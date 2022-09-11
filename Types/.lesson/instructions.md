# START HERE

module Scripts where

data MyBooleanIsBetter = Afirmative | Negative deriving Show

comparison :: Bool -> MyBooleanIsBetter
comparison x
 | x == True   = Afirmative
 | x == False  = Negative


data Mood = Extatic | Elated | Happy | SoSo deriving Show

changeMood :: Int -> Mood
changeMood n
 | n <= 0     = Extatic
 | n == 1     = Elated
 | n == 2     = Happy
 | otherwise  = SoSo

# STOP HERE


# Previous Sessions Code by Topic 

  ## 
  1. 
  2. 
  3. 

  Use [Markdown](https://gist.github.com/cuonggt/9b7d08a597b167299f0d) to format your instructions.

  For example, here is a code block in python3
```python
def hello_world():
  print("hello world!")
```


  Include an image by placing it in the `assets` folder.

  For example, here is the Replit logo:

  ![alt text](assets/logo.png)
  
  