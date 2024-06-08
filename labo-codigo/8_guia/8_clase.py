from queue import LifoQueue as Pila
from queue import Queue as Cola
import random


# =========================================
# =========================================
# auxiliares
def pertenece(ls: list[int], e: int) -> bool:
    for element in ls:
        if e == element:
            return True
    return False


def reverse_string(string: str) -> str:
    res: str = ""
    for char in range(len(string) - 1, -1, -1):
        res += string[char]
    return res


def remove_leading_spaces(string: str) -> str:
    res: str = ""
    fst_chr: bool = False

    for char in string:
        if char != " " and not fst_chr:
            fst_chr = not fst_chr
        if fst_chr:
            res += char
    return res


def remove_trailing_spaces(string: str) -> str:
    reverso: str = reverse_string(string)
    sin_leading_spaces: str = remove_leading_spaces(reverso)
    respuesta: str = reverse_string(sin_leading_spaces)
    return respuesta


def my_split(string: str) -> list[str]:
    palabra: str = ""
    res: list[str] = []
    separadores = [",", ".", "?", "¿", "!", "¡", " ", "\n"]
    for char in string:
        if char in separadores:
            if len(palabra) > 0:
                res.append(palabra)
            palabra = ""
        else:
            palabra += char

    if len(palabra) > 0:
        res.append(palabra)

    return res


def archivo_a_lista_de_palabras(nombre_archivo: str) -> list[str]:
    f = open(nombre_archivo, "r", encoding="utf8")
    string = f.read()
    respuesta: list[str] = my_split(string)
    f.close()
    return respuesta


def copiar_pila(p: Pila) -> Pila:
    nueva_p: Pila = Pila()
    lista_tmp: list = []

    while not p.empty():
        lista_tmp.append(p.get())

    for ind in range(len(lista_tmp) - 1, -1, -1):
        p.put(lista_tmp[ind])
        nueva_p.put(lista_tmp[ind])

    return nueva_p


# =========================================
# =========================================


# ================================
# ejercicio 1
# ================================
# =========================
# ejercicio 1.1
# =========================
def contar_lineas(nombre_archivo: str) -> int:
    lineas: int = 0
    with open(nombre_archivo, "r") as f:
        while f.readline():
            lineas += 1
    return lineas


def contar_lineas2(nombre_archivo: str) -> int:
    lineas: int = 0
    f = open(nombre_archivo, "r")
    while f.readline():
        lineas += 1
    f.close()
    return lineas


# =========================
# ejercicio 1.2
# =========================


def existe_palabra(palabra: str, nombre_archivo: str) -> bool:
    lista_palabras: list[str] = archivo_a_lista_de_palabras(nombre_archivo)
    return palabra in lista_palabras


# =========================
# ejercicio 1.3
# =========================
def cantidad_apariciones(nombre_archivo: str, palabra: str) -> int:
    lista_palabras: list[str] = archivo_a_lista_de_palabras(nombre_archivo)
    apariciones: int = 0
    for word in lista_palabras:
        if word == palabra:
            apariciones += 1
    return apariciones


# ================================
# ejercicio 2
# ================================
def linea_es_comentario(linea: str) -> bool:
    for char in linea:
        if not char == "#" and not char == " ":
            return False
        elif char == "#":
            return True


def clonar_sin_comentarios(nombre_archivo: str) -> None:
    f = open(nombre_archivo, "r", encoding="utf8")
    lineas_sin_comentarios: list[str] = []
    for linea in f.readlines():
        if not linea_es_comentario(linea):
            lineas_sin_comentarios += linea
    f.close()

    new_f = open("sin_comentarios", "w", encoding="utf8")
    new_f.truncate()
    for linea in lineas_sin_comentarios:
        new_f.write(linea)
    new_f.close()


# ================================
# ejercicio 3
# ================================
# De un archivo de texto, crea una lista con las lineas
# separadas por "\n"
def archivo_a_lineas(nombre_archivo: str) -> list[str]:
    archivo = open(nombre_archivo, "r", encoding="utf8")
    respuesta: list[str] = []
    linea: str = ""
    for char in archivo.read():
        if char == "\n" and linea != "" and linea[-1] != "\n":
            respuesta.append(linea + "\n")
            linea = ""
        else:
            linea += char
    archivo.close()
    return respuesta


def invertir_lineas(nombre_archivo: str) -> None:
    lineas_de_archivo: list[str] = archivo_a_lineas(nombre_archivo)
    print(lineas_de_archivo)

    new_file = open("lineas_invertidas", "w", encoding="utf8")
    new_file.truncate()
    for ind in range(len(lineas_de_archivo) - 1, -1, -1):
        new_file.write(lineas_de_archivo[ind])
    new_file.close()


# ================================
# ejercicio 4
# ================================
def agregar_frase_al_final(nombre_archivo: str, frase: str) -> None:
    archivo = open(nombre_archivo, "+a", encoding="utf8")
    archivo.write(frase)
    archivo.close()


# ================================
# ejercicio 5
# ================================
def agregar_frase_al_principio(nombre_archivo: str, frase: str) -> None:
    file = open(nombre_archivo, "r+", encoding="utf8")
    contenido = file.read()
    file.seek(0)
    file.write(frase + "\n" + contenido)
    file.close()


def agregar_frase_al_principio2(nombre_archivo: str, frase: str) -> None:
    contenido: str = ""
    file = open(nombre_archivo, "r", encoding="utf8")
    contenido = file.read()
    file.close()

    file = open(nombre_archivo, "w", encoding="utf8")
    file.write(frase + "\n" + contenido)
    file.close()


# ================================
# ejercicio 6
# ================================
# def listar_palabras_de_archivo(nombre_archivo) -> None:
#     f = open(nombre_archivo,"r+b")
#     secuencia_bytes : list[bytes] = f.read()
#     for b in secuencia_bytes:
#


# ================================
# PILAS
# ================================
# ejercicio 8
# ================================
def generar_nros_al_azar(cantidad: int, desde: int, hasta: int) -> Pila[int]:
    pila = Pila()
    for _ in range(cantidad):
        pila.put(random.randint(desde, hasta))
    return pila


# ================================
# ejercicio 9
# ================================
def cantidad_elementos(p: Pila) -> int:
    cantidad: int = 0
    p_tmp: Pila[int] = copiar_pila(p)
    while not p_tmp.empty():
        p_tmp.get()
        cantidad += 1
    return cantidad


# ================================
# ejercicio 10
# ================================
def buscar_el_maximo(p: Pila) -> int:
    if cantidad_elementos(p) == 0:
        return -1

    p_tmp: Pila[int] = copiar_pila(p)
    maximo: int = p_tmp.get()
    while not p_tmp.empty():
        candidato: int = p_tmp.get()
        if maximo <= candidato:
            maximo = candidato
    return maximo


# ================================
# ejercicio 11
# ================================
# def esta_bien_balanceada(s: str) -> bool:


# ================================
# ejercicio 12
# ================================
def calcular(a: str, b: str, operador: str) -> float:
    a: float = float(a)
    b: float = float(b)
    if operador == "+":
        return a + b
    elif operador == "-":
        return a - b
    elif operador == "*":
        return a * b
    else:
        return a / b


def evaluar_expresion(s: str) -> float:
    operandos: list[str] = ["+", "-", "*", "/"]
    p_operandos: Pila[chr] = Pila()
    tokens: list[str] = my_split(s)

    for t in tokens:
        if t not in operandos:
            p_operandos.put(t)
        else:
            segundo_operando: str = p_operandos.get()
            print(f"segundo_operando: {segundo_operando}")
            primer_operando: str = p_operandos.get()
            print(f"primer_operando: {primer_operando}")
            operador: str = t
            print(f"operador: {operador}")
            operacion = calcular(primer_operando, segundo_operando, operador)
            p_operandos.put(operacion)

    answer: float = float(p_operandos.get())

    return answer


def copiar_cola(original: Cola) -> Cola:
    res: Cola = Cola()
    cola_tmp: Cola = Cola()

    while not (original.empty()):
        v = original.get()
        res.put(v)
        cola_tmp.put(v)

    while not (cola_tmp.empty()):
        v = cola_tmp.get()
        original.put(v)

    return res


"""
notas:
    colas(FIFO):
        c = Cola()
        c.put(elem)
        c.get() -> primer elem: 
        c.empty()
    pilas(LIFO):
        p.Pila()
        p.put(elem)
        p.get() -> último elem
        p.empty()
"""


def imprimir(lista_o_cola):
    print("----")
    while not lista_o_cola.empty():
        print(lista_o_cola.get())


# ================================
# ejercicio 13
# ================================


def generar_nros_al_azar(cantidad: int, desde: int, hasta) -> Cola[int]:
    res: Cola[int] = Cola()
    for _ in range(cantidad):  # No me importa la variable
        x: int = random.randint(desde, hasta)
        res.put(x)
    return res


def armar_secuencia_de_bingo() -> Cola[int]:
    res: Cola[int] = Cola()
    nros: list[int] = []
    while len(nros) < 100:
        v = random.randint(0, 99)
        if not pertenece(nros, v):
            nros.append(v)
            res.put(v)
    return res


def jugar_bingo(carton: list, bolillero: Cola) -> int:
    res: int = 0
    copia = copiar_cola(bolillero)
    aciertos: int = 0
    while aciertos < len(carton):
        v = copia.get()
        res += 1
        if pertenece(carton, v):
            aciertos += 1
    return res


# ================================
# Diccionarios:
mi_dicc: dict[str, str] = {"auto": "car", "sol": "sun", "luna": "moon"}
mi_dicc["clave_nueva"] = "nuevo_valor"  # Nuevo par
mi_dicc["clave_nueva2"] = "nuevo_valor2"  # Nuevo par
mi_dicc["clave_nueva2"] = "nuevo_valor3"  # Sobreescribir el valor del par

otro_dic: dict[str, str] = {}  # creo un dicc vacio
claves: list[str] = mi_dicc.keys()
for clave in claves:
    valor: str = mi_dicc[clave]
    print(clave + " - " + valor)
    # modo python es: print(f'{clave} - {valor})
    otro_dic[clave] = valor  # lo agego al nuevo diccionario.

#
# .items()
# .keys()
# .values()


# ================================
# ejercicio  19
# ================================
def palabras_de_arch(nombre_archivo: str) -> dict[int, int]:
    ls_palabras: list[str] = archivo_a_lista_de_palabras(nombre_archivo)
    res: dict[int, int] = {}
    for palabra in ls_palabras:
        long_palabra = len(palabra)
        if long_palabra in res.keys():
            res[long_palabra] += 1
        else:
            res[long_palabra] = 1
    return res


# ================================
# ejercicio  21
# ================================
def la_palabra_mas_frecuente(nombre_archivo: str) -> str:
    palabras: list[chr] = palabras_de_arch(nombre_archivo)
    contador: dict[str, int] = {}

    for palabra in palabras:
        if palabra in contador:
            # contador[palabra] = contador[palabra] + 1
            contador[palabra] += 1
        else:
            contador[palabra] += 1

# ================================
# ejercicio  22
# ================================

# pastebin.com/xabaQTyv
