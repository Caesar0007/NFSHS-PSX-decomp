	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdtimrem.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDtimeremaining

	.text
	.def	iSNDtimeremaining;	.val	iSNDtimeremaining;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDtimeremaining
iSNDtimeremaining:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	lui	$3,%hi(D_801479F0) # high
	addiu	$3,$3,%lo(D_801479F0) # low
	addu	$3,$2,$3
	#.set	volatile
	lw	$2,8($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	li	$2,2147418112			# 0x7fff0000
	.set	macro
	.set	reorder

	lw	$2,20($3)
	lw	$4,12($3)
	#.set	volatile
	lw	$3,8($3)
	#.set	novolatile
	subu	$2,$2,$4
	divu	$2,$2,$3
	j	$31
$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	ori	$2,$2,0xffff
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDtimeremaining
