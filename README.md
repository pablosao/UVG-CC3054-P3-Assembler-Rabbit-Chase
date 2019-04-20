# Proyecto 3: Rabbit Chase

El objetivo del juego es atrapar un “conejo” antes que escape del tablero de 5x5.  El jugador (H) selecciona como punto de partida cualquier posición de inicio de las 
filas o columnas externas. El conejo (B) aparece en el centro del tablero.  Para su siguiente movimiento, el jugador puede elegir únicamente casillas vecinas a su última 
posición.  En su siguiente movimiento, el conejo elige de forma aleatoria cualquiera de los 9 cuadros vecinos y decide una dirección. En el tercer movimiento, el conejo 
solamente podrá elegir una de las 3 casillas vecinas en la dirección elegida.  El jugador gana si elige la misma casilla elegida por el conejo en el siguiente movimiento 
(X). Se acaba el juego si el conejo sale del tablero (B!) alcanzando cualquiera de las posiciones en las filas o columnas externas.  

# Requisitos

* Raspberry Pi B+

# Como ejecutar el probrama

Para ejecutar el juego debemos colocar los archivos de assembler (.s) en un mismo directorio, y posicionarnos desde la terminal en dicha locación y poder compilar el código
con el siguiente comando:

```bash
$ gcc -o RabbitChase var.s rutinas.s RabbitChase.s  
```

Para iniciar el juego, ejecutamos en la terminal el siguiente comando:

```bash
$ ./RabbitChase
```



# Referencias

* Bandara, N. (2017). _Answer to How to Print colored String in ARM Assembly_. Extraído de: https://stackoverflow.com/questions/46084673/how-to-print-colored-string-in-arm-assembly

* Barnes, R. (2015). _Answer to List of ANSI Color Scape Sequences_. Extraído de: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

* Bramley, J. (2019). _Condition Codes 1: Condition Flags and Codes_. Extraído de: https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/condition-codes-1-condition-flags-and-codes

* Manzke, M. (2007). _2 - Dimensional Arrays_. Extraído de: https://www.scss.tcd.ie/Michael.Manzke/1ba3/1BA3_33_hll.pdf

* Smith, B. (2014). _Raspberry Pi Assembly Language_. Segunda edición. California, Estados Unidos: CreateSpace. 53, 72-73, 88 - 94 pp.
