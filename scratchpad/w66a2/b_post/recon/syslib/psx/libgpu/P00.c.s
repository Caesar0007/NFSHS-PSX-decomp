	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P00.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	GetTPage

	.text
	.def	GetTPage;	.val	GetTPage;	.scl	2;	.type	0x2d;	.endef
	.text
	.ent	GetTPage
GetTPage:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	tp;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	abr;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	x;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	7;	.scl	17;	.type	0x4;	.endef
	andi	$2,$4,0x0003
	sll	$2,$2,7
	andi	$5,$5,0x0003
	sll	$5,$5,5
	or	$2,$2,$5
	andi	$3,$7,0x0100
	sra	$3,$3,4
	or	$2,$2,$3
	andi	$6,$6,0x03ff
	sra	$6,$6,6
	or	$2,$2,$6
	andi	$7,$7,0x0200
	sll	$7,$7,2
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$2,$7
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	GetTPage
