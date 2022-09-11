s :: [Int] -> [Int]
s (x:xs)
 | x > 9 = c x : s xs
 | otherwise = x : s xs