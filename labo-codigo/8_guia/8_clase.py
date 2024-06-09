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
def esta_bien_balanceada(s: str) -> bool:
    p: Pila[chr] = Pila()
    for char in s:
        if char == "(":
            p.put(char)
        elif char == ")":
            if p.empty():
                return False
            p.get()
    return p.empty()


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
            # print(f"segundo_operando: {segundo_operando}")
            primer_operando: str = p_operandos.get()
            # print(f"primer_operando: {primer_operando}")
            operador: str = t
            # print(f"operador: {operador}")
            operacion = calcular(primer_operando, segundo_operando, operador)
            p_operandos.put(operacion)

    answer: float = float(p_operandos.get())

    return answer


# ================================
# COLAS
# ================================


def copiar_cola(original: Cola) -> Cola:
    answer: Cola = Cola()
    cola_tmp: Cola = Cola()

    while not (original.empty()):
        v = original.get()
        answer.put(v)
        cola_tmp.put(v)

    while not (cola_tmp.empty()):
        v = cola_tmp.get()
        original.put(v)

    return answer


# ================================
# ejercicio 13
# ================================
def generar_nros_al_azar_cola(cantidad: int, desde: int, hasta: int) -> Cola[int]:
    c: Cola[int] = Cola()
    for _ in range(cantidad):
        x: int = random.randint(desde, hasta)
        c.put(x)
    return c


# ================================
# ejercicio 14
# ================================
def cantidad_elementos_cola(c: Cola) -> int:
    res: int = 0
    c_copy: Cola = copiar_cola(c)

    while not c_copy.empty():
        c_copy.get()
        res += 1

    return res


# ================================
# ejercicio 15
# ================================
def buscar_el_maximo_cola(c: Cola[int]) -> int:
    if cantidad_elementos_cola(c) == 0:
        return -1
    c_copy: Cola = copiar_cola(c)
    maximo: int = c_copy.get()

    while not c_copy.empty():
        candidato: int = c_copy.get()
        if candidato >= maximo:
            maximo = candidato
    return maximo


# ================================
# ejercicio 16
# ================================
# ejercicio 16.1


def armar_secuencia_de_bingo_modificada(tamanio: int) -> Cola[int]:
    respuesta: Cola[int] = Cola()
    while cantidad_elementos_cola(respuesta) < tamanio:
        candidato: int = random.randint(0, 99)
        if not pertenece_a_cola(candidato, respuesta):
            respuesta.put(candidato)
    return respuesta


# ejercicio 16.2
def pertenece_a_cola(e: int, c: Cola) -> bool:
    c_copy: Cola = copiar_cola(c)
    while not c_copy.empty():
        elemento_cola: int = c_copy.get()
        if e == elemento_cola:
            return True
    return False


def jugar_carton_de_bingo(carton: Cola[int], bolillero: Cola[int]) -> int:
    aciertos: int = 0
    jugadas: int = 0
    bolillero_copy = copiar_cola(bolillero)
    while not bolillero_copy.empty() and aciertos < 12:
        jugada: int = bolillero_copy.get()
        jugadas += 1
        if pertenece_a_cola(jugada, carton):
            aciertos += 1
    return jugadas


# ================================
# ejercicio 17
# ================================
def n_pacientes_urgentes(c: Cola[(int, str, str)]) -> int:
    respuesta: int = 0
    d: Cola[(int, str, str)] = copiar_cola(c)

    while not d.empty():
        tupla: tuple[int, str, str] = d.get()
        prioridad: int = tupla[0]
        if prioridad <= 3:
            respuesta += 1
    print(c.queue)
    return respuesta


# ================================
# ejercicio 18
# ================================
def concatenar_colas(c1: Cola[any], c2: Cola[any]) -> Cola[any]:
    while not c2.empty():
        c1.put(c2.get())
    return c1


def atencion_a_clientes(c: Cola[str, int, bool, bool]) -> Cola[(str, int, bool, bool)]:
    ans: Cola[(str, int, bool, bool)] = Cola()

    c_copy: Cola[(str, int, bool, bool)] = copiar_cola(c)

    prioridad: Cola[(str, int, bool, bool)] = Cola()
    preferencial: Cola[(str, int, bool, bool)] = Cola()
    resto: Cola[(str, int, bool, bool)] = Cola()

    while not c_copy.empty():
        cliente: tuple[(str, int, bool, bool)] = c_copy.get()
        if cliente[3] == True:
            prioridad.put(cliente)
        elif cliente[3] == False and cliente[2] == True:
            preferencial.put(cliente)
        else:
            resto.put(cliente)

    for cola in [prioridad, preferencial, resto]:
        ans = concatenar_colas(ans, cola)

    return ans


clientes = Cola()
clientes.put(("a", 1, True, False))
clientes.put(("b", 2, True, False))
clientes.put(("c", 3, False, True))
clientes.put(("d", 4, True, True))
clientes.put(("e", 5, False, False))
clientes.put(("g", 7, False, False))
clientes.put(("h", 8, False, False))
clientes.put(("f", 9, False, True))
clientes.put(("f", 10, True, False))


# ================================
# ejercicio  19
# ================================
# ...
# ================================
# ejercicio  20
# ================================
# ...
# ================================
# ejercicio  21
# ================================
# ...
# ================================
# ejercicio  22
# ================================
def visitar_sitio(historiales: dict[str, Pila[str]], usuario: str, sitio: str) -> None:
    p: Pila[str] = Pila()
    if usuario in historiales.keys():
        historiales[usuario].put(sitio)
    else:
        historiales[usuario] = p  # Meto pila para usuario y luego jugar
        historiales[usuario].put(sitio)


def navegar_atras(historiales: dict[str, Pila[str]], usuario: str) -> None:
    if usuario in historiales.keys():
        historiales[usuario].get()


historiales = {}
visitar_sitio(historiales, "YoMama", "duckduckgo.com")
visitar_sitio(historiales, "YoMama", "wiki.archlinux.org")
navegar_atras(historiales, "YoMama")
visitar_sitio(historiales, "Pepito", "altavista.com")


# ================================
# ejercicio  23
# ================================
def agregar_producto(
    inventario: dict[str : dict[str:int]], nombre: str, precio: float, cantidad: int
) -> None:
    inventario[nombre] = {"precio": precio, "cantidad": cantidad}


def actualizar_stock(
    inventario: dict[str : dict[str:int]], nombre: str, cantidad: int
) -> None:
    inventario[nombre]["cantidad"] = cantidad


def actualizar_precios(
    inventario: dict[str : dict[str:int]], nombre: str, precio: float
) -> None:
    inventario[nombre]["precio"] = precio


def calcular_valor_inventario(inventario: dict[str : dict[str:int]]) -> float:
    total: float = 0
    for d in inventario.values():
        total += d["precio"] * d["cantidad"]
    return total


inventario = {}
agregar_producto(inventario, "Camisa", 20.0, 50)
agregar_producto(inventario, "Pantalón", 30.0, 30)
actualizar_stock(inventario, "Camisa", 10)
valor_total = calcular_valor_inventario(inventario)
print(f"Valor total del inventario: {valor_total}")


# (☞⌐▀͡ ͜ʖ͡▀ )☞
# pastebin.com/xabaQTyv
