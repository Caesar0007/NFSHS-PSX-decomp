	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstop.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDstop

	.text
	.def	SNDstop;	.val	SNDstop;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDstop
SNDstop:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
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
	bltz	$16,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	move	$4,$16
$L8:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L3
	lw	$4,16($sp)
	jal	iSNDstop
	.set	noreorder
	.set	nomacro
	j	$L8
	move	$4,$16
	.set	macro
	.set	reorder

$L3:
	jal	iSNDleaveaudio
	move	$2,$16
$L7:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDstop
