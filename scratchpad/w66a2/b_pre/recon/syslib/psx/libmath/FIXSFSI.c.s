	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\FIXSFSI.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__fixsfsi
	.ent	__fixsfsi
__fixsfsi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,0x7fff0000		# 2147418112
	ori	$2,$2,0xffff
	and	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	li	$2,-2147483648			# 0x80000000
	.set	noreorder
	.set	nomacro
	j	$L11
	and	$2,$4,$2
	.set	macro
	.set	reorder

$L2:
	sra	$2,$4,23
	andi	$5,$2,0x00ff
	addu	$6,$5,-157
	.set	noreorder
	.set	nomacro
	blez	$6,$L4
	li	$3,0x00800000		# 8388608
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$4,$L5
	li	$4,0x00000022		# 34
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_err_math
	li	$5,0x00000012		# 18
	.set	macro
	.set	reorder

	li	$2,0x7fff0000		# 2147418112
	.set	noreorder
	.set	nomacro
	j	$L11
	ori	$2,$2,0xffff
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	j	$L11
	li	$2,-2147483648			# 0x80000000
	.set	macro
	.set	reorder

$L4:
	li	$2,0x007f0000		# 8323072
	ori	$2,$2,0xffff
	and	$2,$4,$2
	or	$2,$2,$3
	sll	$3,$2,7
	addu	$2,$5,-126
	sltu	$2,$2,32
	beq	$2,$0,$L8
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L8
	subu	$2,$0,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L9
	sra	$3,$3,$2
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	j	$L11
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L9:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L11
	addu	$2,$3,$0
	.set	macro
	.set	reorder

	subu	$2,$0,$2
$L11:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__fixsfsi
