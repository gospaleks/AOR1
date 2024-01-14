#include <stdio.h>

/*
	Racunarski Sistemi 2021 Jun zad 4.


	Ulaz:
	10
	4 5 6 8 9 8 5 2 0 1

	Izlaz:
	4 4 5 6 6 8 9 9 8 5 2 2 0 0 1 1
*/

int obrada(int niz[], int n) {
	_asm {
		mov esi, niz						// u ESI adresa pocetka niza

		mov ecx, n
		shl ecx, 2
		add ecx, esi						// u ECX adresa poslednjeg elementa

		petlja:
			// prvo provera da l' je jedini u niz
			mov eax, [esi]					// u EAX trenutni element za koji se proverava

			xor ebx, ebx					// u EBX broj pojavljivanja
			mov edi, niz
			broji:
				cmp [edi], eax
				jne nastavi
				inc ebx
				nastavi:
				add edi, 4
				cmp edi, ecx
				jl broji

			// ako je vise od jednog pojavljivanja samo nastavi dalje
			cmp ebx, 1
			jg predjiNaSledeci
			// ako je uso ovamo znaci da treba da se doda jos jedan element i sve da se pomeri u desno za jedno mesto
			add ecx, 4                                      // dodam 4 na ECX jer dodajem jedan element
			mov edi, ecx
			pomeraj:
				mov eax, [edi-4]
				mov [edi], eax				// krenem od zadnjeg i vucem sve elemente za jedno mesto udesno
				sub edi, 4
				cmp edi, esi
				jg pomeraj

			mov eax, [esi]					// onda na mesto koje je sada prazno dodam isti element kao sto je trenutni
			mov [esi+4], eax

			predjiNaSledeci:
			add esi, 4
			cmp esi, ecx
			jl petlja


		// ECX mi se povecalo onoliko puta koliko sam puta dodao elemente
		// znaci posto je u ECX adresa poslednjeg, oduzmem to od adrese pocetka niza i podelim sa 4 jer su 32b i dobijem novo n koje vratim
		mov eax, ecx
		mov esi, niz
		sub eax, esi
		shr eax, 2

	}
}


int main() {
	
	int n;
	int niz[100];

	scanf_s("%d", &n);
	for (int i = 0; i < n; ++i)
		scanf_s("%d", niz + i);

	n = obrada(niz, n);

	for (int i = 0; i < n; ++i)
		printf("%d ", niz[i]);

	return 0;
}
