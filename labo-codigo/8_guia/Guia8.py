import typing
from queue import LifoQueue as Pila
from queue import Queue as Cola
import csv 
import random 

# EJERCICIO 1 #

# a)
def contarlineas(nombre_del_archivo: str) -> int:
    file = open(nombre_del_archivo, 'r')
    lines: list[str] = file.readlines()
    file.close()
    return len(lines)

# print(contarlineas('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# b) ( crear funcion pertence para remplazar el in) ==> if (pertenece(palabra , lines) or pertenece(palabra + '\n' , lines))
def existepalabra(palabra:str , nombre_archivo:str) -> bool:
    res : bool = False
    file = open(nombre_archivo , 'r' , encoding ='UTF-8')
    lines : list[str] = file.readlines()
    file.close()
    if (palabra in lines or (palabra + '\n') in lines):
        res = True 
    return res

def separar_en_palabras_2(linea: str) -> list[str]:
    palabras = []
    palabra = ""
    separadores = {' ', '"', '\n'}
    for caracter in linea:
        separador = False
        for sep in separadores:
            if caracter == sep:
                separador = True
                break
        if not separador:
            palabra += caracter
        else:
            if palabra:
                palabras.append(palabra)
                palabra = ""
    if palabra:
        palabras.append(palabra)
    return palabras
# print(separar_en_palabras_2("hola como estas"))

def perteneceSTRaLinea(s:str , l:list[str]) -> bool:
    res : bool = False # asumo false para ir toqueteandolo
    longitud : int = len(l) # longitud ed la lista a recorrer
    for i in range (longitud): # desde i = 0 hasta la longitud ed la lista
        if l[i] == s: # si el iesimo elemento de l es s
            res = True  # dame true
    return res # si no se cumple el if me devolves false

#print(perteneceSTRaLinea("" , ["franco" , "pepe" , "1,2,3,4,5" , "pedro" , "cami" , "niki" , "flor" , "luli" , "marqui" , "lean" , ""]))

def separar_en_palabras(linea:str) -> list[str]:
    palabras : list[str] = [] #lista que va a tener las palabras
    palabra : str = "" # la hago vacio para ir metiendo char x char
    for caracter in linea: # por cada caracter que haya en el string 
        if caracter == " " or caracter == '"' or caracter == '\n': # si el char es algun espacio
            palabras.append(palabra) # lo que formaste como palabra, mandalo a la lista de palabras
            palabra = "" # resetea palabra para seguir metiendole cosas 
        else:
            palabra += caracter #mandale los chars a palabra
    palabras.append(palabra) #termina metiendo las palabras que formaste a la lista final
    return palabras  # devolveme esa lista final

#print(separar_en_palabras("hola como estas"))

def existePalabraVersionLegit(palabra:str ,archivo:str) -> bool:
    archivo : typing.IO = open(archivo , 'r' , encoding="utf-8") # lo abro en reading para q lea la data
    linea : str  # linea es un str
    for linea in archivo: # por cada str que haya en el archivo
        palabras : list[str] = separar_en_palabras(linea) # convierto palabras a lista de str para usar mi funcion de pertenece
        if perteneceSTRaLinea(palabra,palabras): # si el string esta es alguna de las palabras separadas de la lista
            return True  # devolvé true
    archivo.close() #lo cerramo
    return False  # si no se cumple nada dame false 

# print(existePalabraVersionLegit("Ñoqui" , 'C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# c)
def cantidadapariciones(palabra:str , nombre_del_archivo : str) -> int:
    contador : int = 0 # creo un contaor para ir guardando cuantas veces aparece el str
    file = open(nombre_del_archivo , 'r' , encoding = "UTF-8") # lo abrimos en reading
    lines : list[str] = file.readlines() # leemos las lineas 
    for line in lines: # por cada linea en las lineas leidas
        contador += line.count(palabra) # contador + contar cuantas veces aparece el str
    return contador # dame el contador

# print(cantidadapariciones("hola" , 'C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# EJERCICIO 2 #

def clonarSinComentarios(nombre_del_archivo : str):
    sincomentarios : list[str] = [] #creo la lista de lineas que van a ser sin comments 
    file = open(nombre_del_archivo , 'r' , encoding = "UTF-8") # lo abrimos en read 
    lines : list[str] = file.readlines() # leemos las lineas
    file.close() # cerramo
    for line in lines: # por cada linea en las lineas leidas
        if not (perteneceSTRaLinea("#" , line)): # si el "#"" no esta presente en la linea
            sincomentarios.append(line) # mandalo a mi lista final de lineas sin comments
            
    fileSinComentarios = open(nombre_del_archivo + "-copy.txt" , 'w') # le pido que cree un archivo que va a escribir desde 0
    fileSinComentarios.writelines(sincomentarios) # anda typeando lo que guardaste como lineas sin comments en el nuevo archivo
    
#print(clonarSinComentarios('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# SOLUCION DEL PROFE # 
 
def es_comentario(linea: str)-> bool:
    i: int = 0 

    while (i < len(linea) and linea[i] == ' '):   # i < len(linea) es por si hay una linea con todos blancos, se puede indefinir sino
        i += 1 # si hay espacios ,segui fijandote hasta encontrar un char
    return i < len(linea) and linea[i] == '#'  # va a ser true si la linea cumple con todo esto

#print(es_comentario("#hla")) # T
#print(es_comentario("     #ajkfhas")) # T
#print(es_comentario("hola")) # F

def clonar_sin_comentarios(nombre_archivo: str) -> None:
    arch: typing.IO = open(nombre_archivo,"r")
    arch_clonado: typing.IO = open("clonado.txt","w")   # si hago open(nombre_archivo,"w") y nombre_archivo no existe, se crea uno nuevo
    lineas: list[str] = arch.readlines()

    for linea in lineas:
        if (not es_comentario(linea)):
            arch_clonado.write(linea)
    arch.close()
    arch_clonado.close()

#clonar_sin_comentarios('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt')

# EJERCICIO 3 #

def invertir_lista(lista: list[str]) -> list[str]:
    longitud : int = len(lista) # tipica longitud
    lista_invertida : list[str] = [] # le voy a ir mandando los elementos de ultimo a primero uno x uno
    for i in range(longitud - 1, -1, -1): # va copiando los elmentos de ultimo a primero y va pasos para atras, por eso el -1 al final
        lista_invertida.append(lista[i]) # mete en mi lista invertida esos elementos
    return lista_invertida # dame la lista que crafteaste 

# print(invertir_lista(["hola","chau"]))

def invertir_archivo(name:str):
    file : typing.IO = open(name , 'r' , encoding = "UTF-8") # lo abrimos en read
    lines : list[str] = file.readlines() #leemos todas las lineas 
    file.close() # cerramo
    lines = invertir_lista(lines) # creo una variable que invierte las lineas 
    file_r = open('reverso.txt' , 'w' , encoding = "UTF-8") # creo el archivo que va a tener todo dado vuelta 
    for line in lines:  # hago bucle que va por cada linea que hay en  lineas 
        file_r.write(line) # escribo cada linea de la lista de lineas invertidas 
    file_r.close() # cierro x las dudas
    return  # damelo ;)

# print(invertir_archivo('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# EJERCICIO 4 # 

def agregar_frase_al_final(frase:str , name:str):
    file : typing.IO = open(name , 'a' , encoding = "UTF-8") # lo abro con append para tocar el final nomas
    file.write(frase) # le mando la frase 
    file.close() # lo cierro
    return  # devuelvo 
     
# print(agregar_frase_al_final(" { skibidi } " , 'C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt'))

# EJERCICIO 5 # 

def agregar_frase_al_principio(frase:str , name:str):
    file : typing.IO = open(name , 'r' , encoding = "UTF-8" ) # abro el archivo en read
    fileaux = file.read() # leo todo el archivo para guardarme la data
    newfile : typing.IO = open(name , 'w' , encoding = "utf-8") # creo un nuevo archivo que va a tener toda la data del original pero vanilla, sin tocar nada
    fileaux = frase + '\n' + fileaux  # creo una variable que va a guardar primero el input , mete enter, y copia todo lo que tiene el archivo vanilla
    newfile.write(fileaux) # transcribo esta variable con el input primero y desp el archivo vanilla, en un nuevo archivo
    file.close() # cerramo 
    newfile.close()# cerramo
    return  # nos fuimos
    
#print(agregar_frase_al_principio(" { pepe } " ,'C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo.txt' ))
    
# EJERCICIO 6 #

# func de caracteres validos:
def caracterValido(c : str) -> bool:
    return ('a' <= c <= 'z') or ('A' <= c <= 'Z') or ('0' <= c <= '9') or (c == ' ') or (c == '_') # chequeo caracter x caracter si es valido o no

# print(caracterValido("a"))

def listar_palabras_de_archivo(name : str) -> list:
    file : typing.IO = open(name , 'rb') # abro el archivo en read byte
    bytes : list[int] = file.read() # mi lista de bytes va a ser el contenido de larchivo entero
    file.close() # cerramos
    resultado : list[str] = [] # creo una lista a la q le voy a ir mandando las palabras validas 
    palabra_actual : str = "" # variable que va a ir metiendo caracteres validos para formar palabras validas
    for byte in bytes: # por cada byte en bytes, siendo bytes todas las lineas de mi archivo
        char : str = chr(byte) # convierto el byte a un char, para q me devuelva una letra correspondiente al byte que leyó
        if caracterValido(char): # si ese char quie devuelve, es un caracter valido
            palabra_actual += char  # metelo en mi futura palabra valida
        else: # sino
            if len(palabra_actual) >= 5: # si ese char no es valido pero la longitud de la palabra que vengo formando, es mayor o igual a 5
                resultado.append(palabra_actual) # mete esa palabra que formaaste a mi lista de palabras validas
            palabra_actual = "" # vacia esa palabra que tenias para seguir formando palabras validas
    return resultado # DAMELO YA!

# EJERCICIO 7 # 

def suma_total(lista : list[float]) -> float:
    contador = 0.0
    for i in lista:
        contador += i 
    return contador

def promedio_estudiante(nombre_archivo: str , lu: str) -> float:
    notas_lu : list[float] = []
    archivo : typing.IO = open(nombre_archivo , 'r')
    contenido : list[str] = archivo.read()
    print(contenido)
    
    for _ in contenido:
        if lu == contenido[0]:
            notas_lu.append(contenido[3])
    
    
    if notas_lu:
        promedio = (suma_total(notas_lu) / len(notas_lu))
    else:
        promedio = 0.0
    
    return promedio
        
#print(promedio_estudiante('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\notas.csv', "10/24"))

# EJERCICIO 7 (DE UN COMPA) #

lu = ["10/24" , "20/24" , "30/24" , "40/24"]

def calcular_promedio_por_estudiante(nombre_archivo_notas: str, nombre_archivo_promedios: str):
    arch = open(nombre_archivo_promedios, "w")
    arch.write(str(promedio_estudiante(nombre_archivo_notas, "20/24")))
    arch.close()

def promedio_estudiante(nombre_archivo: str, lu: str):
    palabra:str = ""
    es_alumno:bool = False
    notas:int = 0
    cant_notas: int = 0
    
    archivo = open(nombre_archivo, "r")
    lineas:list = archivo.readlines()
    
    for linea in lineas:
        for char in linea:
            if char == "," and palabra == lu:
                es_alumno = True
                palabra = ""
            elif char == ",":
                palabra = ""
            elif es_alumno and char == "\n":
                notas += float(palabra)
            else:
                palabra += char
                
        palabra = ""
        
        if es_alumno:
            cant_notas += 1
            es_alumno = False
            
    if cant_notas > 0:
        promedio = notas / cant_notas
    else:
        promedio = 0 
    
    return promedio

#print(promedio_estudiante('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\notas.csv' , "10/24"))
#print(calcular_promedio_por_estudiante('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\notas.csv' ,'C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\notas_promedios.csv' ))

def promedio_estudiante_2(nombre_archivo:str, lu:str) -> float:
    archivo = open(nombre_archivo,"r")
    lector = csv.reader(archivo)
    total_notas = 0
    cantidad_notas = 0

    for fila in lector:
        nro_lu, materia, fecha, nota = fila
        if nro_lu == lu:
            total_notas += float(nota)
            cantidad_notas += 1 
    
    if cantidad_notas == 0:
        return 0.0
    else: return total_notas / cantidad_notas

def calcular_prom_por_estudiante_2(nombre_archivo_notas: str, nombre_archivo_promedios: str) -> None:
    estudiantes_cargados: list[str] = []

    archivo_promedios = open(nombre_archivo_promedios,"w")
    escritor_csv = csv.writer(archivo_promedios)
    escritor_csv.writerow(['nro de LU', 'promedio'])
   
    archivo_notas = open(nombre_archivo_notas, "r")
    lector_csv_notas = csv.reader(archivo_notas)

    for fila in lector_csv_notas:
        nro_lu = fila[0]
        if nro_lu not in estudiantes_cargados:
            promedio = promedio_estudiante(nombre_archivo_notas, nro_lu)
            escritor_csv.writerow([nro_lu, promedio])
            estudiantes_cargados.append(nro_lu)

# Crear el archivo 'notas.csv'
# with open('notas.csv', 'w', newline='') as archivo_notas:
#     escritor_csv = csv.writer(archivo_notas)
#     escritor_csv.writerow(['12345', 'Matemáticas', '2023-03-01', 8.5])
#     escritor_csv.writerow(['12345', 'Historia', '2023-03-15', 7.0])
#     escritor_csv.writerow(['67890', 'Literatura', '2023-03-01', 9.0])
#     escritor_csv.writerow(['67890', 'Física', '2023-03-15', 8.0])
#     escritor_csv.writerow(['67890', 'Química', '2023-04-01', 7.5])
#     escritor_csv.writerow(['11223', 'Matemáticas', '2023-03-01', 6.0])
#     escritor_csv.writerow(['11223', 'Historia', '2023-03-15', 5.5])
#     escritor_csv.writerow(['12345', 'Física', '2023-04-01', 9.0])

# Crear un archivo 'promedios.csv' vacío
# with open('promedios.csv', 'w', newline='') as archivo_promedios:
#     escritor_csv = csv.writer(archivo_promedios)
#     escritor_csv.writerow(['nro de LU', 'promedio'])

# nombre_archivo_notas = 'notas.csv'
# nombre_archivo_promedios = 'promedios.csv'
# calcular_prom_por_estudiante(nombre_archivo_notas, nombre_archivo_promedios)

# EJERCICIO 8 #
def generar_nros_al_azar(cantidad : int , desde : int , hasta : int) -> Pila[int]:
    p = Pila()
    
    for _ in range(cantidad):
        n = random.randint(desde , hasta)
        p.put(n)
    return p.queue

#print(generar_nros_al_azar(100,0,99))

# EJERCICIO 9 # 

def contar_elementos_pila(p: Pila) -> int: 
    cantidad: int = 0 # arranca en 0
    pilaAUX = Pila() # creo una pila aux para no tocar la original, pq es un dato IN 

    while (not p.empty()): # si la pila vanilla no esta vacia 
        elem = p.get()  # agarra el primer elemento 
        cantidad += 1 # como agarraste algo, sumale 1 a cantidad de elementos
        pilaAUX.put(elem) # ponele ese elemento de la pila vanilla a la aux 
    while(not pilaAUX.empty()): # si la pila aux no esta vacia 
        elem = pilaAUX.get() # agarra el primer elemento
        p.put(elem) # poneselo a la pila vanilla 
    return cantidad # dame cantidad

pila1 = Pila()
pila1.put(4)
pila1.put(9)

#print(contar_elementos_pila(pila1))
#print(contar_elementos_pila(pila1))

# EJERCICIO 10 #
def copiar_pila(p:Pila) -> Pila:
    paux = Pila() 
    res = Pila()
    while not p.empty():
        elem = p.get()
        paux.put(elem)
    while not paux.empty():
        elem = paux.get()
        p.put(elem)
        res.put(elem)
    return res 
 
def buscar_el_maximo(p:Pila[int]) -> int:
    paux = copiar_pila(p)
    max : int = paux.get()
    while not p.empty():
        elem : int = paux.get()
        if elem > max:
            max = elem 
    return max 

# EJERCICIO 11 # 

# Lo encaro con la logica de que: Por cada parentesis que abre, hay uno que cierra, entonces, voy a ir extrayendo cada parentesis que abre y poniendolo en una pila
# cada vez que aparezca un parentesis que cierra, saco ese parentesis que abre, entonces al final, si en algun momento tengo una pila vacia, pero justo estoy parado en
# un parentesis que cierra, entonces no está balanceada. Y si ya recorrí todo el string, devuelvo la pila, y si no está vacia, significa que nop estaba balanceada
# pues por cada parentesis que ciera, se saca el parentesis que abre, entonces no tenia misma cantidad de parentesis que cierran que de los que abren

def esta_bien_balanceada(s:str) -> bool:
    p = Pila()
    
    for char in s:
        if char == '(': # apertura de parentesis
            p.put(char)
        elif char == ')': # lo cierra
            if p.empty():
                return False 
            p.get() # por cada parentesis que cierra, deberia haber uno que abre, si está balanceada
    return p.empty() # si esta bien balanceada, tiene que dar true, porque por cada '(' hay un ')' que lo satisface

#print(esta_bien_balanceada("1 + ( 2 x 3 - ( 20 / 5 ) )"))  # True
#print(esta_bien_balanceada("10 * ( 1 + ( 2 * ( -1)))"))    # True
#print(esta_bien_balanceada("1 + ) 2 x 3 ( ( )"))           # False
#print(esta_bien_balanceada("((()))"))                      # True
#print(esta_bien_balanceada("(()"))                         # False
#print(esta_bien_balanceada("()()()"))                      # True

# EJERCICIO 12 # 

def pertenece(e, lista: list) -> bool:
    res: bool = False
    for i in lista:
        if e == i:
            res = True
    return res

def operar(a, b, operador) -> float:
    res: float = 0

    if operador == '+':
        res = a + b
    elif operador == '-':
        res = a - b
    elif operador == '*':
        res = a * b
    elif operador == '/':
        res = a / b

    return res

def evaluar_expresion(s: str) -> float:
    operadores = ['+', '-', '*', '/']
    p = Pila()

    for i in s:
        if pertenece(i, operadores):
            a = p.get()
            b = p.get()
            p.put(operar(b, a, i))
        elif i != ' ':
            p.put(int(i))

    return p.get()

print(evaluar_expresion("3 4 + 5 * 2 -"))

# EJERCICIO 13 # 

def generar_numeros_al_azar(cantidad : int , desde:int , hasta:int) -> Cola:
    c = Cola()
    for i in range(cantidad):
        n = random.randint(desde, hasta)
        c.put(n)
    return c.queue

#print(generar_numeros_al_azar(10,1,5))

# EJERCICIO 14 #

def contar_elementos_cola(c: Cola) -> int:
    caux = Cola()
    contador : int = 0
    while not c.empty():
        elemento = c.get()
        caux.put(elemento)
        contador += 1 
    while not caux.empty():
        elemento = caux.get()
        c.put(elemento)
    return contador

c = Cola()
c.put(1)
c.put(2)
c.put(3)
c.put(4)
c.put(100000)

#print(contar_elementos_cola(c))
#print(contar_elementos_cola(c)) # con la segunda vez, chequeo que no se modifique la cola ;)

# EJERCICIO 15 # 

def copiar_cola(c: Cola) -> Cola:
    caux = Cola()
    c_copia = Cola() 
    while not c.empty():
        elemento_c = c.get()
        caux.put(elemento_c)
    while not caux.empty():
        elemento_caux = caux.get()
        c.put(elemento_caux)
        c_copia.put(elemento_caux)
    return c_copia

def buscar_maximo_cola(c: Cola[int]) -> int:
    caux = copiar_cola(c)
    maximo = caux.get()
    while not caux.empty():
        elemento = caux.get()
        if elemento > maximo:
            maximo = elemento
    return maximo 

p = Cola()
p.put(133)
p.put(211)
p.put(23233)
p.put(50000)
p.put(100000)

# print(buscar_maximo_cola(p))

# EJERCICIO 16 # 

def armar_secuencia_de_bingo(c:Cola) -> Cola[int]:
    cantidad_de_n : int = 12 
    for i in range(cantidad_de_n):
        n_random = random.randint(0,99)
        c.put(n_random)
    return c

s = Cola()

#print(armar_secuencia_de_bingo(s).queue) # muestro mi carton de bingo

def jugar_carton_de_bingo(carton : list[int] , bolillero : Cola[int]) -> int:
    
    print(f"Tu carton para jugar es: {carton}\n ----------")
    print(f"Tu bolillero para jugar es {bolillero.queue}")
    
    jugadas : int = 0 
    
    while not bolillero.empty():
        jugadas += 1 
        bolilla = bolillero.get()
        for i in range (len(carton) -1 , -1 , -1):
            if carton[i] == bolilla:
                carton.pop(i)
                break 
        if not carton:
            break
    print(f"Te tomó {jugadas} jugadas completar el carton")
    return jugadas 

#print(jugar_carton_de_bingo([1,4] , armar_secuencia_de_bingo(s)))


def armarSecuencideBingo2() -> Cola:
    #armo una lista con los numeros del 0 al 9
    lista: list = list(range(0,10))
    #desordena de forma random la lista
    random.shuffle(lista)
    #creo una cola y la lleno con los elementos de la lista
    bolillero: Cola = Cola()
    for bolilla in lista:
        bolillero.put(bolilla)
    return bolillero

def jugarCartonDeBingo(carton: list, bolillero: Cola) -> int:
    cantSinMarcar: int = len(carton)
    jugadas: int = 0
    bolilleroAux: Cola = Cola()
    #mientras no marque todos los numeros del carton saco bolillas
    while cantSinMarcar > 0:
        num: int  = bolillero.get()
        bolilleroAux.put(num)
        if num in carton:
            cantSinMarcar -= 1
        jugadas += 1
    
    while not bolillero.empty():
        num: int  = bolillero.get()
        bolilleroAux.put(num)
        
    while not bolilleroAux.empty():
        num: int  = bolilleroAux.get()
        bolillero.put(num)
    
    return jugadas


bolillero = armarSecuencideBingo2()
carton = [1,5]

"""
print("\nEste es tu carton:")
print(carton)
print("\nEste es tu bolillero:")
print(list(bolillero.queue))
print("\nEstos son los intentos que te tomó llenar el carton del bingo:")
print(jugarCartonDeBingo(carton,bolillero))
print("\n")
"""

# EJERCICIO 17 # 

def n_pacientes_urgentes(c: Cola[(int,str,str)]) -> int:
    caux = copiar_cola(c) # laburo con una cola aux para no sacarle nada a la posta ;)
    pacientes_urgentes : int = 0
    while caux.empty() == False:
        if caux.get()[0] < 4:
            pacientes_urgentes += 1 
    return pacientes_urgentes
        
#c = Cola()
#     prioridad ;     nombre     ;    medico
#c.put((   2     , 'Pepito'       , 'Cardiologia'))
#c.put((   4     , 'Sech'         , 'Neurologia'))
#c.put((   1     , 'Manuelito'    , 'Pediatria'))
#c.put((   3     , 'Papadopoulos' , 'Traumatologia'))
#c.put((   5     , 'Luis'         , 'Ginecologia'))

#print(n_pacientes_urgentes(c))  # 3

# EJERCICIO 18 # 

"""lista_banco: Cola = Cola()

def ingresar_atencion():
    nombre: str = str(input("Ingrese Nombre y Apellido: "))
    dni: int = int(input("Ingrese numero de DNI: "))
    if 3000000 < dni < 47000000:
        cuenta: str = str(input("Su cuenta es preferencial? (si/no): "))
        prioridad: str = str(
            input("Es +65, embarazada o con movilidad reducida? (si/no): "))
        print("Ingresando...\n------")

        cliente = [nombre, dni, cuenta, prioridad]

        return lista_banco.put(cliente)
    else:
        print("Dni invalido")

def atencion_a_clientes(fila: Cola) -> Cola:
    prioridad: Cola = Cola()
    preferencial: Cola = Cola()
    resto: Cola = Cola()

    while not fila.empty():
        cliente = fila.get()
        if cliente[-1] == "si":
            prioridad.put(cliente)
        if cliente[-2] == "si":
            preferencial.put(cliente)
        if cliente[-1] != "si" and cliente[-2] != "si":
            resto.put(cliente)
    # ordenamos los clientes de acuerdo a sus necesidades

    res: Cola = prioridad
    while not preferencial.empty():
        res.put(preferencial.get())
    while not resto.empty():
        res.put(resto.get())
    # creamos la cola final, en el orden prioridad, preferencial, resto

    return res

for i in range(3):
    ingresar_atencion()
fila = list(atencion_a_clientes(lista_banco).Cola)
print(fila)
"""


def atencion_a_clientes(c: Cola) -> Cola:
    cola_prioridad = Cola()
    cola_preferencial = Cola()
    cola_resto = Cola()
    
    # Procesar todos los clientes de la cola original
    while not c.empty():
        cliente = c.get()
        nombre, dni, preferencial, prioridad = cliente
        
        if prioridad: # si prioridad == True
            cola_prioridad.put(cliente)
        elif preferencial:
            cola_preferencial.put(cliente)
        else:
            cola_resto.put(cliente)
    
    # Crear la cola final
    cola_atencion = Cola()
    
    # Añadir primero los clientes con prioridad pq FIFO => FIRST IN FIRST OUT
    while not cola_prioridad.empty():
        cola_atencion.put(cola_prioridad.get())
    
    # Añadir luego los clientes preferenciales
    while not cola_preferencial.empty():
        cola_atencion.put(cola_preferencial.get())
    
    # Añadir finalmente el resto de los clientes
    while not cola_resto.empty():
        cola_atencion.put(cola_resto.get())
    
    return cola_atencion

# Ejemplo de uso
c = Cola()
c.put(("Juan Perez", 12345678, False, True))  # Prioridad
c.put(("Ana Gomez", 87654321, True, False))   # Preferencial
c.put(("Pedro Sanchez", 11223344, False, False))  # Resto
c.put(("Maria Rodriguez", 33445566, True, False)) # Preferencial
c.put(("Luis Garcia", 55667788, False, True))  # Prioridad

cola_atencion = atencion_a_clientes(c)

# Mostrar la cola final de atención
#while not cola_atencion.empty():
#    print(cola_atencion.get())

# EJERCICIO 19 # 

def agrupar_por_longitud(nombre_archivo: str) -> dict:
    diccionario = {}
    cant_caracteres: int = 0
        
    arch = open(nombre_archivo, "r")
    texto = arch.read()
    
    for char in texto:
        if char == " " or char == "\n" or char == "\0":
            if cant_caracteres > 0:
                if cant_caracteres in diccionario.keys(): # se puede usar in con dicts :)
                    cant_palabras = diccionario[cant_caracteres]
                    cant_palabras += 1
                    diccionario[cant_caracteres] = cant_palabras
                    cant_caracteres = 0
                else:
                    diccionario[cant_caracteres] = 1
                    cant_caracteres = 0
    if cant_caracteres > 0:    
        if char != " " and char != "\n":
            cant_caracteres += 1

    arch.close()
    
    return diccionario

#print(agrupar_por_longitud('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\archivo_copy.txt'))

# EJERCICIO 20 # 

"""def promedio_estudiante_diccionarios(nombre_archivo : str , lu : str) -> float: # la codie y no la usé, soy un retrasado 
    suma_de_las_notas : float = 0.0
    cantidad_de_notas : float = 0.0 
    
    file = open(nombre_archivo , 'r')
    lineas = csv.reader(file)
    
    for fila in lineas:
        nro_lu , materia , fecha , nota = fila 
        if nro_lu == lu: # si lu es el del csv
            suma_de_las_notas += float(nota) # suma los float de cada nota que tiene
            cantidad_de_notas += 1 # por cada nota que sumas, agrega 1 nota al contador de notas
    
    if cantidad_de_notas == 0.0 or 0:
        return 0.0 
    
    return suma_de_las_notas / cantidad_de_notas # promedio de alumno
"""

def calcular_promedio_por_estudiante_diccionarios(nombre_archivo : str) -> dict[str,float]:
    promedios_alumnos : dict = {}
    datos_alumnos : dict = {}
    
    # leo el archivo
    file = open(nombre_archivo , 'r')
    lineas = csv.reader(file)
    for fila in lineas:
        if len(fila) < 4: # chequeo que la fila tenga las 4 tipos de dato que necesito
            continue
        nro_lu , materia, fecha, nota = fila 
        if not nro_lu in datos_alumnos: # si el numero de lu no esta en el diccionario, el diccionario de ese alumno lo hago vacio, asi voy metiendo datos
            datos_alumnos[nro_lu] = [] # convierto el dict a vacio
        datos_alumnos[nro_lu].append(float(nota)) # agrego la nota como dato del diccionario
    
    # promedio de cada estudiante 
    for nro_lu , notas in datos_alumnos.items(): # para nro_lu y notas dentro de los elementos de datos_alumnos
        promedio = suma_total(notas) / len(notas)
        promedios_alumnos[nro_lu] = promedio # el duiccionario termina teniendo la forma: {LU : PROMEDIO}
        
    return promedios_alumnos    
    
print(calcular_promedio_por_estudiante_diccionarios('C:\\Users\\Franco\\Desktop\\Programación\\AED1\\Python\\Guia8\\notas.csv'))
    
# EJERCICIO 21 # 

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
