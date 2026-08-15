	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\memstd.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.sdata
	.text
	.sdata
	.align	1
MAGIC_USED:
	.half	16973
	.text
	.sdata
	.align	1
MAGIC_FREE:
	.half	16966
	.text
	.sdata
	.align	1
MAGIC_HEAD:
	.half	16979
	.text
	.align	2
	.globl	FREE_find
	.align	2
	.globl	FREE_findlargest
	.align	2
	.globl	FREE_add
	.align	2
	.globl	FREE_remove
	.align	2
	.globl	initmemblock
	.align	2
	.globl	MEM_infosize
	.align	2
	.globl	MEM_tailsize
	.rdata
	.align	2
$LC0:
	.ascii	"%s LOW\000"
	.align	2
$LC1:
	.ascii	"%s HIGH\000"
	.text
	.align	2
	.globl	creatememclass
	.align	2
	.globl	largestunused
	.align	2
	.globl	getblocksize
	.align	2
	.globl	getblockname
	.align	2
	.globl	reservememadr
	.align	2
	.globl	purgememadr

	.comm	gMemClassTable,64

	.extern	mb_default, 4

	.text
	.def	MemBlock;	.scl	10;	.type	0x8;	.size	24;	.endef
	.def	magic;	.val	0;	.scl	8;	.type	0xd;	.endef
	.def	flags;	.val	2;	.scl	8;	.type	0xd;	.endef
	.def	size;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	physnext;	.val	8;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	physprev;	.val	12;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	freenext;	.val	16;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	freeprev;	.val	20;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	.eos;	.val	24;	.scl	102;	.tag	MemBlock;	.size	24;	.endef
	.def	MemBlock;	.scl	13;	.tag	MemBlock;	.size	24;	.type	0x8;	.endef
	.def	MemClass;	.scl	10;	.type	0x8;	.size	64;	.endef
	.def	name;	.val	0;	.scl	8;	.dim	8;	.size	8;	.type	0x32;	.endef
	.def	phys_first;	.val	8;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	phys_last;	.val	12;	.scl	8;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	freehead;	.val	16;	.scl	8;	.dim	24;	.size	24;	.type	0x32;	.endef
	.def	granularity;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	alignment;	.val	44;	.scl	8;	.type	0x4;	.endef
	.def	infosize;	.val	48;	.scl	8;	.type	0x4;	.endef
	.def	flags;	.val	52;	.scl	8;	.type	0x4;	.endef
	.def	mutex;	.val	56;	.scl	8;	.type	0x11;	.endef
	.def	field3c;	.val	60;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	64;	.scl	102;	.tag	MemClass;	.size	64;	.endef
	.def	MemClass;	.scl	13;	.tag	MemClass;	.size	64;	.type	0x8;	.endef
	.def	FREE_find;	.val	FREE_find;	.scl	2;	.tag	MemBlock;	.size	24;	.type	0x68;	.endef
	.text
	.ent	FREE_find
FREE_find:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mb;	.val	4;	.scl	17;	.tag	MemClass;	.size	64;	.type	0x18;	.endef
	.def	size;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	reverse;	.val	6;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L8
	addu	$4,$4,16
	.set	macro
	.set	reorder

$L3:
	lw	$4,16($4)
	#nop
	lw	$2,4($4)
	#nop
	slt	$2,$2,$5
	beq	$2,$0,$L7
	j	$L3
$L8:
	lw	$4,20($4)
	#nop
	lw	$2,4($4)
	#nop
	slt	$2,$2,$5
	bne	$2,$0,$L8
$L7:
	lhu	$3,0($4)
	li	$2,16979			# 0x00004253
	bne	$3,$2,$L12
	move	$4,$0
$L12:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	FREE_find
	.def	FREE_findlargest;	.val	FREE_findlargest;	.scl	2;	.tag	MemBlock;	.size	24;	.type	0x68;	.endef
	.text
	.ent	FREE_findlargest
FREE_findlargest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mb;	.val	4;	.scl	17;	.tag	MemClass;	.size	64;	.type	0x18;	.endef
	.def	size;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	reverse;	.val	6;	.scl	17;	.type	0x4;	.endef
	move	$7,$0
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L14
	addu	$4,$4,16
	.set	macro
	.set	reorder

	move	$5,$7
$L14:
	bne	$6,$0,$L23
	lw	$4,16($4)
	#nop
	lw	$2,4($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	li	$2,16979			# 0x00004253
	.set	macro
	.set	reorder

	lhu	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L29
	move	$2,$7
	.set	macro
	.set	reorder

$L20:
	move	$7,$4
	lw	$5,4($4)
$L16:
	lw	$4,16($4)
	#nop
	lw	$2,4($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	li	$2,16979			# 0x00004253
	.set	macro
	.set	reorder

	lhu	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L20
	move	$2,$7
	.set	macro
	.set	reorder

	j	$L29
$L27:
	move	$7,$4
	lw	$5,4($4)
$L23:
	lw	$4,20($4)
	#nop
	lw	$2,4($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	li	$2,16979			# 0x00004253
	.set	macro
	.set	reorder

	lhu	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L27
	move	$2,$7
	.set	macro
	.set	reorder

$L29:
	j	$31

	.loc	1 0
LM2:
	.end	FREE_findlargest
	.def	FREE_add;	.val	FREE_add;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FREE_add
FREE_add:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mb;	.val	4;	.scl	17;	.tag	MemClass;	.size	64;	.type	0x18;	.endef
	.def	node;	.val	5;	.scl	17;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	addu	$6,$4,16
	move	$7,$6
	lw	$2,8($5)
	lw	$3,20($6)
	lw	$4,16($6)
	subu	$2,$2,$5
	subu	$3,$3,$4
	srl	$3,$3,1
	addu	$4,$4,$3
	sltu	$4,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L37
	addu	$8,$2,-16
	.set	macro
	.set	reorder

$L32:
	lw	$7,20($7)
	#nop
	sltu	$2,$5,$7
	bne	$2,$0,$L32
	lw	$6,16($7)
	.set	noreorder
	.set	nomacro
	j	$L41
	sw	$6,16($5)
	.set	macro
	.set	reorder

$L37:
	lw	$6,16($6)
	#nop
	sltu	$2,$6,$5
	bne	$2,$0,$L37
	lw	$7,20($6)
	sw	$6,16($5)
$L41:
	sw	$7,20($5)
	sw	$8,4($5)
	sw	$5,16($7)
	sw	$5,20($6)
	lhu	$2,2($5)
	li	$3,16966			# 0x00004246
	sh	$3,0($5)
	ori	$2,$2,0x4000
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2($5)
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	FREE_add
	.def	FREE_remove;	.val	FREE_remove;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	FREE_remove
FREE_remove:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mb;	.val	4;	.scl	17;	.tag	MemClass;	.size	64;	.type	0x18;	.endef
	.def	node;	.val	5;	.scl	17;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	lw	$3,20($5)
	lw	$2,16($5)
	#nop
	sw	$2,16($3)
	sw	$3,20($2)
	lhu	$2,2($5)
	sh	$0,0($5)
	andi	$2,$2,0xbfff
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2($5)
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	FREE_remove
	.def	initmemblock;	.val	initmemblock;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	initmemblock
initmemblock:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	blk;	.val	17;	.scl	17;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	name;	.val	19;	.scl	17;	.type	0x12;	.endef
	.def	size;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	tailextra;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	flags;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	physprev;	.val	20;	.scl	9;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	physnext;	.val	24;	.scl	9;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	flags;	.val	18;	.scl	4;	.type	0x4;	.endef
	.def	physprev;	.val	4;	.scl	4;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	.def	physnext;	.val	3;	.scl	4;	.tag	MemBlock;	.size	24;	.type	0x18;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$7
	addu	$2,$6,16
	sw	$16,16($sp)
	addu	$16,$17,$2
	sw	$18,24($sp)
	lw	$18,56($sp)
	lw	$4,60($sp)
	lw	$3,64($sp)
	li	$2,16973			# 0x0000424d
	sw	$31,36($sp)
	sh	$2,0($17)
	sw	$6,4($17)
	andi	$2,$18,0x0200
	sh	$18,2($17)
	sw	$3,8($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	sw	$4,12($17)
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1111818240			# 0x42450000
	ori	$5,$5,0x4e44
	.set	noreorder
	.set	nomacro
	jal	putm
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

$L44:
	andi	$2,$18,0x0800
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L45
	addu	$4,$16,12
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

$L45:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L46
	addu	$16,$16,$20
	.set	macro
	.set	reorder

	andi	$2,$18,0x0100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L48
	subu	$2,$16,$17
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$2,1
	addu	$16,$16,$2
$L46:
	subu	$2,$16,$17
$L48:
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
	.end	initmemblock
	.def	MEM_infosize;	.val	MEM_infosize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	MEM_infosize
MEM_infosize:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gMemClassTable) # high
	addiu	$2,$2,%lo(gMemClassTable) # low
	andi	$4,$4,0x000f
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$2,0($4)
	#nop
	lw	$2,48($2)
	j	$31

	.loc	1 0
LM6:
	.end	MEM_infosize
	.def	MEM_tailsize;	.val	MEM_tailsize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	MEM_tailsize
MEM_tailsize:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x12;	.endef
	.def	id;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lui	$2,%hi(gMemClassTable) # high
	addiu	$2,$2,%lo(gMemClassTable) # low
	andi	$5,$5,0x000f
	sll	$5,$5,2
	addu	$5,$5,$2
	sw	$31,20($sp)
	sw	$16,16($sp)
	lw	$16,0($5)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L51
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$2,52($16)
	#nop
	andi	$2,$2,0x0100
	beq	$2,$0,$L51
	jal	strlen
	addu	$3,$2,1
$L51:
	lw	$2,48($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	MEM_tailsize
	.def	creatememclass;	.val	creatememclass;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	creatememclass
creatememclass:
	.frame	$sp,328,$31		# vars= 256, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	id;	.val	30;	.scl	17;	.type	0x4;	.endef
	.def	name;	.val	22;	.scl	17;	.type	0x12;	.endef
	.def	membuf;	.val	20;	.scl	17;	.type	0x12;	.endef
	.def	bufsize;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	granularity;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	alignment;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	infosize;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	lowguard;	.val	28;	.scl	9;	.type	0x4;	.endef
	.def	reserved9;	.val	32;	.scl	9;	.type	0x4;	.endef
	.def	highguard;	.val	36;	.scl	9;	.type	0x4;	.endef
	.def	usemutex;	.val	40;	.scl	9;	.type	0x4;	.endef
	.def	field3c;	.val	44;	.scl	9;	.type	0x4;	.endef
	.def	granularity;	.val	2;	.scl	4;	.type	0x4;	.endef
	.def	alignment;	.val	23;	.scl	4;	.type	0x4;	.endef
	.def	infosize;	.val	21;	.scl	4;	.type	0x4;	.endef
	.def	lowguard;	.val	2;	.scl	4;	.type	0x4;	.endef
	.def	highguard;	.val	3;	.scl	4;	.type	0x4;	.endef
	.def	field3c;	.val	2;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,328
	sw	$23,316($sp)
	lw	$23,348($sp)
	sw	$21,308($sp)
	lw	$21,352($sp)
	lw	$2,356($sp)
	lw	$3,364($sp)
	sw	$fp,320($sp)
	move	$fp,$4
	sw	$22,312($sp)
	move	$22,$5
	sw	$20,304($sp)
	move	$20,$6
	sw	$18,296($sp)
	move	$18,$fp
	sw	$31,324($sp)
	sw	$19,300($sp)
	sw	$17,292($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L53
	sw	$16,288($sp)
	.set	macro
	.set	reorder

	ori	$18,$18,0x0200
$L53:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L56
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	ori	$18,$18,0x0100
$L56:
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	move	$6,$22
	addu	$2,$21,80
	addu	$2,$20,$2
	addu	$3,$23,31
	addu	$2,$2,$3
	subu	$3,$0,$23
	and	$2,$2,$3
	addu	$19,$2,-16
	addu	$16,$20,$7
	addu	$2,$21,32
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$17,$20,16
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$sp,32
	li	$6,64			# 0x00000040
	move	$7,$21
	ori	$2,$18,0x8000
	sw	$2,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$19,24($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$0
	subu	$6,$16,$19
	addu	$6,$6,-16
	move	$7,$21
	sw	$18,16($sp)
	sw	$20,20($sp)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$22
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,32
	move	$6,$0
	move	$7,$21
	ori	$2,$18,0x8010
	sw	$2,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,64			# 0x00000040
	lui	$3,%hi(gMemClassTable) # high
	addiu	$3,$3,%lo(gMemClassTable) # low
	andi	$2,$fp,0x000f
	sll	$2,$2,2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$17,0($2)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$22
	.set	macro
	.set	reorder

	li	$3,2147418112			# 0x7fff0000
	ori	$3,$3,0xffff
	li	$2,16979			# 0x00004253
	sh	$2,16($17)
	addu	$2,$20,32
	sw	$20,8($17)
	sw	$16,12($17)
	sw	$2,32($17)
	sw	$2,36($17)
	sw	$3,20($17)
	lw	$2,344($sp)
	move	$4,$17
	sw	$23,44($17)
	sw	$21,48($17)
	sw	$18,52($17)
	sw	$0,56($17)
	sw	$2,40($17)
	lw	$2,372($sp)
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	FREE_add
	sw	$2,60($17)
	.set	macro
	.set	reorder

	lw	$8,368($sp)
	#nop
	beq	$8,$0,$L55
	jal	allocmutex
	sw	$2,56($17)
$L55:
	lw	$2,4($19)
	lw	$31,324($sp)
	lw	$fp,320($sp)
	lw	$23,316($sp)
	lw	$22,312($sp)
	lw	$21,308($sp)
	lw	$20,304($sp)
	lw	$19,300($sp)
	lw	$18,296($sp)
	lw	$17,292($sp)
	lw	$16,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,328
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	creatememclass
	.def	largestunused;	.val	largestunused;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	largestunused
largestunused:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$3,%hi(gMemClassTable) # high
	addiu	$3,$3,%lo(gMemClassTable) # low
	lw	$2,mb_default
	move	$5,$0
	sw	$31,16($sp)
	andi	$2,$2,0x000f
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	FREE_findlargest
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L58
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$3,4($2)
$L58:
	lw	$31,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	largestunused
	.def	getblocksize;	.val	getblocksize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	getblocksize
getblocksize:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x11;	.endef
	lw	$2,-12($4)
	j	$31

	.loc	1 0
LM10:
	.end	getblocksize
	.def	getblockname;	.val	getblockname;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	getblockname
getblockname:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	p;	.val	17;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	addu	$16,$17,-16
	sw	$31,24($sp)
	lhu	$4,2($16)
	#nop
	andi	$2,$4,0x0100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L62
	move	$3,$0
	.set	macro
	.set	reorder

	jal	MEM_infosize
	lw	$3,4($16)
	#nop
	addu	$3,$17,$3
	addu	$3,$3,$2
$L62:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM11:
	.end	getblockname
	.def	reservememadr;	.val	reservememadr;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	reservememadr
reservememadr:
	.frame	$sp,72,$31		# vars= 0, regs= 9/0, args= 32, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	23;	.scl	17;	.type	0x12;	.endef
	.def	size;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	classid;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,72
	sw	$23,60($sp)
	move	$23,$4
	sw	$22,56($sp)
	move	$22,$5
	sw	$18,40($sp)
	move	$18,$6
	sw	$21,52($sp)
	move	$21,$0
	sw	$17,36($sp)
	lui	$2,%hi(gMemClassTable) # high
	addiu	$2,$2,%lo(gMemClassTable) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	slt	$2,$22,8
	sw	$31,64($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$16,32($sp)
	lw	$19,0($3)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L64
	move	$17,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$22,$L66
	li	$17,8			# 0x00000008
	.set	macro
	.set	reorder

$L64:
	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	MEM_tailsize
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$3,40($19)
	addu	$2,$17,$2
	addu	$20,$3,-1
	addu	$3,$3,15
	addu	$2,$2,$3
	nor	$3,$0,$20
	and	$2,$2,$3
	addu	$17,$2,-16
	andi	$2,$18,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L67
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	FREE_findlargest
	andi	$6,$18,0x0010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L75
	move	$16,$2
	.set	macro
	.set	reorder

$L67:
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	FREE_find
	andi	$6,$18,0x0010
	.set	macro
	.set	reorder

	move	$16,$2
$L75:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L66
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FREE_remove
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	subu	$3,$2,$17
	slt	$2,$3,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	andi	$2,$18,0x0010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L71
	nor	$2,$0,$20
	.set	macro
	.set	reorder

	move	$17,$16
	and	$2,$3,$2
	addu	$16,$16,$2
	move	$4,$17
	lw	$2,8($17)
	move	$5,$0
	sw	$16,12($2)
	lw	$2,8($17)
	move	$6,$5
	sw	$17,12($16)
	sw	$2,8($16)
	sw	$0,16($sp)
	lw	$2,12($17)
	move	$7,$5
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	FREE_add
	move	$5,$17
	.set	macro
	.set	reorder

	j	$L70
$L71:
	addu	$2,$17,16
	addu	$17,$16,$2
	move	$4,$17
	move	$5,$0
	lw	$2,8($16)
	move	$6,$5
	sw	$17,12($2)
	sw	$0,16($sp)
	sw	$16,20($sp)
	lw	$2,8($16)
	move	$7,$5
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	FREE_add
	move	$5,$17
	.set	macro
	.set	reorder

	sw	$17,8($16)
$L70:
	lw	$2,52($19)
	#nop
	andi	$2,$2,0x0700
	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L73
	or	$18,$18,$2
	.set	macro
	.set	reorder

	li	$2,-257			# 0xfffffeff
	and	$18,$18,$2
$L73:
	move	$4,$16
	sw	$18,16($sp)
	lw	$2,12($4)
	move	$5,$23
	sw	$2,20($sp)
	lw	$2,8($4)
	move	$6,$22
	sw	$2,24($sp)
	lw	$7,48($19)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	addu	$21,$4,16
	.set	macro
	.set	reorder

	.def	end;	.val	$L66;	.scl	6;	.type	0x0;	.endef
$L66:
	move	$2,$21
	lw	$31,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM12:
	.end	reservememadr
	.def	purgememadr;	.val	purgememadr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	purgememadr
purgememadr:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L77
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$16,$4,-16
	lui	$2,%hi(gMemClassTable) # high
	addiu	$2,$2,%lo(gMemClassTable) # low
	lw	$17,8($16)
	lhu	$3,-14($4)
	lw	$18,12($16)
	andi	$3,$3,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lhu	$4,2($18)
	lw	$19,0($3)
	andi	$4,$4,0x4000
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L78
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FREE_remove
	move	$5,$18
	.set	macro
	.set	reorder

	move	$16,$18
	lw	$18,12($16)
	sw	$17,8($16)
	sw	$16,8($18)
	sw	$16,12($17)
$L78:
	lhu	$2,2($17)
	#nop
	andi	$2,$2,0x4000
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FREE_remove
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$17,8($17)
	sw	$18,12($16)
	sw	$17,8($16)
	sw	$16,12($17)
$L79:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	FREE_add
	move	$5,$16
	.set	macro
	.set	reorder

$L77:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM13:
	.end	purgememadr
	.def	gMemClassTable;	.val	gMemClassTable;	.scl	2;	.tag	MemClass;	.dim	16;	.size	64;	.type	0x78;	.endef
	.def	MAGIC_USED;	.val	MAGIC_USED;	.scl	3;	.type	0xd;	.endef
	.def	MAGIC_FREE;	.val	MAGIC_FREE;	.scl	3;	.type	0xd;	.endef
	.def	MAGIC_HEAD;	.val	MAGIC_HEAD;	.scl	3;	.type	0xd;	.endef
