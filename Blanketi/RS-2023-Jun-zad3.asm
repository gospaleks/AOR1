.386
.model flat, c
.stack 4096
.data
	mat dd  1,  2,  3,  4,  1
		dd  5,  6,  7,  8,  1
		dd  9, 10, 11, 12,  1
		dd 13, 14, 15, 16,  1
		dd  1,  1,  1,  1,  1
	n	dd 5
.code
anuliraj proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov esi, [ebp+16]       ; &niz
	
	mov ebx, [ebp+12]
	shl ebx, 2              ; u EBX jer 4*n

	mov edx, [ebp+8]        ; k
	shl edx, 2              ; *4 jer su 32b el, u EDX je skok


	xor edi, edi            ; EDI ide 0, k, 2k, 3k, 4k... (svaki k-ti)
	xor ebp, ebp            ; u EBP je nula koju treba smestim u mem
	petlja:
		mov [esi][edi], ebp
		add edi, edx
		cmp edi, ebx
		jl petlja

	popad
	popfd
	pop ebp
	ret 12
anuliraj endp
main proc
	

	; Racunarski sistemi 2023 Jun zad 3.


	mov esi, n
	shl esi, 2
	sub esi, 4
	lea eax, mat[esi]      ; pocetak sporedne dijagonale
	push eax

	mov eax, n
	mul eax
	mov ebx, n
	dec ebx
	shl ebx, 1
	sub eax, ebx          ; u EAX je broj elemenata tog "niza" koji je od pocetka dijagonale do kraja dijagonale u memoriju
                        ; tj u EAX je (n*n - 2*(n-1)) -> tako sam sracunao vrv moze i lakse...
	push eax
	mov eax, n
	dec eax
	push eax              ; svaki (n-1)-ti
	call anuliraj


	nop
	ret
main endp
end main
