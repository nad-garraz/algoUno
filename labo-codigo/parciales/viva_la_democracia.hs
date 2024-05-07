type Presidente = String
type Vicepresidente = String
type Formula = (Presidente, Vicepresidente)
type Formulas = [Formula]
type Voto = Integer
type Votos = [Voto]

votosEnBlanco :: [(String, String)] -> [Integer] -> Integer -> Integer
votosEnBlanco formulas vNegros vTotal = vTotal - suma vNegros

suma :: [Integer] -> Integer
suma [] = 0
suma (n : ns) = n + suma ns

formulasValidas :: [(String, String)] -> Bool
formulasValidas [] = True
formulasValidas (x : xs) = siPresiNoVice x && soloUnaCandidatura x xs && formulasValidas xs
  where
    siPresiNoVice :: (String, String) -> Bool
    siPresiNoVice (presi, vice) = presi /= vice

    soloUnaCandidatura :: (String, String) -> [(String, String)] -> Bool
    soloUnaCandidatura _ [] = True
    soloUnaCandidatura (a, b) ((c, d) : resto)
        | (a /= c && b /= d) && (a /= d && b /= c) = soloUnaCandidatura (a, b) resto
        | otherwise = False

porcentajeDeVotos :: String -> [(String, String)] -> [Integer] -> Float
porcentajeDeVotos presi ((a, b) : resto) (v : vs)
    | presi == a = porcentaje v (suma (v : vs))
    | otherwise = porcentajeDeVotos presi resto (vs ++ [v])
  where
    porcentaje :: Integer -> Integer -> Float
    porcentaje v vTotal = (division v vTotal) * 100

    division :: Integer -> Integer -> Float
    division n m = fromInteger n / fromInteger m

proximoPresidente :: [(String, String)] -> [Integer] -> String
proximoPresidente (x : []) [v] = fst x
-- ... terminar
