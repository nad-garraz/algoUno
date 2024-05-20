divisoresPropios :: Int -> [Int]
divisoresPropios a = divisoresPropiosAux a 1

divisoresPropiosAux :: Int -> Int -> [Int]
divisoresPropiosAux n m
  | m == n = []
  | mod n m == 0 = m: pasoRec
  | otherwise = pasoRec
  where
    pasoRec = divisoresPropiosAux n (m+1)

sonAmigos :: Int -> Int -> Bool
sonAmigos a b = suma(divisoresPropios a) == b && suma(divisoresPropios b) == a

suma :: [Int] -> Int
suma [] = 0
suma (x:xs) = x + suma xs

losPrimerosNPerfectos :: Int -> [Int]
losPrimerosNPerfectos a = losPrimerosNPerfectosAux a 5 0

losPrimerosNPerfectosAux :: Int -> Int -> Int -> [Int]
losPrimerosNPerfectosAux a n corta
  | a == corta = []
  | n == suma(divisoresPropios n) = n : losPrimerosNPerfectosAux a (n+1) (corta + 1)
  | otherwise = losPrimerosNPerfectosAux a (n+1) corta

-- la lista input no tiene repetidos
-- la lista de ouput no puede tener tuplas repetidas ni (a,b)=(b,a)
listaDeAmigos :: [Int] -> [(Int,Int)]
listaDeAmigos [] = []
listaDeAmigos (n:resto) = (listaDeAmigos resto) ++ (amigosDeXEnLs n resto)

amigosDeXEnLs :: Int -> [Int] -> [(Int,Int)]
amigosDeXEnLs _ [] = []
amigosDeXEnLs x (y:ys)
  | sonAmigos x y = [(x,y)]
  | otherwise = amigosDeXEnLs x ys
