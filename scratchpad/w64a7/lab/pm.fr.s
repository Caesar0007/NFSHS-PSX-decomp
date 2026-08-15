	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"
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
	lui	$2,%hi(_padVbCb+4) # high
	addiu	$2,$2,%lo(_padVbCb+4) # low
 #APP
 #NO_APP
	lui	$3,%hi(_padVbCallback0) # high
	addiu	$3,$3,%lo(_padVbCallback0) # low
	sw	$3,0($2)
	lui	$3,%hi(_padVbCallback1) # high
	addiu	$3,$3,%lo(_padVbCallback1) # low
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
	lui	$2,%hi(_padIntRegs) # high
	lw	$3,%lo(_padIntRegs)($2)
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
	move	$2,$0
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
	lui	$2,%hi(_padFuncIntGun) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(_padFuncIntGun)($2)
	#nop
	beq	$2,$0,$L4
	jal	$31,$2
$L4:
	.set	noreorder
	.set	nomacro
	j	$L5
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L3:
	move	$2,$0
$L5:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_padVbCallback1
	.align	2
	.globl	_padVbCallback0
	.ent	_padVbCallback0
_padVbCallback0:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$4,%hi(_padVbExec) # high
	lui	$2,%hi(_padChanStart) # high
	lw	$3,%lo(_padChanStart)($2)
	li	$2,1			# 0x00000001
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L7
	sw	$2,%lo(_padVbExec)($4)
	.set	macro
	.set	reorder

	lui	$4,%hi(_padFrames) # high
	lw	$3,%lo(_padFrames)($4)
	#nop
	slt	$2,$3,150
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,%lo(_padFrames)($4)
$L7:
	lui	$2,%hi(_padChanStop) # high
	lw	$2,%lo(_padChanStop)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	lui	$2,%hi(_padIntExec) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(_padFrames+4) # high
	lw	$3,%lo(_padFrames+4)($4)
	#nop
	slt	$2,$3,150
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,%lo(_padFrames+4)($4)
$L9:
	lui	$2,%hi(_padIntExec) # high
$L17:
	lw	$2,%lo(_padIntExec)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	lui	$2,%hi(_padChanStart) # high
	.set	macro
	.set	reorder

	lui	$17,%hi(_padChanStop) # high
	lw	$3,%lo(_padChanStart)($2)
	lw	$2,%lo(_padChanStop)($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	lui	$2,%hi(_padSioState) # high
	.set	macro
	.set	reorder

	lui	$16,%hi(_padSioChan) # high
	lui	$18,%hi(_padInfoDir) # high
	sll	$4,$3,4
	subu	$4,$4,$3
	sw	$0,%lo(_padSioState)($2)
	lw	$2,%lo(_padInfoDir)($18)
	sll	$4,$4,4
	sw	$3,%lo(_padSioChan)($16)
	.set	noreorder
	.set	nomacro
	jal	_padInitSioMode
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	lui	$2,%hi(_padFuncNextPort) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(_padFuncNextPort)($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,65535			# 0x0000ffff
	.set	macro
	.set	reorder

$L12:
	lw	$2,%lo(_padChanStop)($17)
	lw	$4,%lo(_padSioChan)($16)
	lui	$3,%hi(_padTotalCurr) # high
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	sw	$0,%lo(_padTotalCurr)($3)
	.set	macro
	.set	reorder

$L15:
	lw	$2,%lo(_padSioChan)($16)
	#nop
	sll	$4,$2,4
	subu	$4,$4,$2
	lw	$2,%lo(_padInfoDir)($18)
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	_padSioMain
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$2,%lo(_padChanStop)($17)
	lw	$3,%lo(_padSioChan)($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L15
$L14:
	lui	$2,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($2)
	li	$2,136			# 0x00000088
	#.set	volatile
	sh	$2,14($3)
	#.set	novolatile
$L11:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	_padVbCallback0
	.align	2
	.globl	_padStartCom
	.ent	_padStartCom
_padStartCom:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	lui	$18,%hi(_padIntExec) # high
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	EnterCriticalSection
	sw	$0,%lo(_padIntExec)($18)
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	lui	$16,%hi(_padVbCb) # high
	addiu	$16,$16,%lo(_padVbCb) # low
	.set	noreorder
	.set	nomacro
	jal	SysDeqIntRP
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	SysEnqIntRP
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
	lui	$2,%hi(_padIntRegs) # high
	lw	$3,%lo(_padIntRegs)($2)
	li	$2,-2			# 0xfffffffe
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	#.set	volatile
	lw	$2,4($3)
	#.set	novolatile
	move	$5,$0
	ori	$2,$2,0x0001
	#.set	volatile
	sw	$2,4($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	lui	$17,%hi(_padInfoDir) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ExitCriticalSection
	lui	$16,%hi(_padFuncClrInfo) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(_padInfoDir)($17)
	lw	$2,%lo(_padFuncClrInfo)($16)
	#nop
	jal	$31,$2
	lw	$4,%lo(_padInfoDir)($17)
	lw	$2,%lo(_padFuncClrInfo)($16)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,240
	.set	macro
	.set	reorder

	lui	$2,%hi(_padFrames) # high
	addiu	$2,$2,%lo(_padFrames) # low
 #APP
 #NO_APP
	sw	$0,4($2)
	sw	$0,0($2)
	lw	$31,28($sp)
	li	$2,1			# 0x00000001
	sw	$2,%lo(_padIntExec)($18)
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
	li	$4,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	ChangeClearRCnt
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	lui	$5,%hi(_padVbCb) # high
	.set	noreorder
	.set	nomacro
	jal	SysDeqIntRP
	addiu	$5,$5,%lo(_padVbCb) # low
	.set	macro
	.set	reorder

	jal	ExitCriticalSection
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_padStopCom
	.align	2
	.globl	_padInitSioMode
	.ent	_padInitSioMode
_padInitSioMode:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	lui	$16,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($16)
	li	$2,64			# 0x00000040
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	#.set	volatile
	sh	$2,10($3)
	#.set	novolatile
	li	$2,13			# 0x0000000d
	#.set	volatile
	sh	$0,10($3)
	#.set	novolatile
	#.set	volatile
	sh	$2,8($3)
	#.set	novolatile
	li	$2,136			# 0x00000088
	#.set	volatile
	sh	$2,14($3)
	#.set	novolatile
	lbu	$3,232($18)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L21
	li	$4,145			# 0x00000091
	.set	macro
	.set	reorder

	li	$4,80			# 0x00000050
$L21:
	jal	setRC2wait
	lui	$5,%hi(_padSioChan) # high
	lw	$4,%lo(_padSioChan)($5)
	lw	$2,%lo(_padSioRegs)($16)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L23
	li	$3,4099			# 0x00001003
	.set	macro
	.set	reorder

	li	$3,12291			# 0x00003003
$L23:
	#.set	volatile
	sh	$3,10($2)
	#.set	novolatile
	lui	$2,%hi(_padFixResult) # high
	addiu	$3,$2,%lo(_padFixResult) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	bltz	$2,$L25
	blez	$2,$L26
	move	$17,$3
	move	$16,$5
	lui	$19,%hi(_padFuncRecvAuto) # high
$L27:
	lw	$3,%lo(_padSioChan)($16)
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
	lw	$3,12($18)
	lw	$2,%lo(_padFuncRecvAuto)($19)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$2,%lo(_padSioChan)($16)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$2,0($2)
	#nop
	bgtz	$2,$L27
$L26:
	lui	$3,%hi(_padFixResult) # high
	lui	$2,%hi(_padSioChan) # high
	lw	$2,%lo(_padSioChan)($2)
	addiu	$3,$3,%lo(_padFixResult) # low
	sll	$2,$2,2
	addu	$5,$2,$3
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L56
	lui	$2,%hi(_padSioRegs) # high
	.set	macro
	.set	reorder

	move	$4,$18
	lui	$2,%hi(_padFuncRecvAuto) # high
	lw	$2,%lo(_padFuncRecvAuto)($2)
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$3,0($5)
	.set	macro
	.set	reorder

	lui	$2,%hi(_padFuncClrCmdNo) # high
	lw	$2,%lo(_padFuncClrCmdNo)($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$18
	.set	macro
	.set	reorder

$L25:
	lui	$2,%hi(_padSioRegs) # high
$L56:
	lw	$3,%lo(_padSioRegs)($2)
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L32
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
	beq	$2,$0,$L33
	lui	$2,%hi(_padIntRegs) # high
	.set	macro
	.set	reorder

$L34:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	li	$4,100			# 0x00000064
	.set	macro
	.set	reorder

	lui	$16,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($16)
	li	$2,1			# 0x00000001
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	move	$2,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$2,%lo(_padSioRegs)($16)
	li	$4,430			# 0x000001ae
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	lui	$3,%hi(_padIntRegs) # high
	lw	$2,%lo(_padIntRegs)($3)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L57
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

	move	$16,$3
$L40:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L52
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,%lo(_padIntRegs)($16)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

$L57:
	lui	$16,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($16)
	li	$2,66			# 0x00000042
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	move	$2,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$2,%lo(_padSioRegs)($16)
	li	$4,430			# 0x000001ae
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	lui	$3,%hi(_padIntRegs) # high
	lw	$2,%lo(_padIntRegs)($3)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L58
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

	move	$16,$3
$L46:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L52
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,%lo(_padIntRegs)($16)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

$L58:
	lui	$16,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($16)
	li	$2,1			# 0x00000001
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	move	$2,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$3,%lo(_padSioRegs)($16)
	move	$2,$0
	#.set	volatile
	lbu	$3,0($3)
	#.set	novolatile
	j	$L52
$L33:
	lw	$3,%lo(_padIntRegs)($2)
	li	$2,-129			# 0xffffff7f
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
$L32:
	lbu	$2,80($18)
	#nop
	beq	$2,$0,$L50
	lbu	$2,54($18)
	.set	noreorder
	.set	nomacro
	j	$L52
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L50:
	li	$2,1			# 0x00000001
$L52:
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

	.end	_padInitSioMode
	.align	2
	.globl	_padSioMain
	.ent	_padSioMain
_padSioMain:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(_padSioState) # high
	lui	$3,%hi(padIntFunc) # high
	lw	$5,%lo(_padSioState)($16)
	addiu	$3,$3,%lo(padIntFunc) # low
	sw	$31,20($sp)
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$2,0($2)
 #APP
 #NO_APP
	addu	$5,$5,1
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$5,%lo(_padSioState)($16)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	bltz	$4,$L60
	lui	$2,%hi(_padFuncNextPort) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(_padSioState)($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L65
	lui	$4,%hi(_padSioState) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	lui	$4,%hi(_padSioState) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(_padFuncNextPort) # high
	lw	$2,%lo(_padFuncNextPort)($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	lui	$4,%hi(_padSioState) # high
$L65:
	lw	$3,%lo(_padSioState)($4)
	#nop
	slt	$2,$3,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L64
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L64
	sw	$2,%lo(_padSioState)($4)
	.set	macro
	.set	reorder

$L60:
	lw	$2,%lo(_padFuncNextPort)($2)
	#nop
	jal	$31,$2
$L64:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_padSioMain
	.align	2
	.globl	_padSioRW
	.ent	_padSioRW
_padSioRW:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	bgez	$19,$L67
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(_padSioRegs) # high
	lw	$2,%lo(_padSioRegs)($4)
	lw	$3,64($16)
	#.set	volatile
	lbu	$5,0($2)
	#.set	novolatile
	li	$2,255			# 0x000000ff
	sb	$2,68($16)
	li	$2,1			# 0x00000001
	sb	$2,69($16)
	nor	$2,$0,$19
	sb	$2,0($3)
	lw	$3,%lo(_padSioRegs)($4)
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L72
	andi	$18,$5,0x00ff
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
	lui	$2,%hi(_padSioRegs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(_padSioRegs)($2)
	nor	$2,$0,$19
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L89
	move	$2,$18
	.set	macro
	.set	reorder

$L67:
	lw	$2,60($16)
	#nop
	lbu	$2,0($2)
	li	$3,8			# 0x00000008
	sra	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L77
	li	$7,136			# 0x00000088
	.set	macro
	.set	reorder

	lbu	$2,68($16)
	#nop
	sltu	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L91
	li	$3,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	li	$7,34			# 0x00000022
$L77:
	li	$3,528482304			# 0x1f800000
$L91:
	ori	$3,$3,0x1120
	lui	$2,%hi(_padSioRegs) # high
	lui	$5,%hi(_waitTime) # high
	lw	$6,%lo(_padSioRegs)($2)
	#.set	volatile
	lhu	$3,0($3)
	#.set	novolatile
	#.set	volatile
	lhu	$4,4($6)
	#.set	novolatile
	li	$2,430			# 0x000001ae
	sw	$2,%lo(_waitTime)($5)
	lui	$2,%hi(_startTime) # high
	andi	$3,$3,0xffff
	andi	$4,$4,0x0002
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L78
	sw	$3,%lo(_startTime)($2)
	.set	macro
	.set	reorder

	move	$3,$6
$L81:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L81
$L78:
	lui	$2,%hi(_padSioRegs) # high
	lui	$5,%hi(_padIntRegs) # high
	lw	$2,%lo(_padSioRegs)($2)
	lw	$3,%lo(_padIntRegs)($5)
	#.set	volatile
	lbu	$4,0($2)
	#.set	novolatile
	#.set	volatile
	sh	$7,14($2)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L83
	andi	$18,$4,0x00ff
	.set	macro
	.set	reorder

	move	$17,$5
$L84:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L89
	li	$2,-20			# 0xffffffec
	.set	macro
	.set	reorder

	lw	$2,%lo(_padIntRegs)($17)
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L84
$L83:
	lui	$2,%hi(_padSioRegs) # high
	lw	$2,%lo(_padSioRegs)($2)
	#nop
	#.set	volatile
	sb	$19,0($2)
	#.set	novolatile
	lbu	$2,69($16)
	lbu	$4,68($16)
	lw	$3,60($16)
	addu	$2,$2,1
	addu	$3,$3,$4
	sb	$2,69($16)
	sb	$18,0($3)
	lbu	$2,68($16)
	#nop
	addu	$2,$2,1
	sb	$2,68($16)
	move	$2,$18
$L89:
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

	.end	_padSioRW
	.align	2
	.globl	_padSioRW2
	.ent	_padSioRW2
_padSioRW2:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,60($17)
	#nop
	lbu	$2,0($2)
	li	$3,8			# 0x00000008
	sra	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L93
	li	$16,136			# 0x00000088
	.set	macro
	.set	reorder

	lbu	$2,68($17)
	#nop
	sltu	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L120
	lui	$2,%hi(_padSioRegs) # high
	.set	macro
	.set	reorder

	li	$16,34			# 0x00000022
$L93:
	lui	$2,%hi(_padSioRegs) # high
$L120:
	lw	$3,%lo(_padSioRegs)($2)
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
	li	$4,400			# 0x00000190
	.set	macro
	.set	reorder

	lui	$2,%hi(_padSioRegs) # high
	lw	$4,%lo(_padSioRegs)($2)
	#nop
	#.set	volatile
	lbu	$2,0($4)
	#.set	novolatile
	#.set	volatile
	lbu	$3,68($17)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L99
	andi	$18,$2,0x00ff
	.set	macro
	.set	reorder

	sra	$3,$18,4
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L98
	li	$2,34			# 0x00000022
	.set	macro
	.set	reorder

$L99:
	#.set	volatile
	sh	$16,14($4)
	#.set	novolatile
	j	$L100
$L98:
	#.set	volatile
	sh	$2,14($4)
	#.set	novolatile
$L100:
 #APP
 #NO_APP
	lui	$2,%hi(_padIntRegs) # high
	lw	$3,%lo(_padIntRegs)($2)
	#nop
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L102
	lui	$2,%hi(_startTime) # high
	.set	macro
	.set	reorder

	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x1120
	li	$6,528482304			# 0x1f800000
	ori	$6,$6,0x1128
	li	$9,65536			# 0x00010000
	move	$7,$3
	lw	$4,%lo(_startTime)($2)
	lui	$2,%hi(_waitTime) # high
	lw	$5,%lo(_waitTime)($2)
$L103:
	#.set	volatile
	lhu	$2,0($8)
	#.set	novolatile
	#nop
	andi	$3,$2,0xffff
	sltu	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L121
	li	$2,528482304			# 0x1f800000
	.set	macro
	.set	reorder

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
	addu	$3,$3,$9
$L104:
	li	$2,528482304			# 0x1f800000
$L121:
	ori	$2,$2,0x1124
	#.set	volatile
	lhu	$2,0($2)
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
	lbu	$3,232($17)
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L112
	lui	$2,%hi(_padSioState) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(_padSioState)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L122
	lui	$2,%hi(_padSioRegs) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

$L113:
	jal	chkRC2wait
	beq	$2,$0,$L113
$L112:
	lui	$2,%hi(_padSioRegs) # high
$L122:
	lw	$2,%lo(_padSioRegs)($2)
	#nop
	#.set	volatile
	sb	$19,0($2)
	#.set	novolatile
	lbu	$2,69($17)
	lbu	$3,68($17)
	addu	$2,$2,1
	sb	$2,69($17)
	li	$2,255			# 0x000000ff
	beq	$3,$2,$L116
	lw	$2,60($17)
	#nop
	addu	$2,$2,$3
	sb	$18,0($2)
$L116:
	lbu	$3,68($17)
	move	$2,$18
	addu	$3,$3,1
	sb	$3,68($17)
$L117:
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

	.end	_padSioRW2
	.align	2
	.globl	_padClrIntSio0
	.ent	_padClrIntSio0
_padClrIntSio0:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(_padIntRegs) # high
	lui	$5,%hi(_padSioRegs) # high
	lw	$3,%lo(_padIntRegs)($2)
	lw	$4,%lo(_padSioRegs)($5)
	li	$2,-129			# 0xffffff7f
	sw	$31,20($sp)
	sw	$16,16($sp)
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
	#.set	volatile
	lhu	$2,4($4)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L124
	move	$16,$5
	.set	macro
	.set	reorder

$L125:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L130
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,%lo(_padSioRegs)($16)
	#nop
	#.set	volatile
	lhu	$2,4($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	bne	$2,$0,$L125
$L124:
	lui	$2,%hi(_padSioRegs) # high
	lw	$4,%lo(_padSioRegs)($2)
	#nop
	#.set	volatile
	lhu	$3,10($4)
	#.set	novolatile
	li	$2,1			# 0x00000001
	ori	$3,$3,0x0010
	#.set	volatile
	sh	$3,10($4)
	#.set	novolatile
$L130:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_padClrIntSio0
	.align	2
	.globl	_padWaitRXready
	.ent	_padWaitRXready
_padWaitRXready:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(_padSioRegs) # high
	lw	$3,%lo(_padSioRegs)($2)
$L134:
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L134
	j	$31
	.end	_padWaitRXready

	.lcomm	_padVbCb,16

	.lcomm	_padFrames,8
