#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*********************************************
 *       Autor: Pablo Sao
 *       Fecha: 20 de abril de 2019
 * Descripción: Generador de números aleatorios  *
 *************************************************/

int main(){

	int num = 3;
	
	/* Inicializando numero random*/
	srand(time(0));

	num = rand() % num + 1;

	return 0;
}
