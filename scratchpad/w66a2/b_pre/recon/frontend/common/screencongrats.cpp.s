	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screencongrats.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Cleanup__15tScreenCongrats
	.ent	Cleanup__15tScreenCongrats
Cleanup__15tScreenCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CleanupSpinningCarsMenu__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cleanup__15tScreenCongrats
	.rdata
	.align	2
$LC0:
	.ascii	"%s%d\000"
	.align	2
$LC1:
	.ascii	"zcong\000"
	.align	2
$LC2:
	.ascii	"zelim\000"
	.align	2
$LC3:
	.ascii	"congb\000"
	.align	2
$LC4:
	.ascii	"\000"
	.text
	.align	2
	.globl	GetShapeInfo__15tScreenCongratsRsT1PPcT3
	.ent	GetShapeInfo__15tScreenCongratsRsT1PPcT3
GetShapeInfo__15tScreenCongratsRsT1PPcT3:
	.frame	$sp,64,$31		# vars= 0, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,36($sp)
	move	$19,$4
	move	$8,$5
	sw	$23,52($sp)
	move	$23,$6
	sw	$16,24($sp)
	move	$16,$7
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	sw	$31,56($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	sw	$0,116($19)
	sw	$0,112($19)
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$20,$5,$2
	lw	$2,100($19)
	lw	$22,80($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	li	$4,22			# 0x00000016
	.set	macro
	.set	reorder

	li	$4,43			# 0x0000002b
$L602:
	lui	$2,%hi(fPermFileNameBuf) # high
	sh	$4,0($8)
	addiu	$4,$2,%lo(fPermFileNameBuf) # low
	lui	$2,%hi($LC0) # high
	lw	$3,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L604
	addiu	$5,$2,%lo($LC0) # low
	.set	macro
	.set	reorder

	lui	$2,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$L605
	addiu	$6,$2,%lo($LC1) # low
	.set	macro
	.set	reorder

$L604:
	lui	$2,%hi($LC2) # high
	addiu	$6,$2,%lo($LC2) # low
$L605:
	lui	$2,%hi(frontEnd+832) # high
	lbu	$7,%lo(frontEnd+832)($2)
	jal	sprintf
	lui	$2,%hi(fPermFileNameBuf) # high
	addiu	$2,$2,%lo(fPermFileNameBuf) # low
	sw	$2,0($16)
	lw	$2,104($19)
	#nop
	addu	$2,$2,-3
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$18,900			# 0x00000384
	lui	$4,%hi(tournamentManager) # high
	addiu	$2,$4,%lo(tournamentManager) # low
	lbu	$3,5($20)
	lh	$2,16($2)
	sltu	$3,$0,$3
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L621
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$21,$4
	move	$17,$2
	addiu	$4,$21,%lo(tournamentManager) # low
$L620:
	sll	$5,$16,16
	.set	noreorder
	.set	nomacro
	jal	PlayerRanking__18tTournamentManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bne	$2,$0,$L611
	move	$18,$16
$L611:
	addu	$16,$16,1
	slt	$2,$17,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L620
	addiu	$4,$21,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
$L621:
	addiu	$4,$4,%lo(tournamentManager) # low
	move	$5,$20
	li	$6,2			# 0x00000002
	lui	$16,%hi(congratsSwapFileName) # high
	addiu	$16,$16,%lo(congratsSwapFileName) # low
	move	$7,$16
	.set	noreorder
	.set	nomacro
	jal	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	sw	$18,16($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sw	$16,0($22)
	sh	$2,0($23)
	li	$2,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	j	$L601
	sw	$2,112($19)
	.set	macro
	.set	reorder

$L606:
	lw	$3,108($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L615
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L616
	lui	$2,%hi($LC4) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L617
	addiu	$2,$2,%lo($LC4) # low
	.set	macro
	.set	reorder

$L615:
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	move	$5,$20
	move	$6,$0
	lui	$16,%hi(congratsSwapFileName) # high
	addiu	$16,$16,%lo(congratsSwapFileName) # low
	move	$7,$16
	li	$2,32			# 0x00000020
	sh	$2,0($23)
	li	$2,32			# 0x00000020
	sw	$2,116($19)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L601
	sw	$16,0($22)
	.set	macro
	.set	reorder

$L616:
	li	$2,10			# 0x0000000a
	sh	$2,0($23)
	li	$2,10			# 0x0000000a
	sw	$2,116($19)
	lui	$2,%hi($LC3) # high
	addiu	$2,$2,%lo($LC3) # low
	.set	noreorder
	.set	nomacro
	j	$L601
	sw	$2,0($22)
	.set	macro
	.set	reorder

$L617:
	sw	$2,0($22)
	sh	$0,0($23)
$L601:
	lw	$31,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	GetShapeInfo__15tScreenCongratsRsT1PPcT3
	.align	2
	.globl	GetCar__15tScreenCongratsR8tCarInfo
	.ent	GetCar__15tScreenCongratsR8tCarInfo
GetCar__15tScreenCongratsR8tCarInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	lui	$4,%hi(carManager) # high
	lui	$2,%hi(frontEnd+291) # high
	addiu	$4,$4,%lo(carManager) # low
	move	$6,$16
	lbu	$5,%lo(frontEnd+291)($2)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,197($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,175($2)
	#nop
	sb	$2,197($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetCar__15tScreenCongratsR8tCarInfo

	.lcomm	carRotate.232,4
	.align	2
	.globl	DrawBackground__15tScreenCongrats
	.ent	DrawBackground__15tScreenCongrats
DrawBackground__15tScreenCongrats:
	.frame	$sp,136,$31		# vars= 72, regs= 6/0, args= 40, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$19,124($sp)
	move	$19,$4
	sw	$31,132($sp)
	sw	$20,128($sp)
	sw	$18,120($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	lw	$2,84($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L625
	move	$20,$0
	.set	macro
	.set	reorder

	lh	$20,92($19)
$L625:
	lw	$2,40($19)
	#nop
	sw	$2,60($sp)
	lw	$2,40($19)
	lui	$3,%hi(carRotate.232) # high
	sw	$2,84($sp)
	lw	$5,96($19)
	lw	$2,%lo(carRotate.232)($3)
	lh	$4,88($5)
	addu	$2,$2,3
	sw	$2,%lo(carRotate.232)($3)
	lw	$2,92($5)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

	lw	$4,104($19)
	li	$5,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$4,$5,$L628
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,136($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L697
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

$L628:
	lw	$2,352($19)
	#nop
	bne	$2,$0,$L629
	.set	noreorder
	.set	nomacro
	beq	$4,$5,$L697
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

$L629:
	.set	noreorder
	.set	nomacro
	bne	$4,$5,$L626
	lui	$2,%hi(R3DCar_aSyncLoading) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(R3DCar_aSyncLoading)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L697
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,356($19)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,60
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

$L697:
	lw	$2,%lo(ticks)($2)
	.set	noreorder
	.set	nomacro
	j	$L630
	sw	$2,136($19)
	.set	macro
	.set	reorder

$L626:
	lw	$2,136($19)
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L631
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,136($19)
$L631:
	lw	$4,128($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L632
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,136($19)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,1001
	beq	$2,$0,$L634
	lw	$2,364($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	lui	$3,%hi(kRGBVals) # high
	.set	macro
	.set	reorder

$L634:
	beq	$4,$0,$L635
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

$L635:
	lw	$2,128($19)
	lw	$3,368($19)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L633
	sw	$2,128($19)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$0,128($19)
	sw	$2,360($19)
$L633:
	lui	$3,%hi(kRGBVals) # high
$L698:
	lui	$2,%hi(textDefinitions+71) # high
	addiu	$3,$3,%lo(kRGBVals) # low
	lbu	$2,%lo(textDefinitions+71)($2)
	lh	$5,92($19)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	jal	CalcFadeVal__Fii
	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	lh	$5,92($19)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$18,$2
	.set	macro
	.set	reorder

	li	$5,791			# 0x00000317
	li	$6,2			# 0x00000002
	li	$7,11			# 0x0000000b
	lh	$4,92($19)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	move	$17,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,792			# 0x00000318
	.set	macro
	.set	reorder

	li	$4,792			# 0x00000318
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	sw	$18,16($sp)
	sw	$17,20($sp)
	lw	$7,128($19)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$5,790			# 0x00000316
	li	$6,2			# 0x00000002
	lh	$4,92($19)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType
	li	$7,11			# 0x0000000b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,793			# 0x00000319
	.set	macro
	.set	reorder

	li	$4,793			# 0x00000319
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	lw	$2,124($19)
	lw	$7,128($19)
	li	$6,9			# 0x00000009
	sw	$18,16($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	subu	$7,$2,$7
	.set	macro
	.set	reorder

$L632:
	lw	$5,372($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L637
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(ticks)($2)
	lw	$3,136($19)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,129
	bne	$2,$0,$L637
	.set	noreorder
	.set	nomacro
	jal	FeAudio_AsyncPlaySpeech__Fii
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$0,372($19)
$L637:
	lw	$2,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	move	$16,$0
	.set	macro
	.set	reorder

	lh	$5,92($19)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	sw	$2,68($sp)
	lw	$2,140($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	li	$4,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,144($19)
	ori	$4,$4,0xaaab
	subu	$2,$2,$3
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$2,$8,$2
	addu	$2,$2,21
	sw	$2,132($19)
	slt	$2,$2,42
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,20			# 0x00000014
	sw	$0,140($19)
	.set	noreorder
	.set	nomacro
	j	$L645
	sw	$2,132($19)
	.set	macro
	.set	reorder

$L639:
	lui	$5,%hi(ticks) # high
	lw	$2,%lo(ticks)($5)
	lw	$3,136($19)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,132($19)
	slt	$2,$2,20
	bne	$2,$0,$L645
 #APP
 #NO_APP
	li	$16,1			# 0x00000001
 #APP
 #NO_APP
	lw	$3,136($19)
	lw	$4,%lo(ticks)($5)
	li	$2,20			# 0x00000014
	.set	noreorder
	.set	nomacro
	bgez	$3,$L644
	sw	$2,132($19)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L644:
	li	$2,91619328			# 0x05760000
	ori	$2,$2,0x19f1
	sra	$3,$3,2
	subu	$3,$4,$3
	mult	$3,$2
	sra	$2,$3,31
	mfhi	$8
	#nop
	#nop
	sra	$4,$8,5
	subu	$4,$4,$2
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,4
	subu	$2,$2,$4
	sll	$2,$2,3
	subu	$2,$2,$4
	sll	$2,$2,2
	subu	$3,$3,$2
	slt	$3,$3,45
	beq	$3,$0,$L645
	lw	$2,%lo(ticks)($5)
	sw	$16,140($19)
	.set	noreorder
	.set	nomacro
	j	$L645
	sw	$2,144($19)
	.set	macro
	.set	reorder

$L638:
	li	$4,6553600			# 0x00640000
	ori	$4,$4,0x6464
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$5,$20
	.set	macro
	.set	reorder

	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x8080
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	sw	$2,68($sp)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	lw	$2,136($19)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L646
	addu	$2,$2,3
$L646:
	sra	$2,$2,2
	sw	$2,132($19)
	slt	$2,$2,21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	sw	$2,132($19)
$L647:
 #APP
 #NO_APP
$L645:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L648
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L649
	move	$7,$0
	.set	macro
	.set	reorder

	li	$7,10			# 0x0000000a
$L649:
	li	$5,1040			# 0x00000410
	addu	$2,$sp,40
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	lw	$4,132($19)
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	move	$6,$0
	.set	macro
	.set	reorder

	j	$L651
$L648:
	lw	$3,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L652
	move	$7,$0
	.set	macro
	.set	reorder

	li	$7,10			# 0x0000000a
$L652:
	li	$5,1040			# 0x00000410
	addu	$2,$sp,40
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	lw	$4,132($19)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	move	$6,$0
	.set	macro
	.set	reorder

$L651:
	lw	$2,104($19)
	#nop
	addu	$2,$2,-3
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	li	$3,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	ori	$3,$3,0xaaab
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,1
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L655
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,31
$L655:
	sra	$4,$4,5
	sll	$4,$4,5
	subu	$4,$3,$4
	li	$5,1552			# 0x00000610
	li	$6,70			# 0x00000046
	li	$7,15			# 0x0000000f
	addu	$2,$sp,64
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L654:
	lw	$2,104($19)
	#nop
	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,108($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L658
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L659
	li	$3,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	j	$L630
$L658:
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,116($19)
	sra	$2,$2,3
	rem	$4,$2,$3
	li	$5,1552			# 0x00000610
	li	$6,41			# 0x00000029
	li	$7,190			# 0x000000be
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$2,$sp,64
	.set	noreorder
	.set	nomacro
	jal	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L630
$L659:
	lui	$2,%hi(ticks) # high
	lw	$4,%lo(ticks)($2)
	ori	$3,$3,0x6667
	mult	$4,$3
	li	$2,5570560			# 0x00550000
	ori	$2,$2,0x1e00
	sw	$2,44($sp)
	sra	$4,$4,31
	mfhi	$3
	#nop
	#nop
	sra	$2,$3,3
	lw	$3,116($19)
	subu	$2,$2,$4
	rem	$4,$2,$3
	li	$5,1552			# 0x00000610
	li	$6,-193			# 0xffffff3f
	li	$7,86			# 0x00000056
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$2,$sp,40
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L630:
	lw	$2,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	li	$4,196608			# 0x00030000
	.set	macro
	.set	reorder

	lw	$3,104($19)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L666
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L670
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L665
	ori	$4,$4,0x0022
	.set	macro
	.set	reorder

	j	$L671
$L670:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L667
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L662
	li	$4,196608			# 0x00030000
	.set	macro
	.set	reorder

$L665:
	.set	noreorder
	.set	nomacro
	j	$L671
	li	$4,15940			# 0x00003e44
	.set	macro
	.set	reorder

$L666:
	li	$4,2162688			# 0x00210000
	.set	noreorder
	.set	nomacro
	j	$L671
	ori	$4,$4,0x2121
	.set	macro
	.set	reorder

$L667:
	.set	noreorder
	.set	nomacro
	j	$L671
	li	$4,12356			# 0x00003044
	.set	macro
	.set	reorder

$L662:
$L696:
	ori	$4,$4,0x0022
$L671:
	lw	$2,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L672
	li	$17,21			# 0x00000015
	.set	macro
	.set	reorder

	li	$17,42			# 0x0000002a
$L672:
	lh	$5,92($19)
	jal	CalcFadeVal__Fii
	sw	$2,92($sp)
	lw	$2,100($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	li	$16,7			# 0x00000007
	.set	macro
	.set	reorder

	lw	$3,104($19)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L674
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$18,1431633920			# 0x55550000
	ori	$18,$18,0x5556
	move	$20,$16
	mult	$16,$18
$L700:
	sra	$3,$16,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L677
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,1040			# 0x00000410
	sll	$6,$16,1
	move	$7,$0
	lh	$3,92($19)
	addu	$2,$sp,88
	sw	$20,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L677:
	addu	$16,$16,1
	slt	$2,$16,30
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	mult	$16,$18
	.set	macro
	.set	reorder

	li	$16,34			# 0x00000022
	li	$18,1431633920			# 0x55550000
	ori	$18,$18,0x5556
	li	$20,1			# 0x00000001
	mult	$16,$18
$L701:
	sra	$3,$16,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L683
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,1040			# 0x00000410
	sll	$6,$16,1
	move	$7,$0
	lh	$3,92($19)
	addu	$2,$sp,88
	sw	$20,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L683:
	addu	$16,$16,1
	slt	$2,$16,63
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	mult	$16,$18
	.set	macro
	.set	reorder

	j	$L687
$L674:
	li	$16,7			# 0x00000007
$L699:
	li	$18,1431633920			# 0x55550000
	ori	$18,$18,0x5556
	li	$20,1			# 0x00000001
	mult	$16,$18
$L702:
	sra	$3,$16,31
	mfhi	$8
	#nop
	#nop
	subu	$3,$8,$3
	sll	$2,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L690
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,1040			# 0x00000410
	sll	$6,$16,1
	move	$7,$0
	lh	$3,92($19)
	addu	$2,$sp,88
	sw	$20,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L690:
	addu	$16,$16,1
	slt	$2,$16,40
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L702
	mult	$16,$18
	.set	macro
	.set	reorder

$L687:
	lw	$3,104($19)
	li	$2,3			# 0x00000003
	bne	$3,$2,$L624
	lw	$2,352($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	lui	$2,%hi(showRoomFlag) # high
	.set	macro
	.set	reorder

	lh	$5,376($19)
	lh	$6,378($19)
	lw	$7,384($19)
	sw	$0,%lo(showRoomFlag)($2)
	li	$2,128			# 0x00000080
	sw	$2,20($sp)
	lui	$2,%hi(carRotate.232) # high
	lw	$3,%lo(carRotate.232)($2)
	li	$2,1			# 0x00000001
	sw	$2,24($sp)
	sw	$7,16($sp)
	sw	$3,28($sp)
	lw	$2,120($19)
	#nop
	sw	$2,32($sp)
	lw	$7,380($19)
	.set	noreorder
	.set	nomacro
	jal	DrawCar__FR8tCarInfossffcbUl7tPlayer
	addu	$4,$19,148
	.set	macro
	.set	reorder

$L624:
	lw	$31,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	DrawBackground__15tScreenCongrats
	.align	2
	.globl	DrawForeground__15tScreenCongrats
	.ent	DrawForeground__15tScreenCongrats
DrawForeground__15tScreenCongrats:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DrawForeground__15tScreenCongrats
	.align	2
	.globl	CalculatePrizes__15tScreenCongrats
	.ent	CalculatePrizes__15tScreenCongrats
CalculatePrizes__15tScreenCongrats:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,1082130432			# 0x40800000
	li	$3,-1058275328			# 0xc0ec0000
	ori	$3,$3,0xcccd
	li	$2,4			# 0x00000004
	sw	$2,104($4)
	li	$2,-1			# 0xffffffff
	sw	$2,128($4)
	li	$2,278			# 0x00000116
	sh	$2,376($4)
	li	$2,63			# 0x0000003f
	sw	$0,100($4)
	sh	$2,378($4)
	sw	$3,384($4)
	lw	$3,100($4)
	li	$2,1			# 0x00000001
	sw	$0,108($4)
	sw	$0,120($4)
	sw	$0,124($4)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L706
	sw	$5,380($4)
	.set	macro
	.set	reorder

	li.s	$3,-8.19999980926513671875e0
	li	$2,288			# 0x00000120
	sh	$2,376($4)
	li	$2,73			# 0x00000049
	sh	$2,378($4)
	sw	$3,384($4)
$L706:
 #APP
 #NO_APP
	j	$31
	.end	CalculatePrizes__15tScreenCongrats
	.align	2
	.globl	Initialize__15tScreenCongrats
	.ent	Initialize__15tScreenCongrats
Initialize__15tScreenCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,-1			# 0xffffffff
	sw	$31,20($sp)
	sw	$0,372($16)
	sw	$2,136($16)
	sw	$2,132($16)
	sw	$0,140($16)
	.set	noreorder
	.set	nomacro
	jal	SetLicensePlate__Fv
	sw	$3,356($16)
	.set	macro
	.set	reorder

	lw	$2,96($16)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lw	$2,96($16)
	addu	$5,$16,148
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lw	$3,128($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L709
	sw	$2,352($16)
	.set	macro
	.set	reorder

	move	$2,$3
	sw	$0,360($16)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L710
	sw	$0,364($16)
	.set	macro
	.set	reorder

	addu	$2,$2,63
$L710:
	.set	noreorder
	.set	nomacro
	j	$L713
	sra	$2,$2,6
	.set	macro
	.set	reorder

$L709:
	li	$2,1			# 0x00000001
	sw	$2,360($16)
	sw	$2,364($16)
	li	$2,1000			# 0x000003e8
$L713:
	sw	$2,368($16)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__15tScreenCongrats
	.align	2
	.globl	ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($6)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L720
	lui	$2,%hi(ginfo+16) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(ginfo+16)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L717
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,136($4)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,150
	beq	$2,$0,$L716
$L717:
	li	$5,1			# 0x00000001
$L716:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L720
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($6)
$L720:
	j	$31
	.end	ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	DrawCongratsMessage__23tScreenPinkSlipCongrats
	.ent	DrawCongratsMessage__23tScreenPinkSlipCongrats
DrawCongratsMessage__23tScreenPinkSlipCongrats:
	.frame	$sp,312,$31		# vars= 264, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,312
	sw	$19,300($sp)
	move	$19,$4
	li	$2,41			# 0x00000029
	sh	$2,24($sp)
	li	$2,60			# 0x0000003c
	sh	$2,26($sp)
	li	$2,420			# 0x000001a4
	sh	$2,28($sp)
	lui	$2,%hi(frontEnd+832) # high
	lbu	$2,%lo(frontEnd+832)($2)
	li	$3,200			# 0x000000c8
	sw	$31,304($sp)
	sw	$18,296($sp)
	sw	$17,292($sp)
	sw	$16,288($sp)
	addu	$2,$2,-2
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L722
	sh	$3,30($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,629			# 0x00000275
	.set	macro
	.set	reorder

	lh	$4,388($19)
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$18,$2
	.set	macro
	.set	reorder

	lb	$4,148($19)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,289
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lh	$3,388($19)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	subu	$4,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L726
	addu	$4,$sp,32
	.set	macro
	.set	reorder

$L722:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,629			# 0x00000275
	.set	macro
	.set	reorder

	lh	$4,388($19)
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$18,$2
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lh	$3,388($19)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	subu	$4,$4,$3
	.set	macro
	.set	reorder

	lb	$4,148($19)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,289
	.set	macro
	.set	reorder

	addu	$4,$sp,32
$L726:
	move	$5,$18
	move	$6,$17
	sw	$2,16($sp)
	lh	$2,388($19)
	move	$7,$16
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	addu	$5,$sp,24
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$31,304($sp)
	lw	$19,300($sp)
	lw	$18,296($sp)
	lw	$17,292($sp)
	lw	$16,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,312
	.set	macro
	.set	reorder

	.end	DrawCongratsMessage__23tScreenPinkSlipCongrats
	.align	2
	.globl	GetCar__23tScreenPinkSlipCongratsR8tCarInfo
	.ent	GetCar__23tScreenPinkSlipCongratsR8tCarInfo
GetCar__23tScreenPinkSlipCongratsR8tCarInfo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	lui	$6,%hi(carManager) # high
	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	li	$7,1			# 0x00000001
	sw	$31,20($sp)
	lh	$5,388($4)
	lhu	$2,388($4)
	addiu	$4,$6,%lo(carManager) # low
	move	$6,$16
	subu	$5,$7,$5
	addu	$5,$5,$3
	subu	$7,$7,$2
	sll	$7,$7,16
	lbu	$5,293($5)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	sra	$7,$7,16
	.set	macro
	.set	reorder

	lbu	$2,197($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,175($2)
	#nop
	sb	$2,197($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetCar__23tScreenPinkSlipCongratsR8tCarInfo
	.align	2
	.globl	CalculatePrizes__23tScreenPinkSlipCongrats
	.ent	CalculatePrizes__23tScreenPinkSlipCongrats
CalculatePrizes__23tScreenPinkSlipCongrats:
	.frame	$sp,248,$31		# vars= 208, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$19,236($sp)
	move	$19,$4
	sw	$18,232($sp)
	li	$18,-1			# 0xffffffff
	sw	$31,240($sp)
	sw	$17,228($sp)
	sw	$16,224($sp)
	lh	$17,388($19)
	li	$2,3			# 0x00000003
	sw	$2,104($19)
	li	$2,2			# 0x00000002
	sw	$2,108($19)
	lh	$2,388($19)
	li	$16,1			# 0x00000001
	sw	$0,124($19)
	sw	$18,128($19)
	sw	$0,100($19)
	subu	$17,$16,$17
	move	$4,$17
	subu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	jal	CarIO_CleanUpLicense__Fi
	sw	$2,120($19)
	.set	macro
	.set	reorder

	subu	$16,$16,$17
	sll	$16,$16,3
	lui	$4,%hi(frontEnd+900) # high
	addiu	$4,$4,%lo(frontEnd+900) # low
	addu	$4,$16,$4
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CarIO_CreateLicense__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

	lw	$2,96($19)
	addu	$5,$sp,16
	lh	$4,96($2)
	lw	$2,100($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

	lb	$3,209($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$18,$L730
	sll	$3,$3,1
	.set	macro
	.set	reorder

	lh	$2,388($19)
	#nop
	addu	$2,$2,19
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L731
	sw	$3,372($19)
	.set	macro
	.set	reorder

$L730:
	lh	$2,388($19)
	#nop
	addu	$2,$2,23
	sw	$2,372($19)
$L731:
	li.s	$3,4.00000000000000000000e0
	li.s	$4,-7.40000009536743164062e0
	li	$2,278			# 0x00000116
	sh	$2,376($19)
	li	$2,75			# 0x0000004b
	sh	$2,378($19)
	sw	$3,380($19)
	sw	$4,384($19)
	lw	$31,240($sp)
	lw	$19,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,248
	.set	macro
	.set	reorder

	.end	CalculatePrizes__23tScreenPinkSlipCongrats
	.align	2
	.globl	Initialize__23tScreenPinkSlipCongrats
	.ent	Initialize__23tScreenPinkSlipCongrats
Initialize__23tScreenPinkSlipCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,-1			# 0xffffffff
	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	sw	$31,16($sp)
	sh	$2,388($4)
	lbu	$2,71($3)
	lbu	$3,72($3)
	srl	$2,$2,1
	addu	$2,$2,1
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L734
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L735
	sh	$0,388($4)
	.set	macro
	.set	reorder

$L734:
	sh	$2,388($4)
$L735:
	jal	Initialize__15tScreenCongrats
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__23tScreenPinkSlipCongrats
	.align	2
	.globl	Cleanup__23tScreenPinkSlipCongrats
	.ent	Cleanup__23tScreenPinkSlipCongrats
Cleanup__23tScreenPinkSlipCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CleanupSpinningCarsMenu__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cleanup__23tScreenPinkSlipCongrats
	.align	2
	.globl	ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($6)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L740
	lw	$2,360($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($6)
	sw	$2,364($4)
$L740:
	jal	ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	GetCar__23tScreenTournamentTrophyR8tCarInfo
	.ent	GetCar__23tScreenTournamentTrophyR8tCarInfo
GetCar__23tScreenTournamentTrophyR8tCarInfo:
	.frame	$sp,96,$31		# vars= 72, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$31,92($sp)
	sw	$16,88($sp)
	lw	$2,100($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	move	$16,$5
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	lh	$5,56($sp)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,204			# 0x000000cc
	.set	macro
	.set	reorder

	lbu	$2,61($sp)
	#nop
	sb	$2,196($16)
	lbu	$2,60($sp)
	.set	noreorder
	.set	nomacro
	j	$L747
	sb	$2,197($16)
	.set	macro
	.set	reorder

$L743:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	move	$6,$16
	lui	$2,%hi(frontEnd+291) # high
	lbu	$5,%lo(frontEnd+291)($2)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,197($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,175($2)
	#nop
	sb	$2,197($16)
$L747:
	lw	$31,92($sp)
	lw	$16,88($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	GetCar__23tScreenTournamentTrophyR8tCarInfo
	.align	2
	.globl	DrawCongratsMessage__23tScreenTournamentTrophy
	.ent	DrawCongratsMessage__23tScreenTournamentTrophy
DrawCongratsMessage__23tScreenTournamentTrophy:
	.frame	$sp,1456,$31		# vars= 1408, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,1456
	sw	$20,1448($sp)
	move	$20,$4
	li	$2,41			# 0x00000029
	sh	$2,24($sp)
	li	$2,60			# 0x0000003c
	sh	$2,26($sp)
	li	$2,200			# 0x000000c8
	sh	$2,28($sp)
	li	$2,400			# 0x00000190
	sw	$31,1452($sp)
	sw	$19,1444($sp)
	sw	$18,1440($sp)
	sw	$17,1436($sp)
	sw	$16,1432($sp)
	sh	$2,30($sp)
	lw	$2,100($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	lui	$4,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(tournamentManager) # low
	move	$18,$0
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	move	$19,$18
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	lb	$3,560($4)
	#nop
	slt	$3,$3,4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L750
	addu	$17,$5,$2
	.set	macro
	.set	reorder

	lb	$2,0($17)
	lw	$3,104($20)
	addu	$18,$2,947
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L754
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L757
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$3,$0,$L753
	.set	noreorder
	.set	nomacro
	j	$L751
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

$L757:
	bne	$3,$2,$L755
$L753:
	.set	noreorder
	.set	nomacro
	j	$L751
	move	$16,$0
	.set	macro
	.set	reorder

$L754:
	.set	noreorder
	.set	nomacro
	j	$L751
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L755:
	li	$16,2			# 0x00000002
$L751:
	lb	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,947
	.set	macro
	.set	reorder

	addu	$4,$16,993
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,104
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

$L750:
	lw	$4,104($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L769
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager+560) # high
	lb	$3,%lo(tournamentManager+560)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L759
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

$L769:
	bne	$4,$2,$L758
$L759:
	bne	$18,$0,$L761
	lb	$2,0($17)
	#nop
	addu	$18,$2,966
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L768
	addu	$4,$sp,104
	.set	macro
	.set	reorder

$L761:
	lb	$2,0($17)
	#nop
	addu	$19,$2,966
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$4,$sp,608
$L768:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

$L758:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L763
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	addu	$16,$sp,104
	move	$5,$16
	li	$7,1			# 0x00000001
	lh	$4,92($20)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lh	$4,28($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapHeight__FsPc
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,26($sp)
	#nop
	addu	$3,$3,$2
	sh	$3,26($sp)
$L763:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L764
	addu	$5,$sp,608
	.set	macro
	.set	reorder

	addu	$6,$sp,24
	li	$7,1			# 0x00000001
	lh	$4,92($20)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L764:
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$2,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	addu	$16,$sp,1368
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,68($sp)
	li	$2,260			# 0x00000104
	sh	$2,24($sp)
	li	$2,200			# 0x000000c8
	sh	$2,26($sp)
	li	$2,240			# 0x000000f0
	.set	noreorder
	.set	nomacro
	jal	FeTools_FormatMoney__FPcl
	sh	$2,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	addu	$4,$sp,1112
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	move	$5,$2
	addu	$6,$sp,24
	li	$7,1			# 0x00000001
	lh	$4,92($20)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	j	$L748
$L749:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,800			# 0x00000320
	.set	macro
	.set	reorder

	li	$4,800			# 0x00000320
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$2,-10
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,288			# 0x00000120
	sll	$16,$16,16
	sra	$6,$16,16
	li	$7,4259840			# 0x00410000
	ori	$7,$7,0x4141
	li	$2,3			# 0x00000003
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L748:
	lw	$31,1452($sp)
	lw	$20,1448($sp)
	lw	$19,1444($sp)
	lw	$18,1440($sp)
	lw	$17,1436($sp)
	lw	$16,1432($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,1456
	.set	macro
	.set	reorder

	.end	DrawCongratsMessage__23tScreenTournamentTrophy
	.align	2
	.globl	CalculatePrizes__23tScreenTournamentTrophy
	.ent	CalculatePrizes__23tScreenTournamentTrophy
CalculatePrizes__23tScreenTournamentTrophy:
	.frame	$sp,120,$31		# vars= 72, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$18,96($sp)
	move	$18,$4
	sw	$20,104($sp)
	lui	$20,%hi(tournamentManager) # high
	sw	$16,88($sp)
	addiu	$16,$20,%lo(tournamentManager) # low
	move	$4,$16
	addu	$5,$sp,16
	li	$2,1			# 0x00000001
	sw	$31,112($sp)
	sw	$21,108($sp)
	sw	$19,100($sp)
	sw	$17,92($sp)
	sw	$2,100($18)
	li	$2,4			# 0x00000004
	sw	$2,104($18)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	sw	$2,108($18)
	.set	macro
	.set	reorder

	li	$19,900			# 0x00000384
	lw	$3,4($16)
	lw	$4,24($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($16)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$21,$4,$2
	lbu	$3,5($21)
	lh	$2,16($16)
	sltu	$3,$0,$3
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L771
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	addiu	$4,$20,%lo(tournamentManager) # low
$L794:
	sll	$5,$17,16
	.set	noreorder
	.set	nomacro
	jal	PlayerRanking__18tTournamentManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bne	$2,$0,$L775
	move	$19,$17
$L775:
	addu	$17,$17,1
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L794
	addiu	$4,$20,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

$L771:
	li	$2,1			# 0x00000001
	beq	$19,$2,$L778
	.set	noreorder
	.set	nomacro
	blez	$19,$L780
	slt	$2,$19,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L782
$L778:
	lw	$2,44($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L783
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$2,104($18)
	.set	noreorder
	.set	nomacro
	j	$L784
	sw	$19,108($18)
	.set	macro
	.set	reorder

$L783:
	sw	$0,104($18)
	sw	$0,108($18)
$L784:
	li	$2,15			# 0x0000000f
	sw	$2,372($18)
	.set	noreorder
	.set	nomacro
	j	$L785
	sw	$0,100($18)
	.set	macro
	.set	reorder

$L782:
	lbu	$2,5($21)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L795
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$2,$19,14
	sw	$2,372($18)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L793
	sw	$0,100($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L793
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L780:
	li	$2,1			# 0x00000001
$L795:
	sw	$2,100($18)
	li	$2,3			# 0x00000003
$L793:
	sw	$2,104($18)
	sw	$0,108($18)
$L785:
 #APP
 #NO_APP
	lui	$2,%hi(tournamentManager+20) # high
	sw	$0,120($18)
	lw	$3,%lo(tournamentManager+20)($2)
	#nop
	sw	$3,124($18)
	lw	$2,76($sp)
	#nop
	beq	$2,$0,$L789
	lw	$2,80($sp)
	#nop
	subu	$2,$3,$2
	sw	$2,124($18)
$L789:
	lw	$2,20($sp)
	#nop
	bne	$2,$0,$L790
	li	$2,-1			# 0xffffffff
$L790:
 #APP
 #NO_APP
	li	$4,1082130432			# 0x40800000
 #APP
 #NO_APP
	li.s	$3,-7.40000009536743164062e0
	sw	$2,128($18)
	li	$2,278			# 0x00000116
	sh	$2,376($18)
	li	$2,63			# 0x0000003f
	sh	$2,378($18)
	sw	$3,384($18)
	lw	$3,100($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L770
	sw	$4,380($18)
	.set	macro
	.set	reorder

	li.s	$3,-8.19999980926513671875e0
	li	$2,288			# 0x00000120
	sh	$2,376($18)
	li	$2,73			# 0x00000049
	sh	$2,378($18)
	sw	$3,384($18)
$L770:
	lw	$31,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	CalculatePrizes__23tScreenTournamentTrophy
	.align	2
	.globl	GetCar__23tScreenBeTheCopCongratsR8tCarInfo
	.ent	GetCar__23tScreenBeTheCopCongratsR8tCarInfo
GetCar__23tScreenBeTheCopCongratsR8tCarInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$16,16($sp)
	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	lui	$4,%hi(carManager) # high
	sw	$31,24($sp)
	lbu	$5,301($16)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,204			# 0x000000cc
	.set	macro
	.set	reorder

	lbu	$3,302($16)
	#nop
	sb	$3,199($17)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	GetCar__23tScreenBeTheCopCongratsR8tCarInfo
	.align	2
	.globl	CalculatePrizes__23tScreenBeTheCopCongrats
	.ent	CalculatePrizes__23tScreenBeTheCopCongrats
CalculatePrizes__23tScreenBeTheCopCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CalculatePrizes__15tScreenCongrats
	move	$16,$4
	.set	macro
	.set	reorder

	li.s	$3,4.00000000000000000000e0
	li.s	$4,-7.40000009536743164062e0
	li	$2,3			# 0x00000003
	sw	$2,104($16)
	li	$2,278			# 0x00000116
	sh	$2,376($16)
	li	$2,75			# 0x0000004b
	sh	$2,378($16)
	sw	$3,380($16)
	sw	$4,384($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalculatePrizes__23tScreenBeTheCopCongrats
	.align	2
	.globl	DrawCongratsMessage__23tScreenBeTheCopCongrats
	.ent	DrawCongratsMessage__23tScreenBeTheCopCongrats
DrawCongratsMessage__23tScreenBeTheCopCongrats:
	.frame	$sp,296,$31		# vars= 264, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$17,284($sp)
	move	$17,$4
	sw	$16,280($sp)
	li	$16,76			# 0x0000004c
	li	$2,41			# 0x00000029
	sh	$2,16($sp)
	li	$2,60			# 0x0000003c
	sh	$2,18($sp)
	li	$2,200			# 0x000000c8
	sh	$2,20($sp)
	sh	$2,22($sp)
	lui	$2,%hi(frontEnd+301) # high
	lbu	$3,%lo(frontEnd+301)($2)
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L801
	sw	$31,288($sp)
	.set	macro
	.set	reorder

	li	$16,77			# 0x0000004d
$L801:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	beq	$2,$0,$L802
	lb	$4,148($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,289
	.set	macro
	.set	reorder

$L802:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	lb	$4,148($17)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,289
	.set	macro
	.set	reorder

	addu	$16,$sp,24
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,16
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$31,288($sp)
	lw	$17,284($sp)
	lw	$16,280($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	DrawCongratsMessage__23tScreenBeTheCopCongrats
	.align	2
	.globl	GetCar__25tScreenTournamentCongratsR8tCarInfo
	.ent	GetCar__25tScreenTournamentCongratsR8tCarInfo
GetCar__25tScreenTournamentCongratsR8tCarInfo:
	.frame	$sp,96,$31		# vars= 72, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$16,88($sp)
	move	$16,$5
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	sw	$31,92($sp)
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	lh	$5,72($sp)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,204			# 0x000000cc
	.set	macro
	.set	reorder

	lw	$31,92($sp)
	lw	$16,88($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	GetCar__25tScreenTournamentCongratsR8tCarInfo
	.align	2
	.globl	CalculatePrizes__25tScreenTournamentCongrats
	.ent	CalculatePrizes__25tScreenTournamentCongrats
CalculatePrizes__25tScreenTournamentCongrats:
	.frame	$sp,104,$31		# vars= 72, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$17,92($sp)
	move	$17,$4
	sw	$16,88($sp)
	lui	$16,%hi(tournamentManager) # high
	addiu	$16,$16,%lo(tournamentManager) # low
	move	$4,$16
	sw	$31,96($sp)
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CalculatePrizes__15tScreenCongrats
	move	$4,$17
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	sw	$2,104($17)
	lw	$2,20($16)
	#nop
	sw	$2,124($17)
	lw	$2,76($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L807
	li	$3,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,80($sp)
$L807:
	sw	$3,128($17)
	li.s	$3,4.00000000000000000000e0
	li.s	$4,-7.40000009536743164062e0
	li	$2,278			# 0x00000116
	sh	$2,376($17)
	li	$2,75			# 0x0000004b
	sh	$2,378($17)
	sw	$3,380($17)
	sw	$4,384($17)
	lw	$31,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	CalculatePrizes__25tScreenTournamentCongrats
	.align	2
	.globl	DrawCongratsMessage__25tScreenTournamentCongrats
	.ent	DrawCongratsMessage__25tScreenTournamentCongrats
DrawCongratsMessage__25tScreenTournamentCongrats:
	.frame	$sp,424,$31		# vars= 400, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,424
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	addu	$5,$sp,24
	li	$2,41			# 0x00000029
	sh	$2,16($sp)
	li	$2,60			# 0x0000003c
	sh	$2,18($sp)
	li	$2,200			# 0x000000c8
	sh	$2,20($sp)
	li	$2,400			# 0x00000190
	sw	$31,420($sp)
	sw	$16,416($sp)
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	sh	$2,22($sp)
	.set	macro
	.set	reorder

	lh	$4,76($sp)
	jal	TextSys_Word__Fi
	move	$4,$2
	addu	$5,$sp,16
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$2,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L809
	addu	$16,$sp,352
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,88($sp)
	li	$2,180			# 0x000000b4
	sh	$2,18($sp)
	li	$2,430			# 0x000001ae
	.set	noreorder
	.set	nomacro
	jal	FeTools_FormatMoney__FPcl
	sh	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	addu	$4,$sp,96
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,64			# 0x00000040
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$sp,16
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

$L809:
	lw	$31,420($sp)
	lw	$16,416($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,424
	.set	macro
	.set	reorder

	.end	DrawCongratsMessage__25tScreenTournamentCongrats
	.align	2
	.globl	___25tScreenTournamentCongrats
	.ent	___25tScreenTournamentCongrats
___25tScreenTournamentCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___25tScreenTournamentCongrats
	.align	2
	.globl	___23tScreenBeTheCopCongrats
	.ent	___23tScreenBeTheCopCongrats
___23tScreenBeTheCopCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___23tScreenBeTheCopCongrats
	.align	2
	.globl	___23tScreenPinkSlipCongrats
	.ent	___23tScreenPinkSlipCongrats
___23tScreenPinkSlipCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___23tScreenPinkSlipCongrats
	.align	2
	.globl	___23tScreenTournamentTrophy
	.ent	___23tScreenTournamentTrophy
___23tScreenTournamentTrophy:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___23tScreenTournamentTrophy
	.align	2
	.globl	___15tScreenCongrats
	.ent	___15tScreenCongrats
___15tScreenCongrats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___15tScreenCongrats
	.globl	congratsSwapFileName
	.data
	.align	2
congratsSwapFileName:
	.space	16
	.globl	fPermFileNameBuf
	.align	2
fPermFileNameBuf:
	.space	16
	.globl	screenPinkSlipCongrats
	.align	2
screenPinkSlipCongrats:
	.space	4
	.globl	screenTournamentTrophy
	.align	2
screenTournamentTrophy:
	.space	4
	.globl	screenBeTheCopCongrats
	.align	2
screenBeTheCopCongrats:
	.space	4
	.globl	screenTournamentCongrats
	.align	2
screenTournamentCongrats:
	.space	4
