	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdma.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDdmtransfer
	.align	2
	.globl	iSNDdmcallback
	.align	2
	.globl	iSNDdmservice
	.align	2
	.globl	iSNDdmqueue
	.align	2
	.globl	iSNDdmqueuesplit
	.align	2
	.globl	iSNDdmcomplete

	.text
	.def	SNDDmaEntry;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	handle;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	dstSpu;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	srcHi;	.val	8;	.scl	8;	.type	0xd;	.endef
	.def	len64;	.val	10;	.scl	8;	.type	0xc;	.endef
	.def	priority;	.val	11;	.scl	8;	.type	0xc;	.endef
	.def	flag;	.val	12;	.scl	8;	.type	0xc;	.endef
	.def	pad;	.val	13;	.scl	8;	.dim	3;	.size	3;	.type	0x3c;	.endef
	.def	deadline;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	SNDDmaEntry;	.size	20;	.endef
	.def	iSNDdmtransfer;	.val	iSNDdmtransfer;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDdmtransfer
iSNDdmtransfer:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	#.set	volatile
	lbu	$2,12($3)
	#.set	novolatile
 #APP
	mfc0 $17,$12
	nop
	li $1,-1026
	and $8,$17,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	#nop
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L4
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

 #APP
	mtc0 $17,$12
 #NO_APP
	j	$L3
$L4:
	move	$5,$0
	li	$2,1			# 0x00000001
	sb	$2,14($3)
	move	$4,$5
	move	$7,$3
	addu	$3,$7,16
$L6:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	beq	$2,$0,$L9
	#.set	volatile
	lbu	$2,11($3)
	#.set	novolatile
	#nop
	sltu	$2,$5,$2
	beq	$2,$0,$L10
	sb	$4,13($7)
	#.set	volatile
	lw	$6,0($3)
	#.set	novolatile
	#.set	volatile
	lbu	$2,11($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L9
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

$L10:
	#.set	volatile
	lbu	$2,11($3)
	#.set	novolatile
	#nop
	bne	$2,$5,$L9
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	sltu	$2,$2,$6
	beq	$2,$0,$L9
	sb	$4,13($7)
	#.set	volatile
	lw	$6,0($3)
	#.set	novolatile
$L9:
	addu	$4,$4,1
	slt	$2,$4,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	addu	$3,$3,20
	.set	macro
	.set	reorder

	lui	$2,%hi(sndpd) # high
	addiu	$4,$2,%lo(sndpd) # low
	#.set	volatile
	lbu	$2,13($4)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$2,$4,16
	addu	$16,$3,$2
	lbu	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,1832($4)
	#.set	volatile
	sb	$2,1($4)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L17
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	jal	$31,$3
$L14:
	lui	$2,%hi(sndgs) # high
$L17:
	addiu	$2,$2,%lo(sndgs) # low
	lui	$4,%hi(sndpd) # high
	#.set	volatile
	lw	$2,68($2)
	#.set	novolatile
	addiu	$4,$4,%lo(sndpd) # low
	addu	$2,$2,15
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($4)
	#.set	novolatile
	lhu	$2,8($16)
	#nop
	#.set	volatile
	sh	$2,422($3)
	#.set	novolatile
	#.set	volatile
	lw	$3,1300($4)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,426($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0xffcf
	ori	$2,$2,0x0020
	#.set	volatile
	sh	$2,426($3)
	#.set	novolatile
	lw	$5,1276($4)
	li	$3,-251723776			# 0xf0ff0000
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	ori	$3,$3,0xffff
	and	$2,$2,$3
	li	$3,536870912			# 0x20000000
	or	$2,$2,$3
	#.set	volatile
	sw	$2,0($5)
	#.set	novolatile
	#.set	volatile
	lw	$3,1280($4)
	#.set	novolatile
	lw	$2,4($16)
	li	$5,16777216			# 0x01000000
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	lbu	$2,10($16)
	#.set	volatile
	lw	$3,1284($4)
	#.set	novolatile
	sll	$2,$2,16
	ori	$2,$2,0x0010
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,1288($4)
	#.set	novolatile
	ori	$5,$5,0x0201
	#.set	volatile
	sw	$5,0($2)
	#.set	novolatile
 #APP
	mtc0 $17,$12
 #NO_APP
$L3:
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
LM1:
	.end	iSNDdmtransfer
	.def	iSNDdmcallback;	.val	iSNDdmcallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDdmcallback
iSNDdmcallback:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$2,13			# 0x0000000d
	#.set	volatile
	sw	$2,20($sp)
	#.set	novolatile
	#.set	volatile
	sw	$0,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	sw	$31,28($sp)
	slt	$2,$2,750
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	sw	$16,24($sp)
	.set	macro
	.set	reorder

$L22:
	#.set	volatile
	lw	$3,20($sp)
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,20($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,16($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($sp)
	#.set	novolatile
	#nop
	slt	$2,$2,750
	bne	$2,$0,$L22
$L20:
	lui	$3,%hi(sndpd) # high
	addiu	$3,$3,%lo(sndpd) # low
	#.set	volatile
	lw	$4,1300($3)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,426($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0xffcf
	#.set	volatile
	sh	$2,426($4)
	#.set	novolatile
	#.set	volatile
	lw	$4,1300($3)
	#.set	novolatile
	#nop
	#.set	volatile
	lhu	$2,426($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0030
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L25
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$3,1
$L36:
	slt	$2,$3,4001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	lui	$2,%hi(sndpd) # high
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,426($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0030
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L25:
	lui	$2,%hi(sndpd) # high
$L35:
	addiu	$4,$2,%lo(sndpd) # low
	#.set	volatile
	lbu	$3,13($4)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	#.set	volatile
	lw	$2,16($2)
	#.set	novolatile
 #APP
	mfc0 $16,$12
	nop
	li $1,-1026
	and $8,$16,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	#nop
	beq	$2,$0,$L29
	#.set	volatile
	lbu	$2,1($4)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L37
	lui	$2,%hi(sndpd) # high
	.set	macro
	.set	reorder

	lw	$2,1832($4)
	#.set	volatile
	sb	$0,1($4)
	#.set	novolatile
	beq	$2,$0,$L30
	jal	$31,$2
$L30:
	lui	$2,%hi(sndpd) # high
$L37:
	addiu	$4,$2,%lo(sndpd) # low
	#.set	volatile
	lbu	$3,13($4)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	sw	$0,16($2)
	lbu	$2,12($4)
	#nop
	addu	$2,$2,-1
	sb	$2,12($4)
	#.set	volatile
	lbu	$2,12($4)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	bgtz	$2,$L29
	#.set	volatile
	sb	$0,14($4)
	#.set	novolatile
 #APP
	mtc0 $16,$12
 #NO_APP
	j	$L18
$L29:
 #APP
	mtc0 $16,$12
 #NO_APP
	jal	iSNDdmtransfer
$L18:
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
LM2:
	.end	iSNDdmcallback
	.def	iSNDdmservice;	.val	iSNDdmservice;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDdmservice
iSNDdmservice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(sndpd) # high
	addiu	$5,$2,%lo(sndpd) # low
	sw	$31,16($sp)
	lbu	$2,14($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L39
	lui	$4,%hi(sndgs) # high
	.set	macro
	.set	reorder

	jal	iSNDdmtransfer
	j	$L40
$L39:
	#.set	volatile
	lbu	$3,13($5)
	#.set	novolatile
	addiu	$4,$4,%lo(sndgs) # low
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	#.set	volatile
	lw	$3,68($4)
	#.set	novolatile
	lw	$2,32($2)
	#nop
	sltu	$3,$3,$2
	bne	$3,$0,$L40
	jal	iSNDdmcallback
$L40:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSNDdmservice
	.def	iSNDdmqueue;	.val	iSNDdmqueue;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDdmqueue
iSNDdmqueue:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	dst_spu;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	src_ram;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	len;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	prio;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	flag;	.val	16;	.scl	9;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lw	$10,40($sp)
	andi	$2,$6,0x003f
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$6,$6,64
$L43:
	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	#.set	volatile
	lw	$2,8($3)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,8($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,8($3)
	#.set	novolatile
 #APP
	mfc0 $9,$12
	nop
	li $1,-1026
	and $8,$9,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L52
	move	$8,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	#.set	volatile
	sw	$2,8($3)
	#.set	novolatile
	move	$8,$0
$L52:
	move	$16,$3
	addu	$3,$16,16
	.def	scan;	.val	$L45;	.scl	6;	.type	0x0;	.endef
$L45:
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L47
	addu	$8,$8,1
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,12($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sb	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	#.set	volatile
	sw	$4,4($3)
	#.set	novolatile
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	srl	$2,$5,3
	#.set	volatile
	sh	$2,8($3)
	#.set	novolatile
	sra	$2,$6,6
	#.set	volatile
	sb	$2,10($3)
	#.set	novolatile
	#.set	volatile
	sb	$7,11($3)
	#.set	novolatile
	#.set	volatile
	sb	$10,12($3)
	#.set	novolatile
 #APP
	mtc0 $9,$12
 #NO_APP
	jal	iSNDdmservice
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	j	$L51
	.def	occupied;	.val	$L47;	.scl	6;	.type	0x0;	.endef
$L47:
	slt	$2,$8,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L45
	addu	$3,$3,20
	.set	macro
	.set	reorder

 #APP
	mtc0 $9,$12
 #NO_APP
	move	$2,$0
$L51:
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
LM4:
	.end	iSNDdmqueue
	.def	iSNDdmqueuesplit;	.val	iSNDdmqueuesplit;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDdmqueuesplit
iSNDdmqueuesplit:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	dst_spu;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	src_ram;	.val	19;	.scl	17;	.type	0xe;	.endef
	.def	len;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	prio;	.val	22;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$18,32($sp)
	move	$18,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$17,28($sp)
	move	$17,$6
	sw	$22,48($sp)
	move	$22,$7
	move	$2,$0
	sw	$31,52($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	.set	noreorder
	.set	nomacro
	blez	$17,$L64
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sndpd) # high
	addiu	$21,$2,%lo(sndpd) # low
	li	$20,10			# 0x0000000a
$L55:
	li	$16,4096			# 0x00001000
	slt	$2,$17,$16
	beq	$2,$0,$L59
	move	$16,$17
$L59:
	#.set	volatile
	lbu	$2,12($21)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	subu	$2,$20,$2
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L60
	move	$4,$18
	.set	macro
	.set	reorder

	jal	iSNDdmservice
	j	$L59
$L60:
	sw	$0,16($sp)
	move	$5,$19
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDdmqueue
	move	$7,$22
	.set	macro
	.set	reorder

	addu	$18,$18,$16
	subu	$17,$17,$16
	.set	noreorder
	.set	nomacro
	bgtz	$17,$L55
	addu	$19,$19,$16
	.set	macro
	.set	reorder

$L64:
	lw	$31,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSNDdmqueuesplit
	.def	iSNDdmcomplete;	.val	iSNDdmcomplete;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDdmcomplete
iSNDdmcomplete:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	handle;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDdmservice
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	lbu	$2,12($3)
	#nop
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L70
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L68
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	found;	.val	$L69;	.scl	6;	.type	0x0;	.endef
$L69:
	.set	noreorder
	.set	nomacro
	j	$L68
	move	$2,$0
	.set	macro
	.set	reorder

$L70:
	lw	$2,16($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L69
	addu	$4,$4,1
	.set	macro
	.set	reorder

	slt	$2,$4,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	addu	$3,$3,20
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.def	done;	.val	$L68;	.scl	6;	.type	0x0;	.endef
$L68:
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
LM6:
	.end	iSNDdmcomplete
