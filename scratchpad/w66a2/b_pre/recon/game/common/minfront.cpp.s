	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\minfront.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	MinFront_ParseOptions__Fv

	.text
	.text
	.ent	MinFront_ParseOptions__Fv
MinFront_ParseOptions__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(bigBuf+12) # high
	addiu	$4,$4,%lo(bigBuf+12) # low
	li	$5,8192			# 0x00002000
	li	$6,16			# 0x00000010
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	resizememadr
	sw	$0,0($16)
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

	.end	MinFront_ParseOptions__Fv
