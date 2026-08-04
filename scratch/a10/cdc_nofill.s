
.file	1 "C:\\Temp\\nfs4-wt48-a10\\recon\\syslib\\psx\\libcd\\cdcont.c"
gcc2_compiled.:
__gnu_compiled_c:
.text
.align	2
.globl	CdStatus
.align	2
.globl	CdMode
.align	2
.globl	CdLastPos
.align	2
.globl	CdReset
.align	2
.globl	CdFlush
.align	2
.globl	CdSetDebug
.align	2
.globl	CdSync
.align	2
.globl	CdReady
.align	2
.globl	CdSyncCallback
.align	2
.globl	CdReadyCallback
.align	2
.globl	CdControl
.align	2
.globl	CdControlF
.align	2
.globl	CdControlB
.align	2
.globl	CdGetSector
.align	2
.globl	CdGetSector2
.align	2
.globl	CdDataCallback
.align	2
.globl	CdDataSync
.align	2
.globl	CdIntToPos
.align	2
.globl	CdPosToInt

.extern	CD_cbready, 4
.extern	CD_cbsync, 4
.extern	CD_debug, 4
.extern	CD_pos, 4
.extern	CD_mode, 1
.extern	CD_status, 1

.text
.text
.ent	CdStatus
.set	noreorder
CdStatus:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lbu	$2,CD_status
#nop # DEBUG: 'j	$31' does not load from $2
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM1:
.end	CdStatus
.text
.ent	CdMode
.set	noreorder
CdMode:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lbu	$2,CD_mode
#nop # DEBUG: 'j	$31' does not load from $2
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM2:
.end	CdMode
.text
.ent	CdLastPos
.set	noreorder
CdLastPos:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
la	$2,CD_pos
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM3:
.end	CdLastPos
.text
.ent	CdReset
.set	noreorder
CdReset:
.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
.mask	0x80010000,-4
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$16,16($sp)
addu	$16,$4,$zero
li	$2,2			# 0x00000002
bne	$16,$2,$L5
sw	$31,20($sp)

jal	CD_initintr
nop  # DEBUG: branch/jump
j	$L8
li	$2,1			# 0x00000001

$L5:
jal	CD_init
nop  # DEBUG: branch/jump
bne	$2,$0,$L8
addu	$2,$0,$zero

li	$2,1			# 0x00000001
bne	$16,$2,$L8
nop  # DEBUG: branch/jump
jal	CD_initvol
nop  # DEBUG: branch/jump
addu	$3,$2,$zero
bne	$3,$0,$L8
addu	$2,$0,$zero

li	$2,1			# 0x00000001
$L8:
lw	$31,20($sp)
#nop # DEBUG: 'lw	$16,16($sp)' does not load from $31
lw	$16,16($sp)
#nop # DEBUG: 'j	$31' does not load from $16
j	$31
addu	$sp,$sp,24


.loc	1 0
LM4:
.end	CdReset
.text
.ent	CdFlush
.set	noreorder
CdFlush:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_flush
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'addu	$sp,$sp,24' does not load from $31
addu	$sp,$sp,24
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM5:
.end	CdFlush
.text
.ent	CdSetDebug
.set	noreorder
CdSetDebug:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lw	$2,CD_debug
#nop # DEBUG: 'sw	$4,CD_debug' does not load from $2
sw	$4,CD_debug
j	$31

.loc	1 0
LM6:
.end	CdSetDebug
.text
.ent	CdSync
.set	noreorder
CdSync:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_sync
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'addu	$sp,$sp,24' does not load from $31
addu	$sp,$sp,24
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM7:
.end	CdSync
.text
.ent	CdReady
.set	noreorder
CdReady:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_ready
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'addu	$sp,$sp,24' does not load from $31
addu	$sp,$sp,24
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM8:
.end	CdReady
.text
.ent	CdSyncCallback
.set	noreorder
CdSyncCallback:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lw	$2,CD_cbsync
#nop # DEBUG: 'sw	$4,CD_cbsync' does not load from $2
sw	$4,CD_cbsync
j	$31

.loc	1 0
LM9:
.end	CdSyncCallback
.text
.ent	CdReadyCallback
.set	noreorder
CdReadyCallback:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lw	$2,CD_cbready
#nop # DEBUG: 'sw	$4,CD_cbready' does not load from $2
sw	$4,CD_cbready
j	$31

.loc	1 0
LM10:
.end	CdReadyCallback
.text
.ent	CdControl
.set	noreorder
CdControl:
.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
.mask	0x80ff0000,-8
.fmask	0x00000000,0
subu	$sp,$sp,56
sw	$20,32($sp)
addu	$20,$5,$zero
sw	$21,36($sp)
addu	$21,$6,$zero
sw	$18,24($sp)
addu	$18,$4,$zero
sw	$16,16($sp)
li	$16,3			# 0x00000003
sw	$17,20($sp)
andi	$17,$18,0x00ff
lui	$2,%hi(_cd_param_count) # high
addiu	$2,$2,%lo(_cd_param_count) # low
sw	$19,28($sp)
lw	$19,CD_cbsync
#nop # DEBUG: 'sll	$3,$17,2' does not load from $19
sll	$3,$17,2
sw	$22,40($sp)
addu	$22,$3,$2
sw	$23,44($sp)
addu	$23,$0,$zero
sw	$31,48($sp)
$L28:
sw	$0,CD_cbsync
li	$2,1			# 0x00000001
beq	$17,$2,$L29
nop  # DEBUG: branch/jump
lbu	$2,CD_status
nop # DEBUG: Reuse of '$2'. 'andi	$2,$2,0x0010' does not use $at
andi	$2,$2,0x0010
beq	$2,$0,$L29
li	$4,1			# 0x00000001

addu	$5,$0,$zero
addu	$6,$5,$zero
jal	CD_cw
addu	$7,$5,$zero

$L29:
beq	$20,$0,$L31
nop  # DEBUG: branch/jump
lw	$2,0($22)
nop # DEBUG: Reuse of '$2'. 'beq	$2,$0,$L31' does not use $at
beq	$2,$0,$L31
li	$4,2			# 0x00000002

addu	$5,$20,$zero
addu	$6,$21,$zero
jal	CD_cw
addu	$7,$0,$zero

bne	$2,$0,$L26
nop  # DEBUG: branch/jump
$L31:
sw	$19,CD_cbsync
andi	$4,$18,0x00ff
addu	$5,$20,$zero
addu	$6,$21,$zero
jal	CD_cw
addu	$7,$0,$zero

beq	$2,$0,$L34
addu	$2,$23,1

$L26:
addu	$16,$16,-1
li	$2,-1			# 0xffffffff
bne	$16,$2,$L28
nop  # DEBUG: branch/jump
sw	$19,CD_cbsync
addu	$23,$2,$zero
addu	$2,$23,1
$L34:
lw	$31,48($sp)
#nop # DEBUG: 'lw	$23,44($sp)' does not load from $31
lw	$23,44($sp)
#nop # DEBUG: 'lw	$22,40($sp)' does not load from $23
lw	$22,40($sp)
#nop # DEBUG: 'lw	$21,36($sp)' does not load from $22
lw	$21,36($sp)
#nop # DEBUG: 'lw	$20,32($sp)' does not load from $21
lw	$20,32($sp)
#nop # DEBUG: 'lw	$19,28($sp)' does not load from $20
lw	$19,28($sp)
#nop # DEBUG: 'lw	$18,24($sp)' does not load from $19
lw	$18,24($sp)
#nop # DEBUG: 'lw	$17,20($sp)' does not load from $18
lw	$17,20($sp)
#nop # DEBUG: 'lw	$16,16($sp)' does not load from $17
lw	$16,16($sp)
#nop # DEBUG: 'j	$31' does not load from $16
j	$31
addu	$sp,$sp,56


.loc	1 0
LM11:
.end	CdControl
.text
.ent	CdControlF
.set	noreorder
CdControlF:
.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
.mask	0x807f0000,-4
.fmask	0x00000000,0
subu	$sp,$sp,48
sw	$20,32($sp)
addu	$20,$5,$zero
sw	$18,24($sp)
addu	$18,$4,$zero
sw	$16,16($sp)
li	$16,3			# 0x00000003
sw	$17,20($sp)
andi	$17,$18,0x00ff
lui	$2,%hi(_cd_param_count) # high
addiu	$2,$2,%lo(_cd_param_count) # low
sw	$19,28($sp)
lw	$19,CD_cbsync
#nop # DEBUG: 'sll	$3,$17,2' does not load from $19
sll	$3,$17,2
sw	$21,36($sp)
addu	$21,$3,$2
sw	$22,40($sp)
addu	$22,$0,$zero
sw	$31,44($sp)
$L39:
sw	$0,CD_cbsync
li	$2,1			# 0x00000001
beq	$17,$2,$L40
nop  # DEBUG: branch/jump
lbu	$2,CD_status
nop # DEBUG: Reuse of '$2'. 'andi	$2,$2,0x0010' does not use $at
andi	$2,$2,0x0010
beq	$2,$0,$L40
li	$4,1			# 0x00000001

addu	$5,$0,$zero
addu	$6,$5,$zero
jal	CD_cw
addu	$7,$5,$zero

$L40:
beq	$20,$0,$L42
nop  # DEBUG: branch/jump
lw	$2,0($21)
nop # DEBUG: Reuse of '$2'. 'beq	$2,$0,$L42' does not use $at
beq	$2,$0,$L42
li	$4,2			# 0x00000002

addu	$5,$20,$zero
addu	$6,$0,$zero
jal	CD_cw
addu	$7,$6,$zero

bne	$2,$0,$L37
nop  # DEBUG: branch/jump
$L42:
sw	$19,CD_cbsync
andi	$4,$18,0x00ff
addu	$5,$20,$zero
addu	$6,$0,$zero
jal	CD_cw
li	$7,1			# 0x00000001

beq	$2,$0,$L45
addu	$2,$22,1

$L37:
addu	$16,$16,-1
li	$2,-1			# 0xffffffff
bne	$16,$2,$L39
nop  # DEBUG: branch/jump
sw	$19,CD_cbsync
addu	$22,$2,$zero
addu	$2,$22,1
$L45:
lw	$31,44($sp)
#nop # DEBUG: 'lw	$22,40($sp)' does not load from $31
lw	$22,40($sp)
#nop # DEBUG: 'lw	$21,36($sp)' does not load from $22
lw	$21,36($sp)
#nop # DEBUG: 'lw	$20,32($sp)' does not load from $21
lw	$20,32($sp)
#nop # DEBUG: 'lw	$19,28($sp)' does not load from $20
lw	$19,28($sp)
#nop # DEBUG: 'lw	$18,24($sp)' does not load from $19
lw	$18,24($sp)
#nop # DEBUG: 'lw	$17,20($sp)' does not load from $18
lw	$17,20($sp)
#nop # DEBUG: 'lw	$16,16($sp)' does not load from $17
lw	$16,16($sp)
#nop # DEBUG: 'j	$31' does not load from $16
j	$31
addu	$sp,$sp,48


.loc	1 0
LM12:
.end	CdControlF
.text
.ent	CdControlB
.set	noreorder
CdControlB:
.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
.mask	0x807f0000,-4
.fmask	0x00000000,0
subu	$sp,$sp,48
sw	$20,32($sp)
addu	$20,$5,$zero
sw	$21,36($sp)
addu	$21,$6,$zero
sw	$18,24($sp)
addu	$18,$4,$zero
sw	$16,16($sp)
li	$16,3			# 0x00000003
sw	$17,20($sp)
andi	$17,$18,0x00ff
lui	$2,%hi(_cd_param_count) # high
addiu	$2,$2,%lo(_cd_param_count) # low
sw	$19,28($sp)
lw	$19,CD_cbsync
#nop # DEBUG: 'sll	$3,$17,2' does not load from $19
sll	$3,$17,2
sw	$22,40($sp)
addu	$22,$3,$2
sw	$31,44($sp)
$L51:
sw	$0,CD_cbsync
li	$2,1			# 0x00000001
beq	$17,$2,$L52
nop  # DEBUG: branch/jump
lbu	$2,CD_status
nop # DEBUG: Reuse of '$2'. 'andi	$2,$2,0x0010' does not use $at
andi	$2,$2,0x0010
beq	$2,$0,$L52
li	$4,1			# 0x00000001

addu	$5,$0,$zero
addu	$6,$5,$zero
jal	CD_cw
addu	$7,$5,$zero

$L52:
beq	$20,$0,$L54
nop  # DEBUG: branch/jump
lw	$2,0($22)
nop # DEBUG: Reuse of '$2'. 'beq	$2,$0,$L54' does not use $at
beq	$2,$0,$L54
li	$4,2			# 0x00000002

addu	$5,$20,$zero
addu	$6,$21,$zero
jal	CD_cw
addu	$7,$0,$zero

bne	$2,$0,$L49
nop  # DEBUG: branch/jump
$L54:
sw	$19,CD_cbsync
andi	$4,$18,0x00ff
addu	$5,$20,$zero
addu	$6,$21,$zero
jal	CD_cw
addu	$7,$0,$zero

beq	$2,$0,$L48
addu	$2,$0,$zero

$L49:
addu	$16,$16,-1
li	$2,-1			# 0xffffffff
bne	$16,$2,$L51
nop  # DEBUG: branch/jump
sw	$19,CD_cbsync
$L48:
bne	$2,$0,$L47
addu	$4,$0,$zero

jal	CD_sync
addu	$5,$21,$zero

xori	$2,$2,0x0002
j	$L57
sltu	$2,$2,1

$L47:
addu	$2,$0,$zero
$L57:
lw	$31,44($sp)
#nop # DEBUG: 'lw	$22,40($sp)' does not load from $31
lw	$22,40($sp)
#nop # DEBUG: 'lw	$21,36($sp)' does not load from $22
lw	$21,36($sp)
#nop # DEBUG: 'lw	$20,32($sp)' does not load from $21
lw	$20,32($sp)
#nop # DEBUG: 'lw	$19,28($sp)' does not load from $20
lw	$19,28($sp)
#nop # DEBUG: 'lw	$18,24($sp)' does not load from $19
lw	$18,24($sp)
#nop # DEBUG: 'lw	$17,20($sp)' does not load from $18
lw	$17,20($sp)
#nop # DEBUG: 'lw	$16,16($sp)' does not load from $17
lw	$16,16($sp)
#nop # DEBUG: 'j	$31' does not load from $16
j	$31
addu	$sp,$sp,48


.loc	1 0
LM13:
.end	CdControlB
.text
.ent	CdGetSector
.set	noreorder
CdGetSector:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_getsector
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'sltu	$2,$2,1' does not load from $31
sltu	$2,$2,1
j	$31
addu	$sp,$sp,24


.loc	1 0
LM14:
.end	CdGetSector
.text
.ent	CdGetSector2
.set	noreorder
CdGetSector2:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_getsector2
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'sltu	$2,$2,1' does not load from $31
sltu	$2,$2,1
j	$31
addu	$sp,$sp,24


.loc	1 0
LM15:
.end	CdGetSector2
.text
.ent	CdDataCallback
.set	noreorder
CdDataCallback:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
addu	$5,$4,$zero
sw	$31,16($sp)
jal	DMACallback
li	$4,3			# 0x00000003

lw	$31,16($sp)
nop # DEBUG: Reuse of '$31'. 'j	$31' does not use $at
j	$31
addu	$sp,$sp,24


.loc	1 0
LM16:
.end	CdDataCallback
.text
.ent	CdDataSync
.set	noreorder
CdDataSync:
.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
.mask	0x80000000,-8
.fmask	0x00000000,0
subu	$sp,$sp,24
sw	$31,16($sp)
jal	CD_datasync
nop  # DEBUG: branch/jump
lw	$31,16($sp)
#nop # DEBUG: 'addu	$sp,$sp,24' does not load from $31
addu	$sp,$sp,24
j	$31
nop  # DEBUG: branch/jump

.loc	1 0
LM17:
.end	CdDataSync
.text
.ent	CdIntToPos
.set	noreorder
CdIntToPos:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
li	$8,458096640			# 0x1b4e0000
ori	$8,$8,0x81b5
addu	$4,$4,150
mult	$4,$8
addu	$2,$5,$zero
li	$9,1717960704			# 0x66660000
ori	$9,$9,0x6667
mfhi	$3
sra	$7,$3,3
sra	$3,$4,31
subu	$7,$7,$3
sll	$5,$7,2
addu	$5,$5,$7
sll	$3,$5,4
subu	$3,$3,$5
subu	$4,$4,$3
mult	$4,$9
mfhi	$6
li	$3,-2004353024			# 0x88880000
ori	$3,$3,0x8889
mult	$7,$3
sra	$5,$6,2
sra	$3,$4,31
mfhi	$10
subu	$5,$5,$3
sll	$6,$5,4
mult	$7,$8
sll	$3,$5,2
addu	$3,$3,$5
sll	$3,$3,1
subu	$4,$4,$3
addu	$6,$6,$4
addu	$5,$10,$7
sra	$5,$5,5
sra	$8,$7,31
subu	$5,$5,$8
sll	$3,$5,4
subu	$3,$3,$5
mfhi	$11
sll	$3,$3,2
subu	$7,$7,$3
mult	$7,$9
sb	$6,2($2)
sra	$4,$11,6
subu	$4,$4,$8
sll	$6,$4,4
sll	$3,$4,2
addu	$3,$3,$4
sll	$3,$3,1
subu	$5,$5,$3
addu	$6,$6,$5
sra	$3,$7,31
sb	$6,0($2)
mfhi	$9
sra	$4,$9,2
subu	$4,$4,$3
sll	$5,$4,4
sll	$3,$4,2
addu	$3,$3,$4
sll	$3,$3,1
subu	$7,$7,$3
addu	$5,$5,$7
j	$31
sb	$5,1($2)


.loc	1 0
LM18:
.end	CdIntToPos
.text
.ent	CdPosToInt
.set	noreorder
CdPosToInt:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
.mask	0x00000000,0
.fmask	0x00000000,0
lbu	$3,0($4)
#nop # DEBUG: 'lbu	$6,1($4)' does not load from $3
lbu	$6,1($4)
#nop # DEBUG: 'srl	$5,$3,4' does not load from $6
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
#nop # DEBUG: 'subu	$2,$2,$3' does not load from $5
subu	$2,$2,$3
srl	$4,$5,4
sll	$3,$4,2
addu	$3,$3,$4
sll	$3,$3,1
andi	$5,$5,0x000f
addu	$3,$3,$5
addu	$2,$2,$3
j	$31
addu	$2,$2,-150


.loc	1 0
LM19:
.end	CdPosToInt
