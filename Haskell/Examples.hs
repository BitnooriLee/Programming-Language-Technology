module Examples  where
import Test.QuickCheck

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
power n 0                             = 1
power n k | k > 0                  = power n (k-1) * n
power n k | otherwise         = error  "power: negative arg not supported"