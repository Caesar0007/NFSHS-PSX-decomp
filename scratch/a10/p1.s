	.file	1 "p1.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f

	.extern	g_currentthread, 4
	.extern	Cdinfo, 4

	.text
	.def	f;	.val	f;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	f
f:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x4;	.endef
	lw	$2,Cdinfo
	subu	$sp,$sp,24
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$3,g_currentthread
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L4
	move	$2,$0
	.set	macro
	.set	reorder

	jal	other
	.set	noreorder
	.set	nomacro
	j	$L4
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L2:
	move	$2,$0
$L4:
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
	.end	f
