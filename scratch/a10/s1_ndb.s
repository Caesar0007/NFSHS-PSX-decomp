	.file	1 "s1.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.def	CdSetDebug;	.val	CdSetDebug;	.scl	2;	.type	0x24;	.endef
	.globl	CdSetDebug
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	level;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$3,%hi(CD_debug) # high
	lw	$2,%lo(CD_debug)($3)
	sw	$4,%lo(CD_debug)($3)
	j	$31

	.loc	1 0
LM1:
	.end	CdSetDebug
