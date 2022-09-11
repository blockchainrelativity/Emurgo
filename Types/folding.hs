--create a foldl function that will always want to start with the first element of the list. foldl you are prepending each element to the next argument.
-- rev : [a] -> [a]
-- rev = foldl (\acc elem -> elem : elems) []

--foldr is resolving the last 

--function that returns all prefixes of a given list. 
prefixes :: [a] -> [[a]]
prefixes = foldr (\x acc -> [x] : (map ((:) x) acc)) []  

lagrange :: [(Float, Float)] -> Float -> Float
lagrange xs x =
  foldl (\acc (xj,y) -> acc + (y * l xj)) 0 xs
  where
    l xj = foldl (\acc (xk, _) -> 
      if xj == xk then acc
       else acc * ((x-xk)/(xj-xk))) 1 xs


--exercise in tree to guess a word 
data Tree a = Leaf a | Node a [Tree a] deriving Show
t =
 Node 'c' [
  Node 'a' 
  [Leaf 'r', 
   Leaf 't',
   Node 'n'
   [Leaf 't']],
  Node 'o'
  [Node 'o'
   [Leaf 'l']]]

foldtree :: (b -> a -> b) -> b -> Tree a -> b
foldtree f acc (Leaf x) = f acc x
foldtree f acc (Node x xs) = foldl f' (f acc x) xs
  where
   f' acc t = foldtree f acc t 

