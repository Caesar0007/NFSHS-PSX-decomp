	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\MCXMAIN.c"

 # GNU C 2.7.2 [AL 1.1, MM 40] Sony Playstation compiled by GNU C

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = R3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.section .data,"aw",@progbits
	.align	2
_padMtapDataReg:
	.word	528486464
	.text
	.align	2
	.globl	_padIntInit
	.ent	_padIntInit
_padIntInit:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lw	$2,_padFuncSendAuto
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$16,$4,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$0
	lw	$3,60($16)
	li	$5,-2			# 0xfffffffe
	sw	$2,_padMtapFlag
	.set	noreorder
	.set	nomacro
	jal	_padSioRW
	sb	$0,0($3)
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padIntInit
	.align	2
	.globl	_padIntQuery
	.ent	_padIntQuery
_padIntQuery:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$3,_padSioChan
	lw	$2,_padChanStart
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L3
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,_padGunExec
	#nop
	beq	$2,$0,$L3
	lw	$2,_padFuncGetGunPos
	#nop
	jal	$31,$2
	lw	$2,_padFuncSetGunPort
	#nop
	jal	$31,$2
$L3:
	lw	$2,_padMtapFlag
	#nop
	beq	$2,$0,$L5
	lw	$4,12($16)
	lw	$2,_padFuncSendAuto
	#nop
	jal	$31,$2
	lw	$4,12($16)
	lw	$2,_padFuncSendAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,240
	.set	macro
	.set	reorder

$L5:
	#.set	volatile
	lbu	$2,54($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$5,0x00000042		# 66
	.set	macro
	.set	reorder

$L6:
	lbu	$5,54($16)
$L8:
	jal	_padSioRW2
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padIntQuery
	.align	2
	.globl	_padIntRecvId
	.ent	_padIntRecvId
_padIntRecvId:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,_padMtapFlag
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$4,12($16)
	lw	$2,_padFuncSendAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,480
	.set	macro
	.set	reorder

	lw	$4,12($16)
	lw	$2,_padFuncSendAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L10:
	lbu	$2,54($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	lw	$5,_padModeMtap
$L11:
	.set	noreorder
	.set	nomacro
	jal	_padSioRW2
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	addu	$3,$2,$0
	bltz	$3,$L16
	andi	$2,$3,0x00f0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	andi	$2,$3,0x000f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

$L14:
	sll	$2,$2,1
	sw	$2,_padMtapCount
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L16
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,0x00000020		# 32
	sw	$2,_padMtapCount
	addu	$2,$0,$0
$L16:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padIntRecvId
	.align	2
	.globl	_padIntRecvHdr
	.ent	_padIntRecvHdr
_padIntRecvHdr:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	addu	$16,$4,$0
	sw	$31,20($sp)
	lw	$2,60($16)
	#nop
	lbu	$2,0($2)
	li	$3,0x00000008		# 8
	srl	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L18
	addu	$5,$0,$0
	.set	macro
	.set	reorder

	lbu	$2,54($16)
	#nop
	sltu	$5,$2,1
$L18:
	lw	$2,_padFuncGetTxd
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$0
	.set	macro
	.set	reorder

	addu	$4,$16,$0
	.set	noreorder
	.set	nomacro
	jal	_padSioRW2
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

	addu	$3,$2,$0
	li	$2,0x0000005a		# 90
	.set	noreorder
	beq	$3,$2,$L19
	addu	$2,$3,$0
	.set	reorder
	beq	$3,$0,$L19
	.set	noreorder
	.set	nomacro
	bgez	$3,$L21
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

	addu	$2,$3,$0
$L19:
$L21:
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_padIntRecvHdr
	.align	2
	.globl	_padIntRecvData
	.ent	_padIntRecvData
_padIntRecvData:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,20($sp)
	addu	$17,$4,$0
	lw	$2,_padFuncCurrLimit
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,_padModeMtap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	addu	$20,$0,$0
	.set	macro
	.set	reorder

	lw	$2,60($17)
	#nop
	lbu	$2,0($2)
	li	$3,0x00000008		# 8
	sra	$2,$2,4
	bne	$2,$3,$L23
	lbu	$2,54($17)
	#nop
	sltu	$20,$2,1
$L23:
	beq	$20,$0,$L28
	li	$16,-1			# 0xffffffff
	li	$18,-240			# 0xffffff10
$L26:
	lw	$2,_padMtapCount
	#nop
	addu	$2,$2,-1
	sw	$2,_padMtapCount
	blez	$2,$L28
	bltz	$16,$L29
	lw	$4,12($17)
	lw	$2,_padFuncCurrLimit
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$18
	.set	macro
	.set	reorder

$L29:
	addu	$4,$17,$0
	lw	$2,_padFuncGetTxd
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$5,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$4,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_padSioRW2
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

	bltz	$2,$L57
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	addu	$18,$18,240
	.set	macro
	.set	reorder

$L28:
	lw	$3,_padSioChan
	lw	$2,_padMtapCount
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L37
	sltu	$4,$3,1
	.set	macro
	.set	reorder

	la	$3,_padFixResult
	sll	$2,$4,2
	addu	$16,$2,$3
	sll	$2,$4,4
	subu	$2,$2,$4
	sll	$18,$2,4
	li	$21,0x00000003		# 3
$L35:
	lw	$4,0($16)
	#nop
	bltz	$4,$L37
	.set	noreorder
	.set	nomacro
	blez	$4,$L38
	sll	$2,$4,4
	.set	macro
	.set	reorder

	lw	$3,_padInfoDir
	subu	$2,$2,$4
	addu	$3,$18,$3
	lw	$3,12($3)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$19,$3,-240
	lw	$2,_padFuncRecvAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$0
	.set	macro
	.set	reorder

$L38:
	lw	$3,0($16)
	#nop
	beq	$3,$21,$L40
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L42
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	beq	$2,$0,$L44
	addu	$4,$17,$0
	.set	reorder
	bltz	$3,$L58
	.set	macro
	.set	reorder

	j	$L46
$L42:
	li	$2,0x00000004		# 4
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L58
	addu	$4,$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L58
	sw	$21,0($16)
	.set	macro
	.set	reorder

$L40:
	lw	$2,_padFuncRecvAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,-240
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L48
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder

$L46:
	lw	$2,_padInfoDir
	#nop
	addu	$19,$2,$18
	lw	$2,_padFuncRecvAuto
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$0
	.set	macro
	.set	reorder

	lw	$2,_padFuncClrCmdNo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$0
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L48:
	sw	$2,0($16)
	addu	$4,$17,$0
$L44:
$L58:
	lw	$2,_padFuncGetTxd
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$5,$20,$0
	.set	macro
	.set	reorder

	addu	$4,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_padSioRW
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

	bltz	$2,$L57
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	jal	_padClrIntSio0
	bne	$2,$0,$L51
$L32:
	.set	noreorder
	.set	nomacro
	j	$L57
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

$L51:
	lw	$2,_padMtapCount
	#nop
	addu	$2,$2,-1
	sw	$2,_padMtapCount
	slt	$2,$2,2
	beq	$2,$0,$L35
	j	$L37
$L53:
	addu	$4,$17,$0
	lw	$2,_padFuncGetTxd
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$5,$20,$0
	.set	macro
	.set	reorder

	addu	$4,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_padSioRW
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

	bltz	$2,$L57
	.set	noreorder
	.set	nomacro
	jal	setRC2wait
	li	$4,0x0000003c		# 60
	.set	macro
	.set	reorder

	jal	_padClrIntSio0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L57
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

$L37:
	lw	$2,_padMtapCount
	#nop
	addu	$2,$2,-1
	sw	$2,_padMtapCount
	bgtz	$2,$L53
	jal	_padWaitRXready
	lbu	$3,68($17)
	#nop
	addu	$2,$3,1
	sb	$2,68($17)
	lw	$2,_padSioRegs
	lw	$4,60($17)
	#.set	volatile
	lbu	$2,0($2)
	#.set	novolatile
	addu	$3,$3,$4
	sb	$2,0($3)
	lw	$2,_padFuncNextPort
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	addu	$2,$0,$0
$L57:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,48
	j	$31
	.end	_padIntRecvData

	.lcomm	_padMtapCount,4

	.lcomm	_padMtapFlag,4
