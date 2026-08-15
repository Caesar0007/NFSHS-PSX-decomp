	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\ailife.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AILife_EvaluateLife__FP8Car_tObj
	.align	2
	.globl	AILife_RCSetSpeeds__FP8Car_tObj
	.rdata
	.align	2
$LC0:
	.ascii	" psad checked group, basis now %d(s=%d) new slice=%d\n\000"
	.text
	.align	2
	.globl	AILife_RCPickSliceAndDirection__FP8Car_tObj
	.align	2
	.globl	AILife_RCPickDesiredLatPosition__FP8Car_tObj
	.align	2
	.globl	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	.align	2
	.globl	AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
	.align	2
	.globl	AILife_PlaceCarAtLocation__FP8Car_tObji
	.align	2
	.globl	AILife_ReencarnateTraffic__FP8Car_tObj
	.align	2
	.globl	AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	.align	2
	.globl	AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
	.align	2
	.globl	AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	.align	2
	.globl	AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
	.rdata
	.align	2
$LC1:
	.ascii	"dist=%d\000"
	.text
	.align	2
	.globl	AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
	.align	2
	.globl	AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
	.align	2
	.globl	AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
	.align	2
	.globl	AILife_IsCarInAnyVisibleArea__FP8Car_tObj
	.align	2
	.globl	AILife_IsSliceInAnyVisibleArea__Fi
	.align	2
	.globl	AILife_IsSliceCloseToAnyCopCar__Fi
	.align	2
	.globl	AILife_IsPositionInAnyVisibleArea__FP8coorddef
	.align	2
	.globl	AILife_Debug__FPce

	.extern	Cars_gNumCopCars, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	gWSavePtr, 4
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	AITune_driveSide, 4
	.extern	GameSetup_gData, 2600
	.extern	AITune_oneWay, 4
	.extern	BWorldSm_slices, 4
	.extern	gNumSlices, 4
	.extern	Cars_gNumCars, 4
	.extern	Cars_gNumLifeBasisCars, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4

	.text
	.text
	.ent	AILife_EvaluateLife__FP8Car_tObj
AILife_EvaluateLife__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0400
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L603
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$5,1400($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
	addu	$4,$16,160
	.set	macro
	.set	reorder

	bne	$2,$0,$L601
	.set	noreorder
	.set	nomacro
	jal	AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$3,$2
	sw	$3,1400($16)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L603
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L601:
	move	$2,$0
$L603:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AILife_EvaluateLife__FP8Car_tObj
	.text
	.ent	AILife_RCSetSpeeds__FP8Car_tObj
AILife_RCSetSpeeds__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$2,1372($16)
	#nop
	sw	$2,1380($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AILife_RCSetSpeeds__FP8Car_tObj
	.text
	.ent	AILife_RCPickSliceAndDirection__FP8Car_tObj
AILife_RCPickSliceAndDirection__FP8Car_tObj:
	.frame	$sp,72,$31		# vars= 16, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$19,44($sp)
	move	$19,$4
	lw	$3,fastRandom
	lw	$4,randSeed
	#nop
	mult	$3,$4
	mflo	$3
	#nop
	#nop
	andi	$6,$3,0xffff
	mult	$6,$4
	li	$7,16711680			# 0x00ff0000
	lw	$5,Cars_gNumLifeBasisCars
	ori	$7,$7,0xff00
	sw	$21,52($sp)
	li	$21,1			# 0x00000001
	sw	$31,64($sp)
	mflo	$4
	#nop
	and	$2,$3,$7
	srl	$2,$2,8
	mult	$5,$2
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	sw	$3,randtemp
	sw	$6,fastRandom
	lui	$2,%hi(Cars_gLifeBasisCarList) # high
	addiu	$2,$2,%lo(Cars_gLifeBasisCarList) # low
	sw	$4,randtemp
	mflo	$12
	#nop
	#nop
	srl	$3,$12,16
	sll	$3,$3,2
	addu	$3,$3,$2
	andi	$2,$4,0xffff
	and	$4,$4,$7
	srl	$4,$4,8
	sw	$2,fastRandom
	sll	$2,$4,5
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$4
	sll	$2,$2,3
	srl	$2,$2,16
	lw	$3,0($3)
	slt	$2,$2,500
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	sw	$3,1400($19)
	.set	macro
	.set	reorder

	li	$21,-1			# 0xffffffff
$L606:
	#.set	volatile
	lw	$4,1400($19)
	#.set	novolatile
	#nop
	lw	$3,1380($4)
	li	$2,1966080			# 0x001e0000
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	beq	$2,$0,$L607
	lw	$21,1364($4)
$L607:
	lw	$22,604($4)
	move	$20,$0
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$23,$2,%lo(Cars_gSortedList) # low
	sll	$2,$21,3
	addu	$2,$2,$21
	sll	$18,$2,2
$L608:
	lw	$3,Cars_gNumCars
	#nop
	slt	$2,$20,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	addu	$2,$22,$3
	.set	macro
	.set	reorder

	rem	$3,$2,$3
	sll	$3,$3,2
	addu	$3,$3,$23
	lw	$16,0($3)
	#nop
	beq	$16,$19,$L610
	lw	$3,1400($19)
	#nop
	beq	$16,$3,$L610
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0100
	beq	$2,$0,$L610
	lh	$2,8($3)
	.set	noreorder
	.set	nomacro
	bltz	$18,$L613
	addu	$3,$2,$18
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L631
	move	$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L616
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L613:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L631
	move	$2,$3
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L616:
	move	$2,$3
$L631:
	move	$17,$0
	addu	$4,$sp,16
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,16($sp)
	sw	$9,20($sp)
	sw	$10,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
	move	$5,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L618
	lw	$5,1400($19)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$4,$16
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L632
	sra	$2,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$2,$3,16
$L632:
	mult	$21,$2
	mflo	$8
	#nop
	#nop
	blez	$8,$L618
	li	$17,1			# 0x00000001
$L618:
	beq	$17,$0,$L609
	sw	$16,1400($19)
$L610:
	addu	$22,$22,$21
	.set	noreorder
	.set	nomacro
	j	$L608
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L609:
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
	slt	$2,$2,500
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L630:
	sw	$2,1364($19)
	lw	$2,AITune_oneWay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L624:
	sw	$3,1364($19)
$L623:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	srl	$2,$3,21
	andi	$2,$2,0x0007
	addu	$2,$2,28
	mult	$2,$21
	lw	$2,1364($19)
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L626
	sw	$2,1360($19)
	.set	macro
	.set	reorder

	lw	$2,1400($19)
	#nop
	lhu	$2,8($2)
	lw	$3,gNumSlices
	addu	$6,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	move	$5,$6
	.set	macro
	.set	reorder

	lhu	$2,gNumSlices
	#nop
	subu	$5,$6,$2
$L628:
	.set	noreorder
	.set	nomacro
	j	$L627
	sh	$5,8($19)
	.set	macro
	.set	reorder

$L626:
	lw	$2,1400($19)
	#nop
	lhu	$2,8($2)
	#nop
	addu	$5,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$2,$L629
	move	$3,$5
	.set	macro
	.set	reorder

	lhu	$2,gNumSlices
	#nop
	addu	$3,$2,$5
$L629:
	sh	$3,8($19)
$L627:
	lui	$4,%hi($LC0) # high
	lw	$2,1400($19)
	lh	$7,8($19)
	lw	$5,596($2)
	lh	$6,8($2)
	.set	noreorder
	.set	nomacro
	jal	AILife_Debug__FPce
	addiu	$4,$4,%lo($LC0) # low
	.set	macro
	.set	reorder

	lw	$31,64($sp)
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

	.end	AILife_RCPickSliceAndDirection__FP8Car_tObj
	.text
	.ent	AILife_RCPickDesiredLatPosition__FP8Car_tObj
AILife_RCPickDesiredLatPosition__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$4
	lw	$3,1364($6)
	lw	$2,AITune_driveSide
	lh	$4,8($6)
	bne	$3,$2,$L634
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$3,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$3
	lbu	$5,31($4)
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	lbu	$3,29($4)
	andi	$2,$2,0xffff
	andi	$3,$3,0x000f
	mult	$3,$2
	sll	$5,$5,15
	mflo	$2
	#nop
	#nop
	srl	$2,$2,16
	addu	$3,$2,1
	mult	$5,$3
	srl	$2,$5,1
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	j	$L636
	subu	$2,$3,$2
	.set	macro
	.set	reorder

$L634:
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	lw	$3,BWorldSm_slices
	sll	$4,$4,5
	addu	$4,$4,$3
	lbu	$5,30($4)
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	lbu	$3,29($4)
	andi	$2,$2,0xffff
	srl	$3,$3,4
	mult	$3,$2
	sll	$5,$5,15
	mflo	$2
	#nop
	#nop
	srl	$2,$2,16
	addu	$3,$2,1
	subu	$2,$0,$5
	mult	$2,$3
	srl	$2,$5,1
	mflo	$3
	#nop
	#nop
	addu	$2,$3,$2
$L636:
	sw	$2,1368($6)
	#.set	volatile
	lw	$2,1368($6)
	#.set	novolatile
	lw	$3,1388($6)
	#nop
	addu	$2,$2,$3
	sw	$2,1368($6)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1816($6)
	.set	macro
	.set	reorder

	.end	AILife_RCPickDesiredLatPosition__FP8Car_tObj
	.text
	.ent	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
AILife_PlaceCarAtLocation__FP8Car_tObjiiiii:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$6,1368($4)
	lw	$2,40($sp)
	sw	$7,1364($4)
	sw	$7,1360($4)
	sh	$5,8($4)
	sw	$2,1380($4)
	lw	$5,44($sp)
	jal	AILife_PlaceCarAtLocation__FP8Car_tObji
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
	.text
	.ent	AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	addu	$4,$sp,16
	move	$5,$0
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$3,1368($4)
	li	$2,65536			# 0x00010000
	sw	$2,20($sp)
	sw	$3,16($sp)
	lh	$5,8($4)
	lw	$7,1364($4)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
	.text
	.ent	AILife_PlaceCarAtLocation__FP8Car_tObji
AILife_PlaceCarAtLocation__FP8Car_tObji:
	.frame	$sp,96,$31		# vars= 56, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$18,80($sp)
	move	$18,$4
	sw	$19,84($sp)
	move	$19,$5
	sw	$31,88($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	lw	$3,1368($18)
	lw	$5,1380($18)
	li	$2,1			# 0x00000001
	sb	$2,145($18)
	sw	$3,1816($18)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ResetCar__FP8Car_tObj
	sw	$5,1372($18)
	.set	macro
	.set	reorder

	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	beq	$2,$0,$L640
	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	j	$L641
$L640:
	.set	noreorder
	.set	nomacro
	jal	AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L641:
	lw	$2,1380($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$7,264($18)
	lw	$8,268($18)
	lw	$9,272($18)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	lw	$16,1380($18)
	lw	$5,16($sp)
	bgez	$16,$L643
	subu	$16,$0,$16
$L643:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L647
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L642:
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

$L647:
	lw	$7,16($sp)
	lw	$8,20($sp)
	lw	$9,24($sp)
	sw	$7,172($18)
	sw	$8,176($18)
	sw	$9,180($18)
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	addu	$17,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_ResetCar__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	addu	$17,$sp,32
$L648:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	xformy
	move	$5,$19
	.set	macro
	.set	reorder

	addu	$16,$18,240
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$2,$18,452
	addu	$3,$18,272
$L646:
	lw	$7,0($16)
	lw	$8,4($16)
	lw	$9,8($16)
	lw	$10,12($16)
	sw	$7,0($2)
	sw	$8,4($2)
	sw	$9,8($2)
	sw	$10,12($2)
	addu	$16,$16,16
	.set	noreorder
	.set	nomacro
	bne	$16,$3,$L646
	addu	$2,$2,16
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$7,0($16)
	.set	noreorder
	.set	nomacro
	jal	AIInit_ClearAICar__FP8Car_tObj
	sw	$7,0($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadPosition__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$18
	sw	$2,1816($18)
	sw	$2,1368($18)
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadSpan__FP8Car_tObj
	sw	$2,1396($18)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateLaneInfo__FP8Car_tObj
	sw	$2,620($4)
	.set	macro
	.set	reorder

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

	.end	AILife_PlaceCarAtLocation__FP8Car_tObji
	.text
	.ent	AILife_ReencarnateTraffic__FP8Car_tObj
AILife_ReencarnateTraffic__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	andi	$2,$2,0xffff
	sw	$3,fastRandom
	sll	$3,$2,1
	addu	$3,$3,$2
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	srl	$5,$3,16
	.set	macro
	.set	reorder

	jal	R3DCar_ChangeTrafficColor__FP8Car_tObji
$L650:
	.set	noreorder
	.set	nomacro
	jal	AI_ChooseNewLaneSlack__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AILife_RCPickSliceAndDirection__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AILife_RCPickDesiredLatPosition__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AILife_RCSetSpeeds__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObji
	move	$5,$0
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

	.end	AILife_ReencarnateTraffic__FP8Car_tObj
	.text
	.ent	AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef:
	.frame	$sp,80,$31		# vars= 32, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$16,48($sp)
	move	$16,$4
	sw	$20,64($sp)
	move	$20,$5
	sw	$19,60($sp)
	move	$19,$6
	sw	$21,68($sp)
	move	$21,$7
	addu	$4,$sp,16
	move	$5,$0
	sw	$18,56($sp)
	lw	$18,96($sp)
	li	$6,12			# 0x0000000c
	sw	$31,72($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$17,52($sp)
	.set	macro
	.set	reorder

	addu	$17,$sp,32
	move	$4,$17
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	andi	$2,$2,0xffff
	sw	$3,fastRandom
	sll	$3,$2,1
	addu	$3,$3,$2
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	srl	$5,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	R3DCar_ChangeTrafficColor__FP8Car_tObji
	move	$4,$16
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	jal	AI_ChooseNewLaneSlack__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$0,1400($16)
	sw	$19,1364($16)
	sw	$19,1360($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_RCSetSpeeds__FP8Car_tObj
	sh	$20,8($16)
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$5,8($16)
	lw	$7,1364($16)
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	sw	$0,1380($16)
	.set	macro
	.set	reorder

	addu	$3,$16,240
	move	$2,$18
	addu	$4,$18,32
	lw	$8,0($21)
	lw	$9,4($21)
	lw	$10,8($21)
	sw	$8,160($16)
	sw	$9,164($16)
	sw	$10,168($16)
$L653:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L653
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($3)
	addu	$3,$16,452
	move	$2,$18
	addu	$4,$2,32
$L654:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L654
	addu	$3,$3,16
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$8,0($2)
	sw	$8,0($3)
	lw	$8,16($sp)
	lw	$9,20($sp)
	lw	$10,24($sp)
	sw	$8,172($16)
	sw	$9,176($16)
	sw	$10,180($16)
	.set	noreorder
	.set	nomacro
	jal	AIInit_ClearAICar__FP8Car_tObj
	sw	$0,192($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadPosition__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,1816($16)
	sw	$2,1368($16)
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadSpan__FP8Car_tObj
	sw	$2,1396($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateLaneInfo__FP8Car_tObj
	sw	$2,620($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AILife_RCPickDesiredLatPosition__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	.text
	.ent	AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
AILife_ReencarnateCopBySlice__FP8Car_tObjiiii:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,AITune_oneWay
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	sh	$5,8($16)
	lw	$8,40($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L656
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
$L656:
	sw	$6,1364($16)
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L658
	sw	$6,1360($16)
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	bne	$7,$2,$L659
	lw	$3,BWorldSm_slices
	sll	$2,$5,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	li	$2,-131072			# 0xfffe0000
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	j	$L667
	subu	$2,$2,$9
	.set	macro
	.set	reorder

$L659:
	lw	$3,BWorldSm_slices
	sll	$2,$5,5
	addu	$2,$2,$3
	lbu	$3,31($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	andi	$2,$2,0x000f
	mult	$3,$2
	.set	noreorder
	.set	nomacro
	j	$L668
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

$L658:
	lw	$3,1364($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L663
	sll	$3,$5,5
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lbu	$2,29($3)
	#nop
	srl	$4,$2,4
	bne	$4,$0,$L662
$L663:
	lw	$2,BWorldSm_slices
	sll	$3,$5,5
	addu	$3,$3,$2
	lbu	$2,31($3)
	lbu	$3,29($3)
	sll	$2,$2,15
	andi	$3,$3,0x000f
	mult	$2,$3
	srl	$2,$2,1
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	j	$L667
	subu	$2,$9,$2
	.set	macro
	.set	reorder

$L662:
	lbu	$2,30($3)
	#nop
	sll	$2,$2,15
	subu	$3,$0,$2
	mult	$3,$4
	srl	$2,$2,1
$L668:
	mflo	$9
	#nop
	#nop
	addu	$2,$9,$2
$L667:
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L665
	sw	$2,1368($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AILife_RCSetSpeeds__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L669
	move	$4,$16
	.set	macro
	.set	reorder

$L665:
	sw	$0,1372($16)
	sw	$0,1380($16)
	move	$4,$16
$L669:
	lw	$2,1368($16)
	move	$5,$0
	sw	$2,1816($4)
	.set	noreorder
	.set	nomacro
	jal	AILife_PlaceCarAtLocation__FP8Car_tObji
	sw	$2,1396($4)
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

	.end	AILife_ReencarnateCopBySlice__FP8Car_tObjiiii
	.text
	.ent	AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef:
	.frame	$sp,72,$31		# vars= 32, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,52($sp)
	move	$17,$4
	sw	$16,48($sp)
	move	$16,$5
	sw	$18,56($sp)
	move	$18,$6
	sw	$20,64($sp)
	move	$20,$7
	addu	$4,$sp,16
	move	$5,$0
	sw	$19,60($sp)
	lw	$19,88($sp)
	sw	$31,68($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	lw	$2,AITune_oneWay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	sh	$16,8($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$18,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$18,1			# 0x00000001
$L671:
	move	$4,$17
	sw	$18,1364($17)
	sw	$18,1360($17)
	sw	$0,1372($17)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ResetCar__FP8Car_tObj
	sw	$0,1380($17)
	.set	macro
	.set	reorder

	move	$4,$17
	lh	$5,8($17)
	lw	$7,1364($17)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	addu	$3,$17,240
	move	$2,$19
	addu	$4,$19,32
	lw	$8,0($20)
	lw	$9,4($20)
	lw	$10,8($20)
	sw	$8,160($17)
	sw	$9,164($17)
	sw	$10,168($17)
$L673:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L673
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($3)
	addu	$3,$17,452
	move	$2,$19
	addu	$4,$2,32
$L674:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L674
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	sw	$8,0($3)
	lw	$8,16($sp)
	lw	$9,20($sp)
	lw	$10,24($sp)
	sw	$8,172($17)
	sw	$9,176($17)
	sw	$10,180($17)
	.set	noreorder
	.set	nomacro
	jal	AIInit_ClearAICar__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadPosition__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$2,1816($17)
	sw	$2,1368($17)
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadSpan__FP8Car_tObj
	sw	$2,1396($17)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateLaneInfo__FP8Car_tObj
	sw	$2,620($4)
	.set	macro
	.set	reorder

	lw	$31,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	.text
	.ent	AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii:
	.frame	$sp,112,$31		# vars= 72, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$18,96($sp)
	move	$18,$4
	sw	$16,88($sp)
	move	$16,$5
	sw	$17,92($sp)
	move	$17,$6
	sw	$19,100($sp)
	move	$19,$7
	addu	$4,$sp,16
	move	$5,$0
	sw	$31,104($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,145($18)
	lw	$2,AITune_oneWay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L676
	sh	$16,8($18)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L676
	li	$17,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L676:
	move	$4,$18
	sw	$17,1364($18)
	sw	$17,1360($18)
	sw	$0,1372($18)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ResetCar__FP8Car_tObj
	sw	$0,1380($18)
	.set	macro
	.set	reorder

	lw	$2,1364($18)
	#nop
	mult	$19,$2
	move	$4,$18
	mflo	$8
	#nop
	#nop
	sw	$8,32($sp)
	lh	$5,8($18)
	lw	$7,1364($18)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	addu	$17,$sp,48
	lw	$5,128($sp)
	.set	noreorder
	.set	nomacro
	jal	xformy
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$18,240
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$2,$18,452
	addu	$3,$18,272
$L678:
	lw	$9,0($16)
	lw	$10,4($16)
	lw	$11,8($16)
	lw	$8,12($16)
	sw	$9,0($2)
	sw	$10,4($2)
	sw	$11,8($2)
	sw	$8,12($2)
	addu	$16,$16,16
	.set	noreorder
	.set	nomacro
	bne	$16,$3,$L678
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$9,0($16)
	sw	$9,0($2)
	lw	$9,16($sp)
	lw	$10,20($sp)
	lw	$11,24($sp)
	sw	$9,172($18)
	sw	$10,176($18)
	sw	$11,180($18)
	.set	noreorder
	.set	nomacro
	jal	AIInit_ClearAICar__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadPosition__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$18
	sw	$2,1816($18)
	sw	$2,1368($18)
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadSpan__FP8Car_tObj
	sw	$2,1396($18)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateLaneInfo__FP8Car_tObj
	sw	$2,620($4)
	.set	macro
	.set	reorder

	lw	$31,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii
	.text
	.ent	AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,8($4)
	lw	$2,168($5)
	#nop
	subu	$6,$3,$2
	lw	$3,0($4)
	lw	$2,160($5)
	bgez	$6,1f
	subu	$6,$0,$6
1:
	subu	$3,$3,$2
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L680
	sra	$2,$6,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L681
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L680:
	sra	$2,$3,2
	addu	$3,$6,$2
$L681:
	li	$2,14155776			# 0x00d80000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L683
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L682:
	ori	$2,$2,0x8001
	mult	$3,$2
	lui	$4,%hi($LC1) # high
	sra	$2,$3,31
	addiu	$4,$4,%lo($LC1) # low
	mfhi	$7
	#nop
	#nop
	addu	$5,$7,$3
	sra	$5,$5,15
	.set	noreorder
	.set	nomacro
	jal	AILife_Debug__FPce
	subu	$5,$5,$2
	.set	macro
	.set	reorder

	move	$2,$0
$L683:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
	.text
	.ent	AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,Cars_gNumLifeBasisCars
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	addu	$18,$4,160
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L685
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gLifeBasisCarList) # high
	addiu	$16,$2,%lo(Cars_gLifeBasisCarList) # low
$L686:
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$2,0($16)
	j	$L691
$L689:
	lw	$2,Cars_gNumLifeBasisCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L686
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L685:
	move	$2,$0
$L691:
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

	.end	AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
	.text
	.ent	AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	lw	$2,168($5)
	#nop
	subu	$6,$3,$2
	lw	$3,0($4)
	lw	$2,160($5)
	bgez	$6,1f
	subu	$6,$0,$6
1:
	subu	$3,$3,$2
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$6,$3
	beq	$2,$0,$L693
	sra	$2,$6,2
	.set	noreorder
	.set	nomacro
	j	$L694
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L693:
	sra	$2,$3,2
	addu	$3,$6,$2
$L694:
	li	$2,11272192			# 0x00ac0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
	.text
	.ent	AILife_IsCarInAnyVisibleArea__FP8Car_tObj
AILife_IsCarInAnyVisibleArea__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsPositionInAnyVisibleArea__FP8coorddef
	addu	$4,$4,160
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

	.end	AILife_IsCarInAnyVisibleArea__FP8Car_tObj
	.text
	.ent	AILife_IsSliceInAnyVisibleArea__Fi
AILife_IsSliceInAnyVisibleArea__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gHumanRaceCarList) # low
	sw	$31,28($sp)
$L697:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lh	$4,8($2)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	li	$3,11206656			# 0x00ab0000
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L701
	lw	$2,0($16)
	j	$L703
$L701:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L697
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L699:
$L703:
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

	.end	AILife_IsSliceInAnyVisibleArea__Fi
	.text
	.ent	AILife_IsSliceCloseToAnyCopCar__Fi
AILife_IsSliceCloseToAnyCopCar__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Cars_gCopCarList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gCopCarList) # low
	sw	$31,28($sp)
$L705:
	lw	$2,Cars_gNumCopCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L707
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lh	$4,8($2)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	li	$3,3211264			# 0x00310000
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L709
	lw	$2,0($16)
	j	$L711
$L709:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L705
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L707:
$L711:
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

	.end	AILife_IsSliceCloseToAnyCopCar__Fi
	.text
	.ent	AILife_IsPositionInAnyVisibleArea__FP8coorddef
AILife_IsPositionInAnyVisibleArea__FP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,Cars_gNumHumanRaceCars
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L713
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$16,$2,%lo(Cars_gHumanRaceCarList) # low
$L714:
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L717
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$2,0($16)
	j	$L720
$L717:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L714
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L713:
	move	$2,$0
$L720:
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

	.end	AILife_IsPositionInAnyVisibleArea__FP8coorddef
	.text
	.ent	AILife_Debug__FPce
AILife_Debug__FPce:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,0($sp)
	sw	$5,4($sp)
	sw	$6,8($sp)
	sw	$7,12($sp)
	j	$31
	.end	AILife_Debug__FPce
