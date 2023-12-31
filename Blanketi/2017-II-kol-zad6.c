#include <stdio.h>

/*
	2017 II kol zad 6.
*/

// *u resenja su mnozenje s 10 radili mnozenje s 2 i 8 pa sabrano

// znaci fora je imamo u niz 3, 2, 1 i to da konvertuje u broj 123
// s tim da se pazi da ne dodje do prekoracenje i da su sve cifre korektne
unsigned int bcdtoi(const char* niz, const unsigned int n) {
	_asm {
		// EBX - stepen
		// ESI - adresa tr elementa
		// ECX - n
		// EDI - suma koja se na kraju mora smesti u EAX

		xor edi, edi
		mov esi, niz				// adresa niza u ESI
		mov ecx, n				// broj elemenata niza u ECX zbog loop
		mov ebx, 1				// stepen (10^0, 10^1, 10^2...)	

		petlja:
			cmp [esi], 10			// cifra mora da bude 0-9
			jnl lose

			movzx eax, byte ptr [esi]
			mul ebx				// cifra * stepen
				cmp edx, 0
				jne lose			// ako je mnozenje otislo u edx znaci da je rez veci od 32b
			add edi, eax
				jc lose				// ako zbir da carry odma kraj jer ne moze stane u 32b
			xor edx, edx			// anuliraj edx zbog mnozenje

			mov eax, ebx
			mov ebx, 10
			mul ebx
			mov ebx, eax
			xor edx, edx			// opet anuliraj edx zbog mnozenje
			inc esi
			loop petlja
		mov eax, edi				// stavi u EAX jer tamo return ocekuje
		jmp kraj
		lose:
		mov eax, 0
		kraj:	
	}
}


int main()
{
	char niz[20];
	int n;

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf_s("%d", &niz[i]);			// niz char da bi bilo byte al unosimo %d 
	
	unsigned int rez = bcdtoi(niz, n);

	printf("%u", rez);

	return 0;
}
