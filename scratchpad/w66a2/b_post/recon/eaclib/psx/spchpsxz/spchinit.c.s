	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchinit.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	gGameNum
	.globl	gFilterSetting
	.globl	gLastSubTick
	.globl	gDataRate
	.globl	gLastTick
	.section	.bss
	.align	2
gGameNum:
	.space	4
gFilterSetting:
	.space	4
gLastSubTick:
	.space	4
gDataRate:
	.space	4
gLastTick:
	.space	4
	.text
 #NO_APP
	.text
	.align	2
	.globl	iSPCH_MemAlloc
	.align	2
	.globl	iSPCH_MemFree
	.align	2
	.globl	SPCH_Deinit
	.align	2
	.globl	iSPCH_InitInGame
	.align	2
	.globl	SPCH_GetSampleDataRate
	.align	2
	.globl	SPCH_InitBankMem
	.align	2
	.globl	SPCH_Init

	.text
	.def	iSPCH_MemAlloc;	.val	iSPCH_MemAlloc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_MemAlloc
iSPCH_MemAlloc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	numBytes;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tag;	.val	5;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,24
	lui	$2,%hi(gMemAlloc) # high
	lw	$3,%lo(gMemAlloc)($2)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L2
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	$31,$3
$L2:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSPCH_MemAlloc
	.def	iSPCH_MemFree;	.val	iSPCH_MemFree;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_MemFree
iSPCH_MemFree:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(gMemFree) # high
	lw	$2,%lo(gMemFree)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	$31,$2
$L4:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_MemFree
	.def	SPCH_Deinit;	.val	SPCH_Deinit;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SPCH_Deinit
SPCH_Deinit:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$3,24641536			# 0x01780000
	lui	$4,%hi(gSPCH_Initialized) # high
	lw	$2,%lo(gSPCH_Initialized)($4)
	ori	$3,$3,0x9a34
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L6
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gSampleRequest) # high
	sw	$0,%lo(gSampleRequest)($2)
	lui	$2,%hi(gSentenceRuleTest) # high
	sw	$0,%lo(gSentenceRuleTest)($2)
	lui	$2,%hi(gSentenceRuleSet) # high
	sw	$0,%lo(gSPCH_Initialized)($4)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_DisposeBanks
	sw	$0,%lo(gSentenceRuleSet)($2)
	.set	macro
	.set	reorder

	jal	iSPCH_InitEventDat
$L6:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	SPCH_Deinit
	.def	iSPCH_InitInGame;	.val	iSPCH_InitInGame;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_InitInGame
iSPCH_InitInGame:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gVoxInGame) # high
	li	$3,-1			# 0xffffffff
	sw	$3,%lo(gVoxInGame)($2)
	addiu	$2,$2,%lo(gVoxInGame) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,4($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSPCH_InitInGame
	.def	SPCH_GetSampleDataRate;	.val	SPCH_GetSampleDataRate;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_GetSampleDataRate
SPCH_GetSampleDataRate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	numSamples;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	rate;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	channels;	.val	6;	.scl	17;	.type	0x4;	.endef
	mult	$4,$5
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L17
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$4,$4,7
$L17:
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L11
	sra	$3,$4,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L13
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L15
	move	$2,$3
	.set	macro
	.set	reorder

	j	$L16
	.def	div10;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	li	$2,1717960704			# 0x66660000
	ori	$2,$2,0x6667
	mult	$3,$2
	sra	$2,$4,31
	mfhi	$7
	#nop
	#nop
	sra	$3,$7,2
	.set	noreorder
	.set	nomacro
	j	$L13
	subu	$3,$3,$2
	.set	macro
	.set	reorder

	.def	mul27;	.val	$L15;	.scl	6;	.type	0x0;	.endef
$L15:
	li	$2,-1840709632			# 0x92490000
	ori	$2,$2,0x2493
	sll	$3,$3,1
	mult	$3,$2
	mfhi	$7
	#nop
	#nop
	addu	$2,$7,$3
	sra	$2,$2,2
	sra	$3,$3,31
	subu	$3,$2,$3
	.def	done;	.val	$L13;	.scl	6;	.type	0x0;	.endef
$L13:
	move	$2,$3
$L16:
	j	$31

	.loc	1 0
LM5:
	.end	SPCH_GetSampleDataRate
	.def	SPCH_InitBankMem;	.val	SPCH_InitBankMem;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_InitBankMem
SPCH_InitBankMem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	memAllocFn;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memFreeFn;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	numBanks;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	move	$7,$0
	li	$2,24641536			# 0x01780000
	lui	$3,%hi(gSPCH_Initialized) # high
	lw	$3,%lo(gSPCH_Initialized)($3)
	ori	$2,$2,0x9a34
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L19
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	beq	$4,$0,$L19
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L19
	lui	$2,%hi(gMemAlloc) # high
	.set	macro
	.set	reorder

	sw	$4,%lo(gMemAlloc)($2)
	lui	$2,%hi(gMemFree) # high
	move	$4,$6
	.set	noreorder
	.set	nomacro
	jal	iSPCH_BankMemAlloc
	sw	$5,%lo(gMemFree)($2)
	.set	macro
	.set	reorder

	move	$7,$2
$L19:
	lw	$31,16($sp)
	move	$2,$7
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	SPCH_InitBankMem
	.def	SPCH_Init;	.val	SPCH_Init;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_Init
SPCH_Init:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	sampleRequestCb;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	gameNum;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	dataRate;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lui	$2,%hi(gSampleRequest) # high
	sw	$4,%lo(gSampleRequest)($2)
	move	$4,$5
	lui	$2,%hi(gGameNum) # high
	sw	$4,%lo(gGameNum)($2)
	lui	$2,%hi(gDataRate) # high
	sw	$6,%lo(gDataRate)($2)
	lui	$2,%hi(gMemAlloc) # high
	sw	$0,%lo(gMemAlloc)($2)
	lui	$2,%hi(gMemFree) # high
	sw	$0,%lo(gMemFree)($2)
	lui	$2,%hi(gSentenceRuleTest) # high
	sw	$0,%lo(gSentenceRuleTest)($2)
	lui	$2,%hi(gSentenceRuleSet) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_EACseedrandom
	sw	$0,%lo(gSentenceRuleSet)($2)
	.set	macro
	.set	reorder

	jal	iSPCH_ClearChosen
	.set	noreorder
	.set	nomacro
	jal	SPCH_SetPreLoadTicks
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(gFilterSetting) # high
	.set	noreorder
	.set	nomacro
	jal	iSPCH_InitEventDat
	sw	$0,%lo(gFilterSetting)($2)
	.set	macro
	.set	reorder

	jal	iSPCH_InitInGame
	jal	iSPCH_InitBanks
	jal	iSPCH_InitEventQueue
	li	$3,24641536			# 0x01780000
	ori	$3,$3,0x9a34
	lw	$31,16($sp)
	lui	$2,%hi(gSPCH_Initialized) # high
	sw	$3,%lo(gSPCH_Initialized)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	SPCH_Init
