	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\physics.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
	.align	2
	.globl	Physics_CalculateDerivedCarSpecs__FP8Car_tObj
	.align	2
	.globl	Physics_CheckGamedata__Fv
	.align	2
	.globl	Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
	.align	2
	.globl	Physics_SetCurrentWallType__Fi
	.align	2
	.globl	Physics_GetTorque__FP8Car_tObji
	.align	2
	.globl	Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
	.align	2
	.globl	Physics_DoBarrierCheck__FP8Car_tObj
	.align	2
	.globl	Physics_AutoShift__FP8Car_tObj
	.align	2
	.globl	Physics_RampCarControlValues__FP8Car_tObj
	.align	2
	.globl	Physics_FixEngineRpm__FP8Car_tObj
	.align	2
	.globl	Physics_ResetCar__FP8Car_tObj
	.align	2
	.globl	Physics_StopCar__FP8Car_tObj
	.align	2
	.globl	Physics_TestForBarrierCollision__FP8Car_tObj
	.align	2
	.globl	Physics_CalculateRoadGripModifiers__FP8Car_tObj
	.rdata
	.align	2
$LC0:
	.word	0
	.word	0
	.word	250
	.word	200
	.word	175
	.word	150
	.word	125
	.word	0
	.align	2
$LC1:
	.word	0
	.word	0
	.word	200
	.word	175
	.word	150
	.word	125
	.word	100
	.word	0
	.text
	.align	2
	.globl	Physics_CalculateCarAcceleration__FP8Car_tObj
	.align	2
	.globl	Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	.align	2
	.globl	Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	.align	2
	.globl	Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
	.align	2
	.globl	Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
	.align	2
	.globl	Physics_Real__FP8Car_tObj
	.align	2
	.globl	Physics_SimCar__FP8Car_tObj
	.globl	gBrakeRatio
	.sdata
	.align	2
gBrakeRatio:
	.space	4
	.globl	gGasRatio
	.align	2
gGasRatio:
	.space	4
	.globl	gSteerRatio
	.align	2
gSteerRatio:
	.space	4
	.globl	currentWallType
	.align	2
currentWallType:
	.space	4
	.globl	exceedRedline
	.align	2
exceedRedline:
	.space	4
	.globl	roadMult
	.align	2
roadMult:
	.space	4
	.globl	frontMult
	.align	2
frontMult:
	.space	4
	.globl	rearMult
	.align	2
rearMult:
	.space	4
	.globl	leftMult
	.align	2
leftMult:
	.space	4
	.globl	rightMult
	.align	2
rightMult:
	.space	4
	.globl	slippery
	.align	2
slippery:
	.space	4
	.globl	steeringControl
	.align	2
steeringControl:
	.space	4
	.globl	powerControl
	.align	2
powerControl:
	.space	4

	.extern	gNumSlices, 4
	.extern	AITune_driveSide, 4
	.extern	gripLossTable, 12
	.extern	gripLossTableWet, 12
	.extern	gravity_ch, 12
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	roadSurfaceFrictionCoeff, 40
	.extern	roadSurfaceIndex, 60
	.extern	AIInit_forceHumanHandBrake, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	simGlobal, 24
	.extern	BWorldSm_slices, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	move	$4,$17
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,0($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,4($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$16,$0
	sw	$2,8($3)
$L601:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$3,$16,2
	lw	$4,1124($18)
	addu	$16,$16,1
	addu	$4,$4,$3
	sw	$2,12($4)
	slt	$2,$16,8
	bne	$2,$0,$L601
	move	$16,$0
$L605:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$3,$16,2
	lw	$4,1124($18)
	addu	$16,$16,1
	addu	$4,$4,$3
	sw	$2,44($4)
	slt	$2,$16,8
	bne	$2,$0,$L605
	move	$16,$0
$L609:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$3,$16,2
	lw	$4,1124($18)
	addu	$16,$16,1
	addu	$4,$4,$3
	sw	$2,76($4)
	slt	$2,$16,41
	bne	$2,$0,$L609
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,240($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,244($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,248($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,252($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,256($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,260($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,264($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,268($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,272($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,276($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,280($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,284($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,288($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,292($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,296($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,300($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,304($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,308($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,312($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,316($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,320($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,324($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,328($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,332($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,336($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,340($3)
	.set	macro
	.set	reorder

	lw	$3,1124($18)
	#nop
	sw	$2,344($3)
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

	.end	Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
	.text
	.ent	Physics_CalculateDerivedCarSpecs__FP8Car_tObj
Physics_CalculateDerivedCarSpecs__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$4,1124($17)
	#nop
	lw	$3,240($4)
	li	$2,65536			# 0x00010000
	div	$2,$2,$3
	sw	$2,348($4)
	lw	$2,648($17)
	#nop
	lw	$2,64($2)
	li	$16,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L614
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	lw	$2,272($3)
	#nop
	addu	$2,$2,$16
	sw	$2,272($3)
	lw	$2,1124($17)
	li	$5,65536			# 0x00010000
	lw	$4,268($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x147a
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,268($3)
$L614:
	lw	$2,648($17)
	#nop
	lw	$2,68($2)
	#nop
	bne	$2,$16,$L615
	lw	$3,1124($17)
	#nop
	lw	$2,272($3)
	#nop
	addu	$2,$2,1
	sw	$2,272($3)
	lw	$2,1124($17)
	li	$5,65536			# 0x00010000
	lw	$4,280($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,280($3)
	lw	$2,1124($17)
	li	$5,65536			# 0x00010000
	lw	$4,284($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,284($3)
	lw	$2,1124($17)
	#nop
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,0($3)
	lw	$2,1124($17)
	li	$5,65536			# 0x00010000
	lw	$4,276($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x1999
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,276($3)
$L615:
	lw	$2,648($17)
	#nop
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L616
	li	$5,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$4,1124($17)
	#nop
	lw	$2,8($4)
	#nop
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,8($4)
	lw	$2,1124($17)
	#nop
	lw	$4,252($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x4000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,252($3)
$L617:
	li	$5,65536			# 0x00010000
	lw	$2,1124($17)
	sll	$16,$18,2
	addu	$2,$2,$16
	lw	$4,76($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x2666
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	addu	$18,$18,1
	addu	$3,$3,$16
	sw	$2,76($3)
	slt	$2,$18,41
	bne	$2,$0,$L617
	lw	$2,1124($17)
	li	$5,65536			# 0x00010000
	lw	$4,244($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x1999
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,244($3)
$L616:
	lw	$3,1124($17)
	#nop
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L637
	move	$18,$0
	.set	macro
	.set	reorder

	move	$16,$18
$L624:
	addu	$3,$3,$16
	lw	$5,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L625
	li	$2,655			# 0x0000028f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	addu	$3,$3,$16
$L625:
	sw	$2,384($3)
	lw	$3,1124($17)
	#nop
	addu	$2,$3,$16
	lw	$4,12($2)
	lw	$5,0($3)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	addu	$3,$3,$16
	sw	$2,416($3)
	lw	$2,1124($17)
	#nop
	addu	$2,$2,$16
	lw	$4,416($2)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$5,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	addu	$3,$3,$16
	sw	$2,416($3)
	lw	$2,1124($17)
	#nop
	addu	$2,$2,$16
	lw	$4,416($2)
	lw	$5,44($2)
	jal	fixedmult
	lw	$3,1124($17)
	#nop
	addu	$3,$3,$16
	sw	$2,416($3)
	lw	$2,1124($17)
	#nop
	addu	$3,$2,$16
	lw	$5,240($2)
	lw	$4,384($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,16
	.set	macro
	.set	reorder

	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	addu	$3,$3,$16
	sw	$2,352($3)
	lw	$3,1124($17)
	#nop
	lw	$2,4($3)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	lw	$2,4($3)
$L637:
	lw	$4,244($3)
	addu	$2,$2,-1
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$5,12($3)
	jal	fixedmult
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L635
	sra	$2,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$2,$3,16
$L635:
	lw	$5,1124($17)
	bgez	$2,$L629
	addu	$2,$2,255
$L629:
	sra	$2,$2,8
	sll	$2,$2,2
	addu	$2,$5,$2
	lw	$3,4($5)
	lw	$4,76($2)
	addu	$3,$3,-1
	sll	$3,$3,2
	addu	$3,$5,$3
	lw	$5,416($3)
	jal	fixedmult
	lw	$3,1124($17)
	#nop
	lw	$3,244($3)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L630
	move	$5,$3
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$5,$3,$2
$L630:
	sra	$2,$5,16
	mult	$2,$2
	mflo	$7
	#nop
	#nop
	mult	$7,$2
	mflo	$5
	#nop
	jal	fixeddiv
	lw	$3,1124($17)
	#nop
	sw	$2,448($3)
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$2,%lo(GameSetup_gData+60)($2)
	#nop
	slt	$2,$2,8
	bne	$2,$0,$L633
	lw	$3,1124($17)
	#nop
	lw	$2,288($3)
	#nop
	addu	$2,$2,9830
	sw	$2,288($3)
	lw	$3,1124($17)
	#nop
	lw	$2,256($3)
	#nop
	addu	$2,$2,-9830
	sw	$2,256($3)
	lw	$3,1124($17)
	#nop
	lw	$2,264($3)
	#nop
	addu	$2,$2,327
	sw	$2,264($3)
$L633:
	lw	$2,1124($17)
	#nop
	lw	$5,260($2)
	li	$4,65536			# 0x00010000
	srl	$2,$5,31
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,1
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,452($3)
	lw	$2,1124($17)
	#nop
	lw	$4,452($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1608			# 0x00000648
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,452($3)
	lw	$3,1124($17)
	#nop
	lw	$2,452($3)
	#nop
	sll	$2,$2,8
	sw	$2,452($3)
	lw	$2,1124($17)
	#nop
	lw	$5,452($2)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,456($3)
	lw	$2,1124($17)
	#nop
	lw	$5,276($2)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	sw	$2,460($3)
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

	.end	Physics_CalculateDerivedCarSpecs__FP8Car_tObj
	.text
	.ent	Physics_CheckGamedata__Fv
Physics_CheckGamedata__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Physics_CheckGamedata__Fv
	.text
	.ent	Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef:
	.frame	$sp,96,$31		# vars= 56, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$18,80($sp)
	move	$18,$4
	move	$4,$6
	move	$3,$5
	sw	$31,88($sp)
	sw	$19,84($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	sw	$5,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L640
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L640:
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L641
	sra	$6,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L641:
	sra	$2,$2,8
	mult	$6,$2
	mflo	$7
	#nop
	lw	$2,12($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L647
	move	$8,$7
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L647:
	sra	$2,$2,8
	mult	$6,$2
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L652
	move	$7,$0
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L652:
	lw	$2,24($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L653
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L653:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,20($sp)
	mflo	$5
	#nop
	bgez	$3,$L654
	addu	$3,$3,255
$L654:
	lw	$2,28($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L655
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L655:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$9
	#nop
	#nop
	addu	$5,$5,$9
	lw	$2,160($18)
	lw	$7,172($18)
	lw	$3,168($18)
	subu	$2,$2,$8
	sw	$2,160($18)
	lw	$2,164($18)
	addu	$3,$3,$5
	sw	$3,168($18)
	addu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$7,$L658
	sw	$2,164($18)
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L658:
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L659
	sra	$5,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L659:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,176($18)
	mflo	$5
	#nop
	bgez	$3,$L660
	addu	$3,$3,255
$L660:
	lw	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L661
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L661:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,180($18)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L662
	addu	$5,$5,$9
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L662:
	lw	$2,8($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L663
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L663:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$9
	#nop
	#nop
	addu	$2,$5,$9
	subu	$6,$0,$2
	sw	$6,16($sp)
	lw	$3,172($18)
	#nop
	bgez	$3,$L664
	addu	$3,$3,255
$L664:
	lw	$2,24($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L665
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L665:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,176($18)
	mflo	$5
	#nop
	bgez	$3,$L666
	addu	$3,$3,255
$L666:
	lw	$2,28($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L667
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L667:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,180($18)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L668
	addu	$5,$5,$9
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L668:
	lw	$2,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L669
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L669:
	sra	$2,$2,8
	mult	$3,$2
	.set	noreorder
	bgez	$6,1f
	move	$2,$6
	subu	$2,$0,$2
1:
	.set	reorder
	sra	$19,$2,1
	sw	$0,16($sp)
	mflo	$9
	#nop
	#nop
	addu	$5,$5,$9
	.set	noreorder
	.set	nomacro
	blez	$5,$L670
	sw	$5,24($sp)
	.set	macro
	.set	reorder

	li	$2,327680			# 0x00050000
	slt	$2,$2,$5
	beq	$2,$0,$L683
	.set	noreorder
	.set	nomacro
	bgez	$19,$L672
	move	$3,$19
	.set	macro
	.set	reorder

	addu	$3,$19,255
$L672:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,6
	subu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L674
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L683
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L670:
	li	$2,-327680			# 0xfffb0000
	slt	$2,$5,$2
	beq	$2,$0,$L683
	.set	noreorder
	.set	nomacro
	bgez	$19,$L676
	move	$3,$19
	.set	macro
	.set	reorder

	addu	$3,$19,255
$L676:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,6
	addu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	blez	$2,$L674
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	sw	$0,24($sp)
$L674:
$L683:
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,32($sp)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,172($18)
	lw	$4,16($sp)
	lw	$5,56($sp)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$3,176($18)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L678
	sw	$16,180($18)
	.set	macro
	.set	reorder

	sw	$0,176($18)
$L678:
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
	addu	$16,$16,$2
	lw	$2,172($18)
	lw	$3,180($18)
	.set	noreorder
	bgez	$2,1f
	move	$4,$2
	subu	$4,$0,$4
1:
	.set	reorder
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	sw	$16,1056($18)
	.set	macro
	.set	reorder

	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L682
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L679:
	sra	$2,$4,2
	addu	$2,$3,$2
$L682:
	sw	$2,192($18)
	move	$2,$19
	lw	$31,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
	.text
	.ent	Physics_SetCurrentWallType__Fi
Physics_SetCurrentWallType__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,currentWallType
	j	$31
	.end	Physics_SetCurrentWallType__Fi
	.text
	.ent	Physics_GetTorque__FP8Car_tObji
Physics_GetTorque__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	slt	$6,$5,41
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L686
	move	$2,$5
	.set	macro
	.set	reorder

	li	$2,40			# 0x00000028
$L686:
	.set	noreorder
	.set	nomacro
	blez	$2,$L687
	move	$3,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L687
	li	$3,40			# 0x00000028
	.set	macro
	.set	reorder

	move	$3,$5
$L687:
	lw	$2,1124($4)
	sll	$3,$3,2
	addu	$2,$2,$3
	lw	$2,76($2)
	j	$31
	.end	Physics_GetTorque__FP8Car_tObji
	.text
	.ent	Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	li	$4,917504			# 0x000e0000
	ori	$4,$4,0xffff
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,1
	li	$3,262144			# 0x00040000
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$6,48($sp)
	sw	$7,52($sp)
	sw	$2,400($18)
	lw	$2,currentWallType
	slt	$4,$4,$5
	sw	$0,404($18)
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L690
	sw	$2,408($18)
	.set	macro
	.set	reorder

	li	$2,1245184			# 0x00130000
	lw	$3,1056($18)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L688
$L690:
	lw	$4,48($sp)
	lw	$5,476($18)
	jal	fixedmult
	lw	$4,52($sp)
	lw	$5,480($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,56($sp)
	lw	$5,484($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,48($sp)
	lw	$5,452($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$19,$16,$2
	.set	macro
	.set	reorder

	lw	$4,52($sp)
	lw	$5,456($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,56($sp)
	lw	$5,460($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
 #APP
 #NO_APP
	.set	noreorder
	bgez	$19,1f
	move	$4,$19
	subu	$4,$0,$4
1:
	.set	reorder
	.set	noreorder
	bgez	$16,1f
	move	$3,$16
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L691
	sra	$4,$4,1
	.set	macro
	.set	reorder

	sra	$4,$3,1
$L691:
	bgez	$19,$L693
	.set	noreorder
	.set	nomacro
	bgez	$16,$L700
	li	$2,851968			# 0x000d0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L700
	subu	$4,$0,$4
	.set	macro
	.set	reorder

$L693:
	blez	$16,$L696
	subu	$4,$0,$4
$L696:
	sra	$4,$4,1
	li	$2,851968			# 0x000d0000
$L700:
	lw	$3,1056($18)
	ori	$2,$2,0x6666
	slt	$2,$2,$3
	beq	$2,$0,$L697
	blez	$4,$L699
	lw	$2,1104($18)
	#nop
	bgtz	$2,$L698
$L699:
	bgez	$4,$L697
	lw	$2,1104($18)
	#nop
	bgez	$2,$L697
$L698:
	sra	$4,$4,2
$L697:
	sw	$4,280($18)
$L688:
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

	.end	Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
	.text
	.ent	Physics_DoBarrierCheck__FP8Car_tObj
Physics_DoBarrierCheck__FP8Car_tObj:
	.frame	$sp,120,$31		# vars= 64, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$17,92($sp)
	move	$17,$4
	sw	$20,104($sp)
	move	$20,$0
	sw	$31,112($sp)
	sw	$21,108($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$16,88($sp)
	lh	$21,8($17)
	lw	$2,BWorldSm_slices
	sll	$3,$21,5
	addu	$3,$3,$2
	lb	$2,18($3)
	lb	$4,20($3)
 #APP
 #NO_APP
	sll	$5,$2,9
 #APP
 #NO_APP
	lb	$2,19($3)
	move	$19,$20
	sw	$5,40($sp)
 #APP
 #NO_APP
	lw	$6,40($sp)
 #APP
 #NO_APP
	sll	$4,$4,9
	sw	$4,48($sp)
	sll	$2,$2,9
	sw	$2,44($sp)
 #APP
 #NO_APP
	lw	$4,0($3)
 #APP
 #NO_APP
	lw	$2,172($17)
	lw	$5,160($17)
	sra	$2,$2,5
	addu	$2,$5,$2
	subu	$7,$2,$4
 #APP
 #NO_APP
	sw	$7,24($sp)
 #APP
 #NO_APP
	lw	$4,4($3)
 #APP
 #NO_APP
	lw	$2,176($17)
	lw	$5,164($17)
	sra	$2,$2,5
	addu	$2,$5,$2
	subu	$8,$2,$4
 #APP
 #NO_APP
	sw	$8,28($sp)
 #APP
 #NO_APP
	lw	$4,8($3)
 #APP
 #NO_APP
	lw	$2,180($17)
	lw	$5,168($17)
 #APP
 #NO_APP
	sra	$2,$2,5
	addu	$2,$5,$2
	subu	$3,$2,$4
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bgez	$6,$L702
	sw	$3,32($sp)
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L702:
	move	$2,$7
	.set	noreorder
	.set	nomacro
	bgez	$2,$L703
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L703:
	sra	$2,$2,8
	mult	$6,$2
	lw	$5,44($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L744
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L744:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L705
	sra	$6,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L705:
	sra	$2,$2,8
	mult	$6,$2
	lw	$5,48($sp)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L745
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L745:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L707
	sra	$3,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L707:
	sra	$2,$2,8
	mult	$3,$2
 #APP
 #NO_APP
	addu	$2,$9,$6
	#nop
	lw	$4,268($17)
	lw	$3,264($17)
	lw	$7,272($17)
	move	$5,$3
	mflo	$10
	addu	$18,$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$3,$L708
	sw	$18,196($17)
	.set	macro
	.set	reorder

	addu	$5,$3,255
$L708:
	lw	$2,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L709
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L709:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L710
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L710:
	lw	$2,44($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L711
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L711:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L712
	move	$3,$7
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L712:
	lw	$2,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L713
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L713:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,316($17)
	addu	$2,$9,$6
	mflo	$11
	#nop
	#nop
	addu	$16,$2,$11
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	blez	$2,$L714
	lw	$4,316($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L715
	move	$8,$2
	.set	macro
	.set	reorder

$L714:
	lw	$4,316($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	subu	$8,$0,$2
$L715:
	lw	$4,244($17)
	lw	$3,240($17)
	lw	$7,248($17)
	bgez	$3,$L716
	addu	$3,$3,255
$L716:
	lw	$2,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L717
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L717:
	sra	$2,$2,8
	mult	$5,$2
	move	$3,$4
	mflo	$9
	#nop
	bgez	$3,$L718
	addu	$3,$3,255
$L718:
	lw	$2,44($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L719
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L719:
	sra	$2,$2,8
	mult	$4,$2
	move	$3,$7
	mflo	$6
	#nop
	bgez	$3,$L720
	addu	$3,$3,255
$L720:
	lw	$2,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L721
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L721:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,308($17)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L746
	addu	$2,$9,$6
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L746:
	addu	$2,$2,$11
	.set	noreorder
	.set	nomacro
	bgez	$2,$L723
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L723:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,BWorldSm_slices
	sll	$2,$21,5
	addu	$5,$2,$3
	lh	$3,24($5)
	lw	$2,1924($17)
	sll	$3,$3,8
	mflo	$10
	#nop
	#nop
	.set	noreorder
	bgez	$10,1f
	move	$4,$10
	subu	$4,$0,$4
1:
	.set	reorder
	addu	$8,$8,$4
	subu	$3,$8,$3
	subu	$2,$3,$2
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$19,-1			# 0xffffffff
	subu	$20,$3,$18
	sw	$2,currentWallType
$L724:
	lh	$3,26($5)
	lw	$2,1924($17)
	sll	$3,$3,8
	subu	$3,$3,$8
	addu	$2,$3,$2
	slt	$2,$2,$18
	beq	$2,$0,$L725
	li	$19,1			# 0x00000001
	subu	$20,$18,$3
	sw	$19,currentWallType
$L725:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L726
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L727
	.set	noreorder
	.set	nomacro
	jal	Force_HitWall__Fi
	li	$4,1966080			# 0x001e0000
	.set	macro
	.set	reorder

$L727:
	lw	$2,308($17)
	#nop
	bgez	$2,$L728
	addu	$2,$2,255
$L728:
	lw	$3,40($sp)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L747
	sra	$4,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$4,$2,8
$L747:
	sw	$4,72($sp)
	lw	$2,308($17)
	#nop
	bgez	$2,$L730
	addu	$2,$2,255
$L730:
	lw	$3,44($sp)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L731
	addu	$2,$2,255
$L731:
	sra	$2,$2,8
	sw	$2,76($sp)
	lw	$2,308($17)
	#nop
	bgez	$2,$L732
	addu	$2,$2,255
$L732:
	lw	$3,48($sp)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L733
	addu	$2,$2,255
$L733:
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	blez	$19,$L734
	sw	$2,80($sp)
	.set	macro
	.set	reorder

	lw	$2,160($17)
	#nop
	addu	$2,$2,$4
	sw	$2,416($17)
	lw	$2,164($17)
	lw	$3,76($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,420($17)
	lw	$2,168($17)
	lw	$3,80($sp)
	.set	noreorder
	.set	nomacro
	j	$L743
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L734:
	lw	$2,160($17)
	#nop
	subu	$2,$2,$4
	sw	$2,416($17)
	lw	$2,164($17)
	lw	$3,76($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,420($17)
	lw	$2,168($17)
	lw	$3,80($sp)
	#nop
	subu	$2,$2,$3
$L743:
	sw	$2,424($17)
	lw	$3,392($17)
	li	$2,39321			# 0x00009999
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L737
	li	$2,58981			# 0x0000e665
	.set	macro
	.set	reorder

	lw	$3,300($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L737
	lhu	$2,380($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L736
	sll	$5,$20,1
	.set	macro
	.set	reorder

$L737:
	bgez	$19,$L738
	lw	$2,40($sp)
	lw	$3,44($sp)
	lw	$4,48($sp)
	sw	$2,56($sp)
	sw	$3,60($sp)
	.set	noreorder
	.set	nomacro
	j	$L739
	sw	$4,64($sp)
	.set	macro
	.set	reorder

$L738:
	lw	$2,40($sp)
	lw	$3,48($sp)
	subu	$2,$0,$2
	sw	$2,56($sp)
	lw	$2,44($sp)
	subu	$3,$0,$3
	sw	$3,64($sp)
	subu	$2,$0,$2
	sw	$2,60($sp)
$L739:
	move	$4,$17
	addu	$5,$sp,56
	.set	noreorder
	.set	nomacro
	jal	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
	addu	$6,$17,160
	.set	macro
	.set	reorder

	lw	$2,400($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	li	$3,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$2,currentWallType
	sw	$0,404($17)
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L741
	sw	$2,408($17)
	.set	macro
	.set	reorder

$L736:
	bgez	$5,1f
	subu	$5,$0,$5
1:
	mult	$19,$5
	move	$4,$17
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	jal	Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
	addu	$6,$17,324
	.set	macro
	.set	reorder

	lw	$3,64($sp)
	move	$4,$17
	sw	$3,16($sp)
	lw	$6,56($sp)
	lw	$7,60($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
	move	$5,$2
	.set	macro
	.set	reorder

$L741:
	move	$2,$19
$L726:
	lw	$31,112($sp)
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

	.end	Physics_DoBarrierCheck__FP8Car_tObj
	.text
	.ent	Physics_AutoShift__FP8Car_tObj
Physics_AutoShift__FP8Car_tObj:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$4,1124($16)
	li	$2,715784192			# 0x2aaa0000
	lw	$5,240($4)
	ori	$2,$2,0xaaab
	mult	$5,$2
	move	$22,$0
	lbu	$2,1090($16)
	sra	$6,$5,31
	sltu	$2,$2,2
	mfhi	$7
	#nop
	#nop
	subu	$3,$7,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	subu	$21,$5,$3
	.set	macro
	.set	reorder

	lw	$2,1120($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	subu	$2,$5,$6
	.set	macro
	.set	reorder

	sra	$2,$2,1
	subu	$21,$5,$2
$L750:
	lw	$2,4($4)
	lw	$3,1144($16)
	addu	$2,$2,-2
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$4,384($2)
	.set	noreorder
	bgez	$3,1f
	move	$23,$3
	subu	$23,$0,$23
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lw	$5,1124($16)
	#nop
	lw	$3,244($5)
	#nop
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L768
	addu	$3,$22,1
	.set	macro
	.set	reorder

	li	$22,1			# 0x00000001
	addu	$3,$22,1
$L768:
	lbu	$4,1090($16)
	lw	$2,4($5)
	#nop
	subu	$2,$2,$3
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	move	$19,$4
	.set	macro
	.set	reorder

	addu	$19,$19,1
$L753:
	sltu	$2,$4,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L755
	move	$18,$4
	.set	macro
	.set	reorder

	addu	$18,$4,-1
$L755:
	lw	$2,1056($16)
	lw	$17,192($16)
	bgez	$2,$L756
	subu	$17,$0,$17
$L756:
	lbu	$2,1090($16)
	lw	$3,1124($16)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$5,12($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$17
	.set	macro
	.set	reorder

	move	$6,$2
	.set	noreorder
	.set	nomacro
	bgez	$6,$L757
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$6,$6,$2
$L757:
	move	$4,$17
	lw	$2,1124($16)
	sll	$3,$19,2
	addu	$2,$2,$3
	lw	$5,12($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$20,$6,16
	.set	macro
	.set	reorder

	lw	$2,1124($16)
	sll	$3,$18,2
	addu	$2,$2,$3
	lw	$5,12($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$17
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L769
	sra	$5,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$5,$3,16
$L769:
	lw	$3,gGasRatio
	li	$2,32768			# 0x00008000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L770
	addu	$2,$21,500
	.set	macro
	.set	reorder

	lw	$2,1124($16)
	#nop
	lw	$2,240($2)
	.set	noreorder
	bgez	$20,1f
	move	$3,$20
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L759
	addu	$2,$21,500
	.set	macro
	.set	reorder

$L770:
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	addu	$3,$22,1
	.set	macro
	.set	reorder

	lw	$2,1124($16)
	#nop
	lw	$2,4($2)
	lbu	$4,1090($16)
	subu	$2,$2,$3
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L771
	slt	$2,$5,$21
	.set	macro
	.set	reorder

	beq	$19,$4,$L748
	lbu	$2,1090($16)
	lw	$3,1124($16)
	sb	$0,1091($16)
	sb	$19,1090($16)
	sb	$2,1089($16)
	lbu	$2,8($3)
	.set	noreorder
	.set	nomacro
	j	$L748
	sb	$2,1092($16)
	.set	macro
	.set	reorder

$L761:
	slt	$2,$5,$21
$L771:
	beq	$2,$0,$L748
	lbu	$2,1090($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L748
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,1090($16)
	lw	$4,1124($16)
	sb	$2,1091($16)
	sb	$18,1090($16)
	sb	$3,1089($16)
	lbu	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$L748
	sb	$2,1092($16)
	.set	macro
	.set	reorder

$L759:
	slt	$2,$5,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	slt	$2,$18,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	slt	$2,$23,6553
	.set	macro
	.set	reorder

	beq	$2,$0,$L748
	lbu	$2,1090($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L748
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,1124($16)
	sb	$3,1091($16)
	sb	$18,1090($16)
	lbu	$2,8($2)
	#nop
	sb	$2,1092($16)
$L748:
	lw	$31,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Physics_AutoShift__FP8Car_tObj
	.text
	.ent	Physics_RampCarControlValues__FP8Car_tObj
Physics_RampCarControlValues__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,1120($17)
	#nop
	beq	$2,$0,$L773
	lbu	$2,1090($17)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L773
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sb	$2,1086($17)
	sb	$2,1090($17)
$L773:
	lw	$2,912($17)
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L774
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	lw	$3,172($17)
	sw	$0,1104($17)
	sb	$0,1087($17)
	sb	$2,1088($17)
	sb	$0,1091($17)
	sll	$2,$3,7
	subu	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	bgez	$2,$L775
	sw	$0,1108($17)
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L775:
	lw	$3,176($17)
	sra	$2,$2,8
	sw	$2,172($17)
	sll	$2,$3,7
	subu	$2,$2,$3
	sll	$2,$2,1
	bgez	$2,$L776
	addu	$2,$2,255
$L776:
	lw	$3,180($17)
	sra	$2,$2,8
	sw	$2,176($17)
	sll	$2,$3,7
	subu	$2,$2,$3
	sll	$2,$2,1
	bgez	$2,$L777
	addu	$2,$2,255
$L777:
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	j	$L778
	sw	$2,180($17)
	.set	macro
	.set	reorder

$L774:
	lw	$2,648($17)
	#nop
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L779
	li	$4,48			# 0x00000030
	.set	macro
	.set	reorder

	li	$4,36			# 0x00000024
$L779:
 #APP
 #NO_APP
	lbu	$2,1084($17)
	lbu	$5,1087($17)
	#nop
	subu	$3,$2,$5
	bltz	$3,$L781
	andi	$4,$4,0x00ff
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L851
	addu	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L851
	addu	$2,$5,$4
	.set	macro
	.set	reorder

$L781:
	andi	$4,$4,0x00ff
	subu	$3,$0,$3
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L851
	subu	$2,$5,$3
	.set	macro
	.set	reorder

	subu	$2,$5,$4
$L851:
	sb	$2,1087($17)
	lw	$2,648($17)
	#nop
	lw	$2,32($2)
	#nop
	beq	$2,$0,$L787
	lbu	$2,1085($17)
	lbu	$4,1088($17)
	#nop
	subu	$3,$2,$4
	.set	noreorder
	.set	nomacro
	bltz	$3,$L788
	slt	$2,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L852
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L852
	addu	$2,$4,16
	.set	macro
	.set	reorder

$L788:
	subu	$3,$0,$3
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L852
	subu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L852
	addu	$2,$4,-16
	.set	macro
	.set	reorder

$L787:
	lbu	$2,1085($17)
$L852:
	sb	$2,1088($17)
	lbu	$2,1092($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	sb	$2,1092($17)
$L795:
	lui	$2,%hi(simGlobal+4) # high
	lw	$5,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$5,513
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L824
	lui	$6,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,596($17)
	addiu	$4,$6,%lo(GameSetup_gData) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$3,988($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L797
	slt	$2,$5,520
	.set	macro
	.set	reorder

	beq	$2,$0,$L798
	lw	$4,%lo(GameSetup_gData)($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L800
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L857
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L800:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L798
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L857
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L798
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L857:
	.set	noreorder
	.set	nomacro
	j	$L797
	sb	$2,1086($17)
	.set	macro
	.set	reorder

$L798:
	lbu	$3,1086($17)
	lbu	$2,1090($17)
	#nop
	bne	$3,$2,$L802
	lw	$2,912($17)
	#nop
	bne	$2,$0,$L802
	lw	$2,632($17)
	#nop
	bne	$2,$0,$L797
	lw	$2,628($17)
	#nop
	bne	$2,$0,$L797
	lw	$2,192($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,13107
	beq	$2,$0,$L797
	lbu	$2,1085($17)
	#nop
	sltu	$2,$2,129
	bne	$2,$0,$L805
	lbu	$2,1084($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L805
	sltu	$2,$3,2
	.set	macro
	.set	reorder

	bne	$2,$0,$L805
	lw	$2,1108($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L805
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$0,1086($17)
	.set	noreorder
	.set	nomacro
	j	$L797
	sw	$2,1108($17)
	.set	macro
	.set	reorder

$L805:
	lw	$2,192($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,13107
	beq	$2,$0,$L797
	lbu	$2,1084($17)
	#nop
	sltu	$2,$2,129
	bne	$2,$0,$L797
	lbu	$2,1090($17)
	#nop
	bne	$2,$0,$L797
	lw	$2,1108($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L797
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sb	$2,1086($17)
$L802:
	sw	$0,1108($17)
$L797:
	lbu	$7,1090($17)
	lbu	$5,1086($17)
	andi	$6,$7,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$5,$6,$L824
	lui	$4,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,596($17)
	addiu	$4,$4,%lo(GameSetup_gData) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,988($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L858
	sltu	$2,$5,2
	.set	macro
	.set	reorder

	lw	$2,1120($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L810
	sltu	$2,$5,2
	.set	macro
	.set	reorder

$L858:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$2,1090($17)
	lbu	$3,1086($17)
	lw	$4,1124($17)
	.set	noreorder
	.set	nomacro
	j	$L853
	sb	$0,1091($17)
	.set	macro
	.set	reorder

$L812:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L824
	sltu	$2,$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L824
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	sb	$7,1089($17)
	lw	$2,4($3)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	move	$16,$18
	.set	macro
	.set	reorder

	sll	$2,$16,2
$L859:
	addu	$2,$3,$2
	lw	$5,240($3)
	lw	$4,384($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lw	$3,1056($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L817
	move	$18,$16
$L817:
	lw	$3,1124($17)
	#nop
	lw	$2,4($3)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L859
	sll	$2,$16,2
	.set	macro
	.set	reorder

$L816:
	lw	$2,1124($17)
	sb	$0,1091($17)
	sb	$18,1090($17)
	lbu	$2,8($2)
	.set	noreorder
	.set	nomacro
	j	$L824
	sb	$2,1092($17)
	.set	macro
	.set	reorder

$L810:
	sltu	$2,$5,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L822
	sltu	$2,$5,2
	.set	macro
	.set	reorder

	bne	$2,$0,$L822
	.set	noreorder
	.set	nomacro
	j	$L823
	sb	$3,1091($17)
	.set	macro
	.set	reorder

$L822:
	sb	$0,1091($17)
$L823:
	lbu	$2,1090($17)
	lbu	$3,1086($17)
	lw	$4,1124($17)
$L853:
	sb	$2,1089($17)
	sb	$3,1090($17)
	lbu	$2,8($4)
	#nop
	sb	$2,1092($17)
$L824:
	lw	$2,648($17)
	#nop
	lw	$2,24($2)
	#nop
	beq	$2,$0,$L825
	lw	$3,1100($17)
	lw	$5,1104($17)
	lw	$2,1124($17)
	subu	$3,$3,$5
	lw	$4,272($2)
	.set	noreorder
	.set	nomacro
	bltz	$3,$L826
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L855
	addu	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L855
	addu	$2,$5,$4
	.set	macro
	.set	reorder

$L826:
	subu	$3,$0,$3
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L855
	subu	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L855
	subu	$2,$5,$4
	.set	macro
	.set	reorder

$L825:
	lw	$2,1100($17)
$L855:
	sw	$2,1104($17)
$L778:
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L833
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L835
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L860
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L835:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L833
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L860
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L833
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L860:
	.set	noreorder
	.set	nomacro
	j	$L836
	sb	$2,1088($17)
	.set	macro
	.set	reorder

$L833:
	lw	$2,628($17)
	#nop
	bne	$2,$0,$L838
	lw	$2,632($17)
	#nop
	beq	$2,$0,$L836
$L838:
	lw	$2,1108($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sb	$2,1087($17)
	.set	noreorder
	.set	nomacro
	j	$L840
	sb	$0,1088($17)
	.set	macro
	.set	reorder

$L839:
	sb	$0,1087($17)
	sb	$2,1088($17)
$L840:
	sb	$0,1091($17)
$L836:
	lw	$3,1004($17)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L841
	sb	$0,1087($17)
$L841:
	lw	$2,AIInit_forceHumanHandBrake
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L861
	li	$5,-2078212096			# 0x84210000
	.set	macro
	.set	reorder

	lw	$2,1120($17)
	#nop
	beq	$2,$0,$L861
	lw	$3,1396($17)
	lw	$2,1364($17)
	#nop
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$8,$L856
	li	$2,-124			# 0xffffff84
	.set	macro
	.set	reorder

	li	$2,124			# 0x0000007c
$L856:
	sw	$2,1104($17)
	li	$2,1			# 0x00000001
	sb	$2,1093($17)
	li	$5,-2078212096			# 0x84210000
$L861:
	lbu	$2,1087($17)
	ori	$5,$5,0x0843
	addu	$2,$2,1
	sll	$2,$2,16
	mult	$2,$5
	li	$6,65536			# 0x00010000
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,7
	sra	$2,$2,31
	subu	$3,$3,$2
	slt	$2,$6,$3
	beq	$2,$0,$L845
	move	$3,$6
$L845:
	sw	$3,gGasRatio
	lbu	$2,1088($17)
	#nop
	addu	$2,$2,1
	sll	$2,$2,16
	mult	$2,$5
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,7
	sra	$2,$2,31
	subu	$3,$3,$2
	slt	$2,$6,$3
	beq	$2,$0,$L846
	li	$3,65536			# 0x00010000
$L846:
	lw	$2,1104($17)
	lui	$4,%hi(GameSetup_gData) # high
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sll	$2,$2,9
	sw	$2,gSteerRatio
	lw	$2,596($17)
	addiu	$4,$4,%lo(GameSetup_gData) # low
	sw	$3,gBrakeRatio
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$3,988($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L772
	lbu	$2,1090($17)
	#nop
	bne	$2,$0,$L772
	lw	$2,1108($17)
	#nop
	bne	$2,$3,$L772
	lbu	$2,1088($17)
	#nop
	addu	$2,$2,1
	sll	$2,$2,16
	mult	$2,$5
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,7
	sra	$2,$2,31
	subu	$3,$3,$2
	slt	$2,$6,$3
	beq	$2,$0,$L848
	li	$3,65536			# 0x00010000
$L848:
	sw	$3,gGasRatio
	lbu	$2,1087($17)
	#nop
	addu	$2,$2,1
	sll	$2,$2,16
	mult	$2,$5
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,7
	sra	$2,$2,31
	subu	$3,$3,$2
	slt	$2,$6,$3
	beq	$2,$0,$L849
	li	$3,65536			# 0x00010000
$L849:
	sw	$3,gBrakeRatio
$L772:
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

	.end	Physics_RampCarControlValues__FP8Car_tObj
	.text
	.ent	Physics_FixEngineRpm__FP8Car_tObj
Physics_FixEngineRpm__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
 #APP
 #NO_APP
	lw	$3,172($4)
	#nop
	bgez	$3,$L863
	addu	$3,$3,255
$L863:
	lw	$2,452($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L864
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L864:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,176($4)
	mflo	$5
	#nop
	bgez	$3,$L865
	addu	$3,$3,255
$L865:
	lw	$2,456($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L866
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L866:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,180($4)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L867
	addu	$5,$5,$7
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L867:
	lw	$2,460($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L868
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L868:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,172($4)
	mflo	$7
	#nop
	#nop
	addu	$2,$5,$7
	.set	noreorder
	.set	nomacro
	bgez	$3,$L869
	sw	$2,1048($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L869:
	lw	$2,476($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L870
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L870:
	sra	$2,$2,8
 #APP
 #NO_APP
	mult	$5,$2
	lw	$3,176($4)
	mflo	$6
	#nop
	bgez	$3,$L871
	addu	$3,$3,255
$L871:
	lw	$2,480($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L872
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L872:
	sra	$2,$2,8
 #APP
 #NO_APP
	mult	$3,$2
	lw	$5,180($4)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L873
	addu	$3,$6,$7
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L873:
	lw	$2,484($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L874
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L874:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$7
	#nop
	#nop
	addu	$3,$3,$7
 #APP
 #NO_APP
	sw	$3,1056($4)
	lw	$3,396($4)
	li	$2,2			# 0x00000002
	sw	$0,1132($4)
	sw	$0,1144($4)
	sw	$0,1156($4)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L877
	sw	$0,1160($4)
	.set	macro
	.set	reorder

	sw	$0,396($4)
$L877:
	j	$31
	.end	Physics_FixEngineRpm__FP8Car_tObj
	.text
	.ent	Physics_ResetCar__FP8Car_tObj
Physics_ResetCar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,648($4)
	#nop
	lw	$2,8($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L879
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sb	$2,1086($4)
	.set	noreorder
	.set	nomacro
	j	$L880
	sb	$2,1090($4)
	.set	macro
	.set	reorder

$L879:
	sb	$3,1086($4)
	sb	$3,1090($4)
$L880:
	move	$3,$0
	sw	$0,1024($4)
	sw	$0,1028($4)
	sw	$0,1032($4)
	sw	$0,1012($4)
	sw	$0,1016($4)
	sw	$0,1020($4)
	sw	$0,1048($4)
	sw	$0,1052($4)
	sw	$0,1056($4)
	sw	$0,1060($4)
	sw	$0,1064($4)
	sw	$0,1068($4)
	sw	$0,1132($4)
	sw	$0,1144($4)
	sw	$0,1156($4)
	sw	$0,1160($4)
	sw	$0,1004($4)
	sw	$0,628($4)
	sw	$0,1108($4)
$L884:
	sw	$0,684($4)
	sw	$0,688($4)
	addu	$3,$3,1
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L884
	addu	$4,$4,48
	.set	macro
	.set	reorder

	j	$31
	.end	Physics_ResetCar__FP8Car_tObj
	.text
	.ent	Physics_StopCar__FP8Car_tObj
Physics_StopCar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,172($4)
	#nop
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L888
	addu	$2,$2,255
$L888:
	lw	$3,176($4)
	sra	$2,$2,8
	sw	$2,172($4)
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	bgez	$2,$L889
	addu	$2,$2,255
$L889:
	lw	$3,180($4)
	sra	$2,$2,8
	sw	$2,176($4)
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$3,$2,$3
	bgez	$3,$L890
	addu	$3,$3,255
$L890:
	lw	$2,300($4)
	sra	$3,$3,8
	slt	$2,$2,13107
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L894
	sw	$3,180($4)
	.set	macro
	.set	reorder

	lw	$3,280($4)
	#nop
	bgez	$3,$L892
	addu	$3,$3,255
$L892:
	sra	$3,$3,8
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	sw	$2,280($4)
$L894:
	j	$31
	.end	Physics_StopCar__FP8Car_tObj
	.text
	.ent	Physics_TestForBarrierCollision__FP8Car_tObj
Physics_TestForBarrierCollision__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_DoBarrierCheck__FP8Car_tObj
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	beq	$17,$0,$L895
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L897
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

$L897:
	sw	$17,1004($16)
$L895:
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

	.end	Physics_TestForBarrierCollision__FP8Car_tObj
	.text
	.ent	Physics_CalculateRoadGripModifiers__FP8Car_tObj
Physics_CalculateRoadGripModifiers__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	move	$8,$0
	move	$9,$8
	move	$10,$8
	move	$11,$8
	move	$5,$8
	lui	$2,%hi(roadSurfaceIndex) # high
	addiu	$12,$2,%lo(roadSurfaceIndex) # low
	lui	$2,%hi(roadSurfaceFrictionCoeff) # high
	addiu	$7,$2,%lo(roadSurfaceFrictionCoeff) # low
	move	$6,$16
	sw	$31,20($sp)
$L902:
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L901
	sra	$2,$8,1
	.set	macro
	.set	reorder

	lw	$2,648($16)
	lw	$3,696($6)
	lw	$4,56($2)
	andi	$3,$3,0x000f
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$3,$3,$2
	addu	$3,$3,$12
	lw	$2,slippery
	lbu	$3,0($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L913
	slt	$2,$5,2
	.set	macro
	.set	reorder

	addu	$3,$3,1
$L913:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L905
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$7
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L906
	addu	$8,$8,$2
	.set	macro
	.set	reorder

$L905:
	addu	$2,$2,$7
	lw	$2,0($2)
	#nop
	addu	$9,$9,$2
$L906:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L908
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L907
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L908:
	sll	$2,$3,2
	addu	$2,$2,$7
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L909
	addu	$10,$10,$2
	.set	macro
	.set	reorder

$L907:
	addu	$2,$2,$7
	lw	$2,0($2)
	#nop
	addu	$11,$11,$2
$L909:
	addu	$6,$6,48
	.set	noreorder
	.set	nomacro
	j	$L902
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L901:
	sra	$4,$9,1
	sra	$3,$10,1
	sw	$3,leftMult
	sra	$3,$11,1
	sw	$2,frontMult
	addu	$2,$2,$4
	sw	$3,rightMult
	lw	$3,372($16)
	sra	$2,$2,1
	sw	$4,rearMult
	lw	$4,1056($16)
	addu	$2,$2,$3
	sw	$2,roadMult
	li	$2,327680			# 0x00050000
	slt	$2,$2,$4
	beq	$2,$0,$L899
	lw	$2,1124($16)
	#nop
	lw	$5,280($2)
	jal	fixedmult
	lw	$4,1056($16)
	lw	$5,1124($16)
	lw	$3,frontMult
	lw	$5,284($5)
	addu	$3,$3,$2
	sw	$3,frontMult
	jal	fixedmult
	lw	$3,rearMult
	#nop
	addu	$3,$3,$2
	sw	$3,rearMult
$L899:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Physics_CalculateRoadGripModifiers__FP8Car_tObj
	.text
	.ent	Physics_CalculateCarAcceleration__FP8Car_tObj
Physics_CalculateCarAcceleration__FP8Car_tObj:
	.frame	$sp,120,$31		# vars= 64, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$17,84($sp)
	move	$17,$4
	lui	$2,%hi($LC0) # high
	sw	$31,116($sp)
	sw	$fp,112($sp)
	sw	$23,108($sp)
	sw	$22,104($sp)
	sw	$21,100($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$18,88($sp)
	sw	$16,80($sp)
	addiu	$9,$2,%lo($LC0)
	lw	$6,0($9)
	lw	$7,4($9)
	lw	$8,8($9)
	sw	$6,16($sp)
	sw	$7,20($sp)
	sw	$8,24($sp)
	lw	$6,12($9)
	lw	$7,16($9)
	lw	$8,20($9)
	sw	$6,28($sp)
	sw	$7,32($sp)
	sw	$8,36($sp)
	lw	$6,24($9)
	lw	$7,28($9)
	sw	$6,40($sp)
	sw	$7,44($sp)
	lui	$2,%hi($LC1) # high
	addiu	$9,$2,%lo($LC1)
	lw	$6,0($9)
	lw	$7,4($9)
	lw	$8,8($9)
	sw	$6,48($sp)
	sw	$7,52($sp)
	sw	$8,56($sp)
	lw	$6,12($9)
	lw	$7,16($9)
	lw	$8,20($9)
	sw	$6,60($sp)
	sw	$7,64($sp)
	sw	$8,68($sp)
	lw	$6,24($9)
	lw	$7,28($9)
	sw	$6,72($sp)
	sw	$7,76($sp)
	lw	$2,1124($17)
	#nop
	lw	$5,240($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L915
	move	$20,$0
	.set	macro
	.set	reorder

	addu	$5,$5,7
$L915:
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	move	$23,$0
	lw	$4,540($17)
	lw	$3,556($17)
	sra	$fp,$5,3
	addu	$4,$4,$3
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	.set	noreorder
	.set	nomacro
	bgez	$4,$L917
	andi	$3,$2,0xffff
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L917:
	sra	$2,$4,8
	sltu	$2,$3,$2
	beq	$2,$0,$L916
	li	$23,1			# 0x00000001
$L916:
	lw	$18,1124($17)
	lw	$3,1128($17)
	lw	$2,240($18)
	sw	$0,exceedRedline
	addu	$2,$2,500
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L918
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,exceedRedline
$L918:
	lw	$2,648($17)
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L919
	li	$22,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,1124($17)
	#nop
	lw	$2,280($3)
	lw	$3,284($3)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	li	$3,65536			# 0x00010000
	addu	$22,$2,$3
$L919:
	lw	$4,1056($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$22
	.set	macro
	.set	reorder

	move	$22,$2
	.set	noreorder
	.set	nomacro
	bgez	$22,$L921
	move	$5,$22
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$5,$22,$2
$L921:
	sra	$5,$5,16
	mult	$5,$5
	mflo	$3
	#nop
	#nop
	mult	$3,$5
	lw	$4,448($18)
	mflo	$5
	#nop
	jal	fixedmult
	move	$22,$2
	lbu	$3,1090($17)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L925
	lw	$2,powerControl
	#nop
	bne	$2,$0,$L924
$L925:
	lw	$16,240($18)
	lw	$5,gGasRatio
	addu	$16,$16,250
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	bne	$2,$0,$L926
	lw	$2,240($18)
	.set	noreorder
	.set	nomacro
	j	$L928
	addu	$16,$2,250
	.set	macro
	.set	reorder

$L926:
	lw	$4,240($18)
	lw	$5,gGasRatio
	.set	noreorder
	.set	nomacro
	j	$L1028
	addu	$4,$4,250
	.set	macro
	.set	reorder

$L924:
	lw	$16,240($18)
	lw	$5,gGasRatio
	addu	$16,$16,100
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	bne	$2,$0,$L929
	lw	$2,240($18)
	.set	noreorder
	.set	nomacro
	j	$L928
	addu	$16,$2,100
	.set	macro
	.set	reorder

$L929:
	lw	$4,240($18)
	lw	$5,gGasRatio
	addu	$4,$4,100
$L1028:
	jal	fixedmult
	move	$16,$2
$L928:
	lw	$2,1128($17)
	lw	$3,240($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L931
	addu	$2,$3,50
	.set	macro
	.set	reorder

	lbu	$3,1090($17)
	sw	$2,1128($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L933
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,powerControl
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
$L932:
$L933:
	sw	$2,636($17)
$L931:
	lw	$2,636($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L935
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,1090($17)
	#nop
	beq	$3,$2,$L937
	lw	$2,powerControl
	#nop
	bne	$2,$0,$L936
$L937:
	lw	$2,240($18)
	.set	noreorder
	.set	nomacro
	j	$L938
	addu	$2,$2,-800
	.set	macro
	.set	reorder

$L936:
	lw	$2,240($18)
	#nop
	addu	$2,$2,-400
$L938:
	move	$3,$2
 #APP
 #NO_APP
	slt	$2,$3,$16
	bne	$2,$0,$L939
	move	$3,$16
$L939:
	move	$16,$3
 #APP
 #NO_APP
	lw	$2,636($17)
	#nop
	addu	$2,$2,-1
	sw	$2,636($17)
$L935:
	lbu	$2,1090($17)
	li	$5,1			# 0x00000001
	beq	$2,$5,$L941
	lbu	$2,1092($17)
	#nop
	bne	$2,$0,$L941
	lw	$2,powerControl
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L940
	lui	$4,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L941:
	beq	$23,$0,$L942
 #APP
 #NO_APP
	lw	$2,1128($17)
	#nop
	addu	$2,$2,-100
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L1033
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L942:
	lw	$3,1128($17)
	#nop
	slt	$2,$3,$16
	beq	$2,$0,$L945
	lbu	$2,1092($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1027
	addu	$4,$3,250
	.set	macro
	.set	reorder

	move	$3,$16
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L960
	sw	$4,1128($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L960
	move	$3,$4
	.set	macro
	.set	reorder

$L945:
	lbu	$2,1092($17)
	#nop
	beq	$2,$0,$L948
$L1027:
	lbu	$3,1089($17)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L948
	lbu	$2,1091($17)
	#nop
	beq	$2,$0,$L949
	lbu	$2,1088($17)
	#nop
	sltu	$2,$2,65
	bne	$2,$0,$L950
	lbu	$2,1086($17)
	#nop
	sll	$2,$2,2
	addu	$3,$sp,$2
	lw	$2,1128($17)
	lw	$3,48($3)
	.set	noreorder
	.set	nomacro
	j	$L1034
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L950:
	lbu	$2,1086($17)
	#nop
	sll	$2,$2,2
	addu	$3,$sp,$2
	lw	$2,1128($17)
	lw	$3,16($3)
	#nop
	addu	$2,$2,$3
$L1034:
	sw	$2,1128($17)
	lw	$2,240($18)
 #APP
 #NO_APP
	lw	$4,1128($17)
	move	$3,$2
	slt	$2,$3,$4
	bne	$2,$0,$L960
	.set	noreorder
	.set	nomacro
	j	$L960
	move	$3,$4
	.set	macro
	.set	reorder

$L949:
	lbu	$2,1090($17)
	#nop
	sltu	$2,$2,4
	bne	$2,$0,$L954
	lw	$2,1128($17)
	.set	noreorder
	.set	nomacro
	j	$L1029
	addu	$2,$2,-200
	.set	macro
	.set	reorder

$L954:
	lw	$2,1128($17)
	#nop
	addu	$2,$2,-100
$L1029:
	sw	$2,1128($17)
	lw	$2,1128($17)
$L1033:
	#nop
	bgez	$2,$L956
	move	$2,$0
$L956:
	.set	noreorder
	.set	nomacro
	j	$L959
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L948:
	lw	$3,1128($17)
	#nop
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L959
	addu	$4,$3,-200
	.set	macro
	.set	reorder

	move	$3,$16
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L960
	sw	$4,1128($17)
	.set	macro
	.set	reorder

	move	$3,$4
$L960:
	sw	$3,1128($17)
$L959:
	sw	$0,1136($17)
	.set	noreorder
	.set	nomacro
	j	$L961
	sw	$0,1132($17)
	.set	macro
	.set	reorder

$L940:
	lw	$2,596($17)
	addiu	$4,$4,%lo(GameSetup_gData) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,988($2)
	#nop
	beq	$2,$5,$L963
	lw	$2,1120($17)
	#nop
	beq	$2,$0,$L962
$L963:
	.set	noreorder
	.set	nomacro
	jal	Physics_AutoShift__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L962:
	lbu	$2,1092($17)
	#nop
	beq	$2,$0,$L964
	lbu	$2,1091($17)
	#nop
	bne	$2,$0,$L964
	lbu	$2,1089($17)
	j	$L1031
$L964:
	lbu	$2,1090($17)
$L1031:
	lw	$4,1056($17)
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$5,12($2)
	jal	fixedmult
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L966
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L966:
	lw	$2,exceedRedline
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L968
	sra	$21,$3,16
	.set	macro
	.set	reorder

	lw	$2,636($17)
	#nop
	blez	$2,$L967
$L968:
	lw	$2,240($18)
	#nop
	bgez	$2,$L969
	addu	$2,$2,255
$L969:
	sra	$2,$2,8
	sll	$2,$2,2
	addu	$2,$18,$2
	lbu	$3,1090($17)
	lw	$4,76($2)
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$5,416($3)
	jal	fixedmult
	.set	noreorder
	.set	nomacro
	j	$L970
	sll	$20,$2,1
	.set	macro
	.set	reorder

$L967:
	lw	$5,1128($17)
	#nop
	bgez	$5,$L971
	addu	$5,$5,255
$L971:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Physics_GetTorque__FP8Car_tObji
	sra	$5,$5,8
	.set	macro
	.set	reorder

	lbu	$3,1090($17)
	#nop
	sll	$3,$3,2
	addu	$3,$18,$3
	lw	$5,416($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	move	$20,$2
$L970:
	subu	$4,$16,$21
	.set	noreorder
	bgez	$4,1f
	move	$2,$4
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,125
	beq	$2,$0,$L972
	lw	$2,240($18)
	#nop
	addu	$2,$2,-300
	slt	$2,$16,$2
	beq	$2,$0,$L972
	move	$4,$0
$L972:
	lw	$2,1128($17)
	#nop
	subu	$19,$2,$21
	slt	$2,$19,251
	bne	$2,$0,$L975
	lbu	$2,1092($17)
	#nop
	bne	$2,$0,$L975
	lbu	$2,1090($17)
	#nop
	sltu	$2,$2,5
	bne	$2,$0,$L974
$L975:
	lbu	$2,1090($17)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L976
	lw	$2,1056($17)
	#nop
	slt	$2,$2,-6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L976
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$3,gGasRatio
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L974
$L976:
	lbu	$2,1090($17)
	#nop
	bne	$2,$0,$L977
	lw	$2,1056($17)
	#nop
	slt	$2,$2,6554
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L977
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$3,gGasRatio
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L974
$L977:
	lw	$3,1132($17)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L973
$L974:
	lw	$2,636($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L973
	slt	$2,$16,2000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L979
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$2,1084($17)
	#nop
	sltu	$2,$2,64
	bne	$2,$0,$L979
	bne	$23,$0,$L979
	lw	$2,648($17)
	#nop
	lw	$3,0($2)
	li	$2,19			# 0x00000013
	bne	$3,$2,$L978
	lbu	$2,1090($17)
	#nop
	sltu	$2,$2,3
	bne	$2,$0,$L978
$L979:
	.set	noreorder
	.set	nomacro
	j	$L980
	li	$4,200			# 0x000000c8
	.set	macro
	.set	reorder

$L978:
	lbu	$3,1090($17)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L982
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L981
	sltu	$2,$3,3
	.set	macro
	.set	reorder

$L982:
	.set	noreorder
	.set	nomacro
	j	$L980
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

$L981:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1035
	slt	$2,$fp,$19
	.set	macro
	.set	reorder

	li	$4,50			# 0x00000032
$L980:
	slt	$2,$fp,$19
$L1035:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L985
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,1132($17)
$L985:
	lw	$3,1128($17)
	slt	$2,$4,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L986
	subu	$2,$3,$4
	.set	macro
	.set	reorder

	subu	$2,$3,$19
$L986:
	.set	noreorder
	.set	nomacro
	j	$L988
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L973:
	bgez	$4,$L989
	lw	$5,288($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$20
	.set	macro
	.set	reorder

	lui	$3,%hi(gravity_ch+8) # high
	lw	$3,%lo(gravity_ch+8)($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L992
	subu	$20,$0,$2
	.set	macro
	.set	reorder

	lbu	$3,1090($17)
	#nop
	sltu	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1036
	lui	$2,%hi(gravity_ch+8) # high
	.set	macro
	.set	reorder

	bgez	$20,$L1036
	sltu	$2,$3,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1037
	srl	$2,$20,31
	.set	macro
	.set	reorder

$L992:
	lui	$2,%hi(gravity_ch+8) # high
$L1036:
	lw	$2,%lo(gravity_ch+8)($2)
	#nop
	bgez	$2,$L990
	lbu	$2,1090($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1038
	sll	$2,$2,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$20,$L990
	srl	$2,$20,31
	.set	macro
	.set	reorder

$L1037:
	addu	$2,$20,$2
	sra	$20,$2,1
$L990:
	lbu	$2,1090($17)
	#nop
	sll	$2,$2,2
$L1038:
	addu	$2,$18,$2
	lw	$4,384($2)
	li	$5,671088640			# 0x28000000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,3
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L993
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L993:
	lbu	$2,1090($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L994
	sra	$3,$3,16
	.set	macro
	.set	reorder

	subu	$4,$0,$19
	slt	$2,$3,$4
	beq	$2,$0,$L995
	move	$3,$4
$L995:
	lw	$2,1128($17)
	.set	noreorder
	.set	nomacro
	j	$L998
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L994:
	lw	$4,1128($17)
	subu	$2,$0,$19
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L998
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	subu	$2,$4,$19
$L998:
	sw	$2,1128($17)
	lw	$2,exceedRedline
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L988
	move	$3,$16
	.set	macro
	.set	reorder

	lw	$4,1128($17)
	#nop
	slt	$2,$3,$4
	beq	$2,$0,$L1000
	move	$3,$4
$L1000:
	.set	noreorder
	.set	nomacro
	j	$L988
	sw	$3,1128($17)
	.set	macro
	.set	reorder

$L989:
	bne	$4,$0,$L1002
	sw	$21,1128($17)
	.set	noreorder
	.set	nomacro
	j	$L988
	move	$20,$22
	.set	macro
	.set	reorder

$L1002:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L1004
	slt	$2,$19,201
	.set	macro
	.set	reorder

	lw	$2,1128($17)
	move	$20,$0
	addu	$2,$2,-100
	.set	noreorder
	.set	nomacro
	j	$L1005
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L1004:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1006
	slt	$2,$19,-200
	.set	macro
	.set	reorder

	lw	$2,1128($17)
	#nop
	addu	$2,$2,-200
	.set	noreorder
	.set	nomacro
	j	$L1007
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L1006:
	beq	$2,$0,$L1008
	lw	$2,1128($17)
	#nop
	addu	$2,$2,200
	.set	noreorder
	.set	nomacro
	j	$L1007
	sw	$2,1128($17)
	.set	macro
	.set	reorder

$L1008:
	sw	$21,1128($17)
$L1007:
 #APP
 #NO_APP
	lw	$5,gGasRatio
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$20
	.set	macro
	.set	reorder

	move	$20,$2
$L1005:
	lw	$3,1128($17)
	move	$4,$16
 #APP
 #NO_APP
	slt	$2,$4,$3
	bne	$2,$0,$L1010
	move	$4,$3
$L1010:
	sw	$4,1128($17)
 #APP
 #NO_APP
	li	$4,65536			# 0x00010000
	lui	$2,%hi(GameSetup_gData+56) # high
	lw	$3,1144($17)
	lw	$2,%lo(GameSetup_gData+56)($2)
	bgez	$3,1f
	subu	$3,$0,$3
1:
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1011
	addu	$3,$3,$4
	.set	macro
	.set	reorder

	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	beq	$2,$0,$L1013
	.set	noreorder
	.set	nomacro
	j	$L1013
	li	$3,196608			# 0x00030000
	.set	macro
	.set	reorder

$L1011:
	li	$2,131072			# 0x00020000
	slt	$2,$2,$3
	beq	$2,$0,$L1013
	li	$3,131072			# 0x00020000
$L1013:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bgez	$20,$L1015
	move	$4,$20
	.set	macro
	.set	reorder

	addu	$4,$20,255
$L1015:
	move	$2,$3
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1016
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1016:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$20
$L988:
	lw	$2,1128($17)
	#nop
	bgez	$2,$L961
	lw	$2,1056($17)
	#nop
	sll	$2,$2,5
	.set	noreorder
	.set	nomacro
	blez	$20,$L1019
	subu	$3,$0,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L1019
	subu	$2,$20,$3
	.set	macro
	.set	reorder

	bgtz	$2,$L961
$L1019:
	bgez	$20,$L1020
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1020
	subu	$2,$20,$3
	.set	macro
	.set	reorder

	bltz	$2,$L961
$L1020:
	move	$20,$3
	sw	$0,1128($17)
$L961:
	lw	$2,648($17)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-12
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1039
	subu	$2,$20,$22
	.set	macro
	.set	reorder

	lw	$2,slippery
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1021
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,1090($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1039
	subu	$2,$20,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$20,$L1021
	sll	$2,$20,1
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	sra	$20,$2,2
$L1021:
	subu	$2,$20,$22
$L1039:
	lw	$31,116($sp)
	lw	$fp,112($sp)
	lw	$23,108($sp)
	lw	$22,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Physics_CalculateCarAcceleration__FP8Car_tObj
	.text
	.ent	Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	lw	$2,40($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1041
	move	$8,$4
	.set	macro
	.set	reorder

	lw	$2,1156($8)
	lw	$3,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1042
	sw	$2,44($16)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1042:
	lw	$2,frontMult
	.set	noreorder
	.set	nomacro
	j	$L1059
	sra	$3,$3,8
	.set	macro
	.set	reorder

$L1041:
	lw	$2,1160($8)
	lw	$3,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1045
	sw	$2,44($16)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1045:
	lw	$2,rearMult
	sra	$3,$3,8
$L1059:
	bgez	$2,$L1046
	addu	$2,$2,255
$L1046:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$6
	#nop
	lw	$2,16($16)
	lw	$3,24($16)
	.set	noreorder
	bgez	$2,1f
	move	$7,$2
	subu	$7,$0,$7
1:
	.set	reorder
	.set	noreorder
	bgez	$3,1f
	move	$4,$3
	subu	$4,$0,$4
1:
	.set	reorder
	slt	$2,$4,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1047
	sra	$2,$4,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1048
	addu	$5,$7,$2
	.set	macro
	.set	reorder

$L1047:
	sra	$2,$7,2
	addu	$5,$4,$2
$L1048:
	lw	$2,slippery
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1049
	lui	$3,%hi(gripLossTableWet) # high
	.set	macro
	.set	reorder

	lw	$2,648($8)
	#nop
	lw	$2,56($2)
	.set	noreorder
	.set	nomacro
	j	$L1057
	addiu	$3,$3,%lo(gripLossTableWet) # low
	.set	macro
	.set	reorder

$L1049:
	lw	$2,648($8)
	lui	$3,%hi(gripLossTable) # high
	lw	$2,56($2)
	addiu	$3,$3,%lo(gripLossTable) # low
$L1057:
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	div	$2,$6,$2
	subu	$4,$6,$2
	slt	$2,$6,$5
	beq	$2,$0,$L1051
	lw	$2,44($16)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	subu	$2,$5,$6
	addu	$3,$3,$2
	sra	$3,$3,2
	.set	noreorder
	.set	nomacro
	j	$L1052
	sw	$3,44($16)
	.set	macro
	.set	reorder

$L1051:
	sw	$0,44($16)
$L1052:
	lw	$2,648($8)
	#nop
	lw	$3,56($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1053
	li	$6,655360			# 0x000a0000
	.set	macro
	.set	reorder

	li	$6,524288			# 0x00080000
$L1053:
	lw	$3,44($16)
	move	$2,$6
 #APP
 #NO_APP
	slt	$2,$2,$3
	bne	$2,$0,$L1054
	move	$6,$3
$L1054:
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,257
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	sw	$6,44($16)
	.set	macro
	.set	reorder

	jal	fixeddiv
	sra	$7,$2,8
$L1055:
	lw	$2,16($16)
	#nop
	mult	$2,$7
	mflo	$6
	#nop
	lw	$2,24($16)
	#nop
	mult	$2,$7
	sra	$2,$6,8
	sw	$2,28($16)
	mflo	$3
	#nop
	#nop
	sra	$2,$3,8
	sw	$2,36($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	.text
	.ent	Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$2,28($16)
	lw	$3,36($16)
	.set	noreorder
	bgez	$2,1f
	move	$5,$2
	subu	$5,$0,$5
1:
	.set	reorder
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1061
	move	$19,$4
	.set	macro
	.set	reorder

	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L1062
	addu	$20,$5,$2
	.set	macro
	.set	reorder

$L1061:
	sra	$2,$5,2
	addu	$20,$3,$2
$L1062:
	lw	$2,40($16)
	lw	$4,4($16)
	beq	$2,$0,$L1063
	lw	$2,1156($19)
	.set	noreorder
	.set	nomacro
	j	$L1064
	sw	$2,44($16)
	.set	macro
	.set	reorder

$L1063:
	lw	$2,36($16)
	lw	$3,1160($19)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1067
	sw	$3,44($16)
	.set	macro
	.set	reorder

	lbu	$2,1087($19)
	#nop
	sltu	$2,$2,129
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1096
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1067:
	lw	$3,1132($19)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1065
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1096:
	.set	noreorder
	.set	nomacro
	j	$L1064
	sw	$2,1132($19)
	.set	macro
	.set	reorder

$L1065:
	sw	$0,1132($19)
$L1064:
	lw	$2,slippery
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1069
	lui	$3,%hi(gripLossTableWet) # high
	.set	macro
	.set	reorder

	lw	$2,648($19)
	#nop
	lw	$2,56($2)
	.set	noreorder
	.set	nomacro
	j	$L1093
	addiu	$3,$3,%lo(gripLossTableWet) # low
	.set	macro
	.set	reorder

$L1069:
	lw	$2,648($19)
	lui	$3,%hi(gripLossTable) # high
	lw	$2,56($2)
	addiu	$3,$3,%lo(gripLossTable) # low
$L1093:
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$5,0($2)
	slt	$2,$4,$20
	beq	$2,$0,$L1071
	lw	$2,648($19)
	#nop
	lw	$2,48($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1072
	subu	$17,$20,$4
	.set	macro
	.set	reorder

	lw	$2,40($16)
	#nop
	bne	$2,$0,$L1072
	lw	$2,1144($19)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,9830
	beq	$2,$0,$L1072
	.set	noreorder
	.set	nomacro
	jal	rdiv
	move	$5,$20
	.set	macro
	.set	reorder

	sw	$0,44($16)
	lbu	$3,1090($19)
	#nop
	sltu	$3,$3,3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1073
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$4,28($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	sw	$2,28($16)
$L1073:
	lw	$4,36($16)
	.set	noreorder
	.set	nomacro
	j	$L1094
	move	$5,$18
	.set	macro
	.set	reorder

$L1072:
 #APP
 #NO_APP
	div	$2,$17,$5
 #APP
 #NO_APP
	div	$5,$4,$5
	move	$3,$2
	slt	$2,$3,$5
	bne	$2,$0,$L1075
	move	$3,$5
$L1075:
	subu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	jal	rdiv
	move	$5,$20
	.set	macro
	.set	reorder

	lw	$3,648($19)
	move	$18,$2
	lw	$3,56($3)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L1076
	lw	$3,44($16)
	#nop
	sll	$2,$3,4
	subu	$2,$2,$3
	addu	$2,$2,$17
	bgez	$2,$L1077
	addu	$2,$2,15
$L1077:
	.set	noreorder
	.set	nomacro
	j	$L1095
	sra	$2,$2,4
	.set	macro
	.set	reorder

$L1076:
	lw	$3,44($16)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	addu	$2,$2,$17
	bgez	$2,$L1079
	addu	$2,$2,3
$L1079:
	sra	$2,$2,2
$L1095:
	sw	$2,44($16)
	lw	$4,28($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,36($16)
	move	$5,$18
	sw	$2,28($16)
$L1094:
	jal	fixedmult
	.set	noreorder
	.set	nomacro
	j	$L1080
	sw	$2,36($16)
	.set	macro
	.set	reorder

$L1071:
	sw	$0,44($16)
$L1080:
	lw	$2,40($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1081
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,1132($19)
	#nop
	bne	$3,$2,$L1081
	lw	$2,648($19)
	#nop
	lw	$2,48($2)
	#nop
	bne	$2,$0,$L1081
	sw	$20,44($16)
	lbu	$2,1090($19)
	#nop
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1081
	sll	$2,$20,2
	.set	macro
	.set	reorder

	sw	$2,44($16)
$L1081:
	lw	$2,648($19)
	#nop
	lw	$3,56($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1084
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L1085
	li	$4,524288			# 0x00080000
	.set	macro
	.set	reorder

$L1084:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1087
	li	$4,262144			# 0x00040000
	.set	macro
	.set	reorder

$L1085:
	lw	$3,44($16)
	move	$2,$4
 #APP
 #NO_APP
	slt	$2,$2,$3
	bne	$2,$0,$L1089
	move	$4,$3
$L1089:
	sw	$4,44($16)
$L1087:
	lw	$2,648($19)
	#nop
	lw	$2,48($2)
	#nop
	beq	$2,$0,$L1060
	lw	$3,44($16)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1091
	addu	$2,$2,3
$L1091:
	sra	$2,$2,2
	sw	$2,44($16)
$L1060:
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

	.end	Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	.text
	.ent	Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$16,24($sp)
	lw	$2,12($17)
	lw	$19,4($17)
	move	$16,$0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1098
	sw	$0,44($17)
	.set	macro
	.set	reorder

	addu	$2,$17,24
	sw	$2,16($sp)
	lw	$4,16($17)
	lw	$5,24($17)
	lw	$6,12($17)
	.set	noreorder
	.set	nomacro
	jal	Math_ResolveRotatedVector__FiiiPiT3
	addu	$7,$17,16
	.set	macro
	.set	reorder

$L1098:
	lw	$4,0($17)
	#nop
	bgez	$4,$L1165
	lw	$3,24($17)
	#nop
	bgez	$3,$L1165
	lw	$2,gGasRatio
	#nop
	slt	$2,$2,16385
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	lbu	$2,1090($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1104
	slt	$2,$3,$4
	.set	macro
	.set	reorder

$L1166:
	beq	$2,$0,$L1107
	.set	noreorder
	.set	nomacro
	j	$L1107
	move	$3,$4
	.set	macro
	.set	reorder

$L1165:
	blez	$4,$L1104
	lw	$3,24($17)
	#nop
	blez	$3,$L1104
	lw	$2,gGasRatio
	#nop
	slt	$2,$2,16385
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1167
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	lbu	$2,1090($18)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1104
	slt	$2,$3,$4
	.set	macro
	.set	reorder

$L1167:
	bne	$2,$0,$L1107
	move	$3,$4
$L1107:
	sw	$3,0($17)
	li	$16,1			# 0x00000001
$L1104:
	lw	$2,1124($18)
	lw	$4,0($17)
	lw	$5,276($2)
	jal	fixedmult
	move	$3,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L1110
	sw	$3,0($17)
	.set	macro
	.set	reorder

	lw	$2,4($17)
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	bne	$2,$0,$L1109
$L1110:
	lbu	$2,1093($18)
	#nop
	beq	$2,$0,$L1121
	lw	$2,40($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1121
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$3,1056($18)
	#nop
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	beq	$2,$0,$L1121
$L1109:
	lbu	$2,1093($18)
	#nop
	bne	$2,$0,$L1112
	lw	$2,648($18)
	#nop
	lw	$2,72($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1113
	li	$2,1638400			# 0x00190000
	.set	macro
	.set	reorder

	lw	$3,1056($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L1113
	lbu	$2,1088($18)
	#nop
	sltu	$2,$2,236
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1113
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	bne	$2,$0,$L1112
	lw	$2,1132($18)
	#nop
	bne	$2,$0,$L1112
$L1113:
	lw	$4,0($17)
	lw	$3,4($17)
	#nop
	slt	$2,$3,$4
	bne	$2,$0,$L1158
	subu	$3,$0,$3
	slt	$2,$4,$3
	beq	$2,$0,$L1116
$L1158:
	sw	$3,0($17)
$L1116:
	lw	$2,648($18)
	#nop
	lw	$2,72($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1121
	li	$2,1572864			# 0x00180000
	.set	macro
	.set	reorder

	lw	$3,1056($18)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1121
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1119
	li	$2,524288			# 0x00080000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1121
	sw	$2,44($17)
	.set	macro
	.set	reorder

$L1119:
	.set	noreorder
	.set	nomacro
	j	$L1121
	sw	$0,44($17)
	.set	macro
	.set	reorder

$L1112:
	lw	$2,40($17)
	#nop
	beq	$2,$0,$L1122
	lw	$2,1140($18)
	.set	noreorder
	.set	nomacro
	j	$L1159
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L1122:
	lw	$2,1140($18)
	#nop
	addu	$2,$2,2
$L1159:
	sw	$2,1140($18)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$2,40($17)
	#nop
	beq	$2,$0,$L1155
	j	$L1160
$L1121:
	lw	$5,24($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1126
	subu	$5,$0,$5
	.set	macro
	.set	reorder

	srl	$2,$5,31
	addu	$5,$5,$2
	lw	$4,16($17)
	.set	noreorder
	.set	nomacro
	jal	fixedatan
	sra	$5,$5,1
	.set	macro
	.set	reorder

	lw	$3,24($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L1127
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,16($17)
	#nop
	blez	$2,$L1128
	.set	noreorder
	.set	nomacro
	j	$L1161
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

$L1128:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1127
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

$L1161:
	subu	$16,$2,$16
$L1127:
	.set	noreorder
	.set	nomacro
	j	$L1131
	sll	$16,$16,8
	.set	macro
	.set	reorder

$L1126:
	move	$16,$0
$L1131:
	lw	$2,40($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1132
	li	$4,1048576			# 0x00100000
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$16,1f
	move	$3,$16
	subu	$3,$0,$3
1:
	.set	reorder
	move	$2,$4
	slt	$2,$2,$3
	bne	$2,$0,$L1133
	move	$4,$3
$L1133:
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
	li	$5,5461			# 0x00001555
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L1135
	move	$5,$2
	.set	macro
	.set	reorder

	subu	$5,$0,$5
$L1135:
	li	$4,2031616			# 0x001f0000
	lui	$2,%hi(gravity_ch) # high
	ori	$4,$4,0xffff
	sw	$5,28($17)
	lw	$2,%lo(gravity_ch)($2)
	lw	$6,16($17)
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	addu	$2,$5,$2
	sw	$2,28($17)
	lw	$2,24($17)
	.set	noreorder
	bgez	$6,1f
	move	$3,$6
	subu	$3,$0,$3
1:
	.set	reorder
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$3,$3,$2
	slt	$4,$4,$3
	bne	$4,$0,$L1142
	blez	$6,$L1137
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	move	$3,$2
	slt	$2,$3,$6
	bne	$2,$0,$L1151
	.set	noreorder
	.set	nomacro
	j	$L1151
	move	$3,$6
	.set	macro
	.set	reorder

$L1137:
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	subu	$3,$0,$2
	slt	$2,$3,$6
	beq	$2,$0,$L1151
	.set	noreorder
	.set	nomacro
	j	$L1151
	move	$3,$6
	.set	macro
	.set	reorder

$L1132:
	.set	noreorder
	bgez	$16,1f
	move	$3,$16
	subu	$3,$0,$3
1:
	.set	reorder
	li	$5,32768			# 0x00008000
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1168
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	move	$3,$5
$L1168:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1143
	li	$4,131072			# 0x00020000
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$16,1f
	move	$4,$16
	subu	$4,$0,$4
1:
	.set	reorder
	slt	$2,$4,$5
	beq	$2,$0,$L1146
	li	$4,32768			# 0x00008000
$L1143:
$L1146:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1147
	sra	$5,$3,1
	.set	macro
	.set	reorder

	subu	$5,$0,$5
$L1147:
	lui	$2,%hi(gravity_ch) # high
	lw	$2,%lo(gravity_ch)($2)
	lw	$4,16($17)
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	blez	$4,$L1148
	addu	$5,$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	move	$3,$2
	slt	$2,$3,$4
	bne	$2,$0,$L1151
	.set	noreorder
	.set	nomacro
	j	$L1151
	move	$3,$4
	.set	macro
	.set	reorder

$L1148:
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	subu	$3,$0,$2
	slt	$2,$3,$4
	beq	$2,$0,$L1151
	move	$3,$4
$L1151:
	sw	$3,28($17)
$L1142:
	move	$4,$18
	lw	$2,0($17)
	move	$5,$17
	sw	$0,32($17)
	.set	noreorder
	.set	nomacro
	jal	Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
	sw	$2,36($17)
	.set	macro
	.set	reorder

	lw	$6,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L1154
	subu	$6,$0,$6
	.set	macro
	.set	reorder

	addu	$2,$17,36
	sw	$2,16($sp)
	lw	$4,28($17)
	lw	$5,36($17)
	.set	noreorder
	.set	nomacro
	jal	Math_ResolveRotatedVector__FiiiPiT3
	addu	$7,$17,28
	.set	macro
	.set	reorder

$L1154:
	lw	$2,40($17)
	#nop
	beq	$2,$0,$L1155
$L1160:
	lw	$2,44($17)
	.set	noreorder
	.set	nomacro
	j	$L1097
	sw	$2,1156($18)
	.set	macro
	.set	reorder

$L1155:
	lw	$2,44($17)
	#nop
	sw	$2,1160($18)
$L1097:
	lw	$31,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
	.text
	.ent	Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$4,1120($17)
	lw	$2,AITune_driveSide
	#nop
	mult	$4,$2
	move	$20,$5
	move	$19,$6
	lw	$3,1396($17)
	mflo	$16
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1173
	move	$18,$0
	.set	macro
	.set	reorder

	blez	$16,$L1173
	lw	$5,1732($17)
	lh	$4,8($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	addu	$5,$5,1
	.set	macro
	.set	reorder

	beq	$2,$0,$L1172
$L1173:
	lw	$2,1396($17)
	#nop
	blez	$2,$L1171
	bgez	$16,$L1171
	lw	$5,1732($17)
	lh	$4,8($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	bne	$2,$0,$L1171
$L1172:
	li	$18,1			# 0x00000001
$L1171:
	beq	$18,$0,$L1170
	subu	$16,$0,$16
$L1170:
	.set	noreorder
	.set	nomacro
	blez	$16,$L1174
	li	$16,7			# 0x00000007
	.set	macro
	.set	reorder

$L1175:
	move	$5,$19
	lh	$4,8($17)
	lw	$6,1120($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	move	$7,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1176
	slt	$2,$16,10
	.set	macro
	.set	reorder

	beq	$2,$0,$L1176
	.set	noreorder
	.set	nomacro
	j	$L1175
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L1176:
	lw	$3,BWorldSm_slices
	sll	$2,$20,5
	addu	$2,$2,$3
	lbu	$2,31($2)
	addu	$3,$16,-7
	sll	$2,$2,15
	mult	$3,$2
	srl	$2,$2,1
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L1179
	addu	$4,$8,$2
	.set	macro
	.set	reorder

	li	$2,65536			# 0x00010000
	ori	$2,$2,0x8000
	addu	$4,$4,$2
$L1179:
	.set	noreorder
	.set	nomacro
	j	$L1188
	move	$2,$4
	.set	macro
	.set	reorder

$L1174:
	li	$16,6			# 0x00000006
$L1181:
	move	$5,$19
	lh	$4,8($17)
	lw	$6,1120($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	move	$7,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1182
	slt	$2,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1189
	li	$3,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1181
	addu	$16,$16,-1
	.set	macro
	.set	reorder

$L1182:
	li	$3,6			# 0x00000006
$L1189:
	lw	$4,BWorldSm_slices
	sll	$2,$20,5
	addu	$2,$2,$4
	lbu	$2,30($2)
	subu	$3,$3,$16
	sll	$2,$2,15
	mult	$3,$2
	srl	$2,$2,1
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L1185
	addu	$4,$8,$2
	.set	macro
	.set	reorder

	li	$2,65536			# 0x00010000
	ori	$2,$2,0x8000
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L1188
	subu	$2,$0,$2
	.set	macro
	.set	reorder

$L1185:
	subu	$2,$0,$4
$L1188:
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

	.end	Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
	.text
	.ent	Physics_Real__FP8Car_tObj
Physics_Real__FP8Car_tObj:
	.frame	$sp,280,$31		# vars= 232, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,280
	sw	$21,268($sp)
	move	$21,$4
	lui	$2,%hi(GameSetup_gData+72) # high
	sw	$31,276($sp)
	sw	$22,272($sp)
	sw	$20,264($sp)
	sw	$19,260($sp)
	sw	$18,256($sp)
	sw	$17,252($sp)
	sw	$16,248($sp)
	sw	$0,1036($21)
	sw	$0,1040($21)
	sw	$0,1044($21)
	lw	$2,%lo(GameSetup_gData+72)($2)
	lw	$22,1124($21)
	li	$16,1			# 0x00000001
	sw	$16,steeringControl
	sw	$16,powerControl
	beq	$2,$0,$L1191
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$21,8
	.set	macro
	.set	reorder

	xor	$2,$2,$16
	beq	$2,$0,$L1191
	sw	$16,slippery
	j	$L1192
$L1191:
	sw	$0,slippery
$L1192:
	lw	$2,684($21)
	#nop
	beq	$2,$0,$L1193
	lw	$2,732($21)
	#nop
	beq	$2,$0,$L1193
	lw	$2,392($21)
	#nop
	slt	$2,$2,3277
	bne	$2,$0,$L1193
	sw	$0,steeringControl
$L1193:
	lw	$2,780($21)
	#nop
	beq	$2,$0,$L1194
	lw	$2,828($21)
	#nop
	beq	$2,$0,$L1194
	lw	$2,392($21)
	#nop
	slt	$2,$2,3277
	bne	$2,$0,$L1194
	sw	$0,powerControl
$L1194:
	lw	$4,172($21)
	lw	$5,452($21)
	jal	fixedmult
	lw	$4,176($21)
	lw	$5,456($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($21)
	lw	$5,460($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,172($21)
	lw	$5,464($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1048($21)
	.set	macro
	.set	reorder

	lw	$4,176($21)
	lw	$5,468($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($21)
	lw	$5,472($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,172($21)
	lw	$5,476($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1052($21)
	.set	macro
	.set	reorder

	lw	$4,176($21)
	lw	$5,480($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,180($21)
	lw	$5,484($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($21)
	lw	$5,452($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1056($21)
	.set	macro
	.set	reorder

	lw	$4,280($21)
	lw	$5,456($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($21)
	lw	$5,460($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($21)
	lw	$5,464($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1060($21)
	.set	macro
	.set	reorder

	lw	$4,280($21)
	lw	$5,468($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($21)
	lw	$5,472($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,276($21)
	lw	$5,476($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,1064($21)
	.set	macro
	.set	reorder

	lw	$4,280($21)
	lw	$5,480($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($21)
	lw	$5,484($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	lw	$5,1056($21)
	li	$2,327680			# 0x00050000
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1195
	sw	$16,1068($21)
	.set	macro
	.set	reorder

	lw	$4,1048($21)
	jal	fixeddiv
	.set	noreorder
	.set	nomacro
	j	$L1196
	sw	$2,1144($21)
	.set	macro
	.set	reorder

$L1195:
	sw	$0,1144($21)
$L1196:
	lw	$2,1048($21)
	#nop
	sll	$2,$2,5
	subu	$2,$0,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,144($sp)
	lw	$2,1052($21)
	#nop
	sll	$2,$2,5
	subu	$2,$0,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,148($sp)
	lw	$2,1056($21)
	#nop
	sll	$2,$2,5
	subu	$2,$0,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,152($sp)
	lw	$4,280($21)
	lw	$5,452($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,5
	.set	macro
	.set	reorder

	move	$4,$0
	li	$3,-655360			# 0xfff60000
	subu	$18,$0,$2
	srl	$2,$18,31
	addu	$18,$18,$2
	sw	$0,112($sp)
	sw	$3,116($sp)
	sw	$0,120($sp)
	lw	$5,452($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$18,$18,1
	.set	macro
	.set	reorder

	lw	$4,116($sp)
	lw	$5,456($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,460($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lui	$19,%hi(gravity_ch) # high
	addu	$16,$16,$17
	lw	$4,112($sp)
	addu	$16,$16,$2
	sw	$16,%lo(gravity_ch)($19)
	lw	$5,464($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addiu	$20,$19,%lo(gravity_ch) # low
	.set	macro
	.set	reorder

	lw	$4,116($sp)
	lw	$5,468($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,472($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,112($sp)
	addu	$16,$16,$2
	sw	$16,4($20)
	lw	$5,476($21)
	jal	fixedmult
	lw	$4,116($sp)
	lw	$5,480($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,484($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,8($20)
	lw	$3,144($sp)
	lw	$5,148($sp)
	lw	$6,152($sp)
	addu	$2,$3,$18
	subu	$3,$3,$18
	sw	$2,32($sp)
	sw	$5,36($sp)
	sw	$6,40($sp)
	sw	$3,80($sp)
	sw	$5,84($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_RampCarControlValues__FP8Car_tObj
	sw	$6,88($sp)
	.set	macro
	.set	reorder

	lw	$3,%lo(gravity_ch)($19)
	#nop
	bgez	$3,$L1197
	addu	$3,$3,255
$L1197:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1198
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L1198:
	lw	$2,1104($21)
	sra	$16,$3,16
	addu	$3,$2,$16
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1199
	slt	$2,$3,-127
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1200
	li	$3,127			# 0x0000007f
	.set	macro
	.set	reorder

$L1199:
	beq	$2,$0,$L1200
	li	$3,-127			# 0xffffff81
$L1200:
	lw	$2,268($22)
	#nop
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1320
	sra	$5,$2,7
	.set	macro
	.set	reorder

	addu	$2,$2,127
	sra	$5,$2,7
$L1320:
	sw	$5,28($sp)
	lw	$2,536($21)
	lw	$3,540($21)
	#nop
	addu	$2,$2,$3
	lw	$3,544($21)
	lw	$4,572($21)
	addu	$2,$2,$3
	addu	$3,$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1203
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,511
$L1203:
	sra	$3,$2,9
	move	$4,$5
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1204
	subu	$2,$2,$3
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1204:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1205
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1205:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sw	$8,28($sp)
	lw	$4,1056($21)
	li	$2,3932160			# 0x003c0000
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1321
	li	$2,1703936			# 0x001a0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1092			# 0x00000444
	.set	macro
	.set	reorder

	lw	$4,28($sp)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$2
	.set	macro
	.set	reorder

	sw	$2,28($sp)
	li	$2,1703936			# 0x001a0000
$L1321:
	lw	$3,1056($21)
	ori	$2,$2,0xb333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1207
	li	$2,851968			# 0x000d0000
	.set	macro
	.set	reorder

	lw	$3,1144($21)
	#nop
	slt	$2,$3,3277
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1319
	slt	$2,$3,-3276
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1216
	slt	$2,$3,-3276
	.set	macro
	.set	reorder

	j	$L1319
$L1207:
	ori	$2,$2,0x6666
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1322
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$3,1144($21)
	#nop
	slt	$2,$3,9831
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1319
	slt	$2,$3,-9830
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1216
	slt	$2,$3,-9830
	.set	macro
	.set	reorder

$L1319:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1322
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1323
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1216:
	lw	$2,1144($21)
	li	$5,65536			# 0x00010000
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sll	$3,$2,1
	move	$2,$5
	slt	$2,$2,$3
	bne	$2,$0,$L1218
	move	$5,$3
$L1218:
	lw	$4,28($sp)
	jal	fixedmult
	sw	$2,28($sp)
	move	$4,$21
$L1322:
	li	$2,1			# 0x00000001
$L1323:
	sw	$0,76($sp)
	sw	$2,56($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateCarAcceleration__FP8Car_tObj
	sw	$0,104($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1220
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1220:
	lw	$2,248($22)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1221
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1221:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,steeringControl
	mflo	$2
	#nop
	#nop
	sw	$2,16($sp)
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1222
	sw	$2,64($sp)
	.set	macro
	.set	reorder

	lw	$2,powerControl
	#nop
	bne	$2,$0,$L1222
	sw	$0,1156($21)
	.set	noreorder
	.set	nomacro
	j	$L1190
	sw	$0,1160($21)
	.set	macro
	.set	reorder

$L1222:
	lw	$3,gBrakeRatio
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1223
	sw	$0,1004($21)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1223:
	lw	$2,252($22)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1224
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1224:
	sra	$2,$2,8
	mult	$4,$2
	lw	$2,1056($21)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sll	$2,$2,5
	move	$4,$2
	mflo	$16
 #APP
 #NO_APP
	#nop
	#nop
	slt	$2,$4,$16
	bne	$2,$0,$L1225
	move	$4,$16
$L1225:
	lw	$3,572($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1226
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L1324
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$3,$3,127
$L1324:
	sra	$3,$3,7
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1228
	subu	$2,$2,$3
	.set	macro
	.set	reorder

	addu	$4,$16,255
$L1228:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1229
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1229:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$16
$L1226:
	lw	$2,1056($21)
	#nop
	blez	$2,$L1230
	subu	$16,$0,$16
$L1230:
	lw	$5,256($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	addu	$3,$3,$2
	sw	$3,16($sp)
	lw	$3,64($sp)
	subu	$2,$16,$2
	addu	$3,$3,$2
	lui	$2,%hi(gravity_ch+4) # high
	lw	$4,%lo(gravity_ch+4)($2)
	sw	$3,64($sp)
	lw	$5,276($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$0,$4
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateRoadGripModifiers__FP8Car_tObj
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$17,$L1231
	move	$3,$17
	.set	macro
	.set	reorder

	addu	$3,$17,255
$L1231:
	lw	$2,roadMult
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1232
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1232:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$17
	#nop
	#nop
	bltz	$17,$L1190
	lw	$2,slippery
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1234
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$5,264($22)
	.set	noreorder
	.set	nomacro
	j	$L1313
	addu	$5,$5,655
	.set	macro
	.set	reorder

$L1234:
	lw	$5,264($22)
$L1313:
	jal	fixedmult
	move	$18,$2
	lw	$2,552($21)
	lw	$3,556($21)
	#nop
	addu	$2,$2,$3
	lw	$3,560($21)
	lw	$4,572($21)
	addu	$2,$2,$3
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1325
	sra	$3,$2,9
	.set	macro
	.set	reorder

	addu	$2,$2,511
	sra	$3,$2,9
$L1325:
	li	$2,49152			# 0x0000c000
	addu	$16,$3,$2
	lw	$4,1148($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1237
	sw	$4,1148($21)
	.set	macro
	.set	reorder

	move	$5,$16
	addu	$2,$4,255
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1239
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L1239:
	sra	$2,$5,8
	mult	$3,$2
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	j	$L1240
	sw	$8,1148($21)
	.set	macro
	.set	reorder

$L1237:
	.set	noreorder
	.set	nomacro
	blez	$4,$L1240
	sll	$2,$4,1
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	bgez	$2,$L1242
	addu	$2,$2,3
$L1242:
	sra	$2,$2,2
	sw	$2,1148($21)
$L1240:
	lw	$2,1148($21)
	lw	$3,frontMult
	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1243
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1243:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1244
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1244:
	sra	$2,$2,8
	mult	$3,$2
	subu	$2,$17,$18
	mflo	$8
	#nop
	#nop
	sw	$8,20($sp)
	lw	$3,1148($21)
	lw	$4,rearMult
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1245
	sw	$2,68($sp)
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1245:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1246
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1246:
	sra	$2,$2,8
	mult	$3,$2
	lw	$2,steeringControl
	mflo	$8
	#nop
	#nop
	sw	$8,68($sp)
	sw	$0,1140($21)
	sw	$0,44($sp)
	sw	$0,52($sp)
	sw	$0,92($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1247
	sw	$0,100($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L1247:
	lw	$2,powerControl
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1248
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
	addu	$5,$sp,64
	.set	macro
	.set	reorder

$L1248:
	lw	$2,52($sp)
	lw	$3,100($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,1044($21)
	lw	$2,44($sp)
	lw	$3,92($sp)
	lw	$4,1044($21)
	addu	$2,$2,$3
	sw	$2,1036($21)
	lw	$5,460($22)
	jal	fixedmult
	move	$4,$2
	lui	$2,%hi(GameSetup_gData+56) # high
	sw	$4,1044($21)
	lw	$3,%lo(GameSetup_gData+56)($2)
	li	$2,128			# 0x00000080
	bne	$3,$2,$L1249
	blez	$4,$L1249
	lbu	$2,1094($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1249
	sll	$2,$4,2
	.set	macro
	.set	reorder

	sw	$2,1044($21)
$L1249:
	lw	$2,slippery
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1326
	lui	$2,%hi(gravity_ch+8) # high
	.set	macro
	.set	reorder

	lw	$2,648($21)
	#nop
	lw	$3,56($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1327
	li	$5,65536			# 0x00010000
	.set	macro
	.set	reorder

	lbu	$2,1090($21)
	#nop
	sltu	$2,$2,4
	beq	$2,$0,$L1327
	lw	$4,1044($21)
	.set	noreorder
	.set	nomacro
	j	$L1314
	ori	$5,$5,0x2666
	.set	macro
	.set	reorder

$L1327:
	lw	$4,1044($21)
	ori	$5,$5,0x1999
$L1314:
	jal	fixedmult
	sw	$2,1044($21)
	lui	$2,%hi(gravity_ch+8) # high
$L1326:
	sw	$0,1040($21)
	lw	$4,%lo(gravity_ch+8)($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,6553			# 0x00001999
	.set	macro
	.set	reorder

	lw	$4,1036($21)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1253
	subu	$16,$0,$2
	.set	macro
	.set	reorder

	addu	$4,$4,7
$L1253:
	lw	$5,292($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,3
	.set	macro
	.set	reorder

	lw	$4,1044($21)
	subu	$2,$0,$2
	sw	$2,1152($21)
	lw	$5,292($22)
	jal	fixedmult
	addu	$2,$2,$16
	sw	$2,1148($21)
	lw	$2,44($sp)
	lw	$4,92($sp)
	lw	$5,456($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$2,52($sp)
	lw	$4,100($sp)
	lw	$3,leftMult
	lw	$5,rightMult
	addu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	lw	$5,456($22)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	sll	$2,$2,1
	addu	$16,$16,$2
	sw	$16,132($sp)
	lw	$2,280($21)
	#nop
	blez	$2,$L1256
	bgtz	$16,$L1255
$L1256:
	bgez	$2,$L1254
	bgez	$16,$L1254
$L1255:
	lbu	$2,1093($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1257
	lui	$2,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0008
	bne	$2,$0,$L1257
	lw	$2,132($sp)
	#nop
	srl	$3,$2,31
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1315
	sra	$2,$2,1
	.set	macro
	.set	reorder

$L1257:
	lw	$3,1100($21)
	#nop
	bgez	$3,$L1261
	lw	$2,280($21)
	#nop
	slt	$2,$2,13108
	beq	$2,$0,$L1260
$L1261:
	blez	$3,$L1259
	lw	$2,280($21)
	#nop
	slt	$2,$2,-13107
	beq	$2,$0,$L1259
$L1260:
	lw	$3,1132($21)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L1259
	lw	$2,280($21)
	.set	noreorder
	.set	nomacro
	j	$L1315
	subu	$2,$0,$2
	.set	macro
	.set	reorder

$L1259:
	lw	$2,1124($21)
	lw	$4,132($sp)
	lw	$5,300($2)
	jal	fixedmult
$L1315:
	sw	$2,132($sp)
$L1254:
	addu	$4,$21,452
	addu	$5,$sp,160
	sw	$0,128($sp)
	.set	noreorder
	.set	nomacro
	jal	transpose
	sw	$0,136($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	Cars_DoGravityEffectsOnAcc__FP8Car_tObji
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,1036($21)
	lw	$5,160($sp)
	jal	fixedmult
	lw	$4,1040($21)
	lw	$5,164($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($21)
	lw	$5,168($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1036($21)
	addu	$16,$16,$2
	sw	$16,1024($21)
	lw	$5,172($sp)
	jal	fixedmult
	lw	$4,1040($21)
	lw	$5,176($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($21)
	lw	$5,180($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,1036($21)
	addu	$16,$16,$2
	sw	$16,1028($21)
	lw	$5,184($sp)
	jal	fixedmult
	lw	$4,1040($21)
	lw	$5,188($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,1044($21)
	lw	$5,192($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,1032($21)
	lw	$4,128($sp)
	lw	$5,160($sp)
	jal	fixedmult
	lw	$4,132($sp)
	lw	$5,164($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,136($sp)
	lw	$5,168($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,1012($21)
	lw	$4,128($sp)
	lw	$5,172($sp)
	jal	fixedmult
	lw	$4,132($sp)
	lw	$5,176($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,136($sp)
	lw	$5,180($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,1016($21)
	lw	$4,128($sp)
	lw	$5,184($sp)
	jal	fixedmult
	lw	$4,132($sp)
	lw	$5,188($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,136($sp)
	lw	$5,192($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$3,1024($21)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1263
	sw	$16,1020($21)
	.set	macro
	.set	reorder

	addu	$3,$3,31
$L1263:
	sra	$3,$3,5
	lw	$2,172($21)
	lw	$4,1028($21)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1264
	sw	$2,172($21)
	.set	macro
	.set	reorder

	addu	$4,$4,31
$L1264:
	sra	$3,$4,5
	lw	$2,176($21)
	lw	$5,1032($21)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1265
	sw	$2,176($21)
	.set	macro
	.set	reorder

	addu	$5,$5,31
$L1265:
	sra	$3,$5,5
	lw	$2,180($21)
	lw	$4,1012($21)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1266
	sw	$2,180($21)
	.set	macro
	.set	reorder

	addu	$4,$4,31
$L1266:
	sra	$3,$4,5
	lw	$2,276($21)
	lw	$5,1016($21)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1267
	sw	$2,276($21)
	.set	macro
	.set	reorder

	addu	$5,$5,63
$L1267:
	sra	$3,$5,6
	lw	$2,280($21)
	lw	$4,1020($21)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1268
	sw	$2,280($21)
	.set	macro
	.set	reorder

	addu	$4,$4,31
$L1268:
	sra	$2,$4,5
	lw	$3,284($21)
	lw	$4,1120($21)
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1269
	sw	$3,284($21)
	.set	macro
	.set	reorder

	li	$2,262144			# 0x00040000
	lw	$3,1372($21)
	ori	$2,$2,0x71c6
	slt	$2,$2,$3
	bne	$2,$0,$L1270
	lbu	$2,1090($21)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L1271
	lbu	$2,1090($21)
	.set	noreorder
	.set	nomacro
	j	$L1272
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L1271:
	li	$2,8			# 0x00000008
$L1272:
	li	$4,1572864			# 0x00180000
	addu	$2,$22,$2
	lw	$5,12($2)
	.set	noreorder
	.set	nomacro
	j	$L1318
	ori	$4,$4,0x8000
	.set	macro
	.set	reorder

$L1270:
	lbu	$2,1090($21)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L1275
	lbu	$2,1090($21)
	.set	noreorder
	.set	nomacro
	j	$L1276
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L1275:
	li	$2,8			# 0x00000008
$L1276:
	addu	$2,$22,$2
	lw	$4,1372($21)
	lw	$5,12($2)
$L1318:
	jal	fixedmult
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1277
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L1277:
	lbu	$2,1090($21)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1278
	sra	$16,$3,16
	.set	macro
	.set	reorder

	lbu	$2,1090($21)
	.set	noreorder
	.set	nomacro
	j	$L1279
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L1278:
	li	$2,8			# 0x00000008
$L1279:
	addu	$2,$22,$2
	lw	$4,1056($21)
	lw	$5,12($2)
	jal	fixedmult
	move	$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1280
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$5,$5,$2
$L1280:
	lw	$3,240($22)
	sll	$2,$16,8
	div	$4,$2,$3
 #APP
 #NO_APP
	sra	$2,$5,16
	subu	$5,$16,$2
	slt	$2,$5,201
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1281
	slt	$2,$5,200
	.set	macro
	.set	reorder

	sll	$2,$5,7
	div	$2,$2,$16
	addu	$4,$4,$2
	move	$3,$4
	slt	$2,$3,225
	bne	$2,$0,$L1282
	li	$3,224			# 0x000000e0
$L1282:
	.set	noreorder
	.set	nomacro
	j	$L1283
	sb	$3,1112($21)
	.set	macro
	.set	reorder

$L1281:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1283
	sll	$2,$5,7
	.set	macro
	.set	reorder

	div	$2,$2,$16
	addu	$4,$4,$2
	bltz	$4,$L1285
	.set	noreorder
	.set	nomacro
	j	$L1286
	sb	$4,1112($21)
	.set	macro
	.set	reorder

$L1285:
	sb	$0,1112($21)
$L1286:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1328
	li	$3,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	sll	$2,$5,9
	lw	$3,240($22)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	div	$3,$2,$3
	slt	$2,$3,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1329
	andi	$2,$3,0x00ff
	.set	macro
	.set	reorder

	li	$3,255			# 0x000000ff
	andi	$2,$3,0x00ff
$L1329:
	sltu	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1283
	sb	$3,1113($21)
	.set	macro
	.set	reorder

	sb	$0,1112($21)
$L1283:
	li	$3,715784192			# 0x2aaa0000
$L1328:
	lw	$2,1380($21)
	ori	$3,$3,0xaaab
	bgez	$2,1f
	subu	$2,$0,$2
1:
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,16
	subu	$6,$3,$2
	slt	$2,$6,3
	lw	$3,1120($21)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1290
	sll	$2,$3,1
	.set	macro
	.set	reorder

	mult	$3,$6
	mflo	$3
	#nop
	j	$L1291
$L1290:
	addu	$3,$2,$3
$L1291:
 #APP
 #NO_APP
	bltz	$3,$L1292
	lh	$2,8($21)
	lw	$4,gNumSlices
	addu	$5,$2,$3
	slt	$2,$5,$4
	bne	$2,$0,$L1294
	.set	noreorder
	.set	nomacro
	j	$L1294
	subu	$5,$5,$4
	.set	macro
	.set	reorder

$L1292:
	lh	$2,8($21)
	#nop
	addu	$5,$2,$3
	bgez	$5,$L1294
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L1294:
	sll	$16,$5,5
	sll	$6,$3,1
	addu	$6,$6,$3
	lw	$2,BWorldSm_slices
	bgez	$6,1f
	subu	$6,$0,$6
1:
	lw	$8,160($21)
	lw	$9,164($21)
	lw	$10,168($21)
	sw	$8,200($sp)
	sw	$9,204($sp)
	sw	$10,208($sp)
	addu	$2,$16,$2
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,216($sp)
	sw	$9,220($sp)
	sw	$10,224($sp)
	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	move	$17,$2
	addu	$3,$16,$3
	lb	$4,18($3)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sw	$2,232($sp)
	addu	$3,$16,$3
	lb	$4,19($3)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sw	$2,236($sp)
	addu	$16,$16,$3
	lb	$4,20($16)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$5,216($sp)
	lw	$3,232($sp)
	lw	$6,220($sp)
	lw	$7,236($sp)
	addu	$5,$5,$3
	addu	$6,$6,$7
	lw	$3,224($sp)
	lw	$7,200($sp)
	sw	$2,240($sp)
	sw	$5,216($sp)
	addu	$3,$3,$2
	lw	$2,204($sp)
	subu	$5,$5,$7
	sw	$5,216($sp)
	lw	$5,208($sp)
	addu	$4,$sp,216
	sw	$6,220($sp)
	sw	$3,224($sp)
	subu	$6,$6,$2
	subu	$3,$3,$5
	sw	$6,220($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	sw	$3,224($sp)
	.set	macro
	.set	reorder

	lw	$4,216($sp)
	lw	$5,240($21)
	jal	fixedmult
	lw	$4,220($sp)
	lw	$5,244($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,224($sp)
	lw	$5,248($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1330
	sra	$16,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$16,$2,8
$L1330:
	slt	$2,$16,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1297
	sw	$16,1116($21)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1316
	li	$2,127			# 0x0000007f
	.set	macro
	.set	reorder

$L1297:
	slt	$2,$16,-127
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1269
	li	$2,-127			# 0xffffff81
	.set	macro
	.set	reorder

$L1316:
	sw	$2,1116($21)
$L1269:
	lui	$2,%hi(GameSetup_gData+56) # high
	lw	$2,%lo(GameSetup_gData+56)($2)
	#nop
	andi	$2,$2,0x0008
	bne	$2,$0,$L1303
	lbu	$2,1087($21)
	#nop
	beq	$2,$0,$L1301
	lw	$2,1144($21)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,6554
	bne	$2,$0,$L1303
$L1301:
	lw	$2,1124($21)
	lw	$5,172($21)
	lw	$4,344($2)
	jal	fixedmult
	lw	$5,176($21)
	lw	$3,1124($21)
	sw	$2,172($21)
	lw	$4,344($3)
	jal	fixedmult
	lw	$5,180($21)
	lw	$3,1124($21)
	sw	$2,176($21)
	lw	$4,344($3)
	jal	fixedmult
	sw	$2,180($21)
$L1303:
	lw	$3,448($21)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1304
	li	$2,2883584			# 0x002c0000
	.set	macro
	.set	reorder

	lw	$3,192($21)
	ori	$2,$2,0xa3d7
	slt	$2,$2,$3
	beq	$2,$0,$L1304
	lw	$5,172($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,65208			# 0x0000feb8
	.set	macro
	.set	reorder

	lw	$5,176($21)
	li	$4,65208			# 0x0000feb8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,172($21)
	.set	macro
	.set	reorder

	lw	$5,180($21)
	.set	noreorder
	.set	nomacro
	j	$L1317
	li	$4,65208			# 0x0000feb8
	.set	macro
	.set	reorder

$L1304:
	lbu	$3,1090($21)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1306
	lui	$2,%hi(gravity_ch+8) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(gravity_ch+8)($2)
	li	$2,32767			# 0x00007fff
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1306
	li	$3,1245184			# 0x00130000
	.set	macro
	.set	reorder

	lw	$2,1056($21)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1309
	li	$16,64880			# 0x0000fd70
	.set	macro
	.set	reorder

	lw	$2,1104($21)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,33
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1307
	li	$16,65404			# 0x0000ff7c
	.set	macro
	.set	reorder

	li	$16,64880			# 0x0000fd70
$L1307:
$L1309:
	lw	$5,172($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,176($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,172($21)
	.set	macro
	.set	reorder

	lw	$5,180($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,176($21)
	.set	macro
	.set	reorder

	lw	$5,276($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,180($21)
	.set	macro
	.set	reorder

	lw	$5,280($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($21)
	.set	macro
	.set	reorder

	lw	$5,284($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($21)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1190
	sw	$2,284($21)
	.set	macro
	.set	reorder

$L1306:
	lbu	$2,1093($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1190
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	lw	$3,192($21)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L1190
	lw	$5,172($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$5,176($21)
	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,172($21)
	.set	macro
	.set	reorder

	lw	$5,180($21)
	li	$4,32768			# 0x00008000
$L1317:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,176($21)
	.set	macro
	.set	reorder

	sw	$2,180($21)
$L1190:
	lw	$31,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,280
	.set	macro
	.set	reorder

	.end	Physics_Real__FP8Car_tObj
	.text
	.ent	Physics_SimCar__FP8Car_tObj
Physics_SimCar__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,300($4)
	#nop
	slt	$2,$2,6553
	beq	$2,$0,$L1332
	lw	$3,1128($4)
	sw	$0,1132($4)
	sw	$0,1144($4)
	sw	$0,1156($4)
	slt	$2,$3,501
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1333
	sw	$0,1160($4)
	.set	macro
	.set	reorder

	addu	$2,$3,-500
	.set	noreorder
	.set	nomacro
	j	$L1334
	sw	$2,1128($4)
	.set	macro
	.set	reorder

$L1333:
	sw	$0,1128($4)
$L1334:
	lw	$3,392($4)
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$3
	bne	$2,$0,$L1331
	jal	Physics_StopCar__FP8Car_tObj
	j	$L1331
$L1332:
	jal	Physics_Real__FP8Car_tObj
$L1331:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Physics_SimCar__FP8Car_tObj
