	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P09.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	TermPrim

	.text
	.def	TermPrim;	.val	TermPrim;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	TermPrim
TermPrim:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x11;	.endef
	li	$3,16711680			# 0x00ff0000
	lw	$2,0($4)
	ori	$3,$3,0xffff
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	TermPrim
