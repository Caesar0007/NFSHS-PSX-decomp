	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fecredits.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Setup__14tCreditManager
	.ent	Setup__14tCreditManager
Setup__14tCreditManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,16($4)
	sw	$0,20($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,4($4)
	.set	macro
	.set	reorder

	.end	Setup__14tCreditManager
	.rdata
	.align	2
$LC0:
	.ascii	"%szcred%d.dat\000"
	.align	2
$LC1:
	.ascii	"records\000"
	.text
	.align	2
	.globl	Init__14tCreditManageri
	.ent	Init__14tCreditManageri
Init__14tCreditManageri:
	.frame	$sp,104,$31		# vars= 80, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$16,96($sp)
	move	$16,$4
	sw	$31,100($sp)
	lw	$2,16($16)
	#nop
	bne	$2,$0,$L602
	lw	$2,20($16)
	#nop
	beq	$2,$0,$L603
	sw	$0,20($16)
$L603:
	addu	$4,$sp,16
	li	$2,-1			# 0xffffffff
	sw	$2,28($16)
	li	$2,128			# 0x00000080
	sw	$2,8($16)
	lui	$2,%hi(Paths_Paths+148) # high
	lui	$5,%hi($LC0) # high
	sw	$0,52($16)
	sw	$0,36($16)
	sw	$0,40($16)
	sw	$0,44($16)
	sw	$0,20($16)
	sw	$0,32($16)
	lw	$6,%lo(Paths_Paths+148)($2)
	lui	$2,%hi(frontEnd+832) # high
	lbu	$7,%lo(frontEnd+832)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	loadfileatadrz
	sw	$5,0($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$3,-901412889			# 0xca4587e7
	multu	$2,$3
	li	$2,1			# 0x00000001
	sw	$2,16($16)
	mfhi	$8
	#nop
	#nop
	srl	$2,$8,8
	sw	$2,24($16)
$L602:
	lw	$31,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Init__14tCreditManageri
	.align	2
	.globl	DeInit__14tCreditManager
	.ent	DeInit__14tCreditManager
DeInit__14tCreditManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,20($4)
	.set	macro
	.set	reorder

	.end	DeInit__14tCreditManager
	.align	2
	.globl	RealDeInit__14tCreditManager
	.ent	RealDeInit__14tCreditManager
RealDeInit__14tCreditManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	sw	$0,20($16)
	.set	macro
	.set	reorder

	lw	$4,0($16)
	jal	purgememadr
	sw	$0,16($16)
$L605:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	RealDeInit__14tCreditManager
	.align	2
	.globl	Draw__14tCreditManagerb
	.ent	Draw__14tCreditManagerb
Draw__14tCreditManagerb:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L608
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,4($16)
	.set	noreorder
	.set	nomacro
	j	$L623
	addu	$2,$2,4
	.set	macro
	.set	reorder

$L608:
	lw	$2,4($16)
	#nop
	addu	$2,$2,-4
$L623:
	sw	$2,4($16)
	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L624
	move	$3,$2
	.set	macro
	.set	reorder

	move	$2,$0
	move	$3,$2
$L624:
 #APP
 #NO_APP
	slt	$2,$3,93
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L625
	slt	$2,$3,92
	.set	macro
	.set	reorder

	li	$3,92			# 0x0000005c
	slt	$2,$3,92
$L625:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	sw	$3,4($16)
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	lw	$4,8($16)
	subu	$3,$2,$3
	slt	$2,$3,$4
	beq	$2,$0,$L613
	move	$3,$4
$L613:
	sw	$3,8($16)
$L612:
	move	$6,$0
	li	$7,128			# 0x00000080
	lui	$2,%hi(screenMain) # high
	lw	$5,%lo(screenMain)($2)
$L614:
	lhu	$2,132($5)
	#nop
	ori	$2,$2,0x0002
	sh	$2,132($5)
	lw	$4,4($16)
	addu	$6,$6,1
	subu	$4,$7,$4
	sll	$2,$4,16
	sll	$3,$4,8
	or	$2,$2,$3
	or	$2,$2,$4
	sw	$2,140($5)
	slt	$2,$6,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	addu	$5,$5,48
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	bne	$2,$0,$L618
	lw	$2,20($16)
	#nop
	beq	$2,$0,$L607
	.set	noreorder
	.set	nomacro
	jal	RealDeInit__14tCreditManager
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L607
$L618:
	lw	$2,16($16)
	#nop
	beq	$2,$0,$L607
	.set	noreorder
	.set	nomacro
	jal	SetupCurrCredit__14tCreditManager
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,28($16)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L607
	.set	noreorder
	.set	nomacro
	jal	DrawCurrCredit__14tCreditManager
	move	$4,$16
	.set	macro
	.set	reorder

$L607:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw__14tCreditManagerb
	.align	2
	.globl	SetupCurrCredit__14tCreditManager
	.ent	SetupCurrCredit__14tCreditManager
SetupCurrCredit__14tCreditManager:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lui	$3,%hi(FECredits_lastFadeTick) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,%lo(FECredits_lastFadeTick)($3)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	subu	$2,$2,$3
	slt	$2,$2,13
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	bne	$2,$0,$L627
	lw	$3,32($16)
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L627
	move	$17,$0
	.set	macro
	.set	reorder

	li	$4,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetNoDebounceKey__Fii
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	li	$4,32			# 0x00000020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FEInput_GetNoDebounceKey__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$2,$0,$L628
$L629:
	li	$17,1			# 0x00000001
$L628:
	beq	$17,$0,$L630
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$2,28($16)
	sw	$0,52($16)
	addu	$2,$2,1
	sw	$2,32($16)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	lui	$2,%hi(FECredits_lastFadeTick) # high
	sw	$3,%lo(FECredits_lastFadeTick)($2)
$L630:
	lw	$2,32($16)
	lw	$3,24($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L631
	sw	$0,32($16)
$L631:
	lw	$2,32($16)
	#nop
	bgez	$2,$L627
	lw	$2,24($16)
	#nop
	addu	$2,$2,-1
	sw	$2,32($16)
$L627:
	lw	$4,52($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L633
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(CREDFADETICKS) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,%lo(CREDFADETICKS)($3)
	subu	$2,$2,$4
	slt	$3,$3,$2
	beq	$3,$0,$L633
	lw	$2,32($16)
	lw	$3,24($16)
	addu	$2,$2,1
	sw	$2,32($16)
	slt	$2,$2,$3
	bne	$2,$0,$L634
	sw	$0,32($16)
$L634:
	lw	$2,32($16)
	#nop
	bgez	$2,$L635
	lw	$2,24($16)
	#nop
	addu	$2,$2,-1
	sw	$2,32($16)
$L635:
	sw	$0,52($16)
$L633:
	lw	$3,28($16)
	lw	$2,32($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L636
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	sw	$2,12($16)
	sw	$0,36($16)
	sw	$0,40($16)
	sw	$0,44($16)
$L636:
	lw	$2,8($16)
	lw	$3,12($16)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L637
	sw	$2,8($16)
	.set	macro
	.set	reorder

	sw	$0,8($16)
$L637:
	lw	$2,8($16)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sw	$2,8($16)
$L638:
	lw	$3,8($16)
	li	$2,128			# 0x00000080
	bne	$3,$2,$L639
	lw	$2,36($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	li	$2,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	lw	$4,32($16)
	ori	$2,$2,0x5556
	mult	$4,$2
	li	$2,1			# 0x00000001
	sra	$3,$4,31
	sw	$2,36($16)
	mfhi	$6
	#nop
	#nop
	subu	$3,$6,$3
	sll	$2,$3,$2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L641
	sw	$4,28($16)
	.set	macro
	.set	reorder

	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,4
	addu	$2,$2,$4
	lw	$3,0($16)
	sll	$2,$2,2
	addu	$2,$2,$3
	lh	$3,28($2)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L639
$L641:
	lw	$2,24($16)
	addu	$3,$4,1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi(screenMain) # high
	.set	macro
	.set	reorder

	move	$3,$0
$L645:
	lw	$4,%lo(screenMain)($2)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,0($16)
	sll	$2,$2,2
	addu	$2,$2,$3
	lh	$5,28($2)
	jal	SwapBackground__11tScreenMaini
$L639:
	lw	$2,40($16)
	#nop
	bne	$2,$0,$L643
	lw	$2,36($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	lui	$2,%hi(screenMain) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(screenMain)($2)
	jal	DoneLoadingBackground__11tScreenMain
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sw	$2,40($16)
	sw	$3,48($16)
$L643:
	lw	$2,44($16)
	#nop
	bne	$2,$0,$L626
	lw	$2,40($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
	lui	$4,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($4)
	lw	$3,48($16)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,31
	bne	$2,$0,$L626
	#.set	volatile
	lw	$3,%lo(ticks)($4)
	#.set	novolatile
	li	$2,1			# 0x00000001
	sw	$2,44($16)
	li	$2,-8			# 0xfffffff8
	sw	$2,12($16)
	sw	$3,52($16)
$L626:
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

	.end	SetupCurrCredit__14tCreditManager
	.align	2
	.globl	DrawCurrCredit__14tCreditManager
	.ent	DrawCurrCredit__14tCreditManager
DrawCurrCredit__14tCreditManager:
	.frame	$sp,416,$31		# vars= 336, regs= 10/0, args= 40, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,416
	li	$3,1717960704			# 0x66660000
	lui	$2,%hi(ticks) # high
	ori	$3,$3,0x6667
	lw	$8,%lo(ticks)($2)
	li	$2,13500416			# 0x00ce0000
	ori	$2,$2,0xc844
	li	$5,1040			# 0x00000410
	li	$6,16			# 0x00000010
	move	$7,$6
	sw	$2,44($sp)
	addu	$2,$sp,40
	sw	$31,412($sp)
	sw	$fp,408($sp)
	sw	$23,404($sp)
	sw	$4,416($sp)
	sra	$4,$8,4
	mult	$4,$3
	sw	$22,400($sp)
	sw	$21,396($sp)
	sw	$20,392($sp)
	sw	$19,388($sp)
	sw	$18,384($sp)
	sw	$17,380($sp)
	sw	$16,376($sp)
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sra	$8,$8,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,2
	subu	$3,$3,$8
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,230
	.set	macro
	.set	reorder

	lw	$9,416($sp)
	li	$4,1			# 0x00000001
	lw	$3,28($9)
	move	$5,$4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,0($9)
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	addu	$17,$3,$2
	.set	macro
	.set	reorder

	lw	$9,416($sp)
	#nop
	lw	$5,8($9)
	lhu	$19,14($17)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$5,40			# 0x00000028
	.set	macro
	.set	reorder

	lw	$9,416($sp)
	li	$4,48830			# 0x0000bebe
	lw	$5,8($9)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$5,40			# 0x00000028
	.set	macro
	.set	reorder

	li	$4,7864320			# 0x00780000
	lw	$9,416($sp)
	ori	$4,$4,0x7878
	lw	$5,8($9)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$18,$2
	.set	macro
	.set	reorder

	lh	$3,10($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L647
	move	$fp,$2
	.set	macro
	.set	reorder

	lhu	$2,4($17)
	#nop
	sh	$2,64($sp)
	lhu	$2,6($17)
	#nop
	sh	$2,66($sp)
	lhu	$3,10($17)
	li	$2,100			# 0x00000064
	sh	$2,70($sp)
	sh	$3,68($sp)
	lh	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$sp,64
	lh	$7,8($17)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	j	$L648
$L647:
	lh	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	lh	$5,4($17)
	lh	$6,6($17)
	move	$4,$2
	sw	$0,16($sp)
	lh	$2,8($17)
	move	$7,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L648:
	lh	$2,18($17)
	#nop
	beq	$2,$0,$L649
	lhu	$2,12($17)
	#nop
	sh	$2,64($sp)
	lhu	$2,14($17)
	#nop
	sh	$2,66($sp)
	lhu	$3,18($17)
	li	$2,100			# 0x00000064
	sh	$2,70($sp)
	sh	$3,68($sp)
	lh	$4,2($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$sp,64
	lh	$7,16($17)
	move	$6,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L650
	addu	$19,$19,$2
	.set	macro
	.set	reorder

$L649:
	lh	$4,2($17)
	addu	$19,$19,8
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	lh	$5,12($17)
	lh	$6,14($17)
	move	$4,$2
	sw	$0,16($sp)
	lh	$2,16($17)
	move	$7,$18
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L650:
	lh	$2,22($17)
	lhu	$3,22($17)
	beq	$2,$0,$L651
	move	$19,$3
$L651:
	lhu	$9,20($17)
	lh	$16,18($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L652
	sh	$9,368($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$4,2($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	lh	$4,2($17)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,1300
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
$L652:
	lhu	$9,368($sp)
	#nop
	sll	$2,$9,16
	bne	$2,$0,$L653
	lh	$2,16($17)
	#nop
	bne	$2,$0,$L654
	lhu	$2,12($17)
	#nop
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	j	$L703
	addu	$2,$2,2
	.set	macro
	.set	reorder

$L654:
	lhu	$2,12($17)
	#nop
	subu	$2,$2,$16
	addu	$2,$2,-2
$L703:
	sh	$2,368($sp)
$L653:
	addu	$16,$sp,72
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$17,32
	.set	macro
	.set	reorder

	lhu	$9,368($sp)
	#nop
	sll	$23,$9,16
$L656:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L657
	move	$22,$0
	.set	macro
	.set	reorder

	move	$21,$22
	move	$18,$22
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strchr
	li	$5,10			# 0x0000000a
	.set	macro
	.set	reorder

	move	$20,$2
	beq	$20,$0,$L659
	sb	$0,0($20)
$L659:
	lbu	$3,0($16)
	li	$2,10			# 0x0000000a
	bne	$3,$2,$L660
	move	$3,$2
	addu	$16,$16,1
$L707:
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L707
	addu	$16,$16,1
	.set	macro
	.set	reorder

	addu	$16,$16,-1
	#.set	volatile
	lbu	$3,0($16)
	#.set	novolatile
$L660:
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L665
	move	$3,$2
	.set	macro
	.set	reorder

	li	$22,1			# 0x00000001
	addu	$16,$16,1
$L708:
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L708
	addu	$16,$16,1
	.set	macro
	.set	reorder

	addu	$16,$16,-1
$L665:
	lbu	$3,0($16)
	li	$2,42			# 0x0000002a
	bne	$3,$2,$L670
	li	$21,1			# 0x00000001
	move	$3,$2
	addu	$16,$16,1
$L709:
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L709
	addu	$16,$16,1
	.set	macro
	.set	reorder

	addu	$16,$16,-1
	#.set	volatile
	lbu	$3,0($16)
	#.set	novolatile
$L670:
	li	$2,94			# 0x0000005e
	bne	$3,$2,$L675
	li	$18,1			# 0x00000001
	move	$3,$2
	addu	$16,$16,1
$L710:
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L710
	addu	$16,$16,1
	.set	macro
	.set	reorder

	addu	$16,$16,-1
$L675:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L704
	li	$2,2000			# 0x000007d0
	.set	macro
	.set	reorder

	li	$2,700			# 0x000002bc
$L704:
	lui	$9,%hi(CREDFADETICKS) # high
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L682
	sw	$2,%lo(CREDFADETICKS)($9)
	.set	macro
	.set	reorder

	li	$4,1430			# 0x00000596
	li	$2,180			# 0x000000b4
	sh	$2,64($sp)
	li	$2,85			# 0x00000055
	sh	$2,66($sp)
	li	$2,280			# 0x00000118
	sh	$2,68($sp)
	li	$2,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$2,70($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$sp,64
	move	$6,$fp
	move	$7,$0
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L706
	addu	$19,$19,8
	.set	macro
	.set	reorder

$L682:
	beq	$18,$0,$L684
	move	$16,$0
$L685:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$16,1431
	.set	macro
	.set	reorder

	move	$4,$2
	sra	$5,$23,16
	sll	$6,$19,16
	sra	$6,$6,16
	move	$7,$fp
	addu	$19,$19,8
	sw	$0,16($sp)
	lh	$2,24($17)
	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	slt	$2,$16,25
	bne	$2,$0,$L685
	.set	noreorder
	.set	nomacro
	j	$L706
	addu	$19,$19,8
	.set	macro
	.set	reorder

$L684:
	.set	noreorder
	.set	nomacro
	bne	$22,$0,$L690
	move	$4,$16
	.set	macro
	.set	reorder

	sra	$5,$23,16
	sll	$6,$19,16
	sra	$6,$6,16
	sw	$0,16($sp)
	lh	$2,24($17)
	move	$7,$fp
	.set	noreorder
	.set	nomacro
	j	$L705
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L690:
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L691
	li	$4,5242880			# 0x00500000
	.set	macro
	.set	reorder

	lw	$9,416($sp)
	#nop
	lw	$5,8($9)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	ori	$4,$4,0x5050
	.set	macro
	.set	reorder

	move	$4,$16
	sra	$5,$23,16
	sll	$6,$19,16
	sra	$6,$6,16
	sw	$0,16($sp)
	lh	$3,24($17)
	move	$7,$2
	sw	$3,20($sp)
$L705:
	jal	FETextRender_FullTextRGB__FPcssics
$L691:
	addu	$19,$19,8
$L706:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L656
	move	$16,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L656
	addu	$16,$20,1
	.set	macro
	.set	reorder

$L657:
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$9,416($sp)
	#nop
	lw	$2,40($9)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	li	$4,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	lw	$2,48($9)
	ori	$4,$4,0x6667
	subu	$3,$3,$2
	sll	$2,$3,6
	addu	$2,$2,$3
	sll	$2,$2,3
	mult	$2,$4
	li	$18,200			# 0x000000c8
	sra	$2,$2,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,5
	subu	$16,$3,$2
	slt	$2,$16,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	slt	$2,$16,321
	.set	macro
	.set	reorder

	move	$18,$16
	li	$16,200			# 0x000000c8
	slt	$2,$16,321
$L711:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	li	$2,320			# 0x00000140
	.set	macro
	.set	reorder

	subu	$18,$2,$16
	.set	noreorder
	.set	nomacro
	bgez	$18,$L712
	li	$2,520			# 0x00000208
	.set	macro
	.set	reorder

	move	$18,$0
$L712:
	subu	$16,$2,$18
$L696:
	.set	noreorder
	.set	nomacro
	blez	$18,$L698
	li	$4,5242880			# 0x00500000
	.set	macro
	.set	reorder

	ori	$4,$4,0x5050
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$16,-37
	move	$7,$18
	lh	$6,14($17)
	li	$2,4			# 0x00000004
	sw	$2,16($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	li	$2,1			# 0x00000001
	sw	$2,24($sp)
	sw	$0,28($sp)
	sw	$2,32($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXTransDrawBrightEndLine__Fiiiiiiiii
	addu	$6,$6,-2
	.set	macro
	.set	reorder

$L698:
	li	$4,1717960704			# 0x66660000
	lui	$2,%hi(ticks) # high
	lw	$9,416($sp)
	lw	$3,%lo(ticks)($2)
	lw	$2,48($9)
	ori	$4,$4,0x6667
	subu	$3,$3,$2
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	mult	$2,$4
	li	$17,100			# 0x00000064
	sra	$2,$2,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,5
	subu	$16,$3,$2
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	slt	$2,$16,169
	.set	macro
	.set	reorder

	move	$17,$16
	li	$16,100			# 0x00000064
	slt	$2,$16,169
$L713:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	li	$2,168			# 0x000000a8
	.set	macro
	.set	reorder

	subu	$17,$2,$16
	.set	noreorder
	.set	nomacro
	bgez	$17,$L714
	li	$2,268			# 0x0000010c
	.set	macro
	.set	reorder

	move	$17,$0
$L714:
	subu	$16,$2,$18
$L700:
	.set	noreorder
	.set	nomacro
	blez	$17,$L646
	li	$4,5242880			# 0x00500000
	.set	macro
	.set	reorder

	ori	$4,$4,0x5050
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$6,$16,-58
	li	$7,2			# 0x00000002
	lhu	$9,368($sp)
	li	$2,1			# 0x00000001
	sw	$17,16($sp)
	sw	$2,20($sp)
	sw	$2,24($sp)
	sw	$0,28($sp)
	sw	$2,32($sp)
	sll	$5,$9,16
	.set	noreorder
	.set	nomacro
	jal	PSXTransDrawBrightEndLine__Fiiiiiiiii
	sra	$5,$5,16
	.set	macro
	.set	reorder

$L646:
	lw	$31,412($sp)
	lw	$fp,408($sp)
	lw	$23,404($sp)
	lw	$22,400($sp)
	lw	$21,396($sp)
	lw	$20,392($sp)
	lw	$19,388($sp)
	lw	$18,384($sp)
	lw	$17,380($sp)
	lw	$16,376($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,416
	.set	macro
	.set	reorder

	.end	DrawCurrCredit__14tCreditManager
