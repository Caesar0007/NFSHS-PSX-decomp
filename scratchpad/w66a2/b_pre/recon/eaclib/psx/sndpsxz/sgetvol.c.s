	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sgetvol.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDgetvol

	.text
	.def	SNDgetvol;	.val	SNDgetvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDgetvol
SNDgetvol:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(sndgs) # low
	sw	$31,24($sp)
	sw	$16,16($sp)
	lb	$2,60($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
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
	bltz	$16,$L3
	jal	iSNDleaveaudio
	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$2,$2,3
	addu	$2,$2,$16
	lw	$3,148($17)
	sll	$2,$2,2
	addu	$2,$2,$3
	lb	$2,45($2)
	j	$L4
$L3:
	jal	iSNDleaveaudio
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
	.end	SNDgetvol
