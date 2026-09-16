	.set noat
	.set noreorder
	.globl	_st_dma
	.type	_st_dma, @function
_st_dma:
	addiu	$29,$29,-0x30
	sw	$16,0x18($29)
	addu	$16,$4,$0
	sw	$18,0x20($29)
	addu	$18,$5,$0
	sw	$19,0x24($29)
	addu	$19,$6,$0
	sw	$20,0x28($29)
	addu	$20,$7,$0
	addu	$4,$0,$0
	sll	$5,$16,4
	lui	$3,(0x1000000 >> 16)
	sw	$31,0x2C($29)
	sw	$17,0x1C($29)
	lui	$2,(0x1F801088 >> 16)
	addu	$2,$2,$5
	lw	$2,(0x1F801088 & 0xFFFF)($2)
	lbu	$17,0x44($29)
	and	$2,$2,$3
	beqz	$2,.L800F8838
	lui	$6,(0x10000 >> 16)
.L800F8814:
	beq	$4,$6,.L800F8860
	nop
	lui	$2,(0x1F801088 >> 16)
	addu	$2,$2,$5
	lw	$2,(0x1F801088 & 0xFFFF)($2)
	nop
	and	$2,$2,$3
	bnez	$2,.L800F8814
	addiu	$4,$4,0x1
.L800F8838:
	addiu	$2,$0,0x1
.L800F883C:
	bne	$17,$2,.L800F8880
	nop
	lui	$3,%hi(D_80136AB4)
	lw	$3,%lo(D_80136AB4)($3)
	nop
	lbu	$4,0x2($3)
	sllv	$2,$2,$16
	j	.L800F8898
	or	$2,$4,$2
.L800F8860:
	lui	$1,(0x1F801088 >> 16)
	addu	$1,$1,$5
	lw	$5,(0x1F801088 & 0xFFFF)($1)
	lui	$4,%hi(D_80057110)
	jal	printf
	addiu	$4,$4,%lo(D_80057110)
	j	.L800F883C
	addiu	$2,$0,0x1
.L800F8880:
	lui	$3,%hi(D_80136AB4)
	lw	$3,%lo(D_80136AB4)($3)
	sllv	$2,$2,$16
	lbu	$4,0x2($3)
	nor	$2,$0,$2
	and	$2,$4,$2
.L800F8898:
	sb	$2,0x2($3)
	lui	$2,%hi(D_80136AB4)
	lw	$2,%lo(D_80136AB4)($2)
	nop
	lw	$2,0x0($2)
	nop
	sw	$2,0x10($29)
	sll	$6,$16,2
	addiu	$6,$6,0x3
	addiu	$3,$0,0x1
	sllv	$3,$3,$6
	lui	$5,(0x1F801080 >> 16)
	ori	$5,$5,(0x1F801080 & 0xFFFF)
	sll	$2,$16,4
	addu	$5,$2,$5
	lui	$4,%hi(D_80136AB0)
	lw	$4,%lo(D_80136AB0)($4)
	sll	$2,$19,16
	lw	$6,0x0($4)
	or	$2,$2,$20
	or	$6,$6,$3
	sw	$6,0x0($4)
	sw	$18,0x0($5)
	addiu	$5,$5,0x4
	sw	$2,0x0($5)
	lui	$3,%hi(D_80136A98)
	lw	$3,%lo(D_80136A98)($3)
	nop
	lbu	$2,0x0($3)
	nop
	andi	$2,$2,0x40
	bnez	$2,.L800F8930
	addiu	$5,$5,0x4
.L800F891C:
	lbu	$2,0x0($3)
	nop
	andi	$2,$2,0x40
	beqz	$2,.L800F891C
	nop
.L800F8930:
	lw	$2,0x40($29)
	nop
	sw	$2,0x0($5)
	lw	$2,0x0($5)
	nop
	sw	$2,0x10($29)
	lw	$31,0x2C($29)
	lw	$20,0x28($29)
	lw	$19,0x24($29)
	lw	$18,0x20($29)
	lw	$17,0x1C($29)
	lw	$16,0x18($29)
	jr	$31
	addiu	$29,$29,0x30
	.size	_st_dma, . - _st_dma
