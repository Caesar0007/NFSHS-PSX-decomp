	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\cluttype.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	cluttype

	.text
	.def	cluttype;	.val	cluttype;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	cluttype
cluttype:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	shapeId;	.val	4;	.scl	17;	.type	0x4;	.endef
	addu	$3,$4,-15
	sltu	$2,$3,18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi($L8) # high
	addiu	$2,$2,%lo($L8) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L8:
	.word	$L4
	.word	$L4
	.word	$L2
	.word	$L7
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L7
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L2
	.word	$L7
	.text
$L4:
	.set	noreorder
	.set	nomacro
	j	$L2
	li	$5,35			# 0x00000023
	.set	macro
	.set	reorder

$L7:
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
	.end	cluttype
