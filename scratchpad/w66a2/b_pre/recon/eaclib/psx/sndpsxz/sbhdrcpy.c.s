	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbhdrcpy.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDbankheadercopy

	.extern	sndgs, 156

	.text
	.def	SNDGlobals;	.scl	10;	.type	0x8;	.size	156;	.endef
	.def	pad0;	.val	0;	.scl	8;	.dim	60;	.size	60;	.type	0x32;	.endef
	.def	initialized;	.val	60;	.scl	8;	.type	0x2;	.endef
	.def	pad3d;	.val	61;	.scl	8;	.dim	91;	.size	91;	.type	0x32;	.endef
	.def	bank_table;	.val	152;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	156;	.scl	102;	.tag	SNDGlobals;	.size	156;	.endef
	.def	SNDbankheadercopy;	.val	SNDbankheadercopy;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDbankheadercopy
SNDbankheadercopy:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	dst;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	bankId;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	lui	$2,%hi(sndgs) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(sndgs) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	lb	$2,60($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	move	$19,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L22
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

	.def	initialized;	.val	$L10;	.scl	6;	.type	0x0;	.endef
$L10:
	.set	noreorder
	.set	nomacro
	jal	SNDbankheadersize
	move	$4,$19
	.set	macro
	.set	reorder

	move	$6,$2
	.set	noreorder
	.set	nomacro
	bltz	$6,$L22
	sll	$16,$19,1
	.set	macro
	.set	reorder

	addu	$16,$16,$19
	lw	$2,152($18)
	sll	$16,$16,2
	addu	$2,$16,$2
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,152($18)
	#nop
	addu	$16,$16,$2
	lw	$16,0($16)
	move	$3,$0
	lhu	$2,6($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	move	$8,$16
	.set	macro
	.set	reorder

	li	$9,4			# 0x00000004
	move	$7,$17
	move	$6,$16
	move	$5,$17
	move	$4,$16
$L14:
	lbu	$2,4($16)
	#nop
	bne	$2,$9,$L17
	lw	$2,20($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	subu	$2,$2,$8
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L19
	sw	$2,20($5)
	.set	macro
	.set	reorder

$L17:
	lw	$2,12($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	subu	$2,$2,$16
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	sw	$2,12($7)
$L19:
	addu	$7,$7,4
	addu	$6,$6,4
	addu	$5,$5,4
	lhu	$2,6($16)
	addu	$3,$3,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L13:
	move	$2,$0
	lui	$3,%hi(sndgs+152) # high
	sll	$4,$19,1
	addu	$4,$4,$19
	lw	$3,%lo(sndgs+152)($3)
	sll	$4,$4,2
	addu	$4,$4,$3
	sw	$17,0($4)
$L22:
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
	.end	SNDbankheadercopy
