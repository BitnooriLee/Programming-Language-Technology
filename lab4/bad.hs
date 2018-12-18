mult x y = if y < 1 then 0 else x + mult x (y-1) ;
fact     = \x -> if x < 3 then x else mul x (fact (x-1)) ;
main     = print (fact 6) ;