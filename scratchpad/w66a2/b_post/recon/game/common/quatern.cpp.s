	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\quatern.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Quatern_VecInterpolate__FP8coorddefT0iT0
	.align	2
	.globl	Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
	.align	2
	.globl	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	.align	2
	.globl	Quatern_MatToQuat__FP10matrixtdefP5tQuat

	.text
	.text
	.ent	Quatern_VecInterpolate__FP8coorddefT0iT0
Quatern_VecInterpolate__FP8coorddefT0iT0:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$19,28($sp)
	move	$19,$7
	sw	$31,32($sp)
	lw	$2,0($17)
	lw	$4,0($16)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($19)
	lw	$2,4($17)
	lw	$4,4($16)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,4($16)
	#nop
	addu	$3,$3,$2
	sw	$3,4($19)
	lw	$2,8($17)
	lw	$4,8($16)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,8($16)
	#nop
	addu	$3,$3,$2
	sw	$3,8($19)
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Quatern_VecInterpolate__FP8coorddefT0iT0
	.text
	.ent	Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$22,40($sp)
	move	$22,$7
	sw	$31,44($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	lh	$2,0($18)
	lh	$4,0($16)
	lw	$17,64($sp)
	lw	$19,68($sp)
	lw	$20,72($sp)
	subu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lhu	$3,0($16)
	#nop
	addu	$3,$3,$2
	sh	$3,0($19)
	lh	$2,2($18)
	lh	$4,2($16)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lhu	$3,2($16)
	#nop
	addu	$3,$3,$2
	sh	$3,2($19)
	lh	$2,4($18)
	lh	$4,4($16)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lhu	$3,4($16)
	#nop
	addu	$3,$3,$2
	sh	$3,4($19)
	lh	$2,6($18)
	lh	$4,6($16)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$22
	move	$6,$17
	lhu	$3,6($16)
	move	$7,$20
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	Quatern_VecInterpolate__FP8coorddefT0iT0
	sh	$3,6($19)
	.set	macro
	.set	reorder

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

	.end	Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
	.text
	.ent	Quatern_QuatToMat__FP5tQuatP10matrixtdef
Quatern_QuatToMat__FP5tQuatP10matrixtdef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$6,0($4)
	lh	$10,6($4)
	sll	$2,$6,1
	mult	$10,$2
	lh	$7,2($4)
	mflo	$13
	#nop
	sll	$11,$7,1
	mult	$10,$11
	lh	$3,4($4)
	mflo	$12
	#nop
	sll	$9,$3,1
	mult	$10,$9
	mflo	$10
	#nop
	#nop
	mult	$6,$2
	mflo	$15
	#nop
	#nop
	mult	$6,$11
	mflo	$8
	#nop
	#nop
	mult	$7,$11
	mflo	$11
	#nop
	#nop
	mult	$3,$9
	mflo	$3
	#nop
	#nop
	mult	$6,$9
	li	$4,268435456			# 0x10000000
	subu	$2,$4,$11
	subu	$4,$4,$15
	subu	$2,$2,$3
	sra	$2,$2,12
	sw	$2,0($5)
	addu	$2,$8,$10
	sra	$2,$2,12
	subu	$8,$8,$10
	sra	$8,$8,12
	subu	$3,$4,$3
	mflo	$6
	#nop
	sra	$3,$3,12
	subu	$4,$4,$11
	mult	$7,$9
	sra	$4,$4,12
	sw	$2,4($5)
	sw	$8,12($5)
	sw	$3,16($5)
	sw	$4,32($5)
	subu	$2,$6,$12
	sra	$2,$2,12
	addu	$6,$6,$12
	sra	$6,$6,12
	sw	$2,8($5)
	sw	$6,24($5)
	mflo	$7
	#nop
	#nop
	addu	$2,$7,$13
	sra	$2,$2,12
	subu	$7,$7,$13
	sra	$7,$7,12
	sw	$2,20($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$7,28($5)
	.set	macro
	.set	reorder

	.end	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	.text
	.ent	Quatern_MatToQuat__FP10matrixtdefP5tQuat
Quatern_MatToQuat__FP10matrixtdefP5tQuat:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$4,0($17)
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L604
	move	$18,$5
	.set	macro
	.set	reorder

	lw	$2,4($17)
	#nop
	bne	$2,$0,$L604
	lw	$2,8($17)
	#nop
	bne	$2,$0,$L604
	lw	$2,12($17)
	#nop
	bne	$2,$0,$L604
	lw	$3,16($17)
	#nop
	bne	$3,$4,$L604
	lw	$2,20($17)
	#nop
	bne	$2,$0,$L604
	lw	$2,24($17)
	#nop
	bne	$2,$0,$L604
	lw	$2,28($17)
	#nop
	bne	$2,$0,$L604
	lw	$2,32($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L604
	li	$2,16384			# 0x00004000
	.set	macro
	.set	reorder

	sh	$2,6($18)
	sh	$0,0($18)
	sh	$0,2($18)
	.set	noreorder
	.set	nomacro
	j	$L603
	sh	$0,4($18)
	.set	macro
	.set	reorder

$L604:
	lw	$5,0($17)
	lw	$4,16($17)
	lw	$6,32($17)
	addu	$2,$5,$4
	addu	$2,$2,$6
	blez	$2,$L605
	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	move	$16,$2
	li	$4,32768			# 0x00008000
	move	$5,$16
	srl	$2,$5,31
	addu	$2,$5,$2
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sh	$2,6($18)
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$2,28($17)
	lw	$4,20($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,0($18)
	lw	$2,8($17)
	lw	$4,24($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,2($18)
	lw	$2,12($17)
	lw	$4,4($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	j	$L620
	subu	$4,$2,$4
	.set	macro
	.set	reorder

$L605:
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	move	$3,$0
	.set	macro
	.set	reorder

	slt	$2,$4,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
$L606:
	lw	$6,32($17)
	lw	$5,0($17)
	#nop
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
$L621:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L612
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L610
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	j	$L603
$L618:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L614
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	j	$L603
$L610:
	lw	$4,16($17)
	#nop
	addu	$4,$4,$6
	subu	$4,$5,$4
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	move	$16,$2
	srl	$2,$16,31
	addu	$2,$16,$2
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L611
	sh	$2,0($18)
	.set	macro
	.set	reorder

	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$2
$L611:
	lw	$2,28($17)
	lw	$4,20($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,6($18)
	lw	$2,12($17)
	lw	$4,4($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,2($18)
	lw	$2,8($17)
	lw	$4,24($17)
	move	$5,$16
	addu	$4,$2,$4
$L620:
	jal	fixedmult
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L603
	sh	$2,4($18)
	.set	macro
	.set	reorder

$L612:
	lw	$4,16($17)
	addu	$2,$6,$5
	subu	$4,$4,$2
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	move	$16,$2
	srl	$2,$16,31
	addu	$2,$16,$2
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L613
	sh	$2,2($18)
	.set	macro
	.set	reorder

	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$2
$L613:
	lw	$2,8($17)
	lw	$4,24($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,6($18)
	lw	$2,28($17)
	lw	$4,20($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,4($18)
	lw	$2,12($17)
	lw	$4,4($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L603
	sh	$2,0($18)
	.set	macro
	.set	reorder

$L614:
	lw	$4,16($17)
	#nop
	addu	$4,$5,$4
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	move	$16,$2
	srl	$2,$16,31
	addu	$2,$16,$2
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L615
	sh	$2,4($18)
	.set	macro
	.set	reorder

	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$2
$L615:
	lw	$2,12($17)
	lw	$4,4($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,6($18)
	lw	$2,8($17)
	lw	$4,24($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,0($18)
	lw	$2,20($17)
	lw	$4,28($17)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sra	$2,$2,2
	sh	$2,2($18)
$L603:
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

	.end	Quatern_MatToQuat__FP10matrixtdefP5tQuat
