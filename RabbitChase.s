
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
	
	B     _exit 

_exit: 
	LDMFD SP!,{LR} 
	BX    LR 
