	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\trnsfrm.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	transform

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	x;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	y;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	z;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	.0fake;	.size	12;	.endef
	.def	TransformResult;	.scl	13;	.tag	.0fake;	.size	12;	.type	0x8;	.endef
	.def	transform;	.val	transform;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	transform
transform:
	.frame	$sp,56,$31		# vars= 16, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	vec;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	mat;	.val	19;	.scl	17;	.type	0x14;	.endef
	.def	out;	.val	20;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$19,44($sp)
	move	$19,$5
	sw	$31,52($sp)
	sw	$20,48($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$4,0($18)
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$20,$6
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,12($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,24($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,16($sp)
	lw	$4,0($18)
	lw	$5,4($19)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,16($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,28($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,20($sp)
	lw	$4,0($18)
	lw	$5,8($19)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,20($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,32($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	sw	$16,24($sp)
	lw	$3,16($sp)
	lw	$7,20($sp)
	lw	$8,24($sp)
	sw	$3,0($20)
	sw	$7,4($20)
	sw	$8,8($20)
	lw	$31,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	transform
