	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sballoc.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDbankalloc

	.text
	.def	iSNDbankalloc;	.val	iSNDbankalloc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDbankalloc
iSNDbankalloc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(sndgs) # high
	addiu	$2,$2,%lo(sndgs) # low
	lhu	$4,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	move	$3,$0
	.set	macro
	.set	reorder

	move	$5,$4
	lw	$4,152($2)
$L3:
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	addu	$4,$4,12
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

$L9:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDbankalloc
