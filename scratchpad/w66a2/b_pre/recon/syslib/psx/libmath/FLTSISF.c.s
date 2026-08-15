	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\FLTSISF.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	__floatsisf
	.ent	__floatsisf
__floatsisf:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L2
	li	$3,0x0000009d		# 157
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L18
	li	$2,0x00ff0000		# 16711680
	.set	macro
	.set	reorder

	li	$6,-2147483648			# 0x80000000
	subu	$4,$0,$4
$L18:
	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	li	$2,0x3fff0000		# 1073676288
	.set	macro
	.set	reorder

	li	$5,0x00ff0000		# 16711680
	ori	$5,$5,0xffff
$L7:
	sll	$4,$4,4
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	li	$2,0x3fff0000		# 1073676288
$L19:
	ori	$2,$2,0xffff
	slt	$2,$2,$4
	bne	$2,$0,$L17
	li	$5,0x3fff0000		# 1073676288
	ori	$5,$5,0xffff
$L12:
	sll	$4,$4,1
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	addu	$3,$3,-1
	.set	macro
	.set	reorder

$L17:
	addu	$4,$4,64
	bgez	$4,$L14
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$L15
	srl	$4,$4,8
	.set	macro
	.set	reorder

$L14:
	srl	$4,$4,7
$L15:
	sll	$2,$3,23
	or	$3,$6,$2
	li	$2,-8454144			# 0xff7f0000
	ori	$2,$2,0xffff
	and	$2,$4,$2
	or	$2,$3,$2
$L16:
	j	$31
	.end	__floatsisf
