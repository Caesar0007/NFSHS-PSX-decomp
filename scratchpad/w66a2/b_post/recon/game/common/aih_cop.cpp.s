	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_cop.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	AIHigh_Cop_AggressionData
	.data
	.align	2
AIHigh_Cop_AggressionData:
	.word	10
	.word	655360
	.word	851968
	.word	512
	.word	512
	.word	8
	.word	917504
	.word	983040
	.word	768
	.word	512
	.word	4
	.word	1179648
	.word	1179648
	.word	1152
	.word	1024
	.globl	AICop_skillDelay
	.align	2
AICop_skillDelay:
	.word	3276
	.word	6553
	.word	65536
	.globl	AIH_Cop_chasePositions
	.align	2
AIH_Cop_chasePositions:
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
	.globl	NitroDistanceMeters
	.align	2
NitroDistanceMeters:
	.word	3932160
	.word	1638400
	.word	3932160
	.word	1638400
	.text
	.align	2
	.globl	__10AIHigh_CopP8Car_tObji
	.align	2
	.globl	SetTuningLevers__10AIHigh_Cop
	.align	2
	.globl	HighExecute__10AIHigh_Cop
	.align	2
	.globl	CheckForNeedyPlayers__10AIHigh_Cop
	.align	2
	.globl	CheckForWipeOut__10AIHigh_Cop
	.align	2
	.globl	CheckForNewTarget__10AIHigh_Cop
	.align	2
	.globl	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	.align	2
	.globl	GetCheckChasePosition__10AIHigh_CopP8coorddef
	.align	2
	.globl	CheckForNewTriggers__10AIHigh_Cop
	.align	2
	.globl	___10AIHigh_Cop

	.extern	gNumSlices, 4
	.extern	Cars_gNumCars, 4
	.extern	AI_elapsedTime, 4
	.extern	Cars_gNumRaceCars, 4
	.extern	AITune_gRoughLapTime, 4
	.extern	gWSavePtr, 4
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	AICop_gRoadBlockState, 4
	.extern	BWorldSm_slices, 4
	.extern	AICop_spikeBelt, 20
	.extern	simGlobal, 24
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	GameSetup_gData, 2600
	.extern	triggerManagerCops, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumHumanRaceCars, 4

	.text
	.text
	.ent	__10AIHigh_CopP8Car_tObji
__10AIHigh_CopP8Car_tObji:
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
	lui	$3,%hi(AIHigh_Cop_vtable) # high
	addiu	$3,$3,%lo(AIHigh_Cop_vtable) # low
	sw	$3,20($2)
	li	$3,-1			# 0xffffffff
	sw	$0,88($2)
	sw	$0,96($2)
	sw	$3,100($2)
	sw	$0,92($2)
	sw	$0,104($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__10AIHigh_CopP8Car_tObji
	.text
	.ent	SetTuningLevers__10AIHigh_Cop
SetTuningLevers__10AIHigh_Cop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	lw	$5,0($7)
	li	$2,1			# 0x00000001
	lw	$3,648($5)
	lw	$4,24($7)
	lw	$6,0($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L607
	lui	$3,%hi(copTuningInfo) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(copTuningInfo) # low
	addu	$2,$6,-22
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,12($2)
	#nop
	sw	$3,1736($5)
	lw	$3,0($7)
	lw	$2,4($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1740($3)
	.set	macro
	.set	reorder

$L607:
	addiu	$3,$3,%lo(copTuningInfo) # low
	addu	$2,$6,-22
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,8($2)
	#nop
	sw	$3,1736($5)
	lw	$3,0($7)
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1740($3)
	.set	macro
	.set	reorder

	.end	SetTuningLevers__10AIHigh_Cop
	.text
	.ent	HighExecute__10AIHigh_Cop
HighExecute__10AIHigh_Cop:
	.frame	$sp,136,$31		# vars= 72, regs= 5/0, args= 40, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$17,116($sp)
	move	$17,$4
	sw	$31,128($sp)
	sw	$19,124($sp)
	sw	$18,120($sp)
	sw	$16,112($sp)
	lw	$2,0($17)
	#nop
	sw	$0,616($2)
	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	jal	CheckSpikeBelt__15AIHigh_BasicCop
	sw	$0,612($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForWipeOut__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetTuningLevers__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,8($17)
	#nop
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi($L759) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L759) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L759:
	.word	$L610
	.word	$L616
	.word	$L646
	.word	$L685
	.word	$L656
	.word	$L736
	.word	$L645
	.word	$L645
	.word	$L645
	.word	$L755
	.word	$L645
	.text
$L610:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,0($17)
	#nop
	lw	$2,1392($4)
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0400
	beq	$2,$0,$L611
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
	beq	$3,$0,$L613
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

$L613:
	.set	noreorder
	.set	nomacro
	j	$L761
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L611:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L615
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

$L615:
	li	$2,1			# 0x00000001
$L761:
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	j	$L608
	sw	$2,8($17)
	.set	macro
	.set	reorder

$L616:
	lw	$4,0($17)
	#nop
	lw	$2,1392($4)
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$3,32($17)
	li	$2,-1			# 0xffffffff
	sw	$2,100($17)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L617
	sw	$0,84($17)
	.set	macro
	.set	reorder

	sw	$0,32($17)
$L617:
	lw	$3,32($17)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L618
	lw	$5,36($17)
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$4,$17
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
	beq	$3,$0,$L620
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

$L620:
	lw	$2,64($17)
	li	$3,3			# 0x00000003
	sw	$16,4($17)
	sw	$3,8($17)
	sw	$2,16($sp)
	lw	$4,0($17)
	lw	$5,52($17)
	lw	$6,56($17)
	lw	$7,60($17)
	jal	AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
	lw	$2,48($17)
	.set	noreorder
	.set	nomacro
	j	$L645
	sw	$2,100($17)
	.set	macro
	.set	reorder

$L618:
	lw	$2,0($17)
	#nop
	lw	$2,1392($2)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$3,$2,$L645
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTriggers__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$3,$sp,40
	addu	$4,$2,64
$L624:
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	lw	$12,12($2)
	sw	$9,0($3)
	sw	$10,4($3)
	sw	$11,8($3)
	sw	$12,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L624
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$9,0($2)
	lw	$10,4($2)
	sw	$9,0($3)
	sw	$10,4($3)
	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L625
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(Cars_gHumanRaceCarList)($2)
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	lw	$5,4($2)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	li	$3,19595264			# 0x012b0000
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L625
	li	$16,1			# 0x00000001
$L625:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L627
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,44($sp)
	sw	$2,40($sp)
	sw	$2,56($sp)
	sw	$2,48($sp)
	sw	$2,52($sp)
$L627:
	lw	$4,triggerManagerCops
	.set	noreorder
	.set	nomacro
	jal	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	lw	$18,40($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L628
	slt	$2,$18,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L645
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L645
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$4,48($sp)
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	nor	$3,$0,$4
	.set	macro
	.set	reorder

	xori	$3,$4,0x0001
$L632:
	sltu	$2,$3,1
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L765
	move	$4,$17
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,48($sp)
	#.set	novolatile
	#nop
	bne	$2,$0,$L645
$L765:
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,104			# 0x00000068
	.set	macro
	.set	reorder

	addu	$19,$sp,64
	sw	$19,16($sp)
	lw	$3,100($sp)
	#nop
	sw	$3,20($sp)
	lw	$3,104($sp)
	move	$4,$2
	sw	$3,24($sp)
	lw	$3,108($sp)
	addu	$18,$sp,52
	sw	$3,28($sp)
	lw	$5,0($17)
	lw	$6,44($sp)
	.set	noreorder
	.set	nomacro
	jal	__15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii
	move	$7,$18
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L636
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

$L636:
	li	$6,1			# 0x00000001
	li	$2,5			# 0x00000005
	sw	$16,4($17)
	sw	$2,8($17)
	sw	$19,16($sp)
	lw	$4,0($17)
	lw	$5,44($sp)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	move	$7,$18
	.set	macro
	.set	reorder

	j	$L645
$L628:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	mflo	$3
	#nop
	#nop
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$19,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$19,1			# 0x00000001
$L638:
	lw	$2,56($sp)
	#nop
	beq	$2,$0,$L639
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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
	beq	$3,$0,$L641
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

$L641:
	.set	noreorder
	.set	nomacro
	j	$L762
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L639:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$0
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
	beq	$3,$0,$L644
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

$L644:
	li	$2,3			# 0x00000003
$L762:
	sw	$16,4($17)
	sw	$2,8($17)
	lw	$2,56($sp)
	move	$6,$19
	sw	$2,16($sp)
	lw	$4,0($17)
	lw	$5,44($sp)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
	move	$7,$6
	.set	macro
	.set	reorder

	j	$L645
$L646:
	li	$2,-1			# 0xffffffff
	sw	$2,100($17)
	lw	$2,32($17)
	li	$5,1			# 0x00000001
	beq	$2,$5,$L647
	li	$18,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L772
	li	$4,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$3,1392($2)
	#nop
	and	$3,$3,$4
	sw	$3,1392($2)
	lw	$2,32($17)
	#nop
	beq	$2,$5,$L647
$L772:
	beq	$2,$18,$L647
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L647
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__10AIHigh_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,148			# 0x00000094
	.set	macro
	.set	reorder

	lui	$4,%hi(AIHigh_Cop_AggressionData) # high
	lw	$5,104($17)
	addiu	$4,$4,%lo(AIHigh_Cop_AggressionData) # low
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$4
	lw	$4,88($17)
	lw	$3,16($3)
	lw	$6,0($4)
	lui	$4,%hi(NitroDistanceMeters) # high
	sw	$3,16($sp)
	lw	$3,24($17)
	addiu	$4,$4,%lo(NitroDistanceMeters) # low
	sll	$3,$3,3
	addu	$3,$3,$4
	lw	$3,0($3)
	#nop
	sw	$3,20($sp)
	lw	$3,24($17)
	#nop
	sll	$3,$3,3
	addu	$3,$3,$4
	move	$4,$2
	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$3,4($3)
	lw	$2,%lo(GameSetup_gData+8)($2)
	sw	$3,24($sp)
	lw	$3,104($17)
	sll	$2,$2,2
	sw	$3,28($sp)
	lui	$3,%hi(AICop_skillDelay) # high
	addiu	$3,$3,%lo(AICop_skillDelay) # low
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
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
	beq	$3,$0,$L652
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

$L652:
	lw	$4,0($17)
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	sw	$18,8($17)
	.set	macro
	.set	reorder

	lw	$3,88($17)
	lw	$6,76($2)
	lw	$5,0($3)
	lh	$4,48($6)
	lw	$3,52($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L647:
	lw	$2,92($17)
	#nop
	bne	$2,$0,$L653
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	beq	$2,$0,$L645
$L653:
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	sw	$0,92($17)
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

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L655
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

$L655:
	.set	noreorder
	.set	nomacro
	j	$L763
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L656:
	lw	$3,0($17)
	#nop
	lw	$2,1392($3)
	lw	$18,4($17)
	ori	$2,$2,0x0002
	sw	$2,1392($3)
	lw	$2,144($18)
	#nop
	slt	$2,$2,161
	bne	$2,$0,$L657
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
	beq	$3,$0,$L659
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

$L659:
	lw	$4,0($17)
	li	$2,9			# 0x00000009
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

$L657:
	lw	$3,88($17)
	lw	$2,24($17)
	lw	$3,156($3)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L766
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L766
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$0,124($18)
$L766:
	sw	$2,100($17)
	lui	$2,%hi(simGlobal) # high
	addiu	$16,$2,%lo(simGlobal) # low
	lw	$2,4($16)
	lw	$3,140($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L661
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForNeedyPlayers__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	nor	$2,$0,$2
	sltu	$4,$0,$2
$L661:
	beq	$4,$0,$L662
	lw	$2,4($16)
	#nop
	addu	$2,$2,960
	sw	$2,140($18)
$L662:
	.set	noreorder
	.set	nomacro
	jal	HandleBlockadeSpeech__15AIHigh_BasicCop
	move	$4,$17
	.set	macro
	.set	reorder

	move	$16,$0
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__10AIHigh_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	beq	$2,$0,$L663
	lw	$2,112($18)
	#nop
	sltu	$16,$2,1
$L663:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L664
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

$L664:
	lui	$3,%hi(AIHigh_Cop_AggressionData) # high
	addiu	$3,$3,%lo(AIHigh_Cop_AggressionData) # low
	lw	$4,104($17)
	#nop
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,0($2)
	lw	$4,120($18)
	lw	$6,8($2)
	slt	$3,$3,$4
	lw	$4,4($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L665
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,108($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,$4
	beq	$2,$0,$L665
	lw	$2,104($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$5,$2,$6
$L665:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L667
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_Cop_AggressionData) # high
	lw	$5,104($17)
	addiu	$2,$2,%lo(AIHigh_Cop_AggressionData) # low
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$6,12($3)
	.set	noreorder
	.set	nomacro
	jal	SetMurderMode__13AIState_Chaseii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L667:
	move	$16,$0
	lw	$2,88($17)
	move	$4,$17
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	jal	ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
	li	$5,16384			# 0x00004000
	.set	macro
	.set	reorder

	beq	$2,$0,$L668
	lw	$2,112($18)
	#nop
	sltu	$16,$2,1
$L668:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L669
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$16,$sp,56
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
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

	move	$4,$18
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetMurderMode__13AIState_Chaseii
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

$L669:
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__10AIHigh_Cop
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$sp,56
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__10AIHigh_CopP8coorddef
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

$L670:
	lw	$3,32($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L674
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L767
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,88($17)
	#nop
	beq	$2,$0,$L672
	lw	$2,0($2)
	#nop
	lw	$2,912($2)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L671
$L672:
	li	$2,1			# 0x00000001
$L767:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L674
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	bne	$3,$2,$L673
$L674:
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,0($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
$L675:
	sw	$4,1360($3)
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	sw	$2,1776($3)
$L673:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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
	beq	$3,$0,$L677
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

$L677:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	sw	$2,8($17)
$L671:
	lw	$2,92($17)
	#nop
	bne	$2,$0,$L679
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	beq	$2,$0,$L678
$L679:
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	beq	$2,$0,$L680
	lw	$2,84($17)
	#nop
	bne	$2,$0,$L680
	lw	$4,0($17)
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

$L680:
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
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	sw	$0,92($17)
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
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L682
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

$L682:
	.set	noreorder
	.set	nomacro
	j	$L763
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L678:
	lw	$2,84($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L773
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

$L685:
	lw	$3,32($17)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$6,$L687
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	bne	$3,$2,$L686
$L687:
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,0($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
$L688:
	move	$4,$17
	sw	$5,1360($3)
	lw	$2,0($17)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	sw	$6,1776($2)
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
	beq	$3,$0,$L690
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

$L690:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	sw	$2,8($17)
$L686:
	lw	$2,92($17)
	#nop
	beq	$2,$0,$L691
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	sw	$0,92($17)
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

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L693
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

$L693:
	.set	noreorder
	.set	nomacro
	j	$L763
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L691:
	lw	$2,84($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+48) # high
$L773:
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,0($17)
	bne	$2,$0,$L695
	li	$6,-1			# 0xffffffff
$L695:
	move	$4,$17
	move	$5,$0
	sw	$6,1360($3)
	lw	$2,0($17)
	li	$18,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	sw	$18,1776($2)
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
	beq	$3,$0,$L697
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

$L697:
	lw	$3,84($17)
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L698
	sw	$2,8($17)
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$5
	.set	macro
	.set	reorder

$L698:
	.set	noreorder
	.set	nomacro
	j	$L645
	sw	$0,84($17)
	.set	macro
	.set	reorder

$L694:
	lw	$3,32($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L699
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$3,1392($2)
	#nop
	ori	$3,$3,0x0002
	sw	$3,1392($2)
	lw	$3,100($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L700
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(AICop_spikeBelt) # high
	lw	$2,%lo(AICop_spikeBelt)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L768
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$3,%lo(GameSetup_gData+8)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L701
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L703
	li	$16,58982			# 0x0000e666
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L703
	li	$16,52428			# 0x0000cccc
	.set	macro
	.set	reorder

$L701:
	li	$16,45875			# 0x0000b333
$L703:
	lw	$2,100($17)
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
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,100($17)
	lw	$4,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$4
	lbu	$5,31($3)
	lbu	$4,29($3)
	sll	$5,$5,15
	andi	$4,$4,0x000f
	mult	$5,$4
	move	$5,$16
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$5,$0,$16
	lui	$8,%hi(AICop_spikeBelt) # high
	addiu	$4,$8,%lo(AICop_spikeBelt) # low
	lui	$3,%hi(D_8011E0B0) # high
	sw	$5,8($4)
	sw	$2,12($4)
	lw	$6,100($17)
	lw	$7,%lo(D_8011E0B0)($3)
	li	$3,1			# 0x00000001
	sw	$3,%lo(AICop_spikeBelt)($8)
	sw	$6,4($4)
	sw	$7,16($4)
	lw	$4,100($17)
	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSpikeBelt__Fiii
	addu	$6,$16,$2
	.set	macro
	.set	reorder

	lw	$3,100($17)
$L700:
	li	$2,1			# 0x00000001
$L768:
	sw	$2,AICop_gRoadBlockState
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L704
	lui	$2,%hi(AICop_spikeBelt) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(AICop_spikeBelt) # low
	lw	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L704
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(D_8011E0B0)($2)
	#nop
	sw	$2,16($4)
$L704:
	lw	$2,40($17)
	#nop
	beq	$2,$0,$L705
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L706
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$17
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	addu	$5,$17,32
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	j	$L705
$L706:
	.set	noreorder
	.set	nomacro
	jal	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	addu	$5,$17,32
	.set	macro
	.set	reorder

$L705:
	lw	$5,88($17)
	#nop
	addu	$16,$5,140
	lw	$2,16($16)
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
	bgez	$3,$L708
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L708:
	sra	$3,$3,16
	sll	$4,$3,5
	li	$2,65536			# 0x00010000
	div	$4,$2,$4
	sll	$3,$3,21
	lui	$2,%hi(GameSetup_gData+4) # high
	sw	$3,140($5)
	sw	$4,28($16)
	lw	$3,%lo(GameSetup_gData+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L709
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L710
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

$L709:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L713
	li	$5,43253			# 0x0000a8f5
	.set	macro
	.set	reorder

$L710:
	jal	fixedmult
	sw	$2,28($16)
$L713:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__10AIHigh_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

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
	beq	$3,$0,$L714
	li	$2,19595264			# 0x012b0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$5
	bne	$2,$0,$L718
	lw	$2,88($17)
	#nop
	lw	$5,0($2)
	#nop
	lw	$3,1380($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L769
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L769:
	ori	$2,$2,0x71c7
	slt	$2,$2,$3
	beq	$2,$0,$L718
	lw	$5,1380($5)
	jal	fixeddiv
	move	$3,$2
	blez	$3,$L718
	lw	$2,72($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L718
$L714:
	li	$18,1			# 0x00000001
$L718:
	bne	$18,$0,$L719
	lw	$2,88($17)
	lw	$5,52($17)
	lw	$4,0($2)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L720
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$4,$4,$2
$L720:
	lw	$3,76($17)
	sra	$2,$4,16
	mult	$3,$2
	mflo	$9
	#nop
	#nop
	blez	$9,$L645
$L719:
	lw	$4,88($17)
	li	$2,-1			# 0xffffffff
	sw	$2,100($17)
	lw	$2,44($17)
	lw	$3,148($4)
	#nop
	bne	$3,$2,$L722
	sw	$0,140($4)
$L722:
	li	$4,148			# 0x00000094
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$0,32($17)
	.set	macro
	.set	reorder

	lui	$4,%hi(AIHigh_Cop_AggressionData) # high
	lw	$5,104($17)
	addiu	$4,$4,%lo(AIHigh_Cop_AggressionData) # low
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$4
	lw	$4,88($17)
	lw	$3,16($3)
	lw	$6,0($4)
	lui	$4,%hi(NitroDistanceMeters) # high
	sw	$3,16($sp)
	lw	$3,24($17)
	addiu	$4,$4,%lo(NitroDistanceMeters) # low
	sll	$3,$3,3
	addu	$3,$3,$4
	lw	$3,0($3)
	#nop
	sw	$3,20($sp)
	lw	$3,24($17)
	#nop
	sll	$3,$3,3
	addu	$3,$3,$4
	move	$4,$2
	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$3,4($3)
	lw	$2,%lo(GameSetup_gData+8)($2)
	sw	$3,24($sp)
	lw	$3,104($17)
	sll	$2,$2,2
	sw	$3,28($sp)
	lui	$3,%hi(AICop_skillDelay) # high
	addiu	$3,$3,%lo(AICop_skillDelay) # low
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
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
	beq	$3,$0,$L725
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

$L725:
	lw	$3,68($17)
	li	$2,4			# 0x00000004
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L645
	sw	$2,8($17)
	.set	macro
	.set	reorder

	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ChangeDirection__FP8Car_tObji
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

	j	$L645
$L699:
	lw	$2,0($17)
	#nop
	lw	$3,1392($2)
	li	$5,-3			# 0xfffffffd
	and	$3,$3,$5
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTarget__10AIHigh_Cop
	sw	$3,1392($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,32($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L728
	li	$18,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$18,$L728
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetCheckChasePosition__10AIHigh_CopP8coorddef
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,148			# 0x00000094
	.set	macro
	.set	reorder

	lui	$4,%hi(AIHigh_Cop_AggressionData) # high
	lw	$5,104($17)
	addiu	$4,$4,%lo(AIHigh_Cop_AggressionData) # low
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$4
	lw	$4,88($17)
	lw	$3,16($3)
	lw	$6,0($4)
	lui	$4,%hi(NitroDistanceMeters) # high
	sw	$3,16($sp)
	lw	$3,24($17)
	addiu	$4,$4,%lo(NitroDistanceMeters) # low
	sll	$3,$3,3
	addu	$3,$3,$4
	lw	$3,0($3)
	#nop
	sw	$3,20($sp)
	lw	$3,24($17)
	#nop
	sll	$3,$3,3
	addu	$3,$3,$4
	move	$4,$2
	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$3,4($3)
	lw	$2,%lo(GameSetup_gData+8)($2)
	sw	$3,24($sp)
	lw	$3,104($17)
	sll	$2,$2,2
	sw	$3,28($sp)
	lui	$3,%hi(AICop_skillDelay) # high
	addiu	$3,$3,%lo(AICop_skillDelay) # low
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
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
	beq	$3,$0,$L732
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

$L732:
	lw	$4,0($17)
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	Mobile__6SpeechP8Car_tObj
	sw	$18,8($17)
	.set	macro
	.set	reorder

	lw	$3,88($17)
	lw	$6,76($2)
	lw	$5,0($3)
	lh	$4,48($6)
	lw	$3,52($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	j	$L645
$L728:
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L735
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

$L735:
	.set	noreorder
	.set	nomacro
	j	$L763
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L736:
	lw	$3,0($17)
	#nop
	lbu	$2,144($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L737
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L738
	sw	$0,1924($3)
	.set	macro
	.set	reorder

$L737:
	ori	$2,$2,0x8000
	sw	$2,1924($3)
$L738:
	li	$2,-1			# 0xffffffff
	sw	$2,100($17)
	move	$18,$0
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$19,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$16,$2,%lo(Cars_gRaceCarList) # low
$L739:
	lw	$2,Cars_gNumRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L740
	lw	$5,0($16)
	#nop
	lw	$2,596($5)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$2,0($2)
	#nop
	lw	$2,120($2)
	#nop
	beq	$2,$0,$L743
	lw	$4,4($17)
	jal	UnleashIfInRange__15AIState_OffroadP8Car_tObj
$L743:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L739
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L740:
	lw	$6,0($17)
	#nop
	lh	$2,8($6)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$4,$2,$3
	lbu	$2,30($4)
	lbu	$7,29($4)
	sll	$2,$2,15
	srl	$3,$7,4
	mult	$2,$3
	lw	$5,1396($6)
	mflo	$9
	#nop
	#nop
	subu	$2,$0,$9
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	andi	$3,$7,0x000f
	.set	macro
	.set	reorder

	lbu	$2,31($4)
	#nop
	sll	$2,$2,15
	mult	$2,$3
	mflo	$9
	#nop
	#nop
	slt	$2,$9,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	sw	$0,1924($6)
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
	beq	$3,$0,$L746
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

$L746:
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	sw	$2,8($17)
$L744:
	lw	$2,92($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L770
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	move	$4,$17
	.set	macro
	.set	reorder

$L770:
	lw	$2,0($17)
	move	$5,$0
	sw	$0,1924($2)
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	sw	$0,92($17)
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
	jal	__17AIState_PurgatoryP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L749
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

$L749:
	.set	noreorder
	.set	nomacro
	j	$L763
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L755:
	move	$4,$17
	lw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
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

	beq	$2,$0,$L645
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
	beq	$3,$0,$L758
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

$L758:
	li	$2,2			# 0x00000002
$L763:
	sw	$16,4($17)
	sw	$2,8($17)
$L645:
	lw	$4,4($17)
	jal	StateExecute__12AIState_Base
$L608:
	lw	$31,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	HighExecute__10AIHigh_Cop
	.text
	.ent	CheckForNeedyPlayers__10AIHigh_Cop
CheckForNeedyPlayers__10AIHigh_Cop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$7,-1			# 0xffffffff
	move	$6,$0
	lw	$8,Cars_gNumHumanRaceCars
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$10,$2,%lo(highLevelAIObjs) # low
	li	$9,1310720			# 0x00140000
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$5,$2,%lo(Cars_gHumanRaceCarList) # low
$L777:
	slt	$2,$6,$8
	beq	$2,$0,$L776
	lw	$3,0($5)
	#nop
	lw	$4,596($3)
	#nop
	sll	$2,$4,2
	addu	$2,$2,$10
	lw	$2,0($2)
	#nop
	lw	$2,172($2)
	#nop
	slt	$2,$2,801
	bne	$2,$0,$L779
	lw	$2,1380($3)
	#nop
	bgez	$2,$L780
	subu	$2,$0,$2
$L780:
	slt	$2,$9,$2
	beq	$2,$0,$L779
	move	$7,$4
$L779:
	addu	$5,$5,4
	.set	noreorder
	.set	nomacro
	j	$L777
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L776:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	CheckForNeedyPlayers__10AIHigh_Cop
	.text
	.ent	CheckForWipeOut__10AIHigh_Cop
CheckForWipeOut__10AIHigh_Cop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$10,$4
	lw	$3,8($10)
	li	$2,4			# 0x00000004
	bne	$3,$2,$L800
	lw	$4,88($10)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L785
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	lw	$3,0($10)
	lw	$2,%lo(D_8011E0B0)($2)
	lw	$3,1864($3)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L785
	lw	$3,140($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L799
	sra	$2,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$2,$3,16
$L799:
	slt	$2,$2,2
	bne	$2,$0,$L790
$L785:
	li	$5,1			# 0x00000001
$L790:
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L800
	move	$7,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$13,$2,%lo(highLevelAIObjs) # low
	lui	$4,%hi(simGlobal) # high
	lw	$3,fastRandom
	lw	$2,randSeed
	addiu	$12,$4,%lo(simGlobal) # low
	mult	$3,$2
	lw	$6,AI_elapsedTime
	lw	$11,Cars_gNumHumanRaceCars
	lw	$4,88($10)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$5,$2,%lo(Cars_gHumanRaceCarList) # low
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$2,$2,2
	subu	$2,$2,$6
	sll	$9,$2,3
	lw	$8,148($4)
	mflo	$3
	#nop
	#nop
	srl	$2,$3,8
	andi	$4,$2,0xffff
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
$L792:
	slt	$2,$7,$11
	beq	$2,$0,$L800
	lw	$2,0($5)
	#nop
	lw	$2,596($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$13
	lw	$2,0($2)
	#nop
	lw	$2,148($2)
	#nop
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L796
	addu	$3,$9,$6
	.set	macro
	.set	reorder

	slt	$2,$4,$3
	beq	$2,$0,$L796
	lw	$2,4($12)
	lw	$3,0($10)
	addu	$2,$2,640
	sw	$2,1864($3)
$L796:
	addu	$5,$5,4
	.set	noreorder
	.set	nomacro
	j	$L792
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L800:
	j	$31
	.end	CheckForWipeOut__10AIHigh_Cop
	.text
	.ent	CheckForNewTarget__10AIHigh_Cop
CheckForNewTarget__10AIHigh_Cop:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$0
	sw	$21,36($sp)
	li	$21,655360000			# 0x27100000
	li	$2,1			# 0x00000001
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,32($20)
	lw	$23,88($20)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L803
	move	$4,$19
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L803
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$3,$2,$L802
$L803:
	li	$4,1			# 0x00000001
$L802:
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L826
	move	$2,$0
	.set	macro
	.set	reorder

	move	$18,$0
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$22,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gRaceCarList) # low
$L807:
	lw	$2,Cars_gNumRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L806
	lw	$2,0($17)
	#nop
	lw	$2,596($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$22
	lw	$16,0($2)
	#nop
	lw	$2,120($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L809
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$2,24($20)
	lw	$3,156($16)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$3,0($3)
$L809:
	lw	$2,24($20)
	lw	$4,88($20)
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,112($2)
	beq	$4,$0,$L810
	bne	$4,$16,$L810
	addu	$2,$2,-1
$L810:
	slt	$2,$2,$3
	beq	$2,$0,$L811
	lw	$4,0($20)
	lw	$5,0($16)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$3,$21
	beq	$2,$0,$L811
	move	$21,$3
	move	$19,$16
$L811:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L807
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L806:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L814
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$22,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gRaceCarList) # low
$L817:
	lw	$2,Cars_gNumRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L816
	lw	$2,0($17)
	#nop
	lw	$2,596($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$22
	lw	$16,0($2)
	lw	$4,0($20)
	lw	$5,0($16)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$3,$21
	beq	$2,$0,$L819
	lw	$2,120($16)
	#nop
	beq	$2,$0,$L819
	move	$21,$3
	move	$19,$16
$L819:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L817
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L816:
	beq	$19,$0,$L822
$L814:
	.set	noreorder
	.set	nomacro
	beq	$19,$23,$L822
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$2,24($20)
	lw	$3,156($19)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$3,24($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L826
	sw	$3,104($20)
	.set	macro
	.set	reorder

$L822:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L826
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L826
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	move	$5,$0
	.set	macro
	.set	reorder

	move	$2,$0
$L826:
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

	.end	CheckForNewTarget__10AIHigh_Cop
	.text
	.ent	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
AssignToPlayer__10AIHigh_CopP13AIHigh_Player:
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
	beq	$4,$0,$L828
	move	$17,$5
	.set	macro
	.set	reorder

	lw	$5,28($16)
	lw	$2,0($16)
	lw	$7,24($16)
	lw	$6,596($2)
	jal	RemoveChaser__16AIHigh_BasicPerpii7copType
$L828:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L829
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,32($16)
	#nop
	beq	$3,$2,$L829
	sw	$0,32($16)
$L829:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L827
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

$L827:
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

	.end	AssignToPlayer__10AIHigh_CopP13AIHigh_Player
	.text
	.ent	GetCheckChasePosition__10AIHigh_CopP8coorddef
GetCheckChasePosition__10AIHigh_CopP8coorddef:
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

	lw	$3,96($16)
	#nop
	beq	$2,$3,$L833
	li	$17,1			# 0x00000001
	sw	$2,96($16)
$L833:
	move	$2,$17
	lui	$6,%hi(AIH_Cop_chasePositions) # high
	addiu	$6,$6,%lo(AIH_Cop_chasePositions) # low
	lw	$3,96($16)
	lw	$5,104($16)
	sll	$4,$3,1
	addu	$4,$4,$3
	sll	$4,$4,2
	sll	$3,$5,3
	addu	$3,$3,$5
	sll	$3,$3,3
	addu	$4,$4,$3
	addu	$4,$4,$6
	lw	$7,0($4)
	lw	$8,4($4)
	lw	$9,8($4)
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

	.end	GetCheckChasePosition__10AIHigh_CopP8coorddef
	.text
	.ent	CheckForNewTriggers__10AIHigh_Cop
CheckForNewTriggers__10AIHigh_Cop:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lui	$2,%hi(simGlobal) # high
	addiu	$3,$2,%lo(simGlobal) # low
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sw	$4,64($sp)
	lw	$2,4($3)
	#nop
	slt	$2,$2,1472
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L870
	move	$2,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$2,Cars_gNumCars
 #APP
 #NO_APP
	#nop
	addu	$fp,$2,-1
$L838:
	.set	noreorder
	.set	nomacro
	bltz	$fp,$L837
	sll	$2,$fp,2
	.set	macro
	.set	reorder

	lui	$7,%hi(Cars_gTotalSortedList) # high
	addiu	$7,$7,%lo(Cars_gTotalSortedList) # low
	addu	$2,$2,$7
	lw	$21,0($2)
	#nop
	lw	$2,608($21)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L840
	lui	$7,%hi(highLevelAIObjs) # high
	.set	macro
	.set	reorder

	lw	$2,596($21)
	addiu	$7,$7,%lo(highLevelAIObjs) # low
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$16,0($2)
	lw	$7,64($sp)
	addu	$3,$16,112
	#.set	volatile
	lw	$5,156($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,24($7)
	#.set	novolatile
	lw	$18,132($16)
	sll	$4,$2,2
	addu	$2,$3,$4
	lw	$3,8($3)
	lw	$2,0($2)
	move	$6,$5
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L844
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	addu	$2,$5,$4
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L845
	sll	$18,$18,1
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lh	$4,8($2)
	.set	noreorder
	.set	nomacro
	jal	AICop_NoCopsInArea__Fii
	li	$5,32768000			# 0x01f40000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L848
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L845:
	.set	noreorder
	.set	nomacro
	j	$L848
	move	$4,$0
	.set	macro
	.set	reorder

$L844:
	addu	$2,$6,$4
	lw	$4,0($2)
$L848:
	lui	$2,%hi(GameSetup_gData+8) # high
	lw	$3,%lo(GameSetup_gData+8)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L871
	lui	$7,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	li	$18,65536			# 0x00010000
$L871:
	addiu	$7,$7,%lo(simGlobal) # low
	lw	$3,104($16)
	lw	$2,4($7)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,448
	bne	$2,$0,$L840
	lw	$7,20($sp)
	#nop
	slt	$2,$7,$4
	beq	$2,$0,$L840
	lw	$2,1380($21)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L853
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L853:
	sll	$2,$3,5
	subu	$3,$2,$3
	bltz	$3,$L854
	lh	$2,8($21)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L856
	.set	noreorder
	.set	nomacro
	j	$L856
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L854:
	lh	$2,8($21)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L856
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L856:
	lw	$5,136($16)
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	sw	$3,136($16)
	.set	macro
	.set	reorder

	move	$4,$5
	.set	noreorder
	.set	nomacro
	j	$L859
	move	$20,$3
	.set	macro
	.set	reorder

$L858:
	move	$4,$3
	move	$20,$5
$L859:
	move	$17,$4
	subu	$2,$20,$17
	slt	$23,$2,6
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,3
	addu	$22,$2,$18
$L860:
	slt	$2,$17,$20
	beq	$2,$0,$L840
	beq	$23,$0,$L840
	lw	$4,triggerManagerCops
	lw	$5,596($21)
	.set	noreorder
	.set	nomacro
	jal	CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
	move	$6,$17
	.set	macro
	.set	reorder

	move	$19,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$19,$2,$L862
	sll	$5,$22,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$5,$L866
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$5,$5,$2
$L866:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	move	$4,$17
	sra	$18,$5,16
	mflo	$3
	#nop
	#nop
	andi	$2,$3,0xffff
	sw	$3,randtemp
	srl	$3,$3,8
	andi	$3,$3,0xffff
	sw	$2,fastRandom
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	AILife_IsSliceInAnyVisibleArea__Fi
	srl	$16,$2,14
	.set	macro
	.set	reorder

	bne	$2,$0,$L862
	lw	$7,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L869
	slt	$2,$16,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L860
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L869:
	lw	$4,triggerManagerCops
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	GetTrigger__24AITrigger_TriggerManageriPi
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	j	$L870
$L862:
	.set	noreorder
	.set	nomacro
	j	$L860
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L840:
	.set	noreorder
	.set	nomacro
	j	$L838
	addu	$fp,$fp,-1
	.set	macro
	.set	reorder

$L837:
	move	$2,$0
$L870:
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

	.end	CheckForNewTriggers__10AIHigh_Cop
	.text
	.ent	___10AIHigh_Cop
___10AIHigh_Cop:
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

	.end	___10AIHigh_Cop
