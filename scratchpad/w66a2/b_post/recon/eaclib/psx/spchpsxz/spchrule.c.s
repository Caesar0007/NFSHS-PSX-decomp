	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchrule.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.align	2
	.align	2
	.align	2
	.globl	iSPCH_GetRuleDataAddr
	.align	2
	.globl	iSPCH_SentenceUsesParm
	.align	2
	.globl	iSPCH_GetRuleID
	.align	2
	.globl	iSPCH_RuleSet
	.align	2
	.globl	iSPCH_GetRuleSettings
	.align	2
	.globl	iSPCH_CheckSentenceRules

	.text
	.def	bool;	.scl	13;	.type	0x4;	.endef
	.def	SentenceRuleSetFn;	.scl	13;	.type	0x91;	.endef
	.def	SentenceRuleTestFn;	.scl	13;	.type	0x94;	.endef
	.def	VoxSentence_GetNumPhrases;	.val	VoxSentence_GetNumPhrases;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	VoxSentence_GetNumPhrases
VoxSentence_GetNumPhrases:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,3($4)
	.set	noreorder
	.set	nomacro
	j	$31
	srl	$2,$2,2
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	VoxSentence_GetNumPhrases
	.def	iSPCH_GetOffset8;	.val	iSPCH_GetOffset8;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetOffset8
iSPCH_GetOffset8:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tableBase;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	addu	$5,$5,$6
	lbu	$2,0($5)
	#nop
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_GetOffset8
	.def	iSPCH_GetOffset16;	.val	iSPCH_GetOffset16;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetOffset16
iSPCH_GetOffset16:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tableBase;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$6,$6,1
	addu	$6,$6,$5
	lhu	$2,0($6)
	#nop
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSPCH_GetOffset16
	.def	iSPCH_GetRuleDataAddr;	.val	iSPCH_GetRuleDataAddr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetRuleDataAddr
iSPCH_GetRuleDataAddr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,6($4)
	#nop
	sll	$2,$2,1
	addu	$2,$2,12
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSPCH_GetRuleDataAddr
	.def	iSPCH_SentenceUsesParm;	.val	iSPCH_SentenceUsesParm;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SentenceUsesParm
iSPCH_SentenceUsesParm:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	paramIdx;	.val	20;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$31,36($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	VoxSentence_GetNumPhrases
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$0
	move	$18,$2
	.set	noreorder
	.set	nomacro
	blez	$18,$L11
	move	$17,$16
	.set	macro
	.set	reorder

$L7:
	move	$4,$19
	addu	$5,$19,4
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset8
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$2
	lbu	$2,2($4)
	#nop
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L10
	move	$3,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L11
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L18:
	.set	noreorder
	.set	nomacro
	j	$L13
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

$L10:
	addu	$2,$4,$3
$L19:
	lbu	$2,4($2)
	#nop
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L18
	addu	$3,$3,1
	.set	macro
	.set	reorder

	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	addu	$2,$4,$3
	.set	macro
	.set	reorder

$L13:
	addu	$16,$16,1
	slt	$2,$16,$18
	bne	$2,$0,$L7
	.def	done;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	move	$2,$17
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


	.loc	1 0
LM5:
	.end	iSPCH_SentenceUsesParm
	.def	iSPCH_GetRuleID;	.val	iSPCH_GetRuleID;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_GetRuleID
iSPCH_GetRuleID:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	sentence;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$5
	sw	$16,32($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetRuleDataAddr
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$4,$2
	sltu	$2,$17,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L21
	sll	$3,$17,1
	.set	macro
	.set	reorder

	addu	$3,$3,$4
	lbu	$4,0($3)
	#nop
	#.set	volatile
	sw	$4,16($sp)
	#.set	novolatile
	lbu	$2,1($3)
	#nop
	andi	$2,$2,0x000f
	#.set	volatile
	sw	$2,20($sp)
	#.set	novolatile
	lbu	$2,1($3)
	move	$16,$4
	srl	$2,$2,4
	#.set	volatile
	sw	$2,24($sp)
	#.set	novolatile
$L21:
	move	$2,$16
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


	.loc	1 0
LM6:
	.end	iSPCH_GetRuleID
	.def	iSPCH_RuleSet;	.val	iSPCH_RuleSet;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_RuleSet
iSPCH_RuleSet:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	21;	.scl	17;	.type	0x13;	.endef
	.def	rule;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	values;	.val	8;	.scl	9;	.type	0x14;	.endef
	subu	$sp,$sp,72
	sw	$17,36($sp)
	lui	$17,%hi(gSentenceRuleSet) # high
	lw	$2,%lo(gSentenceRuleSet)($17)
	sw	$21,52($sp)
	move	$21,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	sw	$6,80($sp)
	.set	macro
	.set	reorder

	lb	$20,7($21)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetRuleDataAddr
	move	$18,$0
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$5,$21,12
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset16
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$20,$L23
	move	$22,$2
	.set	macro
	.set	reorder

	lui	$2,%hi($L36) # high
	addiu	$fp,$2,%lo($L36) # low
	move	$23,$17
$L25:
	lbu	$4,0($16)
 #APP
 #NO_APP
	#nop
	#.set	volatile
	sw	$4,16($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$3,1($16)
	#.set	novolatile
	move	$19,$4
	andi	$3,$3,0x000f
	#.set	volatile
	sw	$3,20($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($16)
	#.set	novolatile
	move	$17,$3
	srl	$5,$2,4
	sltu	$2,$5,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	sw	$5,24($sp)
	.set	macro
	.set	reorder

	sll	$2,$5,2
	addu	$2,$2,$fp
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L36:
	.word	$L30
	.word	$L28
	.word	$L28
	.word	$L30
	.word	$L28
	.text
$L30:
	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SentenceUsesParm
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	sll	$2,$17,2
	.set	macro
	.set	reorder

	lw	$7,80($sp)
	lhu	$4,0($21)
	addu	$2,$2,$7
	lw	$6,0($2)
	lw	$2,%lo(gSentenceRuleSet)($23)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$19
	.set	macro
	.set	reorder

$L28:
	addu	$18,$18,1
	slt	$2,$18,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L25
	addu	$16,$16,2
	.set	macro
	.set	reorder

$L23:
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
LM7:
	.end	iSPCH_RuleSet
	.def	iSPCH_GetRuleSettings;	.val	iSPCH_GetRuleSettings;	.scl	2;	.type	0x2c;	.endef
	.text
	.ent	iSPCH_GetRuleSettings
iSPCH_GetRuleSettings:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	sentence;	.val	0;	.scl	9;	.type	0x13;	.endef
	.def	values;	.val	4;	.scl	9;	.type	0x14;	.endef
	.def	out;	.val	8;	.scl	9;	.type	0x12;	.endef
	subu	$sp,$sp,80
	sw	$22,64($sp)
	move	$22,$0
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sw	$4,80($sp)
	sw	$5,84($sp)
	sw	$6,88($sp)
	lb	$7,7($4)
	move	$21,$22
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetRuleDataAddr
	sw	$7,36($sp)
	.set	macro
	.set	reorder

	lw	$7,84($sp)
	li	$20,1			# 0x00000001
	sw	$2,32($sp)
	addu	$23,$7,4
$L39:
	lw	$7,36($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$7,$L42
	move	$18,$0
	.set	macro
	.set	reorder

	move	$fp,$23
	lw	$17,32($sp)
$L43:
	lbu	$2,0($17)
	#nop
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$3,1($17)
	#.set	novolatile
	move	$19,$0
	andi	$3,$3,0x000f
	#.set	volatile
	sw	$3,20($sp)
	#.set	novolatile
	#.set	volatile
	lbu	$2,1($17)
	#.set	novolatile
	#nop
	srl	$2,$2,4
	#.set	volatile
	sw	$2,24($sp)
	#.set	novolatile
	li	$2,12			# 0x0000000c
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L54
	move	$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L56
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L71
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

$L54:
	.set	noreorder
	.set	nomacro
	bne	$4,$20,$L56
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	lw	$6,0($fp)
$L71:
	subu	$2,$2,$18
	li	$3,1			# 0x00000001
	sll	$16,$3,$2
	li	$3,4			# 0x00000004
	#.set	volatile
	lw	$2,24($sp)
	#.set	novolatile
	#.set	volatile
	lw	$5,16($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L59
	lui	$2,%hi(gSentenceRuleTest) # high
	.set	macro
	.set	reorder

	lw	$7,84($sp)
	sll	$2,$4,2
	addu	$2,$2,$7
	lw	$2,0($2)
	#nop
	beq	$2,$0,$L61
$L70:
	.set	noreorder
	.set	nomacro
	j	$L61
	move	$19,$16
	.set	macro
	.set	reorder

$L59:
	lw	$2,%lo(gSentenceRuleTest)($2)
	#nop
	beq	$2,$0,$L62
	lw	$7,80($sp)
	#nop
	lhu	$4,0($7)
	jal	$31,$2
	j	$L63
$L62:
	li	$2,-1			# 0xffffffff
$L63:
	bne	$2,$0,$L64
	.set	noreorder
	.set	nomacro
	j	$L61
	move	$19,$0
	.set	macro
	.set	reorder

$L64:
	bgtz	$2,$L70
	or	$21,$21,$16
$L61:
	or	$22,$22,$19
	.def	next_rule;	.val	$L56;	.scl	6;	.type	0x0;	.endef
$L56:
	lw	$7,36($sp)
	addu	$18,$18,1
	slt	$2,$18,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L43
	addu	$17,$17,2
	.set	macro
	.set	reorder

$L42:
	addu	$20,$20,1
	slt	$2,$20,13
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L39
	addu	$23,$23,4
	.set	macro
	.set	reorder

	lw	$7,88($sp)
	andi	$2,$22,0x00ff
	sb	$21,0($7)
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSPCH_GetRuleSettings
	.def	iSPCH_CheckSentenceRules;	.val	iSPCH_CheckSentenceRules;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_CheckSentenceRules
iSPCH_CheckSentenceRules:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	testVal;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	clearMask;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	rulePtr;	.val	6;	.scl	17;	.type	0x4;	.endef
	nor	$5,$0,$5
	lbu	$3,1($6)
	lbu	$2,2($6)
	and	$3,$3,$5
	xor	$2,$2,$4
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSPCH_CheckSentenceRules
