module PowerWeightRatio where

data Car = Car
    { name   :: String
    , weight :: (Float,Char)
    , power  :: (Float,Char)
    } deriving Show

convweight :: (Float,Char) -> Float
convweight (x,'p') = x
convweight (x,'k') = x / 0.45359237
convweight (_,_) = 0

convpower :: (Float,Char) -> Float
convpower (x,'H') = x
convpower (x,'W') = x / 745.699872
convpower (_,_) = 0

pwr2w :: (Float,Char) -> (Float,Char) -> Float
pwr2w weight power = convpower power / convweight weight

race :: Car -> Car -> String 
race (Car carA wtA pwA) (Car carB wtB pwB) 
 | pwr2w wtA pwA > pwr2w wtB pwB = carA ++ ", you are the winnner!!!" 
 | pwr2w wtA pwA < pwr2w wtB pwB = carB ++ ", you are the winnner!!!" 


tesla = Car {name = "Tesla", weight = (4766,'p'), power = (760613.86944,'W')}

golf = Car {name = "Golf cart", weight = (400,'p'), power = (10,'H')}

charger = Car {name = "Dodge Charger", weight = (4280,'p'), power = (840,'H')}

{-
PWR (hp/lb) = P (hp) / WT (lb)

PWR (W/kg) = P (W) / WT (kg)
-}

-- data Weight = Pounds (Float,'p') | Kilograms (Float,'k')
-- class Weight a where
--     Weight :: (Float,Char) -> Float