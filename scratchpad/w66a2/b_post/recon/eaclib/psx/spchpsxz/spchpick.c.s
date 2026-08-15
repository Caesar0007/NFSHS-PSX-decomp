	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchpick.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	gSentenceChoice
	.globl	DAT_80148448
	.globl	ispch_gPickSamples
	.globl	gChooseShort
	.globl	ispch_gChoice
	.section	.bss
	.align	2
gSentenceChoice:
	.space	0xc
DAT_80148448:
	.space	0x34
ispch_gPickSamples:
	.space	100
gChooseShort:
	.space	4
ispch_gChoice:
	.space	144
	.text
	.text
 #NO_APP
	.align	2
	.globl	iSPCH_MatchSample
	.align	2
	.globl	iSPCH_GetPhraseBank
	.align	2
	.globl	iSPCH_GetBankBits
	.align	2
	.globl	iSPCH_ClearCycleBit
	.align	2
	.globl	iSPCH_CheckBankBit
	.align	2
	.globl	iSPCH_CheckTemplateSample
	.align	2
	.globl	iSPCH_SampleExists
	.align	2
	.globl	iSPCH_ChooseSamples
	.align	2
	.globl	iSPCH_SampleLength
	.align	2
	.globl	iSPCH_ConvertTime
	.align	2
	.globl	iSPCH_SentenceLength
	.align	2
	.globl	iSPCH_OrderSentences
	.align	2
	.globl	iSPCH_RepeatEvent
	.align	2
	.globl	iSPCH_ShortRuleStatus
	.align	2
	.globl	iSPCH_SentenceGetChoices
	.align	2
	.globl	iSPCH_RandomizeSentencePicks
	.align	2
	.globl	iSPCH_IterateChoice
	.align	2
	.globl	iSPCH_ChooseShortSentence
	.align	2
	.globl	iSPCH_SentenceMakeChoice
	.align	2
	.globl	iSPCH_ConstantRuleSet
	.align	2
	.globl	iSPCH_MakeSampleRequests
	.align	2
	.globl	iSPCH_ClearChosen
	.align	2
	.globl	iSPCH_SaveChosenSentence
	.align	2
	.globl	iSPCH_OneChosen
	.align	2
	.globl	iSPCH_PlayChosen
	.align	2
	.globl	iSPCH_ChooseSentence
	.align	2
	.globl	SPCH_SetPreLoadTicks

	.text
	.def	SampleRequestFn;	.scl	13;	.type	0x91;	.endef
	.def	SentenceRuleSetFn;	.scl	13;	.type	0x91;	.endef
	.def	iSPCH_MatchSample;	.val	iSPCH_MatchSample;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_MatchSample
iSPCH_MatchSample:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	bankIdx;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	sample;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	phraseTemplate;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	paramTable;	.val	23;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$22,40($sp)
	move	$22,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$23,44($sp)
	move	$23,$7
	sw	$31,48($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lb	$20,3($21)
	#nop
	slt	$2,$20,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
	move	$19,$0
	.set	macro
	.set	reorder

	.def	valid_count;	.val	$L3;	.scl	6;	.type	0x0;	.endef
$L3:
	.set	noreorder
	.set	nomacro
	blez	$20,$L4
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$2,$22,$17
$L14:
	lbu	$4,12($2)
	#nop
	sltu	$2,$4,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	move	$19,$0
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	addu	$2,$21,$17
	lbu	$2,4($2)
	sll	$18,$3,$4
	move	$4,$21
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetMatchValue
	andi	$16,$2,0x000f
	.set	macro
	.set	reorder

	and	$2,$18,$2
	beq	$2,$0,$L10
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L11
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$2,$23
	lw	$2,0($2)
	#nop
	and	$2,$18,$2
	beq	$2,$0,$L10
$L11:
	li	$19,1			# 0x00000001
$L10:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L4
	addu	$17,$17,1
	.set	macro
	.set	reorder

	slt	$2,$17,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	addu	$2,$22,$17
	.set	macro
	.set	reorder

	.def	done;	.val	$L4;	.scl	6;	.type	0x0;	.endef
$L4:
	move	$2,$19
	lw	$31,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSPCH_MatchSample
	.def	iSPCH_GetPhraseBank;	.val	iSPCH_GetPhraseBank;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_GetPhraseBank
iSPCH_GetPhraseBank:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	phraseTemplate;	.val	4;	.scl	17;	.type	0x13;	.endef
	.def	paramTable;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	outChoice;	.val	18;	.scl	17;	.type	0x13;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$31,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lhu	$5,0($4)
	lbu	$3,2($4)
	li	$2,-1			# 0xffffffff
	sh	$2,2($18)
	sh	$2,0($18)
	li	$2,1			# 0x00000001
	srl	$4,$3,4
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L17
	andi	$17,$3,0x000f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L19
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$4,$2,$L21
	j	$L22
	.def	byFind;	.val	$L19;	.scl	6;	.type	0x0;	.endef
$L19:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_FindBank
	andi	$4,$5,0xffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L22
	sh	$2,0($18)
	.set	macro
	.set	reorder

	.def	byParam;	.val	$L17;	.scl	6;	.type	0x0;	.endef
$L17:
	sll	$2,$17,2
	addu	$2,$2,$19
	lw	$16,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$16,$L26
	lui	$2,%hi(gVoxBanks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(gVoxBanks)($2)
	sll	$2,$16,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lhu	$3,0($2)
	andi	$2,$5,0xffff
	beq	$3,$2,$L26
	.set	noreorder
	.set	nomacro
	j	$L26
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.def	bySub;	.val	$L21;	.scl	6;	.type	0x0;	.endef
$L21:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_FindBank
	andi	$4,$5,0xffff
	.set	macro
	.set	reorder

	move	$16,$2
	sll	$2,$17,2
	addu	$17,$2,$19
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_TestSubBankBounds
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L25
	lhu	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L26
	sh	$2,2($18)
	.set	macro
	.set	reorder

$L25:
	li	$16,-1			# 0xffffffff
$L26:
	sh	$16,0($18)
	.def	done;	.val	$L22;	.scl	6;	.type	0x0;	.endef
$L22:
	lh	$2,0($18)
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	nor	$2,$0,$2
	srl	$2,$2,31
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_GetPhraseBank
	.def	iSPCH_GetBankBits;	.val	iSPCH_GetBankBits;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetBankBits
iSPCH_GetBankBits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	bank;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,2($4)
	lbu	$3,3($4)
	andi	$2,$2,0x000f
	addu	$2,$2,2
	mult	$3,$2
	addu	$4,$4,8
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSPCH_GetBankBits
	.def	iSPCH_ClearCycleBit;	.val	iSPCH_ClearCycleBit;	.scl	2;	.type	0x6c;	.endef
	.text
	.ent	iSPCH_ClearCycleBit
iSPCH_ClearCycleBit:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	bank;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	cycle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	move	$2,$5
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L29
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$5,7
$L29:
	sra	$2,$2,3
	addu	$17,$2,1
	sll	$2,$2,3
	subu	$2,$5,$2
	li	$16,1			# 0x00000001
	sll	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetBankBits
	nor	$16,$0,$16
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	lbu	$3,0($2)
	#nop
	and	$3,$3,$16
	sb	$3,0($2)
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


	.loc	1 0
LM4:
	.end	iSPCH_ClearCycleBit
	.def	iSPCH_CheckBankBit;	.val	iSPCH_CheckBankBit;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_CheckBankBit
iSPCH_CheckBankBit:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	bank;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	cycle;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L31
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$17,$5,7
$L31:
	sra	$17,$17,3
	sll	$2,$17,3
	subu	$2,$5,$2
	li	$16,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetBankBits
	sll	$16,$16,$2
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	lbu	$2,0($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	and	$2,$2,$16
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSPCH_CheckBankBit
	.def	iSPCH_CheckTemplateSample;	.val	iSPCH_CheckTemplateSample;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_CheckTemplateSample
iSPCH_CheckTemplateSample:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	choice;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	bank;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	base;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lhu	$2,6($5)
	lh	$4,2($4)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	move	$3,$0
	.set	macro
	.set	reorder

	lbu	$2,3($5)
	#nop
	mult	$2,$4
	move	$4,$5
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	iSPCH_CheckBankBit
	addu	$5,$6,$7
	.set	macro
	.set	reorder

	move	$3,$2
$L33:
	lw	$31,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	iSPCH_CheckTemplateSample
	.def	iSPCH_SampleExists;	.val	iSPCH_SampleExists;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_SampleExists
iSPCH_SampleExists:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	choice;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	bankPtr;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	bank;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	lbu	$2,3($16)
	#nop
	slt	$2,$2,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L36
	move	$5,$0
	.set	macro
	.set	reorder

$L35:
	lh	$3,2($4)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L37
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	iSPCH_CheckTemplateSample
	move	$6,$17
	.set	macro
	.set	reorder

	move	$5,$2
$L37:
	lbu	$2,2($16)
	#nop
	andi	$2,$2,0x00f0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSPCH_CheckBankBit
	addu	$5,$17,8
	.set	macro
	.set	reorder

	move	$5,$2
$L36:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	iSPCH_SampleExists
	.def	iSPCH_ChooseSamples;	.val	iSPCH_ChooseSamples;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ChooseSamples
iSPCH_ChooseSamples:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	choice;	.val	22;	.scl	17;	.type	0x13;	.endef
	.def	maxToPick;	.val	30;	.scl	17;	.type	0x4;	.endef
	.def	phraseTemplate;	.val	8;	.scl	9;	.type	0x4;	.endef
	.def	unused;	.val	12;	.scl	9;	.type	0x4;	.endef
	subu	$sp,$sp,72
	sw	$22,56($sp)
	move	$22,$4
	sw	$fp,64($sp)
	move	$fp,$5
	sw	$16,32($sp)
	move	$16,$0
	lui	$2,%hi(gVoxBanks) # high
	sw	$31,68($sp)
	sw	$23,60($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	#.set	volatile
	sw	$6,80($sp)
	#.set	novolatile
	#.set	volatile
	sw	$7,84($sp)
	#.set	novolatile
	lh	$21,0($22)
	lw	$3,%lo(gVoxBanks)($2)
	sll	$2,$21,2
	addu	$2,$2,$3
	lw	$19,0($2)
	#nop
	lbu	$20,3($19)
	lh	$18,6($22)
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L40
	move	$17,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gPickSamples) # high
	addiu	$23,$2,%lo(ispch_gPickSamples) # low
	move	$4,$19
$L49:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	iSPCH_UnPackSample
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	move	$4,$21
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$6,80($sp)
	#.set	novolatile
	#.set	volatile
	lw	$7,84($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	iSPCH_MatchSample
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	move	$4,$22
	.set	macro
	.set	reorder

	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SampleExists
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	addu	$2,$18,$23
	.set	macro
	.set	reorder

	sb	$16,0($2)
	addu	$17,$17,1
	slt	$2,$17,$fp
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L44:
	addu	$16,$16,1
	slt	$2,$16,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L49
	move	$4,$19
	.set	macro
	.set	reorder

$L40:
	move	$2,$17
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSPCH_ChooseSamples
	.def	iSPCH_SampleLength;	.val	iSPCH_SampleLength;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SampleLength
iSPCH_SampleLength:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	choice;	.val	4;	.scl	17;	.type	0x13;	.endef
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$0
	lui	$2,%hi(ispch_gPickSamples) # high
	addiu	$2,$2,%lo(ispch_gPickSamples) # low
	lui	$3,%hi(gVoxBanks) # high
	sw	$31,36($sp)
	lh	$5,8($4)
	lw	$3,%lo(gVoxBanks)($3)
	addu	$5,$5,$2
	lh	$2,0($4)
	lbu	$5,0($5)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_UnPackSample
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$16,16($sp)
	#nop
	move	$2,$16
$L52:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSPCH_SampleLength
	.def	iSPCH_ConvertTime;	.val	iSPCH_ConvertTime;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ConvertTime
iSPCH_ConvertTime:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	samples;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gDataRate) # high
	lw	$3,%lo(gDataRate)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L54
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,2
	div	$5,$2,$3
$L54:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM10:
	.end	iSPCH_ConvertTime
	.def	iSPCH_SentenceLength;	.val	iSPCH_SentenceLength;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SentenceLength
iSPCH_SentenceLength:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$0
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	.set	noreorder
	.set	nomacro
	blez	$19,$L56
	move	$17,$18
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gChoice) # high
	addiu	$16,$2,%lo(ispch_gChoice) # low
$L57:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SampleLength
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$18,$18,$2
	addu	$17,$17,1
	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L57
	addu	$16,$16,12
	.set	macro
	.set	reorder

$L56:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ConvertTime
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


	.loc	1 0
LM11:
	.end	iSPCH_SentenceLength
	.def	iSPCH_OrderSentences;	.val	iSPCH_OrderSentences;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_OrderSentences
iSPCH_OrderSentences:
	.frame	$sp,152,$31		# vars= 104, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	event;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	outOrder;	.val	22;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,152
	sw	$21,140($sp)
	move	$21,$4
	sw	$22,144($sp)
	move	$22,$5
	sw	$18,128($sp)
	move	$18,$0
	sw	$31,148($sp)
	sw	$20,136($sp)
	sw	$19,132($sp)
	sw	$17,124($sp)
	sw	$16,120($sp)
	lbu	$19,6($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L62
	move	$16,$18
	.set	macro
	.set	reorder

	addu	$17,$sp,16
	move	$4,$21
$L85:
	addu	$5,$21,12
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset16
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$2
	lbu	$3,0($4)
	addu	$2,$17,$16
	sb	$3,0($2)
	lbu	$2,0($4)
	addu	$16,$16,1
	addu	$18,$18,$2
	slt	$2,$16,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L85
	move	$4,$21
	.set	macro
	.set	reorder

$L62:
	.set	noreorder
	.set	nomacro
	blez	$18,$L67
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$20,$sp,16
$L68:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_Rand
	move	$4,$18
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L71
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$2,$20,$16
$L87:
	lbu	$2,0($2)
	#nop
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bltz	$3,$L86
	addu	$2,$22,$17
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L87
	addu	$2,$20,$16
	.set	macro
	.set	reorder

$L71:
	addu	$2,$22,$17
$L86:
	sb	$16,0($2)
	addu	$2,$20,$16
	lbu	$3,0($2)
	addu	$17,$17,1
	subu	$18,$18,$3
	.set	noreorder
	.set	nomacro
	bgtz	$18,$L68
	sb	$0,0($2)
	.set	macro
	.set	reorder

$L67:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L79
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$21
$L88:
	addu	$5,$21,12
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset16
	move	$6,$16
	.set	macro
	.set	reorder

	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L83
	addu	$2,$22,$17
	.set	macro
	.set	reorder

	sb	$16,0($2)
	addu	$17,$17,1
$L83:
	addu	$16,$16,1
	slt	$2,$16,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L88
	move	$4,$21
	.set	macro
	.set	reorder

$L79:
	lw	$31,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder


	.loc	1 0
LM12:
	.end	iSPCH_OrderSentences
	.def	iSPCH_RepeatEvent;	.val	iSPCH_RepeatEvent;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_RepeatEvent
iSPCH_RepeatEvent:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	eventArgs;	.val	6;	.scl	17;	.type	0x1d;	.endef
	move	$6,$4
	li	$5,1			# 0x00000001
	lui	$2,%hi(gVoxInGame) # high
	lhu	$4,0($6)
	lw	$3,%lo(gVoxInGame)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L90
	addiu	$2,$2,%lo(gVoxInGame) # low
	.set	macro
	.set	reorder

	lb	$4,8($6)
	#nop
	blez	$4,$L90
	lw	$2,4($2)
	#nop
	slt	$5,$2,$4
$L90:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM13:
	.end	iSPCH_RepeatEvent
	.def	iSPCH_ShortRuleStatus;	.val	iSPCH_ShortRuleStatus;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ShortRuleStatus
iSPCH_ShortRuleStatus:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	mode;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetShortRule
	move	$16,$0
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L99
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$17,$2,$L94
$L99:
	bne	$3,$2,$L95
	bne	$17,$3,$L94
$L95:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L100
	move	$2,$16
	.set	macro
	.set	reorder

	.def	ok1;	.val	$L94;	.scl	6;	.type	0x0;	.endef
$L94:
	li	$16,1			# 0x00000001
	move	$2,$16
$L100:
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


	.loc	1 0
LM14:
	.end	iSPCH_ShortRuleStatus
	.def	iSPCH_SentenceGetChoices;	.val	iSPCH_SentenceGetChoices;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SentenceGetChoices
iSPCH_SentenceGetChoices:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	paramTable;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	ruleByte1;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	ruleByte2;	.val	17;	.scl	17;	.type	0xe;	.endef
	.def	filterMode;	.val	16;	.scl	9;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$21,36($sp)
	move	$21,$4
	sw	$23,44($sp)
	move	$23,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$17,20($sp)
	move	$17,$7
	sw	$20,32($sp)
	li	$20,1			# 0x00000001
	sw	$19,28($sp)
	move	$19,$0
	sw	$31,48($sp)
	sw	$22,40($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	move	$22,$2
	slt	$2,$22,13
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L116
	move	$2,$20
	.set	macro
	.set	reorder

	lw	$5,72($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ShortRuleStatus
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L104
	andi	$4,$16,0x00ff
	.set	macro
	.set	reorder

	andi	$5,$17,0x00ff
	.set	noreorder
	.set	nomacro
	jal	iSPCH_CheckSentenceRules
	move	$6,$21
	.set	macro
	.set	reorder

	bne	$2,$0,$L106
	.def	fail;	.val	$L104;	.scl	6;	.type	0x0;	.endef
$L104:
	.set	noreorder
	.set	nomacro
	j	$L107
	move	$20,$0
	.set	macro
	.set	reorder

	.def	choose;	.val	$L106;	.scl	6;	.type	0x0;	.endef
$L106:
	.set	noreorder
	.set	nomacro
	blez	$22,$L107
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gChoice) # high
	addiu	$16,$2,%lo(ispch_gChoice) # low
$L109:
	sh	$19,6($16)
	move	$4,$21
	addu	$5,$21,4
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset8
	move	$6,$18
	.set	macro
	.set	reorder

	move	$17,$2
	move	$4,$17
	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetPhraseBank
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L112
	move	$4,$16
	.set	macro
	.set	reorder

	lh	$3,0($16)
	li	$2,-2			# 0xfffffffe
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L107
	move	$20,$0
	.set	macro
	.set	reorder

	li	$20,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L107
	sh	$20,0($16)
	.set	macro
	.set	reorder

$L112:
	li	$5,100			# 0x00000064
	subu	$5,$5,$19
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ChooseSamples
	move	$7,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L104
	addu	$19,$19,$2
	.set	macro
	.set	reorder

	sh	$2,4($16)
	addu	$18,$18,1
	slt	$2,$18,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L109
	addu	$16,$16,12
	.set	macro
	.set	reorder

	.def	out;	.val	$L107;	.scl	6;	.type	0x0;	.endef
$L107:
	move	$2,$20
$L116:
	lw	$31,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM15:
	.end	iSPCH_SentenceGetChoices
	.def	iSPCH_RandomizeSentencePicks;	.val	iSPCH_RandomizeSentencePicks;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_RandomizeSentencePicks
iSPCH_RandomizeSentencePicks:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$31,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$22,$2
	.set	noreorder
	.set	nomacro
	blez	$22,$L118
	move	$21,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gPickSamples) # high
	addiu	$23,$2,%lo(ispch_gPickSamples) # low
	lui	$2,%hi(ispch_gChoice) # high
	addiu	$18,$2,%lo(ispch_gChoice) # low
$L119:
	move	$16,$0
	lhu	$2,4($18)
	lh	$3,6($18)
	sll	$2,$2,16
	sra	$20,$2,16
	srl	$2,$2,31
	addu	$2,$20,$2
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	blez	$2,$L122
	addu	$17,$3,$23
	.set	macro
	.set	reorder

	move	$19,$2
$L123:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_Rand
	move	$4,$20
	.set	macro
	.set	reorder

	addu	$4,$17,$16
	addu	$2,$17,$2
	lbu	$5,0($4)
	lbu	$3,0($2)
	addu	$16,$16,1
	sb	$3,0($4)
	sb	$5,0($2)
	slt	$2,$16,$19
	bne	$2,$0,$L123
$L122:
	addu	$21,$21,1
	slt	$2,$21,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L119
	addu	$18,$18,12
	.set	macro
	.set	reorder

$L118:
	lw	$31,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM16:
	.end	iSPCH_RandomizeSentencePicks
	.def	iSPCH_IterateChoice;	.val	iSPCH_IterateChoice;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_IterateChoice
iSPCH_IterateChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$5,$2,-1
	lui	$2,%hi(ispch_gChoice) # high
	addiu	$2,$2,%lo(ispch_gChoice) # low
 #APP
 #NO_APP
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$2
	lh	$4,4($3)
	lh	$2,6($3)
	move	$6,$16
	addu	$4,$2,$4
	.def	top;	.val	$L129;	.scl	6;	.type	0x0;	.endef
$L129:
	lhu	$2,8($3)
	#nop
	addu	$2,$2,1
	sh	$2,8($3)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$4
	beq	$2,$0,$L130
	.set	noreorder
	.set	nomacro
	j	$L131
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L130:
	lhu	$2,6($3)
	addu	$5,$5,-1
	sh	$2,8($3)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L132
	addu	$3,$3,-12
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
	move	$16,$6
$L132:
	lh	$4,4($3)
	lh	$2,6($3)
	#nop
	addu	$4,$2,$4
$L131:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L129
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM17:
	.end	iSPCH_IterateChoice
	.def	iSPCH_ChooseShortSentence;	.val	iSPCH_ChooseShortSentence;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ChooseShortSentence
iSPCH_ChooseShortSentence:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	blez	$5,$L143
	move	$17,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gChoice) # high
	addiu	$3,$2,%lo(ispch_gChoice) # low
$L136:
	lhu	$2,6($3)
	addu	$4,$4,1
	sh	$2,8($3)
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L136
	addu	$3,$3,12
	.set	macro
	.set	reorder

	j	$L143
$L141:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SentenceLength
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetFilterLength
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$16,$16,$2
	beq	$16,$0,$L144
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L143
	move	$16,$17
	.set	macro
	.set	reorder

$L144:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_IterateChoice
	move	$4,$18
	.set	macro
	.set	reorder

	move	$16,$2
$L143:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L148
	move	$2,$17
	.set	macro
	.set	reorder

	beq	$17,$0,$L141
$L148:
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


	.loc	1 0
LM18:
	.end	iSPCH_ChooseShortSentence
	.def	iSPCH_SentenceMakeChoice;	.val	iSPCH_SentenceMakeChoice;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SentenceMakeChoice
iSPCH_SentenceMakeChoice:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	mode;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$0
	li	$2,1			# 0x00000001
	sw	$31,32($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L150
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	jal	iSPCH_RandomizeSentencePicks
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ChooseShortSentence
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L151
	move	$19,$2
	.set	macro
	.set	reorder

$L150:
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	move	$4,$16
	.set	macro
	.set	reorder

	move	$18,$2
	slt	$2,$19,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L151
	move	$17,$0
	.set	macro
	.set	reorder

	li	$19,1			# 0x00000001
	lui	$2,%hi(ispch_gChoice) # high
	addiu	$16,$2,%lo(ispch_gChoice) # low
	.def	top;	.val	$L153;	.scl	6;	.type	0x0;	.endef
$L153:
	lh	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_Rand
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lhu	$3,6($16)
	#nop
	addu	$3,$3,$2
	sh	$3,8($16)
	slt	$2,$17,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L153
	addu	$16,$16,12
	.set	macro
	.set	reorder

$L151:
	move	$2,$19
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


	.loc	1 0
LM19:
	.end	iSPCH_SentenceMakeChoice
	.def	iSPCH_ConstantRuleSet;	.val	iSPCH_ConstantRuleSet;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_ConstantRuleSet
iSPCH_ConstantRuleSet:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	22;	.scl	17;	.type	0x13;	.endef
	.def	rule;	.val	23;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gSentenceRuleSet) # high
	lw	$2,%lo(gSentenceRuleSet)($2)
	subu	$sp,$sp,72
	sw	$22,56($sp)
	move	$22,$4
	sw	$23,60($sp)
	move	$23,$5
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L160
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	move	$4,$23
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	blez	$21,$L160
	move	$19,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gPickSamples) # high
	addiu	$fp,$2,%lo(ispch_gPickSamples) # low
	lui	$2,%hi(ispch_gChoice) # high
	addiu	$18,$2,%lo(ispch_gChoice) # low
$L162:
	move	$4,$23
	addu	$5,$23,4
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset8
	move	$6,$19
	.set	macro
	.set	reorder

	move	$20,$2
	move	$17,$0
	addu	$2,$20,$17
$L184:
	lbu	$2,4($2)
	#nop
	srl	$5,$2,4
	li	$2,15			# 0x0000000f
	beq	$5,$2,$L168
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetRuleID
	move	$4,$22
	.set	macro
	.set	reorder

	addu	$6,$sp,16
	lui	$4,%hi(gVoxBanks) # high
	lh	$3,0($18)
	lw	$4,%lo(gVoxBanks)($4)
	lh	$5,8($18)
	sll	$3,$3,2
	addu	$3,$3,$4
	addu	$5,$5,$fp
	lw	$4,0($3)
	lbu	$5,0($5)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_UnPackSample
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L168
	move	$5,$16
	addu	$3,$sp,$17
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(gSentenceRuleSet) # high
	#.set	volatile
	lhu	$4,0($22)
	#.set	novolatile
	lbu	$6,28($3)
	lw	$2,%lo(gSentenceRuleSet)($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sll	$6,$7,$6
	.set	macro
	.set	reorder

$L168:
	addu	$17,$17,1
	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L184
	addu	$2,$20,$17
	.set	macro
	.set	reorder

	addu	$19,$19,1
	slt	$2,$19,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L162
	addu	$18,$18,12
	.set	macro
	.set	reorder

$L160:
	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM20:
	.end	iSPCH_ConstantRuleSet
	.def	iSPCH_MakeSampleRequests;	.val	iSPCH_MakeSampleRequests;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_MakeSampleRequests
iSPCH_MakeSampleRequests:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	paramTable;	.val	30;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,72
	sw	$fp,64($sp)
	move	$fp,$5
	sw	$20,48($sp)
	move	$20,$0
	sw	$31,68($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	blez	$21,$L186
	move	$19,$20
	.set	macro
	.set	reorder

	lui	$2,%hi(ispch_gPickSamples) # high
	addiu	$23,$2,%lo(ispch_gPickSamples) # low
	lui	$22,%hi(gSampleRequest) # high
	lui	$2,%hi(ispch_gChoice) # high
	addiu	$18,$2,%lo(ispch_gChoice) # low
$L187:
	lui	$3,%hi(gVoxBanks) # high
	lh	$2,0($18)
	lw	$3,%lo(gVoxBanks)($3)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$16,0($2)
	lh	$2,8($18)
	#nop
	addu	$2,$2,$23
	lbu	$3,2($16)
	lbu	$17,0($2)
	andi	$3,$3,0x00f0
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L190
	lui	$2,%hi(gClearCycle) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gClearCycle)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L190
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSPCH_ClearCycleBit
	move	$5,$17
	.set	macro
	.set	reorder

$L190:
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	iSPCH_UnPackSample
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L191
	lhu	$2,4($16)
	lw	$5,20($sp)
	lh	$3,2($18)
	sll	$4,$2,8
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L192
	mult	$3,$4
	.set	macro
	.set	reorder

	mflo	$8
	#nop
	#nop
	addu	$5,$5,$8
$L192:
	move	$7,$fp
	lw	$6,16($sp)
	lh	$4,0($18)
	lw	$2,%lo(gSampleRequest)($22)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$20,$20,$6
	.set	macro
	.set	reorder

$L191:
	addu	$19,$19,1
	slt	$2,$19,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L187
	addu	$18,$18,12
	.set	macro
	.set	reorder

$L186:
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ConvertTime
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$31,68($sp)
	lw	$fp,64($sp)
	lw	$23,60($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM21:
	.end	iSPCH_MakeSampleRequests
	.def	iSPCH_ClearChosen;	.val	iSPCH_ClearChosen;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_ClearChosen
iSPCH_ClearChosen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(DAT_80148448) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,%lo(DAT_80148448)($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM22:
	.end	iSPCH_ClearChosen
	.def	iSPCH_SaveChosenSentence;	.val	iSPCH_SaveChosenSentence;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SaveChosenSentence
iSPCH_SaveChosenSentence:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	paramTable;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	ruleCtx;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	eventArgs;	.val	7;	.scl	17;	.type	0x14;	.endef
	move	$9,$0
	lui	$3,%hi(gSentenceChoice) # high
	addiu	$2,$3,%lo(gSentenceChoice) # low
	move	$8,$2
	sw	$4,%lo(gSentenceChoice)($3)
	sw	$5,4($8)
	sw	$6,8($8)
$L196:
	lw	$2,0($7)
	addu	$7,$7,4
	addu	$9,$9,1
	sw	$2,16($8)
	slt	$2,$9,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L196
	addu	$8,$8,4
	.set	macro
	.set	reorder

	lui	$3,%hi(DAT_80148448) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,%lo(DAT_80148448)($3)
	.set	macro
	.set	reorder


	.loc	1 0
LM23:
	.end	iSPCH_SaveChosenSentence
	.def	iSPCH_OneChosen;	.val	iSPCH_OneChosen;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_OneChosen
iSPCH_OneChosen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(DAT_80148448) # high
	lw	$2,%lo(DAT_80148448)($2)
	j	$31

	.loc	1 0
LM24:
	.end	iSPCH_OneChosen
	.def	iSPCH_PlayChosen;	.val	iSPCH_PlayChosen;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_PlayChosen
iSPCH_PlayChosen:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_OneChosen
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L202
	lui	$16,%hi(gSentenceChoice) # high
	.set	macro
	.set	reorder

	addiu	$17,$16,%lo(gSentenceChoice) # low
	lw	$4,%lo(gSentenceChoice)($16)
	lw	$5,8($17)
	lw	$18,16($17)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_RuleSet
	addu	$6,$17,16
	.set	macro
	.set	reorder

	lw	$4,%lo(gSentenceChoice)($16)
	lw	$5,4($17)
	jal	iSPCH_ConstantRuleSet
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_MakeSampleRequests
	move	$5,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(gVoxInGame) # high
	lw	$2,%lo(gVoxInGame)($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L203
	addiu	$4,$3,%lo(gVoxInGame) # low
	.set	macro
	.set	reorder

	lw	$2,4($4)
	.set	noreorder
	.set	nomacro
	j	$L204
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L203:
	li	$2,1			# 0x00000001
	sw	$18,%lo(gVoxInGame)($3)
$L204:
	sw	$2,4($4)
$L202:
	jal	iSPCH_ClearChosen
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


	.loc	1 0
LM25:
	.end	iSPCH_PlayChosen
	.def	iSPCH_ChooseSentence;	.val	iSPCH_ChooseSentence;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ChooseSentence
iSPCH_ChooseSentence:
	.frame	$sp,176,$31		# vars= 112, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	eventArgs;	.val	23;	.scl	17;	.type	0x1e;	.endef
	subu	$sp,$sp,176
	sw	$23,164($sp)
	move	$23,$4
	sw	$21,156($sp)
	move	$21,$0
	sw	$31,172($sp)
	sw	$fp,168($sp)
	sw	$22,160($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$18,144($sp)
	sw	$17,140($sp)
	sw	$16,136($sp)
	sb	$0,128($sp)
	lw	$4,0($23)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_FindEvent
	move	$18,$21
	.set	macro
	.set	reorder

	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L222
	move	$2,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSPCH_RepeatEvent
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L222
	move	$2,$18
	.set	macro
	.set	reorder

	jal	iSPCH_ClearChosen
	lui	$2,%hi(gFilterSetting) # high
	lw	$20,%lo(gFilterSetting)($2)
	lui	$2,%hi(DAT_80148064) # high
	lw	$3,%lo(DAT_80148064)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L208
	addu	$20,$20,$2
	slt	$2,$20,3
	bne	$2,$0,$L208
	li	$20,2			# 0x00000002
$L208:
	.set	noreorder
	.set	nomacro
	jal	VoxEvent_GetFilterLengthFlag
	move	$4,$19
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L210
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L223
	move	$4,$19
	.set	macro
	.set	reorder

	move	$20,$0
$L210:
	move	$4,$19
$L223:
	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetRuleSettings
	addu	$6,$sp,128
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	iSPCH_OrderSentences
	move	$fp,$2
	.set	macro
	.set	reorder

	lbu	$22,6($19)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$22,$L216
	li	$18,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$18,$0
$L212:
	slt	$2,$21,$22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L216
	addu	$2,$sp,$21
	.set	macro
	.set	reorder

	lbu	$17,24($2)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$17,$L216
	slt	$2,$17,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L216
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$5,$19,12
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset16
	move	$6,$17
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	move	$5,$23
	lbu	$7,128($sp)
	andi	$6,$fp,0x00ff
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SentenceGetChoices
	sw	$20,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L219
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSPCH_SentenceMakeChoice
	move	$5,$20
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L219
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$16
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SaveChosenSentence
	move	$7,$23
	.set	macro
	.set	reorder

$L219:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L212
	addu	$21,$21,1
	.set	macro
	.set	reorder

	.def	out;	.val	$L216;	.scl	6;	.type	0x0;	.endef
$L216:
	move	$2,$18
$L222:
	lw	$31,172($sp)
	lw	$fp,168($sp)
	lw	$23,164($sp)
	lw	$22,160($sp)
	lw	$21,156($sp)
	lw	$20,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder


	.loc	1 0
LM26:
	.end	iSPCH_ChooseSentence
	.def	SPCH_SetPreLoadTicks;	.val	SPCH_SetPreLoadTicks;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SPCH_SetPreLoadTicks
SPCH_SetPreLoadTicks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	ticks;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gPreLoadTicks) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,%lo(gPreLoadTicks)($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM27:
	.end	SPCH_SetPreLoadTicks
