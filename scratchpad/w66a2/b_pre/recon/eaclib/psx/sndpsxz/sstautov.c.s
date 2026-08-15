	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstautov.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_autovol

	.text
	.def	SNDSTRM_autovol;	.val	SNDSTRM_autovol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_autovol
SNDSTRM_autovol:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	steps;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	vol;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,24($sp)
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
	move	$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L3
	li	$2,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	ori	$2,$2,0x6667
	mult	$16,$2
	sra	$5,$16,31
	lw	$4,8($3)
	move	$6,$17
	sb	$17,84($3)
	mfhi	$7
	#nop
	#nop
	sra	$2,$7,2
	.set	noreorder
	.set	nomacro
	jal	SNDautovol
	subu	$5,$2,$5
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
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDSTRM_autovol
