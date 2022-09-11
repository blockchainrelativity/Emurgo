module Algebraic where

 data Mood = Scared | Numb | Extatic | Hyper deriving Show

 data Point = Point Double Double deriving Show

 data PointP a = Coordinates a a deriving Show

 data PointA a b = Cord a b | Cardinal a b deriving Show

 moveThePointQ1 :: Fractional a => a -> a -> PointP a
 moveThePointQ1 x y = Coordinates (abs x) (abs y) 

 moveThePointQ1' :: Fractional a => a -> a -> PointA a a
 moveThePointQ1' x y = Cord (abs x) (abs y) 


 stateChange :: Int -> PointP Float -> PointP Float
 stateChange q (Coordinates x y) = if q == 1 then (moveThePointQ1 x y) else (moveThePointQ1 y x)

 change :: Int -> PointA Float Float -> PointA Float Float
 change q (Cord x y)
  | q == 1    = moveThePointQ1' x y
  | otherwise = moveThePointQ1' y x
 change q (Cardinal x y)
  | q == 2    = Cardinal y 0
  | otherwise = Cardinal x 0
