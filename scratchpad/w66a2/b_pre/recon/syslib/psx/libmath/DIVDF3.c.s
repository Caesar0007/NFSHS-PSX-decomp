	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\DIVDF3.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__divdf3
	.ent	__divdf3
__divdf3:
	.frame	$sp,104,$31		# vars= 48, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	addu	$8,$4,$0
	addu	$9,$5,$0
	addu	$10,$6,$0
	addu	$11,$7,$0
	sra	$3,$9,20
	andi	$3,$3,0x07ff
	sra	$2,$11,20
	andi	$2,$2,0x07ff
	subu	$3,$3,$2
	sw	$17,76($sp)
	addu	$17,$3,1022
	li	$3,0x7fff0000		# 2147418112
	ori	$3,$3,0xffff
	li	$2,-2147483648			# 0x80000000
	and	$4,$9,$2
	and	$2,$11,$2
	sw	$20,88($sp)
	xor	$20,$4,$2
	and	$3,$11,$3
	sw	$31,96($sp)
	sw	$21,92($sp)
	sw	$19,84($sp)
	sw	$18,80($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L2
	sw	$16,72($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$10,$0,$L2
	li	$2,0x7fff0000		# 2147418112
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L3
	ori	$2,$2,0xffff
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L3:
	addu	$19,$2,$0
	.set	noreorder
	.set	nomacro
	j	$L5
	li	$18,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L2:
	li	$2,0x7fff0000		# 2147418112
	ori	$2,$2,0xffff
	and	$2,$9,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L21
	li	$7,0x000f0000		# 983040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L22
	ori	$7,$7,0xffff
	.set	macro
	.set	reorder

	addu	$19,$20,$0
	.set	noreorder
	.set	nomacro
	j	$L5
	addu	$18,$0,$0
	.set	macro
	.set	reorder

$L21:
	ori	$7,$7,0xffff
$L22:
	addu	$4,$8,$0
	and	$5,$9,$7
	li	$2,0x00100000		# 1048576
	or	$5,$5,$2
	addu	$6,$10,$0
	and	$7,$11,$7
	or	$7,$7,$2
	sw	$5,52($sp)
	sw	$8,48($sp)
	sw	$7,60($sp)
	.set	noreorder
	.set	nomacro
	jal	_comp_mant
	sw	$10,56($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L23
	addu	$21,$sp,48
	.set	macro
	.set	reorder

	addu	$4,$sp,48
	addu	$5,$0,$0
	li	$2,0x00000001		# 1
	sw	$2,16($sp)
	lw	$6,48($sp)
	lw	$7,52($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$17,$17,-1
	.set	macro
	.set	reorder

	addu	$21,$sp,48
$L23:
	li	$16,0x00000001		# 1
	li	$2,0x00200000		# 2097152
	sw	$2,36($sp)
	sw	$0,32($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
$L9:
	lw	$4,48($sp)
	lw	$5,52($sp)
	lw	$6,56($sp)
	lw	$7,60($sp)
	jal	_comp_mant
	.set	noreorder
	.set	nomacro
	bltz	$2,$L12
	addu	$4,$sp,64
	.set	macro
	.set	reorder

	lw	$5,56($sp)
	lw	$6,60($sp)
	lw	$2,28($sp)
	lw	$7,36($sp)
	lw	$3,24($sp)
	lw	$8,32($sp)
	or	$2,$2,$7
	or	$3,$3,$8
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_mainasu
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	lw	$2,68($sp)
	#nop
	sw	$2,16($sp)
	lw	$7,64($sp)
	lw	$5,48($sp)
	lw	$6,52($sp)
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
	addu	$4,$21,$0
	.set	macro
	.set	reorder

$L12:
	addu	$4,$sp,48
	sw	$16,16($sp)
	lw	$6,48($sp)
	lw	$7,52($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sw	$16,16($sp)
	lw	$6,32($sp)
	lw	$7,36($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$2,36($sp)
	#nop
	bne	$2,$0,$L9
	lw	$2,32($sp)
	#nop
	bne	$2,$0,$L9
	.set	noreorder
	.set	nomacro
	bltz	$17,$L14
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	li	$16,0x00000001		# 1
	sw	$0,44($sp)
	sw	$16,40($sp)
	sw	$0,16($sp)
	lw	$7,40($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	j	$L20
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L14:
	subu	$16,$0,$17
	li	$2,0x00000001		# 1
	sll	$2,$2,$16
	addu	$16,$16,1
	sw	$0,44($sp)
	sw	$2,40($sp)
	sw	$0,16($sp)
	lw	$7,40($sp)
	lw	$5,24($sp)
	lw	$6,28($sp)
	addu	$17,$0,$0
$L20:
	.set	noreorder
	.set	nomacro
	jal	_add_mant_d
 #APP
	.set	macro
	.set	reorder

 #NO_APP
	addu	$4,$sp,24
	sw	$16,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$3,-1114112			# 0xffef0000
	lw	$2,28($sp)
	ori	$3,$3,0xffff
	and	$3,$2,$3
	slt	$2,$17,2047
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L16
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	li	$4,0x00000022		# 34
	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,0x0000000f		# 15
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L17
	li	$2,0x7ff00000		# 2146435072
	.set	macro
	.set	reorder

	li	$2,-1048576			# 0xfff00000
$L17:
	addu	$19,$2,$0
	.set	noreorder
	.set	nomacro
	j	$L5
	addu	$18,$0,$0
	.set	macro
	.set	reorder

$L16:
	sll	$2,$17,20
	or	$2,$20,$2
	or	$19,$2,$3
	lw	$18,24($sp)
$L5:
	addu	$2,$18,$0
	addu	$3,$19,$0
	lw	$31,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	addu	$sp,$sp,104
	j	$31
	.end	__divdf3
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl _comp_mant
_comp_mant:
	sltu	$v0,$a3,$a1
	sw	$a0,0($sp)
	sw	$a1,4($sp)
	sw	$a2,8($sp)
	bnez	$v0,.L800F60F8
	 sw	$a3,12($sp)
	sltu	$v0,$a1,$a3
	bnez	$v0,.L800F60FC
	 addiu	$v0,$zero,-1
	sltu	$v0,$a2,$a0
	bnez	$v0,.L800F60FC
	 addiu	$v0,$zero,1
	sltu	$v1,$a0,$a2
	bnez	$v1,.L800F60FC
	 addiu	$v0,$zero,-1
	j	.L800F60FC
	 addu	$v0,$zero,$zero
.L800F60F8:
	addiu	$v0,$zero,1
.L800F60FC:
	jr	$ra
	 nop
	.set pop

