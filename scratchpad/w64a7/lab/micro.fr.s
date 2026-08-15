	.file	1 "micro.i"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f
	.ent	f
f:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,gs
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L2
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	la	$16,g
$L3:
	lw	$2,ch
	lw	$3,fp
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$4,0($2)
	jal	$31,$3
	lw	$2,gs
	#nop
	bgtz	$2,$L3
$L2:
	li	$2,0x00000001		# 1
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	f
