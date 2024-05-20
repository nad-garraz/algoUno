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
    return (temp_far - 32) * 5 / 9


# ej 2.4
def imprimir_dos_veces(estribillo: str) -> str:
    return estribillo * 2


# ej 2.5
def es_multiplo_de(n: int, m: int) -> bool:
    return n % m == 0


# ej 2.6
def es_multiplo_de(n: int, m: int) -> bool:
    return n % m == 0


# ej 2.7
def es_par(numero: int) -> bool:
    return es_multiplo_de(numero)


# ej 2.8
def cantidad_de_pizzas(comensales: int, min_cant_de_porciones: int) -> int:
    porciones_por_pizza: int = 8
    sobras: int = 2
    minimo_de_porciones: int = min_cant_de_porciones * comensales + sobras
    pizzas_fraccionarias: float = minimo_de_porciones / porciones_por_pizza
    cantidad_de_pizzas: int = ceil(pizzas_fraccionarias)
    return cantidad_de_pizzas


# Ejercicio 3
# ej 3.1
def alguno_es_0(numero1: float, numero2: float) -> bool:
    return numero1 == 0 or numero2 == 0


# ej 3.2
def alguno_es_0(numero1: float, numero2: float) -> bool:
    return numero1 == 0 and numero2 == 0


# ej 3.3
def es_nombre_largo(nombre: str) -> bool:
    longitud: int = len(nombre)
    condicion: bool = longitud >= 3 and longitud <= 8
    resultado: bool = False
    return condicion or resultado


# ej 3.4
def es_bisisesto(anio: int) -> bool:
    multiplo_de_400: bool = anio % 400 == 0
    multiplo_de_4: bool = anio % 4 == 0
    no_multiplo_de_100: bool = anio % 100 != 0
    return multiplo_de_400 or (multiplo_de_4 and no_multiplo_de_100)


# Ejercicio 4
# ej 4.1
def peso_bajo_3_metros(altura) -> int:
    return min(900, altura * 100 * 3)


def peso_sobre_3_metros(altura) -> int:
    return max(0, (altura - 3) * 100 * 2)


def peso_pino(altura: int) -> int:
    return peso_bajo_3_metros(altura) + peso_sobre_3_metros(altura)


# ej 4.2
def es_peso_util(peso: int) -> bool:
    return peso >= 400 and peso <= 1000


# ej 4.3
# Ejercicio feo mal redactado.
def sirve_pino(altura: int) -> bool:
    return peso_pino(altura) >= 400 and peso_pino(altura) <= 1000


# ej 4.4
# ...
# ===================
# TODO 20/05/2024: Preguntar qué es eso de la composición de funciones.
# ===================

# Ejercicio 5
# ===================
# TODO 20/05/2024: No entiendo un carajo el enunciado.
# ===================
# Se puede usar if then else o no?


# Ejercicio 6
# ej 6.1
def imprimir_del_1_al_10() -> None:
    numero: int = 10
    while numero > 0:
        print(numero)
        numero -= 1


# ej 6.2
def imprimir_pares_entre_10_y_40() -> None:
    numero: int = 10
    while numero < 42:
        print(numero)
        numero += 2


# ej 6.3
def imprimir_eco_10_veces() -> None:
    numero: int = 0
    while numero < 10:
        print(f"{numero+1} - eco")
        numero += 1


# ej 6.4
def cuenta_regresiva(numero: int) -> None:
    while numero > 0:
        print(numero)
        numero = numero - 1


# ej 6.5
# ===================
# TODO 20/05/2024:
# ===================

# ej 6.6
# ===================
# TODO 20/05/2024:
# ===================


# Ejercicio 7
# ej 7.4
def cuenta_regresiva(numero: int) -> None:
    for numero in range(numero, 0, -1):
        print(numero)
    print("Despegue")


# Ejercicio 8
# ¿Qué sería la ejecución simbólica?

# Ejercicio 9
# ===================
# TODO 20/05/2024: consultar
# ===================
