module Lists where

abc :: [Int]
abc = [1..10]

x2 :: Int -> Int
x2 n = n + 3

x3 :: Int -> Int
xs n = n * 3

-- Prelude> abc = [1..5]
-- Prelude> y = map (+ 10) abc
-- head
-- take
-- zip
-- takeWhile

y = map (x2) abc

arg@(name,age,gender) = ("curtis",37,'M')

naMe :: (name,age,gender) -> name
naMe (nameOf,_,_) = nameOf

aGe :: (name,age,gender) -> age
aGe (_,ageOf,_) = ageOf