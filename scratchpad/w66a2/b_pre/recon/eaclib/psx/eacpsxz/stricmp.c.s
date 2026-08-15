	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\stricmp.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	stricmp

	.text
	.def	stricmp;	.val	stricmp;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	stricmp
stricmp:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	b;	.val	5;	.scl	17;	.type	0x1c;	.endef
$L2:
	lbu	$6,0($4)
	#nop
	addu	$2,$6,-65
	sltu	$2,$2,26
	beq	$2,$0,$L5
	addu	$6,$6,32
$L5:
	lbu	$2,0($5)
	#nop
	addu	$2,$2,-65
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	addu	$2,$6,-32
	.set	macro
	.set	reorder

	lbu	$3,0($5)
	.set	noreorder
	.set	nomacro
	j	$L7
	subu	$3,$2,$3
	.set	macro
	.set	reorder

$L6:
	lbu	$2,0($5)
	#nop
	subu	$3,$6,$2
$L7:
	bne	$3,$0,$L3
	lbu	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	addu	$4,$4,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L2
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	stricmp
