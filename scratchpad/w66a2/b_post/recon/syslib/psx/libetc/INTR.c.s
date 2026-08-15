	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libetc\\INTR.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	ResetCallback
	.ent	ResetCallback
ResetCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,D_80135B80
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,12($2)
	#nop
	jal	$31,$2
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	ResetCallback
	.align	2
	.globl	InterruptCallback
	.ent	InterruptCallback
InterruptCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,D_80135B80
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,8($2)
	#nop
	jal	$31,$2
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	InterruptCallback
	.align	2
	.globl	DMACallback
	.ent	DMACallback
DMACallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,D_80135B80
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,4($2)
	#nop
	jal	$31,$2
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	DMACallback
	.align	2
	.globl	VSyncCallback
	.ent	VSyncCallback
VSyncCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$2,D_80135B80
	addu	$5,$4,$0
	sw	$31,16($sp)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,0x00000004		# 4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	VSyncCallback
	.align	2
	.globl	VSyncCallbacks
	.ent	VSyncCallbacks
VSyncCallbacks:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,D_80135B80
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,20($2)
	#nop
	jal	$31,$2
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	VSyncCallbacks
	.align	2
	.globl	CheckCallback
	.ent	CheckCallback
CheckCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,D_80134AF8+2
	j	$31
	.end	CheckCallback
	.align	2
	.globl	SetIntrMask
	.ent	SetIntrMask
SetIntrMask:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,D_80135B88
	#nop
	lhu	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$4,0($3)
	.set	macro
	.set	reorder

	.end	SetIntrMask
	.align	2
	.globl	_initIntr
	.ent	_initIntr
_initIntr:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	la	$16,D_80134AF8
	sw	$31,20($sp)
	lhu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$3,D_80135B84
	lw	$2,D_80135B88
	li	$5,0x33330000		# 858980352
	#.set	volatile
	sh	$0,0($2)
	#.set	novolatile
	#.set	volatile
	lhu	$2,0($2)
	#.set	novolatile
	ori	$5,$5,0x3333
	#.set	volatile
	sh	$2,0($3)
	#.set	novolatile
	lw	$2,D_80135B8C
	addu	$4,$16,$0
	#.set	volatile
	sw	$5,0($2)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	_bzero_w
	li	$5,0x0000041a		# 1050
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	setjmp
	addu	$4,$16,56
	.set	macro
	.set	reorder

	beq	$2,$0,$L10
	jal	_intrhand
$L10:
	la	$16,D_80134AF8+60
	addu	$4,$16,-4
	addu	$2,$16,4060
	.set	noreorder
	.set	nomacro
	jal	HookEntryInt
	sw	$2,0($16)
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	jal	startIntrVSync
	sh	$2,-60($16)
	.set	macro
	.set	reorder

	lw	$3,D_80135B80
	.set	noreorder
	.set	nomacro
	jal	startIntrDMA
	sw	$2,20($3)
	.set	macro
	.set	reorder

	lw	$3,D_80135B80
	.set	noreorder
	.set	nomacro
	jal	_96_remove
	sw	$2,4($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ExitCriticalSection
	addu	$16,$16,-60
	.set	macro
	.set	reorder

	addu	$2,$16,$0
$L11:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_initIntr
	.rdata
	.align	2
$LC0:
	.ascii	"unexpected interrupt(%04x)\n\000"
	.align	2
$LC1:
	.ascii	"intr timeout(%04x:%04x)\n\000"
	.text
	.align	2
	.globl	_intrhand
	.ent	_intrhand
_intrhand:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	la	$17,D_80134AF8
 #APP
 #NO_APP
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lhu	$2,0($17)
	#nop
	bne	$2,$0,$L13
	lw	$2,D_80135B84
	#nop
	#.set	volatile
	lhu	$5,0($2)
	#.set	novolatile
	la	$4,$LC0
	jal	printf
	jal	ReturnFromException
$L13:
	lw	$4,D_80135B88
	lw	$3,D_80135B84
	li	$2,0x00000001		# 1
	sh	$2,2($17)
	lhu	$2,48($17)
	#.set	volatile
	lhu	$3,0($3)
	#.set	novolatile
	#.set	volatile
	lhu	$4,0($4)
	#.set	novolatile
	and	$2,$2,$3
	and	$4,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L14
	addu	$16,$4,$0
	.set	macro
	.set	reorder

	li	$19,0x00000001		# 1
	addu	$20,$17,4
$L15:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L18
	addu	$17,$0,$0
	.set	macro
	.set	reorder

	addu	$18,$20,$0
$L25:
	slt	$2,$17,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	andi	$2,$16,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	sll	$2,$19,$17
	.set	macro
	.set	reorder

	lw	$3,D_80135B84
	nor	$2,$0,$2
	#.set	volatile
	sh	$2,0($3)
	#.set	novolatile
	lw	$2,0($18)
	#nop
	beq	$2,$0,$L23
	jal	$31,$2
$L23:
	addu	$18,$18,4
	srl	$16,$16,1
	andi	$2,$16,0xffff
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L25
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L18:
	lw	$4,D_80135B88
	lw	$3,D_80135B84
	lhu	$2,D_80134AF8+48
	#.set	volatile
	lhu	$3,0($3)
	#.set	novolatile
	#.set	volatile
	lhu	$4,0($4)
	#.set	novolatile
	and	$2,$2,$3
	and	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L15
	addu	$16,$4,$0
	.set	macro
	.set	reorder

$L14:
	lw	$5,D_80135B84
	lw	$6,D_80135B88
	#.set	volatile
	lhu	$3,0($5)
	#.set	novolatile
	#.set	volatile
	lhu	$2,0($6)
	#.set	novolatile
	#nop
	and	$2,$2,$3
	beq	$2,$0,$L27
	la	$2,D_80135B90
	lw	$3,0($2)
	#nop
	addu	$4,$3,$0
	addu	$3,$3,1
	slt	$4,$4,2049
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L29
	sw	$3,0($2)
	.set	macro
	.set	reorder

	la	$4,$LC1
	#.set	volatile
	lhu	$5,0($5)
	#.set	novolatile
	#.set	volatile
	lhu	$6,0($6)
	#.set	novolatile
	jal	printf
	lw	$2,D_80135B84
	sw	$0,D_80135B90
	#.set	volatile
	sh	$0,0($2)
	#.set	novolatile
	j	$L29
$L27:
	sw	$0,D_80135B90
$L29:
	sh	$0,D_80134AF8+2
	jal	ReturnFromException
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_intrhand
	.align	2
	.globl	_set_intr_callback
	.ent	_set_intr_callback
_set_intr_callback:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	addu	$17,$4,$0
 #APP
 #NO_APP
	sw	$18,24($sp)
	addu	$18,$5,$0
	la	$4,D_80134AF8+4
 #APP
 #NO_APP
	sll	$2,$17,2
	addu	$5,$2,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	lw	$20,0($5)
 #APP
 #NO_APP
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$20,$L41
	addu	$2,$20,$0
	.set	macro
	.set	reorder

	lhu	$2,-4($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L41
	addu	$2,$20,$0
	.set	macro
	.set	reorder

	lw	$2,D_80135B88
	#nop
	#.set	volatile
	lhu	$3,0($2)
	#.set	novolatile
	#.set	volatile
	sh	$0,0($2)
	#.set	novolatile
	andi	$3,$3,0xffff
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L34
	andi	$19,$3,0xffff
	.set	macro
	.set	reorder

	li	$3,0x00000001		# 1
	sll	$3,$3,$17
 #APP
 #NO_APP
	sw	$18,0($5)
	lhu	$2,44($4)
	or	$19,$19,$3
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L35
	sh	$2,44($4)
	.set	macro
	.set	reorder

$L34:
	li	$2,0x00000001		# 1
	sll	$2,$2,$17
	nor	$2,$0,$2
	sw	$0,0($5)
	lhu	$3,44($4)
	and	$19,$19,$2
	and	$3,$3,$2
	sh	$3,44($4)
$L35:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L42
	li	$2,0x00000004		# 4
	.set	macro
	.set	reorder

	sltu	$16,$18,1
	.set	noreorder
	.set	nomacro
	jal	ChangeClearPAD
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	li	$4,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	li	$2,0x00000004		# 4
$L42:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L43
	li	$2,0x00000005		# 5
	.set	macro
	.set	reorder

	addu	$4,$0,$0
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	sltu	$5,$18,1
	.set	macro
	.set	reorder

	li	$2,0x00000005		# 5
$L43:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L44
	li	$2,0x00000006		# 6
	.set	macro
	.set	reorder

	li	$4,0x00000001		# 1
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	sltu	$5,$18,1
	.set	macro
	.set	reorder

	li	$2,0x00000006		# 6
$L44:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L39
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	sltu	$5,$18,1
	.set	macro
	.set	reorder

$L39:
	lw	$2,D_80135B88
	#nop
	#.set	volatile
	sh	$19,0($2)
	#.set	novolatile
	addu	$2,$20,$0
$L41:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_set_intr_callback
	.align	2
	.globl	StopCallback
	.ent	StopCallback
StopCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	la	$16,D_80134AF8
 #APP
 #NO_APP
	sw	$31,20($sp)
	lhu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	EnterCriticalSection
	lw	$2,D_80135B88
	lw	$4,D_80135B8C
	#.set	volatile
	lhu	$3,0($2)
	#.set	novolatile
	#nop
	sh	$3,50($16)
	#.set	volatile
	lw	$3,0($4)
	#.set	novolatile
	lw	$4,D_80135B84
	sw	$3,52($16)
	#.set	volatile
	sh	$0,0($2)
	#.set	novolatile
	#.set	volatile
	lhu	$2,0($2)
	#.set	novolatile
	#nop
	#.set	volatile
	sh	$2,0($4)
	#.set	novolatile
	lw	$4,D_80135B8C
	li	$3,0x77770000		# 2004287488
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	ori	$3,$3,0x7777
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	ResetEntryInt
	sw	$2,0($4)
	.set	macro
	.set	reorder

	addu	$2,$16,$0
	sh	$0,0($2)
$L46:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	StopCallback
	.align	2
	.globl	RestartCallback
	.ent	RestartCallback
RestartCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	la	$16,D_80134AF8
 #APP
 #NO_APP
	sw	$31,20($sp)
	lhu	$2,0($16)
	#nop
	bne	$2,$0,$Lfs0_0_45
	addu	$4,$16,56
	jal	HookEntryInt
	lw	$4,D_80135B88
	lhu	$3,50($16)
	li	$2,0x00000001		# 1
	sh	$2,0($16)
	#.set	volatile
	sh	$3,0($4)
	#.set	novolatile
	lw	$3,D_80135B8C
	lw	$2,52($16)
	#nop
	sw	$2,0($3)
	jal	ExitCriticalSection
	addu	$2,$16,$0
	j	$Lfs0_0_46
$Lfs0_0_45:
	addu	$2,$0,$0
$Lfs0_0_46:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	RestartCallback
	.align	2
	.ent	_bzero_w
_bzero_w:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L52
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
$L53:
	sw	$0,0($4)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L53
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L52:
	j	$31
	.end	_bzero_w
