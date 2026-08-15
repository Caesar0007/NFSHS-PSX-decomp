	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\stats.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Stats_DoPlayerGlue__Fv
	.align	2
	.globl	Stats_ClearPosition__Fv
	.align	2
	.globl	Stats_GetPosition__FP8Car_tObj
	.align	2
	.globl	Stats_GetNumOpponents__Fv
	.align	2
	.globl	Stats_TrackStats__FP8Car_tObj
	.align	2
	.globl	Stats_ExtrapolateOpponentTimes__Fi
	.align	2
	.globl	Stats_TrackEndGame__Fv

	.extern	CopSpeak_gSpchHandle, 4
	.extern	CopSpeak_gQueueHead, 4
	.extern	CopSpeak_gQueuePlay, 4
	.extern	simVar, 28
	.extern	Cars_gAIRaceCarList, 36
	.extern	Cars_gNumAIRaceCars, 4
	.extern	Cars_topSpeedCap, 88
	.extern	gNumSlices, 4
	.extern	simGlobal, 24
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 8
	.extern	GameSetup_gData, 2600
	.extern	Stats_racePosition, 96
	.extern	Cars_gNumRaceCars, 4

	.text
	.text
	.ent	Stats_DoPlayerGlue__Fv
Stats_DoPlayerGlue__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$2,Cars_gNumRaceCars
	subu	$sp,$sp,40
	sw	$19,28($sp)
	li	$19,99			# 0x00000063
	sw	$17,20($sp)
	move	$17,$0
	sw	$31,32($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L602
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Stats_racePosition) # high
	addiu	$18,$2,%lo(Stats_racePosition) # low
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$16,$2,%lo(Cars_gRaceCarList) # low
$L604:
	lw	$4,0($16)
	jal	Stats_GetPosition__FP8Car_tObj
	lw	$3,0($16)
	#nop
	sw	$2,904($3)
	lw	$2,12($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	li	$2,99			# 0x00000063
	.set	macro
	.set	reorder

	bne	$19,$2,$L603
	move	$19,$17
$L603:
	addu	$18,$18,16
	lw	$2,Cars_gNumRaceCars
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L602:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,32($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L607
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(Cars_gHumanRaceCarList)($2)
	addiu	$5,$2,%lo(Cars_gHumanRaceCarList) # low
	lw	$2,912($4)
	li	$3,2			# 0x00000002
	beq	$2,$3,$L609
	lw	$2,4($5)
	#nop
	lw	$2,912($2)
	#nop
	bne	$2,$3,$L608
$L609:
	li	$3,65536			# 0x00010000
	sw	$3,624($4)
	lw	$2,4($5)
	.set	noreorder
	.set	nomacro
	j	$L607
	sw	$3,624($2)
	.set	macro
	.set	reorder

$L608:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L607
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Stats_racePosition) # high
	addiu	$2,$2,%lo(Stats_racePosition) # low
	sll	$3,$19,4
	addu	$6,$3,$2
	li	$7,65536			# 0x00010000
$L614:
	lw	$4,0($5)
	lw	$2,4($6)
	lw	$3,848($4)
	#nop
	subu	$3,$2,$3
	slt	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	slt	$2,$3,10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L613
	sw	$7,624($4)
	.set	macro
	.set	reorder

$L615:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L624
	ori	$2,$2,0x0666
	.set	macro
	.set	reorder

$L617:
	slt	$2,$3,30
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L624
	ori	$2,$2,0x0ccc
	.set	macro
	.set	reorder

$L619:
	slt	$2,$3,60
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L624
	ori	$2,$2,0x1333
	.set	macro
	.set	reorder

$L621:
	ori	$2,$2,0x1999
$L624:
	sw	$2,624($4)
$L613:
	lw	$2,Cars_gNumHumanRaceCars
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L607:
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

	.end	Stats_DoPlayerGlue__Fv
	.text
	.ent	Stats_ClearPosition__Fv
Stats_ClearPosition__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	li	$6,-1			# 0xffffffff
	li	$5,-131072			# 0xfffe0000
	ori	$5,$5,0x7961
	lui	$2,%hi(Stats_racePosition) # high
	addiu	$3,$2,%lo(Stats_racePosition) # low
$L626:
	sw	$6,0($3)
	sw	$5,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	addu	$4,$4,1
	slt	$2,$4,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	addu	$3,$3,16
	.set	macro
	.set	reorder

	j	$31
	.end	Stats_ClearPosition__Fv
	.text
	.ent	Stats_GetPosition__FP8Car_tObj
Stats_GetPosition__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	lw	$2,Cars_gNumRaceCars
	lw	$7,596($4)
	.set	noreorder
	.set	nomacro
	blez	$2,$L632
	move	$6,$5
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$2,%hi(Stats_racePosition) # high
	addiu	$3,$2,%lo(Stats_racePosition) # low
$L634:
	lw	$2,0($3)
	#nop
	bne	$2,$7,$L633
	.set	noreorder
	.set	nomacro
	j	$L632
	addu	$6,$5,1
	.set	macro
	.set	reorder

$L633:
	addu	$5,$5,1
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	addu	$3,$3,16
	.set	macro
	.set	reorder

$L632:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	Stats_GetPosition__FP8Car_tObj
	.text
	.ent	Stats_GetNumOpponents__Fv
Stats_GetNumOpponents__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	lw	$2,Cars_gNumRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L639
	move	$4,$5
	.set	macro
	.set	reorder

	li	$7,-1			# 0xffffffff
	move	$6,$2
	lui	$2,%hi(Stats_racePosition) # high
	addiu	$3,$2,%lo(Stats_racePosition) # low
$L641:
	lw	$2,0($3)
	#nop
	beq	$2,$7,$L640
	addu	$4,$4,1
$L640:
	addu	$5,$5,1
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L641
	addu	$3,$3,16
	.set	macro
	.set	reorder

$L639:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	Stats_GetNumOpponents__Fv
	.text
	.ent	Stats_TrackStats__FP8Car_tObj
Stats_TrackStats__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L644
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$4,864($16)
	lw	$20,gNumSlices
	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	move	$19,$3
	.set	macro
	.set	reorder

	sll	$2,$4,2
	addu	$4,$16,$2
	lw	$3,1056($16)
	lw	$2,888($4)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L646
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L647
	lw	$2,648($16)
	#nop
	lw	$2,0($2)
	#nop
	slt	$2,$2,19
	beq	$2,$0,$L647
	.set	noreorder
	.set	nomacro
	jal	rand
	move	$18,$4
	.set	macro
	.set	reorder

	lui	$4,%hi(Cars_topSpeedCap) # high
	addiu	$17,$4,%lo(Cars_topSpeedCap) # low
	lw	$3,648($16)
	sll	$4,$2,1
	lw	$3,0($3)
	addu	$4,$4,$2
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$2,0($3)
	lw	$3,1056($16)
	subu	$2,$2,$4
	slt	$2,$2,$3
	beq	$2,$0,$L649
	jal	rand
	lw	$3,648($16)
	#nop
	lw	$3,0($3)
	sll	$4,$2,1
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$3,0($3)
	addu	$4,$4,$2
	subu	$3,$3,$4
$L649:
	.set	noreorder
	.set	nomacro
	j	$L646
	sw	$3,888($18)
	.set	macro
	.set	reorder

$L647:
	lw	$2,864($16)
	lw	$3,1056($16)
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$3,888($2)
$L646:
	lw	$5,864($16)
	lw	$2,612($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L673
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$2,912($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L653
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L652
$L653:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L652
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L652
$L654:
	li	$3,65536			# 0x00010000
	ori	$3,$3,0x869f
	sll	$2,$5,2
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L655
	sw	$3,872($2)
	.set	macro
	.set	reorder

$L652:
	lw	$3,864($16)
	lw	$2,868($16)
	sll	$3,$3,2
	addu	$3,$16,$3
	subu	$2,$19,$2
	sw	$2,872($3)
$L655:
	lui	$4,%hi(GameSetup_gData) # high
	lw	$2,612($16)
	addiu	$3,$4,%lo(GameSetup_gData) # low
	sw	$19,868($16)
	sw	$2,864($16)
	lw	$3,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L673
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L658
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L657
$L658:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L651
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L657
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

$L657:
	lw	$2,864($16)
	#nop
	addu	$2,$2,1
	mult	$2,$20
	lw	$3,868($16)
	sw	$19,852($16)
	li	$2,2			# 0x00000002
	addu	$3,$3,-512
	sw	$2,912($16)
	sw	$3,868($16)
	mflo	$13
	#nop
	#nop
	sw	$13,848($16)
$L651:
	lui	$2,%hi(GameSetup_gData+48) # high
$L673:
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	beq	$2,$0,$L659
	lh	$2,8($16)
	#nop
	subu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	j	$L660
	addu	$3,$2,-1
	.set	macro
	.set	reorder

$L659:
	lh	$3,8($16)
$L660:
	lw	$2,856($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L674
	move	$11,$0
	.set	macro
	.set	reorder

	lw	$2,912($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sw	$3,856($16)
	.set	macro
	.set	reorder

	lw	$2,864($16)
	lw	$3,616($16)
	#nop
	subu	$2,$2,$3
	mult	$2,$20
	sw	$19,852($16)
	lw	$2,856($16)
	mflo	$13
	#nop
	#nop
	addu	$2,$13,$2
	sw	$2,848($16)
	move	$11,$0
$L674:
	lw	$5,Cars_gNumRaceCars
	lui	$2,%hi(Stats_racePosition) # high
	addiu	$10,$2,%lo(Stats_racePosition) # low
	move	$12,$10
$L663:
	slt	$2,$11,$5
	beq	$2,$0,$L644
	lw	$4,848($16)
	lw	$3,4($10)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	addu	$8,$5,-2
	.set	macro
	.set	reorder

	bne	$4,$3,$L665
	lw	$2,852($16)
	lw	$3,8($10)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L665
$L675:
	sll	$2,$8,4
	addu	$9,$2,16
	addu	$7,$2,$12
$L669:
	slt	$2,$8,$11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	addu	$2,$9,$12
	.set	macro
	.set	reorder

	addu	$9,$9,-16
	lw	$3,0($7)
	lw	$4,4($7)
	lw	$5,8($7)
	lw	$6,12($7)
	addu	$7,$7,-16
	addu	$8,$8,-1
	sw	$3,0($2)
	sw	$4,4($2)
	sw	$5,8($2)
	.set	noreorder
	.set	nomacro
	j	$L669
	sw	$6,12($2)
	.set	macro
	.set	reorder

$L670:
	lw	$3,596($16)
	lw	$4,848($16)
	lw	$2,608($16)
	lw	$5,852($16)
	andi	$2,$2,0x0004
	sw	$3,0($10)
	sw	$4,4($10)
	sw	$5,8($10)
	.set	noreorder
	.set	nomacro
	j	$L644
	sw	$2,12($10)
	.set	macro
	.set	reorder

$L665:
	addu	$10,$10,16
	.set	noreorder
	.set	nomacro
	j	$L663
	addu	$11,$11,1
	.set	macro
	.set	reorder

$L644:
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

	.end	Stats_TrackStats__FP8Car_tObj
	.text
	.ent	Stats_ExtrapolateOpponentTimes__Fi
Stats_ExtrapolateOpponentTimes__Fi:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$22,40($sp)
	move	$22,$4
	li	$4,3			# 0x00000003
	move	$5,$0
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	sltu	$19,$0,$2
	move	$18,$0
	li	$20,2			# 0x00000002
	lui	$23,%hi(GameSetup_gData) # high
	addiu	$21,$23,%lo(GameSetup_gData) # low
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gHumanRaceCarList) # low
$L677:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$5,0($17)
	#nop
	lw	$2,912($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L755
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,848($5)
	#nop
	bgtz	$4,$L682
	li	$4,1			# 0x00000001
$L682:
	lw	$2,852($5)
	#nop
	addu	$6,$2,-512
	slt	$2,$4,100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L683
	sll	$2,$4,1
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$6,$2,$4
$L683:
	lw	$3,gNumSlices
	lw	$2,4($21)
	#nop
	mult	$3,$2
	lw	$2,844($5)
	mflo	$3
	#nop
	#nop
	addu	$2,$3,$2
	mult	$6,$2
	mflo	$3
	#nop
	#nop
	div	$16,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L684
	sll	$2,$16,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L685
	sw	$16,868($5)
	.set	macro
	.set	reorder

$L684:
	sw	$2,868($5)
$L685:
	lw	$2,%lo(GameSetup_gData)($23)
	#nop
	beq	$2,$20,$L686
	beq	$19,$0,$L691
	j	$L754
$L686:
	lw	$2,28($21)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L755
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$19,$0,$L691
$L754:
	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L681
	sw	$20,912($2)
	.set	macro
	.set	reorder

$L691:
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	sw	$2,912($3)
$L681:
	li	$2,1			# 0x00000001
$L755:
	bne	$22,$2,$L693
	lw	$4,%lo(GameSetup_gData)($23)
	#nop
	beq	$4,$20,$L694
	beq	$19,$0,$L695
	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$20,912($2)
	.set	macro
	.set	reorder

$L695:
	lw	$3,0($17)
	#nop
	lw	$2,912($3)
	#nop
	beq	$2,$20,$L698
	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$22,912($3)
	.set	macro
	.set	reorder

$L694:
	lw	$3,0($17)
	#nop
	lw	$2,912($3)
	#nop
	beq	$2,$4,$L698
	lw	$2,28($21)
	#nop
	bne	$2,$18,$L698
	beq	$19,$0,$L700
	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$4,912($3)
	.set	macro
	.set	reorder

$L700:
	sw	$22,912($3)
$L698:
	lw	$4,0($17)
	jal	Stats_GetPosition__FP8Car_tObj
	lw	$3,0($17)
	#nop
	sw	$2,976($3)
	lw	$3,0($17)
	#nop
	lw	$2,868($3)
	#nop
	sw	$2,980($3)
	lw	$2,4($21)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L693
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$6,$2,%lo(GameSetup_gData) # low
$L705:
	lw	$3,0($4)
	sll	$2,$5,2
	addu	$3,$3,$2
	lw	$2,872($3)
	#nop
	sw	$2,984($3)
	lw	$2,4($6)
	addu	$5,$5,1
	slt	$2,$5,$2
	bne	$2,$0,$L705
$L693:
	lw	$4,0($17)
	jal	Stats_GetPosition__FP8Car_tObj
	lw	$3,0($17)
	#nop
	sw	$2,976($3)
	lw	$4,0($17)
	jal	Stats_GetPosition__FP8Car_tObj
	lw	$3,0($17)
	#nop
	sw	$2,976($3)
	lw	$3,0($17)
	#nop
	lw	$2,868($3)
	#nop
	sw	$2,980($3)
	lw	$3,0($17)
	#nop
	lw	$2,912($3)
	#nop
	sw	$2,972($3)
	lw	$3,0($17)
	#nop
	lw	$2,872($3)
	#nop
	sw	$2,1000($3)
	lw	$3,0($17)
	#nop
	lw	$2,928($3)
	#nop
	sw	$2,960($3)
	lw	$3,0($17)
	#nop
	lw	$2,932($3)
	#nop
	sw	$2,964($3)
	lw	$2,0($17)
	#nop
	lw	$3,936($2)
	move	$5,$0
	sw	$3,968($2)
	lw	$2,0($17)
	move	$6,$17
	sw	$0,956($2)
$L710:
	lw	$4,0($6)
	sll	$2,$5,2
	addu	$2,$4,$2
	lw	$3,956($4)
	lw	$2,536($2)
	addu	$5,$5,1
	addu	$3,$3,$2
	slt	$2,$5,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	sw	$3,956($4)
	.set	macro
	.set	reorder

	lw	$2,4($21)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L679
	move	$5,$0
	.set	macro
	.set	reorder

	move	$7,$17
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$8,$2,%lo(GameSetup_gData) # low
$L715:
	lw	$3,0($7)
	sll	$4,$5,2
	addu	$3,$3,$4
	lw	$2,872($3)
	#nop
	sw	$2,984($3)
	lw	$6,0($7)
	#nop
	addu	$4,$6,$4
	lw	$3,984($4)
	lw	$2,1000($6)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L714
	beq	$3,$0,$L714
	sw	$3,1000($6)
$L714:
	lw	$2,4($8)
	addu	$5,$5,1
	slt	$2,$5,$2
	bne	$2,$0,$L715
$L679:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L677
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L678:
	move	$18,$0
	li	$21,2			# 0x00000002
	addiu	$20,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(Cars_gAIRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gAIRaceCarList) # low
$L718:
	lw	$2,Cars_gNumAIRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L719
	lw	$5,0($17)
	#nop
	lw	$2,912($5)
	#nop
	beq	$2,$21,$L722
	lw	$4,848($5)
	#nop
	bgtz	$4,$L723
	li	$4,1			# 0x00000001
$L723:
	lw	$2,852($5)
	#nop
	addu	$6,$2,-512
	slt	$2,$4,100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
	sll	$2,$4,1
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$6,$2,$4
$L724:
	lw	$3,gNumSlices
	lw	$2,4($20)
	#nop
	mult	$3,$2
	lw	$2,844($5)
	mflo	$3
	#nop
	#nop
	addu	$2,$3,$2
	mult	$6,$2
	mflo	$3
	#nop
	#nop
	div	$16,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L725
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$2,912($2)
	#nop
	beq	$2,$21,$L725
	jal	rand
	lw	$3,4($20)
	#nop
	mult	$3,$2
	lw	$3,0($17)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L726
	addu	$2,$2,127
$L726:
	sra	$2,$2,7
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L727
	sw	$2,868($3)
	.set	macro
	.set	reorder

$L725:
	lw	$2,0($17)
	#nop
	sw	$16,868($2)
$L727:
	lw	$2,0($17)
	#nop
	sw	$21,912($2)
$L722:
	lw	$4,0($17)
	jal	Stats_GetPosition__FP8Car_tObj
	lw	$3,0($17)
	#nop
	sw	$2,976($3)
	lw	$3,0($17)
	#nop
	lw	$2,868($3)
	#nop
	sw	$2,980($3)
	lw	$3,0($17)
	#nop
	lw	$2,912($3)
	#nop
	sw	$2,972($3)
	lw	$2,0($17)
	#nop
	lw	$3,936($2)
	li	$4,65536			# 0x00010000
	sw	$3,968($2)
	lw	$2,0($17)
	ori	$4,$4,0x869f
	sw	$4,1000($2)
	lw	$2,4($20)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L729
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$17
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$7,$2,%lo(GameSetup_gData) # low
$L731:
	lw	$4,0($6)
	sll	$2,$5,2
	addu	$2,$4,$2
	lw	$3,1000($4)
	lw	$2,872($2)
	#nop
	slt	$3,$2,$3
	beq	$3,$0,$L730
	blez	$2,$L730
	sw	$2,1000($4)
$L730:
	lw	$2,4($7)
	addu	$5,$5,1
	slt	$2,$5,$2
	bne	$2,$0,$L731
$L729:
	jal	rand
	lw	$5,0($17)
	lw	$3,4($20)
	lw	$4,980($5)
	#nop
	div	$4,$4,$3
	li	$3,715784192			# 0x2aaa0000
	ori	$3,$3,0xaaab
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$3
	#nop
	#nop
	sra	$3,$3,3
	subu	$3,$3,$2
	lw	$2,1000($5)
	subu	$4,$4,$3
	slt	$2,$4,$2
	beq	$2,$0,$L734
	sw	$4,1000($5)
$L734:
	lw	$2,4($20)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L720
	move	$5,$0
	.set	macro
	.set	reorder

	move	$7,$17
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$8,$2,%lo(GameSetup_gData) # low
$L738:
	lw	$3,0($7)
	sll	$4,$5,2
	addu	$3,$3,$4
	lw	$2,872($3)
	#nop
	sw	$2,984($3)
	lw	$6,0($7)
	#nop
	addu	$4,$6,$4
	lw	$3,984($4)
	lw	$2,1000($6)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L737
	beq	$3,$0,$L737
	sw	$3,1000($6)
$L737:
	lw	$2,4($8)
	addu	$5,$5,1
	slt	$2,$5,$2
	bne	$2,$0,$L738
$L720:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L718
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L719:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L741
	move	$8,$0
	.set	macro
	.set	reorder

	lw	$12,Cars_gNumRaceCars
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$9,$2,%lo(Cars_gRaceCarList) # low
	move	$13,$9
$L742:
	slt	$2,$8,$12
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$12,$L747
	move	$5,$0
	.set	macro
	.set	reorder

	move	$11,$9
	lw	$10,Cars_gNumRaceCars
	move	$7,$13
$L749:
	beq	$8,$5,$L748
	lw	$2,0($11)
	lw	$3,0($7)
	lw	$4,980($2)
	lw	$3,980($3)
	#nop
	slt	$2,$3,$4
	bne	$2,$0,$L752
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L748
	slt	$2,$5,$8
	.set	macro
	.set	reorder

	beq	$2,$0,$L748
$L752:
	addu	$6,$6,1
 #APP
 #NO_APP
$L748:
	addu	$5,$5,1
	slt	$2,$5,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	addu	$7,$7,4
	.set	macro
	.set	reorder

$L747:
	lw	$2,0($9)
	addu	$9,$9,4
	addu	$8,$8,1
	.set	noreorder
	.set	nomacro
	j	$L742
	sw	$6,976($2)
	.set	macro
	.set	reorder

$L741:
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

	.end	Stats_ExtrapolateOpponentTimes__Fi
	.text
	.ent	Stats_TrackEndGame__Fv
Stats_TrackEndGame__Fv:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lw	$2,Cars_gNumRaceCars
	subu	$sp,$sp,72
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L757
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L759
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,63
$L759:
	sra	$2,$2,6
	sll	$2,$2,6
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L791
	lui	$2,%hi(simVar+4) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+4) # high
	lw	$4,%lo(GameSetup_gData+4)($2)
	lw	$2,gNumSlices
	#nop
	mult	$4,$2
	move	$6,$0
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	addiu	$19,$3,%lo(Cars_gHumanRaceCarList) # low
	mflo	$5
$L760:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L791
	lui	$2,%hi(simVar+4) # high
	.set	macro
	.set	reorder

	lw	$4,0($19)
	#nop
	lw	$3,848($4)
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L764
	sw	$5,20($sp)
	.set	macro
	.set	reorder

	sw	$3,20($sp)
$L764:
	sw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Stats_GetPosition__FP8Car_tObj
	sw	$6,28($sp)
	.set	macro
	.set	reorder

	move	$21,$0
	move	$20,$2
	li	$13,1			# 0x00000001
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	bne	$20,$13,$L765
	move	$22,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L766
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

$L790:
	lui	$13,%hi(Cars_gRaceCarList) # high
	addiu	$13,$13,%lo(Cars_gRaceCarList) # low
	addu	$2,$2,$13
	lw	$2,0($2)
	#nop
	lw	$2,1056($2)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	.set	noreorder
	.set	nomacro
	j	$L770
	sra	$22,$2,16
	.set	macro
	.set	reorder

$L765:
	lui	$2,%hi(GameSetup_gData+188) # high
	lw	$2,%lo(GameSetup_gData+188)($2)
	li	$18,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L792
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$18,$20,-1
$L766:
	move	$17,$0
$L792:
	move	$fp,$19
	la	$16,Cars_gRaceCarList
$L771:
	lw	$2,Cars_gNumRaceCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	move	$23,$17
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$4,0($16)
	sw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Stats_GetPosition__FP8Car_tObj
	sw	$6,28($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	lw	$6,28($sp)
	bne	$2,$18,$L773
	lw	$2,0($16)
	#nop
	lw	$21,848($2)
	#nop
	slt	$2,$5,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	li	$13,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$21,$5
$L793:
	.set	noreorder
	.set	nomacro
	beq	$20,$13,$L790
	sll	$2,$23,2
	.set	macro
	.set	reorder

	lw	$2,0($fp)
	#nop
	lh	$22,1058($2)
	j	$L770
$L773:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L771
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L770:
	lw	$13,20($sp)
	lw	$2,0($19)
	subu	$3,$21,$13
	sw	$3,920($2)
	slt	$2,$22,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L778
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,0($19)
	#nop
	lw	$3,912($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L778
	li	$13,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,920($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,7
	div	$2,$2,$22
	sw	$2,916($4)
	lw	$2,0($19)
	.set	noreorder
	.set	nomacro
	j	$L762
	sw	$13,924($2)
	.set	macro
	.set	reorder

$L778:
	lw	$2,0($19)
	#nop
	sw	$0,916($2)
	lw	$2,0($19)
	#nop
	sw	$0,924($2)
$L762:
	addu	$19,$19,4
	.set	noreorder
	.set	nomacro
	j	$L760
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L757:
	lui	$2,%hi(simVar+4) # high
$L791:
	lw	$2,%lo(simVar+4)($2)
	#nop
	bne	$2,$0,$L756
	lw	$3,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L782
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$12,$2,%lo(simGlobal) # low
	li	$11,-1			# 0xffffffff
	move	$10,$3
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$5,$2,%lo(Cars_gHumanRaceCarList) # low
	lw	$9,CopSpeak_gQueuePlay
	lw	$8,CopSpeak_gQueueHead
	lw	$7,CopSpeak_gSpchHandle
$L784:
	lw	$3,0($5)
	#nop
	lw	$2,912($3)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L783
	lw	$3,852($3)
	lw	$4,4($12)
	addu	$2,$3,320
	slt	$2,$2,$4
	beq	$2,$0,$L783
	.set	noreorder
	.set	nomacro
	bne	$9,$8,$L794
	addu	$2,$3,640
	.set	macro
	.set	reorder

	beq	$7,$11,$L786
$L794:
	slt	$2,$2,$4
	beq	$2,$0,$L783
$L786:
	lw	$13,16($sp)
	#nop
	addu	$13,$13,1
	sw	$13,16($sp)
$L783:
	addu	$6,$6,1
	slt	$2,$6,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L784
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L782:
	lw	$2,Cars_gNumHumanRaceCars
	lw	$13,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$13,$2,$L756
	lui	$3,%hi(simVar+4) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,%lo(simVar+4)($3)
	.set	noreorder
	.set	nomacro
	jal	Stats_ExtrapolateOpponentTimes__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L756:
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

	.end	Stats_TrackEndGame__Fv
