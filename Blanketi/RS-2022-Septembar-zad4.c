#include <stdio.h>

/*
	Racunarski Sistemi 2022 Septembar zad 4.

	Ulaz:
	5
	11 4 5 55 7
	Izlaz:
	0 4 0 0 7
*/


int main() {

	int n;
	int niz[100];

	scanf_s("%d", &n);

	for (int i = 0; i < n; ++i)
		scanf_s("%d", niz + i);

	_asm {

		// ovo sve sluzi da napravim masku sa jedinice onoliko bita koliko ima validnih u n
		// npr za n = 5 = (101) to su 3 bita, znaci pravim masku 00000111
		// muljavine al na kraj je u EDX maska, tj to sto treba

		// u sustini pomeram ga levo i brojim pomeranja dok ne dodje do prve 1-ce (kad se upali carry znam da je 1-ca)
		// onda to oduzmem od 8 jer je n 8b broj i napravim masku 2^(x)-1
		mov edx, n
		xor eax, eax
		dec eax
		opet:	
			inc eax
			shl dl, 1
			jnc opet
		mov ecx, 8
		sub ecx, eax
		mov edx, 1
		shl edx, cl
		dec edx

		xor esi, esi
		movzx ecx, n
		petlja:
			mov ebx, niz[esi]

			push ecx                // push ecx da bi mogo i ovu unutra petlju da radim s loop
			mov ecx, 32
			pomerajDesno:
				mov eax, ebx

				xor eax, n            // if(((niz[i] XNOR n) & maska) == maska) => nadjen
				neg eax               // XNOR daje jednakost bitova i maska filtira samo bitne bitove iz n
				dec eax
				and eax, edx
				cmp eax, edx
				je nadjen

				shr ebx, 1				  // u svakom prolazu originalni broj pomerimo za jedno mesto udesno da bi tako proverili svaki "podniz bitova" sa n
				loop pomerajDesno


			jmp nijeNadjen
			nadjen:
			xor eax, eax
			mov niz[esi], eax			// ako je nadjen anuliraj ga

			nijeNadjen:
			pop ecx               // vrati ecx zbog spoljasnje petlje koja ide kroz niz
			add esi, 4
			loop petlja
	}


	for (int i = 0; i < n; ++i)
		printf("%d ", niz[i]);

	return 0;
}
