import Test.HUnit
import Tipos4

enLosContactos :: Nombre -> ContactosTel -> Bool
enLosContactos _ [] = False
enLosContactos nombre ((tel, nombreT) : cts) = nombre == nombreT || enLosContactos nombre cts

{-
  _____         _
 |_   _|__  ___| |_ ___  ___
   | |/ _ \/ __| __/ _ \/ _ \
   | |  __/\__ \ ||  __/ (_) |
   |_|\___||___/\__\___|\___/

-}
-- Función con comandos para que corra al ejecutar el archivo.

main :: IO ()
main = do
    runTestTT $ TestList [testList_enLosContactos]
    return ()

tCase_enLosContactos :: [(Bool, (Nombre, ContactosTel))]
tCase_enLosContactos =
    [ (True, ("dsa", [("1", "dsa")]))
    , (False, ("c", [("0", [])]))
    , (False, ("Bobe", [("1", "Bob"), ("23", "es"), ("4553", "ponja")]))
    , (True, ("Bob", [("1", "Bob"), ("23", "es"), ("4553", "ponja")]))
    ]

generateTestCase :: (Bool, (Nombre, ContactosTel)) -> Test
generateTestCase (expected, (input, xs)) = TestCase (assertEqual ("Caso \"" ++ input ++ "\"") expected (enLosContactos input xs))
testList_enLosContactos :: Test
testList_enLosContactos = TestList (map generateTestCase tCase_enLosContactos)
