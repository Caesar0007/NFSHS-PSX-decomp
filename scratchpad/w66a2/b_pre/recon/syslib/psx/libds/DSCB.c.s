	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libds\\DSCB.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	DsReadyCallback
	.ent	DsReadyCallback
DsReadyCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$3,ds_ready_cb
	lw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($3)
	.set	macro
	.set	reorder

	.end	DsReadyCallback
	.align	2
	.globl	DsDataCallback
	.ent	DsDataCallback
DsDataCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	addu	$5,$4,$0
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,0x00000003		# 3
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DsDataCallback

	.lcomm	ds_ready_cb,4
