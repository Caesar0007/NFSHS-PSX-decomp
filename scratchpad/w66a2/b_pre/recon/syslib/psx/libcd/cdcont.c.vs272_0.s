	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\cdcont.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	CdStatus
	.ent	CdStatus
CdStatus:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(CD_status) # high
	lbu	$2,%lo(CD_status)($2)
	j	$31
	.end	CdStatus
	.align	2
	.globl	CdMode
	.ent	CdMode
CdMode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(CD_mode) # high
	lbu	$2,%lo(CD_mode)($2)
	j	$31
	.end	CdMode
	.align	2
	.globl	CdLastPos
	.ent	CdLastPos
CdLastPos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(CD_pos) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo(CD_pos) # low
	.set	macro
	.set	reorder

	.end	CdLastPos
	.align	2
	.globl	CdReset
	.ent	CdReset
CdReset:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L5
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	CD_initintr
	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L5:
	jal	CD_init_80108140
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	bne	$16,$2,$L8
	jal	CD_initvol
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L8:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdReset
	.align	2
	.globl	CdFlush
	.ent	CdFlush
CdFlush:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_flush
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdFlush
	.align	2
	.globl	CdSetDebug
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(CD_debug) # high
	lw	$2,%lo(CD_debug)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,%lo(CD_debug)($3)
	.set	macro
	.set	reorder

	.end	CdSetDebug
	.align	2
	.globl	CdSync
	.ent	CdSync
CdSync:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_sync
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdSync
	.align	2
	.globl	CdReady
	.ent	CdReady
CdReady:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_ready
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdReady
	.align	2
	.globl	CdSyncCallback
	.ent	CdSyncCallback
CdSyncCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(CD_cbsync) # high
	lw	$2,%lo(CD_cbsync)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,%lo(CD_cbsync)($3)
	.set	macro
	.set	reorder

	.end	CdSyncCallback
	.align	2
	.globl	CdReadyCallback
	.ent	CdReadyCallback
CdReadyCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(CD_cbready) # high
	lw	$2,%lo(CD_cbready)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,%lo(CD_cbready)($3)
	.set	macro
	.set	reorder

	.end	CdReadyCallback
	.align	2
	.globl	CdControl
	.ent	CdControl
CdControl:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	li	$16,3			# 0x00000003
	lui	$2,%hi(CD_cbsync) # high
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	andi	$19,$20,0x00ff
	lui	$3,%hi(_cd_param_count) # high
	addiu	$3,$3,%lo(_cd_param_count) # low
	sw	$21,36($sp)
	lw	$21,%lo(CD_cbsync)($2)
	sll	$4,$19,2
	sw	$23,44($sp)
	addu	$23,$4,$3
	sw	$fp,48($sp)
	move	$fp,$0
	sw	$22,40($sp)
	move	$22,$2
	sw	$31,52($sp)
$L16:
	li	$8,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$19,$8,$L19
	sw	$0,%lo(CD_cbsync)($22)
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_status) # high
	lbu	$2,%lo(CD_status)($2)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	move	$4,$8
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$5
	.set	macro
	.set	reorder

$L19:
	beq	$17,$0,$L21
	lw	$2,0($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L21
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L18
$L21:
	sw	$21,%lo(CD_cbsync)($22)
	andi	$4,$20,0x00ff
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L26
	addu	$2,$fp,1
	.set	macro
	.set	reorder

$L18:
	addu	$16,$16,-1
	li	$8,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$16,$8,$L16
	lui	$2,%hi(CD_cbsync) # high
	.set	macro
	.set	reorder

	sw	$21,%lo(CD_cbsync)($2)
	move	$fp,$8
	addu	$2,$fp,1
$L26:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CdControl
	.align	2
	.globl	CdControlF
	.ent	CdControlF
CdControlF:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	move	$17,$5
	sw	$19,28($sp)
	move	$19,$4
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
 #APP
 #NO_APP
	li	$16,3			# 0x00000003
	andi	$18,$19,0x00ff
 #APP
 #NO_APP
	lui	$2,%hi(CD_cbsync) # high
	lui	$3,%hi(_cd_param_count) # high
	addiu	$3,$3,%lo(_cd_param_count) # low
	sll	$4,$18,2
	addu	$22,$4,$3
	move	$23,$0
	li	$fp,-1			# 0xffffffff
	move	$21,$2
	lw	$20,%lo(CD_cbsync)($2)
	li	$8,1			# 0x00000001
$L39:
	.set	noreorder
	.set	nomacro
	beq	$18,$8,$L31
	sw	$0,%lo(CD_cbsync)($21)
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_status) # high
	lbu	$2,%lo(CD_status)($2)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L31
	move	$4,$8
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$5
	.set	macro
	.set	reorder

$L31:
	beq	$17,$0,$L33
	lw	$2,0($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$5,$17
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$6
	.set	macro
	.set	reorder

	bne	$2,$0,$L30
$L33:
	sw	$20,%lo(CD_cbsync)($21)
	andi	$4,$19,0x00ff
	move	$5,$17
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	addu	$2,$23,1
	.set	macro
	.set	reorder

$L30:
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bne	$16,$fp,$L39
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_cbsync) # high
	sw	$20,%lo(CD_cbsync)($2)
	li	$23,-1			# 0xffffffff
	addu	$2,$23,1
$L38:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CdControlF
	.align	2
	.globl	CdControlB
	.ent	CdControlB
CdControlB:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	li	$16,3			# 0x00000003
	lui	$2,%hi(CD_cbsync) # high
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	andi	$19,$20,0x00ff
	lui	$3,%hi(_cd_param_count) # high
	addiu	$3,$3,%lo(_cd_param_count) # low
	sw	$21,36($sp)
	lw	$21,%lo(CD_cbsync)($2)
	sll	$4,$19,2
	sw	$23,44($sp)
	addu	$23,$4,$3
	sw	$fp,48($sp)
	li	$fp,-1			# 0xffffffff
	sw	$22,40($sp)
	move	$22,$2
	sw	$31,52($sp)
	li	$8,1			# 0x00000001
$L54:
	.set	noreorder
	.set	nomacro
	beq	$19,$8,$L44
	sw	$0,%lo(CD_cbsync)($22)
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_status) # high
	lbu	$2,%lo(CD_status)($2)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	move	$4,$8
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$5
	.set	macro
	.set	reorder

$L44:
	beq	$17,$0,$L46
	lw	$2,0($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L43
$L46:
	sw	$21,%lo(CD_cbsync)($22)
	andi	$4,$20,0x00ff
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	move	$2,$0
	.set	macro
	.set	reorder

$L43:
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bne	$16,$fp,$L54
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(CD_cbsync) # high
	sw	$21,%lo(CD_cbsync)($2)
	li	$2,-1			# 0xffffffff
$L49:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L51
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CD_sync
	move	$5,$18
	.set	macro
	.set	reorder

	xori	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	j	$L52
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L51:
	move	$2,$0
$L52:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CdControlB
	.align	2
	.globl	CdGetSector
	.ent	CdGetSector
CdGetSector:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_getsector
	lw	$31,16($sp)
	sltu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdGetSector
	.align	2
	.globl	CdGetSector2
	.ent	CdGetSector2
CdGetSector2:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_getsector2
	lw	$31,16($sp)
	sltu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdGetSector2
	.align	2
	.globl	CdDataCallback
	.ent	CdDataCallback
CdDataCallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$5,$4
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdDataCallback
	.align	2
	.globl	CdDataSync
	.ent	CdDataSync
CdDataSync:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CD_datasync
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CdDataSync
	.align	2
	.globl	CdIntToPos
	.ent	CdIntToPos
CdIntToPos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,458096640			# 0x1b4e0000
	ori	$3,$3,0x81b5
	addu	$4,$4,150
	mult	$4,$3
	move	$2,$5
	li	$5,-2004353024			# 0x88880000
	ori	$5,$5,0x8889
	mfhi	$3
	#nop
	#nop
	sra	$7,$3,3
	sra	$3,$4,31
	subu	$7,$7,$3
	mult	$7,$5
	li	$9,1717960704			# 0x66660000
	ori	$9,$9,0x6667
	sll	$5,$7,2
	addu	$5,$5,$7
	sll	$3,$5,4
	mfhi	$6
	#nop
	subu	$3,$3,$5
	subu	$4,$4,$3
	mult	$4,$9
	sra	$3,$7,31
	addu	$8,$6,$7
	sra	$8,$8,5
	subu	$8,$8,$3
	sll	$3,$8,4
	subu	$3,$3,$8
	mfhi	$5
	#nop
	sll	$3,$3,2
	subu	$7,$7,$3
	mult	$7,$9
	sra	$3,$4,31
	sra	$5,$5,2
	subu	$5,$5,$3
	sll	$6,$5,4
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$3,$3,1
	subu	$4,$4,$3
	mfhi	$11
	#nop
	addu	$6,$6,$4
	sra	$3,$7,31
	mult	$8,$9
	sb	$6,2($2)
	sra	$4,$11,2
	subu	$4,$4,$3
	sll	$5,$4,4
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,1
	subu	$7,$7,$3
	addu	$5,$5,$7
	sra	$3,$8,31
	sb	$5,1($2)
	mfhi	$9
	#nop
	#nop
	sra	$4,$9,2
	subu	$4,$4,$3
	sll	$5,$4,4
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,1
	subu	$8,$8,$3
	addu	$5,$5,$8
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$5,0($2)
	.set	macro
	.set	reorder

	.end	CdIntToPos
	.align	2
	.globl	CdPosToInt
	.ent	CdPosToInt
CdPosToInt:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$3,0($4)
	lbu	$6,1($4)
	srl	$5,$3,4
	sll	$2,$5,2
	addu	$2,$2,$5
	sll	$2,$2,1
	andi	$3,$3,0x000f
	addu	$2,$2,$3
	sll	$5,$2,4
	subu	$5,$5,$2
	sll	$5,$5,2
	srl	$3,$6,4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	andi	$6,$6,0x000f
	addu	$2,$2,$6
	addu	$5,$5,$2
	sll	$3,$5,2
	addu	$3,$3,$5
	sll	$2,$3,4
	lbu	$5,2($4)
	subu	$2,$2,$3
	srl	$4,$5,4
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,1
	andi	$5,$5,0x000f
	addu	$3,$3,$5
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,-150
	.set	macro
	.set	reorder

	.end	CdPosToInt
