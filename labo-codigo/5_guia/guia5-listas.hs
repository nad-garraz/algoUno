{-
   ____       _         ____            _ _     _
  / ___|_   _(_) __ _  | ___|          | (_)___| |_ __ _ ___
 | |  _| | | | |/ _` | |___ \   _____  | | / __| __/ _` / __|
 | |_| | |_| | | (_| |  ___) | |_____| | | \__ \ || (_| \__ \
  \____|\__,_|_|\__,_| |____/          |_|_|___/\__\__,_|___/
-}

-- Módulo para testeo
import Test.HUnit

-- entrada en calor
sumaLista :: [Integer] -> Integer
sumaLista [] = 0
sumaLista (x : xs) = x + sumaLista xs

-- Casos de testeo para sumalista
testSumaLista1 :: Test
testSumaLista1 = TestCase $ assertEqual "caso 1 sumaLista" 10 (sumaLista [1, 2, 3, 4])
testSumaLista2 :: Test
testSumaLista2 = TestCase $ assertEqual "caso 2 sumaLista" 0 (sumaLista [])

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e [] = False
pertenece e (x : xs) = e == x || pertenece e xs

cola :: (Eq t) => [t] -> [t]
cola [] = []
cola (x : xs) = xs

cabeza :: (Eq t) => [t] -> t
cabeza (x : xs) = x

-- fin entrada en calor

-- =================
{- Ejercicio 1 -}
-- =================
-- Ejercicio 1 - (1)
longitud :: [tx] -> Int
longitud [] = 0
longitud (x : xs) = 1 + longitud xs

-- Ejercicio 1 - (2)
ultimo :: [txs] -> txs
ultimo (x : xs)
    | longitud xs == 0 = x
    | otherwise = ultimo xs

-- Ejercicio 1 - (3)
principio :: [t] -> [t]
principio (x : xs)
    | longitud xs == 0 = []
    | longitud xs == 1 = [x]
    | otherwise = x : principio xs

principio2 :: [a] -> [a]
principio2 [_] = []
principio2 (x : xs) = x : principio2 xs

-- Ejercicio 1 - (4)
reverso :: [t] -> [t]
reverso [] = []
reverso xs = ultimo xs : reverso (principio xs)

-- =================
{- Ejercicio 2 -}
-- =================
--
-- Ejercicio 2 - (1)
pertenece2 :: (Eq t) => t -> [t] -> Bool
pertenece2 _ [] = False
pertenece2 t (x : xs)
    | t == x = True
    | otherwise = pertenece2 t xs

-- Ejercicio 2 - (2)
todosIguales :: (Eq t) => [t] -> Bool
todosIguales [_] = True
todosIguales (x : xs)
    | x == firstElement xs = todosIguales xs
    | otherwise = False
  where
    firstElement (x : xs) = x

todosIguales2 :: (Eq t) => [t] -> Bool
todosIguales2 [] = True
todosIguales2 [_] = True
todosIguales2 (x : y : ys) = x == y && todosIguales2 (y : ys)

-- Ejercicio 2 - (3)
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = True
todosDistintos (x : xs)
    | pertenece2 x xs = False
    | otherwise = todosDistintos xs

todosDistintos2 :: (Eq t) => [t] -> Bool
todosDistintos2 [] = True
todosDistintos2 (x : xs) = not (pertenece x xs) && todosDistintos2 (xs)

-- No funca, solo compara consecutivos.
todosDistintos3 :: (Eq a) => [a] -> Bool
todosDistintos3 [] = True
todosDistintos3 [x] = True
todosDistintos3 (x : y : ys)
    | x == y = False
    | otherwise = todosDistintos3 (y : ys)

-- Ejercicio 2 - (4)
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [] = False
hayRepetidos (x : xs) = pertenece x xs || hayRepetidos xs

-- Ejercicio 2 - (5)
quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar e (x : xs)
    | e /= x = x : quitar e xs
    | otherwise = xs

-- Ejercicio 2 - (6)
quitarTodos :: (Eq t) => t -> [t] -> [t]
quitarTodos _ [] = []
quitarTodos e (x : xs)
    | e /= x = x : quitarTodos e xs
    | otherwise = quitarTodos e xs

-- Ejercicio 2 - (7)
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (x : xs) = x : eliminarRepetidos (quitarTodos x xs)

-- Ejercicio 2 - (8)
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos xs ys = todosElementosIncluidos xs ys && todosElementosIncluidos ys xs

todosElementosIncluidos :: (Eq t) => [t] -> [t] -> Bool
todosElementosIncluidos [] _ = True
todosElementosIncluidos (x : xs) ys = pertenece x ys && todosElementosIncluidos xs ys

-- Ejercicio 2 - (9)
capicua :: (Eq a) => [a] -> Bool
capicua [] = True
capicua xs = not (cabeza xs /= ultimo xs)

-- =================
{- Ejercicio 3 -}
-- =================
-- Ejercicio 3 - (1)
sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x : xs) = x + sumatoria xs

-- Ejercicio 3 - (2)
productoria :: [Integer] -> Integer
productoria [] = 0
productoria (x : xs) = x * productoria xs

-- Ejercicio 3 - (3)
maximo :: [Integer] -> Integer
maximo [a] = a
maximo (x : xs)
    | x <= cabeza xs = maximo xs
    | otherwise = maximo (x : cola xs)

-- Ejercicio 3 - (4)
sumarN :: Integer -> [Integer] -> [Integer]
sumarN _ [] = []
sumarN n (m : ms) = n + m : sumarN n ms

-- Ejercicio 3 - (5)
sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero ns = sumarN (cabeza ns) ns

-- Ejercicio 3 - (6)
sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo ns = sumarN (cabeza (reverso ns)) ns

-- Ejercicio 3 - (7)
pares :: [Integer] -> [Integer]
pares [] = []
pares ns
    | mod (cabeza ns) 2 == 0 = cabeza ns : pares (cola ns)
    | otherwise = pares (cola ns)

-- Ejercicio 3 - (8)
multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN n [] = []
multiplosDeN n ns
    | mod (cabeza ns) n == 0 = cabeza ns : multiplosDeN n (cola ns)
    | otherwise = multiplosDeN n (cola ns)

-- Ejercicio 3 - (9)
ordenar :: [Integer] -> [Integer]
ordenar ns = reverso (decreciente ns)
  where
    decreciente :: [Integer] -> [Integer]
    decreciente [] = []
    decreciente ns = maximo ns : decreciente (quitar (maximo ns) ns)

-- =================
{- Ejercicio 4 -}
-- =================
-- Ejercicio 4 - (a)
borrarEspaciosRepetidos :: [Char] -> [Char]
borrarEspaciosRepetidos [] = []
borrarEspaciosRepetidos (c : []) = [c]
borrarEspaciosRepetidos (c : cs)
    | c == ' ' && cabeza cs == ' ' = borrarEspaciosRepetidos cs
    | otherwise = c : borrarEspaciosRepetidos cs

-- Ejercicio 4 - (b)
contarPalabras :: [Char] -> Integer
contarPalabras [] = 0
contarPalabras cs = 1 + contarEspacios (borrarEspacioIniFin (borrarEspaciosRepetidos cs))

-- aux borrar espacios al final y al principio del string
borrarEspacioIniFin :: [Char] -> [Char]
borrarEspacioIniFin [] = []
borrarEspacioIniFin (c : cs)
    | c == ' ' = borrarEspacioFin cs
    | otherwise = borrarEspacioFin (c : cs)

-- aux borrar espacios al final del string
borrarEspacioFin :: [Char] -> [Char]
borrarEspacioFin (x : [])
    | x == ' ' = []
    | otherwise = [x]
borrarEspacioFin (x : cs) = x : borrarEspacioFin cs

contarEspacios :: [Char] -> Integer
contarEspacios [] = 0
contarEspacios (c : cs)
    | c == ' ' = 1 + contarEspacios cs
    | otherwise = 0 + contarEspacios cs

-- -- Ejercicio 4 - (c)
palabras :: [Char] -> [[Char]]
palabras cs = primeraPalabra (limpiarEspacios cs) : elRestoDePalabras (limpiarEspacios cs)
  where
    -- "ab c def g" -> ["c", "def", "g"]
    elRestoDePalabras :: [Char] -> [[Char]]
    elRestoDePalabras [] = []
    elRestoDePalabras (' ' : cs) = cortarEnEspacio (limpiarEspacios cs) : elRestoDePalabras cs
    elRestoDePalabras (c : cs) = elRestoDePalabras cs

    primeraPalabra :: [Char] -> [Char]
    primeraPalabra [] = []
    primeraPalabra (c : ' ' : xs) = [c]
    primeraPalabra (c : cs) = c : primeraPalabra cs

    cortarEnEspacio :: [Char] -> [Char]
    cortarEnEspacio [] = []
    cortarEnEspacio (c : cs)
        | c == ' ' = []
        | otherwise = c : cortarEnEspacio cs

    limpiarEspacios :: [Char] -> [Char]
    limpiarEspacios cs = borrarEspacioIniFin (borrarEspaciosRepetidos cs)

-- ===================
--  Aca refrito un montón de funciones que ya hice, para practicar nada más. Pero el ejecicio
--  sale mucho más corto usando las funciones hechas a lo largo de la práctica.

palabraMasLarga :: [Char] -> [Char]
palabraMasLarga [] = []
palabraMasLarga cs = aux (lsDePalabras (rmLeftAndRightSpace cs))
  where
    aux :: [[Char]] -> [Char]
    aux [c] = c
    aux (c : d : ds)
        | lengthString c <= lengthString d = aux (d : ds)
        | otherwise = aux (c : ds)

    lsDePalabras :: [Char] -> [[Char]]
    lsDePalabras [] = []
    lsDePalabras cs = restoPalabras (rmLeftAndRightSpace cs)

    lsStr2Strlength :: [[Char]] -> [Integer]
    lsStr2Strlength [] = []
    lsStr2Strlength (s : ss) = lengthString s : lsStr2Strlength ss

    lengthString :: [Char] -> Integer
    lengthString [] = 0
    lengthString (c : cs) = 1 + lengthString cs

    primeraPalabra2 :: [Char] -> [Char]
    primeraPalabra2 [] = []
    primeraPalabra2 (' ' : cs) = []
    primeraPalabra2 (c : cs) = c : primeraPalabra2 cs

    restoPalabras :: [Char] -> [[Char]]
    restoPalabras [] = []
    restoPalabras cs = primeraPalabra2 cs : restoPalabras (cortoEnEspacio cs)

    cortoEnEspacio :: [Char] -> [Char]
    cortoEnEspacio [] = []
    cortoEnEspacio (c : cs)
        | c == ' ' = cs
        | otherwise = cortoEnEspacio cs

    rmLeftAndRightSpace :: [Char] -> [Char]
    rmLeftAndRightSpace [] = []
    rmLeftAndRightSpace (' ' : cs) = rmLeftAndRightSpace (rmRepeatSpace cs)
    rmLeftAndRightSpace cs = rmRightSpace cs

    rmRightSpace :: [Char] -> [Char]
    rmRightSpace [] = []
    rmRightSpace (' ' : []) = []
    rmRightSpace (c : cs) = c : rmRightSpace cs

    rmRepeatSpace :: [Char] -> [Char]
    rmRepeatSpace [] = []
    rmRepeatSpace (c : []) = [c]
    rmRepeatSpace (c : d : cs)
        | c == d && d == ' ' = rmRepeatSpace (d : cs)
        | otherwise = c : rmRepeatSpace (d : cs)

{-
  _____         _
 |_   _|__  ___| |_ ___  ___
   | |/ _ \/ __| __/ _ \/ _ \
   | |  __/\__ \ ||  __/ (_) |
   |_|\___||___/\__\___|\___/

-}
-- Función con comandos para que corra al ejecutar el archivo.

main :: IO ()
main = do
    runTestTT $ TestList [testSumaLista1, testSumaLista2]
    runTestTT $ TestList [testList_palabraMasLarga]
    return ()

tests_primeraPalabra :: [(String, String)]
tests_primeraPalabra = [("a", "  a  "), ("ab", "ab cd"), ("ab", "ab  cd "), ("ab", " ab  cd  "), ("ab", "  ab  cd  ")]

tests_cortoEnEspacio :: [(String, String)]
tests_cortoEnEspacio = [("", "a"), ("cd", "ab cd"), ("cd ef", "ab cd ef")]

tests_lsDePalabras :: [([String], String)]
tests_lsDePalabras = [(["a"], " a"), (["a"], "a "), (["a"], " a"), (["ab", "cd"], "  ab  cd  "), (["ab", "cd", "ef"], " ab  cd ef"), (["Hola", "Manola"], "Hola Manola")]

tCase_palabraMasLarga :: [(String, String)]
tCase_palabraMasLarga = [("a", " a"), ("av", "av "), ("av", " av   c "), ("abc", " abc  ab  cd  "), ("abcde", " ab  cd ef    abcde"), ("Manola", "Hola Manola"), ("da", "da error")]

---- Esto genera un TestCase para cada par de (expected, output) de la lista tests_...
generateTestCase :: ([Char], [Char]) -> Test
generateTestCase (expected, input) = TestCase (assertEqual ("Caso \"" ++ input ++ "\"") expected (palabraMasLarga (input)))

-- generateTestCase (expected, input) = TestCase (assertEqual ("Caso \"" ++ input ++ "\"") expected (cortoEnEspacio input))
-- generateTestCase (expected, input) = TestCase (assertEqual ("Caso \"" ++ input ++ "\"") expected (lsDePalabras input))

-- esto genera una TestList, mapeando generateTestCase a tests_primeraPalabra.
-- testList_palabraMasLarga :: Test
-- testList_palabraMasLarga = TestList (map generateTestCase tests_primeraPalabra)
-- testList_cortoEnEspacio :: Test
-- testList_cortoEnEspacio = TestList (map generateTestCase tests_cortoEnEspacio)
-- testList_lsDePalabras :: Test
-- testList_lsDePalabras = TestList (map generateTestCase tests_lsDePalabras)
testList_palabraMasLarga :: Test
testList_palabraMasLarga = TestList (map generateTestCase tCase_palabraMasLarga)
