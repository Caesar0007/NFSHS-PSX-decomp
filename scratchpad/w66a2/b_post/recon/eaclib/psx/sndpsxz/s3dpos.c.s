	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\s3dpos.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDplatform3dpos

	.text
	.def	iSNDplatform3dpos;	.val	iSNDplatform3dpos;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatform3dpos
iSNDplatform3dpos:
	.frame	$sp,48,$31		# vars= 8, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	chan;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	x;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	move	$4,$5
	sll	$2,$17,1
	addu	$8,$2,$17
	sll	$3,$8,2
	subu	$3,$3,$17
	sll	$3,$3,2
	lui	$2,%hi(sndpd+216) # high
	addiu	$2,$2,%lo(sndpd+216) # low
	sw	$16,32($sp)
	addu	$16,$3,$2
	sw	$31,40($sp)
	#.set	volatile
	sh	$4,24($16)
	#.set	novolatile
	#.set	volatile
	lbu	$3,28($16)
	#.set	novolatile
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$3,30($16)
	#.set	novolatile
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L3
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	lui	$3,%hi(sndgs+148) # high
	sll	$2,$8,3
	addu	$2,$2,$17
	sll	$2,$2,2
	lw	$5,%lo(sndgs+148)($3)
	#.set	volatile
	lbu	$3,36($16)
	#.set	novolatile
	addu	$2,$2,$5
	sll	$3,$3,24
	lb	$5,45($2)
	sra	$3,$3,24
	sw	$3,16($sp)
	#.set	volatile
	lbu	$2,37($16)
	#.set	novolatile
	addu	$7,$sp,28
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	jal	iSNDatodlrv
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L4
$L3:
	#.set	volatile
	lbu	$2,30($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs+148) # high
	sll	$3,$8,3
	addu	$3,$3,$17
	lw	$2,%lo(sndgs+148)($2)
	sll	$3,$3,2
	addu	$3,$3,$2
	lb	$5,45($3)
	.set	noreorder
	.set	nomacro
	jal	iSNDatolrv
	addu	$7,$sp,28
	.set	macro
	.set	reorder

$L4:
	lbu	$2,24($sp)
	#nop
	#.set	volatile
	sb	$2,36($16)
	#.set	novolatile
	lbu	$2,28($sp)
	#nop
	#.set	volatile
	sb	$2,37($16)
	#.set	novolatile
	lw	$5,24($sp)
	lw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDsetvol
	move	$4,$17
	.set	macro
	.set	reorder

	move	$2,$0
$L8:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatform3dpos
