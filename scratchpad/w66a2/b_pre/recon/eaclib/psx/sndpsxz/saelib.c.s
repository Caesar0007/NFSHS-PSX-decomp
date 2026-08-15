	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\saelib.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDlibatodlrv

	.text
	.def	iSNDlibatodlrv;	.val	iSNDlibatodlrv;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDlibatodlrv
iSNDlibatodlrv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	angle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	out_l;	.val	16;	.scl	17;	.type	0x14;	.endef
	.def	out_r;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDsin
	sra	$4,$4,6
	.set	macro
	.set	reorder

	move	$3,$2
	li	$4,65536			# 0x00010000
	subu	$2,$4,$3
	mult	$17,$2
	mflo	$8
	#nop
	#nop
	srl	$2,$8,16
	sw	$2,0($16)
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$2,$3,$4
	.set	macro
	.set	reorder

	li	$2,127			# 0x0000007f
	sw	$2,0($16)
	addu	$2,$3,$4
$L5:
	mult	$17,$2
	mflo	$8
	#nop
	#nop
	srl	$2,$8,16
	sw	$2,0($18)
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	li	$2,127			# 0x0000007f
	.set	macro
	.set	reorder

	sw	$2,0($18)
$L4:
	lw	$31,28($sp)
	lw	$18,24($sp)
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
	.end	iSNDlibatodlrv
