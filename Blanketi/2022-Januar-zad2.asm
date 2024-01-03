.386
.model flat, c
.stack 4096
.data
	mat dd 1, 5, 2, 4
		dd 5, 1 ,3, 10
		dd 9, 1, 5, 1
		dd 4, 6, 11, 2
	n dd 4
	niz dd 10 dup(?)
.code
maksimumNiza proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov esi, [ebp+12]		; u ESI adresa pocetka niza
	mov ecx, [ebp+8]		; broj elemenata niza
	dec ecx

	mov edx, [esi]			; prvi proglasavam za max (maxEl = niz[0])
	add esi, 4
	petlja:
		mov eax, [esi]
		cmp eax, edx		; if (niz[i] > maxEl)
		jng dalje
		mov edx, eax		; maxEl = niz[i]
		dalje:
		add esi, 4
		loop petlja

	mov [ebp+12], edx		; na dno steka upisem rez i u main to pop-ujem u neki registar

	popad
	popfd
	pop ebp
	ret 4
maksimumNiza endp
main proc
	
	lea ebx, mat		; adresa prve vrste u ebx
	mov ecx, n

	mov edx, ecx
	shl edx, 2			; u EDX je 4*n, to je da skoci na pocetak sledece vrste

	xor edi, edi		; indeks gde se upisuje u niz

	petlja:
		push ebx
		push n
		call maksimumNiza
		pop eax

		mov niz[edi], eax	

		add edi, 4
		add ebx, edx
		loop petlja

	nop
	ret
main endp
end main
