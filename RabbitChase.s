
/************************************************************************************/ 
/*         Autor: Pablo Sao & Mirka Monzon                                          */ 
/*         Fecha: 11 de abril de 2019                                               */ 
/*   Descripcion: Rabbit Chase, donde el objetivo es capturar el conejo en un       */ 
/*				  tablero.                                          */ 
/************************************************************************************/ 

.text 
.align 2 
.global main 
.type main, %function 

main: 
	STMFD SP!, {LR} 

	@**    Inicializando matriz
	BL    _initMatrix
	
	@**    Desplegando inicio
	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    MENU 		@ Mostramos Menú

	/*   Ingreso de opción   */

	LDR   R0, =msjOpcion
	BL    puts

	/*   Ingreso de teclado   */

	LDR   R0, =fIngreso
	LDR   R1, =opcionIn
	BL    scanf

	/*   verificamos que se haya ingresado un número   */
	CMP   R0, #0
	BEQ   _error

	/*   Identificación de operaciones   */
	LDR   R0, =opcionIn
	LDR   R0, [R0]

	CMP   R0, #1
	BLEQ  _startPlay

	CMP   R0, #2
	BLEQ   _exit
	BLGT  _error


_initMatrix:
	PUSH  {LR}
	
	@**     Posición inicial de jugador
	LDR   R0, =colUsr
	LDR   R0, [R0]
	
	LDR   R11, =filaUsr
	LDR   R11,[R11]

	LDR   R1, =displayUsr
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R0
	STR   R1, [R12]


	@**     Posición inicial de conejo
	LDR   R0, =colConejo
	LDR   R0, [R0]
	
	LDR   R11, =filaConejo
	LDR   R11,[R11]

	LDR   R1, =displayConejo
	LDR   R1, [R1]

	BL    IDFILA

	ADD   R12, R0
	STR   R1, [R12]

	POP   {PC}	

_error:
	LDR   R0, =opcionIn
	MOV   R1, #0
	STR   R1,[R0]
	BL    getchar
	B     main


_startPlay:

	BL    SETUSR

	B     _exit


_exit: 
	LDMFD SP!,{LR} 
	BX    LR

.data
.align 2

fIngreso:
	.asciz "%d"

opcionIn:
	.word 0

msjOpcion:
	.asciz "Ingrese Opción: "

