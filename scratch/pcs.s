	.file	1 "pcs.i"
gcc2_compiled.:
__gnu_compiled_c:
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
	lb	$2,0($4)
	j	$31
	.end	f
