	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_btcperp.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	strategyChart
	.data
	.align	2
strategyChart:
	.byte	4
	.byte	4
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.globl	AIHigh_BTC_uTurnProb1000Skills
	.align	2
AIHigh_BTC_uTurnProb1000Skills:
	.word	3
	.word	4
	.word	5
	.text
	.align	2
	.globl	ReleaseCops__15AIHigh_BTC_Perp
	.align	2
	.globl	HandleCops__15AIHigh_BTC_Perp
	.align	2
	.globl	IsFalseArrest__15AIHigh_BTC_Perp
	.align	2
	.globl	CheckForControlsPressed__15AIHigh_BTC_Perp
	.align	2
	.globl	HandlePullOver__15AIHigh_BTC_Perp
	.align	2
	.globl	NotifyCopsOfArrest__15AIHigh_BTC_Perp
	.align	2
	.globl	NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
	.align	2
	.globl	NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
	.align	2
	.globl	NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
	.align	2
	.globl	ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
	.align	2
	.globl	CheckForActivation__15AIHigh_BTC_Perp
	.align	2
	.globl	NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop
	.align	2
	.globl	HighExecute__20AIHigh_BTC_HumanPerp
	.align	2
	.globl	__17AIHigh_BTC_AIPerpP8Car_tObj
	.align	2
	.globl	_._17AIHigh_BTC_AIPerp
	.align	2
	.globl	AvoidCops__17AIHigh_BTC_AIPerp
	.align	2
	.globl	CalculateTimeTillContact__17AIHigh_BTC_AIPerp
	.align	2
	.globl	FindClosestCop__17AIHigh_BTC_AIPerp
	.align	2
	.globl	HighExecute__17AIHigh_BTC_AIPerp
	.align	2
	.globl	NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop
	.align	2
	.globl	_._20AIHigh_BTC_HumanPerp
	.align	2
	.globl	___15AIHigh_BTC_Perp_80061348
	.align	2
	.globl	Execute__17AIState_NonActive_80061370
	.align	2
	.globl	___17AIState_NonActive_80061378
	.align	2
	.globl	TestForRelease__12AIState_Base_800613C4
	.align	2
	.globl	___12AIState_Base_800613CC

	.extern	AICop_gRoadBlockState, 4
	.extern	Camera_gInfo, 544
	.extern	gNumSlices, 4
	.extern	GameSetup_gData, 2600
	.extern	simGlobal, 24
	.extern	AI_elapsedTime, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	Cars_gNumCars, 4

	.text
	.text
	.ent	ReleaseCops__15AIHigh_BTC_Perp
ReleaseCops__15AIHigh_BTC_Perp:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
$L602:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L601
	lw	$3,0($16)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L604
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L604
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp
	move	$5,$18
	.set	macro
	.set	reorder

$L604:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L602
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L601:
	lw	$2,0($18)
	#nop
	sw	$0,1884($2)
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

	.end	ReleaseCops__15AIHigh_BTC_Perp
	.text
	.ent	HandleCops__15AIHigh_BTC_Perp
HandleCops__15AIHigh_BTC_Perp:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	HandlePullOver__15AIHigh_BTC_Perp
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HandleCops__15AIHigh_BTC_Perp
	.text
	.ent	IsFalseArrest__15AIHigh_BTC_Perp
IsFalseArrest__15AIHigh_BTC_Perp:
	.frame	$sp,64,$31		# vars= 16, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	subu	$sp,$sp,64
	sw	$19,44($sp)
	move	$19,$4
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
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
	lw	$3,0($19)
	sll	$2,$2,3
	lw	$3,608($3)
	#nop
	andi	$3,$3,0x0004
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L608
	srl	$2,$2,16
	.set	macro
	.set	reorder

	slt	$2,$2,980
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	move	$2,$0
	.set	macro
	.set	reorder

	move	$21,$0
	lui	$2,%hi(Cars_gList) # high
	addiu	$20,$2,%lo(Cars_gList) # low
$L611:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$5,0($20)
	#nop
	lw	$2,608($5)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L613
	lw	$2,0($19)
	lw	$4,160($5)
	lw	$2,160($2)
	#nop
	subu	$4,$4,$2
	sw	$4,16($sp)
	lw	$3,0($19)
	lw	$2,164($5)
	lw	$3,164($3)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,0($19)
	lw	$2,168($5)
	lw	$3,168($3)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,0($19)
	#nop
	lw	$5,240($2)
	jal	fixedmult
	lw	$3,0($19)
	lw	$4,20($sp)
	lw	$5,244($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$3,0($19)
	lw	$4,24($sp)
	lw	$5,248($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$18,$18,$16
	lw	$3,0($19)
	lw	$4,16($sp)
	lw	$5,264($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$18,$18,$2
	.set	macro
	.set	reorder

	lw	$3,0($19)
	lw	$4,20($sp)
	lw	$5,268($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$3,0($19)
	lw	$4,24($sp)
	lw	$5,272($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	addu	$17,$17,$2
 #APP
 #NO_APP
	bgez	$18,$L614
	subu	$18,$0,$18
$L614:
 #APP
 #NO_APP
	li	$2,196608			# 0x00030000
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	li	$2,524288			# 0x00080000
	.set	macro
	.set	reorder

	slt	$2,$2,$17
	bne	$2,$0,$L616
	.set	noreorder
	.set	nomacro
	bgez	$17,$L619
	addu	$20,$20,4
	.set	macro
	.set	reorder

$L616:
	lw	$4,0($19)
	li	$5,2			# 0x00000002
	li	$6,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	AudioClc_HonkHorn__FP8Car_tObjiii
	li	$7,32			# 0x00000020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L618
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L613:
	addu	$20,$20,4
$L619:
	.set	noreorder
	.set	nomacro
	j	$L611
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L608:
	move	$2,$0
$L618:
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

	.end	IsFalseArrest__15AIHigh_BTC_Perp
	.text
	.ent	CheckForControlsPressed__15AIHigh_BTC_Perp
CheckForControlsPressed__15AIHigh_BTC_Perp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lw	$3,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	move	$4,$0
	.set	macro
	.set	reorder

	lhu	$2,1084($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	addu	$3,$3,1084
	.set	macro
	.set	reorder

	lbu	$3,9($3)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L621
$L622:
	li	$4,1			# 0x00000001
$L621:
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L623
	lui	$2,%hi(Cars_gHumanRaceCarList+4) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(Cars_gHumanRaceCarList+4)($2)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L623
	lhu	$2,1084($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	addu	$3,$3,1084
	.set	macro
	.set	reorder

	lbu	$3,9($3)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L623
$L624:
	li	$4,1			# 0x00000001
$L623:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	CheckForControlsPressed__15AIHigh_BTC_Perp
	.text
	.ent	HandlePullOver__15AIHigh_BTC_Perp
HandlePullOver__15AIHigh_BTC_Perp:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,24($16)
	#nop
	beq	$2,$0,$L626
	jal	NotifyCopsOfArrest__15AIHigh_BTC_Perp
	lw	$2,100($16)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L627
	sw	$2,100($16)
	.set	macro
	.set	reorder

	lw	$2,128($16)
	#nop
	bne	$2,$0,$L627
	.set	noreorder
	.set	nomacro
	jal	IsFalseArrest__15AIHigh_BTC_Perp
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	move	$4,$16
	addu	$2,$2,-640
	.set	noreorder
	.set	nomacro
	jal	NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
	sw	$2,104($16)
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sw	$0,632($2)
	lui	$2,%hi(Cars_gList) # high
	sw	$0,24($16)
	lw	$4,%lo(Cars_gList)($2)
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

	j	$L627
$L628:
	lw	$2,128($16)
	#nop
	bne	$2,$0,$L627
	.set	noreorder
	.set	nomacro
	jal	NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,128($16)
$L627:
	.set	noreorder
	.set	nomacro
	jal	CheckForControlsPressed__15AIHigh_BTC_Perp
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,100($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L625
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$2,24($16)
	#nop
	beq	$2,$0,$L625
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L625
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$17,128($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L625
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,104($16)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,321
	bne	$2,$0,$L625
	move	$4,$16
	sw	$3,104($16)
	.set	noreorder
	.set	nomacro
	jal	NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
	sw	$0,120($16)
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sw	$0,632($2)
	sw	$0,24($16)
	sw	$17,124($16)
	.set	noreorder
	.set	nomacro
	j	$L625
	sw	$0,128($16)
	.set	macro
	.set	reorder

$L626:
	lw	$2,132($16)
	#nop
	lw	$2,112($2)
	#nop
	slt	$2,$2,6
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	move	$3,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckIfCaught__16AIHigh_BasicPerp
	move	$4,$16
	.set	macro
	.set	reorder

	sltu	$3,$0,$2
$L633:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L625
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	sw	$2,632($3)
	li	$2,96			# 0x00000060
	sw	$2,100($16)
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	li	$2,2			# 0x00000002
	sw	$2,24($16)
	sw	$3,104($16)
$L625:
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

	.end	HandlePullOver__15AIHigh_BTC_Perp
	.text
	.ent	NotifyCopsOfArrest__15AIHigh_BTC_Perp
NotifyCopsOfArrest__15AIHigh_BTC_Perp:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
$L638:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L635
	lw	$3,0($16)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0220
	beq	$2,$0,$L640
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L640
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$19
	.set	macro
	.set	reorder

$L640:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L638
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L635:
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

	.end	NotifyCopsOfArrest__15AIHigh_BTC_Perp
	.text
	.ent	NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
$L645:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L642
	lw	$3,0($16)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0220
	beq	$2,$0,$L647
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L647
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$19
	.set	macro
	.set	reorder

$L647:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L645
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L642:
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

	.end	NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
	.text
	.ent	NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
$L652:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L649
	lw	$3,0($16)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0220
	beq	$2,$0,$L654
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L654
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
	move	$5,$19
	.set	macro
	.set	reorder

$L654:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L652
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L649:
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

	.end	NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp
	.text
	.ent	NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
$L659:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L656
	lw	$3,0($16)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L661
	lbu	$2,145($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$2,596($3)
	lw	$7,108($18)
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj
	move	$6,$0
	.set	macro
	.set	reorder

$L661:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L659
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L656:
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

	.end	NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp
	.text
	.ent	ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop:
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
	jal	Clear__16AIHigh_BasicPerp
	move	$17,$5
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,1			# 0x00000001
	sw	$0,112($16)
	sw	$0,116($16)
	sw	$2,120($16)
	sw	$0,124($16)
	sw	$0,616($3)
	lw	$2,0($17)
	lw	$3,0($16)
	lw	$2,612($2)
	#nop
	sw	$2,612($3)
	sw	$0,124($17)
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

	.end	ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
	.text
	.ent	CheckForActivation__15AIHigh_BTC_Perp
CheckForActivation__15AIHigh_BTC_Perp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$11,$4
	move	$7,$0
	lw	$8,Cars_gNumCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$10,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$9,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$6,$2,%lo(Cars_gList) # low
$L667:
	slt	$2,$7,$8
	beq	$2,$0,$L666
	lw	$3,0($6)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L669
	lbu	$2,145($3)
	#nop
	beq	$2,$0,$L669
	lw	$2,596($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$10
	lw	$5,0($2)
	#nop
	lw	$2,28($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$3,124($5)
$L670:
	beq	$3,$0,$L669
	lw	$4,0($11)
	#nop
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L672
$L676:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

$L672:
	lw	$3,100($5)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$9
	lw	$3,648($4)
	lw	$4,444($2)
	lw	$2,0($3)
	#nop
	beq	$4,$2,$L676
$L669:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L667
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L666:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CheckForActivation__15AIHigh_BTC_Perp
	.text
	.ent	NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop
NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop:
	.frame	$sp,48,$31		# vars= 8, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$18,40($sp)
	move	$18,$5
	sw	$31,44($sp)
	sw	$17,36($sp)
	lw	$17,128($18)
	.set	noreorder
	.set	nomacro
	jal	ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
	sw	$18,132($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ReleaseCops__15AIHigh_BTC_Perp
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	li	$7,1			# 0x00000001
	lw	$6,0($16)
	sll	$5,$17,4
	mflo	$2
	#nop
	#nop
	sw	$2,randtemp
	andi	$2,$2,0xffff
	sw	$2,fastRandom
	.set	noreorder
	.set	nomacro
	bltz	$5,$L678
	move	$8,$7
	.set	macro
	.set	reorder

	lw	$2,0($18)
	lw	$4,gNumSlices
	lh	$3,8($2)
	lhu	$2,8($2)
	addu	$3,$3,$5
	slt	$3,$3,$4
	bne	$3,$0,$L679
	lhu	$3,gNumSlices
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$L680
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L679:
	addu	$2,$2,$5
$L680:
	.set	noreorder
	.set	nomacro
	j	$L681
	sh	$2,8($6)
	.set	macro
	.set	reorder

$L678:
	lw	$3,0($18)
	#nop
	lh	$2,8($3)
	lhu	$4,8($3)
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L682
	addu	$2,$4,$5
	.set	macro
	.set	reorder

	lhu	$3,gNumSlices
	.set	noreorder
	.set	nomacro
	j	$L683
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L682:
	addu	$3,$4,$5
$L683:
	sh	$3,8($6)
$L681:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L684
	mult	$7,$17
	.set	macro
	.set	reorder

	lw	$2,0($16)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	j	$L685
	sw	$9,1360($2)
	.set	macro
	.set	reorder

$L684:
	lw	$3,0($16)
	mflo	$9
	#nop
	#nop
	subu	$2,$0,$9
	sw	$2,1360($3)
$L685:
	lw	$2,0($16)
	#nop
	lw	$3,1360($2)
	addu	$5,$sp,24
	sw	$3,1364($2)
	lw	$4,0($16)
	addu	$6,$sp,28
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$6,28($sp)
	lh	$5,8($2)
	sw	$0,16($sp)
	sw	$0,20($sp)
	lw	$4,0($16)
	lw	$7,1364($2)
	jal	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	lw	$4,0($18)
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

	jal	Dispatch__6Speech
	lw	$3,76($2)
	lw	$5,0($16)
	lh	$4,8($3)
	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$4,0($18)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($16)
	lh	$4,8($3)
	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$4,0($18)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($16)
	lh	$4,48($3)
	lw	$3,52($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	jal	TrgSfx_RestartTrgSfx__Fv
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

	.end	NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop
	.text
	.ent	HighExecute__20AIHigh_BTC_HumanPerp
HighExecute__20AIHigh_BTC_HumanPerp:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,124($16)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L688
	jal	CheckForActivation__15AIHigh_BTC_Perp
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop
	move	$5,$2
	.set	macro
	.set	reorder

	j	$L687
$L688:
	.set	noreorder
	.set	nomacro
	jal	HandleCops__15AIHigh_BTC_Perp
	move	$4,$16
	.set	macro
	.set	reorder

$L687:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HighExecute__20AIHigh_BTC_HumanPerp
	.text
	.ent	__17AIHigh_BTC_AIPerpP8Car_tObj
__17AIHigh_BTC_AIPerpP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__16AIHigh_BasicPerpP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_BTC_HumanPerp_vtable+64) # high
	addiu	$2,$2,%lo(AIHigh_BTC_HumanPerp_vtable+64) # low
	sw	$2,20($16)
	li	$2,1			# 0x00000001
	sw	$2,124($16)
	lui	$2,%hi(AIHigh_BTC_AIPerp_vtable) # high
	lw	$3,0($16)
	addiu	$2,$2,%lo(AIHigh_BTC_AIPerp_vtable) # low
	sw	$2,20($16)
	li	$2,64000			# 0x0000fa00
	sw	$0,128($16)
	sw	$0,132($16)
	sw	$0,136($16)
	sw	$0,140($16)
	sw	$0,144($16)
	sw	$2,148($16)
	sw	$0,152($16)
	lw	$2,184($3)
	#nop
	sw	$2,156($16)
	lw	$3,188($3)
	move	$2,$16
	sw	$0,164($2)
	sw	$0,168($2)
	sw	$3,160($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__17AIHigh_BTC_AIPerpP8Car_tObj
	.text
	.ent	_._17AIHigh_BTC_AIPerp
_._17AIHigh_BTC_AIPerp:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIHigh_BTC_AIPerp_vtable) # high
	sw	$31,16($sp)
	lw	$6,0($4)
	lw	$3,156($4)
	addiu	$2,$2,%lo(AIHigh_BTC_AIPerp_vtable) # low
	sw	$2,20($4)
	sw	$3,184($6)
	lw	$3,0($4)
	lw	$2,160($4)
	#nop
	sw	$2,188($3)
	lui	$2,%hi(AIHigh_BasicPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicPerp_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	_._11AIHigh_Base
	sw	$2,20($4)
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

	.end	_._17AIHigh_BTC_AIPerp
	.text
	.ent	AvoidCops__17AIHigh_BTC_AIPerp
AvoidCops__17AIHigh_BTC_AIPerp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$4
	lw	$4,164($9)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L719
	move	$10,$0
	.set	macro
	.set	reorder

	lw	$2,1120($4)
	#nop
	bne	$2,$0,$L719
	lw	$6,0($9)
	lw	$5,1364($4)
	lw	$2,1364($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L719
	li	$3,32702464			# 0x01f30000
	.set	macro
	.set	reorder

	lw	$7,168($9)
	ori	$3,$3,0xffff
	.set	noreorder
	bgez	$7,1f
	move	$2,$7
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$3,$3,$2
	bne	$3,$0,$L719
	lw	$3,1396($6)
	lw	$2,1396($4)
	#nop
	subu	$3,$3,$2
	mult	$3,$5
	mflo	$3
	#nop
	#nop
	mult	$7,$5
	lw	$6,308($4)
	#nop
	subu	$2,$0,$6
	slt	$2,$3,$2
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	move	$8,$10
	.set	macro
	.set	reorder

	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$8,2			# 0x00000002
$L710:
	li	$2,1638400			# 0x00190000
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,164($9)
	#nop
	lw	$3,316($2)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1638400			# 0xffe70000
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	subu	$2,$0,$3
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$6,3			# 0x00000003
$L711:
	lui	$2,%hi(strategyChart) # high
	addiu	$2,$2,%lo(strategyChart) # low
	sll	$3,$6,1
	addu	$3,$3,$6
	addu	$3,$8,$3
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	lui	$2,%hi(strategyChart) # high
	.set	macro
	.set	reorder

	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$7,0($9)
	#nop
	lw	$4,632($7)
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	andi	$2,$2,0xffff
	sw	$3,fastRandom
	sll	$3,$2,5
	subu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	sll	$3,$3,3
	lw	$2,AI_elapsedTime
	srl	$3,$3,16
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$2,$4,5
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$5,$5,$2
	sltu	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L715
	li	$3,1114112			# 0x00110000
	.set	macro
	.set	reorder

	lw	$2,164($9)
	#nop
	lw	$2,1380($2)
	ori	$3,$3,0xc71c
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	lui	$2,%hi(strategyChart) # high
	.set	macro
	.set	reorder

	lw	$2,1380($7)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	lui	$2,%hi(strategyChart) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L719
	li	$10,1			# 0x00000001
	.set	macro
	.set	reorder

$L715:
	lui	$2,%hi(strategyChart) # high
$L727:
	addiu	$2,$2,%lo(strategyChart) # low
	sll	$3,$6,1
	addu	$3,$3,$6
	addu	$3,$8,$3
	addu	$3,$3,$2
	lbu	$2,0($3)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	lui	$4,%hi(AIHigh_BTC_uTurnProb1000Skills) # high
	.set	macro
	.set	reorder

	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$2,%lo(GameSetup_gData+8)($2)
	addiu	$4,$4,%lo(AIHigh_BTC_uTurnProb1000Skills) # low
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$4,0($2)
	mflo	$3
	#nop
	lw	$2,AI_elapsedTime
	#nop
	mult	$4,$2
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
	mflo	$5
	#nop
	#nop
	sltu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	li	$4,1114112			# 0x00110000
	.set	macro
	.set	reorder

	lw	$2,164($9)
	#nop
	lw	$2,1380($2)
	ori	$4,$4,0xc71c
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$4,$2
	beq	$2,$0,$L719
	lw	$3,0($9)
	#nop
	lw	$2,1380($3)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$4,$2
	beq	$2,$0,$L719
	lw	$4,1364($3)
	lw	$2,1360($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L719
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	sw	$2,1360($3)
$L719:
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L725
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($9)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,632($3)
	.set	macro
	.set	reorder

$L725:
	lw	$2,0($9)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,632($2)
	.set	macro
	.set	reorder

	.end	AvoidCops__17AIHigh_BTC_AIPerp
	.text
	.ent	CalculateTimeTillContact__17AIHigh_BTC_AIPerp
CalculateTimeTillContact__17AIHigh_BTC_AIPerp:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,164($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L736
	li	$2,64000			# 0x0000fa00
	.set	macro
	.set	reorder

	lw	$2,136($16)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L736
	li	$2,64000			# 0x0000fa00
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lw	$3,1380($2)
	lw	$2,1380($4)
	lw	$4,168($16)
	subu	$5,$3,$2
	addu	$3,$5,32767
	li	$2,65534			# 0x0000fffe
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	li	$2,65536000			# 0x03e80000
	.set	macro
	.set	reorder

	jal	fixeddiv
	bgez	$2,$L731
	addu	$2,$2,1023
$L731:
	sra	$2,$2,10
	subu	$2,$0,$2
$L730:
	sw	$2,148($16)
	lw	$2,148($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L728
	li	$2,64000			# 0x0000fa00
	.set	macro
	.set	reorder

$L736:
	sw	$2,148($16)
$L728:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalculateTimeTillContact__17AIHigh_BTC_AIPerp
	.text
	.ent	FindClosestCop__17AIHigh_BTC_AIPerp
FindClosestCop__17AIHigh_BTC_AIPerp:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$20,32($sp)
	li	$20,655294464			# 0x270f0000
	sw	$18,24($sp)
	move	$18,$20
	sw	$19,28($sp)
	li	$19,-1			# 0xffffffff
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gHumanRaceCarList) # low
	sw	$31,40($sp)
$L740:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L739
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$5,0($16)
	#nop
	lw	$2,608($5)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L742
	lw	$4,0($21)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$3,$2
	.set	noreorder
	bgez	$2,1f
	move	$4,$2
	subu	$4,$0,$4
1:
	.set	reorder
	slt	$2,$4,$18
	beq	$2,$0,$L742
	move	$20,$3
	lw	$2,0($16)
	move	$18,$4
	lw	$19,596($2)
$L742:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L740
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L739:
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L745
	lui	$2,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$0,164($21)
	.set	macro
	.set	reorder

$L745:
	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$3,$19,2
	addu	$3,$3,$2
	lw	$2,0($3)
	sw	$20,168($21)
	sw	$2,164($21)
$L737:
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

	.end	FindClosestCop__17AIHigh_BTC_AIPerp
	.text
	.ent	HighExecute__17AIHigh_BTC_AIPerp
HighExecute__17AIHigh_BTC_AIPerp:
	.frame	$sp,48,$31		# vars= 16, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$31,44($sp)
	sw	$18,40($sp)
	sw	$16,32($sp)
	lw	$2,0($17)
	#nop
	lbu	$2,145($2)
	#nop
	beq	$2,$0,$L749
	jal	FindClosestCop__17AIHigh_BTC_AIPerp
	.set	noreorder
	.set	nomacro
	jal	CalculateTimeTillContact__17AIHigh_BTC_AIPerp
	move	$4,$17
	.set	macro
	.set	reorder

$L749:
	lw	$3,8($17)
	#nop
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	lui	$2,%hi($L787) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L787) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L787:
	.word	$L774
	.word	$L752
	.word	$L752
	.word	$L750
	.word	$L750
	.word	$L750
	.word	$L750
	.word	$L777
	.word	$L750
	.word	$L750
	.word	$L780
	.text
$L752:
	lw	$3,136($17)
	#nop
	sltu	$2,$3,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L769
	lui	$2,%hi($L770) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L770) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L770:
	.word	$L753
	.word	$L757
	.word	$L760
	.word	$L753
	.word	$L761
	.word	$L753
	.text
$L757:
	lw	$2,148($17)
	#nop
	slt	$2,$2,320
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,144($17)
	lw	$2,136($17)
	li	$16,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L790
	lui	$3,%hi(Camera_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,132($17)
	#nop
	lw	$4,0($2)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($17)
	lh	$4,8($3)
	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lui	$3,%hi(Camera_gInfo) # high
$L790:
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sw	$16,136($17)
	sw	$16,128($3)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	sw	$16,400($3)
	sb	$2,132($3)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	.set	noreorder
	.set	nomacro
	j	$L753
	sb	$2,404($3)
	.set	macro
	.set	reorder

$L760:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	j	$L753
	sw	$2,136($17)
	.set	macro
	.set	reorder

$L761:
	lui	$2,%hi(simGlobal) # high
	addiu	$16,$2,%lo(simGlobal) # low
	lw	$3,4($16)
	lw	$4,144($17)
	lw	$2,152($17)
	subu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L762
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	sw	$2,136($17)
	.set	noreorder
	.set	nomacro
	jal	ReleaseCops__15AIHigh_BTC_Perp
	move	$4,$17
	.set	macro
	.set	reorder

$L762:
	lw	$2,4($16)
	lw	$4,144($17)
	lw	$3,152($17)
	subu	$2,$2,$4
	addu	$3,$3,-64
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L763
	lui	$2,%hi(Camera_gInfo) # high
	.set	macro
	.set	reorder

	addiu	$16,$2,%lo(Camera_gInfo) # low
	lw	$2,128($16)
	#nop
	beq	$2,$0,$L764
	lw	$2,132($17)
	#nop
	lw	$4,0($2)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($17)
	lh	$4,48($3)
	lw	$3,52($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Camera_ResetRelPos__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

$L764:
	sw	$0,128($16)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	sw	$0,400($16)
	sb	$2,132($16)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	#nop
	sb	$2,404($16)
$L763:
	lw	$2,132($17)
	lw	$4,0($17)
	lw	$5,0($2)
	lw	$2,1364($4)
	lw	$3,1364($5)
	#nop
	bne	$3,$2,$L753
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	lw	$4,0($17)
	#nop
	lw	$3,1364($4)
	#nop
	mult	$2,$3
	mflo	$8
	#nop
	#nop
	blez	$8,$L753
	lw	$4,1380($4)
	#nop
	bgez	$4,$L767
	subu	$4,$0,$4
$L767:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	lw	$3,132($17)
	#nop
	sw	$2,136($3)
$L753:
	lw	$3,136($17)
$L769:
	li	$2,5			# 0x00000005
	bne	$3,$2,$L750
	.set	noreorder
	.set	nomacro
	jal	HandleCops__15AIHigh_BTC_Perp
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,24($17)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L772
	.set	noreorder
	.set	nomacro
	jal	AvoidCops__17AIHigh_BTC_AIPerp
	move	$4,$17
	.set	macro
	.set	reorder

$L772:
	lw	$2,124($17)
	#nop
	beq	$2,$0,$L750
$L774:
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

	addu	$4,$sp,16
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(AIHigh_BTC_AIPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BTC_AIPerp_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($18)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	addu	$6,$sp,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	sw	$2,20($sp)
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
	beq	$3,$0,$L776
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

$L776:
	li	$2,7			# 0x00000007
	sw	$18,4($17)
	sw	$2,8($17)
	.set	noreorder
	.set	nomacro
	j	$L750
	sw	$0,136($17)
	.set	macro
	.set	reorder

$L777:
	.set	noreorder
	.set	nomacro
	jal	CheckForActivation__15AIHigh_BTC_Perp
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L750
	sw	$0,12($17)
	.set	macro
	.set	reorder

$L778:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L750
	sw	$2,12($17)
	.set	macro
	.set	reorder

$L780:
	lw	$2,136($17)
	#nop
	bne	$2,$0,$L781
	lw	$2,148($17)
	#nop
	slt	$2,$2,320
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,144($17)
	lw	$2,136($17)
	li	$16,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L791
	lui	$3,%hi(Camera_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,132($17)
	#nop
	lw	$4,0($2)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($17)
	lh	$4,8($3)
	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lui	$3,%hi(Camera_gInfo) # high
$L791:
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sw	$16,136($17)
	sw	$16,128($3)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	sw	$16,400($3)
	sb	$2,132($3)
	lw	$2,0($17)
	#nop
	lbu	$2,596($2)
	.set	noreorder
	.set	nomacro
	j	$L750
	sb	$2,404($3)
	.set	macro
	.set	reorder

$L781:
	lw	$18,136($17)
	li	$2,2			# 0x00000002
	bne	$18,$2,$L750
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
	beq	$3,$0,$L786
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

$L786:
	li	$2,4			# 0x00000004
	sw	$16,4($17)
	sw	$18,8($17)
	sw	$2,136($17)
$L750:
	lw	$4,4($17)
	jal	StateExecute__12AIState_Base
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

	.end	HighExecute__17AIHigh_BTC_AIPerp
	.text
	.ent	NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop
NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop:
	.frame	$sp,64,$31		# vars= 8, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,44($sp)
	move	$19,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	lw	$17,100($16)
	lw	$21,0($16)
	.set	noreorder
	.set	nomacro
	jal	ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
	sw	$16,132($19)
	.set	macro
	.set	reorder

	move	$4,$0
$L793:
	sll	$2,$4,2
	lw	$3,0($19)
	addu	$4,$4,1
	addu	$3,$3,$2
	slt	$2,$4,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L793
	sw	$0,536($3)
	.set	macro
	.set	reorder

	lw	$2,0($19)
	#nop
	sh	$0,2228($2)
	lw	$2,0($19)
	#nop
	sh	$0,2230($2)
	lui	$2,%hi(GameSetup_gData+84) # high
	lw	$2,%lo(GameSetup_gData+84)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L797
	li	$2,51			# 0x00000033
	.set	macro
	.set	reorder

	lw	$3,0($19)
	#nop
	sh	$2,2228($3)
	lw	$3,0($19)
	li	$2,2			# 0x00000002
	sh	$2,2230($3)
$L797:
	lw	$2,0($19)
	#nop
	sh	$0,2232($2)
	lw	$2,0($19)
	li	$4,1			# 0x00000001
	sh	$0,2234($2)
	lw	$2,0($19)
	lui	$3,%hi(Camera_gInfo) # high
	sh	$0,2174($2)
	lw	$2,0($19)
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sw	$4,1884($2)
	sw	$4,128($3)
	lw	$2,0($19)
	#nop
	lbu	$2,596($2)
	sw	$4,400($3)
	sb	$2,132($3)
	lw	$2,0($19)
	#nop
	lbu	$2,596($2)
	.set	noreorder
	.set	nomacro
	jal	Object_ClearCustomObjects__Fv
	sb	$2,404($3)
	.set	macro
	.set	reorder

	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	lw	$10,128($16)
	sw	$0,AICop_gRoadBlockState
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
	slt	$2,$2,333
	lw	$3,132($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	li	$7,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$9,$0
	li	$20,1			# 0x00000001
	li	$2,851968			# 0x000d0000
	ori	$2,$2,0x5555
	sw	$2,1372($21)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L799
	sw	$2,136($16)
	.set	macro
	.set	reorder

	li	$2,640			# 0x00000280
	sw	$2,152($19)
	.set	noreorder
	.set	nomacro
	j	$L801
	li	$3,225			# 0x000000e1
	.set	macro
	.set	reorder

$L799:
	li	$2,384			# 0x00000180
	sw	$2,152($19)
	.set	noreorder
	.set	nomacro
	j	$L801
	li	$3,400			# 0x00000190
	.set	macro
	.set	reorder

$L798:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L802
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$9,$0
	move	$20,$7
	li	$2,2883584			# 0x002c0000
	ori	$2,$2,0x71c7
	li	$3,400			# 0x00000190
	sw	$2,1372($21)
	sw	$2,136($16)
	.set	noreorder
	.set	nomacro
	j	$L821
	li	$2,384			# 0x00000180
	.set	macro
	.set	reorder

$L802:
	li	$3,40			# 0x00000028
 #APP
 #NO_APP
	move	$9,$7
	move	$20,$0
	li	$2,2883584			# 0x002c0000
	ori	$2,$2,0x71c7
	sw	$2,1372($21)
	sw	$2,136($16)
	li	$2,480			# 0x000001e0
$L821:
	sw	$2,152($19)
$L801:
	li	$2,715784192			# 0x2aaa0000
	ori	$2,$2,0xaaab
	mult	$3,$2
	mfhi	$3
	#nop
	#nop
	mult	$3,$7
	mflo	$3
	#nop
	#nop
	mult	$3,$10
	lw	$8,0($19)
	mflo	$4
	#nop
	#nop
	bltz	$4,$L804
	lhu	$2,8($21)
	lw	$3,gNumSlices
	addu	$6,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L806
	move	$5,$6
	.set	macro
	.set	reorder

	lhu	$2,gNumSlices
	#nop
	subu	$5,$6,$2
$L806:
	.set	noreorder
	.set	nomacro
	j	$L805
	sh	$5,8($8)
	.set	macro
	.set	reorder

$L804:
	lhu	$2,8($21)
	#nop
	addu	$5,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$2,$L807
	move	$3,$5
	.set	macro
	.set	reorder

	lhu	$2,gNumSlices
	#nop
	addu	$3,$2,$5
$L807:
	sh	$3,8($8)
$L805:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$9,$2,$L808
	mult	$7,$10
	.set	macro
	.set	reorder

	lw	$2,0($19)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	j	$L809
	sw	$11,1360($2)
	.set	macro
	.set	reorder

$L808:
	lw	$3,0($19)
	mflo	$11
	#nop
	#nop
	subu	$2,$0,$11
	sw	$2,1360($3)
$L809:
	lw	$2,0($19)
	#nop
	lw	$3,1360($2)
	addu	$5,$sp,24
	sw	$3,1364($2)
	lw	$4,0($19)
	addu	$6,$sp,28
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$2,0($19)
	lw	$6,28($sp)
	move	$3,$2
	li	$2,1			# 0x00000001
	lh	$5,8($3)
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L812
	li	$2,2031616			# 0x001f0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L822
	ori	$2,$2,0x1c71
	.set	macro
	.set	reorder

$L812:
	li	$2,1114112			# 0x00110000
	ori	$2,$2,0xc71c
$L822:
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$4,0($19)
	lw	$7,1364($3)
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	lui	$18,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Camera_Update__Fv
	addiu	$18,$18,%lo(GameSetup_gData) # low
	.set	macro
	.set	reorder

	sll	$16,$17,1
	addu	$16,$16,$17
	sll	$16,$16,2
	addu	$16,$16,$17
	sll	$16,$16,2
	addu	$16,$16,$18
	lui	$17,%hi(AITune_BTC) # high
	addiu	$17,$17,%lo(AITune_BTC) # low
	lw	$3,8($18)
	lw	$4,492($16)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$5,0($2)
	jal	fixedmult
	lw	$3,0($19)
	#nop
	sw	$2,1868($3)
	lw	$3,8($18)
	lw	$4,484($16)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$5,4($2)
	jal	fixedmult
	lw	$3,0($19)
	#nop
	sw	$2,1724($3)
	lw	$4,156($19)
	lw	$5,488($16)
	jal	fixedmult
	lw	$4,8($18)
	#nop
	sll	$3,$4,3
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$5,8($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,0($19)
	#nop
	sw	$2,184($3)
	lw	$2,0($19)
	#nop
	lw	$5,184($2)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,0($19)
	#nop
	sw	$2,188($3)
	lw	$4,0($19)
	lw	$5,460($16)
	jal	AIPerson_SetPersonality__FP8Car_tObji
	lw	$4,0($19)
	lw	$5,448($16)
	jal	R3DCar_ChangeTrafficColor__FP8Car_tObji
	lw	$2,0($19)
	#nop
	lw	$3,648($2)
	lw	$2,452($16)
	#nop
	sw	$2,156($3)
	lw	$2,0($19)
	#nop
	lw	$3,648($2)
	lw	$2,456($16)
	#nop
	.set	noreorder
	.set	nomacro
	jal	Hud_InitMap__Fv
	sw	$2,148($3)
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,140($19)
	li	$2,1			# 0x00000001
	bne	$20,$2,$L814
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L816
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

$L816:
	li	$2,2			# 0x00000002
	sw	$16,4($19)
	sw	$2,8($19)
	.set	noreorder
	.set	nomacro
	j	$L817
	sw	$20,136($19)
	.set	macro
	.set	reorder

$L814:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$4,$2
	li	$6,1			# 0x00000001
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_CruiseP8Car_tObj12cruiseMode_ti
	li	$7,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$3,4($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L819
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

$L819:
	li	$2,10			# 0x0000000a
	sw	$16,4($19)
	sw	$2,8($19)
	sw	$0,136($19)
$L817:
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	move	$4,$21
	.set	macro
	.set	reorder

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

	jal	Dispatch__6Speech
	lw	$3,76($2)
	lw	$5,0($19)
	lh	$4,8($3)
	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	jal	TrgSfx_RestartTrgSfx__Fv
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

	.end	NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop
	.text
	.ent	_._20AIHigh_BTC_HumanPerp
_._20AIHigh_BTC_HumanPerp:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIHigh_BasicPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicPerp_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._11AIHigh_Base
	sw	$2,20($4)
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

	.end	_._20AIHigh_BTC_HumanPerp
	.text
	.ent	___15AIHigh_BTC_Perp_80061348
___15AIHigh_BTC_Perp_80061348:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIHigh_BasicPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicPerp_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	___11AIHigh_Base
	sw	$2,20($4)
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

	.end	___15AIHigh_BTC_Perp_80061348
	.text
	.ent	Execute__17AIState_NonActive_80061370
Execute__17AIState_NonActive_80061370:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Execute__17AIState_NonActive_80061370
	.text
	.ent	___17AIState_NonActive_80061378
___17AIState_NonActive_80061378:
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
	beq	$5,$0,$L833
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L833:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17AIState_NonActive_80061378
	.text
	.ent	TestForRelease__12AIState_Base_800613C4
TestForRelease__12AIState_Base_800613C4:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TestForRelease__12AIState_Base_800613C4
	.text
	.ent	___12AIState_Base_800613CC
___12AIState_Base_800613CC:
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
	beq	$5,$0,$L838
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L838:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___12AIState_Base_800613CC
