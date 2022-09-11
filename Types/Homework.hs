-- homework :: Int -> Int --deriving (Show)
-- homework x = 3 ^ 2

task :: Float -> Float -> Float
task dividend divisor = dividend / divisor

task1 :: Fractional a => a -> a -> a
task1 dividend divisor = dividend / divisor

-- x=[1,2,3,4,5,6,7,8,9,10]
-- y=1:2:3:4:5:6:7:8:9:10 

-- x == y
-- y == x
-- x /= y

-- g=1
-- h=2
-- i=100

-- g:h:i:g:h:i:[]

-- x + y

-- x=[1..11]
-- y=[10..100]
-- x
-- y

fb1 :: Int -> Int -> Int
fb1 a b = a - b

fb2 :: Int -> Int -> Int
fb2 a b = b - a

fb3 :: Int -> Int -> Int
fb3 a b = a ^ b

fb4 :: Int -> Int -> Int -> Int
fb4 a b c = a + b + c

fb4 :: String -> String -> String -> String -> [String]
fb4 a b c d = a:b:c:d:[]

fb5 :: Num a => a -> a -> a -> a -> a -> [a]
fb5 a b c d e = a:b:c:d:e:[] 

