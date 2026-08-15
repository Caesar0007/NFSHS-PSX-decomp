	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\color.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	IsNumChar__Fc
	.align	2
	.globl	Risk_ReadNextValue__FPPc

	.text
	.text
	.ent	IsNumChar__Fc
IsNumChar__Fc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	addu	$4,$4,-48
	andi	$4,$4,0x00ff
	sltu	$4,$4,10
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L601
	andi	$4,$2,0x00ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L601:
	li	$2,45			# 0x0000002d
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L602
	xori	$2,$4,0x002b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L602:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	IsNumChar__Fc
	.text
	.ent	Risk_ReadNextValue__FPPc
Risk_ReadNextValue__FPPc:
	.frame	$sp,296,$31		# vars= 256, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$19,284($sp)
	move	$19,$4
	sw	$17,276($sp)
	move	$17,$0
	sw	$18,280($sp)
	li	$18,47			# 0x0000002f
	sw	$31,288($sp)
	sw	$16,272($sp)
	lw	$16,0($19)
$L605:
	lbu	$4,0($16)
	jal	IsNumChar__Fc
	andi	$2,$2,0x00ff
	bne	$2,$0,$L606
	lbu	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L605
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L605
	addu	$16,$16,1
	.set	macro
	.set	reorder

	li	$3,47			# 0x0000002f
$L609:
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L609
	addu	$16,$16,1
	.set	macro
	.set	reorder

	j	$L605
$L606:
	addu	$18,$sp,16
$L613:
	lbu	$4,0($16)
	jal	IsNumChar__Fc
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	addu	$2,$18,$17
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	addu	$16,$16,1
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	j	$L613
	sb	$3,0($2)
	.set	macro
	.set	reorder

$L614:
	addu	$4,$sp,16
	addu	$2,$4,$17
	.set	noreorder
	.set	nomacro
	jal	atoi
	sb	$0,0($2)
	.set	macro
	.set	reorder

	sw	$16,0($19)
	lw	$31,288($sp)
	lw	$19,284($sp)
	lw	$18,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	Risk_ReadNextValue__FPPc
