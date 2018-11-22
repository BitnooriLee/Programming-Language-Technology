module Examples  where 
import Test.QuickCheck 

exchangeRate :: Double
exchangeRate  =  9.166
toEU s =  s / exchangeRate 
toSEK e = e * exchangeRate 

prop_exchange e =  toEU ( toSEK e) ~== e

n~== m = abs(n - m) < epsilon
                 where epsilon = 10e-13
         
--abs' x = if x < 0 then -x else x

abs' x | x < 0 = -x
           | otherwise = x

--Definition by recursion
power :: Integer -> Integer -> Integer --type of power
power n 0                             = 1
power n k | k > 0                  = n * power n (k-1)
                   | otherwise         = error  "power  on negative arg not supported"

prop_power n  k = let k' = abs k in
                                        power n k' == n^k'
--prop_power n k = power n (abs k) == n^(abs  k)


example :: Double -> (Bool, Double)
example n = (n < 0 , abs n)
--second (x,y) = y


snacks :: String
snacks = "Spam"

dinner = [snacks, "Fish", "Chips", snacks, snacks, "Pudding"]

summary :: [String]  -> String
summary []=  "Nothing"
summary [x]  = "Just"  ++ x 
summary[x,y] = x ++ " then "  ++y
summary(x:xs) = x
              ++ " then some other stuff and then finally "
              ++ last xs
              
len ::  [ t ]    ->  Int
len []           = 0
len (x:xs)    = 1+ len xs
--len' xs = sum[1| x <- xs]
doubles xs = [2*x| x <- xs]

last' []        = error "last of empty list"
last' [x]       = x
last' (x:xs) =  last' xs

