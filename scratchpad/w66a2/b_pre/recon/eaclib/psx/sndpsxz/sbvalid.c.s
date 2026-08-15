	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbvalid.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDvalidbank

	.text
	.def	iSNDvalidbank;	.val	iSNDvalidbank;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDvalidbank
iSNDvalidbank:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	bank_id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	bltz	$4,$L3
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(sndgs) # low
	lhu	$2,12($3)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sll	$2,$4,1
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

$L2:
	addu	$2,$2,$4
	lw	$3,152($3)
	sll	$2,$2,2
	addu	$3,$2,$3
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	lb	$3,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L7
	li	$2,-18			# 0xffffffee
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L7:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDvalidbank
