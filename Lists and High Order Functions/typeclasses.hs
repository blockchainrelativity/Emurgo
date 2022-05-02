data Temp = C Float | F Float

class Temp a where
    Temp :: a -> Float

instance Eq Temp where
 (==) (C n) (C m) = n == m
 (==) (F n) (F m) = n == m
 (==) (C n) (F m) = (1.8*n + 32) == m
 (==) (F n) (C m) = (1.8*n + 32) == m

instance Num Temp where
 (+) (C n) (C m) = (C n) + (C m)
 (+) (F n) (F m) = (F n) + (F m)
 (+) (C n) (F m) = (C (1.8*n + 32)) + (F m)
 (+) (F n) (C m) = (C (1.8*n + 32)) + (F m)

class Listable a where
      toList :: a -> [Float]

instance Listable Temp where
      toList (C n)  = n:[]

-- Aggregate is a function that aggregates inputs
-- Total Function is a function that works in all circumstances, ex: head is not a total function, but safehead is because it takes into account all possible inputs

