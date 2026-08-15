	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\REG13.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetGeomScreen

	.text
	.def	SetGeomScreen;	.val	SetGeomScreen;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetGeomScreen
SetGeomScreen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	h;	.val	4;	.scl	17;	.type	0x4;	.endef
 #APP
	ctc2 $4,$26
 #NO_APP
	j	$31

	.loc	1 0
LM1:
	.end	SetGeomScreen
