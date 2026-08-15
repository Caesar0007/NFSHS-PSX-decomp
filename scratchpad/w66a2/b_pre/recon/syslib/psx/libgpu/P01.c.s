	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P01.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	GetClut

	.text
	.def	GetClut;	.val	GetClut;	.scl	2;	.type	0x2d;	.endef
	.text
	.ent	GetClut
GetClut:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	x;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	5;	.scl	17;	.type	0x4;	.endef
	sll	$2,$5,6
	sra	$4,$4,4
	andi	$4,$4,0x003f
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0xffff
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	GetClut
