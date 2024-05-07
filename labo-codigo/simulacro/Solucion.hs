module Solucion where

relacionesValidas :: [(String, String)] -> Bool
relacionesValidas [] = True
relacionesValidas (unaAmistad : masLista) = not (mismaPersona unaAmistad) && not (amistadRepetida unaAmistad masLista) && pasoRecursivo
  where
    pasoRecursivo = relacionesValidas masLista

mismaPersona :: (String, String) -> Bool
mismaPersona (a, b) = a == b

amistadRepetida :: (String, String) -> [(String, String)] -> Bool
amistadRepetida _ [] = False
amistadRepetida a (b : elResto) = mismaAmistad a b || amistadRepetida a elResto
  where
    mismaAmistad (a, b) (c, d) = (a == c && b == d) || (a == d && b == c)

personas :: [(String, String)] -> [String]
personas rs = eliminarRepetidos (personasConRepes rs)

personasConRepes :: [(String, String)] -> [String]
personasConRepes [] = []
personasConRepes ((p1, p2) : rs) = p1 : p2 : personasConRepes rs

eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (x : xs) = x : eliminarRepetidos (quitarTodos x xs)

quitarTodos :: (Eq t) => t -> [t] -> [t]
quitarTodos _ [] = []
quitarTodos e (x : xs)
    | e == x = quitarTodos e xs
    | otherwise = x : (quitarTodos e xs)

amigosDe :: String -> [(String, String)] -> [String]
amigosDe a [] = []
amigosDe a ((p1, p2) : elResto)
    | a == p1 = p2 : pasoRecursivo
    | a == p2 = p1 : pasoRecursivo
    | otherwise = pasoRecursivo
  where
    pasoRecursivo = amigosDe a elResto

personaConMasAmigos :: [(String, String)] -> String
personaConMasAmigos relaciones =
    personaConMasAmigosAux personasDeRelacion (cantidadDeAmigosDePersonas personasDeRelacion relaciones)
  where
    personasDeRelacion = personas relaciones

cantidadDeAmigosDePersonas :: [String] -> [(String, String)] -> [Int]
cantidadDeAmigosDePersonas [] _ = []
cantidadDeAmigosDePersonas (p1 : ps) relaciones = longitud (amigosDe p1 relaciones) : pasoRecursivo
  where
    pasoRecursivo = cantidadDeAmigosDePersonas ps relaciones

longitud :: [t] -> Int
longitud [] = 0
longitud (x : xs) = 1 + longitud xs

personaConMasAmigosAux :: [String] -> [Int] -> String
personaConMasAmigosAux [p1] _ = p1
personaConMasAmigosAux (p1 : p2 : ps) (c1 : c2 : cs)
    | c1 > c2 = personaConMasAmigosAux (p1 : ps) (c1 : cs)
    | otherwise = personaConMasAmigosAux (p2 : ps) (c2 : cs)
