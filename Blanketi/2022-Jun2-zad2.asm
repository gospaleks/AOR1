.386
.model flat, c
.stack 4096
.data 
	mat db 1, 10, 6, 13
		db 5, 6, 7, 8
		db 9, 5, 5, 5
		db 13, 14, 15, 16
	n dd 4
.code
poredi proc
	push ebp
	mov ebp, esp
	pushfd
	push ebx

	mov eax, [ebp+12]	; a
	mov ebx, [ebp+8]	; b

	cmp eax, ebx		; realno nema sta da pisem izi je
	jne nisuJednaki
	mov eax, 0
	jmp kraj
	
	nisuJednaki:
	cmp eax, ebx
	jnl prviNijeManji
	mov eax, 1
	jmp kraj

	prviNijeManji:
	mov eax, 2
	
	kraj:
	pop ebx
	popfd
	pop ebp
	ret 8
poredi endp
main proc

	; 2022 Jun2 zad 2.

	
	xor ebx, ebx
	mov ecx, n
	dec ecx						; idem do pretposlednje vrste jer za zadnju nema smisla proveravati
	spo:
		xor esi, esi
		un:
			movzx eax, byte ptr mat[ebx][esi]	; a[i][j] u EAX (tj AL jer su 8b)
			
			mov edi, ebx
			add edi, n
			movzx edx, byte ptr mat[edi][esi]	; a[i+1][j] u EDX (tj DL jer su 8b)
			
			push eax		; baci na stek prvi podatak
			push edx		; baci na stek drugi podatak
			call poredi		; posle poziva rez je u EAX

			cmp eax, 1		
			jne dalje
			mov mat[ebx][esi], dl

			dalje:
			inc esi
			cmp esi, n
			jl un
		
		add ebx, n
		loop spo
	

	nop
	ret
main endp
end main
