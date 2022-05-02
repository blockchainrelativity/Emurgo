module Assigment04 where

{- Algebraic Data Types
   LETS PLAY TWISTER Part1 
 
  1. Create  custom data type that for Twister Colors: green, yellow, blue, red (suggestion: tColor)

  2. Create another custom data type that handles body parts: Left Hand, Right Hand, Left Foot, Right Foot (suggestion: tBpart)

  3. Create a function that creates a movement, with inputs player number, body part and color 
     and output a tuple with all the info of the movement
-} 

 data Tcolor = Green | Yellow | Blue | Red deriving Show

 data Tpart = LHand | RHand | LFoot | RFoot deriving Show

 plyrMove :: Int -> Tpart -> Tcolor -> (Int,Tpart,Tcolor)
 plyrMove pnum clr bpart = (pnum,clr,bpart)
 
{-
  4. Given the following code, include the missing type and data constructors. Given that the pieces in chess are:
  Pawn, Bishop, Knight, Rook, Queen and King, and the posible movements are: Forward, Backward, Left, Right and Diagonal
-}

 -- < INSERT MISSING CUSTOM DATA TYPES HERE>

 data Horizontal = LeftM | RightM deriving Show
 data Vertical = Forward | Backward deriving Show
 
 data Pieces = Pawn
             | Bishop
             | Knight
             | Rook
             | Queen
             | King
             deriving Show

 data Moves = MoveH Horizontal 
            | MoveV Vertical 
            | Diagonal Vertical Horizontal 
            | KnightM Vertical 
            | KingRookM Horizontal Horizontal
            deriving Show

 type PlayerMove = (Pieces,Moves,Int,Int)

 playerMovement :: Pieces -> Moves -> Int -> Int -> PlayerMove
 playerMovement piece move spacesH spacesV =(piece,move,spacesH,spacesV)

{-HIGH ORDER FUNCTIONS 

 5.  Create a function all' that takes 2 inputs, 
 (1st input ) a partial function (with operators: >,>=,<,<=,==) and any value
 (2nd input) a list, 
  and output True if all elements of the functions comply, False if any of the elements 
  doesn't, using MAP 

 6. Create anoter version of all', named allF, using FOLDR instead

-}

 all' :: Ord a => (a -> a -> Bool) -> [a] -> Bool
 all' f lst = map (f x) lst
 