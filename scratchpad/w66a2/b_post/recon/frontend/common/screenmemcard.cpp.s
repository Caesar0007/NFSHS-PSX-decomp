	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screenmemcard.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"zmemcrd\000"
	.text
	.align	2
	.globl	GetShapeInfo__14tScreenMemcardRsT1PPcT3
	.ent	GetShapeInfo__14tScreenMemcardRsT1PPcT3
GetShapeInfo__14tScreenMemcardRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$0,0($6)
	sw	$0,0($2)
	li	$2,60			# 0x0000003c
	sh	$2,0($5)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__14tScreenMemcardRsT1PPcT3
	.align	2
	.globl	DrawIcon__14tScreenMemcardP8shapetbliiiis
	.ent	DrawIcon__14tScreenMemcardP8shapetbliiiis
DrawIcon__14tScreenMemcardP8shapetbliiiis:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	move	$8,$5
	sw	$21,44($sp)
	move	$21,$6
	sw	$23,52($sp)
	move	$23,$7
	li	$3,4			# 0x00000004
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$22,48($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$2,12($8)
	lhu	$9,88($sp)
	lbu	$22,0($8)
	lh	$fp,4($8)
	lh	$10,6($8)
	sll	$17,$2,4
	sra	$17,$17,20
	move	$4,$17
	sll	$2,$2,20
	sra	$2,$2,20
	move	$20,$2
	andi	$2,$20,0x003f
	sll	$2,$2,$3
	div	$19,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$17,$L602
	sw	$10,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$17,255
$L602:
	sra	$18,$4,8
	sll	$2,$18,8
	subu	$18,$17,$2
	li	$7,528482304			# 0x1f800000
	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$16,0($7)
	lw	$5,528482304
	lw	$3,0($16)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,40
	lw	$2,0($5)
	and	$4,$16,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,46			# 0x0000002e
	sb	$2,7($16)
	li	$2,9			# 0x00000009
	sb	$2,3($16)
	li	$2,-128			# 0xffffff80
	subu	$2,$2,$9
	move	$4,$8
	sb	$2,4($16)
	sb	$2,5($16)
	.set	noreorder
	.set	nomacro
	jal	shapetoclutid
	sb	$2,6($16)
	.set	macro
	.set	reorder

	andi	$3,$22,0x0003
	sll	$3,$3,7
	sh	$2,14($16)
	andi	$2,$17,0x0100
	sra	$2,$2,4
	or	$3,$3,$2
	andi	$2,$20,0x03ff
	sra	$2,$2,6
	or	$3,$3,$2
	andi	$2,$17,0x0200
	sll	$2,$2,2
	or	$3,$3,$2
	sh	$3,22($16)
	addu	$3,$19,$fp
	sb	$19,12($16)
	sb	$18,13($16)
	sb	$3,20($16)
	sb	$18,21($16)
	sb	$19,28($16)
	lw	$10,16($sp)
	#nop
	addu	$2,$18,$10
	sb	$2,29($16)
	sb	$3,36($16)
	sb	$2,37($16)
	sh	$21,8($16)
	sh	$23,10($16)
	lw	$3,80($sp)
	sh	$23,18($16)
	sh	$21,24($16)
	addu	$3,$21,$3
	sh	$3,16($16)
	lw	$2,84($sp)
	sh	$3,32($16)
	addu	$2,$23,$2
	sh	$2,26($16)
	sh	$2,34($16)
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	DrawIcon__14tScreenMemcardP8shapetbliiiis
	.align	2
	.globl	LoadIcon__14tScreenMemcardi
	.ent	LoadIcon__14tScreenMemcardi
LoadIcon__14tScreenMemcardi:
	.frame	$sp,80,$31		# vars= 16, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$22,64($sp)
	move	$22,$4
	sw	$21,60($sp)
	move	$21,$5
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Buffered__Fv
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_Threshold__Fv
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$16,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L603
	lui	$3,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,%lo(CURRENTLYUSINGMEMCARD)($3)
	addu	$2,$22,$21
	sb	$0,607($2)
	sb	$0,622($2)
	lw	$2,108($22)
	#nop
	lw	$2,8($2)
	#nop
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	sll	$16,$21,1
	.set	macro
	.set	reorder

	addu	$16,$16,$21
	sll	$16,$16,2
	subu	$16,$16,$21
	sll	$16,$16,2
	addu	$4,$16,640
	addu	$4,$22,$4
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,44			# 0x0000002c
	.set	macro
	.set	reorder

	li	$17,22			# 0x00000016
	addu	$16,$22,$16
	sll	$2,$21,5
	addu	$2,$2,112
	lw	$3,108($22)
	addu	$2,$22,$2
	sw	$2,644($16)
	sll	$2,$21,2
	addu	$2,$2,$21
	sll	$2,$2,3
	addu	$2,$2,16
	addu	$3,$3,$2
	lui	$2,%hi(fMemIcon) # high
	sw	$3,640($16)
	sll	$3,$21,3
	addu	$3,$3,$21
	lw	$2,%lo(fMemIcon)($2)
	sll	$3,$3,6
	addu	$2,$2,$3
	addu	$3,$2,192
	sw	$2,664($16)
	addu	$2,$2,384
	sw	$3,668($16)
	sw	$2,672($16)
$L606:
	lw	$4,104($22)
	jal	MCRD_handlecardevents
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L606
	sll	$16,$21,1
	.set	macro
	.set	reorder

	addu	$5,$16,$21
	sll	$5,$5,2
	subu	$5,$5,$21
	sll	$5,$5,2
	addu	$5,$5,640
	addu	$5,$22,$5
	li	$6,1			# 0x00000001
	lw	$4,104($22)
	.set	noreorder
	.set	nomacro
	jal	MCRD_loadfile
	move	$23,$0
	.set	macro
	.set	reorder

	addu	$19,$22,$21
	sw	$16,32($sp)
	addu	$fp,$22,$16
	sll	$8,$21,3
	sw	$8,36($sp)
$L610:
	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L639
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	lw	$4,104($22)
	jal	MCRD_getcard
	lw	$3,0($2)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L614
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$8,1428($22)
$L614:
	lw	$4,104($22)
	jal	MCRD_handlecardevents
	addu	$3,$2,-2
	sltu	$2,$3,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L610
	sll	$2,$3,2
	.set	macro
	.set	reorder

	lui	$8,%hi($L636) # high
	addiu	$8,$8,%lo($L636) # low
	addu	$2,$2,$8
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L636:
	.word	$L635
	.word	$L635
	.word	$L610
	.word	$L610
	.word	$L610
	.word	$L635
	.word	$L610
	.word	$L610
	.word	$L635
	.word	$L635
	.word	$L610
	.word	$L610
	.word	$L610
	.word	$L616
	.word	$L635
	.word	$L610
	.word	$L610
	.word	$L635
	.word	$L610
	.word	$L610
	.word	$L610
	.word	$L635
	.text
$L616:
	lw	$2,1428($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	li	$23,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ReleaseIcons__14tScreenMemcard
	move	$4,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L639
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

$L617:
	lw	$8,32($sp)
	#nop
	addu	$2,$8,$21
	sll	$2,$2,2
	subu	$2,$2,$21
	sll	$2,$2,2
	addu	$2,$22,$2
	lw	$2,676($2)
	#nop
	lbu	$2,0($2)
	#nop
	addu	$2,$2,-16
	sb	$2,607($19)
	lw	$4,104($22)
	.set	noreorder
	.set	nomacro
	jal	garyMemCardGrabBlocks
	move	$5,$21
	.set	macro
	.set	reorder

	lbu	$3,607($19)
	#nop
	sltu	$3,$3,4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L619
	sb	$2,622($19)
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	sb	$2,607($19)
$L619:
	lbu	$2,607($19)
	#nop
	bne	$2,$0,$L620
	sb	$23,607($19)
$L620:
	lhu	$4,1300($fp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L621
	sll	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

$L621:
	move	$4,$0
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	Texture_GetClutId__FiPiT1
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	lhu	$2,28($sp)
	lw	$3,24($sp)
	sll	$2,$2,6
	sra	$3,$3,4
	andi	$3,$3,0x003f
	or	$2,$2,$3
	sh	$2,1300($fp)
	lbu	$2,607($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L622
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$8,36($sp)
	li	$18,900			# 0x00000384
	move	$16,$17
	addu	$2,$8,$21
	sll	$20,$2,6
$L623:
 #APP
 #NO_APP
	lui	$2,%hi(fMemIcon) # high
	lw	$2,%lo(fMemIcon)($2)
	#nop
	addu	$2,$20,$2
	addu	$4,$16,$2
	lbu	$2,0($4)
	li	$3,64			# 0x00000040
	andi	$2,$2,0x00f7
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L626
	move	$5,$18
	.set	macro
	.set	reorder

	sll	$6,$21,4
	lw	$7,24($sp)
	lw	$2,28($sp)
	addu	$6,$6,$21
	.set	noreorder
	.set	nomacro
	jal	vramfxya
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L626:
	addu	$18,$18,17
	lbu	$2,607($19)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	addu	$16,$16,192
	.set	macro
	.set	reorder

$L622:
	li	$2,128			# 0x00000080
	sh	$2,1330($fp)
	li	$8,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L610
	sb	$8,592($19)
	.set	macro
	.set	reorder

$L635:
	li	$23,1			# 0x00000001
	move	$8,$23
 #APP
 #NO_APP
	sw	$8,1428($22)
	.set	noreorder
	.set	nomacro
	j	$L610
	sb	$0,592($19)
	.set	macro
	.set	reorder

$L618:
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
$L639:
	sw	$0,%lo(CURRENTLYUSINGMEMCARD)($2)
$L603:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
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
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	LoadIcon__14tScreenMemcardi
	.align	2
	.globl	DrawVerticalLine__14tScreenMemcardssss
	.ent	DrawVerticalLine__14tScreenMemcardssss
DrawVerticalLine__14tScreenMemcardssss:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$8,$5
	sll	$2,$7,16
	lhu	$5,56($sp)
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L641
	sw	$31,32($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	slt	$2,$3,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

$L641:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L647
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L647
	move	$7,$0
	.set	macro
	.set	reorder

$L643:
	li	$7,64			# 0x00000040
$L647:
	ori	$4,$4,0x5a5a
	sll	$2,$5,16
	sltu	$2,$2,1
	sw	$2,20($sp)
	sll	$2,$7,16
	sra	$2,$2,15
	sw	$2,24($sp)
	lui	$2,%hi(GRIDMEMCARDGOURAUDBIT_Y) # high
	lui	$3,%hi(GRIDMEMCARD_HEIGHT) # high
	lhu	$5,%lo(GRIDMEMCARDGOURAUDBIT_Y)($2)
	lui	$2,%hi(EXTRAYATTOP) # high
	sll	$6,$6,16
	sra	$6,$6,16
	lhu	$3,%lo(GRIDMEMCARD_HEIGHT)($3)
	lhu	$2,%lo(EXTRAYATTOP)($2)
	li	$7,2			# 0x00000002
	sw	$0,28($sp)
	sll	$5,$5,1
	addu	$3,$3,$5
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$5,$8,16
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	DrawVerticalLine__14tScreenMemcardssss
	.align	2
	.globl	DrawHorizontalLine__14tScreenMemcardssss
	.ent	DrawHorizontalLine__14tScreenMemcardssss
DrawHorizontalLine__14tScreenMemcardssss:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sll	$2,$7,16
	lhu	$4,56($sp)
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L649
	sw	$31,32($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	slt	$2,$3,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L649:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L658
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	move	$7,$0
	.set	macro
	.set	reorder

$L651:
	li	$7,64			# 0x00000040
$L658:
	move	$8,$7
	sw	$2,16($sp)
	lui	$2,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	lui	$3,%hi(GRIDMEMCARD_WIDTH) # high
	lhu	$2,%lo(GRIDMEMCARDGOURAUDBIT_X)($2)
	lhu	$3,%lo(GRIDMEMCARD_WIDTH)($3)
	sll	$2,$2,1
	addu	$2,$2,2
	addu	$3,$3,$2
	sll	$2,$5,16
	sra	$5,$2,16
	sll	$2,$6,16
	sra	$6,$2,16
	sll	$3,$3,16
	sll	$2,$4,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	sra	$7,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L657
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L654:
	li	$2,2			# 0x00000002
$L657:
	sw	$2,20($sp)
	li	$4,7864320			# 0x00780000
	ori	$4,$4,0x5a5a
	sll	$2,$8,16
	lui	$3,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	lw	$3,%lo(GRIDMEMCARDGOURAUDBIT_X)($3)
	sra	$2,$2,15
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	DrawHorizontalLine__14tScreenMemcardssss
	.align	2
	.globl	PlaceIcons__14tScreenMemcardii
	.ent	PlaceIcons__14tScreenMemcardii
PlaceIcons__14tScreenMemcardii:
	.frame	$sp,96,$31		# vars= 24, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$18,64($sp)
	move	$18,$4
	sw	$19,68($sp)
	move	$19,$5
	sw	$20,72($sp)
	move	$20,$0
	sw	$22,80($sp)
	lui	$22,%hi(MEMCARDICONOFFX) # high
	sw	$21,76($sp)
	lui	$21,%hi(MEMCARD_DELTAX) # high
	sw	$fp,88($sp)
	lui	$fp,%hi(MEMCARD_DELTAY) # high
	sll	$2,$19,1
	sw	$23,84($sp)
	addu	$23,$18,$2
	sw	$31,92($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	sw	$6,104($sp)
$L660:
	addu	$2,$18,$19
	lbu	$2,622($2)
	#nop
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	li	$3,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	lhu	$2,1420($18)
	ori	$3,$3,0x5556
	sll	$2,$2,16
	sra	$4,$2,16
	mult	$4,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$2
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L664
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	subu	$2,$4,$2
	sll	$2,$2,16
	lw	$3,%lo(MEMCARD_DELTAX)($21)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$L672
	mult	$3,$2
	.set	macro
	.set	reorder

$L664:
	addu	$2,$2,$3
	subu	$2,$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	li	$3,2			# 0x00000002
	lw	$4,%lo(MEMCARD_DELTAX)($21)
	subu	$3,$3,$2
	mult	$4,$3
$L672:
	lui	$8,%hi(GRIDMEMCARD_STARTX) # high
	lhu	$2,%lo(MEMCARDICONOFFX)($22)
	lhu	$3,%lo(GRIDMEMCARD_STARTX)($8)
	#nop
	addu	$2,$2,$3
	mflo	$8
	#nop
	#nop
	addu	$17,$2,$8
	li	$4,1431633920			# 0x55550000
	lhu	$2,1420($18)
	ori	$4,$4,0x5556
	sll	$2,$2,16
	sra	$3,$2,16
	mult	$3,$4
	sra	$2,$2,31
	lw	$4,%lo(MEMCARD_DELTAY)($fp)
	mfhi	$3
	#nop
	#nop
	subu	$2,$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	li	$3,4			# 0x00000004
	subu	$3,$3,$2
	mult	$3,$4
	lui	$8,%hi(MEMCARDICONOFFY) # high
	lui	$2,%hi(GRIDMEMCARD_STARTY) # high
	lhu	$2,%lo(GRIDMEMCARD_STARTY)($2)
	lhu	$3,%lo(MEMCARDICONOFFY)($8)
	lw	$4,100($18)
	addu	$2,$2,$3
	mflo	$9
	#nop
	#nop
	addu	$7,$2,$9
	lui	$2,%hi(ticks) # high
	move	$16,$7
 #APP
 #NO_APP
	lw	$3,%lo(ticks)($2)
	addu	$2,$18,$19
	lbu	$2,607($2)
	sra	$3,$3,4
 #APP
 #NO_APP
	rem	$5,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$19,$4,$L666
	li	$2,31			# 0x0000001f
	.set	macro
	.set	reorder

	li	$2,11862016			# 0x00b50000
	ori	$2,$2,0x5623
	sw	$2,36($sp)
	lh	$2,1330($23)
	lw	$8,104($sp)
	lh	$4,1416($18)
	addu	$3,$8,$2
	sll	$2,$17,16
	sra	$2,$2,16
	addu	$6,$2,-242
	sll	$2,$7,16
	sra	$2,$2,16
	addu	$7,$2,-112
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	li	$5,1040			# 0x00000410
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L673:
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	addu	$2,$sp,32
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L668
$L666:
	sw	$2,16($sp)
	li	$2,16			# 0x00000010
	lui	$3,%hi(fMemIcon) # high
	sw	$2,20($sp)
	lh	$2,1330($23)
	lw	$8,104($sp)
	lw	$3,%lo(fMemIcon)($3)
	addu	$4,$8,$2
	sll	$2,$19,3
	addu	$2,$2,$19
	sll	$2,$2,6
	addu	$3,$3,$2
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,6
	addu	$5,$3,$2
	sll	$2,$17,16
	sra	$6,$2,16
	sll	$2,$7,16
	sra	$7,$2,16
	slt	$2,$4,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sll	$2,$4,16
	.set	macro
	.set	reorder

	li	$4,128			# 0x00000080
	sll	$2,$4,16
$L674:
	sra	$2,$2,16
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawIcon__14tScreenMemcardP8shapetbliiiis
	move	$4,$18
	.set	macro
	.set	reorder

$L668:
	lw	$2,100($18)
	#nop
	bne	$2,$19,$L670
	lw	$8,104($sp)
	#nop
	bne	$8,$0,$L670
	lw	$2,1440($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$4,$0
	.set	macro
	.set	reorder

	sll	$17,$17,16
	sra	$17,$17,16
	sll	$16,$16,16
	lui	$8,%hi(MEMCARDICONOFFY) # high
	sra	$16,$16,16
	lw	$5,%lo(MEMCARDICONOFFX)($22)
	lw	$6,%lo(MEMCARDICONOFFY)($8)
	lw	$7,%lo(MEMCARD_DELTAX)($21)
	lw	$2,%lo(MEMCARD_DELTAY)($fp)
	subu	$5,$17,$5
	addu	$5,$5,2
	subu	$6,$16,$6
	addu	$6,$6,1
	addu	$7,$7,-2
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$4,48830			# 0x0000bebe
	lui	$8,%hi(MEMCARDICONOFFY) # high
	lw	$5,%lo(MEMCARDICONOFFX)($22)
	lw	$6,%lo(MEMCARDICONOFFY)($8)
	lw	$7,%lo(MEMCARD_DELTAX)($21)
	lw	$2,%lo(MEMCARD_DELTAY)($fp)
	subu	$5,$17,$5
	subu	$6,$16,$6
	addu	$7,$7,2
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L670:
	lhu	$2,1420($18)
	addu	$20,$20,1
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L660
	sh	$2,1420($18)
	.set	macro
	.set	reorder

$L659:
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
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
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	PlaceIcons__14tScreenMemcardii
	.rdata
	.align	2
$LC1:
	.ascii	"NFS4\000"
	.text
	.align	2
	.globl	DrawMemCardStuff__14tScreenMemcards
	.ent	DrawMemCardStuff__14tScreenMemcards
DrawMemCardStuff__14tScreenMemcards:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$4,104($17)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	move	$21,$5
	.set	macro
	.set	reorder

	lw	$3,100($17)
	sw	$2,108($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L676
	sh	$0,1420($17)
	.set	macro
	.set	reorder

	lhu	$2,1418($17)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L677
	sh	$2,1418($17)
	.set	macro
	.set	reorder

$L676:
	sh	$0,1416($17)
	sh	$0,1418($17)
$L677:
	lh	$3,1418($17)
	li	$2,4			# 0x00000004
	bne	$3,$2,$L678
	lhu	$2,1416($17)
	sh	$0,1418($17)
	addu	$2,$2,1
	sh	$2,1416($17)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,30
	bne	$2,$0,$L678
	sh	$0,1416($17)
$L678:
	lw	$2,108($17)
	#nop
	lw	$3,0($2)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L680
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$3,1424($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L681
	sw	$2,1428($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,1424($17)
$L681:
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,1424($17)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,801
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	li	$4,635			# 0x0000027b
	.set	macro
	.set	reorder

	li	$4,639			# 0x0000027f
$L682:
	lw	$2,108($17)
	sw	$4,1408($17)
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L693
	move	$19,$0
	.set	macro
	.set	reorder

	sll	$2,$19,16
$L742:
	sra	$5,$2,16
	addu	$3,$17,$5
	lbu	$2,592($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	sll	$2,$5,1
	.set	macro
	.set	reorder

	addu	$16,$17,$2
	lhu	$2,1330($16)
	#nop
	addu	$2,$2,8
	sh	$2,1330($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	move	$4,$17
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	sh	$2,1330($16)
	sb	$0,592($3)
	sb	$0,607($3)
	sb	$0,622($3)
	lhu	$4,1300($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L688
	sll	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L688
	sh	$0,1300($16)
	.set	macro
	.set	reorder

$L689:
	sll	$6,$21,16
	.set	noreorder
	.set	nomacro
	jal	PlaceIcons__14tScreenMemcardii
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L688:
	addu	$2,$19,1
	move	$19,$2
	lw	$3,108($17)
	sll	$2,$2,16
	lw	$3,8($3)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L742
	sll	$2,$19,16
	.set	macro
	.set	reorder

	j	$L693
$L680:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L694
	li	$2,648			# 0x00000288
	.set	macro
	.set	reorder

	sw	$0,1424($17)
	.set	noreorder
	.set	nomacro
	j	$L693
	sw	$2,1408($17)
	.set	macro
	.set	reorder

$L694:
	lw	$2,108($17)
	sw	$0,1424($17)
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	li	$2,637			# 0x0000027d
	.set	macro
	.set	reorder

	li	$2,644			# 0x00000284
$L740:
	sw	$2,1408($17)
	lw	$2,1440($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$0,1360($17)
	.set	macro
	.set	reorder

$L700:
	.set	noreorder
	.set	nomacro
	jal	ReleaseIcons__14tScreenMemcard
	move	$4,$17
	.set	macro
	.set	reorder

	sw	$0,1428($17)
	.set	noreorder
	.set	nomacro
	j	$L701
	sw	$0,1440($17)
	.set	macro
	.set	reorder

$L699:
	lw	$3,108($17)
	sw	$2,1360($17)
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L701
	move	$19,$0
	.set	macro
	.set	reorder

	move	$4,$3
	sll	$2,$19,16
$L744:
	sra	$2,$2,15
	addu	$2,$17,$2
	lh	$2,1330($2)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L743
	addu	$2,$19,1
	.set	macro
	.set	reorder

	sw	$0,1360($17)
$L743:
	move	$19,$2
	sll	$2,$2,16
	lw	$3,8($4)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	sll	$2,$19,16
	.set	macro
	.set	reorder

$L698:
	lw	$2,108($17)
	#nop
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L701
	move	$19,$0
	.set	macro
	.set	reorder

	li	$20,-1			# 0xffffffff
$L711:
	lw	$2,1428($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	sll	$2,$19,16
	.set	macro
	.set	reorder

	sra	$5,$2,16
	addu	$2,$17,$5
	lbu	$2,592($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L715
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	#nop
	bne	$2,$0,$L715
	lw	$2,1440($17)
	#nop
	bne	$2,$0,$L718
	.set	noreorder
	.set	nomacro
	jal	LoadIcon__14tScreenMemcardi
	move	$4,$17
	.set	macro
	.set	reorder

$L715:
	lw	$2,1440($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L745
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

$L718:
	lw	$2,1360($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	sll	$2,$19,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	addu	$2,$17,$2
	sb	$0,592($2)
$L719:
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
$L745:
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L741
	sll	$2,$19,16
	.set	macro
	.set	reorder

	sra	$3,$2,16
	addu	$2,$17,$3
	lbu	$2,592($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	lh	$2,1330($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L741
	sll	$2,$19,16
	.set	macro
	.set	reorder

	lui	$5,%hi($LC1) # high
	lw	$4,104($17)
	.set	noreorder
	.set	nomacro
	jal	MCRD_fileexists
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

	lw	$3,1408($17)
	sw	$2,100($17)
	li	$2,639			# 0x0000027f
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L724
	li	$2,635			# 0x0000027b
	.set	macro
	.set	reorder

	beq	$3,$2,$L724
	sw	$0,1424($17)
$L724:
	lw	$2,100($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L725
	addu	$2,$17,$2
	.set	macro
	.set	reorder

	lbu	$2,592($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L725
	addu	$4,$17,1368
	.set	macro
	.set	reorder

	lw	$5,100($17)
	sw	$20,1408($17)
	sll	$5,$5,5
	addu	$5,$5,112
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$5,$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L741
	sll	$2,$19,16
	.set	macro
	.set	reorder

$L725:
	li	$2,644			# 0x00000284
	sw	$2,1408($17)
	sll	$2,$19,16
$L741:
	sra	$3,$2,16
	addu	$18,$17,$3
	lbu	$2,592($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L746
	addu	$2,$19,1
	.set	macro
	.set	reorder

	lw	$2,1440($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L747
	sll	$2,$19,16
	.set	macro
	.set	reorder

	lw	$2,1360($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L730
	sll	$2,$19,16
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$16,$17,$2
	lhu	$2,1330($16)
	#nop
	addu	$2,$2,8
	sh	$2,1330($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L748
	move	$4,$17
	.set	macro
	.set	reorder

	lhu	$4,1300($16)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L732
	sh	$2,1330($16)
	.set	macro
	.set	reorder

	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

	sh	$0,1300($16)
$L732:
	sb	$0,592($18)
	sb	$0,607($18)
	.set	noreorder
	.set	nomacro
	j	$L733
	sb	$0,622($18)
	.set	macro
	.set	reorder

$L730:
$L747:
	sra	$2,$2,15
	addu	$3,$17,$2
	lhu	$2,1330($3)
	#nop
	addu	$2,$2,-8
	sh	$2,1330($3)
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L748
	move	$4,$17
	.set	macro
	.set	reorder

	sh	$0,1330($3)
$L733:
	move	$4,$17
$L748:
	sll	$5,$19,16
	sra	$5,$5,16
	sll	$6,$21,16
	.set	noreorder
	.set	nomacro
	jal	PlaceIcons__14tScreenMemcardii
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L728:
	addu	$2,$19,1
$L746:
	move	$19,$2
	lw	$3,108($17)
	sll	$2,$2,16
	lw	$3,8($3)
	sra	$2,$2,16
	slt	$2,$2,$3
	bne	$2,$0,$L711
$L701:
	lw	$2,1440($17)
	#nop
	beq	$2,$0,$L693
	lw	$2,1360($17)
	#nop
	beq	$2,$0,$L693
	sw	$0,1440($17)
$L693:
	lw	$2,108($17)
	#nop
	lw	$3,0($2)
	li	$2,-3			# 0xfffffffd
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L749
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	lw	$3,100($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L749
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	macro
	.set	reorder

	li	$2,703			# 0x000002bf
	sw	$2,1408($17)
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
$L749:
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	#nop
	bne	$2,$0,$L675
	lw	$4,104($17)
	jal	MCRD_handlecardevents
$L675:
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

	.end	DrawMemCardStuff__14tScreenMemcards
	.align	2
	.globl	SetEnablings__14tScreenMemcard
	.ent	SetEnablings__14tScreenMemcard
SetEnablings__14tScreenMemcard:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,104($16)
	jal	MCRD_getcard
	move	$3,$0
	sw	$2,108($16)
	lw	$2,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L752
	move	$5,$3
	.set	macro
	.set	reorder

	li	$8,-1			# 0xffffffff
	li	$7,-2			# 0xfffffffe
	move	$6,$2
	move	$4,$16
$L754:
	addu	$2,$16,$3
	lbu	$2,592($2)
	#nop
	beq	$2,$0,$L756
	lh	$2,1330($4)
	#nop
	blez	$2,$L753
$L756:
	lw	$2,108($16)
	#nop
	lw	$2,0($2)
	#nop
	beq	$2,$8,$L753
	beq	$2,$7,$L753
	li	$5,1			# 0x00000001
$L753:
	addu	$3,$3,1
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L754
	addu	$4,$4,2
	.set	macro
	.set	reorder

$L752:
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	#nop
	beq	$2,$0,$L760
	li	$5,1			# 0x00000001
$L760:
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L761
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,100($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L762
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,12416($4)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L763
	sw	$2,12416($4)
	.set	macro
	.set	reorder

$L762:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,12416($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,12416($3)
$L763:
	lw	$2,108($16)
	#nop
	lw	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L765
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L765
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L769
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,100($16)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L769
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

$L765:
	lh	$2,1436($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L764
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($2)
	#nop
	lw	$2,12372($4)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L761
	sw	$2,12372($4)
	.set	macro
	.set	reorder

$L764:
$L769:
	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,12372($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,12372($3)
$L761:
	jal	FECheat_IsTheUserACryBabyCheater__Fv
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	#nop
	lw	$2,12372($3)
	#nop
	ori	$2,$2,0x0001
	sw	$2,12372($3)
$L750:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetEnablings__14tScreenMemcard
	.align	2
	.globl	DrawBackground__14tScreenMemcard
	.ent	DrawBackground__14tScreenMemcard
DrawBackground__14tScreenMemcard:
	.frame	$sp,96,$31		# vars= 24, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$23,84($sp)
	move	$23,$4
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	lw	$2,100($23)
	li	$3,-1			# 0xffffffff
	sw	$3,1408($23)
	addu	$2,$23,$2
	lbu	$2,592($2)
	#nop
	bne	$2,$0,$L771
	sw	$3,100($23)
$L771:
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	lhu	$2,92($23)
	#nop
	sll	$2,$2,1
	move	$5,$2
 #APP
 #NO_APP
	addu	$4,$2,-128
	sll	$2,$4,16
	sra	$3,$2,16
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L815
	slt	$2,$3,129
	.set	macro
	.set	reorder

	blez	$3,$L774
$L815:
	bne	$2,$0,$L776
	.set	noreorder
	.set	nomacro
	j	$L776
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

$L774:
	move	$4,$0
$L776:
	sh	$4,40($sp)
	sll	$2,$5,16
	sra	$4,$2,17
	move	$3,$4
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	slt	$2,$3,129
	.set	macro
	.set	reorder

	blez	$3,$L779
$L816:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L781
	sh	$4,48($sp)
	.set	macro
	.set	reorder

	li	$10,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	j	$L781
	sh	$10,48($sp)
	.set	macro
	.set	reorder

$L779:
	sh	$0,48($sp)
$L781:
	sll	$2,$5,16
	sra	$5,$2,15
	slt	$2,$5,129
	bne	$2,$0,$L782
	li	$5,128			# 0x00000080
$L782:
	bgez	$5,$L783
	move	$5,$0
$L783:
	lw	$2,1364($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	move	$16,$5
	.set	macro
	.set	reorder

	lh	$3,92($23)
	li	$2,636			# 0x0000027c
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L785
	sw	$2,1408($23)
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,1432($23)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L785
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	move	$5,$0
	.set	macro
	.set	reorder

	move	$3,$0
	li	$5,128			# 0x00000080
	move	$4,$23
$L789:
	addu	$2,$23,$3
	sb	$0,592($2)
	sb	$0,607($2)
	sb	$0,622($2)
	sh	$5,1330($4)
	addu	$3,$3,1
	slt	$2,$3,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L789
	addu	$4,$4,2
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L784
	sw	$2,1364($23)
	.set	macro
	.set	reorder

$L785:
	lw	$2,1432($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L784
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,1432($23)
$L784:
	lw	$2,1364($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L817
	lui	$3,%hi(kRGBVals) # high
	.set	macro
	.set	reorder

$L814:
	lhu	$10,40($sp)
	li	$3,128			# 0x00000080
	sll	$2,$10,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L793
	move	$4,$23
	.set	macro
	.set	reorder

	sll	$5,$16,16
	.set	noreorder
	.set	nomacro
	jal	DrawMemCardStuff__14tScreenMemcards
	sra	$5,$5,16
	.set	macro
	.set	reorder

$L793:
	lui	$3,%hi(kRGBVals) # high
$L817:
	lui	$2,%hi(textDefinitions+41) # high
	addiu	$3,$3,%lo(kRGBVals) # low
	lbu	$2,%lo(textDefinitions+41)($2)
	sll	$5,$16,16
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sra	$5,$5,16
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$2,1412($23)
	li	$3,-1			# 0xffffffff
	beq	$2,$3,$L794
	sw	$2,1408($23)
$L794:
	lw	$4,1408($23)
	#nop
	beq	$4,$3,$L795
	jal	TextSys_Word__Fi
	addu	$4,$23,1368
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

$L795:
	addu	$4,$23,1368
	addu	$5,$sp,32
	move	$6,$16
	li	$7,2			# 0x00000002
	li	$22,5242880			# 0x00500000
	ori	$22,$22,0x5050
	lui	$2,%hi(kMemCardMessageX) # high
	lui	$3,%hi(kMemCardMessageY) # high
	lhu	$8,%lo(kMemCardMessageX)($2)
	lhu	$3,%lo(kMemCardMessageY)($3)
	li	$2,190			# 0x000000be
	sh	$2,36($sp)
	sh	$0,38($sp)
	sh	$8,32($sp)
	sh	$3,34($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lh	$4,1436($23)
	lui	$2,%hi(GRIDMEMCARD_STARTY) # high
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,659
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	lui	$2,%hi(kMemCardMessage1X) # high
	lui	$10,%hi(kMemCardMessage1Y) # high
	lh	$5,%lo(kMemCardMessage1X)($2)
	lh	$6,%lo(kMemCardMessage1Y)($10)
	move	$7,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lui	$21,%hi(GRIDMEMCARD_STARTX) # high
	lui	$2,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	lui	$3,%hi(GRIDMEMCARDGOURAUDBIT_Y) # high
	lhu	$6,%lo(GRIDMEMCARDGOURAUDBIT_X)($2)
	lui	$2,%hi(EXTRAYATTOP) # high
	lui	$10,%hi(GRIDMEMCARD_STARTY) # high
	lui	$20,%hi(GRIDMEMCARD_WIDTH) # high
	lhu	$19,%lo(GRIDMEMCARD_STARTX)($21)
	lhu	$18,%lo(GRIDMEMCARD_STARTY)($10)
	lhu	$3,%lo(GRIDMEMCARDGOURAUDBIT_Y)($3)
	lhu	$7,%lo(EXTRAYATTOP)($2)
	lhu	$17,%lo(GRIDMEMCARD_WIDTH)($20)
	move	$fp,$0
	sw	$22,16($sp)
	sw	$22,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	subu	$19,$19,$6
	sll	$19,$19,16
	sra	$19,$19,16
	move	$4,$19
	subu	$18,$18,$3
	addu	$2,$7,4
	subu	$18,$18,$2
	sll	$18,$18,16
	sra	$18,$18,16
	move	$5,$18
	sll	$6,$6,1
	addu	$17,$17,$6
	addu	$17,$17,2
	sll	$17,$17,16
	sra	$17,$17,16
	move	$6,$17
	lui	$2,%hi(GRIDMEMCARD_HEIGHT) # high
	sll	$3,$3,1
	lhu	$2,%lo(GRIDMEMCARD_HEIGHT)($2)
	addu	$7,$7,6
	addu	$2,$2,$3
	addu	$2,$2,$7
	sll	$2,$2,16
	sra	$16,$2,16
	srl	$2,$2,31
	addu	$16,$16,$2
	sra	$16,$16,1
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$5,$18,$16
	move	$6,$17
	move	$7,$16
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$22,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$22,28($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$10,%hi(kMemCardMessage1Y) # high
	lui	$2,%hi(kMemCardMessageH1) # high
	lw	$5,%lo(GRIDMEMCARD_STARTX)($21)
	lw	$6,%lo(kMemCardMessage1Y)($10)
	lw	$7,%lo(GRIDMEMCARD_WIDTH)($20)
	lw	$2,%lo(kMemCardMessageH1)($2)
	addu	$5,$5,2
	addu	$6,$6,-2
	addu	$7,$7,-4
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$2,%hi(MEMCARD_DELTAY) # high
	lui	$10,%hi(GRIDMEMCARD_STARTY) # high
	lw	$5,%lo(GRIDMEMCARD_STARTX)($21)
	lw	$3,%lo(MEMCARD_DELTAY)($2)
	lw	$6,%lo(GRIDMEMCARD_STARTY)($10)
	lw	$7,%lo(GRIDMEMCARD_WIDTH)($20)
	addu	$5,$5,2
	sll	$2,$3,2
	addu	$2,$2,$3
	addu	$6,$6,$2
	addu	$6,$6,1
	lui	$2,%hi(kMemCardMessageH) # high
	lw	$2,%lo(kMemCardMessageH)($2)
	addu	$7,$7,-4
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lhu	$16,%lo(GRIDMEMCARD_STARTX)($21)
$L799:
	move	$4,$23
	sll	$5,$16,16
	sra	$5,$5,16
	sll	$2,$fp,16
	sra	$3,$2,16
	srl	$2,$2,31
	addu	$2,$3,$2
	sra	$2,$2,1
	sll	$2,$2,1
	subu	$3,$3,$2
	sll	$3,$3,16
	sra	$3,$3,16
	lhu	$10,48($sp)
	lui	$18,%hi(EXTRAYATTOP) # high
	sw	$3,16($sp)
	lhu	$3,%lo(EXTRAYATTOP)($18)
	sll	$17,$10,16
	lui	$10,%hi(GRIDMEMCARD_STARTY) # high
	lhu	$6,%lo(GRIDMEMCARD_STARTY)($10)
	lui	$10,%hi(GRIDMEMCARDGOURAUDBIT_Y) # high
	lhu	$2,%lo(GRIDMEMCARDGOURAUDBIT_Y)($10)
	sra	$7,$17,16
	subu	$6,$6,$2
	subu	$6,$6,$3
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	DrawVerticalLine__14tScreenMemcardssss
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lui	$3,%hi(MEMCARD_DELTAX) # high
	addu	$2,$fp,1
	move	$fp,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lhu	$3,%lo(MEMCARD_DELTAX)($3)
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L799
	addu	$16,$16,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(GRIDMEMCARD_STARTY) # high
	lw	$3,%lo(EXTRAYATTOP)($18)
	lhu	$16,%lo(GRIDMEMCARD_STARTY)($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L801
	move	$4,$23
	.set	macro
	.set	reorder

	sra	$7,$17,16
	lui	$2,%hi(GRIDMEMCARD_STARTX) # high
	lui	$3,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	lhu	$5,%lo(GRIDMEMCARD_STARTX)($2)
	lhu	$3,%lo(GRIDMEMCARDGOURAUDBIT_X)($3)
	lhu	$6,%lo(EXTRAYATTOP)($18)
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	subu	$5,$5,$3
	sll	$5,$5,16
	sra	$5,$5,16
	subu	$6,$16,$6
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	DrawHorizontalLine__14tScreenMemcardssss
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L801:
	move	$fp,$0
	lui	$19,%hi(GRIDMEMCARD_STARTX) # high
	lui	$18,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
$L805:
	move	$4,$23
	sll	$6,$16,16
	sra	$6,$6,16
	sll	$2,$fp,16
	sra	$3,$2,16
	srl	$2,$2,31
	addu	$2,$3,$2
	sra	$2,$2,1
	sll	$2,$2,1
	subu	$3,$3,$2
	sll	$3,$3,16
	lhu	$10,48($sp)
	lhu	$5,%lo(GRIDMEMCARD_STARTX)($19)
	lhu	$2,%lo(GRIDMEMCARDGOURAUDBIT_X)($18)
	sra	$3,$3,16
	sw	$3,16($sp)
	sll	$17,$10,16
	sra	$7,$17,16
	subu	$5,$5,$2
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	DrawHorizontalLine__14tScreenMemcardssss
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lui	$2,%hi(MEMCARD_DELTAY) # high
	addu	$3,$fp,1
	move	$fp,$3
	sll	$3,$3,16
	sra	$5,$3,16
	lhu	$9,%lo(MEMCARD_DELTAY)($2)
	slt	$2,$5,6
	addu	$8,$16,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L805
	move	$16,$8
	.set	macro
	.set	reorder

	move	$4,$23
	sra	$7,$17,16
	srl	$2,$3,31
	addu	$2,$5,$2
	sra	$2,$2,1
	sll	$2,$2,1
	subu	$2,$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$2,16($sp)
	lui	$2,%hi(GRIDMEMCARD_STARTX) # high
	lui	$3,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	lhu	$5,%lo(GRIDMEMCARD_STARTX)($2)
	lhu	$2,%lo(GRIDMEMCARDGOURAUDBIT_X)($3)
	lui	$3,%hi(kMemCardMessageH) # high
	lhu	$6,%lo(kMemCardMessageH)($3)
	subu	$5,$5,$2
	sll	$5,$5,16
	sra	$5,$5,16
	subu	$6,$6,$9
	addu	$6,$8,$6
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	DrawHorizontalLine__14tScreenMemcardssss
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lhu	$10,40($sp)
	move	$16,$0
	sll	$2,$10,16
	sra	$17,$2,16
	addu	$4,$16,30
$L818:
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sw	$17,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L818
	addu	$4,$16,30
	.set	macro
	.set	reorder

	lw	$2,1364($23)
	#nop
	beq	$2,$0,$L770
	.set	noreorder
	.set	nomacro
	jal	SetEnablings__14tScreenMemcard
	move	$4,$23
	.set	macro
	.set	reorder

$L770:
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
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
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	DrawBackground__14tScreenMemcard
	.align	2
	.globl	DrawForeground__14tScreenMemcard
	.ent	DrawForeground__14tScreenMemcard
DrawForeground__14tScreenMemcard:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lhu	$2,92($4)
	#nop
	sll	$2,$2,1
	addu	$4,$2,-128
	sll	$2,$4,16
	sra	$3,$2,16
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L830
	slt	$2,$3,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L822
	move	$16,$0
	.set	macro
	.set	reorder

$L830:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L831
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L831
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

$L822:
	move	$4,$0
$L831:
	sll	$2,$4,16
	sra	$17,$2,16
	addu	$4,$16,56
$L832:
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sw	$17,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L832
	addu	$4,$16,56
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

	.end	DrawForeground__14tScreenMemcard
	.align	2
	.globl	__14tScreenMemcard
	.ent	__14tScreenMemcard
__14tScreenMemcard:
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
	lui	$3,%hi(tScreenMemcard_vtable) # high
	addiu	$3,$3,%lo(tScreenMemcard_vtable) # low
	sw	$3,96($2)
	li	$3,-1			# 0xffffffff
	sw	$3,1412($2)
	li	$3,1			# 0x00000001
	sw	$3,104($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__14tScreenMemcard
	.align	2
	.globl	ReleaseIcons__14tScreenMemcard
	.ent	ReleaseIcons__14tScreenMemcard
ReleaseIcons__14tScreenMemcard:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	sw	$16,16($sp)
	move	$16,$18
	sw	$31,28($sp)
$L836:
	addu	$2,$18,$17
	sb	$0,592($2)
	sb	$0,607($2)
	sb	$0,622($2)
	lhu	$4,1300($16)
	#nop
	beq	$4,$0,$L839
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

	sh	$0,1300($16)
$L839:
	addu	$17,$17,1
	slt	$2,$17,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L836
	addu	$16,$16,2
	.set	macro
	.set	reorder

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

	.end	ReleaseIcons__14tScreenMemcard
	.rdata
	.align	2
$LC2:
	.ascii	"records\000"
	.text
	.align	2
	.globl	Initialize__14tScreenMemcard
	.ent	Initialize__14tScreenMemcard
Initialize__14tScreenMemcard:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	lui	$3,%hi(GRIDMEMCARD_STARTX) # high
	li	$2,246			# 0x000000f6
	sw	$2,%lo(GRIDMEMCARD_STARTX)($3)
	lui	$3,%hi(GRIDMEMCARD_STARTY) # high
	li	$2,60			# 0x0000003c
	sw	$2,%lo(GRIDMEMCARD_STARTY)($3)
	lui	$3,%hi(MEMCARD_DELTAX) # high
	li	$2,59			# 0x0000003b
	sw	$2,%lo(MEMCARD_DELTAX)($3)
	lui	$3,%hi(MEMCARD_DELTAY) # high
	li	$2,27			# 0x0000001b
	sw	$2,%lo(MEMCARD_DELTAY)($3)
	lui	$2,%hi(kMemCardMessageH1) # high
	li	$5,12			# 0x0000000c
	sw	$5,%lo(kMemCardMessageH1)($2)
	lui	$2,%hi(kMemCardMessageH) # high
	sw	$5,%lo(kMemCardMessageH)($2)
	lui	$2,%hi(EXTRAYATTOP) # high
	lui	$3,%hi(GRIDMEMCARD_WIDTH) # high
	sw	$5,%lo(EXTRAYATTOP)($2)
	li	$2,177			# 0x000000b1
	sw	$2,%lo(GRIDMEMCARD_WIDTH)($3)
	lui	$3,%hi(GRIDMEMCARD_HEIGHT) # high
	li	$2,147			# 0x00000093
	sw	$2,%lo(GRIDMEMCARD_HEIGHT)($3)
	lui	$2,%hi(GRIDMEMCARDGOURAUDBIT_X) # high
	sw	$5,%lo(GRIDMEMCARDGOURAUDBIT_X)($2)
	lui	$2,%hi(GRIDMEMCARDGOURAUDBIT_Y) # high
	li	$5,6			# 0x00000006
	lui	$3,%hi(MEMCARDICONOFFX) # high
	sw	$5,%lo(GRIDMEMCARDGOURAUDBIT_Y)($2)
	li	$2,15			# 0x0000000f
	sw	$2,%lo(MEMCARDICONOFFX)($3)
	lui	$2,%hi(MEMCARDICONOFFY) # high
	lui	$3,%hi(kMemCardMessage1Y) # high
	sw	$5,%lo(MEMCARDICONOFFY)($2)
	li	$2,51			# 0x00000033
	sw	$2,%lo(kMemCardMessage1Y)($3)
	lui	$2,%hi(kMemCardMessageX) # high
	li	$3,336			# 0x00000150
	sw	$3,%lo(kMemCardMessageX)($2)
	lui	$2,%hi(kMemCardMessage1X) # high
	sw	$3,%lo(kMemCardMessage1X)($2)
	lui	$3,%hi(kMemCardMessageY) # high
	li	$2,198			# 0x000000c6
	li	$5,8640			# 0x000021c0
	move	$6,$0
	sw	$31,20($sp)
	sw	$0,1432($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,%lo(kMemCardMessageY)($3)
	.set	macro
	.set	reorder

	lui	$3,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($3)
	lui	$3,%hi(fMemIcon) # high
	sw	$2,%lo(fMemIcon)($3)
	sw	$0,1424($16)
	sh	$0,1416($16)
	sh	$0,1418($16)
	lbu	$2,557($4)
	li	$7,647			# 0x00000287
	sh	$2,1436($16)
	sll	$2,$2,2
	lh	$3,1436($16)
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L842
	sw	$2,104($16)
	.set	macro
	.set	reorder

	li	$7,649			# 0x00000289
$L842:
	move	$6,$0
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$8,128			# 0x00000080
	lw	$2,12372($4)
	lw	$3,12416($4)
	move	$5,$16
	sw	$7,12420($4)
	ori	$2,$2,0x0001
	ori	$3,$3,0x0001
	sw	$2,12372($4)
	sw	$3,12416($4)
$L843:
	addu	$2,$16,$6
	sb	$0,592($2)
	sb	$0,607($2)
	sb	$0,622($2)
	sh	$8,1330($5)
	sh	$0,1300($5)
	addu	$6,$6,1
	slt	$2,$6,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L843
	addu	$5,$5,2
	.set	macro
	.set	reorder

	move	$4,$16
	li	$2,-1			# 0xffffffff
	sw	$0,1364($4)
	sw	$0,1440($4)
	sw	$0,1360($4)
	sw	$2,100($4)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$0,1428($4)
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

	.end	Initialize__14tScreenMemcard
	.align	2
	.globl	Cleanup__14tScreenMemcard
	.ent	Cleanup__14tScreenMemcard
Cleanup__14tScreenMemcard:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	ReleaseIcons__14tScreenMemcard
	move	$16,$4
	.set	macro
	.set	reorder

	jal	DeInit_Memcard__Fv
	lui	$2,%hi(fMemIcon) # high
	lw	$4,%lo(fMemIcon)($2)
	lui	$2,%hi(menuDefs) # high
	lw	$5,%lo(menuDefs)($2)
	li	$6,-2			# 0xfffffffe
	lw	$2,12372($5)
	lw	$3,12416($5)
	and	$2,$2,$6
	and	$3,$3,$6
	sw	$2,12372($5)
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$3,12416($5)
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

	.end	Cleanup__14tScreenMemcard
	.align	2
	.globl	___14tScreenMemcard
	.ent	___14tScreenMemcard
___14tScreenMemcard:
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

	.end	___14tScreenMemcard
