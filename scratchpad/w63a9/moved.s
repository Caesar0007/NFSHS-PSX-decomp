	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\MULDF3.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__muldf3
	.align	2
	.globl	_mul_mant_d

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
	.def	__muldf3;	.val	__muldf3;	.scl	2;	.type	0x27;	.endef
	.text
	.ent	__muldf3
__muldf3:
	.frame	$sp,128,$31		# vars= 64, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x7;	.endef
	.def	b;	.val	6;	.scl	17;	.type	0x7;	.endef
	subu	$sp,$sp,128
	li	$10,2147418112			# 0x7fff0000
	ori	$10,$10,0xffff
	move	$8,$4
	move	$9,$5
	li	$2,-2147483648			# 0x80000000
	and	$3,$9,$2
	and	$2,$7,$2
	sw	$fp,120($sp)
	xor	$fp,$3,$2
	and	$2,$9,$10
	sw	$31,124($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$21,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$16,88($sp)
	.set	macro
	.set	reorder

	beq	$8,$0,$L3
$L4:
	and	$2,$7,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	sra	$3,$9,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L16
	andi	$3,$3,0x07ff
	.set	macro
	.set	reorder

$L3:
	sw	$fp,76($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sw	$0,72($sp)
	.set	macro
	.set	reorder

$L15:
	andi	$3,$3,0x07ff
$L16:
	sra	$2,$7,20
	andi	$2,$2,0x07ff
	addu	$3,$3,$2
	addu	$23,$3,-1022
	sw	$3,80($sp)
 #APP
 #NO_APP
	li	$3,983040			# 0x000f0000
	ori	$3,$3,0xffff
	addu	$20,$sp,56
	move	$4,$20
	and	$2,$9,$3
	li	$5,1048576			# 0x00100000
	or	$2,$2,$5
	and	$3,$7,$3
	or	$3,$3,$5
	li	$19,21			# 0x00000015
	sw	$2,44($sp)
	sw	$8,40($sp)
	sw	$3,52($sp)
	sw	$6,48($sp)
	sw	$19,16($sp)
	lw	$7,56($sp)
	#.set	volatile
	lw	$6,40($sp)
	#.set	novolatile
	#.set	volatile
	lw	$7,44($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$22,56($sp)
	move	$4,$20
	sw	$19,16($sp)
	lw	$7,56($sp)
	lw	$6,48($sp)
	lw	$7,52($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,2031616			# 0x001f0000
	ori	$2,$2,0xffff
	addu	$4,$sp,24
	move	$5,$22
	lw	$18,56($sp)
	lw	$16,40($sp)
	lw	$17,48($sp)
	move	$6,$18
	and	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	_mul_mant_d
	and	$17,$17,$2
	.set	macro
	.set	reorder

	addu	$21,$sp,64
	move	$4,$21
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	_mul_mant_d
	move	$6,$18
	.set	macro
	.set	reorder

	move	$4,$20
	sw	$19,16($sp)
	#.set	volatile
	lw	$7,32($sp)
	#.set	novolatile
	lw	$6,64($sp)
	lw	$7,68($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,60($sp)
	#nop
	sw	$2,16($sp)
	#.set	volatile
	lw	$7,32($sp)
	#.set	novolatile
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	_mul_mant_d
	move	$6,$22
	.set	macro
	.set	reorder

	move	$4,$20
	sw	$19,16($sp)
	lw	$6,64($sp)
	lw	$7,68($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,60($sp)
	#nop
	sw	$2,16($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L6
	li	$16,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

	li	$2,1024			# 0x00000400
	sw	$0,36($sp)
	sw	$2,32($sp)
	sw	$0,16($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$2,11			# 0x0000000b
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	j	$L14
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L6:
 #APP
 #NO_APP
	li	$2,512			# 0x00000200
	sw	$0,36($sp)
	sw	$2,32($sp)
	sw	$0,16($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	li	$2,11			# 0x0000000b
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	j	$L14
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L8:
	li	$2,10			# 0x0000000a
	lw	$11,80($sp)
	li	$5,1			# 0x00000001
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	addu	$23,$11,-1023
$L14:
	jal	_dbl_shift_us
	li	$3,-1114112			# 0xffef0000
	lw	$2,28($sp)
	ori	$3,$3,0xffff
	and	$3,$2,$3
	slt	$2,$23,2047
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	li	$4,34			# 0x00000022
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,13			# 0x0000000d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L11
	li	$2,2146435072			# 0x7ff00000
	.set	macro
	.set	reorder

	li	$2,-1048576			# 0xfff00000
$L11:
	sw	$2,76($sp)
	.set	noreorder
	.set	nomacro
	j	$L5
	sw	$0,72($sp)
	.set	macro
	.set	reorder

$L10:
	sll	$2,$23,20
	or	$2,$fp,$2
	or	$2,$2,$3
	sw	$2,76($sp)
	lw	$11,24($sp)
	#nop
	sw	$11,72($sp)
$L5:
	lw	$2,72($sp)
	lw	$3,76($sp)
	lw	$31,124($sp)
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,128
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	__muldf3
	.def	_mul_mant_d;	.val	_mul_mant_d;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	_mul_mant_d
_mul_mant_d:
	.frame	$sp,64,$31		# vars= 16, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	out;	.val	19;	.scl	17;	.type	0x14;	.endef
	.def	x;	.val	17;	.scl	17;	.type	0xe;	.endef
	.def	y;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,64
	sw	$17,44($sp)
	move	$17,$5
	sw	$16,40($sp)
	move	$16,$6
	sw	$18,48($sp)
	andi	$18,$17,0xffff
	andi	$2,$16,0xffff
	mult	$18,$2
	mflo	$3
	#nop
	srl	$17,$17,16
	mult	$17,$2
	sw	$19,52($sp)
	move	$19,$4
	sw	$0,28($sp)
	sw	$3,24($sp)
	mflo	$2
	#nop
	#nop
	srl	$3,$2,16
	sll	$2,$2,16
	sw	$3,36($sp)
	sw	$2,32($sp)
	sw	$3,16($sp)
	#.set	volatile
	lw	$7,32($sp)
	#.set	novolatile
	lw	$5,24($sp)
	lw	$6,28($sp)
	sw	$31,56($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	srl	$16,$16,16
	mult	$18,$16
	mflo	$2
	#nop
	#nop
	srl	$3,$2,16
	sll	$2,$2,16
	sw	$3,36($sp)
	sw	$2,32($sp)
	sw	$3,16($sp)
	#.set	volatile
	lw	$7,32($sp)
	#.set	novolatile
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	mult	$17,$16
	lw	$2,28($sp)
	mflo	$3
	#nop
	#nop
	addu	$2,$2,$3
	#.set	volatile
	lw	$3,24($sp)
	#.set	novolatile
	sw	$2,28($sp)
	#.set	volatile
	lw	$4,28($sp)
	#.set	novolatile
	move	$2,$19
	sw	$3,0($2)
	sw	$4,4($2)
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
LM2:
	.end	_mul_mant_d
