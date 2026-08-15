	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sover.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDover

	.text
	.def	SNDover;	.val	SNDover;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	SNDover
SNDover:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L3
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

	.set	noreorder
	.set	nomacro
	jal	iSNDleaveaudio
	srl	$16,$2,31
	.set	macro
	.set	reorder

	move	$2,$16
$L3:
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
LM1:
	.end	SNDover
