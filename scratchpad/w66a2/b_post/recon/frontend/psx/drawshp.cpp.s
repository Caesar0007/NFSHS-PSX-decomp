	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\drawshp.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	DrawShape_SubtractNFS4RectEdges__FR4RECT
	.align	2
	.globl	DrawShape_NFS4RoundRectangle__FiR4RECTs
	.align	2
	.globl	DrawShape_NFS4Rectangle__FR4RECT
	.align	2
	.globl	DrawShape_NFS4TransRectangle__FR4RECTs
	.globl	kNoColor
	.sdata
	.align	2
kNoColor:
	.space	4

	.extern	gHelpShapes, 4

	.text
	.text
	.ent	DrawShape_SubtractNFS4RectEdges__FR4RECT
DrawShape_SubtractNFS4RectEdges__FR4RECT:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$9,$4
	move	$13,$0
	li	$14,528482304			# 0x1f800000
	ori	$14,$14,0x0004
	sw	$16,24($sp)
	li	$16,528482304			# 0x1f800000
	li	$8,16711680			# 0x00ff0000
	ori	$8,$8,0xffff
	li	$15,-16777216			# 0xff000000
	li	$12,8388608			# 0x00800000
	ori	$12,$12,0x8080
	sw	$31,28($sp)
	lhu	$2,2($9)
	lhu	$3,6($9)
	addu	$2,$2,1
	move	$11,$2
	addu	$2,$2,$3
	addu	$10,$2,-1
	lhu	$3,0($9)
	lhu	$2,4($9)
	addu	$7,$3,2
	sll	$2,$2,16
	sra	$2,$2,19
	addu	$6,$3,$2
$L601:
	lw	$4,0($14)
	lw	$5,0($16)
	lw	$3,0($4)
	lw	$2,0($5)
	and	$3,$3,$15
	and	$2,$2,$8
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($5)
	addu	$2,$4,36
	sw	$2,0($14)
	and	$2,$4,$8
	and	$3,$3,$15
	or	$3,$3,$2
	li	$2,58			# 0x0000003a
	sw	$3,0($5)
	sw	$12,4($4)
	sb	$2,7($4)
	li	$2,8			# 0x00000008
	sb	$2,3($4)
	addu	$2,$11,2
	sh	$2,10($4)
	addu	$2,$10,-2
	addu	$3,$13,1
	move	$13,$3
	sll	$3,$3,16
	sra	$3,$3,16
	sw	$12,20($4)
	sw	$0,28($4)
	sw	$0,12($4)
	sh	$7,8($4)
	sh	$6,16($4)
	sh	$11,18($4)
	sh	$7,24($4)
	sh	$2,26($4)
	sh	$6,32($4)
	sh	$10,34($4)
	lhu	$4,0($9)
	lhu	$2,4($9)
	slt	$3,$3,2
	addu	$4,$4,$2
	addu	$4,$4,-2
	move	$7,$4
	sll	$2,$2,16
	sra	$2,$2,19
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L601
	subu	$6,$4,$2
	.set	macro
	.set	reorder

	li	$11,528482304			# 0x1f800000
	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$4,2			# 0x00000002
	move	$5,$4
	move	$6,$0
	li	$7,256			# 0x00000100
	li	$10,-16777216			# 0xff000000
	lw	$16,0($11)
	lw	$8,528482304
	lw	$3,0($16)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,12
	lw	$2,0($8)
	and	$9,$16,$9
	sw	$3,0($11)
	and	$2,$2,$10
	or	$2,$2,$9
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sw	$2,0($8)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	move	$6,$5
	andi	$7,$2,0xffff
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	DrawShape_SubtractNFS4RectEdges__FR4RECT
	.text
	.ent	DrawShape_NFS4RoundRectangle__FiR4RECTs
DrawShape_NFS4RoundRectangle__FiR4RECTs:
	.frame	$sp,80,$31		# vars= 24, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lw	$2,gHelpShapes
	subu	$sp,$sp,80
	sw	$17,60($sp)
	move	$17,$5
	sw	$16,56($sp)
	move	$16,$6
	sw	$19,68($sp)
	move	$19,$0
	sw	$31,76($sp)
	sw	$20,72($sp)
	sw	$18,64($sp)
	.set	noreorder
	.set	nomacro
	bltz	$4,$L606
	addu	$18,$2,1312
	.set	macro
	.set	reorder

	sll	$4,$4,16
	sra	$4,$4,16
	li	$7,2			# 0x00000002
	lhu	$3,4($17)
	lhu	$5,0($17)
	lhu	$6,2($17)
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	sll	$3,$3,16
	sra	$3,$3,17
	addu	$5,$5,$3
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,4
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L606:
	sll	$2,$16,16
	sra	$20,$2,16
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L610
	li	$4,41			# 0x00000029
	.set	macro
	.set	reorder

	li	$19,1			# 0x00000001
$L610:
	ori	$5,$19,0x0008
	lh	$6,0($17)
	lh	$7,2($17)
	addu	$16,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$4,41			# 0x00000029
	lh	$6,0($17)
	lh	$2,4($17)
	lh	$3,16($18)
	lh	$7,2($17)
	ori	$5,$19,0x000c
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$6,$6,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L608
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,8650752			# 0x00840000
	ori	$4,$4,0x1d08
	lh	$5,0($17)
	lh	$3,16($18)
	lh	$6,2($17)
	lh	$8,18($18)
	lh	$7,4($17)
	sw	$2,16($sp)
	addu	$5,$5,$3
	addu	$6,$6,$8
	addu	$6,$6,-1
	sll	$3,$3,$2
	subu	$7,$7,$3
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$7,$7,$2
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,0($17)
	lh	$2,16($18)
	lh	$6,2($17)
	lh	$7,4($17)
	addu	$5,$5,$2
	sll	$2,$2,1
	subu	$7,$7,$2
	lh	$2,18($18)
	addu	$7,$7,1
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	j	$L605
$L608:
	li	$4,8650752			# 0x00840000
	ori	$4,$4,0x1d08
	lh	$5,0($17)
	lh	$2,16($18)
	lh	$6,2($17)
	lh	$3,18($18)
	lh	$7,4($17)
	li	$16,1			# 0x00000001
	sw	$16,16($sp)
	sw	$16,20($sp)
	addu	$5,$5,$2
	addu	$6,$6,$3
	addu	$6,$6,-1
	sll	$2,$2,$16
	subu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	addu	$7,$7,$16
	.set	macro
	.set	reorder

	lh	$5,0($17)
	lh	$2,16($18)
	lh	$6,2($17)
	lh	$7,4($17)
	lh	$3,18($18)
	move	$4,$0
	sw	$16,20($sp)
	addu	$5,$5,$2
	sll	$2,$2,$16
	subu	$7,$7,$2
	addu	$7,$7,$16
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

$L605:
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

	.end	DrawShape_NFS4RoundRectangle__FiR4RECTs
	.text
	.ent	DrawShape_NFS4Rectangle__FR4RECT
DrawShape_NFS4Rectangle__FR4RECT:
	.frame	$sp,96,$31		# vars= 24, regs= 7/0, args= 40, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$16,64($sp)
	move	$16,$4
	li	$6,8060928			# 0x007b0000
	ori	$6,$6,0x2908
	li	$5,1376256			# 0x00150000
	ori	$5,$5,0x0800
	li	$3,2686976			# 0x00290000
	ori	$3,$3,0x1000
	li	$2,4849664			# 0x004a0000
	ori	$2,$2,0x1900
	li	$4,42			# 0x0000002a
	sw	$5,48($sp)
	li	$5,9			# 0x00000009
	sw	$2,56($sp)
	lui	$2,%hi(gHelpShapes) # high
	sw	$31,88($sp)
	sw	$21,84($sp)
	sw	$20,80($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$6,44($sp)
	sw	$3,52($sp)
	lh	$6,0($16)
	lh	$7,2($16)
	lw	$18,%lo(gHelpShapes)($2)
	addu	$17,$sp,40
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$21,$18,1344
	addu	$19,$18,1376
	addu	$20,$18,1408
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$18,$18,1440
	.set	macro
	.set	reorder

	li	$4,43			# 0x0000002b
	lh	$6,0($16)
	lh	$2,4($16)
	lh	$3,16($19)
	lh	$7,2($16)
	li	$5,9			# 0x00000009
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$6,$6,$3
	.set	macro
	.set	reorder

	li	$4,44			# 0x0000002c
	lh	$6,0($16)
	lh	$7,2($16)
	lh	$2,6($16)
	lh	$3,18($20)
	li	$5,9			# 0x00000009
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$7,$7,$3
	.set	macro
	.set	reorder

	li	$4,45			# 0x0000002d
	lh	$6,0($16)
	lh	$8,4($16)
	lh	$9,16($18)
	lh	$7,2($16)
	lh	$2,6($16)
	lh	$3,18($18)
	li	$5,9			# 0x00000009
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$8
	subu	$6,$6,$9
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$7,$7,$3
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$2,16($21)
	lh	$6,2($16)
	lh	$7,4($16)
	lh	$3,16($19)
	li	$17,1			# 0x00000001
	sw	$17,16($sp)
	sw	$17,20($sp)
	lw	$4,48($sp)
	addu	$5,$5,$2
	subu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	subu	$7,$7,$3
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$3,16($20)
	lh	$6,2($16)
	lh	$2,6($16)
	lh	$7,4($16)
	lh	$8,16($18)
	sw	$17,16($sp)
	sw	$17,20($sp)
	lw	$4,44($sp)
	addu	$5,$5,$3
	addu	$6,$6,$2
	addu	$6,$6,-1
	subu	$7,$7,$3
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	subu	$7,$7,$8
	.set	macro
	.set	reorder

	lh	$4,0($16)
	lh	$5,2($16)
	lh	$3,18($21)
	lh	$7,6($16)
	lh	$8,18($20)
	li	$6,2			# 0x00000002
	sw	$17,16($sp)
	lw	$2,52($sp)
	addu	$5,$5,$3
	subu	$7,$7,$3
	sw	$2,20($sp)
	sw	$2,24($sp)
	lw	$2,56($sp)
	subu	$7,$7,$8
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransGouraudSquare__Fiiiiiiiii
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	lh	$4,0($16)
	lh	$3,4($16)
	lh	$5,2($16)
	lh	$8,18($19)
	lh	$7,6($16)
	lh	$9,18($18)
	li	$6,2			# 0x00000002
	sw	$17,16($sp)
	lw	$2,52($sp)
	addu	$4,$4,$3
	addu	$4,$4,-2
	addu	$5,$5,$8
	subu	$7,$7,$8
	sw	$2,20($sp)
	sw	$2,24($sp)
	lw	$2,56($sp)
	subu	$7,$7,$9
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransGouraudSquare__Fiiiiiiiii
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$6,2($16)
	lh	$3,18($21)
	lh	$7,16($21)
	lh	$2,6($16)
	lh	$8,18($20)
	move	$4,$0
	sw	$17,20($sp)
	addu	$5,$5,2
	addu	$6,$6,$3
	addu	$7,$7,-2
	subu	$2,$2,$3
	subu	$2,$2,$8
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$8,4($16)
	lh	$6,2($16)
	lh	$3,18($19)
	lh	$7,16($19)
	lh	$2,6($16)
	lh	$9,18($18)
	move	$4,$0
	sw	$17,20($sp)
	addu	$5,$5,$8
	addu	$5,$5,-2
	addu	$6,$6,$3
	subu	$7,$0,$7
	addu	$7,$7,2
	subu	$2,$2,$3
	subu	$2,$2,$9
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$3,16($21)
	lh	$6,2($16)
	lh	$7,4($16)
	lh	$8,16($19)
	lh	$2,6($16)
	move	$4,$0
	sw	$17,20($sp)
	addu	$5,$5,$3
	addu	$6,$6,$17
	subu	$7,$7,$3
	subu	$7,$7,$8
	addu	$2,$2,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

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

	.end	DrawShape_NFS4Rectangle__FR4RECT
	.text
	.ent	DrawShape_NFS4TransRectangle__FR4RECTs
DrawShape_NFS4TransRectangle__FR4RECTs:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$18,32($sp)
	move	$18,$5
	move	$4,$0
	li	$7,4			# 0x00000004
	sw	$17,28($sp)
	sll	$17,$18,17
	sw	$31,40($sp)
	sw	$19,36($sp)
	lh	$5,0($16)
	lh	$6,2($16)
	lh	$2,6($16)
	sra	$17,$17,16
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,0($16)
	lh	$2,4($16)
	lh	$6,2($16)
	lh	$3,6($16)
	li	$7,4			# 0x00000004
	sw	$17,20($sp)
	addu	$5,$5,$2
	addu	$5,$5,-4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,0($16)
	lh	$6,2($16)
	lh	$7,4($16)
	li	$19,2			# 0x00000002
	sw	$19,16($sp)
	sw	$17,20($sp)
	addu	$5,$5,4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	addu	$7,$7,-8
	.set	macro
	.set	reorder

	lh	$5,0($16)
	lh	$6,2($16)
	lh	$2,6($16)
	lh	$7,4($16)
	move	$4,$0
	sw	$19,16($sp)
	sw	$17,20($sp)
	addu	$5,$5,4
	addu	$6,$6,$2
	addu	$6,$6,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	addu	$7,$7,-8
	.set	macro
	.set	reorder

	move	$4,$0
	sll	$18,$18,16
	lh	$5,0($16)
	lh	$6,2($16)
	lh	$7,4($16)
	lh	$2,6($16)
	sra	$18,$18,16
	sw	$18,20($sp)
	addu	$5,$5,4
	addu	$6,$6,$19
	addu	$7,$7,-8
	addu	$2,$2,-4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
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

	.end	DrawShape_NFS4TransRectangle__FR4RECTs
