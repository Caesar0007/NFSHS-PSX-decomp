	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aiphysic.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIPhysic_StopCar__FP8Car_tObjii
	.align	2
	.globl	AIPhysic_RevEngine__FP8Car_tObj
	.align	2
	.globl	AIPhysic_HandleShifting__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CalculateGear__FP8Car_tObj
	.align	2
	.globl	AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
	.align	2
	.globl	AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
	.align	2
	.globl	AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
	.align	2
	.globl	AIPhysic_CalcAcceleration__FP8Car_tObji
	.align	2
	.globl	AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
	.align	2
	.globl	AIPhysic_CalcDeceleration__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CheckDesiredDirection__FP8Car_tObj
	.align	2
	.globl	AIPhysic_HandleSignalling__FP8Car_tObj
	.align	2
	.globl	AIPhysic_HandleWipeoutTimer__FP8Car_tObj
	.align	2
	.globl	AIPhysic_Main__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CheckForBadPosition__FP8Car_tObj
	.align	2
	.globl	AIPhysics_UseCoolPhysics__FP8Car_tObj
	.align	2
	.globl	AIPhysic_SimplePhysics__FP8Car_tObj
	.align	2
	.globl	AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
	.align	2
	.globl	AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CoolPhysics__FP8Car_tObj
	.align	2
	.globl	AIPhysic_HandleDirection__FP8Car_tObj
	.align	2
	.globl	AIPhysic_Preperation__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CalculateRoadPosition__FP8coorddefi
	.align	2
	.globl	AIPhysic_GetDesiredVector__FP8Car_tObj
	.align	2
	.globl	AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CheckIfOutOfControl__FP8Car_tObj
	.align	2
	.globl	AIPhysic_OutOfControlPhysics__FP8Car_tObj
	.align	2
	.globl	AIPhysic_GetRearEndDamageFactor__FP8Car_tObj

	.lcomm	copCollisionReactionTime.282,4

	.lcomm	copCollisionGripLoss.283,16

	.lcomm	copCollisionSlowDown.284,16
	.align	2
	.globl	AIPhysic_InControlPhysics__FP8Car_tObj
	.align	2
	.globl	AIPhysic_FinishUp__FP8Car_tObj
	.align	2
	.globl	AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
	.align	2
	.globl	AIPhysic_HitWallCheck__FP8Car_tObj
	.align	2
	.globl	AIPhysic_ProcessBarrierCollision__FP8Car_tObj
	.align	2
	.globl	AIPhysic_ProcessCollision__FP8Car_tObj
	.align	2
	.globl	AIPhysic_ChangeDirection__FP8Car_tObji
	.align	2
	.globl	AIPhysic_CheckForGripReduction__FP8Car_tObj
	.align	2
	.globl	AIPhysic_StartUp__Fv
	.align	2
	.globl	AIPhysic_CleanUp__Fv
	.align	2
	.globl	AIPhysic_Reset__Fv
	.align	2
	.globl	AIPhysic_ResetCar__FP8Car_tObj
	.align	2
	.globl	AIPhysic_InitCar__FP8Car_tObj
	.align	2
	.globl	AIPhysic_DeInitCar__FP8Car_tObj
	.globl	AIPhysic_iTime
	.sdata
	.align	2
AIPhysic_iTime:
	.space	4
	.globl	AIPhysic_time
	.align	2
AIPhysic_time:
	.space	4
	.globl	AIPhysic_elapsedTime
	.align	2
AIPhysic_elapsedTime:
	.space	4
	.globl	AIPhysicConfig
	.data
	.align	2
AIPhysicConfig:
	.space	108

	.extern	gNumSlices, 4
	.extern	AIDataRecord_TrackCurve, 4
	.extern	BWorldSm_slices, 4
	.extern	randtemp, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AIPhysic_StopCar__FP8Car_tObjii
AIPhysic_StopCar__FP8Car_tObjii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$5
	sw	$0,1020($4)
	sw	$0,1016($4)
	sw	$0,1012($4)
	sw	$0,1044($4)
	sw	$0,1040($4)
	sw	$0,1036($4)
	sw	$0,1080($4)
	sw	$0,1076($4)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L601
	sw	$0,1072($4)
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L601:
	lw	$2,172($4)
	sra	$8,$3,8
	mult	$8,$2
	mflo	$3
	#nop
	#nop
	bgez	$3,$L602
	addu	$3,$3,255
$L602:
	lw	$2,176($4)
	#nop
	mult	$8,$2
	sra	$2,$3,8
	mflo	$7
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L604
	sw	$2,172($4)
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L604:
	sra	$2,$7,8
	sw	$2,176($4)
	lw	$2,180($4)
	#nop
	mult	$8,$2
	mflo	$2
	#nop
	#nop
	bgez	$2,$L606
	addu	$2,$2,255
$L606:
	lw	$3,280($4)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$3,$L607
	sw	$2,180($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L607:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L608
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L608:
	sra	$2,$6,8
	mult	$3,$2
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$9,280($4)
	.set	macro
	.set	reorder

	.end	AIPhysic_StopCar__FP8Car_tObjii
	.text
	.ent	AIPhysic_RevEngine__FP8Car_tObj
AIPhysic_RevEngine__FP8Car_tObj:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,1412($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L610
	subu	$sp,$sp,8
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$5,$5,$2
$L610:
	lw	$3,596($4)
	#nop
	srl	$2,$3,31
	addu	$2,$3,$2
	sra	$2,$2,1
	sll	$2,$2,1
	subu	$3,$3,$2
	lw	$2,AIPhysic_elapsedTime
	addu	$3,$3,1
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	sll	$2,$3,3
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$3,$2,2
	lw	$2,1128($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sra	$2,$3,1
	subu	$3,$0,$2
	andi	$2,$3,0x0001
	beq	$2,$0,$L611
	addu	$3,$3,-1
$L611:
	lw	$2,1128($4)
	#nop
	addu	$2,$2,$3
	sw	$2,1128($4)
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	srl	$2,$5,31
	.set	macro
	.set	reorder

	addu	$2,$5,$2
	sra	$2,$2,1
	ori	$2,$2,0x0001
	sw	$2,1128($4)
$L613:
	lw	$2,1128($4)
	#nop
	slt	$2,$2,501
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	li	$2,500			# 0x000001f4
	.set	macro
	.set	reorder

	sw	$2,1128($4)
$L609:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	AIPhysic_RevEngine__FP8Car_tObj
	.text
	.ent	AIPhysic_HandleShifting__FP8Car_tObj
AIPhysic_HandleShifting__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$3,1408($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L616
	li	$16,3000			# 0x00000bb8
	.set	macro
	.set	reorder

	lw	$2,AIPhysic_elapsedTime
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L617
	sw	$2,1408($17)
	.set	macro
	.set	reorder

$L616:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalculateGear__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	move	$19,$2
	move	$5,$19
	lw	$16,1380($17)
	#nop
	bgez	$16,1f
	subu	$16,$0,$16
1:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
	move	$18,$0
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	slt	$2,$19,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	move	$4,$17
	.set	macro
	.set	reorder

	li	$18,262144000			# 0x0fa00000
$L630:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
	move	$5,$19
	.set	macro
	.set	reorder

	bgez	$16,$L619
	addu	$16,$16,255
$L619:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L620
	sra	$16,$16,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L620:
	sra	$2,$2,8
	mult	$16,$2
	mflo	$16
	#nop
	#nop
	bgez	$16,$L621
	addu	$16,$16,255
$L621:
	lw	$2,1412($17)
	#nop
	subu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bgez	$2,$L622
	sra	$16,$16,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L622:
	sra	$2,$2,8
	mult	$16,$2
	mflo	$6
	#nop
	#nop
	addu	$16,$18,$6
	.set	noreorder
	.set	nomacro
	bgez	$16,$L623
	move	$2,$16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$16,$2
$L623:
	sra	$16,$2,16
	sb	$19,1090($17)
$L617:
	lw	$3,1128($17)
	#nop
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	subu	$2,$16,$3
	.set	macro
	.set	reorder

	bgez	$2,$L625
	addu	$2,$2,7
$L625:
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$L629
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L624:
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	subu	$2,$3,$16
	.set	macro
	.set	reorder

	bgez	$2,$L628
	addu	$2,$2,7
$L628:
	sra	$2,$2,3
	subu	$2,$3,$2
$L629:
	sw	$2,1128($17)
$L615:
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

	.end	AIPhysic_HandleShifting__FP8Car_tObj
	.text
	.ent	AIPhysic_CalculateGear__FP8Car_tObj
AIPhysic_CalculateGear__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	li	$2,65536			# 0x00010000
	ori	$2,$2,0xffff
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,1380($18)
	lbu	$17,1090($18)
	.set	noreorder
	bgez	$3,1f
	move	$20,$3
	subu	$20,$0,$20
1:
	.set	reorder
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L633
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L632:
	lw	$3,1776($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L647
	move	$19,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L633
	move	$17,$0
	.set	macro
	.set	reorder

$L635:
	move	$19,$0
$L647:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
	move	$5,$17
	.set	macro
	.set	reorder

	slt	$16,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L639
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
	move	$5,$17
	.set	macro
	.set	reorder

	slt	$2,$20,$2
	beq	$2,$0,$L638
$L639:
	li	$19,1			# 0x00000001
$L638:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L648
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L641
	move	$4,$18
	.set	macro
	.set	reorder

	addu	$16,$17,1
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$2,1404($18)
	move	$17,$16
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$2,1408($18)
	.set	macro
	.set	reorder

$L641:
	lw	$2,1404($18)
	addu	$17,$17,-1
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$2,1408($18)
	.set	macro
	.set	reorder

$L633:
	move	$2,$17
$L648:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	AIPhysic_CalculateGear__FP8Car_tObj
	.text
	.ent	AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
$L651:
	slt	$2,$5,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	addu	$2,$5,-2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L650:
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$2,1460($2)
	j	$31
	.end	AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
	.text
	.ent	AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
$L654:
	slt	$2,$5,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	addu	$2,$5,-2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L654
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L653:
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$2,1432($2)
	j	$31
	.end	AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
	.text
	.ent	AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	slt	$2,$5,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	addu	$2,$5,-3
	.set	macro
	.set	reorder

	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$2,1432($2)
	j	$31
$L656:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
	.text
	.ent	AIPhysic_CalcAcceleration__FP8Car_tObji
AIPhysic_CalcAcceleration__FP8Car_tObji:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,1408($19)
	.set	noreorder
	bgez	$5,1f
	move	$18,$5
	subu	$18,$0,$18
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L685
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,648($19)
	#nop
	lw	$3,0($2)
	#nop
	slt	$2,$3,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	lui	$2,%hi(Cars_topSpeedCap) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_topSpeedCap) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$17,0($3)
	lw	$5,1916($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$17
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$5,1840($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L685
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$2,$16,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L662
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$2,$17,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	li	$2,-196608			# 0xfffd0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xc71d
	addu	$18,$17,$2
$L660:
	move	$5,$18
	.set	noreorder
	.set	nomacro
	bgez	$5,$L665
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$5,$5,$2
$L665:
	sra	$5,$5,16
	slt	$2,$5,112
	bne	$2,$0,$L666
	li	$5,111			# 0x0000006f
$L666:
	bgez	$5,$L667
	move	$5,$0
$L667:
	lw	$4,1712($19)
	jal	Get__23AIDataRecord_AccTable_ti
	move	$16,$2
	lw	$4,1852($19)
	li	$2,65536			# 0x00010000
	beq	$4,$2,$L668
	.set	noreorder
	.set	nomacro
	bgez	$16,$L669
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L669:
	move	$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$2,$L670
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L670:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$16
$L668:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L671
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$2,$16,255
$L671:
	lw	$3,1920($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L672
	sra	$4,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L672:
	sra	$3,$3,8
	mult	$4,$3
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	mflo	$16
	#nop
	blez	$2,$L673
	.set	noreorder
	.set	nomacro
	bgez	$16,$L674
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L674:
	sra	$3,$3,8
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$16,$2,1
$L673:
	lw	$2,608($19)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L686
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L676
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L676:
	lw	$2,1740($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L677
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L677:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$16
	#nop
	lui	$2,%hi(GameSetup_gData) # high
$L686:
	addiu	$5,$2,%lo(GameSetup_gData) # low
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L679
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L687
	move	$4,$19
	.set	macro
	.set	reorder

$L679:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L680
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L678
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L687
	move	$4,$19
	.set	macro
	.set	reorder

$L680:
	lw	$2,608($19)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L678
	.set	noreorder
	.set	nomacro
	bgez	$16,$L681
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$16,255
$L681:
	lui	$3,%hi(AITune_BTCPerpAccMults) # high
	lw	$2,8($5)
	addiu	$3,$3,%lo(AITune_BTCPerpAccMults) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L682
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L682:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$16
$L678:
	move	$4,$19
$L687:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$2
	li	$2,65536			# 0x00010000
	.set	noreorder
	beq	$5,$2,$L683
	move	$2,$16
	.set	reorder
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
	move	$2,$16
$L683:
$L662:
$L685:
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

	.end	AIPhysic_CalcAcceleration__FP8Car_tObji
	.text
	.ent	AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	addu	$4,$4,1268
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L691
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L690
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L690:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$16,$2,7
	move	$2,$16
$L691:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
	.text
	.ent	AIPhysic_CalcDeceleration__FP8Car_tObj
AIPhysic_CalcDeceleration__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1720($4)
	lw	$5,1840($4)
	lw	$3,128($2)
	li	$2,65536			# 0x00010000
	slt	$2,$2,$5
	beq	$2,$0,$L693
	.set	noreorder
	.set	nomacro
	bgez	$3,$L694
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L694:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L695
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L695:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$3
$L693:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	AIPhysic_CalcDeceleration__FP8Car_tObj
	.text
	.ent	AIPhysic_CheckDesiredDirection__FP8Car_tObj
AIPhysic_CheckDesiredDirection__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,524288			# 0x00080000
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	ori	$5,$5,0xe38e
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	#.set	volatile
	lw	$3,%lo(GameSetup_gData)($2)
	#.set	novolatile
 #APP
 #NO_APP
$L697:
	lw	$2,1384($4)
	#nop
	slt	$2,$2,$5
	beq	$2,$0,$L699
	lw	$2,1360($4)
	#nop
	sw	$2,1364($4)
$L699:
	j	$31
	.end	AIPhysic_CheckDesiredDirection__FP8Car_tObj
	.text
	.ent	AIPhysic_HandleSignalling__FP8Car_tObj
AIPhysic_HandleSignalling__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L706
	li	$2,-262144			# 0xfffc0000
	.set	macro
	.set	reorder

	lw	$5,1396($4)
	lw	$3,1368($4)
	addu	$2,$5,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L702
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	lhu	$2,2232($4)
	sh	$0,2234($4)
	ori	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2232($4)
	.set	macro
	.set	reorder

$L702:
	addu	$2,$5,$2
	slt	$2,$2,$3
	beq	$2,$0,$L704
	lhu	$2,2234($4)
	sh	$0,2232($4)
	ori	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2234($4)
	.set	macro
	.set	reorder

$L704:
	sh	$0,2232($4)
	sh	$0,2234($4)
$L706:
	j	$31
	.end	AIPhysic_HandleSignalling__FP8Car_tObj
	.text
	.ent	AIPhysic_HandleWipeoutTimer__FP8Car_tObj
AIPhysic_HandleWipeoutTimer__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	lw	$2,608($7)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	lw	$6,%lo(D_8011E0B0)($2)
	lw	$2,1860($7)
	#nop
	slt	$2,$2,$6
	beq	$2,$0,$L710
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$5,1264($7)
	#nop
	lw	$4,48($5)
	#nop
	addu	$4,$6,$4
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	lw	$3,52($5)
	andi	$2,$2,0xffff
	and	$2,$2,$3
	addu	$4,$4,$2
	sw	$4,1860($7)
$L710:
	j	$31
	.end	AIPhysic_HandleWipeoutTimer__FP8Car_tObj
	.text
	.ent	AIPhysic_Main__FP8Car_tObj
AIPhysic_Main__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	la	$2,AIPhysic_time
	sw	$2,16($sp)
	la	$2,AIPhysic_elapsedTime
	sw	$2,20($sp)
	la	$2,AIPhysic_iTime
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$2,24($sp)
	lw	$2,1884($16)
	li	$4,1			# 0x00000001
	sw	$2,28($sp)
	lw	$6,140($16)
	lw	$7,0($16)
	.set	noreorder
	.set	nomacro
	jal	Sched_ExecuteCheck__FiiiiPiN24i
	move	$5,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L711
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L713
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcSpeed__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

$L713:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CheckDesiredDirection__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CheckForGripReduction__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_HandleSignalling__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcLateralVelocity__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AIPhysics_UseCoolPhysics__FP8Car_tObj
	sw	$2,1796($16)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$17,$2
	andi	$5,$17,0x00ff
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
	sltu	$5,$0,$5
	.set	macro
	.set	reorder

	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0004
	bne	$2,$0,$L711
	lbu	$2,145($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(simGlobal)($2)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L716
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_RevEngine__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L711
$L716:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_HandleShifting__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lhu	$2,380($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L717
	li	$2,196608			# 0x00030000
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0400
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	li	$5,64225			# 0x0000fae1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L732
	move	$4,$16
	.set	macro
	.set	reorder

$L717:
	lw	$3,1384($16)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L719
	sw	$0,1056($16)
	sw	$0,1160($16)
	sw	$0,1156($16)
$L719:
	lhu	$2,380($16)
	#nop
	bne	$2,$0,$L720
	lw	$2,256($16)
	#nop
	slt	$2,$2,19660
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	move	$4,$16
	.set	macro
	.set	reorder

$L720:
	lw	$2,628($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L722
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L732
	li	$5,64880			# 0x0000fd70
	.set	macro
	.set	reorder

$L722:
	lw	$2,632($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	lw	$3,1384($16)
	ori	$2,$2,0x38e2
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L724
	li	$2,524288			# 0x00080000
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,58982			# 0x0000e666
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_StopCar__FP8Car_tObjii
	move	$6,$5
	.set	macro
	.set	reorder

	j	$L711
$L724:
	ori	$2,$2,0xe38d
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L723
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L732
	li	$5,62914			# 0x0000f5c2
	.set	macro
	.set	reorder

$L723:
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,912($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L726
	li	$3,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$2,1380($16)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L733
	move	$4,$16
	.set	macro
	.set	reorder

$L726:
	lw	$2,1372($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L728
	andi	$2,$17,0x00ff
	.set	macro
	.set	reorder

	move	$4,$16
$L733:
	li	$5,61603			# 0x0000f0a3
$L732:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_StopCar__FP8Car_tObjii
	li	$6,64225			# 0x0000fae1
	.set	macro
	.set	reorder

	j	$L711
$L728:
	beq	$2,$0,$L729
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CoolPhysics__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L730
$L729:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_SimplePhysics__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

$L730:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CheckForBadPosition__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_HandleWipeoutTimer__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

$L711:
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

	.end	AIPhysic_Main__FP8Car_tObj
	.text
	.ent	AIPhysic_CheckForBadPosition__FP8Car_tObj
AIPhysic_CheckForBadPosition__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$0
	sw	$31,16($sp)
	lw	$2,180($4)
	li	$3,7536640			# 0x00730000
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L736
	move	$8,$7
	.set	macro
	.set	reorder

	lw	$2,172($4)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L736
	lw	$2,192($4)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L735
	lbu	$2,144($4)
	#nop
	bne	$2,$0,$L735
$L736:
	li	$7,1			# 0x00000001
$L735:
	lh	$2,8($4)
	lw	$3,BWorldSm_slices
	lw	$6,1396($4)
	sll	$2,$2,5
	addu	$5,$2,$3
	lh	$3,24($5)
	li	$2,-2293760			# 0xffdd0000
	sll	$3,$3,8
	subu	$2,$2,$3
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	li	$3,2293760			# 0x00230000
	.set	macro
	.set	reorder

	lh	$2,26($5)
	#nop
	sll	$2,$2,8
	addu	$2,$2,$3
	slt	$2,$2,$6
	beq	$2,$0,$L737
$L738:
	li	$8,1			# 0x00000001
$L737:
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L742
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$8,$0,$L741
$L742:
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$0
	.set	macro
	.set	reorder

$L741:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_CheckForBadPosition__FP8Car_tObj
	.text
	.ent	AIPhysics_UseCoolPhysics__FP8Car_tObj
AIPhysics_UseCoolPhysics__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,608($4)
	#nop
	andi	$2,$3,0x0800
	bne	$2,$0,$L745
	lbu	$4,144($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L745
	andi	$2,$3,0x0020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	sltu	$2,$4,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L748
$L745:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L748:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	AIPhysics_UseCoolPhysics__FP8Car_tObj
	.text
	.ent	AIPhysic_SimplePhysics__FP8Car_tObj
AIPhysic_SimplePhysics__FP8Car_tObj:
	.frame	$sp,64,$31		# vars= 32, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,48($sp)
	move	$16,$4
	sw	$31,56($sp)
	sw	$17,52($sp)
	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	li	$3,-17			# 0xffffffef
	.set	macro
	.set	reorder

	lw	$2,1396($16)
	#nop
	sw	$2,1816($16)
	lw	$2,1392($16)
	#nop
	and	$2,$2,$3
	sw	$2,1392($16)
$L753:
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L754
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(simGlobal) # low
	lw	$3,4($17)
	lw	$2,1860($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L754
	lw	$4,AIDataRecord_TrackCurve
	lh	$5,8($16)
	jal	Get__25AIDataRecord_TrackCurve_ti
	slt	$2,$2,31
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L754
	li	$2,1441792			# 0x00160000
	.set	macro
	.set	reorder

	lw	$3,1384($16)
	ori	$2,$2,0x38e3
	slt	$2,$2,$3
	beq	$2,$0,$L754
	lw	$2,4($17)
	#nop
	addu	$2,$2,384
	sw	$2,1864($16)
$L754:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$7,264($16)
	lw	$8,268($16)
	lw	$9,272($16)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	lw	$7,324($16)
	lw	$8,328($16)
	lw	$9,332($16)
	sw	$7,32($sp)
	sw	$8,36($sp)
	sw	$9,40($sp)
	lw	$4,1428($16)
	lw	$5,32($sp)
	jal	fixedmult
	sw	$2,32($sp)
	lw	$4,1428($16)
	lw	$5,36($sp)
	jal	fixedmult
	sw	$2,36($sp)
	lw	$4,1428($16)
	lw	$5,40($sp)
	jal	fixedmult
	sw	$2,40($sp)
	lw	$2,1380($16)
	lw	$4,1364($16)
	#nop
	mult	$2,$4
	lw	$5,16($sp)
	mflo	$4
	#nop
	jal	fixedmult
	sw	$2,16($sp)
	lw	$2,1380($16)
	lw	$4,1364($16)
	#nop
	mult	$2,$4
	lw	$5,20($sp)
	mflo	$4
	#nop
	jal	fixedmult
	sw	$2,20($sp)
	lw	$2,1380($16)
	lw	$4,1364($16)
	#nop
	mult	$2,$4
	lw	$5,24($sp)
	mflo	$4
	#nop
	jal	fixedmult
	sw	$2,24($sp)
	lw	$2,16($sp)
	lw	$3,32($sp)
	lw	$5,1428($16)
	lw	$4,1364($16)
	addu	$2,$2,$3
	mult	$5,$4
	sw	$2,172($16)
	lw	$2,20($sp)
	lw	$3,36($sp)
	lw	$4,1384($16)
	addu	$2,$2,$3
	sw	$2,176($16)
	lw	$2,24($sp)
	lw	$3,40($sp)
	sw	$4,1056($16)
	addu	$2,$2,$3
	sw	$2,180($16)
	mflo	$5
	#nop
	#nop
	.set	noreorder
	bgez	$5,1f
	move	$4,$5
	subu	$4,$0,$4
1:
	.set	reorder
	move	$3,$4
	.set	noreorder
	.set	nomacro
	bgez	$4,$L756
	sw	$5,1048($16)
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L756:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L755
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L757
	sw	$2,1144($16)
	.set	macro
	.set	reorder

$L755:
	sw	$0,1144($16)
$L757:
	lw	$3,1384($16)
	li	$2,196608			# 0x00030000
	sw	$0,276($16)
	sw	$0,280($16)
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	sw	$0,284($16)
	.set	macro
	.set	reorder

	lw	$5,1364($16)
	move	$4,$16
	nor	$5,$0,$5
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	sltu	$5,$5,1
	.set	macro
	.set	reorder

$L758:
	li	$6,715784192			# 0x2aaa0000
	lw	$2,1380($16)
	ori	$6,$6,0xaaab
	.set	noreorder
	bgez	$2,1f
	move	$5,$2
	subu	$5,$0,$5
1:
	.set	reorder
	mult	$5,$6
	sra	$2,$5,31
	mfhi	$7
	#nop
	#nop
	sra	$3,$7,16
	subu	$4,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L759
	lui	$2,%hi(AIPhysicConfig+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(AIPhysicConfig+4)($2)
	#nop
	mult	$2,$6
	sra	$2,$2,31
	mfhi	$7
	#nop
	#nop
	subu	$3,$7,$2
	slt	$2,$4,$3
	beq	$2,$0,$L759
	bltz	$5,$L759
	move	$4,$3
$L759:
	li	$3,715784192			# 0x2aaa0000
	lui	$2,%hi(AIPhysicConfig+8) # high
	lw	$2,%lo(AIPhysicConfig+8)($2)
	ori	$3,$3,0xaaab
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$7
	#nop
	#nop
	subu	$3,$7,$2
	slt	$2,$3,$4
	beq	$2,$0,$L761
	move	$4,$3
$L761:
	lw	$2,1364($16)
	#nop
	mult	$4,$2
	mflo	$3
	#nop
	#nop
	bltz	$3,$L762
	lh	$2,8($16)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L765
	.set	noreorder
	.set	nomacro
	j	$L765
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L762:
	lh	$2,8($16)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L765
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L765:
	sw	$3,1880($16)
	lw	$31,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	AIPhysic_SimplePhysics__FP8Car_tObj
	.text
	.ent	AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
AIPhysic_SimplePhysics_LongVel__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$5,1380($16)
	jal	AIPhysic_CalcAcceleration__FP8Car_tObji
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalcDeceleration__FP8Car_tObj
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$3,632($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L768
	move	$5,$2
	.set	macro
	.set	reorder

	sw	$0,1372($16)
$L768:
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,1864($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L769
	lw	$2,1372($16)
	#nop
	bgez	$2,$L770
	addu	$2,$2,3
$L770:
	sra	$2,$2,2
	sw	$2,1372($16)
$L769:
	lw	$4,1364($16)
	li	$2,-1			# 0xffffffff
	bne	$4,$2,$L771
	lw	$2,1372($16)
	lw	$3,1380($16)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L773
	lw	$2,1360($16)
	#nop
	beq	$2,$4,$L772
$L773:
	lw	$2,AIPhysic_elapsedTime
	lbu	$3,1088($16)
	sll	$2,$2,2
	addu	$3,$3,$2
	slt	$2,$3,255
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L774
	sw	$5,1044($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L775
	sb	$3,1088($16)
	.set	macro
	.set	reorder

$L774:
	li	$2,255			# 0x000000ff
	sb	$2,1088($16)
$L775:
	lbu	$2,1088($16)
	#nop
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L776
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,1085($16)
$L776:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L777
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L777:
	lw	$2,AIPhysic_iTime
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L778
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L778:
	sra	$2,$2,8
	mult	$3,$2
	lw	$2,1380($16)
	lw	$4,1364($16)
	lw	$3,1360($16)
	mflo	$6
	#nop
	#nop
	addu	$5,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L767
	sw	$5,1380($16)
	.set	macro
	.set	reorder

	lw	$2,1372($16)
	#nop
	move	$3,$2
	slt	$2,$3,$5
	bne	$2,$0,$L807
	.set	noreorder
	.set	nomacro
	j	$L807
	move	$3,$5
	.set	macro
	.set	reorder

$L772:
	.set	noreorder
	.set	nomacro
	bgez	$17,$L783
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$4,$17,255
$L783:
	lw	$2,AIPhysic_iTime
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L784
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L784:
	sra	$2,$2,8
	mult	$4,$2
	lbu	$4,1088($16)
	lw	$2,AIPhysic_elapsedTime
	#nop
	slt	$2,$2,$4
	mflo	$6
	#nop
	#nop
	subu	$3,$3,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	sw	$3,1380($16)
	.set	macro
	.set	reorder

	lbu	$2,AIPhysic_elapsedTime
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L786
	sb	$2,1088($16)
	.set	macro
	.set	reorder

$L785:
	sb	$0,1088($16)
$L786:
	lbu	$2,1088($16)
	#nop
	bne	$2,$0,$L787
	sb	$0,1085($16)
$L787:
	lw	$2,1380($16)
	lw	$3,1372($16)
	sw	$17,1044($16)
	.set	noreorder
	.set	nomacro
	j	$L808
	slt	$2,$2,$3
	.set	macro
	.set	reorder

$L771:
	lw	$2,1372($16)
	lw	$3,1380($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L791
	lw	$2,1360($16)
	#nop
	beq	$4,$2,$L790
$L791:
	lw	$2,AIPhysic_elapsedTime
	lbu	$3,1088($16)
	sll	$2,$2,2
	addu	$3,$3,$2
	slt	$2,$3,255
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L792
	sw	$5,1044($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L793
	sb	$3,1088($16)
	.set	macro
	.set	reorder

$L792:
	li	$2,255			# 0x000000ff
	sb	$2,1088($16)
$L793:
	lbu	$2,1088($16)
	#nop
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L809
	move	$2,$5
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,1085($16)
	move	$2,$5
$L809:
	bgez	$2,$L795
	addu	$2,$2,255
$L795:
	lw	$3,AIPhysic_iTime
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L796
	sra	$4,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L796:
	sra	$2,$3,8
	mult	$4,$2
	lw	$2,1380($16)
	lw	$4,1364($16)
	lw	$3,1360($16)
	mflo	$6
	#nop
	#nop
	subu	$5,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L767
	sw	$5,1380($16)
	.set	macro
	.set	reorder

	lw	$3,1372($16)
	#nop
	slt	$2,$3,$5
	beq	$2,$0,$L807
	.set	noreorder
	.set	nomacro
	j	$L807
	move	$3,$5
	.set	macro
	.set	reorder

$L790:
	.set	noreorder
	.set	nomacro
	bgez	$17,$L800
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$4,$17,255
$L800:
	lw	$2,AIPhysic_iTime
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L801
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L801:
	sra	$2,$2,8
	mult	$4,$2
	lbu	$4,1088($16)
	lw	$2,AIPhysic_elapsedTime
	#nop
	slt	$2,$2,$4
	mflo	$6
	#nop
	#nop
	addu	$3,$3,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L802
	sw	$3,1380($16)
	.set	macro
	.set	reorder

	lbu	$2,AIPhysic_elapsedTime
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L803
	sb	$2,1088($16)
	.set	macro
	.set	reorder

$L802:
	sb	$0,1088($16)
$L803:
	lbu	$2,1088($16)
	#nop
	bne	$2,$0,$L804
	sb	$0,1085($16)
$L804:
	lw	$2,1380($16)
	lw	$3,1372($16)
	sw	$17,1044($16)
	slt	$2,$3,$2
$L808:
	beq	$2,$0,$L767
$L807:
	sw	$3,1380($16)
$L767:
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

	.end	AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
	.text
	.ent	AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
AIPhysic_SimplePhysics_LatVel__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$31,40($sp)
	sw	$16,32($sp)
	lw	$3,1384($17)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$3,1816($17)
	lw	$2,1396($17)
	#nop
	subu	$16,$3,$2
	lw	$3,1384($17)
$L819:
	li	$2,1638400			# 0x00190000
	slt	$2,$2,$3
	beq	$2,$0,$L813
	lw	$6,324($17)
	lw	$7,328($17)
	lw	$8,332($17)
	sw	$6,16($sp)
	sw	$7,20($sp)
	sw	$8,24($sp)
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	lw	$2,160($17)
	lw	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,160($17)
	lw	$2,164($17)
	lw	$3,20($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,164($17)
	lw	$2,168($17)
	lw	$3,24($sp)
	sw	$0,1428($17)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L818
	sw	$2,168($17)
	.set	macro
	.set	reorder

$L813:
	lw	$2,1380($17)
	#nop
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	subu	$4,$0,$3
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L815
	sw	$16,1428($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L818
	sw	$4,1428($17)
	.set	macro
	.set	reorder

$L815:
	slt	$2,$3,$16
	beq	$2,$0,$L818
	sw	$3,1428($17)
$L818:
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

	.end	AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
	.text
	.ent	AIPhysic_CoolPhysics__FP8Car_tObj
AIPhysic_CoolPhysics__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,1392($16)
	#nop
	ori	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_HandleDirection__FP8Car_tObj
	sw	$2,1392($16)
	.set	macro
	.set	reorder

	lw	$3,1364($16)
	lw	$2,1380($16)
	#nop
	mult	$3,$2
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L821
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,1776($16)
	#nop
	beq	$3,$2,$L821
	sw	$0,1816($16)
$L821:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_HitWallCheck__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L823
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ChangeDirection__FP8Car_tObji
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

$L823:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_Preperation__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CheckIfOutOfControl__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L824
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_OutOfControlPhysics__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L825
$L824:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_InControlPhysics__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

$L825:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_FinishUp__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_CoolPhysics__FP8Car_tObj
	.text
	.ent	AIPhysic_HandleDirection__FP8Car_tObj
AIPhysic_HandleDirection__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$4
	lw	$3,1776($5)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L840
	li	$2,-655360			# 0xfff60000
	.set	macro
	.set	reorder

	lw	$3,1816($5)
	lw	$4,1396($5)
	addu	$2,$3,$2
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L837
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$2,1796($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L838
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
$L837:
	addu	$2,$3,$2
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	lw	$2,1796($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L839
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(D_8011E0B0) # high
$L838:
	lw	$2,%lo(D_8011E0B0)($2)
	#nop
	addu	$2,$2,-24
	sw	$2,1780($5)
	lui	$2,%hi(simGlobal) # high
$L839:
	addiu	$6,$2,%lo(simGlobal) # low
	lw	$3,4($6)
	lw	$4,1780($5)
	lw	$2,1772($5)
	subu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L833
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,1776($5)
	lw	$2,4($6)
	#nop
	sw	$2,1780($5)
$L833:
	lw	$2,1372($5)
	li	$3,1310720			# 0x00140000
	slt	$2,$3,$2
	beq	$2,$0,$L834
	sw	$3,1372($5)
$L834:
	lw	$2,1372($5)
	#nop
	subu	$2,$0,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L835
	li	$2,-1310720			# 0xffec0000
	.set	macro
	.set	reorder

	sw	$2,1372($5)
$L835:
	sw	$0,1816($5)
$L840:
	j	$31
	.end	AIPhysic_HandleDirection__FP8Car_tObj
	.text
	.ent	AIPhysic_Preperation__FP8Car_tObj
AIPhysic_Preperation__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 16, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,40($sp)
	move	$18,$4
	sw	$31,44($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$4,172($18)
	lw	$5,240($18)
	jal	fixedmult
	lw	$4,176($18)
	lw	$5,244($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($18)
	lw	$5,248($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,172($18)
	lw	$5,252($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1048($18)
	.set	macro
	.set	reorder

	lw	$4,176($18)
	lw	$5,256($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($18)
	lw	$5,260($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,172($18)
	lw	$5,264($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1052($18)
	.set	macro
	.set	reorder

	lw	$4,176($18)
	lw	$5,268($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($18)
	lw	$5,272($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($18)
	lw	$5,240($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1056($18)
	.set	macro
	.set	reorder

	lw	$4,280($18)
	lw	$5,244($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($18)
	lw	$5,248($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($18)
	lw	$5,252($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1060($18)
	.set	macro
	.set	reorder

	lw	$4,280($18)
	lw	$5,256($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($18)
	lw	$5,260($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($18)
	lw	$5,264($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1064($18)
	.set	macro
	.set	reorder

	lw	$4,280($18)
	lw	$5,268($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($18)
	lw	$5,272($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$3,1048($18)
	addu	$16,$16,$2
	sw	$16,1068($18)
	.set	noreorder
	bgez	$3,1f
	move	$4,$3
	subu	$4,$0,$4
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$4,$L843
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L843:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L844
	sw	$2,1144($18)
	.set	macro
	.set	reorder

$L842:
	sw	$0,1144($18)
$L844:
	lw	$6,264($18)
	lw	$7,268($18)
	lw	$8,272($18)
	sw	$6,16($sp)
	sw	$7,20($sp)
	sw	$8,24($sp)
	lw	$3,1776($18)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L845
	lw	$4,16($sp)
	lw	$5,24($sp)
	j	$L851
$L845:
	lw	$4,16($sp)
	lw	$5,24($sp)
	subu	$4,$0,$4
	subu	$5,$0,$5
$L851:
	jal	intatan
	move	$16,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GetDesiredVector__FP8Car_tObj
	sw	$16,1784($18)
	.set	macro
	.set	reorder

	lw	$4,1744($18)
	lw	$5,1752($18)
	jal	intatan
	move	$4,$2
	subu	$3,$16,$4
	slt	$2,$3,-512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L852
	addu	$2,$3,1024
	.set	macro
	.set	reorder

	slt	$2,$3,513
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L848
	sw	$3,1756($18)
	.set	macro
	.set	reorder

	addu	$2,$3,-1024
$L852:
	sw	$2,1756($18)
$L848:
	sw	$4,1788($18)
	lw	$31,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AIPhysic_Preperation__FP8Car_tObj
	.text
	.ent	AIPhysic_CalculateRoadPosition__FP8coorddefi
AIPhysic_CalculateRoadPosition__FP8coorddefi:
	.frame	$sp,48,$31		# vars= 48, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$2,BWorldSm_slices
	sll	$5,$5,5
	addu	$2,$5,$2
	lw	$10,0($2)
	lw	$11,4($2)
	lw	$12,8($2)
	sw	$10,0($sp)
	sw	$11,4($sp)
	sw	$12,8($sp)
	lw	$3,0($4)
	lw	$2,0($sp)
	#nop
	subu	$7,$3,$2
	sw	$7,16($sp)
	lw	$3,4($4)
	lw	$2,4($sp)
	#nop
	subu	$8,$3,$2
	sw	$8,20($sp)
	lw	$3,8($4)
	lw	$2,8($sp)
	lw	$4,BWorldSm_slices
	subu	$9,$3,$2
	addu	$5,$5,$4
	sw	$9,24($sp)
	lb	$3,18($5)
	#nop
	sll	$3,$3,9
	sw	$3,32($sp)
	lb	$2,19($5)
	#nop
	sll	$4,$2,9
	sw	$4,36($sp)
	lb	$2,20($5)
	#nop
	sll	$6,$2,9
	.set	noreorder
	.set	nomacro
	bgez	$3,$L854
	sw	$6,40($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L854:
	move	$2,$7
	.set	noreorder
	.set	nomacro
	bgez	$2,$L855
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L855:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L861
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L861:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L857
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L857:
	sra	$2,$2,8
	mult	$3,$2
	move	$4,$6
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L858
	addu	$3,$5,$10
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L858:
	move	$2,$9
	.set	noreorder
	.set	nomacro
	bgez	$2,$L859
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L859:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$10
	#nop
	#nop
	addu	$2,$3,$10
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AIPhysic_CalculateRoadPosition__FP8coorddefi
	.text
	.ent	AIPhysic_GetDesiredVector__FP8Car_tObj
AIPhysic_GetDesiredVector__FP8Car_tObj:
	.frame	$sp,88,$31		# vars= 48, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$18,72($sp)
	move	$18,$4
	sw	$20,80($sp)
	sw	$31,84($sp)
	sw	$19,76($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	lw	$2,1800($18)
	lh	$19,8($18)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L864
	move	$20,$0
	.set	macro
	.set	reorder

	lw	$2,1804($18)
	#nop
	bne	$2,$0,$L864
	lw	$2,1808($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L863
	li	$5,45875			# 0x0000b333
	.set	macro
	.set	reorder

$L864:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	j	$L862
$L863:
	lw	$2,1380($18)
	#nop
	.set	noreorder
	bgez	$2,1f
	move	$16,$2
	subu	$16,$0,$16
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,715784192			# 0x2aaa0000
	ori	$4,$4,0xaaab
	li	$3,196608			# 0x00030000
	addu	$2,$2,$3
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,16
	subu	$17,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$17,$L865
	lui	$2,%hi(AIPhysicConfig+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(AIPhysicConfig+4)($2)
	#nop
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$2
	slt	$2,$17,$3
	beq	$2,$0,$L865
	bltz	$16,$L865
	move	$17,$3
$L865:
	li	$3,715784192			# 0x2aaa0000
	lui	$2,%hi(AIPhysicConfig+8) # high
	lw	$2,%lo(AIPhysicConfig+8)($2)
	ori	$3,$3,0xaaab
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$2
	slt	$2,$3,$17
	beq	$2,$0,$L866
	move	$17,$3
$L866:
	lw	$2,1776($18)
	#nop
	mult	$17,$2
	mflo	$3
	#nop
	lw	$2,1364($18)
	#nop
	mult	$3,$2
	mflo	$5
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$5,$L867
	addu	$3,$19,$5
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	#nop
	slt	$2,$3,$4
	bne	$2,$0,$L870
	.set	noreorder
	.set	nomacro
	j	$L870
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L867:
	bgez	$3,$L870
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L870:
	sw	$3,1880($18)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,1880($18)
	lw	$4,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$4
	lbu	$4,30($3)
	lbu	$6,29($3)
	sll	$4,$4,15
	srl	$5,$6,4
	mult	$4,$5
	lbu	$3,31($3)
	mflo	$5
	#nop
	sll	$3,$3,15
	andi	$6,$6,0x000f
	mult	$3,$6
	.set	noreorder
	bgez	$2,1f
	move	$4,$2
	subu	$4,$0,$4
1:
	.set	reorder
	li	$3,1114112			# 0x00110000
	ori	$3,$3,0xffff
	mflo	$6
	#nop
	#nop
	addu	$2,$5,$6
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L882
	li	$2,62259			# 0x0000f333
	.set	macro
	.set	reorder

	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L872
	sll	$2,$17,3
	.set	macro
	.set	reorder

	subu	$2,$2,$17
	sll	$3,$2,5
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$17
	sll	$3,$2,3
	subu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$17
	.set	noreorder
	.set	nomacro
	bgez	$3,$L872
	sra	$17,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$17,$3,16
$L872:
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L874
	sll	$2,$17,3
	.set	macro
	.set	reorder

	subu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,3
	subu	$2,$2,$17
	sll	$2,$2,5
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	j	$L901
	sll	$3,$2,1
	.set	macro
	.set	reorder

$L874:
	li	$2,52428			# 0x0000cccc
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L877
	sll	$2,$17,5
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,3
	subu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$2,$17
	sll	$3,$2,3
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L901
	sll	$3,$3,1
	.set	macro
	.set	reorder

$L877:
	li	$2,49152			# 0x0000c000
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L882
	sll	$2,$17,2
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,4
	addu	$2,$2,$17
	sll	$2,$2,4
	addu	$2,$2,$17
	sll	$2,$2,4
	addu	$2,$2,$17
	sll	$3,$2,2
	subu	$3,$3,$2
$L901:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L882
	sra	$17,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$17,$3,16
$L882:
	lw	$2,1776($18)
	#nop
	mult	$17,$2
	mflo	$3
	#nop
	lw	$2,1364($18)
	#nop
	mult	$3,$2
	mflo	$5
	#nop
	#nop
	bltz	$5,$L885
	lw	$3,gNumSlices
	addu	$5,$19,$5
	slt	$2,$5,$3
	bne	$2,$0,$L888
	.set	noreorder
	.set	nomacro
	j	$L888
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L885:
	addu	$5,$19,$5
	bgez	$5,$L888
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L888:
	sw	$5,1880($18)
	lw	$2,1880($18)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,16($sp)
	sw	$9,20($sp)
	sw	$10,24($sp)
	lw	$2,1880($18)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lb	$5,18($2)
	#nop
	sll	$5,$5,9
	sw	$5,48($sp)
	lw	$2,1880($18)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$3
	lb	$2,19($2)
	#nop
	sll	$2,$2,9
	sw	$2,52($sp)
	lw	$2,1880($18)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$3
	lb	$2,20($2)
	#nop
	sll	$2,$2,9
	sw	$2,56($sp)
	lw	$4,1816($18)
	jal	fixedmult
	sw	$2,32($sp)
	lw	$4,1816($18)
	lw	$5,52($sp)
	jal	fixedmult
	sw	$2,36($sp)
	lw	$4,1816($18)
	lw	$5,56($sp)
	jal	fixedmult
	addu	$4,$sp,32
	lw	$3,32($sp)
	lw	$6,16($sp)
	lw	$7,24($sp)
	move	$5,$19
	sw	$2,40($sp)
	addu	$3,$3,$6
	sw	$3,32($sp)
	lw	$3,36($sp)
	lw	$6,20($sp)
	addu	$2,$2,$7
	sw	$2,40($sp)
	addu	$3,$3,$6
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalculateRoadPosition__FP8coorddefi
	sw	$3,36($sp)
	.set	macro
	.set	reorder

	lw	$4,BWorldSm_slices
	sll	$3,$19,5
	addu	$5,$3,$4
	lbu	$4,31($5)
	lbu	$6,29($5)
	sll	$4,$4,15
	andi	$3,$6,0x000f
	mult	$4,$3
	move	$4,$2
	mflo	$8
	#nop
	#nop
	slt	$2,$8,$4
	beq	$2,$0,$L891
	lw	$2,1396($18)
	#nop
	slt	$2,$2,$4
	bne	$2,$0,$L890
$L891:
	lbu	$2,30($5)
	srl	$3,$6,4
	sll	$2,$2,15
	mult	$2,$3
	mflo	$8
	#nop
	#nop
	subu	$2,$0,$8
	slt	$2,$4,$2
	beq	$2,$0,$L889
	lw	$2,1396($18)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L889
$L890:
	lw	$3,1396($18)
	#nop
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L892
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$16,-1			# 0xffffffff
$L892:
	move	$4,$19
	sll	$5,$16,19
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	addu	$5,$3,$5
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L893
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$2,1396($18)
	sll	$5,$16,18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L895
	sltu	$4,$0,$2
	.set	macro
	.set	reorder

$L893:
	.set	noreorder
	.set	nomacro
	j	$L895
	move	$4,$0
	.set	macro
	.set	reorder

$L889:
	li	$4,1			# 0x00000001
$L895:
	addu	$20,$20,1
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$17,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$17,$L896
	move	$2,$17
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$17,$2
$L896:
	sra	$17,$2,16
	li	$3,4			# 0x00000004
	slt	$2,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L902
	slt	$2,$20,5
	.set	macro
	.set	reorder

	move	$3,$17
$L902:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L883
	move	$17,$3
	.set	macro
	.set	reorder

	beq	$4,$0,$L882
$L883:
	lw	$2,32($sp)
	lw	$3,160($18)
	#nop
	subu	$2,$2,$3
	sw	$2,1744($18)
	lw	$2,36($sp)
	lw	$3,164($18)
	#nop
	subu	$2,$2,$3
	sw	$2,1748($18)
	lw	$2,40($sp)
	lw	$3,168($18)
	#nop
	subu	$2,$2,$3
	sw	$2,1752($18)
$L862:
	lw	$31,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	AIPhysic_GetDesiredVector__FP8Car_tObj
	.text
	.ent	AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
AIPhysic_TargetedGetDesiredVector__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1800($4)
	lw	$5,160($4)
	lw	$3,1804($4)
	lw	$6,164($4)
	subu	$2,$2,$5
	sw	$2,1744($4)
	lw	$2,1808($4)
	subu	$3,$3,$6
	sw	$3,1748($4)
	lw	$3,168($4)
	lw	$5,1812($4)
	subu	$2,$2,$3
	sw	$2,1752($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,1816($4)
	.set	macro
	.set	reorder

	.end	AIPhysic_TargetedGetDesiredVector__FP8Car_tObj
	.text
	.ent	AIPhysic_CheckIfOutOfControl__FP8Car_tObj
AIPhysic_CheckIfOutOfControl__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$5,1364($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lui	$3,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($3)
	lw	$4,1864($16)
	.set	noreorder
	bgez	$2,1f
	move	$7,$2
	subu	$7,$0,$7
1:
	.set	reorder
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L906
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	lw	$3,1380($16)
	ori	$2,$2,0xffff
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L918
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L906:
	lw	$2,1756($16)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,116
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L909
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,1776($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L909
	li	$3,-196608			# 0xfffd0000
	.set	macro
	.set	reorder

	lw	$2,1380($16)
	#nop
	.set	noreorder
	bgez	$2,1f
	move	$8,$2
	subu	$8,$0,$8
1:
	.set	reorder
	lui	$2,%hi(AIPhysicConfig+96) # high
	lw	$2,%lo(AIPhysicConfig+96)($2)
	#nop
	addu	$2,$2,$3
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,8($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$4,$2,$3
	lbu	$2,30($4)
	lbu	$6,29($4)
	sll	$2,$2,15
	srl	$3,$6,4
	mult	$2,$3
	lw	$5,1396($16)
	mflo	$9
	#nop
	#nop
	subu	$2,$0,$9
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,31($4)
	andi	$3,$6,0x000f
	sll	$2,$2,15
	mult	$2,$3
	mflo	$9
	#nop
	#nop
	slt	$2,$9,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,52428			# 0x0000cccc
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,1048($16)
	lw	$4,1384($16)
	.set	noreorder
	bgez	$2,1f
	move	$5,$2
	subu	$5,$0,$5
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$4,$L919
	sra	$2,$4,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
	sra	$2,$4,8
$L919:
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$3,$3,1
	slt	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L915
	li	$2,917504			# 0x000e0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L918
	move	$2,$0
	.set	macro
	.set	reorder

$L909:
	.set	noreorder
	.set	nomacro
	j	$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L915:
	move	$2,$0
$L918:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_CheckIfOutOfControl__FP8Car_tObj
	.text
	.ent	AIPhysic_OutOfControlPhysics__FP8Car_tObj
AIPhysic_OutOfControlPhysics__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,1364($17)
	lui	$16,%hi(AIPhysicConfig) # high
	sw	$0,1844($17)
	lw	$5,%lo(AIPhysicConfig)($16)
	#nop
	mult	$2,$5
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcFutureLateralVel__FP8Car_tObji
	addiu	$16,$16,%lo(AIPhysicConfig) # low
	.set	macro
	.set	reorder

	lw	$4,1364($17)
	lw	$3,1380($17)
	#nop
	mult	$4,$3
	move	$20,$0
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L921
	move	$21,$2
	.set	macro
	.set	reorder

	lw	$2,1776($17)
	#nop
	nor	$2,$0,$2
	sltu	$20,$20,$2
$L921:
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,1864($17)
	lw	$5,80($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

	lw	$3,1756($17)
	#nop
	subu	$3,$0,$3
	mult	$3,$2
	lw	$3,84($16)
	mflo	$5
	#nop
	#nop
	slt	$2,$5,$3
	beq	$2,$0,$L922
	move	$3,$5
$L922:
	lw	$2,84($16)
	move	$5,$3
	subu	$3,$0,$2
	slt	$2,$3,$5
	beq	$2,$0,$L923
	move	$3,$5
$L923:
	move	$5,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L924
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L924:
	lw	$4,68($16)
	sra	$2,$2,8
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$6,$3,9
	slt	$2,$6,$4
	beq	$2,$0,$L925
	move	$4,$6
$L925:
	lw	$2,68($16)
	move	$6,$4
	subu	$3,$0,$2
	slt	$2,$3,$6
	beq	$2,$0,$L926
	move	$3,$6
$L926:
	lw	$4,1384($17)
	move	$6,$3
	slt	$2,$6,$4
	beq	$2,$0,$L927
	move	$4,$6
$L927:
	lw	$7,1384($17)
	move	$6,$4
	subu	$3,$0,$7
	slt	$2,$3,$6
	beq	$2,$0,$L928
	move	$3,$6
$L928:
	move	$6,$3
	lw	$4,96($16)
	lw	$3,1380($17)
	subu	$2,$0,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L929
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L929
	.set	noreorder
	.set	nomacro
	bgez	$7,$L930
	move	$3,$7
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L930:
	lw	$2,100($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L931
	sra	$8,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L931:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$3
	#nop
	#nop
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L932
	move	$4,$3
	.set	macro
	.set	reorder

	move	$4,$6
$L932:
	move	$6,$4
	subu	$3,$0,$3
	slt	$2,$3,$6
	beq	$2,$0,$L933
	move	$3,$6
$L933:
	lw	$2,104($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L935
	move	$6,$3
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L935:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$3
	#nop
	#nop
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L936
	move	$4,$3
	.set	macro
	.set	reorder

	move	$4,$5
$L936:
	move	$5,$4
	subu	$3,$0,$3
	slt	$2,$3,$5
	beq	$2,$0,$L937
	move	$3,$5
$L937:
	move	$5,$3
$L929:
	lw	$3,1872($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L938
	sll	$2,$5,$2
	.set	macro
	.set	reorder

	addu	$5,$5,$2
$L938:
	lw	$2,1064($17)
	#nop
	subu	$3,$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$3,$L981
	lui	$2,%hi(AIPhysicConfig) # high
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L981:
	addiu	$5,$2,%lo(AIPhysicConfig) # low
	lw	$2,88($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L940
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L940:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,1380($17)
	li	$2,1179648			# 0x00120000
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L941
	subu	$18,$0,$9
	.set	macro
	.set	reorder

	srl	$2,$18,31
	addu	$2,$18,$2
	sra	$18,$2,1
$L941:
	lw	$3,1836($17)
	#nop
	slt	$2,$18,$3
	beq	$2,$0,$L942
	move	$3,$18
$L942:
	lw	$2,1836($17)
	move	$18,$3
	subu	$3,$0,$2
	slt	$2,$3,$18
	beq	$2,$0,$L943
	move	$3,$18
$L943:
	lw	$2,1048($17)
	#nop
	subu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$2,$L944
	move	$18,$3
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L944:
	lw	$4,72($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L945
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L945:
	sra	$2,$4,8
	mult	$3,$2
	lw	$3,1832($17)
	mflo	$9
	#nop
	#nop
	subu	$19,$0,$9
	slt	$2,$19,$3
	beq	$2,$0,$L946
	move	$3,$19
$L946:
	lw	$2,1832($17)
	move	$19,$3
	subu	$3,$0,$2
	slt	$2,$3,$19
	beq	$2,$0,$L947
	move	$3,$19
$L947:
	move	$19,$3
	li	$3,-1			# 0xffffffff
	lw	$2,1776($17)
	lw	$4,1056($17)
	bne	$2,$3,$L948
	lw	$2,1800($17)
	#nop
	bne	$2,$0,$L948
	lw	$2,1804($17)
	#nop
	bne	$2,$0,$L948
	lw	$2,1808($17)
	#nop
	bne	$2,$0,$L948
	lw	$2,96($5)
	.set	noreorder
	.set	nomacro
	j	$L949
	subu	$3,$0,$2
	.set	macro
	.set	reorder

$L948:
	lw	$3,1372($17)
	lw	$2,1364($17)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	lw	$2,1776($17)
	#nop
	mult	$3,$2
	mflo	$3
$L949:
	lw	$2,632($17)
	#nop
	bne	$2,$0,$L950
	.set	noreorder
	.set	nomacro
	bltz	$3,$L951
	li	$2,-131072			# 0xfffe0000
	.set	macro
	.set	reorder

	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L950
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L953
	j	$L950
$L951:
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L950
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	slt	$2,$2,$4
	bne	$2,$0,$L950
$L953:
	lw	$3,1360($17)
	lw	$2,1364($17)
	#nop
	bne	$3,$2,$L950
	lw	$5,1056($17)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalcAcceleration__FP8Car_tObji
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,1776($17)
	#nop
	mult	$2,$4
	lbu	$5,1088($17)
	lw	$3,AIPhysic_elapsedTime
	#nop
	slt	$3,$3,$5
	mflo	$16
	#nop
	beq	$3,$0,$L957
	lbu	$2,AIPhysic_elapsedTime
	#nop
	subu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L958
	sb	$2,1088($17)
	.set	macro
	.set	reorder

$L957:
	sb	$0,1088($17)
$L958:
	lbu	$2,1088($17)
	#nop
	bne	$2,$0,$L960
	.set	noreorder
	.set	nomacro
	j	$L960
	sb	$0,1085($17)
	.set	macro
	.set	reorder

$L950:
	lw	$2,1056($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	.set	noreorder
	.set	nomacro
	blez	$2,$L960
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalcDeceleration__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	subu	$16,$0,$2
	lw	$2,AIPhysic_elapsedTime
	lbu	$3,1088($17)
	sll	$2,$2,2
	addu	$3,$3,$2
	slt	$2,$3,255
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L962
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L963
	sb	$3,1088($17)
	.set	macro
	.set	reorder

$L962:
	sb	$2,1088($17)
$L963:
	lbu	$2,1088($17)
	#nop
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L964
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,1085($17)
$L964:
	lw	$2,1056($17)
	#nop
	bgez	$2,$L960
	subu	$16,$0,$16
$L960:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L966
	li	$4,-1376256			# 0xffeb0000
	.set	macro
	.set	reorder

	ori	$4,$4,0xffff
	li	$3,1900544			# 0x001d0000
	lw	$2,1384($17)
	ori	$3,$3,0xfffe
	addu	$2,$2,$4
	sltu	$3,$3,$2
	bne	$3,$0,$L967
	.set	noreorder
	.set	nomacro
	bgez	$18,$L968
	move	$2,$18
	.set	macro
	.set	reorder

	addu	$2,$18,3
$L968:
	sra	$18,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L969
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$2,$16,3
$L969:
	.set	noreorder
	.set	nomacro
	j	$L970
	sra	$16,$2,2
	.set	macro
	.set	reorder

$L967:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,49152			# 0x0000c000
	.set	macro
	.set	reorder

	move	$18,$2
	move	$3,$16
	srl	$2,$16,31
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L971
	sra	$4,$2,1
	.set	macro
	.set	reorder

	addu	$3,$16,3
$L971:
	sra	$2,$3,2
	addu	$16,$4,$2
$L970:
	.set	noreorder
	.set	nomacro
	bgez	$19,$L972
	move	$3,$19
	.set	macro
	.set	reorder

	addu	$3,$19,3
$L972:
	move	$2,$19
	.set	noreorder
	.set	nomacro
	bgez	$19,$L973
	sra	$3,$3,2
	.set	macro
	.set	reorder

	addu	$2,$19,7
$L973:
	sra	$2,$2,3
	addu	$19,$3,$2
$L966:
	lw	$3,1364($17)
	lw	$2,1380($17)
	#nop
	mult	$3,$2
	lui	$2,%hi(AIPhysicConfig+16) # high
	lw	$3,%lo(AIPhysicConfig+16)($2)
	.set	noreorder
	bgez	$21,1f
	move	$2,$21
	subu	$2,$0,$2
1:
	.set	reorder
	mflo	$9
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$9,$L976
	subu	$4,$2,$3
	.set	macro
	.set	reorder

	li	$2,196608			# 0x00030000
	lw	$3,1384($17)
	ori	$2,$2,0x8e38
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L982
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

$L976:
	lw	$2,1872($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L974
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

$L982:
	sw	$2,1156($17)
	.set	noreorder
	.set	nomacro
	j	$L977
	sw	$2,1160($17)
	.set	macro
	.set	reorder

$L974:
	blez	$4,$L978
	sw	$4,1156($17)
	.set	noreorder
	.set	nomacro
	j	$L977
	sw	$4,1160($17)
	.set	macro
	.set	reorder

$L978:
	sw	$0,1160($17)
	sw	$0,1156($17)
$L977:
	sw	$19,1036($17)
	sw	$0,1040($17)
	sw	$16,1044($17)
	sw	$0,1072($17)
	sw	$0,1076($17)
	sw	$0,1080($17)
	sw	$0,1012($17)
	sw	$18,1016($17)
	sw	$0,1020($17)
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

	.end	AIPhysic_OutOfControlPhysics__FP8Car_tObj
	.text
	.ent	AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
AIPhysic_GetRearEndDamageFactor__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,552($4)
	lw	$2,556($4)
	li	$5,327			# 0x00000147
	addu	$3,$3,$2
	lw	$2,560($4)
	lw	$4,572($4)
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	move	$3,$2
	li	$4,65536			# 0x00010000
	move	$2,$4
	slt	$2,$2,$3
	bne	$2,$0,$L984
	move	$4,$3
$L984:
	lw	$31,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
	.text
	.ent	AIPhysic_InControlPhysics__FP8Car_tObj
AIPhysic_InControlPhysics__FP8Car_tObj:
	.frame	$sp,112,$31		# vars= 56, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$18,80($sp)
	move	$18,$4
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$23,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$20,88($sp)
	sw	$19,84($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	lw	$9,1364($18)
	#nop
	sw	$9,56($sp)
	sw	$0,1844($18)
	lw	$10,1744($18)
	lw	$11,1748($18)
	lw	$12,1752($18)
	sw	$10,16($sp)
	sw	$11,20($sp)
	sw	$12,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_QDNormalizeVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	lw	$3,20($sp)
	lw	$2,16($sp)
	sw	$0,64($sp)
	subu	$2,$0,$2
	sw	$5,32($sp)
	sw	$3,36($sp)
	sw	$2,40($sp)
	lw	$4,172($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$20,$0
	.set	macro
	.set	reorder

	lw	$4,176($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$3,1364($18)
	addu	$16,$16,$2
	mult	$16,$3
	li	$5,98			# 0x00000062
	lw	$23,1836($18)
	lw	$6,1396($18)
	lw	$2,1816($18)
	lw	$4,1056($18)
	subu	$6,$6,$2
	sw	$6,52($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$9,48($sp)
	.set	macro
	.set	reorder

	li	$4,65536			# 0x00010000
	lw	$5,1888($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,608($18)
	#nop
	andi	$3,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L987
	move	$16,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($2)
	lw	$2,1860($18)
	#nop
	slt	$2,$2,$4
	beq	$2,$0,$L987
	lw	$2,280($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,1001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L987
	li	$2,1441792			# 0x00160000
	.set	macro
	.set	reorder

	lw	$3,1384($18)
	ori	$2,$2,0x38e3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L987
	addu	$2,$4,384
	.set	macro
	.set	reorder

	sw	$2,1864($18)
$L987:
	addu	$4,$18,1268
	lui	$2,%hi(simGlobal) # high
	addiu	$17,$2,%lo(simGlobal) # low
	lw	$3,4($17)
	lw	$2,440($18)
	li	$5,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	subu	$19,$3,$2
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	bne	$2,$3,$L991
	lw	$2,4($17)
	lw	$3,1864($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1049
	lui	$2,%hi(GameSetup_gData+8) # high
	.set	macro
	.set	reorder

$L991:
	lw	$3,4($17)
	lw	$2,440($18)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1050
	move	$23,$0
	.set	macro
	.set	reorder

	sw	$3,1864($18)
$L1050:
	lw	$3,280($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L993
	move	$16,$23
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L993:
	addu	$3,$3,458
	slt	$2,$3,13108
	bne	$2,$0,$L994
	li	$3,13107			# 0x00003333
$L994:
	lw	$2,280($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L995
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L996
	sw	$3,280($18)
	.set	macro
	.set	reorder

$L995:
	sw	$2,280($18)
$L996:
	li	$20,655360			# 0x000a0000
	lui	$2,%hi(GameSetup_gData+8) # high
$L1049:
	lw	$fp,%lo(GameSetup_gData+8)($2)
	slt	$2,$19,16
	beq	$2,$0,$L997
	lw	$2,1860($18)
	#nop
	addu	$2,$2,-20
	sw	$2,1860($18)
$L997:
	la	$2,copCollisionReactionTime.282
	addu	$2,$fp,$2
	lbu	$2,0($2)
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L998
	lw	$2,432($18)
	#nop
	beq	$2,$0,$L998
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L998
	move	$4,$16
	.set	macro
	.set	reorder

	move	$23,$0
	lui	$3,%hi(copCollisionGripLoss.283) # high
	addiu	$3,$3,%lo(copCollisionGripLoss.283) # low
	sll	$2,$fp,2
	addu	$2,$2,$3
	lw	$5,0($2)
	li	$10,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$10,64($sp)
	.set	macro
	.set	reorder

	move	$16,$2
$L998:
	lw	$2,1832($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1051
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1051:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1000
	sra	$4,$2,8
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L1000:
	sra	$3,$3,8
	mult	$4,$3
	lui	$2,%hi(AIPhysicConfig+28) # high
	lw	$2,%lo(AIPhysicConfig+28)($2)
	mflo	$19
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1052
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$5,$2,8
$L1052:
	mult	$5,$3
	lw	$3,1840($18)
	li	$2,65536			# 0x00010000
	slt	$2,$2,$3
	mflo	$21
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1053
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L1004
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L1004:
	move	$2,$19
	.set	noreorder
	.set	nomacro
	bgez	$19,$L1005
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$19,255
$L1005:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$19
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$21,$L1007
	move	$2,$21
	.set	macro
	.set	reorder

	addu	$2,$21,255
$L1007:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$21
	#nop
	lui	$2,%hi(simGlobal) # high
$L1053:
	addiu	$22,$2,%lo(simGlobal) # low
	lw	$4,1876($18)
	lw	$3,4($22)
	lw	$17,1756($18)
	lw	$9,1372($18)
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1008
	sw	$9,60($sp)
	.set	macro
	.set	reorder

	li	$2,1717960704			# 0x66660000
	ori	$2,$2,0x6667
	mult	$3,$2
	li	$5,1			# 0x00000001
	subu	$4,$4,$3
	sra	$3,$3,31
	mfhi	$9
	#nop
	#nop
	sra	$2,$9,4
	subu	$2,$2,$3
	and	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1054
	li	$2,150			# 0x00000096
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
$L1054:
	subu	$3,$2,$4
	slt	$2,$3,50
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1010
	sll	$2,$5,4
	.set	macro
	.set	reorder

	subu	$2,$2,$5
	sll	$2,$2,1
	mult	$2,$3
	mflo	$2
	#nop
	li	$3,1374355456			# 0x51eb0000
	ori	$3,$3,0x851f
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$3
	#nop
	#nop
	sra	$3,$3,4
	.set	noreorder
	.set	nomacro
	j	$L1048
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L1010:
	li	$2,-1840709632			# 0x92490000
	ori	$2,$2,0x2493
	mult	$4,$2
	mfhi	$3
	#nop
	#nop
	addu	$2,$3,$4
	sra	$2,$2,2
	sra	$3,$4,31
	subu	$2,$2,$3
	addu	$2,$2,10
	mult	$5,$2
	mflo	$3
$L1048:
	slt	$2,$4,51
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1013
	addu	$17,$17,$3
	.set	macro
	.set	reorder

	li	$3,1374355456			# 0x51eb0000
	ori	$3,$3,0x851f
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,18
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,4
	.set	noreorder
	.set	nomacro
	j	$L1013
	subu	$20,$3,$2
	.set	macro
	.set	reorder

$L1008:
	lw	$2,1264($18)
	#nop
	lw	$2,44($2)
	.set	noreorder
	bgez	$17,1f
	move	$16,$17
	subu	$16,$0,$16
1:
	.set	reorder
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1055
	lui	$2,%hi(AIPhysicConfig) # high
	.set	macro
	.set	reorder

	lw	$2,1016($18)
	#nop
	mult	$17,$2
	mflo	$9
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	blez	$9,$L1013
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysic_GetRearEndDamageFactor__FP8Car_tObj
	sll	$16,$16,16
	.set	macro
	.set	reorder

	li	$3,65536			# 0x00010000
	subu	$3,$3,$2
	sll	$2,$3,2
	lw	$4,1264($18)
	addu	$2,$2,$3
	lw	$3,44($4)
	sll	$2,$2,2
	addu	$3,$3,-20
	sll	$3,$3,16
	addu	$2,$2,$3
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1055
	lui	$2,%hi(AIPhysicConfig) # high
	.set	macro
	.set	reorder

	lw	$2,4($22)
	#nop
	addu	$2,$2,150
	sw	$2,1876($18)
$L1013:
	lui	$2,%hi(AIPhysicConfig) # high
$L1055:
	addiu	$16,$2,%lo(AIPhysicConfig) # low
	lw	$5,36($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

	subu	$3,$0,$17
	mult	$3,$2
	lw	$4,40($16)
	mflo	$3
	#nop
	#nop
	slt	$2,$3,$4
	beq	$2,$0,$L1015
	move	$4,$3
$L1015:
	lw	$2,40($16)
	move	$3,$4
	subu	$4,$0,$2
	slt	$2,$4,$3
	beq	$2,$0,$L1016
	move	$4,$3
$L1016:
	lw	$6,52($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1017
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1017:
	lw	$2,20($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1018
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1018:
	sra	$2,$2,8
	mult	$6,$2
	lw	$4,24($16)
	mflo	$9
	#nop
	#nop
	subu	$6,$0,$9
	slt	$2,$6,$4
	beq	$2,$0,$L1019
	move	$4,$6
$L1019:
	lw	$2,24($16)
	move	$6,$4
	subu	$4,$0,$2
	slt	$2,$4,$6
	beq	$2,$0,$L1020
	move	$4,$6
$L1020:
	lw	$5,1384($18)
	move	$6,$4
	slt	$2,$6,$5
	beq	$2,$0,$L1021
	move	$5,$6
$L1021:
	lw	$7,1384($18)
	move	$6,$5
	subu	$4,$0,$7
	slt	$2,$4,$6
	beq	$2,$0,$L1022
	move	$4,$6
$L1022:
	move	$6,$4
	lw	$5,52($16)
	lw	$4,1380($18)
	subu	$2,$0,$5
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1023
	slt	$2,$4,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1056
	lui	$2,%hi(AIPhysicConfig+44) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$7,$L1024
	move	$4,$7
	.set	macro
	.set	reorder

	addu	$4,$7,255
$L1024:
	lw	$2,56($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1025
	sra	$8,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1025:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$4
	#nop
	#nop
	bgez	$4,1f
	subu	$4,$0,$4
1:
	slt	$2,$6,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1026
	move	$5,$4
	.set	macro
	.set	reorder

	move	$5,$6
$L1026:
 #APP
 #NO_APP
	lw	$2,60($16)
	#nop
	bgez	$2,$L1028
	addu	$2,$2,255
$L1028:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$4
	#nop
	#nop
	bgez	$4,1f
	subu	$4,$0,$4
1:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1029
	move	$5,$4
	.set	macro
	.set	reorder

	move	$5,$3
$L1029:
	move	$3,$5
	subu	$4,$0,$4
	slt	$2,$4,$3
	beq	$2,$0,$L1030
	move	$4,$3
$L1030:
	move	$3,$4
$L1023:
	lui	$2,%hi(AIPhysicConfig+44) # high
$L1056:
	lw	$4,1064($18)
	lw	$5,%lo(AIPhysicConfig+44)($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$3
	.set	macro
	.set	reorder

	subu	$17,$0,$2
	slt	$2,$17,$23
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1031
	move	$3,$23
	.set	macro
	.set	reorder

	move	$3,$17
$L1031:
	move	$17,$3
	subu	$3,$0,$23
	slt	$2,$3,$17
	beq	$2,$0,$L1032
	move	$3,$17
$L1032:
	move	$17,$3
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$21
	.set	macro
	.set	reorder

	lw	$9,56($sp)
	#nop
	subu	$3,$0,$9
	mult	$3,$2
	mflo	$16
	#nop
	#nop
	slt	$2,$16,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1033
	move	$3,$19
	.set	macro
	.set	reorder

	move	$3,$16
$L1033:
	move	$16,$3
	subu	$3,$0,$19
	slt	$2,$3,$16
	beq	$2,$0,$L1034
	move	$3,$16
$L1034:
	lw	$9,60($sp)
	lw	$10,56($sp)
	#nop
	mult	$9,$10
	mflo	$2
	#nop
	lw	$5,1380($18)
	#nop
	mult	$5,$10
	mflo	$6
	#nop
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1035
	move	$16,$3
	.set	macro
	.set	reorder

	lw	$2,632($18)
	#nop
	bne	$2,$0,$L1035
	lw	$3,1360($18)
	lw	$2,1364($18)
	#nop
	bne	$3,$2,$L1035
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalcAcceleration__FP8Car_tObji
	move	$4,$18
	.set	macro
	.set	reorder

	lbu	$4,1088($18)
	lw	$3,AIPhysic_elapsedTime
	#nop
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1036
	move	$5,$2
	.set	macro
	.set	reorder

	lbu	$2,AIPhysic_elapsedTime
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L1037
	sb	$2,1088($18)
	.set	macro
	.set	reorder

$L1036:
	sb	$0,1088($18)
$L1037:
	lbu	$2,1088($18)
	#nop
	bne	$2,$0,$L1039
	.set	noreorder
	.set	nomacro
	j	$L1039
	sb	$0,1085($18)
	.set	macro
	.set	reorder

$L1035:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_CalcDeceleration__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	subu	$5,$0,$2
	lw	$2,AIPhysic_elapsedTime
	lbu	$3,1088($18)
	sll	$2,$2,2
	addu	$3,$3,$2
	slt	$2,$3,255
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1040
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1041
	sb	$3,1088($18)
	.set	macro
	.set	reorder

$L1040:
	sb	$2,1088($18)
$L1041:
	lbu	$2,1088($18)
	#nop
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1042
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,1085($18)
$L1042:
	lw	$2,1056($18)
	#nop
	bgez	$2,$L1039
	subu	$5,$0,$5
$L1039:
	lw	$9,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L1044
	lui	$2,%hi(copCollisionSlowDown.284) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(copCollisionSlowDown.284) # low
	sll	$3,$fp,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	subu	$5,$0,$2
$L1044:
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L1045
	lui	$2,%hi(AIPhysicConfig+16) # high
	.set	macro
	.set	reorder

	lw	$10,48($sp)
	lw	$3,%lo(AIPhysicConfig+16)($2)
	.set	noreorder
	bgez	$10,1f
	move	$2,$10
	subu	$2,$0,$2
1:
	.set	reorder
	subu	$20,$2,$3
$L1045:
	blez	$20,$L1046
	sw	$20,1160($18)
	.set	noreorder
	.set	nomacro
	j	$L1047
	sw	$20,1156($18)
	.set	macro
	.set	reorder

$L1046:
	sw	$0,1160($18)
	sw	$0,1156($18)
$L1047:
	sw	$16,1036($18)
	sw	$0,1040($18)
	sw	$5,1044($18)
	sw	$0,1072($18)
	sw	$0,1076($18)
	sw	$0,1080($18)
	sw	$0,1012($18)
	sw	$17,1016($18)
	sw	$0,1020($18)
	lw	$31,108($sp)
	lw	$fp,104($sp)
	lw	$23,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	AIPhysic_InControlPhysics__FP8Car_tObj
	.text
	.ent	AIPhysic_FinishUp__FP8Car_tObj
AIPhysic_FinishUp__FP8Car_tObj:
	.frame	$sp,128,$31		# vars= 96, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$18,120($sp)
	move	$18,$4
	sw	$31,124($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	lw	$2,1044($18)
	lw	$3,1080($18)
	move	$5,$0
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Cars_DoGravityEffectsOnAcc__FP8Car_tObji
	sw	$2,1044($18)
	.set	macro
	.set	reorder

	addu	$4,$18,240
	lw	$2,1044($18)
	lw	$3,1080($18)
	addu	$5,$sp,32
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transpose
	sw	$2,1044($18)
	.set	macro
	.set	reorder

	addu	$4,$18,324
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$sp,72
	.set	macro
	.set	reorder

	lw	$4,1036($18)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,1040($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1036($18)
	addu	$16,$16,$2
	sw	$16,1024($18)
	lw	$5,44($sp)
	jal	fixedmult
	lw	$4,1040($18)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($18)
	lw	$5,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1036($18)
	addu	$16,$16,$2
	sw	$16,1028($18)
	lw	$5,56($sp)
	jal	fixedmult
	lw	$4,1040($18)
	lw	$5,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($18)
	lw	$5,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1072($18)
	addu	$16,$16,$2
	sw	$16,1032($18)
	lw	$5,72($sp)
	jal	fixedmult
	lw	$4,1076($18)
	lw	$5,76($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1080($18)
	lw	$5,80($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,1024($18)
	lw	$4,1072($18)
	addu	$3,$3,$16
	sw	$3,1024($18)
	lw	$5,84($sp)
	jal	fixedmult
	lw	$4,1076($18)
	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1080($18)
	lw	$5,92($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,1028($18)
	lw	$4,1072($18)
	addu	$3,$3,$16
	sw	$3,1028($18)
	lw	$5,96($sp)
	jal	fixedmult
	lw	$4,1076($18)
	lw	$5,100($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1080($18)
	lw	$5,104($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,1032($18)
	lw	$4,1012($18)
	addu	$3,$3,$16
	sw	$3,1032($18)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,1016($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1020($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,16($sp)
	lw	$4,1012($18)
	lw	$5,44($sp)
	jal	fixedmult
	lw	$4,1016($18)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1020($18)
	lw	$5,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,20($sp)
	lw	$4,1012($18)
	lw	$5,56($sp)
	jal	fixedmult
	lw	$4,1016($18)
	lw	$5,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1020($18)
	lw	$5,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,24($sp)
	lw	$6,16($sp)
	lw	$7,20($sp)
	lw	$8,24($sp)
	sw	$6,1012($18)
	sw	$7,1016($18)
	sw	$8,1020($18)
	lw	$4,1024($18)
	lw	$5,AIPhysic_iTime
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$4,1028($18)
	lw	$3,172($18)
	lw	$5,AIPhysic_iTime
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$3,172($18)
	.set	macro
	.set	reorder

	lw	$4,1032($18)
	lw	$3,176($18)
	lw	$5,AIPhysic_iTime
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$3,176($18)
	.set	macro
	.set	reorder

	lw	$3,180($18)
	lw	$4,1844($18)
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1059
	sw	$3,180($18)
	.set	macro
	.set	reorder

$L1063:
	lw	$2,AIPhysic_elapsedTime
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L1059
	lw	$4,172($18)
	lw	$5,1844($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lw	$4,176($18)
	lw	$5,1844($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,172($18)
	.set	macro
	.set	reorder

	lw	$4,180($18)
	lw	$5,1844($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,176($18)
	.set	macro
	.set	reorder

	lw	$3,1844($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1063
	sw	$2,180($18)
	.set	macro
	.set	reorder

$L1059:
	lw	$2,1012($18)
	#nop
	bgez	$2,$L1064
	addu	$2,$2,255
$L1064:
	lw	$4,AIPhysic_iTime
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1065
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1065:
	sra	$5,$3,8
	mult	$2,$5
	lw	$2,276($18)
	lw	$3,1016($18)
	mflo	$6
	#nop
	#nop
	addu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1066
	sw	$2,276($18)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1066:
	sra	$2,$3,8
	mult	$2,$5
	lw	$2,280($18)
	lw	$3,1020($18)
	mflo	$6
	#nop
	#nop
	addu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1068
	sw	$2,280($18)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1068:
	sra	$2,$3,8
	mult	$2,$5
	lw	$2,284($18)
	mflo	$6
	#nop
	#nop
	addu	$2,$2,$6
	sw	$2,284($18)
	lw	$31,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	AIPhysic_FinishUp__FP8Car_tObj
	.text
	.ent	AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L1071
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,1368($16)
	.set	noreorder
	.set	nomacro
	j	$L1070
	sw	$2,1816($16)
	.set	macro
	.set	reorder

$L1071:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,AIPhysic_elapsedTime
	lw	$5,1396($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$4,$2,8
	lw	$3,1368($16)
	#nop
	slt	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1072
	addu	$6,$2,$4
	.set	macro
	.set	reorder

	lw	$2,1816($16)
	li	$3,-65536			# 0xffff0000
	addu	$2,$2,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1081
	li	$3,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1073
	sw	$5,1816($16)
	.set	macro
	.set	reorder

$L1072:
	li	$3,65536			# 0x00010000
$L1081:
	lw	$2,1816($16)
	lw	$4,1396($16)
	addu	$2,$2,$3
	slt	$2,$2,$4
	beq	$2,$0,$L1073
	lw	$2,1368($16)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1073
	sw	$4,1816($16)
$L1073:
	lw	$3,1816($16)
	lw	$4,1368($16)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1075
	addu	$2,$3,$6
	.set	macro
	.set	reorder

	sw	$2,1816($16)
	.set	noreorder
	.set	nomacro
	j	$L1080
	slt	$2,$4,$2
	.set	macro
	.set	reorder

$L1075:
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1070
	subu	$2,$3,$6
	.set	macro
	.set	reorder

	lw	$4,1368($16)
	sw	$2,1816($16)
	slt	$2,$2,$4
$L1080:
	beq	$2,$0,$L1070
	sw	$4,1816($16)
$L1070:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
	.text
	.ent	AIPhysic_HitWallCheck__FP8Car_tObj
AIPhysic_HitWallCheck__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,8($4)
	lw	$3,BWorldSm_slices
	lw	$5,1732($4)
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$7,29($2)
	li	$2,7			# 0x00000007
	srl	$3,$7,4
	subu	$2,$2,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1083
	move	$6,$0
	.set	macro
	.set	reorder

	andi	$2,$7,0x000f
	addu	$2,$2,6
	slt	$2,$2,$5
	xori	$6,$2,0x0001
$L1083:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L1084
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L1084:
	lw	$3,1776($4)
	#nop
	bne	$3,$2,$L1085
	lw	$2,1828($4)
	lw	$3,AIPhysic_elapsedTime
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1086
	sw	$2,1828($4)
	.set	macro
	.set	reorder

$L1085:
	sw	$0,1828($4)
$L1086:
	lw	$2,1828($4)
	#nop
	slt	$2,$2,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1087
	li	$2,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$3,340($4)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L1087:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	AIPhysic_HitWallCheck__FP8Car_tObj
	.text
	.ent	AIPhysic_ProcessBarrierCollision__FP8Car_tObj
AIPhysic_ProcessBarrierCollision__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1089
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,1380($4)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L1089
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ChangeDirection__FP8Car_tObji
	li	$5,96			# 0x00000060
	.set	macro
	.set	reorder

$L1089:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_ProcessBarrierCollision__FP8Car_tObj
	.text
	.ent	AIPhysic_ProcessCollision__FP8Car_tObj
AIPhysic_ProcessCollision__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,400($4)
	li	$2,55705			# 0x0000d999
	slt	$2,$2,$3
	beq	$2,$0,$L1093
	lw	$2,404($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1093
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,1380($4)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L1093
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1096
	li	$5,96			# 0x00000060
	.set	macro
	.set	reorder

	li	$5,160			# 0x000000a0
$L1096:
	jal	AIPhysic_ChangeDirection__FP8Car_tObji
$L1093:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_ProcessCollision__FP8Car_tObj
	.text
	.ent	AIPhysic_ChangeDirection__FP8Car_tObji
AIPhysic_ChangeDirection__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$4
	lw	$3,1776($6)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1106
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$7,$2,%lo(simGlobal) # low
	lw	$4,4($7)
	lw	$3,1780($6)
	lw	$2,1772($6)
	subu	$4,$4,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1101
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,1776($6)
$L1106:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1107
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	addiu	$7,$2,%lo(simGlobal) # low
	lw	$4,4($7)
	lw	$3,1780($6)
	lw	$2,1772($6)
	subu	$4,$4,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1107
	li	$3,1245184			# 0x00130000
	.set	macro
	.set	reorder

	lw	$2,1380($6)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1107
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L1101:
	sw	$2,1776($6)
	lw	$2,4($7)
	sw	$5,1772($6)
	sw	$2,1780($6)
$L1107:
	j	$31
	.end	AIPhysic_ChangeDirection__FP8Car_tObji
	.text
	.ent	AIPhysic_CheckForGripReduction__FP8Car_tObj
AIPhysic_CheckForGripReduction__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,1888($16)
	li	$2,65535			# 0x0000ffff
	slt	$2,$2,$4
	bne	$2,$0,$L1109
	lw	$2,1264($16)
	lw	$3,AIPhysic_elapsedTime
	lw	$2,64($2)
	#nop
	mult	$3,$2
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,440($16)
	mflo	$6
	#nop
	#nop
	addu	$4,$4,$6
	sw	$4,1888($16)
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,64
	beq	$2,$0,$L1110
	lw	$2,432($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1122
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

$L1110:
	lw	$2,1264($16)
	#nop
	lw	$3,60($2)
	li	$2,65536			# 0x00010000
	subu	$2,$2,$3
	bgez	$2,$L1112
	addu	$2,$2,3
$L1112:
	sra	$2,$2,2
	addu	$2,$3,$2
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1108
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1108
	sw	$2,1888($16)
	.set	macro
	.set	reorder

$L1109:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L1108
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0028
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1108
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L1116
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1123
	slt	$2,$2,2001
	.set	macro
	.set	reorder

$L1116:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	subu	$2,$0,$2
	slt	$2,$2,2001
$L1123:
	xori	$2,$2,0x0001
	beq	$2,$0,$L1108
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$5,1264($16)
	lw	$4,AIPhysic_elapsedTime
	mflo	$2
	#nop
	lw	$3,56($5)
	#nop
	mult	$4,$3
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1120
	andi	$3,$2,0xffff
	.set	macro
	.set	reorder

	addu	$4,$4,31
$L1120:
	sra	$2,$4,5
	slt	$2,$3,$2
	beq	$2,$0,$L1108
	lw	$2,60($5)
$L1122:
	sw	$2,1888($16)
$L1108:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_CheckForGripReduction__FP8Car_tObj
	.text
	.ent	AIPhysic_StartUp__Fv
AIPhysic_StartUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIPhysic_StartUp__Fv
	.text
	.ent	AIPhysic_CleanUp__Fv
AIPhysic_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIPhysic_CleanUp__Fv
	.text
	.ent	AIPhysic_Reset__Fv
AIPhysic_Reset__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIPhysic_Reset__Fv
	.text
	.ent	AIPhysic_ResetCar__FP8Car_tObj
AIPhysic_ResetCar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,632($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,628($4)
	.set	macro
	.set	reorder

	.end	AIPhysic_ResetCar__FP8Car_tObj
	.text
	.ent	AIPhysic_InitCar__FP8Car_tObj
AIPhysic_InitCar__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$4,608($20)
	#nop
	andi	$2,$4,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1132
	andi	$2,$4,0x0028
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1134
	li	$16,786432			# 0x000c0000
	.set	macro
	.set	reorder

	li	$16,720896			# 0x000b0000
$L1134:
	lw	$2,1264($20)
	#nop
	lw	$3,32($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1149
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1149:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1136
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$16,255
$L1136:
	sra	$2,$2,8
	mult	$3,$2
	andi	$2,$4,0x0008
	mflo	$16
	#nop
	beq	$2,$0,$L1137
	lw	$4,596($20)
	jal	AISpeeds_GetUpgradeBrakeMult__Fi
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1138
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L1138:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1139
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1139:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$16
$L1137:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,132			# 0x00000084
	.set	macro
	.set	reorder

	move	$18,$2
	sw	$16,128($18)
	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	move	$19,$2
	move	$17,$0
$L1140:
	slt	$2,$17,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1141
	sll	$16,$17,16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1144
	sra	$3,$3,1
	.set	macro
	.set	reorder

	ori	$16,$16,0xffff
$L1144:
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1150
	slt	$2,$16,128
	.set	macro
	.set	reorder

	subu	$16,$0,$16
	slt	$2,$16,128
$L1150:
	bne	$2,$0,$L1146
	li	$16,128			# 0x00000080
$L1146:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1147
	addu	$16,$18,$16
	.set	macro
	.set	reorder

	li	$2,65536			# 0x00010000
	ori	$2,$2,0xffff
	addu	$3,$3,$2
$L1147:
	sra	$2,$3,17
	sb	$2,0($16)
	.set	noreorder
	.set	nomacro
	j	$L1140
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1141:
	sw	$18,1720($20)
$L1132:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	AIPhysic_InitCar__FP8Car_tObj
	.text
	.ent	AIPhysic_DeInitCar__FP8Car_tObj
AIPhysic_DeInitCar__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L1154
	lw	$4,1720($16)
	#nop
	beq	$4,$0,$L1154
	jal	__builtin_delete
	sw	$0,1720($16)
$L1154:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIPhysic_DeInitCar__FP8Car_tObj
