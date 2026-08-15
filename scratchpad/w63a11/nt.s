	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon/game/common/newton.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	.align	2
	.globl	Newton_FindClosestQuad__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CalculateSliceYaw__Fi
	.align	2
	.globl	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_FindGroundElevationGeneral__FP8coorddefN20
	.align	2
	.globl	Newton_FindGroundElevationRough__FP8coorddefN20
	.align	2
	.globl	Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
	.align	2
	.globl	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	.align	2
	.globl	Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	.align	2
	.globl	Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	.align	2
	.globl	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	.align	2
	.globl	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	.align	2
	.globl	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	.align	2
	.globl	Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
	.align	2
	.globl	Newton_QDUpdateVel__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
	.align	2
	.globl	Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
	.align	2
	.globl	Newton_CalcRealShadowCoordinates__FP8Car_tObji
	.align	2
	.globl	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
	.align	2
	.globl	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	.align	2
	.globl	Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
	.align	2
	.globl	Newton_CalculateRoadPosition__FP13BO_tNewtonObj

	.lcomm	divTable,200

	.lcomm	fudgeTable,64

	.lcomm	swap,16

	.lcomm	testSimRoadInfo,132

	.lcomm	newtestSimRoadInfo,132

	.lcomm	dummy_124,12

	.lcomm	dummy_133,12

	.extern	gWSavePtr, 4
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	simGlobal, 24
	.extern	BWorldSm_slices, 4
	.extern	gNumSlices, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	GameSetup_gData, 2600
	.extern	AICop_spikeBelt, 20

	.text
	.text
	.ent	Newton_AddDamageZone__FP13BO_tNewtonObjiii
Newton_AddDamageZone__FP13BO_tNewtonObjiii:
	.frame	$sp,96,$31		# vars= 40, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$18,64($sp)
	move	$18,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$23,84($sp)
	move	$23,$6
	sw	$17,60($sp)
	move	$17,$7
	sw	$31,88($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	sw	$19,68($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L555
	lui	$2,%hi(GameSetup_gData+80) # high
	.set	macro
	.set	reorder

	lw	$4,400($18)
	jal	Force_HitWall__Fi
	lui	$2,%hi(GameSetup_gData+80) # high
$L555:
	lw	$2,%lo(GameSetup_gData+80)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L527
	li	$3,6553600			# 0x00640000
	.set	macro
	.set	reorder

	srl	$2,$16,31
	addu	$2,$16,$2
	sra	$4,$2,1
	move	$2,$3
	slt	$2,$2,$4
	bne	$2,$0,$L500
	move	$3,$4
$L500:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L501
	srl	$2,$3,31
	.set	macro
	.set	reorder

	addu	$2,$3,$2
	sra	$3,$2,1
$L501:
	sll	$2,$23,2
	addu	$6,$18,$2
	lw	$4,536($6)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L556
	slt	$2,$23,8
	.set	macro
	.set	reorder

	move	$3,$4
$L556:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L527
	sw	$3,536($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L504
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,536($18)
	lw	$3,544($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,540($18)
	move	$4,$2
	slt	$2,$4,$3
	beq	$2,$0,$L506
	move	$4,$3
$L506:
	lw	$2,536($18)
	lw	$3,560($18)
	.set	noreorder
	.set	nomacro
	j	$L554
	sw	$4,540($18)
	.set	macro
	.set	reorder

$L504:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L509
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$2,564($18)
	lw	$3,540($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,536($18)
	move	$4,$2
	slt	$2,$4,$3
	beq	$2,$0,$L511
	move	$4,$3
$L511:
	lw	$2,540($18)
	lw	$3,548($18)
	sw	$4,536($18)
	lw	$4,544($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L512
	move	$3,$4
$L512:
	.set	noreorder
	.set	nomacro
	j	$L527
	sw	$3,544($18)
	.set	macro
	.set	reorder

$L509:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L514
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lw	$2,552($18)
	lw	$3,560($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,556($18)
	move	$4,$2
	slt	$2,$4,$3
	beq	$2,$0,$L516
	move	$4,$3
$L516:
	lw	$2,536($18)
	lw	$3,560($18)
	sw	$4,556($18)
$L554:
	lw	$4,564($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L517
	move	$3,$4
$L517:
	.set	noreorder
	.set	nomacro
	j	$L527
	sw	$3,564($18)
	.set	macro
	.set	reorder

$L514:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L519
	addu	$2,$23,2
	.set	macro
	.set	reorder

	lw	$2,564($18)
	lw	$3,540($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,536($18)
	move	$4,$2
	slt	$2,$4,$3
	beq	$2,$0,$L521
	move	$4,$3
$L521:
	lw	$2,556($18)
	lw	$3,564($18)
	sw	$4,536($18)
	lw	$4,560($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L522
	move	$3,$4
$L522:
	.set	noreorder
	.set	nomacro
	j	$L527
	sw	$3,560($18)
	.set	macro
	.set	reorder

$L519:
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$2,536($2)
	#nop
	addu	$2,$3,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	addu	$2,$23,1
	sll	$2,$2,2
	addu	$5,$18,$2
	lw	$4,536($5)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L557
	addu	$2,$23,-2
	.set	macro
	.set	reorder

	move	$3,$4
$L557:
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$3,536($5)
	lw	$3,536($6)
	lw	$2,536($2)
	#nop
	addu	$3,$3,$2
	srl	$2,$3,31
	addu	$3,$3,$2
	addu	$2,$23,-1
	sll	$2,$2,2
	addu	$5,$18,$2
	lw	$4,536($5)
	sra	$3,$3,1
	slt	$2,$3,$4
	beq	$2,$0,$L526
	move	$3,$4
$L526:
	sw	$3,536($5)
$L527:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L496
	li	$22,131072			# 0x00020000
	.set	macro
	.set	reorder

	move	$21,$0
	li	$2,5898240			# 0x005a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L529
	move	$20,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L530
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$5,$16,3
$L530:
	sra	$16,$5,2
	li	$3,65536			# 0x00010000
	ori	$3,$3,0xffff
	lw	$4,392($18)
	li	$2,1			# 0x00000001
	sh	$2,380($18)
	li	$2,1			# 0x00000001
	sw	$0,428($18)
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L531
	sw	$2,1932($18)
	.set	macro
	.set	reorder

	lw	$2,164($18)
	li	$3,65536			# 0x00010000
	addu	$2,$2,$3
	sw	$2,164($18)
$L531:
	li	$2,1431633920			# 0x55550000
	ori	$2,$2,0x5556
	mult	$16,$2
	li	$4,786432			# 0x000c0000
	sra	$2,$5,31
	lw	$3,176($18)
	mfhi	$11
	#nop
	#nop
	subu	$2,$11,$2
	addu	$3,$3,$2
	move	$2,$4
	slt	$2,$2,$3
	bne	$2,$0,$L532
	move	$4,$3
$L532:
	sw	$4,176($18)
	.set	noreorder
	.set	nomacro
	bgez	$16,$L534
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$16,31
$L534:
	sra	$19,$4,5
	li	$2,39321			# 0x00009999
	slt	$2,$2,$19
	beq	$2,$0,$L535
	li	$19,39321			# 0x00009999
$L535:
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L536
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,176($18)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L558
	li	$2,1310720			# 0x00140000
	.set	macro
	.set	reorder

	sw	$3,176($18)
$L536:
	li	$2,1310720			# 0x00140000
$L558:
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L537
	li	$6,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lw	$3,fastRandom
	lw	$4,randSeed
	#nop
	mult	$3,$4
	mflo	$3
	#nop
	#nop
	andi	$8,$3,0xffff
	mult	$8,$4
	mflo	$5
	#nop
	#nop
	andi	$9,$5,0xffff
	mult	$9,$4
	ori	$6,$6,0xff00
	and	$2,$3,$6
	srl	$10,$2,8
	sw	$3,randtemp
	sw	$8,fastRandom
	mflo	$7
	#nop
	and	$2,$5,$6
	andi	$8,$7,0xffff
	mult	$8,$4
	srl	$2,$2,8
	sll	$3,$2,1
	addu	$21,$3,$2
	sw	$5,randtemp
	sw	$9,fastRandom
	and	$2,$7,$6
	srl	$2,$2,8
	sll	$3,$2,1
	addu	$20,$3,$2
	sw	$7,randtemp
	sw	$8,fastRandom
	mflo	$4
	#nop
	#nop
	andi	$2,$4,0xffff
	sw	$4,randtemp
	and	$4,$4,$6
	srl	$4,$4,8
	sltu	$4,$4,13107
	sw	$2,fastRandom
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L538
	sll	$22,$10,2
	.set	macro
	.set	reorder

	subu	$19,$0,$19
$L538:
	li	$3,196608			# 0x00030000
	ori	$3,$3,0xffff
	addu	$2,$22,$21
	addu	$2,$2,$20
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L559
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,65535			# 0x0000ffff
	slt	$2,$3,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L560
	slt	$2,$3,$21
	.set	macro
	.set	reorder

	sll	$22,$10,3
$L560:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L561
	slt	$2,$3,$20
	.set	macro
	.set	reorder

	sll	$21,$21,1
$L561:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L559
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sll	$20,$20,1
$L537:
	li	$2,2			# 0x00000002
$L559:
	bne	$17,$2,$L544
	sll	$22,$22,1
	sll	$21,$21,1
	.set	noreorder
	.set	nomacro
	j	$L544
	sll	$20,$20,1
	.set	macro
	.set	reorder

$L529:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	bgez	$5,$L562
	sra	$19,$5,6
	.set	macro
	.set	reorder

	addu	$5,$5,63
	sra	$19,$5,6
$L562:
	li	$2,32768			# 0x00008000
	slt	$2,$2,$19
	beq	$2,$0,$L544
	li	$19,32768			# 0x00008000
$L544:
	lw	$4,276($18)
	lw	$5,240($18)
	jal	fixedmult
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
	addu	$16,$16,$2
	sltu	$2,$23,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L547
	sw	$16,1068($18)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$22
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1060($18)
	sra	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$L552
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L547:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$22
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1060($18)
	sra	$3,$3,1
	addu	$2,$2,$3
$L552:
	sw	$2,1060($18)
	addu	$2,$23,-2
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L549
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$21
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$20
	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1064($18)
	sra	$3,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,1064($18)
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1068($18)
	sra	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$L553
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L549:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$21
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$20
	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1064($18)
	sra	$3,$3,1
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,1064($18)
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	lw	$2,1068($18)
	sra	$3,$3,1
	subu	$2,$2,$3
$L553:
	sw	$2,1068($18)
	addu	$4,$18,240
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$4,1060($18)
	lw	$5,16($sp)
	jal	fixedmult
	lw	$4,1064($18)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($18)
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1060($18)
	addu	$16,$16,$2
	sw	$16,276($18)
	lw	$5,28($sp)
	jal	fixedmult
	lw	$4,1064($18)
	lw	$5,32($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1060($18)
	addu	$16,$16,$2
	sw	$16,280($18)
	lw	$5,40($sp)
	jal	fixedmult
	lw	$4,1064($18)
	lw	$5,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($18)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,284($18)
$L496:
	lw	$31,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	.text
	.ent	Newton_FindClosestQuad__FP13BO_tNewtonObj
Newton_FindClosestQuad__FP13BO_tNewtonObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$5,$4
	addu	$4,$5,160
	addu	$5,$5,8
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Newton_FindClosestQuad__FP13BO_tNewtonObj
	.text
	.ent	Newton_CalculateSliceYaw__Fi
Newton_CalculateSliceYaw__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$5,gNumSlices
	addu	$3,$4,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L566
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L567
	move	$6,$3
	.set	macro
	.set	reorder

$L566:
	addu	$2,$5,-1
	subu	$6,$4,$2
$L567:
	lw	$3,BWorldSm_slices
	sll	$2,$4,5
	addu	$2,$2,$3
	lw	$4,0($2)
	lw	$5,8($2)
	sll	$2,$6,5
	addu	$2,$2,$3
	lw	$3,0($2)
	lw	$2,8($2)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	intatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Newton_CalculateSliceYaw__Fi
	.text
	.ent	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
Newton_UpdateRoadGeometry__FP13BO_tNewtonObj:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$22,56($sp)
	move	$22,$4
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lbu	$2,145($22)
	#nop
	beq	$2,$0,$L589
	lbu	$2,144($22)
	lh	$fp,8($22)
	sltu	$6,$2,2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L571
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$0,368($22)
	sw	$0,364($22)
	sw	$0,360($22)
$L572:
	slt	$2,$5,4
	beq	$2,$0,$L573
	lw	$2,128($22)
	#nop
	beq	$2,$0,$L576
	lw	$7,16($4)
	lw	$8,20($4)
	lw	$9,24($4)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	j	$L577
$L576:
	lh	$2,8($22)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
$L577:
	lw	$2,360($22)
	lw	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,360($22)
	lw	$2,364($22)
	lw	$3,20($sp)
	addu	$4,$4,12
	addu	$2,$2,$3
	sw	$2,364($22)
	lw	$2,368($22)
	lw	$3,24($sp)
	addu	$5,$5,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L572
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L573:
	lw	$2,360($22)
	#nop
	bgez	$2,$L578
	addu	$2,$2,3
$L578:
	lw	$4,364($22)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L579
	sw	$2,360($22)
	.set	macro
	.set	reorder

	addu	$4,$4,3
$L579:
	lw	$3,368($22)
	sra	$2,$4,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L580
	sw	$2,364($22)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L580:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L581
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L571:
	lw	$2,128($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L582
	sll	$2,$fp,5
	.set	macro
	.set	reorder

	lw	$7,16($22)
	lw	$8,20($22)
	lw	$9,24($22)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
	j	$L581
$L582:
	lw	$3,BWorldSm_slices
	#nop
	addu	$2,$2,$3
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
$L581:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L584
	sll	$3,$fp,5
	.set	macro
	.set	reorder

	lb	$2,97($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L586
	addu	$16,$22,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UNormal__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,336($22)
	sw	$8,340($22)
	sw	$9,344($22)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UForward__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,348($22)
	sw	$8,352($22)
	sw	$9,356($22)
	lw	$21,340($22)
	lw	$19,356($22)
	lw	$18,336($22)
	lw	$16,344($22)
	lw	$20,348($22)
	lw	$17,352($22)
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	move	$23,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$20
	subu	$2,$23,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,324($22)
	.set	macro
	.set	reorder

	move	$23,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$17
	subu	$2,$23,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,328($22)
	.set	macro
	.set	reorder

	move	$23,$2
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$20
	.set	macro
	.set	reorder

	subu	$2,$23,$2
	.set	noreorder
	.set	nomacro
	j	$L586
	sw	$2,332($22)
	.set	macro
	.set	reorder

$L584:
	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lb	$2,18($3)
	lb	$4,20($3)
	sll	$5,$2,9
	lb	$2,19($3)
	sll	$4,$4,9
	sw	$5,324($22)
	sw	$4,332($22)
	sll	$2,$2,9
	sw	$2,328($22)
	lb	$2,12($3)
	lb	$4,14($3)
	sll	$5,$2,9
	lb	$2,13($3)
	sll	$4,$4,9
	sw	$5,336($22)
	sw	$4,344($22)
	sll	$2,$2,9
	sw	$2,340($22)
	lb	$2,15($3)
	#nop
	sll	$5,$2,9
	lb	$2,16($3)
	lb	$3,17($3)
	sw	$5,348($22)
	sll	$2,$2,9
	sll	$4,$3,9
	sw	$2,352($22)
	sw	$4,356($22)
$L586:
	lw	$4,gNumSlices
	addu	$3,$fp,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L588
	move	$6,$3
	.set	macro
	.set	reorder

	addu	$2,$4,-1
	subu	$6,$fp,$2
$L588:
	lw	$3,BWorldSm_slices
	sll	$2,$fp,5
	addu	$2,$2,$3
	lw	$4,0($2)
	lw	$5,8($2)
	sll	$2,$6,5
	addu	$2,$2,$3
	lw	$3,0($2)
	lw	$2,8($2)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	intatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	sw	$2,376($22)
$L589:
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	.text
	.ent	Newton_FindGroundElevationGeneral__FP8coorddefN20
Newton_FindGroundElevationGeneral__FP8coorddefN20:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$8,$4
	sw	$16,16($sp)
	sw	$31,20($sp)
	lw	$7,4($5)
	li	$2,40632			# 0x00009eb8
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L591
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$6,0($5)
	li	$2,65536			# 0x00010000
	subu	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bgez	$6,$L592
	sra	$7,$2,9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L592:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L593
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L593:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L594
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L594:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L595
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L595:
	sra	$2,$2,8
	mult	$5,$2
	lui	$3,%hi(divTable) # high
	addiu	$3,$3,%lo(divTable) # low
	sll	$2,$7,2
	addu	$2,$2,$3
	lw	$5,0($2)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$9
	.set	macro
	.set	reorder

	j	$L601
$L591:
	lw	$6,0($5)
	#nop
	bgez	$6,$L597
	addu	$6,$6,255
$L597:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L598
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L598:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L599
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L599:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L600
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L600:
	sra	$2,$2,8
	mult	$5,$2
	move	$5,$7
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	subu	$4,$4,$9
	.set	macro
	.set	reorder

$L601:
	lw	$3,4($16)
	#nop
	addu	$2,$2,$3
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Newton_FindGroundElevationGeneral__FP8coorddefN20
	.text
	.ent	Newton_FindGroundElevationRough__FP8coorddefN20
Newton_FindGroundElevationRough__FP8coorddefN20:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$6,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L603
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L603:
	lw	$3,0($4)
	lw	$2,0($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L604
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L604:
	sra	$2,$2,8
	mult	$3,$2
	lw	$6,8($5)
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L605
	subu	$8,$0,$10
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L605:
	lw	$3,8($4)
	lw	$2,8($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L606
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L606:
	sra	$2,$2,8
	mult	$3,$2
	move	$7,$0
	lui	$2,%hi(fudgeTable) # high
	addiu	$9,$2,%lo(fudgeTable) # low
	mflo	$10
	#nop
	#nop
	subu	$8,$8,$10
$L607:
	bne	$7,$0,$L610
	lw	$2,0($4)
	lw	$3,8($4)
	.set	noreorder
	bgez	$2,1f
	move	$6,$2
	subu	$6,$0,$6
1:
	.set	reorder
	sra	$3,$3,1
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$6
	bne	$2,$0,$L620
	.set	noreorder
	.set	nomacro
	j	$L622
	sra	$2,$6,2
	.set	macro
	.set	reorder

$L610:
	lw	$2,0($4)
	lw	$3,8($4)
	sra	$2,$2,2
	.set	noreorder
	bgez	$2,1f
	move	$6,$2
	subu	$6,$0,$6
1:
	.set	reorder
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$6
	beq	$2,$0,$L614
$L620:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L613
	addu	$3,$6,$2
	.set	macro
	.set	reorder

$L614:
	sra	$2,$6,2
$L622:
	addu	$3,$3,$2
$L613:
	sra	$2,$3,15
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$3,$L616
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,31
$L616:
	sra	$2,$2,5
	sll	$2,$2,5
	subu	$2,$3,$2
	sll	$2,$2,1
	addu	$2,$2,$9
	lh	$2,0($2)
	addu	$7,$7,1
	sll	$2,$2,7
	addu	$16,$16,$2
	slt	$2,$7,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L607
	li	$2,40632			# 0x00009eb8
	.set	macro
	.set	reorder

	lw	$5,4($5)
	#nop
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	subu	$2,$2,$5
	sra	$2,$2,9
	lui	$3,%hi(divTable) # high
	addiu	$3,$3,%lo(divTable) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$8
	.set	macro
	.set	reorder

	j	$L621
$L618:
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$4,$8
	.set	macro
	.set	reorder

$L621:
	lw	$3,4($17)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,$16
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

	.end	Newton_FindGroundElevationRough__FP8coorddefN20
	.text
	.ent	Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,340($16)
	lw	$3,336($16)
	lw	$4,344($16)
	move	$17,$5
	sw	$2,4($17)
	slt	$2,$2,6554
	sw	$3,0($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	sw	$4,8($17)
	.set	macro
	.set	reorder

	addu	$4,$16,160
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationGeneral__FP8coorddefN20
	addu	$6,$16,360
	.set	macro
	.set	reorder

	lw	$4,160($16)
	lw	$5,168($16)
	move	$6,$2
	sw	$0,684($16)
	sw	$0,732($16)
	sw	$0,780($16)
	sw	$0,828($16)
	sw	$0,688($16)
	sw	$0,736($16)
	sw	$0,784($16)
	sw	$0,832($16)
	sw	$6,656($16)
	sw	$6,704($16)
	sw	$6,752($16)
	sw	$6,800($16)
	sw	$6,676($16)
	sw	$6,724($16)
	sw	$6,772($16)
	sw	$6,820($16)
	sw	$4,652($16)
	sw	$4,700($16)
	sw	$4,748($16)
	sw	$4,796($16)
	sw	$5,660($16)
	sw	$5,708($16)
	sw	$5,756($16)
	sw	$5,804($16)
	lw	$4,0($17)
	lw	$5,4($17)
	lw	$3,8($17)
	li	$2,1			# 0x00000001
	sw	$2,696($16)
	sw	$2,744($16)
	sw	$2,792($16)
	sw	$2,840($16)
	sw	$4,664($16)
	sw	$4,712($16)
	sw	$4,760($16)
	sw	$4,808($16)
	sw	$5,668($16)
	sw	$5,716($16)
	sw	$5,764($16)
	sw	$5,812($16)
	sw	$3,672($16)
	sw	$3,720($16)
	sw	$3,768($16)
	.set	noreorder
	.set	nomacro
	j	$L625
	sw	$3,816($16)
	.set	macro
	.set	reorder

$L624:
	li	$6,-2097152000			# 0x83000000
$L625:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$6
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
	.text
	.ent	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef:
	.frame	$sp,448,$31		# vars= 392, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,448
	sw	$20,424($sp)
	move	$20,$4
	sw	$31,444($sp)
	sw	$fp,440($sp)
	sw	$23,436($sp)
	sw	$22,432($sp)
	sw	$21,428($sp)
	sw	$19,420($sp)
	sw	$18,416($sp)
	sw	$17,412($sp)
	sw	$16,408($sp)
	lw	$2,252($20)
	lw	$3,256($20)
	lw	$4,260($20)
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$2,80($sp)
	sw	$3,84($sp)
	sw	$4,88($sp)
	lw	$2,316($20)
	lw	$14,264($20)
	sll	$9,$2,1
	addu	$9,$9,$2
	sll	$9,$9,2
	addu	$9,$9,$2
	sra	$9,$9,12
	sra	$14,$14,8
	mult	$9,$14
	lw	$13,268($20)
	mflo	$14
	#nop
	sra	$13,$13,8
	mult	$9,$13
	lw	$2,272($20)
	mflo	$13
	#nop
	sra	$2,$2,8
	mult	$9,$2
	sw	$14,96($sp)
	sw	$13,100($sp)
	mflo	$9
	#nop
	#nop
	sw	$9,104($sp)
	lw	$2,308($20)
	lw	$12,240($20)
	sll	$10,$2,3
	subu	$10,$10,$2
	sra	$10,$10,11
	sra	$12,$12,8
	mult	$10,$12
	lw	$11,244($20)
	mflo	$12
	#nop
	sra	$11,$11,8
	mult	$10,$11
	lw	$2,248($20)
	mflo	$11
	#nop
	sra	$2,$2,8
	mult	$10,$2
	move	$fp,$5
	sw	$12,112($sp)
	sw	$11,116($sp)
	mflo	$10
	#nop
	#nop
	sw	$10,120($sp)
	lw	$3,312($20)
	lw	$5,252($20)
	subu	$3,$0,$3
	sra	$3,$3,8
	sra	$5,$5,8
	mult	$3,$5
	lw	$4,256($20)
	mflo	$5
	#nop
	sra	$4,$4,8
	mult	$3,$4
	lw	$2,260($20)
	mflo	$4
	#nop
	sra	$2,$2,8
	mult	$3,$2
	move	$23,$0
	move	$21,$23
	addu	$16,$sp,160
	addu	$18,$20,8
	addu	$17,$20,136
	sw	$5,144($sp)
	sw	$4,148($sp)
	mflo	$3
	#nop
	#nop
	sw	$3,152($sp)
	lw	$6,160($20)
	lw	$7,164($20)
	lw	$8,168($20)
	addu	$6,$6,$5
	addu	$7,$7,$4
	addu	$8,$8,$3
	addu	$5,$6,$14
	subu	$2,$5,$12
	addu	$4,$7,$13
	sw	$6,128($sp)
	sw	$2,32($sp)
	subu	$2,$4,$11
	addu	$3,$8,$9
	sw	$2,36($sp)
	subu	$2,$3,$10
	addu	$5,$5,$12
	addu	$4,$4,$11
	addu	$3,$3,$10
	subu	$6,$6,$14
	sw	$2,40($sp)
	subu	$2,$6,$12
	sw	$7,132($sp)
	subu	$7,$7,$13
	sw	$2,56($sp)
	subu	$2,$7,$11
	sw	$8,136($sp)
	subu	$8,$8,$9
	sw	$2,60($sp)
	subu	$2,$8,$10
	addu	$6,$6,$12
	addu	$7,$7,$11
	addu	$8,$8,$10
	sw	$5,44($sp)
	sw	$4,48($sp)
	sw	$3,52($sp)
	sw	$2,64($sp)
	sw	$6,68($sp)
	sw	$7,72($sp)
	sw	$8,76($sp)
$L627:
	lw	$15,0($18)
	lw	$22,4($18)
	lw	$24,8($18)
	lw	$25,12($18)
	sw	$15,0($16)
	sw	$22,4($16)
	sw	$24,8($16)
	sw	$25,12($16)
	addu	$18,$18,16
	.set	noreorder
	.set	nomacro
	bne	$18,$17,$L627
	addu	$16,$16,16
	.set	macro
	.set	reorder

	lw	$15,0($18)
	sw	$15,0($16)
	move	$19,$20
	addu	$18,$sp,96
	addu	$17,$sp,32
$L628:
	addu	$2,$20,192
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$sp,160
	move	$5,$16
	lw	$15,0($17)
	lw	$22,4($17)
	lw	$24,8($17)
	sw	$15,0($18)
	sw	$22,4($18)
	sw	$24,8($18)
	lw	$2,4($17)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
	sw	$2,676($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UNormal__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$15,0($2)
	lw	$22,4($2)
	lw	$24,8($2)
	sw	$15,296($sp)
	sw	$22,300($sp)
	sw	$24,304($sp)
	lw	$2,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	li	$4,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$4,0($2)
$L632:
	sw	$4,696($19)
	lw	$2,300($sp)
	#nop
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	andi	$4,$4,0x000f
	.set	macro
	.set	reorder

	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L719
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	bne	$4,$0,$L633
$L634:
	li	$2,65536			# 0x00010000
$L719:
	sw	$2,300($sp)
	lw	$2,16($sp)
	sw	$0,296($sp)
	sw	$0,304($sp)
	lw	$3,0($17)
	#nop
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$3,4($17)
	lw	$4,392($20)
	lw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L708
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L633:
	lw	$2,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	addu	$2,$4,-2
	.set	macro
	.set	reorder

	lw	$15,168($sp)
	lw	$22,172($sp)
	lw	$24,176($sp)
	sw	$15,312($sp)
	sw	$22,316($sp)
	sw	$24,320($sp)
	.set	noreorder
	.set	nomacro
	j	$L724
	sltu	$2,$2,2
	.set	macro
	.set	reorder

$L636:
	lh	$2,160($sp)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$15,0($2)
	lw	$22,4($2)
	lw	$24,8($2)
	sw	$15,312($sp)
	sw	$22,316($sp)
	sw	$24,320($sp)
	addu	$2,$4,-2
	sltu	$2,$2,2
$L724:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$5,$sp,296
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationRough__FP8coorddefN20
	addu	$6,$sp,312
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L717
	sw	$2,4($18)
	.set	macro
	.set	reorder

$L638:
	addu	$5,$sp,296
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationGeneral__FP8coorddefN20
	addu	$6,$sp,312
	.set	macro
	.set	reorder

	sw	$2,4($18)
$L717:
	lw	$2,4($18)
	#nop
	sw	$2,676($19)
	lw	$5,4($18)
	lw	$3,4($17)
	li	$2,131072			# 0x00020000
	subu	$3,$5,$3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	sw	$0,296($sp)
	sw	$2,300($sp)
	sw	$0,304($sp)
	lw	$2,4($17)
	#nop
	sw	$2,4($18)
	lw	$2,16($sp)
	lw	$3,0($17)
	#nop
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,20($sp)
	lw	$3,4($17)
$L708:
	addu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,24($sp)
	lw	$3,8($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L640:
	lw	$3,0($18)
	lw	$2,16($sp)
	lw	$4,8($18)
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,20($sp)
	lw	$3,24($sp)
	addu	$2,$2,$5
	addu	$3,$3,$4
	sw	$2,20($sp)
	sw	$3,24($sp)
$L635:
	lw	$2,0($18)
	lw	$3,4($18)
	lw	$4,8($18)
	addu	$18,$18,12
	sw	$2,652($19)
	sw	$3,656($19)
	sw	$4,660($19)
	lw	$2,296($sp)
	lw	$3,300($sp)
	lw	$4,304($sp)
	addu	$17,$17,12
	sw	$2,664($19)
	sw	$3,668($19)
	sw	$4,672($19)
	.set	noreorder
	.set	nomacro
	j	$L628
	addu	$19,$19,48
	.set	macro
	.set	reorder

$L629:
	move	$7,$0
	li	$9,1			# 0x00000001
	move	$5,$20
	move	$8,$7
	sw	$0,400($sp)
	sw	$0,296($sp)
	sw	$0,304($sp)
$L642:
	slt	$2,$7,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	addu	$3,$sp,$8
	.set	macro
	.set	reorder

	lw	$2,656($5)
	lw	$3,36($3)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,300($sp)
	sw	$0,688($5)
	lw	$3,300($sp)
	#nop
	slt	$2,$3,-9829
	beq	$2,$0,$L646
	sw	$9,684($5)
	.set	noreorder
	.set	nomacro
	j	$L647
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L646:
	lw	$2,684($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$9,$L720
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	blez	$3,$L649
	addu	$21,$21,1
	sw	$0,684($5)
	.set	noreorder
	.set	nomacro
	j	$L720
	sw	$9,688($5)
	.set	macro
	.set	reorder

$L649:
	lw	$2,392($20)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$2,176($20)
	#nop
	slt	$2,$2,-6552
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$3,300($20)
	li	$2,62259			# 0x0000f333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	sw	$0,684($5)
$L647:
	li	$2,3473408			# 0x00350000
$L720:
	lw	$3,192($20)
	ori	$2,$2,0x8000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	li	$4,-13107			# 0xffffcccd
	.set	macro
	.set	reorder

	li	$4,-9830			# 0xffffd99a
$L652:
	lw	$2,300($sp)
	#nop
	slt	$2,$2,$4
	beq	$2,$0,$L653
	sw	$4,300($sp)
$L653:
	lw	$4,300($sp)
	sll	$3,$7,2
	addu	$2,$sp,328
	.set	noreorder
	.set	nomacro
	bgez	$4,$L654
	addu	$6,$2,$3
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L654:
	lw	$2,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L655
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L655:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L656
	sw	$2,0($6)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L656:
	lw	$2,1124($20)
	#nop
	lw	$2,312($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L657
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L657:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	sw	$3,680($5)
	lw	$2,648($20)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$9,$L644
	sll	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,680($5)
$L644:
	addu	$5,$5,48
	addu	$8,$8,12
	.set	noreorder
	.set	nomacro
	j	$L642
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L643:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L721
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$2,688($20)
	lw	$3,736($20)
	#nop
	addu	$2,$2,$3
	lw	$3,784($20)
	lw	$4,832($20)
	addu	$2,$2,$3
	addu	$2,$2,$4
	sw	$2,400($sp)
$L721:
	move	$18,$20
$L660:
	slt	$2,$19,4
	beq	$2,$0,$L661
	bne	$21,$0,$L707
	lw	$4,680($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L664
	li	$2,56360			# 0x0000dc28
	.set	macro
	.set	reorder

	lw	$3,300($20)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L666
	sra	$2,$4,1
	.set	macro
	.set	reorder

$L664:
	beq	$21,$0,$L662
$L707:
	lw	$2,688($18)
	#nop
	beq	$2,$0,$L662
	lw	$2,176($20)
	#nop
	bgez	$2,$L662
	lw	$3,388($20)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$16,$2,$3
	bltz	$16,$L662
	lw	$15,400($sp)
	#nop
	div	$3,$16,$15
	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L669
	sra	$17,$3,1
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,4096			# 0x00001000
	.set	macro
	.set	reorder

	slt	$2,$2,19661
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	li	$2,19660			# 0x00004ccc
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,4096			# 0x00001000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L718
	move	$4,$2
	.set	macro
	.set	reorder

$L670:
	move	$4,$2
$L718:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$17,$2
$L669:
	lw	$2,680($18)
	#nop
	addu	$2,$2,$17
$L666:
	sw	$2,680($18)
$L662:
	addu	$18,$18,48
	.set	noreorder
	.set	nomacro
	j	$L660
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L661:
	move	$18,$0
	lui	$2,%hi(swap) # high
	addiu	$17,$2,%lo(swap) # low
	move	$16,$18
$L673:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	addu	$2,$sp,$16
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$4,36($2)
	lw	$2,100($3)
	lw	$5,256($20)
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,1
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	blez	$5,$L677
	move	$3,$5
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$4,336($2)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L679
	move	$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L710
	move	$3,$4
	.set	macro
	.set	reorder

$L677:
	lw	$2,1124($20)
	#nop
	lw	$2,336($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$5,$3
	beq	$2,$0,$L679
$L710:
	move	$5,$3
$L679:
	lw	$3,0($17)
	addu	$17,$17,4
	addu	$16,$16,12
	addu	$18,$18,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	j	$L673
	sw	$5,692($2)
	.set	macro
	.set	reorder

$L674:
	addu	$4,$sp,344
	lw	$2,16($sp)
	lw	$3,24($sp)
	lw	$6,108($sp)
	lw	$5,132($sp)
	sra	$2,$2,2
	sw	$2,16($sp)
	lw	$2,20($sp)
	sra	$3,$3,2
	sw	$3,24($sp)
	lw	$3,120($sp)
	sra	$2,$2,2
	addu	$3,$3,$5
	sw	$2,20($sp)
	lw	$2,96($sp)
	lw	$5,136($sp)
	addu	$2,$2,$6
	subu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,344($sp)
	lw	$2,100($sp)
	lw	$6,112($sp)
	lw	$3,124($sp)
	addu	$2,$2,$6
	addu	$3,$3,$5
	subu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,348($sp)
	lw	$2,104($sp)
	lw	$6,116($sp)
	lw	$3,128($sp)
	lw	$5,140($sp)
	addu	$2,$2,$6
	addu	$3,$3,$5
	subu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,352($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,296
	lw	$2,108($sp)
	lw	$6,132($sp)
	lw	$3,96($sp)
	lw	$5,120($sp)
	addu	$2,$2,$6
	addu	$3,$3,$5
	subu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,296($sp)
	lw	$2,112($sp)
	lw	$6,136($sp)
	lw	$3,100($sp)
	lw	$5,124($sp)
	addu	$2,$2,$6
	addu	$3,$3,$5
	subu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,300($sp)
	lw	$2,116($sp)
	lw	$6,140($sp)
	lw	$3,104($sp)
	lw	$5,128($sp)
	addu	$2,$2,$6
	addu	$3,$3,$5
	subu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,304($sp)
	.set	macro
	.set	reorder

	lw	$4,348($sp)
	lw	$5,304($sp)
	jal	fixedmult
	lw	$4,352($sp)
	lw	$5,300($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,352($sp)
	lw	$5,296($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,312($sp)
	.set	macro
	.set	reorder

	lw	$4,344($sp)
	lw	$5,304($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,344($sp)
	lw	$5,300($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,316($sp)
	.set	macro
	.set	reorder

	lw	$4,348($sp)
	lw	$5,296($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,312
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$16,320($sp)
	.set	macro
	.set	reorder

	lw	$2,316($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L681
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$2,312($sp)
	#nop
	sw	$2,0($fp)
	lw	$2,316($sp)
	#nop
	sw	$2,4($fp)
	lw	$2,320($sp)
	#nop
	sw	$2,8($fp)
	lw	$3,316($sp)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L722
	li	$3,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L722
	li	$23,4			# 0x00000004
	.set	macro
	.set	reorder

$L681:
	li	$23,4			# 0x00000004
	sw	$0,0($fp)
	sw	$2,4($fp)
	sw	$0,8($fp)
	li	$3,-65536			# 0xffff0000
$L722:
	lw	$2,300($20)
	ori	$3,$3,0x199a
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L684
	slt	$2,$23,4
	.set	macro
	.set	reorder

	lw	$3,276($20)
	#nop
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L685
	addu	$2,$2,255
$L685:
	lw	$3,280($20)
	sra	$2,$2,8
	sw	$2,276($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L686
	addu	$2,$2,255
$L686:
	lw	$3,284($20)
	sra	$2,$2,8
	sw	$2,280($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L687
	addu	$2,$2,255
$L687:
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	j	$L688
	sw	$2,284($20)
	.set	macro
	.set	reorder

$L684:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$4,276($20)
	lw	$5,240($20)
	jal	fixedmult
	lw	$4,280($20)
	lw	$5,244($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($20)
	lw	$5,248($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($20)
	lw	$5,252($20)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1060($20)
	.set	macro
	.set	reorder

	lw	$4,280($20)
	lw	$5,256($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($20)
	lw	$5,260($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($20)
	lw	$5,264($20)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1064($20)
	.set	macro
	.set	reorder

	lw	$4,280($20)
	lw	$5,268($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($20)
	lw	$5,272($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,776($20)
	lw	$5,824($20)
	lw	$2,680($20)
	lw	$4,728($20)
	addu	$3,$3,$5
	addu	$2,$2,$4
	subu	$3,$3,$2
	sra	$17,$3,2
	.set	noreorder
	.set	nomacro
	blez	$17,$L690
	sw	$16,1068($20)
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$2,316($2)
	#nop
	move	$3,$2
	slt	$2,$3,$17
	bne	$2,$0,$L694
	.set	noreorder
	.set	nomacro
	j	$L694
	move	$3,$17
	.set	macro
	.set	reorder

$L690:
	lw	$2,1124($20)
	#nop
	lw	$2,316($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$3,$17
	beq	$2,$0,$L694
	move	$3,$17
$L694:
	move	$17,$3
	lw	$3,680($20)
	lw	$5,776($20)
	lw	$2,728($20)
	lw	$4,824($20)
	addu	$3,$3,$5
	addu	$2,$2,$4
	subu	$3,$3,$2
	sra	$16,$3,2
	blez	$16,$L695
	lw	$2,1124($20)
	#nop
	lw	$2,320($2)
	#nop
	move	$3,$2
	slt	$2,$3,$16
	bne	$2,$0,$L699
	.set	noreorder
	.set	nomacro
	j	$L699
	move	$3,$16
	.set	macro
	.set	reorder

$L695:
	lw	$2,1124($20)
	#nop
	lw	$2,320($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$3,$16
	beq	$2,$0,$L699
	move	$3,$16
$L699:
	move	$16,$3
	li	$3,65536			# 0x00010000
	lw	$4,1060($20)
	ori	$3,$3,0x3332
	.set	noreorder
	bgez	$4,1f
	move	$2,$4
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L700
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$5,304($2)
$L700:
	jal	fixedmult
	sw	$2,1060($20)
	li	$2,65536			# 0x00010000
	ori	$2,$2,0x3332
	lw	$3,1060($20)
	lw	$4,1068($20)
	addu	$3,$3,$17
	sw	$3,1060($20)
	.set	noreorder
	bgez	$4,1f
	move	$3,$4
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L702
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$5,308($2)
$L702:
	jal	fixedmult
	sw	$2,1068($20)
	addu	$4,$20,240
	lw	$2,1068($20)
	addu	$5,$sp,360
	subu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	transpose
	sw	$2,1068($20)
	.set	macro
	.set	reorder

	lw	$4,1060($20)
	lw	$5,360($sp)
	jal	fixedmult
	lw	$4,1064($20)
	lw	$5,364($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($20)
	lw	$5,368($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1060($20)
	addu	$16,$16,$2
	sw	$16,276($20)
	lw	$5,372($sp)
	jal	fixedmult
	lw	$4,1064($20)
	lw	$5,376($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($20)
	lw	$5,380($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1060($20)
	addu	$16,$16,$2
	sw	$16,280($20)
	lw	$5,384($sp)
	jal	fixedmult
	lw	$4,1064($20)
	lw	$5,388($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1068($20)
	lw	$5,392($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,284($20)
$L688:
	lui	$2,%hi(simGlobal+4) # high
$L723:
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L704
	move	$4,$20
	.set	macro
	.set	reorder

	move	$5,$fp
	.set	noreorder
	.set	nomacro
	j	$L713
	addu	$6,$20,360
	.set	macro
	.set	reorder

$L704:
	move	$5,$fp
	addu	$6,$sp,16
$L713:
	jal	Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	sw	$2,392($20)
	lw	$2,20($sp)
	lw	$31,444($sp)
	lw	$fp,440($sp)
	lw	$23,436($sp)
	lw	$22,432($sp)
	lw	$21,428($sp)
	lw	$20,424($sp)
	lw	$19,420($sp)
	lw	$18,416($sp)
	lw	$17,412($sp)
	lw	$16,408($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,448
	.set	macro
	.set	reorder

	.end	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	.text
	.ent	Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_DoBarrierCheck__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L725
	move	$4,$16
	sw	$0,400($16)
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	sw	$0,404($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

$L725:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
	.text
	.ent	Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L729
	subu	$sp,$sp,32
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L729:
	lw	$2,240($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L730
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L730:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L731
	addu	$3,$3,255
$L731:
	lw	$2,244($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L732
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L732:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L733
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L733:
	lw	$2,248($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L734
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L734:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L735
	addu	$3,$3,255
$L735:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L736
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L736:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	sw	$15,0($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L737
	addu	$3,$3,255
$L737:
	lw	$2,252($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L738
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L738:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L739
	addu	$3,$3,255
$L739:
	lw	$2,256($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L740
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L740:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L741
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L741:
	lw	$2,260($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L742
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L742:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L743
	addu	$3,$3,255
$L743:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L744
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L744:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sw	$8,4($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L745
	addu	$3,$3,255
$L745:
	lw	$2,264($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L746
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L746:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L747
	addu	$3,$3,255
$L747:
	lw	$2,268($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L748
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L748:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L749
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L749:
	lw	$2,272($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L750
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L750:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L751
	addu	$3,$3,255
$L751:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L752
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L752:
	sra	$2,$2,8
	mult	$3,$2
	li	$13,-1			# 0xffffffff
	lw	$14,0($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$14,$L753
	sw	$9,8($sp)
	.set	macro
	.set	reorder

	li	$13,1			# 0x00000001
$L753:
	.set	noreorder
	.set	nomacro
	bgez	$8,$L754
	li	$12,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$12,1			# 0x00000001
$L754:
	.set	noreorder
	.set	nomacro
	bgez	$9,$L755
	li	$11,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
$L755:
	lw	$3,160($4)
	lw	$2,0($6)
	#nop
	subu	$7,$3,$2
	sw	$7,16($sp)
	lw	$3,164($4)
	lw	$2,4($6)
	#nop
	subu	$8,$3,$2
	sw	$8,20($sp)
	lw	$3,168($4)
	lw	$2,8($6)
	#nop
	subu	$10,$3,$2
	sw	$10,24($sp)
	lw	$4,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L763
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L763:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L757
	sra	$6,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L757:
	sra	$2,$2,8
	mult	$6,$2
	lw	$4,4($5)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L764
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L764:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L759
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L759:
	sra	$2,$2,8
	mult	$4,$2
	lw	$5,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L760
	addu	$3,$6,$15
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L760:
	move	$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$2,$L761
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L761:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$5
	#nop
	#nop
	mult	$13,$14
	mflo	$6
	#nop
	lw	$2,4($sp)
	#nop
	mult	$12,$2
	mflo	$7
	#nop
	#nop
	mult	$11,$9
	addu	$3,$3,$5
	addu	$2,$6,$7
	mflo	$4
	#nop
	#nop
	addu	$2,$2,$4
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	.text
	.ent	Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1:
	.frame	$sp,48,$31		# vars= 16, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,40($sp)
	move	$18,$4
	sw	$17,36($sp)
	move	$17,$5
	sw	$31,44($sp)
	sw	$16,32($sp)
	lw	$5,160($18)
	lw	$2,0($6)
	#nop
	subu	$5,$5,$2
	sw	$5,16($sp)
	lw	$2,164($18)
	lw	$3,4($6)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,168($18)
	lw	$3,8($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$4,0($17)
	jal	fixedmult
	lw	$4,4($17)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($17)
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,300($18)
	li	$2,45875			# 0x0000b333
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	bne	$2,$0,$L766
	lw	$2,308($18)
	.set	noreorder
	.set	nomacro
	j	$L770
	subu	$2,$16,$2
	.set	macro
	.set	reorder

$L766:
	lw	$2,312($18)
	#nop
	subu	$2,$16,$2
$L770:
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

	.end	Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	.text
	.ent	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	move	$6,$0
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lui	$2,%hi(GameSetup_gData+28) # high
	lw	$2,%lo(GameSetup_gData+28)($2)
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	lw	$5,160($16)
	lw	$3,160($2)
	#nop
	subu	$4,$5,$3
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L772
	move	$18,$6
	.set	macro
	.set	reorder

	subu	$4,$3,$5
$L772:
	lw	$5,168($16)
	lw	$2,168($2)
	#nop
	subu	$3,$5,$2
	bgtz	$3,$L773
	subu	$3,$2,$5
$L773:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L774
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L796
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L774:
	sra	$2,$4,2
	addu	$2,$3,$2
$L796:
	sw	$2,140($16)
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L776
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	lui	$2,%hi(GameSetup_gData+28) # high
	lw	$4,%lo(GameSetup_gData+28)($2)
	li	$2,1			# 0x00000001
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	lw	$5,160($16)
	lw	$3,160($2)
	#nop
	subu	$4,$5,$3
	bgtz	$4,$L777
	subu	$4,$3,$5
$L777:
	lw	$5,168($16)
	lw	$2,168($2)
	#nop
	subu	$3,$5,$2
	bgtz	$3,$L778
	subu	$3,$2,$5
$L778:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L779
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L780
	addu	$3,$4,$2
	.set	macro
	.set	reorder

$L779:
	sra	$2,$4,2
	addu	$3,$3,$2
$L780:
	lw	$2,140($16)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L776
	li	$6,1			# 0x00000001
	sw	$3,140($16)
$L776:
	lw	$2,140($16)
	li	$17,6291456			# 0x00600000
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L785
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	sll	$3,$6,2
	addu	$3,$3,$2
	lw	$4,0($3)
	addu	$5,$16,8
	.set	noreorder
	.set	nomacro
	jal	BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
	addu	$4,$4,8
	.set	macro
	.set	reorder

	bne	$2,$0,$L782
	li	$18,1			# 0x00000001
$L782:
	lw	$2,140($16)
	#nop
	slt	$2,$17,$2
	bne	$2,$0,$L785
	beq	$18,$0,$L784
$L785:
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L787
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L784
$L787:
	lbu	$2,144($16)
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L788
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,444($16)
	sw	$2,448($16)
$L788:
	sb	$3,144($16)
	sw	$0,276($16)
	.set	noreorder
	.set	nomacro
	j	$L771
	sw	$0,284($16)
	.set	macro
	.set	reorder

$L784:
	lw	$2,608($16)
	lbu	$4,144($16)
	andi	$2,$2,0x0030
	bne	$2,$0,$L789
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L790
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L789
$L790:
	lw	$3,140($16)
	li	$2,4718592			# 0x00480000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L789
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L791
	sb	$2,144($16)
	.set	macro
	.set	reorder

$L789:
	sb	$0,144($16)
$L791:
	slt	$2,$4,2
	bne	$2,$0,$L771
	.set	noreorder
	.set	nomacro
	jal	Cars_SetCarUpForHiRezSim__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$16
	lui	$5,%hi(dummy_124) # high
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_124) # low
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$2,384($16)
	.set	macro
	.set	reorder

	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	j	$L794
$L793:
	lui	$5,%hi(dummy_124) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_124) # low
	.set	macro
	.set	reorder

	sw	$2,384($16)
$L794:
	lw	$2,384($16)
	lw	$4,312($16)
	li	$3,1			# 0x00000001
	sw	$3,444($16)
	sw	$3,448($16)
	sw	$0,388($16)
	sw	$0,400($16)
	sw	$0,404($16)
	sw	$0,392($16)
	addu	$2,$2,$4
	sw	$2,164($16)
$L771:
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

	.end	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.text
	.ent	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
Newton_UpdateRoadInfo__FP13BO_tNewtonObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lbu	$2,145($16)
	#nop
	beq	$2,$0,$L797
	jal	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	lb	$2,97($16)
	#nop
	beq	$2,$0,$L799
	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

$L799:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L797
	lw	$3,128($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L801
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($3)
$L801:
	sw	$2,444($16)
	andi	$2,$2,0x000f
	sw	$2,448($16)
$L797:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
	.text
	.ent	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L804
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,240
	addu	$2,$4,324
	addu	$3,$4,356
$L805:
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	lw	$9,12($2)
	sw	$6,0($5)
	sw	$7,4($5)
	sw	$8,8($5)
	sw	$9,12($5)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L805
	addu	$5,$5,16
	.set	macro
	.set	reorder

	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,0($5)
	.set	macro
	.set	reorder

$L804:
	lw	$2,324($4)
	#nop
	subu	$2,$0,$2
	sw	$2,240($4)
	lw	$2,4($3)
	addu	$4,$4,240
	subu	$2,$0,$2
	sw	$2,4($4)
	lw	$2,8($3)
	#nop
	subu	$2,$0,$2
	sw	$2,8($4)
	lw	$2,12($3)
	#nop
	sw	$2,12($4)
	lw	$2,16($3)
	#nop
	sw	$2,16($4)
	lw	$2,20($3)
	#nop
	sw	$2,20($4)
	lw	$2,24($3)
	#nop
	subu	$2,$0,$2
	sw	$2,24($4)
	lw	$2,28($3)
	#nop
	subu	$2,$0,$2
	sw	$2,28($4)
	lw	$2,32($3)
	#nop
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,32($4)
	.set	macro
	.set	reorder

	.end	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	.text
	.ent	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L808
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,452
	addu	$2,$4,324
	addu	$3,$4,356
$L809:
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	lw	$9,12($2)
	sw	$6,0($5)
	sw	$7,4($5)
	sw	$8,8($5)
	sw	$9,12($5)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L809
	addu	$5,$5,16
	.set	macro
	.set	reorder

	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,0($5)
	.set	macro
	.set	reorder

$L808:
	lw	$2,324($4)
	#nop
	subu	$2,$0,$2
	sw	$2,452($4)
	lw	$2,4($3)
	addu	$4,$4,452
	subu	$2,$0,$2
	sw	$2,4($4)
	lw	$2,8($3)
	#nop
	subu	$2,$0,$2
	sw	$2,8($4)
	lw	$2,12($3)
	#nop
	sw	$2,12($4)
	lw	$2,16($3)
	#nop
	sw	$2,16($4)
	lw	$2,20($3)
	#nop
	sw	$2,20($4)
	lw	$2,24($3)
	#nop
	subu	$2,$0,$2
	sw	$2,24($4)
	lw	$2,28($3)
	#nop
	subu	$2,$0,$2
	sw	$2,28($4)
	lw	$2,32($3)
	#nop
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,32($4)
	.set	macro
	.set	reorder

	.end	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	.text
	.ent	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi:
	.frame	$sp,120,$31		# vars= 72, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$20,104($sp)
	move	$20,$4
	sw	$22,112($sp)
	move	$22,$5
	sw	$18,96($sp)
	move	$18,$6
	move	$4,$22
	addu	$5,$20,8
	xori	$7,$7,0x0001
	sw	$21,108($sp)
	sltu	$21,$0,$7
	sw	$31,116($sp)
	sw	$19,100($sp)
	sw	$17,92($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	sw	$16,88($sp)
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sll	$19,$22,5
	sh	$22,6($20)
	addu	$3,$19,$3
	lb	$2,18($3)
	#nop
	sll	$2,$2,9
	sw	$2,324($20)
	lb	$2,19($3)
	#nop
	sll	$2,$2,9
	sw	$2,328($20)
	lb	$2,20($3)
	#nop
	sll	$2,$2,9
	sw	$2,332($20)
	lb	$2,12($3)
	#nop
	sll	$2,$2,9
	sw	$2,336($20)
	lb	$2,13($3)
	#nop
	sll	$2,$2,9
	sw	$2,340($20)
	lb	$2,14($3)
	#nop
	sll	$2,$2,9
	sw	$2,344($20)
	lb	$2,15($3)
	#nop
	sll	$2,$2,9
	sw	$2,348($20)
	lb	$2,16($3)
	addu	$16,$20,324
	sll	$2,$2,9
	sw	$2,352($20)
	lb	$2,17($3)
	move	$4,$16
	sll	$2,$2,9
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,356($20)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$20,336
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$20,348
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	move	$5,$21
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	move	$5,$21
	.set	macro
	.set	reorder

	lw	$4,0($18)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
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
	lw	$4,0($18)
	lw	$5,44($sp)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
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
	lw	$4,0($18)
	lw	$5,56($sp)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$3,BWorldSm_slices
	lw	$2,16($sp)
	sw	$16,24($sp)
	addu	$19,$19,$3
	lw	$3,0($19)
	#nop
	addu	$2,$2,$3
	sw	$2,160($20)
	lw	$2,20($sp)
	lw	$3,4($19)
	#nop
	addu	$2,$2,$3
	sw	$2,164($20)
	lw	$2,24($sp)
	lw	$4,8($19)
	lw	$3,608($20)
	addu	$2,$2,$4
	andi	$3,$3,0x0004
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L812
	sw	$2,168($20)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L813
	sb	$0,144($20)
	.set	macro
	.set	reorder

$L812:
	li	$2,2			# 0x00000002
	sb	$2,144($20)
$L813:
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$20
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	move	$5,$21
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	move	$5,$21
	.set	macro
	.set	reorder

	lbu	$3,144($20)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L814
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	sll	$3,$22,5
	addu	$3,$3,$2
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L815
	sw	$2,384($20)
	.set	macro
	.set	reorder

$L814:
	.set	noreorder
	.set	nomacro
	bne	$3,$16,$L816
	move	$4,$0
	.set	macro
	.set	reorder

	move	$6,$4
	move	$5,$20
$L817:
	slt	$2,$6,4
	beq	$2,$0,$L818
	lw	$2,128($20)
	#nop
	beq	$2,$0,$L821
	lw	$8,16($5)
	lw	$9,20($5)
	lw	$10,24($5)
	sw	$8,72($sp)
	sw	$9,76($sp)
	sw	$10,80($sp)
	.set	noreorder
	.set	nomacro
	j	$L832
	addu	$5,$5,12
	.set	macro
	.set	reorder

$L821:
	lh	$2,8($20)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,72($sp)
	sw	$9,76($sp)
	sw	$10,80($sp)
	addu	$5,$5,12
$L832:
	lw	$2,76($sp)
	addu	$6,$6,1
	.set	noreorder
	.set	nomacro
	j	$L817
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L818:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L823
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,3
$L823:
	sra	$4,$2,2
	.set	noreorder
	.set	nomacro
	j	$L815
	sw	$4,384($20)
	.set	macro
	.set	reorder

$L816:
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L825
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$20
	lui	$5,%hi(dummy_133) # high
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_133) # low
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$2,384($20)
	.set	macro
	.set	reorder

	sw	$2,gWSavePtr
	sw	$16,stackSpeedUpEnbabledFlag
	j	$L826
$L825:
	lui	$5,%hi(dummy_133) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_133) # low
	.set	macro
	.set	reorder

	sw	$2,384($20)
$L826:
	lw	$2,384($20)
	lw	$3,312($20)
	#nop
	addu	$2,$2,$3
	sw	$2,164($20)
$L815:
	move	$4,$20
	addu	$5,$20,336
	.set	noreorder
	.set	nomacro
	jal	Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	addu	$6,$20,360
	.set	macro
	.set	reorder

	lw	$3,164($20)
	lbu	$4,144($20)
	#.set	volatile
	sw	$2,392($20)
	#.set	novolatile
	sw	$0,392($20)
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L827
	sw	$3,164($20)
	.set	macro
	.set	reorder

	lw	$3,128($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L830
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L833
	sw	$2,444($20)
	.set	macro
	.set	reorder

$L827:
	li	$2,1			# 0x00000001
$L830:
	sw	$2,444($20)
$L833:
	lw	$2,444($20)
	#nop
	andi	$2,$2,0x000f
	sw	$2,448($20)
	lw	$31,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	.text
	.ent	Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	lw	$17,56($sp)
	sw	$18,24($sp)
	lw	$18,60($sp)
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	lw	$19,64($sp)
	lui	$2,%hi(GameSetup_gData+56) # high
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$5,0($16)
	sw	$0,136($16)
	sb	$0,144($16)
	sw	$0,160($16)
	sw	$0,164($16)
	sw	$0,168($16)
	sw	$0,172($16)
	sw	$0,176($16)
	sw	$0,180($16)
	sw	$6,184($16)
	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L835
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L835
	sll	$2,$6,2
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sw	$2,184($16)
$L835:
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L836
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L837
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,648($2)
	#nop
	lw	$2,0($2)
	#nop
	slt	$2,$2,22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L838
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lw	$2,648($2)
	#nop
	lw	$2,0($2)
	#nop
	slt	$2,$2,22
	beq	$2,$0,$L837
$L838:
	lw	$2,184($16)
	#nop
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L836
	sw	$2,184($16)
	.set	macro
	.set	reorder

$L837:
	lw	$2,184($16)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	sw	$3,184($16)
$L836:
	lw	$5,184($16)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$5,184($16)
	li	$4,65536			# 0x00010000
	sw	$2,188($16)
	sll	$5,$5,3
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sw	$5,288($16)
	.set	macro
	.set	reorder

	move	$3,$17
	li	$20,65536			# 0x00010000
	sw	$2,292($16)
	sw	$0,276($16)
	sw	$0,280($16)
	sw	$0,284($16)
	sw	$0,296($16)
	sw	$20,300($16)
	sw	$0,304($16)
	sw	$17,308($16)
	sw	$18,312($16)
	.set	noreorder
	.set	nomacro
	bgez	$17,$L840
	sw	$19,316($16)
	.set	macro
	.set	reorder

	addu	$3,$17,255
$L840:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$18,$L842
	move	$2,$18
	.set	macro
	.set	reorder

	addu	$2,$18,255
$L842:
	sra	$2,$2,8
	mult	$2,$2
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$3,$7
	.set	macro
	.set	reorder

	sw	$2,320($16)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L844
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$3,$2,255
$L844:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$19,$L846
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$19,255
$L846:
	sra	$2,$2,8
	mult	$2,$2
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$3,$7
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	addu	$3,$16,36
	sw	$2,320($16)
	li	$2,1			# 0x00000001
	sh	$0,380($16)
	sw	$2,444($16)
	sw	$2,448($16)
	sw	$0,388($16)
	sw	$0,392($16)
	sw	$20,148($16)
	sw	$0,196($16)
	sw	$0,372($16)
	sw	$0,396($16)
	sw	$0,400($16)
	sw	$0,404($16)
	sw	$0,408($16)
	sw	$0,412($16)
	sw	$0,432($16)
	sw	$0,436($16)
	sw	$0,440($16)
$L848:
	sw	$0,536($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L848
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$0,146($16)
	sh	$0,382($16)
	sb	$2,145($16)
	sw	$0,152($16)
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

	.end	Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
	.text
	.ent	Newton_QDUpdateVel__FP13BO_tNewtonObj
Newton_QDUpdateVel__FP13BO_tNewtonObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$2,145($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L853
	lui	$2,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L855
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	lw	$4,172($18)
	lw	$17,176($18)
	lw	$16,180($18)
	sra	$4,$4,6
	sra	$17,$17,6
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$16,$16,6
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,52428			# 0x0000cccc
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$3,160($18)
	lw	$4,168($18)
	addu	$3,$3,$16
	sw	$3,160($18)
	lw	$3,164($18)
	addu	$4,$4,$2
	sw	$4,168($18)
	addu	$3,$3,$17
	.set	noreorder
	.set	nomacro
	j	$L853
	sw	$3,164($18)
	.set	macro
	.set	reorder

$L855:
	lw	$2,172($18)
	lw	$3,160($18)
	sra	$2,$2,6
	addu	$3,$3,$2
	lw	$2,176($18)
	sw	$3,160($18)
	lw	$3,164($18)
	sra	$2,$2,6
	addu	$3,$3,$2
	lw	$2,180($18)
	sw	$3,164($18)
	lw	$3,168($18)
	sra	$2,$2,6
	addu	$3,$3,$2
	sw	$3,168($18)
$L853:
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

	.end	Newton_QDUpdateVel__FP13BO_tNewtonObj
	.text
	.ent	Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
Newton_OptzRotxform__FP10matrixtdefiiiPiiT4:
	.frame	$sp,208,$31		# vars= 160, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$22,200($sp)
	move	$22,$4
	sw	$20,192($sp)
	move	$20,$5
	move	$5,$6
	sw	$21,196($sp)
	move	$21,$7
	sw	$18,184($sp)
	addu	$18,$sp,56
	lw	$2,224($sp)
	lw	$6,232($sp)
	move	$4,$18
	sw	$17,180($sp)
	.set	noreorder
	bgez	$20,1f
	move	$17,$20
	subu	$17,$0,$17
1:
	.set	reorder
	sw	$16,176($sp)
	.set	noreorder
	bgez	$5,1f
	move	$16,$5
	subu	$16,$0,$16
1:
	.set	reorder
	sw	$19,188($sp)
	.set	noreorder
	bgez	$21,1f
	move	$19,$21
	subu	$19,$0,$19
1:
	.set	reorder
	sw	$31,204($sp)
	sw	$0,0($2)
	addu	$2,$17,$16
	lw	$3,0($6)
	addu	$2,$2,$19
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	sw	$3,0($6)
	.set	macro
	.set	reorder

	slt	$16,$16,20
	slt	$17,$17,14
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L859
	xori	$16,$16,0x0001
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	fixedxformx
	move	$5,$20
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	addu	$6,$sp,136
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L860
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L859:
	addu	$2,$sp,136
	move	$4,$18
	addu	$3,$sp,88
$L861:
	lw	$8,0($4)
	lw	$9,4($4)
	lw	$10,8($4)
	lw	$11,12($4)
	sw	$8,0($2)
	sw	$9,4($2)
	sw	$10,8($2)
	sw	$11,12($2)
	addu	$4,$4,16
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L861
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$8,0($4)
	sw	$8,0($2)
$L860:
	slt	$2,$19,14
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L862
	move	$4,$22
	.set	macro
	.set	reorder

	addu	$16,$sp,96
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedxformz
	move	$5,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,136
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L863
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L862:
	addu	$2,$sp,136
	addu	$3,$sp,168
$L864:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($4)
	sw	$9,4($4)
	sw	$10,8($4)
	sw	$11,12($4)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L864
	addu	$4,$4,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($4)
$L863:
	move	$2,$16
	lw	$31,204($sp)
	lw	$22,200($sp)
	lw	$21,196($sp)
	lw	$20,192($sp)
	lw	$19,188($sp)
	lw	$18,184($sp)
	lw	$17,180($sp)
	lw	$16,176($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
	.text
	.ent	Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj
Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj:
	.frame	$sp,112,$31		# vars= 64, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	sw	$31,104($sp)
	sw	$16,96($sp)
	lbu	$2,145($17)
	#nop
	beq	$2,$0,$L865
	lw	$2,276($17)
	#nop
	bgez	$2,$L867
	addu	$2,$2,63
$L867:
	sra	$2,$2,6
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L868
	addu	$2,$2,63
$L868:
	sra	$2,$2,6
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L869
	addu	$2,$2,63
$L869:
	sra	$2,$2,6
	sw	$2,80($sp)
	addu	$2,$sp,88
	sw	$2,16($sp)
	li	$2,4096			# 0x00001000
	sw	$2,20($sp)
	addu	$2,$17,152
	sw	$2,24($sp)
	lw	$5,72($sp)
	lw	$6,76($sp)
	lw	$7,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L865
	addu	$16,$17,240
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	lbu	$2,146($17)
	#nop
	addu	$2,$2,-1
	sb	$2,146($17)
	andi	$2,$2,0x00ff
	beq	$2,$0,$L872
	lw	$2,88($sp)
	#nop
	beq	$2,$0,$L865
$L872:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sb	$2,146($17)
	sw	$0,152($17)
$L865:
	lw	$31,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj
	.text
	.ent	Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj
Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj:
	.frame	$sp,112,$31		# vars= 64, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	sw	$31,104($sp)
	sw	$16,96($sp)
	lbu	$2,145($17)
	#nop
	beq	$2,$0,$L873
	lbu	$2,144($17)
	#nop
	bne	$2,$0,$L873
	lw	$2,276($17)
	#nop
	bgez	$2,$L875
	addu	$2,$2,15
$L875:
	sra	$2,$2,4
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L876
	addu	$2,$2,15
$L876:
	sra	$2,$2,4
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L877
	addu	$2,$2,15
$L877:
	sra	$2,$2,4
	sw	$2,80($sp)
	addu	$2,$sp,88
	sw	$2,16($sp)
	li	$2,8192			# 0x00002000
	sw	$2,20($sp)
	addu	$2,$17,152
	sw	$2,24($sp)
	lw	$5,72($sp)
	lw	$6,76($sp)
	lw	$7,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_OptzRotxform__FP10matrixtdefiiiPiiT4
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L873
	addu	$16,$17,240
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$2,88($sp)
	#nop
	bne	$2,$0,$L880
	lbu	$2,146($17)
	#nop
	addu	$2,$2,-1
	sb	$2,146($17)
	andi	$2,$2,0x00ff
	bne	$2,$0,$L873
$L880:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,64			# 0x00000040
	sb	$2,146($17)
	sw	$0,152($17)
$L873:
	lw	$31,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj
	.text
	.ent	Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L882
	li	$2,58982			# 0x0000e666
	.set	macro
	.set	reorder

	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L882
	addu	$3,$17,452
	.set	macro
	.set	reorder

	addu	$2,$17,240
	addu	$4,$17,272
$L883:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L883
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($3)
	lw	$2,0($5)
	lw	$3,4($5)
	lw	$4,8($5)
	sw	$2,464($17)
	sw	$3,468($17)
	.set	noreorder
	.set	nomacro
	j	$L881
	sw	$4,472($17)
	.set	macro
	.set	reorder

$L882:
	lw	$2,0($5)
	lw	$3,4($5)
	lw	$4,8($5)
	sw	$2,464($17)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$6
	sw	$3,468($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L884
	sw	$4,472($17)
	.set	macro
	.set	reorder

	lw	$3,240($17)
	#nop
	bgez	$3,$L885
	addu	$3,$3,255
$L885:
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L886
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L886:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,244($17)
	mflo	$4
	#nop
	bgez	$3,$L887
	addu	$3,$3,255
$L887:
	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L888
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L888:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,248($17)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L889
	addu	$4,$4,$8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L889:
	lw	$2,8($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L890
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L890:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	addu	$4,$4,$8
	bgez	$4,$L891
	subu	$4,$0,$4
$L891:
	jal	__floatsidf
	li.d	$6,5.00000000000000000000e-1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__gtdf2
	move	$5,$3
	.set	macro
	.set	reorder

	blez	$2,$L884
	lw	$4,468($17)
	lw	$5,272($17)
	jal	fixedmult
	lw	$4,472($17)
	lw	$5,268($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,472($17)
	lw	$5,264($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,452($17)
	.set	macro
	.set	reorder

	lw	$4,464($17)
	lw	$5,272($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,464($17)
	lw	$5,268($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,456($17)
	.set	macro
	.set	reorder

	lw	$4,468($17)
	lw	$5,264($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$17,452
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$16,460($17)
	.set	macro
	.set	reorder

	lw	$4,456($17)
	lw	$5,472($17)
	jal	fixedmult
	lw	$4,460($17)
	lw	$5,468($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,460($17)
	lw	$5,464($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,476($17)
	.set	macro
	.set	reorder

	lw	$4,452($17)
	lw	$5,472($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,452($17)
	lw	$5,468($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,480($17)
	.set	macro
	.set	reorder

	lw	$4,456($17)
	lw	$5,464($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$17,476
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L893
	sw	$16,484($17)
	.set	macro
	.set	reorder

$L884:
	lw	$4,244($17)
	lw	$5,472($17)
	jal	fixedmult
	lw	$4,248($17)
	lw	$5,468($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,248($17)
	lw	$5,464($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,476($17)
	.set	macro
	.set	reorder

	lw	$4,240($17)
	lw	$5,472($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,240($17)
	lw	$5,468($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,480($17)
	.set	macro
	.set	reorder

	lw	$4,244($17)
	lw	$5,464($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$17,476
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$16,484($17)
	.set	macro
	.set	reorder

	lw	$4,468($17)
	lw	$5,484($17)
	jal	fixedmult
	lw	$4,472($17)
	lw	$5,480($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,472($17)
	lw	$5,476($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,452($17)
	.set	macro
	.set	reorder

	lw	$4,464($17)
	lw	$5,484($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,464($17)
	lw	$5,480($17)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,456($17)
	.set	macro
	.set	reorder

	lw	$4,468($17)
	lw	$5,476($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$17,452
	subu	$16,$16,$2
	sw	$16,460($17)
$L893:
	jal	Math_NormalizeShortVector__FP8coorddef
$L881:
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

	.end	Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
	.text
	.ent	Newton_CalcRealShadowCoordinates__FP8Car_tObji
Newton_CalcRealShadowCoordinates__FP8Car_tObji:
	.frame	$sp,144,$31		# vars= 112, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$17,132($sp)
	move	$17,$4
	sw	$31,140($sp)
	sw	$18,136($sp)
	sw	$16,128($sp)
	lw	$3,156($17)
	lw	$7,308($17)
	lw	$8,312($17)
	lw	$9,316($17)
	sw	$7,112($sp)
	sw	$8,116($sp)
	sw	$9,120($sp)
	lw	$2,112($sp)
	lw	$4,120($sp)
	addu	$2,$2,3276
	addu	$4,$4,3276
	subu	$18,$5,$3
	sw	$2,112($sp)
	sw	$4,120($sp)
	lw	$5,264($17)
	jal	fixedmult
	lw	$4,120($sp)
	sw	$2,16($sp)
	lw	$5,268($17)
	jal	fixedmult
	lw	$4,120($sp)
	sw	$2,20($sp)
	lw	$5,272($17)
	jal	fixedmult
	lw	$4,112($sp)
	sw	$2,24($sp)
	lw	$5,240($17)
	jal	fixedmult
	lw	$4,112($sp)
	sw	$2,32($sp)
	lw	$5,244($17)
	jal	fixedmult
	lw	$4,112($sp)
	sw	$2,36($sp)
	lw	$5,248($17)
	jal	fixedmult
	move	$4,$2
	sw	$4,40($sp)
	lh	$3,2236($17)
	li	$2,20			# 0x00000014
	bne	$3,$2,$L895
	lw	$2,112($sp)
	lw	$5,240($17)
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,6
	sra	$16,$16,8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,48($sp)
	lw	$5,244($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,52($sp)
	lw	$5,248($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L896
	sw	$2,56($sp)
	.set	macro
	.set	reorder

$L895:
	lw	$2,32($sp)
	lw	$3,36($sp)
	sw	$4,56($sp)
	sw	$2,48($sp)
	sw	$3,52($sp)
$L896:
	lw	$3,300($17)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	beq	$2,$0,$L897
	lw	$5,336($17)
	lw	$4,116($sp)
	lw	$2,392($17)
	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$2
	.set	macro
	.set	reorder

	sw	$2,96($sp)
	lw	$5,340($17)
	lw	$4,116($sp)
	lw	$2,392($17)
	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$2
	.set	macro
	.set	reorder

	sw	$2,100($sp)
	lw	$5,344($17)
	lw	$4,116($sp)
	lw	$2,392($17)
	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$2
	.set	macro
	.set	reorder

	sw	$2,104($sp)
	lw	$3,160($17)
	lw	$4,96($sp)
	#nop
	addu	$3,$3,$4
	sw	$3,64($sp)
	lw	$3,164($17)
	lw	$4,100($sp)
	#nop
	addu	$3,$3,$4
	sw	$3,68($sp)
	lw	$3,168($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L898
	sw	$3,72($sp)
	.set	macro
	.set	reorder

$L897:
	lw	$7,160($17)
	lw	$8,164($17)
	lw	$9,168($17)
	sw	$7,64($sp)
	sw	$8,68($sp)
	sw	$9,72($sp)
	lw	$2,384($17)
	#nop
	sw	$2,68($sp)
$L898:
	lw	$3,64($sp)
	lw	$4,16($sp)
	lw	$2,68($sp)
	lw	$5,20($sp)
	addu	$3,$3,$4
	addu	$2,$2,$5
	sw	$2,84($sp)
	lw	$2,72($sp)
	lw	$4,24($sp)
	lw	$5,48($sp)
	sw	$3,80($sp)
	addu	$2,$2,$4
	subu	$3,$3,$5
	sw	$2,88($sp)
	sw	$3,488($17)
	lw	$2,84($sp)
	lw	$3,52($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,492($17)
	lw	$2,88($sp)
	lw	$3,56($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,496($17)
	lw	$2,80($sp)
	lw	$3,48($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,500($17)
	lw	$2,84($sp)
	lw	$3,52($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,504($17)
	lw	$2,88($sp)
	lw	$3,56($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,508($17)
	lw	$4,64($sp)
	lw	$2,16($sp)
	lw	$5,20($sp)
	lw	$3,72($sp)
	lw	$6,24($sp)
	subu	$4,$4,$2
	lw	$2,68($sp)
	subu	$3,$3,$6
	sw	$4,80($sp)
	subu	$2,$2,$5
	sw	$2,84($sp)
	sw	$3,88($sp)
	lw	$2,32($sp)
	#nop
	subu	$4,$4,$2
	sw	$4,512($17)
	lw	$2,84($sp)
	lw	$3,36($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,516($17)
	lw	$2,88($sp)
	lw	$3,40($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,520($17)
	lw	$2,80($sp)
	lw	$3,32($sp)
	move	$6,$0
	addu	$2,$2,$3
	sw	$2,524($17)
	lw	$2,84($sp)
	lw	$3,36($sp)
	move	$5,$17
	addu	$2,$2,$3
	sw	$2,528($17)
	lw	$2,88($sp)
	lw	$3,40($sp)
	move	$4,$5
	addu	$2,$2,$3
	sw	$2,532($17)
$L902:
	lw	$3,656($5)
	#nop
	sw	$3,492($4)
	lw	$2,176($17)
	#nop
	bgez	$2,$L903
	addu	$2,$2,63
$L903:
	sra	$2,$2,6
	mult	$2,$18
	addu	$5,$5,48
	addu	$6,$6,1
	mflo	$7
	#nop
	#nop
	addu	$2,$3,$7
	sw	$2,492($4)
	slt	$2,$6,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L902
	addu	$4,$4,12
	.set	macro
	.set	reorder

	lw	$31,140($sp)
	lw	$18,136($sp)
	lw	$17,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	Newton_CalcRealShadowCoordinates__FP8Car_tObji
	.text
	.ent	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
Newton_CheckForSpikeBelts__FP13BO_tNewtonObj:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	move	$5,$4
	lui	$2,%hi(AICop_spikeBelt) # high
	lw	$6,%lo(AICop_spikeBelt)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L906
	addiu	$4,$2,%lo(AICop_spikeBelt) # low
	.set	macro
	.set	reorder

	lw	$2,4($4)
	lw	$3,8($4)
	lw	$4,12($4)
	sw	$2,0($sp)
	sw	$3,4($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L906
	sw	$4,8($sp)
	.set	macro
	.set	reorder

	lh	$3,8($5)
	#nop
	bne	$3,$2,$L906
	lw	$2,608($5)
	lw	$3,1396($5)
	andi	$2,$2,0x0230
	bne	$2,$0,$L906
	lw	$2,4($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L906
	move	$2,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L906
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,628($5)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L906
	sw	$2,628($5)
	.set	macro
	.set	reorder

	li	$3,327680			# 0x00050000
	ori	$3,$3,0x0007
	li	$2,983040			# 0x000f0000
	sw	$2,400($5)
	sw	$3,408($5)
	lw	$7,160($5)
	lw	$8,164($5)
	lw	$9,168($5)
	sw	$7,416($5)
	sw	$8,420($5)
	sw	$9,424($5)
$L906:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
	.text
	.ent	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef:
	.frame	$sp,112,$31		# vars= 72, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	li	$2,65536			# 0x00010000
	sw	$31,104($sp)
	sw	$16,96($sp)
	sw	$5,116($sp)
	sw	$6,120($sp)
	sw	$7,124($sp)
	sw	$0,40($sp)
	sw	$2,44($sp)
	sw	$0,48($sp)
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bgez	$7,$L923
	sra	$2,$7,8
	.set	macro
	.set	reorder

	addu	$7,$7,255
	sra	$2,$7,8
$L923:
	sll	$2,$2,8
	subu	$2,$0,$2
	sw	$2,24($sp)
 #APP
 #NO_APP
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$5,$L913
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L913:
	sra	$3,$2,8
	sll	$11,$3,8
	sw	$11,32($sp)
	lw	$2,172($17)
	#nop
	bgez	$2,$L915
	addu	$2,$2,255
$L915:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$4
	#nop
	bgez	$6,$L916
	addu	$6,$6,255
$L916:
	lw	$2,176($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L917
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L917:
	sra	$2,$2,8
	mult	$6,$2
	#.set	volatile
	lw	$3,124($sp)
	#.set	novolatile
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L918
	addu	$5,$4,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L918:
	lw	$2,180($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L919
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L919:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$12
	#nop
	#nop
	addu	$5,$5,$12
	.set	noreorder
	.set	nomacro
	bgez	$5,$L924
	subu	$2,$0,$5
	.set	macro
	.set	reorder

	subu	$5,$0,$5
	subu	$2,$0,$5
$L924:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L925
	sra	$5,$2,4
	.set	macro
	.set	reorder

	addu	$2,$2,15
	sra	$5,$2,4
$L925:
	slt	$2,$5,-1965
	bne	$2,$0,$L922
	li	$5,-1966			# 0xfffff852
$L922:
	lw	$2,116($sp)
	lw	$3,44($sp)
	lw	$7,48($sp)
	lw	$8,24($sp)
	lw	$9,28($sp)
	sw	$2,56($sp)
	lw	$2,120($sp)
	move	$4,$17
	sw	$2,60($sp)
	lw	$10,124($sp)
	lw	$2,40($sp)
	addu	$6,$sp,56
	sw	$3,72($sp)
	sw	$7,76($sp)
	sw	$8,80($sp)
	sw	$9,84($sp)
	sw	$11,88($sp)
	sw	$2,68($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
	sw	$10,64($sp)
	.set	macro
	.set	reorder

	li	$4,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	Physics_SetCurrentWallType__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,124($sp)
	move	$4,$17
	sw	$2,16($sp)
	lw	$6,116($sp)
	lw	$7,120($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$31,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
	.text
	.ent	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos:
	.frame	$sp,80,$31		# vars= 48, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$17,68($sp)
	move	$17,$5
	li	$2,65536			# 0x00010000
	sw	$2,36($sp)
	li	$2,1			# 0x00000001
	sw	$31,72($sp)
	sw	$16,64($sp)
	sw	$0,40($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L927
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$2,52($6)
	lw	$3,40($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,44($6)
	lw	$3,32($6)
	.set	noreorder
	.set	nomacro
	j	$L935
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L927:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L929
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,40($6)
	lw	$3,28($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,32($6)
	lw	$3,20($6)
	.set	noreorder
	.set	nomacro
	j	$L935
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L929:
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L931
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,28($6)
	lw	$3,16($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,20($6)
	lw	$3,8($6)
	.set	noreorder
	.set	nomacro
	j	$L935
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L931:
	bne	$4,$2,$L928
	lw	$2,16($6)
	lw	$3,52($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,8($6)
	lw	$3,44($6)
	#nop
	subu	$2,$2,$3
$L935:
	sw	$2,16($sp)
$L928:
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	lw	$5,40($sp)
	jal	fixedmult
	lw	$4,24($sp)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,32($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,48($sp)
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,36($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,52($sp)
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	lw	$5,32($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$3,48($sp)
	subu	$16,$16,$2
	sw	$16,56($sp)
	sw	$3,0($17)
	lw	$2,52($sp)
	#nop
	sw	$2,4($17)
	lw	$2,56($sp)
	#nop
	sw	$2,8($17)
	lw	$31,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	.text
	.ent	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,120($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L939
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	beq	$2,$0,$L938
$L939:
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$2,$2,4
	addu	$2,$4,$2
	lw	$3,676($2)
	lw	$2,656($2)
	#nop
	subu	$3,$3,$2
	li	$2,131072			# 0x00020000
	slt	$2,$2,$3
	beq	$2,$0,$L937
$L938:
	li	$7,1			# 0x00000001
$L937:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	.text
	.ent	Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj:
	.frame	$sp,176,$31		# vars= 120, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	sw	$17,140($sp)
	move	$17,$4
	sw	$19,148($sp)
	move	$19,$0
	sw	$31,172($sp)
	sw	$fp,168($sp)
	sw	$23,164($sp)
	sw	$22,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$18,144($sp)
	sw	$16,136($sp)
 #APP
 #NO_APP
	addu	$4,$sp,64
	move	$5,$19
	sw	$0,128($sp)
	lw	$9,360($17)
	lw	$10,364($17)
	lw	$11,368($17)
	sw	$9,32($sp)
	sw	$10,36($sp)
	sw	$11,40($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	lui	$2,%hi(testSimRoadInfo) # high
	addiu	$2,$2,%lo(testSimRoadInfo) # low
	addu	$3,$17,8
	addu	$4,$17,136
$L941:
	lw	$13,0($3)
	lw	$9,4($3)
	lw	$10,8($3)
	lw	$11,12($3)
	sw	$13,0($2)
	sw	$9,4($2)
	sw	$10,8($2)
	sw	$11,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L941
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$12,0($3)
	sw	$12,0($2)
	lw	$3,192($17)
	li	$2,2621440			# 0x00280000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1000
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$3,172($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L943
	addu	$2,$2,255
$L943:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$3,176($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L944
	addu	$2,$2,255
$L944:
	sra	$2,$2,8
	sw	$2,68($sp)
	lw	$3,180($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L945
	addu	$2,$2,255
$L945:
	sra	$2,$2,8
	sw	$2,72($sp)
	move	$18,$0
$L1000:
	sw	$0,132($sp)
	move	$21,$17
	lui	$23,%hi(testSimRoadInfo) # high
	addiu	$22,$23,%lo(testSimRoadInfo) # low
	addu	$20,$21,8
	lui	$11,%hi(newtestSimRoadInfo) # high
	addiu	$fp,$11,%lo(newtestSimRoadInfo) # low
$L946:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L940
	addu	$4,$sp,80
	.set	macro
	.set	reorder

	move	$5,$22
	li	$6,1			# 0x00000001
	lw	$12,652($21)
	lw	$13,656($21)
	lw	$9,660($21)
	sw	$12,80($sp)
	sw	$13,84($sp)
	sw	$9,88($sp)
	lw	$2,80($sp)
	lw	$3,64($sp)
	lw	$7,68($sp)
	lw	$8,72($sp)
	addu	$2,$2,$3
	sw	$2,80($sp)
	lw	$2,84($sp)
	lw	$3,88($sp)
	addu	$2,$2,$7
	addu	$3,$3,$8
	sw	$2,84($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	sw	$3,88($sp)
	.set	macro
	.set	reorder

	lb	$4,90($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L950
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	addu	$6,$17,8
	.set	macro
	.set	reorder

	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L951
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

$L950:
	move	$4,$17
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L951
	lui	$11,%hi(newtestSimRoadInfo) # high
	.set	macro
	.set	reorder

	addiu	$3,$11,%lo(newtestSimRoadInfo) # low
	move	$2,$22
$L953:
	lw	$12,0($2)
	lw	$13,4($2)
	lw	$9,8($2)
	lw	$10,12($2)
	sw	$12,0($3)
	sw	$13,4($3)
	sw	$9,8($3)
	sw	$10,12($3)
	addu	$2,$2,16
	lui	$11,%hi(testSimRoadInfo+128) # high
	addiu	$11,$11,%lo(testSimRoadInfo+128) # low
	.set	noreorder
	.set	nomacro
	bne	$2,$11,$L953
	addu	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$sp,80
	move	$5,$20
	addiu	$6,$23,%lo(testSimRoadInfo) # low
	lui	$12,%hi(testSimRoadInfo+128) # high
	addiu	$12,$12,%lo(testSimRoadInfo+128) # low
	lw	$13,0($12)
	sw	$13,0($3)
	lw	$12,80($sp)
	lw	$13,84($sp)
	lw	$9,88($sp)
	sw	$12,96($sp)
	sw	$13,100($sp)
	sw	$9,104($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
	addu	$7,$sp,128
	.set	macro
	.set	reorder

	move	$16,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L994
	li	$19,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$19,$L956
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L995
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L956:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L995
	move	$4,$2
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	bne	$16,$2,$L955
$L994:
	move	$4,$2
$L995:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	move	$6,$20
	.set	macro
	.set	reorder

$L955:
	andi	$2,$16,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L961
	andi	$2,$16,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L996
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	andi	$2,$16,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L963
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L996:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L963:
	addu	$4,$sp,96
	move	$5,$fp
	li	$6,1			# 0x00000001
	lw	$2,96($sp)
	lw	$3,16($sp)
	lw	$7,20($sp)
	lw	$8,24($sp)
	addu	$2,$2,$3
	sw	$2,96($sp)
	lw	$2,100($sp)
	lw	$3,104($sp)
	addu	$2,$2,$7
	addu	$3,$3,$8
	sw	$2,100($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	sw	$3,104($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$fp
	.set	noreorder
	.set	nomacro
	jal	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L961
	andi	$2,$16,0x000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L966
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L967
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	j	$L997
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L967:
	andi	$2,$16,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L968
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	addu	$6,$17,$4
$L997:
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
$L968:
	lui	$11,%hi(newtestSimRoadInfo) # high
	addiu	$3,$11,%lo(newtestSimRoadInfo) # low
	addiu	$2,$23,%lo(testSimRoadInfo) # low
$L970:
	lw	$12,0($2)
	lw	$13,4($2)
	lw	$9,8($2)
	lw	$10,12($2)
	sw	$12,0($3)
	sw	$13,4($3)
	sw	$9,8($3)
	sw	$10,12($3)
	addu	$2,$2,16
	lui	$11,%hi(testSimRoadInfo+128) # high
	addiu	$11,$11,%lo(testSimRoadInfo+128) # low
	.set	noreorder
	.set	nomacro
	bne	$2,$11,$L970
	addu	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$sp,96
	move	$5,$fp
	li	$6,1			# 0x00000001
	lw	$12,0($2)
	sw	$12,0($3)
	lw	$11,80($sp)
	lw	$12,84($sp)
	lw	$13,88($sp)
	sw	$11,96($sp)
	sw	$12,100($sp)
	sw	$13,104($sp)
	lw	$2,96($sp)
	lw	$3,16($sp)
	lw	$7,20($sp)
	lw	$8,24($sp)
	addu	$2,$2,$3
	sw	$2,96($sp)
	lw	$2,100($sp)
	lw	$3,104($sp)
	addu	$2,$2,$7
	addu	$3,$3,$8
	sw	$2,100($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	sw	$3,104($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$fp
	.set	noreorder
	.set	nomacro
	jal	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L961
	move	$7,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(testSimRoadInfo+8) # high
	addiu	$6,$2,%lo(testSimRoadInfo+8) # low
	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L972:
	slt	$2,$7,4
	beq	$2,$0,$L973
	lw	$2,120($22)
	#nop
	beq	$2,$0,$L974
	lw	$10,0($6)
	lw	$11,4($6)
	lw	$12,8($6)
	sw	$10,112($sp)
	sw	$11,116($sp)
	sw	$12,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L998
	addu	$6,$6,12
	.set	macro
	.set	reorder

$L974:
	lh	$2,%lo(testSimRoadInfo)($23)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	sw	$9,112($sp)
	sw	$10,116($sp)
	sw	$11,120($sp)
	addu	$6,$6,12
$L998:
	addu	$7,$7,1
	lw	$2,48($sp)
	lw	$3,112($sp)
	lw	$4,116($sp)
	lw	$5,120($sp)
	addu	$2,$2,$3
	sw	$2,48($sp)
	lw	$2,52($sp)
	lw	$3,56($sp)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L972
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L973:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L976
	addu	$3,$3,3
$L976:
	lw	$2,52($sp)
	sra	$5,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L977
	sw	$5,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L977:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L978
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L978:
	sra	$2,$3,2
	lw	$3,32($sp)
	lw	$4,40($sp)
	sw	$2,56($sp)
	sw	$0,20($sp)
	subu	$3,$3,$5
	subu	$4,$4,$2
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L961
	sw	$4,24($sp)
	.set	macro
	.set	reorder

$L966:
	move	$7,$0
	lui	$2,%hi(testSimRoadInfo+8) # high
	addiu	$6,$2,%lo(testSimRoadInfo+8) # low
	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L980:
	slt	$2,$7,4
	beq	$2,$0,$L981
	lw	$2,120($22)
	#nop
	beq	$2,$0,$L982
	lw	$13,0($6)
	lw	$9,4($6)
	lw	$10,8($6)
	sw	$13,112($sp)
	sw	$9,116($sp)
	sw	$10,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L999
	addu	$6,$6,12
	.set	macro
	.set	reorder

$L982:
	lh	$2,%lo(testSimRoadInfo)($23)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$12,0($2)
	lw	$13,4($2)
	lw	$9,8($2)
	sw	$12,112($sp)
	sw	$13,116($sp)
	sw	$9,120($sp)
	addu	$6,$6,12
$L999:
	addu	$7,$7,1
	lw	$2,48($sp)
	lw	$3,112($sp)
	lw	$4,116($sp)
	lw	$5,120($sp)
	addu	$2,$2,$3
	sw	$2,48($sp)
	lw	$2,52($sp)
	lw	$3,56($sp)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L980
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L981:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L984
	addu	$3,$3,3
$L984:
	lw	$2,52($sp)
	sra	$4,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L985
	sw	$4,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L985:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L986
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L986:
	sra	$2,$3,2
	sw	$2,56($sp)
	lw	$3,160($17)
	#nop
	subu	$3,$3,$4
	sw	$3,16($sp)
	lw	$3,168($17)
	sw	$0,20($sp)
	subu	$3,$3,$2
	sw	$3,24($sp)
$L961:
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L951:
	beq	$19,$0,$L987
	lw	$5,16($sp)
	lw	$6,20($sp)
	lw	$7,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$11,652($21)
	lw	$12,656($21)
	lw	$13,660($21)
	sw	$11,416($17)
	sw	$12,420($17)
	sw	$13,424($17)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ProcessBarrierCollision__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L988
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L988:
	lw	$5,400($17)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L940
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L990
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$6,132($sp)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1001
	move	$4,$17
	.set	macro
	.set	reorder

	li	$6,4			# 0x00000004
$L990:
	move	$4,$17
$L1001:
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L940
$L987:
	addu	$21,$21,48
	lw	$10,132($sp)
	addu	$18,$18,1
	addu	$10,$10,2
	.set	noreorder
	.set	nomacro
	j	$L946
	sw	$10,132($sp)
	.set	macro
	.set	reorder

$L940:
	lw	$31,172($sp)
	lw	$fp,168($sp)
	lw	$23,164($sp)
	lw	$22,160($sp)
	lw	$21,156($sp)
	lw	$20,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
	.text
	.ent	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
Newton_LimitAngularVelocity__FP13BO_tNewtonObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,65536			# 0x00010000
	lw	$5,276($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L1004
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1003
$L1004:
	sw	$3,276($4)
$L1003:
	li	$3,65536			# 0x00010000
	lw	$5,280($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L1006
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1005
$L1006:
	sw	$3,280($4)
$L1005:
	li	$3,65536			# 0x00010000
	lw	$5,284($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L1008
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1010
$L1008:
	sw	$3,284($4)
$L1010:
	j	$31
	.end	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	.text
	.ent	Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj:
	.frame	$sp,128,$31		# vars= 64, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$18,104($sp)
	move	$18,$4
	sw	$31,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$17,100($sp)
	sw	$16,96($sp)
	lbu	$2,145($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1045
	li	$21,18432			# 0x00004800
	.set	macro
	.set	reorder

	addu	$2,$sp,80
	sw	$2,16($sp)
	addu	$2,$sp,84
	sw	$2,20($sp)
	addu	$2,$sp,88
	sw	$2,24($sp)
	lw	$2,1884($18)
	li	$4,1			# 0x00000001
	sw	$2,28($sp)
	lw	$6,140($18)
	lw	$7,0($18)
	.set	noreorder
	.set	nomacro
	jal	Sched_ExecuteCheck__FiiiiPiN24i
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$2,$0,$L1045
	lbu	$2,144($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1013
	move	$4,$18
	.set	macro
	.set	reorder

	addu	$5,$sp,32
	sw	$0,176($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
	sh	$0,380($18)
	.set	macro
	.set	reorder

	lw	$3,312($18)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1045
	sw	$2,164($18)
	.set	macro
	.set	reorder

$L1013:
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$4,84($sp)
	#nop
	mult	$4,$21
	lw	$8,32($sp)
	lw	$9,36($sp)
	lw	$10,40($sp)
	sw	$8,48($sp)
	sw	$9,52($sp)
	sw	$10,56($sp)
	lw	$6,384($18)
	sw	$2,384($18)
	mflo	$4
	#nop
	lw	$3,80($sp)
	subu	$2,$2,$6
	mult	$2,$3
	lw	$20,392($18)
	lw	$5,148($18)
	mflo	$19
	#nop
	jal	fixedmult
	lw	$3,176($18)
	lw	$4,252($18)
	subu	$3,$3,$2
	sw	$3,176($18)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,256($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,260($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$5,$sp,48
	addu	$16,$16,$17
	addu	$16,$16,$2
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
	sw	$6,300($18)
	.set	macro
	.set	reorder

	lw	$4,172($18)
	lw	$5,180($18)
	bgez	$4,1f
	subu	$4,$0,$4
1:
	bgez	$5,1f
	subu	$5,$0,$5
1:
	jal	Math_BetterDist__Fii
	lw	$4,372($18)
	sw	$2,192($18)
	lw	$2,388($18)
	sll	$3,$4,3
	subu	$3,$3,$4
	subu	$2,$19,$2
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1015
	addu	$16,$sp,32
	.set	macro
	.set	reorder

	addu	$2,$2,7
$L1015:
	sra	$2,$2,3
	sw	$2,372($18)
	slt	$2,$20,13107
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1016
	sw	$19,388($18)
	.set	macro
	.set	reorder

	lw	$4,84($sp)
	#nop
	mult	$4,$21
	lw	$5,148($18)
	lhu	$2,380($18)
	lhu	$3,84($sp)
	sw	$0,372($18)
	addu	$2,$2,$3
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$2,380($18)
	.set	macro
	.set	reorder

	lw	$3,176($18)
	#nop
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1017
	sw	$3,176($18)
	.set	macro
	.set	reorder

$L1016:
	lhu	$2,380($18)
	#nop
	beq	$2,$0,$L1018
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1019
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1019:
	lw	$2,176($18)
	lw	$3,300($18)
	subu	$6,$19,$2
	li	$2,45875			# 0x0000b333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1020
	move	$3,$0
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$16
	lw	$8,360($18)
	lw	$9,364($18)
	lw	$10,368($18)
	sw	$8,64($sp)
	sw	$9,68($sp)
	sw	$10,72($sp)
	lw	$2,68($sp)
	addu	$6,$sp,64
	addu	$2,$2,-6553
	.set	noreorder
	.set	nomacro
	jal	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
	sw	$2,68($sp)
	.set	macro
	.set	reorder

	lw	$3,400($18)
	li	$2,327680			# 0x00050000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1021
	li	$2,1245184			# 0x00130000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1022
	li	$4,1310720			# 0x00140000
	.set	macro
	.set	reorder

	move	$4,$3
$L1022:
	sw	$4,400($18)
$L1021:
	lw	$2,300($18)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1024
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1024
	sw	$2,1932($18)
	.set	macro
	.set	reorder

$L1020:
	move	$5,$3
	move	$4,$18
$L1028:
	lw	$2,680($4)
	addu	$5,$5,1
	addu	$3,$3,$2
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1028
	addu	$4,$4,48
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L1024
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	bgez	$2,$L1031
	addu	$2,$2,3
$L1031:
	sra	$2,$2,2
	lw	$3,164($18)
	addu	$2,$19,$2
	sw	$2,176($18)
	sll	$2,$6,1
	sw	$2,400($18)
	sh	$0,380($18)
	subu	$3,$3,$20
	li	$20,3276			# 0x00000ccc
	sw	$3,164($18)
	move	$3,$2
	li	$2,1310720			# 0x00140000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1032
	sw	$20,392($18)
	.set	macro
	.set	reorder

	move	$4,$18
	li	$6,9			# 0x00000009
	li	$2,65536			# 0x00010000
	sw	$2,408($18)
	sw	$0,404($18)
	lw	$8,160($18)
	lw	$9,164($18)
	lw	$10,168($18)
	sw	$8,416($18)
	sw	$9,420($18)
	sw	$10,424($18)
	lw	$5,400($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	move	$7,$0
	.set	macro
	.set	reorder

$L1032:
	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L1024
	lw	$4,400($18)
	jal	Force_HitWall__Fi
$L1024:
	.set	noreorder
	.set	nomacro
	jal	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1046
	slt	$2,$20,2621
	.set	macro
	.set	reorder

$L1018:
	.set	noreorder
	.set	nomacro
	jal	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	slt	$2,$20,2621
$L1046:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1047
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,164($18)
	lw	$3,608($18)
	sw	$0,392($18)
	subu	$2,$2,$20
	andi	$3,$3,0x0400
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1036
	sw	$2,164($18)
	.set	macro
	.set	reorder

	lw	$3,300($18)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1048
	li	$2,327680			# 0x00050000
	.set	macro
	.set	reorder

	sh	$0,380($18)
$L1036:
	li	$2,327680			# 0x00050000
$L1048:
	ori	$2,$2,0xffff
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1037
	li	$2,786432			# 0x000c0000
	.set	macro
	.set	reorder

	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1038
	li	$16,65503			# 0x0000ffdf
	.set	macro
	.set	reorder

	li	$16,65470			# 0x0000ffbe
$L1038:
	lw	$4,172($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,180($18)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,172($18)
	.set	macro
	.set	reorder

	sw	$2,180($18)
$L1037:
	li	$2,262144			# 0x00040000
	lw	$3,192($18)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1039
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$19,$L1040
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$19,3
$L1040:
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L1017
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L1039:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1042
	srl	$2,$19,31
	.set	macro
	.set	reorder

	addu	$2,$19,$2
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1017
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L1042:
	sw	$19,176($18)
$L1017:
	lui	$2,%hi(simGlobal+4) # high
$L1047:
	lw	$2,%lo(simGlobal+4)($2)
	addu	$4,$18,8
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	sw	$2,156($18)
	.set	macro
	.set	reorder

	beq	$2,$0,$L1045
	lw	$4,176($18)
	#nop
	blez	$4,$L1045
	lw	$2,164($18)
	lw	$3,364($18)
	#nop
	subu	$2,$2,$3
	li	$3,524288			# 0x00080000
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1045
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	sw	$2,176($18)
$L1045:
	lw	$31,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
	.text
	.ent	Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$2,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$2
	lw	$9,0($4)
	lw	$10,4($4)
	lw	$11,8($4)
	sw	$9,0($sp)
	sw	$10,4($sp)
	sw	$11,8($sp)
	lw	$3,0($5)
	lw	$2,0($sp)
	#nop
	subu	$7,$3,$2
	sw	$7,16($sp)
	lw	$3,4($5)
	lw	$2,4($sp)
	#nop
	subu	$8,$3,$2
	sw	$8,20($sp)
	lw	$3,8($5)
	lw	$2,8($sp)
	#nop
	subu	$3,$3,$2
	sw	$3,24($sp)
	lw	$4,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1057
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1057:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1051
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1051:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,4($6)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1058
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1058:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1053
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1053:
	sra	$2,$2,8
	mult	$4,$2
	lw	$6,8($6)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1054
	addu	$4,$5,$9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1054:
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1055
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1055:
	sra	$2,$2,8
	mult	$6,$2
	mflo	$9
	#nop
	#nop
	addu	$2,$4,$9
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
	.text
	.ent	Newton_CalculateRoadPosition__FP13BO_tNewtonObj
Newton_CalculateRoadPosition__FP13BO_tNewtonObj:
	.frame	$sp,48,$31		# vars= 48, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$8,$4
	lh	$2,8($8)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	sw	$9,0($sp)
	sw	$10,4($sp)
	sw	$11,8($sp)
	lw	$9,160($8)
	lw	$10,164($8)
	lw	$11,168($8)
	sw	$9,32($sp)
	sw	$10,36($sp)
	sw	$11,40($sp)
	lw	$3,32($sp)
	lw	$2,0($sp)
	lw	$4,36($sp)
	lw	$5,40($sp)
	subu	$7,$3,$2
	lw	$2,4($sp)
	lw	$3,8($sp)
	sw	$7,16($sp)
	subu	$4,$4,$2
	subu	$5,$5,$3
	sw	$4,20($sp)
	sw	$5,24($sp)
	lw	$6,324($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1067
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1067:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1061
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1061:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($8)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1068
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1068:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1063
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1063:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,332($8)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1064
	addu	$3,$6,$9
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1064:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1065
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1065:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$9
	#nop
	#nop
	addu	$2,$3,$9
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Newton_CalculateRoadPosition__FP13BO_tNewtonObj
