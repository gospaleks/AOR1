.386
.model flat, c
.stack 4096
.data
	NIZ dd 10 dup(?)
	MAT dd 5, 7
		dd 3, 1
		dd 0, 2
		dd 1, 4
	N dd 4
.code
max proc
	push ebp
	mov ebp, esp
	pushad
	pushfd

	cmp eax, edx			; if (a < b)
	jg dalje		
	mov eax, edx		  	; a = b, u EAX se na kraju nalazi veci
	dalje:
	mov edx, [ebp+8]		
	mov [edx], eax			; izlaz preko adrese

	popfd
	popad
	pop ebp
	ret 4
max endp
main proc	
	
	; II kol 2021/22 zad 5 

	
	;	ebx					esi
	;	0		5 7 ->	7		0
	;	8		3 1 ->	3		4
	;	16		0 2 ->	2		8
	;	24		1 4 ->	7		12

	lea esi, niz				; u esi adresa niza
	xor ebx, ebx
	mov ecx, n				 ; u sustini ovo je spoljasnja petlja koja prodje N puta
	petlja:
						; unutrasnja petlja nema jer imamo samo dve kolone
		mov eax, MAT[ebx]		; uzmi prvi podatak
		mov edx, MAT[ebx][4]		; uzmi drugi podatak
		push esi
		call max
		
		add esi, 4			; adresu niza povecavamo da znamo gde da upisemo s
		add ebx, 8
		loop petlja

	nop
	ret
main endp
end main
