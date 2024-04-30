{-
--   ____       _         ____            _ _     _
--  / ___|_   _(_) __ _  | ___|          | (_)___| |_ __ _ ___
-- | |  _| | | | |/ _` | |___ \   _____  | | / __| __/ _` / __|
-- | |_| | |_| | | (_| |  ___) | |_____| | | \__ \ || (_| \__ \
--  \____|\__,_|_|\__,_| |____/          |_|_|___/\__\__,_|___/
-}

-- entrada en calor
sumaLista :: [Integer] -> Integer
sumaLista [] = 0
sumaLista (x : xs) = x + sumaLista xs

pertenece :: Integer -> [Integer] -> Bool
pertenece e [] = False
pertenece e (x : xs) = e == x || pertenece e xs

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

-- Preguntar poro el caso de lista con un solo elemento. Se devuele vacío?

-- Ejercicio 1 - (4)
reverso :: [t] -> [t]
reverso [] = []
reverso x = ultimo x : reverso (principio x)

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

-- Ejercicio 2 - (3)
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = True
todosDistintos (x : xs)
    | pertenece2 x xs = False
    | otherwise = todosDistintos xs

-- Ejercicio 2 - (4)
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [] = False
hayRepetidos (x : xs) = pertenece2 x xs || hayRepetidos xs

-- Ejercicio 2 - (5)
quitar :: (Eq t) => t -> [t] -> [t]
quitar target (pri : resto)
    | target /= pri = pri : quitar target resto
    | otherwise = resto

-- Ejercicio 2 - (6)
quitarTodos :: (Eq t) => t -> [t] -> [t]
quitarTodos target lista = [x | x <- lista, x /= target]

-- version alternativa.
quitarTodos2 :: (Eq t) => t -> [t] -> [t]
quitarTodos2 _ [] = []
quitarTodos2 target (pri : resto)
    | target /= pri = pri : quitarTodos2 target (resto)
    | otherwise = quitarTodos2 target resto

-- Ejercicio 2 - (7)
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (pri : rest)
    | pertenece2 pri rest = pri : eliminarRepetidos (quitarTodos2 pri rest)
    | otherwise = pri : eliminarRepetidos rest

-- Ejercicio 2 - (8)
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos _ [] = False
mismosElementos [] _ = False
mismosElementos lista_a lista_b
    | compararElPrimeroConLista lista_a lista_b = mismosElementos (tail lista_a) (lista_b)
    | otherwise = False
  where
    compararElPrimeroConLista lista_a lista b = pertenece2 (head (lista_a)) lista_b
