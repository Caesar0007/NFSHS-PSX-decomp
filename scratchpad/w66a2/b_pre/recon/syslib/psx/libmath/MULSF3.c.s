	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\MULSF3.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__mulsf3
	.ent	__mulsf3
__mulsf3:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$8,$4,$0
	addu	$9,$5,$0
	li	$4,2147418112			# 0x7fff0000
	ori	$4,$4,0xffff
	li	$10,-2147483648			# 0x80000000
	and	$2,$8,$10
	and	$3,$9,$10
	sw	$16,16($sp)
	xor	$16,$2,$3
	and	$2,$8,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	and	$2,$9,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	li	$2,8323072			# 0x007f0000
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	j	$L12
	addu	$2,$16,$0
	.set	macro
	.set	reorder

$L2:
	ori	$2,$2,0xffff
	sra	$6,$8,23
	and	$3,$8,$2
	li	$4,8388608			# 0x00800000
	or	$8,$3,$4
	sra	$5,$9,23
	and	$2,$9,$2
	or	$9,$2,$4
	sra	$4,$8,8
	sra	$3,$9,8
	mult	$4,$3
	mflo	$7
	#nop
	andi	$2,$8,0x00ff
	mult	$2,$3
	mflo	$8
	#nop
	andi	$2,$9,0x00ff
	mult	$2,$4
	andi	$6,$6,0x00ff
	andi	$5,$5,0x00ff
	addu	$6,$6,$5
	sra	$2,$8,8
	addu	$7,$7,$2
	mflo	$4
	#nop
	#nop
	sra	$2,$4,8
	addu	$7,$7,$2
	and	$2,$7,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	addu	$3,$6,-126
	.set	macro
	.set	reorder

	addu	$7,$7,128
	.set	noreorder
	.set	nomacro
	j	$L5
	srl	$7,$7,8
	.set	macro
	.set	reorder

$L4:
	addu	$7,$7,64
	and	$2,$7,$10
	beq	$2,$0,$L6
	.set	noreorder
	.set	nomacro
	j	$L5
	srl	$7,$7,8
	.set	macro
	.set	reorder

$L6:
	srl	$7,$7,7
	addu	$3,$6,-127
$L5:
	li	$2,-8454144			# 0xff7f0000
	ori	$2,$2,0xffff
	and	$7,$7,$2
	slt	$2,$3,255
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	sll	$2,$3,23
	.set	macro
	.set	reorder

	li	$4,34			# 0x00000022
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,12			# 0x0000000c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L9
	li	$4,2139095040			# 0x7f800000
	.set	macro
	.set	reorder

	li	$4,-8388608			# 0xff800000
$L9:
	.set	noreorder
	.set	nomacro
	j	$L11
	addu	$8,$4,$0
	.set	macro
	.set	reorder

$L8:
	or	$2,$16,$2
	or	$8,$2,$7
$L11:
	addu	$2,$8,$0
$L12:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__mulsf3
