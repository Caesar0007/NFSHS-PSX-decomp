	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\ssine.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDsin

	.text
	.def	iSNDsin;	.val	iSNDsin;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDsin
iSNDsin:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x4;	.endef
	sra	$2,$4,8
	andi	$3,$2,0x0003
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L2
	andi	$4,$4,0x00ff
	.set	macro
	.set	reorder

	lui	$3,%hi(snd_sine_table) # high
	addiu	$3,$3,%lo(snd_sine_table) # low
	sll	$2,$4,1
$L6:
	addu	$2,$2,$3
	lhu	$2,0($2)
	j	$31
$L2:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L3
	li	$2,256			# 0x00000100
	.set	macro
	.set	reorder

	lui	$3,%hi(snd_sine_table) # high
	addiu	$3,$3,%lo(snd_sine_table) # low
	subu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L6
	sll	$2,$2,1
	.set	macro
	.set	reorder

$L3:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L4
	sll	$3,$4,1
	.set	macro
	.set	reorder

	lui	$2,%hi(snd_sine_table) # high
	addiu	$2,$2,%lo(snd_sine_table) # low
	li	$3,256			# 0x00000100
	subu	$3,$3,$4
	sll	$3,$3,1
	addu	$3,$3,$2
	lhu	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	subu	$2,$0,$2
	.set	macro
	.set	reorder

$L4:
	lui	$2,%hi(snd_sine_table) # high
	addiu	$2,$2,%lo(snd_sine_table) # low
	addu	$3,$3,$2
	lhu	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	subu	$2,$0,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDsin
