	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\hrzsku.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
	.rdata
	.align	2
$LC0:
	.ascii	"stars\000"
	.align	2
$LC1:
	.ascii	"starCols\000"
	.text
	.align	2
	.globl	Sky_InitStars__Fv
	.align	2
	.globl	Sky_KillStars__Fv
	.align	2
	.globl	Hrz_InitSkyColor__Fv
	.align	2
	.globl	Hrz_InitSky__Fv
	.align	2
	.globl	Hrz_Init2DRing__Fv
	.align	2
	.globl	Hrz_GetHorizonPixMap__FP12Draw_tPixMap
	.rdata
	.align	2
$LC2:
	.ascii	"gRngCoordTop\000"
	.text
	.align	2
	.globl	Hrz_InitHorizon__Fv
	.align	2
	.globl	Hrz_KillHorizon__Fv
	.align	2
	.globl	Hrz_LightningAddFork__FScScSc
	.align	2
	.globl	Hrz_CalculateLightning__Fv
	.align	2
	.globl	Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
	.align	2
	.globl	Hrz_SetLightingPosInSky__FP13DRender_tView
	.align	2
	.globl	Hrz_BuildForkLightning__FP11Draw_DCache
	.align	2
	.globl	Hrz_LightningFlicker__Fi
	.align	2
	.globl	HrzSetPsxMatrix__FP10matrixtdef
	.align	2
	.globl	HrzSetPsxTranslation__FP8coorddef
	.align	2
	.globl	Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
	.align	2
	.globl	Hrz_SetDitheringPrim__Fii
	.align	2
	.globl	Hrz_BuildSky__Fv
	.align	2
	.globl	Sky_RenderStars__FP13Draw_SkyCachei
	.align	2
	.globl	Hrz_BuildHorizon__FP13DRender_tView
	.globl	Hrz_gProjResultZ0
	.sdata
	.align	2
Hrz_gProjResultZ0:
	.space	4
	.globl	Hrz_gProjScratch_9C
	.align	2
Hrz_gProjScratch_9C:
	.space	4
	.globl	gHorizonPixmap
	.data
	.align	2
gHorizonPixmap:
	.space	64
	.globl	gHorizonExtraSkyPixmaps
	.align	2
gHorizonExtraSkyPixmaps:
	.space	64
	.globl	gSkyMesh
	.align	2
gSkyMesh:
	.space	680
	.globl	gSkyColor
	.align	2
gSkyColor:
	.space	340
	.globl	gSkyPixmapIndex
	.align	2
gSkyPixmapIndex:
	.space	64
	.globl	gpPmx
	.align	2
gpPmx:
	.space	64
	.globl	gHrzRingColor
	.align	2
gHrzRingColor:
	.space	136
	.globl	gfxPmxHeightPercentage
	.align	2
gfxPmxHeightPercentage:
	.space	64
	.globl	gHrz_Lightning
	.align	2
gHrz_Lightning:
	.space	104
	.globl	starPosInSky
	.sdata
	.align	2
starPosInSky:
	.space	4
	.globl	starColors
	.align	2
starColors:
	.space	4
	.globl	Hrz_gTrackSpec
	.align	2
Hrz_gTrackSpec:
	.space	4
	.globl	Sky_gTrackSpec
	.align	2
Sky_gTrackSpec:
	.space	4
	.globl	gRngCoordTop
	.align	2
gRngCoordTop:
	.space	4
	.globl	Hrz_gLightningPosInSky_vx
	.align	1
Hrz_gLightningPosInSky_vx:
	.space	2
	.globl	Hrz_gLightningPosInSky_vy
	.align	1
Hrz_gLightningPosInSky_vy:
	.space	2
	.globl	Hrz_gLightningPosInSky_vz
	.align	1
Hrz_gLightningPosInSky_vz:
	.space	2
	.globl	Hrz_gLightningPosInSky_pad
	.align	1
Hrz_gLightningPosInSky_pad:
	.space	2

	.lcomm	sunPosInSky_vx,2

	.lcomm	sunPosInSky_vy,2

	.lcomm	sunPosInSky_vz,2

	.lcomm	sunPosInSky_pad,2

	.lcomm	moonPosInSky_vx,2

	.lcomm	moonPosInSky_vy,2

	.lcomm	moonPosInSky_vz,2

	.lcomm	moonPosInSky_pad,2
	.globl	Hrz_gSaveCol
	.data
	.align	2
Hrz_gSaveCol:
	.space	16
	.globl	Hrz_gSkyVtx_A0
	.sdata
	.align	2
Hrz_gSkyVtx_A0:
	.space	4
	.globl	Hrz_gSkyVtx_A1
	.align	2
Hrz_gSkyVtx_A1:
	.space	4
	.globl	Hrz_gSkyVtx_B0
	.align	2
Hrz_gSkyVtx_B0:
	.space	4
	.globl	Hrz_gSkyVtx_B1
	.align	2
Hrz_gSkyVtx_B1:
	.space	4

	.extern	Night_gLightning, 4
	.extern	Camera_gGeomScreen, 4
	.extern	Night_gShowForks, 1
	.extern	Draw_gViewOtSize, 4
	.extern	Draw_gPlayer2View, 4
	.extern	Draw_gPlayer1View, 4
	.extern	GameSetup_gData, 2600
	.extern	TrackSpec_gSpec, 264

	.text
	.text
	.ent	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,20($sp)
	lw	$11,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	move	$9,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$11,$L620
	move	$8,$0
	.set	macro
	.set	reorder

	li	$10,65535			# 0x0000ffff
$L605:
	lh	$2,0($6)
	lh	$3,0($5)
	lw	$4,0($7)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,0($5)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L608
	addu	$2,$2,$10
$L608:
	sra	$2,$2,16
	addu	$2,$3,$2
	sh	$2,0($9)
	lh	$2,2($6)
	lh	$3,2($5)
	lw	$4,0($7)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,2($5)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L609
	addu	$2,$2,$10
$L609:
	sra	$2,$2,16
	addu	$2,$3,$2
	sh	$2,2($9)
	addu	$7,$7,4
	addu	$5,$5,4
	addu	$6,$6,4
 #APP
 #NO_APP
	addu	$8,$8,1
	slt	$2,$8,$11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L605
	addu	$9,$9,4
	.set	macro
	.set	reorder

$L620:
	j	$31
$L603:
	lw	$4,0($7)
	.set	noreorder
	.set	nomacro
	blez	$11,$L620
	move	$8,$0
	.set	macro
	.set	reorder

	li	$7,65535			# 0x0000ffff
$L613:
	lh	$2,0($6)
	lh	$3,0($5)
	#nop
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,0($5)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L616
	addu	$2,$2,$7
$L616:
	sra	$2,$2,16
	addu	$2,$3,$2
	sh	$2,0($9)
	lh	$2,2($6)
	lh	$3,2($5)
	#nop
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,2($5)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L617
	addu	$2,$2,$7
$L617:
	sra	$2,$2,16
	addu	$2,$3,$2
	sh	$2,2($9)
	addu	$5,$5,4
	addu	$6,$6,4
 #APP
 #NO_APP
	addu	$8,$8,1
	slt	$2,$8,$11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	addu	$9,$9,4
	.set	macro
	.set	reorder

	j	$31
	.end	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
	.text
	.ent	Sky_InitStars__Fv
Sky_InitStars__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lw	$2,starPosInSky
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	random
	move	$20,$0
	.set	macro
	.set	reorder

	lw	$3,Sky_gTrackSpec
	#nop
	lw	$4,92($3)
	.set	noreorder
	.set	nomacro
	jal	seedrandom
	move	$21,$2
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	lw	$2,Sky_gTrackSpec
	addiu	$4,$4,%lo($LC0) # low
	lw	$5,68($2)
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	lw	$3,Sky_gTrackSpec
	addiu	$4,$4,%lo($LC1) # low
	lw	$5,68($3)
	move	$6,$20
	sw	$2,starPosInSky
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,2
	.set	macro
	.set	reorder

	sw	$2,starColors
$L623:
	lw	$2,Sky_gTrackSpec
	#nop
	lw	$2,68($2)
	#nop
	slt	$2,$20,$2
	beq	$2,$0,$L624
	jal	random
	.set	noreorder
	.set	nomacro
	jal	random
	andi	$19,$2,0xffff
	.set	macro
	.set	reorder

	lw	$4,Sky_gTrackSpec
	#nop
	lw	$3,76($4)
	lw	$16,72($4)
	#nop
	subu	$3,$3,$16
	remu	$3,$2,$3
	addu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	move	$18,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$4,$19
	lw	$3,starPosInSky
	sll	$16,$20,3
	addu	$3,$16,$3
	sh	$2,0($3)
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	sh	$18,2($3)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$3,starPosInSky
	#nop
	addu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	jal	random
	sh	$2,4($16)
	.set	macro
	.set	reorder

	lw	$4,Sky_gTrackSpec
	#nop
	lw	$3,84($4)
	lw	$4,80($4)
	#nop
	subu	$3,$3,$4
	remu	$3,$2,$3
	sll	$5,$20,2
	lw	$2,starColors
	addu	$20,$20,1
	addu	$5,$5,$2
	addu	$4,$4,$3
	sll	$2,$4,16
	sll	$3,$4,8
	or	$2,$2,$3
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L623
	sw	$2,0($5)
	.set	macro
	.set	reorder

$L624:
	.set	noreorder
	.set	nomacro
	jal	seedrandom
	move	$4,$21
	.set	macro
	.set	reorder

$L621:
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

	.end	Sky_InitStars__Fv
	.text
	.ent	Sky_KillStars__Fv
Sky_KillStars__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,starPosInSky
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L628
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L628:
	lw	$4,starColors
	#nop
	beq	$4,$0,$L629
	jal	purgememadr
$L629:
	lw	$31,16($sp)
	sw	$0,starPosInSky
	sw	$0,starColors
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sky_KillStars__Fv
	.text
	.ent	Hrz_InitSkyColor__Fv
Hrz_InitSkyColor__Fv:
	.frame	$sp,24,$31		# vars= 24, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$0
	move	$6,$7
	li	$8,16			# 0x00000010
	lui	$2,%hi(gSkyColor) # high
	addiu	$9,$2,%lo(gSkyColor) # low
$L631:
	slt	$2,$7,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	sll	$4,$7,2
	.set	macro
	.set	reorder

	lw	$2,Sky_gTrackSpec
	#nop
	move	$3,$2
	addu	$2,$2,$4
	addu	$3,$3,$4
	lwl	$10,31($2)
	lwr	$10,28($2)
	swl	$10,11($sp)
	swr	$10,8($sp)
	lwl	$10,11($3)
	lwr	$10,8($3)
	swl	$10,19($sp)
	swr	$10,16($sp)
	lbu	$3,8($sp)
	lbu	$2,16($sp)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L635
	addu	$2,$2,7
$L635:
	lbu	$4,9($sp)
	lbu	$3,17($sp)
	sra	$2,$2,3
	sb	$2,0($sp)
	subu	$2,$4,$3
	bgez	$2,$L636
	addu	$2,$2,7
$L636:
	lbu	$4,10($sp)
	lbu	$3,18($sp)
	sra	$2,$2,3
	sb	$2,1($sp)
	subu	$2,$4,$3
	bgez	$2,$L637
	addu	$2,$2,7
$L637:
	sra	$2,$2,3
	sb	$2,2($sp)
	move	$3,$0
	sll	$2,$6,2
	addu	$5,$2,$9
$L638:
	slt	$2,$3,17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	slt	$2,$3,9
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	move	$4,$3
	.set	macro
	.set	reorder

	subu	$4,$8,$3
$L642:
	lbu	$2,0($sp)
	#nop
	mult	$2,$4
	lbu	$2,16($sp)
	mflo	$10
	#nop
	#nop
	addu	$2,$2,$10
	sb	$2,0($5)
	lbu	$2,1($sp)
	#nop
	mult	$2,$4
	lbu	$2,17($sp)
	mflo	$10
	#nop
	#nop
	addu	$2,$2,$10
	sb	$2,1($5)
	lbu	$2,2($sp)
	#nop
	mult	$2,$4
	addu	$3,$3,1
	addu	$6,$6,1
	lbu	$2,18($sp)
	mflo	$10
	#nop
	#nop
	addu	$2,$2,$10
	sb	$2,2($5)
	.set	noreorder
	.set	nomacro
	j	$L638
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L639:
	.set	noreorder
	.set	nomacro
	j	$L631
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L632:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Hrz_InitSkyColor__Fv
	.text
	.ent	Hrz_InitSky__Fv
Hrz_InitSky__Fv:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	lw	$2,Sky_gTrackSpec
	subu	$sp,$sp,56
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$4,52($2)
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	lui	$16,%hi(TrackSpec_gSpec) # high
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lw	$3,Sky_gTrackSpec
	sh	$2,sunPosInSky_vx
	lw	$4,52($3)
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	addiu	$16,$16,%lo(TrackSpec_gSpec) # low
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	sh	$2,sunPosInSky_vz
	lhu	$2,144($16)
	lhu	$3,192($16)
	lw	$4,Sky_gTrackSpec
	addu	$2,$2,$3
	sh	$2,sunPosInSky_vy
	lw	$4,60($4)
	jal	fixedcos
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lw	$3,Sky_gTrackSpec
	sh	$2,moonPosInSky_vx
	lw	$4,60($3)
	jal	fixedsin
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lhu	$3,152($16)
	lhu	$4,192($16)
	sh	$2,moonPosInSky_vz
	lui	$2,%hi(GameSetup_gData+12) # high
	addu	$3,$3,$4
	sh	$3,moonPosInSky_vy
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L644
	lw	$2,Sky_gTrackSpec
	lw	$4,Draw_gPlayer1View
	lbu	$5,48($2)
	lbu	$6,49($2)
	lbu	$7,50($2)
	jal	Draw_SetViewColor__Fiiii
	lw	$2,Sky_gTrackSpec
	lw	$4,Draw_gPlayer2View
	j	$L671
$L644:
	lw	$2,Sky_gTrackSpec
	lw	$4,Draw_gPlayer1View
$L671:
	lbu	$5,48($2)
	lbu	$6,49($2)
	lbu	$7,50($2)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetViewColor__Fiiii
	move	$19,$0
	.set	macro
	.set	reorder

	move	$22,$19
	lui	$2,%hi(gSkyMesh) # high
	addiu	$23,$2,%lo(gSkyMesh) # low
$L646:
	lw	$4,Sky_gTrackSpec
	#nop
	lw	$3,4($4)
	#nop
	andi	$2,$3,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	sll	$16,$19,2
	.set	macro
	.set	reorder

	addu	$2,$4,$16
	lw	$4,128($2)
	jal	fixedcos
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lw	$3,Sky_gTrackSpec
	#nop
	addu	$3,$3,$16
	lw	$4,128($3)
	.set	noreorder
	.set	nomacro
	j	$L672
	move	$21,$2
	.set	macro
	.set	reorder

$L649:
	andi	$2,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	slt	$2,$19,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L652
	sll	$16,$19,11
	.set	macro
	.set	reorder

$L651:
	sll	$16,$19,12
$L652:
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$16
$L672:
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$17,$0
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,1000			# 0x000003e8
	.set	macro
	.set	reorder

	move	$20,$2
	sll	$2,$22,3
	addu	$18,$2,$23
$L653:
 #APP
 #NO_APP
	lw	$2,Sky_gTrackSpec
	sll	$16,$17,12
	lw	$2,52($2)
	addu	$17,$17,1
	subu	$16,$16,$2
	addu	$16,$16,16384
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$21
	.set	macro
	.set	reorder

	lw	$3,Sky_gTrackSpec
	addu	$22,$22,1
	sh	$2,0($18)
	lhu	$2,104($3)
	move	$4,$16
	addu	$2,$2,$20
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	sh	$2,2($18)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$21
	.set	macro
	.set	reorder

	sh	$2,4($18)
	slt	$2,$17,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	addu	$18,$18,8
	.set	macro
	.set	reorder

	addu	$19,$19,1
	slt	$2,$19,5
	bne	$2,$0,$L646
	lw	$2,Sky_gTrackSpec
	#nop
	lw	$3,0($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L658
	move	$19,$0
	.set	macro
	.set	reorder

	move	$22,$19
	lui	$2,%hi(gSkyPixmapIndex) # high
	addiu	$6,$2,%lo(gSkyPixmapIndex) # low
$L659:
	move	$17,$0
	sll	$5,$19,2
$L662:
	move	$2,$17
	lw	$3,Sky_gTrackSpec
	.set	noreorder
	.set	nomacro
	bgez	$17,$L665
	addu	$4,$22,$6
	.set	macro
	.set	reorder

	addu	$2,$17,3
$L665:
	sra	$2,$2,2
	sll	$2,$2,2
	subu	$2,$17,$2
	addu	$17,$17,1
	addu	$2,$2,$5
	addu	$2,$3,$2
	lbu	$2,108($2)
	#nop
	addu	$2,$2,8
	sb	$2,0($4)
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L662
	addu	$22,$22,1
	.set	macro
	.set	reorder

	addu	$19,$19,1
	slt	$2,$19,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,Sky_gTrackSpec
	#nop
	lw	$3,0($4)
	#nop
	bne	$3,$2,$L658
	lw	$2,4($4)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L669
$L658:
	jal	Hrz_InitSkyColor__Fv
$L669:
	jal	Flare_InitLensFlare__Fv
	lw	$31,48($sp)
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

	.end	Hrz_InitSky__Fv
	.text
	.ent	Hrz_Init2DRing__Fv
Hrz_Init2DRing__Fv:
	.frame	$sp,96,$31		# vars= 64, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$17,84($sp)
	move	$17,$0
	sw	$31,88($sp)
	sw	$16,80($sp)
$L674:
	lw	$2,Hrz_gTrackSpec
	#nop
	lw	$2,4($2)
	sll	$16,$17,12
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedsin
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,32000			# 0x00007d00
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$3,gRngCoordTop
	sll	$16,$17,3
	addu	$3,$16,$3
	sh	$2,0($3)
	.set	noreorder
	.set	nomacro
	jal	fixedcos
	sh	$0,2($3)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,32000			# 0x00007d00
	.set	macro
	.set	reorder

	lw	$3,gRngCoordTop
	addu	$17,$17,1
	addu	$16,$16,$3
	sh	$2,4($16)
	slt	$2,$17,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(gHorizonPixmap) # high
	addiu	$8,$2,%lo(gHorizonPixmap) # low
	lw	$7,Hrz_gTrackSpec
	addu	$5,$sp,16
	lui	$2,%hi(gpPmx) # high
	addiu	$4,$2,%lo(gpPmx) # low
$L680:
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	addu	$2,$7,$17
	.set	macro
	.set	reorder

	lbu	$2,32($2)
	#nop
	andi	$2,$2,0x0007
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$2,0($2)
	#nop
	sw	$2,0($4)
	lbu	$3,9($2)
	lbu	$2,5($2)
	#nop
	subu	$3,$3,$2
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	sw	$3,0($5)
	.set	macro
	.set	reorder

	move	$6,$3
$L682:
	addu	$5,$5,4
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L680
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L679:
	move	$17,$0
	lui	$2,%hi(gfxPmxHeightPercentage) # high
	addiu	$5,$2,%lo(gfxPmxHeightPercentage) # low
	addu	$4,$sp,16
$L684:
	lw	$2,0($4)
	#nop
	sll	$2,$2,16
	div	$2,$2,$6
	addu	$4,$4,4
	addu	$17,$17,1
	sw	$2,0($5)
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$9,$0
	li	$12,16			# 0x00000010
	lui	$2,%hi(gHrzRingColor) # high
	addiu	$8,$2,%lo(gHrzRingColor) # low
	move	$11,$8
	move	$10,$9
$L688:
	slt	$2,$9,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	move	$17,$0
	.set	macro
	.set	reorder

	move	$7,$10
	lw	$2,Hrz_gTrackSpec
	sll	$4,$9,2
	move	$3,$2
	addu	$2,$2,$4
	addu	$3,$3,$4
	lwl	$13,27($2)
	lwr	$13,24($2)
	swl	$13,19($sp)
	swr	$13,16($sp)
	lwl	$13,19($3)
	lwr	$13,16($3)
	swl	$13,27($sp)
	swr	$13,24($sp)
$L692:
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L693
	slt	$2,$17,9
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	move	$5,$17
	.set	macro
	.set	reorder

	subu	$5,$12,$17
$L696:
	lbu	$2,16($sp)
	lbu	$6,24($sp)
	#nop
	subu	$2,$2,$6
	bgez	$2,$L697
	addu	$2,$2,7
$L697:
	lbu	$4,17($sp)
	lbu	$3,25($sp)
	sra	$2,$2,3
	sb	$2,32($sp)
	subu	$2,$4,$3
	bgez	$2,$L698
	addu	$2,$2,7
$L698:
	lbu	$4,18($sp)
	lbu	$3,26($sp)
	sra	$2,$2,3
	subu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L699
	sb	$2,33($sp)
	.set	macro
	.set	reorder

	addu	$4,$4,7
$L699:
	lbu	$2,32($sp)
	#nop
	mult	$2,$5
	addu	$3,$7,$11
	sra	$2,$4,3
	sb	$2,34($sp)
	mflo	$13
	#nop
	#nop
	addu	$2,$6,$13
	sb	$2,0($3)
	lbu	$2,33($sp)
	#nop
	mult	$2,$5
	lbu	$2,25($sp)
	mflo	$13
	#nop
	#nop
	addu	$2,$2,$13
	sb	$2,1($3)
	lbu	$2,34($sp)
	#nop
	mult	$2,$5
	addu	$7,$7,4
	addu	$17,$17,1
	lbu	$2,26($sp)
	mflo	$13
	#nop
	#nop
	addu	$2,$2,$13
	.set	noreorder
	.set	nomacro
	j	$L692
	sb	$2,2($3)
	.set	macro
	.set	reorder

$L693:
	lwl	$14,3($8)
	lwr	$14,0($8)
	swl	$14,67($8)
	swr	$14,64($8)
	addu	$8,$8,68
	addu	$10,$10,68
	.set	noreorder
	.set	nomacro
	j	$L688
	addu	$9,$9,1
	.set	macro
	.set	reorder

$L689:
	jal	Hrz_InitSky__Fv
	lw	$2,Sky_gTrackSpec
	lw	$31,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	lw	$3,8($2)
	lui	$2,%hi(Hrz_gSaveCol+4) # high
	sw	$3,%lo(Hrz_gSaveCol+4)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Hrz_Init2DRing__Fv
	.text
	.ent	Hrz_GetHorizonPixMap__FP12Draw_tPixMap
Hrz_GetHorizonPixMap__FP12Draw_tPixMap:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	li	$17,11			# 0x0000000b
	lui	$2,%hi(gHorizonPixmap) # high
	addiu	$2,$2,%lo(gHorizonPixmap) # low
	addu	$2,$2,44
	addu	$4,$4,176
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
$L702:
	sw	$4,0($2)
	addu	$2,$2,-4
	addu	$17,$17,-1
	.set	noreorder
	.set	nomacro
	bgez	$17,$L702
	addu	$4,$4,-16
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(gHorizonPixmap) # high
	addiu	$20,$2,%lo(gHorizonPixmap) # low
	li	$19,48			# 0x00000030
	lui	$2,%hi(gHorizonExtraSkyPixmaps) # high
	addiu	$16,$2,%lo(gHorizonExtraSkyPixmaps) # low
	li	$18,32			# 0x00000020
$L706:
	addu	$2,$18,$20
	addu	$18,$18,4
	addu	$17,$17,1
	move	$5,$0
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$2,$19,$20
	addu	$19,$19,4
	sw	$16,0($2)
	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L706
	addu	$16,$16,16
	.set	macro
	.set	reorder

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

	.end	Hrz_GetHorizonPixMap__FP12Draw_tPixMap
	.text
	.ent	Hrz_InitHorizon__Fv
Hrz_InitHorizon__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(TrackSpec_gSpec+40) # high
	addiu	$16,$16,%lo(TrackSpec_gSpec+40) # low
	addu	$2,$16,48
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,136			# 0x00000088
	sw	$31,20($sp)
	sw	$16,Hrz_gTrackSpec
	sw	$2,Sky_gTrackSpec
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,gRngCoordTop
	jal	Hrz_Init2DRing__Fv
	lw	$2,52($16)
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L711
	jal	Sky_InitStars__Fv
$L711:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Hrz_InitHorizon__Fv
	.text
	.ent	Hrz_KillHorizon__Fv
Hrz_KillHorizon__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gRngCoordTop
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	jal	Sky_KillStars__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Hrz_KillHorizon__Fv
	.text
	.ent	Hrz_LightningAddFork__FScScSc
Hrz_LightningAddFork__FScScSc:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$16,16($sp)
	move	$16,$6
	sll	$6,$6,24
	sra	$2,$6,24
	sw	$31,36($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L717
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L718
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L717:
	slt	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	jal	random
	li	$3,-1431655765			# 0xaaaaaaab
	multu	$2,$3
	mfhi	$7
	#nop
	#nop
	srl	$4,$7,1
	sll	$3,$4,1
	addu	$3,$3,$4
	subu	$5,$2,$3
$L719:
$L718:
	lui	$4,%hi(gHrz_Lightning) # high
	addiu	$4,$4,%lo(gHrz_Lightning) # low
	lbu	$3,100($4)
	li	$19,1			# 0x00000001
	addu	$2,$3,1
	sb	$2,100($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$17,$2,$4
	sll	$3,$18,24
	sra	$3,$3,24
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$3,$16,24
	sra	$3,$3,24
	sh	$2,0($17)
	sll	$2,$3,4
	subu	$2,$2,$3
	andi	$3,$5,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$3,$19,$L723
	sh	$2,2($17)
	.set	macro
	.set	reorder

	slt	$2,$3,2
	beq	$2,$0,$L728
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L722
	sll	$4,$20,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L732
	sll	$2,$20,24
	.set	macro
	.set	reorder

$L728:
	li	$2,2			# 0x00000002
	beq	$3,$2,$L724
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L725
	sll	$2,$20,24
	.set	macro
	.set	reorder

	j	$L732
$L722:
	sra	$4,$4,24
	addu	$5,$18,$20
	sll	$5,$5,24
	sra	$5,$5,24
	addu	$6,$16,1
	sll	$6,$6,24
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningAddFork__FScScSc
	sra	$6,$6,24
	.set	macro
	.set	reorder

	jal	random
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L731
	addu	$2,$2,2
	.set	macro
	.set	reorder

$L723:
	li	$4,-1			# 0xffffffff
	addu	$5,$18,$4
	sll	$5,$5,24
	sra	$5,$5,24
	addu	$16,$16,1
	sll	$16,$16,24
	sra	$16,$16,24
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningAddFork__FScScSc
	move	$6,$16
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	addu	$5,$18,$4
	sll	$5,$5,24
	sra	$5,$5,24
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningAddFork__FScScSc
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L731
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

$L724:
	jal	random
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L731
	addu	$2,$2,4
	.set	macro
	.set	reorder

$L725:
	jal	random
	andi	$2,$2,0x0001
	sll	$2,$2,1
	subu	$2,$19,$2
	move	$20,$2
	sll	$4,$2,24
	sra	$4,$4,24
	addu	$2,$18,$2
	sll	$2,$2,24
	sra	$5,$2,24
	addu	$6,$16,1
	sll	$6,$6,24
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningAddFork__FScScSc
	sra	$6,$6,24
	.set	macro
	.set	reorder

	jal	random
	andi	$2,$2,0x0001
$L731:
	sb	$2,4($17)
	sll	$2,$20,24
$L732:
	bgez	$2,$L716
	lbu	$2,4($17)
	#nop
	addu	$2,$2,8
	sb	$2,4($17)
$L716:
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

	.end	Hrz_LightningAddFork__FScScSc
	.text
	.ent	Hrz_CalculateLightning__Fv
Hrz_CalculateLightning__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(gHrz_Lightning) # high
	addiu	$2,$2,%lo(gHrz_Lightning) # low
	li	$3,200			# 0x000000c8
	li	$4,1			# 0x00000001
	move	$5,$0
	move	$6,$5
	sw	$31,16($sp)
	sb	$0,100($2)
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningAddFork__FScScSc
	sw	$3,96($2)
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

	.end	Hrz_CalculateLightning__Fv
	.text
	.ent	Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$12,528482304			# 0x1f800000
	ori	$12,$12,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$11,-16777216			# 0xff000000
	lw	$2,148($7)
	lw	$10,528482304
	lw	$8,0($12)
	sll	$2,$2,2
	addu	$2,$2,$10
	lw	$3,0($8)
	lw	$2,0($2)
	and	$3,$3,$11
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($8)
	lw	$7,148($7)
	addu	$3,$8,40
	sll	$7,$7,2
	addu	$7,$7,$10
	lw	$2,0($7)
	and	$9,$8,$9
	sw	$3,0($12)
	and	$2,$2,$11
	or	$2,$2,$9
	sw	$2,0($7)
	li	$2,9			# 0x00000009
	sb	$2,3($8)
	li	$2,46			# 0x0000002e
	sb	$2,7($8)
	sb	$6,6($8)
	sb	$6,5($8)
	sb	$6,4($8)
	lhu	$2,0($4)
	#nop
	sh	$2,8($8)
	lhu	$2,2($4)
	#nop
	sh	$2,10($8)
	lhu	$2,0($4)
	#nop
	sh	$2,24($8)
	lhu	$2,2($4)
	#nop
	addu	$2,$2,16
	sh	$2,26($8)
	lhu	$2,0($4)
	#nop
	addu	$2,$2,16
	sh	$2,16($8)
	lhu	$2,2($4)
	#nop
	sh	$2,18($8)
	lhu	$2,0($4)
	andi	$5,$5,0x00ff
	addu	$2,$2,16
	sh	$2,32($8)
	lhu	$2,2($4)
	sll	$5,$5,2
	addu	$2,$2,16
	sh	$2,34($8)
	lui	$2,%hi(gLightningPixmap) # high
	addiu	$2,$2,%lo(gLightningPixmap) # low
	addu	$5,$5,$2
	lw	$2,0($5)
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

	.end	Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
	.text
	.ent	Hrz_SetLightingPosInSky__FP13DRender_tView
Hrz_SetLightingPosInSky__FP13DRender_tView:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$16,32($sp)
	lw	$6,44($4)
	lw	$7,48($4)
	lw	$8,52($4)
	sw	$6,16($sp)
	sw	$7,20($sp)
	sw	$8,24($sp)
	.set	noreorder
	.set	nomacro
	jal	random
	li	$16,274857984			# 0x10620000
	.set	macro
	.set	reorder

	ori	$16,$16,0x4dd3
	multu	$2,$16
	lw	$4,16($sp)
	#nop
	sra	$4,$4,2
	mfhi	$6
	#nop
	#nop
	srl	$5,$6,9
	sll	$3,$5,5
	subu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$3,$3,6
	subu	$2,$2,$3
	addu	$4,$4,$2
	addu	$4,$4,-4000
	sh	$4,Hrz_gLightningPosInSky_vx
	jal	random
	li	$3,91619328			# 0x05760000
	ori	$3,$3,0x19f1
	multu	$2,$3
	lw	$4,20($sp)
	#nop
	sra	$4,$4,2
	addu	$4,$4,8000
	mfhi	$6
	#nop
	#nop
	srl	$5,$6,6
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,4
	subu	$3,$3,$5
	sll	$3,$3,3
	subu	$3,$3,$5
	sll	$3,$3,3
	subu	$2,$2,$3
	addu	$4,$4,$2
	sh	$4,Hrz_gLightningPosInSky_vy
	jal	random
	multu	$2,$16
	lw	$4,24($sp)
	lw	$31,36($sp)
	lw	$16,32($sp)
	sra	$4,$4,2
	mfhi	$6
	#nop
	#nop
	srl	$5,$6,9
	sll	$3,$5,5
	subu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$3,$3,6
	subu	$2,$2,$3
	addu	$4,$4,$2
	addu	$4,$4,-4000
	sh	$4,Hrz_gLightningPosInSky_vz
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Hrz_SetLightingPosInSky__FP13DRender_tView
	.text
	.ent	Hrz_BuildForkLightning__FP11Draw_DCache
Hrz_BuildForkLightning__FP11Draw_DCache:
	.frame	$sp,64,$31		# vars= 32, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lui	$2,%hi(gHrz_Lightning) # high
	sw	$17,52($sp)
	addiu	$17,$2,%lo(gHrz_Lightning) # low
	sw	$31,60($sp)
	sw	$18,56($sp)
	sw	$16,48($sp)
	lw	$2,96($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L739
	move	$18,$4
	.set	macro
	.set	reorder

	addu	$16,$sp,32
	move	$4,$16
	move	$5,$0
	lw	$2,Draw_gViewOtSize
	li	$6,12			# 0x0000000c
	addu	$2,$2,-2
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,148($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	move	$4,$16
	.set	macro
	.set	reorder

	la	$8,Hrz_gLightningPosInSky_vx
 #APP
	lwc2 $0, 0($8)
	lwc2 $1, 4($8)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$sp,24
 #APP
	swc2 $14, 0($2)
 #NO_APP
	lbu	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L742
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
$L747:
	andi	$2,$16,0x00ff
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$3,$17
	lhu	$2,0($3)
	lhu	$5,24($sp)
	addu	$16,$16,1
	addu	$2,$2,$5
	sh	$2,16($sp)
	lhu	$2,2($3)
	lhu	$5,26($sp)
	lbu	$6,96($17)
	addu	$2,$2,$5
	sh	$2,18($sp)
	lbu	$5,4($3)
	.set	noreorder
	.set	nomacro
	jal	Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
	move	$7,$18
	.set	macro
	.set	reorder

	lbu	$3,100($17)
	andi	$2,$16,0x00ff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L747
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L742:
	lui	$3,%hi(gHrz_Lightning) # high
	addiu	$3,$3,%lo(gHrz_Lightning) # low
	lw	$2,96($3)
	#nop
	addu	$2,$2,-16
	sw	$2,96($3)
$L739:
	lw	$31,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Hrz_BuildForkLightning__FP11Draw_DCache
	.text
	.ent	Hrz_LightningFlicker__Fi
Hrz_LightningFlicker__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L749
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	bne	$4,$2,$L750
	lbu	$2,Night_gShowForks
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	li	$2,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xc0c0
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xc0c0
	li	$5,84			# 0x00000054
	lui	$3,%hi(gSkyColor) # high
	addiu	$3,$3,%lo(gSkyColor) # low
	lw	$4,Sky_gTrackSpec
	addu	$3,$3,336
	sw	$2,8($4)
$L752:
	sw	$6,0($3)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L752
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	j	$L748
$L750:
	lbu	$2,Night_gShowForks
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	li	$2,12582912			# 0x00c00000
	.set	macro
	.set	reorder

	ori	$2,$2,0x2828
	li	$6,12582912			# 0x00c00000
	ori	$6,$6,0x2828
	li	$5,84			# 0x00000054
	lui	$3,%hi(gSkyColor) # high
	addiu	$3,$3,%lo(gSkyColor) # low
	lw	$4,Sky_gTrackSpec
	addu	$3,$3,336
	sw	$2,8($4)
$L758:
	sw	$6,0($3)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L758
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	j	$L748
$L749:
	lui	$2,%hi(Hrz_gSaveCol+4) # high
	lw	$3,Sky_gTrackSpec
	lw	$2,%lo(Hrz_gSaveCol+4)($2)
	.set	noreorder
	.set	nomacro
	jal	Hrz_InitSkyColor__Fv
	sw	$2,8($3)
	.set	macro
	.set	reorder

$L748:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Hrz_LightningFlicker__Fi
	.text
	.ent	HrzSetPsxMatrix__FP10matrixtdef
HrzSetPsxMatrix__FP10matrixtdef:
	.frame	$sp,72,$31		# vars= 72, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	lw	$7,0($4)
	lw	$5,4($4)
	lw	$10,8($4)
	subu	$5,$0,$5
	sw	$7,32($sp)
	sra	$7,$7,4
	sw	$5,36($sp)
	sra	$5,$5,4
	sw	$10,40($sp)
	sra	$10,$10,4
	lw	$3,12($4)
	lw	$2,16($4)
	lw	$8,20($4)
	subu	$2,$0,$2
	sw	$3,44($sp)
	sra	$3,$3,4
	sw	$2,48($sp)
	sra	$2,$2,4
	sw	$8,52($sp)
	lw	$9,24($4)
	lw	$6,28($4)
	lw	$4,32($4)
	sra	$8,$8,4
	sh	$7,0($sp)
	sh	$3,2($sp)
	sh	$5,6($sp)
	sh	$2,8($sp)
	sh	$10,12($sp)
	sh	$8,14($sp)
	subu	$6,$0,$6
	sw	$9,56($sp)
	sra	$9,$9,4
	sw	$6,60($sp)
	sra	$6,$6,4
	sw	$4,64($sp)
	sra	$4,$4,4
	sh	$9,4($sp)
	sh	$6,10($sp)
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
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	HrzSetPsxMatrix__FP10matrixtdef
	.text
	.ent	HrzSetPsxTranslation__FP8coorddef
HrzSetPsxTranslation__FP8coorddef:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	subu	$sp,$sp,32
	sra	$2,$2,10
	sw	$2,20($sp)
	lw	$2,4($4)
	#nop
	sra	$2,$2,10
	sw	$2,24($sp)
	lw	$2,8($4)
	#nop
	sra	$2,$2,10
	sw	$2,28($sp)
 #APP
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

	.end	HrzSetPsxTranslation__FP8coorddef
	.text
	.ent	Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L775
	addu	$2,$4,-1
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L772:
 #APP
	lwc2 $0, 0($5)
	lwc2 $1, 4($5)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$5,$5,8
 #APP
	swc2 $14, 0($7)
 #NO_APP
	addu	$7,$7,4
 #APP
	swc2 $27, 0($6)
 #NO_APP
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L772
	addu	$6,$6,4
	.set	macro
	.set	reorder

$L775:
	j	$31
	.end	Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
	.text
	.ent	Hrz_SetDitheringPrim__Fii
Hrz_SetDitheringPrim__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$6,$4
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	sll	$5,$5,2
	lw	$2,528482304
	li	$8,-16777216			# 0xff000000
	sw	$31,24($sp)
	lw	$4,0($9)
	addu	$5,$5,$2
	lw	$3,0($4)
	lw	$2,0($5)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	addu	$3,$4,12
	lw	$2,0($5)
	and	$7,$4,$7
	sw	$3,0($9)
	and	$2,$2,$8
	or	$2,$2,$7
	sw	$2,0($5)
	move	$5,$0
	li	$7,256			# 0x00000100
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
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

	.end	Hrz_SetDitheringPrim__Fii
	.text
	.ent	Hrz_BuildSky__Fv
Hrz_BuildSky__Fv:
	.frame	$sp,72,$31		# vars= 32, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,48($sp)
	li	$16,120			# 0x00000078
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$31,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L779
	sw	$17,52($sp)
	.set	macro
	.set	reorder

	li	$16,60			# 0x0000003c
$L779:
	li	$17,528482304			# 0x1f800000
	ori	$17,$17,0x0014
	li	$20,528482304			# 0x1f800000
	lw	$2,Sky_gTrackSpec
	ori	$20,$20,0x0168
	lw	$2,4($2)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L780
	li	$18,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(gSkyMesh) # high
	addiu	$6,$2,%lo(gSkyMesh) # low
	li	$7,85			# 0x00000055
	move	$5,$18
	ori	$5,$5,0x0008
	move	$4,$18
	ori	$4,$4,0x015c
$L781:
	addu	$3,$6,8
	addu	$2,$6,16
 #APP
	lwc2 $0, 0($6)
	lwc2 $1, 4($6)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$6,$6,24
	addu	$7,$7,-3
	addu	$5,$5,12
	addu	$4,$4,12
	addu	$2,$5,4
	addu	$8,$5,8
 #APP
	swc2 $12, 0($5)
	swc2 $13, 0($2)
	swc2 $14, 0($8)
 #NO_APP
	addu	$2,$4,4
	addu	$3,$4,8
 #APP
	swc2 $17, 0($4)
	swc2 $18, 0($2)
	swc2 $19, 0($3)
 #NO_APP
	slt	$2,$7,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$5,$8
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$2,$L790
	move	$4,$3
	.set	macro
	.set	reorder

$L786:
 #APP
	lwc2 $0, 0($6)
	lwc2 $1, 4($6)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$6,$6,8
	addu	$5,$5,4
	addu	$4,$4,4
 #APP
	swc2 $14, 0($5)
	swc2 $19, 0($4)
 #NO_APP
	addu	$7,$7,-1
	beq	$7,$2,$L790
	j	$L786
$L780:
	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(gSkyMesh) # high
	addiu	$6,$2,%lo(gSkyMesh) # low
	li	$3,528482304			# 0x1f800000
	ori	$3,$3,0x0010
	li	$5,528482304			# 0x1f800000
	ori	$5,$5,0x0164
	li	$4,84			# 0x00000054
	addu	$7,$sp,32
	li	$8,-1			# 0xffffffff
$L791:
 #APP
	lwc2 $0, 0($6)
	lwc2 $1, 4($6)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$6,$6,8
	addu	$3,$3,4
	addu	$5,$5,4
 #APP
	swc2 $25, 0($7)
	swc2 $26, 4($7)
	swc2 $27, 8($7)
	swc2 $14, 0($3)
 #NO_APP
	lw	$2,36($sp)
	#nop
	sra	$2,$2,2
	addu	$2,$2,$16
	sh	$2,2($3)
 #APP
	swc2 $19, 0($5)
 #NO_APP
	addu	$4,$4,-1
	bne	$4,$8,$L791
$L790:
	lw	$2,Sky_gTrackSpec
	#nop
	lw	$2,4($2)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$5,Draw_gViewOtSize
	.set	noreorder
	.set	nomacro
	jal	Hrz_SetDitheringPrim__Fii
	addu	$5,$5,-2
	.set	macro
	.set	reorder

$L795:
	lui	$3,%hi(gHorizonPixmap) # high
	lui	$2,%hi(TrackSpec_gSpec+92) # high
	lw	$2,%lo(TrackSpec_gSpec+92)($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L796
	addiu	$19,$3,%lo(gHorizonPixmap) # low
	.set	macro
	.set	reorder

	la	$4,sunPosInSky_vx
	lw	$16,148($18)
	.set	noreorder
	.set	nomacro
	jal	Flare_Sun__FP7SVECTORP15Draw_FlareCache
	move	$5,$18
	.set	macro
	.set	reorder

	sw	$16,148($18)
$L796:
	lw	$15,Sky_gTrackSpec
	move	$11,$0
	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x0004
	li	$16,528482304			# 0x1f800000
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$13,-16777216			# 0xff000000
	lui	$2,%hi(gSkyColor+68) # high
	addiu	$14,$2,%lo(gSkyColor+68) # low
	addu	$25,$14,-68
	addu	$24,$14,-64
	lui	$2,%hi(gSkyPixmapIndex) # high
	addiu	$12,$2,%lo(gSkyPixmapIndex) # low
$L797:
	slt	$2,$11,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	sll	$2,$11,4
	.set	macro
	.set	reorder

	addu	$2,$2,$11
	.set	noreorder
	.set	nomacro
	bgez	$2,$L817
	sra	$8,$2,4
	.set	macro
	.set	reorder

	addu	$2,$2,15
	sra	$8,$2,4
$L817:
	sll	$2,$8,2
	addu	$3,$2,$20
	lw	$2,68($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L818
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lw	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L818
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L818
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L802
	sll	$2,$8,2
	.set	macro
	.set	reorder

$L818:
	addu	$4,$2,$17
	lhu	$3,16($18)
	lh	$2,68($4)
	sll	$3,$3,16
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,72($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,4($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,0($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L802
	sll	$2,$8,2
	.set	macro
	.set	reorder

$L819:
	addu	$3,$2,$17
	lh	$2,68($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L820
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L820
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L820
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L802
	sll	$2,$8,2
	.set	macro
	.set	reorder

$L820:
	addu	$4,$2,$17
	lhu	$3,18($18)
	lh	$2,70($4)
	sll	$3,$3,16
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L821
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,74($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L821
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lh	$2,6($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L821
	sll	$2,$8,2
	.set	macro
	.set	reorder

	lhu	$2,2($4)
	#nop
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L802
	sll	$2,$8,2
	.set	macro
	.set	reorder

$L821:
	addu	$3,$2,$17
	lh	$2,70($3)
	#nop
	bgez	$2,$L809
	lh	$2,74($3)
	#nop
	bgez	$2,$L809
	lh	$2,6($3)
	#nop
	bgez	$2,$L809
	lhu	$2,2($3)
	#nop
	sll	$2,$2,16
	bltz	$2,$L802
$L809:
	lw	$3,0($15)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L810
	lw	$2,4($15)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L811
	lbu	$5,0($12)
	lw	$2,Draw_gViewOtSize
	lw	$6,0($16)
	lw	$4,0($10)
	sll	$5,$5,2
	addu	$5,$5,$19
	sll	$2,$2,2
	addu	$6,$6,$2
	lw	$2,-8($6)
	lw	$3,0($4)
	lw	$7,0($5)
	and	$2,$2,$9
	and	$3,$3,$13
	or	$2,$2,$3
	sw	$2,0($4)
	lw	$2,-8($6)
	and	$3,$4,$9
	and	$2,$2,$13
	or	$2,$2,$3
	sll	$3,$8,2
	sw	$2,-8($6)
	addu	$2,$3,$14
	lw	$2,0($2)
	#nop
	sw	$2,4($4)
	addu	$2,$4,52
	sw	$2,0($10)
	addu	$2,$14,$3
	lw	$2,4($2)
	#nop
	sw	$2,16($4)
	addu	$2,$3,$25
	lw	$2,0($2)
	#nop
	sw	$2,28($4)
	addu	$2,$3,$24
	lw	$5,0($2)
	li	$2,12			# 0x0000000c
	sb	$2,3($4)
	li	$2,60			# 0x0000003c
	sb	$2,7($4)
	sw	$5,40($4)
	lw	$2,0($7)
	#nop
	sw	$2,12($4)
	lw	$2,4($7)
	#nop
	sw	$2,24($4)
	lw	$2,8($7)
	#nop
	sw	$2,36($4)
	lw	$2,12($7)
	addu	$3,$3,$17
	sw	$2,48($4)
	lw	$2,68($3)
	#nop
	sw	$2,8($4)
	lw	$2,72($3)
	#nop
	sw	$2,20($4)
	lw	$2,0($3)
	#nop
	sw	$2,32($4)
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L802
	sw	$2,44($4)
	.set	macro
	.set	reorder

$L811:
	lbu	$5,0($12)
	lw	$2,Draw_gViewOtSize
	lw	$6,0($16)
	lw	$4,0($10)
	sll	$5,$5,2
	addu	$5,$5,$19
	sll	$2,$2,2
	addu	$6,$6,$2
	lw	$2,-8($6)
	lw	$3,0($4)
	lw	$5,0($5)
	and	$2,$2,$9
	and	$3,$3,$13
	or	$2,$2,$3
	sw	$2,0($4)
	lw	$3,-8($6)
	addu	$2,$4,40
	sw	$2,0($10)
	and	$2,$4,$9
	and	$3,$3,$13
	or	$3,$3,$2
	sw	$3,-8($6)
	lw	$3,8($15)
	li	$2,9			# 0x00000009
	sb	$2,3($4)
	li	$2,44			# 0x0000002c
	sw	$3,4($4)
	sb	$2,7($4)
	lw	$2,0($5)
	#nop
	sw	$2,12($4)
	lw	$2,4($5)
	#nop
	sw	$2,20($4)
	lw	$2,8($5)
	sll	$3,$8,2
	sw	$2,28($4)
	lw	$2,12($5)
	addu	$3,$3,$17
	.set	noreorder
	.set	nomacro
	j	$L816
	sw	$2,36($4)
	.set	macro
	.set	reorder

$L810:
	lw	$2,Draw_gViewOtSize
	lw	$5,0($16)
	lw	$4,0($10)
	sll	$2,$2,2
	addu	$5,$5,$2
	lw	$3,-8($5)
	lw	$2,0($4)
	and	$3,$3,$9
	and	$2,$2,$13
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,-8($5)
	and	$3,$4,$9
	and	$2,$2,$13
	or	$2,$2,$3
	sll	$3,$8,2
	sw	$2,-8($5)
	addu	$2,$3,$14
	lw	$2,0($2)
	#nop
	sw	$2,4($4)
	addu	$2,$4,36
	sw	$2,0($10)
	addu	$2,$14,$3
	lw	$2,4($2)
	#nop
	sw	$2,12($4)
	addu	$2,$3,$25
	lw	$2,0($2)
	#nop
	sw	$2,20($4)
	addu	$2,$3,$24
	lw	$5,0($2)
	li	$2,8			# 0x00000008
	sb	$2,3($4)
	li	$2,56			# 0x00000038
	addu	$3,$3,$17
	sb	$2,7($4)
	sw	$5,28($4)
$L816:
	lw	$2,68($3)
	#nop
	sw	$2,8($4)
	lw	$2,72($3)
	#nop
	sw	$2,16($4)
	lw	$2,0($3)
	#nop
	sw	$2,24($4)
	lw	$2,4($3)
	#nop
	sw	$2,32($4)
$L802:
	addu	$12,$12,1
	.set	noreorder
	.set	nomacro
	j	$L797
	addu	$11,$11,1
	.set	macro
	.set	reorder

$L798:
	lw	$2,Sky_gTrackSpec
	#nop
	lw	$2,4($2)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,Draw_gViewOtSize
	.set	noreorder
	.set	nomacro
	jal	Hrz_SetDitheringPrim__Fii
	addu	$5,$5,-2
	.set	macro
	.set	reorder

$L778:
	lw	$31,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Hrz_BuildSky__Fv
	.text
	.ent	Sky_RenderStars__FP13Draw_SkyCachei
Sky_RenderStars__FP13Draw_SkyCachei:
	.frame	$sp,88,$31		# vars= 48, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$18,72($sp)
	move	$18,$4
	sw	$19,76($sp)
	move	$19,$5
	sw	$17,68($sp)
	li	$17,120			# 0x00000078
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$31,80($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L823
	sw	$16,64($sp)
	.set	macro
	.set	reorder

	li	$17,60			# 0x0000003c
$L823:
	addu	$4,$sp,16
	move	$5,$0
	lw	$16,starPosInSky
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$2,Sky_gTrackSpec
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L822
	move	$6,$0
	.set	macro
	.set	reorder

	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	li	$9,-16777216			# 0xff000000
$L825:
 #APP
	lwc2 $0, 0($16)
	lwc2 $1, 4($16)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$16,$16,8
	addu	$2,$sp,56
 #APP
	swc2 $19, 0($2)
 #NO_APP
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L828
	addu	$2,$sp,32
	.set	macro
	.set	reorder

 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$2,$sp,40
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,44($sp)
	lh	$4,32($sp)
	sra	$2,$2,2
	addu	$3,$2,$17
	sh	$3,34($sp)
	lh	$2,16($18)
	#nop
	slt	$2,$2,$4
	bne	$2,$0,$L828
	.set	noreorder
	.set	nomacro
	bltz	$4,$L828
	sll	$3,$3,16
	.set	macro
	.set	reorder

	lh	$2,18($18)
	sra	$3,$3,16
	slt	$2,$2,$3
	bne	$2,$0,$L828
	.set	noreorder
	.set	nomacro
	bltz	$3,$L828
	sll	$5,$19,2
	.set	macro
	.set	reorder

	lw	$2,528482304
	lw	$4,0($8)
	addu	$5,$5,$2
	lw	$3,0($4)
	lw	$2,0($5)
	and	$3,$3,$9
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($5)
	addu	$2,$4,12
	sw	$2,0($8)
	and	$2,$4,$7
	and	$3,$3,$9
	or	$3,$3,$2
	sw	$3,0($5)
	lw	$3,starColors
	sll	$2,$6,2
	addu	$2,$2,$3
	lw	$3,0($2)
	li	$2,2			# 0x00000002
	sb	$2,3($4)
	li	$2,104			# 0x00000068
	sw	$3,4($4)
	sb	$2,7($4)
	lw	$2,32($sp)
	#nop
	sw	$2,8($4)
$L828:
	lw	$2,Sky_gTrackSpec
	#nop
	lw	$2,68($2)
	addu	$6,$6,1
	slt	$2,$6,$2
	bne	$2,$0,$L825
$L822:
	lw	$31,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Sky_RenderStars__FP13Draw_SkyCachei
	.text
	.ent	Hrz_BuildHorizon__FP13DRender_tView
Hrz_BuildHorizon__FP13DRender_tView:
	.frame	$sp,128,$31		# vars= 64, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$16,88($sp)
	move	$16,$4
	li	$2,65536			# 0x00010000
	ori	$2,$2,0x07ae
	addu	$4,$sp,24
	move	$5,$0
	li	$6,12			# 0x0000000c
	sw	$31,124($sp)
	sw	$fp,120($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$21,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$2,76($sp)
	.set	macro
	.set	reorder

	lw	$3,Camera_gGeomScreen
	li	$22,528482304			# 0x1f800000
	slt	$2,$3,701
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L833
	sw	$0,80($sp)
	.set	macro
	.set	reorder

	sw	$3,80($sp)
	.set	noreorder
	.set	nomacro
	jal	SetGeomScreen
	li	$4,700			# 0x000002bc
	.set	macro
	.set	reorder

$L833:
	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxMatrix__FP10matrixtdef
	addu	$4,$16,68
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	li	$4,17			# 0x00000011
	lw	$5,gRngCoordTop
	li	$6,528482304			# 0x1f800000
	ori	$6,$6,0x0124
	li	$7,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR
	ori	$7,$7,0x0058
	.set	macro
	.set	reorder

	move	$8,$0
	move	$6,$8
	li	$5,528482304			# 0x1f800000
	ori	$5,$5,0x0124
	move	$4,$8
$L834:
	lw	$3,0($5)
	#nop
	slt	$2,$6,$3
	beq	$2,$0,$L837
	move	$6,$3
	move	$8,$4
$L837:
	addu	$4,$4,1
	slt	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L834
	addu	$5,$5,4
	.set	macro
	.set	reorder

	sll	$2,$8,3
	lw	$4,gRngCoordTop
	lw	$5,Hrz_gTrackSpec
	addu	$4,$4,$2
	lhu	$2,0($4)
	#nop
	sh	$2,40($sp)
	lhu	$2,8($5)
	lhu	$3,12($5)
	#nop
	addu	$2,$2,$3
	sh	$2,42($sp)
	lhu	$2,4($4)
	#nop
	sh	$2,44($sp)
	lhu	$2,0($4)
	#nop
	sh	$2,48($sp)
	lhu	$2,8($5)
	#nop
	sh	$2,50($sp)
	lhu	$2,4($4)
	addu	$4,$sp,64
	sh	$2,52($sp)
	lwl	$9,51($sp)
	lwr	$9,48($sp)
	lwl	$10,55($sp)
	lwr	$10,52($sp)
	swl	$9,67($sp)
	swr	$9,64($sp)
	swl	$10,71($sp)
	swr	$10,68($sp)
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$3,$sp,72
 #APP
	swc2 $14, 0($3)
 #NO_APP
	lw	$2,72($sp)
	lwl	$9,43($sp)
	lwr	$9,40($sp)
	lwl	$10,47($sp)
	lwr	$10,44($sp)
	swl	$9,67($sp)
	swr	$9,64($sp)
	swl	$10,71($sp)
	swr	$10,68($sp)
	sw	$2,60($sp)
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	nop
	nop
	.word 0x4A180001
	swc2 $14, 0($3)
 #NO_APP
	move	$7,$0
	lw	$2,72($sp)
	move	$6,$22
	sw	$2,56($sp)
	sll	$2,$8,2
	addu	$2,$2,$22
	lh	$5,56($sp)
	lh	$3,88($2)
	lh	$4,58($sp)
	lh	$2,90($2)
	subu	$5,$5,$3
	subu	$4,$4,$2
$L839:
	lw	$2,292($6)
	#nop
	blez	$2,$L840
	lhu	$2,88($6)
	lhu	$3,90($6)
	addu	$2,$2,$5
	addu	$3,$3,$4
	sh	$2,20($6)
	sh	$3,22($6)
$L840:
	addu	$7,$7,1
	slt	$2,$7,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L839
	addu	$6,$6,4
	.set	macro
	.set	reorder

	move	$7,$0
	move	$6,$22
	sll	$2,$8,2
	addu	$2,$2,$22
	lh	$5,60($sp)
	lh	$3,88($2)
	lh	$4,62($sp)
	lh	$2,90($2)
	subu	$5,$5,$3
	subu	$4,$4,$2
$L842:
	lw	$2,292($6)
	#nop
	blez	$2,$L843
	lhu	$2,88($6)
	lhu	$3,90($6)
	addu	$2,$2,$5
	addu	$3,$3,$4
	sh	$2,88($6)
	sh	$3,90($6)
$L843:
	addu	$7,$7,1
	slt	$2,$7,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L842
	addu	$6,$6,4
	.set	macro
	.set	reorder

	ori	$4,$22,0x009c
	ori	$5,$22,0x0058
	ori	$6,$22,0x0014
	lui	$16,%hi(gfxPmxHeightPercentage) # high
	addiu	$16,$16,%lo(gfxPmxHeightPercentage) # low
	move	$7,$16
	li	$18,16			# 0x00000010
	li	$17,1			# 0x00000001
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	ori	$4,$22,0x00e0
	ori	$5,$22,0x005c
	ori	$6,$22,0x0018
	move	$7,$16
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(TrackSpec_gSpec+4) # high
	lh	$2,%lo(TrackSpec_gSpec+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L845
	move	$20,$0
	.set	macro
	.set	reorder

	move	$18,$20
	li	$21,4			# 0x00000004
	li	$fp,-16777216			# 0xff000000
	lui	$2,%hi(gHrzRingColor+68) # high
	addiu	$23,$2,%lo(gHrzRingColor+68) # low
	move	$19,$22
$L846:
	slt	$2,$20,16
	beq	$2,$0,$L845
	lw	$2,292($19)
	#nop
	slt	$2,$2,16000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L851
	addu	$2,$22,$21
	.set	macro
	.set	reorder

	lw	$2,292($2)
	#nop
	slt	$2,$2,16000
	bne	$2,$0,$L850
$L851:
	addu	$2,$22,$21
	lwl	$9,159($19)
	lwr	$9,156($19)
	swl	$9,43($sp)
	swr	$9,40($sp)
	lwl	$9,227($19)
	lwr	$9,224($19)
	swl	$9,47($sp)
	swr	$9,44($sp)
	lwl	$9,91($2)
	lwr	$9,88($2)
	swl	$9,51($sp)
	swr	$9,48($sp)
	lwl	$9,91($19)
	lwr	$9,88($19)
	swl	$9,55($sp)
	swr	$9,52($sp)
	lh	$2,40($sp)
	#nop
	bgez	$2,$L853
	lh	$2,44($sp)
	#nop
	bgez	$2,$L853
	lh	$2,48($sp)
	#nop
	bgez	$2,$L853
	lh	$2,52($sp)
	#nop
	bltz	$2,$L850
$L853:
	lh	$3,528482320
	lh	$2,40($sp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L854
	lh	$2,44($sp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L854
	lh	$2,48($sp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L854
	lh	$2,52($sp)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L850
$L854:
	lh	$2,42($sp)
	#nop
	bgez	$2,$L855
	lh	$2,46($sp)
	#nop
	bgez	$2,$L855
	lh	$2,50($sp)
	#nop
	bgez	$2,$L855
	lh	$2,54($sp)
	#nop
	bltz	$2,$L850
$L855:
	lhu	$2,18($22)
	lh	$3,42($sp)
	sll	$2,$2,16
	sra	$4,$2,16
	slt	$3,$4,$3
	beq	$3,$0,$L856
	lh	$2,46($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L856
	lh	$2,50($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L856
	lh	$2,54($sp)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L850
$L856:
	addu	$4,$sp,56
	addu	$5,$18,156
	addu	$5,$22,$5
	addu	$6,$18,224
	addu	$6,$22,$6
	addu	$7,$sp,76
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(gpPmx) # high
	addiu	$3,$3,%lo(gpPmx) # low
	addu	$3,$18,$3
	lw	$2,Hrz_gTrackSpec
	li	$4,16			# 0x00000010
	addu	$2,$2,$20
	lbu	$2,32($2)
	lw	$17,0($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L850
	li	$3,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$3,$3,0x0004
	li	$5,16711680			# 0x00ff0000
	lw	$16,0($3)
	ori	$5,$5,0xffff
	addu	$2,$16,52
	sw	$2,0($3)
	lw	$2,Draw_gViewOtSize
	lw	$4,528482304
	lw	$3,0($16)
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$2,-8($4)
	and	$3,$3,$fp
	and	$2,$2,$5
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$2,-8($4)
	and	$5,$16,$5
	and	$2,$2,$fp
	or	$2,$2,$5
	sw	$2,-8($4)
	addu	$2,$18,$23
	lw	$2,0($2)
	#nop
	sw	$2,4($16)
	addu	$2,$23,$18
	lw	$2,4($2)
	lui	$9,%hi(gHrzRingColor+4) # high
	sw	$2,16($16)
	addu	$2,$23,$18
	lw	$2,-68($2)
	addiu	$9,$9,%lo(gHrzRingColor+4) # low
	sw	$2,28($16)
	addu	$2,$18,$9
	lw	$2,0($2)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetPolyGT4
	sw	$2,40($16)
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	sw	$2,12($16)
	lw	$2,4($17)
	#nop
	sw	$2,24($16)
	lw	$2,8($17)
	#nop
	sw	$2,36($16)
	lw	$2,12($17)
	#nop
	sw	$2,48($16)
	lw	$2,Hrz_gTrackSpec
	#nop
	addu	$2,$2,$20
	lbu	$2,32($2)
	#nop
	sltu	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L858
	addu	$3,$22,$18
	.set	macro
	.set	reorder

	lw	$2,56($sp)
	#nop
	sw	$2,8($16)
	lw	$2,156($19)
	#nop
	sw	$2,20($16)
	lw	$2,92($19)
	#nop
	sw	$2,32($16)
	lw	$2,88($19)
	.set	noreorder
	.set	nomacro
	j	$L850
	sw	$2,44($16)
	.set	macro
	.set	reorder

$L858:
 #APP
 #NO_APP
	lw	$2,156($3)
	#nop
	sw	$2,8($16)
	lw	$2,56($sp)
	#nop
	sw	$2,20($16)
	lw	$2,88($3)
	#nop
	sw	$2,32($16)
	lw	$2,92($3)
	#nop
	sw	$2,44($16)
$L850:
	addu	$19,$19,4
	addu	$18,$18,4
	addu	$21,$21,4
	.set	noreorder
	.set	nomacro
	j	$L846
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L845:
	lw	$2,Night_gLightning
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	lui	$2,%hi(TrackSpec_gSpec) # high
	.set	macro
	.set	reorder

	lbu	$2,Night_gShowForks
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	lui	$2,%hi(TrackSpec_gSpec) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hrz_BuildForkLightning__FP11Draw_DCache
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lui	$2,%hi(TrackSpec_gSpec) # high
$L867:
	addiu	$17,$2,%lo(TrackSpec_gSpec) # low
	lw	$2,92($17)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L861
	addu	$16,$sp,40
	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	HrzSetPsxTranslation__FP8coorddef
	move	$4,$16
	.set	macro
	.set	reorder

	la	$4,moonPosInSky_vx
	.set	noreorder
	.set	nomacro
	jal	Flare_Moon__FP7SVECTORP15Draw_FlareCache
	li	$5,528482304			# 0x1f800000
	.set	macro
	.set	reorder

$L861:
	lw	$2,92($17)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L862
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lw	$5,Draw_gViewOtSize
	.set	noreorder
	.set	nomacro
	jal	Sky_RenderStars__FP13Draw_SkyCachei
	addu	$5,$5,-2
	.set	macro
	.set	reorder

$L862:
	lh	$2,6($17)
	#nop
	beq	$2,$0,$L863
	jal	Hrz_BuildSky__Fv
$L863:
	lw	$10,80($sp)
	#nop
	beq	$10,$0,$L832
	.set	noreorder
	.set	nomacro
	jal	SetGeomScreen
	move	$4,$10
	.set	macro
	.set	reorder

$L832:
	lw	$31,124($sp)
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	Hrz_BuildHorizon__FP13DRender_tView
