	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_btccop.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	_19AIHigh_BTC_HumanCop_lastInputRequestTick_
	.sdata
	.align	2
_19AIHigh_BTC_HumanCop_lastInputRequestTick_:
	.word	0
	.globl	AIH_BTCCop_freezeToggle_8013c564
	.align	2
AIH_BTCCop_freezeToggle_8013c564:
	.word	1
	.globl	AIH_BTC_Cop_1HC1HP_StageTimes
	.data
	.align	2
AIH_BTC_Cop_1HC1HP_StageTimes:
	.word	60
	.word	60
	.word	60
	.globl	AIH_BTCCop_chasePositions
	.align	2
AIH_BTCCop_chasePositions:
	.word	0
	.word	0
	.word	720896
	.word	-524288
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-983040
	.word	0
	.word	0
	.word	-983040
	.word	0
	.word	0
	.word	-983040
	.word	0
	.word	0
	.word	-983040
	.word	0
	.word	0
	.word	524288
	.word	-393216
	.word	0
	.word	524288
	.word	393216
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-655360
	.word	0
	.word	0
	.word	-655360
	.word	0
	.word	0
	.word	-655360
	.word	0
	.word	0
	.word	327680
	.word	-262144
	.word	0
	.word	327680
	.word	262144
	.word	0
	.word	327680
	.word	0
	.word	0
	.word	-327680
	.word	0
	.word	0
	.word	-327680
	.word	0
	.word	0
	.word	-327680
	.text
	.align	2
	.globl	__14AIHigh_BTC_CopP8Car_tObji
	.align	2
	.globl	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.align	2
	.globl	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	.align	2
	.globl	CheckForNewTarget__14AIHigh_BTC_Cop
	.align	2
	.globl	StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.align	2
	.globl	FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.align	2
	.globl	FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.align	2
	.globl	FreezeAndEndChase__14AIHigh_BTC_Cop
	.align	2
	.globl	HudOff__14AIHigh_BTC_Cop
	.align	2
	.globl	__19AIHigh_BTC_HumanCopP8Car_tObji
	.align	2
	.globl	FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
	.align	2
	.globl	ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
	.align	2
	.globl	FreezeAndEndChase__19AIHigh_BTC_HumanCop
	.align	2
	.globl	CheckConditionWithCop0__19AIHigh_BTC_HumanCop
	.align	2
	.globl	NewStage__19AIHigh_BTC_HumanCopiii

	.lcomm	sayLose.258,4
	.align	2
	.globl	UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
	.align	2
	.globl	UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
	.align	2
	.globl	RequestWingman__19AIHigh_BTC_HumanCop
	.align	2
	.globl	RequestBlockader__19AIHigh_BTC_HumanCopi
	.align	2
	.globl	CheckForWingmanRequest__19AIHigh_BTC_HumanCop
	.align	2
	.globl	CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
	.align	2
	.globl	UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
	.align	2
	.globl	ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
	.align	2
	.globl	ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
	.align	2
	.globl	SetDesiredSpeed__19AIHigh_BTC_HumanCop
	.align	2
	.globl	HighExecute__19AIHigh_BTC_HumanCop
	.align	2
	.globl	HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
	.align	2
	.globl	__18AIHigh_BTC_WingmanP8Car_tObji
	.align	2
	.globl	HighExecute__18AIHigh_BTC_Wingman
	.align	2
	.globl	CheckForActivation__18AIHigh_BTC_Wingman
	.align	2
	.globl	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
	.align	2
	.globl	SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
	.align	2
	.globl	SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
	.align	2
	.globl	_._18AIHigh_BTC_Wingman
	.align	2
	.globl	_._19AIHigh_BTC_HumanCop
	.align	2
	.globl	___14AIHigh_BTC_Cop
	.align	2
	.globl	Execute__17AIState_NonActive
	.align	2
	.globl	___17AIState_NonActive
	.align	2
	.globl	TestForRelease__12AIState_Base_8005F678
	.align	2
	.globl	___12AIState_Base_8005F680

	.extern	gWSavePtr, 4
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	gBlockadeTypes, 5
	.extern	Cars_gNumCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumTrafficCars, 4
	.extern	AIInit_forceHumanHandBrake, 4
	.extern	AI_elapsedTime, 4
	.extern	AITune_driveSide, 4
	.extern	BWorldSm_slices, 4
	.extern	AICop_gRoadBlockState, 4
	.extern	AICop_spikeBelt, 20
	.extern	simVar, 28
	.extern	AIDataRecord_TrackCurve, 4
	.extern	simGlobal, 24
	.extern	gNumSlices, 4
	.extern	AIHigh_CopGameType, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	GameSetup_gData, 2600
	.extern	Cars_gNumRaceCars, 4

	.text
	.text
	.ent	__14AIHigh_BTC_CopP8Car_tObji
__14AIHigh_BTC_CopP8Car_tObji:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__15AIHigh_BasicCopP8Car_tObji
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(AIHigh_BTC_Cop_vtable) # high
	addiu	$3,$3,%lo(AIHigh_BTC_Cop_vtable) # low
	sw	$3,20($2)
	sw	$0,88($2)
	sw	$0,92($2)
	sw	$0,96($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__14AIHigh_BTC_CopP8Car_tObji
	.text
	.ent	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,88($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L607
	move	$17,$5
	.set	macro
	.set	reorder

	lw	$5,28($16)
	lw	$2,0($16)
	lw	$7,24($16)
	lw	$6,596($2)
	jal	RemoveChaser__16AIHigh_BasicPerpii7copType
$L607:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L606
	sw	$17,88($16)
	.set	macro
	.set	reorder

	lw	$5,28($16)
	lw	$2,0($16)
	lw	$7,24($16)
	lw	$6,596($2)
	.set	noreorder
	.set	nomacro
	jal	AddChaser__16AIHigh_BasicPerpii7copType
	move	$4,$17
	.set	macro
	.set	reorder

$L606:
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

	.end	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.text
	.ent	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$2,0($16)
	lw	$4,88($16)
	lw	$5,28($16)
	lw	$6,596($2)
	.set	noreorder
	.set	nomacro
	jal	CheckChaserPosition__16AIHigh_BasicPerpii
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$3,92($16)
	#nop
	beq	$2,$3,$L610
	li	$17,1			# 0x00000001
	sw	$2,92($16)
$L610:
	move	$2,$17
	lui	$4,%hi(AIH_BTCCop_chasePositions) # high
	lw	$5,92($16)
	addiu	$4,$4,%lo(AIH_BTCCop_chasePositions) # low
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$4
	lw	$7,0($3)
	lw	$8,4($3)
	lw	$9,8($3)
	sw	$7,0($18)
	sw	$8,4($18)
	sw	$9,8($18)
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

	.end	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	.text
	.ent	CheckForNewTarget__14AIHigh_BTC_Cop
CheckForNewTarget__14AIHigh_BTC_Cop:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	move	$21,$4
	sw	$19,28($sp)
	move	$19,$0
	sw	$20,32($sp)
	li	$20,655360000			# 0x27100000
	sw	$18,24($sp)
	move	$18,$19
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$23,44($sp)
	addiu	$23,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(Cars_gRaceCarList) # low
	sw	$31,48($sp)
	sw	$22,40($sp)
	sw	$16,16($sp)
	lw	$22,88($21)
$L612:
	lw	$2,Cars_gNumRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L613
	lw	$5,0($17)
	#nop
	lbu	$2,145($5)
	#nop
	beq	$2,$0,$L614
	lw	$2,608($5)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L614
	lw	$2,596($5)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$23
	lw	$16,0($2)
	#nop
	lw	$2,120($16)
	#nop
	beq	$2,$0,$L614
	lw	$4,0($21)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$3,$20
	beq	$2,$0,$L614
	move	$20,$3
	move	$19,$16
$L614:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L612
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L613:
	beq	$19,$0,$L618
	.set	noreorder
	.set	nomacro
	beq	$19,$22,$L618
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L621
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L618:
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L621
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L621
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	move	$2,$0
$L621:
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

	.end	CheckForNewTarget__14AIHigh_BTC_Cop
	.text
	.ent	StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,96($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$3,0($4)
	sw	$2,96($4)
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L622
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	move	$4,$3
	.set	macro
	.set	reorder

	lw	$3,76($2)
	#nop
	lh	$4,72($3)
	#nop
	addu	$4,$2,$4
	lw	$2,76($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L622:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.text
	.ent	FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,96($16)
	li	$2,3			# 0x00000003
	beq	$3,$2,$L627
	bne	$3,$0,$L625
$L627:
	lw	$3,20($16)
	li	$2,4			# 0x00000004
	sw	$2,96($16)
	lh	$4,24($3)
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HudOff__14AIHigh_BTC_Cop
	move	$4,$16
	.set	macro
	.set	reorder

$L625:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.text
	.ent	FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,88($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L630
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,96($4)
$L630:
	j	$31
	.end	FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	.text
	.ent	FreezeAndEndChase__14AIHigh_BTC_Cop
FreezeAndEndChase__14AIHigh_BTC_Cop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	FreezeAndEndChase__14AIHigh_BTC_Cop
	.text
	.ent	HudOff__14AIHigh_BTC_Cop
HudOff__14AIHigh_BTC_Cop:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,28($4)
	#nop
	bne	$2,$0,$L632
	jal	Hud_BustedOverlayOff__Fv
$L632:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HudOff__14AIHigh_BTC_Cop
	.text
	.ent	__19AIHigh_BTC_HumanCopP8Car_tObji
__19AIHigh_BTC_HumanCopP8Car_tObji:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$16,24($sp)
	move	$16,$6
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIHigh_BTC_CopP8Car_tObji
	sw	$18,32($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$2,%hi(AIHigh_BTC_HumanCop_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BTC_HumanCop_vtable) # low
	sw	$2,20($17)
	li	$2,1			# 0x00000001
	sw	$2,132($17)
	li	$2,-1			# 0xffffffff
	sw	$2,100($17)
	li	$2,65536			# 0x00010000
	lui	$3,%hi(AITune_BTC) # high
	sw	$2,108($17)
	lui	$2,%hi(GameSetup_gData+8) # high
	sw	$0,124($17)
	sw	$0,128($17)
	sw	$0,136($17)
	sw	$0,104($17)
	lw	$4,%lo(GameSetup_gData+8)($2)
	addiu	$3,$3,%lo(AITune_BTC) # low
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,12($2)
	lw	$3,0($17)
	move	$6,$5
	sw	$2,112($17)
	sw	$0,616($3)
	sw	$0,16($sp)
	sw	$0,20($sp)
	lw	$4,0($17)
	sw	$0,_19AIHigh_BTC_HumanCop_lastInputRequestTick_
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L652
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$3,fastRandom
	lw	$5,randSeed
	#nop
	mult	$3,$5
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xff00
	mflo	$3
	#nop
	#nop
	andi	$4,$3,0xffff
	sw	$3,randtemp
	and	$3,$3,$6
	srl	$3,$3,8
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$2,$2,16
	sltu	$2,$2,500
	sw	$4,fastRandom
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L645:
	mult	$4,$5
	mflo	$3
	#nop
	#nop
	andi	$2,$3,0xffff
	sw	$3,randtemp
	and	$3,$3,$6
	srl	$3,$3,8
	sw	$2,fastRandom
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$2,$2,16
	sltu	$2,$2,750
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$2,AIHigh_CopGameType
	#nop
	xori	$2,$2,0x0004
	sltu	$18,$18,$2
$L646:
	move	$4,$17
	move	$5,$0
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
	li	$7,500			# 0x000001f4
	.set	macro
	.set	reorder

	lw	$3,100($17)
	#nop
	addu	$3,$3,1
	andi	$3,$3,0x0001
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L647
	move	$4,$2
	.set	macro
	.set	reorder

	sll	$2,$16,3
	.set	noreorder
	.set	nomacro
	j	$L648
	subu	$2,$2,$16
	.set	macro
	.set	reorder

$L647:
	sll	$2,$16,3
	subu	$2,$16,$2
$L648:
 #APP
 #NO_APP
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalcRoadBend__FP8Car_tObji
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	bgez	$2,$L649
	subu	$2,$0,$2
$L649:
	slt	$2,$2,24249
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,AIHigh_CopGameType
	li	$2,4			# 0x00000004
	beq	$3,$2,$L653
	li	$18,1			# 0x00000001
$L653:
	lw	$2,0($17)
	move	$6,$16
	lh	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	NewStage__19AIHigh_BTC_HumanCopiii
	move	$7,$18
	.set	macro
	.set	reorder

	move	$2,$17
$L652:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__19AIHigh_BTC_HumanCopP8Car_tObji
	.text
	.ent	FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	subu	$sp,$sp,48
	mflo	$3
	#nop
	#nop
	srl	$2,$3,8
	andi	$2,$2,0xffff
	sll	$2,$2,1
	mult	$7,$2
	sw	$21,36($sp)
	sw	$31,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	mflo	$9
	#nop
	#nop
	srl	$2,$9,16
	subu	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bltz	$2,$L655
	move	$21,$6
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	addu	$17,$5,$2
	slt	$2,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$2,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L671
	subu	$17,$17,$3
	.set	macro
	.set	reorder

$L655:
	addu	$17,$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$17,$L671
	li	$2,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$17,$17,$2
	li	$2,1717960704			# 0x66660000
$L671:
	ori	$2,$2,0x6667
	mult	$21,$2
	move	$19,$0
	sll	$20,$21,1
	sra	$2,$21,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,1
	subu	$18,$3,$2
$L659:
	slt	$2,$19,30
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	subu	$2,$0,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L662
	subu	$16,$17,$21
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L672
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L662:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L672
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
$L664:
	move	$4,$16
$L672:
	move	$5,$20
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	li	$7,6			# 0x00000006
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$20
	li	$6,1			# 0x00000001
	li	$7,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLaneInSliceRange__Fiiii
	move	$16,$2
	.set	macro
	.set	reorder

	beq	$16,$0,$L666
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	move	$2,$17
	.set	macro
	.set	reorder

$L666:
	.set	noreorder
	.set	nomacro
	bltz	$18,$L667
	addu	$5,$17,$18
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	move	$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L670
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L667:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L674
	move	$17,$5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L670:
	move	$17,$5
$L674:
	.set	noreorder
	.set	nomacro
	j	$L659
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L660:
	move	$2,$17
$L673:
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

	.end	FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
	.text
	.ent	ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$3,0($17)
	move	$16,$5
	lw	$2,1392($3)
	#nop
	ori	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__14AIHigh_BTC_Cop
	sw	$2,1392($3)
	.set	macro
	.set	reorder

	lw	$2,88($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L676
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,96($17)
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,116($17)
$L676:
	.set	noreorder
	.set	nomacro
	jal	ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
	move	$4,$17
	.set	macro
	.set	reorder

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

	.end	ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
	.text
	.ent	FreezeAndEndChase__19AIHigh_BTC_HumanCop
FreezeAndEndChase__19AIHigh_BTC_HumanCop:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,28($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L677
	li	$6,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lw	$3,fastRandom
	lw	$5,randSeed
	#nop
	mult	$3,$5
	ori	$6,$6,0xff00
	mflo	$3
	#nop
	#nop
	andi	$4,$3,0xffff
	sw	$3,randtemp
	and	$3,$3,$6
	srl	$3,$3,8
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$2,$2,16
	sltu	$2,$2,500
	sw	$4,fastRandom
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L679:
	mult	$4,$5
	mflo	$3
	#nop
	#nop
	andi	$2,$3,0xffff
	sw	$3,randtemp
	and	$3,$3,$6
	srl	$3,$3,8
	sw	$2,fastRandom
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$2,$2,16
	sltu	$2,$2,750
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L680
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,AIHigh_CopGameType
	#nop
	xori	$2,$2,0x0004
	sltu	$17,$17,$2
$L680:
	lw	$2,0($18)
	lw	$4,AIDataRecord_TrackCurve
	lh	$5,8($2)
	jal	Get__25AIDataRecord_TrackCurve_ti
	slt	$2,$2,66
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,AIHigh_CopGameType
	li	$2,4			# 0x00000004
	beq	$3,$2,$L688
	li	$17,1			# 0x00000001
$L688:
	lw	$2,0($18)
	li	$6,100			# 0x00000064
	lh	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,100($18)
	#nop
	addu	$3,$3,1
	andi	$3,$3,0x0001
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L682
	move	$5,$2
	.set	macro
	.set	reorder

	sll	$2,$16,3
	.set	noreorder
	.set	nomacro
	j	$L683
	subu	$2,$2,$16
	.set	macro
	.set	reorder

$L682:
	sll	$2,$16,3
	subu	$2,$16,$2
$L683:
	bltz	$2,$L684
	lw	$3,gNumSlices
	addu	$5,$5,$2
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L689
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L684:
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$5,$L689
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L689:
	move	$6,$16
	lw	$2,0($4)
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	NewStage__19AIHigh_BTC_HumanCopiii
	sh	$5,8($2)
	.set	macro
	.set	reorder

$L677:
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

	.end	FreezeAndEndChase__19AIHigh_BTC_HumanCop
	.text
	.ent	CheckConditionWithCop0__19AIHigh_BTC_HumanCop
CheckConditionWithCop0__19AIHigh_BTC_HumanCop:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,28($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	lui	$2,%hi(highLevelAIObjs) # high
	.set	macro
	.set	reorder

	lw	$16,%lo(highLevelAIObjs)($2)
	lw	$3,100($17)
	lw	$2,100($16)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L692
	lw	$2,0($16)
	lw	$6,128($16)
	lw	$7,132($16)
	lh	$5,8($2)
	addu	$2,$3,1
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L693
	sll	$2,$6,3
	.set	macro
	.set	reorder

	subu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	j	$L694
	sll	$2,$2,1
	.set	macro
	.set	reorder

$L693:
	subu	$2,$2,$6
	sll	$2,$2,1
	subu	$2,$0,$2
$L694:
	bltz	$2,$L695
	lw	$3,gNumSlices
	addu	$5,$5,$2
	slt	$2,$5,$3
	bne	$2,$0,$L697
	.set	noreorder
	.set	nomacro
	j	$L697
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L695:
	addu	$5,$5,$2
	bgez	$5,$L697
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L697:
	.set	noreorder
	.set	nomacro
	jal	NewStage__19AIHigh_BTC_HumanCopiii
	move	$4,$17
	.set	macro
	.set	reorder

$L692:
	lw	$2,0($16)
	lw	$3,0($17)
	lw	$2,1372($2)
	#nop
	sw	$2,1372($3)
$L690:
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

	.end	CheckConditionWithCop0__19AIHigh_BTC_HumanCop
	.text
	.ent	NewStage__19AIHigh_BTC_HumanCopiii
NewStage__19AIHigh_BTC_HumanCopiii:
	.frame	$sp,64,$31		# vars= 8, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,40($sp)
	move	$18,$4
	sw	$19,44($sp)
	move	$19,$5
	sw	$20,48($sp)
	move	$20,$6
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,100($18)
	#nop
	addu	$2,$2,1
	sw	$2,100($18)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,436($3)
	lw	$4,AIHigh_CopGameType
	addu	$2,$2,1
	sw	$2,436($3)
	addu	$2,$4,-2
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L702
	move	$16,$7
	.set	macro
	.set	reorder

	lw	$2,100($18)
	lw	$3,428($3)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	lui	$3,%hi(simVar+4) # high
	.set	macro
	.set	reorder

$L702:
	li	$2,4			# 0x00000004
	bne	$4,$2,$L700
	lw	$2,100($18)
	#nop
	slt	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	lui	$3,%hi(simVar+4) # high
	.set	macro
	.set	reorder

$L728:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L699
	sw	$2,%lo(simVar+4)($3)
	.set	macro
	.set	reorder

$L700:
	jal	BWorld_InitSpikeBelt__Fv
	lui	$2,%hi(AICop_spikeBelt) # high
	.set	noreorder
	.set	nomacro
	jal	Object_ClearCustomObjects__Fv
	sw	$0,%lo(AICop_spikeBelt)($2)
	.set	macro
	.set	reorder

	lw	$2,0($18)
	sw	$20,128($18)
	sw	$16,132($18)
	sh	$19,8($2)
	lw	$2,0($18)
	addu	$5,$sp,24
	sw	$20,1364($2)
	lw	$4,0($18)
	addu	$6,$sp,28
	sw	$0,AICop_gRoadBlockState
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$3,AIHigh_CopGameType
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L703
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$6,28($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L723
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L703:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L705
	li	$2,851968			# 0x000d0000
	.set	macro
	.set	reorder

	ori	$2,$2,0x5555
	mult	$20,$2
	lw	$6,28($sp)
	move	$5,$19
	sw	$0,20($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	j	$L723
	sw	$9,16($sp)
	.set	macro
	.set	reorder

$L705:
	lw	$2,BWorldSm_slices
	sll	$21,$19,5
	addu	$6,$21,$2
	lbu	$2,31($6)
	lbu	$4,29($6)
	sll	$2,$2,15
	andi	$3,$4,0x000f
	mult	$2,$3
	lbu	$3,30($6)
	mflo	$17
	#nop
	srl	$7,$4,4
	sll	$3,$3,15
	mult	$3,$7
	lh	$2,26($6)
	li	$8,-32768			# 0xffff8000
	sll	$2,$2,8
	addu	$5,$2,$8
	slt	$2,$17,$5
	mflo	$16
	#nop
	beq	$2,$0,$L707
	move	$5,$17
$L707:
	lh	$2,24($6)
	#nop
	sll	$2,$2,8
	addu	$3,$2,$8
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L708
	move	$17,$5
	.set	macro
	.set	reorder

	move	$3,$16
$L708:
	move	$16,$3
	move	$4,$19
	li	$5,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	subu	$5,$5,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	li	$2,-131072			# 0xfffe0000
	.set	macro
	.set	reorder

	addu	$16,$16,$2
$L709:
	lw	$2,BWorldSm_slices
	#nop
	addu	$2,$21,$2
	lbu	$5,29($2)
	move	$4,$19
	andi	$5,$5,0x000f
	.set	noreorder
	.set	nomacro
	jal	AIWorld_IsDriveableLane__Fii
	addu	$5,$5,7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	li	$2,-131072			# 0xfffe0000
	.set	macro
	.set	reorder

	addu	$17,$17,$2
$L710:
	lw	$2,28($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,AITune_driveSide
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L713
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L729
	subu	$6,$0,$16
	.set	macro
	.set	reorder

$L711:
	lw	$3,AITune_driveSide
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L714
	move	$5,$19
	.set	macro
	.set	reorder

$L713:
	move	$5,$19
	move	$6,$17
	sll	$2,$20,8
	.set	noreorder
	.set	nomacro
	j	$L724
	addu	$2,$2,512
	.set	macro
	.set	reorder

$L714:
	subu	$6,$0,$16
$L729:
	sll	$3,$20,8
	li	$2,512			# 0x00000200
	subu	$2,$2,$3
$L724:
	sw	$0,16($sp)
	sw	$2,20($sp)
$L723:
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	move	$7,$20
	.set	macro
	.set	reorder

	lw	$3,AIHigh_CopGameType
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L717
	lui	$4,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(AIH_BTC_Cop_1HC1HP_StageTimes) # high
	lw	$3,100($18)
	addiu	$2,$2,%lo(AIH_BTC_Cop_1HC1HP_StageTimes) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L727
	sll	$16,$2,5
	.set	macro
	.set	reorder

$L717:
	lw	$3,100($18)
	addiu	$4,$4,%lo(GameSetup_gData) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,464($2)
	#nop
	sll	$16,$2,5
$L727:
	bgez	$16,$L719
	move	$16,$0
$L719:
	lw	$2,108($18)
	#nop
	mult	$16,$2
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L720
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$4,$4,$2
$L720:
	lw	$2,28($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L721
	sra	$16,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hud_BTC_BonusTime__Fl
	sll	$4,$16,1
	.set	macro
	.set	reorder

$L721:
	lw	$2,112($18)
	li	$3,1			# 0x00000001
	sw	$3,124($18)
	sw	$0,116($18)
	sw	$0,120($18)
	sw	$3,96($18)
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_RestartTrgSfx__Fv
	sw	$2,112($18)
	.set	macro
	.set	reorder

$L699:
	lw	$31,56($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	NewStage__19AIHigh_BTC_HumanCopiii
	.text
	.ent	UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,96($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L731
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$3,$2,$L731
	lw	$2,112($16)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	sw	$2,112($16)
$L731:
	lw	$2,88($16)
	#nop
	beq	$2,$0,$L732
	lw	$5,112($16)
	lw	$2,0($2)
	lw	$3,0($16)
	lw	$4,648($2)
	lw	$6,1120($3)
	.set	noreorder
	.set	nomacro
	j	$L738
	addu	$4,$4,92
	.set	macro
	.set	reorder

$L732:
	lw	$2,0($16)
	move	$4,$0
	lw	$6,1120($2)
	move	$5,$4
$L738:
	.set	noreorder
	.set	nomacro
	jal	Hud_BTC_Update__FPcib
	sltu	$6,$6,1
	.set	macro
	.set	reorder

	lw	$2,112($16)
	#nop
	bgez	$2,$L730
	lw	$2,AIH_BTCCop_freezeToggle_8013c564
	#nop
	beq	$2,$0,$L735
	lw	$4,0($16)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,56($3)
	lw	$3,60($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	sw	$0,AIH_BTCCop_freezeToggle_8013c564
$L735:
	lw	$2,112($16)
	#nop
	slt	$2,$2,-160
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	move	$4,$16
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	lui	$2,%hi(simVar+4) # high
	sw	$3,%lo(simVar+4)($2)
	lw	$5,88($4)
	lw	$7,0($4)
	sw	$3,AIH_BTCCop_freezeToggle_8013c564
	.set	noreorder
	.set	nomacro
	jal	HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
	move	$6,$3
	.set	macro
	.set	reorder

$L730:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
	.text
	.ent	UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$4
	lw	$2,112($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L740
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($5)
	#nop
	lw	$4,1364($2)
	li	$3,1			# 0x00000001
	sw	$3,AIInit_forceHumanHandBrake
	sw	$4,1120($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,136($5)
	.set	macro
	.set	reorder

$L740:
	lw	$3,96($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L741
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($5)
	#nop
	sw	$0,1120($2)
	lw	$3,0($5)
	li	$2,1			# 0x00000001
	sw	$2,632($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,136($5)
	.set	macro
	.set	reorder

$L741:
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L742
	li	$3,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	lw	$4,0($5)
	#nop
	lw	$2,1392($4)
	#nop
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$3,128($5)
	lw	$2,0($5)
	#nop
	sw	$3,1120($2)
	lw	$2,132($5)
	lw	$3,0($5)
	sltu	$2,$2,1
	sw	$2,632($3)
	lw	$2,0($5)
	#nop
	lw	$2,632($2)
	#nop
	beq	$2,$0,$L748
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,136($5)
	.set	macro
	.set	reorder

$L742:
	lw	$3,0($5)
	#nop
	lw	$2,632($3)
	#nop
	beq	$2,$4,$L746
	lw	$2,1120($3)
	#nop
	beq	$2,$0,$L745
$L746:
	lw	$2,1392($3)
	#nop
	ori	$2,$2,0x0002
	sw	$2,1392($3)
$L745:
	lw	$2,0($5)
	sw	$0,136($5)
	sw	$0,96($5)
	sw	$0,1120($2)
	lw	$2,0($5)
	#nop
	sw	$0,632($2)
$L748:
	j	$31
	.end	UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
	.text
	.ent	RequestWingman__19AIHigh_BTC_HumanCop
RequestWingman__19AIHigh_BTC_HumanCop:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,96($17)
	#nop
	addu	$2,$2,-3
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	lui	$6,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$6,$6,%lo(GameSetup_gData) # low
	lui	$5,%hi(AITune_BTC) # high
	addiu	$5,$5,%lo(AITune_BTC) # low
	lw	$2,100($17)
	lw	$4,0($17)
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$6
	lw	$6,8($6)
	lw	$3,468($3)
	sll	$2,$6,3
	subu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$2,16($2)
	sll	$3,$3,6
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	addu	$16,$3,$2
	.set	macro
	.set	reorder

	lw	$3,76($2)
	#nop
	lh	$4,96($3)
	lw	$3,100($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,116($17)
	#nop
	beq	$3,$0,$L752
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L752
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	subu	$2,$2,$3
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L752
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$3,120($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L752
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L749
	sw	$2,120($17)
	.set	macro
	.set	reorder

$L752:
	jal	Dispatch__6Speech
	lw	$3,76($2)
	#nop
	lh	$4,24($3)
	lw	$3,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L749:
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

	.end	RequestWingman__19AIHigh_BTC_HumanCop
	.text
	.ent	RequestBlockader__19AIHigh_BTC_HumanCopi
RequestBlockader__19AIHigh_BTC_HumanCopi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,96($16)
	#nop
	addu	$2,$2,-3
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L758
	move	$17,$5
	.set	macro
	.set	reorder

	beq	$17,$0,$L760
	lw	$4,0($16)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,88($3)
	lw	$3,92($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lui	$5,%hi(GameSetup_gData) # high
	addiu	$5,$5,%lo(GameSetup_gData) # low
	lui	$4,%hi(AITune_BTC) # high
	lw	$2,100($16)
	addiu	$4,$4,%lo(AITune_BTC) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$5
	lw	$5,8($5)
	lw	$3,472($3)
	sll	$2,$5,3
	subu	$2,$2,$5
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,24($2)
	.set	noreorder
	.set	nomacro
	j	$L772
	sll	$3,$3,6
	.set	macro
	.set	reorder

$L760:
	lw	$4,0($16)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,80($3)
	lw	$3,84($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lui	$5,%hi(GameSetup_gData) # high
	addiu	$5,$5,%lo(GameSetup_gData) # low
	lui	$4,%hi(AITune_BTC) # high
	lw	$2,100($16)
	addiu	$4,$4,%lo(AITune_BTC) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$5
	lw	$5,8($5)
	lw	$3,476($3)
	sll	$2,$5,3
	subu	$2,$2,$5
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,20($2)
	sll	$3,$3,6
$L772:
	lw	$4,116($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L763
	addu	$3,$3,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L763
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	subu	$2,$2,$4
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L763
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	lw	$3,120($16)
	#nop
	beq	$3,$2,$L763
	jal	Dispatch__6Speech
	lw	$3,76($2)
	#nop
	lh	$4,32($3)
	lw	$3,36($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L767
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L758
	sw	$2,120($16)
	.set	macro
	.set	reorder

$L767:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L758
	sw	$2,120($16)
	.set	macro
	.set	reorder

$L763:
	jal	Dispatch__6Speech
	lw	$3,76($2)
	#nop
	lh	$4,24($3)
	lw	$3,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L758:
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

	.end	RequestBlockader__19AIHigh_BTC_HumanCopi
	.text
	.ent	CheckForWingmanRequest__19AIHigh_BTC_HumanCop
CheckForWingmanRequest__19AIHigh_BTC_HumanCop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,120($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L774
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	sw	$2,120($4)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L774:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CheckForWingmanRequest__19AIHigh_BTC_HumanCop
	.text
	.ent	CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,0($5)
	lw	$3,120($4)
	#nop
	addu	$2,$3,-2
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	bne	$3,$2,$L779
	li	$2,1			# 0x00000001
	sw	$2,0($5)
$L779:
	li	$2,5			# 0x00000005
	sw	$2,120($4)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L778:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
	.text
	.ent	UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L785
	slt	$2,$5,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L790
	beq	$5,$0,$L784
$L793:
	j	$31
$L790:
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,120($4)
	.set	macro
	.set	reorder

$L784:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,120($4)
	.set	macro
	.set	reorder

$L785:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,120($4)
	.set	macro
	.set	reorder

	.end	UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
	.text
	.ent	ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	lw	$5,Cars_gNumTrafficCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$7,$2,%lo(highLevelAIObjs) # low
	li	$6,1			# 0x00000001
	lui	$2,%hi(Cars_gTrafficCarList) # high
	addiu	$3,$2,%lo(Cars_gTrafficCarList) # low
$L797:
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	addu	$4,$4,1
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lw	$2,596($2)
	addu	$3,$3,4
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L797
	sw	$6,28($2)
	.set	macro
	.set	reorder

$L801:
	j	$31
	.end	ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
	.text
	.ent	ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	lw	$5,Cars_gNumTrafficCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$6,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gTrafficCarList) # high
	addiu	$3,$2,%lo(Cars_gTrafficCarList) # low
$L805:
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L809
	addu	$4,$4,1
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lw	$2,596($2)
	addu	$3,$3,4
	sll	$2,$2,2
	addu	$2,$2,$6
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L805
	sw	$0,28($2)
	.set	macro
	.set	reorder

$L809:
	j	$31
	.end	ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
	.text
	.ent	SetDesiredSpeed__19AIHigh_BTC_HumanCop
SetDesiredSpeed__19AIHigh_BTC_HumanCop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,0($16)
	#nop
	lw	$2,1120($4)
	#nop
	beq	$2,$0,$L810
	jal	AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
	move	$3,$2
	lw	$5,136($16)
	lw	$4,0($16)
	slt	$2,$5,$3
	beq	$2,$0,$L812
	move	$3,$5
$L812:
	sw	$3,1372($4)
$L810:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetDesiredSpeed__19AIHigh_BTC_HumanCop
	.text
	.ent	HighExecute__19AIHigh_BTC_HumanCop
HighExecute__19AIHigh_BTC_HumanCop:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,40($sp)
	sw	$17,36($sp)
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,96($16)
	#nop
	bne	$3,$2,$L815
	jal	ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
$L815:
	lw	$4,88($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L816
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,96($16)
	#nop
	beq	$3,$2,$L816
	lw	$2,0($4)
	lw	$3,0($16)
	lw	$2,1364($2)
	#nop
	sw	$2,1360($3)
$L816:
	.set	noreorder
	.set	nomacro
	jal	SetDesiredSpeed__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckConditionWithCop0__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__14AIHigh_BTC_Cop
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,88($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L817
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L817:
	lw	$3,AIHigh_CopGameType
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L818
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(simGlobal) # low
	lw	$2,4($17)
	lw	$3,_19AIHigh_BTC_HumanCop_lastInputRequestTick_
	#nop
	subu	$2,$2,$3
	slt	$2,$2,641
	bne	$2,$0,$L819
	lw	$2,0($16)
	#nop
	lbu	$3,1099($2)
	li	$2,4			# 0x00000004
	bne	$3,$2,$L820
	.set	noreorder
	.set	nomacro
	jal	RequestWingman__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sb	$0,1099($2)
	lw	$2,4($17)
	#nop
	sw	$2,_19AIHigh_BTC_HumanCop_lastInputRequestTick_
$L820:
	lw	$2,0($16)
	#nop
	lbu	$3,1099($2)
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L821
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	RequestBlockader__19AIHigh_BTC_HumanCopi
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sb	$0,1099($2)
	lw	$2,4($17)
	#nop
	sw	$2,_19AIHigh_BTC_HumanCop_lastInputRequestTick_
$L821:
	lw	$2,0($16)
	#nop
	lbu	$3,1099($2)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L818
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	RequestBlockader__19AIHigh_BTC_HumanCopi
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sb	$0,1099($2)
	lw	$2,4($17)
	#nop
	sw	$2,_19AIHigh_BTC_HumanCop_lastInputRequestTick_
	j	$L818
$L819:
	lw	$3,0($16)
	#nop
	lbu	$2,1099($3)
	#nop
	addu	$2,$2,-4
	sltu	$2,$2,3
	beq	$2,$0,$L818
	sb	$0,1099($3)
$L818:
	lw	$4,4($16)
	jal	StateExecute__12AIState_Base
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

	.end	HighExecute__19AIHigh_BTC_HumanCop
	.text
	.ent	HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,608($7)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L827
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$7,%lo(Cars_gHumanRaceCarList)($2)
$L827:
	lw	$2,28($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L831
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	beq	$6,$0,$L826
$L831:
	sltu	$6,$6,1
	lw	$3,0($5)
	lw	$2,%lo(simGlobal+4)($2)
	lw	$4,116($4)
	lh	$7,596($7)
	lw	$5,648($3)
	subu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	jal	Hud_BustedOverlayOn__FiPcbs
	addu	$5,$5,92
	.set	macro
	.set	reorder

$L826:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
	.text
	.ent	__18AIHigh_BTC_WingmanP8Car_tObji
__18AIHigh_BTC_WingmanP8Car_tObji:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIHigh_BTC_CopP8Car_tObji
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(AIHigh_BTC_Wingman_vtable) # high
	addiu	$3,$3,%lo(AIHigh_BTC_Wingman_vtable) # low
	sw	$3,20($2)
	sw	$0,112($2)
	sw	$0,116($2)
	sw	$0,120($2)
	sw	$0,100($2)
	sw	$0,104($2)
	sw	$0,108($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__18AIHigh_BTC_WingmanP8Car_tObji
	.text
	.ent	HighExecute__18AIHigh_BTC_Wingman
HighExecute__18AIHigh_BTC_Wingman:
	.frame	$sp,104,$31		# vars= 48, regs= 4/0, args= 40, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$17,92($sp)
	move	$17,$4
	sw	$31,100($sp)
	sw	$18,96($sp)
	.set	noreorder
	.set	nomacro
	jal	CheckSpikeBelt__15AIHigh_BasicCop
	sw	$16,88($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForActivation__18AIHigh_BTC_Wingman
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,8($17)
	#nop
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	lui	$2,%hi($L914) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L914) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L914:
	.word	$L845
	.word	$L848
	.word	$L849
	.word	$L880
	.word	$L861
	.word	$L848
	.word	$L848
	.word	$L899
	.word	$L848
	.word	$L908
	.word	$L848
	.text
$L845:
	lw	$5,0($17)
	li	$4,8			# 0x00000008
	lw	$2,1392($5)
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,1392($5)
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$16,0($17)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,40
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(D_80054F24) # high
	addiu	$2,$2,%lo(D_80054F24) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($18)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	addu	$6,$sp,40
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	sw	$2,44($sp)
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	sb	$0,145($2)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L847
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L847:
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	j	$L916
	sw	$18,4($17)
	.set	macro
	.set	reorder

$L849:
	lw	$4,0($17)
	#nop
	lw	$2,1392($4)
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$3,104($17)
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L850
	addu	$2,$3,-2
	.set	macro
	.set	reorder

	sltu	$2,$2,2
	beq	$2,$0,$L850
	lw	$4,0($17)
	jal	AILife_IsCarInAnyVisibleArea__FP8Car_tObj
	bne	$2,$0,$L854
	lw	$4,0($17)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,128($3)
	lw	$3,132($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	move	$4,$17
	lw	$6,104($17)
	lw	$5,108($17)
	lw	$2,104($17)
	xori	$6,$6,0x0003
	sltu	$6,$6,1
	.set	noreorder
	.set	nomacro
	jal	SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
	sw	$2,100($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_Idle_vtable) # high
	addiu	$2,$2,%lo(AIState_Idle_vtable) # low
	sw	$2,4($16)
	li	$2,1			# 0x00000001
	sw	$2,12($16)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L853
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L853:
	.set	noreorder
	.set	nomacro
	j	$L917
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L850:
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__14AIHigh_BTC_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,88($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L854
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,148			# 0x00000094
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$2,88($17)
	#nop
	lw	$6,0($2)
	li	$2,512			# 0x00000200
	sw	$2,16($sp)
	li	$2,3932160			# 0x003c0000
	sw	$2,20($sp)
	li	$2,1638400			# 0x00190000
	sw	$2,24($sp)
	li	$2,2			# 0x00000002
	sw	$2,28($sp)
	li	$2,65536			# 0x00010000
	sw	$2,32($sp)
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
	addu	$7,$sp,40
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L857
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L857:
	li	$2,4			# 0x00000004
$L917:
	sw	$16,4($17)
	sw	$2,8($17)
$L854:
	.set	noreorder
	.set	nomacro
	jal	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$16,0($17)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,40
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(D_80054F24) # high
	addiu	$2,$2,%lo(D_80054F24) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($18)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	addu	$6,$sp,40
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	.set	noreorder
	.set	nomacro
	j	$L920
	sw	$2,44($sp)
	.set	macro
	.set	reorder

$L861:
	lw	$3,0($17)
	move	$4,$17
	lw	$2,1392($3)
	lw	$18,4($17)
	ori	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	jal	HandleBlockadeSpeech__15AIHigh_BasicCop
	sw	$2,1392($3)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L862
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,88($17)
	#nop
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
	addu	$6,$sp,40
	.set	macro
	.set	reorder

$L862:
	lw	$2,144($18)
	#nop
	slt	$2,$2,161
	bne	$2,$0,$L863
	.set	noreorder
	.set	nomacro
	jal	FindBarrierEndSlice__13AIState_Chase
	move	$4,$18
	.set	macro
	.set	reorder

	li	$4,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	move	$6,$16
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__17AIState_GotoSliceP8Car_tObjii
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L865
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L865:
	li	$2,9			# 0x00000009
	sw	$16,4($17)
	sw	$2,8($17)
$L863:
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__14AIHigh_BTC_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L866
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$sp,56
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,88($17)
	move	$4,$18
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
	move	$6,$16
	.set	macro
	.set	reorder

$L866:
	lw	$3,120($18)
	li	$2,8			# 0x00000008
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,108($18)
	li	$3,917504			# 0x000e0000
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	li	$3,983040			# 0x000f0000
	.set	macro
	.set	reorder

	lw	$2,104($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$4,$2,$3
$L867:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L870
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetMurderMode__13AIState_Chaseii
	li	$6,768			# 0x00000300
	.set	macro
	.set	reorder

$L870:
	lw	$2,88($17)
	#nop
	bne	$2,$0,$L871
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L873
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L873:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	sw	$2,8($17)
$L871:
	lw	$3,104($17)
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L874
	addu	$2,$3,-2
	.set	macro
	.set	reorder

	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L874
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,0($17)
	#nop
	lw	$2,1360($3)
	move	$5,$0
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	sw	$2,1360($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L876
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L876:
	lw	$4,0($17)
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	sw	$2,8($17)
	.set	macro
	.set	reorder

	lw	$3,76($2)
	#nop
	lh	$4,56($3)
	lw	$3,60($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L874:
	.set	noreorder
	.set	nomacro
	jal	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$16,0($17)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,72
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(D_80054F24) # high
	addiu	$2,$2,%lo(D_80054F24) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($18)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	move	$6,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	.set	noreorder
	.set	nomacro
	j	$L920
	sw	$2,76($sp)
	.set	macro
	.set	reorder

$L880:
	lw	$2,0($17)
	#nop
	lw	$3,1392($2)
	move	$4,$17
	ori	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__14AIHigh_BTC_Cop
	sw	$3,1392($2)
	.set	macro
	.set	reorder

	lw	$2,88($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L881
	move	$16,$0
	.set	macro
	.set	reorder

	li	$4,8			# 0x00000008
	li	$2,1			# 0x00000001
	sw	$2,104($17)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,100($17)
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L883
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L883:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	j	$L843
	sw	$2,8($17)
	.set	macro
	.set	reorder

$L881:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	lw	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L884
	lui	$2,%hi(AICop_spikeBelt) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(AICop_spikeBelt) # low
	lw	$3,4($4)
	lw	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L884
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,16($4)
$L884:
	lw	$2,88($17)
	lw	$4,0($17)
	lw	$5,0($2)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	li	$3,3211264			# 0x00310000
	ori	$3,$3,0xffff
	move	$4,$2
	.set	noreorder
	bgez	$4,1f
	move	$5,$4
	subu	$5,$0,$5
1:
	.set	reorder
	slt	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L918
	li	$2,19595264			# 0x012b0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$5
	bne	$2,$0,$L886
	#.set	volatile
	lw	$2,88($17)
	#.set	novolatile
	#nop
	lw	$2,0($2)
	#nop
	lw	$3,1380($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L922
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L922:
	ori	$2,$2,0x71c7
	slt	$3,$2,$3
	beq	$3,$0,$L886
	#.set	volatile
	lw	$2,88($17)
	#.set	novolatile
	#nop
	lw	$2,0($2)
	#nop
	lw	$5,1380($2)
	jal	fixeddiv
	move	$3,$2
	blez	$3,$L886
	lw	$2,120($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L886
$L918:
	li	$16,1			# 0x00000001
$L886:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L890
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,148			# 0x00000094
	sw	$0,112($17)
	sw	$2,104($17)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,100($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$2,88($17)
	#nop
	lw	$6,0($2)
	li	$2,512			# 0x00000200
	sw	$2,16($sp)
	li	$2,3932160			# 0x003c0000
	sw	$2,20($sp)
	li	$2,1638400			# 0x00190000
	sw	$2,24($sp)
	li	$2,2			# 0x00000002
	sw	$2,28($sp)
	li	$2,65536			# 0x00010000
	sw	$2,32($sp)
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
	addu	$7,$sp,40
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L892
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L892:
	li	$2,4			# 0x00000004
	sw	$16,4($17)
	sw	$2,8($17)
$L890:
	lw	$3,104($17)
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L893
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L893
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$3,100($17)
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L895
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L895:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	sw	$2,8($17)
$L893:
	.set	noreorder
	.set	nomacro
	jal	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$16,0($17)
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,56
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(D_80054F24) # high
	addiu	$2,$2,%lo(D_80054F24) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($18)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	move	$6,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	sw	$2,60($sp)
$L920:
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	sb	$0,145($2)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L898
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L898:
	li	$2,7			# 0x00000007
	sw	$18,4($17)
	sw	$2,8($17)
	sw	$0,104($17)
	.set	noreorder
	.set	nomacro
	j	$L848
	sw	$0,100($17)
	.set	macro
	.set	reorder

$L899:
	lw	$4,0($17)
	#nop
	lw	$2,1392($4)
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$2,100($17)
	lw	$3,104($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L848
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L901
	addu	$2,$3,-2
	.set	macro
	.set	reorder

	lw	$5,108($17)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
	sw	$18,100($17)
	.set	macro
	.set	reorder

	j	$L921
$L901:
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$5,108($17)
	lw	$6,104($17)
	sw	$3,100($17)
	xori	$6,$6,0x0003
	.set	noreorder
	.set	nomacro
	jal	SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
	sltu	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_Idle_vtable) # high
	addiu	$2,$2,%lo(AIState_Idle_vtable) # low
	sw	$2,4($16)
	sw	$18,12($16)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L905
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L905:
	.set	noreorder
	.set	nomacro
	j	$L919
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L908:
	move	$4,$17
	lw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$0
	.set	macro
	.set	reorder

	li	$5,655360			# 0x000a0000
	.set	noreorder
	.set	nomacro
	jal	InTargetSliceRange__17AIState_GotoSlicei
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L848
$L921:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L911
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	li	$5,3			# 0x00000003
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L911:
	li	$2,2			# 0x00000002
$L919:
	sw	$16,4($17)
$L916:
	sw	$2,8($17)
$L848:
	lw	$4,4($17)
	jal	StateExecute__12AIState_Base
$L843:
	lw	$31,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	HighExecute__18AIHigh_BTC_Wingman
	.text
	.ent	CheckForActivation__18AIHigh_BTC_Wingman
CheckForActivation__18AIHigh_BTC_Wingman:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$19,36($sp)
	move	$19,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$20,40($sp)
	addiu	$20,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$18,32($sp)
	addiu	$18,$2,%lo(Cars_gList) # low
	sw	$31,44($sp)
	sw	$16,24($sp)
	sw	$0,16($sp)
$L926:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L925
	lw	$3,0($18)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L928
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L928
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	jal	CheckForWingmanRequest__19AIHigh_BTC_HumanCop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L929
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,104($17)
	sw	$16,108($17)
$L929:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L928
	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L931
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,3			# 0x00000003
$L931:
	sw	$3,104($17)
	sw	$16,108($17)
$L928:
	addu	$18,$18,4
	.set	noreorder
	.set	nomacro
	j	$L926
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L925:
	lw	$4,108($17)
	#nop
	beq	$4,$0,$L933
	lw	$5,100($17)
	jal	UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role
$L933:
	lw	$2,100($17)
	lw	$3,104($17)
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	xor	$2,$2,$3
	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	CheckForActivation__18AIHigh_BTC_Wingman
	.text
	.ent	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,96($4)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L936
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	sw	$0,632($2)
	lw	$2,96($4)
	sw	$0,96($4)
	xori	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L936:
	move	$2,$0
	lw	$4,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,632($4)
	.set	macro
	.set	reorder

	.end	UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman
	.text
	.ent	SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,28($sp)
	lw	$4,0($5)
	#nop
	lw	$2,1380($4)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L940
	li	$7,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$7,1			# 0x00000001
$L940:
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
	srl	$2,$2,16
	sltu	$2,$2,500
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L941
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L941:
	sll	$2,$7,3
	subu	$2,$2,$7
	sll	$2,$2,2
	mult	$5,$2
	mflo	$5
	#nop
	#nop
	bltz	$5,$L942
	lh	$2,8($4)
	lw	$3,gNumSlices
	addu	$5,$2,$5
	slt	$2,$5,$3
	bne	$2,$0,$L944
	.set	noreorder
	.set	nomacro
	j	$L944
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L942:
	lh	$2,8($4)
	#nop
	addu	$5,$2,$5
	bgez	$5,$L944
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L944:
	lw	$2,1380($4)
	sw	$0,20($sp)
	sw	$2,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	move	$6,$0
	.set	macro
	.set	reorder

	jal	Dispatch__6Speech
	lw	$3,76($2)
	lw	$5,0($16)
	lh	$4,40($3)
	lw	$3,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop
	.text
	.ent	SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,32($sp)
	move	$18,$4
	sw	$21,44($sp)
	move	$21,$5
	sw	$22,48($sp)
	sw	$31,52($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$4,88($21)
	lw	$19,0($21)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L948
	move	$22,$6
	.set	macro
	.set	reorder

	lw	$16,0($4)
	li	$17,-1			# 0xffffffff
	lw	$2,1380($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L949
	move	$20,$16
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L949:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$19
	.set	macro
	.set	reorder

	li	$3,32768000			# 0x01f40000
	move	$5,$2
	.set	noreorder
	bgez	$5,1f
	move	$4,$5
	subu	$4,$0,$4
1:
	.set	reorder
	slt	$2,$3,$4
	beq	$2,$0,$L950
	move	$3,$4
$L950:
 #APP
 #NO_APP
	li	$4,98304000			# 0x05dc0000
 #APP
 #NO_APP
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L988
	mult	$5,$17
	.set	macro
	.set	reorder

	move	$4,$3
$L988:
	mflo	$8
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$8,$L952
	move	$3,$4
	.set	macro
	.set	reorder

	li	$2,715784192			# 0x2aaa0000
	ori	$2,$2,0xaaab
	mult	$3,$2
	sra	$3,$3,31
	mfhi	$9
	#nop
	#nop
	sra	$2,$9,16
	subu	$2,$2,$3
	mult	$2,$17
	mflo	$5
	#nop
	#nop
	bltz	$5,$L953
	lh	$2,8($19)
	j	$L984
$L953:
	lh	$2,8($19)
	.set	noreorder
	.set	nomacro
	j	$L986
	addu	$16,$2,$5
	.set	macro
	.set	reorder

$L952:
 #APP
 #NO_APP
	li	$2,715784192			# 0x2aaa0000
	ori	$2,$2,0xaaab
	mult	$3,$2
	sra	$3,$3,31
	mfhi	$9
	#nop
	#nop
	sra	$2,$9,16
	subu	$2,$2,$3
	mult	$2,$17
	mflo	$5
	#nop
	#nop
	bltz	$5,$L958
	lh	$2,8($16)
$L984:
	lw	$3,gNumSlices
	addu	$16,$2,$5
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L989
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L958:
	lh	$2,8($20)
	#nop
	addu	$16,$2,$5
$L986:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L989
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
	li	$2,1			# 0x00000001
$L989:
	sh	$2,80($18)
	lw	$2,88($21)
	.set	noreorder
	.set	nomacro
	j	$L969
	sw	$2,36($18)
	.set	macro
	.set	reorder

$L948:
	lw	$2,1380($19)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L963
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L963:
	li	$2,83			# 0x00000053
 #APP
 #NO_APP
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	bltz	$3,$L964
	lh	$2,8($19)
	#nop
	addu	$2,$2,$3
 #APP
 #NO_APP
	lw	$3,gNumSlices
	move	$16,$2
	slt	$2,$16,$3
	bne	$2,$0,$L966
	.set	noreorder
	.set	nomacro
	j	$L966
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L964:
	lh	$2,8($19)
	#nop
	addu	$5,$2,$3
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bgez	$5,$L967
	move	$16,$5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$5,$2
$L967:
$L966:
	sh	$0,80($18)
	sw	$0,36($18)
$L969:
	lw	$3,1364($19)
	#nop
	subu	$2,$0,$3
	.set	noreorder
	.set	nomacro
	bltz	$2,$L970
	sw	$3,56($18)
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	subu	$5,$16,$3
	slt	$2,$5,$4
	bne	$2,$0,$L972
	.set	noreorder
	.set	nomacro
	j	$L972
	subu	$5,$5,$4
	.set	macro
	.set	reorder

$L970:
	subu	$5,$16,$3
	bgez	$5,$L972
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L972:
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	li	$3,-858993459			# 0xcccccccd
	mflo	$2
	#nop
	#nop
	srl	$4,$2,8
	andi	$4,$4,0xffff
	multu	$4,$3
	li	$17,1			# 0x00000001
	sw	$5,52($18)
	sw	$17,AICop_gRoadBlockState
	sw	$2,randtemp
	andi	$2,$2,0xffff
	sw	$2,fastRandom
	mfhi	$3
	#nop
	#nop
	srl	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	subu	$3,$4,$2
	lui	$2,%hi(gBlockadeTypes) # high
	addiu	$2,$2,%lo(gBlockadeTypes) # low
	addu	$2,$3,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L974
	sw	$2,40($18)
	.set	macro
	.set	reorder

	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L975
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$18
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	addu	$5,$18,32
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	j	$L987
	move	$5,$16
	.set	macro
	.set	reorder

$L975:
	.set	noreorder
	.set	nomacro
	jal	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	addu	$5,$18,32
	.set	macro
	.set	reorder

$L974:
	move	$5,$16
$L987:
	lw	$3,0($21)
	li	$2,256			# 0x00000100
	sw	$2,16($sp)
	lw	$4,0($18)
	lw	$6,1364($3)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
	move	$7,$0
	.set	macro
	.set	reorder

	beq	$22,$0,$L977
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L978
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L978:
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,1
	bltz	$3,$L979
	lw	$2,0($18)
	#nop
	lh	$2,8($2)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L981
	.set	noreorder
	.set	nomacro
	j	$L981
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L979:
	lw	$2,0($18)
	#nop
	lh	$2,8($2)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L981
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L981:
 #APP
 #NO_APP
	sw	$3,116($18)
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
	sll	$2,$3,7
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$3,$2,2
	subu	$3,$3,$2
	sll	$2,$3,3
	subu	$2,$2,$3
	srl	$2,$2,16
	li	$3,55705			# 0x0000d999
	addu	$2,$2,$3
	sw	$2,120($18)
	lw	$2,116($18)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$4,29($2)
	sll	$3,$3,15
	srl	$4,$4,4
	mult	$3,$4
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	lw	$3,116($18)
	lw	$4,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$4
	lbu	$5,31($3)
	lbu	$4,29($3)
	sll	$5,$5,15
	andi	$4,$4,0x000f
	mult	$5,$4
	move	$17,$2
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	subu	$5,$0,$17
	lui	$6,%hi(AICop_spikeBelt) # high
	addiu	$4,$6,%lo(AICop_spikeBelt) # low
	lw	$7,116($18)
	lui	$3,%hi(simGlobal+4) # high
	sw	$5,8($4)
	sw	$2,12($4)
	lw	$3,%lo(simGlobal+4)($3)
	li	$16,1			# 0x00000001
	sw	$16,%lo(AICop_spikeBelt)($6)
	sw	$7,4($4)
	sw	$3,16($4)
	lw	$4,116($18)
	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSpikeBelt__Fiii
	addu	$6,$17,$2
	.set	macro
	.set	reorder

	sw	$16,112($18)
$L977:
	jal	Dispatch__6Speech
	lw	$3,76($2)
	lw	$5,0($18)
	lh	$4,40($3)
	lw	$3,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$31,52($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi
	.text
	.ent	_._18AIHigh_BTC_Wingman
_._18AIHigh_BTC_Wingman:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._11AIHigh_Base
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._18AIHigh_BTC_Wingman
	.text
	.ent	_._19AIHigh_BTC_HumanCop
_._19AIHigh_BTC_HumanCop:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._11AIHigh_Base
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._19AIHigh_BTC_HumanCop
	.text
	.ent	___14AIHigh_BTC_Cop
___14AIHigh_BTC_Cop:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___11AIHigh_Base
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___14AIHigh_BTC_Cop
	.text
	.ent	Execute__17AIState_NonActive
Execute__17AIState_NonActive:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Execute__17AIState_NonActive
	.text
	.ent	___17AIState_NonActive
___17AIState_NonActive:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_NonActive_vtable) # high
	addiu	$2,$2,%lo(AIState_NonActive_vtable) # low
	sw	$31,16($sp)
	sw	$2,4($4)
	li	$2,1			# 0x00000001
	lw	$3,0($4)
	andi	$5,$5,0x0001
	sb	$2,145($3)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1006
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1006:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17AIState_NonActive
	.text
	.ent	TestForRelease__12AIState_Base_8005F678
TestForRelease__12AIState_Base_8005F678:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TestForRelease__12AIState_Base_8005F678
	.text
	.ent	___12AIState_Base_8005F680
___12AIState_Base_8005F680:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1011
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1011:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___12AIState_Base_8005F680
