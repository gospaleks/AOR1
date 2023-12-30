.386
.model flat,c
.stack 4096
.data
	mat db "    abcddd"
		db " aleksand "
		db "  aoij    "
	n dd 3
	m dd 10
	rez dd ?
.code
najduza proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	xor edi, edi					; konacan rez je ovde (maxDuzina = 0)
	xor eax, eax
	mov edx, [ebp+16]				; adresa matrice
	mov ecx, [ebp+12]				; n - br vrsta
	xor ebx, ebx
	spo:						; petlja koja ide po vrstama
		xor esi, esi
		blanko:					; ova petlja treba da preskoci sve blanko znake na pocetku
			mov al, [edx][esi]
			cmp al, 32
			jne dalje
			inc esi
			cmp esi, [ebp+8]
			jl blanko

		dalje:
		push ebx				; push ebx i pop ebx jer mi fale registri jbg
		xor ebx, ebx				; rez za svaku vrstu je ovde (currentDuzina = 0)
		slova:
			mov al, [edx][esi]
			cmp al, 32
			je kraj
			inc ebx				; povecaj duzinu reci ako nije doso do blanko
			inc esi
			cmp esi, [ebp+8]
			jl slova

		kraj:
		cmp ebx, edi				; u C je ovo -> if (currentDuzina > maxDuzina) maxDuzina = currentDuzina;
		jl dalje2
		mov edi, ebx
		dalje2:
		pop ebx

		add edx, [ebp+8]
		add ebx, [ebp+8]
		loop spo

	mov eax, [ebp+20]
	mov dword ptr [eax], edi			; smesti maxDuzina u memoriju

	popad
	popfd
	pop ebp
	ret 16						; 16 da skloni sve sa steka
najduza endp
main proc
	
	; Oktobar 2023 - zad 2.

	push offset rez
	push offset mat
	push n
	push m
	call najduza

	nop
	ret
main endp
end main
