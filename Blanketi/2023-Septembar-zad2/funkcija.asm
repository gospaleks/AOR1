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

	mov eax, [ebp+8]			;adresa prvog elementa niza a
	xor edx, edx				;proglasamo to kasnije za maksmalni element podniza
	
	;32 je blanko znak

	mov esi, -1
	petlja:						;do prvog blanko, preskace se prva rec
		inc esi
		mov bl, 32
		cmp [eax+esi], bl
		jne petlja
	
	mov ch, 0					; string je null-terminated pa provera za kraj
	gore:
		petlja2:				;do prvog koji nam treba (preskoci blanko znake)
			inc esi
			cmp [eax+esi], bl
			je petlja2
	
		mov edi, esi
		dec edi					; u edi se pameti pozicija na koju treba da se upise max karakter
		xor edx, edx
		mov dl, [eax+esi]		;prvi je maks pa poredimo sa njim i proglasamo taj za maks
		petlja3:
			inc esi
			mov cl, [eax+esi]
			cmp cl, dl
			jl preskoci
			mov dl, [eax+esi]
			preskoci:
			cmp [eax+esi], ch		; dodatna provera dal je kraj stringa jer jebe zadnja rec
			je kraj
			cmp [eax+esi], bl
			jne petlja3

		kraj:	
		mov byte ptr [eax+edi], dl	; upisujemo max karakter ispred reci
		cmp byte ptr [eax+esi], ch	; provera za kraj ('\0')
		jne gore

	pop edi
	pop esi
	popfd
	pop ebp
	ret
funkcija endp
end