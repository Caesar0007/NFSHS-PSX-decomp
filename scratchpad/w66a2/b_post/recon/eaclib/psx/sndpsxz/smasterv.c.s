	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\smasterv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDmastervol

	.text
	.def	SNDMasterState;	.scl	10;	.type	0x8;	.size	152;	.endef
	.def	pad0;	.val	0;	.scl	8;	.dim	17;	.size	17;	.type	0x3c;	.endef
	.def	channel_count;	.val	17;	.scl	8;	.type	0xc;	.endef
	.def	pad1;	.val	18;	.scl	8;	.dim	130;	.size	130;	.type	0x3c;	.endef
	.def	play_records;	.val	148;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	152;	.scl	102;	.tag	SNDMasterState;	.size	152;	.endef
	.def	SNDmastervol;	.val	SNDmastervol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDmastervol
SNDmastervol:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	vol;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	lui	$2,%hi(sndgs) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sndgs) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lb	$2,60($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$18,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L9
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	jal	iSNDenteraudio
	move	$17,$0
	.set	macro
	.set	reorder

	lbu	$2,17($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	sb	$18,61($16)
	.set	macro
	.set	reorder

	move	$19,$16
	move	$18,$17
$L4:
	lw	$2,148($19)
	#nop
	addu	$16,$2,$18
	lb	$3,11($16)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L7
	lw	$2,0($16)
	#nop
	bltz	$2,$L7
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcvol
	move	$4,$17
	.set	macro
	.set	reorder

	lb	$5,45($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDvol
	move	$4,$17
	.set	macro
	.set	reorder

$L7:
	lbu	$2,17($19)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	addu	$18,$18,100
	.set	macro
	.set	reorder

$L3:
	jal	iSNDleaveaudio
	move	$2,$0
$L9:
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
	.end	SNDmastervol
