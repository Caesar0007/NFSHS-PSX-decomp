	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\sim.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"Sc32-1\000"
	.align	2
$LC1:
	.ascii	"Sc32-2\000"
	.align	2
$LC2:
	.ascii	"Sc64\000"
	.text
	.align	2
	.globl	Sim_StartUp__Fv
	.align	2
	.globl	Sim_Restart__Fv
	.align	2
	.globl	Sim_CleanUp__Fv
	.align	2
	.globl	Sim_FadeInSFX__Fv
	.align	2
	.globl	Sim_ProcessSimSchedules__Fv
	.align	2
	.globl	Sim_ProcessPause__Fv
	.align	2
	.globl	Sim_CheckForPause__Fi
	.align	2
	.globl	Sim_MainGameLoop__Fv
	.globl	InBetween
	.sdata
	.align	2
InBetween:
	.space	4
	.globl	unPauseDelay
	.align	2
unPauseDelay:
	.space	4
	.globl	skipRender
	.align	2
skipRender:
	.space	4
	.globl	quitType
	.align	2
quitType:
	.space	4

	.extern	Input_gLookBehind, 8
	.extern	Hud_ActivateCDPlayer, 4
	.extern	gSimQueue_Ticker, 4
	.extern	Device_gForcePause, 4
	.extern	Replay_ReplayMode, 4
	.extern	Device_gPausePortIndex, 1
	.extern	gSimQueue_BlockSelf, 4
	.extern	clock_realTime, 12
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	gWSavePtr, 4
	.extern	counter, 16
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gHumanRaceCarList, 8
	.extern	Replay_ReplayInterface, 32
	.extern	gMasterSFXLevel, 4
	.extern	Input_gTime, 4
	.extern	countdown, 1
	.extern	GameSetup_gData, 2600
	.extern	simGlobal, 24
	.extern	simVar, 28

	.text
	.text
	.ent	Sim_StartUp__Fv
Sim_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,70			# 0x00000046
	lui	$2,%hi(simVar) # high
	li	$3,1			# 0x00000001
	sw	$3,%lo(simVar)($2)
	addiu	$2,$2,%lo(simVar) # low
	sw	$16,16($sp)
	lui	$16,%hi(simGlobal) # high
	sw	$31,20($sp)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,12($2)
	sw	$0,%lo(simGlobal)($16)
	addiu	$16,$16,%lo(simGlobal) # low
	.set	noreorder
	.set	nomacro
	jal	Sched_CreateNewSchedule__FPci
	sw	$0,4($16)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	Sched_CreateNewSchedule__FPci
	sw	$2,16($16)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,26			# 0x0000001a
	.set	noreorder
	.set	nomacro
	jal	Sched_CreateNewSchedule__FPci
	sw	$2,20($16)
	.set	macro
	.set	reorder

	lui	$3,%hi(GameSetup_gData+88) # high
	lw	$4,%lo(GameSetup_gData+88)($3)
	.set	noreorder
	.set	nomacro
	jal	FastRandom_StartUp__FUi
	sw	$2,12($16)
	.set	macro
	.set	reorder

	jal	AICop_StartUp__Fv
	jal	AIInit_StartUp1__Fv
	jal	R3DCar_StartUp__Fv
	jal	CarIO_StartUp__Fv
	jal	Cars_StartUp__Fv
	jal	R3DCar_PostStartUp__Fv
	jal	AIHigh_StartUp__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,9			# 0x00000009
	.set	macro
	.set	reorder

	jal	AIInit_StartUp2__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

	jal	AudioCmn_Init__Fv
	lui	$5,%hi(Camera_Update__Fv) # high
	addiu	$5,$5,%lo(Camera_Update__Fv) # low
	move	$6,$0
	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	li	$7,100			# 0x00000064
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

	.end	Sim_StartUp__Fv
	.text
	.ent	Sim_Restart__Fv
Sim_Restart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,1			# 0x00000001
	sw	$2,quitType
	lui	$2,%hi(simVar) # high
	addiu	$2,$2,%lo(simVar) # low
	sw	$16,16($sp)
	lui	$16,%hi(simGlobal) # high
	sw	$31,20($sp)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sw	$0,%lo(simGlobal)($16)
	lw	$4,88($2)
	addiu	$16,$16,%lo(simGlobal) # low
	sb	$0,countdown
	sw	$0,4($16)
	.set	noreorder
	.set	nomacro
	jal	FastRandom_StartUp__FUi
	sw	$0,436($2)
	.set	macro
	.set	reorder

	jal	AICop_Restart__Fv
	jal	AIInit_Reset1__Fv
	jal	R3DCar_Restart__Fv
	jal	AIHigh_Restart1__Fv
	jal	Cars_Restart__Fv
	jal	AIHigh_Restart2__Fv
	jal	AIInit_Reset2__Fv
	jal	Hud_Reset__Fv
	jal	Render_RestartTrackRender__Fv
	jal	SimQueue_Reset__Fv
	lw	$2,Input_gTime
	#nop
	sw	$2,8($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sim_Restart__Fv
	.text
	.ent	Sim_CleanUp__Fv
Sim_CleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Force_Disable__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SimQueue_CleanUp__Fv
	lui	$16,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(simGlobal) # low
	lui	$5,%hi(Camera_Update__Fv) # high
	addiu	$5,$5,%lo(Camera_Update__Fv) # low
	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	move	$6,$0
	.set	macro
	.set	reorder

	jal	AIInit_CleanUp2__Fv
	jal	AIHigh_CleanUp__Fv
	jal	Cars_CleanUp__Fv
	jal	R3DCar_CleanUp__Fv
	jal	CarIO_CleanUp__Fv
	jal	AIInit_CleanUp1__Fv
	jal	AICop_CleanUp__Fv
	jal	FastRandom_CleanUp__Fv
	lw	$4,16($16)
	jal	Sched_CleanUpSchedule__FP15Sched_tSchedule
	lw	$4,20($16)
	jal	Sched_CleanUpSchedule__FP15Sched_tSchedule
	lw	$4,12($16)
	jal	Sched_CleanUpSchedule__FP15Sched_tSchedule
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sim_CleanUp__Fv
	.text
	.ent	Sim_FadeInSFX__Fv
Sim_FadeInSFX__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L604
	addu	$2,$4,-17
	.set	macro
	.set	reorder

	lw	$3,gMasterSFXLevel
	lui	$2,%hi(GameSetup_gData+244) # high
	sw	$0,gMasterSFXLevel
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,%lo(GameSetup_gData+244)($2)
	.set	macro
	.set	reorder

$L604:
	sltu	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	lui	$2,%hi(Replay_ReplayInterface+28) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Replay_ReplayInterface+28)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	lui	$2,%hi(GameSetup_gData+244) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+244)($2)
	addu	$3,$4,-16
	.set	noreorder
	.set	nomacro
	j	$L607
	sra	$2,$2,2
	.set	macro
	.set	reorder

$L606:
	lw	$3,%lo(GameSetup_gData+244)($2)
	addu	$2,$4,-16
$L607:
	mult	$3,$2
	mflo	$5
	#nop
	#nop
	sra	$2,$5,6
	sw	$2,gMasterSFXLevel
$L608:
	j	$31
	.end	Sim_FadeInSFX__Fv
	.text
	.ent	Sim_ProcessSimSchedules__Fv
Sim_ProcessSimSchedules__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	sw	$31,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L612
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L628
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

$L612:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L628
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

$L628:
	lw	$2,%lo(simGlobal)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	lbu	$2,countdown
	#nop
	addu	$16,$2,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L629
	slt	$2,$16,4
	.set	macro
	.set	reorder

	move	$16,$0
	slt	$2,$16,4
$L629:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	lui	$6,%hi(simGlobal) # high
	.set	macro
	.set	reorder

	li	$17,35			# 0x00000023
	li	$4,2			# 0x00000002
$L631:
	addu	$5,$16,$17
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L631
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	lui	$6,%hi(simGlobal) # high
$L630:
	addiu	$4,$6,%lo(simGlobal) # low
	lui	$3,%hi(counter) # high
	lbu	$5,countdown
	addiu	$3,$3,%lo(counter) # low
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$3,4($4)
	lw	$2,0($2)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	slt	$2,$3,512
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	li	$4,-4			# 0xfffffffc
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,%lo(simGlobal)($6)
$L632:
	addu	$5,$5,35
	move	$6,$0
	li	$2,64			# 0x00000040
	li	$7,127			# 0x0000007f
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlaySound__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lbu	$2,countdown
	#nop
	addu	$2,$2,1
	sb	$2,countdown
$L621:
	jal	Sim_FadeInSFX__Fv
	.set	noreorder
	.set	nomacro
	j	$L627
	lui	$2,%hi(simGlobal) # high
	.set	macro
	.set	reorder

$L610:
	jal	Sim_FadeInSFX__Fv
	lui	$3,%hi(simGlobal) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(simGlobal)($3)
	lui	$2,%hi(simGlobal) # high
$L627:
	addiu	$16,$2,%lo(simGlobal) # low
	lw	$2,4($16)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L624
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	jal	Stats_ClearPosition__Fv
	jal	Collide_ClearCollisionRegistry__Fv
	lw	$4,16($16)
	jal	Sched_Execute__FP15Sched_tSchedule
	jal	Cars_ManageBureaucracy__Fv
	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	jal	Cars_CheckForAccidentScenes__Fv
$L624:
	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	lw	$4,12($16)
	li	$17,1			# 0x00000001
	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	jal	Sched_Execute__FP15Sched_tSchedule
	lw	$4,gWSavePtr
	jal	SetSp
	lw	$3,4($16)
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	and	$3,$3,$17
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L625
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	jal	AIHigh_Execute__Fv
	lw	$4,gWSavePtr
	jal	SetSp
	li	$4,528482304			# 0x1f800000
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	lw	$4,20($16)
	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	jal	Sched_Execute__FP15Sched_tSchedule
	jal	Stats_TrackEndGame__Fv
	jal	Stats_DoPlayerGlue__Fv
	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	jal	AudioClc_SoundCars__Fv
$L625:
	lw	$2,4($16)
	#nop
	addu	$2,$2,1
	sw	$2,4($16)
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

	.end	Sim_ProcessSimSchedules__Fv
	.text
	.ent	Sim_ProcessPause__Fv
Sim_ProcessPause__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(clock_realTime+8) # high
	lw	$3,unPauseDelay
	lw	$2,%lo(clock_realTime+8)($2)
	subu	$sp,$sp,24
	sw	$31,20($sp)
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L633
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MPause_Logic__Fv
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$16,$L635
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lui	$2,%hi(simVar) # high
	addiu	$16,$2,%lo(simVar) # low
	lw	$2,16($16)
	#nop
	bne	$2,$0,$L636
	jal	AudioCmn_UnPause__Fv
$L636:
	sw	$0,gSimQueue_BlockSelf
	.set	noreorder
	.set	nomacro
	jal	Force_UnPause__Fv
	sw	$0,8($16)
	.set	macro
	.set	reorder

	j	$L637
$L635:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L638
	addu	$2,$3,-4
	.set	macro
	.set	reorder

	jal	AudioCmn_UnPauseAndRestart__Fv
	lui	$3,%hi(simVar) # high
	addiu	$2,$3,%lo(simVar) # low
	sw	$16,8($2)
	sw	$16,4($2)
	.set	noreorder
	.set	nomacro
	j	$L637
	sw	$16,%lo(simVar)($3)
	.set	macro
	.set	reorder

$L638:
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L641
	lui	$3,%hi(GameSetup_gData+184) # high
	.set	macro
	.set	reorder

	lbu	$2,Device_gPausePortIndex
	#nop
	sltu	$2,$0,$2
	sw	$2,%lo(GameSetup_gData+184)($3)
$L641:
	jal	Hud_BTC_QuitOut__Fv
	jal	AudioCmn_UnPauseAndRestart__Fv
	lui	$3,%hi(simVar) # high
	addiu	$2,$3,%lo(simVar) # low
	li	$4,1			# 0x00000001
	sw	$0,8($2)
	sw	$16,4($2)
	.set	noreorder
	.set	nomacro
	jal	Stats_ExtrapolateOpponentTimes__Fi
	sw	$0,%lo(simVar)($3)
	.set	macro
	.set	reorder

	sw	$16,quitType
$L637:
	jal	MPause_EndPauseMenu__Fv
$L633:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sim_ProcessPause__Fv
	.text
	.ent	Sim_CheckForPause__Fi
Sim_CheckForPause__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayMode
	subu	$sp,$sp,24
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simVar) # high
	lw	$2,%lo(simVar)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,33
	bne	$2,$0,$L643
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L646
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	lui	$2,%hi(clock_realTime+8) # high
	.set	macro
	.set	reorder

$L646:
	lw	$2,Device_gForcePause
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	lui	$2,%hi(clock_realTime+8) # high
	.set	macro
	.set	reorder

$L648:
	lw	$2,%lo(clock_realTime+8)($2)
	#nop
	addu	$2,$2,4
	sw	$2,unPauseDelay
	jal	AudioCmn_Pause__Fv
	li	$3,1			# 0x00000001
	lui	$2,%hi(simVar+8) # high
	sw	$3,gSimQueue_BlockSelf
	.set	noreorder
	.set	nomacro
	jal	Force_Pause__Fv
	sw	$3,%lo(simVar+8)($2)
	.set	macro
	.set	reorder

$L643:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sim_CheckForPause__Fi
	.text
	.ent	Sim_MainGameLoop__Fv
Sim_MainGameLoop__Fv:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lui	$2,%hi(simVar) # high
	sw	$17,28($sp)
	addiu	$17,$2,%lo(simVar) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$2,$2,%lo(simGlobal) # low
	sw	$19,36($sp)
	move	$19,$2
	li	$2,1			# 0x00000001
	sw	$2,quitType
	lui	$2,%hi(clock_realTime+4) # high
	lw	$2,%lo(clock_realTime+4)($2)
	lw	$3,Input_gTime
	sw	$23,52($sp)
	move	$23,$0
	sw	$fp,56($sp)
	lui	$fp,%hi(Replay_ReplayInterface) # high
	sw	$20,40($sp)
	addiu	$20,$fp,%lo(Replay_ReplayInterface) # low
	sw	$31,60($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	addu	$22,$2,10000
	sw	$3,8($19)
$L650:
	lw	$2,4($17)
	#nop
	bne	$2,$0,$L654
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(clock_realTime+4) # high
	lw	$3,gSimQueue_Ticker
	lw	$5,%lo(clock_realTime+4)($2)
	sll	$4,$3,1
	subu	$3,$5,$22
	subu	$2,$4,$23
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	sw	$4,20($17)
	.set	macro
	.set	reorder

	addu	$2,$4,1
	sw	$2,20($17)
$L655:
	lw	$3,Input_gTime
	lw	$2,8($19)
	lw	$23,20($17)
	subu	$2,$3,$2
	slt	$2,$2,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	move	$22,$5
	.set	macro
	.set	reorder

	sw	$3,8($19)
$L656:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$21,$2,%lo(GameSetup_gData) # low
 #APP
 #NO_APP
$L657:
	lw	$3,8($19)
	lw	$2,Input_gTime
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L658
	lw	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,Replay_ReplayMode
	#nop
	bne	$3,$2,$L661
	lw	$2,8($17)
	#nop
	bne	$2,$0,$L661
	jal	Replay_GetInterfaceKey__Fv
	lw	$3,20($20)
	li	$2,4			# 0x00000004
	bne	$3,$2,$L661
	lw	$3,8($20)
	lw	$2,40($21)
	sw	$0,20($20)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	sw	$3,4($17)
	.set	macro
	.set	reorder

	jal	AudioCmn_UnPauseAndRestart__Fv
	j	$L661
$L663:
	beq	$3,$0,$L665
	lw	$2,16($17)
	#nop
	beq	$2,$0,$L709
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_UnPauseAndQuit__Fv
	sw	$0,16($17)
	.set	macro
	.set	reorder

	j	$L661
$L665:
	lw	$2,16($17)
$L709:
	lw	$3,%lo(Replay_ReplayInterface)($fp)
	#nop
	beq	$2,$3,$L661
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L668
	sw	$3,16($17)
	.set	macro
	.set	reorder

	jal	Camera_Update__Fv
	jal	AudioCmn_Pause__Fv
	j	$L661
$L668:
	jal	AudioCmn_UnPause__Fv
$L661:
	lw	$2,4($17)
	#nop
	bne	$2,$0,$L670
	lw	$2,8($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

	jal	Sim_ProcessPause__Fv
	li	$2,24			# 0x00000018
	.set	noreorder
	.set	nomacro
	j	$L670
	sw	$2,12($17)
	.set	macro
	.set	reorder

$L671:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$2,$0,$L673
	jal	AudioMus_SwitchSong__Fv
	li	$2,1			# 0x00000001
	sw	$2,Hud_ActivateCDPlayer
$L673:
	lw	$4,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L674
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$5,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L670
	.set	noreorder
	.set	nomacro
	j	$L670
	sw	$0,12($17)
	.set	macro
	.set	reorder

$L674:
	move	$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(GameSetup_gData) # low
 #APP
 #NO_APP
$L679:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L681
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

	li	$4,27			# 0x0000001b
$L681:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$2,$0,$L680
	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	beq	$2,$0,$L680
	.set	noreorder
	.set	nomacro
	jal	Camera_NextMode__Fi
	move	$4,$16
	.set	macro
	.set	reorder

$L680:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L684
	li	$4,28			# 0x0000001c
	.set	macro
	.set	reorder

	li	$4,29			# 0x0000001d
$L684:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	addu	$4,$16,22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DashHUD_ToggleHud__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$16,22
$L710:
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$5,$0
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	sll	$5,$16,2
	lui	$3,%hi(Input_gLookBehind) # high
	addiu	$3,$3,%lo(Input_gLookBehind) # low
	addu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	Sim_CheckForPause__Fi
	sw	$2,0($5)
	.set	macro
	.set	reorder

	lw	$2,12($18)
	addu	$16,$16,1
	xori	$2,$2,0x0001
	sltu	$2,$2,1
	slt	$2,$2,$16
	beq	$2,$0,$L679
$L670:
	lw	$2,8($19)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L657
	sw	$2,8($19)
	.set	macro
	.set	reorder

$L658:
	lw	$2,8($17)
	sw	$0,skipRender
	bne	$2,$0,$L687
	lw	$2,16($17)
	#nop
	bne	$2,$0,$L687
	lw	$2,4($17)
	#nop
	bne	$2,$0,$L687
	lw	$3,24($17)
	lw	$2,20($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,skipRender
	j	$L701
$L688:
	li	$16,1			# 0x00000001
$L690:
	lw	$4,24($17)
	#nop
	andi	$2,$4,0x0001
	bne	$2,$0,$L693
	.set	noreorder
	.set	nomacro
	jal	SimQueue_SetCurrentInput__Fi
	sra	$4,$4,1
	.set	macro
	.set	reorder

$L693:
	lw	$3,Replay_ReplayMode
	li	$2,2			# 0x00000002
	sw	$0,InBetween
	bne	$3,$2,$L708
	lw	$4,4($20)
	#nop
	beq	$4,$3,$L708
	bne	$4,$16,$L696
	lw	$2,24($17)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L708
$L696:
	bne	$4,$0,$L694
	lw	$2,24($17)
	#nop
	andi	$2,$2,0x0003
	beq	$2,$0,$L708
$L694:
	lw	$3,4($20)
	li	$2,3			# 0x00000003
	bne	$3,$2,$L698
	jal	Sim_ProcessSimSchedules__Fv
$L708:
	jal	Sim_ProcessSimSchedules__Fv
	j	$L697
$L698:
	sw	$16,InBetween
	jal	Camera_Update__Fv
$L697:
	lw	$2,24($17)
	lw	$3,20($17)
	addu	$2,$2,1
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L690
	sw	$2,24($17)
	.set	macro
	.set	reorder

	j	$L701
$L687:
	jal	Camera_Update__Fv
$L701:
	lw	$2,skipRender
	#nop
	bne	$2,$0,$L702
	lw	$4,8($17)
	jal	Render_Render__Fi
$L702:
	jal	Input_MainExitKey__Fv
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,Replay_ReplayMode
	li	$2,3			# 0x00000003
	bne	$3,$2,$L650
	lw	$2,4($19)
	#nop
	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L650
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L711:
	.set	noreorder
	.set	nomacro
	j	$L650
	sw	$2,4($17)
	.set	macro
	.set	reorder

$L654:
	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(GameSetup_gData) # low
	lw	$3,436($2)
	#nop
	sw	$3,440($2)
$L649:
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

	.end	Sim_MainGameLoop__Fv
