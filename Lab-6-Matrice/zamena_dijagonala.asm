.386
.model flat, c
.data
	mat db 1, 2, 3, 4
		db 5, 6, 7, 8
		db 9, 10, 11, 12
		db 13, 14, 15, 16
	n dd 4
.code
main proc
	
	; PROBLEM:
	; Zameniti mesta elementima na glavnoj i
	; na sporednoj dijagonali kvadratne matrice

	; 8b matrica smestena po vrstama i obilazak po vrstama

	mov esi, 0
	mov ebx, 0
	mov edi, n
	dec edi

	mov ecx, n
	petlja:
		movzx eax, mat[ebx][esi]
		xchg al, mat[ebx][edi]
		mov mat[ebx][esi], al

		inc esi
		dec edi
		add ebx, n
		loop petlja

	nop
	ret
main endp
end main
