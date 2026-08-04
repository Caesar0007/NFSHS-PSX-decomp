	.text
	.globl	CdSetDebug
	.extern	CD_debug, 4
CdSetDebug:
	.set	reorder
	lw	$2,CD_debug
	sw	$4,CD_debug
	j	$31
