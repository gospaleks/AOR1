.386
.model flat,c
public funkcija
.code
funkcija proc
	
	push ebp
	mov ebp, esp
	pushfd
	push esi
	push edi

	mov ebx, [ebp+12]	; u EBX adresa niza
	mov ecx, [ebp+8]	; vrednost N

	mov edx, [ebp+16]	; &a[0]
	mov eax, [ebp+20]	; &a[N-1]

	mov edi, [ebp+24]	; &A

	xor esi, esi
	petlja:
		push edi
		mov edi, [edx]
		cmp [ebx][esi], edi
		pop edi
		jng dalje
		push edi
		mov edi, [eax]
		cmp [ebx][esi], edi
		pop edi
		jnl dalje
		; telo
		push eax
		mov eax, [edi]
		mov [ebx][esi], eax 
		pop eax
		
		
		dalje:
		add esi, 4
		loop petlja

	pop edi
	pop esi
	popfd
	pop ebp
	ret

funkcija endp
end