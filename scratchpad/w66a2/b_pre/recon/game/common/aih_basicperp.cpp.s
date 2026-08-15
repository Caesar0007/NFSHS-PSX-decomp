	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_basicperp.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	AIHigh_BasicPerp_PlayerCaughtSpeed
	.data
	.align	2
AIHigh_BasicPerp_PlayerCaughtSpeed:
	.word	1019448
	.word	1165084
	.word	1310720
	.globl	AIHigh_BasicPerp_PlayerCaughtDeltaY
	.align	2
AIHigh_BasicPerp_PlayerCaughtDeltaY:
	.word	327680
	.word	425984
	.word	524288
	.globl	AIHigh_BasicPerp_MinDeltaSpeed
	.align	2
AIHigh_BasicPerp_MinDeltaSpeed:
	.word	582542
	.word	728177
	.word	873813
	.globl	AIHigh_BasicPerp_CopCaughtSpeed
	.align	2
AIHigh_BasicPerp_CopCaughtSpeed:
	.word	728177
	.word	932067
	.word	1165084
	.globl	AIHigh_BasicPerp_CaughtDistance
	.align	2
AIHigh_BasicPerp_CaughtDistance:
	.word	1966080
	.word	2949120
	.word	3932160
	.text
	.align	2
	.globl	CheckForCrimes__16AIHigh_BasicPerp
	.align	2
	.globl	CheckIfCaught__16AIHigh_BasicPerp
	.align	2
	.globl	RemoveCloseCops__16AIHigh_BasicPerp
	.align	2
	.globl	RemoveChaser__16AIHigh_BasicPerpii7copType
	.align	2
	.globl	AddChaser__16AIHigh_BasicPerpii7copType
	.align	2
	.globl	CheckChaserPosition__16AIHigh_BasicPerpii
	.align	2
	.globl	Clear__16AIHigh_BasicPerp
	.align	2
	.globl	__16AIHigh_BasicPerpP8Car_tObj
	.align	2
	.globl	___16AIHigh_BasicPerp

	.extern	Cars_gNumCopCars, 4
	.extern	BWorldSm_slices, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumCars, 4
	.extern	AITune_driveSide, 4
	.extern	GameSetup_gData, 2600
	.extern	AITune_oneWay, 4
	.extern	simGlobal, 24

	.text
	.text
	.ent	CheckForCrimes__16AIHigh_BasicPerp
CheckForCrimes__16AIHigh_BasicPerp:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	lw	$16,120($17)
	lh	$4,8($2)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetLegalSpeed__Fi
	move	$18,$16
	.set	macro
	.set	reorder

	lui	$3,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($3)
	lw	$3,104($17)
	#nop
	subu	$3,$4,$3
	slt	$3,$3,640
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L599
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,0($17)
	#nop
	lw	$2,912($3)
	#nop
	slt	$2,$2,2
	beq	$2,$0,$L599
	lw	$2,440($3)
	#nop
	subu	$2,$4,$2
	slt	$2,$2,15
	beq	$2,$0,$L602
	lw	$2,432($3)
	#nop
	beq	$2,$0,$L602
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	li	$2,1310720			# 0x00140000
	.set	macro
	.set	reorder

	lw	$3,436($3)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L603
	.set	noreorder
	.set	nomacro
	j	$L602
	li	$16,4			# 0x00000004
	.set	macro
	.set	reorder

$L603:
	bne	$16,$0,$L602
	li	$16,3			# 0x00000003
$L602:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L606
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	bne	$16,$2,$L599
$L606:
	lw	$2,0($17)
	#nop
	lw	$3,1380($2)
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	beq	$2,$0,$L607
	bne	$16,$0,$L607
	li	$16,1			# 0x00000001
$L607:
	lw	$2,AITune_oneWay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$3,0($17)
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,1380($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L610
	srl	$2,$2,31
	.set	macro
	.set	reorder

$L609:
	srl	$2,$3,31
$L610:
	beq	$2,$0,$L616
	lw	$2,0($17)
	#nop
	lw	$3,1380($2)
	#nop
	bgez	$3,1f
	subu	$3,$0,$3
1:
	.set	noreorder
	.set	nomacro
	j	$L629
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

$L608:
	lw	$4,0($17)
	lw	$2,AITune_driveSide
	lw	$3,1380($4)
	#nop
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	bltz	$7,$L614
	lw	$2,1732($4)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	j	$L617
$L628:
	.set	noreorder
	.set	nomacro
	j	$L599
	sw	$16,120($17)
	.set	macro
	.set	reorder

$L614:
	lw	$2,1732($4)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

$L617:
	bgez	$3,1f
	subu	$3,$0,$3
1:
	li	$2,262144			# 0x00040000
$L629:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	bne	$16,$0,$L630
	li	$16,2			# 0x00000002
$L616:
	lui	$2,%hi(simGlobal+4) # high
$L630:
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,512
	beq	$2,$0,$L620
	move	$16,$0
$L620:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L599
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$6,Cars_gNumCars
	lui	$2,%hi(Cars_gList) # high
	addiu	$4,$2,%lo(Cars_gList) # low
$L622:
	slt	$2,$5,$6
	beq	$2,$0,$L599
	lw	$3,0($4)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0220
	beq	$2,$0,$L624
	lbu	$2,145($3)
	#nop
	bne	$2,$0,$L628
$L624:
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L622
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L599:
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

	.end	CheckForCrimes__16AIHigh_BasicPerp
	.text
	.ent	CheckIfCaught__16AIHigh_BasicPerp
CheckIfCaught__16AIHigh_BasicPerp:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$19,52($sp)
	move	$19,$4
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	lw	$4,0($19)
	lui	$3,%hi(GameSetup_gData+8) # high
	lw	$2,608($4)
	lw	$5,%lo(GameSetup_gData+8)($3)
	andi	$2,$2,0x0002
	beq	$2,$0,$L632
	lw	$2,1380($4)
	#nop
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	j	$L633
$L632:
	lw	$3,192($4)
$L633:
	lw	$2,120($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	lui	$2,%hi(AIHigh_BasicPerp_PlayerCaughtSpeed) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(AIHigh_BasicPerp_PlayerCaughtSpeed) # low
	sll	$4,$5,2
	addu	$2,$4,$2
	lw	$2,0($2)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,104($19)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,960
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,0($19)
	#nop
	lw	$2,912($3)
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	move	$22,$0
	.set	macro
	.set	reorder

	lui	$23,%hi(Cars_gHumanRaceCarList) # high
	addiu	$fp,$23,%lo(Cars_gHumanRaceCarList) # low
	move	$21,$4
	lw	$3,256($3)
	li	$2,39321			# 0x00009999
	slt	$2,$2,$3
	sw	$2,32($sp)
$L638:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$22,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	lui	$2,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$3,$22,2
	addu	$3,$3,$2
	lw	$2,0($19)
	lw	$18,0($3)
	lw	$3,1380($2)
	lw	$2,1380($18)
	#nop
	subu	$5,$3,$2
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L645
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L674
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L645:
	lw	$2,%lo(Cars_gHumanRaceCarList)($23)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L646
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L674
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,4($fp)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L646:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L674:
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L648
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L647
$L648:
	lw	$2,%lo(Cars_gHumanRaceCarList)($23)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	#nop
	bne	$3,$2,$L647
	lw	$2,4($fp)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L642
$L647:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L642
$L643:
	li	$4,1			# 0x00000001
$L642:
	beq	$4,$0,$L640
	lw	$3,1392($18)
	#nop
	andi	$2,$3,0x0002
	beq	$2,$0,$L640
	lhu	$2,380($18)
	#nop
	bne	$2,$0,$L640
	lbu	$2,145($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	andi	$2,$3,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L640
	li	$2,39321			# 0x00009999
	.set	macro
	.set	reorder

	lw	$3,256($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	lui	$2,%hi(AIHigh_BasicPerp_MinDeltaSpeed) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(AIHigh_BasicPerp_MinDeltaSpeed) # low
	addu	$2,$21,$2
	lw	$2,0($2)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	lui	$2,%hi(AIHigh_BasicPerp_CopCaughtSpeed) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(AIHigh_BasicPerp_CopCaughtSpeed) # low
	addu	$2,$21,$2
	lw	$3,1380($18)
	lw	$2,0($2)
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L640
	lui	$2,%hi(AIHigh_BasicPerp_PlayerCaughtDeltaY) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(AIHigh_BasicPerp_PlayerCaughtDeltaY) # low
	addu	$2,$21,$2
	lw	$3,0($19)
	lw	$5,164($18)
	lw	$4,164($3)
	lw	$2,0($2)
	subu	$3,$5,$4
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L675
	slt	$3,$3,$2
	.set	macro
	.set	reorder

	subu	$3,$4,$5
	slt	$3,$3,$2
$L675:
	beq	$3,$0,$L640
	lw	$4,0($19)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$2,1f
	move	$17,$2
	subu	$17,$0,$17
1:
	.set	reorder
	lw	$3,0($19)
	li	$7,7			# 0x00000007
	lh	$4,8($3)
	lw	$5,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$5
	lbu	$4,29($4)
	lw	$6,1732($3)
	srl	$2,$4,4
	subu	$2,$7,$2
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	move	$16,$0
	.set	macro
	.set	reorder

	andi	$2,$4,0x000f
	addu	$2,$2,6
	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L676
	lui	$2,%hi(AIHigh_BasicPerp_CaughtDistance) # high
	.set	macro
	.set	reorder

	lh	$4,8($18)
	#nop
	sll	$2,$4,5
	addu	$2,$2,$5
	lbu	$3,29($2)
	lw	$5,1732($18)
	srl	$2,$3,4
	subu	$2,$7,$2
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L676
	lui	$2,%hi(AIHigh_BasicPerp_CaughtDistance) # high
	.set	macro
	.set	reorder

	andi	$2,$3,0x000f
	addu	$2,$2,6
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L676
	lui	$2,%hi(AIHigh_BasicPerp_CaughtDistance) # high
	.set	macro
	.set	reorder

	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L676
	lui	$2,%hi(AIHigh_BasicPerp_CaughtDistance) # high
	.set	macro
	.set	reorder

	lw	$2,0($19)
	lw	$5,1732($18)
	lh	$4,8($2)
	lw	$6,1732($2)
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	sltu	$16,$0,$2
$L656:
	lui	$2,%hi(AIHigh_BasicPerp_CaughtDistance) # high
$L676:
	addiu	$2,$2,%lo(AIHigh_BasicPerp_CaughtDistance) # low
	addu	$2,$21,$2
	lw	$2,0($2)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L640
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L640
	move	$20,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L660
	li	$17,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	bne	$3,$2,$L659
$L660:
	lw	$2,%lo(Cars_gHumanRaceCarList)($23)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L661
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	#nop
	bne	$3,$2,$L659
	lw	$2,4($fp)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L659
$L661:
	lw	$2,0($19)
	lw	$4,160($18)
	lw	$2,160($2)
	#nop
	subu	$4,$4,$2
	sw	$4,16($sp)
	lw	$3,0($19)
	lw	$2,164($18)
	lw	$3,164($3)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,0($19)
	lw	$2,168($18)
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
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$3,0($19)
	lw	$4,24($sp)
	lw	$5,248($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$3,0($19)
	lw	$4,16($sp)
	lw	$5,264($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$20,$16,$2
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
$L659:
	lw	$7,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L673
	li	$3,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$2,1384($18)
	ori	$3,$3,0x71c6
	slt	$2,$3,$2
	bne	$2,$0,$L662
	lw	$2,0($19)
	#nop
	lw	$2,1384($2)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L673
$L662:
 #APP
 #NO_APP
	li	$3,524288			# 0x00080000
	ori	$3,$3,0xffff
	.set	noreorder
	bgez	$20,1f
	move	$2,$20
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$3,$2
	bne	$2,$0,$L640
	.set	noreorder
	.set	nomacro
	bltz	$17,$L640
	slt	$2,$3,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L673:
	lw	$2,108($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L670
	sw	$18,108($19)
	.set	macro
	.set	reorder

$L640:
	.set	noreorder
	.set	nomacro
	j	$L638
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L634:
	move	$2,$0
$L670:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	CheckIfCaught__16AIHigh_BasicPerp
	.text
	.ent	RemoveCloseCops__16AIHigh_BasicPerp
RemoveCloseCops__16AIHigh_BasicPerp:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$22,40($sp)
	move	$22,$4
	sw	$18,24($sp)
	move	$18,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$21,36($sp)
	addiu	$21,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(GameSetup_gData) # high
	sw	$20,32($sp)
	addiu	$20,$2,%lo(GameSetup_gData) # low
	sw	$19,28($sp)
	li	$19,1			# 0x00000001
	lui	$2,%hi(Cars_gCopCarList) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(Cars_gCopCarList) # low
	sw	$31,44($sp)
	sw	$16,16($sp)
$L680:
	lw	$2,Cars_gNumCopCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L677
	lw	$16,0($17)
	#nop
	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0004
	bne	$2,$0,$L682
	lw	$5,0($22)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$4,$16
	.set	macro
	.set	reorder

	li	$3,9764864			# 0x00950000
	ori	$3,$3,0xffff
	.set	noreorder
	bgez	$2,1f
	move	$6,$2
	subu	$6,$0,$6
1:
	.set	reorder
	slt	$3,$3,$6
	bne	$3,$0,$L682
	lw	$2,596($16)
	lw	$3,48($20)
	sll	$2,$2,2
	addu	$2,$2,$21
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L684
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
$L684:
	li	$2,1900544			# 0x001d0000
	ori	$2,$2,0xffff
	slt	$2,$2,$6
	sw	$5,1364($16)
	sw	$5,1360($16)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L685
	sw	$19,1776($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L686
	sw	$19,84($4)
	.set	macro
	.set	reorder

$L685:
	li	$2,2			# 0x00000002
	sw	$2,84($4)
$L686:
	lw	$4,0($4)
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

$L682:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L680
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L677:
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	RemoveCloseCops__16AIHigh_BasicPerp
	.text
	.ent	RemoveChaser__16AIHigh_BasicPerpii7copType
RemoveChaser__16AIHigh_BasicPerpii7copType:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$5,$5,2
	addu	$5,$4,$5
	addu	$6,$4,112
	sll	$7,$7,2
	addu	$6,$6,$7
	lw	$2,0($6)
	lw	$3,76($5)
	addu	$2,$2,-1
	sll	$3,$3,3
	addu	$4,$4,$3
	sw	$2,0($6)
	li	$2,-1			# 0xffffffff
	sw	$2,28($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,32($4)
	.set	macro
	.set	reorder

	.end	RemoveChaser__16AIHigh_BasicPerpii7copType
	.text
	.ent	AddChaser__16AIHigh_BasicPerpii7copType
AddChaser__16AIHigh_BasicPerpii7copType:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$3,$4,112
	sll	$7,$7,2
	addu	$3,$3,$7
	sw	$31,16($sp)
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	addu	$2,$4,40
	li	$3,5			# 0x00000005
	sw	$5,28($2)
	sw	$6,32($2)
	sll	$2,$5,2
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	jal	CheckChaserPosition__16AIHigh_BasicPerpii
	sw	$3,76($2)
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

	.end	AddChaser__16AIHigh_BasicPerpii7copType
	.text
	.ent	CheckChaserPosition__16AIHigh_BasicPerpii
CheckChaserPosition__16AIHigh_BasicPerpii:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,24($sp)
	move	$18,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$21,36($sp)
	move	$21,$6
	sll	$3,$20,2
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$4,$2,%lo(highLevelAIObjs) # low
	sll	$2,$21,2
	addu	$2,$2,$4
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,0($2)
	addu	$3,$18,$3
	lw	$2,0($2)
	lw	$16,76($3)
	lh	$23,8($2)
	.set	noreorder
	.set	nomacro
	blez	$16,$L693
	li	$19,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$fp,$4
	move	$22,$3
	addu	$2,$16,$19
$L704:
	sll	$2,$2,3
	addu	$2,$18,$2
	lw	$17,28($2)
	lw	$2,32($2)
	.set	noreorder
	.set	nomacro
	beq	$17,$19,$L705
	addu	$5,$16,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L699
	sll	$2,$2,2
	.set	macro
	.set	reorder

	addu	$2,$2,$fp
	lw	$2,0($2)
	#nop
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$5,$23
	.set	macro
	.set	reorder

	lw	$3,0($18)
	#nop
	lw	$3,1364($3)
	#nop
	mult	$2,$3
	li	$2,-786432			# 0xfff40000
	mflo	$7
	#nop
	#nop
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L706
	move	$2,$16
	.set	macro
	.set	reorder

$L699:
	sll	$2,$17,2
	addu	$2,$18,$2
	sw	$16,76($2)
	addu	$5,$16,-1
$L705:
	sll	$4,$16,3
	sll	$2,$5,3
	addu	$2,$18,$2
	sw	$5,76($22)
	lw	$3,28($2)
	addu	$4,$18,$4
	sw	$3,28($4)
	lw	$3,32($2)
	move	$16,$5
	sw	$3,32($4)
	sw	$20,28($2)
	.set	noreorder
	.set	nomacro
	blez	$16,$L693
	sw	$21,32($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L704
	addu	$2,$16,-1
	.set	macro
	.set	reorder

$L693:
	move	$2,$16
$L706:
	lw	$31,52($sp)
	lw	$fp,48($sp)
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

	.end	CheckChaserPosition__16AIHigh_BasicPerpii
	.text
	.ent	Clear__16AIHigh_BasicPerp
Clear__16AIHigh_BasicPerp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	li	$6,-1			# 0xffffffff
	move	$3,$4
$L708:
	sw	$6,28($3)
	sw	$6,32($3)
	addu	$5,$5,1
	slt	$2,$5,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L708
	addu	$3,$3,8
	.set	macro
	.set	reorder

	li	$2,-640			# 0xfffffd80
	sw	$0,24($4)
	sw	$0,100($4)
	sw	$2,104($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,108($4)
	.set	macro
	.set	reorder

	.end	Clear__16AIHigh_BasicPerp
	.text
	.ent	__16AIHigh_BasicPerpP8Car_tObj
__16AIHigh_BasicPerpP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__11AIHigh_BaseP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$2,%hi(AIHigh_BasicPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicPerp_vtable) # low
	sw	$2,20($16)
	sw	$0,112($16)
	sw	$0,116($16)
	.set	noreorder
	.set	nomacro
	jal	Clear__16AIHigh_BasicPerp
	sw	$0,120($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__16AIHigh_BasicPerpP8Car_tObj
	.text
	.ent	___16AIHigh_BasicPerp
___16AIHigh_BasicPerp:
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

	.end	___16AIHigh_BasicPerp
