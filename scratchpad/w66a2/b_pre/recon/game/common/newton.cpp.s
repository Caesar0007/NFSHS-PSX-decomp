	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\newton.cpp"
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
	beq	$2,$0,$L661
	lui	$2,%hi(GameSetup_gData+80) # high
	.set	macro
	.set	reorder

	lw	$4,400($18)
	jal	Force_HitWall__Fi
	lui	$2,%hi(GameSetup_gData+80) # high
$L661:
	lw	$2,%lo(GameSetup_gData+80)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	li	$3,6553600			# 0x00640000
	.set	macro
	.set	reorder

	srl	$2,$16,31
	addu	$2,$16,$2
	sra	$4,$2,1
	move	$2,$3
	slt	$2,$2,$4
	bne	$2,$0,$L606
	move	$3,$4
$L606:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	srl	$2,$3,31
	.set	macro
	.set	reorder

	addu	$2,$3,$2
	sra	$3,$2,1
$L607:
	sll	$2,$23,2
	addu	$6,$18,$2
	lw	$4,536($6)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L662
	slt	$2,$23,8
	.set	macro
	.set	reorder

	move	$3,$4
$L662:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	sw	$3,536($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L610
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
	beq	$2,$0,$L612
	move	$4,$3
$L612:
	lw	$2,536($18)
	lw	$3,560($18)
	.set	noreorder
	.set	nomacro
	j	$L660
	sw	$4,540($18)
	.set	macro
	.set	reorder

$L610:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L615
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
	beq	$2,$0,$L617
	move	$4,$3
$L617:
	lw	$2,540($18)
	lw	$3,548($18)
	sw	$4,536($18)
	lw	$4,544($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L618
	move	$3,$4
$L618:
	.set	noreorder
	.set	nomacro
	j	$L633
	sw	$3,544($18)
	.set	macro
	.set	reorder

$L615:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L620
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
	beq	$2,$0,$L622
	move	$4,$3
$L622:
	lw	$2,536($18)
	lw	$3,560($18)
	sw	$4,556($18)
$L660:
	lw	$4,564($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L623
	move	$3,$4
$L623:
	.set	noreorder
	.set	nomacro
	j	$L633
	sw	$3,564($18)
	.set	macro
	.set	reorder

$L620:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L625
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
	beq	$2,$0,$L627
	move	$4,$3
$L627:
	lw	$2,556($18)
	lw	$3,564($18)
	sw	$4,536($18)
	lw	$4,560($18)
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$3,$2,1
	slt	$2,$3,$4
	beq	$2,$0,$L628
	move	$3,$4
$L628:
	.set	noreorder
	.set	nomacro
	j	$L633
	sw	$3,560($18)
	.set	macro
	.set	reorder

$L625:
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
	beq	$2,$0,$L663
	addu	$2,$23,-2
	.set	macro
	.set	reorder

	move	$3,$4
$L663:
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
	beq	$2,$0,$L632
	move	$3,$4
$L632:
	sw	$3,536($5)
$L633:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L602
	li	$22,131072			# 0x00020000
	.set	macro
	.set	reorder

	move	$21,$0
	li	$2,5898240			# 0x005a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	move	$20,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L636
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$5,$16,3
$L636:
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
	bne	$3,$0,$L637
	sw	$2,1932($18)
	.set	macro
	.set	reorder

	lw	$2,164($18)
	li	$3,65536			# 0x00010000
	addu	$2,$2,$3
	sw	$2,164($18)
$L637:
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
	bne	$2,$0,$L638
	move	$4,$3
$L638:
	sw	$4,176($18)
	.set	noreorder
	.set	nomacro
	bgez	$16,$L640
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$16,31
$L640:
	sra	$19,$4,5
	li	$2,39321			# 0x00009999
	slt	$2,$2,$19
	beq	$2,$0,$L641
	li	$19,39321			# 0x00009999
$L641:
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,176($18)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	li	$2,1310720			# 0x00140000
	.set	macro
	.set	reorder

	sw	$3,176($18)
$L642:
	li	$2,1310720			# 0x00140000
$L664:
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
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
	beq	$4,$0,$L644
	sll	$22,$10,2
	.set	macro
	.set	reorder

	subu	$19,$0,$19
$L644:
	li	$3,196608			# 0x00030000
	ori	$3,$3,0xffff
	addu	$2,$22,$21
	addu	$2,$2,$20
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L665
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,65535			# 0x0000ffff
	slt	$2,$3,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L666
	slt	$2,$3,$21
	.set	macro
	.set	reorder

	sll	$22,$10,3
$L666:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	slt	$2,$3,$20
	.set	macro
	.set	reorder

	sll	$21,$21,1
$L667:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sll	$20,$20,1
$L643:
	li	$2,2			# 0x00000002
$L665:
	bne	$17,$2,$L650
	sll	$22,$22,1
	sll	$21,$21,1
	.set	noreorder
	.set	nomacro
	j	$L650
	sll	$20,$20,1
	.set	macro
	.set	reorder

$L635:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	bgez	$5,$L668
	sra	$19,$5,6
	.set	macro
	.set	reorder

	addu	$5,$5,63
	sra	$19,$5,6
$L668:
	li	$2,32768			# 0x00008000
	slt	$2,$2,$19
	beq	$2,$0,$L650
	li	$19,32768			# 0x00008000
$L650:
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
	beq	$2,$0,$L653
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
	j	$L658
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L653:
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
$L658:
	sw	$2,1060($18)
	addu	$2,$23,-2
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
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
	j	$L659
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L655:
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
$L659:
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
$L602:
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
	beq	$2,$0,$L672
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L673
	move	$6,$3
	.set	macro
	.set	reorder

$L672:
	addu	$2,$5,-1
	subu	$6,$4,$2
$L673:
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
	beq	$2,$0,$L695
	lbu	$2,144($22)
	lh	$fp,8($22)
	sltu	$6,$2,2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L677
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$0,368($22)
	sw	$0,364($22)
	sw	$0,360($22)
$L678:
	slt	$2,$5,4
	beq	$2,$0,$L679
	lw	$2,128($22)
	#nop
	beq	$2,$0,$L682
	lw	$7,16($4)
	lw	$8,20($4)
	lw	$9,24($4)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	j	$L683
$L682:
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
$L683:
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
	j	$L678
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L679:
	lw	$2,360($22)
	#nop
	bgez	$2,$L684
	addu	$2,$2,3
$L684:
	lw	$4,364($22)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L685
	sw	$2,360($22)
	.set	macro
	.set	reorder

	addu	$4,$4,3
$L685:
	lw	$3,368($22)
	sra	$2,$4,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L686
	sw	$2,364($22)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L686:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L687
	sw	$2,368($22)
	.set	macro
	.set	reorder

$L677:
	lw	$2,128($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	sll	$2,$fp,5
	.set	macro
	.set	reorder

	lw	$7,16($22)
	lw	$8,20($22)
	lw	$9,24($22)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
	j	$L687
$L688:
	lw	$3,BWorldSm_slices
	#nop
	addu	$2,$2,$3
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,360($22)
	sw	$8,364($22)
	sw	$9,368($22)
$L687:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L690
	sll	$3,$fp,5
	.set	macro
	.set	reorder

	lb	$2,97($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L692
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
	j	$L692
	sw	$2,332($22)
	.set	macro
	.set	reorder

$L690:
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
$L692:
	lw	$4,gNumSlices
	addu	$3,$fp,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L694
	move	$6,$3
	.set	macro
	.set	reorder

	addu	$2,$4,-1
	subu	$6,$fp,$2
$L694:
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
$L695:
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
	beq	$2,$0,$L697
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$6,0($5)
	li	$2,65536			# 0x00010000
	subu	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bgez	$6,$L698
	sra	$7,$2,9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L698:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L699
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L699:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L700
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L700:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L701
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L701:
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

	j	$L707
$L697:
	lw	$6,0($5)
	#nop
	bgez	$6,$L703
	addu	$6,$6,255
$L703:
	lw	$3,0($8)
	lw	$2,0($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L704
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L704:
	sra	$2,$2,8
	mult	$3,$2
	lw	$5,8($5)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L705
	subu	$4,$0,$9
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L705:
	lw	$3,8($8)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L706
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L706:
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

$L707:
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
	bgez	$6,$L709
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L709:
	lw	$3,0($4)
	lw	$2,0($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L710
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L710:
	sra	$2,$2,8
	mult	$3,$2
	lw	$6,8($5)
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L711
	subu	$8,$0,$10
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L711:
	lw	$3,8($4)
	lw	$2,8($17)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L712
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L712:
	sra	$2,$2,8
	mult	$3,$2
	move	$7,$0
	lui	$2,%hi(fudgeTable) # high
	addiu	$9,$2,%lo(fudgeTable) # low
	mflo	$10
	#nop
	#nop
	subu	$8,$8,$10
$L713:
	bne	$7,$0,$L716
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
	bne	$2,$0,$L726
	.set	noreorder
	.set	nomacro
	j	$L728
	sra	$2,$6,2
	.set	macro
	.set	reorder

$L716:
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
	beq	$2,$0,$L720
$L726:
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L719
	addu	$3,$6,$2
	.set	macro
	.set	reorder

$L720:
	sra	$2,$6,2
$L728:
	addu	$3,$3,$2
$L719:
	sra	$2,$3,15
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	bgez	$3,$L722
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,31
$L722:
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
	bne	$2,$0,$L713
	li	$2,40632			# 0x00009eb8
	.set	macro
	.set	reorder

	lw	$5,4($5)
	#nop
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
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

	j	$L727
$L724:
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$4,$8
	.set	macro
	.set	reorder

$L727:
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
	bne	$2,$0,$L730
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
	j	$L731
	sw	$3,816($16)
	.set	macro
	.set	reorder

$L730:
	li	$6,-2097152000			# 0x83000000
$L731:
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
$L733:
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
	bne	$18,$17,$L733
	addu	$16,$16,16
	.set	macro
	.set	reorder

	lw	$15,0($18)
	sw	$15,0($16)
	move	$19,$20
	addu	$18,$sp,96
	addu	$17,$sp,32
$L734:
	addu	$2,$20,192
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L735
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
	beq	$2,$0,$L738
	li	$4,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$4,0($2)
$L738:
	sw	$4,696($19)
	lw	$2,300($sp)
	#nop
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	andi	$4,$4,0x000f
	.set	macro
	.set	reorder

	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L825
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	bne	$4,$0,$L739
$L740:
	li	$2,65536			# 0x00010000
$L825:
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
	j	$L814
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L739:
	lw	$2,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L742
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
	j	$L830
	sltu	$2,$2,2
	.set	macro
	.set	reorder

$L742:
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
$L830:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L744
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
	j	$L823
	sw	$2,4($18)
	.set	macro
	.set	reorder

$L744:
	addu	$5,$sp,296
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationGeneral__FP8coorddefN20
	addu	$6,$sp,312
	.set	macro
	.set	reorder

	sw	$2,4($18)
$L823:
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
	beq	$2,$0,$L746
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
$L814:
	addu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,24($sp)
	lw	$3,8($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L741
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L746:
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
$L741:
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
	j	$L734
	addu	$19,$19,48
	.set	macro
	.set	reorder

$L735:
	move	$7,$0
	li	$9,1			# 0x00000001
	move	$5,$20
	move	$8,$7
	sw	$0,400($sp)
	sw	$0,296($sp)
	sw	$0,304($sp)
$L748:
	slt	$2,$7,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L749
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
	beq	$2,$0,$L752
	sw	$9,684($5)
	.set	noreorder
	.set	nomacro
	j	$L753
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L752:
	lw	$2,684($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$9,$L826
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	blez	$3,$L755
	addu	$21,$21,1
	sw	$0,684($5)
	.set	noreorder
	.set	nomacro
	j	$L826
	sw	$9,688($5)
	.set	macro
	.set	reorder

$L755:
	lw	$2,392($20)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L826
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$2,176($20)
	#nop
	slt	$2,$2,-6552
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L826
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	lw	$3,300($20)
	li	$2,62259			# 0x0000f333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L826
	li	$2,3473408			# 0x00350000
	.set	macro
	.set	reorder

	sw	$0,684($5)
$L753:
	li	$2,3473408			# 0x00350000
$L826:
	lw	$3,192($20)
	ori	$2,$2,0x8000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	li	$4,-13107			# 0xffffcccd
	.set	macro
	.set	reorder

	li	$4,-9830			# 0xffffd99a
$L758:
	lw	$2,300($sp)
	#nop
	slt	$2,$2,$4
	beq	$2,$0,$L759
	sw	$4,300($sp)
$L759:
	lw	$4,300($sp)
	sll	$3,$7,2
	addu	$2,$sp,328
	.set	noreorder
	.set	nomacro
	bgez	$4,$L760
	addu	$6,$2,$3
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L760:
	lw	$2,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L761
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L761:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L762
	sw	$2,0($6)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L762:
	lw	$2,1124($20)
	#nop
	lw	$2,312($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L763
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L763:
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
	bne	$2,$9,$L750
	sll	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,680($5)
$L750:
	addu	$5,$5,48
	addu	$8,$8,12
	.set	noreorder
	.set	nomacro
	j	$L748
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L749:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L827
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
$L827:
	move	$18,$20
$L766:
	slt	$2,$19,4
	beq	$2,$0,$L767
	bne	$21,$0,$L813
	lw	$4,680($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L770
	li	$2,56360			# 0x0000dc28
	.set	macro
	.set	reorder

	lw	$3,300($20)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	sra	$2,$4,1
	.set	macro
	.set	reorder

$L770:
	beq	$21,$0,$L768
$L813:
	lw	$2,688($18)
	#nop
	beq	$2,$0,$L768
	lw	$2,176($20)
	#nop
	bgez	$2,$L768
	lw	$3,388($20)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$16,$2,$3
	bltz	$16,$L768
	lw	$15,400($sp)
	#nop
	div	$3,$16,$15
	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L775
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
	bne	$2,$0,$L776
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
	j	$L824
	move	$4,$2
	.set	macro
	.set	reorder

$L776:
	move	$4,$2
$L824:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$17,$2
$L775:
	lw	$2,680($18)
	#nop
	addu	$2,$2,$17
$L772:
	sw	$2,680($18)
$L768:
	addu	$18,$18,48
	.set	noreorder
	.set	nomacro
	j	$L766
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L767:
	move	$18,$0
	lui	$2,%hi(swap) # high
	addiu	$17,$2,%lo(swap) # low
	move	$16,$18
$L779:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L780
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
	blez	$5,$L783
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
	bne	$2,$0,$L785
	move	$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L816
	move	$3,$4
	.set	macro
	.set	reorder

$L783:
	lw	$2,1124($20)
	#nop
	lw	$2,336($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$5,$3
	beq	$2,$0,$L785
$L816:
	move	$5,$3
$L785:
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
	j	$L779
	sw	$5,692($2)
	.set	macro
	.set	reorder

$L780:
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
	bltz	$2,$L787
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
	bne	$2,$0,$L828
	li	$3,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L828
	li	$23,4			# 0x00000004
	.set	macro
	.set	reorder

$L787:
	li	$23,4			# 0x00000004
	sw	$0,0($fp)
	sw	$2,4($fp)
	sw	$0,8($fp)
	li	$3,-65536			# 0xffff0000
$L828:
	lw	$2,300($20)
	ori	$3,$3,0x199a
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L790
	slt	$2,$23,4
	.set	macro
	.set	reorder

	lw	$3,276($20)
	#nop
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L791
	addu	$2,$2,255
$L791:
	lw	$3,280($20)
	sra	$2,$2,8
	sw	$2,276($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L792
	addu	$2,$2,255
$L792:
	lw	$3,284($20)
	sra	$2,$2,8
	sw	$2,280($20)
	sll	$2,$3,6
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L793
	addu	$2,$2,255
$L793:
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	j	$L794
	sw	$2,284($20)
	.set	macro
	.set	reorder

$L790:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L829
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
	blez	$17,$L796
	sw	$16,1068($20)
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$2,316($2)
	#nop
	move	$3,$2
	slt	$2,$3,$17
	bne	$2,$0,$L800
	.set	noreorder
	.set	nomacro
	j	$L800
	move	$3,$17
	.set	macro
	.set	reorder

$L796:
	lw	$2,1124($20)
	#nop
	lw	$2,316($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$3,$17
	beq	$2,$0,$L800
	move	$3,$17
$L800:
	move	$17,$3
	lw	$3,680($20)
	lw	$5,776($20)
	lw	$2,728($20)
	lw	$4,824($20)
	addu	$3,$3,$5
	addu	$2,$2,$4
	subu	$3,$3,$2
	sra	$16,$3,2
	blez	$16,$L801
	lw	$2,1124($20)
	#nop
	lw	$2,320($2)
	#nop
	move	$3,$2
	slt	$2,$3,$16
	bne	$2,$0,$L805
	.set	noreorder
	.set	nomacro
	j	$L805
	move	$3,$16
	.set	macro
	.set	reorder

$L801:
	lw	$2,1124($20)
	#nop
	lw	$2,320($2)
	#nop
	subu	$3,$0,$2
	slt	$2,$3,$16
	beq	$2,$0,$L805
	move	$3,$16
$L805:
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
	bne	$3,$0,$L806
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$5,304($2)
$L806:
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
	bne	$2,$0,$L808
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

	lw	$2,1124($20)
	#nop
	lw	$5,308($2)
$L808:
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
$L794:
	lui	$2,%hi(simGlobal+4) # high
$L829:
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L810
	move	$4,$20
	.set	macro
	.set	reorder

	move	$5,$fp
	.set	noreorder
	.set	nomacro
	j	$L819
	addu	$6,$20,360
	.set	macro
	.set	reorder

$L810:
	move	$5,$fp
	addu	$6,$sp,16
$L819:
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

	beq	$2,$0,$L831
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

$L831:
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
	bgez	$3,$L835
	subu	$sp,$sp,32
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L835:
	lw	$2,240($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L836
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L836:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L837
	addu	$3,$3,255
$L837:
	lw	$2,244($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L838
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L838:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L839
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L839:
	lw	$2,248($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L840
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L840:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L841
	addu	$3,$3,255
$L841:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L842
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L842:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	sw	$15,0($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L843
	addu	$3,$3,255
$L843:
	lw	$2,252($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L844
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L844:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L845
	addu	$3,$3,255
$L845:
	lw	$2,256($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L846
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L846:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L847
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L847:
	lw	$2,260($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L848
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L848:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L849
	addu	$3,$3,255
$L849:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L850
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L850:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sw	$8,4($sp)
	lw	$3,0($5)
	#nop
	bgez	$3,$L851
	addu	$3,$3,255
$L851:
	lw	$2,264($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L852
	sra	$7,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L852:
	sra	$2,$2,8
	mult	$7,$2
	lw	$3,4($5)
	mflo	$7
	#nop
	bgez	$3,$L853
	addu	$3,$3,255
$L853:
	lw	$2,268($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L854
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L854:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L855
	addu	$7,$7,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L855:
	lw	$2,272($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L856
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L856:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$3,$7,$15
	bgez	$3,$L857
	addu	$3,$3,255
$L857:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L858
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L858:
	sra	$2,$2,8
	mult	$3,$2
	li	$13,-1			# 0xffffffff
	lw	$14,0($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$14,$L859
	sw	$9,8($sp)
	.set	macro
	.set	reorder

	li	$13,1			# 0x00000001
$L859:
	.set	noreorder
	.set	nomacro
	bgez	$8,$L860
	li	$12,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$12,1			# 0x00000001
$L860:
	.set	noreorder
	.set	nomacro
	bgez	$9,$L861
	li	$11,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
$L861:
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
	bgez	$4,$L869
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L869:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L863
	sra	$6,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L863:
	sra	$2,$2,8
	mult	$6,$2
	lw	$4,4($5)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L870
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L870:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L865
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L865:
	sra	$2,$2,8
	mult	$4,$2
	lw	$5,8($5)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L866
	addu	$3,$6,$15
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L866:
	move	$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$2,$L867
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L867:
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
	bne	$2,$0,$L872
	lw	$2,308($18)
	.set	noreorder
	.set	nomacro
	j	$L876
	subu	$2,$16,$2
	.set	macro
	.set	reorder

$L872:
	lw	$2,312($18)
	#nop
	subu	$2,$16,$2
$L876:
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
	bgtz	$4,$L878
	move	$18,$6
	.set	macro
	.set	reorder

	subu	$4,$3,$5
$L878:
	lw	$5,168($16)
	lw	$2,168($2)
	#nop
	subu	$3,$5,$2
	bgtz	$3,$L879
	subu	$3,$2,$5
$L879:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L880
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L902
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L880:
	sra	$2,$4,2
	addu	$2,$3,$2
$L902:
	sw	$2,140($16)
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L882
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
	bgtz	$4,$L883
	subu	$4,$3,$5
$L883:
	lw	$5,168($16)
	lw	$2,168($2)
	#nop
	subu	$3,$5,$2
	bgtz	$3,$L884
	subu	$3,$2,$5
$L884:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L885
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L886
	addu	$3,$4,$2
	.set	macro
	.set	reorder

$L885:
	sra	$2,$4,2
	addu	$3,$3,$2
$L886:
	lw	$2,140($16)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L882
	li	$6,1			# 0x00000001
	sw	$3,140($16)
$L882:
	lw	$2,140($16)
	li	$17,6291456			# 0x00600000
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L891
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

	bne	$2,$0,$L888
	li	$18,1			# 0x00000001
$L888:
	lw	$2,140($16)
	#nop
	slt	$2,$17,$2
	bne	$2,$0,$L891
	beq	$18,$0,$L890
$L891:
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L893
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L890
$L893:
	lbu	$2,144($16)
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L894
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,444($16)
	sw	$2,448($16)
$L894:
	sb	$3,144($16)
	sw	$0,276($16)
	.set	noreorder
	.set	nomacro
	j	$L877
	sw	$0,284($16)
	.set	macro
	.set	reorder

$L890:
	lw	$2,608($16)
	lbu	$4,144($16)
	andi	$2,$2,0x0030
	bne	$2,$0,$L895
	lw	$2,1884($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L896
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,3
	beq	$2,$0,$L895
$L896:
	lw	$3,140($16)
	li	$2,4718592			# 0x00480000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L895
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L897
	sb	$2,144($16)
	.set	macro
	.set	reorder

$L895:
	sb	$0,144($16)
$L897:
	slt	$2,$4,2
	bne	$2,$0,$L877
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
	beq	$2,$0,$L899
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
	j	$L900
$L899:
	lui	$5,%hi(dummy_124) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_124) # low
	.set	macro
	.set	reorder

	sw	$2,384($16)
$L900:
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
$L877:
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
	beq	$2,$0,$L903
	jal	Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
	.set	noreorder
	.set	nomacro
	jal	Newton_FindClosestQuad__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

	lb	$2,97($16)
	#nop
	beq	$2,$0,$L905
	.set	noreorder
	.set	nomacro
	jal	Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

$L905:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L903
	lw	$3,128($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L907
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($3)
$L907:
	sw	$2,444($16)
	andi	$2,$2,0x000f
	sw	$2,448($16)
$L903:
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
	bne	$5,$0,$L910
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,240
	addu	$2,$4,324
	addu	$3,$4,356
$L911:
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
	bne	$2,$3,$L911
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

$L910:
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
	bne	$5,$0,$L914
	addu	$3,$4,324
	.set	macro
	.set	reorder

	addu	$5,$4,452
	addu	$2,$4,324
	addu	$3,$4,356
$L915:
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
	bne	$2,$3,$L915
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

$L914:
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
	beq	$3,$0,$L918
	sw	$2,168($20)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L919
	sb	$0,144($20)
	.set	macro
	.set	reorder

$L918:
	li	$2,2			# 0x00000002
	sb	$2,144($20)
$L919:
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
	bne	$3,$2,$L920
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	sll	$3,$22,5
	addu	$3,$3,$2
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L921
	sw	$2,384($20)
	.set	macro
	.set	reorder

$L920:
	.set	noreorder
	.set	nomacro
	bne	$3,$16,$L922
	move	$4,$0
	.set	macro
	.set	reorder

	move	$6,$4
	move	$5,$20
$L923:
	slt	$2,$6,4
	beq	$2,$0,$L924
	lw	$2,128($20)
	#nop
	beq	$2,$0,$L927
	lw	$8,16($5)
	lw	$9,20($5)
	lw	$10,24($5)
	sw	$8,72($sp)
	sw	$9,76($sp)
	sw	$10,80($sp)
	.set	noreorder
	.set	nomacro
	j	$L938
	addu	$5,$5,12
	.set	macro
	.set	reorder

$L927:
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
$L938:
	lw	$2,76($sp)
	addu	$6,$6,1
	.set	noreorder
	.set	nomacro
	j	$L923
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L924:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L929
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,3
$L929:
	sra	$4,$2,2
	.set	noreorder
	.set	nomacro
	j	$L921
	sw	$4,384($20)
	.set	macro
	.set	reorder

$L922:
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L931
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
	j	$L932
$L931:
	lui	$5,%hi(dummy_133) # high
	.set	noreorder
	.set	nomacro
	jal	Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
	addiu	$5,$5,%lo(dummy_133) # low
	.set	macro
	.set	reorder

	sw	$2,384($20)
$L932:
	lw	$2,384($20)
	lw	$3,312($20)
	#nop
	addu	$2,$2,$3
	sw	$2,164($20)
$L921:
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
	bne	$4,$0,$L933
	sw	$3,164($20)
	.set	macro
	.set	reorder

	lw	$3,128($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L936
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lbu	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L939
	sw	$2,444($20)
	.set	macro
	.set	reorder

$L933:
	li	$2,1			# 0x00000001
$L936:
	sw	$2,444($20)
$L939:
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
	beq	$2,$0,$L941
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L941
	sll	$2,$6,2
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sw	$2,184($16)
$L941:
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L942
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L943
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
	bne	$2,$0,$L944
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
	beq	$2,$0,$L943
$L944:
	lw	$2,184($16)
	#nop
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L942
	sw	$2,184($16)
	.set	macro
	.set	reorder

$L943:
	lw	$2,184($16)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	sw	$3,184($16)
$L942:
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
	bgez	$17,$L946
	sw	$19,316($16)
	.set	macro
	.set	reorder

	addu	$3,$17,255
$L946:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$18,$L948
	move	$2,$18
	.set	macro
	.set	reorder

	addu	$2,$18,255
$L948:
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
	bgez	$2,$L950
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$3,$2,255
$L950:
	sra	$4,$3,8
	mult	$4,$4
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$19,$L952
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$19,255
$L952:
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
$L954:
	sw	$0,536($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L954
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
	beq	$2,$0,$L959
	lui	$2,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L961
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
	j	$L959
	sw	$3,164($18)
	.set	macro
	.set	reorder

$L961:
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
$L959:
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
	bne	$17,$0,$L965
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
	j	$L966
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L965:
	addu	$2,$sp,136
	move	$4,$18
	addu	$3,$sp,88
$L967:
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
	bne	$4,$3,$L967
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$8,0($4)
	sw	$8,0($2)
$L966:
	slt	$2,$19,14
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L968
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
	j	$L969
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L968:
	addu	$2,$sp,136
	addu	$3,$sp,168
$L970:
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
	bne	$2,$3,$L970
	addu	$4,$4,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($4)
$L969:
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
	beq	$2,$0,$L971
	lw	$2,276($17)
	#nop
	bgez	$2,$L973
	addu	$2,$2,63
$L973:
	sra	$2,$2,6
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L974
	addu	$2,$2,63
$L974:
	sra	$2,$2,6
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L975
	addu	$2,$2,63
$L975:
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
	beq	$2,$0,$L971
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
	beq	$2,$0,$L978
	lw	$2,88($sp)
	#nop
	beq	$2,$0,$L971
$L978:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sb	$2,146($17)
	sw	$0,152($17)
$L971:
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
	beq	$2,$0,$L979
	lbu	$2,144($17)
	#nop
	bne	$2,$0,$L979
	lw	$2,276($17)
	#nop
	bgez	$2,$L981
	addu	$2,$2,15
$L981:
	sra	$2,$2,4
	sw	$2,72($sp)
	lw	$2,280($17)
	#nop
	bgez	$2,$L982
	addu	$2,$2,15
$L982:
	sra	$2,$2,4
	sw	$2,76($sp)
	lw	$2,284($17)
	#nop
	bgez	$2,$L983
	addu	$2,$2,15
$L983:
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
	beq	$2,$0,$L979
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
	bne	$2,$0,$L986
	lbu	$2,146($17)
	#nop
	addu	$2,$2,-1
	sb	$2,146($17)
	andi	$2,$2,0x00ff
	bne	$2,$0,$L979
$L986:
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,64			# 0x00000040
	sb	$2,146($17)
	sw	$0,152($17)
$L979:
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
	bne	$2,$0,$L988
	li	$2,58982			# 0x0000e666
	.set	macro
	.set	reorder

	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L988
	addu	$3,$17,452
	.set	macro
	.set	reorder

	addu	$2,$17,240
	addu	$4,$17,272
$L989:
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
	bne	$2,$4,$L989
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
	j	$L987
	sw	$4,472($17)
	.set	macro
	.set	reorder

$L988:
	lw	$2,0($5)
	lw	$3,4($5)
	lw	$4,8($5)
	sw	$2,464($17)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$6
	sw	$3,468($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L990
	sw	$4,472($17)
	.set	macro
	.set	reorder

	lw	$3,240($17)
	#nop
	bgez	$3,$L991
	addu	$3,$3,255
$L991:
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L992
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L992:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,244($17)
	mflo	$4
	#nop
	bgez	$3,$L993
	addu	$3,$3,255
$L993:
	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L994
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L994:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,248($17)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L995
	addu	$4,$4,$8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L995:
	lw	$2,8($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L996
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L996:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	addu	$4,$4,$8
	bgez	$4,$L997
	subu	$4,$0,$4
$L997:
	jal	__floatsidf
	li.d	$6,5.00000000000000000000e-1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__gtdf2
	move	$5,$3
	.set	macro
	.set	reorder

	blez	$2,$L990
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
	j	$L999
	sw	$16,484($17)
	.set	macro
	.set	reorder

$L990:
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
$L999:
	jal	Math_NormalizeShortVector__FP8coorddef
$L987:
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
	bne	$3,$2,$L1001
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
	j	$L1002
	sw	$2,56($sp)
	.set	macro
	.set	reorder

$L1001:
	lw	$2,32($sp)
	lw	$3,36($sp)
	sw	$4,56($sp)
	sw	$2,48($sp)
	sw	$3,52($sp)
$L1002:
	lw	$3,300($17)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	beq	$2,$0,$L1003
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
	j	$L1004
	sw	$3,72($sp)
	.set	macro
	.set	reorder

$L1003:
	lw	$7,160($17)
	lw	$8,164($17)
	lw	$9,168($17)
	sw	$7,64($sp)
	sw	$8,68($sp)
	sw	$9,72($sp)
	lw	$2,384($17)
	#nop
	sw	$2,68($sp)
$L1004:
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
$L1008:
	lw	$3,656($5)
	#nop
	sw	$3,492($4)
	lw	$2,176($17)
	#nop
	bgez	$2,$L1009
	addu	$2,$2,63
$L1009:
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
	bne	$2,$0,$L1008
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
	beq	$6,$0,$L1012
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
	beq	$6,$0,$L1012
	sw	$4,8($sp)
	.set	macro
	.set	reorder

	lh	$3,8($5)
	#nop
	bne	$3,$2,$L1012
	lw	$2,608($5)
	lw	$3,1396($5)
	andi	$2,$2,0x0230
	bne	$2,$0,$L1012
	lw	$2,4($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1012
	move	$2,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1012
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,628($5)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L1012
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
$L1012:
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
	bgez	$7,$L1029
	sra	$2,$7,8
	.set	macro
	.set	reorder

	addu	$7,$7,255
	sra	$2,$7,8
$L1029:
	sll	$2,$2,8
	subu	$2,$0,$2
	sw	$2,24($sp)
 #APP
 #NO_APP
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1019
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L1019:
	sra	$3,$2,8
	sll	$11,$3,8
	sw	$11,32($sp)
	lw	$2,172($17)
	#nop
	bgez	$2,$L1021
	addu	$2,$2,255
$L1021:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$4
	#nop
	bgez	$6,$L1022
	addu	$6,$6,255
$L1022:
	lw	$2,176($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1023
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1023:
	sra	$2,$2,8
	mult	$6,$2
	#.set	volatile
	lw	$3,124($sp)
	#.set	novolatile
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1024
	addu	$5,$4,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1024:
	lw	$2,180($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1025
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1025:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$12
	#nop
	#nop
	addu	$5,$5,$12
	bgez	$5,$L1026
	subu	$5,$0,$5
$L1026:
 #APP
 #NO_APP
	subu	$2,$0,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1030
	sra	$5,$2,4
	.set	macro
	.set	reorder

	addu	$2,$2,15
	sra	$5,$2,4
$L1030:
	slt	$2,$5,-1965
	bne	$2,$0,$L1028
	li	$5,-1966			# 0xfffff852
$L1028:
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
	bne	$4,$2,$L1032
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
	j	$L1040
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L1032:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1034
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
	j	$L1040
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L1034:
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1036
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
	j	$L1040
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L1036:
	bne	$4,$2,$L1033
	lw	$2,16($6)
	lw	$3,52($6)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,8($6)
	lw	$3,44($6)
	#nop
	subu	$2,$2,$3
$L1040:
	sw	$2,16($sp)
$L1033:
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
	beq	$2,$0,$L1044
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	beq	$2,$0,$L1043
$L1044:
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
	beq	$2,$0,$L1042
$L1043:
	li	$7,1			# 0x00000001
$L1042:
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
$L1046:
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
	bne	$3,$4,$L1046
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
	beq	$2,$0,$L1105
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$3,172($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L1048
	addu	$2,$2,255
$L1048:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$3,176($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L1049
	addu	$2,$2,255
$L1049:
	sra	$2,$2,8
	sw	$2,68($sp)
	lw	$3,180($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	bgez	$2,$L1050
	addu	$2,$2,255
$L1050:
	sra	$2,$2,8
	sw	$2,72($sp)
	move	$18,$0
$L1105:
	sw	$0,132($sp)
	move	$21,$17
	lui	$23,%hi(testSimRoadInfo) # high
	addiu	$22,$23,%lo(testSimRoadInfo) # low
	addu	$20,$21,8
	lui	$11,%hi(newtestSimRoadInfo) # high
	addiu	$fp,$11,%lo(newtestSimRoadInfo) # low
$L1051:
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1045
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
	beq	$4,$0,$L1055
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
	j	$L1056
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

$L1055:
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
	beq	$2,$0,$L1056
	lui	$11,%hi(newtestSimRoadInfo) # high
	.set	macro
	.set	reorder

	addiu	$3,$11,%lo(newtestSimRoadInfo) # low
	move	$2,$22
$L1058:
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
	bne	$2,$11,$L1058
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
	beq	$16,$2,$L1099
	li	$19,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$19,$L1061
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1100
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L1061:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L1100
	move	$4,$2
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	bne	$16,$2,$L1060
$L1099:
	move	$4,$2
$L1100:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	move	$6,$20
	.set	macro
	.set	reorder

$L1060:
	andi	$2,$16,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1066
	andi	$2,$16,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1101
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	andi	$2,$16,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1068
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L1101:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L1068:
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
	beq	$2,$0,$L1066
	andi	$2,$16,0x000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1071
	andi	$2,$16,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1072
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	j	$L1102
	addu	$6,$17,8
	.set	macro
	.set	reorder

$L1072:
	andi	$2,$16,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1073
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	addu	$6,$17,$4
$L1102:
	jal	Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
$L1073:
	lui	$11,%hi(newtestSimRoadInfo) # high
	addiu	$3,$11,%lo(newtestSimRoadInfo) # low
	addiu	$2,$23,%lo(testSimRoadInfo) # low
$L1075:
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
	bne	$2,$11,$L1075
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
	beq	$2,$0,$L1066
	move	$7,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(testSimRoadInfo+8) # high
	addiu	$6,$2,%lo(testSimRoadInfo+8) # low
	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L1077:
	slt	$2,$7,4
	beq	$2,$0,$L1078
	lw	$2,120($22)
	#nop
	beq	$2,$0,$L1079
	lw	$10,0($6)
	lw	$11,4($6)
	lw	$12,8($6)
	sw	$10,112($sp)
	sw	$11,116($sp)
	sw	$12,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L1103
	addu	$6,$6,12
	.set	macro
	.set	reorder

$L1079:
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
$L1103:
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
	j	$L1077
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L1078:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L1081
	addu	$3,$3,3
$L1081:
	lw	$2,52($sp)
	sra	$5,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1082
	sw	$5,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L1082:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1083
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L1083:
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
	j	$L1066
	sw	$4,24($sp)
	.set	macro
	.set	reorder

$L1071:
	move	$7,$0
	lui	$2,%hi(testSimRoadInfo+8) # high
	addiu	$6,$2,%lo(testSimRoadInfo+8) # low
	sw	$0,56($sp)
	sw	$0,52($sp)
	sw	$0,48($sp)
$L1085:
	slt	$2,$7,4
	beq	$2,$0,$L1086
	lw	$2,120($22)
	#nop
	beq	$2,$0,$L1087
	lw	$13,0($6)
	lw	$9,4($6)
	lw	$10,8($6)
	sw	$13,112($sp)
	sw	$9,116($sp)
	sw	$10,120($sp)
	.set	noreorder
	.set	nomacro
	j	$L1104
	addu	$6,$6,12
	.set	macro
	.set	reorder

$L1087:
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
$L1104:
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
	j	$L1085
	sw	$3,56($sp)
	.set	macro
	.set	reorder

$L1086:
	lw	$3,48($sp)
	#nop
	bgez	$3,$L1089
	addu	$3,$3,3
$L1089:
	lw	$2,52($sp)
	sra	$4,$3,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1090
	sw	$4,48($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L1090:
	lw	$3,56($sp)
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1091
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L1091:
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
$L1066:
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L1056:
	beq	$19,$0,$L1092
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
	beq	$2,$0,$L1093
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L1093:
	lw	$5,400($17)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1045
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L1095
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$6,132($sp)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1106
	move	$4,$17
	.set	macro
	.set	reorder

	li	$6,4			# 0x00000004
$L1095:
	move	$4,$17
$L1106:
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L1045
$L1092:
	addu	$21,$21,48
	lw	$10,132($sp)
	addu	$18,$18,1
	addu	$10,$10,2
	.set	noreorder
	.set	nomacro
	j	$L1051
	sw	$10,132($sp)
	.set	macro
	.set	reorder

$L1045:
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
	bne	$2,$0,$L1109
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1108
$L1109:
	sw	$3,276($4)
$L1108:
	li	$3,65536			# 0x00010000
	lw	$5,280($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L1111
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1110
$L1111:
	sw	$3,280($4)
$L1110:
	li	$3,65536			# 0x00010000
	lw	$5,284($4)
	ori	$3,$3,0x8000
	slt	$2,$3,$5
	bne	$2,$0,$L1113
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
	slt	$2,$5,$3
	beq	$2,$0,$L1115
$L1113:
	sw	$3,284($4)
$L1115:
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
	beq	$2,$0,$L1150
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

	beq	$2,$0,$L1150
	lbu	$2,144($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1118
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
	j	$L1150
	sw	$2,164($18)
	.set	macro
	.set	reorder

$L1118:
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
	bgez	$2,$L1120
	addu	$16,$sp,32
	.set	macro
	.set	reorder

	addu	$2,$2,7
$L1120:
	sra	$2,$2,3
	sw	$2,372($18)
	slt	$2,$20,13107
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1121
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
	j	$L1122
	sw	$3,176($18)
	.set	macro
	.set	reorder

$L1121:
	lhu	$2,380($18)
	#nop
	beq	$2,$0,$L1123
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1124
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1124:
	lw	$2,176($18)
	lw	$3,300($18)
	subu	$6,$19,$2
	li	$2,45875			# 0x0000b333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1125
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
	beq	$2,$0,$L1126
	li	$2,1245184			# 0x00130000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1127
	li	$4,1310720			# 0x00140000
	.set	macro
	.set	reorder

	move	$4,$3
$L1127:
	sw	$4,400($18)
$L1126:
	lw	$2,300($18)
	#nop
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1129
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1129
	sw	$2,1932($18)
	.set	macro
	.set	reorder

$L1125:
	move	$5,$3
	move	$4,$18
$L1133:
	lw	$2,680($4)
	addu	$5,$5,1
	addu	$3,$3,$2
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1133
	addu	$4,$4,48
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L1129
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	bgez	$2,$L1136
	addu	$2,$2,3
$L1136:
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
	beq	$2,$0,$L1137
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

$L1137:
	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L1129
	lw	$4,400($18)
	jal	Force_HitWall__Fi
$L1129:
	.set	noreorder
	.set	nomacro
	jal	Newton_LimitAngularVelocity__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1151
	slt	$2,$20,2621
	.set	macro
	.set	reorder

$L1123:
	.set	noreorder
	.set	nomacro
	jal	Newton_CheckForSpikeBelts__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

	slt	$2,$20,2621
$L1151:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1152
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
	bne	$3,$0,$L1141
	sw	$2,164($18)
	.set	macro
	.set	reorder

	lw	$3,300($18)
	li	$2,58982			# 0x0000e666
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1153
	li	$2,327680			# 0x00050000
	.set	macro
	.set	reorder

	sh	$0,380($18)
$L1141:
	li	$2,327680			# 0x00050000
$L1153:
	ori	$2,$2,0xffff
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1142
	li	$2,786432			# 0x000c0000
	.set	macro
	.set	reorder

	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1143
	li	$16,65503			# 0x0000ffdf
	.set	macro
	.set	reorder

	li	$16,65470			# 0x0000ffbe
$L1143:
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
$L1142:
	li	$2,262144			# 0x00040000
	lw	$3,192($18)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1144
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$19,$L1145
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$19,3
$L1145:
	sra	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L1122
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L1144:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1147
	srl	$2,$19,31
	.set	macro
	.set	reorder

	addu	$2,$19,$2
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1122
	sw	$2,176($18)
	.set	macro
	.set	reorder

$L1147:
	sw	$19,176($18)
$L1122:
	lui	$2,%hi(simGlobal+4) # high
$L1152:
	lw	$2,%lo(simGlobal+4)($2)
	addu	$4,$18,8
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	sw	$2,156($18)
	.set	macro
	.set	reorder

	beq	$2,$0,$L1150
	lw	$4,176($18)
	#nop
	blez	$4,$L1150
	lw	$2,164($18)
	lw	$3,364($18)
	#nop
	subu	$2,$2,$3
	li	$3,524288			# 0x00080000
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1150
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	sw	$2,176($18)
$L1150:
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
	bgez	$4,$L1162
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1162:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1156
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1156:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,4($6)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1163
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1163:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1158
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1158:
	sra	$2,$2,8
	mult	$4,$2
	lw	$6,8($6)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1159
	addu	$4,$5,$9
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1159:
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1160
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1160:
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
	bgez	$6,$L1172
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1172:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1166
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1166:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($8)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1173
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1173:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1168
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1168:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,332($8)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1169
	addu	$3,$6,$9
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1169:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1170
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1170:
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
