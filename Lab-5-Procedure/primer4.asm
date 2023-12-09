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
	add eax, [ebp+8]
	mov [ebp + 8], eax

	popad
	popfd
	ret 4
saberi endp
main proc
	
	; saberi dva broja stek: ulaz i izlaz po vrednosti

	push x
	push y
	call saberi
	pop eax
	mov rez, eax

	nop
	ret
main endp
end main