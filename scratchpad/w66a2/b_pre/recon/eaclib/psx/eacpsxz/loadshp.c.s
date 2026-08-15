	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\loadshp.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	loadshapeadr

	.comm	shapeext,4

	.text
	.def	loadshapeadr;	.val	loadshapeadr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	loadshapeadr
loadshapeadr:
	.frame	$sp,152,$31		# vars= 128, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	filename;	.val	2;	.scl	17;	.type	0x12;	.endef
	.def	arg2;	.val	16;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,152
	move	$2,$4
	sw	$16,144($sp)
	move	$16,$5
	addu	$4,$sp,16
	sw	$31,148($sp)
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addu	$2,$4,$2
	addu	$3,$2,-1
	sltu	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$8,46			# 0x0000002e
	.set	macro
	.set	reorder

	li	$7,58			# 0x0000003a
	li	$6,47			# 0x0000002f
	li	$5,92			# 0x0000005c
$L5:
	lbu	$2,0($3)
	#nop
	beq	$2,$8,$L7
	beq	$2,$7,$L3
	beq	$2,$6,$L3
	beq	$2,$5,$L3
	addu	$3,$3,-1
	sltu	$2,$4,$3
	bne	$2,$0,$L5
$L3:
	lbu	$3,0($3)
	li	$2,46			# 0x0000002e
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L12
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$5,shapeext
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.def	done;	.val	$L7;	.scl	6;	.type	0x0;	.endef
$L7:
	addu	$4,$sp,16
$L12:
	.set	noreorder
	.set	nomacro
	jal	loadpackadr
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$31,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	loadshapeadr
	.def	shapeext;	.val	shapeext;	.scl	2;	.type	0x12;	.endef
