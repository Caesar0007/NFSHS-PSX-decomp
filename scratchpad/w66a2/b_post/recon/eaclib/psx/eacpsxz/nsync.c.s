	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\nsync.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.def	LoadArgs;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	name;	.val	0;	.scl	8;	.type	0x12;	.endef
	.def	dest;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	memclass;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	abortval;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	LoadArgs;	.size	16;	.endef
	.def	LoadArgs;	.scl	13;	.tag	LoadArgs;	.size	16;	.type	0x8;	.endef
	.align	2
	.def	filesizeatomic;	.val	filesizeatomic;	.scl	2;	.type	0x24;	.endef
	.globl	filesizeatomic
	.text
	.ent	filesizeatomic
filesizeatomic:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	retry;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	a;	.val	5;	.scl	17;	.tag	LoadArgs;	.size	16;	.type	0x18;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,28($sp)
	lw	$4,0($5)
	li	$5,1			# 0x00000001
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L3
	move	$2,$0
	.set	macro
	.set	reorder

$L2:
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_sizesync
	move	$5,$16
	.set	macro
	.set	reorder

	move	$5,$16
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	move	$16,$2
	.set	macro
	.set	reorder

	move	$2,$16
$L3:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	filesizeatomic
	.align	2
	.def	filesize;	.val	filesize;	.scl	2;	.type	0x24;	.endef
	.globl	filesize
	.text
	.ent	filesize
filesize:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	lw	$2,abortflag
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(filesizeatomic) # high
	addiu	$4,$4,%lo(filesizeatomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	filesize
	.align	2
	.def	loadfileadratomic;	.val	loadfileadratomic;	.scl	2;	.type	0x61;	.endef
	.globl	loadfileadratomic
	.text
	.ent	loadfileadratomic
loadfileadratomic:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	retry;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	a;	.val	18;	.scl	17;	.tag	LoadArgs;	.size	16;	.type	0x18;	.endef
	subu	$sp,$sp,56
	sw	$16,32($sp)
	move	$16,$4
	sw	$18,40($sp)
	move	$18,$5
	li	$5,1			# 0x00000001
	move	$6,$16
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	lw	$4,0($18)
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	addu	$17,$16,-1
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_sizesync
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,0($18)
	lw	$6,8($18)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$5,$19
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L7
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$16
	lw	$4,24($sp)
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$2,loadfilecallback
	#nop
	beq	$2,$0,$L8
	lw	$5,0($18)
	lw	$6,8($18)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	bne	$17,$0,$L13
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

$L13:
	move	$16,$17
$L8:
	.set	noreorder
	.set	nomacro
	j	$L14
	move	$2,$16
	.set	macro
	.set	reorder

$L7:
	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	move	$5,$17
	.set	macro
	.set	reorder

$L6:
	move	$2,$0
$L14:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	loadfileadratomic
	.align	2
	.def	loadfileadrz;	.val	loadfileadrz;	.scl	2;	.type	0x24;	.endef
	.globl	loadfileadrz
	.text
	.ent	loadfileadrz
loadfileadrz:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	memclass;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	sw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(loadfileadratomic) # high
	addiu	$4,$4,%lo(loadfileadratomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	loadfileadrz
	.align	2
	.def	loadfileadr;	.val	loadfileadr;	.scl	2;	.type	0x24;	.endef
	.globl	loadfileadr
	.text
	.ent	loadfileadr
loadfileadr:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	memclass;	.val	5;	.scl	17;	.type	0x4;	.endef
	lw	$2,abortflag
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	sw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(loadfileadratomic) # high
	addiu	$4,$4,%lo(loadfileadratomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	loadfileadr
	.align	2
	.def	loadfileatadratomic;	.val	loadfileatadratomic;	.scl	2;	.type	0x24;	.endef
	.globl	loadfileatadratomic
	.text
	.ent	loadfileatadratomic
loadfileatadratomic:
	.frame	$sp,48,$31		# vars= 8, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	retry;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	a;	.val	2;	.scl	17;	.tag	LoadArgs;	.size	16;	.type	0x18;	.endef
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	move	$2,$5
	li	$5,1			# 0x00000001
	move	$6,$16
	addu	$7,$sp,24
	sw	$31,40($sp)
	sw	$17,36($sp)
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	move	$17,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L19
	move	$2,$0
	.set	macro
	.set	reorder

$L18:
	li	$7,2147418112			# 0x7fff0000
	lw	$4,24($sp)
	addu	$16,$16,-1
	sw	$16,16($sp)
	lw	$6,4($17)
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	ori	$7,$7,0xffff
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,4($17)
$L19:
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
LM6:
	.end	loadfileatadratomic
	.align	2
	.def	loadfileatadrz;	.val	loadfileatadrz;	.scl	2;	.type	0x24;	.endef
	.globl	loadfileatadrz
	.text
	.ent	loadfileatadrz
loadfileatadrz:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	sw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(loadfileatadratomic) # high
	addiu	$4,$4,%lo(loadfileatadratomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	loadfileatadrz
	.align	2
	.def	loadfileatadr;	.val	loadfileatadr;	.scl	2;	.type	0x24;	.endef
	.globl	loadfileatadr
	.text
	.ent	loadfileatadr
loadfileatadr:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	lw	$2,abortflag
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	sw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(loadfileatadratomic) # high
	addiu	$4,$4,%lo(loadfileatadratomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	loadfileatadr
	.align	2
	.def	loadbigfileheaderatomic;	.val	loadbigfileheaderatomic;	.scl	2;	.type	0x61;	.endef
	.globl	loadbigfileheaderatomic
	.text
	.ent	loadbigfileheaderatomic
loadbigfileheaderatomic:
	.frame	$sp,56,$31		# vars= 8, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	retry;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	a;	.val	16;	.scl	17;	.tag	LoadArgs;	.size	16;	.type	0x18;	.endef
	subu	$sp,$sp,56
	sw	$20,48($sp)
	move	$20,$4
	sw	$16,32($sp)
	move	$16,$5
	li	$5,1			# 0x00000001
	move	$6,$20
	sw	$31,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L30
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,0($16)
	lw	$6,8($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$5,2704			# 0x00000a90
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L25
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$17
	li	$7,2704			# 0x00000a90
	lw	$4,24($sp)
	addu	$19,$20,-1
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	sw	$19,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	typeofbigfile
	move	$4,$17
	.set	macro
	.set	reorder

	bne	$2,$0,$L26
	.def	purgefail;	.val	$L27;	.scl	6;	.type	0x0;	.endef
$L27:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L32
	move	$5,$19
	.set	macro
	.set	reorder

$L26:
	.set	noreorder
	.set	nomacro
	jal	sizeofbigfileheader
	move	$4,$17
	.set	macro
	.set	reorder

	move	$18,$2
	sltu	$2,$18,2705
	bne	$2,$0,$L28
	lw	$4,0($16)
	lw	$6,8($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$5,$18
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L27
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,2704			# 0x00000a90
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$17,$16
	li	$5,2704			# 0x00000a90
	addu	$6,$17,$5
	lw	$4,24($sp)
	addu	$7,$18,-2704
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	sw	$19,16($sp)
	.set	macro
	.set	reorder

$L28:
	lw	$4,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	addu	$5,$20,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L30
	move	$2,$17
	.set	macro
	.set	reorder

	.def	closefail;	.val	$L25;	.scl	6;	.type	0x0;	.endef
$L25:
	lw	$4,24($sp)
	addu	$5,$20,-1
$L32:
	jal	FILE_closesync
	move	$2,$0
$L30:
	lw	$31,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	loadbigfileheaderatomic
	.align	2
	.def	loadbigfileheader;	.val	loadbigfileheader;	.scl	2;	.type	0x24;	.endef
	.globl	loadbigfileheader
	.text
	.ent	loadbigfileheader
loadbigfileheader:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	memclass;	.val	5;	.scl	17;	.type	0x4;	.endef
	lw	$2,abortflag
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$4,16($sp)
	sw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(loadbigfileheaderatomic) # high
	addiu	$4,$4,%lo(loadbigfileheaderatomic) # low
	move	$5,$2
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_atomic
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM10:
	.end	loadbigfileheader

	.extern	loadfilecallback, 4
	.extern	abortflag, 4
