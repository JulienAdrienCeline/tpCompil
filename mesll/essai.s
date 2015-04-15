	.file	"essai.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
# BB#0:
	subl	$12, %esp
	movl	$.Lstr, (%esp)
	calll	puts
	movl	$20, 4(%esp)
	movl	$.L.str1, (%esp)
	calll	printf
	xorl	%eax, %eax
	addl	$12, %esp
	ret
.Ltmp0:
	.size	main, .Ltmp0-main

	.type	.L.str1,@object         # @.str1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str1:
	.asciz	"k = %d\n"
	.size	.L.str1, 8

	.type	.Lstr,@object           # @str
.Lstr:
	.asciz	"hello world"
	.size	.Lstr, 12


	.ident	"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"
	.section	".note.GNU-stack","",@progbits
