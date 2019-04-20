
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

	MOV   R7, #3
	MOV   R0, #0
	MOV   R2, #1
	LDR   R1, =move
	SWI   0
	
	LDR   R0, =move
	LDR   R0, [R0]
	
	/* Identificando movimiento */
	CMP   R0, #'a' 
	BLEQ  _subFila

	/*LDR   R0, =Entro
	BL    puts*/

	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    PRINT5X5		@ Mostramos matriz de inicio

	POP   {PC}



_subFila:
	PUSH  {LR}

	LDR   R4, =colUsr	@ direccion de posicion en columna

	LDR   R2, [R4]		@ posición actual
	MOV   R3, R2 		@ backup de posicion

	
	CMP   R2, #0		@ posición == 0
	MOVEQ R2, #20		@    posicion es columna 5
	
	CMP   R2, #4		@ posición >= 8
	SUBGE R2, #4		@    Si es >= se resta 4

	@**  actualizando matriz  
	STR   R2, [R4]


	@**

	LDR   R4, =filaUsr	@ Cargando dirección de la fila
	LDR   R4, [R4]		@ Obteniendo valor de la fila

	CMP   R4, #1
	LDREQ R5, =fila1

	CMP   R4, #2
	LDREQ R5, =fila2

	CMP   R4, #3
	LDREQ R5, =fila3

	LDR   R6, =clsDisplay	@ cargando limpieza de posición
	LDR   R6, [R6]

	PUSH  {R5} 		@ Guardando dirección de fila
	ADD   R5, R3		@ sumamos backup de posicion	
	STR   R6, [R5]		@ Liberando espacio

	POP   {R5}		@ Restaurando direccion

	LDR   R6, =displayUsr	@ cargando direccion de vista usuario
	LDR   R6, [R6]		@ obteniendo caracteres
	
	ADD   R5, R2		@ seleccionamos nueva posición
	STR   R6, [R5] 	

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
