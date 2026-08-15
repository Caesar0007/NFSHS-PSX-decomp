	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fecheats.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.data
	.align	2
cheatList:
	.byte	89
	.byte	104
	.byte	6
	.byte	6
	.byte	96
	.byte	126
	.byte	127
	.byte	0
	.word	11
	.byte	89
	.byte	88
	.byte	22
	.byte	22
	.byte	96
	.byte	126
	.byte	127
	.byte	0
	.word	12
	.byte	97
	.byte	112
	.byte	14
	.byte	38
	.byte	88
	.byte	126
	.byte	127
	.byte	0
	.word	13
	.byte	27
	.byte	6
	.byte	15
	.byte	23
	.byte	16
	.byte	30
	.byte	31
	.byte	0
	.word	14
	.byte	45
	.byte	65
	.byte	52
	.byte	2
	.byte	80
	.byte	126
	.byte	127
	.byte	0
	.word	19
	.byte	14
	.byte	5
	.byte	1
	.byte	2
	.byte	5
	.byte	14
	.byte	15
	.byte	0
	.word	23
	.byte	36
	.byte	31
	.byte	44
	.byte	28
	.byte	18
	.byte	62
	.byte	63
	.byte	0
	.word	30
	.byte	19
	.byte	41
	.byte	28
	.byte	6
	.byte	41
	.byte	62
	.byte	63
	.byte	0
	.word	29
	.byte	3
	.byte	3
	.byte	15
	.byte	6
	.byte	0
	.byte	14
	.byte	15
	.byte	0
	.word	28
	.byte	30
	.byte	31
	.byte	63
	.byte	27
	.byte	0
	.byte	62
	.byte	63
	.byte	0
	.word	27
	.align	2
bonusList:
	.byte	157
	.byte	153
	.byte	136
	.byte	134
	.byte	147
	.byte	175
	.byte	146
	.byte	255
	.word	20
	.byte	135
	.byte	223
	.byte	223
	.byte	171
	.byte	157
	.byte	143
	.byte	216
	.byte	255
	.word	21
	.byte	246
	.byte	156
	.byte	140
	.byte	159
	.byte	255
	.byte	255
	.byte	191
	.byte	255
	.word	22
	.text
	.align	2
	.globl	FECheat_HandleActivation__F10tCheatCode
	.ent	FECheat_HandleActivation__F10tCheatCode
FECheat_HandleActivation__F10tCheatCode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$5,$4
	sltu	$2,$5,31
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi($L632) # high
	addiu	$2,$2,%lo($L632) # low
	sll	$3,$5,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L632:
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L609
	.word	$L600
	.word	$L600
	.word	$L600
	.word	$L610
	.word	$L600
	.word	$L615
	.word	$L617
	.word	$L600
	.word	$L600
	.word	$L600
	.word	$L600
	.word	$L620
	.word	$L619
	.word	$L600
	.word	$L617
	.word	$L618
	.word	$L600
	.word	$L600
	.word	$L600
	.word	$L629
	.word	$L629
	.word	$L629
	.word	$L629
	.text
$L609:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__11tCarManager13tCarClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L600
$L610:
	move	$16,$0
	sll	$4,$16,16
$L635:
	.set	noreorder
	.set	nomacro
	jal	FECheat_HandleActivation__F10tCheatCode
	sra	$4,$4,16
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	sll	$4,$16,16
	.set	macro
	.set	reorder

	j	$L600
$L615:
	lui	$16,%hi(trackManager) # high
	addiu	$16,$16,%lo(trackManager) # low
	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	move	$6,$5
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L600
$L617:
	lui	$2,%hi(tournamentManager) # high
	addiu	$2,$2,%lo(tournamentManager) # low
	lw	$3,20($2)
	li	$4,50000			# 0x0000c350
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L600
	sw	$3,20($2)
	.set	macro
	.set	reorder

$L618:
	li	$4,99942400			# 0x05f50000
	lui	$3,%hi(tournamentManager) # high
	addiu	$3,$3,%lo(tournamentManager) # low
	lw	$2,20($3)
	ori	$4,$4,0xe100
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L600
	sw	$2,20($3)
	.set	macro
	.set	reorder

$L619:
	lui	$4,%hi(Stats_gTrackRecords) # high
	addiu	$4,$4,%lo(Stats_gTrackRecords) # low
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetAllDefaultRecords__FP13tRecordBufferb
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L600
$L620:
	lui	$3,%hi(gFECheats) # high
	li	$2,-1			# 0xffffffff
	sw	$2,%lo(gFECheats)($3)
	move	$16,$0
	li	$17,19			# 0x00000013
	sll	$2,$16,16
$L637:
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	beq	$4,$17,$L636
	addu	$2,$16,1
	.set	macro
	.set	reorder

	jal	FECheat_HandleActivation__F10tCheatCode
	addu	$2,$16,1
$L636:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,31
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	sll	$2,$16,16
	.set	macro
	.set	reorder

	j	$L600
$L629:
	move	$16,$0
	addu	$4,$5,-27
	lui	$2,%hi(tournamentManager) # high
	addiu	$5,$2,%lo(tournamentManager) # low
$L630:
	sll	$2,$16,16
	sra	$3,$2,16
	slt	$2,$3,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	addu	$2,$3,$5
	.set	macro
	.set	reorder

	sb	$4,496($2)
	.set	noreorder
	.set	nomacro
	j	$L630
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L600:
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

	.end	FECheat_HandleActivation__F10tCheatCode
	.align	2
	.globl	FECheat_EncodeString__FPcT0
	.ent	FECheat_EncodeString__FPcT0
FECheat_EncodeString__FPcT0:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	move	$6,$4
	move	$7,$0
$L639:
	addu	$4,$sp,$7
	addu	$2,$6,$7
	addu	$3,$5,$7
	lbu	$2,0($2)
	addu	$7,$7,1
	sb	$2,0($4)
	slt	$2,$7,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	sb	$0,0($3)
	.set	macro
	.set	reorder

	move	$7,$0
$L643:
	move	$6,$0
	addu	$8,$5,$7
$L646:
	addu	$4,$sp,$6
	lbu	$2,0($4)
	lbu	$3,0($8)
	andi	$2,$2,0x0001
	sll	$2,$2,$6
	or	$3,$3,$2
	sb	$3,0($8)
	lbu	$2,0($4)
	addu	$6,$6,1
	srl	$2,$2,1
	sb	$2,0($4)
	slt	$2,$6,8
	bne	$2,$0,$L646
	addu	$7,$7,1
	slt	$2,$7,8
	bne	$2,$0,$L643
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	FECheat_EncodeString__FPcT0
	.align	2
	.globl	FECheat_EncodeString2__FPcT0
	.ent	FECheat_EncodeString2__FPcT0
FECheat_EncodeString2__FPcT0:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	move	$6,$4
	move	$8,$5
	move	$7,$0
	addu	$4,$6,$7
$L666:
	lbu	$2,0($4)
	addu	$3,$sp,$7
	nor	$2,$0,$2
	sb	$2,0($3)
	addu	$3,$8,$7
	lbu	$2,0($4)
	addu	$7,$7,1
	nor	$2,$0,$2
	sb	$2,0($3)
	slt	$2,$7,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L666
	addu	$4,$6,$7
	.set	macro
	.set	reorder

	move	$7,$0
$L657:
	lbu	$3,0($8)
	addu	$4,$8,$7
	sra	$2,$3,$7
	andi	$2,$2,0x0001
	sll	$2,$2,$7
	xor	$3,$3,$2
	sb	$3,0($8)
	lbu	$3,0($4)
	#nop
	sra	$2,$3,$7
	andi	$2,$2,0x0001
	sll	$2,$2,$7
	xor	$3,$3,$2
	addu	$2,$sp,$7
	sb	$3,0($4)
	lbu	$2,0($2)
	lbu	$3,0($8)
	sra	$2,$2,$7
	andi	$2,$2,0x0001
	sll	$2,$2,$7
	or	$3,$3,$2
	sb	$3,0($8)
	lbu	$2,0($sp)
	lbu	$3,0($4)
	sra	$2,$2,$7
	andi	$2,$2,0x0001
	sll	$2,$2,$7
	addu	$7,$7,1
	or	$3,$3,$2
	slt	$2,$7,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L657
	sb	$3,0($4)
	.set	macro
	.set	reorder

	li	$7,1			# 0x00000001
$L661:
	addu	$6,$8,$7
	addu	$4,$7,-1
	lbu	$2,0($6)
	addu	$5,$sp,$7
	andi	$2,$2,0x00fe
	sb	$2,0($6)
	andi	$3,$2,0x00ff
	sra	$2,$3,$4
	andi	$2,$2,0x0001
	sll	$2,$2,$4
	xor	$3,$3,$2
	sb	$3,0($6)
	lbu	$2,0($5)
	#nop
	sra	$2,$2,$4
	andi	$2,$2,0x0001
	or	$3,$3,$2
	sb	$3,0($6)
	lbu	$2,0($5)
	addu	$7,$7,1
	andi	$2,$2,0x0001
	sll	$2,$2,$4
	or	$3,$3,$2
	slt	$2,$7,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L661
	sb	$3,0($6)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	FECheat_EncodeString2__FPcT0
	.align	2
	.globl	FECheat_ActivateBonus__F10tCheatCode
	.ent	FECheat_ActivateBonus__F10tCheatCode
FECheat_ActivateBonus__F10tCheatCode:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FECheat_HandleActivation__F10tCheatCode
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$4,%hi(gFEBonus) # high
	li	$2,1			# 0x00000001
	sll	$2,$2,$16
	lw	$3,%lo(gFEBonus)($4)
	lw	$31,20($sp)
	lw	$16,16($sp)
	or	$3,$3,$2
	sw	$3,%lo(gFEBonus)($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FECheat_ActivateBonus__F10tCheatCode
	.align	2
	.globl	FECheat_ActivateCheat__FPc
	.ent	FECheat_ActivateCheat__FPc
FECheat_ActivateCheat__FPc:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$0
	addu	$5,$sp,16
	sw	$31,36($sp)
	sw	$18,32($sp)
	.set	noreorder
	.set	nomacro
	jal	FECheat_EncodeString__FPcT0
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$18,$17
	lui	$2,%hi(cheatList) # high
	addiu	$8,$2,%lo(cheatList) # low
	addu	$7,$sp,16
	move	$6,$17
$L672:
	slt	$2,$18,10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$2,$5,$6
$L684:
	addu	$2,$2,$8
	addu	$3,$7,$5
	lbu	$4,0($2)
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L683
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$5,$5,1
	slt	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	addu	$2,$5,$6
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
$L683:
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L680
	addu	$6,$6,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L672
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L680:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

	lui	$17,%hi(FEApp) # high
	lw	$16,%lo(FEApp)($17)
	li	$4,634			# 0x0000027a
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

	lui	$2,%hi(cheatList) # high
	addiu	$2,$2,%lo(cheatList) # low
	sll	$16,$18,1
	addu	$16,$16,$18
	sll	$16,$16,2
	addu	$16,$16,$2
	lw	$4,8($16)
	.set	noreorder
	.set	nomacro
	jal	FECheat_HandleActivation__F10tCheatCode
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi(gFECheats) # high
	lw	$2,8($16)
	lw	$3,%lo(gFECheats)($4)
	sll	$2,$17,$2
	or	$3,$3,$2
	sw	$3,%lo(gFECheats)($4)
$L671:
	move	$2,$17
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

	.end	FECheat_ActivateCheat__FPc
	.align	2
	.globl	FECheat_IsCheatEnabled__F10tCheatCode
	.ent	FECheat_IsCheatEnabled__F10tCheatCode
FECheat_IsCheatEnabled__F10tCheatCode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gFECheats) # high
	lui	$3,%hi(gFEBonus) # high
	lw	$2,%lo(gFECheats)($2)
	lw	$3,%lo(gFEBonus)($3)
	#nop
	or	$2,$2,$3
	li	$3,1			# 0x00000001
	sll	$3,$3,$4
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

	.end	FECheat_IsCheatEnabled__F10tCheatCode
	.align	2
	.globl	FECheat_SaveBonus__FRUl
	.ent	FECheat_SaveBonus__FRUl
FECheat_SaveBonus__FRUl:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gFEBonus) # high
	lw	$2,%lo(gFEBonus)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder

	.end	FECheat_SaveBonus__FRUl
	.align	2
	.globl	FECheat_LoadBonus__FRUl
	.ent	FECheat_LoadBonus__FRUl
FECheat_LoadBonus__FRUl:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$0
	lui	$2,%hi(gFEBonus) # high
	sw	$17,20($sp)
	move	$17,$2
	sw	$18,24($sp)
	li	$18,1			# 0x00000001
	sw	$31,28($sp)
	lw	$3,0($4)
	lui	$2,%hi(gFECheats) # high
	sw	$0,%lo(gFECheats)($2)
	sw	$3,%lo(gFEBonus)($17)
$L690:
	lw	$2,%lo(gFEBonus)($17)
	sll	$3,$18,$16
	and	$2,$2,$3
	beq	$2,$0,$L693
	.set	noreorder
	.set	nomacro
	jal	FECheat_HandleActivation__F10tCheatCode
	move	$4,$16
	.set	macro
	.set	reorder

$L693:
	addu	$16,$16,1
	slt	$2,$16,31
	bne	$2,$0,$L690
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

	.end	FECheat_LoadBonus__FRUl
	.align	2
	.globl	FECheat_IsTheUserACryBabyCheater__Fv
	.ent	FECheat_IsTheUserACryBabyCheater__Fv
FECheat_IsTheUserACryBabyCheater__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gFECheats) # high
	lw	$2,%lo(gFECheats)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

	.end	FECheat_IsTheUserACryBabyCheater__Fv
	.align	2
	.globl	FECheat_ActivateBonusByCode__FPc
	.ent	FECheat_ActivateBonusByCode__FPc
FECheat_ActivateBonusByCode__FPc:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$0
	addu	$5,$sp,16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	FECheat_EncodeString2__FPcT0
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$7,$17
	addu	$8,$sp,16
	lui	$2,%hi(bonusList) # high
	addiu	$9,$2,%lo(bonusList) # low
	move	$16,$9
	move	$6,$17
$L699:
	move	$5,$0
	addu	$2,$5,$6
$L713:
	addu	$2,$2,$9
	addu	$3,$8,$5
	lbu	$4,0($2)
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L712
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$5,$5,1
	slt	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L713
	addu	$2,$5,$6
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
$L712:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L708
	addu	$7,$7,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

	lw	$4,8($16)
	.set	noreorder
	.set	nomacro
	jal	FECheat_ActivateBonus__F10tCheatCode
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L711
	move	$2,$17
	.set	macro
	.set	reorder

$L708:
	addu	$16,$16,12
	slt	$2,$7,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	addu	$6,$6,12
	.set	macro
	.set	reorder

	move	$2,$17
$L711:
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

	.end	FECheat_ActivateBonusByCode__FPc
