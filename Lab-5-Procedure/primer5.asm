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
	
	mov ecx, [ebp+4]
	mov eax, [ecx]			; y

	mov ecx, [ebp+8]
	mov ebx, [ecx]			; x

	add eax, ebx
	mov ecx, [ebp + 12]
	mov [ecx], eax			; u rez

	popad
	popfd
	ret 12
saberi endp
main proc
	
	; saberi dva broja stek: ulaz i izlaz po adresi

	push offset rez
	push offset x
	push offset y
	call saberi

	nop
	ret
main endp
end main