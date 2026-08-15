	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\stream.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	validatehandle
	.align	2
	.globl	inbetween
	.align	2
	.globl	decbufferusage
	.align	2
	.globl	getfreerequest
	.align	2
	.globl	queuerequest
	.align	2
	.align	2
	.globl	freerequest
	.align	2
	.globl	filterchunk
	.align	2
	.globl	parsechunks
	.align	2
	.globl	opencallback
	.align	2
	.globl	closecallback
	.align	2
	.globl	readcallback
	.align	2
	.globl	startnextrequest
	.align	2
	.globl	restartstream
	.align	2
	.globl	STREAM_overhead
	.align	2
	.globl	STREAM_create
	.align	2
	.globl	STREAM_setfilter
	.align	2
	.globl	STREAM_destroy
	.align	2
	.globl	STREAM_setpriority
	.align	2
	.globl	STREAM_setgreedylevel
	.align	2
	.globl	STREAM_setgreedystate
	.align	2
	.globl	STREAM_queuefile
	.align	2
	.globl	STREAM_queuemem
	.align	2
	.globl	STREAM_cancelrequest
	.align	2
	.globl	STREAM_kill
	.align	2
	.globl	STREAM_get
	.align	2
	.globl	STREAM_release
	.align	2
	.globl	STREAM_gettable
	.align	2
	.globl	STREAM_state
	.align	2
	.globl	STREAM_isendofstream
	.align	2
	.globl	STREAM_buffersize
	.align	2
	.globl	STREAM_bufferusage

	.comm	requestidcounter,4

	.text
	.def	validatehandle;	.val	validatehandle;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	validatehandle
validatehandle:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	outObj;	.val	5;	.scl	17;	.type	0x14;	.endef
	.def	outHandle;	.val	6;	.scl	17;	.type	0x14;	.endef
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L4
	li	$3,1297219584			# 0x4d520000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L4:
	lw	$7,0($4)
	#nop
	lw	$2,0($7)
	ori	$3,$3,0x5453
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L5
	move	$2,$0
	.set	macro
	.set	reorder

	sw	$4,0($6)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$7,0($5)
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	validatehandle
	.def	inbetween;	.val	inbetween;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	inbetween
inbetween:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	b;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	c;	.val	6;	.scl	17;	.type	0xe;	.endef
	sltu	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	sltu	$2,$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	move	$3,$0
	.set	macro
	.set	reorder

	sltu	$3,$6,$5
$L9:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	move	$3,$0
	.set	macro
	.set	reorder

	sltu	$2,$6,$5
	beq	$2,$0,$L11
$L14:
	li	$3,1			# 0x00000001
$L11:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	inbetween
	.def	decbufferusage;	.val	decbufferusage;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	decbufferusage
decbufferusage:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	amount;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	move	$6,$4
	sw	$31,16($sp)
 #APP
	mfc0 $3,$12
	nop
	li $1,-0x402
	and $8,$3,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,60($6)
	#nop
	subu	$4,$2,$5
	sw	$4,60($6)
 #APP
	mtc0 $3,$12
 #NO_APP
	lw	$3,52($6)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L15
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,40($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L15
	sw	$2,56($6)
	.set	macro
	.set	reorder

	lw	$4,164($6)
	lw	$5,48($6)
	jal	FILE_priorityop
$L15:
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
	.end	decbufferusage
	.def	getfreerequest;	.val	getfreerequest;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	getfreerequest
getfreerequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
 #APP
	mfc0 $6,$12
	nop
	li $1,-0x402
	and $8,$6,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,88($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	move	$5,$0
	.set	macro
	.set	reorder

	move	$5,$2
	lw	$2,requestidcounter
	lw	$3,12($5)
	addu	$2,$2,256
	sw	$3,88($4)
	sw	$2,requestidcounter
	bne	$2,$0,$L24
	li	$2,256			# 0x00000100
	sw	$2,requestidcounter
$L24:
	lbu	$2,0($5)
	lw	$3,requestidcounter
	#nop
	or	$2,$2,$3
	sw	$2,0($5)
$L23:
 #APP
	mtc0 $6,$12
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	getfreerequest
	.def	queuerequest;	.val	queuerequest;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	queuerequest
queuerequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	5;	.scl	17;	.type	0x4;	.endef
	li	$2,1			# 0x00000001
	sw	$2,4($5)
	sw	$0,12($5)
 #APP
	mfc0 $3,$12
	nop
	li $1,-0x402
	and $8,$3,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,84($4)
	#nop
	bne	$2,$0,$L28
	sw	$0,8($5)
	sw	$5,76($4)
	.set	noreorder
	.set	nomacro
	j	$L29
	sw	$5,80($4)
	.set	macro
	.set	reorder

$L28:
	sw	$2,8($5)
	lw	$2,84($4)
	#nop
	sw	$5,12($2)
$L29:
	sw	$5,84($4)
 #APP
	mtc0 $3,$12
 #NO_APP
	j	$31

	.loc	1 0
LM5:
	.end	queuerequest
	.def	func_800FC4E4;	.val	func_800FC4E4;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	func_800FC4E4
func_800FC4E4:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	reqid;	.val	5;	.scl	17;	.type	0xe;	.endef
	lw	$2,12($4)
	andi	$3,$5,0x00ff
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L32
	sll	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L32:
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,8($4)
	sll	$2,$2,2
	addu	$4,$3,$2
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L40
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,4($4)
	#nop
	beq	$3,$0,$L40
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

$L40:
	j	$31

	.loc	1 0
LM6:
	.end	func_800FC4E4
	.def	freerequest;	.val	freerequest;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	freerequest
freerequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	5;	.scl	17;	.type	0x4;	.endef
	lw	$2,76($4)
	#nop
	bne	$5,$2,$L42
	lw	$2,12($5)
	.set	noreorder
	.set	nomacro
	j	$L43
	sw	$2,76($4)
	.set	macro
	.set	reorder

$L42:
	lw	$3,8($5)
	lw	$2,12($5)
	#nop
	sw	$2,12($3)
$L43:
	lw	$2,84($4)
	#nop
	bne	$5,$2,$L44
	lw	$2,8($5)
	.set	noreorder
	.set	nomacro
	j	$L45
	sw	$2,84($4)
	.set	macro
	.set	reorder

$L44:
	lw	$3,12($5)
	lw	$2,8($5)
	#nop
	sw	$2,8($3)
$L45:
	lw	$2,80($4)
	#nop
	bne	$5,$2,$L46
	lw	$2,12($5)
	#nop
	bne	$2,$0,$L47
	lw	$2,8($5)
$L47:
	sw	$2,80($4)
$L46:
	sw	$0,4($5)
	lw	$2,88($4)
	#nop
	sw	$2,12($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,88($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	freerequest
	.def	StreamFilter;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	mask;	.val	0;	.scl	8;	.type	0xe;	.endef
	.def	value;	.val	4;	.scl	8;	.type	0xe;	.endef
	.def	consumer;	.val	8;	.scl	8;	.type	0xe;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	StreamFilter;	.size	12;	.endef
	.def	StreamFilter;	.scl	13;	.tag	StreamFilter;	.size	12;	.type	0x8;	.endef
	.def	filterchunk;	.val	filterchunk;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	filterchunk
filterchunk:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	5;	.scl	17;	.type	0x4;	.endef
	lw	$3,20($4)
	lw	$5,0($5)
	.set	noreorder
	.set	nomacro
	blez	$3,$L49
	move	$6,$0
	.set	macro
	.set	reorder

	move	$7,$3
	lw	$4,16($4)
$L50:
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	#.set	volatile
	lw	$3,4($4)
	#.set	novolatile
	and	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L53
	addu	$6,$6,1
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,8($4)
	#.set	novolatile
	j	$31
$L53:
	slt	$2,$6,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L50
	addu	$4,$4,12
	.set	macro
	.set	reorder

$L49:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	filterchunk
	.def	parsechunks;	.val	parsechunks;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	parsechunks
parsechunks:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	s;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,72($18)
	lw	$16,68($18)
	lw	$19,80($18)
	subu	$2,$3,$16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L78
	move	$2,$0
	.set	macro
	.set	reorder

	li	$21,-2			# 0xfffffffe
$L60:
	lw	$17,4($16)
	li	$2,-16777216			# 0xff000000
	and	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L62
	move	$20,$16
	.set	macro
	.set	reorder

	addu	$2,$16,$17
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L62
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filterchunk
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L64
	sll	$3,$4,24
	.set	macro
	.set	reorder

 #APP
	mfc0 $6,$12
	nop
	li $1,-0x402
	and $8,$6,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,4($19)
	#nop
	xori	$2,$2,0x0004
	sltu	$5,$2,1
	bne	$5,$0,$L66
	sw	$21,0($16)
	lw	$2,68($18)
	#nop
	addu	$2,$2,$17
	sw	$2,68($18)
$L66:
 #APP
	mtc0 $6,$12
 #NO_APP
	j	$L68
$L64:
	lw	$2,4($16)
	#nop
	or	$2,$2,$3
	sw	$2,4($16)
 #APP
	mfc0 $6,$12
	nop
	li $1,-0x402
	and $8,$6,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,4($19)
	#nop
	xori	$2,$2,0x0004
	sltu	$5,$2,1
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L70
	sll	$2,$4,4
	.set	macro
	.set	reorder

	lw	$3,24($18)
	addu	$2,$2,-16
	addu	$3,$3,$2
	lw	$2,8($3)
	#nop
	addu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L71
	sw	$2,8($3)
	.set	macro
	.set	reorder

	sw	$16,12($3)
$L71:
	lw	$2,68($18)
	#nop
	addu	$2,$2,$17
	sw	$2,68($18)
	lw	$2,60($18)
	lw	$4,52($18)
	addu	$3,$2,$17
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L70
	sw	$3,60($18)
	.set	macro
	.set	reorder

	slt	$2,$3,$4
	bne	$2,$0,$L70
	sw	$0,56($18)
$L70:
 #APP
	mtc0 $6,$12
 #NO_APP
$L68:
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L78
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,0($20)
	lw	$2,92($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L78
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,72($18)
	lw	$16,68($18)
	#nop
	subu	$2,$3,$16
	slt	$2,$2,8
	beq	$2,$0,$L60
	.def	malformed;	.val	$L62;	.scl	6;	.type	0x0;	.endef
$L62:
	move	$2,$0
$L78:
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
LM9:
	.end	parsechunks
	.def	opencallback;	.val	opencallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	opencallback
opencallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	a0;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a1;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,20($sp)
	lw	$4,164($16)
	jal	FILE_completeop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L81
	sw	$2,156($16)
	.set	macro
	.set	reorder

	lw	$5,48($16)
	.set	noreorder
	.set	nomacro
	jal	restartstream
	move	$4,$16
	.set	macro
	.set	reorder

$L81:
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
LM10:
	.end	opencallback
	.def	closecallback;	.val	closecallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	closecallback
closecallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	a0;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a1;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,20($sp)
	lw	$4,164($16)
	jal	FILE_completeop
	addu	$4,$16,92
	li	$5,1			# 0x00000001
	lw	$6,48($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	move	$7,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L83
	sw	$2,164($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(opencallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(opencallback) # low
	.set	macro
	.set	reorder

$L83:
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
	.end	closecallback
	.def	readcallback;	.val	readcallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	readcallback
readcallback:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	a0;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	a1;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$18,80($16)
	#nop
	lw	$3,16($18)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L85
	lw	$5,168($16)
	lw	$3,160($16)
	lw	$2,88($18)
	addu	$17,$3,$5
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L86
	xori	$17,$2,0x0001
	.set	macro
	.set	reorder

$L85:
	lw	$4,164($16)
	jal	FILE_completeop
	lw	$3,168($16)
	move	$5,$2
	slt	$17,$2,$3
$L86:
	move	$4,$16
	lw	$2,160($16)
	lw	$3,72($16)
	addu	$2,$2,$5
	addu	$3,$3,$5
	sw	$2,160($16)
	.set	noreorder
	.set	nomacro
	jal	parsechunks
	sw	$3,72($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$3,4($18)
	li	$2,4			# 0x00000004
	beq	$3,$2,$L87
	bne	$17,$0,$L89
	beq	$4,$0,$L93
$L89:
 #APP
	mfc0 $3,$12
	nop
	li $1,-0x402
	and $8,$3,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	li	$2,3			# 0x00000003
	sw	$2,4($18)
 #APP
	mtc0 $3,$12
 #NO_APP
$L87:
	lw	$5,48($16)
	.set	noreorder
	.set	nomacro
	jal	startnextrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L94
	.def	restart;	.val	$L93;	.scl	6;	.type	0x0;	.endef
$L93:
	lw	$5,48($16)
	.set	noreorder
	.set	nomacro
	jal	restartstream
	move	$4,$16
	.set	macro
	.set	reorder

$L94:
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
	.end	readcallback
	.def	startnextrequest;	.val	startnextrequest;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	startnextrequest
startnextrequest:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	s;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	prio;	.val	19;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
 #APP
	mfc0 $5,$12
	nop
	li $1,-0x402
	and $8,$5,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$4,80($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L97
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,4($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L97
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$2,12($4)
	#nop
	bne	$2,$0,$L99
	.set	noreorder
	.set	nomacro
	j	$L97
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L99:
	sw	$2,80($17)
$L97:
	beq	$3,$0,$L102
	.set	noreorder
	.set	nomacro
	j	$L103
	sw	$0,40($17)
	.set	macro
	.set	reorder

$L102:
	lw	$6,80($17)
	lw	$2,68($17)
	#nop
	sw	$2,96($6)
	li	$2,2			# 0x00000002
	sw	$2,4($6)
$L103:
 #APP
	mtc0 $5,$12
 #NO_APP
	bne	$3,$0,$L95
	lw	$2,68($17)
	#nop
	sw	$2,72($17)
	lw	$3,16($6)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L106
	addu	$18,$6,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L107
	sw	$0,160($17)
	.set	macro
	.set	reorder

$L106:
	move	$4,$18
	addu	$16,$17,92
	lw	$2,88($6)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	strcmp
	sw	$2,160($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L107
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,156($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L109
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1			# 0x00000001
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	sw	$2,164($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(opencallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(opencallback) # low
	.set	macro
	.set	reorder

	j	$L95
$L109:
	.set	noreorder
	.set	nomacro
	jal	FILE_close
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	sw	$2,164($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(closecallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(closecallback) # low
	.set	macro
	.set	reorder

	j	$L95
$L107:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	restartstream
	move	$5,$19
	.set	macro
	.set	reorder

$L95:
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
LM13:
	.end	startnextrequest
	.def	restartstream;	.val	restartstream;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	restartstream
restartstream:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	s;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	prio;	.val	20;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	lw	$2,64($17)
	lw	$3,68($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L114
	move	$20,$5
	.set	macro
	.set	reorder

	li	$6,-1			# 0xffffffff
	li	$5,-2			# 0xfffffffe
	move	$4,$3
$L115:
	lw	$3,64($17)
	#nop
	lw	$2,0($3)
	#nop
	bne	$2,$6,$L118
	lw	$2,32($17)
	.set	noreorder
	.set	nomacro
	j	$L145
	sw	$2,64($17)
	.set	macro
	.set	reorder

$L118:
	bne	$2,$5,$L114
	lw	$2,4($3)
	#nop
	addu	$2,$3,$2
	sw	$2,64($17)
$L145:
	lw	$2,64($17)
	#nop
	bne	$2,$4,$L115
$L114:
 #APP
	mfc0 $18,$12
	nop
	li $1,-0x402
	and $8,$18,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$16,76($17)
	#nop
	lw	$2,12($16)
	#nop
	beq	$2,$0,$L123
	li	$19,1			# 0x00000001
$L124:
	lw	$3,12($16)
	#nop
	lw	$2,4($3)
	#nop
	beq	$2,$19,$L123
	lw	$4,64($17)
	lw	$6,96($3)
	lw	$5,72($17)
	.set	noreorder
	.set	nomacro
	jal	inbetween
	addu	$6,$6,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L123
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freerequest
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$16,76($17)
	#nop
	lw	$2,12($16)
	#nop
	bne	$2,$0,$L124
$L123:
 #APP
	mtc0 $18,$12
 #NO_APP
	lw	$6,64($17)
 #APP
 #NO_APP
	lw	$3,72($17)
	#nop
	sltu	$2,$3,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L131
	subu	$2,$6,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L132
	addu	$5,$2,-1
	.set	macro
	.set	reorder

$L131:
	lw	$2,36($17)
	#nop
	subu	$2,$2,$3
	addu	$5,$2,-8
	slt	$2,$5,8192
	beq	$2,$0,$L135
	lw	$5,68($17)
	lw	$4,32($17)
	subu	$16,$3,$5
	subu	$2,$6,$4
	addu	$3,$16,1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L146
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	memcpy
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$3,68($17)
	li	$2,-1			# 0xffffffff
	sw	$2,0($3)
	li	$2,8			# 0x00000008
	sw	$2,4($3)
	lw	$4,32($17)
	lw	$2,64($17)
	addu	$3,$4,$16
	subu	$2,$2,$3
	addu	$5,$2,-1
	sw	$4,68($17)
	sw	$3,72($17)
	.def	check_room;	.val	$L132;	.scl	6;	.type	0x0;	.endef
$L132:
	slt	$2,$5,8192
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L135
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L146:
	.set	noreorder
	.set	nomacro
	j	$L143
	sw	$2,40($17)
	.set	macro
	.set	reorder

	.def	have_room;	.val	$L135;	.scl	6;	.type	0x0;	.endef
$L135:
	lw	$16,80($17)
	#nop
	lw	$3,16($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L139
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	lw	$4,160($17)
	lw	$3,88($16)
	addu	$2,$4,$5
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L140
	subu	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L141
	sw	$2,168($17)
	.set	macro
	.set	reorder

$L140:
	sw	$5,168($17)
$L141:
	lw	$4,72($17)
	lw	$5,84($16)
	lw	$6,168($17)
	jal	memcpy
	move	$4,$0
	move	$5,$4
	lw	$2,84($16)
	lw	$3,168($17)
	move	$6,$17
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	readcallback
	sw	$2,84($16)
	.set	macro
	.set	reorder

	j	$L143
$L139:
	sw	$2,168($17)
	sw	$20,16($sp)
	sw	$17,20($sp)
	lw	$4,156($17)
	lw	$5,160($17)
	lw	$6,72($17)
	lw	$7,168($17)
	jal	FILE_read
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L143
	sw	$2,164($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(readcallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(readcallback) # low
	.set	macro
	.set	reorder

$L143:
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
LM14:
	.end	restartstream
	.def	STREAM_overhead;	.val	STREAM_overhead;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_overhead
STREAM_overhead:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	numReq;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	numFilters;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	numConsumers;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,2
	sll	$3,$5,1
	addu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,172
	addu	$2,$2,$3
	sll	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$6
	.set	macro
	.set	reorder


	.loc	1 0
LM15:
	.end	STREAM_overhead
	.def	STREAM_create;	.val	STREAM_create;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_create
STREAM_create:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	numReq;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	numFilters;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	numConsumers;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	objbuf;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	bufsize;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	bufsize;	.val	20;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$16,16($sp)
	sw	$20,32($sp)
	lw	$20,56($sp)
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	STREAM_overhead
	move	$16,$7
	.set	macro
	.set	reorder

	subu	$2,$20,$2
	slt	$2,$2,24576
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L174
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L154
	slt	$2,$17,257
	.set	macro
	.set	reorder

$L176:
	.set	noreorder
	.set	nomacro
	j	$L174
	move	$2,$0
	.set	macro
	.set	reorder

$L154:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L176
	addu	$2,$18,-1
	.set	macro
	.set	reorder

	sltu	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L174
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$19,$L176
	slt	$2,$18,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L174
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,1297219584			# 0x4d520000
	ori	$2,$2,0x5453
	.set	noreorder
	.set	nomacro
	jal	allocmutex
	sw	$2,0($16)
	.set	macro
	.set	reorder

	addu	$4,$16,92
	move	$5,$0
	li	$6,64			# 0x00000040
	sw	$2,4($16)
	addu	$2,$16,172
	sw	$2,8($16)
	addu	$2,$16,$20
	sw	$2,36($16)
	li	$2,150			# 0x00000096
	sw	$2,44($16)
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,3
	addu	$2,$2,$17
	lw	$3,8($16)
	sll	$2,$2,2
	sw	$17,12($16)
	sw	$18,20($16)
	sw	$19,28($16)
	sw	$0,40($16)
	sw	$0,52($16)
	sw	$0,56($16)
	sw	$0,60($16)
	sw	$0,76($16)
	sw	$0,80($16)
	sw	$0,84($16)
	addu	$3,$3,$2
	sll	$2,$18,1
	addu	$2,$2,$18
	sll	$2,$2,2
	sw	$3,16($16)
	addu	$3,$3,$2
	sw	$3,24($16)
	move	$2,$3
	sll	$3,$19,4
	addu	$2,$2,$3
	sw	$2,32($16)
	move	$7,$2
	move	$8,$2
	move	$9,$2
	lw	$3,8($16)
	li	$2,50			# 0x00000032
	sw	$2,48($16)
	sw	$7,64($16)
	sw	$8,68($16)
	sw	$9,72($16)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$3,88($16)
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	blez	$17,$L178
	sw	$0,156($16)
	.set	macro
	.set	reorder

	li	$6,100			# 0x00000064
	move	$4,$5
$L160:
	lw	$3,8($16)
	#nop
	addu	$3,$3,$4
	addu	$4,$4,100
	sw	$5,0($3)
	sw	$0,4($3)
	lw	$2,8($16)
	addu	$5,$5,1
	addu	$2,$2,$6
	sw	$2,12($3)
	slt	$2,$5,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L160
	addu	$6,$6,100
	.set	macro
	.set	reorder

	move	$5,$0
$L178:
	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,3
	addu	$2,$2,$17
	lw	$3,8($16)
	sll	$2,$2,2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	blez	$18,$L164
	sw	$0,-88($2)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$3,$5
$L165:
	lw	$2,16($16)
	addu	$5,$5,1
	addu	$2,$2,$3
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$4,8($2)
	slt	$2,$5,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L165
	addu	$3,$3,12
	.set	macro
	.set	reorder

$L164:
	.set	noreorder
	.set	nomacro
	blez	$19,$L169
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$4,$5,4
$L177:
	addu	$3,$5,1
	lw	$2,24($16)
	move	$5,$3
	addu	$2,$2,$4
	sw	$16,0($2)
	sw	$5,4($2)
	sw	$0,8($2)
	slt	$2,$5,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L177
	sll	$4,$5,4
	.set	macro
	.set	reorder

$L169:
	lw	$2,24($16)
$L174:
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
LM16:
	.end	STREAM_create
	.def	STREAM_setfilter;	.val	STREAM_setfilter;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_setfilter
STREAM_setfilter:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	consumer;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	filterIdx;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	mask;	.val	18;	.scl	17;	.type	0xe;	.endef
	.def	match;	.val	19;	.scl	17;	.type	0xe;	.endef
	.def	value;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	value;	.val	17;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$19,36($sp)
	move	$19,$7
	addu	$5,$sp,16
	sw	$17,28($sp)
	lw	$17,64($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L179
	blez	$16,$L179
	lw	$2,16($sp)
	#nop
	lw	$3,20($2)
	#nop
	slt	$2,$3,$16
	bne	$2,$0,$L179
	.set	noreorder
	.set	nomacro
	bne	$16,$3,$L183
	or	$2,$18,$19
	.set	macro
	.set	reorder

	bne	$2,$0,$L179
$L183:
	.set	noreorder
	.set	nomacro
	bgtz	$17,$L184
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L184
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	bne	$17,$2,$L179
$L184:
	lw	$3,16($sp)
	#nop
	lw	$2,28($3)
	#nop
	slt	$2,$2,$17
	bne	$2,$0,$L179
	lw	$2,40($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L179
	sll	$2,$16,1
	.set	macro
	.set	reorder

	addu	$2,$2,$16
	sll	$2,$2,2
	lw	$3,16($3)
	addu	$2,$2,-12
	addu	$3,$3,$2
	sw	$18,0($3)
	sw	$19,4($3)
	sw	$17,8($3)
$L179:
	lw	$31,40($sp)
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
LM17:
	.end	STREAM_setfilter
	.def	STREAM_destroy;	.val	STREAM_destroy;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_destroy
STREAM_destroy:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L187
	.set	noreorder
	.set	nomacro
	jal	STREAM_kill
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$3,40($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L190
	move	$16,$2
	.set	macro
	.set	reorder

$L191:
	.set	noreorder
	.set	nomacro
	jal	iscurrentthread
	move	$4,$0
	.set	macro
	.set	reorder

	beq	$2,$0,$L192
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

$L192:
	.set	noreorder
	.set	nomacro
	jal	yieldthread
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$2,40($2)
	#nop
	beq	$2,$16,$L191
$L190:
	lw	$2,16($sp)
	#nop
	lw	$4,4($2)
	.set	noreorder
	.set	nomacro
	jal	freemutex
	sw	$0,0($2)
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$4,156($2)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

$L187:
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
LM18:
	.end	STREAM_destroy
	.def	STREAM_setpriority;	.val	STREAM_setpriority;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_setpriority
STREAM_setpriority:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	prioA;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	prioB;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$5
	sw	$17,28($sp)
	move	$17,$6
	addu	$5,$sp,16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L194
	lw	$2,16($sp)
	#nop
	sw	$16,44($2)
	sw	$17,48($2)
$L194:
	lw	$31,32($sp)
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
LM19:
	.end	STREAM_setpriority
	.def	STREAM_setgreedylevel;	.val	STREAM_setgreedylevel;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_setgreedylevel
STREAM_setgreedylevel:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	s;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	lvl;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$16,24($sp)
	move	$16,$5
	addu	$5,$sp,16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L196
	lw	$2,16($sp)
	#nop
	lw	$3,52($2)
	lw	$4,60($2)
	#nop
	slt	$3,$4,$3
	slt	$5,$4,$16
	.set	noreorder
	.set	nomacro
	beq	$3,$5,$L196
	sw	$16,52($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	STREAM_setgreedystate
	move	$4,$17
	.set	macro
	.set	reorder

$L196:
	lw	$31,32($sp)
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
LM20:
	.end	STREAM_setgreedylevel
	.def	STREAM_setgreedystate;	.val	STREAM_setgreedystate;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_setgreedystate
STREAM_setgreedystate:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	state;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L199
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L199
	sw	$16,56($5)
	.set	macro
	.set	reorder

	lw	$3,40($5)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L199
	lw	$4,164($5)
	lw	$5,48($5)
	jal	FILE_priorityop
$L199:
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
LM21:
	.end	STREAM_setgreedystate
	.def	STREAM_queuefile;	.val	STREAM_queuefile;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	STREAM_queuefile
STREAM_queuefile:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	name;	.val	17;	.scl	17;	.type	0x12;	.endef
	.def	off;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	len;	.val	19;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$19,36($sp)
	move	$19,$7
	addu	$5,$sp,16
	addu	$6,$sp,20
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L211
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	jal	getfreerequest
	move	$16,$2
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L204
	addu	$4,$16,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L211
	move	$2,$0
	.set	macro
	.set	reorder

$L204:
	move	$5,$17
	li	$6,63			# 0x0000003f
	.set	noreorder
	.set	nomacro
	jal	strncpy
	sw	$0,16($16)
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	move	$5,$16
	sw	$18,88($16)
	.set	noreorder
	.set	nomacro
	jal	queuerequest
	sw	$19,92($16)
	.set	macro
	.set	reorder

 #APP
	mfc0 $5,$12
	nop
	li $1,-0x402
	and $8,$5,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$3,16($sp)
	#nop
	lw	$4,40($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L206
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,40($3)
$L206:
 #APP
	mtc0 $5,$12
 #NO_APP
	bne	$4,$0,$L208
	lw	$4,16($sp)
	#nop
	lw	$2,56($4)
	#nop
	beq	$2,$0,$L209
	lw	$5,48($4)
	j	$L210
$L209:
	lw	$5,44($4)
$L210:
	jal	startnextrequest
$L208:
	lw	$2,0($16)
$L211:
	lw	$31,40($sp)
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
LM22:
	.end	STREAM_queuefile
	.def	STREAM_queuemem;	.val	STREAM_queuemem;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	STREAM_queuemem
STREAM_queuemem:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	blocklist;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	ptr;	.val	16;	.scl	17;	.type	0x11;	.endef
	.def	len;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$5
	sw	$16,24($sp)
	move	$16,$6
	sw	$18,32($sp)
	move	$18,$7
	addu	$5,$sp,16
	addu	$6,$sp,20
	sw	$31,44($sp)
	sw	$20,40($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L225
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	jal	getfreerequest
	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L225
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L227
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$2,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L218
	move	$4,$19
	.set	macro
	.set	reorder

$L219:
	lw	$2,4($4)
	#nop
	addu	$4,$4,$2
	lw	$3,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L219
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L218:
	lw	$2,4($4)
	#nop
	addu	$16,$16,$2
	move	$5,$17
$L227:
	lw	$4,16($sp)
	li	$20,1			# 0x00000001
	sw	$20,16($17)
	sw	$19,84($17)
	sw	$16,88($17)
	.set	noreorder
	.set	nomacro
	jal	queuerequest
	sw	$18,92($17)
	.set	macro
	.set	reorder

 #APP
	mfc0 $4,$12
	nop
	li $1,-0x402
	and $8,$4,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,16($sp)
	#nop
	lw	$3,40($2)
	#nop
	bne	$3,$0,$L222
	sw	$20,40($2)
$L222:
 #APP
	mtc0 $4,$12
 #NO_APP
	bne	$3,$0,$L224
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	startnextrequest
	move	$5,$0
	.set	macro
	.set	reorder

$L224:
	lw	$2,0($17)
$L225:
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
LM23:
	.end	STREAM_queuemem
	.def	STREAM_cancelrequest;	.val	STREAM_cancelrequest;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_cancelrequest
STREAM_cancelrequest:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	reqid;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,64
	sw	$16,24($sp)
	move	$16,$5
	addu	$5,$sp,16
	addu	$6,$sp,20
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	bne	$2,$0,$L228
 #APP
	mfc0 $18,$12
	nop
	li $1,-0x402
	and $8,$18,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	func_800FC4E4
	move	$5,$16
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L232
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L232
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$2,$6,$L235
	lw	$4,16($sp)
	jal	freerequest
	.def	notactive;	.val	$L232;	.scl	6;	.type	0x0;	.endef
$L232:
	.set	noreorder
	.set	nomacro
	j	$L236
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	active;	.val	$L235;	.scl	6;	.type	0x0;	.endef
$L235:
	lw	$3,16($sp)
	sw	$4,4($5)
	lw	$23,64($3)
	lw	$2,76($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L238
	move	$20,$23
	.set	macro
	.set	reorder

	lw	$20,96($5)
$L238:
	lw	$5,12($5)
	#nop
	beq	$5,$0,$L240
	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$6,$L239
	move	$2,$0
	.set	macro
	.set	reorder

$L240:
	lw	$22,68($3)
	.set	noreorder
	.set	nomacro
	j	$L236
	move	$2,$0
	.set	macro
	.set	reorder

$L239:
	lw	$22,96($5)
	.def	reclaim;	.val	$L236;	.scl	6;	.type	0x0;	.endef
$L236:
 #APP
	mtc0 $18,$12
 #NO_APP
	bne	$2,$0,$L228
	lw	$3,16($sp)
	#nop
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L228
	move	$19,$0
	.set	macro
	.set	reorder

	li	$fp,-1			# 0xffffffff
$L245:
	lw	$2,24($3)
	sll	$3,$19,4
	addu	$3,$2,$3
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L251
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	move	$4,$23
	lw	$6,12($3)
	.set	noreorder
	.set	nomacro
	jal	inbetween
	move	$5,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L249
	move	$16,$20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	lw	$2,4($2)
	.set	noreorder
	.set	nomacro
	beq	$20,$22,$L251
	sll	$21,$2,24
	.set	macro
	.set	reorder

$L252:
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$fp,$L255
	li	$2,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$16,32($2)
	j	$L254
$L255:
	lw	$3,4($16)
	ori	$2,$2,0xffff
	and	$17,$3,$2
	li	$2,-16777216			# 0xff000000
	and	$3,$3,$2
	bne	$3,$21,$L257
 #APP
	mfc0 $18,$12
	nop
	li $1,-0x402
	and $8,$18,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,20($sp)
	#nop
	lw	$3,8($2)
	#nop
	subu	$3,$3,$17
	sw	$3,8($2)
 #APP
	mtc0 $18,$12
 #NO_APP
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	decbufferusage
	move	$5,$17
	.set	macro
	.set	reorder

	li	$2,-2			# 0xfffffffe
	sw	$2,0($16)
	sw	$17,4($16)
$L257:
	addu	$16,$16,$17
$L254:
	bne	$16,$22,$L252
 #APP
 #NO_APP
	j	$L251
$L249:
	lw	$2,20($sp)
	#nop
	lw	$6,12($2)
	.set	noreorder
	.set	nomacro
	j	$L270
	move	$4,$20
	.set	macro
	.set	reorder

$L263:
	lw	$4,20($sp)
	jal	STREAM_get
	lw	$4,20($sp)
	.set	noreorder
	.set	nomacro
	jal	STREAM_release
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,20($sp)
	#nop
	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L251
	move	$4,$20
	.set	macro
	.set	reorder

	lw	$6,12($3)
$L270:
	.set	noreorder
	.set	nomacro
	jal	inbetween
	move	$5,$22
	.set	macro
	.set	reorder

	bne	$2,$0,$L263
	.def	nextconsumer;	.val	$L251;	.scl	6;	.type	0x0;	.endef
$L251:
	lw	$3,16($sp)
	#nop
	lw	$2,28($3)
	addu	$19,$19,1
	slt	$2,$19,$2
	bne	$2,$0,$L245
$L228:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM24:
	.end	STREAM_cancelrequest
	.def	STREAM_kill;	.val	STREAM_kill;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_kill
STREAM_kill:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	s;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L271
	lw	$2,16($sp)
	#nop
	lw	$5,84($2)
	#nop
	beq	$5,$0,$L271
	j	$L296
$L276:
	lw	$5,0($5)
	.set	noreorder
	.set	nomacro
	jal	STREAM_cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$5,84($2)
$L296:
	lw	$2,4($5)
	#nop
	addu	$2,$2,-1
	sltu	$2,$2,2
	beq	$2,$0,$L297
	j	$L276
$L280:
	lw	$5,76($4)
	jal	freerequest
$L297:
	lw	$4,16($sp)
	#nop
	lw	$3,76($4)
	lw	$2,80($4)
	#nop
	bne	$3,$2,$L280
	lw	$2,16($sp)
	#nop
	move	$5,$2
	lw	$3,80($2)
	li	$2,4			# 0x00000004
	sw	$2,4($3)
	lw	$2,28($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L282
	move	$4,$0
	.set	macro
	.set	reorder

	sll	$3,$4,4
$L298:
	lw	$2,24($5)
	lw	$5,16($sp)
	addu	$3,$3,$2
	sw	$0,8($3)
	lw	$2,28($5)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L298
	sll	$3,$4,4
	.set	macro
	.set	reorder

$L282:
	lw	$4,16($sp)
	#nop
	lw	$5,60($4)
	jal	decbufferusage
	lw	$4,16($sp)
	#nop
	lw	$3,64($4)
	lw	$2,68($4)
	#nop
	beq	$3,$2,$L287
	li	$7,-1			# 0xffffffff
	li	$5,16711680			# 0x00ff0000
	ori	$5,$5,0xffff
	li	$6,-2			# 0xfffffffe
$L288:
	lw	$2,0($3)
	#nop
	bne	$2,$7,$L291
	lw	$3,32($4)
	j	$L292
$L291:
	lw	$2,4($3)
	sw	$6,0($3)
	and	$2,$2,$5
	sw	$2,4($3)
	addu	$3,$3,$2
$L292:
	lw	$4,16($sp)
	#nop
	lw	$2,68($4)
	#nop
	bne	$3,$2,$L288
$L287:
	lw	$3,40($4)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L271
	sw	$0,40($4)
$L271:
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
LM25:
	.end	STREAM_kill
	.def	STREAM_get;	.val	STREAM_get;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_get
STREAM_get:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	consumer;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L311
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	#nop
	lw	$2,8($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L301
	li	$3,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L311
	move	$2,$0
	.set	macro
	.set	reorder

$L301:
	lw	$7,12($5)
	#nop
	lw	$2,4($7)
	ori	$3,$3,0xffff
	and	$4,$2,$3
	sw	$4,4($7)
 #APP
	mfc0 $3,$12
	nop
	li $1,-0x402
	and $8,$3,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$2,8($5)
	#nop
	subu	$2,$2,$4
	sw	$2,8($5)
 #APP
	mtc0 $3,$12
 #NO_APP
	.set	noreorder
	.set	nomacro
	blez	$2,$L311
	move	$2,$7
	.set	macro
	.set	reorder

	lw	$2,4($5)
	addu	$5,$7,$4
	sll	$6,$2,24
	lw	$2,4($5)
	li	$3,-16777216			# 0xff000000
	and	$2,$2,$3
	beq	$2,$6,$L306
	li	$10,-1			# 0xffffffff
	lw	$8,16($sp)
	li	$3,16711680			# 0x00ff0000
	ori	$3,$3,0xffff
	li	$9,-16777216			# 0xff000000
$L307:
	lw	$2,0($5)
	#nop
	bne	$2,$10,$L308
	lw	$5,32($8)
	j	$L305
$L308:
	lw	$2,4($5)
	#nop
	and	$4,$2,$3
	addu	$5,$5,$4
$L305:
	lw	$2,4($5)
	#nop
	and	$2,$2,$9
	bne	$2,$6,$L307
$L306:
	lw	$2,20($sp)
	#nop
	sw	$5,12($2)
	move	$2,$7
$L311:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM26:
	.end	STREAM_get
	.def	STREAM_release;	.val	STREAM_release;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	STREAM_release
STREAM_release:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$5
	addu	$5,$sp,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L313
	lw	$4,16($sp)
	#nop
	lw	$2,32($4)
	#nop
	sltu	$2,$16,$2
	bne	$2,$0,$L313
	lw	$2,36($4)
	#nop
	addu	$2,$2,-8
	sltu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L313
	li	$3,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	beq	$2,$3,$L313
	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	decbufferusage
	sw	$3,0($16)
	.set	macro
	.set	reorder

 #APP
	mfc0 $5,$12
	nop
	li $1,-0x402
	and $8,$5,$1
	mtc0 $8,$12
	nop
	nop
	nop
 #NO_APP
	lw	$3,16($sp)
	#nop
	lw	$4,40($3)
	li	$6,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L319
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,40($3)
$L319:
 #APP
	mtc0 $5,$12
 #NO_APP
	bne	$4,$6,$L313
	lw	$4,16($sp)
	#nop
	lw	$2,56($4)
	#nop
	beq	$2,$0,$L322
	lw	$5,48($4)
	j	$L323
$L322:
	lw	$5,44($4)
$L323:
	jal	restartstream
$L313:
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
LM27:
	.end	STREAM_release
	.def	STREAM_gettable;	.val	STREAM_gettable;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_gettable
STREAM_gettable:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L325
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	lw	$2,8($2)
$L325:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM28:
	.end	STREAM_gettable
	.def	STREAM_state;	.val	STREAM_state;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_state
STREAM_state:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L328
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$2,40($2)
$L328:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM29:
	.end	STREAM_state
	.def	STREAM_isendofstream;	.val	STREAM_isendofstream;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_isendofstream
STREAM_isendofstream:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L333
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$2,40($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L332
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	lw	$2,8($2)
	#nop
	sltu	$3,$2,1
$L332:
	move	$2,$3
$L333:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM30:
	.end	STREAM_isendofstream
	.def	STREAM_buffersize;	.val	STREAM_buffersize;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_buffersize
STREAM_buffersize:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	bne	$2,$0,$L335
	lw	$2,16($sp)
	#nop
	lw	$3,36($2)
	lw	$2,32($2)
	.set	noreorder
	.set	nomacro
	j	$L336
	subu	$2,$3,$2
	.set	macro
	.set	reorder

$L335:
	move	$2,$0
$L336:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM31:
	.end	STREAM_buffersize
	.def	STREAM_bufferusage;	.val	STREAM_bufferusage;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	STREAM_bufferusage
STREAM_bufferusage:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	validatehandle
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L338
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	lw	$2,60($2)
$L338:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM32:
	.end	STREAM_bufferusage
	.def	requestidcounter;	.val	requestidcounter;	.scl	2;	.type	0xe;	.endef
