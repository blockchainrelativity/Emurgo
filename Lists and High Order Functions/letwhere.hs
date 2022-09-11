addPwr2 n = 2 + pwr2
  where pwr2 = n^2

addPwr2' n = let pwr2 = n^2 
             in 2 + pwr2 

{-
Foldable t => (a -> b -> c) -> b -> t a -> break

foldr
fun :: [SomeType] -> someResult
fun []     = ...
fun (x:xs) = Do something with x and recursively call (fun xs) 

-}

map' :: (a -> b) -> [a] -> [b]
map' f lst = foldr (\x xs -> (f x):xs) [] lst

--currying of the inputs would look like this
map'' :: (a -> b) -> [a] -> [b]
map'' f = foldr (\x xs -> (f x):xs) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' f lst = foldr (\x xs -> if (f x) then (x:xs) else xs) [] lst

sum' :: [Int] -> Int
sum' lst = foldr (\x xs -> x + xs) 0 lst

--Foldr without foldr 
-- sum (x:xs) = x + sum xs
