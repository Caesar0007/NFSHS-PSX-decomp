	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libapi\\PAD.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	ReadInitPadFlag

	.extern	_init_pad_flag, 4

	.text
	.def	ReadInitPadFlag;	.val	ReadInitPadFlag;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	ReadInitPadFlag
ReadInitPadFlag:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,_init_pad_flag
	j	$31

	.loc	1 0
LM1:
	.end	ReadInitPadFlag
