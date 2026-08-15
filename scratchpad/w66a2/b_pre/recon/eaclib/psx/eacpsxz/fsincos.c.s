	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fsincos.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	fixedsincos

	.text
	.def	fixedsincos;	.val	fixedsincos;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	fixedsincos
fixedsincos:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	angle;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	psin;	.val	17;	.scl	17;	.type	0x14;	.endef
	.def	pcos;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$18,32($sp)
	move	$18,$6
	sra	$4,$16,6
	addu	$5,$sp,16
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	intsincos
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	andi	$16,$16,0x003f
	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$3,$2,6
	addu	$2,$2,$3
	sll	$2,$2,5
	subu	$2,$2,$16
	sll	$3,$2,5
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,20($sp)
	sra	$2,$2,9
	sra	$3,$3,2
	mult	$3,$2
	lw	$3,16($sp)
	mflo	$7
	#nop
	#nop
	sra	$4,$7,21
	addu	$3,$3,$4
	sw	$3,0($17)
	lw	$3,16($sp)
	#nop
	sra	$3,$3,2
	mult	$3,$2
	lw	$2,20($sp)
	mflo	$7
	#nop
	#nop
	sra	$4,$7,21
	subu	$2,$2,$4
	sw	$2,0($18)
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	fixedsincos
