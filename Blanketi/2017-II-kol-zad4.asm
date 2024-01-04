.386
.model flat, c
.data
	ASC db "Ovo je jedna recenica. Ovo je jos jedna recenica. Takodje i ova.@"
.code
vratiOznaku proc
	pushfd
		
	cmp eax, "A"
	jl nijeVeliko
	cmp eax, "Z"
	jg nijeVeliko
	mov ebx, 1			; 1 - veliko slovo
	jmp kraj

	nijeVeliko:
	cmp eax, "a"
	jl nijeMalo
	cmp eax, "z"
	jg nijeMalo
	mov ebx, 2			; 2 - malo slovo
	jmp kraj

	nijeMalo:
	cmp eax, "@"
	jne nije@
	mov ebx, 3			; 3 - znak za kraj
	jmp kraj

	nije@:
	cmp eax, " "
	jne nijeBlanko
	mov ebx, 4			; 4 - blanko
	jmp kraj

	nijeBlanko:
	mov ebx, 5			; 5 - ostalo

	kraj:
	popfd
	ret
vratiOznaku endp
main proc
	
	; 2017 II kol zad 4.


	; 1 - veliko slovo
	; 2 - malo slovo
	; 3 - @
	; 4 - blanko
	; 5 - ostali karakteri 

	xor esi, esi
	petlja:
		movzx eax, byte ptr ASC[esi]
		call vratiOznaku
		cmp ebx, 3
		je kraj
		
								; spec slucaj
		cmp ebx, 5					; ako je tacka ispred nje odma povecaj slovo
		jne nastavi
		mov edi, esi
		dec edi
		movzx eax, byte ptr ASC[edi]
		sub eax, 32
		mov ASC[edi], al
		jmp dalje

		nastavi:
		cmp ebx, 4					; ako je blanko proveri iza i ispred dal je malo slovo
		jne nijeBlanko					; ako nije samo idi dalje
		mov edi, esi		
		dec edi	
		movzx eax, byte ptr ASC[edi]			; ovde u EAX karakter ispred
		call vratiOznaku
		cmp ebx, 2
		jne proveriIza
		sub eax, 32
		mov ASC[edi], al				; ako je malo slovo promeni ga u veliko
		

		proveriIza:
		mov edi, esi
		inc edi
		movzx eax, byte ptr ASC[edi]			; ovde u EAX karakter iza
		call vratiOznaku
		cmp ebx, 2
		jne dalje
		sub eax, 32					; -32 jer tolko je razlika u ASCII tabelu
		mov ASC[edi], al				; ako je malo slovo promeni ga u veliko

		dalje:
		nijeBlanko:
		inc esi						; predji na sledeci
		jmp petlja

	kraj:
	nop
	ret
main endp
end main
