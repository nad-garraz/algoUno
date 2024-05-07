import Test.HUnit
import Tipos4

eliminarContacto :: Nombre -> ContactosTel -> ContactosTel
eliminarContacto _ [] = []
eliminarContacto nombre (c : contactos)
    | nombre == snd c = contactos
    | otherwise = c : eliminarContacto nombre contactos

-- Testing
main :: IO ()
main = do
    runTestTT $ TestList [testList_eliminarContacto]
    return ()

tCase_eliminarContacto :: [(ContactosTel, (Nombre, ContactosTel))]
tCase_eliminarContacto =
    [ ([], ("Pepe", [("+123", "Pepe")]))
    , ([("+123", "TuVieja")], ("Nadie", [("+123", "TuVieja")]))
    , ([], ("telefono", []))
    , ([("1", "pa")], ("falo", [("4", "falo"), ("1", "pa")]))
    , ([("4", "falo")], ("pa", [("4", "falo"), ("1", "pa")]))
    ]

generateTestCase :: (ContactosTel, (Nombre, ContactosTel)) -> Test
generateTestCase (expected, (nombre, b)) = TestCase (assertEqual ("Caso \"" ++ nombre ++ "\"") expected (eliminarContacto nombre b))

testList_eliminarContacto :: Test
testList_eliminarContacto = TestList (map generateTestCase tCase_eliminarContacto)
