{-

La lista tiene que tener un solo tipo.

[1,2,3,4,5]
1:2:3:4:5:[]

-}

-- Suma los elementos de una lista
mySum :: [Int] -> Int
mySum [] = 0
mySum (x : xs) = x + mySum xs

-- Retorna los elementos pares de una lista
evens :: [Int] -> [Int]
evens [] = []
evens (x : xs)
    | mod x 2 == 0 = x : evens xs
    | otherwise = evens xs

asc :: Int -> Int -> [Int]
asc n m
    | m < n = []
    | n == m = [m]
    | n < m = n : asc (n + 2) m

listorti :: Int -> Int -> Int -> [Int]
listorti a b c = 1 : 2 : 3 : []

identidad :: tx -> ty -> tx
identidad x y = x

myElem :: (Eq a) => a -> [a] -> Bool
myElem _ [] = False -- myElem e [] = False
myElem e (x : xs) = (e == x) || (myElem e xs)

{- o también puede el último renglón ser:
 myElem e (x:xs)
 | e == x = True
 | otherwise = myElem e xs
-}

myNub :: (Eq a) => [a] -> [a]
myNub [] = []
myNub (x : xs) = x : myNub [e | e <- xs, x /= e]

{- o también puede el último renglón ser:
 myNub (x : xs)
 | myElem x xs = myNub xs
 | otherwise = x : myNub xs
-}
