	.file	"resultat.ll"
	.text
	.globl	fac
	.align	16, 0x90
	.type	fac,@function
fac:                                    # @fac
# BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%eax
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$5, -16(%eax)
	movl	$5, %esi
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$12, -16(%eax)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB0_2
# BB#1:                                 # %label3
	movl	$12, %eax
	movl	%esp, %ecx
	leal	-16(%ecx), %edx
	movl	%edx, %esp
	movl	$8, -16(%ecx)
	movl	$8, %esi
	subl	$16, %esp
	movl	%eax, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	addl	$16, %esp
.LBB0_2:                                # %label4
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
	leal	-4(%ebp), %esp
	popl	%esi
	popl	%ebp
	ret
.Ltmp0:
	.size	fac, .Ltmp0-fac

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushl	%ebp
.Ltmp4:
	.cfi_def_cfa_offset 8
.Ltmp5:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
.Ltmp6:
	.cfi_def_cfa_register %ebp
	pushl	%edi
	pushl	%esi
.Ltmp7:
	.cfi_offset %esi, -16
.Ltmp8:
	.cfi_offset %edi, -12
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$3, -16(%eax)
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$9, -16(%eax)
	subl	$16, %esp
	movl	$9, 4(%esp)
	movl	$3, (%esp)
	calll	fac
	addl	$16, %esp
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB1_6
# BB#1:                                 # %label5
	movl	$3, %esi
	movl	$9, %edi
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str1, (%esp)
	calll	printf
	addl	$16, %esp
	cmpl	$9, %edi
	jg	.LBB1_3
# BB#2:                                 # %label7
	subl	$16, %esp
	movl	%edi, 4(%esp)
	movl	$str2, (%esp)
	calll	printf
	addl	$16, %esp
.LBB1_3:                                # %label8
	cmpl	$4, %esi
	jg	.LBB1_5
# BB#4:                                 # %label9
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str3, (%esp)
	calll	printf
	addl	$16, %esp
.LBB1_5:                                # %label10
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str4, (%esp)
	calll	printf
	addl	$16, %esp
.LBB1_6:                                # %label6
	xorl	%eax, %eax
	leal	-8(%ebp), %esp
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
.Ltmp9:
	.size	main, .Ltmp9-main
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
