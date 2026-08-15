	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\spchpsxz\\spchevnt.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	gPreLoadTicks
	.globl	gEventDats
	.globl	gVoxInGame
	.globl	gRepeatCount
	.globl	gVoxEvents
	.globl	DAT_80148064
	.section	.bss
	.align	2
gPreLoadTicks:
	.space	4
gEventDats:
	.space	16
gVoxInGame:
	.space	4
gRepeatCount:
	.space	4
gVoxEvents:
	.space	4
DAT_80148064:
	.space	964
	.text
	.text
 #NO_APP
	.align	2
	.align	2
	.align	2
	.globl	VoxEvent_GetKeepTillExpiresFlag
	.align	2
	.globl	iSPCH_SearchEventDat
	.align	2
	.globl	iSPCH_FindEvent
	.align	2
	.globl	iSPCH_InitEventDat
	.align	2
	.globl	GetFilterLength
	.align	2
	.globl	GetFilterPriority
	.align	2
	.globl	iSPCH_InitEventQueue
	.align	2
	.globl	iSPCH_FindEventSlot
	.align	2
	.globl	SPCH_AddEvent
	.align	2
	.globl	iSPCH_ChooseEvent
	.align	2
	.globl	SPCH_ClearEventQueue
	.align	2
	.globl	iSPCH_ClearOldEvents
	.align	2
	.globl	SPCH_PlaySpeech
	.align	2
	.globl	SPCH_ChooseSpeech

	.extern	gPreLoadTicks, 4

	.text
	.def	.0fake;	.scl	10;	.type	0x8;	.size	60;	.endef
	.def	_ovl0;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	_ovl4;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	enabled;	.val	8;	.scl	8;	.type	0xd;	.endef
	.def	subTick;	.val	10;	.scl	8;	.type	0xd;	.endef
	.def	tick;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	event;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	args;	.val	20;	.scl	8;	.dim	10;	.size	40;	.type	0x34;	.endef
	.def	.eos;	.val	60;	.scl	102;	.tag	.0fake;	.size	60;	.endef
	.def	VoxSlot;	.scl	13;	.tag	.0fake;	.size	60;	.type	0x8;	.endef
	.def	VoxEvent_GetFilterLengthFlag;	.val	VoxEvent_GetFilterLengthFlag;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	VoxEvent_GetFilterLengthFlag
VoxEvent_GetFilterLengthFlag:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	e;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,10($4)
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	VoxEvent_GetFilterLengthFlag
	.def	iSPCH_GetOffset16;	.val	iSPCH_GetOffset16;	.scl	3;	.type	0x24;	.endef
	.text
	.ent	iSPCH_GetOffset16
iSPCH_GetOffset16:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	base;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	tableBase;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	index;	.val	6;	.scl	17;	.type	0x4;	.endef
	sll	$6,$6,1
	addu	$6,$6,$5
	lhu	$2,0($6)
	#nop
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$4,$2
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSPCH_GetOffset16
	.def	VoxEvent_GetKeepTillExpiresFlag;	.val	VoxEvent_GetKeepTillExpiresFlag;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	VoxEvent_GetKeepTillExpiresFlag
VoxEvent_GetKeepTillExpiresFlag:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	e;	.val	4;	.scl	17;	.type	0x4;	.endef
	lbu	$2,10($4)
	#nop
	srl	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	VoxEvent_GetKeepTillExpiresFlag
	.def	iSPCH_SearchEventDat;	.val	iSPCH_SearchEventDat;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_SearchEventDat
iSPCH_SearchEventDat:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	dat;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	eventID;	.val	19;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lhu	$17,2($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L6
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$18
$L13:
	addu	$5,$18,12
	.set	noreorder
	.set	nomacro
	jal	iSPCH_GetOffset16
	move	$6,$16
	.set	macro
	.set	reorder

	move	$3,$2
	lhu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L9
	addu	$16,$16,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	move	$2,$3
	.set	macro
	.set	reorder

$L9:
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	move	$4,$18
	.set	macro
	.set	reorder

$L6:
	move	$2,$0
$L12:
	lw	$31,32($sp)
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


	.loc	1 0
LM4:
	.end	iSPCH_SearchEventDat
	.def	iSPCH_FindEvent;	.val	iSPCH_FindEvent;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_FindEvent
iSPCH_FindEvent:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	eventID;	.val	18;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(gEventDats) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gEventDats) # low
	sw	$31,28($sp)
$L15:
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L17
	.set	noreorder
	.set	nomacro
	jal	iSPCH_SearchEventDat
	move	$5,$18
	.set	macro
	.set	reorder

	bne	$2,$0,$L19
$L17:
	addu	$17,$17,1
	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$2,$0
$L19:
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


	.loc	1 0
LM5:
	.end	iSPCH_FindEvent
	.def	iSPCH_InitEventDat;	.val	iSPCH_InitEventDat;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_InitEventDat
iSPCH_InitEventDat:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,3			# 0x00000003
	lui	$2,%hi(gEventDats) # high
	addiu	$2,$2,%lo(gEventDats) # low
	addu	$2,$2,12
$L21:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L21
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM6:
	.end	iSPCH_InitEventDat
	.def	GetFilterLength;	.val	GetFilterLength;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	GetFilterLength
GetFilterLength:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gEventDats) # high
	lw	$2,%lo(gEventDats)($2)
	#nop
	lw	$2,4($2)
	j	$31

	.loc	1 0
LM7:
	.end	GetFilterLength
	.def	GetFilterPriority;	.val	GetFilterPriority;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	GetFilterPriority
GetFilterPriority:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gEventDats) # high
	lw	$2,%lo(gEventDats)($2)
	#nop
	lw	$2,8($2)
	j	$31

	.loc	1 0
LM8:
	.end	GetFilterPriority
	.def	iSPCH_InitEventQueue;	.val	iSPCH_InitEventQueue;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_InitEventQueue
iSPCH_InitEventQueue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	lui	$3,%hi(gVoxEvents) # high
	addiu	$2,$3,%lo(gVoxEvents) # low
	move	$7,$2
 #APP
 #NO_APP
	move	$4,$7
 #APP
 #NO_APP
	addu	$8,$4,960
	sw	$0,%lo(gVoxEvents)($3)
	sw	$0,4($7)
$L28:
	move	$5,$0
	move	$3,$6
	#.set	volatile
	sh	$0,8($4)
	#.set	novolatile
	#.set	volatile
	sh	$0,10($4)
	#.set	novolatile
	#.set	volatile
	sw	$0,12($4)
	#.set	novolatile
	#.set	volatile
	sw	$0,16($4)
	#.set	novolatile
	.def	inner;	.val	$L31;	.scl	6;	.type	0x0;	.endef
$L31:
	addu	$2,$3,$7
	sw	$0,20($2)
	addu	$5,$5,1
	slt	$2,$5,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	addu	$3,$3,4
	.set	macro
	.set	reorder

	addu	$4,$4,60
	slt	$2,$4,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	addu	$6,$6,60
	.set	macro
	.set	reorder

	lui	$2,%hi(gLastTick) # high
	sw	$0,%lo(gLastTick)($2)
	lui	$2,%hi(gLastSubTick) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,%lo(gLastSubTick)($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSPCH_InitEventQueue
	.def	iSPCH_FindEventSlot;	.val	iSPCH_FindEventSlot;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_FindEventSlot
iSPCH_FindEventSlot:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	priority;	.val	17;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	lui	$4,%hi(gVoxEvents) # high
	lw	$2,%lo(gVoxEvents)($4)
	sw	$16,16($sp)
	li	$16,-1			# 0xffffffff
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	move	$3,$0
	addiu	$4,$4,%lo(gVoxEvents) # low
$L36:
	lhu	$2,8($4)
	#nop
	bne	$2,$0,$L39
	.set	noreorder
	.set	nomacro
	j	$L40
	move	$16,$3
	.set	macro
	.set	reorder

$L39:
	addu	$3,$3,1
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	addu	$4,$4,60
	.set	macro
	.set	reorder

$L35:
	jal	gettick
	move	$7,$2
	move	$3,$0
	lui	$6,%hi(gVoxEvents) # high
	addiu	$4,$6,%lo(gVoxEvents) # low
$L42:
	lw	$2,16($4)
	#nop
	lhu	$5,2($2)
	#nop
	beq	$5,$0,$L45
	lw	$2,12($4)
	#nop
	subu	$2,$7,$2
	sltu	$2,$5,$2
	beq	$2,$0,$L45
	sh	$0,8($4)
	lw	$2,%lo(gVoxEvents)($6)
	move	$16,$3
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L40
	sw	$2,%lo(gVoxEvents)($6)
	.set	macro
	.set	reorder

$L45:
	addu	$3,$3,1
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	addu	$4,$4,60
	.set	macro
	.set	reorder

	move	$3,$0
	lui	$5,%hi(gVoxEvents) # high
	addiu	$4,$5,%lo(gVoxEvents) # low
$L47:
	lw	$2,16($4)
	#nop
	lhu	$2,4($2)
	#nop
	sltu	$2,$17,$2
	bne	$2,$0,$L50
	sh	$0,8($4)
	lw	$2,%lo(gVoxEvents)($5)
	move	$16,$3
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L40
	sw	$2,%lo(gVoxEvents)($5)
	.set	macro
	.set	reorder

$L50:
	addu	$3,$3,1
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L47
	addu	$4,$4,60
	.set	macro
	.set	reorder

	.def	done;	.val	$L40;	.scl	6;	.type	0x0;	.endef
$L40:
	move	$2,$16
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
LM10:
	.end	iSPCH_FindEventSlot
	.def	SPCH_AddEvent;	.val	SPCH_AddEvent;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_AddEvent
SPCH_AddEvent:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	table;	.val	18;	.scl	17;	.type	0x1e;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$4,0($18)
	jal	iSPCH_FindEvent
	move	$17,$2
	beq	$17,$0,$Lfaddr5_53
	lb	$16,9($17)
	.set	noreorder
	.set	nomacro
	jal	iSPCH_Rand
	li	$4,100			# 0x00000064
	.set	macro
	.set	reorder

	slt	$16,$16,$2
	bne	$16,$0,$Lfaddr5_53
	lhu	$4,4($17)
	jal	iSPCH_FindEventSlot
	move	$16,$2
	bltz	$16,$Lfaddr5_53
	jal	gettick
	lui	$3,%hi(gLastTick) # high
	lw	$3,%lo(gLastTick)($3)
	move	$7,$2
	.set	noreorder
	.set	nomacro
	bne	$7,$3,$Lfaddr5_56
	lui	$2,%hi(gLastSubTick) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(gLastSubTick) # high
	lhu	$2,%lo(gLastSubTick)($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$Lfaddr5_57
	sh	$2,%lo(gLastSubTick)($3)
	.set	macro
	.set	reorder

$Lfaddr5_56:
	sh	$0,%lo(gLastSubTick)($2)
$Lfaddr5_57:
	move	$6,$0
	lui	$2,%hi(gVoxEvents) # high
	addiu	$2,$2,%lo(gVoxEvents) # low
	move	$8,$2
 #APP
 #NO_APP
	move	$4,$18
	sll	$2,$16,4
	subu	$2,$2,$16
	sll	$2,$2,2
	move	$5,$2
 #APP
 #NO_APP
	lui	$2,%hi(gLastTick) # high
	sw	$7,%lo(gLastTick)($2)
	lui	$2,%hi(gLastSubTick) # high
	lhu	$3,%lo(gLastSubTick)($2)
	addu	$2,$5,$8
	sw	$17,16($2)
	sw	$7,12($2)
	sh	$3,10($2)
$Lfaddr5_58:
	lw	$3,0($4)
	addu	$4,$4,4
	addu	$2,$5,$8
	addu	$6,$6,1
	sw	$3,20($2)
	slt	$2,$6,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lfaddr5_58
	addu	$5,$5,4
	.set	macro
	.set	reorder

	lui	$3,%hi(gVoxEvents) # high
	lw	$2,%lo(gVoxEvents)($3)
	#nop
	addu	$2,$2,1
	sw	$2,%lo(gVoxEvents)($3)
	addiu	$3,$3,%lo(gVoxEvents) # low
	sll	$2,$16,4
	subu	$2,$2,$16
	sll	$2,$2,2
	addu	$2,$2,$3
	li	$3,1			# 0x00000001
	sh	$3,8($2)
$Lfaddr5_53:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM11:
	.end	SPCH_AddEvent
	.def	iSPCH_ChooseEvent;	.val	iSPCH_ChooseEvent;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSPCH_ChooseEvent
iSPCH_ChooseEvent:
	.frame	$sp,72,$31		# vars= 16, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$20,48($sp)
	li	$20,-1			# 0xffffffff
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	jal	gettick
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$fp,$20
	move	$23,$0
	lui	$5,%hi(gVoxEvents) # high
	lw	$3,gPreLoadTicks
	addiu	$19,$5,%lo(gVoxEvents) # low
	sw	$0,20($sp)
	sh	$0,24($sp)
	addu	$2,$2,$3
	sw	$2,16($sp)
$L66:
	lhu	$2,8($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L65
	move	$21,$0
	.set	macro
	.set	reorder

	move	$22,$21
	lw	$17,16($19)
	lw	$2,12($19)
	lw	$5,16($sp)
	lhu	$3,2($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L68
	subu	$18,$5,$2
	.set	macro
	.set	reorder

	move	$2,$3
	sltu	$21,$2,$18
$L68:
	lui	$2,%hi(gFilterSetting) # high
	lw	$3,%lo(gFilterSetting)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L69
	.set	noreorder
	.set	nomacro
	jal	VoxEvent_GetFilterLengthFlag
	move	$4,$17
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	beq	$2,$0,$L69
	lhu	$16,4($17)
	jal	GetFilterPriority
	slt	$16,$16,$2
	beq	$16,$0,$L69
	li	$22,1			# 0x00000001
$L69:
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L82
	lui	$5,%hi(gVoxEvents) # high
	.set	macro
	.set	reorder

	beq	$22,$0,$L72
$L82:
	sh	$0,8($19)
	lw	$2,%lo(gVoxEvents)($5)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L65
	sw	$2,%lo(gVoxEvents)($5)
	.set	macro
	.set	reorder

$L72:
	lhu	$4,4($17)
	lw	$5,20($sp)
	#nop
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L83
	sll	$2,$23,4
	.set	macro
	.set	reorder

	move	$20,$23
	subu	$2,$2,$20
	sll	$2,$2,2
	lui	$5,%hi(gVoxEvents) # high
	addiu	$5,$5,%lo(gVoxEvents) # low
	addu	$2,$2,$5
	lhu	$2,10($2)
	move	$fp,$18
	.set	noreorder
	.set	nomacro
	j	$L81
	sw	$4,20($sp)
	.set	macro
	.set	reorder

$L83:
	.set	noreorder
	.set	nomacro
	bne	$4,$5,$L65
	sltu	$2,$18,$fp
	.set	macro
	.set	reorder

	bne	$2,$0,$L79
	bne	$18,$fp,$L65
	lhu	$2,10($19)
	lhu	$5,24($sp)
	#nop
	sltu	$2,$5,$2
	beq	$2,$0,$L65
$L79:
	move	$20,$23
	move	$fp,$18
	sll	$2,$20,4
	subu	$2,$2,$20
	sll	$2,$2,2
	lui	$5,%hi(gVoxEvents) # high
	addiu	$5,$5,%lo(gVoxEvents) # low
	addu	$2,$2,$5
	lhu	$2,10($2)
$L81:
	sh	$2,24($sp)
$L65:
	addu	$23,$23,1
	slt	$2,$23,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L66
	addu	$19,$19,60
	.set	macro
	.set	reorder

	move	$2,$20
	lw	$31,68($sp)
	lw	$fp,64($sp)
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


	.loc	1 0
LM12:
	.end	iSPCH_ChooseEvent
	.def	SPCH_ClearEventQueue;	.val	SPCH_ClearEventQueue;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SPCH_ClearEventQueue
SPCH_ClearEventQueue:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$4,$0
	lui	$5,%hi(gVoxEvents) # high
	addiu	$3,$5,%lo(gVoxEvents) # low
$L85:
	lhu	$2,8($3)
	#nop
	beq	$2,$0,$L88
	sh	$0,8($3)
	lw	$2,%lo(gVoxEvents)($5)
	#nop
	addu	$2,$2,-1
	sw	$2,%lo(gVoxEvents)($5)
$L88:
	addu	$4,$4,1
	slt	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L85
	addu	$3,$3,60
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM13:
	.end	SPCH_ClearEventQueue
	.def	iSPCH_ClearOldEvents;	.val	iSPCH_ClearOldEvents;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSPCH_ClearOldEvents
iSPCH_ClearOldEvents:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	winnerSlot;	.val	21;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(gVoxEvents) # high
	sw	$19,28($sp)
	move	$19,$2
	addiu	$3,$19,%lo(gVoxEvents) # low
	sll	$2,$21,4
	subu	$2,$2,$21
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$20,32($sp)
	move	$20,$3
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$18,12($2)
	lhu	$22,10($2)
	move	$16,$20
	sw	$0,4($20)
$L92:
	beq	$17,$21,$L96
	lhu	$2,8($16)
	#nop
	beq	$2,$0,$L96
	lw	$3,12($16)
	lhu	$4,10($16)
	sltu	$2,$3,$18
	bne	$2,$0,$L99
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L101
	sltu	$2,$4,$22
	.set	macro
	.set	reorder

	beq	$2,$0,$L101
	.def	disable;	.val	$L99;	.scl	6;	.type	0x0;	.endef
$L99:
	lw	$4,16($16)
	jal	VoxEvent_GetKeepTillExpiresFlag
	andi	$2,$2,0x00ff
	bne	$2,$0,$L96
	sh	$0,8($16)
	lw	$2,%lo(gVoxEvents)($19)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L96
	sw	$2,%lo(gVoxEvents)($19)
	.set	macro
	.set	reorder

	.def	dcheck;	.val	$L101;	.scl	6;	.type	0x0;	.endef
$L101:
	lw	$2,16($16)
	#nop
	lb	$3,9($2)
	li	$2,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L96
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,4($20)
	.def	cont;	.val	$L96;	.scl	6;	.type	0x0;	.endef
$L96:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	addu	$16,$16,60
	.set	macro
	.set	reorder

	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM14:
	.end	iSPCH_ClearOldEvents
	.def	SPCH_PlaySpeech;	.val	SPCH_PlaySpeech;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SPCH_PlaySpeech
SPCH_PlaySpeech:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	iSPCH_OneChosen
	bne	$2,$0,$L109
	jal	SPCH_ChooseSpeech
	beq	$2,$0,$L106
$L109:
	jal	iSPCH_PlayChosen
$L106:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM15:
	.end	SPCH_PlaySpeech
	.def	SPCH_ChooseSpeech;	.val	SPCH_ChooseSpeech;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SPCH_ChooseSpeech
SPCH_ChooseSpeech:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(gVoxEvents) # high
	lw	$3,%lo(gVoxEvents)($2)
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$0
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gVoxEvents) # low
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L111
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	jal	iSPCH_ChooseEvent
	move	$20,$2
	.set	noreorder
	.set	nomacro
	bltz	$20,$L122
	move	$2,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSPCH_ClearOldEvents
	move	$4,$20
	.set	macro
	.set	reorder

	sll	$2,$20,4
	subu	$2,$2,$20
	sll	$2,$2,2
	addu	$3,$16,20
	addu	$19,$2,$3
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ChooseSentence
	move	$4,$19
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L113
	lui	$3,%hi(gReparm) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gReparm)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L113
	move	$17,$0
	.set	macro
	.set	reorder

	move	$21,$3
$L115:
	move	$4,$17
	lw	$2,%lo(gReparm)($21)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$5,$19
	.set	macro
	.set	reorder

	move	$16,$2
	bltz	$16,$L118
	.set	noreorder
	.set	nomacro
	jal	iSPCH_ChooseSentence
	move	$4,$19
	.set	macro
	.set	reorder

	move	$18,$2
$L118:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L113
	addu	$17,$17,1
	.set	macro
	.set	reorder

	bgtz	$16,$L115
$L113:
	.set	noreorder
	.set	nomacro
	bgez	$18,$L123
	lui	$3,%hi(gVoxEvents) # high
	.set	macro
	.set	reorder

	move	$18,$0
$L123:
	lw	$2,%lo(gVoxEvents)($3)
	#nop
	addu	$2,$2,-1
	sw	$2,%lo(gVoxEvents)($3)
	addiu	$3,$3,%lo(gVoxEvents) # low
	sll	$2,$20,4
	subu	$2,$2,$20
	sll	$2,$2,2
	addu	$2,$2,$3
	sh	$0,8($2)
$L111:
	move	$2,$18
$L122:
	lw	$31,40($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM16:
	.end	SPCH_ChooseSpeech
