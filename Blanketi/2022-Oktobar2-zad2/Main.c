#include <stdio.h>
#include <string.h>
/*
	2022 Oktobar2 zad 2.
*/

extern int transformisi(char s[]);

int main() {
		
	char s[100];
	scanf("%s", s);

	// ovde je to sto treba se doda za vracanje al to je manje bitan deo zadatka realno
	int x = transformisi(s);
	printf("%s", s);

	return 0;
}