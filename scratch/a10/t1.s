	.text
	.align	2
	.globl	tfn
	.ent	tfn
tfn:
	.set	reorder
	addiu	$sp,$sp,-8
	beq	$4,$0,L1
	lw	$2,gvar
	addu	$2,$2,$5
L1:
	addiu	$sp,$sp,8
	j	$31
	.end	tfn
	.comm	gvar,4
