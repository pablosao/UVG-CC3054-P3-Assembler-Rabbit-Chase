
/************************************************************************************/ 
/*         Autor: Pablo Sao & Mirka Monzon                                          */ 
/*         Fecha: 15 de abril de 2019                                               */ 
/*   Descripcion: Rabbit Chase, donde el objetivo es capturar el conejo en un       */ 
/*				  tablero.                                          */
/************************************************************************************/ 

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
	
	LDR   R0, =menu			@ Dirección de menu 
	BL    puts			@ Se muestra en pantalla 

	POP   {PC} 
	

/*		Area de Datos		*/ 

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

separador: 
	.asciz "\033[36m----------------------------------------------------------------------------------\033[0m\n" 


autores: 
	.asciz "\033[33m      ()_()\033[0m                                                      \033[33m()_()\033[0m 
\033[33m      (o o)\033[0m             by Pablo Sao & Mirka Monzon              \033[33m(o o)\033[0m 
\033[33m  ooO--(_)--Ooo\033[0m                     2019                     \033[33mooO--(_)--Ooo\033[0m\n" 

clear: 
	.asciz "\033[H\033[J" 

instrucciones: 
	.ascii "" 
	
menu: 
	.ascii "\t\t\tMenú \n1). Iniciar Partida. \n2). Salir.\n" 
	
linea_nueva: 
	.ascii "\n" 

