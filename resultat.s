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
	pushl	%edi
	pushl	%esi
.Ltmp6:
	.cfi_offset %esi, -16
.Ltmp7:
	.cfi_offset %edi, -12
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$3, -16(%eax)
	movl	$3, %esi
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$9, -16(%eax)
	subl	$16, %esp
	movl	$3, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_4
# BB#1:                                 # %label2
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$12, -16(%eax)
	movl	$12, %eax
	leal	-16(%ecx), %edx
	movl	%edx, %esp
	movl	$8, -16(%ecx)
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB0_3
# BB#2:                                 # %label4
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$9, -16(%eax)
	movl	$9, %eax
.LBB0_3:                                # %label5
	movl	$8, %esi
	subl	$16, %esp
	movl	%eax, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
	addl	$16, %esp
.LBB0_4:                                # %label3
	movl	$9, %edi
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str1, (%esp)
	calll	printf
	addl	$16, %esp
	subl	$16, %esp
	movl	%edi, 4(%esp)
	movl	$str2, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	leal	-8(%ebp), %esp
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.Ltmp8:
	.size	main, .Ltmp8-main
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


	.section	".note.GNU-stack","",@progbits
