	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\shpclut.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	getshapeclut
	.align	2
	.globl	shapetoclutid

	.text
	.def	getshapeclut;	.val	getshapeclut;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	getshapeclut
getshapeclut:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	shape;	.val	4;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	li	$6,35			# 0x00000023
	.set	macro
	.set	reorder

	li	$5,-256			# 0xffffff00
$L3:
	lbu	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$6,$L11
	move	$2,$4
	.set	macro
	.set	reorder

	lw	$3,0($4)
	#nop
	and	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	sra	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L7:
	move	$2,$0
$L8:
	move	$4,$2
	bne	$4,$0,$L3
$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L11:
	j	$31

	.loc	1 0
LM1:
	.end	getshapeclut
	.def	shapetoclutid;	.val	shapetoclutid;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	shapetoclutid
shapetoclutid:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	shape;	.val	4;	.scl	17;	.type	0x1e;	.endef
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L13
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.def	loop;	.val	$L14;	.scl	6;	.type	0x0;	.endef
$L14:
	lbu	$2,0($4)
	li	$3,35			# 0x00000023
	andi	$2,$2,0x00f7
	bne	$2,$3,$L15
	lw	$4,12($4)
	#nop
	sll	$5,$4,4
	sll	$4,$4,20
	sra	$4,$4,20
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sra	$5,$5,20
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$L19
	sra	$2,$2,16
	.set	macro
	.set	reorder

$L15:
	lw	$3,0($4)
	li	$2,-256			# 0xffffff00
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	sra	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L17
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L16:
	move	$4,$0
$L17:
	bne	$4,$0,$L14
$L13:
	move	$2,$0
$L19:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	shapetoclutid
