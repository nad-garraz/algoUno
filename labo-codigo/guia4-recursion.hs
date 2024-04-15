{-
   ____       _         _  _             _       _
  / ___|_   _(_) __ _  | || |           (_)_ __ | |_ _ __ ___
 | |  _| | | | |/ _` | | || |_   _____  | | '_ \| __| '__/ _ \
 | |_| | |_| | | (_| | |__   _| |_____| | | | | | |_| | | (_) |
  \____|\__,_|_|\__,_|    |_|           |_|_| |_|\__|_|  \___/

-- =================
-}

-- =================
{- Ejercicio 1 -}
-- =================
-- Fibonacci
fibonacci :: Int -> Int
fibonacci n
    | n == 0 = 0
    | n == 1 = 1
    | otherwise = fibonacci (n - 1) + fibonacci (n - 2)

-- =================
{- Ejercicio 2 -}
-- =================
--
parteEntera :: Float -> Int
parteEntera x
    | x >= 0 && x < 1 = 0
    | x >= 1 = 1 + parteEntera (x - 1)
    | otherwise = -1 + parteEntera (x + 1)

-- =================
{- Ejercicio 3 -}
-- =================
esDivisible :: Integer -> Integer -> Bool
esDivisible n m
    | n == m = True
    | n < m = False
    | n > m = esDivisible (n - m) m

-- =================
{- Ejercicio 4 -}
-- =================
sumaImpares :: Integer -> Integer
sumaImpares n
    | n == 1 = 1
    | otherwise = (2 * n - 1) + sumaImpares (n - 1)

-- =================
{- Ejercicio 5 -}
-- =================
medioFact :: Integer -> Integer
medioFact 0 = 0
medioFact n
    | n <= 2 = n
    | n `esDivisible` 2 = n * medioFact (n - 2)
    | otherwise = n * medioFact (n - 2)

-- =================
{- Ejercicio 6 -}
-- =================
sumaDigitos :: Integer -> Integer
sumaDigitos 0 = 0
sumaDigitos n = mod n 10 + sumaDigitos (div n 10)

-- =================
{- Ejercicio 7 -}
-- =================
todosDigitosIguales :: Integer -> Bool
todosDigitosIguales n
    | n < 10 = True
    | otherwise = (digitoUnidad n == digitoUnidad (sacoUnidad n) && todosDigitosIguales (sacoUnidad n))
  where
    digitoUnidad n = n `mod` 10
    sacoUnidad n = n `div` 10

-- =================
{- Ejercicio 8 -}
-- =================
-- auxiliares
---------------------------------------------------
digitoUnidad :: Integer -> Integer
digitoUnidad n = n `mod` 10

sacoUnidad :: Integer -> Integer
sacoUnidad n = n `div` 10

modulo :: Integer -> Integer
modulo n
    | n >= 0 = n
    | otherwise = -n

cantDigitos :: Integer -> Integer
cantDigitos n
    | modulo (sacoUnidad n) == 0 = 1
    | otherwise = 1 + cantDigitos (modulo (sacoUnidad n))

---------------------------------------------------

iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n i
    | i == cantDigitos n = digitoUnidad n
    | otherwise = iesimoDigito (sacoUnidad n) i

-- =================
{- Ejercicio 9 -}
-- =================
{-
  problema esCapicua (n:\enteros>=0): Bool {
    requiere: {True}
    asegura: {res = True \sisolosi "n" se lee igual de izquiera a derecha que de derecha a izquierda}
   }
-}

primerDigito :: Integer -> Integer
primerDigito n
    | n < 10 = n
    | otherwise = primerDigito (sacoUnidad n)

sacoPrimerDigito :: Integer -> Integer
sacoPrimerDigito n = mod n (10 ^ ((cantDigitos n) - 1))

esCapicua :: Integer -> Bool
esCapicua n
    | cantDigitos n <= 3 && primerDigito n == digitoUnidad n = True
    | primerDigito n == digitoUnidad n = esCapicua (sacoPrimerDigito (sacoUnidad n))
    | otherwise = False

-- =================
{- Ejercicio 10 -}
-- =================
-- Ejercicio 10 (a)
{-
  problema f1 (n:\enteros \geq 0): \enteros {
    requiere: {n \geq 0}
    asegura: { res = 2^(n+1) - 1 }
   }
-}

f1 :: Integer -> Integer
f1 n
    | n == 0 = 1
    | otherwise = 2 ^ n + f1 (n - 1)

-- Ejercicio 10 (b)
{-
  problema f2 (n:\enteros, q: \reales): \reales {
    requiere: {n \geq 1}
    asegura: { si q \neq  1 \entonces res = (q^(n+1) - q)/(q-1) || res = n }
   }
-}

f2 :: Integer -> Float -> Float
f2 n q
    | n == 1 = q
    | otherwise = q ^ n + f2 (n - 1) q

-- Ejercicio 10 (c)
{-
  problema f3 (n:\enteros, q: \reales): \reales {
    requiere: {n \geq 1}
    asegura: { si q \neq  1 \entonces res = (q^(2n+1) - q)/(q-1) || res = 2n }
   }
-}

f3 :: Integer -> Float -> Float
f3 n q
    | n == 1 = q + q ^ 2
    | otherwise = q ^ (2 * n) + q ^ (2 * n - 1) + f3 (n - 1) q

-- Ejercicio 10 (d)
{-
  problema f4 (n:\enteros, q: \reales): \reales {
    requiere: {n \geq 0}
    asegura: { si q \neq  2 \entonces res = (q^(2n+1) - q^n)/(q-2) || res = n+1 }
   }
-}

f4 :: Integer -> Float -> Float
f4 0 _ = 1 -- ponele...
f4 n q
    | n == 1 = q ^ n + q ^ (n + 1)
    | otherwise = q ^ (2 * n) + q ^ (2 * n - 1) + f4 (n - 1) q

-- =================
{- Ejercicio 11 -}
-- =================
-- Ejercicio 11 (a)
{-
  problema eAprox (n:\enteros): \reales {
    requiere: {n \geq 0}
    asegura: { res  }
   }
-}
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

eAprox :: Integer -> Float
eAprox 0 = 1
eAprox n = 1.0 / (fromIntegral (factorial n)) + eAprox (n - 1)

-- Ejercicio 11 (b)
e :: Float
e = eAprox 10

-- =================
{- Ejercicio 12 -}
-- =================

{-
  problema raizDe2Aprox (n:\enteros): \reales {
    requiere: {n >= 1}
    asegura: {}
   }
-}
-- Auxiliar fracciones continuas de raíz de 2
sucesionInfernal :: Integer -> Float
sucesionInfernal 1 = 2
sucesionInfernal n = 2 + 1 / sucesionInfernal (n - 1)

raizDe2Aprox :: Integer -> Float
raizDe2Aprox n = sucesionInfernal n - 1
