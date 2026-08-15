	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\vramfxya.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	checkrect
	.align	2
	.globl	vramimage
	.align	2
	.globl	vramfxya

	.extern	drawpending, 4

	.text
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	.0fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	x;	.val	0;	.scl	8;	.type	0x3;	.endef
	.def	y;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	w;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	h;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.0fake;	.size	8;	.endef
	.def	RECT;	.scl	13;	.tag	.0fake;	.size	8;	.type	0x8;	.endef
	.def	checkrect;	.val	checkrect;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	checkrect
checkrect:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	rectp;	.val	4;	.scl	17;	.type	0x4;	.endef
	lhu	$2,4($4)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L3
	lhu	$2,6($4)
	#nop
	ori	$2,$2,0x0001
	sh	$2,6($4)
$L3:
	j	$31

	.loc	1 0
LM1:
	.end	checkrect
	.def	vramimage;	.val	vramimage;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	vramimage
vramimage:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	rect;	.val	16;	.scl	17;	.tag	.0fake;	.size	8;	.type	0x18;	.endef
	.def	data;	.val	17;	.scl	17;	.type	0x1f;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	checkrect
	move	$17,$5
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,drawpending
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	vramimage
	.def	vramfxya;	.val	vramfxya;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	vramfxya
vramfxya:
	.frame	$sp,1104,$31		# vars= 1048, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	c;	.val	16;	.scl	17;	.type	0x1e;	.endef
	.def	imgX;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	imgY;	.val	30;	.scl	17;	.type	0x4;	.endef
	.def	clutX;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	clutY;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	clutY;	.val	22;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,1104
	sw	$22,1088($sp)
	lw	$22,1120($sp)
	sw	$16,1064($sp)
	move	$16,$4
	sw	$23,1092($sp)
	move	$23,$5
	sw	$fp,1096($sp)
	move	$fp,$6
	sw	$21,1084($sp)
	move	$21,$7
	sw	$31,1100($sp)
	sw	$20,1080($sp)
	sw	$19,1076($sp)
	sw	$18,1072($sp)
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L5
	sw	$17,1068($sp)
	.set	macro
	.set	reorder
	li	$20,-4096			# 0xfffff000
	li	$17,-268435456			# 0xf0000000
	ori	$17,$17,0xffff

	andi	$19,$21,0x0fff
	andi	$2,$22,0x0fff
	sll	$18,$2,16
	addu	$8,$sp,24
	sw	$8,1060($sp)
$L7:
	lbu	$2,0($16)
	#nop
	andi	$2,$2,0x00f7
	addu	$3,$2,-34
	sltu	$2,$3,34
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	lui	$2,%hi($L27) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L27) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L27:
	.word	$L18
	.word	$L17
	.word	$L22
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L16
	.word	$L14
	.word	$L14
	.word	$L14
	.word	$L14
	.text
$L14:
	move	$4,$16
	andi	$3,$23,0x0fff
	lw	$2,12($16)
	lbu	$5,0($16)
	and	$2,$2,$20
	or	$2,$2,$3
	and	$2,$2,$17
	andi	$3,$fp,0x0fff
	sll	$3,$3,16
	or	$2,$2,$3
	ori	$5,$5,0x0008
	sw	$2,12($16)
	sb	$5,0($16)
	sh	$23,16($sp)
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sh	$fp,18($sp)
	.set	macro
	.set	reorder

	lh	$3,4($16)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	addu	$2,$3,15
	.set	noreorder
	.set	nomacro
	bgez	$2,$L32
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$3,30
$L32:
	sra	$2,$2,4
	sh	$2,20($sp)
	lhu	$2,6($16)
	addu	$5,$16,16
	.set	noreorder
	.set	nomacro
	j	$L31
	sh	$2,22($sp)
	.set	macro
	.set	reorder

$L17:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	j	$L10
	addu	$5,$16,16
	.set	macro
	.set	reorder

$L18:
	lh	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L19
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$7,1060($sp)
	move	$5,$16
	.def	clut22loop;	.val	$L20;	.scl	6;	.type	0x0;	.endef
$L20:
	lbu	$2,18($5)
	lbu	$3,17($5)
	lbu	$4,16($5)
	addu	$5,$5,3
	addu	$6,$6,1
	srl	$2,$2,1
	srl	$3,$3,1
	srl	$4,$4,1
	sll	$2,$2,10
	sll	$3,$3,5
	or	$2,$2,$3
	or	$4,$4,$2
	sh	$4,0($7)
	lh	$2,4($16)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	addu	$7,$7,2
	.set	macro
	.set	reorder

$L19:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	j	$L10
	addu	$5,$sp,24
	.set	macro
	.set	reorder

$L22:
	lh	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L23
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$7,$sp,536
	move	$5,$16
	.def	clut24loop;	.val	$L24;	.scl	6;	.type	0x0;	.endef
$L24:
	lbu	$2,18($5)
	lbu	$3,17($5)
	lbu	$4,16($5)
	addu	$5,$5,3
	addu	$6,$6,1
	srl	$2,$2,3
	srl	$3,$3,3
	srl	$4,$4,3
	sll	$2,$2,10
	sll	$3,$3,5
	or	$2,$2,$3
	or	$4,$4,$2
	sh	$4,0($7)
	lh	$2,4($16)
	#nop
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	addu	$7,$7,2
	.set	macro
	.set	reorder

$L23:
	addu	$4,$sp,16
	addu	$5,$sp,536
$L10:
	lw	$2,12($16)
	lbu	$3,0($16)
	and	$2,$2,$20
	or	$2,$2,$19
	and	$2,$2,$17
	or	$2,$2,$18
	ori	$3,$3,0x0008
	sw	$2,12($16)
	sb	$3,0($16)
	sh	$21,16($sp)
	sh	$22,18($sp)
	lhu	$3,4($16)
	li	$2,1			# 0x00000001
	sh	$2,22($sp)
	sh	$3,20($sp)
$L31:
	jal	vramimage
	.def	walk;	.val	$L16;	.scl	6;	.type	0x0;	.endef
$L16:
	lw	$3,0($16)
	li	$2,-256			# 0xffffff00
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	sra	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L29
	addu	$4,$16,$2
	.set	macro
	.set	reorder

$L28:
	move	$4,$0
$L29:
	move	$16,$4
	bne	$16,$0,$L7
$L5:
	lw	$31,1100($sp)
	lw	$fp,1096($sp)
	lw	$23,1092($sp)
	lw	$22,1088($sp)
	lw	$21,1084($sp)
	lw	$20,1080($sp)
	lw	$19,1076($sp)
	lw	$18,1072($sp)
	lw	$17,1068($sp)
	lw	$16,1064($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,1104
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	vramfxya
