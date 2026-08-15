	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\statchk.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"ranklap\000"
	.align	2
$LC1:
	.ascii	"rankbst\000"
	.align	2
$LC2:
	.ascii	"trkrcrds\000"
	.text
	.align	2
	.globl	StatChk_IsRecordLapTime__FP10Car_tStatssPs
	.ent	StatChk_IsRecordLapTime__FP10Car_tStatssPs
StatChk_IsRecordLapTime__FP10Car_tStatssPs:
	.frame	$sp,104,$31		# vars= 48, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$23,92($sp)
	move	$23,$4
	sw	$16,64($sp)
	move	$16,$5
	sw	$31,100($sp)
	sw	$fp,96($sp)
	sw	$22,88($sp)
	sw	$21,84($sp)
	sw	$20,80($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$6,112($sp)
	.set	noreorder
	.set	nomacro
	jal	Stattool_CheckForHumanCar__FP10Car_tStats
	sh	$0,48($sp)
	.set	macro
	.set	reorder

	move	$22,$2
	sll	$2,$22,16
	sra	$2,$2,16
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L601
	sh	$16,40($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L625
	move	$2,$0
	.set	macro
	.set	reorder

$L601:
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	sll	$2,$16,16
	sra	$16,$2,16
	sll	$5,$16,2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	sll	$5,$16,1
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$21,$2
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,360			# 0x00000168
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$20,$2
	.set	macro
	.set	reorder

	move	$19,$0
	.set	noreorder
	.set	nomacro
	blez	$16,$L603
	move	$fp,$2
	.set	macro
	.set	reorder

	sw	$16,56($sp)
	sll	$2,$19,16
$L627:
	sra	$17,$2,16
	sll	$18,$17,2
	addu	$2,$18,$17
	sll	$2,$2,5
	addu	$16,$2,$23
	lui	$4,%hi(carManager) # high
	lh	$5,96($16)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromSimID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	lw	$3,108($16)
	#nop
	andi	$3,$3,0x0200
	bne	$3,$0,$L607
	lbu	$2,2($2)
	#nop
	addu	$2,$2,-7
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	addu	$4,$18,$21
	.set	macro
	.set	reorder

	lw	$3,156($16)
	addu	$2,$18,$21
	.set	noreorder
	.set	nomacro
	j	$L604
	sw	$3,0($2)
	.set	macro
	.set	reorder

$L608:
	addu	$3,$17,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	subu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,7
	sw	$2,0($4)
$L604:
	addu	$2,$19,1
	move	$19,$2
	sll	$2,$2,16
	lw	$7,56($sp)
	sra	$2,$2,16
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	sll	$2,$19,16
	.set	macro
	.set	reorder

$L603:
	lhu	$7,40($sp)
	#nop
	sll	$2,$7,16
	sra	$4,$2,16
	slt	$2,$4,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	move	$5,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Stattool_nCreateIndex__FiPiPs
	move	$6,$20
	.set	macro
	.set	reorder

	j	$L612
$L611:
	sh	$0,0($20)
$L612:
	lhu	$7,40($sp)
	#nop
	sll	$2,$7,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L614
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$2
$L616:
	sll	$2,$4,16
	sra	$2,$2,15
	addu	$2,$2,$20
	lh	$3,0($2)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$23
	lw	$2,108($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	lh	$3,0($2)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$23
	lw	$2,156($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L614
	li	$22,1			# 0x00000001
	.set	macro
	.set	reorder

$L617:
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	move	$22,$0
	.set	macro
	.set	reorder

$L614:
	sll	$2,$22,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	sll	$2,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L626
	move	$4,$21
	.set	macro
	.set	reorder

$L607:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L625
	move	$2,$0
	.set	macro
	.set	reorder

$L620:
	sra	$2,$2,15
	addu	$2,$2,$20
	lhu	$16,0($2)
	jal	Front_GetTrackRaced__Fv
	sll	$2,$2,16
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	move	$5,$fp
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$fp
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	sll	$3,$16,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$23
	lw	$4,156($2)
	lw	$3,32($sp)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L623
	bne	$3,$0,$L622
$L623:
	.set	noreorder
	.set	nomacro
	blez	$4,$L622
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	sh	$7,48($sp)
$L622:
	lw	$7,112($sp)
	move	$4,$21
	sh	$16,0($7)
$L626:
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$fp
	.set	macro
	.set	reorder

	lhu	$7,48($sp)
	#nop
	move	$2,$7
$L625:
	lw	$31,100($sp)
	lw	$fp,96($sp)
	lw	$23,92($sp)
	lw	$22,88($sp)
	lw	$21,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	StatChk_IsRecordLapTime__FP10Car_tStatssPs
	.align	2
	.globl	StatChk_SaveRecordLapTime__FP10Car_tStatsss
	.ent	StatChk_SaveRecordLapTime__FP10Car_tStatsss
StatChk_SaveRecordLapTime__FP10Car_tStatsss:
	.frame	$sp,88,$31		# vars= 48, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$20,80($sp)
	move	$20,$4
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	sll	$3,$6,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	sw	$16,64($sp)
	addu	$16,$2,$20
	sw	$31,84($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	lh	$5,96($16)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromSimID__11tCarManagers
	move	$19,$6
	.set	macro
	.set	reorder

	move	$18,$2
	lbu	$2,2($18)
	#nop
	addu	$2,$2,-7
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC2) # low
	li	$5,360			# 0x00000168
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_GetTrackRaced__Fv
	move	$17,$2
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addu	$5,$17,20
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$2,124($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,128($16)
	#nop
	bne	$3,$2,$L630
	lw	$2,136($16)
	.set	noreorder
	.set	nomacro
	j	$L631
	sw	$2,52($sp)
	.set	macro
	.set	reorder

$L630:
	sw	$0,52($sp)
$L631:
	sll	$4,$19,16
	sra	$4,$4,16
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,5
	addu	$2,$2,$20
	lw	$2,156($2)
	#nop
	sw	$2,56($sp)
	lb	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	sw	$2,48($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,40
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$2
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	jal	Front_GetTrackRaced__Fv
	move	$4,$17
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$3,$3,2
	lui	$5,%hi(Stats_gTrackRecords) # high
	addiu	$5,$5,%lo(Stats_gTrackRecords) # low
	addu	$5,$3,$5
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,340			# 0x00000154
	.set	macro
	.set	reorder

	move	$4,$17
	li	$3,1			# 0x00000001
	lui	$2,%hi(NewBestLap) # high
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$3,%lo(NewBestLap)($2)
	.set	macro
	.set	reorder

$L628:
	lw	$31,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	StatChk_SaveRecordLapTime__FP10Car_tStatsss
	.rdata
	.align	2
$LC3:
	.ascii	"toprcrds\000"
	.align	2
$LC4:
	.ascii	"carttime\000"
	.align	2
$LC5:
	.ascii	"carttrnk\000"
	.text
	.align	2
	.globl	StatChk_IsTopTime__FP10Car_tStatss
	.ent	StatChk_IsTopTime__FP10Car_tStatss
StatChk_IsTopTime__FP10Car_tStatss:
	.frame	$sp,96,$31		# vars= 40, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$22,80($sp)
	move	$22,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$23,84($sp)
	move	$23,$0
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	.set	noreorder
	.set	nomacro
	jal	Front_GetLapsForType__Fv
	sw	$17,60($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	li	$6,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	memset
	move	$19,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,360			# 0x00000168
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC4) # high
	addiu	$4,$4,%lo($LC4) # low
	sll	$3,$16,16
	sra	$17,$3,16
	sll	$5,$17,2
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$fp,$2
	.set	macro
	.set	reorder

	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	sll	$5,$17,1
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,48($sp)
	.set	macro
	.set	reorder

	move	$4,$23
	move	$18,$2
	.set	noreorder
	.set	nomacro
	blez	$17,$L635
	sh	$16,40($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	sll	$3,$4,16
$L672:
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$22
	lw	$2,60($2)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$18
	sh	$4,-2($2)
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L672
	sll	$3,$4,16
	.set	macro
	.set	reorder

$L635:
	jal	Front_GetTrackRaced__Fv
	sll	$2,$2,16
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	move	$5,$fp
	.set	macro
	.set	reorder

	sll	$2,$19,16
	sra	$2,$2,16
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L639
	li	$4,9			# 0x00000009
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
$L639:
	move	$17,$0
	li	$19,1			# 0x00000001
	sll	$2,$4,2
	or	$2,$2,$4
	sll	$2,$2,2
	addu	$21,$2,$fp
	addu	$20,$21,140
$L640:
	sll	$2,$17,16
	lhu	$7,40($sp)
	sra	$16,$2,16
	sll	$3,$7,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$2,$16
	sll	$2,$2,5
	addu	$2,$2,$22
	lui	$4,%hi(carManager) # high
	lh	$5,96($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromSimID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	sll	$3,$16,1
	addu	$3,$3,$18
	lh	$4,0($3)
	#nop
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,5
	addu	$3,$3,$22
	lw	$5,108($3)
	move	$4,$2
	andi	$2,$5,0x0200
	bne	$2,$0,$L669
	lbu	$2,2($4)
	#nop
	addu	$2,$2,-7
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lbu	$2,%lo(frontEnd+3)($2)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	andi	$2,$5,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,128($3)
	#nop
	bne	$3,$2,$L646
	li	$23,1			# 0x00000001
$L646:
	.set	noreorder
	.set	nomacro
	bne	$23,$19,$L642
	sll	$2,$17,16
	.set	macro
	.set	reorder

	sra	$2,$2,15
	addu	$2,$2,$18
	lh	$2,0($2)
	#nop
	sll	$3,$2,2
	addu	$2,$3,$2
	sll	$2,$2,5
	addu	$2,$2,$22
	lw	$4,136($2)
	lw	$2,132($21)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	move	$23,$0
	.set	macro
	.set	reorder

	lw	$2,12($20)
	#nop
	bne	$2,$0,$L648
	blez	$4,$L648
$L649:
	addu	$2,$sp,$3
	.set	noreorder
	.set	nomacro
	j	$L650
	sw	$19,24($2)
	.set	macro
	.set	reorder

$L648:
	lw	$3,12($20)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L652
	bne	$3,$0,$L650
	blez	$4,$L650
$L652:
	sll	$3,$17,16
	sra	$3,$3,15
	addu	$3,$3,$18
	lh	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	sw	$19,24($2)
	lh	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	sw	$19,16($2)
$L650:
	lw	$2,12($21)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	sll	$3,$17,16
	.set	macro
	.set	reorder

	lw	$2,12($20)
	#nop
	bne	$2,$0,$L642
	blez	$4,$L642
$L673:
	sra	$3,$3,15
	addu	$3,$3,$18
	lh	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	sw	$19,24($2)
	lh	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	sw	$19,32($2)
$L642:
	.set	noreorder
	.set	nomacro
	j	$L640
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L641:
	lw	$2,16($sp)
	#nop
	beq	$2,$0,$L659
	lw	$2,20($sp)
	#nop
	beq	$2,$0,$L655
	lw	$3,136($22)
	lw	$2,296($22)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L670
	.set	noreorder
	.set	nomacro
	j	$L658
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L655:
	lw	$2,28($sp)
	#nop
	beq	$2,$0,$L659
	.set	noreorder
	.set	nomacro
	j	$L658
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L659:
	lw	$2,20($sp)
	#nop
	beq	$2,$0,$L658
	lw	$2,24($sp)
	#nop
	beq	$2,$0,$L658
$L670:
	sw	$0,28($sp)
$L658:
	lw	$2,32($sp)
	#nop
	beq	$2,$0,$L662
	lw	$2,36($sp)
	#nop
	beq	$2,$0,$L662
	lw	$3,136($22)
	lw	$2,296($22)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L663
	.set	noreorder
	.set	nomacro
	j	$L662
	sw	$0,36($sp)
	.set	macro
	.set	reorder

$L669:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$4,48($sp)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L668
	move	$2,$0
	.set	macro
	.set	reorder

$L663:
	sw	$0,32($sp)
$L662:
	lw	$2,24($sp)
	lw	$3,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L665
	sltu	$16,$0,$2
	.set	macro
	.set	reorder

	ori	$16,$16,0x0002
$L665:
	lw	$2,28($sp)
	#nop
	beq	$2,$0,$L666
	ori	$16,$16,0x0004
$L666:
	lw	$2,36($sp)
	#nop
	beq	$2,$0,$L667
	ori	$16,$16,0x0008
$L667:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$fp
	.set	macro
	.set	reorder

	lw	$4,48($sp)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	move	$2,$16
$L668:
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	StatChk_IsTopTime__FP10Car_tStatss
	.rdata
	.align	2
$LC6:
	.ascii	"records\000"
	.text
	.align	2
	.globl	StatChk_SaveTopTime__FP10Car_tStatss
	.ent	StatChk_SaveTopTime__FP10Car_tStatss
StatChk_SaveTopTime__FP10Car_tStatss:
	.frame	$sp,176,$31		# vars= 120, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	sw	$fp,168($sp)
	move	$fp,$4
	sw	$23,164($sp)
	move	$23,$0
	sw	$16,136($sp)
	move	$16,$23
	addu	$3,$sp,88
	sw	$31,172($sp)
	sw	$22,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$18,144($sp)
	sw	$17,140($sp)
	sh	$5,96($sp)
	sw	$0,104($sp)
	sh	$0,120($sp)
	sll	$2,$16,16
$L736:
	sra	$2,$2,14
	addu	$2,$3,$2
	sw	$0,0($2)
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L736
	sll	$2,$16,16
	.set	macro
	.set	reorder

	li	$2,20			# 0x00000014
	lhu	$8,96($sp)
 #APP
 #NO_APP
	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	sll	$16,$2,3
	addu	$5,$16,$2
	sll	$5,$5,1
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC4) # high
	addiu	$4,$4,%lo($LC4) # low
	li	$6,16			# 0x00000010
	lhu	$9,96($sp)
	move	$22,$2
	sll	$3,$9,16
	sra	$17,$3,16
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$17,2
	.set	macro
	.set	reorder

	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	sll	$5,$17,1
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,132($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	move	$5,$16
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$21,$2
	.set	macro
	.set	reorder

	move	$16,$0
	.set	noreorder
	.set	nomacro
	blez	$17,$L681
	sw	$2,128($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	sll	$3,$16,16
$L737:
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$fp
	lw	$2,60($2)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$21
	sh	$16,-2($2)
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L737
	sll	$3,$16,16
	.set	macro
	.set	reorder

$L681:
	jal	Front_GetTrackRaced__Fv
	sll	$2,$2,16
	sra	$4,$2,16
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	move	$5,$22
	.set	macro
	.set	reorder

	jal	Front_GetLapsForType__Fv
	li	$10,9			# 0x00000009
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L685
	sh	$10,112($sp)
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
	sh	$11,112($sp)
$L685:
	lhu	$8,96($sp)
	#nop
	sll	$2,$8,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L688
	move	$18,$0
	.set	macro
	.set	reorder

	lhu	$9,112($sp)
	addu	$19,$sp,48
	move	$17,$9
	sll	$2,$17,2
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$20,$2,$22
	sll	$2,$18,16
$L745:
	sra	$2,$2,15
	addu	$16,$2,$21
	lh	$3,0($16)
	lui	$4,%hi(carManager) # high
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$fp
	lh	$5,96($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromSimID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	move	$6,$2
	lbu	$2,2($6)
	#nop
	addu	$2,$2,-7
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	addu	$2,$18,1
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+3) # high
	lbu	$2,%lo(frontEnd+3)($2)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L692
	lui	$2,%hi(GameSetup_gData+28) # high
	.set	macro
	.set	reorder

	lh	$2,0($16)
	#nop
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,5
	.set	noreorder
	.set	nomacro
	j	$L735
	addu	$3,$3,$fp
	.set	macro
	.set	reorder

$L734:
	lhu	$10,120($sp)
	addu	$3,$sp,$2
	sll	$2,$10,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$L713
	sw	$2,88($3)
	.set	macro
	.set	reorder

$L692:
	lh	$3,0($16)
	lw	$2,%lo(GameSetup_gData+28)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L739
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$3,$2,$fp
$L735:
	lw	$2,108($3)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,128($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L739
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$23,1			# 0x00000001
$L694:
	li	$2,1			# 0x00000001
$L739:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L738
	addu	$2,$18,1
	.set	macro
	.set	reorder

	sll	$2,$18,16
	sra	$2,$2,15
	addu	$5,$2,$21
	lh	$3,0($5)
	lw	$4,152($20)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$fp
	lw	$3,136($2)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	move	$23,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L738
	addu	$2,$18,1
	.set	macro
	.set	reorder

	blez	$3,$L738
$L699:
	sw	$3,76($sp)
	lb	$2,0($6)
	lhu	$16,112($sp)
	sw	$2,72($sp)
	lh	$3,0($5)
	li	$11,1			# 0x00000001
	sw	$11,104($sp)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,5
	addu	$2,$2,$fp
	lw	$2,156($2)
	addu	$3,$17,8
	sw	$2,80($sp)
	slt	$2,$17,$3
	lw	$8,64($sp)
	lw	$9,68($sp)
	lw	$10,72($sp)
	lw	$11,76($sp)
	sw	$8,140($20)
	sw	$9,144($20)
	sw	$10,148($20)
	sw	$11,152($20)
	lw	$8,80($sp)
	sw	$8,156($20)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L701
	addu	$7,$sp,16
	.set	macro
	.set	reorder

	move	$6,$3
	sll	$2,$16,16
$L740:
	sra	$4,$2,16
	subu	$3,$4,$17
	sll	$3,$3,2
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$22
	lw	$2,12($2)
	addu	$5,$7,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L702
	sw	$2,0($5)
	.set	macro
	.set	reorder

	addu	$3,$4,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	subu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,7
	sw	$2,0($5)
$L702:
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L701:
	li	$4,8			# 0x00000008
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Stattool_nCreateIndex__FiPiPs
	addu	$6,$sp,48
	.set	macro
	.set	reorder

	move	$16,$0
	li	$3,7			# 0x00000007
	sll	$2,$16,16
$L742:
	sra	$2,$2,15
	addu	$2,$19,$2
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L741
	addu	$2,$16,1
	.set	macro
	.set	reorder

	addu	$8,$16,1
	sh	$8,120($sp)
$L741:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L742
	sll	$2,$16,16
	.set	macro
	.set	reorder

	move	$16,$0
	sll	$2,$18,16
	sra	$2,$2,15
	addu	$2,$2,$21
	lh	$3,0($2)
	sll	$2,$16,16
$L743:
	sra	$2,$2,15
	addu	$2,$19,$2
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L734
	sll	$2,$2,2
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L713:
	sll	$2,$18,16
	sra	$2,$2,15
	addu	$2,$2,$21
	lh	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,64
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$2
	.set	macro
	.set	reorder

	li	$9,20			# 0x00000014
 #APP
 #NO_APP
	move	$2,$9
	sll	$6,$2,3
 #APP
 #NO_APP
	lw	$4,128($sp)
	lw	$10,64($sp)
	lw	$11,68($sp)
	lw	$8,72($sp)
	lw	$9,76($sp)
	sw	$10,140($20)
	sw	$11,144($20)
	sw	$8,148($20)
	sw	$9,152($20)
	lw	$10,80($sp)
	sw	$10,156($20)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	move	$5,$20
	.set	macro
	.set	reorder

	sll	$3,$16,16
$L744:
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$19,$2
	li	$6,20			# 0x00000014
	lh	$2,0($2)
 #APP
 #NO_APP
	addu	$3,$17,$3
	sll	$4,$3,2
	addu	$4,$4,$3
	sll	$4,$4,2
	addu	$4,$4,$22
 #APP
 #NO_APP
	mult	$2,$6
	lw	$8,128($sp)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$8,$9
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	sll	$3,$16,16
	.set	macro
	.set	reorder

	addu	$2,$18,1
$L738:
	move	$18,$2
	lhu	$10,96($sp)
	sll	$2,$2,16
	sll	$3,$10,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L745
	sll	$2,$18,16
	.set	macro
	.set	reorder

$L688:
	lw	$11,104($sp)
	li	$2,1			# 0x00000001
	bne	$11,$2,$L724
	jal	Front_GetTrackRaced__Fv
	move	$4,$22
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$3,$3,2
	lui	$5,%hi(Stats_gTrackRecords) # high
	addiu	$5,$5,%lo(Stats_gTrackRecords) # low
	addu	$5,$3,$5
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,340			# 0x00000154
	.set	macro
	.set	reorder

$L724:
	lw	$3,88($sp)
	lw	$2,92($sp)
	#nop
	bne	$3,$2,$L725
	addu	$2,$3,1
	.set	noreorder
	.set	nomacro
	j	$L726
	sw	$2,92($sp)
	.set	macro
	.set	reorder

$L725:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,88($sp)
$L726:
	move	$16,$0
	addu	$4,$sp,88
	lui	$2,%hi(NewRecords) # high
	addiu	$6,$2,%lo(NewRecords) # low
	li	$5,1			# 0x00000001
	sll	$2,$16,16
$L746:
	sra	$2,$2,14
	addu	$2,$4,$2
	lw	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L730
	slt	$2,$3,9
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sll	$2,$2,2
	addu	$2,$2,$6
	sw	$5,0($2)
$L730:
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L746
	sll	$2,$16,16
	.set	macro
	.set	reorder

	lw	$4,128($sp)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$4,132($sp)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$31,172($sp)
	lw	$fp,168($sp)
	lw	$23,164($sp)
	lw	$22,160($sp)
	lw	$21,156($sp)
	lw	$20,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	StatChk_SaveTopTime__FP10Car_tStatss
	.align	2
	.globl	StatChk_ClearNewRecords__Fv
	.ent	StatChk_ClearNewRecords__Fv
StatChk_ClearNewRecords__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,7			# 0x00000007
	lui	$2,%hi(NewRecords) # high
	addiu	$2,$2,%lo(NewRecords) # low
	addu	$2,$2,28
$L748:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L748
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lui	$2,%hi(NewBestLap) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,%lo(NewBestLap)($2)
	.set	macro
	.set	reorder

	.end	StatChk_ClearNewRecords__Fv
