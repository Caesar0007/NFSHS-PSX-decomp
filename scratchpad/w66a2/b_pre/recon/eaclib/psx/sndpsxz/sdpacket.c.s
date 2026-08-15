	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdpacket.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndpp
	.section	.bss
	.align	2
sndpp:
	.space	52
	.text
 #NO_APP
	.globl	snd_voice_done_hook
	.sdata
	.align	2
snd_voice_done_hook:
	.word	0
	.globl	snd_user_serve_hook
	.align	2
snd_user_serve_hook:
	.word	0
	.text
	.align	2
	.globl	iSNDpacketgetirq
	.align	2
	.globl	iSNDpacketsetirq
	.align	2
	.globl	iSNDpacketirqcallback
	.align	2
	.globl	iSNDpsxzerospu
	.align	2
	.globl	iSNDpacketpurgeframes
	.align	2
	.globl	iSNDfillspuwithpackets
	.align	2
	.globl	iSNDpacketserve
	.align	2
	.globl	iSNDplatformpacketoverhead
	.align	2
	.globl	iSNDplatformcalcdatarate
	.align	2
	.globl	iSNDplatformpacketplaycreate
	.align	2
	.globl	iSNDplatformpacketplaydestroy
	.align	2
	.globl	iSNDplatformpacketplay
	.align	2
	.globl	iSNDpsxpacketstop

	.extern	D_80147871, 1
	.extern	sndpsxlimits, 4

	.text
	.def	SNDPDVoiceTableView;	.scl	10;	.type	0x8;	.size	217;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	216;	.size	216;	.type	0x3c;	.endef
	.def	table;	.val	216;	.scl	8;	.dim	1;	.size	1;	.type	0x3c;	.endef
	.def	.eos;	.val	217;	.scl	102;	.tag	SNDPDVoiceTableView;	.size	217;	.endef
	.def	SNDPDPacketPtrView;	.scl	10;	.type	0x8;	.size	1276;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	1272;	.size	1272;	.type	0x3c;	.endef
	.def	ptr;	.val	1272;	.scl	8;	.dim	1;	.size	4;	.type	0x34;	.endef
	.def	.eos;	.val	1276;	.scl	102;	.tag	SNDPDPacketPtrView;	.size	1276;	.endef
	.def	iSNDpacketgetirq;	.val	iSNDpacketgetirq;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpacketgetirq
iSNDpacketgetirq:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(sndpd) # high
	lui	$2,%hi(sndpp) # high
	lw	$2,%lo(sndpp)($2)
	addiu	$7,$3,%lo(sndpd) # low
	sll	$2,$2,2
	addu	$2,$2,$7
	lw	$5,1272($2)
	#nop
	lb	$3,66($5)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L11
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$3,$7,216
	addu	$4,$2,$3
	#.set	volatile
	lw	$2,12($4)
	#.set	novolatile
	lhu	$6,64($5)
	srl	$2,$2,12
	sltu	$2,$6,$2
	beq	$2,$0,$L5
	#.set	volatile
	lw	$3,12($4)
	#.set	novolatile
	lw	$2,12($5)
	srl	$3,$3,12
	subu	$2,$2,$6
	sltu	$3,$3,$2
	bne	$3,$0,$L10
$L5:
	#.set	volatile
	lw	$2,12($4)
	#.set	novolatile
	lw	$3,12($5)
	srl	$2,$2,11
	sltu	$2,$2,$3
	beq	$2,$0,$L6
	#.set	volatile
	lw	$2,12($4)
	#.set	novolatile
	#nop
	#.set	volatile
	sw	$2,16($4)
	#.set	novolatile
	#.set	volatile
	lbu	$2,32($4)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	bltz	$2,$L10
	#.set	volatile
	lbu	$2,32($4)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	sll	$3,$3,2
	#.set	volatile
	lw	$2,12($4)
	#.set	novolatile
	addu	$3,$3,$7
	#.set	volatile
	sw	$2,232($3)
	#.set	novolatile
$L11:
	j	$31
$L6:
	#.set	volatile
	sw	$0,12($4)
	#.set	novolatile
	#.set	volatile
	lbu	$2,32($4)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	bltz	$2,$L10
	#.set	volatile
	lbu	$3,32($4)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$7
	#.set	volatile
	sw	$0,228($2)
	#.set	novolatile
$L10:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDpacketgetirq
	.def	iSNDpacketsetirq;	.val	iSNDpacketsetirq;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpacketsetirq
iSNDpacketsetirq:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxdisablespuirq
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	lbu	$2,1($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(sndpp) # high
	move	$5,$3
$L14:
	lw	$2,%lo(sndpp)($4)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(sndpp)($4)
	#.set	volatile
	lw	$2,%lo(sndpp)($4)
	#.set	novolatile
	#nop
	blez	$2,$L17
	sw	$0,%lo(sndpp)($4)
$L17:
	#.set	volatile
	lw	$2,%lo(sndpp)($4)
	#.set	novolatile
	#nop
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,1272($2)
	#nop
	beq	$3,$0,$L18
	lb	$2,66($3)
	#nop
	bgez	$2,$L19
$L18:
	addu	$16,$16,1
	slt	$2,$16,2
	beq	$2,$0,$L12
	j	$L14
	.def	success;	.val	$L19;	.scl	6;	.type	0x0;	.endef
$L19:
	lw	$2,0($3)
	lui	$3,%hi(sndpd+1300) # high
	lui	$5,%hi(iSNDpacketirqcallback) # high
	li	$4,9			# 0x00000009
	addiu	$5,$5,%lo(iSNDpacketirqcallback) # low
	lw	$3,%lo(sndpd+1300)($3)
	addu	$2,$2,8
	sra	$2,$2,3
	#.set	volatile
	sh	$2,420($3)
	#.set	novolatile
	jal	InterruptCallback
	jal	iSNDpsxenablespuirq
$L12:
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
	.end	iSNDpacketsetirq
	.def	iSNDpacketirqcallback;	.val	iSNDpacketirqcallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpacketirqcallback
iSNDpacketirqcallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	iSNDpacketgetirq
	jal	iSNDpacketsetirq
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
	.end	iSNDpacketirqcallback
	.def	iSNDpsxzerospu;	.val	iSNDpsxzerospu;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpsxzerospu
iSNDpsxzerospu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	addr;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	len;	.val	5;	.scl	17;	.type	0x4;	.endef
	sra	$5,$5,2
	.set	noreorder
	.set	nomacro
	blez	$5,$L28
	move	$3,$0
	.set	macro
	.set	reorder

	li	$6,512			# 0x00000200
$L24:
	sw	$6,0($4)
	sw	$0,4($4)
	sw	$0,8($4)
	sw	$0,12($4)
	addu	$3,$3,4
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	addu	$4,$4,16
	.set	macro
	.set	reorder

$L28:
	j	$31

	.loc	1 0
LM4:
	.end	iSNDpsxzerospu
	.def	iSNDpacketpurgeframes;	.val	iSNDpacketpurgeframes;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDpacketpurgeframes
iSNDpacketpurgeframes:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	byteoff;	.val	19;	.scl	17;	.type	0xe;	.endef
	.def	count;	.val	20;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$23,44($sp)
	move	$23,$4
	sw	$19,28($sp)
	move	$19,$5
	lui	$4,%hi(sndpd) # high
	addiu	$4,$4,%lo(sndpd) # low
	sll	$2,$23,2
	addu	$2,$2,$4
	sw	$31,48($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$21,1272($2)
	move	$20,$6
	lb	$3,66($21)
	addu	$4,$4,216
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$22,$2,$4
$L30:
	lhu	$2,70($21)
	#nop
	divu	$4,$19,$2
	addu	$3,$4,1
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	subu	$18,$2,$19
	slt	$2,$20,$18
	beq	$2,$0,$L33
	move	$18,$20
$L33:
	lw	$2,44($21)
	sll	$3,$4,1
	addu	$3,$3,$2
	lhu	$4,0($3)
	#nop
	slt	$2,$4,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	move	$17,$18
	.set	macro
	.set	reorder

	move	$17,$4
$L34:
	subu	$2,$4,$17
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L35
	sh	$2,0($3)
	.set	macro
	.set	reorder

	lbu	$2,31($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$23
$L42:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDpacketfreeframes
	move	$6,$17
	.set	macro
	.set	reorder

	lbu	$2,31($22)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	move	$4,$23
	.set	macro
	.set	reorder

$L35:
	lw	$2,12($21)
	addu	$19,$19,$18
	sltu	$2,$19,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L32
	subu	$20,$20,$18
	.set	macro
	.set	reorder

	move	$19,$0
$L32:
	bgtz	$20,$L30
	lw	$31,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSNDpacketpurgeframes
	.def	iSNDfillspuwithpackets;	.val	iSNDfillspuwithpackets;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDfillspuwithpackets
iSNDfillspuwithpackets:
	.frame	$sp,72,$31		# vars= 8, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	21;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,72
	sw	$23,60($sp)
	move	$23,$4
	lui	$4,%hi(sndpd) # high
	addiu	$4,$4,%lo(sndpd) # low
	sll	$2,$23,2
	addu	$2,$2,$4
	sw	$31,64($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$18,1272($2)
	move	$21,$5
	lb	$3,66($18)
	addu	$4,$4,216
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	lhu	$3,60($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L44
	addu	$20,$2,$4
	.set	macro
	.set	reorder

	lhu	$2,68($18)
	lw	$3,44($18)
	sh	$0,62($18)
	sh	$2,60($18)
	sll	$2,$21,1
	addu	$2,$2,$3
	sh	$0,0($2)
$L44:
	lw	$2,20($18)
	#nop
	bne	$2,$0,$L45
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$18
	li	$5,16			# 0x00000010
$L119:
	lw	$4,72($17)
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxzerospu
	addu	$17,$17,4
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L119
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

$L46:
	lhu	$2,62($18)
	lhu	$3,60($18)
	addu	$2,$2,16
	addu	$3,$3,-16
	sh	$2,62($18)
	sh	$3,60($18)
$L45:
	lhu	$2,60($18)
	#nop
	beq	$2,$0,$L91
	li	$22,2			# 0x00000002
$L52:
	lhu	$2,52($18)
	#nop
	bne	$2,$0,$L120
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L56
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$18
	move	$4,$23
$L121:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDpacketget
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	sw	$2,36($17)
	addu	$17,$17,4
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L121
	move	$4,$23
	.set	macro
	.set	reorder

$L56:
	lw	$2,36($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L61
	li	$2,-1840709632			# 0x92490000
	.set	macro
	.set	reorder

	lw	$2,20($18)
	lw	$4,24($18)
	lhu	$3,64($18)
	subu	$2,$2,$4
	slt	$3,$3,$2
	bne	$3,$0,$L75
	lhu	$3,54($18)
	lhu	$2,56($18)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L77
	sltu	$2,$3,2
	.set	macro
	.set	reorder

	beq	$2,$0,$L78
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L84
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$18
$L80:
	lw	$2,72($17)
	addu	$17,$17,4
	lhu	$4,62($18)
	lhu	$5,60($18)
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxzerospu
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	beq	$2,$0,$L84
	j	$L80
$L78:
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L84
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L86:
	#.set	volatile
	lw	$2,72($4)
	#.set	novolatile
	#nop
	sb	$22,1($2)
	lhu	$2,68($18)
	#.set	volatile
	lw	$3,72($4)
	#.set	novolatile
	addu	$16,$16,1
	addu	$2,$2,$3
	sb	$22,-15($2)
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L86
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L84:
	lhu	$2,62($18)
	#nop
	bne	$2,$0,$L90
	lhu	$2,54($18)
	#nop
	addu	$2,$2,1
	sh	$2,54($18)
$L90:
	.set	noreorder
	.set	nomacro
	j	$L91
	sh	$0,60($18)
	.set	macro
	.set	reorder

$L61:
	lw	$3,24($sp)
	ori	$2,$2,0x2493
	sll	$3,$3,2
	mult	$3,$2
	sh	$0,54($18)
	sh	$0,50($18)
	mfhi	$8
	#nop
	#nop
	addu	$2,$8,$3
	sra	$2,$2,2
	sra	$3,$3,31
	subu	$2,$2,$3
	sh	$2,52($18)
	sh	$2,48($18)
	lhu	$2,52($18)
$L120:
	lhu	$3,60($18)
	#nop
	sltu	$2,$2,$3
	beq	$2,$0,$L92
	lhu	$19,52($18)
	j	$L93
$L92:
	lhu	$19,60($18)
$L93:
	lw	$2,44($18)
	sll	$4,$21,1
	addu	$4,$4,$2
	sll	$2,$19,3
	subu	$2,$2,$19
	lhu	$3,0($4)
	sra	$2,$2,2
	addu	$3,$3,$2
	sh	$3,0($4)
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L94
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$18
$L95:
	lhu	$2,48($18)
	#nop
	mult	$2,$16
	move	$6,$19
	lw	$3,72($17)
	addu	$17,$17,4
	lhu	$5,62($18)
	lw	$4,36($18)
	lhu	$2,50($18)
	addu	$5,$3,$5
	addu	$4,$4,$2
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$4,$8
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L95
$L94:
	lhu	$2,62($18)
	lhu	$3,50($18)
	addu	$2,$2,$19
	sh	$2,62($18)
	lhu	$2,60($18)
	addu	$3,$3,$19
	sh	$3,50($18)
	subu	$2,$2,$19
	sh	$2,60($18)
	lhu	$2,52($18)
	#.set	volatile
	lhu	$3,60($18)
	#.set	novolatile
	subu	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L52
	sh	$2,52($18)
	.set	macro
	.set	reorder

	.def	queue_dma;	.val	$L91;	.scl	6;	.type	0x0;	.endef
$L91:
	bne	$21,$0,$L100
	lbu	$2,31($20)
	#nop
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L106
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L102:
	lw	$2,72($4)
	#nop
	#.set	volatile
	lbu	$3,1($2)
	#.set	novolatile
	addu	$4,$4,4
	ori	$3,$3,0x0004
	#.set	volatile
	sb	$3,1($2)
	#.set	novolatile
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	beq	$2,$0,$L106
	j	$L102
$L100:
	lhu	$2,56($18)
	#nop
	addu	$2,$2,-1
	bne	$21,$2,$L106
	lbu	$2,31($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L106
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L109:
	lhu	$3,68($18)
	lw	$2,72($4)
	#nop
	addu	$3,$3,$2
	#.set	volatile
	lbu	$2,-15($3)
	#.set	novolatile
	addu	$4,$4,4
	ori	$2,$2,0x0001
	#.set	volatile
	sb	$2,-15($3)
	#.set	novolatile
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L109
$L106:
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L77
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$18
$L114:
	lw	$2,8($18)
	#nop
	mult	$2,$16
	move	$4,$0
	lw	$3,0($18)
	lbu	$2,67($18)
	lhu	$6,68($18)
	sll	$2,$21,$2
	addu	$3,$3,$2
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L117
	addu	$5,$3,$8
	.set	macro
	.set	reorder

	sltu	$4,$16,1
$L117:
	sw	$4,16($sp)
	lw	$4,72($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	iSNDdmqueue
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,32($18)
	#.set	volatile
	lbu	$2,31($20)
	#.set	novolatile
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L114
	.def	advance;	.val	$L77;	.scl	6;	.type	0x0;	.endef
$L77:
	lhu	$3,70($18)
	lw	$2,20($18)
	sh	$21,58($18)
	addu	$2,$2,$3
	sw	$2,20($18)
	.def	function_exit;	.val	$L75;	.scl	6;	.type	0x0;	.endef
$L75:
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
LM6:
	.end	iSNDfillspuwithpackets
	.def	iSNDpacketserve;	.val	iSNDpacketserve;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpacketserve
iSNDpacketserve:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamhotroddatachunks
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$18,$0
	lui	$2,%hi(sndpd) # high
	addiu	$20,$2,%lo(sndpd) # low
	addu	$21,$20,216
	li	$19,-1879048192			# 0x90000000
	sll	$2,$18,2
$L135:
	addu	$2,$2,$20
	lw	$16,1272($2)
	#nop
	beq	$16,$0,$L126
	lb	$4,66($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L126
	li	$3,-1840709632			# 0x92490000
	.set	macro
	.set	reorder

	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$21
	lw	$2,12($2)
	ori	$3,$3,0x2493
	srl	$17,$2,12
	mult	$17,$3
	lw	$6,28($16)
	sra	$3,$17,31
	mfhi	$7
	#nop
	#nop
	addu	$2,$7,$17
	sra	$2,$2,4
	subu	$17,$2,$3
	sll	$2,$17,3
	subu	$2,$2,$17
	sll	$17,$2,2
	slt	$2,$17,$6
	bne	$2,$0,$L128
	.set	noreorder
	.set	nomacro
	j	$L129
	subu	$6,$17,$6
	.set	macro
	.set	reorder

	.def	wrapped_position;	.val	$L128;	.scl	6;	.type	0x0;	.endef
$L128:
	lw	$2,12($16)
	#nop
	addu	$2,$17,$2
	subu	$6,$2,$6
	.def	have_advance;	.val	$L129;	.scl	6;	.type	0x0;	.endef
$L129:
	li	$2,1895759872			# 0x70ff0000
	lw	$4,24($16)
	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L130
	addu	$2,$4,$19
	.set	macro
	.set	reorder

	lw	$3,20($16)
	sw	$2,24($16)
	addu	$3,$3,$19
	sw	$3,20($16)
$L130:
	move	$4,$18
	lw	$2,24($16)
	lw	$5,28($16)
	addu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	jal	iSNDpacketpurgeframes
	sw	$2,24($16)
	.set	macro
	.set	reorder

	lw	$2,20($16)
	lw	$3,24($16)
	lw	$4,16($16)
	subu	$2,$2,$3
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L126
	sw	$17,28($16)
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$4,32($16)
	#.set	novolatile
	jal	iSNDdmcomplete
	beq	$2,$0,$L126
	lhu	$5,58($16)
	lhu	$3,56($16)
	addu	$5,$5,1
	slt	$2,$5,$3
	bne	$2,$0,$L133
	subu	$5,$5,$3
$L133:
	.set	noreorder
	.set	nomacro
	jal	iSNDfillspuwithpackets
	move	$4,$18
	.set	macro
	.set	reorder

$L126:
	addu	$18,$18,1
	.set	noreorder
	.set	nomacro
	blez	$18,$L135
	sll	$2,$18,2
	.set	macro
	.set	reorder

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
LM7:
	.end	iSNDpacketserve
	.def	iSNDplatformpacketoverhead;	.val	iSNDplatformpacketoverhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformpacketoverhead
iSNDplatformpacketoverhead:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,sndpsxlimits+16
	#nop
	bgez	$2,$L137
	addu	$2,$2,4095
$L137:
	sra	$2,$2,12
	addu	$2,$2,3
	li	$3,-4			# 0xfffffffc
	and	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,4176
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSNDplatformpacketoverhead
	.def	iSNDplatformcalcdatarate;	.val	iSNDplatformcalcdatarate;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformcalcdatarate
iSNDplatformcalcdatarate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	sample_rate;	.val	4;	.scl	17;	.type	0x1d;	.endef
	lhu	$3,0($4)
	lbu	$2,2($4)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	sll	$2,$3,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,8
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSNDplatformcalcdatarate
	.def	iSNDplatformpacketplaycreate;	.val	iSNDplatformpacketplaycreate;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformpacketplaycreate
iSNDplatformpacketplaycreate:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	mem;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$5
	lui	$2,%hi(sndpd) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(sndpd) # low
	lui	$2,%hi(iSNDpsxpacketstop) # high
	addiu	$2,$2,%lo(iSNDpsxpacketstop) # low
	sw	$31,32($sp)
	sw	$16,16($sp)
	sw	$2,1828($18)
	li	$2,-1			# 0xffffffff
	sb	$2,66($17)
	addu	$2,$17,4176
	la	$16,sndpsxlimits
	sw	$2,44($17)
	lw	$4,16($16)
	jal	iSNDpsxmalloc
	sw	$2,0($17)
	lw	$2,16($16)
	lw	$3,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L140
	sw	$2,4($17)
	.set	macro
	.set	reorder

	sll	$2,$19,2
	addu	$2,$2,$18
	sw	$17,1272($2)
	.set	noreorder
	.set	nomacro
	j	$L141
	move	$2,$0
	.set	macro
	.set	reorder

$L140:
	li	$2,-9			# 0xfffffff7
$L141:
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
LM10:
	.end	iSNDplatformpacketplaycreate
	.def	iSNDplatformpacketplaydestroy;	.val	iSNDplatformpacketplaydestroy;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDplatformpacketplaydestroy
iSNDplatformpacketplaydestroy:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lui	$2,%hi(sndpd) # high
	addiu	$2,$2,%lo(sndpd) # low
	sw	$16,16($sp)
	sll	$16,$4,2
	addu	$16,$16,$2
	sw	$31,20($sp)
	lw	$2,1272($16)
	#nop
	lw	$4,0($2)
	jal	iSNDpsxfree
	sw	$0,1272($16)
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
LM11:
	.end	iSNDplatformpacketplaydestroy
	.def	iSNDplatformpacketplay;	.val	iSNDplatformpacketplay;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformpacketplay
iSNDplatformpacketplay:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	note;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	volAngle;	.val	6;	.scl	17;	.type	0xd;	.endef
	.def	level;	.val	7;	.scl	17;	.type	0xc;	.endef
	.def	pitch;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	a6;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	fxlevel;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	hdr;	.val	28;	.scl	9;	.type	0x1d;	.endef
	.def	hdr;	.val	21;	.scl	4;	.type	0x1d;	.endef
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	lui	$3,%hi(sndpd) # high
	addiu	$3,$3,%lo(sndpd) # low
	sll	$4,$20,2
	addu	$4,$4,$3
	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,2
	subu	$2,$2,$19
	lw	$5,72($sp)
	sll	$2,$2,2
	sw	$21,36($sp)
	lw	$21,76($sp)
	addu	$3,$3,216
	sw	$18,24($sp)
	addu	$18,$2,$3
	sw	$31,40($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,1272($4)
	li	$2,-1			# 0xffffffff
	sb	$0,33($18)
	sb	$2,32($18)
	sb	$0,30($18)
	lbu	$2,2($21)
	#nop
	#.set	volatile
	sb	$2,31($18)
	#.set	novolatile
	#.set	volatile
	sw	$0,4($18)
	#.set	novolatile
	#.set	volatile
	sh	$6,24($18)
	#.set	novolatile
	#.set	volatile
	sb	$7,34($18)
	#.set	novolatile
	#.set	volatile
	sb	$5,35($18)
	#.set	novolatile
	lw	$2,0($16)
	#nop
	#.set	volatile
	sw	$2,0($18)
	#.set	novolatile
	#.set	volatile
	sb	$20,39($18)
	#.set	novolatile
	#.set	volatile
	lbu	$3,31($18)
	#.set	novolatile
	li	$2,4096			# 0x00001000
	div	$2,$2,$3
	sh	$2,68($16)
	andi	$3,$2,0xffff
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	bgez	$2,$L144
	addu	$2,$2,15
$L144:
	sra	$2,$2,4
	sh	$2,70($16)
	lbu	$4,31($18)
	addu	$2,$16,80
	sw	$2,72($16)
	li	$2,13			# 0x0000000d
	lhu	$3,68($16)
	subu	$2,$2,$4
	addu	$3,$3,80
	sb	$2,67($16)
	andi	$4,$2,0x00ff
	lw	$2,4($16)
	addu	$3,$16,$3
	sw	$3,76($16)
	sra	$2,$2,$4
	sh	$2,56($16)
	andi	$3,$2,0xffff
	#.set	volatile
	lbu	$2,31($18)
	#.set	novolatile
	#nop
	div	$3,$3,$2
	lhu	$5,70($16)
	lhu	$2,70($16)
	sh	$3,56($16)
	andi	$4,$3,0xffff
	mult	$4,$2
	#.set	volatile
	lhu	$3,70($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,56($16)
	#.set	novolatile
	sh	$3,64($16)
	lbu	$3,67($16)
	move	$17,$0
	sb	$19,66($16)
	sh	$0,54($16)
	sh	$0,48($16)
	sh	$0,52($16)
	sh	$0,50($16)
	sh	$0,60($16)
	sw	$0,36($16)
	sw	$0,32($16)
	sw	$0,28($16)
	sw	$0,24($16)
	sw	$0,20($16)
	sll	$2,$2,$3
	sw	$2,8($16)
	mflo	$4
	#nop
	#nop
	sw	$4,12($16)
	subu	$4,$4,$5
	sw	$4,16($16)
$L148:
	lw	$4,32($16)
	jal	iSNDdmcomplete
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L148
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDfillspuwithpackets
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$17,$17,1
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L148
	lui	$2,%hi(sndpd) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(sndpd) # low
	lui	$2,%hi(iSNDpacketserve) # high
	addiu	$2,$2,%lo(iSNDpacketserve) # low
	sw	$2,1824($4)
	lui	$2,%hi(iSNDpacketsetirq) # high
	addiu	$2,$2,%lo(iSNDpacketsetirq) # low
	sw	$2,1832($4)
	sw	$0,12($18)
	sw	$0,16($18)
	lw	$2,12($16)
	#nop
	sll	$2,$2,12
	sw	$2,20($18)
	lhu	$3,0($21)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,5
	subu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$2,$3
	sra	$2,$2,16
	#.set	volatile
	sh	$2,26($18)
	#.set	novolatile
	#.set	volatile
	lbu	$2,31($18)
	#.set	novolatile
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L152
	lui	$3,%hi(sndgs+148) # high
	.set	macro
	.set	reorder

	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,3
	addu	$2,$2,$19
	lw	$3,%lo(sndgs+148)($3)
	sll	$2,$2,2
	addu	$2,$2,$3
	lbu	$2,4($2)
	#nop
	#.set	volatile
	sb	$2,32($18)
	#.set	novolatile
	#.set	volatile
	lbu	$3,32($18)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	li	$3,1			# 0x00000001
	sb	$3,249($2)
	#.set	volatile
	lbu	$3,32($18)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	sw	$0,228($2)
	#.set	volatile
	lbu	$3,32($18)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	sw	$0,232($2)
	#.set	volatile
	lbu	$3,32($18)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,20($18)
	addu	$2,$2,$4
	sw	$3,236($2)
$L152:
	lw	$5,64($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpitch
	move	$4,$19
	.set	macro
	.set	reorder

 #APP
	mfc0 $16,$12
	nop
	li $1,-0x402
	and $8,$16,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	jal	iSNDpacketsetirq
 #APP
	mtc0 $16,$12
 #NO_APP
	li	$2,1			# 0x00000001
	sb	$2,28($18)
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM12:
	.end	iSNDplatformpacketplay
	.def	iSNDpsxpacketstop;	.val	iSNDpsxpacketstop;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpsxpacketstop
iSNDpsxpacketstop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	parg;	.val	4;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,24
	move	$5,$0
	lui	$3,%hi(sndpd) # high
	sw	$31,20($sp)
	sw	$16,16($sp)
	lbu	$2,39($4)
	addiu	$7,$3,%lo(sndpd) # low
	sll	$2,$2,24
	sra	$2,$2,22
	addu	$2,$2,$7
	lw	$3,1272($2)
	li	$2,-1			# 0xffffffff
	sb	$2,66($3)
	sb	$2,39($4)
	lbu	$2,D_80147871
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L155
	move	$4,$5
	.set	macro
	.set	reorder

	move	$6,$2
	move	$3,$7
$L156:
	lbu	$2,255($3)
	#nop
	sll	$2,$2,24
	bltz	$2,$L159
	addu	$4,$4,1
$L159:
	addu	$5,$5,1
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L156
	addu	$3,$3,44
	.set	macro
	.set	reorder

$L155:
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L161
	lui	$3,%hi(sndpd) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(sndpd) # low
	lui	$2,%hi(iSNDpacketsetirq) # high
	addiu	$2,$2,%lo(iSNDpacketsetirq) # low
	sw	$0,1824($3)
	sw	$2,1832($3)
$L161:
 #APP
	mfc0 $16,$12
	nop
	li $1,-0x402
	and $8,$16,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	jal	iSNDpacketsetirq
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
LM13:
	.end	iSNDpsxpacketstop
	.def	snd_voice_done_hook;	.val	snd_voice_done_hook;	.scl	2;	.type	0x91;	.endef
	.def	snd_user_serve_hook;	.val	snd_user_serve_hook;	.scl	2;	.type	0x11;	.endef
