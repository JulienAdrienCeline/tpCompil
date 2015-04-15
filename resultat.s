	.file	"resultat.ll"
	.text
	.globl	definir
	.align	16, 0x90
	.type	definir,@function
definir:                                # @definir
	.cfi_startproc
# BB#0:
	movl	%ecx, %eax
	ret
.Ltmp0:
	.size	definir, .Ltmp0-definir
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushl	%ebx
.Ltmp5:
	.cfi_def_cfa_offset 8
	pushl	%edi
.Ltmp6:
	.cfi_def_cfa_offset 12
	pushl	%esi
.Ltmp7:
	.cfi_def_cfa_offset 16
	subl	$16, %esp
.Ltmp8:
	.cfi_def_cfa_offset 32
.Ltmp9:
	.cfi_offset %esi, -16
.Ltmp10:
	.cfi_offset %edi, -12
.Ltmp11:
	.cfi_offset %ebx, -8
	movl	$15, 12(%esp)
	movl	$15, (%esp)
	calll	definir
	movl	%eax, %esi
	movl	$15, (%esp)
	calll	definir
	movl	%eax, %edi
	movb	$0, 11(%esp)
	movb	$10, 10(%esp)
	movb	$100, 9(%esp)
	movb	$37, 8(%esp)
	leal	8(%esp), %ebx
	movl	%ebx, (%esp)
	movl	$15, 4(%esp)
	calll	printf
	movl	%ebx, (%esp)
	movl	$15, 4(%esp)
	calll	printf
	movl	%edi, 4(%esp)
	movl	%ebx, (%esp)
	calll	printf
	movl	%esi, 4(%esp)
	movl	%ebx, (%esp)
	calll	printf
	xorl	%eax, %eax
	addl	$16, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	ret
.Ltmp12:
	.size	main, .Ltmp12-main
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits
