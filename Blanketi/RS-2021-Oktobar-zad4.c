#include <stdio.h>
#define NMAX 10

/*
	Racunarski Sistemi 2021 Oktobar zad 4.


	Ulaz:
	5
	a e c c d
	a e i o d
	b b b a d
	b d e a d
	a a a a a
	Izlaz:
	1 -3 3 1 -5

	// nigde ne kaze al ako treba mozda logicnije da se vrati apsolutna vrednost al tjt u principu
*/

int razlika(char niz[], int n) {
	_asm {
		mov esi, niz			// u ESI adresa pocetka niza
		xor ebx, ebx			// u EBX broj samoglasnika

		mov ecx, n
		petlja:
			movzx eax, byte ptr [esi]
			cmp eax, 'a'
			je nadjen
			cmp eax, 'e'
			je nadjen
			cmp eax, 'i'
			je nadjen
			cmp eax, 'o'
			je nadjen
			cmp eax, 'u'
			je nadjen
			jmp nijeNadjen
			nadjen:
			inc ebx
			nijeNadjen:
			inc esi
			loop petlja

		mov eax, n
		sub eax, ebx			// u EAX je sad broj suglasnika

		sub eax, ebx			// a sad razlika suglasnika i samoglasnika
	}
}


int main() {

	int N;
	char A[NMAX][NMAX];

	scanf_s("%d", &N);
	getchar();
	for (int i = 0; i < N; ++i)
		for (int j = 0; j < N; ++j) {
			scanf_s("%c", &A[i][j]);
			getchar();
		}

	int B[NMAX];
	for (int i = 0; i < N; ++i)
		B[i] = razlika(A[i], N);

	for (int i = 0; i < N; ++i)
		printf("%d ", B[i]);

	return 0;
}
