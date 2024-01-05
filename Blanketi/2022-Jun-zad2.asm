.386
.model flat, c
.stack 4096
.data
	n dd 4
	mat dd 16 dup(?)
	niz dd 1, 2, 3, 4, 5, 0
.code
kopiraj proc
	push ebp
	mov ebp, esp
	pushfd
	pushad


	mov eax, [ebp+12]		; ulazna adresa
	mov ebx, [ebp+8]		; izlazna adresa
	mov ecx, [eax]
	mov [ebx], ecx


	popad
	popfd	
	pop ebp	
	ret
kopiraj endp
main proc
	
	; 2022 Jun zad 2.

	; 32b matrica
	; smestena po vrstama klasican obilazak po kolonama 

	xor edi, edi			; edi prolazi kroz niz

	mov edx, n
	shl edx, 2				; u EDX je 4*n

	xor esi, esi
	spo:
		mov ecx, n
		xor ebx, ebx
		un:
			cmp niz[edi], 0				; ako je doslo do kraja niza (tj do broja 0) samo resetuj EDI na 0
			jnz dalje
			xor edi, edi
			dalje:
			lea eax, niz[edi]
			push eax
			lea eax, mat[ebx][esi]
			push eax
			call kopiraj				; funkcija kopira iz niza u odgovarajuce mesto u matrici
			
			add edi, 4					; predji na sledeci element niza
			add ebx, edx
			loop un
	
			
		add esi, 4
		cmp esi, edx
		jl spo


	nop
	ret
main endp
end main
