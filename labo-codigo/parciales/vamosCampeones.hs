-- 1) Atajaron Suplentes
-- problema atajaronSuplentes (arquerosPorEquipo: seq<String X String>, goles: seq<Z>, totalGolesTorneo: Z): Z {
--   requiere: {equiposValidos(arquerosPorEquipo)}
--   requiere: {|arquerosPorEquipo| = |goles|}
--   requiere: {Todos los elementos de goles son mayores o iguales a 0}
--   requiere: {La suma de todos los elementos de goles es menor o igual a totalGolesTorneo}
--   asegura: {
--   res es la cantidad de goles recibidos en el torneo por arqueros que no son titulares en sus equipos.
--   }
-- }

atajaronSuplentes :: [(String, String)] -> [Integer] -> Integer -> Integer
atajaronSuplentes xs gTitulares gt = gt - suma (gTitulares)

suma :: [Integer] -> Integer
suma [] = 0
suma (g : gs) = g + suma gs

-- 2) Equipos Válidos
-- problema equiposValidos (arquerosPorEquipo: seq<String X String>): Bool {
--   requiere: {True}
--   asegura: {
--   (res = True) <=> arquerosPorEquipo no contiene nombres de clubes repetidos, ni arqueros repetidos, ni jugadores con nombre del club
--   }
-- }

-- quiero verificar que no haya elementos repetidos en la secuencia de tuplas
equiposValidos :: [(String, String)] -> Bool
equiposValidos [] = True
equiposValidos ((x, y) : resto) = val1 (x, y) && val2 x resto && val2 y resto && equiposValidos resto
  where
    val1 :: (Eq str) => (str, str) -> Bool
    val1 (a, b) = x /= y

    val2 :: String -> [(String, String)] -> Bool
    val2 x xs = not (pertenece x (aplanar xs))

-- convierte de lista de tuplas a una lista con todos los elementos de las tuplas
aplanar :: [(String, String)] -> [String]
aplanar [] = []
aplanar ((a, b) : resto) = a : b : aplanar resto

-- retorna si un elemento pertenece a una lista o no
pertenece :: String -> [String] -> Bool
pertenece _ [] = False
pertenece e (x : xs) = e == x || pertenece e xs

-- 3) Porcentaje de goles
-- problema porcentajeDeGoles (arquero: String, arquerosPorEquipo: seq<String X String>, goles: seq<Z>): Reales {
--   requiere: {La segunda componente de algún elemento de arquerosPorEquipo es arquero}
--   requiere: {equiposValidos(arquerosPorEquipo)}
--   requiere: {|arquerosPorEquipo| = |goles|}
--   requiere: {Todos los elementos de goles son mayores o iguales a 0}
--   requiere: {Hay al menos un elemento de goles mayores estricto a 0}
--   asegura: {
--   res es el porcentaje de goles que recibió arquero sobre el total de goles recibidos por arqueros titulares
--   }
-- }

porcentajeDeGoles :: String -> [(String, String)] -> [Integer] -> Float
porcentajeDeGoles arquero ((eq, arqTit) : resto) (g : golesArqTit)
    | arquero == arqTit = porcentaje g (g : golesArqTit)
    | otherwise = porcentajeDeGoles arquero resto (golesArqTit ++ [g])
  where
    division :: Integer -> Integer -> Float
    division a b = fromIntegral a / fromIntegral b

    porcentaje :: Integer -> [Integer] -> Float
    porcentaje g gs = division g (suma gs) * 100


--
-- 4) Valla Menos Vencida
-- problema vallaMenosVencida (arquerosPorEquipo: seq<String X String>, goles: seq<Z>): String {
-- requiere: {equiposValidos(arquerosPorEquipo)}
-- requiere: {|arquerosPorEquipo| = |goles|}
-- requiere: {Todos los elementos de goles son mayores o iguales a 0}
-- requiere: {|goles| > 0}
-- asegura: {
-- res es alguno de los arqueros de arquerosPorEquipo que menor goles recibió de acuerdo a goles
-- }

vallaMenosVencida :: [(String, String)] -> [Integer] -> String
vallaMenosVencida [(a, b)] _ = b
vallaMenosVencida ((e1, arq1) : (e2, arq2) : resto) (g1 : g2 : gs)
    | g1 < g2 = vallaMenosVencida ((e1, arq1) : resto) (g1 : gs)
    | otherwise = vallaMenosVencida ((e2, arq2) : resto) (g2 : gs)
