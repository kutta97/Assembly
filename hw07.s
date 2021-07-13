		.section ".text"
fmtp1:	.asciz	"화씨 온도를 입력 하시오 : "
fmtp2:	.asciz	"섭씨 온도는 %f도 입니다.\n"
fmts1:	.asciz	"%lf"
		.align	4
		f_s		= -8	! 화씨 온도 : 8byte double
		c_s		= -16	! 섭씨 온도 : 8byte double
		.global	main

main:	save	%sp, -(92+16)&-8, %sp
		set		fmtp1, %o0
		call	printf
		nop

input:	set		fmts1, %o0
		add		%fp, f_s, %o1
		call	scanf
		nop

		add		%fp, f_s, %l0	! 화씨 온도 load
		ld		[%l0], %o0		! %fp - 8
		ld		[%l0 + 4], %o1	! %fp - 4
		call	ftoc
		nop

		add		%fp, c_s, %l0	! 섭씨 온도 store
		st		%f0, [%l0]		! %fp - 16
		st		%f1, [%l0 + 4]	! %fp - 12

output:	set		fmtp2, %o0
		ld		[%l0], %o1		! %fp - 16
		ld		[%l0 + 4], %o2	! %fp - 12
		call	printf
		nop

		mov		1, %g1			! exit(0)
		ta		0

		.section ".data"
a	:	.single	0r5.0
b	:	.single	0r9.0
c	:	.single	0r32.0

		.section ".text"
ftoc:	save	%sp, -(92+8)&-8, %sp
		set		a, %l0
		set		b, %l1
		ld		[%l0], %f0
		ld		[%l1], %f1
		fdivs	%f0, %f1, %f0	! 5.0 / 9.0
		fstod	%f0, %f0		! 배정밀도로 변환

		st		%i0, [%fp - 8]
		st		%i1, [%fp - 4]
		ldd		[%fp - 8], %f2
		set		c, %l0
		ld		[%l0], %f4
		fstod	%f4, %f4
		fsubd	%f2, %f4, %f2	! f - 32.0

		fmuld	%f0, %f2, %f0	! (5.0 / 9.0) * (f - 32.0)
		ret
		restore