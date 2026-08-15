	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\COR_02.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	ccos

	.text
	.def	ccos;	.val	ccos;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	ccos
ccos:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	a;	.val	3;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	move	$3,$4
	.set	noreorder
	.set	nomacro
	bgez	$3,$L2
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L2:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L3
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,4095
$L3:
	sra	$2,$2,12
	sll	$2,$2,12
	subu	$3,$3,$2
	sltu	$2,$3,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
 #APP
 #NO_APP
	j	$L1
$L4:
	addu	$2,$3,-1024
	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$4,2047			# 0x000007ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L9
	subu	$4,$4,$3
	.set	macro
	.set	reorder

$L5:
	addu	$4,$3,-2048
	sltu	$2,$4,1024
	beq	$2,$0,$L6
$L9:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L1
	subu	$2,$0,$2
	.set	macro
	.set	reorder

$L6:
	addu	$2,$3,-3072
	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1
	li	$4,4095			# 0x00000fff
	.set	macro
	.set	reorder

	subu	$4,$4,$3
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
$L1:
	lw	$31,24($sp)
	#nop
	addu	$sp,$sp,32
	j	$31


	.loc	1 0
LM1:
	.end	ccos
