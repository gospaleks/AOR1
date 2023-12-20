#include <stdio.h>

extern int stepen2(int osnova, short stepen);


void main() {
	
	// PROBLEM: x * 2^y	

	int osnova, rez;
	short stepen;
	
	scanf_s("%d", &osnova);
	scanf_s("%hd", &stepen);
	
	// rez = stepen2(osnova, stepen);
	_asm {
		movzx eax, stepen
		push eax
		mov eax, osnova
		push eax
		call stepen2
		add esp, 8
		mov rez, eax
	}

	printf("%d", rez);
}