	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\movf.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
 #APP
		.globl	windowbuf
	.globl	currentwindow
	.section	.bss
	.align	2
windowbuf:
	.space	312
currentwindow:
	.space	156
	.text
 #NO_APP
	.align	2
	.globl	movfxya

	.extern	nextprim, 4
	.extern	primptr, 4
	.extern	semitrans, 4

	.text
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	.0fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	x;	.val	0;	.scl	8;	.type	0x3;	.endef
	.def	y;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	w;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	h;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.0fake;	.size	8;	.endef
	.def	RECT;	.scl	13;	.tag	.0fake;	.size	8;	.type	0x8;	.endef
	.def	movfxya;	.val	movfxya;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	movfxya
movfxya:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	shape;	.val	22;	.scl	17;	.type	0x1c;	.endef
	.def	x;	.val	4;	.scl	9;	.type	0x4;	.endef
	.def	y;	.val	8;	.scl	9;	.type	0x4;	.endef
	subu	$sp,$sp,80
	sw	$22,64($sp)
	move	$22,$4
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sw	$5,84($sp)
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sw	$6,88($sp)
	.set	macro
	.set	reorder

	lbu	$3,0($22)
	move	$21,$2
	andi	$2,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	andi	$3,$3,0x0003
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	bne	$3,$2,$L3
	lw	$2,semitrans
	#nop
	andi	$2,$2,0x0002
	bne	$2,$0,$L3
	lw	$5,84($sp)
	lw	$6,88($sp)
	.set	noreorder
	.set	nomacro
	jal	fastmovfxya
	move	$4,$22
	.set	macro
	.set	reorder

	j	$L21
$L3:
	lh	$2,6($22)
	lhu	$3,6($22)
	.set	noreorder
	.set	nomacro
	blez	$2,$L21
	move	$7,$0
	.set	macro
	.set	reorder

$L8:
	lw	$2,12($22)
	#nop
	sll	$2,$2,4
	sra	$2,$2,20
	addu	$4,$2,$7
	andi	$fp,$4,0x00ff
	li	$2,255			# 0x000000ff
	subu	$6,$2,$fp
	sll	$2,$3,16
	sra	$2,$2,16
	subu	$3,$2,$7
	slt	$2,$3,$6
	beq	$2,$0,$L9
	move	$6,$3
$L9:
	lh	$2,4($22)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L10
	move	$19,$0
	.set	macro
	.set	reorder

	andi	$2,$4,0x0100
	lw	$9,88($sp)
	sra	$8,$2,4
	addu	$23,$7,$9
	mult	$19,$21
$L23:
	lw	$2,12($22)
	#nop
	sll	$2,$2,20
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L14
	sra	$5,$2,20
	.set	macro
	.set	reorder

	addu	$4,$4,15
$L14:
	sll	$3,$5,4
	div	$3,$3,$21
	sra	$2,$4,4
	addu	$20,$5,$2
	li	$2,-64			# 0xffffffc0
	and	$2,$20,$2
	sll	$2,$2,4
	div	$2,$2,$21
	addu	$3,$3,$19
	subu	$18,$3,$2
	lh	$3,4($22)
	li	$2,255			# 0x000000ff
	subu	$17,$2,$18
	subu	$3,$3,$19
	slt	$2,$3,$17
	beq	$2,$0,$L15
	move	$17,$3
$L15:
	lw	$16,primptr
	#nop
	addu	$2,$16,40
	sw	$2,primptr
	li	$2,9			# 0x00000009
	sb	$2,3($16)
	li	$2,44			# 0x0000002c
	sb	$2,7($16)
	lbu	$2,semitrans
	move	$4,$22
	ori	$2,$2,0x002c
	sb	$2,7($16)
	sw	$6,24($sp)
	sw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	shapetoclutid
	sw	$8,32($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	sh	$2,14($16)
	lbu	$3,0($22)
	addu	$4,$18,$5
	sb	$18,12($16)
	sb	$fp,13($16)
	sb	$4,20($16)
	sb	$fp,21($16)
	sb	$18,28($16)
	lw	$6,24($sp)
	sb	$4,36($16)
	addu	$2,$fp,$6
	andi	$3,$3,0x0003
	sll	$3,$3,7
	sb	$2,29($16)
	sb	$2,37($16)
	andi	$2,$20,0x03c0
	lw	$8,32($sp)
	sra	$2,$2,6
	or	$3,$3,$8
	or	$3,$3,$2
	sh	$3,22($16)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	bgtz	$5,$L22
	move	$17,$6
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L22:
	bgtz	$17,$L17
	li	$17,1			# 0x00000001
$L17:
	lw	$9,84($sp)
	#nop
	addu	$2,$19,$9
	addu	$3,$2,$5
	sh	$2,8($16)
	sh	$2,24($16)
	addu	$2,$23,$17
	sh	$2,26($16)
	sh	$2,34($16)
	#.set	volatile
	lw	$2,nextprim
	#.set	novolatile
	sh	$23,10($16)
	sh	$23,18($16)
	sh	$3,16($16)
	sh	$3,32($16)
 #APP
	lui	$13,%hi(nextprim)
 lw $13,%lo(nextprim)($13)
 lwl $14,2($2)
 sll $15,$16,8
 swl $14,2($16)
 swl $15,2($2)
 #NO_APP
	lh	$2,4($22)
	addu	$19,$19,$5
	#.set	volatile
	sw	$16,nextprim
	#.set	novolatile
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	mult	$19,$21
	.set	macro
	.set	reorder

$L10:
	addu	$7,$7,$17
	lh	$2,6($22)
	lhu	$3,6($22)
	slt	$2,$7,$2
	beq	$2,$0,$L21
	j	$L8
$L2:
	lui	$2,%hi(currentwindow) # high
	addiu	$2,$2,%lo(currentwindow) # low
	lhu	$3,4($2)
	lw	$9,84($sp)
	lhu	$2,8($2)
	addu	$3,$3,$9
	lw	$9,88($sp)
	sh	$3,16($sp)
	addu	$2,$2,$9
	sh	$2,18($sp)
	lhu	$2,4($22)
	addu	$4,$sp,16
	sh	$2,20($sp)
	lhu	$2,6($22)
	addu	$5,$22,16
	.set	noreorder
	.set	nomacro
	jal	vramimage
	sh	$2,22($sp)
	.set	macro
	.set	reorder

$L21:
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
LM1:
	.end	movfxya
