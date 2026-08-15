	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentournselect.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.data
	.align	2
trophyTVOrder:
	.byte	1
	.byte	2
	.byte	0
	.byte	3
	.text
	.align	2
	.globl	__18tScreenTournSelect
	.ent	__18tScreenTournSelect
__18tScreenTournSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(tScreenTournSelect_vtable) # high
	addiu	$2,$2,%lo(tScreenTournSelect_vtable) # low
	sw	$2,96($16)
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

	.end	__18tScreenTournSelect
	.align	2
	.globl	_._18tScreenTournSelect
	.ent	_._18tScreenTournSelect
_._18tScreenTournSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tScreenTournSelect_vtable) # high
	addiu	$2,$2,%lo(tScreenTournSelect_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$2,96($4)
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

	.end	_._18tScreenTournSelect
	.rdata
	.align	2
$LC0:
	.ascii	"ztourn\000"
	.text
	.align	2
	.globl	GetShapeInfo__18tScreenTournSelectRsT1PPcT3
	.ent	GetShapeInfo__18tScreenTournSelectRsT1PPcT3
GetShapeInfo__18tScreenTournSelectRsT1PPcT3:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	sw	$31,28($sp)
	sw	$16,24($sp)
	lbu	$2,290($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	move	$9,$6
	.set	macro
	.set	reorder

	lbu	$8,289($3)
	.set	noreorder
	.set	nomacro
	j	$L607
	lui	$4,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

$L605:
	lbu	$8,288($3)
	lui	$4,%hi(tournamentManager) # high
$L607:
	addiu	$4,$4,%lo(tournamentManager) # low
	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	lbu	$3,290($3)
	lw	$6,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$6,$2
	lbu	$3,2($2)
	li	$2,64			# 0x00000040
	sh	$2,0($5)
	li	$2,32			# 0x00000020
	sh	$2,0($9)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	sw	$2,0($7)
	li	$2,-1			# 0xffffffff
	move	$7,$16
	sw	$2,16($sp)
	addu	$3,$8,$3
	sll	$5,$3,2
	addu	$5,$5,$3
	sll	$5,$5,2
	addu	$5,$5,$3
	sll	$5,$5,2
	addu	$5,$5,36
	addu	$5,$6,$5
	.set	noreorder
	.set	nomacro
	jal	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,48($sp)
	#nop
	sw	$16,0($2)
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	GetShapeInfo__18tScreenTournSelectRsT1PPcT3
	.rdata
	.align	2
$LC1:
	.ascii	"%szzzTRN.dct\000"
	.text
	.align	2
	.globl	Initialize__18tScreenTournSelect
	.ent	Initialize__18tScreenTournSelect
Initialize__18tScreenTournSelect:
	.frame	$sp,144,$31		# vars= 88, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$19,124($sp)
	move	$19,$4
	addu	$4,$sp,24
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$2,-1			# 0xffffffff
	sw	$31,140($sp)
	sw	$22,136($sp)
	sw	$21,132($sp)
	sw	$20,128($sp)
	sw	$18,120($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	sw	$2,704($19)
	sw	$2,708($19)
	li	$2,512			# 0x00000200
	sh	$2,24($sp)
	li	$2,80			# 0x00000050
	sh	$2,28($sp)
	li	$2,160			# 0x000000a0
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

	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$16,$sp,32
	move	$4,$16
	lui	$2,%hi(Paths_Paths+164) # high
	lui	$5,%hi($LC1) # high
	sh	$0,686($19)
	sh	$0,684($19)
	lw	$6,%lo(Paths_Paths+164)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

	li	$4,80			# 0x00000050
	move	$5,$4
	li	$6,983040			# 0x000f0000
	li	$7,131072			# 0x00020000
	ori	$7,$7,0x5800
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
	sw	$4,100($19)
	.set	macro
	.set	reorder

	lw	$4,100($19)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_startplayback__Fi
	move	$21,$0
	.set	macro
	.set	reorder

	sw	$0,104($19)
	move	$18,$0
$L620:
	sll	$3,$21,16
	sra	$3,$3,16
	sll	$22,$3,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$20,$2,165
$L612:
	sll	$17,$18,16
	sra	$17,$17,16
	addu	$2,$22,$17
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,4
	addu	$4,$16,492
	addu	$4,$19,$4
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$4,$18,1
	move	$18,$4
	addu	$16,$19,$16
	sll	$2,$17,3
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$2,$17
	addu	$2,$2,142
	sh	$2,514($16)
	li	$2,76			# 0x0000004c
	sh	$2,516($16)
	li	$2,37			# 0x00000025
	sll	$4,$4,16
	sra	$4,$4,16
	lhu	$3,500($16)
	slt	$4,$4,2
	sh	$20,512($16)
	sh	$2,518($16)
	ori	$3,$3,0x0030
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L612
	sh	$3,500($16)
	.set	macro
	.set	reorder

	addu	$2,$21,1
	move	$21,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,290($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	lui	$4,%hi(tournamentManager+24) # high
	.set	macro
	.set	reorder

	lbu	$5,289($3)
	j	$L619
$L617:
	lbu	$5,288($3)
$L619:
	lbu	$3,290($3)
	lw	$4,%lo(tournamentManager+24)($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	#nop
	addu	$3,$5,$3
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lbu	$2,58($2)
	#nop
	sb	$2,698($19)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sh	$2,696($19)
	sw	$3,692($19)
	lw	$31,140($sp)
	lw	$22,136($sp)
	lw	$21,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	Initialize__18tScreenTournSelect
	.align	2
	.globl	Cleanup__18tScreenTournSelect
	.ent	Cleanup__18tScreenTournSelect
Cleanup__18tScreenTournSelect:
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

	.end	Cleanup__18tScreenTournSelect
	.align	2
	.globl	UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
	.ent	UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$16,24($sp)
	lbu	$3,22($18)
	lb	$2,698($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L622
	lui	$4,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(tournamentManager) # low
	li	$19,-1			# 0xffffffff
	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	li	$6,1			# 0x00000001
	move	$7,$16
	.set	noreorder
	.set	nomacro
	jal	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	sw	$19,16($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$0,700($17)
	lbu	$2,22($18)
	lh	$3,696($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L622
	sb	$2,698($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	sh	$19,696($17)
	sw	$2,692($17)
$L622:
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

	.end	UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
	.align	2
	.globl	DrawVideoWall__18tScreenTournSelect
	.ent	DrawVideoWall__18tScreenTournSelect
DrawVideoWall__18tScreenTournSelect:
	.frame	$sp,80,$31		# vars= 24, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$18,64($sp)
	move	$18,$4
	move	$5,$0
	li	$6,34			# 0x00000022
	sw	$17,60($sp)
	li	$17,244			# 0x000000f4
	sw	$31,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$16,56($sp)
	lw	$2,40($18)
	li	$19,97			# 0x00000061
	sw	$2,52($sp)
	sw	$0,16($sp)
	lw	$7,0($18)
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,2097152			# 0x00200000
$L657:
	ori	$4,$4,0x2020
	move	$5,$17
	li	$6,41			# 0x00000029
	li	$7,2			# 0x00000002
	sw	$19,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,80
	slt	$2,$17,485
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L657
	li	$4,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$17,89			# 0x00000059
	li	$16,1			# 0x00000001
	li	$4,1310720			# 0x00140000
$L658:
	ori	$4,$4,0x1414
	li	$5,165			# 0x000000a5
	move	$6,$17
	li	$7,321			# 0x00000141
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,48
	slt	$2,$17,137
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	li	$4,1310720			# 0x00140000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,692($18)
	#nop
	subu	$2,$2,$3
	lh	$3,696($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L634
	srl	$17,$2,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L642
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(trophyTVOrder) # high
	addiu	$19,$2,%lo(trophyTVOrder) # low
	slt	$2,$16,4
$L656:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	addu	$2,$16,$19
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$4,$2,4
	addu	$2,$18,$4
	lw	$2,492($2)
	#nop
	bne	$2,$0,$L637
	addu	$4,$4,492
	.set	noreorder
	.set	nomacro
	jal	TurnOnTV__FR9tTVConfig
	addu	$4,$18,$4
	.set	macro
	.set	reorder

$L637:
	addu	$16,$16,1
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	slt	$2,$16,4
	.set	macro
	.set	reorder

	j	$L656
$L634:
	.set	noreorder
	.set	nomacro
	blez	$17,$L644
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(trophyTVOrder) # high
	addiu	$20,$2,%lo(trophyTVOrder) # low
	li	$19,1			# 0x00000001
	slt	$2,$16,4
$L659:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L644
	addu	$2,$16,$20
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$4,$2,4
	addu	$2,$18,$4
	lw	$2,492($2)
	#nop
	bne	$2,$19,$L645
	addu	$4,$4,492
	.set	noreorder
	.set	nomacro
	jal	TurnOffTV__FR9tTVConfig
	addu	$4,$18,$4
	.set	macro
	.set	reorder

$L645:
	addu	$16,$16,1
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	slt	$2,$16,4
	.set	macro
	.set	reorder

$L644:
	slt	$2,$17,4
	bne	$2,$0,$L642
	sh	$0,696($18)
$L642:
	li	$4,3145728			# 0x00300000
	ori	$4,$4,0x3030
	li	$5,241			# 0x000000f1
	li	$6,142			# 0x0000008e
	li	$7,2			# 0x00000002
	li	$2,74			# 0x0000004a
	li	$16,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	li	$4,2097152			# 0x00200000
	ori	$4,$4,0x2020
	li	$5,165			# 0x000000a5
	li	$6,179			# 0x000000b3
	li	$7,152			# 0x00000098
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$17,$0
	li	$16,492			# 0x000001ec
$L651:
	.set	noreorder
	.set	nomacro
	jal	DrawTV__FR9tTVConfig
	addu	$4,$18,$16
	.set	macro
	.set	reorder

	addu	$17,$17,1
	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L651
	addu	$16,$16,48
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sra	$2,$2,4
	.set	noreorder
	.set	nomacro
	bgez	$2,$L655
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$4,$2,31
$L655:
	sra	$4,$4,5
	sll	$4,$4,5
	subu	$4,$2,$4
	li	$5,1536			# 0x00000600
	li	$6,182			# 0x000000b6
	li	$7,147			# 0x00000093
	addu	$2,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$31,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	DrawVideoWall__18tScreenTournSelect
	.align	2
	.globl	DrawBackground__18tScreenTournSelect
	.ent	DrawBackground__18tScreenTournSelect
DrawBackground__18tScreenTournSelect:
	.frame	$sp,240,$31		# vars= 168, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	sw	$31,236($sp)
	sw	$fp,232($sp)
	sw	$23,228($sp)
	sw	$22,224($sp)
	sw	$21,220($sp)
	sw	$20,216($sp)
	sw	$19,212($sp)
	sw	$18,208($sp)
	sw	$17,204($sp)
	sw	$16,200($sp)
	lbu	$2,290($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	move	$20,$4
	.set	macro
	.set	reorder

	lbu	$7,289($3)
	.set	noreorder
	.set	nomacro
	j	$L696
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

$L661:
	lbu	$7,288($3)
	li	$4,48830			# 0x0000bebe
$L696:
	move	$18,$0
	lui	$16,%hi(tournamentManager) # high
	addiu	$16,$16,%lo(tournamentManager) # low
	lbu	$3,290($3)
	lw	$6,24($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$6,$2
	lbu	$3,2($2)
	lh	$5,92($20)
	addu	$3,$7,$3
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	addu	$23,$6,$2
	.set	macro
	.set	reorder

	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	lh	$5,92($20)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$22,$2
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	lh	$5,92($20)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$21,$2
	.set	macro
	.set	reorder

	li	$5,123			# 0x0000007b
	li	$6,1			# 0x00000001
	li	$7,4			# 0x00000004
	lh	$4,92($20)
	lw	$17,20($16)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	move	$fp,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,123			# 0x0000007b
	.set	macro
	.set	reorder

	li	$4,123			# 0x0000007b
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$16,$2,140
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$2,9
	li	$6,6			# 0x00000006
	move	$7,$17
	sw	$22,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	sw	$21,20($sp)
	.set	macro
	.set	reorder

	li	$5,153			# 0x00000099
	li	$6,1			# 0x00000001
	lh	$4,92($20)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	li	$7,14			# 0x0000000e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,153			# 0x00000099
	.set	macro
	.set	reorder

	li	$4,153			# 0x00000099
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$16,$2,140
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$2,9
	sw	$22,16($sp)
	sw	$21,20($sp)
	lw	$7,48($23)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$5,154			# 0x0000009a
	li	$6,1			# 0x00000001
	lh	$4,92($20)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	li	$7,14			# 0x0000000e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,154			# 0x0000009a
	.set	macro
	.set	reorder

	addu	$19,$2,9
$L663:
	sll	$17,$18,16
	sra	$17,$17,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$17,724
	.set	macro
	.set	reorder

	li	$4,154			# 0x0000009a
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$2,$2,16
	sra	$5,$2,16
	sll	$16,$19,16
	sra	$16,$16,16
	move	$6,$16
	move	$7,$fp
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,153			# 0x00000099
	.set	macro
	.set	reorder

	addu	$4,$2,140
	move	$5,$16
	li	$6,6			# 0x00000006
	sll	$17,$17,2
	addu	$17,$23,$17
	sw	$22,16($sp)
	sw	$21,20($sp)
	lw	$7,24($17)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	addu	$19,$19,9
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	bne	$2,$0,$L663
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	UpdateVideoWall__18tScreenTournSelectP12tTourneyInfo
	move	$5,$23
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$20,40
	.set	macro
	.set	reorder

	lw	$2,44($20)
	#nop
	beq	$2,$0,$L667
	lh	$2,696($20)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L667
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sh	$2,696($20)
	sw	$3,692($20)
$L667:
	.set	noreorder
	.set	nomacro
	jal	DrawVideoWall__18tScreenTournSelect
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$2,104($20)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L668
	move	$8,$0
	.set	macro
	.set	reorder

	li	$8,80			# 0x00000050
$L668:
	li	$10,2883584			# 0x002c0000
	ori	$10,$10,0x1e1e
	sw	$10,184($sp)
	move	$18,$0
	li	$9,128			# 0x00000080
$L669:
	move	$17,$0
	sll	$3,$18,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$fp,$2,41
	sll	$19,$3,2
	addu	$3,$19,$3
	sll	$23,$3,3
	li	$4,2			# 0x00000002
$L697:
	move	$5,$0
	li	$10,512			# 0x00000200
	sll	$22,$10,16
	sra	$6,$22,16
	sll	$21,$8,16
	sra	$7,$21,16
	addu	$2,$17,$19
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,4
	addu	$16,$20,$16
	sll	$2,$17,16
	sra	$2,$2,16
	sll	$3,$2,$4
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$2,$2,165
	sh	$2,128($16)
	li	$2,80			# 0x00000050
	sh	$2,132($16)
	li	$2,48			# 0x00000030
	sll	$3,$3,$4
	sh	$2,134($16)
	li	$2,20			# 0x00000014
	sb	$2,138($16)
	li	$2,40			# 0x00000028
	sh	$fp,130($16)
	sb	$3,136($16)
	sb	$23,137($16)
	sb	$2,139($16)
	sw	$8,192($sp)
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sw	$9,196($sp)
	.set	macro
	.set	reorder

	addu	$3,$17,1
	move	$17,$3
	sh	$2,144($16)
	li	$2,1			# 0x00000001
	sw	$2,108($16)
	li	$2,34			# 0x00000022
	sll	$3,$3,16
	sh	$0,142($16)
	sh	$2,116($16)
	lw	$10,184($sp)
	sra	$3,$3,16
	sw	$10,124($16)
	lw	$9,196($sp)
	slt	$3,$3,4
	sh	$9,114($16)
	sh	$9,112($16)
	lw	$8,192($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L697
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	bne	$2,$0,$L669
	lw	$4,100($20)
	jal	VIDEO_state__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L677
	lui	$2,%hi(Paths_Paths+164) # high
	.set	macro
	.set	reorder

	lw	$4,100($20)
	srl	$5,$22,16
	.set	noreorder
	.set	nomacro
	jal	VIDEO_updateframexy__Fiii
	srl	$6,$21,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L680
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$2,104($20)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L680
	sw	$2,104($20)
	.set	macro
	.set	reorder

$L677:
	addu	$16,$sp,104
	move	$4,$16
	lui	$5,%hi($LC1) # high
	sh	$0,686($20)
	lw	$6,%lo(Paths_Paths+164)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

	lw	$4,100($20)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_spoolfile__FiPc
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,100($20)
	.set	noreorder
	.set	nomacro
	jal	VIDEO_startplayback__Fi
	move	$18,$0
	.set	macro
	.set	reorder

$L680:
	sll	$2,$18,16
$L698:
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	sll	$4,$4,4
	addu	$4,$4,108
	.set	noreorder
	.set	nomacro
	jal	DrawTVLines__FR9tTVConfig
	addu	$4,$20,$4
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L698
	sll	$2,$18,16
	.set	macro
	.set	reorder

	li	$2,325			# 0x00000145
	sh	$2,96($sp)
	li	$2,43			# 0x0000002b
	sh	$2,98($sp)
	li	$2,314			# 0x0000013a
	sh	$2,100($sp)
	lui	$2,%hi(frontEnd+290) # high
	lbu	$3,%lo(frontEnd+290)($2)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L684
	sh	$2,102($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L694
	addu	$4,$4,1932
	.set	macro
	.set	reorder

$L684:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	addu	$4,$4,1704
$L694:
	jal	TextValue__23tListIteratorTournament7tPlayer
	sll	$2,$2,16
	sra	$5,$2,16
	addu	$6,$sp,96
	li	$7,2			# 0x00000002
	lh	$4,92($20)
	li	$2,13			# 0x0000000d
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$2,170			# 0x000000aa
	lui	$3,%hi(frontEnd+290) # high
	sh	$2,96($sp)
	lhu	$2,100($sp)
	lbu	$3,%lo(frontEnd+290)($3)
	addu	$2,$2,-10
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L686
	sh	$2,100($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L695
	addu	$4,$4,1932
	.set	macro
	.set	reorder

$L686:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	addu	$4,$4,1704
$L695:
	jal	TextValue__23tListIteratorTournament7tPlayer
	move	$18,$2
	addu	$2,$18,38
	move	$18,$2
	sll	$2,$2,16
	lw	$3,708($20)
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L689
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,704($20)
	#nop
	bne	$3,$2,$L688
$L689:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$4,708($20)
	.set	macro
	.set	reorder

	lh	$4,100($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapHeight__FsPc
	move	$5,$2
	.set	macro
	.set	reorder

	li	$3,117			# 0x00000075
	subu	$3,$3,$2
	sw	$3,704($20)
$L688:
	sll	$4,$18,16
	sra	$4,$4,16
	addu	$17,$18,-871
	lhu	$2,704($20)
	move	$18,$0
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$2,98($sp)
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	lh	$5,92($20)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,96
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGB__FPcR4RECTi
	move	$6,$2
	.set	macro
	.set	reorder

	li	$5,987			# 0x000003db
	li	$6,170			# 0x000000aa
	li	$7,117			# 0x00000075
	li	$2,1			# 0x00000001
	lh	$4,92($20)
	li	$16,4			# 0x00000004
	sw	$0,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,890
	sll	$17,$17,16
	sra	$5,$17,16
	li	$6,170			# 0x000000aa
	li	$7,125			# 0x0000007d
	lh	$4,92($20)
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$16,24($sp)
	.set	macro
	.set	reorder

$L690:
	sll	$2,$18,16
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	sll	$4,$4,4
	addu	$4,$4,108
	.set	noreorder
	.set	nomacro
	jal	DrawTV__FR9tTVConfig
	addu	$4,$20,$4
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	bne	$2,$0,$L690
	lw	$31,236($sp)
	lw	$fp,232($sp)
	lw	$23,228($sp)
	lw	$22,224($sp)
	lw	$21,220($sp)
	lw	$20,216($sp)
	lw	$19,212($sp)
	lw	$18,208($sp)
	lw	$17,204($sp)
	lw	$16,200($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	DrawBackground__18tScreenTournSelect
	.align	2
	.globl	DrawForeground__18tScreenTournSelect
	.ent	DrawForeground__18tScreenTournSelect
DrawForeground__18tScreenTournSelect:
	.frame	$sp,48,$31		# vars= 0, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,40($sp)
	move	$18,$4
	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	li	$5,167			# 0x000000a7
	li	$6,41			# 0x00000029
	li	$7,316			# 0x0000013c
	sw	$16,32($sp)
	li	$16,1			# 0x00000001
	li	$2,3			# 0x00000003
	sw	$31,44($sp)
	sw	$17,36($sp)
	sw	$16,16($sp)
	sw	$2,20($sp)
	lh	$2,92($18)
	li	$17,20			# 0x00000014
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	li	$5,167			# 0x000000a7
	li	$6,74			# 0x0000004a
	li	$2,2			# 0x00000002
	sw	$16,16($sp)
	sw	$2,20($sp)
	lh	$2,92($18)
	li	$7,316			# 0x0000013c
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$31,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	DrawForeground__18tScreenTournSelect
	.globl	screenTournSelect
	.data
	.align	2
screenTournSelect:
	.space	4

	.lcomm	gSwapFileName,16
