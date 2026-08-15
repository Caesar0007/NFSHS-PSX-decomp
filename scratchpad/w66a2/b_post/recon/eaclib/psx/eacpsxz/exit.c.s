	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\exit.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	addexit

	.comm	gExitFuncs,128

	.text
	.def	addexit;	.val	addexit;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	addexit
addexit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	fn;	.val	4;	.scl	17;	.type	0x91;	.endef
	move	$5,$0
	lui	$2,%hi(gExitFuncs) # high
	addiu	$3,$2,%lo(gExitFuncs) # low
$L5:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L14
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$5,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$3,$3,4
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$2,%hi(gExitFuncs) # high
	addiu	$3,$2,%lo(gExitFuncs) # low
$L11:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($3)
	.set	macro
	.set	reorder

$L10:
	slt	$2,$5,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L14:
	j	$31

	.loc	1 0
LM1:
	.end	addexit
	.def	gExitFuncs;	.val	gExitFuncs;	.scl	2;	.dim	32;	.size	128;	.type	0x271;	.endef
