
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

	@**   Inicializando valor de columna de usuario
	LDR   R1, =colUsr5x5
	LDR   R1, [R1]
	LDR   R2,=colUsr
	STR   R1, [R2]

	@**   Inicializando valor de columna de usuario
	LDR   R1, =filaUsr5x5
	LDR   R1, [R1]
	LDR   R2,=filaUsr
	STR   R1, [R2]

	@**   Inicializando valor de columna de conejo
	LDR   R1, =colConejo5x5
	LDR   R1, [R1]
	LDR   R2,=colConejo
	STR   R1, [R2]

	@**   Inicializando valor de columna de conejo
	LDR   R1, =filaConejo5x5
	LDR   R1, [R1]
	LDR   R2,=filaConejo
	STR   R1, [R2]

	@**    Inicializando matriz
	BL    _initMatrix

	@**    Desplegando inicio
	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner
	BL    MENU 		@ Mostramos Menú


	@**   Ingreso de opción

	LDR   R0, =msjOpcion
	BL    puts

	@**   Ingreso de teclado

	LDR   R0, =fIngreso
	LDR   R1, =opcionIn
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BEQ   _error

	@**   Identificación de operaciones
	LDR   R0, =opcionIn
	LDR   R0, [R0]

	CMP   R0, #1
	BLEQ  SETUSR
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
	
	BL    TABLERO5X5

	@**   Movimiento de jugador
	LDR   R0, =msjturnoUsr
	BL    puts

	BL    MOVEUSR

	@**   Validamos ganador
	BL    _validaXY

	@**   Movimiento conejo
	LDR   R0, =msjturnoC
	BL    puts

	BL    MOVECONEJO

	@**   Validamos ganador
	BL    _validaXY

	B     _startPlay

_validaXY:
	PUSH  {LR}

	@**   Cargamos columnas y filas para comprobar posición
	
	LDR   R2, =colUsr
	LDR   R2, [R2]

	LDR   R3, =colConejo
	LDR   R3, [R3]

	LDR   R4, =filaUsr
	LDR   R4, [R4]

	LDR   R5, =filaConejo
	LDR   R5, [R5]

	CMP   R2, R3
	CMPEQ R4, R5
	BLEQ  _win

	POP   {PC}

_win:
	
	BL    CLEAR 		@ Limpiamos Pantalla
	BL    BANNER 		@ Mostramos Banner

	LDR   R0, =win1
	BL    puts
	
	LDR   R0, =continuar
	BL    puts
	
	MOV   R7, #3
	MOV   R0, #0
	MOV   R2, #1
	LDR   R1, =move
	SWI   0
	
	MOV   R1, #''
	LDR   R2, =move
	STRB  R1, [R2]
	
	B     _exit
	

_exit:
	LDMFD SP!,{LR}
	BX    LR

.data
.align 2

.align 2
fIngreso:
	.asciz "%d"

opcionIn:
	.word 0

.align 2
msjOpcion:
	.asciz "Ingrese Opción: "

.align 2
msjturnoUsr:
	.ascii "Turno Usuario: "

.align 2
msjturnoC:
	.ascii "Turno Conejo..."


@****   Posición inicial del jugador
.align 2
.data
colUsr5x5:
	.word 8

.align 2
.data
filaUsr5x5:
	.word 1


@****   Posición inicial del conejo
.align 2
.data
colConejo5x5:
	.word 8

.align 2
.data
filaConejo5x5:
	.word 3



.align 2
continuar:
	.ascii "\t<Presione \033[31;42mc\033[0m para continuar>"

.align 2
win1:
	.asciz "                                                 ,--. 
           .---.           ,---,               ,--.'| 
          /. ./|        ,`--.' |           ,--,:  : | 
      .--'.  ' ;        |   :  :        ,`--.'`|  ' : 
     /__./ \ : |        :   |  '        |   :  :  | | 
 .--'.  '   \' .        |   :  |        :   |   \ | : 
/___/ \ |    ' '        '   '  ;        |   : '  '; | 
;   \  \;      :        |   |  |        '   ' ;.    ; 
 \   ;  `      |        '   :  ;        |   | | \   | 
  .   \    .\  ;        |   |  '        '   : |  ; .' 
   \   \   ' \ |        '   :  |        |   | '`--'   
    :   '  |--'         ;   |.'         '   : |       
     \   \ ;            '---'           ;   |.'       
      '---'                             '---''  " 
	  

