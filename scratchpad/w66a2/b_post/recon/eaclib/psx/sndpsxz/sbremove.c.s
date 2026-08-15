	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbremove.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDremovepatches
	.align	2
	.globl	SNDbankremove
	.align	2
	.globl	cSNDbankremove

	.extern	sndgs, 156

	.text
	.def	SNDGlobals;	.scl	10;	.type	0x8;	.size	156;	.endef
	.def	pad0;	.val	0;	.scl	8;	.dim	12;	.size	12;	.type	0x32;	.endef
	.def	bank_count;	.val	12;	.scl	8;	.type	0xd;	.endef
	.def	pad0e;	.val	14;	.scl	8;	.dim	3;	.size	3;	.type	0x32;	.endef
	.def	channel_count;	.val	17;	.scl	8;	.type	0xc;	.endef
	.def	pad12;	.val	18;	.scl	8;	.dim	42;	.size	42;	.type	0x32;	.endef
	.def	initialized;	.val	60;	.scl	8;	.type	0x2;	.endef
	.def	pad3d;	.val	61;	.scl	8;	.dim	87;	.size	87;	.type	0x32;	.endef
	.def	play_records;	.val	148;	.scl	8;	.type	0x4;	.endef
	.def	bank_table;	.val	152;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	156;	.scl	102;	.tag	SNDGlobals;	.size	156;	.endef
	.def	SNDBankEntry;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	data;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	platform_data;	.val	4;	.scl	8;	.type	0x11;	.endef
	.def	loaded;	.val	8;	.scl	8;	.type	0xc;	.endef
	.def	platform_allocated;	.val	9;	.scl	8;	.type	0x2;	.endef
	.def	pad;	.val	10;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	SNDBankEntry;	.size	12;	.endef
	.def	iSNDremovepatches;	.val	iSNDremovepatches;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDremovepatches
iSNDremovepatches:
	.frame	$sp,2080,$31		# vars= 2048, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	bank;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	count;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,2080
	sw	$18,2072($sp)
	move	$18,$4
	sw	$17,2068($sp)
	move	$17,$5
	li	$3,-1			# 0xffffffff
	sw	$16,2064($sp)
	li	$16,255			# 0x000000ff
	addu	$2,$sp,2056
	sw	$31,2076($sp)
$L2:
	sw	$3,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L2
	addu	$2,$2,-8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$17,$L7
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L11:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDbankremovepat
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	move	$4,$18
	.set	macro
	.set	reorder

$L7:
	lw	$31,2076($sp)
	lw	$18,2072($sp)
	lw	$17,2068($sp)
	lw	$16,2064($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,2080
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDremovepatches
	.def	SNDbankremove;	.val	SNDbankremove;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SNDbankremove
SNDbankremove:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	bankId;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	cSNDbankremove
	move	$5,$0
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
	.end	SNDbankremove
	.def	cSNDbankremove;	.val	cSNDbankremove;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	cSNDbankremove
cSNDbankremove:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	bankId;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	recurse;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	lui	$2,%hi(sndgs) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(sndgs) # low
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lb	$2,60($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	move	$19,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L30
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L14:
	li	$2,-1			# 0xffffffff
	bne	$19,$2,$L15
	lhu	$2,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$16
$L31:
	.set	noreorder
	.set	nomacro
	jal	cSNDbankremove
	move	$5,$0
	.set	macro
	.set	reorder

	lhu	$2,12($17)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	move	$4,$16
	.set	macro
	.set	reorder

$L17:
	.set	noreorder
	.set	nomacro
	j	$L30
	move	$2,$0
	.set	macro
	.set	reorder

$L15:
	.set	noreorder
	.set	nomacro
	jal	iSNDvalidbank
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	sll	$2,$19,1
	addu	$2,$2,$19
	lw	$3,152($17)
	sll	$2,$2,2
	addu	$2,$2,$3
	lbu	$3,17($17)
	lw	$20,0($2)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L22
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$17
	move	$17,$16
$L23:
	lw	$2,148($18)
	#nop
	addu	$4,$2,$17
	lb	$2,10($4)
	#nop
	bne	$2,$19,$L26
	lw	$4,0($4)
	jal	SNDstop
$L26:
	lbu	$2,17($18)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$17,$17,100
	.set	macro
	.set	reorder

$L22:
	lui	$2,%hi(sndgs) # high
	addiu	$17,$2,%lo(sndgs) # low
	sll	$2,$19,1
	addu	$2,$2,$19
	#.set	volatile
	lw	$3,152($17)
	#.set	novolatile
	sll	$16,$2,2
	addu	$3,$16,$3
	lb	$2,9($3)
	#nop
	beq	$2,$0,$L28
	lw	$4,4($3)
	jal	iSNDplatformfree
	lw	$2,152($17)
	#nop
	addu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L29
	sb	$0,9($2)
	.set	macro
	.set	reorder

$L28:
	lhu	$5,6($20)
	.set	noreorder
	.set	nomacro
	jal	iSNDremovepatches
	move	$4,$19
	.set	macro
	.set	reorder

$L29:
	lui	$4,%hi(sndgs) # high
	addiu	$4,$4,%lo(sndgs) # low
	sll	$3,$19,1
	addu	$3,$3,$19
	lw	$2,152($4)
	sll	$3,$3,2
	addu	$2,$3,$2
	sw	$0,0($2)
	lw	$4,152($4)
	move	$2,$0
	addu	$3,$3,$4
	sb	$0,8($3)
$L30:
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
LM3:
	.end	cSNDbankremove
