	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sserver.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDserver
	.align	2
	.globl	iSND100hzserver
	.align	2
	.globl	iSNDenteraudio
	.align	2
	.globl	iSNDleaveaudio
	.align	2
	.globl	iSNDserveradd100hzclient
	.align	2
	.globl	iSNDserverremove100hzclient

	.comm	request,4

	.text
	.def	iSNDserver;	.val	iSNDserver;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDserver
iSNDserver:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	addiu	$4,$2,%lo(sndgs) # low
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	#.set	volatile
	lbu	$2,62($4)
	#.set	novolatile
	#nop
	bne	$2,$0,$L1
	lbu	$2,63($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,178($4)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sh	$2,178($4)
	#.set	novolatile
	j	$L1
$L3:
	lui	$3,%hi(timerhz) # high
	#.set	volatile
	sb	$2,62($4)
	#.set	novolatile
	#.set	volatile
	lhu	$2,176($4)
	#.set	novolatile
	lw	$5,%lo(timerhz)($3)
	sll	$2,$2,16
	sra	$2,$2,16
	beq	$5,$2,$L4
	lhu	$2,%lo(timerhz)($3)
	#nop
	#.set	volatile
	sh	$2,176($4)
	#.set	novolatile
	#.set	volatile
	sw	$0,68($4)
	#.set	novolatile
	#.set	volatile
	sw	$0,172($4)
	#.set	novolatile
$L4:
	#.set	volatile
	lw	$2,172($4)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,172($4)
	#.set	novolatile
	#.set	volatile
	lw	$3,172($4)
	#.set	novolatile
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,2
	divu	$17,$2,$5
	lw	$2,68($4)
	#nop
	sltu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

	move	$16,$4
$L6:
	lw	$2,72($16)
	#nop
	jal	$31,$2
	lw	$2,68($16)
	#nop
	sltu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	lui	$2,%hi(sndgs) # high
	.set	macro
	.set	reorder

$L10:
	addiu	$2,$2,%lo(sndgs) # low
	#.set	volatile
	sb	$0,62($2)
	#.set	novolatile
$L1:
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
	.end	iSNDserver
	.def	iSND100hzserver;	.val	iSND100hzserver;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSND100hzserver
iSND100hzserver:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi(sndgs) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sndgs) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	#.set	volatile
	lw	$2,68($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,68($16)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	iSNDserve
	move	$17,$0
	.set	macro
	.set	reorder

	lb	$2,64($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L12
	move	$18,$16
	.set	macro
	.set	reorder

$L13:
	lw	$2,76($16)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lb	$2,64($18)
	addu	$17,$17,1
	slt	$2,$17,$2
	bne	$2,$0,$L13
$L12:
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lbu	$2,17($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	move	$17,$0
	.set	macro
	.set	reorder

	move	$19,$3
	move	$18,$17
$L18:
	lw	$2,148($19)
	#nop
	addu	$16,$2,$18
	lb	$3,11($16)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L32
	lw	$2,0($16)
	#nop
	bltz	$2,$L32
	lw	$2,84($16)
	#nop
	beq	$2,$0,$L22
	lbu	$2,59($16)
	lbu	$3,57($16)
	addu	$2,$2,1
	sb	$2,59($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	bne	$2,$0,$L23
	sb	$0,59($16)
$L23:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcpitch
	sh	$0,94($16)
	.set	macro
	.set	reorder

	lhu	$5,98($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformpitch
	move	$4,$17
	.set	macro
	.set	reorder

$L22:
	lw	$2,80($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	move	$5,$0
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	lbu	$2,58($16)
	lbu	$3,56($16)
	addu	$2,$2,$5
	sb	$2,58($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	bne	$2,$0,$L24
	sb	$0,58($16)
$L24:
	lw	$4,20($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L26
	move	$3,$4
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	lw	$2,28($16)
	#nop
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bgez	$3,$L27
	sw	$2,28($16)
	.set	macro
	.set	reorder

	lw	$3,24($16)
	.set	noreorder
	.set	nomacro
	j	$L41
	slt	$2,$3,$2
	.set	macro
	.set	reorder

$L27:
	lw	$3,24($16)
	#nop
	slt	$2,$2,$3
$L41:
	bne	$2,$0,$L29
	sw	$3,28($16)
	sw	$0,20($16)
$L29:
	lw	$2,28($16)
	#nop
	bltz	$2,$L42
$L26:
	lw	$3,32($16)
	#nop
	beq	$3,$0,$L33
	lw	$2,36($16)
	li	$5,1			# 0x00000001
	addu	$2,$2,$3
	sw	$2,36($16)
$L33:
	lw	$2,40($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L44
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lbu	$2,49($16)
	lb	$3,48($16)
	addu	$2,$2,1
	sb	$2,49($16)
	sll	$2,$2,24
	sra	$4,$2,24
	slt	$3,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L35
	sll	$3,$4,3
	.set	macro
	.set	reorder

$L42:
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	SNDstop
	addu	$18,$18,100
	.set	macro
	.set	reorder

	j	$L43
$L35:
	lw	$2,64($16)
	#nop
	addu	$3,$2,$3
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L37
	sw	$2,40($16)
	.set	macro
	.set	reorder

	li	$2,2147418112			# 0x7fff0000
	ori	$2,$2,0xffff
	sw	$2,40($16)
$L37:
	lw	$2,4($3)
	lw	$4,36($16)
	lw	$3,40($16)
	sll	$2,$2,16
	subu	$2,$2,$4
	div	$2,$2,$3
	sw	$2,32($16)
	lw	$2,40($16)
	#nop
	addu	$2,$2,-1
$L44:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L32
	sw	$2,40($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDcalcvol
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	bltz	$2,$L32
	lb	$5,45($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDvol
	move	$4,$17
	.set	macro
	.set	reorder

	.def	next_chan;	.val	$L32;	.scl	6;	.type	0x0;	.endef
$L32:
	addu	$18,$18,100
$L43:
	lbu	$2,17($19)
	addu	$17,$17,1
	slt	$2,$17,$2
	bne	$2,$0,$L18
$L17:
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
LM2:
	.end	iSND100hzserver
	.def	iSNDenteraudio;	.val	iSNDenteraudio;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDenteraudio
iSNDenteraudio:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	SNDI_mutexlock
	lui	$3,%hi(sndgs) # high
	addiu	$3,$3,%lo(sndgs) # low
	lbu	$2,63($3)
	#nop
	addu	$2,$2,1
	sb	$2,63($3)
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
	.end	iSNDenteraudio
	.def	iSNDleaveaudio;	.val	iSNDleaveaudio;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDleaveaudio
iSNDleaveaudio:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(sndgs) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sndgs) # low
	sw	$31,20($sp)
	#.set	volatile
	lbu	$2,63($16)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sb	$2,63($16)
	#.set	novolatile
	jal	SNDI_mutexunlock
	#.set	volatile
	lbu	$2,63($16)
	#.set	novolatile
	#nop
	bne	$2,$0,$L47
	#.set	volatile
	lhu	$2,178($16)
	#.set	novolatile
	#nop
	beq	$2,$0,$L47
$L50:
	#.set	volatile
	lhu	$2,178($16)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sh	$2,178($16)
	#.set	novolatile
	jal	iSNDserver
	#.set	volatile
	lhu	$2,178($16)
	#.set	novolatile
	#nop
	bne	$2,$0,$L50
$L47:
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
	.end	iSNDleaveaudio
	.def	iSNDserveradd100hzclient;	.val	iSNDserveradd100hzclient;	.scl	2;	.type	0x63;	.endef
	.text
	.ent	iSNDserveradd100hzclient
iSNDserveradd100hzclient:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	cb;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs) # high
	addiu	$2,$2,%lo(sndgs) # low
	lb	$3,64($2)
	#nop
	sll	$3,$3,2
	addu	$3,$3,$2
	sw	$4,76($3)
	lbu	$3,64($2)
	#nop
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$3,64($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM5:
	.end	iSNDserveradd100hzclient
	.def	iSNDserverremove100hzclient;	.val	iSNDserverremove100hzclient;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDserverremove100hzclient
iSNDserverremove100hzclient:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	cb;	.val	4;	.scl	17;	.type	0x4;	.endef
	move	$6,$4
 #APP
 #NO_APP
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lb	$2,64($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L64
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$3
	sll	$2,$4,2
$L62:
	addu	$2,$2,$5
	lw	$2,76($2)
	#nop
	bne	$2,$6,$L56
	lbu	$2,64($5)
	#nop
	addu	$2,$2,-1
	sb	$2,64($5)
	sll	$2,$2,24
	sra	$2,$2,24
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L64
	sll	$3,$4,2
	.set	macro
	.set	reorder

$L61:
	addu	$4,$4,1
	sll	$2,$4,2
	addu	$2,$2,$5
	lw	$2,76($2)
	addu	$3,$3,$5
	sw	$2,76($3)
	lb	$2,64($5)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L61
	sll	$3,$4,2
	.set	macro
	.set	reorder

$L64:
	j	$31
$L56:
	lb	$2,64($5)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L62
	sll	$2,$4,2
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM6:
	.end	iSNDserverremove100hzclient
	.def	request;	.val	request;	.scl	2;	.type	0x4;	.endef
