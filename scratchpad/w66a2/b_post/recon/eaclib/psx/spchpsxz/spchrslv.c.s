	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchrslv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SPCH_ResolveData

	.text
	.def	SPCH_ResolveData;	.val	SPCH_ResolveData;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_ResolveData
SPCH_ResolveData:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	dat;	.val	4;	.scl	17;	.type	0x1d;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	iSPCH_BindData
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SPCH_ResolveData
