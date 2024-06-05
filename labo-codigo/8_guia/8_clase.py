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
        if not char == '#' and not char == ' ':
            return False
        elif char == '#':
            return True


def clonar_sin_comentarios(nombre_archivo: str) -> None:
    f = open(nombre_archivo, "r", encoding="utf8")
    lineas_sin_comentarios: list[str] = []
    for linea in f.readlines():
        if not linea_es_comentario(linea):
            lineas_sin_comentarios += linea 
    f.close()

    new_f = open("sin_comentarios","w", encoding="utf8")
    new_f.truncate()
    for linea in lineas_sin_comentarios:
        new_f.write(linea)
    new_f.close()


# ================================
# ejercicio 3
# ================================
def archivo_a_lineas(nombre_archivo: str) -> list[str]:
    archivo = open(nombre_archivo, 'r', encoding = 'utf8')
    respuesta: list[str] = []
    linea: str = ""
    for char in archivo.read():
        if char == '\n' and linea != '' and linea[-1] != '\n':
            respuesta.append(linea + '\n')
            linea = ""
        else:
            linea += char
    archivo.close()
    return respuesta

def invertir_lineas(nombre_archivo: str) -> None:
    lineas_de_archivo: list[str] = archivo_a_lineas(nombre_archivo)
    print(lineas_de_archivo)

    new_file = open("lineas_invertidas",'w', encoding = 'utf8')
    new_file.truncate()
    for ind in range(len(lineas_de_archivo) - 1, -1, -1):
        new_file.write(lineas_de_archivo[ind])
    new_file.close()


# ================================
# PILAS


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
def palabras_de_arch(nombre_archivo: str) -> list[str]:
    with open(nombre_archivo, "r") as archivo:
        contenido: str = archivo.read()
        return mi_split(contenido)  # es lo mismo que:contenido.split()


def mi_split(linea: str) -> list[str]:
    res: list[str] = []
    palabra = ""
    for char in linea:
        if char == " " or char == "\t" or char == "\n" or char == "\r":
            if len(palabra) > 0:
                res.append(palabra)
                palabra = ""
            else:
                palabra += char
        if len(palabra) > 0:
            res.append(palabra)

        return res


def pertenece_dict(d, k):
    lista = list(d.keys())
    for e in lista:
        if e == k:
            return True
    return False


def agrupar(nom_arch) -> dict:
    palabras: list[str] = palabras_de_arch(nom_arch)
    res = {}
    for p in palabras:
        t = len(p)
        if pertenece_dict(res, t):
            res[t] = res[t] + 1
        else:
            res[t] = 1
    return res


def la_palabra_mas_frecuente(nombre_archivo: str) -> str:
    palabras: list[chr] = palabras_de_arch(nombre_archivo)
    contador: dict[str, int] = {}

    for palabra in palabras:
        if palabra in contador:
            # contador[palabra] = contador[palabra] + 1
            contador[palabra] += 1
        else:
            contador[palabra] += 1


# pastebin.com/xabaQTyv
