	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\s3dlow.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SND3dpos

	.text
	.def	SND3dpos;	.val	SND3dpos;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SND3dpos
SND3dpos:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	pos;	.val	18;	.scl	17;	.type	0xe;	.endef
	.def	y;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$17,28($sp)
	move	$17,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,36($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L10
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	slt	$2,$17,16384
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	andi	$18,$18,0xffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
	li	$17,16383			# 0x00003fff
	.set	macro
	.set	reorder

$L3:
	slt	$2,$17,-16384
	beq	$2,$0,$L4
	li	$17,-16384			# 0xffffc000
$L4:
	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$16,$L6
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	move	$4,$16
$L11:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatform3dpos
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L11
	move	$4,$16
	.set	macro
	.set	reorder

$L6:
	jal	iSNDleaveaudio
	move	$2,$16
$L10:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SND3dpos
