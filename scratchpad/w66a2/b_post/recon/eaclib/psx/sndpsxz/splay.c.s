	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\splay.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDplay
	.align	2
	.globl	cSNDplay

	.text
	.def	SNDplay;	.val	SNDplay;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDplay
SNDplay:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	info;	.val	4;	.scl	17;	.type	0x14;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	cSNDplay
	move	$5,$0
	.set	macro
	.set	reorder

	j	$L3
$L2:
	li	$2,-10			# 0xfffffff6
$L3:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDplay
	.def	cSNDplay;	.val	cSNDplay;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	cSNDplay
cSNDplay:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	info;	.val	16;	.scl	17;	.type	0x14;	.endef
	.def	recurse;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lb	$4,4($16)
	jal	iSNDvalidbank
	.set	noreorder
	.set	nomacro
	bltz	$2,$L11
	lui	$4,%hi(sndgs+152) # high
	.set	macro
	.set	reorder

	lb	$3,4($16)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,%lo(sndgs+152)($4)
	lw	$4,0($16)
	addu	$2,$2,$3
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	bltz	$4,$L10
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	lhu	$2,6($5)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

$L11:
	.set	noreorder
	.set	nomacro
	j	$L10
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

$L7:
	lbu	$3,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$5,$2
	lw	$4,20($2)
	j	$L9
$L8:
	addu	$2,$5,$2
	lw	$4,12($2)
$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDplaytaggedpatch
	move	$5,$16
	.set	macro
	.set	reorder

$L10:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	cSNDplay
