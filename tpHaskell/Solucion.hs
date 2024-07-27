module Solucion where

import Data.Char

-- nombre de grupo: { algoRompimos 1 }
-- integrante1: { Daniel García Reparaz, nad.neutron@proton.me, 30926386 }
-- integrante2: { Franco Cataldi Gagliardi, franco-cataldi@hotmail.com, 46192347 }
-- integrante3: { Julieta Sol Valdez, julietavaldez04@gmail.com, 46027398 }
-- integrante4: { Julian Roberto Alvarez Windey, juroalwi@gmail.com, 42087602 }
-- integrantes que abandonaron la materia: {}

-- ========================
-- Funciones auxiliares globales (funciones que se usaron en distintos ejercicios).

-- Mapea 0 -> 'a', 1 -> 'b',...., 25 -> 'z'.
naturalALetra :: Int -> Char
naturalALetra n = chr (n + ord 'a') 

-- Devuelve lista con n (input) elementos con valor x (input).
listaDeNElementosIguales :: Int -> Float -> [Float]
listaDeNElementosIguales 0 x = []
listaDeNElementosIguales n x = x : listaDeNElementosIguales (n - 1) x


-- ========================
-- Resolución de ejercicios.

-- EJ 1
esMinuscula :: Char -> Bool
esMinuscula letra = ord 'a' <= ord letra && ord letra <= ord 'z'

-- EJ 2
letraANatural :: Char -> Int
letraANatural minuscula = ord minuscula - ord 'a'

-- EJ 3
desplazar :: Char -> Int -> Char
desplazar letra desplazamiento
    | esMinuscula letra = naturalALetra (minusculaAEnteroModulo25 letra desplazamiento)
    | otherwise = letra
    where
        -- Mapea (Int(minúscula) + desplazamiento) al correspondiente elemento de {0,..,25}.
        minusculaAEnteroModulo25 :: Char -> Int -> Int
        minusculaAEnteroModulo25 minuscula desplazamiento = mod (letraANatural minuscula + desplazamiento) 26

-- EJ 4
cifrar :: String -> Int -> String
cifrar [] _ = []
cifrar (primerLetra : mensajeRestante) desplazamiento = (desplazar primerLetra desplazamiento) : (cifrar mensajeRestante desplazamiento)

-- EJ 5
descifrar :: String -> Int -> String
descifrar mensajeCifrado desplazamiento = cifrar mensajeCifrado (-desplazamiento)

-- EJ 6
cifrarLista :: [String] -> [String]
cifrarLista mensajes = cifrarProgresivamenteDesde mensajes 0
    where
        cifrarProgresivamenteDesde :: [String] -> Int -> [String]
        cifrarProgresivamenteDesde [] _ = []
        cifrarProgresivamenteDesde (mensaje : mensajes) desplazamiento = cifrar mensaje desplazamiento : cifrarProgresivamenteDesde mensajes (desplazamiento + 1)

-- EJ 7
-- A partir de un string devuelve una lista de 26 elementos.
-- El i-ésimo elemento indica el promedio de apariciones en el string
-- de la i-ésima letra minúcula del abecedario.
frecuencia :: String -> [Float]
frecuencia string = promediarProgresivamenteDesde 0 string
    where
        -- Genera la lista de promedios.
        promediarProgresivamenteDesde :: Int -> String -> [Float]
        promediarProgresivamenteDesde posicion [] = listaDeNElementosIguales (26 - posicion) 0.0
        promediarProgresivamenteDesde posicion string
            | posicion >= 26 = []
            | otherwise = (100.0 * proporcionDeMinusculaEnString) : promediosDeMinusculasRestantes
            where
                proporcionDeMinusculaEnString 
                  | totalDeMinusculas == 0 = 0
                  | otherwise = division (frecuenciaDeMinusculaEnString (naturalALetra posicion) string) totalDeMinusculas
                totalDeMinusculas = cantidadDeMinusculas string

                -- Paso recursivo.
                promediosDeMinusculasRestantes = promediarProgresivamenteDesde (posicion + 1) string

                -- Divide dos enteros como si fueran números reales.
                division :: Int -> Int -> Float
                division n m = (fromIntegral n) / (fromIntegral m)

                -- Cantidad total de minusculas en el string input.
                cantidadDeMinusculas :: String -> Int
                cantidadDeMinusculas [] = 0
                cantidadDeMinusculas (primerLetra : stringRestante)
                    | esMinuscula primerLetra = 1 + cantidadDeMinusculasEnStringRestante
                    | otherwise = cantidadDeMinusculasEnStringRestante
                    where
                        cantidadDeMinusculasEnStringRestante = cantidadDeMinusculas stringRestante

                -- Cantidad de veces que aparece una minúscula en un string.
                frecuenciaDeMinusculaEnString :: Char -> String -> Int
                frecuenciaDeMinusculaEnString _ [] = 0
                frecuenciaDeMinusculaEnString minuscula (primerLetra : stringRestante)
                    | minuscula == primerLetra = 1 + frecuenciaMinusculaEnStringRestante
                    | otherwise = frecuenciaMinusculaEnStringRestante
                    where
                        frecuenciaMinusculaEnStringRestante = frecuenciaDeMinusculaEnString minuscula stringRestante

-- EJ 8
-- Detecta la minuscula de mayor frecuencia en el cifrado de str. Primero busca la frecuencia
-- más alta, y luego el índice de la misma. Finalmente, con el índice recupera la correspondiente letra minúscula.
cifradoMasFrecuente :: String -> Int -> (Char, Float)
cifradoMasFrecuente str n = (minusculaDeMayorFrecuencia, maximaFrecuencia)
    where
        frecuenciasEnCifrado = frecuencia (cifrar str n)
        maximaFrecuencia = maximoValorDeLista frecuenciasEnCifrado
        indiceDeMaximaFrecuencia = indiceDeElementoEnLista maximaFrecuencia frecuenciasEnCifrado
        minusculaDeMayorFrecuencia = naturalALetra indiceDeMaximaFrecuencia

        maximoValorDeLista :: [Float] -> Float
        maximoValorDeLista [valor] = valor
        maximoValorDeLista (primerValor:valoresRestantes)
            | primerValor >= maximoValorEnCola = primerValor
            | otherwise = maximoValorEnCola
            where maximoValorEnCola = maximoValorDeLista valoresRestantes
        indiceDeElementoEnLista elemento lista
            | elemento == head lista = 0
            | otherwise = 1 + indiceDeElementoEnLista elemento (tail lista)

-- EJ 9
-- Analiza si s2 es el resultado de cifrar s1 con algun n (desde 0 hasta 25).
-- Es decir, hay 26 posibles valores de n.
esDescifrado :: String -> String -> Bool
esDescifrado s1 s2 = esDescifradoAux s1 s2 0
    where
        -- Esta funcion toma dos strings y chequea si cifrar s1 n veces es igual a s2 
        -- para algún n. Se parte desde 0 y se hace recursión sobre n hasta llegar al caso
        -- base n = 26, el cual nos garantiza (habiéndose validado los valores de n anteriores)
        -- que no hay cifrado que haga que las listas coincidan.
        esDescifradoAux :: String -> String -> Int -> Bool
        esDescifradoAux _ _ 26 = False
        esDescifradoAux s1 s2 n
            | cifrar s1 n == s2 = True
            | otherwise = esDescifradoAux s1 s2 (n + 1)

-- EJ 10
-- input: todos distintos
-- res: ¡OJO!todos distintos, no hay cosas de la forma ("abc","abc"), pero sí ("AB","AB"),
-- las palabras que aparezcan tienen que siempre estar en el input. res puede tener
-- permutaciones de una misma tupla. Es lo mismo en este ejercicio que
-- "s1 = cifrar s2 n" o "s1 = descifrar s2 n"
todosLosDescifrados :: [String] -> [(String, String)]
todosLosDescifrados [] = []
todosLosDescifrados ls = buscoParesCifradosDeLista ls ls
    where
        -- Toma dos listas y compara sus elementos. La comparación es
        -- para encontrar pares cifrados.
        buscoParesCifradosDeLista :: [String] -> [String] -> [(String, String)]
        buscoParesCifradosDeLista [] _ = []
        buscoParesCifradosDeLista (x : xs) ys =
            buscoParesCifradosDeX x ys ++ buscoParesCifradosDeLista xs ys

        -- Devuelve los pares donde aparece el string de entrada
        -- como primera coordenada del par.
        buscoParesCifradosDeX :: String -> [String] -> [(String, String)]
        buscoParesCifradosDeX _ [] = []
        buscoParesCifradosDeX x (y : ys)
            | todasMayusculas x = [(x,x)] -- Cumple asegura SI NO HAY MINÚSCULAS.
            | x /= y  && esDescifrado x y = (x, y) : pasoRec
            | otherwise = pasoRec
            where
                pasoRec = buscoParesCifradosDeX x ys

                -- String (input) no tiene minúsculas -> True
                todasMayusculas :: String -> Bool
                todasMayusculas [] = True
                todasMayusculas (c:cs) = not (esMinuscula c) && todasMayusculas cs

-- EJ 11
expandirClave :: String -> Int -> String
expandirClave clave 1 = [(head clave)]
expandirClave clave n = [(head clave)] ++ (expandirClave ((tail clave) ++ [(head clave)]) (n - 1))

-- EJ 12
-- Primero expande la clave para que su longitud coincida con la del string a cifrar. Luego se
-- realiza el cifrado lugar a lugar
cifrarVigenere :: String -> String -> String
cifrarVigenere string clave = cifrarVigenereAux string (expandirClave clave (length string))

cifrarVigenereAux :: String -> String -> String
cifrarVigenereAux "" _ = ""
cifrarVigenereAux (s1 : s) (cl1 : clave) = (desplazar s1 (letraANatural cl1)) : (cifrarVigenereAux s clave)

-- EJ 13
descifrarVigenere :: String -> String -> String
descifrarVigenere s clave = descifrarVigenereAux s (expandirClave clave (length s))

descifrarVigenereAux :: String -> String -> String
descifrarVigenereAux "" _ = ""
descifrarVigenereAux (s1 : s) (cl1 : clave) = (desplazar s1 (-(letraANatural cl1))) : (descifrarVigenereAux s clave)

-- EJ 14
-- Busca el peor cifrado calculando la distancia entre el string original y el string cifrado
-- para cada clave ingresada como input. La distancia entre dos secuencias se calcula como
-- la suma de las distancias letra a letra.
peorCifrado :: String -> [String] -> String
peorCifrado s [clave] = clave
peorCifrado s (clave:clavesDeCola)
  |  distanciaEntreSecuencias s (cifrarVigenere s clave) <= distanciaEntreSecuencias s (cifrarVigenere s peorCifradoDeCola) = clave
  |  otherwise = peorCifradoDeCola
     where peorCifradoDeCola = peorCifrado s clavesDeCola

distanciaEntreSecuencias :: [Char] -> [Char] -> Int
distanciaEntreSecuencias [] [] = 0
distanciaEntreSecuencias s1 s2 = distanciaEntreMinusculas (head s1) (head s2) + distanciaEntreSecuencias (tail s1) (tail s2)

distanciaEntreMinusculas  :: Char -> Char -> Int
distanciaEntreMinusculas m1 m2 = valorAbsoluto(letraANatural m1 - letraANatural m2)

valorAbsoluto :: Int -> Int
valorAbsoluto n
 |  n >= 0 = n
 |  otherwise = -n

-- EJ 15
combinacionesVigenere :: [String] -> [String] -> String -> [(String, String)]
combinacionesVigenere [] claves cifrado = []
combinacionesVigenere msjs claves cifrado =
    (combinacionesValidasDeMsj (head msjs) claves cifrado)
        ++ (combinacionesVigenere (tail msjs) claves cifrado)

-- Dado un mensaje fijo calcula cuáles son las claves que cifran al mensaje
-- de forma tal que el resultado es igual a 'cifrado'.
combinacionesValidasDeMsj :: String -> [String] -> String -> [(String, String)]
combinacionesValidasDeMsj msj [] cifrado = []
combinacionesValidasDeMsj msj claves cifrado
    | cifrarVigenere msj (head claves) == cifrado =
        (msj, head (claves)) : combinacionesValidasRestantesDeMsj
    | otherwise = combinacionesValidasRestantesDeMsj
    where
        combinacionesValidasRestantesDeMsj = (combinacionesValidasDeMsj msj (tail claves) cifrado)
