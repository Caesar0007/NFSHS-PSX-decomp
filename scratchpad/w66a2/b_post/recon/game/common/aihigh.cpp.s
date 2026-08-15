	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aihigh.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.align	2
	.globl	AIHigh_kVtbl_80054dcc
	.data
	.align	2
AIHigh_kVtbl_80054dcc:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	__pure_virtual
	.half	0
	.half	0
	.word	_vtdtor_AIHigh_BTC_Perp__FP15AIHigh_BTC_Perp
	.half	0
	.half	0
	.word	CheckForCrimes__16AIHigh_BasicPerp
	.globl	AIHigh_None_vtable
	.align	2
AIHigh_None_vtable:
	.half	0
	.half	0
	.word	0
	.half	0
	.half	0
	.word	HighExecute__11AIHigh_None
	.half	0
	.half	0
	.word	_vtdtor_AIHigh_None__FP11AIHigh_None
	.text
	.align	2
	.globl	AIHigh_StartUp__Fv
	.align	2
	.globl	AIHigh_Restart1__Fv
	.align	2
	.globl	AIHigh_Restart2__Fv
	.align	2
	.globl	AIHigh_CleanUp__Fv
	.align	2
	.globl	AIHigh_Execute__Fv
	.align	2
	.globl	__11AIHigh_BaseP8Car_tObj
	.align	2
	.globl	_._11AIHigh_Base
	.align	2
	.globl	___15AIHigh_BTC_Perp
	.align	2
	.globl	HighExecute__11AIHigh_None
	.align	2
	.globl	_._11AIHigh_None
	.align	2
	.globl	Execute__12AIState_None
	.align	2
	.globl	___12AIState_None
	.align	2
	.globl	TestForRelease__12AIState_Base
	.align	2
	.globl	_._12AIState_Base
	.globl	highLevelAIObjs
	.data
	.align	2
highLevelAIObjs:
	.space	36
	.globl	AIHigh_CopGameType
	.sdata
	.align	2
AIHigh_CopGameType:
	.space	4

	.extern	AI_iTime, 4
	.extern	AI_elapsedTime, 4
	.extern	AI_time, 4
	.extern	Cars_gNumCars, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	_vtdtor_AIHigh_BTC_Perp__FP15AIHigh_BTC_Perp
_vtdtor_AIHigh_BTC_Perp__FP15AIHigh_BTC_Perp:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._11AIHigh_Base
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_vtdtor_AIHigh_BTC_Perp__FP15AIHigh_BTC_Perp
	.text
	.ent	_vtdtor_AIHigh_None__FP11AIHigh_None
_vtdtor_AIHigh_None__FP11AIHigh_None:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._11AIHigh_None
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_vtdtor_AIHigh_None__FP11AIHigh_None
	.text
	.ent	AIHigh_StartUp__Fv
AIHigh_StartUp__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$0
	sw	$20,32($sp)
	move	$20,$18
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AIState_StartUp__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L607
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L652
	move	$19,$0
	.set	macro
	.set	reorder

$L607:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L652
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L652
$L608:
	move	$19,$0
	lui	$2,%hi(Cars_gList) # high
	addiu	$21,$2,%lo(Cars_gList) # low
$L609:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	sll	$3,$19,2
	.set	macro
	.set	reorder

	lui	$2,%hi(highLevelAIObjs) # high
	lw	$17,0($21)
	addiu	$2,$2,%lo(highLevelAIObjs) # low
	lw	$4,608($17)
	addu	$22,$3,$2
	andi	$2,$4,0x0200
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	andi	$2,$4,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,140			# 0x0000008c
	.set	macro
	.set	reorder

	move	$6,$18
	addu	$18,$18,1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__19AIHigh_BTC_HumanCopP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	move	$16,$2
	.set	macro
	.set	reorder

$L612:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,136			# 0x00000088
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__16AIHigh_BasicPerpP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_kVtbl_80054dcc) # high
	addiu	$2,$2,%lo(AIHigh_kVtbl_80054dcc) # low
	sw	$2,20($16)
	li	$2,1			# 0x00000001
	sw	$2,124($16)
	lui	$2,%hi(AIHigh_BTC_HumanPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BTC_HumanPerp_vtable) # low
	sw	$0,128($16)
	.set	noreorder
	.set	nomacro
	j	$L650
	sw	$0,132($16)
	.set	macro
	.set	reorder

$L615:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	andi	$2,$4,0x0010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,172			# 0x000000ac
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__17AIHigh_BTC_AIPerpP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	move	$16,$2
	.set	macro
	.set	reorder

$L618:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	andi	$2,$4,0x0020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__14AIHigh_TrafficP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	move	$16,$2
	.set	macro
	.set	reorder

$L621:
	beq	$2,$0,$L624
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,124			# 0x0000007c
	.set	macro
	.set	reorder

	move	$6,$18
	addu	$18,$18,1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__18AIHigh_BTC_WingmanP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	move	$16,$2
	.set	macro
	.set	reorder

$L624:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,24			# 0x00000018
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__11AIHigh_BaseP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_None_vtable) # high
	addiu	$2,$2,%lo(AIHigh_None_vtable) # low
$L650:
	sw	$2,20($16)
$L614:
	sw	$16,0($22)
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L628
	addu	$20,$20,1
$L628:
	addu	$21,$21,4
	.set	noreorder
	.set	nomacro
	j	$L609
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L610:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L629
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	sw	$2,AIHigh_CopGameType
	j	$L605
$L629:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L653
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$18,$20,$L653
	li	$2,4			# 0x00000004
	sw	$2,AIHigh_CopGameType
	j	$L605
$L653:
	sw	$2,AIHigh_CopGameType
	j	$L605
$L652:
	move	$18,$19
	lui	$2,%hi(AIHigh_None_vtable) # high
	addiu	$22,$2,%lo(AIHigh_None_vtable) # low
	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$21,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$20,$2,%lo(Cars_gList) # low
$L633:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L634
	lw	$17,0($20)
	#nop
	lw	$3,608($17)
	#nop
	andi	$2,$3,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	andi	$2,$3,0x0008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,176			# 0x000000b0
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__12AIHigh_HumanP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	sw	$2,0($21)
	.set	macro
	.set	reorder

$L636:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	andi	$2,$3,0x0010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,192			# 0x000000c0
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__15AIHigh_OpponentP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	sw	$2,0($21)
	.set	macro
	.set	reorder

$L639:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	andi	$2,$3,0x0020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__14AIHigh_TrafficP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	sw	$2,0($21)
	.set	macro
	.set	reorder

$L642:
	beq	$2,$0,$L645
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,108			# 0x0000006c
	.set	macro
	.set	reorder

	move	$6,$18
	addu	$18,$18,1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__10AIHigh_CopP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	sw	$2,0($21)
	.set	macro
	.set	reorder

$L645:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,24			# 0x00000018
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__11AIHigh_BaseP8Car_tObj
	move	$5,$17
	.set	macro
	.set	reorder

	sw	$22,20($16)
	move	$2,$16
	sw	$2,0($21)
$L651:
	addu	$21,$21,4
	addu	$20,$20,4
	.set	noreorder
	.set	nomacro
	j	$L633
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L634:
	.set	noreorder
	.set	nomacro
	blez	$18,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,AIHigh_CopGameType
	j	$L605
$L649:
	sw	$0,AIHigh_CopGameType
$L605:
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

	.end	AIHigh_StartUp__Fv
	.text
	.ent	AIHigh_Restart1__Fv
AIHigh_Restart1__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AIHigh_CleanUp__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIHigh_Restart1__Fv
	.text
	.ent	AIHigh_Restart2__Fv
AIHigh_Restart2__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AIState_Restart__Fv
	jal	AIHigh_StartUp__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIHigh_Restart2__Fv
	.text
	.ent	AIHigh_CleanUp__Fv
AIHigh_CleanUp__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,Cars_gNumCars
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L657
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(highLevelAIObjs) # high
	addiu	$16,$2,%lo(highLevelAIObjs) # low
$L658:
	lw	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L661
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,20($3)
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

	sw	$0,0($16)
$L661:
	lw	$2,Cars_gNumCars
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L657:
	jal	AIState_CleanUp__Fv
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

	.end	AIHigh_CleanUp__Fv
	.text
	.ent	AIHigh_Execute__Fv
AIHigh_Execute__Fv:
	.frame	$sp,56,$31		# vars= 0, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,44($sp)
	move	$19,$0
	lui	$2,%hi(highLevelAIObjs) # high
	sw	$16,32($sp)
	addiu	$16,$2,%lo(highLevelAIObjs) # low
	lui	$2,%hi(Cars_gList) # high
	sw	$18,40($sp)
	addiu	$18,$2,%lo(Cars_gList) # low
	sw	$31,48($sp)
	sw	$17,36($sp)
$L664:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L663
	lw	$2,0($16)
	lw	$7,0($18)
	beq	$2,$0,$L668
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	move	$17,$0
	.set	macro
	.set	reorder

	la	$2,AI_time
	sw	$2,16($sp)
	la	$2,AI_elapsedTime
	sw	$2,20($sp)
	la	$2,AI_iTime
	sw	$2,24($sp)
	lw	$2,1884($7)
	li	$4,1			# 0x00000001
	sw	$2,28($sp)
	lw	$6,140($7)
	lw	$7,0($7)
	.set	noreorder
	.set	nomacro
	jal	Sched_ExecuteCheck__FiiiiPiN24i
	move	$5,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L672
$L671:
	li	$17,1			# 0x00000001
$L672:
	beq	$17,$0,$L668
	lw	$3,0($16)
	#nop
	lw	$2,20($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L668:
	addu	$16,$16,4
	addu	$18,$18,4
	.set	noreorder
	.set	nomacro
	j	$L664
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L663:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AIHigh_Execute__Fv
	.text
	.ent	__11AIHigh_BaseP8Car_tObj
__11AIHigh_BaseP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	li	$4,8			# 0x00000008
	lui	$2,%hi(AIHigh_Base_vtable) # high
	addiu	$2,$2,%lo(AIHigh_Base_vtable) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$2,20($16)
	sw	$5,0($16)
	sw	$0,4($16)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$0,8($16)
	.set	macro
	.set	reorder

	move	$17,$2
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_None_vtable) # high
	addiu	$2,$2,%lo(AIState_None_vtable) # low
	sw	$2,4($17)
	lw	$3,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L678
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

$L678:
	lw	$2,0($16)
	sw	$17,4($16)
	sw	$0,8($16)
	sw	$0,12($16)
	lh	$3,8($2)
	move	$2,$16
	sw	$3,16($2)
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

	.end	__11AIHigh_BaseP8Car_tObj
	.text
	.ent	_._11AIHigh_Base
_._11AIHigh_Base:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	lui	$2,%hi(AIHigh_Base_vtable) # high
	sw	$31,24($sp)
	lw	$3,4($16)
	addiu	$2,$2,%lo(AIHigh_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L682
	sw	$2,20($16)
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

	sw	$0,4($16)
$L682:
	andi	$2,$17,0x0001
	beq	$2,$0,$L684
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$16
	.set	macro
	.set	reorder

$L684:
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

	.end	_._11AIHigh_Base
	.text
	.ent	___15AIHigh_BTC_Perp
___15AIHigh_BTC_Perp:
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

	.end	___15AIHigh_BTC_Perp
	.text
	.ent	HighExecute__11AIHigh_None
HighExecute__11AIHigh_None:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	HighExecute__11AIHigh_None
	.text
	.ent	_._11AIHigh_None
_._11AIHigh_None:
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

	.end	_._11AIHigh_None
	.text
	.ent	Execute__12AIState_None
Execute__12AIState_None:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Execute__12AIState_None
	.text
	.ent	___12AIState_None
___12AIState_None:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_None_vtable) # high
	addiu	$2,$2,%lo(AIState_None_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L690
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L690:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___12AIState_None
	.text
	.ent	TestForRelease__12AIState_Base
TestForRelease__12AIState_Base:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TestForRelease__12AIState_Base
	.text
	.ent	_._12AIState_Base
_._12AIState_Base:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_Base_vtable+8) # high
	addiu	$2,$2,%lo(AIState_Base_vtable+8) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L696
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L696:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._12AIState_Base
