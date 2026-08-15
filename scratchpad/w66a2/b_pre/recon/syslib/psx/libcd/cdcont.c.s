	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\cdcont.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

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
	lbu	$2,CD_status
	j	$31
	.end	CdStatus
	.align	2
	.globl	CdMode
	.ent	CdMode
CdMode:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,CD_mode
	j	$31
	.end	CdMode
	.align	2
	.globl	CdLastPos
	.ent	CdLastPos
CdLastPos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	la	$2,CD_pos
	j	$31
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
	addu	$16,$4,$0
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$Lvs0_0_5
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	CD_initintr
	.set	noreorder
	.set	nomacro
	j	$Lvs0_0_8
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$Lvs0_0_5:
	jal	CD_init_80108140
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lvs0_0_8
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	bne	$16,$2,$Lvs0_0_8
	jal	CD_initvol
	addu	$3,$2,$0
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$Lvs0_0_8
	addu	$2,$0,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$Lvs0_0_8:
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
	addu	$sp,$sp,24
	j	$31
	.end	CdFlush
	.align	2
	.globl	CdSetDebug
	.ent	CdSetDebug
CdSetDebug:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,CD_debug
	sw	$4,CD_debug
	j	$31
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
	addu	$sp,$sp,24
	j	$31
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
	addu	$sp,$sp,24
	j	$31
	.end	CdReady
	.align	2
	.globl	CdSyncCallback
	.ent	CdSyncCallback
CdSyncCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,CD_cbsync
	sw	$4,CD_cbsync
	j	$31
	.end	CdSyncCallback
	.align	2
	.globl	CdReadyCallback
	.ent	CdReadyCallback
CdReadyCallback:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,CD_cbready
	sw	$4,CD_cbready
	j	$31
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
	addu	$17,$5,$0
	sw	$18,24($sp)
	addu	$18,$6,$0
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$16,16($sp)
	li	$16,0x00000003		# 3
	sw	$19,28($sp)
	andi	$19,$20,0x00ff
	la	$3,_cd_param_count
	sw	$21,36($sp)
	lw	$21,CD_cbsync
	sll	$2,$19,2
	sw	$22,40($sp)
	addu	$22,$2,$3
	sw	$23,44($sp)
	addu	$23,$0,$0
	sw	$fp,48($sp)
	li	$fp,-1			# 0xffffffff
	sw	$31,52($sp)
$L17:
	sw	$0,CD_cbsync
	li	$8,0x00000001		# 1
	beq	$19,$8,$L20
	lbu	$2,CD_status
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

$L20:
	beq	$17,$0,$L22
	lw	$2,0($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L22
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	addu	$5,$17,$0
	addu	$6,$18,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L19
$L22:
	sw	$21,CD_cbsync
	andi	$4,$20,0x00ff
	addu	$5,$17,$0
	addu	$6,$18,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L27
	addu	$2,$23,1
	.set	macro
	.set	reorder

$L19:
	addu	$16,$16,-1
	bne	$16,$fp,$L17
	sw	$21,CD_cbsync
	li	$23,-1			# 0xffffffff
	addu	$2,$23,1
$L27:
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
	addu	$sp,$sp,56
	j	$31
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
	addu	$17,$5,$0
	sw	$19,28($sp)
	addu	$19,$4,$0
 #APP
 #NO_APP
	sw	$16,16($sp)
	li	$16,0x00000003		# 3
	sw	$fp,48($sp)
	li	$fp,0x00000001		# 1
	sw	$18,24($sp)
	andi	$18,$19,0x00ff
 #APP
 #NO_APP
	la	$3,_cd_param_count
	sw	$20,32($sp)
	lw	$20,CD_cbsync
	sll	$2,$18,2
	sw	$21,36($sp)
	addu	$21,$2,$3
	sw	$22,40($sp)
	addu	$22,$0,$0
	sw	$23,44($sp)
	li	$23,-1			# 0xffffffff
	sw	$31,52($sp)
$L29:
	sw	$0,CD_cbsync
	beq	$18,$fp,$L32
	lbu	$2,CD_status
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L32
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

$L32:
	beq	$17,$0,$L34
	lw	$2,0($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	addu	$5,$17,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L31
$L34:
	sw	$20,CD_cbsync
	andi	$4,$19,0x00ff
	addu	$5,$17,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	li	$7,0x00000001		# 1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	addu	$2,$22,1
	.set	macro
	.set	reorder

$L31:
	addu	$16,$16,-1
	bne	$16,$23,$L29
	sw	$20,CD_cbsync
	li	$22,-1			# 0xffffffff
	addu	$2,$22,1
$L39:
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
	addu	$sp,$sp,56
	j	$31
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
	addu	$17,$5,$0
	sw	$18,24($sp)
	addu	$18,$6,$0
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$16,16($sp)
	li	$16,0x00000003		# 3
	sw	$fp,48($sp)
	li	$fp,0x00000001		# 1
	sw	$19,28($sp)
	andi	$19,$20,0x00ff
	la	$3,_cd_param_count
	sw	$21,36($sp)
	lw	$21,CD_cbsync
	sll	$2,$19,2
	sw	$22,40($sp)
	addu	$22,$2,$3
	sw	$23,44($sp)
	li	$23,-1			# 0xffffffff
	sw	$31,52($sp)
$L41:
	sw	$0,CD_cbsync
	beq	$19,$fp,$L44
	lbu	$2,CD_status
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L44
	li	$4,0x00000001		# 1
	.set	macro
	.set	reorder

	addu	$5,$0,$0
	addu	$6,$0,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

$L44:
	beq	$17,$0,$L46
	lw	$2,0($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L46
	li	$4,0x00000002		# 2
	.set	macro
	.set	reorder

	addu	$5,$17,$0
	addu	$6,$18,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L43
$L46:
	sw	$21,CD_cbsync
	andi	$4,$20,0x00ff
	addu	$5,$17,$0
	addu	$6,$18,$0
	.set	noreorder
	.set	nomacro
	jal	CD_cw
	addu	$7,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	addu	$2,$0,$0
	.set	macro
	.set	reorder

$L43:
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bne	$16,$23,$L41
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$21,CD_cbsync
$L49:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L51
	addu	$4,$0,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CD_sync
	addu	$5,$18,$0
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
	addu	$2,$0,$0
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
	addu	$sp,$sp,56
	j	$31
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
	.set	noreorder
	lw	$31,16($sp)
	sltu	$2,$2,1
	j	$31
	addu	$sp,$sp,24
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
	.set	noreorder
	lw	$31,16($sp)
	sltu	$2,$2,1
	j	$31
	addu	$sp,$sp,24
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
	sw	$31,16($sp)
	addu	$5,$4,$0
	.set	noreorder
	.set	nomacro
	jal	DMACallback
	li	$4,0x00000003		# 3
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	addu	$sp,$sp,24
	j	$31
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
	addu	$sp,$sp,24
	j	$31
	.end	CdDataSync
	.align	2
	.globl	CdIntToPos
	.ent	CdIntToPos
CdIntToPos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,0x1b4e0000		# 458096640
	ori	$3,$3,0x81b5
	addu	$4,$4,150
	mult	$4,$3
	addu	$2,$5,$0
	li	$5,-2004353024			# 0x88880000
	ori	$5,$5,0x8889
	mfhi	$3
	#nop
	#nop
	sra	$7,$3,3
	sra	$3,$4,31
	subu	$7,$7,$3
	mult	$7,$5
	li	$9,0x66660000		# 1717960704
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
