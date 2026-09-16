	.set noat
	.set noreorder
	.globl	MemCardGetDirentry
	.type	MemCardGetDirentry, @function
MemCardGetDirentry:
	addiu	$29,$29,-0x90
	sw	$23,0x84($29)
	addu	$23,$4,$0
	sw	$16,0x68($29)
	addu	$16,$5,$0
	sw	$22,0x80($29)
	addu	$22,$6,$0
	sw	$19,0x74($29)
	lui	$19,%hi(D_80147518)
	addiu	$19,$19,%lo(D_80147518)
	sw	$31,0x8C($29)
	sw	$30,0x88($29)
	sw	$21,0x7C($29)
	sw	$20,0x78($29)
	sw	$18,0x70($29)
	sw	$17,0x6C($29)
	sw	$7,0x5C($29)
	lw	$2,0x0($19)
	lw	$30,0xA0($29)
	beqz	$2,.L800FB8F0
	addu	$4,$23,$0
	lui	$4,%hi(D_800574C0)
	jal	printf
	addiu	$4,$4,%lo(D_800574C0)
	j	.L800FBAB8
	addiu	$2,$0,-0x1
.L800FB8F0:
	jal	MemCardMakeDevname
	addiu	$5,$29,0x10
	addiu	$4,$29,0x10
	jal	strcat
	addu	$5,$16,$0
	addu	$18,$0,$0
	addu	$17,$0,$0
	addiu	$3,$0,0x1
	sw	$0,0x58($29)
	lw	$4,0xC($19)
	lui	$2,%hi(D_80147514)
	lw	$2,%lo(D_80147514)($2)
	lw	$8,0xA4($29)
	sllv	$3,$3,$4
	or	$2,$2,$3
	lui	$1,%hi(D_80147514)
	sw	$2,%lo(D_80147514)($1)
	addu	$2,$30,$8
	blez	$2,.L800FBAA4
	addu	$21,$0,$0
	addiu	$8,$29,0x50
	sw	$8,0x60($29)
	addu	$20,$0,$0
.L800FB94C:
	bnez	$17,.L800FBA18
	nop
.L800FB954:
	jal	_clr_card_event
	nop
	addiu	$4,$29,0x10
	jal	firstfile
	addiu	$5,$29,0x30
	addu	$16,$2,$0
	bnez	$16,.L800FBA2C
	slt	$2,$17,$30
	jal	_get_card_event_x
	nop
	jal	MemCardEventToRslt
	addu	$4,$2,$0
	beqz	$2,.L800FBA24
	sw	$2,0x58($29)
	addiu	$18,$18,0x1
	slti	$2,$18,0x4
	bnez	$2,.L800FB954
	nop
	jal	MemCardCallback
	addu	$4,$0,$0
	lw	$3,0x0($19)
	lui	$1,%hi(D_8014756C)
	sw	$2,%lo(D_8014756C)($1)
	blez	$3,.L800FB9CC
	addiu	$8,$0,0x2
	lui	$4,%hi(D_80057370)
	jal	printf
	addiu	$4,$4,%lo(D_80057370)
	j	.L800FB9F0
	addu	$4,$0,$0
.L800FB9CC:
	lui	$4,%hi(MemCardCmd_cb)
	addiu	$4,$4,%lo(MemCardCmd_cb)
	sw	$8,0x0($19)
	sw	$0,0x4($19)
	sw	$0,0x8($19)
	lui	$1,%hi(D_80147524)
	jal	UserFuncOpen
	sw	$23,%lo(D_80147524)($1)
	addu	$4,$0,$0
.L800FB9F0:
	addu	$5,$0,$0
	jal	MemCardSync
	addiu	$6,$29,0x58
	lui	$4,%hi(D_8014756C)
	lw	$4,%lo(D_8014756C)($4)
	jal	MemCardCallback
	nop
	lw	$2,0x58($29)
	j	.L800FBAB8
	nop
.L800FBA18:
	jal	nextfile
	addiu	$4,$29,0x30
	addu	$16,$2,$0
.L800FBA24:
	beqz	$16,.L800FBAA4
	slt	$2,$17,$30
.L800FBA2C:
	bnez	$2,.L800FBA8C
	nop
	beqz	$22,.L800FBA8C
	addu	$7,$20,$22
	addiu	$6,$29,0x30
.L800FBA40:
	lw	$2,0x0($6)
	lw	$3,0x4($6)
	lw	$4,0x8($6)
	lw	$5,0xC($6)
	sw	$2,0x0($7)
	sw	$3,0x4($7)
	sw	$4,0x8($7)
	sw	$5,0xC($7)
	addiu	$6,$6,0x10
	lw	$8,0x60($29)
	nop
	bne	$6,$8,.L800FBA40
	addiu	$7,$7,0x10
	lw	$2,0x0($6)
	lw	$3,0x4($6)
	sw	$2,0x0($7)
	sw	$3,0x4($7)
	addiu	$20,$20,0x28
	addiu	$21,$21,0x1
.L800FBA8C:
	lw	$8,0xA4($29)
	addiu	$17,$17,0x1
	addu	$2,$30,$8
	slt	$2,$17,$2
	bnez	$2,.L800FB94C
	nop
.L800FBAA4:
	lw	$8,0x5C($29)
	nop
	beqz	$8,.L800FBAB8
	addu	$2,$0,$0
	sw	$21,0x0($8)
.L800FBAB8:
	lw	$31,0x8C($29)
	lw	$30,0x88($29)
	lw	$23,0x84($29)
	lw	$22,0x80($29)
	lw	$21,0x7C($29)
	lw	$20,0x78($29)
	lw	$19,0x74($29)
	lw	$18,0x70($29)
	lw	$17,0x6C($29)
	lw	$16,0x68($29)
	jr	$31
	addiu	$29,$29,0x90
	.size	MemCardGetDirentry, . - MemCardGetDirentry
