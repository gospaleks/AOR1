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

	mov ebx, [ebp+12]
	mov [ebx], eax

	popad
	popfd
	ret 12
saberi endp
main proc
	
	; saberi dva broja stek: ulaz po vrednosti i izlaz po adresi

	push offset rez
	push x
	push y
	call saberi

	nop
	ret
main endp
end main
