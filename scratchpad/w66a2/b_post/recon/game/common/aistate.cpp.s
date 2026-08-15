	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aistate.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIState_StartUp__Fv
	.align	2
	.globl	AIState_Restart__Fv
	.align	2
	.globl	AIState_CleanUp__Fv
	.align	2
	.globl	StateExecute__12AIState_Base
	.align	2
	.globl	__12AIState_BaseP8Car_tObj
	.align	2
	.globl	Execute__14AIState_Normal
	.align	2
	.globl	__14AIState_NormalP8Car_tObj
	.align	2
	.globl	Execute__12AIState_Idle
	.align	2
	.globl	SetIdlePosition__12AIState_Idlei
	.align	2
	.globl	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
	.align	2
	.globl	___13AIState_Chase
	.align	2
	.globl	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
	.align	2
	.globl	SetMurderMode__13AIState_Chaseii
	.align	2
	.globl	SetUp__13AIState_Chase
	.align	2
	.globl	DoSlowNitrous__13AIState_Chase
	.align	2
	.globl	DoNitrous__13AIState_Chasei
	.align	2
	.globl	Execute__13AIState_Chase
	.align	2
	.globl	FarTargeting__13AIState_Chase
	.align	2
	.globl	CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
	.align	2
	.globl	CloseTargeting__13AIState_Chase
	.align	2
	.globl	ApproachTargeting__13AIState_Chasei
	.align	2
	.globl	CheckForBarriersAndTargetAroundThem__13AIState_Chase
	.align	2
	.globl	FindBarrierEndSlice__13AIState_Chase
	.align	2
	.globl	___15AIState_Offroad
	.align	2
	.globl	__15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii
	.align	2
	.globl	UnleashIfInRange__15AIState_OffroadP8Car_tObj
	.align	2
	.globl	Execute__15AIState_Offroad
	.rdata
	.align	2
$LC0:
	.ascii	"SBUS\000"
	.align	2
$LC1:
	.ascii	"TBUS\000"
	.text
	.align	2
	.globl	__17AIState_PurgatoryP8Car_tObj
	.align	2
	.globl	___17AIState_Purgatory
	.align	2
	.globl	TestForRelease__17AIState_Purgatory
	.align	2
	.globl	Execute__17AIState_Purgatory
	.align	2
	.globl	StartUp__17AIState_Purgatory
	.align	2
	.globl	__21AIState_RovingTrafficP8Car_tObjP9trigger_t
	.align	2
	.globl	CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi
	.align	2
	.globl	Execute__21AIState_RovingTraffic
	.align	2
	.globl	___14AIState_Donuts
	.align	2
	.globl	Execute__14AIState_Donuts
	.align	2
	.globl	__17AIState_GotoSliceP8Car_tObjii
	.align	2
	.globl	Execute__17AIState_GotoSlice
	.align	2
	.globl	InTargetSliceRange__17AIState_GotoSlicei
	.align	2
	.globl	__14AIState_CruiseP8Car_tObj12cruiseMode_ti
	.align	2
	.globl	Execute__14AIState_Cruise
	.align	2
	.globl	___14AIState_Cruise
	.align	2
	.globl	___17AIState_GotoSlice
	.align	2
	.globl	TestForRelease__21AIState_RovingTraffic
	.align	2
	.globl	___21AIState_RovingTraffic
	.align	2
	.globl	Execute__17AIState_NonActive_80072750
	.align	2
	.globl	___17AIState_NonActive_80072758
	.align	2
	.globl	___12AIState_Idle
	.align	2
	.globl	___14AIState_Normal
	.align	2
	.globl	TestForRelease__12AIState_Base_80072830
	.align	2
	.globl	___12AIState_Base_80072838
	.globl	AIState_Purgatory_numTrafficCarsInPurgatory
	.sdata
	.align	2
AIState_Purgatory_numTrafficCarsInPurgatory:
	.space	4

	.extern	GameSetup_gData, 2600
	.extern	AITune_MaxTraffic, 32
	.extern	Cars_gNumCars, 4
	.extern	Cars_gNumTrafficCars, 4
	.extern	randtemp, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	gNumSlices, 4
	.extern	BWorldSm_slices, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	simGlobal, 24
	.extern	AI_elapsedTime, 4

	.text
	.text
	.ent	AIState_StartUp__Fv
AIState_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	StartUp__17AIState_Purgatory
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIState_StartUp__Fv
	.text
	.ent	AIState_Restart__Fv
AIState_Restart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	StartUp__17AIState_Purgatory
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIState_Restart__Fv
	.text
	.ent	AIState_CleanUp__Fv
AIState_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIState_CleanUp__Fv
	.text
	.ent	StateExecute__12AIState_Base
StateExecute__12AIState_Base:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,0($16)
	#nop
	lbu	$2,145($4)
	#nop
	beq	$2,$0,$L603
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0004
	bne	$2,$0,$L603
	lhu	$2,382($4)
	#nop
	bne	$2,$0,$L603
	lw	$5,AI_elapsedTime
	.set	noreorder
	.set	nomacro
	jal	AIScript_ProcessActionsAndReactions__FP10AIScript_ti
	addu	$4,$4,1268
	.set	macro
	.set	reorder

$L603:
	lw	$2,4($16)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
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

	.end	StateExecute__12AIState_Base
	.text
	.ent	__12AIState_BaseP8Car_tObj
__12AIState_BaseP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(AIState_Base_vtable) # high
	addiu	$3,$3,%lo(AIState_Base_vtable) # low
	sw	$3,4($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,0($2)
	.set	macro
	.set	reorder

	.end	__12AIState_BaseP8Car_tObj
	.text
	.ent	Execute__14AIState_Normal
Execute__14AIState_Normal:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,0($16)
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericEndCycle__FP8Car_tObj
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Execute__14AIState_Normal
	.text
	.ent	__14AIState_NormalP8Car_tObj
__14AIState_NormalP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_Normal_vtable) # high
	lw	$3,0($16)
	addiu	$2,$2,%lo(AIState_Normal_vtable) # low
	sw	$2,4($16)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$3,0($16)
	move	$2,$16
	sw	$0,1812($3)
	lw	$4,0($2)
	li	$3,1			# 0x00000001
	sb	$3,145($4)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__14AIState_NormalP8Car_tObj
	.text
	.ent	Execute__12AIState_Idle
Execute__12AIState_Idle:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sw	$0,1372($2)
	lw	$3,0($16)
	#nop
	lw	$2,1396($3)
	.set	noreorder
	.set	nomacro
	j	$L616
	sw	$2,1368($3)
	.set	macro
	.set	reorder

$L610:
	lw	$5,0($16)
	lw	$3,8($16)
	lw	$2,1396($5)
	ori	$4,$4,0xfffe
	subu	$2,$2,$3
	li	$3,65535			# 0x0000ffff
	addu	$2,$2,$3
	sltu	$4,$4,$2
	bne	$4,$0,$L612
	.set	noreorder
	.set	nomacro
	j	$L613
	sw	$0,1372($5)
	.set	macro
	.set	reorder

$L612:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	move	$4,$5
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	lw	$2,1372($3)
	#nop
	bgez	$2,$L614
	addu	$2,$2,3
$L614:
	sra	$2,$2,2
	sw	$2,1372($3)
$L613:
	lw	$3,0($16)
	lw	$2,8($16)
	#nop
	sw	$2,1368($3)
$L616:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Execute__12AIState_Idle
	.text
	.ent	SetIdlePosition__12AIState_Idlei
SetIdlePosition__12AIState_Idlei:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$5,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,12($4)
	.set	macro
	.set	reorder

	.end	SetIdlePosition__12AIState_Idlei
	.text
	.ent	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,28($sp)
	lw	$19,72($sp)
	sw	$21,36($sp)
	lw	$21,76($sp)
	sw	$22,40($sp)
	lw	$22,80($sp)
	sw	$fp,48($sp)
	move	$fp,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$20,32($sp)
	sw	$23,44($sp)
	lw	$23,84($sp)
	sw	$17,20($sp)
	lw	$17,88($sp)
	sw	$31,52($sp)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$20,$7
	.set	macro
	.set	reorder

	addu	$4,$fp,8
	move	$5,$16
	move	$6,$18
	lui	$2,%hi(AIState_Chase_vtable) # high
	addiu	$2,$2,%lo(AIState_Chase_vtable) # low
	sw	$2,4($fp)
	.set	noreorder
	.set	nomacro
	jal	__10AIDelayCarP8Car_tObjT1i
	move	$7,$17
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$18
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
	sw	$19,124($fp)
	.set	macro
	.set	reorder

	lw	$2,0($fp)
	li	$3,65536			# 0x00010000
	sw	$3,1852($2)
	lw	$2,0($fp)
	#nop
	sw	$3,1856($2)
	lw	$3,0($fp)
	lui	$2,%hi(D_8011321C) # high
	sw	$21,128($fp)
	sw	$22,132($fp)
	sw	$23,136($fp)
	sw	$0,140($fp)
	lw	$2,%lo(D_8011321C)($2)
	lw	$3,1364($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	nor	$2,$0,$3
	.set	macro
	.set	reorder

	xori	$2,$3,0x0001
$L622:
	sw	$0,68($fp)
	move	$2,$fp
	sw	$0,144($fp)
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

	.end	__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii
	.text
	.ent	___13AIState_Chase
___13AIState_Chase:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_Chase_vtable) # high
	sw	$31,16($sp)
	lw	$3,0($4)
	addiu	$2,$2,%lo(AIState_Chase_vtable) # low
	sw	$2,4($4)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$2,0($4)
	#nop
	sw	$0,1812($2)
	lw	$2,0($4)
	#nop
	sw	$0,1820($2)
	lw	$2,0($4)
	#nop
	sw	$0,1824($2)
	lw	$2,0($4)
	li	$3,65536			# 0x00010000
	sw	$3,1852($2)
	lw	$2,0($4)
	andi	$5,$5,0x0001
	sw	$3,1856($2)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L627
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L627:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___13AIState_Chase
	.text
	.ent	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
SetTarget__13AIState_ChaseP8Car_tObjP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,28($sp)
	sw	$18,24($sp)
	lw	$2,72($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$17,$L630
	move	$18,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetNewTargetCar__10AIDelayCarP8Car_tObj
	addu	$4,$16,8
	.set	macro
	.set	reorder

$L630:
	sw	$17,72($16)
	lw	$7,0($18)
	lw	$8,4($18)
	lw	$9,8($18)
	sw	$7,76($16)
	sw	$8,80($16)
	sw	$9,84($16)
	#.set	volatile
	lw	$2,72($16)
	#.set	novolatile
	sw	$0,88($16)
	sw	$0,92($16)
	lw	$4,308($2)
	#.set	volatile
	lw	$3,76($16)
	#.set	novolatile
	subu	$2,$0,$4
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L637:
	sw	$2,92($16)
$L632:
	#.set	volatile
	lw	$2,72($16)
	#.set	novolatile
	#nop
	lw	$4,316($2)
	#.set	volatile
	lw	$3,84($16)
	#.set	novolatile
	subu	$2,$0,$4
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L638:
	sw	$2,88($16)
$L635:
	move	$4,$16
	sw	$0,112($4)
	sw	$0,116($4)
	.set	noreorder
	.set	nomacro
	jal	SetUp__13AIState_Chase
	sw	$0,120($4)
	.set	macro
	.set	reorder

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

	.end	SetTarget__13AIState_ChaseP8Car_tObjP8coorddef
	.text
	.ent	SetMurderMode__13AIState_Chaseii
SetMurderMode__13AIState_Chaseii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,112($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L641
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	sw	$5,112($4)
	lw	$2,%lo(simGlobal+4)($2)
	#nop
	addu	$2,$2,$6
	sw	$2,116($4)
$L641:
	j	$31
	.end	SetMurderMode__13AIState_Chaseii
	.text
	.ent	SetUp__13AIState_Chase
SetUp__13AIState_Chase:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$17,36($sp)
	addu	$17,$16,8
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Update__10AIDelayCar
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lw	$2,1380($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L643
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L643:
	sw	$3,100($16)
	lw	$2,56($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L644
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L644:
	lw	$2,0($16)
	sw	$3,96($16)
	lw	$3,48($17)
	lw	$2,1396($2)
	#nop
	subu	$2,$2,$3
	sw	$2,108($16)
	lw	$7,40($16)
	lw	$8,44($16)
	lw	$9,48($16)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	lw	$4,0($16)
	lw	$5,16($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lw	$3,0($16)
	sw	$2,104($16)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$2,0($16)
	#nop
	sw	$0,1812($2)
	lw	$2,112($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,116($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L645
	sw	$0,112($16)
	sw	$0,116($16)
$L645:
	lw	$2,0($16)
	#nop
	lw	$2,1852($2)
	li	$4,65536			# 0x00010000
	beq	$2,$4,$L646
	lw	$2,124($16)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	sw	$2,124($16)
$L646:
	lw	$2,0($16)
	#nop
	sw	$4,1852($2)
	lw	$2,0($16)
	#nop
	sw	$4,1856($2)
	lw	$2,0($16)
	#nop
	sw	$0,1820($2)
	lw	$2,0($16)
	#nop
	sw	$0,1824($2)
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	SetUp__13AIState_Chase
	.text
	.ent	DoSlowNitrous__13AIState_Chase
DoSlowNitrous__13AIState_Chase:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	li	$2,32768			# 0x00008000
	sw	$2,1852($3)
	lw	$3,0($4)
	li	$2,49152			# 0x0000c000
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1856($3)
	.set	macro
	.set	reorder

	.end	DoSlowNitrous__13AIState_Chase
	.text
	.ent	DoNitrous__13AIState_Chasei
DoNitrous__13AIState_Chasei:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$2,124($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L648
	move	$20,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,140($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	li	$4,131072			# 0x00020000
	.set	macro
	.set	reorder

	ori	$4,$4,0x8000
	move	$18,$0
	li	$19,65536			# 0x00010000
	lw	$3,0($16)
	li	$2,196608			# 0x00030000
	sw	$2,1852($3)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lw	$3,0($16)
	addiu	$17,$2,%lo(Cars_gHumanRaceCarList) # low
	sw	$4,1856($3)
$L652:
	beq	$20,$0,$L648
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L648
	lw	$4,0($16)
	lw	$5,0($17)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	lw	$4,0($16)
	#nop
	lw	$3,1364($4)
	#nop
	mult	$2,$3
	mflo	$3
	#nop
	#nop
	blez	$3,$L655
	lw	$2,128($16)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L655
	sw	$19,1852($4)
	lw	$2,0($16)
	#nop
	sw	$19,1856($2)
$L655:
	bgez	$3,$L656
	lw	$2,132($16)
	#nop
	subu	$2,$0,$2
	slt	$2,$2,$3
	beq	$2,$0,$L656
	lw	$2,0($16)
	#nop
	sw	$19,1852($2)
	lw	$2,0($16)
	#nop
	sw	$19,1856($2)
$L656:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L652
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L648:
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

	.end	DoNitrous__13AIState_Chasei
	.text
	.ent	Execute__13AIState_Chase
Execute__13AIState_Chase:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	SetUp__13AIState_Chase
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$4,104($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1638			# 0x00000666
	.set	macro
	.set	reorder

	lw	$3,0($16)
	lw	$4,72($16)
	lw	$3,1380($3)
	lw	$4,1380($4)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	subu	$5,$3,$4
	bgez	$5,1f
	subu	$5,$0,$5
1:
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,104($16)
	li	$3,9175040			# 0x008c0000
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$6,$3,$2
$L659:
	bgez	$4,1f
	subu	$4,$0,$4
1:
	li	$2,393216			# 0x00060000
	ori	$2,$2,0xaaa9
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L661
	xori	$4,$2,0x0001
	.set	macro
	.set	reorder

	lw	$3,100($16)
	lw	$2,96($16)
	#nop
	mult	$3,$2
	li	$2,1			# 0x00000001
	mflo	$7
	#nop
	#nop
	bne	$7,$2,$L672
	bne	$4,$0,$L672
	.set	noreorder
	.set	nomacro
	jal	CloseTargeting__13AIState_Chase
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L671
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

$L672:
	lw	$2,104($16)
	#nop
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$7,$L673
	li	$2,1703936			# 0x001a0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L674
	ori	$2,$2,0xaaaa
	.set	macro
	.set	reorder

$L661:
	.set	noreorder
	.set	nomacro
	jal	FarTargeting__13AIState_Chase
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L671
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

$L673:
	ori	$2,$2,0xaaaa
$L674:
	slt	$2,$2,$5
	bne	$2,$0,$L666
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L675
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,104($16)
	li	$2,5242880			# 0x00500000
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L665
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L666:
	move	$4,$16
$L675:
	move	$5,$0
$L665:
	jal	ApproachTargeting__13AIState_Chasei
	lui	$2,%hi(simGlobal+4) # high
$L671:
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,140($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L658
	.set	noreorder
	.set	nomacro
	jal	DoSlowNitrous__13AIState_Chase
	move	$4,$16
	.set	macro
	.set	reorder

$L658:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Execute__13AIState_Chase
	.text
	.ent	FarTargeting__13AIState_Chase
FarTargeting__13AIState_Chase:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(simGlobal+4) # high
	sw	$31,20($sp)
	sw	$0,120($16)
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,68($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L677
	lw	$2,104($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L678
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,0($16)
	.set	noreorder
	.set	nomacro
	j	$L677
	sw	$2,1360($3)
	.set	macro
	.set	reorder

$L678:
	lw	$3,0($16)
	li	$2,1			# 0x00000001
	sw	$2,1360($3)
$L677:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DoNitrous__13AIState_Chasei
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,0($16)
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	jal	CheckForBarriersAndTargetAroundThem__13AIState_Chase
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,0($16)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericEndCycle__FP8Car_tObj
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FarTargeting__13AIState_Chase
	.text
	.ent	CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1900544			# 0x001d0000
	lw	$3,104($4)
	ori	$2,$2,0xffff
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L683
	li	$5,39321			# 0x00009999
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L684
	li	$5,62259			# 0x0000f333
	.set	macro
	.set	reorder

$L683:
	li	$2,3211264			# 0x00310000
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L692
	li	$2,6488064			# 0x00630000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	li	$2,9764864			# 0x00950000
	.set	macro
	.set	reorder

$L692:
	.set	noreorder
	.set	nomacro
	j	$L684
	li	$5,52428			# 0x0000cccc
	.set	macro
	.set	reorder

$L687:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,13041664			# 0x00c70000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L684
	li	$5,49152			# 0x0000c000
	.set	macro
	.set	reorder

$L689:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L684
	li	$5,45875			# 0x0000b333
$L684:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
	.text
	.ent	CloseTargeting__13AIState_Chase
CloseTargeting__13AIState_Chase:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	move	$17,$4
	sw	$20,32($sp)
	move	$20,$0
	sw	$21,36($sp)
	move	$21,$20
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	#nop
	lw	$fp,1364($2)
	.set	noreorder
	.set	nomacro
	jal	DoNitrous__13AIState_Chasei
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	move	$16,$20
	.set	macro
	.set	reorder

	move	$18,$20
	move	$19,$20
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DoNitrous__13AIState_Chasei
	move	$5,$20
	.set	macro
	.set	reorder

	j	$L695
$L694:
	lw	$19,92($17)
	lw	$18,88($17)
$L695:
	lw	$2,108($17)
	#nop
	mult	$2,$fp
	lw	$2,72($17)
	#nop
	lw	$3,308($2)
	#nop
	subu	$2,$0,$3
	mflo	$4
	#nop
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L696
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L697
	li	$20,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L696:
	beq	$2,$0,$L697
	li	$20,1			# 0x00000001
$L697:
	lw	$2,104($17)
	#nop
	mult	$2,$fp
	lw	$2,72($17)
	#nop
	lw	$3,316($2)
	li	$5,131072			# 0x00020000
	subu	$2,$5,$3
	mflo	$4
	#nop
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	addu	$2,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L700
	li	$21,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L699:
	slt	$2,$2,$4
	beq	$2,$0,$L700
	li	$21,1			# 0x00000001
$L700:
	lw	$2,104($17)
	#nop
	mult	$2,$fp
	lw	$2,72($17)
	#nop
	lw	$3,316($2)
	li	$2,131072			# 0x00020000
	addu	$3,$3,$2
	subu	$2,$0,$3
	mflo	$4
	#nop
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L702
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L703
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L702:
	beq	$2,$0,$L703
	li	$16,1			# 0x00000001
$L703:
	bne	$20,$19,$L705
	bne	$21,$18,$L705
	lw	$2,120($17)
	lw	$3,AI_elapsedTime
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L706
	sw	$2,120($17)
	.set	macro
	.set	reorder

$L705:
	sw	$0,120($17)
$L706:
	mult	$16,$18
	move	$4,$0
	move	$22,$4
	li	$2,-1			# 0xffffffff
	mflo	$9
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bne	$9,$2,$L707
	li	$23,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$22,$19
	bne	$22,$0,$L709
	.set	noreorder
	.set	nomacro
	j	$L709
	move	$22,$2
	.set	macro
	.set	reorder

$L707:
	mult	$20,$19
	mflo	$9
	#nop
	#nop
	bne	$9,$2,$L710
	bne	$16,$0,$L710
	li	$4,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L709
	move	$23,$0
	.set	macro
	.set	reorder

$L710:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L738
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$16,$0,$L738
	lw	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L709
	move	$23,$0
	.set	macro
	.set	reorder

$L712:
$L738:
	bne	$18,$2,$L709
	bne	$16,$18,$L709
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L709
	li	$2,1245184			# 0x00130000
	.set	macro
	.set	reorder

	lw	$3,104($17)
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L709
	li	$4,-2			# 0xfffffffe
$L709:
	lw	$16,64($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$16,$L739
	slt	$2,$21,$18
	.set	macro
	.set	reorder

	subu	$16,$0,$16
$L739:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L717
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L716
	slt	$2,$18,$21
	.set	macro
	.set	reorder

$L717:
	move	$4,$16
	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L737
	ori	$5,$5,0x6666
	.set	macro
	.set	reorder

$L716:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L720
	li	$2,1310720			# 0x00140000
	.set	macro
	.set	reorder

	lw	$3,104($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L720
	bne	$20,$0,$L720
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L740
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L720:
	.set	noreorder
	.set	nomacro
	jal	CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	j	$L737
	move	$5,$2
	.set	macro
	.set	reorder

$L719:
	li	$2,-2			# 0xfffffffe
$L740:
	bne	$4,$2,$L723
	lw	$3,136($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L724
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L726
	li	$5,42598			# 0x0000a666
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L726
	li	$5,47841			# 0x0000bae1
	.set	macro
	.set	reorder

$L724:
	li	$5,51773			# 0x0000ca3d
$L726:
	move	$4,$16
$L737:
	jal	fixedmult
	move	$16,$2
$L723:
	lw	$4,0($17)
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	lw	$2,0($17)
	#nop
	lw	$3,1372($2)
	#nop
	bgez	$3,1f
	subu	$3,$0,$3
1:
	sw	$3,1372($2)
	lw	$4,0($17)
	#nop
	lw	$3,1372($4)
	#nop
	slt	$2,$16,$3
	beq	$2,$0,$L727
	move	$3,$16
$L727:
	move	$16,$3
	li	$2,262144			# 0x00040000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	li	$3,327680			# 0x00050000
	.set	macro
	.set	reorder

	move	$3,$16
$L728:
	mult	$3,$fp
	mflo	$16
	#nop
	#nop
	sw	$16,1372($4)
	lw	$4,0($17)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	beq	$23,$0,$L729
	lw	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	li	$8,983040			# 0x000f0000
	.set	macro
	.set	reorder

	lw	$4,56($17)
	.set	noreorder
	.set	nomacro
	j	$L731
	li	$8,1966080			# 0x001e0000
	.set	macro
	.set	reorder

$L730:
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L732
	li	$3,393216			# 0x00060000
	.set	macro
	.set	reorder

	lw	$2,72($17)
	#nop
	lw	$2,308($2)
	.set	noreorder
	.set	nomacro
	j	$L733
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L732:
	lw	$2,76($17)
$L733:
 #APP
 #NO_APP
	mult	$2,$fp
	lw	$2,56($17)
	mflo	$9
	#nop
	#nop
	addu	$4,$2,$9
 #APP
 #NO_APP
	lw	$2,0($17)
	#nop
	lh	$2,8($2)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$6,$2,$3
	lbu	$2,30($6)
	lbu	$7,29($6)
	sll	$2,$2,15
	srl	$3,$7,4
	mult	$2,$3
	mflo	$9
	#nop
	#nop
	subu	$5,$0,$9
	slt	$2,$5,$4
	beq	$2,$0,$L734
	move	$5,$4
$L734:
	lbu	$2,31($6)
	andi	$3,$7,0x000f
	sll	$2,$2,15
	mult	$2,$3
	move	$4,$5
	mflo	$3
	#nop
	#nop
	slt	$2,$4,$3
	beq	$2,$0,$L735
	move	$3,$4
$L735:
	move	$4,$3
$L731:
	lw	$2,0($17)
	#nop
	sw	$4,1820($2)
	lw	$2,0($17)
	#nop
	sw	$8,1824($2)
$L729:
	.set	noreorder
	.set	nomacro
	jal	CheckForBarriersAndTargetAroundThem__13AIState_Chase
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,0($17)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($17)
	jal	AI_GenericEndCycle__FP8Car_tObj
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

	.end	CloseTargeting__13AIState_Chase
	.text
	.ent	ApproachTargeting__13AIState_Chasei
ApproachTargeting__13AIState_Chasei:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$4,0($17)
	lw	$5,72($17)
	lw	$3,160($4)
	lw	$2,160($5)
	#nop
	subu	$6,$3,$2
	lw	$3,168($4)
	lw	$2,168($5)
	bgez	$6,1f
	subu	$6,$0,$6
1:
	subu	$3,$3,$2
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L742
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L743
	addu	$16,$6,$2
	.set	macro
	.set	reorder

$L742:
	sra	$2,$6,2
	addu	$16,$3,$2
$L743:
	lui	$2,%hi(simGlobal+4) # high
	sw	$0,120($17)
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,68($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L744
	lw	$2,104($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L745
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,0($17)
	.set	noreorder
	.set	nomacro
	j	$L744
	sw	$2,1360($3)
	.set	macro
	.set	reorder

$L745:
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	sw	$2,1360($3)
$L744:
	lw	$4,0($17)
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	lw	$3,136($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L748
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L752
	li	$4,1638400			# 0x00190000
	.set	macro
	.set	reorder

	j	$L753
$L750:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L755
	li	$4,1638400			# 0x00190000
	.set	macro
	.set	reorder

	j	$L753
$L752:
	li	$2,9830400			# 0x00960000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,3932160			# 0x003c0000
	.set	macro
	.set	reorder

	li	$2,6553600			# 0x00640000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,3276800			# 0x00320000
	.set	macro
	.set	reorder

	li	$2,3276800			# 0x00320000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,2621440			# 0x00280000
	.set	macro
	.set	reorder

	li	$2,1638400			# 0x00190000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,2293760			# 0x00230000
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	li	$4,1310720			# 0x00140000
	.set	macro
	.set	reorder

	j	$L753
$L748:
	li	$2,9830400			# 0x00960000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,3932160			# 0x003c0000
	.set	macro
	.set	reorder

	li	$2,6553600			# 0x00640000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,3276800			# 0x00320000
	.set	macro
	.set	reorder

	li	$2,3276800			# 0x00320000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,2621440			# 0x00280000
	.set	macro
	.set	reorder

	li	$2,1638400			# 0x00190000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,2293760			# 0x00230000
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L767
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

$L761:
	li	$2,393216			# 0x00060000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L753
	li	$4,196608			# 0x00030000
	.set	macro
	.set	reorder

$L755:
	li	$2,9830400			# 0x00960000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,5242880			# 0x00500000
	.set	macro
	.set	reorder

	li	$2,6553600			# 0x00640000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,4587520			# 0x00460000
	.set	macro
	.set	reorder

	li	$2,3276800			# 0x00320000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,3276800			# 0x00320000
	.set	macro
	.set	reorder

	li	$2,1638400			# 0x00190000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,2621440			# 0x00280000
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	li	$4,917504			# 0x000e0000
	.set	macro
	.set	reorder

	li	$2,393216			# 0x00060000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
$L767:
$L753:
	lw	$5,0($17)
	#nop
	lw	$3,1364($5)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L775
	subu	$3,$0,$4
	.set	macro
	.set	reorder

	lw	$6,1372($5)
	move	$3,$4
	.set	noreorder
	.set	nomacro
	j	$L786
	slt	$2,$6,$3
	.set	macro
	.set	reorder

$L775:
	lw	$6,1372($5)
	#nop
	slt	$2,$3,$6
$L786:
	beq	$2,$0,$L777
	move	$3,$6
$L777:
	sw	$3,1372($5)
	lw	$4,0($17)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	jal	CheckForBarriersAndTargetAroundThem__13AIState_Chase
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,0($17)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($17)
	jal	AI_GenericEndCycle__FP8Car_tObj
	beq	$18,$0,$L741
	lw	$3,0($17)
	lw	$2,72($17)
	#nop
	lw	$7,160($2)
	lw	$8,164($2)
	lw	$9,168($2)
	sw	$7,1800($3)
	sw	$8,1804($3)
	sw	$9,1808($3)
	lw	$2,72($17)
	lw	$3,0($17)
	lw	$2,1396($2)
	#nop
	sw	$2,1812($3)
	lw	$2,72($17)
	lw	$3,0($17)
	lw	$2,1396($2)
	#nop
	sw	$2,1820($3)
	lw	$3,0($17)
	li	$2,983040			# 0x000f0000
	sw	$2,1824($3)
$L741:
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

	.end	ApproachTargeting__13AIState_Chasei
	.text
	.ent	CheckForBarriersAndTargetAroundThem__13AIState_Chase
CheckForBarriersAndTargetAroundThem__13AIState_Chase:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,104($18)
	li	$2,32768000			# 0x01f40000
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	li	$7,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$3,0($18)
	lw	$6,BWorldSm_slices
	lh	$19,8($3)
	lw	$16,1732($3)
	lw	$3,72($18)
	sll	$2,$19,5
	addu	$2,$2,$6
	lbu	$5,29($2)
	lh	$4,8($3)
	lw	$17,1732($3)
	srl	$2,$5,4
	subu	$2,$7,$2
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	andi	$2,$5,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	sll	$2,$4,5
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	lbu	$3,29($2)
	#nop
	srl	$2,$3,4
	subu	$2,$7,$2
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	move	$16,$2
	.set	macro
	.set	reorder

	beq	$16,$0,$L794
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L796
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AI_TargetLane__FP8Car_tObji
	sw	$0,144($18)
	.set	macro
	.set	reorder

	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AI_TargetLane__FP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AI_TargetLane__FP8Car_tObji
	move	$5,$17
	.set	macro
	.set	reorder

	j	$L787
$L796:
	lw	$2,144($18)
	lw	$3,AI_elapsedTime
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L787
	sw	$2,144($18)
	.set	macro
	.set	reorder

$L794:
	sw	$0,144($18)
$L787:
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

	.end	CheckForBarriersAndTargetAroundThem__13AIState_Chase
	.text
	.ent	FindBarrierEndSlice__13AIState_Chase
FindBarrierEndSlice__13AIState_Chase:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
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
	lw	$3,0($4)
	lw	$2,72($4)
	lw	$7,1732($3)
	lw	$4,1732($2)
	lh	$21,8($3)
	slt	$2,$4,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L799
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L800
	move	$16,$7
	.set	macro
	.set	reorder

$L799:
	move	$5,$7
	move	$16,$4
$L800:
	move	$20,$5
	slt	$2,$20,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L841
	li	$8,83			# 0x00000053
	.set	macro
	.set	reorder

	move	$4,$21
$L842:
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	move	$6,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L841
	li	$8,83			# 0x00000053
	.set	macro
	.set	reorder

	addu	$20,$20,1
	slt	$2,$20,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L842
	move	$4,$21
	.set	macro
	.set	reorder

	li	$8,83			# 0x00000053
$L841:
	move	$9,$8
	lw	$3,gNumSlices
	addu	$23,$21,$8
	sw	$8,20($sp)
	slt	$2,$23,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L806
	sw	$9,16($sp)
	.set	macro
	.set	reorder

	subu	$23,$23,$3
$L806:
	addu	$22,$21,-83
	.set	noreorder
	.set	nomacro
	bgez	$22,$L843
	move	$18,$20
	.set	macro
	.set	reorder

	addu	$22,$22,$3
$L843:
	move	$19,$0
	li	$fp,6			# 0x00000006
$L808:
	slt	$2,$19,83
	beq	$2,$0,$L809
	.set	noreorder
	.set	nomacro
	bltz	$19,$L812
	addu	$16,$21,$19
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L844
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L814
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L812:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L844
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
$L814:
	move	$4,$16
$L844:
	addu	$5,$18,1
	addu	$17,$18,-1
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	move	$6,$17
	.set	macro
	.set	reorder

	andi	$4,$2,0x0004
	andi	$3,$2,0x0002
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L810
	andi	$5,$2,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L817
	sll	$3,$16,5
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lbu	$3,29($3)
	#nop
	srl	$2,$3,4
	subu	$2,$fp,$2
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L817
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$17
	bne	$2,$0,$L817
	.set	noreorder
	.set	nomacro
	j	$L810
	move	$18,$17
	.set	macro
	.set	reorder

$L817:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L820
	sll	$3,$16,5
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lbu	$3,29($3)
	addu	$5,$18,1
	srl	$2,$3,4
	subu	$2,$fp,$2
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L820
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	move	$18,$5
	.set	macro
	.set	reorder

$L820:
	move	$23,$16
	.set	noreorder
	.set	nomacro
	j	$L809
	sw	$19,16($sp)
	.set	macro
	.set	reorder

$L819:
$L810:
	.set	noreorder
	.set	nomacro
	j	$L808
	addu	$19,$19,4
	.set	macro
	.set	reorder

$L809:
	move	$18,$20
	move	$19,$0
	li	$20,6			# 0x00000006
$L822:
	slt	$2,$19,83
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L823
	subu	$2,$0,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L826
	subu	$16,$21,$19
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L845
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L828
	subu	$16,$16,$3
	.set	macro
	.set	reorder

$L826:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L845
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$16,$16,$2
$L828:
	move	$4,$16
$L845:
	addu	$5,$18,1
	addu	$17,$18,-1
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CheckForBarrierBetweenLanes__Fiii
	move	$6,$17
	.set	macro
	.set	reorder

	andi	$4,$2,0x0004
	andi	$3,$2,0x0002
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L824
	andi	$5,$2,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L831
	sll	$3,$16,5
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lbu	$3,29($3)
	#nop
	srl	$2,$3,4
	subu	$2,$20,$2
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L831
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$17
	bne	$2,$0,$L831
	.set	noreorder
	.set	nomacro
	j	$L824
	move	$18,$17
	.set	macro
	.set	reorder

$L831:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L834
	sll	$3,$16,5
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	#nop
	addu	$3,$3,$2
	lbu	$3,29($3)
	addu	$5,$18,1
	srl	$2,$3,4
	subu	$2,$20,$2
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L834
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	addu	$2,$2,7
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L833
	move	$18,$5
	.set	macro
	.set	reorder

$L834:
	move	$22,$16
	.set	noreorder
	.set	nomacro
	j	$L823
	sw	$19,20($sp)
	.set	macro
	.set	reorder

$L833:
$L824:
	.set	noreorder
	.set	nomacro
	j	$L822
	addu	$19,$19,4
	.set	macro
	.set	reorder

$L823:
	lw	$8,16($sp)
	lw	$9,20($sp)
	#nop
	slt	$2,$8,$9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L836
	addu	$3,$23,6
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L837
	addu	$2,$4,-6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L840
	move	$2,$3
	.set	macro
	.set	reorder

$L837:
	.set	noreorder
	.set	nomacro
	j	$L840
	subu	$2,$23,$2
	.set	macro
	.set	reorder

$L836:
	addu	$2,$22,-6
	bgez	$2,$L840
	lw	$2,gNumSlices
	#nop
	addu	$2,$2,-6
	addu	$2,$22,$2
$L840:
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

	.end	FindBarrierEndSlice__13AIState_Chase
	.text
	.ent	___15AIState_Offroad
___15AIState_Offroad:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	lui	$2,%hi(AIState_Offroad_vtable) # high
	sw	$31,16($sp)
	lw	$3,0($6)
	addiu	$2,$2,%lo(AIState_Offroad_vtable) # low
	sw	$2,4($6)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$2,0($6)
	#nop
	sw	$0,1812($2)
	lw	$4,0($6)
	andi	$5,$5,0x0001
	lw	$2,608($4)
	li	$3,-2049			# 0xfffff7ff
	and	$2,$2,$3
	sw	$2,608($4)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L846
	sw	$2,4($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$6
	.set	macro
	.set	reorder

$L846:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___15AIState_Offroad
	.text
	.ent	__15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii
__15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,16($sp)
	lw	$16,64($sp)
	sw	$20,32($sp)
	lw	$20,68($sp)
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$21,36($sp)
	lw	$21,76($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$18,$7
	.set	macro
	.set	reorder

	addu	$3,$19,24
	lui	$2,%hi(AIState_Offroad_vtable) # high
	addiu	$2,$2,%lo(AIState_Offroad_vtable) # low
	sw	$2,4($19)
	sw	$0,92($19)
	sw	$17,8($19)
	lw	$8,0($18)
	lw	$9,4($18)
	lw	$10,8($18)
	sw	$8,12($19)
	sw	$9,16($19)
	sw	$10,20($19)
	addu	$2,$16,32
$L850:
	lw	$8,0($16)
	lw	$9,4($16)
	lw	$10,8($16)
	lw	$11,12($16)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$16,$16,16
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L850
	addu	$3,$3,16
	.set	macro
	.set	reorder

	sll	$2,$20,3
	addu	$2,$2,$20
	sll	$2,$2,3
	subu	$2,$2,$20
	sll	$2,$2,8
	lw	$8,0($16)
	sw	$8,0($3)
	lw	$8,48($19)
	lw	$9,52($19)
	lw	$10,56($19)
	sw	$8,60($19)
	sw	$9,64($19)
	sw	$10,68($19)
	sw	$2,96($19)
	lw	$2,72($sp)
	lw	$3,BWorldSm_slices
	sw	$21,72($19)
	sw	$2,100($19)
	sll	$2,$21,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,76($19)
	sw	$9,80($19)
	sw	$10,84($19)
	lw	$4,0($19)
	#nop
	lw	$3,608($4)
	move	$2,$19
	ori	$3,$3,0x0800
	sw	$3,608($4)
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

	.end	__15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii
	.text
	.ent	UnleashIfInRange__15AIState_OffroadP8Car_tObj
UnleashIfInRange__15AIState_OffroadP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$31,24($sp)
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$16,$5
	.set	macro
	.set	reorder

	lw	$4,192($16)
	lw	$5,100($17)
	.set	noreorder
	bgez	$2,1f
	move	$16,$2
	subu	$16,$0,$16
1:
	.set	reorder
	jal	fixedmult
	move	$3,$2
	li	$2,1310720			# 0x00140000
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L855
	slt	$2,$16,$3
	.set	macro
	.set	reorder

	li	$3,1310720			# 0x00140000
	slt	$2,$16,$3
$L855:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L852
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,92($17)
$L852:
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

	.end	UnleashIfInRange__15AIState_OffroadP8Car_tObj
	.text
	.ent	Execute__15AIState_Offroad
Execute__15AIState_Offroad:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,36($sp)
	lw	$2,92($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L857
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	lw	$7,16($sp)
	lw	$8,20($sp)
	lw	$9,24($sp)
	sw	$7,172($2)
	sw	$8,176($2)
	sw	$9,180($2)
	lw	$2,0($16)
	#nop
	lw	$7,16($sp)
	lw	$8,20($sp)
	lw	$9,24($sp)
	sw	$7,276($2)
	sw	$8,280($2)
	sw	$9,284($2)
	lw	$2,0($16)
	#nop
	sw	$0,1372($2)
	lw	$2,0($16)
	addu	$3,$16,24
	lw	$7,12($16)
	lw	$8,16($16)
	lw	$9,20($16)
	sw	$7,160($2)
	sw	$8,164($2)
	sw	$9,168($2)
	lw	$2,0($16)
	addu	$4,$16,56
	addu	$2,$2,240
$L858:
	lw	$7,0($3)
	lw	$8,4($3)
	lw	$9,8($3)
	lw	$10,12($3)
	sw	$7,0($2)
	sw	$8,4($2)
	sw	$9,8($2)
	sw	$10,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L858
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$7,0($3)
	sw	$7,0($2)
	lw	$2,0($16)
	#nop
	sw	$0,1808($2)
	sw	$0,1804($2)
	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$0,1800($2)
	.set	macro
	.set	reorder

$L857:
	lw	$4,0($16)
	lw	$5,72($16)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	lw	$4,0($16)
	lw	$3,96($16)
	sw	$2,88($16)
	sw	$3,1372($4)
	lw	$2,88($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L860
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	sw	$2,1360($3)
	lw	$3,0($16)
	#nop
	lw	$2,1372($3)
	#nop
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$L861
	sw	$2,1372($3)
	.set	macro
	.set	reorder

$L860:
	lw	$3,0($16)
	li	$2,1			# 0x00000001
	sw	$2,1360($3)
$L861:
	lw	$4,0($16)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericEndCycle__FP8Car_tObj
	lw	$2,0($16)
	#nop
	lw	$7,76($16)
	lw	$8,80($16)
	lw	$9,84($16)
	sw	$7,1800($2)
	sw	$8,1804($2)
	sw	$9,1808($2)
$L859:
	lw	$2,0($16)
	#nop
	sw	$0,1812($2)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Execute__15AIState_Offroad
	.text
	.ent	__17AIState_PurgatoryP8Car_tObj
__17AIState_PurgatoryP8Car_tObj:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$16,32($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__12AIState_BaseP8Car_tObj
	move	$16,$5
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	li	$6,12			# 0x0000000c
	lui	$2,%hi(AIState_NonActive_vtable+8) # high
	addiu	$2,$2,%lo(AIState_NonActive_vtable+8) # low
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,4($17)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,596($16)
	addu	$6,$sp,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,17
	sw	$2,20($sp)
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	sb	$0,145($2)
	lui	$2,%hi(AIState_Purgatory_vtable) # high
	lw	$6,fastRandom
	lw	$3,randSeed
	addiu	$2,$2,%lo(AIState_Purgatory_vtable) # low
	sw	$2,4($17)
	mult	$6,$3
	lui	$2,%hi(Cars_gList) # high
	lw	$2,%lo(Cars_gList)($2)
	lw	$3,0($17)
	#nop
	sw	$2,1400($3)
	lui	$2,%hi(AITune_LifeTimer) # high
	lw	$3,Cars_gNumTrafficCars
	addiu	$2,$2,%lo(AITune_LifeTimer) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$3,0($3)
	mflo	$6
	#nop
	#nop
	srl	$2,$6,8
	andi	$2,$2,0xffff
	mult	$3,$2
	move	$16,$0
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	sw	$6,randtemp
	mflo	$3
	#nop
	#nop
	srl	$2,$3,16
	lw	$3,0($17)
	addu	$2,$2,1
	sw	$2,1420($3)
	lw	$4,0($17)
	andi	$6,$6,0xffff
	sw	$6,fastRandom
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$4,$4,576
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L866
	lui	$5,%hi($LC1) # high
	.set	macro
	.set	reorder

	lw	$4,0($17)
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$4,$4,576
	.set	macro
	.set	reorder

	bne	$2,$0,$L865
$L866:
	li	$16,1			# 0x00000001
$L865:
	beq	$16,$0,$L867
	lw	$4,0($17)
	#nop
	lw	$3,1420($4)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sw	$2,1420($4)
$L867:
	lw	$3,0($17)
	#nop
	lw	$2,1392($3)
	#nop
	ori	$2,$2,0x0004
	sw	$2,1392($3)
	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L870
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$2,AIState_Purgatory_numTrafficCarsInPurgatory
	#nop
	addu	$2,$2,1
	sw	$2,AIState_Purgatory_numTrafficCarsInPurgatory
	move	$2,$17
$L870:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	__17AIState_PurgatoryP8Car_tObj
	.text
	.ent	___17AIState_Purgatory
___17AIState_Purgatory:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$4
	lui	$2,%hi(AIState_Purgatory_vtable) # high
	sw	$31,16($sp)
	lw	$3,0($7)
	addiu	$2,$2,%lo(AIState_Purgatory_vtable) # low
	sw	$2,4($7)
	sw	$0,1928($3)
	lw	$2,0($7)
	#nop
	sw	$0,412($2)
	lw	$4,0($7)
	#nop
	lw	$2,1392($4)
	li	$3,-5			# 0xfffffffb
	and	$2,$2,$3
	sw	$2,1392($4)
	lw	$2,0($7)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L872
	lw	$2,AIState_Purgatory_numTrafficCarsInPurgatory
	#nop
	addu	$2,$2,-1
	sw	$2,AIState_Purgatory_numTrafficCarsInPurgatory
$L872:
	lw	$2,Cars_gNumCars
	#nop
	addu	$4,$2,-1
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$2,$2,%lo(Cars_gSortedList) # low
	sll	$3,$4,2
	addu	$6,$3,$2
	lw	$3,0($7)
	li	$2,1			# 0x00000001
	sw	$2,1364($3)
	sw	$2,1360($3)
 #APP
 #NO_APP
$L873:
	.set	noreorder
	.set	nomacro
	bltz	$4,$L878
	lui	$2,%hi(AIState_NonActive_vtable+8) # high
	.set	macro
	.set	reorder

	lw	$3,0($6)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L875
	addu	$6,$6,-4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L873
	addu	$4,$4,-1
	.set	macro
	.set	reorder

$L875:
	lw	$2,0($7)
	#nop
	sw	$3,1400($2)
	lui	$2,%hi(AIState_NonActive_vtable+8) # high
$L878:
	lw	$3,0($7)
	addiu	$2,$2,%lo(AIState_NonActive_vtable+8) # low
	sw	$2,4($7)
	li	$2,1			# 0x00000001
	sb	$2,145($3)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	sw	$2,4($7)
	andi	$2,$5,0x0001
	beq	$2,$0,$L871
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$7
	.set	macro
	.set	reorder

$L871:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17AIState_Purgatory
	.text
	.ent	TestForRelease__17AIState_Purgatory
TestForRelease__17AIState_Purgatory:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$7,0($4)
	#nop
	lw	$2,1420($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L880
	lui	$3,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(GameSetup_gData) # low
	lw	$5,Cars_gNumTrafficCars
	lw	$2,24($3)
	lw	$4,AIState_Purgatory_numTrafficCarsInPurgatory
	sll	$6,$2,2
	subu	$5,$5,$4
	lui	$2,%hi(AITune_MaxTraffic) # high
	addiu	$4,$2,%lo(AITune_MaxTraffic) # low
	lw	$2,12($3)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L885
	addu	$2,$6,$4
	.set	macro
	.set	reorder

	addu	$6,$6,16
	addu	$2,$6,$4
$L885:
	lw	$2,0($2)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L886
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$3,1420($7)
$L880:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L886:
	j	$31
	.end	TestForRelease__17AIState_Purgatory
	.text
	.ent	Execute__17AIState_Purgatory
Execute__17AIState_Purgatory:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	sw	$0,1928($2)
	lw	$2,0($4)
	#nop
	sw	$0,412($2)
	lw	$4,0($4)
	#nop
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L890
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,960
	bne	$2,$0,$L890
	lw	$2,1420($4)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	sw	$2,1420($4)
$L890:
	j	$31
	.end	Execute__17AIState_Purgatory
	.text
	.ent	StartUp__17AIState_Purgatory
StartUp__17AIState_Purgatory:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,AIState_Purgatory_numTrafficCarsInPurgatory
	j	$31
	.end	StartUp__17AIState_Purgatory
	.text
	.ent	__21AIState_RovingTrafficP8Car_tObjP9trigger_t
__21AIState_RovingTrafficP8Car_tObjP9trigger_t:
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
	jal	__12AIState_BaseP8Car_tObj
	move	$17,$6
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_RovingTraffic_vtable) # high
	addiu	$2,$2,%lo(AIState_RovingTraffic_vtable) # low
	sw	$2,4($16)
	lw	$2,60($17)
	lw	$4,0($16)
	sw	$2,8($16)
	lw	$2,56($17)
	sw	$0,16($16)
	sw	$0,20($16)
	sw	$2,12($16)
	lw	$3,608($4)
	move	$2,$16
	ori	$3,$3,0x0800
	sw	$3,608($4)
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

	.end	__21AIState_RovingTrafficP8Car_tObjP9trigger_t
	.text
	.ent	CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi
CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$16,$L897
	move	$19,$6
	.set	macro
	.set	reorder

	lbu	$2,145($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L910
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	blez	$2,$L899
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L900
	move	$3,$2
	.set	macro
	.set	reorder

$L899:
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	subu	$3,$0,$2
$L900:
	li	$2,786432			# 0x000c0000
	slt	$2,$2,$3
	bne	$2,$0,$L902
	lw	$2,0($18)
	lw	$3,1396($16)
	lw	$5,1396($2)
	#nop
	subu	$4,$5,$3
	.set	noreorder
	.set	nomacro
	blez	$4,$L903
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L905
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L895
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L903:
	ori	$2,$2,0xffff
	subu	$3,$3,$5
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L910
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L905:
	lw	$2,0($18)
	lw	$5,160($16)
	lw	$2,160($2)
	#nop
	subu	$5,$5,$2
	sw	$5,16($sp)
	lw	$3,0($18)
	lw	$2,164($16)
	lw	$3,164($3)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,0($18)
	lw	$2,168($16)
	lw	$3,168($3)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,0($18)
	#nop
	lw	$4,264($2)
	jal	fixedmult
	lw	$3,0($18)
	lw	$5,20($sp)
	lw	$4,268($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$3,0($18)
	lw	$5,24($sp)
	lw	$4,272($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	blez	$16,$L895
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$6,16			# 0x00000010
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	AudioClc_HonkHorn__FP8Car_tObjiii
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	sw	$0,1372($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L895
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L897:
	li	$2,2			# 0x00000002
$L910:
	.set	noreorder
	.set	nomacro
	j	$L895
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L902:
	sw	$0,0($19)
$L895:
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

	.end	CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi
	.text
	.ent	Execute__21AIState_RovingTraffic
Execute__21AIState_RovingTraffic:
	.frame	$sp,96,$31		# vars= 56, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$18,80($sp)
	move	$18,$4
	sw	$31,88($sp)
	sw	$19,84($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	lw	$3,16($18)
	lw	$4,0($18)
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,8($18)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,1800($4)
	sw	$9,1804($4)
	sw	$10,1808($4)
	lw	$3,16($18)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,8($18)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,12($2)
	lw	$4,0($18)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$2,$3
	sw	$2,1372($4)
	lw	$2,0($18)
	#nop
	lh	$2,8($2)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,16($sp)
	sw	$9,20($sp)
	sw	$10,24($sp)
	lw	$2,0($18)
	#nop
	lw	$3,1800($2)
	lw	$2,16($sp)
	#nop
	subu	$5,$3,$2
	sw	$5,32($sp)
	lw	$2,0($18)
	#nop
	lw	$3,1804($2)
	lw	$2,20($sp)
	#nop
	subu	$7,$3,$2
	sw	$7,36($sp)
	lw	$2,0($18)
	#nop
	lw	$3,1808($2)
	lw	$2,24($sp)
	#nop
	subu	$3,$3,$2
	sw	$3,40($sp)
	lw	$6,0($18)
	#nop
	lw	$4,324($6)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L936
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L936:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L913
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L913:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,328($6)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L937
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L937:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L915
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L915:
	sra	$2,$2,8
	mult	$4,$2
	lw	$4,332($6)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L916
	addu	$5,$5,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L916:
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L917
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L917:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	addu	$2,$5,$2
	sw	$2,1812($6)
	lw	$2,0($18)
	#nop
	lw	$4,1800($2)
	lw	$2,160($2)
	#nop
	subu	$4,$4,$2
	sw	$4,48($sp)
	sra	$4,$4,12
	mult	$4,$4
	lw	$3,0($18)
	#nop
	lw	$2,1804($3)
	lw	$3,164($3)
	#nop
	subu	$2,$2,$3
	sw	$2,52($sp)
	lw	$2,0($18)
	#nop
	lw	$3,1808($2)
	lw	$2,168($2)
	mflo	$5
	#nop
	subu	$3,$3,$2
	sra	$2,$3,12
	mult	$2,$2
	sw	$4,48($sp)
	sw	$3,56($sp)
	sw	$2,56($sp)
	mflo	$7
	#nop
	#nop
	addu	$2,$5,$7
	slt	$2,$2,10000
	beq	$2,$0,$L918
	lw	$2,20($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L938
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$3,16($18)
	lui	$4,%hi(simGlobal+4) # high
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,8($18)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,%lo(simGlobal+4)($4)
	lw	$2,16($2)
	#nop
	addu	$3,$3,$2
	sw	$3,20($18)
	lui	$2,%hi(simGlobal+4) # high
$L938:
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,20($18)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L920
	lw	$2,0($18)
	.set	noreorder
	.set	nomacro
	j	$L918
	sw	$0,1372($2)
	.set	macro
	.set	reorder

$L920:
	lw	$2,16($18)
	sw	$0,20($18)
	addu	$2,$2,1
	sw	$2,16($18)
$L918:
	lw	$2,0($18)
	li	$19,2			# 0x00000002
	lw	$3,604($2)
	move	$2,$19
	sw	$2,64($sp)
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$2,$2,%lo(Cars_gSortedList) # low
	addu	$16,$3,1
	sll	$3,$16,$19
	addu	$17,$3,$2
$L924:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L923
	lw	$2,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L923
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$5,0($17)
	addu	$6,$sp,64
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi
	addu	$16,$16,1
	.set	macro
	.set	reorder

	j	$L924
$L923:
	lw	$3,64($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L911
	li	$19,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	lw	$3,604($2)
	move	$2,$19
	sw	$2,64($sp)
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$2,$2,%lo(Cars_gSortedList) # low
	addu	$16,$3,-1
	sll	$3,$16,$19
	addu	$17,$3,$2
$L931:
	bltz	$16,$L911
	lw	$2,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L911
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$5,0($17)
	addu	$6,$sp,64
	addu	$17,$17,-4
	.set	noreorder
	.set	nomacro
	jal	CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	j	$L931
$L911:
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

	.end	Execute__21AIState_RovingTraffic
	.text
	.ent	___14AIState_Donuts
___14AIState_Donuts:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIState_Donuts_vtable) # high
	sw	$31,16($sp)
	lw	$3,0($4)
	addiu	$2,$2,%lo(AIState_Donuts_vtable) # low
	sw	$2,4($4)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$2,0($4)
	#nop
	sw	$0,1812($2)
	lw	$2,0($4)
	andi	$5,$5,0x0001
	sw	$0,1872($2)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L939
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L939:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___14AIState_Donuts
	.text
	.ent	Execute__14AIState_Donuts
Execute__14AIState_Donuts:
	.frame	$sp,80,$31		# vars= 48, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$16,64($sp)
	move	$16,$4
	sw	$31,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	lw	$4,0($16)
	#nop
	lw	$3,264($4)
	lh	$17,8($4)
	bgez	$3,$L943
	addu	$3,$3,255
$L943:
	lw	$2,348($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L944
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L944:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,268($4)
	mflo	$5
	#nop
	bgez	$3,$L945
	addu	$3,$3,255
$L945:
	lw	$2,352($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L946
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L946:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,272($4)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L947
	addu	$5,$5,$7
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L947:
	lw	$2,356($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L948
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L948:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	addu	$2,$5,$7
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L950
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L950:
	sw	$2,1364($4)
	sw	$2,1360($4)
	lw	$3,12($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L952
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L951
	li	$3,-65536			# 0xffff0000
	.set	macro
	.set	reorder

$L952:
	lw	$4,0($16)
	#nop
	lw	$3,264($4)
	#nop
	bgez	$3,$L953
	addu	$3,$3,255
$L953:
	lw	$2,348($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L954
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L954:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,268($4)
	mflo	$5
	#nop
	bgez	$3,$L955
	addu	$3,$3,255
$L955:
	lw	$2,352($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L956
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L956:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,272($4)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L957
	addu	$5,$5,$7
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L957:
	lw	$2,356($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L958
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L958:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	addu	$2,$5,$7
	.set	noreorder
	.set	nomacro
	bltz	$2,$L959
	addu	$3,$17,3
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L960
	addu	$2,$4,-3
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L962
	move	$2,$3
	.set	macro
	.set	reorder

$L960:
	.set	noreorder
	.set	nomacro
	j	$L962
	subu	$2,$17,$2
	.set	macro
	.set	reorder

$L959:
	addu	$2,$17,-3
	bgez	$2,$L962
	lw	$2,gNumSlices
	#nop
	addu	$2,$2,-3
	addu	$2,$17,$2
$L962:
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,48($sp)
	sw	$9,52($sp)
	sw	$10,56($sp)
	lw	$2,0($16)
	#nop
	lw	$2,1396($2)
	lw	$3,12($16)
	.set	noreorder
	bgez	$2,1f
	move	$4,$2
	subu	$4,$0,$4
1:
	.set	reorder
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L970
	move	$18,$0
	.set	macro
	.set	reorder

	li	$2,131072			# 0x00020000
	ori	$2,$2,0x7fff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L970
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L970
	sw	$2,12($16)
	.set	macro
	.set	reorder

$L951:
	lw	$2,8($16)
	#nop
	addu	$2,$2,$3
	li	$3,32767			# 0x00007fff
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L966
	sw	$2,8($16)
	.set	macro
	.set	reorder

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
	sll	$2,$3,2
	addu	$2,$2,$3
	srl	$2,$2,14
	sll	$2,$2,16
	li	$3,1310720			# 0x00140000
	addu	$2,$2,$3
	sw	$2,8($16)
$L966:
	lw	$2,0($16)
	#nop
	lw	$7,240($2)
	lw	$8,244($2)
	lw	$9,248($2)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	lw	$2,0($16)
	#nop
	lw	$7,264($2)
	lw	$8,268($2)
	lw	$9,272($2)
	sw	$7,32($sp)
	sw	$8,36($sp)
	sw	$9,40($sp)
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,393216			# 0x00060000
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	li	$4,393216			# 0x00060000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	li	$4,393216			# 0x00060000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	lw	$4,8($16)
	lw	$5,32($sp)
	jal	fixedmult
	sw	$2,32($sp)
	lw	$4,8($16)
	lw	$5,36($sp)
	jal	fixedmult
	sw	$2,36($sp)
	lw	$4,8($16)
	lw	$5,40($sp)
	jal	fixedmult
	sw	$2,40($sp)
	lw	$3,0($16)
	#nop
	lw	$5,160($3)
	lw	$3,16($sp)
	#nop
	addu	$5,$5,$3
	sw	$5,48($sp)
	lw	$3,0($16)
	#nop
	lw	$4,164($3)
	lw	$3,20($sp)
	#nop
	addu	$4,$4,$3
	sw	$4,52($sp)
	lw	$3,0($16)
	lw	$6,32($sp)
	lw	$3,168($3)
	addu	$5,$5,$6
	sw	$5,48($sp)
	lw	$5,36($sp)
	lw	$6,24($sp)
	addu	$4,$4,$5
	addu	$3,$3,$6
	sw	$3,56($sp)
	addu	$3,$3,$2
	sw	$4,52($sp)
	sw	$3,56($sp)
	lw	$6,0($16)
	addu	$5,$sp,48
	lh	$4,8($6)
	.set	noreorder
	.set	nomacro
	jal	Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef
	addu	$6,$6,324
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	lw	$4,1396($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L967
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	sll	$2,$17,5
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	li	$2,-131072			# 0xfffe0000
	addu	$2,$4,$2
	mflo	$7
	#nop
	#nop
	subu	$3,$0,$7
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L974
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L970
$L967:
	lw	$3,BWorldSm_slices
	sll	$2,$17,5
	addu	$2,$2,$3
	lbu	$3,31($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	andi	$2,$2,0x000f
	mult	$3,$2
	li	$2,131072			# 0x00020000
	addu	$2,$4,$2
	mflo	$7
	#nop
	#nop
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L970
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L974:
	sw	$2,12($16)
$L970:
	lw	$3,0($16)
	lw	$2,12($16)
	#nop
	sw	$2,1872($3)
	lw	$4,0($16)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericEndCycle__FP8Car_tObj
	lw	$2,0($16)
	#nop
	lw	$8,48($sp)
	lw	$9,52($sp)
	lw	$10,56($sp)
	sw	$8,1800($2)
	sw	$9,1804($2)
	sw	$10,1808($2)
	lw	$2,0($16)
	li	$3,262144			# 0x00040000
	sw	$18,1812($2)
	lw	$2,0($16)
	ori	$3,$3,0x71c7
	sw	$3,1372($2)
	lw	$31,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Execute__14AIState_Donuts
	.text
	.ent	__17AIState_GotoSliceP8Car_tObjii
__17AIState_GotoSliceP8Car_tObjii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$18,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(AIState_GotoSlice_vtable) # high
	addiu	$3,$3,%lo(AIState_GotoSlice_vtable) # low
	sw	$3,4($2)
	sw	$17,8($2)
	sw	$18,12($2)
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

	.end	__17AIState_GotoSliceP8Car_tObjii
	.text
	.ent	Execute__17AIState_GotoSlice
Execute__17AIState_GotoSlice:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,8($16)
	lw	$5,0($16)
	jal	AIWorld_ApxSplineDistance__FiP8Car_tObj
	move	$17,$2
	.set	noreorder
	.set	nomacro
	bltz	$17,$L978
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($16)
	.set	noreorder
	.set	nomacro
	j	$L992
	sw	$2,1360($3)
	.set	macro
	.set	reorder

$L978:
	lw	$3,0($16)
	li	$2,-1			# 0xffffffff
	sw	$2,1360($3)
$L992:
	.set	noreorder
	.set	nomacro
	jal	Execute__14AIState_Normal
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L977
	li	$2,720896			# 0x000b0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	.set	noreorder
	bgez	$17,1f
	move	$3,$17
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L981
	li	$4,13107200			# 0x00c80000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L982
	li	$4,262144			# 0x00040000
	.set	macro
	.set	reorder

$L981:
	li	$2,3211264			# 0x00310000
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L983
	li	$2,9764864			# 0x00950000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L982
	li	$4,1310720			# 0x00140000
	.set	macro
	.set	reorder

$L983:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L985
	li	$2,26148864			# 0x018f0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L982
	li	$4,2621440			# 0x00280000
	.set	macro
	.set	reorder

$L985:
	ori	$2,$2,0xffff
	slt	$2,$2,$3
	bne	$2,$0,$L982
	li	$4,5242880			# 0x00500000
$L982:
	lw	$3,0($16)
	#nop
	lw	$7,1372($3)
 #APP
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$7,$L988
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	slt	$2,$7,$6
	.set	macro
	.set	reorder

$L988:
	subu	$6,$0,$4
	slt	$2,$6,$7
$L989:
 #APP
 #NO_APP
	beq	$2,$0,$L990
	move	$6,$7
$L990:
	sw	$6,1372($3)
$L977:
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

	.end	Execute__17AIState_GotoSlice
	.text
	.ent	InTargetSliceRange__17AIState_GotoSlicei
InTargetSliceRange__17AIState_GotoSlicei:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$2,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	lw	$4,0($2)
	lw	$5,8($2)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	bgez	$2,$L994
	subu	$2,$0,$2
$L994:
	slt	$2,$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	InTargetSliceRange__17AIState_GotoSlicei
	.text
	.ent	__14AIState_CruiseP8Car_tObj12cruiseMode_ti
__14AIState_CruiseP8Car_tObj12cruiseMode_ti:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIState_NormalP8Car_tObj
	move	$18,$7
	.set	macro
	.set	reorder

	lui	$2,%hi(AIState_Cruise_vtable) # high
	addiu	$2,$2,%lo(AIState_Cruise_vtable) # low
	sw	$2,4($16)
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L996
	sw	$17,8($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L999
	sw	$18,12($16)
	.set	macro
	.set	reorder

$L996:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1000
	move	$2,$16
	.set	macro
	.set	reorder

	sw	$18,16($16)
$L999:
	move	$2,$16
$L1000:
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

	.end	__14AIState_CruiseP8Car_tObj12cruiseMode_ti
	.text
	.ent	Execute__14AIState_Cruise
Execute__14AIState_Cruise:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,8($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1004
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1008
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$0,$L1003
	j	$L1002
$L1008:
	beq	$3,$2,$L1005
	j	$L1002
$L1003:
	lw	$4,0($16)
	lw	$3,12($16)
	lw	$2,1364($4)
	#nop
	mult	$3,$2
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	j	$L1002
	sw	$6,1372($4)
	.set	macro
	.set	reorder

$L1004:
	lw	$4,0($16)
	jal	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	lw	$2,0($16)
	lw	$5,16($16)
	lw	$4,1372($2)
	jal	fixedmult
	lw	$3,0($16)
	.set	noreorder
	.set	nomacro
	j	$L1002
	sw	$2,1372($3)
	.set	macro
	.set	reorder

$L1005:
	lw	$4,0($16)
	jal	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
$L1002:
	lw	$4,0($16)
	jal	AI_GenericBeginCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericCycle__FP8Car_tObj
	lw	$4,0($16)
	jal	AI_GenericEndCycle__FP8Car_tObj
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Execute__14AIState_Cruise
	.text
	.ent	___14AIState_Cruise
___14AIState_Cruise:
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
	beq	$5,$0,$L1010
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1010:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___14AIState_Cruise
	.text
	.ent	___17AIState_GotoSlice
___17AIState_GotoSlice:
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
	beq	$5,$0,$L1013
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1013:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17AIState_GotoSlice
	.text
	.ent	TestForRelease__21AIState_RovingTraffic
TestForRelease__21AIState_RovingTraffic:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	lw	$3,12($4)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TestForRelease__21AIState_RovingTraffic
	.text
	.ent	___21AIState_RovingTraffic
___21AIState_RovingTraffic:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	lui	$2,%hi(AIState_RovingTraffic_vtable) # high
	sw	$31,16($sp)
	lw	$3,0($6)
	addiu	$2,$2,%lo(AIState_RovingTraffic_vtable) # low
	sw	$2,4($6)
	sw	$0,1808($3)
	sw	$0,1804($3)
	sw	$0,1800($3)
	lw	$2,0($6)
	#nop
	sw	$0,1812($2)
	lw	$4,0($6)
	andi	$5,$5,0x0001
	lw	$2,608($4)
	li	$3,-2049			# 0xfffff7ff
	and	$2,$2,$3
	sw	$2,608($4)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1018
	sw	$2,4($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$6
	.set	macro
	.set	reorder

$L1018:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___21AIState_RovingTraffic
	.text
	.ent	Execute__17AIState_NonActive_80072750
Execute__17AIState_NonActive_80072750:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Execute__17AIState_NonActive_80072750
	.text
	.ent	___17AIState_NonActive_80072758
___17AIState_NonActive_80072758:
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
	beq	$5,$0,$L1023
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1023:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17AIState_NonActive_80072758
	.text
	.ent	___12AIState_Idle
___12AIState_Idle:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	lui	$2,%hi(AIState_Idle_vtable) # high
	addiu	$2,$2,%lo(AIState_Idle_vtable) # low
	sw	$31,16($sp)
	lw	$4,0($6)
	li	$3,-1025			# 0xfffffbff
	sw	$2,4($6)
	lw	$2,608($4)
	andi	$5,$5,0x0001
	and	$2,$2,$3
	sw	$2,608($4)
	lui	$2,%hi(AIState_Base_vtable) # high
	addiu	$2,$2,%lo(AIState_Base_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1026
	sw	$2,4($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$6
	.set	macro
	.set	reorder

$L1026:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___12AIState_Idle
	.text
	.ent	___14AIState_Normal
___14AIState_Normal:
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
	beq	$5,$0,$L1029
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1029:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___14AIState_Normal
	.text
	.ent	TestForRelease__12AIState_Base_80072830
TestForRelease__12AIState_Base_80072830:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	TestForRelease__12AIState_Base_80072830
	.text
	.ent	___12AIState_Base_80072838
___12AIState_Base_80072838:
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
	beq	$5,$0,$L1034
	sw	$2,4($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L1034:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___12AIState_Base_80072838
