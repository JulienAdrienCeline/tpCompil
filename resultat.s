	.file	"resultat.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	subl	$12, %esp
.Ltmp1:
	.cfi_def_cfa_offset 16
	movl	$1, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	movl	$0, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
	movl	$0, 4(%esp)
	movl	$str1, (%esp)
	calll	printf
	movl	$1, 4(%esp)
	movl	$str2, (%esp)
	calll	printf
	movl	$-16, 4(%esp)
	movl	$str3, (%esp)
	calll	printf
	movl	$-20, 4(%esp)
	movl	$str4, (%esp)
	calll	printf
	xorl	%eax, %eax
	addl	$12, %esp
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	str,@object             # @str
	.section	.rodata,"a",@progbits
	.globl	str
str:
	.asciz	"%d\n"
	.size	str, 4

	.type	str0,@object            # @str0
	.globl	str0
str0:
	.asciz	"%d\n"
	.size	str0, 4

	.type	str1,@object            # @str1
	.globl	str1
str1:
	.asciz	"%d\n"
	.size	str1, 4

	.type	str2,@object            # @str2
	.globl	str2
str2:
	.asciz	"%d\n"
	.size	str2, 4

	.type	str3,@object            # @str3
	.globl	str3
str3:
	.asciz	"%d\n"
	.size	str3, 4

	.type	str4,@object            # @str4
	.globl	str4
str4:
	.asciz	"%d\n"
	.size	str4, 4


	.section	".note.GNU-stack","",@progbits
