module Mood where

import Data.Int

data MyBooleanIsBetter = Afirmative | Negative deriving Show

comparison :: Bool -> MyBooleanIsBetter 
comparison x 
 | x == True = Afirmative 
 | x == False = Negative

data Mood = Extatic | Elated | Happy | SoSo deriving Show

changeMood :: Int -> Mood 
changeMood n 
 | n <= 0 = Extatic 
 | n == 1 = Elated 
 | n == 2 = Happy 
 | otherwise = SoSo