	.file	1 "C:\\Temp\\nfs4-decomp\\scratchpad\\w63a8\\flagtest.i"
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
	move	$2,$4
	sw	$2,g
	j	$31
	.end	f

	.comm	g,4
