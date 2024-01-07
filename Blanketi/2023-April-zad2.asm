.386
.model flat, c
.stack 4096
.data
	mat dw 1, 4, 7, 10, 2, 5, 1, 11, 3, 6, 9, 12			; smestena po kolonama
	n dd 4
	m dd 3

	;	matrica je matematicki:
	;	1 2 3
	;	4 5 6
	;	7 1 9                        ; ocekujemo samo 7 i 9 da se promene
	;	10 11 12

.code
prosek proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov esi, [ebp+12]           ; adresa pocetka niza
	mov ecx, [ebp+8]            ; broj elemenata - n

	xor eax, eax				    	  ; suma svih elemenata
	petlja:
		movzx edx, word ptr [esi]    ; moze i add ax, [esi], al onda ako ima izlazni prenos mora rucno
		add eax, edx                 ; ovako prosirim do 32b i sigurno staje
		add esi, 2
		loop petlja
	
	xor edx, edx
	mov ebx, n
	div ebx                    ; posle ovoga u EAX je prosecna vrednost (ceo deo)
	mov [ebp+12], eax          ; smestimo na dno steka da posle u main s pop preuzmemo

	popad
	popfd
	pop ebp
	ret 4
prosek endp
main proc

	; 2023 April zad 2.

	; elementi trece vrste uvek imaju indeks ESI = 4
	; ovo pod uslovom da matrica ima bar 3 vrste
	
	mov esi, 4
	xor ebx, ebx

	mov edx, n
	shl edx, 1					; skok je 2*n

	mov ecx, m
	petlja:
		lea eax, mat[ebx]
		push eax
		push n
		call prosek
		pop eax					; u EAX prosek odgovarajuce kolone

		cmp mat[esi][ebx], ax
		jng dalje
		mov mat[esi][ebx], ax
		
		dalje:
		add ebx, edx
		loop petlja


	nop
	ret
main endp
end main
