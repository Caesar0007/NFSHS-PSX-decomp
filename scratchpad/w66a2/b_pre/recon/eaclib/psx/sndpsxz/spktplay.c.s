	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spktplay.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndpps
	.section	.bss
	.align	2
sndpps:
	.space	4
	.text
	.text
 #NO_APP
	.align	2
	.globl	iSNDpacketplayoverhead
	.align	2
	.globl	SNDPKTPLAY_overhead
	.align	2
	.globl	SNDPKTPLAY_create
	.align	2
	.globl	SNDPKTPLAY_start
	.align	2
	.globl	SNDPKTPLAY_submit
	.align	2
	.globl	SNDPKTPLAY_submitspace
	.align	2
	.globl	SNDPKTPLAY_unsafeframesoutstanding
	.align	2
	.globl	SNDPKTPLAY_framesoutstanding
	.align	2
	.globl	SNDPKTPLAY_purge
	.align	2
	.globl	SNDPKTPLAY_stop
	.align	2
	.globl	SNDPKTPLAY_destroy
	.align	2
	.globl	iSNDpacketget
	.align	2
	.globl	iSNDpacketfreeframes

	.comm	iSNDplatformrate,4

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	24;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	6;	.size	24;	.type	0x34;	.endef
	.def	.eos;	.val	24;	.scl	102;	.tag	.0fake;	.size	24;	.endef
	.def	PktCopy6;	.scl	13;	.tag	.0fake;	.size	24;	.type	0x8;	.endef
	.def	.1fake;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	4;	.size	16;	.type	0x34;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	.1fake;	.size	16;	.endef
	.def	PktCopy4;	.scl	13;	.tag	.1fake;	.size	16;	.type	0x8;	.endef
	.def	.2fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	2;	.size	8;	.type	0x34;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.2fake;	.size	8;	.endef
	.def	PktCopy2;	.scl	13;	.tag	.2fake;	.size	8;	.type	0x8;	.endef
	.def	.3fake;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	b;	.val	0;	.scl	8;	.dim	4;	.size	4;	.type	0x32;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	.3fake;	.size	4;	.endef
	.def	Unal4;	.scl	13;	.tag	.3fake;	.size	4;	.type	0x8;	.endef
	.def	iSNDpacketplayoverhead;	.val	iSNDpacketplayoverhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpacketplayoverhead
iSNDpacketplayoverhead:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	n;	.val	4;	.scl	17;	.type	0x4;	.endef
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,64
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDpacketplayoverhead
	.def	SNDPKTPLAY_overhead;	.val	SNDPKTPLAY_overhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_overhead
SNDPKTPLAY_overhead:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	n;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDpacketplayoverhead
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpacketoverhead
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$2,$16,$2
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
	.end	SNDPKTPLAY_overhead
	.def	SNDPKTPLAY_create;	.val	SNDPKTPLAY_create;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_create
SNDPKTPLAY_create:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	mem;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	relcb;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	notifycb;	.val	22;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$22,40($sp)
	move	$22,$7
	sw	$31,44($sp)
	sw	$20,32($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L17
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L4:
	move	$17,$0
	lui	$2,%hi(sndpps) # high
	addiu	$3,$2,%lo(sndpps) # low
$L8:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	sll	$20,$17,2
	.set	macro
	.set	reorder

	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	blez	$17,$L8
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L17
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

	.def	found;	.val	$L10;	.scl	6;	.type	0x0;	.endef
$L10:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpacketplaycreate
	move	$5,$18
	.set	macro
	.set	reorder

	bltz	$2,$L12
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpacketoverhead
	move	$16,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpacketoverhead
	addu	$18,$18,$2
	.set	macro
	.set	reorder

	subu	$19,$19,$2
	addu	$3,$19,-64
	li	$2,-1431655765			# 0xaaaaaaab
	multu	$3,$2
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	addu	$3,$20,$3
	sw	$18,0($3)
	sw	$16,24($18)
	sw	$21,28($18)
	sw	$22,32($18)
	mfhi	$8
	#nop
	#nop
	srl	$3,$8,4
	#.set	volatile
	sh	$3,8($18)
	#.set	novolatile
	li	$3,-1			# 0xffffffff
	#.set	volatile
	sw	$3,0($18)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L17
	move	$2,$17
	.set	macro
	.set	reorder

$L12:
	li	$2,-6			# 0xfffffffa
$L17:
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
LM3:
	.end	SNDPKTPLAY_create
	.def	SNDPKTPLAY_start;	.val	SNDPKTPLAY_start;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_start
SNDPKTPLAY_start:
	.frame	$sp,88,$31		# vars= 8, regs= 9/0, args= 40, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	p;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	rate;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	hdr;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	params;	.val	20;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,88
	sw	$23,76($sp)
	move	$23,$4
	sw	$22,72($sp)
	move	$22,$5
	sw	$21,68($sp)
	move	$21,$6
	lui	$2,%hi(sndgs) # high
	sw	$19,60($sp)
	addiu	$19,$2,%lo(sndgs) # low
	sw	$31,80($sp)
	sw	$20,64($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	lb	$2,60($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	move	$20,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L28
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L19:
	lui	$2,%hi(sndpps) # high
	addiu	$2,$2,%lo(sndpps) # low
	sll	$3,$23,2
	addu	$3,$3,$2
	lbu	$16,2($22)
	lw	$17,0($3)
	jal	iSNDenteraudio
	addu	$7,$sp,40
	lw	$4,0($21)
	lb	$6,6($21)
	.set	noreorder
	.set	nomacro
	jal	iSNDallocchan
	move	$5,$16
	.set	macro
	.set	reorder

	move	$18,$2
	bgez	$18,$L20
	jal	iSNDleaveaudio
	.set	noreorder
	.set	nomacro
	j	$L28
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

$L20:
	lw	$2,40($sp)
	#nop
	#.set	volatile
	sw	$2,0($17)
	#.set	novolatile
	li	$2,-1			# 0xffffffff
	#.set	volatile
	sh	$0,10($17)
	#.set	novolatile
	#.set	volatile
	sh	$0,14($17)
	#.set	novolatile
	#.set	volatile
	sw	$0,16($17)
	#.set	novolatile
	#.set	volatile
	sw	$0,4($17)
	#.set	novolatile
	#.set	volatile
	sw	$0,20($17)
	#.set	novolatile
	#.set	volatile
	sh	$2,12($17)
	#.set	novolatile
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,3
	addu	$2,$2,$18
	sll	$2,$2,2
	lwl	$8,3($22)
	lwr	$8,0($22)
	swl	$8,39($17)
	swr	$8,36($17)
	lw	$3,148($19)
	lb	$4,11($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L25
	addu	$16,$3,$2
	.set	macro
	.set	reorder

	lhu	$19,16($20)
	.set	noreorder
	.set	nomacro
	j	$L29
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L25:
	lb	$2,7($20)
	#nop
	addu	$19,$2,-64
	sll	$19,$19,8
	andi	$19,$19,0xffff
	li	$2,-1			# 0xffffffff
$L29:
	sb	$2,10($16)
	lhu	$2,4($21)
	li	$4,2147418112			# 0x7fff0000
	sh	$2,92($16)
	lhu	$2,12($20)
	ori	$4,$4,0xffff
	sw	$0,20($16)
	sh	$2,96($16)
	lb	$3,8($20)
	li	$2,8323072			# 0x007f0000
	sw	$0,32($16)
	sw	$4,40($16)
	sw	$2,36($16)
	sll	$3,$3,16
	sw	$3,28($16)
	lbu	$2,7($21)
	#nop
	sb	$2,44($16)
	lbu	$2,8($21)
	#nop
	sb	$2,46($16)
	lbu	$3,9($20)
	li	$2,1			# 0x00000001
	sb	$2,48($16)
	sb	$0,49($16)
	sb	$0,50($16)
	sb	$2,51($16)
	sb	$3,47($16)
	lbu	$2,9($21)
	#nop
	sb	$2,52($16)
	lbu	$2,10($20)
	#nop
	sb	$2,53($16)
	lb	$3,10($21)
	sb	$0,55($16)
	sb	$0,54($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	sh	$2,90($16)
	lbu	$2,7($20)
	move	$4,$18
	sw	$0,64($16)
	sw	$0,68($16)
	sb	$2,61($16)
	sw	$0,72($16)
	sw	$0,76($16)
	sw	$0,80($16)
	sw	$0,84($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcpitch
	sh	$0,94($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDcalcvol
	move	$4,$18
	.set	macro
	.set	reorder

	lhu	$2,98($16)
	lb	$7,45($16)
	sw	$2,16($sp)
	lhu	$2,14($20)
	#nop
	sw	$2,20($sp)
	lui	$2,%hi(iSNDplatformrate) # high
	lb	$3,52($16)
	lw	$2,%lo(iSNDplatformrate)($2)
	#nop
	mult	$2,$3
	mflo	$12
	#nop
	lb	$3,53($16)
	#nop
	mult	$12,$3
	mflo	$3
	#nop
	li	$2,-2113536000			# 0x82060000
	ori	$2,$2,0x1029
	mult	$3,$2
	move	$4,$23
	move	$5,$18
	move	$6,$19
	sw	$22,28($sp)
	addu	$2,$21,12
	sw	$2,32($sp)
	mfhi	$12
	#nop
	#nop
	addu	$2,$12,$3
	sra	$2,$2,13
	sra	$3,$3,31
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpacketplay
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	bltz	$16,$L27
 #APP
 #NO_APP
	jal	iSNDleaveaudio
	lw	$2,0($17)
	j	$L28
$L27:
	.set	noreorder
	.set	nomacro
	jal	iSNDfreechan
	move	$4,$18
	.set	macro
	.set	reorder

	jal	iSNDleaveaudio
	move	$2,$16
$L28:
	lw	$31,80($sp)
	lw	$23,76($sp)
	lw	$22,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	SNDPKTPLAY_start
	.def	SNDPKTPLAY_submit;	.val	SNDPKTPLAY_submit;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_submit
SNDPKTPLAY_submit:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	frame;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L45
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L31:
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$16,0($2)
	jal	iSNDenteraudio
	#.set	volatile
	lhu	$3,14($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	sll	$3,$3,16
	sra	$3,$3,16
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$2,-1
	slt	$3,$3,$2
	bne	$3,$0,$L33
	.set	noreorder
	.set	nomacro
	j	$L34
	li	$17,-13			# 0xfffffff3
	.set	macro
	.set	reorder

	.def	room;	.val	$L33;	.scl	6;	.type	0x0;	.endef
$L33:
	#.set	volatile
	lhu	$4,10($16)
	#.set	novolatile
	#.set	volatile
	lhu	$3,14($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	sll	$4,$4,16
	sra	$4,$4,16
	sll	$3,$3,16
	sra	$3,$3,16
	addu	$4,$4,$3
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L46
	sll	$2,$4,1
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	sra	$2,$2,16
	subu	$4,$4,$2
	sll	$2,$4,1
$L46:
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,40
	lw	$3,4($17)
	addu	$4,$16,$2
	sw	$3,4($4)
	lw	$2,4($16)
	#nop
	sw	$2,0($4)
	lbu	$2,38($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	move	$3,$0
	.set	macro
	.set	reorder

	move	$5,$17
$L41:
	lw	$2,12($5)
	addu	$5,$5,4
	addu	$3,$3,1
	sw	$2,8($4)
	lbu	$2,38($16)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L41
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L36:
	lhu	$2,14($16)
	#nop
	addu	$2,$2,1
	sh	$2,14($16)
	lw	$2,16($16)
	lw	$3,4($17)
	#nop
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	#.set	volatile
	lw	$17,4($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,4($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	sw	$2,4($16)
	.def	leave;	.val	$L34;	.scl	6;	.type	0x0;	.endef
$L34:
	jal	iSNDleaveaudio
	move	$2,$17
$L45:
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
	.end	SNDPKTPLAY_submit
	.def	SNDPKTPLAY_submitspace;	.val	SNDPKTPLAY_submitspace;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_submitspace
SNDPKTPLAY_submitspace:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L48
	lui	$3,%hi(sndpps) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$3,0($2)
	#nop
	#.set	volatile
	lhu	$2,8($3)
	#.set	novolatile
	#.set	volatile
	lhu	$3,14($3)
	#.set	novolatile
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$3,$3,16
	sra	$3,$3,16
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L48:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	SNDPKTPLAY_submitspace
	.def	SNDPKTPLAY_unsafeframesoutstanding;	.val	SNDPKTPLAY_unsafeframesoutstanding;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_unsafeframesoutstanding
SNDPKTPLAY_unsafeframesoutstanding:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndpps) # high
	addiu	$2,$2,%lo(sndpps) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$2,0($4)
	#nop
	lw	$3,16($2)
	lw	$2,20($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	SNDPKTPLAY_unsafeframesoutstanding
	.def	SNDPKTPLAY_framesoutstanding;	.val	SNDPKTPLAY_framesoutstanding;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_framesoutstanding
SNDPKTPLAY_framesoutstanding:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	p;	.val	16;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_unsafeframesoutstanding
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDleaveaudio
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L53
	move	$2,$16
	.set	macro
	.set	reorder

$L52:
	li	$2,-10			# 0xfffffff6
$L53:
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
LM8:
	.end	SNDPKTPLAY_framesoutstanding
	.def	SNDPKTPLAY_purge;	.val	SNDPKTPLAY_purge;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_purge
SNDPKTPLAY_purge:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	lo;	.val	23;	.scl	17;	.type	0x4;	.endef
	.def	hi;	.val	30;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,56
	sw	$23,44($sp)
	move	$23,$5
	sw	$fp,48($sp)
	move	$fp,$6
	sw	$31,52($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L55
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L64
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L55:
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	jal	iSNDenteraudio
	move	$21,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,10($16)
	#.set	novolatile
	#.set	volatile
	lhu	$3,10($16)
	#.set	novolatile
	sll	$2,$2,16
	sra	$19,$2,16
	sll	$3,$3,16
	#.set	volatile
	lhu	$2,14($16)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	sra	$22,$2,16
	.set	noreorder
	.set	nomacro
	blez	$22,$L56
	sra	$18,$3,16
	.set	macro
	.set	reorder

	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,3
	addu	$20,$2,40
	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,3
	addu	$17,$2,$16
	addu	$4,$16,$20
$L66:
	lw	$3,0($4)
	#nop
	slt	$2,$3,$23
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L58
	slt	$2,$fp,$3
	.set	macro
	.set	reorder

	bne	$2,$0,$L58
	lhu	$2,14($16)
	#nop
	addu	$2,$2,-1
	sh	$2,14($16)
	lw	$2,16($16)
	lw	$3,4($4)
	lw	$5,28($16)
	subu	$2,$2,$3
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	beq	$5,$0,$L60
	lw	$4,8($4)
	.set	noreorder
	.set	nomacro
	jal	$31,$5
	addu	$20,$20,24
	.set	macro
	.set	reorder

	j	$L65
$L58:
	lw	$7,0($4)
	lw	$8,4($4)
	lw	$9,8($4)
	lw	$10,12($4)
	sw	$7,40($17)
	sw	$8,44($17)
	sw	$9,48($17)
	sw	$10,52($17)
	lw	$7,16($4)
	lw	$8,20($4)
	sw	$7,56($17)
	sw	$8,60($17)
	addu	$17,$17,24
	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	addu	$19,$19,1
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$19,$2
	bne	$2,$0,$L60
	move	$17,$16
	move	$19,$0
$L60:
	addu	$20,$20,24
$L65:
	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	addu	$18,$18,1
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$18,$2
	bne	$2,$0,$L62
	li	$20,40			# 0x00000028
	move	$18,$0
$L62:
	addu	$21,$21,1
	slt	$2,$21,$22
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	addu	$4,$16,$20
	.set	macro
	.set	reorder

$L56:
	jal	iSNDleaveaudio
	move	$2,$0
$L64:
	lw	$31,52($sp)
	lw	$fp,48($sp)
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
LM9:
	.end	SNDPKTPLAY_purge
	.def	SNDPKTPLAY_stop;	.val	SNDPKTPLAY_stop;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_stop
SNDPKTPLAY_stop:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	p;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L68
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L70
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L68:
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$16,0($2)
	jal	iSNDenteraudio
	lw	$4,0($16)
	jal	SNDstop
	move	$4,$17
	li	$6,2147418112			# 0x7fff0000
	ori	$6,$6,0xffff
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_purge
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$5,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L71
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,12($16)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$2,$L71
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$3,12($16)
	#.set	novolatile
	#nop
	sll	$3,$3,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$16
	lw	$4,48($2)
	jal	$31,$5
	li	$2,-1			# 0xffffffff
$L71:
	#.set	volatile
	sw	$2,0($16)
	#.set	novolatile
	jal	iSNDleaveaudio
	move	$2,$0
$L70:
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
LM10:
	.end	SNDPKTPLAY_stop
	.def	SNDPKTPLAY_destroy;	.val	SNDPKTPLAY_destroy;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDPKTPLAY_destroy
SNDPKTPLAY_destroy:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	p;	.val	16;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L73
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	iSNDplatformpacketplaydestroy
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$16,2
	addu	$2,$2,$3
	sw	$0,0($2)
	.set	noreorder
	.set	nomacro
	j	$L74
	move	$2,$0
	.set	macro
	.set	reorder

$L73:
	li	$2,-10			# 0xfffffff6
$L74:
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
	.end	SNDPKTPLAY_destroy
	.def	PacketFrame;	.scl	10;	.type	0x8;	.size	24;	.endef
	.def	reserved;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	size;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	channel;	.val	8;	.scl	8;	.dim	4;	.size	16;	.type	0x34;	.endef
	.def	.eos;	.val	24;	.scl	102;	.tag	PacketFrame;	.size	24;	.endef
	.def	iSNDpacketget;	.val	iSNDpacketget;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpacketget
iSNDpacketget:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	idx;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	out;	.val	18;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	lui	$2,%hi(sndpps) # high
	addiu	$2,$2,%lo(sndpps) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$16,0($4)
	#nop
	lbu	$3,38($16)
	addu	$2,$17,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L76
	move	$18,$6
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,12($16)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	bltz	$2,$L76
	#.set	volatile
	lhu	$2,12($16)
	#.set	novolatile
	li	$3,-1			# 0xffffffff
	#.set	volatile
	sh	$3,12($16)
	#.set	novolatile
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,40
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L76
	addu	$4,$16,$3
	.set	macro
	.set	reorder

	lw	$4,8($4)
	jal	$31,$2
$L76:
	lhu	$2,14($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L82
	move	$2,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$3,10($16)
	#.set	novolatile
	#nop
	sll	$3,$3,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,40
	addu	$4,$16,$2
	lw	$2,4($4)
	#nop
	sw	$2,0($18)
	lbu	$3,38($16)
	addu	$2,$17,1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L83
	sll	$2,$17,2
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,10($16)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,14($16)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sh	$2,14($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,10($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sh	$2,10($16)
	#.set	novolatile
	lw	$2,20($16)
	lw	$3,4($4)
	#nop
	addu	$2,$2,$3
	sw	$2,20($16)
	lw	$2,16($16)
	lw	$3,4($4)
	#nop
	subu	$2,$2,$3
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	#.set	volatile
	lhu	$3,10($16)
	#.set	novolatile
	#.set	volatile
	lhu	$2,8($16)
	#.set	novolatile
	sll	$3,$3,16
	sll	$2,$2,16
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L83
	sll	$2,$17,2
	.set	macro
	.set	reorder

	#.set	volatile
	sh	$0,10($16)
	#.set	novolatile
	sll	$2,$17,2
$L83:
	addu	$2,$4,$2
	lw	$2,8($2)
$L82:
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
LM12:
	.end	iSNDpacketget
	.def	iSNDpacketfreeframes;	.val	iSNDpacketfreeframes;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDpacketfreeframes
iSNDpacketfreeframes:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	p;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	idx;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	bytes;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lui	$3,%hi(sndpps) # high
	addiu	$3,$3,%lo(sndpps) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$31,16($sp)
	lw	$3,0($2)
	#nop
	lbu	$2,38($3)
	addu	$5,$5,1
	bne	$5,$2,$L88
	lw	$2,20($3)
	lw	$7,32($3)
	subu	$2,$2,$6
	#.set	volatile
	sw	$2,20($3)
	#.set	novolatile
	beq	$7,$0,$L88
	.set	noreorder
	.set	nomacro
	jal	$31,$7
	move	$5,$6
	.set	macro
	.set	reorder

$L88:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM13:
	.end	iSNDpacketfreeframes
	.def	iSNDplatformrate;	.val	iSNDplatformrate;	.scl	2;	.dim	1;	.size	4;	.type	0x34;	.endef
