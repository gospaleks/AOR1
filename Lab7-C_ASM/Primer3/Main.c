#include <stdio.h>

/*
	PROBLEM:
	Prebroj elemente niza 16b elemenata koji imaju
	osobinu da im je nizih n bitova u binarnom zapisu jednako 1
*/

// int niz jer saljemo adresu koja je 32b
// ne mora short niz[]
int prebroj(int niz, int brEl, int n) {
	_asm {
		// eax, ebx, ecx, edx ne mora cuvamo
		push esi
		push edi

		mov ebx, 1								// napravi 2^n - 1 
		mov ecx, n								// to je maska 00001...1
		shl ebx, cl
		dec ebx


		mov edx, 0								// rez = 0
		mov edi, [niz]							// u EBX ide &niz
		mov ecx, brEl							// u ECX ide broj elemenata
		mov esi, 0
		petlja:

			movzx eax, word ptr [edi][esi]		// u EAX trenutni element niza, tj u AX
			and eax, ebx						// and sa maskom
			cmp eax, ebx						// ako se u EAX dobije isto kao maska to znaci da je nadjen
			jnz dalje
			inc edx								// rez++

			dalje:
			add esi, 2							// +2 jer su 16b elementi
			loop petlja

		mov eax, edx							// rez uvek u eax

		pop edi
		pop esi
	}
}

int main() {
	int n;
	int brEl;
	short niz[20];

	scanf_s("%d", &brEl);
	for (int i = 0; i < brEl; ++i)
		scanf_s("%hd", &niz[i]);
	scanf_s("%d", &n);

	int rez;
	_asm {
		mov eax, n
		push eax

		mov eax, brEl
		push eax

		lea eax, niz
		push eax

		call prebroj
		mov rez, eax
		add esp, 12
	}

	// printf("%d", rez);
	char format[] = "%d";
	_asm {
		mov eax, rez
		push eax
		lea eax, format
		push eax
		call printf
		add esp, 8
	}
	return 0;
}