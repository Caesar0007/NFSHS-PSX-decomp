	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADCMD.c"

 # -G value = 0, Cpu = 3000, ISA = 1
 # GNU C version cygnus-2.7.2-970404 SN32.3.7.0004 (SonyPSX) compiled by CC.
 # options passed:  -O2 -G0 -mgas
 # options enabled:  -fdefer-pop -fomit-frame-pointer -fcse-follow-jumps
 # -fcse-skip-blocks -fexpensive-optimizations -fthread-jumps
 # -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse -finline
 # -fkeep-static-consts -fcaller-saves -fpcc-struct-return -fdelayed-branch
 # -frerun-cse-after-loop -fschedule-insns -fschedule-insns2 -fcommon
 # -fverbose-asm -fgnu-linker -mgas -msoft-float -mcpu=3000

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	_padSetAct
	.ent	_padSetAct
_padSetAct:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$5,40($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$6,52($4)
	.set	macro
	.set	reorder

	.end	_padSetAct
	.align	2
	.globl	_padSendAtLoadInfo
	.ent	_padSendAtLoadInfo
_padSendAtLoadInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$3,70($4)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L4
	j	$L3
$L9:
	li	$2,4			# 0x00000004
	beq	$3,$2,$L6
	j	$L3
$L4:
	jal	_padCmdGetStatus
	j	$L3
$L5:
	lbu	$5,228($4)
	jal	_padCmdSetMap
	j	$L3
$L6:
	lbu	$5,71($4)
	jal	_padCmdGetDescR1
$L3:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padSendAtLoadInfo
	.align	2
	.globl	_padRecvAtLoadInfo
	.ent	_padRecvAtLoadInfo
_padRecvAtLoadInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$31,20($sp)
	lbu	$3,70($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L14
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L12
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L23
$L22:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L15
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L23
$L12:
	#.set	volatile
	lw	$2,60($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,60($16)
	#.set	novolatile
	lbu	$2,3($2)
	#nop
	sb	$2,227($16)
	lbu	$2,4($3)
	#.set	volatile
	lw	$3,60($16)
	#.set	novolatile
	sh	$0,230($16)
	sb	$2,228($16)
	lbu	$2,5($3)
	#.set	volatile
	lw	$3,60($16)
	#.set	novolatile
	sb	$2,233($16)
	lbu	$2,6($3)
	sw	$0,236($16)
	.set	noreorder
	.set	nomacro
	j	$L13
	sb	$2,234($16)
	.set	macro
	.set	reorder

$L14:
	lw	$2,60($16)
	#nop
	lbu	$3,4($2)
	lbu	$2,5($2)
	sb	$0,71($16)
	sll	$3,$3,8
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L13
	sh	$2,230($16)
	.set	macro
	.set	reorder

$L15:
	lw	$4,236($16)
	lbu	$2,71($16)
	lw	$3,60($16)
	addu	$2,$2,1
	lbu	$3,4($3)
	addu	$4,$4,8
	sb	$2,71($16)
	addu	$3,$3,3
	andi	$3,$3,0x01fc
	addu	$4,$4,$3
	lbu	$3,234($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	sw	$4,236($16)
	.set	macro
	.set	reorder

$L18:
	.set	noreorder
	.set	nomacro
	j	$L23
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L17:
	.set	noreorder
	.set	nomacro
	jal	_padGetActSize
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	li	$2,254			# 0x000000fe
	sb	$2,70($16)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L18
	sb	$2,73($16)
	.set	macro
	.set	reorder

$L19:
	li	$2,255			# 0x000000ff
	addu	$5,$16,99
	.set	noreorder
	.set	nomacro
	jal	_padLoadActInfo
	sb	$2,70($16)
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L18
	sb	$2,70($16)
	.set	macro
	.set	reorder

$L13:
	li	$2,1			# 0x00000001
$L23:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padRecvAtLoadInfo
	.align	2
	.globl	_padGetActSize
	.ent	_padGetActSize
_padGetActSize:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,227($4)
	lbu	$5,233($4)
	lw	$4,236($4)
	addu	$2,$2,1
	sra	$2,$2,1
	sll	$2,$2,2
	sll	$3,$5,2
	addu	$3,$3,$5
	addu	$3,$3,3
	andi	$3,$3,0x0ffc
	addu	$3,$3,4
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$4
	.set	macro
	.set	reorder

	.end	_padGetActSize
	.align	2
	.globl	_padLoadActInfo
	.ent	_padLoadActInfo
_padLoadActInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$17,20($sp)
	addu	$17,$5,$0
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$Lvs0_0_27
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lvs0_0_28
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	lw	$2,_padFuncChkEng
	#nop
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lvs0_0_26
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$Lvs0_0_27:
	.set	noreorder
	.set	nomacro
	j	$Lvs0_0_28
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$Lvs0_0_26:
 #APP
 #NO_APP
	li	$3,0x00000004		# 4
	addu	$5,$17,3
	sra	$5,$5,2
	sb	$3,73($16)
	li	$3,0x00000001		# 1
	sb	$3,70($16)
	la	$3,_padLoadActInfo_snd
	sw	$3,20($16)
	lbu	$3,227($16)
	la	$4,_padLoadActInfo_rcv
	sw	$4,24($16)
	lbu	$4,233($16)
	sll	$5,$5,2
	sw	$5,0($16)
	sb	$0,71($16)
	addu	$3,$3,1
	sra	$3,$3,1
	sll	$3,$3,2
	addu	$5,$5,$3
	sll	$3,$4,2
	addu	$3,$3,$4
	addu	$3,$3,3
	andi	$3,$3,0x0ffc
	sw	$5,4($16)
	addu	$5,$5,$3
	sw	$5,8($16)
$Lvs0_0_28:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_padLoadActInfo
	.align	2
	.globl	_padLoadActInfo_snd
	.ent	_padLoadActInfo_snd
_padLoadActInfo_snd:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$3,70($4)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L32
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L31
	j	$L30
$L38:
	li	$2,4			# 0x00000004
	beq	$3,$2,$L33
	j	$L30
$L31:
	lbu	$5,71($4)
	jal	_padCmdSetMap
	j	$L30
$L32:
	lbu	$5,71($4)
	jal	_padCmdGetDescR0
	j	$L30
$L33:
	lbu	$2,72($4)
	#nop
	bne	$2,$0,$L34
	lbu	$5,71($4)
	jal	_padCmdGetDescR1
	j	$L30
$L34:
	jal	_padCmd4B
$L30:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padLoadActInfo_snd
	.align	2
	.globl	_padLoadActInfo_rcv
	.ent	_padLoadActInfo_rcv
_padLoadActInfo_rcv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$5,$4,$0
	lbu	$3,70($5)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L44
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L63
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L41
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L65
$L63:
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L46
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L65
$L41:
	lbu	$4,71($5)
	lw	$2,0($5)
	lw	$3,60($5)
	sll	$4,$4,1
	addu	$4,$4,$2
	lbu	$2,4($3)
	lbu	$3,5($3)
	sll	$2,$2,8
	addu	$3,$3,$2
	sh	$3,0($4)
	lbu	$2,71($5)
	lbu	$3,227($5)
	addu	$2,$2,1
	sb	$2,71($5)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L43
	sb	$0,71($5)
	.set	macro
	.set	reorder

$L44:
	lbu	$3,71($5)
	lw	$4,60($5)
	sll	$2,$3,2
	addu	$2,$2,$3
	lw	$3,4($5)
	lbu	$4,4($4)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$2,60($5)
	#nop
	lbu	$2,5($2)
	#nop
	andi	$2,$2,0x007f
	sb	$2,1($3)
	lw	$2,60($5)
	#nop
	lbu	$2,6($2)
	#nop
	sb	$2,2($3)
	lw	$2,60($5)
	#nop
	lbu	$2,7($2)
	#nop
	sb	$2,3($3)
	lw	$2,60($5)
	#nop
	lbu	$2,5($2)
 #APP
 #NO_APP
	#nop
	sra	$2,$2,7
	sb	$2,4($3)
	lbu	$2,71($5)
	lbu	$3,233($5)
	addu	$2,$2,1
	sb	$2,71($5)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	sb	$0,71($5)
	.set	noreorder
	.set	nomacro
	j	$L43
	sb	$0,72($5)
	.set	macro
	.set	reorder

$L46:
	lbu	$2,71($5)
	lw	$3,8($5)
	lbu	$4,72($5)
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L47
	addu	$7,$3,$2
	.set	macro
	.set	reorder

	lw	$2,60($5)
	li	$4,3			# 0x00000003
	lbu	$2,4($2)
 #APP
 #NO_APP
	#nop
	sb	$2,72($5)
	sb	$2,0($7)
	lw	$2,60($5)
	lbu	$3,71($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L48
	addu	$6,$2,5
	.set	macro
	.set	reorder

	lbu	$2,234($5)
	lw	$3,8($5)
	.set	noreorder
	.set	nomacro
	j	$L49
	sll	$2,$2,3
	.set	macro
	.set	reorder

$L48:
	lbu	$2,-8($7)
	lw	$3,-4($7)
	addu	$2,$2,3
	andi	$2,$2,0x01fc
$L49:
	addu	$3,$3,$2
	lui	$2,%hi(_actcur) # high
	sw	$3,4($7)
	.set	noreorder
	.set	nomacro
	j	$L50
	sw	$3,%lo(_actcur)($2)
	.set	macro
	.set	reorder

$L47:
	lw	$2,60($5)
	li	$4,6			# 0x00000006
	addu	$6,$2,2
$L50:
	addu	$4,$4,-1
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L51
	lui	$2,%hi(_actcur) # high
	.set	macro
	.set	reorder

	addiu	$7,$2,%lo(_actcur) # low
	li	$8,-1			# 0xffffffff
$L52:
	lbu	$2,72($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L56
	addu	$4,$4,-1
	.set	macro
	.set	reorder

	lw	$2,0($7)
	lbu	$3,0($6)
	addu	$6,$6,1
	sb	$3,0($2)
	addu	$2,$2,1
	sw	$2,0($7)
	lbu	$2,72($5)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$4,$8,$L52
	sb	$2,72($5)
	.set	macro
	.set	reorder

$L51:
	lbu	$2,72($5)
	#nop
	beq	$2,$0,$L56
$L59:
	.set	noreorder
	.set	nomacro
	j	$L64
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L56:
	lbu	$2,71($5)
	lbu	$3,234($5)
	addu	$2,$2,1
	sb	$2,71($5)
	andi	$2,$2,0x00ff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L60
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$3,6			# 0x00000006
	sb	$3,73($5)
	li	$3,254			# 0x000000fe
	.set	noreorder
	.set	nomacro
	j	$L64
	sb	$3,70($5)
	.set	macro
	.set	reorder

$L60:
	.set	noreorder
	.set	nomacro
	j	$L59
	sb	$0,72($5)
	.set	macro
	.set	reorder

$L43:
	li	$2,1			# 0x00000001
$L64:
$L65:
	j	$31
	.end	_padLoadActInfo_rcv
	.align	2
	.globl	_padSetActAlign
	.ent	_padSetActAlign
_padSetActAlign:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$17,20($sp)
	lui	$2,%hi(_padFuncChkEng) # high
	lw	$2,%lo(_padFuncChkEng)($2)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$17,$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L68
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
 #APP
 #NO_APP
	li	$3,1			# 0x00000001
	sb	$3,70($16)
	lui	$3,%hi(_padSetActAlign_snd) # high
	addiu	$3,$3,%lo(_padSetActAlign_snd) # low
	sw	$3,20($16)
	lui	$3,%hi(_padSetActAlign_rcv) # high
	addiu	$3,$3,%lo(_padSetActAlign_rcv) # low
	sw	$17,32($16)
	sw	$3,24($16)
$L68:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_padSetActAlign
	.align	2
	.globl	_padSetActAlign_snd
	.ent	_padSetActAlign_snd
_padSetActAlign_snd:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,32($4)
	li	$2,77			# 0x0000004d
	sb	$2,54($4)
	li	$2,6			# 0x00000006
	sb	$2,53($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,44($4)
	.set	macro
	.set	reorder

	.end	_padSetActAlign_snd
	.align	2
	.globl	_padSetActAlign_rcv
	.ent	_padSetActAlign_rcv
_padSetActAlign_rcv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,233($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lvs0_1_72
	addu	$8,$0,$0
	.set	macro
	.set	reorder

	li	$11,0x000000ff		# 255
	addu	$10,$0,$0
$Lvs0_1_73:
	lw	$5,32($4)
	addu	$7,$0,$0
	li	$3,0x00000005		# 5
$Lvs0_1_76:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$Lvs0_1_79
	addu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$7,$7,1
$Lvs0_1_79:
	addu	$3,$3,-1
	bgez	$3,$Lvs0_1_76
	lw	$2,4($4)
	#nop
	addu	$2,$10,$2
	lbu	$9,2($2)
	lw	$5,32($4)
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$Lvs0_1_81
	addu	$3,$0,$0
	.set	macro
	.set	reorder

	li	$9,0x00000001		# 1
$Lvs0_1_81:
	addu	$6,$4,$0
$Lvs0_1_82:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$Lvs0_1_85
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$7,$9
	beq	$2,$0,$Lvs0_1_86
	sb	$11,93($6)
	.set	noreorder
	.set	nomacro
	j	$Lvs0_1_85
	addu	$7,$7,-1
	.set	macro
	.set	reorder

$Lvs0_1_86:
	sb	$8,93($6)
$Lvs0_1_85:
 #APP
 #NO_APP
	addu	$3,$3,1
	slt	$2,$3,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lvs0_1_82
	addu	$6,$6,1
	.set	macro
	.set	reorder

	lbu	$2,233($4)
	addu	$8,$8,1
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lvs0_1_73
	addu	$10,$10,5
	.set	macro
	.set	reorder

$Lvs0_1_72:
	li	$2,0x000000fe		# 254
	sb	$2,70($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	.end	_padSetActAlign_rcv
	.align	2
	.globl	_padSetMainMode
	.ent	_padSetMainMode
_padSetMainMode:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$17,20($sp)
	addu	$17,$5,$0
	sw	$18,24($sp)
	addu	$18,$6,$0
	sw	$19,28($sp)
	lui	$2,%hi(_padFuncChkEng) # high
	lw	$2,%lo(_padFuncChkEng)($2)
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$19,$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L91
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
 #APP
 #NO_APP
	lbu	$4,228($16)
 #APP
 #NO_APP
	li	$3,1			# 0x00000001
	sb	$3,70($16)
	lui	$3,%hi(_padSetMainMode_snd) # high
	addiu	$3,$3,%lo(_padSetMainMode_snd) # low
	sw	$3,20($16)
	lui	$3,%hi(_padSetMainMode_rcv) # high
	addiu	$3,$3,%lo(_padSetMainMode_rcv) # low
	sw	$3,24($16)
	andi	$3,$19,0x00ff
	sb	$17,81($16)
	sb	$18,82($16)
	xor	$3,$3,$4
	sltu	$3,$3,1
	sb	$3,83($16)
$L91:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	_padSetMainMode
	.align	2
	.globl	_padSetMainMode_snd
	.ent	_padSetMainMode_snd
_padSetMainMode_snd:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$3,70($4)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L94
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L96
	li	$2,77			# 0x0000004d
	.set	macro
	.set	reorder

	j	$L97
$L94:
	li	$2,68			# 0x00000044
	sb	$2,54($4)
	addu	$2,$4,81
	sw	$2,44($4)
	.set	noreorder
	.set	nomacro
	j	$L97
	sb	$3,53($4)
	.set	macro
	.set	reorder

$L96:
	sb	$2,54($4)
	addu	$2,$4,93
	sw	$2,44($4)
	li	$2,6			# 0x00000006
	sb	$2,53($4)
$L97:
 #APP
	
 #NO_APP
	j	$31
	.end	_padSetMainMode_snd
	.align	2
	.globl	_padSetMainMode_rcv
	.ent	_padSetMainMode_rcv
_padSetMainMode_rcv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$2,83($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L99
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,70($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L100
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L101
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L100:
	.set	noreorder
	.set	nomacro
	j	$L102
	sb	$2,70($4)
	.set	macro
	.set	reorder

$L99:
	lui	$2,%hi(_padFuncClrInfo) # high
	lw	$2,%lo(_padFuncClrInfo)($2)
	#nop
	jal	$31,$2
$L102:
	addu	$2,$0,$0
$L101:
	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padSetMainMode_rcv
	.align	2
	.globl	_padCmdParaMode
	.ent	_padCmdParaMode
_padCmdParaMode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,67			# 0x00000043
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,1			# 0x00000001
	sb	$5,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,53($4)
	.set	macro
	.set	reorder

	.end	_padCmdParaMode
	.align	2
	.globl	_padCmdGetStatus
	.ent	_padCmdGetStatus
_padCmdGetStatus:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,69			# 0x00000045
	sb	$2,54($4)
	sw	$0,44($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,53($4)
	.set	macro
	.set	reorder

	.end	_padCmdGetStatus
	.align	2
	.globl	_padCmdSetMap
	.ent	_padCmdSetMap
_padCmdSetMap:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,76			# 0x0000004c
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,1			# 0x00000001
	sb	$5,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,53($4)
	.set	macro
	.set	reorder

	.end	_padCmdSetMap
	.align	2
	.globl	_padCmdGetDescR0
	.ent	_padCmdGetDescR0
_padCmdGetDescR0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,70			# 0x00000046
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,1			# 0x00000001
	sb	$5,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,53($4)
	.set	macro
	.set	reorder

	.end	_padCmdGetDescR0
	.align	2
	.globl	_padCmdGetDescR1
	.ent	_padCmdGetDescR1
_padCmdGetDescR1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,71			# 0x00000047
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,1			# 0x00000001
	sb	$5,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,53($4)
	.set	macro
	.set	reorder

	.end	_padCmdGetDescR1
	.align	2
	.globl	_padCmd4B
	.ent	_padCmd4B
_padCmd4B:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,75			# 0x0000004b
	sb	$2,54($4)
	sw	$0,44($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,53($4)
	.set	macro
	.set	reorder

	.end	_padCmd4B
	.section .bss,"aw",@progbits
	.align	2
_actcur:
	.space	4
