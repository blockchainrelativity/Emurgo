
odds n = map f [0..n-1]
            where
                f x  = x*2 + 1

odds' n = map (\x -> x*2 + 1) [0..n-1]                

safetail xs = if null xs 
               then []
                else tail xs

safetail' xs 
  | null xs = []
  | otherwise = tail xs

safetail'' [] = []
safetail'' (_:xs) = xs