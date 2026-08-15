	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\femenuextended.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	MenuNFS4_SetHelpPos__FR4RECT
	.ent	MenuNFS4_SetHelpPos__FR4RECT
MenuNFS4_SetHelpPos__FR4RECT:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,0($4)
	lui	$3,%hi(gHelpPos) # high
	sh	$2,%lo(gHelpPos)($3)
	lhu	$2,2($4)
	addiu	$3,$3,%lo(gHelpPos) # low
	sh	$2,2($3)
	lhu	$2,4($4)
	#nop
	sh	$2,4($3)
	lhu	$2,6($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,6($3)
	.set	macro
	.set	reorder

	.end	MenuNFS4_SetHelpPos__FR4RECT
	.rdata
	.align	2
$LC0:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	.ent	MenuNFS4_DrawTextBox__FiR4RECTissbT5
MenuNFS4_DrawTextBox__FiR4RECTissbT5:
	.frame	$sp,168,$31		# vars= 96, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	sw	$17,132($sp)
	move	$17,$4
	sw	$19,140($sp)
	move	$19,$5
	lui	$2,%hi(Draw_gPlayer1View) # high
	lw	$4,%lo(Draw_gPlayer1View)($2)
	lui	$2,%hi(gFlip) # high
	lw	$5,%lo(gFlip)($2)
	sw	$16,128($sp)
	lw	$16,184($sp)
	sw	$23,156($sp)
	lw	$23,192($sp)
	sw	$21,148($sp)
	move	$21,$6
	sw	$22,152($sp)
	move	$22,$7
	sw	$31,164($sp)
	sw	$fp,160($sp)
	sw	$20,144($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	sw	$18,136($sp)
	.set	macro
	.set	reorder

	li	$4,11862016			# 0x00b50000
	ori	$4,$4,0x4200
	li	$5,48830			# 0x0000bebe
	sll	$16,$16,16
	sra	$18,$16,16
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$fp,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L602
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$2
	lh	$2,2($19)
	li	$6,224			# 0x000000e0
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	subu	$6,$6,$2
	.set	macro
	.set	reorder

	sw	$2,44($sp)
$L602:
	.set	noreorder
	.set	nomacro
	jal	DrawShape_SubtractNFS4RectEdges__FR4RECT
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$17,$L603
	li	$9,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	lw	$4,0($9)
	addu	$5,$sp,32
	sh	$0,32($sp)
	lhu	$3,2($fp)
	li	$2,512			# 0x00000200
	sh	$2,36($sp)
	li	$2,240			# 0x000000f0
	lw	$6,528482304
	li	$8,-16777216			# 0xff000000
	sh	$2,38($sp)
	sh	$3,34($sp)
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

	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$sp,64
	move	$4,$16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	s_upper__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$20,$16,$2
	slt	$2,$20,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	move	$3,$20
	.set	macro
	.set	reorder

	move	$3,$21
$L604:
	li	$4,1			# 0x00000001
	move	$5,$18
	move	$6,$0
	.set	noreorder
	.set	nomacro
	.set	noreorder
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	addu	$21,$3,25
	.set	reorder
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L605
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$16
	lh	$2,2($19)
	li	$6,240			# 0x000000f0
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	subu	$6,$6,$2
	.set	macro
	.set	reorder

	move	$16,$2
$L605:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$2
	lhu	$5,0($19)
	lhu	$6,2($19)
	move	$7,$16
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$5,$5,$22
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,4
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$2
	lhu	$5,0($19)
	lhu	$6,2($19)
	move	$7,$16
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$5,$5,$22
	subu	$5,$5,$21
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,4
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lw	$10,188($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L608
	li	$9,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lhu	$2,6($19)
	lh	$3,2($19)
	sll	$2,$2,16
	sra	$2,$2,17
	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L607
	addu	$18,$3,$2
	.set	macro
	.set	reorder

	addu	$18,$18,2
$L607:
	li	$4,10			# 0x0000000a
	li	$5,280			# 0x00000118
	move	$7,$18
	addu	$17,$sp,40
	sll	$16,$22,16
	lh	$6,0($19)
	sra	$16,$16,16
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$16
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$6,$6,-10
	.set	macro
	.set	reorder

	li	$4,11			# 0x0000000b
	li	$5,280			# 0x00000118
	lh	$6,0($19)
	move	$7,$18
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$16
	addu	$6,$6,$20
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$6,$6,8
	.set	macro
	.set	reorder

	li	$4,10			# 0x0000000a
	li	$5,280			# 0x00000118
	lh	$6,0($19)
	move	$7,$18
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$16
	subu	$6,$6,$21
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$6,$6,-10
	.set	macro
	.set	reorder

	li	$4,11			# 0x0000000b
	li	$5,280			# 0x00000118
	lh	$6,0($19)
	move	$7,$18
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	addu	$6,$6,$16
	subu	$6,$6,$21
	addu	$6,$6,$20
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$6,$6,8
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
$L608:
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	addu	$5,$sp,32
	lw	$4,0($9)
	li	$8,-16777216			# 0xff000000
	lwl	$11,3($19)
	lwr	$11,0($19)
	lwl	$12,7($19)
	lwr	$12,4($19)
	swl	$11,35($sp)
	swr	$11,32($sp)
	swl	$12,39($sp)
	swr	$12,36($sp)
	lhu	$2,34($sp)
	lhu	$3,2($fp)
	lw	$6,528482304
	addu	$2,$2,$3
	sh	$2,34($sp)
	lhu	$2,32($sp)
	lhu	$3,36($sp)
	addu	$2,$2,2
	addu	$3,$3,-4
	sh	$2,32($sp)
	sh	$3,36($sp)
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

$L603:
	li	$4,30			# 0x0000001e
	li	$5,8			# 0x00000008
	lui	$3,%hi(gHelpShapes) # high
	lwl	$11,3($19)
	lwr	$11,0($19)
	lwl	$12,7($19)
	lwr	$12,4($19)
	swl	$11,35($sp)
	swr	$11,32($sp)
	swl	$12,39($sp)
	swr	$12,36($sp)
	lhu	$2,34($sp)
	lw	$16,%lo(gHelpShapes)($3)
	lhu	$3,36($sp)
	addu	$2,$2,1
	sll	$7,$2,16
	sra	$7,$7,16
	sh	$2,34($sp)
	lhu	$2,38($sp)
	addu	$16,$16,960
	addu	$2,$2,-2
	sh	$2,38($sp)
	lhu	$2,16($16)
	addu	$3,$3,-1
	sll	$2,$2,16
	sra	$2,$2,17
	subu	$3,$3,$2
	sll	$6,$3,16
	lh	$2,32($sp)
	sra	$6,$6,16
	sh	$3,36($sp)
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	lh	$5,32($sp)
	lh	$6,34($sp)
	lh	$7,36($sp)
	lh	$2,18($16)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,164($sp)
	lw	$fp,160($sp)
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

	.end	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	.align	2
	.globl	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	.ent	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	lw	$18,48($sp)
	sw	$16,16($sp)
	sw	$17,20($sp)
	lw	$17,52($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemGoToMenuNFS4Button_vtable) # high
	addiu	$3,$3,%lo(tMenuItemGoToMenuNFS4Button_vtable) # low
	sw	$3,24($2)
	li	$3,14			# 0x0000000e
	sh	$3,36($2)
	sh	$0,38($2)
	sh	$0,40($2)
	sh	$0,42($2)
	sw	$17,16($2)
	sw	$18,12($2)
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

	.end	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	.align	2
	.globl	_._27tMenuItemGoToMenuNFS4Button
	.ent	_._27tMenuItemGoToMenuNFS4Button
_._27tMenuItemGoToMenuNFS4Button:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemGoToMenuNFS4Button_vtable) # high
	addiu	$2,$2,%lo(tMenuItemGoToMenuNFS4Button_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._23tMenuItemGoToMenuButton
	sw	$2,24($4)
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

	.end	_._27tMenuItemGoToMenuNFS4Button
	.align	2
	.globl	Draw__27tMenuItemGoToMenuNFS4Buttoniib
	.ent	Draw__27tMenuItemGoToMenuNFS4Buttoniib
Draw__27tMenuItemGoToMenuNFS4Buttoniib:
	.frame	$sp,128,$31		# vars= 72, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$17,108($sp)
	move	$17,$4
	sw	$19,116($sp)
	move	$19,$5
	sw	$20,120($sp)
	move	$20,$6
	sw	$18,112($sp)
	move	$18,$7
	sw	$31,124($sp)
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L614
	sw	$16,104($sp)
	.set	macro
	.set	reorder

	lh	$2,36($17)
	#nop
	addu	$2,$2,-14
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

$L614:
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$4,4($17)
	jal	TextSys_Word__Fi
	addu	$16,$sp,40
	move	$4,$16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	s_upper__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sll	$2,$16,16
	sra	$2,$2,16
	slt	$2,$2,140
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L617
	li	$4,165			# 0x000000a5
	.set	macro
	.set	reorder

	addu	$4,$16,25
$L617:
	lhu	$3,36($17)
	#nop
	addu	$2,$3,-2
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L618
	sh	$2,36($17)
	.set	macro
	.set	reorder

	addu	$2,$3,-4
	sh	$2,36($17)
$L618:
	lh	$2,36($17)
	lhu	$3,36($17)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L615
	addu	$2,$3,$4
	.set	macro
	.set	reorder

$L632:
	sh	$2,36($17)
$L615:
	lw	$2,0($17)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L620
	lhu	$2,42($17)
	.set	noreorder
	.set	nomacro
	j	$L633
	addu	$2,$2,12
	.set	macro
	.set	reorder

$L620:
	lhu	$2,42($17)
	#nop
	addu	$2,$2,-12
$L633:
	sh	$2,42($17)
	lh	$2,42($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L622
	slt	$2,$2,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L623
	sh	$0,42($17)
	.set	macro
	.set	reorder

$L622:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	sh	$2,42($17)
$L623:
	li	$2,115			# 0x00000073
$L634:
	li	$18,11			# 0x0000000b
	sh	$19,32($sp)
	sh	$20,34($sp)
	sh	$2,36($sp)
	sh	$18,38($sp)
	lh	$3,38($17)
	lh	$2,42($17)
	lhu	$4,38($17)
	slt	$2,$2,$3
	lhu	$3,42($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	li	$16,115			# 0x00000073
	.set	macro
	.set	reorder

	move	$4,$3
$L635:
	sll	$2,$4,16
	sra	$2,$2,16
	mult	$2,$16
	mflo	$2
	#nop
	#nop
	bgez	$2,$L627
	addu	$2,$2,127
$L627:
	sra	$2,$2,7
	sh	$2,36($sp)
	lh	$7,36($17)
	lh	$2,8($17)
	addu	$5,$sp,32
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$2,16($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	li	$6,140			# 0x0000008c
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	lui	$4,%hi(FontUpsideDownBlit__FiiPviiP12charactertbli) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_SetBlitter__FPFiiPviiP12charactertbli_v
	addiu	$4,$4,%lo(FontUpsideDownBlit__FiiPviiP12charactertbli) # low
	.set	macro
	.set	reorder

	li	$2,280			# 0x00000118
	subu	$2,$2,$20
	sh	$19,32($sp)
	sh	$2,34($sp)
	sh	$16,36($sp)
	sh	$18,38($sp)
	lh	$3,38($17)
	lh	$2,42($17)
	lhu	$4,38($17)
	slt	$2,$2,$3
	lhu	$3,42($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	sll	$2,$4,16
	.set	macro
	.set	reorder

	move	$4,$3
	sll	$2,$4,16
$L636:
	sra	$2,$2,16
	mult	$2,$16
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L637
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	addu	$2,$2,127
$L637:
	sra	$2,$2,7
	sh	$2,36($sp)
	lh	$7,36($17)
	lh	$3,8($17)
	li	$2,1			# 0x00000001
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$3,16($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	li	$6,140			# 0x0000008c
	.set	macro
	.set	reorder

	jal	Font_ReSetBlitter__Fv
$L613:
	lw	$31,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	Draw__27tMenuItemGoToMenuNFS4Buttoniib
	.align	2
	.globl	TransitionOn__27tMenuItemGoToMenuNFS4Button
	.ent	TransitionOn__27tMenuItemGoToMenuNFS4Button
TransitionOn__27tMenuItemGoToMenuNFS4Button:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,12			# 0x0000000c
	sh	$0,42($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,40($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__27tMenuItemGoToMenuNFS4Button
	.align	2
	.globl	TransitionOff__27tMenuItemGoToMenuNFS4Button
	.ent	TransitionOff__27tMenuItemGoToMenuNFS4Button
TransitionOff__27tMenuItemGoToMenuNFS4Button:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-12			# 0xfffffff4
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,40($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__27tMenuItemGoToMenuNFS4Button
	.align	2
	.globl	TransitionIsFinished__27tMenuItemGoToMenuNFS4Button
	.ent	TransitionIsFinished__27tMenuItemGoToMenuNFS4Button
TransitionIsFinished__27tMenuItemGoToMenuNFS4Button:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,40($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__27tMenuItemGoToMenuNFS4Button
	.align	2
	.globl	UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb
	.ent	UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb
UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lhu	$2,38($4)
	lhu	$3,40($4)
	#nop
	addu	$2,$2,$3
	sh	$2,38($4)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L642
	slt	$2,$2,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L643
	sh	$0,38($4)
	.set	macro
	.set	reorder

$L642:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,38($4)
$L643:
	sh	$0,40($4)
$L645:
	jal	UpdateTransition__9tMenuItemb
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb
	.align	2
	.globl	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	.ent	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$18,24($sp)
	lw	$18,48($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	move	$17,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemNFS4LeftRightChoice_vtable) # high
	addiu	$3,$3,%lo(tMenuItemNFS4LeftRightChoice_vtable) # low
	sw	$3,24($2)
	li	$3,14			# 0x0000000e
	sw	$17,12($2)
	sh	$3,32($2)
	sh	$0,34($2)
	sh	$0,36($2)
	sw	$18,16($2)
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

	.end	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	.align	2
	.globl	_._28tMenuItemNFS4LeftRightChoice
	.ent	_._28tMenuItemNFS4LeftRightChoice
_._28tMenuItemNFS4LeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemNFS4LeftRightChoice_vtable) # high
	addiu	$2,$2,%lo(tMenuItemNFS4LeftRightChoice_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	sw	$2,24($4)
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

	.end	_._28tMenuItemNFS4LeftRightChoice
	.align	2
	.globl	Draw__28tMenuItemNFS4LeftRightChoiceiib
	.ent	Draw__28tMenuItemNFS4LeftRightChoiceiib
Draw__28tMenuItemNFS4LeftRightChoiceiib:
	.frame	$sp,64,$31		# vars= 8, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,40($sp)
	move	$16,$4
	sw	$18,48($sp)
	move	$18,$5
	sw	$19,52($sp)
	move	$19,$6
	sw	$17,44($sp)
	move	$17,$7
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L652
	sw	$31,56($sp)
	.set	macro
	.set	reorder

	lh	$2,32($16)
	#nop
	addu	$2,$2,-14
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$4,4($16)
	jal	TextSys_Word__Fi
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	move	$3,$2
	sll	$2,$3,16
	sra	$2,$2,16
	slt	$2,$2,140
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	li	$4,165			# 0x000000a5
	.set	macro
	.set	reorder

	addu	$4,$3,25
$L654:
	lhu	$3,32($16)
	#nop
	addu	$2,$3,-2
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L655
	sh	$2,32($16)
	.set	macro
	.set	reorder

	addu	$2,$3,-4
	sh	$2,32($16)
$L655:
	lh	$2,32($16)
	lhu	$3,32($16)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L653
	addu	$2,$3,$4
	.set	macro
	.set	reorder

$L671:
	sh	$2,32($16)
$L653:
	lw	$2,0($16)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L657
	lhu	$2,38($16)
	.set	noreorder
	.set	nomacro
	j	$L672
	addu	$2,$2,12
	.set	macro
	.set	reorder

$L657:
	lhu	$2,38($16)
	#nop
	addu	$2,$2,-12
$L672:
	sh	$2,38($16)
	lh	$2,38($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L659
	slt	$2,$2,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L660
	sh	$0,38($16)
	.set	macro
	.set	reorder

$L659:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	sh	$2,38($16)
$L660:
	li	$2,115			# 0x00000073
$L673:
	sh	$2,36($sp)
	li	$2,11			# 0x0000000b
	sh	$18,32($sp)
	sh	$19,34($sp)
	sh	$2,38($sp)
	lh	$3,38($16)
	lh	$2,34($16)
	lhu	$4,38($16)
	slt	$2,$2,$3
	lhu	$3,34($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	sll	$2,$4,16
	.set	macro
	.set	reorder

	move	$4,$3
	sll	$2,$4,16
$L674:
	sra	$2,$2,16
	li	$3,115			# 0x00000073
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L663
	addu	$2,$2,127
$L663:
	sra	$2,$2,7
	sh	$2,36($sp)
	lh	$7,32($16)
	lh	$2,8($16)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L665
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lh	$3,32($16)
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L675
	addu	$5,$sp,32
	.set	macro
	.set	reorder

$L665:
	li	$4,1			# 0x00000001
	addu	$5,$sp,32
$L675:
	sw	$4,20($sp)
	sw	$0,24($sp)
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	li	$6,140			# 0x0000008c
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	lui	$4,%hi(FontUpsideDownBlit__FiiPviiP12charactertbli) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_SetBlitter__FPFiiPviiP12charactertbli_v
	addiu	$4,$4,%lo(FontUpsideDownBlit__FiiPviiP12charactertbli) # low
	.set	macro
	.set	reorder

	li	$2,280			# 0x00000118
	subu	$2,$2,$19
	sh	$2,34($sp)
	li	$2,115			# 0x00000073
	sh	$2,36($sp)
	li	$2,11			# 0x0000000b
	sh	$18,32($sp)
	sh	$2,38($sp)
	lh	$3,34($16)
	lh	$2,38($16)
	lhu	$4,34($16)
	slt	$2,$2,$3
	lhu	$3,38($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L676
	sll	$2,$4,16
	.set	macro
	.set	reorder

	move	$4,$3
	sll	$2,$4,16
$L676:
	sra	$2,$2,16
	li	$3,115			# 0x00000073
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L668
	addu	$2,$2,127
$L668:
	sra	$2,$2,7
	sh	$2,36($sp)
	lh	$7,32($16)
	lh	$2,8($16)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L670
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lh	$3,32($16)
	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L677
	addu	$5,$sp,32
	.set	macro
	.set	reorder

$L670:
	li	$4,1			# 0x00000001
	addu	$5,$sp,32
$L677:
	li	$2,1			# 0x00000001
	sw	$4,20($sp)
	sw	$2,24($sp)
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	MenuNFS4_DrawTextBox__FiR4RECTissbT5
	li	$6,140			# 0x0000008c
	.set	macro
	.set	reorder

	jal	Font_ReSetBlitter__Fv
$L651:
	lw	$31,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Draw__28tMenuItemNFS4LeftRightChoiceiib
	.align	2
	.globl	TransitionOn__28tMenuItemNFS4LeftRightChoice
	.ent	TransitionOn__28tMenuItemNFS4LeftRightChoice
TransitionOn__28tMenuItemNFS4LeftRightChoice:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,12			# 0x0000000c
	sh	$0,38($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,36($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__28tMenuItemNFS4LeftRightChoice
	.align	2
	.globl	TransitionOff__28tMenuItemNFS4LeftRightChoice
	.ent	TransitionOff__28tMenuItemNFS4LeftRightChoice
TransitionOff__28tMenuItemNFS4LeftRightChoice:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-12			# 0xfffffff4
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,36($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__28tMenuItemNFS4LeftRightChoice
	.align	2
	.globl	TransitionIsFinished__28tMenuItemNFS4LeftRightChoice
	.ent	TransitionIsFinished__28tMenuItemNFS4LeftRightChoice
TransitionIsFinished__28tMenuItemNFS4LeftRightChoice:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__28tMenuItemNFS4LeftRightChoice
	.align	2
	.globl	UpdateTransition__28tMenuItemNFS4LeftRightChoiceb
	.ent	UpdateTransition__28tMenuItemNFS4LeftRightChoiceb
UpdateTransition__28tMenuItemNFS4LeftRightChoiceb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lhu	$2,34($4)
	lhu	$3,36($4)
	#nop
	addu	$2,$2,$3
	sh	$2,34($4)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L682
	slt	$2,$2,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L683
	sh	$0,34($4)
	.set	macro
	.set	reorder

$L682:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L685
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,34($4)
$L683:
	sh	$0,36($4)
$L685:
	jal	UpdateTransition__9tMenuItemb
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateTransition__28tMenuItemNFS4LeftRightChoiceb
	.align	2
	.globl	Draw__31tMenuItemOptionsLeftRightChoiceiib
	.ent	Draw__31tMenuItemOptionsLeftRightChoiceiib
Draw__31tMenuItemOptionsLeftRightChoiceiib:
	.frame	$sp,104,$31		# vars= 32, regs= 9/0, args= 32, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$17,68($sp)
	move	$17,$4
	sw	$20,80($sp)
	move	$20,$5
	sw	$21,84($sp)
	move	$21,$6
	sw	$22,88($sp)
	move	$22,$7
	li	$4,6			# 0x00000006
	lui	$2,%hi(gHelpShapes) # high
	lw	$2,%lo(gHelpShapes)($2)
	move	$6,$0
	sw	$31,96($sp)
	sw	$23,92($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$16,64($sp)
	lh	$5,8($17)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	addu	$19,$2,1312
	.set	macro
	.set	reorder

	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$18,$2
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$20,148
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$16,$21,3
	sll	$16,$16,16
	sra	$16,$16,16
	move	$6,$16
	move	$7,$18
	li	$23,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

	lw	$3,28($17)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$2,16
	.set	macro
	.set	reorder

	move	$4,$2
	move	$6,$16
	move	$7,$18
	lhu	$5,16($19)
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	sw	$2,20($sp)
	sll	$5,$5,16
	sra	$5,$5,17
	addu	$5,$5,$20
	addu	$5,$5,217
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$5,$5,16
	.set	macro
	.set	reorder

	li	$4,11862016			# 0x00b50000
	ori	$4,$4,0x4200
	lh	$6,8($17)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	addu	$6,$20,166
	addu	$7,$21,6
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L688
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L689
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L688:
	sw	$23,20($sp)
$L689:
	li	$4,10			# 0x0000000a
	li	$5,280			# 0x00000118
	addu	$2,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lh	$2,16($19)
	addu	$7,$21,6
	sw	$0,16($sp)
	subu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L690
	addu	$6,$2,303
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L691
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L690:
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
$L691:
	li	$4,11			# 0x0000000b
	li	$5,280			# 0x00000118
	addu	$2,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
	addu	$5,$sp,32
	li	$2,297			# 0x00000129
	sll	$6,$22,16
	sh	$20,32($sp)
	sh	$21,34($sp)
	sh	$2,36($sp)
	lhu	$2,18($19)
	sra	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	lw	$31,96($sp)
	lw	$23,92($sp)
	lw	$22,88($sp)
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
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Draw__31tMenuItemOptionsLeftRightChoiceiib
	.align	2
	.globl	TransitionOn__29tMenuItemOptionsTwoItemChoice
	.ent	TransitionOn__29tMenuItemOptionsTwoItemChoice
TransitionOn__29tMenuItemOptionsTwoItemChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,28($16)
	#nop
	lw	$3,12($2)
	#nop
	lh	$4,16($3)
	#nop
	addu	$4,$2,$4
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sltu	$2,$0,$2
	sll	$2,$2,7
	sh	$2,32($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TransitionOn__29tMenuItemOptionsTwoItemChoice
	.align	2
	.globl	Draw__29tMenuItemOptionsTwoItemChoiceiib
	.ent	Draw__29tMenuItemOptionsTwoItemChoiceiib
Draw__29tMenuItemOptionsTwoItemChoiceiib:
	.frame	$sp,104,$31		# vars= 40, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$18,80($sp)
	move	$18,$4
	sw	$20,88($sp)
	move	$20,$5
	sw	$31,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$19,84($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	lw	$2,28($18)
	move	$21,$6
	lw	$6,12($2)
	move	$22,$7
	lh	$4,16($6)
	li	$5,-1			# 0xffffffff
	addu	$4,$2,$4
	lui	$2,%hi(gHelpShapes) # high
	lw	$3,%lo(gHelpShapes)($2)
	lw	$2,20($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$19,$3,1312
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	beq	$2,$0,$L696
	lhu	$2,32($18)
	.set	noreorder
	.set	nomacro
	j	$L709
	addu	$2,$2,64
	.set	macro
	.set	reorder

$L696:
	lhu	$2,32($18)
	#nop
	addu	$2,$2,-64
$L709:
	sh	$2,32($18)
	lh	$3,32($18)
	lhu	$4,32($18)
	.set	noreorder
	.set	nomacro
	blez	$3,$L699
	slt	$2,$3,128
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L701
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

$L699:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L700
	move	$2,$4
	.set	macro
	.set	reorder

	move	$2,$0
$L701:
$L700:
	li	$4,6			# 0x00000006
	lh	$5,8($18)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	sh	$2,32($18)
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	move	$7,$0
	lh	$5,32($18)
	lh	$6,8($18)
	addu	$3,$sp,64
	sw	$3,16($sp)
	addu	$3,$sp,68
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	CalcOnOffFade__F13tMenuTextTypesssRiT4
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$21,3
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$20,148
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$16,$16,16
	sra	$16,$16,16
	move	$6,$16
	move	$7,$17
	li	$17,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$2,28($18)
	#nop
	lw	$2,0($2)
	#nop
	lh	$4,0($2)
	jal	TextSys_Word__Fi
	move	$4,$2
	addu	$5,$20,176
	sll	$5,$5,16
	sra	$5,$5,16
	lw	$7,68($sp)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$2,28($18)
	#nop
	lw	$2,0($2)
	#nop
	lh	$4,2($2)
	jal	TextSys_Word__Fi
	move	$4,$2
	lhu	$5,16($19)
	lw	$7,64($sp)
	move	$6,$16
	sw	$0,16($sp)
	sw	$17,20($sp)
	subu	$5,$20,$5
	addu	$5,$5,294
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$5,$5,16
	.set	macro
	.set	reorder

	li	$4,11862016			# 0x00b50000
	ori	$4,$4,0x4200
	lh	$6,8($18)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	addu	$6,$20,166
	addu	$7,$21,6
	sw	$2,44($sp)
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L704
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L705
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L704:
	sw	$17,20($sp)
$L705:
	li	$4,10			# 0x0000000a
	li	$5,280			# 0x00000118
	addu	$2,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lh	$2,16($19)
	addu	$7,$21,6
	sw	$0,16($sp)
	subu	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L706
	addu	$6,$2,303
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L707
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L706:
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
$L707:
	li	$4,11			# 0x0000000b
	li	$5,280			# 0x00000118
	addu	$2,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
	addu	$5,$sp,32
	li	$2,297			# 0x00000129
	sll	$6,$22,16
	sh	$20,32($sp)
	sh	$21,34($sp)
	sh	$2,36($sp)
	lhu	$2,18($19)
	sra	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	DrawShape_NFS4RoundRectangle__FiR4RECTs
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	lw	$31,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Draw__29tMenuItemOptionsTwoItemChoiceiib
	.align	2
	.globl	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.ent	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$2,64($sp)
	lw	$3,68($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,72
	lui	$2,%hi(tMenuNFS4_vtable) # high
	lw	$5,68($sp)
	addiu	$2,$2,%lo(tMenuNFS4_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$2,104($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.align	2
	.globl	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.ent	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$3,56($sp)
	lw	$4,60($sp)
	lw	$2,64($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$4,20($sp)
	move	$4,$16
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuNFS4_vtable) # high
	addiu	$3,$3,%lo(tMenuNFS4_vtable) # low
	sw	$3,104($2)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.align	2
	.globl	_._9tMenuNFS4
	.ent	_._9tMenuNFS4
_._9tMenuNFS4:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuNFS4_vtable) # high
	addiu	$2,$2,%lo(tMenuNFS4_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._5tMenu
	sw	$2,104($4)
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

	.end	_._9tMenuNFS4
	.align	2
	.globl	Initialize__9tMenuNFS4
	.ent	Initialize__9tMenuNFS4
Initialize__9tMenuNFS4:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__5tMenu
	move	$16,$4
	.set	macro
	.set	reorder

	lbu	$2,8($16)
	lw	$3,16($16)
	sw	$0,108($16)
	sw	$0,112($16)
	sb	$0,120($16)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L717
	sb	$2,119($16)
	.set	macro
	.set	reorder

$L718:
	lbu	$2,120($16)
	#nop
	addu	$2,$2,1
	sb	$2,120($16)
	andi	$2,$2,0x00ff
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	bne	$2,$0,$L718
$L717:
	lw	$2,0($16)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L716
	move	$4,$0
	.set	macro
	.set	reorder

$L725:
	sll	$2,$4,16
	sra	$2,$2,14
	addu	$2,$16,$2
	lw	$3,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L716
	addu	$4,$4,1
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	ori	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	j	$L725
	sw	$2,0($3)
	.set	macro
	.set	reorder

$L716:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__9tMenuNFS4
	.align	2
	.globl	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	TransitionOff__9tMenuNFS4
	.ent	TransitionOff__9tMenuNFS4
TransitionOff__9tMenuNFS4:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L729
	move	$16,$0
	.set	macro
	.set	reorder

$L732:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L732
	move	$16,$3
	.set	macro
	.set	reorder

$L729:
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

	.end	TransitionOff__9tMenuNFS4
	.align	2
	.globl	TransitionOn__9tMenuNFS4
	.ent	TransitionOn__9tMenuNFS4
TransitionOn__9tMenuNFS4:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L734
	move	$16,$0
	.set	macro
	.set	reorder

$L737:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L737
	move	$16,$3
	.set	macro
	.set	reorder

$L734:
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

	.end	TransitionOn__9tMenuNFS4
	.align	2
	.globl	TransitionIsFinished__9tMenuNFS4
	.ent	TransitionIsFinished__9tMenuNFS4
TransitionIsFinished__9tMenuNFS4:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	li	$16,1			# 0x00000001
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$2,16($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	move	$17,$0
	.set	macro
	.set	reorder

$L742:
	sll	$2,$17,16
	sra	$2,$2,14
	addu	$2,$18,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	and	$16,$16,$2
	sltu	$16,$0,$16
	addu	$3,$17,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$18,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L742
	move	$17,$3
	.set	macro
	.set	reorder

$L741:
	move	$2,$16
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

	.end	TransitionIsFinished__9tMenuNFS4
	.align	2
	.globl	UpdateTransition__9tMenuNFS4
	.ent	UpdateTransition__9tMenuNFS4
UpdateTransition__9tMenuNFS4:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L744
	move	$16,$0
	.set	macro
	.set	reorder

$L747:
	sll	$5,$16,16
	sra	$5,$5,16
	sll	$2,$5,2
	addu	$2,$17,$2
	lw	$3,16($2)
	lw	$2,8($17)
	#nop
	xor	$5,$5,$2
	lw	$6,24($3)
	sltu	$5,$5,1
	lh	$4,80($6)
	lw	$2,84($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L747
	move	$16,$3
	.set	macro
	.set	reorder

$L744:
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

	.end	UpdateTransition__9tMenuNFS4
	.align	2
	.globl	DrawItem__9tMenuNFS4i
	.ent	DrawItem__9tMenuNFS4i
DrawItem__9tMenuNFS4i:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$5
	sll	$2,$7,2
	addu	$2,$4,$2
	sll	$6,$7,3
	addu	$6,$6,$7
	sll	$6,$6,1
	li	$5,10			# 0x0000000a
	sw	$31,16($sp)
	lw	$3,16($2)
	lw	$2,8($4)
	addu	$6,$6,43
	xor	$7,$7,$2
	lw	$8,24($3)
	sltu	$7,$7,1
	lh	$4,40($8)
	lw	$2,44($8)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
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

	.end	DrawItem__9tMenuNFS4i
	.align	2
	.globl	Draw__9tMenuNFS4
	.ent	Draw__9tMenuNFS4
Draw__9tMenuNFS4:
	.frame	$sp,72,$31		# vars= 24, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,60($sp)
	move	$17,$4
	sw	$31,64($sp)
	sw	$16,56($sp)
	lh	$4,4($17)
	#nop
	bltz	$4,$L751
	jal	FETextRender_Title__Fs
$L751:
	.set	noreorder
	.set	nomacro
	jal	Initialize__5tMenu
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,8($17)
	#nop
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	lw	$5,12($2)
	lw	$3,16($2)
	bltz	$5,$L752
	.set	noreorder
	.set	nomacro
	blez	$3,$L752
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	#nop
	sra	$2,$2,4
	rem	$4,$2,$3
	li	$7,16			# 0x00000010
	li	$3,13500416			# 0x00ce0000
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	ori	$3,$3,0xc844
	sw	$3,36($sp)
	lbu	$2,556($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	li	$7,121			# 0x00000079
$L753:
	li	$5,1040			# 0x00000410
	addu	$2,$sp,32
	li	$6,16			# 0x00000010
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L752:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	move	$16,$0
	.set	macro
	.set	reorder

$L757:
	sll	$5,$16,16
	lw	$2,104($17)
	sra	$5,$5,16
	lh	$4,88($2)
	lw	$2,92($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L757
	move	$16,$3
	.set	macro
	.set	reorder

$L750:
	lw	$31,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Draw__9tMenuNFS4
	.align	2
	.globl	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.ent	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$2,64($sp)
	lw	$3,68($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,72
	lui	$2,%hi(tMenuNFS4TwoPlayer_vtable) # high
	lw	$5,68($sp)
	addiu	$2,$2,%lo(tMenuNFS4TwoPlayer_vtable) # low
	sw	$2,104($16)
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$0,88($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.align	2
	.globl	_._18tMenuNFS4TwoPlayer
	.ent	_._18tMenuNFS4TwoPlayer
_._18tMenuNFS4TwoPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuNFS4TwoPlayer_vtable) # high
	addiu	$2,$2,%lo(tMenuNFS4TwoPlayer_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	sw	$2,104($4)
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

	.end	_._18tMenuNFS4TwoPlayer
	.align	2
	.globl	DrawItem__18tMenuNFS4TwoPlayeri
	.ent	DrawItem__18tMenuNFS4TwoPlayeri
DrawItem__18tMenuNFS4TwoPlayeri:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	sw	$31,16($sp)
	lbu	$3,556($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L764
	li	$8,43			# 0x0000002b
	.set	macro
	.set	reorder

	li	$8,148			# 0x00000094
$L764:
	sll	$2,$5,2
	addu	$2,$4,$2
	sll	$6,$5,3
	addu	$6,$6,$5
	sll	$6,$6,1
	addu	$6,$8,$6
	lw	$2,16($2)
	lw	$7,8($4)
	lw	$3,24($2)
	xor	$7,$5,$7
	lh	$4,40($3)
	li	$5,10			# 0x0000000a
	addu	$4,$2,$4
	lw	$2,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sltu	$7,$7,1
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

	.end	DrawItem__18tMenuNFS4TwoPlayeri
	.align	2
	.globl	__15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.ent	__15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
__15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$2,64($sp)
	lw	$3,68($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,72
	lui	$2,%hi(tMenuNFS4Bottom_vtable) # high
	lw	$5,68($sp)
	addiu	$2,$2,%lo(tMenuNFS4Bottom_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$2,104($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.align	2
	.globl	_._15tMenuNFS4Bottom
	.ent	_._15tMenuNFS4Bottom
_._15tMenuNFS4Bottom:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuNFS4Bottom_vtable) # high
	addiu	$2,$2,%lo(tMenuNFS4Bottom_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	sw	$2,104($4)
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

	.end	_._15tMenuNFS4Bottom
	.align	2
	.globl	Draw__15tMenuNFS4Bottom
	.ent	Draw__15tMenuNFS4Bottom
Draw__15tMenuNFS4Bottom:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	addu	$4,$sp,16
	li	$2,57			# 0x00000039
	sh	$2,16($sp)
	li	$2,198			# 0x000000c6
	sh	$2,18($sp)
	li	$2,114			# 0x00000072
	sh	$2,20($sp)
	li	$2,11			# 0x0000000b
	sw	$31,32($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	MenuNFS4_SetHelpPos__FR4RECT
	sh	$2,22($sp)
	.set	macro
	.set	reorder

	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L769
	move	$16,$0
	.set	macro
	.set	reorder

$L772:
	sll	$7,$16,16
	sra	$7,$7,16
	sll	$2,$7,2
	addu	$2,$17,$2
	move	$5,$0
	lw	$3,16($2)
	lw	$2,8($17)
	move	$6,$5
	xor	$7,$7,$2
	lw	$8,24($3)
	sltu	$7,$7,1
	lh	$4,40($8)
	lw	$2,44($8)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	move	$16,$3
	.set	macro
	.set	reorder

$L769:
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

	.end	Draw__15tMenuNFS4Bottom
	.align	2
	.globl	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.ent	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$3,56($sp)
	lw	$4,60($sp)
	lw	$2,64($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$4,20($sp)
	move	$4,$16
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuBlank_vtable) # high
	addiu	$3,$3,%lo(tMenuBlank_vtable) # low
	sw	$3,104($2)
	li	$3,1			# 0x00000001
	sw	$3,12($2)
	sh	$0,100($2)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	.align	2
	.globl	_._10tMenuBlank
	.ent	_._10tMenuBlank
_._10tMenuBlank:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuBlank_vtable) # high
	addiu	$2,$2,%lo(tMenuBlank_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	sw	$2,104($4)
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

	.end	_._10tMenuBlank
	.align	2
	.globl	Draw__10tMenuBlank
	.ent	Draw__10tMenuBlank
Draw__10tMenuBlank:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,112($16)
	#nop
	beq	$2,$0,$L778
	lw	$2,104($16)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lbu	$2,118($16)
	lhu	$3,116($16)
	sll	$2,$2,24
	sra	$2,$2,24
	addu	$3,$3,$2
	sh	$3,116($16)
$L778:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw__10tMenuBlank
	.align	2
	.globl	ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($6)
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L782
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	bne	$3,$2,$L781
$L782:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L780
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L781:
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	sw	$0,16($4)
	.set	macro
	.set	reorder

$L780:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Initialize__10tMenuBlank
	.ent	Initialize__10tMenuBlank
Initialize__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Initialize__10tMenuBlank
	.align	2
	.globl	DebounceKeys__10tMenuBlank
	.ent	DebounceKeys__10tMenuBlank
DebounceKeys__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.end	DebounceKeys__10tMenuBlank
	.align	2
	.globl	TransitionOff__10tMenuBlank
	.ent	TransitionOff__10tMenuBlank
TransitionOff__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,8			# 0x00000008
	sb	$2,118($4)
	li	$2,1			# 0x00000001
	sw	$2,112($4)
	li	$2,-112			# 0xffffff90
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,116($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__10tMenuBlank
	.align	2
	.globl	TransitionOn__10tMenuBlank
	.ent	TransitionOn__10tMenuBlank
TransitionOn__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-8			# 0xfffffff8
	sb	$2,118($4)
	li	$2,1			# 0x00000001
	sw	$2,112($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,116($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__10tMenuBlank
	.align	2
	.globl	TransitionIsFinished__10tMenuBlank
	.ent	TransitionIsFinished__10tMenuBlank
TransitionIsFinished__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lb	$2,118($4)
	#nop
	blez	$2,$L789
	lh	$2,116($4)
	.set	noreorder
	.set	nomacro
	j	$L790
	srl	$2,$2,31
	.set	macro
	.set	reorder

$L789:
	lh	$2,116($4)
	#nop
	slt	$2,$2,-111
	xori	$2,$2,0x0001
$L790:
	sw	$2,112($4)
	#.set	volatile
	lw	$2,112($4)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__10tMenuBlank
	.align	2
	.globl	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	.ent	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme:
	.frame	$sp,48,$31		# vars= 0, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$8,64($sp)
	lw	$9,68($sp)
	lw	$2,72($sp)
	sw	$16,32($sp)
	move	$16,$4
	sw	$17,36($sp)
	lw	$17,76($sp)
	lw	$3,80($sp)
	sw	$31,40($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,84
	lui	$2,%hi(tMenuOptions_vtable) # high
	lw	$5,80($sp)
	addiu	$2,$2,%lo(tMenuOptions_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$2,104($16)
	.set	macro
	.set	reorder

	move	$2,$16
	sh	$17,128($2)
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

	.end	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	.align	2
	.globl	_._12tMenuOptions
	.ent	_._12tMenuOptions
_._12tMenuOptions:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuOptions_vtable) # high
	addiu	$2,$2,%lo(tMenuOptions_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	sw	$2,104($4)
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

	.end	_._12tMenuOptions
	.align	2
	.globl	Draw__12tMenuOptions
	.ent	Draw__12tMenuOptions
Draw__12tMenuOptions:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,32($sp)
	move	$18,$4
	sw	$31,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	GetNumberEnabledItems__5tMenu
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$22,320			# 0x00000140
	lw	$3,104($18)
	move	$16,$2
	lh	$4,56($3)
	lw	$3,60($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	sll	$16,$16,16
	sra	$16,$16,16
	sll	$2,$16,3
	addu	$2,$2,$16
	lw	$3,112($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L796
	sll	$21,$2,1
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	lw	$2,124($18)
	#nop
	subu	$3,$3,$2
	sltu	$2,$3,33
	bne	$2,$0,$L797
	lb	$2,118($18)
	li	$3,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	bltz	$2,$L795
	sw	$0,112($18)
	.set	macro
	.set	reorder

$L797:
	lb	$2,118($18)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L799
	mult	$3,$22
	.set	macro
	.set	reorder

	mflo	$9
	#nop
	#nop
	mult	$21,$3
	srl	$22,$9,5
	mflo	$2
	#nop
	.set	noreorder
	.set	nomacro
	j	$L801
	srl	$21,$2,5
	.set	macro
	.set	reorder

$L799:
	mflo	$9
	#nop
	#nop
	mult	$21,$3
	srl	$2,$9,5
	subu	$22,$22,$2
	mflo	$3
	#nop
	#nop
	srl	$2,$3,5
	.set	noreorder
	.set	nomacro
	j	$L801
	subu	$21,$21,$2
	.set	macro
	.set	reorder

$L796:
	lb	$2,118($18)
	#nop
	bltz	$2,$L795
$L801:
	addu	$21,$21,18
	lui	$2,%hi(screenwidth) # high
	li	$3,240			# 0x000000f0
	subu	$3,$3,$21
	sra	$19,$3,1
	lw	$2,%lo(screenwidth)($2)
	lh	$4,128($18)
	subu	$2,$2,$22
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L803
	sra	$20,$2,1
	.set	macro
	.set	reorder

	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L804
	subu	$19,$19,$2
	.set	macro
	.set	reorder

$L803:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L804
	sra	$2,$3,2
	.set	macro
	.set	reorder

	addu	$19,$19,$2
$L804:
	lw	$2,112($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$4,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L807
	sra	$5,$22,1
	.set	macro
	.set	reorder

	addu	$5,$20,$5
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$19,2
	sll	$6,$6,16
	sra	$6,$6,16
	li	$7,2			# 0x00000002
	move	$2,$7
	sw	$2,16($sp)
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L807:
	addu	$17,$19,18
	move	$16,$0
$L810:
	sll	$2,$16,16
	sra	$4,$2,16
	sll	$2,$4,2
	addu	$2,$18,$2
	lw	$3,16($2)
	#nop
	beq	$3,$0,$L806
	lw	$2,0($3)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	addu	$5,$20,10
	.set	macro
	.set	reorder

	move	$6,$17
	addu	$17,$17,18
	lw	$7,8($18)
	lw	$2,24($3)
	xor	$7,$4,$7
	sltu	$7,$7,1
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L812:
	.set	noreorder
	.set	nomacro
	j	$L810
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L806:
	move	$4,$0
$L814:
	move	$5,$20
	move	$6,$19
	move	$7,$22
	li	$2,12			# 0x0000000c
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$20
	addu	$6,$19,$21
	move	$7,$22
	li	$2,-2			# 0xfffffffe
	li	$16,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$20
	addu	$18,$19,12
	move	$6,$18
	li	$7,4			# 0x00000004
	addu	$17,$21,-14
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$5,$20,$22
	move	$6,$18
	li	$7,-4			# 0xfffffffc
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$20
	move	$6,$19
	move	$7,$22
	sw	$21,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$16,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

$L795:
	lw	$31,52($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Draw__12tMenuOptions
	.align	2
	.globl	TransitionOff__12tMenuOptions
	.ent	TransitionOff__12tMenuOptions
TransitionOff__12tMenuOptions:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,-1			# 0xffffffff
	sw	$31,16($sp)
	sb	$2,118($4)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,112($4)
	sw	$3,124($4)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,18			# 0x00000012
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

	.end	TransitionOff__12tMenuOptions
	.align	2
	.globl	TransitionOn__12tMenuOptions
	.ent	TransitionOn__12tMenuOptions
TransitionOn__12tMenuOptions:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$17
	sw	$31,24($sp)
$L817:
	lw	$3,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L819
	li	$4,15			# 0x0000000f
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L820
	lw	$2,24($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L820:
	.set	noreorder
	.set	nomacro
	j	$L817
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L819:
	li	$2,1			# 0x00000001
	sb	$2,118($17)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,112($17)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$3,124($17)
	.set	macro
	.set	reorder

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

	.end	TransitionOn__12tMenuOptions
	.align	2
	.globl	TransitionIsFinished__12tMenuOptions
	.ent	TransitionIsFinished__12tMenuOptions
TransitionIsFinished__12tMenuOptions:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,124($4)
	#nop
	subu	$2,$2,$3
	sltu	$2,$2,32
	sw	$2,112($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__12tMenuOptions
	.align	2
	.globl	ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($6)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L825
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,0($6)
$L825:
	jal	ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	IsSubMenu__12tMenuOptions
	.ent	IsSubMenu__12tMenuOptions
IsSubMenu__12tMenuOptions:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	IsSubMenu__12tMenuOptions
	.align	2
	.globl	UpdateTransition__10tMenuBlank
	.ent	UpdateTransition__10tMenuBlank
UpdateTransition__10tMenuBlank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	UpdateTransition__10tMenuBlank
	.align	2
	.globl	___29tMenuItemOptionsTwoItemChoice
	.ent	___29tMenuItemOptionsTwoItemChoice
___29tMenuItemOptionsTwoItemChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___29tMenuItemOptionsTwoItemChoice
	.align	2
	.globl	___31tMenuItemOptionsLeftRightChoice
	.ent	___31tMenuItemOptionsLeftRightChoice
___31tMenuItemOptionsLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___31tMenuItemOptionsLeftRightChoice
	.align	2
	.globl	Draw__27tMenuItemGoToMenuNFS4Buttonb
	.ent	Draw__27tMenuItemGoToMenuNFS4Buttonb
Draw__27tMenuItemGoToMenuNFS4Buttonb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Draw__27tMenuItemGoToMenuNFS4Buttonb
	.globl	gHelpPos
	.data
	.align	2
gHelpPos:
	.space	8
