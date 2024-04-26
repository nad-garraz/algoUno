{-
  ____       _         ____            _ _     _            
 / ___|_   _(_) __ _  | ___|          | (_)___| |_ __ _ ___ 
| |  _| | | | |/ _` | |___ \   _____  | | / __| __/ _` / __|
| |_| | |_| | | (_| |  ___) | |_____| | | \__ \ || (_| \__ \
 \____|\__,_|_|\__,_| |____/          |_|_|___/\__\__,_|___/
-}

-- entrada en calor
sumaLista :: [Integer] -> Integer
sumaLista [] = 0
sumaLista (x:xs) = x + sumaLista xs

pertenece :: Integer -> [Integer] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e == x || pertenece e xs

-- fin entrada en calor

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

