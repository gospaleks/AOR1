#include <stdio.h>

/*
	2020 II kol zad 7.
*/

int main()
{
	int niz[20];
	int n;

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf_s("%d", niz + i);


	char format[] = "%d. %d\n";

	_asm {

		lea esi, niz				// u ESI adresa prvog

		mov ecx, n
		dec ecx
		shl ecx, 2
		mov edi, esi
		add edi, ecx				// u EDI adresa poslednjeg

	
		petlja:
			// broj jedinica za a[i] (bice u EDX)
			xor edx, edx
			mov eax, [esi]
			mov ecx, 32
			brJedinicaLevi:
				shr eax, 1
				adc edx, 0
				loop brJedinicaLevi
		
			// broj jedinica za a[n-1-i] (bice u EBX)
			xor ebx, ebx
			mov eax, [edi]
			mov ecx, 32
			brJedinicaDesni:
				shr eax, 1
				adc ebx, 0
				loop brJedinicaDesni
		
			// poredi EDX i EBX i zameni mesta u nizu ako je potrebno
			cmp edx, ebx
			jle dalje
			mov eax, [edi]
			mov ebx, [esi]
			mov [esi], eax
			mov [edi], ebx

			dalje:
			add esi, 4			// predji na sledeca dva elementa
			sub edi, 4
			cmp esi, edi		// dovoljno je proveriti do n/2
			jl petlja

		// ispis niza
		lea esi, niz
		xor edi, edi
		mov ecx, n
		ispis:
				push ecx		// printf ujebe ECX i onda mora pre poziv da se sacua
			push [esi]			// ili da se ne ide sa loop nego neka while petlja, kako god
			push edi
			lea eax, format
			push eax
			call printf
			add esp, 12
				pop ecx
			inc edi
			add esi, 4
			loop ispis
	}


	return 0;
}
