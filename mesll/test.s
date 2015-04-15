	.file	"test.ll"
	.text
	.globl	mul_add
	.align	16, 0x90
	.type	mul_add,@function
mul_add:                                # @mul_add
	.cfi_startproc
# BB#0:                                 # %entry
                                        # kill: EDX<def> EDX<kill> RDX<def>
                                        # kill: EDI<def> EDI<kill> RDI<def>
	imull	%esi, %edi
	leal	(%rdi,%rdx), %eax
	ret
.Ltmp0:
	.size	mul_add, .Ltmp0-mul_add
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits
