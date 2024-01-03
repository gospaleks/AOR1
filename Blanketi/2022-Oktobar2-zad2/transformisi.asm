.386
.model flat, c
public transformisi
.code
transformisi proc
	push ebp
	mov ebp, esp
	push esi
	push edi
	push eax
	push ebx
	push ecx
	push edx


	xor eax, eax

	mov esi, [ebp+8]		; u ESI adresa niza
	mov edi, esi			; EDI mi pokazuje na mesto gde treba upisujem nov sadrzaj
	mov al, [esi]			; u AL preuzimam trenutni karakter
	petlja:
		mov edx, esi
		mov ah, 0
		vrti:					; ova petlja broji klk puta se ponavlja trenutni char
			cmp al, [edx]
			jne izadji
			inc ah	
			inc edx
			jmp vrti

		izadji:					
		cmp ah, 2				; u AH mi je broj pojavljivanja
		jle dalje
		add ah, 48
		mov [edi], ah			; upsii broj pojavljivanja ako nije <= 2 (+48 jer ocu char da mi upise)
		sub ah, 48				; vratim ga jer mi br pojavljivanja treba da znam klk da preskocim u ESI
		inc edi
		mov [edi], al			; upisem posle broja pojavljivanja i sam karakter
		inc edi

		mov al, ah		
		mov ah, 0
		add esi, eax			; ovde preskacem klk treba
		jmp nastavi

		dalje:
		mov [edi], al			; ako je br pojavljivanja <= 2 onda samo upisem isti char
		inc edi
		inc esi
		nastavi:
		mov al, [esi]			; ovde idemo na sledeci
		cmp al, 0				; provera dal je doso do kraj
		jne petlja

	mov byte ptr [edi], 0		; vestacki stavi kraj jer duzina vrv nije ista kao pocetni string
		
	; ovde bi trebalo da vratim neki kurac
	; al iskr ne kontam cemu to


	pop edx
	pop ecx
	pop ebx
	pop eax
	pop edi
	pop esi
	pop ebp
	ret
transformisi endp
end
