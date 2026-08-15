	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\joystkn.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	initjoy

	.comm	joy_inited,4

	.extern	numjoy, 4

	.text
	.def	initjoy;	.val	initjoy;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	initjoy
initjoy:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	numpads;	.val	4;	.scl	17;	.type	0xe;	.endef
	lw	$2,joy_inited
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$4,numjoy
	bne	$2,$0,$L2
	jal	padinit
	li	$2,1			# 0x00000001
	sw	$2,joy_inited
$L2:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	initjoy
	.def	joy_inited;	.val	joy_inited;	.scl	2;	.type	0x4;	.endef
