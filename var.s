
/************************************************************************************/ 
/*         Autor: Pablo Sao                                                         */ 
/*         Fecha: 19 de abril de 2019                                               */ 
/*   Descripcion: variables de acceso global                                        */ 
/*				                                                    */ 
/************************************************************************************/ 

/*     Despliegue de jugadores    */
.text
.align 2
.global displayUsr
displayUsr:
	.asciz "(H) "

.text
.align 2
.global displayConejo
displayConejo:
	.asciz "(H) "

.text
.align 2
.global clsDisplay
clsDisplay:
	.asciz "( ) "

.text
.align 2
.global displayConejo
displayCapConejo:		@ Captura de Conejo
	.asciz "(x) "


/*     Posición jugador    */
.text
.align 2
.global colUsr
colUsr:
	.word 12

.text
.align 2
.global filaUsr
filaUsr:
	.word 1



/*     Posición conejo    */
.text
.align 2
.global colConejo
colConejo:
	.word 12

.text
.align 2
.global filaConejo
filaConejo:
	.word 3


/*   Tablero de 5x5     */
.text
.align 2
.global fila1
fila1:
	.asciz "( ) ","( ) ","(H) ","( ) ","( ) ","\n   "

.text
.align 2
.global fila2
fila2:
	.asciz "( ) ","( ) ","( ) ","( ) ","( ) ","\n   "

.text
.align 2
.global fila3
fila3:
	.asciz "( ) ","( ) ","(B) ","( ) ","( ) ","\n   "

.text
.align 2
.global fila4
fila4:
	.asciz "( ) ","( ) ","( ) ","( ) ","( ) ","\n   "

.text
.align 2
.global fila5
fila5:
	.asciz "( ) ","( ) ","( ) ","( ) ","( ) ","\n   "
