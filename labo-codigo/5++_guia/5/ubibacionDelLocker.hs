import Test.HUnit
import Tipos5

ubicacionDelLocker :: Identificacion -> MapaDeLockers -> Ubicacion
ubicacionDelLocker _ [] = "No existe"
ubicacionDelLocker id ((idL, (_, ubicacion)) : mLs)
    | id == idL = ubicacion
    | otherwise = ubicacionDelLocker id mLs

-- Testing

main :: IO ()
main = do
    runTestTT $ TestList [testList_ubicacionDelLocker]
    return ()

listaCasos_uDelLocker :: [(Ubicacion, (Identificacion, MapaDeLockers))]
listaCasos_uDelLocker =
    [ ("ZD39I", (100, lockers))
    , ("No existe", (10222, lockers))
    , ("99292", (110, lockers))
    , ("No existe", (100, []))
    ]

-- Para un elemento de la lista de casos, genero un Test
makeTest :: (Ubicacion, (Identificacion, MapaDeLockers)) -> Test
makeTest (expected, (id, mLs)) =
    TestCase
        ( assertEqual
            ( "++++++\n¡Error en caso con:\ninput 1:\n" ++ show id ++ "\ninput 2:\n" ++ show mLs ++ " !\n++++++\n"
            )
            expected
            (ubicacionDelLocker id mLs)
        )

-- Genero una lista de tests usando la lista de casos y la funcion que genera los
-- casos a partir de esta última
testList_ubicacionDelLocker :: Test
testList_ubicacionDelLocker = TestList (map makeTest listaCasos_uDelLocker)
