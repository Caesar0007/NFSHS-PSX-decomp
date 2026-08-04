	.file	1 "s4.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdSetDebug

	.comm	CD_debug,4

	.text
	.def	CdSetDebug;	.val	CdSetDebug;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	level;	.val	4;	.scl	17;	.type	0x4;	.endef
	lw	$2,CD_debug
	sw	$4,CD_debug
	j	$31

	.loc	1 0
LM1:
	.end	CdSetDebug
	.def	CD_debug;	.val	CD_debug;	.scl	2;	.type	0x4;	.endef
