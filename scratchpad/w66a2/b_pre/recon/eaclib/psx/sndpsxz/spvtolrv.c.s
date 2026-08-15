	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spvtolrv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDpvtolrv

	.text
	.def	iSNDpvtolrv;	.val	iSNDpvtolrv;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpvtolrv
iSNDpvtolrv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	pan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	out_l;	.val	6;	.scl	17;	.type	0x14;	.endef
	.def	out_r;	.val	7;	.scl	17;	.type	0x14;	.endef
	li	$2,64			# 0x00000040
	sw	$5,0($6)
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L5
	sw	$5,0($7)
	.set	macro
	.set	reorder

	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,127			# 0x0000007f
	.set	macro
	.set	reorder

	mult	$5,$4
	mflo	$3
	#nop
	#nop
	sra	$2,$3,6
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

$L3:
	subu	$2,$2,$4
	mult	$5,$2
	mflo	$3
	#nop
	#nop
	sra	$2,$3,6
	sw	$2,0($6)
$L5:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDpvtolrv
