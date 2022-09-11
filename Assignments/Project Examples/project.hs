-- import Main (PingPongState(Stopped))

{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DerivingStrategies    #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE LambdaCase            #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeApplications      #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE ViewPatterns          #-}
{-# OPTIONS_GHC -fno-ignore-interface-pragmas #-}
-- {-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:debug-context #-}
-- | A state machine with two states and two roles that take turns.
module PingPong(
    PingPongState(..),
    Input(..),
    PingPongError(..),
    PingPongSchema,
    runPing,
    runPong,
    ping,
    pong,
    initialise,
    runStop,
    runWaitForUpdate,
    combined,
    simplePingPong,
    simplePingPongAuto
    ) where

import Control.Lens
import Control.Monad (forever, void)
import Data.Aeson (FromJSON, ToJSON)
import Data.Monoid (Last (..))
import GHC.Generics (Generic)
import qualified Ledger.Ada as Ada
import Ledger.Constraints (TxConstraints)
import qualified Ledger.Typed.Scripts as Scripts
import Ledger.Typed.Tx (TypedScriptTxOut (..))
import qualified PlutusTx 
import PlutusTx.Prelude hiding (Applicative (..), check)

import Plutus.Contract
import Plutus.Contract.StateMachine (AsSMContractError (..), OnChainState, State (..), Void)
import qualified Plutus.Contract.StateMachine as SM
import Prelude

import GHC.Stack (HasCallStack)
import qualified GHC.Show as Haskell
import qualified Data.Eq as Haskell
import qualified GHC.Show as Haskell

data PingPongState = Pinged | Ponged | Stopped
    deriving stock (Haskell.Show, Haskell.Eq, Generic)

instance Eq PingPongState where
    Pinged == Pinged = True
    Ponged == Ponged = True
    _      == _      = False

data Action = Ping | Pong | Stop
    deriving stock (Haskell.Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

type PingPongSchema =
    Endpoint "initialize" ()
    .\/ Endpoint "ping" ()
    .\/ Endpoint "pong" ()
    .\/ Endpoint "stop" ()
    .\/ Endpoint "wait" ()

data PingPongError =
    PingPonContractError PingPonContractError
    | PingPongSMError SM.SMContractError
    | StoppedUnexpectedly
    deriving stock (Haskell.Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

makeClassyPrisms ''PingPongError

instance AsSMContractError PingPongError where
    _SMContractError = _PingPongContractError

transition :: State PingPongState -> Action -> Maybe (TxConstraints Void Void, State PingPongState)
transition State{stateData=oldData,stateValue} input = case (oldData, input) of
    (_,      Stop) -> Just (mempty, State{stateData=Stopped, stateValue=mempty})
    (Pinged, Pong) -> Just (mempty, State{stateData=Ponged, stateValue})
    (Ponged, Ping) -> Just (mempty, State{stateData=Pinged, stateValue})
    _              -> Nothing

{-# INLINABLE machine #-}
machine :: SM.StateMachine PingPongState Input
machine = SM.mkStateMachine Nothing transition isFinal where
    isFinal Stopped = True
    isFinal _       = False

{-# INLINABLE mkValidator #-}
mkValidator :: Scripts.ValidatorType (SM.StateMachine PingPongState Input)
mkValidator = SM.mkValidator machine

typedValidator :: Scripts.TypedValidator (SM.StateMachine PingPongState Input)
typedValidator = Scripts.mkTypedValidator @(SM.StateMachine PingPongState Input)
    $$(PlutusTx.compile [|| mkValidator ||])
    $$(PlutusTx.compile [|| wrap ||])
    where
        wrap = Scripts.mkUntypedValidator @PingPongState @Input

machineInstance :: SM.StateMachineInstance PingPongState Input
machineInstance = SM.StateMachineInstance machine typedValidator

client :: SM.StateMachineClient PingPongState Input
client = SM.mkStateMachineClient machineInstance

initialise :: forall w. Promise w PingPongSchema PingPongError ()
initialise = endpoint @"initialise" $ \() -> void $ SM.runInitialise client Pinged (Ada.lovelaceValueOf 1)


run ::
    forall w.
    PingPongState
    -> Promise w PingPongSchema PingPongError ()
    -> Contract w PingPongSchema PingPongError ()
run expectedState action = do
    let extractState = tyTxOutData . SM.ocsTxOut
        go Nothing = throwError StoppedUnexpectedly
        go (Just currentState)
            | extractState currentState == expectedState = awaitPromise action
            | otherwise = runWaitForUpdate >>= go
    maybeState <- SM.getOnChainState client
    let datum = fmap fst maybeState
    go datum

runPing :: forall w. Contract w PingPongSchema PingPongError ()
runPing = run Ponged ping

ping :: forall w. Promise w PingPongSchema PingPongError ()
ping = endpoint @"ping" $ \() -> void (SM.runStep client Ping)

runPong :: forall w. Contract w PingPongSchema PingPongError ()
runPong = run Pinged pong

pong :: forall w. Promise w PingPongSchema PingPongError ()
pong = endpoint @"pong" $ \() -> void (SM.runStep client Pong)

runStop :: forall w. Promise w PingPongSchema PingPongError ()
runStop = endpoint @"stop" $ \() -> void (SM.runStep client Stop)

runWaitForUpdate :: forall w. Contract w PingPongSchema PingPongError (Maybe (OnChainState PingPongState Input))
runWaitForUpdate = SM.waitForUpdate client


combined :: Contract (Last PingPongState) PingPongSchema PingPongError ()
combined = forever (selectList [initialise, ping, pong, runStop, wait]) where
    wait = endpoint @"wait" $ \() -> do
        logInfo @Haskell.String "runWaitForUpdate"
        newState <- runWaitForUpdate
        case newState of
            Nothing -> logWarn @Haskell.String "runWaitForUpdate: Nothing"
            Just SM.OnChainState{SM.ocsTxOut=TypedScriptTxOut{tyTxOutData=s}} -> do
                logInfo $ "new state: " <> Haskell.show s
                tell (Last $ Just s)

simplePingPongAuto :: Contract (Last PingPongState) PingPongSchema PingPongError ()
simplePingPongAuto = do
  logInfo @Haskell.String "Initialising PingPongAuto"
  void $ (SM.runInitialise client Pinged (Ada.lovelaceValueOf 2))
  logInfo @Haskell.String "Waiting for PONG"
  awaitPromise pong
  logInfo @Haskell.String "Waiting for PING"
  awaitPromise ping
  logInfo @Haskell.String "Waiting for PONG"
  awaitPromise pong

simplePingPong :: Contract (Last PingPongState) PingPongSchema PingPongError ()
simplePingPong =
  awaitPromise initialise
  >> awaitPromise pong
  >> awaitPromise ping
  >> awaitPromise pong

PlutusTx.unstableMakeIsData ''PingPongState
PlutusTx.makeLift ''PingPongState
PlutusTx.unstableMakeIsData ''Input
PlutusTx.makeLift ''Input