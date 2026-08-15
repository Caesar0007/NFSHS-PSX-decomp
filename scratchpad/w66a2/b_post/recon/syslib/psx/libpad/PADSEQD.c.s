	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADSEQD.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	_padInitDirSeq
	.align	2
	.globl	_dirSendAuto
	.align	2
	.globl	_dirRecvAuto
	.align	2
	.globl	_dirFailAuto
	.align	2
	.globl	_dirCheck

	.extern	_padFuncClrInfo, 4
	.extern	_padFuncRecvAuto, 4
	.extern	_padFuncChkEng, 4
	.extern	_padFuncSendAuto, 4

	.text
	.def	PadSnd;	.scl	13;	.type	0x94;	.endef
	.def	PadRcv;	.scl	13;	.type	0x9e;	.endef
	.def	_padInitDirSeq;	.val	_padInitDirSeq;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	_padInitDirSeq
_padInitDirSeq:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(_dirSendAuto) # high
	addiu	$2,$2,%lo(_dirSendAuto) # low
	sw	$2,_padFuncSendAuto
	lui	$2,%hi(_dirCheck) # high
	addiu	$2,$2,%lo(_dirCheck) # low
	sw	$2,_padFuncChkEng
	lui	$2,%hi(_dirRecvAuto) # high
	addiu	$2,$2,%lo(_dirRecvAuto) # low
	sw	$2,_padFuncRecvAuto
	j	$31

	.loc	1 0
LM1:
	.end	_padInitDirSeq
	.def	_dirSendAuto;	.val	_dirSendAuto;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	_dirSendAuto
_dirSendAuto:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	info;	.val	16;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,60($16)
	#nop
	lbu	$3,0($2)
	li	$2,243			# 0x000000f3
	bne	$3,$2,$L3
	lbu	$2,232($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$3,73($16)
	#nop
	bne	$3,$2,$L3
 #APP
 #NO_APP
	lw	$2,_padFuncClrInfo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

$L3:
	lbu	$3,70($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L8
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L18
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L7
$L14:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L5
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L18
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L7
$L8:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_padCmdParaMode
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L18
	move	$2,$0
	.set	macro
	.set	reorder

	.def	reenter_cfgmode;	.val	$L5;	.scl	6;	.type	0x0;	.endef
$L5:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_padCmdParaMode
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L18
	move	$2,$0
	.set	macro
	.set	reorder

$L7:
	lw	$2,20($16)
	#nop
	beq	$2,$0,$L15
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L18
	move	$2,$0
	.set	macro
	.set	reorder

$L15:
	.set	noreorder
	.set	nomacro
	jal	_padSendAtLoadInfo
	move	$4,$16
	.set	macro
	.set	reorder

	move	$2,$0
$L18:
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
	.end	_dirSendAuto
	.def	_dirRecvAuto;	.val	_dirRecvAuto;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	_dirRecvAuto
_dirRecvAuto:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	info;	.val	16;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,60($16)
	li	$3,15			# 0x0000000f
	lbu	$2,0($2)
	lbu	$17,232($16)
	srl	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L20
	sb	$2,232($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L21
	sb	$17,232($16)
	.set	macro
	.set	reorder

$L20:
	lw	$2,48($16)
	#nop
	sb	$0,0($2)
	lw	$2,60($16)
	lw	$3,48($16)
	lbu	$2,0($2)
	#nop
	sb	$2,1($3)
	lbu	$2,68($16)
	li	$4,2			# 0x00000002
	slt	$2,$4,$2
	beq	$2,$0,$L21
$L25:
	lw	$2,60($16)
	lw	$3,48($16)
	addu	$2,$2,$4
	lbu	$2,0($2)
	addu	$3,$3,$4
	sb	$2,0($3)
	lbu	$2,68($16)
	addu	$4,$4,1
	slt	$2,$4,$2
	bne	$2,$0,$L25
$L21:
	lw	$2,60($16)
	#nop
	lbu	$2,1($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L29
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,70($16)
	#nop
	bne	$3,$2,$L30
	lw	$2,20($16)
	#nop
	beq	$2,$0,$L29
$L30:
	lbu	$2,80($16)
	#nop
	beq	$2,$0,$L28
$L29:
	.set	noreorder
	.set	nomacro
	jal	_dirCheck
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L27
	lbu	$2,55($16)
	#nop
	bne	$2,$0,$L27
	lbu	$2,74($16)
	#nop
	bne	$2,$0,$L27
	lbu	$2,232($16)
	#nop
	beq	$2,$17,$L27
$L28:
	lw	$2,_padFuncClrInfo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

$L27:
	lbu	$3,70($16)
	li	$2,255			# 0x000000ff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L43
	sb	$0,74($16)
	.set	macro
	.set	reorder

	addu	$2,$3,-2
	andi	$2,$2,0x00ff
	sltu	$2,$2,252
	beq	$2,$0,$L32
	lw	$2,60($16)
	#nop
	lbu	$3,0($2)
	li	$2,243			# 0x000000f3
	beq	$3,$2,$L32
	lw	$2,_padFuncClrInfo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

$L32:
	lbu	$2,70($16)
	#nop
	beq	$2,$0,$L33
	lbu	$2,54($16)
	#nop
	beq	$2,$0,$L43
$L33:
	lbu	$3,70($16)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L36
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	beq	$3,$0,$L35
	j	$L34
$L40:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L37
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	j	$L34
$L35:
	lbu	$2,70($16)
	.set	noreorder
	.set	nomacro
	j	$L44
	sb	$4,73($16)
	.set	macro
	.set	reorder

$L36:
	lbu	$2,70($16)
	sb	$0,71($16)
$L44:
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L43
	sb	$2,70($16)
	.set	macro
	.set	reorder

$L37:
	.set	noreorder
	.set	nomacro
	j	$L43
	sb	$2,70($16)
	.set	macro
	.set	reorder

$L34:
	lw	$2,24($16)
	#nop
	beq	$2,$0,$L41
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L42
$L41:
	.set	noreorder
	.set	nomacro
	jal	_padRecvAtLoadInfo
	move	$4,$16
	.set	macro
	.set	reorder

$L42:
	lbu	$3,70($16)
	#nop
	addu	$3,$3,$2
	sb	$3,70($16)
$L43:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	_dirRecvAuto
	.def	_dirFailAuto;	.val	_dirFailAuto;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	_dirFailAuto
_dirFailAuto:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	info;	.val	16;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,76($16)
	lbu	$3,70($16)
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L46
	sw	$2,76($16)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	bne	$3,$2,$L47
	lbu	$3,74($16)
	#nop
	sltu	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L54
	addu	$2,$3,1
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sb	$2,73($16)
	li	$2,255			# 0x000000ff
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L52
	sb	$2,70($16)
	.set	macro
	.set	reorder

$L47:
	lbu	$3,74($16)
	#nop
	sltu	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	addu	$2,$3,1
	.set	macro
	.set	reorder

$L54:
	.set	noreorder
	.set	nomacro
	j	$L52
	sb	$2,74($16)
	.set	macro
	.set	reorder

$L49:
	lbu	$2,73($16)
	#nop
	beq	$2,$0,$L46
	lw	$2,_padFuncClrInfo
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

$L46:
	lw	$2,60($16)
	#nop
	lbu	$3,0($2)
	li	$2,243			# 0x000000f3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L52
	li	$3,255			# 0x000000ff
	.set	macro
	.set	reorder

	lw	$2,48($16)
	#nop
	sb	$3,0($2)
	lw	$2,48($16)
	#nop
	sb	$0,1($2)
	sb	$0,232($16)
$L52:
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
LM4:
	.end	_dirFailAuto
	.def	_dirCheck;	.val	_dirCheck;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	_dirCheck
_dirCheck:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	info;	.val	4;	.scl	17;	.type	0x1c;	.endef
	lhu	$2,230($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L56
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	lbu	$3,70($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L59
	move	$2,$0
	.set	macro
	.set	reorder

$L56:
	.set	noreorder
	.set	nomacro
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L59:
	j	$31

	.loc	1 0
LM5:
	.end	_dirCheck
