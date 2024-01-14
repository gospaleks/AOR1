.386
.model flat, c
.stack 4096
.data
	; stavio sam sve jedinice ostalo da bi bolje video u memoriju sta se desava
	mat dd 1, 1, 1, 9
		dd 1, 1, 5, 1
		dd 1, 7, 1, 1
		dd 10, 1, 1, 1
	n dd 4
.code

; procedura prihvata ulazne podatke preko steka
; adresa niza i vrednost broja elemenata

sort proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov eax, [ebp+12]			; u EAX je adresa niza

	xor esi, esi
	mov ecx, [ebp+8]
	dec ecx
	spo:
		mov edi, esi
		add edi, 4					; j = i + 1
		un:
			mov ebx, [eax][esi]			; a = niz[i]
			mov edx, [eax][edi]			; b = niz[j]
			cmp ebx, edx				; if (a > b)
			jnl nastavi
			mov [eax][esi], edx			; zameni im mesta u memoriji
			mov [eax][edi], ebx
			nastavi:				; else nastavi
			push eax
			mov eax, [ebp+8]			; u eax privremeno sacuvaj 4*N (ovo ne bi bio problem da je niz 8b)
			shl eax, 2
			add edi, 4
			cmp edi, eax
			pop eax					; pop ne ucite na flagove
			jl un
		add esi, 4
		loop spo

	popad
	popfd
	pop ebp
	ret 8
sort endp
main proc	
	
						; stavi sporednu dijagonalu u prvu vrstu
	mov ebx, n
	shl ebx, 2	
	sub ebx, 4				; u EBX je skok 4*n-4 za prolazak kroz sporednu dijagonalu

	mov eax, n
	mul eax
	shl eax, 2
	sub eax, ebx
	sub eax, 4				; U EAX indeks elementa koji je skroz dole levo
	push eax				; push eax da ne bi ponovo posle racunao za vracanje

	xor esi, esi
	mov ecx, n
	petlja:
		mov edx, mat[eax]
		mov edi, mat[esi]
		mov mat[esi], edx
		mov mat[eax], edi 

		sub eax, ebx
		add esi, 4
		loop petlja



	push offset mat
	push n
	call sort					; sortiraj prvu vrstu



							; vrati sporednu dijagonalu
	pop						; pop eax da ne bi ponovo racunao
	xor esi, esi
	mov ecx, n
	petlja1:
		mov edx, mat[eax]
		mov edi, mat[esi]
		mov mat[esi], edx
		mov mat[eax], edi 

		sub eax, ebx
		add esi, 4
		loop petlja1



	nop
	ret
main endp
end main
