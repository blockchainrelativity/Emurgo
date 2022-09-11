module CCValidation where

-- ccNumbers = [4,5,5,6,7,3,7,5,8,6,8,9,9,8,5,5]

-- 1.0 Obtain the last number as the check digit
checkDigit :: [Int] -> Int
checkDigit x = last x 

-- 2.0 - Obtain all elements except the last
firstElems :: [Int] -> [Int]
firstElems x = init x

-- 3.0 Reverse the list of numbers
reverseList :: [Int] -> [Int]
reverseList [] = []
reverseList(head:tail) =  reverseList(tail) ++ [head]


-- 4.0 Only double each odd index number
doubleEachOddIndex :: [Int] -> [Int]
doubleEachOddIndex [] = []
doubleEachOddIndex (x:[]) = [2*x]
doubleEachOddIndex (x:y:xs) = (2*x) : (y) : doubleEachOddIndex xs


-- 5.0 - Subtract 9 from the list if greater than 9 reduce to single digits. 
reduction :: [Int] -> [Int]
reduction [] = []
reduction (x:xs)
  | x > 9 = (x - 9) : reduction xs
  | otherwise = x : reduction xs


-- 6.0 - Aggregate all numbers togther for a grand total
sumOfAll :: [Int] -> Int
sumOfAll [] = 0
sumOfAll (x:xs) = x + sumOfAll xs

-- 7.0 Validate funtion to check any Credit Card Number
validate :: [Int] -> Bool
validate x =
  if ((sumOfAll (reduction (doubleEachOddIndex (reverseList(firstElems x)))) + checkDigit(x)) `mod` 10 == 0) then True else False






-- My copy of notes below
--credit card exercise using
validate :: Int -> Bool
validate 

--convert Int -> [Int] split numbers to digits
ccnum :: Int -> [Int]
ccnum x = x 


--Take last number from list of numbers away
takeLast ::[Int] -> ([Int],Int)


--Reverse the numbers
revNums :: [Int] -> [Int]


--Double all odd digits
doubleNums :: [Int] -> [Int]


--Reduce to a single digits subtract 9
roundNums :: [Int] -> [Int]
roundNums doubleNums

--Sum of all Ints
sumAll :: [Int] -> Int
sumAll roundNums (doubleNums (revNums takeLast))

--Checksum
chckSum :: 
chckSum sumAll 