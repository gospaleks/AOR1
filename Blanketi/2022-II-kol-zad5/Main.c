#include <stdio.h>

extern void funkcija(char n, int a[], int *x, int *y, int *z);

/*
	PROBLEM:
	Kolokvijum II 2022/23 zad 5.
*/

int main() {
	
	int n;
	int a[10];

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf_s("%d", &a[i]);

	int A = 1;
	// * ovo oliver nesto reko kao da ne cast-ujemo u char jer stek prima samo 32b i zavisi od kompajlera
	//   dal ce esp da skoci kako treba, al u ovom slucaju radi, tkd bukv najnebitnija stvar u ovaj zad
	funkcija((char)n, a, &a[0], &a[n - 1], &A);
	
	for (int i = 0; i < n; ++i)
		printf("%d ", a[i]);
	
	return 0;
}
