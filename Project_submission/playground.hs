-- Refer to playground crowdfunding and vesting examples for functions that help


{-# LANGUAGE OverloadedStrings #-}
module Playground where

-- import           Language.Marlowe

type InvestingSchema =
        Endpoint "deposit funds" Deposit
        .\/ Endpoint "retrieve funds" Value

-- | 
newtype Deposit = Deposit {
    depositOwner   :: PaymentPubKeyHash,
    depositAmount :: Value
    } deriving Generic

PlutusTx.makeLift ''DepositTranche

-- | A deposit scheme consisting of two tranches. Each tranche defines a date
--   (POSIX time) after which an additional amount can be spent.
data DepositParams = DepositParams {
    depositTranchecurrent :: DepositTranche,
    depositTranchenew     :: DepositTranche,
    depositOwner          :: PaymentPubKeyHash
    } deriving Generic


{-# INLINABLE totalAmount #-}
-- | The total amount deposited
totalAmount :: VestingParams -> Value
totalAmount VestingParams{vestingTranche1,vestingTranche2,..} =
    vestingTrancheAmount vestingTranchecurrent + vestingTrancheAmount vestingTranchenew

{-# INLINABLE availableFrom #-}
-- | The amount guaranteed to be available from a given tranche in a given time range.
availableAmount :: VestingTranche -> POSIXTimeRange -> Value
availableAmount (VestingTranche d v) range =
    -- The valid range is an open-ended range starting from the tranche vesting date
    let totalamount = totalAmount .from d
    -- If the valid range completely contains the argument range (meaning in particular
    -- that the start time of the argument range is after the tranche vesting date), then
    -- the money in the tranche is available, otherwise nothing is available.
    in if validRange `Interval.contains` range then v else zero

utxo <- watchAddressUntilTime (Scripts.validatorAddress inst) (campaignCollectionDeadline cmp)
-- 'utxo' is the set of unspent outputs at the campaign address at the
-- collection deadline. If 'utxo' still contains our own contribution
-- then we can claim a refund.

availableAt :: VestingParams -> POSIXTime -> Value
availableAt VestingParams{vestingTranche1, vestingTranche2} sl =
    let f VestingTranche{vestingTrancheDate, vestingTrancheAmount} =
            if sl >= vestingTrancheDate then vestingTrancheAmount else mempty
    in foldMap f [vestingTranche1, vestingTranche2]

{-# INLINABLE remainingFrom #-}
-- | The amount that has not been released from this tranche yet
remainingFrom :: VestingTranche -> POSIXTimeRange -> Value
remainingFrom t@VestingTranche{vestingTrancheAmount} range =
    vestingTrancheAmount - availableFrom t range

{-# INLINABLE validate #-}
validate :: VestingParams -> () -> () -> ScriptContext -> Bool
validate VestingParams{vestingTranche1, vestingTranche2, vestingOwner} () () ctx@ScriptContext{scriptContextTxInfo=txInfo@TxInfo{txInfoValidRange}} =
    let
        remainingActual  = Validation.valueLockedBy txInfo (Validation.ownHash ctx)

        remainingExpected =
            remainingFrom vestingTranche1 txInfoValidRange
            + remainingFrom vestingTranche2 txInfoValidRange

    in remainingActual `Value.geq` remainingExpected
            -- The policy encoded in this contract
            -- is "vestingOwner can do with the funds what they want" (as opposed
            -- to "the funds must be paid to vestingOwner"). This is enforcey by
            -- the following condition:
            && Validation.txSignedBy txInfo (unPaymentPubKeyHash vestingOwner)
            -- That way the recipient of the funds can pay them to whatever address they
            -- please, potentially saving one transaction.

data Vesting
instance Scripts.ValidatorTypes Vesting where
    type instance RedeemerType Vesting = ()
    type instance DatumType Vesting = ()

vestingScript :: VestingParams -> Validator
vestingScript = Scripts.validatorScript . typedValidator

typedValidator :: VestingParams -> Scripts.TypedValidator Vesting
typedValidator = Scripts.mkTypedValidatorParam @Vesting
    $$(PlutusTx.compile [|| validate ||])
    $$(PlutusTx.compile [|| wrap ||])
    where
        wrap = Scripts.wrapValidator

contractAddress :: VestingParams -> Ledger.Address
contractAddress = Scripts.validatorAddress . typedValidator

vestingContract :: VestingParams -> Contract () VestingSchema T.Text ()
vestingContract vesting = selectList [vest, retrieve]
  where
    vest = endpoint @"vest funds" $ \_ -> vestFundsC vesting
    retrieve = endpoint @"retrieve funds" $ \payment -> do
        liveness <- retrieveFundsC vesting payment
        case liveness of
            Alive -> awaitPromise retrieve
            Dead  -> pure ()

payIntoContract :: Value -> TxConstraints () ()
payIntoContract = mustPayToTheScript ()

vestFundsC :: VestingParams -> Contract () s T.Text ()
vestFundsC vesting = do
    let txn = payIntoContract (totalAmount vesting)
    mkTxConstraints (Constraints.typedValidatorLookups $ typedValidator vesting) txn
      >>= void . submitUnbalancedTx . Constraints.adjustUnbalancedTx

data Liveness = Alive | Dead

depositsFrom :: [DepositParams] -> DepositTranche -> Value 
depositsFrom [depositParams] = totalAmount (filter depositParams. -> depositTranchecurrent -> b) b (t a)

retrieveFundsC :: VestingParams -> Value -> Contract () s T.Text Liveness
retrieveFundsC vesting payment = do
    let inst = typedValidator vesting
        addr = Scripts.validatorAddress inst
    nextTime <- awaitTime 0
    unspentOutputs <- depositsFrom addr
    let
        currentlyLocked = foldMap (view Tx.ciTxOutValue) (Map.elems unspentOutputs)
        remainingValue = currentlyLocked - payment
        mustRemainLocked = totalAmount vesting - availableAt vesting nextTime
        maxPayment = currentlyLocked - mustRemainLocked

    when (remainingValue `Value.lt` mustRemainLocked)
        $ throwError
        $ T.unwords
            [ "Cannot take out"
            , T.pack (show payment) `T.append` "."
            , "The maximum is"
            , T.pack (show maxPayment) `T.append` "."
            , "At least"
            , T.pack (show mustRemainLocked)
            , "must remain locked by the script."
            ]

    let liveness = if remainingValue `Value.gt` mempty then Alive else Dead
        remainingOutputs = case liveness of
                            Alive -> payIntoContract remainingValue
                            Dead  -> mempty
        txn = Typed.collectFromScript unspentOutputs ()
                <> remainingOutputs
                <> mustValidateIn (Interval.from nextTime)
                <> mustBeSignedBy (vestingOwner vesting)
                -- we don't need to add a pubkey output for 'vestingOwner' here
                -- because this will be done by the wallet when it balances the
                -- transaction.
    mkTxConstraints (Constraints.typedValidatorLookups inst
                  <> Constraints.unspentOutputs unspentOutputs) txn
      >>= void . submitUnbalancedTx . Constraints.adjustUnbalancedTx
    return liveness

endpoints :: Contract () VestingSchema T.Text ()
endpoints = vestingContract vestingParams
  where
    vestingOwner = mockWalletPaymentPubKeyHash w1
    vestingParams =
        VestingParams {vestingTranche1, vestingTranche2, vestingOwner}
    vestingTranche1 =
        VestingTranche
            {vestingTrancheDate = TimeSlot.scSlotZeroTime def + 20000, vestingTrancheAmount = Ada.lovelaceValueOf 50_000_000}
    vestingTranche2 =
        VestingTranche
            {vestingTrancheDate = TimeSlot.scSlotZeroTime def + 40000, vestingTrancheAmount = Ada.lovelaceValueOf 30_000_000}

mkSchemaDefinitions ''VestingSchema

$(mkKnownCurrencies [])




data Event
  = TickEvent
  | KeyEvent Char
  deriving Show

type Size       = (Int, Int)
type Time       = Int
data Config     = Config {
    screenSize   :: Size,
    headChar     :: Char,
    bodyChar     :: Char,
    foodChar     :: Char,
    tickRate     :: Time,
    blinkRate    :: Time
  } deriving Show

type Point      = (Int, Int)
newtype Snake   = Snake { getSnake :: [Point] } deriving Show
newtype Food    = Food { getFood :: Point } deriving Show
type Direction  = String
type Score      = Int
data Game       = Game {
    snake      :: Snake,
    food       :: Food,
    direction  :: Direction,
    score      :: Int
  } deriving Show

main :: IO ()
main = printJSON $ contract party treasury amount action

data Party = Party {Name :: String, Id :: Int} 
data Action = Deposit Int | Withdrawal Int deriving Show 
data Contract = 

type Value      = Int   
type Name       = Name {FirstN :: String, LastN :: String}
type Id         = Id :: Int 

someaction :: IO ()
someaction = do
    | Action == deposit    = putStrLn "How much do you want to deposit?"
    | Action == withdrawal = putStrLn "How much do you want to withdrawal?"
    
-- Deposit ADA from giver, calculate new percentage of total balance, add that percentage
-- to the existing metadata parameter for percentage per giver, set metadata of new eutxo with total percentage per giver
-- Action is either deposit or withdrawal
--Amount is the amount either deposited or withdrawn
contract :: Party -> Party -> Value -> Action -> Contract
contract party treasury amount action = 
 | action == "deposit"    = deposit party amount
 | action == "withdrawal" = withdrawal 
    when
        [deposit party]
        amount
        Close
    where
        pay :: Contract
        pay =
            Pay 
                giver1
                (Party reciever)
                ada 
                amount
                (Pay
                    giver2 
                    (Party reciever)
                    ada 
                    Close
                )

        -- deposit :: Party -> Action 
        -- deposit p = Deposit name amount ada $ ConstantParam "Deposit"

        deposit :: Party -> Int -> Action 
        deposit party amount = Deposit (percentage amount total perc got) party ada 
                                where
                                    got = "`+`"

        withdrawal :: Party -> Value -> Action 
        withdrawal party amount = Withdraw (percentage amount total perc got) party ada 
                                where
                                    got = "`-`"
 
        --Need to find actual value that provides the get of a parameter in metadata, or alternatively grabbing the eutxo and evaluating the current deposit value and compare it to total
        perc :: Int
        perc = Plutus.UTXO.metadata {filter PercentageOfOwnership}

        -- Need actual value that provides the total amount of ADA in treasury wallet, treasury wallet will need to be static in the contract
        total :: Value
        total = Plutus.Wallet.Total treasury
                where
                    treasury :: Party
                    treasury = 

        percentage :: Value -> Value -> Int -> "Function == got" -> Int 
        percentage amnt total perc got = div amnt total got perc
        


-- What is the right way to get a wallets total amount of ADA?
--What is the right way to get the value of a parameter in metadata?
--What is the right way to write a new value to the metadata of the contract?
--
