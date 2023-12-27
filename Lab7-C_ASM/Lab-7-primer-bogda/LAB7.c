#include <stdio.h>

extern int saberi(int a, int b, int c);

int main()
{
	//prvi problem
	
	int a, b, c, d, e, f;
	printf("prvi problem\n\nuneti a, b i c:\n");
	scanf_s("%d%d%d", &a, &b, &c);
	d = saberi(a, b, c);
	printf("d = %d\n", d);
	e = a * d - 4 * b;
	printf("e = %d\n", e);
	_asm {
		xor eax, eax
		mov eax, a
		xor ebx, ebx
		mov ebx, d
		mul ebx
		mov ecx, eax
		mov eax, 4
		mov ebx, b
		mul ebx
		sub ecx, eax
		mov f, ecx
	}
	printf("f = %d", f);

	//drugi problem

	int niz[100], i;
	printf("\n\ndrugi problem\n\nuneti broj elemenata niza i elemente:\n");
	scanf_s("%d", &a);
	
	for (i = 0; i < a; i++)
		scanf_s("%d", &niz[i]);
	
	printf("\nelementi niza su:\n");
	for (i = 0; i < a; i++)
		printf("%d ", niz[i]);

	_asm {
		
		mov ecx, a
		cmp ecx, b
		jg dalje
		
		mov esi, 0
		petlja1 :
		mov niz[esi], 0
			add esi, 4
			loop petlja1
		jmp kraj
		
		dalje :
		mov edx, 0
		mov eax, 0
		mov ebx, 1
		
		petlja2:
			inc eax
			mov esi, a
			shl esi, 2
			sub esi, 4
			sub ecx, ebx
			
			petlja3:
				push ebx
				mov edi, esi
				sub edi, 4
				mov ebx, niz[edi]
				mov niz[esi], ebx
				sub esi, 4
				pop ebx
				loop petlja3
			
			inc ebx
			mov ecx, a
			mov niz[edx], 0
			add edx, 4
			cmp eax, b
			jl petlja2
		kraj:
	}
	printf("\nelementi niza nakon pomeranja su:\n");
	for (i = 0; i < a; i++)
		printf("%d ", niz[i]);
}