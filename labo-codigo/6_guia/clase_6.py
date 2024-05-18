from math import pi
from math import sqrt


def imprimir_un_verso() -> None:
    print("lalaal\nlalalala")


def perimetro() -> float:
    return 2 * pi


def raizDe2() -> float:
    return round(sqrt(2), 4)


def raiz_cuadrada_de(numero: int) -> float:
    return sqrt(numero)


def es_par(z: int) -> bool:
    return z % 2 == 0


def es_nombre_largo(nombre: str) -> bool:
    longitud: int = len(nombre)
    condicion: bool = longitud >= 3 and longitud <= 8
    resultado: bool = False
    if condicion == True:
        resultado = True
    return resultado


def imprimir_pares_10_40() -> None:
    numero: int = 10
    while numero <= 40:
        # numero % 2 == 0 and print(numero)
        # numero = numero + 1
        print(numero)
        numero = numero + 2


def cuenta_regresiva(numero: int) -> None:
    for numero in range(numero, 0, -1):
        print(numero)
    print("Despegue")

    # while (numero > 0):
    #     print(numero)
    #     numero = numero - 1


# imprimir_un_verso()
# print(raizDe2())
# print(perimetro())
# print(es_par(5))
# print(es_nombre_largo("Bob Patiño"))
# imprimir_pares_10_40()
cuenta_regresiva(5)
