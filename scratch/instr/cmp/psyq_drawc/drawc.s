	.file	1 "C:\\\\Temp\\\\nfs4-wt46-a10\\\\recon\\\\game\\\\psx\\\\drawc.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	ChangeTPage__FPUsi
	.align	2
	.globl	DrawC_SetEnviroment__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"%sTr%02d.env\000"
	.align	2
$LC1:
	.ascii	"envmap\000"
	.align	2
$LC2:
	.ascii	"Shadow\000"
	.text
	.align	2
	.globl	DrawC_ReadLightingData__Fv
	.align	2
	.globl	DrawC_ReadeMapData__Fv
	.align	2
	.globl	DrawC_BuildRenderingData__Fv
	.align	2
	.globl	DrawC_KillRenderingData__Fv
	.align	2
	.globl	DrawC_NightHeadlight__FP8Car_tObj
	.sdata
	.align	2
$LC3:
	.ascii	"d\000"
	.align	2
$LC4:
	.ascii	"l\000"
	.rdata
	.align	2
$LC5:
	.ascii	".psh\000"
	.text
	.align	2
	.globl	DrawC_MenuColorData__FiP8Car_tObji
	.align	2
	.globl	DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
	.align	2
	.globl	DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
	.align	2
	.globl	DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.align	2
	.globl	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	.align	2
	.globl	DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.align	2
	.globl	DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.align	2
	.globl	DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
	.align	2
	.globl	DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
	.align	2
	.globl	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	.align	2
	.globl	DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
	.align	2
	.globl	DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
	.align	2
	.globl	DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
	.globl	DrawC_gEnvMap
	.sdata
	.align	2
DrawC_gEnvMap:
	.space	4
	.globl	DrawC_gEnvMapMax
	.align	2
DrawC_gEnvMapMax:
	.space	4
	.globl	DrawC_gMenuLightsDirection
	.align	2
DrawC_gMenuLightsDirection:
	.space	4
	.globl	DrawC_gReflectOffset
	.align	1
DrawC_gReflectOffset:
	.space	2
	.globl	DrawC_gShadow
	.align	2
DrawC_gShadow:
	.space	4
	.globl	DrawC_gShadowMax
	.align	2
DrawC_gShadowMax:
	.space	4
	.globl	DrawC_gWetRoad
	.align	2
DrawC_gWetRoad:
	.space	4
	.globl	SP
	.data
	.align	2
SP:
	.space	64

	.extern	hilight_colors, 20
	.extern	Fe3D_lightsVertex, 384
	.extern	gShowroomLights, 4
	.extern	Fe3D_spotVertex, 198
	.extern	gShadowPixmap, 4
	.extern	TrsProj_precision, 4
	.extern	R3DCar_eMapColour, 4
	.extern	gMenuPixmap, 32
	.extern	Cars_kSkidMarkSurface, 64
	.extern	DrawC_gEnvMapOffset, 8
	.extern	Track_gReflectionMaps, 64
	.extern	gFlip, 4
	.extern	DrawC_gMatA, 32
	.extern	R3DCar_yawCam, 2
	.extern	DrawC_TailLightFlash, 32
	.extern	DrawC_HeadLightFlash, 32
	.extern	DrawC_SirenFlash, 32
	.extern	R3DCar_SignalBrakeFlare, 28
	.extern	DrawC_gOverlay, 102
	.extern	CarIO_carPixMap, 4
	.extern	Draw_gViewOtSize, 4
	.extern	R3DCar_InMenu, 4
	.extern	DrawC_gScreenMat, 32
	.extern	Texture_CarColor, 4
	.extern	DrawC_gMenuColor, 8
	.extern	Night_gLightningType, 4
	.extern	Night_gWeatherColor, 8
	.extern	Night_gDrawLightning, 1
	.extern	gNightMat, 36
	.extern	Cars_gHumanRaceCarList, 8
	.extern	Cars_gList, 8
	.extern	gCView, 140
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	ChangeTPage__FPUsi
ChangeTPage__FPUsi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,0($4)
	sll	$5,$5,5
	andi	$2,$2,0xff9f
	or	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,0($4)
	.set	macro
	.set	reorder

	.end	ChangeTPage__FPUsi
	.text
	.ent	DrawC_SetEnviroment__Fv
DrawC_SetEnviroment__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DrawC_SetEnviroment__Fv
	.text
	.ent	DrawC_ReadLightingData__Fv
DrawC_ReadLightingData__Fv:
	.frame	$sp,304,$31		# vars= 264, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,304
	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+24) # high
	lw	$6,%lo(Paths_Paths+24)($2)
	lui	$2,%hi(GameSetup_gData+60) # high
	lui	$5,%hi($LC0) # high
	lw	$7,%lo(GameSetup_gData+60)($2)
	addiu	$5,$5,%lo($LC0) # low
	sw	$31,296($sp)
	sw	$19,292($sp)
	sw	$18,288($sp)
	sw	$17,284($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,280($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	addu	$16,$sp,272
	move	$4,$16
	move	$19,$2
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sw	$19,272($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,1
	sw	$2,DrawC_gEnvMapMax
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,DrawC_gEnvMapMax
	sw	$2,DrawC_gEnvMap
	.set	noreorder
	.set	nomacro
	blez	$3,$L372
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	move	$16,$17
$L374:
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,DrawC_gEnvMap
	move	$4,$18
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,0($3)
	.set	macro
	.set	reorder

	lw	$3,DrawC_gEnvMap
	move	$4,$18
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,2($3)
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$3,DrawC_gEnvMap
	sll	$2,$2,8
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,4($3)
	.set	macro
	.set	reorder

	lw	$3,DrawC_gEnvMap
	#nop
	addu	$5,$16,$3
	lhu	$3,4($5)
	lh	$4,0($5)
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L373
	sh	$3,4($5)
	.set	macro
	.set	reorder

	li	$2,32767			# 0x00007fff
	.set	noreorder
	.set	nomacro
	j	$L372
	sh	$2,0($5)
	.set	macro
	.set	reorder

$L373:
	lw	$2,DrawC_gEnvMapMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L374
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L372:
	addu	$16,$sp,272
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,1
	sw	$2,DrawC_gShadowMax
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,DrawC_gShadowMax
	sw	$2,DrawC_gShadow
	.set	noreorder
	.set	nomacro
	blez	$3,$L378
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	move	$16,$17
$L380:
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,DrawC_gShadow
	move	$4,$18
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,0($3)
	.set	macro
	.set	reorder

	lw	$3,DrawC_gShadow
	move	$4,$18
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,2($3)
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$3,DrawC_gShadow
	sll	$2,$2,8
	addu	$3,$16,$3
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sh	$2,4($3)
	.set	macro
	.set	reorder

	lw	$3,DrawC_gShadow
	#nop
	addu	$5,$16,$3
	lhu	$3,4($5)
	lh	$4,0($5)
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L379
	sh	$3,4($5)
	.set	macro
	.set	reorder

	li	$2,32767			# 0x00007fff
	.set	noreorder
	.set	nomacro
	j	$L378
	sh	$2,0($5)
	.set	macro
	.set	reorder

$L379:
	lw	$2,DrawC_gShadowMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L380
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L378:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$31,296($sp)
	lw	$19,292($sp)
	lw	$18,288($sp)
	lw	$17,284($sp)
	lw	$16,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,304
	.set	macro
	.set	reorder

	.end	DrawC_ReadLightingData__Fv
	.text
	.ent	DrawC_ReadeMapData__Fv
DrawC_ReadeMapData__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	R3DCcar_ReadeMapData__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawC_ReadeMapData__Fv
	.text
	.ent	DrawC_BuildRenderingData__Fv
DrawC_BuildRenderingData__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	DrawC_ReadLightingData__Fv
	jal	DrawC_ReadeMapData__Fv
	jal	R3DCcar_ReadTrackShadow__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawC_BuildRenderingData__Fv
	.text
	.ent	DrawC_KillRenderingData__Fv
DrawC_KillRenderingData__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,DrawC_gEnvMap
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lw	$4,DrawC_gShadow
	jal	purgememadr
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawC_KillRenderingData__Fv
	.text
	.ent	DrawC_NightHeadlight__FP8Car_tObj
DrawC_NightHeadlight__FP8Car_tObj:
	.frame	$sp,128,$31		# vars= 96, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	move	$5,$4
	lui	$3,%hi(gCView+4) # high
	lui	$2,%hi(Cars_gList) # high
	lw	$3,%lo(gCView+4)($3)
	addiu	$2,$2,%lo(Cars_gList) # low
	sw	$31,120($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	sll	$4,$3,2
	addu	$2,$4,$2
	lw	$3,0($2)
	addu	$2,$5,2176
	sw	$2,104($sp)
	lbu	$2,1095($3)
	#nop
	andi	$2,$2,0x0006
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L387
	addu	$6,$5,160
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	addu	$3,$4,$3
	lw	$2,0($3)
	lui	$17,%hi(gNightMat) # high
	lw	$4,160($2)
	lw	$2,160($5)
	addiu	$17,$17,%lo(gNightMat) # low
	subu	$2,$2,$4
	sw	$2,72($sp)
	lw	$2,0($3)
	addu	$16,$sp,88
	lw	$5,164($2)
	lw	$2,4($6)
	addu	$4,$sp,72
	subu	$2,$2,$5
	sw	$2,76($sp)
	lw	$2,0($3)
	move	$5,$17
	lw	$3,168($2)
	lw	$2,8($6)
	move	$6,$16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,80($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$sp,64
	sh	$0,68($sp)
	sh	$0,66($sp)
	sh	$0,64($sp)
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	addu	$4,$sp,48
 #APP
	swc2 $25, 0($4)
	swc2 $26, 4($4)
	swc2 $27, 8($4)
 #NO_APP
	lw	$5,104($sp)
	jal	Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
$L387:
	lbu	$2,Night_gDrawLightning
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L386
	lui	$2,%hi(Night_gWeatherColor) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Night_gWeatherColor) # low
	addu	$6,$sp,104
	lw	$3,Night_gLightningType
	lbu	$4,104($sp)
	sll	$3,$3,2
	addu	$3,$3,$2
	lbu	$2,0($3)
	lbu	$5,1($3)
	addu	$2,$2,$4
	move	$8,$2
	lbu	$4,1($6)
	slt	$2,$2,256
	addu	$5,$5,$4
	lbu	$4,2($3)
	lbu	$3,2($6)
	move	$7,$5
	addu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L389
	move	$3,$4
	.set	macro
	.set	reorder

	li	$8,255			# 0x000000ff
$L389:
	slt	$2,$5,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L392
	slt	$2,$4,256
	.set	macro
	.set	reorder

	li	$7,255			# 0x000000ff
$L392:
	bne	$2,$0,$L391
	li	$3,255			# 0x000000ff
$L391:
	sb	$8,104($sp)
	sb	$7,1($6)
	sb	$3,2($6)
$L386:
	lw	$31,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	DrawC_NightHeadlight__FP8Car_tObj
	.text
	.ent	DrawC_MenuColorData__FiP8Car_tObji
DrawC_MenuColorData__FiP8Car_tObji:
	.frame	$sp,160,$31		# vars= 120, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$18,144($sp)
	move	$18,$4
	sw	$17,140($sp)
	move	$17,$5
	sw	$19,148($sp)
	sw	$31,152($sp)
	sw	$16,136($sp)
	lw	$4,648($17)
	lw	$2,2264($17)
	lw	$3,0($4)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L394
	move	$19,$6
	.set	macro
	.set	reorder

	lh	$2,2236($17)
	#nop
	bne	$2,$3,$L393
	lbu	$2,64($4)
	lbu	$3,60($4)
	lbu	$4,68($4)
	sll	$2,$2,1
	addu	$3,$3,$2
	sll	$4,$4,2
	lhu	$2,2236($17)
	addu	$3,$3,$4
	addu	$2,$2,-16
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L396
	sb	$3,2227($17)
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sb	$2,2227($17)
$L396:
	sll	$5,$19,2
	lui	$2,%hi(DrawC_gMenuColor) # high
	addiu	$2,$2,%lo(DrawC_gMenuColor) # low
	addu	$5,$5,$2
	lbu	$3,2227($17)
	lw	$2,0($5)
	andi	$4,$3,0x0001
	sll	$4,$4,8
	addu	$4,$18,$4
	andi	$3,$3,0x0002
	sll	$3,$3,8
	addu	$3,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L393
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	sw	$3,0($5)
	.set	macro
	.set	reorder

	lh	$5,2236($17)
	#nop
	slt	$2,$5,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L398
	andi	$3,$18,0x0008
	.set	macro
	.set	reorder

	lhu	$2,2112($17)
	#nop
	andi	$2,$2,0x0008
	beq	$3,$2,$L399
	lw	$2,648($17)
	#nop
	lw	$6,160($2)
	.set	noreorder
	.set	nomacro
	jal	R3DCar_GetCarName__FPcii
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	slt	$2,$18,8
	bne	$2,$0,$L400
	addu	$4,$sp,16
	lui	$5,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L403
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

$L400:
	addu	$4,$sp,16
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
$L403:
	jal	strcat
	lui	$2,%hi(Paths_Paths+96) # high
	lw	$5,%lo(Paths_Paths+96)($2)
	addu	$16,$sp,32
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$5,%hi($LC5) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC5) # low
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	CarIO_UpdateCarTextureData__FPcP8Car_tObji
	move	$6,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

$L399:
	move	$5,$0
	andi	$16,$18,0x0007
	lbu	$2,2227($17)
	lw	$4,2180($17)
	andi	$2,$2,0x0002
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$2,Texture_CarColor
	.set	noreorder
	.set	nomacro
	jal	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	lw	$4,2180($17)
	lbu	$2,2227($17)
	lh	$6,2184($17)
	and	$2,$2,$5
	sll	$2,$2,3
	addu	$16,$16,$2
	sw	$16,Texture_CarColor
	j	$L402
$L398:
	move	$5,$0
	lw	$4,2180($17)
	lh	$6,2184($17)
	andi	$2,$18,0x0007
	sw	$2,Texture_CarColor
$L402:
	jal	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
$L394:
	sh	$18,2112($17)
$L393:
	lw	$31,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	DrawC_MenuColorData__FiP8Car_tObji
	.text
	.ent	DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache:
	.frame	$sp,72,$31		# vars= 8, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,40($sp)
	move	$18,$5
	sw	$fp,64($sp)
	move	$fp,$6
	sw	$19,44($sp)
	move	$19,$7
	sw	$23,60($sp)
	move	$23,$0
	lui	$8,%hi(DrawC_gScreenMat) # high
	sw	$31,68($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lh	$17,2236($18)
	addiu	$8,$8,%lo(DrawC_gScreenMat) # low
	addu	$2,$17,-22
	sltu	$20,$2,6
 #APP
	lw   $12, 0($8)
	lw   $13, 4($8)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($8)
	lw   $13, 12($8)
	lw   $14, 16($8)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$9,%hi(DrawC_gScreenMat) # high
	addiu	$9,$9,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 20($9)
	lw   $13, 24($9)
	ctc2 $12, $5
	lw   $14, 28($9)
	ctc2 $13, $6
	ctc2 $14, $7
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$19,64
 #APP
	mfc2	$t4,$19
 nop
 sra $t4,$t4,2
 sw $t4,0($2)
 #NO_APP
	lw	$16,64($19)
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L405
	sra	$3,$16,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$3,$L407
	sw	$3,64($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	beq	$2,$0,$L408
$L407:
	.set	noreorder
	.set	nomacro
	j	$L500
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L405:
	sw	$0,64($19)
$L408:
	lw	$4,2168($18)
	lw	$2,64($19)
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L409
	sw	$2,2148($18)
	.set	macro
	.set	reorder

	lw	$2,2156($4)
	#nop
	sw	$2,56($19)
	lw	$2,2160($4)
	#nop
	sw	$2,136($19)
	lw	$2,64($19)
	lw	$3,2148($4)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,1
	sw	$2,64($19)
	lw	$3,2164($4)
	j	$L410
$L409:
	lw	$2,2156($18)
	#nop
	sw	$2,56($19)
	lw	$5,2160($18)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	ClearOTagR
	sw	$5,136($19)
	.set	macro
	.set	reorder

	sw	$0,64($19)
	lw	$3,2164($18)
$L410:
	lw	$2,64($19)
	#nop
	sll	$2,$2,2
	sw	$2,64($19)
	addu	$2,$2,$3
	subu	$2,$2,$16
	sw	$2,2152($18)
	lw	$2,136($19)
	#nop
	addu	$2,$2,-1
	sw	$2,136($19)
	lw	$2,2116($18)
	lw	$3,CarIO_carPixMap
	sll	$2,$2,4
	addu	$3,$3,$2
	sw	$3,96($19)
	lbu	$2,2248($18)
	#nop
	sb	$2,1006($19)
	lbu	$2,2250($18)
	#nop
	sb	$2,1007($19)
	lbu	$2,2252($18)
	#nop
	sb	$2,1014($19)
	lbu	$2,2254($18)
	#nop
	sb	$2,1015($19)
	lbu	$2,2253($18)
	li	$4,50			# 0x00000032
	sb	$2,1022($19)
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lbu	$3,2255($18)
	addu	$2,$2,100
	sb	$3,1023($19)
$L411:
	sh	$0,0($2)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L411
	addu	$2,$2,-2
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L462
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,536($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L416
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L501
	ori	$3,$3,0x0001
	.set	macro
	.set	reorder

$L416:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L417
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0002
	ori	$3,$3,0x0002
$L501:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L417:
	lw	$3,544($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L419
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	j	$L502
	ori	$3,$3,0x0100
	.set	macro
	.set	reorder

$L419:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L420
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0200
	ori	$3,$3,0x0200
$L502:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L420:
	lw	$3,548($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L422
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L503
	ori	$2,$2,0x0400
	.set	macro
	.set	reorder

$L422:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L423
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0800
$L503:
	sh	$2,4($3)
$L423:
	lw	$3,552($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L425
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0100
	.set	noreorder
	.set	nomacro
	j	$L504
	ori	$4,$4,0x1000
	.set	macro
	.set	reorder

$L425:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L426
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0200
	ori	$4,$4,0x2000
$L504:
	sh	$3,2($2)
	sh	$4,4($2)
$L426:
	lw	$3,560($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L428
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0001
	.set	noreorder
	.set	nomacro
	j	$L505
	ori	$4,$4,0x0010
	.set	macro
	.set	reorder

$L428:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L429
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0002
	ori	$4,$4,0x0020
$L505:
	sh	$3,2($2)
	sh	$4,4($2)
$L429:
	lw	$3,564($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L431
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L506
	ori	$2,$2,0x0004
	.set	macro
	.set	reorder

$L431:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L432
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0008
$L506:
	sh	$2,4($3)
$L432:
	lw	$3,568($18)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L434
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,8($3)
	#nop
	ori	$2,$2,0x0101
	sh	$2,8($3)
$L434:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L435
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L508
	andi	$2,$4,0x0100
	.set	macro
	.set	reorder

	lhu	$2,48($5)
	lhu	$3,50($5)
	ori	$2,$2,0x0081
	ori	$3,$3,0x0081
	sh	$2,48($5)
	sh	$3,50($5)
	andi	$2,$4,0x0100
$L508:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L435
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L435:
	lbu	$2,1090($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L438
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($3)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L509
	andi	$2,$4,0x0100
	.set	macro
	.set	reorder

	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($3)
	andi	$2,$4,0x0100
$L509:
	bne	$2,$0,$L438
	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($3)
$L438:
	lhu	$3,2228($18)
	#nop
	andi	$2,$3,0x0011
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L441
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L443
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L442
$L443:
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,58($3)
$L442:
	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L510
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	bne	$2,$0,$L441
$L510:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
$L441:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L446
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L511
	andi	$2,$4,0x0100
	.set	macro
	.set	reorder

	lhu	$2,48($5)
	lhu	$3,50($5)
	ori	$2,$2,0x0080
	ori	$3,$3,0x0080
	sh	$2,48($5)
	sh	$3,50($5)
	andi	$2,$4,0x0100
$L511:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L446
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L446:
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L512
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lw	$5,12($19)
	#nop
	sll	$2,$5,1
	addu	$4,$18,$2
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L450
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0040
	sh	$2,56($3)
$L450:
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L451
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L452
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,54($3)
$L452:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L451
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,56($3)
$L451:
	xori	$5,$5,0x0001
	sll	$2,$5,1
	addu	$4,$18,$2
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L454
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x4000
	sh	$2,56($3)
$L454:
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L455
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L456
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,54($3)
$L456:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L513
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,56($3)
$L455:
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L513:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$2,0($2)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L514
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$4,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,56($4)
	#nop
	andi	$2,$3,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L515
	andi	$2,$3,0x4000
	.set	macro
	.set	reorder

	lbu	$2,48($4)
	#nop
	or	$2,$3,$2
	sh	$2,56($4)
	lhu	$3,56($4)
	#nop
	andi	$2,$3,0x4000
$L515:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L514
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,48($4)
	#nop
	andi	$2,$2,0xff00
	or	$2,$3,$2
	sh	$2,56($4)
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L514:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$3,0($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L462
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,56($2)
	lh	$4,48($2)
	sh	$3,48($2)
	sh	$4,56($2)
$L462:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L465
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

$L512:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$6,54($5)
	lhu	$4,56($5)
	lh	$3,8($5)
	ori	$2,$6,0x0002
	sh	$2,54($5)
	ori	$2,$4,0x0200
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L466
	sh	$2,56($5)
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_SirenFlash) # high
	lhu	$3,2232($18)
	addiu	$7,$2,%lo(DrawC_SirenFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$7
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L467
	ori	$2,$6,0x0083
	.set	macro
	.set	reorder

	sh	$2,54($5)
	ori	$2,$4,0x0281
	sh	$2,56($5)
$L467:
	lhu	$2,2234($18)
	#nop
	andi	$2,$2,0x000f
	sll	$2,$2,1
	addu	$2,$2,$7
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L466
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,54($5)
	lhu	$4,56($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,54($5)
	sh	$4,56($5)
$L466:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L516
	lui	$6,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lw	$2,1392($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L517
	addu	$4,$sp,24
	.set	macro
	.set	reorder

$L516:
	addiu	$4,$6,%lo(DrawC_gOverlay) # low
	lhu	$2,58($4)
	#nop
	andi	$5,$2,0x7e7e
	sh	$5,58($4)
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L518
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	lhu	$2,48($4)
	lhu	$3,50($4)
	andi	$2,$2,0x7f7f
	andi	$3,$3,0x7f7f
	sh	$2,48($4)
	sh	$3,50($4)
	lui	$2,%hi(DrawC_HeadLightFlash) # high
$L518:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L519
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L520
	ori	$2,$5,0x0081
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($6)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L519
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	ori	$2,$5,0x0081
$L520:
	sh	$2,58($4)
	lui	$2,%hi(DrawC_HeadLightFlash) # high
$L519:
	lhu	$3,2234($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L521
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L522
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L521
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(DrawC_gOverlay) # high
$L522:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
	lui	$2,%hi(DrawC_gOverlay) # high
$L521:
	addiu	$4,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L523
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_TailLightFlash) # high
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_TailLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L524
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	lhu	$2,48($4)
	lhu	$3,50($4)
	ori	$2,$2,0x0080
	ori	$3,$3,0x0080
	sh	$2,48($4)
	sh	$3,50($4)
	lui	$2,%hi(DrawC_HeadLightFlash) # high
$L524:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L523
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,52($4)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($4)
	lui	$2,%hi(DrawC_gOverlay) # high
$L523:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($5)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L517
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_TailLightFlash) # high
	lhu	$3,2234($18)
	addiu	$2,$2,%lo(DrawC_TailLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L480
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L480:
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	lhu	$3,2234($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L517
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lhu	$2,52($5)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($5)
$L465:
	addu	$4,$sp,24
$L517:
	lui	$16,%hi(DrawC_gMatA) # high
	addiu	$16,$16,%lo(DrawC_gMatA) # low
	lhu	$2,R3DCar_yawCam
	move	$5,$16
	sh	$0,24($sp)
	sh	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	RotMatrix
	sh	$2,26($sp)
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	sw	$0,28($16)
	sw	$0,24($16)
	sw	$0,20($16)
	sw	$0,DrawC_gWetRoad
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L482
	lui	$2,%hi(gCView) # high
	.set	macro
	.set	reorder

	li	$22,3			# 0x00000003
	lw	$4,%lo(gCView)($2)
	lw	$5,gFlip
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	li	$21,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$20,$2
	lh	$3,202($18)
	lb	$16,124($18)
	lh	$5,204($18)
	sll	$4,$3,1
	addu	$4,$4,$3
	lw	$3,DrawC_gEnvMap
	sll	$4,$4,1
	addu	$4,$4,$3
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,1
	lhu	$6,2($4)
	lw	$5,DrawC_gShadow
	lhu	$4,4($4)
	addu	$3,$3,$5
	andi	$2,$4,0x00ff
	slt	$2,$16,$2
	lhu	$5,2($3)
	lhu	$3,4($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L483
	sll	$2,$4,16
	.set	macro
	.set	reorder

	sra	$6,$2,24
$L483:
	andi	$2,$3,0x00ff
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L484
	sll	$2,$3,16
	.set	macro
	.set	reorder

	sra	$5,$2,24
$L484:
	sll	$2,$6,16
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L525
	sll	$2,$5,16
	.set	macro
	.set	reorder

	addu	$6,$6,-10
	li	$23,1			# 0x00000001
$L525:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L526
	sll	$2,$5,16
	.set	macro
	.set	reorder

	move	$22,$0
	subu	$5,$0,$5
	sll	$2,$5,16
$L526:
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L527
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	addu	$5,$5,-10
	li	$21,1			# 0x00000001
$L527:
	sll	$2,$2,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$16,$L488
	lui	$3,%hi(Track_gReflectionMaps) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L489
	sw	$0,100($19)
	.set	macro
	.set	reorder

$L488:
	addiu	$3,$3,%lo(Track_gReflectionMaps) # low
	sll	$2,$16,4
	addu	$2,$2,$3
	lwl	$10,3($2)
	lwr	$10,0($2)
	lwl	$11,7($2)
	lwr	$11,4($2)
	lwl	$8,11($2)
	lwr	$8,8($2)
	lwl	$9,15($2)
	lwr	$9,12($2)
	swl	$10,103($19)
	swr	$10,100($19)
	swl	$11,107($19)
	swr	$11,104($19)
	swl	$8,111($19)
	swr	$8,108($19)
	swl	$9,115($19)
	swr	$9,112($19)
$L489:
	addu	$2,$5,-1
	sll	$2,$2,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$16,$L490
	addu	$4,$19,72
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L491
	sw	$0,116($19)
	.set	macro
	.set	reorder

$L490:
	sll	$16,$16,4
	lui	$2,%hi(Track_gReflectionMaps) # high
	addiu	$2,$2,%lo(Track_gReflectionMaps) # low
	addu	$16,$16,$2
	lbu	$3,0($16)
	li	$2,128			# 0x00000080
	sh	$2,28($sp)
	li	$2,64			# 0x00000040
	sh	$2,30($sp)
	sh	$3,24($sp)
	lbu	$2,1($16)
	move	$6,$0
	sh	$2,26($sp)
	lbu	$5,23($20)
	lhu	$7,6($16)
	addu	$17,$sp,24
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$19,84
	sh	$0,30($sp)
	sh	$0,28($sp)
	sh	$0,26($sp)
	sh	$0,24($sp)
	lbu	$5,23($20)
	lhu	$7,20($20)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$19,122
	lwl	$10,3($16)
	lwr	$10,0($16)
	lwl	$11,7($16)
	lwr	$11,4($16)
	lwl	$8,11($16)
	lwr	$8,8($16)
	lwl	$9,15($16)
	lwr	$9,12($16)
	swl	$10,119($19)
	swr	$10,116($19)
	swl	$11,123($19)
	swr	$11,120($19)
	swl	$8,127($19)
	swr	$8,124($19)
	swl	$9,131($19)
	swr	$9,128($19)
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	move	$5,$21
	.set	macro
	.set	reorder

$L491:
	addu	$2,$22,3
	lh	$3,200($18)
	lui	$4,%hi(DrawC_gEnvMapOffset) # high
	sra	$3,$3,$2
	lbu	$2,117($19)
	addiu	$4,$4,%lo(DrawC_gEnvMapOffset) # low
	srl	$2,$2,6
	sll	$2,$2,1
	addu	$2,$2,$4
	lh	$2,0($2)
	andi	$3,$3,0x003f
	addu	$3,$3,$2
	lui	$2,%hi(GameSetup_gData+72) # high
	sw	$3,132($19)
	lw	$2,%lo(GameSetup_gData+72)($2)
	#nop
	beq	$2,$0,$L492
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L492
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$3,448($18)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$3,0($3)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L492
	sw	$3,DrawC_gWetRoad
$L492:
	lw	$2,312($18)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	lw	$2,392($18)
	sra	$3,$3,1
	addu	$3,$3,$2
	sra	$3,$3,8
	sh	$3,DrawC_gReflectOffset
	.set	noreorder
	.set	nomacro
	j	$L507
	addu	$4,$19,106
	.set	macro
	.set	reorder

$L482:
	lw	$4,%lo(gCView)($2)
	lw	$5,gFlip
	jal	Draw_GetDRAWENV__Fii
	addu	$4,$19,72
	move	$16,$2
	lbu	$5,23($16)
	lhu	$7,20($16)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$19,84
	lbu	$5,23($16)
	lhu	$7,20($16)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuPixmap) # high
	lw	$2,%lo(gMenuPixmap)($2)
	#nop
	lwl	$10,3($2)
	lwr	$10,0($2)
	lwl	$11,7($2)
	lwr	$11,4($2)
	lwl	$8,11($2)
	lwr	$8,8($2)
	lwl	$9,15($2)
	lwr	$9,12($2)
	swl	$10,103($19)
	swr	$10,100($19)
	swl	$11,107($19)
	swr	$11,104($19)
	swl	$8,111($19)
	swr	$8,108($19)
	swl	$9,115($19)
	swr	$9,112($19)
	addu	$4,$19,106
$L507:
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L494
	sra	$6,$fp,1
	.set	macro
	.set	reorder

	lbu	$3,R3DCar_eMapColour
	sra	$2,$fp,2
	mult	$2,$3
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L495
	sra	$6,$8,7
	.set	macro
	.set	reorder

	li	$3,1431633920			# 0x55550000
	ori	$3,$3,0x5556
	sll	$2,$6,1
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$6,$8,$2
$L495:
	sll	$2,$6,1
	addu	$2,$2,$6
	sra	$2,$2,2
	sll	$3,$2,16
	sll	$4,$2,8
	addu	$3,$3,$4
	addu	$3,$3,$2
	sw	$3,152($19)
$L494:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,144($19)
	lh	$3,2236($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L497
	sll	$2,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L498
	sra	$6,$6,2
	.set	macro
	.set	reorder

$L497:
	addu	$2,$2,$6
	sra	$6,$2,2
$L498:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,148($19)
	lw	$2,2148($18)
$L500:
	lw	$31,68($sp)
	lw	$fp,64($sp)
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

	.end	DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
	.text
	.ent	DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,2172($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L536
	move	$9,$5
	.set	macro
	.set	reorder

	lw	$5,2168($4)
	#nop
	beq	$5,$0,$L530
	lh	$2,2172($5)
	lhu	$3,2172($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L531
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sh	$2,2172($5)
	sll	$2,$2,16
	bne	$2,$0,$L536
$L531:
	lw	$2,2160($5)
	lw	$4,2148($5)
	.set	noreorder
	.set	nomacro
	j	$L535
	addu	$8,$2,-1
	.set	macro
	.set	reorder

$L530:
	lw	$2,2160($4)
	lw	$4,2148($4)
	addu	$8,$2,-1
$L535:
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	sll	$5,$4,2
	li	$7,-16777216			# 0xff000000
	lw	$2,0($9)
	lw	$4,56($9)
	addu	$2,$5,$2
	lw	$3,0($4)
	lw	$2,0($2)
	and	$3,$3,$7
	and	$2,$2,$6
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($9)
	sll	$3,$8,2
	addu	$5,$5,$2
	lw	$4,0($5)
	lw	$2,56($9)
	and	$4,$4,$7
	addu	$2,$2,$3
	and	$2,$2,$6
	or	$4,$4,$2
	sw	$4,0($5)
$L536:
	j	$31
	.end	DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
	.text
	.ent	DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	lw	$17,76($sp)
	sw	$18,24($sp)
	lw	$18,72($sp)
	sw	$16,16($sp)
	move	$16,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$22,40($sp)
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$19,28($sp)
	lw	$2,100($17)
	lw	$19,20($21)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L538
	move	$22,$7
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L655
	andi	$2,$18,0x0001
	.set	macro
	.set	reorder

	andi	$18,$18,0x00be
$L538:
	andi	$2,$18,0x0001
$L655:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L539
	move	$7,$19
	.set	macro
	.set	reorder

	lui	$23,%hi(DrawC_gMatA) # high
	addiu	$23,$23,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 0($23)
	lw   $13, 4($23)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($23)
	lw   $13, 12($23)
	lw   $14, 16($23)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$23,%hi(DrawC_gMatA) # high
	addiu	$23,$23,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 20($23)
	lw   $13, 24($23)
	ctc2 $12, $5
	lw   $14, 28($23)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lhu	$8,0($21)
	addu	$6,$17,215
	addu	$5,$19,4
	li	$11,-1			# 0xffffffff
	addu	$10,$17,172
	addu	$9,$17,156
$L542:
	addu	$8,$8,-1
	beq	$8,$11,$L539
	lhu	$2,0($7)
	lhu	$3,-2($5)
	lhu	$4,0($5)
	sh	$2,172($17)
	sh	$3,174($17)
	sh	$4,176($17)
 #APP
	lwc2 $0, 0($10)
	lwc2 $1, 4($10)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($9)
	swc2 $26, 4($9)
	swc2 $27, 8($9)
 #NO_APP
	lw	$2,164($17)
	lw	$3,156($17)
	bgez	$2,$L544
	subu	$2,$0,$2
$L544:
	addu	$5,$5,6
	addu	$7,$7,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L542
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L539:
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$3,12($16)
	lw	$4,24($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($17)
	sh	$3,22($17)
	sh	$4,24($17)
	lw	$2,4($16)
	lw	$3,16($16)
	lw	$4,28($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($17)
	sh	$3,28($17)
	sh	$4,30($17)
	lw	$3,8($16)
	lw	$4,20($16)
	lw	$5,32($16)
	subu	$2,$0,$2
	sh	$2,26($17)
	lhu	$2,28($17)
	sra	$3,$3,4
	sra	$4,$4,4
	sra	$5,$5,4
	sh	$3,32($17)
	lhu	$3,30($17)
	subu	$2,$0,$2
	sh	$4,34($17)
	sh	$5,36($17)
	sh	$2,28($17)
	subu	$3,$0,$3
	sh	$3,30($17)
	lw	$2,0($20)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($17)
	lw	$2,4($20)
	#nop
	sra	$2,$2,$3
	subu	$2,$0,$2
	sw	$2,44($17)
	lw	$2,8($20)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($17)
	.set	macro
	.set	reorder

	addu	$2,$17,20
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	addu	$9,$17,208
	addu	$5,$17,212
	li	$10,-1			# 0xffffffff
	lw	$6,16($21)
	lhu	$8,0($21)
	addu	$7,$6,4
$L548:
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	beq	$8,$10,$L547
	andi	$3,$18,0x0009
	.set	macro
	.set	reorder

	lhu	$2,-2($7)
	lhu	$4,0($7)
	addu	$7,$7,6
	lhu	$3,0($6)
	addu	$6,$6,6
	sh	$3,0($9)
	sh	$2,-2($5)
	sh	$4,0($5)
	addu	$5,$5,8
	.set	noreorder
	.set	nomacro
	j	$L548
	addu	$9,$9,8
	.set	macro
	.set	reorder

$L547:
	lhu	$11,2($21)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L578
	slt	$2,$3,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L651
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L552
	andi	$2,$18,0x0002
	.set	macro
	.set	reorder

	j	$L537
$L651:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L590
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L618
	sll	$2,$11,1
	.set	macro
	.set	reorder

	j	$L537
$L552:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L553
	sll	$2,$11,1
	.set	macro
	.set	reorder

	addu	$2,$2,$11
	sll	$18,$2,2
$L554:
	addu	$11,$11,-1
$L656:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$11,$2,$L537
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$7,$2,$18
	lbu	$4,3($7)
	lbu	$6,4($7)
	lw	$2,4($17)
	lbu	$5,5($7)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L656
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	sll	$2,$4,3
	addu	$4,$2,$17
	sll	$2,$6,3
	addu	$6,$2,$17
	sll	$2,$5,3
	addu	$5,$2,$17
 #APP
	lwc2 $0, 208($4)
	lwc2 $1, 212($4)
	lwc2 $2, 208($6)
	lwc2 $3, 212($6)
	lwc2 $4, 208($5)
	lwc2 $5, 212($5)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L559
	subu	$3,$0,$3
$L559:
	.set	noreorder
	.set	nomacro
	blez	$3,$L656
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L554
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	lw	$5,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$5,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$5,8
	sw	$t6,0($5)
	swl	$t4,2($t5)
	swc2 $12, 8($5)
	swc2 $13, 16($5)
	swc2 $14, 24($5)
 #NO_APP
	lw	$2,140($17)
	#nop
	sw	$2,4($5)
	li	$2,36			# 0x00000024
	sb	$2,7($5)
	lbu	$2,2($7)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,14($3)
	#nop
	andi	$2,$4,0x007f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L563
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$6,1014($17)
	lbu	$8,1015($17)
	beq	$2,$0,$L564
	lbu	$6,1022($17)
	lbu	$8,1023($17)
$L564:
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($5)
	sh	$3,22($5)
	lbu	$2,6($7)
	lbu	$3,8($7)
	lbu	$4,10($7)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,12($5)
	sb	$3,20($5)
	sb	$4,28($5)
	lbu	$2,7($7)
	lbu	$3,9($7)
	lbu	$4,11($7)
	addu	$2,$2,$8
	addu	$3,$3,$8
	addu	$4,$4,$8
	sb	$2,13($5)
	sb	$3,21($5)
	.set	noreorder
	.set	nomacro
	j	$L554
	sb	$4,29($5)
	.set	macro
	.set	reorder

$L563:
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($5)
	sh	$3,22($5)
	lhu	$2,6($7)
	lhu	$3,8($7)
	lhu	$4,10($7)
	sh	$2,12($5)
	sh	$3,20($5)
	.set	noreorder
	.set	nomacro
	j	$L554
	sh	$4,28($5)
	.set	macro
	.set	reorder

$L553:
	addu	$2,$2,$11
	sll	$18,$2,2
$L566:
	addu	$11,$11,-1
$L657:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$11,$2,$L537
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$18
	lbu	$4,3($8)
	lbu	$6,4($8)
	lw	$2,4($17)
	lbu	$5,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L657
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	sll	$2,$4,3
	addu	$4,$2,$17
	sll	$2,$6,3
	addu	$6,$2,$17
	sll	$2,$5,3
	addu	$5,$2,$17
 #APP
	lwc2 $0, 208($4)
	lwc2 $1, 212($4)
	lwc2 $2, 208($6)
	lwc2 $3, 212($6)
	lwc2 $4, 208($5)
	lwc2 $5, 212($5)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L571
	subu	$3,$0,$3
$L571:
	.set	noreorder
	.set	nomacro
	blez	$3,$L657
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L566
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L657
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	lhu	$2,0($8)
	lw	$3,140($17)
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L575
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$4,38			# 0x00000026
$L575:
	sw	$3,4($7)
	sb	$4,7($7)
	lhu	$2,0($8)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L576
	lbu	$2,2($8)
	lw	$3,96($17)
	lbu	$5,1006($17)
	lbu	$6,1007($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,2($3)
	lhu	$2,6($3)
	sh	$4,14($7)
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L566
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L576:
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L566
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L578:
	sll	$2,$11,1
	addu	$2,$2,$11
	sll	$18,$2,2
	li	$20,38			# 0x00000026
$L579:
	addu	$11,$11,-1
$L658:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$11,$2,$L537
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$7,$2,$18
	lbu	$8,3($7)
	lbu	$9,4($7)
	lw	$2,4($17)
	lbu	$10,5($7)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	sll	$2,$8,3
	addu	$8,$2,$17
	sll	$2,$9,3
	addu	$9,$2,$17
	sll	$2,$10,3
	addu	$10,$2,$17
 #APP
	lwc2 $0, 208($8)
	lwc2 $1, 212($8)
	lwc2 $2, 208($9)
	lwc2 $3, 212($9)
	lwc2 $4, 208($10)
	lwc2 $5, 212($10)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L584
	subu	$3,$0,$3
$L584:
	.set	noreorder
	.set	nomacro
	blez	$3,$L658
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L579
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	lhu	$2,0($7)
	#nop
	andi	$2,$2,0x03f3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L588
	addu	$11,$11,1
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	beq	$2,$0,$L588
	lbu	$3,3($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,172($17)
	sh	$4,174($17)
	sh	$2,176($17)
	lbu	$3,4($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,180($17)
	sh	$4,182($17)
	sh	$2,184($17)
	lbu	$3,5($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,188($17)
	sh	$4,190($17)
	sh	$2,192($17)
 #APP
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,84($17)
	lw	$t7,88($17)
	lw	$s0,92($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,72($17)
	lw	$t7,76($17)
	lw	$s0,80($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,144($17)
	#nop
	sw	$2,4($6)
	sb	$20,7($6)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($6)
	sh	$3,22($6)
	lbu	$3,116($17)
	lbu	$5,117($17)
	lbu	$2,174($17)
	lbu	$4,132($17)
	addu	$3,$3,64
	addu	$2,$2,$3
	sb	$2,12($6)
	lbu	$2,176($17)
	addu	$5,$5,$4
	addu	$2,$2,$5
	sb	$2,13($6)
	lbu	$2,182($17)
	#nop
	addu	$2,$2,$3
	sb	$2,20($6)
	lbu	$2,184($17)
	#nop
	addu	$2,$2,$5
	sb	$2,21($6)
	lbu	$2,190($17)
	#nop
	addu	$2,$2,$3
	sb	$2,28($6)
	lbu	$2,192($17)
	#nop
	addu	$2,$2,$5
	sb	$2,29($6)
$L588:
	lw	$2,100($17)
	#nop
	beq	$2,$0,$L589
 #APP
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,144($17)
	#nop
	sw	$2,4($6)
	sb	$20,7($6)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($6)
	sh	$3,22($6)
	lbu	$4,100($17)
	lbu	$5,101($17)
	lbu	$2,214($8)
	lbu	$3,215($8)
	addu	$4,$4,64
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,12($6)
	sb	$3,13($6)
	lbu	$2,214($9)
	lbu	$3,215($9)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,20($6)
	sb	$3,21($6)
	lbu	$2,214($10)
	lbu	$3,215($10)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,28($6)
	sb	$3,29($6)
$L589:
 #APP
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,140($17)
	#nop
	sw	$2,4($6)
	li	$2,36			# 0x00000024
	sb	$2,7($6)
	lbu	$2,2($7)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($6)
	sh	$3,22($6)
	lhu	$2,6($7)
	lhu	$3,8($7)
	lhu	$4,10($7)
	sh	$2,12($6)
	sh	$3,20($6)
	.set	noreorder
	.set	nomacro
	j	$L579
	sh	$4,28($6)
	.set	macro
	.set	reorder

$L590:
	sll	$2,$11,1
	addu	$2,$2,$11
	sll	$18,$2,2
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$10,$2,%lo(DrawC_gOverlay) # low
$L591:
	addu	$11,$11,-1
$L659:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$11,$2,$L537
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$18
	lbu	$4,3($8)
	lbu	$6,4($8)
	lw	$2,4($17)
	lbu	$5,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	sll	$2,$4,3
	addu	$4,$2,$17
	sll	$2,$6,3
	addu	$6,$2,$17
	sll	$2,$5,3
	addu	$5,$2,$17
 #APP
	lwc2 $0, 208($4)
	lwc2 $1, 212($4)
	lwc2 $2, 208($6)
	lwc2 $3, 212($6)
	lwc2 $4, 208($5)
	lwc2 $5, 212($5)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L596
	subu	$3,$0,$3
$L596:
	.set	noreorder
	.set	nomacro
	blez	$3,$L659
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$10
	lh	$2,0($2)
	#nop
	sll	$6,$2,16
	sra	$5,$6,16
	beq	$5,$0,$L598
	lw	$3,60($17)
	lh	$2,0($8)
	lhu	$4,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L599
	andi	$5,$5,0x00ff
	.set	macro
	.set	reorder

	sra	$5,$6,24
$L599:
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	andi	$2,$5,0x0040
	beq	$2,$0,$L600
	addu	$3,$3,-2
$L600:
	.set	noreorder
	.set	nomacro
	bltz	$3,$L659
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	andi	$2,$4,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	andi	$9,$4,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$5,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L603
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L603
$L607:
	sra	$5,$5,2
	andi	$2,$5,0x0003
	beq	$2,$0,$L607
$L603:
	.set	noreorder
	.set	nomacro
	j	$L609
	sw	$3,60($17)
	.set	macro
	.set	reorder

$L598:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L591
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L609:
	andi	$4,$5,0x0003
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L612
	addu	$4,$4,-1
	.set	macro
	.set	reorder

	sll	$4,$4,2
	lbu	$3,2($8)
	lw	$7,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$22,$2
	addu	$6,$2,$4
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	andi	$2,$5,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	li	$3,36			# 0x00000024
	.set	macro
	.set	reorder

	lw	$4,140($17)
$L613:
	andi	$2,$9,0x0001
	beq	$2,$0,$L614
	li	$3,38			# 0x00000026
$L614:
	sw	$4,4($7)
	sb	$3,7($7)
	lbu	$3,2($8)
	lh	$2,0($6)
	lbu	$5,2($6)
	lbu	$6,3($6)
	addu	$3,$3,$2
	lw	$2,96($17)
	sll	$3,$3,4
	addu	$2,$2,$3
	lhu	$3,2($2)
	lhu	$2,6($2)
	sh	$3,14($7)
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L591
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L612:
	lw	$7,4($17)
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	andi	$2,$5,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	li	$3,36			# 0x00000024
	.set	macro
	.set	reorder

	lw	$4,140($17)
$L616:
	andi	$2,$9,0x0001
	beq	$2,$0,$L617
	li	$3,38			# 0x00000026
$L617:
	sw	$4,4($7)
	sb	$3,7($7)
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L591
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L618:
	addu	$2,$2,$11
	sll	$18,$2,2
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$20,$2,%lo(DrawC_gOverlay) # low
$L619:
	addu	$11,$11,-1
$L660:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$11,$2,$L537
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$18
	lbu	$10,3($8)
	lbu	$24,4($8)
	lw	$2,4($17)
	lbu	$25,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	sll	$2,$10,3
	addu	$10,$2,$17
	sll	$2,$24,3
	addu	$24,$2,$17
	sll	$2,$25,3
	addu	$25,$2,$17
 #APP
	lwc2 $0, 208($10)
	lwc2 $1, 212($10)
	lwc2 $2, 208($24)
	lwc2 $3, 212($24)
	lwc2 $4, 208($25)
	lwc2 $5, 212($25)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L624
	subu	$3,$0,$3
$L624:
	.set	noreorder
	.set	nomacro
	blez	$3,$L660
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$20
	lh	$2,0($2)
	#nop
	sll	$5,$2,16
	sra	$6,$5,16
	beq	$6,$0,$L626
	lw	$4,60($17)
	lh	$2,0($8)
	lhu	$3,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L627
	andi	$6,$6,0x00ff
	.set	macro
	.set	reorder

	sra	$6,$5,24
$L627:
	lw	$2,64($17)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L660
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	andi	$2,$3,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	andi	$9,$3,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$6,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L630
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L630
$L634:
	sra	$6,$6,2
	andi	$2,$6,0x0003
	beq	$2,$0,$L634
$L630:
	.set	noreorder
	.set	nomacro
	j	$L636
	sw	$4,60($17)
	.set	macro
	.set	reorder

$L626:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L619
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	addu	$11,$11,-1
	.set	macro
	.set	reorder

	addu	$11,$11,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L636:
	andi	$2,$9,0x03f3
	beq	$2,$0,$L639
	lw	$2,116($17)
	#nop
	beq	$2,$0,$L639
	lbu	$3,3($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,172($17)
	sh	$4,174($17)
	sh	$2,176($17)
	lbu	$3,4($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,180($17)
	sh	$4,182($17)
	sh	$2,184($17)
	lbu	$3,5($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$19,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,188($17)
	sh	$4,190($17)
	sh	$2,192($17)
 #APP
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,84($17)
	lw	$t7,88($17)
	lw	$s0,92($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,72($17)
	lw	$t7,76($17)
	lw	$s0,80($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($7)
	sh	$3,22($7)
	lbu	$3,116($17)
	lbu	$5,117($17)
	lbu	$2,174($17)
	lbu	$4,132($17)
	addu	$3,$3,64
	addu	$2,$2,$3
	sb	$2,12($7)
	lbu	$2,176($17)
	addu	$5,$5,$4
	addu	$2,$2,$5
	sb	$2,13($7)
	lbu	$2,182($17)
	#nop
	addu	$2,$2,$3
	sb	$2,20($7)
	lbu	$2,184($17)
	#nop
	addu	$2,$2,$5
	sb	$2,21($7)
	lbu	$2,190($17)
	#nop
	addu	$2,$2,$3
	sb	$2,28($7)
	lbu	$2,192($17)
	#nop
	addu	$2,$2,$5
	sb	$2,29($7)
$L639:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$6,0x0001
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,152($17)
	.set	noreorder
	.set	nomacro
	j	$L654
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L641:
	andi	$2,$9,0x0004
	beq	$2,$0,$L643
	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L654
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L643:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L654:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
	lbu	$4,100($17)
	lbu	$5,101($17)
	lbu	$2,214($10)
	lbu	$3,215($10)
	addu	$4,$4,64
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,12($7)
	sb	$3,13($7)
	lbu	$2,214($24)
	lbu	$3,215($24)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,20($7)
	sb	$3,21($7)
	lbu	$2,214($25)
	lbu	$3,215($25)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,28($7)
	sb	$3,29($7)
	andi	$2,$6,0x0003
$L661:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	addu	$4,$2,-1
	.set	macro
	.set	reorder

	sll	$4,$4,2
	lbu	$3,2($8)
	lw	$7,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$22,$2
	addu	$6,$2,$4
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$9,0x0001
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$3,140($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L646:
	sw	$3,4($7)
	sb	$5,7($7)
	lbu	$3,2($8)
	lh	$2,0($6)
	lbu	$5,2($6)
	lbu	$6,3($6)
	addu	$3,$3,$2
	lw	$2,96($17)
	sll	$3,$3,4
	addu	$2,$2,$3
	lhu	$3,2($2)
	lhu	$2,6($2)
	sh	$3,14($7)
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L619
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L645:
	lw	$7,4($17)
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$9,0x0001
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$3,140($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L648:
	sw	$3,4($7)
	sb	$5,7($7)
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L619
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L537:
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

	.end	DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.text
	.ent	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$8,28($sp)
	#nop
	lw	$2,4($8)
	lw	$3,8($8)
	lw	$10,24($sp)
	sltu	$2,$2,$3
	beq	$2,$0,$L674
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	lwc2 $2, 0($5)
	lwc2 $3, 4($5)
	lwc2 $4, 0($6)
	lwc2 $5, 4($6)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($8)
 #NO_APP
	lw	$2,12($8)
	lw	$3,68($8)
	beq	$2,$0,$L664
	subu	$3,$0,$3
$L664:
	blez	$3,$L674
 #APP
	swc2 $12, 196($8)
	swc2 $13, 200($8)
	swc2 $14, 204($8)
 #NO_APP
	lh	$3,16($8)
	lh	$2,196($8)
	lh	$9,18($8)
	slt	$2,$3,$2
	beq	$2,$0,$L667
	lh	$2,200($8)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L667
	lh	$2,204($8)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L674
$L667:
	lh	$2,196($8)
	#nop
	bgez	$2,$L668
	lh	$2,200($8)
	#nop
	bgez	$2,$L668
	lh	$2,204($8)
	#nop
	bltz	$2,$L674
$L668:
	lh	$2,198($8)
	#nop
	slt	$2,$9,$2
	beq	$2,$0,$L669
	lh	$2,202($8)
	#nop
	slt	$2,$9,$2
	beq	$2,$0,$L669
	lh	$2,206($8)
	#nop
	slt	$2,$9,$2
	bne	$2,$0,$L674
$L669:
	lh	$2,198($8)
	#nop
	bgez	$2,$L670
	lh	$2,202($8)
	#nop
	bgez	$2,$L670
	lh	$2,206($8)
	#nop
	bltz	$2,$L674
$L670:
	lh	$2,4($4)
	#nop
	bgez	$2,$L671
	lh	$2,4($5)
	#nop
	bgez	$2,$L671
	lh	$2,4($6)
	#nop
	bltz	$2,$L674
$L671:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($8)
 #NO_APP
	lw	$3,60($8)
	lw	$2,64($8)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L674
	sw	$3,60($8)
	.set	macro
	.set	reorder

	lw	$2,136($8)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L674
 #APP
	lw	$3,4($8)
 lw $t4,60($8)
 lw $t5,56($8)
 addiu $t6,$3,32
 sll $t4,$t4,2
 addu $t5,$t5,$t4
 sw $t6,4($8)
 lwl $t6,2($t5)
 lui $t4,0x0700
 srl $t6,$t6,8
 or $t6,$t6,$t4
 sll $t4,$3,8
 sw $t6,0($3)
 swl $t4,2($t5)
 #NO_APP
	lw	$2,196($8)
	lw	$4,200($8)
	lw	$5,204($8)
	sw	$2,8($3)
	sw	$4,16($3)
	sw	$5,24($3)
	lw	$2,140($8)
	#nop
	sw	$2,4($3)
	li	$2,36			# 0x00000024
	sb	$2,7($3)
	lhu	$2,2($10)
	lhu	$4,6($10)
	sh	$2,14($3)
	sh	$4,22($3)
	lw	$2,16($sp)
	#nop
	lhu	$4,0($2)
	lw	$2,20($sp)
	lhu	$5,0($7)
	lhu	$2,0($2)
	sh	$5,12($3)
	sh	$4,20($3)
	sh	$2,28($3)
$L674:
	j	$31
	.end	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	.text
	.ent	DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$17,44($sp)
	lw	$17,100($sp)
	sw	$16,40($sp)
	move	$16,$4
	sw	$18,48($sp)
	move	$18,$5
	sw	$21,60($sp)
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$6,88($sp)
	lw	$2,100($17)
	lw	$20,20($6)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L676
	move	$21,$7
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	bne	$2,$0,$L676
	lw	$25,96($sp)
	#nop
	andi	$25,$25,0x00be
	sw	$25,96($sp)
$L676:
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L677
	move	$8,$20
	.set	macro
	.set	reorder

	lui	$25,%hi(DrawC_gMatA) # high
	addiu	$25,$25,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 0($25)
	lw   $13, 4($25)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($25)
	lw   $13, 12($25)
	lw   $14, 16($25)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$25,%hi(DrawC_gMatA) # high
	addiu	$25,$25,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 20($25)
	lw   $13, 24($25)
	ctc2 $12, $5
	lw   $14, 28($25)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	addu	$6,$17,215
	addu	$5,$20,4
	li	$11,-1			# 0xffffffff
	addu	$10,$17,172
	lw	$25,88($sp)
	addu	$9,$17,156
	lhu	$7,0($25)
$L678:
	addu	$7,$7,-1
	beq	$7,$11,$L677
	lhu	$2,0($8)
	lhu	$3,-2($5)
	lhu	$4,0($5)
	sh	$2,172($17)
	sh	$3,174($17)
	sh	$4,176($17)
 #APP
	lwc2 $0, 0($10)
	lwc2 $1, 4($10)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($9)
	swc2 $26, 4($9)
	swc2 $27, 8($9)
 #NO_APP
	lw	$2,164($17)
	lw	$3,156($17)
	bgez	$2,$L682
	subu	$2,$0,$2
$L682:
	addu	$5,$5,6
	addu	$8,$8,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L678
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L677:
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$3,12($16)
	lw	$4,24($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($17)
	sh	$3,22($17)
	sh	$4,24($17)
	lw	$2,4($16)
	lw	$3,16($16)
	lw	$4,28($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($17)
	sh	$3,28($17)
	sh	$4,30($17)
	lw	$2,8($16)
	lw	$3,20($16)
	lw	$4,32($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,32($17)
	sh	$3,34($17)
	sh	$4,36($17)
	lw	$2,0($18)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($17)
	lw	$2,4($18)
	#nop
	sra	$2,$2,$3
	sw	$2,44($17)
	lw	$2,8($18)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($17)
	.set	macro
	.set	reorder

	addu	$2,$17,20
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	addu	$9,$17,212
	addu	$7,$17,208
	li	$13,-1			# 0xffffffff
	move	$12,$7
	addu	$11,$17,156
	lw	$25,88($sp)
	addu	$6,$17,210
	lw	$8,16($25)
	lhu	$10,0($25)
	addu	$5,$8,4
$L683:
	addu	$10,$10,-1
	.set	noreorder
	.set	nomacro
	beq	$10,$13,$L684
	lui	$25,%hi(DrawC_gScreenMat) # high
	.set	macro
	.set	reorder

	lhu	$2,0($8)
	lhu	$3,-2($5)
	lhu	$4,0($5)
	sh	$2,0($7)
	sh	$3,0($6)
	sh	$4,0($9)
 #APP
	lwc2 $0, 0($12)
	lwc2 $1, 4($12)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($11)
	swc2 $26, 4($11)
	swc2 $27, 8($11)
 #NO_APP
	addu	$5,$5,6
	lw	$3,160($17)
	lw	$4,164($17)
	lhu	$2,156($17)
	addu	$8,$8,6
	sh	$2,0($7)
	sh	$3,0($6)
	addu	$6,$6,8
	sh	$4,0($9)
	addu	$9,$9,8
	.set	noreorder
	.set	nomacro
	j	$L683
	addu	$7,$7,8
	.set	macro
	.set	reorder

$L684:
	addiu	$25,$25,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 0($25)
	lw   $13, 4($25)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($25)
	lw   $13, 12($25)
	lw   $14, 16($25)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$25,%hi(DrawC_gScreenMat) # high
	addiu	$25,$25,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 20($25)
	lw   $13, 24($25)
	ctc2 $12, $5
	lw   $14, 28($25)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lw	$25,88($sp)
	#nop
	lhu	$18,2($25)
	lw	$25,96($sp)
	li	$2,1			# 0x00000001
	andi	$3,$25,0x0009
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L715
	slt	$2,$3,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L806
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L688
	addu	$25,$17,976
	.set	macro
	.set	reorder

	j	$L675
$L806:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L732
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L765
	sll	$2,$18,1
	.set	macro
	.set	reorder

	j	$L675
$L688:
	sw	$25,32($sp)
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0020
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	addu	$fp,$17,992
	.set	macro
	.set	reorder

	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$19,$2,2
$L690:
	addu	$18,$18,-1
$L812:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L675
	addu	$19,$19,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$19
	lbu	$4,3($8)
	lbu	$6,4($8)
	lw	$2,4($17)
	lbu	$5,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$2,$4,3
	addu	$4,$2,$17
	sll	$2,$6,3
	addu	$6,$2,$17
	sll	$2,$5,3
	addu	$5,$2,$17
 #APP
	lwc2 $0, 208($4)
	lwc2 $1, 212($4)
	lwc2 $2, 208($6)
	lwc2 $3, 212($6)
	lwc2 $4, 208($5)
	lwc2 $5, 212($5)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L695
	subu	$3,$0,$3
$L695:
	.set	noreorder
	.set	nomacro
	blez	$3,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$3,212($4)
	lhu	$4,212($6)
	lhu	$5,212($5)
	lh	$6,16($17)
	lh	$2,196($17)
	sh	$3,176($17)
	lh	$3,18($17)
	slt	$2,$6,$2
	sh	$4,184($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	sh	$5,192($17)
	.set	macro
	.set	reorder

	lh	$2,200($17)
	#nop
	slt	$2,$6,$2
	beq	$2,$0,$L697
	lh	$2,204($17)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L697:
	lh	$2,196($17)
	#nop
	bgez	$2,$L698
	lh	$2,200($17)
	#nop
	bgez	$2,$L698
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L698:
	lh	$2,198($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L699
	lh	$2,202($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L699
	lh	$2,206($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L699:
	lh	$2,198($17)
	#nop
	bgez	$2,$L700
	lh	$2,202($17)
	#nop
	bgez	$2,$L700
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L700:
	lh	$2,176($17)
	#nop
	bgez	$2,$L701
	lh	$2,184($17)
	#nop
	bgez	$2,$L701
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L701:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L690
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L812
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$4,200($17)
	lw	$2,204($17)
	lw	$3,196($17)
	sw	$4,16($7)
	sw	$2,24($7)
	sw	$3,8($7)
	lhu	$2,0($8)
	lw	$3,140($17)
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L704
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$4,38			# 0x00000026
$L704:
	sw	$3,4($7)
	sb	$4,7($7)
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0002
	beq	$2,$0,$L705
	lhu	$2,0($8)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L705
	lbu	$2,2($8)
	lw	$3,96($17)
	lbu	$5,1006($17)
	lbu	$6,1007($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,2($3)
	lhu	$2,6($3)
	sh	$4,14($7)
	.set	noreorder
	.set	nomacro
	j	$L808
	sh	$2,22($7)
	.set	macro
	.set	reorder

$L705:
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,14($3)
	#nop
	andi	$2,$4,0x007f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L707
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$5,1014($17)
	lbu	$6,1015($17)
	beq	$2,$0,$L708
	lbu	$5,1022($17)
	lbu	$6,1023($17)
$L708:
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
$L808:
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L690
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L707:
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L690
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L689:
	addu	$23,$17,982
	addu	$22,$17,998
	addu	$21,$17,984
	addu	$20,$17,990
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$19,$2,2
	addu	$18,$18,-1
$L810:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L675
	addu	$19,$19,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$7,24($25)
	#nop
	addu	$7,$7,$19
	lbu	$2,3($7)
	lbu	$3,4($7)
	lbu	$4,5($7)
	lbu	$8,2($7)
	sll	$2,$2,3
	addu	$2,$2,208
	addu	$2,$17,$2
	sll	$3,$3,3
	addu	$3,$3,208
	addu	$3,$17,$3
	sll	$4,$4,3
	lhu	$6,0($2)
	lhu	$5,2($2)
	lhu	$2,4($2)
	addu	$4,$4,208
	sh	$6,172($17)
	sh	$5,174($17)
	sh	$2,176($17)
	lhu	$2,0($3)
	lhu	$5,2($3)
	lhu	$3,4($3)
	addu	$4,$17,$4
	sh	$2,180($17)
	sh	$5,182($17)
	sh	$3,184($17)
	lhu	$5,0($4)
	lhu	$6,2($4)
	lh	$3,172($17)
	lh	$2,180($17)
	lhu	$4,4($4)
	addu	$3,$3,$2
	lh	$2,174($17)
	addu	$3,$3,1
	sh	$4,192($17)
	lh	$4,182($17)
	sra	$3,$3,1
	sh	$3,976($17)
	lh	$3,176($17)
	sh	$5,188($17)
	sh	$6,190($17)
	addu	$2,$2,$4
	addu	$2,$2,1
	lh	$4,184($17)
	sra	$2,$2,1
	sh	$2,978($17)
	lh	$2,180($17)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,188($17)
	sra	$3,$3,1
	sh	$3,980($17)
	lw	$5,96($17)
	addu	$2,$2,$4
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,984($17)
	lh	$2,182($17)
	lh	$3,190($17)
	lh	$4,192($17)
	addu	$2,$2,$3
	addu	$2,$2,1
	lh	$3,184($17)
	sra	$2,$2,1
	sh	$2,986($17)
	lh	$2,188($17)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,172($17)
	sra	$3,$3,1
	sh	$3,988($17)
	lh	$3,190($17)
	addu	$2,$2,$4
	addu	$2,$2,1
	lh	$4,174($17)
	sra	$2,$2,1
	sh	$2,992($17)
	lh	$2,192($17)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,176($17)
	sra	$3,$3,1
	sh	$3,994($17)
	addu	$2,$2,$4
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,996($17)
	lhu	$2,6($7)
	lhu	$3,8($7)
	lhu	$4,10($7)
	sll	$8,$8,4
	sh	$2,178($17)
	sh	$3,186($17)
	sh	$4,194($17)
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L714
	addu	$16,$5,$8
	.set	macro
	.set	reorder

	lbu	$4,1006($17)
	lbu	$5,1007($17)
	lbu	$2,178($17)
	lbu	$3,179($17)
	addu	$2,$2,$4
	sb	$2,178($17)
	lbu	$2,186($17)
	addu	$3,$3,$5
	sb	$3,179($17)
	lbu	$3,187($17)
	addu	$2,$2,$4
	sb	$2,186($17)
	lbu	$2,194($17)
	addu	$3,$3,$5
	sb	$3,187($17)
	lbu	$3,195($17)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,194($17)
	sb	$3,195($17)
$L714:
	addu	$4,$17,172
	move	$6,$fp
	addu	$7,$17,178
	lw	$5,32($sp)
	lbu	$2,178($17)
	lbu	$3,186($17)
	lbu	$8,187($17)
	addu	$2,$2,$3
	addu	$2,$2,1
	lbu	$3,179($17)
	sra	$2,$2,1
	sb	$2,982($17)
	lbu	$2,186($17)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,194($17)
	sra	$3,$3,1
	sb	$3,983($17)
	lbu	$3,187($17)
	addu	$2,$2,$8
	addu	$2,$2,1
	lbu	$8,195($17)
	sra	$2,$2,1
	sb	$2,990($17)
	lbu	$2,178($17)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,194($17)
	sra	$3,$3,1
	sb	$3,991($17)
	lbu	$3,179($17)
	addu	$8,$8,$2
	addu	$8,$8,1
	lbu	$2,195($17)
	sra	$8,$8,1
	sb	$8,998($17)
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sb	$2,999($17)
	sw	$23,16($sp)
	sw	$22,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	addu	$5,$17,180
	move	$6,$21
	move	$7,$23
	lw	$4,32($sp)
	addu	$2,$17,186
	sw	$2,16($sp)
	sw	$20,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$21
	addu	$6,$17,188
	move	$7,$22
	addu	$2,$17,194
	sw	$20,16($sp)
	sw	$2,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$6,$21
	lw	$5,32($sp)
	move	$7,$22
	sw	$23,16($sp)
	sw	$20,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L810
	addu	$18,$18,-1
	.set	macro
	.set	reorder

$L715:
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$19,$2,2
$L716:
	addu	$18,$18,-1
$L813:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L675
	addu	$19,$19,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$7,$2,$19
	lbu	$8,3($7)
	lbu	$9,4($7)
	lw	$2,4($17)
	lbu	$10,5($7)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$2,$8,3
	addu	$8,$2,$17
	sll	$2,$9,3
	addu	$9,$2,$17
	sll	$2,$10,3
	addu	$10,$2,$17
 #APP
	lwc2 $0, 208($8)
	lwc2 $1, 212($8)
	lwc2 $2, 208($9)
	lwc2 $3, 212($9)
	lwc2 $4, 208($10)
	lwc2 $5, 212($10)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L721
	subu	$3,$0,$3
$L721:
	.set	noreorder
	.set	nomacro
	blez	$3,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$3,212($8)
	lhu	$4,212($9)
	lhu	$5,212($10)
	lh	$6,16($17)
	lh	$2,196($17)
	sh	$3,176($17)
	lh	$3,18($17)
	slt	$2,$6,$2
	sh	$4,184($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	sh	$5,192($17)
	.set	macro
	.set	reorder

	lh	$2,200($17)
	#nop
	slt	$2,$6,$2
	beq	$2,$0,$L723
	lh	$2,204($17)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L723:
	lh	$2,196($17)
	#nop
	bgez	$2,$L724
	lh	$2,200($17)
	#nop
	bgez	$2,$L724
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L724:
	lh	$2,198($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L725
	lh	$2,202($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L725
	lh	$2,206($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L725:
	lh	$2,198($17)
	#nop
	bgez	$2,$L726
	lh	$2,202($17)
	#nop
	bgez	$2,$L726
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L726:
	lh	$2,176($17)
	#nop
	bgez	$2,$L727
	lh	$2,184($17)
	#nop
	bgez	$2,$L727
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L727:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L716
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	lhu	$2,0($7)
	#nop
	andi	$2,$2,0x03f3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	beq	$2,$0,$L730
	lbu	$3,3($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,172($17)
	sh	$4,174($17)
	sh	$2,176($17)
	lbu	$3,4($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,180($17)
	sh	$4,182($17)
	sh	$2,184($17)
	lbu	$3,5($7)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,188($17)
	sh	$4,190($17)
	sh	$2,192($17)
 #APP
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,84($17)
	lw	$t7,88($17)
	lw	$s0,92($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,72($17)
	lw	$t7,76($17)
	lw	$s0,80($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,144($17)
	#nop
	sw	$2,4($6)
	li	$2,38			# 0x00000026
	sb	$2,7($6)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($6)
	sh	$3,22($6)
	lbu	$3,116($17)
	lbu	$5,117($17)
	lbu	$2,174($17)
	lbu	$4,132($17)
	addu	$3,$3,64
	addu	$2,$2,$3
	sb	$2,12($6)
	lbu	$2,176($17)
	addu	$5,$5,$4
	addu	$2,$2,$5
	sb	$2,13($6)
	lbu	$2,182($17)
	#nop
	addu	$2,$2,$3
	sb	$2,20($6)
	lbu	$2,184($17)
	#nop
	addu	$2,$2,$5
	sb	$2,21($6)
	lbu	$2,190($17)
	#nop
	addu	$2,$2,$3
	sb	$2,28($6)
	lbu	$2,192($17)
	#nop
	addu	$2,$2,$5
	sb	$2,29($6)
$L730:
	lw	$2,100($17)
	#nop
	beq	$2,$0,$L731
 #APP
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,144($17)
	#nop
	sw	$2,4($6)
	li	$2,38			# 0x00000026
	sb	$2,7($6)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($6)
	sh	$3,22($6)
	lbu	$4,100($17)
	lbu	$5,101($17)
	lbu	$2,214($8)
	lbu	$3,215($8)
	addu	$4,$4,64
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,12($6)
	sb	$3,13($6)
	lbu	$2,214($9)
	lbu	$3,215($9)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,20($6)
	sb	$3,21($6)
	lbu	$2,214($10)
	lbu	$3,215($10)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,28($6)
	sb	$3,29($6)
$L731:
 #APP
	lw	$6,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$6,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$6,8
	sw	$t6,0($6)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($6)
	sw	$3,16($6)
	sw	$4,24($6)
	lw	$2,140($17)
	#nop
	sw	$2,4($6)
	li	$2,36			# 0x00000024
	sb	$2,7($6)
	lbu	$2,2($7)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($6)
	sh	$3,22($6)
	lhu	$2,6($7)
	lhu	$3,8($7)
	lhu	$4,10($7)
	sh	$2,12($6)
	sh	$3,20($6)
	.set	noreorder
	.set	nomacro
	j	$L716
	sh	$4,28($6)
	.set	macro
	.set	reorder

$L732:
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$19,$2,2
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$15,$2,%lo(DrawC_gOverlay) # low
$L733:
	addu	$18,$18,-1
$L814:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L675
	addu	$19,$19,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$19
	lbu	$4,3($8)
	lbu	$6,4($8)
	lw	$2,4($17)
	lbu	$5,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$2,$4,3
	addu	$4,$2,$17
	sll	$2,$6,3
	addu	$6,$2,$17
	sll	$2,$5,3
	addu	$5,$2,$17
 #APP
	lwc2 $0, 208($4)
	lwc2 $1, 212($4)
	lwc2 $2, 208($6)
	lwc2 $3, 212($6)
	lwc2 $4, 208($5)
	lwc2 $5, 212($5)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L738
	subu	$3,$0,$3
$L738:
	.set	noreorder
	.set	nomacro
	blez	$3,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$3,212($4)
	lhu	$4,212($6)
	lhu	$5,212($5)
	lh	$6,16($17)
	lh	$2,196($17)
	sh	$3,176($17)
	lh	$3,18($17)
	slt	$2,$6,$2
	sh	$4,184($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	sh	$5,192($17)
	.set	macro
	.set	reorder

	lh	$2,200($17)
	#nop
	slt	$2,$6,$2
	beq	$2,$0,$L740
	lh	$2,204($17)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L740:
	lh	$2,196($17)
	#nop
	bgez	$2,$L741
	lh	$2,200($17)
	#nop
	bgez	$2,$L741
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L741:
	lh	$2,198($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L742
	lh	$2,202($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L742
	lh	$2,206($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L742:
	lh	$2,198($17)
	#nop
	bgez	$2,$L743
	lh	$2,202($17)
	#nop
	bgez	$2,$L743
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L743:
	lh	$2,176($17)
	#nop
	bgez	$2,$L744
	lh	$2,184($17)
	#nop
	bgez	$2,$L744
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L744:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$15
	lh	$2,0($2)
	#nop
	sll	$6,$2,16
	sra	$5,$6,16
	beq	$5,$0,$L745
	lw	$3,60($17)
	lh	$2,0($8)
	lhu	$4,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L746
	andi	$5,$5,0x00ff
	.set	macro
	.set	reorder

	sra	$5,$6,24
$L746:
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	andi	$2,$5,0x0040
	beq	$2,$0,$L747
	addu	$3,$3,-2
$L747:
	.set	noreorder
	.set	nomacro
	bltz	$3,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	andi	$2,$4,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	andi	$11,$4,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$11,4
	and	$5,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L750
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L750
$L754:
	sra	$5,$5,2
	andi	$2,$5,0x0003
	beq	$2,$0,$L754
$L750:
	.set	noreorder
	.set	nomacro
	j	$L756
	sw	$3,60($17)
	.set	macro
	.set	reorder

$L745:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L733
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lhu	$2,0($8)
	#nop
	andi	$11,$2,0x0fff
$L756:
	andi	$4,$5,0x0003
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L759
	addu	$4,$4,-1
	.set	macro
	.set	reorder

	sll	$4,$4,2
	lbu	$3,2($8)
	lw	$7,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$21,$2
	addu	$9,$2,$4
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	li	$10,8388608			# 0x00800000
	ori	$10,$10,0x8080
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	li	$6,36			# 0x00000024
	sw	$2,8($7)
	andi	$2,$5,0x0080
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$10,140($17)
$L760:
	andi	$2,$11,0x0001
	beq	$2,$0,$L761
	li	$6,38			# 0x00000026
$L761:
	sw	$10,4($7)
	sb	$6,7($7)
	lbu	$3,2($8)
	lh	$2,0($9)
	lbu	$5,2($9)
	lbu	$6,3($9)
	addu	$3,$3,$2
	lw	$2,96($17)
	sll	$3,$3,4
	addu	$2,$2,$3
	lhu	$3,2($2)
	lhu	$2,6($2)
	sh	$3,14($7)
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L733
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L759:
 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	li	$9,8388608			# 0x00800000
	ori	$9,$9,0x8080
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	li	$6,36			# 0x00000024
	sw	$2,8($7)
	andi	$2,$5,0x0080
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L763
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$9,140($17)
$L763:
	andi	$2,$11,0x0001
	beq	$2,$0,$L764
	li	$6,38			# 0x00000026
$L764:
	sw	$9,4($7)
	sb	$6,7($7)
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L733
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L765:
	addu	$2,$2,$18
	sll	$19,$2,2
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$22,$2,%lo(DrawC_gOverlay) # low
$L766:
	addu	$18,$18,-1
$L815:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L675
	addu	$19,$19,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$19
	lbu	$10,3($8)
	lbu	$11,4($8)
	lw	$2,4($17)
	lbu	$24,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$2,$10,3
	addu	$10,$2,$17
	sll	$2,$11,3
	addu	$11,$2,$17
	sll	$2,$24,3
	addu	$24,$2,$17
 #APP
	lwc2 $0, 208($10)
	lwc2 $1, 212($10)
	lwc2 $2, 208($11)
	lwc2 $3, 212($11)
	lwc2 $4, 208($24)
	lwc2 $5, 212($24)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L771
	subu	$3,$0,$3
$L771:
	.set	noreorder
	.set	nomacro
	blez	$3,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$3,212($10)
	lhu	$4,212($11)
	lhu	$5,212($24)
	lh	$6,16($17)
	lh	$2,196($17)
	sh	$3,176($17)
	lh	$3,18($17)
	slt	$2,$6,$2
	sh	$4,184($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L773
	sh	$5,192($17)
	.set	macro
	.set	reorder

	lh	$2,200($17)
	#nop
	slt	$2,$6,$2
	beq	$2,$0,$L773
	lh	$2,204($17)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L773:
	lh	$2,196($17)
	#nop
	bgez	$2,$L774
	lh	$2,200($17)
	#nop
	bgez	$2,$L774
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L774:
	lh	$2,198($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L775
	lh	$2,202($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L775
	lh	$2,206($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L775:
	lh	$2,198($17)
	#nop
	bgez	$2,$L776
	lh	$2,202($17)
	#nop
	bgez	$2,$L776
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L776:
	lh	$2,176($17)
	#nop
	bgez	$2,$L777
	lh	$2,184($17)
	#nop
	bgez	$2,$L777
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L777:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$22
	lh	$2,0($2)
	#nop
	sll	$5,$2,16
	sra	$6,$5,16
	beq	$6,$0,$L778
	lw	$4,60($17)
	lh	$2,0($8)
	lhu	$3,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L779
	andi	$6,$6,0x00ff
	.set	macro
	.set	reorder

	sra	$6,$5,24
$L779:
	lw	$2,64($17)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	andi	$2,$3,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L782
	andi	$9,$3,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$6,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L782
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L782
$L786:
	sra	$6,$6,2
	andi	$2,$6,0x0003
	beq	$2,$0,$L786
$L782:
	.set	noreorder
	.set	nomacro
	j	$L788
	sw	$4,60($17)
	.set	macro
	.set	reorder

$L778:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L766
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L788:
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L791
	andi	$2,$9,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L791:
	andi	$2,$9,0x03f3
	beq	$2,$0,$L793
	lw	$2,116($17)
	#nop
	beq	$2,$0,$L793
	lbu	$3,3($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,172($17)
	sh	$4,174($17)
	sh	$2,176($17)
	lbu	$3,4($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,180($17)
	sh	$4,182($17)
	sh	$2,184($17)
	lbu	$3,5($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$20,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$3,188($17)
	sh	$4,190($17)
	sh	$2,192($17)
 #APP
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,84($17)
	lw	$t7,88($17)
	lw	$s0,92($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,72($17)
	lw	$t7,76($17)
	lw	$s0,80($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($7)
	sh	$3,22($7)
	lbu	$3,116($17)
	lbu	$5,117($17)
	lbu	$2,174($17)
	lbu	$4,132($17)
	addu	$3,$3,64
	addu	$2,$2,$3
	sb	$2,12($7)
	lbu	$2,176($17)
	addu	$5,$5,$4
	addu	$2,$2,$5
	sb	$2,13($7)
	lbu	$2,182($17)
	#nop
	addu	$2,$2,$3
	sb	$2,20($7)
	lbu	$2,184($17)
	#nop
	addu	$2,$2,$5
	sb	$2,21($7)
	lbu	$2,190($17)
	#nop
	addu	$2,$2,$3
	sb	$2,28($7)
	lbu	$2,192($17)
	#nop
	addu	$2,$2,$5
	sb	$2,29($7)
$L793:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$6,0x0001
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,152($17)
	.set	noreorder
	.set	nomacro
	j	$L811
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L795:
	andi	$2,$9,0x0004
	beq	$2,$0,$L797
	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L811
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L797:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L811:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
	lbu	$4,100($17)
	lbu	$5,101($17)
	lbu	$2,214($10)
	lbu	$3,215($10)
	addu	$4,$4,64
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,12($7)
	sb	$3,13($7)
	lbu	$2,214($11)
	lbu	$3,215($11)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,20($7)
	sb	$3,21($7)
	lbu	$2,214($24)
	lbu	$3,215($24)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sb	$2,28($7)
	sb	$3,29($7)
	andi	$2,$6,0x0003
$L816:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L799
	addu	$4,$2,-1
	.set	macro
	.set	reorder

	sll	$4,$4,2
	lbu	$3,2($8)
	lw	$7,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$21,$2
	addu	$6,$2,$4
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$9,0x0001
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$3,140($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L800
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L800:
	sw	$3,4($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	sb	$5,7($7)
	.set	macro
	.set	reorder

	ori	$2,$5,0x0002
	sb	$2,7($7)
$L801:
	lbu	$3,2($8)
	lh	$2,0($6)
	lbu	$5,2($6)
	lbu	$6,3($6)
	addu	$3,$3,$2
	lw	$2,96($17)
	sll	$3,$3,4
	addu	$2,$2,$3
	lhu	$3,2($2)
	lhu	$2,6($2)
	sh	$3,14($7)
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L766
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L799:
 #APP
	lw	$7,4($17)
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$9,0x0001
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$3,140($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L803
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L803:
	sw	$3,4($7)
	sb	$5,7($7)
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L766
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L675:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.text
	.ent	DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	lw	$20,64($sp)
	sw	$17,20($sp)
	lw	$17,68($sp)
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$21,36($sp)
	sw	$31,44($sp)
	sw	$22,40($sp)
	lw	$3,20($19)
	andi	$2,$20,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L818
	move	$21,$7
	.set	macro
	.set	reorder

	lui	$22,%hi(DrawC_gMatA) # high
	addiu	$22,$22,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 0($22)
	lw   $13, 4($22)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($22)
	lw   $13, 12($22)
	lw   $14, 16($22)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$22,%hi(DrawC_gMatA) # high
	addiu	$22,$22,%lo(DrawC_gMatA) # low
 #APP
	lw   $12, 20($22)
	lw   $13, 24($22)
	ctc2 $12, $5
	lw   $14, 28($22)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lhu	$24,0($19)
	move	$7,$3
	addu	$6,$17,215
	li	$10,-1			# 0xffffffff
	addu	$9,$17,172
	addu	$8,$17,156
	addu	$5,$7,4
$L819:
	addu	$24,$24,-1
	beq	$24,$10,$L818
	lhu	$2,0($7)
	lhu	$3,-2($5)
	lhu	$4,0($5)
	sh	$2,172($17)
	sh	$3,174($17)
	sh	$4,176($17)
 #APP
	lwc2 $0, 0($9)
	lwc2 $1, 4($9)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($8)
	swc2 $26, 4($8)
	swc2 $27, 8($8)
 #NO_APP
	lw	$2,164($17)
	lw	$3,156($17)
	bgez	$2,$L823
	subu	$2,$0,$2
$L823:
	addu	$5,$5,6
	addu	$7,$7,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L819
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L818:
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$3,12($16)
	lw	$4,24($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($17)
	sh	$3,22($17)
	sh	$4,24($17)
	lw	$2,4($16)
	lw	$3,16($16)
	lw	$4,28($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($17)
	sh	$3,28($17)
	sh	$4,30($17)
	lw	$3,8($16)
	lw	$4,20($16)
	lw	$5,32($16)
	subu	$2,$0,$2
	sh	$2,26($17)
	lhu	$2,28($17)
	sra	$3,$3,4
	sra	$4,$4,4
	sra	$5,$5,4
	sh	$3,32($17)
	lhu	$3,30($17)
	subu	$2,$0,$2
	sh	$4,34($17)
	sh	$5,36($17)
	sh	$2,28($17)
	subu	$3,$0,$3
	sh	$3,30($17)
	lw	$2,0($18)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($17)
	lw	$2,4($18)
	#nop
	sra	$2,$2,$3
	subu	$2,$0,$2
	sw	$2,44($17)
	lw	$2,8($18)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($17)
	.set	macro
	.set	reorder

	addu	$2,$17,20
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	addu	$8,$17,208
	li	$9,-1			# 0xffffffff
	addu	$6,$17,212
	lw	$7,16($19)
	lhu	$24,0($19)
	addu	$5,$7,4
$L824:
	addu	$24,$24,-1
	.set	noreorder
	.set	nomacro
	beq	$24,$9,$L825
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,-2($5)
	lhu	$4,0($5)
	addu	$5,$5,6
	lhu	$3,0($7)
	addu	$7,$7,6
	sh	$3,0($8)
	sh	$2,-2($6)
	sh	$4,0($6)
	addu	$6,$6,8
	.set	noreorder
	.set	nomacro
	j	$L824
	addu	$8,$8,8
	.set	macro
	.set	reorder

$L825:
	lhu	$24,2($19)
	addiu	$18,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$24,1
	addu	$2,$2,$24
	sll	$25,$2,2
$L828:
	addu	$24,$24,-1
$L860:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$24,$2,$L817
	addu	$25,$25,-12
	.set	macro
	.set	reorder

	lw	$2,24($19)
	lw	$3,8($17)
	addu	$8,$2,$25
	lbu	$5,3($8)
	lbu	$9,4($8)
	lw	$2,4($17)
	lbu	$10,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L860
	addu	$24,$24,-1
	.set	macro
	.set	reorder

	addu	$24,$24,1
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$9,$9,3
	addu	$9,$9,$17
	sll	$10,$10,3
	addu	$10,$10,$17
 #APP
	lwc2 $0, 208($5)
	lwc2 $1, 212($5)
	lwc2 $2, 208($9)
	lwc2 $3, 212($9)
	lwc2 $4, 208($10)
	lwc2 $5, 212($10)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($17)
 #NO_APP
	lw	$2,12($17)
	lw	$3,68($17)
	beq	$2,$0,$L833
	subu	$3,$0,$3
$L833:
	.set	noreorder
	.set	nomacro
	blez	$3,$L860
	addu	$24,$24,-1
	.set	macro
	.set	reorder

	addu	$24,$24,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L828
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L860
	addu	$24,$24,-1
	.set	macro
	.set	reorder

	addu	$24,$24,1
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$18
	lhu	$2,0($2)
	#nop
	sll	$3,$2,16
	lhu	$2,0($8)
	sra	$6,$3,16
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L837
	andi	$11,$2,0x0fff
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L838
	andi	$6,$6,0x003f
	.set	macro
	.set	reorder

	sra	$6,$3,24
$L838:
	andi	$2,$11,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L837
	srl	$2,$11,4
	.set	macro
	.set	reorder

	and	$6,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L837
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L861
	andi	$2,$20,0x0001
	.set	macro
	.set	reorder

$L842:
	sra	$6,$6,2
	andi	$2,$6,0x0003
	beq	$2,$0,$L842
$L837:
	andi	$2,$20,0x0001
$L861:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L862
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,84($17)
	lw	$t7,88($17)
	lw	$s0,92($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$7,4($17)
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
	lw	$t4,4($17)
	lw	$t5,60($17)
	lw	$t6,56($17)
	addiu	$t7,$t4,12
	sll	$t5,$t5,2
	addu	$t6,$t6,$t5
	sw	$t7,4($17)
	lw	$t5,72($17)
	lw	$t7,76($17)
	lw	$s0,80($17)
	sw	$t5,0($t4)
	sw	$t7,4($t4)
	sw	$s0,8($t4)
	lwl	$t5,2($t6)
	sll	$t7,$t4,8
	swl	$t5,2($t4)
	swl	$t7,2($t6)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$11,0x0004
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L846
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L846:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L859:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
	lbu	$2,214($5)
	lbu	$3,100($17)
	lbu	$5,215($5)
	lbu	$4,101($17)
	addu	$3,$3,64
	addu	$2,$2,$3
	sb	$2,12($7)
	addu	$2,$5,$4
	sb	$2,13($7)
	lbu	$2,214($9)
	lbu	$5,215($9)
	addu	$2,$2,$3
	sb	$2,20($7)
	addu	$2,$5,$4
	sb	$2,21($7)
	lbu	$2,214($10)
	lbu	$5,215($10)
	addu	$3,$2,$3
	addu	$4,$5,$4
	sb	$3,28($7)
	sb	$4,29($7)
	andi	$2,$6,0x0003
$L862:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	addu	$4,$2,-1
	.set	macro
	.set	reorder

	lbu	$3,2($8)
	lw	$7,4($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$6,$21,$2
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$11,0x0001
	sw	$3,16($7)
	sw	$4,24($7)
	lw	$3,140($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L849:
	sw	$3,4($7)
	sb	$5,7($7)
	lbu	$3,2($8)
	lh	$2,0($6)
	lbu	$5,2($6)
	lbu	$6,3($6)
	addu	$3,$3,$2
	lw	$2,96($17)
	sll	$3,$3,4
	addu	$2,$2,$3
	lhu	$3,2($2)
	lhu	$2,6($2)
	.set	noreorder
	.set	nomacro
	j	$L858
	sh	$3,14($7)
	.set	macro
	.set	reorder

$L848:
	lw	$7,4($17)
 #APP
	lw	$t4,60($17)
	lw	$t5,56($17)
	addiu	$t6,$7,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4($17)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$7,8
	sw	$t6,0($7)
	swl	$t4,2($t5)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$3,16($7)
	andi	$3,$11,0x0001
	sw	$2,8($7)
	sw	$4,24($7)
	lw	$2,140($17)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L852
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L852:
	sw	$2,4($7)
	andi	$2,$20,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L854
	sb	$5,7($7)
	.set	macro
	.set	reorder

	bne	$3,$0,$L854
	lbu	$2,2($8)
	lw	$3,96($17)
	lbu	$5,1006($17)
	lbu	$6,1007($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,2($3)
	lhu	$2,6($3)
	sh	$4,14($7)
$L858:
	sh	$2,22($7)
	lbu	$2,6($8)
	lbu	$3,8($8)
	lbu	$4,10($8)
	addu	$2,$2,$5
	addu	$3,$3,$5
	addu	$4,$4,$5
	sb	$2,12($7)
	sb	$3,20($7)
	sb	$4,28($7)
	lbu	$2,7($8)
	lbu	$3,9($8)
	lbu	$4,11($8)
	addu	$2,$2,$6
	addu	$3,$3,$6
	addu	$4,$4,$6
	sb	$2,13($7)
	sb	$3,21($7)
	.set	noreorder
	.set	nomacro
	j	$L828
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L854:
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
	lhu	$2,6($8)
	lhu	$3,8($8)
	lhu	$4,10($8)
	sh	$2,12($7)
	sh	$3,20($7)
	.set	noreorder
	.set	nomacro
	j	$L828
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L817:
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

	.end	DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache
	.text
	.ent	DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache:
	.frame	$sp,72,$31		# vars= 0, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,32($sp)
	move	$16,$4
	sw	$17,36($sp)
	move	$17,$5
	sw	$18,40($sp)
	lw	$18,96($sp)
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$6,80($sp)
	sw	$7,84($sp)
	lw	$fp,16($6)
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$3,12($16)
	lw	$4,24($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($18)
	sh	$3,22($18)
	sh	$4,24($18)
	lw	$2,4($16)
	lw	$3,16($16)
	lw	$4,28($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($18)
	sh	$3,28($18)
	sh	$4,30($18)
	lw	$3,8($16)
	lw	$4,20($16)
	lw	$5,32($16)
	subu	$2,$0,$2
	sh	$2,26($18)
	lhu	$2,28($18)
	sra	$3,$3,4
	sra	$4,$4,4
	sra	$5,$5,4
	sh	$3,32($18)
	lhu	$3,30($18)
	subu	$2,$0,$2
	sh	$4,34($18)
	sh	$5,36($18)
	sh	$2,28($18)
	subu	$3,$0,$3
	sh	$3,30($18)
	lw	$2,0($17)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($18)
	lw	$2,4($17)
	#nop
	sra	$2,$2,$3
	subu	$2,$0,$2
	sw	$2,44($18)
	lw	$2,8($17)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($18)
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	lhu	$21,2($8)
	addu	$22,$18,20
	sll	$2,$21,1
	addu	$2,$2,$21
	sll	$23,$2,2
$L864:
	addu	$21,$21,-1
$L885:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$21,$2,$L863
	addu	$23,$23,-12
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	lw	$2,24($8)
	lw	$8,84($sp)
	#nop
	andi	$19,$8,0xffbf
	addu	$17,$2,$23
	lbu	$3,3($17)
	lbu	$5,4($17)
	lbu	$6,5($17)
 #APP
	lw   $12, 0($22)
	lw   $13, 4($22)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($22)
	lw   $13, 12($22)
	lw   $14, 16($22)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($22)
	lw   $13, 24($22)
	ctc2 $12, $5
	lw   $14, 28($22)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$fp,$2
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	#nop
	sh	$2,176($18)
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,1
	addu	$2,$fp,$2
	sh	$3,172($18)
	sh	$4,174($18)
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	#nop
	sh	$2,184($18)
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$2,$2,1
	addu	$2,$fp,$2
	sh	$3,180($18)
	sh	$4,182($18)
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	sh	$4,190($18)
	addu	$4,$18,172
	sh	$3,188($18)
	addu	$3,$18,180
	sh	$2,192($18)
	addu	$2,$18,188
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
	nop
	nop
	.word 0x4B400006
	swc2 $24, 68($18)
 #NO_APP
	lw	$2,12($18)
	lw	$3,68($18)
	beq	$2,$0,$L868
	subu	$3,$0,$3
$L868:
	.set	noreorder
	.set	nomacro
	blez	$3,$L885
	addu	$21,$21,-1
	.set	macro
	.set	reorder

	addu	$21,$21,1
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($18)
 #NO_APP
	lw	$3,60($18)
	lw	$2,64($18)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L864
	sw	$3,60($18)
	.set	macro
	.set	reorder

	lw	$2,136($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L885
	addu	$21,$21,-1
	.set	macro
	.set	reorder

	addu	$21,$21,1
	lw	$8,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$8,$L873
	sll	$2,$8,1
	.set	macro
	.set	reorder

	lui	$8,%hi(DrawC_gOverlay) # high
	addiu	$8,$8,%lo(DrawC_gOverlay) # low
	addu	$2,$2,$8
	lhu	$3,0($2)
	lh	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L874
	sll	$3,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L875
	sra	$3,$3,24
	.set	macro
	.set	reorder

$L874:
	sra	$2,$3,16
	andi	$3,$2,0x00ff
$L875:
	lw	$8,84($sp)
	#nop
	andi	$2,$8,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L876
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L886
	andi	$2,$3,0x0081
	.set	macro
	.set	reorder

	lui	$8,%hi(DrawC_gOverlay) # high
	addiu	$8,$8,%lo(DrawC_gOverlay) # low
	lhu	$3,48($8)
	lh	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L877
	sll	$3,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L876
	sra	$3,$3,24
	.set	macro
	.set	reorder

$L877:
	sra	$2,$3,16
	andi	$3,$2,0x00ff
$L876:
	andi	$2,$3,0x0081
$L886:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L885
	addu	$21,$21,-1
	.set	macro
	.set	reorder

	addu	$21,$21,1
	andi	$3,$3,0x0003
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L880
	andi	$16,$19,0x00ff
	.set	macro
	.set	reorder

	lw	$8,84($sp)
	#nop
	andi	$2,$8,0x7f00
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L887
	move	$4,$16
	.set	macro
	.set	reorder

	sra	$19,$19,8
$L873:
	andi	$16,$19,0x00ff
$L880:
	move	$4,$16
$L887:
	lw	$20,0($18)
	lw	$2,56($18)
	addu	$5,$18,172
	sw	$2,0($18)
	lh	$2,0($17)
	addu	$6,$18,180
	sw	$2,16($sp)
	lw	$2,60($18)
	addu	$7,$18,188
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Flare_CarShapedHalo__FiP7COORD16iisiP15Draw_FlareCache
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$8,92($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$8,$L882
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L888
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L882
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L888:
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L881
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	beq	$16,$2,$L881
$L882:
 #APP
	lw   $12, 0($22)
	lw   $13, 4($22)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($22)
	lw   $13, 12($22)
	lw   $14, 16($22)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($22)
	lw   $13, 24($22)
	ctc2 $12, $5
	lw   $14, 28($22)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	andi	$4,$19,0x00ff
	ori	$4,$4,0x0100
	addu	$5,$18,172
	lh	$2,0($17)
	addu	$6,$18,180
	sw	$2,16($sp)
	lw	$2,60($18)
	addu	$7,$18,188
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Flare_CarShapedHalo__FiP7COORD16iisiP15Draw_FlareCache
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L881:
	.set	noreorder
	.set	nomacro
	j	$L864
	sw	$20,0($18)
	.set	macro
	.set	reorder

$L863:
	lw	$31,68($sp)
	lw	$fp,64($sp)
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

	.end	DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache
	.text
	.ent	DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,R3DCar_InMenu
	subu	$sp,$sp,32
	sw	$18,24($sp)
	lw	$18,gShadowPixmap
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L890
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuPixmap+4) # high
	lw	$18,%lo(gMenuPixmap+4)($2)
$L890:
	addu	$4,$18,6
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lui	$8,%hi(DrawC_gScreenMat) # high
	addiu	$8,$8,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 0($8)
	lw   $13, 4($8)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($8)
	lw   $13, 12($8)
	lw   $14, 16($8)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$8,%hi(DrawC_gScreenMat) # high
	addiu	$8,$8,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 20($8)
	lw   $13, 24($8)
	ctc2 $12, $5
	lw   $14, 28($8)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lw	$2,4($16)
	lw	$3,8($16)
	#nop
	sltu	$2,$2,$3
	beq	$2,$0,$L889
 #APP
	lwc2 $0, 0($17)
	lwc2 $1, 4($17)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	lw	$7,528482308
	#nop
	addu	$2,$7,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$4,$17,8
	addu	$3,$17,24
	addu	$2,$17,16
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$4,$7,16
	addu	$3,$7,32
	addu	$2,$7,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
	swc2 $7, 60($16)
 #NO_APP
	lw	$2,60($16)
	#nop
	sra	$2,$2,1
	addu	$3,$2,40
	.set	noreorder
	.set	nomacro
	bltz	$3,$L889
	sw	$3,60($16)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L889
	li	$5,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	ori	$5,$5,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$7,4($16)
	lw	$4,0($16)
	addu	$2,$7,40
	sw	$2,4($16)
	move	$2,$3
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$3,0($7)
	lw	$2,0($4)
	and	$3,$3,$6
	and	$2,$2,$5
	or	$3,$3,$2
	sw	$3,0($7)
	lw	$2,0($4)
	and	$5,$7,$5
	and	$2,$2,$6
	or	$2,$2,$5
	sw	$2,0($4)
	lw	$3,140($16)
	li	$2,9			# 0x00000009
	sb	$2,3($7)
	li	$2,46			# 0x0000002e
	sw	$3,4($7)
	sb	$2,7($7)
	lw	$2,0($18)
	lw	$3,4($18)
	lw	$4,8($18)
	lw	$5,12($18)
	sw	$2,12($7)
	sw	$3,20($7)
	sw	$4,28($7)
	sw	$5,36($7)
$L889:
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

	.end	DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache
	.text
	.ent	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$9,36($sp)
	#nop
	lw	$2,4($9)
	lw	$3,8($9)
	lw	$11,32($sp)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L904
	move	$10,$4
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($10)
	lwc2 $1, 4($10)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	lw	$8,528482308
	#nop
	addu	$2,$8,8
 #APP
	swc2 $14, 0($2)
	lwc2 $0, 0($5)
	lwc2 $1, 4($5)
	lwc2 $2, 0($6)
	lwc2 $3, 4($6)
	lwc2 $4, 0($7)
	lwc2 $5, 4($7)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$4,$8,16
	addu	$3,$8,32
	addu	$2,$8,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
 #NO_APP
	lw	$2,R3DCar_InMenu
	#nop
	beq	$2,$0,$L896
	.set	noreorder
	.set	nomacro
	j	$L897
	sw	$0,60($9)
	.set	macro
	.set	reorder

$L896:
 #APP
	nop
	nop
	.word 0x4B68002E
	swc2 $7, 60($9)
 #NO_APP
	lw	$2,60($9)
	#nop
	sra	$2,$2,3
	addu	$3,$2,40
	.set	noreorder
	.set	nomacro
	bltz	$3,$L904
	sw	$3,60($9)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	bne	$2,$0,$L904
$L897:
	lh	$2,4($10)
	#nop
	bgez	$2,$L901
	lh	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L903
	li	$5,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lh	$2,4($6)
	#nop
	bgez	$2,$L903
	lh	$2,4($7)
	#nop
	bltz	$2,$L904
$L901:
	li	$5,16711680			# 0x00ff0000
$L903:
	ori	$5,$5,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$8,4($9)
	lw	$4,0($9)
	addu	$2,$8,40
	sw	$2,4($9)
	#.set	volatile
	lw	$2,60($9)
	#.set	novolatile
	lw	$3,0($8)
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$2,0($4)
	and	$3,$3,$6
	and	$2,$2,$5
	or	$3,$3,$2
	sw	$3,0($8)
	lw	$2,0($4)
	and	$5,$8,$5
	and	$2,$2,$6
	or	$2,$2,$5
	sw	$2,0($4)
	lw	$3,140($9)
	li	$2,9			# 0x00000009
	sb	$2,3($8)
	li	$2,46			# 0x0000002e
	sw	$3,4($8)
	sb	$2,7($8)
	lhu	$2,2($11)
	lhu	$3,6($11)
	sh	$2,14($8)
	sh	$3,22($8)
	lw	$2,16($sp)
	#nop
	lhu	$5,0($2)
	lw	$2,20($sp)
	#nop
	lhu	$4,0($2)
	lw	$2,28($sp)
	#nop
	lhu	$3,0($2)
	lw	$2,24($sp)
	#nop
	lhu	$2,0($2)
	sh	$5,12($8)
	sh	$4,20($8)
	sh	$3,28($8)
	sh	$2,36($8)
$L904:
	j	$31
	.end	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	.text
	.ent	DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache:
	.frame	$sp,80,$31		# vars= 0, regs= 10/0, args= 40, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lw	$2,R3DCar_InMenu
	subu	$sp,$sp,80
	sw	$fp,72($sp)
	lw	$fp,gShadowPixmap
	sw	$16,40($sp)
	move	$16,$4
	sw	$23,68($sp)
	move	$23,$5
	sw	$31,76($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L906
	sw	$17,44($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuPixmap+4) # high
	lw	$fp,%lo(gMenuPixmap+4)($2)
$L906:
	addu	$4,$fp,6
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lui	$9,%hi(DrawC_gScreenMat) # high
	addiu	$9,$9,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 0($9)
	lw   $13, 4($9)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($9)
	lw   $13, 12($9)
	lw   $14, 16($9)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	lui	$9,%hi(DrawC_gScreenMat) # high
	addiu	$9,$9,%lo(DrawC_gScreenMat) # low
 #APP
	lw   $12, 20($9)
	lw   $13, 24($9)
	ctc2 $12, $5
	lw   $14, 28($9)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	addu	$19,$23,984
	addu	$21,$23,1016
	lhu	$2,0($16)
	lhu	$3,2($16)
	lhu	$4,4($16)
	addu	$22,$23,1008
	sh	$2,172($23)
	addu	$2,$16,8
	sh	$3,174($23)
	sh	$4,176($23)
	lhu	$3,8($16)
	lhu	$4,2($2)
	lhu	$2,4($2)
	addu	$17,$23,990
	sh	$2,184($23)
	addu	$2,$16,24
	sh	$3,180($23)
	sh	$4,182($23)
	lhu	$3,24($16)
	lhu	$4,2($2)
	lhu	$2,4($2)
	addu	$18,$23,1014
	sh	$3,188($23)
	addu	$3,$16,16
	sh	$4,190($23)
	sh	$2,192($23)
	lhu	$5,16($16)
	lhu	$6,2($3)
	lhu	$2,172($23)
	lhu	$4,4($3)
	lhu	$3,176($23)
	sll	$2,$2,2
	sh	$2,172($23)
	lhu	$2,174($23)
	sll	$3,$3,2
	sh	$3,176($23)
	lhu	$3,182($23)
	addu	$16,$23,1022
	sh	$5,976($23)
	sh	$6,978($23)
	sh	$4,980($23)
	sll	$2,$2,2
	sh	$2,174($23)
	lhu	$2,180($23)
	sll	$3,$3,2
	sll	$2,$2,2
	sh	$2,180($23)
	sh	$3,182($23)
	lhu	$2,184($23)
	lhu	$3,188($23)
	sll	$2,$2,2
	sh	$2,184($23)
	lhu	$2,190($23)
	sll	$3,$3,2
	sh	$3,188($23)
	lhu	$3,192($23)
	sll	$2,$2,2
	sll	$3,$3,2
	sh	$2,190($23)
	move	$2,$5
	sh	$3,192($23)
	move	$3,$6
	sll	$2,$2,2
	sll	$3,$3,2
	sh	$3,978($23)
	move	$3,$4
	sh	$2,976($23)
	lh	$2,172($23)
	lh	$4,180($23)
	sll	$3,$3,2
	sh	$3,980($23)
	lh	$3,174($23)
	addu	$2,$2,$4
	addu	$2,$2,1
	lh	$4,182($23)
	sra	$2,$2,1
	sh	$2,984($23)
	lh	$2,176($23)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,184($23)
	sra	$3,$3,1
	sh	$3,986($23)
	lh	$3,180($23)
	addu	$2,$2,$4
	addu	$2,$2,1
	lh	$4,188($23)
	sra	$2,$2,1
	sh	$2,988($23)
	lh	$2,182($23)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,190($23)
	sra	$3,$3,1
	sh	$3,992($23)
	lh	$3,184($23)
	addu	$2,$2,$4
	addu	$2,$2,1
	lh	$4,192($23)
	sra	$2,$2,1
	sh	$2,994($23)
	lh	$2,188($23)
	addu	$3,$3,$4
	addu	$3,$3,1
	lh	$4,976($23)
	sra	$3,$3,1
	sh	$3,996($23)
	addu	$2,$2,$4
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,1000($23)
	lh	$2,190($23)
	lh	$3,978($23)
	lh	$5,980($23)
	addu	$2,$2,$3
	addu	$2,$2,1
	lh	$3,192($23)
	sra	$2,$2,1
	sh	$2,1002($23)
	lh	$2,976($23)
	addu	$3,$3,$5
	addu	$3,$3,1
	lh	$5,172($23)
	sra	$3,$3,1
	sh	$3,1004($23)
	lh	$3,978($23)
	addu	$2,$2,$5
	addu	$2,$2,1
	lh	$5,174($23)
	sra	$2,$2,1
	sh	$2,1008($23)
	lh	$2,980($23)
	addu	$3,$3,$5
	addu	$3,$3,1
	lh	$5,176($23)
	sra	$3,$3,1
	sh	$3,1010($23)
	lh	$3,172($23)
	addu	$2,$2,$5
	addu	$2,$2,1
	lh	$5,188($23)
	sra	$2,$2,1
	sh	$2,1012($23)
	lh	$2,190($23)
	addu	$3,$3,$5
	addu	$3,$3,1
	lh	$5,174($23)
	sra	$3,$3,1
	sh	$3,1016($23)
	lh	$3,192($23)
	addu	$5,$5,$2
	addu	$5,$5,1
	lh	$2,176($23)
	sra	$5,$5,1
	sh	$5,1018($23)
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,1020($23)
	lhu	$2,0($fp)
	lhu	$3,4($fp)
	lhu	$7,12($fp)
	lhu	$8,8($fp)
	move	$6,$21
	sh	$2,178($23)
	lbu	$2,178($23)
	addu	$4,$23,172
	sh	$3,186($23)
	lbu	$3,186($23)
	move	$5,$19
	sh	$7,194($23)
	move	$7,$22
	sh	$8,982($23)
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sb	$2,990($23)
	lbu	$2,179($23)
	lbu	$3,187($23)
	lbu	$8,194($23)
	addu	$2,$2,$3
	addu	$2,$2,1
	lbu	$3,186($23)
	sra	$2,$2,1
	sb	$2,991($23)
	lbu	$2,187($23)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,195($23)
	sra	$3,$3,1
	sb	$3,998($23)
	lbu	$3,194($23)
	addu	$2,$2,$8
	addu	$2,$2,1
	lbu	$8,982($23)
	sra	$2,$2,1
	sb	$2,999($23)
	lbu	$2,195($23)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,983($23)
	sra	$3,$3,1
	sb	$3,1006($23)
	lbu	$3,982($23)
	addu	$2,$2,$8
	addu	$2,$2,1
	lbu	$8,178($23)
	sra	$2,$2,1
	sb	$2,1007($23)
	lbu	$2,983($23)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,179($23)
	sra	$3,$3,1
	sb	$3,1014($23)
	lbu	$3,178($23)
	addu	$2,$2,$8
	addu	$2,$2,1
	lbu	$8,194($23)
	sra	$2,$2,1
	sb	$2,1015($23)
	lbu	$2,179($23)
	addu	$3,$3,$8
	addu	$3,$3,1
	lbu	$8,195($23)
	sra	$3,$3,1
	sb	$3,1022($23)
	addu	$2,$2,$8
	addu	$2,$2,1
	sra	$2,$2,1
	sb	$2,1023($23)
	addu	$2,$23,178
	sw	$2,16($sp)
	sw	$17,20($sp)
	sw	$16,24($sp)
	sw	$18,28($sp)
	sw	$fp,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	sw	$23,36($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$5,$23,180
	addu	$20,$23,992
	move	$6,$20
	move	$7,$21
	addu	$2,$23,186
	addu	$19,$23,998
	sw	$17,16($sp)
	sw	$2,20($sp)
	sw	$19,24($sp)
	sw	$16,28($sp)
	sw	$fp,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	sw	$23,36($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$21
	addu	$17,$23,1000
	move	$6,$17
	addu	$7,$23,976
	sw	$18,16($sp)
	addu	$18,$23,1006
	addu	$2,$23,982
	sw	$16,20($sp)
	sw	$18,24($sp)
	sw	$2,28($sp)
	sw	$fp,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	sw	$23,36($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$20
	addu	$6,$23,188
	move	$7,$17
	addu	$2,$23,194
	sw	$16,16($sp)
	sw	$19,20($sp)
	sw	$2,24($sp)
	sw	$18,28($sp)
	sw	$fp,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache
	sw	$23,36($sp)
	.set	macro
	.set	reorder

	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache
	.text
	.ent	DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($16)
	lw	$3,12($16)
	lw	$4,24($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($18)
	sh	$3,22($18)
	sh	$4,24($18)
	lw	$2,4($16)
	lw	$3,16($16)
	lw	$4,28($16)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($18)
	sh	$3,28($18)
	sh	$4,30($18)
	lw	$3,8($16)
	lw	$4,20($16)
	lw	$5,32($16)
	subu	$2,$0,$2
	sh	$2,26($18)
	lhu	$2,28($18)
	sra	$3,$3,4
	sra	$4,$4,4
	sra	$5,$5,4
	sh	$3,32($18)
	lhu	$3,30($18)
	subu	$2,$0,$2
	sh	$4,34($18)
	sh	$5,36($18)
	sh	$2,28($18)
	subu	$3,$0,$3
	sh	$3,30($18)
	lw	$2,0($17)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($18)
	lw	$2,4($17)
	#nop
	sra	$2,$2,$3
	subu	$2,$0,$2
	sw	$2,44($18)
	lw	$2,8($17)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($18)
	.set	macro
	.set	reorder

	addu	$2,$18,20
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$0
	move	$6,$5
	li	$7,288			# 0x00000120
	lw	$4,4($18)
	lw	$8,0($18)
	li	$10,-16777216			# 0xff000000
	sw	$0,60($18)
	addu	$2,$4,12
	sw	$2,4($18)
	lw	$2,60($18)
	lw	$3,0($4)
	sll	$2,$2,2
	addu	$8,$8,$2
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
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

	move	$7,$0
	addu	$12,$18,172
	addu	$11,$18,180
	li	$8,16711680			# 0x00ff0000
	ori	$8,$8,0xffff
	li	$9,-16777216			# 0xff000000
	lui	$3,%hi(Fe3D_spotVertex+192) # high
	addiu	$2,$3,%lo(Fe3D_spotVertex+192) # low
	addu	$10,$2,-192
	lhu	$3,%lo(Fe3D_spotVertex+192)($3)
	lhu	$4,2($2)
	lhu	$2,4($2)
	move	$6,$10
	sh	$3,172($18)
	sh	$4,174($18)
	sh	$2,176($18)
$L909:
	slt	$2,$7,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L910
	addu	$5,$7,1
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	bne	$5,$2,$L913
	move	$5,$0
$L913:
	lw	$2,4($18)
	lw	$3,8($18)
	#nop
	sltu	$2,$2,$3
	beq	$2,$0,$L914
	lhu	$2,0($6)
	lhu	$3,2($6)
	lhu	$4,4($6)
	sh	$2,180($18)
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,1
	addu	$2,$2,$10
	sh	$3,182($18)
	sh	$4,184($18)
	lhu	$3,0($2)
	lhu	$4,2($2)
	lhu	$2,4($2)
	#nop
	sh	$2,192($18)
	addu	$2,$18,188
	sh	$3,188($18)
	sh	$4,190($18)
 #APP
	lwc2 $0, 0($12)
	lwc2 $1, 4($12)
	lwc2 $2, 0($11)
	lwc2 $3, 4($11)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	lw	$4,4($18)
	lw	$5,0($18)
	addu	$2,$4,28
	sw	$2,4($18)
	lw	$2,60($18)
	lw	$3,0($4)
	sll	$2,$2,2
	addu	$5,$5,$2
	lw	$2,0($5)
	and	$3,$3,$9
	and	$2,$2,$8
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($5)
	and	$3,$4,$8
	and	$2,$2,$9
	or	$2,$2,$3
	sw	$2,0($5)
 #APP
	swc2 $12, 8($4)
	swc2 $13, 16($4)
	swc2 $14, 24($4)
 #NO_APP
	lw	$3,140($18)
	li	$2,6			# 0x00000006
	sb	$2,3($4)
	li	$2,50			# 0x00000032
	sw	$0,12($4)
	sw	$0,20($4)
	sw	$3,4($4)
	sb	$2,7($4)
$L914:
	addu	$6,$6,6
	.set	noreorder
	.set	nomacro
	j	$L909
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L910:
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$0
	li	$6,1			# 0x00000001
	li	$7,288			# 0x00000120
	li	$10,-16777216			# 0xff000000
	lw	$4,4($18)
	lw	$8,0($18)
	addu	$2,$4,12
	sw	$2,4($18)
	lw	$2,60($18)
	lw	$3,0($4)
	sll	$2,$2,2
	addu	$8,$8,$2
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
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

	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
	.text
	.ent	DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache:
	.frame	$sp,88,$31		# vars= 48, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	lw	$3,gShowroomLights
	lui	$2,%hi(gMenuPixmap+12) # high
	sw	$17,68($sp)
	lw	$17,%lo(gMenuPixmap+12)($2)
	sw	$18,72($sp)
	move	$18,$4
	sw	$19,76($sp)
	move	$19,$5
	sw	$16,64($sp)
	move	$16,$6
	sw	$31,84($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L916
	sw	$20,80($sp)
	.set	macro
	.set	reorder

	jal	gettick
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L950
	sra	$2,$2,8
	.set	macro
	.set	reorder

	addu	$2,$3,255
	sra	$2,$2,8
$L950:
	sll	$2,$2,8
	subu	$2,$3,$2
	sra	$3,$2,3
	lw	$2,DrawC_gMenuLightsDirection
	li	$4,-1			# 0xffffffff
	sw	$3,48($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L919
	sw	$4,56($sp)
	.set	macro
	.set	reorder

	addu	$2,$3,16
	andi	$2,$2,0x001f
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L920
	sw	$4,60($sp)
	.set	macro
	.set	reorder

$L919:
	li	$2,32			# 0x00000020
	subu	$2,$2,$3
	sw	$2,52($sp)
	li	$2,1			# 0x00000001
	sw	$2,60($sp)
$L920:
	li	$8,31			# 0x0000001f
	addu	$2,$sp,47
	li	$3,-1			# 0xffffffff
$L921:
	sb	$3,0($2)
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	bgez	$8,$L921
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	move	$8,$0
	addu	$10,$sp,16
	addu	$9,$sp,56
	addu	$6,$sp,48
$L925:
	move	$7,$0
	move	$5,$6
	move	$4,$9
$L928:
	lw	$2,0($4)
	#nop
	mult	$7,$2
	lw	$2,0($5)
	mflo	$20
	#nop
	#nop
	addu	$2,$2,$20
	andi	$2,$2,0x001f
	addu	$3,$10,$2
	lb	$2,0($3)
	#nop
	slt	$2,$2,$7
	beq	$2,$0,$L931
	sb	$7,0($3)
$L931:
	addu	$7,$7,1
	slt	$2,$7,5
	bne	$2,$0,$L928
	addu	$9,$9,4
	addu	$8,$8,1
	slt	$2,$8,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L925
	addu	$6,$6,4
	.set	macro
	.set	reorder

	addu	$4,$17,6
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetTransPrecision__Fi
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($18)
	lw	$3,12($18)
	lw	$4,24($18)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,20($16)
	sh	$3,22($16)
	sh	$4,24($16)
	lw	$2,4($18)
	lw	$3,16($18)
	lw	$4,28($18)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($16)
	sh	$3,28($16)
	sh	$4,30($16)
	lw	$3,8($18)
	lw	$4,20($18)
	lw	$5,32($18)
	subu	$2,$0,$2
	sh	$2,26($16)
	lhu	$2,28($16)
	sra	$3,$3,4
	sra	$4,$4,4
	sra	$5,$5,4
	sh	$3,32($16)
	lhu	$3,30($16)
	subu	$2,$0,$2
	sh	$4,34($16)
	sh	$5,36($16)
	sh	$2,28($16)
	subu	$3,$0,$3
	sh	$3,30($16)
	lw	$2,0($19)
	lw	$3,TrsProj_precision
	#nop
	sra	$2,$2,$3
	sw	$2,40($16)
	lw	$2,4($19)
	#nop
	sra	$2,$2,$3
	subu	$2,$0,$2
	sw	$2,44($16)
	lw	$2,8($19)
	#nop
	sra	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$2,48($16)
	.set	macro
	.set	reorder

	addu	$2,$16,20
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	move	$8,$0
	addu	$25,$sp,16
	li	$12,16711680			# 0x00ff0000
	ori	$12,$12,0xffff
	li	$18,-16777216			# 0xff000000
	addu	$15,$16,180
	addu	$14,$16,976
	lui	$2,%hi(Fe3D_lightsVertex) # high
	addiu	$24,$2,%lo(Fe3D_lightsVertex) # low
	addu	$19,$24,6
	move	$11,$19
	move	$10,$24
	sw	$0,60($16)
$L934:
	slt	$2,$8,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L916
	sll	$2,$8,1
	.set	macro
	.set	reorder

	addu	$5,$2,2
	li	$2,64			# 0x00000040
	bne	$5,$2,$L938
	move	$5,$0
$L938:
	lw	$2,4($16)
	lw	$3,8($16)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L916
	move	$7,$0
	.set	macro
	.set	reorder

	lhu	$3,2($10)
	lhu	$2,0($10)
	lhu	$4,4($10)
	sh	$3,174($16)
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,1
	sh	$2,172($16)
	addu	$2,$3,$24
	sh	$4,176($16)
	lhu	$4,0($2)
	lhu	$5,2($2)
	lhu	$2,4($2)
	addu	$9,$25,$8
	sh	$4,180($16)
	sh	$5,182($16)
	sh	$2,184($16)
	lhu	$2,0($11)
	lhu	$4,2($11)
	lhu	$5,4($11)
	addu	$3,$3,$19
	sh	$2,188($16)
	lui	$2,%hi(hilight_colors) # high
	sh	$4,190($16)
	sh	$5,192($16)
	lhu	$4,0($3)
	lhu	$5,2($3)
	lhu	$3,4($3)
	addiu	$13,$2,%lo(hilight_colors) # low
	sh	$4,976($16)
	sh	$5,978($16)
	sh	$3,980($16)
$L940:
	slt	$2,$7,2
	beq	$2,$0,$L936
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L951
	addu	$2,$16,172
	.set	macro
	.set	reorder

	lb	$2,0($9)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L942
	addu	$2,$16,172
	.set	macro
	.set	reorder

$L951:
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	lw	$6,4($16)
	#nop
	addu	$2,$6,40
	sw	$2,4($16)
	lw	$2,60($16)
	lw	$4,0($16)
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$2,0($6)
	lw	$3,0($4)
	and	$2,$2,$18
	and	$3,$3,$12
	or	$2,$2,$3
	sw	$2,0($6)
	lw	$2,0($4)
	and	$3,$6,$12
	and	$2,$2,$18
	or	$2,$2,$3
	sw	$2,0($4)
	addu	$2,$6,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$2,$16,188
 #APP
	lwc2 $0, 0($15)
	lwc2 $1, 4($15)
	lwc2 $2, 0($14)
	lwc2 $3, 4($14)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$4,$6,16
	addu	$3,$6,32
	addu	$2,$6,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
 #NO_APP
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L946
	li	$2,3145728			# 0x00300000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L949
	ori	$2,$2,0x0a00
	.set	macro
	.set	reorder

$L946:
	lb	$2,0($9)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$13
	lw	$2,0($2)
$L949:
	sw	$2,4($6)
	li	$2,46			# 0x0000002e
	sb	$2,7($6)
	li	$2,9			# 0x00000009
	sb	$2,3($6)
	lw	$2,0($17)
	lw	$3,4($17)
	lw	$4,8($17)
	lw	$5,12($17)
	sw	$2,12($6)
	sw	$3,20($6)
	sw	$4,28($6)
	sw	$5,36($6)
$L942:
	.set	noreorder
	.set	nomacro
	j	$L940
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L936:
	addu	$11,$11,12
	addu	$10,$10,12
	.set	noreorder
	.set	nomacro
	j	$L934
	addu	$8,$8,1
	.set	macro
	.set	reorder

$L916:
	lw	$31,84($sp)
	lw	$20,80($sp)
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

	.end	DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache
