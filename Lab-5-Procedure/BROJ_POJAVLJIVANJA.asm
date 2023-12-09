.386
.model flat,c
.data
	niz db 1, 5, 4, 6, 6, 2, 6, 7
	n dd 8
	rez dd ?			; ocekujemo 3
.stack 4096
.code
brojPojavljivanja proc
	
	mov ebp, esp
	pushfd
	pushad
	
	mov ecx, [ebp+4]	; u ECX mi je N
	mov esi, 0			; rez = 0

	petlja:
		cmp [eax], dl
		jne preskoci
		inc esi			; rez++
		preskoci:
		inc eax
		loop petlja

	mov [ebx], esi		; u memoriju = rez

	popad
	popfd
	ret 4
brojPojavljivanja endp
main proc
	
	lea eax, niz		; u eax je adresa niza
	push n				; broj elemenata preko steka po vrednosti
	lea ebx, rez		; izlazni po adresi mora da bude ulazni
	mov dl, 6			; podatak za koji brojimo preko registra po vrednosti
	call brojPojavljivanja


	ret
main endp
end main