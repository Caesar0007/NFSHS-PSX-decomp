	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\ai.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	curveynessLevelStarts
	.data
	.align	2
curveynessLevelStarts:
	.word	0
	.word	10
	.word	15
	.word	25
	.text
	.align	2
	.globl	AI_StartUp__Fv
	.align	2
	.globl	AI_CleanUp__Fv
	.align	2
	.globl	AI_Main_OverallSetup__Fv
	.align	2
	.globl	AI_CarAvoidance__FP8Car_tObj
	.align	2
	.globl	AI_WorldAvoidance__FP8Car_tObj
	.align	2
	.globl	AI_InitAIInfo__FP8Car_tObj
	.align	2
	.globl	AI_GenericBeginCycle__FP8Car_tObj
	.align	2
	.globl	AI_GenericCycle__FP8Car_tObj
	.align	2
	.globl	AI_GenericEndCycle__FP8Car_tObj
	.align	2
	.globl	AI_TargetLane__FP8Car_tObji
	.align	2
	.globl	AI_ClearLaneMerits__Fv
	.align	2
	.globl	AI_DoReactions__FP8Car_tObj
	.align	2
	.globl	AI_CheckForPlayerActions__FP8Car_tObjT0
	.align	2
	.globl	AI_DoReactionsAndBehavior__FP8Car_tObj
	.align	2
	.globl	AI_OpponentBlockPlayer__FP8Car_tObjT0
	.rdata
	.align	2
$LC0:
	.word	1
	.word	1
	.word	1
	.text
	.align	2
	.globl	AI_CheckForBarriers__FP8Car_tObj
	.align	2
	.globl	AI_SetupOncomingLaneDemerits__FP8Car_tObj
	.align	2
	.globl	AI_HandleChangeInNumLanes__FP8Car_tObj
	.align	2
	.globl	AI_HandleShouldersAndOffRoad__FP8Car_tObj
	.align	2
	.globl	AI_CalculateLaneSpeeds__FP8Car_tObj
	.align	2
	.globl	AI_CalcMeritsBasedOnSpeed__FP8Car_tObj
	.align	2
	.globl	AI_CheckForClearLanes__FP8Car_tObj
	.align	2
	.globl	AI_CalcBestLineMerits__FP8Car_tObj

	.lcomm	spos.272,132

	.lcomm	firstTime.273,1
	.align	2
	.globl	AI_AddCollidableObjects__FP8Car_tObjP5Group
	.align	2
	.globl	AI_AvoidObjects__FP8Car_tObj
	.align	2
	.globl	AI_AvoidSpikeBelt__FP8Car_tObj
	.align	2
	.globl	AI_SubmitObstacle__FP8Car_tObjiiii
	.align	2
	.globl	AI_HandleTrafficHonking__FP8Car_tObj
	.align	2
	.globl	AI_CheckForCarsOnSide__FP8Car_tObj
	.align	2
	.globl	AI_ProcessObservationsAndChooseLane__FP8Car_tObj
	.align	2
	.globl	AI_ChooseBestLane__FP8Car_tObj
	.align	2
	.globl	AI_CheckPreferredLateralPosition__FP8Car_tObj
	.align	2
	.globl	AI_TryToShareLanes__FP8Car_tObjT0
	.align	2
	.globl	AI_CalculateDesiredLatPosition__FP8Car_tObj
	.align	2
	.globl	AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
	.align	2
	.globl	AI_IsMellowZone__FP8Car_tObji
	.align	2
	.globl	AI_KeepCarsInLane__FP8Car_tObj
	.align	2
	.globl	AI_PushFinishedCarsToSide__FP8Car_tObj
	.align	2
	.globl	AI_MaybeChangeLaneSlack__FP8Car_tObj
	.align	2
	.globl	AI_ChooseNewLaneSlack__FP8Car_tObj
	.globl	CarLogic_gObs
	.data
	.align	2
CarLogic_gObs:
	.space	12
	.globl	AI_Info
	.align	2
AI_Info:
	.space	72
	.globl	AI_time
	.sdata
	.align	2
AI_time:
	.space	4
	.globl	AI_elapsedTime
	.align	2
AI_elapsedTime:
	.space	4
	.globl	AI_iTime
	.align	2
AI_iTime:
	.space	4

	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gNumAIRaceCars, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	D_8011321C, 4
	.extern	Object_customSimObjs, 4
	.extern	Object_customObjInst, 4
	.extern	AIDataRecord_BestLine, 4
	.extern	AITune_driveSide, 4
	.extern	AITune_oneWay, 4
	.extern	Cars_gNumCopCars, 4
	.extern	Cars_gNumTrafficCars, 4
	.extern	gNumSlices, 4
	.extern	BWorldSm_slices, 4
	.extern	Cars_gNumCars, 4
	.extern	simGlobal, 24
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AI_StartUp__Fv
AI_StartUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AI_StartUp__Fv
	.text
	.ent	AI_CleanUp__Fv
AI_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AI_CleanUp__Fv
	.text
	.ent	AI_Main_OverallSetup__Fv
AI_Main_OverallSetup__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AI_Main_OverallSetup__Fv
	.text
	.ent	AI_CarAvoidance__FP8Car_tObj
AI_CarAvoidance__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_SetupOncomingLaneDemerits__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CalculateLaneSpeeds__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CalcMeritsBasedOnSpeed__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CheckForClearLanes__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CheckForCarsOnSide__FP8Car_tObj
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

	.end	AI_CarAvoidance__FP8Car_tObj
	.text
	.ent	AI_WorldAvoidance__FP8Car_tObj
AI_WorldAvoidance__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_CheckForBarriers__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_HandleChangeInNumLanes__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_HandleShouldersAndOffRoad__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CalcBestLineMerits__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_AvoidObjects__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_AvoidSpikeBelt__FP8Car_tObj
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

	.end	AI_WorldAvoidance__FP8Car_tObj
	.text
	.ent	AI_InitAIInfo__FP8Car_tObj
AI_InitAIInfo__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AI_Info) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(AI_Info) # low
	sw	$31,20($sp)
	sw	$0,8($16)
	sw	$0,4($16)
	sw	$0,%lo(AI_Info)($2)
	sw	$0,20($16)
	sw	$0,16($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
	sw	$0,12($16)
	.set	macro
	.set	reorder

	sw	$2,68($16)
	sw	$0,60($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_InitAIInfo__FP8Car_tObj
	.text
	.ent	AI_GenericBeginCycle__FP8Car_tObj
AI_GenericBeginCycle__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AI_InitAIInfo__FP8Car_tObj
	jal	AI_ClearLaneMerits__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_GenericBeginCycle__FP8Car_tObj
	.text
	.ent	AI_GenericCycle__FP8Car_tObj
AI_GenericCycle__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_MaybeChangeLaneSlack__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_DoReactionsAndBehavior__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_PushFinishedCarsToSide__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_KeepCarsInLane__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_HandleTrafficHonking__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CarAvoidance__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_WorldAvoidance__FP8Car_tObj
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

	.end	AI_GenericCycle__FP8Car_tObj
	.text
	.ent	AI_GenericEndCycle__FP8Car_tObj
AI_GenericEndCycle__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_ProcessObservationsAndChooseLane__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CalculateDesiredLatPosition__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
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

	.end	AI_GenericEndCycle__FP8Car_tObj
	.text
	.ent	AI_TargetLane__FP8Car_tObji
AI_TargetLane__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,1732($4)
	#nop
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,327680			# 0x00050000
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($2)
	.set	macro
	.set	reorder

$L610:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,327680			# 0x00050000
	addu	$3,$3,$4
	sw	$3,%lo(CarLogic_gObs)($2)
$L612:
	j	$31
	.end	AI_TargetLane__FP8Car_tObji
	.text
	.ent	AI_ClearLaneMerits__Fv
AI_ClearLaneMerits__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$0
	lui	$4,%hi(CarLogic_gObs) # high
	addiu	$3,$4,%lo(CarLogic_gObs) # low
$L614:
	addu	$2,$2,1
	sw	$0,8($3)
	sw	$0,4($3)
	.set	noreorder
	.set	nomacro
	blez	$2,$L614
	sw	$0,%lo(CarLogic_gObs)($4)
	.set	macro
	.set	reorder

	j	$31
	.end	AI_ClearLaneMerits__Fv
	.text
	.ent	AI_DoReactions__FP8Car_tObj
AI_DoReactions__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	addu	$4,$17,1268
	li	$5,8			# 0x00000008
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L620
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L620
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	move	$5,$2
	.set	macro
	.set	reorder

$L620:
	lbu	$2,1094($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L622
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$0
$L643:
	jal	AudioClc_SetHorn__FP8Car_tObji
$L622:
	addu	$4,$17,1268
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,4096			# 0x00001000
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L625
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData)($2)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L625
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	andi	$2,$2,0x0018
	sra	$3,$2,3
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L629
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L628
	addu	$16,$17,1268
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L647
	move	$4,$16
	.set	macro
	.set	reorder

$L634:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L630
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L631
	addu	$16,$17,1268
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L647
	move	$4,$16
	.set	macro
	.set	reorder

$L628:
	move	$4,$17
	li	$5,4			# 0x00000004
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	j	$L644
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

$L629:
	move	$4,$17
	li	$5,2			# 0x00000002
	li	$6,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	j	$L644
	li	$7,12			# 0x0000000c
	.set	macro
	.set	reorder

$L630:
	move	$4,$17
	li	$5,7			# 0x00000007
	li	$6,40			# 0x00000028
	.set	noreorder
	.set	nomacro
	j	$L644
	li	$7,16			# 0x00000010
	.set	macro
	.set	reorder

$L631:
	move	$4,$17
	li	$5,1			# 0x00000001
	li	$6,32			# 0x00000020
	move	$7,$0
$L644:
	jal	AudioClc_HonkHorn__FP8Car_tObjiii
$L625:
	addu	$16,$17,1268
	move	$4,$16
$L647:
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,512			# 0x00000200
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L635
	lui	$3,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$4,$17
	.set	macro
	.set	reorder

	bgez	$2,1f
	subu	$2,$0,$2
1:
	li	$3,786432			# 0x000c0000
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L646
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIScript_GetReactionTicksLeft__FP10AIScript_t
	move	$4,$16
	.set	macro
	.set	reorder

	bgez	$2,$L637
	addu	$2,$2,31
$L637:
	sra	$2,$2,5
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,1966080			# 0x001e0000
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$3,%lo(CarLogic_gObs)($2)
	.set	macro
	.set	reorder

$L638:
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,1966080			# 0x001e0000
	addu	$3,$3,$4
	sw	$3,8($2)
$L635:
	addu	$4,$17,1268
$L646:
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L618
	lui	$3,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$16,0($2)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,1364($17)
	#nop
	mult	$2,$3
	li	$2,196608			# 0x00030000
	ori	$2,$2,0xffff
	mflo	$8
	#nop
	#nop
	slt	$2,$2,$8
	bne	$2,$0,$L618
	lw	$5,1732($16)
	.set	noreorder
	.set	nomacro
	jal	AI_TargetLane__FP8Car_tObji
	move	$4,$17
	.set	macro
	.set	reorder

$L618:
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

	.end	AI_DoReactions__FP8Car_tObj
	.text
	.ent	AI_CheckForPlayerActions__FP8Car_tObjT0
AI_CheckForPlayerActions__FP8Car_tObjT0:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$2,1f
	move	$20,$2
	subu	$20,$0,$20
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	li	$3,52363264			# 0x031f0000
	ori	$3,$3,0xffff
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L648
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$7,%lo(simGlobal+4)($2)
	lw	$2,440($18)
	#nop
	subu	$2,$7,$2
	slt	$2,$2,15
	beq	$2,$0,$L650
	lw	$2,432($18)
	#nop
	beq	$2,$0,$L650
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L650
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	lw	$5,596($18)
	.set	noreorder
	.set	nomacro
	jal	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	move	$6,$0
	.set	macro
	.set	reorder

$L650:
	lw	$3,1364($17)
	lw	$2,1380($18)
	#nop
	mult	$2,$3
	mflo	$4
	#nop
	lw	$2,1380($17)
	#nop
	mult	$2,$3
	li	$2,2621440			# 0x00280000
	addu	$2,$4,$2
	mflo	$3
	#nop
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	li	$2,720896			# 0x000b0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$5,596($18)
	lw	$7,%lo(simGlobal+4)($2)
	.set	noreorder
	.set	nomacro
	jal	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L651:
	li	$2,720896			# 0x000b0000
	ori	$2,$2,0xffff
	slt	$2,$2,$20
	bne	$2,$0,$L653
	lw	$3,1732($18)
	lw	$2,1732($17)
	#nop
	bne	$3,$2,$L653
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$5,596($18)
	lw	$7,%lo(simGlobal+4)($2)
	.set	noreorder
	.set	nomacro
	j	$L662
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

$L655:
	lui	$2,%hi(simGlobal+4) # high
	lw	$5,596($18)
	lw	$7,%lo(simGlobal+4)($2)
	li	$6,3			# 0x00000003
$L662:
	jal	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
$L653:
	lw	$2,640($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L664
	li	$2,1900544			# 0x001d0000
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$19,$2,%lo(simGlobal) # low
	lw	$2,4($19)
	lw	$3,644($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,15
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	li	$2,1900544			# 0x001d0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	lw	$5,596($18)
	lw	$7,4($19)
	.set	noreorder
	.set	nomacro
	j	$L663
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

$L658:
	lw	$5,596($18)
	lw	$7,4($19)
	li	$6,5			# 0x00000005
$L663:
	jal	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	li	$2,1900544			# 0x001d0000
$L664:
	ori	$2,$2,0xffff
	slt	$2,$2,$20
	bne	$2,$0,$L648
	lbu	$2,1094($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	lui	$2,%hi(GameSetup_gData+84) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+84)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	addu	$4,$17,1268
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$5,596($18)
	lw	$7,%lo(simGlobal+4)($2)
	.set	noreorder
	.set	nomacro
	jal	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

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

	.end	AI_CheckForPlayerActions__FP8Car_tObjT0
	.text
	.ent	AI_DoReactionsAndBehavior__FP8Car_tObj
AI_DoReactionsAndBehavior__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_DoReactions__FP8Car_tObj
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$18,$0
	lui	$2,%hi(Cars_gList) # high
	addiu	$17,$2,%lo(Cars_gList) # low
$L668:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L665
	lw	$16,0($17)
	#nop
	beq	$19,$16,$L670
	lbu	$2,145($16)
	#nop
	beq	$2,$0,$L670
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_CheckForPlayerActions__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,608($19)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_OpponentBlockPlayer__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

$L670:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L668
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L665:
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

	.end	AI_DoReactionsAndBehavior__FP8Car_tObj
	.text
	.ent	AI_OpponentBlockPlayer__FP8Car_tObjT0
AI_OpponentBlockPlayer__FP8Car_tObjT0:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	li	$5,26214400			# 0x01900000
	sw	$31,32($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_IsMellowZone__FP8Car_tObji
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	lui	$2,%hi(AI_Info+68) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(curveynessLevelStarts+8) # high
	lw	$2,%lo(AI_Info+68)($2)
	lw	$3,%lo(curveynessLevelStarts+8)($3)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	move	$4,$17
	.set	macro
	.set	reorder

	lh	$19,8($18)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$3,1364($17)
	#nop
	mult	$2,$3
	addu	$4,$17,1268
	mflo	$16
	#nop
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,1024			# 0x00000400
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L696
	li	$2,-393216			# 0xfffa0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$16,$L677
	li	$2,3211264			# 0x00310000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	li	$2,-393216			# 0xfffa0000
	.set	macro
	.set	reorder

	lw	$5,1732($18)
	lw	$4,1732($17)
	#nop
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	.set	noreorder
	.set	nomacro
	j	$L693
	li	$4,-262144			# 0xfffc0000
	.set	macro
	.set	reorder

$L678:
	.set	noreorder
	.set	nomacro
	bne	$5,$4,$L680
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	.set	noreorder
	.set	nomacro
	j	$L694
	li	$4,-262144			# 0xfffc0000
	.set	macro
	.set	reorder

$L680:
	lw	$3,8($2)
	.set	noreorder
	.set	nomacro
	j	$L695
	li	$4,-262144			# 0xfffc0000
	.set	macro
	.set	reorder

$L677:
	li	$2,-393216			# 0xfffa0000
$L696:
	slt	$2,$16,$2
	bne	$2,$0,$L674
	lw	$3,1264($17)
	#nop
	lw	$2,0($3)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L674
	lw	$2,4($3)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sll	$2,$19,5
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	lw	$5,1732($18)
	addu	$2,$2,$3
	lbu	$4,29($2)
	li	$2,7			# 0x00000007
	srl	$3,$4,4
	subu	$2,$2,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	andi	$2,$4,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,6
	slt	$2,$2,$5
	bne	$2,$0,$L674
	lw	$3,1380($18)
	lw	$2,1364($18)
	#nop
	mult	$3,$2
	li	$2,1310720			# 0x00140000
	mflo	$6
	#nop
	#nop
	slt	$2,$2,$6
	beq	$2,$0,$L674
	lw	$4,1732($17)
	#nop
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,262144			# 0x00040000
$L693:
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L674
	sw	$3,%lo(CarLogic_gObs)($2)
	.set	macro
	.set	reorder

$L688:
	.set	noreorder
	.set	nomacro
	bne	$5,$4,$L690
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,262144			# 0x00040000
$L694:
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L674
	sw	$3,4($2)
	.set	macro
	.set	reorder

$L690:
	lw	$3,8($2)
	li	$4,262144			# 0x00040000
$L695:
	addu	$3,$3,$4
	sw	$3,8($2)
$L674:
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

	.end	AI_OpponentBlockPlayer__FP8Car_tObjT0
	.text
	.ent	AI_CheckForBarriers__FP8Car_tObj
AI_CheckForBarriers__FP8Car_tObj:
	.frame	$sp,96,$31		# vars= 40, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$23,84($sp)
	move	$23,$4
	lui	$2,%hi($LC0) # high
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	addiu	$9,$2,%lo($LC0)
	lw	$6,0($9)
	lw	$7,4($9)
	lw	$8,8($9)
	sw	$6,32($sp)
	sw	$7,36($sp)
	sw	$8,40($sp)
	lw	$4,1732($23)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GetProfileMask__Fi
	addu	$4,$4,-1
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	lw	$4,1732($23)
	jal	AIWorld_GetProfileMask__Fi
	sw	$2,20($sp)
	lw	$4,1732($23)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GetProfileMask__Fi
	addu	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	lw	$6,1364($23)
	lw	$3,1380($23)
	lh	$19,8($23)
	.set	noreorder
	.set	nomacro
	bgez	$3,$L698
	sw	$6,48($sp)
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
$L698:
	sra	$2,$3,16
	bgez	$2,1f
	subu	$2,$0,$2
1:
	li	$3,715784192			# 0x2aaa0000
	ori	$3,$3,0xaaab
	sll	$2,$2,18
	mult	$2,$3
	sra	$2,$2,31
	lw	$6,48($sp)
	mfhi	$3
	#nop
	#nop
	sra	$3,$3,16
	subu	$20,$3,$2
	mult	$20,$6
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L699
	addu	$17,$19,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L726
	addu	$2,$20,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L726
	subu	$17,$17,$3
	.set	macro
	.set	reorder

$L699:
	bgez	$17,$L700
	lw	$2,gNumSlices
	#nop
	addu	$17,$17,$2
$L700:
	lw	$6,48($sp)
	addu	$2,$20,1
$L726:
	mult	$2,$6
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L703
	addu	$16,$19,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	sll	$2,$19,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L727
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L703:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L727
	sll	$2,$19,5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
	sll	$2,$19,5
$L727:
	lw	$3,BWorldSm_slices
	lw	$5,16($sp)
	addu	$2,$2,$3
	lh	$18,22($2)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L707
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,-655360			# 0xfff60000
	addu	$3,$3,$4
	sw	$3,%lo(CarLogic_gObs)($2)
$L707:
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L708
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,-655360			# 0xfff60000
	addu	$3,$3,$4
	sw	$3,4($2)
$L708:
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,-655360			# 0xfff60000
	addu	$3,$3,$4
	sw	$3,8($2)
$L709:
	lw	$3,BWorldSm_slices
	sll	$2,$17,5
	addu	$2,$2,$3
	lh	$2,22($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L728
	li	$2,73			# 0x00000049
	.set	macro
	.set	reorder

	sll	$2,$16,5
	addu	$2,$2,$3
	lh	$2,22($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L710
	li	$2,73			# 0x00000049
	.set	macro
	.set	reorder

$L728:
	sw	$2,1728($23)
$L710:
	lw	$4,1728($23)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$4,$L697
	sll	$2,$20,2
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	sll	$2,$2,3
	addu	$2,$2,$20
	sll	$2,$2,4
	subu	$2,$2,$20
	sll	$2,$2,2
	addu	$3,$2,$20
	.set	noreorder
	.set	nomacro
	bgez	$3,$L729
	sra	$21,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$21,$3,16
$L729:
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L714
	move	$17,$0
	.set	macro
	.set	reorder

	li	$21,1			# 0x00000001
$L714:
	li	$22,-2621440			# 0xffd80000
	lui	$fp,%hi(CarLogic_gObs) # high
	lw	$2,AI_elapsedTime
	addiu	$18,$fp,%lo(CarLogic_gObs) # low
	subu	$2,$4,$2
	sw	$2,1728($23)
$L715:
	slt	$2,$17,$20
	beq	$2,$0,$L697
	lw	$6,48($sp)
	#nop
	mult	$17,$6
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L718
	addu	$16,$19,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$16,$3
	bne	$2,$0,$L719
	.set	noreorder
	.set	nomacro
	j	$L719
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L718:
	bgez	$16,$L719
	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
$L719:
	lw	$2,32($sp)
	#nop
	beq	$2,$0,$L722
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L722
	lw	$2,%lo(CarLogic_gObs)($fp)
	sw	$0,32($sp)
	addu	$2,$2,$22
	sw	$2,%lo(CarLogic_gObs)($fp)
$L722:
	lw	$2,36($sp)
	#nop
	beq	$2,$0,$L723
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L723
	lw	$2,4($18)
	sw	$0,36($sp)
	addu	$2,$2,$22
	sw	$2,4($18)
$L723:
	lw	$2,40($sp)
	#nop
	beq	$2,$0,$L724
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane_UsingMask__Fii
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L724
	lw	$2,8($18)
	sw	$0,40($sp)
	addu	$2,$2,$22
	sw	$2,8($18)
$L724:
	.set	noreorder
	.set	nomacro
	j	$L715
	addu	$17,$17,$21
	.set	macro
	.set	reorder

$L697:
	lw	$31,92($sp)
	lw	$fp,88($sp)
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

	.end	AI_CheckForBarriers__FP8Car_tObj
	.text
	.ent	AI_SetupOncomingLaneDemerits__FP8Car_tObj
AI_SetupOncomingLaneDemerits__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_IsMellowZone__FP8Car_tObji
	li	$5,3932160			# 0x003c0000
	.set	macro
	.set	reorder

	bne	$2,$0,$L731
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L733
	li	$4,-262144			# 0xfffc0000
	.set	macro
	.set	reorder

	li	$4,-786432			# 0xfff40000
$L733:
	lw	$2,Cars_gNumTrafficCars
	#nop
	bne	$2,$0,$L735
	lw	$2,Cars_gNumCopCars
	#nop
	beq	$2,$0,$L731
$L735:
	lw	$2,AITune_oneWay
	#nop
	bne	$2,$0,$L731
	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0002
	bne	$2,$0,$L731
	lw	$3,1364($16)
	lw	$2,AITune_driveSide
	#nop
	bne	$3,$2,$L736
	lw	$2,1732($16)
	#nop
	addu	$2,$2,-1
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	lui	$3,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(CarLogic_gObs)($3)
	#nop
	addu	$2,$2,$4
	sw	$2,%lo(CarLogic_gObs)($3)
$L737:
	lw	$2,1732($16)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L731
	lui	$3,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(CarLogic_gObs) # low
	lw	$2,4($3)
	#nop
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L731
	sw	$2,4($3)
	.set	macro
	.set	reorder

$L736:
	lw	$2,1732($16)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	lui	$3,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(CarLogic_gObs) # low
	lw	$2,4($3)
	#nop
	addu	$2,$2,$4
	sw	$2,4($3)
$L740:
	lw	$2,1732($16)
	#nop
	addu	$2,$2,1
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L731
	lui	$3,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(CarLogic_gObs) # low
	lw	$2,8($3)
	#nop
	addu	$2,$2,$4
	sw	$2,8($3)
$L731:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_SetupOncomingLaneDemerits__FP8Car_tObj
	.text
	.ent	AI_HandleChangeInNumLanes__FP8Car_tObj
AI_HandleChangeInNumLanes__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,1380($16)
	#nop
	bgez	$4,$L744
	subu	$4,$0,$4
$L744:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,27306			# 0x00006aaa
	.set	macro
	.set	reorder

	move	$3,$2
	bgez	$3,$L745
	li	$2,65535			# 0x0000ffff
	addu	$2,$3,$2
$L745:
	sra	$3,$2,16
	slt	$2,$3,5
	beq	$2,$0,$L746
	li	$3,5			# 0x00000005
$L746:
	lw	$2,1364($16)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	bltz	$3,$L747
	lh	$2,8($16)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L759
	sll	$2,$3,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L749
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L747:
	lh	$2,8($16)
	#nop
	addu	$3,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$3,$L759
	sll	$2,$3,5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L749:
	sll	$2,$3,5
$L759:
	lw	$5,BWorldSm_slices
	li	$6,7			# 0x00000007
	addu	$2,$2,$5
	lbu	$4,29($2)
	lw	$3,1732($16)
	srl	$2,$4,4
	subu	$2,$6,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	andi	$2,$4,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,6
	slt	$2,$2,$3
	beq	$2,$0,$L743
$L753:
	lh	$2,8($16)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$5
	lbu	$4,29($2)
	#nop
	srl	$2,$4,4
	subu	$2,$6,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	andi	$2,$4,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,6
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	slt	$2,$3,7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L756
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,2621440			# 0x00280000
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L743
	sw	$3,8($2)
	.set	macro
	.set	reorder

$L756:
	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,2621440			# 0x00280000
	addu	$3,$3,$4
	sw	$3,%lo(CarLogic_gObs)($2)
$L743:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_HandleChangeInNumLanes__FP8Car_tObj
	.text
	.ent	AI_HandleShouldersAndOffRoad__FP8Car_tObj
AI_HandleShouldersAndOffRoad__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	li	$9,-327680			# 0xfffb0000
	lw	$2,608($7)
	lh	$10,8($7)
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	ori	$9,$9,0x199a
	.set	macro
	.set	reorder

	lui	$2,%hi(AI_Info+4) # high
	lw	$3,%lo(AI_Info+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L761
	li	$9,-2490368			# 0xffda0000
	.set	macro
	.set	reorder

	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	li	$2,524288			# 0x00080000
	.set	macro
	.set	reorder

	lw	$3,1384($3)
	ori	$2,$2,0xe38e
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L782
	sll	$2,$10,5
	.set	macro
	.set	reorder

	li	$9,327680			# 0x00050000
$L761:
	sll	$2,$10,5
$L782:
	lw	$8,BWorldSm_slices
	lw	$3,1732($7)
	addu	$2,$2,$8
	addu	$5,$3,-1
	lbu	$4,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$4,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L763
	andi	$2,$4,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L783
	sll	$2,$10,5
	.set	macro
	.set	reorder

$L763:
	lui	$5,%hi(CarLogic_gObs) # high
	lw	$2,%lo(CarLogic_gObs)($5)
	#nop
	addu	$6,$2,$9
	sw	$6,%lo(CarLogic_gObs)($5)
	lh	$2,8($7)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$8
	lbu	$4,30($2)
	lbu	$3,29($2)
	sll	$4,$4,15
	srl	$3,$3,4
	mult	$4,$3
	lh	$2,24($2)
	#nop
	sll	$2,$2,8
	lw	$3,308($7)
	mflo	$11
	#nop
	#nop
	subu	$2,$2,$11
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L762
	li	$2,-6553600			# 0xff9c0000
	.set	macro
	.set	reorder

	addu	$2,$6,$2
	sw	$2,%lo(CarLogic_gObs)($5)
$L762:
	sll	$2,$10,5
	lw	$8,BWorldSm_slices
$L783:
	lw	$3,1732($7)
	addu	$2,$2,$8
	addu	$5,$3,1
	lbu	$4,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$4,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L766
	andi	$2,$4,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L784
	sll	$2,$10,5
	.set	macro
	.set	reorder

$L766:
	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$5,$2,%lo(CarLogic_gObs) # low
	lw	$2,8($5)
	#nop
	addu	$6,$2,$9
	sw	$6,8($5)
	lh	$2,8($7)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$8
	lbu	$4,31($2)
	lbu	$3,29($2)
	sll	$4,$4,15
	andi	$3,$3,0x000f
	mult	$4,$3
	lh	$2,26($2)
	#nop
	sll	$2,$2,8
	lw	$3,308($7)
	mflo	$11
	#nop
	#nop
	subu	$2,$2,$11
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L765
	li	$2,-6553600			# 0xff9c0000
	.set	macro
	.set	reorder

	addu	$2,$6,$2
	sw	$2,8($5)
$L765:
	sll	$2,$10,5
$L784:
	lw	$6,BWorldSm_slices
	lw	$4,1732($7)
	addu	$2,$2,$6
	lbu	$5,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$5,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L769
	andi	$2,$5,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	bne	$4,$2,$L768
$L769:
	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	#nop
	addu	$3,$3,$9
	sw	$3,4($2)
	lw	$2,1732($7)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	xori	$5,$2,0x0001
	.set	macro
	.set	reorder

	lh	$2,8($7)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$6
	lbu	$4,30($2)
	lbu	$3,29($2)
	sll	$4,$4,15
	srl	$3,$3,4
	mult	$4,$3
	lh	$2,24($2)
	#nop
	sll	$2,$2,8
	lw	$3,308($7)
	mflo	$11
	#nop
	#nop
	subu	$2,$2,$11
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L785
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

$L770:
	beq	$5,$0,$L768
	lh	$2,8($7)
	#nop
	sll	$2,$2,5
	addu	$2,$2,$6
	lbu	$4,31($2)
	lbu	$3,29($2)
	sll	$4,$4,15
	andi	$3,$3,0x000f
	mult	$4,$3
	lh	$2,26($2)
	#nop
	sll	$2,$2,8
	lw	$3,308($7)
	mflo	$11
	#nop
	#nop
	subu	$2,$2,$11
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

$L785:
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,-6553600			# 0xff9c0000
	addu	$3,$3,$4
	sw	$3,4($2)
$L768:
	lw	$3,BWorldSm_slices
	sll	$2,$10,5
	addu	$2,$2,$3
	lw	$3,1732($7)
	lbu	$4,29($2)
	li	$2,6			# 0x00000006
	addu	$5,$3,-1
	srl	$3,$4,4
	subu	$2,$2,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L786
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	andi	$2,$4,0x000f
	addu	$2,$2,7
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L775
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

$L786:
	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,-65536000			# 0xfc180000
	addu	$3,$3,$4
	sw	$3,%lo(CarLogic_gObs)($2)
$L775:
	sll	$2,$10,5
	lw	$3,BWorldSm_slices
	lw	$4,1732($7)
	addu	$2,$2,$3
	lbu	$5,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$5,4
	subu	$2,$2,$3
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	andi	$2,$5,0x000f
	addu	$2,$2,7
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L777
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

$L787:
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,-65536000			# 0xfc180000
	addu	$3,$3,$4
	sw	$3,4($2)
$L777:
	lw	$3,BWorldSm_slices
	sll	$2,$10,5
	addu	$2,$2,$3
	lw	$3,1732($7)
	lbu	$4,29($2)
	li	$2,6			# 0x00000006
	addu	$5,$3,1
	srl	$3,$4,4
	subu	$2,$2,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L788
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	andi	$2,$4,0x000f
	addu	$2,$2,7
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L789
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

$L788:
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,-65536000			# 0xfc180000
	addu	$3,$3,$4
	sw	$3,8($2)
$L789:
	j	$31
	.end	AI_HandleShouldersAndOffRoad__FP8Car_tObj
	.text
	.ent	AI_CalculateLaneSpeeds__FP8Car_tObj
AI_CalculateLaneSpeeds__FP8Car_tObj:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	move	$17,$0
	sw	$21,44($sp)
	move	$21,$17
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$16,24($sp)
	lw	$2,1264($18)
	move	$20,$17
	lw	$2,8($2)
	lui	$4,%hi(AI_Info) # high
	sw	$2,20($sp)
	lw	$3,1372($18)
	addiu	$2,$4,%lo(AI_Info) # low
	sw	$3,36($2)
	sw	$3,24($2)
	lw	$3,1372($18)
	move	$19,$2
	sw	$3,40($2)
	sw	$3,28($2)
	lw	$3,1372($18)
	li	$2,1			# 0x00000001
	sw	$3,44($19)
	sw	$3,32($19)
	lw	$3,1732($18)
	lw	$8,604($18)
	addu	$4,$3,-1
	sll	$fp,$2,$4
	sll	$23,$2,$3
	addu	$3,$3,$2
	sll	$22,$2,$3
	sw	$8,16($sp)
$L791:
	li	$2,3			# 0x00000003
	beq	$20,$2,$L790
	lw	$3,Cars_gNumCars
	#nop
	slt	$2,$21,$3
	beq	$2,$0,$L790
	lw	$2,1364($18)
	#nop
	mult	$21,$2
	lw	$8,16($sp)
	mflo	$6
	#nop
	#nop
	addu	$2,$8,$6
	addu	$2,$2,$3
	rem	$3,$2,$3
	lui	$8,%hi(Cars_gSortedList) # high
	addiu	$8,$8,%lo(Cars_gSortedList) # low
	sll	$3,$3,2
	addu	$3,$3,$8
	lw	$16,0($3)
	#nop
	beq	$18,$16,$L796
	lbu	$2,145($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L796
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$18
	.set	macro
	.set	reorder

	move	$5,$2
	lw	$2,1364($18)
	#nop
	mult	$5,$2
	li	$4,1441792			# 0x00160000
	lw	$3,1380($18)
	ori	$4,$4,0x38e2
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$4,$4,$3
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L797
	li	$6,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$6,54613			# 0x0000d555
	.set	noreorder
	.set	nomacro
	j	$L798
	li	$4,26214			# 0x00006666
	.set	macro
	.set	reorder

$L797:
	ori	$6,$6,0x4000
	li	$4,36408			# 0x00008e38
$L798:
	li	$2,917504			# 0x000e0000
	ori	$2,$2,0xffff
	slt	$2,$2,$7
	bne	$2,$0,$L799
	li	$6,10922			# 0x00002aaa
	li	$4,6553			# 0x00001999
$L799:
	lw	$2,316($18)
	#nop
	slt	$2,$2,$7
	beq	$2,$0,$L796
	lw	$8,20($sp)
	#nop
	slt	$2,$7,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L796
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,1364($18)
	#nop
	bne	$3,$2,$L801
	.set	noreorder
	.set	nomacro
	bgez	$5,$L802
	move	$3,$5
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$5,$2
$L802:
	sra	$3,$3,16
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0028
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L803
	addu	$3,$3,-2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$3,$L809
	move	$2,$3
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L803:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L809
	move	$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L809
	move	$2,$0
	.set	macro
	.set	reorder

$L801:
	move	$3,$5
	.set	noreorder
	.set	nomacro
	bgez	$3,$L807
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L807:
	sra	$3,$3,16
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0028
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L808
	addu	$3,$3,2
	.set	macro
	.set	reorder

	slt	$2,$3,2
	bne	$2,$0,$L808
	li	$3,-1			# 0xffffffff
$L808:
	.set	noreorder
	.set	nomacro
	blez	$3,$L809
	move	$2,$3
	.set	macro
	.set	reorder

	move	$2,$0
$L809:
	move	$3,$2
	mult	$3,$6
	mflo	$6
	#nop
	#nop
	mult	$3,$4
	lw	$2,1356($16)
	lw	$3,1380($16)
	and	$2,$2,$23
	addu	$5,$3,$6
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L810
	addu	$3,$3,$4
	.set	macro
	.set	reorder

	and	$2,$17,$23
	bne	$2,$0,$L810
	or	$17,$17,$23
	addu	$20,$20,1
	sw	$5,28($19)
	sw	$3,40($19)
	sw	$16,4($19)
	sw	$7,16($19)
$L810:
	lw	$2,1732($18)
	#nop
	addu	$2,$2,-1
	sltu	$2,$2,14
	beq	$2,$0,$L811
	lw	$2,1356($16)
	#nop
	and	$2,$2,$fp
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L811
	and	$2,$17,$fp
	.set	macro
	.set	reorder

	bne	$2,$0,$L811
	or	$17,$17,$fp
	addu	$20,$20,1
	lui	$8,%hi(AI_Info) # high
	sw	$5,24($19)
	sw	$3,36($19)
	sw	$16,%lo(AI_Info)($8)
	sw	$7,12($19)
$L811:
	lw	$2,1732($18)
	#nop
	addu	$2,$2,1
	sltu	$2,$2,14
	beq	$2,$0,$L796
	lw	$2,1356($16)
	#nop
	and	$2,$2,$22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L796
	and	$2,$17,$22
	.set	macro
	.set	reorder

	bne	$2,$0,$L796
	or	$17,$17,$22
	addu	$20,$20,1
	sw	$5,32($19)
	sw	$3,44($19)
	sw	$16,8($19)
	sw	$7,20($19)
$L796:
	.set	noreorder
	.set	nomacro
	j	$L791
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L790:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	AI_CalculateLaneSpeeds__FP8Car_tObj
	.text
	.ent	AI_CalcMeritsBasedOnSpeed__FP8Car_tObj
AI_CalcMeritsBasedOnSpeed__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$19,1372($16)
	lw	$18,1380($16)
	jal	AIWorld_GameOdometer__FP8Car_tObj
	li	$3,39256064			# 0x02570000
	ori	$3,$3,0xffff
	slt	$20,$3,$2
	lui	$2,%hi(AI_Info) # high
	lw	$3,%lo(AI_Info)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L843
	addiu	$4,$2,%lo(AI_Info) # low
	.set	macro
	.set	reorder

	li	$2,1900544			# 0x001d0000
	lw	$3,12($4)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L843
	lui	$2,%hi(AI_Info) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(CarLogic_gObs) # high
	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,-917504			# 0xfff20000
	addu	$3,$3,$4
	sw	$3,%lo(CarLogic_gObs)($2)
	lui	$2,%hi(AI_Info) # high
$L843:
	addiu	$3,$2,%lo(AI_Info) # low
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L818
	li	$2,1900544			# 0x001d0000
	.set	macro
	.set	reorder

	lw	$3,16($3)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L844
	lui	$2,%hi(AI_Info) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,-917504			# 0xfff20000
	addu	$3,$3,$4
	sw	$3,4($2)
$L818:
	lui	$2,%hi(AI_Info) # high
$L844:
	addiu	$3,$2,%lo(AI_Info) # low
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	li	$2,1900544			# 0x001d0000
	.set	macro
	.set	reorder

	lw	$3,20($3)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L819
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,-917504			# 0xfff20000
	addu	$3,$3,$4
	sw	$3,8($2)
$L819:
	lw	$3,1364($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L820
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	addiu	$16,$2,%lo(CarLogic_gObs) # low
	move	$21,$16
	lui	$2,%hi(AI_Info) # high
	addiu	$17,$2,%lo(AI_Info) # low
$L821:
	lw	$3,24($17)
	#nop
	slt	$2,$18,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L845
	slt	$2,$19,$3
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L824
	subu	$4,$18,$3
	.set	macro
	.set	reorder

	li	$5,-131072			# 0xfffe0000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0xb334
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
	lw	$3,24($17)
$L824:
	slt	$2,$19,$3
$L845:
	bne	$2,$0,$L826
	lw	$2,0($17)
	#nop
	beq	$2,$0,$L826
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L826
	subu	$4,$19,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L826:
	lw	$3,36($17)
	#nop
	slt	$2,$18,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L846
	slt	$2,$19,$3
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L827
	subu	$4,$18,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
	lw	$3,36($17)
$L827:
	slt	$2,$19,$3
$L846:
	bne	$2,$0,$L829
	lw	$2,0($17)
	#nop
	beq	$2,$0,$L829
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L829
	subu	$4,$19,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-6553			# 0xffffe667
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L829:
	addu	$16,$16,4
	addu	$2,$21,12
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L821
	addu	$17,$17,4
	.set	macro
	.set	reorder

	j	$L816
$L820:
	addiu	$16,$2,%lo(CarLogic_gObs) # low
	move	$20,$16
	lui	$2,%hi(AI_Info) # high
	addiu	$17,$2,%lo(AI_Info) # low
$L832:
	lw	$4,24($17)
	#nop
	slt	$2,$4,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L847
	slt	$2,$4,$19
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L836
	subu	$4,$4,$18
	.set	macro
	.set	reorder

	li	$5,-131072			# 0xfffe0000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0xb334
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L836:
	lw	$4,24($17)
	#nop
	slt	$2,$4,$19
$L847:
	bne	$2,$0,$L837
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L837
	subu	$4,$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L837:
	lw	$4,36($17)
	#nop
	slt	$2,$4,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L848
	slt	$2,$4,$19
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	subu	$4,$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L839:
	lw	$4,36($17)
	#nop
	slt	$2,$4,$19
$L848:
	bne	$2,$0,$L840
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L840
	subu	$4,$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,-6553			# 0xffffe667
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	addu	$3,$3,$2
	sw	$3,0($16)
$L840:
	addu	$16,$16,4
	addu	$2,$20,12
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L816:
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

	.end	AI_CalcMeritsBasedOnSpeed__FP8Car_tObj
	.text
	.ent	AI_CheckForClearLanes__FP8Car_tObj
AI_CheckForClearLanes__FP8Car_tObj:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$19,44($sp)
	move	$19,$4
	sw	$17,36($sp)
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$16,32($sp)
	lw	$2,608($19)
	lw	$16,604($19)
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	move	$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_IsMellowZone__FP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L849
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	sw	$2,20($sp)
	sw	$2,16($sp)
	lw	$20,1364($19)
	#nop
	mult	$20,$20
	move	$18,$17
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$fp,$2,%lo(Cars_gSortedList) # low
	li	$22,1			# 0x00000001
	move	$23,$20
	mflo	$7
	#nop
	#nop
	addu	$21,$7,$16
$L862:
	lw	$3,Cars_gNumCars
	#nop
	slt	$2,$20,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L852
	addu	$2,$21,$3
	.set	macro
	.set	reorder

	rem	$3,$2,$3
	sll	$3,$3,2
	addu	$3,$3,$fp
	lw	$16,0($3)
	#nop
	beq	$19,$16,$L856
	lbu	$2,145($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L856
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$19
	.set	macro
	.set	reorder

	li	$3,7143424			# 0x006d0000
	ori	$3,$3,0xffff
	li	$4,262144			# 0x00040000
	addu	$2,$2,$4
	sltu	$3,$3,$2
	bne	$3,$0,$L856
	lw	$2,1356($16)
	lw	$3,1732($19)
	#nop
	sra	$2,$2,$3
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L864
	sra	$2,$17,$3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	bne	$2,$0,$L864
	sw	$0,20($sp)
	lw	$2,1732($19)
	addu	$18,$18,1
	sll	$2,$22,$2
	or	$17,$17,$2
	lw	$3,1732($19)
$L864:
	.set	noreorder
	.set	nomacro
	blez	$3,$L860
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	lw	$2,1356($16)
	#nop
	sra	$2,$2,$3
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L860
	sra	$2,$17,$3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	bne	$2,$0,$L860
	sw	$0,16($sp)
	lw	$2,1732($19)
	addu	$18,$18,1
	addu	$2,$2,-1
	sll	$2,$22,$2
	or	$17,$17,$2
$L860:
	lw	$2,1732($19)
	#nop
	addu	$3,$2,1
	sltu	$2,$3,14
	beq	$2,$0,$L856
	lw	$2,1356($16)
	#nop
	sra	$2,$2,$3
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L856
	sra	$2,$17,$3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	bne	$2,$0,$L856
	sw	$0,24($sp)
	lw	$2,1732($19)
	addu	$18,$18,1
	addu	$2,$2,1
	sll	$2,$22,$2
	or	$17,$17,$2
$L856:
	addu	$21,$21,$23
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L862
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L852:
	lui	$3,%hi(CarLogic_gObs) # high
	lw	$2,%lo(CarLogic_gObs)($3)
	lw	$4,16($sp)
	lw	$5,20($sp)
	lw	$6,24($sp)
	addu	$2,$2,$4
	sw	$2,%lo(CarLogic_gObs)($3)
	addiu	$3,$3,%lo(CarLogic_gObs) # low
	lw	$2,4($3)
	lw	$4,8($3)
	addu	$2,$2,$5
	addu	$4,$4,$6
	sw	$2,4($3)
	sw	$4,8($3)
$L849:
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

	.end	AI_CheckForClearLanes__FP8Car_tObj
	.text
	.ent	AI_CalcBestLineMerits__FP8Car_tObj
AI_CalcBestLineMerits__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,608($16)
	lw	$3,1880($16)
	andi	$2,$2,0x0008
	beq	$2,$0,$L865
	lw	$2,AIDataRecord_BestLine
	#nop
	lw	$2,72($2)
	#nop
	addu	$2,$2,$3
	lw	$3,1264($16)
	lb	$5,0($2)
	lw	$4,68($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,14
	.set	macro
	.set	reorder

	lw	$4,1388($16)
	lw	$3,1364($16)
	#nop
	mult	$4,$3
	sw	$2,1820($16)
	li	$3,327680			# 0x00050000
	sw	$3,1824($16)
	mflo	$6
	#nop
	#nop
	subu	$2,$2,$6
	sw	$2,1820($16)
$L865:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_CalcBestLineMerits__FP8Car_tObj
	.text
	.ent	AI_AddCollidableObjects__FP8Car_tObjP5Group
AI_AddCollidableObjects__FP8Car_tObjP5Group:
	.frame	$sp,96,$31		# vars= 48, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lbu	$2,firstTime.273
	subu	$sp,$sp,96
	sw	$17,76($sp)
	move	$17,$4
	sw	$20,88($sp)
	move	$20,$5
	sw	$16,72($sp)
	addu	$16,$20,4
	sw	$31,92($sp)
	sw	$19,84($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L869
	sw	$18,80($sp)
	.set	macro
	.set	reorder

	sb	$0,firstTime.273
	move	$4,$0
	lui	$5,%hi(spos.272) # high
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	addiu	$5,$5,%lo(spos.272) # low
	.set	macro
	.set	reorder

$L869:
	move	$18,$0
	lui	$19,%hi(spos.272) # high
$L872:
	lw	$2,0($20)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L868
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sw	$2,24($sp)
	lw	$2,4($16)
	#nop
	sw	$2,28($sp)
	lw	$2,8($16)
	addiu	$5,$19,%lo(spos.272) # low
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	lh	$4,%lo(spos.272)($19)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FiP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$3,1364($17)
	#nop
	mult	$2,$3
	li	$3,6488064			# 0x00630000
	ori	$3,$3,0xfffe
	mflo	$9
	#nop
	#nop
	addu	$2,$9,-1
	sltu	$3,$3,$2
	bne	$3,$0,$L874
	lh	$2,8($17)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$10,0($2)
	lw	$11,4($2)
	lw	$12,8($2)
	sw	$10,40($sp)
	sw	$11,44($sp)
	sw	$12,48($sp)
	lw	$3,24($sp)
	lw	$2,40($sp)
	lw	$4,28($sp)
	lw	$5,32($sp)
	subu	$7,$3,$2
	lw	$2,44($sp)
	lw	$3,48($sp)
	sw	$7,56($sp)
	subu	$4,$4,$2
	subu	$5,$5,$3
	sw	$4,60($sp)
	sw	$5,64($sp)
	lw	$6,324($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L884
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L884:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L876
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L876:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($17)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L885
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L885:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L878
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L878:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,332($17)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L879
	addu	$6,$6,$9
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L879:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L880
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L880:
	sra	$2,$2,8
	mult	$3,$2
	li	$5,-851968			# 0xfff30000
	lbu	$3,19($16)
	li	$2,1			# 0x00000001
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L881
	addu	$8,$6,$9
	.set	macro
	.set	reorder

	li	$5,-2621440			# 0xffd80000
$L881:
	move	$4,$17
	lh	$7,12($16)
	lh	$2,%lo(spos.272)($19)
	sll	$7,$7,9
	subu	$6,$8,$7
	addu	$7,$8,$7
	.set	noreorder
	.set	nomacro
	jal	AI_SubmitObstacle__FP8Car_tObjiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L874:
	addu	$16,$16,20
	.set	noreorder
	.set	nomacro
	j	$L872
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L868:
	lw	$31,92($sp)
	lw	$20,88($sp)
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

	.end	AI_AddCollidableObjects__FP8Car_tObjP5Group
	.text
	.ent	AI_AvoidObjects__FP8Car_tObj
AI_AvoidObjects__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Object_customObjInst
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L886
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$5,Object_customSimObjs
	jal	AI_AddCollidableObjects__FP8Car_tObjP5Group
$L886:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_AvoidObjects__FP8Car_tObj
	.text
	.ent	AI_AvoidSpikeBelt__FP8Car_tObj
AI_AvoidSpikeBelt__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 16, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,40($sp)
	move	$16,$4
	addu	$4,$sp,24
	addu	$5,$sp,28
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorld_GetSpikeBelt__FPiN20
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	beq	$2,$0,$L889
	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FiP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,1364($16)
	#nop
	mult	$2,$3
	li	$2,6488064			# 0x00630000
	ori	$2,$2,0xfffe
	mflo	$8
	#nop
	#nop
	addu	$3,$8,-1
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L889
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,-2621440			# 0xffd80000
	lw	$6,28($sp)
	lw	$7,32($sp)
	lw	$2,24($sp)
	addu	$7,$6,$7
	.set	noreorder
	.set	nomacro
	jal	AI_SubmitObstacle__FP8Car_tObjiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L889:
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AI_AvoidSpikeBelt__FP8Car_tObj
	.text
	.ent	AI_SubmitObstacle__FP8Car_tObjiiii
AI_SubmitObstacle__FP8Car_tObjiiii:
	.frame	$sp,56,$31		# vars= 16, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$4
	sw	$18,40($sp)
	move	$18,$5
	sw	$19,44($sp)
	move	$19,$6
	sw	$20,48($sp)
	move	$20,$7
	addu	$4,$sp,16
	move	$5,$0
	sw	$16,32($sp)
	lw	$16,72($sp)
	sw	$31,52($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	sltu	$2,$4,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L893
	sltu	$2,$16,14
	.set	macro
	.set	reorder

	beq	$2,$0,$L893
	lw	$2,1732($17)
	#nop
	addu	$3,$2,-1
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L895
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	bne	$2,$0,$L895
	sw	$18,16($sp)
$L895:
	lw	$3,1732($17)
	#nop
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L896
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	bne	$2,$0,$L896
	sw	$18,20($sp)
$L896:
	lw	$2,1732($17)
	#nop
	addu	$3,$2,1
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L897
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	bne	$2,$0,$L897
	sw	$18,24($sp)
$L897:
	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L902
	lui	$3,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	beq	$2,$0,$L902
	lw	$2,24($sp)
	#nop
	beq	$2,$0,$L902
	lw	$2,1396($17)
	#nop
	subu	$3,$2,$19
	subu	$2,$2,$20
	bgez	$3,1f
	subu	$3,$0,$3
1:
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	beq	$3,$0,$L899
	.set	noreorder
	.set	nomacro
	j	$L898
	sw	$0,16($sp)
	.set	macro
	.set	reorder

$L899:
	sw	$0,24($sp)
$L898:
	lui	$3,%hi(CarLogic_gObs) # high
$L902:
	lw	$2,%lo(CarLogic_gObs)($3)
	lw	$4,16($sp)
	lw	$5,20($sp)
	lw	$6,24($sp)
	addu	$2,$2,$4
	sw	$2,%lo(CarLogic_gObs)($3)
	addiu	$3,$3,%lo(CarLogic_gObs) # low
	lw	$2,4($3)
	lw	$4,8($3)
	addu	$2,$2,$5
	addu	$4,$4,$6
	sw	$2,4($3)
	sw	$4,8($3)
$L893:
	lw	$31,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AI_SubmitObstacle__FP8Car_tObjiiii
	.text
	.ent	AI_HandleTrafficHonking__FP8Car_tObj
AI_HandleTrafficHonking__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsCarInAnyVisibleArea__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$3,608($16)
	#nop
	andi	$3,$3,0x0010
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L903
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$2,D_8011321C
	lw	$3,1364($16)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L905
	nor	$2,$0,$3
	.set	macro
	.set	reorder

	xori	$2,$3,0x0001
$L905:
	sltu	$2,$0,$2
	beq	$2,$0,$L903
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L903
	lui	$2,%hi(AI_Info+28) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(AI_Info+28)($2)
	li	$2,-196608			# 0xfffd0000
	slt	$2,$2,$3
	beq	$2,$0,$L903
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	andi	$2,$3,0xffff
	sw	$3,randtemp
	srl	$3,$3,8
	andi	$3,$3,0xffff
	sw	$2,fastRandom
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$4,$2,16
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L903
	slt	$2,$4,5
	.set	macro
	.set	reorder

	beq	$2,$0,$L903
	lw	$2,1380($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L903
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	li	$6,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	jal	AudioClc_HonkHorn__FP8Car_tObjiii
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

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

	.end	AI_HandleTrafficHonking__FP8Car_tObj
	.text
	.ent	AI_CheckForCarsOnSide__FP8Car_tObj
AI_CheckForCarsOnSide__FP8Car_tObj:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,608($19)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L911
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,316($19)
	#nop
	sll	$4,$2,1
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,Cars_gNumCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L911
	addu	$23,$4,$2
	.set	macro
	.set	reorder

	li	$22,-393216			# 0xfffa0000
	lui	$20,%hi(CarLogic_gObs) # high
	addiu	$21,$20,%lo(CarLogic_gObs) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$18,$2,%lo(Cars_gList) # low
$L916:
	lw	$16,0($18)
	#nop
	beq	$19,$16,$L915
	lbu	$2,145($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L915
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L915
	slt	$2,$3,$23
	.set	macro
	.set	reorder

	beq	$2,$0,$L915
	lw	$3,1732($19)
	lw	$4,1732($16)
	addu	$2,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L919
	addu	$2,$3,1
	.set	macro
	.set	reorder

	lw	$2,%lo(CarLogic_gObs)($20)
	#nop
	addu	$2,$2,$22
	.set	noreorder
	.set	nomacro
	j	$L915
	sw	$2,%lo(CarLogic_gObs)($20)
	.set	macro
	.set	reorder

$L919:
	bne	$4,$2,$L915
	lw	$2,8($21)
	#nop
	addu	$2,$2,$22
	sw	$2,8($21)
$L915:
	lw	$2,Cars_gNumCars
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L916
	addu	$18,$18,4
	.set	macro
	.set	reorder

$L911:
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

	.end	AI_CheckForCarsOnSide__FP8Car_tObj
	.text
	.ent	AI_ProcessObservationsAndChooseLane__FP8Car_tObj
AI_ProcessObservationsAndChooseLane__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$5,$2,%lo(CarLogic_gObs) # low
	lw	$2,%lo(CarLogic_gObs)($2)
	lui	$3,%hi(AI_Info) # high
	sw	$31,16($sp)
	lw	$6,4($5)
	lw	$5,8($5)
	addiu	$3,$3,%lo(AI_Info) # low
	sw	$2,48($3)
	sw	$6,52($3)
	.set	noreorder
	.set	nomacro
	jal	AI_ChooseBestLane__FP8Car_tObj
	sw	$5,56($3)
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

	.end	AI_ProcessObservationsAndChooseLane__FP8Car_tObj
	.text
	.ent	AI_ChooseBestLane__FP8Car_tObj
AI_ChooseBestLane__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(AI_Info) # high
	addiu	$5,$2,%lo(AI_Info) # low
	lw	$6,52($5)
	lw	$3,1732($4)
	lw	$7,48($5)
	li	$2,1			# 0x00000001
	sw	$2,64($5)
	slt	$2,$6,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L927
	sw	$3,60($5)
	.set	macro
	.set	reorder

	lw	$2,1732($4)
	move	$6,$7
	sw	$0,64($5)
	addu	$2,$2,-1
	sw	$2,60($5)
$L927:
	lw	$2,56($5)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L928
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,1732($4)
	sw	$3,64($5)
	addu	$2,$2,1
	sw	$2,60($5)
$L928:
	lw	$2,60($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L929
	slt	$2,$2,14
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,60($5)
	.set	macro
	.set	reorder

$L929:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	li	$2,13			# 0x0000000d
	.set	macro
	.set	reorder

	sw	$2,60($5)
$L932:
	j	$31
	.end	AI_ChooseBestLane__FP8Car_tObj
	.text
	.ent	AI_CheckPreferredLateralPosition__FP8Car_tObj
AI_CheckPreferredLateralPosition__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 16, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	lw	$5,1820($16)
	lw	$2,308($16)
	lh	$4,8($16)
	subu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	addu	$5,$5,-16384
	.set	macro
	.set	reorder

	lw	$3,1732($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L934
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L935
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

$L934:
	xori	$2,$2,0x0001
	sll	$18,$2,1
$L935:
	lui	$2,%hi(AI_Info) # high
	addiu	$2,$2,%lo(AI_Info) # low
	lw	$3,48($2)
	lw	$4,52($2)
	lw	$2,56($2)
	#nop
	sw	$2,24($sp)
	sll	$2,$18,2
	sw	$3,16($sp)
	addu	$3,$sp,16
	addu	$3,$3,$2
	sw	$4,20($sp)
	lw	$2,0($3)
	lw	$4,1824($16)
	#nop
	addu	$2,$2,$4
	sw	$2,0($3)
	lw	$3,16($sp)
	lw	$4,20($sp)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L938
	move	$17,$0
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
	move	$3,$4
$L938:
	lw	$2,24($sp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L939
	li	$17,2			# 0x00000002
$L939:
	lw	$5,1820($16)
	lw	$2,308($16)
	lh	$4,8($16)
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	addu	$5,$5,16384
	.set	macro
	.set	reorder

	lw	$3,1732($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L940
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L941
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L940:
	xori	$2,$2,0x0001
	sll	$6,$2,1
$L941:
	lui	$2,%hi(AI_Info) # high
	addiu	$2,$2,%lo(AI_Info) # low
	lw	$3,48($2)
	lw	$4,52($2)
	lw	$2,56($2)
	#nop
	sw	$2,24($sp)
	sll	$2,$6,2
	sw	$3,16($sp)
	addu	$3,$sp,16
	addu	$3,$3,$2
	sw	$4,20($sp)
	lw	$2,0($3)
	lw	$4,1824($16)
	#nop
	addu	$2,$2,$4
	sw	$2,0($3)
	lw	$3,16($sp)
	lw	$5,20($sp)
	#nop
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L944
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$3,$5
$L944:
	lw	$2,24($sp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L945
	li	$4,2			# 0x00000002
$L945:
	.set	noreorder
	.set	nomacro
	bne	$17,$18,$L948
	move	$2,$0
	.set	macro
	.set	reorder

	bne	$4,$6,$L948
	lw	$3,1820($16)
	li	$2,1			# 0x00000001
	sw	$3,1368($16)
$L948:
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

	.end	AI_CheckPreferredLateralPosition__FP8Car_tObj
	.text
	.ent	AI_TryToShareLanes__FP8Car_tObjT0
AI_TryToShareLanes__FP8Car_tObjT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$4
	lui	$3,%hi(AI_Info+60) # high
	lw	$4,308($9)
	lw	$6,%lo(AI_Info+60)($3)
	srl	$2,$4,31
	addu	$2,$4,$2
	sra	$2,$2,1
	addu	$4,$4,$2
	slt	$2,$6,7
	bne	$2,$0,$L950
	lh	$2,8($5)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,31($2)
	addu	$3,$6,-7
	sll	$2,$2,15
	mult	$3,$2
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	j	$L951
	addu	$7,$6,$2
	.set	macro
	.set	reorder

$L950:
	lh	$2,8($5)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,30($2)
	addu	$3,$6,-6
	sll	$2,$2,15
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	subu	$6,$7,$2
$L951:
	lw	$3,1396($5)
	lw	$2,620($5)
	#nop
	subu	$8,$3,$2
	subu	$5,$8,$6
	addu	$6,$3,$2
	subu	$3,$7,$6
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L959
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L952
	slt	$2,$5,$3
	.set	macro
	.set	reorder

$L959:
	beq	$2,$0,$L954
	srl	$2,$3,31
	addu	$2,$3,$2
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L958
	addu	$2,$6,$2
	.set	macro
	.set	reorder

$L954:
	srl	$2,$5,31
	addu	$2,$5,$2
	sra	$2,$2,1
	subu	$2,$8,$2
$L958:
	sw	$2,1368($9)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L952:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	AI_TryToShareLanes__FP8Car_tObjT0
	.text
	.ent	AI_CalculateDesiredLatPosition__FP8Car_tObj
AI_CalculateDesiredLatPosition__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(AI_Info) # high
	addiu	$2,$2,%lo(AI_Info) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$3,64($2)
	lh	$19,8($16)
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,1824($16)
	lw	$17,0($3)
	blez	$2,$L961
	jal	AI_CheckPreferredLateralPosition__FP8Car_tObj
	li	$3,1			# 0x00000001
	beq	$2,$3,$L960
$L961:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L966
	move	$18,$0
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L963
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	li	$3,1245184			# 0x00130000
	ori	$3,$3,0xffff
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L983
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L966
$L963:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	li	$3,1245184			# 0x00130000
	ori	$3,$3,0xffff
	subu	$2,$0,$2
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L966
	move	$4,$16
	.set	macro
	.set	reorder

$L983:
	.set	noreorder
	.set	nomacro
	jal	AI_IsMellowZone__FP8Car_tObji
	li	$5,65536000			# 0x03e80000
	.set	macro
	.set	reorder

	bne	$2,$0,$L966
	li	$18,1			# 0x00000001
$L966:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L970
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AI_TryToShareLanes__FP8Car_tObjT0
	move	$5,$17
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	beq	$2,$3,$L960
$L970:
	lw	$3,BWorldSm_slices
	sll	$2,$19,5
	addu	$5,$2,$3
	lui	$3,%hi(AI_Info+60) # high
	li	$2,6			# 0x00000006
	lbu	$6,29($5)
	lw	$3,%lo(AI_Info+60)($3)
	srl	$4,$6,4
	subu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L972
	andi	$2,$6,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L971
	slt	$2,$3,7
	.set	macro
	.set	reorder

$L972:
	slt	$2,$3,7
	beq	$2,$0,$L973
	lbu	$2,30($5)
	addu	$3,$3,-6
	sll	$2,$2,15
	mult	$3,$2
	lw	$2,308($16)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	j	$L981
	subu	$2,$7,$2
	.set	macro
	.set	reorder

$L973:
	lbu	$2,31($5)
	addu	$3,$3,-7
	sll	$2,$2,15
	mult	$3,$2
	lw	$2,308($16)
	j	$L982
$L971:
	beq	$2,$0,$L976
	lbu	$2,30($5)
	addu	$3,$3,-6
	sll	$2,$2,15
	mult	$3,$2
	srl	$2,$2,1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	j	$L981
	subu	$2,$7,$2
	.set	macro
	.set	reorder

$L976:
	lbu	$2,31($5)
	addu	$3,$3,-7
	sll	$2,$2,15
	mult	$3,$2
	srl	$2,$2,1
$L982:
	mflo	$7
	#nop
	#nop
	addu	$2,$7,$2
$L981:
	sw	$2,1368($16)
	sll	$5,$19,5
	lw	$2,BWorldSm_slices
	lw	$4,308($16)
	addu	$2,$5,$2
	lh	$3,26($2)
	lw	$2,1368($16)
	sll	$3,$3,8
	subu	$3,$3,$4
	slt	$2,$3,$2
	beq	$2,$0,$L978
	sw	$3,1368($16)
$L978:
	lw	$2,BWorldSm_slices
	lw	$4,308($16)
	addu	$2,$5,$2
	lh	$3,24($2)
	lw	$2,1368($16)
	sll	$3,$3,8
	subu	$4,$4,$3
	slt	$2,$2,$4
	beq	$2,$0,$L960
	sw	$4,1368($16)
$L960:
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

	.end	AI_CalculateDesiredLatPosition__FP8Car_tObj
	.text
	.ent	AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	lui	$2,%hi(AI_Info) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(AI_Info) # low
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	lw	$3,60($16)
	lw	$2,1732($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1015
	lui	$2,%hi(AI_Info+28) # high
	.set	macro
	.set	reorder

	lw	$5,4($16)
	#nop
	beq	$5,$0,$L1015
	lhu	$2,382($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1015
	lui	$2,%hi(AI_Info+28) # high
	.set	macro
	.set	reorder

	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	blez	$2,$L988
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	move	$20,$2
	.set	macro
	.set	reorder

$L988:
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$4,$17
	.set	macro
	.set	reorder

	subu	$20,$0,$2
$L989:
	lui	$2,%hi(AI_Info+4) # high
	lw	$2,%lo(AI_Info+4)($2)
	lw	$3,1380($17)
	lw	$2,1380($2)
	#nop
	subu	$18,$3,$2
	bgtz	$18,$L990
	subu	$18,$2,$3
$L990:
	lw	$3,1368($17)
	lw	$2,1396($17)
	#nop
	subu	$16,$3,$2
	bgtz	$16,$L991
	subu	$16,$2,$3
$L991:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcLateralVelocity__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	blez	$2,$L992
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcLateralVelocity__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L993
	move	$19,$2
	.set	macro
	.set	reorder

$L992:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcLateralVelocity__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	subu	$19,$0,$2
$L993:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x3333
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L987
	lui	$2,%hi(AI_Info) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(AI_Info) # low
	lw	$3,60($4)
	lw	$2,1732($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L995
	lw	$4,32($4)
	j	$L998
$L995:
	lw	$4,24($4)
	j	$L998
$L987:
	lui	$2,%hi(AI_Info+28) # high
$L1015:
	lw	$4,%lo(AI_Info+28)($2)
$L998:
	lw	$3,1364($17)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L999
	lw	$2,1372($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1016
	li	$3,-131072			# 0xfffe0000
	.set	macro
	.set	reorder

	sw	$4,1372($17)
$L1016:
	lw	$2,1372($17)
	ori	$3,$3,0xb334
	.set	noreorder
	.set	nomacro
	j	$L1014
	slt	$2,$2,$3
	.set	macro
	.set	reorder

$L999:
	lw	$2,1372($17)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1017
	li	$3,65536			# 0x00010000
	.set	macro
	.set	reorder

	sw	$4,1372($17)
$L1017:
	lw	$2,1372($17)
	ori	$3,$3,0x4ccc
	slt	$2,$3,$2
$L1014:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1018
	lui	$2,%hi(AI_Info) # high
	.set	macro
	.set	reorder

	sw	$3,1372($17)
$L1018:
	addiu	$4,$2,%lo(AI_Info) # low
	lw	$3,60($4)
	lw	$2,1732($17)
	#nop
	beq	$3,$2,$L986
	lw	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L986
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

	lw	$2,1380($2)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L986
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,1364($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1007
	li	$2,-458752			# 0xfff90000
	.set	macro
	.set	reorder

	lw	$3,1372($17)
	li	$2,393216			# 0x00060000
	ori	$2,$2,0xaaaa
	slt	$2,$3,$2
	beq	$2,$0,$L1011
	li	$3,393216			# 0x00060000
	.set	noreorder
	.set	nomacro
	j	$L1011
	ori	$3,$3,0xaaaa
	.set	macro
	.set	reorder

$L1007:
	lw	$3,1372($17)
	ori	$2,$2,0x5556
	slt	$2,$2,$3
	beq	$2,$0,$L1011
	li	$3,-458752			# 0xfff90000
	ori	$3,$3,0x5556
$L1011:
	sw	$3,1372($17)
$L986:
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

	.end	AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj
	.text
	.ent	AI_IsMellowZone__FP8Car_tObji
AI_IsMellowZone__FP8Car_tObji:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$17,604($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$18,$5
	.set	macro
	.set	reorder

	lw	$3,608($16)
	#nop
	andi	$3,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1021
	move	$6,$2
	.set	macro
	.set	reorder

	lh	$2,8($16)
	lw	$3,BWorldSm_slices
	lw	$4,1732($16)
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$5,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$5,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1021
	andi	$2,$5,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	bne	$4,$2,$L1023
$L1021:
	.set	noreorder
	.set	nomacro
	j	$L1028
	move	$2,$0
	.set	macro
	.set	reorder

$L1023:
	lw	$3,Cars_gNumAIRaceCars
	#nop
	slt	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1024
	li	$4,104857600			# 0x06400000
	.set	macro
	.set	reorder

	li	$4,52428800			# 0x03200000
$L1024:
	slt	$2,$3,2
	beq	$2,$0,$L1025
	li	$4,13107200			# 0x00c80000
$L1025:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1029
	sll	$3,$17,2
	.set	macro
	.set	reorder

	move	$4,$0
$L1029:
	addu	$3,$3,$17
	sll	$3,$3,2
	addu	$3,$3,$17
	sll	$3,$3,18
	addu	$3,$6,$3
	addu	$2,$4,$18
	slt	$2,$2,$3
	xori	$2,$2,0x0001
$L1028:
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

	.end	AI_IsMellowZone__FP8Car_tObji
	.text
	.ent	AI_KeepCarsInLane__FP8Car_tObj
AI_KeepCarsInLane__FP8Car_tObj:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	addu	$sp,$sp,16
	j	$31
	.end	AI_KeepCarsInLane__FP8Car_tObj
	.text
	.ent	AI_PushFinishedCarsToSide__FP8Car_tObj
AI_PushFinishedCarsToSide__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1032
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,912($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1032
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1035
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L1039
$L1035:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1032
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L1054
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L1032
$L1039:
	move	$4,$16
$L1054:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$5,Cars_gNumCars
	.set	noreorder
	bgez	$2,1f
	move	$6,$2
	subu	$6,$0,$6
1:
	.set	reorder
	.set	noreorder
	.set	nomacro
	blez	$5,$L1043
	move	$3,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$4,$2,%lo(Cars_gTotalSortedList) # low
$L1044:
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L1055
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1044
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L1043:
	sll	$2,$3,2
$L1055:
	addu	$2,$2,$3
	sll	$2,$2,19
	slt	$2,$6,$2
	bne	$2,$0,$L1032
	lh	$2,8($16)
	lw	$3,BWorldSm_slices
	lw	$4,1732($16)
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$5,29($2)
	li	$2,6			# 0x00000006
	srl	$3,$5,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1049
	andi	$2,$5,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1048
	slt	$2,$4,7
	.set	macro
	.set	reorder

$L1049:
	lui	$2,%hi(CarLogic_gObs) # high
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,4($2)
	li	$4,9830400			# 0x00960000
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L1032
	sw	$3,4($2)
	.set	macro
	.set	reorder

$L1048:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1051
	lui	$2,%hi(CarLogic_gObs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(CarLogic_gObs)($2)
	li	$4,9830400			# 0x00960000
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L1032
	sw	$3,%lo(CarLogic_gObs)($2)
	.set	macro
	.set	reorder

$L1051:
	addiu	$2,$2,%lo(CarLogic_gObs) # low
	lw	$3,8($2)
	li	$4,9830400			# 0x00960000
	addu	$3,$3,$4
	sw	$3,8($2)
$L1032:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_PushFinishedCarsToSide__FP8Car_tObj
	.text
	.ent	AI_MaybeChangeLaneSlack__FP8Car_tObj
AI_MaybeChangeLaneSlack__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$5,$4
	sw	$31,16($sp)
	lw	$2,596($5)
	#nop
	sll	$3,$2,1
	bltz	$3,$L1057
	lh	$2,8($5)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L1059
	.set	noreorder
	.set	nomacro
	j	$L1059
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L1057:
	lh	$2,8($5)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L1059
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L1059:
	lw	$4,608($5)
	#nop
	andi	$2,$4,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1056
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1062
	sra	$2,$3,4
	.set	macro
	.set	reorder

	sll	$2,$2,4
	bne	$2,$3,$L1056
$L1062:
	andi	$2,$4,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1063
	sra	$2,$3,1
	.set	macro
	.set	reorder

	sll	$2,$2,1
	bne	$2,$3,$L1056
$L1063:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	lw	$4,1264($5)
	#nop
	lw	$4,28($4)
	mflo	$3
	#nop
	#nop
	srl	$2,$3,8
	andi	$2,$2,0xffff
	mult	$4,$2
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	mflo	$2
	#nop
	#nop
	srl	$3,$2,16
	li	$2,1			# 0x00000001
	bne	$3,$2,$L1056
	.set	noreorder
	.set	nomacro
	jal	AI_ChooseNewLaneSlack__FP8Car_tObj
	move	$4,$5
	.set	macro
	.set	reorder

$L1056:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_MaybeChangeLaneSlack__FP8Car_tObj
	.text
	.ent	AI_ChooseNewLaneSlack__FP8Car_tObj
AI_ChooseNewLaneSlack__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,fastRandom
	lw	$2,randSeed
	#nop
	mult	$5,$2
	lw	$3,1264($4)
	mflo	$5
	#nop
	#nop
	srl	$2,$5,6
	andi	$2,$2,0x000c
	addu	$3,$3,$2
	lw	$2,12($3)
	sw	$5,randtemp
	andi	$5,$5,0xffff
	sw	$5,fastRandom
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1388($4)
	.set	macro
	.set	reorder

	.end	AI_ChooseNewLaneSlack__FP8Car_tObj
