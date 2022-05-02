module Main where

-- import TicTacToe

data Player = PlayerX | PlayerO deriving (Eq,Show)
data State = Running | GameOver deriving Show
data Game = Game {gridState  :: GridState
                 ,gamePlayer :: Player
                 ,gameState  :: State
                 ,moves      :: Int
                 } deriving Show

main :: IO ()
main = do
        putStrLn "Choose the starting player (X or O)"
        player <- getChar 
        let start = Game {gridState = initialGrid size size
                         ,gamePlayer = (if player == 'X' then PlayerX else PlayerO)
                         ,gameState = Running
                         ,moves     = 0}
        gameLoop start
        return ()

        -- putStrLn ("You are player " ++ ( if player == 'X' then "Player X" else "Player O"))

gameLoop :: Game -> IO ()
gameLoop game = do 
                putStrLn $ "You are player " ++ if (gamePlayer game) == PlayerX then "X" else "O"
                return ()