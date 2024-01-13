#include <stdio.h>

/*
	RACUNARSKI SISTEMI

	2023 Jun zad 4.
*/


int main() {

	int n, k;
	int niz[100];

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf_s("%d", niz + i);

	scanf_s("%d", &k);

	_asm {
		mov ecx, k
		petlja:
			mov esi, n
			shl esi, 2
			sub esi, 4                 // u ESI je 4*n-4 tj indeks poslednjeg elementa

			mov edx, niz[esi]          // u EDX zapamtim poslednji el. da ga posle stavim na prvo mesto (rotacija)
			mov edi, esi
			sub edi, 4                 // EDI ide jedan indeks manje u odnosu na ESI
			pomeraj:
				mov eax, niz[edi]
				mov niz[esi], eax    	// trenutni dobije vrednost prethodnog

				sub edi, 4
				sub esi, 4
				cmp esi, 0
				jg pomeraj

			mov niz, edx		      	// stavi EDX na niz[0]

			loop petlja
	}

	for (int i = 0; i < n; ++i)
		printf("%d ", niz[i]);

	return 0;
}
