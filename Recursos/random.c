#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*********************************************
 *       Autor: Pablo Sao
 *       Fecha: 20 de abril de 2019
 * Descripción: Generador de números aleatorios  *
 *************************************************/

int RANDOM();

int main(){
	int res;
	res = RANDOM();
	
	printf("Valor: %d\n",res);
	
	return 0;
}

int RANDOM(){
	int max = 4;
	int num;
	
	/* Inicializando numero random*/
	srand(time(0));

	num = rand() % max + 1;
	
	return num;
}
