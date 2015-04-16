	.file	"resultat.ll"
	.text
	.globl	compToTreize
	.align	16, 0x90
	.type	compToTreize,@function
compToTreize:                           # @compToTreize
	.cfi_startproc
# BB#0:
	cmpl	$12, %ecx
	movl	$12, %eax
	ret
.Ltmp0:
	.size	compToTreize, .Ltmp0-compToTreize
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	xorl	%eax, %eax
	ret
.Ltmp1:
	.size	main, .Ltmp1-main
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits
