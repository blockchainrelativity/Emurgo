module Monoids where
import Data.Monoid
import Data.Char

-- Binary operation ( a -> a ) that operates on the same type and output of the same type with an identity (a value that doesnt change nothing).   0, * 1, ++ []     a -> a -> a


-- fun :: Char -> Bool

--isBraille :: Char -> Bool
--isBraille = undefined

--isEmoji :: Char -> Bool
--isEmoji = undefined


--ifForbidden :: (Char -> Bool) -> (Char -> Bool) -> Char -> Bool --Char -> Bool
--ifForbidde c = undefined
--   where predicates = [isBraille,isEmoji,isLink,isImage,isLower,isDigit]

-- ifForbiden = mappend (All . isLower) (All . isDigit)
-- isLower' :: Char -> Any 
-- isLower' = some magic happen nere

predicates = [isLower, isDigit]
ifForbidden []     = mempty 
ifForbidden (x:xs) = mappend (Any . x) (ifForbidden xs)  


--Any . isLower  :: (Bool -> Any) -> (Char -> Bool) -> Char -> Any
-- a -> a -> a
-- 0  1 + 2                = 3
-- "" "Roberto " + "Cerrud" = "Roberto Cerrud"
-- 0  1.1 + 2.2             = 3.3


 