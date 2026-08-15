	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentrackinfo.cpp"
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
	.ascii	"zInfo\000"
	.align	2
$LC1:
	.ascii	"TR%02d%c\000"
	.text
	.align	2
	.globl	GetShapeInfo__16tScreenTrackInfoRsT1PPcT3
	.ent	GetShapeInfo__16tScreenTrackInfoRsT1PPcT3
GetShapeInfo__16tScreenTrackInfoRsT1PPcT3:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	sw	$19,28($sp)
	lw	$19,56($sp)
	li	$2,43			# 0x0000002b
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	sh	$2,0($5)
	addu	$5,$17,100
	li	$2,10			# 0x0000000a
	move	$18,$7
	.set	noreorder
	.set	nomacro
	jal	GetTrackToRace__18tTournamentManagerR10tTrackInfo
	sh	$2,0($6)
	.set	macro
	.set	reorder

	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	sw	$2,0($18)
	lbu	$2,103($17)
	lbu	$7,104($17)
	lb	$6,100($17)
	sll	$2,$2,1
	addu	$7,$7,97
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$7,$2,$7
	.set	macro
	.set	reorder

	sw	$16,0($19)
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

	.end	GetShapeInfo__16tScreenTrackInfoRsT1PPcT3
	.rdata
	.align	2
$LC2:
	.half	204
	.half	205
	.half	206
	.half	207
	.text
	.align	2
	.globl	DrawBackground__16tScreenTrackInfo
	.ent	DrawBackground__16tScreenTrackInfo
DrawBackground__16tScreenTrackInfo:
	.frame	$sp,64,$31		# vars= 8, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,44($sp)
	move	$19,$4
	lui	$2,%hi($LC2) # high
	lui	$4,%hi(trackManager) # high
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	addiu	$11,$2,%lo($LC2)
	lwl	$8,3($11)
	lwr	$8,0($11)
	lwl	$9,7($11)
	lwr	$9,4($11)
	swl	$8,27($sp)
	swr	$8,24($sp)
	swl	$9,31($sp)
	swr	$9,28($sp)
	lb	$5,100($19)
	.set	noreorder
	.set	nomacro
	jal	GetTrackByID__13tTrackManagers
	addiu	$4,$4,%lo(trackManager) # low
	.set	macro
	.set	reorder

	move	$21,$2
	lui	$3,%hi(tournamentManager) # high
	lui	$2,%hi(frontEnd) # high
	addiu	$6,$2,%lo(frontEnd) # low
	lbu	$2,290($6)
	addiu	$4,$3,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	move	$5,$2
	.set	macro
	.set	reorder

	lbu	$6,289($6)
	j	$L603
$L602:
	lbu	$6,288($6)
$L603:
	.set	noreorder
	.set	nomacro
	jal	GetTrackList__18tTournamentManagerss
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(tournamentManager) # high
	addiu	$20,$3,%lo(tournamentManager) # low
	li	$18,9371648			# 0x008f0000
	move	$17,$2
$L604:
	lh	$4,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L605
	li	$5,340			# 0x00000154
	.set	macro
	.set	reorder

	lw	$2,12($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L608
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$7,2			# 0x00000002
$L608:
	li	$2,4			# 0x00000004
	sw	$2,16($sp)
	li	$5,170			# 0x000000aa
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sra	$6,$18,16
	.set	macro
	.set	reorder

	li	$2,589824			# 0x00090000
	addu	$18,$18,$2
	addu	$17,$17,2
	.set	noreorder
	.set	nomacro
	j	$L604
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L605:
	move	$16,$0
	li	$20,4			# 0x00000004
	li	$18,9371648			# 0x008f0000
	addu	$17,$sp,24
$L614:
	sra	$6,$18,16
	li	$7,1			# 0x00000001
	lh	$4,0($17)
	addu	$17,$17,2
	addu	$16,$16,$7
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	li	$2,1179648			# 0x00120000
	addu	$18,$18,$2
	sltu	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	li	$5,340			# 0x00000154
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	li	$5,480			# 0x000001e0
	li	$6,152			# 0x00000098
	li	$7,1			# 0x00000001
	lui	$3,%hi(SelectListTrackDirection) # high
	addiu	$3,$3,%lo(SelectListTrackDirection) # low
	lbu	$2,101($19)
	li	$18,2			# 0x00000002
	sll	$2,$2,$7
	addu	$2,$2,$3
	lh	$4,0($2)
	li	$17,4			# 0x00000004
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$5,480			# 0x000001e0
	li	$6,170			# 0x000000aa
	lui	$16,%hi(SelectListOffOn) # high
	lbu	$2,102($19)
	addiu	$16,$16,%lo(SelectListOffOn) # low
	sll	$2,$2,1
	addu	$2,$2,$16
	lh	$4,0($2)
	li	$7,1			# 0x00000001
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$5,480			# 0x000001e0
	lbu	$2,103($19)
	li	$6,188			# 0x000000bc
	sll	$2,$2,1
	addu	$2,$2,$16
	lh	$4,0($2)
	li	$7,1			# 0x00000001
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$5,480			# 0x000001e0
	lbu	$2,104($19)
	li	$6,206			# 0x000000ce
	sll	$2,$2,1
	addu	$2,$2,$16
	lh	$4,0($2)
	li	$7,1			# 0x00000001
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$17,20($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	li	$5,478			# 0x000001de
	li	$6,33			# 0x00000021
	li	$7,1			# 0x00000001
	lbu	$4,42($21)
	li	$2,11			# 0x0000000b
	sw	$0,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	addu	$4,$4,67
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$0
	sw	$0,16($sp)
	lw	$7,0($19)
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	li	$6,33			# 0x00000021
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,320			# 0x00000140
	li	$6,30			# 0x0000001e
	li	$7,160			# 0x000000a0
	li	$2,10			# 0x0000000a
	sw	$2,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$16,$19,620
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

 #APP
 #NO_APP
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

	.end	DrawBackground__16tScreenTrackInfo
	.align	2
	.globl	Initialize__16tScreenTrackInfo
	.ent	Initialize__16tScreenTrackInfo
Initialize__16tScreenTrackInfo:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$17,36($sp)
	.set	macro
	.set	reorder

	addu	$17,$16,620
	move	$4,$17
	li	$2,10			# 0x0000000a
	sw	$2,16($sp)
	lui	$2,%hi(tvOrder) # high
	addiu	$2,$2,%lo(tvOrder) # low
	addu	$5,$16,140
	sw	$2,20($sp)
	sw	$0,24($sp)
	lw	$6,40($16)
	.set	noreorder
	.set	nomacro
	jal	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	move	$4,$17
	.set	macro
	.set	reorder

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

	.end	Initialize__16tScreenTrackInfo
	.align	2
	.globl	ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($6)
	li	$2,16			# 0x00000010
	bne	$3,$2,$L616
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$4,620
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager) # high
	addiu	$5,$2,%lo(tournamentManager) # low
	lw	$2,12($5)
	#nop
	bne	$2,$0,$L616
	lw	$3,4($5)
	lw	$4,24($5)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$3,84($2)
	lw	$2,20($5)
	#nop
	addu	$2,$2,$3
	sw	$2,20($5)
$L616:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___16tScreenTrackInfo
	.ent	___16tScreenTrackInfo
___16tScreenTrackInfo:
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

	.end	___16tScreenTrackInfo

	.lcomm	gSwapFileName,64
	.globl	screenTrackInfo
	.data
	.align	2
screenTrackInfo:
	.space	4
