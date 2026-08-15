	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\nasync.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	queueadd
	.align	2
	.globl	queuefetch
	.align	2
	.globl	newrequestid
	.align	2
	.align	2
	.globl	cancelrequest
	.align	2
	.globl	finishrequest
	.align	2
	.globl	loadfileclosecallback
	.align	2
	.globl	loadfilereadcallback
	.rdata
	.align	2
$LC0:
	.ascii	"ASYNCBUF\000"
	.text
	.align	2
	.globl	loadfilesizecallback
	.align	2
	.globl	loadfileopencallback
	.align	2
	.globl	loadsegreadcallback
	.align	2
	.globl	asyncsystemtask
	.rdata
	.align	2
$LC1:
	.ascii	"ASYNCREQ\000"
	.text
	.align	2
	.globl	initasync
	.align	2
	.globl	asyncloadfilecallback
	.align	2
	.globl	asyncloadfile
	.align	2
	.globl	asyncloadfileatcallback
	.align	2
	.globl	asyncloadfileat
	.align	2
	.globl	setasyncfile
	.align	2
	.globl	asyncloadsegmentcallback
	.align	2
	.globl	asyncloadsegment
	.align	2
	.globl	cancelasyncload
	.align	2
	.globl	getasyncreadadr
	.align	2
	.globl	getasyncreadstatus

	.comm	request,4

	.comm	numrequests,4

	.comm	readblocksize,4

	.comm	requestidcounter,4

	.comm	freequeuehead,4

	.comm	freequeuetail,4

	.comm	callqueuehead,4

	.comm	callqueuetail,4

	.comm	asyncfilehandle,4

	.comm	asyncfileoffset,4

	.comm	mutex,4


	.text
	.file	1 "C:/Temp/nfs4-decomp/recon/lib/nasync.h"
	.def	AsyncReq;	.scl	10;	.type	0x8;	.size	44;	.endef
	.def	id;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	next;	.val	4;	.scl	8;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	bytesread;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	status;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	buffer;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	callback;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	fileop;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	handle;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	offset;	.val	32;	.scl	8;	.type	0x4;	.endef
	.def	arg24;	.val	36;	.scl	8;	.type	0x4;	.endef
	.def	dest;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	44;	.scl	102;	.tag	AsyncReq;	.size	44;	.endef
	.def	AsyncReq;	.scl	13;	.tag	AsyncReq;	.size	44;	.type	0x8;	.endef
	.def	AsyncQueue;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	head;	.val	0;	.scl	8;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	tail;	.val	4;	.scl	8;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	AsyncQueue;	.size	8;	.endef
	.def	AsyncQueue;	.scl	13;	.tag	AsyncQueue;	.size	8;	.type	0x8;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\nasync.c"
	.def	size_t;	.scl	13;	.type	0xe;	.endef
	.def	queueadd;	.val	queueadd;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	queueadd
queueadd:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	q;	.val	4;	.scl	17;	.tag	AsyncQueue;	.size	8;	.type	0x18;	.endef
	.def	n;	.val	5;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
 #APP
	mfc0 $3,$12
	 nop
	 addiu $1,$0,-0x402
	 and $8,$3,$1
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lw	$2,0($4)
	#nop
	bne	$2,$0,$L2
	.set	noreorder
	.set	nomacro
	j	$L3
	sw	$5,0($4)
	.set	macro
	.set	reorder

$L2:
	lw	$2,4($4)
	#nop
	sw	$5,4($2)
$L3:
	sw	$5,4($4)
	sw	$0,4($5)
 #APP
	mtc0 $3,$12
 #NO_APP
	j	$31

	.loc	1 0
LM1:
	.end	queueadd
	.def	queuefetch;	.val	queuefetch;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x68;	.endef
	.text
	.ent	queuefetch
queuefetch:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	q;	.val	4;	.scl	17;	.tag	AsyncQueue;	.size	8;	.type	0x18;	.endef
 #APP
	mfc0 $5,$12
	 nop
	 addiu $1,$0,-0x402
	 and $8,$5,$1
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	move	$3,$0
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$2,4($3)
	#nop
	sw	$2,0($4)
$L5:
 #APP
	mtc0 $5,$12
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	queuefetch
	.def	newrequestid;	.val	newrequestid;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	newrequestid
newrequestid:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	r;	.val	4;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	lw	$2,requestidcounter
	#nop
	addu	$2,$2,256
	sw	$2,requestidcounter
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	li	$2,256			# 0x00000100
	.set	macro
	.set	reorder

	sw	$2,requestidcounter
$L7:
	lbu	$2,0($4)
	lw	$3,requestidcounter
	#nop
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	newrequestid
	.def	locaterequest;	.val	locaterequest;	.scl	3;	.tag	AsyncReq;	.size	44;	.type	0x68;	.endef
	.text
	.ent	locaterequest
locaterequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	slt	$2,$4,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	lw	$2,numrequests
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	sll	$2,$3,1
	.set	macro
	.set	reorder

$L13:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L10:
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,request
	sll	$2,$2,2
	addu	$5,$3,$2
	lw	$3,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L14
	move	$2,$0
	.set	macro
	.set	reorder

	move	$2,$5
$L14:
	j	$31

	.loc	1 0
LM4:
	.end	locaterequest
	.def	cancelrequest;	.val	cancelrequest;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	cancelrequest
cancelrequest:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	r;	.val	16;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
 #APP
	mfc0 $4,$12
	 nop
	 addiu $1,$0,-0x402
	 and $8,$4,$1
	 mtc0 $8,$12
	 nop
	 nop
	 nop
 #NO_APP
	lw	$3,12($16)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$5,$L16
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,12($16)
$L16:
 #APP
	mtc0 $4,$12
 #NO_APP
	bne	$3,$5,$L15
	lw	$4,16($16)
	#nop
	sltu	$2,$4,2
	bne	$2,$0,$L18
	jal	purgememadr
$L18:
	la	$4,freequeuehead
	lbu	$2,0($16)
	move	$5,$16
	sw	$0,24($16)
	.set	noreorder
	.set	nomacro
	jal	queueadd
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L15:
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
LM5:
	.end	cancelrequest
	.def	finishrequest;	.val	finishrequest;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	finishrequest
finishrequest:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	r;	.val	5;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,24
	move	$5,$4
	sw	$31,16($sp)
	lw	$2,20($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	sw	$0,24($5)
	.set	macro
	.set	reorder

	la	$4,callqueuehead
	jal	queueadd
$L19:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM6:
	.end	finishrequest
	.def	loadfileclosecallback;	.val	loadfileclosecallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	loadfileclosecallback
loadfileclosecallback:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	16;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$17,$16
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	beq	$2,$0,$L22
	.set	noreorder
	.set	nomacro
	jal	cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L23
$L22:
	.set	noreorder
	.set	nomacro
	jal	finishrequest
	move	$4,$17
	.set	macro
	.set	reorder

$L23:
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
LM7:
	.end	loadfileclosecallback
	.def	loadfilereadcallback;	.val	loadfilereadcallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	loadfilereadcallback
loadfilereadcallback:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	16;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$6
	sw	$31,28($sp)
	lw	$4,24($16)
	jal	FILE_completeop
	move	$4,$2
	lw	$2,8($16)
	lw	$7,readblocksize
	addu	$2,$2,$4
	sw	$2,8($16)
	slt	$2,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	li	$5,99			# 0x00000063
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	beq	$2,$0,$L25
$L31:
	lw	$4,28($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_close
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfileclosecallback) # high
	.set	noreorder
	.set	nomacro
	j	$L30
	addiu	$5,$5,%lo(loadfileclosecallback) # low
	.set	macro
	.set	reorder

$L25:
	lw	$2,32($16)
	lw	$3,40($16)
	addu	$2,$2,$4
	addu	$3,$3,$4
	sw	$2,32($16)
	li	$2,99			# 0x00000063
	sw	$3,40($16)
	sw	$2,16($sp)
	sw	$16,20($sp)
	lw	$4,28($16)
	lw	$5,32($16)
	lw	$6,40($16)
	jal	FILE_read
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfilereadcallback) # high
	addiu	$5,$5,%lo(loadfilereadcallback) # low
$L30:
	jal	FILE_callbackop
$L24:
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
LM8:
	.end	loadfilereadcallback
	.def	loadfilesizecallback;	.val	loadfilesizecallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	loadfilesizecallback
loadfilesizecallback:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	17;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$6
	sw	$31,32($sp)
	sw	$16,24($sp)
	lw	$4,24($17)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$16,$17
	.set	macro
	.set	reorder

	lw	$3,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L33
	li	$5,99			# 0x00000063
	.set	macro
	.set	reorder

	lw	$4,28($17)
	.set	noreorder
	.set	nomacro
	jal	FILE_close
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	sw	$2,24($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfileclosecallback) # high
	.set	noreorder
	.set	nomacro
	j	$L37
	addiu	$5,$5,%lo(loadfileclosecallback) # low
	.set	macro
	.set	reorder

$L33:
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	lw	$6,36($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$5,$2
	.set	macro
	.set	reorder

	sw	$2,16($16)
	sw	$2,40($16)
	li	$2,99			# 0x00000063
	sw	$2,16($sp)
	sw	$16,20($sp)
	lw	$4,28($16)
	lw	$5,32($16)
	lw	$7,readblocksize
	lw	$6,40($16)
	jal	FILE_read
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfilereadcallback) # high
	addiu	$5,$5,%lo(loadfilereadcallback) # low
$L37:
	jal	FILE_callbackop
$L32:
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
LM9:
	.end	loadfilesizecallback
	.def	loadfileopencallback;	.val	loadfileopencallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	loadfileopencallback
loadfileopencallback:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	16;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$6
	sw	$31,32($sp)
	sw	$17,28($sp)
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$17,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L39
	sw	$4,28($16)
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	beq	$2,$0,$L40
	.set	noreorder
	.set	nomacro
	jal	cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L42
$L40:
	.set	noreorder
	.set	nomacro
	jal	finishrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L42
$L39:
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$5,99			# 0x00000063
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_close
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfileclosecallback) # high
	.set	noreorder
	.set	nomacro
	j	$L50
	addiu	$5,$5,%lo(loadfileclosecallback) # low
	.set	macro
	.set	reorder

$L43:
	lw	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L46
	li	$2,99			# 0x00000063
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	sw	$16,20($sp)
	lw	$4,28($16)
	lw	$5,32($16)
	lw	$7,readblocksize
	lw	$6,40($16)
	jal	FILE_read
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfilereadcallback) # high
	.set	noreorder
	.set	nomacro
	j	$L50
	addiu	$5,$5,%lo(loadfilereadcallback) # low
	.set	macro
	.set	reorder

$L46:
	.set	noreorder
	.set	nomacro
	jal	FILE_size
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	sw	$2,24($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfilesizecallback) # high
	addiu	$5,$5,%lo(loadfilesizecallback) # low
$L50:
	jal	FILE_callbackop
	.def	done;	.val	$L42;	.scl	6;	.type	0x0;	.endef
$L42:
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
LM10:
	.end	loadfileopencallback
	.def	loadsegreadcallback;	.val	loadsegreadcallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	loadsegreadcallback
loadsegreadcallback:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	status;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	req;	.val	16;	.scl	17;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$6
	sw	$31,32($sp)
	sw	$17,28($sp)
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	move	$17,$16
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$2,8($16)
	lw	$3,32($16)
	addu	$2,$2,$4
	sw	$2,8($16)
	lw	$2,12($16)
	addu	$3,$3,$4
	sw	$3,32($16)
	sw	$3,asyncfileoffset
	beq	$2,$0,$L52
	.set	noreorder
	.set	nomacro
	jal	cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L53
$L52:
	lw	$3,readblocksize
	#nop
	slt	$2,$4,$3
	beq	$2,$0,$L54
	.set	noreorder
	.set	nomacro
	jal	finishrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L53
$L54:
	lw	$2,36($16)
	#nop
	subu	$2,$2,$4
	sw	$2,36($16)
	lw	$2,40($16)
	lw	$7,36($16)
	addu	$2,$2,$4
	sw	$2,40($16)
	slt	$2,$3,$7
	beq	$2,$0,$L55
	move	$7,$3
$L55:
	lw	$4,asyncfilehandle
	li	$2,99			# 0x00000063
	sw	$2,16($sp)
	sw	$17,20($sp)
	lw	$5,32($17)
	lw	$6,40($17)
	jal	FILE_read
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L53
	sw	$2,24($17)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadsegreadcallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(loadsegreadcallback) # low
	.set	macro
	.set	reorder

	.def	done;	.val	$L53;	.scl	6;	.type	0x0;	.endef
$L53:
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
LM11:
	.end	loadsegreadcallback
	.def	asyncsystemtask;	.val	asyncsystemtask;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncsystemtask
asyncsystemtask:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$4,callqueuehead
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L64
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L60:
	lw	$2,12($16)
	#nop
	beq	$2,$0,$L61
	.set	noreorder
	.set	nomacro
	jal	cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L62
$L61:
	lw	$4,0($16)
	lw	$2,20($16)
	#nop
	jal	$31,$2
	la	$4,freequeuehead
	lbu	$2,0($16)
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	queueadd
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L62:
	la	$4,callqueuehead
$L64:
	jal	queuefetch
	move	$16,$2
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L60
	move	$2,$0
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
LM12:
	.end	asyncsystemtask
	.def	initasync;	.val	initasync;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	initasync
initasync:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	numreq;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	blocksize;	.val	3;	.scl	17;	.type	0x4;	.endef
	.def	memclass;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	lw	$2,request
	move	$3,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	slt	$2,$17,257
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L66
	lui	$4,%hi($LC1) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC1) # low
	sll	$16,$17,1
	addu	$16,$16,$17
	sll	$16,$16,2
	subu	$16,$16,$17
	sll	$16,$16,2
	sw	$3,readblocksize
	sw	$17,numrequests
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$16,$16,-44
	sw	$2,request
	sw	$2,freequeuehead
	addu	$2,$2,$16
	sw	$2,freequeuetail
	sw	$0,callqueuehead
	sw	$0,callqueuetail
	sw	$0,asyncfilehandle
	jal	allocmutex
	sw	$2,mutex
	.set	noreorder
	.set	nomacro
	blez	$17,$L68
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$6,request
	li	$5,44			# 0x0000002c
	move	$3,$6
$L70:
	addu	$2,$6,$5
	addu	$5,$5,44
	sw	$4,0($3)
	sw	$2,4($3)
	sw	$0,24($3)
	addu	$4,$4,1
	slt	$2,$4,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	addu	$3,$3,44
	.set	macro
	.set	reorder

$L68:
	lui	$4,%hi(asyncsystemtask) # high
	addiu	$4,$4,%lo(asyncsystemtask) # low
	li	$5,1			# 0x00000001
	move	$6,$5
	sll	$2,$17,$5
	addu	$2,$2,$17
	sll	$2,$2,2
	subu	$2,$2,$17
	lw	$3,request
	sll	$2,$2,2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	sw	$0,-40($2)
	.set	macro
	.set	reorder

$L66:
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
LM13:
	.end	initasync
	.def	asyncloadfilecallback;	.val	asyncloadfilecallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadfilecallback
asyncloadfilecallback:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	memclass;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	cb;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	la	$4,freequeuehead
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	queuefetch
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L75
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	newrequestid
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,1			# 0x00000001
	move	$2,$5
	li	$6,100			# 0x00000064
	move	$7,$16
	sw	$0,8($16)
	sw	$0,12($16)
	sw	$2,16($16)
	sw	$18,20($16)
	sw	$0,32($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	sw	$19,36($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L74
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfileopencallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(loadfileopencallback) # low
	.set	macro
	.set	reorder

	lw	$2,0($16)
	j	$L75
$L74:
	move	$2,$0
$L75:
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
	.end	asyncloadfilecallback
	.def	asyncloadfile;	.val	asyncloadfile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadfile
asyncloadfile:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memclass;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncloadfilecallback
	move	$6,$0
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
LM15:
	.end	asyncloadfile
	.def	asyncloadfileatcallback;	.val	asyncloadfileatcallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadfileatcallback
asyncloadfileatcallback:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	cb;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	la	$4,freequeuehead
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	queuefetch
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L80
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	newrequestid
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,1			# 0x00000001
	li	$6,100			# 0x00000064
	move	$7,$16
	sw	$0,8($16)
	sw	$0,12($16)
	sw	$0,16($16)
	sw	$18,20($16)
	sw	$0,32($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_open
	sw	$19,40($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	sw	$2,24($16)
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$5,%hi(loadfileopencallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(loadfileopencallback) # low
	.set	macro
	.set	reorder

	lw	$2,0($16)
	j	$L80
$L79:
	move	$2,$0
$L80:
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
LM16:
	.end	asyncloadfileatcallback
	.def	asyncloadfileat;	.val	asyncloadfileat;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadfileat
asyncloadfileat:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	name;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncloadfileatcallback
	move	$6,$0
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
LM17:
	.end	asyncloadfileat
	.def	setasyncfile;	.val	setasyncfile;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	setasyncfile
setasyncfile:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	name;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lw	$4,asyncfilehandle
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L83
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

$L83:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L84
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$0,asyncfilehandle
	j	$L82
$L84:
	li	$5,1			# 0x00000001
	la	$7,asyncfilehandle
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	li	$6,100			# 0x00000064
	.set	macro
	.set	reorder

	sw	$0,asyncfileoffset
$L82:
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
LM18:
	.end	setasyncfile
	.def	asyncloadsegmentcallback;	.val	asyncloadsegmentcallback;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadsegmentcallback
asyncloadsegmentcallback:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	offset;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	size;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	cb;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$4
	sw	$20,40($sp)
	move	$20,$5
	sw	$17,28($sp)
	move	$17,$6
	sw	$18,32($sp)
	move	$18,$7
	la	$4,freequeuehead
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	queuefetch
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L90
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	newrequestid
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,asyncfilehandle
	sw	$0,8($16)
	sw	$0,12($16)
	sw	$0,16($16)
	sw	$18,20($16)
	sw	$19,32($16)
	sw	$17,36($16)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L87
	sw	$20,40($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	finishrequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L92
$L87:
	lw	$3,readblocksize
	#nop
	slt	$2,$3,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L93
	li	$2,100			# 0x00000064
	.set	macro
	.set	reorder

	move	$17,$3
$L93:
	sw	$2,16($sp)
	sw	$16,20($sp)
	lw	$5,32($16)
	lw	$6,40($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_read
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L89
	sw	$2,24($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L90
	move	$2,$0
	.set	macro
	.set	reorder

$L89:
	move	$4,$2
	lui	$5,%hi(loadsegreadcallback) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_callbackop
	addiu	$5,$5,%lo(loadsegreadcallback) # low
	.set	macro
	.set	reorder

$L92:
	lw	$2,0($16)
$L90:
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
LM19:
	.end	asyncloadsegmentcallback
	.def	asyncloadsegment;	.val	asyncloadsegment;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	asyncloadsegment
asyncloadsegment:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	offset;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	dest;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	size;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncloadsegmentcallback
	move	$7,$0
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
LM20:
	.end	asyncloadsegment
	.def	cancelasyncload;	.val	cancelasyncload;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	cancelasyncload
cancelasyncload:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	locaterequest
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L95
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L95
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_cancelop
	sw	$2,12($16)
	.set	macro
	.set	reorder

	lw	$2,24($16)
	#nop
	bne	$2,$0,$L95
	lw	$2,20($16)
	#nop
	bne	$2,$0,$L95
	.set	noreorder
	.set	nomacro
	jal	cancelrequest
	move	$4,$16
	.set	macro
	.set	reorder

$L95:
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
	.end	cancelasyncload
	.def	getasyncreadadr;	.val	getasyncreadadr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	getasyncreadadr
getasyncreadadr:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	locaterequest
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L107
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,12($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L107
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,24($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L107
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$16,16($5)
	li	$2,1			# 0x00000001
	bne	$16,$2,$L104
	move	$16,$0
$L104:
	lw	$2,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L107
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$2,20($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L107
	move	$2,$16
	.set	macro
	.set	reorder

	lbu	$2,0($5)
	la	$4,freequeuehead
	.set	noreorder
	.set	nomacro
	jal	queueadd
	sw	$2,0($5)
	.set	macro
	.set	reorder

	move	$2,$16
$L107:
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
	.end	getasyncreadadr
	.def	getasyncreadstatus;	.val	getasyncreadstatus;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	getasyncreadstatus
getasyncreadstatus:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	locaterequest
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L116
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$2,12($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$2,24($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$16,8($5)
	#nop
	bne	$16,$0,$L113
	li	$16,-1			# 0xffffffff
$L113:
	lw	$2,16($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$2,20($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	move	$2,$16
	.set	macro
	.set	reorder

	lbu	$2,0($5)
	la	$4,freequeuehead
	.set	noreorder
	.set	nomacro
	jal	queueadd
	sw	$2,0($5)
	.set	macro
	.set	reorder

	move	$2,$16
$L116:
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
LM23:
	.end	getasyncreadstatus
	.def	request;	.val	request;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	numrequests;	.val	numrequests;	.scl	2;	.type	0x4;	.endef
	.def	readblocksize;	.val	readblocksize;	.scl	2;	.type	0x4;	.endef
	.def	requestidcounter;	.val	requestidcounter;	.scl	2;	.type	0x4;	.endef
	.def	freequeuehead;	.val	freequeuehead;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	freequeuetail;	.val	freequeuetail;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	callqueuehead;	.val	callqueuehead;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	callqueuetail;	.val	callqueuetail;	.scl	2;	.tag	AsyncReq;	.size	44;	.type	0x18;	.endef
	.def	asyncfilehandle;	.val	asyncfilehandle;	.scl	2;	.type	0x4;	.endef
	.def	asyncfileoffset;	.val	asyncfileoffset;	.scl	2;	.type	0x4;	.endef
	.def	mutex;	.val	mutex;	.scl	2;	.type	0x11;	.endef
