	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\ssysreal.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDsystemtaskreal
	.align	2
	.globl	SNDSYS_vectortoreal

	.extern	D_80134A6C, 8

	.text
	.def	iSNDsystemtaskreal;	.val	iSNDsystemtaskreal;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDsystemtaskreal
iSNDsystemtaskreal:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	SNDSYS_service
	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDsystemtaskreal
	.def	SNDSYS_vectortoreal;	.val	SNDSYS_vectortoreal;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSYS_vectortoreal
SNDSYS_vectortoreal:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(D_80134A6C) # high
	lw	$2,%lo(D_80134A6C)($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(iSNDsystemtaskreal) # high
	addiu	$4,$4,%lo(iSNDsystemtaskreal) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,%lo(D_80134A6C)($16)
$L3:
	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	SNDSYS_vectortoreal
