.386
.model flat, c
.data
	ASC db "Je l' i vi 'volite' 'racunarske sisteme' k'o i mi?!$"
	;ASC db "Ovo 'kao' radi nekako 'izgleda da' da$"
.code
main proc

  ; 2016 II kol zad 5
  ; znam da ima resenja al nisam se ni trudio da pokusavam da razumem
  ; ovo je nesto moje, ima malo da je spageti kod al jbg tu smo da se edukujemo
  ; bitno da radi

	xor esi, esi
	petlja:
		movzx eax, byte ptr ASC[esi]		
		
		cmp eax, "$"				; proveri dal je kraj
		je kraj

		cmp eax, "'"				; proveri dal je navodnik		
		jne nijeNavodnik
		; e tu je cvor
		mov edi, esi
		vrti:
			inc edi
			movzx ebx, byte ptr ASC[edi]
			cmp ebx, 32					; ako naidje na blanko to znaci da vise nije ista rec odma obustavi
			je obustavi	
			cmp ebx, "'"				; ako naidje na ' onda je to nadjena rec izmedju '...' i samo je preskoci
			jne vrti
			mov esi, edi
			inc esi
			jmp petlja

		obustavi:
		; ovo je za situaciju 'racunarski sistemi' i situaciju k'o -> da bi i ovo 'r' povecalo, tj 'o' da NE poveca
		mov edi, esi
		dec edi
		inc esi
		movzx eax, byte ptr ASC[edi]
		cmp eax, 32						; ako iza apostrova nije razmak znaci da nije pocetak reci i ne treba nista da se menja
		jne petlja
		movzx eax, byte ptr ASC[esi]
		cmp eax, "a"
		jl petlja
		cmp eax, "z"
		jg petlja
		sub eax, 32
		mov ASC[esi], al
		jmp petlja

		nijeNavodnik:
		cmp eax, 32						; proveri dal je blanko
		jne nijeBlanko
		inc esi							; jeste blanko -> sledeci posle njega stavi da je veliko slovo
		movzx eax, byte ptr ASC[esi]	; dodatna provera da nije slucajno razmak pa '	
		cmp eax, "'"
		je petlja
		sub eax, 32						; ce pretposavimo da nema velika slova osim na pocetak
		mov ASC[esi], al
		inc esi
		jmp petlja

		nijeBlanko:
		inc esi
		jmp petlja

	kraj:
	nop
	ret
main endp
end main
