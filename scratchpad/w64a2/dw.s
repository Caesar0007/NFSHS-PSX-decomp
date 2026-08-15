	.file	1 "recon/game/psx/draww.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	offsets
	.data
	.align	2
offsets:
	.byte	125
	.byte	125
	.byte	50
	.byte	15
	.byte	-1
	.byte	125
	.byte	0
	.byte	0
	.globl	gIdentTemplate
	.align	2
gIdentTemplate:
	.half	4096
	.half	0
	.space	2
	.space	12
	.space	14
	.globl	trk0
	.align	2
trk0:
	.word	410
	.word	530
	.word	800
	.word	850
	.word	800
	.word	850
	.word	800
	.word	850
	.word	800
	.word	850
	.word	800
	.word	850
	.word	815
	.word	885
	.word	815
	.word	885
	.word	815
	.word	885
	.globl	trk4
	.align	2
trk4:
	.word	300
	.word	440
	.word	300
	.word	440
	.word	300
	.word	440
	.word	300
	.word	440
	.word	300
	.word	440
	.word	705
	.word	910
	.word	705
	.word	910
	.word	705
	.word	910
	.word	705
	.word	910
	.word	705
	.word	910
	.globl	goffsets
	.align	2
goffsets:
	.byte	125
	.byte	125
	.byte	50
	.byte	15
	.byte	-1
	.byte	125
	.byte	0
	.byte	0
	.text
	.align	2
	.globl	DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_DivVertice__FP12Draw_SVertexN20
	.align	2
	.globl	DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
	.align	2
	.globl	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	.align	2
	.globl	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	.align	2
	.globl	DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	Night_NightCopCalc__FP6VECTORPs
	.align	2
	.globl	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
	.align	2
	.globl	DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
	.align	2
	.globl	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
	.align	2
	.globl	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	.align	2
	.globl	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	.align	2
	.globl	DrawW_ResetAnimationTimer__Fv
	.align	2
	.globl	DrawW_GetAnimationTime__FP15Trk_AnimateInst
	.align	2
	.globl	DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
	.align	2
	.globl	DrawW_DoObjectAnimations__Fv
	.align	2
	.globl	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	.align	2
	.globl	DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
	.align	2
	.globl	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	.align	2
	.globl	DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
	.align	2
	.globl	DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	.align	2
	.globl	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
	.align	2
	.globl	Draw_CircleClip__FP8coorddefT0i
	.align	2
	.globl	Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
	.align	2
	.globl	DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
	.align	2
	.globl	DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
	.align	2
	.globl	DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
	.align	2
	.globl	DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
	.align	2
	.globl	DepthCue_Init__Fv
	.globl	DrawW_gChunkGeomRez
	.sdata
	.align	2
DrawW_gChunkGeomRez:
	.space	4
	.globl	DrawW_gChunkInd
	.align	2
DrawW_gChunkInd:
	.space	4
	.globl	DrawW_gChunkObjFlag
	.align	2
DrawW_gChunkObjFlag:
	.space	4
	.globl	DrawW_gChunkQuadCount
	.align	2
DrawW_gChunkQuadCount:
	.space	4
	.globl	DrawW_gChunkRelX
	.align	2
DrawW_gChunkRelX:
	.space	4
	.globl	DrawW_gChunkRelY
	.align	2
DrawW_gChunkRelY:
	.space	4
	.globl	DrawW_gChunkRelZ
	.align	2
DrawW_gChunkRelZ:
	.space	4
	.globl	DrawW_gFog_init
	.align	2
DrawW_gFog_init:
	.space	4
	.globl	DrawW_gGroupCount
	.align	2
DrawW_gGroupCount:
	.space	4
	.globl	DrawW_gMatID_tmp
	.align	2
DrawW_gMatID_tmp:
	.space	4
	.globl	DrawW_gNightFlags
	.align	2
DrawW_gNightFlags:
	.space	4
	.globl	DrawW_gNightTmpFlag
	.align	2
DrawW_gNightTmpFlag:
	.space	4
	.globl	DrawW_gChunkStripBuf
	.align	2
DrawW_gChunkStripBuf:
	.space	4
	.globl	DrawW_gChunkVtxBuf
	.align	2
DrawW_gChunkVtxBuf:
	.space	4
	.globl	DrawW_gGroupPtr
	.align	2
DrawW_gGroupPtr:
	.space	4
	.globl	DrawW_gInitialArtPtr
	.align	2
DrawW_gInitialArtPtr:
	.space	4
	.globl	DrawW_gMaterialLUT
	.align	2
DrawW_gMaterialLUT:
	.space	4
	.globl	DrawW_gObjScratch_148
	.align	2
DrawW_gObjScratch_148:
	.space	4
	.globl	DrawWTrough_scratchVec
	.data
	.align	2
DrawWTrough_scratchVec:
	.space	12
	.globl	gDiv
	.align	2
gDiv:
	.space	240
	.globl	animation_timer
	.align	2
animation_timer:
	.space	48
	.globl	gChunkObjInfo
	.align	2
gChunkObjInfo:
	.space	24
	.globl	gVertex3d
	.align	2
gVertex3d:
	.space	1280
	.globl	stackSpeedUpEnbabledFlag
	.sdata
	.align	2
stackSpeedUpEnbabledFlag:
	.space	4
	.globl	gWSavePtr
	.align	2
gWSavePtr:
	.space	4
	.globl	gSD_gt4counter
	.align	2
gSD_gt4counter:
	.space	4
	.globl	gSD_gt3counter
	.align	2
gSD_gt3counter:
	.space	4
	.globl	gVi
	.align	2
gVi:
	.space	4

	.extern	TrackSpec_gSpec, 264
	.extern	gSpikeBeltX, 4
	.extern	gSpikeBeltSlice, 4
	.extern	BWorldSm_slices, 4
	.extern	gDLPixmap, 40
	.extern	gSkidMarkPixmap, 4
	.extern	Object_customSimObjs, 4
	.extern	Object_customObjInst, 4
	.extern	Track_gInViewList, 4
	.extern	gPersistMidgroundObjInst, 4
	.extern	gPersistObjInst, 4
	.extern	gCurrContext, 4
	.extern	gPersistObjDefBoundingSpheres, 4
	.extern	Track_gObjDefs, 4
	.extern	Anim_gInstanceFromIndex, 32
	.extern	Cars_gHumanRaceCarList, 8
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	simGlobal, 24
	.extern	GameSetup_gData, 2600
	.extern	gCopMat, 36
	.extern	BW_gCopCarObj, 4
	.extern	gNightMat, 36
	.extern	Cars_gList, 8
	.extern	Camera_gInfo, 36992
	.extern	gNight_renderNight, 4
	.extern	Track_materials, 4
	.extern	Chunk_chunkCenters, 4
	.extern	gWorldMat, 36
	.extern	Track_chunkList, 4
	.extern	gInitialArt, 24
	.extern	BWorld_gChunkCount, 4
	.extern	gClutDepth, 8192
	.extern	Draw_gViewOtSize, 4
	.extern	Draw_gMidGroundOtz, 4
	.extern	Chunk_lightTable, 4
	.extern	Night_gCurrentNightColor, 4
	.extern	Night_gWeatherLightingTable, 8
	.extern	Night_gNightTbl, 4
	.extern	Night_gCopColor, 8

	.text
	.text
	.ent	DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$10,16($sp)
	lw	$11,20($sp)
	li	$2,12			# 0x0000000c
	sb	$2,3($4)
	lw	$2,12($5)
	lw	$3,12($6)
	lw	$8,12($7)
	lw	$9,12($10)
	sw	$2,4($4)
	sw	$3,16($4)
	sw	$8,40($4)
	sw	$9,28($4)
	lw	$2,8($5)
	lw	$3,8($6)
	lw	$8,8($7)
	lw	$9,8($10)
	sw	$2,8($4)
	sw	$3,20($4)
	sw	$8,44($4)
	sw	$9,32($4)
	lhu	$2,6($5)
	lhu	$3,6($6)
	lhu	$5,6($7)
	lhu	$6,6($10)
	sh	$2,12($4)
	sh	$3,24($4)
	sh	$5,48($4)
	sh	$6,36($4)
	lbu	$2,279($11)
	lhu	$3,298($11)
	lhu	$5,286($11)
	sb	$2,7($4)
	sh	$3,26($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,14($4)
	.set	macro
	.set	reorder

	.end	DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$9,16($sp)
	li	$2,9			# 0x00000009
	sb	$2,3($4)
	lw	$2,12($5)
	lw	$3,12($6)
	lw	$8,12($7)
	sw	$2,4($4)
	sw	$3,16($4)
	sw	$8,28($4)
	lw	$2,8($5)
	lw	$3,8($6)
	lw	$8,8($7)
	sw	$2,8($4)
	sw	$3,20($4)
	sw	$8,32($4)
	lhu	$2,6($5)
	lhu	$3,6($6)
	lhu	$5,6($7)
	sh	$2,12($4)
	sh	$3,24($4)
	sh	$5,36($4)
	lbu	$2,279($9)
	lhu	$3,298($9)
	lhu	$5,286($9)
	sb	$2,7($4)
	sh	$3,26($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,14($4)
	.set	macro
	.set	reorder

	.end	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_DivVertice__FP12Draw_SVertexN20
DrawW_DivVertice__FP12Draw_SVertexN20:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($5)
	lh	$3,0($6)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,0($4)
	lh	$2,2($5)
	lh	$3,2($6)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,2($4)
	lh	$2,4($5)
	lh	$3,4($6)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sh	$2,4($4)
	lbu	$2,6($5)
	lbu	$3,6($6)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sb	$2,6($4)
	lbu	$2,7($5)
	lbu	$3,7($6)
	#nop
	addu	$2,$2,$3
	addu	$2,$2,1
	sra	$2,$2,1
	sb	$2,7($4)
	lbu	$2,12($5)
	lbu	$3,12($6)
	#nop
	addu	$2,$2,$3
	sra	$2,$2,1
	sb	$2,12($4)
	lbu	$2,13($5)
	lbu	$3,13($6)
	#nop
	addu	$2,$2,$3
	sra	$2,$2,1
	sb	$2,13($4)
	lbu	$2,14($5)
	lbu	$3,14($6)
	#nop
	addu	$2,$2,$3
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,14($4)
	.set	macro
	.set	reorder

	.end	DrawW_DivVertice__FP12Draw_SVertexN20
	.text
	.ent	DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$5,4($5)
	lh	$6,4($6)
	lw	$2,16($sp)
	lh	$7,4($7)
	slt	$3,$6,$5
	lh	$8,4($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L505
	slt	$2,$7,$5
	.set	macro
	.set	reorder

	move	$5,$6
	slt	$2,$7,$5
$L505:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L506
	slt	$2,$8,$5
	.set	macro
	.set	reorder

	move	$5,$7
	slt	$2,$8,$5
$L506:
	beq	$2,$0,$L500
	move	$5,$8
$L500:
	lh	$2,328($4)
	#nop
	addu	$5,$5,$2
	slt	$2,$5,2049
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L501
	slt	$2,$5,1281
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L501:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L502
	slt	$3,$5,513
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L507
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L502:
	li	$2,1			# 0x00000001
$L507:
	j	$31
	.end	DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
	.text
	.ent	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss:
	.frame	$sp,120,$31		# vars= 48, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$18,88($sp)
	move	$18,$4
	sw	$17,84($sp)
	move	$17,$6
	sw	$31,116($sp)
	sw	$fp,112($sp)
	sw	$23,108($sp)
	sw	$22,104($sp)
	sw	$21,100($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$16,80($sp)
	sw	$5,124($sp)
	sw	$7,132($sp)
	lh	$2,8($17)
	lh	$3,16($18)
	lhu	$15,144($sp)
	lw	$fp,136($sp)
	lhu	$20,148($sp)
	slt	$2,$3,$2
	sh	$15,56($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L509
	sh	$20,64($sp)
	.set	macro
	.set	reorder

	lh	$2,8($7)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L509
	lh	$2,8($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L509
	lw	$24,140($sp)
	#nop
	lh	$2,8($24)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L508
$L509:
	lh	$2,8($17)
	#nop
	bgez	$2,$L510
	lw	$25,132($sp)
	#nop
	lh	$2,8($25)
	#nop
	bgez	$2,$L510
	lh	$2,8($fp)
	#nop
	bgez	$2,$L510
	lw	$15,140($sp)
	#nop
	lh	$2,8($15)
	#nop
	bltz	$2,$L508
$L510:
	lh	$2,10($17)
	lh	$3,18($18)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L511
	lw	$20,132($sp)
	#nop
	lh	$2,10($20)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L511
	lh	$2,10($fp)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L511
	lw	$24,140($sp)
	#nop
	lh	$2,10($24)
	#nop
	slt	$2,$3,$2
	bne	$2,$0,$L508
$L511:
	lh	$2,10($17)
	#nop
	bgez	$2,$L512
	lw	$25,132($sp)
	#nop
	lh	$2,10($25)
	#nop
	bgez	$2,$L512
	lh	$2,10($fp)
	#nop
	bgez	$2,$L512
	lw	$15,140($sp)
	#nop
	lh	$2,10($15)
	#nop
	bltz	$2,$L508
$L512:
	lh	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L548
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$20,132($sp)
	#nop
	lh	$2,4($20)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L549
	move	$5,$17
	.set	macro
	.set	reorder

	lh	$2,4($fp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L550
	move	$7,$fp
	.set	macro
	.set	reorder

	lw	$24,140($sp)
	#nop
	lh	$2,4($24)
	#nop
	bltz	$2,$L508
$L548:
	move	$5,$17
$L549:
	move	$7,$fp
$L550:
	lui	$2,%hi(gDiv) # high
	lw	$25,140($sp)
	lw	$6,132($sp)
	addiu	$16,$2,%lo(gDiv) # low
	.set	noreorder
	.set	nomacro
	jal	DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31
	sw	$25,16($sp)
	.set	macro
	.set	reorder

	lw	$15,124($sp)
	#nop
	slt	$2,$15,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L514
	move	$5,$17
	.set	macro
	.set	reorder

	lhu	$20,56($sp)
	lw	$6,132($sp)
	sll	$2,$20,16
	sra	$2,$2,12
	addu	$19,$2,$16
	addu	$3,$20,1
	addu	$24,$3,4
	move	$4,$19
	sll	$2,$3,16
	sra	$2,$2,12
	addu	$21,$2,$16
	addu	$2,$3,1
	sll	$2,$2,16
	sra	$2,$2,12
	addu	$23,$2,$16
	addu	$2,$3,2
	sll	$2,$2,16
	sra	$2,$2,12
	addu	$22,$2,$16
	addu	$3,$3,3
	sll	$3,$3,16
	sra	$3,$3,12
	addu	$3,$3,$16
	sh	$24,56($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DivVertice__FP12Draw_SVertexN20
	sw	$3,72($sp)
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($19)
	lwc2 $1, 4($19)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	move	$4,$21
	lw	$5,132($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DivVertice__FP12Draw_SVertexN20
	move	$6,$fp
	.set	macro
	.set	reorder

	addu	$2,$sp,32
 #APP
	cfc2 $12, $31
	nop
	sw $12, 0($2)
 #NO_APP
	lw	$2,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L515
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L516
	sb	$2,15($19)
	.set	macro
	.set	reorder

$L515:
	sb	$0,15($19)
$L516:
	addu	$2,$19,8
 #APP
	swc2 $14, 0($2)
	lwc2 $0, 0($21)
	lwc2 $1, 4($21)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	move	$4,$23
	lw	$6,140($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DivVertice__FP12Draw_SVertexN20
	move	$5,$fp
	.set	macro
	.set	reorder

	addu	$2,$sp,36
 #APP
	cfc2 $12, $31
	nop
	sw $12, 0($2)
 #NO_APP
	lw	$2,36($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L517
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L518
	sb	$2,15($21)
	.set	macro
	.set	reorder

$L517:
	sb	$0,15($21)
$L518:
	addu	$2,$21,8
 #APP
	swc2 $14, 0($2)
	lwc2 $0, 0($23)
	lwc2 $1, 4($23)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	move	$4,$22
	lw	$5,140($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DivVertice__FP12Draw_SVertexN20
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$2,$sp,40
 #APP
	cfc2 $12, $31
	nop
	sw $12, 0($2)
 #NO_APP
	lw	$2,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L519
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L520
	sb	$2,15($23)
	.set	macro
	.set	reorder

$L519:
	sb	$0,15($23)
$L520:
	addu	$2,$23,8
 #APP
	swc2 $14, 0($2)
	lwc2 $0, 0($22)
	lwc2 $1, 4($22)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	move	$5,$17
	lw	$4,72($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DivVertice__FP12Draw_SVertexN20
	move	$6,$fp
	.set	macro
	.set	reorder

	addu	$2,$sp,44
 #APP
	cfc2 $12, $31
	nop
	sw $12, 0($2)
 #NO_APP
	lw	$2,44($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L521
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L522
	sb	$2,15($22)
	.set	macro
	.set	reorder

$L521:
	sb	$0,15($22)
$L522:
	addu	$2,$22,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	lw	$25,72($sp)
 #APP
	lwc2 $0, 0($25)
	lwc2 $1, 4($25)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$sp,48
 #APP
	cfc2 $12, $31
	nop
	sw $12, 0($2)
 #NO_APP
	lw	$2,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L523
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L524
	sb	$2,15($25)
	.set	macro
	.set	reorder

$L523:
	lw	$15,72($sp)
	#nop
	sb	$0,15($15)
$L524:
	lh	$2,218($18)
	#nop
	beq	$2,$0,$L525
	lbu	$2,279($18)
	#nop
	andi	$2,$2,0x00f7
	sb	$2,279($18)
	lw	$2,148($18)
	lbu	$3,15($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L527
	addu	$16,$2,8
	.set	macro
	.set	reorder

	lw	$20,132($sp)
	#nop
	lbu	$2,15($20)
	#nop
	bne	$2,$0,$L529
	lbu	$2,15($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L527
	li	$11,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$17
	move	$6,$20
	move	$7,$19
	sll	$8,$16,2
	li	$10,-16777216			# 0xff000000
	lw	$2,528482304
	lw	$4,0($11)
	addu	$8,$8,$2
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,40
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	sw	$18,16($sp)
	.set	macro
	.set	reorder

$L527:
	lw	$24,132($sp)
	#nop
	lbu	$2,15($24)
	#nop
	bne	$2,$0,$L529
	lbu	$2,15($fp)
	#nop
	bne	$2,$0,$L533
	lbu	$2,15($21)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L529
	li	$11,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$24
	move	$6,$fp
	move	$7,$21
	sll	$8,$16,2
	li	$10,-16777216			# 0xff000000
	lw	$2,528482304
	lw	$4,0($11)
	addu	$8,$8,$2
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,40
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	sw	$18,16($sp)
	.set	macro
	.set	reorder

$L529:
	lbu	$2,15($fp)
	#nop
	bne	$2,$0,$L533
	lw	$25,140($sp)
	#nop
	lbu	$2,15($25)
	#nop
	bne	$2,$0,$L537
	lbu	$2,15($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L533
	li	$11,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$fp
	move	$6,$25
	move	$7,$23
	sll	$8,$16,2
	li	$10,-16777216			# 0xff000000
	lw	$2,528482304
	lw	$4,0($11)
	addu	$8,$8,$2
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,40
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	sw	$18,16($sp)
	.set	macro
	.set	reorder

$L533:
	lw	$15,140($sp)
	#nop
	lbu	$2,15($15)
	#nop
	bne	$2,$0,$L537
	lbu	$2,15($17)
	#nop
	bne	$2,$0,$L537
	lbu	$2,15($22)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L537
	li	$11,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$15
	move	$6,$17
	move	$7,$22
	sll	$8,$16,2
	li	$10,-16777216			# 0xff000000
	lw	$2,528482304
	lw	$4,0($11)
	addu	$8,$8,$2
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,40
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache
	sw	$18,16($sp)
	.set	macro
	.set	reorder

$L537:
	lbu	$2,279($18)
	#nop
	ori	$2,$2,0x0008
	sb	$2,279($18)
$L525:
	lw	$20,124($sp)
	lw	$24,72($sp)
	addu	$20,$20,1
	addu	$2,$24,8
	sw	$20,124($sp)
 #APP
	swc2 $14, 0($2)
 #NO_APP
	move	$4,$18
	move	$6,$17
	lw	$5,124($sp)
	lhu	$25,56($sp)
	lhu	$15,64($sp)
	move	$7,$19
	sw	$24,16($sp)
	sw	$22,20($sp)
	sll	$17,$25,16
	sra	$17,$17,16
	sll	$16,$15,16
	sra	$16,$16,16
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$5,124($sp)
	lw	$7,132($sp)
	lw	$20,72($sp)
	move	$6,$19
	sw	$21,16($sp)
	sw	$17,24($sp)
	sw	$16,28($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$20,20($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$5,124($sp)
	lw	$6,72($sp)
	move	$7,$21
	sw	$fp,16($sp)
	sw	$23,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$5,124($sp)
	lw	$7,72($sp)
	lw	$24,140($sp)
	move	$6,$22
	sw	$23,16($sp)
	sw	$17,24($sp)
	sw	$16,28($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$24,20($sp)
	.set	macro
	.set	reorder

	j	$L508
$L514:
	lhu	$25,64($sp)
	#nop
	sll	$2,$25,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L551
	addu	$2,$18,148
	.set	macro
	.set	reorder

	lw	$20,8($17)
	lw	$15,132($sp)
	lw	$24,8($fp)
	lw	$15,8($15)
 #APP
	mtc2 $20, $12
	mtc2 $24, $14
	mtc2 $15, $13
	nop
	nop
	.word 0x4B400006
 #NO_APP
	addu	$3,$sp,52
 #APP
	swc2 $24, 0($3)
 #NO_APP
	lw	$2,12($18)
	li	$4,1			# 0x00000001
	bne	$2,$4,$L543
	lw	$2,52($sp)
	#nop
	subu	$2,$0,$2
	sw	$2,52($sp)
$L543:
	lw	$2,52($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L551
	addu	$2,$18,148
	.set	macro
	.set	reorder

	lw	$15,8($17)
	lw	$25,140($sp)
	lw	$20,8($fp)
	lw	$25,8($25)
 #APP
	mtc2 $15, $12
	mtc2 $25, $14
	mtc2 $20, $13
	nop
	nop
	.word 0x4B400006
	swc2 $24, 0($3)
 #NO_APP
	lw	$2,12($18)
	#nop
	bne	$2,$4,$L545
	lw	$2,52($sp)
	#nop
	subu	$2,$0,$2
	sw	$2,52($sp)
$L545:
	lw	$2,52($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L508
	addu	$2,$18,148
	.set	macro
	.set	reorder

$L551:
	lw	$19,4($18)
 #APP
	lw	$t4,0($2)
 lw $t5,0($18)
 addiu $t6,$19,52
 sll $t4,$t4,2
 addu $t5,$t5,$t4
 sw $t6,4($18)
 lwl $t6,2($t5)
 lui $t4,0x0C00
 srl $t6,$t6,8
 or $t6,$t6,$t4
 sll $t4,$19,8
 sw $t6,0($19)
 swl $t4,2($t5)
 #NO_APP
	#nop
	move	$4,$19
	move	$5,$17
	lw	$6,132($sp)
	lw	$15,140($sp)
	move	$7,$fp
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache
	sw	$15,16($sp)
	.set	macro
	.set	reorder

$L508:
	lw	$31,116($sp)
	lw	$fp,112($sp)
	lw	$23,108($sp)
	lw	$22,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	.text
	.ent	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($5)
	lw	$3,4($5)
	lw	$5,8($5)
	sll	$2,$2,2
	sll	$3,$3,18
	sll	$5,$5,2
	andi	$2,$2,0xffff
	or	$3,$3,$2
	sw	$3,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,4($4)
	.set	macro
	.set	reorder

	.end	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	.text
	.ent	DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,64,$31		# vars= 0, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$21,52($sp)
	move	$21,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$20,48($sp)
	addu	$20,$16,332
	move	$4,$20
	addu	$5,$16,152
	sw	$19,44($sp)
	addu	$19,$16,348
	sw	$17,36($sp)
	addu	$17,$16,364
	sw	$18,40($sp)
	sw	$31,56($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$18,$16,380
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$16,168
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$16,184
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$16,200
	.set	macro
	.set	reorder

	addu	$6,$16,272
	lw	$2,8($6)
	lw	$3,20($6)
	lw	$4,44($6)
	lw	$5,32($6)
	sw	$2,8($20)
	sw	$3,8($19)
	sw	$4,8($17)
	sw	$5,8($18)
	lw	$2,160($16)
	#nop
	slt	$2,$2,320
	beq	$2,$0,$L555
 #APP
	lwc2 $0, 0($20)
	lwc2 $1, 4($20)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$16,340
 #APP
	swc2 $14, 0($2)
 #NO_APP
$L555:
	lw	$2,176($16)
	#nop
	slt	$2,$2,320
	beq	$2,$0,$L556
 #APP
	lwc2 $0, 0($19)
	lwc2 $1, 4($19)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$16,356
 #APP
	swc2 $14, 0($2)
 #NO_APP
$L556:
	lw	$2,192($16)
	#nop
	slt	$2,$2,320
	beq	$2,$0,$L557
 #APP
	lwc2 $0, 0($17)
	lwc2 $1, 4($17)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$16,372
 #APP
	swc2 $14, 0($2)
 #NO_APP
$L557:
	lw	$2,208($16)
	#nop
	slt	$2,$2,320
	beq	$2,$0,$L558
 #APP
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$16,388
 #APP
	swc2 $14, 0($2)
 #NO_APP
$L558:
	lw	$2,4($6)
	lw	$3,16($6)
	lw	$4,40($6)
	lw	$5,28($6)
	sw	$2,12($20)
	sw	$3,12($19)
	sw	$4,12($17)
	sw	$5,12($18)
	lhu	$3,12($6)
	lhu	$4,24($6)
	lhu	$5,36($6)
	lhu	$2,48($6)
	sh	$3,6($20)
	sh	$4,6($19)
	sh	$2,6($17)
	sh	$5,6($18)
	lh	$4,8($20)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L562
	sb	$0,15($20)
	.set	macro
	.set	reorder

	lh	$3,10($20)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L562
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L578
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L578
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($20)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L563
$L562:
	li	$2,1			# 0x00000001
$L578:
	sb	$2,15($20)
$L563:
	lh	$4,8($19)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L567
	sb	$0,15($19)
	.set	macro
	.set	reorder

	lh	$3,10($19)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L567
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L579
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L579
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($19)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L568
$L567:
	li	$2,1			# 0x00000001
$L579:
	sb	$2,15($19)
$L568:
	lh	$4,8($17)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L572
	sb	$0,15($17)
	.set	macro
	.set	reorder

	lh	$3,10($17)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L572
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L580
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L580
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($17)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L573
$L572:
	li	$2,1			# 0x00000001
$L580:
	sb	$2,15($17)
$L573:
	lh	$4,8($18)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L574
	sb	$0,15($18)
	.set	macro
	.set	reorder

	lh	$3,10($18)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L574
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L581
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L581
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($18)
	#nop
	slt	$2,$2,101
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L582
	move	$4,$16
	.set	macro
	.set	reorder

$L574:
	li	$2,1			# 0x00000001
$L581:
	sb	$2,15($18)
	move	$4,$16
$L582:
	move	$5,$0
	sltu	$2,$21,1
	move	$6,$20
	move	$7,$19
	sw	$17,16($sp)
	sw	$18,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$2,28($sp)
	.set	macro
	.set	reorder

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

	.end	DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
	.text
	.ent	Night_NightCopCalc__FP6VECTORPs
Night_NightCopCalc__FP6VECTORPs:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	#nop
	addu	$2,$3,2047
	sltu	$2,$2,4095
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L588
	move	$7,$5
	.set	macro
	.set	reorder

	lw	$6,0($4)
	#nop
	addu	$2,$6,1023
	sltu	$2,$2,2047
	beq	$2,$0,$L588
	.set	noreorder
	.set	nomacro
	bgez	$3,$L586
	move	$5,$0
	.set	macro
	.set	reorder

	subu	$3,$0,$3
	li	$5,1			# 0x00000001
$L586:
	sra	$3,$3,5
	addu	$6,$6,1024
	sra	$6,$6,5
	sll	$4,$5,2
	sll	$2,$3,6
	lw	$3,Night_gNightTbl
	addu	$2,$2,$6
	addu	$3,$3,$2
	lui	$2,%hi(Night_gCopColor) # high
	addiu	$2,$2,%lo(Night_gCopColor) # low
	addu	$4,$4,$2
	lbu	$5,0($3)
	lh	$2,0($7)
	lw	$3,0($4)
	sra	$5,$5,1
	sll	$2,$2,3
	addu	$2,$2,$3
	addu	$2,$2,$5
	lbu	$2,0($2)
	#nop
	sh	$2,0($7)
$L588:
	j	$31
	.end	Night_NightCopCalc__FP6VECTORPs
	.text
	.ent	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$10,1			# 0x00000001
	lbu	$2,267($6)
	lw	$7,8($4)
	lh	$8,264($6)
	lbu	$3,268($6)
	addu	$2,$2,6
	sll	$2,$10,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L590
	addu	$9,$8,$2
	.set	macro
	.set	reorder

	lbu	$2,269($6)
 #APP
 #NO_APP
	lui	$3,%hi(Night_gWeatherLightingTable) # high
	addiu	$3,$3,%lo(Night_gWeatherLightingTable) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lh	$3,0($5)
	lw	$2,0($2)
	#nop
	addu	$2,$2,$3
	lbu	$2,0($2)
	#nop
	sh	$2,0($5)
$L590:
	slt	$2,$8,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L596
	slt	$2,$7,$9
	.set	macro
	.set	reorder

	beq	$2,$0,$L596
	lbu	$9,266($6)
	lw	$4,0($4)
	addu	$2,$9,5
	sll	$3,$10,$2
	subu	$2,$0,$3
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L596
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L596
	subu	$7,$7,$8
	.set	macro
	.set	reorder

	addu	$4,$4,$3
	lbu	$2,267($6)
	sra	$4,$4,$9
	sra	$7,$7,$2
	sll	$3,$7,6
	addu	$3,$3,$4
	lw	$4,Night_gNightTbl
	lh	$2,0($5)
	addu	$4,$4,$3
	sll	$2,$2,4
	lw	$3,Night_gCurrentNightColor
	lbu	$4,0($4)
	addu	$2,$2,$3
	addu	$2,$2,$4
	lbu	$2,0($2)
	#nop
	sh	$2,0($5)
$L596:
	j	$31
	.end	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32:
	.frame	$sp,64,$31		# vars= 16, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$17,36($sp)
	move	$17,$4
	sw	$19,44($sp)
	move	$19,$5
	sw	$18,40($sp)
	move	$18,$6
	sw	$20,48($sp)
	sw	$22,56($sp)
	lw	$22,80($sp)
	li	$3,-1			# 0xffffffff
	sw	$31,60($sp)
	sw	$21,52($sp)
	sw	$16,32($sp)
	lh	$2,216($17)
	lw	$21,84($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L598
	move	$20,$7
	.set	macro
	.set	reorder

	lbu	$2,262($17)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L599
	addu	$2,$17,52
	.set	macro
	.set	reorder

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
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	addu	$16,$sp,16
 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($20)
	lwc2 $1, 4($20)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	addu	$5,$18,6
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($22)
	lwc2 $1, 4($22)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	addu	$5,$20,6
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($21)
	lwc2 $1, 4($21)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	addu	$5,$22,6
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
 #NO_APP
	move	$4,$16
	addu	$5,$21,6
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

$L599:
	lbu	$2,262($17)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	addu	$2,$17,84
	.set	macro
	.set	reorder

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
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	addu	$16,$sp,16
 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($20)
	lwc2 $1, 4($20)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$18,6
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($22)
	lwc2 $1, 4($22)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$20,6
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
	lwc2 $0, 0($21)
	lwc2 $1, 4($21)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$22,6
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($16)
	swc2 $26, 4($16)
	swc2 $27, 8($16)
 #NO_APP
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$21,6
	.set	macro
	.set	reorder

$L600:
	lh	$6,6($18)
	lw	$5,Chunk_lightTable
	lh	$4,6($20)
	lh	$3,6($21)
	lh	$2,6($22)
	sll	$6,$6,2
	addu	$6,$6,$5
	sll	$4,$4,2
	addu	$4,$4,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$5,0($6)
	lw	$4,0($4)
	lw	$3,0($3)
	lw	$2,0($2)
	sw	$5,4($19)
	sw	$4,16($19)
	.set	noreorder
	.set	nomacro
	j	$L605
	sw	$3,28($19)
	.set	macro
	.set	reorder

$L598:
	lbu	$2,262($17)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	addu	$2,$17,52
	.set	macro
	.set	reorder

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
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	addu	$4,$sp,16
 #APP
	swc2 $25, 0($4)
	swc2 $26, 4($4)
	swc2 $27, 8($4)
 #NO_APP
	addu	$5,$17,216
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

$L606:
	lbu	$2,262($17)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	addu	$2,$17,84
	.set	macro
	.set	reorder

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
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	addu	$4,$sp,16
 #APP
	swc2 $25, 0($4)
	swc2 $26, 4($4)
	swc2 $27, 8($4)
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$17,216
	.set	macro
	.set	reorder

$L607:
	lh	$2,216($17)
	lw	$3,Chunk_lightTable
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,4($19)
	sw	$2,16($19)
	sw	$2,28($19)
$L605:
	sw	$2,40($19)
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

	.end	DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
	.text
	.ent	DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad:
	.frame	$sp,136,$31		# vars= 80, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$16,104($sp)
	move	$16,$4
	move	$12,$5
	sw	$31,132($sp)
	sw	$22,128($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$18,112($sp)
	sw	$17,108($sp)
	lw	$17,4($16)
	lbu	$2,3($12)
	lw	$9,224($16)
	lhu	$6,244($16)
	lhu	$5,246($16)
	lbu	$3,2($12)
	lbu	$8,4($12)
	lbu	$7,5($12)
	lhu	$4,248($16)
	sll	$2,$2,3
	addu	$2,$9,$2
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$4,$4,16
	sra	$4,$4,16
	lw	$10,0($2)
	lw	$2,4($2)
	sra	$11,$10,16
	addu	$10,$10,$6
	addu	$11,$11,$5
	sw	$2,28($sp)
	addu	$2,$2,$4
	sh	$2,28($sp)
	addu	$2,$sp,24
	sh	$10,24($sp)
	sh	$11,26($sp)
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
 #NO_APP
	andi	$3,$3,0x00ff
	sll	$3,$3,3
	addu	$2,$9,$3
 #APP
	.word 0x4A180001
 #NO_APP
	lw	$10,0($2)
	lw	$2,4($2)
	sra	$11,$10,16
	addu	$10,$10,$6
	addu	$11,$11,$5
	sw	$2,36($sp)
	addu	$2,$2,$4
	sh	$2,36($sp)
	addu	$2,$16,152
	sh	$10,32($sp)
	sh	$11,34($sp)
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	addu	$2,$sp,64
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$2,$sp,32
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
 #NO_APP
	andi	$7,$7,0x00ff
	sll	$7,$7,3
	addu	$2,$9,$7
 #APP
	.word 0x4A180001
 #NO_APP
	lw	$10,0($2)
	lw	$2,4($2)
	sra	$11,$10,16
	addu	$10,$10,$6
	addu	$11,$11,$5
	sw	$2,44($sp)
	addu	$2,$2,$4
	sh	$2,44($sp)
	addu	$2,$16,168
	sh	$10,40($sp)
	sh	$11,42($sp)
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	addu	$2,$sp,40
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
 #NO_APP
	andi	$8,$8,0x00ff
	sll	$8,$8,3
	addu	$2,$9,$8
 #APP
	.word 0x4A180001
 #NO_APP
	lw	$10,0($2)
	lw	$2,4($2)
	sra	$11,$10,16
	addu	$10,$10,$6
	addu	$11,$11,$5
	sw	$2,52($sp)
	addu	$2,$2,$4
	sh	$2,52($sp)
	addu	$2,$16,184
	sh	$10,48($sp)
	sh	$11,50($sp)
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	addu	$2,$sp,48
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$16,200
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$3,200($16)
	lw	$2,208($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L611
	lw	$3,152($16)
	lw	$2,160($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L611
	lw	$3,168($16)
	lw	$2,176($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L611
	lw	$3,184($16)
	lw	$2,192($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L609
$L611:
	lw	$2,200($16)
	lw	$3,208($16)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L612
	lw	$2,152($16)
	lw	$3,160($16)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L612
	lw	$2,168($16)
	lw	$3,176($16)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L612
	lw	$2,184($16)
	lw	$3,192($16)
	subu	$2,$0,$2
	slt	$3,$3,$2
	bne	$3,$0,$L609
$L612:
	lw	$2,160($16)
	#nop
	bgez	$2,$L613
	lw	$2,176($16)
	#nop
	bgez	$2,$L613
	lw	$2,192($16)
	#nop
	bgez	$2,$L613
	lw	$2,208($16)
	#nop
	bltz	$2,$L609
$L613:
 #APP
	.word 0x4B68002E
 #NO_APP
	lh	$2,0($12)
	lw	$3,240($16)
	sll	$2,$2,2
	addu	$6,$3,$2
	addu	$2,$16,148
	lbu	$20,0($6)
 #APP
	swc2 $7, 0($2)
 #NO_APP
	addu	$4,$sp,68
	addu	$3,$sp,72
	srl	$2,$20,3
	andi	$22,$2,0x0002
	addu	$2,$sp,76
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
 #NO_APP
	lw	$2,148($16)
	.set	noreorder
	.set	nomacro
	bne	$22,$0,$L614
	slt	$21,$2,200
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L646
	addu	$2,$sp,84
	.set	macro
	.set	reorder

 #APP
	.word 0x4B400006
 #NO_APP
	addu	$3,$sp,80
 #APP
	swc2 $24, 0($3)
 #NO_APP
	lw	$2,12($16)
	li	$4,1			# 0x00000001
	bne	$2,$4,$L615
	lw	$2,80($sp)
	#nop
	subu	$2,$0,$2
	sw	$2,80($sp)
$L615:
	lw	$2,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L646
	addu	$2,$sp,84
	.set	macro
	.set	reorder

	lw	$15,64($sp)
	lw	$24,68($sp)
	lw	$25,76($sp)
 #APP
	mtc2 $15, $12
	mtc2 $25, $14
	mtc2 $24, $13
	nop
	nop
	.word 0x4B400006
	swc2 $24, 0($3)
 #NO_APP
	lw	$2,12($16)
	#nop
	bne	$2,$4,$L617
	lw	$2,80($sp)
	#nop
	subu	$2,$0,$2
	sw	$2,80($sp)
$L617:
	lw	$2,80($sp)
	#nop
	bltz	$2,$L609
$L614:
	addu	$2,$sp,84
$L646:
 #APP
	swc2 $8, 0($2)
 #NO_APP
	lw	$2,252($16)
	lh	$4,2($6)
	lw	$5,12($2)
	sll	$2,$4,4
	addu	$18,$5,$2
	andi	$2,$20,0x0008
	beq	$2,$0,$L619
	lbu	$2,270($16)
	#nop
	beq	$2,$0,$L619
	lh	$3,220($16)
	lw	$2,148($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L619
	lbu	$2,1($6)
	#nop
	addu	$2,$4,$2
	sll	$2,$2,4
	addu	$18,$5,$2
$L619:
	lw	$5,148($16)
	lw	$4,236($16)
	lw	$3,Draw_gMidGroundOtz
	sra	$2,$5,1
	move	$19,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L620
	sw	$19,148($16)
	.set	macro
	.set	reorder

	sll	$19,$19,2
	sra	$2,$5,4
	.set	noreorder
	.set	nomacro
	j	$L643
	addu	$2,$2,$4
	.set	macro
	.set	reorder

$L620:
	addu	$2,$19,$4
$L643:
	sw	$2,148($16)
	lw	$3,148($16)
	#nop
	blez	$3,$L609
	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	andi	$2,$20,0x0080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	li	$10,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$10,$10,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	li	$9,-16777216			# 0xff000000
	sh	$0,60($sp)
	sh	$0,62($sp)
	sh	$0,56($sp)
	sh	$0,58($sp)
	lw	$2,148($16)
	lw	$8,528482304
	lw	$4,0($10)
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$3,0($4)
	lw	$2,0($2)
	and	$3,$3,$9
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$6,148($16)
	addu	$5,$sp,56
	sll	$6,$6,2
	addu	$6,$6,$8
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($10)
	and	$3,$4,$7
	and	$2,$2,$9
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetTexWindow
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L623:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L624
	addu	$2,$16,148
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L625
	addu	$17,$16,272
	.set	macro
	.set	reorder

$L624:
 #APP
	lw	$t4,0($2)
 lw $t5,0($16)
 addiu $t6,$17,52
 sll $t4,$t4,2
 addu $t5,$t5,$t4
 sw $t6,4($16)
 lwl $t6,2($t5)
 lui $t4,0x0C00
 srl $t6,$t6,8
 or $t6,$t6,$t4
 sll $t4,$17,8
 sw $t6,0($17)
 swl $t4,2($t5)
 #NO_APP
$L625:
	lw	$2,64($sp)
	lw	$3,68($sp)
	lw	$4,76($sp)
	lw	$5,72($sp)
	sw	$2,8($17)
	sw	$3,20($17)
	sw	$4,32($17)
	sw	$5,44($17)
	lbu	$2,262($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$17
	addu	$2,$sp,40
	sw	$2,16($sp)
	addu	$2,$sp,48
	addu	$6,$sp,24
	addu	$7,$sp,32
	.set	noreorder
	.set	nomacro
	jal	DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L644
	li	$2,12			# 0x0000000c
	.set	macro
	.set	reorder

$L626:
	lw	$15,84($sp)
 #APP
	mtc2 $15, $8
 #NO_APP
	lh	$4,216($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L628
	sll	$2,$4,2
	.set	macro
	.set	reorder

	lh	$2,46($sp)
	lw	$5,Chunk_lightTable
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$2,0($2)
	addu	$6,$sp,88
	sw	$2,88($sp)
 #APP
	lwc2 $6, 0($6)
	nop
	nop
	.word 0x4A780010
 #NO_APP
	lh	$4,30($sp)
	lh	$3,38($sp)
	lh	$2,54($sp)
	sll	$4,$4,2
	addu	$4,$4,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$2,0($2)
	lw	$4,0($4)
	lw	$3,0($3)
	sw	$2,96($sp)
	addu	$2,$17,40
	sw	$4,88($sp)
	sw	$3,92($sp)
 #APP
	swc2 $22, 0($2)
 #NO_APP
	addu	$3,$sp,92
	addu	$2,$sp,96
 #APP
	lwc2 $20, 0($6)
	lwc2 $21, 0($3)
	lwc2 $22, 0($2)
	lwc2 $6, 0($2)
	nop
	nop
	.word 0x4AF8002A
 #NO_APP
	addu	$4,$17,4
	addu	$3,$17,16
	addu	$2,$17,28
 #APP
	swc2 $20, 0($4)
	swc2 $21, 0($3)
	swc2 $22, 0($2)
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L644
	li	$2,12			# 0x0000000c
	.set	macro
	.set	reorder

$L628:
	lw	$3,Chunk_lightTable
	#nop
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,100($sp)
	addu	$2,$sp,100
 #APP
	lwc2 $6, 0($2)
	nop
	nop
	.word 0x4A780010
	swc2 $22, 0($2)
 #NO_APP
	lw	$2,100($sp)
	#nop
	sw	$2,4($17)
	sw	$2,16($17)
	sw	$2,28($17)
	sw	$2,40($17)
	li	$2,12			# 0x0000000c
$L644:
	sb	$2,3($17)
	lbu	$2,14($18)
	#nop
	ori	$2,$2,0x003c
	sb	$2,7($17)
	lw	$2,0($18)
	lw	$3,4($18)
	lw	$4,8($18)
	lw	$5,12($18)
	sw	$2,12($17)
	sw	$3,24($17)
	lhu	$3,14($17)
	li	$2,65535			# 0x0000ffff
	sw	$4,36($17)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L630
	sw	$5,48($17)
	.set	macro
	.set	reorder

	lh	$2,220($16)
	lh	$3,222($16)
	subu	$2,$19,$2
	sll	$2,$2,4
	sra	$5,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L631
	slt	$2,$5,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L632
	move	$5,$0
	.set	macro
	.set	reorder

$L631:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	lui	$4,%hi(gClutDepth) # high
	.set	macro
	.set	reorder

	li	$5,15			# 0x0000000f
$L632:
	lui	$4,%hi(gClutDepth) # high
$L647:
	addiu	$4,$4,%lo(gClutDepth) # low
	lhu	$3,10($18)
	sll	$2,$5,1
	sll	$3,$3,5
	addu	$2,$2,$3
	addu	$2,$2,$4
	lhu	$2,0($2)
	#nop
	sh	$2,14($17)
$L630:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L634
	addu	$2,$16,116
	.set	macro
	.set	reorder

	lbu	$17,263($16)
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
 #NO_APP
	#nop
	bne	$17,$0,$L635
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L635:
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	move	$4,$22
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	j	$L645
	addu	$2,$16,20
	.set	macro
	.set	reorder

$L636:
	.set	noreorder
	.set	nomacro
	jal	DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$2,$16,20
$L645:
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
 #NO_APP
	bne	$17,$0,$L634
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L634:
	andi	$2,$20,0x0080
	beq	$2,$0,$L609
	lbu	$3,12($18)
	lbu	$2,0($18)
	#nop
	subu	$4,$3,$2
	bgez	$4,$L640
	subu	$4,$0,$4
$L640:
	lbu	$3,13($18)
	lbu	$2,1($18)
	#nop
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L648
	li	$10,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L648:
	ori	$10,$10,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$2,$4,1
	sh	$2,60($sp)
	addu	$2,$3,1
	li	$9,-16777216			# 0xff000000
	sh	$2,62($sp)
	sh	$0,56($sp)
	sh	$0,58($sp)
	lw	$2,148($16)
	lw	$8,528482304
	lw	$4,0($10)
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$3,0($4)
	lw	$2,0($2)
	and	$3,$3,$9
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$6,148($16)
	addu	$5,$sp,56
	sll	$6,$6,2
	addu	$6,$6,$8
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($10)
	and	$3,$4,$7
	and	$2,$2,$9
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetTexWindow
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L609:
	lw	$31,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
	.text
	.ent	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	li	$2,-1			# 0xffffffff
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$16,231($18)
	lw	$17,232($18)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L649
	move	$19,$2
	.set	macro
	.set	reorder

$L651:
	lw	$2,4($18)
	lw	$3,8($18)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$17,$17,6
$L654:
	addu	$16,$16,-1
	bne	$16,$19,$L651
$L649:
	lw	$31,32($sp)
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

	.end	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$4
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$17,256($19)
	li	$2,1			# 0x00000001
	sh	$2,218($19)
$L660:
	lhu	$2,260($19)
	li	$3,-1			# 0xffffffff
	addu	$2,$2,-1
	sh	$2,260($19)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L657
	move	$16,$0
	.set	macro
	.set	reorder

	lbu	$20,2($17)
	addu	$18,$17,4
$L664:
	slt	$2,$16,$20
	beq	$2,$0,$L663
	lw	$2,4($19)
	lw	$3,8($19)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	move	$4,$19
	.set	macro
	.set	reorder

	lhu	$2,0($18)
	addu	$5,$sp,16
	sh	$2,16($sp)
	lbu	$2,0($17)
	lbu	$3,1($17)
	addu	$2,$2,$16
	sb	$2,19($sp)
	addu	$2,$2,1
	addu	$3,$3,$16
	sb	$3,20($sp)
	addu	$3,$3,1
	sb	$2,18($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad
	sb	$3,21($sp)
	.set	macro
	.set	reorder

$L666:
	addu	$18,$18,2
	.set	noreorder
	.set	nomacro
	j	$L664
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L663:
	lbu	$2,3($17)
	.set	noreorder
	.set	nomacro
	j	$L660
	addu	$17,$17,$2
	.set	macro
	.set	reorder

$L657:
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

	.end	DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry:
	.frame	$sp,96,$31		# vars= 40, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$19,68($sp)
	move	$19,$4
	sw	$20,72($sp)
	move	$20,$5
	sw	$fp,88($sp)
	move	$fp,$0
	sw	$22,80($sp)
	li	$22,-1			# 0xffffffff
	sw	$21,76($sp)
	addu	$21,$sp,32
	sw	$23,84($sp)
	li	$23,1			# 0x00000001
	sw	$16,56($sp)
	li	$16,528482304			# 0x1f800000
	lw	$7,BWorld_gChunkCount
	lui	$2,%hi(gIdentTemplate) # high
	sw	$31,92($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$7,48($sp)
	sh	$23,218($16)
	la	$7,528482420
	addiu	$10,$2,%lo(gIdentTemplate)
	lw	$8,0($10)
	lw	$9,4($10)
	sw	$8,0($7)
	sw	$9,4($7)
	lw	$8,8($10)
	lw	$9,12($10)
	sw	$8,8($7)
	sw	$9,12($7)
	lw	$8,16($10)
	lw	$9,20($10)
	sw	$8,16($7)
	sw	$9,20($7)
	lw	$8,24($10)
	lw	$9,28($10)
	sw	$8,24($7)
	sw	$9,28($7)
	sh	$0,328($16)
$L671:
	lw	$8,48($sp)
	#nop
	slt	$2,$fp,$8
	beq	$2,$0,$L670
	lbu	$2,3($20)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	lui	$2,%hi(gInitialArt) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(gInitialArt) # low
	lui	$4,%hi(gWorldMat) # high
	sw	$2,252($16)
	lbu	$2,0($20)
	addiu	$4,$4,%lo(gWorldMat) # low
	sb	$2,228($16)
	lbu	$2,2($20)
	lbu	$3,228($16)
	addu	$5,$16,20
	sb	$2,229($16)
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	addu	$17,$3,$2
	.set	macro
	.set	reorder

	sb	$0,262($16)
	lw	$2,108($17)
	lbu	$4,228($16)
	lw	$3,Track_materials
	sh	$22,216($16)
	addu	$2,$2,4
	sw	$2,224($16)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	sw	$3,240($16)
	lw	$3,Chunk_chunkCenters
	lw	$4,gNight_renderNight
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L676
	addu	$18,$3,$2
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	lui	$9,%hi(Camera_gInfo) # high
	sb	$2,262($16)
	lw	$5,4($19)
	addiu	$9,$9,%lo(Camera_gInfo) # low
	sll	$2,$5,$2
	addu	$2,$2,$5
	sll	$2,$2,4
	addu	$2,$2,$9
	lw	$4,4($2)
	lw	$2,0($18)
	lw	$3,160($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	mult	$2,$2
	lw	$3,168($4)
	lw	$2,8($18)
	mflo	$6
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	mult	$2,$2
	li	$3,75300864			# 0x047d0000
	ori	$3,$3,0xffff
	mflo	$2
	#nop
	#nop
	addu	$2,$6,$2
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L677
	lui	$3,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lbu	$2,1095($2)
	#nop
	andi	$2,$2,0x0006
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	sb	$2,262($16)
$L678:
	lui	$7,%hi(Camera_gInfo) # high
	lw	$3,4($19)
	addiu	$7,$7,%lo(Camera_gInfo) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$7
	lw	$2,4($2)
	lui	$8,%hi(Camera_gInfo) # high
	lw	$3,160($2)
	lw	$2,8($19)
	addiu	$8,$8,%lo(Camera_gInfo) # low
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$3,4($19)
	addu	$4,$sp,16
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$8
	lw	$2,4($2)
	lui	$9,%hi(Camera_gInfo) # high
	lw	$3,164($2)
	lw	$2,12($19)
	addiu	$9,$9,%lo(Camera_gInfo) # low
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,4($19)
	lui	$5,%hi(gNightMat) # high
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$9
	lw	$2,4($2)
	addiu	$5,$5,%lo(gNightMat) # low
	lw	$3,168($2)
	lw	$2,16($19)
	move	$6,$21
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$16,52
	.set	macro
	.set	reorder

$L677:
	lw	$4,BW_gCopCarObj
	#nop
	beq	$4,$0,$L676
	lw	$3,160($4)
	lw	$2,0($18)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	mult	$2,$2
	lw	$3,168($4)
	lw	$2,8($18)
	mflo	$5
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	mult	$2,$2
	li	$3,75300864			# 0x047d0000
	ori	$3,$3,0xffff
	mflo	$2
	#nop
	#nop
	addu	$2,$5,$2
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L676
	move	$6,$4
	.set	macro
	.set	reorder

	lbu	$2,262($16)
	addu	$4,$sp,16
	ori	$2,$2,0x0002
	sb	$2,262($16)
	lw	$3,160($6)
	lw	$2,8($19)
	lui	$5,%hi(gCopMat) # high
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$3,164($6)
	lw	$2,12($19)
	addiu	$5,$5,%lo(gCopMat) # low
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,168($6)
	lw	$2,16($19)
	move	$6,$21
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$16,84
	.set	macro
	.set	reorder

$L676:
	lw	$3,8($19)
	lw	$2,0($18)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,244($16)
	lw	$3,12($19)
	lw	$2,4($18)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,246($16)
	lw	$3,16($19)
	lw	$2,8($18)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,248($16)
	addu	$2,$16,20
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($16)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lbu	$2,229($16)
	#nop
	beq	$2,$0,$L681
	lw	$3,56($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L685
	addu	$2,$3,4
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,256($16)
	lhu	$2,0($3)
	li	$7,125			# 0x0000007d
	sw	$7,236($16)
	.set	noreorder
	.set	nomacro
	jal	DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
	sh	$2,260($16)
	.set	macro
	.set	reorder

	lbu	$2,37($17)
	#nop
	sb	$2,231($16)
	andi	$2,$2,0x00ff
	beq	$2,$0,$L685
	lw	$2,52($17)
	.set	noreorder
	.set	nomacro
	j	$L695
	sw	$2,232($16)
	.set	macro
	.set	reorder

$L681:
	lw	$2,60($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L686
	addu	$2,$2,4
	.set	macro
	.set	reorder

	sw	$2,256($16)
	lw	$2,60($17)
	lw	$3,256($16)
	lhu	$2,0($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L686
	sh	$2,260($16)
	.set	macro
	.set	reorder

	li	$8,125			# 0x0000007d
	sw	$8,236($16)
	.set	noreorder
	.set	nomacro
	jal	DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache
	move	$4,$16
	.set	macro
	.set	reorder

$L686:
	lbu	$2,32($17)
	#nop
	sb	$2,231($16)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,40($17)
	li	$9,125			# 0x0000007d
	sw	$9,236($16)
	sb	$23,263($16)
	sh	$22,216($16)
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sw	$2,232($16)
	.set	macro
	.set	reorder

$L688:
	lbu	$2,33($17)
	#nop
	sb	$2,231($16)
	andi	$2,$2,0x00ff
	beq	$2,$0,$L685
	lw	$2,44($17)
	#nop
	sw	$2,232($16)
$L695:
	move	$4,$16
	li	$2,30			# 0x0000001e
	sw	$2,236($16)
	sb	$23,263($16)
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sh	$22,216($16)
	.set	macro
	.set	reorder

$L685:
	lw	$2,92($17)
	#nop
	addu	$2,$2,4
	sw	$2,224($16)
	lbu	$2,34($17)
	#nop
	sb	$2,231($16)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	li	$10,125			# 0x0000007d
	.set	macro
	.set	reorder

	sw	$10,236($16)
	sb	$23,263($16)
	sh	$22,216($16)
	lw	$2,96($17)
	move	$4,$16
	addu	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sw	$2,232($16)
	.set	macro
	.set	reorder

$L690:
	lbu	$2,35($17)
	#nop
	sb	$2,231($16)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	li	$2,50			# 0x00000032
	.set	macro
	.set	reorder

	sw	$2,236($16)
	sb	$23,263($16)
	sh	$22,216($16)
	lw	$2,100($17)
	move	$4,$16
	addu	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sw	$2,232($16)
	.set	macro
	.set	reorder

$L675:
	addu	$20,$20,4
	.set	noreorder
	.set	nomacro
	j	$L671
	addu	$fp,$fp,1
	.set	macro
	.set	reorder

$L670:
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
	.text
	.ent	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	lw	$3,12($4)
	lw	$6,24($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$6,$6,4
	sh	$2,0($5)
	sh	$3,2($5)
	sh	$6,4($5)
	lw	$2,4($4)
	lw	$3,16($4)
	lw	$6,28($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$6,$6,4
	sh	$2,6($5)
	sh	$3,8($5)
	sh	$6,10($5)
	lw	$2,8($4)
	lw	$3,20($4)
	lw	$4,32($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,12($5)
	sh	$3,14($5)
	sh	$4,16($5)
 #APP
	lw   $12, 0($5)
	lw   $13, 4($5)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($5)
	lw   $13, 12($5)
	lw   $14, 16($5)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	j	$31
	.end	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	.text
	.ent	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	lw	$3,4($4)
	lw	$4,8($4)
	sra	$2,$2,10
	sra	$3,$3,10
	sra	$4,$4,10
	sw	$2,20($5)
	sw	$3,24($5)
	sw	$4,28($5)
 #APP
	lw   $12, 20($5)
	lw   $13, 24($5)
	ctc2 $12, $5
	lw   $14, 28($5)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	j	$31
	.end	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	.text
	.ent	DrawW_ResetAnimationTimer__Fv
DrawW_ResetAnimationTimer__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,11			# 0x0000000b
	lui	$2,%hi(animation_timer) # high
	addiu	$2,$2,%lo(animation_timer) # low
	addu	$2,$2,44
$L701:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L701
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	j	$31
	.end	DrawW_ResetAnimationTimer__Fv
	.text
	.ent	DrawW_GetAnimationTime__FP15Trk_AnimateInst
DrawW_GetAnimationTime__FP15Trk_AnimateInst:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lbu	$3,3($4)
	lw	$5,%lo(GameSetup_gData+60)($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L708
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L708
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	bne	$5,$2,$L707
$L708:
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	j	$31
$L707:
	lh	$2,8($4)
	lh	$3,10($4)
	addu	$2,$2,-2
	mult	$2,$3
	lui	$3,%hi(animation_timer) # high
	lbu	$2,3($4)
	addiu	$3,$3,%lo(animation_timer) # low
	addu	$2,$2,-1
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	move	$3,$2
	mflo	$5
	#nop
	#nop
	slt	$2,$3,$5
	bne	$2,$0,$L709
	move	$3,$5
$L709:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	DrawW_GetAnimationTime__FP15Trk_AnimateInst
	.text
	.ent	DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
DrawW_SetAnimationTime__FP15Trk_AnimateInstPii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,3($4)
	#nop
	addu	$4,$2,-1
	lui	$2,%hi(animation_timer) # high
	addiu	$2,$2,%lo(animation_timer) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	slt	$2,$2,3841
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L713
	lui	$2,%hi(animation_timer) # high
	.set	macro
	.set	reorder

	move	$7,$0
	lw	$8,Cars_gNumHumanRaceCars
	sll	$2,$4,3
	addu	$5,$2,$5
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$6,$2,%lo(Cars_gHumanRaceCarList) # low
$L714:
	slt	$2,$7,$8
	beq	$2,$0,$L727
	lw	$2,0($6)
	#nop
	lh	$4,8($2)
	lw	$2,0($5)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L719
	lw	$2,4($5)
	#nop
	slt	$2,$2,$4
	beq	$2,$0,$L718
$L719:
	sw	$0,0($3)
$L718:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L714
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L713:
	addiu	$2,$2,%lo(animation_timer) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L721
	move	$7,$0
	.set	macro
	.set	reorder

	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($3)
	.set	macro
	.set	reorder

$L721:
	lw	$8,Cars_gNumHumanRaceCars
	sll	$2,$4,3
	addu	$5,$2,$5
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$6,$2,%lo(Cars_gHumanRaceCarList) # low
$L722:
	slt	$2,$7,$8
	beq	$2,$0,$L727
	lw	$2,0($6)
	#nop
	lh	$4,8($2)
	lw	$2,0($5)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L726
	lw	$2,4($5)
	#nop
	slt	$2,$2,$4
	bne	$2,$0,$L726
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
$L726:
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L722
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L727:
	j	$31
	.end	DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
	.text
	.ent	DrawW_DoObjectAnimations__Fv
DrawW_DoObjectAnimations__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$3,%lo(GameSetup_gData+60)($2)
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L729
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(trk0) # high
	.set	noreorder
	.set	nomacro
	j	$L730
	addiu	$18,$2,%lo(trk0) # low
	.set	macro
	.set	reorder

$L729:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L728
	lui	$2,%hi(trk4) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(trk4) # low
$L730:
	lui	$2,%hi(simGlobal+4) # high
	lw	$19,%lo(simGlobal+4)($2)
	move	$17,$0
	lui	$2,%hi(Anim_gInstanceFromIndex) # high
	addiu	$16,$2,%lo(Anim_gInstanceFromIndex) # low
$L732:
	lw	$4,0($16)
	#nop
	lbu	$2,3($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L735
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
	move	$6,$19
	.set	macro
	.set	reorder

$L735:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L732
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L728:
	lw	$31,32($sp)
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

	.end	DrawW_DoObjectAnimations__Fv
	.text
	.ent	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo:
	.frame	$sp,168,$31		# vars= 96, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	sw	$23,156($sp)
	move	$23,$4
	sw	$31,164($sp)
	sw	$fp,160($sp)
	sw	$22,152($sp)
	sw	$21,148($sp)
	sw	$20,144($sp)
	sw	$19,140($sp)
	sw	$18,136($sp)
	sw	$17,132($sp)
	sw	$16,128($sp)
	lw	$2,4($5)
	move	$21,$0
	addu	$16,$2,4
 #APP
 #NO_APP
	lw	$2,0($2)
	li	$fp,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	sw	$2,104($sp)
	.set	macro
	.set	reorder

	lw	$8,16($5)
	li	$2,528482304			# 0x1f800000
	sw	$8,108($sp)
	lw	$8,8($5)
	ori	$2,$2,0x0014
	sw	$8,112($sp)
	lw	$22,12($5)
	lw	$5,20($5)
	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x0014
	sw	$5,116($sp)
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($fp)
 #APP
	lw   $12, 20($8)
	lw   $13, 24($8)
	ctc2 $12, $5
	lw   $14, 28($8)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	move	$20,$0
	addu	$19,$sp,72
	addu	$8,$sp,32
	sw	$8,120($sp)
$L741:
	lw	$8,104($sp)
	#nop
	slt	$2,$20,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L762
	move	$2,$21
	.set	macro
	.set	reorder

	lw	$8,116($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L744
	sll	$2,$20,1
	.set	macro
	.set	reorder

	addu	$2,$2,$8
	lhu	$2,0($2)
	#nop
	srl	$2,$2,12
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	bne	$2,$0,$L743
$L744:
	lw	$18,108($sp)
	#nop
	bne	$18,$0,$L745
	lui	$8,%hi(goffsets) # high
	lbu	$2,4($16)
	addiu	$8,$8,%lo(goffsets) # low
	addu	$2,$2,$8
	lb	$18,0($2)
$L745:
	lbu	$3,2($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L747
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L752
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	beq	$3,$2,$L752
	j	$L743
$L747:
	lh	$5,6($16)
	lw	$3,Track_gObjDefs
	lw	$8,112($sp)
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$17,0($2)
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L753
	move	$4,$23
	.set	macro
	.set	reorder

	addu	$6,$16,8
	.set	noreorder
	.set	nomacro
	jal	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
	move	$7,$fp
	.set	macro
	.set	reorder

	bne	$2,$0,$L743
$L753:
	li	$8,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$22,$8,$L755
	addu	$4,$16,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	xzsquaredist32__FP8coorddefT0
	addu	$5,$23,8
	.set	macro
	.set	reorder

	slt	$2,$2,$22
	beq	$2,$0,$L743
$L755:
	sw	$18,16($sp)
	move	$4,$23
	move	$5,$fp
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
	addu	$7,$16,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L743
	addu	$21,$21,$2
	.set	macro
	.set	reorder

$L752:
	.set	noreorder
	.set	nomacro
	jal	DrawW_GetAnimationTime__FP15Trk_AnimateInst
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1			# 0x00000001
	move	$6,$2
	lw	$8,120($sp)
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
	sw	$8,16($sp)
	.set	macro
	.set	reorder

	li	$8,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$22,$8,$L758
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	xzsquaredist32__FP8coorddefT0
	addu	$5,$23,8
	.set	macro
	.set	reorder

	slt	$2,$2,$22
	beq	$2,$0,$L743
$L758:
	move	$4,$23
	move	$5,$fp
	lh	$2,6($16)
	lw	$3,Track_gObjDefs
	lw	$6,120($sp)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$17,0($2)
	li	$8,-1			# 0xffffffff
	sw	$19,16($sp)
	sw	$18,20($sp)
	sw	$8,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	move	$7,$17
	.set	macro
	.set	reorder

	lbu	$3,5($16)
	#nop
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L743
	addu	$21,$21,$2
	.set	macro
	.set	reorder

	move	$4,$23
	li	$5,-1			# 0xffffffff
	lw	$2,56($sp)
	lw	$3,72($sp)
	sll	$2,$2,4
	subu	$3,$3,$2
	lw	$2,60($sp)
	li	$6,30			# 0x0000001e
	sw	$3,88($sp)
	lw	$3,76($sp)
	sll	$2,$2,4
	subu	$3,$3,$2
	lw	$2,64($sp)
	move	$7,$19
	sw	$3,92($sp)
	lw	$3,80($sp)
	sll	$2,$2,4
	subu	$3,$3,$2
	addu	$2,$sp,88
	sw	$3,96($sp)
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
	sw	$fp,20($sp)
	.set	macro
	.set	reorder

$L743:
	lh	$2,0($16)
	#nop
	addu	$16,$16,$2
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L741
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L740:
	move	$2,$21
$L762:
	lw	$31,164($sp)
	lw	$fp,160($sp)
	lw	$23,156($sp)
	lw	$22,152($sp)
	lw	$21,148($sp)
	lw	$20,144($sp)
	lw	$19,140($sp)
	lw	$18,136($sp)
	lw	$17,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,168
	.set	macro
	.set	reorder

	.end	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	.text
	.ent	DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi:
	.frame	$sp,128,$31		# vars= 56, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$20,104($sp)
	addu	$20,$7,4
	sw	$31,124($sp)
	sw	$fp,120($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$21,108($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	sw	$4,128($sp)
	sw	$6,136($sp)
	sw	$0,80($sp)
	lw	$7,0($7)
	move	$21,$5
	sw	$7,84($sp)
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L777
	move	$2,$0
	.set	macro
	.set	reorder

	addu	$2,$21,20
	sw	$0,48($21)
	sw	$0,44($21)
	sw	$0,40($21)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	move	$23,$0
$L765:
	lw	$8,84($sp)
	#nop
	slt	$2,$23,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L766
	lui	$9,%hi(offsets) # high
	.set	macro
	.set	reorder

	addiu	$9,$9,%lo(offsets) # low
	li	$3,5			# 0x00000005
	lbu	$2,4($20)
	lbu	$4,2($20)
	addu	$2,$2,$9
	lb	$22,0($2)
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L770
	li	$10,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$4,$10,$L769
$L770:
	li	$11,2			# 0x00000002
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$fp,0($2)
	.set	noreorder
	.set	nomacro
	beq	$4,$11,$L778
	addu	$16,$20,8
	.set	macro
	.set	reorder

	lbu	$2,34($20)
	lw	$8,136($sp)
	sll	$4,$2,$11
	addu	$4,$4,$2
	sll	$4,$4,$11
	.set	noreorder
	.set	nomacro
	jal	Object_GetAnim__FP13Trk_SimObject
	addu	$4,$8,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L771
	addu	$16,$20,8
	.set	macro
	.set	reorder

$L778:
	lw	$9,128($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	xzsquaredist32__FP8coorddefT0
	addu	$5,$9,8
	.set	macro
	.set	reorder

	lw	$10,144($sp)
	#nop
	slt	$2,$2,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L774
	move	$17,$0
	.set	macro
	.set	reorder

	lbu	$2,2($20)
	li	$11,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$11,$L773
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$4,128($sp)
	lh	$5,6($20)
	.set	noreorder
	.set	nomacro
	jal	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
	move	$7,$21
	.set	macro
	.set	reorder

	beq	$2,$0,$L773
$L774:
	li	$17,1			# 0x00000001
$L773:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L769
	addu	$4,$sp,72
	.set	macro
	.set	reorder

	lwl	$8,23($20)
	lwr	$8,20($20)
	lwl	$9,27($20)
	lwr	$9,24($20)
	swl	$8,75($sp)
	swr	$8,72($sp)
	swl	$9,79($sp)
	swr	$9,76($sp)
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lh	$16,28($20)
	lw	$4,32($sp)
	lh	$17,30($20)
	lh	$18,32($20)
	sll	$16,$16,8
	move	$5,$16
	sll	$17,$17,8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$18,$18,8
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,56($sp)
	move	$5,$16
	sw	$19,32($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,60($sp)
	move	$5,$17
	sw	$19,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,48($sp)
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,64($sp)
	move	$5,$18
	sw	$19,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	move	$5,$21
	addu	$6,$sp,32
	lw	$4,128($sp)
	move	$7,$fp
	sw	$2,64($sp)
	addu	$2,$20,8
	sw	$2,16($sp)
	li	$2,-1			# 0xffffffff
	sw	$22,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	addu	$8,$8,$2
	.set	noreorder
	.set	nomacro
	j	$L769
	sw	$8,80($sp)
	.set	macro
	.set	reorder

$L771:
	lbu	$2,34($20)
	lw	$9,136($sp)
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	.set	noreorder
	.set	nomacro
	jal	Object_GetAnim__FP13Trk_SimObject
	addu	$4,$9,$4
	.set	macro
	.set	reorder

	move	$6,$21
	move	$7,$22
	lw	$3,0($2)
	lw	$5,128($sp)
	lh	$4,16($3)
	lw	$3,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L769:
	lh	$2,0($20)
	addu	$23,$23,1
	.set	noreorder
	.set	nomacro
	j	$L765
	addu	$20,$20,$2
	.set	macro
	.set	reorder

$L766:
	lw	$2,80($sp)
$L777:
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

	.end	DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
	.text
	.ent	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis:
	.frame	$sp,128,$31		# vars= 72, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$18,96($sp)
	move	$18,$5
	sw	$21,108($sp)
	move	$21,$7
	addu	$2,$21,4
	sw	$31,124($sp)
	sw	$fp,120($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	sw	$2,224($18)
	lbu	$2,3($21)
	lw	$17,144($sp)
	lw	$23,148($sp)
	lhu	$22,152($sp)
	move	$19,$4
	sb	$2,231($18)
	lbu	$2,2($21)
	lw	$4,Track_materials
	sb	$0,262($18)
	lw	$3,gNight_renderNight
	move	$fp,$6
	sw	$23,236($18)
	sll	$2,$2,3
	addu	$2,$2,4
	addu	$2,$21,$2
	sw	$2,232($18)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L780
	sw	$4,240($18)
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	lui	$3,%hi(Cars_gList) # high
	sb	$2,262($18)
	lw	$2,4($19)
	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lbu	$2,1095($2)
	#nop
	andi	$2,$2,0x0006
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	sb	$2,262($18)
$L781:
	lui	$6,%hi(Camera_gInfo) # high
	lw	$3,4($19)
	addiu	$6,$6,%lo(Camera_gInfo) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	#nop
	lw	$3,160($2)
	lw	$2,0($17)
	#nop
	subu	$2,$2,$3
	sw	$2,56($sp)
	lw	$3,4($19)
	addu	$20,$sp,56
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	move	$4,$20
	lw	$3,164($2)
	lw	$2,4($17)
	lui	$5,%hi(gNightMat) # high
	subu	$2,$2,$3
	sw	$2,60($sp)
	lw	$3,4($19)
	addiu	$5,$5,%lo(gNightMat) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	addu	$16,$sp,72
	lw	$3,168($2)
	lw	$2,8($17)
	move	$6,$16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,64($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$18,52
	.set	macro
	.set	reorder

	lw	$2,BW_gCopCarObj
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L782
	move	$4,$20
	.set	macro
	.set	reorder

	lbu	$2,262($18)
	#nop
	ori	$2,$2,0x0002
	sb	$2,262($18)
	lw	$3,BW_gCopCarObj
	lw	$2,0($17)
	lw	$5,160($3)
	#nop
	subu	$2,$2,$5
	lui	$5,%hi(gCopMat) # high
	sw	$2,56($sp)
	lw	$6,164($3)
	lw	$2,4($17)
	addiu	$5,$5,%lo(gCopMat) # low
	subu	$2,$2,$6
	sw	$2,60($sp)
	lw	$3,168($3)
	lw	$2,8($17)
	move	$6,$16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,64($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$18,84
	.set	macro
	.set	reorder

$L782:
	addu	$2,$18,20
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($18)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L780:
	lw	$3,8($19)
	lw	$2,0($17)
	#nop
	subu	$2,$2,$3
	sw	$2,56($sp)
	lw	$3,12($19)
	lw	$2,4($17)
	#nop
	subu	$2,$2,$3
	sw	$2,60($sp)
	lw	$3,16($19)
	lw	$2,8($17)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxTransZero__Fv
	sw	$2,64($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,56
	addu	$19,$sp,72
	.set	noreorder
	.set	nomacro
	jal	TrsProj_TransPt__FP8coorddefT0
	move	$5,$19
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L784
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$2,Draw_gMidGroundOtz
	#nop
	sw	$2,236($18)
	lw	$2,72($sp)
	lw	$3,80($sp)
	sra	$2,$2,2
	sw	$2,72($sp)
	lw	$2,76($sp)
	sra	$3,$3,2
	sw	$3,80($sp)
	sra	$2,$2,2
	sw	$2,76($sp)
$L784:
	lui	$17,%hi(gWorldMat) # high
	addiu	$17,$17,%lo(gWorldMat) # low
	move	$5,$17
	addu	$6,$sp,16
	sw	$0,244($18)
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	sh	$0,248($18)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addu	$16,$18,20
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$18
	sb	$0,263($18)
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sh	$22,216($18)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$0,28($16)
	sw	$0,24($16)
	sw	$0,40($18)
 #APP
	lw   $12, 20($16)
	lw   $13, 24($16)
	ctc2 $12, $5
	lw   $14, 28($16)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lbu	$2,3($21)
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

	.end	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	.text
	.ent	DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi:
	.frame	$sp,80,$31		# vars= 32, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$16,48($sp)
	move	$16,$5
	sw	$20,64($sp)
	move	$20,$6
	sw	$21,68($sp)
	lw	$21,96($sp)
	lw	$3,Track_materials
	addu	$2,$20,4
	sw	$31,72($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$2,224($16)
	sw	$3,240($16)
	lbu	$2,3($20)
	#nop
	sb	$2,231($16)
	lbu	$2,2($20)
	move	$18,$4
	sb	$0,262($16)
	lw	$3,gNight_renderNight
	move	$19,$7
	sw	$21,236($16)
	sll	$2,$2,3
	addu	$2,$2,4
	addu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L786
	sw	$2,232($16)
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	lui	$3,%hi(Cars_gList) # high
	sb	$2,262($16)
	lw	$2,4($18)
	addiu	$3,$3,%lo(Cars_gList) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lbu	$2,1095($2)
	#nop
	andi	$2,$2,0x0006
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L787
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	sb	$2,262($16)
$L787:
	lui	$6,%hi(Camera_gInfo) # high
	lw	$3,4($18)
	addiu	$6,$6,%lo(Camera_gInfo) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	#nop
	lw	$3,160($2)
	lw	$2,8($18)
	#nop
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$3,4($18)
	#nop
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	addu	$4,$sp,16
	lw	$3,164($2)
	lw	$2,12($18)
	lui	$5,%hi(gNightMat) # high
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$3,4($18)
	addiu	$5,$5,%lo(gNightMat) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lw	$2,4($2)
	addu	$17,$sp,32
	lw	$3,168($2)
	lw	$2,16($18)
	move	$6,$17
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$16,52
	.set	macro
	.set	reorder

	lw	$2,BW_gCopCarObj
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L788
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,262($16)
	#nop
	ori	$2,$2,0x0002
	sb	$2,262($16)
	lw	$3,BW_gCopCarObj
	lw	$2,8($18)
	lw	$5,160($3)
	#nop
	subu	$2,$2,$5
	lui	$5,%hi(gCopMat) # high
	sw	$2,16($sp)
	lw	$6,164($3)
	lw	$2,12($18)
	addiu	$5,$5,%lo(gCopMat) # low
	subu	$2,$2,$6
	sw	$2,20($sp)
	lw	$3,168($3)
	lw	$2,16($18)
	move	$6,$17
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$16,84
	.set	macro
	.set	reorder

$L788:
	addu	$2,$16,20
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($16)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L786:
	li	$2,-1			# 0xffffffff
	bne	$21,$2,$L789
	lw	$2,Draw_gMidGroundOtz
	#nop
	sw	$2,236($16)
	lw	$3,8($18)
	lw	$2,0($19)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,12
	sh	$2,244($16)
	lw	$3,12($18)
	lw	$2,4($19)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,12
	sh	$2,246($16)
	lw	$3,16($18)
	lw	$2,8($19)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L791
	sra	$2,$2,12
	.set	macro
	.set	reorder

$L789:
	lw	$3,8($18)
	lw	$2,0($19)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,244($16)
	lw	$3,12($18)
	lw	$2,4($19)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,246($16)
	lw	$3,16($18)
	lw	$2,8($19)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
$L791:
	sh	$2,248($16)
	move	$4,$16
	li	$2,1			# 0x00000001
	sb	$2,263($4)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sh	$2,216($4)
	.set	macro
	.set	reorder

	lbu	$2,3($20)
	lw	$31,72($sp)
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
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
	.text
	.ent	DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo:
	.frame	$sp,128,$31		# vars= 56, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$31,124($sp)
	sw	$fp,120($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$21,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	sw	$4,128($sp)
	lw	$2,4($5)
	lw	$8,0($5)
	addu	$20,$2,4
	sw	$8,72($sp)
	lw	$2,0($2)
	#nop
	sw	$2,80($sp)
	lw	$5,8($5)
	move	$23,$0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L794
	sw	$5,76($sp)
	.set	macro
	.set	reorder

	li	$2,528482304			# 0x1f800000
	ori	$2,$2,0x0014
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0014
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,528482344
 #APP
	lw   $12, 20($9)
	lw   $13, 24($9)
	ctc2 $12, $5
	lw   $14, 28($9)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	sw	$0,84($sp)
$L795:
	lw	$8,84($sp)
	lw	$9,80($sp)
	#nop
	slt	$2,$8,$9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L794
	lui	$2,%hi(goffsets) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(goffsets) # low
	lbu	$3,4($20)
	lbu	$16,2($20)
	addu	$3,$3,$2
	andi	$2,$16,0x0080
	lb	$fp,0($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L819
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L820
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	lw	$8,76($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L820
	addu	$6,$20,8
	.set	macro
	.set	reorder

	lw	$4,128($sp)
	lh	$5,6($20)
	.set	noreorder
	.set	nomacro
	jal	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
	li	$7,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,2($20)
	#nop
	bne	$3,$2,$L800
$L801:
	li	$2,1024			# 0x00000400
$L820:
	sh	$2,528482632
	lbu	$2,5($20)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L804
	li	$17,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,8($20)
	lw	$9,128($sp)
	lw	$2,16($20)
	lw	$4,8($9)
	lw	$5,16($9)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	move	$5,$2
	.set	macro
	.set	reorder

	andi	$3,$16,0x00ff
	li	$2,9			# 0x00000009
	bne	$3,$2,$L805
	lh	$16,24($20)
	lw	$4,32($sp)
	lh	$17,22($20)
	sll	$16,$16,8
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$17,$17,8
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$5,$17
	sw	$19,32($sp)
	sw	$18,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$5,$16
	sw	$19,36($sp)
	sw	$18,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$19,40($sp)
	sw	$18,52($sp)
	sw	$2,64($sp)
	lhu	$17,26($20)
	sh	$0,528482632
$L805:
	li	$5,528482304			# 0x1f800000
	addu	$6,$sp,32
	lw	$4,128($sp)
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$22,0($2)
	addu	$2,$20,8
	sw	$2,16($sp)
	sll	$2,$17,16
	sra	$2,$2,16
	sw	$fp,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L817
	move	$7,$22
	.set	macro
	.set	reorder

$L804:
	andi	$3,$16,0x00ff
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L810
	slt	$2,$3,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$3,$2,$L809
	j	$L800
$L816:
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L812
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	beq	$3,$2,$L811
	j	$L800
$L809:
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$22,0($2)
 #APP
 #NO_APP
	li	$5,528482304			# 0x1f800000
	lw	$4,128($sp)
	addu	$7,$20,8
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
	move	$6,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L800
	addu	$23,$23,$2
	.set	macro
	.set	reorder

$L810:
	addu	$4,$20,20
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lh	$16,28($20)
	lw	$4,32($sp)
	lh	$17,30($20)
	lh	$18,32($20)
	sll	$16,$16,8
	move	$5,$16
	sll	$17,$17,8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$18,$18,8
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$5,$17
	sw	$21,32($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$5,$18
	sw	$21,36($sp)
	sw	$19,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	li	$5,528482304			# 0x1f800000
	lw	$4,128($sp)
	addu	$6,$sp,32
	sw	$21,40($sp)
	sw	$19,52($sp)
	sw	$2,64($sp)
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$22,0($2)
	addu	$2,$20,8
	sw	$2,16($sp)
	sw	$fp,20($sp)
	lh	$2,34($20)
	.set	noreorder
	.set	nomacro
	j	$L818
	move	$7,$22
	.set	macro
	.set	reorder

$L811:
	lh	$5,20($20)
	.set	noreorder
	.set	nomacro
	jal	xformy
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lh	$16,24($20)
	lw	$4,32($sp)
	lh	$17,22($20)
	sll	$16,$16,8
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$17,$17,8
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$5,$17
	sw	$19,32($sp)
	sw	$18,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$5,$16
	sw	$19,36($sp)
	sw	$18,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$18,$2
	lw	$4,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	li	$5,528482304			# 0x1f800000
	lw	$4,128($sp)
	addu	$6,$sp,32
	sw	$19,40($sp)
	sw	$18,52($sp)
	sw	$2,64($sp)
	sh	$0,528482632
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$22,0($2)
	addu	$2,$20,8
	sw	$2,16($sp)
	sw	$fp,20($sp)
	lh	$2,26($20)
	.set	noreorder
	.set	nomacro
	j	$L818
	move	$7,$22
	.set	macro
	.set	reorder

$L812:
	lbu	$2,34($20)
	lw	$8,72($sp)
	lw	$3,Track_gObjDefs
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	lh	$2,6($20)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$22,0($2)
	.set	noreorder
	.set	nomacro
	jal	Object_GetAnim__FP13Trk_SimObject
	addu	$4,$8,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	addu	$4,$20,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lh	$16,28($20)
	lw	$4,32($sp)
	lh	$17,30($20)
	lh	$18,32($20)
	sll	$16,$16,8
	move	$5,$16
	sll	$17,$17,8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$18,$18,8
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$5,$17
	sw	$21,32($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,60($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$5,$18
	sw	$21,36($sp)
	sw	$19,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$4,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,64($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	li	$5,528482304			# 0x1f800000
	addu	$6,$sp,32
	lw	$4,128($sp)
	move	$7,$22
	sw	$2,64($sp)
	addu	$2,$20,8
	sw	$19,52($sp)
	sw	$21,40($sp)
	sw	$2,16($sp)
	li	$2,-1			# 0xffffffff
	sw	$fp,20($sp)
$L818:
	sw	$2,24($sp)
$L817:
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	.set	noreorder
	.set	nomacro
	j	$L800
	addu	$23,$23,$2
	.set	macro
	.set	reorder

$L813:
	lbu	$2,34($20)
	lw	$9,72($sp)
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	.set	noreorder
	.set	nomacro
	jal	Object_GetAnim__FP13Trk_SimObject
	addu	$4,$9,$4
	.set	macro
	.set	reorder

	li	$6,528482304			# 0x1f800000
	move	$7,$fp
	lw	$3,0($2)
	lw	$5,128($sp)
	lh	$4,16($3)
	lw	$3,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L800:
	lw	$8,84($sp)
$L819:
	lh	$2,0($20)
	addu	$8,$8,1
	addu	$20,$20,$2
	.set	noreorder
	.set	nomacro
	j	$L795
	sw	$8,84($sp)
	.set	macro
	.set	reorder

$L794:
	move	$2,$23
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

	.end	DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	.text
	.ent	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,72,$31		# vars= 48, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	move	$7,$4
	sw	$16,64($sp)
	lw	$16,gPersistObjDefBoundingSpheres
	sll	$5,$5,3
	sw	$31,68($sp)
	addu	$16,$16,4
	addu	$16,$16,$5
	lh	$2,0($16)
	lw	$3,0($6)
	sll	$2,$2,10
	addu	$2,$2,$3
	sw	$2,16($sp)
	lh	$2,2($16)
	lw	$3,4($6)
	sll	$2,$2,10
	addu	$2,$2,$3
	sw	$2,20($sp)
	lh	$2,4($16)
	lw	$3,8($6)
	sll	$2,$2,10
	addu	$2,$2,$3
	sw	$2,24($sp)
	lw	$2,56($7)
	addu	$4,$sp,16
	sw	$2,48($sp)
	lw	$2,60($7)
	addu	$5,$7,68
	sw	$2,52($sp)
	lw	$2,64($7)
	addu	$6,$sp,32
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	lw	$3,32($sp)
	lw	$2,48($sp)
	lw	$4,52($sp)
	lw	$5,56($sp)
	addu	$6,$3,$2
	lw	$2,36($sp)
	lw	$3,40($sp)
	sw	$6,32($sp)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sw	$2,36($sp)
	sw	$3,40($sp)
	lh	$2,6($16)
	#nop
	sll	$2,$2,10
	addu	$3,$3,$2
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L822
	sw	$3,40($sp)
	.set	macro
	.set	reorder

	subu	$2,$0,$6
	.set	noreorder
	.set	nomacro
	j	$L823
	slt	$2,$3,$2
	.set	macro
	.set	reorder

$L822:
	li	$2,1			# 0x00000001
$L823:
	lw	$31,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry:
	.frame	$sp,72,$31		# vars= 8, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$20,48($sp)
	move	$20,$0
	sw	$23,60($sp)
	lui	$23,%hi(gChunkObjInfo) # high
	sw	$17,36($sp)
	addiu	$17,$23,%lo(gChunkObjInfo) # low
	lui	$2,%hi(GameSetup_gData) # high
	sw	$fp,64($sp)
	addiu	$fp,$2,%lo(GameSetup_gData) # low
	sw	$18,40($sp)
	move	$18,$5
	sw	$22,56($sp)
	li	$22,528482304			# 0x1f800000
	lui	$2,%hi(gInitialArt) # high
	lw	$8,BWorld_gChunkCount
	lw	$3,gCurrContext
	addiu	$2,$2,%lo(gInitialArt) # low
	sw	$31,68($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$16,32($sp)
	sw	$4,72($sp)
	sw	$4,gVi
	sw	$8,24($sp)
	sw	$2,252($22)
	lw	$21,136($3)
$L825:
	lw	$8,24($sp)
	#nop
	slt	$2,$20,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L826
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	lbu	$2,3($18)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L829
	lh	$3,0($18)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$16,$3,$2
	lw	$2,80($16)
	#nop
	addu	$19,$2,4
	lw	$2,64($16)
	lb	$3,2($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L830
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$4,$4,0x03fc
	li	$2,1			# 0x00000001
	sh	$2,218($22)
	xori	$2,$3,0x0004
	sw	$19,%lo(gChunkObjInfo)($23)
	lw	$3,64($16)
	sltu	$2,$2,1
	sw	$2,8($17)
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$3,4($17)
	.set	macro
	.set	reorder

	lw	$4,gVi
	li	$8,1			# 0x00000001
	sw	$2,gWSavePtr
	sw	$8,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
$L830:
	lw	$2,84($fp)
	#nop
	bne	$2,$0,$L829
	lw	$2,72($fp)
	#nop
	bne	$2,$0,$L829
	lw	$2,68($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L829
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,gVi
	li	$2,1024			# 0x00000400
	sh	$2,328($22)
	sh	$0,218($22)
	sw	$0,20($17)
	sw	$19,%lo(gChunkObjInfo)($23)
	lw	$3,68($16)
	li	$2,-1			# 0xffffffff
	sw	$2,12($17)
	li	$2,50			# 0x00000032
	li	$8,1			# 0x00000001
	sw	$2,16($17)
	sw	$8,8($17)
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	sw	$3,4($17)
	.set	macro
	.set	reorder

$L829:
	addu	$18,$18,4
	.set	noreorder
	.set	nomacro
	j	$L825
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L826:
	sh	$0,218($22)
	lw	$5,gPersistObjInst
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L832
	sh	$2,328($22)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$3,%lo(GameSetup_gData+60)($2)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L834
	addu	$4,$21,-1
	.set	macro
	.set	reorder

	sltu	$2,$4,40
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$2,$21,-61
	.set	macro
	.set	reorder

	sltu	$2,$2,30
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$2,$21,-108
	.set	macro
	.set	reorder

	sltu	$2,$2,9
	bne	$2,$0,$L832
$L834:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L835
	sltu	$2,$4,53
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$2,$21,-68
	.set	macro
	.set	reorder

	sltu	$2,$2,28
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$2,$21,-108
	.set	macro
	.set	reorder

	sltu	$2,$2,20
	bne	$2,$0,$L832
$L835:
	li	$4,528482304			# 0x1f800000
	lui	$2,%hi(gChunkObjInfo) # high
	addiu	$16,$2,%lo(gChunkObjInfo) # low
	sw	$5,4($16)
	sw	$0,%lo(gChunkObjInfo)($2)
	li	$2,125			# 0x0000007d
	sw	$2,16($16)
	lw	$2,gCurrContext
	li	$17,1			# 0x00000001
	sw	$17,8($16)
	lw	$2,144($2)
	ori	$4,$4,0x03fc
	sw	$0,20($16)
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$2,12($16)
	.set	macro
	.set	reorder

	lw	$4,gVi
	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
$L832:
	lw	$2,gPersistMidgroundObjInst
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L836
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$4,$4,0x03fc
	lui	$16,%hi(gChunkObjInfo) # high
	sw	$0,%lo(gChunkObjInfo)($16)
	addiu	$16,$16,%lo(gChunkObjInfo) # low
	sw	$2,4($16)
	li	$2,-1			# 0xffffffff
	li	$17,1			# 0x00000001
	sw	$2,12($16)
	sw	$2,16($16)
	lw	$2,Track_gInViewList
	sll	$3,$21,6
	sw	$17,8($16)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$2,20($16)
	.set	macro
	.set	reorder

	lw	$4,gVi
	sw	$2,gWSavePtr
	sw	$17,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
$L836:
	lw	$7,Object_customObjInst
	#nop
	beq	$7,$0,$L824
	lw	$2,0($7)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L824
	move	$5,$22
	.set	macro
	.set	reorder

	lw	$4,72($sp)
	lw	$2,gCurrContext
	lw	$6,Object_customSimObjs
	lw	$2,144($2)
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L824:
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

	.end	DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
	.text
	.ent	Draw_CircleClip__FP8coorddefT0i
Draw_CircleClip__FP8coorddefT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	lw	$2,0($5)
	#nop
	subu	$7,$3,$2
	bgtz	$7,$L839
	subu	$7,$2,$3
$L839:
	lw	$4,8($4)
	lw	$5,8($5)
	#nop
	subu	$3,$4,$5
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L843
	slt	$2,$3,$7
	.set	macro
	.set	reorder

	subu	$3,$5,$4
	slt	$2,$3,$7
$L843:
	beq	$2,$0,$L841
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L842
	addu	$2,$7,$2
	.set	macro
	.set	reorder

$L841:
	sra	$2,$7,2
	addu	$2,$3,$2
$L842:
	.set	noreorder
	.set	nomacro
	j	$31
	slt	$2,$2,$6
	.set	macro
	.set	reorder

	.end	Draw_CircleClip__FP8coorddefT0i
	.text
	.ent	Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark:
	.frame	$sp,88,$31		# vars= 32, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$fp,80($sp)
	li	$fp,528482304			# 0x1f800000
	ori	$fp,$fp,0x0094
	sw	$20,64($sp)
	sw	$4,88($sp)
	move	$20,$4
	sw	$23,76($sp)
	addu	$23,$20,36
	sw	$21,68($sp)
	li	$21,4194304			# 0x00400000
	ori	$21,$21,0x4040
	sw	$18,56($sp)
	li	$18,528482304			# 0x1f800000
	sw	$31,84($sp)
	sw	$22,72($sp)
	sw	$19,60($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	lw	$19,48($20)
	lw	$3,12($20)
	lw	$4,24($20)
	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,2
	subu	$2,$2,$19
	sll	$2,$2,2
	subu	$2,$2,$19
	sll	$22,$2,4
	sra	$3,$3,4
	lw	$2,0($20)
	sra	$4,$4,4
	sh	$3,22($18)
	sh	$4,24($18)
	sra	$2,$2,4
	sh	$2,20($18)
	lw	$2,4($20)
	lw	$3,16($20)
	lw	$4,28($20)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,26($18)
	sh	$3,28($18)
	sh	$4,30($18)
	lw	$2,8($20)
	lw	$3,20($20)
	lw	$4,32($20)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,32($18)
	sh	$3,34($18)
	sh	$4,36($18)
$L848:
	addu	$19,$19,-1
$L871:
	li	$24,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$19,$24,$L844
	addu	$22,$22,-688
	.set	macro
	.set	reorder

	lw	$24,88($sp)
	#nop
	lw	$2,52($24)
	#nop
	addu	$17,$2,$22
	lh	$4,14($17)
	.set	noreorder
	.set	nomacro
	jal	BWorld_IsSliceInBuildList__Fi
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L850
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	Draw_CircleClip__FP8coorddefT0i
	li	$6,3276800			# 0x00320000
	.set	macro
	.set	reorder

	sltu	$16,$0,$2
$L850:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L871
	addu	$19,$19,-1
	.set	macro
	.set	reorder

	addu	$19,$19,1
	lw	$2,0($17)
	lw	$3,0($23)
	addu	$4,$sp,32
	subu	$2,$2,$3
	sw	$2,32($sp)
	lw	$2,4($17)
	lw	$3,4($23)
	move	$5,$20
	subu	$2,$2,$3
	sw	$2,36($sp)
	lw	$2,8($17)
	lw	$3,8($23)
	addu	$6,$sp,16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,40($sp)
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	sra	$2,$2,6
	sw	$2,40($18)
	lw	$2,20($sp)
	lw	$3,24($sp)
	sra	$2,$2,6
	sra	$3,$3,6
	sw	$2,44($18)
	addu	$2,$18,20
	sw	$3,48($18)
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
	move	$15,$17
	li	$11,16			# 0x00000010
	move	$10,$0
	addu	$8,$15,40
	lh	$16,12($15)
$L854:
	slt	$2,$10,$16
	beq	$2,$0,$L848
	lw	$2,4($18)
	lw	$3,8($18)
	#nop
	sltu	$2,$2,$3
	beq	$2,$0,$L858
	lw	$2,0($8)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	addu	$3,$15,$11
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($3)
	lwc2 $1, 4($3)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$18,152
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$6,4($18)
	#nop
	addu	$2,$6,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$3,$3,8
 #APP
	lwc2 $0, 0($3)
	lwc2 $1, 4($3)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$18,168
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,0($8)
	#nop
	addu	$2,$2,8
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$18,184
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$24,0($8)
 #APP
	lwc2 $0, 0($24)
	lwc2 $1, 4($24)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$18,200
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,152($18)
	lw	$3,160($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L860
	lw	$2,168($18)
	lw	$3,176($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L860
	lw	$2,184($18)
	lw	$3,192($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L860
	lw	$2,200($18)
	lw	$3,208($18)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L858
$L860:
	lw	$2,152($18)
	lw	$3,160($18)
	subu	$2,$0,$2
	slt	$2,$2,$3
	bne	$2,$0,$L861
	lw	$2,168($18)
	lw	$3,176($18)
	subu	$2,$0,$2
	slt	$2,$2,$3
	bne	$2,$0,$L861
	lw	$2,184($18)
	lw	$3,192($18)
	subu	$2,$0,$2
	slt	$2,$2,$3
	bne	$2,$0,$L861
	lw	$2,200($18)
	lw	$3,208($18)
	subu	$2,$0,$2
	slt	$2,$2,$3
	beq	$2,$0,$L858
$L861:
	la	$3,gSkidMarkPixmap
	lw	$5,-4($8)
	addu	$4,$6,20
	andi	$2,$5,0x0001
	sll	$2,$2,2
	addu	$7,$2,$3
	addu	$3,$6,44
	addu	$2,$6,32
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	li	$24,528482304			# 0x1f800000
	ori	$24,$24,0x0094
 #APP
	swc2 $7, 0($24)
 #NO_APP
	lw	$2,0($fp)
	#nop
	sra	$9,$2,5
	addu	$3,$9,50
	.set	noreorder
	.set	nomacro
	blez	$3,$L844
	sw	$3,0($fp)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	bne	$2,$0,$L844
	beq	$5,$0,$L864
	sw	$21,4($6)
	sw	$21,16($6)
	sw	$21,40($6)
	.set	noreorder
	.set	nomacro
	j	$L865
	sw	$21,28($6)
	.set	macro
	.set	reorder

$L864:
	lw	$2,-8($8)
	#nop
	sw	$2,4($6)
	lw	$2,-8($8)
	#nop
	sw	$2,16($6)
	lw	$2,0($8)
	#nop
	lw	$2,16($2)
	#nop
	sw	$2,40($6)
	lw	$2,0($8)
	#nop
	lw	$2,16($2)
	#nop
	sw	$2,28($6)
$L865:
	li	$2,62			# 0x0000003e
	sb	$2,7($6)
	li	$2,12			# 0x0000000c
	sb	$2,3($6)
	lw	$2,0($7)
	lw	$3,4($7)
	lw	$4,8($7)
	lw	$5,12($7)
	sw	$2,12($6)
	sw	$3,24($6)
	lhu	$3,14($6)
	li	$2,65535			# 0x0000ffff
	sw	$4,36($6)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L866
	sw	$5,48($6)
	.set	macro
	.set	reorder

	lhu	$2,220($18)
	lhu	$3,222($18)
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$2,$9,$2
	sll	$2,$2,4
	sra	$3,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$3,$L867
	slt	$2,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L868
	move	$3,$0
	.set	macro
	.set	reorder

$L867:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L872
	sll	$3,$3,1
	.set	macro
	.set	reorder

	li	$3,15			# 0x0000000f
$L868:
	sll	$3,$3,1
$L872:
	lui	$24,%hi(gClutDepth) # high
	lhu	$2,10($7)
	addiu	$24,$24,%lo(gClutDepth) # low
	sll	$2,$2,5
	addu	$2,$2,$3
	addu	$2,$2,$24
	lhu	$2,0($2)
	#nop
	sh	$2,14($6)
$L866:
	lw	$24,0($fp)
 #APP
	lw	$2,4($18)
	sll	$t4,$24,2
	lw	$t5,0($18)
	addiu	$t6,$2,52
	addu	$t5,$t5,$t4
	sw	$t6,4($18)
	lwl	$t6,2($t5)
	lui	$t4,0x0C00
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,$2,8
	sw	$t6,0($2)
	swl	$t4,2($t5)
 #NO_APP
$L858:
	addu	$8,$8,28
	addu	$11,$11,28
	.set	noreorder
	.set	nomacro
	j	$L854
	addu	$10,$10,1
	.set	macro
	.set	reorder

$L844:
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

	.end	Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
	.text
	.ent	DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,56,$31		# vars= 0, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$20,48($sp)
	move	$20,$4
	sw	$19,44($sp)
	addu	$19,$20,332
	move	$4,$19
	addu	$5,$20,152
	sw	$18,40($sp)
	addu	$18,$20,348
	sw	$16,32($sp)
	addu	$16,$20,364
	sw	$17,36($sp)
	sw	$31,52($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$17,$20,380
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$20,168
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$20,184
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR
	addu	$5,$20,200
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($19)
	lwc2 $1, 4($19)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$20,340
 #APP
	swc2 $14, 0($2)
	lwc2 $0, 0($18)
	lwc2 $1, 4($18)
	lwc2 $2, 0($16)
	lwc2 $3, 4($16)
	lwc2 $4, 0($17)
	lwc2 $5, 4($17)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$3,$20,272
	lw	$2,16($3)
	lw	$4,4($3)
	addu	$5,$20,356
	sw	$2,12($16)
	sw	$2,12($18)
	sw	$4,12($17)
	sw	$4,12($19)
	addu	$4,$20,372
	addu	$2,$20,388
 #APP
	swc2 $12, 0($5)
	swc2 $13, 0($4)
	swc2 $14, 0($2)
 #NO_APP
	lhu	$2,12($3)
	lhu	$4,24($3)
	lhu	$5,48($3)
	lhu	$3,36($3)
	sh	$2,6($19)
	sh	$4,6($18)
	sh	$5,6($16)
	sh	$3,6($17)
	lh	$4,8($19)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L877
	sb	$0,15($19)
	.set	macro
	.set	reorder

	lh	$3,10($19)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L877
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L893
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L893
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($19)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L878
$L877:
	li	$2,1			# 0x00000001
$L893:
	sb	$2,15($19)
$L878:
	lh	$4,8($18)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L882
	sb	$0,15($18)
	.set	macro
	.set	reorder

	lh	$3,10($18)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L882
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L894
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L894
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($18)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L883
$L882:
	li	$2,1			# 0x00000001
$L894:
	sb	$2,15($18)
$L883:
	lh	$4,8($16)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L887
	sb	$0,15($16)
	.set	macro
	.set	reorder

	lh	$3,10($16)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L887
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L895
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L895
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($16)
	#nop
	slt	$2,$2,101
	beq	$2,$0,$L888
$L887:
	li	$2,1			# 0x00000001
$L895:
	sb	$2,15($16)
$L888:
	lh	$4,8($17)
	#nop
	slt	$2,$4,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L889
	sb	$0,15($17)
	.set	macro
	.set	reorder

	lh	$3,10($17)
	#nop
	slt	$2,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L889
	slt	$2,$4,-1000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L896
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,-1000
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L896
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,4($17)
	#nop
	slt	$2,$2,101
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L897
	move	$4,$20
	.set	macro
	.set	reorder

$L889:
	li	$2,1			# 0x00000001
$L896:
	sb	$2,15($17)
	move	$4,$20
$L897:
	move	$5,$0
	move	$6,$19
	move	$7,$18
	sw	$16,16($sp)
	sw	$17,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lw	$31,52($sp)
	lw	$20,48($sp)
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

	.end	DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache:
	.frame	$sp,120,$31		# vars= 64, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$fp,112($sp)
	move	$fp,$4
	sw	$21,100($sp)
	move	$21,$5
	sw	$17,84($sp)
	move	$17,$7
	li	$2,512			# 0x00000200
	sw	$23,108($sp)
	move	$23,$0
	addu	$8,$17,148
	sw	$18,88($sp)
	addu	$18,$sp,48
	sw	$31,116($sp)
	sw	$22,104($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$16,80($sp)
	sw	$6,128($sp)
	sh	$2,328($17)
	sw	$8,76($sp)
$L899:
	lw	$9,128($sp)
	#nop
	addu	$2,$9,-1
	slt	$2,$23,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L898
	addu	$19,$fp,20
	.set	macro
	.set	reorder

$L903:
	lw	$10,128($sp)
	#nop
	addu	$2,$10,-1
	slt	$2,$23,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L901
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	lbu	$3,2($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L901
	lui	$3,%hi(gDLPixmap) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(gDLPixmap) # low
	lw	$4,4($19)
	lbu	$2,2($21)
	lw	$5,8($19)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$20,0($2)
	sw	$4,16($sp)
	sw	$5,20($sp)
	lw	$4,-12($19)
	lw	$5,-8($19)
	sw	$4,24($sp)
	sw	$5,28($sp)
	lw	$4,0($fp)
	lw	$5,-16($19)
	sw	$4,32($sp)
	sw	$5,36($sp)
	lw	$4,-4($19)
	lw	$5,0($19)
	addu	$2,$sp,16
	sw	$4,40($sp)
	sw	$5,44($sp)
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$17,152
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$5,528482308
	#nop
	addu	$2,$5,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$2,$sp,24
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$17,168
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	addu	$2,$sp,32
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$17,184
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	addu	$2,$sp,40
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$17,200
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,152($17)
	lw	$3,160($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L907
	lw	$2,168($17)
	lw	$3,176($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L907
	lw	$2,184($17)
	lw	$3,192($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L907
	lw	$2,200($17)
	lw	$3,208($17)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L908
$L907:
	lw	$2,152($17)
	lw	$3,160($17)
	subu	$2,$0,$2
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L930
	addu	$4,$5,20
	.set	macro
	.set	reorder

	lw	$2,168($17)
	lw	$3,176($17)
	subu	$2,$0,$2
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L931
	addu	$3,$5,44
	.set	macro
	.set	reorder

	lw	$2,184($17)
	lw	$3,192($17)
	subu	$2,$0,$2
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L931
	addu	$3,$5,44
	.set	macro
	.set	reorder

	lw	$2,200($17)
	lw	$3,208($17)
	subu	$2,$0,$2
	slt	$2,$2,$3
	beq	$2,$0,$L908
$L930:
	addu	$3,$5,44
$L931:
	addu	$2,$5,32
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	lw	$11,76($sp)
 #APP
	swc2 $7, 0($11)
	nop
	nop
	.word 0x4B400006
 #NO_APP
	addu	$2,$sp,64
 #APP
	swc2 $24, 0($2)
 #NO_APP
	lw	$3,12($17)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L910
	lw	$2,64($sp)
	#nop
	subu	$2,$0,$2
	sw	$2,64($sp)
$L910:
	lw	$2,64($sp)
	#nop
	bltz	$2,$L908
	lw	$2,148($17)
	#nop
	sra	$22,$2,1
	addu	$3,$22,75
	slt	$2,$2,200
	sw	$3,148($17)
	.set	noreorder
	.set	nomacro
	blez	$3,$L908
	sw	$2,72($sp)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	bne	$2,$0,$L908
	lw	$8,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L915
	addu	$16,$17,272
	.set	macro
	.set	reorder

	lw	$16,4($17)
	lw	$9,76($sp)
 #APP
	lw	$t4,0($9)
 lw $t5,0($17)
 addiu $t6,$16,52
 sll $t4,$t4,2
 addu $t5,$t5,$t4
 sw $t6,4($17)
 lwl $t6,2($t5)
 lui $t4,0x0C00
 srl $t6,$t6,8
 or $t6,$t6,$t4
 sll $t4,$16,8
 sw $t6,0($16)
 swl $t4,2($t5)
 #NO_APP
$L915:
	addu	$2,$sp,68
 #APP
	swc2 $8, 0($2)
 #NO_APP
	lbu	$2,262($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L916
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L917
	addu	$2,$17,52
	.set	macro
	.set	reorder

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
	addu	$2,$sp,32
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($18)
	swc2 $26, 4($18)
	swc2 $27, 8($18)
 #NO_APP
	addu	$2,$sp,40
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$18
	addu	$5,$sp,38
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($18)
	swc2 $26, 4($18)
	swc2 $27, 8($18)
 #NO_APP
	move	$4,$18
	addu	$5,$sp,46
	.set	noreorder
	.set	nomacro
	jal	Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
	move	$6,$17
	.set	macro
	.set	reorder

$L917:
	lw	$2,BW_gCopCarObj
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L918
	addu	$2,$17,84
	.set	macro
	.set	reorder

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
	addu	$2,$sp,32
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A480012
	swc2 $25, 0($18)
	swc2 $26, 4($18)
	swc2 $27, 8($18)
 #NO_APP
	addu	$2,$sp,40
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A480012
 #NO_APP
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$sp,38
	.set	macro
	.set	reorder

 #APP
	swc2 $25, 0($18)
	swc2 $26, 4($18)
	swc2 $27, 8($18)
 #NO_APP
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Night_NightCopCalc__FP6VECTORPs
	addu	$5,$sp,46
	.set	macro
	.set	reorder

$L918:
	lh	$3,46($sp)
	lw	$4,Chunk_lightTable
	lh	$2,38($sp)
	sll	$3,$3,2
	addu	$3,$3,$4
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,0($2)
	lw	$3,0($3)
	sw	$2,40($16)
	sw	$2,16($16)
	addu	$2,$17,20
	sw	$3,28($16)
	sw	$3,4($16)
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
	.set	noreorder
	.set	nomacro
	j	$L928
	li	$2,62			# 0x0000003e
	.set	macro
	.set	reorder

$L916:
	lh	$2,46($sp)
	lw	$3,Chunk_lightTable
	sll	$2,$2,2
	addu	$2,$2,$3
	lwl	$10,3($2)
	lwr	$10,0($2)
	swl	$10,51($sp)
	swr	$10,48($sp)
 #APP
	lwc2 $6, 0($18)
 #NO_APP
	lw	$10,68($sp)
 #APP
	mtc2 $10, $8
	nop
	nop
	.word 0x4A780010
 #NO_APP
	addu	$2,$16,28
 #APP
	swc2 $22, 0($2)
 #NO_APP
	lwl	$11,31($16)
	lwr	$11,28($16)
	swl	$11,7($16)
	swr	$11,4($16)
	lh	$2,38($sp)
	lw	$3,Chunk_lightTable
	sll	$2,$2,2
	addu	$2,$2,$3
	lwl	$11,3($2)
	lwr	$11,0($2)
	swl	$11,51($sp)
	swr	$11,48($sp)
 #APP
	lwc2 $6, 0($18)
 #NO_APP
	lw	$11,68($sp)
 #APP
	mtc2 $11, $8
	nop
	nop
	.word 0x4A780010
 #NO_APP
	addu	$2,$16,40
 #APP
	swc2 $22, 0($2)
 #NO_APP
	lwl	$8,43($16)
	lwr	$8,40($16)
	swl	$8,19($16)
	swr	$8,16($16)
	li	$2,62			# 0x0000003e
$L928:
	sb	$2,7($16)
	li	$2,12			# 0x0000000c
	sb	$2,3($16)
	lw	$2,0($20)
	lw	$3,4($20)
	lw	$4,8($20)
	lw	$5,12($20)
	sw	$2,12($16)
	sw	$3,24($16)
	lhu	$3,14($16)
	li	$2,65535			# 0x0000ffff
	sw	$4,36($16)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L920
	sw	$5,48($16)
	.set	macro
	.set	reorder

	lh	$2,220($17)
	lh	$3,222($17)
	subu	$2,$22,$2
	sll	$2,$2,4
	sra	$5,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L921
	slt	$2,$5,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L922
	move	$5,$0
	.set	macro
	.set	reorder

$L921:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	lui	$4,%hi(gClutDepth) # high
	.set	macro
	.set	reorder

	li	$5,15			# 0x0000000f
$L922:
	lui	$4,%hi(gClutDepth) # high
$L932:
	addiu	$4,$4,%lo(gClutDepth) # low
	lhu	$3,10($20)
	sll	$2,$5,1
	sll	$3,$3,5
	addu	$2,$2,$3
	addu	$2,$2,$4
	lhu	$2,0($2)
	#nop
	sh	$2,14($16)
$L920:
	lw	$8,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L908
	addu	$2,$17,116
	.set	macro
	.set	reorder

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
	lw	$2,stackSpeedUpEnbabledFlag
	#nop
	beq	$2,$0,$L925
	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	li	$2,1			# 0x00000001
	sw	$2,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	j	$L929
	addu	$2,$17,20
	.set	macro
	.set	reorder

$L925:
	.set	noreorder
	.set	nomacro
	jal	DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$2,$17,20
$L929:
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
$L908:
	addu	$23,$23,1
	addu	$21,$21,4
	addu	$19,$19,16
	.set	noreorder
	.set	nomacro
	j	$L903
	addu	$fp,$fp,16
	.set	macro
	.set	reorder

$L901:
	addu	$23,$23,1
	addu	$21,$21,4
	.set	noreorder
	.set	nomacro
	j	$L899
	addu	$fp,$fp,16
	.set	macro
	.set	reorder

$L898:
	lw	$31,116($sp)
	lw	$fp,112($sp)
	lw	$23,108($sp)
	lw	$22,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
	.text
	.ent	DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$25,$5
	sw	$19,28($sp)
	move	$19,$6
	lui	$2,%hi(gVertex3d) # high
	addiu	$11,$2,%lo(gVertex3d) # low
	addu	$12,$25,4
	move	$13,$0
	addu	$10,$11,6
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lh	$18,104($4)
	lhu	$24,0($7)
	lhu	$15,2($7)
	lhu	$14,4($7)
	lw	$2,108($4)
	lw	$17,BWorldSm_slices
	addu	$16,$2,4
$L934:
	lw	$2,0($25)
	#nop
	sll	$2,$2,1
	slt	$2,$13,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L935
	addu	$13,$13,2
	.set	macro
	.set	reorder

	lbu	$6,0($12)
	lbu	$2,1($12)
	addu	$12,$12,4
	addu	$2,$18,$2
	sll	$2,$2,5
	addu	$2,$2,$17
	lbu	$8,18($2)
	addu	$2,$2,18
	sll	$6,$6,3
	addu	$6,$16,$6
	lbu	$9,1($2)
	lbu	$7,2($2)
	lhu	$3,0($6)
	lhu	$4,2($6)
	lhu	$5,4($6)
	sll	$8,$8,24
	sra	$8,$8,27
	sll	$9,$9,24
	sra	$9,$9,27
	sll	$7,$7,24
	sra	$7,$7,27
	subu	$2,$3,$8
	addu	$2,$24,$2
	sh	$2,0($11)
	subu	$2,$4,$9
	addu	$2,$15,$2
	sh	$2,-4($10)
	subu	$2,$5,$7
	addu	$2,$14,$2
	addu	$11,$11,8
	addu	$3,$3,$8
	addu	$3,$24,$3
	addu	$4,$4,$9
	addu	$4,$15,$4
	addu	$5,$5,$7
	sh	$2,-2($10)
	lhu	$2,6($6)
	addu	$5,$14,$5
	sh	$2,0($10)
	addu	$10,$10,8
	sh	$3,0($11)
	sh	$4,-4($10)
	sh	$5,-2($10)
	lhu	$2,6($6)
	addu	$11,$11,8
	sh	$2,0($10)
	.set	noreorder
	.set	nomacro
	j	$L934
	addu	$10,$10,8
	.set	macro
	.set	reorder

$L935:
	lui	$4,%hi(gVertex3d) # high
	addiu	$4,$4,%lo(gVertex3d) # low
	addu	$5,$25,4
	lw	$6,0($25)
	.set	noreorder
	.set	nomacro
	jal	DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache
	move	$7,$19
	.set	macro
	.set	reorder

	lw	$31,32($sp)
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

	.end	DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
	.text
	.ent	DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache:
	.frame	$sp,104,$31		# vars= 48, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$16,64($sp)
	move	$16,$4
	sw	$18,72($sp)
	move	$18,$6
	lw	$8,BWorld_gChunkCount
	addu	$2,$18,20
	sw	$31,100($sp)
	sw	$fp,96($sp)
	sw	$23,92($sp)
	sw	$22,88($sp)
	sw	$21,84($sp)
	sw	$20,80($sp)
	sw	$19,76($sp)
	sw	$17,68($sp)
	sh	$0,218($18)
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($18)
	sw	$8,56($sp)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	move	$22,$0
	lui	$2,%hi(Camera_gInfo) # high
	addiu	$fp,$2,%lo(Camera_gInfo) # low
	addu	$23,$sp,24
	addu	$19,$sp,40
	move	$17,$5
$L940:
	lw	$8,56($sp)
	#nop
	slt	$2,$22,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L939
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	lb	$3,2($17)
	#nop
	bne	$3,$2,$L942
	lh	$2,0($17)
	#nop
	sll	$3,$2,3
	subu	$3,$3,$2
	lw	$2,Track_chunkList
	sll	$3,$3,4
	addu	$20,$2,$3
	lw	$21,88($20)
	#nop
	beq	$21,$0,$L942
	lbu	$2,3($17)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L942
	lw	$2,gNight_renderNight
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L946
	lui	$8,%hi(Cars_gList) # high
	.set	macro
	.set	reorder

	lbu	$3,262($18)
	#nop
	ori	$2,$3,0x0004
	sb	$2,262($18)
	lw	$2,4($16)
	addiu	$8,$8,%lo(Cars_gList) # low
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$2,0($2)
	#nop
	lbu	$2,1095($2)
	#nop
	andi	$2,$2,0x0006
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L947
	ori	$2,$3,0x0005
	.set	macro
	.set	reorder

	sb	$2,262($18)
$L947:
	lw	$3,4($16)
	#nop
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$fp
	lw	$2,4($2)
	#nop
	lw	$3,160($2)
	lw	$2,8($16)
	#nop
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$3,4($16)
	#nop
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$fp
	lw	$2,4($2)
	#nop
	lw	$3,164($2)
	lw	$2,12($16)
	move	$4,$23
	subu	$2,$2,$3
	sw	$2,28($sp)
	lw	$3,4($16)
	lui	$5,%hi(gNightMat) # high
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$fp
	lw	$2,4($2)
	addiu	$5,$5,%lo(gNightMat) # low
	lw	$3,168($2)
	lw	$2,16($16)
	move	$6,$19
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$18,52
	.set	macro
	.set	reorder

	lw	$6,BW_gCopCarObj
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L948
	move	$4,$23
	.set	macro
	.set	reorder

	lw	$3,160($6)
	lw	$2,8($16)
	lui	$5,%hi(gCopMat) # high
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$3,164($6)
	lw	$2,12($16)
	addiu	$5,$5,%lo(gCopMat) # low
	subu	$2,$2,$3
	sw	$2,28($sp)
	lw	$3,168($6)
	lw	$2,16($16)
	move	$6,$19
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$18,84
	.set	macro
	.set	reorder

$L948:
	addu	$2,$18,20
	sw	$0,28($2)
	sw	$0,24($2)
	sw	$0,40($18)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L946:
	move	$4,$20
	lh	$3,0($17)
	lw	$6,Chunk_chunkCenters
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$6,$6,$2
	lw	$3,8($16)
	lw	$2,0($6)
	move	$5,$21
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,16($sp)
	lw	$3,12($16)
	lw	$2,4($6)
	addu	$7,$sp,16
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,18($sp)
	lw	$3,16($16)
	lw	$2,8($6)
	move	$6,$18
	subu	$2,$2,$3
	sra	$2,$2,10
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16
	sh	$2,20($sp)
	.set	macro
	.set	reorder

$L942:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L940
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L939:
	lw	$31,100($sp)
	lw	$fp,96($sp)
	lw	$23,92($sp)
	lw	$22,88($sp)
	lw	$21,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
	.text
	.ent	DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache:
	.frame	$sp,456,$31		# vars= 400, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lw	$2,gSpikeBeltSlice
	lw	$3,BWorldSm_slices
	subu	$sp,$sp,456
	sw	$16,416($sp)
	move	$16,$5
	sw	$4,456($sp)
	move	$4,$16
	sw	$31,452($sp)
	sw	$fp,448($sp)
	sw	$23,444($sp)
	sw	$22,440($sp)
	sw	$21,436($sp)
	sw	$20,432($sp)
	sw	$19,428($sp)
	sw	$18,424($sp)
	sw	$17,420($sp)
	sw	$6,464($sp)
	sll	$21,$2,5
	addu	$3,$3,$21
	.set	noreorder
	.set	nomacro
	bgez	$16,$L951
	sw	$3,408($sp)
	.set	macro
	.set	reorder

	addu	$4,$16,7
$L951:
	lw	$11,408($sp)
	sra	$16,$4,3
	lb	$4,18($11)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	srl	$fp,$2,10
	addu	$3,$21,$3
	lb	$4,19($3)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	srl	$23,$2,10
	addu	$3,$21,$3
	lb	$4,20($3)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,9
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	srl	$22,$2,10
	addu	$3,$21,$3
	lb	$18,15($3)
	lw	$4,gSpikeBeltX
	sra	$20,$18,1
	sh	$20,368($sp)
	lb	$18,16($3)
	lb	$5,18($3)
	sra	$19,$18,1
	lb	$18,17($3)
	sll	$5,$5,9
	sh	$19,376($sp)
	sra	$18,$18,1
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$18,384($sp)
	.set	macro
	.set	reorder

	sra	$17,$2,10
	lw	$2,BWorldSm_slices
	sh	$17,392($sp)
	addu	$2,$21,$2
	lb	$5,19($2)
	lw	$4,gSpikeBeltX
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,9
	.set	macro
	.set	reorder

	sra	$16,$2,10
	lw	$2,BWorldSm_slices
	sh	$16,400($sp)
	addu	$2,$21,$2
	lb	$5,20($2)
	lw	$4,gSpikeBeltX
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,9
	.set	macro
	.set	reorder

	sra	$2,$2,10
	move	$9,$2
	move	$6,$0
	li	$5,1			# 0x00000001
	addu	$7,$sp,16
	addu	$4,$sp,24
	subu	$17,$17,$20
	subu	$16,$16,$19
	subu	$2,$2,$18
	sh	$17,16($sp)
	sh	$16,18($sp)
	sh	$2,20($sp)
	sh	$0,22($sp)
$L952:
	addu	$3,$7,$6
	lhu	$2,0($3)
	#nop
	addu	$2,$2,$fp
	sh	$2,0($4)
	lhu	$2,2($3)
	addu	$6,$6,8
	addu	$2,$2,$23
	sh	$2,2($4)
	lhu	$2,4($3)
	addu	$5,$5,1
	sh	$0,6($4)
	addu	$2,$2,$22
	sh	$2,4($4)
	slt	$2,$5,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L952
	addu	$4,$4,8
	.set	macro
	.set	reorder

	li	$6,72			# 0x00000048
	li	$5,1			# 0x00000001
	addu	$8,$sp,16
	lhu	$12,392($sp)
	lhu	$11,400($sp)
	li	$7,80			# 0x00000050
	sh	$9,92($sp)
	sh	$0,94($sp)
	addu	$2,$11,25
	sh	$12,88($sp)
	sh	$2,90($sp)
$L956:
	addu	$4,$8,$6
	addu	$6,$6,8
	lhu	$2,0($4)
	addu	$3,$8,$7
	addu	$2,$2,$fp
	sh	$2,0($3)
	lhu	$2,2($4)
	#nop
	addu	$2,$2,$23
	sh	$2,2($3)
	lhu	$2,4($4)
	addu	$5,$5,1
	sh	$0,6($3)
	addu	$2,$2,$22
	sh	$2,4($3)
	slt	$2,$5,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L956
	addu	$7,$7,8
	.set	macro
	.set	reorder

	li	$6,144			# 0x00000090
	lhu	$12,392($sp)
	lhu	$11,368($sp)
	li	$5,1			# 0x00000001
	addu	$2,$12,$11
	lhu	$12,400($sp)
	lhu	$11,376($sp)
	addu	$8,$sp,16
	sh	$2,160($sp)
	addu	$2,$12,$11
	lhu	$12,384($sp)
	li	$7,152			# 0x00000098
	sh	$0,166($sp)
	sh	$2,162($sp)
	addu	$2,$9,$12
	sh	$2,164($sp)
$L960:
	addu	$4,$8,$6
	addu	$6,$6,8
	lhu	$2,0($4)
	addu	$3,$8,$7
	addu	$2,$2,$fp
	sh	$2,0($3)
	lhu	$2,2($4)
	#nop
	addu	$2,$2,$23
	sh	$2,2($3)
	lhu	$2,4($4)
	addu	$5,$5,1
	sh	$0,6($3)
	addu	$2,$2,$22
	sh	$2,4($3)
	slt	$2,$5,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L960
	addu	$7,$7,8
	.set	macro
	.set	reorder

	move	$9,$0
	addu	$10,$sp,232
	sll	$2,$9,1
$L969:
	addu	$2,$2,$9
	sll	$2,$2,1
	addu	$2,$10,$2
	addu	$3,$9,1
	addu	$6,$9,10
	addu	$5,$9,9
	addu	$4,$9,8
	addu	$7,$9,19
	addu	$8,$9,18
	sb	$9,5($2)
	move	$9,$3
	sh	$0,0($2)
	sb	$9,2($2)
	sb	$6,3($2)
	sb	$5,4($2)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,1
	addu	$2,$10,$2
	sh	$0,0($2)
	sb	$5,3($2)
	sb	$6,4($2)
	sb	$7,5($2)
	sb	$8,2($2)
	slt	$2,$9,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L969
	sll	$2,$9,1
	.set	macro
	.set	reorder

	lui	$2,%hi(gInitialArt+8) # high
	addu	$4,$sp,336
	lhu	$2,%lo(gInitialArt+8)($2)
	lw	$11,464($sp)
	lui	$5,%hi(gWorldMat) # high
	sb	$0,328($sp)
	sb	$0,329($sp)
	addu	$2,$2,-1
	sh	$2,330($sp)
	sb	$0,262($11)
	lw	$12,408($sp)
	lw	$11,456($sp)
	lw	$2,0($12)
	lw	$3,8($11)
	addiu	$5,$5,%lo(gWorldMat) # low
	subu	$2,$2,$3
	sw	$2,336($sp)
	lw	$2,4($12)
	lw	$3,12($11)
	addu	$16,$sp,352
	subu	$2,$2,$3
	sw	$2,340($sp)
	lw	$2,8($12)
	lw	$3,16($11)
	move	$6,$16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,344($sp)
	.set	macro
	.set	reorder

	lw	$12,464($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
	addu	$5,$12,20
	.set	macro
	.set	reorder

	lw	$4,464($sp)
	addu	$2,$sp,16
	sw	$2,224($4)
	li	$2,16			# 0x00000010
	sb	$2,231($4)
	addu	$2,$sp,232
	sw	$2,232($4)
	li	$2,35			# 0x00000023
	sw	$2,236($4)
	addu	$2,$sp,328
	sw	$2,240($4)
	li	$2,-1			# 0xffffffff
	sw	$0,244($4)
	sh	$0,248($4)
	sb	$0,263($4)
	.set	noreorder
	.set	nomacro
	jal	DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
	sh	$2,216($4)
	.set	macro
	.set	reorder

	lw	$31,452($sp)
	lw	$fp,448($sp)
	lw	$23,444($sp)
	lw	$22,440($sp)
	lw	$21,436($sp)
	lw	$20,432($sp)
	lw	$19,428($sp)
	lw	$18,424($sp)
	lw	$17,420($sp)
	lw	$16,416($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,456
	.set	macro
	.set	reorder

	.end	DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
	.text
	.ent	DepthCue_Init__Fv
DepthCue_Init__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(TrackSpec_gSpec) # high
	addiu	$16,$16,%lo(TrackSpec_gSpec) # low
	sw	$31,20($sp)
	lw	$4,244($16)
	li	$5,160			# 0x000000a0
	.set	noreorder
	.set	nomacro
	jal	SetFogNear
	sll	$4,$4,6
	.set	macro
	.set	reorder

	lbu	$4,240($16)
	lbu	$5,241($16)
	lbu	$6,242($16)
	jal	SetFarColor
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DepthCue_Init__Fv
