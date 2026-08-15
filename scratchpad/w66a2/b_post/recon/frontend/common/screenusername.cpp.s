	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screenusername.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	menu_kUserNameRows
	.data
	.align	1
menu_kUserNameRows:
	.half	0
	.globl	MENUUSERNAME_STARTY
	.align	1
MENUUSERNAME_STARTY:
	.half	0
	.globl	screenUserName
	.align	2
screenUserName:
	.word	0
	.rdata
	.align	2
$LC0:
	.ascii	"ScreenUserName.obj globals: menu_kUserNameRows/MENUUSERN"
	.ascii	"AME_STARTY/screenUserName/UserPermFileName (EXT, in .h)\000"
	.data
	.align	2
MOD:
	.word	$LC0
	.text
	.align	2
	.globl	Initialize__15tScreenUserName
	.ent	Initialize__15tScreenUserName
Initialize__15tScreenUserName:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	li	$2,128			# 0x00000080
	lui	$6,%hi(menu_kUserNameRows) # high
	lh	$4,%lo(menu_kUserNameRows)($6)
	lui	$5,%hi(MENUUSERNAME_STARTY) # high
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	sh	$2,104($18)
	li	$2,130			# 0x00000082
	sll	$3,$4,4
	subu	$3,$3,$4
	sra	$3,$3,1
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	blez	$4,$L601
	sh	$2,%lo(MENUUSERNAME_STARTY)($5)
	.set	macro
	.set	reorder

	move	$19,$6
	sll	$16,$17,16
$L606:
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$16,507
	.set	macro
	.set	reorder

	sll	$4,$16,3
	addu	$4,$4,$16
	addu	$4,$4,112
	addu	$4,$18,$4
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	lh	$3,%lo(menu_kUserNameRows)($19)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	sll	$16,$17,16
	.set	macro
	.set	reorder

$L601:
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$18
	.set	macro
	.set	reorder

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

	.end	Initialize__15tScreenUserName
	.rdata
	.align	2
$LC1:
	.ascii	"\000"
	.align	2
$LC2:
	.ascii	"zUser%d\000"
	.text
	.align	2
	.globl	GetShapeInfo__15tScreenUserNameRsT1PPcT3
	.ent	GetShapeInfo__15tScreenUserNameRsT1PPcT3
GetShapeInfo__15tScreenUserNameRsT1PPcT3:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$7
	sw	$16,16($sp)
	lui	$16,%hi($LC1) # high
	addiu	$16,$16,%lo($LC1) # low
	lw	$2,48($sp)
	move	$4,$16
	sw	$31,24($sp)
	sw	$0,0($2)
	li	$2,92			# 0x0000005c
	sh	$0,0($6)
	sh	$2,0($5)
	lui	$5,%hi($LC2) # high
	lui	$2,%hi(frontEnd+832) # high
	lbu	$6,%lo(frontEnd+832)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	sw	$16,0($17)
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

	.end	GetShapeInfo__15tScreenUserNameRsT1PPcT3
	.align	2
	.globl	DrawVerticalLine__15tScreenUserNamesss
	.ent	DrawVerticalLine__15tScreenUserNamesss
DrawVerticalLine__15tScreenUserNamesss:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
 #APP
 #NO_APP
	sll	$2,$7,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	.set	noreorder
	blez	$3,$L609
	sw	$31,32($sp)
	.set	reorder
	slt	$2,$3,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

$L609:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L615
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L615
	move	$7,$0
	.set	macro
	.set	reorder

$L611:
	li	$7,64			# 0x00000040
$L615:
	ori	$4,$4,0x5a5a
	li	$2,162			# 0x000000a2
	sw	$2,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,20($sp)
	sll	$2,$7,16
	sra	$2,$2,15
	sll	$5,$5,16
	sll	$6,$6,16
	sra	$5,$5,16
	sra	$6,$6,16
	li	$7,2			# 0x00000002
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$0,28($sp)
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

	.end	DrawVerticalLine__15tScreenUserNamesss
	.align	2
	.globl	DrawHorizontalLine__15tScreenUserNamesss
	.ent	DrawHorizontalLine__15tScreenUserNamesss
DrawHorizontalLine__15tScreenUserNamesss:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
 #APP
 #NO_APP
	sll	$2,$7,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	.set	noreorder
	blez	$3,$L617
	sw	$31,32($sp)
	.set	reorder
	slt	$2,$3,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

$L617:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L623
	li	$4,7864320			# 0x00780000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L623
	move	$7,$0
	.set	macro
	.set	reorder

$L619:
	li	$7,64			# 0x00000040
$L623:
	ori	$4,$4,0x5a5a
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	sll	$2,$7,16
	sra	$2,$2,15
	sw	$2,24($sp)
	li	$2,12			# 0x0000000c
	sll	$5,$5,16
	sll	$6,$6,16
	sra	$5,$5,16
	sra	$6,$6,16
	li	$7,192			# 0x000000c0
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$2,28($sp)
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

	.end	DrawHorizontalLine__15tScreenUserNamesss
	.rdata
	.align	2
$LC3:
	.ascii	" \000"
	.text
	.align	2
	.globl	DrawBackground__15tScreenUserName
	.ent	DrawBackground__15tScreenUserName
DrawBackground__15tScreenUserName:
	.frame	$sp,112,$31		# vars= 40, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$23,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$20,88($sp)
	sw	$19,84($sp)
	sw	$18,80($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	sw	$4,112($sp)
	lw	$2,100($4)
	#nop
	#.set	volatile
	lw	$2,116($2)
	#.set	novolatile
	#nop
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,17
	addu	$4,$2,-128
	move	$3,$4
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	slt	$2,$3,129
	.set	macro
	.set	reorder

	blez	$3,$L627
$L689:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	move	$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L630
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

$L627:
	move	$2,$0
$L629:
$L630:
	sh	$2,40($sp)
	sll	$2,$5,16
	sra	$4,$2,18
	move	$3,$4
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	slt	$2,$3,129
	.set	macro
	.set	reorder

	blez	$3,$L633
$L690:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	move	$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L636
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

$L633:
	move	$2,$0
$L635:
$L636:
	sh	$2,48($sp)
	sll	$2,$5,16
	sra	$3,$2,16
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L691
	slt	$2,$3,129
	.set	macro
	.set	reorder

	blez	$3,$L639
$L691:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L641
	move	$2,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L642
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

$L639:
	move	$2,$0
$L641:
$L642:
	li	$16,524288			# 0x00080000
	ori	$16,$16,0x0808
	li	$4,240			# 0x000000f0
	li	$5,42			# 0x0000002a
	li	$6,194			# 0x000000c2
	lw	$8,112($sp)
	li	$7,85			# 0x00000055
	sh	$2,104($8)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	li	$4,240			# 0x000000f0
	li	$5,127			# 0x0000007f
	li	$6,194			# 0x000000c2
	li	$7,85			# 0x00000055
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	li	$fp,1			# 0x00000001
	li	$23,2			# 0x00000002
	lui	$2,%hi(MENUUSERNAME_STARTY) # high
	lhu	$21,%lo(MENUUSERNAME_STARTY)($2)
	lui	$2,%hi($LC3) # high
	lhu	$2,%lo($LC3)($2)
	li	$22,14			# 0x0000000e
	sh	$0,56($sp)
	sh	$2,32($sp)
$L643:
	lui	$2,%hi(menu_kUserNameRows) # high
	lhu	$8,56($sp)
	lh	$2,%lo(menu_kUserNameRows)($2)
	sll	$3,$8,16
	sra	$3,$3,16
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L644
	addu	$2,$21,-1
	.set	macro
	.set	reorder

	li	$17,258			# 0x00000102
	sh	$0,64($sp)
	sll	$20,$2,16
	sll	$2,$21,16
	sra	$19,$2,16
$L646:
	lhu	$8,64($sp)
	#nop
	sll	$4,$8,16
	lhu	$8,56($sp)
	sra	$4,$4,16
	sll	$3,$8,16
	sra	$3,$3,16
	sll	$2,$3,3
	addu	$2,$2,$3
	lw	$8,112($sp)
	addu	$4,$4,$2
	addu	$4,$8,$4
	lbu	$2,112($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L647
	li	$4,11862016			# 0x00b50000
	.set	macro
	.set	reorder

	sb	$2,32($sp)
	lh	$5,104($8)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	ori	$4,$4,0x4200
	.set	macro
	.set	reorder

	lbu	$3,32($sp)
	move	$16,$2
	addu	$3,$3,-33
	sltu	$2,$3,62
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	lui	$2,%hi($L673) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L673) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L673:
	.word	$L650
	.word	$L671
	.word	$L657
	.word	$L658
	.word	$L671
	.word	$L664
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L649
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L651
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L671
	.word	$L665
	.text
$L650:
	.set	noreorder
	.set	nomacro
	j	$L688
	li	$4,517			# 0x00000205
	.set	macro
	.set	reorder

$L651:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,517			# 0x00000205
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$17,36
	sll	$5,$5,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$16
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	sll	$2,$17,16
	sra	$18,$2,16
	sw	$22,16($sp)
$L694:
	move	$4,$0
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$5,$18,$5
	addu	$5,$5,-6
	addu	$6,$19,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	beq	$2,$0,$L649
	.set	noreorder
	.set	nomacro
	j	$L694
	sw	$22,16($sp)
	.set	macro
	.set	reorder

$L657:
	.set	noreorder
	.set	nomacro
	j	$L688
	li	$4,518			# 0x00000206
	.set	macro
	.set	reorder

$L658:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,518			# 0x00000206
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$17,36
	sll	$5,$5,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$16
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	sll	$2,$17,16
	sra	$18,$2,16
	sw	$22,16($sp)
$L695:
	move	$4,$0
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$5,$18,$5
	addu	$5,$5,-6
	addu	$6,$19,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	beq	$2,$0,$L649
	.set	noreorder
	.set	nomacro
	j	$L695
	sw	$22,16($sp)
	.set	macro
	.set	reorder

$L664:
	li	$4,519			# 0x00000207
$L688:
	jal	TextSys_Word__Fi
	move	$4,$2
	addu	$5,$17,22
	sll	$5,$5,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$16
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	sll	$5,$17,16
	sra	$5,$5,16
	addu	$5,$5,22
	addu	$6,$19,-2
	li	$7,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$22,16($sp)
	.set	macro
	.set	reorder

	j	$L649
$L665:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,519			# 0x00000207
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$17,78
	sll	$5,$5,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$16
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	sll	$2,$17,16
	sra	$18,$2,16
	sw	$22,16($sp)
$L696:
	move	$4,$0
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$5,$18,$5
	addu	$5,$5,-6
	addu	$6,$19,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,6
	beq	$2,$0,$L649
	.set	noreorder
	.set	nomacro
	j	$L696
	sw	$22,16($sp)
	.set	macro
	.set	reorder

$L671:
	addu	$4,$sp,32
	addu	$5,$17,8
	sll	$5,$5,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$16
	sw	$fp,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$23,20($sp)
	.set	macro
	.set	reorder

$L649:
	lhu	$8,64($sp)
	addu	$17,$17,28
	addu	$8,$8,1
	.set	noreorder
	.set	nomacro
	j	$L646
	sh	$8,64($sp)
	.set	macro
	.set	reorder

$L647:
	lhu	$8,56($sp)
	addu	$21,$21,15
	addu	$8,$8,1
	.set	noreorder
	.set	nomacro
	j	$L643
	sh	$8,56($sp)
	.set	macro
	.set	reorder

$L644:
	li	$16,5242880			# 0x00500000
	ori	$16,$16,0x5050
	li	$4,240			# 0x000000f0
	li	$5,42			# 0x0000002a
	li	$6,194			# 0x000000c2
	li	$7,85			# 0x00000055
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	li	$4,240			# 0x000000f0
	li	$5,127			# 0x0000007f
	li	$6,194			# 0x000000c2
	li	$7,85			# 0x00000055
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	li	$17,252			# 0x000000fc
	move	$16,$0
$L674:
	sll	$5,$17,16
	sra	$5,$5,16
	li	$6,46			# 0x0000002e
	sll	$7,$16,16
	sra	$7,$7,15
	lhu	$8,48($sp)
	lw	$4,112($sp)
	subu	$7,$8,$7
	sll	$7,$7,16
	.set	noreorder
	.set	nomacro
	jal	DrawVerticalLine__15tScreenUserNamesss
	sra	$7,$7,16
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	addu	$17,$17,28
	.set	macro
	.set	reorder

	move	$16,$0
	lui	$2,%hi(MENUUSERNAME_STARTY) # high
	lui	$4,%hi(menu_kUserNameRows) # high
	lhu	$3,%lo(MENUUSERNAME_STARTY)($2)
	lh	$2,%lo(menu_kUserNameRows)($4)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	blez	$2,$L678
	addu	$21,$3,-3
	.set	macro
	.set	reorder

	move	$17,$4
	li	$5,240			# 0x000000f0
$L692:
	sll	$6,$21,16
	sra	$6,$6,16
	addu	$21,$21,15
	sll	$2,$16,16
	sra	$2,$2,16
	lw	$4,112($sp)
	lh	$7,%lo(menu_kUserNameRows)($17)
	lhu	$8,48($sp)
	subu	$7,$7,$2
	sll	$7,$7,1
	subu	$7,$8,$7
	sll	$7,$7,16
	.set	noreorder
	.set	nomacro
	jal	DrawHorizontalLine__15tScreenUserNamesss
	sra	$7,$7,16
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	lh	$3,%lo(menu_kUserNameRows)($17)
	sra	$2,$2,16
	addu	$3,$3,1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L692
	li	$5,240			# 0x000000f0
	.set	macro
	.set	reorder

$L678:
	lhu	$8,40($sp)
	move	$16,$0
	sll	$2,$8,16
	sra	$17,$2,16
	sll	$4,$16,16
$L693:
	sra	$4,$4,16
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

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L693
	sll	$4,$16,16
	.set	macro
	.set	reorder

	lw	$31,108($sp)
	lw	$fp,104($sp)
	lw	$23,100($sp)
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
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	DrawBackground__15tScreenUserName
	.align	2
	.globl	___15tScreenUserName
	.ent	___15tScreenUserName
___15tScreenUserName:
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

	.end	___15tScreenUserName
	.globl	UserPermFileName
	.data
	.align	2
UserPermFileName:
	.space	20
