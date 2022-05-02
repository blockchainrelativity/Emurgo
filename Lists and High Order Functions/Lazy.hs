module Laziness where

all' :: (a -> Bool) -> [a] -> Bool
all' p [] = False
all' p (x:xs) 
 | p x       = all' p xs
 | otherwise = False