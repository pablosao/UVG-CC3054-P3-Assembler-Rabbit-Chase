
/************************************************************************************/
/*         Autor: Pablo Sao & Mirka Monzon                                          */
/*         Fecha: 15 de abril de 2019                                               */
/*   Descripcion: Rabbit Chase, donde el objetivo es capturar el conejo en un       */
/*				  tablero.                                          */
/************************************************************************************/

@****   configuramos inicio de jugador
.text
.align 2
.global SETUSR
SETUSR:
	PUSH  {LR}
	BL    TABLERO5X5
	BL     _confInicio

.text
.align 2
.global TABLERO5X5
TABLERO5X5:
	PUSH  {LR}
	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    PRINT5X5		@ Mostramos matriz de inicio
	POP   {PC}

@****   configura posición inicial de jugador
_confInicio:

	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner

	LDR   R0, =msjconf
	BL    puts

	BL    PRINT5X5		@ Mostramos matriz de inicio

	MOV   R7, #3
	MOV   R0, #0
	MOV   R2, #1
	LDR   R1, =move
	SWI   0

	LDR   R2, =move
	LDRB  R1, [R2]
	STRB  R1, [R2]
	
	LDR   R4, =colUsr
	LDR   R9, =filaUsr
	LDR   R8, =displayUsr
	
	PUSH  {R1}

	@**     Identificando movimiento
	@**     se le agrega NE a CMP para no permitir
	@**     movimientos en diagonal

	CMP   R1, #'a'
	BLEQ  _subFila		@ jugador a la izquierda

	CMP R1, #'d'
	BLEQ  _addFila		@ jugador a la izquierda

/*	CMP R1, #'w'
	BLEQ  _subColumna	@ jugador hacia arriba

	CMP R1, #'s'
	BLEQ  _addColumna
*/
	POP   {R1}

	CMP   R1, #'c'
	BNE   _confInicio

	MOV   R1, #''
	LDR   R2, =move
	STRB  R1, [R2]

	POP   {PC}

.text
.align 2
.global MOVECONEJO
MOVECONEJO:
	PUSH  {LR}

	MOV   R12, #4
	BL    RANDOM
	MOV   R1,R12

	LDR   R4, =colConejo
	LDR   R9, =filaConejo
	LDR   R8, =displayConejo

	CMP   R1, #1
	BLEQ  _subFila		@ jugador a la izquierda

	CMP R1, #2
	BLEQ  _addFila		@ jugador a la izquierda

	CMP R1, #3
	BLEQ  _subColumna	@ jugador hacia arriba

	CMP R1, #4
	BLEQ  _addColumna

	POP   {PC}

.text
.align 2
.global MOVEUSR
@****   movimiento de usuario
MOVEUSR:
	PUSH  {LR}

	MOV   R7, #3
	MOV   R0, #0
	MOV   R2, #1
	LDR   R1, =move
	SWI   0

	LDR   R1, =move
	LDRB  R1, [R1]

	LDR   R4, =colUsr
	LDR   R9, =filaUsr
	LDR   R8, =displayUsr

	@**     Identificando movimiento
	@**     se le agrega NE a CMP para no permitir
	@**     movimientos en diagonal

	CMP   R1, #'a'
	BLEQ  _subFila		@ jugador a la izquierda

	CMP R1, #'d'
	BLEQ  _addFila		@ jugador a la izquierda

	CMP R1, #'w'
	BLEQ  _subColumna	@ jugador hacia arriba

	CMP R1, #'s'
	BLEQ  _addColumna



	POP   {PC}


@****   Movimiento a la izquierda
_subFila:
	PUSH  {LR}

	LDR   R2, [R4]		@ posición actual de la columna

	PUSH  {R2}		@ Backup de posición actual de columna

	CMP   R2, #0		@ posición == 0
	MOVEQ R2, #20		@    posicion es columna 5

	CMP   R2, #4		@ posición >= 8
	SUBGE R2, #4		@    Si es >= se resta 4

	@**     actualizando variable de columna con nueva posición
	STR   R2, [R4]


	@**     Nueva posición de jugador
	LDR   R11,[R9]

	LDR   R1, [R8]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {R2}

	@**     liberando posición anterior de jugador
	LDR   R11,[R9]

	LDR   R1, =clsDisplay
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {PC}



@****  Movimiento a la derecha
_addFila:
	PUSH  {LR}

	LDR   R2, [R4]		@ posición actual de la columna

	PUSH  {R2}		@ Backup de posición actual de columna

	ADD R2, #4

	CMP   R2, #16		@ posición == 0
	MOVGT R2, #0		@    posicion es columna 0

	@**     actualizando variable de columna con nueva posición
	STR   R2, [R4]


	@**     Nueva posición de jugador
	LDR   R11,[R9]

	LDR   R1, [R8]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {R2}

	@**     liberando posición anterior de jugador
	LDR   R11,[R9]

	LDR   R1, =clsDisplay
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {PC}


@****   Movimiento hacia arriba de jugador
_subColumna:
	PUSH  {LR}

	LDR   R1, [R4]		@ posición de columna

	LDR   R11, [R9]	@ posición de fila

	BL    IDFILA

	LDR   R2, =clsDisplay	@ Dirección de liberación de posición
	LDR   R2, [R2]		@ valor para liberar posición

	ADD   R12, R1		@ Obtenemos posición en vector
	STR   R2, [R12]		@ liberamos espacio

	CMP   R11, #1
	MOVEQ R11, #5
	SUBNE R11, #1

	STR   R11, [R9]

	BL    IDFILA

	LDR   R2, [R8]		@ valor para liberar posición

	ADD   R12, R1
	STR   R2, [R12]

	POP   {PC}



@****   Movimiento hacia abajo de jugador
_addColumna:
	PUSH  {LR}

	LDR   R1, [R4]		@ posición de columna

	LDR   R11, [R9]	@ posición de fila

	BL    IDFILA

	LDR   R2, =clsDisplay	@ Dirección de liberación de posición
	LDR   R2, [R2]		@ valor para liberar posición

	ADD   R12, R1		@ Obtenemos posición en vector
	STR   R2, [R12]		@ liberamos espacio

	CMP   R11, #5
	MOVEQ R11, #1
	ADDNE R11, #1

	STR   R11, [R10]

	BL    IDFILA

	LDR   R2, [R8]		@ valor para liberar posición

	ADD   R12, R1
	STR   R2, [R12]

	POP   {PC}



.text
.align 2
.global IDFILA

@****   Carga en R12 la fila correspondiente
@**   R11 -> Numero de fila a cargar, esta esta en variable
@**   R12 -> Retorna dirección de la fila en variable
IDFILA:
	PUSH  {LR}

	CMP   R11, #1
	LDREQ R12, =fila1

	CMP   R11, #2
	LDREQ R12, =fila2

	CMP   R11, #3
	LDREQ R12, =fila3

	CMP   R11, #4
	LDREQ R12, =fila4

	CMP   R11, #5
	LDREQ R12, =fila5


	POP   {PC}

.text
.align 2
.global CLEAR

@****   limpieza de datos
CLEAR:
	PUSH  {LR}

	LDR   R0, =clear
	BL    puts

	POP   {PC}

.text
.align 2
.global BANNER

@**** Banner de ingreso
BANNER:

	PUSH  {LR}

	LDR   R0, =banner		@ Cargamos Texto Rabbit Chase
	BL    puts 			@ Mostramos en pantalla

	LDR   R0, =separador		@ Dirección de separador
	BL    puts			@ Se muestra en pantalla

	LDR   R0, =autores		@ Dirección de autores
	BL    puts			@ Se muestra en pantalla

	LDR   R0, =separador		@ Dirección de separador
	BL    puts			@ Se muestra en pantalla

	POP   {PC}


.text
.align 2
.global MENU

@****  Despliegue del menu
MENU:
	PUSH   {LR}

	LDR   R0, =menu 		@ Dirección del menu
	BL    puts			@ Despligue en pantalla

	POP   {PC}


.text
.align 2
.global PRINT5X5

@****   Despliegue del menu
PRINT5X5:
	PUSH  {LR}		@ Se guarda dirección de llamado

	MOV   R5, #5		@ Control de loop
	LDR   R1, =fila1	@ Se carga dirección de vector 1
	BL    _printM		@ Se llama al método de impresión

	LDR   R0,=new_line	@ Carga dirección de salto de linea
	BL    puts		@ Se imprime en pantalla

	MOV   R5, #5		@ Control de loop
	LDR   R1, =fila2	@ Se carga dirección de vector 1
	BL    _printM		@ Se llama al método de impresión

	LDR   R0,=new_line	@ Carga dirección de salto de linea
	BL    puts		@ Se imprime en pantalla

	MOV   R5, #5		@ Control de loop
	LDR   R1, =fila3	@ Se carga dirección de vector 1
	BL    _printM		@ Se llama al método de impresión

	LDR   R0,=new_line	@ Carga dirección de salto de linea
	BL    puts		@ Se imprime en pantalla

	MOV   R5, #5		@ Control de loop
	LDR   R1, =fila4	@ Se carga dirección de vector 1
	BL    _printM		@ Se llama al método de impresión

	LDR   R0,=new_line	@ Carga dirección de salto de linea
	BL    puts		@ Se imprime en pantalla

	MOV   R5, #5		@ Control de loop
	LDR   R1, =fila5	@ Se carga dirección de vector 1
	BL    _printM		@ Se llama al método de impresión

	LDR   R0,=new_line	@ Carga dirección de salto de linea
	BL    puts		@ Se imprime en pantalla

	POP   {PC}		@ Se retorna a la rutina de procedencia

_printM:

	MOV   R7, #4
	MOV   R0, #1
	MOV   R2, #4
	SWI   0

	ADD   R1, #4

	SUBS  R5, #1
	CMP   R5, #0
	BNE   _printM
	MOV  PC, LR



/****************************************/
/*		Area de Datos		*/
/****************************************/
.data
.align 2
banner:
	.asciz "\033[32m
 ______          _      _      _             _______  _
(_____ \\        | |    | |    (_)   _       (_______)| |
 _____) ) _____ | |__  | |__   _  _| |_      _       | |__   _____   ___  _____
|  __  / (____ ||  _ \\ |  _ \\ | |(_   _)    | |      |  _ \\ (____ | /___)| ___ |
| |  \\ \\ / ___ || |_) )| |_) )| |  | |_     | |_____ | | | |/ ___ ||___ || ____|
|_|   |_|\\_____||____/ |____/ |_|   \\__)     \\______)|_| |_|\\_____|(___/ |_____)\033[0m\n"

.align 2
separador:
	.asciz "\033[36m----------------------------------------------------------------------------------\033[0m\n"

.align 2
autores:
	.asciz "\033[33m      ()_()\033[0m                                                      \033[33m()_()\033[0m
\033[33m      (o o)\033[0m             by Pablo Sao & Mirka Monzon              \033[33m(o o)\033[0m
\033[33m  ooO--(_)--Ooo\033[0m                     2019                     \033[33mooO--(_)--Ooo\033[0m\n"

.align 2
clear:
	.asciz "\033[H\033[J"

.align 2
instrucciones:
	.ascii ""

.align 2
menu:
	.ascii "\t\t\tMenú \n\t1). Iniciar Partida. \n\t2). Salir.\n"

.align 2
new_line:
	.ascii "\n"


.align 2
Entro:
	.asciz "Regreso"

.align 2
tmpDisplay:
	.asciz "Valor %d\n"

.align 2
msjconf:
	.ascii "Seleccione posición\n"
