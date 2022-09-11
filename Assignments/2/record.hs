type PubKeyHash = String
type CurrencySymbol = String
type TokenName = String
type Redeemer = String
type InputValue = Int

--Record of NFTsales (seller)
data NFTsales = NFTsales 
                { nSeller   :: PubKeyHash
                , nPrice    :: Int
                , nCurrency :: CurrencySymbol
                , nToken    :: TokenName
                } deriving Show

--Datum 
data CustomDatum = CustomDatum
    { num1 :: Int
    , num2 :: Int
    } deriving Show

--Record of buyer
data Buyer = Buyer
      { nRedeemer   :: String
      , nPayment    :: InputValue
      } deriving Show 

--actual sale of NFT
--Need to validate payment is sufficient
-- sale :: NFTsales -> Buyer -> Bool
-- sale seller buyer
--   | nPrice <= nPayment = True
--   | otherwise          = False

data Person = Person 
  { name :: String
  , age :: Int } deriving Show

greet :: Person -> [Char]
greet (Person name _) = "Hi " ++ name

--hello world explained
--store the result of a function as a function
hw = putStrLn "Hello World"
hw :: IO ()

-- script = putStrLn ("Hello " ++ name ++ """!")
greeting :: IO ()
greeting = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn "What is your pet species?"
  pet <- getLine
  putStrLn "What is your desire?"
  desire <- getLine
  putStrLn "What is your age?"
  age <- getLine
  putStrLn oldenough


oldenough :: (String, String, String, Int) -> String
oldenough name pet desire age 
    | age <= 40 && age >= 18 = answer <- ("Hello " ++ name ++ ", you have good taste, I like " ++ desire ++ " too. Say hello to your " ++ pet ++ " for me.")
    | age >= 41              = answer <- ("Hello " ++ name ++ ", aren't you a litte too old for " ++ desire ++ "? Well say hello to your " ++ pet ++ " for me.")
    | otherwise              = answer <- ("Hello " ++ name ++ "Say hello to your " ++ pet ++ " for me.")