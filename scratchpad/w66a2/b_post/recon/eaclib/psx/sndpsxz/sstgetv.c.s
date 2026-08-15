	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstgetv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_getvol

	.text
	.def	SNDSTRM_getvol;	.val	SNDSTRM_getvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_getvol
SNDSTRM_getvol:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L5
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	jal	iSNDstreamgetstreamptr
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L5
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	lw	$4,8($16)
	jal	SNDgetvol
	bgez	$2,$L5
	lb	$2,84($16)
$L5:
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
	.end	SNDSTRM_getvol
