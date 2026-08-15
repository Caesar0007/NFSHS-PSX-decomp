	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_opp.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CheckForWipeOut__15AIHigh_Opponent
	.align	2
	.globl	DoRearEnder__15AIHigh_Opponent
	.align	2
	.globl	HighExecute__15AIHigh_Opponent
	.align	2
	.globl	__15AIHigh_OpponentP8Car_tObj
	.align	2
	.globl	DoProvokedAttack__15AIHigh_Opponent
	.align	2
	.globl	___15AIHigh_Opponent

	.extern	GameSetup_gData, 2600
	.extern	BWorldSm_slices, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	AI_elapsedTime, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	simGlobal, 24
	.extern	Cars_gNumCopCars, 4

	.text
	.text
	.ent	CheckForWipeOut__15AIHigh_Opponent
CheckForWipeOut__15AIHigh_Opponent:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	lw	$15,148($8)
	lw	$3,0($8)
	lw	$2,Cars_gNumCopCars
	lw	$14,932($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,1864($3)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L618
	lw	$2,120($8)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,112($8)
	lw	$3,116($8)
	#nop
	addu	$2,$2,$3
	bne	$2,$0,$L601
$L602:
	li	$4,1			# 0x00000001
$L601:
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L618
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	addiu	$12,$2,%lo(simGlobal) # low
	lw	$2,0($8)
	lw	$6,4($12)
	lw	$2,1864($2)
	#nop
	subu	$2,$6,$2
	slt	$2,$2,640
	bne	$2,$0,$L618
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$4,AI_elapsedTime
	#nop
	sll	$3,$4,1
	addu	$5,$3,$4
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	andi	$9,$2,0xffff
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$10,$2,$4
	slt	$2,$9,$5
	sw	$3,fastRandom
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	addu	$2,$6,192
	.set	macro
	.set	reorder

	lw	$3,0($8)
	#nop
	sw	$2,1864($3)
$L604:
	addu	$3,$8,140
	lw	$2,4($3)
	#nop
	lw	$2,0($2)
	lw	$3,12($3)
	addu	$2,$2,-1
	beq	$3,$2,$L618
	lw	$11,Cars_gNumHumanRaceCars
 #APP
 #NO_APP
	move	$7,$0
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$13,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$6,$2,%lo(Cars_gHumanRaceCarList) # low
$L606:
	slt	$2,$7,$11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	li	$5,851968			# 0x000d0000
	.set	macro
	.set	reorder

	lw	$4,0($6)
	ori	$5,$5,0x5554
	lw	$3,596($4)
	lw	$2,1380($4)
	sll	$3,$3,2
	addu	$3,$3,$13
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$5,$5,$2
	lw	$2,0($3)
	lw	$3,932($4)
	lw	$2,148($2)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L608
	slt	$2,$2,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	slt	$2,$15,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	sll	$5,$10,2
	.set	macro
	.set	reorder

$L611:
	subu	$2,$3,$14
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	sll	$5,$10,2
	.set	macro
	.set	reorder

$L617:
	slt	$2,$9,$5
	beq	$2,$0,$L608
	lw	$2,4($12)
	lw	$3,0($8)
	addu	$2,$2,192
	sw	$2,1864($3)
$L608:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L606
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L618:
	j	$31
	.end	CheckForWipeOut__15AIHigh_Opponent
	.text
	.ent	DoRearEnder__15AIHigh_Opponent
DoRearEnder__15AIHigh_Opponent:
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
	lw	$4,0($19)
	li	$5,256			# 0x00000100
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	addu	$4,$4,1268
	.set	macro
	.set	reorder

	move	$17,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L620
	lui	$3,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$16,0($2)
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,0($19)
	#nop
	lw	$3,1364($5)
	#nop
	mult	$2,$3
	li	$4,-131072			# 0xfffe0000
	ori	$4,$4,0xffff
	lw	$5,1396($5)
	li	$2,2490368			# 0x00260000
	lw	$3,1396($16)
	ori	$2,$2,0xfffe
	subu	$5,$5,$3
	bgez	$5,1f
	subu	$5,$0,$5
1:
	mflo	$6
	#nop
	#nop
	addu	$4,$6,$4
	sltu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	sll	$2,$6,1
	.set	macro
	.set	reorder

	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L620
	li	$3,720896			# 0x000b0000
	.set	macro
	.set	reorder

	lw	$2,1380($16)
	ori	$3,$3,0x1c71
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L620
	move	$2,$17
	.set	macro
	.set	reorder

	j	$L634
$L636:
	lw	$2,596($16)
	j	$L634
$L620:
	lw	$3,0($19)
	#nop
	lbu	$2,144($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,1380($3)
	li	$2,1310720			# 0x00140000
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$20,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gHumanRaceCarList) # low
$L625:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$16,0($17)
	#nop
	lh	$2,8($16)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$4,$2,$3
	lbu	$3,30($4)
	lbu	$6,29($4)
	sll	$3,$3,15
	srl	$2,$6,4
	mult	$3,$2
	lw	$5,1396($16)
	mflo	$8
	#nop
	#nop
	subu	$2,$0,$8
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	andi	$3,$6,0x000f
	.set	macro
	.set	reorder

	lbu	$2,31($4)
	#nop
	sll	$2,$2,15
	mult	$2,$3
	mflo	$8
	#nop
	#nop
	slt	$2,$8,$5
	bne	$2,$0,$L629
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$6,0($19)
	#nop
	lw	$3,1364($6)
	#nop
	mult	$2,$3
	li	$4,-131072			# 0xfffe0000
	ori	$4,$4,0xffff
	lw	$5,1396($6)
	li	$3,2490368			# 0x00260000
	lw	$2,1396($16)
	ori	$3,$3,0xfffe
	subu	$5,$5,$2
	bgez	$5,1f
	subu	$5,$0,$5
1:
	mflo	$7
	#nop
	#nop
	addu	$4,$7,$4
	sltu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L637
	li	$3,196608			# 0x00030000
	.set	macro
	.set	reorder

	sll	$2,$7,1
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	ori	$3,$3,0xffff
	.set	macro
	.set	reorder

	lw	$3,596($6)
	lw	$4,1264($6)
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,4($20)
	lw	$4,72($4)
	addu	$3,$3,$2
	and	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L636
	li	$3,196608			# 0x00030000
	.set	macro
	.set	reorder

$L637:
	ori	$3,$3,0xffff
$L638:
	li	$2,458752			# 0x00070000
	ori	$2,$2,0xfffe
	addu	$3,$7,$3
	sltu	$2,$2,$3
	bne	$2,$0,$L629
	lw	$4,0($19)
	#nop
	lw	$3,596($4)
	lw	$4,1264($4)
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,4($20)
	lw	$4,76($4)
	addu	$3,$3,$2
	and	$3,$3,$4
	beq	$3,$4,$L636
$L629:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L625
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L623:
	li	$2,-1			# 0xffffffff
$L634:
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

	.end	DoRearEnder__15AIHigh_Opponent
	.text
	.ent	HighExecute__15AIHigh_Opponent
HighExecute__15AIHigh_Opponent:
	.frame	$sp,80,$31		# vars= 16, regs= 5/0, args= 40, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$18,64($sp)
	move	$18,$4
	sw	$31,72($sp)
	sw	$19,68($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	lw	$3,8($18)
	#nop
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	lui	$2,%hi($L682) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L682) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L682:
	.word	$L649
	.word	$L640
	.word	$L653
	.word	$L640
	.word	$L665
	.word	$L640
	.word	$L640
	.word	$L640
	.word	$L640
	.word	$L640
	.word	$L640
	.text
$L649:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($18)
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
	li	$2,2			# 0x00000002
	sw	$16,4($18)
	.set	noreorder
	.set	nomacro
	j	$L639
	sw	$2,8($18)
	.set	macro
	.set	reorder

$L653:
	.set	noreorder
	.set	nomacro
	jal	HandleCops__13AIHigh_Player
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForWipeOut__15AIHigh_Opponent
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$4,0($18)
	li	$5,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	addu	$4,$4,1268
	.set	macro
	.set	reorder

	move	$17,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L654
	move	$19,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L685
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L654:
	.set	noreorder
	.set	nomacro
	jal	DoRearEnder__15AIHigh_Opponent
	move	$4,$18
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$19,$L656
	move	$16,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L685
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L656:
	.set	noreorder
	.set	nomacro
	jal	DoProvokedAttack__15AIHigh_Opponent
	move	$4,$18
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$16,$L655
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L685:
	sw	$2,176($18)
$L655:
	lw	$2,176($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	addu	$4,$sp,40
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	lw	$2,176($18)
	li	$3,2			# 0x00000002
	addu	$16,$2,-1
	slt	$2,$16,$3
	bne	$2,$0,$L660
	move	$3,$16
$L660:
	move	$16,$3
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,148			# 0x00000094
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,32			# 0x00000020
	sw	$2,16($sp)
	li	$2,9830400			# 0x00960000
	sw	$2,20($sp)
	sw	$2,24($sp)
	li	$2,65536			# 0x00010000
	lui	$3,%hi(Cars_gList) # high
	addiu	$3,$3,%lo(Cars_gList) # low
	sw	$2,32($sp)
	sll	$2,$17,2
	addu	$2,$2,$3
	sw	$16,28($sp)
	lw	$5,0($18)
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	jal	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
	addu	$7,$sp,40
	.set	macro
	.set	reorder

	lw	$3,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L664
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

$L664:
	li	$2,4			# 0x00000004
	sw	$16,4($18)
	.set	noreorder
	.set	nomacro
	j	$L640
	sw	$2,8($18)
	.set	macro
	.set	reorder

$L665:
	lw	$16,4($18)
	.set	noreorder
	.set	nomacro
	jal	HandleCops__13AIHigh_Player
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForWipeOut__15AIHigh_Opponent
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	li	$6,15			# 0x0000000f
	.set	noreorder
	.set	nomacro
	jal	SetMurderMode__13AIState_Chaseii
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,176($18)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L667
	slt	$2,$3,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$3,$2,$L669
	j	$L666
$L675:
	li	$2,3			# 0x00000003
	beq	$3,$2,$L671
	j	$L666
$L667:
	lw	$4,0($18)
	li	$5,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	addu	$4,$4,1268
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	bne	$2,$3,$L666
	.set	noreorder
	.set	nomacro
	j	$L666
	sw	$0,176($18)
	.set	macro
	.set	reorder

$L669:
	.set	noreorder
	.set	nomacro
	jal	DoRearEnder__15AIHigh_Opponent
	move	$4,$18
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	bne	$2,$3,$L666
	.set	noreorder
	.set	nomacro
	j	$L666
	sw	$0,176($18)
	.set	macro
	.set	reorder

$L671:
	lw	$2,188($18)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L666
	sw	$2,188($18)
	.set	macro
	.set	reorder

	sw	$0,176($18)
$L666:
	lw	$2,176($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L640
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,0($18)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L677
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L677:
	li	$4,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$5,1360($3)
	.set	macro
	.set	reorder

	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L681
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

$L681:
	li	$2,2			# 0x00000002
	sw	$16,4($18)
	sw	$2,8($18)
	sw	$0,176($18)
$L640:
	lw	$4,4($18)
	jal	StateExecute__12AIState_Base
$L639:
	lw	$31,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	HighExecute__15AIHigh_Opponent
	.text
	.ent	__15AIHigh_OpponentP8Car_tObj
__15AIHigh_OpponentP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__13AIHigh_PlayerP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(AIHigh_Opponent_vtable) # high
	addiu	$3,$3,%lo(AIHigh_Opponent_vtable) # low
	sw	$3,20($2)
	sw	$0,176($2)
	sw	$0,180($2)
	sw	$0,184($2)
	sw	$0,188($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__15AIHigh_OpponentP8Car_tObj
	.text
	.ent	DoProvokedAttack__15AIHigh_Opponent
DoProvokedAttack__15AIHigh_Opponent:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$5,0($4)
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,440($5)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,15
	beq	$2,$0,$L699
	lw	$6,432($5)
	#nop
	beq	$6,$0,$L699
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L699
	lw	$2,180($4)
	#nop
	beq	$2,$6,$L700
	sw	$6,180($4)
	sw	$0,184($4)
$L700:
	lw	$2,184($4)
	lw	$3,0($4)
	addu	$2,$2,1
	sw	$2,184($4)
	lw	$5,1264($3)
	#nop
	lw	$3,36($5)
	#nop
	slt	$3,$3,$2
	beq	$3,$0,$L699
	lw	$2,40($5)
	sw	$0,184($4)
	sw	$2,188($4)
	lw	$2,596($6)
	j	$31
$L699:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.end	DoProvokedAttack__15AIHigh_Opponent
	.text
	.ent	___15AIHigh_Opponent
___15AIHigh_Opponent:
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

	.end	___15AIHigh_Opponent
