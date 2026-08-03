	.file	1 "c_funrollloops.i"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.align	2
	.globl	g
	.align	2
	.globl	h

	.comm	arr,400

	.comm	tbl,32

	.text
	.text
	.ent	helper
helper:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,2
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,1
	.set	macro
	.set	reorder

	.end	helper
	.text
	.ent	g
g:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,28($sp)
	move	$19,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$18,24($sp)
	move	$18,$16
	mult	$19,$5
	sw	$21,36($sp)
	addu	$21,$19,1
	sw	$22,40($sp)
	addu	$22,$5,2
	sw	$23,44($sp)
	subu	$23,$19,$5
	sw	$fp,48($sp)
	xor	$fp,$19,$5
	sw	$31,52($sp)
	sw	$20,32($sp)
	mflo	$20
	#nop
	.set	noreorder
	.set	nomacro
	blez	$19,$L4
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(arr) # high
	addiu	$17,$2,%lo(arr) # low
$L6:
	.set	noreorder
	.set	nomacro
	jal	helper
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,0($17)
	addu	$17,$17,4
	addu	$16,$16,1
	sll	$4,$3,1
	addu	$4,$4,$3
	addu	$4,$4,$2
	slt	$2,$16,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	addu	$18,$18,$4
	.set	macro
	.set	reorder

$L4:
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$5,$22
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	addu	$18,$18,$16
	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$fp
	.set	macro
	.set	reorder

	addu	$2,$18,$21
	addu	$2,$2,$22
	addu	$2,$2,$20
	addu	$2,$2,$23
	addu	$2,$2,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	g
	.text
	.ent	h
h:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$0
	.set	noreorder
	.set	nomacro
	blez	$5,$L10
	move	$7,$8
	.set	macro
	.set	reorder

	andi	$2,$5,0x0001
	beq	$2,$0,$L12
	lw	$7,0($4)
	li	$8,1			# 0x00000001
	slt	$6,$8,$5
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L10
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L12:
	lw	$2,0($4)
	lw	$3,4($4)
	addu	$4,$4,8
	addu	$8,$8,2
	slt	$6,$8,$5
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L12
	addu	$7,$7,$3
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	h
