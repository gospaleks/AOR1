#include <stdio.h>

/*
	2022 April zad 2.
*/

extern int kopirajNegativne(short niz1[], short niz2[], int n);

int main() {

	int n, m;
	short mat[20][20];
	scanf_s("%d %d", &n, &m);
	for (int i = 0; i < n; ++i)
		for (int j = 0; j < m; ++j)
			scanf_s("%hd", &mat[i][j]);

	short niz[100];
	int x = 0;
	for (int i = 0; i < n; ++i) {
		// ovde je fora da smestamo uvek u isti niz
		// s tim sto funkciji prosledimo samo deo koji nije popunjen
		// to omogucava +x, jer se u svaki poziv vrati onoliko elemenata koliko je ubaceno
		x += kopirajNegativne((niz + x), mat[i], m);
	}
	
	for (int i = 0; i < x; ++i)
		printf("%hd ", niz[i]);

	return 0;
}