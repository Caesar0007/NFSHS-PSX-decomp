	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdmemlu.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDmemlargestunused

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	blk;	.val	0;	.scl	8;	.type	0xd;	.endef
	.def	sz;	.val	2;	.scl	8;	.type	0xd;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	.0fake;	.size	4;	.endef
	.def	SndSpuEnt;	.scl	13;	.tag	.0fake;	.size	4;	.type	0x8;	.endef
	.def	SNDmemlargestunused;	.val	SNDmemlargestunused;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDmemlargestunused
SNDmemlargestunused:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	out;	.val	9;	.scl	17;	.type	0x14;	.endef
	move	$9,$4
	li	$2,65			# 0x00000041
	sw	$2,0($9)
	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	lhu	$2,1304($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$7,$0
	.set	macro
	.set	reorder

	lhu	$2,1310($3)
	.set	noreorder
	.set	nomacro
	j	$L3
	addu	$7,$2,-65
	.set	macro
	.set	reorder

$L2:
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$10,$3,1308
	move	$8,$3
	addu	$6,$8,1312
$L5:
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L8
	sll	$3,$5,2
	.set	macro
	.set	reorder

	lhu	$2,0($6)
	#nop
	addu	$3,$2,-65
	slt	$2,$7,$3
	beq	$2,$0,$L10
	.set	noreorder
	.set	nomacro
	j	$L10
	move	$7,$3
	.set	macro
	.set	reorder

$L8:
	addu	$3,$3,$10
	lhu	$4,0($3)
	lhu	$2,2($3)
	lhu	$3,0($6)
	addu	$4,$4,$2
	subu	$3,$3,$4
	slt	$2,$7,$3
	beq	$2,$0,$L10
	move	$7,$3
	sw	$4,0($9)
$L10:
	lhu	$2,1304($8)
	addu	$5,$5,1
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$6,$6,4
	.set	macro
	.set	reorder

$L4:
	sll	$3,$5,2
	lui	$2,%hi(sndpd+1308) # high
	addiu	$2,$2,%lo(sndpd+1308) # low
	addu	$3,$3,$2
	lhu	$4,0($3)
	lhu	$3,2($3)
	lhu	$2,2($2)
	addu	$4,$4,$3
	subu	$3,$2,$4
	slt	$2,$7,$3
	beq	$2,$0,$L3
	move	$7,$3
	sw	$4,0($9)
$L3:
	lw	$2,0($9)
	#nop
	sll	$2,$2,6
	sw	$2,0($9)
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$7,6
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDmemlargestunused
