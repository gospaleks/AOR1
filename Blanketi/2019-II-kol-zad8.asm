#include <stdio.h>
#include <string.h>

/*
	PROBLEM:
	II kol 2019/20 8. zad
*/

int funkcija(short a[], int brEl, int n) {

	_asm {
		pushfd
		push esi
		push edi


		mov ebx, 1
		mov ecx, n
		shl ebx, cl
		dec ebx				    // u EBX maska 0...01...1 

		xor eax, eax		  // rez = 0

		mov edi, [a]		  // pocev od adrese a procitaj 4B a to je u stvari adresa naseg niza

		mov ecx, brEl
		xor esi, esi
		xor edx, edx
		petlja:
			mov dx, word ptr [edi][esi]
			and edx, ebx
			cmp edx, ebx
			jne nastavi
			inc eax
			nastavi:

			add esi, 2
			loop petlja

		pop edi
		pop esi
		popfd
	}

}

int main() {
	
	int brEl;
	short a[20];
	scanf_s("%d", &brEl);
	for (int i = 0; i < brEl; ++i)
		scanf_s("%hd", &a[i]);
	int n;
	scanf_s("%d", &n);

	int rez;
	_asm {
		mov eax, n
		push eax

		mov eax, brEl
		push eax

		lea eax, a
		push eax

		call funkcija
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
