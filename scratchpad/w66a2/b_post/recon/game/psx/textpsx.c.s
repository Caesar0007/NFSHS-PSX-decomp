	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\game\\psx\\textpsx.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	fortext4
	.align	2
	.globl	inittextdraw
	.align	2
	.globl	restoretextdraw

	.text
	.def	fortext4;	.val	fortext4;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	fortext4
fortext4:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	x;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	source;	.val	6;	.scl	17;	.type	0x11;	.endef
	.def	u;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	v;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	width;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	height;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	rowbytes;	.val	28;	.scl	9;	.type	0x4;	.endef
	j	$31

	.loc	1 0
LM1:
	.end	fortext4
	.def	inittextdraw;	.val	inittextdraw;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	inittextdraw
inittextdraw:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(currentfont+328) # high
	lui	$2,%hi(fortext4) # high
	addiu	$2,$2,%lo(fortext4) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,%lo(currentfont+328)($3)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	inittextdraw
	.def	restoretextdraw;	.val	restoretextdraw;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	restoretextdraw
restoretextdraw:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(currentfont+148) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,%lo(currentfont+148)($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	restoretextdraw
