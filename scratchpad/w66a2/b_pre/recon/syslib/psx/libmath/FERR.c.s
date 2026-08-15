	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libmath\\FERR.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.globl	math_errno
	.section .data,"aw",@progbits
	.align	2
math_errno:
	.word	0
	.globl	math_err_point
	.align	2
math_err_point:
	.word	0
	.text
	.align	2
	.globl	_err_math
	.ent	_err_math
_err_math:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,0x00000021		# 33
	sw	$31,16($sp)
	sw	$4,math_errno
	sw	$5,math_err_point
	beq	$4,$2,$L3
	li	$2,0x00000022		# 34
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L4
	li	$4,-201326592			# 0xf4000000
	.set	macro
	.set	reorder

	j	$L2
$L3:
	li	$4,-201326592			# 0xf4000000
	ori	$4,$4,0x0002
	.set	noreorder
	.set	nomacro
	j	$L7
	li	$5,0x00000301		# 769
	.set	macro
	.set	reorder

$L4:
	ori	$4,$4,0x0002
	li	$5,0x00000302		# 770
$L7:
	jal	DeliverEvent
$L2:
	.set	noreorder
	lw	$31,16($sp)
	addu	$2,$0,$0
	j	$31
	addu	$sp,$sp,24
	.set	reorder
	.end	_err_math
