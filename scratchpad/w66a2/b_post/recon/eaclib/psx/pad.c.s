	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\pad.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	padinit
	.align	2
	.globl	PAD_restore
	.align	2
	.globl	PAD_state
	.align	2
	.align	2
	.globl	PAD_update

	.comm	gPadinfo,84

	.comm	Padglobal,16

	.text
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	byte;	.scl	13;	.type	0xc;	.endef
	.def	u_short;	.scl	13;	.type	0xd;	.endef
	.def	uint;	.scl	13;	.type	0xe;	.endef
	.def	PAD_PSX;	.scl	10;	.type	0x8;	.size	6;	.endef
	.def	state;	.val	0;	.scl	8;	.type	0xd;	.endef
	.def	unused;	.val	2;	.scl	8;	.dim	2;	.size	4;	.type	0x3d;	.endef
	.def	.eos;	.val	6;	.scl	102;	.tag	PAD_PSX;	.size	6;	.endef
	.def	PAD_PSX;	.scl	13;	.tag	PAD_PSX;	.size	6;	.type	0x8;	.endef
	.def	tPadVariantData;	.scl	12;	.type	0x9;	.size	6;	.endef
	.def	standard;	.val	0;	.scl	11;	.tag	PAD_PSX;	.size	6;	.type	0x8;	.endef
	.def	.eos;	.val	6;	.scl	102;	.tag	tPadVariantData;	.size	6;	.endef
	.def	tPadVariantData;	.scl	13;	.tag	tPadVariantData;	.size	6;	.type	0x9;	.endef
	.def	PAD_COMMON;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	nopad;	.val	0;	.scl	8;	.type	0xc;	.endef
	.def	ID;	.val	1;	.scl	8;	.type	0xc;	.endef
	.def	data;	.val	2;	.scl	8;	.tag	tPadVariantData;	.size	6;	.type	0x9;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	PAD_COMMON;	.size	8;	.endef
	.def	PAD_COMMON;	.scl	13;	.tag	PAD_COMMON;	.size	8;	.type	0x8;	.endef
	.def	tActiveTime;	.scl	10;	.type	0x8;	.size	2;	.endef
	.def	bActive;	.val	0;	.scl	8;	.type	0xc;	.endef
	.def	time;	.val	1;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	2;	.scl	102;	.tag	tActiveTime;	.size	2;	.endef
	.def	tActiveTime;	.scl	13;	.tag	tActiveTime;	.size	2;	.type	0x8;	.endef
	.def	tPadModuleState;	.scl	10;	.type	0x8;	.size	84;	.endef
	.def	initialized;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	buf;	.val	4;	.scl	8;	.tag	PAD_COMMON;	.dim	8;	.size	64;	.type	0x38;	.endef
	.def	state;	.val	68;	.scl	8;	.tag	tActiveTime;	.dim	8;	.size	16;	.type	0x38;	.endef
	.def	.eos;	.val	84;	.scl	102;	.tag	tPadModuleState;	.size	84;	.endef
	.def	tPadModuleState;	.scl	13;	.tag	tPadModuleState;	.size	84;	.type	0x8;	.endef
	.def	padinit;	.val	padinit;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	padinit
padinit:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	la	$16,gPadinfo
	sw	$31,20($sp)
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L2
	la	$4,Padglobal
	.set	noreorder
	.set	nomacro
	jal	PadInitDirect
	addu	$5,$4,8
	.set	macro
	.set	reorder

	jal	PadStartCom
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,84			# 0x00000054
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	la	$4,PAD_update
	.set	noreorder
	.set	nomacro
	jal	addtimer
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L2:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31


	.loc	1 0
LM1:
	.end	padinit
	.def	PAD_restore;	.val	PAD_restore;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	PAD_restore
PAD_restore:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	la	$16,gPadinfo
	sw	$31,20($sp)
	lw	$2,0($16)
	#nop
	beq	$2,$0,$Lnodb4_4
	la	$4,PAD_update
	jal	deltimer
	jal	PadStopCom
	sw	$0,0($16)
$Lnodb4_4:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM2:
	.end	PAD_restore
	.def	PAD_state;	.val	PAD_state;	.scl	2;	.type	0x2d;	.endef
	.text
	.ent	PAD_state
PAD_state:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	padID;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	la	$3,gPadinfo
	sw	$31,16($sp)
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	sltu	$2,$4,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	sll	$2,$4,3
	.set	macro
	.set	reorder

	addu	$4,$3,4
	.set	noreorder
	.set	nomacro
	jal	PAD_convert
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	andi	$2,$2,0xffff
	.set	macro
	.set	reorder

$L6:
	move	$2,$0
$L7:
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31


	.loc	1 0
LM3:
	.end	PAD_state
	.def	PAD_convert;	.val	PAD_convert;	.scl	3;	.type	0x2d;	.endef
	.text
	.ent	PAD_convert
PAD_convert:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	pad;	.val	4;	.scl	17;	.tag	PAD_COMMON;	.size	8;	.type	0x18;	.endef
	lhu	$2,2($4)
	#nop
	nor	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0xffff
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	PAD_convert
	.def	PAD_update;	.val	PAD_update;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	PAD_update
PAD_update:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	la	$2,gPadinfo+4
	sw	$18,24($sp)
	addu	$18,$2,8
	sw	$17,20($sp)
	move	$17,$2
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,28($sp)
$L13:
	lbu	$2,Padglobal($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L24
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

$L14:
	la	$4,Padglobal
	addu	$4,$16,$4
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	move	$4,$18
	li	$5,24			# 0x00000018
$L24:
	.set	noreorder
	.set	nomacro
	jal	blockfill
	li	$6,255			# 0x000000ff
	.set	macro
	.set	reorder

	addu	$18,$18,32
	addu	$16,$16,8
	slt	$2,$16,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	addu	$17,$17,32
	.set	macro
	.set	reorder

	move	$8,$0
	move	$7,$8
	la	$4,gPadinfo+69
	addu	$6,$4,-1
$L20:
	lbu	$2,gPadinfo+4($7)
	lbu	$3,0($6)
	sltu	$5,$2,1
	beq	$5,$3,$L19
	lbu	$3,0($4)
	#nop
	addu	$2,$3,1
	sltu	$3,$3,6
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L19
	sb	$2,0($4)
	.set	macro
	.set	reorder

	sb	$5,0($6)
	sb	$0,0($4)
$L19:
	addu	$4,$4,2
	addu	$6,$6,2
	addu	$8,$8,1
	slt	$2,$8,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	addu	$7,$7,8
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,32
	j	$31


	.loc	1 0
LM5:
	.end	PAD_update
	.def	gPadinfo;	.val	gPadinfo;	.scl	2;	.tag	tPadModuleState;	.size	84;	.type	0x8;	.endef
	.def	Padglobal;	.val	Padglobal;	.scl	2;	.tag	PAD_COMMON;	.dim	2;	.size	16;	.type	0x38;	.endef
