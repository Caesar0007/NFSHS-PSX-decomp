	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\salloc.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndchanreserved
	.section	.bss
sndchanreserved:
	.space	4
	.text
 #NO_APP
	.text
	.align	2
	.globl	iSNDischanreserved
	.align	2
	.globl	iSNDallocchan
	.align	2
	.globl	iSNDfreechan
	.align	2
	.globl	iSNDgetchan

	.text
	.def	iSNDischanreserved;	.val	iSNDischanreserved;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDischanreserved
iSNDischanreserved:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	count;	.val	5;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	blez	$5,$L3
	move	$3,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(sndchanreserved) # high
	addiu	$6,$2,%lo(sndchanreserved) # low
	addu	$2,$3,$6
$L9:
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L4
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L4:
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	addu	$2,$3,$6
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDischanreserved
	.def	iSNDallocchan;	.val	iSNDallocchan;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDallocchan
iSNDallocchan:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	priority;	.val	0;	.scl	9;	.type	0xe;	.endef
	.def	numChannels;	.val	8;	.scl	17;	.type	0x4;	.endef
	.def	a2;	.val	8;	.scl	9;	.type	0x4;	.endef
	.def	out;	.val	12;	.scl	9;	.type	0x1e;	.endef
	subu	$sp,$sp,72
	move	$8,$5
	li	$9,-9			# 0xfffffff7
	sw	$19,44($sp)
	move	$19,$0
	sw	$23,60($sp)
	move	$23,$19
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	sw	$4,72($sp)
	sw	$6,80($sp)
	sw	$7,84($sp)
	.set	noreorder
	.set	nomacro
	blez	$8,$L12
	sw	$9,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sndchanreserved) # high
	addiu	$4,$2,%lo(sndchanreserved) # low
	li	$3,-1			# 0xffffffff
	addu	$2,$19,$4
$L68:
	sb	$3,0($2)
	addu	$19,$19,1
	slt	$2,$19,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L68
	addu	$2,$19,$4
	.set	macro
	.set	reorder

$L12:
	lui	$3,%hi(DAT_80136dec) # high
	lw	$2,%lo(DAT_80136dec)($3)
	#nop
	addu	$2,$2,32
	.set	noreorder
	.set	nomacro
	bgez	$2,$L16
	sw	$2,%lo(DAT_80136dec)($3)
	.set	macro
	.set	reorder

	sw	$0,%lo(DAT_80136dec)($3)
$L16:
	slt	$2,$23,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	move	$19,$23
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs) # high
	addiu	$22,$2,%lo(sndgs) # low
	lui	$2,%hi(sndchanreserved) # high
	addiu	$fp,$2,%lo(sndchanreserved) # low
	li	$20,-1			# 0xffffffff
$L69:
	move	$21,$20
	lbu	$2,17($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L21
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$17
$L22:
	li	$2,1			# 0x00000001
	lw	$9,72($sp)
	sll	$2,$2,$17
	and	$2,$9,$2
	beq	$2,$0,$L25
	lw	$2,148($22)
	#nop
	addu	$16,$2,$18
	lb	$2,11($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L25
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	iSNDischanreserved
	sw	$8,24($sp)
	.set	macro
	.set	reorder

	lw	$8,24($sp)
	bne	$2,$0,$L25
	lw	$3,16($16)
	#nop
	sltu	$2,$3,$21
	beq	$2,$0,$L25
	move	$21,$3
	move	$20,$17
$L25:
	lbu	$2,17($22)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L22
	addu	$18,$18,100
	.set	macro
	.set	reorder

$L21:
	.set	noreorder
	.set	nomacro
	bltz	$20,$L19
	addu	$2,$23,$fp
	.set	macro
	.set	reorder

	sb	$20,0($2)
	addu	$23,$23,1
$L19:
	addu	$19,$19,1
	slt	$2,$19,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L69
	li	$20,-1			# 0xffffffff
	.set	macro
	.set	reorder

	slt	$2,$23,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	move	$19,$23
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs) # high
	addiu	$fp,$2,%lo(sndgs) # low
$L34:
	li	$22,102			# 0x00000066
	li	$20,-1			# 0xffffffff
	move	$21,$20
	lbu	$2,17($fp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$17
$L36:
	li	$2,1			# 0x00000001
	lw	$9,72($sp)
	sll	$2,$2,$17
	and	$2,$9,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	iSNDischanreserved
	sw	$8,24($sp)
	.set	macro
	.set	reorder

	lw	$8,24($sp)
	bne	$2,$0,$L39
	lw	$2,148($fp)
	#nop
	addu	$16,$2,$18
	lbu	$2,12($16)
	#nop
	sltu	$2,$2,101
	beq	$2,$0,$L39
	lbu	$3,12($16)
	#nop
	slt	$2,$3,$22
	beq	$2,$0,$L41
	lw	$21,16($16)
	.set	noreorder
	.set	nomacro
	j	$L67
	move	$22,$3
	.set	macro
	.set	reorder

$L41:
	bne	$3,$22,$L39
	lw	$3,16($16)
	#nop
	sltu	$2,$3,$21
	beq	$2,$0,$L39
	move	$21,$3
$L67:
	move	$20,$17
$L39:
	lbu	$2,17($fp)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	addu	$18,$18,100
	.set	macro
	.set	reorder

$L35:
	.set	noreorder
	.set	nomacro
	bltz	$20,$L33
	lui	$9,%hi(sndchanreserved) # high
	.set	macro
	.set	reorder

	addiu	$9,$9,%lo(sndchanreserved) # low
	addu	$2,$23,$9
	sb	$20,0($2)
	addu	$23,$23,1
	slt	$2,$23,$8
	beq	$2,$0,$L32
$L33:
	addu	$19,$19,1
	slt	$2,$19,$8
	bne	$2,$0,$L34
$L32:
	.set	noreorder
	.set	nomacro
	bne	$23,$8,$L60
	lui	$2,%hi(DAT_80136dec) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(sndchanreserved) # high
	lb	$3,%lo(sndchanreserved)($4)
	lw	$2,%lo(DAT_80136dec)($2)
	lw	$9,84($sp)
	or	$2,$2,$3
	sw	$2,0($9)
	lb	$9,%lo(sndchanreserved)($4)
	move	$19,$0
	.set	noreorder
	.set	nomacro
	blez	$23,$L49
	sw	$9,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sndgs) # high
	addiu	$21,$2,%lo(sndgs) # low
	addiu	$18,$4,%lo(sndchanreserved) # low
$L50:
	lb	$2,0($18)
	lw	$4,148($21)
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$16,$4,$3
	li	$2,1			# 0x00000001
	lb	$20,11($16)
	lw	$17,0($16)
	bne	$20,$2,$L53
	bgez	$17,$L54
	lb	$3,60($16)
	#nop
	sll	$2,$3,$2
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$17,0($2)
$L54:
	.set	noreorder
	.set	nomacro
	jal	SNDstop
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDover
	move	$4,$17
	.set	macro
	.set	reorder

	beq	$2,$20,$L53
	addu	$19,$19,-1
	.set	noreorder
	.set	nomacro
	bltz	$19,$L57
	addu	$18,$18,-1
	.set	macro
	.set	reorder

$L58:
	lb	$2,0($18)
	addu	$18,$18,-1
	addu	$19,$19,-1
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,$2
	lw	$2,148($21)
	sll	$3,$3,2
	addu	$16,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$19,$L58
	sb	$0,11($16)
	.set	macro
	.set	reorder

$L57:
	li	$9,-9			# 0xfffffff7
	.set	noreorder
	.set	nomacro
	j	$L60
	sw	$9,16($sp)
	.set	macro
	.set	reorder

$L53:
	addu	$18,$18,1
	li	$2,1			# 0x00000001
	addu	$19,$19,1
	sb	$2,11($16)
	lw	$2,68($21)
	lbu	$9,80($sp)
	sw	$2,16($16)
	slt	$2,$19,$23
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L50
	sb	$9,12($16)
	.set	macro
	.set	reorder

$L49:
	li	$19,1			# 0x00000001
	lui	$2,%hi(sndgs) # high
	lui	$6,%hi(sndchanreserved) # high
	addiu	$5,$2,%lo(sndgs) # low
	lb	$3,%lo(sndchanreserved)($6)
	lw	$9,84($sp)
	sll	$2,$3,$19
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,148($5)
	lw	$4,0($9)
	addu	$2,$2,$3
	sw	$4,0($2)
	slt	$2,$19,$23
	beq	$2,$0,$L60
	addiu	$8,$6,%lo(sndchanreserved) # low
	li	$7,-1			# 0xffffffff
$L65:
	lb	$3,%lo(sndchanreserved)($6)
	addu	$4,$19,$8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($5)
	sll	$2,$2,2
	addu	$2,$2,$3
	lbu	$3,0($4)
	addu	$2,$19,$2
	sb	$3,3($2)
	lb	$3,0($4)
	addu	$19,$19,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($5)
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$7,0($2)
	lb	$3,0($4)
	lbu	$4,%lo(sndchanreserved)($6)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($5)
	sll	$2,$2,2
	addu	$2,$2,$3
	sb	$4,60($2)
	slt	$2,$19,$23
	bne	$2,$0,$L65
	.def	done;	.val	$L60;	.scl	6;	.type	0x0;	.endef
$L60:
	lw	$2,16($sp)
	lw	$31,68($sp)
	lw	$fp,64($sp)
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
LM2:
	.end	iSNDallocchan
	.def	iSNDfreechan;	.val	iSNDfreechan;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDfreechan
iSNDfreechan:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	chan;	.val	4;	.scl	17;	.type	0x4;	.endef
	move	$8,$0
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	lw	$9,148($3)
	sll	$2,$2,2
	addu	$5,$9,$2
	lbu	$7,55($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L71
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lbu	$3,17($3)
	#nop
	slt	$2,$8,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L72
	move	$5,$8
	.set	macro
	.set	reorder

	move	$10,$3
	move	$3,$9
$L73:
 #APP
 #NO_APP
	lbu	$2,55($3)
	#nop
	bne	$2,$7,$L76
	lw	$2,0($3)
	#nop
	bltz	$2,$L76
	lb	$2,11($3)
	#nop
	beq	$2,$0,$L76
	lbu	$2,54($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L76
	addu	$8,$8,1
	.set	macro
	.set	reorder

	move	$6,$5
$L76:
	addu	$5,$5,1
	slt	$2,$5,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	addu	$3,$3,100
	.set	macro
	.set	reorder

$L72:
	lui	$2,%hi(sndgs) # high
	addiu	$9,$2,%lo(sndgs) # low
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	lw	$3,148($9)
	sll	$2,$2,2
	addu	$5,$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L78
	sll	$2,$6,1
	.set	macro
	.set	reorder

	sb	$0,11($5)
	lw	$2,68($9)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,16($5)
	.set	macro
	.set	reorder

$L78:
	addu	$2,$2,$6
	sll	$2,$2,3
	addu	$2,$2,$6
	sll	$7,$2,2
	addu	$2,$7,$3
	lb	$3,11($2)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L79
	beq	$4,$6,$L79
	.set	noreorder
	.set	nomacro
	bne	$8,$3,$L81
	lui	$3,%hi(DAT_801478f4) # high
	.set	macro
	.set	reorder

	sb	$0,11($5)
	lw	$2,68($9)
	#nop
	sw	$2,16($5)
	lw	$2,148($9)
	#nop
	addu	$2,$7,$2
	sb	$0,11($2)
	lw	$2,148($9)
	lw	$3,68($9)
	addu	$2,$7,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,16($2)
	.set	macro
	.set	reorder

$L79:
	lui	$3,%hi(DAT_801478f4) # high
$L81:
 #APP
 #NO_APP
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$2,$2,3
	addu	$2,$2,$6
	lw	$3,%lo(DAT_801478f4)($3)
	sll	$2,$2,2
	addu	$7,$2,$3
	lb	$3,11($7)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L82
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L83
	addiu	$2,$2,%lo(sndgs) # low
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,11($7)
	.set	macro
	.set	reorder

$L82:
	addiu	$2,$2,%lo(sndgs) # low
$L83:
 #APP
 #NO_APP
	sb	$0,11($5)
	lw	$2,68($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,16($5)
	.set	macro
	.set	reorder

$L71:
	sb	$0,11($5)
	lw	$2,68($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,16($5)
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSNDfreechan
	.def	iSNDgetchan;	.val	iSNDgetchan;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDgetchan
iSNDgetchan:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0xe;	.endef
	.set	noreorder
	.set	nomacro
	bltz	$4,$L86
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(sndgs) # low
	lbu	$2,17($3)
	andi	$5,$4,0x001f
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L88
	sll	$2,$5,1
	.set	macro
	.set	reorder

	.def	invalid;	.val	$L86;	.scl	6;	.type	0x0;	.endef
$L86:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	.def	valid_range;	.val	$L88;	.scl	6;	.type	0x0;	.endef
$L88:
	addu	$2,$2,$5
	sll	$2,$2,3
	addu	$2,$2,$5
	lw	$3,148($3)
	sll	$2,$2,2
	addu	$3,$3,$2
	lb	$2,11($3)
	#nop
	beq	$2,$0,$L90
	lw	$2,0($3)
	#nop
	beq	$2,$4,$L89
$L90:
	li	$5,-8			# 0xfffffff8
$L89:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSNDgetchan
