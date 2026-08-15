	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\mathnfs.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Math_DistXZ__FP8coorddefT0
	.align	2
	.globl	Math_Dist3D__FP8coorddefT0
	.align	2
	.globl	Math_BetterDist__Fii
	.align	2
	.globl	Math_ResolveRotatedVector__FiiiPiT3
	.align	2
	.globl	Math_VectorLength__FP8coorddef
	.align	2
	.globl	Math_VectorLength2__FP8coorddef
	.align	2
	.globl	Math_NormalizeVector__FP8coorddef
	.align	2
	.globl	Math_NormalizeShortVector__FP8coorddef
	.align	2
	.globl	Math_QDNormalizeVector__FP8coorddef
	.align	2
	.globl	Math_fasttransmult__FP10matrixtdefN20

	.text
	.text
	.ent	Math_DistXZ__FP8coorddefT0
Math_DistXZ__FP8coorddefT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	lw	$2,0($5)
	lw	$7,8($4)
	lw	$4,8($5)
	subu	$6,$3,$2
	bgtz	$6,$L601
	subu	$6,$2,$3
$L601:
	subu	$3,$7,$4
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L605
	slt	$2,$3,$6
	.set	macro
	.set	reorder

	subu	$3,$4,$7
	slt	$2,$3,$6
$L605:
	beq	$2,$0,$L603
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$6,$2
	.set	macro
	.set	reorder

$L603:
	sra	$2,$6,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	Math_DistXZ__FP8coorddefT0
	.text
	.ent	Math_Dist3D__FP8coorddefT0
Math_Dist3D__FP8coorddefT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	lw	$2,0($5)
	#nop
	subu	$7,$3,$2
	bgtz	$7,$L607
	subu	$7,$2,$3
$L607:
	lw	$6,4($4)
	lw	$2,4($5)
	#nop
	subu	$3,$6,$2
	bgtz	$3,$L608
	subu	$3,$2,$6
$L608:
	lw	$4,8($4)
	lw	$5,8($5)
	#nop
	subu	$6,$4,$5
	.set	noreorder
	.set	nomacro
	bgtz	$6,$L614
	slt	$2,$3,$7
	.set	macro
	.set	reorder

	subu	$6,$5,$4
$L614:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L611
	addu	$3,$7,$2
	.set	macro
	.set	reorder

$L610:
	sra	$2,$7,2
	addu	$3,$3,$2
$L611:
	slt	$2,$6,$3
	beq	$2,$0,$L612
	sra	$2,$6,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L612:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$6,$2
	.set	macro
	.set	reorder

	.end	Math_Dist3D__FP8coorddefT0
	.text
	.ent	Math_BetterDist__Fii
Math_BetterDist__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L617
	move	$4,$5
	.set	macro
	.set	reorder

$L616:
	move	$6,$5
$L617:
	sra	$5,$6,2
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	sra	$2,$4,4
	.set	macro
	.set	reorder

	addu	$2,$6,$2
	sra	$3,$4,6
	addu	$2,$2,$3
	sra	$3,$4,7
	addu	$2,$2,$3
	sra	$3,$4,9
	addu	$2,$2,$3
	sra	$3,$4,14
	addu	$2,$2,$3
	sra	$3,$4,15
$L622:
	addu	$2,$2,$3
	sra	$3,$4,16
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L618:
	sra	$3,$6,1
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	sra	$2,$4,3
	.set	macro
	.set	reorder

	addu	$2,$6,$2
	sra	$3,$4,5
	addu	$2,$2,$3
	sra	$3,$4,6
	addu	$2,$2,$3
	sra	$3,$4,7
	addu	$2,$2,$3
	sra	$3,$4,8
	addu	$2,$2,$3
	sra	$3,$4,9
	addu	$2,$2,$3
	sra	$3,$4,12
	addu	$2,$2,$3
	sra	$3,$4,13
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L622
	sra	$3,$4,14
	.set	macro
	.set	reorder

$L619:
	addu	$2,$3,$5
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	sra	$3,$4,5
	.set	macro
	.set	reorder

	sra	$2,$4,2
	addu	$2,$6,$2
	sra	$3,$4,4
	addu	$2,$2,$3
	sra	$3,$4,5
	addu	$2,$2,$3
	sra	$3,$4,6
	addu	$2,$2,$3
	sra	$3,$4,7
	addu	$2,$2,$3
	sra	$3,$4,8
	addu	$2,$2,$3
	sra	$3,$4,9
	addu	$2,$2,$3
	sra	$3,$4,11
	addu	$2,$2,$3
	sra	$3,$4,12
	addu	$2,$2,$3
	sra	$3,$4,13
	addu	$2,$2,$3
	sra	$3,$4,14
	addu	$2,$2,$3
	sra	$3,$4,15
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L620:
	sra	$2,$4,2
	addu	$2,$6,$2
	addu	$2,$2,$3
	sra	$3,$4,8
	addu	$2,$2,$3
	sra	$3,$4,10
	addu	$2,$2,$3
	sra	$3,$4,11
	addu	$2,$2,$3
	sra	$3,$4,12
	addu	$2,$2,$3
	sra	$3,$4,13
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	Math_BetterDist__Fii
	.text
	.ent	Math_ResolveRotatedVector__FiiiPiT3
Math_ResolveRotatedVector__FiiiPiT3:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$21,36($sp)
	move	$21,$7
	sw	$31,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L624
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L624:
	sra	$16,$6,8
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	move	$17,$2
	.set	macro
	.set	reorder

	move	$18,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$19
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,0($21)
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$2
	lw	$2,64($sp)
	#nop
	sw	$16,0($2)
	lw	$31,40($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Math_ResolveRotatedVector__FiiiPiT3
	.text
	.ent	Math_VectorLength__FP8coorddef
Math_VectorLength__FP8coorddef:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$0
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$18,0($4)
	lw	$17,4($4)
	lw	$16,8($4)
	.set	noreorder
	bgez	$18,1f
	move	$2,$18
	subu	$2,$0,$2
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	j	$L638
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L628:
	sra	$18,$18,1
	sra	$17,$17,1
	sra	$16,$16,1
	addu	$19,$19,1
	.set	noreorder
	bgez	$18,1f
	move	$2,$18
	subu	$2,$0,$2
1:
	.set	reorder
	li	$3,16777216			# 0x01000000
$L638:
	slt	$2,$3,$2
	bne	$2,$0,$L628
	.set	noreorder
	bgez	$17,1f
	move	$2,$17
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	bne	$2,$0,$L628
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$21,2
	srl	$4,$20,2
	srl	$5,$6,2
	addu	$3,$2,$4
	addu	$3,$3,$5
	li	$2,1073741824			# 0x40000000
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	addu	$4,$21,$20
	.set	macro
	.set	reorder

	li	$22,1073741824			# 0x40000000
$L632:
	sra	$18,$18,1
	sra	$17,$17,1
	sra	$16,$16,1
	addu	$19,$19,1
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$21,2
	srl	$4,$20,2
	srl	$5,$6,2
	addu	$2,$2,$4
	addu	$2,$2,$5
	sltu	$2,$22,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	addu	$4,$21,$20
	.set	macro
	.set	reorder

$L639:
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$6
	.set	macro
	.set	reorder

	beq	$19,$0,$L635
$L636:
	addu	$19,$19,-1
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L636
	sll	$2,$2,1
	.set	macro
	.set	reorder

$L635:
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Math_VectorLength__FP8coorddef
	.text
	.ent	Math_VectorLength2__FP8coorddef
Math_VectorLength2__FP8coorddef:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$0
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$18,0($4)
	lw	$17,4($4)
	lw	$16,8($4)
	.set	noreorder
	bgez	$18,1f
	move	$2,$18
	subu	$2,$0,$2
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	j	$L653
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L643:
	sra	$18,$18,1
	sra	$17,$17,1
	sra	$16,$16,1
	addu	$19,$19,1
	.set	noreorder
	bgez	$18,1f
	move	$2,$18
	subu	$2,$0,$2
1:
	.set	reorder
	li	$3,16777216			# 0x01000000
$L653:
	slt	$2,$3,$2
	bne	$2,$0,$L643
	.set	noreorder
	bgez	$17,1f
	move	$2,$17
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	bne	$2,$0,$L643
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$21,2
	srl	$4,$20,2
	srl	$5,$6,2
	addu	$3,$2,$4
	addu	$3,$3,$5
	li	$2,1073741824			# 0x40000000
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	addu	$2,$21,$20
	.set	macro
	.set	reorder

	li	$22,1073741824			# 0x40000000
$L647:
	sra	$18,$18,1
	sra	$17,$17,1
	sra	$16,$16,1
	addu	$19,$19,1
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$21,2
	srl	$4,$20,2
	srl	$5,$6,2
	addu	$2,$2,$4
	addu	$2,$2,$5
	sltu	$2,$22,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	addu	$2,$21,$20
	.set	macro
	.set	reorder

$L654:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L650
	addu	$2,$2,$6
	.set	macro
	.set	reorder

$L651:
	addu	$19,$19,-1
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L651
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L650:
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Math_VectorLength2__FP8coorddef
	.text
	.ent	Math_NormalizeVector__FP8coorddef
Math_NormalizeVector__FP8coorddef:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,0($21)
	lw	$17,4($21)
	lw	$18,8($21)
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	j	$L665
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L658:
	sra	$16,$16,1
	sra	$17,$17,1
	sra	$18,$18,1
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	li	$3,16777216			# 0x01000000
$L665:
	slt	$2,$3,$2
	bne	$2,$0,$L658
	.set	noreorder
	bgez	$17,1f
	move	$2,$17
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	bne	$2,$0,$L658
	.set	noreorder
	bgez	$18,1f
	move	$2,$18
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$20,2
	srl	$4,$19,2
	srl	$5,$6,2
	addu	$3,$2,$4
	addu	$3,$3,$5
	li	$2,1073741824			# 0x40000000
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	li	$22,1073741824			# 0x40000000
	.set	macro
	.set	reorder

$L662:
	sra	$16,$16,1
	sra	$17,$17,1
	sra	$18,$18,1
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$20,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$6,$2
	srl	$2,$20,2
	srl	$4,$19,2
	srl	$5,$6,2
	addu	$2,$2,$4
	addu	$2,$2,$5
	sltu	$2,$22,$2
	bne	$2,$0,$L662
$L661:
	addu	$4,$20,$19
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$6
	.set	macro
	.set	reorder

	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L664
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sw	$2,0($21)
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sw	$2,4($21)
	.set	macro
	.set	reorder

	sw	$2,8($21)
$L664:
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Math_NormalizeVector__FP8coorddef
	.text
	.ent	Math_NormalizeShortVector__FP8coorddef
Math_NormalizeShortVector__FP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$4,4($18)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$4,8($18)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$2
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,4($18)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,0($18)
	.set	macro
	.set	reorder

	lw	$4,8($18)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,4($18)
	.set	macro
	.set	reorder

	sw	$2,8($18)
$L666:
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

	.end	Math_NormalizeShortVector__FP8coorddef
	.text
	.ent	Math_QDNormalizeVector__FP8coorddef
Math_QDNormalizeVector__FP8coorddef:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,36($sp)
	lw	$6,0($16)
	lw	$7,4($16)
	lw	$8,8($16)
	sw	$6,16($sp)
	sw	$7,20($sp)
	sw	$8,24($sp)
	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L669
	subu	$2,$0,$2
	.set	macro
	.set	reorder

	sw	$2,16($sp)
$L669:
	lw	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L670
	subu	$2,$0,$2
	.set	macro
	.set	reorder

	sw	$2,20($sp)
$L670:
	lw	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L671
	subu	$2,$0,$2
	.set	macro
	.set	reorder

	sw	$2,24($sp)
$L671:
	lw	$4,16($sp)
	lw	$5,20($sp)
	jal	Math_BetterDist__Fii
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_BetterDist__Fii
	move	$4,$2
	.set	macro
	.set	reorder

	beq	$2,$0,$L672
	.set	noreorder
	.set	nomacro
	jal	rinverse
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L673
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L673:
	move	$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$4,$L674
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$4,255
$L674:
	sra	$3,$2,8
	mult	$5,$3
	lw	$2,4($16)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L675
	sw	$6,0($16)
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L675:
	sra	$2,$2,8
	mult	$2,$3
	lw	$2,8($16)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L677
	sw	$6,4($16)
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L677:
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	sw	$6,8($16)
$L672:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Math_QDNormalizeVector__FP8coorddef
	.text
	.ent	Math_fasttransmult__FP10matrixtdefN20
Math_fasttransmult__FP10matrixtdefN20:
	.frame	$sp,56,$31		# vars= 40, regs= 4/0, args= 0, extra= 0
	.mask	0x000f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,48($sp)
	move	$18,$4
	sw	$17,44($sp)
	move	$17,$6
	move	$14,$0
	li	$25,8			# 0x00000008
	li	$24,4			# 0x00000004
	move	$15,$18
	sw	$19,52($sp)
	sw	$16,40($sp)
$L683:
	move	$9,$0
	addu	$16,$18,$24
	addu	$6,$18,$25
	li	$12,24			# 0x00000018
	li	$11,12			# 0x0000000c
	move	$10,$5
$L687:
	lw	$4,0($15)
	lw	$2,0($10)
	sra	$3,$4,3
	sra	$2,$2,3
	mult	$3,$2
	lw	$8,0($16)
	addu	$2,$5,$11
	lw	$7,0($2)
	mflo	$13
	#nop
	sra	$3,$8,3
	sra	$2,$7,3
	mult	$3,$2
	addu	$2,$5,$12
	lw	$3,0($6)
	lw	$2,0($2)
	mflo	$7
	#nop
	sra	$3,$3,3
	sra	$2,$2,3
	mult	$3,$2
	addu	$10,$10,4
	addu	$11,$11,4
	addu	$4,$14,$9
	addu	$9,$9,1
	sll	$4,$4,2
	sra	$3,$13,10
	sra	$2,$7,10
	addu	$3,$3,$2
	mflo	$8
	#nop
	#nop
	sra	$2,$8,10
	addu	$3,$3,$2
	addu	$2,$sp,$4
	sw	$3,0($2)
	slt	$2,$9,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	addu	$12,$12,4
	.set	macro
	.set	reorder

	addu	$25,$25,12
	addu	$24,$24,12
	addu	$14,$14,3
	slt	$2,$14,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L683
	addu	$15,$15,12
	.set	macro
	.set	reorder

	lw	$4,0($sp)
	lw	$2,4($sp)
	lw	$8,8($sp)
	lw	$7,12($sp)
	lw	$3,16($sp)
	sw	$4,0($17)
	sw	$2,4($17)
	sw	$8,8($17)
	sw	$7,12($17)
	sw	$3,16($17)
	lw	$4,20($sp)
	lw	$2,24($sp)
	lw	$8,28($sp)
	lw	$7,32($sp)
	sw	$4,20($17)
	sw	$2,24($17)
	sw	$8,28($17)
	sw	$7,32($17)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Math_fasttransmult__FP10matrixtdefN20
