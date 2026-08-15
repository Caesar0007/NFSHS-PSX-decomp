	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\devsys.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	psxdevelopmentsystem

	.text
	.def	psxdevelopmentsystem;	.val	psxdevelopmentsystem;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	psxdevelopmentsystem
psxdevelopmentsystem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$4,134
	li	$2,14170			# 0x0000375a
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L2
	li	$3,10074			# 0x0000275a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L5
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L2:
	li	$2,1			# 0x00000001
$L5:
	j	$31

	.loc	1 0
LM1:
	.end	psxdevelopmentsystem
