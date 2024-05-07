import Test.HUnit
import Tipos5

existeElLocker :: Identificacion -> MapaDeLockers -> Bool
existeElLocker _ [] = False
existeElLocker id ((idL, st) : mLs) = id == idL || existeElLocker id mLs

main :: IO ()
main = do
    runTestTT $ TestList [testList_existeElLocker]
    return ()

tCase_existeElLocker :: [(Bool, (Identificacion, MapaDeLockers))]
tCase_existeElLocker =
    [ (True, (100, lockers))
    , (False, (104, lockers))
    , (False, (104, []))
    , (False, (105, []))
    ]

-- Genereo el test
generateTestCase :: (Bool, (Identificacion, MapaDeLockers)) -> Test
generateTestCase (expected, (a, b)) = TestCase (assertEqual "Test" expected (existeElLocker a b))

testList_existeElLocker :: Test
testList_existeElLocker = TestList (map generateTestCase tCase_existeElLocker)
