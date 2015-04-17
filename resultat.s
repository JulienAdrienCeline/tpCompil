	.file	"resultat.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushl	%ebp
.Ltmp3:
	.cfi_def_cfa_offset 8
.Ltmp4:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
.Ltmp5:
	.cfi_def_cfa_register %ebp
	pushl	%esi
	pushl	%eax
.Ltmp6:
	.cfi_offset %esi, -12
	movl	$3, -8(%ebp)
	movl	$3, %esi
	subl	$16, %esp
	movl	$3, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_2
# BB#1:                                 # %label2
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$6, -16(%eax)
	movl	$6, %esi
.LBB0_2:                                # %label3
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	leal	-4(%ebp), %esp
	popl	%esi
	popl	%ebp
	ret
.Ltmp7:
	.size	main, .Ltmp7-main
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
