	.file	1 "c_fnostrengthreduce.i"
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
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$18,24($sp)
	move	$18,$16
	mult	$17,$5
	sw	$20,32($sp)
	addu	$20,$17,1
	sw	$21,36($sp)
	addu	$21,$5,2
	sw	$22,40($sp)
	subu	$22,$17,$5
	sw	$23,44($sp)
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$19,28($sp)
	mflo	$19
	#nop
	.set	noreorder
	.set	nomacro
	blez	$17,$L4
	xor	$23,$17,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(arr) # high
	addiu	$fp,$2,%lo(arr) # low
$L6:
	.set	noreorder
	.set	nomacro
	jal	helper
	move	$4,$16
	.set	macro
	.set	reorder

	sll	$3,$16,2
	addu	$3,$3,$fp
	lw	$4,0($3)
	addu	$16,$16,1
	sll	$3,$4,1
	addu	$3,$3,$4
	addu	$3,$3,$2
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	addu	$18,$18,$3
	.set	macro
	.set	reorder

$L4:
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$5,$21
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$23
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
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	snk
	move	$4,$19
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
	move	$4,$23
	.set	macro
	.set	reorder

	addu	$2,$18,$20
	addu	$2,$2,$21
	addu	$2,$2,$19
	addu	$2,$2,$22
	addu	$2,$2,$23
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
	move	$3,$0
	.set	noreorder
	.set	nomacro
	blez	$5,$L10
	move	$6,$3
	.set	macro
	.set	reorder

	sll	$2,$3,2
$L14:
	addu	$2,$2,$4
	lw	$2,0($2)
	addu	$3,$3,1
	addu	$6,$6,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	h
