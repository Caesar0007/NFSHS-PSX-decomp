	.file	1 "scratchpad/w64a2/equiv_lab.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	probeA__Fii
	.align	2
	.globl	probeB__Fii
	.align	2
	.globl	probeC__Fii
	.align	2
	.globl	probeD__Fii
	.align	2
	.globl	probeE__Fi

	.text
	.text
	.ent	probeA__Fii
probeA__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	li	$17,305397760			# 0x12340000
	lui	$2,%hi(g) # high
	sw	$16,16($sp)
	lw	$16,%lo(g)($2)
	ori	$17,$17,0x5678
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L2:
	beq	$18,$0,$L3
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,2
$L3:
	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$16,$17
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeA__Fii
	.text
	.ent	probeB__Fii
probeB__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	lui	$2,%hi(g) # high
	sw	$16,16($sp)
	lw	$16,%lo(g)($2)
	addiu	$2,$2,%lo(g) # low
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$17,12($2)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L6
	move	$18,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L6:
	beq	$18,$0,$L7
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,2
$L7:
	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$16,$17
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeB__Fii
	.text
	.ent	probeC__Fii
probeC__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	li	$17,305397760			# 0x12340000
	lui	$2,%hi(g) # high
	sw	$16,16($sp)
	lw	$16,%lo(g)($2)
	ori	$17,$17,0x5678
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L10
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L10:
	beq	$18,$0,$L11
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,2
$L11:
	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$16,$17
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeC__Fii
	.text
	.ent	probeD__Fii
probeD__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(g) # high
	sw	$16,16($sp)
	lw	$16,%lo(g)($2)
	sw	$17,20($sp)
	move	$17,$5
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L14
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L14:
	beq	$17,$0,$L15
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,2
$L15:
	addu	$16,$16,5
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,5
	.set	noreorder
	.set	nomacro
	jal	f__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$16,5
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeD__Fii
	.text
	.ent	probeE__Fi
probeE__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$5,%hi(g) # high
	addiu	$2,$5,%lo(g) # low
	lw	$3,12($2)
	lw	$2,%lo(g)($5)
	#nop
	addu	$2,$3,$2
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	probeE__Fi
