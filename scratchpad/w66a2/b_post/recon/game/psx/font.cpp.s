	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\font.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	font_clutx
	.sdata
	.align	2
font_clutx:
	.word	-1
	.globl	font_cluty
	.align	2
font_cluty:
	.word	-1
	.globl	font_tint
	.align	2
font_tint:
	.word	1719697536
	.text
	.align	2
	.globl	Font_TextColor__Fi
	.align	2
	.globl	Font_TextTint__Fi
	.align	2
	.globl	Font_SetABR__Fi
	.align	2
	.globl	Font_Blit__FiiPviiP12charactertbli
	.align	2
	.globl	Font_ComputeColors__Fiiic
	.align	2
	.globl	Font_textbsearch__FiPcUlUl
	.align	2
	.globl	Font_Getcharacter__Fi
	.align	2
	.globl	Font_SetBlitter__FPFiiPviiP12charactertbli_v
	.align	2
	.globl	Font_ReSetBlitter__Fv
	.align	2
	.globl	Font_SwitchFont__FPc
	.align	2
	.globl	Font_DeInit__Fv
	.align	2
	.globl	Font_ExitFromGame__Fv
	.align	2
	.globl	Font_LoadFont__FPciic
	.align	2
	.globl	Font_TextXY__FPcii
	.align	2
	.globl	Font_GetUVWH__FcPiN41
	.globl	font_abr
	.sdata
	.align	2
font_abr:
	.space	4
	.globl	gFontClut
	.align	1
gFontClut:
	.space	2
	.globl	gFontSpaceWidth
gFontSpaceWidth:
	.space	1
	.globl	font_currentTPage
	.align	1
font_currentTPage:
	.space	2
	.globl	gCurrentBlitter
	.align	2
gCurrentBlitter:
	.space	4

	.extern	colourRGB, 64
	.extern	currentfont, 160
	.extern	shpfontclut, 48

	.text
	.text
	.ent	Font_TextColor__Fi
Font_TextColor__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$5,%hi(shpfontclut) # high
	addiu	$5,$5,%lo(shpfontclut) # low
	sll	$4,$4,4
	lhu	$2,font_clutx
	lhu	$3,14($5)
	addu	$2,$2,$4
	sll	$3,$3,6
	sh	$2,12($5)
	srl	$2,$2,4
	andi	$2,$2,0x003f
	or	$3,$3,$2
	sh	$3,gFontClut
	j	$31
	.end	Font_TextColor__Fi
	.text
	.ent	Font_TextTint__Fi
Font_TextTint__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,16711680			# 0x00ff0000
	ori	$2,$2,0xffff
	and	$4,$4,$2
	li	$2,1711276032			# 0x66000000
	or	$4,$4,$2
	sw	$4,font_tint
	j	$31
	.end	Font_TextTint__Fi
	.text
	.ent	Font_SetABR__Fi
Font_SetABR__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(currentfont+136) # high
	lw	$2,%lo(currentfont+136)($2)
	move	$5,$4
	sw	$31,16($sp)
	sw	$5,font_abr
	lw	$6,12($2)
	lbu	$4,0($2)
	sll	$7,$6,4
	sll	$6,$6,20
	andi	$4,$4,0x0003
	sra	$6,$6,20
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sra	$7,$7,20
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sh	$2,font_currentTPage
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Font_SetABR__Fi
	.text
	.ent	Font_Blit__FiiPviiP12charactertbli
Font_Blit__FiiPviiP12charactertbli:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$13,528482304			# 0x1f800000
	ori	$13,$13,0x0004
	li	$10,16711680			# 0x00ff0000
	ori	$10,$10,0xffff
	li	$12,-16777216			# 0xff000000
	sll	$5,$5,16
	or	$5,$5,$4
	sw	$31,16($sp)
	lw	$9,0($13)
	lw	$11,528482304
	lw	$6,12($6)
	lw	$8,44($sp)
	sll	$6,$6,4
	sra	$6,$6,20
	move	$4,$9
	lw	$3,0($9)
	lw	$2,0($11)
	lbu	$15,2($8)
	lbu	$8,3($8)
	and	$3,$3,$12
	and	$2,$2,$10
	or	$3,$3,$2
	sw	$3,0($9)
	addu	$3,$9,20
	and	$10,$9,$10
	sll	$8,$8,16
	lw	$14,40($sp)
	lw	$2,0($11)
	or	$8,$8,$15
	sw	$3,0($13)
	and	$2,$2,$12
	or	$2,$2,$10
	sw	$2,0($11)
	li	$2,4			# 0x00000004
	addu	$6,$6,$14
	andi	$6,$6,0x00ff
	sb	$2,3($9)
	lw	$2,font_tint
	sll	$6,$6,8
	sw	$5,8($9)
	sw	$2,4($9)
	lhu	$2,gFontClut
	li	$5,1			# 0x00000001
	sw	$8,16($9)
	sll	$2,$2,16
	or	$2,$2,$6
	or	$2,$2,$7
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	sw	$2,12($9)
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

	.end	Font_Blit__FiiPviiP12charactertbli
	.text
	.ent	Font_ComputeColors__Fiiic
Font_ComputeColors__Fiiic:
	.frame	$sp,88,$31		# vars= 24, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$20,64($sp)
	move	$20,$4
	sw	$22,72($sp)
	move	$22,$7
	li	$2,-16777216			# 0xff000000
	sw	$21,68($sp)
	and	$21,$5,$2
	li	$9,-2139095040			# 0x80800000
	ori	$9,$9,0x8081
	move	$10,$0
	li	$25,-1995374592			# 0x89110000
	sw	$5,24($sp)
	lbu	$2,24($sp)
	lbu	$4,26($sp)
	lui	$8,%hi(shpfontclut) # high
	sw	$31,80($sp)
	sw	$23,76($sp)
	sll	$5,$2,5
	subu	$5,$5,$2
	mult	$5,$9
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	addiu	$2,$8,%lo(shpfontclut) # low
	move	$15,$2
	li	$2,35			# 0x00000023
	sb	$2,%lo(shpfontclut)($8)
	li	$2,16			# 0x00000010
	sll	$3,$4,5
	subu	$3,$3,$4
	mfhi	$12
	#nop
	sh	$2,4($15)
	lbu	$7,25($sp)
	mult	$3,$9
	li	$2,1			# 0x00000001
	sh	$2,6($15)
	sh	$0,8($15)
	sh	$0,10($15)
	lbu	$2,%lo(shpfontclut)($8)
	ori	$25,$25,0x9a23
	sw	$6,32($sp)
	lhu	$6,font_clutx
	sll	$4,$7,5
	subu	$4,$4,$7
	lhu	$7,font_cluty
	mfhi	$11
	#nop
	li	$17,15			# 0x0000000f
	sw	$2,%lo(shpfontclut)($8)
	mult	$4,$9
	sh	$6,12($15)
	sh	$7,14($15)
	addu	$2,$11,$3
	sra	$2,$2,7
	sra	$3,$3,31
	subu	$16,$2,$3
	addu	$3,$12,$5
	sra	$3,$3,7
	sra	$5,$5,31
	subu	$3,$3,$5
	sll	$3,$3,10
	mfhi	$9
	#nop
	#nop
	addu	$2,$9,$4
	sra	$2,$2,7
	sra	$4,$4,31
	subu	$2,$2,$4
	sll	$2,$2,5
	ori	$4,$2,0x8000
	or	$19,$3,$4
	or	$18,$3,$2
$L608:
	andi	$2,$22,0x00ff
	beq	$2,$0,$L609
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L609
	slt	$2,$10,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L615
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$2,$10,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L615
	or	$2,$19,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L618
	or	$2,$18,$16
	.set	macro
	.set	reorder

$L609:
	lbu	$2,24($sp)
	#nop
	mult	$2,$10
	mflo	$2
	#nop
	lbu	$3,25($sp)
	#nop
	mult	$3,$10
	mflo	$3
	#nop
	sll	$5,$2,5
	subu	$5,$5,$2
	mult	$5,$25
	mfhi	$12
	#nop
	sll	$7,$3,5
	subu	$7,$7,$3
	mult	$7,$25
	mfhi	$13
	#nop
	lbu	$2,26($sp)
	#nop
	mult	$2,$10
	mflo	$2
	#nop
	lbu	$3,32($sp)
	subu	$4,$17,$10
	mult	$3,$4
	mflo	$3
	#nop
	sll	$6,$2,5
	subu	$6,$6,$2
	mult	$6,$25
	mfhi	$23
	#nop
	sll	$8,$3,5
	subu	$8,$8,$3
	mult	$8,$25
	mfhi	$14
	#nop
	lbu	$2,33($sp)
	#nop
	mult	$2,$4
	mflo	$2
	#nop
	lbu	$9,34($sp)
	#nop
	mult	$9,$4
	mflo	$9
	#nop
	sll	$4,$2,5
	subu	$4,$4,$2
	mult	$4,$25
	addu	$2,$12,$5
	sra	$2,$2,11
	sra	$5,$5,31
	subu	$24,$2,$5
	addu	$2,$13,$7
	sra	$2,$2,11
	sra	$7,$7,31
	subu	$12,$2,$7
	addu	$2,$23,$6
	mfhi	$11
	#nop
	sll	$3,$9,5
	subu	$3,$3,$9
	mult	$3,$25
	sra	$2,$2,11
	sra	$6,$6,31
	subu	$7,$2,$6
	addu	$2,$14,$8
	sra	$2,$2,11
	sra	$8,$8,31
	subu	$6,$2,$8
	addu	$2,$11,$4
	sra	$2,$2,11
	sra	$4,$4,31
	subu	$5,$2,$4
	mfhi	$9
	#nop
	#nop
	addu	$2,$9,$3
	sra	$2,$2,11
	sra	$3,$3,31
	subu	$4,$2,$3
	slt	$2,$10,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	sw	$23,40($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L615
	move	$2,$0
	.set	macro
	.set	reorder

$L616:
	addu	$2,$24,$6
	addu	$3,$12,$5
	addu	$4,$7,$4
	sll	$2,$2,10
	sll	$3,$3,5
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$20,$17,$L618
	or	$2,$2,$4
	.set	macro
	.set	reorder

	ori	$2,$2,0x8000
$L618:
	bne	$2,$0,$L615
	li	$2,1024			# 0x00000400
$L615:
	sh	$2,16($15)
	addu	$10,$10,1
	slt	$2,$10,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	addu	$15,$15,2
	.set	macro
	.set	reorder

	lui	$4,%hi(shpfontclut) # high
	addiu	$4,$4,%lo(shpfontclut) # low
	sll	$7,$20,4
	lw	$5,font_clutx
	lw	$6,font_cluty
	addu	$7,$5,$7
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramf__FP8shapetbliiii
	sw	$6,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,80($sp)
	lw	$23,76($sp)
	lw	$22,72($sp)
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
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Font_ComputeColors__Fiiic
	.text
	.ent	Font_textbsearch__FiPcUlUl
Font_textbsearch__FiPcUlUl:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$19,28($sp)
	move	$19,$7
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L624
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	sra	$2,$17,1
$L631:
	mult	$2,$19
	li	$5,2			# 0x00000002
	mflo	$3
	#nop
	#nop
	addu	$16,$18,$3
	.set	noreorder
	.set	nomacro
	jal	geti
	move	$4,$16
	.set	macro
	.set	reorder

	subu	$2,$20,$2
	bne	$2,$0,$L627
	.set	noreorder
	.set	nomacro
	j	$L630
	move	$2,$16
	.set	macro
	.set	reorder

$L627:
	blez	$2,$L625
	addu	$18,$16,$19
	addu	$17,$17,-1
$L625:
	sra	$17,$17,1
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L631
	sra	$2,$17,1
	.set	macro
	.set	reorder

$L624:
	move	$2,$0
$L630:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	Font_textbsearch__FiPcUlUl
	.text
	.ent	Font_Getcharacter__Fi
Font_Getcharacter__Fi:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	li	$5,2			# 0x00000002
	lui	$2,%hi(currentfont) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(currentfont) # low
	addu	$3,$17,-32
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$18,132($19)
	subu	$2,$2,$3
	addu	$16,$18,$2
	.set	noreorder
	.set	nomacro
	jal	geti
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$17,$L633
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$18
	lw	$6,116($19)
	.set	noreorder
	.set	nomacro
	jal	Font_textbsearch__FiPcUlUl
	li	$7,11			# 0x0000000b
	.set	macro
	.set	reorder

	j	$L634
$L633:
	move	$2,$16
$L634:
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

	.end	Font_Getcharacter__Fi
	.text
	.ent	Font_SetBlitter__FPFiiPviiP12charactertbli_v
Font_SetBlitter__FPFiiPviiP12charactertbli_v:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,gCurrentBlitter
	j	$31
	.end	Font_SetBlitter__FPFiiPviiP12charactertbli_v
	.text
	.ent	Font_ReSetBlitter__Fv
Font_ReSetBlitter__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Font_Blit__FiiPviiP12charactertbli) # high
	addiu	$2,$2,%lo(Font_Blit__FiiPviiP12charactertbli) # low
	sw	$2,gCurrentBlitter
	j	$31
	.end	Font_ReSetBlitter__Fv
	.text
	.ent	Font_SwitchFont__FPc
Font_SwitchFont__FPc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	setfont
	lui	$2,%hi(currentfont) # high
	addiu	$2,$2,%lo(currentfont) # low
	lw	$3,136($2)
	lw	$5,font_abr
	sw	$0,148($2)
	sw	$0,152($2)
	sw	$0,156($2)
	lbu	$4,0($3)
	lw	$6,12($3)
	andi	$4,$4,0x0003
	sll	$7,$6,4
	sll	$6,$6,20
	sra	$6,$6,20
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sra	$7,$7,20
	.set	macro
	.set	reorder

	sh	$2,font_currentTPage
	.set	noreorder
	.set	nomacro
	jal	Font_Getcharacter__Fi
	li	$4,32			# 0x00000020
	.set	macro
	.set	reorder

	lbu	$2,8($2)
	lw	$31,16($sp)
	sb	$2,gFontSpaceWidth
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Font_SwitchFont__FPc
	.text
	.ent	Font_DeInit__Fv
Font_DeInit__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,font_clutx
	subu	$sp,$sp,24
	sw	$16,16($sp)
	li	$16,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L639
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lhu	$4,font_cluty
	sra	$2,$2,4
	andi	$2,$2,0x003f
	sll	$4,$4,6
	or	$4,$4,$2
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sra	$4,$4,16
	.set	macro
	.set	reorder

$L639:
	lw	$31,20($sp)
	sw	$16,font_clutx
	sw	$16,font_cluty
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Font_DeInit__Fv
	.text
	.ent	Font_ExitFromGame__Fv
Font_ExitFromGame__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	sw	$2,font_clutx
	sw	$2,font_cluty
	j	$31
	.end	Font_ExitFromGame__Fv
	.text
	.ent	Font_LoadFont__FPciic
Font_LoadFont__FPciic:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,36($sp)
	move	$19,$4
	sw	$21,44($sp)
	move	$21,$5
	sw	$22,48($sp)
	move	$22,$6
	sw	$20,40($sp)
	move	$20,$7
	sw	$31,52($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	setfont
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(currentfont+136) # high
	lw	$18,%lo(currentfont+136)($2)
	#nop
	lh	$2,4($18)
	lh	$3,6($18)
	#nop
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$17,$2,1
	.set	noreorder
	.set	nomacro
	blez	$17,$L643
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$18
$L658:
	lbu	$3,16($4)
	addu	$16,$16,1
	andi	$2,$3,0x000f
	sll	$2,$2,4
	srl	$3,$3,4
	or	$2,$2,$3
	sb	$2,16($4)
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	addu	$4,$16,$18
	.set	macro
	.set	reorder

$L643:
	lw	$3,font_clutx
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L659
	move	$4,$18
	.set	macro
	.set	reorder

	la	$5,font_clutx
	la	$6,font_cluty
	.set	noreorder
	.set	nomacro
	jal	Texture_GetClutId__FiPiT1
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$18
$L659:
	move	$5,$21
	move	$6,$22
	lw	$7,font_clutx
	lw	$2,font_cluty
	move	$16,$0
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramf__FP8shapetbliiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	jal	waitdraw
	lui	$2,%hi(shpfontclut) # high
	addiu	$2,$2,%lo(shpfontclut) # low
	subu	$2,$2,$18
	lbu	$3,0($18)
	sll	$2,$2,8
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	blez	$17,$L649
	sw	$3,0($18)
	.set	macro
	.set	reorder

	addu	$4,$16,$18
$L660:
	lbu	$3,16($4)
	addu	$16,$16,1
	andi	$2,$3,0x000f
	sll	$2,$2,4
	srl	$3,$3,4
	or	$2,$2,$3
	sb	$2,16($4)
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	addu	$4,$16,$18
	.set	macro
	.set	reorder

$L649:
	move	$16,$0
	lui	$2,%hi(colourRGB) # high
	addiu	$17,$2,%lo(colourRGB) # low
$L656:
	move	$4,$16
	lw	$5,0($17)
	move	$6,$0
	andi	$7,$20,0x00ff
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	Font_ComputeColors__Fiiic
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,16
	bne	$2,$0,$L656
	jal	Font_ReSetBlitter__Fv
	.set	noreorder
	.set	nomacro
	jal	Font_SwitchFont__FPc
	move	$4,$19
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$2,%hi(currentfont+136) # high
	lw	$5,%lo(currentfont+136)($2)
	addu	$2,$4,-16
	.set	noreorder
	.set	nomacro
	jal	resizememadr
	subu	$5,$5,$2
	.set	macro
	.set	reorder

	li	$4,8388608			# 0x00800000
	.set	noreorder
	.set	nomacro
	jal	Font_TextTint__Fi
	ori	$4,$4,0x8080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	lh	$2,6($18)
	lw	$31,52($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$2,$22,$2
	lw	$22,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Font_LoadFont__FPciic
	.text
	.ent	Font_TextXY__FPcii
Font_TextXY__FPcii:
	.frame	$sp,64,$31		# vars= 0, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,40($sp)
	move	$18,$5
	sw	$22,56($sp)
	move	$22,$6
	sw	$20,48($sp)
	move	$20,$4
	sw	$19,44($sp)
	li	$19,-1			# 0xffffffff
	lui	$2,%hi(currentfont) # high
	sw	$21,52($sp)
	addiu	$21,$2,%lo(currentfont) # low
	sw	$31,60($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
$L662:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L663
	li	$11,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lbu	$19,0($20)
	#nop
	slt	$2,$19,33
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	addu	$20,$20,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_Getcharacter__Fi
	move	$4,$19
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L662
	addu	$4,$17,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	geti
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$6,136($21)
	lb	$4,9($17)
	lb	$5,10($17)
	move	$7,$16
	sw	$2,16($sp)
	sw	$17,20($sp)
	lw	$2,120($21)
	lw	$3,gCurrentBlitter
	addu	$4,$18,$4
	addu	$5,$22,$5
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lb	$2,8($17)
	.set	noreorder
	.set	nomacro
	j	$L662
	addu	$18,$18,$2
	.set	macro
	.set	reorder

$L665:
	lbu	$2,gFontSpaceWidth
	.set	noreorder
	.set	nomacro
	j	$L662
	addu	$18,$18,$2
	.set	macro
	.set	reorder

$L663:
	ori	$11,$11,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	move	$5,$0
	move	$6,$5
	li	$10,-16777216			# 0xff000000
	lw	$4,0($11)
	lhu	$7,font_currentTPage
	lw	$8,528482304
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$10
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,12
	sw	$3,0($11)
	and	$3,$4,$9
	and	$2,$2,$10
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,60($sp)
	lw	$22,56($sp)
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

	.end	Font_TextXY__FPcii
	.text
	.ent	Font_GetUVWH__FcPiN41
Font_GetUVWH__FcPiN41:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	lw	$20,64($sp)
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$19,28($sp)
	move	$19,$7
	sw	$21,36($sp)
	lw	$21,68($sp)
	andi	$4,$4,0x00ff
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_Getcharacter__Fi
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	addu	$4,$16,4
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$16,6
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	geti
	sw	$2,0($17)
	.set	macro
	.set	reorder

	lui	$3,%hi(currentfont+136) # high
	lw	$3,%lo(currentfont+136)($3)
	#nop
	lw	$3,12($3)
	#nop
	sll	$3,$3,20
	sra	$3,$3,20
	addu	$3,$3,$2
	sw	$3,0($18)
	lbu	$2,2($16)
	#nop
	sw	$2,0($19)
	lbu	$2,3($16)
	#nop
	sw	$2,0($20)
	lb	$2,10($16)
	#nop
	sw	$2,0($21)
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

	.end	Font_GetUVWH__FcPiN41
