module SomeExtras where
import test 
import Debug.Trace

--Maybe data type (Nothing, Just)

safediv :: Integral a => a -> a -> Maybe a
safediv x y = if y == 0 then Nothing else Just (div x y)

-- fromJust :: Maybe a -> a


-- Either Left or Right
funX :: Int -> String -> Either Int String
funX num word
 | num == (length word) = Right word
 | otherwise            = Left num
