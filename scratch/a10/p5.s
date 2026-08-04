	.file	1 "p5.c"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	gsmall
	.sdata
	.align	2
gsmall:
	.word	5
	.globl	gbig
	.data
	.align	2
gbig:
	.word	1
	.space	252
	.text
	.align	2
	.globl	f

	.text
	.text
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gbig) # high
	lw	$2,%lo(gbig)($2)
	sw	$4,gsmall
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.end	f
