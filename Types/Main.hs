module Damn where

data Sometype = OK | Good | Great | AWESOME deriving Show

functiontype :: Int -> Int -> Sometype
functiontype x y
 | y == 4 && x >= 1 && x < 2  = OK
 | x == 2         = Good
 | x == 3         = Great
 | x == 4         = AWESOME

-- x = 5
