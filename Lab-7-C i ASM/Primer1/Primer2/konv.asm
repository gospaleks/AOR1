.386
.model flat,c
public konv
.code
konv proc
	push ebp
	mov ebp, esp
	pushfd
	push esi
	push edi
	push eax


	mov esi, [ebp+8]		; adresa pocetka stringa ulaz
	mov edi, [ebp+12]		; adresa pocetka string izlaz

	petlja:
		mov al, [esi]		; u al smestim karakter koji proveravam
		cmp al, 'A'			; provera dal je veliko
		jl nijeVeliko
		cmp al, 'Z'
		jg nijeVeliko

		add al, 32			; ovde ako dodje jeste veliko slovo
							; povecaj za 32 (vidi ASCII tabelu)
							; ili u ah npr smesti 'a'-'A', to je isto 32

		nijeVeliko:
		mov [edi], al		; smesti karakter bilo da je promenjen ili ne
		inc edi				; uvecaj i i j
		inc esi

		and al, al			; ovde proveravam dal je ulaz doso do '\0'
		jnz petlja

	mov byte ptr [edi], 0	; stavljam '\0' na kraj izlaza (null-terminated string)


	pop eax
	pop edi
	pop esi
	popfd
	pop ebp
	ret						; samo ret jer ce sam poziv f-je da se oslobodi steka
konv endp
end