fmt1:   .asciz	" Score : %d A\n"
fmt2:   .asciz	" Score : %d B\n"
fmt3:   .asciz	" Score : %d C\n"
        .align	4
        .global	main

main:   save    %sp, -96, %sp
		mov     80, %l0			! score = 80
		subcc	%l0, 80, %g0
		bl		next1
		mov		%l0, %o1
		set     fmt1, %o0
        call    printf
		nop
		ba		end

next1:	subcc	%l0, 60, %g0
		bl		next2
		mov		%l0, %o1
		set     fmt2, %o0
        call    printf
		nop
		ba		end

next2:	mov		%l0, %o1
		set     fmt3, %o0
        call    printf
		nop

 end:   ret
        restore