	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fetv.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	DrawTVLines__FR9tTVConfig
	.ent	DrawTVLines__FR9tTVConfig
DrawTVLines__FR9tTVConfig:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lh	$3,10($16)
	lh	$4,26($16)
	addu	$3,$3,1
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,4
	rem	$5,$3,$2
	sll	$2,$4,1
	addu	$2,$2,$4
	lh	$3,12($16)
	sll	$2,$2,4
	addu	$3,$3,2
	rem	$2,$3,$2
	lhu	$4,22($16)
	sh	$5,10($16)
	move	$9,$5
	lh	$3,10($16)
	lh	$5,22($16)
	sh	$2,12($16)
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	li	$10,8			# 0x00000008
	.set	macro
	.set	reorder

	subu	$2,$4,$9
	subu	$10,$10,$2
	.set	noreorder
	.set	nomacro
	j	$L602
	move	$9,$4
	.set	macro
	.set	reorder

$L601:
	lh	$2,26($16)
	addu	$3,$3,8
	addu	$2,$5,$2
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	sll	$2,$10,16
	.set	macro
	.set	reorder

	subu	$10,$4,$9
$L602:
	sll	$2,$10,16
$L612:
	.set	noreorder
	.set	nomacro
	blez	$2,$L604
	li	$7,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$8,0($7)
	lw	$5,528482304
	lw	$3,0($8)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($8)
	addu	$3,$8,24
	lw	$2,0($5)
	and	$4,$8,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,42			# 0x0000002a
	sb	$2,7($8)
	li	$2,5			# 0x00000005
	sb	$2,3($8)
	lhu	$2,20($16)
	sh	$9,10($8)
	sh	$2,8($8)
	lhu	$2,20($16)
	lhu	$3,24($16)
	sh	$9,14($8)
	addu	$2,$2,$3
	sh	$2,12($8)
	lhu	$2,20($16)
	addu	$4,$9,$10
	sh	$4,18($8)
	sh	$2,16($8)
	lhu	$3,20($16)
	lhu	$5,24($16)
	li	$2,10			# 0x0000000a
	sh	$4,22($8)
	sb	$2,6($8)
	sb	$2,5($8)
	sb	$2,4($8)
	addu	$3,$3,$5
	sh	$3,20($8)
$L604:
	lh	$4,12($16)
	lh	$3,22($16)
	lhu	$9,12($16)
	slt	$2,$3,$4
	beq	$2,$0,$L605
	lh	$2,26($16)
	#nop
	addu	$2,$3,$2
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	li	$7,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$7,$7,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$6,-16777216			# 0xff000000
	lw	$8,0($7)
	lw	$5,528482304
	lw	$3,0($8)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($8)
	addu	$3,$8,24
	lw	$2,0($5)
	and	$4,$8,$4
	sw	$3,0($7)
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($5)
	li	$2,42			# 0x0000002a
	sb	$2,7($8)
	li	$2,5			# 0x00000005
	sb	$2,3($8)
	lhu	$2,20($16)
	sh	$9,10($8)
	sh	$2,8($8)
	lhu	$2,20($16)
	lhu	$3,24($16)
	sh	$9,14($8)
	addu	$2,$2,$3
	sh	$2,12($8)
	lhu	$2,20($16)
	addu	$4,$9,1
	sh	$4,18($8)
	sh	$2,16($8)
	lhu	$3,20($16)
	lhu	$5,24($16)
	li	$2,10			# 0x0000000a
	sh	$4,22($8)
	sb	$2,6($8)
	sb	$2,5($8)
	sb	$2,4($8)
	addu	$3,$3,$5
	sh	$3,20($8)
$L605:
	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lhu	$2,8($16)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L600
	lhu	$3,20($16)
	li	$4,-4			# 0xfffffffc
	addu	$2,$3,4
	and	$2,$2,$4
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$3,$3,16
	lh	$4,24($16)
	sra	$3,$3,16
	addu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,655360			# 0x000a0000
$L613:
	ori	$4,$4,0x0a0a
	sll	$5,$17,16
	sra	$5,$5,16
	lh	$6,22($16)
	lh	$2,26($16)
	li	$7,1			# 0x00000001
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$17,4
	move	$17,$2
	sll	$2,$2,16
	lh	$3,20($16)
	lh	$4,24($16)
	sra	$2,$2,16
	addu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

$L607:
	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L600:
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

	.end	DrawTVLines__FR9tTVConfig
	.align	2
	.globl	DrawTV__FR9tTVConfig
	.ent	DrawTV__FR9tTVConfig
DrawTV__FR9tTVConfig:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$18,48($sp)
	move	$18,$4
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	jal	rand
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	li	$12,1			# 0x00000001
	lui	$3,%hi(gHelpShapes) # high
	andi	$2,$2,0x0003
	sll	$2,$2,5
	addu	$2,$2,1088
	sw	$12,32($sp)
	lhu	$5,6($18)
	lw	$fp,16($18)
	lw	$4,%lo(gHelpShapes)($3)
	lhu	$3,8($18)
	lhu	$22,20($18)
	lhu	$19,22($18)
	lhu	$12,24($18)
	addu	$17,$4,$2
	sh	$12,16($sp)
	lhu	$12,26($18)
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L615
	sh	$12,24($sp)
	.set	macro
	.set	reorder

	li	$fp,8388608			# 0x00800000
	ori	$fp,$fp,0x8080
	sw	$0,32($sp)
$L615:
	lh	$2,4($18)
	lhu	$3,6($18)
	lhu	$4,4($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L616
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L617
	lw	$2,0($18)
	#nop
	addu	$2,$2,-1
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	addu	$2,$4,4
	.set	macro
	.set	reorder

	sh	$2,4($18)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$L654
	slt	$2,$3,$2
	.set	macro
	.set	reorder

$L617:
	lw	$3,0($18)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L621
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$3,$2,$L656
$L621:
	lhu	$2,4($18)
	lhu	$3,6($18)
	addu	$2,$2,-8
	sh	$2,4($18)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$3
$L654:
	beq	$2,$0,$L616
	sh	$3,4($18)
$L616:
	lw	$3,0($18)
	li	$2,1			# 0x00000001
$L656:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L625
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L625
	srl	$2,$fp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L661
	andi	$2,$2,0x00ff
	.set	macro
	.set	reorder

$L632:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L626
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L628
	srl	$2,$fp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L661
	andi	$2,$2,0x00ff
	.set	macro
	.set	reorder

$L625:
	lhu	$5,6($18)
	.set	noreorder
	.set	nomacro
	j	$L655
	srl	$2,$fp,16
	.set	macro
	.set	reorder

$L626:
	lh	$3,4($18)
	lhu	$2,6($18)
	li	$12,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L629
	sw	$12,32($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L629
	sw	$12,0($18)
	.set	macro
	.set	reorder

$L628:
	lh	$3,4($18)
	lhu	$2,6($18)
	li	$12,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L629
	sw	$12,32($sp)
	.set	macro
	.set	reorder

	sw	$0,0($18)
$L629:
	lhu	$5,4($18)
	srl	$2,$fp,16
$L655:
	andi	$2,$2,0x00ff
$L661:
	sll	$21,$5,16
	sra	$12,$21,16
	mult	$2,$12
	mflo	$3
	#nop
	srl	$2,$fp,8
	andi	$2,$2,0x00ff
	mult	$2,$12
	mflo	$6
	#nop
	andi	$2,$fp,0x00ff
	mult	$2,$12
	sw	$12,36($sp)
	srl	$3,$3,7
	sll	$3,$3,16
	srl	$2,$6,7
	sll	$2,$2,8
	or	$3,$3,$2
	lhu	$2,8($18)
	#nop
	andi	$2,$2,0x0008
	mflo	$4
	#nop
	#nop
	srl	$4,$4,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L633
	or	$fp,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawTVLines__FR9tTVConfig
	move	$4,$18
	.set	macro
	.set	reorder

$L633:
	lhu	$2,8($18)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L635
	li	$23,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$23,$23,0x0004
	li	$20,16711680			# 0x00ff0000
	ori	$20,$20,0xffff
 #APP
 #NO_APP
	li	$12,-16777216			# 0xff000000
	lw	$16,0($23)
	lw	$5,528482304
	move	$4,$16
	lw	$3,0($16)
	lw	$2,0($5)
	and	$3,$3,$12
	and	$2,$2,$20
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$2,0($5)
	addu	$3,$16,40
	sw	$3,0($23)
	and	$3,$16,$20
	and	$2,$2,$12
	or	$2,$2,$3
	sw	$2,0($5)
	sra	$2,$21,17
	li	$3,64			# 0x00000040
	subu	$3,$3,$2
	sll	$2,$3,16
	sll	$5,$3,8
	or	$2,$2,$5
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetPolyFT4
	sw	$2,4($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetShadeTex
	move	$5,$0
	.set	macro
	.set	reorder

	sh	$22,8($16)
	sh	$19,10($16)
	lhu	$12,16($sp)
	sh	$19,18($16)
	sh	$22,24($16)
	addu	$2,$22,$12
	sh	$2,16($16)
	lhu	$12,24($sp)
	li	$4,-64			# 0xffffffc0
	sh	$2,32($16)
	addu	$21,$19,$12
	sh	$21,26($16)
	sh	$21,34($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	sb	$3,12($16)
	lbu	$2,26($17)
	#nop
	sb	$2,13($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	lbu	$2,16($17)
	#nop
	addu	$2,$2,$3
	sb	$2,20($16)
	lbu	$2,26($17)
	#nop
	sb	$2,21($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	sb	$3,28($16)
	lbu	$3,26($17)
	lbu	$2,18($17)
	#nop
	addu	$2,$2,$3
	sb	$2,29($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	lbu	$2,16($17)
	#nop
	addu	$2,$2,$3
	sb	$2,36($16)
	lbu	$3,26($17)
	lbu	$2,18($17)
	#nop
	addu	$2,$2,$3
	sb	$2,37($16)
	lbu	$4,9($17)
	lhu	$5,26($17)
	lhu	$3,24($17)
	andi	$4,$4,0x0003
	sll	$4,$4,7
	andi	$2,$5,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	ori	$2,$2,0x0060
	or	$4,$4,$2
	andi	$3,$3,0x03c0
	srl	$3,$3,6
	or	$4,$4,$3
	andi	$5,$5,0x0200
	sll	$5,$5,2
	or	$4,$4,$5
	sh	$4,22($16)
	lw	$5,4($17)
	#nop
	andi	$4,$5,0x003f
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sra	$5,$5,6
	.set	macro
	.set	reorder

	sh	$2,14($16)
	lhu	$2,8($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L635
	lhu	$5,44($18)
	#nop
	subu	$2,$5,$19
	addu	$3,$2,1
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L637
	move	$4,$3
	.set	macro
	.set	reorder

	subu	$4,$0,$3
$L637:
	sll	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L657
	subu	$2,$5,$21
	.set	macro
	.set	reorder

	li	$4,128			# 0x00000080
$L657:
	addu	$3,$2,1
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L639
	move	$8,$3
	.set	macro
	.set	reorder

	subu	$8,$0,$3
$L639:
	sll	$2,$8,1
	move	$8,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	li	$12,-16777216			# 0xff000000
	.set	macro
	.set	reorder

	li	$8,128			# 0x00000080
$L658:
	li	$7,128			# 0x00000080
	lw	$16,0($23)
	lw	$2,528482304
	lw	$3,0($16)
	lw	$2,0($2)
	and	$3,$3,$12
	and	$2,$2,$20
	or	$3,$3,$2
	sll	$2,$4,16
	sra	$2,$2,16
	lw	$12,36($sp)
	subu	$2,$7,$2
	subu	$9,$7,$12
	mult	$9,$2
	li	$12,-16777216			# 0xff000000
	sw	$3,0($16)
	lw	$2,0($23)
	lw	$4,528482304
	addu	$2,$2,52
	sw	$2,0($23)
	lw	$2,0($4)
	and	$3,$16,$20
	and	$2,$2,$12
	or	$2,$2,$3
	sw	$2,0($4)
	mflo	$5
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L641
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,127
$L641:
	sra	$3,$2,7
	sll	$4,$3,16
	sll	$2,$3,8
	or	$6,$4,$2
	sll	$2,$8,16
	sra	$2,$2,16
	subu	$2,$7,$2
	mult	$9,$2
	or	$2,$6,$3
	sw	$2,16($16)
	sw	$2,4($16)
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L644
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,127
$L644:
	sra	$3,$2,7
	sll	$5,$3,16
	sll	$2,$3,8
	or	$2,$5,$2
	or	$2,$2,$3
	sw	$2,40($16)
	sw	$2,28($16)
	li	$2,62			# 0x0000003e
	sb	$2,7($16)
	li	$2,12			# 0x0000000c
	sb	$2,3($16)
	sh	$22,8($16)
	lhu	$12,16($sp)
	lhu	$2,44($18)
	addu	$3,$22,$12
	sll	$2,$2,1
	subu	$2,$2,$19
	sh	$3,20($16)
	sh	$2,10($16)
	lhu	$2,44($18)
	sh	$22,32($16)
	sll	$2,$2,1
	subu	$2,$2,$19
	sh	$2,22($16)
	lhu	$2,44($18)
	sh	$3,44($16)
	lhu	$12,24($sp)
	sll	$2,$2,1
	subu	$2,$2,$19
	subu	$2,$2,$12
	sh	$2,34($16)
	lhu	$2,44($18)
	li	$4,-64			# 0xffffffc0
	sll	$2,$2,1
	subu	$2,$2,$19
	subu	$2,$2,$12
	sh	$2,46($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	sb	$3,12($16)
	lbu	$2,26($17)
	#nop
	addu	$2,$2,-1
	sb	$2,13($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	lbu	$2,16($17)
	#nop
	addu	$2,$2,$3
	sb	$2,24($16)
	lbu	$2,26($17)
	#nop
	addu	$2,$2,-1
	sb	$2,25($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	sb	$3,36($16)
	lbu	$2,26($17)
	lbu	$3,18($17)
	addu	$2,$2,-1
	addu	$3,$3,$2
	sb	$3,37($16)
	lhu	$2,24($17)
	lh	$3,24($17)
	and	$2,$2,$4
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($17)
	sll	$3,$3,4
	div	$3,$3,$2
	lbu	$2,16($17)
	#nop
	addu	$2,$2,$3
	sb	$2,48($16)
	lbu	$2,26($17)
	lbu	$3,18($17)
	addu	$2,$2,-1
	addu	$3,$3,$2
	sb	$3,49($16)
	lbu	$4,9($17)
	lhu	$5,26($17)
	lhu	$3,24($17)
	andi	$4,$4,0x0003
	sll	$4,$4,7
	andi	$2,$5,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	ori	$2,$2,0x0060
	or	$4,$4,$2
	andi	$3,$3,0x03c0
	srl	$3,$3,6
	or	$4,$4,$3
	andi	$5,$5,0x0200
	sll	$5,$5,2
	or	$4,$4,$5
	sh	$4,26($16)
	lw	$5,4($17)
	#nop
	andi	$4,$5,0x003f
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sra	$5,$5,6
	.set	macro
	.set	reorder

	sh	$2,14($16)
$L635:
	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	li	$20,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$20,$20,0x0004
	li	$17,16711680			# 0x00ff0000
	ori	$17,$17,0xffff
	li	$21,-16777216			# 0xff000000
 #APP
 #NO_APP
	li	$23,528482304			# 0x1f800000
	lw	$16,0($20)
	lw	$2,0($23)
	lw	$3,0($16)
	lw	$2,0($2)
	and	$3,$3,$21
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$5,0($23)
	move	$4,$16
	lw	$2,0($5)
	addu	$3,$16,40
	sw	$3,0($20)
	and	$3,$16,$17
	and	$2,$2,$21
	or	$2,$2,$3
	sw	$2,0($5)
	.set	noreorder
	.set	nomacro
	jal	SetPolyFT4
	sw	$fp,4($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$12,32($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SetShadeTex
	xori	$5,$12,0x0001
	.set	macro
	.set	reorder

	sh	$22,8($16)
	sh	$19,10($16)
	lhu	$12,16($sp)
	#nop
	addu	$9,$22,$12
	sh	$9,16($16)
	sh	$19,18($16)
	sh	$22,24($16)
	lhu	$12,24($sp)
	sh	$9,32($16)
	addu	$6,$19,$12
	sh	$6,26($16)
	sh	$6,34($16)
	lbu	$2,28($18)
	#nop
	sb	$2,12($16)
	lbu	$2,29($18)
	#nop
	sb	$2,13($16)
	lbu	$2,28($18)
	lbu	$3,30($18)
	#nop
	addu	$2,$2,$3
	sb	$2,20($16)
	lbu	$2,29($18)
	#nop
	sb	$2,21($16)
	lbu	$2,28($18)
	#nop
	sb	$2,28($16)
	lbu	$2,29($18)
	lbu	$3,31($18)
	#nop
	addu	$2,$2,$3
	sb	$2,29($16)
	lbu	$2,28($18)
	lbu	$3,30($18)
	#nop
	addu	$2,$2,$3
	sb	$2,36($16)
	lbu	$2,29($18)
	lbu	$3,31($18)
	#nop
	addu	$2,$2,$3
	sb	$2,37($16)
	lhu	$2,36($18)
	#nop
	sh	$2,22($16)
	lhu	$2,34($18)
	#nop
	sh	$2,14($16)
	lhu	$2,8($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L614
	lhu	$5,44($18)
	#nop
	subu	$2,$5,$19
	addu	$3,$2,1
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L649
	move	$4,$3
	.set	macro
	.set	reorder

	subu	$4,$0,$3
$L649:
	sll	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	subu	$2,$5,$6
	.set	macro
	.set	reorder

	li	$4,128			# 0x00000080
$L659:
	addu	$3,$2,1
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L651
	move	$8,$3
	.set	macro
	.set	reorder

	subu	$8,$0,$3
$L651:
	sll	$2,$8,1
	move	$8,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	srl	$3,$fp,16
	.set	macro
	.set	reorder

	li	$8,128			# 0x00000080
$L660:
	andi	$3,$3,0x00ff
	sll	$2,$4,16
	sra	$2,$2,16
	li	$6,128			# 0x00000080
	subu	$2,$6,$2
	mult	$3,$2
	mflo	$10
	#nop
	srl	$4,$fp,8
	andi	$4,$4,0x00ff
	mult	$4,$2
	mflo	$13
	#nop
	andi	$7,$fp,0x00ff
	mult	$7,$2
	sll	$2,$8,16
	mflo	$11
	#nop
	sra	$2,$2,16
	subu	$6,$6,$2
	mult	$3,$6
	lw	$2,0($23)
	lw	$16,0($20)
	lw	$2,0($2)
	lw	$3,0($16)
	and	$2,$2,$17
	and	$3,$3,$21
	or	$3,$3,$2
	addu	$2,$16,52
	mflo	$8
	#nop
	sw	$3,0($16)
	sw	$2,0($20)
	mult	$4,$6
	lw	$5,0($23)
	#nop
	lw	$2,0($5)
	and	$3,$16,$17
	and	$2,$2,$21
	or	$2,$2,$3
	sw	$2,0($5)
	li	$2,12			# 0x0000000c
	sb	$2,3($16)
	srl	$2,$10,7
	sll	$2,$2,16
	mflo	$4
	#nop
	srl	$3,$13,7
	sll	$3,$3,8
	mult	$7,$6
	or	$2,$2,$3
	srl	$3,$11,7
	or	$2,$2,$3
	sh	$22,8($16)
	sw	$2,16($16)
	sw	$2,4($16)
	srl	$3,$8,7
	sll	$3,$3,16
	srl	$2,$4,7
	sll	$2,$2,8
	or	$3,$3,$2
	mflo	$6
	#nop
	#nop
	srl	$2,$6,7
	or	$3,$3,$2
	li	$2,60			# 0x0000003c
	sw	$3,40($16)
	sw	$3,28($16)
	sb	$2,7($16)
	lhu	$2,44($18)
	sh	$9,20($16)
	sll	$2,$2,1
	subu	$2,$2,$19
	sh	$2,10($16)
	lhu	$2,44($18)
	sh	$22,32($16)
	sll	$2,$2,1
	subu	$2,$2,$19
	sh	$2,22($16)
	lhu	$2,44($18)
	sh	$9,44($16)
	lhu	$12,24($sp)
	sll	$2,$2,1
	subu	$2,$2,$19
	subu	$2,$2,$12
	sh	$2,34($16)
 #APP
 #NO_APP
	lhu	$2,44($18)
	#nop
	sll	$2,$2,1
	subu	$2,$2,$19
	subu	$2,$2,$12
	sh	$2,46($16)
	lbu	$2,28($18)
	#nop
	sb	$2,12($16)
	lbu	$2,29($18)
	#nop
	addu	$2,$2,-1
	sb	$2,13($16)
	lbu	$2,28($18)
	lbu	$3,30($18)
	#nop
	addu	$2,$2,$3
	sb	$2,24($16)
	lbu	$2,29($18)
	#nop
	addu	$2,$2,-1
	sb	$2,25($16)
	lbu	$2,28($18)
	#nop
	sb	$2,36($16)
	lbu	$2,29($18)
	lbu	$3,31($18)
	addu	$2,$2,255
	addu	$3,$3,$2
	sb	$3,37($16)
	lbu	$2,28($18)
	lbu	$3,30($18)
	#nop
	addu	$2,$2,$3
	sb	$2,48($16)
	lbu	$2,29($18)
	lbu	$3,31($18)
	addu	$2,$2,255
	addu	$3,$3,$2
	sb	$3,49($16)
	lhu	$2,36($18)
	#nop
	sh	$2,26($16)
	lhu	$2,34($18)
	#nop
	sh	$2,14($16)
$L614:
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

	.end	DrawTV__FR9tTVConfig
	.align	2
	.globl	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
	.ent	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
InitTV__FR9tTVConfigP18tTexture_ShapeInfos:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sll	$16,$6,16
	sra	$16,$16,11
	addu	$16,$16,$5
	sw	$31,24($sp)
	sw	$0,0($17)
	sh	$0,8($17)
	lhu	$2,20($16)
	#nop
	subu	$2,$0,$2
	sh	$2,20($17)
	lhu	$2,22($16)
	#nop
	subu	$2,$0,$2
	sh	$2,22($17)
	lhu	$2,16($16)
	#nop
	sh	$2,24($17)
	lhu	$2,18($16)
	#nop
	sh	$2,26($17)
	lhu	$2,24($16)
	lh	$3,24($16)
	andi	$2,$2,0xffc0
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$3,$3,$2
	lbu	$2,8($16)
	sll	$3,$3,4
	div	$3,$3,$2
	lbu	$2,26($17)
	sb	$3,28($17)
	lbu	$3,24($17)
	lbu	$4,26($16)
	sb	$2,31($17)
	sb	$3,30($17)
	sb	$4,29($17)
	lhu	$2,24($16)
	#nop
	sh	$2,38($17)
	lhu	$2,26($16)
	#nop
	sh	$2,40($17)
	lhu	$2,4($16)
	#nop
	sh	$2,42($17)
	lbu	$2,9($16)
	lhu	$5,42($17)
	andi	$2,$2,0x0003
	andi	$4,$5,0x003f
	sll	$4,$4,4
	srl	$5,$5,6
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sb	$2,32($17)
	.set	macro
	.set	reorder

	sh	$2,34($17)
	lbu	$4,9($16)
	lhu	$5,26($16)
	lhu	$3,24($16)
	andi	$4,$4,0x0003
	sll	$4,$4,7
	andi	$2,$5,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	or	$4,$4,$2
	andi	$3,$3,0x03c0
	srl	$3,$3,6
	or	$4,$4,$3
	andi	$5,$5,0x0200
	sll	$5,$5,2
	or	$4,$4,$5
	.set	noreorder
	.set	nomacro
	jal	rand
	sh	$4,36($17)
	.set	macro
	.set	reorder

	lh	$4,26($17)
	#nop
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,4
	rem	$3,$2,$3
	.set	noreorder
	.set	nomacro
	jal	rand
	sh	$3,10($17)
	.set	macro
	.set	reorder

	lh	$4,26($17)
	#nop
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,4
	rem	$3,$2,$3
	sh	$0,44($17)
	sh	$0,4($17)
	li	$2,8388608			# 0x00800000
	ori	$2,$2,0x8080
	sw	$2,16($17)
	li	$2,128			# 0x00000080
	sh	$2,6($17)
	sh	$3,12($17)
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

	.end	InitTV__FR9tTVConfigP18tTexture_ShapeInfos
	.align	2
	.globl	TurnOffTV__FR9tTVConfig
	.ent	TurnOffTV__FR9tTVConfig
TurnOffTV__FR9tTVConfig:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,3			# 0x00000003
	sw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,6($4)
	.set	macro
	.set	reorder

	.end	TurnOffTV__FR9tTVConfig
	.align	2
	.globl	TurnOnTV__FR9tTVConfig
	.ent	TurnOnTV__FR9tTVConfig
TurnOnTV__FR9tTVConfig:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,2			# 0x00000002
	sw	$2,0($4)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,6($4)
	.set	macro
	.set	reorder

	.end	TurnOnTV__FR9tTVConfig
