	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\REG11.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetFarColor

	.text
	.def	SetFarColor;	.val	SetFarColor;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetFarColor
SetFarColor:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	r;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	g;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	b;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$4,$4,4
	sll	$5,$5,4
	sll	$6,$6,4
 #APP
	ctc2 $4,$21
	ctc2 $5,$22
	ctc2 $6,$23
 #NO_APP
	j	$31

	.loc	1 0
LM1:
	.end	SetFarColor
