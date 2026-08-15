	.file	1 "scratchpad/w65a3/dtor2.i"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	useit__FP1D

	.text
	.text
	.ent	useit__FP1D
useit__FP1D:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._1A
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	useit__FP1D
