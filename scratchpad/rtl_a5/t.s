	.file	1 "recon/eaclib/psx/eacpsxz/nfile.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	freeop
	.align	2
	.globl	freehandle
	.align	2
	.globl	reservehandle
	.align	2
	.globl	reserveop
	.align	2
	.globl	FILE_overhead
	.align	2
	.globl	FILE_opstatus
	.align	2
	.globl	FILE_operror
	.rdata
	.align	2
$LC0:
	.ascii	"File Sys\000"
	.text
	.align	2
	.globl	FILE_init
	.align	2
	.globl	FILE_completeop
	.align	2
	.globl	FILE_callbackop
	.align	2
	.globl	FILE_open
	.align	2
	.globl	FILE_close
	.align	2
	.globl	FILE_read
	.align	2
	.globl	FILE_size
	.align	2
	.globl	iFILE_perror
	.align	2
	.globl	FILE_waitop
	.align	2
	.globl	FILE_atomic
	.align	2
	.globl	FILE_priorityop
	.align	2
	.globl	FILE_initwithmem
	.align	2
	.globl	FILE_cancelop
	.align	2
	.globl	iFILE_delbigclosecallback
	.align	2
	.globl	iFILE_CommandCompleteCallback
	.rdata
	.align	2
$LC1:
	.ascii	"bigfile buf\000"
	.text
	.align	2
	.globl	iFILE_addbigreadcallback
	.align	2
	.globl	iFILE_addbigopencallback
	.rdata
	.align	2
$LC2:
	.ascii	"bigfile header\000"
	.text
	.align	2
	.globl	FILE_addbig
	.align	2
	.globl	FILE_delbig
	.align	2
	.globl	iFILE_ExecCommand

	.comm	gFileMgr,48

	.comm	gFileOpSeq,4

	.extern	disablecd, 4

	.text
	.file	1 "C:/Temp/nfs4-wt35-a5/recon/lib/nfile.h"
	.def	FileOp;	.scl	10;	.type	0x8;	.size	48;	.endef
	.def	id;	.val	0;	.scl	8;	.type	0xe;	.endef
	.def	cancelreq;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	status;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	error;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	prio;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	param;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	result18;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	result1C;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	_g20;	.val	32;	.scl	8;	.dim	4;	.size	4;	.type	0x3c;	.endef
	.def	result24;	.val	36;	.scl	8;	.type	0x4;	.endef
	.def	callback;	.val	40;	.scl	8;	.type	0x91;	.endef
	.def	qnext;	.val	44;	.scl	8;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	.def	.eos;	.val	48;	.scl	102;	.tag	FileOp;	.size	48;	.endef
	.def	FileOp;	.scl	13;	.tag	FileOp;	.size	48;	.type	0x8;	.endef
	.def	FileHandle;	.scl	10;	.type	0x8;	.size	76;	.endef
	.def	inuse;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	size;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	flags;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	name;	.val	12;	.scl	8;	.dim	64;	.size	64;	.type	0x32;	.endef
	.def	.eos;	.val	76;	.scl	102;	.tag	FileHandle;	.size	76;	.endef
	.def	FileHandle;	.scl	13;	.tag	FileHandle;	.size	76;	.type	0x8;	.endef
	.def	FileMgr;	.scl	10;	.type	0x8;	.size	48;	.endef
	.def	opcount;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	handlecount;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	idmask;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	state;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	cbpending;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	curop;	.val	20;	.scl	8;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	.def	oparray;	.val	24;	.scl	8;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	.def	handlearray;	.val	28;	.scl	8;	.tag	FileHandle;	.size	76;	.type	0x18;	.endef
	.def	queuehead;	.val	32;	.scl	8;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	.def	devicelist;	.val	36;	.scl	8;	.type	0x11;	.endef
	.def	_g28;	.val	40;	.scl	8;	.dim	8;	.size	8;	.type	0x3c;	.endef
	.def	.eos;	.val	48;	.scl	102;	.tag	FileMgr;	.size	48;	.endef
	.def	FileMgr;	.scl	13;	.tag	FileMgr;	.size	48;	.type	0x8;	.endef
	.file	1 "recon/eaclib/psx/eacpsxz/nfile.c"
	.def	freeop;	.val	freeop;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	freeop
freeop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	op;	.val	4;	.scl	17;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
 #APP
	mfc0 $16,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$16,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,48			# 0x00000030
	.set	macro
	.set	reorder

 #APP
	mtc0 $16,$12
 #NO_APP
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	freeop
	.def	freehandle;	.val	freehandle;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	freehandle
freehandle:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	h;	.val	4;	.scl	17;	.tag	FileHandle;	.size	76;	.type	0x18;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
 #APP
	mfc0 $16,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$16,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,76			# 0x0000004c
	.set	macro
	.set	reorder

 #APP
	mtc0 $16,$12
 #NO_APP
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	freehandle
	.def	reservehandle;	.val	reservehandle;	.scl	2;	.tag	FileHandle;	.size	76;	.type	0x68;	.endef
	.text
	.ent	reservehandle
reservehandle:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
 #APP
	mfc0 $6,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$6,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lui	$2,%hi(gFileMgr) # high
	addiu	$2,$2,%lo(gFileMgr) # low
	lw	$3,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L4
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$3
	lw	$3,28($2)
$L5:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$4,$4,1
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$3,$3,76
	.set	macro
	.set	reorder

$L4:
 #APP
	mtc0 $6,$12
 #NO_APP
	lui	$2,%hi(gFileMgr) # high
	addiu	$3,$2,%lo(gFileMgr) # low
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L10
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	lw	$3,28($3)
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	j	$L4
	sw	$2,0($3)
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	reservehandle
	.def	reserveop;	.val	reserveop;	.scl	2;	.tag	FileOp;	.size	48;	.type	0x68;	.endef
	.text
	.ent	reserveop
reserveop:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
 #APP
	mfc0 $13,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$13,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lui	$3,%hi(gFileMgr) # high
	lw	$2,%lo(gFileMgr)($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L14
	move	$7,$0
	.set	macro
	.set	reorder

	li	$10,-15794176			# 0xff0f0000
	ori	$10,$10,0xffff
	li	$11,1048576			# 0x00100000
	li	$9,983040			# 0x000f0000
	ori	$9,$9,0xffff
	li	$12,-1048576			# 0xfff00000
	move	$6,$7
	move	$5,$3
	addiu	$8,$5,%lo(gFileMgr) # low
$L15:
	lw	$2,24($8)
	#nop
	addu	$4,$6,$2
	lw	$3,0($4)
	#nop
	srl	$2,$3,20
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	and	$2,$3,$10
	.set	macro
	.set	reorder

	or	$2,$2,$11
	sw	$2,0($4)
	lw	$2,24($8)
	lw	$5,gFileOpSeq
	addu	$2,$6,$2
	and	$5,$5,$9
	sb	$7,3($2)
	lw	$4,24($8)
	lw	$3,gFileOpSeq
	addu	$4,$6,$4
	lw	$2,0($4)
	addu	$3,$3,1
	sw	$3,gFileOpSeq
	slt	$3,$9,$3
	and	$2,$2,$12
	or	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L14
	sw	$2,0($4)
	.set	macro
	.set	reorder

	sw	$0,gFileOpSeq
	j	$L14
$L18:
	lw	$2,%lo(gFileMgr)($5)
	addu	$7,$7,1
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	addu	$6,$6,48
	.set	macro
	.set	reorder

$L14:
 #APP
	mtc0 $13,$12
 #NO_APP
	lui	$2,%hi(gFileMgr) # high
	lw	$3,%lo(gFileMgr)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$7,$3,$L21
	addiu	$4,$2,%lo(gFileMgr) # low
	.set	macro
	.set	reorder

	sll	$2,$7,1
	addu	$2,$2,$7
	lw	$3,24($4)
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L21:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	reserveop
	.def	FILE_overhead;	.val	FILE_overhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_overhead
FILE_overhead:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	handlecount;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	opcount;	.val	6;	.scl	17;	.type	0x4;	.endef
	bne	$4,$0,$L24
	li	$4,24			# 0x00000018
$L24:
	bne	$5,$0,$L25
	li	$5,2048			# 0x00000800
$L25:
	bne	$6,$0,$L26
	li	$6,10			# 0x0000000a
$L26:
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$3,$4,2
	addu	$3,$3,$4
	addu	$3,$3,$2
	sll	$3,$3,4
	sll	$2,$5,2
	addu	$2,$2,$5
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	FILE_overhead
	.def	FILE_opstatus;	.val	FILE_opstatus;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_opstatus
FILE_opstatus:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	6;	.scl	17;	.type	0xe;	.endef
	move	$6,$4
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L28
	subu	$sp,$sp,16
	.set	macro
	.set	reorder

	li	$5,983040			# 0x000f0000
	ori	$5,$5,0xffff
	lui	$4,%hi(gFileMgr+24) # high
	srl	$3,$6,24
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,%lo(gFileMgr+24)($4)
	sll	$2,$2,4
	addu	$4,$3,$2
	lw	$2,0($4)
	and	$3,$6,$5
	and	$2,$2,$5
	beq	$3,$2,$L30
$L28:
	.set	noreorder
	.set	nomacro
	j	$L31
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	.def	success;	.val	$L30;	.scl	6;	.type	0x0;	.endef
$L30:
	lw	$2,8($4)
$L31:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	FILE_opstatus
	.def	FILE_operror;	.val	FILE_operror;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_operror
FILE_operror:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	lui	$3,%hi(gFileMgr+24) # high
	srl	$4,$4,24
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,%lo(gFileMgr+24)($3)
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,12($2)
	subu	$sp,$sp,16
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	FILE_operror
	.def	FILE_init;	.val	FILE_init;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_init
FILE_init:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	handlecount;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	opcount;	.val	18;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gFileMgr) # high
	lw	$2,%lo(gFileMgr)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L35
	move	$2,$0
	.set	macro
	.set	reorder

$L34:
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	FILE_overhead
	move	$6,$18
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	FILE_initwithmem
	move	$7,$2
	.set	macro
	.set	reorder

$L35:
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
LM8:
	.end	FILE_init
	.def	FILE_completeop;	.val	FILE_completeop;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_completeop
FILE_completeop:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$16,32($sp)
	lui	$3,%hi(gFileMgr+24) # high
	srl	$4,$4,24
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,%lo(gFileMgr+24)($3)
	sll	$2,$2,4
	sw	$31,36($sp)
	addu	$4,$3,$2
	#.set	volatile
	lw	$2,8($4)
	#.set	novolatile
	#.set	volatile
	lw	$3,8($4)
	#.set	novolatile
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L37
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	srl	$2,$2,20
	andi	$2,$2,0x000f
	addu	$3,$2,-2
	sltu	$2,$3,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L37
	lui	$2,%hi($L49) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L49) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L49:
	.word	$L40
	.word	$L43
	.word	$L47
	.word	$L47
	.word	$L45
	.word	$L43
	.word	$L45
	.word	$L40
	.word	$L43
	.text
$L40:
	lw	$16,36($4)
	j	$L37
$L43:
	lw	$16,8($4)
	j	$L37
$L45:
	lw	$16,24($4)
	j	$L37
$L47:
	lw	$16,28($4)
$L37:
	jal	freeop
	move	$2,$16
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	FILE_completeop
	.def	FILE_callbackop;	.val	FILE_callbackop;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FILE_callbackop
FILE_callbackop:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	callback;	.val	7;	.scl	17;	.type	0x91;	.endef
	subu	$sp,$sp,40
	lui	$2,%hi(gFileMgr) # high
	sw	$16,32($sp)
	addiu	$16,$2,%lo(gFileMgr) # low
	srl	$3,$4,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sw	$31,36($sp)
	lw	$3,24($16)
	sll	$2,$2,4
	addu	$3,$3,$2
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L51
	move	$7,$5
	.set	macro
	.set	reorder

	sw	$7,40($3)
	lw	$2,16($16)
	#nop
	addu	$2,$2,1
	sw	$2,16($16)
	lw	$5,8($3)
	lw	$6,20($3)
	jal	$31,$7
	lw	$2,16($16)
	#nop
	addu	$2,$2,-1
	sw	$2,16($16)
$L51:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM10:
	.end	FILE_callbackop
	.def	FILE_open;	.val	FILE_open;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_open
FILE_open:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	name;	.val	20;	.scl	17;	.type	0x12;	.endef
	.def	a1;	.val	17;	.scl	17;	.type	0xe;	.endef
	.def	a2;	.val	18;	.scl	17;	.type	0xe;	.endef
	.def	a3;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	move	$16,$7
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	sw	$19,28($sp)
	.set	macro
	.set	reorder

	li	$4,-15794176			# 0xff0f0000
	move	$19,$2
	ori	$4,$4,0xffff
	lw	$3,0($19)
	li	$2,2097152			# 0x00200000
	sw	$16,20($19)
	sw	$17,24($19)
	sw	$18,16($19)
	and	$3,$3,$4
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	reservehandle
	sw	$3,0($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L53
	sw	$2,36($19)
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sw	$2,12($19)
	.set	noreorder
	.set	nomacro
	jal	iFILE_perror
	move	$4,$19
	.set	macro
	.set	reorder

$L53:
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$20
	.set	macro
	.set	reorder

	move	$5,$20
	lw	$4,36($19)
	li	$6,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	strncpy
	addu	$4,$4,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$2,0($19)
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
LM11:
	.end	FILE_open
	.def	FILE_close;	.val	FILE_close;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_close
FILE_close:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	19;	.scl	17;	.type	0x11;	.endef
	.def	a1;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	a2;	.val	17;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$4,-15794176			# 0xff0f0000
	lui	$3,%hi(gFileMgr+36) # high
	move	$18,$2
	ori	$4,$4,0xffff
	lw	$5,%lo(gFileMgr+36)($3)
	lw	$3,0($18)
	li	$2,3145728			# 0x00300000
	sw	$16,16($18)
	sw	$17,20($18)
	sw	$19,36($18)
	and	$3,$3,$4
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L56
	sw	$3,0($18)
	.set	macro
	.set	reorder

	li	$3,3			# 0x00000003
$L57:
	lw	$2,4($5)
	#nop
	bne	$2,$19,$L58
	sw	$3,12($18)
	.set	noreorder
	.set	nomacro
	jal	iFILE_perror
	move	$4,$18
	.set	macro
	.set	reorder

	j	$L56
$L58:
	lw	$5,12($5)
	#nop
	bne	$5,$0,$L57
$L56:
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,0($18)
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
LM12:
	.end	FILE_close
	.def	FILE_read;	.val	FILE_read;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_read
FILE_read:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	handle;	.val	20;	.scl	17;	.type	0x11;	.endef
	.def	offset;	.val	21;	.scl	17;	.type	0xe;	.endef
	.def	dest;	.val	22;	.scl	17;	.type	0xe;	.endef
	.def	len;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	a5;	.val	16;	.scl	9;	.type	0xe;	.endef
	.def	a6;	.val	20;	.scl	9;	.type	0xe;	.endef
	.def	a5;	.val	17;	.scl	4;	.type	0xe;	.endef
	.def	a6;	.val	16;	.scl	4;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$17,20($sp)
	lw	$17,64($sp)
	sw	$16,16($sp)
	lw	$16,68($sp)
	sw	$20,32($sp)
	move	$20,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$22,40($sp)
	move	$22,$6
	sw	$19,28($sp)
	move	$19,$7
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$3,-15794176			# 0xff0f0000
	move	$18,$2
	lw	$2,0($18)
	ori	$3,$3,0xffff
	and	$2,$2,$3
	li	$3,4194304			# 0x00400000
	or	$2,$2,$3
	sw	$2,0($18)
	sw	$16,20($18)
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L61
	sw	$17,16($18)
	.set	macro
	.set	reorder

	li	$2,6			# 0x00000006
	sw	$2,12($18)
	.set	noreorder
	.set	nomacro
	jal	iFILE_perror
	move	$4,$18
	.set	macro
	.set	reorder

$L61:
	sw	$20,36($18)
	lw	$4,4($20)
	addu	$2,$21,$19
	slt	$2,$4,$2
	beq	$2,$0,$L62
	subu	$19,$4,$21
	.set	noreorder
	.set	nomacro
	bgez	$19,$L64
	move	$4,$18
	.set	macro
	.set	reorder

	move	$19,$0
$L62:
	move	$4,$18
$L64:
	sw	$19,28($18)
	sw	$22,32($18)
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	sw	$21,24($18)
	.set	macro
	.set	reorder

	lw	$2,0($18)
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM13:
	.end	FILE_read
	.def	FILE_size;	.val	FILE_size;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_size
FILE_size:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	19;	.scl	17;	.type	0x11;	.endef
	.def	a1;	.val	17;	.scl	17;	.type	0xe;	.endef
	.def	a2;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$4,-15794176			# 0xff0f0000
	move	$18,$2
	ori	$4,$4,0xffff
	lw	$3,0($18)
	li	$2,6291456			# 0x00600000
	sw	$16,20($18)
	sw	$17,16($18)
	and	$3,$3,$4
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L66
	sw	$3,0($18)
	.set	macro
	.set	reorder

	li	$2,6			# 0x00000006
	sw	$2,12($18)
	.set	noreorder
	.set	nomacro
	jal	iFILE_perror
	move	$4,$18
	.set	macro
	.set	reorder

$L66:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	sw	$19,36($18)
	.set	macro
	.set	reorder

	lw	$2,0($18)
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
LM14:
	.end	FILE_size
	.def	iFILE_perror;	.val	iFILE_perror;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iFILE_perror
iFILE_perror:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	op;	.val	4;	.scl	17;	.tag	FileOp;	.size	48;	.type	0x18;	.endef
	j	$31

	.loc	1 0
LM15:
	.end	iFILE_perror
	.def	FILE_waitop;	.val	FILE_waitop;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_waitop
FILE_waitop:
	.frame	$sp,72,$31		# vars= 24, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	id;	.val	20;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,72
	sw	$20,56($sp)
	move	$20,$4
	lui	$2,%hi(gFileMgr) # high
	addiu	$6,$2,%lo(gFileMgr) # low
	srl	$3,$20,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sw	$31,64($sp)
	sw	$21,60($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	lw	$3,24($6)
	sll	$5,$2,4
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L70
	addu	$16,$3,$5
	.set	macro
	.set	reorder

	li	$3,983040			# 0x000f0000
	ori	$3,$3,0xffff
	lw	$2,0($16)
	and	$4,$20,$3
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L81
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	li	$19,983040			# 0x000f0000
	.set	macro
	.set	reorder

	ori	$19,$19,0xffff
	move	$18,$4
	move	$21,$6
	move	$17,$5
$L73:
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L81
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	lw	$2,24($21)
	#nop
	addu	$2,$17,$2
	lw	$2,0($2)
	#nop
	and	$2,$2,$19
	beq	$18,$2,$L78
	.def	invalid;	.val	$L70;	.scl	6;	.type	0x0;	.endef
$L70:
	.set	noreorder
	.set	nomacro
	j	$L81
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	.def	valid;	.val	$L78;	.scl	6;	.type	0x0;	.endef
$L78:
	lw	$2,8($16)
	#nop
	beq	$2,$0,$L73
$L72:
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
$L81:
	lw	$31,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM16:
	.end	FILE_waitop
	.def	FILE_atomic;	.val	FILE_atomic;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_atomic
FILE_atomic:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	fn;	.val	2;	.scl	17;	.type	0x94;	.endef
	.def	unused;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	a3;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a4;	.val	7;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	move	$2,$4
	move	$4,$6
	sw	$16,16($sp)
	lui	$16,%hi(gFileMgr) # high
	addiu	$16,$16,%lo(gFileMgr) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$17,8($16)
	move	$5,$7
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$4,8($16)
	.set	macro
	.set	reorder

	move	$4,$0
	sw	$17,8($16)
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	move	$16,$2
	.set	macro
	.set	reorder

	move	$2,$16
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
LM17:
	.end	FILE_atomic
	.def	FILE_priorityop;	.val	FILE_priorityop;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FILE_priorityop
FILE_priorityop:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	priority;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,16
	lui	$2,%hi(gFileMgr) # high
	addiu	$7,$2,%lo(gFileMgr) # low
	srl	$4,$4,24
	sll	$2,$4,1
	addu	$2,$2,$4
	lw	$3,24($7)
	sll	$2,$2,4
	addu	$6,$3,$2
 #APP
	mfc0 $9,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$9,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lw	$3,16($6)
	sw	$5,16($6)
	lw	$2,12($7)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L84
	lw	$2,20($7)
	#nop
	beq	$6,$2,$L84
	lw	$2,8($6)
	#nop
	bne	$2,$0,$L84
	beq	$3,$5,$L84
	lw	$2,32($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L86
	move	$4,$0
	.set	macro
	.set	reorder

$L87:
	beq	$2,$6,$L86
	move	$4,$2
	lw	$2,44($4)
	#nop
	bne	$2,$0,$L87
$L86:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L90
	lui	$2,%hi(gFileMgr+32) # high
	.set	macro
	.set	reorder

	lw	$2,44($6)
	.set	noreorder
	.set	nomacro
	j	$L91
	sw	$2,44($4)
	.set	macro
	.set	reorder

$L90:
	lw	$3,44($6)
	#nop
	sw	$3,%lo(gFileMgr+32)($2)
$L91:
	lui	$2,%hi(gFileMgr+32) # high
	lw	$2,%lo(gFileMgr+32)($2)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L93
	sw	$2,44($6)
	.set	macro
	.set	reorder

	lw	$5,16($6)
$L94:
	lw	$3,44($6)
	#nop
	lw	$2,16($3)
	#nop
	slt	$2,$5,$2
	bne	$2,$0,$L93
	move	$4,$3
	lw	$2,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L94
	sw	$2,44($6)
	.set	macro
	.set	reorder

$L93:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L97
	lui	$2,%hi(gFileMgr+32) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L84
	sw	$6,44($4)
	.set	macro
	.set	reorder

$L97:
	sw	$6,%lo(gFileMgr+32)($2)
$L84:
 #APP
	mtc0 $9,$12
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder


	.loc	1 0
LM18:
	.end	FILE_priorityop
	.def	FILE_initwithmem;	.val	FILE_initwithmem;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FILE_initwithmem
FILE_initwithmem:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	handlecount;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	opcount;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	membuf;	.val	7;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L100
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$4,24			# 0x00000018
$L100:
	bne	$17,$0,$L101
	li	$17,2048			# 0x00000800
$L101:
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L107
	lui	$18,%hi(gFileMgr) # high
	.set	macro
	.set	reorder

	li	$6,10			# 0x0000000a
$L107:
	lw	$2,%lo(gFileMgr)($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L104
	addiu	$16,$18,%lo(gFileMgr) # low
	.set	macro
	.set	reorder

	move	$5,$17
	li	$2,255			# 0x000000ff
	sw	$6,%lo(gFileMgr)($18)
	sw	$4,4($16)
	sw	$2,8($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_overhead
	sw	$7,24($16)
	.set	macro
	.set	reorder

	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,%lo(gFileMgr)($18)
	lw	$4,disablecd
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,24($16)
	sll	$2,$2,4
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L105
	sw	$3,28($16)
	.set	macro
	.set	reorder

	move	$5,$17
	lui	$7,%hi(iFILE_CommandCompleteCallback) # high
	lw	$4,4($16)
	addiu	$7,$7,%lo(iFILE_CommandCompleteCallback) # low
	sll	$6,$4,2
	addu	$6,$6,$4
	sll	$6,$6,2
	subu	$6,$6,$4
	sll	$6,$6,2
	.set	noreorder
	.set	nomacro
	jal	CD_Init
	addu	$6,$3,$6
	.set	macro
	.set	reorder

	sltu	$2,$2,1
	sw	$2,disablecd
$L105:
	jal	initfileio
	.set	noreorder
	.set	nomacro
	j	$L106
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	already_init;	.val	$L104;	.scl	6;	.type	0x0;	.endef
$L104:
	move	$2,$0
$L106:
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
LM19:
	.end	FILE_initwithmem
	.def	FILE_cancelop;	.val	FILE_cancelop;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FILE_cancelop
FILE_cancelop:
	.frame	$sp,48,$31		# vars= 24, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	5;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	move	$5,$4
	move	$6,$0
	sw	$31,44($sp)
	sw	$16,40($sp)
 #APP
	mfc0 $16,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$16,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L110
	li	$4,983040			# 0x000f0000
	.set	macro
	.set	reorder

	ori	$4,$4,0xffff
	lui	$2,%hi(gFileMgr) # high
	addiu	$8,$2,%lo(gFileMgr) # low
	srl	$3,$5,24
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,24($8)
	sll	$2,$2,4
	addu	$7,$2,$3
	lw	$2,0($7)
	and	$3,$5,$4
	and	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L110
	srl	$2,$5,20
	.set	macro
	.set	reorder

	andi	$3,$2,0x000f
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L110
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	beq	$3,$2,$L110
	lw	$2,20($8)
	move	$5,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L114
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,4($5)
	.set	noreorder
	.set	nomacro
	j	$L135
	move	$6,$2
	.set	macro
	.set	reorder

$L114:
	lw	$3,8($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L134
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,32($8)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L110
	move	$3,$0
	.set	macro
	.set	reorder

$L121:
	beq	$2,$5,$L120
	move	$3,$2
	lw	$2,44($3)
	#nop
	bne	$2,$0,$L121
$L120:
	bne	$2,$0,$L124
 #APP
	mtc0 $16,$12
 #NO_APP
	j	$L108
$L124:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L125
	lui	$2,%hi(gFileMgr+32) # high
	.set	macro
	.set	reorder

	lw	$2,44($5)
	.set	noreorder
	.set	nomacro
	j	$L126
	sw	$2,44($3)
	.set	macro
	.set	reorder

$L125:
	lw	$3,44($5)
	#nop
	sw	$3,%lo(gFileMgr+32)($2)
$L126:
	lui	$2,%hi(gFileMgr) # high
	addiu	$2,$2,%lo(gFileMgr) # low
	lw	$3,12($2)
	li	$6,2			# 0x00000002
	addu	$3,$3,-1
	sw	$3,12($2)
	li	$2,-1			# 0xffffffff
$L134:
	sw	$2,8($5)
	li	$2,1			# 0x00000001
$L135:
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L127
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,0($5)
	li	$3,4			# 0x00000004
	srl	$2,$2,20
	andi	$2,$2,0x000f
	bne	$2,$3,$L110
	lw	$2,36($5)
	#nop
	lw	$4,0($2)
	jal	stopreadfile
	j	$L110
$L127:
	bne	$6,$2,$L110
	lw	$2,40($5)
	#nop
	beq	$2,$0,$L110
	lw	$4,0($5)
	lw	$6,20($5)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.def	cleanup;	.val	$L110;	.scl	6;	.type	0x0;	.endef
$L110:
 #APP
	mtc0 $16,$12
 #NO_APP
$L108:
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM20:
	.end	FILE_cancelop
	.def	iFILE_delbigclosecallback;	.val	iFILE_delbigclosecallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iFILE_delbigclosecallback
iFILE_delbigclosecallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	a1;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	cmd;	.val	16;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$16,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM21:
	.end	iFILE_delbigclosecallback
	.def	iFILE_CommandCompleteCallback;	.val	iFILE_CommandCompleteCallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iFILE_CommandCompleteCallback
iFILE_CommandCompleteCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	result;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gFileMgr+20) # high
	lw	$6,%lo(gFileMgr+20)($2)
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L137
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,4($6)
	#.set	volatile
	lw	$3,8($6)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L139
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L140
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L139:
$L140:
	sw	$2,8($6)
	lui	$2,%hi(gFileMgr) # high
	addiu	$16,$2,%lo(gFileMgr) # low
	sw	$0,20($16)
	lw	$2,40($6)
	#nop
	beq	$2,$0,$L143
	lw	$2,16($16)
	#nop
	addu	$2,$2,1
	sw	$2,16($16)
	lw	$4,0($6)
	lw	$2,40($6)
	lw	$5,8($6)
	lw	$6,20($6)
	jal	$31,$2
	lw	$2,16($16)
	#nop
	addu	$2,$2,-1
	sw	$2,16($16)
$L143:
	lw	$2,16($16)
	#nop
	bne	$2,$0,$L137
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	move	$4,$0
	.set	macro
	.set	reorder

$L137:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM22:
	.end	iFILE_CommandCompleteCallback
	.def	size_t;	.scl	13;	.type	0xe;	.endef
	.def	iFILE_addbigreadcallback;	.val	iFILE_addbigreadcallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iFILE_addbigreadcallback
iFILE_addbigreadcallback:
	.frame	$sp,56,$31		# vars= 8, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	node;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$6
	lui	$2,%hi(gFileMgr) # high
	sw	$19,44($sp)
	addiu	$19,$2,%lo(gFileMgr) # low
	srl	$3,$4,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	sw	$31,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$16,32($sp)
	lw	$3,24($19)
	lw	$5,8($17)
	addu	$3,$3,$2
	lw	$2,36($3)
	lw	$20,16($3)
	sw	$2,4($17)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	sw	$2,36($5)
	.set	macro
	.set	reorder

	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	typeofbigfile
	move	$16,$17
	.set	macro
	.set	reorder

	bne	$2,$0,$L146
	lw	$4,0($17)
	jal	purgememadr
$L146:
	lw	$4,0($17)
	jal	sizeofbigfileheader
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	getblocksize
	move	$18,$2
	.set	macro
	.set	reorder

	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L147
	lui	$4,%hi($LC1) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC1) # low
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	move	$5,$16
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,2048			# 0x00000800
	.set	macro
	.set	reorder

	lw	$4,0($17)
	jal	purgememadr
	li	$5,2048			# 0x00000800
	addu	$6,$16,$5
	sw	$16,0($17)
	sw	$20,16($sp)
	sw	$17,20($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	FILE_read
	addu	$7,$18,-2048
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(iFILE_addbigreadcallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(iFILE_addbigreadcallback) # low
	.set	macro
	.set	reorder

	j	$L148
$L147:
	lw	$2,36($19)
	#nop
	sw	$2,12($16)
	sw	$16,36($19)
	lw	$4,8($16)
	jal	iFILE_ExecCommand
$L148:
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
LM23:
	.end	iFILE_addbigreadcallback
	.def	iFILE_addbigopencallback;	.val	iFILE_addbigopencallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iFILE_addbigopencallback
iFILE_addbigopencallback:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	status;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	node;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,56
	sw	$16,32($sp)
	move	$16,$5
	sw	$17,36($sp)
	lui	$5,%hi(gFileMgr+24) # high
	srl	$3,$4,24
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,%lo(gFileMgr+24)($5)
	sll	$2,$2,4
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	addu	$2,$2,$3
	lw	$19,16($2)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$17,$6
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L150
	move	$18,$17
	.set	macro
	.set	reorder

	lw	$3,8($17)
	li	$2,4			# 0x00000004
	sw	$2,12($3)
	lw	$4,8($17)
	jal	iFILE_ExecCommand
	j	$L151
$L150:
	move	$5,$0
	sw	$19,16($sp)
	sw	$18,20($sp)
	lw	$6,0($18)
	.set	noreorder
	.set	nomacro
	jal	FILE_read
	li	$7,2048			# 0x00000800
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(iFILE_addbigreadcallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(iFILE_addbigreadcallback) # low
	.set	macro
	.set	reorder

$L151:
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
LM24:
	.end	iFILE_addbigopencallback
	.def	FILE_addbig;	.val	FILE_addbig;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_addbig
FILE_addbig:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	19;	.scl	17;	.type	0x12;	.endef
	.def	a1;	.val	21;	.scl	17;	.type	0xe;	.endef
	.def	datatype;	.val	20;	.scl	17;	.type	0xe;	.endef
	.def	param;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	lui	$2,%hi(gFileMgr+36) # high
	sw	$17,20($sp)
	lw	$17,%lo(gFileMgr+36)($2)
	sw	$19,28($sp)
	move	$19,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$16,16($sp)
	move	$16,$7
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$5,-15794176			# 0xff0f0000
	ori	$5,$5,0xffff
	move	$18,$2
	move	$4,$0
	lw	$3,0($18)
	li	$2,9437184			# 0x00900000
	sw	$16,20($18)
	sw	$20,16($18)
	and	$3,$3,$5
	or	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	iscurrentthread
	sw	$3,0($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L160
	move	$4,$19
	.set	macro
	.set	reorder

$L161:
	lw	$5,4($17)
	li	$6,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	strncmp
	addu	$5,$5,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L155
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	jal	iFILE_ExecCommand
	sw	$2,36($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L159
	move	$2,$18
	.set	macro
	.set	reorder

$L155:
	lw	$17,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L161
	move	$4,$19
	.set	macro
	.set	reorder

$L160:
	li	$5,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$21
	.set	macro
	.set	reorder

	move	$17,$2
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,2048			# 0x00000800
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$18,8($17)
	.set	macro
	.set	reorder

	move	$4,$19
	li	$5,1			# 0x00000001
	move	$6,$20
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	sw	$2,0($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(iFILE_addbigopencallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(iFILE_addbigopencallback) # low
	.set	macro
	.set	reorder

	lw	$2,0($18)
$L159:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM25:
	.end	FILE_addbig
	.def	FILE_delbig;	.val	FILE_delbig;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	FILE_delbig
FILE_delbig:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	delHandle;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	a2;	.val	21;	.scl	17;	.type	0xe;	.endef
	.def	a3;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$16,16($sp)
	lui	$2,%hi(gFileMgr) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(gFileMgr) # low
	sw	$31,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$17,36($19)
	.set	noreorder
	.set	nomacro
	jal	reserveop
	move	$16,$6
	.set	macro
	.set	reorder

	li	$4,-15794176			# 0xff0f0000
	move	$18,$2
	ori	$4,$4,0xffff
	lw	$5,28($19)
	lw	$3,0($18)
	li	$2,10485760			# 0x00a00000
	sw	$16,20($18)
	sw	$21,16($18)
	and	$3,$3,$4
	or	$3,$3,$2
	sw	$3,0($18)
	lw	$2,8($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L163
	move	$16,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,12($18)
$L163:
	lw	$4,4($19)
	#nop
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L165
	move	$3,$0
	.set	macro
	.set	reorder

$L167:
	beq	$5,$0,$L168
	lw	$2,8($5)
	#nop
	beq	$2,$0,$L168
	lw	$2,0($5)
	#nop
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L180
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L168:
	addu	$3,$3,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L167
	addu	$5,$5,76
	.set	macro
	.set	reorder

$L165:
	lw	$19,4($17)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L181
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L173:
	lw	$2,4($17)
	#nop
	beq	$2,$20,$L172
	move	$16,$17
	lw	$17,12($17)
	#nop
	bne	$17,$0,$L173
$L172:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L176
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L181:
	sw	$2,12($18)
$L176:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L177
	lui	$2,%hi(gFileMgr+36) # high
	.set	macro
	.set	reorder

	lw	$2,12($17)
	.set	noreorder
	.set	nomacro
	j	$L178
	sw	$2,12($16)
	.set	macro
	.set	reorder

$L180:
	sw	$2,8($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L165
	sw	$2,12($18)
	.set	macro
	.set	reorder

$L177:
	sw	$0,%lo(gFileMgr+36)($2)
$L178:
	lw	$4,0($17)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	FILE_close
	move	$6,$18
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(iFILE_delbigclosecallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(iFILE_delbigclosecallback) # low
	.set	macro
	.set	reorder

	lw	$2,0($18)
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM26:
	.end	FILE_delbig
	.def	iFILE_ExecCommand;	.val	iFILE_ExecCommand;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iFILE_ExecCommand
iFILE_ExecCommand:
	.frame	$sp,184,$31		# vars= 136, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	cmdp;	.val	4;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,184
	sw	$17,164($sp)
	move	$17,$4
	sw	$31,176($sp)
	sw	$19,172($sp)
	sw	$18,168($sp)
	sw	$16,160($sp)
 #APP
	mfc0 $6,$12
	 nop
	 addiu $at,$zero,-0x402
	 and $8,$6,$at
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L183
	lui	$2,%hi(gFileMgr+32) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gFileMgr+32)($2)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L184
	sw	$2,44($17)
	.set	macro
	.set	reorder

	lw	$5,16($17)
$L185:
	lw	$3,44($17)
	#nop
	lw	$2,16($3)
	#nop
	slt	$2,$5,$2
	bne	$2,$0,$L184
	move	$4,$3
	lw	$2,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L185
	sw	$2,44($17)
	.set	macro
	.set	reorder

$L184:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L190
	lui	$2,%hi(gFileMgr+32) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L191
	sw	$17,44($4)
	.set	macro
	.set	reorder

$L190:
	sw	$17,%lo(gFileMgr+32)($2)
$L191:
	lui	$3,%hi(gFileMgr) # high
	addiu	$3,$3,%lo(gFileMgr) # low
	lw	$2,12($3)
	#nop
	addu	$2,$2,1
	sw	$2,12($3)
$L183:
	lui	$2,%hi(gFileMgr) # high
	addiu	$4,$2,%lo(gFileMgr) # low
	lw	$2,20($4)
	#nop
	beq	$2,$0,$L192
 #APP
	mtc0 $6,$12
 #NO_APP
	j	$L182
$L192:
	lw	$17,32($4)
	#nop
	beq	$17,$0,$L193
	lw	$3,16($17)
	lw	$2,8($4)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L193
	lw	$2,12($4)
	lw	$3,44($17)
	addu	$2,$2,-1
	sw	$3,32($4)
	.set	noreorder
	.set	nomacro
	j	$L194
	sw	$2,12($4)
	.set	macro
	.set	reorder

$L193:
	move	$17,$0
$L194:
	lui	$2,%hi(gFileMgr+20) # high
	sw	$17,%lo(gFileMgr+20)($2)
 #APP
	mtc0 $6,$12
 #NO_APP
	beq	$17,$0,$L182
	lw	$2,0($17)
	#nop
	srl	$2,$2,20
	andi	$2,$2,0x000f
	addu	$3,$2,-2
	sltu	$2,$3,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L182
	sll	$3,$3,2
	.set	macro
	.set	reorder

	lui	$2,%hi($L232) # high
	addiu	$2,$2,%lo($L232) # low
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L232:
	.word	$L199
	.word	$L220
	.word	$L223
	.word	$L227
	.word	$L228
	.word	$L231
	.word	$L199
	.word	$L231
	.word	$L231
	.text
$L199:
	sb	$0,88($sp)
	lw	$4,36($17)
	li	$5,124			# 0x0000007c
	.set	noreorder
	.set	nomacro
	jal	strchr
	addu	$4,$4,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L200
	li	$2,124			# 0x0000007c
	.set	macro
	.set	reorder

	lw	$4,36($17)
	#nop
	lbu	$3,12($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L237
	li	$19,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$4,12
	.set	noreorder
	.set	nomacro
	jal	strchr
	move	$5,$2
	.set	macro
	.set	reorder

	li	$19,4			# 0x00000004
	lw	$3,36($17)
	addu	$4,$sp,24
	sb	$0,24($sp)
	lw	$5,36($17)
	addu	$16,$2,-12
	addu	$5,$5,12
	subu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	jal	strncpy
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$2,$sp,$16
	sb	$0,24($2)
	lw	$4,36($17)
$L237:
	li	$5,124			# 0x0000007c
	.set	noreorder
	.set	nomacro
	jal	strchr
	addu	$4,$4,12
	.set	macro
	.set	reorder

	addu	$4,$sp,88
	.set	noreorder
	.set	nomacro
	j	$L234
	addu	$5,$2,1
	.set	macro
	.set	reorder

$L200:
	lw	$2,24($17)
	li	$19,1			# 0x00000001
	and	$2,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L202
	addu	$4,$sp,88
	.set	macro
	.set	reorder

	li	$19,3			# 0x00000003
	lw	$5,36($17)
	#nop
	addu	$5,$5,12
$L234:
	jal	strcpy
$L202:
	andi	$2,$19,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L204
	move	$18,$0
	.set	macro
	.set	reorder

	lw	$6,36($17)
	lw	$5,24($17)
	.set	noreorder
	.set	nomacro
	jal	openfile
	addu	$4,$6,12
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L204
	li	$3,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	srl	$2,$2,20
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L206
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,36($17)
	#nop
	lw	$4,0($2)
	jal	closefile
	j	$L204
$L206:
	lw	$2,36($17)
	#nop
	lw	$4,0($2)
	jal	getfilesize
	lw	$3,36($17)
	#nop
	sw	$2,4($3)
$L204:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L208
	andi	$2,$19,0x0006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L208
	lui	$2,%hi(gFileMgr+36) # high
	.set	macro
	.set	reorder

	lw	$16,%lo(gFileMgr+36)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L208
	andi	$2,$19,0x0004
	.set	macro
	.set	reorder

$L236:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L213
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$4,$4,12
	.set	macro
	.set	reorder

	bne	$2,$0,$L212
$L213:
	addu	$5,$sp,88
	move	$6,$0
	addu	$2,$sp,156
	sw	$2,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	addu	$7,$sp,152
	.set	macro
	.set	reorder

	beq	$2,$0,$L212
	lw	$2,36($17)
	#nop
	sw	$16,0($2)
	lw	$3,36($17)
	lw	$2,156($sp)
	#nop
	sw	$2,4($3)
	lw	$3,36($17)
	lw	$2,152($sp)
	li	$18,1			# 0x00000001
	sw	$2,8($3)
$L212:
	lw	$16,12($16)
	#nop
	beq	$16,$0,$L208
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L236
	andi	$2,$19,0x0004
	.set	macro
	.set	reorder

$L208:
	lw	$2,0($17)
	li	$3,8			# 0x00000008
	srl	$2,$2,20
	andi	$2,$2,0x000f
	bne	$2,$3,$L219
	lw	$4,36($17)
	jal	freehandle
	sw	$18,24($17)
$L219:
	.set	noreorder
	.set	nomacro
	j	$L235
	move	$4,$18
	.set	macro
	.set	reorder

$L220:
	lw	$4,36($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L231
	sw	$0,12($17)
	.set	macro
	.set	reorder

	lw	$2,8($4)
	#nop
	bne	$2,$0,$L222
	lw	$4,0($4)
	jal	closefile
	sw	$2,12($17)
$L222:
	lw	$4,36($17)
	jal	freehandle
	.set	noreorder
	.set	nomacro
	j	$L231
	sw	$0,36($17)
	.set	macro
	.set	reorder

$L223:
	lw	$7,28($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$7,$L235
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,36($17)
	#nop
	lw	$3,8($2)
	#nop
	beq	$3,$0,$L225
	lw	$2,0($2)
	lw	$5,32($17)
	lw	$2,4($2)
	lw	$6,24($17)
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	readfile
	addu	$6,$3,$6
	.set	macro
	.set	reorder

	j	$L182
$L225:
	lw	$4,0($2)
	lw	$5,32($17)
	lw	$6,24($17)
	jal	readfile
	j	$L182
$L227:
	lw	$5,32($17)
	lw	$6,24($17)
	lw	$2,36($17)
	lw	$7,28($17)
	lw	$4,0($2)
	jal	writefile
	j	$L182
$L228:
	lw	$2,36($17)
	#nop
	lw	$2,4($2)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L235
	sw	$2,24($17)
	.set	macro
	.set	reorder

$L231:
	lw	$4,12($17)
	#nop
	sltu	$4,$4,1
$L235:
	jal	iFILE_CommandCompleteCallback
$L182:
	lw	$31,176($sp)
	lw	$19,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder


	.loc	1 0
LM27:
	.end	iFILE_ExecCommand
	.def	gFileMgr;	.val	gFileMgr;	.scl	2;	.tag	FileMgr;	.size	48;	.type	0x8;	.endef
	.def	gFileOpSeq;	.val	gFileOpSeq;	.scl	2;	.type	0x4;	.endef
