	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fememcard.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	productCode
	.data
	.align	2
productCode:
	.byte	83
	.byte	76
	.byte	85
	.byte	83
	.byte	45
	.byte	48
	.byte	48
	.byte	56
	.byte	50
	.byte	54
	.byte	0
	.globl	textSysMemCardFail_Index
	.align	2
textSysMemCardFail_Index:
	.word	0
	.word	677
	.word	685
	.word	675
	.word	811
	.word	671
	.word	669
	.text
	.align	2
	.globl	ChecksumData__FP12tMemCardData
	.ent	ChecksumData__FP12tMemCardData
ChecksumData__FP12tMemCardData:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	addu	$4,$16,8
	li	$5,1104			# 0x00000450
	li	$2,5292			# 0x000014ac
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$2,0($16)
	.set	macro
	.set	reorder

	addu	$4,$16,1112
	li	$5,224			# 0x000000e0
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$2,5272($16)
	.set	macro
	.set	reorder

	addu	$4,$16,1336
	li	$5,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$2,5276($16)
	.set	macro
	.set	reorder

	addu	$4,$16,1352
	li	$5,176			# 0x000000b0
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$2,5280($16)
	.set	macro
	.set	reorder

	addu	$4,$16,1528
	li	$5,3740			# 0x00000e9c
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$2,5284($16)
	.set	macro
	.set	reorder

	sw	$2,5288($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ChecksumData__FP12tMemCardData
	.align	2
	.globl	VerifySuccessfulRead__FP12tMemCardData
	.ent	VerifySuccessfulRead__FP12tMemCardData
VerifySuccessfulRead__FP12tMemCardData:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	addu	$4,$17,8
	li	$5,1104			# 0x00000450
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	crc16
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$17,1112
	lw	$3,5272($17)
	li	$5,224			# 0x000000e0
	xor	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	crc16
	sltu	$16,$3,1
	.set	macro
	.set	reorder

	lw	$3,5276($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L615
	andi	$16,$16,0x0001
	.set	macro
	.set	reorder

	move	$16,$0
$L615:
	addu	$4,$17,1336
	.set	noreorder
	.set	nomacro
	jal	crc16
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	lw	$3,5280($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L617
	andi	$16,$16,0x0001
	.set	macro
	.set	reorder

	move	$16,$0
$L617:
	addu	$4,$17,1352
	.set	noreorder
	.set	nomacro
	jal	crc16
	li	$5,176			# 0x000000b0
	.set	macro
	.set	reorder

	lw	$3,5284($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L619
	andi	$16,$16,0x0001
	.set	macro
	.set	reorder

	move	$16,$0
$L619:
	addu	$4,$17,1528
	.set	noreorder
	.set	nomacro
	jal	crc16
	li	$5,3740			# 0x00000e9c
	.set	macro
	.set	reorder

	lw	$3,5288($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L621
	andi	$16,$16,0x0001
	.set	macro
	.set	reorder

	move	$16,$0
$L621:
	lw	$3,0($17)
	li	$2,5292			# 0x000014ac
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L623
	andi	$16,$16,0x0001
	.set	macro
	.set	reorder

	move	$16,$0
$L623:
	move	$2,$16
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

	.end	VerifySuccessfulRead__FP12tMemCardData
	.align	2
	.globl	MakeWayForMemoryCard__Fv
	.ent	MakeWayForMemoryCard__Fv
MakeWayForMemoryCard__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
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

	.end	MakeWayForMemoryCard__Fv
	.align	2
	.globl	BringThatBeatBack__Fv
	.ent	BringThatBeatBack__Fv
BringThatBeatBack__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	addtimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
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

	.end	BringThatBeatBack__Fv
	.align	2
	.globl	Confirm__Fii
	.ent	Confirm__Fii
Confirm__Fii:
	.frame	$sp,208,$31		# vars= 168, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$18,192($sp)
	move	$18,$4
	sw	$20,200($sp)
	move	$20,$5
	sw	$31,204($sp)
	sw	$19,196($sp)
	sw	$17,188($sp)
	.set	noreorder
	.set	nomacro
	jal	BringThatBeatBack__Fv
	sw	$16,184($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,16
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(tDialogYesNoMem_vtable) # high
	lui	$17,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($17)
	addiu	$2,$2,%lo(tDialogYesNoMem_vtable) # low
	sw	$2,96($16)
	addu	$4,$3,720
	lw	$2,112($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	move	$19,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

$L663:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$2,144($16)
	li	$2,658			# 0x00000292
	sw	$2,164($16)
	lui	$2,%hi(frontEnd+832) # high
	sw	$20,160($16)
	sh	$0,136($16)
	lbu	$3,%lo(frontEnd+832)($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L664
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	sh	$0,124($16)
	sh	$2,126($16)
$L664:
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	move	$4,$16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$18,$2,16
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L665
	lui	$2,%hi(CURRENTPLAYER) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(CURRENTPLAYER)($2)
	lw	$16,%lo(FEApp)($17)
	addu	$4,$4,811
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,568
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

$L668:
	lw	$4,%lo(FEApp)($17)
	#nop
	lw	$2,700($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L667
	jal	Redraw__14tFEApplication
	j	$L668
$L667:
	jal	Redraw__14tFEApplication
	.set	noreorder
	.set	nomacro
	j	$L713
	lui	$3,%hi(nomessage) # high
	.set	macro
	.set	reorder

$L665:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L672
	lui	$3,%hi(nomessage) # high
	.set	macro
	.set	reorder

$L713:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L671
	sw	$2,%lo(nomessage)($3)
	.set	macro
	.set	reorder

$L672:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L671
	move	$16,$17
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L677:
	lw	$4,%lo(FEApp)($16)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L714
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	jal	Redraw__14tFEApplication
	j	$L677
$L671:
	lui	$2,%hi(FEApp) # high
$L714:
	lw	$4,%lo(FEApp)($2)
	jal	Redraw__14tFEApplication
	jal	MakeWayForMemoryCard__Fv
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$2,$18
	lw	$31,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	Confirm__Fii
	.align	2
	.globl	OverwriteConfirm__Fv
	.ent	OverwriteConfirm__Fv
OverwriteConfirm__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(CURRENTPLAYER) # high
	lw	$4,%lo(CURRENTPLAYER)($2)
	li	$5,655			# 0x0000028f
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Confirm__Fii
	addu	$4,$4,803
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

	.end	OverwriteConfirm__Fv
	.align	2
	.globl	OverwriteAlwaysYes__Fv
	.ent	OverwriteAlwaysYes__Fv
OverwriteAlwaysYes__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	OverwriteAlwaysYes__Fv
	.align	2
	.globl	FormatConfirm__Fv
	.ent	FormatConfirm__Fv
FormatConfirm__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(CURRENTPLAYER) # high
	lw	$4,%lo(CURRENTPLAYER)($2)
	li	$5,656			# 0x00000290
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Confirm__Fii
	addu	$4,$4,807
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

	.end	FormatConfirm__Fv
	.align	2
	.globl	LoadingProc__Fv
	.ent	LoadingProc__Fv
LoadingProc__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	LoadingProc__Fv
	.align	2
	.globl	LoadingRedrawProc__Fv
	.ent	LoadingRedrawProc__Fv
LoadingRedrawProc__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Redraw__14tFEApplication
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	LoadingRedrawProc__Fv
	.align	2
	.globl	SavingProc__Fv
	.ent	SavingProc__Fv
SavingProc__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Redraw__14tFEApplication
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SavingProc__Fv
	.align	2
	.globl	Init_Memcard__FbT0
	.ent	Init_Memcard__FbT0
Init_Memcard__FbT0:
	.frame	$sp,72,$31		# vars= 40, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,60($sp)
	move	$17,$4
	lui	$4,%hi(MEMCARD_INITIALIZED) # high
	lw	$2,%lo(MEMCARD_INITIALIZED)($4)
	sw	$16,56($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L721
	sw	$31,64($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(MEMCARDFRONTENDISINITTED) # high
	lw	$3,%lo(MEMCARDFRONTENDISINITTED)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L723
	sw	$2,%lo(MEMCARD_INITIALIZED)($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

$L723:
	jal	PAD_restore
	lui	$2,%hi(ticks) # high
	#.set	volatile
	lw	$3,%lo(ticks)($2)
	#.set	novolatile
	move	$4,$2
$L726:
	#.set	volatile
	lw	$2,%lo(ticks)($4)
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	slt	$2,$2,60
	bne	$2,$0,$L726
	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_init
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_getopts
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(productCode) # high
	addiu	$2,$2,%lo(productCode) # low
	sw	$2,20($sp)
	li	$2,512			# 0x00000200
	sh	$2,28($sp)
	li	$2,256			# 0x00000100
	sh	$2,30($sp)
	li	$2,32			# 0x00000020
	sh	$2,32($sp)
	li	$2,96			# 0x00000060
	sh	$2,34($sp)
	lui	$2,%hi(FormatConfirm__Fv) # high
	addiu	$2,$2,%lo(FormatConfirm__Fv) # low
	sw	$0,16($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L728
	sw	$2,36($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(OverwriteAlwaysYes__Fv) # high
	.set	noreorder
	.set	nomacro
	j	$L729
	addiu	$2,$2,%lo(OverwriteAlwaysYes__Fv) # low
	.set	macro
	.set	reorder

$L728:
	lui	$2,%hi(OverwriteConfirm__Fv) # high
	addiu	$2,$2,%lo(OverwriteConfirm__Fv) # low
$L729:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L730
	sw	$2,40($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(LoadingRedrawProc__Fv) # high
	.set	noreorder
	.set	nomacro
	j	$L731
	addiu	$2,$2,%lo(LoadingRedrawProc__Fv) # low
	.set	macro
	.set	reorder

$L730:
	lui	$2,%hi(LoadingProc__Fv) # high
	addiu	$2,$2,%lo(LoadingProc__Fv) # low
$L731:
	sw	$2,44($sp)
	lui	$2,%hi(SavingProc__Fv) # high
	addiu	$2,$2,%lo(SavingProc__Fv) # low
	#.set	volatile
	sw	$2,48($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	MCRD_setopts
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi(Clock_MasterInterruptHandler__Fv) # high
	.set	noreorder
	.set	nomacro
	jal	addtimer
	addiu	$4,$4,%lo(Clock_MasterInterruptHandler__Fv) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	jal	padinit
	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

$L721:
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

	.end	Init_Memcard__FbT0
	.align	2
	.globl	DeInit_Memcard__Fv
	.ent	DeInit_Memcard__Fv
DeInit_Memcard__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$3,%hi(MEMCARD_INITIALIZED) # high
	lw	$2,%lo(MEMCARD_INITIALIZED)($3)
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(Clock_MasterInterruptHandler__Fv) # high
	addiu	$16,$16,%lo(Clock_MasterInterruptHandler__Fv) # low
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	deltimer
	sw	$0,%lo(MEMCARD_INITIALIZED)($3)
	.set	macro
	.set	reorder

	jal	MCRD_restore
	.set	noreorder
	.set	nomacro
	jal	addtimer
	move	$4,$16
	.set	macro
	.set	reorder

	jal	PAD_restore
	lui	$2,%hi(ticks) # high
	move	$3,$2
	#.set	volatile
	lw	$4,%lo(ticks)($3)
	#.set	novolatile
$L736:
	#.set	volatile
	lw	$2,%lo(ticks)($3)
	#.set	novolatile
	#nop
	subu	$2,$2,$4
	slt	$2,$2,192
	bne	$2,$0,$L736
	jal	padinit
	lui	$2,%hi(MEMCARDFRONTENDISINITTED) # high
	lw	$2,%lo(MEMCARDFRONTENDISINITTED)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($2)
	jal	UpdateMusic__14tFEApplication
$L732:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DeInit_Memcard__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"NFS4\000"
	.align	2
$LC1:
	.ascii	"%s%s\000"
	.text
	.align	2
	.globl	Init_MemcardFile__FR12MCRDFILE_defsb
	.ent	Init_MemcardFile__FR12MCRDFILE_defsb
Init_MemcardFile__FR12MCRDFILE_defsb:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,44			# 0x0000002c
	.set	macro
	.set	reorder

	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L740
	sw	$2,0($18)
	.set	macro
	.set	reorder

	lui	$2,%hi(TITLE) # high
	.set	noreorder
	.set	nomacro
	j	$L744
	sb	$0,%lo(TITLE)($2)
	.set	macro
	.set	reorder

$L740:
	sll	$2,$17,16
	sra	$2,$2,16
	xori	$2,$2,0x0005
	sltu	$16,$2,1
	.set	noreorder
	.set	nomacro
	jal	PlayerNameExist__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L742
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,632			# 0x00000278
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	lui	$4,%hi(TITLE) # high
	addiu	$4,$4,%lo(TITLE) # low
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L744
	lui	$2,%hi(TITLE) # high
	.set	macro
	.set	reorder

$L742:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,633			# 0x00000279
	.set	macro
	.set	reorder

	lui	$4,%hi(TITLE) # high
	addiu	$4,$4,%lo(TITLE) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(TITLE) # high
$L744:
	addiu	$2,$2,%lo(TITLE) # low
	sw	$2,4($18)
	li	$2,5376			# 0x00001500
	sw	$2,8($18)
	sw	$0,12($18)
	sw	$0,16($18)
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

	.end	Init_MemcardFile__FR12MCRDFILE_defsb
	.rdata
	.align	2
$LC2:
	.ascii	"%szMem.psh\000"
	.text
	.align	2
	.globl	SaveGame__Fs
	.ent	SaveGame__Fs
SaveGame__Fs:
	.frame	$sp,5880,$31		# vars= 5824, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,5880
	sw	$21,5860($sp)
	move	$21,$4
	move	$6,$0
	li	$9,1			# 0x00000001
	lui	$2,%hi(gPadinfo) # high
	addiu	$8,$2,%lo(gPadinfo) # low
	li	$7,115			# 0x00000073
	lui	$2,%hi(frontEnd) # high
	addiu	$5,$2,%lo(frontEnd) # low
	lui	$2,%hi(CURRENTPLAYER) # high
	sll	$4,$4,16
	sra	$4,$4,16
	lui	$3,%hi(CURRENTLYUSINGMEMCARD) # high
	sw	$4,%lo(CURRENTPLAYER)($2)
	move	$2,$9
	sw	$31,5876($sp)
	sw	$fp,5872($sp)
	sw	$23,5868($sp)
	sw	$22,5864($sp)
	sw	$20,5856($sp)
	sw	$19,5852($sp)
	sw	$18,5848($sp)
	sw	$17,5844($sp)
	sw	$16,5840($sp)
	sw	$2,%lo(CURRENTLYUSINGMEMCARD)($3)
$L749:
	sltu	$2,$0,$6
	sll	$2,$2,5
	addu	$2,$2,$8
	sw	$9,1096($5)
	lbu	$2,5($2)
	#nop
	beq	$2,$7,$L748
	sw	$0,1096($5)
$L748:
	addu	$6,$6,1
	slt	$2,$6,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	addu	$5,$5,4
	.set	macro
	.set	reorder

	addu	$16,$sp,5568
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	sll	$4,$21,16
	sra	$4,$4,16
	addu	$4,$4,630
	lui	$2,%hi(tDialogBase_vtable) # high
	addiu	$2,$2,%lo(tDialogBase_vtable) # low
	sw	$2,5664($sp)
	li	$2,288			# 0x00000120
	sw	$0,5680($sp)
	sh	$0,5678($sp)
	sh	$0,5698($sp)
	sh	$0,5694($sp)
	sh	$0,5692($sp)
	sh	$0,5676($sp)
	sh	$0,5674($sp)
	sh	$0,5672($sp)
	sh	$0,5670($sp)
	sh	$2,128($16)
	li	$2,-1			# 0xffffffff
	sh	$2,100($16)
	lui	$2,%hi(tDialogMessageString_vtable) # high
	addiu	$2,$2,%lo(tDialogMessageString_vtable) # low
	sw	$2,5664($sp)
	li	$2,128			# 0x00000080
	sh	$0,5704($sp)
	sw	$0,5688($sp)
	sw	$0,5716($sp)
	sw	$0,5700($sp)
	sw	$0,5688($sp)
	sw	$2,140($16)
	lui	$2,%hi(tDialogNoInputMessage_vtable) # high
	addiu	$2,$2,%lo(tDialogNoInputMessage_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,5664($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,5712($sp)
	li	$2,50			# 0x00000032
	sh	$0,5692($sp)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sh	$2,5694($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(FEApp) # high
$L770:
	lw	$2,5700($sp)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L769
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($16)
	jal	Redraw__14tFEApplication
	j	$L770
$L769:
	move	$22,$19
	li	$18,651			# 0x0000028b
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	li	$17,21			# 0x00000015
	.set	macro
	.set	reorder

	sll	$16,$21,16
	sra	$16,$16,14
	addu	$16,$16,1
	lui	$2,%hi(nomessage) # high
	sh	$16,5832($sp)
	.set	noreorder
	.set	nomacro
	jal	MakeWayForMemoryCard__Fv
	sw	$0,%lo(nomessage)($2)
	.set	macro
	.set	reorder

	addu	$4,$sp,5720
	sll	$16,$16,16
	sra	$5,$16,16
	.set	noreorder
	.set	nomacro
	jal	Init_MemcardFile__FR12MCRDFILE_defsb
	move	$6,$19
	.set	macro
	.set	reorder

	addu	$2,$sp,16
	sw	$2,5740($sp)
$L773:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L774
	lui	$4,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L773
$L774:
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,1104			# 0x00000450
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	SaveTournament__18tTournamentManagerR15tSaveTournament
	addu	$5,$sp,1368
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	.set	noreorder
	.set	nomacro
	jal	SaveTracks__13tTrackManagerR14tSaveTrackInfo
	addu	$5,$sp,1352
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	SaveCars__11tCarManagerR12tSaveCarInfo
	addu	$5,$sp,1128
	.set	macro
	.set	reorder

	lui	$4,%hi(Stats_gTrackRecords) # high
	addiu	$4,$4,%lo(Stats_gTrackRecords) # low
	addu	$5,$sp,1544
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,3740			# 0x00000e9c
	.set	macro
	.set	reorder

	jal	rand
	addu	$4,$sp,20
	.set	noreorder
	.set	nomacro
	jal	FECheat_SaveBonus__FRUl
	sw	$2,5284($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,5768
	move	$4,$16
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	lui	$2,%hi(Paths_Paths+128) # high
	lhu	$10,5832($sp)
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sll	$17,$10,16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$23,$2
	move	$4,$23
	move	$5,$0
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	shapepointer
	sw	$2,5736($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sw	$2,5744($sp)
	sw	$0,5748($sp)
	.set	noreorder
	.set	nomacro
	jal	ChecksumData__FP12tMemCardData
	sw	$0,5752($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gMemCardInfo) # high
	addiu	$fp,$2,%lo(gMemCardInfo) # low
	sll	$2,$21,16
	sra	$20,$2,14
$L776:
	bne	$19,$0,$L777
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$17,16
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$16,$16,-2
	sltu	$2,$16,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L776
	sll	$2,$16,2
	.set	macro
	.set	reorder

	lui	$10,%hi($L793) # high
	addiu	$10,$10,%lo($L793) # low
	addu	$2,$2,$10
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L793:
	.word	$L790
	.word	$L790
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L790
	.word	$L776
	.word	$L776
	.word	$L790
	.word	$L790
	.word	$L783
	.word	$L790
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L776
	.word	$L781
	.word	$L790
	.text
$L781:
	lw	$2,52($fp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L776
	sra	$4,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_savefile
	addu	$5,$sp,5720
	.set	macro
	.set	reorder

	j	$L776
$L783:
	li	$18,651			# 0x0000028b
	li	$19,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L776
	move	$22,$19
	.set	macro
	.set	reorder

$L790:
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	addu	$4,$20,1
	.set	macro
	.set	reorder

	lw	$3,0($2)
	li	$2,-3			# 0xfffffffd
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L791
	li	$18,669			# 0x0000029d
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L791
	li	$18,805			# 0x00000325
	.set	macro
	.set	reorder

	li	$18,811			# 0x0000032b
$L791:
	.set	noreorder
	.set	nomacro
	j	$L776
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

$L777:
	lhu	$10,5832($sp)
	li	$17,22			# 0x00000016
	sll	$16,$10,16
$L795:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$16,16
	.set	macro
	.set	reorder

	beq	$2,$17,$L796
	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L795
$L796:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$23
	.set	macro
	.set	reorder

	jal	BringThatBeatBack__Fv
	lui	$2,%hi(nomessage) # high
	lw	$2,%lo(nomessage)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L798
	lui	$17,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	sll	$4,$21,16
	sra	$4,$4,16
	lw	$16,%lo(FEApp)($17)
	addu	$4,$18,$4
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,568
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

$L801:
	lw	$4,%lo(FEApp)($17)
	#nop
	lw	$2,700($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L800
	jal	Redraw__14tFEApplication
	j	$L801
$L800:
	jal	Redraw__14tFEApplication
$L798:
	addu	$16,$sp,5568
	move	$4,$16
	lui	$2,%hi(screenMemcard) # high
	lw	$3,%lo(screenMemcard)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	sw	$2,1440($3)
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	jal	Redraw__14tFEApplication
	move	$4,$16
	li	$5,2			# 0x00000002
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$0,%lo(CURRENTLYUSINGMEMCARD)($2)
	.set	macro
	.set	reorder

	move	$2,$22
	lw	$31,5876($sp)
	lw	$fp,5872($sp)
	lw	$23,5868($sp)
	lw	$22,5864($sp)
	lw	$21,5860($sp)
	lw	$20,5856($sp)
	lw	$19,5852($sp)
	lw	$18,5848($sp)
	lw	$17,5844($sp)
	lw	$16,5840($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,5880
	.set	macro
	.set	reorder

	.end	SaveGame__Fs
	.align	2
	.globl	LoadGame__FsbT1
	.ent	LoadGame__FsbT1
LoadGame__FsbT1:
	.frame	$sp,5824,$31		# vars= 5768, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,5824
	move	$7,$4
	sll	$2,$7,16
	sw	$17,5788($sp)
	sra	$17,$2,16
	sll	$2,$17,2
	sw	$19,5796($sp)
	ori	$19,$2,0x0001
	sw	$16,5784($sp)
	addu	$16,$sp,5568
	move	$4,$16
	lui	$2,%hi(CURRENTPLAYER) # high
	lui	$3,%hi(CURRENTLYUSINGMEMCARD) # high
	sw	$17,%lo(CURRENTPLAYER)($2)
	li	$2,1			# 0x00000001
	sw	$31,5820($sp)
	sw	$fp,5816($sp)
	sw	$23,5812($sp)
	sw	$22,5808($sp)
	sw	$21,5804($sp)
	sw	$20,5800($sp)
	sw	$18,5792($sp)
	sw	$5,5828($sp)
	sw	$6,5832($sp)
	sw	$2,%lo(CURRENTLYUSINGMEMCARD)($3)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sh	$7,5768($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(tDialogBase_vtable) # high
	addiu	$2,$2,%lo(tDialogBase_vtable) # low
	sw	$2,5664($sp)
	li	$2,288			# 0x00000120
	sw	$0,5680($sp)
	sh	$0,5678($sp)
	sh	$0,5698($sp)
	sh	$0,5694($sp)
	sh	$0,5692($sp)
	sh	$0,5676($sp)
	sh	$0,5674($sp)
	sh	$0,5672($sp)
	sh	$0,5670($sp)
	sh	$2,128($16)
	li	$2,-1			# 0xffffffff
	sh	$2,100($16)
	lui	$2,%hi(tDialogMessageString_vtable) # high
	addiu	$2,$2,%lo(tDialogMessageString_vtable) # low
	sw	$2,5664($sp)
	li	$2,128			# 0x00000080
	sh	$0,5704($sp)
	sw	$0,5688($sp)
	sw	$0,5716($sp)
	sw	$0,5700($sp)
	sw	$0,5688($sp)
	sw	$2,140($16)
	lui	$2,%hi(tDialogNoInputMessage_vtable) # high
	lw	$8,5832($sp)
	addiu	$2,$2,%lo(tDialogNoInputMessage_vtable) # low
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L821
	sw	$2,5664($sp)
	.set	macro
	.set	reorder

	lw	$9,5828($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L890
	lui	$2,%hi(nomessage) # high
	.set	macro
	.set	reorder

$L821:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$17,630
	.set	macro
	.set	reorder

	lw	$8,5828($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L822
	sw	$2,5712($sp)
	.set	macro
	.set	reorder

	li	$2,50			# 0x00000032
	sh	$0,5692($sp)
	sh	$2,5694($sp)
$L822:
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$16,%hi(FEApp) # high
$L825:
	lw	$2,5700($sp)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L824
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($16)
	jal	Redraw__14tFEApplication
	j	$L825
$L824:
	lw	$4,%lo(FEApp)($2)
	jal	Redraw__14tFEApplication
	lui	$2,%hi(nomessage) # high
$L890:
	move	$17,$0
	move	$20,$17
	lw	$9,5832($sp)
	li	$fp,44			# 0x0000002c
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L828
	sw	$0,%lo(nomessage)($2)
	.set	macro
	.set	reorder

	move	$fp,$17
$L828:
	li	$18,653			# 0x0000028d
	lhu	$8,5768($sp)
	sll	$21,$19,16
	sll	$8,$8,16
	sw	$8,5776($sp)
$L829:
	.set	noreorder
	.set	nomacro
	jal	MakeWayForMemoryCard__Fv
	addu	$fp,$fp,1
	.set	macro
	.set	reorder

	addu	$4,$sp,5720
	sra	$5,$21,16
	.set	noreorder
	.set	nomacro
	jal	Init_MemcardFile__FR12MCRDFILE_defsb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L832:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$21,16
	.set	macro
	.set	reorder

	li	$9,21			# 0x00000015
	.set	noreorder
	.set	nomacro
	bne	$2,$9,$L833
	addu	$2,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L832
$L833:
	lw	$8,5776($sp)
	sw	$2,5740($sp)
	sw	$0,5736($sp)
	sra	$19,$8,16
	sll	$23,$19,3
	sll	$9,$19,2
	lui	$8,%hi(frontEnd) # high
	addiu	$8,$8,%lo(frontEnd) # low
	addu	$22,$9,$8
	sw	$9,5780($sp)
$L835:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L836
	li	$16,22			# 0x00000016
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$21,16
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$16,$16,-2
	sltu	$2,$16,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L835
	sll	$2,$16,2
	.set	macro
	.set	reorder

	lui	$9,%hi($L861) # high
	addiu	$9,$9,%lo($L861) # low
	addu	$2,$2,$9
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L861:
	.word	$L856
	.word	$L856
	.word	$L835
	.word	$L835
	.word	$L835
	.word	$L856
	.word	$L835
	.word	$L835
	.word	$L856
	.word	$L856
	.word	$L835
	.word	$L835
	.word	$L835
	.word	$L841
	.word	$L856
	.word	$L835
	.word	$L835
	.word	$L835
	.word	$L835
	.word	$L835
	.word	$L840
	.word	$L856
	.text
$L840:
	sra	$4,$21,16
	addu	$5,$sp,5720
	.set	noreorder
	.set	nomacro
	jal	MCRD_loadfile
	move	$6,$0
	.set	macro
	.set	reorder

	j	$L835
$L841:
	.set	noreorder
	.set	nomacro
	jal	VerifySuccessfulRead__FP12tMemCardData
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L842
	lw	$8,5828($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L843
	move	$20,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L844
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd) # high
	addiu	$5,$9,%lo(frontEnd) # low
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,1104			# 0x00000450
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	LoadTournament__18tTournamentManagerR15tSaveTournament
	addu	$5,$sp,1368
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	.set	noreorder
	.set	nomacro
	jal	LoadTracks__13tTrackManagerR14tSaveTrackInfo
	addu	$5,$sp,1352
	.set	macro
	.set	reorder

	addu	$4,$sp,1544
	lui	$5,%hi(Stats_gTrackRecords) # high
	addiu	$5,$5,%lo(Stats_gTrackRecords) # low
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,3740			# 0x00000e9c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FECheat_LoadBonus__FRUl
	addu	$4,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L889
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

$L844:
	lui	$4,%hi(frontEnd+868) # high
	addiu	$4,$4,%lo(frontEnd+868) # low
	addu	$4,$23,$4
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$5,$sp,892
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
$L889:
	addiu	$4,$4,%lo(carManager) # low
	lw	$8,5776($sp)
	addu	$5,$sp,1128
	.set	noreorder
	.set	nomacro
	jal	LoadCars__11tCarManagerR12tSaveCarInfos
	sra	$6,$8,16
	.set	macro
	.set	reorder

	j	$L846
$L843:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	addu	$5,$sp,1128
	lw	$2,5284($sp)
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
	sw	$2,1084($22)
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd) # high
	addiu	$9,$9,%lo(frontEnd) # low
	addu	$4,$9,868
	addu	$4,$23,$4
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$5,$sp,892
	.set	macro
	.set	reorder

	lw	$2,1368($sp)
	#nop
	sw	$2,76($22)
$L846:
	.set	noreorder
	.set	nomacro
	jal	SetPads__Fv
	li	$18,653			# 0x0000028d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L835
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L842:
	lw	$8,5832($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L888
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(nomessage) # high
	lw	$2,%lo(nomessage)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L835
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$17,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

	lw	$16,%lo(FEApp)($17)
	addu	$4,$19,809
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,568
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L835
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L856:
	lw	$9,5780($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	addu	$4,$9,1
	.set	macro
	.set	reorder

	lui	$3,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($3)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	lw	$16,0($16)
	li	$2,-2			# 0xfffffffe
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L857
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$18,671			# 0x0000029f
	.set	noreorder
	.set	nomacro
	j	$L888
	li	$20,2			# 0x00000002
	.set	macro
	.set	reorder

$L857:
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L859
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$20,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$L888
	li	$18,811			# 0x0000032b
	.set	macro
	.set	reorder

$L859:
	li	$18,809			# 0x00000329
 #APP
 #NO_APP
$L888:
	.set	noreorder
	.set	nomacro
	j	$L835
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L836:
$L863:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$21,16
	.set	macro
	.set	reorder

	beq	$2,$16,$L864
	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L863
$L864:
	jal	BringThatBeatBack__Fv
	li	$2,653			# 0x0000028d
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L830
	slt	$2,$fp,3
	.set	macro
	.set	reorder

	bne	$2,$0,$L829
$L830:
	lw	$8,5832($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L868
	lui	$2,%hi(nomessage) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(nomessage)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L891
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$17,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

	lhu	$9,5768($sp)
	lw	$16,%lo(FEApp)($17)
	sll	$4,$9,16
	sra	$4,$4,16
	addu	$4,$18,$4
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,568
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,568
	.set	macro
	.set	reorder

$L872:
	lw	$4,%lo(FEApp)($17)
	#nop
	lw	$2,700($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L871
	jal	Redraw__14tFEApplication
	j	$L872
$L871:
	jal	Redraw__14tFEApplication
$L868:
	lui	$2,%hi(frontEnd) # high
$L891:
	lhu	$8,5768($sp)
	addiu	$16,$2,%lo(frontEnd) # low
	sll	$4,$8,16
	sra	$4,$4,16
	addu	$2,$4,$16
	lbu	$5,866($2)
	jal	Front_ResetPSXController__Fii
	lw	$9,5828($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L875
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	lbu	$3,4($16)
	#nop
	bne	$3,$2,$L876
	sb	$0,4($16)
$L876:
	lbu	$3,834($16)
	lui	$2,%hi(gMasterSFXLevel) # high
	sw	$3,%lo(gMasterSFXLevel)($2)
$L875:
	lw	$8,5832($sp)
	#nop
	bne	$8,$0,$L878
	lw	$9,5828($sp)
	#nop
	beq	$9,$0,$L892
$L878:
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$sp,5568
	.set	macro
	.set	reorder

	lw	$8,5832($sp)
$L892:
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L879
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($2)
	jal	Redraw__14tFEApplication
$L879:
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	addu	$4,$sp,5568
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$0,%lo(CURRENTLYUSINGMEMCARD)($2)
	.set	macro
	.set	reorder

	move	$2,$20
	lw	$31,5820($sp)
	lw	$fp,5816($sp)
	lw	$23,5812($sp)
	lw	$22,5808($sp)
	lw	$21,5804($sp)
	lw	$20,5800($sp)
	lw	$19,5796($sp)
	lw	$18,5792($sp)
	lw	$17,5788($sp)
	lw	$16,5784($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,5824
	.set	macro
	.set	reorder

	.end	LoadGame__FsbT1
	.align	2
	.globl	SavePinkSlipsCars__Fss
	.ent	SavePinkSlipsCars__Fss
SavePinkSlipsCars__Fss:
	.frame	$sp,5736,$31		# vars= 5680, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,5736
	sw	$16,5696($sp)
	move	$16,$4
	sw	$fp,5728($sp)
	move	$fp,$16
	sw	$31,5732($sp)
	sw	$23,5724($sp)
	sw	$22,5720($sp)
	sw	$21,5716($sp)
	sw	$20,5712($sp)
	sw	$19,5708($sp)
	sw	$18,5704($sp)
	sw	$17,5700($sp)
	.set	noreorder
	.set	nomacro
	jal	MakeWayForMemoryCard__Fv
	sh	$5,5680($sp)
	.set	macro
	.set	reorder

	sll	$16,$16,16
	sra	$16,$16,16
	sll	$2,$16,2
	addu	$2,$2,1
	move	$19,$0
	move	$21,$19
	move	$18,$19
	addu	$17,$sp,5568
	move	$4,$17
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	sh	$2,5688($sp)
	sll	$2,$2,16
	move	$20,$2
	li	$22,21			# 0x00000015
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	lui	$2,%hi(CURRENTPLAYER) # high
	lui	$3,%hi(CURRENTLYUSINGMEMCARD) # high
	sw	$16,%lo(CURRENTPLAYER)($2)
	li	$2,1			# 0x00000001
	sw	$2,%lo(CURRENTLYUSINGMEMCARD)($3)
	lui	$2,%hi(nomessage) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$0,%lo(nomessage)($2)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$19
	.set	macro
	.set	reorder

	addu	$4,$sp,5632
	sra	$5,$20,16
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Init_MemcardFile__FR12MCRDFILE_defsb
	move	$23,$2
	.set	macro
	.set	reorder

$L894:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$20,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L895
	sll	$2,$fp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L894
$L895:
	sra	$20,$2,16
	lhu	$8,5688($sp)
	addu	$2,$sp,16
	sw	$2,5652($sp)
	sw	$0,5648($sp)
	sll	$17,$8,16
$L897:
	bne	$19,$0,$L898
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$17,16
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$16,$16,-2
	sltu	$2,$16,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L897
	sll	$2,$16,2
	.set	macro
	.set	reorder

	lui	$8,%hi($L939) # high
	addiu	$8,$8,%lo($L939) # low
	addu	$2,$2,$8
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L939:
	.word	$L931
	.word	$L938
	.word	$L897
	.word	$L897
	.word	$L897
	.word	$L938
	.word	$L897
	.word	$L897
	.word	$L938
	.word	$L938
	.word	$L897
	.word	$L897
	.word	$L897
	.word	$L903
	.word	$L931
	.word	$L897
	.word	$L897
	.word	$L897
	.word	$L897
	.word	$L897
	.word	$L902
	.word	$L938
	.text
$L902:
	sra	$4,$17,16
	addu	$5,$sp,5632
	.set	noreorder
	.set	nomacro
	jal	MCRD_loadfile
	move	$6,$0
	.set	macro
	.set	reorder

	j	$L897
$L903:
	.set	noreorder
	.set	nomacro
	jal	VerifySuccessfulRead__FP12tMemCardData
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L904
	sll	$2,$20,2
	.set	macro
	.set	reorder

	lui	$8,%hi(frontEnd) # high
	addiu	$8,$8,%lo(frontEnd) # low
	addu	$2,$2,$8
	lw	$3,1084($2)
	lw	$2,5284($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L905
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L897
	move	$18,$19
	.set	macro
	.set	reorder

$L905:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	addu	$5,$sp,1128
	lhu	$8,5680($sp)
	move	$6,$20
	sll	$7,$8,16
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCars__11tCarManagerR12tSaveCarInfoss
	sra	$7,$7,16
	.set	macro
	.set	reorder

	li	$16,21			# 0x00000015
$L906:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L907
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L906
$L907:
	move	$5,$0
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	shapepointer
	sw	$2,5648($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sw	$2,5656($sp)
	sw	$0,5660($sp)
	.set	noreorder
	.set	nomacro
	jal	ChecksumData__FP12tMemCardData
	sw	$0,5664($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi($L926) # high
	addiu	$22,$2,%lo($L926) # low
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$19,$2,%lo(gMemCardInfo) # low
$L909:
	bne	$21,$0,$L929
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$17,16
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

 #APP
	
	
 #NO_APP
	addu	$16,$16,-2
	sltu	$2,$16,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L909
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$2,$22
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L926:
	.word	$L923
	.word	$L923
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L923
	.word	$L909
	.word	$L909
	.word	$L923
	.word	$L923
	.word	$L916
	.word	$L923
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L909
	.word	$L914
	.word	$L923
	.text
$L914:
	lw	$2,52($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L909
	sra	$4,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	MCRD_savefile
	addu	$5,$sp,5632
	.set	macro
	.set	reorder

	j	$L909
$L916:
	li	$21,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L909
	move	$18,$0
	.set	macro
	.set	reorder

$L923:
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	sll	$4,$20,2
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	addu	$4,$4,1
	.set	macro
	.set	reorder

 #APP
	
 #NO_APP
	lw	$3,0($2)
	li	$2,-3			# 0xfffffffd
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L924
	li	$18,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L924
	li	$18,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$18,4			# 0x00000004
$L924:
	.set	noreorder
	.set	nomacro
	j	$L909
	li	$21,1			# 0x00000001
	.set	macro
	.set	reorder

$L904:
	.set	noreorder
	.set	nomacro
	j	$L929
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

$L931:
	sll	$4,$20,2
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	addu	$4,$4,1
	.set	macro
	.set	reorder

	lw	$3,0($2)
	li	$2,-2			# 0xfffffffe
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L929
	li	$18,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L929
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$18,4			# 0x00000004
$L929:
	.set	noreorder
	.set	nomacro
	j	$L897
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

$L938:
	li	$19,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L897
	li	$18,2			# 0x00000002
	.set	macro
	.set	reorder

$L898:
	lhu	$8,5688($sp)
	li	$17,22			# 0x00000016
	sll	$16,$8,16
$L941:
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	sra	$4,$16,16
	.set	macro
	.set	reorder

	beq	$2,$17,$L942
	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L941
$L942:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$23
	.set	macro
	.set	reorder

	jal	BringThatBeatBack__Fv
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	sw	$0,%lo(CURRENTLYUSINGMEMCARD)($2)
	move	$2,$18
	lw	$31,5732($sp)
	lw	$fp,5728($sp)
	lw	$23,5724($sp)
	lw	$22,5720($sp)
	lw	$21,5716($sp)
	lw	$20,5712($sp)
	lw	$19,5708($sp)
	lw	$18,5704($sp)
	lw	$17,5700($sp)
	lw	$16,5696($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,5736
	.set	macro
	.set	reorder

	.end	SavePinkSlipsCars__Fss
	.align	2
	.globl	SavePinkSlipsCarsWithErrorDialogs__Fsss
	.ent	SavePinkSlipsCarsWithErrorDialogs__Fsss
SavePinkSlipsCarsWithErrorDialogs__Fsss:
	.frame	$sp,1536,$31		# vars= 1480, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,1536
	sw	$18,1504($sp)
	move	$18,$4
	addu	$4,$sp,16
	sw	$17,1500($sp)
	move	$17,$6
	sw	$fp,1528($sp)
	move	$fp,$5
	sw	$31,1532($sp)
	sw	$23,1524($sp)
	sw	$22,1520($sp)
	sw	$21,1516($sp)
	sw	$20,1512($sp)
	sw	$19,1508($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	sw	$16,1496($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,184
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	move	$22,$0
	lui	$19,%hi(FEApp) # high
	addu	$20,$sp,1344
	sll	$2,$18,16
	sra	$21,$2,16
	sll	$23,$17,16
	lui	$2,%hi(tDialogBase_vtable) # high
	addiu	$2,$2,%lo(tDialogBase_vtable) # low
	sw	$2,280($sp)
	li	$2,288			# 0x00000120
	sw	$0,296($sp)
	sh	$0,294($sp)
	sh	$0,314($sp)
	sh	$0,310($sp)
	sh	$0,308($sp)
	sh	$0,292($sp)
	sh	$0,290($sp)
	sh	$0,288($sp)
	sh	$0,286($sp)
	sh	$2,128($16)
	li	$2,-1			# 0xffffffff
	sh	$2,100($16)
	lui	$2,%hi(tDialogMessageString_vtable) # high
	addiu	$2,$2,%lo(tDialogMessageString_vtable) # low
	sw	$2,280($sp)
	li	$2,128			# 0x00000080
	sh	$0,320($sp)
	sw	$0,304($sp)
	sw	$0,332($sp)
	sw	$0,316($sp)
	sw	$0,304($sp)
	sw	$2,140($16)
	lui	$2,%hi(tDialogNoInputMessage_vtable) # high
	addiu	$2,$2,%lo(tDialogNoInputMessage_vtable) # low
	addu	$3,$sp,16
	sw	$2,280($sp)
	li	$2,657			# 0x00000291
	sw	$2,160($3)
	li	$2,658			# 0x00000292
	sw	$2,164($3)
	li	$2,1			# 0x00000001
	sh	$2,136($3)
	sh	$18,100($3)
$L951:
	lw	$4,%lo(FEApp)($19)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L956:
	lw	$4,%lo(FEApp)($19)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L955
	jal	Redraw__14tFEApplication
	j	$L956
$L955:
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$20
	.set	macro
	.set	reorder

	addu	$4,$21,630
	lui	$2,%hi(tDialogBase_vtable) # high
	addiu	$2,$2,%lo(tDialogBase_vtable) # low
	sw	$2,1440($sp)
	li	$2,288			# 0x00000120
	sw	$0,1456($sp)
	sh	$0,1454($sp)
	sh	$0,1474($sp)
	sh	$0,1470($sp)
	sh	$0,1468($sp)
	sh	$0,1452($sp)
	sh	$0,1450($sp)
	sh	$0,1448($sp)
	sh	$0,1446($sp)
	sh	$2,128($20)
	li	$2,-1			# 0xffffffff
	sh	$2,100($20)
	lui	$2,%hi(tDialogMessageString_vtable) # high
	addiu	$2,$2,%lo(tDialogMessageString_vtable) # low
	sw	$2,1440($sp)
	li	$2,128			# 0x00000080
	sh	$0,1480($sp)
	sw	$0,1464($sp)
	sw	$0,1492($sp)
	sw	$0,1476($sp)
	sw	$0,1464($sp)
	sw	$2,140($20)
	lui	$2,%hi(tDialogNoInputMessage_vtable) # high
	addiu	$2,$2,%lo(tDialogNoInputMessage_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,1440($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	sw	$2,1488($sp)
	li	$2,50			# 0x00000032
	sh	$0,1468($sp)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sh	$2,1470($sp)
	.set	macro
	.set	reorder

$L967:
	lw	$2,1476($sp)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L966
	lw	$4,%lo(FEApp)($19)
	jal	Redraw__14tFEApplication
	j	$L967
$L966:
	lw	$4,%lo(FEApp)($19)
	jal	Redraw__14tFEApplication
	move	$4,$21
$L1067:
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCars__Fss
	sra	$5,$23,16
	.set	macro
	.set	reorder

	move	$18,$2
	beq	$18,$0,$L973
	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

$L973:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L971
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1067
	move	$4,$21
	.set	macro
	.set	reorder

$L971:
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$sp,1344
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($19)
	jal	Redraw__14tFEApplication
	beq	$18,$0,$L976
	lw	$4,%lo(FEApp)($19)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	lui	$3,%hi(textSysMemCardFail_Index) # high
	addiu	$3,$3,%lo(textSysMemCardFail_Index) # low
	sll	$2,$18,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,336
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	sll	$2,$fp,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L977
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L978
	li	$4,664			# 0x00000298
	.set	macro
	.set	reorder

	li	$4,665			# 0x00000299
$L978:
	jal	TextSys_Word__Fi
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$sp,840
	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,184
	li	$2,-60			# 0xffffffc4
	sw	$17,144($4)
	sh	$0,308($sp)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sh	$2,310($sp)
	.set	macro
	.set	reorder

$L977:
	addu	$4,$sp,16
	addu	$2,$sp,336
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sw	$2,144($4)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$22,$2,16
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$sp,184
	.set	macro
	.set	reorder

$L976:
	addu	$4,$sp,1344
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L1068
	addu	$4,$sp,184
	.set	macro
	.set	reorder

	bne	$22,$0,$L951
$L1068:
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$2,$18
	lw	$31,1532($sp)
	lw	$fp,1528($sp)
	lw	$23,1524($sp)
	lw	$22,1520($sp)
	lw	$21,1516($sp)
	lw	$20,1512($sp)
	lw	$19,1508($sp)
	lw	$18,1504($sp)
	lw	$17,1500($sp)
	lw	$16,1496($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,1536
	.set	macro
	.set	reorder

	.end	SavePinkSlipsCarsWithErrorDialogs__Fsss

	.lcomm	TITLE,40
	.globl	CURRENTLYUSINGMEMCARD
	.section .bss,"aw",@progbits
	.align	2
CURRENTLYUSINGMEMCARD:
	.space	4
