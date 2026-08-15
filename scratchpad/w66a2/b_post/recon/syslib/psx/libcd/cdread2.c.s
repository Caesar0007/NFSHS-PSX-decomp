	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\cdread2.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdRead2
	.ent	CdRead2
CdRead2:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	addu	$16,$4,$0
	li	$4,0x0000000e		# 14
	addu	$5,$sp,16
	addu	$6,$0,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControl
	sb	$16,16($sp)
	.set	macro
	.set	reorder

	andi	$2,$16,0x0100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	andi	$2,$16,0x0020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	sw	$0,StMode
	j	$L4
$L3:
	sw	$2,StMode
$L4:
	la	$4,data_ready_callback
	jal	CdDataCallback
	la	$4,_cdread2_ready
	jal	CdReadyCallback
$L2:
	li	$4,0x0000001b		# 27
	addu	$5,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$0,$0
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	CdRead2
	.align	2
	.globl	_cdread2_ready
	.ent	_cdread2_ready
_cdread2_ready:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	StCdInterrupt
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_cdread2_ready
