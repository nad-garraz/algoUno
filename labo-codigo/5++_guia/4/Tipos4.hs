module Tipos4 where
  type Texto = [Char]
  type Nombre = Texto
  type Telefono = Texto
  type Contacto = (Nombre, Telefono)
  type ContactosTel = [Contacto]
