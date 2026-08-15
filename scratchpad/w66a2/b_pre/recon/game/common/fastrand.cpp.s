	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\fastrand.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	fastRandom
	.sdata
	.align	2
fastRandom:
	.word	-126570751
	.globl	randtemp
	.align	2
randtemp:
	.word	0
	.globl	randSeed
	.align	2
randSeed:
	.word	1
	.globl	numRandCalls
	.align	2
numRandCalls:
	.word	0
	.text
	.align	2
	.globl	FastRandom_CleanUp__Fv
	.align	2
	.globl	FastRandom_StartUp__FUi

	.text
	.text
	.ent	FastRandom_CleanUp__Fv
FastRandom_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	FastRandom_CleanUp__Fv
	.text
	.ent	FastRandom_StartUp__FUi
FastRandom_StartUp__FUi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,274857984			# 0x10620000
	ori	$2,$2,0x4dd3
	multu	$4,$2
	li	$3,123404288			# 0x075b0000
	ori	$3,$3,0xcd15
	li	$2,987627520			# 0x3ade0000
	ori	$2,$2,0x68b1
	sw	$3,randSeed
	sw	$2,fastRandom
	mfhi	$6
	#nop
	#nop
	srl	$3,$6,5
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L607
	move	$5,$0
	.set	macro
	.set	reorder

	li	$4,123404288			# 0x075b0000
	ori	$4,$4,0xcd15
$L603:
	lw	$2,fastRandom
	#nop
	mult	$2,$4
	addu	$5,$5,1
	mflo	$2
	#nop
	#nop
	sw	$2,randtemp
	andi	$2,$2,0xffff
	sw	$2,fastRandom
	slt	$2,$5,$3
	bne	$2,$0,$L603
$L607:
	j	$31
	.end	FastRandom_StartUp__FUi
