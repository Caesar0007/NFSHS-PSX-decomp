	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\COR_03.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	csin

	.text
	.def	csin;	.val	csin;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	csin
csin:
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
	bne	$2,$0,$L20
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$2,$3,-1024
	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$4,2047			# 0x000007ff
	.set	macro
	.set	reorder

	subu	$4,$4,$3
$L20:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$6,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L19
	subu	$2,$0,$6
	.set	macro
	.set	reorder

$L6:
	addu	$4,$3,-2048
	sltu	$2,$4,1024
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$3,-3072
	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$4,4095			# 0x00000fff
	.set	macro
	.set	reorder

	subu	$4,$4,$3
	addu	$5,$sp,16
$L24:
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	subu	$6,$0,$2
$L5:
	.set	noreorder
	.set	nomacro
	j	$L19
	subu	$2,$0,$6
	.set	macro
	.set	reorder

$L2:
	sra	$2,$3,12
	sll	$2,$2,12
	subu	$3,$3,$2
	sltu	$2,$3,1024
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L22
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$2,$3,-1024
	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	li	$4,2047			# 0x000007ff
	.set	macro
	.set	reorder

	subu	$4,$4,$3
$L22:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L19
	move	$2,$5
	.set	macro
	.set	reorder

$L14:
	addu	$4,$3,-2048
	sltu	$2,$4,1024
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$2,$3,-3072
	.set	macro
	.set	reorder

	sltu	$2,$2,1024
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	li	$4,4095			# 0x00000fff
	.set	macro
	.set	reorder

	subu	$4,$4,$3
$L23:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	csincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	subu	$5,$0,$2
$L13:
	move	$2,$5
$L19:
	lw	$31,24($sp)
	#nop
	addu	$sp,$sp,32
	j	$31


	.loc	1 0
LM1:
	.end	csin
