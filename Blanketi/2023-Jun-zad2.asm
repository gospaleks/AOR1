.386
.model flat, c
.stack 4096
.data
	; stavio sam sve jedinice ostalo da bi bolje video u memoriju sta se desava
	mat dd 1, 1, 1, 9
		dd 1, 1, 5, 1
		dd 1, 4, 1, 1
		dd 1, 1, 1, 1
	n dd 4
	tmpNiz dd 10 dup(?)
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
		add edi, 4						; j = i + 1
		un:
			mov ebx, [eax][esi]			; a = niz[i]
			mov edx, [eax][edi]			; b = niz[j]
			cmp ebx, edx				; if (a > b)
			jng nastavi
			mov [eax][esi], edx			; zameni im mesta u memoriji
			mov [eax][edi], ebx
			nastavi:					; else nastavi
			push eax
			mov eax, [ebp+8]			; u eax privremeno sacuvaj 4*N (ovo ne bi bio problem da je niz 8b)
			shl eax, 2
			add edi, 4
			cmp edi, eax
			pop eax		; pop ne ucite na flagove
			jl un
		add esi, 4
		loop spo

	popad
	popfd
	pop ebp
	ret 8
sort endp
main proc	
	
	; Jun 2023 - 2.zad

	xor edi, edi		; edi ce da prolazi kroz tmpNiz
	
	mov esi, n			; esi ide po sporednoj dijag, krece od 4n - 4
	shl esi, 2
	sub esi, 4
	mov edx, esi		; u edx je skok

	mov ecx, n			; petlja prolazi kroz dijagonalu i smesta sve u tmpNiz
	petlja:
		mov eax, mat[esi]
		mov tmpNiz[edi], eax
		
		add edi, 4
		add esi, edx
		loop petlja



	push offset tmpNiz
	push n
	call sort			; sortiraj tmpNiz



	xor edi, edi		; sada samo vratimo u matricu slicno kao gornja petlja
	mov esi, edx
	mov ecx, n
	petlja1:
		mov eax, tmpNiz[edi]
		mov mat[esi], eax
		add edi, 4
		add esi, edx
		loop petlja1

	nop
	ret
main endp
end main
