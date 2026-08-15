	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\srandom.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDrandom

	.extern	sndseed, 24

	.text
	.def	iSNDrandom;	.val	iSNDrandom;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDrandom
iSNDrandom:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(sndseed) # high
	addiu	$2,$2,%lo(sndseed) # low
	lw	$3,20($2)
	lw	$2,16($2)
	#nop
	addu	$6,$3,$2
	sltu	$3,$6,$3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L3
	move	$7,$0
	.set	macro
	.set	reorder

	sltu	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	lui	$9,%hi(sndseed) # high
	.set	macro
	.set	reorder

$L3:
	li	$7,1			# 0x00000001
	lui	$9,%hi(sndseed) # high
$L10:
	addiu	$8,$9,%lo(sndseed) # low
	#.set	volatile
	lw	$3,12($8)
	#.set	novolatile
	#.set	volatile
	lw	$4,8($8)
	#.set	novolatile
	#.set	volatile
	lw	$5,4($8)
	#.set	novolatile
	#.set	volatile
	sw	$6,16($8)
	#.set	novolatile
	addu	$2,$6,$3
	addu	$6,$2,$7
	sltu	$7,$6,$3
	addu	$2,$6,$4
	#.set	volatile
	sw	$6,12($8)
	#.set	novolatile
	addu	$6,$2,$7
	sltu	$7,$6,$4
	addu	$2,$6,$5
	#.set	volatile
	sw	$6,8($8)
	#.set	novolatile
	addu	$6,$2,$7
	#.set	volatile
	lw	$3,%lo(sndseed)($9)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($8)
	#.set	novolatile
	sltu	$7,$6,$5
	sw	$6,4($8)
	addu	$3,$6,$3
	addu	$6,$3,$7
	addu	$2,$2,1
	sw	$6,%lo(sndseed)($9)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$2,20($8)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,16($8)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$2,16($8)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,12($8)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$2,12($8)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,8($8)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$2,8($8)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,4($8)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sw	$2,4($8)
	.set	macro
	.set	reorder

	addu	$2,$6,1
	sw	$2,%lo(sndseed)($9)
	move	$6,$2
	.def	done;	.val	$L5;	.scl	6;	.type	0x0;	.endef
$L5:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDrandom
