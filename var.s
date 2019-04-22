
/************************************************************************************/ 
/*         Autor: Pablo Sao                                                         */ 
/*         Fecha: 19 de abril de 2019                                               */ 
/*   Descripcion: variables de acceso global                                        */
/************************************************************************************/ 


/*     Despliegue de jugadores    */
.text
.align 2
.global displayUsr
displayUsr:
	.ascii "(H) "

.text
.align 2
.global displayConejo
displayConejo:
	.ascii "(B) "

.text
.align 2
.global clsDisplay
clsDisplay:
	.ascii "( ) "

.text
.align 2
.global displayConejo
displayCapConejo:		@ Captura de Conejo
	.ascii "(x) "


/*     Posición jugador    */
.align 2
.global colUsr
.data
colUsr:
	.word 8

.align 2
.global filaUsr
.data
filaUsr:
	.word 1


.align 2
.global move
move:
	.byte ''


/*     Posición conejo    */
.align 2
.global colConejo
.data
colConejo:
	.word 8

.align 2
.global filaConejo
.data
filaConejo:
	.word 3


/*   Tablero de 5x5     */
.align 2
.global fila1
.data
fila1:
	.ascii "( ) ","( ) ","( ) ","( ) ","( ) "

.align 2
.global fila2
.data
fila2:
	.ascii "( ) ","( ) ","( ) ","( ) ","( ) "

.align 2
.global fila3
.data
fila3:
	.ascii "( ) ","( ) ","( ) ","( ) ","( ) "

.align 2
.global fila4
.data
fila4:
	.ascii "( ) ","( ) ","( ) ","( ) ","( ) "

.align 2
.global fila5
.data
fila5:
	.ascii "( ) ","( ) ","( ) ","( ) ","( ) "
