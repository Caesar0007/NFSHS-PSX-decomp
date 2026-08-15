	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcard\\INIT.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	InitCARD

	.text
	.def	InitCARD;	.val	InitCARD;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	InitCARD
InitCARD:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	val;	.val	16;	.scl	17;	.type	0x5;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	ChangeClearPAD
	move	$4,$0
	.set	macro
	.set	reorder

	jal	EnterCriticalSection
	jal	ReadInitPadFlag
	bne	$2,$0,$L2
	move	$16,$0
$L2:
	.set	noreorder
	.set	nomacro
	jal	InitCARD2
	move	$4,$16
	.set	macro
	.set	reorder

	jal	_copy_memcard_patch
	jal	_patch_card
	jal	_patch_card2
	jal	ExitCriticalSection
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
	.end	InitCARD
