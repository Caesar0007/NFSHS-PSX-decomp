	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screencarselect.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.data
	.align	2
gKnots:
	.word	491520
	.word	-524288
	.word	17039360
	.word	131072
	.word	0
	.word	491520
	.word	-524288
	.word	17039360
	.word	131072
	.word	0
	.word	196608
	.word	-524288
	.word	17039360
	.word	6684672
	.word	11206656
	.word	196608
	.word	-524288
	.word	17039360
	.word	6684672
	.word	22347776
	.word	688128
	.word	-524288
	.word	17039360
	.word	-4718592
	.word	33554432
	.word	196608
	.word	-524288
	.word	17039360
	.word	6684672
	.word	44761088
	.word	196608
	.word	-524288
	.word	17039360
	.word	6684672
	.word	55902208
	.word	196608
	.word	-524288
	.word	17039360
	.word	6684672
	.word	55902208
	.align	2
gCatmullRom:
	.word	-65536
	.word	196608
	.word	-196608
	.word	65536
	.word	131072
	.word	-327680
	.word	262144
	.word	-65536
	.word	-65536
	.word	0
	.word	65536
	.word	0
	.word	0
	.word	131072
	.word	0
	.word	0
	.align	2
remap:
	.word	0
	.word	2
	.word	1
	.word	3
	.word	4
	.align	2
gStateOverlays:
	.byte	-1
	.byte	6
	.byte	0
	.byte	-1
	.byte	4
	.byte	6
	.byte	0
	.byte	-1
	.byte	-1
	.byte	6
	.byte	2
	.byte	-1
	.byte	4
	.byte	6
	.byte	1
	.byte	-1
	.byte	-1
	.byte	6
	.byte	3
	.byte	5
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.align	2
gOverlayPositions:
	.byte	34
	.byte	1
	.byte	0
	.byte	1
	.byte	200
	.byte	0
	.byte	12
	.byte	0
	.byte	34
	.byte	1
	.byte	200
	.byte	0
	.byte	200
	.byte	0
	.byte	12
	.byte	0
	.byte	213
	.byte	0
	.byte	0
	.byte	1
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	213
	.byte	0
	.byte	185
	.byte	0
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	213
	.byte	0
	.byte	0
	.byte	1
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	213
	.byte	0
	.byte	185
	.byte	0
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	213
	.byte	0
	.byte	0
	.byte	1
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	213
	.byte	0
	.byte	185
	.byte	0
	.byte	32
	.byte	1
	.byte	41
	.byte	0
	.byte	69
	.byte	1
	.byte	5
	.byte	0
	.byte	162
	.byte	0
	.byte	24
	.byte	0
	.byte	69
	.byte	1
	.byte	29
	.byte	0
	.byte	162
	.byte	0
	.byte	24
	.byte	0
	.byte	239
	.byte	1
	.byte	21
	.byte	0
	.byte	3
	.byte	0
	.byte	3
	.byte	0
	.byte	213
	.byte	0
	.byte	21
	.byte	0
	.byte	29
	.byte	1
	.byte	105
	.byte	0
	.byte	136
	.byte	255
	.byte	136
	.byte	0
	.byte	130
	.byte	0
	.byte	77
	.byte	0
	.byte	0
	.byte	0
	.byte	136
	.byte	0
	.byte	130
	.byte	0
	.byte	77
	.byte	0
	.text
	.align	2
	.globl	TransformVector
	.ent	TransformVector
TransformVector:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$22,40($sp)
	move	$22,$6
	sw	$19,28($sp)
	move	$19,$0
	sw	$31,44($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L604:
	sll	$2,$19,16
	sra	$2,$2,14
	addu	$3,$2,$22
	sw	$0,0($3)
	move	$16,$0
	move	$18,$2
	move	$17,$3
$L608:
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$20
	sll	$2,$2,4
	addu	$2,$2,$21
	addu	$2,$18,$2
	lw	$4,0($3)
	lw	$5,0($2)
	jal	fixedmult
	addu	$3,$16,1
	move	$16,$3
	sll	$3,$3,16
	sra	$3,$3,16
	lw	$4,0($17)
	slt	$3,$3,4
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L608
	sw	$4,0($17)
	.set	macro
	.set	reorder

	addu	$2,$19,1
	move	$19,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	bne	$2,$0,$L604
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	TransformVector
	.align	2
	.globl	DrawCar__FR8tCarInfossffcbUl7tPlayer
	.ent	DrawCar__FR8tCarInfossffcbUl7tPlayer
DrawCar__FR8tCarInfossffcbUl7tPlayer:
	.frame	$sp,80,$31		# vars= 0, regs= 7/0, args= 48, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	subu	$sp,$sp,80
	sw	$17,52($sp)
	lw	$17,112($sp)
	sw	$19,60($sp)
	lbu	$19,100($sp)
	move	$8,$4
	sw	$21,68($sp)
	move	$21,$7
	sw	$18,56($sp)
	move	$18,$5
	sw	$20,64($sp)
	move	$20,$6
	sw	$31,72($sp)
	sw	$16,48($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$3,$L612
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$2,$3,2047
$L612:
	sra	$3,$2,11
	sll	$2,$3,11
	subu	$3,$4,$2
	lui	$2,%hi(DrawC_gMenuLights) # high
	sw	$0,%lo(DrawC_gMenuLights)($2)
	sltu	$2,$3,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	lui	$2,%hi(DrawC_gMenuLightsDirection) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	sw	$0,%lo(DrawC_gMenuLightsDirection)($2)
	.set	macro
	.set	reorder

$L613:
	lui	$3,%hi(DrawC_gMenuLightsDirection) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(DrawC_gMenuLightsDirection)($3)
$L614:
	lb	$2,0($8)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L611
	lui	$16,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(gCarObj) # low
	sll	$5,$17,2
	addu	$16,$5,$16
	lw	$2,0($16)
	lbu	$4,197($8)
	lw	$3,648($2)
	lbu	$2,1($8)
	#nop
	sw	$2,0($3)
	lw	$2,0($16)
	#nop
	lw	$3,648($2)
	lbu	$2,199($8)
	#nop
	sw	$2,160($3)
	lui	$2,%hi(gMenuRotate) # high
	addiu	$2,$2,%lo(gMenuRotate) # low
	addu	$5,$5,$2
	lw	$2,0($5)
	#nop
	addu	$2,$2,3
	sw	$2,0($5)
	lbu	$2,196($8)
	lw	$3,0($16)
	srl	$2,$2,2
	lw	$3,648($3)
	andi	$2,$2,0x0001
	sw	$2,60($3)
	lbu	$2,196($8)
	lw	$3,0($16)
	srl	$2,$2,1
	lw	$3,648($3)
	andi	$2,$2,0x0001
	sw	$2,64($3)
	lw	$3,0($16)
	lbu	$2,196($8)
	lw	$3,648($3)
	andi	$2,$2,0x0001
	sw	$2,68($3)
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	DrawC_MenuColorData__FiP8Car_tObji
	move	$6,$17
	.set	macro
	.set	reorder

	lui	$5,%hi(gCView) # high
	addiu	$5,$5,%lo(gCView) # low
	lw	$2,108($sp)
	sll	$6,$18,16
	sw	$2,24($sp)
	lw	$2,96($sp)
	sra	$6,$6,16
	sw	$2,32($sp)
	andi	$2,$19,0x00ff
	sw	$2,36($sp)
	lw	$2,104($sp)
	sll	$7,$20,16
	sw	$17,16($sp)
	sw	$0,20($sp)
	sw	$21,28($sp)
	sw	$2,40($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
	sra	$7,$7,16
	.set	macro
	.set	reorder

$L611:
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

	.end	DrawCar__FR8tCarInfossffcbUl7tPlayer
	.align	2
	.globl	__16tScreenCarSelect
	.ent	__16tScreenCarSelect
__16tScreenCarSelect:
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

	move	$4,$0
	lui	$2,%hi(gOverlayPositions) # high
	addiu	$6,$2,%lo(gOverlayPositions) # low
	li	$5,6			# 0x00000006
	lui	$2,%hi(tScreenCarSelect_vtable) # high
	addiu	$2,$2,%lo(tScreenCarSelect_vtable) # low
	sw	$2,96($16)
	li	$2,-1			# 0xffffffff
	sh	$0,286($16)
	sh	$2,288($16)
	sh	$0,290($16)
$L620:
	sll	$2,$4,16
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,100
	addu	$3,$16,$3
	sll	$2,$2,4
	addu	$2,$2,$6
	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	swl	$7,3($3)
	swr	$7,0($3)
	swl	$8,7($3)
	swr	$8,4($3)
	lwl	$7,11($2)
	lwr	$7,8($2)
	lwl	$8,15($2)
	lwr	$8,12($2)
	swl	$7,11($3)
	swr	$7,8($3)
	swl	$8,15($3)
	swr	$8,12($3)
	addu	$2,$4,1
	sh	$4,22($3)
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,7
	sh	$0,20($3)
	sh	$0,16($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	sh	$5,18($3)
	.set	macro
	.set	reorder

	move	$4,$0
	sll	$2,$4,16
$L628:
	sra	$2,$2,14
	addu	$2,$16,$2
	sw	$0,268($2)
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	sll	$2,$4,16
	.set	macro
	.set	reorder

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

	.end	__16tScreenCarSelect
	.align	2
	.globl	_._16tScreenCarSelect
	.ent	_._16tScreenCarSelect
_._16tScreenCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tScreenCarSelect_vtable) # high
	addiu	$2,$2,%lo(tScreenCarSelect_vtable) # low
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

	.end	_._16tScreenCarSelect
	.align	2
	.globl	Cleanup__16tScreenCarSelect
	.ent	Cleanup__16tScreenCarSelect
Cleanup__16tScreenCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CleanupSpinningCarsMenu__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,120($2)
	lw	$2,124($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
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

	.end	Cleanup__16tScreenCarSelect
	.rdata
	.align	2
$LC0:
	.half	2
	.half	3
	.half	1
	.align	2
$LC1:
	.half	2
	.half	4
	.half	1
	.text
	.align	2
	.globl	DrawOverlay__16tScreenCarSelectP8tOverlay
	.ent	DrawOverlay__16tScreenCarSelectP8tOverlay
DrawOverlay__16tScreenCarSelectP8tOverlay:
	.frame	$sp,320,$31		# vars= 264, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,320
	sw	$18,304($sp)
	sw	$19,308($sp)
	move	$19,$5
	lui	$2,%hi($LC0) # high
	sw	$31,312($sp)
	sw	$17,300($sp)
	sw	$16,296($sp)
	addiu	$15,$2,%lo($LC0)
	lwl	$12,3($15)
	lwr	$12,0($15)
	lh	$13,4($15)
	swl	$12,283($sp)
	swr	$12,280($sp)
	sh	$13,284($sp)
	lui	$2,%hi($LC1) # high
	addiu	$15,$2,%lo($LC1)
	lwl	$12,3($15)
	lwr	$12,0($15)
	lh	$13,4($15)
	swl	$12,291($sp)
	swr	$12,288($sp)
	sh	$13,292($sp)
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L632
	move	$18,$4
	.set	macro
	.set	reorder

	lw	$2,96($18)
	addu	$5,$sp,48
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	move	$17,$2
	lh	$2,20($19)
	lhu	$3,20($19)
	beq	$2,$0,$L638
	lhu	$2,18($19)
	#nop
	mult	$2,$3
	lhu	$2,16($19)
	mflo	$12
	#nop
	#nop
	addu	$2,$2,$12
	sh	$2,16($19)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L635
	slt	$2,$2,128
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L636
	sh	$0,16($19)
	.set	macro
	.set	reorder

$L635:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,16($19)
$L636:
	sh	$0,20($19)
$L638:
	lh	$2,8($19)
	lh	$3,0($19)
	lh	$4,16($19)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,0($19)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L639
	addu	$2,$2,127
$L639:
	sra	$2,$2,7
	addu	$2,$3,$2
	sh	$2,32($sp)
	lh	$2,10($19)
	lh	$3,2($19)
	lh	$4,16($19)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,2($19)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L640
	addu	$2,$2,127
$L640:
	sra	$2,$2,7
	addu	$2,$3,$2
	sh	$2,34($sp)
	lh	$2,12($19)
	lh	$3,4($19)
	lh	$4,16($19)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,4($19)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L641
	addu	$2,$2,127
$L641:
	sra	$2,$2,7
	addu	$2,$3,$2
	sh	$2,36($sp)
	lh	$2,14($19)
	lh	$3,6($19)
	lh	$4,16($19)
	subu	$2,$2,$3
	mult	$4,$2
	lhu	$3,6($19)
	mflo	$2
	#nop
	#nop
	bgez	$2,$L642
	addu	$2,$2,127
$L642:
	sra	$2,$2,7
	addu	$2,$3,$2
	sh	$2,38($sp)
	lh	$3,22($19)
	#nop
	sltu	$2,$3,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	lui	$2,%hi($L690) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L690) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L690:
	.word	$L644
	.word	$L648
	.word	$L648
	.word	$L648
	.word	$L660
	.word	$L666
	.word	$L678
	.text
$L644:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L643
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lb	$4,48($sp)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	addu	$4,$4,289
	.set	macro
	.set	reorder

	j	$L643
$L648:
	lhu	$3,32($sp)
	lhu	$6,34($sp)
	li	$2,23			# 0x00000017
	sh	$2,46($sp)
	lhu	$2,38($sp)
	addu	$5,$3,15
	addu	$2,$6,$2
	lhu	$3,36($sp)
	addu	$2,$2,-30
	sh	$5,40($sp)
	sh	$2,42($sp)
	addu	$3,$3,-30
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L649
	sh	$3,44($sp)
	.set	macro
	.set	reorder

	addu	$5,$5,$3
	addu	$5,$5,-12
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,2
	sll	$6,$6,16
	sra	$6,$6,16
	li	$7,1			# 0x00000001
	lbu	$4,48($sp)
	move	$2,$7
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	sll	$4,$4,24
	sra	$4,$4,24
	addu	$4,$4,289
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$4,$4,16
	.set	macro
	.set	reorder

$L649:
	lh	$3,22($19)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L650
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L651
	li	$16,140			# 0x0000008c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	li	$16,142			# 0x0000008e
	.set	macro
	.set	reorder

$L650:
	li	$16,141			# 0x0000008d
$L651:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L654
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lh	$3,22($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L655
	li	$17,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	lw	$7,80($sp)
	.set	noreorder
	.set	nomacro
	j	$L694
	li	$18,2293760			# 0x00230000
	.set	macro
	.set	reorder

$L655:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L657
	lui	$2,%hi(frontEnd+297) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	lh	$2,7996($2)
	#nop
	sll	$2,$2,1
	addu	$2,$sp,$2
	lh	$2,280($2)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	lw	$7,80($2)
	.set	noreorder
	.set	nomacro
	j	$L694
	li	$18,2293760			# 0x00230000
	.set	macro
	.set	reorder

$L657:
	lbu	$5,%lo(frontEnd+297)($2)
	lui	$4,%hi(carManager) # high
	.set	noreorder
	.set	nomacro
	jal	CalcUsedPrice__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L659
	move	$7,$2
	.set	macro
	.set	reorder

$L654:
	li	$17,2293760			# 0x00230000
	ori	$17,$17,0x2323
	move	$7,$0
$L659:
	li	$18,2293760			# 0x00230000
$L694:
	ori	$18,$18,0x2323
	lh	$4,40($sp)
	lh	$2,44($sp)
	lh	$5,42($sp)
	li	$6,6			# 0x00000006
	sw	$17,16($sp)
	sw	$18,20($sp)
	addu	$4,$4,$2
	addu	$4,$4,-12
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	addu	$5,$5,3
	.set	macro
	.set	reorder

	move	$4,$16
	li	$7,1			# 0x00000001
	move	$17,$7
	lhu	$2,44($sp)
	lhu	$5,40($sp)
	lhu	$6,42($sp)
	li	$16,3			# 0x00000003
	sw	$17,16($sp)
	sw	$16,20($sp)
	sll	$2,$2,16
	sra	$2,$2,17
	addu	$5,$5,$2
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,$16
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lh	$4,40($sp)
	lh	$3,44($sp)
	lh	$5,42($sp)
	li	$2,48830			# 0x0000bebe
	sw	$2,16($sp)
	lui	$2,%hi(tournamentManager+20) # high
	lw	$7,%lo(tournamentManager+20)($2)
	li	$6,9			# 0x00000009
	sw	$18,20($sp)
	addu	$4,$4,$3
	addu	$4,$4,-12
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	addu	$5,$5,13
	.set	macro
	.set	reorder

	li	$4,123			# 0x0000007b
	lhu	$2,44($sp)
	lhu	$5,40($sp)
	lhu	$6,42($sp)
	li	$7,1			# 0x00000001
	sw	$17,16($sp)
	sw	$16,20($sp)
	sll	$2,$2,16
	sra	$2,$2,17
	addu	$5,$5,$2
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,13
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4Rectangle__FR4RECT
	addu	$4,$sp,40
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,32($sp)
	lh	$6,34($sp)
	lh	$7,36($sp)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	j	$L643
$L660:
	move	$16,$0
	sll	$2,$16,16
$L695:
	sra	$6,$2,16
	slt	$2,$6,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$3,$sp,288
	addu	$5,$3,$2
	lbu	$11,244($sp)
	lh	$2,0($5)
	#nop
	and	$2,$11,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,96			# 0x00000060
$L665:
 #APP
 #NO_APP
	li	$3,1717960704			# 0x66660000
	ori	$3,$3,0x6667
	li	$2,48830			# 0x0000bebe
	addu	$16,$16,1
	sw	$2,260($sp)
	lui	$2,%hi(ticks) # high
	lh	$5,0($5)
	lh	$10,32($sp)
	lh	$7,34($sp)
	lw	$9,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	addu	$2,$sp,256
	sw	$4,16($sp)
	sll	$4,$6,2
	sra	$8,$9,4
	mult	$8,$3
	addu	$4,$4,$6
	sll	$6,$4,3
	addu	$6,$6,33
	sll	$4,$4,1
	sw	$2,24($sp)
	and	$5,$11,$5
	sltu	$5,$5,1
	ori	$5,$5,0x0410
	addu	$6,$10,$6
	addu	$7,$7,6
	sra	$9,$9,31
	mfhi	$12
	#nop
	#nop
	sra	$3,$12,2
	subu	$3,$3,$9
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$8,$8,$2
	addu	$8,$8,98
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L695
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L666:
	lh	$3,16($19)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L667
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$16,16
$L696:
	sra	$6,$2,16
	slt	$2,$6,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$3,$sp,288
	addu	$5,$3,$2
	lbu	$11,244($sp)
	lh	$2,0($5)
	#nop
	and	$2,$11,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L672
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,96			# 0x00000060
$L672:
 #APP
 #NO_APP
	li	$3,1717960704			# 0x66660000
	ori	$3,$3,0x6667
	li	$2,48830			# 0x0000bebe
	addu	$16,$16,1
	sw	$2,260($sp)
	lui	$2,%hi(ticks) # high
	lh	$5,0($5)
	lh	$10,32($sp)
	lh	$7,34($sp)
	lw	$9,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	addu	$2,$sp,256
	sw	$4,16($sp)
	sll	$4,$6,2
	sra	$8,$9,4
	mult	$8,$3
	addu	$4,$4,$6
	sll	$6,$4,3
	addu	$6,$6,133
	sll	$4,$4,1
	sw	$2,24($sp)
	and	$5,$11,$5
	sltu	$5,$5,1
	ori	$5,$5,0x0410
	addu	$6,$10,$6
	addu	$7,$7,6
	sra	$9,$9,31
	mfhi	$12
	#nop
	#nop
	sra	$3,$12,2
	subu	$3,$3,$9
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$8,$8,$2
	addu	$8,$8,98
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,$8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L696
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L669:
	li	$7,2			# 0x00000002
	lui	$16,%hi(menuDefs) # high
	lhu	$4,36($sp)
	lhu	$3,32($sp)
	lhu	$2,34($sp)
	sll	$5,$4,16
	sra	$5,$5,17
	addu	$5,$3,$5
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$2,24
	sll	$6,$6,16
	sra	$6,$6,16
	addu	$2,$2,35
	sh	$2,42($sp)
	lhu	$2,38($sp)
	addu	$3,$3,30
	sh	$3,40($sp)
	lw	$3,%lo(menuDefs)($16)
	addu	$4,$4,-60
	sh	$4,44($sp)
	addu	$2,$2,-75
	sh	$2,46($sp)
	#.set	volatile
	lw	$4,7996($3)
	#.set	novolatile
	move	$2,$7
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	addu	$4,$4,150
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$4,$4,16
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($16)
	#nop
	lh	$2,7996($2)
	#nop
	addu	$4,$2,175
	li	$2,176			# 0x000000b0
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L673
	li	$2,12			# 0x0000000c
	.set	macro
	.set	reorder

	lb	$3,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L674
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L697
	sll	$4,$4,16
	.set	macro
	.set	reorder

$L674:
	li	$4,65			# 0x00000041
$L673:
	sll	$4,$4,16
$L697:
	sra	$4,$4,16
	addu	$5,$sp,40
	li	$6,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	lh	$2,7996($2)
	#nop
	sll	$2,$2,1
	addu	$3,$sp,$2
	lbu	$2,244($sp)
	lh	$3,288($3)
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	li	$16,160			# 0x000000a0
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo+5) # high
	lbu	$3,%lo(gPadinfo+5)($2)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L675
	li	$16,158			# 0x0000009e
	.set	macro
	.set	reorder

	li	$16,159			# 0x0000009f
$L675:
	move	$4,$16
	li	$7,1			# 0x00000001
	lhu	$5,32($sp)
	lhu	$3,36($sp)
	lhu	$6,34($sp)
	lhu	$8,38($sp)
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	addu	$5,$5,$3
	addu	$5,$5,-15
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,$8
	addu	$6,$6,-20
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L667:
	lh	$2,36($sp)
	lhu	$5,36($sp)
	slt	$2,$2,67
	bne	$2,$0,$L643
	lh	$2,38($sp)
	lhu	$3,38($sp)
	slt	$2,$2,51
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	addu	$4,$sp,40
	.set	macro
	.set	reorder

	addu	$2,$5,-30
	sh	$2,44($sp)
	addu	$2,$3,-25
	sh	$2,46($sp)
	lhu	$2,32($sp)
	lhu	$3,34($sp)
	addu	$2,$2,15
	addu	$3,$3,20
	sh	$2,40($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4Rectangle__FR4RECT
	sh	$3,42($sp)
	.set	macro
	.set	reorder

	j	$L643
$L678:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L698
	move	$4,$18
	.set	macro
	.set	reorder

	move	$16,$0
	addu	$6,$sp,48
	move	$4,$0
$L699:
	sll	$2,$16,16
	sra	$5,$2,16
$L687:
	sll	$2,$4,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	addu	$3,$5,$3
	addu	$3,$6,$3
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	sb	$0,48($3)
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L698:
	addu	$5,$sp,48
	lhu	$6,32($sp)
	lhu	$7,34($sp)
	addu	$6,$6,13
	sll	$6,$6,16
	sra	$6,$6,16
	addu	$7,$7,4
	sll	$7,$7,16
	.set	noreorder
	.set	nomacro
	jal	DrawSliders__16tScreenCarSelectR8tCarInfoss
	sra	$7,$7,16
	.set	macro
	.set	reorder

$L643:
	lh	$2,22($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4TransRectangle__FR4RECTs
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L632:
	lw	$31,312($sp)
	lw	$19,308($sp)
	lw	$18,304($sp)
	lw	$17,300($sp)
	lw	$16,296($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,320
	.set	macro
	.set	reorder

	.end	DrawOverlay__16tScreenCarSelectP8tOverlay
	.align	2
	.globl	SetState__16tScreenCarSelecti
	.ent	SetState__16tScreenCarSelecti
SetState__16tScreenCarSelecti:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,28($sp)
	sw	$18,24($sp)
	lh	$2,284($16)
	lhu	$18,284($16)
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L701
	addu	$2,$18,-2
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L702
	sh	$17,284($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sh	$2,286($16)
	sh	$2,288($16)
$L702:
	move	$6,$0
	lui	$2,%hi(gStateOverlays) # high
	addiu	$8,$2,%lo(gStateOverlays) # low
	sll	$7,$17,2
	li	$9,-1			# 0xffffffff
	sll	$2,$6,16
$L730:
	sra	$3,$2,16
	sll	$2,$3,2
	addu	$5,$16,$2
	lw	$4,268($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L706
	addu	$2,$3,$7
	.set	macro
	.set	reorder

	addu	$2,$2,$8
	lh	$3,22($4)
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L729
	addu	$2,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L729
	sh	$9,20($4)
	.set	macro
	.set	reorder

$L706:
	addu	$2,$2,$8
	lb	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L708
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,100
	addu	$2,$16,$2
	sw	$2,268($5)
	sh	$0,16($2)
	lw	$3,268($5)
	li	$2,1			# 0x00000001
	sh	$2,20($3)
$L708:
	addu	$2,$6,1
$L729:
	move	$6,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L730
	sll	$2,$6,16
	.set	macro
	.set	reorder

$L701:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L712
	slt	$2,$17,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	slt	$2,$17,7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L731
	addu	$2,$17,-5
	.set	macro
	.set	reorder

	j	$L700
$L713:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	slt	$2,$17,5
	.set	macro
	.set	reorder

	bne	$2,$0,$L700
$L712:
	addu	$2,$17,-5
$L731:
	sltu	$2,$2,2
	lui	$3,%hi(gStopCommentaryNow) # high
	sw	$2,904($16)
	lui	$2,%hi(ticks) # high
	#.set	volatile
	lw	$4,%lo(ticks)($2)
	#.set	novolatile
	#.set	volatile
	lw	$5,%lo(ticks)($2)
	#.set	novolatile
	lw	$6,904($16)
	li	$2,1			# 0x00000001
	sw	$2,%lo(gStopCommentaryNow)($3)
	sw	$0,916($16)
	sw	$4,912($16)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L717
	sw	$5,908($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,1000			# 0x000003e8
	.set	macro
	.set	reorder

	move	$6,$0
	lui	$2,%hi(gKnots) # high
	addiu	$2,$2,%lo(gKnots) # low
	lw	$3,924($16)
	move	$7,$2
	sw	$0,920($16)
	andi	$3,$3,0x03ff
	sw	$3,36($7)
$L718:
	sll	$4,$6,16
	sra	$4,$4,14
	addu	$4,$4,$7
	addu	$3,$6,1
	move	$6,$3
	sll	$3,$3,16
	sra	$3,$3,16
	lw	$5,40($4)
	lw	$2,20($4)
	slt	$3,$3,5
	subu	$5,$5,$2
	subu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L718
	sw	$2,0($4)
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,2			# 0x00000002
	move	$6,$0
	lui	$7,%hi(gRotateOffset) # high
	addiu	$3,$7,%lo(gRotateOffset) # low
	li	$2,65536			# 0x00010000
	sw	$2,12($3)
	sw	$2,8($3)
	sw	$2,4($3)
	.set	noreorder
	.set	nomacro
	jal	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	sw	$2,%lo(gRotateOffset)($7)
	.set	macro
	.set	reorder

	j	$L700
$L717:
	move	$6,$0
$L723:
	sll	$2,$6,16
	addu	$4,$6,1
	move	$6,$4
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,4
	addu	$3,$16,$3
	sll	$4,$4,16
	sra	$4,$4,16
	slt	$4,$4,10
	sw	$0,292($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L723
	sh	$0,296($3)
	.set	macro
	.set	reorder

	sll	$2,$18,16
	sra	$2,$2,16
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L727
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
	move	$6,$0
	.set	macro
	.set	reorder

$L727:
	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

$L700:
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

	.end	SetState__16tScreenCarSelecti
	.align	2
	.globl	CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
	.ent	CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46:
	.frame	$sp,168,$31		# vars= 112, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	lw	$4,188($sp)
	sw	$17,132($sp)
	move	$17,$5
	sw	$19,140($sp)
	move	$19,$6
	sw	$21,148($sp)
	move	$21,$7
	sw	$22,152($sp)
	lw	$22,184($sp)
	li	$5,39321600			# 0x02580000
	sw	$31,160($sp)
	sw	$23,156($sp)
	sw	$20,144($sp)
	sw	$18,136($sp)
	sw	$16,128($sp)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sll	$4,$4,16
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$4,24($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$4,20($sp)
	.set	macro
	.set	reorder

	move	$6,$0
	addu	$11,$sp,32
	lui	$3,%hi(gKnots) # high
	addiu	$5,$3,%lo(gKnots) # low
	sll	$3,$17,2
	addu	$3,$3,$17
	sll	$10,$3,2
	sll	$3,$19,2
	addu	$3,$3,$19
	sll	$9,$3,2
	sll	$3,$21,2
	addu	$3,$3,$21
	sll	$8,$3,2
	sll	$3,$22,2
	addu	$3,$3,$22
	sll	$7,$3,2
	sw	$2,16($sp)
	li	$2,65536			# 0x00010000
	sw	$2,28($sp)
$L733:
	sll	$3,$6,16
	sra	$3,$3,14
	addu	$2,$3,$10
	addu	$2,$2,$5
	lw	$2,0($2)
	addu	$4,$11,$3
	sw	$2,0($4)
	addu	$2,$3,$9
	addu	$2,$2,$5
	lw	$2,0($2)
	#nop
	sw	$2,16($4)
	addu	$2,$3,$8
	addu	$2,$2,$5
	addu	$3,$3,$7
	lw	$2,0($2)
	addu	$3,$3,$5
	sw	$2,32($4)
	addu	$2,$6,1
	move	$6,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lw	$3,0($3)
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	sw	$3,48($4)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(gCatmullRom) # high
	addiu	$23,$2,%lo(gCatmullRom) # low
	move	$5,$23
	addu	$16,$sp,96
	.set	noreorder
	.set	nomacro
	jal	TransformVector
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$20,$sp,32
	move	$5,$20
	addu	$18,$sp,112
	.set	noreorder
	.set	nomacro
	jal	TransformVector
	move	$6,$18
	.set	macro
	.set	reorder

	lw	$2,112($sp)
	lw	$3,192($sp)
	sra	$2,$2,1
	sw	$2,0($3)
	lw	$2,116($sp)
	lw	$3,196($sp)
	sra	$2,$2,1
	sw	$2,0($3)
	lw	$2,120($sp)
	#nop
	sra	$3,$2,1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L741
	sra	$2,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$2,$3,16
$L741:
	lw	$3,200($sp)
	#nop
	sw	$2,0($3)
	lw	$2,124($sp)
	#nop
	sra	$3,$2,1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L738
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L738:
	sra	$3,$3,16
	lui	$7,%hi(gKnots) # high
	addiu	$7,$7,%lo(gKnots) # low
	lw	$2,204($sp)
	lui	$6,%hi(gRotateOffset) # high
	sw	$3,0($2)
	sll	$2,$17,2
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$2,16($2)
	lw	$3,%lo(gRotateOffset)($6)
	addiu	$6,$6,%lo(gRotateOffset) # low
	addu	$2,$2,$3
	sw	$2,32($sp)
	sll	$2,$19,2
	addu	$2,$2,$19
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$2,16($2)
	lw	$3,4($6)
	addu	$4,$sp,16
	addu	$2,$2,$3
	sw	$2,48($sp)
	sll	$2,$21,2
	addu	$2,$2,$21
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$2,16($2)
	lw	$3,8($6)
	move	$5,$23
	addu	$2,$2,$3
	sw	$2,64($sp)
	sll	$2,$22,2
	addu	$2,$2,$22
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$2,16($2)
	lw	$3,12($6)
	move	$6,$16
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TransformVector
	sw	$2,80($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	TransformVector
	move	$6,$18
	.set	macro
	.set	reorder

	lw	$2,112($sp)
	#nop
	sra	$3,$2,1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L739
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L739:
	lw	$2,208($sp)
	sra	$3,$3,16
	sw	$3,0($2)
	lw	$31,160($sp)
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

	.end	CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
	.rdata
	.align	2
$LC2:
	.ascii	"zcars\000"
	.align	2
$LC3:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	GetShapeInfo__16tScreenCarSelectRsT1PPcT3
	.ent	GetShapeInfo__16tScreenCarSelectRsT1PPcT3
GetShapeInfo__16tScreenCarSelectRsT1PPcT3:
	.frame	$sp,240,$31		# vars= 208, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	sw	$17,228($sp)
	move	$17,$4
	li	$2,142			# 0x0000008e
	sw	$31,232($sp)
	sw	$16,224($sp)
	sh	$2,0($5)
	li	$2,11			# 0x0000000b
	sh	$2,0($6)
	lui	$2,%hi($LC2) # high
	addiu	$2,$2,%lo($LC2) # low
	sw	$2,0($7)
	lw	$2,96($17)
	addu	$5,$sp,16
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L743
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

$L743:
	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lbu	$2,216($sp)
	lui	$5,%hi($LC3) # high
	sh	$2,286($17)
	lbu	$2,16($sp)
	addiu	$5,$5,%lo($LC3) # low
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($17)
	lbu	$2,215($sp)
	addu	$6,$sp,24
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sh	$2,290($17)
	.set	macro
	.set	reorder

	lw	$2,256($sp)
	#nop
	sw	$16,0($2)
	lw	$31,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	GetShapeInfo__16tScreenCarSelectRsT1PPcT3
	.align	2
	.globl	UpdateVideoWall__16tScreenCarSelectR8tCarInfo
	.ent	UpdateVideoWall__16tScreenCarSelectR8tCarInfo
UpdateVideoWall__16tScreenCarSelectR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	lbu	$3,200($16)
	lh	$2,286($17)
	#nop
	bne	$3,$2,$L747
	lb	$3,0($16)
	lh	$2,288($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L747
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lbu	$3,2($16)
	#nop
	bne	$3,$2,$L745
	lh	$3,290($17)
	lbu	$2,199($16)
	#nop
	beq	$3,$2,$L745
$L747:
	lb	$2,0($16)
	#nop
	bltz	$2,$L748
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	addu	$5,$16,8
	.set	macro
	.set	reorder

$L748:
	lbu	$2,200($16)
	move	$4,$17
	sh	$2,286($17)
	lbu	$2,0($16)
	move	$5,$0
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($17)
	lbu	$2,199($16)
	move	$6,$5
	sw	$0,900($17)
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	sh	$2,290($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$17,772
	.set	macro
	.set	reorder

$L745:
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

	.end	UpdateVideoWall__16tScreenCarSelectR8tCarInfo
	.rdata
	.align	2
$LC4:
	.ascii	"VideoWall\000"
	.text
	.align	2
	.globl	AllocateAsyncBuffer__16tScreenCarSelect
	.ent	AllocateAsyncBuffer__16tScreenCarSelect
AllocateAsyncBuffer__16tScreenCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$5,%hi($LC4) # high
	li	$4,40000			# 0x00009c40
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	sw	$2,48($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AllocateAsyncBuffer__16tScreenCarSelect
	.align	2
	.globl	FreeAsyncBuffer__16tScreenCarSelect
	.ent	FreeAsyncBuffer__16tScreenCarSelect
FreeAsyncBuffer__16tScreenCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	sw	$0,48($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FreeAsyncBuffer__16tScreenCarSelect
	.align	2
	.globl	InitializeVideoWall__16tScreenCarSelect
	.ent	InitializeVideoWall__16tScreenCarSelect
InitializeVideoWall__16tScreenCarSelect:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$16,32($sp)
	addu	$16,$17,772
	move	$4,$16
	addu	$5,$17,292
	li	$2,10			# 0x0000000a
	sw	$2,16($sp)
	lui	$2,%hi(tvOrder) # high
	addiu	$2,$2,%lo(tvOrder) # low
	sw	$2,20($sp)
	li	$2,150			# 0x00000096
	sw	$31,40($sp)
	sw	$2,24($sp)
	lw	$6,40($17)
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
	li	$5,28			# 0x0000001c
	li	$6,10			# 0x0000000a
	li	$2,60			# 0x0000003c
	sw	$2,16($sp)
	lw	$2,0($17)
	li	$7,310			# 0x00000136
	.set	noreorder
	.set	nomacro
	jal	SetAvailableIcon__10tVideoWallssssP18tTexture_ShapeInfo
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lhu	$2,58($17)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L754
	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($17)
$L754:
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

	.end	InitializeVideoWall__16tScreenCarSelect
	.align	2
	.globl	Initialize__16tScreenCarSelect
	.ent	Initialize__16tScreenCarSelect
Initialize__16tScreenCarSelect:
	.frame	$sp,320,$31		# vars= 296, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,320
	sw	$16,312($sp)
	lui	$2,%hi(frontEnd) # high
	addiu	$5,$2,%lo(frontEnd) # low
	sw	$31,316($sp)
	lbu	$3,4($5)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L758
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetTrackToRace__18tTournamentManagerR10tTrackInfo
	addu	$5,$sp,272
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	lb	$5,272($sp)
	.set	noreorder
	.set	nomacro
	jal	GetTrackByID__13tTrackManagers
	addiu	$4,$4,%lo(trackManager) # low
	.set	macro
	.set	reorder

	lbu	$3,1($2)
	.set	noreorder
	.set	nomacro
	j	$L773
	lui	$2,%hi(GameSetup_gData+60) # high
	.set	macro
	.set	reorder

$L758:
	lui	$4,%hi(trackManager) # high
	lbu	$2,70($5)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$5
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,224
	.set	macro
	.set	reorder

	lbu	$3,225($sp)
	lui	$2,%hi(GameSetup_gData+60) # high
$L773:
	sw	$3,%lo(GameSetup_gData+60)($2)
	lui	$3,%hi(gShowroomLights) # high
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$2,1			# 0x00000001
	sw	$2,%lo(gShowroomLights)($3)
	lw	$3,8248($4)
	li	$2,-2			# 0xfffffffe
	and	$5,$3,$2
	lui	$2,%hi(frontEnd+4) # high
	sw	$5,8248($4)
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L760
	ori	$2,$5,0x0001
	.set	macro
	.set	reorder

	sw	$2,8248($4)
$L760:
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,112($2)
	lw	$2,116($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	jal	SetLicensePlate__Fv
	lw	$2,96($16)
	addu	$5,$sp,16
	sw	$0,900($16)
	sw	$0,924($16)
	sw	$0,904($16)
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L761
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lbu	$2,216($sp)
	#nop
	sh	$2,286($16)
	lbu	$2,16($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($16)
	lbu	$2,215($sp)
	.set	noreorder
	.set	nomacro
	j	$L762
	sh	$2,290($16)
	.set	macro
	.set	reorder

$L761:
	sh	$2,286($16)
	sh	$2,290($16)
	sh	$2,288($16)
$L762:
	lui	$2,%hi(ticks) # high
	#.set	volatile
	lw	$3,%lo(ticks)($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,%lo(ticks)($2)
	#.set	novolatile
	sh	$0,886($16)
	sh	$0,884($16)
	sh	$0,890($16)
	sh	$0,888($16)
	sw	$3,908($16)
	lw	$3,96($16)
	addu	$2,$2,-256
	sw	$2,896($16)
	sw	$2,892($16)
	lh	$4,88($3)
	lw	$2,92($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$5,$0
$L763:
	sll	$2,$5,16
	addu	$4,$5,1
	move	$5,$4
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$16,$3
	sll	$4,$4,16
	sra	$4,$4,16
	slt	$4,$4,7
	sh	$0,116($3)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L763
	sh	$0,120($3)
	.set	macro
	.set	reorder

	move	$5,$0
$L767:
	sll	$2,$5,16
	sra	$2,$2,14
	addu	$2,$16,$2
	sw	$0,268($2)
	addu	$2,$5,1
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	bne	$2,$0,$L767
	lw	$31,316($sp)
	lw	$16,312($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,320
	.set	macro
	.set	reorder

	.end	Initialize__16tScreenCarSelect
	.align	2
	.globl	ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,240,$31		# vars= 208, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	sw	$16,224($sp)
	sw	$17,228($sp)
	move	$17,$6
	sw	$31,232($sp)
	lw	$3,0($17)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L775
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$2,96($16)
	addu	$5,$sp,16
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lui	$3,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($3)
	#nop
	lbu	$3,556($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L776
	move	$5,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L777
	addu	$4,$2,8216
	.set	macro
	.set	reorder

$L776:
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$4,$2,8312
$L777:
	li	$2,267			# 0x0000010b
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L778
	sw	$2,4($4)
	.set	macro
	.set	reorder

	lb	$3,16($sp)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L796
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,268			# 0x0000010c
	sw	$2,4($4)
	lb	$3,16($sp)
	li	$2,1			# 0x00000001
$L796:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L797
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	li	$2,269			# 0x0000010d
	sw	$2,4($4)
$L778:
	lui	$2,%hi(frontEnd) # high
$L797:
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$2,798($4)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L798
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,3($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L781
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

$L798:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,8376($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,8376($3)
$L781:
	lw	$3,0($17)
$L775:
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L774
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	lh	$3,284($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L785
	slt	$2,$3,6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L787
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L789
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	j	$L790
$L787:
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L792
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L774
$L785:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	j	$L795
	move	$5,$0
	.set	macro
	.set	reorder

$L792:
	.set	noreorder
	.set	nomacro
	j	$L795
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L790:
	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L789
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$2
$L795:
	jal	SetState__16tScreenCarSelecti
$L789:
 #APP
 #NO_APP
$L774:
	lw	$31,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	DrawVideoWall__16tScreenCarSelects
	.ent	DrawVideoWall__16tScreenCarSelects
DrawVideoWall__16tScreenCarSelects:
	.frame	$sp,248,$31		# vars= 208, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$16,232($sp)
	move	$16,$4
	sw	$31,240($sp)
	sw	$17,236($sp)
	lw	$2,96($16)
	addu	$5,$sp,24
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	li	$6,28			# 0x0000001c
	li	$3,150			# 0x00000096
	sw	$3,16($sp)
	lw	$7,0($16)
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$5,268($16)
	.set	noreorder
	.set	nomacro
	jal	DrawOverlay__16tScreenCarSelectP8tOverlay
	move	$4,$16
	.set	macro
	.set	reorder

	lhu	$2,58($16)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L800
	lw	$2,900($16)
	#nop
	bne	$2,$0,$L800
	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($16)
$L800:
	lh	$2,92($16)
	#nop
	blez	$2,$L801
	lw	$2,84($16)
	#nop
	beq	$2,$0,$L801
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

$L801:
	addu	$16,$16,772
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$5,$17,16
	.set	noreorder
	.set	nomacro
	jal	SetValid__10tVideoWalls
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$5,31($sp)
	.set	noreorder
	.set	nomacro
	jal	SetAvailable__10tVideoWalls
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,240($sp)
	lw	$17,236($sp)
	lw	$16,232($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,248
	.set	macro
	.set	reorder

	.end	DrawVideoWall__16tScreenCarSelects
	.align	2
	.globl	GetCar__16tScreenCarSelectR8tCarInfo
	.ent	GetCar__16tScreenCarSelectR8tCarInfo
GetCar__16tScreenCarSelectR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lh	$3,284($16)
	#nop
	sltu	$2,$3,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	move	$18,$5
	.set	macro
	.set	reorder

	lui	$2,%hi($L822) # high
	addiu	$2,$2,%lo($L822) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L822:
	.word	$L806
	.word	$L816
	.word	$L809
	.word	$L816
	.word	$L816
	.word	$L806
	.word	$L809
	.word	$L810
	.text
$L806:
	lui	$16,%hi(carManager) # high
	addiu	$4,$16,%lo(carManager) # low
	lui	$2,%hi(frontEnd) # high
	addiu	$17,$2,%lo(frontEnd) # low
	lbu	$5,92($17)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$18
	.set	macro
	.set	reorder

	lbu	$2,92($17)
	lw	$3,%lo(carManager)($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L807
	lb	$2,0($18)
	#nop
	addu	$2,$2,$17
	lbu	$2,96($2)
	#nop
	sb	$2,197($18)
$L807:
	lb	$2,0($18)
	#nop
	addu	$2,$2,$17
	lbu	$2,192($2)
	.set	noreorder
	.set	nomacro
	j	$L804
	sb	$2,199($18)
	.set	macro
	.set	reorder

$L809:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	lbu	$5,296($16)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$18
	.set	macro
	.set	reorder

	lb	$2,0($18)
	#nop
	addu	$2,$2,$16
	lbu	$3,96($2)
	li	$2,1			# 0x00000001
	sb	$2,7($18)
	.set	noreorder
	.set	nomacro
	j	$L804
	sb	$3,197($18)
	.set	macro
	.set	reorder

$L810:
	lui	$2,%hi(D_8011472A) # high
	lbu	$3,%lo(D_8011472A)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L828
	lui	$2,%hi(carManager) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L827
	lui	$2,%hi(carManager) # high
	.set	macro
	.set	reorder

$L828:
	lui	$3,%hi(frontEnd) # high
	addiu	$5,$3,%lo(frontEnd) # low
	lbu	$3,298($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L813
	addiu	$4,$2,%lo(carManager) # low
	.set	macro
	.set	reorder

	lbu	$5,92($5)
	j	$L814
$L813:
	lbu	$5,291($5)
$L814:
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,298($3)
	#nop
	bne	$2,$0,$L815
	lb	$2,0($18)
	#nop
	addu	$2,$2,$3
	lbu	$2,96($2)
	#nop
	sb	$2,197($18)
$L815:
	lb	$2,0($18)
	#nop
	addu	$2,$2,$3
	lbu	$2,192($2)
	.set	noreorder
	.set	nomacro
	j	$L804
	sb	$2,199($18)
	.set	macro
	.set	reorder

$L816:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L829
	lui	$2,%hi(D_80114604) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(D_80114604)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L817
	lui	$2,%hi(D_80114604) # high
	.set	macro
	.set	reorder

$L827:
	.set	noreorder
	.set	nomacro
	j	$L824
	move	$2,$0
	.set	macro
	.set	reorder

$L817:
$L829:
	lbu	$3,%lo(D_80114604)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L830
	lui	$2,%hi(carManager) # high
	.set	macro
	.set	reorder

	lh	$3,284($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L818
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumTourneyCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L824
	move	$2,$0
	.set	macro
	.set	reorder

$L818:
	lui	$2,%hi(carManager) # high
$L830:
	addiu	$4,$2,%lo(carManager) # low
	lh	$3,284($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L820
	lui	$2,%hi(D_80114723) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(D_80114729) # high
	lbu	$5,%lo(D_80114729)($2)
	j	$L821
$L820:
	lbu	$5,%lo(D_80114723)($2)
$L821:
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	lb	$3,0($18)
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$3,$3,$2
	lbu	$2,192($3)
	#nop
	sb	$2,199($18)
$L804:
	lbu	$2,197($18)
	#nop
	addu	$2,$18,$2
	lbu	$3,175($2)
	li	$2,1			# 0x00000001
	sb	$3,197($18)
$L824:
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

	.end	GetCar__16tScreenCarSelectR8tCarInfo
	.align	2
	.globl	SetBrightness__16tScreenCarSelectss
	.ent	SetBrightness__16tScreenCarSelectss
SetBrightness__16tScreenCarSelectss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$6,$6,16
	sra	$6,$6,15
	addu	$4,$4,$6
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,888($4)
	.set	macro
	.set	reorder

	.end	SetBrightness__16tScreenCarSelectss
	.align	2
	.globl	UpdateBrightness__16tScreenCarSelects
	.ent	UpdateBrightness__16tScreenCarSelects
UpdateBrightness__16tScreenCarSelects:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$5,$5,16
	sra	$5,$5,15
	addu	$4,$4,$5
	lh	$6,888($4)
	lh	$5,884($4)
	lhu	$3,884($4)
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L834
	addu	$2,$3,8
	.set	macro
	.set	reorder

	sh	$2,884($4)
	sll	$2,$2,16
	move	$3,$6
	sra	$2,$2,16
	slt	$3,$3,$2
	lhu	$2,888($4)
	beq	$3,$0,$L840
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,884($4)
	.set	macro
	.set	reorder

$L834:
	slt	$2,$6,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L840
	addu	$2,$3,-8
	.set	macro
	.set	reorder

	sh	$2,884($4)
	sll	$2,$2,16
	lh	$3,888($4)
	sra	$2,$2,16
	slt	$2,$2,$3
	lhu	$3,888($4)
	beq	$2,$0,$L840
	sh	$3,884($4)
$L840:
	j	$31
	.end	UpdateBrightness__16tScreenCarSelects
	.align	2
	.globl	DrawBackground__16tScreenCarSelect
	.ent	DrawBackground__16tScreenCarSelect
DrawBackground__16tScreenCarSelect:
	.frame	$sp,232,$31		# vars= 208, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,232
	sw	$16,224($sp)
	move	$16,$4
	sw	$31,228($sp)
	lw	$2,96($16)
	addu	$5,$sp,16
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$16,40
	.set	macro
	.set	reorder

	lw	$2,44($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L843
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$3,792($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L843
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($2)
	lui	$3,%hi(gCarObj) # high
	lbu	$2,556($2)
	addiu	$3,$3,%lo(gCarObj) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L843
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($16)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	xori	$4,$2,0x0001
$L843:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L842
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,11			# 0x0000000b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

	lh	$3,884($16)
	lh	$2,888($16)
	#nop
	bne	$3,$2,$L842
	lbu	$2,23($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L846
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L846:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

$L842:
	lh	$2,92($16)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L841
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

$L841:
	lw	$31,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,232
	.set	macro
	.set	reorder

	.end	DrawBackground__16tScreenCarSelect
	.align	2
	.globl	DrawSliders__16tScreenCarSelectR8tCarInfoss
	.ent	DrawSliders__16tScreenCarSelectR8tCarInfoss
DrawSliders__16tScreenCarSelectR8tCarInfoss:
	.frame	$sp,88,$31		# vars= 0, regs= 8/0, args= 56, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$20,72($sp)
	move	$20,$5
	sw	$17,60($sp)
	move	$17,$7
	sw	$18,64($sp)
	move	$18,$0
	lui	$2,%hi(textVals) # high
	sw	$22,80($sp)
	addiu	$22,$2,%lo(textVals) # low
	sll	$6,$6,16
	sw	$19,68($sp)
	sra	$19,$6,16
	lui	$2,%hi(remap) # high
	sw	$21,76($sp)
	addiu	$21,$2,%lo(remap) # low
	sw	$31,84($sp)
	sw	$16,56($sp)
$L850:
	sll	$2,$18,16
	sra	$16,$2,16
	slt	$2,$16,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	move	$5,$19
	.set	macro
	.set	reorder

	addu	$6,$17,4
	sll	$6,$6,16
	sra	$6,$6,16
	move	$7,$0
	sll	$2,$16,1
	addu	$2,$2,$22
	lh	$4,0($2)
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	sll	$2,$16,2
	addu	$2,$2,$21
	lw	$2,0($2)
	lbu	$3,196($20)
	addu	$5,$20,$2
	andi	$2,$3,0x0001
	lbu	$4,48($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	andi	$2,$3,0x0002
	.set	macro
	.set	reorder

	lbu	$2,53($5)
	#nop
	addu	$4,$4,$2
	andi	$2,$3,0x0002
$L858:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L859
	andi	$2,$3,0x0004
	.set	macro
	.set	reorder

	lbu	$2,58($5)
	#nop
	addu	$4,$4,$2
	andi	$2,$3,0x0004
$L859:
	beq	$2,$0,$L856
	lbu	$2,63($5)
	#nop
	addu	$4,$4,$2
$L856:
	sll	$4,$4,16
	sra	$4,$4,16
	move	$5,$0
	li	$6,11			# 0x0000000b
	move	$7,$19
	sll	$2,$17,16
	sra	$2,$2,16
	sw	$2,16($sp)
	li	$2,104			# 0x00000068
	li	$3,3			# 0x00000003
	sw	$2,20($sp)
	li	$2,7			# 0x00000007
	sw	$2,28($sp)
	li	$2,128			# 0x00000080
	sw	$3,24($sp)
	sw	$3,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$0,48($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,15
	.set	noreorder
	.set	nomacro
	j	$L850
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L849:
	lw	$31,84($sp)
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
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	DrawSliders__16tScreenCarSelectR8tCarInfoss
	.align	2
	.globl	DrawForeground__16tScreenCarSelect
	.ent	DrawForeground__16tScreenCarSelect
DrawForeground__16tScreenCarSelect:
	.frame	$sp,336,$31		# vars= 256, regs= 7/0, args= 48, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,336
	sw	$19,316($sp)
	move	$19,$4
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	addu	$5,$sp,48
	sw	$31,328($sp)
	sw	$21,324($sp)
	sw	$20,320($sp)
	sw	$18,312($sp)
	sw	$17,308($sp)
	sw	$16,304($sp)
	lw	$6,96($19)
	lw	$3,4($2)
	lh	$4,104($6)
	lw	$2,8($3)
	#nop
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,108($6)
	lw	$16,16($3)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lui	$20,%hi(menuDefs) # high
	move	$17,$0
	lw	$5,%lo(menuDefs)($20)
	move	$18,$16
	lw	$3,8376($5)
	#nop
	ori	$3,$3,0x0001
	sw	$3,8376($5)
	lh	$3,284($19)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L861
	move	$21,$2
	.set	macro
	.set	reorder

	addu	$2,$5,4840
	xor	$2,$16,$2
	sltu	$2,$2,$4
	move	$17,$2
	lw	$2,4924($5)
	li	$16,-2			# 0xfffffffe
	and	$2,$2,$16
	sw	$2,4924($5)
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,4($4)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L862
	lbu	$2,290($4)
	#nop
	bne	$2,$0,$L862
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	li	$4,25			# 0x00000019
	.set	macro
	.set	reorder

	beq	$2,$0,$L862
	lw	$3,%lo(menuDefs)($20)
	#nop
	lw	$2,8376($3)
	#nop
	and	$2,$2,$16
	sw	$2,8376($3)
$L862:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L927
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,50($sp)
	#nop
	sltu	$2,$2,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L863
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L865
	sh	$2,216($19)
	.set	macro
	.set	reorder

$L863:
	lui	$2,%hi(menuDefs) # high
$L927:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,4924($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,4924($3)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L865
	sh	$2,216($19)
	.set	macro
	.set	reorder

$L861:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L866
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$2,$5,4564
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L928
	li	$4,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L928:
	lw	$2,4604($5)
	lw	$3,4644($5)
	and	$2,$2,$4
	and	$3,$3,$4
	sw	$2,4604($5)
	sw	$3,4644($5)
	lbu	$3,50($sp)
	li	$2,7			# 0x00000007
	bne	$3,$2,$L865
	lw	$2,4604($5)
	lw	$3,4644($5)
	ori	$2,$2,0x0001
	ori	$3,$3,0x0001
	sw	$2,4604($5)
	.set	noreorder
	.set	nomacro
	j	$L865
	sw	$3,4644($5)
	.set	macro
	.set	reorder

$L866:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L870
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$2,$5,7328
	bne	$16,$2,$L865
	.set	noreorder
	.set	nomacro
	j	$L865
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L870:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L873
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$2,$5,7648
	bne	$18,$2,$L874
	li	$17,1			# 0x00000001
$L874:
	lw	$2,7688($5)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L875
	sw	$2,7688($5)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L865
	sh	$4,216($19)
	.set	macro
	.set	reorder

$L875:
	li	$2,-1			# 0xffffffff
	sh	$2,216($19)
	lw	$2,7688($5)
	#nop
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L865
	sw	$2,7688($5)
	.set	macro
	.set	reorder

$L873:
	bne	$3,$2,$L865
	li	$17,1			# 0x00000001
$L865:
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L929
	move	$2,$17
	.set	macro
	.set	reorder

	move	$17,$0
	move	$2,$17
$L929:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L923
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L923:
	sh	$2,264($19)
	move	$16,$0
	lui	$2,%hi(gStateOverlays) # high
	addiu	$7,$2,%lo(gStateOverlays) # low
	li	$8,1			# 0x00000001
	sll	$2,$16,16
$L931:
	sra	$6,$2,16
	sll	$2,$6,2
	addu	$5,$19,$2
	lw	$4,268($5)
	#nop
	beq	$4,$0,$L886
	lh	$2,284($19)
	lh	$3,22($4)
	sll	$2,$2,2
	addu	$2,$6,$2
	addu	$2,$2,$7
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L884
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sh	$2,20($4)
	lw	$2,268($5)
	#nop
	lh	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L930
	addu	$2,$16,1
	.set	macro
	.set	reorder

	sw	$0,268($5)
$L886:
	lh	$2,284($19)
	#nop
	sll	$2,$2,2
	addu	$2,$6,$2
	addu	$2,$2,$7
	lb	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L884
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,100
	addu	$2,$19,$2
	sw	$2,268($5)
	sh	$0,16($2)
	lw	$2,268($5)
	#nop
	sh	$8,20($2)
$L884:
	addu	$2,$16,1
$L930:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L931
	sll	$2,$16,16
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	sll	$2,$16,16
$L932:
	sra	$2,$2,14
	addu	$2,$19,$2
	lw	$5,268($2)
	.set	noreorder
	.set	nomacro
	jal	DrawOverlay__16tScreenCarSelectP8tOverlay
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	sll	$2,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L896
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sb	$2,48($sp)
$L896:
	lw	$2,96($19)
	addu	$5,$sp,48
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	lui	$3,%hi(gCarObj) # high
	lbu	$2,556($2)
	addiu	$3,$3,%lo(gCarObj) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L897
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$19,772
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,892($19)
$L897:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	UpdateBrightness__16tScreenCarSelects
	move	$5,$0
	.set	macro
	.set	reorder

	lhu	$2,284($19)
	#nop
	addu	$2,$2,-5
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L898
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,48
	li	$5,314			# 0x0000013a
	li.s	$7,4.00000000000000000000e0
	lui	$2,%hi(showRoomFlag) # high
	sw	$0,%lo(showRoomFlag)($2)
	lw	$2,924($19)
	li.s	$3,-7.50000000000000000000e0
	addu	$2,$2,3
	sw	$2,924($19)
	sw	$3,16($sp)
	lbu	$3,884($19)
	li	$2,1			# 0x00000001
	sw	$2,24($sp)
	sw	$3,20($sp)
	lw	$2,924($19)
	li	$6,84			# 0x00000054
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L926
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

$L898:
	lw	$2,%lo(ticks)($2)
	lw	$3,912($19)
	sw	$0,288($sp)
	sw	$0,292($sp)
	sw	$0,296($sp)
	sw	$0,280($sp)
	subu	$2,$2,$3
	addu	$8,$2,-256
	.set	noreorder
	.set	nomacro
	bltz	$8,$L900
	sw	$0,284($sp)
	.set	macro
	.set	reorder

	lb	$4,241($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L900
	li	$2,1808400384			# 0x6bca0000
	.set	macro
	.set	reorder

	ori	$2,$2,0x1af3
	sra	$5,$8,9
	mult	$5,$2
	sra	$3,$8,31
	lui	$16,%hi(kRGBVals) # high
	addiu	$16,$16,%lo(kRGBVals) # low
	mfhi	$10
	#nop
	#nop
	sra	$2,$10,3
	subu	$2,$2,$3
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	subu	$3,$5,$3
	addu	$3,$3,996
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	addu	$20,$3,$2
	sll	$4,$20,16
	sra	$4,$4,16
	sll	$5,$5,9
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	subu	$17,$8,$5
	.set	macro
	.set	reorder

	lui	$4,%hi(textDefinitions) # high
	addiu	$4,$4,%lo(textDefinitions) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$3,$4
	lbu	$2,4($3)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$18,0($2)
	sltu	$2,$17,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L901
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	j	$L924
	subu	$5,$5,$17
	.set	macro
	.set	reorder

$L901:
	li	$2,512			# 0x00000200
	subu	$2,$2,$17
	sltu	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L902
	addu	$5,$17,-384
	.set	macro
	.set	reorder

$L924:
	jal	CalcFadeVal__Fii
	move	$18,$2
$L902:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$20
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$20
	sll	$17,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$17,$17,16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	sll	$2,$2,16
	sra	$6,$2,16
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L900:
	li	$2,5570560			# 0x00550000
	ori	$2,$2,0x1e00
	sw	$2,260($sp)
	lw	$2,40($19)
	#nop
	sw	$2,276($sp)
	lw	$3,912($19)
	#nop
	sltu	$2,$3,257
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L907
	li	$8,128			# 0x00000080
	.set	macro
	.set	reorder

	sltu	$2,$3,385
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L906
	li	$2,384			# 0x00000180
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L907
	move	$8,$0
	.set	macro
	.set	reorder

$L906:
	subu	$8,$2,$3
 #APP
 #NO_APP
$L907:
	li	$4,10			# 0x0000000a
	li	$5,512			# 0x00000200
	move	$6,$0
	move	$7,$6
	addu	$2,$sp,256
	sw	$8,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	lw	$2,908($19)
	#nop
	subu	$8,$3,$2
$L925:
	slt	$2,$8,601
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L909
	lui	$3,%hi(gRotateOffset) # high
	.set	macro
	.set	reorder

	lw	$2,908($19)
	lw	$3,920($19)
	addu	$2,$2,600
	sw	$2,908($19)
	addu	$2,$3,1
	sw	$2,920($19)
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L925
	addu	$8,$8,-600
	.set	macro
	.set	reorder

	addu	$2,$3,-4
	.set	noreorder
	.set	nomacro
	j	$L925
	sw	$2,920($19)
	.set	macro
	.set	reorder

$L909:
	lhu	$5,920($19)
	addiu	$4,$3,%lo(gRotateOffset) # low
	sll	$2,$5,16
	sra	$2,$2,16
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L913
	sw	$0,%lo(gRotateOffset)($3)
	.set	macro
	.set	reorder

	addu	$5,$5,-5
	li	$2,67108864			# 0x04000000
	sw	$2,%lo(gRotateOffset)($3)
$L913:
	addu	$2,$5,1
	move	$6,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lw	$3,%lo(gRotateOffset)($3)
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L914
	sw	$3,4($4)
	.set	macro
	.set	reorder

	addu	$6,$5,-4
	li	$2,67108864			# 0x04000000
	addu	$2,$3,$2
	sw	$2,4($4)
$L914:
	addu	$2,$6,1
	move	$7,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lw	$3,4($4)
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L915
	sw	$3,8($4)
	.set	macro
	.set	reorder

	addu	$7,$6,-4
	li	$2,67108864			# 0x04000000
	addu	$2,$3,$2
	sw	$2,8($4)
$L915:
	addu	$2,$7,1
	move	$9,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lw	$3,8($4)
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L916
	sw	$3,12($4)
	.set	macro
	.set	reorder

	addu	$9,$7,-4
	li	$2,67108864			# 0x04000000
	addu	$2,$3,$2
	sw	$2,12($4)
$L916:
	move	$4,$19
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$7,$7,16
	sra	$7,$7,16
	sll	$2,$9,16
	sra	$2,$2,16
	sw	$2,16($sp)
	addu	$2,$sp,280
	sw	$2,24($sp)
	addu	$2,$sp,284
	sw	$2,28($sp)
	addu	$2,$sp,288
	sw	$2,32($sp)
	addu	$2,$sp,292
	sw	$2,36($sp)
	addu	$2,$sp,296
	sw	$8,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
	sw	$2,40($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(showRoomFlag) # high
	lw	$4,280($sp)
	li	$18,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	__floatsisf
	sw	$18,%lo(showRoomFlag)($2)
	.set	macro
	.set	reorder

	li.s	$16,1.52587890625000000000e-5
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,284($sp)
	.set	noreorder
	.set	nomacro
	jal	__floatsisf
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	move	$5,$16
	.set	macro
	.set	reorder

	lh	$5,288($sp)
	lh	$6,292($sp)
	sw	$2,16($sp)
	lbu	$2,884($19)
	addu	$4,$sp,48
	sw	$18,24($sp)
	sw	$2,20($sp)
	lw	$2,296($sp)
	move	$7,$17
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L926
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	jal	gettick
	lw	$3,912($19)
	#nop
	subu	$2,$2,$3
	sltu	$2,$2,641
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L926
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	lw	$2,916($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L926
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	lb	$2,241($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L926
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	sw	$18,916($19)
	lb	$5,241($sp)
	.set	noreorder
	.set	nomacro
	jal	FeAudio_AsyncPlaySpeech__Fii
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(gCarObj) # high
$L926:
	lw	$2,%lo(gCarObj)($2)
	#nop
	lw	$2,2264($2)
	#nop
	bne	$2,$0,$L860
	lh	$3,884($19)
	lh	$2,888($19)
	#nop
	bne	$3,$2,$L860
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L860
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($19)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	bne	$2,$0,$L860
	lbu	$2,55($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L919
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L919:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$19,772
	.set	macro
	.set	reorder

$L860:
	lw	$31,328($sp)
	lw	$21,324($sp)
	lw	$20,320($sp)
	lw	$19,316($sp)
	lw	$18,312($sp)
	lw	$17,308($sp)
	lw	$16,304($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,336
	.set	macro
	.set	reorder

	.end	DrawForeground__16tScreenCarSelect
	.rdata
	.align	2
$LC5:
	.ascii	"OpponentVid\000"
	.align	2
$LC6:
	.ascii	"z%s\000"
	.text
	.align	2
	.globl	PreLoad__20tScreenCarSelectDuel
	.ent	PreLoad__20tScreenCarSelectDuel
PreLoad__20tScreenCarSelectDuel:
	.frame	$sp,280,$31		# vars= 240, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,280
	sw	$19,268($sp)
	move	$19,$4
	sw	$20,272($sp)
	addu	$20,$19,936
	move	$5,$20
	li	$6,5			# 0x00000005
	sw	$31,276($sp)
	sw	$18,264($sp)
	sw	$17,260($sp)
	sw	$16,256($sp)
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	sw	$0,936($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PreLoad__7tScreen
	move	$4,$19
	.set	macro
	.set	reorder

	li	$4,16000			# 0x00003e80
	lui	$5,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	li	$4,16000			# 0x00003e80
	lui	$5,%hi($LC5) # high
	addiu	$5,$5,%lo($LC5) # low
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	sw	$2,48($19)
	.set	macro
	.set	reorder

	lw	$3,96($19)
	addu	$5,$sp,16
	sw	$2,944($19)
	lh	$4,104($3)
	lw	$2,108($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L934
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

$L934:
	addu	$17,$sp,224
	move	$4,$17
	lui	$16,%hi($LC6) # high
	addiu	$16,$16,%lo($LC6) # low
	move	$5,$16
	addu	$18,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	addu	$6,$19,40
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$2,%hi(frontEnd+797) # high
	lbu	$5,%lo(frontEnd+797)($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	move	$6,$20
	.set	macro
	.set	reorder

	sw	$0,932($19)
	lw	$31,276($sp)
	lw	$20,272($sp)
	lw	$19,268($sp)
	lw	$18,264($sp)
	lw	$17,260($sp)
	lw	$16,256($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,280
	.set	macro
	.set	reorder

	.end	PreLoad__20tScreenCarSelectDuel
	.align	2
	.globl	AllocateAsyncBuffer__20tScreenCarSelectDuel
	.ent	AllocateAsyncBuffer__20tScreenCarSelectDuel
AllocateAsyncBuffer__20tScreenCarSelectDuel:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AllocateAsyncBuffer__20tScreenCarSelectDuel
	.align	2
	.globl	FreeAsyncBuffer__20tScreenCarSelectDuel
	.ent	FreeAsyncBuffer__20tScreenCarSelectDuel
FreeAsyncBuffer__20tScreenCarSelectDuel:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	sw	$0,48($16)
	sw	$0,944($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FreeAsyncBuffer__20tScreenCarSelectDuel
	.align	2
	.globl	InitializeVideoWall__20tScreenCarSelectDuel
	.ent	InitializeVideoWall__20tScreenCarSelectDuel
InitializeVideoWall__20tScreenCarSelectDuel:
	.frame	$sp,56,$31		# vars= 0, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$17,36($sp)
	addu	$17,$18,772
	move	$4,$17
	addu	$5,$18,292
	sw	$20,48($sp)
	li	$20,5			# 0x00000005
	lui	$2,%hi(tvSplitOrder) # high
	sw	$19,44($sp)
	addiu	$19,$2,%lo(tvSplitOrder) # low
	sw	$31,52($sp)
	sw	$16,32($sp)
	sw	$20,16($sp)
	sw	$19,20($sp)
	sw	$0,24($sp)
	lw	$6,40($18)
	.set	noreorder
	.set	nomacro
	jal	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,248			# 0x000000f8
	li	$6,270			# 0x0000010e
	.set	noreorder
	.set	nomacro
	jal	SetAvailableText__10tVideoWallsss
	li	$7,45			# 0x0000002d
	.set	macro
	.set	reorder

	lhu	$2,58($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L941
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	SetOffset__10tVideoWallss
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$17
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($18)
$L941:
	addu	$16,$18,828
	move	$4,$16
	addu	$5,$18,532
	sw	$20,16($sp)
	sw	$19,20($sp)
	sw	$0,24($sp)
	lw	$6,936($18)
	.set	noreorder
	.set	nomacro
	jal	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,248			# 0x000000f8
	li	$6,270			# 0x0000010e
	.set	noreorder
	.set	nomacro
	jal	SetAvailableText__10tVideoWallsss
	li	$7,150			# 0x00000096
	.set	macro
	.set	reorder

	lhu	$2,954($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L940
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetOffset__10tVideoWallss
	li	$6,105			# 0x00000069
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($18)
$L940:
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

	.end	InitializeVideoWall__20tScreenCarSelectDuel
	.align	2
	.globl	Initialize__20tScreenCarSelectDuel
	.ent	Initialize__20tScreenCarSelectDuel
Initialize__20tScreenCarSelectDuel:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__16tScreenCarSelect
	move	$16,$4
	.set	macro
	.set	reorder

	sh	$0,284($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	lui	$2,%hi(gShowroomLights) # high
	sw	$0,%lo(gShowroomLights)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__20tScreenCarSelectDuel
	.align	2
	.globl	Cleanup__20tScreenCarSelectDuel
	.ent	Cleanup__20tScreenCarSelectDuel
Cleanup__20tScreenCarSelectDuel:
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
	addu	$5,$16,936
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__16tScreenCarSelect
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

	.end	Cleanup__20tScreenCarSelectDuel
	.align	2
	.globl	DrawVideoWall__20tScreenCarSelectDuels
	.ent	DrawVideoWall__20tScreenCarSelectDuels
DrawVideoWall__20tScreenCarSelectDuels:
	.frame	$sp,264,$31		# vars= 208, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,264
	sw	$18,248($sp)
	move	$18,$4
	sw	$16,240($sp)
	move	$16,$5
	addu	$5,$sp,32
	sw	$31,256($sp)
	sw	$19,252($sp)
	sw	$17,244($sp)
	lw	$2,96($18)
	move	$17,$0
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	move	$19,$2
	sll	$16,$16,16
	sra	$16,$16,16
	sll	$4,$17,16
$L956:
	sra	$4,$4,16
	move	$5,$0
	move	$6,$5
	lh	$2,92($18)
	subu	$7,$0,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L956
	sll	$4,$17,16
	.set	macro
	.set	reorder

	lh	$2,92($18)
	#nop
	blez	$2,$L953
	lw	$2,84($18)
	#nop
	beq	$2,$0,$L953
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$18,772
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

$L953:
	lhu	$2,58($18)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L954
	addu	$16,$18,772
	.set	macro
	.set	reorder

	lw	$2,900($18)
	#nop
	bne	$2,$0,$L957
	move	$4,$16
	li	$5,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	SetOffset__10tVideoWallss
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($18)
	addu	$16,$18,772
$L954:
$L957:
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$5,$19,16
	.set	noreorder
	.set	nomacro
	jal	SetValid__10tVideoWalls
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$5,39($sp)
	.set	noreorder
	.set	nomacro
	jal	SetAvailable__10tVideoWalls
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,256($sp)
	lw	$19,252($sp)
	lw	$18,248($sp)
	lw	$17,244($sp)
	lw	$16,240($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,264
	.set	macro
	.set	reorder

	.end	DrawVideoWall__20tScreenCarSelectDuels
	.align	2
	.globl	DrawOpponentVideoWall__20tScreenCarSelectDuels
	.ent	DrawOpponentVideoWall__20tScreenCarSelectDuels
DrawOpponentVideoWall__20tScreenCarSelectDuels:
	.frame	$sp,48,$31		# vars= 0, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$16,32($sp)
	move	$16,$0
	sll	$5,$5,16
	sw	$18,40($sp)
	sra	$18,$5,16
	sw	$31,44($sp)
	sll	$4,$16,16
$L966:
	sra	$4,$4,16
	move	$5,$0
	move	$6,$5
	lh	$2,92($17)
	subu	$7,$0,$18
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L966
	sll	$4,$16,16
	.set	macro
	.set	reorder

	lh	$2,92($17)
	#nop
	blez	$2,$L963
	lw	$2,84($17)
	#nop
	beq	$2,$0,$L963
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$17,828
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L963:
	lhu	$2,58($17)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L964
	addu	$16,$17,828
	.set	macro
	.set	reorder

	lw	$2,932($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L967
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetOffset__10tVideoWallss
	li	$6,105			# 0x00000069
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,932($17)
	addu	$16,$17,828
$L964:
$L967:
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetValid__10tVideoWalls
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetAvailable__10tVideoWalls
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw__10tVideoWall
	move	$4,$16
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

	.end	DrawOpponentVideoWall__20tScreenCarSelectDuels
	.rdata
	.align	2
$LC7:
	.ascii	"zDuel\000"
	.text
	.align	2
	.globl	GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3
	.ent	GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3
GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3:
	.frame	$sp,240,$31		# vars= 208, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	sw	$16,224($sp)
	move	$16,$4
	li	$2,52			# 0x00000034
	sw	$31,232($sp)
	sw	$17,228($sp)
	sh	$2,0($5)
	li	$2,5			# 0x00000005
	addu	$5,$sp,16
	sh	$2,0($6)
	lw	$2,96($16)
	move	$17,$7
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L969
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

$L969:
	lbu	$2,216($sp)
	#nop
	sh	$2,286($16)
	lbu	$2,16($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($16)
	lbu	$3,215($sp)
	li	$2,-1			# 0xffffffff
	sh	$2,928($16)
	lui	$2,%hi($LC7) # high
	addiu	$2,$2,%lo($LC7) # low
	sh	$3,290($16)
	sw	$2,0($17)
	lw	$2,256($sp)
	#nop
	sw	$0,0($2)
	lw	$31,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3
	.align	2
	.globl	UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo
	.ent	UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo
UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	lbu	$3,200($16)
	lh	$2,286($17)
	#nop
	bne	$3,$2,$L973
	lb	$3,0($16)
	lh	$2,288($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L973
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lbu	$3,2($16)
	#nop
	bne	$3,$2,$L971
	lh	$3,290($17)
	lbu	$2,199($16)
	#nop
	beq	$3,$2,$L971
$L973:
	lb	$2,0($16)
	#nop
	bltz	$2,$L974
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	addu	$5,$16,16
	.set	macro
	.set	reorder

$L974:
	lbu	$2,200($16)
	move	$4,$17
	sh	$2,286($17)
	lbu	$2,0($16)
	move	$5,$0
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($17)
	lbu	$2,199($16)
	move	$6,$5
	sw	$0,900($17)
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	sh	$2,290($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$17,772
	.set	macro
	.set	reorder

$L971:
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

	.end	UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo
	.align	2
	.globl	UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
	.ent	UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo:
	.frame	$sp,64,$31		# vars= 32, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,48($sp)
	move	$16,$4
	sw	$17,52($sp)
	move	$17,$5
	sw	$31,56($sp)
	lbu	$3,200($17)
	lh	$2,928($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L976
	lui	$5,%hi($LC6) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addiu	$5,$5,%lo($LC6) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$17,16
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	addu	$6,$16,936
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	sw	$0,932($16)
	lbu	$2,200($17)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	sh	$2,928($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$16,828
	.set	macro
	.set	reorder

$L976:
	lw	$31,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
	.align	2
	.globl	DrawBackground__20tScreenCarSelectDuel
	.ent	DrawBackground__20tScreenCarSelectDuel
DrawBackground__20tScreenCarSelectDuel:
	.frame	$sp,280,$31		# vars= 224, regs= 4/0, args= 40, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,280
	sw	$17,268($sp)
	move	$17,$4
	lui	$2,%hi(Draw_gPlayer1View) # high
	lw	$4,%lo(Draw_gPlayer1View)($2)
	lui	$2,%hi(gFlip) # high
	lw	$5,%lo(gFlip)($2)
	sw	$31,276($sp)
	sw	$18,272($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	sw	$16,264($sp)
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,256
	li	$3,7			# 0x00000007
	lw	$4,0($9)
	move	$18,$2
	sh	$3,284($17)
	sh	$0,256($sp)
	lhu	$3,2($18)
	li	$2,512			# 0x00000200
	sh	$2,260($sp)
	lui	$2,%hi(screenheight) # high
	lhu	$2,%lo(screenheight)($2)
	lw	$6,528482304
	li	$8,-16777216			# 0xff000000
	sh	$3,258($sp)
	sh	$2,262($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	li	$2,290			# 0x00000122
	sh	$2,40($sp)
	li	$2,200			# 0x000000c8
	sh	$2,44($sp)
	li	$2,12			# 0x0000000c
	sh	$2,46($sp)
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$2,130			# 0x00000082
	sh	$2,42($sp)
	.set	noreorder
	.set	nomacro
	jal	TextValue__16tListIteratorCar7tPlayer
	addu	$4,$4,5216
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	addu	$5,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$2,%hi(frontEnd+797) # high
	addu	$16,$sp,48
	lbu	$5,%lo(frontEnd+797)($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$16
	.set	macro
	.set	reorder

	lbu	$2,52($sp)
	move	$4,$17
	addu	$2,$16,$2
	lbu	$2,175($2)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
	sb	$2,245($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$17,936
	.set	macro
	.set	reorder

	lw	$2,940($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L980
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$3,848($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L980
	lui	$2,%hi(gCarObj+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gCarObj+4)($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L980
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,896($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	xori	$4,$2,0x0001
$L980:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L981
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$5,$17,936
	move	$6,$0
	li	$7,65			# 0x00000041
	li	$2,5			# 0x00000005
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadShapes__7tScreenR17tShapeInformationssss
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	addu	$4,$17,828
	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	sw	$0,932($17)
	.set	macro
	.set	reorder

	lh	$3,886($17)
	lh	$2,890($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L981
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L981:
	lw	$2,924($17)
	#nop
	addu	$2,$2,3
	sw	$2,924($17)
	lui	$2,%hi(gCarObj+4) # high
	lw	$2,%lo(gCarObj+4)($2)
	sb	$0,244($sp)
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L983
	lui	$16,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($16)
	lw	$3,896($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L983
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$17,828
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($16)
	#nop
	sw	$2,896($17)
$L983:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	UpdateBrightness__16tScreenCarSelects
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$4,$sp,48
	li	$5,278			# 0x00000116
	li.s	$7,1.70000004768371582031e0
	li.s	$3,-9.89999961853027343750e0
	lui	$2,%hi(showRoomFlag) # high
	sw	$0,%lo(showRoomFlag)($2)
	sw	$3,16($sp)
	lbu	$2,886($17)
	li	$6,184			# 0x000000b8
	sw	$0,24($sp)
	sw	$2,20($sp)
	lw	$3,924($17)
	li	$2,1			# 0x00000001
	sw	$2,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gCarObj+4) # high
	lw	$2,%lo(gCarObj+4)($2)
	#nop
	lw	$2,2264($2)
	#nop
	bne	$2,$0,$L984
	lh	$3,886($17)
	lh	$2,890($17)
	#nop
	bne	$3,$2,$L984
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L984
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,896($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L984
	li	$5,128			# 0x00000080
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$17,828
	.set	macro
	.set	reorder

$L984:
	lw	$2,96($17)
	li	$5,105			# 0x00000069
	lh	$4,128($2)
	lw	$2,132($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,256
	li	$2,512			# 0x00000200
	lw	$4,0($9)
	lui	$16,%hi(screenheight) # high
	sh	$0,256($sp)
	lhu	$3,2($18)
	li	$8,-16777216			# 0xff000000
	sh	$2,260($sp)
	lhu	$2,%lo(screenheight)($16)
	lw	$6,528482304
	addu	$3,$3,128
	addu	$2,$2,-128
	sh	$3,258($sp)
	sh	$2,262($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	lw	$6,%lo(screenheight)($16)
	li	$7,512			# 0x00000200
	srl	$2,$6,31
	addu	$6,$6,$2
	sra	$6,$6,1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$6,16($sp)
	.set	macro
	.set	reorder

	lw	$2,96($17)
	addu	$5,$sp,48
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L985
	lui	$2,%hi(frontEnd+298) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(frontEnd+298)($2)
	li	$2,25			# 0x00000019
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L986
	sh	$2,42($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L1000
	addu	$4,$4,4460
	.set	macro
	.set	reorder

$L986:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	addu	$4,$4,4812
$L1000:
	jal	TextValue__16tListIteratorCar7tPlayer
	sll	$2,$2,16
	sra	$4,$2,16
	addu	$5,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	move	$6,$0
	.set	macro
	.set	reorder

	j	$L988
$L985:
	li	$2,-1			# 0xffffffff
	sb	$2,48($sp)
$L988:
	lw	$2,96($17)
	addu	$5,$sp,48
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(gCarObj) # high
	lw	$2,%lo(gCarObj)($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L989
	lui	$16,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($16)
	lw	$3,892($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L989
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	addu	$4,$17,772
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($16)
	#nop
	sw	$2,892($17)
$L989:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	UpdateBrightness__16tScreenCarSelects
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,48
	li.s	$7,1.70000004768371582031e0
	li.s	$3,-9.89999961853027343750e0
	lui	$2,%hi(showRoomFlag) # high
	sw	$0,%lo(showRoomFlag)($2)
	sw	$3,16($sp)
	lbu	$2,884($17)
	li	$5,278			# 0x00000116
	sw	$0,24($sp)
	sw	$2,20($sp)
	lw	$2,924($17)
	li	$6,79			# 0x0000004f
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gCarObj) # high
	lw	$2,%lo(gCarObj)($2)
	#nop
	lw	$2,2264($2)
	#nop
	bne	$2,$0,$L990
	lh	$3,884($17)
	lh	$2,888($17)
	#nop
	bne	$3,$2,$L990
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L990
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	bne	$2,$0,$L990
	lbu	$2,55($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L991
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L991:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$17,772
	.set	macro
	.set	reorder

$L990:
	beq	$18,$0,$L993
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$17,40
	.set	macro
	.set	reorder

	lw	$2,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L994
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$3,792($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L994
	lui	$2,%hi(gCarObj) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gCarObj)($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L994
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	xori	$4,$2,0x0001
$L994:
	beq	$4,$0,$L993
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$17,772
	.set	macro
	.set	reorder

	lh	$3,888($17)
	lh	$2,884($17)
	#nop
	bne	$3,$2,$L993
	lbu	$2,55($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L997
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L997:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

$L993:
	lw	$2,96($17)
	move	$5,$0
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	lw	$31,276($sp)
	lw	$18,272($sp)
	lw	$17,268($sp)
	lw	$16,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,280
	.set	macro
	.set	reorder

	.end	DrawBackground__20tScreenCarSelectDuel
	.align	2
	.globl	DrawForeground__20tScreenCarSelectDuel
	.ent	DrawForeground__20tScreenCarSelectDuel
DrawForeground__20tScreenCarSelectDuel:
	.frame	$sp,304,$31		# vars= 208, regs= 9/0, args= 56, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,304
	sw	$18,272($sp)
	li	$18,45			# 0x0000002d
	addu	$5,$sp,56
	sw	$19,276($sp)
	move	$19,$0
	sw	$31,296($sp)
	sw	$23,292($sp)
	sw	$22,288($sp)
	sw	$21,284($sp)
	sw	$20,280($sp)
	sw	$17,268($sp)
	sw	$16,264($sp)
	lw	$2,96($4)
	li	$21,4			# 0x00000004
	lh	$3,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	move	$20,$2
	lui	$2,%hi(text2PVals) # high
	addiu	$23,$2,%lo(text2PVals) # low
	sll	$2,$19,16
$L1014:
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1001
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(remap) # high
	addiu	$22,$2,%lo(remap) # low
$L1005:
	sll	$2,$17,16
	sra	$16,$2,16
	slt	$2,$16,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1006
	li	$5,500			# 0x000001f4
	.set	macro
	.set	reorder

	addu	$6,$18,4
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$2,$16,1
	addu	$2,$2,$23
	lh	$4,0($2)
	li	$7,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$21,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1008
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$2,$22
	lw	$3,0($2)
	addu	$2,$sp,56
	lbu	$4,196($2)
	addu	$5,$2,$3
	andi	$2,$4,0x0001
	lbu	$3,48($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1015
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$2,53($5)
	#nop
	addu	$3,$3,$2
	andi	$2,$4,0x0002
$L1015:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1016
	andi	$2,$4,0x0004
	.set	macro
	.set	reorder

	lbu	$2,58($5)
	#nop
	addu	$3,$3,$2
	andi	$2,$4,0x0004
$L1016:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1017
	sll	$2,$3,16
	.set	macro
	.set	reorder

	lbu	$2,63($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,16
$L1017:
	.set	noreorder
	.set	nomacro
	j	$L1012
	sra	$4,$2,16
	.set	macro
	.set	reorder

$L1008:
	move	$4,$0
$L1012:
	move	$5,$0
	li	$6,11			# 0x0000000b
	li	$7,417			# 0x000001a1
	sll	$2,$18,16
	sra	$2,$2,16
	sw	$2,16($sp)
	li	$2,73			# 0x00000049
	sw	$2,20($sp)
	li	$2,3			# 0x00000003
	sw	$2,24($sp)
	sw	$2,32($sp)
	li	$2,1			# 0x00000001
	sw	$2,36($sp)
	li	$2,128			# 0x00000080
	sw	$21,28($sp)
	sw	$0,40($sp)
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$0,48($sp)
	.set	macro
	.set	reorder

	addu	$18,$18,15
	.set	noreorder
	.set	nomacro
	j	$L1005
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1006:
	li	$18,150			# 0x00000096
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$2,%hi(frontEnd+797) # high
	lbu	$5,%lo(frontEnd+797)($2)
	addu	$6,$sp,56
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$19,$19,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1014
	sll	$2,$19,16
	.set	macro
	.set	reorder

$L1001:
	lw	$31,296($sp)
	lw	$23,292($sp)
	lw	$22,288($sp)
	lw	$21,284($sp)
	lw	$20,280($sp)
	lw	$19,276($sp)
	lw	$18,272($sp)
	lw	$17,268($sp)
	lw	$16,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,304
	.set	macro
	.set	reorder

	.end	DrawForeground__20tScreenCarSelectDuel
	.align	2
	.globl	GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo
	.ent	GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo
GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$16,556($2)
	lui	$2,%hi(frontEnd) # high
	addiu	$20,$2,%lo(frontEnd) # low
	lbu	$2,298($20)
	move	$19,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1019
	move	$21,$16
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	addu	$2,$16,$20
	lbu	$5,92($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	move	$6,$18
	.set	macro
	.set	reorder

	sll	$2,$16,1
	addu	$2,$2,$16
	lb	$3,0($18)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$20
	lbu	$2,96($3)
	.set	noreorder
	.set	nomacro
	j	$L1025
	addu	$2,$18,$2
	.set	macro
	.set	reorder

$L1019:
	lui	$2,%hi(carManager) # high
	addiu	$17,$2,%lo(carManager) # low
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1026
	move	$4,$17
	.set	macro
	.set	reorder

	move	$19,$0
$L1026:
	move	$16,$19
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1022
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1024
	move	$2,$0
	.set	macro
	.set	reorder

$L1022:
	move	$6,$18
	addu	$2,$21,$20
	lbu	$5,291($2)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$16
	.set	macro
	.set	reorder

	lbu	$2,197($18)
	#nop
	addu	$2,$18,$2
$L1025:
	lbu	$2,175($2)
	#nop
	sb	$2,197($18)
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	lui	$4,%hi(frontEnd) # high
	lbu	$3,556($2)
	addiu	$4,$4,%lo(frontEnd) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	lb	$3,0($18)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$4
	lbu	$3,192($3)
	li	$2,1			# 0x00000001
	sb	$3,199($18)
$L1024:
	lw	$31,40($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo
	.align	2
	.globl	DrawVideoWall__25tScreenCarSelectTwoPlayers
	.ent	DrawVideoWall__25tScreenCarSelectTwoPlayers
DrawVideoWall__25tScreenCarSelectTwoPlayers:
	.frame	$sp,264,$31		# vars= 208, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,264
	sw	$18,248($sp)
	move	$18,$4
	sw	$16,240($sp)
	move	$16,$5
	addu	$5,$sp,32
	sw	$31,256($sp)
	sw	$19,252($sp)
	sw	$17,244($sp)
	lw	$2,96($18)
	move	$17,$0
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	move	$19,$2
	sll	$16,$16,16
	sra	$16,$16,16
	sll	$4,$17,16
$L1037:
	sra	$4,$4,16
	move	$5,$0
	move	$6,$5
	lh	$2,92($18)
	subu	$7,$0,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1037
	sll	$4,$17,16
	.set	macro
	.set	reorder

	lhu	$2,58($18)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1032
	lw	$2,900($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1032
	lui	$17,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($17)
	#nop
	lbu	$2,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1033
	move	$6,$0
	.set	macro
	.set	reorder

	li	$6,105			# 0x00000069
$L1033:
	addu	$16,$18,772
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetOffset__10tVideoWallss
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($17)
	#nop
	lbu	$2,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1034
	li	$7,45			# 0x0000002d
	.set	macro
	.set	reorder

	li	$7,150			# 0x00000096
$L1034:
	move	$4,$16
	li	$5,248			# 0x000000f8
	.set	noreorder
	.set	nomacro
	jal	SetAvailableText__10tVideoWallsss
	li	$6,270			# 0x0000010e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($18)
$L1032:
	lh	$2,92($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1038
	addu	$16,$18,772
	.set	macro
	.set	reorder

	lw	$2,84($18)
	#nop
	beq	$2,$0,$L1038
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$18,772
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$16,$18,772
$L1038:
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$5,$19,16
	.set	noreorder
	.set	nomacro
	jal	SetValid__10tVideoWalls
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$5,39($sp)
	.set	noreorder
	.set	nomacro
	jal	SetAvailable__10tVideoWalls
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw__10tVideoWall
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,256($sp)
	lw	$19,252($sp)
	lw	$18,248($sp)
	lw	$17,244($sp)
	lw	$16,240($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,264
	.set	macro
	.set	reorder

	.end	DrawVideoWall__25tScreenCarSelectTwoPlayers
	.rdata
	.align	2
$LC8:
	.ascii	"zcarsb\000"
	.text
	.align	2
	.globl	GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3
	.ent	GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3
GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3:
	.frame	$sp,240,$31		# vars= 208, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	move	$3,$4
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	sw	$18,232($sp)
	lw	$18,256($sp)
	li	$2,52			# 0x00000034
	sw	$31,236($sp)
	sw	$17,228($sp)
	sw	$16,224($sp)
	sh	$2,0($5)
	move	$5,$0
	li	$2,5			# 0x00000005
	sh	$2,0($6)
	addu	$6,$sp,16
	li	$2,-1			# 0xffffffff
	move	$17,$7
	sh	$2,286($3)
	sh	$2,288($3)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	sh	$2,290($3)
	.set	macro
	.set	reorder

	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lui	$5,%hi($LC3) # high
	addiu	$5,$5,%lo($LC3) # low
	addu	$6,$sp,32
	lui	$2,%hi($LC8) # high
	addiu	$2,$2,%lo($LC8) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,0($17)
	.set	macro
	.set	reorder

	sw	$16,0($18)
	lw	$31,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3
	.align	2
	.globl	UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo
	.ent	UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo
UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	lbu	$3,200($16)
	lh	$2,286($17)
	#nop
	bne	$3,$2,$L1043
	lb	$3,0($16)
	lh	$2,288($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1043
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lbu	$3,2($16)
	#nop
	bne	$3,$2,$L1041
	lh	$3,290($17)
	lbu	$2,199($16)
	#nop
	beq	$3,$2,$L1041
$L1043:
	lb	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L1044
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	addu	$5,$16,16
	.set	macro
	.set	reorder

$L1044:
	lbu	$2,200($16)
	#nop
	sh	$2,286($17)
	lbu	$2,0($16)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,288($17)
	lbu	$2,199($16)
	addu	$4,$17,772
	sw	$0,900($17)
	.set	noreorder
	.set	nomacro
	jal	TurnOff__10tVideoWall
	sh	$2,290($17)
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

$L1041:
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

	.end	UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo
	.align	2
	.globl	TurnOffVideoWall__25tScreenCarSelectTwoPlayer
	.ent	TurnOffVideoWall__25tScreenCarSelectTwoPlayer
TurnOffVideoWall__25tScreenCarSelectTwoPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	TurnOffInstant__10tVideoWall
	addu	$4,$4,772
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

	.end	TurnOffVideoWall__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	DrawBackground__25tScreenCarSelectTwoPlayer
	.ent	DrawBackground__25tScreenCarSelectTwoPlayer
DrawBackground__25tScreenCarSelectTwoPlayer:
	.frame	$sp,296,$31		# vars= 224, regs= 7/0, args= 40, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$16,264($sp)
	move	$16,$4
	lui	$2,%hi(Draw_gPlayer1View) # high
	lw	$4,%lo(Draw_gPlayer1View)($2)
	lui	$2,%hi(gFlip) # high
	lw	$5,%lo(gFlip)($2)
	sw	$20,280($sp)
	li	$20,79			# 0x0000004f
	sw	$31,288($sp)
	sw	$21,284($sp)
	sw	$19,276($sp)
	sw	$18,272($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	sw	$17,268($sp)
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,256
	lw	$4,0($9)
	move	$21,$2
	sh	$0,256($sp)
	lhu	$3,2($21)
	li	$2,512			# 0x00000200
	sh	$2,260($sp)
	lui	$2,%hi(screenheight) # high
	lhu	$2,%lo(screenheight)($2)
	lw	$6,528482304
	li	$8,-16777216			# 0xff000000
	sh	$3,258($sp)
	sh	$2,262($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	lui	$18,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($18)
	li	$2,290			# 0x00000122
	sh	$2,40($sp)
	li	$2,25			# 0x00000019
	sh	$2,42($sp)
	lbu	$2,556($3)
	li	$19,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L1067
	li	$2,200			# 0x000000c8
	.set	macro
	.set	reorder

	li	$2,130			# 0x00000082
	sh	$2,42($sp)
	li	$2,200			# 0x000000c8
$L1067:
	sh	$2,44($sp)
	li	$2,12			# 0x0000000c
	addu	$17,$sp,48
	sh	$2,46($sp)
	lw	$2,96($16)
	move	$5,$17
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1050
	li	$3,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($18)
	sh	$3,42($sp)
	lbu	$2,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L1051
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	li	$20,184			# 0x000000b8
	sh	$2,42($sp)
$L1051:
	lw	$2,924($16)
	addu	$5,$sp,40
	addu	$2,$2,3
	sw	$2,924($16)
	lb	$4,48($sp)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	addu	$4,$4,289
	.set	macro
	.set	reorder

	lw	$2,96($16)
	move	$5,$17
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($18)
	lui	$3,%hi(gCarObj) # high
	lbu	$2,556($2)
	addiu	$17,$3,%lo(gCarObj) # low
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$2,0($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1065
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,892($16)
$L1065:
	lw	$2,%lo(FEApp)($18)
	#nop
	lbu	$2,556($2)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$2,0($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1068
	move	$4,$16
	.set	macro
	.set	reorder

	lh	$3,884($16)
	lh	$2,888($16)
	#nop
	bne	$3,$2,$L1054
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1054
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($16)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	bne	$2,$0,$L1054
	lbu	$2,55($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1055
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
	move	$4,$16
$L1055:
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$4,$16
$L1054:
$L1068:
	.set	noreorder
	.set	nomacro
	jal	UpdateBrightness__16tScreenCarSelects
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	li.s	$7,1.70000004768371582031e0
	lw	$3,%lo(FEApp)($2)
	lui	$2,%hi(showRoomFlag) # high
	sw	$0,%lo(showRoomFlag)($2)
	li.s	$2,-9.89999961853027343750e0
	lbu	$3,556($3)
	addu	$4,$sp,48
	sw	$2,16($sp)
	lbu	$2,884($16)
	li	$5,278			# 0x00000116
	sw	$0,24($sp)
	sw	$2,20($sp)
	lw	$2,924($16)
	move	$6,$20
	sw	$3,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1066
	move	$4,$16
	.set	macro
	.set	reorder

$L1050:
	li	$2,-1			# 0xffffffff
	sb	$2,48($sp)
	lw	$2,96($16)
	move	$5,$17
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	li.s	$7,1.70000004768371582031e0
	lw	$3,%lo(FEApp)($18)
	lui	$2,%hi(showRoomFlag) # high
	sw	$0,%lo(showRoomFlag)($2)
	li.s	$2,-9.89999961853027343750e0
	lbu	$3,556($3)
	move	$4,$17
	sw	$2,16($sp)
	lbu	$2,884($16)
	li	$5,278			# 0x00000116
	sw	$0,24($sp)
	sw	$2,20($sp)
	lw	$2,924($16)
	li	$6,79			# 0x0000004f
	sw	$3,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,128($2)
	lw	$2,132($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
$L1066:
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$16,40
	.set	macro
	.set	reorder

	lw	$2,44($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1057
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$3,792($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1057
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($2)
	lui	$3,%hi(gCarObj) # high
	lbu	$2,556($2)
	addiu	$3,$3,%lo(gCarObj) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$2,2264($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1057
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,892($16)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	xori	$4,$2,0x0001
$L1057:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1058
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($2)
	#nop
	lbu	$3,556($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1059
	move	$7,$0
	.set	macro
	.set	reorder

	li	$7,65			# 0x00000041
$L1059:
	move	$4,$16
	addu	$5,$16,40
	move	$6,$0
	li	$2,5			# 0x00000005
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadShapes__7tScreenR17tShapeInformationssss
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TurnOn__10tVideoWall
	addu	$4,$16,772
	.set	macro
	.set	reorder

	lh	$3,888($16)
	lh	$2,884($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1069
	lui	$17,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lbu	$2,55($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1061
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$5,128			# 0x00000080
$L1061:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetBrightness__16tScreenCarSelectss
	move	$6,$0
	.set	macro
	.set	reorder

$L1058:
	lui	$17,%hi(FEApp) # high
$L1069:
	lw	$2,%lo(FEApp)($17)
	sh	$0,42($sp)
	lbu	$2,556($2)
	li	$18,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L1062
	li	$2,105			# 0x00000069
	.set	macro
	.set	reorder

	sh	$2,42($sp)
$L1062:
	lw	$2,96($16)
	lh	$5,42($sp)
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,136($2)
	lw	$2,140($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(screenheight) # high
	sh	$0,256($sp)
	lhu	$4,2($21)
	lw	$3,%lo(screenheight)($2)
	li	$2,512			# 0x00000200
	sh	$2,260($sp)
	srl	$2,$3,31
	addu	$3,$3,$2
	lw	$2,%lo(FEApp)($17)
	sra	$3,$3,1
	sh	$4,258($sp)
	sh	$3,262($sp)
	lbu	$2,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L1070
	li	$9,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	addu	$2,$4,$3
	sh	$2,258($sp)
$L1070:
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,256
	li	$8,-16777216			# 0xff000000
	lw	$4,0($9)
	lw	$6,528482304
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	lw	$31,288($sp)
	lw	$21,284($sp)
	lw	$20,280($sp)
	lw	$19,276($sp)
	lw	$18,272($sp)
	lw	$17,268($sp)
	lw	$16,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	DrawBackground__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	DrawForeground__25tScreenCarSelectTwoPlayer
	.ent	DrawForeground__25tScreenCarSelectTwoPlayer
DrawForeground__25tScreenCarSelectTwoPlayer:
	.frame	$sp,296,$31		# vars= 208, regs= 8/0, args= 56, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$16,264($sp)
	lui	$16,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($16)
	move	$6,$4
	sw	$17,268($sp)
	sw	$31,292($sp)
	sw	$22,288($sp)
	sw	$21,284($sp)
	sw	$20,280($sp)
	sw	$19,276($sp)
	sw	$18,272($sp)
	lbu	$3,556($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1072
	li	$17,45			# 0x0000002d
	.set	macro
	.set	reorder

	li	$17,150			# 0x00000096
$L1072:
	lw	$2,96($6)
	addu	$5,$sp,56
	lh	$4,104($2)
	lw	$2,108($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	lw	$3,%lo(FEApp)($16)
	#nop
	lbu	$3,556($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1073
	move	$20,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$3,5784($4)
	li	$2,-2			# 0xfffffffe
	and	$5,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1075
	sw	$5,5784($4)
	.set	macro
	.set	reorder

	lbu	$3,58($sp)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1090
	move	$18,$0
	.set	macro
	.set	reorder

$L1075:
	ori	$2,$5,0x0001
	.set	noreorder
	.set	nomacro
	j	$L1076
	sw	$2,5784($4)
	.set	macro
	.set	reorder

$L1073:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$3,6032($4)
	li	$2,-2			# 0xfffffffe
	and	$5,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1078
	sw	$5,6032($4)
	.set	macro
	.set	reorder

	lbu	$3,58($sp)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1090
	move	$18,$0
	.set	macro
	.set	reorder

$L1078:
	ori	$2,$5,0x0001
	sw	$2,6032($4)
$L1076:
	move	$18,$0
$L1090:
	lui	$2,%hi(text2PVals) # high
	addiu	$22,$2,%lo(text2PVals) # low
	lui	$2,%hi(remap) # high
	addiu	$21,$2,%lo(remap) # low
	addu	$19,$sp,56
$L1079:
	sll	$2,$18,16
	sra	$16,$2,16
	slt	$2,$16,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1071
	li	$5,500			# 0x000001f4
	.set	macro
	.set	reorder

	addu	$6,$17,4
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$2,$16,1
	addu	$2,$2,$22
	li	$7,1			# 0x00000001
	lh	$4,0($2)
	li	$2,14			# 0x0000000e
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1087
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$2,$21
	lw	$2,0($2)
	lbu	$4,196($19)
	addu	$5,$19,$2
	andi	$2,$4,0x0001
	lbu	$3,48($5)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1091
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lbu	$2,53($5)
	#nop
	addu	$3,$3,$2
	andi	$2,$4,0x0002
$L1091:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1092
	andi	$2,$4,0x0004
	.set	macro
	.set	reorder

	lbu	$2,58($5)
	#nop
	addu	$3,$3,$2
	andi	$2,$4,0x0004
$L1092:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1093
	sll	$2,$3,16
	.set	macro
	.set	reorder

	lbu	$2,63($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,16
$L1093:
	.set	noreorder
	.set	nomacro
	j	$L1088
	sra	$4,$2,16
	.set	macro
	.set	reorder

$L1087:
	move	$4,$0
$L1088:
	move	$5,$0
	li	$6,11			# 0x0000000b
	li	$7,417			# 0x000001a1
	sll	$2,$17,16
	sra	$2,$2,16
	sw	$2,16($sp)
	li	$2,73			# 0x00000049
	li	$3,3			# 0x00000003
	sw	$2,20($sp)
	li	$2,4			# 0x00000004
	sw	$2,28($sp)
	li	$2,1			# 0x00000001
	sw	$2,36($sp)
	li	$2,128			# 0x00000080
	sw	$3,24($sp)
	sw	$3,32($sp)
	sw	$0,40($sp)
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$0,48($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,15
	.set	noreorder
	.set	nomacro
	j	$L1079
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L1071:
	lw	$31,292($sp)
	lw	$22,288($sp)
	lw	$21,284($sp)
	lw	$20,280($sp)
	lw	$19,276($sp)
	lw	$18,272($sp)
	lw	$17,268($sp)
	lw	$16,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	DrawForeground__25tScreenCarSelectTwoPlayer
	.rdata
	.align	2
$LC9:
	.ascii	"\000"
	.text
	.align	2
	.globl	SetDialog__25tScreenCarSelectTwoPlayer
	.ent	SetDialog__25tScreenCarSelectTwoPlayer
SetDialog__25tScreenCarSelectTwoPlayer:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lbu	$4,556($2)
	#nop
	sll	$3,$4,2
	addu	$2,$2,$3
	lw	$2,560($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1095
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L1096
	li	$2,60			# 0x0000003c
	.set	macro
	.set	reorder

	li	$2,-60			# 0xffffffc4
$L1096:
	li	$4,680			# 0x000002a8
	addu	$17,$17,928
	sh	$0,124($17)
	sh	$2,126($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$16,100($17)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	subu	$4,$4,$16
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$18,$2
	.set	macro
	.set	reorder

	lui	$16,%hi($LC9) # high
	addiu	$16,$16,%lo($LC9) # low
	move	$4,$16
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$16,144($4)
	.set	macro
	.set	reorder

	j	$L1094
$L1095:
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$17,928
	.set	macro
	.set	reorder

$L1094:
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

	.end	SetDialog__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer
	.ent	AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer
AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$5,%hi($LC4) # high
	li	$4,16000			# 0x00003e80
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	sw	$2,48($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	InitializeVideoWall__25tScreenCarSelectTwoPlayer
	.ent	InitializeVideoWall__25tScreenCarSelectTwoPlayer
InitializeVideoWall__25tScreenCarSelectTwoPlayer:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$17,36($sp)
	addu	$17,$16,772
	move	$4,$17
	li	$2,5			# 0x00000005
	sw	$2,16($sp)
	lui	$2,%hi(tvSplitOrder) # high
	addiu	$2,$2,%lo(tvSplitOrder) # low
	addu	$5,$16,292
	sw	$31,40($sp)
	sw	$2,20($sp)
	sw	$0,24($sp)
	lw	$6,40($16)
	.set	noreorder
	.set	nomacro
	jal	Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
	move	$7,$0
	.set	macro
	.set	reorder

	lhu	$2,58($16)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1101
	.set	noreorder
	.set	nomacro
	jal	UpdateImages__10tVideoWall
	move	$4,$17
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,900($16)
$L1101:
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

	.end	InitializeVideoWall__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	Initialize__25tScreenCarSelectTwoPlayer
	.ent	Initialize__25tScreenCarSelectTwoPlayer
Initialize__25tScreenCarSelectTwoPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__16tScreenCarSelect
	move	$16,$4
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sh	$0,284($16)
	sh	$2,286($16)
	sh	$2,288($16)
	sh	$2,290($16)
	sh	$0,890($16)
	sh	$0,888($16)
	sh	$0,886($16)
	sh	$0,884($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	lui	$2,%hi(gShowroomLights) # high
	sw	$0,%lo(gShowroomLights)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	Cleanup__25tScreenCarSelectTwoPlayer
	.ent	Cleanup__25tScreenCarSelectTwoPlayer
Cleanup__25tScreenCarSelectTwoPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$16,928
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__16tScreenCarSelect
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

	.end	Cleanup__25tScreenCarSelectTwoPlayer
	.align	2
	.globl	GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo
	.ent	GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo
GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	lui	$2,%hi(PinkSlipsScreenState) # high
	addiu	$4,$2,%lo(PinkSlipsScreenState) # low
	lw	$3,%lo(PinkSlipsScreenState)($2)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1110
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L1112
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($2)
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	lui	$4,%hi(carManager) # high
	lbu	$7,556($3)
	addiu	$4,$4,%lo(carManager) # low
	addu	$2,$7,$2
	lbu	$5,293($2)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	move	$6,$16
	.set	macro
	.set	reorder

	lbu	$2,197($16)
	#nop
	addu	$2,$16,$2
	lbu	$3,175($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L1112
	sb	$3,197($16)
	.set	macro
	.set	reorder

$L1110:
	move	$2,$0
$L1112:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo
	.align	2
	.globl	DrawBackground__25tScreenPinkSlipsCarSelect
	.ent	DrawBackground__25tScreenPinkSlipsCarSelect
DrawBackground__25tScreenPinkSlipsCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DoMemCardStuff__25tScreenPinkSlipsCarSelect
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawBackground__25tScreenCarSelectTwoPlayer
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,1096($16)
	#nop
	beq	$2,$0,$L1113
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$16,928
	.set	macro
	.set	reorder

$L1113:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawBackground__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	DoMemCardStuff__25tScreenPinkSlipsCarSelect
	.ent	DoMemCardStuff__25tScreenPinkSlipsCarSelect
DoMemCardStuff__25tScreenPinkSlipsCarSelect:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	lui	$21,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($21)
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$19,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L1117
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$17,5			# 0x00000005
$L1117:
	lw	$2,1096($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1116
	li	$22,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$22,$L1146
	lui	$2,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(PinkSlipsScreenState)($2)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1116
	lui	$2,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

$L1146:
	addiu	$3,$2,%lo(PinkSlipsScreenState) # low
	lw	$2,%lo(PinkSlipsScreenState)($2)
	li	$20,8			# 0x00000008
	beq	$2,$20,$L1116
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L1116
	sll	$23,$19,2
	.set	macro
	.set	reorder

	addu	$16,$23,$3
	lw	$4,0($16)
	li	$2,6			# 0x00000006
	beq	$4,$2,$L1116
	lw	$2,1060($18)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L1124
	.set	noreorder
	.set	nomacro
	j	$L1116
	sw	$0,1080($18)
	.set	macro
	.set	reorder

$L1124:
	lw	$3,1080($18)
	#nop
	slt	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1125
	addu	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1116
	sw	$2,1080($18)
	.set	macro
	.set	reorder

$L1125:
	beq	$4,$20,$L1132
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	move	$4,$17
	.set	macro
	.set	reorder

	sw	$2,1084($18)
	lw	$3,0($2)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1127
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1132
	sw	$0,0($16)
	.set	macro
	.set	reorder

$L1127:
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1147
	lui	$18,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	bne	$2,$0,$L1147
	lw	$4,%lo(FEApp)($21)
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	sw	$20,0($16)
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($21)
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	move	$17,$19
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	LoadGame__FsbT1
	move	$6,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1130
	lui	$2,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(carManager) # low
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumPinkSlipsCars__11tCarManagers
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CheapestCarStockPrice__11tCarManager
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumPinkSlipsCars__11tCarManagers
	move	$5,$17
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	li	$3,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L1131
	move	$20,$0
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	j	$L1132
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L1131:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumPinkSlipsCars__11tCarManagers
	move	$5,$17
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1135
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetNumPinkSlipsCars__11tCarManagers
	move	$5,$17
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L1134
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	.set	noreorder
	.set	nomacro
	jal	CheapestCarStockPrice__11tCarManager
	addu	$16,$23,$16
	.set	macro
	.set	reorder

	lw	$3,76($16)
	#nop
	slt	$3,$3,$2
	bne	$3,$0,$L1134
$L1135:
	li	$20,1			# 0x00000001
$L1134:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1133
	sll	$3,$19,2
	.set	macro
	.set	reorder

	lui	$2,%hi(PinkSlipsScreenState) # high
	addiu	$2,$2,%lo(PinkSlipsScreenState) # low
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1137
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

$L1133:
	lui	$2,%hi(PinkSlipsScreenState) # high
	addiu	$2,$2,%lo(PinkSlipsScreenState) # low
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1137
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

$L1130:
	.set	noreorder
	.set	nomacro
	beq	$3,$22,$L1139
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1140
	lui	$2,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1141
	addiu	$2,$2,%lo(PinkSlipsScreenState) # low
	.set	macro
	.set	reorder

$L1139:
	.set	noreorder
	.set	nomacro
	j	$L1132
	sw	$3,0($16)
	.set	macro
	.set	reorder

$L1140:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$L1132
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L1141:
	sll	$3,$19,2
	addu	$3,$3,$2
	li	$2,2			# 0x00000002
$L1137:
	sw	$2,0($3)
$L1132:
	lui	$18,%hi(PinkSlipsScreenState) # high
$L1147:
	addiu	$20,$18,%lo(PinkSlipsScreenState) # low
	sll	$2,$19,2
	addu	$2,$2,$20
	lw	$2,0($2)
	li	$17,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L1143
	lui	$16,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,6612
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,6612
	.set	macro
	.set	reorder

$L1143:
	lw	$3,%lo(PinkSlipsScreenState)($18)
	#nop
	bne	$3,$17,$L1116
	lw	$2,4($20)
	#nop
	bne	$2,$3,$L1116
	jal	DeInit_Memcard__Fv
	jal	SetLicensePlate__Fv
$L1116:
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

	.end	DoMemCardStuff__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	DrawForeground__25tScreenPinkSlipsCarSelect
	.ent	DrawForeground__25tScreenPinkSlipsCarSelect
DrawForeground__25tScreenPinkSlipsCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	DrawForeground__25tScreenCarSelectTwoPlayer
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DrawForeground__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	Initialize__25tScreenPinkSlipsCarSelect
	.ent	Initialize__25tScreenPinkSlipsCarSelect
Initialize__25tScreenPinkSlipsCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$4,1			# 0x00000001
	lui	$2,%hi(PinkSlipsScreenState) # high
	sw	$31,20($sp)
	sw	$0,1080($16)
	sw	$0,1088($16)
	sw	$0,1092($16)
	sw	$0,%lo(PinkSlipsScreenState)($2)
	addiu	$2,$2,%lo(PinkSlipsScreenState) # low
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$0,4($2)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	sw	$2,1084($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Initialize__25tScreenCarSelectTwoPlayer
	sw	$0,1096($4)
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

	.end	Initialize__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	Cleanup__25tScreenPinkSlipsCarSelect
	.ent	Cleanup__25tScreenPinkSlipsCarSelect
Cleanup__25tScreenPinkSlipsCarSelect:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	addu	$4,$16,928
	li	$2,1			# 0x00000001
	sw	$31,20($sp)
	sw	$2,1096($16)
	lui	$2,%hi(PinkSlipsScreenState) # high
	li	$3,7			# 0x00000007
	sw	$3,%lo(PinkSlipsScreenState)($2)
	addiu	$2,$2,%lo(PinkSlipsScreenState) # low
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	sw	$3,4($2)
	.set	macro
	.set	reorder

	jal	DeInit_Memcard__Fv
	.set	noreorder
	.set	nomacro
	jal	Cleanup__25tScreenCarSelectTwoPlayer
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

	.end	Cleanup__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	SetDialog__25tScreenPinkSlipsCarSelect
	.ent	SetDialog__25tScreenPinkSlipsCarSelect
SetDialog__25tScreenPinkSlipsCarSelect:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$16,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L1155
	li	$3,60			# 0x0000003c
	.set	macro
	.set	reorder

	li	$3,-60			# 0xffffffc4
$L1155:
	addu	$2,$18,928
	sh	$0,124($2)
	sh	$3,126($2)
	sh	$16,100($2)
	lui	$2,%hi(PinkSlipsScreenState) # high
	addiu	$4,$2,%lo(PinkSlipsScreenState) # low
	lw	$3,%lo(PinkSlipsScreenState)($2)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1158
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$16,$2,$L1159
$L1158:
	lw	$2,1096($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1159
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$3,$2,$4
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L1160
	sw	$0,1088($18)
$L1160:
	lw	$3,0($3)
	#nop
	sltu	$2,$3,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1154
	lui	$2,%hi($L1183) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L1183) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L1183:
	.word	$L1167
	.word	$L1176
	.word	$L1173
	.word	$L1175
	.word	$L1177
	.word	$L1179
	.word	$L1163
	.word	$L1159
	.word	$L1180
	.text
$L1159:
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$18,928
	.set	macro
	.set	reorder

	j	$L1154
$L1163:
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	sll	$3,$16,2
	addu	$2,$2,$3
	lw	$2,560($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1165
	lui	$3,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(PinkSlipsScreenState) # low
	li	$2,1			# 0x00000001
	subu	$2,$2,$16
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,0($2)
	li	$2,6			# 0x00000006
	beq	$3,$2,$L1164
$L1165:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,680			# 0x000002a8
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	subu	$4,$4,$16
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	lui	$16,%hi($LC9) # high
	addiu	$16,$16,%lo($LC9) # low
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$18,928
	.set	noreorder
	.set	nomacro
	j	$L1185
	sw	$16,144($4)
	.set	macro
	.set	reorder

$L1164:
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$18,928
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1187
	sw	$0,1088($18)
	.set	macro
	.set	reorder

$L1167:
	lw	$2,1092($18)
	#nop
	bne	$2,$0,$L1168
	lw	$2,1088($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1188
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,1088($18)
	lui	$2,%hi(ticks) # high
$L1188:
	lw	$2,%lo(ticks)($2)
	lw	$3,1088($18)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,800
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1170
	addu	$4,$16,683
	.set	macro
	.set	reorder

	addu	$4,$16,681
$L1170:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$18,928
	.set	macro
	.set	reorder

	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L1154
$L1168:
	lw	$2,1088($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1189
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,1088($18)
	lui	$2,%hi(ticks) # high
$L1189:
	lw	$2,%lo(ticks)($2)
	lw	$3,1088($18)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,901
	bne	$2,$0,$L1154
	.set	noreorder
	.set	nomacro
	j	$L1187
	sw	$0,1088($18)
	.set	macro
	.set	reorder

$L1173:
	.set	noreorder
	.set	nomacro
	j	$L1174
	addu	$4,$16,687
	.set	macro
	.set	reorder

$L1175:
	.set	noreorder
	.set	nomacro
	j	$L1174
	addu	$4,$16,689
	.set	macro
	.set	reorder

$L1176:
	addu	$4,$16,685
$L1174:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$18,928
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,1092($18)
	.set	noreorder
	.set	nomacro
	j	$L1154
	sw	$0,1088($18)
	.set	macro
	.set	reorder

$L1177:
	.set	noreorder
	.set	nomacro
	j	$L1178
	addu	$4,$16,813
	.set	macro
	.set	reorder

$L1179:
	.set	noreorder
	.set	nomacro
	j	$L1178
	addu	$4,$16,815
	.set	macro
	.set	reorder

$L1180:
	addu	$4,$16,640
$L1178:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$18,928
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,144($4)
$L1185:
	jal	Display__11tDialogBase
	sw	$0,1088($18)
$L1187:
	sw	$0,1092($18)
$L1154:
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

	.end	SetDialog__25tScreenPinkSlipsCarSelect
	.align	2
	.globl	ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$5,0($6)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L1191
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L1192
	lui	$2,%hi(PinkSlipsScreenState) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(PinkSlipsScreenState) # low
	lw	$5,%lo(PinkSlipsScreenState)($2)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L1198
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L1192
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1198:
	sw	$2,0($6)
$L1192:
	lw	$3,0($6)
	li	$2,16			# 0x00000010
	bne	$3,$2,$L1190
$L1191:
	lui	$5,%hi(PinkSlipsScreenState) # high
	lw	$3,%lo(PinkSlipsScreenState)($5)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1196
	addiu	$6,$5,%lo(PinkSlipsScreenState) # low
	.set	macro
	.set	reorder

	lw	$2,4($6)
	#nop
	beq	$2,$3,$L1190
$L1196:
	li	$2,1			# 0x00000001
	sw	$2,1096($4)
	li	$2,7			# 0x00000007
	addu	$4,$4,928
	sw	$2,%lo(PinkSlipsScreenState)($5)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	sw	$2,4($6)
	.set	macro
	.set	reorder

$L1190:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3
	.ent	GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3
GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3:
	.frame	$sp,240,$31		# vars= 208, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	move	$3,$4
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	sw	$18,232($sp)
	lw	$18,256($sp)
	li	$2,52			# 0x00000034
	sw	$31,236($sp)
	sw	$17,228($sp)
	sw	$16,224($sp)
	sh	$2,0($5)
	move	$5,$0
	li	$2,5			# 0x00000005
	sh	$2,0($6)
	addu	$6,$sp,16
	li	$2,-1			# 0xffffffff
	move	$17,$7
	sh	$2,286($3)
	sh	$2,288($3)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	sh	$2,290($3)
	.set	macro
	.set	reorder

	lui	$16,%hi(gSwapFileName) # high
	addiu	$16,$16,%lo(gSwapFileName) # low
	move	$4,$16
	lui	$5,%hi($LC3) # high
	addiu	$5,$5,%lo($LC3) # low
	addu	$6,$sp,32
	lui	$2,%hi($LC8) # high
	addiu	$2,$2,%lo($LC8) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,0($17)
	.set	macro
	.set	reorder

	sw	$16,0($18)
	lw	$31,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl ___25tScreenPinkSlipsCarSelect
___25tScreenPinkSlipsCarSelect:
	addiu $29, $29, -32
	sw    $16, 16($29)
	addu  $16, $4, $0
	sw    $17, 20($29)
	addu  $17, $5, $0
	addiu $4, $16, 928
	sw    $31, 24($29)
	jal   ___7tScreen
	 addiu $5, $0, 2
	addu  $4, $16, $0
	jal   ___16tScreenCarSelect
	 addu  $5, $17, $0
	lw    $31, 24($29)
	lw    $17, 20($29)
	lw    $16, 16($29)
	jr    $31
	 addiu $29, $29, 32
	.set at
	.set reorder
	.set	reorder
	.set noat
	.set	noreorder
	.set noreorder
	.globl ___25tScreenCarSelectTwoPlayer
___25tScreenCarSelectTwoPlayer:
	addiu $29, $29, -32
	sw    $16, 16($29)
	addu  $16, $4, $0
	sw    $17, 20($29)
	addu  $17, $5, $0
	addiu $4, $16, 928
	sw    $31, 24($29)
	jal   ___7tScreen
	 addiu $5, $0, 2
	addu  $4, $16, $0
	jal   ___16tScreenCarSelect
	 addu  $5, $17, $0
	lw    $31, 24($29)
	lw    $17, 20($29)
	lw    $16, 16($29)
	jr    $31
	 addiu $29, $29, 32
	.set at
	.set reorder
	.set	reorder

 #NO_APP
	.align	2
	.globl	___20tScreenCarSelectDuel
	.ent	___20tScreenCarSelectDuel
___20tScreenCarSelectDuel:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___16tScreenCarSelect
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___20tScreenCarSelectDuel

	.lcomm	textVals,10

	.lcomm	text2PVals,10

	.lcomm	tvOrder,20

	.lcomm	tvSplitOrder,10

	.lcomm	gRotateOffset,16

	.lcomm	gSwapFileName,80

	.lcomm	WaitingString,50
	.globl	screenCarSelect
	.data
	.align	2
screenCarSelect:
	.space	4
