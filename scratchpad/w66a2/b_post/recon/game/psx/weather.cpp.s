	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\weather.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Weather_GetNumParticles__Fi
	.align	2
	.globl	Weather_SetMatrix__FP10matrixtdef
	.align	2
	.globl	Weather_SetIdentMatrix__Fv
	.align	2
	.globl	Weather_InitSnow__Fv
	.align	2
	.globl	Weather_InitRain__Fv
	.align	2
	.globl	Weather_InitSplats__Fv
	.align	2
	.globl	Weather_GetNewState__Fv
	.align	2
	.globl	Weather_ChangeDensityState__Fv
	.align	2
	.globl	Weather_ChangeIntensityState__Fv
	.align	2
	.globl	Weather_ChangeDensityBasedOnTime__Fv
	.align	2
	.globl	Weather_ChangeIntensityBasedOnTime__Fv
	.align	2
	.globl	Weather_InitStateControls__Fv
	.align	2
	.globl	Weather_Restart__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"raindrop\000"
	.align	2
$LC1:
	.ascii	"weather1\000"
	.align	2
$LC2:
	.ascii	"weather2\000"
	.align	2
$LC3:
	.ascii	"weather3\000"
	.text
	.align	2
	.globl	Weather_Init__Fv
	.align	2
	.globl	Weather_DeInit__Fv
	.align	2
	.globl	Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
	.align	2
	.globl	Weather_CheckAndResetParticles__FP7SVECTOR
	.rdata
	.align	2
$LC4:
	.word	0
	.word	65536
	.word	0
	.text
	.align	2
	.globl	Weather_QuickReOrthogonalize__FP10matrixtdefT0
	.align	2
	.globl	Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
	.align	2
	.globl	Weather_CreateSnow__FP7SVECTOR
	.align	2
	.globl	Weather_CreateRain__FP7SVECTORP7DVECTORPc
	.align	2
	.globl	Weather_CreateSplat__FP18Weather_tSplatInfo
	.align	2
	.globl	Weather_DoSplats__FiP18Weather_tSplatInfo
	.align	2
	.globl	Weather_DoWeather__FP13DRender_tView
	.align	2
	.globl	Weather_BuildWeather__FP13DRender_tView
	.globl	Weather_gWasDrawn
	.sdata
	.align	2
Weather_gWasDrawn:
	.space	4
	.globl	Weather_gPos
	.align	2
Weather_gPos:
	.space	4
	.globl	Weather_gSplatInfo
	.align	2
Weather_gSplatInfo:
	.space	4
	.globl	Weather_gPrevPos
	.align	2
Weather_gPrevPos:
	.space	4
	.globl	Weather_gTrackSpec
	.align	2
Weather_gTrackSpec:
	.space	4
	.globl	Weather_gType
	.align	2
Weather_gType:
	.space	4
	.globl	Weather_gDensityGoalState
	.align	2
Weather_gDensityGoalState:
	.space	4
	.globl	Weather_gIntensityGoalState
	.align	2
Weather_gIntensityGoalState:
	.space	4
	.globl	Weather_gDensityChangeFactor
	.align	2
Weather_gDensityChangeFactor:
	.space	4
	.globl	Weather_gIntensityChangeFactor
	.align	2
Weather_gIntensityChangeFactor:
	.space	4
	.globl	Weather_gDensityTimerGoal
	.align	2
Weather_gDensityTimerGoal:
	.space	4
	.globl	Weather_gIntensityTimerGoal
	.align	2
Weather_gIntensityTimerGoal:
	.space	4
	.globl	Weather_gSnowTrack
	.align	2
Weather_gSnowTrack:
	.space	4
	.globl	Weather_gTrackIntensityLimit
	.align	2
Weather_gTrackIntensityLimit:
	.space	4
	.globl	gCurrentNumSplats
	.align	2
gCurrentNumSplats:
	.space	4
	.globl	timechange
	.align	2
timechange:
	.space	4
	.globl	Weather_gLastProcessTime
	.align	2
Weather_gLastProcessTime:
	.space	4
	.globl	Weather_gLastProcessTime1
	.align	2
Weather_gLastProcessTime1:
	.space	4
	.globl	Weather_gSplatInfoServer
	.align	2
Weather_gSplatInfoServer:
	.space	4
	.globl	Weather_gSplatInfoServer1
	.align	2
Weather_gSplatInfoServer1:
	.space	4
	.globl	Weather_gPServer
	.align	2
Weather_gPServer:
	.space	4
	.globl	Weather_gPServer1
	.align	2
Weather_gPServer1:
	.space	4
	.globl	Weather_gPrevPServer
	.align	2
Weather_gPrevPServer:
	.space	4
	.globl	Weather_gPrevPServer1
	.align	2
Weather_gPrevPServer1:
	.space	4
	.globl	Weather_gDrawnServer
	.align	2
Weather_gDrawnServer:
	.space	4
	.globl	Weather_gDrawnServer1
	.align	2
Weather_gDrawnServer1:
	.space	4

	.lcomm	prevCameraMode,8

	.lcomm	prevLookBehind,8

	.extern	Input_gLookBehind, 8
	.extern	gWeatherPixmap, 12
	.extern	Weather_gRandomVelocityVectors, 36
	.extern	Camera_gInfo, 544
	.extern	prevCamPos, 24
	.extern	prevCamMat, 72
	.extern	TrackSpec_gSpec, 264
	.extern	Weather_gTrackIntensityLimitTbl, 64
	.extern	Weather_gIntensityTbl, 16
	.extern	Weather_gDensityTbl, 16
	.extern	simGlobal, 24
	.extern	GameSetup_gData, 2600
	.extern	Weather_gSys, 36

	.text
	.text
	.ent	Weather_GetNumParticles__Fi
Weather_GetNumParticles__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Weather_gSys) # high
	lw	$2,%lo(Weather_gSys)($2)
	j	$31
	.end	Weather_GetNumParticles__Fi
	.text
	.ent	Weather_SetMatrix__FP10matrixtdef
Weather_SetMatrix__FP10matrixtdef:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$2,0($4)
	lw	$3,12($4)
	lw	$5,24($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$5,$5,4
	sh	$2,0($sp)
	sh	$3,2($sp)
	sh	$5,4($sp)
	lw	$2,4($4)
	lw	$3,16($4)
	lw	$5,28($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$5,$5,4
	sh	$2,6($sp)
	sh	$3,8($sp)
	sh	$5,10($sp)
	lw	$2,8($4)
	lw	$3,20($4)
	lw	$4,32($4)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,12($sp)
	sh	$3,14($sp)
	sh	$4,16($sp)
 #APP
	lw   $12, 0($sp)
	lw   $13, 4($sp)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($sp)
	lw   $13, 12($sp)
	lw   $14, 16($sp)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($sp)
	lw   $13, 24($sp)
	ctc2 $12, $5
	lw   $14, 28($sp)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Weather_SetMatrix__FP10matrixtdef
	.text
	.ent	Weather_SetIdentMatrix__Fv
Weather_SetIdentMatrix__Fv:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$3,4096			# 0x00001000
	li	$2,-4096			# 0xfffff000
	sh	$3,0($sp)
	sh	$0,2($sp)
	sh	$0,4($sp)
	sh	$0,6($sp)
	sh	$2,8($sp)
	sh	$0,10($sp)
	sh	$0,12($sp)
	sh	$0,14($sp)
	sh	$3,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
 #APP
	lw   $12, 0($sp)
	lw   $13, 4($sp)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($sp)
	lw   $13, 12($sp)
	lw   $14, 16($sp)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($sp)
	lw   $13, 24($sp)
	ctc2 $12, $5
	lw   $14, 28($sp)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Weather_SetIdentMatrix__Fv
	.text
	.ent	Weather_InitSnow__Fv
Weather_InitSnow__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Weather_gSys) # high
	li	$3,150			# 0x00000096
	sw	$3,%lo(Weather_gSys)($2)
	addiu	$2,$2,%lo(Weather_gSys) # low
	li	$3,640			# 0x00000280
	sh	$3,32($2)
	li	$3,320			# 0x00000140
	sh	$3,20($2)
	li	$3,1600			# 0x00000640
	li	$4,1280			# 0x00000500
	sh	$3,22($2)
	li	$3,-320			# 0xfffffec0
	sh	$3,26($2)
	li	$3,960			# 0x000003c0
	sh	$3,28($2)
	li	$3,-18			# 0xffffffee
	sh	$3,10($2)
	li	$3,160			# 0x000000a0
	sh	$4,24($2)
	sh	$4,30($2)
	sh	$0,8($2)
	sh	$0,12($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,16($2)
	.set	macro
	.set	reorder

	.end	Weather_InitSnow__Fv
	.text
	.ent	Weather_InitRain__Fv
Weather_InitRain__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Weather_gSys) # high
	li	$3,150			# 0x00000096
	sw	$3,%lo(Weather_gSys)($2)
	addiu	$2,$2,%lo(Weather_gSys) # low
	li	$4,1088			# 0x00000440
	li	$3,384			# 0x00000180
	sh	$3,20($2)
	li	$3,2560			# 0x00000a00
	sh	$3,22($2)
	li	$3,2176			# 0x00000880
	sh	$3,24($2)
	li	$3,-320			# 0xfffffec0
	sh	$3,26($2)
	li	$3,1408			# 0x00000580
	sh	$3,30($2)
	li	$3,-104			# 0xffffff98
	sh	$3,10($2)
	li	$3,160			# 0x000000a0
	sh	$4,32($2)
	sh	$4,28($2)
	sh	$0,8($2)
	sh	$0,12($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,16($2)
	.set	macro
	.set	reorder

	.end	Weather_InitRain__Fv
	.text
	.ent	Weather_InitSplats__Fv
Weather_InitSplats__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$0
	lui	$2,%hi(GameSetup_gData) # high
	sw	$20,32($sp)
	addiu	$20,$2,%lo(GameSetup_gData) # low
	sw	$19,28($sp)
	li	$19,1			# 0x00000001
	sw	$31,36($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L608:
	slt	$2,$18,19
	beq	$2,$0,$L607
	lw	$2,12($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L610
	li	$17,240			# 0x000000f0
	.set	macro
	.set	reorder

	li	$17,120			# 0x00000078
$L610:
	.set	noreorder
	.set	nomacro
	jal	random
	sll	$16,$18,3
	.set	macro
	.set	reorder

	li	$3,-858993459			# 0xcccccccd
	multu	$2,$3
	lw	$5,Weather_gSplatInfo
	#nop
	addu	$5,$16,$5
	mfhi	$3
	#nop
	#nop
	srl	$4,$3,8
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,6
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,0($5)
	.set	macro
	.set	reorder

	remu	$3,$2,$17
	lw	$2,Weather_gSplatInfo
	#nop
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,2($2)
	.set	macro
	.set	reorder

	li	$3,458096640			# 0x1b4e0000
	ori	$3,$3,0x81b5
	multu	$2,$3
	lw	$3,Weather_gSplatInfo
	addu	$18,$18,1
	addu	$16,$16,$3
	mfhi	$4
	#nop
	#nop
	srl	$3,$4,5
	sll	$4,$3,2
	addu	$4,$4,$3
	sll	$3,$4,4
	subu	$3,$3,$4
	sll	$3,$3,2
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L608
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L607:
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

	.end	Weather_InitSplats__Fv
	.text
	.ent	Weather_GetNewState__Fv
Weather_GetNewState__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	random
	andi	$4,$2,0x0003
	slt	$2,$4,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	move	$2,$0
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L616
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L614:
$L616:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_GetNewState__Fv
	.text
	.ent	Weather_ChangeDensityState__Fv
Weather_ChangeDensityState__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Weather_GetNewState__Fv
	lw	$3,Weather_gDensityGoalState
	move	$4,$2
	addu	$3,$3,$4
	slt	$2,$3,4
	bne	$2,$0,$L618
	.set	noreorder
	.set	nomacro
	j	$L619
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L618:
	bgez	$3,$L619
	li	$4,1			# 0x00000001
$L619:
	lw	$2,Weather_gDensityGoalState
	sw	$4,Weather_gDensityChangeFactor
	addu	$2,$2,$4
	sw	$2,Weather_gDensityGoalState
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L617
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	addu	$2,$2,1024
	sw	$2,Weather_gDensityTimerGoal
$L617:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_ChangeDensityState__Fv
	.text
	.ent	Weather_ChangeIntensityState__Fv
Weather_ChangeIntensityState__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Weather_GetNewState__Fv
	move	$4,$2
	lw	$3,Weather_gIntensityGoalState
	lw	$2,Weather_gTrackIntensityLimit
	addu	$3,$3,$4
	slt	$2,$2,$3
	beq	$2,$0,$L623
	.set	noreorder
	.set	nomacro
	j	$L624
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L623:
	bgez	$3,$L624
	li	$4,1			# 0x00000001
$L624:
	lw	$2,Weather_gIntensityGoalState
	sw	$4,Weather_gIntensityChangeFactor
	addu	$2,$2,$4
	sw	$2,Weather_gIntensityGoalState
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L622
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	addu	$2,$2,1024
	sw	$2,Weather_gIntensityTimerGoal
$L622:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_ChangeIntensityState__Fv
	.text
	.ent	Weather_ChangeDensityBasedOnTime__Fv
Weather_ChangeDensityBasedOnTime__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Weather_gDensityChangeFactor
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	blez	$2,$L629
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(Weather_gSys) # high
	lui	$2,%hi(Weather_gDensityTbl) # high
	lw	$3,Weather_gDensityGoalState
	addiu	$2,$2,%lo(Weather_gDensityTbl) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,%lo(Weather_gSys)($4)
	lw	$3,0($3)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L632
	j	$L639
$L629:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L634
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(Weather_gSys) # high
	lui	$3,%hi(Weather_gDensityTbl) # high
	lw	$2,Weather_gDensityGoalState
	addiu	$3,$3,%lo(Weather_gDensityTbl) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,%lo(Weather_gSys)($4)
	lw	$2,0($2)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L632
	j	$L631
$L634:
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,Weather_gDensityTimerGoal
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	lui	$4,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

$L632:
	jal	Weather_ChangeDensityState__Fv
	lui	$4,%hi(Weather_gSys) # high
$L631:
$L639:
	lw	$2,%lo(Weather_gSys)($4)
	lw	$3,Weather_gDensityChangeFactor
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L627
	sw	$2,%lo(Weather_gSys)($4)
	.set	macro
	.set	reorder

	sw	$0,%lo(Weather_gSys)($4)
$L627:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_ChangeDensityBasedOnTime__Fv
	.text
	.ent	Weather_ChangeIntensityBasedOnTime__Fv
Weather_ChangeIntensityBasedOnTime__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Weather_gIntensityChangeFactor
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	blez	$2,$L642
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(Weather_gSys+10) # high
	lui	$2,%hi(Weather_gIntensityTbl) # high
	lw	$3,Weather_gIntensityGoalState
	addiu	$2,$2,%lo(Weather_gIntensityTbl) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lh	$2,%lo(Weather_gSys+10)($4)
	lw	$3,0($3)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

 #APP
	
 #NO_APP
	j	$L645
$L642:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L647
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(Weather_gSys+10) # high
	lui	$3,%hi(Weather_gIntensityTbl) # high
	lw	$2,Weather_gIntensityGoalState
	addiu	$3,$3,%lo(Weather_gIntensityTbl) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lh	$3,%lo(Weather_gSys+10)($4)
	lw	$2,0($2)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

	j	$L645
$L647:
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,Weather_gIntensityTimerGoal
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

$L645:
	jal	Weather_ChangeIntensityState__Fv
	lui	$2,%hi(Weather_gSys) # high
$L653:
	addiu	$2,$2,%lo(Weather_gSys) # low
	lhu	$3,10($2)
	lhu	$4,Weather_gIntensityChangeFactor
	#nop
	addu	$3,$3,$4
	sh	$3,10($2)
	sll	$3,$3,16
	sra	$3,$3,16
	slt	$3,$3,-32
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L650
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,Weather_gType
	j	$L640
$L650:
	sw	$0,Weather_gType
$L640:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_ChangeIntensityBasedOnTime__Fv
	.text
	.ent	Weather_InitStateControls__Fv
Weather_InitStateControls__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lui	$3,%hi(Weather_gTrackIntensityLimitTbl) # high
	lw	$4,%lo(GameSetup_gData+60)($2)
	addiu	$3,$3,%lo(Weather_gTrackIntensityLimitTbl) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,Weather_gTrackIntensityLimit
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L656
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L655
	lui	$3,%hi(Weather_gIntensityTbl) # high
	.set	macro
	.set	reorder

$L656:
	li	$2,1			# 0x00000001
	sw	$2,Weather_gSnowTrack
	li	$2,3			# 0x00000003
	sw	$2,Weather_gIntensityGoalState
	.set	noreorder
	.set	nomacro
	j	$L661
	lui	$3,%hi(Weather_gIntensityTbl) # high
	.set	macro
	.set	reorder

$L655:
	sw	$0,Weather_gSnowTrack
	sw	$0,Weather_gIntensityGoalState
$L661:
	lw	$4,Weather_gIntensityGoalState
	addiu	$3,$3,%lo(Weather_gIntensityTbl) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lhu	$3,0($2)
	lui	$2,%hi(Weather_gSys+10) # high
	sh	$3,%lo(Weather_gSys+10)($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L658
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$0,Weather_gType
	.set	noreorder
	.set	nomacro
	j	$L662
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

$L658:
	sw	$2,Weather_gType
	lui	$2,%hi(simGlobal+4) # high
$L662:
	lw	$5,%lo(simGlobal+4)($2)
	li	$2,3			# 0x00000003
	sw	$2,Weather_gDensityGoalState
	lui	$2,%hi(Weather_gDensityTbl+12) # high
	lw	$3,%lo(Weather_gDensityTbl+12)($2)
	lui	$2,%hi(Weather_gSys) # high
	sw	$0,Weather_gIntensityChangeFactor
	sw	$0,Weather_gDensityChangeFactor
	addu	$4,$5,1024
	sw	$4,Weather_gIntensityTimerGoal
	sw	$3,%lo(Weather_gSys)($2)
	sw	$4,Weather_gDensityTimerGoal
	sw	$5,timechange
	j	$31
	.end	Weather_InitStateControls__Fv
	.text
	.ent	Weather_Restart__Fv
Weather_Restart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	sw	$31,16($sp)
	lw	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L671
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	jal	Weather_InitStateControls__Fv
	lui	$2,%hi(simGlobal+4) # high
$L671:
	lw	$2,%lo(simGlobal+4)($2)
	move	$3,$0
	sw	$2,Weather_gLastProcessTime1
	sw	$2,Weather_gLastProcessTime
$L666:
	lw	$2,Weather_gWasDrawn
	#nop
	addu	$2,$2,$3
	addu	$3,$3,1
	sb	$0,0($2)
	slt	$2,$3,152
	bne	$2,$0,$L666
$L663:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_Restart__Fv
	.text
	.ent	Weather_Init__Fv
Weather_Init__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$4,%hi(TrackSpec_gSpec+32) # high
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$3,%lo(GameSetup_gData+72)($2)
	addiu	$2,$4,%lo(TrackSpec_gSpec+32) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$2,Weather_gTrackSpec
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$Lfaddr3_672
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,%lo(TrackSpec_gSpec+32)($4)
	#nop
	sw	$3,Weather_gType
	bne	$3,$2,$Lfaddr3_674
	jal	Weather_InitRain__Fv
	j	$Lfaddr3_675
$Lfaddr3_674:
	bne	$3,$0,$Lfaddr3_675
	jal	Weather_InitSnow__Fv
$Lfaddr3_675:
	lw	$2,Weather_gSplatInfo
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lfaddr3_677
	lui	$4,%hi($LC0) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC0) # low
	li	$5,168			# 0x000000a8
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Weather_gSplatInfo
$Lfaddr3_677:
	lw	$2,Weather_gPos
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lfaddr3_678
	lui	$4,%hi($LC1) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC1) # low
	li	$5,1216			# 0x000004c0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Weather_gPos
$Lfaddr3_678:
	lw	$2,Weather_gPrevPos
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lfaddr3_679
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC2) # low
	li	$5,608			# 0x00000260
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Weather_gPrevPos
$Lfaddr3_679:
	lw	$2,Weather_gWasDrawn
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lfaddr3_696
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,152			# 0x00000098
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Weather_gWasDrawn
	lui	$2,%hi(simGlobal+4) # high
$Lfaddr3_696:
	lw	$2,%lo(simGlobal+4)($2)
	lw	$4,Weather_gPos
	lw	$5,Weather_gPrevPos
	lw	$6,Weather_gWasDrawn
	lw	$7,Weather_gSplatInfo
	sw	$2,Weather_gLastProcessTime1
	sw	$2,Weather_gLastProcessTime
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$4,Weather_gPServer
	sw	$5,Weather_gPrevPServer
	sw	$6,Weather_gDrawnServer
	sw	$7,Weather_gSplatInfoServer
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$Lfaddr3_697
	lui	$2,%hi(prevCamMat) # high
	.set	macro
	.set	reorder

	addu	$2,$4,608
	sw	$2,Weather_gPServer1
	addu	$2,$5,304
	sw	$2,Weather_gPrevPServer1
	addu	$2,$6,76
	sw	$2,Weather_gDrawnServer1
	lui	$2,%hi(Weather_gSys) # high
	li	$3,76			# 0x0000004c
	sw	$3,%lo(Weather_gSys)($2)
	addiu	$2,$2,%lo(Weather_gSys) # low
	sw	$3,4($2)
	addu	$2,$7,72
	sw	$2,Weather_gSplatInfoServer1
	lui	$2,%hi(prevCamMat) # high
$Lfaddr3_697:
	addiu	$7,$2,%lo(prevCamMat) # low
	move	$9,$7
	move	$6,$7
	lui	$2,%hi(Camera_gInfo) # high
	addiu	$2,$2,%lo(Camera_gInfo) # low
	addu	$5,$2,48
	addu	$8,$2,80
	lui	$4,%hi(prevCamPos) # high
	addiu	$3,$4,%lo(prevCamPos) # low
	lw	$10,8($2)
	lw	$11,12($2)
	lw	$12,16($2)
	sw	$10,12($3)
	sw	$11,16($3)
	sw	$12,20($3)
	addiu	$13,$4,%lo(prevCamPos)
	lw	$10,12($3)
	lw	$11,16($3)
	lw	$12,20($3)
	sw	$10,0($13)
	sw	$11,4($13)
	sw	$12,8($13)
$Lfaddr3_682:
	lw	$10,0($5)
	lw	$11,4($5)
	lw	$12,8($5)
	lw	$13,12($5)
	sw	$10,0($6)
	sw	$11,4($6)
	sw	$12,8($6)
	sw	$13,12($6)
	addu	$5,$5,16
	.set	noreorder
	.set	nomacro
	bne	$5,$8,$Lfaddr3_682
	addu	$6,$6,16
	.set	macro
	.set	reorder

	lw	$10,0($5)
	sw	$10,0($6)
	addu	$4,$9,36
	move	$3,$7
	addu	$2,$3,32
$Lfaddr3_683:
	lw	$10,0($3)
	lw	$11,4($3)
	lw	$12,8($3)
	lw	$13,12($3)
	sw	$10,0($4)
	sw	$11,4($4)
	sw	$12,8($4)
	sw	$13,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$Lfaddr3_683
	addu	$4,$4,16
	.set	macro
	.set	reorder

	li	$16,151			# 0x00000097
	lui	$2,%hi(Weather_gSys) # high
	lw	$18,Weather_gPos
	addiu	$19,$2,%lo(Weather_gSys) # low
	lw	$10,0($3)
	sw	$10,0($4)
	addu	$17,$18,4
$Lfaddr3_684:
	.set	noreorder
	.set	nomacro
	jal	random
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	lh	$3,32($19)
	#nop
	remu	$3,$2,$3
	lhu	$2,32($19)
	sll	$3,$3,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,0($18)
	.set	macro
	.set	reorder

	lh	$3,30($19)
	#nop
	remu	$3,$2,$3
	lhu	$2,26($19)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,-2($17)
	.set	macro
	.set	reorder

	lh	$3,24($19)
	#nop
	remu	$3,$2,$3
	lhu	$2,20($19)
	addu	$18,$18,8
	addu	$2,$2,$3
	sh	$2,0($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$Lfaddr3_684
	addu	$17,$17,8
	.set	macro
	.set	reorder

	move	$16,$0
$Lfaddr3_691:
	lw	$2,Weather_gWasDrawn
	#nop
	addu	$2,$2,$16
	addu	$16,$16,1
	sb	$0,0($2)
	slt	$2,$16,152
	bne	$2,$0,$Lfaddr3_691
	sw	$0,gCurrentNumSplats
	jal	Weather_InitSplats__Fv
$Lfaddr3_672:
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

	.end	Weather_Init__Fv
	.text
	.ent	Weather_DeInit__Fv
Weather_DeInit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$4,Weather_gSplatInfo
	#nop
	beq	$4,$0,$L700
	jal	purgememadr
$L700:
	lw	$4,Weather_gPos
	#nop
	beq	$4,$0,$L701
	jal	purgememadr
$L701:
	lw	$4,Weather_gPrevPos
	#nop
	beq	$4,$0,$L702
	jal	purgememadr
$L702:
	lw	$4,Weather_gWasDrawn
	#nop
	beq	$4,$0,$L703
	jal	purgememadr
$L703:
	sw	$0,Weather_gSplatInfo
	sw	$0,Weather_gPos
	sw	$0,Weather_gPrevPos
	sw	$0,Weather_gWasDrawn
$L698:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_DeInit__Fv
	.text
	.ent	Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
Weather_TransformVertex__FP10matrixtdefiP7SVECTOR:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$5
	sw	$16,32($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Weather_SetMatrix__FP10matrixtdef
	move	$16,$6
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($16)
	lwc2 $1, 4($16)
	nop
	nop
	.word 1246232594
 #NO_APP
	addu	$17,$17,-1
	addu	$2,$sp,16
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	li	$7,-1			# 0xffffffff
	move	$6,$2
$L706:
	addu	$17,$17,-1
	.set	noreorder
	.set	nomacro
	beq	$17,$7,$L707
	addu	$5,$16,8
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($5)
	lwc2 $1, 4($5)
	nop
	nop
	.word 1246232594
 #NO_APP
	lw	$2,16($sp)
	lw	$3,20($sp)
	lw	$4,24($sp)
	sh	$2,0($16)
	sh	$3,2($16)
	sh	$4,4($16)
 #APP
	swc2 $25, 0($6)
	swc2 $26, 4($6)
	swc2 $27, 8($6)
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L706
	move	$16,$5
	.set	macro
	.set	reorder

$L707:
	lw	$2,16($sp)
	lw	$3,20($sp)
	lw	$4,24($sp)
	sh	$2,0($16)
	sh	$3,2($16)
	sh	$4,4($16)
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

	.end	Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
	.text
	.ent	Weather_CheckAndResetParticles__FP7SVECTOR
Weather_CheckAndResetParticles__FP7SVECTOR:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	lui	$2,%hi(Weather_gSys) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(Weather_gSys) # low
	sw	$16,16($sp)
	sw	$31,28($sp)
	lh	$5,0($18)
	lh	$4,32($17)
	lhu	$3,32($17)
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L712
	move	$16,$0
	.set	macro
	.set	reorder

	subu	$2,$0,$3
	addu	$2,$2,64
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,0($18)
	.set	macro
	.set	reorder

	lh	$3,30($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,26($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,2($18)
	.set	macro
	.set	reorder

	lh	$3,24($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,20($17)
	.set	noreorder
	.set	nomacro
	j	$L735
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L712:
	subu	$2,$0,$4
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L715
	addu	$2,$3,-64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,0($18)
	.set	macro
	.set	reorder

	lh	$3,30($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,26($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,2($18)
	.set	macro
	.set	reorder

	lh	$3,24($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,20($17)
	li	$16,2			# 0x00000002
$L735:
	addu	$2,$2,$3
	sh	$2,4($18)
$L715:
	lui	$2,%hi(Weather_gSys) # high
	addiu	$17,$2,%lo(Weather_gSys) # low
	lh	$3,4($18)
	lh	$2,22($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L719
	lhu	$2,20($17)
	#nop
	addu	$2,$2,64
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,4($18)
	.set	macro
	.set	reorder

	lh	$3,32($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,32($17)
	sll	$3,$3,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,0($18)
	.set	macro
	.set	reorder

	lh	$3,30($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,26($17)
	.set	noreorder
	.set	nomacro
	j	$L736
	li	$16,3			# 0x00000003
	.set	macro
	.set	reorder

$L719:
	lh	$2,20($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L738
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	random
	li	$16,4			# 0x00000004
	.set	macro
	.set	reorder

	lhu	$3,22($17)
	#nop
	sll	$3,$3,16
	sra	$4,$3,16
	srl	$3,$3,31
	addu	$4,$4,$3
	sra	$4,$4,1
	remu	$3,$2,$4
	lhu	$2,20($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,4($18)
	.set	macro
	.set	reorder

	lh	$3,32($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,32($17)
	sll	$3,$3,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,0($18)
	.set	macro
	.set	reorder

	lh	$3,30($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,26($17)
$L736:
	addu	$2,$2,$3
	sh	$2,2($18)
	lui	$2,%hi(Weather_gSys) # high
$L738:
	addiu	$17,$2,%lo(Weather_gSys) # low
	lh	$4,2($18)
	lh	$2,28($17)
	lhu	$3,28($17)
	slt	$2,$2,$4
	beq	$2,$0,$L727
	lhu	$2,26($17)
	#nop
	addu	$2,$2,64
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,2($18)
	.set	macro
	.set	reorder

	lh	$3,32($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,32($17)
	sll	$3,$3,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,0($18)
	.set	macro
	.set	reorder

	lh	$3,24($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,20($17)
	.set	noreorder
	.set	nomacro
	j	$L737
	li	$16,5			# 0x00000005
	.set	macro
	.set	reorder

$L727:
	lh	$2,26($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	addu	$2,$3,-64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,2($18)
	.set	macro
	.set	reorder

	lh	$3,32($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,32($17)
	sll	$3,$3,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$3,0($18)
	.set	macro
	.set	reorder

	lh	$3,24($17)
	#nop
	remu	$3,$2,$3
	lhu	$2,20($17)
	li	$16,6			# 0x00000006
$L737:
	addu	$2,$2,$3
	sh	$2,4($18)
$L730:
	move	$2,$16
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

	.end	Weather_CheckAndResetParticles__FP7SVECTOR
	.text
	.ent	Weather_QuickReOrthogonalize__FP10matrixtdefT0
Weather_QuickReOrthogonalize__FP10matrixtdefT0:
	.frame	$sp,72,$31		# vars= 16, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$21,52($sp)
	move	$21,$4
	sw	$20,48($sp)
	move	$20,$5
	sw	$19,44($sp)
	addu	$19,$20,24
	move	$4,$19
	lui	$2,%hi($LC4) # high
	sw	$23,60($sp)
	addu	$23,$21,12
	sw	$18,40($sp)
	sw	$31,64($sp)
	sw	$22,56($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	addiu	$8,$2,%lo($LC4)
	lw	$3,0($8)
	lw	$6,4($8)
	lw	$7,8($8)
	sw	$3,16($sp)
	sw	$6,20($sp)
	sw	$7,24($sp)
	lw	$3,24($21)
	lw	$6,28($21)
	lw	$7,32($21)
	sw	$3,24($20)
	sw	$6,28($20)
	sw	$7,32($20)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	addu	$18,$21,24
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,24($21)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$22,$20,12
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	blez	$16,$L741
	lw	$4,16($sp)
	lw	$5,24($21)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	j	$L744
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L741:
	lw	$4,16($sp)
	lw	$5,24($21)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	subu	$16,$0,$16
$L744:
	li	$2,64880			# 0x0000fd70
	slt	$16,$2,$16
	beq	$16,$0,$L740
	lw	$3,0($23)
	lw	$6,4($23)
	lw	$7,8($23)
	sw	$3,16($sp)
	sw	$6,20($sp)
	sw	$7,24($sp)
$L740:
	lw	$4,20($sp)
	lw	$5,8($19)
	jal	fixedmult
	lw	$4,24($sp)
	lw	$5,4($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,0($20)
	lw	$4,24($sp)
	lw	$5,0($19)
	jal	fixedmult
	lw	$4,16($sp)
	lw	$5,8($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,4($20)
	lw	$4,16($sp)
	lw	$5,4($19)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$20
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	sw	$16,8($20)
	.set	macro
	.set	reorder

	lw	$4,4($19)
	lw	$5,8($20)
	jal	fixedmult
	lw	$4,8($19)
	lw	$5,4($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,0($22)
	lw	$4,8($19)
	lw	$5,0($20)
	jal	fixedmult
	lw	$4,0($19)
	lw	$5,8($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,4($22)
	lw	$4,0($19)
	lw	$5,4($20)
	jal	fixedmult
	lw	$4,4($19)
	lw	$5,0($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,8($22)
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

	.end	Weather_QuickReOrthogonalize__FP10matrixtdefT0
	.text
	.ent	Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc:
	.frame	$sp,264,$31		# vars= 216, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,264
	sw	$19,244($sp)
	move	$19,$4
	sw	$20,248($sp)
	move	$20,$5
	sw	$21,252($sp)
	move	$21,$6
	sw	$22,256($sp)
	move	$22,$7
	sw	$18,240($sp)
	addu	$18,$19,104
	move	$4,$18
	sw	$17,236($sp)
	addu	$17,$sp,56
	move	$5,$17
	sw	$31,260($sp)
	.set	noreorder
	.set	nomacro
	jal	Weather_QuickReOrthogonalize__FP10matrixtdefT0
	sw	$16,232($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	addu	$6,$sp,16
	lui	$16,%hi(prevCamMat) # high
	lw	$2,4($19)
	addiu	$16,$16,%lo(prevCamMat) # low
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	addu	$4,$4,$16
	.set	macro
	.set	reorder

	lw	$2,4($19)
	move	$4,$17
	sll	$5,$2,3
	addu	$5,$5,$2
	sll	$5,$5,2
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	Weather_TransformVertex__FP10matrixtdefiP7SVECTOR
	move	$6,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Weather_SetMatrix__FP10matrixtdef
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(prevCamPos) # high
	lw	$3,4($19)
	addiu	$5,$2,%lo(prevCamPos) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,8($19)
	lw	$2,0($2)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L746
	addu	$4,$19,8
	.set	macro
	.set	reorder

	addu	$2,$2,1023
$L746:
	sra	$2,$2,10
	sh	$2,112($sp)
	lw	$3,4($19)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,4($4)
	lw	$2,4($2)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L747
	addu	$2,$2,1023
$L747:
	sra	$2,$2,10
	sh	$2,114($sp)
	lw	$3,4($19)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,8($4)
	lw	$2,8($2)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L748
	addu	$2,$2,1023
$L748:
	sra	$2,$2,10
	addu	$7,$sp,112
	sh	$2,116($sp)
 #APP
	lwc2 $0, 0($7)
	lwc2 $1, 4($7)
	nop
	nop
	.word 1246232594
 #NO_APP
	lw	$3,4($19)
	addu	$6,$sp,120
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$12,8($19)
	lw	$13,12($19)
	lw	$14,16($19)
	sw	$12,0($2)
	sw	$13,4($2)
	sw	$14,8($2)
 #APP
	swc2 $25, 0($6)
	swc2 $26, 4($6)
	swc2 $27, 8($6)
 #NO_APP
	lhu	$2,120($sp)
	lhu	$3,124($sp)
	subu	$2,$0,$2
	subu	$3,$0,$3
	sh	$3,106($sp)
	lui	$3,%hi(Weather_gSys+8) # high
	addiu	$4,$3,%lo(Weather_gSys+8) # low
	sh	$2,104($sp)
	lhu	$2,128($sp)
	lhu	$3,%lo(Weather_gSys+8)($3)
	lhu	$5,2($4)
	lhu	$4,4($4)
	subu	$2,$0,$2
	sh	$2,108($sp)
	sh	$3,112($sp)
	sh	$5,114($sp)
	sh	$4,116($sp)
 #APP
	lwc2 $0, 0($7)
	lwc2 $1, 4($7)
	nop
	nop
	.word 1246232594
	swc2 $25, 0($6)
	swc2 $26, 4($6)
	swc2 $27, 8($6)
 #NO_APP
	move	$10,$0
	move	$11,$6
	addu	$9,$sp,136
	lui	$3,%hi(Weather_gRandomVelocityVectors) # high
	addiu	$8,$3,%lo(Weather_gRandomVelocityVectors) # low
	lhu	$4,120($sp)
	lhu	$5,124($sp)
	lhu	$6,128($sp)
	lhu	$2,104($sp)
	lhu	$3,108($sp)
	addu	$2,$2,$4
	sh	$2,104($sp)
	lhu	$2,106($sp)
	addu	$3,$3,$6
	sh	$4,96($sp)
	sh	$5,98($sp)
	sh	$6,100($sp)
	sh	$3,108($sp)
	addu	$2,$2,$5
	sh	$2,106($sp)
$L751:
	slt	$2,$10,12
	beq	$2,$0,$L750
	lbu	$2,0($8)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,112($sp)
	lbu	$2,1($8)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,114($sp)
	lbu	$2,2($8)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,116($sp)
 #APP
	lwc2 $0, 0($7)
	lwc2 $1, 4($7)
	nop
	nop
	.word 1246232594
	swc2 $25, 0($11)
	swc2 $26, 4($11)
	swc2 $27, 8($11)
 #NO_APP
	lhu	$2,120($sp)
	#nop
	sh	$2,0($9)
	lhu	$2,124($sp)
	addu	$8,$8,3
	sh	$2,2($9)
	lhu	$2,128($sp)
	addu	$10,$10,1
	sh	$2,4($9)
	.set	noreorder
	.set	nomacro
	j	$L751
	addu	$9,$9,8
	.set	macro
	.set	reorder

$L750:
	move	$18,$21
	move	$16,$0
	addu	$17,$18,4
$L756:
	slt	$2,$16,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	li	$2,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xaaab
	mult	$16,$2
	addu	$4,$sp,112
	sra	$2,$16,31
	addu	$6,$sp,136
	lhu	$5,104($sp)
	mfhi	$12
	#nop
	#nop
	sra	$3,$12,1
	subu	$3,$3,$2
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$16,$2
	sll	$2,$2,3
	addu	$6,$6,$2
	lhu	$3,0($18)
	lhu	$2,0($6)
	addu	$3,$3,$5
	addu	$2,$2,$3
	sh	$2,112($sp)
	lhu	$3,-2($17)
	lhu	$5,106($sp)
	lhu	$2,2($6)
	addu	$3,$3,$5
	addu	$2,$2,$3
	sh	$2,114($sp)
	lhu	$3,0($17)
	lhu	$5,108($sp)
	lhu	$2,4($6)
	addu	$3,$3,$5
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Weather_CheckAndResetParticles__FP7SVECTOR
	sh	$2,116($sp)
	.set	macro
	.set	reorder

	lw	$3,112($sp)
	sll	$2,$2,16
	sw	$3,0($18)
	lhu	$3,116($sp)
	addu	$18,$18,8
	sh	$3,0($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	addu	$17,$17,8
	.set	macro
	.set	reorder

	addu	$2,$22,$16
	sb	$0,0($2)
$L758:
	.set	noreorder
	.set	nomacro
	j	$L756
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L760:
	lw	$31,260($sp)
	lw	$22,256($sp)
	lw	$21,252($sp)
	lw	$20,248($sp)
	lw	$19,244($sp)
	lw	$18,240($sp)
	lw	$17,236($sp)
	lw	$16,232($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,264
	.set	macro
	.set	reorder

	.end	Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
	.text
	.ent	Weather_CreateSnow__FP7SVECTOR
Weather_CreateSnow__FP7SVECTOR:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	addu	$10,$sp,24
	lwl	$11,3($4)
	lwr	$11,0($4)
	lwl	$12,7($4)
	lwr	$12,4($4)
	swl	$11,3($sp)
	swr	$11,0($sp)
	swl	$12,7($sp)
	swr	$12,4($sp)
	lwl	$11,3($sp)
	lwr	$11,0($sp)
	lwl	$12,7($sp)
	lwr	$12,4($sp)
	swl	$11,11($sp)
	swr	$11,8($sp)
	swl	$12,15($sp)
	swr	$12,12($sp)
	lwl	$11,11($sp)
	lwr	$11,8($sp)
	lwl	$12,15($sp)
	lwr	$12,12($sp)
	swl	$11,19($sp)
	swr	$11,16($sp)
	swl	$12,23($sp)
	swr	$12,20($sp)
	lhu	$2,8($sp)
	lhu	$3,18($sp)
	addu	$2,$2,10
	addu	$3,$3,-10
	sh	$2,8($sp)
	sh	$3,18($sp)
	lwl	$11,11($sp)
	lwr	$11,8($sp)
	lwl	$12,15($sp)
	lwr	$12,12($sp)
	swl	$11,27($sp)
	swr	$11,24($sp)
	swl	$12,31($sp)
	swr	$12,28($sp)
	lhu	$2,18($sp)
	addu	$3,$sp,8
	sh	$2,26($sp)
	addu	$2,$sp,16
 #APP
	lwc2 $0, 0($sp)
	lwc2 $1, 4($sp)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	li	$8,-16777216			# 0xff000000
	lw	$5,0($9)
	lw	$7,528482304
	lw	$3,0($5)
	lw	$2,0($7)
	and	$3,$3,$8
	and	$2,$2,$6
	or	$3,$3,$2
	sw	$3,0($5)
 #APP
	
 #NO_APP
	addu	$3,$5,40
	lw	$2,0($7)
	and	$6,$5,$6
	sw	$3,0($9)
	addu	$3,$5,16
	and	$2,$2,$8
	or	$2,$2,$6
	sw	$2,0($7)
	li	$2,9			# 0x00000009
	addu	$6,$5,8
	sb	$2,3($5)
	addu	$2,$5,24
 #APP
	swc2 $12, 0($6)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	lwc2 $0, 0($10)
	lwc2 $1, 4($10)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	li	$2,773849088			# 0x2e200000
	ori	$2,$2,0x2020
	sw	$2,4($5)
	addu	$2,$5,32
 #APP
	swc2 $14, 0($2)
 #NO_APP
	lui	$2,%hi(gWeatherPixmap) # high
	addiu	$2,$2,%lo(gWeatherPixmap) # low
	andi	$4,$4,0x0004
	addu	$4,$4,$2
	lw	$2,0($4)
	#nop
	lw	$3,0($2)
	lw	$4,4($2)
	lw	$6,8($2)
	lw	$2,12($2)
	sw	$3,12($5)
	sw	$4,20($5)
	sw	$6,28($5)
	sw	$2,36($5)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Weather_CreateSnow__FP7SVECTOR
	.text
	.ent	Weather_CreateRain__FP7SVECTORP7DVECTORPc
Weather_CreateRain__FP7SVECTORP7DVECTORPc:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	move	$13,$6
	lwl	$14,3($4)
	lwr	$14,0($4)
	lwl	$15,7($4)
	lwr	$15,4($4)
	swl	$14,3($sp)
	swr	$14,0($sp)
	swl	$15,7($sp)
	swr	$15,4($sp)
	lbu	$2,0($13)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L764
	move	$12,$5
	.set	macro
	.set	reorder

	lh	$9,0($12)
	lh	$11,2($12)
 #APP
	lwc2 $0, 0($sp)
	lwc2 $1, 4($sp)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	li	$7,528482304			# 0x1f800000
	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$8,4194304			# 0x00400000
	ori	$8,$8,0x2020
	li	$6,-16777216			# 0xff000000
	lw	$10,0($7)
	lw	$5,528482304
	lw	$3,0($10)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($10)
	addu	$3,$10,20
	lw	$2,0($5)
	and	$4,$10,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,4			# 0x00000004
	sb	$2,3($10)
	li	$2,1375731712			# 0x52000000
	sw	$2,4($10)
	addu	$2,$10,16
	sw	$8,12($10)
 #APP
	swc2 $14, 0($2)
 #NO_APP
	lh	$3,16($10)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	addu	$3,$9,$2
	bgez	$3,$L765
	addu	$3,$3,3
$L765:
	lh	$2,18($10)
	sra	$3,$3,2
	sh	$3,8($10)
	addu	$2,$11,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L766
	sh	$2,10($10)
	.set	macro
	.set	reorder

$L764:
 #APP
	lwc2 $0, 0($sp)
	lwc2 $1, 4($sp)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	li	$7,528482304			# 0x1f800000
	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$8,4194304			# 0x00400000
	ori	$8,$8,0x2020
	li	$6,-16777216			# 0xff000000
	lw	$10,0($7)
	lw	$5,528482304
	lw	$3,0($10)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($10)
	addu	$3,$10,20
	lw	$2,0($5)
	and	$4,$10,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,4			# 0x00000004
	sb	$2,3($10)
	li	$2,1375731712			# 0x52000000
	sw	$2,4($10)
	addu	$2,$10,16
	sw	$8,12($10)
 #APP
	swc2 $14, 0($2)
 #NO_APP
	lw	$2,16($10)
	#nop
	sw	$2,8($10)
$L766:
	li	$2,1			# 0x00000001
	sb	$2,0($13)
	lw	$2,16($10)
	#nop
	sw	$2,0($12)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	Weather_CreateRain__FP7SVECTORP7DVECTORPc
	.text
	.ent	Weather_CreateSplat__FP18Weather_tSplatInfo
Weather_CreateSplat__FP18Weather_tSplatInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$4
	li	$7,528482304			# 0x1f800000
	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$8,0($7)
	lw	$5,528482304
	lhu	$10,0($9)
	lhu	$11,2($9)
	lw	$2,0($8)
	lw	$3,0($5)
	and	$2,$2,$6
	and	$3,$3,$4
	or	$2,$2,$3
	addu	$3,$8,40
	sw	$2,0($8)
 #APP
	
 #NO_APP
	lw	$2,0($5)
	and	$4,$8,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,9			# 0x00000009
	sb	$2,3($8)
	li	$2,46			# 0x0000002e
	sb	$2,7($8)
	lhu	$2,0($9)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L769
	li	$7,18			# 0x00000012
	.set	macro
	.set	reorder

	li	$7,12			# 0x0000000c
$L769:
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,4($9)
	#nop
	subu	$3,$3,$2
	sll	$4,$3,2
	li	$2,-128			# 0xffffff80
	subu	$2,$2,$4
 #APP
	
 #NO_APP
	sra	$3,$3,3
	subu	$6,$10,$3
	sb	$2,6($8)
	sb	$2,5($8)
	sb	$2,4($8)
	addu	$2,$11,$3
	subu	$5,$2,$3
	addu	$4,$10,$7
	addu	$4,$4,$3
	addu	$2,$2,$7
	sll	$3,$3,1
	addu	$2,$2,$3
	sh	$2,26($8)
	sh	$2,34($8)
	lui	$2,%hi(gWeatherPixmap+8) # high
	sh	$6,8($8)
	sh	$5,10($8)
	sh	$4,16($8)
	sh	$5,18($8)
	sh	$6,24($8)
	sh	$4,32($8)
	lw	$2,%lo(gWeatherPixmap+8)($2)
	#nop
	lw	$3,0($2)
	lw	$4,4($2)
	lw	$5,8($2)
	lw	$2,12($2)
	sw	$3,12($8)
	sw	$4,20($8)
	sw	$5,28($8)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,36($8)
	.set	macro
	.set	reorder

	.end	Weather_CreateSplat__FP18Weather_tSplatInfo
	.text
	.ent	Weather_DoSplats__FiP18Weather_tSplatInfo
Weather_DoSplats__FiP18Weather_tSplatInfo:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	lw	$2,gCurrentNumSplats
	move	$4,$5
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L772
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	sw	$20,gCurrentNumSplats
$L772:
	lw	$6,gCurrentNumSplats
	#nop
	.set	noreorder
	.set	nomacro
	blez	$6,$L771
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$19,$2,%lo(simGlobal) # low
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$21,$2,%lo(GameSetup_gData) # low
	move	$16,$4
$L775:
 #APP
 #NO_APP
	lw	$4,4($19)
	lw	$3,4($16)
	#nop
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L776
	addu	$2,$3,32
	.set	macro
	.set	reorder

	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L777
	slt	$2,$20,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	bne	$17,$2,$L778
	sw	$17,gCurrentNumSplats
	.set	noreorder
	.set	nomacro
	j	$L786
	addu	$16,$16,8
	.set	macro
	.set	reorder

$L778:
	.set	noreorder
	.set	nomacro
	jal	random
	move	$18,$16
	.set	macro
	.set	reorder

	li	$3,-858993459			# 0xcccccccd
	multu	$2,$3
	mfhi	$7
	#nop
	#nop
	srl	$4,$7,8
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,6
	subu	$2,$2,$3
	sh	$2,0($16)
 #APP
 #NO_APP
	lw	$3,12($21)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L780
	jal	random
	li	$3,-2004318071			# 0x88888889
	multu	$2,$3
	mfhi	$7
	#nop
	#nop
	srl	$4,$7,7
	sll	$3,$4,4
	subu	$3,$3,$4
	sll	$3,$3,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L785
	srl	$2,$2,1
	.set	macro
	.set	reorder

$L780:
	jal	random
	li	$3,-2004318071			# 0x88888889
	multu	$2,$3
	mfhi	$7
	#nop
	#nop
	srl	$4,$7,7
	sll	$3,$4,4
	subu	$3,$3,$4
	sll	$3,$3,4
	subu	$2,$2,$3
$L785:
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,2($18)
	.set	macro
	.set	reorder

	li	$3,1374355456			# 0x51eb0000
	ori	$3,$3,0x851f
	multu	$2,$3
	mfhi	$7
	#nop
	#nop
	srl	$4,$7,5
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,3
	addu	$3,$3,$4
	sll	$3,$3,2
	lw	$4,4($19)
	subu	$2,$2,$3
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L776
	sw	$4,4($16)
	.set	macro
	.set	reorder

$L777:
	.set	noreorder
	.set	nomacro
	jal	Weather_CreateSplat__FP18Weather_tSplatInfo
	move	$4,$16
	.set	macro
	.set	reorder

$L776:
	addu	$16,$16,8
$L786:
	lw	$6,gCurrentNumSplats
	addu	$17,$17,1
	slt	$2,$17,$6
	bne	$2,$0,$L775
$L771:
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

	.end	Weather_DoSplats__FiP18Weather_tSplatInfo
	.text
	.ent	Weather_DoWeather__FP13DRender_tView
Weather_DoWeather__FP13DRender_tView:
	.frame	$sp,64,$31		# vars= 0, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$21,44($sp)
	move	$21,$4
	lui	$7,%hi(GameSetup_gData+12) # high
	lui	$5,%hi(Weather_gPServer) # high
	addiu	$5,$5,%lo(Weather_gPServer) # low
	lui	$3,%hi(Weather_gPrevPServer) # high
	addiu	$3,$3,%lo(Weather_gPrevPServer) # low
	lui	$2,%hi(Weather_gDrawnServer) # high
	addiu	$2,$2,%lo(Weather_gDrawnServer) # low
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$18,4($21)
	li	$6,1			# 0x00000001
	sll	$4,$18,2
	addu	$5,$4,$5
	addu	$3,$4,$3
	addu	$4,$4,$2
	lw	$2,%lo(GameSetup_gData+12)($7)
	lw	$22,0($5)
	lw	$23,0($3)
	lw	$20,0($4)
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$2,$6,$L788
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,timechange
	#nop
	subu	$2,$3,$2
	slt	$2,$2,33
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L810
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

	lw	$2,Weather_gSnowTrack
	sw	$3,timechange
	bne	$2,$0,$L789
	jal	Weather_ChangeIntensityBasedOnTime__Fv
$L789:
	jal	Weather_ChangeDensityBasedOnTime__Fv
$L788:
	lui	$2,%hi(Weather_gSys) # high
$L810:
	lw	$3,%lo(Weather_gSys)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L808
	addiu	$19,$2,%lo(Weather_gSys) # low
	.set	macro
	.set	reorder

	sll	$17,$18,2
	la	$2,Input_gLookBehind
	addu	$2,$17,$2
	lw	$5,0($2)
 #APP
 #NO_APP
	la	$2,prevLookBehind
	addu	$3,$17,$2
 #APP
 #NO_APP
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L791
	move	$16,$0
	.set	macro
	.set	reorder

	xori	$2,$5,0x0001
	sltu	$16,$2,1
$L791:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Camera_GetMode__Fi
	sw	$5,0($3)
	.set	macro
	.set	reorder

	la	$3,prevCameraMode
	addu	$4,$17,$3
	lw	$3,0($4)
	move	$5,$2
	beq	$5,$3,$L792
	li	$16,1			# 0x00000001
$L792:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L793
	sw	$5,0($4)
	.set	macro
	.set	reorder

	addu	$4,$17,$19
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L793
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$2,$20,$3
$L811:
	sb	$0,0($2)
	lw	$2,0($4)
	addu	$3,$3,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L811
	addu	$2,$20,$3
	.set	macro
	.set	reorder

$L793:
	lui	$3,%hi(simGlobal+4) # high
	sll	$16,$18,2
	lui	$2,%hi(Weather_gLastProcessTime) # high
	addiu	$2,$2,%lo(Weather_gLastProcessTime) # low
	addu	$5,$16,$2
	lw	$3,%lo(simGlobal+4)($3)
	lw	$2,0($5)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L799
	move	$4,$21
	.set	macro
	.set	reorder

	move	$6,$22
	lui	$2,%hi(Weather_gSys) # high
	addiu	$2,$2,%lo(Weather_gSys) # low
	addu	$2,$16,$2
	sw	$3,0($5)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc
	move	$7,$20
	.set	macro
	.set	reorder

$L799:
	jal	Weather_SetIdentMatrix__Fv
	lui	$2,%hi(Camera_gInfo) # high
	addiu	$2,$2,%lo(Camera_gInfo) # low
	sll	$3,$18,4
	addu	$3,$3,$18
	sll	$3,$3,4
	addu	$3,$3,$2
	lw	$2,116($3)
	#nop
	srl	$2,$2,27
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L800
	lui	$2,%hi(Weather_gSys) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Weather_gSys) # low
	addu	$2,$16,$2
	lui	$3,%hi(Weather_gSplatInfoServer) # high
	addiu	$3,$3,%lo(Weather_gSplatInfoServer) # low
	addu	$3,$16,$3
	lw	$4,0($2)
	lw	$5,0($3)
	.set	noreorder
	.set	nomacro
	jal	Weather_DoSplats__FiP18Weather_tSplatInfo
	sra	$4,$4,3
	.set	macro
	.set	reorder

$L800:
	lui	$2,%hi(Weather_gSys) # high
	addiu	$2,$2,%lo(Weather_gSys) # low
	addu	$3,$16,$2
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L801
	move	$17,$0
	.set	macro
	.set	reorder

	li	$21,1			# 0x00000001
	move	$19,$3
	move	$16,$22
	move	$18,$23
$L802:
	lw	$2,Weather_gType
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$21,$L805
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Weather_CreateRain__FP7SVECTORP7DVECTORPc
	addu	$6,$20,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L809
	addu	$16,$16,8
	.set	macro
	.set	reorder

$L805:
	.set	noreorder
	.set	nomacro
	jal	Weather_CreateSnow__FP7SVECTOR
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,8
$L809:
	lw	$2,0($19)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L802
	addu	$18,$18,4
	.set	macro
	.set	reorder

$L801:
	li	$11,528482304			# 0x1f800000
	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$0
	move	$6,$5
	li	$7,32			# 0x00000020
	li	$10,-16777216			# 0xff000000
	lw	$4,0($11)
	lw	$8,528482304
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,12
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

$L808:
	lw	$31,56($sp)
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

	.end	Weather_DoWeather__FP13DRender_tView
	.text
	.ent	Weather_BuildWeather__FP13DRender_tView
Weather_BuildWeather__FP13DRender_tView:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$3,4($16)
	lui	$4,%hi(Camera_gInfo+140) # high
	addiu	$4,$4,%lo(Camera_gInfo+140) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	bne	$2,$0,$L812
	.set	noreorder
	.set	nomacro
	jal	Weather_DoWeather__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

$L812:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Weather_BuildWeather__FP13DRender_tView
