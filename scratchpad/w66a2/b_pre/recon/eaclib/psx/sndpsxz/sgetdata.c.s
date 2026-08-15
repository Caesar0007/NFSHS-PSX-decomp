	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sgetdata.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDgetdata

	.text
	.def	iSNDgetdata;	.val	iSNDgetdata;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDgetdata
iSNDgetdata:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	n;	.val	5;	.scl	17;	.type	0x4;	.endef
	move	$7,$0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L2
	addu	$6,$5,-1
	.set	macro
	.set	reorder

	li	$8,-1			# 0xffffffff
$L3:
	lbu	$3,0($4)
	addu	$4,$4,1
	addu	$6,$6,-1
	sll	$2,$7,8
	.set	noreorder
	.set	nomacro
	bne	$6,$8,$L3
	addu	$7,$2,$3
	.set	macro
	.set	reorder

$L2:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L13
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	slt	$2,$7,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	addu	$7,$7,-256
	.set	macro
	.set	reorder

$L7:
$L13:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L14
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$2,32767			# 0x00007fff
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	li	$2,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
$L14:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L8
	li	$2,8323072			# 0x007f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$2,-16777216			# 0xff000000
	.set	macro
	.set	reorder

$L12:
	addu	$7,$7,$2
$L8:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDgetdata
