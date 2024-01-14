.386
.model flat, c
.stack 4096
.data
	mat dw 2, 1, 2, 1, 1
		dw 9, 5, 7, 5, 9
		dw 2, 6, 7, 8, 4
		dw 0, 3, 3, 0, 3
		dw 3, 3, 7, 3, 3
	n dd 5
	rez dd ?
.code
uporedi proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]

	cmp eax, ebx
	jne preskoci
	mov ecx, 0						; 0 isti su
	mov [ebp + 12], ecx
	jmp kraj
	preskoci:
	mov ecx, 1						; 1 nisu isti
	mov [ebp + 12], ecx
	kraj:

	popad
	popfd
	pop ebp
	ret 4
uporedi endp

main proc
	
	; Racunarski Sistemi 2021 Oktobar zad 3.


	mov ecx, n
	mov edx, ecx
	shl edx, 1						; skok u EDX 2*n
	xor ebx, ebx
	xor ebp, ebp
	spoljasnja:
		inc ebp              ; EBP ide po matematickim indeksima
		mov edi, edx
		sub edi, 2           ; EDI ide od 2*n-2 uvek
		xor esi, esi         ; ESI ide od 0 uvek
		unutrasnja:
			movzx eax, word ptr mat[ebx][esi]
			push eax
			movzx eax, word ptr mat[ebx][edi]
			push eax
			call uporedi
			pop eax

			cmp eax, 1				; ako nisu isti odma prekidaj obradu trenutne vrste i idi na sledecu
			je sledeca

			add esi, 2
			sub edi, 2
			cmp esi, edi
			jl unutrasnja

		mov rez, ebp        ; ako izadje iz unutrasnje petlje znaci da je naso simetricnu vrstu
		jmp kraj            ; prekida se sve

		sledeca:
		add ebx, edx
		loop spoljasnja
	kraj:

	nop
	ret
main endp
end main
