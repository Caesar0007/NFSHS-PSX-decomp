	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\textcrnt.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	putm
	.align	2
	.globl	puti

	.text
	.def	putm;	.val	putm;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	putm
putm:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	dst;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	val;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	n;	.val	6;	.scl	17;	.type	0x4;	.endef
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bltz	$6,$L7
	addu	$4,$4,$6
	.set	macro
	.set	reorder

$L5:
	sb	$5,0($4)
	srl	$5,$5,8
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bgez	$6,$L5
	addu	$4,$4,-1
	.set	macro
	.set	reorder

$L7:
	j	$31

	.loc	1 0
LM1:
	.end	putm
	.def	puti;	.val	puti;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	puti
puti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	buf;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	val;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	n;	.val	6;	.scl	17;	.type	0x4;	.endef
	addu	$6,$6,-1
	bltz	$6,$L13
$L11:
	sb	$5,0($4)
	srl	$5,$5,8
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bgez	$6,$L11
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L13:
	j	$31

	.loc	1 0
LM2:
	.end	puti
