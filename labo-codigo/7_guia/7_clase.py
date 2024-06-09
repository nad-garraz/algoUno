import numpy as np

# ================================
# Auxiliares
# ================================
def copiar_lista(ls: list) -> list:
    res: list = []
    for item in ls:
        res.append(item)
    return res
# ================================
# Fin Auxiliares
# ================================


# ================================
# ejercicio 1
# ================================
# ejercicio 1.1
def pertenece(ls: list[int], e: int) -> bool:
    for element in ls:
        if e == element:
            return True
    return False


# con while
def pertenece2(ls: list[int], e: int) -> bool:
    index: int = 0
    while index < len(ls):
        if e == ls[index]:
            return True
        index += 1
    return False


# con for y range
def pertenece3(ls: list[int], e: int) -> bool:
    for index in range(0, len(ls)):
        if e == ls[index]:
            return True
    return False


# Genérico, para encontrar un char en un string
def pertenece4(ls, e) -> bool:
    for index in range(0, len(ls)):
        if e == ls[index]:
            return True
    return False


# ejercicio 1.2
def divide_a_todos(ls: list[int], e: int) -> bool:
    index: int = 0
    while index < len(ls):
        if ls[index] % e != 0:
            return False
        index += 1
    return True


# ejercicio 1.3
def suma_total(ls: list[int]) -> int:
    total: int = 0
    ind_actual: int = 0
    longitud: int = len(ls)
    while ind_actual < longitud:
        total += ls[ind_actual]
        ind_actual += 1
    return total


# ejercicio 1.4
def ordenados(ls: list[int]) -> bool:
    index: int = 0
    while index < len(ls) - 1:
        if ls[index] >= ls[index + 1]:
            return False
        index += 1
    return True


# ejercicio 1.5
def lista_mayor_a_siete(ls: list[str]) -> bool:
    for palabra in ls:
        if len(palabra) > 7:
            return True
    return False


# ejercicio 1.6
def es_palindromo(string: str) -> bool:
    index: int = 0
    longitud_str: int = len(string)
    while index < longitud_str / 2:
        if string[index] != string[longitud_str - (index + 1)]:
            return False
        index += 1
    return True


# ejercicio 1.7  --> CONSULTAR por lógica del código


def es_minuscula(letra: chr) -> bool:
    return ord(letra) >= 97 and ord(letra) <= 122


def es_mayuscula(letra: chr) -> bool:
    return ord(letra) >= 65 and ord(letra) <= 90


def es_numero(letra: chr) -> bool:
    return ord(letra) >= 48 and ord(letra) <= 57


def fortaleza_contrasenia(string: str) -> bool:
    index: int = 0
    longitud_str: int = len(string)
    minuscula: bool = False
    mayuscula: bool = False
    numero: bool = False
    while (not (minuscula and mayuscula and numero)) and index < longitud_str:
        if not minuscula and es_minuscula(string[index]):
            minuscula = True
        elif not mayuscula and es_mayuscula(string[index]):
            mayuscula = True
        elif not numero and es_numero(string[index]):
            numero = True
        index += 1

    if (minuscula and mayuscula and numero and longitud_str) > 8:
        return "VERDE"
    elif longitud_str < 5:
        return "ROJA"
    else:
        return "AMARILLA"


# ejercicio 1.8
def saldo_actual(movimientos: list[(str, int)]) -> int:
    saldo: int = 0
    for movimiento in movimientos:
        if movimiento[0] == "I":
            saldo += movimiento[1]
        else:
            saldo -= movimiento[1]
    return saldo


# ejercicio 1.9
def es_vocal(c: chr) -> bool:
    return c == "a" or c == "e" or c == "i" or c == "o" or c == "u"


def vocales_distintas(string: str) -> bool:
    vocales: str = ""
    for letra in string:
        if es_vocal(letra) and not pertenece(vocales, letra):
            vocales += letra
            if len(vocales) >= 3:
                return True
    return False


# ================================
# Segunda Parte
# ejercicio 2
# ================================


# ejercicio 2.1 (27/05/2024)
def es_par(n: int) -> bool:
    return n % 2 == 0


# Versión con "while" y "if"
def reemplaza_pares(s: list[int]) -> None:
    ind: int = 0
    long: int = len(s)
    while ind < long:
        if es_par(ind):
            s[ind] = 0
        ind += 1


# Versión sin el "if"
def reemplaza_pares2(s: list[int]) -> None:
    ind: int = 0
    long: int = len(s)
    while ind < long:
        s[ind] = 0
        ind += 2


# Versión con "for"
def reemplaza_pares3(s: list[int]) -> None:
    for ind in range(0, len(s), 2):
        s[ind] = 0


# ejercicio 2.2
def reemplaza_pares_IN(s: list[int]) -> list[int]:
    answer: list[int] = []
    for ind in range(0, len(s)):
        if es_par(ind):
            answer.append(0)
        else:
            answer.append(s[ind])
    return answer


# ejercicio 2.3 --> CONSULTAR
# En este ejercicio el parámetro es de tipo in o de tipo inout? Tendría que
# usar funciones algo nuevo para concatenar el final de la lista? Tengo que codear, cola?
def borrar_vocales(s: str) -> str:
    indice: int = 0
    answer: str = ""
    while indice < len(s):
        if not es_vocal(s[indice]):
            answer += s[indice]
        indice += 1
    return answer


# ejercicio 2.4
def reemplaza_vocales(s: list[chr]) -> list[chr]:
    indice: int = 0
    answer: list[chr] = []
    while indice < len(s):
        if es_vocal(s[indice]):
            answer.append("_")
        else:
            answer.append(s[indice])
        indice += 1
    return answer


# ejercicio 2.5
def da_vuelta_str(string: list[chr]) -> list[chr]:
    longitud_str: int = len(string)
    indice: int = longitud_str - 1
    answer: list[chr] = []
    while indice >= 0:
        answer.append(string[indice])
        indice -= 1
    return answer


# ejercicio 2.6
def eliminar_repetidos(string: list[chr]) -> list[chr]:
    answer: list[chr] = [string[0]]
    indice: int = 1
    while indice < len(string):
        if not pertenece(answer, string[indice]):
            answer.append(string[indice])
        indice += 1
    return answer


# ejercicio 3
def promedio(ls: list[int]) -> float:
    total = 0
    for n in ls:
        total += n
    return total / len(ls)


def mayores_o_iguales_4(ls: list[int]) -> bool:
    for n in ls:
        if n < 4:
            return False
    return True


def aprobado(notas: list[int]) -> int:
    if mayores_o_iguales_4(notas) and promedio(notas) >= 7:
        return 1
    elif mayores_o_iguales_4(notas) and promedio(notas) >= 4 and promedio(notas) < 7:
        return 2
    else:
        return 3


# ejercicio 4.1
# Recibe strings por standard input y forma una lista.
# El loop termina cuando se ingrsa "listo"
def construir_lista_estudiantes() -> list[list[chr]]:
    lista_estudiantes: list[list[chr]] = []
    ultimoNombre: list[chr] = []

    while ultimoNombre != "listo":
        ultimoNombre = str(input("Ingresar nombre: "))
        lista_estudiantes.append(ultimoNombre)
    lista_estudiantes.pop()  # Le saco el "listo" que puse como último elemento de la lista
    return lista_estudiantes


# ejercicio 4.2
# CONSULTAR : Cuando tengo una especificación sin los "requiere"
# tengo que hacer un control de los inputs? O si el input rompe el
# programa no pasa nada?
def input_C_D_X() -> chr:
    valido: bool = False
    opcion: chr = " "
    while not valido:
        opcion = input("Operación a realizar ['C','D','X']: ")
        if opcion == "C" or opcion == "D" or opcion == "X":
            valido = True
    return opcion


def historial_monedero() -> list[tuple[chr, int]]:
    opcion: chr = " "
    historial: list[tuple[chr, int]] = []
    while opcion != "X":
        opcion = input_C_D_X()
        if opcion == "C" or opcion == "D":
            monto: int = input("Ingresar monto: ")
            historial.append((opcion, monto))
    return historial


# ejercicio 4.3
# hacer...


# ejercicio 5.2 (27/05/2024)
# Atento al uso de los in y los out!!!
def pertenece_a_cada_uno_version_2(s: list[list[int]], e: int, res: list[bool]) -> None:
    res.clear()
    for v in s:
        res.append(pertenece(v, e))


# ejercicio 5.3
def filas_misma_longitud(s: list[list[int]]) -> bool:
    long: int = len(s[0])
    res: bool = True

    if long == 0:
        res = False
    else:
        ind: int = 1
        while res and ind < len(s):
            res = len(s[ind]) == long
            ind += 1
    return res


def filas_misma_longitud2(s: list[list[int]]) -> bool:
    long: int = len(s[0])

    if long == 0:
        return False
    else:
        for fila in s:
            if len(fila) != long:
                return False
        return True


def es_matrix(s: list[list[int]]) -> bool:
    return len(s) > 0 and filas_misma_longitud2(s)


# ejercicio 5.4
def filas_ordenadas(m: list[list[int]]) -> list[bool]:
    res: list[bool] = []
    for fila in m:
        res.append(ordenados(fila))
    return res

# ejercicio 5.5
def get_nth_col(A: list[list[float]], col: int) -> list[float]:
    columna: list[float] = []
    col -= 1
    for fila in A:
        columna.append(fila[col])
    return columna

def producto_interno(fila: list[float], columna: list[float]) -> float:
    res: float = 0
    for ind in range(len(fila)):
        res += fila[ind] * columna[ind]
    return res

def producto_matricial(A: list[list[float]], B: list[list[float]]) -> list[list[float]]:
    res: list[list[float]] = []
    fila_res: list[float] = []
    for fila in A:
        for ind in range(1, len(B) + 1):
            columna = get_nth_col(B, ind)
            elemento_res: float = producto_interno(fila, columna)
            fila_res.append(elemento_res)
        res.append(fila_res)
        fila_res = []

    return res

def producto_matricial2(A: list[list[float]], B: list[list[float]]) -> list[list[float]]:
    respuesta: list[list[float]] = []
    respuesta_fila: list[float] = []
    elemento: float = 0

    filas: int = len(A)
    columnas: int = len(A[1])
    productos: int = columnas

    for i in range(filas):
        for j in range(columnas):
            for k in range(productos):
                elemento +=  A[i][k] * B[k][j]
            respuesta_fila.append(elemento)
            elemento = 0
        respuesta.append(respuesta_fila)
        respuesta_fila = []
    return respuesta


# A = np.random.random((3,3))
A = [[1,1],[0.5, 0.5]]
B = copiar_lista(A)
for _ in range(10):
    print(B)
    B = producto_matricial(A,B)



