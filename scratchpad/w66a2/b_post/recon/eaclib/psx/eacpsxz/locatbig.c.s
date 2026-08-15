	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\locatbig.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	typeofbigfile
	.align	2
	.globl	sizeofbigfileheader
	.align	2
	.globl	locatebigentryz
	.align	2
	.globl	locatebigentry
	.align	2
	.globl	locatebigoffset
	.align	2
	.globl	locatebig
	.align	2
	.globl	bigcount

	.lcomm	gLocatebigSizeSink,4

	.text
	.def	typeofbigfile;	.val	typeofbigfile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	typeofbigfile
typeofbigfile:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	17;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,49403			# 0x0000c0fb
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L2
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L3
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$3,1112080384			# 0x42490000
	ori	$3,$3,0x4746
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L5
	move	$2,$16
	.set	macro
	.set	reorder

	li	$16,2			# 0x00000002
$L3:
	move	$2,$16
$L5:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	typeofbigfile
	.def	sizeofbigfileheader;	.val	sizeofbigfileheader;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	sizeofbigfileheader
sizeofbigfileheader:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	17;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	typeofbigfile
	move	$16,$0
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L8
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L9
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L12
$L8:
	addu	$4,$17,2
	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	addu	$16,$2,4
	.set	macro
	.set	reorder

$L9:
	addu	$4,$17,12
	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$16,$2
$L7:
	move	$2,$16
$L12:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	sizeofbigfileheader
	.def	locatebigentryz;	.val	locatebigentryz;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	locatebigentryz
locatebigentryz:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	buf;	.val	16;	.scl	17;	.type	0x11;	.endef
	.def	name;	.val	19;	.scl	17;	.type	0x12;	.endef
	.def	index;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	20;	.scl	17;	.type	0x14;	.endef
	.def	size;	.val	16;	.scl	9;	.type	0x14;	.endef
	.def	size;	.val	21;	.scl	4;	.type	0x14;	.endef
	subu	$sp,$sp,48
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$22,40($sp)
	move	$22,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$17,20($sp)
	move	$17,$0
	sw	$21,36($sp)
	lw	$21,64($sp)
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	sizeofbigfileheader
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	typeofbigfile
	addu	$18,$16,$2
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L15
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L28
	j	$L14
$L15:
	addu	$16,$16,6
	sltu	$2,$16,$18
	beq	$2,$0,$L14
$L17:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L20
	addu	$4,$16,6
	.set	macro
	.set	reorder

	beq	$17,$22,$L23
	j	$L22
$L20:
	.set	noreorder
	.set	nomacro
	jal	stricmp
	move	$5,$19
	.set	macro
	.set	reorder

	bne	$2,$0,$L22
$L23:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L25
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$2,0($20)
$L25:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L26
	addu	$4,$16,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$2,0($21)
$L26:
	.set	noreorder
	.set	nomacro
	j	$L45
	addu	$2,$16,6
	.set	macro
	.set	reorder

	.def	next1;	.val	$L22;	.scl	6;	.type	0x0;	.endef
$L22:
	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$16,6
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	addu	$16,$2,7
	sltu	$2,$16,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L14
$L28:
	addu	$16,$16,16
	sltu	$2,$16,$18
	beq	$2,$0,$L14
$L30:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L33
	addu	$4,$16,8
	.set	macro
	.set	reorder

	beq	$17,$22,$L36
	j	$L35
$L33:
	.set	noreorder
	.set	nomacro
	jal	stricmp
	move	$5,$19
	.set	macro
	.set	reorder

	bne	$2,$0,$L35
$L36:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L38
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	sw	$2,0($20)
$L38:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L39
	addu	$4,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	sw	$2,0($21)
$L39:
	.set	noreorder
	.set	nomacro
	j	$L45
	addu	$2,$16,8
	.set	macro
	.set	reorder

	.def	next2;	.val	$L35;	.scl	6;	.type	0x0;	.endef
$L35:
	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$16,8
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	addu	$16,$2,9
	sltu	$2,$16,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L14:
	beq	$20,$0,$L43
	sw	$0,0($20)
$L43:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L45
	move	$2,$0
	.set	macro
	.set	reorder

	sw	$0,0($21)
$L45:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	locatebigentryz
	.def	locatebigentry;	.val	locatebigentry;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	locatebigentry
locatebigentry:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	name;	.val	5;	.scl	17;	.type	0x12;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	7;	.scl	17;	.type	0x14;	.endef
	.def	size;	.val	16;	.scl	9;	.type	0x14;	.endef
	.def	size;	.val	2;	.scl	4;	.type	0x14;	.endef
	subu	$sp,$sp,32
	lw	$2,48($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	locatebigentry
	.def	locatebigoffset;	.val	locatebigoffset;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	locatebigoffset
locatebigoffset:
	.frame	$sp,40,$31		# vars= 8, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	name;	.val	5;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,40
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L48
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	la	$2,gLocatebigSizeSink
	sw	$2,16($sp)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	addu	$7,$sp,24
	.set	macro
	.set	reorder

$L48:
	lw	$2,24($sp)
	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	locatebigoffset
	.def	locatebig;	.val	locatebig;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	locatebig
locatebig:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	17;	.scl	17;	.type	0x11;	.endef
	.def	name;	.val	5;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	locatebigoffset
	move	$16,$0
	.set	macro
	.set	reorder

	beq	$2,$0,$L50
	addu	$16,$17,$2
$L50:
	move	$2,$16
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	locatebig
	.def	bigcount;	.val	bigcount;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	bigcount
bigcount:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	buf;	.val	17;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	typeofbigfile
	move	$16,$0
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L53
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L54
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L58
$L53:
	addu	$4,$17,4
	.set	noreorder
	.set	nomacro
	j	$L57
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L54:
	addu	$4,$17,8
	li	$5,4			# 0x00000004
$L57:
	jal	getm
	move	$16,$2
	move	$2,$16
$L58:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	bigcount
	.def	gLocatebigSizeSink;	.val	gLocatebigSizeSink;	.scl	3;	.type	0x4;	.endef
