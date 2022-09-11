module Assigment02 where

  {- Absolute value of any number
     Create a function named Absolute that takes a value and return the absolute (the number wihtout the sign) 
     Examples:   Absolute 10  = 10
                 Absolute -10 = 10
                 Absolute -11.11 = 11.11
     
     Create function using if-then, guards and case
  -}               
  
  absoluteI :: Float -> Float
  absoluteI n = if n >= 0 then n else n * (-1)

  absoluteC :: Float -> Float
  absoluteC n =
            case n >= 0 of
                 True  -> n
                 False -> n * (-1)

  absoluteG :: Float -> Float
  absoluteG n  
   | n < 0     = n * (-1)
   | otherwise = n

  absInf :: (Ord a,Num a) => a -> a
  absInf n  
   | n < 0     = n * (-1)
   | otherwise = n

  -- Bonus:  Try to make any of the functions polymorphic, find any problems? can you explain why? Whats the solution?

  {- Celsius to Farenheit or Farenheit to Celsisu Converter 
     Create a function that takes the letters C for converting from Farenheith to Celsius or
     F for converting from Celsis to Farenheit
     The conversion basic formula   (F - 32) x 5/9 = C
  -}

  tempConverter :: Char -> Float -> Float
  tempConverter tu tm 
   | tu == 'C'     = (tm - 32) * 5 / 9
   | tu == 'F'     = (tm * 9 / 5) + 32
   | otherwise     = 0 

  {- Confortable Temperature in Celsius [18C --> 24C] or Farenheit [64.4ºF --> ____ ]
     Create a function that answers "It's too cold!" if temperature below the range of been confortable, 
     or "It's too hot" if its above and "Its comfortable" if its in range.  
     As in previous assigment you should identify input with C for Celsius or F for Farenheiht
  -}

  comfortable :: Char -> Float -> String
  comfortable 'C' tm
   | tm < 18     = "It's too cold!"
   | tm > 24     = "It's too hot"
   | otherwise   = "Its comfortable"
  comfortable 'F' tm
   | tm < 64.4     = "It's too cold!"
   | tm > 75.2     = "It's too hot"
   | otherwise     = "Its comfortable" 
  comfortable _ _ = "You must choose the proper temperature unit (C or F)"
  
  