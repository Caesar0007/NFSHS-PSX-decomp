	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fevideowall.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	.ent	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	move	$9,$0
	sw	$5,0($8)
	sh	$7,4($8)
	sw	$6,8($8)
	sh	$0,26($8)
	sh	$0,24($8)
	sh	$0,20($8)
	lw	$3,16($sp)
	li	$2,-1			# 0xffffffff
	sh	$2,28($8)
	lui	$2,%hi(ticks) # high
	sh	$3,6($8)
	lw	$4,20($sp)
	lw	$6,24($sp)
	lw	$3,%lo(ticks)($2)
	lh	$5,6($8)
	li	$2,1			# 0x00000001
	sh	$2,30($8)
	sh	$0,32($8)
	sh	$2,34($8)
	sw	$0,40($8)
	sw	$4,12($8)
	sw	$3,16($8)
	.set	noreorder
	.set	nomacro
	blez	$5,$L603
	sh	$6,22($8)
	.set	macro
	.set	reorder

	sll	$3,$9,16
$L608:
	addu	$4,$9,1
	move	$9,$4
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	lw	$3,0($8)
	sll	$4,$4,16
	addu	$2,$2,$3
	sw	$0,0($2)
	lh	$2,6($8)
	sra	$4,$4,16
	slt	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L608
	sll	$3,$9,16
	.set	macro
	.set	reorder

$L603:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,52($8)
	.set	macro
	.set	reorder

	.end	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	.align	2
	.globl	UpdateImages__10tVideoWall
	.ent	UpdateImages__10tVideoWall
UpdateImages__10tVideoWall:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lh	$2,6($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L610
	move	$18,$0
	.set	macro
	.set	reorder

	sll	$2,$18,16
$L619:
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$17,$3,4
	lhu	$6,4($16)
	lw	$4,0($16)
	lw	$5,8($16)
	addu	$6,$6,$18
	sll	$6,$6,16
	addu	$4,$4,$17
	.set	noreorder
	.set	nomacro
	jal	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lw	$4,0($16)
	lhu	$3,24($16)
	addu	$4,$17,$4
	lhu	$2,20($4)
	#nop
	addu	$2,$2,$3
	sh	$2,20($4)
	lw	$4,0($16)
	lhu	$3,26($16)
	addu	$4,$17,$4
	lhu	$2,22($4)
	#nop
	addu	$2,$2,$3
	sh	$2,22($4)
	lh	$2,22($16)
	#nop
	blez	$2,$L614
	lw	$3,0($16)
	#nop
	addu	$3,$17,$3
	lhu	$2,8($3)
	#nop
	ori	$2,$2,0x0004
	sh	$2,8($3)
	lw	$2,0($16)
	lhu	$3,22($16)
	addu	$2,$17,$2
	sh	$3,44($2)
$L614:
	lh	$2,34($16)
	#nop
	beq	$2,$0,$L616
	lh	$2,30($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$2,$18,1
	.set	macro
	.set	reorder

$L616:
	lw	$3,0($16)
	#nop
	addu	$3,$17,$3
	lhu	$2,8($3)
	#nop
	ori	$2,$2,0x0028
	sh	$2,8($3)
	addu	$2,$18,1
$L618:
	move	$18,$2
	sll	$2,$2,16
	lh	$3,6($16)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	sll	$2,$18,16
	.set	macro
	.set	reorder

$L610:
	li	$2,1			# 0x00000001
	sw	$2,52($16)
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

	.end	UpdateImages__10tVideoWall
	.align	2
	.globl	SetAvailableText__10tVideoWallsss
	.ent	SetAvailableText__10tVideoWallsss
SetAvailableText__10tVideoWallsss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	sh	$5,28($4)
	sh	$6,36($4)
	sh	$7,38($4)
	sh	$0,32($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,30($4)
	.set	macro
	.set	reorder

	.end	SetAvailableText__10tVideoWallsss
	.align	2
	.globl	SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
	.ent	SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,16($sp)
	lw	$2,20($sp)
	sh	$5,44($4)
	sh	$6,46($4)
	sh	$7,48($4)
	sw	$2,40($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$3,50($4)
	.set	macro
	.set	reorder

	.end	SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
	.align	2
	.globl	SetOffset__10tVideoWallss
	.ent	SetOffset__10tVideoWallss
SetOffset__10tVideoWallss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sh	$5,24($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$6,26($4)
	.set	macro
	.set	reorder

	.end	SetOffset__10tVideoWallss
	.align	2
	.globl	SetAvailable__10tVideoWalls
	.ent	SetAvailable__10tVideoWalls
SetAvailable__10tVideoWalls:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,30($4)
	.set	macro
	.set	reorder

	.end	SetAvailable__10tVideoWalls
	.align	2
	.globl	SetValid__10tVideoWalls
	.ent	SetValid__10tVideoWalls
SetValid__10tVideoWalls:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,34($4)
	.set	macro
	.set	reorder

	.end	SetValid__10tVideoWalls
	.align	2
	.globl	UpdateTransition__10tVideoWall
	.ent	UpdateTransition__10tVideoWall
UpdateTransition__10tVideoWall:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$3,16($17)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,3
	lh	$2,20($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L626
	move	$19,$3
	.set	macro
	.set	reorder

	lh	$2,34($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	sll	$2,$3,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L625
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$2
	sll	$3,$16,16
$L645:
	lh	$2,6($17)
	sra	$4,$3,16
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L625
	sll	$2,$4,1
	.set	macro
	.set	reorder

	lw	$3,12($17)
	#nop
	addu	$2,$2,$3
	lh	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,0($17)
	sll	$2,$2,4
	addu	$4,$2,$3
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L646
	addu	$2,$16,1
	.set	macro
	.set	reorder

	lh	$2,34($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	addu	$2,$16,1
	.set	macro
	.set	reorder

	lh	$2,30($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	addu	$2,$16,1
	.set	macro
	.set	reorder

	jal	TurnOnTV__FR9tTVConfig
	addu	$2,$16,1
$L646:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L625
	sll	$3,$16,16
	.set	macro
	.set	reorder

	j	$L645
$L627:
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	.set	noreorder
	.set	nomacro
	j	$L625
	sw	$2,16($17)
	.set	macro
	.set	reorder

$L626:
	sll	$2,$3,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L638
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$2
	sll	$3,$16,16
$L648:
	lh	$2,6($17)
	sra	$4,$3,16
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	sll	$2,$4,1
	.set	macro
	.set	reorder

	lw	$3,12($17)
	#nop
	addu	$2,$2,$3
	lh	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,0($17)
	sll	$2,$2,4
	addu	$4,$2,$3
	lw	$3,0($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L647
	addu	$2,$16,1
	.set	macro
	.set	reorder

	jal	TurnOffTV__FR9tTVConfig
	addu	$2,$16,1
$L647:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	sll	$3,$16,16
	.set	macro
	.set	reorder

$L638:
	sll	$2,$19,16
	lh	$3,6($17)
	sra	$2,$2,16
	slt	$2,$2,$3
	bne	$2,$0,$L625
	sh	$0,20($17)
$L625:
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

	.end	UpdateTransition__10tVideoWall
	.align	2
	.globl	Draw__10tVideoWall
	.ent	Draw__10tVideoWall
Draw__10tVideoWall:
	.frame	$sp,72,$31		# vars= 24, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,60($sp)
	move	$17,$4
	sw	$31,68($sp)
	sw	$18,64($sp)
	sw	$16,56($sp)
	lh	$2,30($17)
	#nop
	bne	$2,$0,$L651
	lh	$2,34($17)
	#nop
	bne	$2,$0,$L650
$L651:
	lhu	$2,32($17)
	.set	noreorder
	.set	nomacro
	j	$L672
	addu	$2,$2,-4
	.set	macro
	.set	reorder

$L650:
	lhu	$2,32($17)
	#nop
	addu	$2,$2,4
$L672:
	sh	$2,32($17)
	lh	$3,32($17)
	#nop
	slt	$2,$3,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L654
	sh	$2,32($17)
	.set	macro
	.set	reorder

$L653:
	bgez	$3,$L654
	sh	$0,32($17)
$L654:
	lh	$2,34($17)
	#nop
	beq	$2,$0,$L657
	lh	$2,30($17)
	#nop
	beq	$2,$0,$L657
	lh	$2,32($17)
	#nop
	beq	$2,$0,$L656
$L657:
	lh	$2,6($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L658
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$16,16
$L673:
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	lw	$2,0($17)
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	DrawTVLines__FR9tTVConfig
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	lh	$3,6($17)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L658:
	lh	$2,32($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L656
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	li	$18,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	subu	$5,$18,$2
	.set	macro
	.set	reorder

	lw	$3,40($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L664
	move	$16,$2
	.set	macro
	.set	reorder

	lh	$2,46($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L664
	li	$2,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	sw	$2,36($sp)
	lw	$2,40($17)
	#nop
	sw	$2,52($sp)
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lh	$3,46($17)
	sra	$2,$2,4
	rem	$8,$2,$3
	li	$5,1553			# 0x00000611
	lh	$4,44($17)
	lh	$6,48($17)
	lh	$7,50($17)
	lh	$3,32($17)
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	addu	$2,$sp,32
	sw	$2,24($sp)
	subu	$3,$18,$3
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,$8
	.set	macro
	.set	reorder

$L664:
	lh	$2,28($17)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L656
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	move	$5,$4
	.set	macro
	.set	reorder

	lh	$4,28($17)
	jal	TextSys_Word__Fi
	move	$4,$2
	move	$7,$16
	lh	$5,36($17)
	lh	$6,38($17)
	li	$2,3			# 0x00000003
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	move	$5,$4
	.set	macro
	.set	reorder

$L656:
	lw	$2,52($17)
	#nop
	bne	$2,$0,$L667
	lh	$2,34($17)
	#nop
	beq	$2,$0,$L667
	lh	$2,30($17)
	#nop
	bne	$2,$0,$L649
$L667:
	lh	$2,6($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L649
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$16,16
$L674:
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	lw	$2,0($17)
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	DrawTV__FR9tTVConfig
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	lh	$3,6($17)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L649:
	lw	$31,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Draw__10tVideoWall
	.align	2
	.globl	TurnOff__10tVideoWall
	.ent	TurnOff__10tVideoWall
TurnOff__10tVideoWall:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,20($4)
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L677
	lui	$2,%hi(ticksA) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticksA)($2)
	sh	$3,20($4)
	sw	$2,16($4)
$L677:
	j	$31
	.end	TurnOff__10tVideoWall
	.align	2
	.globl	TurnOffInstant__10tVideoWall
	.ent	TurnOffInstant__10tVideoWall
TurnOffInstant__10tVideoWall:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lh	$2,6($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L678
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$16,16
$L684:
	sra	$2,$2,16
	sll	$4,$2,1
	addu	$4,$4,$2
	lw	$2,0($17)
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	TurnOffTV__FR9tTVConfig
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	lh	$3,6($17)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L678:
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

	.end	TurnOffInstant__10tVideoWall
	.align	2
	.globl	TurnOn__10tVideoWall
	.ent	TurnOn__10tVideoWall
TurnOn__10tVideoWall:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,20($4)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L687
	lui	$2,%hi(ticksA) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticksA)($2)
	sh	$3,20($4)
	sw	$2,16($4)
$L687:
	j	$31
	.end	TurnOn__10tVideoWall
