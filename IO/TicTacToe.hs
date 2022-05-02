module TicTacToe where

 import Main

 --data Player = PlayerX | PlayerO deriving (Eq,Show)
 --data Cell = Empty | Filled Player deriving (Eq,Show) 

--1. Explain use of custom data types for Tile State, the state could be Empty, an X or an O

 data CellState = EmptyCell | AnX | AnO deriving (Eq,Show)

--2. Some aliases to avoid repetitive typing and to include readability of outcomes

 type Cell = (Int,Int,CellState)
 type GridState = [[Cell]]


--3. Create initial Grid and GridState 
 size :: Int
 size = 3

 initialGrid :: Int -> Int -> GridState
 initialGrid x y = createListInList x y
   where 
       createListInList :: Int -> Int -> GridState 
       createListInList 0 0  = []
       createListInList _ 0  = []
       createListInList 0 _  = []
       createListInList hL vL 
        | (hL-1) < 0 = [] 
        | otherwise   = if (vL-1) < 0
                         then [] 
                         else (createListInList (hL-1) vL)++[(createInitialRow hL (vL-1)) ++ [((hL),(vL),EmptyCell)]]

       createInitialRow :: Int -> Int -> [Cell] 
       createInitialRow _ 0 = []
       createInitialRow hL vL
        | (vL-1) < 0     = [] 
        | otherwise       = (createInitialRow hL (vL-1)) ++ [(hL,vL,EmptyCell)]

 initialGrid' :: Int -> GridState
 initialGrid' x = createListInList' x x
   where 
       createListInList' :: Int -> Int -> GridState 
       createListInList' 0 0  = []
       createListInList' _ 0  = []
       createListInList' 0 _  = []
       createListInList' hL vL 
        | (hL-1) < 0 = [] 
        | otherwise   = (createListInList' (hL-1) vL) ++ [(createInitialRow' hL vL EmptyCell)]

       createInitialRow' :: Int -> Int -> CellState -> [Cell]
       createInitialRow' h v cS = [(x,y,cell) | x <- [h], y <- [1..v], cell <- [cS]]


 setCellState :: Cell -> GridState -> GridState
 setCellState (h,v,token) pgs = map (\lst -> map (\x -> if isEmptyCell h v x then (h,v,token) else x) lst) pgs

 isEmptyCell :: Int-> Int-> Cell -> Bool
 isEmptyCell x y (h,v,token) = x == h && y == v && token == EmptyCell

 -- 3.1 Single List Data Structure for all the items on the Grid
 createList :: Int -> CellState -> [Cell]
 createList n cS = [(x,y,cell) | x <- [1..n], y <- [1..n], cell <- [cS]]
 
-- createList' :: Int -> Int -> CellState -> [Cell]
-- createList' h v cS = [(x,y,cell) | x <- [h], y <- [1..v], cell <- [cS]]

-- 4. Change state of the GridState 
 changeGridState :: Cell -> GridState -> GridState
 changeGridState _ []              = error "Error from this point forward"
 changeGridState (x,y,cS) grid
  | x > (length grid)              = error "Error outside the grid"
  | otherwise = if y > (length (head grid))
                then error "Error outside of the grid"
                else setCellState (x,y,cS) grid