	.file	"calc_tests/test.ll"
	.text
	.globl	f
	.align	16, 0x90
	.type	f,@function
f:                                      # @f
	.cfi_startproc
# BB#0:
	leaq	1(%rdi), %rax
	ret
.Ltmp0:
	.size	f, .Ltmp0-f
	.cfi_endproc

	.globl	g
	.align	16, 0x90
	.type	g,@function
g:                                      # @g
	.cfi_startproc
# BB#0:
	movl	$1, %eax
	testq	%rdi, %rdi
	js	.LBB1_2
# BB#1:                                 # %label2
	imulq	%rdi, %rdi
	movq	%rdi, %rax
.LBB1_2:                                # %label3
	ret
.Ltmp1:
	.size	g, .Ltmp1-g
	.cfi_endproc

	.globl	fib
	.align	16, 0x90
	.type	fib,@function
fib:                                    # @fib
	.cfi_startproc
# BB#0:
	pushq	%r14
.Ltmp5:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp6:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp7:
	.cfi_def_cfa_offset 32
.Ltmp8:
	.cfi_offset %rbx, -24
.Ltmp9:
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	cmpq	$2, %rbx
	jl	.LBB2_2
# BB#1:                                 # %label5
	leaq	-1(%rbx), %rdi
	callq	fib
	movq	%rax, %r14
	addq	$-2, %rbx
	movq	%rbx, %rdi
	callq	fib
	movq	%rax, %rbx
	addq	%r14, %rbx
.LBB2_2:                                # %label6
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp10:
	.size	fib, .Ltmp10-fib
	.cfi_endproc

	.globl	h
	.align	16, 0x90
	.type	h,@function
h:                                      # @h
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp12:
	.cfi_def_cfa_offset 16
	testq	%rdi, %rdi
	jle	.LBB3_2
# BB#1:                                 # %label8
	subq	%rsi, %rdi
	callq	k
	movq	%rax, %rsi
.LBB3_2:                                # %label9
	movq	%rsi, %rax
	popq	%rdx
	ret
.Ltmp13:
	.size	h, .Ltmp13-h
	.cfi_endproc

	.globl	k
	.align	16, 0x90
	.type	k,@function
k:                                      # @k
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp15:
	.cfi_def_cfa_offset 16
	testq	%rdi, %rdi
	jle	.LBB4_2
# BB#1:                                 # %label11
	callq	h
	movq	%rax, %rsi
	incq	%rsi
.LBB4_2:                                # %label12
	movq	%rsi, %rax
	popq	%rdx
	ret
.Ltmp16:
	.size	k, .Ltmp16-k
	.cfi_endproc

	.globl	mod
	.align	16, 0x90
	.type	mod,@function
mod:                                    # @mod
	.cfi_startproc
# BB#0:
	movq	%rdi, %rcx
	movq	%rcx, %rax
	cqto
	idivq	%rsi
	imulq	%rsi, %rax
	subq	%rax, %rcx
	movq	%rcx, %rax
	ret
.Ltmp17:
	.size	mod, .Ltmp17-mod
	.cfi_endproc

	.globl	abs
	.align	16, 0x90
	.type	abs,@function
abs:                                    # @abs
	.cfi_startproc
# BB#0:
	testq	%rdi, %rdi
	jns	.LBB6_2
# BB#1:                                 # %label13
	negq	%rdi
.LBB6_2:                                # %label15
	movq	%rdi, %rax
	ret
.Ltmp18:
	.size	abs, .Ltmp18-abs
	.cfi_endproc

	.globl	gcd
	.align	16, 0x90
	.type	gcd,@function
gcd:                                    # @gcd
	.cfi_startproc
# BB#0:
	pushq	%r14
.Ltmp22:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp23:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp24:
	.cfi_def_cfa_offset 32
.Ltmp25:
	.cfi_offset %rbx, -24
.Ltmp26:
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	callq	abs
	movq	%rax, %rbx
	movq	%r14, %rdi
	callq	abs
	cmpq	%rax, %rbx
	jg	.LBB7_2
# BB#1:                                 # %label16
	movq	%rbx, %rdi
	movq	%rax, %rsi
	jmp	.LBB7_3
.LBB7_2:                                # %label17
	movq	%rax, %rdi
	movq	%rbx, %rsi
.LBB7_3:                                # %label18
	callq	gcdaux
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp27:
	.size	gcd, .Ltmp27-gcd
	.cfi_endproc

	.globl	gcdaux
	.align	16, 0x90
	.type	gcdaux,@function
gcdaux:                                 # @gcdaux
	.cfi_startproc
# BB#0:
	pushq	%rbx
.Ltmp30:
	.cfi_def_cfa_offset 16
.Ltmp31:
	.cfi_offset %rbx, -16
	movq	%rsi, %rax
	movq	%rdi, %rbx
	testq	%rbx, %rbx
	je	.LBB8_2
# BB#1:                                 # %label20
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	mod
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	gcdaux
.LBB8_2:                                # %label21
	popq	%rbx
	ret
.Ltmp32:
	.size	gcdaux, .Ltmp32-gcdaux
	.cfi_endproc

	.globl	fg
	.align	16, 0x90
	.type	fg,@function
fg:                                     # @fg
	.cfi_startproc
# BB#0:
	addq	gy(%rip), %rdi
	movq	%rdi, %rax
	ret
.Ltmp33:
	.size	fg, .Ltmp33-fg
	.cfi_endproc

	.globl	testtest
	.align	16, 0x90
	.type	testtest,@function
testtest:                               # @testtest
	.cfi_startproc
# BB#0:
	cmpq	%rsi, %rdi
	jne	.LBB10_2
# BB#1:                                 # %label22
	movq	$-1, %rax
	ret
.LBB10_2:                               # %label23
	jg	.LBB10_5
# BB#3:                                 # %label25
	addq	$-5, %rsi
	xorl	%eax, %eax
	cmpq	%rsi, %rdi
	jle	.LBB10_7
# BB#4:                                 # %label29
	movl	$1, %eax
	ret
.LBB10_5:                               # %label26
	addq	$5, %rsi
	movl	$2, %eax
	cmpq	%rsi, %rdi
	jge	.LBB10_7
# BB#6:                                 # %label32
	movl	$3, %eax
.LBB10_7:                               # %label24
	ret
.Ltmp34:
	.size	testtest, .Ltmp34-testtest
	.cfi_endproc

	.globl	fact
	.align	16, 0x90
	.type	fact,@function
fact:                                   # @fact
	.cfi_startproc
# BB#0:
	pushq	%rbx
.Ltmp37:
	.cfi_def_cfa_offset 16
.Ltmp38:
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movl	$1, %eax
	testq	%rbx, %rbx
	jle	.LBB11_2
# BB#1:                                 # %label35
	leaq	-1(%rbx), %rdi
	callq	fact
	imulq	%rbx, %rax
.LBB11_2:                               # %label36
	popq	%rbx
	ret
.Ltmp39:
	.size	fact, .Ltmp39-fact
	.cfi_endproc

	.globl	pow
	.align	16, 0x90
	.type	pow,@function
pow:                                    # @pow
	.cfi_startproc
# BB#0:
	pushq	%rbx
.Ltmp42:
	.cfi_def_cfa_offset 16
.Ltmp43:
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movl	$1, %eax
	testq	%rsi, %rsi
	jle	.LBB12_2
# BB#1:                                 # %label38
	decq	%rsi
	movq	%rbx, %rdi
	callq	pow
	imulq	%rbx, %rax
.LBB12_2:                               # %label39
	popq	%rbx
	ret
.Ltmp44:
	.size	pow, .Ltmp44-pow
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp46:
	.cfi_def_cfa_offset 16
	movq	$2, x(%rip)
	movl	$x__printf_constant, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	callq	printf
	movq	x(%rip), %rsi
	incq	%rsi
	movq	%rsi, x(%rip)
	movl	$x__printf_constant, %edi
	xorl	%eax, %eax
	callq	printf
	movq	x(%rip), %rdi
	callq	f
	movq	%rax, %rcx
	imulq	x(%rip), %rcx
	movq	%rcx, y(%rip)
	movl	$y__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movq	y(%rip), %rdi
	callq	g
	movq	%rax, %rcx
	movq	%rcx, z(%rip)
	movl	$z__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$25, %edi
	callq	fib
	movq	%rax, %rcx
	movq	%rcx, tmp(%rip)
	movl	$tmp__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$10, %edi
	movl	$1, %esi
	callq	h
	movq	%rax, %rcx
	movq	%rcx, u(%rip)
	movl	$u__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$42, %edi
	movl	$91, %esi
	callq	gcdaux
	movq	%rax, %rcx
	movq	%rcx, testgcd1(%rip)
	movl	$testgcd1__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$421264322, %edi        # imm = 0x191BFBC2
	movl	$912356724, %esi        # imm = 0x36617574
	callq	gcdaux
	movq	%rax, %rcx
	movq	%rcx, testgcd2(%rip)
	movl	$testgcd2__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movq	$2, gy(%rip)
	movl	$gy__printf_constant, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$3, %edi
	callq	fg
	movq	%rax, %rcx
	movq	%rcx, gg(%rip)
	movl	$gg__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movq	$-6, %rdi
	xorl	%esi, %esi
	callq	testtest
	movq	%rax, %rcx
	movq	%rcx, testtest1(%rip)
	movl	$testtest1__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movq	$-1, %rdi
	xorl	%esi, %esi
	callq	testtest
	movq	%rax, %rcx
	movq	%rcx, testtest2(%rip)
	movl	$testtest2__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	testtest
	movq	%rax, %rcx
	movq	%rcx, testtest3(%rip)
	movl	$testtest3__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$1, %edi
	xorl	%esi, %esi
	callq	testtest
	movq	%rax, %rcx
	movq	%rcx, testtest4(%rip)
	movl	$testtest4__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$6, %edi
	xorl	%esi, %esi
	callq	testtest
	movq	%rax, %rcx
	movq	%rcx, testtest5(%rip)
	movl	$testtest5__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$10, %edi
	callq	fact
	movq	%rax, %rcx
	movq	%rcx, f10(%rip)
	movl	$f10__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$20, %edi
	callq	fact
	movq	%rax, %rcx
	movq	%rcx, f20(%rip)
	movl	$f20__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$30, %edi
	callq	fact
	movq	%rax, %rcx
	movq	%rcx, f30(%rip)
	movl	$f30__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$100, %edi
	callq	fact
	movq	%rax, %rcx
	movq	%rcx, f100(%rip)
	movl	$f100__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$1000, %edi             # imm = 0x3E8
	callq	fact
	movq	%rax, %rcx
	movq	%rcx, f1000(%rip)
	movl	$f1000__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$2, %edi
	movl	$62, %esi
	callq	pow
	movq	%rax, %rcx
	movq	%rcx, test62(%rip)
	movl	$test62__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$2, %edi
	movl	$63, %esi
	callq	pow
	movq	%rax, %rcx
	movq	%rcx, test63(%rip)
	movl	$test63__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$2, %edi
	movl	$64, %esi
	callq	pow
	movq	%rax, %rcx
	movq	%rcx, test64(%rip)
	movl	$test64__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	movl	$2, %edi
	movl	$65, %esi
	callq	pow
	movq	%rax, %rcx
	movq	%rcx, test65(%rip)
	movl	$test65__printf_constant, %edi
	xorl	%eax, %eax
	movq	%rcx, %rsi
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	ret
.Ltmp47:
	.size	main, .Ltmp47-main
	.cfi_endproc

	.type	x,@object               # @x
	.bss
	.globl	x
	.align	8
x:
	.quad	0                       # 0x0
	.size	x, 8

	.type	x__printf_constant,@object # @x__printf_constant
	.section	.rodata,"a",@progbits
	.globl	x__printf_constant
x__printf_constant:
	.asciz	"x = %ld\n"
	.size	x__printf_constant, 9

	.type	y,@object               # @y
	.bss
	.globl	y
	.align	8
y:
	.quad	0                       # 0x0
	.size	y, 8

	.type	y__printf_constant,@object # @y__printf_constant
	.section	.rodata,"a",@progbits
	.globl	y__printf_constant
y__printf_constant:
	.asciz	"y = %ld\n"
	.size	y__printf_constant, 9

	.type	z,@object               # @z
	.bss
	.globl	z
	.align	8
z:
	.quad	0                       # 0x0
	.size	z, 8

	.type	z__printf_constant,@object # @z__printf_constant
	.section	.rodata,"a",@progbits
	.globl	z__printf_constant
z__printf_constant:
	.asciz	"z = %ld\n"
	.size	z__printf_constant, 9

	.type	tmp,@object             # @tmp
	.bss
	.globl	tmp
	.align	8
tmp:
	.quad	0                       # 0x0
	.size	tmp, 8

	.type	tmp__printf_constant,@object # @tmp__printf_constant
	.section	.rodata,"a",@progbits
	.globl	tmp__printf_constant
tmp__printf_constant:
	.asciz	"tmp = %ld\n"
	.size	tmp__printf_constant, 11

	.type	u,@object               # @u
	.bss
	.globl	u
	.align	8
u:
	.quad	0                       # 0x0
	.size	u, 8

	.type	u__printf_constant,@object # @u__printf_constant
	.section	.rodata,"a",@progbits
	.globl	u__printf_constant
u__printf_constant:
	.asciz	"u = %ld\n"
	.size	u__printf_constant, 9

	.type	testgcd1,@object        # @testgcd1
	.bss
	.globl	testgcd1
	.align	8
testgcd1:
	.quad	0                       # 0x0
	.size	testgcd1, 8

	.type	testgcd1__printf_constant,@object # @testgcd1__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testgcd1__printf_constant
testgcd1__printf_constant:
	.asciz	"testgcd1 = %ld\n"
	.size	testgcd1__printf_constant, 16

	.type	testgcd2,@object        # @testgcd2
	.bss
	.globl	testgcd2
	.align	8
testgcd2:
	.quad	0                       # 0x0
	.size	testgcd2, 8

	.type	testgcd2__printf_constant,@object # @testgcd2__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testgcd2__printf_constant
testgcd2__printf_constant:
	.asciz	"testgcd2 = %ld\n"
	.size	testgcd2__printf_constant, 16

	.type	gy,@object              # @gy
	.bss
	.globl	gy
	.align	8
gy:
	.quad	0                       # 0x0
	.size	gy, 8

	.type	gy__printf_constant,@object # @gy__printf_constant
	.section	.rodata,"a",@progbits
	.globl	gy__printf_constant
gy__printf_constant:
	.asciz	"gy = %ld\n"
	.size	gy__printf_constant, 10

	.type	gg,@object              # @gg
	.bss
	.globl	gg
	.align	8
gg:
	.quad	0                       # 0x0
	.size	gg, 8

	.type	gg__printf_constant,@object # @gg__printf_constant
	.section	.rodata,"a",@progbits
	.globl	gg__printf_constant
gg__printf_constant:
	.asciz	"gg = %ld\n"
	.size	gg__printf_constant, 10

	.type	testtest1,@object       # @testtest1
	.bss
	.globl	testtest1
	.align	8
testtest1:
	.quad	0                       # 0x0
	.size	testtest1, 8

	.type	testtest1__printf_constant,@object # @testtest1__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testtest1__printf_constant
	.align	16
testtest1__printf_constant:
	.asciz	"testtest1 = %ld\n"
	.size	testtest1__printf_constant, 17

	.type	testtest2,@object       # @testtest2
	.bss
	.globl	testtest2
	.align	8
testtest2:
	.quad	0                       # 0x0
	.size	testtest2, 8

	.type	testtest2__printf_constant,@object # @testtest2__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testtest2__printf_constant
	.align	16
testtest2__printf_constant:
	.asciz	"testtest2 = %ld\n"
	.size	testtest2__printf_constant, 17

	.type	testtest3,@object       # @testtest3
	.bss
	.globl	testtest3
	.align	8
testtest3:
	.quad	0                       # 0x0
	.size	testtest3, 8

	.type	testtest3__printf_constant,@object # @testtest3__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testtest3__printf_constant
	.align	16
testtest3__printf_constant:
	.asciz	"testtest3 = %ld\n"
	.size	testtest3__printf_constant, 17

	.type	testtest4,@object       # @testtest4
	.bss
	.globl	testtest4
	.align	8
testtest4:
	.quad	0                       # 0x0
	.size	testtest4, 8

	.type	testtest4__printf_constant,@object # @testtest4__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testtest4__printf_constant
	.align	16
testtest4__printf_constant:
	.asciz	"testtest4 = %ld\n"
	.size	testtest4__printf_constant, 17

	.type	testtest5,@object       # @testtest5
	.bss
	.globl	testtest5
	.align	8
testtest5:
	.quad	0                       # 0x0
	.size	testtest5, 8

	.type	testtest5__printf_constant,@object # @testtest5__printf_constant
	.section	.rodata,"a",@progbits
	.globl	testtest5__printf_constant
	.align	16
testtest5__printf_constant:
	.asciz	"testtest5 = %ld\n"
	.size	testtest5__printf_constant, 17

	.type	f10,@object             # @f10
	.bss
	.globl	f10
	.align	8
f10:
	.quad	0                       # 0x0
	.size	f10, 8

	.type	f10__printf_constant,@object # @f10__printf_constant
	.section	.rodata,"a",@progbits
	.globl	f10__printf_constant
f10__printf_constant:
	.asciz	"f10 = %ld\n"
	.size	f10__printf_constant, 11

	.type	f20,@object             # @f20
	.bss
	.globl	f20
	.align	8
f20:
	.quad	0                       # 0x0
	.size	f20, 8

	.type	f20__printf_constant,@object # @f20__printf_constant
	.section	.rodata,"a",@progbits
	.globl	f20__printf_constant
f20__printf_constant:
	.asciz	"f20 = %ld\n"
	.size	f20__printf_constant, 11

	.type	f30,@object             # @f30
	.bss
	.globl	f30
	.align	8
f30:
	.quad	0                       # 0x0
	.size	f30, 8

	.type	f30__printf_constant,@object # @f30__printf_constant
	.section	.rodata,"a",@progbits
	.globl	f30__printf_constant
f30__printf_constant:
	.asciz	"f30 = %ld\n"
	.size	f30__printf_constant, 11

	.type	f100,@object            # @f100
	.bss
	.globl	f100
	.align	8
f100:
	.quad	0                       # 0x0
	.size	f100, 8

	.type	f100__printf_constant,@object # @f100__printf_constant
	.section	.rodata,"a",@progbits
	.globl	f100__printf_constant
f100__printf_constant:
	.asciz	"f100 = %ld\n"
	.size	f100__printf_constant, 12

	.type	f1000,@object           # @f1000
	.bss
	.globl	f1000
	.align	8
f1000:
	.quad	0                       # 0x0
	.size	f1000, 8

	.type	f1000__printf_constant,@object # @f1000__printf_constant
	.section	.rodata,"a",@progbits
	.globl	f1000__printf_constant
f1000__printf_constant:
	.asciz	"f1000 = %ld\n"
	.size	f1000__printf_constant, 13

	.type	test62,@object          # @test62
	.bss
	.globl	test62
	.align	8
test62:
	.quad	0                       # 0x0
	.size	test62, 8

	.type	test62__printf_constant,@object # @test62__printf_constant
	.section	.rodata,"a",@progbits
	.globl	test62__printf_constant
test62__printf_constant:
	.asciz	"test62 = %ld\n"
	.size	test62__printf_constant, 14

	.type	test63,@object          # @test63
	.bss
	.globl	test63
	.align	8
test63:
	.quad	0                       # 0x0
	.size	test63, 8

	.type	test63__printf_constant,@object # @test63__printf_constant
	.section	.rodata,"a",@progbits
	.globl	test63__printf_constant
test63__printf_constant:
	.asciz	"test63 = %ld\n"
	.size	test63__printf_constant, 14

	.type	test64,@object          # @test64
	.bss
	.globl	test64
	.align	8
test64:
	.quad	0                       # 0x0
	.size	test64, 8

	.type	test64__printf_constant,@object # @test64__printf_constant
	.section	.rodata,"a",@progbits
	.globl	test64__printf_constant
test64__printf_constant:
	.asciz	"test64 = %ld\n"
	.size	test64__printf_constant, 14

	.type	test65,@object          # @test65
	.bss
	.globl	test65
	.align	8
test65:
	.quad	0                       # 0x0
	.size	test65, 8

	.type	test65__printf_constant,@object # @test65__printf_constant
	.section	.rodata,"a",@progbits
	.globl	test65__printf_constant
test65__printf_constant:
	.asciz	"test65 = %ld\n"
	.size	test65__printf_constant, 14


	.section	".note.GNU-stack","",@progbits
