module Functors where

 maybeMap :: (a->b) -> Maybe a -> Maybe b
 maybeMap _ Nothing  = Nothing
 maybeMap f (Just x) = Just (f x)

 data DaList a = DaList [a] | Exit deriving Show

 instance Functor DaList where
  -- fmap _ (DaList [])        = Exit
  -- fmap _ Exit               = Exit
  -- fmap f (DaList (x:xs))    = DaList (f x : xs)

 lst = [DaList [1..10], DaList [11..21]]
 mapping = map aux lst
 
 aux :: (Num a => DaList) -> DaList
 aux (DaList lst) = DaList (map (+2) lst)