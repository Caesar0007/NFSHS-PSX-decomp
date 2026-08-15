	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentrophyroom.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	__17tScreenTrophyRoom
	.ent	__17tScreenTrophyRoom
__17tScreenTrophyRoom:
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

	move	$2,$16
	lui	$3,%hi(tScreenTrophyRoom_vtable) # high
	addiu	$3,$3,%lo(tScreenTrophyRoom_vtable) # low
	sw	$3,96($2)
	sb	$0,156($2)
	sh	$0,212($2)
	sh	$0,214($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__17tScreenTrophyRoom
	.align	2
	.globl	_._17tScreenTrophyRoom
	.ent	_._17tScreenTrophyRoom
_._17tScreenTrophyRoom:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tScreenTrophyRoom_vtable) # high
	addiu	$2,$2,%lo(tScreenTrophyRoom_vtable) # low
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

	.end	_._17tScreenTrophyRoom
	.rdata
	.align	2
$LC0:
	.ascii	"zTrophy\000"
	.text
	.align	2
	.globl	GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3
	.ent	GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3
GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$7
	sw	$18,32($sp)
	lw	$18,56($sp)
	li	$2,38			# 0x00000026
	sw	$31,36($sp)
	sw	$16,24($sp)
	sh	$2,0($5)
	li	$2,32			# 0x00000020
	sh	$2,0($6)
	lui	$2,%hi(frontEnd+290) # high
	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	lbu	$3,%lo(frontEnd+290)($2)
	move	$7,$16
	sll	$2,$3,1
	addu	$5,$4,$2
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$6,24($4)
	lbu	$5,212($5)
	addu	$2,$6,$2
	lbu	$3,2($2)
	li	$2,-1			# 0xffffffff
	sw	$2,16($sp)
	addu	$3,$3,$5
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
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	sw	$2,0($17)
	sw	$16,0($18)
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3
	.align	2
	.globl	ProcessInput__17tScreenTrophyRoom7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__17tScreenTrophyRoom7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__17tScreenTrophyRoom7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,32($sp)
	lw	$3,0($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L624
	move	$18,$7
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($18)
	addu	$2,$2,512
	sw	$2,4($18)
	lw	$3,0($17)
$L624:
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L607
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L622
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

$L607:
	lw	$3,208($16)
	lhu	$2,140($16)
	sll	$3,$3,1
	addu	$5,$16,$3
	sll	$2,$2,16
	sra	$3,$2,16
	srl	$2,$2,31
	addu	$3,$3,$2
	sra	$3,$3,1
	lh	$2,212($5)
	lhu	$4,212($5)
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	sh	$2,212($5)
	.set	noreorder
	.set	nomacro
	j	$L621
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

$L609:
	subu	$2,$4,$3
	sh	$2,212($5)
	li	$4,4			# 0x00000004
$L621:
	jal	AudioCmn_PlayFESFX__Fi
	lw	$2,208($16)
	#nop
	sll	$2,$2,1
	addu	$4,$16,$2
	lh	$2,212($4)
	lh	$3,140($16)
	.set	noreorder
	.set	nomacro
	blez	$2,$L613
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L611
	j	$L614
$L613:
	blez	$3,$L611
$L614:
	lw	$2,208($16)
	#nop
	sll	$2,$2,1
	addu	$2,$16,$2
	lh	$3,212($2)
	lhu	$2,212($2)
	bgez	$3,$L612
	.set	noreorder
	.set	nomacro
	j	$L612
	move	$2,$0
	.set	macro
	.set	reorder

$L611:
	lhu	$2,140($16)
$L612:
	sh	$2,212($4)
	lw	$3,0($17)
	li	$2,2048			# 0x00000800
$L622:
	bne	$3,$2,$L616
	lw	$3,208($16)
	#nop
	sll	$3,$3,1
	addu	$3,$16,$3
	lhu	$2,212($3)
	#nop
	addu	$2,$2,-1
	sh	$2,212($3)
	lw	$2,208($16)
	#nop
	sll	$2,$2,1
	addu	$3,$16,$2
	lh	$2,212($3)
	#nop
	bgez	$2,$L616
	lhu	$2,140($16)
	#nop
	addu	$2,$2,-1
	sh	$2,212($3)
$L616:
	lw	$3,0($17)
	li	$2,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L623
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,208($16)
	#nop
	sll	$3,$3,1
	addu	$3,$16,$3
	lhu	$2,212($3)
	#nop
	addu	$2,$2,1
	sh	$2,212($3)
	lw	$2,208($16)
	lh	$3,140($16)
	sll	$2,$2,1
	addu	$4,$16,$2
	lh	$2,212($4)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L618
	sh	$0,212($4)
$L618:
	move	$4,$16
$L623:
	move	$5,$19
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$18
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

	.end	ProcessInput__17tScreenTrophyRoom7tPlayerR13tInputKeyTypeR12tMenuCommand
	.rdata
	.align	2
$LC1:
	.ascii	"zCase2\000"
	.align	2
$LC2:
	.ascii	"zCase\000"
	.text
	.align	2
	.globl	PreLoad__17tScreenTrophyRoom
	.ent	PreLoad__17tScreenTrophyRoom
PreLoad__17tScreenTrophyRoom:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PreLoad__7tScreen
	move	$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$16,100
	li	$6,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	sw	$0,100($16)
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+290) # high
	lbu	$2,%lo(frontEnd+290)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
	lui	$2,%hi($LC1) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L627
	addiu	$5,$2,%lo($LC1) # low
	.set	macro
	.set	reorder

$L626:
	lui	$2,%hi($LC2) # high
	addiu	$5,$2,%lo($LC2) # low
$L627:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	addu	$6,$4,100
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

	.end	PreLoad__17tScreenTrophyRoom
	.align	2
	.globl	Initialize__17tScreenTrophyRoom
	.ent	Initialize__17tScreenTrophyRoom
Initialize__17tScreenTrophyRoom:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$17,28($sp)
	.set	macro
	.set	reorder

$L630:
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$16,100
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(frontEnd) # low
 #APP
 #NO_APP
	lbu	$2,290($3)
	#nop
	sw	$2,208($16)
	lbu	$2,290($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$4,8			# 0x00000008
$L634:
	move	$17,$0
	move	$19,$3
	lui	$2,%hi(tournamentManager) # high
	addiu	$18,$2,%lo(tournamentManager) # low
	li	$2,1			# 0x00000001
	sh	$4,140($16)
	sw	$2,160($16)
	sll	$3,$17,16
$L643:
	lh	$2,140($16)
	sra	$6,$3,16
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	li	$3,1			# 0x00000001
	sh	$3,216($2)
	lbu	$3,290($19)
	lw	$4,24($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	andi	$2,$17,0x00ff
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lb	$2,36($2)
	#nop
	addu	$2,$2,$18
	lb	$3,496($2)
	#nop
	addu	$2,$3,-1
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	move	$5,$0
	.set	macro
	.set	reorder

	move	$5,$3
$L640:
	sll	$2,$6,2
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$5,$2,$5
	addu	$17,$17,1
	sll	$6,$6,5
	lw	$2,100($16)
	move	$7,$0
	sw	$0,16($sp)
	lw	$4,104($16)
	.set	noreorder
	.set	nomacro
	jal	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	sll	$3,$17,16
	.set	macro
	.set	reorder

$L637:
	lw	$4,104($16)
	jal	purgememadr
	lh	$2,140($16)
	sw	$0,104($16)
	sll	$2,$2,1
	addu	$2,$16,$2
	sh	$0,216($2)
	lw	$2,208($16)
	#nop
	sll	$2,$2,1
	addu	$5,$16,$2
	lh	$2,140($16)
	lh	$4,212($5)
	addu	$3,$2,-1
	slt	$2,$4,$3
	beq	$2,$0,$L641
	move	$3,$4
$L641:
	sh	$3,212($5)
	lw	$2,208($16)
	#nop
	sll	$2,$2,1
	addu	$2,$16,$2
	lbu	$2,212($2)
	#nop
	sb	$2,156($16)
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,144($16)
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

	.end	Initialize__17tScreenTrophyRoom
	.align	2
	.globl	Cleanup__17tScreenTrophyRoom
	.ent	Cleanup__17tScreenTrophyRoom
Cleanup__17tScreenTrophyRoom:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FreeShapes__7tScreenR17tShapeInformation
	addu	$5,$16,100
	.set	macro
	.set	reorder

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

	.end	Cleanup__17tScreenTrophyRoom
	.align	2
	.globl	DrawBackground__17tScreenTrophyRoom
	.ent	DrawBackground__17tScreenTrophyRoom
DrawBackground__17tScreenTrophyRoom:
	.frame	$sp,112,$31		# vars= 48, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$18,88($sp)
	move	$18,$4
	li	$2,1717960704			# 0x66660000
	sw	$17,84($sp)
	lui	$17,%hi(ticks) # high
	ori	$2,$2,0x6667
	li	$5,1040			# 0x00000410
	li	$6,16			# 0x00000010
	lw	$8,%lo(ticks)($17)
	move	$7,$6
	sw	$31,104($sp)
	sw	$21,100($sp)
	sra	$4,$8,4
	mult	$4,$2
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$16,80($sp)
	li	$2,13500416			# 0x00ce0000
	ori	$2,$2,0xc844
	sw	$2,36($sp)
	addu	$2,$sp,32
	sra	$8,$8,31
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	mfhi	$10
	#nop
	#nop
	sra	$3,$10,2
	subu	$3,$3,$8
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,28
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	addiu	$16,$2,%lo(frontEnd) # low
	lbu	$2,290($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L647
	li	$19,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$19,4			# 0x00000004
$L647:
	move	$4,$18
	move	$5,$0
	lui	$2,%hi(gCurrentShapes) # high
	li	$6,24			# 0x00000018
	lw	$7,%lo(gCurrentShapes)($2)
	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,5
	subu	$2,$2,$19
	sra	$2,$2,1
	li	$3,276			# 0x00000114
	subu	$21,$3,$2
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	li	$5,106			# 0x0000006a
	li	$6,57			# 0x00000039
	li	$7,300			# 0x0000012c
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	lh	$3,92($18)
	li	$2,30			# 0x0000001e
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	LoadTrophy__17tScreenTrophyRoom
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$18,40
	.set	macro
	.set	reorder

	lw	$2,44($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L665
	li	$6,256			# 0x00000100
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($17)
	#nop
	sw	$2,144($18)
	li	$6,256			# 0x00000100
$L665:
	li	$7,47			# 0x0000002f
	lui	$4,%hi(tournamentManager+24) # high
	lw	$5,208($18)
	lbu	$3,290($16)
	lw	$8,%lo(tournamentManager+24)($4)
	sll	$5,$5,1
	addu	$5,$18,$5
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$8,$2
	lbu	$3,2($2)
	lbu	$2,212($5)
	lh	$4,92($18)
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$8
	lbu	$5,36($2)
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	sw	$2,20($sp)
	li	$2,4			# 0x00000004
	sw	$2,24($sp)
	sll	$5,$5,24
	sra	$5,$5,24
	addu	$5,$5,852
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$5,$2,%lo(gPadinfo) # low
	lbu	$3,5($5)
	li	$6,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$6,$L651
	li	$4,990			# 0x000003de
	.set	macro
	.set	reorder

	lbu	$2,37($5)
	#nop
	beq	$2,$3,$L650
	lbu	$2,36($5)
	#nop
	bne	$2,$0,$L650
$L651:
	lbu	$2,37($5)
	#nop
	bne	$2,$6,$L649
	beq	$3,$2,$L650
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L650:
	.set	noreorder
	.set	nomacro
	j	$L652
	li	$4,991			# 0x000003df
	.set	macro
	.set	reorder

$L649:
	lui	$2,%hi(gPadinfo) # high
$L666:
	addiu	$5,$2,%lo(gPadinfo) # low
	lbu	$2,5($5)
	li	$3,35			# 0x00000023
	beq	$2,$3,$L654
	lbu	$2,37($5)
	#nop
	bne	$2,$3,$L652
$L654:
	li	$4,992			# 0x000003e0
$L652:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$17,$0
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	addu	$20,$sp,56
	lh	$5,92($18)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,256			# 0x00000100
	li	$6,200			# 0x000000c8
	move	$7,$2
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
$L657:
	sll	$3,$17,16
	lh	$2,140($18)
	sra	$5,$3,16
	slt	$2,$5,$2
	beq	$2,$0,$L656
	div	$4,$5,$19
	mfhi	$3
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	subu	$2,$2,$3
	addu	$9,$21,$2
	move	$6,$9
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$3,$2,4
	subu	$3,$3,$2
	lw	$2,208($18)
	addu	$8,$3,70
	sll	$2,$2,1
	addu	$2,$18,$2
	lh	$2,212($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L659
	move	$7,$8
	.set	macro
	.set	reorder

	lhu	$2,58($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	li	$4,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	lw	$2,40($18)
	#nop
	sw	$2,76($sp)
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,144($18)
	ori	$4,$4,0xaaab
	subu	$2,$2,$3
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$10
	#nop
	#nop
	sra	$3,$10,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L660
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,31
$L660:
	sra	$4,$4,5
	sll	$4,$4,5
	subu	$4,$3,$4
	li	$5,1536			# 0x00000600
	move	$6,$9
	.set	noreorder
	.set	nomacro
	j	$L664
	sll	$7,$8,16
	.set	macro
	.set	reorder

$L659:
	sll	$4,$17,16
	sra	$4,$4,16
	li	$5,1536			# 0x00000600
	sll	$6,$6,16
	sra	$6,$6,16
	lw	$2,100($18)
	sll	$7,$7,16
	sw	$2,76($sp)
$L664:
	lh	$2,92($18)
	sra	$7,$7,16
	sw	$0,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L657
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L656:
 #APP
 #NO_APP
	lw	$31,104($sp)
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
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	DrawBackground__17tScreenTrophyRoom
	.align	2
	.globl	LoadTrophy__17tScreenTrophyRoom
	.ent	LoadTrophy__17tScreenTrophyRoom
LoadTrophy__17tScreenTrophyRoom:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$31,32($sp)
	sw	$16,24($sp)
	lw	$2,208($17)
	#nop
	sll	$2,$2,1
	addu	$5,$17,$2
	lh	$3,212($5)
	lbu	$2,156($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L667
	lui	$2,%hi(frontEnd+290) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$7,$16
	lbu	$3,%lo(frontEnd+290)($2)
	lw	$6,24($4)
	lbu	$5,212($5)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$6,$2
	lbu	$3,2($2)
	li	$2,-1			# 0xffffffff
	sw	$2,16($sp)
	addu	$3,$3,$5
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
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,208($17)
	#nop
	sll	$2,$2,1
	addu	$2,$17,$2
	lbu	$2,212($2)
	#nop
	sb	$2,156($17)
$L667:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	LoadTrophy__17tScreenTrophyRoom
	.globl	screenTrophyRoom
	.data
	.align	2
screenTrophyRoom:
	.space	4
	.globl	gSwapFileName
	.align	2
gSwapFileName:
	.space	16
