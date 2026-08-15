	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P06.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	AddPrim

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	addr;	.val	0;	.scl	18;	.type	0xe;	.size	24;	.endef
	.def	len;	.val	24;	.scl	18;	.type	0xe;	.size	8;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	.0fake;	.size	4;	.endef
	.def	P_TAG;	.scl	13;	.tag	.0fake;	.size	4;	.type	0x8;	.endef
	.def	AddPrim;	.val	AddPrim;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	AddPrim
AddPrim:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	ot;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	p;	.val	5;	.scl	17;	.type	0x11;	.endef
	li	$6,16711680			# 0x00ff0000
	ori	$6,$6,0xffff
	li	$7,-16777216			# 0xff000000
	lw	$3,0($5)
	lw	$2,0($4)
	and	$3,$3,$7
	and	$2,$2,$6
	or	$3,$3,$2
	sw	$3,0($5)
	lw	$2,0($4)
	and	$5,$5,$6
	and	$2,$2,$7
	or	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	AddPrim
