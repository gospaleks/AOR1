.386
.model flat, c
.stack 4096
.data
	mat dd 20, 6, 3, 3
		dd 10, 2, 3, 3
		dd 1, 2, 4, 1
		dd 15, 1, 1, 1
	n dd 4
	rez dd ?				; ocekuje se 2
.code
sumaNiza proc
	push ebp
	mov ebp, esp
	pushfd
	pushad
	
	mov esi, [ebp+12]		; adresa niza
	xor edx, edx			; u EDX ce bude suma

	mov ecx, [ebp+8]		; n
	petlja:
		mov eax, [esi]
		add edx, eax		; dodaj na sumu
		add esi, 4
		loop petlja

	mov [ebp+12], edx		; na dno steka stavi sumu

	popad
	popfd
	pop ebp
	ret 4					; ret 4 jer ce sledeci sklonim u main kad preuzmem
sumaNiza endp
main proc

		
	; 2022 Septembar zad 2


	mov rez, 0

	mov edi, n
	dec edi					; u EDI je (n-1) jer preostali deo niza ima n-1 elementa

	mov edx, n
	shl edx, 2				; skok 4*n

	xor ebx, ebx
	xor ebp, ebp			; ebp ide 0, 1, 2, 3... indeks vrste
	mov ecx, n
	petlja:
		
		lea eax, mat[ebx][4]
		push eax
		push edi
		call sumaNiza
		pop eax				; u EAX suma preostalog dela niza

		cmp mat[ebx], eax	; uporedi i ako je prvi manji od sume preostalih stavi u krez i izadji iz petlje
		jnl dalje
		mov rez, ebp
		jmp kraj
		dalje:
		inc ebp
		add ebx, edx
		loop petlja

	kraj:
	nop
	ret
main endp
end main
