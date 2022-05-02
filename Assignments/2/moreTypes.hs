--type synonyms
type MyChar = Char
type Alias = String
type Name = String

changeName :: Name -> Alias
changeName word
  | word == "Curtis" = "Boss"
  | otherwise        = "I dont know what you are talking about"


type Pos = (Int, Int, String)
type StateChange = Pos -> Pos

data Move = North | South | East | West

-- move :: Move -> StateChange
-- move North (x, y, "Up")    = (x, y+1, "Moved North 1 space")
-- move South (x, y, "South") = (x, y-1, "Moved South 1 space")
-- move East (x, y, "East") = (x+1, y, "Moved East 1 space")
-- move West (x, y, "West") = (x-1, y, "Moved West 1 space")

move :: StateChange
move (x, y, t)   
  | t == "North" = (x, y+1, "Moved North 1 space")
  | t == "South" = (x, y-1, "Moved South 1 space")
  | t == "East"  = (x+1, y, "Moved East 1 space")
  | t == "West"  = (x-1, y, "Moved West 1 space")

