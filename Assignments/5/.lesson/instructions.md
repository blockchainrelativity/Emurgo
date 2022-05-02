# Assigment #05
  1. LAMBDAs
     Convert the following functions into lambda expressions:
     isTriplet x y z = x ^ 2 + y ^ 2 == z ^ 2
 

 isTriplet :: Int -> Int -> Int -> Bool
 isTriplet x y z = x^2 + y^2 == z^2



## list concatenation operators, consider this two functions : and ++
(:)     example =>  2 : [1..10]

(++)    example =>  [1..10] ++ [11..22]

## MORE HIGH ORDER FUNCTIONS and ANONYMOUS FUNCTIONS with LAMBDAs
 
  2. Write a function that gives a list with the first number of a list of ints -} 

  3. Create a function that create an acronym
        examples
    Result - Input (List of Strings)
    AIDS - Acquired Immunodeficiency Syndrome. ...
    ASAP - As Soon As Possible. ...
    AWOL - Absent Without Official Leave (or Absent Without Leave) ...
    IMAX - Image Maximum. ...
    LASER - Light Amplification by the Stimulated Emission of Radiation. ...
    PIN - Personal Identification Number. ...
    RADAR - Radio Detection and Ranging.
 
 test = ["Light","Amplification","Stimulated","Emission","Radiation"]  
 asap = ["As","Soon","As","Possible"]
  