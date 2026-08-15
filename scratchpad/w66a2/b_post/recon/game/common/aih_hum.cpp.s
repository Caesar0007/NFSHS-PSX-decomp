	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_hum.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	HighExecute__12AIHigh_Human
	.align	2
	.globl	__12AIHigh_HumanP8Car_tObj
	.align	2
	.globl	_._12AIHigh_Human

	.text
	.text
	.ent	HighExecute__12AIHigh_Human
HighExecute__12AIHigh_Human:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	HandleCops__13AIHigh_Player
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,1			# 0x00000001
	sb	$2,145($3)
	lw	$4,4($16)
	jal	StateExecute__12AIState_Base
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HighExecute__12AIHigh_Human
	.text
	.ent	__12AIHigh_HumanP8Car_tObj
__12AIHigh_HumanP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__13AIHigh_PlayerP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_Human_vtable) # high
	addiu	$2,$2,%lo(AIHigh_Human_vtable) # low
	sw	$2,20($16)
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

	.end	__12AIHigh_HumanP8Car_tObj
	.text
	.ent	_._12AIHigh_Human
_._12AIHigh_Human:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(AIHigh_BasicPerp_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicPerp_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._11AIHigh_Base
	sw	$2,20($4)
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

	.end	_._12AIHigh_Human
