	.file	"resultat.ll"
	.text
	.globl	fac
	.align	16, 0x90
	.type	fac,@function
fac:                                    # @fac
# BB#0:
	subl	$12, %esp
	movl	16(%esp), %eax
	addl	20(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	addl	$12, %esp
	ret
.Ltmp0:
	.size	fac, .Ltmp0-fac

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %label1
	pushl	%ebp
.Ltmp4:
	.cfi_def_cfa_offset 8
.Ltmp5:
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
.Ltmp6:
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$12, %esp
.Ltmp7:
	.cfi_offset %esi, -20
.Ltmp8:
	.cfi_offset %edi, -16
.Ltmp9:
	.cfi_offset %ebx, -12
	movl	$3, -16(%ebp)
	movl	$3, %edi
	movl	$9, -20(%ebp)
	movl	$9, %esi
	subl	$16, %esp
	movl	$9, 4(%esp)
	movl	$3, (%esp)
	calll	fac
	addl	$16, %esp
	subl	$16, %esp
	movl	$3, 4(%esp)
	movl	$str0, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB1_7
# BB#1:                                 # %label2
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$12, -16(%eax)
	movl	$12, %ebx
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$8, -16(%eax)
	movl	$8, %edi
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB1_6
# BB#2:                                 # %label4
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$9, -16(%eax)
	movl	$9, %ebx
	movb	$1, %al
	testb	%al, %al
	jne	.LBB1_4
# BB#3:                                 # %label6
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$12, -16(%eax)
	movl	$12, %ebx
.LBB1_4:                                # %label7
	cmpl	$7, %ebx
	jl	.LBB1_6
# BB#5:                                 # %label8
	movl	%esp, %eax
	leal	-16(%eax), %ecx
	movl	%ecx, %esp
	movl	$4, -16(%eax)
	movl	$4, %edi
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$4, (%esp)
	calll	fac
	addl	$16, %esp
.LBB1_6:                                # %label5
	subl	$16, %esp
	movl	%ebx, 4(%esp)
	movl	$str1, (%esp)
	calll	printf
	addl	$16, %esp
.LBB1_7:                                # %label3
	subl	$16, %esp
	movl	%edi, 4(%esp)
	movl	$str2, (%esp)
	calll	printf
	addl	$16, %esp
	subl	$16, %esp
	movl	%esi, 4(%esp)
	movl	$str3, (%esp)
	calll	printf
	addl	$16, %esp
	xorl	%eax, %eax
	leal	-12(%ebp), %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
.Ltmp10:
	.size	main, .Ltmp10-main
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


	.section	".note.GNU-stack","",@progbits
