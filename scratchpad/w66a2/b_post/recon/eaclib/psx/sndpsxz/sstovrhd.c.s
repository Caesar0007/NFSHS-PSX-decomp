	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstovrhd.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_overheadtap
	.align	2
	.globl	SNDSTRM_overhead

	.text
	.def	SNDSTRM_overheadtap;	.val	SNDSTRM_overheadtap;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_overheadtap
SNDSTRM_overheadtap:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	numConsumers;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	numReq;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sll	$16,$4,1
	addu	$16,$16,$4
	sll	$16,$16,2
	subu	$16,$16,$4
	sll	$16,$16,2
	addu	$16,$16,96
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_overhead
	move	$4,$5
	.set	macro
	.set	reorder

	addu	$2,$16,$2
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
	.end	SNDSTRM_overheadtap
	.def	SNDSTRM_overhead;	.val	SNDSTRM_overhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_overhead
SNDSTRM_overhead:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	numConsumers;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	numReq;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_overheadtap
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	addu	$4,$17,1
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	STREAM_overhead
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$2,$16,$2
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
LM2:
	.end	SNDSTRM_overhead
