--Pattern matching
isDG :: Integer -> Bool
isDG age = age >= 18 

--Case variable of
isDC :: Int -> String
isDC age =
  case age >= 18 of
    True  -> "Welcome In!"
    False -> "Get a fake ID first"

--pattern matching with guard
pattern :: Int -> String
pattern 0 = "zero"
pattern 1 = "hero"
pattern n  
  | n > 1 = "Too many here"

--Tuples containg horizontal vertical time
myTupl :: (Int,Int,Int) -> String
myTupl (hor,ver,time)
  | hor > 0 && ver > 0 && time > 0 = "This lands in the top right corner in the future"
  | hor > 0 && ver > 0 && time < 0 = "This landed in the top right corner in the past"
  | hor < 0 && ver > 0 && time < 0 = "This landed in the top left corner in the past"
  | hor < 0 && ver > 0 && time > 0 = "This lands in the top left corner in the future"
  | otherwise                      = "You did not cross the x or y axis and time does not matter"

