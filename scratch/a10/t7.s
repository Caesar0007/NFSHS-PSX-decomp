	.text
	.globl	tfn
tfn:
	.set	noreorder
	beq	$4,$0,L1
	lw	$2,gvar
L1:
	j	$31
	nop
	.comm	gvar,4
