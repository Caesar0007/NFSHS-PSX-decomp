	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\overlays.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	OptionsBarThing__Fiiii
	.sdata
	.align	2
$LC0:
	.ascii	"%d\000"
	.align	2
$LC1:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	RaceSummary__Fv
	.align	2
	.globl	RaceStatistics__Fv
	.align	2
	.globl	Hud_BTCStats__Fsb
	.align	2
	.globl	Hud_RenderStatsView__Fv
	.globl	StatsTimer
	.sdata
	.align	2
StatsTimer:
	.space	4
	.globl	D_8013D99C
	.align	2
D_8013D99C:
	.space	4
	.globl	Hud_NextPerp
	.align	2
Hud_NextPerp:
	.space	4

	.extern	D_8013D99C, 4
	.extern	StatsTimer, 4
	.extern	D_8010FA4C, 4
	.extern	simGlobal, 24
	.extern	FinalBTC_Countdown, 4
	.extern	BTCPerpInfo, 320
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gNumRaceCars, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	OptionsBarThing__Fiiii
OptionsBarThing__Fiiii:
	.frame	$sp,56,$31		# vars= 0, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,44($sp)
	move	$19,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$20,48($sp)
	move	$20,$6
	sw	$18,40($sp)
	move	$18,$7
	li	$4,1			# 0x00000001
	sw	$31,52($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_GoTpage__Fi
	sw	$17,36($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	li	$4,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$0
	move	$6,$5
	move	$7,$5
	li	$2,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildString__FPciiiib
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	sra	$2,$2,1
	li	$5,160			# 0x000000a0
	subu	$5,$5,$2
	addu	$16,$16,$18
	addu	$6,$16,-6
	li	$7,48830			# 0x0000bebe
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildString__FPciiiib
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$19
	addu	$6,$16,-8
	move	$7,$20
	li	$2,8			# 0x00000008
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hud_GoTpage__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,52($sp)
	lw	$20,48($sp)
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

	.end	OptionsBarThing__Fiiii
	.text
	.ent	RaceSummary__Fv
RaceSummary__Fv:
	.frame	$sp,184,$31		# vars= 112, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$22,168($sp)
	lui	$8,%hi(GameSetup_gData) # high
	addiu	$8,$8,%lo(GameSetup_gData) # low
	sw	$31,180($sp)
	sw	$fp,176($sp)
	sw	$23,172($sp)
	sw	$21,164($sp)
	sw	$20,160($sp)
	sw	$19,156($sp)
	sw	$18,152($sp)
	sw	$17,148($sp)
	sw	$16,144($sp)
	lw	$2,4($8)
	li	$fp,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$fp,$L602
	li	$22,8			# 0x00000008
	.set	macro
	.set	reorder

	li	$22,40			# 0x00000028
$L602:
	li	$8,304			# 0x00000130
	.set	noreorder
	.set	nomacro
	bne	$2,$fp,$L603
	sh	$8,72($sp)
	.set	macro
	.set	reorder

	li	$8,239			# 0x000000ef
	sh	$8,72($sp)
$L603:
	lw	$2,Cars_gNumRaceCars
	li	$4,56			# 0x00000038
	addu	$2,$2,1
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,2
	addu	$16,$16,30
	sh	$16,80($sp)
	sll	$16,$16,16
	sra	$8,$16,16
	sra	$16,$16,17
	li	$2,120			# 0x00000078
	subu	$2,$2,$16
	sw	$8,96($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,100($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	sra	$2,$2,1
	li	$17,160			# 0x000000a0
	subu	$17,$17,$2
	li	$2,118			# 0x00000076
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	subu	$21,$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,56			# 0x00000038
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$17,$17,16
	sra	$5,$17,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,46			# 0x0000002e
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$2,$22,17
	move	$17,$2
	move	$5,$17
	addu	$2,$21,15
	sll	$2,$2,16
	sra	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,58			# 0x0000003a
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$2,$22,95
	move	$20,$2
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,59			# 0x0000003b
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$2,$22,167
	move	$18,$2
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	lhu	$8,100($sp)
	sh	$22,104($sp)
	sh	$17,112($sp)
	sh	$20,120($sp)
	sh	$18,128($sp)
	sh	$8,88($sp)
	lui	$8,%hi(GameSetup_gData) # high
	addiu	$8,$8,%lo(GameSetup_gData) # low
	lw	$2,4($8)
	addu	$19,$22,225
	.set	noreorder
	.set	nomacro
	beq	$2,$fp,$L604
	sh	$19,136($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,60			# 0x0000003c
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

$L604:
	move	$4,$0
	move	$5,$22
	addu	$2,$21,17
	sll	$2,$2,16
	sra	$23,$2,16
	lhu	$8,72($sp)
	addu	$6,$23,12
	sw	$fp,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	move	$7,$8
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$5,$17,-2
	lw	$17,100($sp)
	lw	$8,96($sp)
	li	$7,1			# 0x00000001
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	move	$6,$17
	addu	$16,$8,-8
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$5,$20,-2
	move	$6,$17
	li	$7,1			# 0x00000001
	sw	$16,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$5,$18,-2
	move	$6,$17
	li	$7,1			# 0x00000001
	sw	$16,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lui	$8,%hi(GameSetup_gData) # high
	addiu	$8,$8,%lo(GameSetup_gData) # low
	lw	$2,4($8)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$fp,$L605
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$5,$19,-2
	move	$6,$17
	li	$7,1			# 0x00000001
	sw	$16,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

$L605:
	move	$19,$0
	lui	$2,%hi(Cars_gRaceCarList) # high
	addiu	$21,$2,%lo(Cars_gRaceCarList) # low
	move	$20,$23
	lui	$23,%hi(GameSetup_gData)
$L606:
	sll	$3,$19,16
	lw	$2,Cars_gNumRaceCars
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$21
	lw	$4,0($2)
	#nop
	lw	$18,976($4)
	lw	$3,StatsTimer
	sll	$2,$18,1
	addu	$2,$2,4
	slt	$2,$2,$3
	beq	$2,$0,$L610
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
$L611:
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	sll	$16,$18,1
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	addu	$16,$16,$18
	sll	$16,$16,2
	addu	$16,$20,$16
	lhu	$8,104($sp)
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	ori	$5,$8,0x0001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$17,$19,16
	sra	$17,$17,14
	addu	$17,$17,$21
	lw	$2,0($17)
	lui	$5,%hi($LC1) # high
	lw	$6,648($2)
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$6,92
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lhu	$8,112($sp)
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$5,$8
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
$L613:
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	sll	$16,$19,16
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC1) # high
	sra	$16,$16,16
	sll	$2,$16,2
	addu	$17,$2,$21
	lw	$6,0($17)
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$6,585
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$6,$18,1
	addu	$6,$6,$18
	sll	$6,$6,2
	lhu	$8,120($sp)
	addu	$6,$20,$6
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$5,$8
	.set	macro
	.set	reorder

	addiu	$2,$23,%lo(GameSetup_gData) # low
	lw	$2,184($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L615
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L626
	li	$4,54			# 0x00000036
	.set	macro
	.set	reorder

$L615:
	lw	$3,%lo(GameSetup_gData)($23)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L629
	sll	$2,$19,16
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$2,968($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	li	$4,61			# 0x0000003d
	.set	macro
	.set	reorder

	sll	$2,$19,16
$L629:
	sra	$2,$2,14
	addu	$2,$2,$21
	lw	$4,0($2)
	#nop
	lw	$3,972($4)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L619
	lw	$4,980($4)
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L628
	addu	$4,$sp,32
	.set	macro
	.set	reorder

$L619:
	li	$4,53			# 0x00000035
$L626:
	jal	TextSys_Word__Fi
	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,32
$L628:
	sll	$6,$18,1
	addu	$6,$6,$18
	sll	$6,$6,2
	lhu	$8,128($sp)
	addu	$6,$20,$6
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$5,$8
	.set	macro
	.set	reorder

	addiu	$2,$23,%lo(GameSetup_gData) # low
	lw	$3,4($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L610
	sll	$2,$19,16
	.set	macro
	.set	reorder

	sra	$2,$2,14
	addu	$2,$2,$21
	lw	$2,0($2)
	#nop
	lw	$4,1000($2)
	#nop
	bne	$4,$0,$L627
	move	$4,$0
$L627:
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lhu	$8,136($sp)
	sll	$6,$18,1
	addu	$6,$6,$18
	sll	$6,$6,2
	addu	$6,$20,$6
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$5,$8
	.set	macro
	.set	reorder

$L610:
	.set	noreorder
	.set	nomacro
	j	$L606
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L607:
	move	$19,$22
	lhu	$8,88($sp)
	move	$4,$19
	sll	$17,$8,16
	sra	$17,$17,16
	lhu	$8,72($sp)
	move	$5,$17
	move	$18,$8
	lhu	$8,80($sp)
	move	$6,$18
	sll	$16,$8,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	OptionsBarThing__Fiiii
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	Hud_RenderPauseBox__Fiiii
	move	$7,$16
	.set	macro
	.set	reorder

	lw	$31,180($sp)
	lw	$fp,176($sp)
	lw	$23,172($sp)
	lw	$22,168($sp)
	lw	$21,164($sp)
	lw	$20,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	RaceSummary__Fv
	.text
	.ent	RaceStatistics__Fv
RaceStatistics__Fv:
	.frame	$sp,176,$31		# vars= 104, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	lui	$9,%hi(GameSetup_gData) # high
	addiu	$9,$9,%lo(GameSetup_gData) # low
	sw	$23,164($sp)
	li	$23,160			# 0x000000a0
	sw	$31,172($sp)
	sw	$fp,168($sp)
	sw	$22,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$18,144($sp)
	sw	$17,140($sp)
	sw	$16,136($sp)
	lw	$4,4($9)
	li	$18,1			# 0x00000001
	addu	$3,$4,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,Cars_gNumHumanRaceCars
	addu	$2,$2,40
	sh	$2,88($sp)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	subu	$17,$3,$2
	sll	$9,$17,1
	subu	$20,$23,$17
	sh	$9,80($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$18,$L631
	sh	$20,72($sp)
	.set	macro
	.set	reorder

	li	$9,52			# 0x00000034
	sh	$9,88($sp)
$L631:
	lui	$9,%hi(GameSetup_gData) # high
	lw	$2,%lo(GameSetup_gData)($9)
	#nop
	bne	$2,$18,$L632
	lhu	$9,88($sp)
	#nop
	addu	$9,$9,27
	sh	$9,88($sp)
$L632:
	li	$4,57			# 0x00000039
	lhu	$9,88($sp)
	li	$2,120			# 0x00000078
	sll	$9,$9,16
	sra	$16,$9,17
	subu	$2,$2,$16
	sw	$9,104($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,108($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$22,$20,10
	li	$21,160			# 0x000000a0
	sra	$2,$2,1
	subu	$23,$23,$2
	lhu	$9,108($sp)
	li	$2,118			# 0x00000076
	sh	$9,96($sp)
	lui	$9,%hi(GameSetup_gData) # high
	addiu	$9,$9,%lo(GameSetup_gData) # low
	lw	$3,4($9)
	subu	$16,$2,$16
	addu	$3,$3,2
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	addu	$19,$2,19
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L633
	sh	$19,112($sp)
	.set	macro
	.set	reorder

	li	$21,85			# 0x00000055
$L633:
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,57			# 0x00000039
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$23,16
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$0
	sll	$2,$20,16
	sra	$20,$2,16
	move	$5,$20
	addu	$2,$16,17
	sll	$2,$2,16
	sra	$fp,$2,16
	addu	$6,$fp,11
	sll	$2,$17,17
	sra	$16,$2,16
	move	$7,$16
	sw	$18,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(GameSetup_gData) # high
	lw	$2,%lo(GameSetup_gData)($9)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L669
	move	$23,$0
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$20
	sll	$6,$19,16
	sra	$6,$6,16
	move	$7,$16
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	move	$23,$0
$L669:
	lw	$9,108($sp)
	move	$19,$fp
	sw	$9,124($sp)
	lw	$9,104($sp)
	la	$fp,GameSetup_gData
	sra	$9,$9,16
	sw	$9,120($sp)
	addu	$9,$9,-8
	sw	$9,128($sp)
$L635:
	sll	$3,$23,16
	lw	$2,Cars_gNumHumanRaceCars
	sra	$16,$3,16
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	lui	$2,%hi(Cars_gRaceCarList) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_gRaceCarList) # low
	sll	$20,$16,2
	addu	$17,$20,$2
	lw	$2,0($17)
	#nop
	lw	$4,648($2)
	.set	noreorder
	.set	nomacro
	jal	textpixels
	addu	$4,$4,92
	.set	macro
	.set	reorder

	move	$4,$0
	sll	$5,$21,16
	sra	$5,$5,16
	addu	$5,$5,-2
	addu	$6,$19,11
	li	$7,1			# 0x00000001
	lw	$9,120($sp)
	sra	$2,$2,$7
	addu	$3,$9,-19
	lw	$9,124($sp)
	subu	$18,$5,$2
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	subu	$8,$19,$9
	subu	$3,$3,$8
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$16,$L639
	move	$4,$0
	.set	macro
	.set	reorder

	sll	$5,$22,16
	sra	$5,$5,16
	addu	$5,$5,-2
	lw	$6,124($sp)
	lw	$9,128($sp)
	li	$7,1			# 0x00000001
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$9,16($sp)
	.set	macro
	.set	reorder

$L639:
	lw	$2,D_8013D99C
	#nop
	slt	$2,$2,3
	bne	$2,$0,$L640
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lw	$2,0($17)
	lui	$5,%hi($LC1) # high
	lw	$6,648($2)
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$6,92
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$19,-4
	.set	macro
	.set	reorder

$L640:
	lw	$2,4($fp)
	li	$9,1			# 0x00000001
	beq	$2,$9,$L670
	.set	noreorder
	.set	nomacro
	blez	$2,$L670
	lui	$9,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	move	$17,$0
	addiu	$9,$9,%lo(Cars_gHumanRaceCarList) # low
	addu	$18,$20,$9
	sll	$2,$17,16
$L671:
	sra	$5,$2,16
	sll	$2,$5,1
	lw	$3,D_8013D99C
	addu	$2,$2,4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	sll	$2,$5,2
	.set	macro
	.set	reorder

	lw	$4,0($18)
	#nop
	addu	$2,$4,$2
	lw	$3,984($2)
	#nop
	beq	$3,$0,$L647
	lw	$2,1000($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L665
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

$L647:
	li	$4,4			# 0x00000004
$L665:
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	sll	$16,$17,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,52			# 0x00000034
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$2
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$16,1
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$22,16
	sra	$5,$5,16
	sll	$6,$16,1
	addu	$6,$6,$16
	sll	$6,$6,2
	addu	$6,$19,$6
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$6,12
	.set	macro
	.set	reorder

	lw	$2,0($18)
	sll	$16,$16,2
	addu	$2,$2,$16
	lw	$4,984($2)
	#nop
	bne	$4,$0,$L666
	move	$4,$0
$L666:
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$21,16
	sra	$5,$5,16
	addu	$5,$5,5
	sll	$2,$17,16
	sra	$2,$2,16
	sll	$6,$2,1
	addu	$6,$6,$2
	sll	$6,$6,2
	addu	$6,$19,$6
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$6,12
	.set	macro
	.set	reorder

$L646:
	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	lw	$3,4($fp)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	sll	$2,$17,16
	.set	macro
	.set	reorder

	lw	$2,4($fp)
$L670:
	lw	$3,D_8013D99C
	sll	$2,$2,1
	addu	$2,$2,4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	lui	$9,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,55			# 0x00000037
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,4($fp)
	li	$9,1			# 0x00000001
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$6,$19,$3
	sll	$3,$22,16
	.set	noreorder
	.set	nomacro
	beq	$2,$9,$L653
	sra	$5,$3,16
	.set	macro
	.set	reorder

	addu	$6,$6,12
$L653:
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	sll	$2,$23,16
	lw	$3,184($fp)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L654
	sll	$2,$2,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L667
	li	$4,54			# 0x00000036
	.set	macro
	.set	reorder

$L654:
	lui	$9,%hi(Cars_gHumanRaceCarList) # high
	addiu	$9,$9,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$2,$9
	lw	$4,0($2)
	#nop
	lw	$3,972($4)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L656
	lui	$9,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$4,980($4)
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L668
	sll	$2,$21,16
	.set	macro
	.set	reorder

$L656:
	lw	$2,%lo(GameSetup_gData)($9)
	li	$9,1			# 0x00000001
	bne	$2,$9,$L658
	lw	$2,968($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	li	$4,61			# 0x0000003d
	.set	macro
	.set	reorder

$L658:
	li	$4,53			# 0x00000035
$L667:
	jal	TextSys_Word__Fi
	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	sll	$2,$21,16
$L668:
	sra	$2,$2,16
	lw	$3,4($fp)
	li	$9,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$9,$L660
	addu	$5,$2,5
	.set	macro
	.set	reorder

	sll	$2,$3,$9
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$19,$2
	.set	noreorder
	.set	nomacro
	j	$L661
	addu	$6,$2,12
	.set	macro
	.set	reorder

$L660:
	addu	$6,$19,12
$L661:
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$9,%hi(GameSetup_gData) # high
$L672:
	lw	$2,%lo(GameSetup_gData)($9)
	li	$9,1			# 0x00000001
	bne	$2,$9,$L662
	lw	$2,4($fp)
	lw	$3,D_8013D99C
	sll	$2,$2,$9
	addu	$2,$2,6
	slt	$2,$2,$3
	beq	$2,$0,$L663
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,62			# 0x0000003e
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$22,16
	lhu	$9,112($sp)
	sra	$5,$5,16
	sll	$16,$9,16
	sra	$16,$16,16
	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	sll	$2,$23,16
	sra	$2,$2,14
	lui	$9,%hi(Cars_gHumanRaceCarList) # high
	addiu	$9,$9,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$2,$9
	addu	$4,$sp,32
	lw	$2,0($2)
	lui	$5,%hi($LC0) # high
	lw	$6,960($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$21,16
	sra	$5,$5,16
	addu	$5,$5,5
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

$L663:
	lw	$2,4($fp)
	lw	$3,D_8013D99C
	sll	$2,$2,1
	addu	$2,$2,8
	slt	$2,$2,$3
	beq	$2,$0,$L662
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,63			# 0x0000003f
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$22,16
	lhu	$9,112($sp)
	sra	$5,$5,16
	sll	$16,$9,16
	sra	$16,$16,16
	addu	$16,$16,13
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	sll	$2,$23,16
	sra	$2,$2,14
	lui	$9,%hi(Cars_gHumanRaceCarList) # high
	addiu	$9,$9,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$2,$9
	addu	$4,$sp,32
	lw	$2,0($2)
	lui	$5,%hi($LC0) # high
	lw	$6,964($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	sll	$5,$21,16
	sra	$5,$5,16
	addu	$5,$5,5
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

$L662:
	addu	$22,$22,150
	addu	$21,$21,150
	.set	noreorder
	.set	nomacro
	j	$L635
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L636:
	lhu	$9,72($sp)
	#nop
	sll	$19,$9,16
	sra	$19,$19,16
	lhu	$9,96($sp)
	move	$4,$19
	sll	$18,$9,16
	sra	$18,$18,16
	lhu	$9,80($sp)
	move	$5,$18
	sll	$17,$9,16
	sra	$17,$17,16
	lhu	$9,88($sp)
	move	$6,$17
	sll	$16,$9,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	OptionsBarThing__Fiiii
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$18
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	Hud_RenderPauseBox__Fiiii
	move	$7,$16
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

	.end	RaceStatistics__Fv
	.text
	.ent	Hud_BTCStats__Fsb
Hud_BTCStats__Fsb:
	.frame	$sp,168,$31		# vars= 96, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	lw	$2,Cars_gNumHumanRaceCars
	move	$3,$4
	sw	$fp,160($sp)
	move	$fp,$0
	sw	$20,144($sp)
	move	$20,$fp
	sw	$31,164($sp)
	sw	$23,156($sp)
	sw	$22,152($sp)
	sw	$21,148($sp)
	sw	$19,140($sp)
	sw	$18,136($sp)
	sw	$17,132($sp)
	sw	$16,128($sp)
	sw	$5,172($sp)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sh	$3,80($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(Cars_gHumanRaceCarList) # high
	addiu	$4,$4,%lo(Cars_gHumanRaceCarList) # low
	sll	$3,$3,16
	sra	$3,$3,16
	li	$2,1			# 0x00000001
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$2,0($2)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L675
	.set	noreorder
	.set	nomacro
	j	$L674
	li	$fp,1			# 0x00000001
	.set	macro
	.set	reorder

$L675:
	li	$20,1			# 0x00000001
$L674:
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L677
	li	$6,231			# 0x000000e7
	.set	macro
	.set	reorder

	li	$6,161			# 0x000000a1
$L677:
	lw	$8,172($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L679
	sw	$0,88($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(BTCPerpInfo) # high
	la	$3,Hud_NextPerp
	lhu	$8,80($sp)
	addiu	$5,$5,%lo(BTCPerpInfo) # low
	sll	$4,$8,16
	sra	$4,$4,16
	sll	$2,$4,1
	addu	$2,$2,$3
	lh	$3,0($2)
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,5
	addu	$3,$3,-1
	sll	$3,$3,4
	addu	$3,$3,$2
	addu	$3,$3,$5
	lw	$2,12($3)
	#nop
	beq	$2,$0,$L678
$L679:
	li	$8,1			# 0x00000001
	sw	$8,88($sp)
$L678:
	la	$3,Hud_NextPerp
	lhu	$8,80($sp)
	li	$21,160			# 0x000000a0
	sll	$2,$8,16
	sra	$2,$2,15
	addu	$2,$2,$3
	lh	$3,0($2)
	addu	$8,$6,6
	sh	$8,104($sp)
	lw	$8,88($sp)
	addu	$3,$3,1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,2
	addu	$23,$3,22
	srl	$2,$6,1
	subu	$17,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L680
	sh	$17,96($sp)
	.set	macro
	.set	reorder

	addu	$23,$3,34
$L680:
	lw	$8,172($sp)
	#nop
	beq	$8,$0,$L681
	addu	$23,$23,8
$L681:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L720
	sll	$2,$23,16
	.set	macro
	.set	reorder

	addu	$23,$23,12
	sll	$2,$23,16
$L720:
	sra	$16,$2,17
	li	$2,120			# 0x00000078
	subu	$2,$2,$16
	li	$4,71			# 0x00000047
	addu	$18,$17,7
	lw	$8,172($sp)
	move	$19,$18
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L683
	sh	$2,112($sp)
	.set	macro
	.set	reorder

	li	$4,72			# 0x00000048
$L683:
	jal	TextSys_Word__Fi
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	sra	$2,$2,1
	subu	$21,$21,$2
	li	$2,118			# 0x00000076
	subu	$2,$2,$16
	addu	$6,$2,15
	addu	$3,$17,3
	sh	$3,32($sp)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L685
	move	$2,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L686
	addu	$2,$2,12
	.set	macro
	.set	reorder

$L685:
	addu	$2,$2,15
$L686:
	sh	$2,34($sp)
	sll	$2,$19,16
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L687
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L688
	addu	$2,$2,12
	.set	macro
	.set	reorder

$L687:
	addu	$2,$2,80
$L688:
	sh	$2,36($sp)
	sll	$2,$19,16
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L689
	sra	$2,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L690
	addu	$2,$2,80
	.set	macro
	.set	reorder

$L689:
	addu	$2,$2,150
$L690:
	move	$22,$6
	li	$4,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	sh	$2,38($sp)
	.set	macro
	.set	reorder

	lw	$8,172($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L691
	li	$4,71			# 0x00000047
	.set	macro
	.set	reorder

	li	$4,72			# 0x00000048
$L691:
	jal	TextSys_Word__Fi
	move	$4,$2
	sll	$5,$21,16
	sra	$5,$5,16
	sll	$6,$16,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	sra	$6,$6,16
	.set	macro
	.set	reorder

	beq	$20,$0,$L693
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	sll	$6,$22,16
	sra	$6,$6,16
	lui	$3,%hi(Cars_gRaceCarList) # high
	lhu	$8,80($sp)
	addiu	$3,$3,%lo(Cars_gRaceCarList) # low
	sll	$2,$8,16
	sra	$2,$2,14
	addu	$2,$2,$3
	lw	$2,0($2)
	addu	$22,$22,12
	lw	$4,648($2)
	lh	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$4,$4,92
	.set	macro
	.set	reorder

$L693:
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	bne	$fp,$0,$L694
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,74			# 0x0000004a
	.set	macro
	.set	reorder

	move	$4,$2
	lh	$5,34($sp)
	sll	$6,$22,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L694:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,75			# 0x0000004b
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$16,$22,16
	sra	$16,$16,16
	move	$6,$16
	lh	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	li	$21,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,76			# 0x0000004c
	.set	macro
	.set	reorder

	move	$4,$2
	lh	$5,38($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$16,$16,15
	move	$6,$16
	lhu	$8,96($sp)
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	sll	$5,$8,16
	lhu	$8,104($sp)
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	move	$7,$8
	.set	macro
	.set	reorder

	sll	$2,$23,16
	lhu	$8,112($sp)
	sra	$17,$2,16
	sll	$2,$8,16
	sra	$18,$2,16
	subu	$19,$16,$18
	sll	$2,$21,16
$L722:
	sra	$2,$2,15
	addu	$2,$sp,$2
	lh	$2,32($2)
	lw	$8,172($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L699
	addu	$5,$2,-2
	.set	macro
	.set	reorder

	addu	$2,$18,-8
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L700
	subu	$2,$17,$2
	.set	macro
	.set	reorder

$L699:
	subu	$2,$17,$19
$L700:
	lw	$8,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L721
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$2,$2,-16
$L721:
	move	$6,$16
	li	$7,1			# 0x00000001
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	addu	$2,$21,1
	move	$21,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L722
	sll	$2,$21,16
	.set	macro
	.set	reorder

	lw	$8,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L703
	sll	$3,$22,16
	.set	macro
	.set	reorder

	lhu	$8,96($sp)
	#nop
	sll	$2,$8,16
	sra	$5,$2,16
	sra	$3,$3,16
	addu	$3,$3,15
	sll	$2,$23,16
	sra	$2,$2,16
	lhu	$8,112($sp)
	addu	$4,$3,$2
	sll	$2,$8,16
	sra	$2,$2,16
	lw	$8,172($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L704
	subu	$3,$3,$2
	.set	macro
	.set	reorder

	subu	$2,$4,$3
	.set	noreorder
	.set	nomacro
	j	$L705
	addu	$6,$2,-24
	.set	macro
	.set	reorder

$L704:
	subu	$2,$4,$3
	addu	$6,$2,-16
$L705:
	move	$4,$0
	lhu	$8,104($sp)
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	move	$7,$8
	.set	macro
	.set	reorder

$L703:
	addu	$4,$22,15
	move	$22,$4
	lhu	$8,80($sp)
	la	$3,Hud_NextPerp
	sll	$5,$8,16
	sra	$2,$5,15
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L707
	move	$21,$0
	.set	macro
	.set	reorder

	addu	$20,$sp,40
	sll	$2,$4,16
	sra	$2,$2,16
	sw	$2,120($sp)
	sra	$19,$5,16
$L724:
	sll	$18,$19,2
	lui	$8,%hi(StatsTimer) # high
	addiu	$8,$8,%lo(StatsTimer) # low
	addu	$3,$18,$8
	sll	$2,$21,16
	sra	$16,$2,16
	sll	$17,$16,1
	lw	$3,0($3)
	addu	$2,$17,4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	addu	$3,$21,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$20
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$16,1
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$2,$17,$16
	sll	$2,$2,2
	lw	$8,120($sp)
	lh	$5,32($sp)
	addu	$17,$8,$2
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$fp,$0,$L711
	lui	$5,%hi($LC1) # high
	.set	macro
	.set	reorder

	move	$4,$20
	addiu	$5,$5,%lo($LC1) # low
	addu	$2,$18,$19
	sll	$2,$2,5
	sll	$6,$16,4
	lui	$8,%hi(BTCPerpInfo) # high
	addiu	$8,$8,%lo(BTCPerpInfo) # low
	addu	$6,$6,$8
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	move	$4,$20
	lh	$5,34($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

$L711:
	sll	$16,$16,4
	addu	$2,$18,$19
	sll	$2,$2,5
	addu	$16,$16,$2
	lui	$8,%hi(BTCPerpInfo) # high
	addiu	$8,$8,%lo(BTCPerpInfo) # low
	addu	$16,$16,$8
	lw	$4,8($16)
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	move	$5,$20
	.set	macro
	.set	reorder

	move	$4,$20
	lh	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L712
	li	$4,73			# 0x00000049
	.set	macro
	.set	reorder

	li	$4,61			# 0x0000003d
$L712:
	jal	TextSys_Word__Fi
	move	$4,$2
	lh	$5,38($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$3,$21,1
$L723:
	move	$21,$3
	la	$2,Hud_NextPerp
	lhu	$8,80($sp)
	sll	$3,$3,16
	sll	$5,$8,16
	sra	$4,$5,15
	addu	$4,$4,$2
	lh	$2,0($4)
	sra	$3,$3,16
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L724
	sra	$19,$5,16
	.set	macro
	.set	reorder

$L707:
	lw	$8,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L715
	lui	$2,%hi(StatsTimer) # high
	.set	macro
	.set	reorder

	lhu	$8,80($sp)
	addiu	$2,$2,%lo(StatsTimer) # low
	sll	$3,$8,16
	sra	$3,$3,14
	addu	$3,$3,$2
	sll	$2,$21,16
	sra	$18,$2,16
	sll	$17,$18,1
	lw	$3,0($3)
	addu	$2,$17,4
	slt	$2,$2,$3
	beq	$2,$0,$L715
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$16,$sp,40
	lw	$4,FinalBTC_Countdown
	.set	noreorder
	.set	nomacro
	jal	Hud_ParseTime__FiPc
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,77			# 0x0000004d
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$6,$22,16
	sra	$6,$6,16
	addu	$2,$17,$18
	sll	$2,$2,2
	addu	$6,$6,$2
	lh	$5,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$6,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L716
	move	$4,$16
	.set	macro
	.set	reorder

	lh	$5,38($sp)
	.set	noreorder
	.set	nomacro
	j	$L719
	sll	$6,$22,16
	.set	macro
	.set	reorder

$L716:
	lh	$5,36($sp)
	sll	$6,$22,16
$L719:
	sra	$6,$6,16
	sll	$3,$21,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	addu	$6,$6,2
	.set	macro
	.set	reorder

$L715:
	lw	$8,172($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L718
	sll	$7,$23,16
	.set	macro
	.set	reorder

	lhu	$8,96($sp)
	sra	$7,$7,16
	sll	$4,$8,16
	lhu	$8,112($sp)
	sra	$4,$4,16
	sll	$5,$8,16
	lhu	$8,104($sp)
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	OptionsBarThing__Fiiii
	move	$6,$8
	.set	macro
	.set	reorder

$L718:
	sll	$7,$23,16
	lhu	$8,96($sp)
	sra	$7,$7,16
	sll	$4,$8,16
	lhu	$8,112($sp)
	sra	$4,$4,16
	sll	$5,$8,16
	lhu	$8,104($sp)
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	Hud_RenderPauseBox__Fiiii
	move	$6,$8
	.set	macro
	.set	reorder

	lw	$31,164($sp)
	lw	$fp,160($sp)
	lw	$23,156($sp)
	lw	$22,152($sp)
	lw	$21,148($sp)
	lw	$20,144($sp)
	lw	$19,140($sp)
	lw	$18,136($sp)
	lw	$17,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,168
	.set	macro
	.set	reorder

	.end	Hud_BTCStats__Fsb
	.text
	.ent	Hud_RenderStatsView__Fv
Hud_RenderStatsView__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lui	$4,%hi(Cars_gHumanRaceCarList) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,%lo(Cars_gHumanRaceCarList)($4)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sra	$3,$3,9
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	andi	$4,$3,0x0001
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L758
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

$L729:
	.set	noreorder
	.set	nomacro
	j	$L730
	move	$4,$0
	.set	macro
	.set	reorder

$L726:
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$2,%lo(GameSetup_gData+12)($2)
	li	$3,1			# 0x00000001
	bne	$2,$3,$L732
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
$L758:
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L733
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L759
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L730
	move	$4,$0
	.set	macro
	.set	reorder

$L733:
	lw	$2,4($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

$L759:
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L739
	lh	$2,Hud_NextPerp
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L729
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L729
$L737:
	lw	$2,D_8010FA4C
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L730
	lh	$2,Hud_NextPerp+2
	#nop
	beq	$2,$0,$L730
	.set	noreorder
	.set	nomacro
	j	$L730
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L732:
	lw	$2,Cars_gNumRaceCars
	#nop
	bne	$2,$3,$L730
$L739:
	li	$4,1			# 0x00000001
$L730:
	bne	$4,$0,$L746
	lw	$2,StatsTimer
	sw	$0,D_8013D99C
	addu	$2,$2,1
	move	$3,$2
	slt	$2,$3,10001
	sw	$3,StatsTimer
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	li	$3,10000			# 0x00002710
$L760:
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	sw	$3,StatsTimer
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L761
	move	$4,$0
	.set	macro
	.set	reorder

	jal	RaceSummary__Fv
	j	$L725
$L746:
	lw	$2,D_8013D99C
	sw	$0,StatsTimer
	addu	$2,$2,1
	move	$3,$2
	slt	$2,$3,10001
	sw	$3,D_8013D99C
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L762
	lui	$2,%hi(Cars_gHumanRaceCarList+4) # high
	.set	macro
	.set	reorder

	li	$3,10000			# 0x00002710
$L762:
	lw	$2,%lo(Cars_gHumanRaceCarList+4)($2)
	sw	$3,D_8013D99C
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L754
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L754
	move	$4,$2
	.set	macro
	.set	reorder

$L757:
$L761:
	.set	noreorder
	.set	nomacro
	jal	Hud_BTCStats__Fsb
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L725
$L754:
	jal	RaceStatistics__Fv
$L725:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Hud_RenderStatsView__Fv
