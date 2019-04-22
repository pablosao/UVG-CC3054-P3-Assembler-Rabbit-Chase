
/**********************************************************************/ 
/*         Autor: Pablo Sao                                           */ 
/*         Fecha: 21 de abril de 2019                                 */ 
/*   Descripcion: Generación de número aleatorio                      */ 
/*				                                      */ 
/**********************************************************************/ 


.text 
.align 2 
.global main 
.type main, %function 

main: 

	@**     Prueba Random 
	MOV   R12, #4
	BL    RANDOM
	MOV   R1,R12
	LDR   R0, =display
	BL    printf

	MOV   R7, #1
	SWI   0
.data
.align 2
display:
	.asciz "Valor: %d\n"
