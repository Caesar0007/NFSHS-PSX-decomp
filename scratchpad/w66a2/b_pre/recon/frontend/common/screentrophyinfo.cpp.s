	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentrophyinfo.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	kBannerColors
	.data
	.align	2
kBannerColors:
	.word	3948810
	.word	15940
	.word	2171169
	.word	12356
	.rdata
	.align	2
$LC0:
	.ascii	"zSTI\000"
	.text
	.align	2
	.globl	GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3
	.ent	GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3
GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$8,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$17,28($sp)
	move	$17,$6
	lui	$2,%hi(screenTrophyRoom) # high
	lw	$4,%lo(screenTrophyRoom)($2)
	lui	$3,%hi(frontEnd+290) # high
	sw	$31,40($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	lw	$2,208($4)
	lbu	$3,%lo(frontEnd+290)($3)
	sll	$2,$2,1
	addu	$4,$4,$2
	lui	$2,%hi(tournamentManager) # high
	addiu	$6,$2,%lo(tournamentManager) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$5,24($6)
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lbu	$2,212($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$5,$5,$2
	lb	$2,0($5)
	move	$18,$7
	addu	$2,$2,$6
	lb	$3,496($2)
	#nop
	addu	$2,$3,-1
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$3
$L601:
	lui	$3,%hi(kBannerColors) # high
	addiu	$3,$3,%lo(kBannerColors) # low
	sll	$2,$4,16
	sra	$2,$2,14
	addu	$2,$2,$3
	lui	$16,%hi(gSwapFileNameTI) # high
	addiu	$16,$16,%lo(gSwapFileNameTI) # low
	move	$4,$6
	li	$6,2			# 0x00000002
	lw	$2,0($2)
	move	$7,$16
	sw	$2,100($8)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sh	$2,0($17)
	lw	$2,64($sp)
	#nop
	sw	$16,0($2)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	sw	$2,0($18)
	li	$2,11			# 0x0000000b
	sh	$2,0($19)
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

	.end	GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3
	.align	2
	.globl	DrawBackground__17tScreenTrophyInfo
	.ent	DrawBackground__17tScreenTrophyInfo
DrawBackground__17tScreenTrophyInfo:
	.frame	$sp,120,$31		# vars= 56, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$22,112($sp)
	move	$22,$4
	sw	$31,116($sp)
	sw	$21,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	lh	$2,92($22)
	#nop
	addu	$4,$2,-64
	.set	noreorder
	.set	nomacro
	bgez	$4,$L603
	sll	$20,$2,1
	.set	macro
	.set	reorder

	move	$4,$0
$L603:
	.set	noreorder
	.set	nomacro
	bgez	$20,$L604
	sll	$19,$4,1
	.set	macro
	.set	reorder

	move	$20,$0
$L604:
	slt	$2,$20,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	lui	$2,%hi(screenTrophyRoom) # high
	.set	macro
	.set	reorder

	li	$20,128			# 0x00000080
$L621:
	lui	$3,%hi(frontEnd+290) # high
	lui	$4,%hi(tournamentManager+24) # high
	lw	$16,%lo(tournamentManager+24)($4)
	lui	$4,%hi(kRGBVals) # high
	lw	$7,%lo(screenTrophyRoom)($2)
	addiu	$4,$4,%lo(kRGBVals) # low
	lw	$2,208($7)
	lbu	$3,%lo(frontEnd+290)($3)
	sll	$2,$2,1
	addu	$7,$7,$2
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lui	$3,%hi(textDefinitions+29) # high
	lbu	$3,%lo(textDefinitions+29)($3)
	lbu	$6,2($2)
	lbu	$2,212($7)
	sll	$3,$3,2
	addu	$3,$3,$4
	addu	$6,$6,$2
	sll	$2,$6,2
	addu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$16,$16,$2
	lw	$4,0($3)
	lb	$21,0($16)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	li	$17,175			# 0x000000af
	lb	$4,0($16)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,833
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,30			# 0x0000001e
	li	$6,25			# 0x00000019
	move	$7,$16
	li	$2,3			# 0x00000003
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	addu	$16,$21,890
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,987			# 0x000003db
	li	$6,140			# 0x0000008c
	move	$7,$17
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,145			# 0x00000091
	move	$6,$17
	move	$7,$2
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	li	$17,183			# 0x000000b7
$L606:
	addu	$18,$21,928
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,989			# 0x000003dd
	li	$6,140			# 0x0000008c
	sll	$7,$17,16
	sra	$7,$7,16
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	li	$2,145			# 0x00000091
	sh	$2,32($sp)
	li	$2,347			# 0x0000015b
	sh	$2,36($sp)
	li	$2,100			# 0x00000064
	sh	$17,34($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGB__FPcR4RECTi
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	li	$4,347			# 0x0000015b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapHeight__FsPc
	move	$5,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$2
$L607:
	addu	$18,$21,909
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,988			# 0x000003dc
	li	$6,140			# 0x0000008c
	sll	$7,$17,16
	sra	$7,$7,16
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	li	$2,145			# 0x00000091
	sh	$2,32($sp)
	li	$2,347			# 0x0000015b
	sh	$2,36($sp)
	li	$2,100			# 0x00000064
	sh	$17,34($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGB__FPcR4RECTi
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	li	$4,347			# 0x0000015b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapHeight__FsPc
	move	$5,$2
	.set	macro
	.set	reorder

$L608:
	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$22,40
	.set	macro
	.set	reorder

	lw	$2,44($22)
	#nop
	beq	$2,$0,$L609
	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

$L609:
	addu	$4,$21,871
	li	$2,35			# 0x00000023
	sh	$2,32($sp)
	li	$2,45			# 0x0000002d
	sh	$2,34($sp)
	li	$2,452			# 0x000001c4
	sh	$2,36($sp)
	li	$2,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	li	$4,5242880			# 0x00500000
	ori	$4,$4,0x5050
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	move	$6,$2
	li	$7,3			# 0x00000003
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	li	$4,715784192			# 0x2aaa0000
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	ori	$4,$4,0xaaab
	mult	$3,$4
	lw	$2,40($22)
	sra	$3,$3,31
	sw	$2,60($sp)
	mfhi	$8
	#nop
	#nop
	sra	$2,$8,1
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L610
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$4,$2,31
$L610:
	sra	$4,$4,5
	sll	$4,$4,5
	subu	$4,$2,$4
	li	$5,1536			# 0x00000600
	li	$6,70			# 0x00000046
	li	$7,-5			# 0xfffffffb
	addu	$2,$sp,40
	sw	$19,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	li	$18,1431633920			# 0x55550000
	ori	$18,$18,0x5556
	lw	$2,100($22)
	addu	$17,$sp,64
	sw	$2,68($sp)
	mult	$16,$18
$L622:
	sra	$3,$16,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L614
	move	$4,$0
	.set	macro
	.set	reorder

	li	$5,1040			# 0x00000410
	sll	$6,$16,1
	move	$7,$4
	sw	$20,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$17,24($sp)
	.set	macro
	.set	reorder

$L614:
	addu	$16,$16,1
	slt	$2,$16,30
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	mult	$16,$18
	.set	macro
	.set	reorder

	li	$16,34			# 0x00000022
	li	$18,1431633920			# 0x55550000
	ori	$18,$18,0x5556
	addu	$17,$sp,64
	mult	$16,$18
$L623:
	sra	$3,$16,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L619
	move	$4,$0
	.set	macro
	.set	reorder

	li	$5,1040			# 0x00000410
	sll	$6,$16,1
	move	$7,$4
	sw	$20,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$17,24($sp)
	.set	macro
	.set	reorder

$L619:
	addu	$16,$16,1
	slt	$2,$16,63
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	mult	$16,$18
	.set	macro
	.set	reorder

	lw	$31,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	DrawBackground__17tScreenTrophyInfo
	.align	2
	.globl	___17tScreenTrophyInfo
	.ent	___17tScreenTrophyInfo
___17tScreenTrophyInfo:
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

	.end	___17tScreenTrophyInfo
	.globl	gSwapFileNameTI
	.data
	.align	2
gSwapFileNameTI:
	.space	16
	.globl	screenTrophyInfo
	.align	2
screenTrophyInfo:
	.space	4
