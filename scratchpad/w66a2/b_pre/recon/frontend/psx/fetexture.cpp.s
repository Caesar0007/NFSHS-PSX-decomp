	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\fetexture.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"unpacked\000"
	.text
	.align	2
	.globl	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
	.align	2
	.globl	FETexture_LoadPmx__FPciP18tTexture_ShapeInfo

	.text
	.text
	.ent	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii:
	.frame	$sp,88,$31		# vars= 32, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$22,80($sp)
	lw	$22,104($sp)
	sw	$19,68($sp)
	move	$19,$6
	sw	$21,76($sp)
	move	$21,$7
	sw	$31,84($sp)
	sw	$20,72($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	sw	$0,48($sp)
	.set	noreorder
	.set	nomacro
	jal	shapepointer
	sw	$0,52($sp)
	.set	macro
	.set	reorder

	move	$18,$2
	beq	$18,$0,$L600
	lbu	$2,0($18)
	#nop
	andi	$20,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L602
	addu	$16,$18,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	unpacksize
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	addu	$5,$2,16
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$17,$2
	move	$4,$18
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	unpack
	addu	$5,$17,16
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	#nop
	andi	$2,$2,0x007f
	sb	$2,0($17)
	lw	$2,0($18)
	lbu	$3,0($17)
	sra	$2,$2,8
	addu	$2,$18,$2
	subu	$2,$2,$17
	sll	$2,$2,8
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L603
	sw	$3,0($17)
	.set	macro
	.set	reorder

$L602:
	move	$17,$18
$L603:
	lbu	$2,0($17)
	#nop
	andi	$4,$2,0x0003
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L604
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_GetClutId__FiPiT1
	addu	$6,$sp,52
	.set	macro
	.set	reorder

	lw	$3,52($sp)
	lw	$2,48($sp)
	sll	$3,$3,6
	sra	$2,$2,4
	andi	$2,$2,0x003f
	or	$3,$3,$2
	sw	$3,4($19)
$L604:
	move	$4,$17
	lw	$8,0($17)
	lw	$9,4($17)
	lw	$10,8($17)
	lw	$11,12($17)
	sw	$8,24($sp)
	sw	$9,28($sp)
	sw	$10,32($sp)
	sw	$11,36($sp)
	lw	$8,16($17)
	sw	$8,40($sp)
	lw	$6,12($17)
	lw	$7,48($sp)
	lw	$2,52($sp)
	sll	$5,$6,20
	sra	$5,$5,20
	addu	$5,$5,$22
	sll	$6,$6,4
	sra	$6,$6,20
	addu	$6,$6,$21
	.set	noreorder
	.set	nomacro
	jal	vramfxya
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	sw	$18,0($19)
	lbu	$2,0($17)
	lw	$3,12($19)
	li	$4,-16777216			# 0xff000000
	sb	$2,9($19)
	lw	$2,0($17)
	and	$3,$3,$4
	srl	$2,$2,8
	or	$3,$3,$2
	sw	$3,12($19)
	lhu	$2,4($17)
	#nop
	sh	$2,16($19)
	lhu	$2,6($17)
	#nop
	sh	$2,18($19)
	lhu	$2,8($17)
	#nop
	sh	$2,20($19)
	lhu	$2,10($17)
	#nop
	sh	$2,22($19)
	lw	$2,12($17)
	#nop
	sll	$2,$2,20
	sra	$2,$2,20
	sh	$2,24($19)
	lw	$2,12($17)
	move	$4,$17
	sll	$2,$2,4
	sra	$2,$2,20
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sh	$2,26($19)
	.set	macro
	.set	reorder

	lw	$5,4($19)
	lbu	$6,9($19)
	lhu	$7,26($19)
	lhu	$3,24($19)
	sb	$2,8($19)
	andi	$4,$5,0x003f
	sll	$4,$4,4
	sra	$5,$5,6
	andi	$6,$6,0x0003
	sll	$6,$6,7
	andi	$2,$7,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	or	$6,$6,$2
	andi	$3,$3,0x03ff
	srl	$3,$3,6
	or	$6,$6,$3
	andi	$7,$7,0x0200
	sll	$7,$7,2
	or	$6,$6,$7
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sh	$6,28($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L606
	sh	$2,30($19)
	.set	macro
	.set	reorder

	beq	$22,$0,$L605
$L606:
	lw	$8,24($sp)
	lw	$9,28($sp)
	lw	$10,32($sp)
	lw	$11,36($sp)
	sw	$8,0($17)
	sw	$9,4($17)
	sw	$10,8($17)
	sw	$11,12($17)
	lw	$8,40($sp)
	sw	$8,16($17)
$L605:
	beq	$20,$0,$L600
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

$L600:
	lw	$31,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
	.text
	.ent	FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
FETexture_LoadPmx__FPciP18tTexture_ShapeInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$7,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
