myMod :: Int -> Int -> Int
myMod x y = x `mod` y 

isEven :: Int -> Bool
isEven x y = myMod (add x y) 2 == 0  

add :: Int -> Int -> Int
add x y = x + y

myMod2 :: Integer -> Integer -> Integer
myMod2 x y = x `mod` y 

isEven2 :: Integer -> Bool
isEven2 x y = myMod2 (add2 x y) 2 == 0  

add2 :: Integer -> Integer -> Integer
add2 x y = x + y

x :: Int
x=2

y :: Integer
y=3

z :: Float
z=2.5

a :: Double
a=33.3333333333333

b :: Char
b='R'

c :: String
c="Relativity"

d :: [Char]
d="Relativity"

e=10
f=11.11
g='o'

h :: Bool
h=False

j :: Bool
j=True

w :: Word
w=10