	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\FLTSIDF.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__floatsidf
	.ent	__floatsidf
__floatsidf:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,44($sp)
	addu	$19,$0,$0
	sw	$18,40($sp)
	li	$18,0x0000041d		# 1053
	sw	$31,48($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L2
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	addu	$16,$0,$0
	.set	noreorder
	.set	nomacro
	j	$L16
	addu	$17,$0,$0
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L17
	li	$2,0x00ff0000		# 16711680
	.set	macro
	.set	reorder

	li	$19,-2147483648			# 0x80000000
	subu	$4,$0,$4
$L17:
	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	li	$2,0x3fff0000		# 1073676288
	.set	macro
	.set	reorder

	li	$3,0x00ff0000		# 16711680
	ori	$3,$3,0xffff
$L7:
	sll	$4,$4,4
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	addu	$18,$18,-4
	.set	macro
	.set	reorder

	li	$2,0x3fff0000		# 1073676288
$L18:
	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	li	$2,0x0000000a		# 10
	.set	macro
	.set	reorder

	li	$3,0x3fff0000		# 1073676288
	ori	$3,$3,0xffff
$L12:
	sll	$4,$4,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	li	$2,0x0000000a		# 10
$L19:
	sw	$4,28($sp)
	addu	$4,$sp,24
	sw	$0,24($sp)
	sw	$2,16($sp)
	lw	$6,24($sp)
	lw	$7,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_dbl_shift_us
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$2,-1114112			# 0xffef0000
	lw	$3,28($sp)
	ori	$2,$2,0xffff
	and	$3,$3,$2
	or	$17,$3,$19
	sll	$2,$18,20
	or	$17,$17,$2
	lw	$16,24($sp)
	sw	$3,28($sp)
$L16:
	addu	$2,$16,$0
	addu	$3,$17,$0
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	addu	$sp,$sp,56
	j	$31
	.end	__floatsidf
