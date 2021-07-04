iput:	.asciz	"4개의 영문자 입력 : "
oput:	.asciz	"%dth 문자 = %c\n"
fmt	:	.asciz	"%s"
		.align	4
		.global main

main:	save    %sp, -96, %sp
		set		iput, %o0		! printf("4개의 영문자 입력 : ");
		call	printf
		nop
		set		fmt, %o0		! scanf("%s", str);
		add		%fp, -4, %o1
		call	scanf
		nop
		ld		[%fp-4], %l0
		mov		1, %l1			! i = 1;
		mov		5, %l2			! 출력된 문자의 순서를 계산할 때 사용(5 - i)

print:	cmp		%l1, 4			! if i > 4
		bg		exit			! print 종료
		nop
		set		oput, %o0		! printf("%dth 문자 = %c\n");
		sub		%l2, %l1, %o1	! 출력된 문자는 5 - i 번째 문자이다.
		mov		%l0, %o2
		call	printf
		nop
		srl		%l0, 8, %l0		! 1byte(문자 1개) 쉬프트
		inc		%l1				! i++;
		ba		print			! 후방 분기
		nop

exit:	ret
		restore