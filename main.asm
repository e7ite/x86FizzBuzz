	extern      printf
	extern      scanf

section .data
	msg 	    db "Enter a number to loop to: ", 0
    	msg2        db "Looping until %d", 10, 0
	scanFmt	    db "%d", 0
    	fmt         db "%d", 10, 0
    	fizz        db "fizz", 10, 0
    	buzz        db "buzz", 10, 0
    	both        db "fizzbuzz", 10, 0

section .bss
	buf 	    resb 0x10

section .text
	global 	    main
    	global      FIZZBUZZ

main:
	push 	ebp
	mov 	ebp, esp

    	mov     eax, msg
    	push    eax
    	call    printf

    	mov     dword [ebp - 4], 0
    	lea     eax, [ebp - 4]
    	push    eax
    	mov     ebx, scanFmt
    	push    ebx
    	call    scanf
    	add     esp, 8
    
    	mov     ebx, msg2
    	push    ebx
    	call    printf
    	add     esp, 4

    	call    FIZZBUZZ

    	mov     esp, ebp
    	pop     ebp
    	ret
	
FIZZBUZZ:
    	push    ebp
    	mov     ebp, esp
    	sub     esp, 4

    	mov     ecx, 1
FOR_LOOP_1_TO_N:
    	mov     eax, [ebp + 0x8]
    	cmp     ecx, eax
    	jg      END

    	mov     edx, 0
    	mov     eax, ecx
    	mov     ebx, 3
    	cdq
    	idiv    ebx
    	cmp     edx, 0
    	jne     NOT_MOD3
    	mov     byte [ebp - 1], 0x1
    	jmp     MOD5
NOT_MOD3:
    	mov     byte [ebp - 1], 0x0
MOD5:
    	mov     edx, 0
    	mov     eax, ecx
    	mov     ebx, 5
    	cdq
    	idiv    ebx
    	cmp     edx, 0
    	jne     NOT_MOD5
    	mov     byte [ebp - 2], 0x1
    	jmp     CHECK_MOD3_AND_MOD5
NOT_MOD5:
    	mov     byte [ebp - 2], 0x0

CHECK_MOD3_AND_MOD5:
    	movzx   eax, byte [ebp - 1]
    	cmp     eax, 1
    	jne     CHECK_MOD3
    	movzx   edx, byte [ebp - 2]
    	cmp     edx, 1
    	jne     CHECK_MOD3
    	mov     edx, both
    	jmp     PRINT_FIZZBUZZ
CHECK_MOD3:
    	movzx   edx, byte [ebp - 1]
    	cmp     edx, 1
    	jne     CHECK_MOD5
    	mov     edx, fizz
    	jmp     PRINT_FIZZBUZZ
CHECK_MOD5:
    	movzx   edx, byte [ebp - 2]
    	cmp     edx, 1
    	jne     PRINT_I
    	mov     edx, buzz
PRINT_FIZZBUZZ:
    	push    ecx
    	push    edx
    	jmp     OUTPUT
PRINT_I:
    	mov     edx, ecx
    	push    edx
    	mov     edx, fmt
    	push    edx
OUTPUT:
    	call    printf
    	add     esp, 4
    	pop     ecx
    	inc     ecx
    	jmp     FOR_LOOP_1_TO_N
    
END:
    	mov     esp, ebp
    	pop     ebp
    	ret
