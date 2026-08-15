	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\nloadpk.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	loadpackadrz
	.align	2
	.globl	loadpackadr

	.text
	.def	loadpackadrz;	.val	loadpackadrz;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	loadpackadrz
loadpackadrz:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	name;	.val	19;	.scl	17;	.type	0x12;	.endef
	.def	memclass;	.val	20;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,36($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L8
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	unpacksize
	move	$4,$17
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L4
	move	$16,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getblocksize
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	xori	$6,$20,0x0010
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	getblocksize
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$17,$16
	move	$4,$19
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$20
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L5
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	unpackz
	move	$5,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L5
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$0
$L5:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	move	$2,$16
	.set	macro
	.set	reorder

$L4:
	move	$2,$16
$L8:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	loadpackadrz
	.def	loadpackadr;	.val	loadpackadr;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	loadpackadr
loadpackadr:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	memclass;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	loadpackadrz
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
	.end	loadpackadr
