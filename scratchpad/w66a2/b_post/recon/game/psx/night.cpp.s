	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\night.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	lightningInit
	.sdata
lightningInit:
	.byte	1
	.globl	Night_gCopCountryLightTbl
	.data
	.align	2
Night_gCopCountryLightTbl:
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.globl	CopCarTypeLights
	.sdata
	.align	2
CopCarTypeLights:
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.text
	.align	2
	.globl	Night_FindClosestColor__FG7CVECTORPi
	.align	2
	.globl	Night_CreateNightTableElement__FiliPUc
	.align	2
	.globl	Night_CreateNightTable__FiliPA256_A16_Uc
	.align	2
	.globl	Night_GenerateNextLightningEvent__Fv
	.align	2
	.globl	Night_PauseLightningEffect__Fi
	.align	2
	.globl	Night_DoLightningEffect__FP13DRender_tView
	.align	2
	.globl	Night_SetCopColor__FP18GameSetup_tCarData
	.sdata
	.align	2
$LC0:
	.ascii	"plnight\000"
	.text
	.align	2
	.globl	Night_InitPlayerHeadLightColor__Fi
	.align	2
	.globl	Night_SetPlayerHeadLightColor__Fiii
	.sdata
	.align	2
$LC1:
	.ascii	"CopRed\000"
	.align	2
$LC2:
	.ascii	"CopBlue\000"
	.text
	.align	2
	.globl	Night_InitCopLightColors__Fv
	.align	2
	.globl	Night_SetCopLightColors__Fii
	.sdata
	.align	2
$LC3:
	.ascii	"wtnight\000"
	.text
	.align	2
	.globl	Night_InitWeatherTables__Fv
	.align	2
	.globl	Night_SetWeatherColors__Fi
	.data
	.align	2
colorCreationTable.252:
	.byte	0
	.byte	15
	.byte	7
	.byte	5
	.byte	11
	.byte	13
	.byte	3
	.byte	9
	.byte	1
	.byte	14
	.byte	10
	.byte	4
	.byte	2
	.byte	12
	.byte	6
	.byte	8
	.text
	.align	2
	.globl	Night_GenerateAllLightTables__Fv
	.rdata
	.align	2
$LC4:
	.ascii	"%snight.psh\000"
	.align	2
$LC5:
	.ascii	"night.psh\000"
	.sdata
	.align	2
$LC6:
	.ascii	"nght\000"
	.text
	.align	2
	.globl	Night_InitNightDriving__Fv
	.align	2
	.globl	Night_KillNightDriving__Fv
	.align	2
	.globl	Night_RestartNightDriving__Fv
	.align	2
	.globl	Night_SetEnviroment__FP13DRender_tView
	.align	2
	.globl	Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
	.globl	Night_gCopCarTypeColorIdx
	.sdata
	.align	2
Night_gCopCarTypeColorIdx:
	.space	2
	.globl	Night_gLightningPauseAreas
	.data
	.align	2
Night_gLightningPauseAreas:
	.space	128
	.globl	Night_gAdditiveHeadlightColor
	.align	2
Night_gAdditiveHeadlightColor:
	.space	64
	.globl	Night_gDrawLightning
	.sdata
Night_gDrawLightning:
	.space	1
	.globl	Night_gPlayerLightingTable
	.align	2
Night_gPlayerLightingTable:
	.space	4
	.globl	Night_gCopLightingTableRed
	.align	2
Night_gCopLightingTableRed:
	.space	4
	.globl	Night_gCopLightingTableBlue
	.align	2
Night_gCopLightingTableBlue:
	.space	4
	.globl	Night_gWeatherLightingTable
	.align	2
Night_gWeatherLightingTable:
	.space	4
	.globl	D_8013D9F4
	.align	2
D_8013D9F4:
	.space	4
	.globl	gNight_renderNight
	.align	2
gNight_renderNight:
	.space	4
	.globl	Night_gXDist
	.align	2
Night_gXDist:
	.space	4
	.globl	Night_gZNear
	.align	2
Night_gZNear:
	.space	4
	.globl	Night_gZDist
	.align	2
Night_gZDist:
	.space	4
	.globl	Night_gXDistShift
	.align	2
Night_gXDistShift:
	.space	4
	.globl	Night_gZDistShift
	.align	2
Night_gZDistShift:
	.space	4
	.globl	Night_gNightTbl
	.align	2
Night_gNightTbl:
	.space	4
	.globl	Night_gLightningType
	.align	2
Night_gLightningType:
	.space	4
	.globl	Night_gCurrentNightColor
	.align	2
Night_gCurrentNightColor:
	.space	4
	.globl	Night_gCopColor
	.align	2
Night_gCopColor:
	.space	4
	.globl	D_8013DA50
	.align	2
D_8013DA50:
	.space	4
	.globl	Night_gNightAmbientColor
	.align	2
Night_gNightAmbientColor:
	.space	4
	.globl	Night_gColor
	.align	2
Night_gColor:
	.space	8
	.globl	Night_gTotalLights
	.align	2
Night_gTotalLights:
	.space	4
	.globl	Night_gLightning
	.align	2
Night_gLightning:
	.space	4
	.globl	Night_gNextLightning
	.align	2
Night_gNextLightning:
	.space	4
	.globl	Night_gEndNextLightning
	.align	2
Night_gEndNextLightning:
	.space	4
	.globl	Night_gNextFlicker
	.align	2
Night_gNextFlicker:
	.space	4
	.globl	Night_gFlashAzimuth
	.align	2
Night_gFlashAzimuth:
	.space	4
	.globl	Night_gShowForks
Night_gShowForks:
	.space	1
	.globl	Night_gFlashIntensity
	.align	2
Night_gFlashIntensity:
	.space	4
	.globl	Night_gPlayerHeadLightColor
	.align	2
Night_gPlayerHeadLightColor:
	.space	8
	.globl	Night_gWeatherColor
	.align	2
Night_gWeatherColor:
	.space	4
	.globl	D_8013DA8C
	.align	2
D_8013DA8C:
	.space	4
	.globl	gNightInitCache
	.align	2
gNightInitCache:
	.space	4
	.globl	gTableCache
	.align	2
gTableCache:
	.space	4
	.globl	nightfile
	.align	2
nightfile:
	.space	4

	.extern	GameSetup_gData, 2600
	.extern	Chunk_lightTable, 4
	.extern	Night_gWeatherColor, 8
	.extern	Night_gWeatherLightingTable, 8
	.extern	TrackSpec_gSpec, 264
	.extern	Night_gCopColor, 8
	.extern	Weather_gType, 4
	.extern	simGlobal, 24
	.extern	Chunk_numLight, 4

	.text
	.text
	.ent	Night_FindClosestColor__FG7CVECTORPi
Night_FindClosestColor__FG7CVECTORPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$8,131072			# 0x00020000
	lw	$2,gTableCache
	lw	$3,Night_gTotalLights
	li	$7,1			# 0x00000001
	sw	$4,0($sp)
	lbu	$15,0($sp)
	lbu	$14,1($sp)
	lbu	$13,2($sp)
	addu	$3,$3,$7
	lbu	$11,0($2)
	lbu	$12,1($2)
	lbu	$10,2($2)
	slt	$2,$7,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	ori	$8,$8,0xfa03
	.set	macro
	.set	reorder

	li	$9,3			# 0x00000003
$L602:
	subu	$2,$15,$11
	mult	$2,$2
	mflo	$4
	#nop
	subu	$2,$14,$12
	mult	$2,$2
	mflo	$6
	#nop
	subu	$2,$13,$10
	mult	$2,$2
	lw	$2,gTableCache
	addu	$4,$4,$6
	addu	$2,$9,$2
	lbu	$11,0($2)
	lbu	$12,1($2)
	lbu	$10,2($2)
	mflo	$25
	#nop
	#nop
	addu	$4,$4,$25
	slt	$2,$4,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	addu	$2,$7,-1
	.set	macro
	.set	reorder

	move	$8,$4
	sw	$2,0($5)
	slt	$2,$8,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	addu	$7,$7,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$8
	.set	macro
	.set	reorder

$L605:
	addu	$7,$7,1
$L609:
	slt	$2,$7,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	addu	$9,$9,3
	.set	macro
	.set	reorder

$L601:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$8
	.set	macro
	.set	reorder

	.end	Night_FindClosestColor__FG7CVECTORPi
	.text
	.ent	Night_CreateNightTableElement__FiliPUc
Night_CreateNightTableElement__FiliPUc:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$7
	sll	$2,$6,4
	addu	$2,$2,$6
	sll	$2,$2,4
	sw	$5,52($sp)
	lbu	$3,52($sp)
	addu	$7,$2,$6
	mult	$3,$7
	sw	$16,32($sp)
	move	$16,$4
	sll	$2,$16,1
	lw	$3,gTableCache
	addu	$2,$2,$16
	sw	$31,40($sp)
	addu	$2,$2,$3
	lbu	$4,0($2)
	lbu	$5,1($2)
	mflo	$10
	#nop
	#nop
	sra	$3,$10,12
	addu	$6,$4,$3
	addu	$3,$sp,52
	slt	$4,$6,256
	lbu	$8,1($3)
	lbu	$9,2($3)
	lbu	$3,2($2)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L617
	mult	$8,$7
	.set	macro
	.set	reorder

	li	$6,255			# 0x000000ff
$L617:
	mflo	$10
	#nop
	#nop
	sra	$2,$10,12
	addu	$5,$5,$2
	slt	$2,$5,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	mult	$9,$7
	.set	macro
	.set	reorder

	li	$5,255			# 0x000000ff
$L618:
	mflo	$10
	#nop
	#nop
	sra	$2,$10,12
	addu	$4,$3,$2
 #APP
 #NO_APP
	slt	$2,$4,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	li	$3,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	li	$4,255			# 0x000000ff
$L619:
	and	$2,$4,$3
	sb	$2,18($sp)
	and	$2,$5,$3
	sb	$2,17($sp)
	andi	$4,$2,0x00ff
	and	$3,$6,$3
	sll	$4,$4,8
	sb	$3,16($sp)
	andi	$3,$3,0x00ff
	or	$3,$3,$4
	addu	$5,$sp,24
	lbu	$2,18($sp)
	lbu	$4,19($sp)
	sll	$2,$2,16
	or	$3,$3,$2
	sll	$4,$4,24
	.set	noreorder
	.set	nomacro
	jal	Night_FindClosestColor__FG7CVECTORPi
	or	$4,$3,$4
	.set	macro
	.set	reorder

	slt	$2,$2,513
	bne	$2,$0,$L615
	lw	$2,Chunk_numLight
	#nop
	addu	$2,$2,4
	slt	$2,$16,$2
	beq	$2,$0,$L615
	lw	$3,Night_gTotalLights
	#nop
	slt	$2,$3,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	sll	$2,$3,1
	.set	macro
	.set	reorder

$L615:
	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L610
	sb	$2,0($17)
	.set	macro
	.set	reorder

$L614:
	addu	$2,$2,$3
	lw	$3,gTableCache
	lbu	$4,16($sp)
	addu	$2,$2,$3
	sb	$4,0($2)
	lw	$3,Night_gTotalLights
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,gTableCache
	lbu	$4,17($sp)
	addu	$2,$2,$3
	sb	$4,1($2)
	lw	$3,Night_gTotalLights
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,gTableCache
	lbu	$4,18($sp)
	addu	$2,$2,$3
	sb	$4,2($2)
	lbu	$2,Night_gTotalLights
	#nop
	sb	$2,0($17)
	lw	$2,Night_gTotalLights
	#nop
	addu	$2,$2,1
	sw	$2,Night_gTotalLights
$L610:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Night_CreateNightTableElement__FiliPUc
	.text
	.ent	Night_CreateNightTable__FiliPA256_A16_Uc
Night_CreateNightTable__FiliPA256_A16_Uc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sll	$2,$4,4
	addu	$7,$7,$2
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Night_CreateNightTableElement__FiliPUc
	addu	$7,$7,$6
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

	.end	Night_CreateNightTable__FiliPA256_A16_Uc
	.text
	.ent	Night_GenerateNextLightningEvent__Fv
Night_GenerateNextLightningEvent__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	random
	lui	$3,%hi(simGlobal+4) # high
	andi	$2,$2,0x07ff
	lw	$3,%lo(simGlobal+4)($3)
	addu	$2,$2,31
	addu	$3,$3,$2
	sw	$3,Night_gNextLightning
	jal	random
	andi	$2,$2,0x000f
	lw	$3,Night_gNextLightning
	addu	$2,$2,15
	addu	$2,$3,$2
	sw	$2,Night_gEndNextLightning
	sw	$3,Night_gNextFlicker
	jal	random
	andi	$2,$2,0xffff
	sw	$2,Night_gFlashAzimuth
	jal	random
	lw	$31,16($sp)
	andi	$2,$2,0x0001
	sb	$2,Night_gShowForks
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_GenerateNextLightningEvent__Fv
	.text
	.ent	Night_PauseLightningEffect__Fi
Night_PauseLightningEffect__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(Camera_gInfo) # high
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sll	$2,$4,4
	addu	$2,$2,$4
	sll	$2,$2,4
	addu	$2,$2,$3
	lui	$4,%hi(D_80113228) # high
	lui	$3,%hi(Night_gLightningPauseAreas) # high
	addiu	$3,$3,%lo(Night_gLightningPauseAreas) # low
	lw	$4,%lo(D_80113228)($4)
	lh	$5,140($2)
	sll	$4,$4,3
	addu	$4,$4,$3
	lw	$2,0($4)
	lw	$4,4($4)
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	move	$3,$0
	.set	macro
	.set	reorder

	slt	$3,$5,$4
$L623:
	lw	$2,Weather_gType
	#nop
	bne	$2,$0,$L624
	li	$3,1			# 0x00000001
$L624:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L626
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(D_8011E0B0)($2)
	#nop
	sw	$2,Night_gNextLightning
	sw	$2,Night_gEndNextLightning
$L626:
	j	$31
	.end	Night_PauseLightningEffect__Fi
	.text
	.ent	Night_DoLightningEffect__FP13DRender_tView
Night_DoLightningEffect__FP13DRender_tView:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,Night_gLightning
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$4,Night_gFlashIntensity
	lw	$5,Night_gFlashAzimuth
	jal	AudioCmn_PlayThunder__Fii
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningFlicker__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	sw	$0,Night_gLightning
$L628:
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,Night_gNextLightning
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,Night_gEndNextLightning
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,Night_gNextFlicker
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	jal	random
	li	$4,1			# 0x00000001
	and	$2,$2,$4
	sw	$2,Night_gLightningType
	jal	Hrz_LightningFlicker__Fi
	lui	$4,%hi(Camera_gInfo+140) # high
	lw	$3,4($16)
	addiu	$4,$4,%lo(Camera_gInfo+140) # low
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$0,Night_gDrawLightning
	j	$L635
$L630:
	li	$2,1			# 0x00000001
	sb	$2,Night_gDrawLightning
	li	$2,1			# 0x00000001
$L635:
	sw	$2,Night_gLightning
	jal	random
	lui	$3,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($3)
	andi	$2,$2,0x0003
	addu	$3,$3,$2
	sw	$3,Night_gNextFlicker
	jal	random
	lw	$3,Night_gLightningType
	andi	$2,$2,0x001f
	addu	$3,$3,1
	mult	$3,$2
	lbu	$3,lightningInit
	mflo	$6
	#nop
	#nop
	addu	$2,$6,64
	sw	$2,Night_gFlashIntensity
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L636
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lbu	$2,Night_gShowForks
	#nop
	beq	$2,$0,$L633
	.set	noreorder
	.set	nomacro
	jal	Hrz_SetLightingPosInSky__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

$L633:
	sb	$0,lightningInit
	lui	$2,%hi(simGlobal+4) # high
$L636:
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,Night_gEndNextLightning
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L627
	jal	Night_GenerateNextLightningEvent__Fv
	jal	Hrz_CalculateLightning__Fv
	li	$2,1			# 0x00000001
	sb	$2,lightningInit
$L627:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_DoLightningEffect__FP13DRender_tView
	.text
	.ent	Night_SetCopColor__FP18GameSetup_tCarData
Night_SetCopColor__FP18GameSetup_tCarData:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	la	$3,Night_gCopCarTypeColorIdx
	lw	$2,0($4)
	lw	$5,160($4)
	addu	$2,$2,$3
	lbu	$4,0($2)
	lw	$2,Night_gCopLightingTableRed
	lw	$3,Night_gCopLightingTableBlue
	sw	$2,8($sp)
	lui	$2,%hi(Night_gCopCountryLightTbl) # high
	addiu	$2,$2,%lo(Night_gCopCountryLightTbl) # low
	sw	$3,12($sp)
	sll	$3,$4,2
	addu	$3,$3,$4
	addu	$3,$3,$5
	sll	$3,$3,1
	addu	$3,$3,$2
	lw	$6,8($sp)
	lw	$7,12($sp)
	sw	$6,0($sp)
	sw	$7,4($sp)
	lbu	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	lw	$4,0($2)
	lbu	$2,1($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	sw	$4,Night_gCopColor
	lw	$2,0($2)
	#nop
	sw	$2,Night_gCopColor+4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	Night_SetCopColor__FP18GameSetup_tCarData
	.text
	.ent	Night_InitPlayerHeadLightColor__Fi
Night_InitPlayerHeadLightColor__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,Night_gPlayerLightingTable
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Night_gPlayerLightingTable
$L639:
	sll	$3,$16,2
	la	$4,Night_gPlayerHeadLightColor
	lui	$2,%hi(TrackSpec_gSpec+236) # high
	lw	$2,%lo(TrackSpec_gSpec+236)($2)
	addu	$3,$3,$4
	sw	$2,0($3)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_InitPlayerHeadLightColor__Fi
	.text
	.ent	Night_SetPlayerHeadLightColor__Fiii
Night_SetPlayerHeadLightColor__Fiii:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sll	$2,$4,2
	la	$3,Night_gPlayerHeadLightColor
	addu	$2,$2,$3
	move	$4,$5
	sw	$31,16($sp)
	lw	$5,0($2)
	lw	$7,Night_gPlayerLightingTable
	jal	Night_CreateNightTable__FiliPA256_A16_Uc
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_SetPlayerHeadLightColor__Fiii
	.text
	.ent	Night_InitCopLightColors__Fv
Night_InitCopLightColors__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,Night_gCopLightingTableRed
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Night_gCopLightingTableRed
$L642:
	lw	$2,Night_gCopLightingTableBlue
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L641
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC2) # low
	li	$5,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,Night_gCopLightingTableBlue
$L641:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_InitCopLightColors__Fv
	.text
	.ent	Night_SetCopLightColors__Fii
Night_SetCopLightColors__Fii:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	li	$5,6291456			# 0x00600000
	ori	$5,$5,0x2020
	lw	$7,Night_gCopLightingTableBlue
	move	$6,$17
	sw	$19,28($sp)
	sll	$19,$16,3
	sw	$18,24($sp)
	sra	$18,$17,1
	sw	$31,32($sp)
	addu	$7,$7,$19
	.set	noreorder
	.set	nomacro
	jal	Night_CreateNightTableElement__FiliPUc
	addu	$7,$7,$18
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1048576			# 0x00100000
	ori	$5,$5,0x1054
	lw	$7,Night_gCopLightingTableRed
	move	$6,$17
	addu	$7,$7,$19
	.set	noreorder
	.set	nomacro
	jal	Night_CreateNightTableElement__FiliPUc
	addu	$7,$7,$18
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

	.end	Night_SetCopLightColors__Fii
	.text
	.ent	Night_InitWeatherTables__Fv
Night_InitWeatherTables__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	lui	$18,%hi($LC3) # high
	sw	$16,16($sp)
	la	$16,Night_gWeatherLightingTable
	sw	$31,28($sp)
$L649:
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	addiu	$4,$18,%lo($LC3) # low
	.set	macro
	.set	reorder

	li	$5,256			# 0x00000100
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
$L648:
	addu	$17,$17,1
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$3,5701632			# 0x00570000
	ori	$3,$3,0x4054
	li	$2,7077888			# 0x006c0000
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	ori	$2,$2,0x4040
	sw	$3,Night_gWeatherColor
	sw	$2,D_8013DA8C
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Night_InitWeatherTables__Fv
	.text
	.ent	Night_SetWeatherColors__Fi
Night_SetWeatherColors__Fi:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$18,24($sp)
	move	$18,$0
	sw	$17,20($sp)
	la	$17,Night_gWeatherColor
	sw	$16,16($sp)
	la	$16,Night_gWeatherLightingTable
	sw	$31,32($sp)
$L653:
	lw	$5,0($17)
	addu	$17,$17,4
	lw	$7,0($16)
	addu	$16,$16,4
	addu	$18,$18,1
	move	$4,$19
	li	$6,15			# 0x0000000f
	.set	noreorder
	.set	nomacro
	jal	Night_CreateNightTableElement__FiliPUc
	addu	$7,$7,$19
	.set	macro
	.set	reorder

	slt	$2,$18,2
	bne	$2,$0,$L653
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

	.end	Night_SetWeatherColors__Fi
	.text
	.ent	Night_GenerateAllLightTables__Fv
Night_GenerateAllLightTables__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$6,$0
	move	$5,$6
	lw	$3,Chunk_numLight
	li	$2,528482304			# 0x1f800000
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$2,gNightInitCache
	sw	$2,gTableCache
	sw	$3,Night_gTotalLights
$L658:
	sll	$4,$6,2
	addu	$6,$6,1
	lw	$3,Chunk_lightTable
	lw	$2,gTableCache
	addu	$3,$4,$3
	lbu	$3,0($3)
	addu	$2,$5,$2
	sb	$3,0($2)
	lw	$3,Chunk_lightTable
	lw	$2,gTableCache
	addu	$3,$4,$3
	lbu	$3,1($3)
	addu	$2,$5,$2
	sb	$3,1($2)
	lw	$2,gTableCache
	lw	$3,Chunk_lightTable
	addu	$2,$5,$2
	addu	$4,$4,$3
	lbu	$3,2($4)
	#nop
	sb	$3,2($2)
	slt	$2,$6,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	addu	$5,$5,3
	.set	macro
	.set	reorder

	move	$18,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(colorCreationTable.252) # high
	addiu	$20,$2,%lo(colorCreationTable.252) # low
$L662:
	lw	$2,Night_gTotalLights
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,72($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L667
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Night_SetWeatherColors__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	move	$16,$0
$L667:
	slt	$2,$16,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L668
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$2,$16,$20
	lbu	$17,0($2)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Night_SetPlayerHeadLightColor__Fiii
	move	$6,$17
	.set	macro
	.set	reorder

	lw	$2,20($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	slt	$2,$16,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Night_SetCopLightColors__Fii
	move	$5,$17
	.set	macro
	.set	reorder

$L670:
	.set	noreorder
	.set	nomacro
	j	$L667
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L668:
	.set	noreorder
	.set	nomacro
	j	$L662
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L663:
	move	$6,$0
	move	$5,$6
$L671:
	sll	$4,$6,2
	addu	$6,$6,1
	lw	$3,gTableCache
	lw	$2,Chunk_lightTable
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$2,$4,$2
	sb	$3,0($2)
	lw	$2,gTableCache
	lw	$3,Chunk_lightTable
	addu	$2,$5,$2
	lbu	$2,1($2)
	addu	$3,$4,$3
	sb	$2,1($3)
	lw	$2,gTableCache
	lw	$3,Chunk_lightTable
	addu	$2,$5,$2
	lbu	$2,2($2)
	addu	$4,$4,$3
	sb	$2,2($4)
	slt	$2,$6,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	addu	$5,$5,3
	.set	macro
	.set	reorder

	move	$4,$0
	la	$7,Night_gPlayerHeadLightColor
	li	$6,-2004353024			# 0x88880000
	ori	$6,$6,0x8889
	lui	$2,%hi(Night_gAdditiveHeadlightColor) # high
	addiu	$5,$2,%lo(Night_gAdditiveHeadlightColor) # low
$L675:
	lbu	$2,Night_gPlayerHeadLightColor
	#nop
	mult	$2,$4
	mflo	$2
	#nop
	#nop
	mult	$2,$6
	mfhi	$3
	#nop
	#nop
	addu	$3,$3,$2
	sra	$3,$3,3
	sra	$2,$2,31
	subu	$3,$3,$2
	sb	$3,0($5)
	lbu	$2,1($7)
	#nop
	mult	$2,$4
	mflo	$2
	#nop
	#nop
	mult	$2,$6
	mfhi	$3
	#nop
	#nop
	addu	$3,$3,$2
	sra	$3,$3,3
	sra	$2,$2,31
	subu	$3,$3,$2
	sb	$3,1($5)
	lbu	$2,2($7)
	#nop
	mult	$2,$4
	mflo	$2
	#nop
	#nop
	mult	$2,$6
	addu	$4,$4,1
	mfhi	$3
	#nop
	#nop
	addu	$3,$3,$2
	sra	$3,$3,3
	sra	$2,$2,31
	subu	$3,$3,$2
	sb	$3,2($5)
	slt	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	addu	$5,$5,4
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

	.end	Night_GenerateAllLightTables__Fv
	.text
	.ent	Night_InitNightDriving__Fv
Night_InitNightDriving__Fv:
	.frame	$sp,288,$31		# vars= 256, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,288
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$4,$2,%lo(GameSetup_gData) # low
	sw	$31,280($sp)
	sw	$17,276($sp)
	sw	$16,272($sp)
	lw	$3,84($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L680
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,12($4)
	#nop
	xori	$2,$2,0x0001
	sltu	$2,$0,$2
$L680:
	sw	$2,gNight_renderNight
	beq	$3,$0,$L681
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(TrackSpec_gSpec) # high
	addiu	$2,$2,%lo(TrackSpec_gSpec) # low
	li	$3,255			# 0x000000ff
	sw	$3,244($2)
	sw	$0,240($2)
$L681:
	lw	$2,gNight_renderNight
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L687:
	lui	$2,%hi(Paths_Paths+100) # high
	lui	$5,%hi($LC4) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sw	$2,nightfile
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	filesize
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,nightfile
	.set	noreorder
	.set	nomacro
	jal	blockmove
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$5,%hi($LC6) # high
	lw	$4,nightfile
	.set	noreorder
	.set	nomacro
	jal	locateshape
	addiu	$5,$5,%lo($LC6) # low
	.set	macro
	.set	reorder

	addu	$2,$2,16
	sw	$2,Night_gNightTbl
	.set	noreorder
	.set	nomacro
	jal	Night_InitPlayerHeadLightColor__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$16,$2,%lo(GameSetup_gData) # low
	lw	$2,20($16)
	#nop
	beq	$2,$0,$L683
	jal	Night_InitCopLightColors__Fv
$L683:
	lw	$2,72($16)
	li	$17,1			# 0x00000001
	bne	$2,$17,$L684
	jal	Night_InitWeatherTables__Fv
$L684:
	jal	Night_GenerateAllLightTables__Fv
	lw	$2,72($16)
	#nop
	bne	$2,$17,$L679
	sw	$0,Night_gLightning
	jal	random
	lui	$3,%hi(D_8011E0B0) # high
	lw	$3,%lo(D_8011E0B0)($3)
	andi	$2,$2,0x01ff
	addu	$3,$3,$2
	sw	$3,Night_gNextLightning
	jal	random
	lw	$3,Night_gNextLightning
	andi	$2,$2,0x0031
	addu	$2,$3,$2
	sw	$2,Night_gEndNextLightning
	sw	$3,Night_gNextFlicker
	jal	Hrz_CalculateLightning__Fv
$L679:
	lw	$31,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,288
	.set	macro
	.set	reorder

	.end	Night_InitNightDriving__Fv
	.text
	.ent	Night_KillNightDriving__Fv
Night_KillNightDriving__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,nightfile
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L689
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L689:
	lw	$4,Night_gPlayerLightingTable
	sw	$0,nightfile
	beq	$4,$0,$L690
	jal	purgememadr
$L690:
	lw	$4,Night_gCopLightingTableRed
	sw	$0,Night_gPlayerLightingTable
	beq	$4,$0,$L691
	jal	purgememadr
$L691:
	lw	$4,Night_gCopLightingTableBlue
	sw	$0,Night_gCopLightingTableRed
	beq	$4,$0,$L692
	jal	purgememadr
$L692:
	lw	$4,Night_gWeatherLightingTable
	sw	$0,Night_gCopLightingTableBlue
	beq	$4,$0,$L693
	jal	purgememadr
$L693:
	lw	$4,D_8013D9F4
	sw	$0,Night_gWeatherLightingTable
	beq	$4,$0,$L694
	jal	purgememadr
$L694:
	lw	$31,16($sp)
	sw	$0,D_8013D9F4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_KillNightDriving__Fv
	.text
	.ent	Night_RestartNightDriving__Fv
Night_RestartNightDriving__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$4,$2,%lo(GameSetup_gData) # low
	sw	$31,16($sp)
	lw	$3,72($4)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L695
	lw	$2,84($4)
	#nop
	beq	$2,$0,$L695
	sw	$0,Night_gLightning
	jal	random
	lui	$3,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($3)
	andi	$2,$2,0x01ff
	addu	$3,$3,$2
	sw	$3,Night_gNextLightning
	jal	random
	andi	$2,$2,0x0031
	lw	$3,Night_gNextLightning
	#nop
	addu	$2,$3,$2
	sw	$2,Night_gEndNextLightning
	sw	$3,Night_gNextFlicker
	.set	noreorder
	.set	nomacro
	jal	Hrz_LightningFlicker__Fi
	move	$4,$0
	.set	macro
	.set	reorder

$L695:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_RestartNightDriving__Fv
	.text
	.ent	Night_SetEnviroment__FP13DRender_tView
Night_SetEnviroment__FP13DRender_tView:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	sw	$31,20($sp)
	sw	$16,16($sp)
	lw	$2,84($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$2,Night_gPlayerLightingTable
	lw	$3,72($3)
	sb	$0,Night_gDrawLightning
	sw	$2,Night_gCurrentNightColor
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L702
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$4,4($16)
	jal	Night_PauseLightningEffect__Fi
	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L702
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Night_DoLightningEffect__FP13DRender_tView
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,10			# 0x0000000a
$L702:
	sw	$2,Night_gXDistShift
	li	$2,12			# 0x0000000c
	lui	$3,%hi(Camera_gInfo) # high
	lw	$4,4($16)
	addiu	$3,$3,%lo(Camera_gInfo) # low
	sw	$2,Night_gZDistShift
	sll	$2,$4,4
	addu	$2,$2,$4
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,4($2)
	li	$3,128			# 0x00000080
 #APP
 #NO_APP
	sw	$3,Night_gZNear
	lbu	$2,1095($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	li	$2,13			# 0x0000000d
	.set	macro
	.set	reorder

	sw	$2,Night_gZDistShift
	li	$2,11			# 0x0000000b
	sw	$2,Night_gXDistShift
$L700:
	lw	$4,4($16)
	jal	Camera_GetMode__Fi
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L703
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-512			# 0xfffffe00
	sw	$2,Night_gZNear
$L703:
	lw	$5,Night_gXDistShift
	lw	$4,Night_gZDistShift
	sll	$2,$3,$5
	sll	$3,$3,$4
	addu	$4,$4,-6
	addu	$5,$5,-5
	sw	$2,Night_gXDist
	sw	$3,Night_gZDist
	sw	$4,Night_gZDistShift
	sw	$5,Night_gXDistShift
$L697:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Night_SetEnviroment__FP13DRender_tView
	.text
	.ent	Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
Night_AdditiveNightCalc__FP6VECTORP7CVECTOR:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$5
 #APP
 #NO_APP
	li	$10,1			# 0x00000001
	lw	$9,Night_gZDistShift
	lw	$6,Night_gZNear
	lw	$5,8($4)
	addu	$2,$9,6
	sll	$2,$10,$2
	addu	$3,$6,$2
	slt	$2,$6,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L711
	lw	$8,Night_gXDistShift
	lw	$4,0($4)
	addu	$2,$8,5
	sll	$3,$10,$2
	subu	$2,$0,$3
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	subu	$2,$5,$6
	sra	$2,$2,$9
	sll	$2,$2,6
	sra	$4,$4,$8
	addu	$2,$2,$4
	lui	$4,%hi(Night_gAdditiveHeadlightColor) # high
	lw	$3,Night_gNightTbl
	addiu	$4,$4,%lo(Night_gAdditiveHeadlightColor) # low
	addu	$3,$3,$2
	lbu	$2,0($3)
	lbu	$5,0($7)
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$3,0($2)
	lbu	$4,1($7)
	andi	$2,$3,0x00ff
	addu	$5,$5,$2
	move	$9,$5
	andi	$2,$3,0xff00
	sra	$2,$2,8
	addu	$4,$4,$2
	move	$8,$4
	srl	$3,$3,16
	andi	$3,$3,0x00ff
	lbu	$2,2($7)
	slt	$5,$5,256
	addu	$3,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L707
	move	$6,$3
	.set	macro
	.set	reorder

	li	$9,255			# 0x000000ff
$L707:
	slt	$2,$4,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	slt	$2,$3,256
	.set	macro
	.set	reorder

	li	$8,255			# 0x000000ff
$L710:
	bne	$2,$0,$L709
	li	$6,255			# 0x000000ff
$L709:
	sb	$9,0($7)
	sb	$8,1($7)
	sb	$6,2($7)
$L711:
	j	$31
	.end	Night_AdditiveNightCalc__FP6VECTORP7CVECTOR
