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
	movl	$5, 8(%esp)
	movl	$5, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	movl	$18, 4(%esp)
	movl	$str0, (%esp)
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


	.section	".note.GNU-stack","",@progbits
