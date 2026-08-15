	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\matrix.c"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	identitymatrix
	.rdata
	.align	2
identitymatrix:
	.word	65536
	.word	0
	.word	0
	.word	0
	.word	65536
	.word	0
	.word	0
	.word	0
	.word	65536
	.text
	.align	2
	.globl	addmatrix
	.align	2
	.globl	submatrix
	.align	2
	.globl	scalematrix
	.rdata
	.text
	.rdata
	.align	2
coef:
	.word	16384
	.word	-8192
	.word	6144
	.word	-5120
	.text
	.align	2
	.globl	reorthogonalize

	.text
	.def	addmatrix;	.val	addmatrix;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	addmatrix
addmatrix:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	m1;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	m2;	.val	5;	.scl	17;	.type	0x14;	.endef
	.def	out;	.val	6;	.scl	17;	.type	0x14;	.endef
	move	$8,$0
	move	$7,$6
$L5:
	lw	$3,0($5)
	addu	$5,$5,4
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$8,$8,1
	addu	$2,$2,$3
	sw	$2,0($7)
	slt	$2,$8,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$7,$7,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	addmatrix
	.def	submatrix;	.val	submatrix;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	submatrix
submatrix:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	m1;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	m2;	.val	5;	.scl	17;	.type	0x14;	.endef
	.def	out;	.val	6;	.scl	17;	.type	0x14;	.endef
	move	$8,$0
	move	$7,$6
$L11:
	lw	$3,0($5)
	addu	$5,$5,4
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$8,$8,1
	subu	$2,$2,$3
	sw	$2,0($7)
	slt	$2,$8,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$7,$7,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	submatrix
	.def	scalematrix;	.val	scalematrix;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	scalematrix
scalematrix:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	m;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	scalar;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	out;	.val	20;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$18,24($sp)
	move	$18,$0
	sw	$17,20($sp)
	move	$17,$20
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,36($sp)
$L17:
	lw	$4,0($16)
	addu	$16,$16,4
	addu	$18,$18,1
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	sw	$2,0($17)
	slt	$2,$18,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	addu	$17,$17,4
	.set	macro
	.set	reorder

	move	$2,$20
	lw	$31,36($sp)
	lw	$20,32($sp)
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
LM3:
	.end	scalematrix
	.def	.0fake;	.scl	10;	.type	0x8;	.size	36;	.endef
	.def	m;	.val	0;	.scl	8;	.dim	9;	.size	36;	.type	0x34;	.endef
	.def	.eos;	.val	36;	.scl	102;	.tag	.0fake;	.size	36;	.endef
	.def	mtx;	.scl	13;	.tag	.0fake;	.size	36;	.type	0x8;	.endef
	.def	reorthogonalize;	.val	reorthogonalize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	reorthogonalize
reorthogonalize:
	.frame	$sp,256,$31		# vars= 200, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	M;	.val	20;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,256
	sw	$20,232($sp)
	move	$20,$4
	sw	$22,240($sp)
	move	$22,$0
	sw	$19,228($sp)
	addu	$19,$sp,56
	lui	$7,%hi(identitymatrix) # high
	addiu	$7,$7,%lo(identitymatrix) # low
	sw	$fp,248($sp)
	addu	$fp,$7,32
	sw	$21,236($sp)
	addu	$21,$sp,136
	sw	$23,244($sp)
	addu	$23,$sp,88
	sw	$31,252($sp)
	sw	$18,224($sp)
	sw	$17,220($sp)
	sw	$16,216($sp)
	move	$4,$20
$L35:
	.set	noreorder
	.set	nomacro
	jal	transpose
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	transmult
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	la	$5,identitymatrix
	.set	noreorder
	.set	nomacro
	jal	submatrix
	addu	$6,$sp,96
	.set	macro
	.set	reorder

	addu	$3,$sp,136
	la	$2,identitymatrix
$L24:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$7,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$7,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$fp,$L24
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($fp)
	sw	$8,0($3)
	addu	$3,$sp,176
	lui	$8,%hi(identitymatrix) # high
	addiu	$2,$8,%lo(identitymatrix) # low
$L25:
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$9,0($3)
	sw	$10,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$fp,$L25
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$9,0($2)
	sw	$9,0($3)
	li	$17,1			# 0x00000001
	addu	$18,$sp,176
	lui	$2,%hi(coef) # high
	addiu	$2,$2,%lo(coef) # low
	addu	$16,$2,4
	move	$4,$21
$L34:
	addu	$5,$sp,96
	.set	noreorder
	.set	nomacro
	jal	transmult
	move	$6,$19
	.set	macro
	.set	reorder

	move	$3,$21
	move	$2,$19
$L30:
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$9,0($3)
	sw	$10,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$23,$L30
	addu	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$sp,136
	addu	$6,$sp,16
	lw	$9,0($2)
	sw	$9,0($3)
	#.set	volatile
	lw	$5,0($16)
	#.set	novolatile
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	jal	scalematrix
	addu	$17,$17,1
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	addmatrix
	move	$6,$18
	.set	macro
	.set	reorder

	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L34
	move	$4,$21
	.set	macro
	.set	reorder

	addu	$3,$sp,56
	move	$2,$20
	addu	$4,$20,32
$L32:
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$9,0($3)
	sw	$10,4($3)
	sw	$7,8($3)
	sw	$8,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L32
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$9,0($2)
	sw	$9,0($3)
	addu	$4,$sp,56
	addu	$5,$sp,176
	.set	noreorder
	.set	nomacro
	jal	transmult
	move	$6,$20
	.set	macro
	.set	reorder

	addu	$22,$22,1
	slt	$2,$22,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$31,252($sp)
	lw	$fp,248($sp)
	lw	$23,244($sp)
	lw	$22,240($sp)
	lw	$21,236($sp)
	lw	$20,232($sp)
	lw	$19,228($sp)
	lw	$18,224($sp)
	lw	$17,220($sp)
	lw	$16,216($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,256
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	reorthogonalize
	.def	identitymatrix;	.val	identitymatrix;	.scl	2;	.dim	9;	.size	36;	.type	0x34;	.endef
	.def	coef;	.val	coef;	.scl	3;	.dim	4;	.size	16;	.type	0x34;	.endef
