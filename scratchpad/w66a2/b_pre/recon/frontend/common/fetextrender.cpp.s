	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fetextrender.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	textDefinitions
	.data
	.align	2
textDefinitions:
	.byte	3
	.byte	0
	.byte	0
	.byte	9
	.byte	9
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	10
	.byte	10
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	17
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	9
	.byte	9
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	16
	.byte	20
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	16
	.byte	20
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	17
	.byte	17
	.byte	17
	.byte	0
	.byte	0
	.byte	0
	.byte	15
	.byte	15
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	9
	.byte	9
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	15
	.byte	10
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	20
	.byte	9
	.byte	1
	.byte	0
	.byte	0
	.byte	16
	.byte	20
	.byte	9
	.byte	3
	.byte	2
	.byte	0
	.byte	9
	.byte	9
	.byte	9
	.globl	gSemiTransText
	.section .data,"aw",@progbits
	.align	2
gSemiTransText:
	.word	0
	.text
	.align	2
	.globl	FETextRender_SetFont__Fi
	.ent	FETextRender_SetFont__Fi
FETextRender_SetFont__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$3,%hi(currentSize) # high
	lh	$2,%lo(currentSize)($3)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L600
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	sh	$4,%lo(currentSize)($3)
	sll	$2,$4,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L603
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L604
	lui	$2,%hi(font18) # high
	.set	macro
	.set	reorder

	j	$L605
$L603:
	lui	$2,%hi(font12) # high
	lw	$4,%lo(font12)($2)
	j	$L602
$L604:
	lui	$2,%hi(fontTitle) # high
	lw	$4,%lo(fontTitle)($2)
	j	$L602
$L605:
	lw	$4,%lo(font18)($2)
$L602:
	jal	Font_SwitchFont__FPc
$L600:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FETextRender_SetFont__Fi
	.rdata
	.align	2
$LC0:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	FETextRender_FullTextRGB__FPcssics
	.ent	FETextRender_FullTextRGB__FPcssics
FETextRender_FullTextRGB__FPcssics:
	.frame	$sp,184,$31		# vars= 128, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$16,144($sp)
	lbu	$16,200($sp)
	sw	$19,156($sp)
	lw	$19,204($sp)
	sw	$20,160($sp)
	move	$20,$5
	sw	$18,152($sp)
	move	$18,$20
	sw	$17,148($sp)
	move	$17,$4
	sw	$23,172($sp)
	move	$23,$7
	sw	$21,164($sp)
	move	$21,$6
	sw	$31,176($sp)
	sw	$22,168($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$22,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L618
	sll	$2,$19,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$17,$sp,16
	sll	$2,$19,16
$L618:
	sra	$3,$2,16
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L611
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L611
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L610
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L611:
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	subu	$18,$18,$2
	.set	macro
	.set	reorder

$L610:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L614
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L619
	lui	$2,%hi(gSemiTransText) # high
	.set	macro
	.set	reorder

$L614:
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$17
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	sra	$3,$3,1
	subu	$18,$20,$3
$L612:
	lui	$2,%hi(gSemiTransText) # high
$L619:
	lw	$2,%lo(gSemiTransText)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,15			# 0x0000000f
$L615:
	jal	Font_TextColor__Fi
	.set	noreorder
	.set	nomacro
	jal	Font_TextTint__Fi
	move	$4,$23
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$2,$18,16
	sra	$18,$2,16
	move	$5,$18
	sll	$2,$21,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$2,$22,-3
	andi	$2,$2,0xffff
	sltu	$2,$2,3
	beq	$2,$0,$L608
	.set	noreorder
	.set	nomacro
	jal	Font_TextTint__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$18,2
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$16,1
	.set	macro
	.set	reorder

$L608:
	lw	$31,176($sp)
	lw	$23,172($sp)
	lw	$22,168($sp)
	lw	$21,164($sp)
	lw	$20,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	FETextRender_FullTextRGB__FPcssics
	.align	2
	.globl	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	.ent	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$9,%hi(kRGBVals) # high
	lui	$8,%hi(textDefinitions) # high
	addiu	$8,$8,%lo(textDefinitions) # low
	sll	$3,$7,1
	addu	$3,$3,$7
	sll	$3,$3,1
	addu	$7,$3,3
	addiu	$9,$9,%lo(kRGBVals) # low
	addu	$3,$3,$8
	sll	$5,$5,16
	sll	$6,$6,16
	sra	$5,$5,16
	lw	$2,48($sp)
	sra	$6,$6,16
	sw	$31,24($sp)
	lbu	$3,0($3)
	addu	$2,$2,$7
	addu	$2,$2,$8
	lbu	$7,0($2)
	lw	$2,52($sp)
	sll	$7,$7,2
	addu	$7,$7,$9
	sll	$2,$2,16
	lw	$7,0($7)
	sra	$2,$2,16
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	.align	2
	.globl	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	.ent	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,44($sp)
	move	$21,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$20,40($sp)
	move	$5,$4
	lui	$4,%hi(kRGBVals) # high
	sw	$18,32($sp)
	lui	$18,%hi(textDefinitions) # high
	lw	$2,72($sp)
	addiu	$18,$18,%lo(textDefinitions) # low
	sw	$31,48($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,1
	lw	$2,76($sp)
	addu	$3,$16,3
	addu	$2,$2,$3
	addu	$2,$2,$18
	lbu	$2,0($2)
	addiu	$4,$4,%lo(kRGBVals) # low
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$4,0($2)
	lw	$17,80($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$20,$7
	.set	macro
	.set	reorder

	move	$4,$21
	sll	$19,$19,16
	sra	$5,$19,16
	addu	$16,$16,$18
	sll	$17,$17,16
	sra	$17,$17,16
	sll	$20,$20,16
	sra	$6,$20,16
	lbu	$3,0($16)
	move	$7,$2
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	lw	$31,48($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	.align	2
	.globl	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	.ent	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$19,36($sp)
	move	$19,$7
	lw	$5,64($sp)
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L625
	sw	$31,40($sp)
	.set	macro
	.set	reorder

	sll	$4,$16,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	move	$5,$2
$L625:
	sll	$4,$16,16
	lui	$3,%hi(textDefinitions) # high
	addiu	$3,$3,%lo(textDefinitions) # low
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,1
	addu	$2,$2,$3
	lbu	$7,1($2)
	sra	$4,$4,16
	sw	$5,20($sp)
	sll	$5,$17,16
	sll	$6,$18,16
	sra	$5,$5,16
	sra	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$19,16($sp)
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

	.end	FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	.ent	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType:
	.frame	$sp,64,$31		# vars= 0, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$21,52($sp)
	move	$21,$4
	sw	$16,32($sp)
	move	$16,$7
	sll	$5,$5,16
	sw	$17,36($sp)
	sra	$17,$5,16
	move	$4,$17
	sw	$20,48($sp)
	move	$20,$6
	sw	$31,56($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	sw	$18,40($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$19,$2
	.set	macro
	.set	reorder

	move	$18,$2
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L630
	lui	$3,%hi(textDefinitions) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	move	$16,$2
	lui	$3,%hi(textDefinitions) # high
$L630:
	addiu	$3,$3,%lo(textDefinitions) # low
	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$2,$2,1
	addu	$2,$2,$3
	move	$4,$21
	sll	$6,$19,16
	sll	$7,$18,16
	move	$5,$17
	sra	$6,$6,16
	lbu	$2,1($2)
	sra	$7,$7,16
	sw	$20,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

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

	.end	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	.ent	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sll	$7,$7,16
	lw	$2,56($sp)
	lw	$3,60($sp)
	sra	$7,$7,16
	sw	$7,16($sp)
	sll	$7,$6,16
	sra	$7,$7,16
	sw	$31,32($sp)
	sw	$2,20($sp)
	sll	$2,$4,16
	sw	$3,24($sp)
	sll	$3,$5,16
	move	$4,$0
	sra	$5,$2,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sra	$6,$3,16
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

	.end	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	.ent	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType:
	.frame	$sp,64,$31		# vars= 0, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,32($sp)
	lw	$16,88($sp)
	sw	$21,52($sp)
	move	$21,$4
	sw	$17,36($sp)
	move	$17,$5
	sw	$19,44($sp)
	move	$19,$6
	sw	$20,48($sp)
	move	$20,$7
	sw	$18,40($sp)
	lh	$18,80($sp)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L635
	sw	$31,56($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L634
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

$L635:
	sll	$4,$17,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_Title__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

	j	$L633
$L634:
	bne	$16,$2,$L637
	sll	$4,$17,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	move	$16,$2
$L637:
	sll	$4,$17,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	move	$4,$21
	sll	$6,$19,16
	sll	$7,$20,16
	move	$5,$2
	sra	$6,$6,16
	lw	$3,84($sp)
	sra	$7,$7,16
	sw	$16,16($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$3,20($sp)
	.set	macro
	.set	reorder

$L633:
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

	.end	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	.ent	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib:
	.frame	$sp,712,$31		# vars= 656, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,712
	sw	$17,676($sp)
	lw	$17,728($sp)
	sw	$16,672($sp)
	move	$16,$4
	sw	$23,700($sp)
	move	$23,$5
	sw	$31,708($sp)
	sw	$fp,704($sp)
	sw	$22,696($sp)
	sw	$21,692($sp)
	sw	$20,688($sp)
	sw	$19,684($sp)
	sw	$18,680($sp)
	sw	$6,720($sp)
	sw	$7,724($sp)
	lh	$8,2($23)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	sw	$8,656($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L642
	slt	$2,$17,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L701
	li	$8,16			# 0x00000010
	.set	macro
	.set	reorder

	bne	$17,$0,$L701
	.set	noreorder
	.set	nomacro
	j	$L701
	li	$8,8			# 0x00000008
	.set	macro
	.set	reorder

$L642:
	li	$8,10			# 0x0000000a
$L701:
	sh	$8,664($sp)
	move	$20,$0
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lui	$3,%hi(gSemiTransText) # high
	lw	$3,%lo(gSemiTransText)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L647
	move	$fp,$2
	.set	macro
	.set	reorder

	li	$4,15			# 0x0000000f
$L647:
	jal	Font_TextColor__Fi
	lw	$4,720($sp)
	jal	Font_TextTint__Fi
	move	$4,$16
	addu	$16,$sp,144
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$6,$fp,1
	.set	macro
	.set	reorder

	bne	$17,$0,$L649
	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	move	$4,$16
	.set	macro
	.set	reorder

$L649:
	.set	noreorder
	.set	nomacro
	blez	$fp,$L650
	move	$19,$16
	.set	macro
	.set	reorder

	li	$22,32			# 0x00000020
	addu	$21,$sp,16
	andi	$2,$20,0xffff
$L714:
	addu	$2,$19,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L655
	li	$3,32			# 0x00000020
	.set	macro
	.set	reorder

	addu	$20,$20,1
$L702:
	andi	$2,$20,0xffff
	addu	$2,$19,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L702
	addu	$20,$20,1
	.set	macro
	.set	reorder

	addu	$20,$20,-1
$L655:
	lhu	$2,4($23)
	#nop
	sll	$2,$2,16
	sra	$2,$2,19
	addu	$2,$20,$2
	addu	$17,$2,10
	andi	$2,$17,0xffff
	slt	$2,$fp,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L703
	andi	$18,$20,0xffff
	.set	macro
	.set	reorder

	move	$17,$fp
$L703:
	addu	$4,$19,$18
	addu	$5,$sp,16
	andi	$16,$17,0xffff
	subu	$16,$16,$18
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$6,$16,1
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$16,$21,$16
	.set	noreorder
	.set	nomacro
	jal	textpixels
	sb	$0,0($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lh	$3,4($23)
	sra	$2,$2,16
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L704
	andi	$3,$17,0xffff
	.set	macro
	.set	reorder

$L709:
	addu	$2,$19,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$22,$L699
	li	$4,32			# 0x00000020
	.set	macro
	.set	reorder

	sltu	$2,$18,$3
$L706:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L705
	andi	$2,$17,0xffff
	.set	macro
	.set	reorder

	addu	$17,$17,-1
	andi	$3,$17,0xffff
	addu	$2,$19,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L706
	sltu	$2,$18,$3
	.set	macro
	.set	reorder

	andi	$2,$17,0xffff
$L705:
	addu	$2,$19,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L707
	move	$4,$21
	.set	macro
	.set	reorder

$L699:
	addu	$3,$sp,144
	li	$4,32			# 0x00000020
	andi	$2,$17,0xffff
$L708:
	sltu	$2,$18,$2
	beq	$2,$0,$L669
	addu	$17,$17,-1
	andi	$2,$17,0xffff
	addu	$2,$3,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L708
	andi	$2,$17,0xffff
	.set	macro
	.set	reorder

$L669:
	move	$4,$21
$L707:
	andi	$16,$17,0xffff
	subu	$2,$16,$18
	addu	$2,$2,$21
	.set	noreorder
	.set	nomacro
	jal	textpixels
	sb	$0,1($2)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lh	$3,4($23)
	sra	$2,$2,16
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L659
	sltu	$2,$18,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	andi	$3,$17,0xffff
	.set	macro
	.set	reorder

$L659:
	andi	$3,$17,0xffff
$L704:
	andi	$2,$20,0xffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L675
	addu	$2,$3,$19
	.set	macro
	.set	reorder

	lbu	$2,1($2)
	#nop
	sb	$2,17($sp)
	addu	$2,$19,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L677
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$2,$4,$3
$L710:
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$22,$L677
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$17,$17,1
	andi	$3,$17,0xffff
	addu	$2,$5,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	addu	$2,$4,$3
	.set	macro
	.set	reorder

$L677:
	andi	$2,$17,0xffff
	andi	$3,$20,0xffff
	subu	$2,$2,$3
	addu	$2,$21,$2
	sb	$0,0($2)
$L675:
	andi	$3,$17,0xffff
	addu	$2,$19,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$2,$4,$3
$L711:
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$22,$L700
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$17,$17,1
	andi	$3,$17,0xffff
	addu	$2,$5,$3
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	addu	$2,$4,$3
	.set	macro
	.set	reorder

$L682:
	andi	$2,$17,0xffff
	addu	$2,$19,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L712
	move	$4,$21
	.set	macro
	.set	reorder

$L700:
	addu	$3,$sp,144
	li	$4,32			# 0x00000020
	addu	$17,$17,1
$L713:
	andi	$2,$17,0xffff
	addu	$2,$3,$2
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L713
	addu	$17,$17,1
	.set	macro
	.set	reorder

	addu	$17,$17,-1
	move	$4,$21
$L712:
	andi	$2,$17,0xffff
	andi	$3,$20,0xffff
	subu	$2,$2,$3
	addu	$2,$21,$2
	.set	noreorder
	.set	nomacro
	jal	textpixels
	sb	$0,0($2)
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,1			# 0x00000001
	lw	$8,724($sp)
	lhu	$3,0($23)
	.set	noreorder
	.set	nomacro
	beq	$8,$2,$L691
	move	$20,$17
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L690
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L691:
	.set	noreorder
	.set	nomacro
	j	$L692
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L690:
	.set	noreorder
	.set	nomacro
	beq	$8,$2,$L694
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$8,$2,$L692
$L694:
	sll	$2,$4,16
	sra	$2,$2,17
	subu	$3,$3,$2
$L692:
	lw	$8,732($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L695
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$16,$2,16
	lh	$6,2($23)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$8,724($sp)
	#nop
	addu	$2,$8,-3
	sltu	$2,$2,3
	beq	$2,$0,$L695
	.set	noreorder
	.set	nomacro
	jal	Font_TextTint__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lh	$6,2($23)
	addu	$5,$16,2
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$6,1
	.set	macro
	.set	reorder

	lw	$4,720($sp)
	jal	Font_TextTint__Fi
$L695:
	lhu	$2,2($23)
	lhu	$8,664($sp)
	#nop
	addu	$2,$2,$8
	sh	$2,2($23)
	andi	$2,$20,0xffff
	slt	$2,$2,$fp
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L714
	andi	$2,$20,0xffff
	.set	macro
	.set	reorder

$L650:
	lh	$2,2($23)
	lw	$8,656($sp)
	lw	$31,708($sp)
	lw	$fp,704($sp)
	lw	$23,700($sp)
	lw	$22,696($sp)
	lw	$21,692($sp)
	lw	$20,688($sp)
	lw	$19,684($sp)
	lw	$18,680($sp)
	lw	$17,676($sp)
	lw	$16,672($sp)
	subu	$2,$2,$8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,712
	.set	macro
	.set	reorder

	.end	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	.align	2
	.globl	FETextRender_WordWrapTextRGB__FPcR4RECTi
	.ent	FETextRender_WordWrapTextRGB__FPcR4RECTi
FETextRender_WordWrapTextRGB__FPcR4RECTi:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$7,$0
	sw	$31,24($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FETextRender_WordWrapTextRGB__FPcR4RECTi
	.align	2
	.globl	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	.ent	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$8,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$19,36($sp)
	move	$19,$6
	lui	$3,%hi(kRGBVals) # high
	sw	$17,28($sp)
	lui	$17,%hi(textDefinitions) # high
	lw	$2,64($sp)
	addiu	$17,$17,%lo(textDefinitions) # low
	sw	$31,40($sp)
	sw	$16,24($sp)
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,1
	addu	$2,$16,3
	addu	$7,$7,$2
	addu	$7,$7,$17
	lbu	$2,0($7)
	addiu	$3,$3,%lo(kRGBVals) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$5,$8
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$16,$16,$17
	move	$5,$19
	lbu	$7,1($16)
	lbu	$3,0($16)
	move	$6,$2
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$3,16($sp)
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

	.end	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	.ent	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$2,$4
	move	$3,$5
	move	$8,$6
	move	$4,$0
	move	$5,$2
	move	$6,$3
	sw	$7,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	move	$7,$8
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
	.ent	FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sll	$4,$5,16
	sw	$16,24($sp)
	lw	$16,64($sp)
	sra	$4,$4,16
	sw	$18,32($sp)
	move	$18,$6
	sw	$19,36($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$19,$7
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$2
	move	$6,$18
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	sw	$16,16($sp)
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

	.end	FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
	.ent	FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$2,$5
	move	$3,$6
	sll	$5,$4,16
	move	$4,$0
	sra	$5,$5,16
	move	$6,$2
	sw	$7,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
	move	$7,$3
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
	.align	2
	.globl	FETextRender_WordWrapHeight__FsPc
	.ent	FETextRender_WordWrapHeight__FsPc
FETextRender_WordWrapHeight__FsPc:
	.frame	$sp,40,$31		# vars= 8, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	li	$2,500			# 0x000001f4
	sh	$2,30($sp)
	li	$2,1			# 0x00000001
	sh	$4,28($sp)
	move	$4,$5
	addu	$5,$sp,24
	move	$6,$0
	move	$7,$6
	sw	$31,32($sp)
	sh	$0,24($sp)
	sh	$0,26($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$2,20($sp)
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

	.end	FETextRender_WordWrapHeight__FsPc
	.align	2
	.globl	FETextRender_Title__Fs
	.ent	FETextRender_Title__Fs
FETextRender_Title__Fs:
	.frame	$sp,128,$31		# vars= 88, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	subu	$sp,$sp,128
	sw	$16,112($sp)
	sw	$31,120($sp)
	sw	$17,116($sp)
	lbu	$2,556($2)
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L727
	move	$16,$0
	.set	macro
	.set	reorder

	li	$16,105			# 0x00000069
$L727:
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,48			# 0x00000030
	ori	$6,$16,0x0010
	move	$7,$0
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$2,43			# 0x0000002b
	sh	$2,104($sp)
	addu	$2,$16,18
	.set	noreorder
	.set	nomacro
	jal	textpixels
	sh	$2,106($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$2,$2,10
	sll	$7,$2,16
	lh	$5,104($sp)
	lh	$6,106($sp)
	sra	$7,$7,16
	sh	$2,108($sp)
	li	$2,12			# 0x0000000c
	sh	$2,110($sp)
	li	$2,12			# 0x0000000c
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
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

	lw	$31,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	FETextRender_Title__Fs
	.align	2
	.globl	FETextRender_SetABR__Fib
	.ent	FETextRender_SetABR__Fib
FETextRender_SetABR__Fib:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(gSemiTransText) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_SetABR__Fi
	sw	$5,%lo(gSemiTransText)($2)
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

	.end	FETextRender_SetABR__Fib
