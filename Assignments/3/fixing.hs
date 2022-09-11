module Fixing where

--Data Types
 fixMe1 :: Int -> Int -> Bool   
 fixMe1 n m 
  | n >= m    = True
  | otherwise = True


 fixMe2 :: Float -> Float -> String     
 fixMe2 n m = if n / m > 10  then "A-F" else "0-9"

 abc :: [Int]
 abc = [1..11]

 fixMe3 :: [Int] -> Int
 fixMe3 [] = 0
 fixMe3 (x:xs) = x + fixMe3 xs


 fixMe4 ::  [Char] -> [Char] -> String
 fixMe4 fName lName = lName ++ ", " ++ fName

 -- Recursion and Polymorphism
 scoresT :: Fractional a => [a]
 scoresT = [74,85,81,98,69.99,78,87,93]

 myDlength :: Fractional a => [a] -> a
 myDlength [] = 0
 myDlength (x:xs) = 1 + myDlength (xs)  

 fixMe5 :: (Ord a,Fractional a) => ([a] -> a) -> ([a] -> a) -> [a] -> Char
 fixMe5 myOper myLen lst 
  | (myOper lst)/(myLen lst)  > 90.99   = 'A'
  | (myOper lst)/(myLen lst)  > 80.99   = 'B'
  | (myOper lst)/(myLen lst)  > 70.99   = 'C' 
  | otherwise                           = 'F'

 data Charlist = Empty | Cons Char [Char] deriving Show

 -- beginsWith :: Char -> Charlist -> Bool
 -- beginsWith []            = False
 -- beginsWith c (Cons x xs) = c == x

 foundLetters :: String -> Char -> Int
 foundLetters [] _    = 0
 foundLetters (x:xs) c
  | x == c    = (foundLetters xs c) + 1
  | otherwise = (foundLetters xs c) + 0


 --  -- | (beginsWith (x:list)) char == x = n + 1

 all' :: (a -> Bool) -> [a] -> Bool
 all' p []     = True
 all' p [x]    = p x
 all' p (x:xs)
  | p x       = all' p xs
  | otherwise = False

 phrase' :: String -> [String]
 phrase' = words
 phrase = "This is the end as we know it but I feel fine"
 
 -- need2know :: (String -> Char -> Int) -> Bool
 -- need2know phrase' p c = all' p $ foundLetters (phrase' phrase) c