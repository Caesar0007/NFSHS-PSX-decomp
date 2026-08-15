	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\nfs3.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	befuddleExtensions
	.data
	.align	2
befuddleExtensions:
	.byte	113
	.byte	112
	.byte	108
	.byte	0
	.byte	97
	.byte	105
	.byte	105
	.byte	0
	.byte	115
	.byte	112
	.byte	100
	.byte	0
	.byte	113
	.byte	97
	.byte	108
	.byte	0
	.byte	115
	.byte	97
	.byte	108
	.byte	0
	.byte	100
	.byte	116
	.byte	97
	.byte	0
	.byte	113
	.byte	112
	.byte	115
	.byte	0
	.byte	105
	.byte	110
	.byte	102
	.byte	0
	.byte	113
	.byte	100
	.byte	97
	.byte	0
	.byte	99
	.byte	97
	.byte	114
	.byte	0
	.byte	113
	.byte	97
	.byte	115
	.byte	0
	.byte	113
	.byte	100
	.byte	116
	.byte	0
	.byte	115
	.byte	112
	.byte	108
	.byte	0
	.byte	115
	.byte	112
	.byte	101
	.byte	0
	.globl	gMusicInSimIsOn
	.sdata
gMusicInSimIsOn:
	.byte	1
	.globl	gUseFrontend
	.align	2
gUseFrontend:
	.word	1
	.globl	gFECheats
	.align	2
gFECheats:
	.word	0
	.globl	gFEBonus
	.align	2
gFEBonus:
	.word	0
	.globl	gFEBigHandle
	.align	2
gFEBigHandle:
	.word	0
	.globl	MEMCARDFRONTENDISINITTED
	.align	2
MEMCARDFRONTENDISINITTED:
	.word	0
	.globl	gCheckTotalTime
gCheckTotalTime:
	.byte	1
	.globl	gCheckLapTime
gCheckLapTime:
	.byte	1
	.globl	gUpdateTournamentInfoFlag
gUpdateTournamentInfoFlag:
	.byte	1
	.globl	gUpdateKnockoutInfoFlag
gUpdateKnockoutInfoFlag:
	.byte	1
	.globl	gKnockOutSpeechFlag
gKnockOutSpeechFlag:
	.byte	1
	.globl	gCalculateVictory
gCalculateVictory:
	.byte	1
	.globl	gPlayerEnteredNameAlready
	.align	2
gPlayerEnteredNameAlready:
	.byte	0
	.byte	0
	.globl	nfs_sysInfo
	.align	2
nfs_sysInfo:
	.word	0
	.globl	missionManager
	.align	2
missionManager:
	.byte	0
	.space	7
	.globl	finishOrder
	.align	2
finishOrder:
	.byte	0
	.space	7
	.text
	.align	2
	.globl	Nfs2_SystemNLibStartUp__Fv
	.align	2
	.globl	Nfs2_BefuddleCode__Fv
	.align	2
	.globl	Nfs2_ResetGame__Fv
	.sdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.rdata
	.align	2
$LC1:
	.ascii	"zHPurs.mis\000"
	.align	2
$LC2:
	.ascii	"zHPurs2.mis\000"
	.align	2
$LC3:
	.ascii	"fecars.car\000"
	.text
	.align	2
	.globl	NFS4_LoadPerps__Fv
	.sdata
	.align	2
$LC4:
	.ascii	"ymus\000"
	.text
	.align	2
	.globl	Nfs2_GameModuleStartUp__FPi
	.align	2
	.globl	Nfs2_CleanUpGameModule__Fv
	.rdata
	.align	2
$LC5:
	.ascii	"front.bin\000"
	.text
	.align	2
	.globl	LoadFrontendOverlay__Fv
	.rdata
	.align	2
$LC6:
	.ascii	"%sDCT.BIN\000"
	.text
	.align	2
	.globl	LoadOverlay__Fv
	.rdata
	.align	2
$LC7:
	.ascii	"%sldic.psh\000"
	.text
	.align	2
	.globl	NFS4_LoadingIcon__Fv
	.align	2
	.globl	NFS3_CheckForFileOperations__Fv
	.sdata
	.align	2
$LC8:
	.ascii	"win*\000"
	.align	2
$LC9:
	.ascii	"lose*\000"
	.text
	.align	2
	.globl	main
	.globl	carManager
	.data
	.align	2
carManager:
	.space	908
	.globl	frontEnd
	.align	2
frontEnd:
	.space	1104
	.globl	trackManager
	.align	2
trackManager:
	.space	136
	.globl	tournamentManager
	.align	2
tournamentManager:
	.space	644
	.globl	CreditManager
	.align	2
CreditManager:
	.space	56
	.globl	Stats_gTrackRecords
	.align	2
Stats_gTrackRecords:
	.space	3740
	.globl	gTournamentFinishOrder
	.align	2
gTournamentFinishOrder:
	.space	12
	.globl	befuddleTemp
	.align	2
befuddleTemp:
	.space	10

	.extern	quitType, 4
	.extern	Replay_ReplayMode, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Replay_ReplayInterface, 32
	.extern	simVar, 28
	.extern	ComingIntoTheFrontEndTheVeryFirstTime, 4
	.extern	gFileMgr, 48
	.extern	CF_DVLC, 4
	.extern	_6Speech_fgSpeech, 4
	.extern	GameSetup_gData, 2600
	.extern	_6Speech_fgUndefined, 4

	.text
	.text
	.ent	Nfs2_SystemNLibStartUp__Fv
Nfs2_SystemNLibStartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Platform_SysStartUp__Fv
	jal	Loading_GetInitialMemory__Fv
	lw	$2,_6Speech_fgUndefined
	#nop
	bne	$2,$0,$L602
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,80			# 0x00000050
	.set	macro
	.set	reorder

	lui	$3,%hi(Speaker_vtable) # high
	addiu	$3,$3,%lo(Speaker_vtable) # low
	sw	$3,76($2)
	sw	$0,72($2)
	sw	$2,_6Speech_fgUndefined
$L602:
	jal	Render_InitLibRender__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Nfs2_SystemNLibStartUp__Fv
	.text
	.ent	Nfs2_BefuddleCode__Fv
Nfs2_BefuddleCode__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	lui	$18,%hi(befuddleTemp) # high
	lui	$2,%hi(befuddleExtensions) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(befuddleExtensions) # low
	sw	$31,28($sp)
$L604:
	addiu	$4,$18,%lo(befuddleTemp) # low
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$17,$17,1
	slt	$2,$17,14
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	addu	$16,$16,4
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

	.end	Nfs2_BefuddleCode__Fv
	.text
	.ent	Nfs2_ResetGame__Fv
Nfs2_ResetGame__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Replay_ResetReplay__Fv
	jal	BWorld_Restart__Fv
	jal	Sim_Restart__Fv
	jal	Camera_Init__Fv
	jal	Weather_Restart__Fv
	jal	AudioCmn_Reset__Fv
	jal	Reset__6Speech
	jal	AudioClc_StartUp__Fv
	jal	DashHUD_ResetHUD__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Nfs2_ResetGame__Fv
	.text
	.ent	NFS4_LoadPerps__Fv
NFS4_LoadPerps__Fv:
	.frame	$sp,96,$31		# vars= 64, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	sw	$31,88($sp)
	sw	$17,84($sp)
	sw	$16,80($sp)
	lw	$2,428($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L610
	lui	$2,%hi($LC0) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo($LC0) # low
	lui	$2,%hi(Paths_Paths) # high
	addiu	$6,$2,%lo(Paths_Paths) # low
	lw	$3,12($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L611
	lui	$2,%hi($LC1) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	addiu	$7,$2,%lo($LC1) # low
	.set	macro
	.set	reorder

$L611:
	lui	$2,%hi($LC2) # high
	addiu	$7,$2,%lo($LC2) # low
$L612:
	lw	$6,148($6)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$7,%hi($LC3) # high
	addiu	$7,$7,%lo($LC3) # low
	lui	$3,%hi(Paths_Paths+148) # high
	lw	$6,%lo(Paths_Paths+148)($3)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	addu	$8,$16,12
	lui	$3,%hi(GameSetup_gData) # high
	addiu	$5,$3,%lo(GameSetup_gData) # low
	addu	$11,$5,444
	move	$12,$0
	move	$17,$2
	lw	$3,0($16)
	lw	$4,4($16)
	lw	$2,428($5)
	lw	$9,0($17)
	sll	$3,$3,2
	addu	$8,$8,$3
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,2
	lw	$4,432($5)
	addu	$8,$8,$3
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,2
	subu	$3,$3,$4
	sll	$3,$3,2
	.set	noreorder
	.set	nomacro
	blez	$2,$L613
	addu	$8,$8,$3
	.set	macro
	.set	reorder

	addu	$10,$17,4
	li	$13,-1			# 0xffffffff
	move	$14,$5
	addu	$6,$14,456
	addu	$7,$8,1
$L614:
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L627
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$5,0($8)
	move	$3,$10
$L620:
	lb	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L628
	sltu	$2,$4,$9
	.set	macro
	.set	reorder

	addu	$4,$4,1
	sltu	$2,$4,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	addu	$3,$3,204
	.set	macro
	.set	reorder

	sltu	$2,$4,$9
$L628:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	sll	$2,$4,1
	.set	macro
	.set	reorder

$L627:
	move	$4,$0
	sll	$2,$4,1
$L629:
	addu	$2,$2,$4
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$10
	lbu	$2,1($2)
	#nop
	sw	$2,0($11)
	lbu	$2,0($7)
	#nop
	sw	$2,-8($6)
	lbu	$2,1($7)
	#nop
	sw	$2,4($6)
	lh	$2,3($7)
	#nop
	sw	$2,8($6)
	lw	$3,12($14)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L624
	lh	$2,5($7)
	#nop
	sw	$2,12($6)
	lh	$2,7($7)
	#nop
	sw	$2,16($6)
	lh	$2,9($7)
	.set	noreorder
	.set	nomacro
	j	$L625
	sw	$2,20($6)
	.set	macro
	.set	reorder

$L624:
	sw	$13,12($6)
	sw	$13,16($6)
	sw	$13,20($6)
$L625:
	addu	$8,$8,44
	addu	$11,$11,52
	sll	$3,$4,1
	lhu	$2,13($7)
	addu	$3,$3,$4
	sw	$2,24($6)
	lw	$2,15($7)
	addu	$5,$12,1
	sw	$2,28($6)
	lw	$2,19($7)
	move	$12,$5
	sw	$2,32($6)
	lw	$2,23($7)
	sll	$5,$5,16
	sw	$2,36($6)
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$3,$3,2
	lbu	$2,0($7)
	addu	$3,$3,$10
	addu	$2,$3,$2
	lbu	$2,132($2)
	sra	$5,$5,16
	sw	$2,-4($6)
	lbu	$2,0($7)
	addu	$7,$7,44
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,68($3)
	lbu	$4,70($3)
	andi	$3,$2,0xff00
	or	$4,$4,$3
	andi	$2,$2,0x00ff
	sll	$2,$2,16
	or	$4,$4,$2
	sw	$4,0($6)
	lw	$2,428($14)
	#nop
	slt	$5,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L614
	addu	$6,$6,52
	.set	macro
	.set	reorder

$L613:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

$L610:
	lw	$31,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	NFS4_LoadPerps__Fv
	.text
	.ent	Nfs2_GameModuleStartUp__FPi
Nfs2_GameModuleStartUp__FPi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	move	$4,$0
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Audio_InitDriver__Fii
	move	$5,$4
	.set	macro
	.set	reorder

	jal	restoretextdraw
	jal	Platform_InitMemory__Fv
	jal	Platform_ResetDCTBuffer__Fv
	.set	noreorder
	.set	nomacro
	jal	GameSetup_StartUp__FPi
	move	$4,$16
	.set	macro
	.set	reorder

	jal	Replay_InitReplay__Fv
	jal	Nfs2_BefuddleCode__Fv
	jal	Loading_DrawLoadingScreen__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	jal	NFS4_LoadPerps__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	jal	Physics_CheckGamedata__Fv
	jal	Clock_SystemStartUp__Fv
	jal	AudioCmn_LoadGameSamples__Fv
	jal	CopSpeak_StartUp__Fv
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L631
	lw	$2,_6Speech_fgSpeech
	#nop
	bne	$2,$0,$L631
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,932			# 0x000003a4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__6Speech
	move	$4,$2
	.set	macro
	.set	reorder

	sw	$2,_6Speech_fgSpeech
$L631:
	jal	Render_InitPauseMenu__Fv
	jal	Render_InitTrackRender__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	jal	BWorld_Init__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	jal	Hrz_InitHorizon__Fv
	jal	Night_InitNightDriving__Fv
	jal	Weather_Init__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,7			# 0x00000007
	.set	macro
	.set	reorder

	jal	Sim_StartUp__Fv
	jal	Render_InitTrackRenderPostSim__Fv
	jal	Hud_InitMap__Fv
	jal	SimQueue_StartUp__Fv
	jal	largestunused
	move	$4,$2
	lui	$2,%hi(D_801131F8) # high
	lw	$3,%lo(D_801131F8)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L634
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L636
	ori	$2,$2,0x3000
	.set	macro
	.set	reorder

$L634:
	li	$2,45056			# 0x0000b000
$L636:
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	li	$4,24576			# 0x00006000
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	ori	$5,$5,0x4000
	lui	$6,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC4) # low
	.set	macro
	.set	reorder

$L633:
	lui	$5,%hi(GameSetup_gData) # high
	addiu	$5,$5,%lo(GameSetup_gData) # low
	lw	$4,264($5)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_BuildPlayList__FiPi
	addu	$5,$5,268
	.set	macro
	.set	reorder

	jal	largestunused
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Nfs2_GameModuleStartUp__FPi
	.text
	.ent	Nfs2_CleanUpGameModule__Fv
Nfs2_CleanUpGameModule__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Render_KillTrackRender__Fv
	jal	Render_KillPauseMenu__Fv
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,964($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L638
	move	$7,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gList) # high
	addiu	$10,$2,%lo(Cars_gList) # low
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	addiu	$9,$2,%lo(Cars_gNewCarStatsList) # low
	move	$8,$3
	sll	$6,$7,16
$L647:
	sra	$6,$6,16
	sll	$4,$6,2
	addu	$5,$4,$10
	lw	$3,0($5)
	#nop
	lw	$2,648($3)
	#nop
	lw	$2,0($2)
	#nop
	sw	$2,940($3)
	lw	$3,0($5)
	#nop
	lw	$2,648($3)
	#nop
	lw	$2,4($2)
	#nop
	sw	$2,944($3)
	lw	$3,0($5)
	#nop
	lw	$2,648($3)
	#nop
	lw	$2,88($2)
	#nop
	sw	$2,948($3)
	lw	$3,0($5)
	addu	$4,$4,$6
	lw	$2,608($3)
	sll	$4,$4,5
	sw	$2,952($3)
	lw	$2,0($5)
	addu	$4,$4,$9
	addu	$3,$2,844
	addu	$2,$2,1004
$L642:
	lw	$11,0($3)
	lw	$12,4($3)
	lw	$13,8($3)
	lw	$14,12($3)
	sw	$11,0($4)
	sw	$12,4($4)
	sw	$13,8($4)
	sw	$14,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L642
	addu	$4,$4,16
	.set	macro
	.set	reorder

	addu	$2,$7,1
	move	$7,$2
	sll	$2,$2,16
	lw	$3,964($8)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	sll	$6,$7,16
	.set	macro
	.set	reorder

$L638:
	jal	Replay_StoringReplay__Fv
	jal	AudioCmn_DeInit__Fv
	lw	$4,_6Speech_fgSpeech
	#nop
	beq	$4,$0,$L644
	.set	noreorder
	.set	nomacro
	jal	_._6Speech
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$0,_6Speech_fgSpeech
$L644:
	jal	CopSpeak_CleanUp__Fv
	jal	Clock_SystemCleanUp__Fv
	jal	GameSetup_CleanUp__Fv
	jal	Sim_CleanUp__Fv
	jal	Hrz_KillHorizon__Fv
	jal	BWorld_DeInit__Fv
	jal	Camera_Kill__Fv
	jal	Weather_DeInit__Fv
	jal	Audio_DeInitDriver__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Nfs2_CleanUpGameModule__Fv
	.text
	.ent	LoadFrontendOverlay__Fv
LoadFrontendOverlay__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	lui	$5,%hi(bigBuf) # high
	addiu	$5,$5,%lo(bigBuf) # low
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncloadfileat
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
$L649:
	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L648
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L649
$L648:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	LoadFrontendOverlay__Fv
	.text
	.ent	LoadOverlay__Fv
LoadOverlay__Fv:
	.frame	$sp,88,$31		# vars= 64, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$31,84($sp)
	.set	noreorder
	.set	nomacro
	jal	LoadFrontendOverlay__Fv
	sw	$16,80($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC6) # high
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC6) # low
	.set	macro
	.set	reorder

	la	$5,CF_DVLC
	.set	noreorder
	.set	nomacro
	jal	asyncloadfileat
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$16,$2
$L653:
	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L652
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L653
$L652:
	lw	$31,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	LoadOverlay__Fv
	.text
	.ent	NFS4_LoadingIcon__Fv
NFS4_LoadingIcon__Fv:
	.frame	$sp,144,$31		# vars= 88, regs= 3/0, args= 40, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	addu	$4,$sp,40
	lui	$2,%hi(Paths_Paths+148) # high
	lui	$5,%hi($LC7) # high
	lw	$6,%lo(Paths_Paths+148)($2)
	addiu	$5,$5,%lo($LC7) # low
	sw	$31,136($sp)
	sw	$17,132($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,128($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,40
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd+832) # high
	lbu	$5,%lo(frontEnd+832)($3)
	move	$17,$2
	slt	$2,$5,6
	bne	$2,$0,$L657
	move	$5,$0
$L657:
	.set	noreorder
	.set	nomacro
	jal	shapepointer
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,120
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$3,1024			# 0x00000400
	sh	$3,124($sp)
	li	$3,512			# 0x00000200
	move	$16,$2
	sh	$0,120($sp)
	sh	$0,122($sp)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$3,126($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$4
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	li	$6,512			# 0x00000200
	li	$7,240			# 0x000000f0
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	sw	$2,20($sp)
	sw	$2,24($sp)
	sw	$0,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_DirectSetEnvironment__Fiiiiiiiiii
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	settrans
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$16
	li	$6,210			# 0x000000d2
	lh	$2,4($4)
	li	$5,482			# 0x000001e2
	.set	noreorder
	.set	nomacro
	jal	movfxya
	subu	$5,$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	lw	$31,136($sp)
	lw	$17,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	NFS4_LoadingIcon__Fv
	.text
	.ent	NFS3_CheckForFileOperations__Fv
NFS3_CheckForFileOperations__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gFileMgr) # high
	addiu	$2,$2,%lo(gFileMgr) # low
	lw	$3,24($2)
	lw	$4,28($2)
	#nop
	sltu	$2,$3,$4
	beq	$2,$0,$L665
$L662:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$5
 #APP
	break 0x666
 nop
 #NO_APP
$L661:
	addu	$3,$3,4
	sltu	$2,$3,$4
	bne	$2,$0,$L662
$L665:
	j	$31
	.end	NFS3_CheckForFileOperations__Fv
	.text
	.ent	main
main:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__main
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Platform_DebuggerPollHost__Fv
	move	$21,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Nfs2_SystemNLibStartUp__Fv
	lui	$16,%hi(carManager) # high
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	Audio_InitDriver__Fii
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Audio_DeInitDriver__Fv
	addiu	$16,$16,%lo(carManager) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetVideoMode
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd+832) # high
	li	$2,255			# 0x000000ff
	.set	noreorder
	.set	nomacro
	jal	LoadFrontendOverlay__Fv
	sb	$2,%lo(frontEnd+832)($3)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,ComingIntoTheFrontEndTheVeryFirstTime
	.set	noreorder
	.set	nomacro
	jal	Initialize__11tCarManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	LoadDescription__11tCarManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FECheat_ActivateBonus__F10tCheatCode
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	move	$6,$5
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	jal	SetClassViewable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$17,%hi(tournamentManager) # high
	addiu	$17,$17,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	Initialize__18tTournamentManager
	move	$4,$17
	.set	macro
	.set	reorder

	la	$4,missionManager
	.set	noreorder
	.set	nomacro
	jal	Initialize__15tMissionManager
	lui	$16,%hi(trackManager) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(trackManager) # low
	.set	noreorder
	.set	nomacro
	jal	Initialize__13tTrackManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	LoadDescription__18tTournamentManager
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	LoadDescription__13tTrackManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitGraphics__Fv
	lui	$19,%hi(simVar) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_Menu__F21tFront_ProcessingType
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$22,%hi(GameSetup_gData) # high
	addiu	$17,$22,%lo(GameSetup_gData) # low
	li	$20,2			# 0x00000002
$L667:
	jal	NFS3_CheckForFileOperations__Fv
	jal	MinFront_ParseOptions__Fv
	lw	$3,gUseFrontend
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L670
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_BuildStream__FPi
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
$L670:
	lui	$4,%hi(trackManager) # high
	.set	noreorder
	.set	nomacro
	jal	ReleaseDescription__13tTrackManager
	addiu	$4,$4,%lo(trackManager) # low
	.set	macro
	.set	reorder

	la	$4,missionManager
	jal	ReleaseDescription__15tMissionManager
	lui	$4,%hi(tournamentManager) # high
	.set	noreorder
	.set	nomacro
	jal	ReleaseDescription__18tTournamentManager
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	.set	noreorder
	.set	nomacro
	jal	ReleaseDescription__11tCarManager
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	jal	NFS3_CheckForFileOperations__Fv
	.set	noreorder
	.set	nomacro
	jal	Nfs2_GameModuleStartUp__FPi
	move	$4,$16
	.set	macro
	.set	reorder

	jal	NFS3_CheckForFileOperations__Fv
	lw	$2,%lo(simVar)($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	lui	$2,%hi(Replay_ReplayInterface) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(Replay_ReplayInterface) # low
	li	$16,1			# 0x00000001
$L673:
	.set	noreorder
	.set	nomacro
	jal	Nfs2_ResetGame__Fv
	sw	$0,%lo(simVar)($19)
	.set	macro
	.set	reorder

	jal	Sim_MainGameLoop__Fv
	lw	$2,36($17)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L675
	lw	$2,40($17)
	#nop
	beq	$2,$0,$L674
$L675:
	lw	$2,%lo(simVar)($19)
	#nop
	beq	$2,$0,$L677
	lw	$2,40($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	lui	$2,%hi(simVar) # high
	.set	macro
	.set	reorder

$L677:
	lw	$2,40($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	sw	$20,36($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L679
	sw	$0,28($18)
	.set	macro
	.set	reorder

$L678:
	.set	noreorder
	.set	nomacro
	jal	Stats_GetNumOpponents__Fv
	sw	$16,28($18)
	.set	macro
	.set	reorder

	slt	$2,$2,2
	bne	$2,$0,$L679
	lw	$3,%lo(GameSetup_gData)($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L682
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L691
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

$L682:
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lw	$3,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$3,608($3)
	#nop
	andi	$3,$3,0x0200
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L679
	addiu	$4,$2,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L691
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L679
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

$L691:
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$2,976($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L683
	lui	$4,%hi($LC8) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L689
	addiu	$4,$4,%lo($LC8) # low
	.set	macro
	.set	reorder

$L683:
	lui	$4,%hi($LC9) # high
	addiu	$4,$4,%lo($LC9) # low
$L689:
	jal	AudioMus_PlaySong__FPc
$L679:
	sw	$20,Replay_ReplayMode
	sw	$16,%lo(simVar)($19)
	.set	noreorder
	.set	nomacro
	j	$L671
	sw	$0,40($17)
	.set	macro
	.set	reorder

$L674:
	sw	$0,28($18)
$L671:
	lui	$2,%hi(simVar) # high
$L690:
	lw	$2,%lo(simVar)($2)
	#nop
	bne	$2,$0,$L673
$L672:
	jal	Nfs2_CleanUpGameModule__Fv
	jal	NFS4_LoadingIcon__Fv
	jal	LoadOverlay__Fv
	jal	NFS3_CheckForFileOperations__Fv
	jal	Front_InitGraphicsAndDisplayLoading__Fv
	sll	$2,$21,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	Front_GetInGameVars__Fv
	sw	$2,36($17)
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	.set	noreorder
	.set	nomacro
	jal	LoadDescription__11tCarManager
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	.set	noreorder
	.set	nomacro
	jal	LoadDescription__18tTournamentManager
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	.set	noreorder
	.set	nomacro
	jal	LoadDescription__13tTrackManager
	addiu	$4,$4,%lo(trackManager) # low
	.set	macro
	.set	reorder

	lw	$2,quitType
	li	$4,1			# 0x00000001
	bne	$2,$4,$L687
	li	$4,2			# 0x00000002
$L687:
	jal	Front_Menu__F21tFront_ProcessingType
	lhu	$21,36($17)
	jal	NFS3_CheckForFileOperations__Fv
	j	$L667
	.end	main
