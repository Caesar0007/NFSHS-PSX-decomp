	.file	1 "e1.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdSync

	.text
	.def	CdSync;	.val	CdSync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CdSync
CdSync:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mode;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	result;	.val	5;	.scl	17;	.type	0x1c;	.endef
	bne	$4,$0,$L2
	lui	$2,%hi(CD_cbsync) # high
	sw	$0,%lo(CD_cbsync)($2)
$L2:
	lui	$2,%hi(CD_syncsync) # high
	lw	$2,%lo(CD_syncsync)($2)
	j	$31

	.loc	1 0
LM1:
	.end	CdSync
