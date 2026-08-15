	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\mcrd.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	MCRD_getcard
	.ent	MCRD_getcard
MCRD_getcard:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$4,$4,-1
	lui	$5,%hi(gMemCardInfo) # high
	addiu	$5,$5,%lo(gMemCardInfo) # low
	andi	$2,$4,0x0004
	sll	$2,$2,2
	andi	$3,$4,0x0003
	or	$2,$2,$3
	sw	$2,60($5)
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$5,$5,1180
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$5
	.set	macro
	.set	reorder

	.end	MCRD_getcard
