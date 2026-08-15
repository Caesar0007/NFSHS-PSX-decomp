	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchsamp.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSPCH_InitSample
	.align	2
	.globl	iSPCH_UnPackSample

	.text
	.def	bool;	.scl	13;	.type	0x4;	.endef
	.def	iSPCH_InitSample;	.val	iSPCH_InitSample;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_InitSample
iSPCH_InitSample:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	out;	.val	4;	.scl	17;	.type	0x14;	.endef
	li	$2,-1			# 0xffffffff
	sw	$2,4($4)
	li	$2,255			# 0x000000ff
	sw	$0,0($4)
	sw	$0,8($4)
	sb	$2,12($4)
	sb	$2,13($4)
	sb	$2,14($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,15($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSPCH_InitSample
	.def	iSPCH_UnPackSample;	.val	iSPCH_UnPackSample;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_UnPackSample
iSPCH_UnPackSample:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	bank;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	sampleIdx;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	out;	.val	21;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	move	$18,$17
	move	$4,$21
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_InitSample
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lbu	$2,3($20)
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	move	$16,$17
	.set	macro
	.set	reorder

	lbu	$2,2($20)
	#nop
	andi	$5,$2,0x000f
	addu	$7,$5,2
	mult	$19,$7
	addu	$6,$20,8
	move	$4,$17
	slt	$2,$17,$5
	sw	$5,8($21)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	addu	$6,$6,$9
	.set	macro
	.set	reorder

	addu	$3,$21,$4
$L18:
	addu	$2,$4,$6
	lbu	$2,2($2)
	addu	$4,$4,1
	sb	$2,12($3)
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	addu	$3,$21,$4
	.set	macro
	.set	reorder

$L4:
	lbu	$2,0($6)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	addu	$4,$6,$7
	.set	macro
	.set	reorder

	lbu	$19,1($6)
	#nop
	mult	$19,$7
	addu	$6,$20,8
	mflo	$9
	#nop
	#nop
	addu	$6,$6,$9
	addu	$4,$6,$7
$L19:
	addu	$5,$19,1
	lbu	$2,0($6)
	lbu	$3,1($6)
	sll	$2,$2,8
	addu	$6,$2,$3
	sll	$6,$6,8
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L11
	sw	$6,4($21)
	.set	macro
	.set	reorder

	lbu	$8,3($20)
	#nop
	slt	$2,$5,$8
$L20:
	bne	$2,$0,$L13
	lhu	$2,4($20)
	li	$18,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L10
	sll	$16,$2,8
	.set	macro
	.set	reorder

$L13:
	lbu	$2,0($4)
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L15
	addu	$4,$4,$7
	.set	noreorder
	.set	nomacro
	j	$L10
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L15:
	li	$18,1			# 0x00000001
	lbu	$2,0($4)
	lbu	$3,1($4)
	sll	$2,$2,8
	addu	$16,$2,$3
	sll	$16,$16,8
$L10:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L20
	slt	$2,$5,$8
	.set	macro
	.set	reorder

$L11:
	subu	$2,$16,$6
	sw	$2,0($21)
	li	$17,1			# 0x00000001
$L3:
	move	$2,$17
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_UnPackSample
