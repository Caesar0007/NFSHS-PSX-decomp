	.file	1 "p3.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f

	.text
	.def	f;	.val	f;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	f
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(Cdinfo) # high
	lw	$2,%lo(Cdinfo)($2)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	lui	$3,%hi(g_currentthread) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(g_currentthread)($3)
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L5
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L2:
	move	$2,$0
$L5:
	j	$31

	.loc	1 0
LM1:
	.end	f
