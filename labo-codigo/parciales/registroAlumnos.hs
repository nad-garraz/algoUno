aproboMasDeNMaterias :: [(String, [Integer])] -> String -> Integer -> Bool
aproboMasDeNMaterias [] _ _ = False
aproboMasDeNMaterias ((alumno, notas) : resto) nombre n
    | nombre == alumno && notaGEQ4 notas >= n = True
    | otherwise = aproboMasDeNMaterias resto nombre n

notaGEQ4 :: [Integer] -> Integer
notaGEQ4 [] = 0
notaGEQ4 (n : ns)
    | n >= 4 = 1 + notaGEQ4 ns
    | otherwise = notaGEQ4 ns

buenosAlumnos :: [(String, [Integer])] -> [String]
buenosAlumnos [] = []
buenosAlumnos ((nombre, notas) : resto)
    | notaGEQ4 notas > (long notas - 1 ) && promedio notas >= 8 = nombre : buenosAlumnos resto
    | otherwise = buenosAlumnos resto

promedio :: [Integer] -> Float
promedio ns = dividir (sum ns) (long ns)

sumar :: [Integer] -> Integer
sumar [] = 0
sumar (n : ns) = n + sumar ns

long :: [Integer] -> Integer
long [] = 0
long (n : ns) = 1 + long ns

dividir :: Integer -> Integer -> Float
dividir n m = fromIntegral n / fromIntegral m

mejorPromedio :: [(String, [Integer])] -> String
mejorPromedio (r : []) = fst r
mejorPromedio ((alumno1, notas1) : (alumno2, notas2) : resto)
    | promedio notas1 >= promedio notas2 = mejorPromedio ((alumno1, notas1) : resto)
    | otherwise = mejorPromedio ((alumno2, notas2) : resto)

seGraduoConHoneres :: [(String, [Integer])] ->  String -> Integer -> Bool
seGraduoConHoneres (x:[]) _ _ = False
seGraduoConHoneres registro alumno cantidadDeMaterias 
    | aproboMasDeNMaterias registro alumno (cantidadDeMaterias - 1) && inBuenosAlumnos alumno (buenosAlumnos registro) && (promedioAlumno alumno registro - 1) < promedioAlumno (mejorPromedio registro) registro = True
    | otherwise = seGraduoConHoneres (tail registro) alumno cantidadDeMaterias
  where
    inBuenosAlumnos :: String -> [String] -> Bool
    inBuenosAlumnos _ [] = False
    inBuenosAlumnos alumno (buenA : buenAs) = alumno == buenA || inBuenosAlumnos alumno buenAs

    promedioAlumno :: String -> [(String, [Integer])] -> Float
    promedioAlumno alumno (x : resto)
        | alumno == fst x = promedio (snd x)
        | otherwise = promedioAlumno alumno resto



registro :: [(String, [Integer])]
registro = [("a", [1,2,3,1]),("brain",[10,9,10]), ("ramon", [3,4,5]), ("noNerd",[5,6,7]), ("nerda",[8,9,10]), ("nerdo", [10,10,9])]
registro1 = [("nerdo", [10,10,9,10])]
registro2 = [("brain",[10,9,10]), ("ramon", [3,4,5])]
