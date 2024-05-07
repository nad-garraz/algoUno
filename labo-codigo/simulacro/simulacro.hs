{-
}

 Ejercicio 2
problema personas (relaciones: seq⟨String x String⟩) : seq⟨String⟩ {
  requiere: {relacionesValidas(relaciones)}
  asegura: {res no tiene elementos repetidos}
  asegura: {res tiene exactamente los elementos que figuran en alguna tupla de relaciones, en cualquiera de sus posiciones}
}
 Ejercicio 3
problema amigosDe (persona: String, relaciones: seq⟨String x String⟩) : seq⟨String⟩ {
  requiere: {relacionesValidas(relaciones)}
  asegura: {res tiene exactamente los elementos que figuran en las tuplas de relaciones en las que una de sus componentes es persona}
}

-}

-- 1
-- problema relacionesValidas (relaciones: seq⟨String x String⟩) : Bool {
--   requiere: {True}
--   asegura: {(res = true) <=> relaciones no contiene ni tuplas repetidas,
--   ni tuplas con ambas componentes iguales}
-- A los fines de este problema consideraremos que dos tuplas son iguales si el par de elementos que las componen (sin importar el orden) son iguales.
relacionesValidas :: [(String,String)] -> Bool
relacionesValidas [] = True
relacionesValidas (x:xs) = not (tuplasConMismosElementos x xs) && relacionesValidas xs

tuplasConMismosElementos :: (String, String) -> [(String,String)] -> Bool
tuplasConMismosElementos (a,b) [] = a == b
tuplasConMismosElementos (x1,y1) ((a,b) : resto)
  | x1 == y1 = True
  | (x1 == a && y1 == b) || (x1 == b && y1 == a) = True
  | otherwise = tuplasConMismosElementos (x1,y1) (resto)

-- 2
-- Tengo que aplanar
-- [("ab","bc"), ("ad","cd")] -> ["ab","bc","ad","cd"]
-- [("ab","bc"), ("ab","cd")] -> ["ab","bc","cd"]
--
personas :: [(String, String)] -> [String]
personas [] = []
personas xs = borrarRepetidos (aplanar xs)

aplanar :: [(String, String)] -> [String]
aplanar [] = []
aplanar ((a, b) : strs) = a : b : aplanar strs

borrarRepetidos :: [String] -> [String]
borrarRepetidos [] = []
borrarRepetidos (x : xs)
    | pertenece x xs = borrarRepetidos xs
    | otherwise = x : borrarRepetidos xs

pertenece :: String -> [String] -> Bool
pertenece _ [] = False
pertenece str (x : xs) = str == x || pertenece str xs

-- 3
-- "ab" --> [("ab","bc"), ("ad","cd"),("ef", "ab")] -> ["ab","bc","ef","cd"]

amigosDe :: String -> [(String, String)] -> [String]
amigosDe _ [] = []
amigosDe p ((ami1, ami2) : rs)
    | (p == ami1 || p == ami2) = ami1 : ami2 : amigosDe p rs
    | otherwise = amigosDe p rs

-- 4
-- problema personaConMasAmigos (relaciones: seq⟨String x String⟩) : String {
--   requiere: {relaciones no vacía}
--   requiere: {relacionesValidas(relaciones)}
--   asegura: {res es el Strings que aparece más veces en las tuplas de relaciones (o alguno de ellos si hay empate)}
-- }
--
-- Devuelve el elemento que más veces aparece en una lista de tuplas
personasConMasAmigos :: [(String, String)] -> String
personasConMasAmigos [] = ""
personasConMasAmigos relaciones = personasConMasAmigosSinMALDITASTuplas (personasDeRelaciones relaciones)

-- Le doy una lista de duplas y me aplana. [(a,b),(c,d)] -> [a,b,c,d]
personasDeRelaciones :: [(String, String)] -> [String]
personasDeRelaciones [] = []
personasDeRelaciones [(a, b)] = [a, b]
personasDeRelaciones ((a, b) : relaciones) = a : b : personasDeRelaciones relaciones

-- Me da las cantidad de apariciones de un elemento en una lista
qAmigosDePersona :: String -> [String] -> Integer
qAmigosDePersona _ [] = 0
qAmigosDePersona persona (a : personas)
    | persona == a = 1 + pasoRecursivo
    | otherwise = pasoRecursivo
  where
    pasoRecursivo = qAmigosDePersona persona personas

-- Devuelve el elemento que más veces aparece en una lista
personasConMasAmigosSinMALDITASTuplas :: [String] -> String
personasConMasAmigosSinMALDITASTuplas [a] = a
personasConMasAmigosSinMALDITASTuplas (a : b : personas)
    | qAmigosDePersona a personas >= qAmigosDePersona b personas = personasConMasAmigosSinMALDITASTuplas (a : personas)
    | otherwise = personasConMasAmigosSinMALDITASTuplas (b : personas)
