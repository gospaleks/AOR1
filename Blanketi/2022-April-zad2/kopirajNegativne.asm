.386
.model flat, c
public kopirajNegativne
.code
kopirajNegativne proc
	push ebp
	mov ebp, esp
	pushfd
	push edi
	push esi
	push ecx
	push edx

	
	mov esi, [ebp+12]	; adresa source niza
	mov edi, [ebp+8]	; adresa destination niza

	mov eax, 0			; ovde ce bude br negativnih koji su ubaceni u destination niz
	mov ecx, [ebp+16]	; br elemenata source niza
	petlja:
		
		; movSx - sign jer nam treba prosirenje sa znakom
		movsx edx, word ptr [esi]

		cmp edx, 0		; ako je negativan dodaj ga u destination niz
		jnl dalje
		mov [edi], edx
		inc eax
		add edi, 2

		dalje:
		add esi, 2
		loop petlja


	pop edx
	pop ecx
	pop esi
	pop edi
	popfd
	pop ebp
	ret
kopirajNegativne endp
end