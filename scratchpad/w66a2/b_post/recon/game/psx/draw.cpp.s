	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\draw.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Draw_SetView__Fiiiiiiiii
	.align	2
	.globl	Draw_InitViews__Fv
	.sdata
	.align	2
$LC0:
	.ascii	"ot0\000"
	.align	2
$LC1:
	.ascii	"ot1\000"
	.text
	.align	2
	.globl	Draw_InitViewOT__Fv
	.align	2
	.globl	Draw_InitViewOTInGame__Fv
	.align	2
	.globl	Draw_DeInitViews__Fv
	.align	2
	.globl	Draw_DeInitViewsInGame__Fv
	.align	2
	.globl	Draw_GetDRAWENV__Fii
	.align	2
	.globl	Draw_SetViewMemBudget__Fii
	.align	2
	.globl	Draw_SetViewColor__Fiiii
	.sdata
	.align	2
$LC2:
	.ascii	"ps0\000"
	.align	2
$LC3:
	.ascii	"ps1\000"
	.text
	.align	2
	.globl	AllocatePrimitivesBuffer__Fv
	.align	2
	.globl	ClearPrimitivesBuffer__Fv
	.align	2
	.globl	ClearPlatformPrimitivesBuffer__Fv
	.align	2
	.globl	Draw_StartRenderingView__Fi
	.align	2
	.globl	Draw_StopRenderingView__Fi
	.align	2
	.globl	Draw_CheckFirstFrameRender__Fv
	.align	2
	.globl	Draw_StartFrameRender__Fv
	.align	2
	.globl	Draw_SetDrawSyncCallback__FPFv_v
	.align	2
	.globl	Draw_StopFrameRender__Fv
	.align	2
	.globl	Draw_DrawDirectScreen__FP8shapetblii
	.align	2
	.globl	Draw_DirectSetEnvironment__Fiiiiiiiiii
	.align	2
	.globl	Draw_SetEnvironment__Fiiiiiiii
	.align	2
	.globl	Draw_InitRenderEngine__Fiiiiii
	.align	2
	.globl	Draw_RestartRenderEngine__Fv
	.align	2
	.globl	Draw_DeInitRenderEngine__Fv
	.align	2
	.globl	Draw_InitLibRender__Fv
	.globl	Draw_gDoVSync
	.sdata
	.align	2
Draw_gDoVSync:
	.space	4
	.globl	Draw_gMidGroundOtz
	.align	2
Draw_gMidGroundOtz:
	.space	4
	.globl	Draw_gViewOtSize
	.align	2
Draw_gViewOtSize:
	.space	4
	.globl	gFlip
	.align	2
gFlip:
	.space	4
	.globl	Draw_gMaxPrim
	.align	2
Draw_gMaxPrim:
	.space	4
	.globl	Draw_gNumView
	.align	2
Draw_gNumView:
	.space	4
	.globl	Draw_gSyncCallback
	.align	2
Draw_gSyncCallback:
	.space	4
	.globl	gLoop
	.align	2
gLoop:
	.space	4
	.globl	gTotalMem
	.align	2
gTotalMem:
	.space	4

	.extern	timerhz, 4
	.extern	Draw_gPlayer2View, 4
	.extern	Draw_gPlayer1View, 4
	.extern	gEnviro, 48
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	Draw_SetView__Fiiiiiiiii
Draw_SetView__Fiiiiiiiii:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lw	$2,Draw_gNumView
	subu	$sp,$sp,64
	sw	$19,36($sp)
	lw	$19,80($sp)
	sw	$20,40($sp)
	lw	$20,84($sp)
	sw	$22,48($sp)
	lw	$22,88($sp)
	move	$3,$5
	sw	$fp,56($sp)
	move	$fp,$6
	sw	$21,44($sp)
	lw	$21,92($sp)
	move	$5,$4
	sw	$23,52($sp)
	lw	$23,96($sp)
	move	$6,$3
	sw	$31,60($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sw	$7,76($sp)
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,3
	addu	$16,$16,$2
	sll	$16,$16,3
	lui	$2,%hi(Draw_gView) # high
	addiu	$2,$2,%lo(Draw_gView) # low
	addu	$16,$16,$2
	addu	$18,$16,8
	move	$4,$18
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	SetDefDrawEnv
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	addu	$17,$16,100
	move	$4,$17
	move	$5,$fp
	lw	$6,76($sp)
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	SetDefDrawEnv
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	sb	$0,25($18)
	sb	$0,26($18)
	sb	$0,27($18)
	sb	$0,25($17)
	sb	$0,26($17)
	sb	$0,27($17)
	sb	$21,24($17)
	sb	$21,24($18)
	sb	$22,22($17)
	sb	$22,22($18)
	lw	$2,Draw_gNumView
	sw	$23,0($16)
	sw	$0,4($16)
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
	addu	$3,$2,1
	sw	$3,Draw_gNumView
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Draw_SetView__Fiiiiiiiii
	.text
	.ent	Draw_InitViews__Fv
Draw_InitViews__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,Draw_gNumView
	j	$31
	.end	Draw_InitViews__Fv
	.text
	.ent	Draw_InitViewOT__Fv
Draw_InitViewOT__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Draw_gView) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Draw_gView) # low
	sw	$31,24($sp)
$L603:
	lw	$2,Draw_gNumView
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	lui	$4,%hi($LC0) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC0) # low
	li	$6,16			# 0x00000010
	lw	$5,0($16)
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,2
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	lw	$5,0($16)
	li	$6,16			# 0x00000010
	sw	$2,192($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,2
	.set	macro
	.set	reorder

	sw	$2,196($16)
	.set	noreorder
	.set	nomacro
	j	$L603
	addu	$16,$16,200
	.set	macro
	.set	reorder

$L602:
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

	.end	Draw_InitViewOT__Fv
	.text
	.ent	Draw_InitViewOTInGame__Fv
Draw_InitViewOTInGame__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Draw_gView) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Draw_gView) # low
	sw	$31,24($sp)
$L607:
	lw	$2,Draw_gNumView
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	lui	$5,%hi($LC0) # high
	.set	macro
	.set	reorder

	addiu	$5,$5,%lo($LC0) # low
	lw	$4,0($16)
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	jal	Platform_ReserveMemory__FiPc
	sll	$4,$4,2
	.set	macro
	.set	reorder

	lui	$5,%hi($LC1) # high
	lw	$4,0($16)
	addiu	$5,$5,%lo($LC1) # low
	sw	$2,192($16)
	.set	noreorder
	.set	nomacro
	jal	Platform_ReserveMemory__FiPc
	sll	$4,$4,2
	.set	macro
	.set	reorder

	sw	$2,196($16)
	.set	noreorder
	.set	nomacro
	j	$L607
	addu	$16,$16,200
	.set	macro
	.set	reorder

$L606:
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

	.end	Draw_InitViewOTInGame__Fv
	.text
	.ent	Draw_DeInitViews__Fv
Draw_DeInitViews__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Draw_gView) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Draw_gView) # low
	sw	$31,24($sp)
$L611:
	lw	$2,Draw_gNumView
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L610
	lw	$4,192($16)
	#nop
	beq	$4,$0,$L613
	jal	purgememadr
$L613:
	lw	$4,196($16)
	#nop
	beq	$4,$0,$L614
	jal	purgememadr
$L614:
	sw	$0,192($16)
	sw	$0,196($16)
	addu	$16,$16,200
	.set	noreorder
	.set	nomacro
	j	$L611
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L610:
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

	.end	Draw_DeInitViews__Fv
	.text
	.ent	Draw_DeInitViewsInGame__Fv
Draw_DeInitViewsInGame__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	lw	$5,Draw_gNumView
	lui	$2,%hi(Draw_gView) # high
	addiu	$3,$2,%lo(Draw_gView) # low
$L617:
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L620
	addu	$4,$4,1
	.set	macro
	.set	reorder

	sw	$0,192($3)
	sw	$0,196($3)
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$3,$3,200
	.set	macro
	.set	reorder

$L620:
	j	$31
	.end	Draw_DeInitViewsInGame__Fv
	.text
	.ent	Draw_GetDRAWENV__Fii
Draw_GetDRAWENV__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,3
	addu	$3,$3,$4
	sll	$3,$3,3
	lui	$2,%hi(Draw_gView+8) # high
	addiu	$2,$2,%lo(Draw_gView+8) # low
	addu	$3,$3,$2
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,3
	subu	$2,$2,$5
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	Draw_GetDRAWENV__Fii
	.text
	.ent	Draw_SetViewMemBudget__Fii
Draw_SetViewMemBudget__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(Draw_gView) # high
	addiu	$3,$3,%lo(Draw_gView) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,4($2)
	.set	macro
	.set	reorder

	.end	Draw_SetViewMemBudget__Fii
	.text
	.ent	Draw_SetViewColor__Fiiii
Draw_SetViewColor__Fiiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,3
	lui	$3,%hi(Draw_gView) # high
	addiu	$3,$3,%lo(Draw_gView) # low
	addu	$3,$2,$3
	lbu	$2,32($3)
	#nop
	beq	$2,$0,$L626
	sb	$5,33($3)
	sb	$6,34($3)
	sb	$7,35($3)
$L626:
	lbu	$2,124($3)
	#nop
	beq	$2,$0,$L629
	sb	$5,125($3)
	sb	$6,126($3)
	sb	$7,127($3)
$L629:
	j	$31
	.end	Draw_SetViewColor__Fiiii
	.text
	.ent	AllocatePrimitivesBuffer__Fv
AllocatePrimitivesBuffer__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L631
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	jal	Draw_InitViewOT__Fv
	.set	noreorder
	.set	nomacro
	j	$L640
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

$L631:
	jal	Draw_InitViewOTInGame__Fv
	lui	$2,%hi(GameSetup_gData+12) # high
$L640:
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L633
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L638
	ori	$2,$2,0x2500
	.set	macro
	.set	reorder

$L633:
	li	$2,65536			# 0x00010000
	ori	$2,$2,0xf600
$L638:
	sw	$2,gTotalMem
	lui	$5,%hi($LC2) # high
	lw	$4,gTotalMem
	.set	noreorder
	.set	nomacro
	jal	Platform_ReserveMemory__FiPc
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	lui	$5,%hi($LC3) # high
	addiu	$5,$5,%lo($LC3) # low
	lui	$16,%hi(gEnviro) # high
	lw	$4,gTotalMem
	addiu	$16,$16,%lo(gEnviro) # low
	.set	noreorder
	.set	nomacro
	jal	Platform_ReserveMemory__FiPc
	sw	$2,20($16)
	.set	macro
	.set	reorder

	sw	$2,44($16)
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L635
	lui	$5,%hi(Draw_gView) # high
	.set	macro
	.set	reorder

	addiu	$5,$5,%lo(Draw_gView) # low
	lw	$3,Draw_gPlayer1View
	lw	$4,gTotalMem
	sll	$2,$3,$2
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$5
	sra	$4,$4,1
	lw	$3,Draw_gPlayer2View
	addu	$4,$4,-6656
	sw	$4,4($2)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$L639
	addu	$2,$2,$5
	.set	macro
	.set	reorder

$L635:
	lw	$3,Draw_gPlayer1View
	lw	$4,gTotalMem
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	lui	$3,%hi(Draw_gView) # high
	addiu	$3,$3,%lo(Draw_gView) # low
	addu	$2,$2,$3
	addu	$4,$4,-6656
$L639:
	sw	$4,4($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AllocatePrimitivesBuffer__Fv
	.text
	.ent	ClearPrimitivesBuffer__Fv
ClearPrimitivesBuffer__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$4,$0
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gEnviro) # high
	addiu	$16,$2,%lo(gEnviro) # low
	lw	$4,20($16)
	#nop
	beq	$4,$0,$L642
	jal	purgememadr
$L642:
	lw	$4,44($16)
	#nop
	beq	$4,$0,$L643
	jal	purgememadr
$L643:
	sw	$0,44($16)
	.set	noreorder
	.set	nomacro
	jal	Draw_DeInitViews__Fv
	sw	$0,20($16)
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

	.end	ClearPrimitivesBuffer__Fv
	.text
	.ent	ClearPlatformPrimitivesBuffer__Fv
ClearPlatformPrimitivesBuffer__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(gEnviro) # high
	addiu	$2,$2,%lo(gEnviro) # low
	sw	$0,44($2)
	sw	$0,20($2)
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L646
	jal	Draw_DeInitViews__Fv
	j	$L645
$L646:
	jal	Draw_DeInitViewsInGame__Fv
$L645:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ClearPlatformPrimitivesBuffer__Fv
	.text
	.ent	Draw_StartRenderingView__Fi
Draw_StartRenderingView__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	sll	$2,$8,1
	addu	$2,$2,$8
	sll	$2,$2,3
	addu	$2,$2,$8
	sll	$2,$2,3
	lui	$3,%hi(Draw_gView) # high
	addiu	$3,$3,%lo(Draw_gView) # low
	addu	$6,$2,$3
	lw	$2,0($6)
	#nop
	sll	$3,$2,3
	subu	$5,$3,$2
	sw	$2,Draw_gViewOtSize
	.set	noreorder
	.set	nomacro
	bgez	$5,$L650
	li	$7,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	addu	$5,$5,7
$L650:
	lhu	$2,12($6)
	lw	$4,Draw_gPlayer1View
	sh	$2,16($7)
	lw	$2,gFlip
	lhu	$3,14($6)
	sll	$2,$2,2
	addu	$2,$6,$2
	sh	$3,18($7)
	lw	$3,192($2)
	sra	$2,$5,3
	sw	$2,Draw_gMidGroundOtz
	.set	noreorder
	.set	nomacro
	beq	$8,$4,$L651
	sw	$3,0($7)
	.set	macro
	.set	reorder

	lw	$2,Draw_gPlayer2View
	#nop
	beq	$8,$2,$L651
	lw	$2,Draw_gMaxPrim
	.set	noreorder
	.set	nomacro
	j	$L655
	sw	$2,8($7)
	.set	macro
	.set	reorder

$L651:
	lw	$2,4($7)
	lw	$3,4($6)
	#nop
	addu	$2,$2,$3
	sw	$2,8($7)
$L655:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,12($7)
	.set	macro
	.set	reorder

	.end	Draw_StartRenderingView__Fi
	.text
	.ent	Draw_StopRenderingView__Fi
Draw_StopRenderingView__Fi:
	.frame	$sp,120,$31		# vars= 96, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	addu	$7,$sp,16
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,3
	lui	$3,%hi(Draw_gView) # high
	addiu	$3,$3,%lo(Draw_gView) # low
	lw	$4,gFlip
	addu	$5,$2,$3
	sw	$31,112($sp)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$5,$2
	addu	$3,$2,8
	addu	$2,$2,88
$L657:
	lw	$10,0($3)
	lw	$11,4($3)
	lw	$12,8($3)
	lw	$13,12($3)
	sw	$10,0($7)
	sw	$11,4($7)
	sw	$12,8($7)
	sw	$13,12($7)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L657
	addu	$7,$7,16
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	li	$8,-16777216			# 0xff000000
	lw	$10,0($3)
	lw	$11,4($3)
	lw	$12,8($3)
	sw	$10,0($7)
	sw	$11,4($7)
	sw	$12,8($7)
	lw	$2,0($5)
	lw	$7,528482304
	lw	$4,0($9)
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$3,0($4)
	lw	$2,-4($2)
	and	$3,$3,$8
	and	$2,$2,$6
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$5,0($5)
	addu	$3,$4,64
	sll	$5,$5,2
	addu	$5,$5,$7
	lw	$2,-4($5)
	and	$6,$4,$6
	sw	$3,0($9)
	and	$2,$2,$8
	or	$2,$2,$6
	sw	$2,-4($5)
	.set	noreorder
	.set	nomacro
	jal	SetDrawEnv
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$31,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Draw_StopRenderingView__Fi
	.text
	.ent	Draw_CheckFirstFrameRender__Fv
Draw_CheckFirstFrameRender__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 2/0, args= 40, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$3,gFlip
	li	$2,-1			# 0xffffffff
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L659
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	li	$4,320			# 0x00000140
	li	$5,256			# 0x00000100
	move	$6,$4
	li	$7,240			# 0x000000f0
	li	$16,1			# 0x00000001
	sw	$16,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$0,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_DirectSetEnvironment__Fiiiiiiiiii
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,256			# 0x00000100
	li	$6,320			# 0x00000140
	li	$7,240			# 0x000000f0
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	sw	$0,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_DirectSetEnvironment__Fiiiiiiiiii
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	sw	$16,gFlip
	jal	AllocatePrimitivesBuffer__Fv
$L659:
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Draw_CheckFirstFrameRender__Fv
	.text
	.ent	Draw_StartFrameRender__Fv
Draw_StartFrameRender__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Draw_gView) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Draw_gView) # low
	sw	$31,24($sp)
$L663:
	lw	$2,Draw_gNumView
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$2,gFlip
	lw	$5,0($16)
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$4,192($2)
	.set	noreorder
	.set	nomacro
	jal	ClearOTagR
	addu	$16,$16,200
	.set	macro
	.set	reorder

	j	$L663
$L664:
	lui	$3,%hi(gEnviro) # high
	addiu	$3,$3,%lo(gEnviro) # low
	lw	$4,gFlip
	lw	$31,24($sp)
	lw	$17,20($sp)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,20($2)
	#nop
	sw	$3,528482308
	lw	$2,20($2)
	lw	$3,gTotalMem
	lw	$16,16($sp)
	addu	$2,$2,$3
	sw	$2,Draw_gMaxPrim
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Draw_StartFrameRender__Fv
	.text
	.ent	Draw_SetDrawSyncCallback__FPFv_v
Draw_SetDrawSyncCallback__FPFv_v:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,Draw_gSyncCallback
	j	$31
	.end	Draw_SetDrawSyncCallback__FPFv_v
	.text
	.ent	Draw_StopFrameRender__Fv
Draw_StopFrameRender__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$4,$0
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,gLoop
	lw	$3,Draw_gSyncCallback
	addu	$2,$2,1
	sw	$2,gLoop
	beq	$3,$0,$L669
	jal	$31,$3
$L669:
	lw	$2,Draw_gDoVSync
	#nop
	beq	$2,$0,$L670
	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

$L670:
	lw	$3,gFlip
	move	$17,$0
	lui	$4,%hi(gEnviro) # high
	addiu	$4,$4,%lo(gEnviro) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	jal	PutDispEnv
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(Draw_gView) # high
	addiu	$16,$2,%lo(Draw_gView) # low
$L671:
	lw	$2,Draw_gNumView
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$2,gFlip
	lw	$3,0($16)
	sll	$2,$2,2
	addu	$2,$16,$2
	addu	$16,$16,200
	lw	$4,192($2)
	sll	$3,$3,2
	addu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	jal	DrawOTag
	addu	$4,$4,-4
	.set	macro
	.set	reorder

	j	$L671
$L672:
	li	$2,1			# 0x00000001
	lw	$3,gFlip
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	subu	$2,$2,$3
	sw	$2,gFlip
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Draw_StopFrameRender__Fv
	.text
	.ent	Draw_DrawDirectScreen__FP8shapetblii
Draw_DrawDirectScreen__FP8shapetblii:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	addu	$6,$6,256
	move	$7,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramcf__FP8shapetbliiii
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Draw_DrawDirectScreen__FP8shapetblii
	.text
	.ent	Draw_DirectSetEnvironment__Fiiiiiiiiii
Draw_DirectSetEnvironment__Fiiiiiiiiii:
	.frame	$sp,152,$31		# vars= 96, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,152
	lw	$2,168($sp)
	sw	$21,140($sp)
	lw	$21,172($sp)
	sw	$16,120($sp)
	lw	$16,176($sp)
	sw	$17,124($sp)
	move	$17,$4
	sw	$18,128($sp)
	move	$18,$5
	sw	$19,132($sp)
	move	$19,$6
	sw	$20,136($sp)
	move	$20,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L677
	sw	$31,144($sp)
	.set	macro
	.set	reorder

	sw	$20,16($sp)
	addu	$4,$sp,24
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	SetDefDrawEnv
	move	$7,$19
	.set	macro
	.set	reorder

	beq	$16,$0,$L678
	lw	$2,180($sp)
	#nop
	sb	$2,49($sp)
	lw	$2,184($sp)
	#nop
	sb	$2,50($sp)
	lw	$2,188($sp)
	#nop
	sb	$2,51($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L679
	sb	$2,48($sp)
	.set	macro
	.set	reorder

$L678:
	sb	$0,48($sp)
$L679:
	.set	noreorder
	.set	nomacro
	jal	PutDrawEnv
	addu	$4,$sp,24
	.set	macro
	.set	reorder

$L677:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L676
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$6,$18
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetDispMask
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PutDispEnv
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$4,timerhz
	.set	noreorder
	.set	nomacro
	jal	timedwait
	sra	$4,$4,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetDispMask
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L676:
	lw	$31,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder

	.end	Draw_DirectSetEnvironment__Fiiiiiiiiii
	.text
	.ent	Draw_SetEnvironment__Fiiiiiiii
Draw_SetEnvironment__Fiiiiiiii:
	.frame	$sp,48,$31		# vars= 0, regs= 1/0, args= 40, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$8,$4
	move	$9,$5
	lw	$2,64($sp)
	lw	$3,68($sp)
	lw	$4,72($sp)
	lw	$5,76($sp)
	sw	$6,16($sp)
	move	$6,$8
	sw	$7,20($sp)
	move	$7,$9
	sw	$31,40($sp)
	sw	$4,32($sp)
	move	$4,$0
	sw	$5,36($sp)
	li	$5,256			# 0x00000100
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_DirectSetEnvironment__Fiiiiiiiiii
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Draw_SetEnvironment__Fiiiiiiii
	.text
	.ent	Draw_InitRenderEngine__Fiiiiii
Draw_InitRenderEngine__Fiiiiii:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$2,$4
	move	$3,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$20,40($sp)
	move	$20,$7
	sw	$16,24($sp)
	lui	$16,%hi(gEnviro) # high
	addiu	$16,$16,%lo(gEnviro) # low
	move	$4,$16
	move	$5,$2
	sw	$17,28($sp)
	lw	$17,64($sp)
	move	$6,$3
	sw	$18,32($sp)
	lw	$18,68($sp)
	li	$2,-1			# 0xffffffff
	sw	$31,44($sp)
	sw	$2,gFlip
	sw	$0,20($16)
	sw	$0,44($16)
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$18,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$16,24
	move	$5,$19
	move	$6,$20
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$18,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw_SetDrawSyncCallback__FPFv_v
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Draw_InitRenderEngine__Fiiiiii
	.text
	.ent	Draw_RestartRenderEngine__Fv
Draw_RestartRenderEngine__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Draw_RestartRenderEngine__Fv
	.text
	.ent	Draw_DeInitRenderEngine__Fv
Draw_DeInitRenderEngine__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	ClearPlatformPrimitivesBuffer__Fv
	lw	$31,16($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,gFlip
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw_DeInitRenderEngine__Fv
	.text
	.ent	Draw_InitLibRender__Fv
Draw_InitLibRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,1			# 0x00000001
	sw	$31,16($sp)
	sw	$2,gLoop
	jal	InitGeom
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw_InitLibRender__Fv
