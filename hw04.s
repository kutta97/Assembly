		.section ".text"
fmt1:	.asciz	"정수 7개를 입력하시오 "
fmt2:	.asciz	"정수 7개의 배수\n"
fmt3:	.asciz	"%3d "
fmt4:	.asciz	"%\n"
fmt5:	.asciz	"%d"
		.align	4
		list = -28				! 4 * 7, (i = %l0)
		size = -32				! (4 * 7) + (4 * 1), (size = %l7)
		.global	main

main:	save	%sp, (-96-(4*7)-1*4)&-8, %sp
		mov		7, %o0			! size = 7
		st		%o0, [%fp+size]	! store 7

		set		fmt1, %o0
		call	printf
		nop

		mov		0, %l0			! %l0 : i
		ld		[%fp+size], %l7	! %l7 = n = 7
		ba		stest
		nop

! scanf for loop
sloop:	sll		%l0, 2, %o1		! i * 4
		add		%fp, %o1, %o1	! %fp + i * 4
		add		%o1, list, %o1	! %fp - 28 + i * 4
		set		fmt5, %o0
		call	scanf
		nop
sinc:	inc		%l0				! i++;

stest:	cmp		%l0, %l7		! i < 7
		bl		sloop
		nop

		dec		%l0
		ba		dtest			! i 를 6으로 만들어줌(ld를 사용하지 않고 %l0를 재사용)
		nop

! doubling for loop
dloop:	sll		%l0, 2, %l1		! i * 4
		add		%l1, list, %l1	! - 28 + i * 4
		ld		[%fp+%l1], %o0	! %fp - 28 + i * 4
		mov		%o0, %o1
		call	.mul
		nop
		st		%o0, [%fp+%l1]
dec:	dec		%l0				! i--;

dtest:	tst		%l0				! i => 0
		bge		dloop
		nop
		
		set		fmt2, %o0
		call	printf
		nop

		inc		%l0				! i 를 0으로 만들어줌 (ld를 사용하지 않고 %l0를 재사용)
		ba		ptest
		nop

ploop:	sll		%l0, 2, %l1		! i * 4
		add		%l1, list, %l1	! %fp - 28 + i * 4
		ld		[%fp+%l1], %o1
		set		fmt3, %o0
		call	printf
		nop
pinc:	inc		%l0				! i++;

ptest:	cmp		%l0, %l7		! i < 7
		bl		ploop
		nop
		set		fmt4, %o0
		call	printf
		nop

exit:	ret
		restore