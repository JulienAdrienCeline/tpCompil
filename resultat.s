	.text
	.file	"resultat04_autreReactionBizarre.ll"
	.globl	definir
	.align	16, 0x90
	.type	definir,@function
definir:                                # @definir
	.cfi_startproc
# BB#0:
	movl	%edi, %eax
	retq
.Ltmp0:
	.size	definir, .Ltmp0-definir
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp1:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp2:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp3:
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
.Ltmp4:
	.cfi_def_cfa_offset 48
.Ltmp5:
	.cfi_offset %rbx, -32
.Ltmp6:
	.cfi_offset %r14, -24
.Ltmp7:
	.cfi_offset %rbp, -16
	movl	$15, 12(%rsp)
	movl	$15, %edi
	callq	definir
	movl	%eax, %r14d
	movl	$15, %edi
	callq	definir
	movl	%eax, %ebp
	movb	$0, 11(%rsp)
	movb	$10, 10(%rsp)
	movb	$100, 9(%rsp)
	movb	$37, 8(%rsp)
	leaq	8(%rsp), %rbx
	movl	$15, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	printf
	movl	$15, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	printf
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movl	%ebp, %esi
	callq	printf
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movl	%r14d, %esi
	callq	printf
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Ltmp8:
	.size	main, .Ltmp8-main
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits