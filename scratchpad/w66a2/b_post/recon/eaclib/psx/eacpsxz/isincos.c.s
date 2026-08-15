	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\isincos.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	intsincos

	.extern	sintbl, 1028

	.text
	.def	intsincos;	.val	intsincos;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	intsincos
intsincos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	angle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	psin;	.val	5;	.scl	17;	.type	0x14;	.endef
	.def	pcos;	.val	6;	.scl	17;	.type	0x14;	.endef
	sra	$2,$4,8
	andi	$3,$2,0x0003
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L4
	andi	$4,$4,0x00ff
	.set	macro
	.set	reorder

	slt	$2,$3,2
	beq	$2,$0,$L9
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L3
	lui	$3,%hi(sintbl) # high
	.set	macro
	.set	reorder

	j	$31
$L9:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	sll	$2,$4,2
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L6
	lui	$3,%hi(sintbl) # high
	.set	macro
	.set	reorder

	j	$31
$L3:
	addiu	$3,$3,%lo(sintbl) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
	li	$2,256			# 0x00000100
	subu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L10
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L4:
	lui	$3,%hi(sintbl) # high
	addiu	$3,$3,%lo(sintbl) # low
	li	$2,256			# 0x00000100
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,0($5)
	sll	$2,$4,2
$L11:
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L5:
	lui	$3,%hi(sintbl) # high
	addiu	$3,$3,%lo(sintbl) # low
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	subu	$2,$0,$2
	sw	$2,0($5)
	li	$2,256			# 0x00000100
	subu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L11
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L6:
	addiu	$3,$3,%lo(sintbl) # low
	li	$2,256			# 0x00000100
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	subu	$2,$0,$2
	sw	$2,0($5)
	sll	$2,$4,2
$L10:
	addu	$2,$2,$3
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	intsincos
