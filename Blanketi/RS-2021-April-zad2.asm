.386
.model flat, c
.stack 4096
.data
	niz dw 10, 2, 1, 11, 5, 1, 4
	n	dd 7
.code
prviVeci proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov esi, [ebp+12]
	mov ecx, [ebp+8]
	dec ecx

	movzx edx, word ptr [esi]            ; prvi element niza

	add esi, 2
	mov edi, 1                           ; edi ide po indeksima 0, 1, 2, 3...
	petlja:
		movzx eax, word ptr [esi]
		cmp eax, edx
		jl dalje
		mov eax, edi
		jmp kraj
		dalje:
		inc edi
		add esi, 2
		loop petlja

	xor eax, eax                           ; ako je doso do ovde znaci nije naso veci
	kraj:
	mov [ebp+12], eax                      ; stavi rez na dno steka da se posle u main uzme samo s pop

	popad
	popfd
	pop ebp
	ret 4
prviVeci endp

main proc

  ; Racunarski Sistemi 2021. April zad 2.

	xor edx, edx
	xor ebx, ebx

	mov ecx, n
	petlja:                                ; mora n puta da se ponovi ceo postupak da bi se sortirao niz
		push ecx                             ; push ecx i pop posle da bi mogo ecx da koristim i za unutrasnju petlju

		xor esi, esi
		mov ecx, n
		dec ecx
		sledeci:
			lea eax, niz[esi]
			push eax
			push ecx
			call prviVeci
			pop eax

			cmp eax, 0                        ; ako je rez = 0 znaci da nema veci samo idi dalje na sledeci element
			je dalje
			shl eax, 1                        ; inace zameni mesta na trenutni i na ovog sto je nadjen
			mov bx, niz[esi]
			mov dx, niz[esi][eax]
			mov niz[esi], dx
			mov niz[esi][eax], bx
			dalje:

			add esi, 2
			loop sledeci

		pop ecx
		loop petlja
	nop
	ret
main endp
end main
