	.text
	.globl	tfn
tfn:
	.set	reorder
	lw	$2,sd4
	lw	$4,d4
	la	$5,sd4
	j	$31
	.sdata
sd4:	.word	7
	.data
d4:	.word	9
