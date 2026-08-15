	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdplapat.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDplatformplay

	.extern	DAT_801479f0, 1

	.text
	.def	iSNDplatformplay;	.val	iSNDplatformplay;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformplay
iSNDplatformplay:
	.frame	$sp,64,$31		# vars= 16, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	chan;	.val	0;	.scl	9;	.type	0x4;	.endef
	.def	voice;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	pitch;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	a5;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	fx;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	volAngle;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	pitchOffset;	.val	28;	.scl	9;	.type	0x4;	.endef
	.def	fx;	.val	2;	.scl	4;	.type	0x4;	.endef
	.def	volAngle;	.val	2;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,64
	sw	$20,48($sp)
	move	$20,$5
	sw	$21,52($sp)
	move	$21,$6
	sw	$22,56($sp)
	move	$22,$7
	sw	$19,44($sp)
	move	$19,$0
	sw	$17,36($sp)
	li	$17,22050			# 0x00005622
	sw	$18,40($sp)
	move	$18,$19
	sll	$2,$20,1
	addu	$2,$2,$20
	sll	$2,$2,2
	subu	$2,$2,$20
	sll	$2,$2,2
	la	$3,DAT_801479f0
	sw	$16,32($sp)
	addu	$16,$2,$3
	li	$2,-1			# 0xffffffff
	sw	$31,60($sp)
	sw	$4,64($sp)
	#.set	volatile
	sb	$0,33($16)
	#.set	novolatile
	#.set	volatile
	sb	$2,32($16)
	#.set	novolatile
	li	$2,1			# 0x00000001
	sb	$0,30($16)
$L12:
	#.set	volatile
	sb	$2,31($16)
	#.set	novolatile
	addu	$4,$sp,64
$L13:
	addu	$5,$sp,16
	addu	$6,$sp,20
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L3
	li	$2,138			# 0x0000008a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L6
	li	$2,133			# 0x00000085
	.set	macro
	.set	reorder

	lw	$19,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L13
	addu	$4,$sp,64
	.set	macro
	.set	reorder

$L6:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L7
	li	$2,130			# 0x00000082
	.set	macro
	.set	reorder

	lw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L13
	addu	$4,$sp,64
	.set	macro
	.set	reorder

$L7:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	li	$2,132			# 0x00000084
	.set	macro
	.set	reorder

	lbu	$2,20($sp)
	j	$L12
$L8:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L9
	li	$2,146			# 0x00000092
	.set	macro
	.set	reorder

	lw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L13
	addu	$4,$sp,64
	.set	macro
	.set	reorder

$L9:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L13
	addu	$4,$sp,64
	.set	macro
	.set	reorder

	lbu	$2,20($sp)
	#nop
	#.set	volatile
	sb	$2,30($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L13
	addu	$4,$sp,64
	.set	macro
	.set	reorder

$L3:
	#.set	volatile
	sw	$18,4($16)
	#.set	novolatile
	#.set	volatile
	sb	$21,34($16)
	#.set	novolatile
	lw	$2,88($sp)
	#nop
	#.set	volatile
	sh	$2,24($16)
	#.set	novolatile
	lw	$2,84($sp)
	#nop
	#.set	volatile
	sb	$2,35($16)
	#.set	novolatile
	lw	$2,0($19)
	#nop
	#.set	volatile
	sw	$2,0($16)
	#.set	novolatile
	sll	$2,$18,12
	#.set	volatile
	sw	$0,12($16)
	#.set	novolatile
	#.set	volatile
	sw	$0,16($16)
	#.set	novolatile
	#.set	volatile
	sw	$2,20($16)
	#.set	novolatile
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,5
	subu	$2,$2,$17
	sll	$2,$2,3
	addu	$2,$2,$17
	sll	$2,$2,3
	subu	$2,$2,$17
	sra	$2,$2,16
	#.set	volatile
	sh	$2,26($16)
	#.set	novolatile
	#.set	volatile
	lbu	$2,31($16)
	#.set	novolatile
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	move	$4,$20
	.set	macro
	.set	reorder

	lui	$3,%hi(sndgs+148) # high
	sll	$2,$20,1
	addu	$2,$2,$20
	sll	$2,$2,3
	addu	$2,$2,$20
	lw	$3,%lo(sndgs+148)($3)
	sll	$2,$2,2
	addu	$2,$2,$3
	lbu	$2,4($2)
	lui	$4,%hi(sndpd) # high
	sb	$2,32($16)
	#.set	volatile
	lbu	$3,32($16)
	#.set	novolatile
	addiu	$4,$4,%lo(sndpd) # low
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	li	$3,1			# 0x00000001
	sb	$3,249($2)
	#.set	volatile
	lbu	$3,32($16)
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
	sw	$0,228($2)
	#.set	volatile
	lbu	$3,32($16)
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
	sw	$0,232($2)
	#.set	volatile
	lbu	$3,32($16)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,20($16)
	addu	$2,$2,$4
	sw	$3,236($2)
	move	$4,$20
$L14:
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpitch
	move	$5,$22
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,28($16)
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatformplay
