	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\drawc.cpp"
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

	.extern	D_8011F4B4, 20
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
	blez	$3,$L604
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	move	$16,$17
$L606:
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
	bgez	$4,$L605
	sh	$3,4($5)
	.set	macro
	.set	reorder

	li	$2,32767			# 0x00007fff
	.set	noreorder
	.set	nomacro
	j	$L604
	sh	$2,0($5)
	.set	macro
	.set	reorder

$L605:
	lw	$2,DrawC_gEnvMapMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L604:
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
	blez	$3,$L610
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	move	$16,$17
$L612:
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
	bgez	$4,$L611
	sh	$3,4($5)
	.set	macro
	.set	reorder

	li	$2,32767			# 0x00007fff
	.set	noreorder
	.set	nomacro
	j	$L610
	sh	$2,0($5)
	.set	macro
	.set	reorder

$L611:
	lw	$2,DrawC_gShadowMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L610:
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
	beq	$2,$0,$L619
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
$L619:
	lbu	$2,Night_gDrawLightning
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	addu	$6,$sp,104
	.set	macro
	.set	reorder

	lui	$2,%hi(Night_gWeatherColor) # high
	addiu	$2,$2,%lo(Night_gWeatherColor) # low
	lw	$3,Night_gLightningType
	lbu	$4,104($sp)
	sll	$3,$3,2
	addu	$3,$3,$2
 #APP
 #NO_APP
	lbu	$2,0($3)
	lbu	$5,1($6)
	addu	$4,$4,$2
	move	$9,$4
	lbu	$2,1($3)
	slt	$4,$4,256
	addu	$7,$5,$2
	lbu	$5,2($6)
	lbu	$2,2($3)
	move	$8,$7
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L621
	move	$3,$5
	.set	macro
	.set	reorder

	li	$9,255			# 0x000000ff
$L621:
	slt	$2,$7,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	slt	$2,$5,256
	.set	macro
	.set	reorder

	li	$8,255			# 0x000000ff
$L624:
	bne	$2,$0,$L623
	li	$3,255			# 0x000000ff
$L623:
	sb	$9,104($sp)
	sb	$8,1($6)
	sb	$3,2($6)
$L618:
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
	bne	$2,$0,$L626
	move	$19,$6
	.set	macro
	.set	reorder

	lh	$2,2236($17)
	#nop
	bne	$2,$3,$L625
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
	beq	$2,$0,$L628
	sb	$3,2227($17)
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sb	$2,2227($17)
$L628:
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
	beq	$2,$3,$L625
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
	beq	$2,$0,$L630
	andi	$3,$18,0x0008
	.set	macro
	.set	reorder

	lhu	$2,2112($17)
	#nop
	andi	$2,$2,0x0008
	beq	$3,$2,$L631
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
	bne	$2,$0,$L632
	addu	$4,$sp,16
	lui	$5,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L635
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

$L632:
	addu	$4,$sp,16
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
$L635:
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

$L631:
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
	j	$L634
$L630:
	move	$5,$0
	lw	$4,2180($17)
	lh	$6,2184($17)
	andi	$2,$18,0x0007
	sw	$2,Texture_CarColor
$L634:
	jal	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
$L626:
	sh	$18,2112($17)
$L625:
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
	mfc2	$12,$19
 nop
 sra $12,$12,2
 sw $12,0($2)
 #NO_APP
	lw	$16,64($19)
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	sra	$3,$16,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$3,$L639
	sw	$3,64($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	beq	$2,$0,$L640
$L639:
	.set	noreorder
	.set	nomacro
	j	$L732
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L637:
	sw	$0,64($19)
$L640:
	lw	$2,64($19)
	lw	$4,2168($18)
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L641
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
	j	$L642
$L641:
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
$L642:
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
$L643:
	sh	$0,0($2)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L643
	addu	$2,$2,-2
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L694
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,536($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L733
	ori	$3,$3,0x0001
	.set	macro
	.set	reorder

$L648:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0002
	ori	$3,$3,0x0002
$L733:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L649:
	lw	$3,544($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	j	$L734
	ori	$3,$3,0x0100
	.set	macro
	.set	reorder

$L651:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0200
	ori	$3,$3,0x0200
$L734:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L652:
	lw	$3,548($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L654
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L735
	ori	$2,$2,0x0400
	.set	macro
	.set	reorder

$L654:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0800
$L735:
	sh	$2,4($3)
$L655:
	lw	$3,552($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L657
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0100
	.set	noreorder
	.set	nomacro
	j	$L736
	ori	$4,$4,0x1000
	.set	macro
	.set	reorder

$L657:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0200
	ori	$4,$4,0x2000
$L736:
	sh	$3,2($2)
	sh	$4,4($2)
$L658:
	lw	$3,560($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0001
	.set	noreorder
	.set	nomacro
	j	$L737
	ori	$4,$4,0x0010
	.set	macro
	.set	reorder

$L660:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0002
	ori	$4,$4,0x0020
$L737:
	sh	$3,2($2)
	sh	$4,4($2)
$L661:
	lw	$3,564($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L663
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L738
	ori	$2,$2,0x0004
	.set	macro
	.set	reorder

$L663:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0008
$L738:
	sh	$2,4($3)
$L664:
	lw	$3,568($18)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,8($3)
	#nop
	ori	$2,$2,0x0101
	sh	$2,8($3)
$L666:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
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
$L740:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L667:
	lbu	$2,1090($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($3)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L741
	andi	$2,$4,0x0100
	.set	macro
	.set	reorder

	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($3)
	andi	$2,$4,0x0100
$L741:
	bne	$2,$0,$L670
	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($3)
$L670:
	lhu	$3,2228($18)
	#nop
	andi	$2,$3,0x0011
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L673
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L674
$L675:
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,58($3)
$L674:
	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L742
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	bne	$2,$0,$L673
$L742:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
$L673:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
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
$L743:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L678
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L678:
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L744
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lw	$4,12($19)
	#nop
	sll	$2,$4,1
	addu	$5,$18,$2
	lhu	$2,2232($5)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0040
	sh	$2,56($3)
$L682:
	lhu	$2,2232($5)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L683
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,54($3)
$L684:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L683
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,56($3)
$L683:
	xori	$4,$4,0x0001
	sll	$2,$4,1
	addu	$4,$18,$2
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L686
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x4000
	sh	$2,56($3)
$L686:
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L687
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,54($3)
$L688:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L745
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,56($3)
$L687:
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L745:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$2,0($2)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L746
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
	bne	$2,$0,$L747
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
$L747:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L746
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,48($4)
	#nop
	andi	$2,$2,0xff00
	or	$2,$3,$2
	sh	$2,56($4)
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L746:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$3,0($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L694
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,56($2)
	lh	$4,48($2)
	sh	$3,48($2)
	sh	$4,56($2)
$L694:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L697
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

$L744:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$6,54($5)
	lhu	$4,56($5)
	lh	$3,8($5)
	ori	$2,$6,0x0002
	sh	$2,54($5)
	ori	$2,$4,0x0200
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L698
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
	beq	$2,$0,$L699
	ori	$2,$6,0x0083
	.set	macro
	.set	reorder

	sh	$2,54($5)
	ori	$2,$4,0x0281
	sh	$2,56($5)
$L699:
	lhu	$2,2234($18)
	#nop
	andi	$2,$2,0x000f
	sll	$2,$2,1
	addu	$2,$2,$7
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,54($5)
	lhu	$4,56($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,54($5)
	sh	$4,56($5)
$L698:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	lui	$6,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lw	$2,1392($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L749
	addu	$4,$sp,24
	.set	macro
	.set	reorder

$L748:
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
	bne	$2,$0,$L750
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
$L750:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L751
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L752
	ori	$2,$5,0x0081
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($6)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L751
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	ori	$2,$5,0x0081
$L752:
	sh	$2,58($4)
	lui	$2,%hi(DrawC_HeadLightFlash) # high
$L751:
	lhu	$3,2234($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L754
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L753
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(DrawC_gOverlay) # high
$L754:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
	lui	$2,%hi(DrawC_gOverlay) # high
$L753:
	addiu	$4,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L755
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
	beq	$2,$0,$L756
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
$L756:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L755
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,52($4)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($4)
	lui	$2,%hi(DrawC_gOverlay) # high
$L755:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($5)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
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
	beq	$2,$0,$L712
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L712:
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
	beq	$2,$0,$L749
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lhu	$2,52($5)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($5)
$L697:
	addu	$4,$sp,24
$L749:
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
	bne	$2,$0,$L714
	lui	$2,%hi(gCView) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(gCView)($2)
	lw	$5,gFlip
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	li	$22,3			# 0x00000003
	.set	macro
	.set	reorder

	move	$20,$2
	lh	$3,202($18)
	lh	$5,204($18)
	lb	$7,124($18)
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
	slt	$2,$7,$2
	lhu	$5,2($3)
	lhu	$3,4($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L715
	sll	$2,$4,16
	.set	macro
	.set	reorder

	sra	$6,$2,24
$L715:
	andi	$2,$3,0x00ff
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L716
	li	$21,2			# 0x00000002
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$5,$2,24
$L716:
	sll	$2,$6,16
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L757
	sll	$2,$5,16
	.set	macro
	.set	reorder

	addu	$6,$6,-10
	li	$23,1			# 0x00000001
$L757:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L758
	sll	$2,$5,16
	.set	macro
	.set	reorder

	move	$22,$0
	subu	$5,$0,$5
	sll	$2,$5,16
$L758:
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L759
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	addu	$5,$5,-10
	li	$21,1			# 0x00000001
$L759:
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L720
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L721
	sw	$0,100($19)
	.set	macro
	.set	reorder

$L720:
	lui	$3,%hi(Track_gReflectionMaps) # high
	addiu	$3,$3,%lo(Track_gReflectionMaps) # low
	sll	$2,$2,4
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
$L721:
	sll	$2,$5,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L722
	addu	$4,$19,72
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L723
	sw	$0,116($19)
	.set	macro
	.set	reorder

$L722:
	sll	$16,$2,4
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

$L723:
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
	beq	$2,$0,$L724
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$3,448($18)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$3,0($3)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L724
	sw	$3,DrawC_gWetRoad
$L724:
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
	j	$L739
	addu	$4,$19,106
	.set	macro
	.set	reorder

$L714:
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
$L739:
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
	bne	$2,$0,$L726
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
	beq	$23,$0,$L727
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
$L727:
	sll	$2,$6,1
	addu	$2,$2,$6
	sra	$2,$2,2
	sll	$3,$2,16
	sll	$4,$2,8
	addu	$3,$3,$4
	addu	$3,$3,$2
	sw	$3,152($19)
$L726:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,144($19)
	lh	$3,2236($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L729
	sll	$2,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L730
	sra	$6,$6,2
	.set	macro
	.set	reorder

$L729:
	addu	$2,$2,$6
	sra	$6,$2,2
$L730:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,148($19)
	lw	$2,2148($18)
$L732:
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
	bne	$2,$0,$L768
	move	$9,$5
	.set	macro
	.set	reorder

	lw	$5,2168($4)
	#nop
	beq	$5,$0,$L762
	lh	$2,2172($5)
	lhu	$3,2172($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L763
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sh	$2,2172($5)
	sll	$2,$2,16
	bne	$2,$0,$L768
$L763:
	lw	$2,2160($5)
	lw	$4,2148($5)
	.set	noreorder
	.set	nomacro
	j	$L767
	addu	$8,$2,-1
	.set	macro
	.set	reorder

$L762:
	lw	$2,2160($4)
	lw	$4,2148($4)
	addu	$8,$2,-1
$L767:
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
$L768:
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
	bne	$2,$0,$L770
	move	$22,$7
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L921
	andi	$2,$18,0x0001
	.set	macro
	.set	reorder

	andi	$18,$18,0x00be
$L770:
	andi	$2,$18,0x0001
$L921:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L771
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
	li	$11,-1			# 0xffffffff
	addu	$10,$17,172
	addu	$9,$17,156
	addu	$6,$17,215
	addu	$5,$19,4
$L772:
	addu	$8,$8,-1
	beq	$8,$11,$L771
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
	bgez	$2,$L776
	subu	$2,$0,$2
$L776:
	addu	$5,$5,6
	addu	$7,$7,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L772
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L771:
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
	li	$10,-1			# 0xffffffff
	addu	$6,$17,212
	lw	$7,16($21)
	lhu	$8,0($21)
	addu	$5,$7,4
$L777:
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	beq	$8,$10,$L778
	andi	$3,$18,0x0009
	.set	macro
	.set	reorder

	lhu	$2,-2($5)
	lhu	$4,0($5)
	addu	$5,$5,6
	lhu	$3,0($7)
	addu	$7,$7,6
	sh	$3,0($9)
	sh	$2,-2($6)
	sh	$4,0($6)
	addu	$6,$6,8
	.set	noreorder
	.set	nomacro
	j	$L777
	addu	$9,$9,8
	.set	macro
	.set	reorder

$L778:
	lhu	$10,2($21)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L832
	slt	$2,$3,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L917
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L782
	andi	$2,$18,0x0002
	.set	macro
	.set	reorder

	j	$L769
$L917:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L844
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L884
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	j	$L769
$L782:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L783
	sll	$2,$10,1
	.set	macro
	.set	reorder

	addu	$2,$2,$10
	sll	$9,$2,2
$L784:
	addu	$10,$10,-1
$L922:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$10,$2,$L769
	addu	$9,$9,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$7,$2,$9
	lbu	$6,3($7)
	lbu	$5,4($7)
	lw	$2,4($17)
	lbu	$4,5($7)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L922
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	sll	$6,$6,3
	addu	$6,$6,$17
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$4,$4,3
	addu	$4,$4,$17
 #APP
	lwc2 $0, 208($6)
	lwc2 $1, 212($6)
	lwc2 $2, 208($5)
	lwc2 $3, 212($5)
	lwc2 $4, 208($4)
	lwc2 $5, 212($4)
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
	beq	$2,$0,$L801
	subu	$3,$0,$3
$L801:
	.set	noreorder
	.set	nomacro
	blez	$3,$L922
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
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
	bltz	$3,$L784
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L922
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
 #APP
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
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
	beq	$2,$0,$L805
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$6,1014($17)
	lbu	$8,1015($17)
	beq	$2,$0,$L806
	lbu	$6,1022($17)
	lbu	$8,1023($17)
$L806:
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
	j	$L784
	sb	$4,29($5)
	.set	macro
	.set	reorder

$L805:
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
	j	$L784
	sh	$4,28($5)
	.set	macro
	.set	reorder

$L783:
	addu	$2,$2,$10
	sll	$9,$2,2
$L808:
	addu	$10,$10,-1
$L923:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$10,$2,$L769
	addu	$9,$9,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$9
	lbu	$6,3($8)
	lbu	$5,4($8)
	lw	$2,4($17)
	lbu	$4,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L923
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	sll	$6,$6,3
	addu	$6,$6,$17
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$4,$4,3
	addu	$4,$4,$17
 #APP
	lwc2 $0, 208($6)
	lwc2 $1, 212($6)
	lwc2 $2, 208($5)
	lwc2 $3, 212($5)
	lwc2 $4, 208($4)
	lwc2 $5, 212($4)
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
	beq	$2,$0,$L825
	subu	$3,$0,$3
$L825:
	.set	noreorder
	.set	nomacro
	blez	$3,$L923
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
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
	bltz	$3,$L808
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L923
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	lhu	$2,0($8)
	lw	$3,140($17)
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L829
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$4,38			# 0x00000026
$L829:
	sw	$3,4($7)
	sb	$4,7($7)
	lhu	$2,0($8)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L830
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
	j	$L808
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L830:
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
	j	$L808
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L832:
	li	$18,38			# 0x00000026
	sll	$2,$10,1
	addu	$2,$2,$10
	sll	$11,$2,2
$L833:
	addu	$10,$10,-1
$L924:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$10,$2,$L769
	addu	$11,$11,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$6,$2,$11
	lbu	$9,3($6)
	lbu	$8,4($6)
	lw	$2,4($17)
	lbu	$7,5($6)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L924
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	sll	$9,$9,3
	addu	$9,$9,$17
	sll	$8,$8,3
	addu	$8,$8,$17
	sll	$7,$7,3
	addu	$7,$7,$17
 #APP
	lwc2 $0, 208($9)
	lwc2 $1, 212($9)
	lwc2 $2, 208($8)
	lwc2 $3, 212($8)
	lwc2 $4, 208($7)
	lwc2 $5, 212($7)
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
	beq	$2,$0,$L838
	subu	$3,$0,$3
$L838:
	.set	noreorder
	.set	nomacro
	blez	$3,$L924
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
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
	bltz	$3,$L833
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L924
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	lhu	$2,0($6)
	#nop
	andi	$2,$2,0x03f3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	addu	$10,$10,1
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	beq	$2,$0,$L842
	lbu	$3,3($6)
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
	lbu	$3,4($6)
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
	lbu	$3,5($6)
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
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,84($17)
	lw	$15,88($17)
	lw	$16,92($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,72($17)
	lw	$15,76($17)
	lw	$16,80($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,144($17)
	#nop
	sw	$2,4($5)
	sb	$18,7($5)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($5)
	sh	$3,22($5)
 #APP
	lbu	$14,116($17)
	lbu	$15,117($17)
	lbu	$13,132($17)
	addiu	$14,$14,64
	addu	$15,$15,$13
	lbu	$12,174($17)
	lbu	$13,176($17)
	addu	$12,$12,$14
	sb	$12,12($5)
	addu	$13,$13,$15
	sb	$13,13($5)
	lbu	$12,182($17)
	lbu	$13,184($17)
	addu	$12,$12,$14
	sb	$12,20($5)
	addu	$13,$13,$15
	sb	$13,21($5)
	lbu	$12,190($17)
	lbu	$13,192($17)
	addu	$12,$12,$14
	sb	$12,28($5)
	addu	$13,$13,$15
	sb	$13,29($5)
 #NO_APP
$L842:
	lw	$2,100($17)
	#nop
	beq	$2,$0,$L843
 #APP
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,144($17)
	#nop
	sw	$2,4($5)
	sb	$18,7($5)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($5)
	sh	$3,22($5)
 #APP
	lbu	$14,100($17)
	lbu	$15,101($17)
	addiu	$14,$14,64
	lbu	$12,214($9)
	lbu	$13,215($9)
	addu	$12,$12,$14
	sb	$12,12($5)
	addu	$13,$13,$15
	sb	$13,13($5)
	lbu	$12,214($8)
	lbu	$13,215($8)
	addu	$12,$12,$14
	sb	$12,20($5)
	addu	$13,$13,$15
	sb	$13,21($5)
	lbu	$12,214($7)
	lbu	$13,215($7)
	addu	$12,$12,$14
	sb	$12,28($5)
	addu	$13,$13,$15
	sb	$13,29($5)
 #NO_APP
$L843:
 #APP
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,140($17)
	#nop
	sw	$2,4($5)
	li	$2,36			# 0x00000024
	sb	$2,7($5)
	lbu	$2,2($6)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($5)
	sh	$3,22($5)
	lhu	$2,6($6)
	lhu	$3,8($6)
	lhu	$4,10($6)
	sh	$2,12($5)
	sh	$3,20($5)
	.set	noreorder
	.set	nomacro
	j	$L833
	sh	$4,28($5)
	.set	macro
	.set	reorder

$L844:
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$15,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$10,1
	addu	$2,$2,$10
	sll	$11,$2,2
$L845:
	addu	$10,$10,-1
$L925:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$10,$2,$L769
	addu	$11,$11,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$11
	lbu	$6,3($8)
	lbu	$5,4($8)
	lw	$2,4($17)
	lbu	$4,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L925
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	sll	$6,$6,3
	addu	$6,$6,$17
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$4,$4,3
	addu	$4,$4,$17
 #APP
	lwc2 $0, 208($6)
	lwc2 $1, 212($6)
	lwc2 $2, 208($5)
	lwc2 $3, 212($5)
	lwc2 $4, 208($4)
	lwc2 $5, 212($4)
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
	beq	$2,$0,$L862
	subu	$3,$0,$3
$L862:
	.set	noreorder
	.set	nomacro
	blez	$3,$L925
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
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
	lhu	$2,0($2)
	#nop
	sll	$6,$2,16
	sra	$5,$6,16
	beq	$5,$0,$L864
	lw	$3,60($17)
	lh	$2,0($8)
	lhu	$4,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L865
	andi	$5,$5,0x00ff
	.set	macro
	.set	reorder

	sra	$5,$6,24
$L865:
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	andi	$2,$5,0x0040
	beq	$2,$0,$L866
	addu	$3,$3,-2
$L866:
	.set	noreorder
	.set	nomacro
	bltz	$3,$L925
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L925
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	andi	$2,$4,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L869
	andi	$9,$4,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$5,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L869
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L869
$L873:
	sra	$5,$5,2
	andi	$2,$5,0x0003
	beq	$2,$0,$L873
$L869:
	.set	noreorder
	.set	nomacro
	j	$L875
	sw	$3,60($17)
	.set	macro
	.set	reorder

$L864:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L845
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L925
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L875:
	andi	$4,$5,0x0003
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L878
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
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	andi	$2,$5,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L879
	li	$3,36			# 0x00000024
	.set	macro
	.set	reorder

	lw	$4,140($17)
$L879:
	andi	$2,$9,0x0001
	beq	$2,$0,$L880
	li	$3,38			# 0x00000026
$L880:
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
	j	$L845
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L878:
	lw	$7,4($17)
 #APP
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	swc2 $12, 8($7)
	swc2 $13, 16($7)
	swc2 $14, 24($7)
 #NO_APP
	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	andi	$2,$5,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L882
	li	$3,36			# 0x00000024
	.set	macro
	.set	reorder

	lw	$4,140($17)
$L882:
	andi	$2,$9,0x0001
	beq	$2,$0,$L883
	li	$3,38			# 0x00000026
$L883:
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
	j	$L845
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L884:
	addiu	$20,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$10,1
	addu	$2,$2,$10
	sll	$18,$2,2
$L885:
	addu	$10,$10,-1
$L926:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$10,$2,$L769
	addu	$18,$18,-12
	.set	macro
	.set	reorder

	lw	$2,24($21)
	lw	$3,8($17)
	addu	$8,$2,$18
	lbu	$25,3($8)
	lbu	$24,4($8)
	lw	$2,4($17)
	lbu	$11,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L926
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	sll	$2,$25,3
	addu	$25,$2,$17
	sll	$2,$24,3
	addu	$24,$2,$17
	sll	$2,$11,3
	addu	$11,$2,$17
 #APP
	lwc2 $0, 208($25)
	lwc2 $1, 212($25)
	lwc2 $2, 208($24)
	lwc2 $3, 212($24)
	lwc2 $4, 208($11)
	lwc2 $5, 212($11)
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
	beq	$2,$0,$L890
	subu	$3,$0,$3
$L890:
	.set	noreorder
	.set	nomacro
	blez	$3,$L926
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
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
	lhu	$2,0($2)
	#nop
	sll	$5,$2,16
	sra	$6,$5,16
	beq	$6,$0,$L892
	lw	$4,60($17)
	lh	$2,0($8)
	lhu	$3,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L893
	andi	$6,$6,0x00ff
	.set	macro
	.set	reorder

	sra	$6,$5,24
$L893:
	lw	$2,64($17)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L926
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L926
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	andi	$2,$3,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L896
	andi	$9,$3,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$6,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L896
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L896
$L900:
	sra	$6,$6,2
	andi	$2,$6,0x0003
	beq	$2,$0,$L900
$L896:
	.set	noreorder
	.set	nomacro
	j	$L902
	sw	$4,60($17)
	.set	macro
	.set	reorder

$L892:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L885
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L926
	addu	$10,$10,-1
	.set	macro
	.set	reorder

	addu	$10,$10,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L902:
	andi	$2,$9,0x03f3
	beq	$2,$0,$L905
	lw	$2,116($17)
	#nop
	beq	$2,$0,$L905
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
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,84($17)
	lw	$15,88($17)
	lw	$16,92($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,72($17)
	lw	$15,76($17)
	lw	$16,80($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
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
 #APP
	lbu	$14,116($17)
	lbu	$15,117($17)
	lbu	$13,132($17)
	addiu	$14,$14,64
	addu	$15,$15,$13
	lbu	$12,174($17)
	lbu	$13,176($17)
	addu	$12,$12,$14
	sb	$12,12($7)
	addu	$13,$13,$15
	sb	$13,13($7)
	lbu	$12,182($17)
	lbu	$13,184($17)
	addu	$12,$12,$14
	sb	$12,20($7)
	addu	$13,$13,$15
	sb	$13,21($7)
	lbu	$12,190($17)
	lbu	$13,192($17)
	addu	$12,$12,$14
	sb	$12,28($7)
	addu	$13,$13,$15
	sb	$13,29($7)
 #NO_APP
$L905:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L927
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$6,0x0001
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L907
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,152($17)
	.set	noreorder
	.set	nomacro
	j	$L920
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L907:
	andi	$2,$9,0x0004
	beq	$2,$0,$L909
	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L920
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L909:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L920:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
 #APP
	lbu	$14,100($17)
	lbu	$15,101($17)
	addiu	$14,$14,64
	lbu	$12,214($25)
	lbu	$13,215($25)
	addu	$12,$12,$14
	sb	$12,12($7)
	addu	$13,$13,$15
	sb	$13,13($7)
	lbu	$12,214($24)
	lbu	$13,215($24)
	addu	$12,$12,$14
	sb	$12,20($7)
	addu	$13,$13,$15
	sb	$13,21($7)
	lbu	$12,214($11)
	lbu	$13,215($11)
	addu	$12,$12,$14
	sb	$12,28($7)
	addu	$13,$13,$15
	sb	$13,29($7)
 #NO_APP
	andi	$2,$6,0x0003
$L927:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L911
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
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L912
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L912:
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
	j	$L885
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L911:
	lw	$7,4($17)
 #APP
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L914
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L914:
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
	j	$L885
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L769:
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
	beq	$2,$0,$L940
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
	beq	$2,$0,$L930
	subu	$3,$0,$3
$L930:
	blez	$3,$L940
 #APP
	swc2 $12, 196($8)
	swc2 $13, 200($8)
	swc2 $14, 204($8)
 #NO_APP
	lh	$3,16($8)
	lh	$2,196($8)
	lh	$9,18($8)
	slt	$2,$3,$2
	beq	$2,$0,$L933
	lh	$2,200($8)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L933
	lh	$2,204($8)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L940
$L933:
	lh	$2,196($8)
	#nop
	bgez	$2,$L934
	lh	$2,200($8)
	#nop
	bgez	$2,$L934
	lh	$2,204($8)
	#nop
	bltz	$2,$L940
$L934:
	lh	$2,198($8)
	#nop
	slt	$2,$9,$2
	beq	$2,$0,$L935
	lh	$2,202($8)
	#nop
	slt	$2,$9,$2
	beq	$2,$0,$L935
	lh	$2,206($8)
	#nop
	slt	$2,$9,$2
	bne	$2,$0,$L940
$L935:
	lh	$2,198($8)
	#nop
	bgez	$2,$L936
	lh	$2,202($8)
	#nop
	bgez	$2,$L936
	lh	$2,206($8)
	#nop
	bltz	$2,$L940
$L936:
	lh	$2,4($4)
	#nop
	bgez	$2,$L937
	lh	$2,4($5)
	#nop
	bgez	$2,$L937
	lh	$2,4($6)
	#nop
	bltz	$2,$L940
$L937:
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
	bltz	$3,$L940
	sw	$3,60($8)
	.set	macro
	.set	reorder

	lw	$2,136($8)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L940
 #APP
	lw	$3,4($8)
 lw $12,60($8)
 lw $13,56($8)
 addiu $14,$3,32
 sll $12,$12,2
 addu $13,$13,$12
 sw $14,4($8)
 lwl $14,2($13)
 lui $12,0x0700
 srl $14,$14,8
 or $14,$14,$12
 sll $12,$3,8
 sw $14,0($3)
 swl $12,2($13)
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
$L940:
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
	lw	$19,20($6)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L942
	move	$21,$7
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	bne	$2,$0,$L942
	lw	$25,96($sp)
	#nop
	andi	$25,$25,0x00be
	sw	$25,96($sp)
$L942:
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L943
	move	$8,$19
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
	addu	$5,$19,4
	li	$11,-1			# 0xffffffff
	addu	$10,$17,172
	lw	$25,88($sp)
	addu	$9,$17,156
	lhu	$7,0($25)
$L944:
	addu	$7,$7,-1
	beq	$7,$11,$L943
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
	bgez	$2,$L948
	subu	$2,$0,$2
$L948:
	addu	$5,$5,6
	addu	$8,$8,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L944
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L943:
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
$L949:
	addu	$10,$10,-1
	.set	noreorder
	.set	nomacro
	beq	$10,$13,$L950
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
	j	$L949
	addu	$7,$7,8
	.set	macro
	.set	reorder

$L950:
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
	beq	$3,$2,$L993
	slt	$2,$3,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L1096
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L954
	addu	$25,$17,976
	.set	macro
	.set	reorder

	j	$L941
$L1096:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1010
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1055
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	j	$L941
$L954:
	sw	$25,32($sp)
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0020
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L955
	addu	$fp,$17,992
	.set	macro
	.set	reorder

	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$9,$2,2
$L956:
	addu	$18,$18,-1
$L1102:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L941
	addu	$9,$9,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$9
	lbu	$5,5($8)
	lbu	$6,3($8)
	lw	$2,4($17)
	lbu	$4,4($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$6,$6,3
	addu	$6,$6,$17
	sll	$4,$4,3
	addu	$4,$4,$17
 #APP
	lwc2 $0, 208($6)
	lwc2 $1, 212($6)
	lwc2 $2, 208($4)
	lwc2 $3, 212($4)
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
	beq	$2,$0,$L973
	subu	$3,$0,$3
$L973:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$2,212($6)
	lhu	$3,212($4)
	lhu	$4,212($5)
	sh	$2,176($17)
	sh	$3,184($17)
	sh	$4,192($17)
 #APP
 #NO_APP
	lh	$3,16($17)
	lh	$2,196($17)
	lh	$4,18($17)
	slt	$2,$3,$2
	beq	$2,$0,$L975
	lh	$2,200($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L975
	lh	$2,204($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L975:
	lh	$2,196($17)
	#nop
	bgez	$2,$L976
	lh	$2,200($17)
	#nop
	bgez	$2,$L976
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L976:
	lh	$2,198($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L977
	lh	$2,202($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L977
	lh	$2,206($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L977:
	lh	$2,198($17)
	#nop
	bgez	$2,$L978
	lh	$2,202($17)
	#nop
	bgez	$2,$L978
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L978:
	lh	$2,176($17)
	#nop
	bgez	$2,$L979
	lh	$2,184($17)
	#nop
	bgez	$2,$L979
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L979:
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
	bltz	$3,$L956
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1102
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L982
	li	$4,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$4,38			# 0x00000026
$L982:
	sw	$3,4($7)
	sb	$4,7($7)
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0002
	beq	$2,$0,$L983
	lhu	$2,0($8)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L983
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
	j	$L1098
	sh	$2,22($7)
	.set	macro
	.set	reorder

$L983:
	lbu	$2,2($8)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,14($3)
	#nop
	andi	$2,$4,0x007f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L985
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$5,1014($17)
	lbu	$6,1015($17)
	beq	$2,$0,$L986
	lbu	$5,1022($17)
	lbu	$6,1023($17)
$L986:
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($7)
	sh	$3,22($7)
$L1098:
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
	j	$L956
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L985:
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
	j	$L956
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L955:
	addu	$23,$17,982
	addu	$22,$17,998
	addu	$21,$17,984
	addu	$20,$17,990
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$19,$2,2
	addu	$18,$18,-1
$L1100:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L941
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
	beq	$2,$0,$L992
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
$L992:
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
	j	$L1100
	addu	$18,$18,-1
	.set	macro
	.set	reorder

$L993:
	li	$11,38			# 0x00000026
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$10,$2,2
$L994:
	addu	$18,$18,-1
$L1103:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L941
	addu	$10,$10,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$6,$2,$10
	lbu	$9,5($6)
	lbu	$8,3($6)
	lw	$2,4($17)
	lbu	$7,4($6)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$9,$9,3
	addu	$9,$9,$17
	sll	$8,$8,3
	addu	$8,$8,$17
	sll	$7,$7,3
	addu	$7,$7,$17
 #APP
	lwc2 $0, 208($8)
	lwc2 $1, 212($8)
	lwc2 $2, 208($7)
	lwc2 $3, 212($7)
	lwc2 $4, 208($9)
	lwc2 $5, 212($9)
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
	beq	$2,$0,$L999
	subu	$3,$0,$3
$L999:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$2,212($8)
	lhu	$3,212($7)
	lhu	$4,212($9)
	sh	$2,176($17)
	sh	$3,184($17)
	sh	$4,192($17)
 #APP
 #NO_APP
	lh	$3,16($17)
	lh	$2,196($17)
	lh	$4,18($17)
	slt	$2,$3,$2
	beq	$2,$0,$L1001
	lh	$2,200($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L1001
	lh	$2,204($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1001:
	lh	$2,196($17)
	#nop
	bgez	$2,$L1002
	lh	$2,200($17)
	#nop
	bgez	$2,$L1002
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1002:
	lh	$2,198($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1003
	lh	$2,202($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1003
	lh	$2,206($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1003:
	lh	$2,198($17)
	#nop
	bgez	$2,$L1004
	lh	$2,202($17)
	#nop
	bgez	$2,$L1004
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1004:
	lh	$2,176($17)
	#nop
	bgez	$2,$L1005
	lh	$2,184($17)
	#nop
	bgez	$2,$L1005
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1005:
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
	bltz	$3,$L994
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1103
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	lhu	$2,0($6)
	#nop
	andi	$2,$2,0x03f3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1008
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lw	$2,116($17)
	#nop
	beq	$2,$0,$L1008
	lbu	$3,3($6)
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
	lbu	$3,4($6)
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
	lbu	$3,5($6)
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
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,84($17)
	lw	$15,88($17)
	lw	$16,92($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,72($17)
	lw	$15,76($17)
	lw	$16,80($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,144($17)
	#nop
	sw	$2,4($5)
	sb	$11,7($5)
	lhu	$2,118($17)
	lhu	$3,122($17)
	sh	$2,14($5)
	sh	$3,22($5)
 #APP
	lbu	$14,116($17)
	lbu	$15,117($17)
	lbu	$13,132($17)
	addiu	$14,$14,64
	addu	$15,$15,$13
	lbu	$12,174($17)
	lbu	$13,176($17)
	addu	$12,$12,$14
	sb	$12,12($5)
	addu	$13,$13,$15
	sb	$13,13($5)
	lbu	$12,182($17)
	lbu	$13,184($17)
	addu	$12,$12,$14
	sb	$12,20($5)
	addu	$13,$13,$15
	sb	$13,21($5)
	lbu	$12,190($17)
	lbu	$13,192($17)
	addu	$12,$12,$14
	sb	$12,28($5)
	addu	$13,$13,$15
	sb	$13,29($5)
 #NO_APP
$L1008:
	lw	$2,100($17)
	#nop
	beq	$2,$0,$L1009
 #APP
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,144($17)
	#nop
	sw	$2,4($5)
	sb	$11,7($5)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($5)
	sh	$3,22($5)
 #APP
	lbu	$14,100($17)
	lbu	$15,101($17)
	addiu	$14,$14,64
	lbu	$12,214($8)
	lbu	$13,215($8)
	addu	$12,$12,$14
	sb	$12,12($5)
	addu	$13,$13,$15
	sb	$13,13($5)
	lbu	$12,214($7)
	lbu	$13,215($7)
	addu	$12,$12,$14
	sb	$12,20($5)
	addu	$13,$13,$15
	sb	$13,21($5)
	lbu	$12,214($9)
	lbu	$13,215($9)
	addu	$12,$12,$14
	sb	$12,28($5)
	addu	$13,$13,$15
	sb	$13,29($5)
 #NO_APP
$L1009:
 #APP
	lw	$5,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$5,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$5,8
	sw	$14,0($5)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($5)
	sw	$3,16($5)
	sw	$4,24($5)
	lw	$2,140($17)
	#nop
	sw	$2,4($5)
	li	$2,36			# 0x00000024
	sb	$2,7($5)
	lbu	$2,2($6)
	lw	$3,96($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$2,2($3)
	lhu	$3,6($3)
	sh	$2,14($5)
	sh	$3,22($5)
	lhu	$2,6($6)
	lhu	$3,8($6)
	lhu	$4,10($6)
	sh	$2,12($5)
	sh	$3,20($5)
	.set	noreorder
	.set	nomacro
	j	$L994
	sh	$4,28($5)
	.set	macro
	.set	reorder

$L1010:
	lui	$2,%hi(DrawC_gOverlay) # high
	addiu	$16,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$15,$2,2
$L1011:
	addu	$18,$18,-1
$L1104:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L941
	addu	$15,$15,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$15
	lbu	$5,5($8)
	lbu	$6,3($8)
	lw	$2,4($17)
	lbu	$4,4($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$5,$5,3
	addu	$5,$5,$17
	sll	$6,$6,3
	addu	$6,$6,$17
	sll	$4,$4,3
	addu	$4,$4,$17
 #APP
	lwc2 $0, 208($6)
	lwc2 $1, 212($6)
	lwc2 $2, 208($4)
	lwc2 $3, 212($4)
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
	beq	$2,$0,$L1028
	subu	$3,$0,$3
$L1028:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$2,212($6)
	lhu	$3,212($4)
	lhu	$4,212($5)
	sh	$2,176($17)
	sh	$3,184($17)
	sh	$4,192($17)
 #APP
 #NO_APP
	lh	$3,16($17)
	lh	$2,196($17)
	lh	$4,18($17)
	slt	$2,$3,$2
	beq	$2,$0,$L1030
	lh	$2,200($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L1030
	lh	$2,204($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1030:
	lh	$2,196($17)
	#nop
	bgez	$2,$L1031
	lh	$2,200($17)
	#nop
	bgez	$2,$L1031
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1031:
	lh	$2,198($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1032
	lh	$2,202($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1032
	lh	$2,206($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1032:
	lh	$2,198($17)
	#nop
	bgez	$2,$L1033
	lh	$2,202($17)
	#nop
	bgez	$2,$L1033
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1033:
	lh	$2,176($17)
	#nop
	bgez	$2,$L1034
	lh	$2,184($17)
	#nop
	bgez	$2,$L1034
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1034:
 #APP
	nop
	nop
	.word 0x4B58002D
	swc2 $7, 60($17)
 #NO_APP
	lbu	$2,2($8)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$16
	lhu	$2,0($2)
	#nop
	sll	$6,$2,16
	sra	$5,$6,16
	beq	$5,$0,$L1035
	lw	$3,60($17)
	lh	$2,0($8)
	lhu	$4,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1036
	andi	$5,$5,0x00ff
	.set	macro
	.set	reorder

	sra	$5,$6,24
$L1036:
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	andi	$2,$5,0x0040
	beq	$2,$0,$L1037
	addu	$3,$3,-2
$L1037:
	.set	noreorder
	.set	nomacro
	bltz	$3,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	andi	$2,$4,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1040
	andi	$11,$4,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$11,4
	and	$5,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1040
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L1040
$L1044:
	sra	$5,$5,2
	andi	$2,$5,0x0003
	beq	$2,$0,$L1044
$L1040:
	.set	noreorder
	.set	nomacro
	j	$L1046
	sw	$3,60($17)
	.set	macro
	.set	reorder

$L1035:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L1011
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lhu	$2,0($8)
	#nop
	andi	$11,$2,0x0fff
$L1046:
	andi	$4,$5,0x0003
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1049
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
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	bne	$2,$0,$L1050
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$10,140($17)
$L1050:
	andi	$2,$11,0x0001
	beq	$2,$0,$L1051
	li	$6,38			# 0x00000026
$L1051:
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
	j	$L1011
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L1049:
 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	bne	$2,$0,$L1053
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$9,140($17)
$L1053:
	andi	$2,$11,0x0001
	beq	$2,$0,$L1054
	li	$6,38			# 0x00000026
$L1054:
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
	j	$L1011
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L1055:
	addiu	$22,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$20,$2,2
$L1056:
	addu	$18,$18,-1
$L1105:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L941
	addu	$20,$20,-12
	.set	macro
	.set	reorder

	lw	$25,88($sp)
	#nop
	lw	$2,24($25)
	lw	$3,8($17)
	addu	$8,$2,$20
	lbu	$24,5($8)
	lbu	$11,3($8)
	lw	$2,4($17)
	lbu	$10,4($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	sll	$24,$24,3
	addu	$24,$24,$17
	sll	$11,$11,3
	addu	$11,$11,$17
	sll	$10,$10,3
	addu	$10,$10,$17
 #APP
	lwc2 $0, 208($11)
	lwc2 $1, 212($11)
	lwc2 $2, 208($10)
	lwc2 $3, 212($10)
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
	beq	$2,$0,$L1061
	subu	$3,$0,$3
$L1061:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
 #APP
	swc2 $12, 196($17)
	swc2 $13, 200($17)
	swc2 $14, 204($17)
 #NO_APP
	lhu	$2,212($11)
	lhu	$3,212($10)
	lhu	$4,212($24)
	sh	$2,176($17)
	sh	$3,184($17)
	sh	$4,192($17)
 #APP
 #NO_APP
	lh	$3,16($17)
	lh	$2,196($17)
	lh	$4,18($17)
	slt	$2,$3,$2
	beq	$2,$0,$L1063
	lh	$2,200($17)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L1063
	lh	$2,204($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1063:
	lh	$2,196($17)
	#nop
	bgez	$2,$L1064
	lh	$2,200($17)
	#nop
	bgez	$2,$L1064
	lh	$2,204($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1064:
	lh	$2,198($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1065
	lh	$2,202($17)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1065
	lh	$2,206($17)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1065:
	lh	$2,198($17)
	#nop
	bgez	$2,$L1066
	lh	$2,202($17)
	#nop
	bgez	$2,$L1066
	lh	$2,206($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1066:
	lh	$2,176($17)
	#nop
	bgez	$2,$L1067
	lh	$2,184($17)
	#nop
	bgez	$2,$L1067
	lh	$2,192($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1067:
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
	lhu	$2,0($2)
	#nop
	sll	$5,$2,16
	sra	$6,$5,16
	beq	$6,$0,$L1068
	lw	$4,60($17)
	lh	$2,0($8)
	lhu	$3,0($8)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1069
	andi	$6,$6,0x00ff
	.set	macro
	.set	reorder

	sra	$6,$5,24
$L1069:
	lw	$2,64($17)
	#nop
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lw	$2,136($17)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	andi	$2,$3,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1072
	andi	$9,$3,0x0fff
	.set	macro
	.set	reorder

	srl	$2,$9,4
	and	$6,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L1072
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

	bne	$2,$0,$L1072
$L1076:
	sra	$6,$6,2
	andi	$2,$6,0x0003
	beq	$2,$0,$L1076
$L1072:
	.set	noreorder
	.set	nomacro
	j	$L1078
	sw	$4,60($17)
	.set	macro
	.set	reorder

$L1068:
	lw	$3,60($17)
	lw	$2,64($17)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L1056
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
	lhu	$2,0($8)
	#nop
	andi	$9,$2,0x0fff
$L1078:
	lw	$25,96($sp)
	#nop
	andi	$2,$25,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1081
	andi	$2,$9,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1105
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L1081:
	andi	$2,$9,0x03f3
	beq	$2,$0,$L1083
	lw	$2,116($17)
	#nop
	beq	$2,$0,$L1083
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
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,84($17)
	lw	$15,88($17)
	lw	$16,92($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,72($17)
	lw	$15,76($17)
	lw	$16,80($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
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
 #APP
	lbu	$14,116($17)
	lbu	$15,117($17)
	lbu	$13,132($17)
	addiu	$14,$14,64
	addu	$15,$15,$13
	lbu	$12,174($17)
	lbu	$13,176($17)
	addu	$12,$12,$14
	sb	$12,12($7)
	addu	$13,$13,$15
	sb	$13,13($7)
	lbu	$12,182($17)
	lbu	$13,184($17)
	addu	$12,$12,$14
	sb	$12,20($7)
	addu	$13,$13,$15
	sb	$13,21($7)
	lbu	$12,190($17)
	lbu	$13,192($17)
	addu	$12,$12,$14
	sb	$12,28($7)
	addu	$13,$13,$15
	sb	$13,29($7)
 #NO_APP
$L1083:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1106
	andi	$2,$6,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$6,0x0001
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1085
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,152($17)
	.set	noreorder
	.set	nomacro
	j	$L1101
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L1085:
	andi	$2,$9,0x0004
	beq	$2,$0,$L1087
	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L1101
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L1087:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L1101:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
 #APP
	lbu	$14,100($17)
	lbu	$15,101($17)
	addiu	$14,$14,64
	lbu	$12,214($11)
	lbu	$13,215($11)
	addu	$12,$12,$14
	sb	$12,12($7)
	addu	$13,$13,$15
	sb	$13,13($7)
	lbu	$12,214($10)
	lbu	$13,215($10)
	addu	$12,$12,$14
	sb	$12,20($7)
	addu	$13,$13,$15
	sb	$13,21($7)
	lbu	$12,214($24)
	lbu	$13,215($24)
	addu	$12,$12,$14
	sb	$12,28($7)
	addu	$13,$13,$15
	sb	$13,29($7)
 #NO_APP
	andi	$2,$6,0x0003
$L1106:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1089
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
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L1090
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L1090:
	sw	$3,4($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1091
	sb	$5,7($7)
	.set	macro
	.set	reorder

	ori	$2,$5,0x0002
	sb	$2,7($7)
$L1091:
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
	j	$L1056
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L1089:
 #APP
	lw	$7,4($17)
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L1093
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L1093:
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
	j	$L1056
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L941:
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
	beq	$2,$0,$L1108
	move	$21,$7
	.set	macro
	.set	reorder

	move	$7,$3
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
	li	$10,-1			# 0xffffffff
	addu	$9,$17,172
	addu	$8,$17,156
	addu	$6,$17,215
	addu	$5,$7,4
$L1109:
	addu	$24,$24,-1
	beq	$24,$10,$L1108
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
	bgez	$2,$L1113
	subu	$2,$0,$2
$L1113:
	addu	$5,$5,6
	addu	$7,$7,6
	sb	$3,-1($6)
	sb	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L1109
	addu	$6,$6,8
	.set	macro
	.set	reorder

$L1108:
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
$L1114:
	addu	$24,$24,-1
	.set	noreorder
	.set	nomacro
	beq	$24,$9,$L1115
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
	j	$L1114
	addu	$8,$8,8
	.set	macro
	.set	reorder

$L1115:
	lhu	$24,2($19)
	addiu	$18,$2,%lo(DrawC_gOverlay) # low
	sll	$2,$24,1
	addu	$2,$2,$24
	sll	$25,$2,2
$L1118:
	addu	$24,$24,-1
$L1162:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$24,$2,$L1107
	addu	$25,$25,-12
	.set	macro
	.set	reorder

	lw	$2,24($19)
	lw	$3,8($17)
	addu	$8,$2,$25
	lbu	$10,3($8)
	lbu	$9,4($8)
	lw	$2,4($17)
	lbu	$6,5($8)
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1162
	addu	$24,$24,-1
	.set	macro
	.set	reorder

	addu	$24,$24,1
	sll	$10,$10,3
	addu	$10,$10,$17
	sll	$9,$9,3
	addu	$9,$9,$17
	sll	$6,$6,3
	addu	$6,$6,$17
 #APP
	lwc2 $0, 208($10)
	lwc2 $1, 212($10)
	lwc2 $2, 208($9)
	lwc2 $3, 212($9)
	lwc2 $4, 208($6)
	lwc2 $5, 212($6)
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
	beq	$2,$0,$L1135
	subu	$3,$0,$3
$L1135:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1162
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
	bltz	$3,$L1118
	sw	$3,60($17)
	.set	macro
	.set	reorder

	lw	$2,136($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1162
	addu	$24,$24,-1
	.set	macro
	.set	reorder

	addu	$24,$24,1
	lbu	$2,2($8)
	lhu	$4,0($8)
 #APP
 #NO_APP
	sll	$2,$2,1
	addu	$2,$2,$18
	lhu	$2,0($2)
	#nop
	sll	$3,$2,16
	sra	$5,$3,16
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1139
	andi	$11,$4,0x0fff
	.set	macro
	.set	reorder

	sll	$2,$4,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1140
	andi	$5,$5,0x003f
	.set	macro
	.set	reorder

	sra	$5,$3,24
$L1140:
	andi	$2,$11,0x03f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1139
	srl	$2,$11,4
	.set	macro
	.set	reorder

	and	$5,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1139
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1163
	andi	$2,$20,0x0001
	.set	macro
	.set	reorder

$L1144:
	sra	$5,$5,2
	andi	$2,$5,0x0003
	beq	$2,$0,$L1144
$L1139:
	andi	$2,$20,0x0001
$L1163:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1164
	andi	$2,$5,0x0003
	.set	macro
	.set	reorder

 #APP
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,84($17)
	lw	$15,88($17)
	lw	$16,92($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
 #NO_APP
	lw	$7,4($17)
 #APP
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
	lw	$12,4($17)
	lw	$13,60($17)
	lw	$14,56($17)
	addiu	$15,$12,12
	sll	$13,$13,2
	addu	$14,$14,$13
	sw	$15,4($17)
	lw	$13,72($17)
	lw	$15,76($17)
	lw	$16,80($17)
	sw	$13,0($12)
	sw	$15,4($12)
	sw	$16,8($12)
	lwl	$13,2($14)
	sll	$15,$12,8
	swl	$13,2($12)
	swl	$15,2($14)
 #NO_APP
	lw	$2,196($17)
	lw	$3,200($17)
	lw	$4,204($17)
	sw	$2,8($7)
	andi	$2,$11,0x0004
	sw	$3,16($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1148
	sw	$4,24($7)
	.set	macro
	.set	reorder

	lw	$2,148($17)
	.set	noreorder
	.set	nomacro
	j	$L1161
	sw	$2,4($7)
	.set	macro
	.set	reorder

$L1148:
	lw	$2,144($17)
	#nop
	sw	$2,4($7)
$L1161:
	li	$2,38			# 0x00000026
	sb	$2,7($7)
	lhu	$2,102($17)
	lhu	$3,106($17)
	sh	$2,14($7)
	sh	$3,22($7)
 #APP
	lbu	$14,100($17)
	lbu	$15,101($17)
	addiu	$14,$14,64
	lbu	$12,214($10)
	lbu	$13,215($10)
	addu	$12,$12,$14
	sb	$12,12($7)
	addu	$13,$13,$15
	sb	$13,13($7)
	lbu	$12,214($9)
	lbu	$13,215($9)
	addu	$12,$12,$14
	sb	$12,20($7)
	addu	$13,$13,$15
	sb	$13,21($7)
	lbu	$12,214($6)
	lbu	$13,215($6)
	addu	$12,$12,$14
	sb	$12,28($7)
	addu	$13,$13,$15
	sb	$13,29($7)
 #NO_APP
	andi	$2,$5,0x0003
$L1164:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1150
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
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$2,$0,$L1151
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L1151:
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
	j	$L1160
	sh	$3,14($7)
	.set	macro
	.set	reorder

$L1150:
	lw	$7,4($17)
 #APP
	lw	$12,60($17)
	lw	$13,56($17)
	addiu	$14,$7,32
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4($17)
	lwl	$14,2($13)
	lui	$12,0x0700
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,$7,8
	sw	$14,0($7)
	swl	$12,2($13)
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
	beq	$3,$0,$L1154
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	li	$5,38			# 0x00000026
$L1154:
	sw	$2,4($7)
	andi	$2,$20,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1156
	sb	$5,7($7)
	.set	macro
	.set	reorder

	bne	$3,$0,$L1156
	lbu	$2,2($8)
	lw	$3,96($17)
	lbu	$5,1006($17)
	lbu	$6,1007($17)
	sll	$2,$2,4
	addu	$3,$3,$2
	lhu	$4,2($3)
	lhu	$2,6($3)
	sh	$4,14($7)
$L1160:
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
	j	$L1118
	sb	$4,29($7)
	.set	macro
	.set	reorder

$L1156:
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
	j	$L1118
	sh	$4,28($7)
	.set	macro
	.set	reorder

$L1107:
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
$L1166:
	addu	$21,$21,-1
$L1187:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$21,$2,$L1165
	addu	$23,$23,-12
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	lw	$2,24($8)
	#nop
	addu	$17,$2,$23
 #APP
 #NO_APP
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
	beq	$2,$0,$L1170
	subu	$3,$0,$3
$L1170:
	.set	noreorder
	.set	nomacro
	blez	$3,$L1187
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
	bltz	$3,$L1166
	sw	$3,60($18)
	.set	macro
	.set	reorder

	lw	$2,136($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1187
	addu	$21,$21,-1
	.set	macro
	.set	reorder

	addu	$21,$21,1
	lw	$8,84($sp)
	#nop
	andi	$19,$8,0xffbf
	lw	$8,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$8,$L1175
	sll	$2,$8,1
	.set	macro
	.set	reorder

	lui	$8,%hi(DrawC_gOverlay) # high
	addiu	$8,$8,%lo(DrawC_gOverlay) # low
	addu	$2,$2,$8
	lhu	$2,0($2)
	#nop
	sll	$4,$2,16
 #APP
 #NO_APP
	lh	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1176
	sra	$3,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1177
	sra	$3,$4,24
	.set	macro
	.set	reorder

$L1176:
	andi	$3,$3,0x00ff
$L1177:
 #APP
 #NO_APP
	lw	$8,84($sp)
	#nop
	andi	$2,$8,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1178
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1188
	andi	$2,$3,0x0081
	.set	macro
	.set	reorder

	lui	$8,%hi(DrawC_gOverlay) # high
	addiu	$8,$8,%lo(DrawC_gOverlay) # low
	lhu	$2,48($8)
	#nop
	sll	$4,$2,16
 #APP
 #NO_APP
	lh	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1179
	sra	$3,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1180
	sra	$3,$4,24
	.set	macro
	.set	reorder

$L1179:
	andi	$3,$3,0x00ff
$L1180:
 #APP
 #NO_APP
$L1178:
	andi	$2,$3,0x0081
$L1188:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1187
	addu	$21,$21,-1
	.set	macro
	.set	reorder

	addu	$21,$21,1
	andi	$3,$3,0x0003
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1182
	andi	$16,$19,0x00ff
	.set	macro
	.set	reorder

	lw	$8,84($sp)
	#nop
	andi	$2,$8,0x7f00
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1189
	move	$4,$16
	.set	macro
	.set	reorder

	sra	$19,$19,8
$L1175:
	andi	$16,$19,0x00ff
$L1182:
	move	$4,$16
$L1189:
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
	jal	Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$8,92($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$8,$L1184
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L1190
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L1184
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L1190:
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L1183
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	beq	$16,$2,$L1183
$L1184:
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
	jal	Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L1183:
	.set	noreorder
	.set	nomacro
	j	$L1166
	sw	$20,0($18)
	.set	macro
	.set	reorder

$L1165:
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
	beq	$2,$0,$L1192
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuPixmap+4) # high
	lw	$18,%lo(gMenuPixmap+4)($2)
$L1192:
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
	beq	$2,$0,$L1191
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
	bltz	$3,$L1191
	sw	$3,60($16)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1191
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
$L1191:
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
	beq	$2,$0,$L1206
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
	beq	$2,$0,$L1198
	.set	noreorder
	.set	nomacro
	j	$L1199
	sw	$0,60($9)
	.set	macro
	.set	reorder

$L1198:
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
	bltz	$3,$L1206
	sw	$3,60($9)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	bne	$2,$0,$L1206
$L1199:
	lh	$2,4($10)
	#nop
	bgez	$2,$L1203
	lh	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1205
	li	$5,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lh	$2,4($6)
	#nop
	bgez	$2,$L1205
	lh	$2,4($7)
	#nop
	bltz	$2,$L1206
$L1203:
	li	$5,16711680			# 0x00ff0000
$L1205:
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
$L1206:
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
	beq	$2,$0,$L1208
	sw	$17,44($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuPixmap+4) # high
	lw	$fp,%lo(gMenuPixmap+4)($2)
$L1208:
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
$L1211:
	slt	$2,$7,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1212
	addu	$5,$7,1
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	bne	$5,$2,$L1215
	move	$5,$0
$L1215:
	lw	$2,4($18)
	lw	$3,8($18)
	#nop
	sltu	$2,$2,$3
	beq	$2,$0,$L1216
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
$L1216:
	addu	$6,$6,6
	.set	noreorder
	.set	nomacro
	j	$L1211
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L1212:
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
	beq	$3,$0,$L1218
	sw	$20,80($sp)
	.set	macro
	.set	reorder

	jal	gettick
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1252
	sra	$2,$2,8
	.set	macro
	.set	reorder

	addu	$2,$3,255
	sra	$2,$2,8
$L1252:
	sll	$2,$2,8
	subu	$2,$3,$2
	sra	$3,$2,3
	lw	$2,DrawC_gMenuLightsDirection
	li	$4,-1			# 0xffffffff
	sw	$3,48($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1221
	sw	$4,56($sp)
	.set	macro
	.set	reorder

	addu	$2,$3,16
	andi	$2,$2,0x001f
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L1222
	sw	$4,60($sp)
	.set	macro
	.set	reorder

$L1221:
	li	$2,32			# 0x00000020
	subu	$2,$2,$3
	sw	$2,52($sp)
	li	$2,1			# 0x00000001
	sw	$2,60($sp)
$L1222:
	li	$3,-1			# 0xffffffff
	li	$8,31			# 0x0000001f
	addu	$2,$sp,47
$L1223:
	sb	$3,0($2)
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	bgez	$8,$L1223
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	move	$8,$0
	addu	$10,$sp,16
	addu	$9,$sp,56
	addu	$6,$sp,48
$L1227:
	move	$7,$0
	move	$5,$6
	move	$4,$9
$L1230:
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
	beq	$2,$0,$L1233
	sb	$7,0($3)
$L1233:
	addu	$7,$7,1
	slt	$2,$7,5
	bne	$2,$0,$L1230
	addu	$9,$9,4
	addu	$8,$8,1
	slt	$2,$8,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1227
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
$L1236:
	slt	$2,$8,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1218
	sll	$2,$8,1
	.set	macro
	.set	reorder

	addu	$5,$2,2
	li	$2,64			# 0x00000040
	bne	$5,$2,$L1240
	move	$5,$0
$L1240:
	lw	$2,4($16)
	lw	$3,8($16)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1218
	move	$7,$0
	.set	macro
	.set	reorder

	lhu	$2,0($10)
	lhu	$3,2($10)
	lhu	$4,4($10)
 #APP
 #NO_APP
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
	lui	$2,%hi(D_8011F4B4) # high
	sh	$4,190($16)
	sh	$5,192($16)
	lhu	$4,0($3)
	lhu	$5,2($3)
	lhu	$3,4($3)
	addiu	$13,$2,%lo(D_8011F4B4) # low
	sh	$4,976($16)
	sh	$5,978($16)
	sh	$3,980($16)
$L1242:
	slt	$2,$7,2
	beq	$2,$0,$L1238
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L1253
	addu	$2,$16,172
	.set	macro
	.set	reorder

	lb	$2,0($9)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1244
	addu	$2,$16,172
	.set	macro
	.set	reorder

$L1253:
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
	bne	$7,$0,$L1248
	li	$2,3145728			# 0x00300000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1251
	ori	$2,$2,0x0a00
	.set	macro
	.set	reorder

$L1248:
	lb	$2,0($9)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$13
	lw	$2,0($2)
$L1251:
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
$L1244:
	.set	noreorder
	.set	nomacro
	j	$L1242
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L1238:
	addu	$11,$11,12
	addu	$10,$10,12
	.set	noreorder
	.set	nomacro
	j	$L1236
	addu	$8,$8,1
	.set	macro
	.set	reorder

$L1218:
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
