.386
.model flat,c
.data
	x db 5
	y db 3
	rez db ?
.stack 4096
.code
saberi proc
	pushfd
	mov cl, al
	add	cl, bl
	popfd
	ret
saberi endp
main proc
	
	; saberi dva broja: ulaz i izlaz po vrednosti


	movzx eax, x
	movzx ebx, y
	call saberi
	mov rez, cl

	nop
	ret
main endp
end main