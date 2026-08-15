	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADCMD.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

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
	li	$2,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	beq	$3,$2,$L4
	j	$L3
$L9:
	li	$2,0x00000004		# 4
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
	move	$16,$4
	sw	$31,20($sp)
	lbu	$3,70($16)
	li	$2,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L14
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L12
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	j	$L23
$L22:
	li	$2,0x00000004		# 4
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L15
	li	$2,0x00000001		# 1
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
	lbu	$3,71($16)
	lw	$2,60($16)
	addu	$3,$3,1
	lbu	$2,4($2)
	addu	$4,$4,8
	sb	$3,71($16)
	addu	$2,$2,3
	andi	$2,$2,0x01fc
	addu	$4,$4,$2
	lbu	$2,234($16)
	andi	$3,$3,0x00ff
	sltu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L17
	sw	$4,236($16)
	.set	macro
	.set	reorder

$L18:
	.set	noreorder
	.set	nomacro
	j	$L23
	move	$2,$0
	.set	macro
	.set	reorder

$L17:
	.set	noreorder
	.set	nomacro
	jal	_padGetActSize
	move	$4,$16
	.set	macro
	.set	reorder

	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,0x000000fe		# 254
	sb	$2,70($16)
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	j	$L18
	sb	$2,73($16)
	.set	macro
	.set	reorder

$L19:
	li	$2,0x000000ff		# 255
	addu	$5,$16,99
	.set	noreorder
	.set	nomacro
	jal	_padLoadActInfo
	sb	$2,70($16)
	.set	macro
	.set	reorder

	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	j	$L18
	sb	$2,70($16)
	.set	macro
	.set	reorder

$L13:
	li	$2,0x00000001		# 1
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
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L27
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,_padFuncChkEng
	#nop
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L26
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L27:
	.set	noreorder
	.set	nomacro
	j	$L28
	move	$2,$0
	.set	macro
	.set	reorder

$L26:
 #APP
 #NO_APP
	addu	$5,$17,3
	sra	$5,$5,2
	li	$3,0x00000004		# 4
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
$L28:
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
	li	$2,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L32
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	beq	$3,$2,$L31
	j	$L30
$L38:
	li	$2,0x00000004		# 4
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
	move	$5,$4
	lbu	$3,70($5)
	li	$2,0x00000003		# 3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L44
	slt	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L63
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L41
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

	j	$L65
$L63:
	li	$2,0x00000004		# 4
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L46
	li	$2,0x00000001		# 1
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
	move	$2,$0
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
	move	$2,$0
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
	li	$4,0x00000003		# 3
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
	addu	$2,$3,$2
	sw	$2,4($7)
	sw	$2,_actcur
	.set	noreorder
	.set	nomacro
	j	$L66
	addu	$4,$4,-1
	.set	macro
	.set	reorder

$L47:
	lw	$2,60($5)
	li	$4,0x00000006		# 6
	addu	$6,$2,2
	addu	$4,$4,-1
$L66:
	li	$2,-1			# 0xffffffff
	beq	$4,$2,$L51
	la	$7,_actcur
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

	lw	$3,0($7)
	#nop
	addu	$2,$3,1
	sw	$2,0($7)
	lbu	$2,0($6)
	#nop
	sb	$2,0($3)
	lbu	$2,72($5)
	addu	$6,$6,1
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
	move	$2,$0
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
	move	$2,$0
	.set	macro
	.set	reorder

	li	$3,0x00000006		# 6
	sb	$3,73($5)
	li	$3,0x000000fe		# 254
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
	li	$2,0x00000001		# 1
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
	move	$16,$4
	sw	$17,20($sp)
	lw	$2,_padFuncChkEng
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L69
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	li	$3,0x00000001		# 1
	sb	$3,70($16)
	la	$3,_padSetActAlign_snd
	sw	$3,20($16)
	la	$3,_padSetActAlign_rcv
	sw	$17,32($16)
	sw	$3,24($16)
$L69:
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
	li	$2,0x0000004d		# 77
	sb	$2,54($4)
	li	$2,0x00000006		# 6
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
	beq	$2,$0,$L72
	move	$8,$0
	.set	macro
	.set	reorder

	li	$11,0x000000ff		# 255
	move	$10,$0
$L73:
	lw	$5,32($4)
	move	$7,$0
	li	$3,0x00000005		# 5
$L76:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L79
	addu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$7,$7,1
$L79:
	addu	$3,$3,-1
	bgez	$3,$L76
	lw	$2,4($4)
	#nop
	addu	$2,$10,$2
	lbu	$9,2($2)
	lw	$5,32($4)
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L81
	move	$3,$0
	.set	macro
	.set	reorder

	li	$9,0x00000001		# 1
$L81:
	move	$6,$4
$L82:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$8,$L85
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$7,$9
	beq	$2,$0,$L86
	sb	$11,93($6)
	.set	noreorder
	.set	nomacro
	j	$L85
	addu	$7,$7,-1
	.set	macro
	.set	reorder

$L86:
	sb	$8,93($6)
$L85:
 #APP
 #NO_APP
	addu	$3,$3,1
	slt	$2,$3,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L82
	addu	$6,$6,1
	.set	macro
	.set	reorder

	lbu	$2,233($4)
	addu	$8,$8,1
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	addu	$10,$10,5
	.set	macro
	.set	reorder

$L72:
	li	$2,0x000000fe		# 254
	sb	$2,70($4)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
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
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$19,28($sp)
	lw	$2,_padFuncChkEng
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$19,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,0x00000001		# 1
 #APP
 #NO_APP
	lbu	$4,228($16)
 #APP
 #NO_APP
	li	$3,0x00000001		# 1
	sb	$3,70($16)
	la	$3,_padSetMainMode_snd
	sw	$3,20($16)
	la	$3,_padSetMainMode_rcv
	sw	$3,24($16)
	andi	$3,$19,0x00ff
	sb	$17,81($16)
	sb	$18,82($16)
	xor	$3,$3,$4
	sltu	$3,$3,1
	sb	$3,83($16)
$L92:
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
	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L95
	li	$2,0x00000003		# 3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L97
	li	$2,0x0000004d		# 77
	.set	macro
	.set	reorder

	j	$L98
$L95:
	li	$2,0x00000044		# 68
	sb	$2,54($4)
	addu	$2,$4,81
	sw	$2,44($4)
	.set	noreorder
	.set	nomacro
	j	$L98
	sb	$3,53($4)
	.set	macro
	.set	reorder

$L97:
	sb	$2,54($4)
	addu	$2,$4,93
	sw	$2,44($4)
	li	$2,0x00000006		# 6
	sb	$2,53($4)
$L98:
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
	beq	$2,$0,$L100
	li	$2,0x00000002		# 2
	.set	macro
	.set	reorder

	lbu	$3,70($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L101
	li	$2,0x000000fe		# 254
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L102
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L101:
	.set	noreorder
	.set	nomacro
	j	$L103
	sb	$2,70($4)
	.set	macro
	.set	reorder

$L100:
	lw	$2,_padFuncClrInfo
	#nop
	jal	$31,$2
$L103:
	move	$2,$0
$L102:
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
	li	$2,0x00000043		# 67
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,0x00000001		# 1
	sb	$2,53($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$5,36($4)
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
	li	$2,0x00000045		# 69
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
	li	$2,0x0000004c		# 76
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,0x00000001		# 1
	sb	$2,53($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$5,36($4)
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
	li	$2,0x00000046		# 70
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,0x00000001		# 1
	sb	$2,53($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$5,36($4)
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
	li	$2,0x00000047		# 71
	sb	$2,54($4)
	addu	$2,$4,36
	sw	$2,44($4)
	li	$2,0x00000001		# 1
	sb	$2,53($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$5,36($4)
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
	li	$2,0x0000004b		# 75
	sb	$2,54($4)
	sw	$0,44($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,53($4)
	.set	macro
	.set	reorder

	.end	_padCmd4B

	.lcomm	_actcur,4
