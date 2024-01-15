#include <stdio.h>

/*
	Racunarski Sistemi 2021. April zad 4.

	Ulaz:
	 4
	 1  2 -4  1
	-4  6 -8  9
	 5  6  8  4
	-7 -4 -4 -4
	Izlaz:
	2 0 4 -4
*/


int razlika(int niz[], int n) {
	_asm {

		mov esi, niz
		
		xor eax, eax				// u EAX broj pozitivnih (P)
		xor edx, edx				// u EDX broj negativnih (Q)


		mov ecx, n
		petlja:
			mov ebx, [esi]

			cmp ebx, 0
			jge pozitivan
			inc edx
			jmp dalje
			pozitivan:
			inc eax
			dalje:

			add esi, 4
			loop petlja

		sub eax, edx				// P - Q u EAX kao povratna vrednost

	}
}


int main() {
	
	int n;
	int mat[20][20];

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		for (int j = 0; j < n; ++j)
			scanf_s("%d", &mat[i][j]);

	int B[20];

	for (int i = 0; i < n; ++i)
		B[i] = razlika(mat[i], n);

	for (int i = 0; i < n; ++i)
		printf("%d ", B[i]);

	return 0;
}
