	.text
	.globl	tfn
tfn:
	.set	reorder
	.extern	ex4,4
	lw	$2,ex4
	lw	$3,loc4
	lw	$4,big64
	la	$5,ex4
	sw	$6,loc4
	j	$31
	.comm	loc4,4
	.comm	big64,64
