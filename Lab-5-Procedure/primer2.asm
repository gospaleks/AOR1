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
	pushad

	mov esi, [eax]
	add esi, [ebx]
	mov [ecx], esi

	popad
	popfd
	ret
saberi endp
main proc
	
	; saberi dva broja: ulaz i izlaz po adresi

	lea eax, x
	lea ebx, y
	lea ecx, rez
	call saberi

	nop
	ret
main endp
end main