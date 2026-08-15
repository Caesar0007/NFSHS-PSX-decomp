	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\FOG_01.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetFogNear

	.text
	.def	SetFogNear;	.val	SetFogNear;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetFogNear
SetFogNear:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x5;	.endef
	.def	h;	.val	5;	.scl	17;	.type	0x5;	.endef
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,6
	subu	$2,$0,$2
	div	$4,$2,$5
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	SetDQA
	.set	noreorder
	.set	nomacro
	jal	SetDQB
	li	$4,20971520			# 0x01400000
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31


	.loc	1 0
LM1:
	.end	SetFogNear
