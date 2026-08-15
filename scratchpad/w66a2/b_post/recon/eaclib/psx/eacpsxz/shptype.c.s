	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\shptype.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	shapetype

	.text
	.def	shapetype;	.val	shapetype;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	shapetype
shapetype:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	shapeId;	.val	4;	.scl	17;	.type	0x4;	.endef
	addu	$3,$4,-1
	sltu	$2,$3,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi($L10) # high
	addiu	$2,$2,%lo($L10) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L10:
	.word	$L3
	.word	$L2
	.word	$L2
	.word	$L4
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L5
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L7
	.word	$L7
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L8
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L9
	.text
$L3:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,68			# 0x00000044
	.set	macro
	.set	reorder

$L4:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,65			# 0x00000041
	.set	macro
	.set	reorder

$L7:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,66			# 0x00000042
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,67			# 0x00000043
	.set	macro
	.set	reorder

$L9:
	move	$5,$0
$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	shapetype
