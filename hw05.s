		.section ".text"
fmt01:	.asciz	">> 직원의 정보(이름, ID, 급여)를 입력하세요. <<\n"
fmt02:	.asciz	"%d번: "
fmt03:	.asciz	"\n--------------------------------------------\n"
fmt04:	.asciz	" 급여가 %d만원(평균) 이상인 직원 정보 "
fmt05:	.asciz	"\t%s,\t %d만원 \n"
fmt06:	.asciz	"--------------------------------------------\n"
fmts01:	.asciz	"%s %s %d"
		.align	4
		size	= 5
		name	= 0		! 구조체 이름속성 크기 : 12byte
		id		= 12	! 구조체 id 크기 : 8byte
		salary	= 20	! 봉급 크기 : 4byte 정수
		emp		= -120	! emp[5] : 24(구조체 크기) * 5(구조체 배열 크기) = 120byte
		average	= -124	! 급여 평균 : 4byte 정수
		sum		= -128	! 급여 합계 : 4byte 정수
		.global main

main:	save	%sp, -(94+120+8)&-8, %sp
		st		%g0, [%fp + average]		! int average = 0
		st		%g0, [%fp + sum]			! int sum = 0

print1:	! printf(">> 직원의 정보(이름, ID, 급여)를 입력하세요. <<\n");
		set		fmt01, %o0
		call	printf
		nop

		set		emp, %l5		! %l5는 구조체 크기 24씩 줄어드는 변수
		add		%l5, %fp, %l5	! %fp-120
		ba		forInputTest	! emp[i]
		mov		%g0, %l0		! i = 0;

forInputLoop:
		! printf("%d번: ", i+1);
		set		fmt02, %o0
		add		%l0, 1, %o1
		call	printf
		nop

		! scanf("%s %s %d", emp[i].name, emp[i].id, &emp[i].salary);
		set		fmts01, %o0
		add		%l5, name, %o1
		add		%l5, id, %o2
		add		%l5, salary, %o3
		call	scanf
		nop

		! sum += employee[i].salary;
		ld		[%fp + sum], %o0
		ld		[%l5 + salary], %o1
		add		%o0, %o1, %o0
		st		%o0, [%fp + sum]

inc_i:	
		inc		%l0
		add		%l5, 24, %l5	! emp[i] -> emp[i+1]

forInputTest:
		cmp		%l0, size		! i < size
		bl		forInputLoop
		nop

avg:
		! average = sum / SIZE
		ld		[%fp + sum], %o0
		mov		size, %o1
		call	.div
		nop
		st		%o0, [%fp + average]
		ld		[%fp + average], %l1	! %l1 : average

print2:	! printf(" 급여가 %d만원(평균) 이상인 직원 정보 ");
		set		fmt03, %o0
		call	printf
		nop
		set		fmt04, %o0
		mov		%l1, %o1
		call	printf
		nop
		set		fmt03, %o0
		call	printf
		nop

		set		emp, %l5		! %l5는 구조체 크기 24씩 줄어드는 변수
		add		%l5, %fp, %l5	! %fp-120
		ba		forOutputTest	! emp[i]
		mov		%g0, %l0		! i = 0;

forOutputLoop:
		ld		[%l5 + salary], %l2
		cmp		%l1, %l2		! employee[i].salary >= average
		bge		inc_o
		nop

		! printf("\t%s,\t %d만원 \n, employee[i].id, employee[i].salary");
		set		fmt05, %o0
		add		%l5, id, %o1
		ld		[%l5 + salary], %o2
		call	printf
		nop

inc_o:	
		inc		%l0
		add		%l5, 24, %l5	! emp[i] -> emp[i+1]

forOutputTest:
		cmp		%l0, size		! i < size
		bl		forOutputLoop
		nop

		set		fmt06, %o0
		call	printf
		nop

		ret
		restore