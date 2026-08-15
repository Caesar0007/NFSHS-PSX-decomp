	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentracks.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.data
	.align	2
tvOrder:
	.half	2
	.half	7
	.half	4
	.half	8
	.half	1
	.half	6
	.half	0
	.half	9
	.half	3
	.half	5
	.rdata
	.align	2
$LC0:
	.ascii	"%szzzTR%02d.dct\000"
	.text
	.align	2
	.globl	DrawBackground__18tScreenTrackSelect
	.ent	DrawBackground__18tScreenTrackSelect
DrawBackground__18tScreenTrackSelect:
	.frame	$sp,208,$31		# vars= 152, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$23,196($sp)
	move	$23,$4
	li	$5,-1			# 0xffffffff
	li	$2,320			# 0x00000140
	sh	$2,16($sp)
	li	$2,200			# 0x000000c8
	sh	$2,18($sp)
	li	$2,170			# 0x000000aa
	sh	$2,20($sp)
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$2,12			# 0x0000000c
	sw	$31,204($sp)
	sw	$fp,200($sp)
	sw	$22,192($sp)
	sw	$21,188($sp)
	sw	$20,184($sp)
	sw	$19,180($sp)
	sw	$18,176($sp)
	sw	$17,172($sp)
	sw	$16,168($sp)
	sh	$2,22($sp)
	.set	noreorder
	.set	nomacro
	jal	TextValue__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	lui	$2,%hi(frontEnd+35) # high
	addu	$16,$sp,24
	lbu	$5,%lo(frontEnd+35)($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$23,40
	.set	macro
	.set	reorder

	lw	$2,44($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	addu	$16,$23,608
	.set	macro
	.set	reorder

	lh	$3,20($16)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L601
	lh	$2,112($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

$L601:
	lw	$2,104($23)
	lw	$4,100($23)
	andi	$2,$2,0x0001
	sltu	$2,$2,1
	sll	$16,$2,7
	.set	noreorder
	.set	nomacro
	jal	VIDEO_state__Fi
	move	$22,$16
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L604
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$sp,72
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$10,512			# 0x00000200
	li	$2,170			# 0x000000aa
	sh	$2,76($sp)
	li	$2,256			# 0x00000100
	sh	$10,72($sp)
	sh	$0,74($sp)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$2,78($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	sh	$0,112($23)
	addu	$2,$2,-20
	.set	noreorder
	.set	nomacro
	j	$L605
	sw	$2,120($23)
	.set	macro
	.set	reorder

$L604:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L606
	li	$5,512			# 0x00000200
	.set	macro
	.set	reorder

	lw	$4,100($23)
	sll	$6,$16,16
	.set	noreorder
	.set	nomacro
	jal	VIDEO_updateframexy__Fiii
	srl	$6,$6,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L605
	lw	$3,104($23)
	#nop
	addu	$3,$3,1
	andi	$2,$3,0x0001
	sltu	$2,$2,1
	sll	$22,$2,7
	.set	noreorder
	.set	nomacro
	j	$L605
	sw	$3,104($23)
	.set	macro
	.set	reorder

$L606:
	lw	$2,124($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L617
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lh	$2,114($23)
	lh	$3,112($23)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

$L617:
	lw	$2,%lo(ticks)($2)
	lw	$3,668($23)
	#nop
	subu	$2,$2,$3
	sltu	$2,$2,257
	bne	$2,$0,$L605
	lh	$2,114($23)
	lh	$3,112($23)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$16,$sp,80
	.set	macro
	.set	reorder

	lbu	$2,27($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L614:
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__18tScreenTrackSelects
	move	$4,$23
	.set	macro
	.set	reorder

	addu	$16,$sp,80
$L618:
	move	$4,$16
	lui	$2,%hi(Paths_Paths+164) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+164)($2)
	lh	$7,110($23)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	lw	$4,100($23)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_spoolfile__FiPc
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,100($23)
	jal	VIDEO_startplayback__Fi
$L605:
	lh	$2,112($23)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L616
	li	$10,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$10,$10,0x0004
	li	$16,16711680			# 0x00ff0000
	ori	$16,$16,0xffff
 #APP
 #NO_APP
	li	$4,2			# 0x00000002
	li	$5,1			# 0x00000001
	li	$17,-64			# 0xffffffc0
	andi	$6,$17,0x0200
	sll	$6,$6,16
	sra	$6,$6,16
	move	$21,$0
	move	$7,$21
	sw	$10,160($sp)
	lw	$fp,0($10)
	li	$10,-16777216			# 0xff000000
	li	$20,313			# 0x00000139
	li	$19,232			# 0x000000e8
	ori	$18,$22,0x007f
	lw	$8,528482304
	lw	$3,0($fp)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$16
	or	$3,$3,$2
	sw	$3,0($fp)
	lw	$2,0($8)
	lw	$10,160($sp)
	addu	$3,$fp,40
	sw	$3,0($10)
	li	$10,-16777216			# 0xff000000
	and	$2,$2,$10
	and	$3,$fp,$16
	or	$2,$2,$3
	sw	$2,0($8)
	lh	$8,112($23)
	li	$10,9			# 0x00000009
	li	$2,153			# 0x00000099
	sb	$10,3($fp)
	li	$10,105			# 0x00000069
	sh	$10,10($fp)
	sh	$10,18($fp)
	li	$10,512			# 0x00000200
	sh	$2,8($fp)
	sh	$2,24($fp)
	andi	$2,$10,0x003f
	addu	$3,$2,80
	sh	$20,16($fp)
	sh	$19,26($fp)
	sh	$20,32($fp)
	sh	$19,34($fp)
	sb	$2,12($fp)
	sb	$22,13($fp)
	sb	$3,20($fp)
	sb	$22,21($fp)
	sb	$2,28($fp)
	sb	$18,29($fp)
	sb	$3,36($fp)
	sb	$18,37($fp)
	sll	$2,$8,16
	sll	$3,$8,8
	or	$2,$2,$3
	or	$2,$2,$8
	sw	$2,4($fp)
	li	$10,46			# 0x0000002e
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sb	$10,7($fp)
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	li	$5,1			# 0x00000001
	li	$10,512			# 0x00000200
	addu	$9,$10,80
	and	$17,$9,$17
	sll	$17,$17,16
	sra	$6,$17,16
	move	$7,$21
	andi	$9,$9,0x003f
	sh	$2,22($fp)
	sh	$0,14($fp)
	lw	$10,160($sp)
	lw	$8,528482304
	lw	$fp,0($10)
	li	$10,-16777216			# 0xff000000
	lw	$2,0($8)
	lw	$3,0($fp)
	and	$2,$2,$16
	and	$3,$3,$10
	or	$3,$3,$2
	sw	$3,0($fp)
	lw	$2,0($8)
	and	$16,$fp,$16
	and	$2,$2,$10
	or	$2,$2,$16
	sw	$2,0($8)
	lh	$8,112($23)
	lw	$10,160($sp)
	addu	$2,$fp,40
	sw	$2,0($10)
	li	$10,9			# 0x00000009
	sb	$10,3($fp)
	li	$10,105			# 0x00000069
	li	$2,473			# 0x000001d9
	sh	$2,16($fp)
	sh	$2,32($fp)
	addu	$2,$9,80
	sb	$2,20($fp)
	sb	$2,36($fp)
	sll	$2,$8,16
	sll	$3,$8,8
	or	$2,$2,$3
	or	$2,$2,$8
	sh	$10,10($fp)
	sh	$10,18($fp)
	sw	$2,4($fp)
	li	$10,46			# 0x0000002e
	sh	$20,8($fp)
	sh	$20,24($fp)
	sh	$19,26($fp)
	sh	$19,34($fp)
	sb	$9,12($fp)
	sb	$22,13($fp)
	sb	$22,21($fp)
	sb	$9,28($fp)
	sb	$18,29($fp)
	sb	$18,37($fp)
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sb	$10,7($fp)
	.set	macro
	.set	reorder

	sh	$2,22($fp)
	sh	$0,14($fp)
$L616:
	.set	noreorder
	.set	nomacro
	jal	DrawVideoWall__18tScreenTrackSelect
	move	$4,$23
	.set	macro
	.set	reorder

	lw	$31,204($sp)
	lw	$fp,200($sp)
	lw	$23,196($sp)
	lw	$22,192($sp)
	lw	$21,188($sp)
	lw	$20,184($sp)
	lw	$19,180($sp)
	lw	$18,176($sp)
	lw	$17,172($sp)
	lw	$16,168($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	DrawBackground__18tScreenTrackSelect
	.rdata
	.align	2
$LC1:
	.ascii	"ztrack\000"
	.align	2
$LC2:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	GetShapeInfo__18tScreenTrackSelectRsT1PPcT3
	.ent	GetShapeInfo__18tScreenTrackSelectRsT1PPcT3
GetShapeInfo__18tScreenTrackSelectRsT1PPcT3:
	.frame	$sp,96,$31		# vars= 48, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$21,84($sp)
	move	$21,$4
	sw	$18,72($sp)
	move	$18,$5
	sw	$19,76($sp)
	move	$19,$6
	sw	$20,80($sp)
	move	$20,$7
	lui	$4,%hi(trackManager) # high
	lui	$2,%hi(frontEnd+35) # high
	lbu	$5,%lo(frontEnd+35)($2)
	addiu	$4,$4,%lo(trackManager) # low
	sw	$17,68($sp)
	lw	$17,112($sp)
	addu	$6,$sp,16
	sw	$31,88($sp)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	sw	$16,64($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	addu	$6,$sp,24
	li	$2,68			# 0x00000044
	sh	$2,0($18)
	li	$2,10			# 0x0000000a
	sh	$2,0($19)
	lui	$2,%hi($LC1) # high
	addiu	$2,$2,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,0($20)
	.set	macro
	.set	reorder

	sw	$16,0($17)
	lbu	$2,16($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,108($21)
	lw	$31,88($sp)
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
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	GetShapeInfo__18tScreenTrackSelectRsT1PPcT3
	.align	2
	.globl	Initialize__18tScreenTrackSelect
	.ent	Initialize__18tScreenTrackSelect
Initialize__18tScreenTrackSelect:
	.frame	$sp,184,$31		# vars= 136, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$18,176($sp)
	move	$18,$4
	li	$5,-1			# 0xffffffff
	sw	$16,168($sp)
	lui	$16,%hi(frontEnd) # high
	sw	$17,172($sp)
	lui	$17,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($17)
	addiu	$16,$16,%lo(frontEnd) # low
	sw	$31,180($sp)
	sb	$0,70($16)
	.set	noreorder
	.set	nomacro
	jal	Decrement__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($17)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	lbu	$5,35($16)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	addu	$4,$sp,80
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$2,512			# 0x00000200
	sh	$2,80($sp)
	li	$2,170			# 0x000000aa
	sh	$2,84($sp)
	li	$2,256			# 0x00000100
	sh	$0,82($sp)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$2,86($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$18
	.set	macro
	.set	reorder

	addu	$16,$sp,88
	move	$4,$16
	lui	$2,%hi(Paths_Paths+164) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+164)($2)
	lb	$7,32($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	li	$4,160			# 0x000000a0
	li	$5,128			# 0x00000080
	li	$6,983040			# 0x000f0000
	li	$7,131072			# 0x00020000
	ori	$7,$7,0xc000
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	VIDEO_create__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	VIDEO_spoolfile__FiPc
	sw	$4,100($18)
	.set	macro
	.set	reorder

	lw	$4,100($18)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_startplayback__Fi
	addu	$16,$18,608
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$18,128
	li	$2,10			# 0x0000000a
	sw	$0,104($18)
	sw	$2,16($sp)
	lui	$2,%hi(tvOrder) # high
	addiu	$2,$2,%lo(tvOrder) # low
	sw	$2,20($sp)
	li	$2,150			# 0x00000096
	sw	$2,24($sp)
	lw	$6,40($18)
	.set	noreorder
	.set	nomacro
	jal	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,248			# 0x000000f8
	li	$6,320			# 0x00000140
	.set	noreorder
	.set	nomacro
	jal	SetAvailableText__10tVideoWallsss
	li	$7,80			# 0x00000050
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,38			# 0x00000026
	li	$6,10			# 0x0000000a
	li	$2,60			# 0x0000003c
	sw	$2,16($sp)
	lw	$2,0($18)
	li	$7,310			# 0x00000136
	.set	noreorder
	.set	nomacro
	jal	SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	sh	$0,112($18)
	sh	$0,114($18)
	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	sw	$0,664($18)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	li	$3,1			# 0x00000001
	sw	$3,124($18)
	addu	$2,$2,-256
	sw	$2,668($18)
	lbu	$2,32($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,110($18)
	lw	$31,180($sp)
	lw	$18,176($sp)
	lw	$17,172($sp)
	lw	$16,168($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	Initialize__18tScreenTrackSelect
	.align	2
	.globl	Cleanup__18tScreenTrackSelect
	.ent	Cleanup__18tScreenTrackSelect
Cleanup__18tScreenTrackSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,100($16)
	jal	VIDEO_destroy__Fi
	lw	$4,100($16)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cleanup__18tScreenTrackSelect
	.align	2
	.globl	SetBrightness__18tScreenTrackSelects
	.ent	SetBrightness__18tScreenTrackSelects
SetBrightness__18tScreenTrackSelects:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$2,$5,16
	lh	$3,114($4)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L624
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lhu	$3,112($4)
	lw	$2,%lo(ticks)($2)
	sh	$5,114($4)
	sh	$3,116($4)
	sw	$2,120($4)
$L624:
	j	$31
	.end	SetBrightness__18tScreenTrackSelects
	.align	2
	.globl	UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
	.ent	UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
UpdateBrightness__18tScreenTrackSelectR17tTrackInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	lw	$2,120($16)
	lh	$5,114($16)
	subu	$3,$3,$2
	lh	$2,112($16)
	lhu	$4,114($16)
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L626
	slt	$2,$3,128
	.set	macro
	.set	reorder

	bne	$2,$0,$L627
	.set	noreorder
	.set	nomacro
	j	$L626
	sh	$4,112($16)
	.set	macro
	.set	reorder

$L627:
	bltz	$3,$L629
	lh	$2,116($16)
	#nop
	subu	$2,$5,$2
	mult	$2,$3
	lhu	$3,116($16)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L630
	addu	$2,$2,127
$L630:
	sra	$2,$2,7
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L626
	sh	$2,112($16)
	.set	macro
	.set	reorder

$L629:
	sh	$0,112($16)
$L626:
	lw	$2,112($16)
	#nop
	bne	$2,$0,$L625
	lw	$4,100($16)
	jal	VIDEO_abortplayback__Fi
	lw	$2,124($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L625
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,124($16)
	sw	$3,668($16)
	lbu	$2,0($17)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,110($16)
$L625:
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

	.end	UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
	.align	2
	.globl	UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
	.ent	UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	lb	$3,0($17)
	lh	$2,108($16)
	#nop
	beq	$3,$2,$L634
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	addu	$5,$17,8
	.set	macro
	.set	reorder

	sw	$0,664($16)
	lbu	$2,0($17)
	addu	$4,$16,608
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	sh	$2,108($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__18tScreenTrackSelects
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$0,124($16)
$L634:
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

	.end	UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
	.align	2
	.globl	DrawVideoWall__18tScreenTrackSelect
	.ent	DrawVideoWall__18tScreenTrackSelect
DrawVideoWall__18tScreenTrackSelect:
	.frame	$sp,88,$31		# vars= 48, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$17,76($sp)
	move	$17,$4
	lui	$4,%hi(trackManager) # high
	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	sw	$31,84($sp)
	sw	$18,80($sp)
	sw	$16,72($sp)
	lbu	$2,70($3)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$3
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	li	$5,478			# 0x000001de
	li	$6,33			# 0x00000021
	li	$7,1			# 0x00000001
	lbu	$4,66($sp)
	li	$2,11			# 0x0000000b
	sw	$0,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	addu	$4,$4,67
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$0
	li	$2,150			# 0x00000096
	sw	$2,16($sp)
	lw	$7,0($17)
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	li	$6,28			# 0x0000001c
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,320			# 0x00000140
	li	$6,30			# 0x0000001e
	li	$7,160			# 0x000000a0
	li	$2,10			# 0x0000000a
	li	$18,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lhu	$2,58($17)
	#nop
	and	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	addu	$16,$17,608
	.set	macro
	.set	reorder

	lw	$2,664($17)
	#nop
	bne	$2,$0,$L638
	lbu	$5,27($sp)
	.set	noreorder
	.set	nomacro
	jal	SetAvailable__10tVideoWalls
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$18,664($17)
	addu	$16,$17,608
$L638:
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	DrawVideoWall__18tScreenTrackSelect
	.align	2
	.globl	ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,72,$31		# vars= 48, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,64($sp)
	sw	$31,68($sp)
	lw	$6,0($6)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L640
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	lui	$2,%hi(frontEnd) # high
	addiu	$16,$2,%lo(frontEnd) # low
	lbu	$2,70($16)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$16
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$3,3916($4)
	li	$2,-2			# 0xfffffffe
	and	$5,$3,$2
	sw	$5,3916($4)
	lbu	$3,3($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L641
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,798($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L641
	ori	$2,$5,0x0001
	.set	macro
	.set	reorder

	sw	$2,3916($4)
$L641:
	lbu	$2,18($sp)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3916($3)
$L642:
	lbu	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3916($3)
$L643:
	lui	$2,%hi(frontEnd) # high
	addiu	$5,$2,%lo(frontEnd) # low
	lbu	$2,3($5)
	li	$4,1			# 0x00000001
	bne	$2,$4,$L644
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L651
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	or	$2,$2,$4
	sw	$2,3916($3)
$L644:
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L651
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	jal	Front_EnableLocalSpeech__Fv
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,3952($4)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L639
	sw	$2,3952($4)
	.set	macro
	.set	reorder

$L646:
$L651:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3952($3)
	#nop
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L639
	sw	$2,3952($3)
	.set	macro
	.set	reorder

$L640:
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L639
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($2)
	#nop
	lw	$3,4($2)
	#nop
	lw	$2,104($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	beq	$2,$0,$L639
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$16,608
	.set	macro
	.set	reorder

$L639:
	lw	$31,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___18tScreenTrackSelect
	.ent	___18tScreenTrackSelect
___18tScreenTrackSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___18tScreenTrackSelect

	.lcomm	gSwapFileName,20
	.globl	screenTrackSelect
	.data
	.align	2
screenTrackSelect:
	.space	4
