sacarEspaciosRepetidos :: [Char] -> [Char]
sacarEspaciosRepetidos [] = []
sacarEspaciosRepetidos (x:[]) = [x]
sacarEspaciosRepetidos (x:y:xs) | x==y && x==' ' = sacarEspaciosRepetidos (y:xs)
                                | otherwise =  x:(sacarEspaciosRepetidos (y:xs) )
                                 
--sacarEspaciosRepetidos ['h','o','l','a',' ',' ','m','u','n','d','o']


contarPalabras :: [Char] -> Int
contarPalabras xs = contarEspacios (sacarEspaciosIniFin (sacarEspaciosRepetidos xs)) + 1

sacarEspaciosIniFin :: [Char] -> [Char]
sacarEspaciosIniFin [] = []
sacarEspaciosIniFin (x:xs) | x==' ' = sacarEspacioFin xs
                           | otherwise = x:(sacarEspacioFin xs) 

sacarEspacioFin :: [Char] -> [Char]
sacarEspacioFin [] = []
sacarEspacioFin (x:[]) | x==' ' = []
                       | otherwise = [x] 
sacarEspacioFin (x:xs) = x:(sacarEspacioFin xs)


contarEspacios :: [Char] -> Int
contarEspacios [] = 0
contarEspacios (x:xs) | x==' '= 1 + contarEspacios xs
                      | otherwise = contarEspacios xs


palabras :: [Char] -> [[Char]]
palabras xs = palabrasAux (sacarEspaciosIniFin (sacarEspaciosRepetidos xs))

palabrasAux :: [Char] -> [[Char]]
palabrasAux [] = []
palabrasAux (x:xs) = primeraPalabra (x:xs):(palabrasAux (sacarPrimeraPalabra (x:xs)))

primeraPalabra :: [Char] -> [Char]
primeraPalabra [] = []
primeraPalabra (x:xs) | x == ' ' = []
                      | otherwise = x:(primeraPalabra xs)                     

sacarPrimeraPalabra :: [Char] -> [Char]
sacarPrimeraPalabra [] = []
sacarPrimeraPalabra (x:xs) | x == ' ' = xs
                           | otherwise = sacarPrimeraPalabra xs  


palabraMasLarga :: [Char] -> [Char]
palabraMasLarga xs = palabraMasLargaAux (sacarEspaciosIniFin (sacarEspaciosRepetidos xs))

palabraMasLargaAux :: [Char] -> [Char]
palabraMasLargaAux xs | sacarPrimeraPalabra xs == [] = primeraPalabra xs
                      | length (primeraPalabra xs) > length (palabraMasLargaAux (sacarPrimeraPalabra xs)) = primeraPalabra xs
                      | otherwise = palabraMasLargaAux (sacarPrimeraPalabra xs) 
                      
                      
aplanar :: [[Char]] -> [Char]
aplanar [] = []
aplanar (xs:xss) = xs ++ (aplanar xss)
