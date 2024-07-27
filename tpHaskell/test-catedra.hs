import Test.HUnit
import Solucion
import Data.List

-- No está permitido agregar nuevos imports.

runCatedraTests = runTestTT allTests

allTests =
    test
        [ "esMinuscula" ~: testsEjesMinuscula,
          "letraANatural" ~: testsEjletraANatural,
          "desplazar" ~: testsEjdesplazar,
          "cifrar" ~: testsEjcifrar,
          "descifrar" ~: testsEjdescifrar,
          "cifrarLista" ~: testsEjcifrarLista,
          "frecuencia" ~: testsEjfrecuencia,
          "cifradoMasFrecuente" ~: testsEjcifradoMasFrecuente,
          "esDescifrado" ~: testsEjesDescifrado,
          "todosLosDescifrados" ~: testsEjtodosLosDescifrados,
          "expandirClave" ~: testsEjexpandirClave,
          "cifrarVigenere" ~: testsEjcifrarVigenere,
          "descifrarVigenere" ~: testsEjdescifrarVigenere,
          "peorCifrado" ~: testsEjpeorCifrado,
          "combinacionesVigenere" ~: testsEjcombinacionesVigenere
        ]

testsEjesMinuscula =
    test
        [ esMinuscula 'd' ~?= True, -- dado en el template
          esMinuscula 'A' ~?= False, -- en el ASCII aparece antes
          esMinuscula '?' ~?= False, -- en el ASCII aparece despues
          esMinuscula 'a' ~?= True, -- compruebo que este incluido
          esMinuscula 'z' ~?= True -- compruebo que este incluido
        ]

testsEjletraANatural =
    test
        [ letraANatural 'b' ~?= 1, -- dado en el template
          letraANatural 'a' ~?= 0, -- compruebo que arranca en 0
          letraANatural 'z' ~?= 25, -- compruebo que termina en 25
          letraANatural 'm' ~?= 12 -- compruebo que no haya errores en las letras del medio
        ]

testsEjdesplazar =
    test
        [ desplazar 'a' 3 ~?= 'd', -- dado en el template
          desplazar 'A' 4 ~?= 'A', -- caso mayuscula positivo
          desplazar 'J' (-2) ~?= 'J', -- caso mayuscula negativo
          desplazar 'd' (-5) ~?= 'y', -- negativo y termina el abecedario por lo que tiene que ir a la 'z' y seguir desde ahi
          desplazar 'c' 28 ~?= 'e', -- numero mayor a la cantidad de letras en el abecedario
          desplazar ' ' 5 ~?= ' ', -- desplazar un "espacio"
          desplazar 'ñ' 1 ~?= 'ñ' -- desplazar un caracter que no es minuscula
        ]

testsEjcifrar =
    test
        [ cifrar "computacion" 3 ~?= "frpsxwdflrq", -- dado en el template, todas minusculas
          cifrar "proGRAma" 4 ~?= "tvsGRAqe", -- algunas mayusculas y algunas minusculas
          cifrar "PROGRAMA" 8 ~?= "PROGRAMA", -- todas mayusculas
          cifrar "programa" 27 ~?= "qsphsbnb" -- numero mayor a la cantidad de letras en abecedario
        ]

testsEjdescifrar =
    test
        [ descifrar "frpsxwdflrq" 3 ~?= "computacion", -- caso template
          descifrar "tvsGRAqe" 4 ~?= "proGRAma", -- todos los demas es descifrando lo anteriormente cifrado.....
          descifrar "PROGRAMA" 8 ~?= "PROGRAMA",
          descifrar "qsphsbnb" 27 ~?= "programa"
        ]

testsEjcifrarLista =
    test
        [ --
          -- dado en el template
          cifrarLista ["compu", "labo", "intro"] ~?= ["compu", "mbcp", "kpvtq"],
          -- pruebo que no me cifre las mayusculas
          cifrarLista ["compu", "lABo", "intro"] ~?= ["compu", "mABp", "kpvtq"],
          -- caso lista vacia
          cifrarLista [] ~?= [],
          -- una unica palabra
          cifrarLista ["compu"] ~?= ["compu"],
          -- pruebo con mayor cantidad y con una palabra entera en mayuscula
          cifrarLista ["labo", "compu", "INTRO", "CasA"]
            ~?= ["labo", "dpnqv", "INTRO", "CdvA"],
          -- caso todas mayus menos 1 (chequea que efectivamente no cifre mayus y si minus si hay mayus y min)
          cifrarLista ["LABO", "COMPU", "INTRO", "CASa"]
            ~?= ["LABO", "COMPU", "INTRO", "CASd"]
        ]

-- =======================================================================================
-- =======================================================================================
-- ACLARACIONES PARA LOS TESTS DE Ejfrecuencia:
-- LAS LISTAS SON RENOMBRADAS PARA FACILITAR LA LECTURA, A CONTINUACION LAS PRESENTAMOS
-- La función listaDeNElementosIguales está definida en el módulo Solucion.hs.

-- nombramos las listas y usamos la función listaDeNElementosIguales para armarlas más fácilmente.
f_taller = [ 16.666668, 0.0, 0.0, 0.0, 16.666668, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 33.333336, 0.0,
                          0.0, 0.0, 0.0, 0.0, 16.666668, 0.0, 16.666668, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ]

f_sinMinusculas = (listaDeNElementosIguales 26 0.0)

f_abcdefghijklmnopqrstuvwxyz = (listaDeNElementosIguales 26 3.846154)

f_abcdefghijklmnopqrstuvwXYZ = listaDeNElementosIguales 23 4.347826 ++ [0, 0, 0]

f_n = (listaDeNElementosIguales 13 0.0) ++ [100.0] ++ (listaDeNElementosIguales 12 0.0)

f_palpAL = [25.0] ++ listaDeNElementosIguales 10 0.0 ++ [25.0] ++ (listaDeNElementosIguales 3 0.0) ++ [50.0] ++ listaDeNElementosIguales 10 0.0
-- FIN ACLARICIONES
-- =======================================================================================
-- =======================================================================================

testsEjfrecuencia =
    test
        [ --
          -- dado en el template
          expectlistProximity (frecuencia "taller") f_taller,
          -- caso lista vacia
          expectlistProximity (frecuencia "") f_sinMinusculas,
          -- una vez cada letra
          expectlistProximity (frecuencia "abcdefghijklmnopqrstuvwxyz") f_abcdefghijklmnopqrstuvwxyz,
          -- chequeo que no me cuente las mayusculas
          expectlistProximity (frecuencia "abcdefghijklmnopqrstuvwxyzABCDEFGHI") f_abcdefghijklmnopqrstuvwxyz,
          -- lo mismo que la anterior pero para probar que me cuente bien en que posiciones estan
          expectlistProximity (frecuencia "abcdefghijklmnopqrstuvwXYZ") f_abcdefghijklmnopqrstuvwXYZ,
          -- un solo caracter
          expectlistProximity (frecuencia "n") f_n,
          -- mezcla de todo lo anterior, pruebo que me de con distintos valores
          expectlistProximity (frecuencia "palpAL") f_palpAL,
          -- si no hay letras minúsculas todo debe ser 0  
          expectlistProximity (frecuencia "SIN_MINUSCULAS") f_sinMinusculas
        ]

testsEjcifradoMasFrecuente =
    test
        [ --
          -- dado en el template
          expectAnyTuplaAprox (cifradoMasFrecuente "taller" 3) [('o', 33.333338)],
          -- cuando es un String de un solo caracter (caso base)
          expectAnyTuplaAprox (cifradoMasFrecuente "s" 2)  [('u', 100.000001)],
          -- Las mayúsculas no influyen en el resultado.
          -- Si hay minúsculas con MISMA FRECUENCIA -> cualquiera está bien.
          expectAnyTuplaAprox (cifradoMasFrecuente "taLLer" 3) [('w', 25.0), ('d', 25.000001), ('h', 25.0), ('u', 25.0)],
          expectAnyTuplaAprox (cifradoMasFrecuente "st" 4) [('v', 50.000001), ('w', 50.000001)]
        ]

testsEjesDescifrado =
    test
        [ --
          esDescifrado "taller" "compu" ~?= False, -- dado en el template
          esDescifrado "pepe" "zozo" ~?= True, -- pruebo un caso que sea verdadero
          esDescifrado "zozo" "pepe" ~?= True, -- pruebo que no me modifique el orden en que pongo las palabras
          esDescifrado "pEpe" "zozo" ~?= False, -- pruebo que no me tome mayusculas
          esDescifrado "" "" ~?= True, -- caso ambas listas vacias
          esDescifrado "" "hola" ~?= False, -- cualquier string con lista vacia
          esDescifrado "hola" "" ~?= False, -- vacio es descifrado de string
          esDescifrado "Pepe" "Pjuj" ~?= True, -- la mayuscula en el principio del string
          esDescifrado "pepE" "ujuE" ~?= True, -- la mayuscula en el final del string
          esDescifrado "AAaAA" "AAzAA" ~?= True -- minuscula entre mayusculas
        ]

testsEjtodosLosDescifrados =
    test
        [ --
          -- Ejercicio template pero aceptando todas las posibles implementaciones correctas.
          expectPermutacion (todosLosDescifrados ["compu", "frpsx", "mywza"]) [("compu", "frpsx"), ("frpsx", "compu")],
          -- Si #(elem[i]) = 1, tendrá un par con cada otro elemento #(elem[j]) = 1 con j distinto i
          -- Si elem NO tiene minúsculas, tendrá un par con sí mismo.
          -- elem = "" es igual a si mismo cifrado para cualquier n.
          expectPermutacion
            (todosLosDescifrados ["a", "b", "ab", "A", "HOLA", ""])
            [("a", "b"), ("b", "a"), ("A", "A"), ("HOLA", "HOLA"), ("", "")],
          -- Si elem tiene UNA minúsuculas Y UN par, también estará la permutación.
          -- elem TODO mayus juega con sí mismo.
          expectPermutacion
            (todosLosDescifrados ["Compu", "Crpsx", "ab", "yz", "foreveraalone", "EGO"])
            [("Compu", "Crpsx"), ("Crpsx", "Compu"), ("ab", "yz"), ("yz", "ab"), ("EGO", "EGO")]
        ]

testsEjexpandirClave =
    test
        [ expandirClave "compu" 8 ~?= "compucom", -- caso template
          expandirClave "a" 1 ~?= "a", -- caso string un elemento
          expandirClave "a" 5 ~?= "aaaaa", -- caso string se amplifica
          expandirClave "abc" 1 ~?= "a", -- string de mas de un elemento queda igual
          expandirClave "abc" 3 ~?= "abc", -- string de mas de un elemento queda igual con n > 1
          expandirClave "abc" 6 ~?= "abcabc", -- string de mas de un elemento se amplifica
          expandirClave "abcdefghij" 10 ~?= "abcdefghij", -- string muy extenso, se queda igual
          expandirClave "hola" 12 ~?= "holaholahola" -- string de 4 caracteres, se reescribe dos veces enteras
        ]

testsEjcifrarVigenere =
    test
        [ cifrarVigenere "computacion" "ip" ~?= "kdueciirqdv", -- caso template
          cifrarVigenere "a" "a" ~?= "a", -- caso devuelve lo mismo
          cifrarVigenere "b" "b" ~?= "c", -- caso devuelve la clave modificada
          cifrarVigenere "a" "z" ~?= "z", -- caso devuelve la clave sin modificar
          cifrarVigenere "zzzz" "b" ~?= "aaaa", -- caso modifica el string de input
          cifrarVigenere "hola" "llave" ~?= "szlv" -- caso cifrado vigenere completo
        ]

testsEjdescifrarVigenere =
    test
        [ descifrarVigenere "kdueciirqdv" "ip" ~?= "computacion", -- caso template
          descifrarVigenere "a" "a" ~?= "a", -- los casos a continuacion son descifrando lo previamente cifrado....
          descifrarVigenere "c" "b" ~?= "b",
          descifrarVigenere "z" "a" ~?= "z",
          descifrarVigenere "m" "m" ~?= "a",
          descifrarVigenere "aaaa" "b" ~?= "zzzz",
          descifrarVigenere "szlv" "llave" ~?= "hola"
        ]

testsEjpeorCifrado =
    test
        [ peorCifrado "computacion" ["ip", "asdef", "ksy"] ~?= "asdef", -- caso template
          peorCifrado "hola" ["abc", "xyz", "pqr"] ~?= "abc", -- caso devuelve primer elemento
          peorCifrado " " ["abc", "xyz", "pqr"] ~?= "abc", -- caso primer input vacio
          peorCifrado "woqpeoqwpeopqwe" ["hola", "mundo", "test"] ~?= "test", -- caso devuelve tercer elemento
          peorCifrado "abcd" ["o", "b", "p"] ~?= "b" -- caso devuelve segundo elemento
        ]

testsEjcombinacionesVigenere =
    test
        [ --
          -- caso template
          combinacionesVigenere ["hola", "mundo"] ["a", "b"] "ipmb" ~?= [("hola", "b")],
          -- #(cifrado) distinto de #(msjs[i])  para todo i -> [].
          combinacionesVigenere ["hola"] ["abc"] "plasdfvx" ~?= [],
          -- Los requiere sobre los elementos no importan cuando no hay elementos (☞⌐▀͡ ͜ʖ͡▀ )☞
          combinacionesVigenere [] [] "" ~?= [],
          -- existe combinación posible
          combinacionesVigenere ["hola"] ["a", "b", "c", "d", "abc"] "hpna" ~?= [("hola", "abc")],
          -- #(msjs) > 0 y una combinación posible con mayúsculas
          combinacionesVigenere ["AhBoClDaE", "mundo"] ["abc", "def"] "AlBrCqDeE" ~?= [("AhBoClDaE", "def")],
          -- más de una combinación posible
          expectPermutacion (combinacionesVigenere ["Abb", "Aaa"] ["b", "a"] "Abb") [("Aaa", "b"), ("Abb", "a")],
          -- elementos de mensaje TODO MAYUS, cifrado = msjs[i] para algun i  -> Un par por cada CLAVE
          expectPermutacion
            (combinacionesVigenere ["TUFILLO", "YOMAMA"] ["a", "b", "and", "so", "on"] "TUFILLO")
            [("TUFILLO", "a"), ("TUFILLO", "b"), ("TUFILLO", "and"), ("TUFILLO", "so"), ("TUFILLO", "on")]
        ]

-- Funciones útiles

-- margetFloat(): Float
-- asegura: res es igual a 0.00001
margenFloat = 0.00001

-- expectAny (actual: a, expected: [a]): Test
-- asegura: res es un Test Verdadero si y sólo si actual pertenece a la lista expected
expectAny :: (Foldable t, Eq a, Show a, Show (t a)) => a -> t a -> Test
expectAny actual expected =
    elem actual expected
        ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)

-- expectlistProximity (actual: [Float], expected: [Float]): Test
-- asegura: res es un Test Verdadero si y sólo si:
--                  |actual| = |expected|
--                  para todo i entero tal que 0<=i<|actual|, |actual[i] - expected[i]| < margenFloat()
expectlistProximity :: [Float] -> [Float] -> Test
expectlistProximity actual expected =
    esParecidoLista actual expected
        ~? ("expected list: " ++ show expected ++ "\nbut got: " ++ show actual)

esParecidoLista :: [Float] -> [Float] -> Bool
esParecidoLista actual expected = (length actual) == (length expected) && (esParecidoUnaAUno actual expected)

esParecidoUnaAUno :: [Float] -> [Float] -> Bool
esParecidoUnaAUno [] [] = True
esParecidoUnaAUno (x : xs) (y : ys) = (aproximado x y) && (esParecidoUnaAUno xs ys)

aproximado :: Float -> Float -> Bool
aproximado x y = abs (x - y) < margenFloat

-- expectAnyTuplaAprox (actual: CharxFloat, expected: [CharxFloat]): Test
-- asegura: res un Test Verdadero si y sólo si:
--                  para algun i entero tal que 0<=i<|expected|,
--                         (fst expected[i]) == (fst actual) && |(snd expected[i]) - (snd actual)| < margenFloat()

expectAnyTuplaAprox :: (Char, Float) -> [(Char, Float)] -> Test
expectAnyTuplaAprox actual expected =
    elemAproxTupla actual expected
        ~? ("expected any of: " ++ show expected ++ "\nbut got: " ++ show actual)

elemAproxTupla :: (Char, Float) -> [(Char, Float)] -> Bool
elemAproxTupla _ [] = False
elemAproxTupla (ac, af) ((bc, bf) : bs) = sonAprox || (elemAproxTupla (ac, af) bs)
    where
        sonAprox = (ac == bc) && (aproximado af bf)

-- expectPermutacion (actual: [T], expected[T]) : Test
-- asegura: res es un Test Verdadero si y sólo si:
--            para todo elemento e de tipo T, #Apariciones(actual, e) = #Apariciones(expected, e)

expectPermutacion :: (Ord a, Show a) => [a] -> [a] -> Test
expectPermutacion actual expected =
    esPermutacion actual expected
        ~? ("expected list: " ++ show expected ++ "\nbut got: " ++ show actual)

esPermutacion :: (Ord a) => [a] -> [a] -> Bool
esPermutacion a b = (length a == length b) && (sort a == sort b)
