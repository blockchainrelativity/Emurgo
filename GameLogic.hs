module GameLogic where
 import TicTacToe
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
 anyFullRowWinner :: GridState -> Bool
 anyFullRowWinner [] = False
 anyFullRowWinner (x:xs) = check x || anyFullRowWinner xs
    where
         check []                 = True
         check ((row,_,state):ys)  
          | state /=  EmptyCell   = let z = state == takeNextState ys && check ys
                                    in trace ("State is " ++ show state ++ " and " ++ show (takeNextState ys)) z
          | otherwise             = False
            where
             takeNextState []            = state
             takeNextState ((_,_,sta):_) = sta 

--testing

 step1 = initialGrid size size
 step2 = setCellState (2,1,AnO) step1
 step3 = setCellState (2,2,AnO) step2
 step4 = setCellState (2,3,AnX) step3


 test1 = anyFullRowWinner step1
 test2 = anyFullRowWinner step2
 test3 = anyFullRowWinner step3
 test4 = anyFullRowWinner step4
 --any Empty Cell?
 --Traverse the DataStructure for EmptyCell
 anyEmptyCell :: Game -> Bool
 anyEmptyCell (Game _ _ _ m) 
  | m == size^2    = False
  | otherwise      = True
   
 --gameOverAction
 --Present Winner or Tie


--  data Player = PlayerX | PlayerO deriving (Eq,Show)
--  data State = Running | GameOver deriving Show
--  data Game = Game {gridState :: GridState
--                  ,gamePlayer :: Player
--                  ,gameState :: State
--                  ,moves :: Int
--                  } deriving Show
--  data CellState = EmptyCell | AnX | AnO deriving (Eq,Show)
--  type Cell = (Int,Int,CellState)
