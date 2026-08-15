	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screenpinkslips.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	screenPinkSlips
	.data
	.align	2
screenPinkSlips:
	.word	0
	.align	2
imageTVOrder:
	.byte	1
	.byte	2
	.byte	0
	.byte	3
	.align	2
flareextra_248:
	.word	0
	.rdata
	.align	2
$LC0:
	.ascii	"%szzzTR%02d.dct\000"
	.text
	.align	2
	.globl	DrawBackground__16tScreenPinkSlips
	.ent	DrawBackground__16tScreenPinkSlips
DrawBackground__16tScreenPinkSlips:
	.frame	$sp,232,$31		# vars= 160, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,232
	sw	$fp,224($sp)
	move	$fp,$4
	sw	$18,200($sp)
	move	$18,$0
	lui	$2,%hi(frontEnd) # high
	sw	$20,208($sp)
	addiu	$20,$2,%lo(frontEnd) # low
	sw	$19,204($sp)
	lui	$19,%hi(flareextra_248) # high
	li	$2,347			# 0x0000015b
	sh	$2,32($sp)
	li	$2,143			# 0x0000008f
	sh	$2,34($sp)
	li	$2,144			# 0x00000090
	sh	$2,36($sp)
	li	$2,14			# 0x0000000e
	sw	$31,228($sp)
	sw	$23,220($sp)
	sw	$22,216($sp)
	sw	$21,212($sp)
	sw	$17,196($sp)
	sw	$16,192($sp)
	sh	$2,38($sp)
$L601:
	sll	$3,$18,16
	lbu	$2,71($20)
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,100($fp)
	#nop
	lh	$4,8($2)
	#nop
	addu	$2,$4,-1
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L605
	move	$5,$0
	.set	macro
	.set	reorder

	bne	$3,$0,$L604
	bne	$4,$0,$L604
$L605:
	li	$5,1			# 0x00000001
$L604:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L644
	lui	$4,%hi(trackManager) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(flareextra_248)($19)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(flareextra_248)($19)
	slt	$2,$2,61
	bne	$2,$0,$L607
	sw	$0,%lo(flareextra_248)($19)
$L607:
	lw	$3,%lo(flareextra_248)($19)
	#nop
	slt	$2,$3,31
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	srl	$2,$3,31
	.set	macro
	.set	reorder

	li	$2,60			# 0x0000003c
	subu	$2,$2,$3
	srl	$3,$2,31
$L608:
	addu	$2,$3,$2
	sra	$4,$2,1
	addu	$4,$4,20
	lh	$3,92($fp)
	li	$2,128			# 0x00000080
	subu	$2,$2,$3
	mult	$4,$2
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	blez	$4,$L610
	li	$2,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	ori	$2,$2,0x5556
	sll	$7,$4,1
	mult	$7,$2
	srl	$6,$4,31
	addu	$6,$4,$6
	sra	$6,$6,1
	li	$2,23			# 0x00000017
	lh	$16,32($sp)
	lh	$17,34($sp)
	sra	$7,$7,31
	sw	$2,16($sp)
	addu	$4,$16,-15
	addu	$5,$17,6
	mfhi	$10
	#nop
	.set	noreorder
	.set	nomacro
	jal	Flare_2DHalo__Fiiiii
	subu	$7,$10,$7
	.set	macro
	.set	reorder

	li	$4,56			# 0x00000038
	move	$5,$0
	addu	$6,$16,-18
	move	$7,$17
	lh	$3,92($fp)
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L610:
	li	$16,2			# 0x00000002
	lui	$4,%hi(trackManager) # high
$L644:
	addiu	$4,$4,%lo(trackManager) # low
	sll	$2,$18,16
	sra	$2,$2,16
	addu	$2,$2,$20
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,40
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	sb	$18,70($20)
	.set	noreorder
	.set	nomacro
	jal	TextValue__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	move	$7,$0
	lhu	$5,32($sp)
	lhu	$6,34($sp)
	li	$2,1			# 0x00000001
	sw	$16,16($sp)
	sw	$2,20($sp)
	addu	$5,$5,10
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,3
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
	addu	$5,$sp,32
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lhu	$2,34($sp)
	addu	$18,$18,1
	addu	$2,$2,14
	.set	noreorder
	.set	nomacro
	j	$L601
	sh	$2,34($sp)
	.set	macro
	.set	reorder

$L602:
	lw	$2,100($fp)
	lui	$3,%hi(frontEnd) # high
	lhu	$2,8($2)
	addiu	$3,$3,%lo(frontEnd) # low
	move	$4,$2
	sb	$2,70($3)
	andi	$2,$4,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	addu	$2,$4,-1
	.set	macro
	.set	reorder

	sb	$2,70($3)
$L611:
	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	lbu	$2,70($3)
	addu	$16,$sp,40
	addu	$2,$2,$3
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$fp,40
	.set	macro
	.set	reorder

	lw	$2,44($fp)
	#nop
	beq	$2,$0,$L612
	lb	$2,128($fp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L612
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,128($fp)
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,124($fp)
$L612:
	.set	noreorder
	.set	nomacro
	jal	DrawVideoWall__16tScreenPinkSlips
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$2,108($fp)
	lw	$4,104($fp)
	andi	$2,$2,0x0001
	sltu	$2,$2,1
	sll	$16,$2,7
	.set	noreorder
	.set	nomacro
	jal	VIDEO_state__Fi
	sh	$16,168($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$5,512			# 0x00000200
	.set	macro
	.set	reorder

	lw	$4,104($fp)
	sll	$6,$16,16
	.set	noreorder
	.set	nomacro
	jal	VIDEO_updateframexy__Fiii
	srl	$6,$6,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$3,108($fp)
	#nop
	addu	$3,$3,1
	andi	$2,$3,0x0001
	sltu	$2,$2,1
	sll	$2,$2,7
	sh	$2,168($sp)
	sw	$3,108($fp)
$L645:
	move	$18,$19
	li	$9,64			# 0x00000040
	lbu	$10,168($sp)
	li	$8,1			# 0x00000001
	sb	$10,176($sp)
	move	$17,$0
$L646:
	sll	$2,$18,16
	sra	$21,$2,16
	lbu	$10,176($sp)
	sll	$20,$21,6
	addu	$23,$20,$10
	li	$10,64			# 0x00000040
	addu	$22,$10,-1
$L622:
	sll	$3,$19,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$16,$fp,$2
	sll	$2,$17,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$2,$2,160
	sh	$2,152($16)
	addu	$2,$20,25
	sh	$2,154($16)
	li	$2,80			# 0x00000050
	sll	$3,$3,3
	sh	$2,156($16)
	li	$2,40			# 0x00000028
	sh	$9,158($16)
	sb	$3,160($16)
	sb	$23,161($16)
	sb	$2,162($16)
	.set	noreorder
	.set	nomacro
	bne	$21,$8,$L625
	sb	$9,163($16)
	.set	macro
	.set	reorder

	sb	$22,163($16)
$L625:
	li	$4,2			# 0x00000002
	move	$5,$0
	li	$10,512			# 0x00000200
	sll	$6,$10,16
	lhu	$10,168($sp)
	sra	$6,$6,16
	sw	$8,184($sp)
	sw	$9,188($sp)
	sll	$7,$10,16
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sra	$7,$7,16
	.set	macro
	.set	reorder

	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	addu	$3,$17,1
	move	$17,$3
	sh	$2,168($16)
	li	$2,32			# 0x00000020
	sll	$3,$3,16
	sra	$3,$3,16
	sh	$0,166($16)
	lw	$8,184($sp)
	slt	$3,$3,4
	sh	$2,140($16)
	sw	$4,148($16)
	sw	$8,132($16)
	lw	$9,188($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L622
	addu	$19,$19,1
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L646
	move	$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	li	$18,240			# 0x000000f0
	.set	macro
	.set	reorder

$L615:
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,124($fp)
	#nop
	subu	$2,$2,$3
	sltu	$2,$2,257
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	li	$18,240			# 0x000000f0
	.set	macro
	.set	reorder

	addu	$16,$sp,88
	move	$4,$16
	lui	$2,%hi(Paths_Paths+164) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+164)($2)
	lb	$7,40($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	lw	$4,104($fp)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_spoolfile__FiPc
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,104($fp)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_startplayback__Fi
	li	$18,240			# 0x000000f0
	.set	macro
	.set	reorder

$L643:
	li	$17,129			# 0x00000081
	li	$16,1			# 0x00000001
	li	$4,3145728			# 0x00300000
$L647:
	ori	$4,$4,0x3030
	sll	$5,$18,16
	sra	$5,$5,16
	li	$6,15			# 0x0000000f
	li	$7,2			# 0x00000002
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	addu	$2,$18,80
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,480
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	li	$4,3145728			# 0x00300000
	.set	macro
	.set	reorder

	li	$18,79			# 0x0000004f
	li	$16,1			# 0x00000001
$L634:
	li	$4,2097152			# 0x00200000
	ori	$4,$4,0x2020
	li	$5,160			# 0x000000a0
	sll	$6,$18,16
	sra	$6,$6,16
	li	$7,321			# 0x00000141
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	addu	$2,$18,64
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,143
	bne	$2,$0,$L634
	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$18,$0
$L638:
	sll	$2,$18,16
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	sll	$4,$4,4
	addu	$4,$4,132
	.set	noreorder
	.set	nomacro
	jal	DrawTV__FR9tTVConfig
	addu	$4,$fp,$4
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	bne	$2,$0,$L638
	lw	$31,228($sp)
	lw	$fp,224($sp)
	lw	$23,220($sp)
	lw	$22,216($sp)
	lw	$21,212($sp)
	lw	$20,208($sp)
	lw	$19,204($sp)
	lw	$18,200($sp)
	lw	$17,196($sp)
	lw	$16,192($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,232
	.set	macro
	.set	reorder

	.end	DrawBackground__16tScreenPinkSlips
	.rdata
	.align	2
$LC1:
	.ascii	"zPink\000"
	.align	2
$LC2:
	.ascii	"TR%02dPS\000"
	.text
	.align	2
	.globl	GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3
	.ent	GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3
GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3:
	.frame	$sp,96,$31		# vars= 48, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$21,84($sp)
	move	$21,$4
	sw	$17,68($sp)
	move	$17,$5
	sw	$18,72($sp)
	move	$18,$6
	sw	$20,80($sp)
	move	$20,$7
	lui	$4,%hi(trackManager) # high
	lui	$2,%hi(frontEnd+35) # high
	lbu	$5,%lo(frontEnd+35)($2)
	addiu	$4,$4,%lo(trackManager) # low
	sw	$19,76($sp)
	lw	$19,112($sp)
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
	li	$2,57			# 0x00000039
	sh	$2,0($17)
	li	$2,4			# 0x00000004
	sh	$2,0($18)
	lui	$2,%hi($LC1) # high
	addiu	$2,$2,%lo($LC1) # low
	lui	$5,%hi($LC2) # high
	sw	$2,0($20)
	lb	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	sw	$16,0($19)
	lbu	$2,16($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,112($21)
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

	.end	GetShapeInfo__16tScreenPinkSlipsRsT1PPcT3
	.align	2
	.globl	Initialize__16tScreenPinkSlips
	.ent	Initialize__16tScreenPinkSlips
Initialize__16tScreenPinkSlips:
	.frame	$sp,176,$31		# vars= 136, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	sw	$16,160($sp)
	move	$16,$4
	addu	$4,$sp,24
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$2,512			# 0x00000200
	sh	$2,24($sp)
	li	$2,170			# 0x000000aa
	sh	$2,28($sp)
	li	$2,256			# 0x00000100
	sw	$31,172($sp)
	sw	$18,168($sp)
	sw	$17,164($sp)
	sh	$0,26($sp)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$2,30($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	lui	$17,%hi(frontEnd) # high
	lui	$18,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($18)
	addiu	$17,$17,%lo(frontEnd) # low
	sb	$0,70($17)
	.set	noreorder
	.set	nomacro
	jal	Decrement__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($18)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__18tListIteratorTrack7tPlayer
	addu	$4,$4,3208
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	#nop
	lw	$2,4($2)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$2,100($16)
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	sw	$0,708($16)
	lbu	$5,35($17)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,112
	.set	macro
	.set	reorder

	addu	$17,$sp,32
	move	$4,$17
	lui	$2,%hi(Paths_Paths+164) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+164)($2)
	lb	$7,112($sp)
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
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	VIDEO_create__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	VIDEO_spoolfile__FiPc
	sw	$4,104($16)
	.set	macro
	.set	reorder

	lw	$4,104($16)
	jal	VIDEO_startplayback__Fi
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$0,108($16)
	sh	$0,114($16)
	sh	$0,116($16)
	sw	$0,708($16)
	sb	$2,128($16)
	sw	$3,124($16)
	lw	$31,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	Initialize__16tScreenPinkSlips
	.align	2
	.globl	Cleanup__16tScreenPinkSlips
	.ent	Cleanup__16tScreenPinkSlips
Cleanup__16tScreenPinkSlips:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,104($16)
	jal	VIDEO_destroy__Fi
	lw	$4,104($16)
	jal	purgememadr
	move	$4,$16
	lui	$2,%hi(frontEnd+70) # high
	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	sb	$0,%lo(frontEnd+70)($2)
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

	.end	Cleanup__16tScreenPinkSlips
	.align	2
	.globl	UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
	.ent	UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,28($sp)
	sw	$16,16($sp)
	#.set	volatile
	lbu	$2,0($18)
	#.set	novolatile
	lh	$3,112($17)
	sll	$6,$2,24
	sra	$2,$6,24
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L651
	lui	$16,%hi(gSwapFileName) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$0,708($17)
	lbu	$2,0($18)
	lb	$3,128($17)
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	bltz	$3,$L653
	sh	$2,112($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,-1			# 0xffffffff
	sb	$2,128($17)
	sw	$3,124($17)
$L653:
	lw	$4,104($17)
	jal	VIDEO_abortplayback__Fi
$L651:
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

	.end	UpdateVideoWall__16tScreenPinkSlipsR17tTrackInformation
	.align	2
	.globl	DrawVideoWall__16tScreenPinkSlips
	.ent	DrawVideoWall__16tScreenPinkSlips
DrawVideoWall__16tScreenPinkSlips:
	.frame	$sp,56,$31		# vars= 0, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$16,32($sp)
	move	$16,$0
	sw	$31,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	sll	$4,$16,16
$L687:
	sra	$4,$4,16
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,36
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	sll	$4,$16,16
	.set	macro
	.set	reorder

	lhu	$2,58($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,708($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	move	$16,$0
	sll	$6,$16,16
$L689:
	sra	$6,$6,16
	sll	$4,$6,1
	addu	$4,$4,$6
	sll	$4,$4,4
	addu	$4,$4,516
	lw	$5,40($18)
	.set	noreorder
	.set	nomacro
	jal	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	sll	$6,$16,16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,708($18)
	lui	$2,%hi(ticks) # high
$L688:
	lw	$2,%lo(ticks)($2)
	lw	$3,124($18)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,2
	lb	$2,128($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L666
	move	$16,$3
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L673
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(imageTVOrder) # high
	addiu	$19,$2,%lo(imageTVOrder) # low
	move	$16,$3
	sll	$2,$17,16
	sra	$3,$2,16
$L694:
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L673
	addu	$2,$3,$19
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$4,$2,4
	addu	$2,$18,$4
	lw	$2,516($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L690
	addu	$2,$17,1
	.set	macro
	.set	reorder

	addu	$4,$4,516
	.set	noreorder
	.set	nomacro
	jal	TurnOnTV__FR9tTVConfig
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	addu	$2,$17,1
$L690:
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L673
	sll	$2,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L694
	sra	$3,$2,16
	.set	macro
	.set	reorder

$L666:
	sll	$2,$16,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L693
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(imageTVOrder) # high
	addiu	$20,$2,%lo(imageTVOrder) # low
	move	$19,$3
	sll	$2,$17,16
$L692:
	sra	$3,$2,16
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	addu	$2,$3,$20
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$4,$2,4
	addu	$2,$18,$4
	lw	$3,516($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L691
	addu	$2,$17,1
	.set	macro
	.set	reorder

	addu	$4,$4,516
	.set	noreorder
	.set	nomacro
	jal	TurnOffTV__FR9tTVConfig
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	addu	$2,$17,1
$L691:
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L692
	sll	$2,$17,16
	.set	macro
	.set	reorder

$L675:
	sll	$2,$16,16
$L693:
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	move	$16,$0
	.set	macro
	.set	reorder

	sb	$0,128($18)
$L673:
	move	$16,$0
$L684:
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	sll	$4,$4,4
	addu	$4,$4,516
	.set	noreorder
	.set	nomacro
	jal	DrawTV__FR9tTVConfig
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	bne	$2,$0,$L684
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

	.end	DrawVideoWall__16tScreenPinkSlips
	.align	2
	.globl	ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,72,$31		# vars= 48, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$31,68($sp)
	sw	$16,64($sp)
	lw	$3,0($6)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L695
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$16,$2,%lo(frontEnd) # low
	lui	$4,%hi(trackManager) # high
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
	beq	$3,$2,$L697
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,798($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L697
	ori	$2,$5,0x0001
	.set	macro
	.set	reorder

	sw	$2,3916($4)
$L697:
	lbu	$2,18($sp)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L698
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3916($3)
$L698:
	lbu	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3916($3)
$L699:
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,3($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L701
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L701
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3916($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3916($3)
	lui	$2,%hi(menuDefs) # high
$L701:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,3952($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,3952($3)
$L695:
	lw	$31,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___16tScreenPinkSlips
	.ent	___16tScreenPinkSlips
___16tScreenPinkSlips:
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

	.end	___16tScreenPinkSlips

	.lcomm	gSwapFileName,20
