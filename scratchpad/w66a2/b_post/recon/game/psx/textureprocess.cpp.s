	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\textureprocess.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	TextureProcess_TransColorCheck__FPci
	.align	2
	.globl	TextureProcess_ColorClut__FiiPciii
	.align	2
	.globl	TextureProcess_DepthColorCluts__FPci
	.align	2
	.globl	Fog_CheckRange__FiP6FogKey
	.align	2
	.globl	Fog_FindKey__FiP6FogKey
	.align	2
	.globl	Fog_AllocKey__Fv
	.align	2
	.globl	Fog_AddKey__Fii
	.align	2
	.globl	Fog_Update__Fi
	.rdata
	.align	2
$LC0:
	.ascii	"%sTr%02d%s\000"
	.text
	.align	2
	.globl	Fog_MakeTrackPathName__FPc
	.rdata
	.align	2
$LC1:
	.ascii	"N.fog\000"
	.align	2
$LC2:
	.ascii	"W.fog\000"
	.align	2
$LC3:
	.ascii	"S.fog\000"
	.align	2
$LC4:
	.ascii	".fog\000"
	.text
	.align	2
	.globl	Fog_ReadFogKeys__Fv
	.rdata
	.align	2
$LC5:
	.ascii	"fog pos\000"
	.text
	.align	2
	.globl	Fog_InitFogTriggers__Fv
	.align	2
	.globl	Fog_DeInitFogTriggers__Fv
	.align	2
	.globl	TextureProcess_Init__Fv
	.align	2
	.globl	CV_ProcessWorldColors_FINAL__FiP7CVECTORs
	.align	2
	.globl	CV_ColorTracks__Fiii
	.align	2
	.globl	CV_InitColorVertices__Fv
	.globl	gZDepth
	.sdata
	.align	2
gZDepth:
	.space	4
	.globl	TP_gZPaletteSystem
	.align	2
TP_gZPaletteSystem:
	.space	4
	.globl	Fog_gNumKeys
	.align	2
Fog_gNumKeys:
	.space	4
	.globl	Fog_gCurrentKey
	.align	2
Fog_gCurrentKey:
	.space	4
	.globl	D_8013DB84
	.align	2
D_8013DB84:
	.space	4
	.globl	Fog_gHeadKey
	.align	2
Fog_gHeadKey:
	.space	4
	.globl	fogslicePos
	.align	2
fogslicePos:
	.space	4

	.lcomm	fogstrspc,256

	.extern	Chunk_lightTable, 4
	.extern	Chunk_numLight, 4
	.extern	GameSetup_gData, 2600
	.extern	Paths_Paths, 200
	.extern	gNumSlices, 4
	.extern	gCView, 140
	.extern	openkeys, 128
	.extern	Fog_gBuf, 384
	.extern	gClutDepth, 8192
	.extern	TrackSpec_gSpec, 264

	.text
	.text
	.ent	TextureProcess_TransColorCheck__FPci
TextureProcess_TransColorCheck__FPci:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	li	$7,-1			# 0xffffffff
	li	$6,32768			# 0x00008000
$L603:
	addu	$5,$5,-1
	beq	$5,$7,$L602
	lhu	$2,0($4)
	addu	$4,$4,2
	sltu	$2,$6,$2
	.set	noreorder
	.set	nomacro
	j	$L603
	or	$3,$3,$2
	.set	macro
	.set	reorder

$L602:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	TextureProcess_TransColorCheck__FPci
	.text
	.ent	TextureProcess_ColorClut__FiiPciii
TextureProcess_ColorClut__FiiPciii:
	.frame	$sp,576,$31		# vars= 520, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,576
	lui	$3,%hi(TrackSpec_gSpec) # high
	addiu	$3,$3,%lo(TrackSpec_gSpec) # low
	sw	$31,572($sp)
	sw	$fp,568($sp)
	sw	$23,564($sp)
	sw	$22,560($sp)
	sw	$21,556($sp)
	sw	$20,552($sp)
	sw	$19,548($sp)
	sw	$18,544($sp)
	sw	$17,540($sp)
	sw	$16,536($sp)
	sw	$7,588($sp)
	lw	$2,16($3)
	#nop
	mult	$2,$4
	move	$23,$6
	move	$22,$0
	move	$fp,$3
	mflo	$9
	#nop
	addu	$20,$sp,16
	addu	$5,$5,-1
	div	$21,$9,$5
$L609:
	lw	$8,588($sp)
	#nop
	slt	$2,$22,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	addu	$4,$sp,528
	.set	macro
	.set	reorder

	lhu	$19,0($23)
	#nop
	andi	$3,$19,0xffff
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L611
	srl	$2,$3,7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	sh	$0,0($20)
	.set	macro
	.set	reorder

$L611:
	andi	$16,$2,0x00f8
	srl	$2,$3,2
	andi	$18,$2,0x00f8
	andi	$2,$19,0x001f
	sll	$17,$2,3
	lbu	$4,20($fp)
	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$17,$4
	.set	macro
	.set	reorder

	subu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L614
	move	$17,$0
	.set	macro
	.set	reorder

	move	$17,$2
	slt	$2,$17,256
	bne	$2,$0,$L614
	li	$17,255			# 0x000000ff
$L614:
	lbu	$4,21($fp)
	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$18,$4
	.set	macro
	.set	reorder

	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L617
	move	$18,$0
	.set	macro
	.set	reorder

	move	$18,$2
	slt	$2,$18,256
	bne	$2,$0,$L617
	li	$18,255			# 0x000000ff
$L617:
	lbu	$4,22($fp)
	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$16,$4
	.set	macro
	.set	reorder

	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L620
	move	$16,$0
	.set	macro
	.set	reorder

	move	$16,$2
	slt	$2,$16,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L624
	slt	$2,$16,8
	.set	macro
	.set	reorder

	li	$16,255			# 0x000000ff
$L620:
	slt	$2,$16,8
$L624:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L625
	sra	$2,$16,3
	.set	macro
	.set	reorder

	li	$16,8			# 0x00000008
	sra	$2,$16,3
$L625:
	andi	$16,$2,0x001f
	sra	$2,$18,3
	andi	$18,$2,0x001f
	sra	$2,$17,3
	andi	$17,$2,0x001f
	andi	$2,$19,0x8000
	sll	$3,$16,10
	or	$2,$2,$3
	sll	$3,$18,5
	or	$2,$2,$3
	or	$2,$2,$17
	sh	$2,0($20)
$L612:
	addu	$23,$23,2
	addu	$20,$20,2
	.set	noreorder
	.set	nomacro
	j	$L609
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L608:
	lw	$2,592($sp)
	lhu	$8,588($sp)
	addu	$5,$sp,16
	sh	$2,528($sp)
	lw	$2,596($sp)
	sh	$8,532($sp)
	sh	$2,530($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	sh	$2,534($sp)
	.set	macro
	.set	reorder

	lw	$31,572($sp)
	lw	$fp,568($sp)
	lw	$23,564($sp)
	lw	$22,560($sp)
	lw	$21,556($sp)
	lw	$20,552($sp)
	lw	$19,548($sp)
	lw	$18,544($sp)
	lw	$17,540($sp)
	lw	$16,536($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,576
	.set	macro
	.set	reorder

	.end	TextureProcess_ColorClut__FiiPciii
	.text
	.ent	TextureProcess_DepthColorCluts__FPci
TextureProcess_DepthColorCluts__FPci:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,44($sp)
	move	$19,$4
	sw	$17,36($sp)
	move	$17,$5
	move	$4,$0
	sw	$31,48($sp)
	sw	$18,40($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$16,$0
	lui	$2,%hi(gClutDepth) # high
	addiu	$18,$2,%lo(gClutDepth) # low
	slt	$2,$16,16
$L632:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	slt	$4,$17,17
	.set	macro
	.set	reorder

	xori	$4,$4,0x0001
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	Texture_GetClutId__FiPiT1
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,16			# 0x00000010
	move	$6,$19
	sll	$7,$16,1
	addu	$16,$16,1
	lw	$2,TP_gZPaletteSystem
	lhu	$3,28($sp)
	lw	$8,24($sp)
	sll	$2,$2,5
	addu	$7,$7,$2
	addu	$7,$7,$18
	sll	$3,$3,6
	sra	$2,$8,4
	andi	$2,$2,0x003f
	or	$3,$3,$2
	sh	$3,0($7)
	sw	$8,16($sp)
	lw	$2,28($sp)
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	TextureProcess_ColorClut__FiiPciii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L632
	slt	$2,$16,16
	.set	macro
	.set	reorder

$L628:
	lw	$3,TP_gZPaletteSystem
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	move	$2,$3
	addu	$3,$3,1
	sw	$3,TP_gZPaletteSystem
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	TextureProcess_DepthColorCluts__FPci
	.text
	.ent	Fog_CheckRange__FiP6FogKey
Fog_CheckRange__FiP6FogKey:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($5)
	lh	$6,2($5)
	lh	$7,2($2)
	#nop
	slt	$2,$7,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	slt	$2,$4,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	slt	$2,$4,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	move	$2,$0
	.set	macro
	.set	reorder

$L636:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

$L634:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$3,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L642
	move	$2,$5
	.set	macro
	.set	reorder

	move	$2,$0
$L642:
	j	$31
	.end	Fog_CheckRange__FiP6FogKey
	.text
	.ent	Fog_FindKey__FiP6FogKey
Fog_FindKey__FiP6FogKey:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L644
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	lw	$16,Fog_gHeadKey
$L644:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Fog_CheckRange__FiP6FogKey
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	move	$2,$16
	.set	macro
	.set	reorder

	lh	$2,2($16)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L652
$L647:
	lw	$16,8($16)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Fog_CheckRange__FiP6FogKey
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L647
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L656
$L652:
	lw	$16,4($16)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Fog_CheckRange__FiP6FogKey
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	move	$2,$16
	.set	macro
	.set	reorder

$L656:
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

	.end	Fog_FindKey__FiP6FogKey
	.text
	.ent	Fog_AllocKey__Fv
Fog_AllocKey__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	li	$6,1			# 0x00000001
	lui	$2,%hi(Fog_gBuf) # high
	addiu	$4,$2,%lo(Fog_gBuf) # low
	lui	$2,%hi(openkeys) # high
	addiu	$3,$2,%lo(openkeys) # low
$L658:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$6,$L661
	addu	$5,$5,1
	.set	macro
	.set	reorder

	sw	$0,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L661:
	addu	$4,$4,12
	slt	$2,$5,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Fog_AllocKey__Fv
	.text
	.ent	Fog_AddKey__Fii
Fog_AddKey__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Fog_AllocKey__Fv
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$3,Fog_gHeadKey
	move	$17,$2
	sw	$0,8($17)
	sw	$0,4($17)
	sh	$18,2($17)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L666
	sh	$16,0($17)
	.set	macro
	.set	reorder

	sw	$17,Fog_gHeadKey
	sw	$17,4($17)
	.set	noreorder
	.set	nomacro
	j	$L667
	sw	$17,8($17)
	.set	macro
	.set	reorder

$L666:
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L668
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Fog_FindKey__FiP6FogKey
	move	$5,$0
	.set	macro
	.set	reorder

	move	$3,$2
$L668:
	lh	$2,2($3)
	#nop
	beq	$2,$18,$L665
	lw	$2,4($3)
	sw	$17,4($3)
	sw	$3,8($17)
	sw	$2,4($17)
	sw	$17,8($2)
$L667:
	lw	$2,Fog_gNumKeys
	#nop
	addu	$2,$2,1
	sw	$2,Fog_gNumKeys
$L665:
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

	.end	Fog_AddKey__Fii
	.text
	.ent	Fog_Update__Fi
Fog_Update__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	lw	$3,Fog_gNumKeys
	li	$2,1			# 0x00000001
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L671
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(gCView+8) # high
	addiu	$4,$4,%lo(gCView+8) # low
	sll	$16,$18,5
	addu	$16,$16,$18
	sll	$16,$16,2
	lw	$5,fogslicePos
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	lw	$2,fogslicePos
	#nop
	addu	$16,$16,$2
	lh	$17,0($16)
	sll	$16,$18,2
	lui	$2,%hi(Fog_gCurrentKey) # high
	addiu	$2,$2,%lo(Fog_gCurrentKey) # low
	addu	$16,$16,$2
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	Fog_FindKey__FiP6FogKey
	move	$4,$17
	.set	macro
	.set	reorder

	move	$6,$2
	sw	$6,0($16)
	lw	$2,4($6)
	lh	$5,0($6)
	lh	$3,0($2)
	lh	$7,2($2)
	.set	noreorder
	.set	nomacro
	beq	$5,$3,$L676
	lui	$2,%hi(TrackSpec_gSpec+24) # high
	.set	macro
	.set	reorder

	lh	$4,2($6)
	#nop
	slt	$2,$7,$4
	beq	$2,$0,$L673
	lw	$3,gNumSlices
	.set	noreorder
	.set	nomacro
	bltz	$17,$L673
	addu	$7,$7,$3
	.set	macro
	.set	reorder

	slt	$2,$17,$4
	beq	$2,$0,$L673
	addu	$17,$17,$3
$L673:
	lw	$2,4($6)
	lh	$5,0($6)
	lh	$4,0($2)
	lh	$2,2($6)
	subu	$4,$4,$5
	subu	$3,$17,$2
	mult	$3,$4
	mflo	$3
	#nop
	subu	$2,$7,$2
	div	$2,$3,$2
	addu	$5,$5,$2
	lui	$2,%hi(TrackSpec_gSpec+24) # high
$L676:
	sw	$5,%lo(TrackSpec_gSpec+24)($2)
$L671:
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

	.end	Fog_Update__Fi
	.text
	.ent	Fog_MakeTrackPathName__FPc
Fog_MakeTrackPathName__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	lui	$16,%hi(fogstrspc) # high
	addiu	$16,$16,%lo(fogstrspc) # low
	lui	$5,%hi($LC0) # high
	lui	$3,%hi(Paths_Paths+24) # high
	lui	$2,%hi(GameSetup_gData+60) # high
	sw	$4,16($sp)
	move	$4,$16
	lw	$7,%lo(GameSetup_gData+60)($2)
	lw	$6,%lo(Paths_Paths+24)($3)
	addiu	$5,$5,%lo($LC0) # low
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	andi	$7,$7,0x000f
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

	.end	Fog_MakeTrackPathName__FPc
	.text
	.ent	Fog_ReadFogKeys__Fv
Fog_ReadFogKeys__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,84($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L696
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	lui	$4,%hi($LC1) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L693
	addiu	$4,$4,%lo($LC1) # low
	.set	macro
	.set	reorder

$L679:
	lui	$2,%hi(GameSetup_gData) # high
$L696:
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,84($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L693
	addiu	$4,$4,%lo($LC2) # low
	.set	macro
	.set	reorder

$L682:
	lw	$2,72($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L683
	lui	$4,%hi($LC3) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L693
	addiu	$4,$4,%lo($LC3) # low
	.set	macro
	.set	reorder

$L683:
	lui	$4,%hi($LC4) # high
	addiu	$4,$4,%lo($LC4) # low
$L693:
	jal	Fog_MakeTrackPathName__FPc
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L692
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$19,0($18)
	#nop
	sltu	$2,$19,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L685
	move	$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L692
	move	$2,$0
	.set	macro
	.set	reorder

$L685:
	move	$16,$18
	slt	$2,$17,$19
$L695:
	beq	$2,$0,$L687
	lw	$4,4($16)
	lw	$5,8($16)
	addu	$16,$16,8
	.set	noreorder
	.set	nomacro
	jal	Fog_AddKey__Fii
	addu	$17,$17,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L695
	slt	$2,$17,$19
	.set	macro
	.set	reorder

$L687:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L692:
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

	.end	Fog_ReadFogKeys__Fv
	.text
	.ent	Fog_InitFogTriggers__Fv
Fog_InitFogTriggers__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$4,1			# 0x00000001
	li	$3,31			# 0x0000001f
	lui	$2,%hi(openkeys) # high
	addiu	$2,$2,%lo(openkeys) # low
	addu	$2,$2,124
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$0,Fog_gNumKeys
	sw	$0,Fog_gHeadKey
$L698:
	sw	$4,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L698
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	jal	Fog_ReadFogKeys__Fv
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(TrackSpec_gSpec+24) # high
	lw	$5,%lo(TrackSpec_gSpec+24)($2)
	.set	noreorder
	.set	nomacro
	jal	Fog_AddKey__Fii
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+12) # high
$L710:
	lw	$3,Fog_gHeadKey
	lw	$2,%lo(GameSetup_gData+12)($2)
	li	$18,1			# 0x00000001
	sw	$3,Fog_gCurrentKey
	sw	$3,D_8013DB84
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L711
	lui	$4,%hi($LC5) # high
	.set	macro
	.set	reorder

	li	$18,2			# 0x00000002
$L711:
	addiu	$4,$4,%lo($LC5) # low
	sll	$5,$18,5
	addu	$5,$5,$18
	sll	$5,$5,2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,fogslicePos
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L704
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$16
$L705:
 #APP
 #NO_APP
	move	$4,$0
	lw	$5,fogslicePos
	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	addu	$5,$5,$17
	.set	macro
	.set	reorder

	slt	$2,$16,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L705
	addu	$17,$17,132
	.set	macro
	.set	reorder

$L704:
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

	.end	Fog_InitFogTriggers__Fv
	.text
	.ent	Fog_DeInitFogTriggers__Fv
Fog_DeInitFogTriggers__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,fogslicePos
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Fog_DeInitFogTriggers__Fv
	.text
	.ent	TextureProcess_Init__Fv
TextureProcess_Init__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,16			# 0x00000010
	sw	$2,gZDepth
	sw	$0,TP_gZPaletteSystem
	j	$31
	.end	TextureProcess_Init__Fv
	.text
	.ent	CV_ProcessWorldColors_FINAL__FiP7CVECTORs
CV_ProcessWorldColors_FINAL__FiP7CVECTORs:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$22,40($sp)
	move	$22,$4
	sw	$23,44($sp)
	move	$23,$5
	sw	$21,36($sp)
	move	$21,$0
	sll	$6,$6,16
	sw	$20,32($sp)
	sra	$20,$6,16
	sw	$19,28($sp)
	move	$19,$21
	sw	$31,48($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L719:
	lw	$2,Chunk_numLight
	#nop
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	move	$5,$22
	.set	macro
	.set	reorder

	lw	$2,Chunk_lightTable
	lbu	$4,0($23)
	addu	$2,$19,$2
	lbu	$16,0($2)
	lbu	$17,1($2)
	lbu	$18,2($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$16,$4
	.set	macro
	.set	reorder

	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L722
	move	$16,$0
	.set	macro
	.set	reorder

	move	$16,$2
	slt	$2,$16,256
	bne	$2,$0,$L722
	li	$16,255			# 0x000000ff
$L722:
	lbu	$4,1($23)
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$17,$4
	.set	macro
	.set	reorder

	subu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L725
	move	$17,$0
	.set	macro
	.set	reorder

	move	$17,$2
	slt	$2,$17,256
	bne	$2,$0,$L725
	li	$17,255			# 0x000000ff
$L725:
	lbu	$4,2($23)
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$18,$4
	.set	macro
	.set	reorder

	subu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L728
	move	$18,$0
	.set	macro
	.set	reorder

	move	$18,$2
	slt	$2,$18,256
	bne	$2,$0,$L728
	li	$18,255			# 0x000000ff
$L728:
	addu	$16,$16,$20
	addu	$17,$17,$20
	slt	$2,$16,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L730
	addu	$18,$18,$20
	.set	macro
	.set	reorder

	li	$16,255			# 0x000000ff
$L730:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L738
	slt	$2,$17,256
	.set	macro
	.set	reorder

	move	$16,$0
$L738:
	bne	$2,$0,$L732
	li	$17,255			# 0x000000ff
$L732:
	.set	noreorder
	.set	nomacro
	bgez	$17,$L739
	slt	$2,$18,256
	.set	macro
	.set	reorder

	move	$17,$0
$L739:
	bne	$2,$0,$L734
	li	$18,255			# 0x000000ff
$L734:
	bgez	$18,$L735
	move	$18,$0
$L735:
	lw	$2,Chunk_lightTable
	#nop
	addu	$2,$19,$2
	sb	$16,0($2)
	lw	$2,Chunk_lightTable
	#nop
	addu	$2,$19,$2
	sb	$17,1($2)
	lw	$2,Chunk_lightTable
	addu	$21,$21,1
	addu	$2,$19,$2
	addu	$19,$19,4
	.set	noreorder
	.set	nomacro
	j	$L719
	sb	$18,2($2)
	.set	macro
	.set	reorder

$L737:
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

	.end	CV_ProcessWorldColors_FINAL__FiP7CVECTORs
	.text
	.ent	CV_ColorTracks__Fiii
CV_ColorTracks__Fiii:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$16,24($sp)
	move	$16,$0
	addu	$4,$sp,16
	move	$5,$16
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$2,%lo(GameSetup_gData+12)($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L745
	move	$6,$16
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L746
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	bne	$17,$3,$L762
	bne	$19,$3,$L762
	li	$16,-65536			# 0xffff0000
	ori	$16,$16,0x6380
	.set	noreorder
	.set	nomacro
	j	$L747
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

$L746:
$L762:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L763
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L764
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L748
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$16,-65536			# 0xffff0000
	.set	noreorder
	.set	nomacro
	j	$L749
	ori	$16,$16,0x0c00
	.set	macro
	.set	reorder

$L748:
$L764:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L763
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L763
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	bne	$19,$17,$L763
	li	$16,-29696			# 0xffff8c00
	li	$2,16			# 0x00000010
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L749
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

$L763:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L765
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L766
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L751
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L749
	li	$16,-30720			# 0xffff8800
	.set	macro
	.set	reorder

$L751:
$L766:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L765
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L765
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	bne	$19,$17,$L765
	li	$16,-65536			# 0xffff0000
	li	$2,24			# 0x00000018
$L747:
	sb	$2,17($sp)
	.set	noreorder
	.set	nomacro
	j	$L749
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

$L765:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L767
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	bne	$17,$0,$L767
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L753
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	li	$16,-65536			# 0xffff0000
	ori	$16,$16,0x69f0
	.set	noreorder
	.set	nomacro
	j	$L749
	li	$6,49			# 0x00000031
	.set	macro
	.set	reorder

$L753:
$L767:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L768
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	bne	$17,$0,$L768
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L754
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	li	$16,-65536			# 0xffff0000
	ori	$16,$16,0x4c00
	.set	noreorder
	.set	nomacro
	j	$L749
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

$L754:
$L768:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L769
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	bne	$17,$0,$L769
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$19,$2,$L758
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

$L769:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L770
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	bne	$17,$2,$L770
	.set	noreorder
	.set	nomacro
	bne	$19,$17,$L770
	li	$16,-21504			# 0xffffac00
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L770
	move	$4,$16
	.set	macro
	.set	reorder

$L745:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L770
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$17,$0,$L770
	bne	$19,$3,$L770
$L758:
	li	$16,26624			# 0x00006800
	li	$6,22			# 0x00000016
$L749:
	move	$4,$16
$L770:
	.set	noreorder
	.set	nomacro
	jal	CV_ProcessWorldColors_FINAL__FiP7CVECTORs
	addu	$5,$sp,16
	.set	macro
	.set	reorder

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

	.end	CV_ColorTracks__Fiii
	.text
	.ent	CV_InitColorVertices__Fv
CV_InitColorVertices__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sw	$31,16($sp)
	lw	$4,60($2)
	lw	$5,72($2)
	lw	$6,84($2)
	.set	noreorder
	.set	nomacro
	jal	CV_ColorTracks__Fiii
	andi	$4,$4,0x000f
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

	.end	CV_InitColorVertices__Fv
