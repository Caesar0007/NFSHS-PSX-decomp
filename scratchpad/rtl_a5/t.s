	.file	1 "recon/eaclib/psx/eacpsxz/syncfile.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	synccallback
	.align	2
	.globl	syncblockio
	.align	2
	.globl	FILE_opensync
	.align	2
	.globl	FILE_readsync
	.align	2
	.globl	FILE_closesync
	.align	2
	.globl	FILE_sizesync
	.align	2
	.globl	FILE_addbigsync
	.align	2
	.globl	FILE_delbigsync

	.text
	.def	SyncIoFn;	.scl	13;	.type	0x94;	.endef
	.def	SyncCtrl;	.scl	10;	.type	0x8;	.size	36;	.endef
	.def	cbarg;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	fd;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	buf;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	remain;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	done;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	chunk;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	offset;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	iofn;	.val	28;	.scl	8;	.type	0x94;	.endef
	.def	op;	.val	32;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	36;	.scl	102;	.tag	SyncCtrl;	.size	36;	.endef
	.def	SyncCtrl;	.scl	13;	.tag	SyncCtrl;	.size	36;	.type	0x8;	.endef
	.def	synccallback;	.val	synccallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	synccallback
synccallback:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	op;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	type;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	c;	.val	18;	.scl	17;	.tag	SyncCtrl;	.size	36;	.type	0x18;	.endef
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$17,$18
	move	$4,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L2
	sw	$0,32($17)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,8($17)
	#.set	novolatile
	#nop
	addu	$2,$2,$4
	#.set	volatile
	sw	$2,8($17)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($17)
	#.set	novolatile
	lw	$3,20($17)
	addu	$2,$2,$4
	#.set	volatile
	sw	$2,16($17)
	#.set	novolatile
	#.set	volatile
	lw	$2,24($17)
	#.set	novolatile
	slt	$3,$4,$3
	addu	$2,$2,$4
	#.set	volatile
	sw	$2,24($17)
	#.set	novolatile
	beq	$3,$0,$L3
	#.set	volatile
	sw	$0,12($17)
	#.set	novolatile
	j	$L4
$L3:
	lw	$2,12($17)
	#nop
	subu	$2,$2,$4
	sw	$2,12($17)
$L4:
	#.set	volatile
	lw	$2,12($18)
	#.set	novolatile
	#nop
	blez	$2,$L1
	#.set	volatile
	lw	$2,12($18)
	#.set	novolatile
	#nop
	slt	$2,$2,8193
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,12($18)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,20($18)
	.set	macro
	.set	reorder

$L6:
	sw	$2,20($18)
$L11:
	lw	$2,0($18)
	sw	$18,20($sp)
	sw	$2,16($sp)
	lw	$4,4($18)
	lw	$5,8($18)
	lw	$2,28($18)
	lw	$6,24($18)
	lw	$7,20($18)
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sw	$2,32($18)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(synccallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(synccallback) # low
	.set	macro
	.set	reorder

	j	$L1
$L2:
	sw	$0,12($17)
$L1:
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
	.end	synccallback
	.def	syncblockio;	.val	syncblockio;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	syncblockio
syncblockio:
	.frame	$sp,72,$31		# vars= 40, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	fd;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	buf;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	cbarg;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	iofn;	.val	20;	.scl	9;	.type	0x94;	.endef
	.def	cbarg;	.val	3;	.scl	4;	.type	0x4;	.endef
	.def	iofn;	.val	8;	.scl	4;	.type	0x94;	.endef
	subu	$sp,$sp,72
	lw	$3,88($sp)
	lw	$8,92($sp)
	#.set	volatile
	sw	$3,24($sp)
	#.set	novolatile
	#.set	volatile
	sw	$4,28($sp)
	#.set	novolatile
	#.set	volatile
	sw	$5,32($sp)
	#.set	novolatile
	#.set	volatile
	sw	$7,36($sp)
	#.set	novolatile
	#.set	volatile
	sw	$0,40($sp)
	#.set	novolatile
	#.set	volatile
	sw	$7,44($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,44($sp)
	#.set	novolatile
	sw	$31,64($sp)
	#.set	volatile
	sw	$6,48($sp)
	#.set	novolatile
	slt	$2,$2,8193
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	sw	$8,52($sp)
	.set	macro
	.set	reorder

	li	$2,8192			# 0x00002000
	sw	$2,44($sp)
$L13:
	addu	$2,$sp,24
	sw	$3,16($sp)
	sw	$2,20($sp)
	lw	$6,48($sp)
	lw	$7,44($sp)
	jal	$31,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(synccallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(synccallback) # low
	.set	macro
	.set	reorder

	j	$L19
$L17:
	lw	$4,56($sp)
	jal	FILE_waitop
$L19:
	lw	$2,36($sp)
	#nop
	bne	$2,$0,$L17
	lw	$2,56($sp)
	#nop
	bne	$2,$0,$L17
$L14:
	lw	$2,40($sp)
	lw	$31,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	syncblockio
	.def	FILE_opensync;	.val	FILE_opensync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_opensync
FILE_opensync:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	a2;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	a3;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	out;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$7
	sw	$17,20($sp)
	move	$17,$0
	move	$7,$17
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L21
	.set	noreorder
	.set	nomacro
	jal	FILE_waitop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_opstatus
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	sltu	$17,$2,1
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L22
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L21:
	sw	$0,0($18)
$L22:
	move	$2,$17
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	FILE_opensync
	.def	FILE_readsync;	.val	FILE_readsync;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FILE_readsync
FILE_readsync:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	fd;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	buf;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	cbarg;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	cbarg;	.val	3;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,32
	lui	$2,%hi(FILE_read) # high
	lw	$3,48($sp)
	addiu	$2,$2,%lo(FILE_read) # low
	sw	$31,24($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	syncblockio
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	FILE_readsync
	.def	FILE_closesync;	.val	FILE_closesync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_closesync
FILE_closesync:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	fd;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a2;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	move	$6,$17
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_close
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L26
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_waitop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	move	$2,$17
$L26:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	FILE_closesync
	.def	FILE_sizesync;	.val	FILE_sizesync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_sizesync
FILE_sizesync:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	fd;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a2;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	move	$6,$17
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_size
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L29
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_waitop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	move	$2,$17
$L29:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	FILE_sizesync
	.def	FILE_addbigsync;	.val	FILE_addbigsync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_addbigsync
FILE_addbigsync:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	a2;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	a3;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	out;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$7
	sw	$17,20($sp)
	move	$17,$0
	move	$7,$17
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_addbig
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L31
	.set	noreorder
	.set	nomacro
	jal	FILE_waitop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_opstatus
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	sltu	$17,$2,1
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L32
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L31:
	sw	$0,0($18)
$L32:
	move	$2,$17
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	FILE_addbigsync
	.def	FILE_delbigsync;	.val	FILE_delbigsync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_delbigsync
FILE_delbigsync:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	a0;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a1;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	move	$6,$17
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_delbig
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L35
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_waitop
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	move	$2,$17
$L35:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	FILE_delbigsync
