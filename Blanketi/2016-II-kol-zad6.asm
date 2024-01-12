.386
.model flat, c
.stack 4096
.data
    N   dd 5
    MAT dw 1, 0, 0, 0, 6
        dw 0, 4, 0, 9, 0
        dw 0, 0, 5, 0, 0
        dw 0, 7, 0, 2, 0
        dw 8, 0, 0, 0, 3
    COL dd ?                    ; ocekuje se 1
.code
aritmSredina proc
    push ebp
    mov ebp, esp
    pushfd
    pushad

    mov esi, [ebp+12]           ; &a
    mov edi, [ebp+8]            ; &b
       
    movzx eax, word ptr [esi]
    movzx ebx, word ptr [edi]
    add eax, ebx                ; sabiraju se 16b, a radim s 32b, odma je resen izlazni prenos
    shr eax, 1

    mov [ebp+12], eax           ; rez na dno steka

    popad
    popfd
    pop ebp
    ret 4
aritmSredina endp
main proc

    ; 2016 II kol zad 6.

    mov esi, N
    shl esi, 1
    mov ecx, esi                ; u ECX je skok za vrste, tj 2*n
    sub esi, 2                  ; u ESI je (2*n - 2) tj indeks poslednje kolone

    xor ebx, ebx                ; u EBX indeks prve vrste

    mov eax, esi
    mul N
    mov edx, eax                ; u EDX indeks poslednje vrste tj (2*n-2)*n

    xor ebp, ebp                ; EBP ce ide posle u COL (tu se pamti indeks kolone)
    xor edi, edi                ; u EDI je maxAritmSredina
    spo:
                                ; poziv procedure
        lea eax, MAT[ebx][esi]
        push eax
        lea eax, MAT[edx][esi]
        push eax
        call aritmSredina
        pop eax
        
        cmp eax, edi            ; ako je u EAX veci od trenutnog maks update-uj podaci
        jl dalje
        mov edi, eax
        mov ebp, esi

        dalje:
        add ebx, ecx            ; EBX predje na sledecu vrstu odozgo na dole
        sub edx, ecx            ; EDX predje na sledecu vrstu odozdo na gore
        sub esi, 2
        cmp esi, 0
        jge spo

    shr ebp, 1                  ; podelim sa 2 jer je matrica 16b i ESI ide na po 2
    mov COL, ebp                ; smesti u memoriju

	nop
	ret
main endp
end main
