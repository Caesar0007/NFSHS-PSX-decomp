	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbirmpat.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDbankremovepat

	.text
	.def	iSNDbankremovepat;	.val	iSNDbankremovepat;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDbankremovepat
iSNDbankremovepat:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	patch_idx;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	scratch;	.val	20;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$5
	sw	$20,32($sp)
	move	$20,$6
	lui	$3,%hi(sndgs+152) # high
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,%lo(sndgs+152)($3)
	sll	$2,$2,2
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	addu	$2,$2,$3
	lw	$16,0($2)
	#nop
	lbu	$2,4($16)
	li	$19,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L2
	move	$17,$0
	.set	macro
	.set	reorder

	move	$17,$16
$L2:
	jal	iSNDvalidbank
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	bltz	$18,$L12
	lhu	$2,6($16)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	lbu	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L7
	sll	$2,$18,2
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	lw	$4,20($2)
	j	$L8
$L7:
	addu	$2,$16,$2
	lw	$4,12($2)
$L8:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L12
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDremovetaggedpatch
	move	$5,$20
	.set	macro
	.set	reorder

	lbu	$3,4($16)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L10
	sll	$2,$18,2
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$0,20($2)
	.set	macro
	.set	reorder

$L10:
	addu	$2,$16,$2
	sw	$0,12($2)
$L11:
	move	$2,$0
$L12:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDbankremovepat
