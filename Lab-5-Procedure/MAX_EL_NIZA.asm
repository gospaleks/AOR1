; MAKSIMALNI ELEMENT NIZA CIJI SU ELEMENTI 32b BROJEVI

.386
.model flat,c
.data
	niz dd 1, 5, 4, 9, 0f6h, 222h, 6, 7
	n dd 8
	rez dd ?			
.stack 4096
.code
maxEl proc
	mov ebp, esp
	pushfd
	pushad

	mov ecx, [ebp+4]	; br elemenata niza
	mov esi, [ebp+8]	; adresa prvog
	mov eax, [esi]		; u c je ovo max = niz[0]

	petlja:
		cmp [esi], eax
		jle preskoci
		mov eax, [esi]
		preskoci:
		add esi, 4	; +4 jer je dd
		loop petlja
	
	mov [edx], eax		; ubaci u rez u memoriju

	popad
	popfd
	ret 8			; da skloni i n i niz sto su stavljeni na stek
maxEl endp

main proc

	push offset niz
	push n
	lea edx, rez
	call maxEl

	nop
	ret
main endp
end main
