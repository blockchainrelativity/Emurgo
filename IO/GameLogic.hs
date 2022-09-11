module GameLogic where
 import TicTacToe
 import Main
 import Debug.Trace 

 --winner?
 --any of the symbols is in winning state?
 --Full Row (any of the 3) | Full Column (any of the 3) | Full Diagonal (any of the 2)
 --Full Rows posibilities (same cellState == AnX OR AnO)
 --{(1,1),(1,2),(1,3)} OR {(2,1),(2,2),(2,3)} OR {(3,1),(3,2),(3,3)}
 -- x <- [1..size], y <- _  
 --Full Collumns posibilities (same cellState == AnX OR AnO)
 --{(1,1),(2,1),(3,1)} OR {(1,2),(2,2),(3,2)} OR {(1,3),(2,3),(3,3)}
 -- x <- _ , y <- [1..size]
 --Full Diagonals posibilities (same cellState == AnX OR AnO)
 --{(1,1),(2,2),(3,3)} OR {(1,3),(2,2),(3,1)}
 -- x <- [1..size], y <- [1..size]  OR x <- [1..size], y [size..1]
 
 --  type GridState = [[Cell]]
 --  data CellState = EmptyCell | AnX | AnO deriving (Eq,Show)
 --  type Cell = (Int,Int,CellState)

-- winning logic
--Traverse the DataStructure for EmptyCell
 fullRowWinner :: GridState -> Bool 
 fullRowWinner (x:xs) =  check x || fullRowWinner xs
    where
      check []                = True
      check ((row,_,state):ys)
        | state /= EmptyCell  = state == takeNextState ys && check ys
        | otherwise           = False
          where
            takeNextState []                  = state
            takeNextState ((_,_,nextstate):_) = nextstate

--Testing

 step1 = initialGrid size size
 step2 = setCellState (2,1,AnX) step1
 step3 = setCellState (2,1,AnX) step2
 step4 = setCellState (2,1,AnX) step3

 test1 = fullRowWinner step1
 test2 = fullRowWinner step2
 test3 = fullRowWinner step3
 test4 = fullRowWinner step4
 
-- is there an empty cell?
 anyEmptyCell :: Game -> Bool
 anyEmptyCell (Game _ _ _ moves)
  | moves == size^2  = False
  | otherwise        = True

-- GameOver action
--Present display winner or Tie

--  data Player = PlayerX | PlayerO deriving (Eq,Show)
--  data State = Running | GameOver deriving Show
--  data Game = Game {gridState :: GridState
--                  ,gamePlayer :: Player
--                  ,gameState :: State
--                  ,moves :: Int
--                  } deriving Show
--  data CellState = EmptyCell | AnX | AnO deriving (Eq,Show)
--  type Cell = (Int,Int,CellState)