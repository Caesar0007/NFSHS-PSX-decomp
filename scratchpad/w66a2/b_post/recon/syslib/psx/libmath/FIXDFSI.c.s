	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\FIXDFSI.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__fixdfsi
	.ent	__fixdfsi
__fixdfsi:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	li	$2,0x7fff0000		# 2147418112
	ori	$2,$2,0xffff
	sw	$17,36($sp)
	sw	$16,32($sp)
	addu	$16,$4,$0
	addu	$17,$5,$0
	and	$2,$17,$2
	sw	$31,48($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$18,40($sp)
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
	andi	$18,$2,0x07ff
	addu	$19,$18,-1053
	.set	noreorder
	.set	nomacro
	blez	$19,$L3
	li	$4,0x00000022		# 34
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,0x00000011		# 17
	.set	macro
	.set	reorder

	li	$2,0x7fff0000		# 2147418112
	.set	noreorder
	.set	nomacro
	bgez	$17,$L8
	ori	$2,$2,0xffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L3:
	li	$2,0x000f0000		# 983040
	ori	$2,$2,0xffff
	addu	$4,$sp,24
	and	$2,$17,$2
	li	$3,0x00100000		# 1048576
	or	$2,$2,$3
	sw	$2,28($sp)
	li	$2,0x0000000a		# 10
	sw	$16,24($sp)
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	addu	$2,$18,-1022
	sltu	$2,$2,32
	lw	$3,28($sp)
	beq	$2,$0,$L9
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L6
	subu	$2,$0,$19
	.set	macro
	.set	reorder

$L9:
	.set	noreorder
	.set	nomacro
	j	$L8
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L6:
	sra	$3,$3,$2
	addu	$2,$3,$0
 #APP
 #NO_APP
	bgez	$17,$L8
	subu	$2,$0,$2
$L8:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,56
	j	$31
	.end	__fixdfsi
