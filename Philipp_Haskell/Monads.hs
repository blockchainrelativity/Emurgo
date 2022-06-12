-- Left identity
return a >>= k = k a

--Right Identity
m >>= return = m

--Associative
m >>= (\x -> k x >>= h) = (m >>= k) >>= h

--Used to bind, this provides the interal type of the value in the Monad being called
>>= 

--Used to unbind,     
>>

--Used to return the monad of that value. Example: ma -> a -> return a = ma
return 
-- instance Monad Maybe where
    -- m >>= f = case m of 
    --             Nothing -> Nothing
    --             Just x -> f x
    -- return v = Just v

--Used to return the failed state or error message in the Monad. So instead of just a string error message it returns the monad version of the error so your code can utilize it
fail