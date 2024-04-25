sumaLista :: [Integer] -> Integer
sumaLista [] = 0
sumaLista (x:xs) = x + sumaLista xs

pertenece :: Integer -> [Integer] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e == x || pertenece e xs

-- =================
{- Ejercicio 1 -}
-- =================
-- Ejercicio 1 - (1)
longitud :: [tx] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-- Ejercicio 1 - (2)
ultimo :: [txs] -> txs
ultimo (x:xs)
  | longitud xs == 0 = x
  | otherwise = ultimo xs

-- Ejercicio 1 - (3)
principio :: [t] -> [t]
principio (x:xs)
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

