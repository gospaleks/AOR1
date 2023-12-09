.386
.model flat,c
.data
	x dd 5
	y dd 3
	rez dd ?
.stack 4096
.code
saberi proc
	pushfd
	push eax

	add eax, ebx
	mov [ecx], eax

	pop eax
	popfd
	ret
saberi endp
main proc
	
	; saberi dva broja: ulaz po vrednosti, izlaz po adresi

	mov eax, x
	mov ebx, y
	lea ecx, rez
	call saberi
	

	nop
	ret
main endp
end main