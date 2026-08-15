	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	_padSetVsyncParam
	.ent	_padSetVsyncParam
_padSetVsyncParam:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$2,_padVbCb+4
 #APP
 #NO_APP
	la	$3,_padVbCallback0
	sw	$3,0($2)
	la	$3,_padVbCallback1
	sw	$3,4($2)
	sw	$0,-4($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,8($2)
	.set	macro
	.set	reorder

	.end	_padSetVsyncParam
	.align	2
	.globl	_padVbCallback1
	.ent	_padVbCallback1
_padVbCallback1:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$3,_padIntRegs
	subu	$sp,$sp,24
	sw	$31,16($sp)
	#.set	volatile
	lw	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,_padFuncIntGun
	#nop
	beq	$2,$0,$L4
	jal	$31,$2
$L4:
	li	$2,0x00000001		# 1
$L3:
$L5:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padVbCallback1
	.align	2
	.globl	_padVbCallback0
	.ent	_padVbCallback0
_padVbCallback0:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$3,_padChanStart
	li	$2,0x00000001		# 1
	sw	$31,16($sp)
	sw	$2,_padVbExec
	beq	$3,$0,$L7
	la	$4,_padFrames
	lw	$3,0($4)
	#nop
	slt	$2,$3,150
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,0($4)
$L7:
	lw	$2,_padChanStop
	#nop
	bne	$2,$0,$L9
	la	$4,_padFrames+4
	lw	$3,0($4)
	#nop
	slt	$2,$3,150
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,0($4)
$L9:
	lw	$2,_padIntExec
	#nop
	beq	$2,$0,$L11
	lw	$3,_padChanStart
	lw	$2,_padChanStop
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	sll	$4,$3,4
	.set	macro
	.set	reorder

	subu	$4,$4,$3
	lw	$2,_padInfoDir
	sll	$4,$4,4
	sw	$0,_padSioState
	sw	$3,_padSioChan
	.set	noreorder
	.set	nomacro
	jal	_padInitSioMode
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	bne	$2,$0,$L12
	lw	$2,_padFuncNextPort
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,0x0000ffff		# 65535
	.set	macro
	.set	reorder

$L12:
	lw	$3,_padSioChan
	lw	$2,_padChanStop
	sw	$0,_padTotalCurr
	slt	$2,$2,$3
	bne	$2,$0,$L14
$L15:
	sll	$4,$3,4
	subu	$4,$4,$3
	lw	$2,_padInfoDir
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	_padSioMain
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,_padSioChan
	lw	$2,_padChanStop
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L15
$L14:
	lw	$3,_padSioRegs
	li	$2,0x00000088		# 136
	#.set	volatile
	sh	$2,14($3)
	#.set	novolatile
$L11:
	.set	noreorder
	lw	$31,16($sp)
	addu	$2,$0,$0
	j	$31
	addu	$sp,$sp,24
	.set	reorder
	.end	_padVbCallback0
	.align	2
	.globl	_padStartCom
	.ent	_padStartCom
_padStartCom:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	sw	$0,_padIntExec
	jal	EnterCriticalSection
	li	$4,0x00000002		# 2
	la	$16,_padVbCb
	.set	noreorder
	.set	nomacro
	jal	SysDeqIntRP
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	li	$4,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	jal	SysEnqIntRP
	addu	$5,$16,$0
	.set	macro
	.set	reorder

	li	$4,0x00000003		# 3
	lw	$3,_padIntRegs
	li	$2,-2			# 0xfffffffe
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,4($3)
	#.set	novolatile
	addu	$5,$0,$0
	ori	$2,$2,0x0001
	#.set	volatile
	sw	$2,4($3)
	#.set	novolatile
	jal	ChangeClearRCnt
	jal	ExitCriticalSection
	lw	$4,_padInfoDir
	lw	$2,_padFuncClrInfo
	#nop
	jal	$31,$2
	lw	$4,_padInfoDir
	lw	$2,_padFuncClrInfo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,240
	.set	macro
	.set	reorder

	la	$2,_padFrames
 #APP
 #NO_APP
	sw	$0,4($2)
	sw	$0,0($2)
	li	$2,0x00000001		# 1
	sw	$2,_padIntExec
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padStartCom
	.align	2
	.globl	_padStopCom
	.ent	_padStopCom
_padStopCom:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	EnterCriticalSection
	li	$4,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	la	$5,_padVbCb
	.set	noreorder
	.set	nomacro
	jal	SysDeqIntRP
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	jal	ExitCriticalSection
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padStopCom
	.align	2
	.globl	_padInitSioMode
	.ent	_padInitSioMode
_padInitSioMode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	lw	$3,_padSioRegs
	li	$2,0x00000040		# 64
	sw	$31,24($sp)
	sw	$17,20($sp)
	#.set	volatile
	sh	$2,10($3)
	#.set	novolatile
	li	$2,0x0000000d		# 13
	#.set	volatile
	sh	$0,10($3)
	#.set	novolatile
	#.set	volatile
	sh	$2,8($3)
	#.set	novolatile
	li	$2,0x00000088		# 136
	#.set	volatile
	sh	$2,14($3)
	#.set	novolatile
	lbu	$3,232($16)
	li	$2,0x00000008		# 8
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L20
	li	$4,0x00000091		# 145
	.set	macro
	.set	reorder

	li	$4,0x00000050		# 80
$L20:
	jal	setRC2wait
	lw	$4,_padSioRegs
	lw	$2,_padSioChan
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L25
	li	$3,0x00001003		# 4099
	.set	macro
	.set	reorder

	li	$3,0x00003003		# 12291
$L25:
	#.set	volatile
	sh	$3,10($4)
	#.set	novolatile
	sll	$2,$2,2
	lw	$2,_padFixResult($2)
	#nop
	bltz	$2,$L28
	blez	$2,$L29
	la	$17,_padFixResult
$L30:
	lw	$3,_padSioChan
	#nop
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$2,0($3)
	#nop
	addu	$2,$2,-1
	sll	$4,$2,4
	subu	$4,$4,$2
	sll	$4,$4,4
	sw	$2,0($3)
	lw	$2,12($16)
	lw	$3,_padFuncRecvAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,_padSioChan
	#nop
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$2,0($2)
	#nop
	bgtz	$2,$L30
$L29:
	lw	$2,_padSioChan
	la	$3,_padFixResult
	sll	$2,$2,2
	addu	$5,$2,$3
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$4,$16,$0
	lw	$2,_padFuncRecvAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$3,0($5)
	.set	macro
	.set	reorder

	lw	$2,_padFuncClrCmdNo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$0
	.set	macro
	.set	reorder

$L28:
	lw	$3,_padSioRegs
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L35
	#.set	volatile
	lhu	$2,10($3)
	#.set	novolatile
	#nop
	ori	$2,$2,0x0010
	#.set	volatile
	sh	$2,10($3)
	#.set	novolatile
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L36
	li	$2,-129			# 0xffffff7f
	.set	macro
	.set	reorder

$L37:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L37
	li	$4,0x00000064		# 100
	.set	macro
	.set	reorder

	lw	$3,_padSioRegs
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$2,_padSioRegs
	li	$4,0x000001ae		# 430
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	j	$L58
$L43:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L55
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L58:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	lw	$3,_padSioRegs
	li	$2,0x00000042		# 66
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$2,_padSioRegs
	li	$4,0x000001ae		# 430
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	j	$L59
$L49:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L55
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L59:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	lw	$3,_padSioRegs
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$3,_padSioRegs
	addu	$2,$0,$0
	#.set	volatile
	lbu	$3,0($3)
	#.set	novolatile
	j	$L55
$L36:
	lw	$3,_padIntRegs
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
$L35:
	lbu	$2,80($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L55
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	lbu	$2,54($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L54
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
 #APP
 #NO_APP
$L54:
$L55:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_padInitSioMode
	.align	2
	.globl	_padSioMain
	.ent	_padSioMain
_padSioMain:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$5,_padSioState
	sw	$31,16($sp)
	lw	$3,0($5)
	#nop
	sll	$2,$3,2
	lw	$2,padIntFunc($2)
 #APP
 #NO_APP
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$3,0($5)
	.set	macro
	.set	reorder

	addu	$4,$2,$0
	bltz	$4,$L61
	lw	$2,_padSioState
	#nop
	beq	$2,$0,$L62
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	jal	_padClrIntSio0
	bne	$2,$0,$L62
	lw	$2,_padFuncNextPort
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,-3			# 0xfffffffd
	.set	macro
	.set	reorder

$L62:
	lw	$3,_padSioState
	#nop
	slt	$2,$3,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sw	$2,_padSioState
	j	$L65
$L61:
	lw	$2,_padFuncNextPort
	#nop
	jal	$31,$2
$L65:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padSioMain
	.align	2
	.globl	_padSioRW
	.ent	_padSioRW
_padSioRW:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$18,24($sp)
	addu	$18,$5,$0
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	bgez	$18,$L67
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$2,_padSioRegs
	lw	$3,64($16)
	#.set	volatile
	lbu	$4,0($2)
	#.set	novolatile
	li	$2,0x000000ff		# 255
	sb	$2,68($16)
	li	$2,0x00000001		# 1
	sb	$2,69($16)
	nor	$2,$0,$18
	sb	$2,0($3)
	lw	$3,_padSioRegs
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	andi	$17,$4,0x00ff
	.set	macro
	.set	reorder

$L68:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L68
$L72:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L72
	nor	$2,$0,$18
	.set	macro
	.set	reorder

	lw	$3,_padSioRegs
	#nop
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L89
	addu	$2,$17,$0
	.set	macro
	.set	reorder

$L67:
	lw	$2,60($16)
	#nop
	lbu	$2,0($2)
	li	$3,0x00000008		# 8
	sra	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L77
	li	$6,0x00000088		# 136
	.set	macro
	.set	reorder

	lbu	$2,68($16)
	#nop
	sltu	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L91
	li	$2,0x1f800000		# 528482304
	.set	macro
	.set	reorder

	li	$6,0x00000022		# 34
$L77:
	li	$2,0x1f800000		# 528482304
$L91:
	ori	$2,$2,0x1120
	lw	$5,_padSioRegs
	#.set	volatile
	lhu	$4,0($2)
	#.set	novolatile
	#.set	volatile
	lhu	$3,4($5)
	#.set	novolatile
	li	$2,0x000001ae		# 430
	sw	$2,_waitTime
	sw	$4,_startTime
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L78
	addu	$3,$5,$0
	.set	macro
	.set	reorder

$L81:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L81
$L78:
	lw	$2,_padSioRegs
	lw	$3,_padIntRegs
	#.set	volatile
	lbu	$4,0($2)
	#.set	novolatile
	#.set	volatile
	sh	$6,14($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L83
	andi	$17,$4,0x00ff
	.set	macro
	.set	reorder

$L84:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L89
	li	$2,-20			# 0xffffffec
	.set	macro
	.set	reorder

	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L84
$L83:
	lw	$2,_padSioRegs
	#nop
	#.set	volatile
	sb	$18,0($2)
	#.set	novolatile
	lbu	$2,69($16)
	lbu	$4,68($16)
	lw	$3,60($16)
	addu	$2,$2,1
	addu	$3,$3,$4
	sb	$2,69($16)
	sb	$17,0($3)
	lbu	$2,68($16)
	#nop
	addu	$2,$2,1
	sb	$2,68($16)
	addu	$2,$17,$0
$L89:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_padSioRW
	.align	2
	.globl	_padSioRW2
	.ent	_padSioRW2
_padSioRW2:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$19,28($sp)
	addu	$19,$5,$0
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$2,60($16)
	#nop
	lbu	$2,0($2)
	li	$3,0x00000008		# 8
	sra	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L93
	li	$17,0x00000088		# 136
	.set	macro
	.set	reorder

	lbu	$2,68($16)
	#nop
	sltu	$2,$2,9
	bne	$2,$0,$L93
	li	$17,0x00000022		# 34
$L93:
	lw	$3,_padSioRegs
$L94:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L94
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x00000190		# 400
	.set	macro
	.set	reorder

	lw	$4,_padSioRegs
	#nop
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	#.set	volatile
	lbu	$3,68($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L99
	andi	$18,$2,0x00ff
	.set	macro
	.set	reorder

	sra	$3,$18,4
	li	$2,0x00000008		# 8
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L98
	li	$2,0x00000022		# 34
	.set	macro
	.set	reorder

$L99:
	#.set	volatile
	sh	$17,14($4)
	#.set	novolatile
	j	$L100
$L98:
	#.set	volatile
	sh	$2,14($4)
	#.set	novolatile
$L100:
	lw	$3,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
 #APP
 #NO_APP
	#nop
	andi	$2,$2,0x0080
	bne	$2,$0,$L102
	li	$9,0x1f800000		# 528482304
	ori	$9,$9,0x1120
	li	$6,0x1f800000		# 528482304
	ori	$6,$6,0x1128
	li	$10,0x00010000		# 65536
	li	$8,0x1f800000		# 528482304
	ori	$8,$8,0x1124
	addu	$7,$3,$0
	lw	$4,_startTime
	lw	$5,_waitTime
$L103:
	#.set	volatile
	lhu	$2,0($9)
	#.set	novolatile
	#nop
	andi	$3,$2,0xffff
	sltu	$2,$3,$4
	beq	$2,$0,$L104
	#.set	volatile
	lhu	$2,0($6)
	#.set	novolatile
	#nop
	beq	$2,$0,$L105
	#.set	volatile
	lhu	$2,0($6)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L104
	addu	$3,$2,$3
	.set	macro
	.set	reorder

$L105:
	addu	$3,$3,$10
$L104:
	#.set	volatile
	lhu	$2,0($8)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L107
	subu	$2,$3,$4
	.set	macro
	.set	reorder

	sltu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L101
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	j	$L117
$L107:
	srl	$2,$2,3
	sltu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L117
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

$L101:
	#.set	volatile
	lw	$2,0($7)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L103
$L102:
	lbu	$3,232($16)
	li	$2,0x00000008		# 8
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L112
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	lw	$3,_padSioState
	#nop
	bne	$3,$2,$L112
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

$L113:
	jal	chkRC2wait
	beq	$2,$0,$L113
$L112:
	lw	$2,_padSioRegs
	#nop
	#.set	volatile
	sb	$19,0($2)
	#.set	novolatile
	lbu	$2,69($16)
	lbu	$3,68($16)
	addu	$2,$2,1
	sb	$2,69($16)
	li	$2,0x000000ff		# 255
	beq	$3,$2,$L116
	lbu	$3,68($16)
	lw	$2,60($16)
	#nop
	addu	$2,$2,$3
	sb	$18,0($2)
$L116:
	lbu	$3,68($16)
	addu	$2,$18,$0
	addu	$3,$3,1
	sb	$3,68($16)
$L117:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_padSioRW2
	.align	2
	.globl	_padClrIntSio0
	.ent	_padClrIntSio0
_padClrIntSio0:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$3,_padIntRegs
	lw	$4,_padSioRegs
	li	$2,-129			# 0xffffff7f
	sw	$31,16($sp)
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L121
$L122:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L127
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,_padSioRegs
	#nop
	#.set	volatile
	lhu	$2,4($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	bne	$2,$0,$L122
$L121:
	lw	$4,_padSioRegs
	#nop
	#.set	volatile
	lhu	$3,10($4)
	#.set	novolatile
	li	$2,0x00000001		# 1
	ori	$3,$3,0x0010
	#.set	volatile
	sh	$3,10($4)
	#.set	novolatile
$L127:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padClrIntSio0
	.align	2
	.globl	_padWaitRXready
	.ent	_padWaitRXready
_padWaitRXready:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,_padSioRegs
$L131:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L131
	j	$31
	.end	_padWaitRXready

	.lcomm	_padVbCb,16

	.lcomm	_padFrames,8
