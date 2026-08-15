	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\CARDINIT.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	StartCARD
	.ent	StartCARD
StartCARD:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	EnterCriticalSection
	jal	StartCARD2
	.set	noreorder
	.set	nomacro
	jal	ChangeClearPAD
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	jal	ExitCriticalSection
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StartCARD
	.align	2
	.globl	StopCARD
	.ent	StopCARD
StopCARD:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	StopCARD2
	jal	_ExitCard
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StopCARD
