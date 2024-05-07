import Test.HUnit
import Tipos4

enLosContactos :: Nombre -> ContactosTel -> Bool
enLosContactos _ [] = False
enLosContactos nombre ((tel, nombreT) : cts) = nombre == nombreT || enLosContactos nombre cts

agregarContacto :: Contacto -> ContactosTel -> ContactosTel
agregarContacto newC [] = newC : []
agregarContacto (a, b) (ct : cts)
    | b == snd ct = (a, b) : cts
    | otherwise = ct : agregarContacto (a, b) cts

{-
  _____         _
 |_   _|__  ___| |_ ___  ___
   | |/ _ \/ __| __/ _ \/ _ \
   | |  __/\__ \ ||  __/ (_) |
   |_|\___||___/\__\___|\___/

-}

main :: IO ()
main = do
    runTestTT $ TestList [testList_agregarContacto]
    return ()

tCase_agregarContacto :: [(ContactosTel, (Contacto, ContactosTel))]
tCase_agregarContacto =
    [ ([("+123", "dsa")], (("+123", "dsa"), [("+321", "dsa")]))
    , ([("telefono", "dsa")], (("telefono", "dsa"), []))
    , ([("1", "da"), ("4", "dsa")], (("4", "dsa"), [("1", "da")]))
    ]

generateTestCase :: (ContactosTel, (Contacto, ContactosTel)) -> Test
generateTestCase (expected, (a, b)) = TestCase (assertEqual ("Caso \"" ++ snd a ++ "\"") expected (agregarContacto a b))

testList_agregarContacto :: Test
testList_agregarContacto = TestList (map generateTestCase tCase_agregarContacto)
