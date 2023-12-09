.386
.model flat,c
.data
	x dd 5
	y dd 3
	rez dd ?
.stack 4096
.code
saberi proc
	mov ebp, esp
	pushfd
	pushad
	
	
	mov eax, [ebp+4]
	mov ebx, [eax]

	mov eax, [ebp+8]
	mov ecx, [eax]

	add ebx, ecx
	mov [ebp+8], ebx


	popad
	popfd
	ret 4
saberi endp
main proc
	
	; saberi dva broja stek: ulaz po adresi i izlaz po vrednosti

	push offset x
	push offset y
	call saberi
	pop eax
	mov rez, eax
	nop

	ret
main endp
end main