	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\stimerem.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDtimeremaining

	.text
	.def	SNDtimeremaining;	.val	SNDtimeremaining;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDtimeremaining
SNDtimeremaining:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	17;	.scl	17;	.type	0xe;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$16,24($sp)
	li	$16,-1024			# 0xfffffc00
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,32($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	move	$4,$17
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bgez	$17,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	iSNDleaveaudio
	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

$L3:
	sw	$2,16($sp)
	move	$4,$17
$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L5
	lw	$4,16($sp)
	jal	iSNDtimeremaining
	move	$3,$2
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L9
	move	$16,$3
	.set	macro
	.set	reorder

$L5:
	jal	iSNDleaveaudio
	move	$2,$16
$L8:
	lw	$31,32($sp)
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
	.end	SNDtimeremaining
