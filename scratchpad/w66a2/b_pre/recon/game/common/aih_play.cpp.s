	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_play.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	AIHigh_Player_kNumArrestsByLap
	.data
	.align	2
AIHigh_Player_kNumArrestsByLap:
	.word	3
	.word	5
	.word	8
	.globl	gBlockadeTypes
	.align	2
gBlockadeTypes:
	.byte	5
	.byte	6
	.byte	4
	.byte	2
	.byte	0
	.text
	.align	2
	.globl	CheckIfABlockadeCanBeSetup__13AIHigh_Player
	.rdata
	.align	2
$LC0:
	.ascii	"\005\006\004\002\000"
	.text
	.align	2
	.globl	SetupBlockade__13AIHigh_Player
	.align	2
	.globl	CheckForNewLevel__13AIHigh_Playeri
	.align	2
	.globl	HandleSpeech__13AIHigh_Player
	.align	2
	.globl	MaintainAvailableCops__13AIHigh_Player
	.align	2
	.globl	__13AIHigh_PlayerP8Car_tObj
	.align	2
	.globl	HandleCops__13AIHigh_Player
	.align	2
	.globl	CleanupBlockaders__13AIHigh_Playeri
	.align	2
	.globl	HandlePullOver__13AIHigh_Player
	.align	2
	.globl	___13AIHigh_Player

	.extern	DashHUD_gInfo, 108
	.extern	simVar, 28
	.extern	AICop_numArrestedHumans, 4
	.extern	simGlobal, 24
	.extern	AI_elapsedTime, 4
	.extern	Cars_gNumAIRaceCars, 4
	.extern	Cars_gNumRaceCars, 4
	.extern	AICop_gRoadBlockState, 4
	.extern	GameSetup_gData, 2600
	.extern	AITune_gRoughLapTime, 4
	.extern	BWorldSm_slices, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	triggerManagerCops, 4
	.extern	gNumSlices, 4
	.extern	Cars_gNumCopCars, 4
	.extern	Cars_gNumHumanRaceCars, 4

	.text
	.text
	.ent	CheckIfABlockadeCanBeSetup__13AIHigh_Player
CheckIfABlockadeCanBeSetup__13AIHigh_Player:
	.frame	$sp,56,$31		# vars= 24, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,48($sp)
	move	$18,$4
	addu	$4,$sp,24
	move	$5,$0
	sw	$17,44($sp)
	addu	$17,$18,140
	sw	$31,52($sp)
	sw	$16,40($sp)
	lw	$16,16($17)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	move	$5,$0
	xori	$2,$2,0x0002
	sltu	$4,$2,1
	lw	$2,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	move	$6,$4
	.set	macro
	.set	reorder

	lw	$2,24($17)
	#nop
	bne	$2,$0,$L601
	lw	$2,112($18)
	lw	$3,0($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L602
	beq	$4,$0,$L601
$L602:
	lw	$2,116($18)
	lw	$3,4($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L600
	bne	$6,$0,$L600
$L601:
	li	$5,1			# 0x00000001
$L600:
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L628
	move	$2,$0
	.set	macro
	.set	reorder

	move	$7,$0
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$11,$2,%lo(highLevelAIObjs) # low
	lw	$9,Cars_gNumCopCars
	lw	$2,12($16)
	li	$10,12			# 0x0000000c
	sw	$2,16($sp)
	lui	$2,%hi(Cars_gCopCarList) # high
	lw	$3,16($16)
	addiu	$8,$2,%lo(Cars_gCopCarList) # low
	sw	$3,20($sp)
$L605:
	slt	$2,$7,$9
	beq	$2,$0,$L606
	lw	$2,0($8)
	#nop
	lw	$3,596($2)
	lw	$2,1392($2)
	sll	$3,$3,2
	addu	$3,$3,$11
	andi	$2,$2,0x000c
	lw	$6,0($3)
	bne	$2,$10,$L607
	lw	$2,24($6)
	#nop
	sll	$4,$2,2
	addu	$3,$sp,$4
	addu	$2,$sp,32
	addu	$5,$2,$4
	lw	$3,16($3)
	lw	$2,0($5)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	addu	$3,$sp,24
	.set	macro
	.set	reorder

	addu	$3,$3,$4
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	lw	$2,0($5)
	#nop
	addu	$2,$2,1
	sw	$2,0($5)
	li	$2,1			# 0x00000001
	sw	$2,32($6)
	sw	$18,36($6)
$L607:
	addu	$8,$8,4
	.set	noreorder
	.set	nomacro
	j	$L605
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L606:
	lw	$3,16($sp)
	lw	$2,32($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$3,20($sp)
	lw	$2,36($sp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L611
$L629:
	lw	$9,Cars_gNumCopCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$12,$2,%lo(highLevelAIObjs) # low
	li	$11,8			# 0x00000008
	li	$10,2			# 0x00000002
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$8,$2,%lo(Cars_gCopCarList) # low
$L613:
	slt	$2,$7,$9
	beq	$2,$0,$L611
	lw	$2,0($8)
	#nop
	lw	$3,596($2)
	lw	$2,1392($2)
	sll	$3,$3,2
	addu	$3,$3,$12
	andi	$2,$2,0x000c
	lw	$6,0($3)
	bne	$2,$11,$L615
	lw	$2,32($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$10,$L615
	addu	$2,$sp,32
	.set	macro
	.set	reorder

	lw	$3,24($6)
	#nop
	sll	$3,$3,2
	addu	$4,$sp,$3
	addu	$5,$2,$3
	lw	$2,16($4)
	lw	$3,0($5)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,0($5)
	li	$2,1			# 0x00000001
	sw	$2,32($6)
	sw	$18,36($6)
$L615:
	addu	$8,$8,4
	.set	noreorder
	.set	nomacro
	j	$L613
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L611:
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,1			# 0x00000001
	beq	$3,$2,$L619
	lw	$3,20($sp)
	lw	$2,36($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$6,Cars_gNumCopCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$11,$2,%lo(highLevelAIObjs) # low
	li	$10,8			# 0x00000008
	li	$9,1			# 0x00000001
	li	$8,4			# 0x00000004
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$5,$2,%lo(Cars_gCopCarList) # low
$L620:
	slt	$2,$7,$6
	beq	$2,$0,$L619
	lw	$2,0($5)
	#nop
	lw	$3,596($2)
	lw	$2,1392($2)
	sll	$3,$3,2
	addu	$3,$3,$11
	andi	$2,$2,0x000c
	lw	$3,0($3)
	bne	$2,$10,$L622
	lw	$2,24($3)
	#nop
	bne	$2,$0,$L622
	lw	$2,20($sp)
	lw	$4,36($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L622
	bne	$4,$0,$L622
	sw	$9,36($sp)
	sw	$8,32($3)
	sw	$18,36($3)
$L622:
	addu	$5,$5,4
	.set	noreorder
	.set	nomacro
	j	$L620
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L619:
	lw	$2,24($sp)
	lw	$3,16($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,28($sp)
	lw	$4,20($sp)
	#nop
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L628
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$2,$0
$L628:
	lw	$31,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CheckIfABlockadeCanBeSetup__13AIHigh_Player
	.text
	.ent	SetupBlockade__13AIHigh_Player
SetupBlockade__13AIHigh_Player:
	.frame	$sp,96,$31		# vars= 40, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$20,72($sp)
	move	$20,$4
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$23,84($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	lw	$4,0($20)
	#nop
	lw	$3,1364($4)
	lw	$19,156($20)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$5,$2,$3
	bltz	$5,$L631
	lh	$2,8($4)
	lw	$3,gNumSlices
	addu	$18,$2,$5
	slt	$2,$18,$3
	bne	$2,$0,$L633
	.set	noreorder
	.set	nomacro
	j	$L633
	subu	$18,$18,$3
	.set	macro
	.set	reorder

$L631:
	lh	$2,8($4)
	#nop
	addu	$18,$2,$5
	bgez	$18,$L633
	lw	$2,gNumSlices
	#nop
	addu	$18,$18,$2
$L633:
	lw	$2,12($19)
	#nop
	sw	$2,16($sp)
	lw	$2,16($19)
	move	$5,$18
	sw	$2,20($sp)
	lw	$2,0($20)
	lw	$4,triggerManagerCops
	lw	$7,1364($2)
	.set	noreorder
	.set	nomacro
	jal	CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$5,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L695
	addu	$6,$sp,40
	.set	macro
	.set	reorder

	lw	$4,triggerManagerCops
	.set	noreorder
	.set	nomacro
	jal	GetTrigger__24AITrigger_TriggerManageriPi
	move	$18,$0
	.set	macro
	.set	reorder

	move	$16,$2
$L636:
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsSliceInAnyVisibleArea__Fi
	move	$17,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L641
	lw	$4,4($16)
	jal	AILife_IsSliceCloseToAnyCopCar__Fi
	beq	$2,$0,$L640
$L641:
	li	$17,1			# 0x00000001
$L640:
	beq	$17,$0,$L637
	lw	$6,4($16)
	lw	$3,gNumSlices
	lw	$4,triggerManagerCops
	addu	$5,$6,1
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	subu	$5,$6,$2
$L643:
	lw	$2,0($20)
	#nop
	lw	$7,1364($2)
	.set	noreorder
	.set	nomacro
	jal	CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$5,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L695
	addu	$6,$sp,40
	.set	macro
	.set	reorder

	lw	$4,triggerManagerCops
	.set	noreorder
	.set	nomacro
	jal	GetTrigger__24AITrigger_TriggerManageriPi
	addu	$18,$18,1
	.set	macro
	.set	reorder

	move	$16,$2
	slt	$2,$18,4
	bne	$2,$0,$L636
$L637:
	lw	$2,20($19)
	lw	$18,4($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	li	$22,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$22,$18
$L646:
	move	$19,$0
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$9,$2,%lo(highLevelAIObjs) # low
	addu	$7,$sp,32
	lui	$2,%hi(Cars_gCopCarList) # high
	lw	$8,Cars_gNumCopCars
	lw	$3,16($sp)
	lw	$4,20($sp)
	addiu	$6,$2,%lo(Cars_gCopCarList) # low
	sw	$0,24($sp)
	sw	$0,28($sp)
	sw	$3,32($sp)
	sw	$4,36($sp)
$L647:
	slt	$2,$19,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	move	$21,$0
	.set	macro
	.set	reorder

	lw	$2,0($6)
	#nop
	lw	$3,596($2)
	lw	$2,1392($2)
	sll	$3,$3,2
	addu	$3,$3,$9
	andi	$2,$2,0x0004
	lw	$4,0($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$3,32($4)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L651
	lw	$2,24($4)
	#nop
	sll	$2,$2,2
	addu	$2,$7,$2
	lw	$2,0($2)
	#nop
	sltu	$5,$5,$2
$L651:
	beq	$5,$0,$L649
	lw	$3,24($4)
	#nop
	sll	$3,$3,2
	addu	$3,$7,$3
	lw	$2,0($3)
	#nop
	addu	$2,$2,-1
	sw	$2,0($3)
	lw	$2,24($4)
	addu	$3,$sp,24
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
$L649:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L647
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L648:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	li	$2,-858993459			# 0xcccccccd
	mflo	$3
	#nop
	#nop
	srl	$4,$3,8
	andi	$4,$4,0xffff
	multu	$4,$2
	move	$17,$21
	move	$19,$21
	li	$7,1			# 0x00000001
	addu	$fp,$20,140
	sw	$0,44($sp)
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	mfhi	$8
	#nop
	#nop
	srl	$3,$8,2
	sll	$2,$3,2
	addu	$2,$2,$3
	subu	$3,$4,$2
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	addu	$2,$3,$2
	lbu	$23,0($2)
$L653:
	lw	$2,Cars_gNumCopCars
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	lui	$3,%hi(Cars_gCopCarList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gCopCarList) # low
	sll	$2,$19,2
	addu	$2,$2,$3
	lui	$10,%hi(highLevelAIObjs) # high
	lw	$3,0($2)
	addiu	$10,$10,%lo(highLevelAIObjs) # low
	lw	$2,596($3)
	lw	$3,1392($3)
	sll	$2,$2,2
	addu	$2,$2,$10
	andi	$3,$3,0x0004
	lw	$4,0($2)
	beq	$3,$0,$L655
	lw	$2,32($4)
	#nop
	bne	$2,$7,$L655
	lw	$2,24($4)
	#nop
	bne	$2,$7,$L658
	lw	$2,20($sp)
	#nop
	beq	$2,$0,$L658
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L659
	addu	$16,$4,32
	.set	macro
	.set	reorder

	move	$21,$4
$L659:
	addu	$2,$2,-1
	sw	$2,20($sp)
	sh	$0,48($16)
	sw	$23,8($16)
	lw	$2,8($fp)
	#nop
	sw	$2,12($16)
	li	$2,2			# 0x00000002
	sw	$2,32($4)
	srl	$2,$17,31
	addu	$2,$17,$2
	sra	$2,$2,1
	lw	$3,0($20)
	sll	$2,$2,1
	lw	$3,1364($3)
	addu	$2,$2,3
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L660
	move	$23,$0
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	addu	$3,$18,$2
	slt	$2,$3,$4
	bne	$2,$0,$L663
	.set	noreorder
	.set	nomacro
	j	$L663
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L660:
	addu	$3,$18,$2
	bgez	$3,$L663
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L663:
	sw	$3,20($16)
	lw	$2,0($20)
	lw	$3,20($16)
	lw	$2,1364($2)
	#nop
	sw	$2,24($16)
	lw	$2,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$2
	lbu	$4,30($3)
	lbu	$5,29($3)
	sll	$4,$4,15
	srl	$2,$5,4
	mult	$4,$2
	lbu	$2,31($3)
	mflo	$4
	#nop
	andi	$5,$5,0x000f
	sll	$2,$2,15
	mult	$2,$5
	lw	$2,28($sp)
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$7,$L664
	addu	$5,$4,$3
	.set	macro
	.set	reorder

	lw	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L664
	srl	$2,$5,1
	.set	macro
	.set	reorder

	subu	$2,$2,$4
	sw	$2,28($16)
	.set	noreorder
	.set	nomacro
	j	$L696
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L664:
	andi	$2,$17,0x0001
	bne	$2,$0,$L666
	lw	$2,20($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	move	$2,$5
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L667
	subu	$3,$0,$10
	.set	macro
	.set	reorder

	addu	$2,$5,3
$L667:
	sra	$2,$2,2
	addu	$2,$3,$2
	sw	$2,28($16)
	.set	noreorder
	.set	nomacro
	j	$L696
	li	$2,190			# 0x000000be
	.set	macro
	.set	reorder

$L666:
	lw	$2,20($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	move	$2,$5
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L669
	subu	$4,$0,$10
	.set	macro
	.set	reorder

	addu	$2,$5,3
$L669:
	sra	$2,$2,2
	sll	$3,$2,1
	addu	$3,$3,$2
	addu	$3,$4,$3
	li	$2,-190			# 0xffffff42
	sw	$3,28($16)
$L696:
	sw	$2,32($16)
	lw	$6,fastRandom
	lw	$2,randSeed
	#nop
	mult	$6,$2
	lw	$5,20($16)
	sw	$20,4($16)
	sw	$0,36($16)
	mflo	$6
	#nop
	#nop
	srl	$3,$6,8
	andi	$3,$3,0xffff
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
	sw	$2,40($16)
	lw	$4,0($20)
	sw	$6,randtemp
	andi	$6,$6,0xffff
	sw	$6,fastRandom
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	sw	$7,48($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$7,48($sp)
	.set	noreorder
	.set	nomacro
	bgez	$3,$L670
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L670:
	sra	$3,$3,16
	subu	$3,$0,$3
	sw	$3,44($16)
	lw	$2,0($20)
	#nop
	lw	$2,1364($2)
	#nop
	mult	$3,$2
	mflo	$10
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$10,$L699
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L699
	sw	$0,44($16)
	.set	macro
	.set	reorder

$L658:
	lw	$2,16($sp)
	#nop
	beq	$2,$0,$L655
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L675
	addu	$16,$4,32
	.set	macro
	.set	reorder

	move	$21,$4
$L675:
	addu	$2,$2,-1
	sw	$2,16($sp)
	sh	$0,48($16)
	sw	$23,8($16)
	lw	$2,8($fp)
	#nop
	sw	$2,12($16)
	li	$2,2			# 0x00000002
	sw	$2,32($4)
	srl	$2,$17,31
	addu	$2,$17,$2
	sra	$2,$2,1
	lw	$3,0($20)
	sll	$2,$2,1
	lw	$3,1364($3)
	addu	$2,$2,3
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L676
	move	$23,$0
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	addu	$3,$18,$2
	slt	$2,$3,$4
	bne	$2,$0,$L679
	.set	noreorder
	.set	nomacro
	j	$L679
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L676:
	addu	$3,$18,$2
	bgez	$3,$L679
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L679:
	sw	$3,20($16)
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	lw	$2,0($20)
	#nop
	lw	$2,1364($2)
	#nop
	sw	$2,24($16)
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
	sltu	$2,$2,300
	beq	$2,$0,$L680
	.set	noreorder
	.set	nomacro
	j	$L681
	sw	$7,36($16)
	.set	macro
	.set	reorder

$L680:
	sw	$0,36($16)
$L681:
	lw	$6,fastRandom
	lw	$2,randSeed
	#nop
	mult	$6,$2
	lw	$5,20($16)
	mflo	$6
	#nop
	#nop
	srl	$3,$6,8
	andi	$3,$3,0xffff
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
	sw	$2,40($16)
	lw	$4,0($20)
	sw	$6,randtemp
	andi	$6,$6,0xffff
	sw	$6,fastRandom
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	sw	$7,48($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$7,48($sp)
	.set	noreorder
	.set	nomacro
	bgez	$3,$L682
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L682:
	sra	$3,$3,16
	subu	$3,$0,$3
	sw	$3,44($16)
	lw	$2,0($20)
	#nop
	lw	$2,1364($2)
	#nop
	mult	$3,$2
	mflo	$10
	#nop
	#nop
	bgez	$10,$L683
	sw	$0,44($16)
$L683:
	lw	$3,20($16)
	lw	$2,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$2
	lbu	$4,30($3)
	lbu	$5,29($3)
	sll	$4,$4,15
	srl	$2,$5,4
	mult	$4,$2
	lbu	$2,31($3)
	mflo	$4
	#nop
	andi	$5,$5,0x000f
	sll	$2,$2,15
	mult	$2,$5
	lw	$2,24($sp)
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$7,$L684
	addu	$5,$4,$3
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	srl	$2,$5,1
	.set	macro
	.set	reorder

	subu	$2,$2,$4
	sw	$2,28($16)
	.set	noreorder
	.set	nomacro
	j	$L697
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L684:
	andi	$2,$17,0x0001
	bne	$2,$0,$L686
	lw	$2,20($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	move	$2,$5
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L687
	subu	$3,$0,$10
	.set	macro
	.set	reorder

	addu	$2,$5,3
$L687:
	sra	$2,$2,2
	addu	$2,$3,$2
	sw	$2,28($16)
	.set	noreorder
	.set	nomacro
	j	$L697
	li	$2,190			# 0x000000be
	.set	macro
	.set	reorder

$L686:
	lw	$2,20($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	move	$2,$5
	mflo	$10
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L689
	subu	$4,$0,$10
	.set	macro
	.set	reorder

	addu	$2,$2,3
$L689:
	sra	$2,$2,2
	sll	$3,$2,1
	addu	$3,$3,$2
	addu	$3,$4,$3
	li	$2,-190			# 0xffffff42
	sw	$3,28($16)
$L697:
	sw	$2,32($16)
	sw	$20,4($16)
	li	$2,-1			# 0xffffffff
$L699:
	.set	noreorder
	.set	nomacro
	beq	$22,$2,$L690
	li	$10,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$10,44($sp)
	sw	$22,16($16)
	move	$22,$2
$L690:
	sw	$7,24($fp)
	addu	$17,$17,1
$L655:
	.set	noreorder
	.set	nomacro
	j	$L653
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L654:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L630
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sh	$2,80($21)
	lw	$10,44($sp)
	#nop
	beq	$10,$0,$L692
	lw	$4,0($21)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,88($3)
	lw	$3,92($3)
	j	$L698
$L695:
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	CheckForNewLevel__13AIHigh_Playeri
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L630
$L692:
	lw	$4,0($21)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,80($3)
	lw	$3,84($3)
$L698:
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$4,0($21)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	lw	$5,0($20)
	lh	$4,48($3)
	lw	$3,52($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

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

	jal	Dispatch__6Speech
	lw	$3,76($2)
	lw	$5,0($21)
	lh	$4,40($3)
	lw	$3,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L630:
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

	.end	SetupBlockade__13AIHigh_Player
	.text
	.ent	CheckForNewLevel__13AIHigh_Playeri
CheckForNewLevel__13AIHigh_Playeri:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	addu	$3,$18,140
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	lw	$2,0($18)
	lw	$19,8($3)
	lw	$2,912($2)
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	move	$16,$19
	.set	macro
	.set	reorder

	move	$16,$3
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L702
	sw	$0,8($16)
	.set	macro
	.set	reorder

	sw	$0,12($16)
$L702:
	lw	$3,8($16)
	lw	$4,4($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$3,$3,$2
	sw	$3,16($16)
	lw	$3,36($3)
	lw	$2,AITune_gRoughLapTime
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L703
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L703:
	sra	$3,$3,16
	sll	$4,$3,5
	li	$2,65536			# 0x00010000
	div	$4,$2,$4
	sll	$3,$3,21
	lui	$2,%hi(GameSetup_gData+4) # high
	sw	$3,140($18)
	sw	$4,28($16)
	lw	$3,%lo(GameSetup_gData+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L704
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L721
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

$L704:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L705
	li	$5,43253			# 0x0000a8f5
	.set	macro
	.set	reorder

$L721:
	jal	fixedmult
	sw	$2,28($16)
$L705:
	sw	$0,24($16)
	.set	noreorder
	.set	nomacro
	j	$L700
	sw	$0,120($18)
	.set	macro
	.set	reorder

$L701:
	lw	$2,20($18)
	#nop
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	lw	$2,120($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	addu	$3,$18,140
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L724
	addu	$4,$18,140
	.set	macro
	.set	reorder

	lw	$3,140($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L710
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
$L710:
	sra	$2,$3,16
	bgtz	$2,$L709
	li	$4,1			# 0x00000001
$L709:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L712
	addu	$4,$18,140
	.set	macro
	.set	reorder

$L724:
	lw	$2,4($4)
	#nop
	lw	$3,0($2)
	addu	$16,$16,1
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L725
	move	$17,$4
	.set	macro
	.set	reorder

	addu	$16,$3,-2
$L725:
	lw	$2,12($17)
	#nop
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L714
	sw	$16,8($17)
	.set	macro
	.set	reorder

	sw	$16,12($17)
$L714:
	lw	$3,8($17)
	lw	$4,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$3,$3,$2
	sw	$3,16($17)
	lw	$3,36($3)
	lw	$2,AITune_gRoughLapTime
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L715
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L715:
	sra	$3,$3,16
	sll	$4,$3,5
	li	$2,65536			# 0x00010000
	div	$4,$2,$4
	sll	$3,$3,21
	lui	$2,%hi(GameSetup_gData+4) # high
	sw	$3,140($18)
	sw	$4,28($17)
	lw	$3,%lo(GameSetup_gData+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L716
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L722
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

$L716:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L717
	li	$5,43253			# 0x0000a8f5
	.set	macro
	.set	reorder

$L722:
	jal	fixedmult
	sw	$2,28($17)
$L717:
	sw	$0,24($17)
$L712:
	addu	$3,$18,140
$L723:
	lw	$2,8($3)
	#nop
	beq	$19,$2,$L700
	lw	$2,triggerManagerCops
	lw	$3,16($3)
	lw	$4,4($2)
	lw	$2,32($3)
	#nop
	mult	$4,$2
	mflo	$6
	#nop
	#nop
	sw	$6,132($18)
$L700:
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

	.end	CheckForNewLevel__13AIHigh_Playeri
	.text
	.ent	HandleSpeech__13AIHigh_Player
HandleSpeech__13AIHigh_Player:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$3,32($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L727
	move	$17,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gCopCarList) # high
	lw	$2,%lo(Cars_gCopCarList)($2)
	#nop
	lw	$17,596($2)
$L727:
	lw	$3,40($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L729
	slt	$2,$3,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L729
	move	$17,$3
$L729:
	lw	$3,48($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L730
	slt	$2,$3,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L730
	move	$17,$3
$L730:
	li	$3,1			# 0x00000001
	lw	$2,0($16)
	lw	$5,24($16)
	lw	$4,596($2)
	.set	noreorder
	.set	nomacro
	beq	$5,$3,$L732
	slt	$2,$5,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L735
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$5,$2,$L737
$L733:
	.set	noreorder
	.set	nomacro
	j	$L738
	li	$16,4			# 0x00000004
	.set	macro
	.set	reorder

$L732:
	.set	noreorder
	.set	nomacro
	jal	Hud_Perp_OverlayOn__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L738
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

$L735:
	.set	noreorder
	.set	nomacro
	jal	Hud_Perp_OverlayOn__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,128($16)
	#nop
	slt	$2,$4,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	li	$16,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L738
	addu	$16,$4,6
	.set	macro
	.set	reorder

$L737:
	.set	noreorder
	.set	nomacro
	jal	Hud_Perp_OverlayOn__Fii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L738:
	lw	$2,AICop_gRoadBlockState
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,AICop_gRoadBlockState
$L740:
	lui	$3,%hi(Cars_gList) # high
	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$4,0($2)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	move	$5,$16
	lh	$4,72($3)
	lw	$3,76($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
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

	.end	HandleSpeech__13AIHigh_Player
	.text
	.ent	MaintainAvailableCops__13AIHigh_Player
MaintainAvailableCops__13AIHigh_Player:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	addu	$4,$sp,16
	move	$5,$0
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumRaceCars
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L743
	li	$9,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L743
	li	$9,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$9,$2
$L743:
	move	$7,$0
	lw	$8,Cars_gNumRaceCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$10,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$6,$2,%lo(Cars_gRaceCarList) # low
$L745:
	slt	$2,$7,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L746
	addu	$7,$7,1
	.set	macro
	.set	reorder

	lw	$2,0($6)
	#nop
	lw	$2,596($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$10
	lw	$5,0($2)
	#nop
	addu	$5,$5,140
	lw	$2,16($5)
	lw	$3,16($sp)
	lw	$2,12($2)
	#nop
	addu	$3,$3,$2
	sw	$3,16($sp)
	lw	$2,16($5)
	lw	$4,20($sp)
	lw	$2,16($2)
	#nop
	addu	$4,$4,$2
	sw	$4,20($sp)
	lw	$2,16($5)
	#nop
	lw	$2,0($2)
	#nop
	addu	$3,$3,$2
	sw	$3,16($sp)
	lw	$2,16($5)
	addu	$6,$6,4
	lw	$2,4($2)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L745
	sw	$4,20($sp)
	.set	macro
	.set	reorder

$L746:
	move	$8,$0
	lw	$10,Cars_gNumCopCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$12,$2,%lo(highLevelAIObjs) # low
	li	$11,1			# 0x00000001
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$7,$2,%lo(Cars_gCopCarList) # low
$L749:
	slt	$2,$8,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	lui	$2,%hi(highLevelAIObjs) # high
	.set	macro
	.set	reorder

	lw	$4,0($7)
	#nop
	lw	$2,596($4)
	lw	$3,1392($4)
	sll	$2,$2,2
	addu	$2,$2,$12
	andi	$3,$3,0x0004
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L754
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,32($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$11,$L754
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$3,$2,$L753
$L754:
	li	$6,1			# 0x00000001
$L753:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L755
	addu	$3,$sp,24
	.set	macro
	.set	reorder

	lw	$2,24($5)
	#nop
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	lw	$2,1392($4)
	addu	$9,$9,-1
	.set	noreorder
	.set	nomacro
	j	$L765
	ori	$2,$2,0x0008
	.set	macro
	.set	reorder

$L755:
	lw	$2,1392($4)
	li	$3,-9			# 0xfffffff7
	and	$2,$2,$3
$L765:
	sw	$2,1392($4)
	addu	$7,$7,4
	.set	noreorder
	.set	nomacro
	j	$L749
	addu	$8,$8,1
	.set	macro
	.set	reorder

$L750:
	move	$7,$0
	lw	$11,Cars_gNumCopCars
	addiu	$12,$2,%lo(highLevelAIObjs) # low
	addu	$10,$sp,16
	addu	$8,$sp,24
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$6,$2,%lo(Cars_gCopCarList) # low
$L757:
	.set	noreorder
	.set	nomacro
	blez	$9,$L764
	slt	$2,$7,$11
	.set	macro
	.set	reorder

	beq	$2,$0,$L764
	lw	$5,0($6)
	#nop
	lw	$2,1392($5)
	#nop
	andi	$2,$2,0x0008
	bne	$2,$0,$L759
	lw	$2,596($5)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$12
	lw	$2,0($2)
	#nop
	lw	$2,24($2)
	#nop
	sll	$2,$2,2
	addu	$3,$10,$2
	addu	$4,$8,$2
	lw	$2,0($3)
	lw	$3,0($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L759
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,0($4)
	lw	$2,1392($5)
	addu	$9,$9,-1
	ori	$2,$2,0x0008
	sw	$2,1392($5)
$L759:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L757
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L764:
	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	MaintainAvailableCops__13AIHigh_Player
	.text
	.ent	__13AIHigh_PlayerP8Car_tObj
__13AIHigh_PlayerP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__16AIHigh_BasicPerpP8Car_tObj
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_Player_vtable) # high
	addiu	$2,$2,%lo(AIHigh_Player_vtable) # low
	lui	$3,%hi(GameSetup_gData) # high
	addiu	$3,$3,%lo(GameSetup_gData) # low
	sw	$2,20($17)
	lw	$2,4($3)
	lw	$3,12($3)
	xori	$2,$2,0x0002
	sltu	$4,$0,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L772
	addu	$5,$17,140
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L773
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L772:
	lw	$2,Cars_gNumAIRaceCars
	#nop
	slt	$2,$0,$2
	sll	$2,$2,2
$L773:
	addu	$3,$2,$4
	sll	$3,$3,3
	lui	$2,%hi(copGame) # high
	addiu	$2,$2,%lo(copGame) # low
	addu	$3,$3,$2
	sw	$3,4($5)
 #APP
 #NO_APP
	move	$2,$3
 #APP
 #NO_APP
	sw	$0,8($5)
	lw	$3,8($5)
	sw	$0,0($5)
	sw	$0,12($5)
	lw	$4,4($2)
	sw	$0,24($5)
	sw	$0,32($5)
	sw	$0,20($5)
	sw	$0,28($5)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$4,$4,$2
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$6,$2,%lo(GameSetup_gData) # low
	sw	$4,16($5)
	sw	$0,124($17)
	sw	$0,128($17)
	lw	$2,20($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L777
	addu	$5,$17,140
	.set	macro
	.set	reorder

	lw	$2,triggerManagerCops
	lw	$3,16($5)
	lw	$4,4($2)
	lw	$2,32($3)
	#nop
	mult	$4,$2
	lw	$2,0($17)
	mflo	$7
	#nop
	#nop
	sw	$7,132($17)
	lh	$2,8($2)
	move	$16,$5
	sw	$2,136($17)
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L778
	sw	$0,8($16)
	.set	macro
	.set	reorder

	sw	$0,12($16)
$L778:
	lw	$3,8($16)
	lw	$4,4($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$3,$3,$2
	sw	$3,16($16)
	lw	$3,36($3)
	lw	$2,AITune_gRoughLapTime
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L779
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L779:
	sra	$3,$3,16
	sll	$4,$3,5
	li	$2,65536			# 0x00010000
	div	$4,$2,$4
	sll	$3,$3,21
	sw	$3,140($17)
	sw	$4,28($16)
	lw	$3,4($6)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L780
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L783
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

$L780:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L781
	li	$5,43253			# 0x0000a8f5
	.set	macro
	.set	reorder

$L783:
	jal	fixedmult
	sw	$2,28($16)
$L781:
	sw	$0,24($16)
$L777:
	move	$2,$17
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

	.end	__13AIHigh_PlayerP8Car_tObj
	.text
	.ent	HandleCops__13AIHigh_Player
HandleCops__13AIHigh_Player:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,Cars_gNumCopCars
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	addu	$16,$17,140
	sw	$31,28($sp)
	sw	$18,24($sp)
	lw	$18,16($16)
	beq	$2,$0,$L784
	jal	MaintainAvailableCops__13AIHigh_Player
	.set	noreorder
	.set	nomacro
	jal	CheckIfABlockadeCanBeSetup__13AIHigh_Player
	move	$4,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L786
	.set	noreorder
	.set	nomacro
	jal	SetupBlockade__13AIHigh_Player
	move	$4,$17
	.set	macro
	.set	reorder

$L786:
	lw	$2,8($18)
	#nop
	bne	$2,$0,$L787
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	CleanupBlockaders__13AIHigh_Playeri
	move	$5,$0
	.set	macro
	.set	reorder

$L787:
	lw	$2,0($17)
	#nop
	lw	$3,1380($2)
	lw	$2,1364($2)
	#nop
	mult	$3,$2
	move	$5,$16
	lw	$2,112($17)
	lw	$3,116($17)
	lw	$6,AI_elapsedTime
	addu	$2,$2,$3
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L788
	srl	$4,$7,31
	.set	macro
	.set	reorder

	sw	$0,32($16)
	lw	$3,140($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L790
	move	$2,$3
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$3,$2
$L790:
	sra	$2,$2,16
	slt	$2,$2,-1
	bne	$2,$0,$L796
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L797
	sll	$2,$6,15
	.set	macro
	.set	reorder

	sll	$2,$6,16
$L797:
	subu	$2,$3,$2
	sw	$2,140($17)
	lw	$4,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L794
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$4,$4,$2
$L794:
	lw	$2,16($5)
	#nop
	lw	$3,36($2)
	lw	$2,AITune_gRoughLapTime
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L795
	sra	$4,$4,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
$L795:
	sra	$2,$3,16
	sll	$2,$2,5
	addu	$2,$2,-128
	slt	$2,$4,$2
	beq	$2,$0,$L796
	lw	$2,28($5)
	#nop
	mult	$2,$6
	lw	$2,20($5)
	mflo	$7
	#nop
	#nop
	addu	$2,$2,$7
	.set	noreorder
	.set	nomacro
	j	$L796
	sw	$2,20($5)
	.set	macro
	.set	reorder

$L788:
	lw	$2,32($16)
	#nop
	addu	$2,$2,$6
	sw	$2,32($16)
$L796:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	CheckForNewLevel__13AIHigh_Playeri
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HandlePullOver__13AIHigh_Player
	move	$4,$17
	.set	macro
	.set	reorder

$L784:
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

	.end	HandleCops__13AIHigh_Player
	.text
	.ent	CleanupBlockaders__13AIHigh_Playeri
CleanupBlockaders__13AIHigh_Playeri:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,0($19)
	#nop
	lw	$2,936($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L800
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$2,912($3)
	#nop
	slt	$2,$2,2
	beq	$2,$0,$L800
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L808
	move	$17,$0
	.set	macro
	.set	reorder

$L800:
	li	$18,1			# 0x00000001
	move	$17,$0
$L808:
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$20,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$16,$2,%lo(Cars_gCopCarList) # low
$L803:
	lw	$2,Cars_gNumCopCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L798
	lw	$2,0($16)
	#nop
	lw	$2,596($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$4,0($2)
	li	$2,1			# 0x00000001
	lw	$3,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L806
	addu	$5,$4,32
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L806
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$3,$2,$L805
	beq	$18,$0,$L805
$L806:
	lw	$2,4($5)
	#nop
	bne	$2,$19,$L805
	sw	$0,0($5)
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$0
	.set	macro
	.set	reorder

$L805:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L803
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L798:
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

	.end	CleanupBlockaders__13AIHigh_Playeri
	.text
	.ent	HandlePullOver__13AIHigh_Player
HandlePullOver__13AIHigh_Player:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,24($17)
	#nop
	beq	$2,$0,$L811
	lw	$2,100($17)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L810
	sw	$2,100($17)
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$4,596($2)
	#nop
	slt	$2,$4,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L845
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	jal	Hud_Perp_OverlayOff__Fi
	lui	$2,%hi(simGlobal+4) # high
$L845:
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,24($17)
	sw	$2,104($17)
	li	$2,3			# 0x00000003
	bne	$3,$2,$L814
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L815
	lw	$2,AICop_numArrestedHumans
	#nop
	addu	$2,$2,1
	sw	$2,AICop_numArrestedHumans
$L815:
	lw	$2,0($17)
	#nop
	sw	$3,912($2)
$L814:
	lw	$3,AICop_numArrestedHumans
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L846
	addu	$16,$17,140
	.set	macro
	.set	reorder

	lui	$3,%hi(simVar+4) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(simVar+4)($3)
	.set	noreorder
	.set	nomacro
	jal	Stats_ExtrapolateOpponentTimes__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$16,$17,140
$L846:
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L817
	sw	$0,8($16)
	.set	macro
	.set	reorder

	sw	$0,12($16)
$L817:
	lw	$3,8($16)
	lw	$4,4($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$3,$3,$2
	sw	$3,16($16)
	lw	$3,36($3)
	lw	$2,AITune_gRoughLapTime
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L818
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L818:
	sra	$3,$3,16
	sll	$4,$3,5
	li	$2,65536			# 0x00010000
	div	$4,$2,$4
	sll	$3,$3,21
	lui	$2,%hi(GameSetup_gData+4) # high
	sw	$3,140($17)
	sw	$4,28($16)
	lw	$3,%lo(GameSetup_gData+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L819
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L820
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

$L819:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L823
	li	$5,43253			# 0x0000a8f5
	.set	macro
	.set	reorder

$L820:
	jal	fixedmult
	sw	$2,28($16)
$L823:
	move	$4,$17
	sw	$0,24($16)
	.set	noreorder
	.set	nomacro
	jal	RemoveCloseCops__16AIHigh_BasicPerp
	sw	$0,120($17)
	.set	macro
	.set	reorder

	lw	$3,24($17)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L825
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	#nop
	bne	$3,$2,$L825
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L824
$L825:
	lw	$4,0($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$5
	.set	macro
	.set	reorder

$L824:
	lw	$3,24($17)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L826
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L827
	sw	$0,632($2)
	.set	macro
	.set	reorder

$L826:
	lw	$3,Cars_gNumHumanRaceCars
	#nop
	bne	$3,$2,$L827
	lw	$2,AICop_numArrestedHumans
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L827
	lui	$3,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$2,596($2)
	addiu	$3,$3,%lo(DashHUD_gInfo) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$0,28($2)
$L827:
	.set	noreorder
	.set	nomacro
	j	$L810
	sw	$0,24($17)
	.set	macro
	.set	reorder

$L811:
	.set	noreorder
	.set	nomacro
	jal	CheckIfCaught__16AIHigh_BasicPerp
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L810
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$17
	lw	$3,0($17)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	jal	CleanupBlockaders__13AIHigh_Playeri
	sw	$2,632($3)
	.set	macro
	.set	reorder

	addu	$5,$17,140
	lw	$6,16($5)
	lw	$2,AITune_gRoughLapTime
	lw	$3,36($6)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L830
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L830:
	lw	$4,140($17)
	sra	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$4,$L831
	sll	$3,$2,5
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$4,$4,$2
$L831:
	lw	$2,44($6)
	#nop
	sw	$2,100($17)
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,104($17)
	sra	$2,$4,16
	subu	$7,$3,$2
	lw	$3,120($17)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L832
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$2,932($2)
	#nop
	bne	$2,$0,$L832
	lw	$3,12($5)
	lw	$4,4($5)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,48($2)
	#nop
	beq	$2,$0,$L832
	lw	$2,16($5)
	#nop
	lw	$2,40($2)
	#nop
	slt	$6,$7,$2
$L832:
	beq	$6,$0,$L833
	lw	$4,124($17)
	#nop
	slt	$2,$4,2
	beq	$2,$0,$L833
	lw	$2,156($17)
	#nop
	lw	$2,48($2)
	lw	$3,0($17)
	addu	$2,$4,$2
	sw	$2,124($17)
	lw	$2,928($3)
	#nop
	addu	$2,$2,1
	sw	$2,928($3)
	.set	noreorder
	.set	nomacro
	j	$L844
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L833:
	lw	$2,128($17)
	lw	$3,0($17)
	addu	$2,$2,1
	sw	$2,128($17)
	lw	$2,932($3)
	#nop
	addu	$2,$2,1
	sw	$2,932($3)
	lui	$2,%hi(GameSetup_gData+4) # high
	lw	$4,%lo(GameSetup_gData+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L836
	move	$3,$2
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L847
	lui	$2,%hi(AIHigh_Player_kNumArrestsByLap) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L847
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L836:
	move	$3,$0
	lui	$2,%hi(AIHigh_Player_kNumArrestsByLap) # high
$L847:
	addiu	$2,$2,%lo(AIHigh_Player_kNumArrestsByLap) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,128($17)
	lw	$3,0($3)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L841
	addu	$3,$17,140
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lw	$2,0($2)
	lw	$3,12($3)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L844
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L840
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L841:
	li	$2,3			# 0x00000003
	sw	$2,24($17)
	lw	$2,100($17)
	lw	$3,0($17)
	addu	$2,$2,192
	sw	$2,100($17)
	lw	$2,936($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L834
	sw	$2,936($3)
	.set	macro
	.set	reorder

$L840:
$L844:
	sw	$2,24($17)
$L834:
	.set	noreorder
	.set	nomacro
	jal	HandleSpeech__13AIHigh_Player
	move	$4,$17
	.set	macro
	.set	reorder

$L810:
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

	.end	HandlePullOver__13AIHigh_Player
	.text
	.ent	___13AIHigh_Player
___13AIHigh_Player:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(_vt_16AIHigh_BasicPerp) # high
	addiu	$2,$2,%lo(_vt_16AIHigh_BasicPerp) # low
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

	.end	___13AIHigh_Player
