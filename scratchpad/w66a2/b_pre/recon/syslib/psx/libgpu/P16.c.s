	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P16.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetPolyF4

	.text
	.def	SetPolyF4;	.val	SetPolyF4;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetPolyF4
SetPolyF4:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x11;	.endef
	li	$2,5			# 0x00000005
	sb	$2,3($4)
	li	$2,40			# 0x00000028
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,7($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SetPolyF4
