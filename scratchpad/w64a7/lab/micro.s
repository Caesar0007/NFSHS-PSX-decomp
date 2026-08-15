	.file	1 "micro.i"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -da -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	f
	.ent	f
f:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,ch
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$16,24($sp)
	sll	$2,$2,2
	lw	$2,g($2)
	la	$3,g
	.set	noreorder
	.set	nomacro
	blez	$2,$L7
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	move	$16,$3
$L3:
	lw	$2,fp
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,ch
	#nop
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L3
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L7:
	lw	$31,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	f
