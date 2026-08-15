	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\render.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Render_CreatePlayerViews__Fv
	.align	2
	.globl	Render_CreatePauseMenuViews__Fv
	.align	2
	.globl	Render_CreateViews__Fv
	.align	2
	.globl	Render_StartRenderingWorldView__Fi
	.align	2
	.globl	Render_StopRenderingWorldView__Fi
	.align	2
	.globl	Render_RenderWorld__FP13DRender_tView
	.align	2
	.globl	Render_RenderPlayerView__Fii
	.align	2
	.globl	Render_RenderDebugView__Fv
	.align	2
	.globl	Render_StartFrameRender__Fv
	.align	2
	.globl	Render_StopFrameRender__Fv
	.align	2
	.globl	Render_InitPauseMenu__Fv
	.align	2
	.globl	Render_RenderPauseMenuView__Fv
	.align	2
	.globl	Render_KillPauseMenu__Fv
	.align	2
	.globl	Render_Render__Fi
	.align	2
	.globl	FlareThing__Fv
	.align	2
	.globl	Render_InitTrackRender__Fv
	.align	2
	.globl	Render_RestartTrackRender__Fv
	.align	2
	.globl	Render_InitTrackRenderPostSim__Fv
	.align	2
	.globl	Render_KillTrackRender__Fv
	.align	2
	.globl	Render_InitLibRender__Fv
	.align	2
	.globl	StampImage__Fii
	.align	2
	.globl	Render_InitBlurMode__Fv
	.align	2
	.globl	Render_InsertDepthOfField__Fv
	.globl	Render_gMenuRenderFlag
	.sdata
	.align	2
Render_gMenuRenderFlag:
	.space	4
	.globl	Render_gPacketLenLo
	.align	1
Render_gPacketLenLo:
	.space	2
	.globl	Render_gPacketLenHi
	.align	1
Render_gPacketLenHi:
	.space	2
	.globl	gCView
	.data
	.align	2
gCView:
	.space	140
	.globl	Render_gBlurEffectDepth1
	.sdata
	.align	2
Render_gBlurEffectDepth1:
	.space	4
	.globl	Render_gBlurEffectDepth2
	.align	2
Render_gBlurEffectDepth2:
	.space	4
	.globl	Render_gBlurEffectMode
	.align	2
Render_gBlurEffectMode:
	.space	4
	.globl	Draw_gPlayer1View
	.align	2
Draw_gPlayer1View:
	.space	4
	.globl	Draw_gPlayer2View
	.align	2
Draw_gPlayer2View:
	.space	4
	.globl	gPauseMenuRect
	.align	1
gPauseMenuRect:
	.space	2
	.globl	D_8013D3D6
	.align	1
D_8013D3D6:
	.space	2
	.globl	D_8013D3D8
	.align	1
D_8013D3D8:
	.space	2
	.globl	D_8013D3DA
	.align	1
D_8013D3DA:
	.space	2
	.globl	gPauseRender
	.align	2
gPauseRender:
	.space	4
	.globl	Draw_gRearView
	.align	2
Draw_gRearView:
	.space	4
	.globl	Render_gDebugView
	.align	2
Render_gDebugView:
	.space	4
	.globl	Render_gPauseMenuView
	.align	2
Render_gPauseMenuView:
	.space	4
	.globl	Render_gPacketEnd
	.align	2
Render_gPacketEnd:
	.space	4
	.globl	Render_gWorldMat
	.data
	.align	2
Render_gWorldMat:
	.space	32
	.globl	Render_gNightMat
	.align	2
Render_gNightMat:
	.space	32
	.globl	Render_gCopMat
	.align	2
Render_gCopMat:
	.space	36
	.globl	INT_1f800084
	.sdata
	.align	2
INT_1f800084:
	.space	4
	.globl	INT_1f800088
	.align	2
INT_1f800088:
	.space	4
	.globl	INT_1f80008c
	.align	2
INT_1f80008c:
	.space	4
	.globl	INT_1f800090
	.align	2
INT_1f800090:
	.space	4

	.extern	gFlare_LensFlare, 128
	.extern	gMPauseUpdateNextTime, 4
	.extern	gMPauseUpdate, 4
	.extern	gFlip, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	Render_CreatePlayerViews__Fv
Render_CreatePlayerViews__Fv:
	.frame	$sp,64,$31		# vars= 0, regs= 5/0, args= 40, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$2,%lo(GameSetup_gData+12)($2)
	subu	$sp,$sp,64
	sw	$19,52($sp)
	li	$19,1			# 0x00000001
	sw	$31,56($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L601
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,256			# 0x00000100
	li	$6,320			# 0x00000140
	move	$7,$5
	move	$18,$6
	li	$17,120			# 0x00000078
	li	$16,2000			# 0x000007d0
	sw	$18,16($sp)
	sw	$17,20($sp)
	sw	$0,24($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetView__Fiiiiiiiii
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,376			# 0x00000178
	li	$6,320			# 0x00000140
	move	$7,$5
	sw	$2,Draw_gPlayer1View
	sw	$18,16($sp)
	sw	$17,20($sp)
	sw	$0,24($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetView__Fiiiiiiiii
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	j	$L603
$L601:
	move	$4,$0
	li	$5,256			# 0x00000100
	li	$6,320			# 0x00000140
	move	$7,$5
	move	$2,$6
	sw	$2,16($sp)
	li	$2,240			# 0x000000f0
	sw	$2,20($sp)
	li	$2,3000			# 0x00000bb8
	sw	$0,24($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetView__Fiiiiiiiii
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	sw	$2,Draw_gPlayer1View
	li	$2,-1			# 0xffffffff
$L603:
	sw	$2,Draw_gPlayer2View
	lw	$31,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Render_CreatePlayerViews__Fv
	.text
	.ent	Render_CreatePauseMenuViews__Fv
Render_CreatePauseMenuViews__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 1/0, args= 40, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	li	$2,320			# 0x00000140
	sw	$2,16($sp)
	li	$2,240			# 0x000000f0
	sw	$2,20($sp)
	li	$2,1			# 0x00000001
	move	$4,$0
	li	$5,256			# 0x00000100
	li	$6,320			# 0x00000140
	move	$7,$5
	sw	$31,40($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetView__Fiiiiiiiii
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	sw	$2,Render_gPauseMenuView
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Render_CreatePauseMenuViews__Fv
	.text
	.ent	Render_CreateViews__Fv
Render_CreateViews__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_InitViews__Fv
	jal	Render_CreatePlayerViews__Fv
	jal	Hud_CreateHudViews__Fv
	jal	Render_CreatePauseMenuViews__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_CreateViews__Fv
	.text
	.ent	Render_StartRenderingWorldView__Fi
Render_StartRenderingWorldView__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	lui	$16,%hi(gCView) # high
	addiu	$16,$16,%lo(gCView) # low
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Camera_SetCamera__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	jal	Track_AnimateTrackLighting__Fv
	.set	noreorder
	.set	nomacro
	jal	Draw_StartRenderingView__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	lw	$4,4($16)
	sw	$2,528482316
	jal	Fog_Update__Fi
	jal	DrawC_SetEnviroment__Fv
	jal	TrsProj_ResetTransPrecision__Fv
	.set	noreorder
	.set	nomacro
	jal	Night_SetEnviroment__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

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

	.end	Render_StartRenderingWorldView__Fi
	.text
	.ent	Render_StopRenderingWorldView__Fi
Render_StopRenderingWorldView__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_StopRenderingView__Fi
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_StopRenderingWorldView__Fi
	.text
	.ent	Render_RenderWorld__FP13DRender_tView
Render_RenderWorld__FP13DRender_tView:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorld_OnyxBuildFacets__FP13DRender_tView
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	Skidmark_OnyxBuildFacets__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetSp
	move	$4,$17
	.set	macro
	.set	reorder

	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	Souffle_InsertFacet__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetSp
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	R3DCar_InsertAllListFacet__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hrz_BuildHorizon__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	Weather_BuildWeather__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetSp
	move	$4,$17
	.set	macro
	.set	reorder

	jal	Render_InsertDepthOfField__Fv
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

	.end	Render_RenderWorld__FP13DRender_tView
	.text
	.ent	Render_RenderPlayerView__Fii
Render_RenderPlayerView__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	lui	$16,%hi(gCView) # high
	sw	$17,%lo(gCView)($16)
	addiu	$16,$16,%lo(gCView) # low
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Render_StartRenderingWorldView__Fi
	sw	$5,4($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Render_RenderWorld__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Render_StopRenderingWorldView__Fi
	move	$4,$17
	.set	macro
	.set	reorder

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

	.end	Render_RenderPlayerView__Fii
	.text
	.ent	Render_RenderDebugView__Fv
Render_RenderDebugView__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Render_RenderDebugView__Fv
	.text
	.ent	Render_StartFrameRender__Fv
Render_StartFrameRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	BWorld_StartLoop__Fv
	jal	Track_AnimateTextures__Fv
	jal	Souffle_DoSouffle__Fv
	jal	Draw_CheckFirstFrameRender__Fv
	jal	Draw_StartFrameRender__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_StartFrameRender__Fv
	.text
	.ent	Render_StopFrameRender__Fv
Render_StopFrameRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_StopFrameRender__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_StopFrameRender__Fv
	.text
	.ent	Render_InitPauseMenu__Fv
Render_InitPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	MPause_InitMPause__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_InitPauseMenu__Fv
	.text
	.ent	Render_RenderPauseMenuView__Fv
Render_RenderPauseMenuView__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$4,Render_gPauseMenuView
	lui	$2,%hi(gCView) # high
	sw	$31,20($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_StartRenderingView__Fi
	sw	$4,%lo(gCView)($2)
	.set	macro
	.set	reorder

	jal	MPause_Render__Fv
	lw	$4,Render_gPauseMenuView
	lw	$16,gFlip
	sw	$0,gFlip
	jal	Draw_StopRenderingView__Fi
	lw	$31,20($sp)
	sw	$16,gFlip
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_RenderPauseMenuView__Fv
	.text
	.ent	Render_KillPauseMenu__Fv
Render_KillPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	MPause_KillMPause__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_KillPauseMenu__Fv
	.text
	.ent	Render_Render__Fi
Render_Render__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L617
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,gPauseRender
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,320			# 0x00000140
	sh	$2,D_8013D3D8
	li	$2,240			# 0x000000f0
	sw	$16,gPauseRender
	sh	$0,gPauseMenuRect
	sh	$0,D_8013D3D6
	sh	$2,D_8013D3DA
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	jal	RPause_CopyBackToFrontBuffer__Fv
	jal	MPause_StartPauseMenu__Fv
	sw	$16,gMPauseUpdate
	sw	$0,gMPauseUpdateNextTime
$L618:
	lw	$3,gMPauseUpdate
	li	$2,78			# 0x0000004e
	sh	$2,gPauseMenuRect
	li	$2,98			# 0x00000062
	sh	$2,D_8013D3D6
	li	$2,164			# 0x000000a4
	sh	$2,D_8013D3D8
	li	$2,139			# 0x0000008b
	sh	$2,D_8013D3DA
	beq	$3,$0,$L616
	jal	RPause_StartPauseMenu__Fv
	jal	Render_RenderPauseMenuView__Fv
	jal	RPause_StopPauseMenu__Fv
	j	$L616
$L617:
	lw	$2,gPauseRender
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	sw	$0,gPauseRender
	j	$L616
$L621:
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L623
	jal	Render_StartFrameRender__Fv
	lw	$4,Draw_gPlayer1View
	.set	noreorder
	.set	nomacro
	jal	Render_RenderPlayerView__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,Draw_gPlayer2View
	.set	noreorder
	.set	nomacro
	j	$L624
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L623:
	jal	Render_StartFrameRender__Fv
	lw	$4,Draw_gPlayer1View
	move	$5,$0
$L624:
	jal	Render_RenderPlayerView__Fii
	jal	Hud_Render__Fv
	jal	Render_RenderDebugView__Fv
	jal	Render_StopFrameRender__Fv
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

	.end	Render_Render__Fi
	.text
	.ent	FlareThing__Fv
FlareThing__Fv:
	.frame	$sp,64,$31		# vars= 8, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$2,%lo(GameSetup_gData+12)($2)
	subu	$sp,$sp,64
	sw	$20,40($sp)
	li	$20,1			# 0x00000001
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L626
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$20,2			# 0x00000002
$L626:
	move	$17,$0
	lui	$2,%hi(gEnviro) # high
	addiu	$23,$2,%lo(gEnviro) # low
	li	$22,5			# 0x00000005
	lui	$2,%hi(gFlare_LensFlare) # high
	addiu	$21,$2,%lo(gFlare_LensFlare) # low
	addu	$19,$21,16
	move	$16,$21
$L627:
	slt	$2,$17,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L625
	addu	$18,$17,$21
	.set	macro
	.set	reorder

	lbu	$2,124($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$2,gFlip
	lhu	$4,8($16)
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,$23
	lhu	$2,0($3)
	#nop
	addu	$2,$2,$4
	addu	$2,$2,-2
	sh	$2,16($sp)
	lhu	$2,2($3)
	lhu	$3,10($16)
	addu	$4,$sp,16
	sh	$22,20($sp)
	sh	$22,22($sp)
	addu	$2,$2,$3
	addu	$2,$2,-2
	.set	noreorder
	.set	nomacro
	jal	StoreImage
	sh	$2,18($sp)
	.set	macro
	.set	reorder

	sb	$0,124($18)
$L629:
	addu	$19,$19,50
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L627
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L625:
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

	.end	FlareThing__Fv
	.text
	.ent	Render_InitTrackRender__Fv
Render_InitTrackRender__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sw	$31,24($sp)
	lw	$4,72($2)
	lw	$5,84($2)
	jal	TrackSpec_Load__Fii
	jal	Render_CreateViews__Fv
	li	$4,320			# 0x00000140
	li	$5,256			# 0x00000100
	move	$2,$4
	sw	$2,16($sp)
	li	$2,240			# 0x000000f0
	move	$6,$0
	move	$7,$5
	.set	noreorder
	.set	nomacro
	jal	Draw_InitRenderEngine__Fiiiiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	jal	DrawC_BuildRenderingData__Fv
	jal	Texture_InitTrackTexture__Fv
	jal	GenericPMX_LoadTexture__Fv
	jal	Souffle_InitTrackSouffle__Fv
	jal	Skidmark_InitSkidmark__Fv
	jal	TrgSfx_InitTrgSfx__Fv
	jal	DashHUD_InitHUD__Fv
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	jal	Fog_InitFogTriggers__Fv
	lui	$4,%hi(FlareThing__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	Draw_SetDrawSyncCallback__FPFv_v
	addiu	$4,$4,%lo(FlareThing__Fv) # low
	.set	macro
	.set	reorder

	jal	Render_InitBlurMode__Fv
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Render_InitTrackRender__Fv
	.text
	.ent	Render_RestartTrackRender__Fv
Render_RestartTrackRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_RestartRenderEngine__Fv
	jal	DepthCue_Init__Fv
	jal	Night_RestartNightDriving__Fv
	jal	Skidmark_RestartSkidmark__Fv
	jal	Souffle_RestartTrackSouffle__Fv
	jal	TrgSfx_RestartTrgSfx__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_RestartTrackRender__Fv
	.text
	.ent	Render_InitTrackRenderPostSim__Fv
Render_InitTrackRenderPostSim__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$0,gPauseRender
	jal	Texture_DeInitPaletteSharing__Fv
	jal	CV_InitColorVertices__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_InitTrackRenderPostSim__Fv
	.text
	.ent	Render_KillTrackRender__Fv
Render_KillTrackRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_DeInitRenderEngine__Fv
	jal	DrawC_KillRenderingData__Fv
	jal	Night_KillNightDriving__Fv
	jal	Texture_KillTrackTexture__Fv
	jal	Souffle_KillTrackSouffle__Fv
	jal	Skidmark_KillSkidmark__Fv
	jal	TrgSfx_KillTrgSfx__Fv
	jal	DashHUD_KillHUD__Fv
	.set	noreorder
	.set	nomacro
	jal	Draw_SetDrawSyncCallback__FPFv_v
	move	$4,$0
	.set	macro
	.set	reorder

	jal	Fog_DeInitFogTriggers__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_KillTrackRender__Fv
	.text
	.ent	Render_InitLibRender__Fv
Render_InitLibRender__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_InitLibRender__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Render_InitLibRender__Fv
	.text
	.ent	StampImage__Fii
StampImage__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Render_gBlurEffectMode
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$13,gFlip
	j	$L639
$L638:
	lw	$3,gFlip
	#nop
	subu	$13,$2,$3
$L639:
	lw	$2,Render_gBlurEffectMode
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	move	$8,$0
	.set	macro
	.set	reorder

	move	$4,$0
$L649:
	li	$11,528482304			# 0x1f800000
	ori	$11,$11,0x0004
	li	$10,16711680			# 0x00ff0000
	ori	$10,$10,0xffff
	li	$25,-16777216			# 0xff000000
	li	$24,64			# 0x00000040
	li	$15,240			# 0x000000f0
	li	$14,240			# 0x000000f0
	li	$12,128			# 0x00000080
	li	$9,320			# 0x00000140
	move	$7,$4
$L644:
	sll	$4,$5,2
	lw	$2,528482304
	lw	$6,0($11)
	addu	$4,$4,$2
	lw	$3,0($6)
	lw	$2,0($4)
	and	$3,$3,$25
	and	$2,$2,$10
	or	$3,$3,$2
	sw	$3,0($6)
	lw	$3,0($4)
	addu	$2,$6,40
	sw	$2,0($11)
	and	$2,$6,$10
	and	$3,$3,$25
	or	$3,$3,$2
	li	$2,9			# 0x00000009
	sw	$3,0($4)
	sb	$2,3($6)
	li	$2,46			# 0x0000002e
	sb	$2,7($6)
	addu	$2,$7,64
	sh	$2,16($6)
	sh	$2,32($6)
	sll	$2,$8,6
	sb	$0,12($6)
	sb	$0,13($6)
	sb	$24,20($6)
	sb	$0,21($6)
	sb	$0,28($6)
	sb	$15,29($6)
	sb	$24,36($6)
	sb	$15,37($6)
	sh	$7,8($6)
	sh	$0,10($6)
	sh	$0,18($6)
	sh	$7,24($6)
	sh	$14,26($6)
	sh	$14,34($6)
	sb	$12,4($6)
	sb	$12,5($6)
	.set	noreorder
	.set	nomacro
	bne	$13,$0,$L645
	sb	$12,6($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L648
	andi	$2,$9,0x03ff
	.set	macro
	.set	reorder

$L645:
	andi	$2,$2,0x03ff
$L648:
	sra	$2,$2,6
	ori	$2,$2,0x0110
	sh	$2,22($6)
	addu	$9,$9,64
	addu	$8,$8,1
	slt	$2,$8,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L644
	addu	$7,$7,64
	.set	macro
	.set	reorder

	j	$31
	.end	StampImage__Fii
	.text
	.ent	Render_InitBlurMode__Fv
Render_InitBlurMode__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+56) # high
	lw	$3,%lo(GameSetup_gData+56)($2)
	li	$2,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L653
	slt	$2,$3,33
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L657
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L652
	li	$2,11			# 0x0000000b
	.set	macro
	.set	reorder

	j	$31
$L657:
	li	$2,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L654
	li	$2,31			# 0x0000001f
	.set	macro
	.set	reorder

	j	$31
$L652:
	sw	$2,Render_gBlurEffectMode
	j	$31
$L653:
	li	$2,27			# 0x0000001b
	sw	$2,Render_gBlurEffectMode
	j	$31
$L654:
	sw	$2,Render_gBlurEffectMode
	j	$31
	.end	Render_InitBlurMode__Fv
	.text
	.ent	Render_InsertDepthOfField__Fv
Render_InsertDepthOfField__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$3,Render_gBlurEffectMode
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	andi	$2,$3,0x0008
	beq	$2,$0,$L661
	lw	$5,Render_gBlurEffectDepth1
	.set	noreorder
	.set	nomacro
	jal	StampImage__Fii
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L661:
	lw	$2,Render_gBlurEffectMode
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	li	$19,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lw	$5,Render_gBlurEffectDepth2
	.set	noreorder
	.set	nomacro
	jal	StampImage__Fii
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$19,528482304			# 0x1f800000
$L664:
	ori	$19,$19,0x0004
	li	$17,16711680			# 0x00ff0000
	ori	$17,$17,0xffff
	li	$5,1			# 0x00000001
	li	$16,528482304			# 0x1f800000
	li	$18,-16777216			# 0xff000000
	lw	$4,Render_gBlurEffectDepth1
	lw	$2,0($16)
	lw	$6,0($19)
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$3,0($6)
	lw	$2,0($4)
	and	$3,$3,$18
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($6)
	lw	$2,0($4)
	addu	$3,$6,24
	sw	$3,0($19)
	and	$3,$6,$17
	and	$2,$2,$18
	or	$2,$2,$3
	sw	$2,0($4)
	li	$2,5			# 0x00000005
	sb	$2,3($6)
	li	$2,42			# 0x0000002a
	li	$3,320			# 0x00000140
	sb	$2,7($6)
	sh	$0,8($6)
	sh	$0,10($6)
	sh	$3,12($6)
	sh	$0,14($6)
	sh	$0,16($6)
	sb	$0,4($6)
	sb	$0,5($6)
	sb	$0,6($6)
	lw	$4,0($19)
	li	$2,240			# 0x000000f0
	sh	$2,18($6)
	sh	$3,20($6)
	sh	$2,22($6)
	lw	$6,Render_gBlurEffectDepth1
	lw	$2,0($16)
	sll	$6,$6,2
	addu	$6,$6,$2
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$18
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($19)
	and	$3,$4,$17
	and	$2,$2,$18
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawStp
	sw	$2,0($6)
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	li	$5,1			# 0x00000001
	move	$6,$0
	li	$7,256			# 0x00000100
	lw	$8,Render_gBlurEffectDepth1
	lw	$2,0($16)
	lw	$16,0($19)
	sll	$8,$8,$4
	addu	$8,$8,$2
	lw	$3,0($16)
	lw	$2,0($8)
	and	$3,$3,$18
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,12
	lw	$2,0($8)
	and	$17,$16,$17
	sw	$3,0($19)
	and	$2,$2,$18
	or	$2,$2,$17
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sw	$2,0($8)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	move	$6,$5
	andi	$7,$2,0xffff
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

$L659:
	lw	$31,40($sp)
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

	.end	Render_InsertDepthOfField__Fv
