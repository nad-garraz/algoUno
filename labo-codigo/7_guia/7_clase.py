# Notas:

# Ejercicio de la clase
# ej 1
# def pertenece ()


def suma_total(ls: list[int]) -> int:
    total: int = 0
    ind_actual: int = 0
    longitud: int = len(ls)
    while ind_actual < longitud:
        valor: int
        total += ls[ind_actual]
        ind_actual += 1
    return total


# ejrcicicio clase 2
def pertenece(ls: list[int], n: int) -> bool:
    pertenece: bool = False
    ind_actual: int = 0
    longitud: int = len(ls)
    while not pertenece and ind_actual < longitud:
        valor: int = ls[ind_actual]
        pertenece = n == valor
        ind_actual += 1
    return pertenece


# ejercicio 2.1 (27/05/2024)
def es_par(n: int) -> bool:
    return n % 2 == 0


# Versión con "while" y "if"
def remplaza_pares(s: list[int]) -> None:
    ind: int = 0
    long: int = len(s)
    while ind < long:
        if es_par(ind):
            s[ind] = 0
        ind += 1


# Versión sin el "if"
def remplaza_pares2(s: list[int]) -> None:
    ind: int = 0
    long: int = len(s)
    while ind < long:
        s[ind] = 0
        ind += 2


# Versión con "for"
def remplaza_pares3(s: list[int]) -> None:
    for ind in range(0, len(s), 2):
        s[ind] = 0


# Ejercicio 5.2 (27/05/2024)
# Atento al uso de los in y los out!!!
def pertenece_a_cada_uno_version_2(s: list[list[int]], e: int, res: list[bool]) -> None:
    res.clear()
    for v in s:
        res.append(pertenece(v, e))


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
