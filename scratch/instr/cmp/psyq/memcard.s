	.file	1 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
gcc2_compiled.:
__gnu_compiled_c:
	.data
	.align	2
ascii_table:
	.half	33359
	.half	48
	.half	33376
	.half	65
	.half	33409
	.half	97
	.align	2
ascii_k_table:
	.half	33088
	.half	33097
	.half	33128
	.half	33172
	.half	33168
	.half	33171
	.half	33173
	.half	33126
	.half	33129
	.half	33130
	.half	33174
	.half	33147
	.half	33091
	.half	33148
	.half	33092
	.half	33118
	.half	33094
	.half	33095
	.half	33137
	.half	33153
	.half	33138
	.half	33096
	.half	33175
	.half	33133
	.half	33167
	.half	33134
	.half	33103
	.half	33105
	.half	33125
	.half	33135
	.half	33122
	.half	33136
	.half	33104
	.align	2
sjis_table:
	.byte	79
	.byte	48
	.byte	96
	.byte	65
	.byte	129
	.byte	97
	.align	2
sjis_k_table:
	.byte	32
	.byte	0
	.byte	0
	.byte	44
	.byte	46
	.byte	0
	.byte	58
	.byte	59
	.byte	63
	.byte	33
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	94
	.byte	126
	.byte	95
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	47
	.byte	0
	.byte	0
	.byte	0
	.byte	124
	.byte	0
	.byte	0
	.byte	96
	.byte	39
	.byte	0
	.byte	34
	.byte	40
	.byte	41
	.byte	0
	.byte	0
	.byte	91
	.byte	93
	.byte	123
	.byte	125
	.byte	60
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	43
	.byte	45
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	61
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	92
	.byte	36
	.byte	0
	.byte	0
	.byte	37
	.byte	35
	.byte	38
	.byte	42
	.byte	64
	.text
	.align	2
	.globl	MCRD_init
	.align	2
	.globl	iMCRD_InitCard
	.align	2
	.globl	MCRD_restore
	.align	2
	.globl	MCRD_getopts
	.align	2
	.globl	MCRD_setopts
	.align	2
	.globl	MCRD_loadfile
	.align	2
	.globl	iMCRD_DoFileLoad
	.align	2
	.globl	MCRD_savefile
	.align	2
	.globl	iMCRD_DoFileWrite
	.align	2
	.globl	iMCRD_DoFileDelete
	.align	2
	.globl	MCRD_handlecardevents
	.align	2
	.globl	MCRD_fileexists
	.align	2
	.globl	iMCRD_timersub
	.sdata
	.align	2
$LC0:
	.ascii	"*\000"
	.text
	.align	2
	.globl	garyMemCardGrabBlocks
	.align	2
	.globl	iMCRD_LoadCard
	.align	2
	.globl	iMCRD_FormatCard
	.align	2
	.globl	iMCRD_HandleError
	.align	2
	.globl	iMCRD_DefaultCBProc1
	.align	2
	.globl	ascii2sjis
	.align	2
	.globl	sjis2ascii

	.extern	timerhz, 4
	.extern	gMemCardInfo, 6108

	.text
	.text
	.ent	MCRD_init
MCRD_init:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	lui	$16,%hi(gMemCardInfo) # high
	addiu	$16,$16,%lo(gMemCardInfo) # low
	move	$4,$16
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,6108			# 0x000017dc
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lui	$2,%hi(iMCRD_DefaultCBProc1) # high
	addiu	$2,$2,%lo(iMCRD_DefaultCBProc1) # low
	sw	$2,36($16)
	sw	$2,32($16)
	lui	$2,%hi(asyncidle) # high
	addiu	$2,$2,%lo(asyncidle) # low
	sw	$0,48($16)
	sw	$17,56($16)
	sw	$2,44($16)
	.set	noreorder
	.set	nomacro
	jal	MemCardInit
	sw	$2,40($16)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
$L2:
	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iMCRD_InitCard
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	lui	$4,%hi(iMCRD_timersub) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	addtimer
	addiu	$4,$4,%lo(iMCRD_timersub) # low
	.set	macro
	.set	reorder

	jal	MemCardStart
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

	.end	MCRD_init
	.text
	.ent	iMCRD_InitCard
iMCRD_InitCard:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	MCRD_getcard
	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L7
	addu	$4,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L7:
	li	$2,-1			# 0xffffffff
	sw	$2,0($3)
	li	$2,15			# 0x0000000f
	li	$5,600			# 0x00000258
	sw	$0,4($3)
	sw	$0,8($3)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$2,12($3)
	.set	macro
	.set	reorder

	move	$2,$0
$L8:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	iMCRD_InitCard
	.text
	.ent	MCRD_restore
MCRD_restore:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(iMCRD_timersub) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(iMCRD_timersub) # low
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	move	$6,$4
	.set	macro
	.set	reorder

	jal	MemCardStop
	jal	MemCardEnd
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MCRD_restore
	.text
	.ent	MCRD_getopts
MCRD_getopts:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gMemCardInfo) # high
	lw	$3,%lo(gMemCardInfo)($2)
	addiu	$2,$2,%lo(gMemCardInfo) # low
	sw	$0,4($4)
	sw	$3,0($4)
	lw	$3,32($2)
	#nop
	sw	$3,20($4)
	lw	$3,36($2)
	#nop
	sw	$3,24($4)
	lw	$3,40($2)
	#nop
	sw	$3,28($4)
	lw	$3,44($2)
	#nop
	sw	$3,32($4)
	lw	$3,20($2)
	#nop
	sw	$3,8($4)
	lwl	$5,27($2)
	lwr	$5,24($2)
	lwl	$6,31($2)
	lwr	$6,28($2)
	swl	$5,15($4)
	swr	$5,12($4)
	swl	$6,19($4)
	swr	$6,16($4)
	j	$31
	.end	MCRD_getopts
	.text
	.ent	MCRD_setopts
MCRD_setopts:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	lui	$2,%hi(gMemCardInfo) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(gMemCardInfo) # low
	li	$2,66			# 0x00000042
	sb	$2,4($4)
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L14
	li	$2,73			# 0x00000049
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L17
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L15
	lui	$3,%hi(gMemCardInfo+5) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L21
	li	$2,65			# 0x00000041
	.set	macro
	.set	reorder

$L14:
	.set	noreorder
	.set	nomacro
	j	$L13
	sb	$2,5($4)
	.set	macro
	.set	reorder

$L15:
	li	$2,69			# 0x00000045
	.set	noreorder
	.set	nomacro
	j	$L13
	sb	$2,5($4)
	.set	macro
	.set	reorder

$L17:
	lui	$3,%hi(gMemCardInfo+5) # high
	li	$2,65			# 0x00000041
$L21:
	sb	$2,%lo(gMemCardInfo+5)($3)
$L13:
	lui	$16,%hi(gMemCardInfo+6) # high
	addiu	$16,$16,%lo(gMemCardInfo+6) # low
	move	$4,$16
	lw	$5,4($17)
	.set	noreorder
	.set	nomacro
	jal	strncpy
	li	$6,10			# 0x0000000a
	.set	macro
	.set	reorder

	sb	$0,10($16)
	lw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L19
	sw	$2,-6($16)
	.set	macro
	.set	reorder

$L12:
	lui	$3,%hi(gMemCardInfo) # high
	addiu	$2,$3,%lo(gMemCardInfo) # low
	sb	$0,4($2)
	sw	$0,%lo(gMemCardInfo)($3)
$L19:
	lui	$2,%hi(gMemCardInfo) # high
	lw	$3,20($17)
	addiu	$2,$2,%lo(gMemCardInfo) # low
	sw	$3,32($2)
	lw	$3,24($17)
	#nop
	sw	$3,36($2)
	lw	$3,28($17)
	#nop
	sw	$3,40($2)
	lw	$3,32($17)
	#nop
	sw	$3,44($2)
	lw	$3,8($17)
	#nop
	sw	$3,20($2)
	lwl	$7,15($17)
	lwr	$7,12($17)
	lwl	$8,19($17)
	lwr	$8,16($17)
	swl	$7,27($2)
	swr	$7,24($2)
	swl	$8,31($2)
	swr	$8,28($2)
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

	.end	MCRD_setopts
	.text
	.ent	MCRD_loadfile
MCRD_loadfile:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$16,16($sp)
	lui	$16,%hi(gMemCardInfo+608) # high
	sw	$19,28($sp)
	addiu	$19,$16,%lo(gMemCardInfo+608) # low
	move	$4,$19
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,572			# 0x0000023c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L23
	sw	$18,%lo(gMemCardInfo+608)($16)
	.set	macro
	.set	reorder

	addu	$4,$19,4
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$19,-604
	.set	macro
	.set	reorder

$L23:
	lw	$5,0($20)
	.set	noreorder
	.set	nomacro
	jal	strcat
	addu	$4,$19,4
	.set	macro
	.set	reorder

	lw	$2,4($20)
	#nop
	sw	$2,28($19)
	lw	$2,8($20)
	#nop
	sw	$2,32($19)
	lw	$2,12($20)
	#nop
	sw	$2,36($19)
	lw	$2,24($20)
	#nop
	sw	$2,560($19)
	lw	$2,28($20)
	#nop
	sw	$2,564($19)
	lw	$2,32($20)
	#nop
	sw	$2,568($19)
	lw	$2,20($20)
	addu	$3,$19,-608
	sw	$2,556($19)
	addu	$2,$19,46
	sw	$2,36($20)
	addu	$2,$19,47
	sw	$2,40($20)
	li	$2,3			# 0x00000003
	sw	$2,48($3)
	sw	$0,52($3)
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	MCRD_loadfile
	.text
	.ent	iMCRD_DoFileLoad
iMCRD_DoFileLoad:
	.frame	$sp,72,$31		# vars= 8, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	lui	$2,%hi(gMemCardInfo+608) # high
	sw	$18,40($sp)
	addiu	$18,$2,%lo(gMemCardInfo+608) # low
	sw	$31,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,28($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	move	$23,$4
	.set	macro
	.set	reorder

	lw	$2,560($18)
	#nop
	beq	$2,$0,$L25
$L26:
	addu	$5,$18,4
	addu	$6,$18,44
	move	$7,$0
	addu	$2,$18,-608
	move	$16,$2
	lw	$4,60($16)
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	MemCardReadFile
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	sw	$2,28($sp)
	li	$4,1			# 0x00000001
$L52:
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,40($16)
	#nop
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L52
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L28:
	lw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	move	$6,$23
	.set	macro
	.set	reorder

	bne	$2,$0,$L51
	lw	$2,28($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L31
	move	$17,$0
	.set	macro
	.set	reorder

	move	$16,$18
$L34:
	lh	$4,48($16)
	jal	sjis2ascii
	lw	$3,28($18)
	#nop
	addu	$3,$3,$17
	sb	$2,0($3)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L31
	addu	$16,$16,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L34
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L31:
	move	$17,$0
	li	$22,1			# 0x00000001
	li	$20,16			# 0x00000010
	li	$19,-268435456			# 0xf0000000
	ori	$19,$19,0xffff
	li	$21,-4096			# 0xfffff000
	sll	$2,$17,2
$L53:
	addu	$2,$18,$2
	lw	$16,560($2)
	#nop
	beq	$16,$0,$L25
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L41
	addu	$4,$18,172
	.set	macro
	.set	reorder

	bne	$17,$22,$L42
	.set	noreorder
	.set	nomacro
	j	$L41
	addu	$4,$18,300
	.set	macro
	.set	reorder

$L42:
	addu	$4,$18,428
$L41:
	addu	$5,$16,16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	shapetype
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$4,$18,140
	sb	$2,0($16)
	andi	$3,$2,0x00ff
	li	$6,32			# 0x00000020
	lw	$2,12($16)
	ori	$3,$3,0x9000
	sw	$3,0($16)
	sra	$3,$3,8
	sh	$20,6($16)
	sh	$20,4($16)
	sh	$0,10($16)
	sh	$0,8($16)
	and	$2,$2,$19
	and	$2,$2,$21
	sw	$2,12($16)
	addu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$5,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	cluttype
	li	$4,16			# 0x00000010
	.set	macro
	.set	reorder

	sb	$2,0($16)
	andi	$3,$2,0x00ff
	lw	$2,12($16)
	addu	$17,$17,1
	sh	$20,4($16)
	sh	$22,6($16)
	sh	$0,10($16)
	sh	$0,8($16)
	sw	$3,0($16)
	and	$2,$2,$19
	and	$2,$2,$21
	sw	$2,12($16)
	slt	$2,$17,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L53
	sll	$2,$17,2
	.set	macro
	.set	reorder

$L25:
	lw	$3,32($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L45
	lui	$2,%hi(gMemCardInfo) # high
	.set	macro
	.set	reorder

	addiu	$16,$2,%lo(gMemCardInfo) # low
	lw	$4,60($16)
	lw	$6,556($18)
	lw	$7,36($18)
	addu	$5,$18,4
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MemCardReadFile
	addu	$7,$7,512
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L47
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,52($16)
	.set	noreorder
	.set	nomacro
	j	$L51
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

$L47:
	move	$4,$0
$L54:
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L54
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
	lw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	move	$6,$23
	.set	macro
	.set	reorder

	bne	$2,$0,$L51
$L45:
	lui	$3,%hi(gMemCardInfo+52) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(gMemCardInfo+52)($3)
	li	$2,15			# 0x0000000f
$L51:
	lw	$31,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	iMCRD_DoFileLoad
	.text
	.ent	MCRD_savefile
MCRD_savefile:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$17,20($sp)
	lui	$17,%hi(gMemCardInfo+608) # high
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$16,16($sp)
	lw	$2,8($19)
	#nop
	andi	$2,$2,0x007f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L57
	addiu	$20,$17,%lo(gMemCardInfo+608) # low
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,572			# 0x0000023c
	.set	macro
	.set	reorder

	addu	$16,$20,4
	move	$4,$16
	addu	$5,$20,-604
	li	$2,83			# 0x00000053
	sb	$2,44($20)
	li	$2,67			# 0x00000043
	.set	noreorder
	.set	nomacro
	jal	strcpy
	sb	$2,45($20)
	.set	macro
	.set	reorder

	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	strcat
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$18,%lo(gMemCardInfo+608)($17)
	lw	$2,8($19)
	#nop
	sw	$2,32($20)
	lw	$2,16($19)
	#nop
	sw	$2,40($20)
	lw	$2,12($19)
	#nop
	sw	$2,36($20)
	lw	$2,20($19)
	#nop
	sw	$2,556($20)
	lw	$2,16($19)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L58
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$16
	move	$3,$19
$L59:
	lw	$2,24($3)
	#nop
	beq	$2,$0,$L62
	addu	$18,$18,1
$L62:
	addu	$16,$16,1
	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L59
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L76
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	addu	$2,$18,16
	sb	$2,46($20)
	lw	$3,8($19)
	#nop
	addu	$2,$3,8192
	.set	noreorder
	.set	nomacro
	bgez	$2,$L77
	sra	$2,$2,13
	.set	macro
	.set	reorder

	addu	$2,$3,16383
	sra	$2,$2,13
$L77:
	sb	$2,47($20)
	lw	$4,4($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L76
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	jal	strlen
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L76
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,4($19)
	jal	strlen
	sltu	$2,$2,33
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L68
	move	$16,$0
	.set	macro
	.set	reorder

$L57:
	.set	noreorder
	.set	nomacro
	j	$L76
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L68:
	move	$17,$20
$L69:
	lw	$2,4($19)
	#nop
	addu	$2,$2,$16
	lbu	$4,0($2)
	jal	ascii2sjis
	sh	$2,48($17)
	andi	$2,$2,0xffff
	beq	$2,$0,$L70
	addu	$16,$16,1
	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L69
	addu	$17,$17,2
	.set	macro
	.set	reorder

$L70:
	lw	$4,24($19)
	jal	getshapeclut
	addu	$4,$2,16
	addu	$5,$20,140
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	addu	$5,$20,172
	lw	$4,24($19)
	li	$6,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$4,16
	.set	macro
	.set	reorder

	slt	$2,$18,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L78
	move	$2,$0
	.set	macro
	.set	reorder

	addu	$5,$20,300
	lw	$4,28($19)
	li	$6,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$4,16
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L78
	move	$2,$0
	.set	macro
	.set	reorder

	addu	$5,$20,428
	lw	$4,32($19)
	li	$6,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$4,16
	.set	macro
	.set	reorder

$L58:
	move	$2,$0
$L78:
	lui	$3,%hi(gMemCardInfo) # high
	addiu	$3,$3,%lo(gMemCardInfo) # low
	li	$4,2			# 0x00000002
	sw	$4,48($3)
	sw	$0,52($3)
$L76:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	MCRD_savefile
	.text
	.ent	iMCRD_DoFileWrite
iMCRD_DoFileWrite:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	lui	$2,%hi(gMemCardInfo+608) # high
	sw	$16,32($sp)
	addiu	$16,$2,%lo(gMemCardInfo+608) # low
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	lw	$2,40($16)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L80
	move	$19,$4
	.set	macro
	.set	reorder

	addu	$17,$16,-608
	addu	$18,$16,4
	lw	$4,60($17)
	lbu	$6,47($16)
	.set	noreorder
	.set	nomacro
	jal	MemCardCreateFile
	move	$5,$18
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	move	$5,$2
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	sw	$5,28($sp)
	.set	macro
	.set	reorder

	bne	$2,$0,$L94
	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	move	$5,$18
	addu	$6,$16,44
	move	$7,$0
	lw	$4,60($17)
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	MemCardWriteFile
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	move	$4,$0
$L96:
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L96
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	lw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	move	$6,$19
	.set	macro
	.set	reorder

	bne	$2,$0,$L94
$L80:
	addu	$5,$16,4
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$17,$2,%lo(gMemCardInfo) # low
	lw	$4,60($17)
	lw	$6,556($16)
	lw	$7,36($16)
	lw	$2,32($16)
	addu	$7,$7,512
	.set	noreorder
	.set	nomacro
	jal	MemCardWriteFile
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L89
	sw	$2,28($sp)
	.set	macro
	.set	reorder

$L95:
	li	$2,1			# 0x00000001
	sw	$2,52($17)
	.set	noreorder
	.set	nomacro
	j	$L94
	li	$2,13			# 0x0000000d
	.set	macro
	.set	reorder

$L89:
	move	$4,$0
$L97:
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L97
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	lw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	move	$6,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L94
	lui	$3,%hi(gMemCardInfo) # high
	.set	macro
	.set	reorder

	li	$2,12			# 0x0000000c
	addiu	$3,$3,%lo(gMemCardInfo) # low
	li	$4,1			# 0x00000001
	sw	$0,52($3)
	sw	$4,48($3)
$L94:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	iMCRD_DoFileWrite
	.text
	.ent	iMCRD_DoFileDelete
iMCRD_DoFileDelete:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	li	$17,17			# 0x00000011
	lui	$5,%hi(gMemCardInfo+608) # high
	addiu	$5,$5,%lo(gMemCardInfo+608) # low
	sw	$16,16($sp)
	addu	$16,$5,-608
	sw	$31,28($sp)
	lw	$4,60($16)
	.set	noreorder
	.set	nomacro
	jal	MemCardDeleteFile
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L100
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L101
	move	$2,$17
	.set	macro
	.set	reorder

	j	$L104
$L100:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L99
	sw	$2,48($16)
	.set	macro
	.set	reorder

$L101:
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	move	$4,$18
	.set	macro
	.set	reorder

	li	$17,18			# 0x00000012
	li	$3,19			# 0x00000013
	sw	$3,4($2)
	li	$2,1			# 0x00000001
	sw	$2,52($16)
$L99:
	move	$2,$17
$L104:
	lw	$31,28($sp)
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

	.end	iMCRD_DoFileDelete
	.text
	.ent	MCRD_handlecardevents
MCRD_handlecardevents:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$16,24($sp)
	li	$16,23			# 0x00000017
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$18,32($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$18,$2
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	MemCardSync
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	move	$3,$2
	beq	$3,$0,$L162
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L108
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L110
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L161
$L108:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L161
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$5,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$3,$L114
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L135
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L161
$L114:
	lw	$3,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$5,$L126
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L116
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L131
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L132
	li	$16,23			# 0x00000017
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L161
	move	$2,$16
	.set	macro
	.set	reorder

$L116:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$4,$2,%lo(gMemCardInfo) # low
	addu	$2,$17,-1
	sll	$2,$2,2
	lw	$3,timerhz
	addu	$2,$2,$4
	sw	$5,52($4)
	sw	$3,64($2)
	lw	$3,0($18)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L107
	li	$16,22			# 0x00000016
	.set	macro
	.set	reorder

	lw	$4,60($4)
	jal	MemCardAccept
	.set	noreorder
	.set	nomacro
	j	$L161
	move	$2,$16
	.set	macro
	.set	reorder

$L126:
	lui	$4,%hi(gMemCardInfo) # high
	addiu	$4,$4,%lo(gMemCardInfo) # low
	sw	$5,52($4)
	addu	$2,$17,-1
	sll	$2,$2,$16
	lw	$3,timerhz
	addu	$2,$2,$4
	sw	$3,64($2)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L107
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L131:
	li	$16,3			# 0x00000003
	lui	$2,%hi(gMemCardInfo+52) # high
	sw	$5,%lo(gMemCardInfo+52)($2)
	li	$2,-4			# 0xfffffffc
	.set	noreorder
	.set	nomacro
	j	$L107
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L132:
	lui	$2,%hi(gMemCardInfo+60) # high
	lw	$4,%lo(gMemCardInfo+60)($2)
	.set	noreorder
	.set	nomacro
	jal	MemCardAccept
	li	$16,21			# 0x00000015
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L161
	move	$2,$16
	.set	macro
	.set	reorder

$L135:
	lw	$3,20($sp)
	#nop
	sltu	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L107
	lui	$2,%hi($L142) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L142) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L142:
	.word	$L138
	.word	$L139
	.word	$L140
	.word	$L138
	.word	$L141
	.text
$L138:
	li	$16,4			# 0x00000004
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$2,$2,%lo(gMemCardInfo) # low
	li	$3,1			# 0x00000001
	sw	$17,608($2)
	.set	noreorder
	.set	nomacro
	j	$L107
	sw	$3,48($2)
	.set	macro
	.set	reorder

$L139:
	.set	noreorder
	.set	nomacro
	jal	iMCRD_InitCard
	move	$4,$17
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sw	$2,0($18)
	.set	noreorder
	.set	nomacro
	j	$L107
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

$L140:
	.set	noreorder
	.set	nomacro
	jal	iMCRD_InitCard
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L107
	li	$16,3			# 0x00000003
	.set	macro
	.set	reorder

$L141:
	li	$2,-2			# 0xfffffffe
	sw	$2,0($18)
	.set	noreorder
	.set	nomacro
	j	$L107
	li	$16,5			# 0x00000005
	.set	macro
	.set	reorder

$L110:
	lui	$2,%hi(gMemCardInfo+48) # high
	lw	$3,%lo(gMemCardInfo+48)($2)
	#nop
	sltu	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L107
	lui	$2,%hi($L159) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L159) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L159:
	.word	$L147
	.word	$L151
	.word	$L153
	.word	$L155
	.word	$L157
	.text
$L147:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
	addu	$2,$17,-1
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L148
	li	$16,22			# 0x00000016
	.set	macro
	.set	reorder

	lw	$4,60($3)
	li	$16,23			# 0x00000017
	.set	noreorder
	.set	nomacro
	jal	MemCardExist
	sw	$0,52($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L161
	move	$2,$16
	.set	macro
	.set	reorder

$L162:
	.set	noreorder
	.set	nomacro
	j	$L107
	li	$16,21			# 0x00000015
	.set	macro
	.set	reorder

$L148:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L161
	move	$2,$16
	.set	macro
	.set	reorder

$L151:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
	lw	$2,608($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L161
	move	$2,$16
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$0,4($18)
	sw	$0,52($3)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_LoadCard
	sw	$0,48($3)
	.set	macro
	.set	reorder

	j	$L161
$L153:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
	lw	$2,608($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L161
	move	$2,$16
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$0,4($18)
	sw	$0,52($3)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_DoFileWrite
	sw	$0,48($3)
	.set	macro
	.set	reorder

	j	$L161
$L155:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
	lw	$2,608($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L161
	move	$2,$16
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$0,4($18)
	sw	$0,52($3)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_DoFileLoad
	sw	$0,48($3)
	.set	macro
	.set	reorder

	j	$L161
$L157:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
	lw	$2,608($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L161
	move	$2,$16
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$0,4($18)
	sw	$0,52($3)
	.set	noreorder
	.set	nomacro
	jal	iMCRD_DoFileDelete
	sw	$0,48($3)
	.set	macro
	.set	reorder

	j	$L161
$L107:
	move	$2,$16
$L161:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	MCRD_handlecardevents
	.text
	.ent	MCRD_fileexists
MCRD_fileexists:
	.frame	$sp,56,$31		# vars= 24, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,40($sp)
	move	$16,$5
	sw	$31,48($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$17,44($sp)
	.set	macro
	.set	reorder

	addu	$17,$2,16
	addu	$4,$sp,16
	lui	$5,%hi(gMemCardInfo+4) # high
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addiu	$5,$5,%lo(gMemCardInfo+4) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	strcat
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$0
$L164:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L167
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L164
	addu	$17,$17,40
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L167:
	lw	$31,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	MCRD_fileexists
	.text
	.ent	iMCRD_timersub
iMCRD_timersub:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$3,$2,%lo(gMemCardInfo) # low
$L171:
	lw	$2,64($3)
	addu	$4,$4,1
	addu	$2,$2,-1
	sw	$2,64($3)
	slt	$2,$4,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L171
	addu	$3,$3,4
	.set	macro
	.set	reorder

	j	$31
	.end	iMCRD_timersub
	.text
	.ent	garyMemCardGrabBlocks
garyMemCardGrabBlocks:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$5
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(gMemCardInfo+60) # high
	addu	$16,$2,16
	lw	$4,%lo(gMemCardInfo+60)($3)
	li	$3,15			# 0x0000000f
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	move	$6,$16
	addu	$7,$2,8
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MemCardGetDirentry
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$17,$L176
	move	$3,$0
	.set	macro
	.set	reorder

$L177:
	addu	$3,$3,1
	slt	$2,$3,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L177
	addu	$16,$16,40
	.set	macro
	.set	reorder

$L176:
	lw	$2,24($16)
	#nop
	bgez	$2,$L181
	addu	$2,$2,8191
$L181:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	sra	$2,$2,13
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	garyMemCardGrabBlocks
	.text
	.ent	iMCRD_LoadCard
iMCRD_LoadCard:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	sw	$31,36($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	addu	$16,$17,16
	.set	noreorder
	.set	nomacro
	jal	iMCRD_InitCard
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L184
	li	$2,11			# 0x0000000b
	.set	macro
	.set	reorder

	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$2,%hi(gMemCardInfo+60) # high
	move	$6,$16
	lw	$4,%lo(gMemCardInfo+60)($2)
	li	$2,15			# 0x0000000f
	addu	$7,$17,8
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MemCardGetDirentry
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	iMCRD_HandleError
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L184
	move	$4,$0
	.set	macro
	.set	reorder

$L186:
	lbu	$2,0($16)
	#nop
	beq	$2,$0,$L189
	lw	$3,24($16)
	#nop
	bgez	$3,$L190
	addu	$3,$3,8191
$L190:
	lw	$2,12($17)
	sra	$3,$3,13
	subu	$2,$2,$3
	sw	$2,12($17)
$L189:
	addu	$4,$4,1
	slt	$2,$4,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L186
	addu	$16,$16,40
	.set	macro
	.set	reorder

	lw	$2,12($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L192
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L193
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L192:
	sw	$0,0($17)
$L193:
	lui	$3,%hi(gMemCardInfo+52) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(gMemCardInfo+52)($3)
	li	$2,9			# 0x00000009
$L184:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	iMCRD_LoadCard
	.text
	.ent	iMCRD_FormatCard
iMCRD_FormatCard:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(gMemCardInfo+60) # high
	lw	$4,%lo(gMemCardInfo+60)($3)
	.set	noreorder
	.set	nomacro
	jal	MemCardFormat
	move	$16,$2
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L197
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L203
	move	$2,$17
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L198
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L204
	li	$3,15			# 0x0000000f
	.set	macro
	.set	reorder

$L197:
	.set	noreorder
	.set	nomacro
	j	$L202
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L198:
	li	$2,-4			# 0xfffffffc
$L202:
	sw	$2,0($16)
	li	$17,-1			# 0xffffffff
	move	$2,$17
$L203:
	li	$3,15			# 0x0000000f
$L204:
	sw	$0,0($16)
	sw	$3,12($16)
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

	.end	iMCRD_FormatCard
	.text
	.ent	iMCRD_HandleError
iMCRD_HandleError:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$0
	move	$4,$19
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L206
	move	$17,$2
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L209
	slt	$2,$16,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L213
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L208
	sltu	$2,$18,8
	.set	macro
	.set	reorder

	j	$L248
$L213:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L210
	sltu	$2,$18,8
	.set	macro
	.set	reorder

	j	$L248
$L208:
	.set	noreorder
	.set	nomacro
	j	$L206
	li	$20,10			# 0x0000000a
	.set	macro
	.set	reorder

$L209:
	.set	noreorder
	.set	nomacro
	j	$L206
	li	$20,13			# 0x0000000d
	.set	macro
	.set	reorder

$L210:
	li	$20,16			# 0x00000010
$L206:
	sltu	$2,$18,8
$L248:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L241
	lui	$2,%hi($L242) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L242) # low
	sll	$3,$18,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L242:
	.word	$L216
	.word	$L217
	.word	$L218
	.word	$L219
	.word	$L223
	.word	$L237
	.word	$L238
	.word	$L240
	.text
$L217:
	li	$2,-1			# 0xffffffff
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L218:
	li	$2,-4			# 0xfffffffc
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L219:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$16,$2,%lo(gMemCardInfo) # low
	lw	$4,60($16)
	jal	MemCardAccept
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L220
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L221
	li	$2,23			# 0x00000017
	.set	macro
	.set	reorder

$L220:
	sw	$2,48($16)
	.set	noreorder
	.set	nomacro
	j	$L216
	sw	$0,52($16)
	.set	macro
	.set	reorder

$L223:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L249
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lui	$2,%hi(gMemCardInfo+32) # high
	lw	$2,%lo(gMemCardInfo+32)($2)
	#nop
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L224
	move	$16,$0
	.set	macro
	.set	reorder

	li	$18,-1			# 0xffffffff
$L226:
	.set	noreorder
	.set	nomacro
	jal	iMCRD_FormatCard
	move	$4,$19
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L234
	addu	$16,$16,1
	.set	macro
	.set	reorder

	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L226
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	beq	$3,$2,$L236
$L234:
	lui	$3,%hi(gMemCardInfo+48) # high
	li	$2,2			# 0x00000002
	sw	$2,%lo(gMemCardInfo+48)($3)
	.set	noreorder
	.set	nomacro
	j	$L247
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

$L236:
	li	$2,-2			# 0xfffffffe
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

$L224:
	li	$2,-2			# 0xfffffffe
$L249:
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

$L237:
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,19			# 0x00000013
	.set	macro
	.set	reorder

$L238:
	lui	$2,%hi(gMemCardInfo) # high
	addiu	$16,$2,%lo(gMemCardInfo) # low
	lw	$2,36($16)
	#nop
	jal	$31,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L239
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lw	$4,60($16)
	.set	noreorder
	.set	nomacro
	jal	MemCardDeleteFile
	addu	$5,$16,612
	.set	macro
	.set	reorder

	li	$2,21			# 0x00000015
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L247
	sw	$3,48($16)
	.set	macro
	.set	reorder

$L239:
$L221:
	sw	$2,4($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L216
	sw	$2,52($16)
	.set	macro
	.set	reorder

$L240:
	.set	noreorder
	.set	nomacro
	j	$L214
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

$L241:
	li	$2,23			# 0x00000017
$L214:
	lui	$3,%hi(gMemCardInfo+52) # high
	sw	$2,4($17)
	li	$2,1			# 0x00000001
	sw	$2,%lo(gMemCardInfo+52)($3)
$L216:
	move	$2,$20
$L247:
	lw	$31,36($sp)
	lw	$20,32($sp)
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

	.end	iMCRD_HandleError
	.text
	.ent	iMCRD_DefaultCBProc1
iMCRD_DefaultCBProc1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	iMCRD_DefaultCBProc1
	.text
	.ent	ascii2sjis
ascii2sjis:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	move	$5,$3
	addu	$2,$4,-32
	andi	$2,$2,0x00ff
	sltu	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L252
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L253
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L252:
	addu	$2,$4,-48
	andi	$2,$2,0x00ff
	sltu	$2,$2,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L253
	addu	$2,$4,-58
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sltu	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L255
	addu	$2,$4,-65
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L253
	li	$5,11			# 0x0000000b
	.set	macro
	.set	reorder

$L255:
	andi	$2,$2,0x00ff
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L257
	addu	$2,$4,-91
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L253
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L257:
	andi	$2,$2,0x00ff
	sltu	$2,$2,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L259
	addu	$2,$4,-97
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L253
	li	$5,37			# 0x00000025
	.set	macro
	.set	reorder

$L259:
	andi	$2,$2,0x00ff
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L261
	addu	$2,$4,-123
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L253
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

$L261:
	andi	$2,$2,0x00ff
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L263
	li	$5,63			# 0x0000003f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L263:
$L253:
	andi	$4,$5,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L265
	addu	$4,$4,31
	.set	macro
	.set	reorder

	lui	$2,%hi(ascii_k_table) # high
	addiu	$2,$2,%lo(ascii_k_table) # low
	andi	$3,$6,0x00ff
	subu	$3,$3,$4
	sll	$3,$3,1
	addu	$3,$3,$2
	lhu	$3,0($3)
	.set	noreorder
	.set	nomacro
	j	$L268
	sll	$2,$3,8
	.set	macro
	.set	reorder

$L265:
	lui	$2,%hi(ascii_table) # high
	addiu	$2,$2,%lo(ascii_table) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	andi	$4,$6,0x00ff
	lhu	$2,0($3)
	lhu	$3,2($3)
	addu	$2,$2,$4
	subu	$3,$2,$3
	sll	$2,$3,8
$L268:
	andi	$3,$3,0xffff
	srl	$3,$3,8
	or	$2,$2,$3
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$31
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.end	ascii2sjis
	.text
	.ent	sjis2ascii
sjis2ascii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	sll	$2,$4,16
	sra	$3,$2,24
	andi	$4,$4,0x00ff
	li	$2,129			# 0x00000081
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L270
	move	$6,$3
	.set	macro
	.set	reorder

	lui	$3,%hi(sjis_k_table) # high
	addiu	$3,$3,%lo(sjis_k_table) # low
	andi	$2,$6,0x00ff
	addu	$2,$2,$3
	lbu	$2,-64($2)
	j	$31
$L270:
	li	$2,130			# 0x00000082
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L271
	addu	$2,$3,-79
	.set	macro
	.set	reorder

	sltu	$2,$2,10
	bne	$2,$0,$L272
	addu	$2,$3,-96
	sltu	$2,$2,26
	beq	$2,$0,$L273
	.set	noreorder
	.set	nomacro
	j	$L272
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L273:
	addu	$2,$3,127
	andi	$2,$2,0x00ff
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L277
	lui	$3,%hi(sjis_table) # high
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
$L272:
	lui	$3,%hi(sjis_table) # high
$L277:
	addiu	$3,$3,%lo(sjis_table) # low
	sll	$2,$5,1
	addu	$2,$2,$3
	lbu	$3,0($2)
	lbu	$2,1($2)
	subu	$3,$6,$3
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x00ff
	.set	macro
	.set	reorder

$L271:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	sjis2ascii
