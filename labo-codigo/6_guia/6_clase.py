from math import pi
from math import sqrt


# Ejercicio 1
# ej 1.1
def imprimir_hola_mundo() -> None:
    print("¡Hola, mundo!")


# ej 1.2
def imprimir_un_verso() -> None:
    print("lalaal\nlalalala")

# ej 1.3
def raizDe2() -> float:
    return round(sqrt(2), 4)


# ej 1.4
def factorial_de_dos() -> int:
    return 2


# ej 1.5
def perimetro() -> float:
    return 2 * pi

# Ejercicio 2
# ej 2.1
def imprimir_saludo(nombre: str) -> str:
    print(f"Hola, {nombre}")

# ej 2.2
def imprimir_saludo(numero: float) -> float:
    return sqrt(numero)

# ej 2.3
def fahrenheit_a_celsius(temp_far: float) -> float:
    return (temp_far - 32) * 5 /9

# ej 2.4
def imprimir_dos_veces(estribillo: str) -> str:
    return estribillo * 2

# ej 2.5
def es_multiplo_de(n: int, m : int) -> bool:
    return n % m == 0
 
# ej 2.6
def es_multiplo_de(n: int, m : int) -> bool:
    return n % m == 0

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


# Ejercicio 4
# ej 4.11

def peso_pino()

# imprimir_un_verso()
# print(raizDe2())
# print(perimetro())
# print(es_par(5))
# print(es_nombre_largo("Bob Patiño"))
# imprimir_pares_10_40()
# cuenta_regresiva(5)
