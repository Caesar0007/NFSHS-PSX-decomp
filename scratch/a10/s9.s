	.file	1 "s1.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdSetDebug
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,CD_debug
	sw	$4,CD_debug
	j	$31
	.end	CdSetDebug
