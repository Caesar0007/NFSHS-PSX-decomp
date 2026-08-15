	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\bworld.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	xzsquaredist32__FP8coorddefT0
	.align	2
	.globl	UpdateContext__FP13DRender_tViewi
	.rdata
	.align	2
$LC0:
	.word	0
	.word	655360
	.word	0
	.text
	.align	2
	.globl	BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
	.align	2
	.globl	BWorld_InitSpikeBelt__Fv
	.align	2
	.globl	BWorld_SetSpikeBelt__Fiii
	.align	2
	.globl	BWorld_GetSpikeBelt__FPiN20

	.lcomm	cop_angle.238,4
	.align	2
	.globl	SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
	.align	2
	.globl	BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
	.align	2
	.globl	GetRezIndex__Fi
	.align	2
	.globl	SetupChunkBuildList__FP13DRender_tView
	.align	2
	.globl	BWorld_IsSliceInBuildList__Fi
	.align	2
	.globl	BWorld_OnyxBuildFacets__FP13DRender_tView

	.lcomm	totalMem.251,4
	.rdata
	.align	2
$LC1:
	.ascii	"bworld\000"
	.text
	.align	2
	.globl	BWAllocMem__Fl
	.align	2
	.globl	BWorld_InitContexts__Fv
	.align	2
	.globl	BWorld_DeInitContexts__Fv
	.align	2
	.globl	SetContext__Fi
	.align	2
	.globl	BWorld_OpenContext__Fii
	.align	2
	.globl	BWorld_Restart__Fv
	.align	2
	.globl	BWorld_StartLoop__Fv
	.rdata
	.align	2
$LC2:
	.ascii	"S.grp\000"
	.align	2
$LC3:
	.ascii	"N.grp\000"
	.align	2
$LC4:
	.ascii	"W.grp\000"
	.align	2
$LC5:
	.ascii	".grp\000"
	.sdata
	.align	2
$LC6:
	.ascii	"\000"
	.text
	.align	2
	.globl	BWorld_Init__Fv
	.align	2
	.globl	BWorld_DeInit__Fv

	.lcomm	gBWPrimPtr,4
	.globl	gBWMemTotal
	.sdata
	.align	2
gBWMemTotal:
	.space	4
	.globl	gWorldMat
	.data
	.align	2
gWorldMat:
	.space	36
	.globl	gNightMat
	.align	2
gNightMat:
	.space	36
	.globl	gCopMat
	.align	2
gCopMat:
	.space	36
	.globl	gContextMan
	.align	2
gContextMan:
	.space	320
	.globl	BWorld_gChunkBuildList
	.align	2
BWorld_gChunkBuildList:
	.space	144
	.globl	SceneLoaded
	.sdata
	.align	2
SceneLoaded:
	.space	4
	.globl	gCurrContext
	.align	2
gCurrContext:
	.space	4
	.globl	gSpikeBelt
	.align	2
gSpikeBelt:
	.space	4
	.globl	gSpikeBeltSlice
	.align	2
gSpikeBeltSlice:
	.space	4
	.globl	gSpikeBeltChunk
	.align	2
gSpikeBeltChunk:
	.space	4
	.globl	gSpikeBeltX
	.align	2
gSpikeBeltX:
	.space	4
	.globl	gBWSlice
	.align	2
gBWSlice:
	.space	4
	.globl	BWorld_gChunkCount
	.align	2
BWorld_gChunkCount:
	.space	4
	.globl	gSpikeBeltWidth
	.align	2
gSpikeBeltWidth:
	.space	4
	.globl	gSpikeBeltColourTableIndex
	.align	2
gSpikeBeltColourTableIndex:
	.space	4
	.globl	BW_gCopCarObj
	.align	2
BW_gCopCarObj:
	.space	4
	.globl	gVi2
	.align	2
gVi2:
	.space	4

	.extern	gPersistObjDef, 4
	.extern	Replay_ReplayMode, 4
	.extern	Draw_gDoVSync, 4
	.extern	Object_customSliceNum, 4
	.extern	Object_customSFXInst, 4
	.extern	Night_gLightningType, 4
	.extern	Night_gDrawLightning, 1
	.extern	Night_gZDistShift, 4
	.extern	Night_gXDistShift, 4
	.extern	Night_gZNear, 4
	.extern	TrackSpec_gSpec, 264
	.extern	stackSpeedUpEnbabledFlag, 4
	.extern	gWSavePtr, 4
	.extern	Track_chunkList, 4
	.extern	Chunk_chunkCenters, 4
	.extern	Track_gInViewList, 4
	.extern	Track_gInViewCount, 4
	.extern	gNumSlices, 4
	.extern	Cars_gNumCopCars, 4
	.extern	GameSetup_gData, 2600
	.extern	Camera_gInfo, 544
	.extern	gNight_renderNight, 4
	.extern	Draw_gPlayer2View, 4
	.extern	Draw_gPlayer1View, 4
	.extern	BWorldSm_slices, 4
	.extern	Chunk_lightTable, 4
	.extern	Chunk_numLight, 4

	.text
	.text
	.ent	xzsquaredist32__FP8coorddefT0
xzsquaredist32__FP8coorddefT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($5)
	lw	$3,0($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,12
	mult	$2,$2
	lw	$2,8($5)
	lw	$3,8($4)
	mflo	$6
	#nop
	subu	$2,$2,$3
	sra	$2,$2,12
	mult	$2,$2
	sra	$3,$6,6
	mflo	$8
	#nop
	#nop
	sra	$2,$8,6
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	xzsquaredist32__FP8coorddefT0
	.text
	.ent	UpdateContext__FP13DRender_tViewi
UpdateContext__FP13DRender_tViewi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SetContext__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L602
	addu	$16,$17,8
	.set	macro
	.set	reorder

	lw	$2,gCurrContext
	#nop
	lh	$2,4($2)
	#nop
	sw	$2,gBWSlice
$L602:
	move	$4,$16
	lw	$5,gCurrContext
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	addu	$5,$5,4
	.set	macro
	.set	reorder

	lw	$5,gCurrContext
	#nop
	lb	$2,94($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,gCurrContext
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L604:
	lw	$3,gCurrContext
	#nop
	lbu	$4,121($3)
	lw	$2,136($3)
	#nop
	beq	$2,$4,$L601
	sw	$4,136($3)
$L601:
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

	.end	UpdateContext__FP13DRender_tViewi
	.text
	.ent	BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group:
	.frame	$sp,72,$31		# vars= 16, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$20,56($sp)
	move	$20,$4
	sw	$21,60($sp)
	move	$21,$5
	sw	$17,44($sp)
	move	$17,$0
	sw	$18,48($sp)
	addu	$18,$6,4
	sw	$16,40($sp)
	move	$16,$18
	sw	$31,64($sp)
	sw	$19,52($sp)
	lw	$19,0($6)
$L607:
	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	li	$2,100			# 0x00000064
	.set	macro
	.set	reorder

	lhu	$4,14($16)
	lh	$6,12($16)
	lhu	$9,12($16)
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L610
	sll	$2,$4,16
	.set	macro
	.set	reorder

	lui	$2,%hi($LC0) # high
	addiu	$13,$2,%lo($LC0)
	lw	$10,0($13)
	lw	$11,4($13)
	lw	$12,8($13)
	sw	$10,24($sp)
	sw	$11,28($sp)
	sw	$12,32($sp)
	move	$4,$17
	li	$5,257			# 0x00000101
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddEnviroEffect__FiiP8coorddefT2
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	j	$L606
$L610:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	move	$7,$0
	.set	macro
	.set	reorder

	andi	$5,$4,0x7fff
	move	$8,$7
	move	$3,$18
$L612:
	slt	$2,$8,$19
	beq	$2,$0,$L613
	lhu	$2,14($3)
	#nop
	andi	$2,$2,0x7fff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L614
	addu	$3,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	addu	$8,$8,1
	.set	macro
	.set	reorder

$L614:
	li	$7,1			# 0x00000001
$L613:
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L618
	sll	$2,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L618
	move	$4,$20
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	sll	$6,$9,16
	sra	$6,$6,16
	move	$7,$16
	sll	$2,$8,4
	addu	$2,$18,$2
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
	sw	$21,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L619
	addu	$16,$16,16
	.set	macro
	.set	reorder

$L611:
	sw	$21,16($sp)
	move	$4,$20
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache
	move	$7,$16
	.set	macro
	.set	reorder

$L618:
	addu	$16,$16,16
$L619:
	.set	noreorder
	.set	nomacro
	j	$L607
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L606:
	lw	$31,64($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
	.text
	.ent	BWorld_InitSpikeBelt__Fv
BWorld_InitSpikeBelt__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$7,2147418112			# 0x7fff0000
	ori	$7,$7,0xffff
	li	$9,-1			# 0xffffffff
	move	$5,$0
	lw	$10,Chunk_numLight
	lw	$4,Chunk_lightTable
	li	$8,128			# 0x00000080
	sw	$0,gSpikeBelt
	sw	$0,gSpikeBeltSlice
	sw	$0,gSpikeBeltChunk
$L621:
	slt	$2,$5,$10
	beq	$2,$0,$L622
	lbu	$2,0($4)
	#nop
	subu	$2,$8,$2
	mult	$2,$2
	lbu	$2,1($4)
	mflo	$6
	#nop
	subu	$2,$8,$2
	mult	$2,$2
	lbu	$2,2($4)
	mflo	$3
	#nop
	subu	$2,$8,$2
	mult	$2,$2
	addu	$2,$6,$3
	mflo	$12
	#nop
	#nop
	addu	$3,$2,$12
	slt	$2,$3,$7
	beq	$2,$0,$L623
	move	$7,$3
	move	$9,$5
$L623:
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L621
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L622:
	sw	$9,gSpikeBeltColourTableIndex
	j	$31
	.end	BWorld_InitSpikeBelt__Fv
	.text
	.ent	BWorld_SetSpikeBelt__Fiii
BWorld_SetSpikeBelt__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	sw	$2,gSpikeBelt
	lw	$2,BWorldSm_slices
	sw	$4,gSpikeBeltSlice
	sll	$4,$4,5
	addu	$4,$4,$2
	lbu	$2,28($4)
	sw	$6,gSpikeBeltWidth
	sw	$5,gSpikeBeltX
	sw	$2,gSpikeBeltChunk
	j	$31
	.end	BWorld_SetSpikeBelt__Fiii
	.text
	.ent	BWorld_GetSpikeBelt__FPiN20
BWorld_GetSpikeBelt__FPiN20:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,gSpikeBelt
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L628
	move	$2,$0
	.set	macro
	.set	reorder

	sw	$0,0($6)
	sw	$0,0($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($4)
	.set	macro
	.set	reorder

$L628:
	lw	$2,gSpikeBeltSlice
	#nop
	sw	$2,0($4)
	lw	$2,gSpikeBeltX
	#nop
	sw	$2,0($5)
	lw	$3,gSpikeBeltWidth
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,0($6)
	.set	macro
	.set	reorder

	.end	BWorld_GetSpikeBelt__FPiN20
	.text
	.ent	SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache:
	.frame	$sp,112,$31		# vars= 80, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	sw	$31,108($sp)
	sw	$18,104($sp)
	sw	$16,96($sp)
	lw	$3,0($17)
	lw	$2,Draw_gPlayer1View
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L632
	move	$18,$5
	.set	macro
	.set	reorder

	lw	$2,Draw_gPlayer2View
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L631
	move	$4,$17
	.set	macro
	.set	reorder

$L632:
	lw	$5,4($17)
	.set	noreorder
	.set	nomacro
	j	$L647
	move	$4,$17
	.set	macro
	.set	reorder

$L631:
	li	$5,1			# 0x00000001
$L647:
	jal	UpdateContext__FP13DRender_tViewi
	lw	$4,68($17)
	lw	$2,72($17)
	lw	$5,76($17)
	lui	$3,%hi(gWorldMat) # high
	sw	$4,%lo(gWorldMat)($3)
	addiu	$3,$3,%lo(gWorldMat) # low
	subu	$2,$0,$2
	sw	$2,4($3)
	sw	$5,8($3)
	lw	$4,80($17)
	lw	$2,84($17)
	lw	$5,88($17)
	subu	$2,$0,$2
	sw	$4,12($3)
	sw	$2,16($3)
	sw	$5,20($3)
	lw	$4,92($17)
	lw	$2,96($17)
	lw	$5,100($17)
	sw	$4,24($3)
	lw	$4,gNight_renderNight
	subu	$2,$0,$2
	sw	$2,28($3)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L630
	sw	$5,32($3)
	.set	macro
	.set	reorder

	lui	$3,%hi(Camera_gInfo) # high
	addiu	$3,$3,%lo(Camera_gInfo) # low
	lui	$16,%hi(gNightMat) # high
	lw	$4,4($17)
	addiu	$16,$16,%lo(gNightMat) # low
	sll	$2,$4,4
	addu	$2,$2,$4
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$4,4($2)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$4,$4,240
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$18,52
	lw	$2,4($4)
	lw	$3,28($4)
	subu	$2,$0,$2
	sw	$2,4($4)
	lw	$2,16($4)
	subu	$3,$0,$3
	sw	$3,28($4)
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	sw	$2,16($4)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$0,BW_gCopCarObj
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L630
	li	$9,11796480			# 0x00b40000
	.set	macro
	.set	reorder

	li	$7,-1			# 0xffffffff
	lw	$11,Cars_gNumCopCars
	lui	$12,%hi(Cars_gList) # high
	addu	$10,$17,8
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$2,$2,%lo(Cars_gCopCarList) # low
	addu	$8,$2,-4
$L636:
	slt	$2,$7,$11
	beq	$2,$0,$L637
	bgez	$7,$L640
	lw	$6,%lo(Cars_gList)($12)
	j	$L641
$L640:
	lw	$6,0($8)
$L641:
	lbu	$2,145($6)
	#nop
	beq	$2,$0,$L638
	lw	$2,1392($6)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L638
	lhu	$2,2174($6)
	#nop
	andi	$2,$2,0x0004
	bne	$2,$0,$L638
	lw	$5,160($6)
	lw	$3,8($17)
	lw	$4,168($6)
	lw	$2,8($10)
	subu	$5,$5,$3
	subu	$4,$4,$2
	bgez	$5,1f
	subu	$5,$0,$5
1:
	bgez	$4,1f
	subu	$4,$0,$4
1:
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	sra	$2,$4,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L644
	addu	$4,$5,$2
	.set	macro
	.set	reorder

$L643:
	sra	$2,$5,2
	addu	$4,$4,$2
$L644:
	slt	$2,$4,$9
	beq	$2,$0,$L638
	move	$9,$4
	sw	$6,BW_gCopCarObj
$L638:
	addu	$8,$8,4
	.set	noreorder
	.set	nomacro
	j	$L636
	addu	$7,$7,1
	.set	macro
	.set	reorder

$L637:
	lw	$2,BW_gCopCarObj
	#nop
	beq	$2,$0,$L630
	lw	$4,648($2)
	jal	Night_SetCopColor__FP18GameSetup_tCarData
	addu	$16,$sp,56
	lw	$5,gBWPrimPtr
	#nop
	addu	$5,$5,64
	sw	$5,gBWPrimPtr
	.set	noreorder
	.set	nomacro
	jal	xformy
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,BW_gCopCarObj
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	transpose
	addu	$4,$4,240
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$16
	lui	$16,%hi(gCopMat) # high
	addiu	$16,$16,%lo(gCopMat) # low
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$18,84
	lw	$2,4($4)
	lw	$3,28($4)
	subu	$2,$0,$2
	sw	$2,4($4)
	lw	$2,16($4)
	subu	$3,$0,$3
	sw	$3,28($4)
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	sw	$2,16($4)
	.set	macro
	.set	reorder

$L630:
	lw	$31,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
	.text
	.ent	BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
BWorld_CheckChunkVisible__FP12BWorldSm_PosT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$5,$L672
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$7,0($5)
	lw	$3,gNumSlices
	addu	$6,$7,2
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	sll	$2,$6,5
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	.set	noreorder
	.set	nomacro
	j	$L673
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L650:
	addu	$2,$3,-2
	subu	$2,$7,$2
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$3,$3,$2
$L673:
	lh	$5,0($5)
	lbu	$11,28($3)
	addu	$2,$5,-2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L652
	sll	$2,$2,5
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	.set	noreorder
	.set	nomacro
	j	$L674
	addu	$5,$3,$2
	.set	macro
	.set	reorder

$L652:
	lw	$2,gNumSlices
	lw	$3,BWorldSm_slices
	addu	$2,$2,-2
	addu	$2,$5,$2
	sll	$2,$2,5
	addu	$5,$3,$2
$L674:
	lbu	$3,117($4)
	lw	$2,Track_gInViewCount
	#nop
	addu	$2,$2,$3
	sll	$3,$3,6
	lbu	$7,0($2)
	lw	$2,Track_gInViewList
	addu	$7,$7,-1
	addu	$4,$2,$3
	li	$2,-1			# 0xffffffff
	lbu	$3,28($5)
	.set	noreorder
	.set	nomacro
	beq	$7,$2,$L660
	move	$6,$0
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
	move	$10,$2
	sll	$2,$7,$9
	addu	$8,$2,$4
$L655:
	lh	$4,0($8)
	#nop
	andi	$5,$4,0x03ff
	.set	noreorder
	.set	nomacro
	bne	$5,$11,$L658
	andi	$2,$4,0x0800
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	xori	$2,$6,0x0002
	.set	macro
	.set	reorder

	addu	$6,$6,1
	.set	noreorder
	.set	nomacro
	bne	$6,$9,$L671
	xori	$2,$6,0x0002
	.set	macro
	.set	reorder

$L658:
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L662
	andi	$2,$4,0x0800
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	xori	$2,$6,0x0002
	.set	macro
	.set	reorder

	addu	$6,$6,1
	.set	noreorder
	.set	nomacro
	bne	$6,$9,$L671
	xori	$2,$6,0x0002
	.set	macro
	.set	reorder

$L662:
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bne	$7,$10,$L655
	addu	$8,$8,-2
	.set	macro
	.set	reorder

$L660:
	xori	$2,$6,0x0002
$L671:
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L672:
	j	$31
	.end	BWorld_CheckChunkVisible__FP12BWorldSm_PosT0
	.text
	.ent	GetRezIndex__Fi
GetRezIndex__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,gCurrContext
	#nop
	lw	$2,148($2)
	#nop
	slt	$2,$2,$4
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,2
	.set	macro
	.set	reorder

	.end	GetRezIndex__Fi
	.text
	.ent	SetupChunkBuildList__FP13DRender_tView
SetupChunkBuildList__FP13DRender_tView:
	.frame	$sp,144,$31		# vars= 88, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	lui	$2,%hi(BWorld_gChunkBuildList) # high
	sw	$17,108($sp)
	addiu	$17,$2,%lo(BWorld_gChunkBuildList) # low
	lw	$2,gCurrContext
	lw	$3,Track_gInViewList
	sw	$22,128($sp)
	move	$22,$4
	sw	$23,132($sp)
	move	$23,$0
	sw	$21,124($sp)
	move	$21,$23
	sw	$fp,136($sp)
	addu	$fp,$sp,80
	sw	$31,140($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$18,112($sp)
	sw	$16,104($sp)
	lw	$5,136($2)
	lw	$2,Track_gInViewCount
	sll	$4,$5,6
	addu	$2,$2,$5
	lbu	$2,0($2)
	addu	$19,$3,$4
	sw	$2,96($sp)
$L680:
	lw	$7,96($sp)
	#nop
	slt	$2,$21,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L681
	addu	$5,$22,8
	.set	macro
	.set	reorder

	lhu	$2,0($19)
	lw	$3,Chunk_chunkCenters
	andi	$18,$2,0x03ff
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,2
	addu	$16,$3,$2
	.set	noreorder
	.set	nomacro
	jal	xzsquaredist32__FP8coorddefT0
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,gCurrContext
	#nop
	lw	$3,140($3)
	move	$20,$2
	slt	$3,$3,$20
	bne	$3,$0,$L684
	lhu	$2,0($19)
	#nop
	andi	$2,$2,0x0800
	bne	$2,$0,$L684
	lw	$3,8($22)
	lw	$2,0($16)
	#nop
	subu	$2,$2,$3
	lw	$3,BWorldSm_slices
	sw	$2,64($sp)
	sll	$2,$18,8
	addu	$2,$2,$3
	lw	$3,12($22)
	lw	$2,4($2)
	#nop
	subu	$2,$2,$3
	sw	$2,68($sp)
	lw	$3,16($22)
	lw	$2,8($16)
	lw	$16,Track_chunkList
	subu	$2,$2,$3
	sw	$2,72($sp)
	sll	$2,$18,3
	subu	$2,$2,$18
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxTransZero__Fv
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,64
	.set	noreorder
	.set	nomacro
	jal	TrsProj_TransPt__FP8coorddefT0
	move	$5,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxTrans__FP8coorddef
	move	$4,$fp
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	lw	$2,24($sp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L686
	lw	$3,28($sp)
	lw	$2,36($sp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L686
	lw	$3,40($sp)
	lw	$2,48($sp)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L686
	lw	$3,52($sp)
	lw	$2,60($sp)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L684
$L686:
	lw	$2,16($sp)
	lw	$3,24($sp)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L687
	lw	$2,28($sp)
	lw	$3,36($sp)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L687
	lw	$2,40($sp)
	lw	$3,48($sp)
	subu	$2,$0,$2
	slt	$3,$3,$2
	beq	$3,$0,$L687
	lw	$2,52($sp)
	lw	$3,60($sp)
	subu	$2,$0,$2
	slt	$3,$3,$2
	bne	$3,$0,$L684
$L687:
	lw	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L692
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,36($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L692
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L692
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,60($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L684
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L692:
	#.set	volatile
	sb	$2,3($17)
	#.set	novolatile
	lw	$2,gCurrContext
	#nop
	lw	$2,152($2)
	#nop
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$2,3($17)
	#.set	novolatile
$L689:
	lhu	$2,0($19)
	#nop
	andi	$2,$2,0x4000
	beq	$2,$0,$L690
	#.set	volatile
	lbu	$2,3($17)
	#.set	novolatile
	#nop
	andi	$2,$2,0x00fd
	#.set	volatile
	sb	$2,3($17)
	#.set	novolatile
$L690:
	lhu	$2,0($19)
	#nop
	andi	$2,$2,0x2000
	beq	$2,$0,$L691
	#.set	volatile
	lbu	$2,3($17)
	#.set	novolatile
	#nop
	andi	$2,$2,0x00fe
	#.set	volatile
	sb	$2,3($17)
	#.set	novolatile
$L691:
	.set	noreorder
	.set	nomacro
	jal	GetRezIndex__Fi
	move	$4,$20
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$2,2($17)
	#.set	novolatile
	#.set	volatile
	sh	$18,0($17)
	#.set	novolatile
	addu	$17,$17,4
	addu	$23,$23,1
$L684:
	addu	$19,$19,2
	.set	noreorder
	.set	nomacro
	j	$L680
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L681:
	move	$2,$23
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
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
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	SetupChunkBuildList__FP13DRender_tView
	.text
	.ent	BWorld_IsSliceInBuildList__Fi
BWorld_IsSliceInBuildList__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bgez	$4,$L694
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$4,7
$L694:
	lw	$2,BWorld_gChunkCount
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L695
	sra	$4,$4,3
	.set	macro
	.set	reorder

	move	$6,$2
	lui	$2,%hi(BWorld_gChunkBuildList) # high
	addiu	$3,$2,%lo(BWorld_gChunkBuildList) # low
$L696:
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L699
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L699:
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L695:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	BWorld_IsSliceInBuildList__Fi
	.text
	.ent	BWorld_OnyxBuildFacets__FP13DRender_tView
BWorld_OnyxBuildFacets__FP13DRender_tView:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Chunk_UpdateSys__FP13DRender_tView
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$4,528482304			# 0x1f800000
	sw	$19,gVi2
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	lw	$4,gVi2
	li	$20,1			# 0x00000001
	sw	$2,gWSavePtr
	sw	$20,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
	li	$5,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lui	$4,%hi(gWorldMat) # high
	addiu	$4,$4,%lo(gWorldMat) # low
	li	$5,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	ori	$5,$5,0x0014
	.set	macro
	.set	reorder

	lw	$4,gVi2
	.set	noreorder
	.set	nomacro
	jal	SetupChunkBuildList__FP13DRender_tView
	li	$18,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	sw	$2,BWorld_gChunkCount
	jal	SetSp
	lui	$4,%hi(TrackSpec_gSpec) # high
	addiu	$3,$4,%lo(TrackSpec_gSpec) # low
	sw	$2,gWSavePtr
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$16,$2,%lo(GameSetup_gData) # low
	lhu	$2,24($3)
	lhu	$3,28($3)
	lbu	$4,%lo(TrackSpec_gSpec)($4)
	lw	$5,84($16)
 #APP
 #NO_APP
	sw	$0,stackSpeedUpEnbabledFlag
	sh	$2,220($18)
	sh	$3,222($18)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L703
	sb	$4,270($18)
	.set	macro
	.set	reorder

	lhu	$2,Night_gZNear
	lbu	$3,Night_gXDistShift
	lbu	$4,Night_gZDistShift
	lbu	$5,Night_gDrawLightning
	lbu	$6,Night_gLightningType
	sh	$2,264($18)
	sb	$3,266($18)
	sb	$4,267($18)
	sb	$5,268($18)
	sb	$6,269($18)
$L703:
	li	$4,528482304			# 0x1f800000
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$3,%hi(BWorld_gChunkBuildList) # high
	addiu	$17,$3,%lo(BWorld_gChunkBuildList) # low
	sw	$2,gWSavePtr
	sw	$20,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	lw	$3,60($16)
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L721
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lw	$2,72($16)
	#nop
	beq	$2,$20,$L705
$L721:
	.set	noreorder
	.set	nomacro
	jal	SetSp
	ori	$4,$4,0x03fc
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	sw	$2,gWSavePtr
	sw	$20,stackSpeedUpEnbabledFlag
	.set	noreorder
	.set	nomacro
	jal	DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache
	li	$6,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lw	$4,gWSavePtr
	jal	SetSp
	sw	$2,gWSavePtr
	sw	$0,stackSpeedUpEnbabledFlag
$L705:
	lw	$2,gSpikeBelt
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L722
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$2,BWorld_gChunkCount
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L706
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(BWorld_gChunkBuildList) # high
	addiu	$17,$2,%lo(BWorld_gChunkBuildList) # low
$L710:
	lh	$3,0($17)
	lw	$2,gSpikeBeltChunk
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L709
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$5,gSpikeBeltWidth
	.set	noreorder
	.set	nomacro
	jal	DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache
	move	$6,$18
	.set	macro
	.set	reorder

$L709:
	lw	$2,BWorld_gChunkCount
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L706:
	lui	$2,%hi(GameSetup_gData+12) # high
$L722:
	lw	$2,%lo(GameSetup_gData+12)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L713
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(BWorld_gChunkBuildList) # high
	addiu	$16,$2,%lo(BWorld_gChunkBuildList) # low
$L714:
	lw	$2,BWorld_gChunkCount
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L713
	lh	$2,0($16)
	#nop
	sll	$3,$2,3
	subu	$3,$3,$2
	lw	$2,Track_chunkList
	sll	$3,$3,4
	addu	$2,$2,$3
	lw	$6,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L716
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
	move	$5,$18
	.set	macro
	.set	reorder

$L716:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L714
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L713:
	lw	$2,Object_customSFXInst
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	lui	$4,%hi(gWorldMat) # high
	.set	macro
	.set	reorder

	lw	$4,Object_customSliceNum
	jal	BWorld_IsSliceInBuildList__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$6,Object_customSFXInst
	.set	noreorder
	.set	nomacro
	jal	BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
	move	$5,$18
	.set	macro
	.set	reorder

$L719:
	lui	$4,%hi(gWorldMat) # high
$L723:
	addiu	$4,$4,%lo(gWorldMat) # low
	.set	noreorder
	.set	nomacro
	jal	DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
	ori	$5,$18,0x0014
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi(BWorld_gChunkBuildList) # high
	.set	noreorder
	.set	nomacro
	jal	DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry
	addiu	$5,$5,%lo(BWorld_gChunkBuildList) # low
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

	.end	BWorld_OnyxBuildFacets__FP13DRender_tView
	.text
	.ent	BWAllocMem__Fl
BWAllocMem__Fl:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$5,%hi($LC1) # high
	lw	$2,gBWMemTotal
	sw	$31,16($sp)
	addu	$2,$2,$4
	sw	$2,gBWMemTotal
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC1) # low
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

	.end	BWAllocMem__Fl
	.text
	.ent	BWorld_InitContexts__Fv
BWorld_InitContexts__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$7,-1			# 0xffffffff
	li	$6,1			# 0x00000001
	lui	$2,%hi(gContextMan) # high
	addiu	$4,$2,%lo(gContextMan) # low
	addu	$5,$4,156
	move	$3,$6
	sw	$3,%lo(gContextMan)($2)
	sw	$0,4($4)
$L726:
	sw	$7,8($5)
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bgez	$6,$L726
	addu	$5,$5,-156
	.set	macro
	.set	reorder

	j	$31
	.end	BWorld_InitContexts__Fv
	.text
	.ent	BWorld_DeInitContexts__Fv
BWorld_DeInitContexts__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	BWorld_InitContexts__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorld_DeInitContexts__Fv
	.text
	.ent	SetContext__Fi
SetContext__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,3
	subu	$2,$2,$4
	sll	$2,$2,2
	lui	$3,%hi(gContextMan+8) # high
	addiu	$3,$3,%lo(gContextMan+8) # low
	addu	$2,$2,$3
	sw	$2,gCurrContext
	j	$31
	.end	SetContext__Fi
	.text
	.ent	BWorld_OpenContext__Fii
BWorld_OpenContext__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$4
	lui	$4,%hi(gContextMan) # high
	addiu	$4,$4,%lo(gContextMan) # low
	lw	$3,4($4)
	addu	$4,$4,8
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$4,$2,$4
	sh	$0,4($4)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L734
	sw	$5,0($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L735
	lui	$3,%hi(gContextMan) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L741
	addiu	$3,$3,%lo(gContextMan) # low
	.set	macro
	.set	reorder

$L734:
	li	$3,786432			# 0x000c0000
	ori	$3,$3,0xea40
	li	$2,589824			# 0x00090000
	ori	$2,$2,0xc400
	sw	$2,144($4)
	li	$2,19600			# 0x00004c90
	sw	$2,152($4)
	.set	noreorder
	.set	nomacro
	j	$L739
	li	$2,57600			# 0x0000e100
	.set	macro
	.set	reorder

$L735:
	li	$3,327680			# 0x00050000
	ori	$3,$3,0x2210
	li	$2,262144			# 0x00040000
	ori	$2,$2,0x4944
	sw	$2,144($4)
	li	$2,10000			# 0x00002710
	sw	$2,152($4)
	li	$2,36100			# 0x00008d04
$L739:
	sw	$3,140($4)
	sw	$2,148($4)
	lui	$3,%hi(gContextMan) # high
	addiu	$3,$3,%lo(gContextMan) # low
$L741:
	lw	$4,4($3)
	#nop
	move	$2,$4
	addu	$4,$4,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,4($3)
	.set	macro
	.set	reorder

	.end	BWorld_OpenContext__Fii
	.text
	.ent	BWorld_Restart__Fv
BWorld_Restart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Object_KillStatus__Fv
	jal	Object_InitStatus__Fv
	.set	noreorder
	.set	nomacro
	jal	SetContext__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	jal	BWorld_InitSpikeBelt__Fv
	jal	Anim_Restart__Fv
	sw	$0,SceneLoaded
	jal	Object_ClearCustomObjects__Fv
	sw	$0,Draw_gDoVSync
	jal	BWorldSm_Restart__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorld_Restart__Fv
	.text
	.ent	BWorld_StartLoop__Fv
BWorld_StartLoop__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	BWorld_StartLoop__Fv
	.text
	.ent	BWorld_Init__Fv
BWorld_Init__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,Replay_ReplayMode
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L747
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(GameSetup_gData) # high
	addiu	$16,$4,%lo(GameSetup_gData) # low
	lw	$3,12($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L748
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L775
	lui	$3,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	jal	rand
	bgez	$2,$L749
	addu	$2,$2,16383
$L749:
	sra	$2,$2,14
	.set	noreorder
	.set	nomacro
	jal	rand
	sw	$2,212($16)
	.set	macro
	.set	reorder

	lw	$4,4($16)
	move	$3,$2
	slt	$2,$4,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L750
	move	$2,$3
	.set	macro
	.set	reorder

	mult	$3,$4
	mflo	$2
	#nop
	#nop
	bgez	$2,$L751
	addu	$2,$2,32767
$L751:
	.set	noreorder
	.set	nomacro
	j	$L772
	sra	$2,$2,15
	.set	macro
	.set	reorder

$L750:
	bgez	$2,$L753
	addu	$2,$2,16383
$L753:
	sra	$2,$2,14
$L772:
	.set	noreorder
	.set	nomacro
	jal	rand
	sw	$2,216($16)
	.set	macro
	.set	reorder

	lui	$3,%hi(GameSetup_gData) # high
	addiu	$4,$3,%lo(GameSetup_gData) # low
	lw	$3,4($4)
	#nop
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L754
	addu	$2,$2,32767
$L754:
	lw	$3,216($4)
	sra	$2,$2,15
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L755
	sw	$2,220($4)
	.set	macro
	.set	reorder

	addu	$2,$3,1
	sw	$2,220($4)
$L755:
	lw	$2,72($4)
	#nop
	beq	$2,$0,$L756
	lw	$2,212($4)
	lw	$3,220($4)
	addu	$2,$2,10
	addu	$3,$3,5
	sw	$2,212($4)
	.set	noreorder
	.set	nomacro
	j	$L757
	sw	$3,220($4)
	.set	macro
	.set	reorder

$L756:
	lw	$2,24($4)
	#nop
	beq	$2,$0,$L757
	lw	$2,212($4)
	#nop
	addu	$2,$2,20
	sw	$2,212($4)
$L757:
	sw	$0,SceneLoaded
	j	$L747
$L748:
	lui	$3,%hi(GameSetup_gData) # high
$L775:
	addiu	$3,$3,%lo(GameSetup_gData) # low
	li	$2,99			# 0x00000063
	sw	$2,212($3)
	sw	$2,216($3)
	sw	$2,220($3)
$L747:
	.set	noreorder
	.set	nomacro
	jal	Object_InitStatus__Fv
	lui	$16,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(GameSetup_gData) # low
	lw	$4,60($16)
	jal	Track_SetTrackNumber__Fi
	jal	BWorld_InitContexts__Fv
	lw	$3,12($16)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L760
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	BWorld_OpenContext__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L773
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L760:
	move	$4,$0
$L773:
	.set	noreorder
	.set	nomacro
	jal	BWorld_OpenContext__Fii
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetContext__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,84($3)
	#nop
	beq	$2,$0,$L762
	lw	$2,72($3)
	#nop
	beq	$2,$0,$L763
	lui	$4,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	j	$L774
	addiu	$4,$4,%lo($LC2) # low
	.set	macro
	.set	reorder

$L763:
	lui	$4,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L774
	addiu	$4,$4,%lo($LC3) # low
	.set	macro
	.set	reorder

$L762:
	lw	$2,72($3)
	#nop
	beq	$2,$0,$L766
	lui	$4,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	j	$L774
	addiu	$4,$4,%lo($LC4) # low
	.set	macro
	.set	reorder

$L766:
	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
$L774:
	jal	Track_MakeTrackPathName__FPc
	.set	noreorder
	.set	nomacro
	jal	Track_Init__FPc
	move	$4,$2
	.set	macro
	.set	reorder

	jal	Object_InitCustomObjects__Fv
	jal	Object_InitIMassObjectInfo__Fv
	lw	$4,gPersistObjDef
	#nop
	beq	$4,$0,$L768
	lw	$4,0($4)
	jal	Scene_Init__Fi
$L768:
	.set	noreorder
	.set	nomacro
	jal	Loading_UpdateLoadingScreen__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lui	$4,%hi($LC6) # high
	.set	noreorder
	.set	nomacro
	jal	Track_MakeTrackDataPathName__FPc
	addiu	$4,$4,%lo($LC6) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Anim_InitSystem__FPc
	move	$4,$2
	.set	macro
	.set	reorder

	lui	$3,%hi(GameSetup_gData) # high
	addiu	$5,$3,%lo(GameSetup_gData) # low
	lw	$2,12($5)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L776
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L769
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L776
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$4,212($5)
	jal	Scene_LoadSceneFile__Fi
$L769:
	lui	$2,%hi(GameSetup_gData) # high
$L776:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	lw	$3,84($2)
	lw	$2,72($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	sltu	$4,$0,$3
	.set	macro
	.set	reorder

	addu	$4,$4,2
$L770:
	jal	AudList_LoadAudioFile__Fi
	jal	BWorld_InitSpikeBelt__Fv
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorld_Init__Fv
	.text
	.ent	BWorld_DeInit__Fv
BWorld_DeInit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Object_KillStatus__Fv
	jal	Track_DeInit__Fv
	jal	BWorld_DeInitContexts__Fv
	jal	Object_DeInitIMassObjectInfo__Fv
	jal	Scene_DeInit__Fv
	jal	Object_DeInitCustomObjects__Fv
	sw	$0,SceneLoaded
	jal	AudList_PurgeAudio__Fv
	jal	Anim_DeInitSystem__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorld_DeInit__Fv
