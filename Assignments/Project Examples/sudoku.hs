type Grid = Matrix Value 
type Matrix a = [Row a]
type Row a = [a]
type Value = Char 
type Choices = [Value]
type Collapse = 

easy :: Grid
easy = ["2....1.38",".......5",".7...6..",...]

--Replicate the blank '.' to all rows and columns, replicate is a built in function that just replicates the input element to the specified number of times. So replicate Int a
blank :: Grid
blank =  replicate 9 (replicate 9 '.')

rows :: Matrix a -> [Row a]
--this is how it would be written out 
--rows matrix = matrix 
--and this is using the haskell function that provides identity, shown as
--id x = x
rows = id

--the transpose function takes in the columns and transposes them into rows, so column 1 becomes row 1, column 2 becomes row 2, etc.
columns :: Matrix a -> [Row a]
columns = transpose

boxes :: Matrix a -> [Row a]
boxes = transpose

validator :: Grid -> Bool
validator g = validator' g (rows g) && 
              validator' g (columns g) && 
              validator' g (boxes g) 

noDuplicates :: [Value] -> Bool              
noDuplicates [] = True
noDuplicates (x:xs) = notElem x xs && noDuplicates xs

solve :: Grid -> [Grid]
solve = filter validator . collapse . choices

solve' :: Grid -> [Grid]
solve' = filter validator . collapse . prune . choices

solve'' :: Grid -> [Grid]
solve'' = filter validator . collapse . fix prune . choices
            where 
                fix f x = if x == x' then x else fix f x'
                    where x' = f x

choices :: Grid -> Matrix Choices
choices g = map (map choice) g 
            where
                choice c = if c == '.' then ['1'..'9'] else [c]

collapse :: Matrix [a] -> [Matrix a]
collapse m = cp (map cp m)


cardesianProduct :: [[a]] -> [[a]]
cardesianProduct [] = [[]]
cardesianProduct (xs:xss) = [y:ys | y <- xs, ys <- cardesianProduct xss]

prune :: Matrix Choices -> Matrix Choices
prune = pruneBy boxes . pruneBy columns . pruneBy rows 
        where
            pruneBy f = f . map reduce . f

            reduce :: Row Choices -> Row Choices
            reduce 