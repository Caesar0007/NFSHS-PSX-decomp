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
	move	$2,$0
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
	move	$2,$0
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
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	jal	SysEnqIntRP
	move	$5,$16
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
	move	$16,$4
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
	lw	$2,_padSioChan
	lw	$3,_padSioRegs
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	li	$4,0x00001003		# 4099
	.set	macro
	.set	reorder

	li	$4,0x00003003		# 12291
$L22:
	sll	$2,$2,2
	#.set	volatile
	sh	$4,10($3)
	#.set	novolatile
	lw	$2,_padFixResult($2)
	#nop
	bltz	$2,$L24
	blez	$2,$L25
	la	$17,_padFixResult
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
	bgtz	$2,$L26
$L25:
	lw	$2,_padSioChan
	la	$3,_padFixResult
	sll	$2,$2,2
	addu	$5,$2,$3
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$4,$16
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
	move	$4,$16
	.set	macro
	.set	reorder

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
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	li	$2,-129			# 0xffffff7f
	.set	macro
	.set	reorder

$L33:
	jal	chkRC2wait
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
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
	beq	$2,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

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
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

$L55:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
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
	beq	$2,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

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
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

$L56:
	lw	$2,_padIntRegs
	#nop
	#.set	volatile
	lw	$2,0($2)
	#.set	novolatile
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L45
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
	beq	$2,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

	jal	_padWaitRXready
	lw	$3,_padSioRegs
	move	$2,$0
	#.set	volatile
	lbu	$3,0($3)
	#.set	novolatile
	j	$L51
$L32:
	lw	$3,_padIntRegs
	#nop
	#.set	volatile
	sw	$2,0($3)
	#.set	novolatile
$L31:
	lbu	$2,80($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L51
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	lbu	$2,54($16)
	#nop
	sltu	$2,$2,1
$L51:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_padInitSioMode

	.lcomm	_padVbCb,16

	.lcomm	_padFrames,8
