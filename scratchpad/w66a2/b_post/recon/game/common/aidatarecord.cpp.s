	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aidatarecord.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	.align	2
	.globl	_._14AIDataRecord_t
	.align	2
	.globl	AddRecordToCollection__14AIDataRecord_t
	.align	2
	.globl	RemoveRecordFromCollection__14AIDataRecord_t
	.align	2
	.globl	StartUp1__14AIDataRecord_t
	.align	2
	.globl	StartUp2__14AIDataRecord_t
	.align	2
	.globl	CleanUp1__14AIDataRecord_t
	.align	2
	.globl	CleanUp2__14AIDataRecord_t
	.align	2
	.globl	Setup__14AIDataRecord_t
	.align	2
	.globl	Load__14AIDataRecord_t
	.align	2
	.globl	SaveAndPurge__14AIDataRecord_t
	.align	2
	.globl	__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
	.align	2
	.globl	Get__23AIDataRecord_AccTable_ti
	.align	2
	.globl	Setup__23AIDataRecord_AccTable_t
	.align	2
	.globl	__23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
	.align	2
	.globl	__25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
	.align	2
	.globl	Get__25AIDataRecord_TrackCurve_ti
	.align	2
	.globl	__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
	.align	2
	.globl	Get__30AIDataRecord_CurveSpeedTable_ti
	.align	2
	.globl	Upgrade__30AIDataRecord_CurveSpeedTable_ti
	.align	2
	.globl	Get__26AIDataRecord_CarTracking_ti
	.align	2
	.globl	_._26AIDataRecord_CarTracking_t
	.align	2
	.globl	_._30AIDataRecord_CurveSpeedTable_t
	.align	2
	.globl	_._25AIDataRecord_TrackCurve_t
	.align	2
	.globl	_._23AIDataRecord_BestLine_t
	.align	2
	.globl	_._23AIDataRecord_AccTable_t
	.globl	AIDataRecord_BestLine
	.sdata
	.align	2
AIDataRecord_BestLine:
	.space	4
	.globl	AIDataRecord_TrackCurve
	.align	2
AIDataRecord_TrackCurve:
	.space	4
	.globl	AIDataRecord_WhichRecord
	.align	2
AIDataRecord_WhichRecord:
	.space	4
	.globl	AIDataRecord_RecordMethod
	.align	2
AIDataRecord_RecordMethod:
	.space	4
	.globl	recordCollection
	.data
	.align	2
recordCollection:
	.space	96

	.extern	gNumSlices, 4
	.extern	Cars_gHumanRaceCarList, 36

	.text
	.text
	.ent	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	lui	$2,%hi(AIDataRecord_t_vtable) # high
	addiu	$2,$2,%lo(AIDataRecord_t_vtable) # low
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AddRecordToCollection__14AIDataRecord_t
	sw	$2,84($16)
	.set	macro
	.set	reorder

	move	$2,$16
	sw	$17,76($2)
	sw	$0,80($2)
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

	.end	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	.text
	.ent	_._14AIDataRecord_t
_._14AIDataRecord_t:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	lui	$2,%hi(AIDataRecord_t_vtable) # high
	addiu	$2,$2,%lo(AIDataRecord_t_vtable) # low
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SaveAndPurge__14AIDataRecord_t
	sw	$2,84($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	RemoveRecordFromCollection__14AIDataRecord_t
	move	$4,$17
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	beq	$16,$0,$L605
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L605:
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

	.end	_._14AIDataRecord_t
	.text
	.ent	AddRecordToCollection__14AIDataRecord_t
AddRecordToCollection__14AIDataRecord_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	lui	$2,%hi(recordCollection) # high
	addiu	$3,$2,%lo(recordCollection) # low
$L607:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	addu	$5,$5,1
	.set	macro
	.set	reorder

	sw	$4,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L610:
	slt	$2,$5,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L607
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	AddRecordToCollection__14AIDataRecord_t
	.text
	.ent	RemoveRecordFromCollection__14AIDataRecord_t
RemoveRecordFromCollection__14AIDataRecord_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	lui	$2,%hi(recordCollection) # high
	addiu	$3,$2,%lo(recordCollection) # low
$L614:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L617
	addu	$5,$5,1
	.set	macro
	.set	reorder

	sw	$0,0($3)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L617:
	slt	$2,$5,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	RemoveRecordFromCollection__14AIDataRecord_t
	.text
	.ent	StartUp1__14AIDataRecord_t
StartUp1__14AIDataRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$3,23			# 0x00000017
	lui	$2,%hi(recordCollection) # high
	addiu	$2,$2,%lo(recordCollection) # low
	addu	$2,$2,92
	sw	$31,16($sp)
	sw	$0,AIDataRecord_WhichRecord
	sw	$0,AIDataRecord_RecordMethod
$L621:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L621
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,88			# 0x00000058
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
	li	$5,5			# 0x00000005
	.set	macro
	.set	reorder

	sw	$2,AIDataRecord_BestLine
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,88			# 0x00000058
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$2,AIDataRecord_TrackCurve
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	StartUp1__14AIDataRecord_t
	.text
	.ent	StartUp2__14AIDataRecord_t
StartUp2__14AIDataRecord_t:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(recordCollection) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(recordCollection) # low
	sw	$31,24($sp)
$L626:
	lw	$3,0($16)
	#nop
	beq	$3,$0,$L629
	lw	$2,84($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L629:
	addu	$17,$17,1
	slt	$2,$17,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	addu	$16,$16,4
	.set	macro
	.set	reorder

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

	.end	StartUp2__14AIDataRecord_t
	.text
	.ent	CleanUp1__14AIDataRecord_t
CleanUp1__14AIDataRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$3,AIDataRecord_BestLine
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L632
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$2,84($3)
	li	$5,3			# 0x00000003
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sw	$0,AIDataRecord_BestLine
$L632:
	lw	$3,AIDataRecord_TrackCurve
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L631
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,84($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sw	$0,AIDataRecord_TrackCurve
$L631:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CleanUp1__14AIDataRecord_t
	.text
	.ent	CleanUp2__14AIDataRecord_t
CleanUp2__14AIDataRecord_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	CleanUp2__14AIDataRecord_t
	.text
	.ent	Setup__14AIDataRecord_t
Setup__14AIDataRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,76($16)
	#nop
	bne	$2,$0,$L638
	.set	noreorder
	.set	nomacro
	jal	Load__14AIDataRecord_t
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	addu	$4,$16,8
	.set	macro
	.set	reorder

	lw	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

$L638:
	sw	$2,72($16)
$L635:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Setup__14AIDataRecord_t
	.text
	.ent	Load__14AIDataRecord_t
Load__14AIDataRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,80($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L640
	addu	$4,$16,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	loadpackadrz
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,72($16)
$L640:
	lw	$2,72($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Load__14AIDataRecord_t
	.text
	.ent	SaveAndPurge__14AIDataRecord_t
SaveAndPurge__14AIDataRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,72($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L642
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,76($16)
	#nop
	bne	$2,$0,$L643
	jal	purgememadr
$L643:
	sw	$0,72($16)
	li	$2,1			# 0x00000001
$L642:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SaveAndPurge__14AIDataRecord_t
	.text
	.ent	__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	move	$2,$5
	sw	$17,20($sp)
	move	$17,$6
	move	$5,$7
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$16,8
	lui	$5,%hi(D_800553B8) # high
	addiu	$5,$5,%lo(D_800553B8) # low
	lui	$2,%hi(AIDataRecord_AccTable_t_vtable) # high
	addiu	$2,$2,%lo(AIDataRecord_AccTable_t_vtable) # low
	sw	$2,84($16)
	li	$2,112			# 0x00000070
	sw	$2,0($16)
	li	$2,224			# 0x000000e0
	lui	$3,%hi(D_8011647C) # high
	sw	$2,4($16)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	sw	$17,88($16)
	lw	$7,%lo(Cars_gHumanRaceCarList)($2)
	lw	$6,%lo(D_8011647C)($3)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$7,$7,576
	.set	macro
	.set	reorder

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

	.end	__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
	.text
	.ent	Get__23AIDataRecord_AccTable_ti
Get__23AIDataRecord_AccTable_ti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,72($4)
	sll	$5,$5,1
	addu	$5,$5,$2
	lh	$2,0($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,8
	.set	macro
	.set	reorder

	.end	Get__23AIDataRecord_AccTable_ti
	.text
	.ent	Setup__23AIDataRecord_AccTable_t
Setup__23AIDataRecord_AccTable_t:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Setup__14AIDataRecord_t
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$0
$L648:
	slt	$2,$16,112
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L647
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Get__23AIDataRecord_AccTable_ti
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$5,88($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	sll	$3,$16,1
	addu	$16,$16,1
	lw	$4,72($17)
	sra	$2,$2,8
	addu	$3,$3,$4
	.set	noreorder
	.set	nomacro
	j	$L648
	sh	$2,0($3)
	.set	macro
	.set	reorder

$L647:
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

	.end	Setup__23AIDataRecord_AccTable_t
	.text
	.ent	__23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
__23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(AIDataRecord_BestLine_t_vtable) # high
	lw	$3,gNumSlices
	lw	$4,80($16)
	addiu	$2,$2,%lo(AIDataRecord_BestLine_t_vtable) # low
	sw	$2,84($16)
	sw	$3,0($16)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L652
	sw	$3,4($16)
	.set	macro
	.set	reorder

	addu	$4,$16,8
	lui	$2,%hi(D_80116498) # high
	lw	$6,%lo(D_80116498)($2)
	lui	$2,%hi(D_80113228) # high
	lui	$5,%hi(D_800553C4) # high
	lw	$7,%lo(D_80113228)($2)
	.set	noreorder
	.set	nomacro
	j	$L655
	addiu	$5,$5,%lo(D_800553C4) # low
	.set	macro
	.set	reorder

$L652:
	addu	$4,$16,8
	lui	$2,%hi(D_8011649C) # high
	lw	$6,%lo(D_8011649C)($2)
	lui	$2,%hi(D_80113228) # high
	lui	$5,%hi(D_800553D4) # high
	lw	$7,%lo(D_80113228)($2)
	addiu	$5,$5,%lo(D_800553D4) # low
$L655:
	jal	sprintf
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t
	.text
	.ent	__25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
__25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(AIDataRecord_TrackCurve_t_vtable) # high
	lw	$3,gNumSlices
	addiu	$2,$2,%lo(AIDataRecord_TrackCurve_t_vtable) # low
	sw	$2,84($16)
	lw	$2,80($16)
	sw	$3,0($16)
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L657
	sw	$3,4($16)
	.set	macro
	.set	reorder

	addu	$4,$16,8
	lui	$2,%hi(D_80116490) # high
	lw	$6,%lo(D_80116490)($2)
	lui	$2,%hi(D_80113228) # high
	lui	$5,%hi(D_800553E4) # high
	lw	$7,%lo(D_80113228)($2)
	.set	noreorder
	.set	nomacro
	j	$L660
	addiu	$5,$5,%lo(D_800553E4) # low
	.set	macro
	.set	reorder

$L657:
	addu	$4,$16,8
	lui	$2,%hi(D_80116494) # high
	lw	$6,%lo(D_80116494)($2)
	lui	$2,%hi(D_80113228) # high
	lui	$5,%hi(D_800553F4) # high
	lw	$7,%lo(D_80113228)($2)
	addiu	$5,$5,%lo(D_800553F4) # low
$L660:
	jal	sprintf
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t
	.text
	.ent	Get__25AIDataRecord_TrackCurve_ti
Get__25AIDataRecord_TrackCurve_ti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,72($4)
	#nop
	addu	$2,$2,$5
	lbu	$2,0($2)
	j	$31
	.end	Get__25AIDataRecord_TrackCurve_ti
	.text
	.ent	__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	move	$5,$6
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__14AIDataRecord_t26AIDataRecord_WhichRecord_tPc
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(AIDataRecord_CurveSpeedTable_t_vtable) # high
	lw	$3,80($16)
	addiu	$2,$2,%lo(AIDataRecord_CurveSpeedTable_t_vtable) # low
	sw	$2,84($16)
	li	$2,256			# 0x00000100
	sw	$2,0($16)
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L663
	sw	$2,4($16)
	.set	macro
	.set	reorder

	addu	$4,$16,8
	lui	$5,%hi(D_80055404) # high
	lui	$2,%hi(D_80116478) # high
	lw	$6,%lo(D_80116478)($2)
	.set	noreorder
	.set	nomacro
	j	$L666
	addiu	$5,$5,%lo(D_80055404) # low
	.set	macro
	.set	reorder

$L663:
	addu	$4,$16,8
	lui	$5,%hi(D_80055410) # high
	addiu	$5,$5,%lo(D_80055410) # low
	lui	$2,%hi(D_8011647C) # high
	lw	$6,%lo(D_8011647C)($2)
$L666:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$17
	.set	macro
	.set	reorder

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

	.end	__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
	.text
	.ent	Get__30AIDataRecord_CurveSpeedTable_ti
Get__30AIDataRecord_CurveSpeedTable_ti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bgez	$5,$L670
	slt	$2,$5,256
	.set	macro
	.set	reorder

	subu	$5,$0,$5
	slt	$2,$5,256
$L670:
	bne	$2,$0,$L669
	li	$5,255			# 0x000000ff
$L669:
	lw	$2,72($4)
	#nop
	addu	$2,$2,$5
	lbu	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,16
	.set	macro
	.set	reorder

	.end	Get__30AIDataRecord_CurveSpeedTable_ti
	.text
	.ent	Upgrade__30AIDataRecord_CurveSpeedTable_ti
Upgrade__30AIDataRecord_CurveSpeedTable_ti:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$16,16($sp)
	move	$16,$0
	sw	$18,24($sp)
	li	$18,65535			# 0x0000ffff
	sw	$31,32($sp)
$L672:
	lw	$2,0($17)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Get__30AIDataRecord_CurveSpeedTable_ti
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$3,72($17)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L674
	addu	$3,$3,$16
	.set	macro
	.set	reorder

	addu	$2,$2,$18
$L674:
	sra	$2,$2,16
	sb	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L672
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L671:
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

	.end	Upgrade__30AIDataRecord_CurveSpeedTable_ti
	.text
	.ent	Get__26AIDataRecord_CarTracking_ti
Get__26AIDataRecord_CarTracking_ti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Get__26AIDataRecord_CarTracking_ti
	.text
	.ent	_._26AIDataRecord_CarTracking_t
_._26AIDataRecord_CarTracking_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._14AIDataRecord_t
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._26AIDataRecord_CarTracking_t
	.text
	.ent	_._30AIDataRecord_CurveSpeedTable_t
_._30AIDataRecord_CurveSpeedTable_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._14AIDataRecord_t
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._30AIDataRecord_CurveSpeedTable_t
	.text
	.ent	_._25AIDataRecord_TrackCurve_t
_._25AIDataRecord_TrackCurve_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._14AIDataRecord_t
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._25AIDataRecord_TrackCurve_t
	.text
	.ent	_._23AIDataRecord_BestLine_t
_._23AIDataRecord_BestLine_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._14AIDataRecord_t
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._23AIDataRecord_BestLine_t
	.text
	.ent	_._23AIDataRecord_AccTable_t
_._23AIDataRecord_AccTable_t:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_._14AIDataRecord_t
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._23AIDataRecord_AccTable_t
