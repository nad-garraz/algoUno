module Tipos5 where

  type Identificacion = Integer
  type Texto = String
  type Ubicacion = Texto
  type Estado = (Disponibilidad, Ubicacion)
  type Locker = (Identificacion, Estado)
  type MapaDeLockers = [Locker]
  data Disponibilidad = Libre | Ocupado deriving (Eq, Show)

  -- Para el test
  lockers :: MapaDeLockers
  lockers =
      [ (100, (Ocupado, "ZD39I"))
      , (101, (Libre, "JAH3I"))
      , (103, (Libre, "IQSA9"))
      , (105, (Libre, "QOTSA"))
      , (109, (Ocupado, "893JJ"))
      , (110, (Ocupado, "99292"))
      ]
