.386
.model flat, c
.data 
	mat dw 1, 2, 3, 4
		dw 5, 6, 7, 8
		dw 9, 10, 11, 12
	n dd 3
	m dd 4
.code
main2 proc

	; JEDAN OD PROBLEMA ZA LAB_6:
	; Matrica 16b elemenata smestena po vrstama
	; obilazeci matricu po vrstama od pozadi sve elemente na parnim kolonama zameniti prvim elementom

	mov eax, n
	dec eax
	mov ebx, m
	mul ebx
	shl eax, 1
	mov ebx, eax		; u EBX je 2*(n-1)*m -> tj indeks od koji treba pocne EBX

	mov edx, m
	shl edx, 1			; u EDX je 2*m -> to je skok

	mov bp, mat			; u BP je mat[0][0]
	mov ecx, n
	spo:
		mov esi, edx
		sub esi, 2
		mov edi, m		; edi sluzi samo da vidim dal sam u parnu kolonu (neparni indeks)
		dec edi
		un:
			mov eax, edi
			shr eax, 1
			jnc dalje
			mov mat[ebx][esi], bp

			dalje:
			dec edi
			sub esi, 2
			cmp esi, 0
			jge un

		sub ebx, edx 
		loop spo

	nop
	ret
main2 endp
end main2
