import Test.HUnit
import Tipos5

ocuparLocker :: Identificacion -> MapaDeLockers -> MapaDeLockers
ocuparLocker _ [] = []
ocuparLocker id ((idl, (disp, ubi)) : mls)
    | id == idl && disp == Libre = (idl, (Ocupado, ubi)) : ocuparLocker id mls
    | id == idl && disp == Ocupado = (idl, (Libre, ubi)) : ocuparLocker id mls
    | otherwise = (idl, (disp, ubi)) : ocuparLocker id mls

-- testing
main :: IO ()
main = do
    runTestTT $ TestList [testList_estaDisponibleElLocker]
    return ()

lockers2 :: MapaDeLockers
lockers2 =
    [ (100, (Ocupado, "ZD39I"))
    , (101, (Ocupado, "JAH3I"))
    , (103, (Libre, "IQSA9"))
    , (105, (Libre, "QOTSA"))
    , (109, (Ocupado, "893JJ"))
    , (110, (Ocupado, "99292"))
    ]

lockers3 :: MapaDeLockers
lockers3 =
    [ (100, (Ocupado, "ZD39I"))
    , (101, (Libre, "JAH3I"))
    , (103, (Ocupado, "IQSA9"))
    , (105, (Libre, "QOTSA"))
    , (109, (Ocupado, "893JJ"))
    , (110, (Ocupado, "99292"))
    ]

listaCasos_oLocker :: [(MapaDeLockers, (Identificacion, MapaDeLockers))]
listaCasos_oLocker =
    [ (lockers2, (101, lockers))
    , ([], (102, []))
    , (lockers, (109802, lockers))
    , (lockers3, (103, lockers))
    ]

-- Para un elemento de la lista de casos, genero un Test
makeTest :: (MapaDeLockers, (Identificacion, MapaDeLockers)) -> Test
makeTest (expected, (id, mLs)) =
    TestCase
        ( assertEqual
            ( "++++++\n¡Error en caso con:\ninput 1:\n" ++ show id ++ "\ninput 2:\n" ++ show mLs ++ " !\n++++++\n"
            )
            expected
            (ocuparLocker id mLs)
        )

-- Genero una lista de tests usando la lista de casos y la funcion que genera los
-- casos a partir de esta última
testList_estaDisponibleElLocker :: Test
testList_estaDisponibleElLocker = TestList (map makeTest listaCasos_oLocker)
