mrRecursion :: [Int] -> Int
mrRecursion [] = 0
mrRecursion x = head x + mrRecursion (tail x)

-- 1. Analyze the problem
-- 2. Is that the smallest form it can be?
-- 3. Consider input outputs
-- 4. consider the process (choose your algorithm)
--  if recursion consider the base case

-- Factorial will multiply all numbers up to given input
-- n = (*) 1 - n
-- n!
-- input :: Int // output :: Int
--recursion: base case is when input = 0 (traversion from n to 0)


factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)