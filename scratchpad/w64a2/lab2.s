	.file	1 "scratchpad/w64a2/equiv_lab2.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	probeF__Fi
	.align	2
	.globl	probeG__Fi
	.align	2
	.globl	probeH__Fi
	.align	2
	.globl	probeI__Fi

	.extern	h, 4

	.text
	.text
	.ent	probeF__Fi
probeF__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(g+12) # high
	lw	$2,%lo(g+12)($2)
	#nop
	addu	$4,$2,$4
	addu	$4,$4,$2
	addu	$4,$4,$2
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder

	.end	probeF__Fi
	.text
	.ent	probeG__Fi
probeG__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(g+12) # high
	lw	$3,%lo(g+12)($2)
	lw	$5,h
	addu	$2,$3,$4
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($5)
	.set	macro
	.set	reorder

	.end	probeG__Fi
	.text
	.ent	probeH__Fi
probeH__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(g+12) # high
	lw	$3,%lo(g+12)($2)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L4
	addu	$2,$3,$4
	.set	macro
	.set	reorder

	addu	$2,$2,$3
$L4:
	addu	$2,$2,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	probeH__Fi
	.text
	.ent	probeI__Fi
probeI__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(g+12) # high
	lw	$5,%lo(g+12)($2)
	lw	$2,h
	addu	$3,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L6
	sw	$4,0($2)
	.set	macro
	.set	reorder

	addu	$3,$3,$5
$L6:
	addu	$3,$3,$5
	addu	$3,$3,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$5
	.set	macro
	.set	reorder

	.end	probeI__Fi
