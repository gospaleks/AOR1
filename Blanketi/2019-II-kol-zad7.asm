.386
.model flat, c
.data
	mat dw 1, 2, 3, 4, 5
		dw 6, 7, 8, 9, 10
		dw 11, 12, 13, 14, 15
		dw 16, 17, 18, 19, 20
		dw 21, 22, 23, 24, 25
	n db 5
	broj db 3
	niz dw 25 dup(?)			; ocekivan rez: 16, 22, 4, 10
	m db ?						; m = 4
.code
main proc
	
	; 2019 II kol zad 7 


	xor ebp, ebp
	xor edx, edx
	xor edi, edi
	xor ebx, ebx
	mov m, 0

	xor eax, eax
	movzx eax, n
	shl eax, 1						; ogranicavam se da ce 2*n da bude u 8b tkd samo koristim AL
									; jer mi AH treba za razliku matematickih indeksa

	xor esi, esi
	mov dh, 1						; matematicki indeks vrste
	mov dl, 1						; matematicki indeks kolone
	spo:
		xor ebx, ebx
		mov dh, 1
		movzx ecx, n
		un:
			; ovde vidi razlika dal je jednaka sa broj
			cmp dh, dl				; prvo da se osiguram da je u ah veci da bi oduzimao manji od veci
			jg veci
			mov ah, dl
			sub ah, dh
			jmp dalje
			veci:
			mov ah, dh
			sub ah, dl
			dalje:
			cmp ah, broj
			jne preskoci
			mov bp, mat[ebx][esi]	; ako jeste jednako sa broj upisi u niz (ebx jer u [] mora 32b reg)
			mov niz[edi], bp
			inc m					; povecaj broj elemenata niza
			add edi, 2
			preskoci:

			inc dh					; povecaj matematicki indeks vrste
			add bl, al				; ovde mora sa bl jer uvecavam ga za al sto je 8b
			loop un

		inc dl						; povecaj matematicki indeks kolone
		add esi, 2
		cmp esi, eax 
		jl spo

	nop
	ret
main endp
end main
