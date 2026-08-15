	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sgettag.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDgettag

	.text
	.def	iSNDgettag;	.val	iSNDgettag;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDgettag
iSNDgettag:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	cursor;	.val	17;	.scl	17;	.type	0x14;	.endef
	.def	outId;	.val	5;	.scl	17;	.type	0x1e;	.endef
	.def	outVal;	.val	19;	.scl	17;	.type	0x14;	.endef
	.def	outPtr;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$6
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$4,0($17)
	#nop
	lbu	$3,0($4)
	li	$2,252			# 0x000000fc
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L3
	move	$18,$7
	.set	macro
	.set	reorder

	move	$6,$2
$L4:
	addu	$2,$4,1
	move	$3,$4
	sw	$2,0($17)
	lbu	$3,1($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$6,$L4
	move	$4,$2
	.set	macro
	.set	reorder

$L3:
	lw	$2,0($17)
	#nop
	lbu	$2,0($2)
	li	$3,255			# 0x000000ff
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L6
	sw	$2,0($5)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L13
	move	$2,$0
	.set	macro
	.set	reorder

$L6:
	lw	$4,0($17)
	#nop
	addu	$2,$4,1
	sw	$2,0($17)
	lw	$5,0($5)
	li	$2,253			# 0x000000fd
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L8
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	bne	$5,$2,$L10
	.def	marker;	.val	$L8;	.scl	6;	.type	0x0;	.endef
$L8:
	.set	noreorder
	.set	nomacro
	j	$L13
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	data_tag;	.val	$L10;	.scl	6;	.type	0x0;	.endef
$L10:
	lbu	$16,1($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$3,$L11
	addu	$4,$4,2
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	iSNDgetdata
	sw	$4,0($17)
	.set	macro
	.set	reorder

	lw	$3,0($17)
	move	$16,$2
	addu	$3,$3,3
	sw	$3,0($17)
$L11:
	lw	$2,0($17)
	#nop
	addu	$2,$2,1
	sw	$2,0($17)
	sw	$2,0($18)
	sltu	$2,$16,5
	beq	$2,$0,$L12
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	iSNDgetdata
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$2,0($19)
$L12:
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	addu	$3,$3,$16
	sw	$3,0($17)
$L13:
	lw	$31,32($sp)
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
	.end	iSNDgettag
