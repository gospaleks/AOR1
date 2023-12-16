.386
.model flat, c
.data
	mat db 1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12
	n dd 3
	m dd 4
	suma db ?
.code
main proc
	
	; smestena po kolonama
	; obilazak po vrstama
	; problem: SUMIRANJE ELEMENATA NEPARNIH KOLONA

	mov eax, 0							; rez = 0
	mov edi, 0

	mov esi, 0
	spo:
		mov ebx, 0
		mov ecx, m
		un:
			mov edx, edi				; znaci edi mi ide od 0 do n*m
			shr edx, 1					; ovde provera dal je na neparnu poziciju
			jnc nastavi					; ako carry ode na 1 znaci da je neparna pozicija
			add al, mat[ebx][esi]		; dodaj taj element u zbir
			nastavi:					; u sustini prolazi sve svakako kroz sve elemente
			inc edi

			add ebx, n
			loop un


		inc esi
		cmp esi, n
		jl spo

	mov suma, al			; smatram da suma elemenata nema bude veca od 8b

	nop
	ret
main endp
end main