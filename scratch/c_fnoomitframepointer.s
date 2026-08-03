	.file	1 "c_fnoomitframepointer.i"
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
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sll	$2,$4,2
	addu	$2,$2,$4
	addu	$2,$2,1
	lw	$fp,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	helper
	.text
	.ent	g
g:
	.frame	$fp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$fp,56($sp)
	move	$fp,$sp
	sw	$19,36($sp)
	move	$19,$4
	sw	$16,24($sp)
	move	$16,$0
	sw	$18,32($sp)
	move	$18,$16
	mult	$19,$5
	sw	$21,44($sp)
	addu	$21,$19,1
	sw	$22,48($sp)
	addu	$22,$5,2
	sw	$23,52($sp)
	subu	$23,$19,$5
	xor	$6,$19,$5
	sw	$31,60($sp)
	sw	$20,40($sp)
	sw	$17,28($sp)
	mflo	$20
	#nop
	.set	noreorder
	.set	nomacro
	blez	$19,$L4
	sw	$6,16($fp)
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

	move	$5,$18
	lw	$4,16($fp)
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

	lw	$4,16($fp)
	jal	snk
	addu	$2,$18,$21
	addu	$2,$2,$22
	addu	$2,$2,$20
	lw	$6,16($fp)
	addu	$2,$2,$23
	addu	$2,$2,$6
	move	$sp,$fp
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	g
	.text
	.ent	h
h:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	move	$3,$0
	.set	noreorder
	.set	nomacro
	blez	$5,$L10
	move	$6,$3
	.set	macro
	.set	reorder

$L12:
	lw	$2,0($4)
	addu	$3,$3,1
	addu	$6,$6,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L10:
	move	$2,$6
	move	$sp,$fp
	lw	$fp,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	h
