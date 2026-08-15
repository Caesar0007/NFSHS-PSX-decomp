	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADMAIN.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-delayed-branch -o

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
	sw	$0,8($2)
	j	$31
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
	beq	$2,$0,$L3
	#.set	volatile
	lw	$2,0($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L3
	lw	$2,_padFuncIntGun
	#nop
	beq	$2,$0,$L4
	jal	$31,$2
$L4:
	li	$2,0x00000001		# 1
	j	$L5
$L3:
	move	$2,$0
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
	beq	$2,$0,$L7
	addu	$2,$3,1
	sw	$2,0($4)
$L7:
	lw	$2,_padChanStop
	#nop
	bne	$2,$0,$L9
	la	$4,_padFrames+4
	lw	$3,0($4)
	#nop
	slt	$2,$3,150
	beq	$2,$0,$L9
	addu	$2,$3,1
	sw	$2,0($4)
$L9:
	lw	$2,_padIntExec
	#nop
	beq	$2,$0,$L11
	lw	$3,_padChanStart
	lw	$2,_padChanStop
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L11
	sll	$4,$3,4
	subu	$4,$4,$3
	lw	$2,_padInfoDir
	sll	$4,$4,4
	sw	$0,_padSioState
	sw	$3,_padSioChan
	addu	$4,$2,$4
	jal	_padInitSioMode
	bne	$2,$0,$L12
	lw	$2,_padFuncNextPort
	li	$4,0x0000ffff		# 65535
	jal	$31,$2
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
	addu	$4,$2,$4
	jal	_padSioMain
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
	move	$2,$0
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
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
	move	$5,$16
	jal	SysDeqIntRP
	li	$4,0x00000002		# 2
	move	$5,$16
	jal	SysEnqIntRP
	li	$4,0x00000003		# 3
	lw	$3,_padIntRegs
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
	jal	ChangeClearRCnt
	jal	ExitCriticalSection
	lw	$4,_padInfoDir
	lw	$2,_padFuncClrInfo
	#nop
	jal	$31,$2
	lw	$4,_padInfoDir
	lw	$2,_padFuncClrInfo
	addu	$4,$4,240
	jal	$31,$2
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
	li	$5,0x00000001		# 1
	jal	ChangeClearRCnt
	li	$4,0x00000002		# 2
	la	$5,_padVbCb
	jal	SysDeqIntRP
	jal	ExitCriticalSection
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padStopCom
	.align	2
	.globl	_padInitSioMode
	.ent	_padInitSioMode
_padInitSioMode:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	li	$4,0x00000091		# 145
	lw	$3,_padSioRegs
	li	$2,0x00000040		# 64
	sw	$31,32($sp)
	sw	$17,28($sp)
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
	bne	$3,$2,$L20
	li	$4,0x00000050		# 80
$L20:
	jal	setRC2wait
	li	$3,0x00001003		# 4099
	lw	$2,_padSioChan
	lw	$4,_padSioRegs
	beq	$2,$0,$L22
	li	$3,0x00003003		# 12291
$L22:
	sll	$2,$2,2
	#.set	volatile
	sh	$3,10($4)
	#.set	novolatile
	lw	$2,_padFixResult($2)
	la	$3,_padFixResult
	bltz	$2,$L24
	blez	$2,$L25
	move	$17,$3
$L26:
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
	addu	$4,$2,$4
	jal	$31,$3
	lw	$2,_padSioChan
	#nop
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$2,0($2)
	#nop
	bgtz	$2,$L26
$L25:
	lw	$2,_padSioChan
	la	$3,_padFixResult
	sll	$2,$2,2
	addu	$5,$2,$3
	lw	$2,0($5)
	#nop
	bne	$2,$0,$L24
	move	$4,$16
	lw	$2,_padFuncRecvAuto
	li	$3,-1			# 0xffffffff
	sw	$3,0($5)
	jal	$31,$2
	lw	$2,_padFuncClrCmdNo
	move	$4,$16
	jal	$31,$2
$L24:
	lw	$3,_padSioRegs
	#nop
	#.set	volatile
	lhu	$2,4($3)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L31
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
	beq	$2,$0,$L32
$L33:
	jal	chkRC2wait
	beq	$2,$0,$L33
	li	$4,0x00000064		# 100
	lw	$3,_padSioRegs
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	beq	$2,$0,$L53
	jal	_padWaitRXready
	lw	$2,_padSioRegs
	li	$4,0x000001ae		# 430
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	j	$L55
$L39:
	jal	chkRC2wait
	bne	$2,$0,$L52
$L55:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L39
	li	$4,0x0000003c		# 60
	lw	$3,_padSioRegs
	li	$2,0x00000042		# 66
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	beq	$2,$0,$L53
	jal	_padWaitRXready
	lw	$2,_padSioRegs
	li	$4,0x000001ae		# 430
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	jal	setRC2wait
	j	$L56
$L45:
	jal	chkRC2wait
	bne	$2,$0,$L53
$L56:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L45
	li	$4,0x0000003c		# 60
	lw	$3,_padSioRegs
	li	$2,0x00000001		# 1
	#.set	volatile
	sb	$2,0($3)
	#.set	novolatile
	jal	setRC2wait
	jal	_padClrIntSio0
	beq	$2,$0,$L53
	jal	_padWaitRXready
	lw	$3,_padSioRegs
	move	$2,$0
	#.set	volatile
	lbu	$3,0($3)
	#.set	novolatile
	j	$L51
$L32:
	lw	$3,_padIntRegs
	li	$2,-129			# 0xffffff7f
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
$L31:
	lbu	$2,80($16)
	#nop
	bne	$2,$0,$L49
	li	$2,0x00000001		# 1
	j	$L51
$L52:
$L53:
	move	$2,$0
	j	$L51
$L49:
	lbu	$2,54($16)
	#nop
	sltu	$2,$2,1
$L51:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_padInitSioMode

	.lcomm	_padVbCb,16

	.lcomm	_padFrames,8
