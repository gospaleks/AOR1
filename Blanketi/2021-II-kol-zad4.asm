.386
.model flat, c
.data
	niz dd 5, 2, 0, 0, 6, 7, 0, 8
	n dd 8
	zbir dd ?
.code
main proc	
	
	; II kol 2021/22 zad 



	xor eax, eax				; rez = 0
	xor esi, esi
	mov ecx, n
	dec ecx						; i < n-1
	petlja:
		
		cmp niz[esi], 0			; ako je trenutni 0
		jne preskoci
		
		mov edi, esi			; sledeci dodaj u eax
		add edi, 4
		add eax, niz[edi]

		preskoci:
		add esi, 4
		loop petlja

	mov zbir, eax				; prebaci rez u memoriju

	nop
	ret
main endp
end main
