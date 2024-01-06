.386
.model flat,c
.stack 4096
.data
	mat dw 5, 3, 1
		dw 3, 4, 5
		dw 1, 4, 7
		dw 4, 8, 10
	n dw 4
	m dw 3
	rez dd ?				; ocekivan rez je 5
.code
main proc
	
	; 2022/23 II kol zad 4.

	; ovo je greskom smesteno po vrstama a treba po kolonama
	; onda pronalazenje drugog elementa pretposlednje vrste je lakse - samo 4*n-4

	; da dobijem drugi element u pretposlednjoj vrsti
	; ebx je (2*m * (n-2)) i dodam 2 jer je druga kolona
	movzx ebx, m
	shl ebx, 1
	movzx eax, n
	sub eax, 2
	mul ebx

	movzx edi, word ptr mat[eax][2]		; u EDI element sa kojim poredim

	; sada matricu mogu da posmatram kao niz
	movzx eax, n
	movzx ecx, m
	mul ecx
	mov ecx, eax				; u ECX broj proslaska (n*m)

	xor edx, edx				; u EDX je rez koji posle smestam u memoriju
	xor esi, esi
	petlja:
		movzx eax, word ptr mat[esi]
		cmp eax, edi
		jle dalje
		inc edx
		dalje:
		add esi, 2
		loop petlja

	mov rez, edx

	nop
	ret
main endp
end main
