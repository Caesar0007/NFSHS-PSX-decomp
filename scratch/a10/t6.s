	.text
	.globl	tfn
tfn:
	.set	noreorder
	addu	$3,$4,$5
	beq	$4,$0,L1
	addu	$2,$2,$3
L1:
	lw	$7,0($4)
	addu	$8,$7,$7
	j	$31
	nop
