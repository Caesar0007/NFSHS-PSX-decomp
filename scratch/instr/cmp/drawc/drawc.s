	.file	1 "C:\\\\Temp\\\\nfs4-wt46-a10\\\\recon\\\\game\\\\psx\\\\drawc.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	ChangeTPage__FPUsi
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
	.align	2
	.globl	DrawC_SetEnviroment__Fv
	.text
	.ent	DrawC_SetEnviroment__Fv
DrawC_SetEnviroment__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DrawC_SetEnviroment__Fv
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
	.text
	.ent	DrawC_ReadLightingData__Fv
DrawC_ReadLightingData__Fv:
	.frame	$sp,304,$31		# vars= 264, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,304
	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+24) # high
	lw	$6,%lo(Paths_Paths+24)($2)
	lui	$2,%hi(GameSetup_gData+60) # high
	lui	$5,%hi($LC0) # high
	lw	$7,%lo(GameSetup_gData+60)($2)
	addiu	$5,$5,%lo($LC0) # low
	sw	$31,300($sp)
	sw	$20,296($sp)
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
	move	$20,$2
	.set	noreorder
	.set	nomacro
	jal	Risk_ReadNextValue__FPPc
	sw	$20,272($sp)
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
	blez	$3,$L364
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	li	$19,32767			# 0x00007fff
	move	$16,$17
$L366:
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
	bgez	$4,$L365
	sh	$3,4($5)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L364
	sh	$19,0($5)
	.set	macro
	.set	reorder

$L365:
	lw	$2,DrawC_gEnvMapMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L366
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L364:
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
	blez	$3,$L370
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$16
	li	$19,32767			# 0x00007fff
	move	$16,$17
$L372:
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
	bgez	$4,$L371
	sh	$3,4($5)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L370
	sh	$19,0($5)
	.set	macro
	.set	reorder

$L371:
	lw	$2,DrawC_gShadowMax
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L372
	addu	$16,$16,6
	.set	macro
	.set	reorder

$L370:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$31,300($sp)
	lw	$20,296($sp)
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
	.align	2
	.globl	DrawC_ReadeMapData__Fv
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
	.align	2
	.globl	DrawC_BuildRenderingData__Fv
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
	.align	2
	.globl	DrawC_KillRenderingData__Fv
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
	.align	2
	.globl	DrawC_NightHeadlight__FP8Car_tObj
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
	beq	$2,$0,$L379
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
$L379:
	lbu	$2,Night_gDrawLightning
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L378
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
	bne	$2,$0,$L381
	move	$3,$4
	.set	macro
	.set	reorder

	li	$8,255			# 0x000000ff
$L381:
	slt	$2,$5,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L384
	slt	$2,$4,256
	.set	macro
	.set	reorder

	li	$7,255			# 0x000000ff
$L384:
	bne	$2,$0,$L383
	li	$3,255			# 0x000000ff
$L383:
	sb	$8,104($sp)
	sb	$7,1($6)
	sb	$3,2($6)
$L378:
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
	bne	$2,$0,$L386
	move	$19,$6
	.set	macro
	.set	reorder

	lh	$2,2236($17)
	#nop
	bne	$2,$3,$L385
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
	beq	$2,$0,$L388
	sb	$3,2227($17)
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sb	$2,2227($17)
$L388:
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
	beq	$2,$3,$L385
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
	beq	$2,$0,$L390
	andi	$3,$18,0x0008
	.set	macro
	.set	reorder

	lhu	$2,2112($17)
	#nop
	andi	$2,$2,0x0008
	beq	$3,$2,$L391
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
	bne	$2,$0,$L392
	addu	$4,$sp,16
	lui	$5,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L395
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

$L392:
	addu	$4,$sp,16
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
$L395:
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

$L391:
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
	j	$L394
$L390:
	move	$5,$0
	lw	$4,2180($17)
	lh	$6,2184($17)
	andi	$2,$18,0x0007
	sw	$2,Texture_CarColor
$L394:
	jal	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
$L386:
	sh	$18,2112($17)
$L385:
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
	.align	2
	.globl	DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache
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
	bne	$2,$0,$L397
	sra	$3,$16,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$3,$L399
	sw	$3,64($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	beq	$2,$0,$L400
$L399:
	.set	noreorder
	.set	nomacro
	j	$L492
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L397:
	sw	$0,64($19)
$L400:
	lw	$4,2168($18)
	lw	$2,64($19)
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L401
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
	j	$L402
$L401:
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
$L402:
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
$L403:
	sh	$0,0($2)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L403
	addu	$2,$2,-2
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L454
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,536($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L408
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L493
	ori	$3,$3,0x0001
	.set	macro
	.set	reorder

$L408:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L409
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0002
	ori	$3,$3,0x0002
$L493:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L409:
	lw	$3,544($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L411
	lui	$4,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	j	$L494
	ori	$3,$3,0x0100
	.set	macro
	.set	reorder

$L411:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L412
	addiu	$5,$4,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($4)
	lhu	$3,4($5)
	ori	$2,$2,0x0200
	ori	$3,$3,0x0200
$L494:
	sh	$2,%lo(DrawC_gOverlay)($4)
	sh	$3,4($5)
$L412:
	lw	$3,548($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L414
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L495
	ori	$2,$2,0x0400
	.set	macro
	.set	reorder

$L414:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L415
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0800
$L495:
	sh	$2,4($3)
$L415:
	lw	$3,552($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L417
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0100
	.set	noreorder
	.set	nomacro
	j	$L496
	ori	$4,$4,0x1000
	.set	macro
	.set	reorder

$L417:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L418
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0200
	ori	$4,$4,0x2000
$L496:
	sh	$3,2($2)
	sh	$4,4($2)
$L418:
	lw	$3,560($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L420
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0001
	.set	noreorder
	.set	nomacro
	j	$L497
	ori	$4,$4,0x0010
	.set	macro
	.set	reorder

$L420:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L421
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,2($2)
	lhu	$4,4($2)
	ori	$3,$3,0x0002
	ori	$4,$4,0x0020
$L497:
	sh	$3,2($2)
	sh	$4,4($2)
$L421:
	lw	$3,564($18)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	beq	$2,$0,$L423
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L498
	ori	$2,$2,0x0004
	.set	macro
	.set	reorder

$L423:
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L424
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,4($3)
	#nop
	ori	$2,$2,0x0008
$L498:
	sh	$2,4($3)
$L424:
	lw	$3,568($18)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L426
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,8($3)
	#nop
	ori	$2,$2,0x0101
	sh	$2,8($3)
$L426:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L427
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L500
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
$L500:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L427
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L427:
	lbu	$2,1090($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L430
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($3)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L501
	andi	$2,$4,0x0100
	.set	macro
	.set	reorder

	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($3)
	andi	$2,$4,0x0100
$L501:
	bne	$2,$0,$L430
	lhu	$2,52($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($3)
$L430:
	lhu	$3,2228($18)
	#nop
	andi	$2,$3,0x0011
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L433
	andi	$2,$3,0x0040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L435
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L434
$L435:
	lui	$3,%hi(DrawC_gOverlay) # high
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,58($3)
$L434:
	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L502
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	bne	$2,$0,$L433
$L502:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
$L433:
	lhu	$2,2230($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L438
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$4,2($5)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L503
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
$L503:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L438
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L438:
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L504
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
	beq	$2,$0,$L442
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0040
	sh	$2,56($3)
$L442:
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L443
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L444
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,54($3)
$L444:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L443
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x0081
	sh	$2,56($3)
$L443:
	xori	$5,$5,0x0001
	sll	$2,$5,1
	addu	$4,$18,$2
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L446
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x4000
	sh	$2,56($3)
$L446:
	lhu	$2,2232($4)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L447
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L448
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	.set	macro
	.set	reorder

	lhu	$2,54($3)
	#nop
	ori	$2,$2,0x8000
	sh	$2,54($3)
$L448:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L505
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,56($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,56($3)
$L447:
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L505:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$2,0($2)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L506
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
	bne	$2,$0,$L507
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
$L507:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L506
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
	.set	macro
	.set	reorder

	lhu	$2,48($4)
	#nop
	andi	$2,$2,0xff00
	or	$2,$3,$2
	sh	$2,56($4)
	lui	$2,%hi(R3DCar_SignalBrakeFlare) # high
$L506:
	addiu	$2,$2,%lo(R3DCar_SignalBrakeFlare) # low
	addu	$2,$17,$2
	lbu	$3,0($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L454
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(DrawC_gOverlay) # low
	lhu	$3,56($2)
	lh	$4,48($2)
	sh	$3,48($2)
	sh	$4,56($2)
$L454:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L457
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

$L504:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$6,54($5)
	lhu	$4,56($5)
	lh	$3,8($5)
	ori	$2,$6,0x0002
	sh	$2,54($5)
	ori	$2,$4,0x0200
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L458
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
	beq	$2,$0,$L459
	ori	$2,$6,0x0083
	.set	macro
	.set	reorder

	sh	$2,54($5)
	ori	$2,$4,0x0281
	sh	$2,56($5)
$L459:
	lhu	$2,2234($18)
	#nop
	andi	$2,$2,0x000f
	sll	$2,$2,1
	addu	$2,$2,$7
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L458
	li	$2,-32512			# 0xffff8100
	.set	macro
	.set	reorder

	lhu	$3,54($5)
	lhu	$4,56($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,54($5)
	sh	$4,56($5)
$L458:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L508
	lui	$6,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lw	$2,1392($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L509
	addu	$4,$sp,24
	.set	macro
	.set	reorder

$L508:
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
	bne	$2,$0,$L510
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
$L510:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L511
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L512
	ori	$2,$5,0x0081
	.set	macro
	.set	reorder

	lhu	$2,%lo(DrawC_gOverlay)($6)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L511
	lui	$2,%hi(DrawC_HeadLightFlash) # high
	.set	macro
	.set	reorder

	ori	$2,$5,0x0081
$L512:
	sh	$2,58($4)
	lui	$2,%hi(DrawC_HeadLightFlash) # high
$L511:
	lhu	$3,2234($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L513
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,2228($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L514
	lui	$3,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(DrawC_gOverlay) # high
	lhu	$2,%lo(DrawC_gOverlay)($2)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L513
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(DrawC_gOverlay) # high
$L514:
	addiu	$3,$3,%lo(DrawC_gOverlay) # low
	lhu	$2,58($3)
	#nop
	ori	$2,$2,0x8100
	sh	$2,58($3)
	lui	$2,%hi(DrawC_gOverlay) # high
$L513:
	addiu	$4,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($4)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L515
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
	beq	$2,$0,$L516
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
$L516:
	lhu	$3,2232($18)
	addiu	$2,$2,%lo(DrawC_HeadLightFlash) # low
	andi	$3,$3,0x000f
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L515
	lui	$2,%hi(DrawC_gOverlay) # high
	.set	macro
	.set	reorder

	lhu	$2,52($4)
	#nop
	ori	$2,$2,0x0080
	sh	$2,52($4)
	lui	$2,%hi(DrawC_gOverlay) # high
$L515:
	addiu	$5,$2,%lo(DrawC_gOverlay) # low
	lhu	$2,2($5)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L509
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
	beq	$2,$0,$L472
	li	$2,-32768			# 0xffff8000
	.set	macro
	.set	reorder

	lhu	$3,48($5)
	lhu	$4,50($5)
	or	$3,$3,$2
	or	$4,$4,$2
	sh	$3,48($5)
	sh	$4,50($5)
$L472:
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
	beq	$2,$0,$L509
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lhu	$2,52($5)
	#nop
	ori	$2,$2,0x8000
	sh	$2,52($5)
$L457:
	addu	$4,$sp,24
$L509:
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
	bne	$2,$0,$L474
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
	beq	$2,$0,$L475
	sll	$2,$4,16
	.set	macro
	.set	reorder

	sra	$6,$2,24
$L475:
	andi	$2,$3,0x00ff
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L476
	sll	$2,$3,16
	.set	macro
	.set	reorder

	sra	$5,$2,24
$L476:
	sll	$2,$6,16
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L517
	sll	$2,$5,16
	.set	macro
	.set	reorder

	addu	$6,$6,-10
	li	$23,1			# 0x00000001
$L517:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L518
	sll	$2,$5,16
	.set	macro
	.set	reorder

	move	$22,$0
	subu	$5,$0,$5
	sll	$2,$5,16
$L518:
	sra	$2,$2,16
	slt	$2,$2,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L519
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	addu	$5,$5,-10
	li	$21,1			# 0x00000001
$L519:
	sll	$2,$2,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$16,$L480
	lui	$3,%hi(Track_gReflectionMaps) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L481
	sw	$0,100($19)
	.set	macro
	.set	reorder

$L480:
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
$L481:
	addu	$2,$5,-1
	sll	$2,$2,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$16,$L482
	addu	$4,$19,72
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L483
	sw	$0,116($19)
	.set	macro
	.set	reorder

$L482:
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

$L483:
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
	beq	$2,$0,$L484
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$18,8
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L484
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$3,448($18)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$3,0($3)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L484
	sw	$3,DrawC_gWetRoad
$L484:
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
	j	$L499
	addu	$4,$19,106
	.set	macro
	.set	reorder

$L474:
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
$L499:
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
	bne	$2,$0,$L486
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
	beq	$23,$0,$L487
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
$L487:
	sll	$2,$6,1
	addu	$2,$2,$6
	sra	$2,$2,2
	sll	$3,$2,16
	sll	$4,$2,8
	addu	$3,$3,$4
	addu	$3,$3,$2
	sw	$3,152($19)
$L486:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,144($19)
	lh	$3,2236($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L489
	sll	$2,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L490
	sra	$6,$6,2
	.set	macro
	.set	reorder

$L489:
	addu	$2,$2,$6
	sra	$6,$2,2
$L490:
	sll	$2,$6,16
	sll	$3,$6,8
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,148($19)
	lw	$2,2148($18)
$L492:
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
	.align	2
	.globl	DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
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
	bne	$2,$0,$L528
	move	$9,$5
	.set	macro
	.set	reorder

	lw	$5,2168($4)
	#nop
	beq	$5,$0,$L522
	lh	$2,2172($5)
	lhu	$3,2172($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L523
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sh	$2,2172($5)
	sll	$2,$2,16
	bne	$2,$0,$L528
$L523:
	lw	$2,2160($5)
	lw	$4,2148($5)
	.set	noreorder
	.set	nomacro
	j	$L527
	addu	$8,$2,-1
	.set	macro
	.set	reorder

$L522:
	lw	$2,2160($4)
	lw	$4,2148($4)
	addu	$8,$2,-1
$L527:
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
$L528:
	j	$31
	.end	DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache
