	.text
	.align	2
	.globl	tfn
tfn:
	.set	reorder
	addu	$3,$4,$5
	beq	$4,$0,L1
	addu	$2,$2,$3
L1:
	j	$31
