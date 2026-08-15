	.file	1 "scratchpad/w65a3/dtor3.i"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gB
	.data
	.align	2
gB:
	.space	8
	.text
	.align	2
	.globl	del__FP1C
	.align	2
	.globl	__1E
	.align	2
	.globl	useF__FP1F
	.align	2
	.globl	_GLOBAL_.D.gB
.stabs "___DTOR_LIST__",22,0,0,_GLOBAL_.D.gB
	.align	2
	.globl	_GLOBAL_.I.gB
.stabs "___CTOR_LIST__",22,0,0,_GLOBAL_.I.gB

	.text
	.text
	.ent	del__FP1C
del__FP1C:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L16
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_._1A
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L16:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	del__FP1C
	.text
	.ent	__1E
__1E:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__1A
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__1E
	.text
	.ent	useF__FP1F
useF__FP1F:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._1A
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	useF__FP1F
	.text
	.ent	_GLOBAL_.D.gB
_GLOBAL_.D.gB:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(gB) # high
	addiu	$4,$4,%lo(gB) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._1A
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_GLOBAL_.D.gB
	.text
	.ent	_GLOBAL_.I.gB
_GLOBAL_.I.gB:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(gB) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__1A
	addiu	$4,$4,%lo(gB) # low
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_GLOBAL_.I.gB
