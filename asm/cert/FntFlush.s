	.set noat
	.set noreorder
	.globl	FntFlush
	.type	FntFlush, @function
FntFlush:
	addiu	$29,$29,-0x50
	addiu	$6,$0,0x80
	sw	$6,0x1C($29)
	sw	$6,0x20($29)
	sw	$31,0x4C($29)
	sw	$30,0x48($29)
	sw	$23,0x44($29)
	sw	$22,0x40($29)
	sw	$21,0x3C($29)
	sw	$20,0x38($29)
	sw	$19,0x34($29)
	sw	$18,0x30($29)
	sw	$17,0x2C($29)
	sw	$16,0x28($29)
	sw	$0,0x14($29)
	bltz	$4,.L800F6D74
	sw	$6,0x24($29)
	lui	$2,%hi(D_80135FD8)
	lw	$2,%lo(D_80135FD8)($2)
	nop
	slt	$2,$4,$2
	bnez	$2,.L800F6DAC
	sll	$2,$4,1
.L800F6D74:
	lui	$4,%hi(D_80135FDC)
	lw	$4,%lo(D_80135FDC)($4)
	nop
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,4
	lui	$1,%hi(D_80135E7C)
	addu	$1,$1,$2
	lw	$2,%lo(D_80135E7C)($1)
	nop
	bnez	$2,.L800F6DAC
	sll	$2,$4,1
	j	.L800F7004
	addu	$2,$0,$0
.L800F6DAC:
	addu	$2,$2,$4
	sll	$2,$2,4
	lui	$3,%hi(Font)
	addiu	$3,$3,%lo(Font)
	addu	$19,$2,$3
	addiu	$6,$19,0x10
	sw	$6,0x10($29)
	lw	$4,0x10($29)
	lw	$16,0x24($19)
	lw	$30,0x1C($19)
	lh	$17,0x8($19)
	lh	$21,0xA($19)
	lh	$2,0xC($19)
	lh	$3,0xE($19)
	nop
	addu	$3,$21,$3
	sw	$3,0x18($29)
	lw	$18,0x20($19)
	lw	$22,0x2C($19)
	jal	TermPrim
	addu	$23,$17,$2
	j	.L800F6F94
	nop
.L800F6E08:
	beqz	$30,.L800F6FA4
	sll	$2,$3,24
	sra	$3,$2,24
	addiu	$2,$0,0x20
	beq	$3,$2,.L800F6F38
	addu	$20,$0,$0
	slti	$2,$3,0x21
	beqz	$2,.L800F6E44
	addiu	$2,$0,0x9
	beq	$3,$2,.L800F6EA4
	addiu	$2,$0,0xA
	beq	$3,$2,.L800F6F50
	nop
	j	.L800F6EAC
	nop
.L800F6E44:
	addiu	$2,$0,0x7E
	bne	$3,$2,.L800F6EAC
	addiu	$2,$0,0x63
	addiu	$16,$16,0x1
	lb	$3,0x0($16)
	nop
	bne	$3,$2,.L800F6F54
	nop
	addiu	$16,$16,0x1
	lb	$2,0x0($16)
	addiu	$16,$16,0x1
	lb	$3,0x0($16)
	addiu	$16,$16,0x1
	addiu	$2,$2,-0x30
	sll	$2,$2,4
	addiu	$3,$3,-0x30
	sw	$2,0x1C($29)
	lb	$2,0x0($16)
	sll	$3,$3,4
	sw	$3,0x20($29)
	addiu	$2,$2,-0x30
	sll	$2,$2,4
	j	.L800F6F54
	sw	$2,0x24($29)
.L800F6EA4:
	j	.L800F6F3C
	addiu	$17,$17,0x20
.L800F6EAC:
	lbu	$3,0x0($16)
	nop
	addiu	$2,$3,-0x61
	sltiu	$2,$2,0x1A
	beqz	$2,.L800F6ED0
	sll	$2,$3,24
	sra	$2,$2,24
	j	.L800F6ED8
	addiu	$3,$2,-0x40
.L800F6ED0:
	sra	$2,$2,24
	addiu	$3,$2,-0x20
.L800F6ED8:
	bgez	$3,.L800F6EE4
	addu	$2,$3,$0
	addiu	$2,$3,0xF
.L800F6EE4:
	sra	$4,$2,4
	sll	$2,$4,4
	subu	$2,$3,$2
	sll	$2,$2,3
	sb	$2,0xC($18)
	sll	$2,$4,3
	sb	$2,0xD($18)
	sh	$17,0x8($18)
	sh	$21,0xA($18)
	lbu	$6,0x1C($29)
	addu	$5,$18,$0
	sb	$6,0x4($18)
	lbu	$6,0x20($29)
	nop
	sb	$6,0x5($18)
	lbu	$6,0x24($29)
	nop
	sb	$6,0x6($18)
	lw	$4,0x10($29)
	jal	AddPrim
	addiu	$18,$18,0x10
.L800F6F38:
	addiu	$17,$17,0x8
.L800F6F3C:
	slt	$2,$17,$23
	bnez	$2,.L800F6F54
	nop
	bnez	$22,.L800F6F54
	nop
.L800F6F50:
	addiu	$20,$0,0x1
.L800F6F54:
	beqz	$20,.L800F6F8C
	nop
	lw	$6,0x14($29)
	nop
	slt	$2,$6,$17
	beqz	$2,.L800F6F74
	nop
	sw	$17,0x14($29)
.L800F6F74:
	addiu	$21,$21,0x8
	lw	$6,0x18($29)
	lh	$17,0x8($19)
	slt	$2,$21,$6
	beqz	$2,.L800F6FA4
	nop
.L800F6F8C:
	addiu	$16,$16,0x1
	addiu	$30,$30,-0x1
.L800F6F94:
	lb	$2,0x0($16)
	lbu	$3,0x0($16)
	bnez	$2,.L800F6E08
	nop
.L800F6FA4:
	lbu	$2,0x7($19)
	nop
	beqz	$2,.L800F6FE8
	nop
	lw	$4,0x10($29)
	jal	AddPrim
	addu	$5,$19,$0
	beqz	$22,.L800F6FE8
	nop
	lhu	$2,0x8($19)
	lw	$6,0x14($29)
	lhu	$3,0xA($19)
	subu	$2,$6,$2
	addiu	$3,$3,-0x8
	subu	$3,$21,$3
	sh	$2,0xC($19)
	sh	$3,0xE($19)
.L800F6FE8:
	lw	$4,0x10($29)
	jal	DrawOTag
	nop
	lw	$3,0x24($19)
	lw	$2,0x10($29)
	sw	$0,0x28($19)
	sb	$0,0x0($3)
.L800F7004:
	lw	$31,0x4C($29)
	lw	$30,0x48($29)
	lw	$23,0x44($29)
	lw	$22,0x40($29)
	lw	$21,0x3C($29)
	lw	$20,0x38($29)
	lw	$19,0x34($29)
	lw	$18,0x30($29)
	lw	$17,0x2C($29)
	lw	$16,0x28($29)
	jr	$31
	addiu	$29,$29,0x50
	.size	FntFlush, . - FntFlush
