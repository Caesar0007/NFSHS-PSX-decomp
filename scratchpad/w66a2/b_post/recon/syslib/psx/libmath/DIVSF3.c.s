	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\DIVSF3.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__divsf3
	.ent	__divsf3
__divsf3:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	addu	$6,$4,$0
	sra	$3,$6,23
	andi	$3,$3,0x00ff
	sra	$2,$5,23
	andi	$2,$2,0x00ff
	subu	$8,$3,$2
	addu	$7,$8,126
	li	$4,0x7fff0000		# 2147418112
	ori	$4,$4,0xffff
	li	$2,-2147483648			# 0x80000000
	and	$3,$6,$2
	and	$2,$5,$2
	sw	$16,16($sp)
	xor	$16,$3,$2
	and	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	li	$2,0x4f000000		# 1325400064
 #APP
 #NO_APP
	beq	$16,$0,$L19
	.set	noreorder
	.set	nomacro
	j	$L19
	li	$2,0x4f800000		# 1333788672
	.set	macro
	.set	reorder

$L2:
	and	$2,$6,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	li	$2,0x007f0000		# 8323072
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L19
	addu	$2,$16,$0
	.set	macro
	.set	reorder

$L5:
	ori	$2,$2,0xffff
	and	$3,$6,$2
	li	$4,0x00800000		# 8388608
	or	$6,$3,$4
	and	$2,$5,$2
	or	$5,$2,$4
	slt	$2,$6,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	li	$3,0x01000000		# 16777216
	.set	macro
	.set	reorder

	sll	$6,$6,1
	addu	$7,$8,125
$L20:
	addu	$4,$0,$0
$L8:
	slt	$2,$6,$5
	bne	$2,$0,$L11
	or	$4,$4,$3
	subu	$6,$6,$5
$L11:
	sra	$3,$3,1
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L8
	sll	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$7,$L13
	subu	$3,$0,$7
	.set	macro
	.set	reorder

	addu	$4,$4,1
	addu	$7,$7,1
	.set	noreorder
	.set	nomacro
	j	$L14
	sra	$4,$4,1
	.set	macro
	.set	reorder

$L13:
	li	$2,0x00000001		# 1
	sll	$2,$2,$3
	addu	$4,$4,$2
	addu	$3,$3,1
	sra	$4,$4,$3
	addu	$7,$0,$0
$L14:
	li	$2,-8454144			# 0xff7f0000
	ori	$2,$2,0xffff
	and	$4,$4,$2
	slt	$2,$7,255
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	sll	$2,$7,23
	.set	macro
	.set	reorder

	li	$4,0x00000022		# 34
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,0x0000000e		# 14
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L16
	li	$4,0x7f800000		# 2139095040
	.set	macro
	.set	reorder

	li	$4,-8388608			# 0xff800000
$L16:
	.set	noreorder
	.set	nomacro
	j	$L18
	addu	$6,$4,$0
	.set	macro
	.set	reorder

$L15:
	or	$2,$16,$2
	or	$6,$2,$4
$L18:
	addu	$2,$6,$0
$L19:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__divsf3
