fmt1:   .asciz	"++x * z--			: %d\n"
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

        add     %l0, 1, %o0
		mov		%l2, %o1
		call	.mul
		nop

		sub		%l2, 1, %l3
		mov		%o0, %o1
		set     fmt1, %o0
        call    printf
        nop

        ret
        restore