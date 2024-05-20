noHayIguales :: [(Integer,Integer)] -> Bool
noHayIguales [] = True 
noHayIguales (x:[]) = duplaNoIgual x
noHayIguales (x:y:ys) = duplaNoIgual x && not( duplasIguales x (y:ys)) && noHayIguales (y:ys)

duplaNoIgual :: (Integer,Integer) -> Bool
duplaNoIgual (x,y) = x /= y

duplasIguales :: (Integer,Integer) -> [(Integer,Integer)] -> Bool
duplasIguales _ [] = False
duplasIguales (x,y) ((z,w):resto) = (x == z && y == w) || (x == w && y == z) || duplasIguales (x,y) resto
