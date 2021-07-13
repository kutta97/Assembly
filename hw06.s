		.section ".text"
fmtp1:	.asciz	"Enter integer 5 number : \n"
fmtp2:	.asciz	"Total = %d\n"
fmts1:	.asciz	"%d"
		.align	4
		n		= 5
		n_s		= -4	! 배열의 크기 : 4byte 정수
		a_s		= -24	! a[5] = 4(자료형 크기) * 5(배열의 크기) = 20byte
		total_s	=  -28	! 배열 원소들의 합 : 4byte 정수
		.global	main

main:	save	%sp, -(92+4+20+4)&-8, %sp
		mov		n, %l1				! %l1 = n = 5
		st		%l1, [%fp + n_s]	! int n = 5

print1:	set		fmtp1, %o0		! printf("Enter integer 5 number : \n");
		call	printf
		nop

		add		%fp, a_s, %l5	! %l5는 int 크기 4씩 줄어드는 변수
		ba		forInputTest	! a[i]
		mov		%g0, %l0		! i = 0;

forInputLoop:
		! scanf("%d", &a[i]);
		set		fmts1, %o0
		mov		%l5, %o1
		call	scanf
		nop

inc_i:	inc		%l0				! i++
		add		%l5, 4, %l5		! a[i] -> a[i+1]

forInputTest:
		cmp		%l0, %l1		! i < n
		bl		forInputLoop
		nop

		mov		%l1, %o0		! sum 의 매개변수 n = 5
		add		%fp, a_s, %o1	! sum 의 매개변수 a[] : 배열의 시작 주소
		call	sum
		nop

print2:	mov		%o0, %o1
		set		fmtp2, %o0		! printf("Total = %d\n");
		call	printf
		nop

exit:	mov		1, %g1					! exit(0)
		ta		0

		total_s_f = -4	! sum 의 지역변수 total : 4byte 정수
sum:	save	%sp, -(92+4)&-8, %sp
		mov		%g0, %l0				! %l0 = total = 0
		st		%l0, [%fp + total_s_f]	! int total = 0
		ba		whileTest
		nop

whileLoop:
		sll		%i0, 2, %l4				! n * 4
		add		%i1, %l4, %l5			! %l5 = a[n]
		ld		[%l5], %l1				! a[n] 값을 load
		add		%l0, %l1, %l0			! total += a[n]
		st		%l0, [%fp + total_s_f]

whileTest:
		tst		%i0						! n > 0
		dec		%i0						! n--
		bg		whileLoop
		nop

		mov		%l0, %i0				! return total
		ret
		restore