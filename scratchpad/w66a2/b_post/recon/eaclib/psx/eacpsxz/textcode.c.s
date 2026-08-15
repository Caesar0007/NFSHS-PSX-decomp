	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\textcode.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	decodeansi

	.text
	.def	decodeansi;	.val	decodeansi;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	decodeansi
decodeansi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	cursor;	.val	4;	.scl	17;	.type	0x5c;	.endef
	lw	$3,0($4)
	#nop
	lbu	$2,0($3)
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,0($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	decodeansi
