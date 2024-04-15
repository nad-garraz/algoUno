{- Practica 3. Intro a Haskell -}
-- =================
{- Ejercicio 1 -}
-- =================
-- Ejercicio 1 (a)
f :: Int -> Int
f x
    | x == 1 = 8
    | x == 4 = 131
    | x == 16 = 16

-- Ejercicio 1 (b)
g :: Int -> Int
g x
    | x == 8 = 16
    | x == 16 = 4
    | x == 131 = 1

-- Ejercicio 1 (c)
h :: Int -> Int
h x = f (g x)

k :: Int -> Int
k x = g (f x)

-- =================
{- Ejercicio 2 -}
-- =================

-- Ejercicio 2 (a)
absoluto :: Int -> Int
absoluto x
    | x < 0 = (-x)
    | otherwise = x

-- Ejercicio 2 (b)
maximoAbsoluto :: Int -> Int -> Int
maximoAbsoluto x y
    | x > y = x
    | otherwise = y

-- Ejercicio 2 (c)
maximo3 :: Int -> Int -> Int -> Int
maximo3 x y z
    | x >= y && x >= z = x
    | y >= z = y
    | otherwise = z

-- Ejercicio 2 (d)
algunoEs0 :: Float -> Float -> Bool
algunoEs0 x y
    | x == 0 || y == 0 = True
    | otherwise = False

-- Ejercicio 2 (d) pattern matching
algunoEs0PM :: Float -> Float -> Bool
algunoEs0PM x 0 = True
algunoEs0PM 0 y = True
algunoEs0PM x y = False

-- Ejercicio 2 (e)
ambosSon0 :: Float -> Float -> Bool
ambosSon0 x y =
    x == 0 && y == 0 || False

-- Ejercicio 2 (e) pattern matching
ambosSon0PM :: Float -> Float -> Bool
ambosSon0PM 0 0 = True
ambosSon0PM x y = False

-- Ejercicio 2 (f)
mismoIntervalo :: Float -> Float -> Bool
mismoIntervalo x y
    | (enIntervalo (-(1 / 0)) 3 x) && (enIntervalo (-(1 / 0)) 3 y) = True
    | (enIntervalo 3 7 x) && (enIntervalo 3 7 y) = True
    | (enIntervalo 7 (1 / 0)) x && (enIntervalo 3 (1 / 0) y) = True
    | otherwise = False
  where
    enIntervalo :: Float -> Float -> Float -> Bool
    enIntervalo min max x = x > min && x <= max

-- Ejercicio 2 (g)
sumaDistintos :: Int -> Int -> Int -> Int
sumaDistintos x y z
    | x /= y && x /= z && y /= z = x + y + z
    | x == y && x == z = 0
    | x == y && x /= z = x + z
    | x == z && x /= y = x + y
    | y == z && x /= z = x + z

-- Ejercicio 2 (h)
esMultiploDe :: Int -> Int -> Bool
esMultiploDe x y = (absoluto x `rem` absoluto y) == 0

-- Ejercicio 2 (i)
-- auxiliar
ultimosDigitos :: Int -> Int -> Int
ultimosDigitos x y = x `mod` y

digitoUnidades :: Int -> Int
digitoUnidades x
    | x < 0 = ultimosDigitos (-x) 10
    | otherwise = ultimosDigitos x 10

-- Ejercicio 2 (j)
digitoDecenas :: Int -> Int
digitoDecenas x
    | x < 0 = (ultimosDigitos (-x) 100) `div` 10
    | otherwise = (ultimosDigitos x 100) `div` 10

-- =================
{- Ejercicio 3 -}
-- =================
estanRelacionados :: Int -> Int -> Bool
estanRelacionados 0 0 = False
estanRelacionados x y
    | x `mod` y == 0 = True
    | otherwise = False

-- =================
{- Ejercicio 4 -}
-- =================
-- Ejercicio 4 (a)
prodInt :: (Float, Float) -> (Float, Float) -> Float
prodInt v w = fst v * fst w + snd v * snd w

-- Ejercicio 4 (b)
todoMenor :: (Float, Float) -> (Float, Float) -> Bool
todoMenor v w
    | fst v < fst w && snd v < snd w = True
    | otherwise = False

-- Ejercicio 4 (c)
-- auxiliar
resta :: (Float, Float) -> (Float, Float) -> (Float, Float)
resta v w = (fst v - fst w, snd v - snd w)

distanciaPuntos :: (Float, Float) -> (Float, Float) -> Float
distanciaPuntos v w = sqrt (prodInt (v `resta` w) (v `resta` w))

-- Ejercicio 4 (d)
sumaTerna :: (Float, Float, Float) -> (Float, Float, Float) -> (Float, Float, Float)
sumaTerna (v1, v2, v3) (w1, w2, w3) = (v1 + w1, v2 + w2, v3 + w3)

-- Ejercicio 4 (e)
--
sumarSoloMultiplos :: (Int, Int, Int) -> Int -> Int
sumarSoloMultiplos (a, b, c) n = sum [x | x <- [a, b, c], a `esMultiploDe` n]

-- No entendí la especificacion --> ahora sí entendí, porque hay un número más
--
-- Ejercicio 4 (f)
-- auxiliar es par
esPar x = x `mod` 2 == 0

posPrimerPar :: (Int, Int, Int) -> Int
posPrimerPar (a, b, c)
    | esPar a = 0
    | esPar b = 1
    | esPar c = 2
    | otherwise = 4

-- Ejercicio 4 (g)
crearPar :: a -> b -> (a, b)
crearPar a b = (a, b)

-- Ejercicio 4 (h)
invertir :: (a, b) -> (b, a)
invertir (a, b) = (b, a)

-- =================
{- Ejercicio 5 -}
-- =================
todosMenores :: (Int, Int, Int) -> Bool
todosMenores (a, b, c) = (f a > g a && f b > g b && f c > g c) == True
  where
    f n
        | n >= 7 = n * n
        | otherwise = 2 * n - 1
    g n
        | n `mod` 2 == 0 = n `div` 2
        | otherwise = 3 * n + 1

-- =================
{- Ejercicio 6 -}
-- =================
bisiesto :: Int -> Bool
bisiesto year
    | year `mod` 100 == 0 = year `mod` 400 == 0 -- Si la "p" = V después decide "q"
    | otherwise = year `mod` 4 == 0

-- =================
{- Ejercicio 7 -}
-- =================
distanciaManhattan :: (Float, Float, Float) -> (Float, Float, Float) -> Float
distanciaManhattan (a, b, c) (d, e, f) = sum [abs x | x <- [(a - d), (b - e), (c - f)]]

-- =================
{- Ejercicio 8 -}
-- =================
sumaUltimosDosDigitos :: Int -> Int
sumaUltimosDosDigitos x = digitoUnidades x + digitoDecenas x -- definidas más arriba
-- sumaUltimosDosDigitos x = ((abs x) `mod` 10) + mod ((abs x) `div` 10) 10

comparar :: Int -> Int -> Int
comparar a b
    | sumaUltimosDosDigitos a < sumaUltimosDosDigitos b = 1
    | sumaUltimosDosDigitos a > sumaUltimosDosDigitos b = -1
    | otherwise = 0

-- =================
{- Ejercicio 9 -}
-- =================
-- Ejercicio 9 (a)
{-
 ----------------------------
problema esCero (x: R) : R {
  requiere: {True}
  asegura: {res = 1 <==> x = 0}
  asegura: {res = 0 <==> x /= 0}
}
 ----------------------------
-}

-- Ejercicio 9 (b)
{-
 ----------------------------
problema unoOMenosUno (x: R) : R {
  requiere: {True}
  asegura: {res = 15 <==> x = 1}
  asegura: {res = -15 <==> x = -1}
}
Qué pasa en este caso para los demás valores que puede tomar x?
Porque si no ingreso 1 o -1 entonces estaría indefinido.
 ----------------------------
-}

-- Ejercicio 9 (c)
{-
 ----------------------------
problema esCero (x: R) : R {
  requiere: {True}
  asegura: {res = 15 <==> x = 1}
  asegura: {res = -15 <==> x = -1}
}
Qué pasa en este caso para los demás valores que puede tomar x?
 ----------------------------
-}
