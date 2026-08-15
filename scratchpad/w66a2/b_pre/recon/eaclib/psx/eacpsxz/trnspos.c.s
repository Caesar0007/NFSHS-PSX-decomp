	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\trnspos.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	transpose

	.text
	.def	matrixtdef;	.scl	10;	.type	0x8;	.size	36;	.endef
	.def	m;	.val	0;	.scl	8;	.dim	9;	.size	36;	.type	0x34;	.endef
	.def	.eos;	.val	36;	.scl	102;	.tag	matrixtdef;	.size	36;	.endef
	.def	matrixtdef;	.scl	13;	.tag	matrixtdef;	.size	36;	.type	0x8;	.endef
	.def	transpose;	.val	transpose;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	transpose
transpose:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	.def	dst;	.val	5;	.scl	17;	.tag	matrixtdef;	.size	36;	.type	0x18;	.endef
	bne	$4,$5,$L2
	lw	$6,12($5)
	lw	$4,4($5)
	lw	$3,8($5)
	lw	$2,20($5)
	sw	$6,4($5)
	lw	$6,24($5)
	#nop
	sw	$6,8($5)
	lw	$6,28($5)
	sw	$4,12($5)
	sw	$3,24($5)
	sw	$2,28($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,20($5)
	.set	macro
	.set	reorder

$L2:
	lw	$2,0($4)
	#nop
	sw	$2,0($5)
	lw	$2,12($4)
	#nop
	sw	$2,4($5)
	lw	$2,24($4)
	#nop
	sw	$2,8($5)
	lw	$2,4($4)
	#nop
	sw	$2,12($5)
	lw	$2,16($4)
	#nop
	sw	$2,16($5)
	lw	$2,28($4)
	#nop
	sw	$2,20($5)
	lw	$2,8($4)
	#nop
	sw	$2,24($5)
	lw	$2,20($4)
	#nop
	sw	$2,28($5)
	lw	$2,32($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,32($5)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	transpose
