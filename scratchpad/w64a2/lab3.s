	.file	1 "scratchpad/w64a2/equiv_lab3.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	probeJ__FP1Si
	.align	2
	.globl	probeK__FP1Si
	.align	2
	.globl	probeL__Fi
	.align	2
	.globl	probeM__Fi
	.align	2
	.globl	probeN__Fi
	.align	2
	.globl	probeO__Fi
	.align	2
	.globl	probeP__Fi
	.align	2
	.globl	probeQ__Fi

	.extern	h, 4

	.text
	.text
	.ent	probeJ__FP1Si
probeJ__FP1Si:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,12($4)
	lw	$2,0($4)
	addu	$5,$3,$5
	addu	$5,$5,$3
	addu	$5,$5,$3
	addu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$5,$2
	.set	macro
	.set	reorder

	.end	probeJ__FP1Si
	.text
	.ent	probeK__FP1Si
probeK__FP1Si:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,12($4)
	#nop
	addu	$2,$3,$5
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$5
	.set	macro
	.set	reorder

	.end	probeK__FP1Si
	.text
	.ent	probeL__Fi
probeL__Fi:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$5,7			# 0x00000007
	addu	$3,$sp,28
	addu	$2,$4,$5
$L7:
	sw	$2,0($3)
	addu	$3,$3,-4
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L7
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$3,12($sp)
	#nop
	addu	$2,$3,$4
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeL__Fi
	.text
	.ent	probeM__Fi
probeM__Fi:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$5,7			# 0x00000007
	addu	$3,$sp,28
	addu	$2,$4,$5
$L13:
	sw	$2,0($3)
	addu	$3,$3,-4
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L13
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	addu	$3,$4,3
	addu	$2,$3,$4
	addu	$2,$2,$3
	addu	$2,$2,$3
	lw	$4,12($sp)
	addu	$2,$2,$3
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeM__Fi
	.text
	.ent	probeN__Fi
probeN__Fi:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$5,$4
	li	$4,7			# 0x00000007
	addu	$3,$sp,28
	addu	$2,$5,$4
$L19:
	sw	$2,0($3)
	addu	$3,$3,-4
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L19
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$3,12($sp)
	lw	$4,h
	addu	$2,$3,$5
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	sw	$5,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeN__Fi
	.text
	.ent	probeO__Fi
probeO__Fi:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$5,7			# 0x00000007
	addu	$3,$sp,28
	addu	$2,$4,$5
$L25:
	sw	$2,0($3)
	addu	$3,$3,-4
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L25
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$3,12($sp)
	#nop
	addu	$2,$3,$4
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	probeO__Fi
	.text
	.ent	probeP__Fi
probeP__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	.set	noreorder
	.set	nomacro
	blez	$4,$L29
	move	$5,$6
	.set	macro
	.set	reorder

	li	$7,305397760			# 0x12340000
	ori	$7,$7,0x5678
	lui	$2,%hi(g) # high
	addiu	$3,$2,%lo(g) # low
$L31:
	lw	$2,0($3)
	addu	$6,$6,1
	and	$2,$2,$7
	addu	$5,$5,$2
	slt	$2,$6,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L29:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	probeP__Fi
	.text
	.ent	probeQ__Fi
probeQ__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	lw	$2,h
	#nop
	lw	$7,0($2)
	.set	noreorder
	.set	nomacro
	blez	$4,$L35
	move	$5,$6
	.set	macro
	.set	reorder

	lui	$2,%hi(g) # high
	addiu	$3,$2,%lo(g) # low
$L37:
	lw	$2,0($3)
	addu	$6,$6,1
	and	$2,$2,$7
	addu	$5,$5,$2
	slt	$2,$6,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L37
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L35:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	probeQ__Fi
