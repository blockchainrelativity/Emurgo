module OurGame where
 --import Graphics.Gloss
 --import System.Random

 data State a = Var Int a (State a) 
              | EmptyState 
              deriving (Show,Eq)

 set :: (State a) -> Int -> a -> (State a)
 set EmptyState v   x   = (Var v x EmptyState)
 set (Var v x rs) v' x'
   | (v == v')          = (Var v x' rs)
   | otherwise          = (Var v x (set rs v' x'))

 get :: (State Int) -> Int -> Int
 get EmptyState x          = -1
 get (Var k x rs) k'       
   | k == k'               = x
   | otherwise             = get rs k'

 increment1 :: (State Int) -> Int -> (State Int)
 increment1 s x = set s x (oldx + 1)
     where oldx = get s x