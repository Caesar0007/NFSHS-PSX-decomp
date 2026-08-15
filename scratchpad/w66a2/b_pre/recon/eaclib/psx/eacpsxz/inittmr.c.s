	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\inittmr.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	memclass
	.section	.bss
	.align	2
memclass:
	.space	64
	.text
 #NO_APP
	.globl	DAT_8013dd48
	.sdata
	.align	2
DAT_8013dd48:
	.ascii	"RAM\000"
	.text
	.align	2
	.globl	initmemadr
	.align	2
	.globl	inittimer
	.align	2
	.globl	restoretimer
	.align	2
	.globl	tmrint

	.comm	timerflag,4

	.comm	timerevent,4

	.comm	reentryflag,4

	.extern	libticks, 4
	.extern	g_currentthread, 4
	.extern	ticks, 4
	.extern	timerhz, 4

	.text
	.def	initmemadr;	.val	initmemadr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	initmemadr
initmemadr:
	.frame	$sp,56,$31		# vars= 0, regs= 1/0, args= 48, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	base;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	size;	.val	7;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	move	$6,$4
	move	$7,$5
	li	$2,8			# 0x00000008
	sw	$2,16($sp)
	li	$2,32			# 0x00000020
	sw	$2,20($sp)
	lui	$2,%hi(MEM_defaultevent) # high
	addiu	$2,$2,%lo(MEM_defaultevent) # low
	lui	$5,%hi(DAT_8013dd48) # high
	move	$4,$0
	addiu	$5,$5,%lo(DAT_8013dd48) # low
	sw	$31,48($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	sw	$0,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	jal	creatememclass
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(memclass) # high
	lw	$4,%lo(memclass)($3)
	addiu	$3,$3,%lo(memclass) # low
	sw	$4,4($3)
	lw	$31,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	initmemadr
	.def	inittimer;	.val	inittimer;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	inittimer
inittimer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	hz;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L3
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	li	$16,100			# 0x00000064
$L3:
	jal	EnterCriticalSection
	lw	$2,timerflag
	#nop
	bne	$2,$0,$L4
	lui	$4,%hi(tmrsub) # high
	addiu	$4,$4,%lo(tmrsub) # low
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$4,-234881024			# 0xf2000000
	ori	$4,$4,0x0002
	li	$5,2			# 0x00000002
	li	$6,4096			# 0x00001000
	lui	$7,%hi(tmrint) # high
	.set	noreorder
	.set	nomacro
	jal	OpenEvent
	addiu	$7,$7,%lo(tmrint) # low
	.set	macro
	.set	reorder

	move	$4,$2
	sw	$4,timerevent
	jal	EnableEvent
	lui	$4,%hi(restoretimer) # high
	li	$2,1			# 0x00000001
	sw	$2,timerflag
	.set	noreorder
	.set	nomacro
	jal	addexit
	addiu	$4,$4,%lo(restoretimer) # low
	.set	macro
	.set	reorder

$L4:
	jal	initgp
	li	$5,4194304			# 0x00400000
	ori	$5,$5,0x9980
	div	$5,$5,$16
	li	$4,-234881024			# 0xf2000000
	ori	$4,$4,0x0002
	li	$6,4096			# 0x00001000
	sw	$16,timerhz
	sw	$0,reentryflag
	.set	noreorder
	.set	nomacro
	jal	SetRCnt
	andi	$5,$5,0xffff
	.set	macro
	.set	reorder

	li	$4,-234881024			# 0xf2000000
	.set	noreorder
	.set	nomacro
	jal	StartRCnt
	ori	$4,$4,0x0002
	.set	macro
	.set	reorder

	jal	ExitCriticalSection
	jal	resettick
	lui	$4,%hi(restoretimer) # high
	.set	noreorder
	.set	nomacro
	jal	addexit
	addiu	$4,$4,%lo(restoretimer) # low
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
LM2:
	.end	inittimer
	.def	restoretimer;	.val	restoretimer;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	restoretimer
restoretimer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,timerevent
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	DisableEvent
	lw	$31,16($sp)
	sw	$0,timerflag
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	restoretimer
	.def	tmrint;	.val	tmrint;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	tmrint
tmrint:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	addu	$4,$sp,16
	sw	$31,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	savegp
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$3,%hi(tmrsub) # high
	#.set	volatile
	lw	$2,ticks
	#.set	novolatile
	addiu	$16,$3,%lo(tmrsub) # low
	addu	$2,$2,1
	#.set	volatile
	sw	$2,ticks
	#.set	novolatile
	#.set	volatile
	lw	$2,libticks
	#.set	novolatile
	li	$3,1			# 0x00000001
	sw	$3,g_currentthread
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,libticks
	#.set	novolatile
$L7:
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L10
	jal	$31,$2
$L10:
	addu	$17,$17,1
	slt	$2,$17,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	sw	$0,g_currentthread
	jal	restoregp
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	tmrint
	.def	timerflag;	.val	timerflag;	.scl	2;	.type	0x4;	.endef
	.def	timerevent;	.val	timerevent;	.scl	2;	.type	0x4;	.endef
	.def	reentryflag;	.val	reentryflag;	.scl	2;	.type	0x4;	.endef
	.def	DAT_8013dd48;	.val	DAT_8013dd48;	.scl	2;	.dim	4;	.size	4;	.type	0x32;	.endef
