	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\replay.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Replay_Compress__FPc
	.align	2
	.globl	Replay_Decompress__FPc
	.align	2
	.globl	Replay_InitReplay__Fv
	.align	2
	.globl	Replay_ResetReplay__Fv
	.align	2
	.globl	Replay_StoringReplay__Fv
	.align	2
	.globl	Replay_StoringControllerData__FG15tControllerData
	.align	2
	.globl	Replay_RetreivingControllerData__Fv
	.align	2
	.globl	Replay_SaveInput__Fi
	.align	2
	.globl	Replay_GetInput__Fi
	.align	2
	.globl	Replay_SaveReplay__Fv
	.align	2
	.globl	Replay_LoadReplay__Fv
	.align	2
	.globl	Replay_DoReplay__FP8Car_tObj
	.align	2
	.globl	Replay_GetInterfaceKey__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"%scamera.viv\000"
	.align	2
$LC1:
	.ascii	"tr%02dr.rho\000"
	.align	2
$LC2:
	.ascii	"tr%02d.rho\000"
	.text
	.align	2
	.globl	Replay_LoadCameraFile__Fv
	.align	2
	.globl	Replay_ReplayChooseCamera__Fii
	.align	2
	.globl	Replay_ReplayFindClosestCamera__Fii
	.globl	Replay_Size
	.sdata
	.align	2
Replay_Size:
	.space	4
	.globl	numValidCams
	.align	2
numValidCams:
	.space	4
	.globl	Replay_ReplayMode
	.align	2
Replay_ReplayMode:
	.space	4
	.globl	Replay_ReplayStorePtr
	.align	2
Replay_ReplayStorePtr:
	.space	4
	.globl	Replay_ReplayGetPtr
	.align	2
Replay_ReplayGetPtr:
	.space	4

	.extern	gNumSlices, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	simVar, 28
	.extern	Input_gSim, 4
	.extern	simGlobal, 24
	.extern	D_8013D99C, 4
	.extern	StatsTimer, 4
	.extern	Replay_ReplayCounter, 8
	.extern	Replay_ReplayCamera, 32
	.extern	Cars_gHumanRaceCarList, 8
	.extern	Replay_ReplayInterface, 32
	.extern	Replay_ReplayBuffer, 27180
	.extern	GameSetup_gData, 2600
	.extern	uncompressed_data, 32
	.extern	compressed_data, 33

	.text
	.text
	.ent	Replay_Compress__FPc
Replay_Compress__FPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$0
	li	$7,1			# 0x00000001
	li	$13,255			# 0x000000ff
	lui	$2,%hi(compressed_data) # high
	addiu	$12,$2,%lo(compressed_data) # low
	addu	$6,$12,$7
	addu	$11,$4,32
	move	$10,$11
$L601:
	lbu	$8,0($4)
	move	$5,$0
	andi	$3,$8,0x00ff
	addu	$4,$4,1
$L618:
	lbu	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L605
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$4,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$4,$4,1
	.set	macro
	.set	reorder

	addu	$4,$4,-1
$L605:
	slt	$2,$5,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	addu	$2,$7,$12
	.set	macro
	.set	reorder

	sb	$13,0($6)
	addu	$6,$6,3
	move	$3,$2
	addu	$7,$7,3
	sb	$5,1($2)
	.set	noreorder
	.set	nomacro
	j	$L610
	sb	$8,2($3)
	.set	macro
	.set	reorder

$L609:
	.set	noreorder
	.set	nomacro
	blez	$5,$L610
	move	$3,$0
	.set	macro
	.set	reorder

$L612:
	sb	$8,0($6)
	addu	$6,$6,1
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L610:
	slt	$2,$4,$11
	bne	$2,$0,$L603
	li	$9,1			# 0x00000001
$L603:
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L601
	lui	$2,%hi(compressed_data) # high
	.set	macro
	.set	reorder

	sb	$7,%lo(compressed_data)($2)
	addiu	$2,$2,%lo(compressed_data) # low
	addu	$3,$7,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,0($3)
	.set	macro
	.set	reorder

	.end	Replay_Compress__FPc
	.text
	.ent	Replay_Decompress__FPc
Replay_Decompress__FPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$9,0($4)
	li	$8,1			# 0x00000001
	slt	$2,$8,$9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L620
	li	$10,255			# 0x000000ff
	.set	macro
	.set	reorder

	addu	$4,$4,$8
	lui	$2,%hi(uncompressed_data) # high
	addiu	$5,$2,%lo(uncompressed_data) # low
$L621:
	lbu	$2,0($4)
	#nop
	bne	$2,$10,$L624
	lbu	$7,1($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L625
	move	$3,$0
	.set	macro
	.set	reorder

	move	$6,$4
$L626:
	lbu	$2,2($6)
	addu	$3,$3,1
	sb	$2,0($5)
	slt	$2,$3,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L625:
	addu	$4,$4,3
	.set	noreorder
	.set	nomacro
	j	$L623
	addu	$8,$8,3
	.set	macro
	.set	reorder

$L624:
	sb	$2,0($5)
	addu	$5,$5,1
	addu	$4,$4,1
	addu	$8,$8,1
$L623:
	slt	$2,$8,$9
	bne	$2,$0,$L621
$L620:
	lui	$2,%hi(uncompressed_data) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo(uncompressed_data) # low
	.set	macro
	.set	reorder

	.end	Replay_Decompress__FPc
	.text
	.ent	Replay_InitReplay__Fv
Replay_InitReplay__Fv:
	.frame	$sp,232,$31		# vars= 208, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,232
	lui	$2,%hi(GameSetup_gData) # high
	sw	$16,224($sp)
	addiu	$16,$2,%lo(GameSetup_gData) # low
	sw	$31,228($sp)
	lw	$2,36($16)
	#nop
	sw	$2,Replay_ReplayMode
	jal	Replay_LoadCameraFile__Fv
	lw	$3,Replay_ReplayMode
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L633
	lui	$2,%hi(Replay_ReplayBuffer) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addu	$3,$16,224
	addu	$2,$16,416
$L634:
	lw	$5,0($3)
	lw	$6,4($3)
	lw	$7,8($3)
	lw	$8,12($3)
	sw	$5,0($4)
	sw	$6,4($4)
	sw	$7,8($4)
	sw	$8,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L634
	addu	$4,$4,16
	.set	macro
	.set	reorder

	lw	$5,0($3)
	lw	$6,4($3)
	lw	$7,8($3)
	sw	$5,0($4)
	sw	$6,4($4)
	.set	noreorder
	.set	nomacro
	jal	Replay_LoadReplay__Fv
	sw	$7,8($4)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(Replay_ReplayBuffer) # high
	addiu	$2,$2,%lo(Replay_ReplayBuffer) # low
	addu	$4,$2,2592
$L635:
	lw	$5,0($2)
	lw	$6,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$5,0($3)
	sw	$6,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L635
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$5,0($2)
	lw	$6,4($2)
	sw	$5,0($3)
	sw	$6,4($3)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$2,$2,224
	addu	$3,$sp,16
	addu	$4,$sp,208
$L636:
	lw	$5,0($3)
	lw	$6,4($3)
	lw	$7,8($3)
	lw	$8,12($3)
	sw	$5,0($2)
	sw	$6,4($2)
	sw	$7,8($2)
	sw	$8,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L636
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$5,0($3)
	lw	$6,4($3)
	lw	$7,8($3)
	sw	$5,0($2)
	sw	$6,4($2)
	sw	$7,8($2)
	lui	$2,%hi(Replay_ReplayBuffer+2600) # high
	lw	$2,%lo(Replay_ReplayBuffer+2600)($2)
	sw	$0,Replay_ReplayGetPtr
	sw	$2,Replay_Size
	j	$L632
$L633:
	addiu	$3,$2,%lo(Replay_ReplayBuffer) # low
	move	$2,$16
	addu	$4,$2,2592
$L638:
	lw	$5,0($2)
	lw	$6,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$5,0($3)
	sw	$6,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L638
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$5,0($2)
	lw	$6,4($2)
	sw	$5,0($3)
	sw	$6,4($3)
$L632:
	lw	$31,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,232
	.set	macro
	.set	reorder

	.end	Replay_InitReplay__Fv
	.text
	.ent	Replay_ResetReplay__Fv
Replay_ResetReplay__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$3,Replay_ReplayMode
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sltu	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$16,24575			# 0x00005fff
	lui	$2,%hi(Replay_ReplayBuffer) # high
	addiu	$2,$2,%lo(Replay_ReplayBuffer) # low
	addu	$2,$2,$16
$L641:
	sb	$0,2604($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L641
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	sw	$0,Replay_ReplayStorePtr
	sw	$0,Replay_ReplayGetPtr
	.set	noreorder
	.set	nomacro
	j	$L659
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L640:
	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(Replay_ReplayCamera) # high
	addiu	$17,$2,%lo(Replay_ReplayCamera) # low
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$18,$2,%lo(Cars_gHumanRaceCarList) # low
	lui	$2,%hi(Replay_ReplayInterface) # high
	sw	$0,%lo(Replay_ReplayInterface)($2)
	addiu	$2,$2,%lo(Replay_ReplayInterface) # low
	li	$3,2			# 0x00000002
	sw	$3,4($2)
	li	$3,4			# 0x00000004
	sw	$0,Replay_ReplayGetPtr
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$3,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
$L647:
	lw	$2,numValidCams
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,12($19)
	#nop
	beq	$3,$2,$L652
	bne	$16,$0,$L651
$L652:
	lw	$2,0($18)
	#nop
	lh	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	Replay_ReplayFindClosestCamera__Fii
	move	$4,$16
	.set	macro
	.set	reorder

$L651:
	.set	noreorder
	.set	nomacro
	j	$L653
	li	$2,19			# 0x00000013
	.set	macro
	.set	reorder

$L650:
	li	$2,4			# 0x00000004
$L653:
	sw	$2,8($17)
	sw	$0,12($17)
	addu	$17,$17,16
	addu	$16,$16,1
	slt	$2,$16,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	addu	$18,$18,4
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L659:
	lui	$2,%hi(Replay_ReplayCounter+4) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter+4) # low
$L655:
	sw	$0,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L655
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	sw	$0,StatsTimer
	sw	$0,D_8013D99C
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Replay_ResetReplay__Fv
	.text
	.ent	Replay_StoringReplay__Fv
Replay_StoringReplay__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Replay_SaveReplay__Fv
	lw	$31,16($sp)
	sw	$0,numValidCams
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Replay_StoringReplay__Fv
	.text
	.ent	Replay_StoringControllerData__FG15tControllerData
Replay_StoringControllerData__FG15tControllerData:
	.frame	$sp,64,$31		# vars= 40, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayStorePtr
	subu	$sp,$sp,64
	sw	$31,60($sp)
	sw	$16,56($sp)
	sw	$4,64($sp)
	sw	$5,68($sp)
	sw	$6,72($sp)
	addu	$2,$2,128
	slt	$2,$2,24576
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L662
	sw	$7,76($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	li	$2,1			# 0x00000001
	sw	$2,Replay_ReplayMode
	sw	$3,Replay_Size
	j	$L661
$L662:
	.set	noreorder
	.set	nomacro
	jal	Replay_Compress__FPc
	addu	$4,$sp,64
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$3,$2
	andi	$2,$3,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$3,32
$L665:
	lwl	$8,3($3)
	lwr	$8,0($3)
	lwl	$9,7($3)
	lwr	$9,4($3)
	lwl	$10,11($3)
	lwr	$10,8($3)
	lwl	$11,15($3)
	lwr	$11,12($3)
	swl	$8,3($4)
	swr	$8,0($4)
	swl	$9,7($4)
	swr	$9,4($4)
	swl	$10,11($4)
	swr	$10,8($4)
	swl	$11,15($4)
	swr	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L665
	addu	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L679
	addu	$16,$sp,16
	.set	macro
	.set	reorder

$L663:
	addu	$2,$3,32
$L666:
	lw	$8,0($3)
	lw	$9,4($3)
	lw	$10,8($3)
	lw	$11,12($3)
	sw	$8,0($4)
	sw	$9,4($4)
	sw	$10,8($4)
	sw	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L666
	addu	$4,$4,16
	.set	macro
	.set	reorder

	addu	$16,$sp,16
$L679:
	move	$5,$16
	lb	$8,0($3)
	sb	$8,0($4)
	lui	$4,%hi(Replay_ReplayBuffer+2604) # high
	addiu	$4,$4,%lo(Replay_ReplayBuffer+2604) # low
	lw	$2,Replay_ReplayStorePtr
	lbu	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,Replay_ReplayStorePtr
	lbu	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,Replay_ReplayStorePtr
	.set	noreorder
	.set	nomacro
	jal	Replay_Compress__FPc
	addu	$4,$sp,96
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$3,$2
	andi	$2,$3,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$3,32
$L669:
	lwl	$8,3($3)
	lwr	$8,0($3)
	lwl	$9,7($3)
	lwr	$9,4($3)
	lwl	$10,11($3)
	lwr	$10,8($3)
	lwl	$11,15($3)
	lwr	$11,12($3)
	swl	$8,3($4)
	swr	$8,0($4)
	swl	$9,7($4)
	swr	$9,4($4)
	swl	$10,11($4)
	swr	$10,8($4)
	swl	$11,15($4)
	swr	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L669
	addu	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L680
	addu	$16,$sp,16
	.set	macro
	.set	reorder

$L667:
	addu	$2,$3,32
$L670:
	lw	$8,0($3)
	lw	$9,4($3)
	lw	$10,8($3)
	lw	$11,12($3)
	sw	$8,0($4)
	sw	$9,4($4)
	sw	$10,8($4)
	sw	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L670
	addu	$4,$4,16
	.set	macro
	.set	reorder

	addu	$16,$sp,16
$L680:
	move	$5,$16
	lb	$8,0($3)
	sb	$8,0($4)
	lui	$4,%hi(Replay_ReplayBuffer+2604) # high
	addiu	$4,$4,%lo(Replay_ReplayBuffer+2604) # low
	lw	$2,Replay_ReplayStorePtr
	lbu	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,Replay_ReplayStorePtr
	lbu	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,Replay_ReplayStorePtr
	.set	noreorder
	.set	nomacro
	jal	Replay_Compress__FPc
	addu	$4,$sp,128
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$3,$2
	andi	$2,$3,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$3,32
$L673:
	lwl	$8,3($3)
	lwr	$8,0($3)
	lwl	$9,7($3)
	lwr	$9,4($3)
	lwl	$10,11($3)
	lwr	$10,8($3)
	lwl	$11,15($3)
	lwr	$11,12($3)
	swl	$8,3($4)
	swr	$8,0($4)
	swl	$9,7($4)
	swr	$9,4($4)
	swl	$10,11($4)
	swr	$10,8($4)
	swl	$11,15($4)
	swr	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L673
	addu	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L681
	addu	$16,$sp,16
	.set	macro
	.set	reorder

$L671:
	addu	$2,$3,32
$L674:
	lw	$8,0($3)
	lw	$9,4($3)
	lw	$10,8($3)
	lw	$11,12($3)
	sw	$8,0($4)
	sw	$9,4($4)
	sw	$10,8($4)
	sw	$11,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L674
	addu	$4,$4,16
	.set	macro
	.set	reorder

	addu	$16,$sp,16
$L681:
	move	$5,$16
	lb	$8,0($3)
	sb	$8,0($4)
	lui	$4,%hi(Replay_ReplayBuffer+2604) # high
	addiu	$4,$4,%lo(Replay_ReplayBuffer+2604) # low
	lw	$2,Replay_ReplayStorePtr
	lbu	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,Replay_ReplayStorePtr
	lbu	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,Replay_ReplayStorePtr
	.set	noreorder
	.set	nomacro
	jal	Replay_Compress__FPc
	addu	$4,$sp,160
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$3,$2
	andi	$2,$3,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	addu	$2,$3,32
	.set	macro
	.set	reorder

$L677:
	lwl	$8,3($3)
	lwr	$8,0($3)
	lwl	$9,7($3)
	lwr	$9,4($3)
	lwl	$10,11($3)
	lwr	$10,8($3)
	lwl	$11,15($3)
	lwr	$11,12($3)
	swl	$8,3($16)
	swr	$8,0($16)
	swl	$9,7($16)
	swr	$9,4($16)
	swl	$10,11($16)
	swr	$10,8($16)
	swl	$11,15($16)
	swr	$11,12($16)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L677
	addu	$16,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L682
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L675:
$L678:
	lw	$8,0($3)
	lw	$9,4($3)
	lw	$10,8($3)
	lw	$11,12($3)
	sw	$8,0($16)
	sw	$9,4($16)
	sw	$10,8($16)
	sw	$11,12($16)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L678
	addu	$16,$16,16
	.set	macro
	.set	reorder

	addu	$5,$sp,16
$L682:
	lui	$4,%hi(Replay_ReplayBuffer+2604) # high
	addiu	$4,$4,%lo(Replay_ReplayBuffer+2604) # low
	lb	$8,0($3)
	sb	$8,0($16)
 #APP
 #NO_APP
	lw	$2,Replay_ReplayStorePtr
	lbu	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,Replay_ReplayStorePtr
	lbu	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,Replay_ReplayStorePtr
$L661:
	lw	$31,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Replay_StoringControllerData__FG15tControllerData
	.text
	.ent	Replay_RetreivingControllerData__Fv
Replay_RetreivingControllerData__Fv:
	.frame	$sp,208,$31		# vars= 168, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$19,196($sp)
	move	$19,$4
	sw	$18,192($sp)
	addu	$18,$sp,144
	move	$4,$18
	sw	$16,184($sp)
	lui	$16,%hi(Replay_ReplayBuffer+2604) # high
	lw	$5,Replay_ReplayGetPtr
	addiu	$16,$16,%lo(Replay_ReplayBuffer+2604) # low
	sw	$17,188($sp)
	addu	$17,$16,-2604
	sw	$31,200($sp)
	addu	$2,$5,$17
	lbu	$6,2604($2)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Replay_Decompress__FPc
	move	$4,$18
	.set	macro
	.set	reorder

	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,19($sp)
	swr	$7,16($sp)
	swl	$8,23($sp)
	swr	$8,20($sp)
	swl	$9,27($sp)
	swr	$9,24($sp)
	swl	$10,31($sp)
	swr	$10,28($sp)
	lwl	$7,19($2)
	lwr	$7,16($2)
	lwl	$8,23($2)
	lwr	$8,20($2)
	lwl	$9,27($2)
	lwr	$9,24($2)
	lwl	$10,31($2)
	lwr	$10,28($2)
	swl	$7,35($sp)
	swr	$7,32($sp)
	swl	$8,39($sp)
	swr	$8,36($sp)
	swl	$9,43($sp)
	swr	$9,40($sp)
	swl	$10,47($sp)
	swr	$10,44($sp)
	lbu	$2,144($sp)
	lw	$5,Replay_ReplayGetPtr
	move	$4,$18
	addu	$5,$5,$2
	addu	$2,$5,$17
	sw	$5,Replay_ReplayGetPtr
	lbu	$6,2604($2)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Replay_Decompress__FPc
	move	$4,$18
	.set	macro
	.set	reorder

	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,51($sp)
	swr	$7,48($sp)
	swl	$8,55($sp)
	swr	$8,52($sp)
	swl	$9,59($sp)
	swr	$9,56($sp)
	swl	$10,63($sp)
	swr	$10,60($sp)
	lwl	$7,19($2)
	lwr	$7,16($2)
	lwl	$8,23($2)
	lwr	$8,20($2)
	lwl	$9,27($2)
	lwr	$9,24($2)
	lwl	$10,31($2)
	lwr	$10,28($2)
	swl	$7,67($sp)
	swr	$7,64($sp)
	swl	$8,71($sp)
	swr	$8,68($sp)
	swl	$9,75($sp)
	swr	$9,72($sp)
	swl	$10,79($sp)
	swr	$10,76($sp)
	lbu	$2,144($sp)
	lw	$5,Replay_ReplayGetPtr
	move	$4,$18
	addu	$5,$5,$2
	addu	$2,$5,$17
	sw	$5,Replay_ReplayGetPtr
	lbu	$6,2604($2)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Replay_Decompress__FPc
	move	$4,$18
	.set	macro
	.set	reorder

	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,83($sp)
	swr	$7,80($sp)
	swl	$8,87($sp)
	swr	$8,84($sp)
	swl	$9,91($sp)
	swr	$9,88($sp)
	swl	$10,95($sp)
	swr	$10,92($sp)
	lwl	$7,19($2)
	lwr	$7,16($2)
	lwl	$8,23($2)
	lwr	$8,20($2)
	lwl	$9,27($2)
	lwr	$9,24($2)
	lwl	$10,31($2)
	lwr	$10,28($2)
	swl	$7,99($sp)
	swr	$7,96($sp)
	swl	$8,103($sp)
	swr	$8,100($sp)
	swl	$9,107($sp)
	swr	$9,104($sp)
	swl	$10,111($sp)
	swr	$10,108($sp)
	lbu	$2,144($sp)
	lw	$5,Replay_ReplayGetPtr
	move	$4,$18
	addu	$5,$5,$2
	addu	$17,$5,$17
	sw	$5,Replay_ReplayGetPtr
	lbu	$6,2604($17)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Replay_Decompress__FPc
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$19
	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,115($sp)
	swr	$7,112($sp)
	swl	$8,119($sp)
	swr	$8,116($sp)
	swl	$9,123($sp)
	swr	$9,120($sp)
	swl	$10,127($sp)
	swr	$10,124($sp)
	lwl	$7,19($2)
	lwr	$7,16($2)
	lwl	$8,23($2)
	lwr	$8,20($2)
	lwl	$9,27($2)
	lwr	$9,24($2)
	lwl	$10,31($2)
	lwr	$10,28($2)
	swl	$7,131($sp)
	swr	$7,128($sp)
	swl	$8,135($sp)
	swr	$8,132($sp)
	swl	$9,139($sp)
	swr	$9,136($sp)
	swl	$10,143($sp)
	swr	$10,140($sp)
	lbu	$4,144($sp)
	lw	$2,Replay_ReplayGetPtr
	#nop
	addu	$2,$2,$4
	sw	$2,Replay_ReplayGetPtr
	andi	$2,$19,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L684
	addu	$3,$sp,16
	.set	macro
	.set	reorder

	move	$4,$18
$L686:
	lwl	$7,3($3)
	lwr	$7,0($3)
	lwl	$8,7($3)
	lwr	$8,4($3)
	lwl	$9,11($3)
	lwr	$9,8($3)
	lwl	$10,15($3)
	lwr	$10,12($3)
	swl	$7,3($5)
	swr	$7,0($5)
	swl	$8,7($5)
	swr	$8,4($5)
	swl	$9,11($5)
	swr	$9,8($5)
	swl	$10,15($5)
	swr	$10,12($5)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L686
	addu	$5,$5,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L688
	move	$2,$19
	.set	macro
	.set	reorder

$L684:
	move	$4,$18
$L687:
	lw	$7,0($3)
	lw	$8,4($3)
	lw	$9,8($3)
	lw	$10,12($3)
	sw	$7,0($5)
	sw	$8,4($5)
	sw	$9,8($5)
	sw	$10,12($5)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L687
	addu	$5,$5,16
	.set	macro
	.set	reorder

	move	$2,$19
$L688:
	lw	$31,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	Replay_RetreivingControllerData__Fv
	.text
	.ent	Replay_SaveInput__Fi
Replay_SaveInput__Fi:
	.frame	$sp,136,$31		# vars= 0, regs= 2/0, args= 128, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$16,128($sp)
	sw	$31,132($sp)
	.set	noreorder
	.set	nomacro
	jal	Input_Fetch__Fi
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(controlData) # high
	addiu	$7,$2,%lo(controlData) # low
	sll	$6,$16,2
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$4,$6,$2
	sll	$16,$16,7
	lw	$2,0($4)
	lb	$3,Input_gSim
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bgez	$3,$L690
	addu	$5,$2,$7
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L690:
	sra	$2,$3,2
	addu	$2,$2,64
	sb	$2,0($5)
	lw	$3,0($4)
	lbu	$2,Input_gSim+1
	addu	$3,$3,$16
	addu	$3,$3,$7
	srl	$2,$2,3
	sb	$2,32($3)
	lw	$3,0($4)
	lbu	$2,Input_gSim+2
	addu	$3,$3,$16
	addu	$3,$3,$7
	srl	$2,$2,3
	sb	$2,64($3)
	lw	$2,0($4)
	lbu	$3,Input_gSim+3
	addu	$2,$2,$16
	addu	$2,$2,$7
	sb	$3,96($2)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$5,$6,$2
	lw	$2,0($5)
	#nop
	lw	$2,648($2)
	#nop
	lw	$2,24($2)
	#nop
	beq	$2,$0,$L691
	lw	$3,0($4)
	#nop
	addu	$3,$3,$16
	addu	$3,$3,$7
	lbu	$2,0($3)
	#nop
	ori	$2,$2,0x0080
	sb	$2,0($3)
$L691:
	lw	$2,0($5)
	#nop
	lw	$2,648($2)
	#nop
	lw	$2,28($2)
	#nop
	beq	$2,$0,$L692
	lw	$3,0($4)
	#nop
	addu	$3,$3,$16
	addu	$3,$3,$7
	lbu	$2,32($3)
	#nop
	ori	$2,$2,0x0080
	sb	$2,32($3)
$L692:
	lw	$2,0($5)
	#nop
	lw	$2,648($2)
	#nop
	lw	$2,32($2)
	#nop
	beq	$2,$0,$L693
	lw	$3,0($4)
	#nop
	addu	$3,$3,$16
	addu	$3,$3,$7
	lbu	$2,64($3)
	#nop
	ori	$2,$2,0x0080
	sb	$2,64($3)
$L693:
	lw	$2,0($4)
	li	$3,32			# 0x00000020
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L689
	sw	$2,0($4)
	.set	macro
	.set	reorder

	li	$5,-16777216			# 0xff000000
	ori	$5,$5,0xffff
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	addu	$12,$sp,16
	addu	$16,$16,$7
	addu	$11,$16,16
	sw	$0,0($4)
	lbu	$8,0($16)
	lbu	$9,4($16)
	lbu	$10,8($16)
	lbu	$2,1($16)
	lbu	$7,12($16)
	lbu	$3,2($16)
	lbu	$4,3($16)
	sll	$2,$2,8
	or	$8,$8,$2
	sll	$3,$3,16
	or	$8,$8,$3
	sll	$4,$4,24
	or	$8,$8,$4
	lbu	$2,5($16)
	lbu	$3,7($16)
	sll	$2,$2,8
	or	$9,$9,$2
	and	$9,$9,$5
	lbu	$2,6($16)
	sll	$3,$3,24
	sll	$2,$2,16
	or	$9,$9,$2
	and	$9,$9,$6
	or	$9,$9,$3
	lbu	$2,9($16)
	lbu	$3,11($16)
	sll	$2,$2,8
	or	$10,$10,$2
	and	$10,$10,$5
	lbu	$2,10($16)
	sll	$3,$3,24
	sll	$2,$2,16
	or	$10,$10,$2
	and	$10,$10,$6
	lbu	$2,13($16)
	#nop
	sll	$2,$2,8
	or	$7,$7,$2
	lbu	$2,14($16)
	and	$7,$7,$5
	sll	$2,$2,16
	or	$7,$7,$2
	lbu	$2,15($16)
	and	$7,$7,$6
	sll	$2,$2,24
	or	$7,$7,$2
	andi	$2,$11,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	or	$10,$10,$3
	.set	macro
	.set	reorder

	addu	$2,$16,128
$L697:
	lwl	$13,3($11)
	lwr	$13,0($11)
	lwl	$14,7($11)
	lwr	$14,4($11)
	lwl	$15,11($11)
	lwr	$15,8($11)
	lwl	$24,15($11)
	lwr	$24,12($11)
	swl	$13,3($12)
	swr	$13,0($12)
	swl	$14,7($12)
	swr	$14,4($12)
	swl	$15,11($12)
	swr	$15,8($12)
	swl	$24,15($12)
	swr	$24,12($12)
	addu	$11,$11,16
	.set	noreorder
	.set	nomacro
	bne	$11,$2,$L697
	addu	$12,$12,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L699
	move	$4,$8
	.set	macro
	.set	reorder

$L695:
	addu	$2,$16,128
$L698:
	lw	$13,0($11)
	lw	$14,4($11)
	lw	$15,8($11)
	lw	$24,12($11)
	sw	$13,0($12)
	sw	$14,4($12)
	sw	$15,8($12)
	sw	$24,12($12)
	addu	$11,$11,16
	.set	noreorder
	.set	nomacro
	bne	$11,$2,$L698
	addu	$12,$12,16
	.set	macro
	.set	reorder

	move	$4,$8
$L699:
	move	$5,$9
	.set	noreorder
	.set	nomacro
	jal	Replay_StoringControllerData__FG15tControllerData
	move	$6,$10
	.set	macro
	.set	reorder

$L689:
	lw	$31,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	Replay_SaveInput__Fi
	.text
	.ent	Replay_GetInput__Fi
Replay_GetInput__Fi:
	.frame	$sp,160,$31		# vars= 128, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$17,148($sp)
	move	$17,$4
	sw	$31,152($sp)
	.set	noreorder
	.set	nomacro
	jal	Input_Fetch__Fi
	sw	$16,144($sp)
	.set	macro
	.set	reorder

	sll	$2,$17,2
	lui	$3,%hi(Replay_ReplayCounter) # high
	addiu	$3,$3,%lo(Replay_ReplayCounter) # low
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	lui	$2,%hi(Replay_ReplayBuffer) # high
	.set	macro
	.set	reorder

	lw	$3,Replay_ReplayGetPtr
	addiu	$2,$2,%lo(Replay_ReplayBuffer) # low
	addu	$3,$3,$2
	lbu	$2,2604($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L702
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	sw	$2,Replay_ReplayMode
	j	$L701
$L702:
	lui	$2,%hi(controlData) # high
	addiu	$2,$2,%lo(controlData) # low
	sll	$16,$17,7
	.set	noreorder
	.set	nomacro
	jal	Replay_RetreivingControllerData__Fv
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	andi	$2,$16,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L704
	addu	$3,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$sp,144
$L706:
	lwl	$7,3($3)
	lwr	$7,0($3)
	lwl	$8,7($3)
	lwr	$8,4($3)
	lwl	$9,11($3)
	lwr	$9,8($3)
	lwl	$10,15($3)
	lwr	$10,12($3)
	swl	$7,3($16)
	swr	$7,0($16)
	swl	$8,7($16)
	swr	$8,4($16)
	swl	$9,11($16)
	swr	$9,8($16)
	swl	$10,15($16)
	swr	$10,12($16)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L706
	addu	$16,$16,16
	.set	macro
	.set	reorder

	j	$L701
$L704:
	addu	$2,$sp,144
$L707:
	lw	$7,0($3)
	lw	$8,4($3)
	lw	$9,8($3)
	lw	$10,12($3)
	sw	$7,0($16)
	sw	$8,4($16)
	sw	$9,8($16)
	sw	$10,12($16)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L707
	addu	$16,$16,16
	.set	macro
	.set	reorder

$L701:
	lw	$3,Replay_ReplayMode
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L708
	lui	$4,%hi(controlData) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(controlData) # low
	sll	$5,$17,$2
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	sll	$3,$17,7
	addu	$2,$2,$3
	addu	$2,$2,$4
	lb	$2,0($2)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L709
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$3,648($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L710
	sw	$2,24($3)
	.set	macro
	.set	reorder

$L709:
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,24($2)
$L710:
	lui	$4,%hi(controlData) # high
	addiu	$4,$4,%lo(controlData) # low
	sll	$5,$17,2
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	sll	$3,$17,7
	addu	$2,$2,$3
	addu	$2,$2,$4
	lbu	$2,32($2)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$3,648($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L712
	sw	$2,28($3)
	.set	macro
	.set	reorder

$L711:
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,28($2)
$L712:
	lui	$4,%hi(controlData) # high
	addiu	$4,$4,%lo(controlData) # low
	sll	$5,$17,2
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	sll	$3,$17,7
	addu	$2,$2,$3
	addu	$2,$2,$4
	lbu	$2,64($2)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$3,648($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L714
	sw	$2,32($3)
	.set	macro
	.set	reorder

$L713:
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,32($2)
$L714:
	lui	$5,%hi(controlData) # high
	addiu	$5,$5,%lo(controlData) # low
	sll	$4,$17,2
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$4,$4,$2
	lw	$3,0($4)
	sll	$6,$17,7
	addu	$3,$3,$6
	addu	$3,$3,$5
	lbu	$2,0($3)
	#nop
	andi	$2,$2,0x007f
	sb	$2,0($3)
	lw	$3,0($4)
	#nop
	addu	$3,$3,$6
	addu	$3,$3,$5
	lbu	$2,32($3)
	#nop
	andi	$2,$2,0x007f
	sb	$2,32($3)
	lw	$3,0($4)
	#nop
	addu	$3,$3,$6
	addu	$3,$3,$5
	lbu	$2,64($3)
	#nop
	andi	$2,$2,0x007f
	sb	$2,64($3)
	lw	$2,0($4)
	#nop
	addu	$2,$2,$6
	addu	$2,$2,$5
	lb	$2,0($2)
	#nop
	addu	$2,$2,-64
	sll	$2,$2,2
	sb	$2,Input_gSim
	lw	$2,0($4)
	#nop
	addu	$2,$2,$6
	addu	$2,$2,$5
	lbu	$2,32($2)
	#nop
	sll	$2,$2,3
	sb	$2,Input_gSim+1
	lw	$2,0($4)
	#nop
	addu	$2,$2,$6
	addu	$2,$2,$5
	lbu	$2,64($2)
	#nop
	sll	$2,$2,3
	sb	$2,Input_gSim+2
	lw	$2,0($4)
	#nop
	addu	$2,$2,$6
	addu	$2,$2,$5
	lbu	$2,96($2)
	#nop
	sb	$2,Input_gSim+3
	.set	noreorder
	.set	nomacro
	j	$L719
	sll	$5,$17,2
	.set	macro
	.set	reorder

$L708:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L719
	sll	$5,$17,2
	.set	macro
	.set	reorder

	sb	$0,Input_gSim
	sb	$0,Input_gSim+1
	sb	$0,Input_gSim+2
	sb	$0,Input_gSim+3
$L719:
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$2,$5,$2
	lw	$3,0($2)
	lw	$4,numValidCams
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L717
	sw	$3,0($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(Replay_ReplayCamera) # high
	addiu	$3,$3,%lo(Replay_ReplayCamera) # low
	sll	$2,$17,4
	addu	$2,$2,$3
	lw	$3,8($2)
	li	$2,19			# 0x00000013
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L720
	sll	$3,$17,2
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	lw	$2,%lo(simGlobal)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$5,$2
	lw	$2,0($2)
	#nop
	lh	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	Replay_ReplayChooseCamera__Fii
	move	$4,$17
	.set	macro
	.set	reorder

$L717:
	sll	$3,$17,2
$L720:
	lui	$2,%hi(Replay_ReplayCounter) # high
	addiu	$2,$2,%lo(Replay_ReplayCounter) # low
	addu	$4,$3,$2
	lw	$3,0($4)
	li	$2,32			# 0x00000020
	bne	$3,$2,$L700
	sw	$0,0($4)
$L700:
	lw	$31,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	Replay_GetInput__Fi
	.text
	.ent	Replay_SaveReplay__Fv
Replay_SaveReplay__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayMode
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L724
	lui	$2,%hi(Replay_ReplayBuffer) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	sw	$2,Replay_Size
	lui	$2,%hi(Replay_ReplayBuffer) # high
$L724:
	addiu	$3,$2,%lo(Replay_ReplayBuffer) # low
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$4,$2,2592
$L723:
	lw	$5,0($2)
	lw	$6,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$5,0($3)
	sw	$6,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L723
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$5,0($2)
	lw	$6,4($2)
	sw	$5,0($3)
	sw	$6,4($3)
	lui	$2,%hi(Replay_ReplayBuffer) # high
	addiu	$2,$2,%lo(Replay_ReplayBuffer) # low
	lw	$4,Replay_Size
	li	$3,2			# 0x00000002
	sw	$3,36($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,2600($2)
	.set	macro
	.set	reorder

	.end	Replay_SaveReplay__Fv
	.text
	.ent	Replay_LoadReplay__Fv
Replay_LoadReplay__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Replay_LoadReplay__Fv
	.text
	.ent	Replay_DoReplay__FP8Car_tObj
Replay_DoReplay__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayMode
	subu	$sp,$sp,24
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$4,600($4)
	jal	Replay_SaveInput__Fi
	j	$L726
$L727:
	lw	$4,600($4)
	jal	Replay_GetInput__Fi
$L726:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Replay_DoReplay__FP8Car_tObj
	.text
	.ent	Replay_GetInterfaceKey__Fv
Replay_GetInterfaceKey__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$2,%lo(GameSetup_gData+12)($2)
	subu	$sp,$sp,48
	sw	$20,32($sp)
	li	$20,1			# 0x00000001
	sw	$17,20($sp)
	move	$17,$20
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L730
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$20,2			# 0x00000002
$L730:
	lui	$2,%hi(Replay_ReplayInterface) # high
	addiu	$16,$2,%lo(Replay_ReplayInterface) # low
	lw	$2,20($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L731
	sw	$0,24($16)
	.set	macro
	.set	reorder

	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,20($16)
	.set	macro
	.set	reorder

$L731:
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L733
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	move	$16,$0
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L736
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$2,$0,$L735
$L736:
	li	$16,1			# 0x00000001
$L735:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L734
	lui	$2,%hi(Replay_ReplayInterface) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Replay_ReplayInterface) # low
	li	$3,24			# 0x00000018
	sw	$3,20($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$3,8($2)
	.set	macro
	.set	reorder

$L734:
	li	$4,25			# 0x00000019
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	lui	$2,%hi(simVar+16) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	lui	$2,%hi(Replay_ReplayInterface+28) # high
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$0,%lo(Replay_ReplayInterface+28)($2)
	.set	macro
	.set	reorder

$L733:
	li	$4,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L741
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,16($16)
	.set	macro
	.set	reorder

$L741:
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,16($16)
	.set	macro
	.set	reorder

$L740:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L744
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$2,1717960704			# 0x66660000
	lw	$4,16($16)
	ori	$2,$2,0x6667
	addu	$4,$4,1
	mult	$4,$2
	sra	$2,$4,31
	mfhi	$7
	#nop
	#nop
	sra	$3,$7,1
	subu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$4,16($16)
	.set	macro
	.set	reorder

$L744:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L746
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$3,16($16)
	li	$2,8			# 0x00000008
	sw	$2,20($16)
	sltu	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
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
	.word	$L748
	.word	$L749
	.word	$L750
	.word	$L751
	.word	$L755
	.text
$L748:
	lui	$2,%hi(Replay_ReplayInterface+8) # high
	li	$3,1			# 0x00000001
	sw	$3,%lo(Replay_ReplayInterface+8)($2)
	lui	$2,%hi(GameSetup_gData+40) # high
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$3,%lo(GameSetup_gData+40)($2)
	.set	macro
	.set	reorder

$L749:
	lui	$3,%hi(Replay_ReplayInterface+8) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,%lo(Replay_ReplayInterface+8)($3)
	.set	macro
	.set	reorder

$L750:
	lui	$3,%hi(Replay_ReplayInterface) # high
	lw	$2,%lo(Replay_ReplayInterface)($3)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,%lo(Replay_ReplayInterface)($3)
	.set	macro
	.set	reorder

$L751:
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L752
	lui	$2,%hi(Replay_ReplayInterface) # high
	.set	macro
	.set	reorder

	li	$2,1431633920			# 0x55550000
	lui	$5,%hi(Replay_ReplayInterface) # high
	addiu	$5,$5,%lo(Replay_ReplayInterface) # low
	lw	$4,4($5)
	ori	$2,$2,0x5556
	addu	$4,$4,1
	mult	$4,$2
	sra	$3,$4,31
	mfhi	$7
	#nop
	#nop
	subu	$3,$7,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$4,4($5)
	.set	macro
	.set	reorder

$L752:
	addiu	$5,$2,%lo(Replay_ReplayInterface) # low
	lw	$4,4($5)
	#nop
	addu	$3,$4,1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L754
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$4,4
$L754:
	sra	$2,$2,2
	sll	$2,$2,2
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$2,4($5)
	.set	macro
	.set	reorder

$L755:
	li	$3,954400768			# 0x38e30000
	lui	$2,%hi(Replay_ReplayInterface) # high
	addiu	$5,$2,%lo(Replay_ReplayInterface) # low
	lw	$4,12($5)
	ori	$3,$3,0x8e39
	addu	$4,$4,1
	mult	$4,$3
	li	$2,1			# 0x00000001
	sw	$2,24($5)
	mfhi	$7
	#nop
	#nop
	sra	$3,$7,$2
	sra	$2,$4,31
	subu	$3,$3,$2
	sll	$2,$3,3
	addu	$2,$2,$3
	subu	$4,$4,$2
	lui	$2,%hi(ReplayCameraList) # high
	addiu	$6,$2,%lo(ReplayCameraList) # low
	sw	$4,12($5)
	sll	$4,$4,2
	addu	$4,$4,$6
	lw	$3,0($4)
	li	$2,19			# 0x00000013
	bne	$3,$2,$L756
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L732
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Replay_ReplayCamera) # high
	addiu	$19,$2,%lo(Replay_ReplayCamera) # low
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gHumanRaceCarList) # low
	lui	$2,%hi(Camera_gInfo) # high
	addiu	$18,$2,%lo(Camera_gInfo) # low
$L760:
	lw	$2,numValidCams
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	sw	$2,0($18)
	lw	$2,0($17)
	#nop
	sw	$2,4($18)
	lw	$2,0($17)
	#nop
	lh	$5,8($2)
	.set	noreorder
	.set	nomacro
	jal	Replay_ReplayFindClosestCamera__Fii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,19			# 0x00000013
	.set	noreorder
	.set	nomacro
	j	$L759
	sw	$2,8($19)
	.set	macro
	.set	reorder

$L761:
	.set	noreorder
	.set	nomacro
	jal	Camera_SetMode__Fii
	li	$5,10			# 0x0000000a
	.set	macro
	.set	reorder

$L759:
	addu	$19,$19,16
	addu	$17,$17,4
	addu	$16,$16,1
	slt	$2,$16,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
	addu	$18,$18,272
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L778
	lui	$2,%hi(simVar+16) # high
	.set	macro
	.set	reorder

$L756:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L732
	move	$16,$0
	.set	macro
	.set	reorder

	move	$22,$6
	move	$21,$5
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$19,$2,%lo(Cars_gHumanRaceCarList) # low
	lui	$2,%hi(Camera_gInfo) # high
	addiu	$17,$2,%lo(Camera_gInfo) # low
	lui	$2,%hi(Replay_ReplayCamera) # high
	addiu	$18,$2,%lo(Replay_ReplayCamera) # low
$L768:
	sw	$0,0($18)
	sw	$0,84($17)
	lw	$2,0($19)
	#nop
	sw	$2,0($17)
	lw	$2,0($19)
	#nop
	sw	$2,4($17)
	lw	$2,12($21)
	move	$4,$16
	sll	$2,$2,2
	addu	$2,$2,$22
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Camera_SetMode__Fii
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lw	$2,12($21)
	addu	$19,$19,4
	sll	$2,$2,2
	addu	$2,$2,$22
	lw	$2,0($2)
	addu	$17,$17,272
	sw	$2,8($18)
	slt	$2,$16,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L768
	addu	$18,$18,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L778
	lui	$2,%hi(simVar+16) # high
	.set	macro
	.set	reorder

$L746:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L773
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	sw	$2,20($16)
	.set	noreorder
	.set	nomacro
	j	$L732
	sw	$17,8($16)
	.set	macro
	.set	reorder

$L773:
	li	$4,25			# 0x00000019
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	sw	$0,StatsTimer
	sw	$0,D_8013D99C
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	sw	$17,28($16)
	.set	macro
	.set	reorder

$L732:
	lui	$2,%hi(simVar+16) # high
$L778:
	lw	$2,%lo(simVar+16)($2)
	#nop
	beq	$2,$0,$L729
	jal	Camera_Update__Fv
$L729:
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

	.end	Replay_GetInterfaceKey__Fv
	.text
	.ent	Replay_LoadCameraFile__Fv
Replay_LoadCameraFile__Fv:
	.frame	$sp,144,$31		# vars= 120, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,numValidCams
	subu	$sp,$sp,144
	sw	$31,140($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L779
	sw	$16,136($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+32) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+32)($2)
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$0,128($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	li	$5,16			# 0x00000010
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_addbigsync
	addu	$7,$sp,128
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,48($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$6,60($3)
	lui	$5,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$L821
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

$L781:
	lw	$6,60($3)
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
$L821:
	jal	sprintf
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	li	$5,100			# 0x00000064
	lw	$4,128($sp)
	sw	$0,numValidCams
	.set	noreorder
	.set	nomacro
	jal	FILE_delbigsync
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$0
	li	$7,2			# 0x00000002
	li	$6,-1537			# 0xfffff9ff
	li	$5,-1			# 0xffffffff
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$3,$2,%lo(gReplayCameraSlots) # low
$L786:
	sb	$7,0($3)
	lw	$2,0($3)
	addu	$4,$4,1
	sh	$5,30($3)
	and	$2,$2,$6
	sw	$2,0($3)
	slt	$2,$4,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L786
	addu	$3,$3,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L779
	lui	$2,%hi(gReplayCameraSlots) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(gReplayCameraSlots) # low
	move	$3,$16
	addu	$4,$16,1024
$L789:
	lw	$11,0($3)
	lw	$12,4($3)
	lw	$13,8($3)
	lw	$14,12($3)
	sw	$11,0($2)
	sw	$12,4($2)
	sw	$13,8($2)
	sw	$14,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L789
	addu	$2,$2,16
	.set	macro
	.set	reorder

	move	$7,$0
	li	$4,-1			# 0xffffffff
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$3,$2,%lo(gReplayCameraSlots) # low
$L793:
	lh	$2,2($3)
	#nop
	beq	$2,$0,$L794
	lw	$2,numValidCams
	#nop
	addu	$2,$2,1
	sw	$2,numValidCams
	.set	noreorder
	.set	nomacro
	j	$L822
	addu	$3,$3,32
	.set	macro
	.set	reorder

$L794:
	sh	$4,30($3)
	addu	$3,$3,32
$L822:
	addu	$7,$7,1
	slt	$2,$7,32
	bne	$2,$0,$L793
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	move	$9,$0
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$10,$2,%lo(gReplayCameraSlots) # low
$L797:
	slt	$2,$9,31
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	move	$7,$0
	.set	macro
	.set	reorder

	move	$5,$10
	li	$8,32			# 0x00000020
$L801:
	slt	$2,$7,31
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L799
	addu	$6,$8,$10
	.set	macro
	.set	reorder

	lh	$3,30($5)
	lh	$4,30($6)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L806
	bgez	$3,$L803
$L806:
	bltz	$4,$L803
	lw	$11,0($5)
	lw	$12,4($5)
	lw	$13,8($5)
	lw	$14,12($5)
	sw	$11,96($sp)
	sw	$12,100($sp)
	sw	$13,104($sp)
	sw	$14,108($sp)
	lw	$11,16($5)
	lw	$12,20($5)
	lw	$13,24($5)
	lw	$14,28($5)
	sw	$11,112($sp)
	sw	$12,116($sp)
	sw	$13,120($sp)
	sw	$14,124($sp)
	lw	$11,0($6)
	lw	$12,4($6)
	lw	$13,8($6)
	lw	$14,12($6)
	sw	$11,0($5)
	sw	$12,4($5)
	sw	$13,8($5)
	sw	$14,12($5)
	lw	$11,16($6)
	lw	$12,20($6)
	lw	$13,24($6)
	lw	$14,28($6)
	sw	$11,16($5)
	sw	$12,20($5)
	sw	$13,24($5)
	sw	$14,28($5)
	lw	$11,96($sp)
	lw	$12,100($sp)
	lw	$13,104($sp)
	lw	$14,108($sp)
	sw	$11,0($6)
	sw	$12,4($6)
	sw	$13,8($6)
	sw	$14,12($6)
	lw	$11,112($sp)
	lw	$12,116($sp)
	lw	$13,120($sp)
	lw	$14,124($sp)
	sw	$11,16($6)
	sw	$12,20($6)
	sw	$13,24($6)
	sw	$14,28($6)
$L803:
	addu	$5,$5,32
	addu	$8,$8,32
	.set	noreorder
	.set	nomacro
	j	$L801
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L799:
	.set	noreorder
	.set	nomacro
	j	$L797
	addu	$9,$9,1
	.set	macro
	.set	reorder

$L798:
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	beq	$2,$0,$L807
	lw	$2,numValidCams
	#nop
	addu	$2,$2,-1
	move	$7,$2
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$4,$2,%lo(gReplayCameraSlots) # low
	sll	$2,$7,5
	addu	$3,$2,$4
	lh	$6,30($3)
	.set	noreorder
	.set	nomacro
	bltz	$7,$L807
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$4,$2,-32
$L811:
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L812
	addu	$2,$4,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L810
	sh	$6,30($5)
	.set	macro
	.set	reorder

$L812:
	lhu	$2,30($2)
	#nop
	sh	$2,30($3)
$L810:
	addu	$4,$4,-32
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bgez	$7,$L811
	addu	$3,$3,-32
	.set	macro
	.set	reorder

$L807:
	lw	$5,numValidCams
	#nop
	.set	noreorder
	.set	nomacro
	blez	$5,$L779
	move	$7,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$4,$2,%lo(gReplayCameraSlots) # low
$L818:
	addu	$7,$7,1
	lw	$2,4($4)
	lw	$3,12($4)
	sll	$2,$2,6
	sw	$2,4($4)
	lw	$2,8($4)
	sll	$3,$3,6
	sw	$3,12($4)
	sll	$2,$2,6
	sw	$2,8($4)
	slt	$2,$7,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L818
	addu	$4,$4,32
	.set	macro
	.set	reorder

$L779:
	lw	$31,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	Replay_LoadCameraFile__Fv
	.text
	.ent	Replay_ReplayChooseCamera__Fii
Replay_ReplayChooseCamera__Fii:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$10,$4
	lui	$3,%hi(Replay_ReplayCamera) # high
	addiu	$3,$3,%lo(Replay_ReplayCamera) # low
	sll	$2,$10,4
	addu	$2,$2,$3
	sw	$31,16($sp)
	lw	$9,12($2)
	#nop
	addu	$7,$9,-1
	bgez	$7,$L824
	lw	$2,numValidCams
	#nop
	addu	$7,$2,-1
$L824:
	lw	$2,numValidCams
	addu	$3,$9,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L825
	move	$8,$0
	.set	macro
	.set	reorder

	move	$8,$3
$L825:
	lui	$4,%hi(gReplayCameraSlots) # high
	addiu	$4,$4,%lo(gReplayCameraSlots) # low
	sll	$2,$9,5
	addu	$2,$2,$4
	sll	$3,$8,5
	addu	$3,$3,$4
	lh	$6,30($2)
	lh	$3,30($3)
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L826
	subu	$2,$5,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L828
	slt	$2,$2,200
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L829
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	j	$L842
$L828:
	subu	$2,$6,$5
	slt	$2,$2,200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	slt	$2,$5,$3
	.set	macro
	.set	reorder

$L829:
	lui	$3,%hi(Replay_ReplayCamera) # high
	addiu	$3,$3,%lo(Replay_ReplayCamera) # low
	sll	$2,$10,4
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L830
	sw	$7,12($2)
	.set	macro
	.set	reorder

$L826:
	slt	$2,$5,$3
$L842:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L843
	lui	$2,%hi(Replay_ReplayCamera) # high
	.set	macro
	.set	reorder

	subu	$2,$5,$3
	.set	noreorder
	.set	nomacro
	blez	$2,$L833
	slt	$2,$2,200
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L844
	lui	$3,%hi(Replay_ReplayCamera) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L843
	lui	$2,%hi(Replay_ReplayCamera) # high
	.set	macro
	.set	reorder

$L833:
	subu	$2,$3,$5
	slt	$2,$2,200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L830
	lui	$3,%hi(Replay_ReplayCamera) # high
	.set	macro
	.set	reorder

$L844:
	addiu	$3,$3,%lo(Replay_ReplayCamera) # low
	sll	$2,$10,4
	addu	$2,$2,$3
	sw	$8,12($2)
$L830:
	lui	$2,%hi(Replay_ReplayCamera) # high
$L843:
	addiu	$2,$2,%lo(Replay_ReplayCamera) # low
	sll	$3,$10,4
	addu	$3,$3,$2
	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$9,$L823
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L839
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L845
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

$L839:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L837
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L845
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L846
	lui	$3,%hi(gReplayCameraSlots) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gHumanRaceCarList) # high
$L845:
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	sll	$2,$10,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$2,1008($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L847
	move	$4,$10
	.set	macro
	.set	reorder

$L837:
	lui	$3,%hi(gReplayCameraSlots) # high
$L846:
	lui	$2,%hi(Replay_ReplayCamera) # high
	addiu	$2,$2,%lo(Replay_ReplayCamera) # low
	sll	$6,$10,4
	addu	$5,$6,$2
	lw	$2,12($5)
	addiu	$7,$3,%lo(gReplayCameraSlots) # low
	sll	$2,$2,5
	addu	$2,$2,$7
	lbu	$3,0($2)
	li	$2,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L836
	move	$4,$10
	.set	macro
	.set	reorder

	li	$4,-100728832			# 0xf9ff0000
	ori	$4,$4,0xffff
	lui	$3,%hi(Camera_gInfo) # high
	addiu	$3,$3,%lo(Camera_gInfo) # low
	addu	$6,$6,$10
	sll	$6,$6,4
	lw	$2,12($5)
	addu	$6,$6,$3
	sw	$0,0($5)
	lw	$3,116($6)
	sll	$2,$2,5
	addu	$2,$2,$7
	lw	$2,0($2)
	and	$3,$3,$4
	srl	$2,$2,9
	andi	$2,$2,0x0003
	sll	$2,$2,25
	or	$3,$3,$2
	sw	$3,116($6)
	lw	$2,12($5)
	move	$4,$10
	sll	$2,$2,5
	addu	$2,$2,$7
	lw	$2,0($2)
	li	$5,11			# 0x0000000b
	srl	$2,$2,$5
	andi	$2,$2,0x0007
	.set	noreorder
	.set	nomacro
	jal	Camera_SetMode__Fii
	sb	$2,126($6)
	.set	macro
	.set	reorder

	j	$L823
$L836:
$L847:
	lui	$2,%hi(Replay_ReplayCamera) # high
	addiu	$2,$2,%lo(Replay_ReplayCamera) # low
	sll	$3,$4,4
	addu	$3,$3,$2
	li	$2,1			# 0x00000001
	lui	$5,%hi(gReplayCameraSlots) # high
	lw	$6,12($3)
	addiu	$5,$5,%lo(gReplayCameraSlots) # low
	sw	$2,0($3)
	sll	$6,$6,5
	.set	noreorder
	.set	nomacro
	jal	Camera_ReplayUpdate__FiP15Camera_tCamSlot
	addu	$5,$6,$5
	.set	macro
	.set	reorder

$L823:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Replay_ReplayChooseCamera__Fii
	.text
	.ent	Replay_ReplayFindClosestCamera__Fii
Replay_ReplayFindClosestCamera__Fii:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$24,$4
	move	$15,$0
	move	$14,$15
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$7,$2,%lo(gReplayCameraSlots) # low
	move	$10,$7
	lw	$8,gNumSlices
	lw	$13,numValidCams
	li	$6,1			# 0x00000001
	sw	$31,16($sp)
	srl	$2,$8,31
	addu	$2,$8,$2
	sra	$9,$2,$6
$L849:
	slt	$2,$14,$13
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L919
	lui	$2,%hi(Replay_ReplayCamera) # high
	.set	macro
	.set	reorder

	lh	$2,30($10)
	#nop
	subu	$3,$5,$2
	slt	$2,$9,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L855
	subu	$2,$8,$3
	.set	macro
	.set	reorder

	blez	$3,$L853
	j	$L856
$L855:
	blez	$2,$L853
$L856:
	lh	$2,30($10)
	#nop
	subu	$2,$5,$2
	move	$12,$2
	slt	$2,$9,$12
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L920
	slt	$3,$6,$13
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L920
	subu	$12,$8,$12
	.set	macro
	.set	reorder

$L853:
	lh	$4,30($10)
	#nop
	subu	$3,$5,$4
	slt	$2,$9,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L859
	subu	$12,$3,$8
	.set	macro
	.set	reorder

	subu	$12,$4,$5
$L859:
	slt	$3,$6,$13
$L920:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L865
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L865:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	slt	$2,$9,$2
	beq	$2,$0,$L863
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L867
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L867:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	subu	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L921
	slt	$3,$6,$13
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L924
	move	$2,$0
	.set	macro
	.set	reorder

$L863:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L869
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L869:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	blez	$2,$L861
	slt	$3,$6,$13
	.set	macro
	.set	reorder

$L921:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L873
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L873:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	slt	$2,$9,$2
	beq	$2,$0,$L871
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L875
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L875:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L862
	subu	$11,$8,$2
	.set	macro
	.set	reorder

$L871:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L877
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L877:
	addu	$2,$7,$2
	lh	$2,30($2)
	.set	noreorder
	.set	nomacro
	j	$L862
	subu	$11,$5,$2
	.set	macro
	.set	reorder

$L861:
	move	$2,$0
$L924:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L922
	addu	$2,$7,$2
	.set	macro
	.set	reorder

	sll	$2,$6,5
	addu	$2,$7,$2
$L922:
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	slt	$2,$9,$2
	beq	$2,$0,$L879
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L883
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L883:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L862
	subu	$11,$2,$8
	.set	macro
	.set	reorder

$L879:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L885
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L885:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$11,$2,$5
$L862:
	lh	$4,30($10)
	slt	$3,$6,$13
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L891
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L891:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	slt	$2,$9,$2
	beq	$2,$0,$L889
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L893
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L893:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	subu	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L890
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L918
$L889:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L895
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L895:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$2,$L887
	move	$2,$0
	.set	macro
	.set	reorder

$L890:
	lh	$4,30($10)
	slt	$3,$6,$13
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L899
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L899:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	slt	$2,$9,$2
	beq	$2,$0,$L897
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L901
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L901:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L888
	subu	$3,$8,$2
	.set	macro
	.set	reorder

$L897:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L903
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L903:
	addu	$2,$7,$2
	lh	$2,30($2)
	.set	noreorder
	.set	nomacro
	j	$L888
	subu	$3,$4,$2
	.set	macro
	.set	reorder

$L887:
$L918:
	lh	$4,30($10)
	slt	$3,$6,$13
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L923
	addu	$2,$7,$2
	.set	macro
	.set	reorder

	sll	$2,$6,5
	addu	$2,$7,$2
$L923:
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	slt	$2,$9,$2
	beq	$2,$0,$L905
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L909
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L909:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L888
	subu	$3,$2,$8
	.set	macro
	.set	reorder

$L905:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L911
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$6,5
$L911:
	addu	$2,$7,$2
	lh	$2,30($2)
	#nop
	subu	$3,$2,$4
$L888:
	addu	$2,$12,$11
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L851
	addu	$10,$10,32
	.set	macro
	.set	reorder

	addu	$6,$6,1
	.set	noreorder
	.set	nomacro
	j	$L849
	addu	$14,$14,1
	.set	macro
	.set	reorder

$L851:
	move	$15,$14
	lui	$2,%hi(Replay_ReplayCamera) # high
$L919:
	addiu	$2,$2,%lo(Replay_ReplayCamera) # low
	sll	$6,$24,4
	addu	$7,$6,$2
	lui	$2,%hi(gReplayCameraSlots) # high
	addiu	$8,$2,%lo(gReplayCameraSlots) # low
	sll	$2,$15,5
	addu	$2,$2,$8
	sw	$15,12($7)
	lbu	$3,0($2)
	li	$2,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L914
	move	$4,$24
	.set	macro
	.set	reorder

	li	$4,-100728832			# 0xf9ff0000
	ori	$4,$4,0xffff
	lui	$3,%hi(Camera_gInfo) # high
	addiu	$3,$3,%lo(Camera_gInfo) # low
	addu	$6,$6,$24
	sll	$6,$6,4
	move	$2,$15
	addu	$6,$6,$3
	sll	$2,$2,5
	addu	$2,$2,$8
	sw	$0,0($7)
	lw	$3,116($6)
	lw	$2,0($2)
	and	$3,$3,$4
	srl	$2,$2,9
	andi	$2,$2,0x0003
	sll	$2,$2,25
	or	$3,$3,$2
	sw	$3,116($6)
	lw	$2,12($7)
	li	$5,11			# 0x0000000b
	sll	$2,$2,5
	addu	$2,$2,$8
	lw	$2,0($2)
	move	$4,$24
	srl	$2,$2,$5
	andi	$2,$2,0x0007
	.set	noreorder
	.set	nomacro
	jal	Camera_SetMode__Fii
	sb	$2,126($6)
	.set	macro
	.set	reorder

	j	$L848
$L914:
	lw	$5,12($7)
	li	$2,1			# 0x00000001
	sw	$2,0($7)
	sll	$5,$5,5
	.set	noreorder
	.set	nomacro
	jal	Camera_ReplayUpdate__FiP15Camera_tCamSlot
	addu	$5,$5,$8
	.set	macro
	.set	reorder

$L848:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Replay_ReplayFindClosestCamera__Fii
