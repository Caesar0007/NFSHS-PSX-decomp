	.text
	.globl	CdSetDebug
CdSetDebug:
	.extern	CD_debug, 4
	lw	$2,CD_debug
	.set	noreorder
	j	$31
	sw	$4,CD_debug
	.set	reorder
