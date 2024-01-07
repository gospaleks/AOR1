.386
.model flat, c
.stack 4096
.data
	a db 3, 2, 1, 0ffh			; za prekoracenje probati neki veci broj
	B dw ?						; ocekuje se 7Bh
.code
konv proc
	push ebp
	mov ebp, esp
	pushfd
	pushad

	; ideja je sledeca:
	;	krenem od cifre najvece tezine (u nasem slucaju to je zadnja cifra u nizu)
	;	u svaki prolaz pomnozim s 10 i dodam trenutnu cifru
	;	za  3 2 1 bi bilo: 0*10  +1 = 1
	;	                   1*10  +2 = 12
	;	                   12*10 +3 = 123
	
	; ovim izbegavam ono jebavanje sa stepen, jer mi treba dodatni registar
	; koji ce da ide 1, 10, 100, 1000... i mnogo me jebe mnozenje s 10 jer uvek mora rez da bude u EDX:EAX
	; u stvari moze mnozenje s 10 da se odradi kao zbir mnozenja sa 8 i sa 2, al opet jebavanje
	; tkd ovako je mnogo mnogo mnogo bolje

	mov esi, [ebp+12]       ; u ESI adresa pocetka niza
	mov ecx, [ebp+8]        ; u ECX broj elemenata - n
	add esi, ecx
	dec esi                 ; da bi ESI krenuo od poslednjeg elementa

	xor eax, eax            ; u EAX ide rezultat
	mov ebx, 10
	petlja:
		mul bx
		cmp dx, 0
		jne prekoracenje      ; ako u DX prilikom mnozenja ima nesto to znaci da je rez veci od 16b
		add al, [esi]         ; parcijalno sabiram rezultat da bi mogo da vidim ima li prekoracenje
		adc ah, 0
		jc prekoracenje

		dec esi
		loop petlja
	jmp sveOk					; ako dodje do ovde sve je ok samo stavi na dno steka eax da se moz preuzme

	prekoracenje:
	mov eax, -1
	sveOk:
	mov [ebp+12], eax		; dodaj
	popad
	popfd
	pop ebp
	ret 4
konv endp
main proc
	
	; 2019 II kol zad 6.

	; u main treba samo nadjem klk elementa ima niz jer nigde nije zapamceno i da se pozove procedura
	
	
	xor esi, esi
	dec esi
	petlja:
		inc esi
		movzx eax, byte ptr a[esi]
		cmp eax, 0ffh
		jne petlja

	push offset a
	push esi
	call konv
	pop eax

	mov B, ax

	nop
	ret
main endp
end main
