	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\dashhud.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	DashHUD_InitHUD__Fv
	.align	2
	.globl	DashHUD_KillHUD__Fv
	.align	2
	.globl	DashHUD_ResetHUD__Fv
	.align	2
	.globl	DashHUD_ToggleHud__Fi
	.align	2
	.globl	DashHUD_CheckWrongWay__Fi
	.align	2
	.globl	DashHUD_HUDCalc__Fi
	.globl	resethud
	.sdata
	.align	2
resethud:
	.space	4
	.globl	DashHUD_gInfo
	.data
	.align	2
DashHUD_gInfo:
	.space	108

	.extern	simGlobal, 24
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Camera_gInfo, 544
	.extern	Replay_ReplayMode, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	DashHUD_InitHUD__Fv
DashHUD_InitHUD__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$4,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$8,$2,%lo(GameSetup_gData) # low
	sw	$31,16($sp)
	lw	$2,12($8)
	lui	$3,%hi(DashHUD_gInfo) # high
	xori	$2,$2,0x0001
	sltu	$2,$2,1
	sw	$2,%lo(DashHUD_gInfo)($3)
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	li	$6,131072			# 0x00020000
	ori	$6,$6,0x3ca5
	li	$9,1			# 0x00000001
	li	$5,196608			# 0x00030000
	ori	$5,$5,0x9999
	move	$7,$3
	move	$3,$8
$L603:
	lw	$2,1092($3)
	#nop
	bne	$2,$0,$L604
	.set	noreorder
	.set	nomacro
	j	$L605
	sw	$6,1096($3)
	.set	macro
	.set	reorder

$L604:
	bne	$2,$9,$L605
	sw	$5,1096($3)
$L605:
	lw	$2,%lo(DashHUD_gInfo)($7)
	addu	$4,$4,1
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	addu	$3,$3,180
	.set	macro
	.set	reorder

	lui	$2,%hi(DashHUD_gInfo) # high
$L612:
	addiu	$4,$2,%lo(DashHUD_gInfo) # low
	lw	$2,%lo(DashHUD_gInfo)($2)
	li	$3,1			# 0x00000001
	sw	$3,28($4)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	sw	$3,32($4)
	.set	macro
	.set	reorder

	sw	$0,36($4)
	.set	noreorder
	.set	nomacro
	j	$L609
	sw	$0,40($4)
	.set	macro
	.set	reorder

$L608:
	sw	$3,36($4)
$L609:
	lui	$3,%hi(DashHUD_gInfo) # high
	lw	$2,Replay_ReplayMode
	addiu	$3,$3,%lo(DashHUD_gInfo) # low
	sw	$0,44($3)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	sw	$0,48($3)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+232) # high
	lw	$2,%lo(GameSetup_gData+232)($2)
	.set	noreorder
	.set	nomacro
	j	$L611
	sw	$2,92($3)
	.set	macro
	.set	reorder

$L610:
	sw	$0,92($3)
$L611:
	lui	$2,%hi(DashHUD_gInfo) # high
	lui	$3,%hi(GameSetup_gData+4) # high
	lw	$3,%lo(GameSetup_gData+4)($3)
	addiu	$2,$2,%lo(DashHUD_gInfo) # low
	sw	$0,96($2)
	sw	$0,100($2)
	sw	$0,104($2)
	.set	noreorder
	.set	nomacro
	jal	HudPmx_InitTextures__Fv
	sw	$3,60($2)
	.set	macro
	.set	reorder

	jal	Hud_Init0__Fv
	jal	Hud_Init__Fv
	jal	Hud_PositionMap__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DashHUD_InitHUD__Fv
	.text
	.ent	DashHUD_KillHUD__Fv
DashHUD_KillHUD__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Hud_Kill__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DashHUD_KillHUD__Fv
	.text
	.ent	DashHUD_ResetHUD__Fv
DashHUD_ResetHUD__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	lui	$2,%hi(GameSetup_gData+232) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+232)($2)
	lui	$2,%hi(DashHUD_gInfo+92) # high
	.set	noreorder
	.set	nomacro
	j	$L616
	sw	$3,%lo(DashHUD_gInfo+92)($2)
	.set	macro
	.set	reorder

$L615:
	lui	$2,%hi(DashHUD_gInfo+92) # high
	sw	$0,%lo(DashHUD_gInfo+92)($2)
$L616:
	lui	$3,%hi(DashHUD_gInfo) # high
	lw	$2,Replay_ReplayMode
	addiu	$3,$3,%lo(DashHUD_gInfo) # low
	sw	$0,100($3)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	sw	$0,104($3)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,28($3)
	sw	$2,32($3)
$L618:
	j	$31
	.end	DashHUD_ResetHUD__Fv
	.text
	.ent	DashHUD_ToggleHud__Fi
DashHUD_ToggleHud__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(DashHUD_gInfo) # high
	addiu	$2,$2,%lo(DashHUD_gInfo) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$2,28($4)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,28($4)
	.set	macro
	.set	reorder

	.end	DashHUD_ToggleHud__Fi
	.text
	.ent	DashHUD_CheckWrongWay__Fi
DashHUD_CheckWrongWay__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(Camera_gInfo) # high
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sll	$2,$4,4
	addu	$2,$2,$4
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$3,1008($2)
	#nop
	slt	$2,$3,64
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	move	$5,$0
	.set	macro
	.set	reorder

	slt	$2,$3,148
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L621:
	lui	$2,%hi(DashHUD_gInfo) # high
	addiu	$2,$2,%lo(DashHUD_gInfo) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$2,44($3)
	#nop
	beq	$5,$2,$L623
	sw	$5,44($3)
$L623:
	j	$31
	.end	DashHUD_CheckWrongWay__Fi
	.text
	.ent	DashHUD_HUDCalc__Fi
DashHUD_HUDCalc__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(DashHUD_gInfo+28) # high
	addiu	$5,$2,%lo(DashHUD_gInfo+28) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L624
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$17,0($3)
	#nop
	lw	$2,864($17)
	addu	$4,$5,-28
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L626
	sw	$2,56($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,56($4)
$L626:
	lw	$2,56($4)
	lw	$3,60($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	sw	$3,56($4)
$L646:
	lw	$3,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$3,512
	beq	$2,$0,$L628
	sw	$0,52($4)
	.set	noreorder
	.set	nomacro
	j	$L629
	sw	$0,20($4)
	.set	macro
	.set	reorder

$L628:
	lw	$5,864($17)
	#nop
	beq	$5,$0,$L630
	lw	$2,868($17)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,320
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	lw	$3,912($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L648
	lui	$3,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	addu	$2,$5,-1
$L647:
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$3,872($2)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$6,$2,%lo(GameSetup_gData) # low
	sw	$3,52($4)
	lw	$2,%lo(GameSetup_gData)($2)
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L649
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,92($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	slt	$2,$3,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L650
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	lw	$2,188($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L633
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

$L634:
	lui	$2,%hi(DashHUD_gInfo) # high
$L650:
	addiu	$2,$2,%lo(DashHUD_gInfo) # low
	lw	$4,52($2)
	li	$3,1			# 0x00000001
	sw	$3,20($2)
	.set	noreorder
	.set	nomacro
	j	$L629
	sw	$4,92($2)
	.set	macro
	.set	reorder

$L633:
$L649:
	addiu	$4,$2,%lo(DashHUD_gInfo) # low
	lw	$3,92($4)
	lw	$2,52($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L651
	lui	$3,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,20($4)
$L651:
	lw	$2,852($17)
	lw	$3,%lo(simGlobal+4)($3)
	addu	$2,$2,192
	slt	$2,$2,$3
	beq	$2,$0,$L636
	sw	$0,20($4)
$L636:
	lw	$2,20($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
	andi	$2,$3,0x0010
	.set	macro
	.set	reorder

	beq	$2,$0,$L637
	lw	$2,resethud
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,resethud
	.set	noreorder
	.set	nomacro
	j	$L645
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

$L637:
	lw	$2,resethud
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	j	$L644
$L630:
	lui	$3,%hi(DashHUD_gInfo) # high
$L648:
	addiu	$3,$3,%lo(DashHUD_gInfo) # low
	lw	$5,868($17)
	lui	$2,%hi(simGlobal+4) # high
	sw	$0,20($3)
	lw	$2,%lo(simGlobal+4)($2)
	lw	$4,resethud
	subu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L629
	sw	$2,52($3)
	.set	macro
	.set	reorder

$L644:
	sw	$0,resethud
$L629:
	lui	$2,%hi(simGlobal+4) # high
$L645:
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,868($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,320
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	lui	$2,%hi(DashHUD_gInfo) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(DashHUD_gInfo) # low
	lw	$3,56($4)
	lw	$2,60($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L652
	lui	$2,%hi(DashHUD_gInfo+24) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L642
	sw	$2,24($4)
	.set	macro
	.set	reorder

$L641:
	lui	$2,%hi(DashHUD_gInfo+24) # high
$L652:
	sw	$0,%lo(DashHUD_gInfo+24)($2)
$L642:
	.set	noreorder
	.set	nomacro
	jal	Stats_GetPosition__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$16,%hi(DashHUD_gInfo) # high
	addiu	$16,$16,%lo(DashHUD_gInfo) # low
	.set	noreorder
	.set	nomacro
	jal	Stats_GetNumOpponents__Fv
	sw	$2,84($16)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$16,68
	addu	$6,$16,80
	.set	noreorder
	.set	nomacro
	jal	Cars_InitDashData__FP8Car_tObjPiT1
	sw	$2,88($16)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$16,64
	addu	$6,$16,72
	.set	noreorder
	.set	nomacro
	jal	Cars_GetDashData__FP8Car_tObjPiN21
	addu	$7,$16,76
	.set	macro
	.set	reorder

	lw	$2,76($16)
	lh	$3,82($16)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sw	$2,76($16)
	sw	$3,80($16)
$L624:
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

	.end	DashHUD_HUDCalc__Fi
