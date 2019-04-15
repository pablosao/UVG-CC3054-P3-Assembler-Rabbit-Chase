
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

	CMP   R1, #0x31			@ Si R1 == 1
	BEQ   _play			@   Inicia juego

	CMP   R1, #0x32			@ Si R2 == 2
	BEQ   _exit			@   Sale del juego

	BL    main

_play:

	/* Armamos matriz inicial */


_exit:
	LDMFD SP!,{LR}
	BX    LR

.data
.align 2

mensaje_ingreso:
	.asciz "Ingrese Opción: "

vingreso:
	.asciz ""
