	.text
	.file	"resultatDef.ll"
	.globl	fac
	.align	16, 0x90
	.type	fac,@function
fac:                                    # @fac
# BB#0:
	pushq	%rax
	movl	$str, %edi
	movl	$5, %esi
	xorl	%eax, %eax
	callq	printf
	popq	%rax
	retq
.Ltmp0:
	.size	fac, .Ltmp0-fac

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %label1
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	callq	fac
	xorl	%eax, %eax
	popq	%rdx
	retq
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	str,@object             # @str
	.section	.rodata,"a",@progbits
	.globl	str
str:
	.asciz	"%d\n"
	.size	str, 4


	.section	".note.GNU-stack","",@progbits
