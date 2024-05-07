hayQueCodificar :: Char -> [(Char, Char)] -> Bool
hayQueCodificar _ [] = False
hayQueCodificar a ((b, c) : ds) = a == b || hayQueCodificar a ds

--
-- cuantasVecesHayQueCodificar :: Char -> [Char] -> [(Char, Char)] -> Integer
-- cuantasVecesHayQueCodificar _ [_] [] = 0
-- cuantasVecesHayQueCodificar c frase mapeo
--     | hayQueCodificar c mapeo && aparicionesChar c frase
--     | otherwise = 0
--   where
--     aparicionesChar :: Char -> [Char] -> Integer
--     aparicionesChar c (d : ds)
--         | c == d = 1 + aparicionesChar c ds
--         | otherwise = aparicionesChar c ds

cuantasVecesHayQueCodificar :: Char -> [Char] -> [(Char, Char)] -> Integer
cuantasVecesHayQueCodificar  _ [] _ = 0
cuantasVecesHayQueCodificar c (x:frase) mapeo
  | hayQueCodificar c mapeo && c == x = 1 + pasoRec
  | otherwise =0  + pasoRec
  where
  pasoRec = cuantasVecesHayQueCodificar c frase mapeo



laQueMasHayQueCodificar :: [Char] -> [(Char, Char)] -> Char
laQueMasHayQueCodificar (c : []) _ = c
laQueMasHayQueCodificar (c : d : frase) mapeo
    | cuantasVecesHayQueCodificar c (c : d : frase) mapeo > cuantasVecesHayQueCodificar d (c : d : frase) mapeo = laQueMasHayQueCodificar (c : frase) mapeo
    | otherwise = laQueMasHayQueCodificar (d : frase) mapeo

codificarFrase :: [Char] -> [(Char, Char)] -> [Char]
codificarFrase [] _ = []
codificarFrase (x : frase) mapeo
    | hayQueCodificar x mapeo = swap x mapeo : pasoRec
    | otherwise = x : pasoRec
  where
    pasoRec = codificarFrase frase mapeo

-- solo corre cuando Char está en la lista.
-- Caso 0 no jode, porque seguro lo detecta antes de 
-- evaluar []
swap :: Char -> [(Char, Char)] -> Char 
swap a ((b, c) : ds)
    | a == b = c
    | otherwise = swap a ds
