.386
.model flat, c
.data
	mat db 1, 2, 3, 4
		db 5, 6, 7, 8
		db 9, 10, 11, 12
	n dd 3
	m dd 4
	rez db 3 dup(?)
.code
main proc
	
	; MATRICA SMESTENA PO VRSTAMA
	; OBILAZAk PO VRSTAMA
	; problem: ODREDITI SUMU SVAKE VRSTE

	mov ecx, n
	mov ebx, 0
	mov edi, 0						; index za smestanje u rez

	spo:		
		mov eax, 0					; rez = 0
		mov esi, 0
		un:
			movzx edx, mat[ebx][esi]
			add eax, edx			; dodaj na rez
			inc esi
			cmp esi, m
			jl un

		mov rez[edi], al			; smesti u memoriju
		inc edi

		add ebx, m
		loop spo


	nop
	ret
main endp
end main