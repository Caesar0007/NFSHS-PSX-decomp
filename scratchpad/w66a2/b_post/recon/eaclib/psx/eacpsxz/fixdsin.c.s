	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdsin.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	fixedsin
	.align	2
	.globl	fixedcos

	.text
	.def	fixedsin;	.val	fixedsin;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	fixedsin
fixedsin:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	x;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sra	$17,$16,6
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	move	$17,$2
	.set	macro
	.set	reorder

	andi	$16,$16,0x003f
	sll	$3,$16,1
	addu	$3,$3,$16
	sll	$4,$3,6
	addu	$3,$3,$4
	sll	$3,$3,5
	subu	$3,$3,$16
	sll	$4,$3,5
	addu	$3,$3,$4
	sll	$3,$3,1
	sra	$3,$3,9
	sra	$2,$2,2
	mult	$2,$3
	lw	$31,24($sp)
	lw	$16,16($sp)
	mflo	$5
	#nop
	#nop
	sra	$2,$5,21
	addu	$2,$17,$2
	lw	$17,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	fixedsin
	.def	fixedcos;	.val	fixedcos;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	fixedcos
fixedcos:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	x;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sra	$17,$16,6
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	subu	$2,$0,$2
	andi	$16,$16,0x003f
	sll	$3,$16,1
	addu	$3,$3,$16
	sll	$4,$3,6
	addu	$3,$3,$4
	sll	$3,$3,5
	subu	$3,$3,$16
	sll	$4,$3,5
	addu	$3,$3,$4
	sll	$3,$3,1
	sra	$3,$3,9
	sra	$2,$2,2
	mult	$2,$3
	lw	$31,24($sp)
	lw	$16,16($sp)
	mflo	$5
	#nop
	#nop
	sra	$2,$5,21
	addu	$2,$17,$2
	lw	$17,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	fixedcos
