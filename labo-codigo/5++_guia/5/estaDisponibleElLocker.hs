import Test.HUnit
import Tipos5

estaDisponibleElLocker :: Identificacion -> MapaDeLockers -> Bool 
estaDisponibleElLocker _ [] = False
estaDisponibleElLocker id ((idL, (disponibilidad, _)) : mLs)
    | id == idL = show disponibilidad == "Libre"
    | otherwise = estaDisponibleElLocker id mLs


--testing
main :: IO ()
main = do
    runTestTT $ TestList [testList_estaDisponibleElLocker]
    return ()


listaCasos_uDelLocker :: [(Bool, (Identificacion, MapaDeLockers))]
listaCasos_uDelLocker =
    [ (False, (10, lockers))
    , (False, (10222, lockers))
    , (False, (110, lockers))
    , (True, (105, lockers))
    , (True, (103, lockers))
    , (False, (100, []))
    ]

-- Para un elemento de la lista de casos, genero un Test
makeTest :: (Bool, (Identificacion, MapaDeLockers)) -> Test
makeTest (expected, (id, mLs)) =
    TestCase
        ( assertEqual
            ( "++++++\n¡Error en caso con:\ninput 1:\n" ++ show id ++ "\ninput 2:\n" ++ show mLs ++ " !\n++++++\n"
            )
            expected
            (estaDisponibleElLocker id mLs)
        )

-- Genero una lista de tests usando la lista de casos y la funcion que genera los
-- casos a partir de esta última
testList_estaDisponibleElLocker :: Test
testList_estaDisponibleElLocker = TestList (map makeTest listaCasos_uDelLocker)
