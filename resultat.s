	.file	"resultat.ll"
	.text
	.globl	compToTreize
	.align	16, 0x90
	.type	compToTreize,@function
compToTreize:                           # @compToTreize
# BB#0:
	movl	4(%esp), %eax
	cmpl	$12, %eax
	jg	.LBB0_2
# BB#1:                                 # %label1
	addl	$13, %eax
	ret
.LBB0_2:                                # %label2
	addl	$-13, %eax
	ret
.Ltmp0:
	.size	compToTreize, .Ltmp0-compToTreize

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushl	%esi
.Ltmp3:
	.cfi_def_cfa_offset 8
	subl	$24, %esp
.Ltmp4:
	.cfi_def_cfa_offset 32
.Ltmp5:
	.cfi_offset %esi, -8
	movl	$15, (%esp)
	calll	compToTreize
	movl	%eax, %esi
	movl	$7, (%esp)
	calll	compToTreize
	movl	%eax, 8(%esp)
	movl	%esi, 4(%esp)
	movl	$str, (%esp)
	calll	printf
	xorl	%eax, %eax
	addl	$24, %esp
	popl	%esi
	ret
.Ltmp6:
	.size	main, .Ltmp6-main
	.cfi_endproc

	.type	str,@object             # @str
	.section	.rodata,"a",@progbits
	.globl	str
	.align	16
str:
	.asciz	"Les r\303\251sultats sont %d et %d\n"
	.size	str, 30


	.section	".note.GNU-stack","",@progbits
