# -*- coding: latin-1 -*-
from typing import TypeVar, Tuple
from queue import LifoQueue as Pila
from queue import Queue as Cola
import random

T = TypeVar("T")


def suma_total(s: list[int]) -> int:
    total: int = 0
    indice_actual: int = 0
    longitud: int = len(s)
    while indice_actual < longitud:
        valor_actual: int = s[indice_actual]
        total = total + valor_actual
        indice_actual += 1
    return total


def suma_total2(s: list[int]) -> int:
    total: int = 0
    longitud: int = len(s)
    for ind in range(0, longitud):
        total = total + s[ind]
    return total


def suma_total3(s: list[int]) -> int:
    total: int = 0
    for valor in s:
        total = total + valor
    return total


def pertenece_2(s: list[int], e: int) -> bool:
    longitud: int = len(s)
    indice_actual: int = 0
    pertenece: bool = False
    while indice_actual < longitud:
        if s[indice_actual] == e:
            pertenece = True
        indice_actual = indice_actual + 1
    return pertenece


def pertenece_3(s: list[int], e: int) -> bool:
    longitud: int = len(s)
    indice_actual: int = 0
    pertenece: bool = False
    while (indice_actual < longitud) and (not pertenece):
        if s[indice_actual] == e:
            pertenece = True
        indice_actual = indice_actual + 1
    return pertenece


def pertenece_1(s: list[int], e: int) -> bool:
    return e in s


# 1.7


def tiene_minuscula(cadena: str) -> bool:
    res: bool = False
    for c in cadena:
        if "a" <= c and c <= "z":
            res = True
    return res


def tiene_mayuscula(cadena: str) -> bool:
    res: bool = False
    for c in cadena:
        if "A" <= c and c <= "Z":
            res = True
    return res


def tiene_numeros(cadena: str) -> bool:
    res: bool = False
    for c in cadena:
        if "0" <= c and c <= "9":
            res = True
    return res


def fortaleza_PWD_v2(cadena: str) -> str:
    tiene_min: bool = tiene_minuscula(cadena)
    tiene_may: bool = tiene_mayuscula(cadena)
    tiene_mum: bool = tiene_numeros(cadena)
    mayor_a_8: bool = len(cadena) > 8

    if tiene_may and tiene_mum and tiene_min and mayor_a_8:
        return "VERDE"
    elif len(cadena) < 5:
        return "ROJA"
    else:
        return "AMARILLA"


# x = fortaleza_PWD_v2 ("a6$_Afghij5Dklmnopqrstuvwxyz")


def fortaleza_PWD_v1(cadena: str) -> str:
    tiene_min: bool = False
    tiene_may: bool = False
    tiene_mum: bool = False
    mayor_a_8: bool = len(cadena) > 8

    for c in cadena:
        if c.isalpha():
            if c.islower():
                tiene_min = True
            elif c.isupper():
                tiene_may = True
        elif c.isdigit():
            tiene_mum = True

    if tiene_may and tiene_mum and tiene_min and mayor_a_8:
        return "VERDE"
    elif len(cadena) < 5:
        return "ROJA"
    else:
        return "AMARILLA"


# 2.1
def es_par(num: int) -> bool:
    return num % 2 == 0


def reemplazar_pos_pares_por_cero(lista: list[int]) -> None:
    indice: int = 0
    longitud = len(lista)
    while indice < longitud:
        if es_par(indice):
            lista[indice] = 0
        indice += 1


lista = [2, 4, 5, 6]
# print (f"modificar_pares: {lista}" )
reemplazar_pos_pares_por_cero(lista)
# print (f"modificar_pares: {lista}" )


def reemplazar_pos_pares_por_cero_for(lista: list[int]) -> None:
    # for i in range(len(lista)):
    # if i % 2 == 0:
    #    lista[i] = 0
    for i in range(0, len(lista), 2):
        lista[i] = 0


# 5.2 problema perteneceACadaUno (in s:seq<seq<Z>>, in e:Z, out res: seq<Bool>)


def pertenece_a_cada_uno_version_2(s: list[list[int]], e: int, res: list[bool]) -> None:

    indice_actual: int = 0
    longitud: int = len(s)
    # res.clear()

    while indice_actual < longitud:
        lista_actual: int = s[indice_actual]
        res.append(pertenece_1(lista_actual, e))
        indice_actual += 1


res = []
print(f"pertenece_a_cada_uno_version_2: {res}")
pertenece_a_cada_uno_version_2([[1, 2, 1], [2, 3, 4], [3, 4]], 3, res)
print(f"pertenece_a_cada_uno_version_2: {res}")


def pertenece_a_cada_uno_version_2_for(
    s: list[list[int]], e: int, res: list[bool]
) -> None:
    res.clear()
    for i in range(len(s)):
        res.append(pertenece_1(s[i], e))


# 3-6-24


# ejemplos de for
def prueba():

    s: list[str] = ["a", "b", "c", "d", "e"]

    for x in s:  # imprimo contenido
        print(x)

    print("")

    for i in range(len(s)):  # imprimo índices
        print(i)

    print("")

    for i in range(2, len(s)):  # imprimo índices empezando por el 2
        print(i)

    print("")

    for i in range( 0, len(s), 2):  # imprimo índices empezando por el 0 y avanzando de a 2
        print(i)

    print("")

    for v in s:  # imprimo contenido
        print(v)

    print("")

    for i in range(len(s)):  # imprimo contenido usando el índice
        print(s[i])

    print("")


# suma todos los elementos de una matriz tomando los valores
def sumar_matriz(s: list[list[int]]) -> int:
    res: int = 0
    for f in s:
        for v in f:
            res += v
    return res


print("sumar_matriz:")
print(sumar_matriz([[1, 2, 1], [2, 3, 4], [3, 4, 0]]))
print("")


# suma todos los elementos de una matriz recorriendola por los índices
def sumar_matriz_ind(s: list[list[int]]) -> int:
    res: int = 0
    for f in range(len(s)):
        for c in range(len(s[f])):
            res += s[f][c]
    return res


print("sumar_matriz_ind :")
print(sumar_matriz_ind([[1, 2, 1], [2, 3, 4], [3, 4, 0]]))
print("")


# ver dónde se inicializa res y cont_fila
# devuelve una lista con los valores de la suma de cada fila
def sumar_filas_matriz_ind(s: list[list[int]]) -> list[int]:
    res: list[int] = []
    for f in s:
        cont_fila = 0
        for v in f:
            cont_fila += v
        res.append(cont_fila)

    return res


print("sumar_filas_matriz_ind :")
print(sumar_filas_matriz_ind([[1, 2, 1], [2, 3, 4], [3, 4, 0]]))
print("")


# devuelve una lista con los valores de la suma de cada columna
def sumar_columnas_matriz(s: list[list[int]]) -> list[int]:
    res: list[int] = []
    for c in range(len(s[0])):  # asumo que hay, por lo menos, una fila
        suma_col: int = 0
        for f in range(len(s)):
            suma_col += s[f][c]
        res.append(suma_col)
    return res


print("sumar_columnas_matriz :")
print(sumar_columnas_matriz([[1, 2, 1], [2, 3, 4], [3, 4, 0]]))
print("")


def columna(matriz: list[list[int]], nro_col: int) -> list[int]:
    res: list[int] = []
    for fila in matriz:
        res.append(fila[nro_col])
    return res


# devuelve una lista de tuplas con los valores mín y máx de cada columna
def min_max_columnas_matriz(s: list[list[int]]) -> list[(int, int)]:
    res: list[(int, int)] = []
    for nro_col in range(len(s[0])):  # asumo que hay, por lo menos, una fila
        col: list[int] = columna(s, nro_col)

        res.append(min_max(col))
    return res


# devuelve una tupla con el valor mínimo y el máximo
def min_max(s: list[int]) -> Tuple[int, int]:  # (int, int):
    # requiere |s| > 0
    minimo = s[0]
    maximo = s[0]

    for numero in s:
        if numero < minimo:
            minimo = numero
        if numero > maximo:
            maximo = numero

    return minimo, maximo


print("min_max_columnas_matriz :")
print(min_max_columnas_matriz([[1, 2, 1], [2, 3, 4], [3, 4, 0]]))
print("")


# clase colas - dicc en: https://pastebin.com/95JyVctp
