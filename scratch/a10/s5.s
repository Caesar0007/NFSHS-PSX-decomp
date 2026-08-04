	.text
	.globl	CdSetDebug
	.extern	CD_debug, 4
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31
	.mask	0x00000000,0
	lw	$2,CD_debug
	sw	$4,CD_debug
	j	$31
	.end	CdSetDebug
