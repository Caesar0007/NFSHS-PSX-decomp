	.text
	.globl	CdSetDebug
	.extern	CD_debug, 4
CdSetDebug:
	lw	$2,CD_debug
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,CD_debug
	.set	macro
	.set	reorder
