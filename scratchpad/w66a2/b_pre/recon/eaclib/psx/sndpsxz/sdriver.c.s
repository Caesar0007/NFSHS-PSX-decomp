	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdriver.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDstop
	.align	2
	.globl	iSNDplatformpitch
	.align	2
	.globl	iSNDplatformfxlevel
	.align	2
	.globl	iSNDvol

	.extern	DAT_801479f0, 1

	.text
	.def	iSNDstop;	.val	iSNDstop;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstop
iSNDstop:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	chan;	.val	17;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$17,20($sp)
	move	$17,$4
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,2
	lui	$3,%hi(sndpd+216) # high
	sw	$19,28($sp)
	addiu	$19,$3,%lo(sndpd+216) # low
	sw	$16,16($sp)
	addu	$16,$2,$19
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	#.set	volatile
	lbu	$2,39($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	bltz	$2,$L2
	lw	$2,1612($19)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	move	$4,$17
	.set	macro
	.set	reorder

	li	$21,3			# 0x00000003
	li	$20,1			# 0x00000001
	#.set	volatile
	sb	$21,29($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,28($16)
	#.set	novolatile
	#.set	volatile
	lbu	$2,31($16)
	#.set	novolatile
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	sll	$18,$20,$17
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,32($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$17,$2,24
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$2,$17,$20
	addu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,2
	addu	$16,$2,$19
	sll	$2,$20,$17
	or	$18,$18,$2
	#.set	volatile
	sb	$21,29($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,28($16)
	#.set	novolatile
$L3:
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxkeyoff
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDstop
	.def	iSNDplatformpitch;	.val	iSNDplatformpitch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformpitch
iSNDplatformpitch:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	pitch;	.val	5;	.scl	17;	.type	0x4;	.endef
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	lui	$3,%hi(sndpd+216) # high
	addiu	$4,$3,%lo(sndpd+216) # low
	addu	$6,$2,$4
	lhu	$2,26($6)
	#nop
	mult	$2,$5
	li	$5,1			# 0x00000001
	mflo	$7
	#nop
	#nop
	sra	$2,$7,12
	sll	$3,$2,3
	subu	$3,$3,$2
	sll	$2,$3,6
	subu	$2,$2,$3
	#.set	volatile
	sw	$2,8($6)
	#.set	novolatile
	#.set	volatile
	sb	$5,40($6)
	#.set	novolatile
	#.set	volatile
	lbu	$3,31($6)
	#.set	novolatile
	li	$2,2			# 0x00000002
	bne	$3,$2,$L5
	#.set	volatile
	lbu	$3,32($6)
	#.set	novolatile
	addu	$4,$4,-216
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,8($6)
	addu	$2,$2,$4
	sw	$3,224($2)
	#.set	volatile
	lbu	$3,32($6)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	sb	$5,256($2)
$L5:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDplatformpitch
	.def	iSNDplatformfxlevel;	.val	iSNDplatformfxlevel;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformfxlevel
iSNDplatformfxlevel:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	bus;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	fxon;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	la	$3,DAT_801479f0
	addu	$3,$2,$3
	sw	$31,16($sp)
	#.set	volatile
	lbu	$2,28($3)
	#.set	novolatile
	#nop
	andi	$5,$2,0x00ff
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L7
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$6,35($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L12
	move	$2,$0
	.set	macro
	.set	reorder

$L7:
	#.set	volatile
	lbu	$2,31($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L8
	sll	$4,$7,$4
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,32($3)
	#.set	novolatile
	#nop
	sll	$2,$7,$2
	or	$4,$4,$2
$L8:
	beq	$6,$0,$L9
	jal	iSNDpsxeffecton
	.set	noreorder
	.set	nomacro
	j	$L12
	move	$2,$0
	.set	macro
	.set	reorder

$L9:
	jal	iSNDpsxeffectoff
	move	$2,$0
$L12:
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
	.end	iSNDplatformfxlevel
	.def	iSNDvol;	.val	iSNDvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDvol
iSNDvol:
	.frame	$sp,48,$31		# vars= 8, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	chan;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	sll	$2,$2,2
	lui	$3,%hi(sndpd+216) # high
	addiu	$3,$3,%lo(sndpd+216) # low
	sw	$16,32($sp)
	addu	$16,$2,$3
	sw	$31,40($sp)
	#.set	volatile
	lbu	$3,28($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	beq	$3,$2,$L14
	#.set	volatile
	sb	$5,34($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L20
	move	$2,$0
	.set	macro
	.set	reorder

$L14:
	#.set	volatile
	lbu	$2,30($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$4,24($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	iSNDatolrv
	addu	$7,$sp,28
	.set	macro
	.set	reorder

	j	$L16
$L15:
	#.set	volatile
	lbu	$3,30($16)
	#.set	novolatile
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L16
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$4,24($16)
	#.set	novolatile
	#.set	volatile
	lbu	$2,36($16)
	#.set	novolatile
	addu	$7,$sp,28
	sll	$2,$2,24
	sra	$2,$2,24
	sw	$2,16($sp)
	#.set	volatile
	lbu	$2,37($16)
	#.set	novolatile
	andi	$4,$4,0xffff
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	jal	iSNDatodlrv
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L16:
	lbu	$2,24($sp)
	#nop
	#.set	volatile
	sb	$2,36($16)
	#.set	novolatile
	lbu	$2,28($sp)
	#nop
	#.set	volatile
	sb	$2,37($16)
	#.set	novolatile
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDsetvol
	move	$4,$17
	.set	macro
	.set	reorder

	move	$2,$0
$L20:
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
LM4:
	.end	iSNDvol
