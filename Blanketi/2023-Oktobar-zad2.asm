.386
.model flat, c
.stack 4096
.data
	mat db "      addd"
	    db " aland    "
	    db "  najduza "				; indeks je 2
	    db "    rec   "
	n dd 4
	m dd 10
	rez dd ?
.code
najduza proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov ebx, [ebp+16]				; &mat
	mov ecx, [ebp+12]				; n

	xor dl, dl						; u DL maxDuzinaReci
	xor dh, dh						; u DH indeks trenutne vrste
	xor edi, edi					; konacni rez (tj broj vrste gde je najduza rec)

	slVrsta:
		xor esi, esi				; ESI ide po kolonama (j-indeks)
		dec esi

									; Preskoci blanko znake na pocetku ako ih ima
		iDaljeBlanko:
			inc esi
			mov al, [ebx][esi]
			cmp al, 32
			je iDaljeBlanko

									; Izracunaj koliko slova ima rec -> u AH je duzina reci
		dec esi
		xor ah, ah
		iDaljeSlova:
			inc esi
			mov al, [ebx][esi]
			inc ah
			cmp al, 32
			jne iDaljeSlova

		dec ah						; ovaj dec je da vrati u libelu jer ona iznad petlja predje jedan preko

		cmp ah, dl					; Ako je duzina duza od trenutne najduze update-uj rez
		jle dalje
		mov dl, ah
		movzx edi, dh
		dalje:

		inc dh
		add ebx, [ebp+8]			; skok za m
		loop slVrsta

	mov [ebp+16], edi				; rez izlazni parametar preko steka po vrednsoti

	popad
	popfd
	pop ebp
	ret 8
najduza endp
main proc

	; 2023 Oktobar zad 2.

	push offset mat
	push n
	push m
	call najduza
	pop eax
	mov rez, eax

	nop
	ret
main endp
end main
