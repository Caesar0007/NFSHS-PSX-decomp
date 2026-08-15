	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\saetolrv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDatolrv

	.text
	.def	iSNDatolrv;	.val	iSNDatolrv;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDatolrv
iSNDatolrv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	angle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	out_l;	.val	16;	.scl	17;	.type	0x14;	.endef
	.def	out_r;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$6
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDlibatodlrv
	move	$17,$7
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L2
	subu	$2,$0,$2
	.set	macro
	.set	reorder

	sw	$2,0($16)
$L2:
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L3
	subu	$2,$0,$2
	.set	macro
	.set	reorder

	sw	$2,0($17)
$L3:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDatolrv
