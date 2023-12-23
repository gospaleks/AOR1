.386
.model flat,c
.stack 4096
.data
	n db 4
	m db 5
	mat dw 1,2,3,4,5
		dw 6,7,8,9,10
		dw 11,12,13,14,15
		dw 16,17,18,19,20		; u rezultatu: 34, 38, 42, 46, 50 (dekadno)
.code
sumaSvakogKtog proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	mov eax, [ebp+12]
	mov ecx, [ebp+8]
	div cl
	movzx ecx, al				; broj prolaska
	
	mov edx, [ebp+8]			; korak
	shl edx, 1				; korak*2 jer je 16b niz

	xor esi, esi
	xor ebx, ebx				; suma = 0
	mov edi, [ebp+16]
	petlja:
		
		movzx eax, word ptr [edi][esi]
		add ebx, eax			; suma += eax

		add esi, edx	
		loop petlja

	mov [ebp+16], ebx			; smesti sumu na dno steka

	popad
	popfd
	pop ebp
	ret 8					; pop sve osim onog na dnu
sumaSvakogKtog endp

main proc
	
	movzx eax, n
	dec eax
	mul m
	shl eax, 1				; 2 * (n-1) * m
	lea edi, mat
	add edi, eax				; adresa prvog elementa u poslednjoj vrsti

	movzx ecx, m
	mov ebx, ecx

	xor esi, esi
	petlja:
		lea eax, mat
		add eax, esi

		push eax			; adresa pocetka
		movzx eax, n	
		mul ebx
		push eax			; broj elemenata (saljem n*m)
		push ebx			; korak - saljem m (u proceduru ce se pomnozi sa 2)
		call sumaSvakogKtog
		pop eax				; u EAX je ono sto treba se upise u poslednju vrstu

		mov [edi], ax			; smesti u poslednju vrstu (ax jer su 16b svakako)
		add edi, 2			; predji na sledeci element u poslednjoj vrsti

		add esi, 2			; predji na sledeci pocetni element u prvoj vrsti
		loop petlja

	nop
	ret
main endp
end main
