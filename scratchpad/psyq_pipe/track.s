	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\track.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Track_SetTrackNumber__Fi

	.lcomm	strspc.12,64
	.rdata
	.align	2
$LC0:
	.ascii	"%sTr%02d%s\000"
	.text
	.align	2
	.globl	Track_MakeTrackPathName__FPc

	.lcomm	strspc.15,64
	.align	2
	.globl	Track_MakeTrackDataPathName__FPc
	.align	2
	.globl	AllocArtResource__FP18Track_tArtresourcei
	.align	2
	.globl	InitArtResources__Fv
	.align	2
	.globl	DeInitArtResources__Fv
	.rdata
	.align	2
$LC1:
	.ascii	"mipmapinf\000"
	.align	2
$LC2:
	.ascii	"mpalinfo\000"
	.text
	.align	2
	.globl	LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
	.align	2
	.globl	LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
	.sdata
	.align	2
$LC3:
	.ascii	"S0.psh\000"
	.align	2
$LC4:
	.ascii	"N0.psh\000"
	.align	2
$LC5:
	.ascii	"W0.psh\000"
	.align	2
$LC6:
	.ascii	"0.psh\000"
	.align	2
$LC7:
	.ascii	"r.psh\000"
	.text
	.align	2
	.globl	TexturesLoadInitial__Fv
	.align	2
	.globl	Track_AnimateTextures__Fv
	.align	2
	.globl	Track_GetProperMultiPalShapeIndex__Fii
	.align	2
	.globl	Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
	.align	2
	.globl	Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
	.align	2
	.globl	Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
	.align	2
	.globl	ReduceObjectPrecision__FP5GroupT0i
	.align	2
	.globl	InvalidatePersistentCollideBoomObjects__FP5GroupT0
	.align	2
	.globl	CalcObjectBoundingSphere__FP5GroupT0
	.align	2
	.globl	CalcObjDefPtrs__Fv
	.align	2
	.globl	Track_InitPersistentData__FP15SerializedGroup
	.sdata
	.align	2
$LC8:
	.ascii	"%s\000"
	.rdata
	.align	2
$LC9:
	.ascii	"lighttbl\000"
	.align	2
$LC10:
	.ascii	"Track_mem\000"
	.sdata
	.align	2
$LC11:
	.ascii	".grp\000"
	.align	2
$LC12:
	.ascii	"bsphere\000"
	.text
	.align	2
	.globl	Track_Init__FPc
	.align	2
	.globl	Track_DeInit__Fv
	.align	2
	.globl	Track_AnimateTrackLighting__Fv
	.sdata
	.align	2
$LC13:
	.ascii	".kil\000"
	.text
	.align	2
	.globl	KillFile_OpenRead__Fv
	.align	2
	.globl	KillFile_ReadEntry__FPciRiT2
	.align	2
	.globl	Track_LoadObjectKillData__Fv
	.align	2
	.globl	Save__11SaveSurfaceP14Trk_NewSimQuad
	.rdata
	.align	2
$LC14:
	.ascii	"Surface Save\000"
	.text
	.align	2
	.globl	__11SaveSurfacei
	.align	2
	.globl	___11SaveSurface
	.align	2
	.globl	RestoreAll__11SaveSurface
	.globl	Track_gInViewList
	.sdata
	.align	2
Track_gInViewList:
	.space	4
	.globl	Track_gInViewCount
	.align	2
Track_gInViewCount:
	.space	4
	.globl	Track_header
	.align	2
Track_header:
	.space	4
	.globl	Track_chunkList
	.align	2
Track_chunkList:
	.space	4
	.globl	gPersistObjDef
	.align	2
gPersistObjDef:
	.space	4
	.globl	gPersistObjInst
	.align	2
gPersistObjInst:
	.space	4
	.globl	gPersistMidgroundObjInst
	.align	2
gPersistMidgroundObjInst:
	.space	4
	.globl	gPersistObjDefBoundingSpheres
	.align	2
gPersistObjDefBoundingSpheres:
	.space	4
	.globl	Track_gSaveSurface
	.align	2
Track_gSaveSurface:
	.space	4
	.globl	Track_materials
	.align	2
Track_materials:
	.space	4
	.globl	Track_gObjDefs
	.align	2
Track_gObjDefs:
	.space	4
	.globl	Track_mem
	.align	2
Track_mem:
	.space	4
	.globl	gtrackNumber
	.align	2
gtrackNumber:
	.space	4
	.globl	gObjDefOffsetsGroup
	.align	2
gObjDefOffsetsGroup:
	.space	4
	.globl	Track_gControllerCount
	.align	2
Track_gControllerCount:
	.space	4
	.globl	Track_gMatController
	.align	2
Track_gMatController:
	.space	4
	.globl	Chunk_numLight
	.align	2
Chunk_numLight:
	.space	4
	.globl	Track_gReflectionMaps
	.section .data.track_reflection_maps,"aw",@progbits
	.align	2
Track_gReflectionMaps:
	.space	64
	.globl	gInitialArt
	.section .data.track_initial_art,"aw",@progbits
	.align	2
gInitialArt:
	.space	24

	.lcomm	gTempMipMapInfo,4

	.lcomm	gTempMultiPalInfo,4

	.extern	Chunk_chunkCenters, 4
	.extern	Chunk_lightTable, 4
	.extern	simGlobal, 24
	.extern	gSpikeBeltPixmap, 4
	.extern	GameSetup_gData, 2600
	.extern	TrackSpec_gSpec, 264

	.text
	.text
	.ent	Track_SetTrackNumber__Fi
Track_SetTrackNumber__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$4,$4,0x000f
	sw	$4,gtrackNumber
	j	$31
	.end	Track_SetTrackNumber__Fi
	.text
	.ent	Track_MakeTrackPathName__FPc
Track_MakeTrackPathName__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	lui	$16,%hi(strspc.12) # high
	addiu	$16,$16,%lo(strspc.12) # low
	lui	$5,%hi($LC0) # high
	lui	$2,%hi(Paths_Paths+24) # high
	sw	$4,16($sp)
	move	$4,$16
	lw	$7,gtrackNumber
	lw	$6,%lo(Paths_Paths+24)($2)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Track_MakeTrackPathName__FPc
	.text
	.ent	Track_MakeTrackDataPathName__FPc
Track_MakeTrackDataPathName__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	lui	$16,%hi(strspc.15) # high
	addiu	$16,$16,%lo(strspc.15) # low
	lui	$5,%hi($LC0) # high
	lui	$2,%hi(Paths_Paths+32) # high
	sw	$4,16($sp)
	move	$4,$16
	lw	$7,gtrackNumber
	lw	$6,%lo(Paths_Paths+32)($2)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Track_MakeTrackDataPathName__FPc
	.text
	.ent	AllocArtResource__FP18Track_tArtresourcei
AllocArtResource__FP18Track_tArtresourcei:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$2,-1			# 0xffffffff
	sll	$4,$5,4
	sw	$31,20($sp)
	sw	$2,0($16)
	.set	noreorder
	.set	nomacro
	jal	BWAllocMem__Fl
	sw	$0,20($16)
	.set	macro
	.set	reorder

	sw	$2,12($16)
	sw	$0,8($16)
	sw	$0,4($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AllocArtResource__FP18Track_tArtresourcei
	.text
	.ent	InitArtResources__Fv
InitArtResources__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(gInitialArt) # high
	addiu	$4,$4,%lo(gInitialArt) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AllocArtResource__FP18Track_tArtresourcei
	li	$5,850			# 0x00000352
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWAllocMem__Fl
	li	$4,3400			# 0x00000d48
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$2,Track_materials
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	InitArtResources__Fv
	.text
	.ent	DeInitArtResources__Fv
DeInitArtResources__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(gInitialArt+12) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Chunk_DeInit__Fv
	sw	$0,%lo(gInitialArt+12)($2)
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

	.end	DeInitArtResources__Fv
	.text
	.ent	LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii:
	.frame	$sp,88,$31		# vars= 16, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(TrackSpec_gSpec) # high
	lh	$2,%lo(TrackSpec_gSpec)($2)
	subu	$sp,$sp,88
	sw	$22,72($sp)
	move	$22,$4
	sw	$20,64($sp)
	move	$20,$5
	sw	$21,68($sp)
	li	$21,-1			# 0xffffffff
	sw	$fp,80($sp)
	move	$fp,$7
	sw	$23,76($sp)
	move	$23,$0
	sw	$31,84($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	sw	$0,gTempMipMapInfo
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	sw	$6,96($sp)
	.set	macro
	.set	reorder

	li	$21,-3			# 0xfffffffd
	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,384			# 0x00000180
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,gTempMipMapInfo
	move	$4,$23
	li	$5,-1			# 0xffffffff
	move	$3,$23
$L21:
	lw	$2,gTempMipMapInfo
	addu	$4,$4,1
	addu	$2,$3,$2
	sw	$5,0($2)
	slt	$2,$4,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L21
	addu	$3,$3,12
	.set	macro
	.set	reorder

$L17:
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,gTempMultiPalInfo
	li	$4,-1			# 0xffffffff
	li	$3,127			# 0x0000007f
	addu	$2,$2,1016
$L26:
	sh	$4,2($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L26
	addu	$2,$2,-8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	move	$19,$0
	move	$16,$19
	move	$18,$19
$L28:
	.set	noreorder
	.set	nomacro
	jal	shapecount
	move	$4,$22
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L29
	move	$4,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	shapepointer
	move	$5,$16
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L31
	move	$4,$22
	.set	macro
	.set	reorder

	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	shapename
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	slt	$2,$16,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L33
	move	$7,$21
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	li	$3,1			# 0x00000001
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L33
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	lbu	$3,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L55
	move	$4,$0
	.set	macro
	.set	reorder

$L33:
	li	$7,-1			# 0xffffffff
	move	$4,$0
$L55:
	lw	$9,96($sp)
	move	$5,$17
	sw	$7,20($sp)
	sw	$7,24($sp)
	move	$7,$fp
	sw	$20,28($sp)
	or	$6,$9,$23
	lw	$9,104($sp)
	ori	$6,$6,0x0002
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$9,16($sp)
	.set	macro
	.set	reorder

	lbu	$3,32($sp)
	li	$2,33			# 0x00000021
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L56
	lui	$2,%hi(TrackSpec_gSpec) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,35
	lw	$2,gTempMultiPalInfo
	lbu	$3,33($sp)
	addu	$2,$18,$2
	sb	$3,0($2)
	lw	$2,gTempMultiPalInfo
	lbu	$3,34($sp)
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	jal	atoi
	sb	$3,1($2)
	.set	macro
	.set	reorder

	lw	$4,gTempMultiPalInfo
	#nop
	addu	$3,$18,$4
	sh	$2,2($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	sh	$16,6($3)
	.set	macro
	.set	reorder

	move	$5,$0
	move	$8,$4
	lbu	$7,33($sp)
	lbu	$6,34($sp)
$L39:
	move	$3,$4
	lbu	$2,0($3)
	#nop
	bne	$2,$7,$L38
	lbu	$2,1($3)
	#nop
	bne	$2,$6,$L38
	lh	$2,2($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L53
	addu	$2,$18,$8
	.set	macro
	.set	reorder

$L38:
	addu	$5,$5,1
	slt	$2,$5,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L39
	addu	$4,$4,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L34
	addu	$18,$18,8
	.set	macro
	.set	reorder

$L53:
	lhu	$3,4($4)
	.set	noreorder
	.set	nomacro
	j	$L42
	sh	$3,4($2)
	.set	macro
	.set	reorder

$L35:
	sh	$16,4($3)
$L42:
	addu	$18,$18,8
$L34:
	lui	$2,%hi(TrackSpec_gSpec) # high
$L56:
	lh	$2,%lo(TrackSpec_gSpec)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$2,90			# 0x0000005a
	.set	macro
	.set	reorder

	lbu	$3,32($sp)
	#nop
	bne	$3,$2,$L43
	lbu	$2,35($sp)
	lbu	$4,34($sp)
	lbu	$3,33($sp)
	sh	$2,42($sp)
	li	$2,82			# 0x00000052
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L44
	sh	$4,40($sp)
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	li	$3,1			# 0x00000001
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L44
	sll	$2,$19,$3
	.set	macro
	.set	reorder

	addu	$2,$2,$19
	lw	$3,gTempMipMapInfo
	sll	$2,$2,2
	addu	$2,$2,$3
	sh	$4,0($2)
	lbu	$3,35($sp)
	addu	$19,$19,1
	sw	$16,4($2)
	sw	$16,8($2)
	.set	noreorder
	.set	nomacro
	j	$L43
	sh	$3,2($2)
	.set	macro
	.set	reorder

$L54:
	.set	noreorder
	.set	nomacro
	j	$L43
	sw	$16,8($3)
	.set	macro
	.set	reorder

$L44:
	lbu	$3,33($sp)
	li	$2,90			# 0x0000005a
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L43
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$6,40($sp)
	lh	$5,42($sp)
	lw	$3,gTempMipMapInfo
$L50:
	lhu	$2,0($3)
	#nop
	bne	$6,$2,$L49
	lhu	$2,2($3)
	#nop
	beq	$5,$2,$L54
$L49:
	addu	$4,$4,1
	slt	$2,$4,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L50
	addu	$3,$3,12
	.set	macro
	.set	reorder

$L43:
	addu	$20,$20,16
$L31:
	.set	noreorder
	.set	nomacro
	j	$L28
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L29:
	lw	$31,84($sp)
	lw	$fp,80($sp)
	lw	$23,76($sp)
	lw	$22,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
	.text
	.ent	LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii:
	.frame	$sp,64,$31		# vars= 0, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,44($sp)
	move	$19,$4
	sw	$22,56($sp)
	move	$22,$6
	sw	$21,52($sp)
	move	$21,$7
	sw	$17,36($sp)
	move	$17,$5
	sw	$20,48($sp)
	move	$20,$0
	sw	$16,32($sp)
	move	$16,$20
	sw	$18,40($sp)
	li	$18,-1			# 0xffffffff
	sw	$31,60($sp)
$L58:
	.set	noreorder
	.set	nomacro
	jal	shapecount
	move	$4,$19
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L57
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	shapepointer
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L60
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$2
	ori	$6,$20,0x0042
	move	$7,$22
	sw	$21,16($sp)
	sw	$18,20($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,16
$L60:
	.set	noreorder
	.set	nomacro
	j	$L58
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L57:
	lw	$31,60($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
	.text
	.ent	TexturesLoadInitial__Fv
TexturesLoadInitial__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	sw	$31,28($sp)
	sw	$16,24($sp)
	lw	$2,84($3)
	#nop
	beq	$2,$0,$L64
	lw	$2,72($3)
	#nop
	beq	$2,$0,$L65
	lui	$4,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L77
	addiu	$4,$4,%lo($LC3) # low
	.set	macro
	.set	reorder

$L65:
	lui	$4,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	j	$L77
	addiu	$4,$4,%lo($LC4) # low
	.set	macro
	.set	reorder

$L64:
	lw	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L68
	lui	$4,%hi($LC5) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L77
	addiu	$4,$4,%lo($LC5) # low
	.set	macro
	.set	reorder

$L68:
	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
$L77:
	jal	Track_MakeTrackPathName__FPc
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(D_8011E15C) # high
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L74
	sw	$2,%lo(D_8011E15C)($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	lui	$16,%hi(gInitialArt) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(gInitialArt) # low
	lw	$4,4($16)
	jal	shapecount
	li	$6,64			# 0x00000040
	lw	$4,4($16)
	lw	$5,12($16)
	li	$7,256			# 0x00000100
	sw	$2,8($16)
	.set	noreorder
	.set	nomacro
	jal	LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$2,8($16)
	lw	$3,12($16)
	lw	$4,gSpikeBeltPixmap
	sll	$2,$2,4
	addu	$2,$2,$3
	lwl	$8,3($4)
	lwr	$8,0($4)
	lwl	$9,7($4)
	lwr	$9,4($4)
	lwl	$10,11($4)
	lwr	$10,8($4)
	lwl	$11,15($4)
	lwr	$11,12($4)
	swl	$8,3($2)
	swr	$8,0($2)
	swl	$9,7($2)
	swr	$9,4($2)
	swl	$10,11($2)
	swr	$10,8($2)
	swl	$11,15($2)
	swr	$11,12($2)
	lw	$2,8($16)
	lw	$4,4($16)
	addu	$2,$2,1
	sw	$2,8($16)
	sw	$2,16($16)
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$2,20($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L71
	lui	$2,%hi(gInitialArt+12) # high
	.set	macro
	.set	reorder

$L74:
	j	$L74
$L71:
	lw	$4,%lo(gInitialArt+12)($2)
	jal	Hrz_GetHorizonPixMap__FP12Draw_tPixMap
	lui	$4,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	Track_MakeTrackPathName__FPc
	addiu	$4,$4,%lo($LC7) # low
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L63
	jal	Texture_ResetPaletteSharing__Fv
	move	$4,$16
	lui	$5,%hi(Track_gReflectionMaps) # high
	addiu	$5,$5,%lo(Track_gReflectionMaps) # low
	li	$6,992			# 0x000003e0
	.set	noreorder
	.set	nomacro
	jal	LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

$L63:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TexturesLoadInitial__Fv
	.text
	.ent	Track_AnimateTextures__Fv
Track_AnimateTextures__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$12,-1			# 0xffffffff
	li	$11,128			# 0x00000080
	lui	$2,%hi(simGlobal) # high
	addiu	$9,$2,%lo(simGlobal) # low
	lui	$2,%hi(gInitialArt) # high
	addiu	$10,$2,%lo(gInitialArt) # low
	lw	$7,Track_gMatController
	lw	$8,Track_gControllerCount
	addu	$6,$7,10
$L79:
	addu	$8,$8,-1
	beq	$8,$12,$L85
	lh	$3,0($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$11,$L81
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	lbu	$3,-1($6)
	lw	$2,4($9)
	#nop
	div	$2,$2,$3
	lbu	$3,-8($6)
	#nop
	rem	$5,$2,$3
	lw	$2,2($6)
	lw	$4,12($10)
	lh	$3,2($2)
	lbu	$2,-6($6)
	sll	$3,$3,4
	addu	$4,$4,$3
	addu	$2,$2,$5
	sb	$2,1($4)
	lbu	$2,-5($6)
	#nop
	addu	$2,$2,$5
	sb	$2,5($4)
	lbu	$2,-4($6)
	#nop
	addu	$2,$2,$5
	sb	$2,9($4)
	lbu	$2,-3($6)
	#nop
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$L82
	sb	$2,13($4)
	.set	macro
	.set	reorder

$L81:
	bne	$3,$2,$L82
	lbu	$3,-1($6)
	lw	$2,4($9)
	#nop
	div	$2,$2,$3
	lbu	$3,-2($6)
	#nop
	rem	$4,$2,$3
	lhu	$2,0($6)
	lw	$3,2($6)
	addu	$2,$2,$4
	sh	$2,2($3)
$L82:
	addu	$6,$6,16
	.set	noreorder
	.set	nomacro
	j	$L79
	addu	$7,$7,16
	.set	macro
	.set	reorder

$L85:
	j	$31
	.end	Track_AnimateTextures__Fv
	.text
	.ent	Track_GetProperMultiPalShapeIndex__Fii
Track_GetProperMultiPalShapeIndex__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	lw	$3,gTempMultiPalInfo
$L90:
	lh	$2,4($3)
	#nop
	bne	$2,$4,$L89
	lh	$2,2($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L95
	addu	$6,$6,1
	.set	macro
	.set	reorder

	lh	$2,6($3)
	j	$31
$L89:
	addu	$6,$6,1
$L95:
	slt	$2,$6,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L90
	addu	$3,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	Track_GetProperMultiPalShapeIndex__Fii
	.text
	.ent	Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1:
	.frame	$sp,104,$31		# vars= 64, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$18,88($sp)
	move	$18,$4
	sw	$17,84($sp)
	move	$17,$0
	sw	$19,92($sp)
	move	$19,$6
	sw	$16,80($sp)
	andi	$2,$18,0x0010
	sw	$31,96($sp)
	lwl	$7,3($5)
	lwr	$7,0($5)
	lwl	$8,7($5)
	lwr	$8,4($5)
	lwl	$9,11($5)
	lwr	$9,8($5)
	lwl	$10,15($5)
	lwr	$10,12($5)
	swl	$7,19($sp)
	swr	$7,16($sp)
	swl	$8,23($sp)
	swr	$8,20($sp)
	swl	$9,27($sp)
	swr	$9,24($sp)
	swl	$10,31($sp)
	swr	$10,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L97
	addu	$16,$sp,16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L97:
	andi	$2,$18,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L98
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sll	$6,$17,4
	addu	$4,$16,$6
	addu	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	addu	$6,$16,$6
	.set	macro
	.set	reorder

	addu	$17,$17,1
$L98:
	andi	$2,$18,0x000e
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L99
	andi	$2,$18,0x0002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L100
	sll	$6,$17,4
	.set	macro
	.set	reorder

	addu	$4,$16,$6
	.set	noreorder
	.set	nomacro
	j	$L105
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L100:
	andi	$2,$18,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L102
	addu	$4,$16,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L105
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L102:
	andi	$2,$18,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L101
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	sll	$6,$17,4
	addu	$4,$16,$6
$L105:
	addu	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	addu	$6,$16,$6
	.set	macro
	.set	reorder

$L101:
	addu	$17,$17,1
$L99:
	sll	$3,$17,4
	addu	$2,$sp,16
	addu	$2,$2,$3
	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,3($19)
	swr	$7,0($19)
	swl	$8,7($19)
	swr	$8,4($19)
	swl	$9,11($19)
	swr	$9,8($19)
	swl	$10,15($19)
	swr	$10,12($19)
	lw	$31,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
	.text
	.ent	Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$4
	sw	$19,44($sp)
	move	$19,$5
	sw	$18,40($sp)
	move	$18,$6
	sw	$31,48($sp)
	sw	$16,32($sp)
	lbu	$2,2($17)
	move	$16,$0
	sb	$2,0($19)
$L107:
	blez	$16,$L109
	lbu	$2,7($17)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L106
$L109:
	lbu	$2,3($17)
	#nop
	andi	$2,$2,0x005e
	beq	$2,$0,$L110
	lbu	$2,2($17)
	lh	$4,0($17)
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L117
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lbu	$5,8($17)
	jal	Track_GetProperMultiPalShapeIndex__Fii
	move	$4,$2
	addu	$5,$sp,16
$L117:
	addu	$2,$4,$16
	lw	$3,12($18)
	sll	$2,$2,4
	addu	$2,$2,$3
	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,19($sp)
	swr	$7,16($sp)
	swl	$8,23($sp)
	swr	$8,20($sp)
	swl	$9,27($sp)
	swr	$9,24($sp)
	swl	$10,31($sp)
	swr	$10,28($sp)
	lbu	$4,3($17)
	lw	$6,16($18)
	lw	$2,12($18)
	sll	$6,$6,4
	.set	noreorder
	.set	nomacro
	jal	Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	bne	$16,$0,$L112
	lhu	$2,16($18)
	#nop
	sh	$2,2($19)
$L112:
	lw	$2,16($18)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L113
	sw	$2,16($18)
	.set	macro
	.set	reorder

$L110:
	lbu	$2,2($17)
	lh	$4,0($17)
	andi	$2,$2,0x0002
	beq	$2,$0,$L114
	lbu	$5,8($17)
	jal	Track_GetProperMultiPalShapeIndex__Fii
	move	$4,$2
$L114:
	bne	$16,$0,$L113
	sh	$4,2($19)
$L113:
	.set	noreorder
	.set	nomacro
	j	$L107
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L106:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
	.text
	.ent	Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$17,44($sp)
	move	$17,$6
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L118
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	li	$2,-858993459			# 0xcccccccd
	multu	$5,$2
	lui	$2,%hi(gInitialArt) # high
	addiu	$2,$2,%lo(gInitialArt) # low
	move	$23,$0
	lw	$3,20($2)
	addu	$16,$4,16
	sw	$0,Track_gControllerCount
	sw	$3,16($2)
	mfhi	$7
	#nop
	#nop
	srl	$7,$7,3
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L121
	sw	$7,32($sp)
	.set	macro
	.set	reorder

	move	$3,$16
$L123:
	lhu	$2,2($3)
	#nop
	andi	$2,$2,0x0084
	beq	$2,$0,$L122
	lw	$2,Track_gControllerCount
	#nop
	addu	$2,$2,1
	sw	$2,Track_gControllerCount
$L122:
	lw	$8,32($sp)
	addu	$23,$23,1
	slt	$2,$23,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L123
	addu	$3,$3,10
	.set	macro
	.set	reorder

$L121:
	lw	$4,Track_gControllerCount
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L147
	move	$23,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWAllocMem__Fl
	sll	$4,$4,4
	.set	macro
	.set	reorder

	sw	$2,Track_gMatController
	move	$23,$0
$L147:
	move	$fp,$23
	lui	$2,%hi(gInitialArt) # high
	addiu	$22,$2,%lo(gInitialArt) # low
	move	$21,$17
	move	$17,$16
$L127:
	lw	$9,32($sp)
	#nop
	slt	$2,$23,$9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L128
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
	move	$6,$22
	.set	macro
	.set	reorder

	lbu	$3,2($17)
	#nop
	andi	$2,$3,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L131
	sll	$4,$fp,4
	.set	macro
	.set	reorder

	lw	$2,Track_gMatController
	andi	$3,$3,0x00ff
	addu	$2,$4,$2
	sh	$3,0($2)
	lbu	$3,8($17)
	addu	$fp,$fp,1
	sb	$3,9($2)
	lw	$2,Track_gMatController
	lbu	$3,7($17)
	addu	$2,$4,$2
	sb	$3,8($2)
	lw	$2,Track_gMatController
	lhu	$3,2($21)
	addu	$4,$4,$2
	sh	$3,10($4)
	.set	noreorder
	.set	nomacro
	j	$L132
	sw	$21,12($4)
	.set	macro
	.set	reorder

$L131:
	andi	$2,$3,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L132
	sll	$5,$fp,4
	.set	macro
	.set	reorder

	lw	$2,Track_gMatController
	lbu	$3,2($17)
	addu	$2,$5,$2
	sh	$3,0($2)
	lbu	$2,8($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L134
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,8($17)
$L134:
	lw	$2,Track_gMatController
	lbu	$3,8($17)
	addu	$2,$5,$2
	sb	$3,9($2)
	lw	$2,Track_gMatController
	lbu	$3,7($17)
	addu	$2,$5,$2
	sb	$3,8($2)
	lw	$4,Track_gMatController
	lhu	$2,2($21)
	addu	$4,$5,$4
	sh	$2,10($4)
	sw	$21,12($4)
	lh	$2,2($21)
	lw	$3,12($22)
	sll	$2,$2,4
	addu	$3,$3,$2
	lbu	$2,1($3)
	#nop
	sb	$2,4($4)
	lw	$2,Track_gMatController
	lbu	$4,5($3)
	addu	$2,$5,$2
	sb	$4,5($2)
	lw	$2,Track_gMatController
	lbu	$4,9($3)
	addu	$2,$5,$2
	sb	$4,6($2)
	lw	$2,Track_gMatController
	lbu	$4,13($3)
	addu	$2,$5,$2
	sb	$4,7($2)
	lbu	$4,13($3)
	lbu	$2,1($3)
	#nop
	subu	$2,$4,$2
	bgez	$2,$L135
	subu	$2,$0,$2
$L135:
	addu	$fp,$fp,1
	lw	$3,Track_gMatController
	addu	$2,$2,1
	addu	$3,$5,$3
	sb	$2,2($3)
$L132:
	lui	$2,%hi(TrackSpec_gSpec) # high
	lh	$2,%lo(TrackSpec_gSpec)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L129
	move	$20,$0
	.set	macro
	.set	reorder

	move	$19,$17
	move	$16,$21
	move	$18,$20
$L137:
	slt	$2,$20,32
	beq	$2,$0,$L129
	lw	$2,gTempMipMapInfo
	#nop
	addu	$4,$18,$2
	lw	$3,0($4)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L139
	lw	$5,4($4)
	lh	$2,0($19)
	#nop
	bne	$5,$2,$L139
	lbu	$2,0($16)
	lw	$3,8($4)
	ori	$2,$2,0x0008
	sb	$2,0($16)
	lh	$4,0($19)
	lh	$2,2($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L143
	subu	$3,$3,$5
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	addu	$2,$4,$3
	lw	$3,12($22)
	sll	$2,$2,4
	addu	$2,$2,$3
	lwl	$10,3($2)
	lwr	$10,0($2)
	lwl	$7,7($2)
	lwr	$7,4($2)
	lwl	$8,11($2)
	lwr	$8,8($2)
	lwl	$9,15($2)
	lwr	$9,12($2)
	swl	$10,19($sp)
	swr	$10,16($sp)
	swl	$7,23($sp)
	swr	$7,20($sp)
	swl	$8,27($sp)
	swr	$8,24($sp)
	swl	$9,31($sp)
	swr	$9,28($sp)
	lbu	$4,3($19)
	lw	$6,16($22)
	lw	$2,12($22)
	sll	$6,$6,4
	.set	noreorder
	.set	nomacro
	jal	Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	lw	$2,16($22)
	#nop
	addu	$2,$2,1
	sw	$2,16($22)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L139
	sb	$2,1($16)
	.set	macro
	.set	reorder

$L143:
	sb	$3,1($16)
$L139:
	addu	$18,$18,12
	.set	noreorder
	.set	nomacro
	j	$L137
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L129:
	addu	$21,$21,4
	addu	$17,$17,10
	.set	noreorder
	.set	nomacro
	j	$L127
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L128:
	lw	$4,gTempMipMapInfo
	#nop
	beq	$4,$0,$L145
	jal	purgememadr
$L145:
	lw	$4,gTempMultiPalInfo
	jal	purgememadr
	lui	$2,%hi(gInitialArt) # high
	addiu	$2,$2,%lo(gInitialArt) # low
	lw	$3,8($2)
	sw	$0,4($2)
	sw	$3,16($2)
$L118:
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

	.end	Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
	.text
	.ent	ReduceObjectPrecision__FP5GroupT0i
ReduceObjectPrecision__FP5GroupT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L160
	addu	$10,$4,4
	.set	macro
	.set	reorder

	li	$12,-1			# 0xffffffff
	lw	$11,0($4)
	lw	$13,Track_gObjDefs
$L152:
	addu	$11,$11,-1
	beq	$11,$12,$L160
	beq	$5,$0,$L155
	lh	$2,6($10)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$13
	lw	$2,0($2)
	#nop
	addu	$8,$2,4
	addu	$7,$2,8
	lbu	$9,2($2)
$L156:
	addu	$9,$9,-1
	beq	$9,$12,$L155
	lh	$2,0($8)
	lh	$3,-2($7)
	lh	$4,0($7)
	sra	$2,$2,$6
	sra	$3,$3,$6
	sra	$4,$4,$6
	sh	$2,0($8)
	sh	$3,-2($7)
	sh	$4,0($7)
	addu	$7,$7,8
	.set	noreorder
	.set	nomacro
	j	$L156
	addu	$8,$8,8
	.set	macro
	.set	reorder

$L155:
	lh	$2,0($10)
	.set	noreorder
	.set	nomacro
	j	$L152
	addu	$10,$10,$2
	.set	macro
	.set	reorder

$L160:
	j	$31
	.end	ReduceObjectPrecision__FP5GroupT0i
	.text
	.ent	InvalidatePersistentCollideBoomObjects__FP5GroupT0
InvalidatePersistentCollideBoomObjects__FP5GroupT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	beq	$4,$0,$L171
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L171
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$5,0($4)
	#nop
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L171
	addu	$4,$4,4
	.set	macro
	.set	reorder

	move	$6,$2
$L167:
	lh	$2,6($4)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lh	$2,0($2)
	#nop
	beq	$2,$6,$L168
	sb	$0,2($4)
$L168:
	lh	$2,0($4)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bne	$5,$6,$L167
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L171:
	j	$31
	.end	InvalidatePersistentCollideBoomObjects__FP5GroupT0
	.text
	.ent	CalcObjectBoundingSphere__FP5GroupT0
CalcObjectBoundingSphere__FP5GroupT0:
	.frame	$sp,64,$31		# vars= 16, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,44($sp)
	move	$19,$5
	sw	$18,40($sp)
	addu	$18,$19,4
	sw	$17,36($sp)
	move	$17,$0
	sw	$20,48($sp)
	li	$20,-1			# 0xffffffff
	sw	$16,32($sp)
	addu	$16,$19,10
	sw	$31,56($sp)
	sw	$21,52($sp)
	lw	$21,0($4)
$L177:
	slt	$2,$17,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L172
	sll	$2,$17,2
	.set	macro
	.set	reorder

	lw	$3,Track_gObjDefs
	#nop
	addu	$2,$2,$3
	lw	$6,0($2)
	#nop
	lbu	$7,2($6)
	addu	$8,$6,4
	sw	$0,24($sp)
	sw	$0,20($sp)
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$20,$L182
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	addu	$4,$6,8
$L183:
	lh	$3,0($8)
	lw	$2,16($sp)
	addu	$8,$8,8
	addu	$2,$2,$3
	sw	$2,16($sp)
	lh	$3,-2($4)
	lw	$2,20($sp)
	addu	$7,$7,-1
	addu	$2,$2,$3
	sw	$2,20($sp)
	lh	$3,0($4)
	lw	$2,24($sp)
	addu	$4,$4,8
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$7,$5,$L183
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L182:
	lbu	$2,2($6)
	lw	$5,16($sp)
	#nop
	div	$5,$5,$2
	lw	$4,20($sp)
	sw	$5,16($sp)
	lbu	$2,2($6)
	#nop
	div	$4,$4,$2
	lw	$3,24($sp)
	sw	$4,20($sp)
	lbu	$2,2($6)
	#nop
	div	$3,$3,$2
	addu	$8,$6,4
	move	$11,$0
	addu	$9,$6,8
	sw	$3,24($sp)
	lbu	$7,2($6)
$L185:
	addu	$7,$7,-1
	beq	$7,$20,$L186
	lh	$2,0($8)
	#nop
	subu	$2,$5,$2
	sra	$2,$2,6
	mult	$2,$2
	lh	$2,-2($9)
	mflo	$10
	#nop
	subu	$2,$4,$2
	sra	$2,$2,6
	mult	$2,$2
	lh	$2,0($9)
	mflo	$6
	#nop
	subu	$2,$3,$2
	sra	$2,$2,6
	mult	$2,$2
	addu	$2,$10,$6
	mflo	$13
	#nop
	#nop
	addu	$6,$2,$13
	slt	$2,$11,$6
	beq	$2,$0,$L188
	move	$11,$6
$L188:
	addu	$9,$9,8
	.set	noreorder
	.set	nomacro
	j	$L185
	addu	$8,$8,8
	.set	macro
	.set	reorder

$L186:
	lhu	$2,16($sp)
	addu	$17,$17,1
	sh	$2,0($18)
	lhu	$2,20($sp)
	sll	$4,$11,10
	sh	$2,-4($16)
	lhu	$2,24($sp)
	addu	$18,$18,8
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	sh	$2,-2($16)
	.set	macro
	.set	reorder

	srl	$2,$2,7
	sh	$2,0($16)
	lw	$2,0($19)
	addu	$16,$16,8
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L177
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L172:
	lw	$31,56($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	CalcObjectBoundingSphere__FP5GroupT0
	.text
	.ent	CalcObjDefPtrs__Fv
CalcObjDefPtrs__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,1			# 0x00000001
	lw	$2,gPersistObjDef
	lw	$3,gObjDefOffsetsGroup
	move	$6,$2
	addu	$4,$3,8
	addu	$2,$6,4
	sw	$2,4($3)
$L195:
	lw	$2,0($6)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L196
	addu	$5,$5,1
	.set	macro
	.set	reorder

	lw	$2,-4($4)
	lw	$3,0($4)
	#nop
	addu	$2,$2,$3
	sw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$L195
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L196:
	lw	$2,gObjDefOffsetsGroup
	#nop
	addu	$2,$2,4
	sw	$2,Track_gObjDefs
	j	$31
	.end	CalcObjDefPtrs__Fv
	.text
	.ent	Track_InitPersistentData__FP15SerializedGroup
Track_InitPersistentData__FP15SerializedGroup:
	.frame	$fp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0xc01f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$fp,36($sp)
	move	$fp,$sp
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,12($18)
	move	$16,$0
	sw	$0,gObjDefOffsetsGroup
	sll	$2,$2,5
	srl	$2,$2,3
	addu	$2,$2,7
	srl	$2,$2,3
	sll	$2,$2,3
	subu	$sp,$sp,$2
	lw	$2,12($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L212
	addu	$19,$sp,16
	.set	macro
	.set	reorder

	move	$17,$19
$L214:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	LocateGroupNum__15SerializedGroupi
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$2,0($17)
	lw	$2,12($18)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L214
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L212:
	move	$4,$18
	li	$5,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$18,12($18)
	move	$17,$0
	lui	$2,%hi($L227) # high
	addiu	$20,$2,%lo($L227) # low
	move	$16,$19
$L216:
	slt	$2,$17,$18
	beq	$2,$0,$L217
	lw	$2,0($16)
	#nop
	lw	$2,0($2)
	#nop
	addu	$3,$2,-2
	sltu	$2,$3,37
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L219
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L227:
	.word	$L220
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L223
	.word	$L224
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L221
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L219
	.word	$L222
	.word	$L219
	.word	$L225
	.text
$L220:
	lw	$4,0($16)
	#nop
	lw	$5,4($4)
	lw	$6,Track_materials
	.set	noreorder
	.set	nomacro
	jal	Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
	addu	$5,$5,-16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L230
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L221:
	lw	$4,0($16)
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_Init__FP5Group
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L230
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L222:
	lw	$4,0($16)
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$5,$4
	.set	macro
	.set	reorder

	sw	$2,gPersistMidgroundObjInst
	.set	noreorder
	.set	nomacro
	j	$L230
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L223:
	lw	$4,0($16)
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$5,$4
	.set	macro
	.set	reorder

	sw	$2,gPersistObjInst
	.set	noreorder
	.set	nomacro
	j	$L230
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L224:
	lw	$4,0($16)
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$5,$4
	.set	macro
	.set	reorder

	sw	$2,gPersistObjDef
	.set	noreorder
	.set	nomacro
	j	$L230
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L225:
	lw	$4,0($16)
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem
	move	$5,$4
	.set	macro
	.set	reorder

	sw	$2,gObjDefOffsetsGroup
$L219:
	addu	$16,$16,4
$L230:
	.set	noreorder
	.set	nomacro
	j	$L216
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L217:
	lw	$2,gObjDefOffsetsGroup
	#nop
	beq	$2,$0,$L228
	jal	CalcObjDefPtrs__Fv
$L228:
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
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

	.end	Track_InitPersistentData__FP15SerializedGroup
	.text
	.ent	Track_Init__FPc
Track_Init__FPc:
	.frame	$sp,184,$31		# vars= 128, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$16,144($sp)
	move	$16,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC8) # high
	addiu	$5,$5,%lo($LC8) # low
	sw	$31,176($sp)
	sw	$23,172($sp)
	sw	$22,168($sp)
	sw	$21,164($sp)
	sw	$20,160($sp)
	sw	$19,156($sp)
	sw	$18,152($sp)
	sw	$17,148($sp)
	sw	$0,Track_gSaveSurface
	sw	$0,Track_gObjDefs
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC9) # high
	addiu	$4,$4,%lo($LC9) # low
	li	$5,1028			# 0x00000404
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$18,$2
	.set	macro
	.set	reorder

	sw	$2,Chunk_lightTable
	.set	noreorder
	.set	nomacro
	jal	TextureProcess_Init__Fv
	li	$19,36992			# 0x00009080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	InitArtResources__Fv
	addu	$17,$18,$19
	.set	macro
	.set	reorder

	jal	TexturesLoadInitial__Fv
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,12			# 0x0000000c
	.set	macro
	.set	reorder

	lui	$4,%hi($LC10) # high
	addiu	$4,$4,%lo($LC10) # low
	move	$5,$17
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$16,$2
	.set	macro
	.set	reorder

	sw	$2,0($16)
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L232
	sw	$2,4($16)
	.set	macro
	.set	reorder

	move	$17,$0
$L232:
	move	$4,$16
	sw	$17,8($4)
	sw	$4,Track_mem
	.set	noreorder
	.set	nomacro
	jal	FeignAlloc__9SimpleMemi
	move	$5,$18
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileatadr
	addu	$5,$2,$19
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	li	$5,31			# 0x0000001f
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,32			# 0x00000020
	lw	$6,Track_mem
	addu	$2,$2,4
	sw	$2,Track_header
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,35			# 0x00000023
	addu	$2,$2,4
	sw	$2,Chunk_chunkCenters
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	move	$5,$2
	lw	$4,Chunk_lightTable
	addu	$3,$5,16
	or	$2,$3,$4
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L233
	addu	$2,$5,1040
	.set	macro
	.set	reorder

$L235:
	lwl	$11,3($3)
	lwr	$11,0($3)
	lwl	$12,7($3)
	lwr	$12,4($3)
	lwl	$13,11($3)
	lwr	$13,8($3)
	lwl	$14,15($3)
	lwr	$14,12($3)
	swl	$11,3($4)
	swr	$11,0($4)
	swl	$12,7($4)
	swr	$12,4($4)
	swl	$13,11($4)
	swr	$13,8($4)
	swl	$14,15($4)
	swr	$14,12($4)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L235
	addu	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L254
	move	$4,$16
	.set	macro
	.set	reorder

$L233:
$L236:
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
	bne	$3,$2,$L236
	addu	$4,$4,16
	.set	macro
	.set	reorder

	move	$4,$16
$L254:
	li	$5,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	move	$6,$0
	move	$18,$6
	li	$22,1023			# 0x000003ff
	move	$19,$6
	move	$21,$6
	lw	$4,Track_mem
	lw	$2,4($2)
	lw	$3,Track_header
	addu	$2,$2,-16
	lw	$3,28($3)
	srl	$2,$2,2
	sw	$2,Chunk_numLight
	sll	$5,$3,3
	addu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lw	$3,Track_header
	lw	$4,Track_mem
	lw	$5,28($3)
	sw	$2,Track_gInViewList
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,Track_header
	lw	$4,Track_mem
	lw	$3,28($3)
	move	$6,$0
	sw	$2,Track_gInViewCount
	sll	$5,$3,3
	subu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	sll	$5,$5,4
	.set	macro
	.set	reorder

	sw	$2,Track_chunkList
	jal	Chunk_Init__Fv
	move	$4,$16
	li	$5,33			# 0x00000021
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,29			# 0x0000001d
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$23,$2
	.set	macro
	.set	reorder

	move	$16,$2
$L237:
	lw	$2,Track_header
	#nop
	lw	$3,28($2)
	#nop
	slt	$2,$18,$3
	beq	$2,$0,$L238
	lw	$2,Track_chunkList
	#nop
	addu	$17,$2,$21
	addu	$2,$3,-1
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L240
	move	$20,$0
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	LocateNextGroupType__15SerializedGroupi
	li	$5,29			# 0x0000001d
	.set	macro
	.set	reorder

	move	$20,$2
$L240:
	move	$4,$17
	lw	$6,Track_mem
	.set	noreorder
	.set	nomacro
	jal	InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$9,12($2)
	addu	$3,$2,16
	slt	$2,$9,37
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L255
	move	$8,$0
	.set	macro
	.set	reorder

	li	$9,36			# 0x00000024
$L255:
	.set	noreorder
	.set	nomacro
	blez	$9,$L242
	move	$5,$8
	.set	macro
	.set	reorder

	move	$7,$3
	lw	$2,Track_gInViewList
	lw	$10,Track_header
	addu	$6,$19,$2
$L243:
	lhu	$4,0($7)
	lw	$3,28($10)
	andi	$2,$4,0x03ff
	slt	$2,$2,$3
	beq	$2,$0,$L246
	sh	$4,0($6)
	addu	$6,$6,2
	addu	$5,$5,1
$L246:
	addu	$8,$8,1
	slt	$2,$8,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L243
	addu	$7,$7,2
	.set	macro
	.set	reorder

$L242:
	lw	$2,Track_gInViewCount
	#nop
	addu	$2,$2,$18
	sb	$5,0($2)
	slt	$2,$5,36
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L248
	sll	$3,$5,1
	.set	macro
	.set	reorder

	lw	$2,Track_gInViewList
	#nop
	addu	$2,$19,$2
	addu	$3,$3,$2
$L249:
	sh	$22,0($3)
	addu	$5,$5,1
	slt	$2,$5,36
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L249
	addu	$3,$3,2
	.set	macro
	.set	reorder

$L248:
	move	$16,$20
	addu	$19,$19,64
	addu	$21,$21,112
	.set	noreorder
	.set	nomacro
	j	$L237
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L238:
	.set	noreorder
	.set	nomacro
	jal	Track_InitPersistentData__FP15SerializedGroup
	move	$4,$23
	.set	macro
	.set	reorder

	lw	$4,Track_mem
	jal	ResizeToFit__9SimpleMem
	lui	$4,%hi($LC11) # high
	.set	noreorder
	.set	nomacro
	jal	Track_MakeTrackPathName__FPc
	addiu	$4,$4,%lo($LC11) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC12) # high
	lw	$2,gPersistObjDef
	addiu	$4,$4,%lo($LC12) # low
	lw	$5,0($2)
	move	$6,$0
	sll	$5,$5,3
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	ori	$5,$5,0x0004
	.set	macro
	.set	reorder

	lw	$4,gPersistObjDef
	move	$5,$2
	sw	$5,gPersistObjDefBoundingSpheres
	jal	CalcObjectBoundingSphere__FP5GroupT0
	lw	$4,gPersistMidgroundObjInst
	lw	$5,gPersistObjDef
	.set	noreorder
	.set	nomacro
	jal	ReduceObjectPrecision__FP5GroupT0i
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,gPersistObjInst
	lw	$5,gPersistObjDef
	jal	InvalidatePersistentCollideBoomObjects__FP5GroupT0
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__11SaveSurfacei
	li	$5,48			# 0x00000030
	.set	macro
	.set	reorder

	sw	$2,Track_gSaveSurface
	jal	Track_LoadObjectKillData__Fv
	lw	$31,176($sp)
	lw	$23,172($sp)
	lw	$22,168($sp)
	lw	$21,164($sp)
	lw	$20,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	Track_Init__FPc
	.text
	.ent	Track_DeInit__Fv
Track_DeInit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lw	$16,Track_mem
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L258
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$4,0($16)
	jal	purgememadr
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	sw	$0,4($4)
	.set	macro
	.set	reorder

$L258:
	lw	$4,Track_gSaveSurface
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L270
	lui	$2,%hi(gInitialArt) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	___11SaveSurface
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$0,Track_gSaveSurface
	lui	$2,%hi(gInitialArt) # high
$L270:
	addiu	$3,$2,%lo(gInitialArt) # low
	lw	$2,4($3)
	#nop
	beq	$2,$0,$L266
	sw	$0,4($3)
$L266:
	jal	BWorldSm_DeInit__Fv
	jal	DeInitArtResources__Fv
	lw	$4,Chunk_lightTable
	#nop
	beq	$4,$0,$L267
	jal	purgememadr
	sw	$0,Chunk_lightTable
$L267:
	lw	$4,gPersistObjDefBoundingSpheres
	#nop
	beq	$4,$0,$L268
	jal	purgememadr
$L268:
	lw	$31,20($sp)
	lw	$16,16($sp)
	sw	$0,gPersistObjDefBoundingSpheres
	sw	$0,gPersistMidgroundObjInst
	sw	$0,gPersistObjInst
	sw	$0,gPersistObjDef
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Track_DeInit__Fv
	.text
	.ent	Track_AnimateTrackLighting__Fv
Track_AnimateTrackLighting__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Track_AnimateTrackLighting__Fv
	.text
	.ent	KillFile_OpenRead__Fv
KillFile_OpenRead__Fv:
	.frame	$sp,152,$31		# vars= 128, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,152
	lui	$4,%hi($LC13) # high
	sw	$31,144($sp)
	.set	noreorder
	.set	nomacro
	jal	Track_MakeTrackPathName__FPc
	addiu	$4,$4,%lo($LC13) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC8) # high
	addiu	$5,$5,%lo($LC8) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$31,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder

	.end	KillFile_OpenRead__Fv
	.text
	.ent	KillFile_ReadEntry__FPciRiT2
KillFile_ReadEntry__FPciRiT2:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$5,$5,3
	addu	$4,$4,$5
	lw	$2,4($4)
	#nop
	sw	$2,0($6)
	lw	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	KillFile_ReadEntry__FPciRiT2
	.text
	.ent	Track_LoadObjectKillData__Fv
Track_LoadObjectKillData__Fv:
	.frame	$sp,56,$31		# vars= 8, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$31,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	KillFile_OpenRead__Fv
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L277
	move	$20,$0
	.set	macro
	.set	reorder

	li	$22,16			# 0x00000010
$L279:
	lw	$2,0($21)
	#nop
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L280
	move	$4,$21
	.set	macro
	.set	reorder

	move	$5,$20
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	KillFile_ReadEntry__FPciRiT2
	addu	$7,$sp,20
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	sll	$3,$2,3
	subu	$3,$3,$2
	lw	$2,Track_chunkList
	sll	$3,$3,4
	addu	$6,$2,$3
	lw	$5,64($6)
	#nop
	beq	$5,$0,$L282
	lw	$2,0($5)
	lw	$4,20($sp)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L282
	addu	$18,$5,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$4,$L289
	move	$3,$0
	.set	macro
	.set	reorder

$L290:
	lh	$2,0($18)
	addu	$3,$3,1
	addu	$18,$18,$2
	slt	$2,$3,$4
	bne	$2,$0,$L290
$L289:
	lw	$2,80($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L292
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$19,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$19,$L292
	addu	$4,$2,4
	.set	macro
	.set	reorder

	move	$16,$4
$L299:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Math_DistXZ__FP8coorddefT0
	addu	$5,$18,8
	.set	macro
	.set	reorder

	slt	$2,$2,6553
	beq	$2,$0,$L300
	sb	$22,19($16)
$L300:
	addu	$17,$17,1
	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L299
	addu	$16,$16,20
	.set	macro
	.set	reorder

$L292:
	lbu	$2,2($18)
	#nop
	ori	$2,$2,0x0080
	sb	$2,2($18)
$L282:
	.set	noreorder
	.set	nomacro
	j	$L279
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L280:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

$L277:
	lw	$31,52($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Track_LoadObjectKillData__Fv
	.text
	.ent	Save__11SaveSurfaceP14Trk_NewSimQuad
Save__11SaveSurfaceP14Trk_NewSimQuad:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$4
	lh	$7,0($6)
	lh	$2,2($6)
	#nop
	slt	$2,$2,$7
	bne	$2,$0,$L306
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L306
	sll	$2,$7,3
	.set	macro
	.set	reorder

	lw	$3,4($6)
	#nop
	addu	$2,$2,$3
	sw	$5,0($2)
	lh	$2,0($6)
	lw	$3,4($6)
	lbu	$4,0($5)
	sll	$2,$2,3
	addu	$2,$2,$3
	sb	$4,4($2)
	lhu	$2,0($6)
	#nop
	addu	$2,$2,1
	sh	$2,0($6)
$L306:
	j	$31
	.end	Save__11SaveSurfaceP14Trk_NewSimQuad
	.text
	.ent	__11SaveSurfacei
__11SaveSurfacei:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$4,%hi($LC14) # high
	addiu	$4,$4,%lo($LC14) # low
	sw	$31,20($sp)
	sh	$5,2($16)
	sll	$5,$5,3
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sh	$0,0($16)
	.set	macro
	.set	reorder

	sw	$2,4($16)
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__11SaveSurfacei
	.text
	.ent	___11SaveSurface
___11SaveSurface:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$16,$5
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	beq	$16,$0,$L312
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L312:
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

	.end	___11SaveSurface
	.text
	.ent	RestoreAll__11SaveSurface
RestoreAll__11SaveSurface:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$4
	lh	$2,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L314
	move	$5,$0
	.set	macro
	.set	reorder

$L315:
	lw	$2,4($6)
	sll	$4,$5,3
	addu	$2,$4,$2
	lw	$3,0($2)
	lbu	$2,4($2)
	#nop
	sb	$2,0($3)
	lw	$2,4($6)
	#nop
	addu	$2,$4,$2
	sw	$0,0($2)
	lw	$2,4($6)
	#nop
	addu	$4,$4,$2
	sb	$0,4($4)
	lh	$2,0($6)
	addu	$5,$5,1
	slt	$2,$5,$2
	bne	$2,$0,$L315
$L314:
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,0($6)
	.set	macro
	.set	reorder

	.end	RestoreAll__11SaveSurface
