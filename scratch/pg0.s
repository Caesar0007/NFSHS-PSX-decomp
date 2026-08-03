	.file	1 "pg0.i"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$5,%hi(g4) # high
	lui	$2,%hi(c8) # high
	lui	$3,%hi(big) # high
	lbu	$4,%lo(c8)($2)
	lw	$2,%lo(g4)($5)
	lw	$3,%lo(big)($3)
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	f

	.comm	g4,4

	.comm	c8,8

	.comm	big,256
