	.file	1 "p4.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f

	.comm	gsmall,4

	.comm	gbig,256

	.lcomm	ssmall,4

	.extern	esmall, 4

	.text
	.text
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gbig) # high
	lw	$2,%lo(gbig)($2)
	lw	$3,esmall
	sw	$4,gsmall
	sw	$4,ssmall
	addu	$2,$4,$2
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	f
