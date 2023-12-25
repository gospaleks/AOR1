.386
.model flat,c
public saberi
.code
saberi proc
	push ebp
	mov ebp, esp
	pushfd

	mov eax, [ebp+8]
	add eax, [ebp+12]
	add eax, [ebp+16]

	popfd
	pop ebp
	ret
saberi endp
end