	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\game\\psx\\textpix.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	textnpixels
	.align	2
	.globl	textpixels

	.text
	.def	charactertbl;	.scl	10;	.type	0x8;	.size	11;	.endef
	.def	index;	.val	0;	.scl	8;	.dim	2;	.size	2;	.type	0x3c;	.endef
	.def	width;	.val	2;	.scl	8;	.type	0xc;	.endef
	.def	height;	.val	3;	.scl	8;	.type	0xc;	.endef
	.def	u;	.val	4;	.scl	8;	.dim	2;	.size	2;	.type	0x3c;	.endef
	.def	v;	.val	6;	.scl	8;	.dim	2;	.size	2;	.type	0x3c;	.endef
	.def	advance;	.val	8;	.scl	8;	.type	0x2;	.endef
	.def	xoffset;	.val	9;	.scl	8;	.type	0x2;	.endef
	.def	yoffset;	.val	10;	.scl	8;	.type	0x2;	.endef
	.def	.eos;	.val	11;	.scl	102;	.tag	charactertbl;	.size	11;	.endef
	.def	charactertbl;	.scl	13;	.tag	charactertbl;	.size	11;	.type	0x8;	.endef
	.def	FontDecoder;	.scl	13;	.type	0x94;	.endef
	.def	textnpixels;	.val	textnpixels;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	textnpixels
textnpixels:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	str;	.val	0;	.scl	9;	.type	0x12;	.endef
	.def	n;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$0
	sw	$16,16($sp)
	move	$16,$17
	sw	$31,32($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	blez	$18,$L2
	sw	$4,40($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(currentfont) # high
	addiu	$19,$2,%lo(currentfont) # low
$L3:
	lw	$2,160($19)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	addu	$17,$17,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getcharacter
	move	$4,$2
	.set	macro
	.set	reorder

	beq	$2,$0,$L5
	lb	$2,8($2)
	#nop
	addu	$16,$16,$2
$L5:
	slt	$2,$17,$18
	bne	$2,$0,$L3
$L2:
	move	$2,$16
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
LM1:
	.end	textnpixels
	.def	textpixels;	.val	textpixels;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	textpixels
textpixels:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	string;	.val	4;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	textnpixels
	li	$5,256			# 0x00000100
	.set	macro
	.set	reorder

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
	.end	textpixels
