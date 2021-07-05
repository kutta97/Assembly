iput:	.asciz	"년도를 입력하세요(종료: 음수) "
out1:	.asciz	"%d 윤년입니다.\n"
out2:	.asciz	"%d 평년입니다.\n"
fmt	:	.asciz	"%d"
		.align	4
		.global main

main:	save    %sp, -96, %sp

loop:	set		iput, %o0		! printf("년도를 입력하세요(종료: 음수) ");
		call	printf
		nop
		set		fmt, %o0		! scanf("%d", year);
		add		%fp, -4, %o1
		call	scanf
		nop
		ld		[%fp-4], %l0
		tst		%l0				! if year < 0 (음수인 경우)
		bl		exit			! 프로그램 종료
		nop

div1:	mov		%l0, %o0
		mov		400, %o1
		call	.rem
		nop
		tst		%o0				! 나머지를 0과 비교
		be		print1			! 400으로 나누어 떨어지면 윤년
		nop

div2:	mov		%l0, %o0
		mov		4, %o1
		call	.rem
		nop
		tst		%o0				! 나머지를 0과 비교
		bne		print2			! 4로 나누어 떨어지지 않으면 평년
		nop

div3:	mov		%l0, %o0
		mov		100, %o1
		call	.rem
		nop
		tst		%o0				! 나머지를 0과 비교
		be		print2			! 100으로 나누어 떨어지면 평년
		nop
		ba		print1			! 100으로 나누어 떨어지지 않으면 윤년
		nop	

print1:	set		out1, %o0		! printf("%d 윤년입니다.\n");
		mov		%l0, %o1
		call	printf
		nop
		ba		loop
		nop

print2:	set		out2, %o0		! printf("%d 평년입니다.\n");
		mov		%l0, %o1
		call	printf
		nop
		ba		loop
		nop

exit:	ret
		restore