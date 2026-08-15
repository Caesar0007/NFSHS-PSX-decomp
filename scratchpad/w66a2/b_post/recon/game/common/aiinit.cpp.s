	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aiinit.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	trafcfg
	.data
	.align	2
trafcfg:
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	51
	.byte	179
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	0
	.byte	0
	.byte	64
	.byte	1
	.byte	0
	.byte	204
	.byte	204
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	5
	.byte	0
	.byte	204
	.byte	204
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	0
	.byte	71
	.byte	33
	.byte	0
	.byte	0
	.byte	83
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	0
	.byte	0
	.byte	160
	.byte	0
	.byte	0
	.byte	204
	.byte	204
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	10
	.byte	0
	.byte	204
	.byte	204
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	10
	.byte	0
	.byte	235
	.byte	81
	.byte	0
	.byte	0
	.byte	83
	.byte	3
	.byte	0
	.byte	0
	.text
	.align	2
	.globl	AIInit_StartUp1__Fv
	.align	2
	.globl	AIInit_StartUp2__Fv
	.align	2
	.globl	AIInit_Reset1__Fv
	.align	2
	.globl	AIInit_Reset2__Fv
	.align	2
	.globl	AIInit_CleanUp1__Fv
	.align	2
	.globl	AIInit_CleanUp2__Fv
	.align	2
	.globl	AI_TrafficStartUp__Fv
	.align	2
	.globl	AI_TrafficCleanUp__Fv
	.align	2
	.globl	AIInit_LoadConfigs__Fv
	.align	2
	.globl	AIInit_LoadPhysicsConfig__FP10Udff_tInfo
	.align	2
	.globl	AIInit_ClearAICar__FP8Car_tObj
	.align	2
	.globl	AIInit_RestartAICar__FP8Car_tObj
	.align	2
	.globl	AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
	.align	2
	.globl	AIInit_DeInitAICar__FP8Car_tObj
	.align	2
	.globl	AIInit_InitAICar2__FP8Car_tObj
	.align	2
	.globl	AIInit_DeInitAICar2__FP8Car_tObj
	.align	2
	.globl	AIInit_IsNonStandardCarFile__Fi
	.globl	AITraffic_rawTriggers
	.sdata
	.align	2
AITraffic_rawTriggers:
	.space	4
	.globl	AIInit_useSpreadForce
	.align	2
AIInit_useSpreadForce:
	.space	4
	.globl	AIInit_forceHumanHandBrake
	.align	2
AIInit_forceHumanHandBrake:
	.space	4

	.extern	D_8011321C, 4
	.extern	AIPhysicConfig, 108
	.extern	triggerManagerTraffic, 4
	.extern	AI_Info, 72
	.extern	leaderBoard, 16
	.extern	GameSetup_gData, 2600
	.extern	Cars_gNumCars, 4

	.text
	.text
	.ent	AIInit_StartUp1__Fv
AIInit_StartUp1__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AI_TrafficStartUp__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(inverseLaneWidthTable) # high
	li	$16,1			# 0x00000001
	sw	$0,%lo(inverseLaneWidthTable)($2)
	addiu	$2,$2,%lo(inverseLaneWidthTable) # low
	addu	$17,$2,4
$L601:
	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	rdiv
	sll	$5,$16,14
	.set	macro
	.set	reorder

	sw	$2,0($17)
	addu	$16,$16,1
	slt	$2,$16,80
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	addu	$17,$17,4
	.set	macro
	.set	reorder

	jal	AITune_StartUp1__Fv
	jal	StartUp1__14AIDataRecord_t
	jal	AI_StartUp__Fv
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

	.end	AIInit_StartUp1__Fv
	.text
	.ent	AIInit_StartUp2__Fv
AIInit_StartUp2__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_StartUp__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIInit_LoadConfigs__Fv
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L607
	lui	$2,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(Cars_gList) # low
$L609:
	lw	$4,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	AIScript_Startup__FP10AIScript_t
	addu	$4,$4,1268
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L609
$L607:
	.set	noreorder
	.set	nomacro
	jal	AIPerson_Startup__Fv
	move	$18,$0
	.set	macro
	.set	reorder

	jal	StartUp2__14AIDataRecord_t
	jal	AIPhysic_StartUp__Fv
	jal	AITune_StartUp2__Fv
	lui	$2,%hi(Cars_gList) # high
	addiu	$17,$2,%lo(Cars_gList) # low
$L611:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lw	$16,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_InitCar__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIInit_InitAICar2__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L611
$L605:
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

	.end	AIInit_StartUp2__Fv
	.text
	.ent	AIInit_Reset1__Fv
AIInit_Reset1__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,AIInit_forceHumanHandBrake
	j	$31
	.end	AIInit_Reset1__Fv
	.text
	.ent	AIInit_Reset2__Fv
AIInit_Reset2__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,3			# 0x00000003
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L617
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,AIInit_useSpreadForce
	j	$L618
$L617:
	sw	$0,AIInit_useSpreadForce
$L618:
	lw	$2,Cars_gNumCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L620
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gList) # high
	addiu	$17,$2,%lo(Cars_gList) # low
$L622:
	lw	$4,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	AIScript_Startup__FP10AIScript_t
	addu	$4,$4,1268
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L622
$L620:
	lui	$5,%hi(leaderBoard) # high
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lui	$3,%hi(Cars_gAIRaceCarList) # high
	lw	$4,%lo(Cars_gHumanRaceCarList)($2)
	lw	$3,%lo(Cars_gAIRaceCarList)($3)
	addiu	$2,$5,%lo(leaderBoard) # low
	sw	$4,4($2)
	sw	$4,%lo(leaderBoard)($5)
	sw	$3,12($2)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_Reset__Fv
	sw	$3,8($2)
	.set	macro
	.set	reorder

	lui	$3,%hi(AI_Info) # high
	addiu	$2,$3,%lo(AI_Info) # low
	sw	$0,8($2)
	sw	$0,4($2)
	sw	$0,%lo(AI_Info)($3)
	sw	$0,20($2)
	sw	$0,16($2)
	sw	$0,12($2)
	sw	$0,32($2)
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,44($2)
	sw	$0,40($2)
	sw	$0,36($2)
	sw	$0,56($2)
	sw	$0,52($2)
	sw	$0,48($2)
	sw	$0,60($2)
	sw	$0,68($2)
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

	.end	AIInit_Reset2__Fv
	.text
	.ent	AIInit_CleanUp1__Fv
AIInit_CleanUp1__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AI_CleanUp__Fv
	jal	CleanUp1__14AIDataRecord_t
	jal	AITune_CleanUp1__Fv
	jal	AI_TrafficCleanUp__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIInit_CleanUp1__Fv
	.text
	.ent	AIInit_CleanUp2__Fv
AIInit_CleanUp2__Fv:
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
	blez	$2,$L626
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L627:
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	AIInit_DeInitAICar2__FP8Car_tObj
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_DeInitCar__FP8Car_tObj
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	bne	$2,$0,$L627
$L626:
	.set	noreorder
	.set	nomacro
	jal	AITune_CleanUp2__Fv
	move	$16,$0
	.set	macro
	.set	reorder

	jal	AIPhysic_CleanUp__Fv
	jal	CleanUp2__14AIDataRecord_t
	jal	AIPerson_Cleanup__Fv
	lw	$2,Cars_gNumCars
	#nop
	blez	$2,$L631
$L632:
	.set	noreorder
	.set	nomacro
	jal	AIScript_Cleanup__Fv
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$16,$2
	bne	$2,$0,$L632
$L631:
	jal	AISpeeds_CleanUp__Fv
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

	.end	AIInit_CleanUp2__Fv
	.text
	.ent	AI_TrafficStartUp__Fv
AI_TrafficStartUp__Fv:
	.frame	$sp,128,$31		# vars= 104, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	lui	$2,%hi(GameSetup_gData) # high
	sw	$16,120($sp)
	addiu	$16,$2,%lo(GameSetup_gData) # low
	sw	$31,124($sp)
	lw	$2,24($16)
	#nop
	beq	$2,$0,$L636
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,844			# 0x0000034c
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi(D_8005521C) # high
	lui	$3,%hi(D_801164B0) # high
	lw	$6,%lo(D_801164B0)($3)
	lw	$7,60($16)
	sw	$2,triggerManagerTraffic
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo(D_8005521C) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,AITraffic_rawTriggers
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$4,triggerManagerTraffic
	j	$L640
$L638:
	lw	$4,triggerManagerTraffic
	move	$5,$0
$L640:
	jal	Init__24AITrigger_TriggerManagerPc
$L636:
	lw	$31,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	AI_TrafficStartUp__Fv
	.text
	.ent	AI_TrafficCleanUp__Fv
AI_TrafficCleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,triggerManagerTraffic
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L642
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	__builtin_delete
	sw	$0,triggerManagerTraffic
$L642:
	lw	$4,AITraffic_rawTriggers
	#nop
	beq	$4,$0,$L641
	jal	purgememadr
	sw	$0,AITraffic_rawTriggers
$L641:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AI_TrafficCleanUp__Fv
	.text
	.ent	AIInit_LoadConfigs__Fv
AIInit_LoadConfigs__Fv:
	.frame	$sp,128,$31		# vars= 104, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	addu	$4,$sp,16
	lui	$2,%hi(D_80116470) # high
	lui	$5,%hi(D_8005522C) # high
	lw	$6,%lo(D_80116470)($2)
	addiu	$5,$5,%lo(D_8005522C) # low
	sw	$31,124($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,120($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$5,%hi(trafcfg) # high
	addiu	$5,$5,%lo(trafcfg) # low
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AIInit_LoadPhysicsConfig__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	AIInit_LoadConfigs__Fv
	.text
	.ent	AIInit_LoadPhysicsConfig__FP10Udff_tInfo
AIInit_LoadPhysicsConfig__FP10Udff_tInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$16,%hi(AIPhysicConfig) # high
	sw	$2,%lo(AIPhysicConfig)($16)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	addiu	$16,$16,%lo(AIPhysicConfig) # low
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,4($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,8($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,12($16)
	.set	macro
	.set	reorder

	move	$18,$0
	sw	$2,16($16)
$L646:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L649
	lui	$2,%hi(AIPhysicConfig+64) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(AIPhysicConfig+20) # high
	.set	noreorder
	.set	nomacro
	j	$L650
	addiu	$16,$2,%lo(AIPhysicConfig+20) # low
	.set	macro
	.set	reorder

$L649:
	addiu	$16,$2,%lo(AIPhysicConfig+64) # low
$L650:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,4($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,8($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,12($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,16($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,20($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,28($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,32($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,36($16)
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sw	$2,40($16)
	slt	$2,$18,2
	bne	$2,$0,$L646
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

	.end	AIInit_LoadPhysicsConfig__FP10Udff_tInfo
	.text
	.ent	AIInit_ClearAICar__FP8Car_tObj
AIInit_ClearAICar__FP8Car_tObj:
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

	li	$2,1			# 0x00000001
	lw	$3,16($sp)
	lw	$7,20($sp)
	lw	$8,24($sp)
	sw	$3,276($16)
	sw	$7,280($16)
	sw	$8,284($16)
	sh	$0,380($16)
	sw	$0,1156($16)
	sw	$0,1160($16)
	sw	$0,1416($16)
	sw	$0,1408($16)
	sw	$2,1776($16)
	sw	$0,1780($16)
	sw	$0,1772($16)
	sw	$0,1864($16)
	sw	$0,1860($16)
	sw	$0,1876($16)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	AIInit_ClearAICar__FP8Car_tObj
	.text
	.ent	AIInit_RestartAICar__FP8Car_tObj
AIInit_RestartAICar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,D_8011321C
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L654:
	li	$5,1			# 0x00000001
	sw	$3,1364($4)
	sw	$3,1360($4)
	li	$3,65536			# 0x00010000
	sw	$0,1812($4)
	sw	$0,1808($4)
	sw	$0,1804($4)
	sw	$0,1800($4)
	sw	$0,1820($4)
	sw	$0,1824($4)
	sw	$0,1356($4)
	sw	$5,1776($4)
	sw	$0,1780($4)
	sw	$0,1772($4)
	sw	$0,1728($4)
	sw	$0,1368($4)
	sw	$0,1372($4)
	sw	$0,1376($4)
	sw	$0,1380($4)
	sw	$0,1384($4)
	sw	$0,1388($4)
	sw	$0,1396($4)
	sw	$0,1392($4)
	sw	$0,620($4)
	sw	$4,1400($4)
	sw	$0,1408($4)
	sw	$0,1416($4)
	sw	$0,1420($4)
	sw	$0,1424($4)
	sw	$0,1428($4)
	sw	$0,1828($4)
	sw	$0,1816($4)
	sw	$3,1852($4)
	sw	$3,1856($4)
	sw	$0,1332($4)
	sw	$0,1864($4)
	sw	$3,1868($4)
	sw	$3,1740($4)
	lw	$3,608($4)
	li	$2,6553600			# 0x00640000
	sw	$2,1736($4)
	li	$2,7			# 0x00000007
	sw	$0,1872($4)
	sw	$2,1732($4)
	sw	$0,1876($4)
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L655
	sw	$0,1880($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L656
	sw	$0,1884($4)
	.set	macro
	.set	reorder

$L655:
	sw	$5,1884($4)
$L656:
	lw	$2,608($4)
	li	$3,2			# 0x00000002
	andi	$2,$2,0x000a
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L657
	sw	$0,1860($4)
	.set	macro
	.set	reorder

	sb	$0,145($4)
$L657:
	li	$2,-1			# 0xffffffff
	sw	$2,1904($4)
	li	$2,65536			# 0x00010000
	sw	$0,1892($4)
	sw	$0,1896($4)
	sw	$0,1900($4)
	sw	$0,1908($4)
	sw	$2,1888($4)
	sw	$2,1912($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,1924($4)
	.set	macro
	.set	reorder

	.end	AIInit_RestartAICar__FP8Car_tObj
	.text
	.ent	AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$21,36($sp)
	li	$21,65536			# 0x00010000
	move	$4,$20
	sw	$31,40($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$18,1432
	li	$6,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	sw	$2,1412($18)
	.set	macro
	.set	reorder

	move	$17,$0
	li	$19,-4			# 0xfffffffc
	move	$16,$18
$L662:
	bne	$17,$0,$L663
	lw	$5,1432($18)
	.set	noreorder
	.set	nomacro
	jal	rdiv
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	sw	$2,1460($18)
	.set	macro
	.set	reorder

$L663:
	lw	$3,1432($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L665
	addu	$2,$18,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	sw	$0,1460($16)
	.set	macro
	.set	reorder

$L665:
	lw	$5,1432($2)
	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	rdiv
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	sw	$2,1460($16)
$L664:
	addu	$19,$19,4
	addu	$17,$17,1
	slt	$2,$17,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L662
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$16,$18,1488
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	li	$6,224			# 0x000000e0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$20
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,1404($18)
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,1832($18)
	.set	macro
	.set	reorder

	lw	$3,608($18)
	#nop
	andi	$3,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L668
	sw	$2,1836($18)
	.set	macro
	.set	reorder

	lw	$2,648($18)
	lui	$3,%hi(AITune_accelerationScale) # high
	lw	$2,0($2)
	addiu	$3,$3,%lo(AITune_accelerationScale) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$21,0($2)
$L668:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,92			# 0x0000005c
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$16
	move	$6,$21
	.set	noreorder
	.set	nomacro
	jal	__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
	li	$7,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$3,648($18)
	sw	$2,1712($18)
	lw	$4,0($3)
	jal	AIInit_IsNonStandardCarFile__Fi
	beq	$2,$0,$L669
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,88			# 0x00000058
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$18,576
	.set	noreorder
	.set	nomacro
	jal	__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
	li	$6,7			# 0x00000007
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L670
	sw	$2,1716($18)
	.set	macro
	.set	reorder

$L669:
	sw	$0,1716($18)
$L670:
	li	$5,65536			# 0x00010000
	lw	$4,1832($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$5,$5,0x3333
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,1832($18)
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,1724($18)
	.set	macro
	.set	reorder

	sw	$2,1848($18)
	li	$2,65536			# 0x00010000
	sw	$2,1888($18)
	sw	$0,1916($18)
	sw	$0,1920($18)
	sw	$2,1912($18)
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

	.end	AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
	.text
	.ent	AIInit_DeInitAICar__FP8Car_tObj
AIInit_DeInitAICar__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,1716($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L672
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,84($3)
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

	sw	$0,1716($16)
$L672:
	lw	$3,1712($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L671
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,84($3)
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

	sw	$0,1712($16)
$L671:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIInit_DeInitAICar__FP8Car_tObj
	.text
	.ent	AIInit_InitAICar2__FP8Car_tObj
AIInit_InitAICar2__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L675
	lw	$4,596($16)
	jal	AISpeeds_GetUpgradeHandlingMult__Fi
	lw	$4,1716($16)
	.set	noreorder
	.set	nomacro
	jal	Upgrade__30AIDataRecord_CurveSpeedTable_ti
	move	$5,$2
	.set	macro
	.set	reorder

$L675:
	lw	$4,596($16)
	jal	AISpeeds_GetUpgradeAccMult__Fi
	lw	$4,596($16)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetUpgradeTopSpeedMult__Fi
	sw	$2,1920($16)
	.set	macro
	.set	reorder

	sw	$2,1916($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIInit_InitAICar2__FP8Car_tObj
	.text
	.ent	AIInit_DeInitAICar2__FP8Car_tObj
AIInit_DeInitAICar2__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIInit_DeInitAICar2__FP8Car_tObj
	.text
	.ent	AIInit_IsNonStandardCarFile__Fi
AIInit_IsNonStandardCarFile__Fi:
	.frame	$sp,200,$31		# vars= 200, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	move	$3,$sp
	lui	$2,%hi(D_8005523C) # high
	addiu	$2,$2,%lo(D_8005523C) # low
	addu	$5,$2,192
$L678:
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	lw	$9,12($2)
	sw	$6,0($3)
	sw	$7,4($3)
	sw	$8,8($3)
	sw	$9,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L678
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$6,0($2)
	lw	$7,4($2)
	sw	$6,0($3)
	sw	$7,4($3)
	slt	$2,$4,50
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$sp,$2
	lw	$2,0($2)
	j	$L680
$L679:
	move	$2,$0
$L680:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	AIInit_IsNonStandardCarFile__Fi
