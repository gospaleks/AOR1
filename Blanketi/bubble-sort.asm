.386
.model flat, c
.stack 4096
.data
	niz dd 5, 1, 2, 10, 8, 3, 0
	n dd 7
.code

; void sort(int n, int a[]);

; ovo je nesto tipa bubble sort al jos gore
; al vremenska slozenost ovde nije bitna

sort proc
	push ebp
	mov ebp, esp
	pushfd
	pushad


	; spoljasnja petlja ide n puta
	; unutrasnja n-1
	; posmatra svaka dva susedna
	; i menja mesta ako je prvi manji od drugog
	; ovim se najveci element u svakom prolazu istiskuje na kraj niza

	; algoritam moze da se poboljsa tako da unutrasnja petlja ide od 0 do n-i-1 al to komplikuje s registri samo

	mov ecx, [ebp+8]
	spo:
		push ecx
		mov esi, [ebp+12]				; adresa prvog elementa niza
		mov ecx, [ebp+8]
		dec ecx
		un:
			mov eax, [esi]
			mov ebx, [esi][4]
			cmp eax, ebx				; poredi susedna dva
			jng dalje
			mov [esi], ebx				; zameni im mesta ako je prvi veci od drugog
			mov [esi][4], eax
			dalje:
			add esi, 4					
			loop un
		pop ecx
		loop spo

	popad
	popfd
	pop ebp
	ret 8
sort endp
main proc
	
	push offset niz
	push n
	call sort

	nop
	ret
main endp
end main
