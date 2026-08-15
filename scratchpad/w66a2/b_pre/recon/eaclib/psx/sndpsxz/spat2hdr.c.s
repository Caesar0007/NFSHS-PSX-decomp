	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spat2hdr.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDattributessetdef
	.align	2
	.globl	iSNDpatchtohdr

	.text
	.def	SNDattributessetdef;	.val	SNDattributessetdef;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDattributessetdef
SNDattributessetdef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	attr;	.val	4;	.scl	17;	.type	0x14;	.endef
	li	$2,-1			# 0xffffffff
	sw	$2,0($4)
	li	$2,127			# 0x0000007f
	sb	$2,7($4)
	li	$2,64			# 0x00000040
	sb	$2,8($4)
	move	$2,$0
	sb	$0,6($4)
	sh	$0,4($4)
	sb	$0,9($4)
	sb	$0,10($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,11($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDattributessetdef
	.def	iSNDpatchtohdr;	.val	iSNDpatchtohdr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpatchtohdr
iSNDpatchtohdr:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	sampleData;	.val	16;	.scl	17;	.type	0x13;	.endef
	.def	hdr;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	attr;	.val	17;	.scl	17;	.type	0x14;	.endef
	.def	extraOut;	.val	19;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,56
	sw	$16,32($sp)
	move	$16,$4
	sw	$18,40($sp)
	move	$18,$5
	sw	$17,36($sp)
	move	$17,$6
	sw	$19,44($sp)
	move	$19,$7
	sw	$31,48($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDattributessetdef
	move	$4,$17
	.set	macro
	.set	reorder

	sw	$16,16($sp)
	lbu	$2,3($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$2,$16,8
	.set	macro
	.set	reorder

	addu	$2,$16,4
$L23:
	sw	$2,16($sp)
	li	$2,22050			# 0x00005622
	sh	$2,0($18)
	li	$2,1			# 0x00000001
	sb	$2,2($18)
	li	$2,5			# 0x00000005
	sb	$2,3($18)
	sw	$0,0($19)
$L5:
	addu	$4,$sp,16
$L24:
	addu	$5,$sp,20
	addu	$6,$sp,24
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	lw	$3,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	li	$2,130			# 0x00000082
	.set	macro
	.set	reorder

	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sb	$2,11($17)
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L10
	li	$2,132			# 0x00000084
	.set	macro
	.set	reorder

	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sb	$2,2($18)
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L12
	li	$2,133			# 0x00000085
	.set	macro
	.set	reorder

	lhu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sh	$2,0($18)
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L14
	li	$2,19			# 0x00000013
	.set	macro
	.set	reorder

	lw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L14:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L16
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sb	$2,9($17)
	.set	macro
	.set	reorder

$L16:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L18
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sb	$2,10($17)
	.set	macro
	.set	reorder

$L18:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L20
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L20:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L24
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L24
	sb	$2,6($17)
	.set	macro
	.set	reorder

$L6:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDpatchtohdr
