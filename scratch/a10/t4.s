	.text
	.align	2
	.globl	tfn
tfn:
	.set	reorder
	addu	$3,$4,$5
	jal	callee
	addu	$2,$2,$3
	j	$31
