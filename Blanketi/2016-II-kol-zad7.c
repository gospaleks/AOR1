#include <stdio.h>

/*
	2016 II kol zad 7.
*/

int funkcija(short ulniz[], int n, short scalar) {
	_asm {
		mov ebx, ulniz
		xor eax, eax			  // trazeni zbir u EAX
		xor esi, esi
		mov ecx, n
		petlja:					    // klasican prolazak kroz 16b niz
			movzx edx, word ptr [ebx][esi]
			cmp edx, 0			  // provera dal je pozitivan
			jle preskoci
			cmp dx, scalar		// provera dal je veci od scalara
			jng preskoci
			add eax, edx		  // ako je sve ok dodaj ga na zbir
			preskoci:
			add esi, 2
			loop petlja

		// rez je na kraju u EAX sto je u stvari povratna vrednost f-je
	}
}

int main()
{
	int n, m;
	short mat[20][20];
	int niz[20];

	scanf_s("%d %d", &n, &m);
	for (int i = 0; i < n; ++i)
		for (int j = 0; j < m; ++j)
			scanf_s("%hd", &mat[i][j]);

	for (int i = 0; i < n; ++i)
		niz[i] = funkcija(mat[i], m, mat[i][0]);

	printf("Trazeni niz je: ");
	for (int i = 0; i < n; ++i)
		printf("%d ", niz[i]);

	return 0;
}
