	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\EXTSFDF2.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__extendsfdf2
	.ent	__extendsfdf2
__extendsfdf2:
	.frame	$sp,72,$31		# vars= 16, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	li	$2,0x7fff0000		# 2147418112
	ori	$2,$2,0xffff
	sw	$19,52($sp)
	addu	$19,$4,$0
	and	$2,$19,$2
	sw	$31,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	li	$2,-2147483648			# 0x80000000
	and	$17,$19,$2
	.set	noreorder
	.set	nomacro
	j	$L3
	addu	$16,$0,$0
	.set	macro
	.set	reorder

$L2:
	li	$2,0x007f0000		# 8323072
	ori	$2,$2,0xffff
	and	$3,$19,$2
	sra	$2,$19,23
	andi	$2,$2,0x00ff
	sw	$3,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$18,$2,896
	addu	$4,$sp,24
	li	$2,0x00000003		# 3
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L4:
	li	$2,-2097152			# 0xffe00000
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$18,0x0000037e		# 894
	.set	macro
	.set	reorder

	li	$21,0x00000001		# 1
	li	$20,-2097152			# 0xffe00000
$L7:
	addu	$4,$sp,24
	sw	$21,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	lw	$2,28($sp)
	#nop
	and	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L6:
	lw	$3,28($sp)
	li	$2,0x00100000		# 1048576
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	li	$4,0x00100000		# 1048576
	.set	macro
	.set	reorder

$L14:
	sll	$2,$3,1
	sw	$2,28($sp)
	addu	$3,$2,$0
	and	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	addu	$18,$18,-1
	.set	macro
	.set	reorder

$L12:
	li	$3,-1114112			# 0xffef0000
	lw	$2,28($sp)
	ori	$3,$3,0xffff
	and	$2,$2,$3
	sw	$2,28($sp)
	li	$2,-2147483648			# 0x80000000
$L16:
	and	$2,$19,$2
	sll	$3,$18,20
	lw	$4,28($sp)
	or	$2,$2,$3
	or	$17,$2,$4
	lw	$16,24($sp)
$L3:
	addu	$2,$16,$0
	addu	$3,$17,$0
	lw	$31,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	addu	$sp,$sp,72
	j	$31
	.end	__extendsfdf2
