	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\game\\psx\\unpack.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	unpackz
	.align	2
	.globl	unpack
	.align	2
	.globl	unpacksizez
	.align	2
	.globl	unpacksize

	.text
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	unpackz;	.val	unpackz;	.scl	2;	.type	0x25;	.endef
	.text
	.ent	unpackz
unpackz:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	dst;	.val	5;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$3,1($4)
	li	$2,251			# 0x000000fb
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L3
	move	$6,$0
	.set	macro
	.set	reorder

	li	$2,50			# 0x00000032
	bne	$3,$2,$L2
$L3:
	lbu	$2,0($4)
	#nop
	andi	$3,$2,0x00fe
	li	$2,50			# 0x00000032
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L8
	slt	$2,$3,51
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	li	$2,48			# 0x00000030
	.set	macro
	.set	reorder

	beq	$3,$2,$L8
	j	$L2
$L12:
	li	$2,52			# 0x00000034
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L8
	li	$2,70			# 0x00000046
	.set	macro
	.set	reorder

	beq	$3,$2,$L9
	j	$L2
$L5:
	.set	noreorder
	.set	nomacro
	jal	unrefpack
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L2
	move	$6,$2
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	jal	unhuff
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L2
	move	$6,$2
	.set	macro
	.set	reorder

$L9:
	jal	unbtree
	move	$6,$2
$L2:
	lw	$31,16($sp)
	move	$2,$6
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	unpackz
	.def	unpack;	.val	unpack;	.scl	2;	.type	0x25;	.endef
	.text
	.ent	unpack
unpack:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	dst;	.val	5;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	unpackz
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	unpack
	.def	unpacksizez;	.val	unpacksizez;	.scl	2;	.type	0x25;	.endef
	.text
	.ent	unpacksizez
unpacksizez:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$3,1($4)
	li	$2,251			# 0x000000fb
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L17
	move	$5,$0
	.set	macro
	.set	reorder

	li	$2,50			# 0x00000032
	bne	$3,$2,$L32
$L17:
	lbu	$2,0($4)
	#nop
	andi	$3,$2,0x00fe
	li	$2,50			# 0x00000032
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L19
	slt	$2,$3,51
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	li	$2,24			# 0x00000018
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L19
	slt	$2,$3,25
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L33
	addu	$4,$4,2
	.set	macro
	.set	reorder

	j	$L32
$L22:
	li	$2,48			# 0x00000030
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L33
	addu	$4,$4,2
	.set	macro
	.set	reorder

	j	$L32
$L20:
	li	$2,70			# 0x00000046
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L19
	slt	$2,$3,71
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	li	$2,52			# 0x00000034
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L33
	addu	$4,$4,2
	.set	macro
	.set	reorder

	j	$L32
$L28:
	li	$2,74			# 0x0000004a
	bne	$3,$2,$L32
	.def	ok;	.val	$L19;	.scl	6;	.type	0x0;	.endef
$L19:
	addu	$4,$4,2
$L33:
	.set	noreorder
	.set	nomacro
	jal	getm
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	move	$5,$2
	.def	done;	.val	$L32;	.scl	6;	.type	0x0;	.endef
$L32:
	lw	$31,16($sp)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	unpacksizez
	.def	unpacksize;	.val	unpacksize;	.scl	2;	.type	0x25;	.endef
	.text
	.ent	unpacksize
unpacksize:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	unpacksizez
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	unpacksize
