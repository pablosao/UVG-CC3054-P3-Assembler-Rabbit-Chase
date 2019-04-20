
/************************************************************************************/
/*         Autor: Pablo Sao & Mirka Monzon                                          */
/*         Fecha: 15 de abril de 2019                                               */
/*   Descripcion: Rabbit Chase, donde el objetivo es capturar el conejo en un       */
/*				  tablero.                                          */
/************************************************************************************/

/* configuramos inicio de jugador */
.text
.align 2
.global SETUSR
SETUSR:
	PUSH  {LR}

	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    PRINT5X5		@ Mostramos matriz de inicio

	BL     _confInicio


/*   configura posición inicial de jugador   */
_confInicio:
	MOV   R7, #3
	MOV   R0, #0
	MOV   R2, #1
	LDR   R1, =move
	SWI   0

	LDR   R0, =move
	LDR   R0, [R0]

	PUSH  {R0}
	
	@**     Identificando movimiento
	@**     se le agrega NE a CMP para no permitir
	@**     movimientos en diagonal

	CMP   R0, #'a'
	BLEQ  _subFila		@ jugador a la izquierda

	CMP R0, #'d'
	BLEQ  _addFila		@ jugador a la izquierda

	CMP R0, #'w'
	BLEQ  _subColumna	@ jugador hacia arriba

	CMP R0, #'s'
	BLEQ  _addColumna

	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    PRINT5X5		@ Mostramos matriz de inicio

	POP   {R0}

	CMP   R0, #'c'
	BNE   _confInicio

	POP   {PC}


/*  Movimiento a la izquierda   */
_subFila:
	PUSH  {LR}

	LDR   R4, =colUsr	@ direccion de posicion en columna
	LDR   R2, [R4]		@ posición actual de la columna

	PUSH  {R2}		@ Backup de posición actual de columna

	CMP   R2, #0		@ posición == 0
	MOVEQ R2, #20		@    posicion es columna 5

	CMP   R2, #4		@ posición >= 8
	SUBGE R2, #4		@    Si es >= se resta 4

	@**     actualizando variable de columna con nueva posición
	STR   R2, [R4]


	@**     Nueva posición de jugador	
	LDR   R11, =filaUsr
	LDR   R11,[R11]

	LDR   R1, =displayUsr
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {R2}

	@**     liberando posición anterior de jugador	
	LDR   R11, =filaUsr
	LDR   R11,[R11]

	LDR   R1, =clsDisplay
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {PC}


/*  Movimiento a la izquierda   */
_addFila:
	PUSH  {LR}

	LDR   R4, =colUsr	@ direccion de posicion en columna
	LDR   R2, [R4]		@ posición actual de la columna

	PUSH  {R2}		@ Backup de posición actual de columna

	ADD R2, #4

	CMP   R2, #16		@ posición == 0
	MOVGT R2, #0		@    posicion es columna 0

	@**     actualizando variable de columna con nueva posición
	STR   R2, [R4]


	@**     Nueva posición de jugador	
	LDR   R11, =filaUsr
	LDR   R11,[R11]

	LDR   R1, =displayUsr
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {R2}

	@**     liberando posición anterior de jugador	
	LDR   R11, =filaUsr
	LDR   R11,[R11]

	LDR   R1, =clsDisplay
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R2
	STR   R1, [R12]

	POP   {PC}


/*  Movimiento hacia arriba de jugador   */
_subColumna:
	PUSH  {LR}

	LDR   R3, =colUsr	@ dirección de columna
	LDR   R1, [R3]		@ posición de columna

	LDR   R10, =filaUsr	@ Dirección de fila actual
	LDR   R11, [R10]	@ posición de fila

	BL    IDFILA

	LDR   R2, =clsDisplay	@ Dirección de liberación de posición
	LDR   R2, [R2]		@ valor para liberar posición

	ADD   R12, R1		@ Obtenemos posición en vector
	STR   R2, [R12]		@ liberamos espacio

	CMP   R11, #1
	MOVEQ R11, #5
	SUBNE R11, #1

	STR   R11, [R10]

	BL    IDFILA

	LDR   R2, =displayUsr	@ Dirección de liberación de posición
	LDR   R2, [R2]		@ valor para liberar posición

	ADD   R12, R1
	STR   R2, [R12]

	
	POP   {PC}

/*  Movimiento hacia abajo de jugador  */
_addColumna:
	PUSH  {LR}

	LDR   R3, =colUsr	@ dirección de columna
	LDR   R1, [R3]		@ posición de columna

	LDR   R10, =filaUsr	@ Dirección de fila actual
	LDR   R11, [R10]	@ posición de fila

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

	LDR   R2, =displayUsr	@ Dirección de liberación de posición
	LDR   R2, [R2]		@ valor para liberar posición

	ADD   R12, R1
	STR   R2, [R12]

	
	POP   {PC}



.text
.align 2
.global IDFILA

/* Carga en R12 la fila correspondiente */
@**     R11 -> Numero de fila a cargar, esta esta en variable
@**     R12 -> Retorna dirección de la fila en variable
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

/* limpieza de datos */
CLEAR:
	PUSH  {LR}

	LDR   R0, =clear
	BL    puts

	POP   {PC}

.text
.align 2
.global BANNER

/* Banner de ingreso  */
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

/*  Despliegue del menu  */
MENU:
	PUSH   {LR}

	LDR   R0, =menu 		@ Dirección del menu
	BL    puts			@ Despligue en pantalla

	POP   {PC}


.text
.align 2
.global PRINT5X5

/*  Despliegue del menu  */
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
move:
	.byte ''

.align 2
Entro:
	.asciz "Regreso"

.align 2
tmpDisplay:
	.asciz "Valor %d\n"
