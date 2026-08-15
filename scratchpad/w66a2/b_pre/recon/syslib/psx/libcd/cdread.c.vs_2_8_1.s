	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\cdread.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	CdlCB;	.scl	13;	.type	0x94;	.endef
	.def	CdlLOC;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	minute;	.val	0;	.scl	8;	.type	0xc;	.endef
	.def	second;	.val	1;	.scl	8;	.type	0xc;	.endef
	.def	sector;	.val	2;	.scl	8;	.type	0xc;	.endef
	.def	track;	.val	3;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	CdlLOC;	.size	4;	.endef
	.def	CdlLOC;	.scl	13;	.tag	CdlLOC;	.size	4;	.type	0x8;	.endef
	.def	CdrEnv;	.scl	10;	.type	0x8;	.size	56;	.endef
	.def	w00;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	w04;	.val	4;	.scl	8;	.type	0x1c;	.endef
	.def	w08;	.val	8;	.scl	8;	.type	0x1c;	.endef
	.def	w0c;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	w10;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	w14;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	w18;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	w1c;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	w20;	.val	32;	.scl	8;	.type	0x4;	.endef
	.def	w24;	.val	36;	.scl	8;	.type	0x4;	.endef
	.def	w28;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	w2c;	.val	44;	.scl	8;	.type	0x4;	.endef
	.def	w30;	.val	48;	.scl	8;	.type	0x4;	.endef
	.def	w34;	.val	52;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	56;	.scl	102;	.tag	CdrEnv;	.size	56;	.endef
	.def	CdrEnv;	.scl	13;	.tag	CdrEnv;	.size	56;	.type	0x8;	.endef
	.align	2
	.def	_read_sync;	.val	_read_sync;	.scl	2;	.type	0x21;	.endef
	.globl	_read_sync
	.text
	.ent	_read_sync
_read_sync:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(_cdr+40) # high
	addiu	$16,$16,%lo(_cdr+40) # low
 #APP
 #NO_APP
	sw	$31,20($sp)
	#.set	volatile
	lw	$4,0($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	addu	$16,$16,-40
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	#.set	volatile
	sw	$0,36($16)
	#.set	novolatile
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
	.end	_read_sync
	.rdata
	.align	2
$LC0:
	.ascii	"CdRead: sector error\n\000"
	.text
	.align	2
	.def	_read_int;	.val	_read_int;	.scl	2;	.type	0x21;	.endef
	.globl	_read_int
	.text
	.ent	_read_int
_read_int:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	intr;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	code;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$5
	lui	$2,%hi(_cdr) # high
	addiu	$3,$2,%lo(_cdr) # low
	andi	$4,$4,0x00ff
	li	$2,1			# 0x00000001
	sw	$31,40($sp)
	sw	$16,32($sp)
	#.set	volatile
	sw	$17,52($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,20($3)
	#.set	novolatile
	#nop
	blez	$2,$L11
	#.set	volatile
	lw	$3,16($3)
	#.set	novolatile
	li	$2,512			# 0x00000200
	bne	$3,$2,$L5
	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdGetSector2
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdDataSync
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(_read_data_int) # high
	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	addiu	$4,$4,%lo(_read_data_int) # low
	.set	macro
	.set	reorder

	j	$L7
$L6:
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L7:
	.set	noreorder
	.set	nomacro
	jal	CdPosToInt
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$16,%hi(_cdr+32) # high
	addiu	$16,$16,%lo(_cdr+32) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$3,0($16)
	#.set	novolatile
	#nop
	beq	$2,$3,$L5
	lui	$4,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	jal	puts
	addiu	$4,$4,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$3,$16,-32
	li	$2,-1			# 0xffffffff
	#.set	volatile
	sw	$2,20($3)
	#.set	novolatile
$L5:
	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	lui	$2,%hi(_cdr+8) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(_cdr+8) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$4,0($2)
	#.set	novolatile
	#.set	volatile
	lw	$5,8($2)
	#.set	novolatile
	jal	CdGetSector2
	j	$L11
$L9:
	lui	$16,%hi(_cdr+8) # high
	addiu	$16,$16,%lo(_cdr+8) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$4,0($16)
	#.set	novolatile
	#.set	volatile
	lw	$5,8($16)
	#.set	novolatile
	jal	CdGetSector
	addu	$4,$16,-8
 #APP
 #NO_APP
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,0($16)
	#.set	novolatile
	sll	$2,$2,2
	addu	$3,$3,$2
	#.set	volatile
	sw	$3,8($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($4)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sw	$2,20($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,32($4)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,32($4)
	#.set	novolatile
	j	$L11
$L3:
	#.set	volatile
	sw	$2,20($3)
	#.set	novolatile
$L11:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$3,%hi(_cdr) # high
	addiu	$16,$3,%lo(_cdr) # low
	#.set	volatile
	sw	$2,24($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	bgez	$2,$L12
	.set	noreorder
	.set	nomacro
	jal	_read_issue
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,28($16)
	#.set	novolatile
	#nop
	addu	$3,$3,1200
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L13
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,20($16)
	#.set	novolatile
$L13:
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	beq	$2,$0,$L14
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,28($16)
	#.set	novolatile
	#nop
	addu	$3,$3,1200
	slt	$3,$3,$2
	beq	$3,$0,$L2
$L14:
	#.set	volatile
	lw	$4,44($16)
	#.set	novolatile
	jal	CdReadyCallback
	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L15
	#.set	volatile
	lw	$4,48($16)
	#.set	novolatile
	jal	CdDataCallback
$L15:
	lui	$4,%hi(_read_sync) # high
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	addiu	$4,$4,%lo(_read_sync) # low
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$3,CD_cbread
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L2
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,36($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
$L17:
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	move	$5,$17
	.set	macro
	.set	reorder

$L2:
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
LM2:
	.end	_read_int
	.align	2
	.def	_read_data_int;	.val	_read_data_int;	.scl	2;	.type	0x21;	.endef
	.globl	_read_data_int
	.text
	.ent	_read_data_int
_read_data_int:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(_cdr) # high
	addiu	$16,$16,%lo(_cdr) # low
 #APP
 #NO_APP
	sw	$31,20($sp)
	#.set	volatile
	lw	$2,16($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,8($16)
	#.set	novolatile
	sll	$2,$2,2
	addu	$3,$3,$2
	#.set	volatile
	sw	$3,8($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sw	$2,20($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,32($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,32($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
	#nop
	bne	$2,$0,$L19
	#.set	volatile
	lw	$4,44($16)
	#.set	novolatile
	jal	CdReadyCallback
	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L21
	#.set	volatile
	lw	$4,48($16)
	#.set	novolatile
	jal	CdDataCallback
$L21:
	lui	$4,%hi(_read_sync) # high
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	addiu	$4,$4,%lo(_read_sync) # low
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$3,CD_cbread
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L19
	sw	$2,36($16)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$5,52($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

$L19:
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
LM3:
	.end	_read_data_int
	.rdata
	.align	2
$LC1:
	.ascii	"CdRead: Shell open...\n\000"
	.align	2
$LC2:
	.ascii	"CdRead: retry...\n\000"
	.text
	.align	2
	.def	_read_issue;	.val	_read_issue;	.scl	2;	.type	0x24;	.endef
	.globl	_read_issue
	.text
	.ent	_read_issue
_read_issue:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	retry;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	move	$4,$0
	sw	$31,36($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L24
	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	move	$4,$0
	.set	macro
	.set	reorder

$L24:
	jal	CdStatus
	andi	$2,$2,0x0010
	beq	$2,$0,$L25
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	andi	$2,$2,0x003f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L35
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	jal	puts
	addiu	$4,$4,%lo($LC1) # low
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
$L35:
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$3,%hi(_cdr) # high
	addiu	$3,$3,%lo(_cdr) # low
	#.set	volatile
	sw	$2,28($3)
	#.set	novolatile
	li	$2,-1			# 0xffffffff
	#.set	volatile
	sw	$2,20($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($3)
	#.set	novolatile
	j	$L34
$L25:
	beq	$18,$0,$L27
 #APP
 #NO_APP
	lui	$4,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	jal	puts
	addiu	$4,$4,%lo($LC2) # low
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$5
	.set	macro
	.set	reorder

	jal	CdLastPos
	li	$4,2			# 0x00000002
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$0
	.set	macro
	.set	reorder

	beq	$2,$0,$L29
$L27:
	jal	CdFlush
 #APP
 #NO_APP
	lui	$17,%hi(_cdr+12) # high
	addiu	$17,$17,%lo(_cdr+12) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$16,0($17)
	#.set	novolatile
	#nop
	sb	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CdMode
	andi	$16,$16,0x00ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L36
	li	$4,14			# 0x0000000e
	.set	macro
	.set	reorder

	beq	$18,$0,$L30
$L36:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L30
	.def	error;	.val	$L29;	.scl	6;	.type	0x0;	.endef
$L29:
 #APP
 #NO_APP
	lui	$2,%hi(_cdr) # high
	addiu	$2,$2,%lo(_cdr) # low
	li	$3,-1			# 0xffffffff
	#.set	volatile
	sw	$3,20($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($2)
	#.set	novolatile
	j	$L34
$L30:
 #APP
 #NO_APP
	jal	CdLastPos
	.set	noreorder
	.set	nomacro
	jal	CdPosToInt
	move	$4,$2
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lui	$4,%hi(_read_int) # high
	addiu	$4,$4,%lo(_read_int) # low
	lui	$16,%hi(_cdr) # high
	addiu	$16,$16,%lo(_cdr) # low
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	sw	$2,32($16)
	.set	macro
	.set	reorder

	lw	$2,CD_read_dma_mode
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	lui	$4,%hi(_read_data_int) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	addiu	$4,$4,%lo(_read_data_int) # low
	.set	macro
	.set	reorder

$L33:
	li	$4,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,4($16)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,8($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($16)
	#.set	novolatile
	li	$4,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	VSync
	sw	$2,20($16)
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,24($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($16)
	#.set	novolatile
$L34:
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
LM4:
	.end	_read_issue
	.align	2
	.def	CdRead;	.val	CdRead;	.scl	2;	.type	0x24;	.endef
	.globl	CdRead
	.text
	.ent	CdRead
CdRead:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	sectors;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	buf;	.val	19;	.scl	17;	.type	0x1f;	.endef
	.def	mode;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$16,16($sp)
	lui	$16,%hi(_cdr+36) # high
	#.set	volatile
	lw	$2,%lo(_cdr+36)($16)
	#.set	novolatile
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$17,20($sp)
	addiu	$17,$16,%lo(_cdr+36) # low
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	sw	$31,36($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,%lo(_cdr+36)($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L38
	move	$16,$2
	.set	macro
	.set	reorder

$L41:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	subu	$2,$2,$16
	sltu	$2,$2,121
	beq	$2,$0,$L51
	#.set	volatile
	lw	$2,0($17)
	#.set	novolatile
	#nop
	bne	$2,$0,$L41
$L38:
	lui	$4,%hi(_cdr) # high
$L52:
	addiu	$4,$4,%lo(_cdr) # low
 #APP
 #NO_APP
	#.set	volatile
	sw	$18,12($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,12($4)
	#.set	novolatile
	#nop
	andi	$3,$2,0x0030
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L45
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L46
	li	$3,582			# 0x00000246
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L47
	lui	$2,%hi(_cdr) # high
	.set	macro
	.set	reorder

$L51:
	lui	$16,%hi(_cdr+40) # high
	addiu	$16,$16,%lo(_cdr+40) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$4,0($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	CdSyncCallback
	addu	$16,$16,-40
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$0,36($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L52
	lui	$4,%hi(_cdr) # high
	.set	macro
	.set	reorder

$L45:
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	j	$L44
	sw	$2,16($4)
	.set	macro
	.set	reorder

$L46:
	li	$2,585			# 0x00000249
	.set	noreorder
	.set	nomacro
	j	$L44
	sw	$2,16($4)
	.set	macro
	.set	reorder

$L47:
	addiu	$2,$2,%lo(_cdr) # low
 #APP
 #NO_APP
	#.set	volatile
	sw	$3,16($2)
	#.set	novolatile
$L44:
	lui	$16,%hi(_cdr) # high
	addiu	$16,$16,%lo(_cdr) # low
 #APP
 #NO_APP
	#.set	volatile
	lw	$2,12($16)
	#.set	novolatile
	move	$4,$0
	ori	$2,$2,0x0020
	#.set	volatile
	sw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	sw	$19,4($16)
	#.set	novolatile
	#.set	volatile
	sw	$20,0($16)
	#.set	novolatile
	jal	CdSyncCallback
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	sw	$2,40($16)
	.set	macro
	.set	reorder

	lw	$3,CD_read_dma_mode
	#.set	volatile
	sw	$2,44($16)
	#.set	novolatile
	andi	$3,$3,0x0001
	beq	$3,$0,$L49
	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	move	$4,$0
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,48($16)
	#.set	novolatile
$L49:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,28($16)
	#.set	novolatile
	jal	CdStatus
	andi	$2,$2,0x00e0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L50
	li	$4,9			# 0x00000009
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

$L50:
	.set	noreorder
	.set	nomacro
	jal	_read_issue
	move	$4,$0
	.set	macro
	.set	reorder

	slt	$2,$0,$2
 #APP
 #NO_APP
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
LM5:
	.end	CdRead
	.align	2
	.def	CdReadSync;	.val	CdReadSync;	.scl	2;	.type	0x24;	.endef
	.globl	CdReadSync
	.text
	.ent	CdReadSync
CdReadSync:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	mode;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	result;	.val	20;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$17,20($sp)
	lui	$17,%hi(_cdr+28) # high
	addiu	$17,$17,%lo(_cdr+28) # low
 #APP
 #NO_APP
	sw	$18,24($sp)
	addu	$18,$17,8
	sw	$31,36($sp)
	sw	$16,16($sp)
$L54:
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,0($17)
	#.set	novolatile
	#nop
	addu	$3,$3,1200
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L63
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,-8($17)
	#.set	novolatile
	#nop
	bltz	$2,$L60
	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,-4($17)
	#.set	novolatile
	#nop
	addu	$3,$3,60
	slt	$3,$3,$2
	beq	$3,$0,$L62
	.def	reissue;	.val	$L60;	.scl	6;	.type	0x0;	.endef
$L60:
	.set	noreorder
	.set	nomacro
	jal	_read_issue
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$16,-28($17)
	#.set	novolatile
	j	$L63
	.def	still;	.val	$L62;	.scl	6;	.type	0x0;	.endef
$L62:
	#.set	volatile
	lw	$16,-8($17)
	#.set	novolatile
	.def	check;	.val	$L63;	.scl	6;	.type	0x0;	.endef
$L63:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L70
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,0($18)
	#.set	novolatile
	#nop
	beq	$2,$0,$L65
	beq	$16,$0,$L54
$L65:
	.set	noreorder
	.set	nomacro
	bgtz	$16,$L54
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L70:
	.set	noreorder
	.set	nomacro
	jal	CdReady
	move	$5,$20
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,0($18)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L71
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L71
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$2,$16
$L71:
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
LM6:
	.end	CdReadSync

	.extern	CD_cbread, 4
	.extern	CD_read_dma_mode, 4
	.extern	_cdr, 56
