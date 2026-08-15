	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\crossprd.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	crossproduct

	.text
	.def	crossproduct;	.val	crossproduct;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	crossproduct
crossproduct:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	a;	.val	17;	.scl	17;	.type	0x14;	.endef
	.def	b;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	out;	.val	19;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	lw	$4,4($17)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$6
	.set	macro
	.set	reorder

	lw	$4,8($17)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,0($19)
	lw	$4,0($17)
	lw	$5,8($18)
	jal	fixedmult
	lw	$4,8($17)
	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$2,$2,$16
	sw	$2,4($19)
	lw	$4,0($17)
	lw	$5,4($18)
	jal	fixedmult
	lw	$4,4($17)
	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	move	$2,$19
	sw	$16,8($2)
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	crossproduct
