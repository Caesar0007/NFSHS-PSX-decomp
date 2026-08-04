	.file	1 "e2.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdFlush

	.text
	.def	CdFlush;	.val	CdFlush;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CdFlush
CdFlush:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	mode;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	other
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L2
	lui	$2,%hi(CD_cbsync) # high
	.set	macro
	.set	reorder

	sw	$16,%lo(CD_cbsync)($2)
$L2:
	lui	$2,%hi(CD_cbsync) # high
	lw	$2,%lo(CD_cbsync)($2)
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
	.end	CdFlush
