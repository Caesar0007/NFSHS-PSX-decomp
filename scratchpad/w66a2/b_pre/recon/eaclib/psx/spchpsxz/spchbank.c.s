	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchbank.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSPCH_InitBanks
	.align	2
	.globl	iSPCH_DisposeBanks
	.rdata
	.align	2
$LC0:
	.ascii	"spch banks\000"
	.text
	.align	2
	.globl	iSPCH_BankMemAlloc
	.align	2
	.globl	iSPCH_GetFreeBank
	.align	2
	.globl	iSPCH_FindBank
	.align	2
	.globl	iSPCH_TestSubBankBounds
	.align	2
	.globl	iSPCH_SetCycleBits
	.align	2
	.globl	SPCH_AddBank

	.text
	.def	iSPCH_InitBanks;	.val	iSPCH_InitBanks;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_InitBanks
iSPCH_InitBanks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gVoxBanks) # high
	sw	$0,%lo(gVoxBanks)($2)
	lui	$2,%hi(gNumBanks) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,%lo(gNumBanks)($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSPCH_InitBanks
	.def	iSPCH_DisposeBanks;	.val	iSPCH_DisposeBanks;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_DisposeBanks
iSPCH_DisposeBanks:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(gVoxBanks) # high
	lw	$4,%lo(gVoxBanks)($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L3
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	iSPCH_MemFree
$L3:
	lw	$31,20($sp)
	sw	$0,%lo(gVoxBanks)($16)
	lw	$16,16($sp)
	lui	$2,%hi(gNumBanks) # high
	sw	$0,%lo(gNumBanks)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_DisposeBanks
	.def	iSPCH_BankMemAlloc;	.val	iSPCH_BankMemAlloc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_BankMemAlloc
iSPCH_BankMemAlloc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	numBanks;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	lui	$16,%hi(gVoxBanks) # high
	lw	$2,%lo(gVoxBanks)($16)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$17,%hi(gNumBanks) # high
	lui	$5,%hi($LC0) # high
	sw	$4,%lo(gNumBanks)($17)
	sll	$4,$4,2
	.set	noreorder
	.set	nomacro
	jal	iSPCH_MemAlloc
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	sw	$2,%lo(gVoxBanks)($16)
	.set	macro
	.set	reorder

	lw	$4,%lo(gNumBanks)($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$4,$L5
	move	$3,$0
	.set	macro
	.set	reorder

	move	$5,$4
	move	$4,$2
$L12:
	sw	$0,0($4)
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L5:
	lui	$2,%hi(gVoxBanks) # high
	lw	$2,%lo(gVoxBanks)($2)
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
LM3:
	.end	iSPCH_BankMemAlloc
	.def	iSPCH_GetFreeBank;	.val	iSPCH_GetFreeBank;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetFreeBank
iSPCH_GetFreeBank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,-1			# 0xffffffff
	lui	$2,%hi(gNumBanks) # high
	lw	$2,%lo(gNumBanks)($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L22
	move	$3,$0
	.set	macro
	.set	reorder

	move	$6,$2
	lui	$2,%hi(gVoxBanks) # high
	lw	$4,%lo(gVoxBanks)($2)
$L18:
	lw	$2,0($4)
	#nop
	bne	$2,$0,$L21
	.set	noreorder
	.set	nomacro
	j	$L22
	move	$5,$3
	.set	macro
	.set	reorder

$L21:
	addu	$3,$3,1
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	addu	$4,$4,4
	.set	macro
	.set	reorder

	.def	done;	.val	$L22;	.scl	6;	.type	0x0;	.endef
$L22:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSPCH_GetFreeBank
	.def	iSPCH_FindBank;	.val	iSPCH_FindBank;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_FindBank
iSPCH_FindBank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	key;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gVoxBanks) # high
	lw	$5,%lo(gVoxBanks)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L25
	lui	$2,%hi(gNumBanks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gNumBanks)($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L25
	move	$3,$0
	.set	macro
	.set	reorder

	andi	$4,$4,0xffff
	move	$6,$2
$L26:
	lw	$2,0($5)
	#nop
	beq	$2,$0,$L29
	lhu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L32
	move	$2,$3
	.set	macro
	.set	reorder

$L29:
	addu	$3,$3,1
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L25:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L32:
	j	$31

	.loc	1 0
LM5:
	.end	iSPCH_FindBank
	.def	iSPCH_TestSubBankBounds;	.val	iSPCH_TestSubBankBounds;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSPCH_TestSubBankBounds
iSPCH_TestSubBankBounds:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	bankIdx;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	subIdx;	.val	5;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gVoxBanks) # high
	lw	$3,%lo(gVoxBanks)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L35
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$4,$L35
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	lw	$4,0($2)
	#nop
	lhu	$3,6($4)
	li	$2,65535			# 0x0000ffff
	beq	$3,$2,$L35
	.set	noreorder
	.set	nomacro
	bltz	$5,$L35
	move	$2,$3
	.set	macro
	.set	reorder

	slt	$6,$5,$2
	.def	ret;	.val	$L35;	.scl	6;	.type	0x0;	.endef
$L35:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	iSPCH_TestSubBankBounds
	.def	iSPCH_SetCycleBits;	.val	iSPCH_SetCycleBits;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_SetCycleBits
iSPCH_SetCycleBits:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	p;	.val	16;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetBankBits
	move	$16,$4
	.set	macro
	.set	reorder

	move	$9,$2
	lbu	$5,0($9)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$5,$L40
	lui	$2,%hi(gGameNum) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gGameNum)($2)
	#nop
	rem	$3,$2,$5
	lbu	$2,3($16)
	#nop
	mult	$3,$2
	mflo	$6
	#nop
	#nop
	div	$6,$6,$5
	addu	$3,$3,1
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	div	$2,$3,$5
	move	$3,$6
	.set	noreorder
	.set	nomacro
	bgez	$6,$L41
	subu	$8,$2,$6
	.set	macro
	.set	reorder

	addu	$3,$6,7
$L41:
	sra	$2,$3,3
	addu	$7,$2,1
	sll	$2,$2,3
	subu	$5,$6,$2
	.set	noreorder
	.set	nomacro
	blez	$8,$L40
	move	$6,$0
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
	li	$10,8			# 0x00000008
	sll	$4,$11,$5
$L48:
	addu	$3,$9,$7
	lbu	$2,0($3)
	addu	$5,$5,1
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$5,$10,$L46
	sb	$2,0($3)
	.set	macro
	.set	reorder

	move	$5,$0
	addu	$7,$7,1
$L46:
	addu	$6,$6,1
	slt	$2,$6,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L48
	sll	$4,$11,$5
	.set	macro
	.set	reorder

$L40:
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
LM7:
	.end	iSPCH_SetCycleBits
	.def	SPCH_AddBank;	.val	SPCH_AddBank;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_AddBank
SPCH_AddBank:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	lui	$18,%hi(gVoxBanks) # high
	lw	$2,%lo(gVoxBanks)($18)
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	li	$16,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L50
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	jal	iSPCH_GetFreeBank
	move	$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$16,$L53
	move	$2,$16
	.set	macro
	.set	reorder

	lbu	$2,2($17)
	#nop
	andi	$2,$2,0x00f0
	beq	$2,$0,$L52
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SetCycleBits
	move	$4,$17
	.set	macro
	.set	reorder

$L52:
	lw	$3,%lo(gVoxBanks)($18)
	sll	$2,$16,2
	addu	$2,$2,$3
	sw	$17,0($2)
$L50:
	move	$2,$16
$L53:
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
LM8:
	.end	SPCH_AddBank
