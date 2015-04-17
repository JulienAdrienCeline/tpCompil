	.file	"resultat.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushl	%esi
.Ltmp2:
	.cfi_def_cfa_offset 8
	subl	$24, %esp
.Ltmp3:
	.cfi_def_cfa_offset 32
.Ltmp4:
	.cfi_offset %esi, -8
	movl	$3, 20(%esp)
	movl	$3, %esi
	movl	$3, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_2
# BB#1:                                 # %label1
	movl	$6, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
.LBB0_2:                                # %label2
	movl	%esi, 4(%esp)
	movl	$str1, (%esp)
	calll	printf
	xorl	%eax, %eax
	addl	$24, %esp
	popl	%esi
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
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


	.section	".note.GNU-stack","",@progbits
