	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\AIWORLD.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIWorld_ZSplineDistance__FP8Car_tObjT0
	.align	2
	.globl	AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
	.align	2
	.globl	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	.align	2
	.globl	AIWorld_ApxSplineDistance__FP8Car_tObji
	.align	2
	.globl	AIWorld_ApxSplineDistance__FiP8Car_tObj
	.align	2
	.globl	AIWorld_ApxSplineDistance__Fii
	.align	2
	.globl	AIWorld_SplineDistance__FP8Car_tObjT0
	.align	2
	.globl	AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
	.align	2
	.globl	AIWorld_GameOdometer__FP8Car_tObj
	.align	2
	.globl	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	.align	2
	.globl	AIWorld_IsDriveableLane__Fii
	.align	2
	.globl	AIWorld_GetProfileMask__Fi
	.align	2
	.globl	AIWorld_IsDriveableLane_UsingMask__Fii
	.align	2
	.globl	AIWorld_CheckForBarrierBetweenLanes__Fiii
	.align	2
	.globl	AIWorld_LaneIndex__Fii
	.align	2
	.globl	AIWorld_CalculateLaneInfo__FP8Car_tObj
	.align	2
	.globl	AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
	.align	2
	.globl	AIWorld_CalcRoadBend__FP8Car_tObji
	.align	2
	.globl	AIWorld_CalcFutureLateralVel__FP8Car_tObji
	.align	2
	.globl	AIWorld_CalcSpeed__FP8Car_tObj
	.align	2
	.globl	AIWorld_CalcLateralVelocity__FP8Car_tObj
	.align	2
	.globl	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
	.globl	inverseLaneWidthTable
	.data
	.align	2
inverseLaneWidthTable:
	.space	320

	.extern	AITune_driveSide, 4
	.extern	BWorldSm_slices, 4
	.extern	gNumSlices, 4

	.text
	.text
	.ent	AIWorld_ZSplineDistance__FP8Car_tObjT0
AIWorld_ZSplineDistance__FP8Car_tObjT0:
	.frame	$sp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$31,52($sp)
	sw	$16,48($sp)
	lw	$2,160($4)
	lw	$3,160($5)
	#nop
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,164($4)
	lw	$3,164($5)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,168($4)
	lw	$3,168($5)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$6,348($4)
	lw	$7,352($4)
	lw	$8,356($4)
	sw	$6,32($sp)
	sw	$7,36($sp)
	sw	$8,40($sp)
	lw	$4,16($sp)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,24($sp)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	lw	$31,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AIWorld_ZSplineDistance__FP8Car_tObjT0
	.text
	.ent	AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef:
	.frame	$sp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$31,52($sp)
	sw	$16,48($sp)
	lw	$2,0($4)
	lw	$3,0($5)
	#nop
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,4($4)
	lw	$3,4($5)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,8($4)
	lw	$3,8($5)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$7,24($6)
	lw	$8,28($6)
	lw	$9,32($6)
	sw	$7,32($sp)
	sw	$8,36($sp)
	sw	$9,40($sp)
	lw	$4,16($sp)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,24($sp)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	lw	$31,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
	.text
	.ent	AIWorld_ApxSplineDistance__FP8Car_tObjT0
AIWorld_ApxSplineDistance__FP8Car_tObjT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$3,8($4)
	lh	$2,8($5)
	lw	$4,gNumSlices
	subu	$3,$3,$2
	srl	$2,$4,31
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L605
	sra	$5,$2,1
	.set	macro
	.set	reorder

	slt	$2,$5,$3
	beq	$2,$0,$L605
	.set	noreorder
	.set	nomacro
	j	$L606
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L605:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L608
	sll	$2,$3,1
	.set	macro
	.set	reorder

	subu	$2,$0,$5
	slt	$2,$3,$2
	beq	$2,$0,$L606
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L606:
	sll	$2,$3,1
$L608:
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,17
	.set	macro
	.set	reorder

	.end	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	.text
	.ent	AIWorld_ApxSplineDistance__FP8Car_tObji
AIWorld_ApxSplineDistance__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,8($4)
	lw	$4,gNumSlices
	subu	$3,$2,$5
	srl	$2,$4,31
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L612
	sra	$5,$2,1
	.set	macro
	.set	reorder

	slt	$2,$5,$3
	beq	$2,$0,$L612
	.set	noreorder
	.set	nomacro
	j	$L613
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L612:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L615
	sll	$2,$3,1
	.set	macro
	.set	reorder

	subu	$2,$0,$5
	slt	$2,$3,$2
	beq	$2,$0,$L613
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L613:
	sll	$2,$3,1
$L615:
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,17
	.set	macro
	.set	reorder

	.end	AIWorld_ApxSplineDistance__FP8Car_tObji
	.text
	.ent	AIWorld_ApxSplineDistance__FiP8Car_tObj
AIWorld_ApxSplineDistance__FiP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$2,$4
	move	$4,$5
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIWorld_ApxSplineDistance__FiP8Car_tObj
	.text
	.ent	AIWorld_ApxSplineDistance__Fii
AIWorld_ApxSplineDistance__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,gNumSlices
	subu	$4,$4,$5
	srl	$2,$3,31
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	blez	$4,$L621
	sra	$5,$2,1
	.set	macro
	.set	reorder

	slt	$2,$5,$4
	beq	$2,$0,$L621
	.set	noreorder
	.set	nomacro
	j	$L622
	subu	$4,$4,$3
	.set	macro
	.set	reorder

$L621:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L624
	sll	$2,$4,1
	.set	macro
	.set	reorder

	subu	$2,$0,$5
	slt	$2,$4,$2
	beq	$2,$0,$L622
	lw	$2,gNumSlices
	#nop
	addu	$4,$4,$2
$L622:
	sll	$2,$4,1
$L624:
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,17
	.set	macro
	.set	reorder

	.end	AIWorld_ApxSplineDistance__Fii
	.text
	.ent	AIWorld_SplineDistance__FP8Car_tObjT0
AIWorld_SplineDistance__FP8Car_tObjT0:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$17,$5
	.set	macro
	.set	reorder

	move	$4,$2
	li	$3,786432			# 0x000c0000
	addu	$3,$4,$3
	li	$2,1572864			# 0x00180000
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	move	$2,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ZSplineDistance__FP8Car_tObjT0
	move	$5,$17
	.set	macro
	.set	reorder

$L629:
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

	.end	AIWorld_SplineDistance__FP8Car_tObjT0
	.text
	.ent	AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
AIWorld_SplineDistance__FP8Car_tObjiP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$17,$6
	.set	macro
	.set	reorder

	move	$4,$2
	li	$3,786432			# 0x000c0000
	addu	$3,$4,$3
	li	$2,1572864			# 0x00180000
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$4,$16,160
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef
	addu	$6,$16,324
	.set	macro
	.set	reorder

$L632:
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

	.end	AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
	.text
	.ent	AIWorld_GameOdometer__FP8Car_tObj
AIWorld_GameOdometer__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$3,6($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,17
	.set	macro
	.set	reorder

	.end	AIWorld_GameOdometer__FP8Car_tObj
	.text
	.ent	AIWorld_IsDriveableLaneInSliceRange__Fiiii
AIWorld_IsDriveableLaneInSliceRange__Fiiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,7			# 0x00000007
	subu	$2,$2,$7
	li	$3,8			# 0x00000008
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L648
	slt	$2,$3,16
	.set	macro
	.set	reorder

	move	$3,$0
	slt	$2,$3,16
$L648:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	li	$2,15			# 0x0000000f
	.set	macro
	.set	reorder

	li	$3,15			# 0x0000000f
$L649:
	subu	$2,$2,$3
	li	$3,1			# 0x00000001
	sll	$3,$3,$2
	move	$10,$0
	move	$8,$10
	lw	$9,gNumSlices
	lw	$11,BWorldSm_slices
$L639:
	slt	$2,$10,$5
	beq	$2,$0,$L638
	.set	noreorder
	.set	nomacro
	bltz	$8,$L641
	addu	$7,$4,$8
	.set	macro
	.set	reorder

	slt	$2,$7,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L650
	sll	$2,$7,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	subu	$7,$7,$9
	.set	macro
	.set	reorder

$L641:
	.set	noreorder
	.set	nomacro
	bgez	$7,$L650
	sll	$2,$7,5
	.set	macro
	.set	reorder

	addu	$7,$7,$9
$L643:
	sll	$2,$7,5
$L650:
	addu	$2,$2,$11
	lh	$2,22($2)
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	addu	$8,$8,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L645:
	.set	noreorder
	.set	nomacro
	j	$L639
	addu	$10,$10,1
	.set	macro
	.set	reorder

$L638:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	.text
	.ent	AIWorld_IsDriveableLane__Fii
AIWorld_IsDriveableLane__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,7			# 0x00000007
	subu	$2,$2,$5
	li	$3,8			# 0x00000008
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L652
	move	$6,$4
	.set	macro
	.set	reorder

	move	$3,$0
$L652:
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	li	$4,15			# 0x0000000f
	.set	macro
	.set	reorder

	li	$3,15			# 0x0000000f
$L654:
	subu	$4,$4,$3
	li	$2,1			# 0x00000001
	lw	$5,BWorldSm_slices
	sll	$3,$6,5
	addu	$3,$3,$5
	lh	$3,22($3)
	sll	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	and	$2,$3,$2
	.set	macro
	.set	reorder

	.end	AIWorld_IsDriveableLane__Fii
	.text
	.ent	AIWorld_GetProfileMask__Fi
AIWorld_GetProfileMask__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,7			# 0x00000007
	subu	$2,$2,$4
	li	$3,8			# 0x00000008
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L658
	slt	$2,$3,16
	.set	macro
	.set	reorder

	move	$3,$0
	slt	$2,$3,16
$L658:
	bne	$2,$0,$L657
	li	$3,15			# 0x0000000f
$L657:
	li	$2,15			# 0x0000000f
	subu	$2,$2,$3
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$3,$2
	.set	macro
	.set	reorder

	.end	AIWorld_GetProfileMask__Fi
	.text
	.ent	AIWorld_IsDriveableLane_UsingMask__Fii
AIWorld_IsDriveableLane_UsingMask__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$2
	lh	$2,22($4)
	.set	noreorder
	.set	nomacro
	j	$31
	and	$2,$2,$5
	.set	macro
	.set	reorder

	.end	AIWorld_IsDriveableLane_UsingMask__Fii
	.text
	.ent	AIWorld_CheckForBarrierBetweenLanes__Fiii
AIWorld_CheckForBarrierBetweenLanes__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$2
	li	$2,14			# 0x0000000e
	subu	$5,$2,$5
	subu	$3,$2,$6
	slt	$2,$3,$5
	lh	$4,22($4)
	bne	$2,$0,$L661
	nor	$2,$0,$4
	sra	$2,$2,$5
	subu	$4,$3,$5
	addu	$4,$4,1
	li	$3,-1			# 0xffffffff
	sll	$3,$3,$4
	nor	$3,$0,$3
	.set	noreorder
	.set	nomacro
	j	$31
	and	$2,$2,$3
	.set	macro
	.set	reorder

$L661:
	nor	$2,$0,$4
	sra	$2,$2,$3
	subu	$4,$5,$3
	addu	$4,$4,1
	li	$3,-1			# 0xffffffff
	sll	$3,$3,$4
	nor	$3,$0,$3
	.set	noreorder
	.set	nomacro
	j	$31
	and	$2,$2,$3
	.set	macro
	.set	reorder

	.end	AIWorld_CheckForBarrierBetweenLanes__Fiii
	.text
	.ent	AIWorld_LaneIndex__Fii
AIWorld_LaneIndex__Fii:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$5
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L664
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	sll	$3,$4,5
	addu	$3,$3,$2
	lbu	$2,30($3)
	.set	noreorder
	.set	nomacro
	j	$L670
	li	$16,6			# 0x00000006
	.set	macro
	.set	reorder

$L664:
	lw	$2,BWorldSm_slices
	sll	$3,$4,5
	addu	$3,$3,$2
	lbu	$2,31($3)
	li	$16,7			# 0x00000007
$L670:
	sll	$2,$2,15
	move	$3,$2
	lui	$2,%hi(inverseLaneWidthTable) # high
	.set	noreorder
	.set	nomacro
	bgez	$3,$L666
	addiu	$5,$2,%lo(inverseLaneWidthTable) # low
	.set	macro
	.set	reorder

	addu	$3,$3,16383
$L666:
	sra	$2,$3,14
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	move	$3,$2
	bgez	$3,$L667
	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
$L667:
	sra	$2,$3,16
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L668
	move	$2,$16
	.set	macro
	.set	reorder

	move	$2,$0
$L668:
	move	$16,$2
	slt	$2,$16,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	li	$3,13			# 0x0000000d
	.set	macro
	.set	reorder

	move	$3,$16
$L669:
	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIWorld_LaneIndex__Fii
	.text
	.ent	AIWorld_CalculateLaneInfo__FP8Car_tObj
AIWorld_CalculateLaneInfo__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,1392($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	sw	$0,1356($17)
	.set	macro
	.set	reorder

	lh	$4,8($17)
	lw	$5,1396($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	li	$16,32768			# 0x00008000
	.set	macro
	.set	reorder

	lh	$4,8($17)
	lw	$5,1396($17)
	lw	$3,620($17)
	sw	$2,1732($17)
	subu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	lw	$5,1396($17)
	lw	$3,620($17)
	lh	$4,8($17)
	addu	$5,$5,$3
	subu	$5,$5,$16
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$5,$2
	sltu	$2,$5,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	sltu	$2,$16,14
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	slt	$2,$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	move	$4,$16
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
$L677:
	sll	$2,$6,$4
	lw	$3,1356($17)
	addu	$4,$4,1
	or	$3,$3,$2
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L677
	sw	$3,1356($17)
	.set	macro
	.set	reorder

$L671:
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

	.end	AIWorld_CalculateLaneInfo__FP8Car_tObj
	.text
	.ent	AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$3,$4
	sw	$31,20($sp)
	sw	$16,16($sp)
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L680
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$6,8($3)
	lw	$5,gNumSlices
	lw	$16,376($3)
	addu	$4,$6,1
 #APP
 #NO_APP
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L681
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	subu	$4,$6,$2
$L681:
	jal	Newton_CalculateSliceYaw__Fi
	subu	$4,$2,$16
	slt	$2,$4,513
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	slt	$2,$4,-512
	.set	macro
	.set	reorder

	addu	$4,$4,-1024
	slt	$2,$4,-512
$L684:
	beq	$2,$0,$L680
	addu	$4,$4,1024
$L680:
	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
	.text
	.ent	AIWorld_CalcRoadBend__FP8Car_tObji
AIWorld_CalcRoadBend__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$6,8($4)
	bltz	$5,$L686
	lw	$3,gNumSlices
	addu	$5,$6,$5
	slt	$2,$5,$3
	bne	$2,$0,$L688
	.set	noreorder
	.set	nomacro
	j	$L688
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L686:
	addu	$5,$6,$5
	bgez	$5,$L688
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L688:
	lw	$3,BWorldSm_slices
	sll	$2,$5,5
	addu	$7,$2,$3
	lb	$2,15($7)
	#nop
	sll	$4,$2,9
	.set	noreorder
	.set	nomacro
	bgez	$4,$L698
	sll	$2,$6,5
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L698:
	addu	$6,$2,$3
	lb	$2,18($6)
	#nop
	sll	$3,$2,9
	.set	noreorder
	.set	nomacro
	bgez	$3,$L693
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L693:
	lb	$2,17($7)
	#nop
	sll	$4,$2,9
	sra	$2,$3,8
	mult	$5,$2
	mflo	$5
	#nop
	bgez	$4,$L695
	addu	$4,$4,255
$L695:
	lb	$2,20($6)
	#nop
	sll	$2,$2,9
	.set	noreorder
	.set	nomacro
	bgez	$2,$L697
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L697:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$5,$8
	.set	macro
	.set	reorder

	.end	AIWorld_CalcRoadBend__FP8Car_tObji
	.text
	.ent	AIWorld_CalcFutureLateralVel__FP8Car_tObji
AIWorld_CalcFutureLateralVel__FP8Car_tObji:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$31,40($sp)
	sw	$16,32($sp)
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	li	$3,1245184			# 0x00130000
	.set	macro
	.set	reorder

	lw	$2,1380($17)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L700
	move	$5,$0
$L700:
	lh	$2,8($17)
	.set	noreorder
	.set	nomacro
	bltz	$5,$L702
	addu	$3,$2,$5
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	#nop
	slt	$2,$3,$4
	bne	$2,$0,$L704
	.set	noreorder
	.set	nomacro
	j	$L704
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L702:
	bgez	$3,$L704
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L704:
	lw	$2,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$2
	lb	$5,18($3)
	#nop
	sll	$5,$5,9
	sw	$5,16($sp)
	lb	$2,19($3)
	#nop
	sll	$2,$2,9
	sw	$2,20($sp)
	lb	$2,20($3)
	#nop
	sll	$2,$2,9
	sw	$2,24($sp)
	lw	$4,172($17)
	jal	fixedmult
	lw	$4,176($17)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($17)
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$2,$16,$2
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AIWorld_CalcFutureLateralVel__FP8Car_tObji
	.text
	.ent	AIWorld_CalcSpeed__FP8Car_tObj
AIWorld_CalcSpeed__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,172($4)
	lw	$3,180($4)
	bgez	$5,1f
	subu	$5,$0,$5
1:
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L707
	sra	$2,$5,2
	.set	macro
	.set	reorder

	sra	$2,$3,2
	addu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1384($4)
	.set	macro
	.set	reorder

$L707:
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1384($4)
	.set	macro
	.set	reorder

	.end	AIWorld_CalcSpeed__FP8Car_tObj
	.text
	.ent	AIWorld_CalcLateralVelocity__FP8Car_tObj
AIWorld_CalcLateralVelocity__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$4,172($17)
	lw	$5,324($17)
	jal	fixedmult
	lw	$4,176($17)
	lw	$5,328($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($17)
	lw	$5,332($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	addu	$2,$16,$2
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

	.end	AIWorld_CalcLateralVelocity__FP8Car_tObj
	.text
	.ent	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,1364($20)
	lw	$2,AITune_driveSide
	#nop
	mult	$3,$2
	move	$18,$5
	move	$21,$6
	li	$2,1			# 0x00000001
	mflo	$19
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L710
	move	$16,$0
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sw	$2,0($18)
	lh	$2,8($20)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,31($2)
	.set	noreorder
	.set	nomacro
	j	$L719
	sll	$17,$2,15
	.set	macro
	.set	reorder

$L710:
	li	$2,6			# 0x00000006
	sw	$2,0($18)
	lh	$2,8($20)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,30($2)
	#nop
	sll	$17,$2,15
$L719:
	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	mult	$17,$16
	.set	macro
	.set	reorder

$L715:
	lh	$4,8($20)
	lw	$5,0($18)
	jal	AIWorld_IsDriveableLane__Fii
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	mult	$17,$16
	.set	macro
	.set	reorder

	lw	$2,0($18)
	addu	$16,$16,1
	addu	$2,$2,$19
	sw	$2,0($18)
	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L715
	mult	$17,$16
	.set	macro
	.set	reorder

$L720:
	mflo	$7
	#nop
	srl	$2,$17,1
	addu	$2,$7,$2
	mult	$19,$2
	mflo	$7
	#nop
	#nop
	sw	$7,0($21)
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

	.end	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
