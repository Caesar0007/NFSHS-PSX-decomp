	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdcdvol.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDplatformcdpanvol

	.text
	.def	iSNDplatformcdpanvol;	.val	iSNDplatformcdpanvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformcdpanvol
iSNDplatformcdpanvol:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	pan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	vol;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	addu	$6,$sp,16
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDpvtolrv
	addu	$7,$sp,20
	.set	macro
	.set	reorder

	lui	$4,%hi(sndpd) # high
	addiu	$4,$4,%lo(sndpd) # low
	lw	$3,16($sp)
	#.set	volatile
	lw	$5,1300($4)
	#.set	novolatile
	sll	$2,$3,7
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,20($sp)
	andi	$2,$2,0x7fff
	#.set	volatile
	sh	$2,432($5)
	#.set	novolatile
	sll	$2,$3,7
	addu	$2,$2,$3
	sll	$2,$2,1
	#.set	volatile
	lw	$3,1300($4)
	#.set	novolatile
	andi	$2,$2,0x7fff
	#.set	volatile
	sh	$2,434($3)
	#.set	novolatile
	lw	$31,24($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatformcdpanvol
