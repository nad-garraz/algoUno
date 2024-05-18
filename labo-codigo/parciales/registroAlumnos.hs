--
-- [Integer] tiene valores entre [0-10]
-- n está entre (1 - infinito)
-- String está en la tupla sí o sí
-- tengo que debolver true o false si leyendo todas las notas,  n son >=4
aproboMasDeNMaterias :: [(String, [Integer])] -> String -> Integer -> Bool
aproboMasDeNMaterias [] _ _ = False -- nadie aprobó más de n
aproboMasDeNMaterias ((alumno, notas) : resto) nombre n
    | alumno == nombre && materiasAprobadas notas > n = True
    | otherwise = aproboMasDeNMaterias resto nombre n

materiasAprobadas :: [Integer] -> Integer
materiasAprobadas [] = 0
materiasAprobadas (x : xs)
    | x >= 4 = 1 + materiasAprobadas xs
    | otherwise = materiasAprobadas xs

-- lista de nombres de alumnos cuyo promedio de notas es mayor o iugal a 8 y no tiene aplazos

buenosAlumnos :: [(String, [Integer])] -> [String]
buenosAlumnos [] = []
buenosAlumnos ((nombre, notas) : resto)
    | materiasAprobadas notas == long notas && promedio notas >= 8 = nombre : buenosAlumnos resto
    | otherwise = buenosAlumnos resto

long :: [Integer] -> Integer
long [] = 0
long (x : xs) = 1 + long xs

promedio :: [Integer] -> Float
promedio lista = division (suma lista) (long lista)

suma :: [Integer] -> Integer
suma [] = 0
suma (x : xs) = x + suma xs

division :: Integer -> Integer -> Float
division n m = (fromIntegral n) / (fromIntegral m)

mejorPromedio :: [(String, [Integer])] -> String
mejorPromedio (x : []) = fst x
mejorPromedio ((a1, n1) : (a2, n2) : resto)
    | promedio n1 >= promedio n2 = mejorPromedio ((a1, n1) : resto)
    | otherwise = mejorPromedio ((a2, n2) : resto)

seGraduoConHonores :: [(String, [Integer])] -> Integer -> String -> Bool
seGraduoConHonores reg qMaterias alumno = aproboMasDeNMaterias reg alumno (qMaterias - 1) &&
          pertenece alumno (buenosAlumnos reg) && 
          promedio (notasDeAlumno reg (mejorPromedio reg)) - promedio (notasDeAlumno reg alumno) < 1

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece x (y : ys) = x == y || pertenece x ys

notasDeAlumno :: [(String, [Integer])] -> String -> [Integer]
notasDeAlumno ((nombre, notas) : resto) alumno
    | nombre == alumno = notas
    | otherwise = notasDeAlumno resto alumno




-- aproboMasDeNMaterias :: [(String, [Integer])] -> String -> Integer -> Bool
-- aproboMasDeNMaterias [] _ _ = False
-- aproboMasDeNMaterias ((alumno, notas) : resto) nombre n
--     | nombre == alumno && notaGEQ4 notas >= n = True
--     | otherwise = aproboMasDeNMaterias resto nombre n
--
-- notaGEQ4 :: [Integer] -> Integer
-- notaGEQ4 [] = 0
-- notaGEQ4 (n : ns)
--     | n >= 4 = 1 + notaGEQ4 ns
--     | otherwise = notaGEQ4 ns
--
-- buenosAlumnos :: [(String, [Integer])] -> [String]
-- buenosAlumnos [] = []
-- buenosAlumnos ((nombre, notas) : resto)
--     | notaGEQ4 notas > (long notas - 1 ) && promedio notas >= 8 = nombre : buenosAlumnos resto
--     | otherwise = buenosAlumnos resto
--
-- promedio :: [Integer] -> Float
-- promedio ns = dividir (sum ns) (long ns)
--
-- sumar :: [Integer] -> Integer
-- sumar [] = 0
-- sumar (n : ns) = n + sumar ns
--
-- long :: [Integer] -> Integer
-- long [] = 0
-- long (n : ns) = 1 + long ns
--
-- dividir :: Integer -> Integer -> Float
-- dividir n m = fromIntegral n / fromIntegral m
--
-- mejorPromedio :: [(String, [Integer])] -> String
-- mejorPromedio (r : []) = fst r
-- mejorPromedio ((alumno1, notas1) : (alumno2, notas2) : resto)
--     | promedio notas1 >= promedio notas2 = mejorPromedio ((alumno1, notas1) : resto)
--     | otherwise = mejorPromedio ((alumno2, notas2) : resto)
--
-- seGraduoConHoneres :: [(String, [Integer])] ->  String -> Integer -> Bool
-- seGraduoConHoneres (x:[]) _ _ = False
-- seGraduoConHoneres registro alumno cantidadDeMaterias
--     | aproboMasDeNMaterias registro alumno (cantidadDeMaterias - 1) && inBuenosAlumnos alumno (buenosAlumnos registro) && (promedioAlumno alumno registro - 1) < promedioAlumno (mejorPromedio registro) registro = True
--     | otherwise = seGraduoConHoneres (tail registro) alumno cantidadDeMaterias
--   where
--     inBuenosAlumnos :: String -> [String] -> Bool
--     inBuenosAlumnos _ [] = False
--     inBuenosAlumnos alumno (buenA : buenAs) = alumno == buenA || inBuenosAlumnos alumno buenAs
--
--     promedioAlumno :: String -> [(String, [Integer])] -> Float
--     promedioAlumno alumno (x : resto)
--         | alumno == fst x = promedio (snd x)
--         | otherwise = promedioAlumno alumno resto
--
--
--
registro :: [(String, [Integer])]
registro = [("a", [1, 2, 3, 1]), ("brain", [10, 9, 10]), ("ramon", [3, 4, 5]), ("noNerd", [5, 6, 7]), ("nerda", [8, 9, 10]), ("nerdo", [10, 10, 9])]
registro1 = [("nerdo", [10, 10, 9, 10])]
registro2 = [("brain", [10, 9, 10]), ("ramon", [3, 4, 5])]

pri :: (Integer,Integer,Integer) -> Integer
pri (a,b,c) = a
ter (a,b,c) = c
