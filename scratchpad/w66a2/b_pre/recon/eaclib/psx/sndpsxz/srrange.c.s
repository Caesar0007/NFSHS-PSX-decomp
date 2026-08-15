	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\srrange.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	randrange

	.text
	.def	randrange;	.val	randrange;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	randrange
randrange:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	range;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$2,65536			# 0x00010000
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L3
	li	$16,65536			# 0x00010000
	.set	macro
	.set	reorder

$L2:
	bgez	$16,$L3
	move	$16,$0
$L3:
	jal	iSNDrandom
	andi	$2,$2,0x7fff
	addu	$2,$2,-16384
	mult	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	mflo	$3
	#nop
	#nop
	sra	$2,$3,14
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	randrange
