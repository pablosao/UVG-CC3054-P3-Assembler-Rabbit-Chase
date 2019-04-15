
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

	LDR   R0, =mensaje_ingreso	@ cargando direccion de mensaje
	BL    puts 			@ mostrando mensaje en pantalla



ingreso:

	/* Lectura de teclado */
	MOV   R7, #3			@ syscall para ingreso de datos
	MOV   R0, #0			@ lectura de pantalla
	MOV   R2, #1			@ lee solo 1 caracter
	LDR   R1, =vingreso             @ variable donde se almacena el contenido
	SWI   0

	LDR   R1, [R1]			@ Cargamos valor ingresado

	MOV   R4, #-4			@ Seteamos dirección inicial de matriz
	MOV   R5, #4			@ seteamos contador de impresión

	CMP   R1, #0x31			@ Si R1 == 1
	BLEQ   _play			@   Inicia juego

	CMP   R1, #0x32			@ Si R2 == 2
	BLEQ   _exit			@   Sale del juego

	BL    main

_play:

	/* Armamos matriz inicial */

/*	LDR   R0,=display		@ Cargamos dirección de despliegue
	LDR   R1,=tablero		@ Dirección de matriz

	ADD   R4, #4			@ indice de matriz
	ADD   R1, R4			@ nos posicionamos en el valor del indice
	BL    printf			@ se imprime el valor

	SUBS  R5, #1			@ restamos contador de ciclo
	CMP   R5, #0			@ Si R5 no == 1
	BNE   _play			@    retornamos a _play */
	
	BL   PRINT_M5X5

	B     _exit			@ de lo contrario salimos

_exit:
	LDMFD SP!,{LR}

	BX    LR

.data
.align 2

mensaje_ingreso:
	.asciz "Ingrese Opción: "

/* Formato de impresion de tablero */
.global display
display:
	.asciz "%s | "

/* Se arma tablero */
.global tablero_f1
tablero_f1:
	.asciz "(1)","(2)","(3)","(4)","(5)"

.global tablero_f2
tablero_f2:
	.asciz "(6)","(7)","(8)","(9)","(10)"

.global tablero_f3
tablero_f3:
	.asciz "(11)","(12)","(13)","(14)","(15)"

.global tablero_f4
tablero_f4:
	.asciz "(16)","(17)","(18)","(19)","(20)"

.global tablero_f5
tablero_f5:
	.asciz "(21)","(22)","(23)","(24)","(25)"

vingreso:
	.asciz ""
