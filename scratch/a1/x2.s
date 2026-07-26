	.file	1 "C:\\Temp\\nfs4-wt33-a1\\recon\\eaclib\\psx\\eacpsxz\\cdfs.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CD_Open
	.align	2
	.globl	CD_Close
	.align	2
	.globl	CD_Stopread
	.align	2
	.globl	CD_Getinfo
	.align	2
	.globl	CD_Read
	.align	2
	.globl	readsectorB
	.align	2
	.globl	loaddirinfo
	.align	2
	.globl	dircompare
	.align	2
	.globl	CD_Restore
	.align	2
	.globl	CD_Init
	.align	2
	.globl	CD_Restart
	.align	2
	.globl	CD_systaskfunc
	.align	2
	.globl	CD_timerfunc
	.align	2
	.globl	CdReadyHandler

	.comm	CD_ctx,2108

	.text
	.def	CD_ctx_t;	.scl	10;	.type	0x8;	.size	2108;	.endef
	.def	info;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	maxOpen;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	dirEntryCount;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	cachedSector;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	lastSector;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	curSector;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	timeout;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	ringIdx;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	curLen;	.val	32;	.scl	8;	.type	0x4;	.endef
	.def	remLen;	.val	36;	.scl	8;	.type	0x4;	.endef
	.def	curOff;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	curDst;	.val	44;	.scl	8;	.type	0x11;	.endef
	.def	completionCallback;	.val	48;	.scl	8;	.type	0x91;	.endef
	.def	handleTable;	.val	52;	.scl	8;	.type	0x51;	.endef
	.def	dirEntryArray;	.val	56;	.scl	8;	.type	0x11;	.endef
	.def	sectorCache;	.val	60;	.scl	8;	.dim	2048;	.size	2048;	.type	0x3c;	.endef
	.def	.eos;	.val	2108;	.scl	102;	.tag	CD_ctx_t;	.size	2108;	.endef
	.def	CD_ctx_t;	.scl	13;	.tag	CD_ctx_t;	.size	2108;	.type	0x8;	.endef
	.def	CdlLOC;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	minute;	.val	0;	.scl	8;	.type	0xc;	.endef
	.def	second;	.val	1;	.scl	8;	.type	0xc;	.endef
	.def	sector;	.val	2;	.scl	8;	.type	0xc;	.endef
	.def	track;	.val	3;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	CdlLOC;	.size	4;	.endef
	.def	CdlLOC;	.scl	13;	.tag	CdlLOC;	.size	4;	.type	0x8;	.endef
	.def	rd_le32_unaligned;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	v;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	rd_le32_unaligned;	.size	4;	.endef
	.def	CD_Open;	.val	CD_Open;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Open
CD_Open:
	.frame	$sp,64,$31		# vars= 16, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	16;	.scl	17;	.type	0x12;	.endef
	.def	flags;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	outp;	.val	19;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,64
	sw	$16,40($sp)
	move	$16,$4
	sw	$19,52($sp)
	move	$19,$6
	sw	$18,48($sp)
	addu	$18,$sp,24
	lui	$2,%hi(CD_ctx) # high
	addiu	$2,$2,%lo(CD_ctx) # low
	sw	$31,56($sp)
	sw	$17,44($sp)
	lw	$3,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L10
	move	$17,$0
	.set	macro
	.set	reorder

	move	$4,$3
	lw	$3,52($2)
$L4:
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L10
	addu	$17,$17,1
	slt	$2,$17,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L10:
	lbu	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	toupper
	addu	$16,$16,1
	.set	macro
	.set	reorder

	sb	$2,0($18)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	addu	$18,$18,1
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	lui	$2,%hi(dircompare) # high
	addiu	$2,$2,%lo(dircompare) # low
	lui	$16,%hi(CD_ctx) # high
	addiu	$16,$16,%lo(CD_ctx) # low
	sw	$2,16($sp)
	lw	$5,56($16)
	lw	$6,8($16)
	.set	noreorder
	.set	nomacro
	jal	bsearch
	li	$7,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$3,52($16)
	sll	$4,$17,2
	addu	$3,$4,$3
	sw	$2,0($3)
	lw	$2,52($16)
	#nop
	addu	$4,$4,$2
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	addu	$2,$17,1
	.set	macro
	.set	reorder

	sw	$2,0($19)
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L14:
	sw	$0,0($19)
	move	$2,$0
$L15:
	lw	$31,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	CD_Open
	.def	CD_Close;	.val	CD_Close;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Close
CD_Close:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(CD_ctx+52) # high
	lw	$2,%lo(CD_ctx+52)($2)
	sll	$4,$4,2
	addu	$4,$4,$2
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,-4($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	CD_Close
	.def	CD_Stopread;	.val	CD_Stopread;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Stopread
CD_Stopread:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	dev;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$3,%hi(CD_ctx) # high
	#.set	volatile
	lw	$2,%lo(CD_ctx)($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0004
	#.set	volatile
	sw	$2,%lo(CD_ctx)($3)
	#.set	novolatile
	j	$31

	.loc	1 0
LM3:
	.end	CD_Stopread
	.def	CD_Getinfo;	.val	CD_Getinfo;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Getinfo
CD_Getinfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	namebuf;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	sizeout;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$6
	lui	$2,%hi(CD_ctx+52) # high
	sll	$4,$4,2
	lw	$2,%lo(CD_ctx+52)($2)
	addu	$4,$4,-4
	sw	$31,24($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L19
	addu	$16,$2,$4
	.set	macro
	.set	reorder

	move	$4,$5
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	strncpy
	li	$6,12			# 0x0000000c
	.set	macro
	.set	reorder

$L19:
	beq	$17,$0,$L20
	lw	$2,0($16)
	#nop
	lw	$2,16($2)
	#nop
	sw	$2,0($17)
$L20:
	lw	$2,0($16)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	CD_Getinfo
	.def	.0fake;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	curLen;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	remLen;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	curOff;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	curDst;	.val	12;	.scl	8;	.type	0x11;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	.0fake;	.size	16;	.endef
	.def	CD_Read;	.val	CD_Read;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Read
CD_Read:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	dev;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	offset;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	19;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$7
	lui	$7,%hi(CD_ctx) # high
	addiu	$3,$7,%lo(CD_ctx) # low
	sll	$4,$4,2
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$2,52($3)
	addu	$4,$4,-4
	addu	$4,$2,$4
	#.set	volatile
	lw	$2,%lo(CD_ctx)($7)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	addu	$16,$3,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L36
	move	$2,$0
	.set	macro
	.set	reorder

$L22:
	lw	$2,0($4)
	#nop
	lw	$2,16($2)
	#nop
	subu	$3,$2,$6
	slt	$2,$3,$19
	beq	$2,$0,$L23
	move	$19,$3
$L23:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L24
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$2,$6,2047
$L24:
	sra	$2,$2,11
	sll	$2,$2,11
	subu	$2,$6,$2
	sw	$2,8($16)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	sw	$5,12($16)
	.set	macro
	.set	reorder

	slt	$2,$19,2048
	beq	$2,$0,$L25
$L26:
	#.set	volatile
	lw	$2,%lo(CD_ctx)($7)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0008
	#.set	volatile
	sw	$2,%lo(CD_ctx)($7)
	#.set	novolatile
$L25:
	lw	$3,8($16)
	#nop
	addu	$2,$3,$19
	slt	$2,$2,2049
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L27
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L28
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L27:
	move	$2,$19
$L28:
	sw	$2,0($16)
	subu	$2,$19,$2
	lui	$18,%hi(CD_ctx) # high
	sw	$2,4($16)
	lw	$3,0($4)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L29
	addiu	$17,$18,%lo(CD_ctx) # low
	.set	macro
	.set	reorder

	addu	$6,$6,2047
$L29:
	lui	$2,%hi(CD_timerfunc) # high
	addiu	$20,$2,%lo(CD_timerfunc) # low
	move	$4,$20
	lw	$3,12($3)
	sra	$2,$6,11
	sw	$0,28($17)
	addu	$3,$3,$2
	sw	$3,20($17)
	lui	$3,%hi(timerhz) # high
	#.set	volatile
	lw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	lw	$3,%lo(timerhz)($3)
	ori	$2,$2,0x0002
	#.set	volatile
	sw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	addtimer
	sw	$2,24($17)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,12($17)
	#.set	novolatile
	lw	$2,20($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L36
	move	$2,$19
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L30
	lui	$2,%hi(g_currentthread) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(g_currentthread)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L36
	move	$2,$19
	.set	macro
	.set	reorder

	addu	$2,$17,60
	lw	$5,12($16)
	lw	$4,8($16)
	lw	$6,0($16)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L31
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$2,12($16)
	lw	$3,0($16)
	lw	$4,4($16)
	sw	$0,8($16)
	addu	$2,$2,$3
	sw	$2,12($16)
	slt	$2,$4,2048
	beq	$2,$0,$L32
	#.set	volatile
	lw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	sw	$4,0($16)
	.set	noreorder
	.set	nomacro
	j	$L37
	ori	$2,$2,0x0008
	.set	macro
	.set	reorder

$L32:
	li	$2,2048			# 0x00000800
	sw	$2,0($16)
	#.set	volatile
	lw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	li	$3,-9			# 0xfffffff7
	and	$2,$2,$3
$L37:
	#.set	volatile
	sw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	lui	$4,%hi(CD_ctx) # high
	addiu	$4,$4,%lo(CD_ctx) # low
	lw	$2,4($16)
	lw	$5,0($16)
	lw	$3,20($4)
	subu	$2,$2,$5
	addu	$3,$3,1
	sw	$2,4($16)
	.set	noreorder
	.set	nomacro
	j	$L30
	sw	$3,20($4)
	.set	macro
	.set	reorder

$L31:
	sw	$0,24($17)
	#.set	volatile
	lw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	#.set	volatile
	sw	$2,%lo(CD_ctx)($18)
	#.set	novolatile
	jal	deltimer
	lw	$2,48($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	move	$2,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	savegp
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$2,48($17)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	jal	restoregp
$L30:
	move	$2,$19
$L36:
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	CD_Read
	.def	readsectorB;	.val	readsectorB;	.scl	2;	.type	0x6c;	.endef
	.text
	.ent	readsectorB
readsectorB:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$5,%hi(CD_ctx) # high
	addiu	$4,$5,%lo(CD_ctx) # low
	li	$2,2048			# 0x00000800
	sw	$2,32($4)
	li	$2,10			# 0x0000000a
	sw	$0,28($4)
	#.set	volatile
	sw	$2,%lo(CD_ctx)($5)
	#.set	novolatile
	#.set	volatile
	lw	$2,%lo(CD_ctx)($5)
	#.set	novolatile
	addu	$3,$4,60
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	sw	$3,44($4)
	.set	macro
	.set	reorder

	move	$4,$5
$L40:
	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0003
	bne	$2,$0,$L40
$L39:
	lui	$2,%hi(CD_ctx+60) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo(CD_ctx+60) # low
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	readsectorB
	.def	loaddirinfo;	.val	loaddirinfo;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	loaddirinfo
loaddirinfo:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	startSector;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	numSectors;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	maxEntries;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$5
	lui	$2,%hi(CD_ctx) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(CD_ctx) # low
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	lw	$20,20($17)
	move	$19,$6
	.set	noreorder
	.set	nomacro
	jal	readsectorB
	sw	$4,20($17)
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	addu	$18,$18,-1
	.set	noreorder
	.set	nomacro
	j	$L45
	addu	$16,$3,$2
	.set	macro
	.set	reorder

	.def	next_entry;	.val	$L46;	.scl	6;	.type	0x0;	.endef
$L46:
	lbu	$2,0($16)
	#nop
	bne	$2,$0,$L47
	beq	$18,$0,$L49
	lw	$2,20($17)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	readsectorB
	sw	$2,20($17)
	.set	macro
	.set	reorder

	move	$16,$2
	addu	$18,$18,-1
$L47:
	lbu	$2,25($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L50
	move	$6,$19
	.set	macro
	.set	reorder

	ulw	$5,10($16)
	ulw	$4,2($16)
	.set	noreorder
	.set	nomacro
	jal	loaddirinfo
	srl	$5,$5,11
	.set	macro
	.set	reorder

	jal	readsectorB
	j	$L45
$L50:
	addu	$5,$16,33
	lw	$2,8($17)
	lbu	$6,32($16)
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,2
	lw	$2,56($17)
	addu	$6,$6,-2
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	lw	$3,8($17)
	lw	$4,56($17)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	lbu	$3,32($16)
	addu	$2,$2,$4
	addu	$3,$3,$2
	sb	$0,-2($3)
	lw	$3,8($17)
	ulw	$4,2($16)
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,56($17)
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$4,12($2)
	lw	$3,8($17)
	ulw	$4,10($16)
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,56($17)
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$4,16($2)
	lw	$2,8($17)
	#nop
	addu	$2,$2,1
	sw	$2,8($17)
	.def	test_entry_count;	.val	$L45;	.scl	6;	.type	0x0;	.endef
$L45:
	lbu	$3,0($16)
	lw	$2,8($17)
	#nop
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L46
	addu	$16,$16,$3
	.set	macro
	.set	reorder

	.def	done;	.val	$L49;	.scl	6;	.type	0x0;	.endef
$L49:
	lw	$31,36($sp)
	lui	$2,%hi(CD_ctx+20) # high
	sw	$20,%lo(CD_ctx+20)($2)
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
LM7:
	.end	loaddirinfo
	.def	dircompare;	.val	dircompare;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	dircompare
dircompare:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0x11;	.endef
	.def	b;	.val	5;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	strncmp
	li	$6,12			# 0x0000000c
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
LM8:
	.end	dircompare
	.def	CD_Restore;	.val	CD_Restore;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	CD_Restore
CD_Restore:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CdReset
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_ctx) # high
	addiu	$4,$4,%lo(CD_ctx) # low
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,2108			# 0x0000083c
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
LM9:
	.end	CD_Restore
	.def	CD_Init;	.val	CD_Init;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Init
CD_Init:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	maxOpen;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	numEntries;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	buffer;	.val	19;	.scl	17;	.type	0x11;	.endef
	.def	callback;	.val	20;	.scl	17;	.type	0x91;	.endef
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$19,36($sp)
	move	$19,$6
	lui	$2,%hi(CD_ctx) # high
	sw	$16,24($sp)
	addiu	$16,$2,%lo(CD_ctx) # low
	sw	$31,44($sp)
	sw	$20,40($sp)
	lw	$2,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L62
	move	$20,$7
	.set	macro
	.set	reorder

	jal	CdInit
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L65
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdSetDebug
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdGetToc
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L62
	move	$4,$19
	.set	macro
	.set	reorder

	sll	$2,$18,2
	sll	$5,$17,2
	addu	$5,$5,$17
	sll	$5,$5,2
	addu	$5,$2,$5
	addu	$2,$4,$2
	sw	$18,4($16)
	sw	$4,52($16)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$2,56($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CD_Restart
	li	$4,16			# 0x00000010
	.set	macro
	.set	reorder

	jal	readsectorB
	move	$6,$17
	ulw	$5,166($2)
	ulw	$4,158($2)
	.set	noreorder
	.set	nomacro
	jal	loaddirinfo
	srl	$5,$5,11
	.set	macro
	.set	reorder

	li	$6,20			# 0x00000014
	lui	$7,%hi(dircompare) # high
	lw	$4,56($16)
	lw	$5,8($16)
	.set	noreorder
	.set	nomacro
	jal	qsort
	addiu	$7,$7,%lo(dircompare) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_Restore) # high
	addiu	$4,$4,%lo(CD_Restore) # low
	.set	noreorder
	.set	nomacro
	jal	addexit
	sw	$20,48($16)
	.set	macro
	.set	reorder

	lw	$2,8($16)
	j	$L65
$L62:
	move	$2,$0
$L65:
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM10:
	.end	CD_Init
	.def	CD_Restart;	.val	CD_Restart;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_Restart
CD_Restart:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	startSector;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	lui	$2,%hi(CD_ctx) # high
	#.set	volatile
	lw	$2,%lo(CD_ctx)($2)
	#.set	novolatile
	#nop
	li	$2,160			# 0x000000a0
	sw	$31,40($sp)
	sw	$16,32($sp)
	sb	$2,24($sp)
	li	$4,14			# 0x0000000e
$L72:
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L72
	li	$4,14			# 0x0000000e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	jal	CdFlush
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	CdSync
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L73
	lui	$4,%hi(CdReadyHandler) # high
	.set	macro
	.set	reorder

	li	$17,16			# 0x00000010
$L73:
	lui	$16,%hi(CD_ctx) # high
	addiu	$16,$16,%lo(CD_ctx) # low
	sw	$17,20($16)
	#.set	volatile
	sw	$17,12($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	addiu	$4,$4,%lo(CdReadyHandler) # low
	.set	macro
	.set	reorder

	lw	$4,20($16)
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	li	$4,27			# 0x0000001b
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$0
	.set	macro
	.set	reorder

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
LM11:
	.end	CD_Restart
	.def	CD_systaskfunc;	.val	CD_systaskfunc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	CD_systaskfunc
CD_systaskfunc:
	.frame	$sp,56,$31		# vars= 24, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,40($sp)
	move	$16,$0
	li	$4,1			# 0x00000001
	sw	$31,48($sp)
	.set	noreorder
	.set	nomacro
	jal	CdDiskReady
	sw	$17,44($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L78
	slt	$2,$3,6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L75
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$3,$2,$L75
	jal	CdGetDiskType
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L75
	sltu	$16,$2,2
	.set	macro
	.set	reorder

$L78:
	lui	$2,%hi(CD_ctx) # high
	addiu	$4,$2,%lo(CD_ctx) # low
	lw	$2,24($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L79
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lui	$2,%hi(timerhz) # high
	lw	$3,%lo(timerhz)($2)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L75
	sw	$2,24($4)
	.set	macro
	.set	reorder

$L79:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L75
	sw	$2,24($4)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L75:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L85
	lui	$4,%hi(CD_systaskfunc) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	delsystemtask
	addiu	$4,$4,%lo(CD_systaskfunc) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdReset
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,14			# 0x0000000e
	addu	$5,$sp,32
	addu	$6,$sp,16
	li	$2,160			# 0x000000a0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	sb	$2,32($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	jal	CdFlush
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	CdSync
	move	$5,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_ctx) # high
	addiu	$17,$2,%lo(CD_ctx) # low
	addu	$16,$sp,24
	#.set	volatile
	lw	$4,12($17)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,27			# 0x0000001b
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi(CdReadyHandler) # high
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	addiu	$4,$4,%lo(CdReadyHandler) # low
	.set	macro
	.set	reorder

	lw	$2,36($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L85
	lui	$2,%hi(timerhz) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_timerfunc) # high
	lw	$3,%lo(timerhz)($2)
	addiu	$4,$4,%lo(CD_timerfunc) # low
	sw	$0,28($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	addtimer
	sw	$2,24($17)
	.set	macro
	.set	reorder

$L85:
	lw	$31,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM12:
	.end	CD_systaskfunc
	.def	CD_timerfunc;	.val	CD_timerfunc;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	CD_timerfunc
CD_timerfunc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(CD_ctx) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(CD_ctx) # low
	sw	$31,20($sp)
	lw	$2,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L88
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L88
	sw	$2,24($16)
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_systaskfunc) # high
	addiu	$4,$4,%lo(CD_systaskfunc) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	move	$6,$5
	.set	macro
	.set	reorder

	sw	$0,24($16)
	lui	$4,%hi(CD_timerfunc) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(CD_timerfunc) # low
	.set	macro
	.set	reorder

$L88:
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
LM13:
	.end	CD_timerfunc
	.def	.1fake;	.scl	10;	.type	0x8;	.size	312;	.endef
	.def	hdr;	.val	0;	.scl	8;	.tag	CdlLOC;	.dim	3;	.size	12;	.type	0x38;	.endef
	.def	sub;	.val	12;	.scl	8;	.dim	284;	.size	284;	.type	0x3c;	.endef
	.def	pos;	.val	296;	.scl	8;	.dim	8;	.size	8;	.type	0x3c;	.endef
	.def	gpctx;	.val	304;	.scl	8;	.dim	2;	.size	8;	.type	0x34;	.endef
	.def	.eos;	.val	312;	.scl	102;	.tag	.1fake;	.size	312;	.endef
	.def	.2fake;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	curLen;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	remLen;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	curOff;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	curDst;	.val	12;	.scl	8;	.type	0x11;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	.2fake;	.size	16;	.endef
	.def	CdReadyHandler;	.val	CdReadyHandler;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	CdReadyHandler
CdReadyHandler:
	.frame	$sp,352,$31		# vars= 312, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	intr;	.val	17;	.scl	17;	.type	0xc;	.endef
	.def	result;	.val	19;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,352
	sw	$19,340($sp)
	move	$19,$5
	sw	$17,332($sp)
	move	$17,$4
	move	$4,$0
	lui	$2,%hi(CD_ctx+32) # high
	sw	$16,328($sp)
	addiu	$16,$2,%lo(CD_ctx+32) # low
	sw	$31,344($sp)
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	sw	$18,336($sp)
	.set	macro
	.set	reorder

	lbu	$2,0($19)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L91
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_timerfunc) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(CD_timerfunc) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(CD_systaskfunc) # high
	addiu	$4,$4,%lo(CD_systaskfunc) # low
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	move	$6,$18
	.set	macro
	.set	reorder

	j	$L90
$L91:
	andi	$4,$17,0x00ff
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L93
	slt	$2,$4,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L119
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L96
	lui	$4,%hi(CD_ctx) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L130
	addiu	$17,$4,%lo(CD_ctx) # low
	.set	macro
	.set	reorder

$L119:
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L114
	lui	$4,%hi(CD_ctx) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L130
	addiu	$17,$4,%lo(CD_ctx) # low
	.set	macro
	.set	reorder

$L93:
	addu	$4,$16,-32
	lw	$3,28($4)
	li	$2,-1			# 0xffffffff
	bne	$3,$2,$L95
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L124
	sw	$0,28($4)
	.set	macro
	.set	reorder

$L96:
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L97
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L98
	li	$18,1			# 0x00000001
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	li	$3,-5			# 0xfffffffb
	and	$2,$2,$3
	#.set	volatile
	sw	$2,-32($16)
	#.set	novolatile
	j	$L111
$L98:
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L100
	addu	$17,$16,28
	.set	macro
	.set	reorder

	lw	$17,12($16)
	.set	noreorder
	.set	nomacro
	j	$L128
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L100:
	addu	$4,$sp,16
$L128:
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,512			# 0x00000200
	.set	macro
	.set	reorder

	addu	$4,$sp,28
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,70			# 0x00000046
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdDataSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdPosToInt
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$17,%hi(CD_ctx) # high
	addiu	$4,$17,%lo(CD_ctx) # low
	#.set	volatile
	lw	$3,12($4)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L102
	lui	$2,%hi(timerhz) # high
	.set	macro
	.set	reorder

	lw	$2,28($4)
	#.set	volatile
	lw	$3,12($4)
	#.set	novolatile
	addu	$2,$2,1
	sw	$2,28($4)
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L103
	sw	$3,20($4)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0002
	#.set	volatile
	sw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	j	$L111
$L103:
	li	$2,-1			# 0xffffffff
	sw	$2,28($4)
	li	$4,9			# 0x00000009
	move	$5,$0
	.set	noreorder
	.set	nomacro
	j	$L125
	move	$6,$5
	.set	macro
	.set	reorder

$L102:
	lw	$3,%lo(timerhz)($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	#.set	volatile
	lw	$3,%lo(CD_ctx)($17)
	#.set	novolatile
	sll	$2,$2,1
	andi	$3,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L106
	sw	$2,24($4)
	.set	macro
	.set	reorder

	li	$3,-9			# 0xfffffff7
	lw	$5,12($16)
	#.set	volatile
	lw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	lw	$6,0($16)
	and	$2,$2,$3
	addu	$3,$4,60
	#.set	volatile
	sw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	lw	$4,8($16)
	#.set	volatile
	lw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	addu	$4,$4,$3
	ori	$2,$2,0x0010
	#.set	volatile
	sw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	jal	blockmove
	sw	$0,8($16)
$L106:
	lw	$2,4($16)
	#nop
	blez	$2,$L107
	lw	$2,12($16)
	lw	$3,0($16)
	lw	$4,4($16)
	addu	$2,$2,$3
	sw	$2,12($16)
	slt	$2,$4,2048
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L108
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	sw	$4,0($16)
	ori	$2,$2,0x0008
	#.set	volatile
	sw	$2,%lo(CD_ctx)($17)
	#.set	novolatile
	j	$L109
$L108:
	sw	$2,0($16)
$L109:
	lw	$2,4($16)
	lw	$3,0($16)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L111
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L107:
	.set	noreorder
	.set	nomacro
	j	$L111
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

$L97:
	jal	CdFlush
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	CdSync
	move	$5,$4
	.set	macro
	.set	reorder

$L111:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L95
	lui	$4,%hi(CD_ctx) # high
	.set	macro
	.set	reorder

	li	$3,-2			# 0xfffffffe
	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	addiu	$17,$4,%lo(CD_ctx) # low
	and	$2,$2,$3
	#.set	volatile
	sw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	lui	$4,%hi(CD_timerfunc) # high
	#.set	volatile
	lw	$2,12($17)
	#.set	novolatile
	addiu	$4,$4,%lo(CD_timerfunc) # low
	sw	$0,24($17)
	.set	noreorder
	.set	nomacro
	jal	deltimer
	sw	$2,16($17)
	.set	macro
	.set	reorder

	lw	$2,48($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	addu	$4,$sp,320
	.set	macro
	.set	reorder

	lui	$16,%hi(g_currentthread) # high
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	savegp
	sw	$2,%lo(g_currentthread)($16)
	.set	macro
	.set	reorder

	lw	$2,48($17)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,320($sp)
	jal	restoregp
	.set	noreorder
	.set	nomacro
	j	$L95
	sw	$0,%lo(g_currentthread)($16)
	.set	macro
	.set	reorder

$L114:
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	addu	$17,$16,-32
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControl
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lw	$2,28($17)
	#.set	volatile
	lw	$3,12($17)
	#.set	novolatile
	addu	$2,$2,1
	sw	$2,28($17)
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	sw	$3,20($17)
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sw	$2,28($17)
	li	$4,9			# 0x00000009
	move	$5,$0
	.set	noreorder
	.set	nomacro
	j	$L125
	move	$6,$5
	.set	macro
	.set	reorder

$L116:
	#.set	volatile
	lw	$2,-32($16)
	#.set	novolatile
$L124:
	ori	$2,$2,0x0002
	#.set	volatile
	sw	$2,-32($16)
	#.set	novolatile
	.def	advance;	.val	$L95;	.scl	6;	.type	0x0;	.endef
$L95:
	lui	$4,%hi(CD_ctx) # high
	addiu	$17,$4,%lo(CD_ctx) # low
$L130:
	#.set	volatile
	lw	$2,12($17)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,12($17)
	#.set	novolatile
	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L129
	lui	$3,%hi(CD_ctx) # high
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	li	$3,-3			# 0xfffffffd
	and	$2,$2,$3
	#.set	volatile
	sw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	li	$3,-17			# 0xffffffef
	and	$2,$2,$3
	#.set	volatile
	sw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0001
	#.set	volatile
	sw	$2,%lo(CD_ctx)($4)
	#.set	novolatile
	#.set	volatile
	lw	$3,12($17)
	#.set	novolatile
	lw	$2,20($17)
	#nop
	beq	$3,$2,$L120
	jal	CdFlush
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	CdSync
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$16,$sp,312
	lw	$4,20($17)
	move	$5,$16
	#.set	volatile
	sw	$4,12($17)
	#.set	novolatile
	jal	CdIntToPos
	li	$4,27			# 0x0000001b
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$19
	.set	macro
	.set	reorder

$L120:
	lui	$3,%hi(CD_ctx) # high
$L129:
	#.set	volatile
	lw	$2,%lo(CD_ctx)($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L126
	addiu	$3,$3,%lo(CD_ctx) # low
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,12($3)
	#.set	novolatile
	lw	$4,16($3)
	#nop
	subu	$2,$2,$4
	slt	$2,$2,21
	bne	$2,$0,$L126
	#.set	volatile
	sw	$4,12($3)
	#.set	novolatile
	addu	$16,$sp,312
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,27			# 0x0000001b
	move	$5,$16
	move	$6,$19
$L125:
	jal	CdControl
$L126:
	lui	$4,%hi(CdReadyHandler) # high
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	addiu	$4,$4,%lo(CdReadyHandler) # low
	.set	macro
	.set	reorder

$L90:
	lw	$31,344($sp)
	lw	$19,340($sp)
	lw	$18,336($sp)
	lw	$17,332($sp)
	lw	$16,328($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,352
	.set	macro
	.set	reorder


	.loc	1 0
LM14:
	.end	CdReadyHandler
	.def	CD_ctx;	.val	CD_ctx;	.scl	2;	.tag	CD_ctx_t;	.size	2108;	.type	0x8;	.endef
