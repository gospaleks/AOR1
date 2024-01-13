.386
.model flat, c
.data
	n dd 4
	m dd 3
	mat1 dw 1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 12
	mat2 dd 50 dup(?)
	; ocekuje se da u mat2 bude: 1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c
.code
main proc
	
	; Racunarski Sistemi 2022 Decembar zad 3.



	xor esi, esi        ; indeksi za mat1
	xor ebx, ebx

	xor edx, edx        ; indeksi za mat2
	xor edi, edi

	mov ebp, n
	shl ebp, 1          ; u EBP je 2*N

	spo:
		
		xor ebx, ebx
		xor edi, edi
		mov ecx, m
		un:

			movzx eax, word ptr mat1[ebx][esi]
			mov mat2[edx][edi], eax

			add ebx, ebp    ; skok un petlje za MAT1 je 2N
			add edi, 4      ; skok un petlja za MAT2 je 4
			loop un


		add esi, 2        ; skok spo petlje za MAT1 je 2
		mov eax, m
		shl eax, 2        ; privremeno u eax je 4*m sto je skok za EDX za spo petlju MAT2
		add edx, eax
		cmp esi, ebp  
		jl spo
		
	nop
	ret
main endp
end main
