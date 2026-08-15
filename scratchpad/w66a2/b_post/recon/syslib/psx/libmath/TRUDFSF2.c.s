	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\TRUDFSF2.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__truncdfsf2

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	lo;	.val	0;	.scl	8;	.type	0xe;	.endef
	.def	hi;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.0fake;	.size	8;	.endef
	.def	.1fake;	.scl	12;	.type	0x9;	.size	8;	.endef
	.def	d;	.val	0;	.scl	11;	.type	0x7;	.endef
	.def	w;	.val	0;	.scl	11;	.tag	.0fake;	.size	8;	.type	0x8;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.1fake;	.size	8;	.endef
	.def	double_long;	.scl	13;	.tag	.1fake;	.size	8;	.type	0x9;	.endef
	.def	__truncdfsf2;	.val	__truncdfsf2;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	__truncdfsf2
__truncdfsf2:
	.frame	$sp,64,$31		# vars= 16, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x7;	.endef
	subu	$sp,$sp,64
	li	$2,2147418112			# 0x7fff0000
	ori	$2,$2,0xffff
	sw	$17,44($sp)
	sw	$16,40($sp)
	move	$16,$4
	move	$17,$5
	and	$2,$17,$2
	sw	$31,56($sp)
	sw	$19,52($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$18,48($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L2
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	and	$2,$17,$2
	.set	macro
	.set	reorder

$L2:
	sra	$2,$17,20
	andi	$19,$2,0x07ff
	addu	$18,$19,-896
	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	addu	$4,$sp,32
	and	$2,$17,$2
	li	$3,1048576			# 0x00100000
	or	$2,$2,$3
	sw	$2,28($sp)
	li	$2,4			# 0x00000004
	sw	$16,24($sp)
	sw	$2,16($sp)
	#.set	volatile
	lw	$6,24($sp)
	#.set	novolatile
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	blez	$18,$L3
	li	$2,-16777216			# 0xff000000
	.set	macro
	.set	reorder

	addu	$5,$5,1
	srl	$5,$5,1
	and	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	li	$2,-8454144			# 0xff7f0000
	.set	macro
	.set	reorder

	srl	$5,$5,1
	.set	noreorder
	.set	nomacro
	j	$L9
	addu	$18,$19,-895
	.set	macro
	.set	reorder

$L3:
	subu	$2,$0,$18
	addu	$4,$2,1
	li	$3,1			# 0x00000001
	sll	$3,$3,$4
	addu	$5,$5,$3
	addu	$2,$2,2
	srl	$5,$5,$2
	move	$18,$0
	li	$2,-8454144			# 0xff7f0000
$L9:
	ori	$2,$2,0xffff
	and	$5,$5,$2
	slt	$2,$18,255
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	li	$4,34			# 0x00000022
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$17,$L8
	li	$2,2139095040			# 0x7f800000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-8388608			# 0xff800000
	.set	macro
	.set	reorder

$L6:
	and	$2,$17,$2
	sll	$3,$18,23
	or	$2,$2,$3
	or	$2,$2,$5
$L8:
	lw	$31,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	__truncdfsf2
