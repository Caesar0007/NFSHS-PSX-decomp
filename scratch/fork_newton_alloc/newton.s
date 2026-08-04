	.file	1 "C:\\\\Temp\\\\nfs4-decomp-r3dcar-match\\\\recon\\\\game\\\\common\\\\newton.cpp"
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

	.lcomm	dummy.184,12
	.align	2
	.globl	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
	.align	2
	.globl	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	.align	2
	.globl	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji

	.lcomm	dummy.193,12
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
	beq	$2,$0,$L422
	lui	$2,%hi(GameSetup_gData+80) # high
	.set	macro
	.set	reorder

	lw	$4,400($18)
	jal	Force_HitWall__Fi
	lui	$2,%hi(GameSetup_gData+80) # high
$L422:
	lw	$2,%lo(GameSetup_gData+80)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L395
	srl	$2,$16,31
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	sra	$4,$2,1
	li	$2,6553600			# 0x00640000
	slt	$2,$2,$4
	beq	$2,$0,$L373
	li	$4,6553600			# 0x00640000
$L373:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L374
	srl	$2,$4,31
	.set	macro
	.set	reorder

	addu	$2,$4,$2
	sra	$4,$2,1
$L374:
	sll	$2,$23,2
	addu	$6,$18,$2
	lw	$3,536($6)
	#nop
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L423
	slt	$2,$23,8
	.set	macro
	.set	reorder

	move	$4,$3
$L423:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L395
	sw	$4,536($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L377
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,536($18)
	lw	$3,544($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,540($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L378
	move	$4,$3
$L378:
	lw	$2,536($18)
	lw	$3,560($18)
	.set	noreorder
	.set	nomacro
	j	$L421
	sw	$4,540($18)
	.set	macro
	.set	reorder

$L377:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L381
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$2,564($18)
	lw	$3,540($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,536($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L382
	move	$4,$3
$L382:
	lw	$2,540($18)
	lw	$3,548($18)
	sw	$4,536($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,544($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L383
	move	$4,$3
$L383:
	.set	noreorder
	.set	nomacro
	j	$L395
	sw	$4,544($18)
	.set	macro
	.set	reorder

$L381:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L385
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lw	$2,552($18)
	lw	$3,560($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,556($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L386
	move	$4,$3
$L386:
	lw	$2,536($18)
	lw	$3,560($18)
	sw	$4,556($18)
$L421:
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,564($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L387
	move	$4,$3
$L387:
	.set	noreorder
	.set	nomacro
	j	$L395
	sw	$4,564($18)
	.set	macro
	.set	reorder

$L385:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L389
	addu	$2,$23,2
	.set	macro
	.set	reorder

	lw	$2,564($18)
	lw	$3,540($18)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,536($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L390
	move	$4,$3
$L390:
	lw	$2,556($18)
	lw	$3,564($18)
	sw	$4,536($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$3,560($18)
	sra	$4,$2,1
	slt	$2,$4,$3
	beq	$2,$0,$L391
	move	$4,$3
$L391:
	.set	noreorder
	.set	nomacro
	j	$L395
	sw	$4,560($18)
	.set	macro
	.set	reorder

$L389:
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$3,536($2)
	#nop
	addu	$3,$4,$3
	srl	$2,$3,31
	addu	$3,$3,$2
	addu	$2,$23,1
	sll	$2,$2,2
	addu	$5,$18,$2
	lw	$4,536($5)
	sra	$3,$3,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L424
	addu	$2,$23,-2
	.set	macro
	.set	reorder

	move	$3,$4
$L424:
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
	beq	$2,$0,$L394
	move	$3,$4
$L394:
	sw	$3,536($5)
$L395:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L370
	li	$22,131072			# 0x00020000
	.set	macro
	.set	reorder

	move	$21,$0
	li	$2,5898240			# 0x005a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L397
	move	$20,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L398
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$5,$16,3
$L398:
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
	bne	$3,$0,$L399
	sw	$2,1932($18)
	.set	macro
	.set	reorder

	lw	$2,164($18)
	li	$3,65536			# 0x00010000
	addu	$2,$2,$3
	sw	$2,164($18)
$L399:
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
	slt	$2,$4,$3
	bne	$2,$0,$L400
	move	$4,$3
$L400:
	sw	$4,176($18)
	.set	noreorder
	.set	nomacro
	bgez	$16,$L401
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$16,31
$L401:
	sra	$19,$4,5
	li	$2,39321			# 0x00009999
	slt	$2,$2,$19
	beq	$2,$0,$L402
	li	$19,39321			# 0x00009999
$L402:
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L403
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,176($18)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L425
	li	$2,1310720			# 0x00140000
	.set	macro
	.set	reorder

	sw	$3,176($18)
$L403:
	li	$2,1310720			# 0x00140000
$L425:
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L404
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
	beq	$4,$0,$L405
	sll	$22,$10,2
	.set	macro
	.set	reorder

	subu	$19,$0,$19
$L405:
	li	$3,196608			# 0x00030000
	ori	$3,$3,0xffff
	addu	$2,$22,$21
	addu	$2,$2,$20
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L426
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,65535			# 0x0000ffff
	slt	$2,$3,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L427
	slt	$2,$3,$21
	.set	macro
	.set	reorder

	sll	$22,$10,3
$L427:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L428
	slt	$2,$3,$20
	.set	macro
	.set	reorder

	sll	$21,$21,1
$L428:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L426
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sll	$20,$20,1
$L404:
	li	$2,2			# 0x00000002
$L426:
	bne	$17,$2,$L411
	sll	$22,$22,1
	sll	$21,$21,1
	.set	noreorder
	.set	nomacro
	j	$L411
	sll	$20,$20,1
	.set	macro
	.set	reorder

$L397:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	bgez	$5,$L429
	sra	$19,$5,6
	.set	macro
	.set	reorder

	addu	$5,$5,63
	sra	$19,$5,6
$L429:
	li	$2,32768			# 0x00008000
	slt	$2,$2,$19
	beq	$2,$0,$L411
	li	$19,32768			# 0x00008000
$L411:
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
	beq	$2,$0,$L414
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
	j	$L419
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L414:
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
$L419:
	sw	$2,1060($18)
	addu	$2,$23,-2
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L416
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
	j	$L420
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L416:
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
$L420:
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
$L370:
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
	beq	$2,$0,$L433
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L434
	move	$6,$3
	.set	macro
	.set	reorder

$L433:
	addu	$2,$5,-1
	subu	$6,$4,$2
$L434:
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
	beq	$2,$0,$L456
	lbu	$2,144($22)
	lh	$fp,8($22)
	sltu	$6,$2,2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L438
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$0,368($22)
	sw	$0,364($22)
	sw	$0,360($22)
$L439:
	slt	$2,$5,4
	beq	$2,$0,$L440
	lw	$2,128($22)
	#nop
	beq	$2,$0,$L443
	lw	$7,16($4)
	lw	$8,20($4)
	lw	$9,24($4)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	j	$L444
$L443:
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
$L444:
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
	j	$L439
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L440:
	lw	$2,360($22)
	#nop
	bgez	$2,$L445
	addu	$2,$2,3
$L445:
	lw	$4,364($22)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L446
	sw	$2,360($22)
	.set	macro
	.set	reorder

	addu	$4,$4,3
$L446:
	lw	$3,368($22)
	sra	$2,$4,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L447
	sw	$2,364($22)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L447:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L448
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L438:
	lw	$2,128($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L449
	sll	$2,$fp,5
	.set	macro
	.set	reorder

	lw	$7,16($22)
	lw	$8,20($22)
	lw	$9,24($22)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
	j	$L448
$L449:
	lw	$3,BWorldSm_slices
	#nop
	addu	$2,$2,$3
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
$L448:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L451
	sll	$3,$fp,5
	.set	macro
	.set	reorder

	lb	$2,97($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L453
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
	j	$L453
	sw	$2,332($22)
	.set	macro
	.set	reorder

$L451:
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
$L453:
	lw	$4,gNumSlices
	addu	$3,$fp,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L455
	move	$6,$3
	.set	macro
	.set	reorder

	addu	$2,$4,-1
	subu	$6,$fp,$2
$L455:
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
$L456:
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
	beq	$2,$0,$L458
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$6,0($5)
	li	$2,65536			# 0x00010000
	subu	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bgez	$6,$L459
	sra	$7,$2,9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L459:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L460
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L460:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L461
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L461:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L462
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L462:
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

	j	$L468
$L458:
	lw	$6,0($5)
	#nop
	bgez	$6,$L464
	addu	$6,$6,255
$L464:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L465
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L465:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L466
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L466:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L467
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L467:
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

$L468:
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
	bgez	$6,$L470
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L470:
	lw	$3,0($4)
	lw	$2,0($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L471
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L471:
	sra	$2,$2,8
	mult	$3,$2
	lw	$6,8($5)
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L472
	subu	$8,$0,$10
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L472:
	lw	$3,8($4)
	lw	$2,8($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L473
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L473:
	sra	$2,$2,8
	mult	$3,$2
	move	$7,$0
	lui	$2,%hi(fudgeTable) # high
	addiu	$9,$2,%lo(fudgeTable) # low
	mflo	$10
	#nop
	#nop
	subu	$8,$8,$10
$L474:
	bne	$7,$0,$L477
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
	bne	$2,$0,$L487
	.set	noreorder
	.set	nomacro
	j	$L489
	sra	$2,$6,2
	.set	macro
	.set	reorder

$L477:
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
	beq	$2,$0,$L481
$L487:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L480
	addu	$3,$6,$2
	.set	macro
	.set	reorder

$L481:
	sra	$2,$6,2
$L489:
	addu	$3,$3,$2
$L480:
	sra	$2,$3,15
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$3,$L483
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,31
$L483:
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
	bne	$2,$0,$L474
	li	$2,40632			# 0x00009eb8
	.set	macro
	.set	reorder

	lw	$5,4($5)
	#nop
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L485
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

	j	$L488
$L485:
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$4,$8
	.set	macro
	.set	reorder

$L488:
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
	bne	$2,$0,$L491
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
	j	$L492
	sw	$3,816($16)
	.set	macro
	.set	reorder

$L491:
	li	$6,-2097152000			# 0x83000000
$L492:
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
	.frame	$sp,456,$31		# vars= 400, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,456
	sw	$20,432($sp)
	move	$20,$4
	sw	$31,452($sp)
	sw	$fp,448($sp)
	sw	$23,444($sp)
	sw	$22,440($sp)
	sw	$21,436($sp)
	sw	$19,428($sp)
	sw	$18,424($sp)
	sw	$17,420($sp)
	sw	$16,416($sp)
	sw	$5,460($sp)
	lw	$3,252($20)
	lw	$4,256($20)
	lw	$5,260($20)
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$3,80($sp)
	sw	$4,84($sp)
	sw	$5,88($sp)
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
	sw	$12,112($sp)
	sw	$11,116($sp)
	mflo	$10
	#nop
	#nop
	sw	$10,120($sp)
	lw	$2,312($20)
	sra	$3,$3,8
	subu	$2,$0,$2
	sra	$2,$2,8
	mult	$2,$3
	mflo	$3
	#nop
	sra	$4,$4,8
	mult	$2,$4
	mflo	$4
	#nop
	sra	$5,$5,8
	mult	$2,$5
	addu	$16,$sp,160
	addu	$18,$20,8
	addu	$17,$20,136
	sw	$0,404($sp)
	sw	$0,400($sp)
	sw	$3,144($sp)
	sw	$4,148($sp)
	mflo	$2
	#nop
	#nop
	sw	$2,152($sp)
	lw	$6,160($20)
	lw	$7,164($20)
	lw	$8,168($20)
	addu	$6,$6,$3
	addu	$7,$7,$4
	addu	$8,$8,$2
	addu	$5,$6,$14
	subu	$2,$5,$12
	addu	$4,$7,$13
	sw	$6,128($sp)
	sw	$7,132($sp)
	sw	$8,136($sp)
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
	subu	$7,$7,$13
	sw	$2,56($sp)
	subu	$2,$7,$11
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
$L494:
	lw	$15,0($18)
	lw	$23,4($18)
	lw	$24,8($18)
	lw	$25,12($18)
	sw	$15,0($16)
	sw	$23,4($16)
	sw	$24,8($16)
	sw	$25,12($16)
	addu	$18,$18,16
	.set	noreorder
	.set	nomacro
	bne	$18,$17,$L494
	addu	$16,$16,16
	.set	macro
	.set	reorder

	addu	$22,$sp,96
	addu	$19,$sp,32
	addu	$2,$20,192
	sltu	$2,$20,$2
	lw	$15,0($18)
	sw	$15,0($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L496
	sw	$20,408($sp)
	.set	macro
	.set	reorder

	addu	$fp,$sp,160
	addu	$21,$20,664
	addu	$17,$sp,36
	addu	$16,$sp,104
$L498:
	move	$4,$19
	move	$5,$fp
	lw	$15,0($19)
	lw	$23,4($19)
	lw	$24,8($19)
	sw	$15,0($22)
	sw	$23,4($22)
	sw	$24,8($22)
	lw	$2,0($17)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
	sw	$2,12($21)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UNormal__FP12BWorldSm_Pos
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$15,0($2)
	lw	$23,4($2)
	lw	$24,8($2)
	sw	$15,296($sp)
	sw	$23,300($sp)
	sw	$24,304($sp)
	lw	$2,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L499
	li	$4,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$4,0($2)
$L499:
	sw	$4,32($21)
	lw	$2,300($sp)
	#nop
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L501
	andi	$4,$4,0x000f
	.set	macro
	.set	reorder

	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L581
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	bne	$4,$0,$L500
$L501:
	li	$2,65536			# 0x00010000
$L581:
	sw	$2,300($sp)
	lw	$2,16($sp)
	sw	$0,296($sp)
	sw	$0,304($sp)
	lw	$3,0($19)
	#nop
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$3,0($17)
	lw	$2,392($20)
	#nop
	subu	$18,$3,$2
$L502:
	lw	$2,20($sp)
	#nop
	addu	$2,$2,$18
	sw	$2,20($sp)
	lw	$2,24($sp)
	lw	$3,4($17)
	.set	noreorder
	.set	nomacro
	j	$L578
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L500:
	lw	$2,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L504
	addu	$2,$4,-2
	.set	macro
	.set	reorder

	lh	$2,160($sp)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$15,0($2)
	lw	$23,4($2)
	lw	$24,8($2)
	sw	$15,312($sp)
	sw	$23,316($sp)
	sw	$24,320($sp)
	.set	noreorder
	.set	nomacro
	j	$L579
	addu	$2,$4,-2
	.set	macro
	.set	reorder

$L504:
	lw	$15,168($sp)
	lw	$23,172($sp)
	lw	$24,176($sp)
	sw	$15,312($sp)
	sw	$23,316($sp)
	sw	$24,320($sp)
$L579:
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L506
	move	$4,$19
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
	j	$L580
	sw	$2,-4($16)
	.set	macro
	.set	reorder

$L506:
	addu	$5,$sp,296
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationGeneral__FP8coorddefN20
	addu	$6,$sp,312
	.set	macro
	.set	reorder

	sw	$2,-4($16)
$L580:
	lw	$2,-4($16)
	#nop
	sw	$2,12($21)
	lw	$3,-4($16)
	lw	$2,0($17)
	#nop
	subu	$3,$3,$2
	li	$2,131072			# 0x00020000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L508
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	sw	$0,296($sp)
	sw	$2,300($sp)
	sw	$0,304($sp)
	lw	$2,0($17)
	#nop
	sw	$2,-4($16)
	lw	$2,16($sp)
	lw	$3,0($19)
	#nop
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$18,0($17)
	j	$L502
$L508:
	lw	$2,16($sp)
	lw	$3,0($22)
	#nop
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,20($sp)
	lw	$3,-4($16)
	#nop
	addu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,24($sp)
	lw	$3,0($16)
	#nop
	addu	$2,$2,$3
$L578:
	sw	$2,24($sp)
	addu	$16,$16,12
	lw	$15,0($22)
	lw	$23,4($22)
	lw	$24,8($22)
	sw	$15,-12($21)
	sw	$23,-8($21)
	sw	$24,-4($21)
	addu	$22,$22,12
	addu	$17,$17,12
	addu	$19,$19,12
	lw	$15,296($sp)
	lw	$23,300($sp)
	lw	$24,304($sp)
	sw	$15,0($21)
	sw	$23,4($21)
	sw	$24,8($21)
	addu	$21,$21,48
	lw	$15,408($sp)
	addu	$2,$20,192
	addu	$15,$15,48
	sltu	$2,$15,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L498
	sw	$15,408($sp)
	.set	macro
	.set	reorder

$L496:
	move	$21,$0
	move	$6,$21
	li	$8,1			# 0x00000001
	move	$7,$21
	addu	$5,$20,680
	sw	$0,296($sp)
	sw	$0,304($sp)
$L510:
	slt	$2,$6,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L511
	addu	$3,$sp,$7
	.set	macro
	.set	reorder

	lw	$2,-24($5)
	lw	$3,36($3)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,300($sp)
	sw	$0,8($5)
	lw	$3,300($sp)
	#nop
	slt	$2,$3,-9829
	beq	$2,$0,$L514
	sw	$8,4($5)
	lw	$23,404($sp)
	#nop
	addu	$23,$23,1
	.set	noreorder
	.set	nomacro
	j	$L515
	sw	$23,404($sp)
	.set	macro
	.set	reorder

$L514:
	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L582
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	bgtz	$3,$L517
	lw	$2,392($20)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L582
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$2,176($20)
	#nop
	slt	$2,$2,-6552
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L582
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$3,300($20)
	li	$2,62259			# 0x0000f333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L582
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L582
	sw	$0,4($5)
	.set	macro
	.set	reorder

$L517:
	lw	$24,400($sp)
	#nop
	addu	$24,$24,1
	sw	$24,400($sp)
	sw	$0,4($5)
	sw	$8,8($5)
$L515:
	li	$2,3473408			# 0x00350000
$L582:
	lw	$3,192($20)
	ori	$2,$2,0x8000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L520
	li	$4,-13107			# 0xffffcccd
	.set	macro
	.set	reorder

	li	$4,-9830			# 0xffffd99a
$L520:
	lw	$2,300($sp)
	#nop
	slt	$2,$2,$4
	beq	$2,$0,$L521
	sw	$4,300($sp)
$L521:
	lw	$16,300($sp)
	#nop
	bgez	$16,$L522
	addu	$16,$16,255
$L522:
	lw	$2,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L583
	sra	$3,$16,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L583:
	sra	$2,$2,8
	mult	$3,$2
	sll	$2,$6,2
	addu	$2,$sp,$2
	mflo	$16
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$16,$L524
	sw	$16,328($2)
	.set	macro
	.set	reorder

	addu	$16,$16,255
$L524:
	lw	$2,1124($20)
	#nop
	lw	$2,312($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L584
	sra	$3,$16,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L584:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$16
	#nop
	#nop
	sw	$16,0($5)
	lw	$2,648($20)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L526
	sll	$2,$16,1
	.set	macro
	.set	reorder

	sw	$2,0($5)
$L526:
	addu	$5,$5,48
	addu	$7,$7,12
	.set	noreorder
	.set	nomacro
	j	$L510
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L511:
	lw	$15,400($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$15,$0,$L585
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
	addu	$21,$2,$4
$L585:
	addu	$18,$20,680
$L528:
	slt	$2,$19,4
	beq	$2,$0,$L529
	lw	$23,400($sp)
	lw	$17,0($18)
	bne	$23,$0,$L532
	.set	noreorder
	.set	nomacro
	bgez	$17,$L534
	li	$2,56360			# 0x0000dc28
	.set	macro
	.set	reorder

	lw	$3,300($20)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L534
	sra	$17,$17,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L534
	sw	$17,0($18)
	.set	macro
	.set	reorder

$L532:
	lw	$2,8($18)
	#nop
	beq	$2,$0,$L534
	lw	$3,176($20)
	#nop
	bgez	$3,$L534
	lw	$2,388($20)
	#nop
	subu	$16,$2,$3
	bltz	$16,$L534
	div	$3,$16,$21
	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L538
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
	beq	$2,$0,$L539
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L540
	li	$16,19660			# 0x00004ccc
	.set	macro
	.set	reorder

$L539:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,4096			# 0x00001000
	.set	macro
	.set	reorder

	move	$16,$2
$L540:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$17,$2
$L538:
	lw	$2,0($18)
	#nop
	addu	$2,$2,$17
	sw	$2,0($18)
$L534:
	addu	$18,$18,48
	.set	noreorder
	.set	nomacro
	j	$L528
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L529:
	move	$18,$0
	lui	$2,%hi(swap) # high
	addiu	$17,$2,%lo(swap) # low
	move	$16,$18
$L541:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L542
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

	move	$4,$2
	bgtz	$4,$L545
	lw	$2,1124($20)
	#nop
	lw	$2,336($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$4,$3
	beq	$2,$0,$L547
	.set	noreorder
	.set	nomacro
	j	$L547
	move	$4,$3
	.set	macro
	.set	reorder

$L545:
	lw	$2,1124($20)
	#nop
	lw	$3,336($2)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L547
	move	$4,$3
$L547:
	lw	$3,0($17)
	addu	$17,$17,4
	addu	$16,$16,12
	addu	$18,$18,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$20
	.set	noreorder
	.set	nomacro
	j	$L541
	sw	$4,692($2)
	.set	macro
	.set	reorder

$L542:
	addu	$4,$sp,344
	lw	$2,16($sp)
	lw	$3,20($sp)
	lw	$6,108($sp)
	lw	$5,132($sp)
	sra	$2,$2,2
	sw	$2,16($sp)
	lw	$2,24($sp)
	sra	$3,$3,2
	sw	$3,20($sp)
	lw	$3,120($sp)
	sra	$2,$2,2
	addu	$3,$3,$5
	sw	$2,24($sp)
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
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$4,352($sp)
	lw	$5,296($sp)
	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,312($sp)
	.set	macro
	.set	reorder

	lw	$4,344($sp)
	lw	$5,304($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$4,344($sp)
	lw	$5,300($sp)
	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,316($sp)
	.set	macro
	.set	reorder

	lw	$4,348($sp)
	lw	$5,296($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,312
	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,320($sp)
	.set	macro
	.set	reorder

	lw	$2,316($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L549
	li	$15,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$23,460($sp)
	li	$2,65536			# 0x00010000
	sw	$15,404($sp)
	sw	$0,0($23)
	sw	$2,4($23)
	.set	noreorder
	.set	nomacro
	j	$L550
	sw	$0,8($23)
	.set	macro
	.set	reorder

$L549:
	lw	$2,312($sp)
	lw	$24,460($sp)
	#nop
	sw	$2,0($24)
	lw	$2,316($sp)
	#nop
	sw	$2,4($24)
	lw	$2,320($sp)
	#nop
	sw	$2,8($24)
	lw	$3,316($sp)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L586
	li	$3,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	li	$25,4			# 0x00000004
	sw	$25,404($sp)
$L550:
	li	$3,-65536			# 0xffff0000
$L586:
	lw	$2,300($20)
	ori	$3,$3,0x199a
	slt	$2,$2,$3
	beq	$2,$0,$L552
	lw	$3,276($20)
	#nop
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$18,$2,$3
	bgez	$18,$L553
	addu	$18,$18,255
$L553:
	lw	$3,280($20)
	sra	$2,$18,8
	sw	$2,276($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$18,$2,$3
	bgez	$18,$L554
	addu	$18,$18,255
$L554:
	lw	$3,284($20)
	sra	$2,$18,8
	sw	$2,280($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$18,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$18,$L587
	sra	$2,$18,8
	.set	macro
	.set	reorder

	addu	$18,$18,255
	sra	$2,$18,8
$L587:
	.set	noreorder
	.set	nomacro
	j	$L556
	sw	$2,284($20)
	.set	macro
	.set	reorder

$L552:
	lw	$15,404($sp)
	#nop
	slt	$2,$15,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L588
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
	move	$18,$2
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

	addu	$3,$18,$17
	lw	$6,276($20)
	lw	$5,252($20)
	addu	$3,$3,$2
	sw	$3,1060($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$4,280($20)
	lw	$5,256($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
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

	addu	$3,$18,$17
	lw	$6,276($20)
	lw	$5,264($20)
	addu	$3,$3,$2
	sw	$3,1064($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$4,280($20)
	lw	$5,268($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
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

	addu	$3,$18,$17
	addu	$3,$3,$2
	sw	$3,1068($20)
	lw	$3,776($20)
	lw	$5,824($20)
	lw	$2,680($20)
	lw	$4,728($20)
	addu	$3,$3,$5
	addu	$2,$2,$4
	subu	$3,$3,$2
	sra	$6,$3,2
	bgtz	$6,$L558
	lw	$2,1124($20)
	#nop
	lw	$2,316($2)
	#nop
	subu	$18,$0,$2
	slt	$2,$18,$6
	beq	$2,$0,$L560
	.set	noreorder
	.set	nomacro
	j	$L560
	move	$18,$6
	.set	macro
	.set	reorder

$L558:
	lw	$2,1124($20)
	#nop
	lw	$18,316($2)
	#nop
	slt	$2,$18,$6
	bne	$2,$0,$L560
	move	$18,$6
$L560:
	lw	$3,680($20)
	lw	$5,776($20)
	lw	$2,728($20)
	lw	$4,824($20)
	addu	$3,$3,$5
	addu	$2,$2,$4
	subu	$3,$3,$2
	sra	$17,$3,2
	bgtz	$17,$L562
	lw	$2,1124($20)
	#nop
	lw	$2,320($2)
	#nop
	subu	$16,$0,$2
	slt	$2,$16,$17
	beq	$2,$0,$L564
	.set	noreorder
	.set	nomacro
	j	$L564
	move	$16,$17
	.set	macro
	.set	reorder

$L562:
	lw	$2,1124($20)
	#nop
	lw	$16,320($2)
	#nop
	slt	$2,$16,$17
	bne	$2,$0,$L564
	move	$16,$17
$L564:
	lw	$17,1060($20)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$17,$L566
	move	$6,$17
	.set	macro
	.set	reorder

	subu	$17,$0,$17
$L566:
	li	$19,65536			# 0x00010000
	ori	$19,$19,0x3332
	slt	$2,$19,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L567
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$5,304($2)
$L567:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$17,1068($20)
	sw	$2,1060($20)
	addu	$2,$2,$18
	move	$18,$17
	.set	noreorder
	.set	nomacro
	bgez	$18,$L568
	sw	$2,1060($20)
	.set	macro
	.set	reorder

	subu	$18,$0,$18
$L568:
	slt	$2,$19,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L569
	li	$6,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$6,308($2)
$L569:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$6
	.set	macro
	.set	reorder

	addu	$4,$20,240
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
	move	$18,$2
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

	addu	$3,$18,$17
	lw	$6,1060($20)
	addu	$3,$3,$2
	sw	$3,276($20)
	lw	$5,372($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$4,1064($20)
	lw	$5,376($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
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

	addu	$3,$18,$17
	lw	$6,1060($20)
	addu	$3,$3,$2
	sw	$3,280($20)
	lw	$5,384($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$4,1064($20)
	lw	$5,388($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
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

	addu	$3,$18,$17
	addu	$3,$3,$2
	sw	$3,284($20)
$L556:
	lui	$2,%hi(simGlobal+4) # high
$L588:
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L571
	addu	$6,$20,360
	.set	macro
	.set	reorder

	addu	$6,$sp,16
$L571:
	lw	$5,460($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	move	$4,$20
	.set	macro
	.set	reorder

	sw	$2,392($20)
	lw	$2,20($sp)
	lw	$31,452($sp)
	lw	$fp,448($sp)
	lw	$23,444($sp)
	lw	$22,440($sp)
	lw	$21,436($sp)
	lw	$20,432($sp)
	lw	$19,428($sp)
	lw	$18,424($sp)
	lw	$17,420($sp)
	lw	$16,416($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,456
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

	beq	$2,$0,$L589
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

$L589:
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
	bgez	$3,$L593
	subu	$sp,$sp,32
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L593:
	lw	$2,240($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L594
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L594:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L595
	addu	$3,$3,255
$L595:
	lw	$2,244($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L596
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L596:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L597
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L597:
	lw	$2,248($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L598
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L598:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L599
	addu	$3,$3,255
$L599:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L600
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L600:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	sw	$15,0($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L601
	addu	$3,$3,255
$L601:
	lw	$2,252($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L602
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L602:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L603
	addu	$3,$3,255
$L603:
	lw	$2,256($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L604
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L604:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L605
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L605:
	lw	$2,260($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L606
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L606:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L607
	addu	$3,$3,255
$L607:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L608
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L608:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sw	$8,4($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L609
	addu	$3,$3,255
$L609:
	lw	$2,264($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L610
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L610:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L611
	addu	$3,$3,255
$L611:
	lw	$2,268($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L612
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L612:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L613
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L613:
	lw	$2,272($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L614
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L614:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L615
	addu	$3,$3,255
$L615:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L616
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L616:
	sra	$2,$2,8
	mult	$3,$2
	li	$13,-1			# 0xffffffff
	lw	$14,0($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$14,$L617
	sw	$9,8($sp)
	.set	macro
	.set	reorder

	li	$13,1			# 0x00000001
$L617:
	.set	noreorder
	.set	nomacro
	bgez	$8,$L618
	li	$12,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$12,1			# 0x00000001
$L618:
	.set	noreorder
	.set	nomacro
	bgez	$9,$L619
	li	$11,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
$L619:
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
	bgez	$4,$L627
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L627:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L621
	sra	$6,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L621:
	sra	$2,$2,8
	mult	$6,$2
	lw	$4,4($5)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L628
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L628:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L623
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L623:
	sra	$2,$2,8
	mult	$4,$2
	lw	$5,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L624
	addu	$3,$6,$15
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L624:
	move	$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$2,$L625
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L625:
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
	bne	$2,$0,$L630
	lw	$2,308($18)
	.set	noreorder
	.set	nomacro
	j	$L634
	subu	$2,$16,$2
	.set	macro
	.set	reorder

$L630:
	lw	$2,312($18)
	#nop
	subu	$2,$16,$2
$L634:
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
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lui	$2,%hi(GameSetup_gData+28) # high
	lw	$2,%lo(GameSetup_gData+28)($2)
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	lw	$3,160($16)
	lw	$4,160($2)
	#nop
	subu	$6,$3,$4
	.set	noreorder
	.set	nomacro
	bgtz	$6,$L636
	move	$7,$0
	.set	macro
	.set	reorder

	subu	$6,$4,$3
$L636:
	lw	$5,168($16)
	lw	$4,168($2)
	#nop
	subu	$3,$5,$4
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L659
	slt	$2,$3,$6
	.set	macro
	.set	reorder

	subu	$3,$4,$5
	slt	$2,$3,$6
$L659:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L639
	addu	$3,$6,$2
	.set	macro
	.set	reorder

$L638:
	sra	$2,$6,2
	addu	$3,$3,$2
$L639:
	sw	$3,140($16)
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L640
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
	lw	$4,160($2)
	#nop
	subu	$3,$5,$4
	bgtz	$3,$L641
	subu	$3,$4,$5
$L641:
	lw	$4,168($2)
	lw	$2,168($16)
	#nop
	subu	$5,$2,$4
	bgtz	$5,$L642
	subu	$5,$4,$2
$L642:
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	sra	$2,$5,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L644
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L643:
	sra	$2,$3,2
	addu	$3,$5,$2
$L644:
	lw	$2,140($16)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L640
	li	$7,1			# 0x00000001
	sw	$3,140($16)
$L640:
	lw	$2,140($16)
	li	$17,6291456			# 0x00600000
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L646
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	sll	$2,$7,2
	addu	$2,$2,$3
	lw	$4,0($2)
	addu	$5,$16,8
	.set	noreorder
	.set	nomacro
	jal	BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
	addu	$4,$4,8
	.set	macro
	.set	reorder

	lw	$3,140($16)
	#nop
	slt	$3,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L646
	move	$4,$2
	.set	macro
	.set	reorder

	bne	$4,$0,$L648
$L646:
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L648
$L650:
	lbu	$2,144($16)
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L651
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,444($16)
	sw	$2,448($16)
$L651:
	sb	$3,144($16)
	sw	$0,276($16)
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$0,284($16)
	.set	macro
	.set	reorder

$L648:
	lw	$2,608($16)
	lbu	$4,144($16)
	andi	$2,$2,0x0030
	bne	$2,$0,$L652
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L652
$L653:
	lw	$3,140($16)
	li	$2,4718592			# 0x00480000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L654
	sb	$2,144($16)
	.set	macro
	.set	reorder

$L652:
	sb	$0,144($16)
$L654:
	andi	$2,$4,0x00ff
	sltu	$2,$2,2
	bne	$2,$0,$L635
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
	bne	$2,$0,$L656
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$5,%hi(dummy_124) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_124) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L657
	sw	$2,384($16)
	.set	macro
	.set	reorder

$L656:
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
$L657:
	lw	$4,384($16)
	lw	$3,312($16)
	li	$2,1			# 0x00000001
	sw	$2,444($16)
	sw	$2,448($16)
	sw	$0,388($16)
	sw	$0,400($16)
	sw	$0,404($16)
	sw	$0,392($16)
	addu	$2,$4,$3
	sw	$2,164($16)
$L635:
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
	beq	$2,$0,$L660
	jal	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	lb	$2,97($16)
	#nop
	beq	$2,$0,$L662
	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

$L662:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L660
	lw	$3,128($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L664
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($3)
$L664:
	sw	$2,444($16)
	andi	$2,$2,0x000f
	sw	$2,448($16)
$L660:
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
	bne	$5,$0,$L667
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,240
	addu	$2,$4,324
	addu	$3,$4,356
$L668:
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
	bne	$2,$3,$L668
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

$L667:
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
	bne	$5,$0,$L671
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,452
	addu	$2,$4,324
	addu	$3,$4,356
$L672:
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
	bne	$2,$3,$L672
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

$L671:
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
	.frame	$sp,136,$31		# vars= 80, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$fp,128($sp)
	move	$fp,$4
	sw	$18,104($sp)
	move	$18,$6
	sw	$5,140($sp)
	move	$4,$5
	addu	$5,$fp,8
	xori	$7,$7,0x0001
	sltu	$7,$0,$7
	sw	$31,132($sp)
	sw	$23,124($sp)
	sw	$22,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$17,100($sp)
	sw	$16,96($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	sw	$7,88($sp)
	.set	macro
	.set	reorder

	lhu	$8,140($sp)
	#nop
	sh	$8,6($fp)
	lw	$8,140($sp)
	lw	$5,BWorldSm_slices
	sll	$8,$8,5
	addu	$3,$8,$5
	sw	$8,92($sp)
	lbu	$2,18($3)
	#nop
	sll	$2,$2,9
	sw	$2,324($fp)
	lbu	$2,19($3)
	#nop
	sll	$2,$2,9
	sw	$2,328($fp)
	lbu	$2,20($3)
	#nop
	sll	$2,$2,9
	sw	$2,332($fp)
	lbu	$2,12($3)
	#nop
	sll	$2,$2,9
	sw	$2,336($fp)
	lbu	$2,13($3)
	#nop
	sll	$2,$2,9
	sw	$2,340($fp)
	lbu	$2,14($3)
	#nop
	sll	$2,$2,9
	sw	$2,344($fp)
	lbu	$2,15($3)
	#nop
	sll	$2,$2,9
	sw	$2,348($fp)
	lbu	$2,16($3)
	addu	$16,$fp,324
	sll	$2,$2,9
	sw	$2,352($fp)
	lbu	$2,17($3)
	move	$4,$16
	sll	$2,$2,9
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,356($fp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$fp,336
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$fp,348
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	move	$4,$fp
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
	move	$23,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$22,$2
	.set	macro
	.set	reorder

	lw	$4,0($18)
	lw	$5,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$21,$2
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$20,$2
	.set	macro
	.set	reorder

	lw	$4,0($18)
	lw	$5,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$2
	.set	macro
	.set	reorder

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
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$20
	addu	$17,$17,$19
	addu	$16,$16,$18
	lw	$3,BWorldSm_slices
	lw	$8,92($sp)
	addu	$16,$16,$2
	addu	$5,$3,$8
	addu	$3,$23,$22
	lw	$4,0($5)
	addu	$3,$3,$21
	addu	$3,$3,$4
	sw	$3,160($fp)
	lw	$3,4($5)
	lw	$2,608($fp)
	addu	$17,$17,$3
	sw	$17,164($fp)
	lw	$3,8($5)
	andi	$2,$2,0x0004
	addu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	sw	$16,168($fp)
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L676
	sb	$2,144($fp)
	.set	macro
	.set	reorder

$L675:
	sb	$0,144($fp)
$L676:
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadInfo__FP13BO_tNewtonObj
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
	move	$4,$fp
	.set	macro
	.set	reorder

	lbu	$3,144($fp)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L677
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$8,140($sp)
	lw	$2,BWorldSm_slices
	sll	$3,$8,5
	addu	$3,$3,$2
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L678
	sw	$2,384($fp)
	.set	macro
	.set	reorder

$L677:
	.set	noreorder
	.set	nomacro
	bne	$3,$16,$L679
	move	$23,$0
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$3,$23
	lw	$5,BWorldSm_slices
$L683:
	lw	$2,128($fp)
	#nop
	bne	$2,$0,$L684
	lh	$2,8($fp)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$5
	lw	$2,4($2)
	.set	noreorder
	.set	nomacro
	j	$L697
	sw	$2,76($sp)
	.set	macro
	.set	reorder

$L684:
	lw	$2,20($4)
	#nop
	sw	$2,76($sp)
$L697:
	lw	$2,76($sp)
	addu	$3,$3,1
	addu	$23,$23,$2
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L683
	addu	$4,$4,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$23,$L698
	sra	$2,$23,2
	.set	macro
	.set	reorder

	addu	$23,$23,3
	sra	$2,$23,2
$L698:
	.set	noreorder
	.set	nomacro
	j	$L678
	sw	$2,384($fp)
	.set	macro
	.set	reorder

$L679:
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	move	$4,$fp
	.set	macro
	.set	reorder

	lui	$5,%hi(dummy_133) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_133) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L690
	sw	$2,384($fp)
	.set	macro
	.set	reorder

$L689:
	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$fp
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
	sw	$2,384($fp)
	.set	macro
	.set	reorder

	sw	$2,gWSavePtr
	sw	$16,stackSpeedUpEnbabledFlag
$L690:
	lw	$2,384($fp)
	lw	$3,312($fp)
	#nop
	addu	$2,$2,$3
	sw	$2,164($fp)
$L678:
	move	$4,$fp
	addu	$5,$fp,336
	.set	noreorder
	.set	nomacro
	jal	Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
	addu	$6,$fp,360
	.set	macro
	.set	reorder

	lw	$22,164($fp)
	lbu	$3,144($fp)
	sw	$0,392($fp)
	subu	$2,$22,$2
	andi	$3,$3,0x00ff
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L691
	sw	$2,164($fp)
	.set	macro
	.set	reorder

	lw	$2,128($fp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	li	$23,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L693
	sw	$2,444($fp)
	.set	macro
	.set	reorder

$L691:
	li	$23,1			# 0x00000001
$L694:
	sw	$23,444($fp)
$L693:
	lw	$2,444($fp)
	#nop
	andi	$2,$2,0x000f
	sw	$2,448($fp)
	lw	$31,132($sp)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
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
	addu	$sp,$sp,136
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
	beq	$2,$0,$L700
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	sll	$2,$6,2
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sw	$2,184($16)
$L700:
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L701
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L702
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
	bne	$2,$0,$L703
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
	beq	$2,$0,$L702
$L703:
	lw	$2,184($16)
	#nop
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L701
	sw	$2,184($16)
	.set	macro
	.set	reorder

$L702:
	lw	$2,184($16)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	sw	$3,184($16)
$L701:
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
	bgez	$17,$L705
	sw	$19,316($16)
	.set	macro
	.set	reorder

	addu	$3,$17,255
$L705:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$18,$L707
	move	$2,$18
	.set	macro
	.set	reorder

	addu	$2,$18,255
$L707:
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
	bgez	$2,$L709
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$3,$2,255
$L709:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$19,$L711
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$19,255
$L711:
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
$L713:
	sw	$0,536($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L713
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
	beq	$2,$0,$L718
	lui	$2,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
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
	j	$L718
	sw	$3,164($18)
	.set	macro
	.set	reorder

$L720:
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
$L718:
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
	.frame	$sp,368,$31		# vars= 320, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,368
	sw	$20,352($sp)
	move	$20,$4
	sw	$22,360($sp)
	move	$22,$5
	lw	$3,392($sp)
	move	$5,$6
	sw	$21,356($sp)
	move	$21,$7
	sw	$17,340($sp)
	addu	$17,$sp,216
	sw	$18,344($sp)
	move	$18,$22
	sw	$31,364($sp)
	sw	$19,348($sp)
	.set	noreorder
	.set	nomacro
	bgez	$18,$L724
	sw	$16,336($sp)
	.set	macro
	.set	reorder

	subu	$18,$0,$18
$L724:
	move	$16,$5
	bgez	$16,$L725
	subu	$16,$0,$16
$L725:
	.set	noreorder
	.set	nomacro
	bgez	$21,$L726
	move	$19,$21
	.set	macro
	.set	reorder

	subu	$19,$0,$21
$L726:
	lw	$2,384($sp)
	#nop
	sw	$0,0($2)
	lw	$2,0($3)
	move	$4,$17
	addu	$2,$2,$18
	addu	$2,$2,$16
	addu	$2,$2,$19
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	sw	$2,0($3)
	.set	macro
	.set	reorder

	slt	$2,$16,20
	xori	$8,$2,0x0001
	slt	$2,$18,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	addu	$6,$sp,296
	.set	macro
	.set	reorder

	addu	$7,$sp,248
	addu	$5,$sp,308
	addu	$4,$sp,228
$L728:
	lw	$18,-8($4)
	lw	$16,-4($4)
	lw	$3,0($4)
	addu	$4,$4,16
	lw	$2,0($17)
	addu	$17,$17,16
	sw	$2,0($6)
	sw	$18,-8($5)
	sw	$16,-4($5)
	sw	$3,0($5)
	addu	$5,$5,16
	.set	noreorder
	.set	nomacro
	bne	$17,$7,$L728
	addu	$6,$6,16
	.set	macro
	.set	reorder

	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L727:
	addu	$16,$sp,176
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedxformx
	move	$5,$22
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	addu	$6,$sp,296
	.set	macro
	.set	reorder

	li	$8,1			# 0x00000001
$L732:
	slt	$2,$19,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L733
	addu	$17,$sp,296
	.set	macro
	.set	reorder

	addu	$5,$sp,328
	addu	$4,$20,12
	addu	$3,$sp,308
$L734:
	lw	$18,-8($3)
	lw	$16,-4($3)
	lw	$19,0($3)
	addu	$3,$3,16
	lw	$2,0($17)
	addu	$17,$17,16
	sw	$2,0($20)
	sw	$18,-8($4)
	sw	$16,-4($4)
	sw	$19,0($4)
	addu	$4,$4,16
	.set	noreorder
	.set	nomacro
	bne	$17,$5,$L734
	addu	$20,$20,16
	.set	macro
	.set	reorder

	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L738
	sw	$2,0($20)
	.set	macro
	.set	reorder

$L733:
	addu	$16,$sp,256
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedxformz
	move	$5,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,296
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$20
	.set	macro
	.set	reorder

	li	$8,1			# 0x00000001
$L738:
	lw	$31,364($sp)
	lw	$22,360($sp)
	lw	$21,356($sp)
	lw	$20,352($sp)
	lw	$19,348($sp)
	lw	$18,344($sp)
	lw	$17,340($sp)
	lw	$16,336($sp)
	move	$2,$8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,368
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
	beq	$2,$0,$L739
	lw	$2,276($17)
	#nop
	bgez	$2,$L741
	addu	$2,$2,63
$L741:
	sra	$2,$2,6
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L742
	addu	$2,$2,63
$L742:
	sra	$2,$2,6
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L743
	addu	$2,$2,63
$L743:
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
	beq	$2,$0,$L739
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
	beq	$2,$0,$L746
	lw	$2,88($sp)
	#nop
	beq	$2,$0,$L739
$L746:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sb	$2,146($17)
	sw	$0,152($17)
$L739:
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
	beq	$2,$0,$L747
	lbu	$2,144($17)
	#nop
	bne	$2,$0,$L747
	lw	$2,276($17)
	#nop
	bgez	$2,$L749
	addu	$2,$2,15
$L749:
	sra	$2,$2,4
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L750
	addu	$2,$2,15
$L750:
	sra	$2,$2,4
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L751
	addu	$2,$2,15
$L751:
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
	beq	$2,$0,$L747
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
	bne	$2,$0,$L754
	lbu	$2,146($17)
	#nop
	addu	$2,$2,-1
	sb	$2,146($17)
	andi	$2,$2,0x00ff
	bne	$2,$0,$L747
$L754:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,64			# 0x00000040
	sb	$2,146($17)
	sw	$0,152($17)
$L747:
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
	bne	$2,$0,$L756
	move	$10,$5
	.set	macro
	.set	reorder

	li	$2,58982			# 0x0000e666
	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L756
	addu	$9,$17,452
	.set	macro
	.set	reorder

	addu	$8,$17,240
	addu	$11,$17,272
	addu	$7,$17,464
	addu	$6,$17,252
$L757:
	lw	$3,-8($6)
	lw	$4,-4($6)
	lw	$5,0($6)
	addu	$6,$6,16
	lw	$2,0($8)
	addu	$8,$8,16
	sw	$2,0($9)
	sw	$3,-8($7)
	sw	$4,-4($7)
	sw	$5,0($7)
	addu	$7,$7,16
	.set	noreorder
	.set	nomacro
	bne	$8,$11,$L757
	addu	$9,$9,16
	.set	macro
	.set	reorder

	lw	$2,0($8)
	#nop
	sw	$2,0($9)
	lw	$2,0($10)
	lw	$16,4($10)
	lw	$4,8($10)
	sw	$2,464($17)
	sw	$16,468($17)
	.set	noreorder
	.set	nomacro
	j	$L755
	sw	$4,472($17)
	.set	macro
	.set	reorder

$L756:
	lw	$2,0($10)
	lw	$16,4($10)
	lw	$4,8($10)
	sw	$2,464($17)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$6
	sw	$16,468($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L761
	sw	$4,472($17)
	.set	macro
	.set	reorder

	lw	$16,240($17)
	#nop
	bgez	$16,$L762
	addu	$16,$16,255
$L762:
	lw	$4,0($10)
	#nop
	bgez	$4,$L763
	addu	$4,$4,255
$L763:
	lw	$8,244($17)
	#nop
	bgez	$8,$L764
	addu	$8,$8,255
$L764:
	lw	$7,4($10)
	#nop
	bgez	$7,$L765
	addu	$7,$7,255
$L765:
	lw	$6,248($17)
	#nop
	bgez	$6,$L766
	addu	$6,$6,255
$L766:
	lw	$5,8($10)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L767
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L767:
	sra	$3,$16,8
	sra	$2,$4,8
	mult	$3,$2
	mflo	$4
	#nop
	sra	$3,$8,8
	sra	$2,$7,8
	mult	$3,$2
	mflo	$2
	#nop
	sra	$5,$5,8
	mult	$6,$5
	addu	$2,$4,$2
	mflo	$8
	#nop
	#nop
	addu	$16,$2,$8
	bgez	$16,$L768
	subu	$16,$0,$16
$L768:
	.set	noreorder
	.set	nomacro
	jal	__floatsidf
	move	$4,$16
	.set	macro
	.set	reorder

	li.d	$6,5.00000000000000000000e-1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__gtdf2
	move	$5,$3
	.set	macro
	.set	reorder

	blez	$2,$L761
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,452($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,456($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,460($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,476($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,480($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L770
	sw	$2,484($17)
	.set	macro
	.set	reorder

$L761:
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,476($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,480($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,484($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,452($17)
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
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,456($17)
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
	subu	$2,$16,$2
	sw	$2,460($17)
$L770:
	jal	Math_NormalizeShortVector__FP8coorddef
$L755:
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
	bne	$3,$2,$L773
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
	j	$L774
	sw	$2,56($sp)
	.set	macro
	.set	reorder

$L773:
	lw	$2,32($sp)
	lw	$3,36($sp)
	sw	$4,56($sp)
	sw	$2,48($sp)
	sw	$3,52($sp)
$L774:
	lw	$3,300($17)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	beq	$2,$0,$L775
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
	j	$L776
	sw	$3,72($sp)
	.set	macro
	.set	reorder

$L775:
	lw	$7,160($17)
	lw	$8,164($17)
	lw	$9,168($17)
	sw	$7,64($sp)
	sw	$8,68($sp)
	sw	$9,72($sp)
	lw	$2,384($17)
	#nop
	sw	$2,68($sp)
$L776:
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
$L780:
	lw	$3,656($5)
	#nop
	sw	$3,492($4)
	lw	$2,176($17)
	#nop
	bgez	$2,$L781
	addu	$2,$2,63
$L781:
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
	bne	$2,$0,$L780
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
	beq	$6,$0,$L790
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
	beq	$6,$0,$L790
	sw	$4,8($sp)
	.set	macro
	.set	reorder

	lh	$3,8($5)
	#nop
	bne	$3,$2,$L790
	lw	$2,608($5)
	lw	$3,1396($5)
	andi	$2,$2,0x0230
	bne	$2,$0,$L790
	lw	$2,4($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L790
	move	$2,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L790
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,628($5)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L790
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
$L790:
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
	move	$4,$7
	li	$2,65536			# 0x00010000
	sw	$31,104($sp)
	sw	$16,96($sp)
	sw	$5,116($sp)
	sw	$6,120($sp)
	sw	$7,124($sp)
	sw	$0,40($sp)
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	bgez	$7,$L792
	sw	$0,48($sp)
	.set	macro
	.set	reorder

	addu	$4,$7,255
$L792:
	move	$3,$5
	sra	$4,$4,8
	sll	$2,$4,8
	subu	$2,$0,$2
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L793
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L793:
	sra	$3,$3,8
	sll	$11,$3,8
	sw	$11,32($sp)
	lw	$2,172($17)
	#nop
	bgez	$2,$L795
	addu	$2,$2,255
$L795:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$3
	#nop
	bgez	$6,$L796
	addu	$6,$6,255
$L796:
	lw	$2,176($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L797
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L797:
	sra	$2,$2,8
	mult	$6,$2
	mflo	$12
	#nop
	lw	$2,180($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L799
	addu	$5,$3,$12
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L799:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$12
	#nop
	#nop
	addu	$5,$5,$12
	bgez	$5,$L800
	subu	$5,$0,$5
$L800:
	subu	$5,$0,$5
	bgez	$5,$L801
	addu	$5,$5,15
$L801:
	sra	$5,$5,4
	slt	$2,$5,-1965
	bne	$2,$0,$L802
	li	$5,-1966			# 0xfffff852
$L802:
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
	bne	$4,$2,$L805
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
	j	$L814
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L805:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L807
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
	j	$L814
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L807:
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L809
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
	j	$L814
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L809:
	bne	$4,$2,$L806
	lw	$2,16($6)
	lw	$3,52($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,8($6)
	lw	$3,44($6)
	#nop
	subu	$2,$2,$3
$L814:
	sw	$2,16($sp)
$L806:
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
	beq	$2,$0,$L818
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	beq	$2,$0,$L817
$L818:
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
	beq	$2,$0,$L816
$L817:
	li	$7,1			# 0x00000001
$L816:
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
	sw	$22,160($sp)
	move	$22,$0
	sw	$31,172($sp)
	sw	$fp,168($sp)
	sw	$23,164($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$18,144($sp)
	sw	$16,136($sp)
	lw	$2,360($17)
	addu	$4,$sp,64
	sw	$2,32($sp)
	lw	$2,364($17)
	move	$5,$22
	sw	$2,36($sp)
	lw	$2,368($17)
	li	$6,12			# 0x0000000c
	sw	$0,128($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,40($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(testSimRoadInfo) # high
	addiu	$2,$2,%lo(testSimRoadInfo) # low
	addu	$3,$17,8
	addu	$4,$17,136
$L820:
	lw	$9,0($3)
	lw	$10,4($3)
	lw	$11,8($3)
	lw	$12,12($3)
	sw	$9,0($2)
	sw	$10,4($2)
	sw	$11,8($2)
	sw	$12,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L820
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$13,0($3)
	sw	$13,0($2)
	lw	$3,192($17)
	li	$2,2621440			# 0x00280000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L879
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$3,172($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L822
	addu	$2,$2,255
$L822:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$3,176($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L823
	addu	$2,$2,255
$L823:
	sra	$2,$2,8
	sw	$2,68($sp)
	lw	$3,180($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L824
	addu	$2,$2,255
$L824:
	sra	$2,$2,8
	sw	$2,72($sp)
	move	$18,$0
$L879:
	sw	$0,132($sp)
	move	$21,$17
	lui	$23,%hi(testSimRoadInfo) # high
	addiu	$19,$23,%lo(testSimRoadInfo) # low
	addu	$20,$21,8
	lui	$12,%hi(newtestSimRoadInfo) # high
	addiu	$fp,$12,%lo(newtestSimRoadInfo) # low
$L825:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	addu	$4,$sp,80
	.set	macro
	.set	reorder

	move	$5,$19
	li	$6,1			# 0x00000001
	lw	$13,652($21)
	lw	$9,656($21)
	lw	$10,660($21)
	sw	$13,80($sp)
	sw	$9,84($sp)
	sw	$10,88($sp)
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

	lb	$4,90($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L829
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
	j	$L830
	li	$22,1			# 0x00000001
	.set	macro
	.set	reorder

$L829:
	move	$4,$17
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L830
	lui	$12,%hi(newtestSimRoadInfo) # high
	.set	macro
	.set	reorder

	addiu	$3,$12,%lo(newtestSimRoadInfo) # low
	move	$2,$19
$L832:
	lw	$13,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$13,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	lui	$12,%hi(testSimRoadInfo+128) # high
	addiu	$12,$12,%lo(testSimRoadInfo+128) # low
	.set	noreorder
	.set	nomacro
	bne	$2,$12,$L832
	addu	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$sp,80
	move	$5,$20
	addiu	$6,$23,%lo(testSimRoadInfo) # low
	lui	$13,%hi(testSimRoadInfo+128) # high
	addiu	$13,$13,%lo(testSimRoadInfo+128) # low
	lw	$9,0($13)
	sw	$9,0($3)
	lw	$13,80($sp)
	lw	$9,84($sp)
	lw	$10,88($sp)
	sw	$13,96($sp)
	sw	$9,100($sp)
	sw	$10,104($sp)
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
	beq	$16,$2,$L873
	li	$22,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$22,$L835
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L874
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L835:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L874
	move	$4,$2
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	bne	$16,$2,$L834
$L873:
	move	$4,$2
$L874:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	move	$6,$20
	.set	macro
	.set	reorder

$L834:
	andi	$2,$16,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L840
	andi	$2,$16,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L875
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	andi	$2,$16,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L875:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L842:
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
	beq	$2,$0,$L840
	andi	$2,$16,0x000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L845
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L846
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	j	$L876
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L846:
	andi	$2,$16,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L847
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	addu	$6,$17,$4
$L876:
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
$L847:
	lui	$12,%hi(newtestSimRoadInfo) # high
	addiu	$3,$12,%lo(newtestSimRoadInfo) # low
	addiu	$2,$23,%lo(testSimRoadInfo) # low
$L849:
	lw	$13,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$13,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	lui	$12,%hi(testSimRoadInfo+128) # high
	addiu	$12,$12,%lo(testSimRoadInfo+128) # low
	.set	noreorder
	.set	nomacro
	bne	$2,$12,$L849
	addu	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$sp,96
	move	$5,$fp
	li	$6,1			# 0x00000001
	lw	$13,0($2)
	sw	$13,0($3)
	lw	$12,80($sp)
	lw	$13,84($sp)
	lw	$9,88($sp)
	sw	$12,96($sp)
	sw	$13,100($sp)
	sw	$9,104($sp)
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
	beq	$2,$0,$L840
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L851:
	slt	$2,$6,4
	beq	$2,$0,$L852
	lw	$2,120($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L853
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$11,8($2)
	lw	$12,12($2)
	lw	$13,16($2)
	sw	$11,112($sp)
	sw	$12,116($sp)
	sw	$13,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L877
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L853:
	lh	$2,%lo(testSimRoadInfo)($23)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$3,0($2)
	#nop
	sw	$3,112($sp)
	lw	$3,4($2)
	#nop
	sw	$3,116($sp)
	lw	$2,8($2)
	#nop
	sw	$2,120($sp)
	addu	$6,$6,1
$L877:
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
	j	$L851
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L852:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L855
	addu	$3,$3,3
$L855:
	lw	$2,52($sp)
	sra	$5,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L856
	sw	$5,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L856:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L857
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L857:
	sra	$2,$3,2
	lw	$3,32($sp)
	lw	$4,40($sp)
	sw	$2,56($sp)
	subu	$3,$3,$5
	subu	$4,$4,$2
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L840
	sw	$4,24($sp)
	.set	macro
	.set	reorder

$L845:
	move	$6,$0
	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L859:
	slt	$2,$6,4
	beq	$2,$0,$L860
	lw	$2,120($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L861
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$10,8($2)
	lw	$11,12($2)
	lw	$12,16($2)
	sw	$10,112($sp)
	sw	$11,116($sp)
	sw	$12,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L878
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L861:
	lh	$2,%lo(testSimRoadInfo)($23)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$3,0($2)
	#nop
	sw	$3,112($sp)
	lw	$3,4($2)
	#nop
	sw	$3,116($sp)
	lw	$2,8($2)
	#nop
	sw	$2,120($sp)
	addu	$6,$6,1
$L878:
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
	j	$L859
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L860:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L863
	addu	$3,$3,3
$L863:
	lw	$2,52($sp)
	sra	$4,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L864
	sw	$4,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L864:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L865
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L865:
	sra	$2,$3,2
	sw	$2,56($sp)
	lw	$3,160($17)
	#nop
	subu	$3,$3,$4
	sw	$3,16($sp)
	lw	$3,168($17)
	#nop
	subu	$3,$3,$2
	sw	$3,24($sp)
$L840:
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L830:
	beq	$22,$0,$L866
	lw	$5,16($sp)
	lw	$6,20($sp)
	lw	$7,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$9,652($21)
	lw	$10,656($21)
	lw	$11,660($21)
	sw	$9,416($17)
	sw	$10,420($17)
	sw	$11,424($17)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ProcessBarrierCollision__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L867
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L867:
	lw	$5,400($17)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L869
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$6,132($sp)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L880
	move	$4,$17
	.set	macro
	.set	reorder

	li	$6,4			# 0x00000004
$L869:
	move	$4,$17
$L880:
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L819
$L866:
	addu	$21,$21,48
	lw	$13,132($sp)
	addu	$18,$18,1
	addu	$13,$13,2
	.set	noreorder
	.set	nomacro
	j	$L825
	sw	$13,132($sp)
	.set	macro
	.set	reorder

$L819:
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
	bne	$2,$0,$L883
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L882
$L883:
	sw	$3,276($4)
$L882:
	li	$3,65536			# 0x00010000
	lw	$5,280($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L885
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L884
$L885:
	sw	$3,280($4)
$L884:
	li	$3,65536			# 0x00010000
	lw	$5,284($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L887
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L889
$L887:
	sw	$3,284($4)
$L889:
	j	$31
	.end	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	.text
	.ent	Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj
Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj:
	.frame	$sp,168,$31		# vars= 104, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	sw	$18,144($sp)
	move	$18,$4
	sw	$31,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$17,140($sp)
	sw	$16,136($sp)
	lbu	$2,145($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L890
	addu	$2,$sp,120
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	addu	$2,$sp,124
	sw	$2,20($sp)
	addu	$2,$sp,112
	sw	$2,24($sp)
	lw	$2,1884($18)
	li	$4,1			# 0x00000001
	sw	$2,28($sp)
	lw	$6,140($18)
	lw	$7,0($18)
	.set	noreorder
	.set	nomacro
	jal	Sched_ExecuteCheck__FiiiiPiT4Pci
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$2,$0,$L890
	lbu	$2,144($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L892
	move	$4,$18
	.set	macro
	.set	reorder

	addu	$21,$sp,80
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	move	$5,$21
	.set	macro
	.set	reorder

	lw	$16,384($18)
	lw	$6,80($sp)
	lw	$3,124($sp)
	move	$19,$2
	sw	$19,384($18)
	sll	$4,$3,3
	addu	$4,$4,$3
	lw	$3,120($sp)
	subu	$2,$19,$16
	mult	$2,$3
	lw	$20,392($18)
	lw	$5,148($18)
	sll	$4,$4,11
	mflo	$19
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$6,128($sp)
	.set	macro
	.set	reorder

	lw	$3,176($18)
	lw	$17,252($18)
	subu	$3,$3,$2
	sw	$3,176($18)
	lw	$5,80($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,256($18)
	lw	$5,84($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,260($18)
	lw	$5,88($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$5,$sp,128
	addu	$6,$16,$17
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi
	sw	$6,300($18)
	.set	macro
	.set	reorder

	lw	$16,172($18)
	lw	$17,180($18)
	bgez	$16,$L893
	subu	$16,$0,$16
$L893:
	.set	noreorder
	.set	nomacro
	bgez	$17,$L927
	move	$4,$16
	.set	macro
	.set	reorder

	subu	$17,$0,$17
$L927:
	.set	noreorder
	.set	nomacro
	jal	Math_BetterDist__Fii
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,372($18)
	sw	$2,192($18)
	lw	$2,388($18)
	sll	$3,$4,3
	subu	$3,$3,$4
	subu	$2,$19,$2
	addu	$16,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L928
	sra	$2,$16,3
	.set	macro
	.set	reorder

	addu	$16,$16,7
	sra	$2,$16,3
$L928:
	sw	$2,372($18)
	slt	$2,$20,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L896
	sw	$19,388($18)
	.set	macro
	.set	reorder

	lhu	$2,380($18)
	#nop
	bne	$2,$0,$L897
	.set	noreorder
	.set	nomacro
	jal	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L926
	slt	$2,$20,2621
	.set	macro
	.set	reorder

$L897:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L929
	li	$2,45875			# 0x0000b333
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	li	$2,45875			# 0x0000b333
$L929:
	lw	$3,300($18)
	lw	$17,176($18)
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L900
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,360($18)
	move	$4,$18
	sw	$2,96($sp)
	lw	$2,368($18)
	move	$5,$21
	sw	$2,104($sp)
	lw	$2,364($18)
	addu	$6,$sp,96
	addu	$2,$2,-6553
	.set	noreorder
	.set	nomacro
	jal	Collide_TestWithPlane__FPvP8coorddefT1
	sw	$2,100($sp)
	.set	macro
	.set	reorder

	lw	$16,400($18)
	li	$2,327680			# 0x00050000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L901
	li	$2,1245184			# 0x00130000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L902
	li	$17,1310720			# 0x00140000
	.set	macro
	.set	reorder

	move	$17,$16
$L902:
	sw	$17,400($18)
$L901:
	lw	$2,300($18)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L904
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L904
	sw	$2,1932($18)
	.set	macro
	.set	reorder

$L900:
	move	$3,$18
	li	$4,3			# 0x00000003
$L905:
	addu	$4,$4,-1
	lw	$2,680($3)
	addu	$3,$3,48
	.set	noreorder
	.set	nomacro
	bgez	$4,$L905
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$16,$L904
	sll	$2,$16,1
	.set	macro
	.set	reorder

	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L930
	sra	$3,$16,2
	.set	macro
	.set	reorder

	addu	$16,$16,3
	sra	$3,$16,2
$L930:
	subu	$2,$19,$17
	sll	$16,$2,1
	addu	$3,$19,$3
	li	$2,1310720			# 0x00140000
	lw	$4,164($18)
	slt	$2,$2,$16
	sw	$3,176($18)
	sw	$16,400($18)
	sh	$0,380($18)
	subu	$4,$4,$20
	li	$20,3276			# 0x00000ccc
	sw	$4,164($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L911
	sw	$20,392($18)
	.set	macro
	.set	reorder

	move	$4,$18
	li	$6,9			# 0x00000009
	move	$7,$0
	lw	$16,164($18)
	lw	$17,168($18)
	lw	$5,400($18)
	lw	$3,160($18)
	li	$2,65536			# 0x00010000
	sw	$2,408($18)
	sw	$0,404($18)
	sw	$3,416($18)
	sw	$16,420($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	sw	$17,424($18)
	.set	macro
	.set	reorder

$L911:
	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L904
	lw	$4,400($18)
	jal	Force_HitWall__Fi
$L904:
	.set	noreorder
	.set	nomacro
	jal	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	slt	$2,$20,2621
$L926:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L931
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$16,164($18)
	lw	$2,608($18)
	sw	$0,392($18)
	subu	$3,$16,$20
	andi	$2,$2,0x0400
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L914
	sw	$3,164($18)
	.set	macro
	.set	reorder

	lw	$3,300($18)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L932
	li	$2,327680			# 0x00050000
	.set	macro
	.set	reorder

	sh	$0,380($18)
$L914:
	li	$2,327680			# 0x00050000
$L932:
	ori	$2,$2,0xffff
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L915
	li	$2,786432			# 0x000c0000
	.set	macro
	.set	reorder

	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L916
	li	$16,65503			# 0x0000ffdf
	.set	macro
	.set	reorder

	li	$16,65470			# 0x0000ffbe
$L916:
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
$L915:
	lw	$16,192($18)
	li	$2,262144			# 0x00040000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L917
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$19,$L933
	sra	$2,$19,2
	.set	macro
	.set	reorder

	addu	$19,$19,3
	sra	$2,$19,2
$L933:
	.set	noreorder
	.set	nomacro
	j	$L922
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L917:
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L920
	srl	$2,$19,31
	.set	macro
	.set	reorder

	addu	$2,$19,$2
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L922
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L920:
	.set	noreorder
	.set	nomacro
	j	$L922
	sw	$19,176($18)
	.set	macro
	.set	reorder

$L896:
	lw	$5,148($18)
	lw	$2,124($sp)
	sw	$0,372($18)
	lhu	$3,124($sp)
	sll	$4,$2,3
	addu	$4,$4,$2
	lhu	$2,380($18)
	sll	$4,$4,11
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$2,380($18)
	.set	macro
	.set	reorder

	lw	$3,176($18)
	#nop
	subu	$3,$3,$2
	sw	$3,176($18)
$L922:
	lui	$2,%hi(simGlobal+4) # high
$L931:
	lw	$2,%lo(simGlobal+4)($2)
	addu	$4,$18,8
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	sw	$2,156($18)
	.set	macro
	.set	reorder

	beq	$2,$0,$L890
	lw	$19,176($18)
	#nop
	blez	$19,$L890
	lw	$2,164($18)
	lw	$3,364($18)
	#nop
	subu	$2,$2,$3
	li	$3,524288			# 0x00080000
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L890
	subu	$2,$0,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L890
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L892:
	addu	$5,$sp,80
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
	sw	$2,164($18)
$L890:
	lw	$31,160($sp)
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
	addu	$sp,$sp,168
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
	bgez	$4,$L942
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L942:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L936
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L936:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,4($6)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L943
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L943:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L938
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L938:
	sra	$2,$2,8
	mult	$4,$2
	lw	$6,8($6)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L939
	addu	$4,$5,$9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L939:
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L940
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L940:
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
	bgez	$6,$L952
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L952:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L946
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L946:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($8)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L953
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L953:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L948
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L948:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,332($8)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L949
	addu	$3,$6,$9
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L949:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L950
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L950:
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
