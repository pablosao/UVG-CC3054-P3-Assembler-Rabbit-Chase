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

	BL    CLEAR 
	BL    BANNER 
	BL    MENU 

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
	BLEQ  _play

	CMP   R0, #2
	BLEQ   _exit
	BLGT  _error


_error:
	LDR   R0, =opcionIn
	MOV   R1, #0
	STR   R1,[R0]
	BL    getchar
	B     main


_play:
	MOV   R5, #6		@ Control de loop
	MOV   R6, #0
	BL    _print

	LDR   R0,=temp
	BL    puts

	B     _exit

_print:
	/*LDR   R0, =display
	LDR   R1, =fila1

	ADD   R1, R6

	BL    printf */

	MOV   R7, #4
	MOV   R0, #1
	MOV   R2, #4
	LDR   R1, =fila1
	ADD   R1, R6
	SWI   0

	ADD   R6, #4

	SUBS  R5, #1
	CMP   R5, #0
	BNE   _print
	MOV  PC, LR

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

fila1:
	.asciz "(1) ","(2) ","(3) ","(4) ","(5) ","\n   "

fila2:
	.asciz "(6)","(7)","(8)","(9)","(10)","\n"

display:
	.asciz "%s "

temp:
	.ascii "\n"
