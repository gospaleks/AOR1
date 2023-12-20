.386
.model flat, c
public stepen2
.code
stepen2 proc
	
	; PROBLEM: x * 2^y
	; x je osnova
	; y je stepen

	pushfd
	push ebp
	mov ebp, esp
	push ecx

	mov eax, [ebp+12]	; u eax je osnova
	mov cl, [ebp+16]	; u cl je stepen
	shl eax, cl

	pop ecx
	pop ebp
	popfd
	ret

stepen2 endp
end