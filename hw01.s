fmt1:   .asciz	"++x * z--		: %d\n"
fmt2:   .asciz	"x || --y && z		: %d\n"
fmt3:   .asciz	"z += x >> 2 + ++y	: %d\n"
fmt4:   .asciz	"x = y = z = 5		: %d\n"
fmt5:   .asciz	"(x = 1 + 2, 2 - 1)	: %d\n"
        .align	4
        .global	main

main:   save    %sp, -96, %sp
        mov     1, %l0			! x = 1
        mov     2, %l1			! y = 2
		mov     3, %l2			! z = 3

        ! fmt1
		inc     %l0
		mov		%l0, %o0
		mov		%l2, %o1
		dec		%l2
		call	.mul
		nop

		mov		%o0, %o1
		set     fmt1, %o0
        call    printf
        nop

		! fmt2
		dec		%l1

		! fmt3
		inc		%l1
		add		%l1, 2, %l3
		srl		%l0, %l3, %l0
		add		%l2, %l0, %l2
		mov		%l2, %o1
		set     fmt3, %o0
        call    printf

		! fmt4
		mov		5, %l2
		mov		%l2, %l1
		mov		%l1, %l0
		mov		%l0, %o1
		set     fmt4, %o0
        call    printf

		! fmt5
		mov		1, %l3
		mov		2, %l4
		add		%l3, %l4, %l5
		mov		2, %l3
		mov		1, %l4
		sub		%l3, %l4, %l0
		mov		%l0, %o1
		set     fmt5, %o0
        call    printf

true:	mov		1, %l3

        ret
        restore