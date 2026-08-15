	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstsetgs.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_setgreedystate

	.text
	.def	SNDSTRM_setgreedystate;	.val	SNDSTRM_setgreedystate;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_setgreedystate
SNDSTRM_setgreedystate:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	jal	iSNDstreamgetstreamptr
	beq	$2,$0,$L3
	lw	$4,4($2)
	.set	noreorder
	.set	nomacro
	jal	STREAM_setgreedystate
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
	move	$2,$0
	.set	macro
	.set	reorder

$L3:
	li	$2,-8			# 0xfffffff8
$L4:
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
	.end	SNDSTRM_setgreedystate
