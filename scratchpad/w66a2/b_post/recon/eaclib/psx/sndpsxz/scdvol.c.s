	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\scdvol.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDcdvol

	.extern	sndcdvs, 12

	.text
	.def	SNDcdvol;	.val	SNDcdvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDcdvol
SNDcdvol:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	vol_l;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	vol_r;	.val	5;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+61) # high
	lb	$2,%lo(sndgs+61)($2)
	#nop
	mult	$4,$2
	mflo	$4
	#nop
	li	$2,-2130575360			# 0x81020000
	ori	$2,$2,0x0409
	mult	$4,$2
	subu	$sp,$sp,24
	lui	$3,%hi(sndcdvs) # high
	sw	$31,16($sp)
	addiu	$2,$3,%lo(sndcdvs) # low
	mfhi	$7
	#nop
	#nop
	addu	$5,$7,$4
	sra	$5,$5,6
	sra	$4,$4,31
	subu	$5,$5,$4
	sh	$5,2($2)
	sll	$5,$5,16
	lh	$4,%lo(sndcdvs)($3)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformcdpanvol
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDcdvol
