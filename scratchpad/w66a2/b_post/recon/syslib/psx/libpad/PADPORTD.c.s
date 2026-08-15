	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADPORTD.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	PadInitDirect
	.ent	PadInitDirect
PadInitDirect:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	addu	$17,$4,$0
	sw	$18,24($sp)
	sw	$31,28($sp)
	sw	$16,16($sp)
	sw	$0,_padIntExec
	sw	$0,_padModeMtap
	.set	noreorder
	.set	nomacro
	jal	_padInitDirSeq
	addu	$18,$5,$0
	.set	macro
	.set	reorder

	la	$16,_pad_info
 #APP
 #NO_APP
	la	$2,_pad_failall
	sw	$2,_padFuncNextPort
	la	$2,_pad_reset_state
	sw	$2,_padFuncClrInfo
	la	$2,_pad_getbyte
	sw	$2,_padFuncGetTxd
	la	$2,_pad_filter
	sw	$2,_padFuncCurrLimit
	la	$2,_pad_port_to_slot
	sw	$2,_padFuncPtr2Port
	la	$2,_pad_get_port
	sw	$2,_padFuncPort2Info
	la	$2,_pad_shift
	addu	$4,$16,$0
	sw	$16,_padInfoDir
	sw	$2,_padFuncClrCmdNo
	.set	noreorder
	.set	nomacro
	jal	bzero
	li	$5,0x000001e0		# 480
	.set	macro
	.set	reorder

	addu	$8,$0,$0
	li	$9,0x000000ff		# 255
	addu	$4,$16,64
	la	$7,_pad_buf2
	la	$6,_pad_rxbuf
	sw	$17,48($16)
	sw	$18,288($16)
$L5:
	lw	$2,-16($4)
	addu	$5,$16,93
	sw	$0,-52($4)
	sw	$16,-48($4)
	sb	$9,0($2)
	lw	$2,-16($4)
	li	$3,0x00000005		# 5
	sb	$0,1($2)
	sw	$6,-4($4)
	sw	$7,0($4)
$L6:
	sb	$9,0($5)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L6
	addu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$7,$7,35
	addu	$6,$6,35
	addu	$8,$8,1
	addu	$4,$4,240
	slt	$2,$8,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$16,$16,240
	.set	macro
	.set	reorder

	jal	_padSetVsyncParam
	li	$2,0x00000001		# 1
	sw	$2,_padIntExec
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	PadInitDirect
	.align	2
	.globl	_pad_reset_state
	.ent	_pad_reset_state
_pad_reset_state:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,73($4)
	#nop
	beq	$2,$0,$L12
	addu	$3,$4,93
	li	$5,0x000000ff		# 255
	li	$2,0x00000005		# 5
	sb	$0,73($4)
	sb	$0,70($4)
	sh	$0,230($4)
	sw	$0,20($4)
	sw	$0,24($4)
	sb	$0,227($4)
	sb	$0,228($4)
	sh	$0,230($4)
	sb	$0,233($4)
	sb	$0,234($4)
	sw	$0,0($4)
	sw	$0,4($4)
	sw	$0,8($4)
$L13:
	sb	$5,0($3)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bgez	$2,$L13
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L12:
	j	$31
	.end	_pad_reset_state
	.align	2
	.globl	_pad_failall
	.ent	_pad_failall
_pad_failall:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	li	$19,-9			# 0xfffffff7
	sw	$17,20($sp)
	la	$17,_pad_info
	sw	$18,24($sp)
	la	$18,_padFixResult
	sw	$31,32($sp)
	sw	$16,16($sp)
$L18:
	lw	$3,_padSioChan
	#nop
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$4,$19,$L28
	addu	$16,$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L22
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	j	$L21
	sw	$0,0($2)
	.set	macro
	.set	reorder

$L22:
	.set	noreorder
	.set	nomacro
	jal	_dirFailAuto
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_pad_shift
	addu	$4,$16,$0
	.set	macro
	.set	reorder

$L21:
	lw	$3,_padSioChan
$L28:
	lw	$2,_padSioRegs
	sw	$0,_padSioState
	#.set	volatile
	sh	$0,10($2)
	#.set	novolatile
	lw	$2,_padChanStop
	addu	$3,$3,1
	sw	$3,_padSioChan
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	sll	$4,$3,4
	subu	$4,$4,$3
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	_padInitSioMode
	addu	$4,$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L27
	li	$4,0x0000ffff		# 65535
	.set	macro
	.set	reorder

$L24:
	li	$4,0x0000ffff		# 65535
$L27:
 #APP
 #NO_APP
	beq	$2,$0,$L18
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_pad_failall
	.align	2
	.globl	_pad_shift
	.ent	_pad_shift
_pad_shift:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,54($4)
	sb	$0,54($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,55($4)
	.set	macro
	.set	reorder

	.end	_pad_shift
	.align	2
	.globl	_pad_getbyte
	.ent	_pad_getbyte
_pad_getbyte:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,69($4)
	lbu	$5,54($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L32
	addu	$3,$2,-3
	.set	macro
	.set	reorder

	li	$2,0x0000004d		# 77
	beq	$5,$2,$L35
	j	$L37
$L32:
	slt	$2,$3,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	addu	$2,$4,$3
	.set	macro
	.set	reorder

	lbu	$2,87($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L33:
	lbu	$2,52($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,40($4)
	.set	noreorder
	.set	nomacro
	j	$L43
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L35:
	lbu	$2,53($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	li	$2,0x000000ff		# 255
	.set	macro
	.set	reorder

	lw	$2,44($4)
	.set	noreorder
	.set	nomacro
	j	$L43
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L37:
	lbu	$2,53($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,44($4)
 #APP
 #NO_APP
	#nop
	addu	$2,$2,$3
$L43:
	lbu	$2,0($2)
$L40:
$L42:
	j	$31
	.end	_pad_getbyte
	.align	2
	.globl	_pad_filter
	.ent	_pad_filter
_pad_filter:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	addu	$4,$16,87
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	bzero
	li	$5,0x00000006		# 6
	.set	macro
	.set	reorder

	lhu	$2,230($16)
	#nop
	beq	$2,$0,$L45
	lw	$2,40($16)
	#nop
	beq	$2,$0,$L45
	#.set	volatile
	lbu	$2,52($16)
	#.set	novolatile
	#nop
	sltu	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	li	$9,0x00000006		# 6
	.set	macro
	.set	reorder

	lbu	$9,52($16)
$L46:
	lbu	$2,233($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L71
	addu	$8,$0,$0
	.set	macro
	.set	reorder

	li	$11,0x00000001		# 1
	addu	$10,$0,$0
$L49:
	lw	$2,4($16)
	addu	$6,$0,$0
	addu	$2,$10,$2
	lbu	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	li	$7,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$7,0x000000ff		# 255
$L52:
	addu	$5,$16,93
	lw	$4,40($16)
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L58
	addu	$3,$0,$0
	.set	macro
	.set	reorder

$L54:
	lbu	$2,0($5)
	#nop
	bne	$2,$8,$L57
	lbu	$2,0($4)
	#nop
	and	$2,$2,$7
	bne	$2,$0,$L83
$L57:
	addu	$5,$5,1
	addu	$3,$3,1
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L54
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L58:
	beq	$6,$0,$L63
	lw	$2,4($16)
	#nop
	addu	$2,$10,$2
	lbu	$3,3($2)
	lw	$2,_padTotalCurr
	#nop
	addu	$3,$2,$3
	slt	$2,$3,61
	beq	$2,$0,$L61
	sw	$3,_padTotalCurr
	j	$L60
$L83:
	.set	noreorder
	.set	nomacro
	j	$L58
	li	$6,0x00000001		# 1
	.set	macro
	.set	reorder

$L61:
	addu	$6,$0,$0
$L60:
	beq	$6,$0,$L63
	addu	$5,$16,93
	addu	$4,$16,87
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L63
	addu	$3,$0,$0
	.set	macro
	.set	reorder

$L65:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L68
	addu	$5,$5,1
	.set	macro
	.set	reorder

	sb	$11,0($4)
$L68:
	addu	$3,$3,1
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L63:
	lbu	$2,233($16)
	addu	$8,$8,1
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L49
	addu	$10,$10,5
	.set	macro
	.set	reorder

	j	$L71
$L45:
	lbu	$3,232($16)
	#nop
	addu	$2,$3,-4
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	li	$2,0x00000007		# 7
	.set	macro
	.set	reorder

	bne	$3,$2,$L72
$L73:
	lhu	$2,230($16)
	#nop
	bne	$2,$0,$L72
	lbu	$2,52($16)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	li	$3,0x00000040		# 64
	.set	macro
	.set	reorder

	lw	$4,40($16)
	#nop
	lbu	$2,0($4)
	#nop
	andi	$2,$2,0x00c0
	bne	$2,$3,$L71
	lbu	$2,1($4)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L71
	lw	$2,_padTotalCurr
	#nop
	addu	$2,$2,10
	slt	$2,$2,61
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L71
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	sb	$2,88($16)
	sb	$2,87($16)
	lw	$2,_padTotalCurr
	#nop
	addu	$2,$2,10
	sw	$2,_padTotalCurr
	j	$L71
$L72:
 #APP
 #NO_APP
	lbu	$3,232($16)
	li	$2,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L76
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L71
	sb	$2,87($16)
	.set	macro
	.set	reorder

$L76:
	lhu	$2,230($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L71
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	li	$3,0x00000005		# 5
	addu	$4,$16,5
$L79:
	sb	$2,87($4)
 #APP
 #NO_APP
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L79
	addu	$4,$4,-1
	.set	macro
	.set	reorder

$L71:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_pad_filter
	.align	2
	.globl	_pad_port_to_slot
	.ent	_pad_port_to_slot
_pad_port_to_slot:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$5,$0,$0
	li	$6,0x00000010		# 16
	la	$3,_pad_info
$L85:
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L89
	addu	$2,$6,$0
	.set	macro
	.set	reorder

	addu	$6,$6,16
	addu	$5,$5,1
	slt	$2,$5,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L85
	addu	$3,$3,240
	.set	macro
	.set	reorder

	li	$2,0x000000ff		# 255
$L89:
	j	$31
	.end	_pad_port_to_slot
	.align	2
	.globl	_pad_get_port
	.ent	_pad_get_port
_pad_get_port:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$2,_pad_info
	andi	$4,$4,0x00f0
	beq	$4,$0,$L92
	addu	$2,$2,240
$L92:
	j	$31
	.end	_pad_get_port

	.lcomm	_pad_rxbuf,70

	.lcomm	_pad_buf2,70

	.lcomm	_pad_info,480
