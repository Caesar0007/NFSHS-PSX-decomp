	.text
	.align	2
	.globl	T1
T1:
	subu	$sp,$sp,24
	move	$5,$4
	sw	$31,16($sp)
	li	$4,3
	jal	DMACallback
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
