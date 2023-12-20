#include <stdio.h>
#include <string.h>

extern void konv(char ulaz[], char izlaz[]);

void main() {
	
	/*
		PROBLEM:
		Kopiraj recenicu uz konverziju
		velikih slova u mala
	*/

	char ulaz[100];
	char izlaz[100];

	gets(ulaz, 100);
	
	konv(ulaz, izlaz);

	printf("%s", izlaz);
}