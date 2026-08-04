	.file	1 "e3.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdFlush2

	.text
	.def	CdFlush2;	.val	CdFlush2;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	CdFlush2
CdFlush2:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	other
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM1:
	.end	CdFlush2
