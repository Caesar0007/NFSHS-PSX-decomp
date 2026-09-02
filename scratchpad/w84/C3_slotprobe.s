	.text
	.globl	c3probe
	.ent	c3probe
c3probe:
	subu	$sp,$sp,88
	la	$3,c3sym
	sw	$31,80($sp)
	lw	$2,0($3)
	bne	$2,$0,$L9
	li	$2,0x00000001
	lw	$5,12($3)
	sll	$2,$2,$5
	or	$3,$3,$2
	addu	$5,$sp,16
	sw	$3,c3sym
	jal	c3ext
	move	$4,$2
$L9:
	lw	$31,80($sp)
	addu	$sp,$sp,88
	j	$31
	.end	c3probe
	.comm	c3sym,4
