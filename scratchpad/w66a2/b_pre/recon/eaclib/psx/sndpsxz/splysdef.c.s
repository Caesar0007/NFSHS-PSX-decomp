	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\splysdef.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDplaysetdef

	.text
	.def	SNDplaysetdef;	.val	SNDplaysetdef;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDplaysetdef
SNDplaysetdef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	def;	.val	4;	.scl	17;	.type	0x11;	.endef
	li	$2,-1			# 0xffffffff
	sw	$2,0($4)
	sb	$2,4($4)
	li	$2,60			# 0x0000003c
	sb	$2,5($4)
	li	$2,4096			# 0x00001000
	sh	$2,12($4)
	sh	$2,14($4)
	li	$2,127			# 0x0000007f
	li	$3,64			# 0x00000040
	sb	$2,6($4)
	sb	$2,8($4)
	sb	$2,10($4)
	move	$2,$0
	sb	$3,7($4)
	sb	$3,9($4)
	sb	$0,11($4)
	sh	$0,16($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,18($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDplaysetdef
