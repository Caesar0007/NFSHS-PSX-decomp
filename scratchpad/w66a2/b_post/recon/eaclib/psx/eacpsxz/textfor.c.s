	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\textfor.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	textbsearch
	.align	2
	.globl	getcharacter

	.text
	.def	textbsearch;	.val	textbsearch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	textbsearch
textbsearch:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	key;	.val	20;	.scl	17;	.type	0xe;	.endef
	.def	base;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	count;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	stride;	.val	19;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$19,28($sp)
	move	$19,$7
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L3
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	sra	$2,$17,1
$L9:
	mult	$2,$19
	li	$5,2			# 0x00000002
	mflo	$3
	#nop
	#nop
	addu	$16,$18,$3
	.set	noreorder
	.set	nomacro
	jal	geti
	move	$4,$16
	.set	macro
	.set	reorder

	subu	$2,$20,$2
	bne	$2,$0,$L5
	.set	noreorder
	.set	nomacro
	j	$L8
	move	$2,$16
	.set	macro
	.set	reorder

$L5:
	blez	$2,$L6
	addu	$18,$16,$19
	addu	$17,$17,-1
$L6:
	sra	$17,$17,1
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L9
	sra	$2,$17,1
	.set	macro
	.set	reorder

$L3:
	move	$2,$0
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
	.end	textbsearch
	.def	getcharacter;	.val	getcharacter;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	getcharacter
getcharacter:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	code;	.val	17;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	li	$5,2			# 0x00000002
	lui	$2,%hi(currentfont) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(currentfont) # low
	addu	$3,$17,-32
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$18,132($19)
	subu	$2,$2,$3
	addu	$16,$18,$2
	.set	noreorder
	.set	nomacro
	jal	geti
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$17,$L11
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$18
	lw	$6,116($19)
	.set	noreorder
	.set	nomacro
	jal	textbsearch
	li	$7,11			# 0x0000000b
	.set	macro
	.set	reorder

	j	$L12
$L11:
	move	$2,$16
$L12:
	lw	$31,32($sp)
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
LM2:
	.end	getcharacter
