	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_traf.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CheckForCops__14AIHigh_TrafficPi
	.align	2
	.globl	CopCheck__14AIHigh_TrafficPi
	.align	2
	.globl	HighExecute__14AIHigh_Traffic
	.align	2
	.globl	__14AIHigh_TrafficP8Car_tObj
	.align	2
	.globl	CheckForNewTriggers__14AIHigh_Traffic
	.align	2
	.globl	___14AIHigh_Traffic
	.rdata
	.align	2
D_800551A4:
	.word	0
	.word	6553600
	.word	0

	.extern	gNumSlices, 4
	.extern	Cars_gNumCars, 4
	.extern	BWorldSm_slices, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	triggerManagerTraffic, 4
	.extern	Cars_gNumCopCars, 4

	.text
	.text
	.ent	CheckForCops__14AIHigh_TrafficPi
CheckForCops__14AIHigh_TrafficPi:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$19,28($sp)
	move	$19,$0
	li	$2,1310720000			# 0x4e200000
	sw	$18,24($sp)
	move	$18,$19
	sw	$31,40($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$2,0($20)
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$17,$2,%lo(Cars_gCopCarList) # low
$L600:
	lw	$2,Cars_gNumCopCars
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	move	$2,$19
	.set	macro
	.set	reorder

	lw	$16,0($17)
	#nop
	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0004
	bne	$2,$0,$L604
	lw	$4,0($21)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,0($20)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$2,$3
	beq	$3,$0,$L604
	move	$19,$16
	sw	$2,0($20)
$L604:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L600
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L601:
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

	.end	CheckForCops__14AIHigh_TrafficPi
	.text
	.ent	CopCheck__14AIHigh_TrafficPi
CopCheck__14AIHigh_TrafficPi:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$5
	sw	$31,32($sp)
	sw	$16,24($sp)
	sw	$0,0($17)
	lw	$2,Cars_gNumCopCars
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheckForCops__14AIHigh_TrafficPi
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L613
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,65536			# 0x00010000
	lw	$3,1380($4)
	ori	$2,$2,0xffff
	.set	noreorder
	bgez	$3,1f
	move	$5,$3
	subu	$5,$0,$5
1:
	.set	reorder
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	li	$2,4849664			# 0x004a0000
	lw	$3,16($sp)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	lui	$3,%hi(highLevelAIObjs) # high
	sw	$2,0($17)
	lw	$2,596($4)
	addiu	$3,$3,%lo(highLevelAIObjs) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$16,0($2)
	#nop
	lw	$2,88($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L611
	move	$16,$0
	.set	macro
	.set	reorder

$L609:
$L614:
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	li	$2,4849664			# 0x004a0000
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	move	$2,$16
	.set	macro
	.set	reorder

	lui	$3,%hi(highLevelAIObjs) # high
	lw	$2,596($4)
	addiu	$3,$3,%lo(highLevelAIObjs) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$16,0($2)
$L611:
	move	$2,$16
$L613:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	CopCheck__14AIHigh_TrafficPi
	.text
	.ent	HighExecute__14AIHigh_Traffic
HighExecute__14AIHigh_Traffic:
	.frame	$sp,216,$31		# vars= 168, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,216
	sw	$17,196($sp)
	move	$17,$4
	sw	$31,208($sp)
	sw	$19,204($sp)
	sw	$18,200($sp)
	sw	$16,192($sp)
	lw	$2,0($17)
	#nop
	sw	$0,616($2)
	lw	$2,0($17)
	#nop
	sw	$0,612($2)
	lw	$3,8($17)
	#nop
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	lui	$2,%hi($L706) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L706) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L706:
	.word	$L617
	.word	$L626
	.word	$L643
	.word	$L674
	.word	$L616
	.word	$L616
	.word	$L684
	.word	$L616
	.word	$L616
	.word	$L616
	.word	$L616
	.text
$L617:
	lui	$2,%hi(D_800551A4) # high
	addiu	$11,$2,%lo(D_800551A4)
	lw	$8,0($11)
	lw	$9,4($11)
	lw	$10,8($11)
	sw	$8,24($sp)
	sw	$9,28($sp)
	sw	$10,32($sp)
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0400
	beq	$2,$0,$L618
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
	beq	$3,$0,$L621
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

$L621:
	.set	noreorder
	.set	nomacro
	j	$L708
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L618:
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
	beq	$3,$0,$L625
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

$L625:
	li	$2,1			# 0x00000001
$L708:
	sw	$16,4($17)
	sw	$2,8($17)
	lw	$4,0($17)
	move	$5,$0
	addu	$6,$sp,24
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L615
$L626:
	lw	$2,32($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	move	$16,$0
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
	beq	$3,$0,$L630
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

$L630:
	li	$2,3			# 0x00000003
	sw	$16,4($17)
	sw	$2,8($17)
	sh	$0,40($sp)
	lw	$4,32($17)
	addu	$5,$sp,40
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	addu	$4,$4,16
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
	lw	$7,32($17)
	lh	$5,40($sp)
	addu	$2,$7,32
	sw	$2,16($sp)
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	addu	$7,$7,16
	.set	macro
	.set	reorder

	lw	$3,0($17)
	#nop
	lw	$2,608($3)
	#nop
	ori	$2,$2,0x0400
	sw	$2,608($3)
	.set	noreorder
	.set	nomacro
	j	$L616
	sw	$0,32($17)
	.set	macro
	.set	reorder

$L627:
	lw	$3,4($17)
	#nop
	lw	$2,4($3)
	#nop
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L632
	lw	$2,28($17)
	#nop
	sltu	$16,$2,1
$L632:
	beq	$16,$0,$L616
	.set	noreorder
	.set	nomacro
	jal	CheckForNewTriggers__14AIHigh_Traffic
	move	$4,$17
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L634
	lw	$4,triggerManagerTraffic
	.set	noreorder
	.set	nomacro
	jal	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,5			# 0x00000005
	bne	$3,$2,$L616
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,24			# 0x00000018
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	__21AIState_RovingTrafficP8Car_tObjP9trigger_t
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L638
	move	$18,$2
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

$L638:
	li	$2,6			# 0x00000006
	sw	$2,8($17)
	addu	$2,$16,12
	sw	$18,4($17)
	sw	$2,16($sp)
	lw	$4,0($17)
	lw	$5,4($16)
	lw	$7,60($16)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L616
$L634:
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
	beq	$3,$0,$L642
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

$L642:
	lw	$4,0($17)
	li	$2,2			# 0x00000002
	sw	$16,4($17)
	.set	noreorder
	.set	nomacro
	jal	AILife_ReencarnateTraffic__FP8Car_tObj
	sw	$2,8($17)
	.set	macro
	.set	reorder

	j	$L616
$L643:
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	beq	$2,$0,$L644
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
	beq	$3,$0,$L647
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

$L647:
	.set	noreorder
	.set	nomacro
	j	$L709
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L644:
	lw	$2,28($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	move	$4,$17
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
	beq	$3,$0,$L651
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

$L651:
	.set	noreorder
	.set	nomacro
	j	$L709
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	jal	CopCheck__14AIHigh_TrafficPi
	addu	$5,$sp,176
	.set	macro
	.set	reorder

	beq	$2,$0,$L652
	lw	$2,24($17)
	#nop
	bne	$2,$0,$L616
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
	sll	$3,$2,2
	addu	$3,$3,$2
	lw	$2,176($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	srl	$3,$3,15
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lh	$18,8($2)
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
	li	$19,1			# 0x00000001
	sw	$2,4($16)
	sw	$19,12($16)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L657
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

$L657:
	lw	$2,0($17)
	li	$3,3			# 0x00000003
	sw	$16,4($17)
	sw	$3,8($17)
	lw	$2,1364($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L670
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sll	$2,$18,5
	addu	$2,$2,$3
	lbu	$3,31($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	.set	noreorder
	.set	nomacro
	j	$L711
	andi	$2,$2,0x000f
	.set	macro
	.set	reorder

$L654:
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L661
	slt	$2,$3,8
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
	beq	$3,$0,$L664
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

$L664:
	.set	noreorder
	.set	nomacro
	j	$L709
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L661:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lh	$18,8($2)
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
	li	$19,1			# 0x00000001
	sw	$2,4($16)
	sw	$19,12($16)
	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L669
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

$L669:
	lw	$2,0($17)
	li	$3,3			# 0x00000003
	sw	$16,4($17)
	sw	$3,8($17)
	lw	$2,1364($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L670
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sll	$2,$18,5
	addu	$2,$2,$3
	lbu	$3,31($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	.set	noreorder
	.set	nomacro
	j	$L711
	andi	$2,$2,0x000f
	.set	macro
	.set	reorder

$L670:
	lw	$3,BWorldSm_slices
	sll	$2,$18,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
$L711:
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sw	$8,184($sp)
	lw	$5,184($sp)
	jal	SetIdlePosition__12AIState_Idlei
	j	$L616
$L666:
	.set	noreorder
	.set	nomacro
	j	$L616
	sw	$2,24($17)
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	j	$L616
	sw	$0,24($17)
	.set	macro
	.set	reorder

$L674:
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	move	$4,$17
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
	beq	$3,$0,$L678
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

$L678:
	.set	noreorder
	.set	nomacro
	j	$L709
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L675:
	.set	noreorder
	.set	nomacro
	jal	CopCheck__14AIHigh_TrafficPi
	addu	$5,$sp,180
	.set	macro
	.set	reorder

	bne	$2,$0,$L616
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0400
	beq	$2,$0,$L712
	j	$L616
$L684:
	lw	$4,0($17)
	jal	AILife_EvaluateLife__FP8Car_tObj
	beq	$2,$0,$L685
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
	beq	$3,$0,$L688
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

$L688:
	.set	noreorder
	.set	nomacro
	j	$L709
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L685:
	lw	$2,28($17)
	#nop
	beq	$2,$0,$L690
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
	j	$L709
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L690:
	lw	$3,4($17)
	#nop
	lw	$2,4($3)
	#nop
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L616
$L712:
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
	beq	$3,$0,$L698
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

$L698:
	li	$2,2			# 0x00000002
$L709:
	sw	$16,4($17)
	sw	$2,8($17)
$L616:
	lw	$4,4($17)
	jal	StateExecute__12AIState_Base
$L615:
	lw	$31,208($sp)
	lw	$19,204($sp)
	lw	$18,200($sp)
	lw	$17,196($sp)
	lw	$16,192($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,216
	.set	macro
	.set	reorder

	.end	HighExecute__14AIHigh_Traffic
	.text
	.ent	__14AIHigh_TrafficP8Car_tObj
__14AIHigh_TrafficP8Car_tObj:
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

	move	$2,$16
	lui	$3,%hi(AIHigh_Traffic_vtable) # high
	addiu	$3,$3,%lo(AIHigh_Traffic_vtable) # low
	sw	$3,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	sw	$0,32($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__14AIHigh_TrafficP8Car_tObj
	.text
	.ent	CheckForNewTriggers__14AIHigh_Traffic
CheckForNewTriggers__14AIHigh_Traffic:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lui	$2,%hi(Cars_gTotalSortedList) # high
	lw	$3,Cars_gNumCars
	addiu	$2,$2,%lo(Cars_gTotalSortedList) # low
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
	addu	$23,$3,-1
	sll	$3,$23,2
	addu	$3,$3,$2
	sw	$3,20($sp)
$L719:
	.set	noreorder
	.set	nomacro
	bltz	$23,$L720
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$8,20($sp)
	#nop
	lw	$21,0($8)
	#nop
	lw	$2,608($21)
	#nop
	andi	$2,$2,0x0204
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L738
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$8,%hi(highLevelAIObjs) # high
	addiu	$8,$8,%lo(highLevelAIObjs) # low
	lw	$2,596($21)
	lw	$3,1380($21)
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	bltz	$3,$L723
	li	$7,3276800			# 0x00320000
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
$L723:
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$3,$2,4
	subu	$3,$3,$2
	bltz	$3,$L724
	lh	$2,8($21)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L726
	.set	noreorder
	.set	nomacro
	j	$L726
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L724:
	lh	$2,8($21)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L726
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L726:
	lw	$5,16($6)
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	sw	$3,16($6)
	.set	macro
	.set	reorder

	move	$4,$5
	.set	noreorder
	.set	nomacro
	j	$L729
	move	$20,$3
	.set	macro
	.set	reorder

$L728:
	move	$4,$3
	move	$20,$5
$L729:
	move	$17,$4
	subu	$2,$20,$17
	slt	$fp,$2,50
	sll	$2,$7,1
	addu	$2,$2,$7
	sll	$2,$2,3
	addu	$22,$2,$7
$L730:
	slt	$2,$17,$20
	beq	$2,$0,$L722
	beq	$fp,$0,$L722
	lw	$4,triggerManagerTraffic
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
	beq	$19,$2,$L734
	sll	$5,$22,2
	.set	macro
	.set	reorder

	bgez	$5,$L735
	ori	$5,$5,0xffff
$L735:
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

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L734
	slt	$2,$16,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L734
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$4,triggerManagerTraffic
	.set	noreorder
	.set	nomacro
	jal	GetTrigger__24AITrigger_TriggerManageriPi
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	j	$L737
$L734:
	.set	noreorder
	.set	nomacro
	j	$L730
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L722:
	lw	$8,20($sp)
$L738:
	addu	$23,$23,-1
	addu	$8,$8,-4
	.set	noreorder
	.set	nomacro
	j	$L719
	sw	$8,20($sp)
	.set	macro
	.set	reorder

$L720:
$L737:
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

	.end	CheckForNewTriggers__14AIHigh_Traffic
	.text
	.ent	___14AIHigh_Traffic
___14AIHigh_Traffic:
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

	.end	___14AIHigh_Traffic
