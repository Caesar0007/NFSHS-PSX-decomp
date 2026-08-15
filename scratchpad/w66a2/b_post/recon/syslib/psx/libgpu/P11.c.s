	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P11.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetShadeTex

	.text
	.def	SetShadeTex;	.val	SetShadeTex;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetShadeTex
SetShadeTex:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	tge;	.val	5;	.scl	17;	.type	0x4;	.endef
	beq	$5,$0,$L2
	lbu	$2,7($4)
	.set	noreorder
	.set	nomacro
	j	$L3
	ori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L2:
	lbu	$2,7($4)
	#nop
	andi	$2,$2,0x00fe
$L3:
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,7($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SetShadeTex
