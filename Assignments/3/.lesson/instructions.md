This aims to help you test your basic types, recursion and polymorphism knowledge.
   
  ## Problems
  1. ** Fix the Type:**
     
     The following declarations got type mistakes, debug them and fix them:


     
    fixMe1 :: Int -> Integer -> Bool   
    fixMe1 n m 
     | n >= m    = True
     | otherwise = True

    fixMe2 :: Float -> Double -> String     
    fixMe2 n m = if n / m > 10  then "A-F" else "0-9"

    abc = [1..11]
    fixMe3 :: [Int] -> Int
    fixMe3 [] = 0
    fixMe3 (x:xs) = x + fixMe3 xs

  _Try **fixMe3 abc** in your repl, then fix abc type definition_

    fixMe4 ::  Char -> [Char] -> String     
    fixMe4 fName lName = lName ++ ", " ++ fName

    fixMe5 :: (Ord a,Fractional a) => [a] -> a -> [a] -> a -> [a] -> Char
    fixMe5 myOper myLen lst 
     | (myOper lst)/(myLen lst)  > 90.99   = 'A'
     | (myOper lst)/(myLen lst)  > 80.99   = 'B'
     | (myOper lst)/(myLen lst)  > 70.99   = 'C' 
     | otherwise                           = 'F' 

  _Test it on your repl:
   **fixMe5 sum myDlength scoresT**_

  2. **Give the following recursive function, define the base case**

       
    beginsWith :: Char -> String -> Bool
    
    beginsWith 
    
    beingsWith c (x:xs)   = c == x


  
  3. **Given a Word and a letter (case sensitive), create function that count the number of times that letter shows up in the word**


     
  

