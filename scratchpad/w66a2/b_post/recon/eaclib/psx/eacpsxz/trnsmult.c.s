	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\trnsmult.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	transmult

	.text
	.def	transmult_pointer_arg;	.scl	12;	.type	0x9;	.size	4;	.endef
	.def	pointer;	.val	0;	.scl	11;	.type	0x14;	.endef
	.def	memory;	.val	0;	.scl	11;	.type	0x14;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	transmult_pointer_arg;	.size	4;	.endef
	.def	transmult_pointer_arg;	.scl	13;	.tag	transmult_pointer_arg;	.size	4;	.type	0x9;	.endef
	.def	transmult;	.val	transmult;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	transmult
transmult:
	.frame	$sp,104,$31		# vars= 48, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	a;	.val	0;	.scl	9;	.tag	transmult_pointer_arg;	.size	4;	.type	0x9;	.endef
	.def	b;	.val	4;	.scl	9;	.tag	transmult_pointer_arg;	.size	4;	.type	0x9;	.endef
	.def	out;	.val	8;	.scl	9;	.type	0x14;	.endef
	subu	$sp,$sp,104
	sw	$21,84($sp)
	move	$21,$0
	sw	$fp,96($sp)
	li	$fp,8			# 0x00000008
	sw	$23,92($sp)
	li	$23,4			# 0x00000004
	sw	$22,88($sp)
	sw	$4,104($sp)
	move	$22,$4
	sw	$31,100($sp)
	sw	$20,80($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	sw	$5,108($sp)
	sw	$6,112($sp)
$L5:
	move	$17,$0
	li	$20,24			# 0x00000018
	#.set	volatile
	lw	$3,104($sp)
	#.set	novolatile
	li	$19,12			# 0x0000000c
	addu	$3,$3,$23
	sw	$3,56($sp)
	#.set	volatile
	lw	$3,104($sp)
	#.set	novolatile
	lw	$18,108($sp)
	addu	$3,$3,$fp
	sw	$3,60($sp)
$L9:
	lw	$4,0($22)
	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$18,$18,4
	.set	macro
	.set	reorder

	lw	$3,56($sp)
	#nop
	#.set	volatile
	lw	$4,0($3)
	#.set	novolatile
	#.set	volatile
	lw	$3,108($sp)
	#.set	novolatile
	move	$16,$2
	addu	$2,$3,$19
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$19,$19,4
	.set	macro
	.set	reorder

	lw	$3,60($sp)
	#nop
	#.set	volatile
	lw	$4,0($3)
	#.set	novolatile
	#.set	volatile
	lw	$3,108($sp)
	#.set	novolatile
	addu	$16,$16,$2
	addu	$2,$3,$20
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$20,$20,4
	.set	macro
	.set	reorder

	addu	$16,$16,$2
	addu	$2,$21,$17
	addu	$17,$17,1
	sll	$2,$2,2
	addu	$4,$sp,16
	addu	$2,$4,$2
	sw	$16,0($2)
	slt	$2,$17,3
	bne	$2,$0,$L9
	addu	$fp,$fp,12
	addu	$23,$23,12
	addu	$21,$21,3
	slt	$2,$21,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$22,$22,12
	.set	macro
	.set	reorder

	lw	$5,112($sp)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,36			# 0x00000024
	.set	macro
	.set	reorder

	lw	$31,100($sp)
	lw	$fp,96($sp)
	lw	$23,92($sp)
	lw	$22,88($sp)
	lw	$21,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	transmult
