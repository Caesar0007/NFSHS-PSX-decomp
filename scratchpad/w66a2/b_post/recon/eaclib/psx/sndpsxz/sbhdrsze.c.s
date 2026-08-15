	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbhdrsze.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDbankheadersize

	.text
	.def	SNDbankheadersize;	.val	SNDbankheadersize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDbankheadersize
SNDbankheadersize:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	bankId;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lb	$2,60($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sll	$2,$4,1
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	lw	$3,152($3)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$2,8($2)
	j	$31
$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDbankheadersize
