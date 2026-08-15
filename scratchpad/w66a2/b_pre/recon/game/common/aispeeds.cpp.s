	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aispeeds.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	Track2Speeds
	.data
	.align	2
Track2Speeds:
	.half	50
	.half	3982
	.half	196
	.half	7395
	.half	293
	.half	7395
	.half	332
	.half	3982
	.half	390
	.half	7395
	.half	624
	.half	7395
	.half	665
	.half	3982
	.half	1026
	.half	7395
	.half	10000
	.half	3982
	.globl	Track3Speeds
	.align	2
Track3Speeds:
	.half	7
	.half	5688
	.half	236
	.half	3555
	.half	10000
	.half	5688
	.globl	Track5Speeds
	.align	2
Track5Speeds:
	.half	369
	.half	7964
	.half	674
	.half	5688
	.half	10000
	.half	7964
	.globl	Track6Speeds
	.align	2
Track6Speeds:
	.half	26
	.half	3555
	.half	327
	.half	7111
	.half	393
	.half	3555
	.half	627
	.half	7111
	.half	10000
	.half	3555
	.globl	Track7Speeds
	.align	2
Track7Speeds:
	.half	29
	.half	5688
	.half	429
	.half	7964
	.half	617
	.half	7964
	.half	655
	.half	5688
	.half	823
	.half	7964
	.half	10000
	.half	5688
	.globl	AISpeeds_TrackSpeeds
	.align	2
AISpeeds_TrackSpeeds:
	.word	Track0Speeds
	.word	Track1Speeds
	.word	Track2Speeds
	.word	Track3Speeds
	.word	Track4Speeds
	.word	Track5Speeds
	.word	Track6Speeds
	.word	Track7Speeds
	.word	Track8Speeds
	.word	Track9Speeds
	.word	Track10Speeds
	.globl	Track0Speeds
	.sdata
	.align	2
Track0Speeds:
	.half	10000
	.half	7395
	.globl	Track1Speeds
	.align	2
Track1Speeds:
	.half	10000
	.half	7395
	.globl	Track4Speeds
	.align	2
Track4Speeds:
	.half	10000
	.half	5688
	.globl	Track8Speeds
	.align	2
Track8Speeds:
	.half	10000
	.half	11377
	.globl	Track9Speeds
	.align	2
Track9Speeds:
	.half	10000
	.half	11377
	.globl	Track10Speeds
	.align	2
Track10Speeds:
	.half	10000
	.half	11377
	.align	2
$LC0:
	.ascii	"aiwther\000"
	.text
	.align	2
	.globl	AISpeeds_StartUp__Fv
	.rdata
	.align	2
$LC1:
	.ascii	"%stuning.bin\000"
	.text
	.align	2
	.globl	AISpeeds_ReadTuningInfo__Fv
	.align	2
	.globl	AISpeeds_CleanUp__Fv
	.align	2
	.globl	AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
	.align	2
	.globl	AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
	.align	2
	.globl	AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
	.align	2
	.globl	AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
	.align	2
	.globl	AISpeeds_BTCGetGlueFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetNextAICar__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetPrevAICar__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetCaravanFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetGlueFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetDamageFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_LimitGlueMultiplier__FP8Car_tObji
	.align	2
	.globl	AISpeeds_CalcCopTopSpeed__FP8Car_tObj
	.align	2
	.globl	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetLegalSpeed__Fi
	.align	2
	.globl	AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
	.align	2
	.globl	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	.align	2
	.globl	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
	.rdata
	.align	2
$LC2:
	.word	65536
	.word	58982
	.word	52428
	.word	45875
	.text
	.align	2
	.globl	AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_MaintainLeaderBoard__Fv
	.align	2
	.globl	AISpeeds_GetScriptFactor__FP8Car_tObj
	.align	2
	.globl	AISpeeds_GetUpgradeAccMult__Fi
	.align	2
	.globl	AISpeeds_GetUpgradeBrakeMult__Fi
	.align	2
	.globl	AISpeeds_GetUpgradeHandlingMult__Fi
	.align	2
	.globl	AISpeeds_GetUpgradeTopSpeedMult__Fi
	.align	2
	.globl	AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
	.align	2
	.globl	AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
	.globl	engineUpgrade
	.data
	.align	2
engineUpgrade:
	.space	16
	.globl	suspensionUpgrade
	.align	2
suspensionUpgrade:
	.space	16
	.globl	aeroUpgrade
	.align	2
aeroUpgrade:
	.space	16
	.globl	leaderBoard
	.align	2
leaderBoard:
	.space	16
	.globl	CaravanInfo
	.align	2
CaravanInfo:
	.space	96
	.globl	AISpeeds_WeatherMultFactors
	.sdata
	.align	2
AISpeeds_WeatherMultFactors:
	.space	4
	.globl	AISpeeds_trackAndNightMult
	.align	2
AISpeeds_trackAndNightMult:
	.space	4

	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	AI_elapsedTime, 4
	.extern	AIDataRecord_TrackCurve, 4
	.extern	gNumSlices, 4
	.extern	BWorldSm_slices, 4
	.extern	Cars_gNumCars, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	simGlobal, 24
	.extern	Cars_gAIRaceCarList, 36
	.extern	Cars_gNumAIRaceCars, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AISpeeds_StartUp__Fv
AISpeeds_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,260			# 0x00000104
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,AISpeeds_WeatherMultFactors
	jal	AISpeeds_ReadTuningInfo__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_StartUp__Fv
	.text
	.ent	AISpeeds_ReadTuningInfo__Fv
AISpeeds_ReadTuningInfo__Fv:
	.frame	$sp,168,$31		# vars= 128, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,168
	addu	$4,$sp,16
	lui	$5,%hi($LC1) # high
	lui	$2,%hi(Paths_Paths+8) # high
	lw	$6,%lo(Paths_Paths+8)($2)
	addiu	$5,$5,%lo($LC1) # low
	sw	$18,152($sp)
	move	$18,$0
	sw	$31,160($sp)
	sw	$19,156($sp)
	sw	$17,148($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,144($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(CaravanInfo) # high
	addiu	$16,$2,%lo(CaravanInfo) # low
$L604:
	slt	$2,$18,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	lui	$3,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$2,$2,5
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,4($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,8($16)
	.set	macro
	.set	reorder

	li	$4,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sll	$5,$2,21
	.set	macro
	.set	reorder

	sw	$2,12($16)
	addu	$16,$16,16
	.set	noreorder
	.set	nomacro
	j	$L604
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L603:
	lw	$2,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumAIRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L630
	lui	$2,%hi(Cars_gAIRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gAIRaceCarList)($2)
	move	$16,$0
	lw	$2,648($2)
	addiu	$18,$3,%lo(GameSetup_gData) # low
	lw	$19,0($2)
$L608:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,128($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,132($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$19,$L611
	sw	$2,136($sp)
	.set	macro
	.set	reorder

	lw	$2,8($18)
	#nop
	sll	$2,$2,2
	addu	$2,$sp,$2
	lw	$2,128($2)
	#nop
	sw	$2,16($18)
$L611:
	addu	$16,$16,1
	slt	$2,$16,22
	beq	$2,$0,$L613
	j	$L608
$L630:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,22
	bne	$2,$0,$L630
$L613:
	sw	$0,AISpeeds_trackAndNightMult
	move	$16,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
$L618:
	slt	$2,$16,12
	beq	$2,$0,$L619
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$3,84($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L622
	move	$5,$2
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
$L622:
	lw	$2,60($19)
	#nop
	bne	$16,$2,$L620
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$2,AISpeeds_trackAndNightMult
$L620:
	.set	noreorder
	.set	nomacro
	j	$L618
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L619:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	move	$6,$2
	move	$5,$0
	li	$7,65536			# 0x00010000
	lw	$4,AISpeeds_WeatherMultFactors
	move	$3,$5
$L627:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L628
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,63
$L628:
	sra	$2,$2,6
	subu	$2,$7,$2
	sw	$2,0($4)
	addu	$4,$4,4
	addu	$5,$5,1
	slt	$2,$5,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	addu	$3,$3,$6
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$5,%hi(engineUpgrade) # high
	addiu	$5,$5,%lo(engineUpgrade) # low
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$5,%hi(suspensionUpgrade) # high
	addiu	$5,$5,%lo(suspensionUpgrade) # low
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$5,%hi(aeroUpgrade) # high
	addiu	$5,$5,%lo(aeroUpgrade) # low
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$31,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,168
	.set	macro
	.set	reorder

	.end	AISpeeds_ReadTuningInfo__Fv
	.text
	.ent	AISpeeds_CleanUp__Fv
AISpeeds_CleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,AISpeeds_WeatherMultFactors
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L631
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
	sw	$0,AISpeeds_WeatherMultFactors
$L631:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_CleanUp__Fv
	.text
	.ent	AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Cars_gNumAIRaceCars
	lw	$3,1908($4)
	#nop
	subu	$5,$2,$3
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData)($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L634
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,1920
	beq	$2,$0,$L634
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L634
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	lhu	$3,6($4)
	lhu	$2,6($2)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	sll	$2,$5,1
	.set	macro
	.set	reorder

	addu	$2,$2,$5
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	li	$3,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L634:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.end	AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
	.text
	.ent	AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$22,40($sp)
	move	$22,$5
	sw	$31,44($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$3,1892($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L637
	move	$20,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L638
	li	$16,65536			# 0x00010000
	.set	macro
	.set	reorder

$L637:
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L640
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L639
$L640:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L641
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L639
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L639
$L641:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_BTCGetGlueFactor__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L687
	move	$16,$2
	.set	macro
	.set	reorder

$L639:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetGlueFactor__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	move	$16,$2
$L638:
$L687:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetScriptFactor__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	move	$4,$19
	lw	$17,1856($19)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetDamageFactor__FP8Car_tObj
	move	$21,$2
	.set	macro
	.set	reorder

	move	$18,$2
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L689
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumAIRaceCars
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L644
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetCaravanFactor__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L688
	move	$3,$17
	.set	macro
	.set	reorder

$L644:
$L689:
	move	$3,$17
$L688:
	bgez	$3,$L647
	addu	$3,$3,255
$L647:
	lw	$4,AISpeeds_trackAndNightMult
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L648
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L648:
	move	$6,$2
	.set	noreorder
	.set	nomacro
	bgez	$6,$L649
	sra	$7,$4,8
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L649:
	lui	$8,%hi(GameSetup_gData) # high
	addiu	$2,$8,%lo(GameSetup_gData) # low
	lw	$3,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L650
	sra	$4,$6,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L650:
	move	$2,$16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L651
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L651:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	bgez	$2,$L652
	addu	$2,$2,255
$L652:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$2
	#nop
	#nop
	bgez	$2,$L653
	addu	$2,$2,255
$L653:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$2
	#nop
	#nop
	bgez	$2,$L654
	addu	$2,$2,255
$L654:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$17
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$17,$L655
	move	$2,$17
	.set	macro
	.set	reorder

	addu	$2,$17,255
$L655:
	move	$3,$18
	.set	noreorder
	.set	nomacro
	bgez	$3,$L656
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L656:
	move	$2,$21
	.set	noreorder
	.set	nomacro
	bgez	$2,$L657
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L657:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	bgez	$2,$L658
	addu	$2,$2,255
$L658:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,%lo(GameSetup_gData)($8)
	li	$2,1			# 0x00000001
	mflo	$16
	#nop
	beq	$3,$2,$L659
	lhu	$2,6($19)
	#nop
	sltu	$2,$2,150
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L659
	li	$18,65536			# 0x00010000
	.set	macro
	.set	reorder

	lhu	$2,6($19)
	subu	$4,$18,$17
	mult	$4,$2
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,436			# 0x000001b4
	.set	macro
	.set	reorder

	lhu	$3,6($19)
	#nop
	sltu	$3,$3,150
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L659
	subu	$17,$18,$2
	.set	macro
	.set	reorder

	lhu	$2,6($19)
	subu	$4,$18,$16
	mult	$4,$2
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,436			# 0x000001b4
	.set	macro
	.set	reorder

	subu	$16,$18,$2
$L659:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
	move	$4,$19
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L690
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$17,$L662
	move	$2,$17
	.set	macro
	.set	reorder

	addu	$2,$17,255
$L662:
	move	$4,$3
	.set	noreorder
	.set	nomacro
	bgez	$3,$L663
	sra	$2,$2,8
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L663:
	sra	$4,$4,8
	mult	$2,$4
	mflo	$17
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$16,$L664
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$6,$16,255
$L664:
	sra	$5,$6,8
	mult	$5,$4
	mflo	$16
	#nop
	move	$4,$19
$L690:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_LimitGlueMultiplier__FP8Car_tObji
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_LimitGlueMultiplier__FP8Car_tObji
	sw	$2,1840($19)
	.set	macro
	.set	reorder

	move	$17,$2
	lw	$3,1840($19)
	li	$4,65536			# 0x00010000
	slt	$2,$4,$3
	beq	$2,$0,$L666
	.set	noreorder
	.set	nomacro
	j	$L667
	sw	$3,148($19)
	.set	macro
	.set	reorder

$L666:
	sw	$4,148($19)
$L667:
	.set	noreorder
	.set	nomacro
	bgez	$20,$L668
	move	$3,$20
	.set	macro
	.set	reorder

	addu	$3,$20,255
$L668:
	lw	$2,1840($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L669
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L669:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$16
	#nop
	move	$2,$17
	bgez	$2,$L671
	addu	$2,$2,255
$L671:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$10
	#nop
	#nop
	sw	$10,0($22)
	lw	$2,608($19)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L684
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,912($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L684
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L674
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L673
$L674:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	#nop
	bne	$2,$4,$L673
	lw	$2,4($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L684
$L673:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObji
	move	$5,$0
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	bgez	$2,1f
	move	$8,$2
	subu	$8,$0,$8
1:
	.set	reorder
	lw	$4,1396($19)
	lw	$3,308($19)
	lw	$6,Cars_gNumCars
	subu	$9,$4,$3
	.set	noreorder
	.set	nomacro
	blez	$6,$L676
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$3,$2,%lo(Cars_gTotalSortedList) # low
$L677:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L691
	sll	$2,$5,2
	.set	macro
	.set	reorder

	addu	$5,$5,1
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L677
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L676:
	sll	$2,$5,2
$L691:
	addu	$2,$2,$5
	sll	$2,$2,19
	slt	$2,$8,$2
	bne	$2,$0,$L684
	lh	$2,8($19)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$5,$2,$3
	lbu	$2,30($5)
	lbu	$6,29($5)
	sll	$2,$2,15
	srl	$3,$6,4
	mult	$2,$3
	mflo	$10
	#nop
	#nop
	subu	$7,$0,$10
	slt	$2,$9,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	andi	$3,$6,0x000f
	.set	macro
	.set	reorder

	lbu	$2,31($5)
	#nop
	sll	$2,$2,15
	mult	$2,$3
	mflo	$3
	#nop
	#nop
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	slt	$2,$4,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	move	$16,$0
	.set	macro
	.set	reorder

	li	$2,26214400			# 0x01900000
	slt	$2,$2,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L681
	li	$16,1114112			# 0x00110000
	.set	macro
	.set	reorder

$L682:
	.set	noreorder
	.set	nomacro
	j	$L684
	move	$16,$0
	.set	macro
	.set	reorder

$L681:
	ori	$16,$16,0xc71c
$L684:
	lw	$3,0($22)
	lw	$2,1364($19)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	sw	$3,0($22)
	lw	$2,1364($19)
	#nop
	mult	$16,$2
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
	.text
	.ent	AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	slt	$2,$6,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L705
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,1720($4)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L694
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$6,$6,$2
$L694:
	sra	$6,$6,16
	.set	noreorder
	.set	nomacro
	bgez	$6,$L702
	slt	$2,$6,128
	.set	macro
	.set	reorder

	subu	$6,$0,$6
	slt	$2,$6,128
$L702:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L703
	addu	$2,$4,$6
	.set	macro
	.set	reorder

	li	$6,128			# 0x00000080
	addu	$2,$4,$6
$L703:
	lbu	$2,0($2)
	.set	noreorder
	.set	nomacro
	bgez	$7,$L697
	sll	$3,$2,17
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$7,$7,$2
$L697:
	sra	$7,$7,16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L704
	slt	$2,$7,128
	.set	macro
	.set	reorder

	subu	$7,$0,$7
	slt	$2,$7,128
$L704:
	bne	$2,$0,$L699
	li	$7,128			# 0x00000080
$L699:
	addu	$2,$4,$7
	lbu	$2,0($2)
	#nop
	sll	$2,$2,17
	subu	$2,$3,$2
	sra	$3,$2,3
	addu	$2,$2,$3
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L705:
	j	$31
	.end	AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
	.text
	.ent	AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$18,24($sp)
	li	$18,200			# 0x000000c8
	lui	$2,%hi(GameSetup_gData) # high
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,1380($19)
	addiu	$21,$2,%lo(GameSetup_gData) # low
	.set	noreorder
	bgez	$3,1f
	move	$20,$3
	subu	$20,$0,$20
1:
	.set	reorder
$L709:
	.set	noreorder
	.set	nomacro
	bltz	$18,$L710
	li	$2,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xaaab
	mult	$18,$2
	sra	$2,$18,31
	mfhi	$9
	#nop
	lw	$3,1364($19)
	subu	$2,$9,$2
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bltz	$5,$L712
	lh	$2,8($19)
	lw	$3,gNumSlices
	addu	$5,$2,$5
	slt	$2,$5,$3
	bne	$2,$0,$L716
	.set	noreorder
	.set	nomacro
	j	$L716
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L712:
	lh	$2,8($19)
	#nop
	addu	$5,$2,$5
	bgez	$5,$L716
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L716:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$16,$2
	lw	$4,1716($19)
	.set	noreorder
	.set	nomacro
	jal	Get__30AIDataRecord_CurveSpeedTable_ti
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,72($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L720
	move	$17,$2
	.set	macro
	.set	reorder

	move	$2,$16
	bgez	$2,$L721
	addu	$2,$2,3
$L721:
	sra	$2,$2,2
	lw	$3,AISpeeds_WeatherMultFactors
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$17
	.set	macro
	.set	reorder

	move	$17,$2
$L720:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L726
	move	$4,$19
	.set	macro
	.set	reorder

	sll	$5,$18,16
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L709
	addu	$18,$18,-25
	.set	macro
	.set	reorder

$L726:
	.set	noreorder
	.set	nomacro
	j	$L725
	move	$2,$17
	.set	macro
	.set	reorder

$L710:
	move	$2,$0
$L725:
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

	.end	AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_BTCGetGlueFactor__FP8Car_tObj
AISpeeds_BTCGetGlueFactor__FP8Car_tObj:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$18,24($sp)
	li	$18,655294464			# 0x270f0000
	sw	$31,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,608($21)
	#nop
	andi	$2,$2,0x0020
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L735
	move	$20,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$19,$0
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$17,$2,%lo(Cars_gHumanRaceCarList) # low
$L729:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L730
	lw	$16,0($17)
	#nop
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	bgez	$4,1f
	move	$2,$4
	subu	$2,$0,$2
1:
	.set	reorder
	.set	noreorder
	bgez	$18,1f
	move	$3,$18
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$2,$3
	beq	$2,$0,$L732
	move	$18,$4
	move	$20,$16
$L732:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L729
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L730:
	lw	$2,1364($21)
	#nop
	mult	$18,$2
	lw	$3,1120($20)
	mflo	$18
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L744
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$4,589824			# 0x00090000
	ori	$4,$4,0xffff
	li	$3,1245184			# 0x00130000
	lw	$2,1380($20)
	ori	$3,$3,0xfffe
	addu	$2,$2,$4
	sltu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L737
	li	$2,-2004353024			# 0x88880000
	.set	macro
	.set	reorder

$L735:
	.set	noreorder
	.set	nomacro
	j	$L744
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

$L737:
	ori	$2,$2,0x8889
	mult	$18,$2
	sra	$3,$18,31
	mfhi	$6
	#nop
	#nop
	addu	$2,$6,$18
	sra	$2,$2,21
	subu	$2,$2,$3
	addu	$4,$2,10
	.set	noreorder
	.set	nomacro
	bltz	$4,$L739
	slt	$2,$4,21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	li	$3,20			# 0x00000014
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L741
	move	$3,$4
	.set	macro
	.set	reorder

$L739:
	move	$3,$0
$L741:
	lui	$2,%hi(AIPerson_glueTable) # high
	addiu	$2,$2,%lo(AIPerson_glueTable) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$4,0($3)
	li	$2,65535			# 0x0000ffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L745
	slt	$2,$4,26214
	.set	macro
	.set	reorder

	lw	$5,1868($21)
	li	$16,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$16,$4
	.set	macro
	.set	reorder

	subu	$4,$16,$2
	slt	$2,$4,26214
$L745:
	beq	$2,$0,$L743
	li	$4,26214			# 0x00006666
$L743:
	lw	$5,1724($21)
	jal	fixedmult
$L744:
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

	.end	AISpeeds_BTCGetGlueFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_GetNextAICar__FP8Car_tObj
AISpeeds_GetNextAICar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1896($4)
	j	$31
	.end	AISpeeds_GetNextAICar__FP8Car_tObj
	.text
	.ent	AISpeeds_GetPrevAICar__FP8Car_tObj
AISpeeds_GetPrevAICar__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$0
	lw	$2,Cars_gNumCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L748
	move	$5,$7
	.set	macro
	.set	reorder

	move	$8,$2
	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$6,$2,%lo(Cars_gTotalSortedList) # low
$L749:
	lw	$3,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L756
	move	$2,$7
	.set	macro
	.set	reorder

	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L753
	move	$7,$3
$L753:
	addu	$5,$5,1
	slt	$2,$5,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	addu	$6,$6,4
	.set	macro
	.set	reorder

$L748:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L756:
	j	$31
	.end	AISpeeds_GetPrevAICar__FP8Car_tObj
	.text
	.ent	AISpeeds_GetCaravanFactor__FP8Car_tObj
AISpeeds_GetCaravanFactor__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$20,1908($18)
	jal	AISpeeds_GetNextAICar__FP8Car_tObj
	lw	$3,1892($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L758
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$2,1908($3)
	#nop
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	li	$19,58982			# 0x0000e666
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L760
	sw	$0,1892($18)
	.set	macro
	.set	reorder

$L758:
	beq	$17,$0,$L767
	lw	$2,1892($17)
	#nop
	bne	$2,$0,$L768
	li	$2,851968			# 0x000d0000
	lw	$3,1384($17)
	ori	$2,$2,0x6491
	slt	$2,$2,$3
	beq	$2,$0,$L767
	lw	$3,1364($18)
	lw	$2,1376($17)
	#nop
	mult	$2,$3
	mflo	$4
	#nop
	lw	$2,1372($17)
	#nop
	mult	$2,$3
	mflo	$5
	#nop
	bgez	$4,$L764
	addu	$4,$4,255
$L764:
	sra	$4,$4,8
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$4
	slt	$2,$5,$2
	beq	$2,$0,$L766
$L767:
	lw	$2,1892($17)
$L768:
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L760
	li	$19,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L760
	ori	$19,$19,0x1999
	.set	macro
	.set	reorder

$L766:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	lw	$3,1900($18)
	li	$4,655360			# 0x000a0000
	addu	$2,$3,$4
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	li	$19,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,65536000			# 0x03e80000
	addu	$2,$3,$2
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	ori	$19,$19,0x3333
	.set	macro
	.set	reorder

	li	$19,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L760
	ori	$19,$19,0x8000
	.set	macro
	.set	reorder

$L770:
	subu	$2,$3,$4
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L773
	li	$2,-65536000			# 0xfc180000
	.set	macro
	.set	reorder

	addu	$2,$3,$2
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	li	$19,52428			# 0x0000cccc
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L760
	li	$19,39321			# 0x00009999
	.set	macro
	.set	reorder

$L773:
	li	$19,65536			# 0x00010000
$L760:
	lui	$2,%hi(CaravanInfo) # high
	addiu	$2,$2,%lo(CaravanInfo) # low
	sll	$3,$20,4
	addu	$8,$3,$2
	lw	$2,0($8)
	#nop
	beq	$2,$0,$L776
	lw	$2,1904($18)
	lw	$3,AI_elapsedTime
	#nop
	subu	$2,$2,$3
	sw	$2,1904($18)
$L776:
	lw	$2,1904($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L777
	li	$5,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lw	$6,fastRandom
	lw	$4,randSeed
	#nop
	mult	$6,$4
	lw	$3,0($8)
	ori	$5,$5,0xff00
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	mflo	$6
	#nop
	#nop
	and	$2,$6,$5
	srl	$2,$2,8
	mult	$3,$2
	mflo	$10
	#nop
	andi	$7,$6,0xffff
	mult	$7,$4
	srl	$2,$10,16
	addu	$3,$3,$2
	sw	$3,1904($18)
	lw	$2,8($8)
	lw	$3,4($8)
	#nop
	subu	$2,$2,$3
	mflo	$4
	#nop
	#nop
	and	$5,$4,$5
	srl	$5,$5,8
	mult	$2,$5
	sw	$6,randtemp
	sw	$7,fastRandom
	sw	$4,randtemp
	andi	$4,$4,0xffff
	sw	$4,fastRandom
	mflo	$5
	#nop
	#nop
	srl	$2,$5,16
	addu	$3,$3,$2
	sll	$3,$3,16
	sw	$3,1900($18)
$L777:
	lw	$2,Cars_gNumAIRaceCars
	#nop
	addu	$2,$2,-1
	slt	$2,$20,$2
	beq	$2,$0,$L778
	lw	$2,1892($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L778
	lui	$2,%hi(GameSetup_gData+4) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+4)($2)
	lw	$2,gNumSlices
	#nop
	mult	$3,$2
	lhu	$2,6($18)
	mflo	$9
	#nop
	#nop
	addu	$3,$9,-333
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	sltu	$2,$20,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L779
	lui	$2,%hi(leaderBoard) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$4,%lo(leaderBoard)($2)
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	beq	$4,$2,$L778
$L779:
	lw	$2,fastRandom
	lw	$3,randSeed
	#nop
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	andi	$3,$2,0xffff
	sw	$2,randtemp
	srl	$2,$2,8
	sw	$3,fastRandom
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L781
	andi	$4,$2,0xffff
	.set	macro
	.set	reorder

	lw	$2,1892($17)
	#nop
	bne	$2,$0,$L778
$L781:
	lw	$3,12($8)
	lw	$2,AI_elapsedTime
	#nop
	mult	$3,$2
	mflo	$9
	#nop
	#nop
	sltu	$2,$4,$9
	beq	$2,$0,$L778
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_GetPrevAICar__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L778
	sw	$2,1892($18)
$L778:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L785
	move	$2,$19
	.set	macro
	.set	reorder

	lw	$2,1912($18)
	lw	$3,1912($17)
	addu	$2,$2,-6553
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L785
	move	$2,$19
	.set	macro
	.set	reorder

	lw	$2,1892($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L785
	move	$2,$19
	.set	macro
	.set	reorder

	sw	$18,1892($17)
$L785:
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

	.end	AISpeeds_GetCaravanFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_GetGlueFactor__FP8Car_tObj
AISpeeds_GetGlueFactor__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$16,16($sp)
	lui	$16,%hi(leaderBoard) # high
	addiu	$16,$16,%lo(leaderBoard) # low
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	li	$18,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$4,8($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$19,$2
	.set	macro
	.set	reorder

	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$3,4($16)
	li	$4,589824			# 0x00090000
	lw	$3,1380($3)
	ori	$4,$4,0xffff
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L787
	slt	$2,$19,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L788
	move	$16,$18
	.set	macro
	.set	reorder

$L787:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L789
	li	$2,-2004353024			# 0x88880000
	.set	macro
	.set	reorder

	ori	$2,$2,0x8889
	subu	$3,$17,$19
	mult	$3,$2
	mfhi	$6
	#nop
	#nop
	addu	$2,$6,$3
	sra	$2,$2,21
	sra	$3,$3,31
	subu	$2,$2,$3
	addu	$3,$2,10
	.set	noreorder
	.set	nomacro
	bgez	$3,$L811
	slt	$2,$3,21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L798
	move	$4,$0
	.set	macro
	.set	reorder

$L789:
	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L794
	li	$2,-2004353024			# 0x88880000
	.set	macro
	.set	reorder

	ori	$2,$2,0x8889
	subu	$3,$17,$19
	mult	$3,$2
	mfhi	$6
	#nop
	#nop
	addu	$2,$6,$3
	sra	$2,$2,21
	sra	$3,$3,31
	subu	$2,$2,$3
	addu	$3,$2,10
	.set	noreorder
	.set	nomacro
	bltz	$3,$L796
	slt	$2,$3,21
	.set	macro
	.set	reorder

$L811:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L798
	move	$4,$3
	.set	macro
	.set	reorder

$L796:
	move	$4,$0
$L798:
	lui	$3,%hi(AIPerson_glueTable) # high
	addiu	$3,$3,%lo(AIPerson_glueTable) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	j	$L788
	li	$18,65536			# 0x00010000
	.set	macro
	.set	reorder

$L794:
	ori	$2,$2,0x8889
	subu	$3,$17,$19
	mult	$3,$2
	mfhi	$6
	#nop
	#nop
	addu	$2,$6,$3
	sra	$2,$2,21
	sra	$3,$3,31
	subu	$2,$2,$3
	addu	$3,$2,10
	.set	noreorder
	.set	nomacro
	bltz	$3,$L802
	slt	$2,$3,21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L804
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L804
	move	$4,$3
	.set	macro
	.set	reorder

$L802:
	move	$4,$0
$L804:
	lui	$3,%hi(AIPerson_glueTable) # high
	addiu	$3,$3,%lo(AIPerson_glueTable) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$16,0($2)
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L788
	li	$18,32768			# 0x00008000
	.set	macro
	.set	reorder

	li	$18,58982			# 0x0000e666
$L788:
	.set	noreorder
	.set	nomacro
	jal	AIWorld_GameOdometer__FP8Car_tObj
	move	$4,$20
	.set	macro
	.set	reorder

	li	$3,3932160			# 0x003c0000
	addu	$3,$19,$3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L807
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L812
	li	$17,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$16,65536			# 0x00010000
$L807:
	li	$17,65536			# 0x00010000
$L812:
	slt	$2,$17,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L808
	subu	$4,$16,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L809
	addu	$16,$2,$17
	.set	macro
	.set	reorder

$L808:
	subu	$4,$17,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	subu	$16,$17,$2
$L809:
	move	$2,$16
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

	.end	AISpeeds_GetGlueFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_GetDamageFactor__FP8Car_tObj
AISpeeds_GetDamageFactor__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,536($16)
	lw	$3,540($16)
	lw	$4,548($16)
	addu	$2,$2,$3
	lw	$3,544($16)
	sw	$0,1912($16)
	addu	$2,$2,$3
	addu	$2,$2,$4
	lw	$3,552($16)
	lw	$4,556($16)
	addu	$2,$2,$3
	addu	$2,$2,$4
	lw	$3,560($16)
	lw	$4,564($16)
	addu	$2,$2,$3
	addu	$4,$2,$4
	lui	$2,%hi(GameSetup_gData) # high
	sw	$4,1912($16)
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L815
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L814
$L815:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L816
	addiu	$5,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L814
	lw	$2,4($5)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L814
$L816:
	.set	noreorder
	.set	nomacro
	j	$L817
	li	$5,327			# 0x00000147
	.set	macro
	.set	reorder

$L814:
	lw	$4,1912($16)
	li	$5,72			# 0x00000048
$L817:
	jal	fixedmult
	sw	$2,1912($16)
 #APP
 #NO_APP
	li	$4,32768			# 0x00008000
	#.set	volatile
	lw	$3,1912($16)
	#.set	novolatile
	li	$2,65536			# 0x00010000
	subu	$3,$2,$3
	li	$2,32767			# 0x00007fff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L818
	sw	$3,1912($16)
	.set	macro
	.set	reorder

	move	$4,$3
$L818:
	sw	$4,1912($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_GetDamageFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_LimitGlueMultiplier__FP8Car_tObji
AISpeeds_LimitGlueMultiplier__FP8Car_tObji:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$18,24($sp)
	move	$18,$5
	li	$3,-65536			# 0xffff0000
	ori	$3,$3,0x6666
	addu	$3,$18,$3
	li	$2,52427			# 0x0000cccb
	sltu	$2,$2,$3
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L820
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$19,655360000			# 0x27100000
	move	$17,$0
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$16,$2,%lo(Cars_gHumanRaceCarList) # low
$L823:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L822
	li	$2,7864320			# 0x00780000
	.set	macro
	.set	reorder

	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$3,$19
	beq	$2,$0,$L825
	move	$19,$3
$L825:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L823
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L822:
	slt	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L831
	move	$2,$18
	.set	macro
	.set	reorder

	li	$2,65536			# 0x00010000
	ori	$2,$2,0x6666
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L832
	li	$2,39320			# 0x00009998
	.set	macro
	.set	reorder

	li	$18,65536			# 0x00010000
	ori	$18,$18,0x6666
$L832:
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L831
	move	$2,$18
	.set	macro
	.set	reorder

	li	$18,39321			# 0x00009999
$L820:
	move	$2,$18
$L831:
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

	.end	AISpeeds_LimitGlueMultiplier__FP8Car_tObji
	.text
	.ent	AISpeeds_CalcCopTopSpeed__FP8Car_tObj
AISpeeds_CalcCopTopSpeed__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$3,1736($16)
	move	$4,$2
	slt	$2,$4,$3
	beq	$2,$0,$L834
	move	$3,$4
$L834:
	move	$4,$3
	lw	$3,AISpeeds_trackAndNightMult
	lw	$2,1856($16)
	bgez	$3,$L835
	addu	$3,$3,255
$L835:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L836
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L836:
	sra	$2,$2,8
	mult	$3,$2
	li	$5,65536			# 0x00010000
	mflo	$3
	#nop
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L837
	sw	$3,1840($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L838
	sw	$3,148($16)
	.set	macro
	.set	reorder

$L837:
	sw	$5,148($16)
$L838:
	move	$2,$4
	bgez	$2,$L839
	addu	$2,$2,255
$L839:
	lw	$3,1840($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L840
	sra	$4,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L840:
	sra	$2,$3,8
	mult	$4,$2
	mflo	$3
	#nop
	lw	$2,1364($16)
	#nop
	mult	$3,$2
	lw	$31,20($sp)
	lw	$16,16($sp)
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_CalcCopTopSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$4,8($17)
	jal	AISpeeds_GetLegalSpeed__Fi
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,49152			# 0x0000c000
	.set	macro
	.set	reorder

	move	$16,$2
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L843
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L860
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

$L843:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$4,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L844
	addiu	$5,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L860
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	lw	$2,4($5)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

$L844:
	lw	$3,1364($17)
	lw	$2,1364($4)
	#nop
	beq	$3,$2,$L848
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L859
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L848
	move	$16,$2
	.set	macro
	.set	reorder

$L842:
$L860:
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,1364($17)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L858
	nor	$2,$0,$3
	.set	macro
	.set	reorder

	xori	$2,$3,0x0001
$L858:
	sltu	$2,$0,$2
	beq	$2,$0,$L848
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L852
	move	$2,$16
	.set	macro
	.set	reorder

$L859:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L848
	move	$16,$2
	.set	macro
	.set	reorder

$L852:
	move	$16,$2
$L848:
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L854
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
	move	$5,$16
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	bgez	$16,$L855
	move	$3,$16
	.set	macro
	.set	reorder

	addu	$3,$16,255
$L855:
	lw	$2,1724($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L856
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L856:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$16
$L854:
	li	$2,524288			# 0x00080000
	ori	$2,$2,0xe38e
	slt	$2,$16,$2
	beq	$2,$0,$L857
	li	$16,524288			# 0x00080000
	ori	$16,$16,0xe38e
$L857:
	lw	$2,1364($17)
	#nop
	mult	$16,$2
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_GetLegalSpeed__Fi
AISpeeds_GetLegalSpeed__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(AISpeeds_TrackSpeeds) # high
	lui	$2,%hi(GameSetup_gData+60) # high
	lw	$2,%lo(GameSetup_gData+60)($2)
	addiu	$3,$3,%lo(AISpeeds_TrackSpeeds) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,0($2)
$L864:
	lhu	$2,0($3)
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L864
	addu	$3,$3,4
	.set	macro
	.set	reorder

	addu	$3,$3,-4
	#.set	volatile
	lhu	$2,2($3)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$31
	sll	$2,$2,8
	.set	macro
	.set	reorder

	.end	AISpeeds_GetLegalSpeed__Fi
	.text
	.ent	AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	blez	$5,$L867
	li	$2,-917504			# 0xfff20000
	.set	macro
	.set	reorder

	ori	$2,$2,0x999a
	lw	$4,1424($4)
	addu	$3,$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L868
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L868:
	sra	$2,$4,8
	mult	$5,$2
	mflo	$5
	#nop
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L874
	li	$2,524288			# 0x00080000
	.set	macro
	.set	reorder

	move	$5,$3
$L874:
	ori	$2,$2,0xe665
	slt	$2,$2,$5
	bne	$2,$0,$L871
	li	$5,524288			# 0x00080000
	.set	noreorder
	.set	nomacro
	j	$L871
	ori	$5,$5,0xe666
	.set	macro
	.set	reorder

$L867:
	bgez	$5,$L872
	addu	$5,$5,255
$L872:
	lw	$2,1424($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L873
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L873:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$5
$L871:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji
	.text
	.ent	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
AISpeeds_CalcDesiredSpeed__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,608($16)
	#nop
	andi	$2,$3,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L876
	sw	$0,1372($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
	addu	$5,$16,1376
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L875
	sw	$2,1372($16)
	.set	macro
	.set	reorder

$L876:
	andi	$2,$3,0x0020
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L878
	andi	$2,$3,0x0010
	.set	macro
	.set	reorder

	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L879
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcCopTopSpeed__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L885
	sw	$2,1372($16)
	.set	macro
	.set	reorder

$L879:
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,1372($16)
$L885:
	lw	$2,1372($16)
	.set	noreorder
	.set	nomacro
	j	$L875
	sw	$2,1376($16)
	.set	macro
	.set	reorder

$L878:
	beq	$2,$0,$L875
	.set	noreorder
	.set	nomacro
	jal	AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,1372($16)
	sw	$2,1376($16)
$L875:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_CalcDesiredSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1400($4)
	li	$3,851968			# 0x000d0000
	lw	$2,1380($2)
	ori	$3,$3,0x5554
	.set	noreorder
	bgez	$2,1f
	move	$4,$2
	subu	$4,$0,$4
1:
	.set	reorder
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L887
	li	$2,1703936			# 0x001a0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xaaa9
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L889
	li	$2,2555904			# 0x00270000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L891
	li	$2,3604480			# 0x00370000
	.set	macro
	.set	reorder

	ori	$2,$2,0x8e37
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L893
	li	$2,4653056			# 0x00470000
	.set	macro
	.set	reorder

	ori	$2,$2,0x1c70
	li	$3,131072			# 0x00020000
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L888
	ori	$3,$3,0xc51e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L897
	li	$3,131072			# 0x00020000
	.set	macro
	.set	reorder

$L893:
	li	$3,262144			# 0x00040000
	.set	noreorder
	.set	nomacro
	j	$L888
	ori	$3,$3,0x71c7
	.set	macro
	.set	reorder

$L891:
	li	$3,524288			# 0x00080000
	.set	noreorder
	.set	nomacro
	j	$L888
	ori	$3,$3,0xe38e
	.set	macro
	.set	reorder

$L889:
	li	$3,851968			# 0x000d0000
	.set	noreorder
	.set	nomacro
	j	$L888
	ori	$3,$3,0x5555
	.set	macro
	.set	reorder

$L887:
	li	$3,1441792			# 0x00160000
$L897:
	ori	$3,$3,0x38e3
$L888:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,randSeed
	lw	$2,fastRandom
	#nop
	mult	$3,$2
	subu	$sp,$sp,16
	lui	$2,%hi($LC2) # high
	addiu	$8,$2,%lo($LC2)
	lw	$5,0($8)
	lw	$6,4($8)
	lw	$7,8($8)
	sw	$5,0($sp)
	sw	$6,4($sp)
	sw	$7,8($sp)
	lw	$5,12($8)
	sw	$5,12($sp)
	mflo	$3
	#nop
	#nop
	srl	$2,$3,6
	andi	$2,$2,0x000c
	addu	$2,$sp,$2
	lw	$2,0($2)
	sw	$3,randtemp
	andi	$3,$3,0xffff
	sw	$3,fastRandom
	sw	$2,1424($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_MaintainLeaderBoard__Fv
AISpeeds_MaintainLeaderBoard__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$0
	move	$8,$7
	lui	$2,%hi(leaderBoard) # high
	move	$9,$2
	addiu	$2,$9,%lo(leaderBoard) # low
	move	$6,$2
	lui	$2,%hi(Cars_gTotalSortedList) # high
	lw	$3,Cars_gNumCars
	addiu	$2,$2,%lo(Cars_gTotalSortedList) # low
	sw	$0,%lo(leaderBoard)($9)
	sw	$0,4($6)
	sw	$0,8($6)
	sw	$0,12($6)
	addu	$5,$3,-1
	sll	$3,$5,2
	addu	$3,$3,$2
$L902:
	bltz	$5,$L909
	lw	$4,0($3)
	#nop
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L904
	lw	$2,%lo(leaderBoard)($9)
	#nop
	bne	$2,$0,$L904
	lw	$2,1892($4)
	#nop
	bne	$2,$0,$L904
	sw	$4,%lo(leaderBoard)($9)
$L904:
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L905
	sw	$8,1896($4)
	move	$8,$4
	sw	$7,1908($4)
	lw	$2,8($6)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L906
	addu	$7,$7,1
	.set	macro
	.set	reorder

	sw	$4,8($6)
$L906:
	sw	$4,12($6)
$L905:
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L907
	lw	$2,4($6)
	#nop
	bne	$2,$0,$L907
	sw	$4,4($6)
$L907:
	addu	$3,$3,-4
	.set	noreorder
	.set	nomacro
	j	$L902
	addu	$5,$5,-1
	.set	macro
	.set	reorder

$L909:
	j	$31
	.end	AISpeeds_MaintainLeaderBoard__Fv
	.text
	.ent	AISpeeds_GetScriptFactor__FP8Car_tObj
AISpeeds_GetScriptFactor__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	addu	$16,$4,1268
	move	$4,$16
	li	$5,4			# 0x00000004
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L911
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$17,$L913
	li	$2,32768			# 0x00008000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L913
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

$L911:
	li	$2,65536			# 0x00010000
	ori	$2,$2,0x8000
$L913:
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

	.end	AISpeeds_GetScriptFactor__FP8Car_tObj
	.text
	.ent	AISpeeds_GetUpgradeAccMult__Fi
AISpeeds_GetUpgradeAccMult__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(Cars_gList) # high
	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,0($4)
	#nop
	lw	$2,648($16)
	#nop
	lw	$2,60($2)
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L915
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lui	$2,%hi(engineUpgrade) # high
	lw	$5,%lo(engineUpgrade)($2)
	jal	fixedmult
	move	$4,$2
$L915:
	lw	$2,648($16)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L916
	lui	$2,%hi(suspensionUpgrade) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(suspensionUpgrade)($2)
	jal	fixedmult
	move	$4,$2
$L916:
	lw	$2,648($16)
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L917
	lui	$2,%hi(aeroUpgrade) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(aeroUpgrade)($2)
	jal	fixedmult
	move	$4,$2
$L917:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AISpeeds_GetUpgradeAccMult__Fi
	.text
	.ent	AISpeeds_GetUpgradeBrakeMult__Fi
AISpeeds_GetUpgradeBrakeMult__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(Cars_gList) # high
	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,0($4)
	#nop
	lw	$2,648($16)
	#nop
	lw	$2,60($2)
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L919
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lui	$2,%hi(engineUpgrade+4) # high
	lw	$5,%lo(engineUpgrade+4)($2)
	jal	fixedmult
	move	$4,$2
$L919:
	lw	$2,648($16)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L920
	lui	$2,%hi(suspensionUpgrade+4) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(suspensionUpgrade+4)($2)
	jal	fixedmult
	move	$4,$2
$L920:
	lw	$2,648($16)
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L921
	lui	$2,%hi(aeroUpgrade+4) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(aeroUpgrade+4)($2)
	jal	fixedmult
	move	$4,$2
$L921:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AISpeeds_GetUpgradeBrakeMult__Fi
	.text
	.ent	AISpeeds_GetUpgradeHandlingMult__Fi
AISpeeds_GetUpgradeHandlingMult__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(Cars_gList) # high
	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,0($4)
	#nop
	lw	$2,648($16)
	#nop
	lw	$2,60($2)
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L923
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lui	$2,%hi(engineUpgrade+8) # high
	lw	$5,%lo(engineUpgrade+8)($2)
	jal	fixedmult
	move	$4,$2
$L923:
	lw	$2,648($16)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L924
	lui	$2,%hi(suspensionUpgrade+8) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(suspensionUpgrade+8)($2)
	jal	fixedmult
	move	$4,$2
$L924:
	lw	$2,648($16)
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L925
	lui	$2,%hi(aeroUpgrade+8) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(aeroUpgrade+8)($2)
	jal	fixedmult
	move	$4,$2
$L925:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AISpeeds_GetUpgradeHandlingMult__Fi
	.text
	.ent	AISpeeds_GetUpgradeTopSpeedMult__Fi
AISpeeds_GetUpgradeTopSpeedMult__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(Cars_gList) # high
	addiu	$2,$2,%lo(Cars_gList) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$16,0($4)
	#nop
	lw	$2,648($16)
	#nop
	lw	$2,60($2)
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L927
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	lui	$2,%hi(engineUpgrade+12) # high
	lw	$5,%lo(engineUpgrade+12)($2)
	jal	fixedmult
	move	$4,$2
$L927:
	lw	$2,648($16)
	#nop
	lw	$2,64($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L928
	lui	$2,%hi(suspensionUpgrade+12) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(suspensionUpgrade+12)($2)
	jal	fixedmult
	move	$4,$2
$L928:
	lw	$2,648($16)
	#nop
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L929
	lui	$2,%hi(aeroUpgrade+12) # high
	.set	macro
	.set	reorder

	lw	$5,%lo(aeroUpgrade+12)($2)
	jal	fixedmult
	move	$4,$2
$L929:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AISpeeds_GetUpgradeTopSpeedMult__Fi
	.text
	.ent	AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
AISpeeds_CalcHumanTopSpeed__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
	.text
	.ent	AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lh	$5,8($18)
	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L932
	move	$17,$5
	.set	macro
	.set	reorder

	subu	$5,$5,$3
$L932:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	lw	$3,1364($18)
	move	$16,$2
	sll	$2,$3,2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L933
	addu	$5,$17,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L935
	.set	noreorder
	.set	nomacro
	j	$L935
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L933:
	bgez	$5,$L935
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L935:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$3,$2
	slt	$2,$16,$3
	beq	$2,$0,$L937
	move	$16,$3
$L937:
	lw	$2,1364($18)
	#nop
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	bltz	$2,$L938
	addu	$5,$17,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L940
	.set	noreorder
	.set	nomacro
	j	$L940
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L938:
	bgez	$5,$L940
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L940:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$3,$2
	slt	$2,$16,$3
	beq	$2,$0,$L942
	move	$16,$3
$L942:
	lw	$3,1364($18)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L943
	addu	$5,$17,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L945
	.set	noreorder
	.set	nomacro
	j	$L945
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L943:
	bgez	$5,$L945
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L945:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$3,$2
	slt	$2,$16,$3
	beq	$2,$0,$L947
	move	$16,$3
$L947:
	lw	$2,1364($18)
	#nop
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	bltz	$2,$L948
	addu	$5,$17,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L950
	.set	noreorder
	.set	nomacro
	j	$L950
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L948:
	bgez	$5,$L950
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L950:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$3,$2
	slt	$2,$16,$3
	beq	$2,$0,$L952
	move	$16,$3
$L952:
	lw	$3,1364($18)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L953
	addu	$5,$17,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L955
	.set	noreorder
	.set	nomacro
	j	$L955
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L953:
	bgez	$5,$L955
	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L955:
	lw	$4,AIDataRecord_TrackCurve
	jal	Get__25AIDataRecord_TrackCurve_ti
	move	$3,$2
	slt	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L960
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	move	$16,$3
$L960:
	ori	$2,$2,0xa666
	mult	$16,$2
	mflo	$5
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L961
	sra	$16,$5,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$5,$5,$2
	sra	$16,$5,16
$L961:
	slt	$2,$16,256
	bne	$2,$0,$L959
	li	$16,255			# 0x000000ff
$L959:
	lw	$4,1716($18)
	.set	noreorder
	.set	nomacro
	jal	Get__30AIDataRecord_CurveSpeedTable_ti
	move	$5,$16
	.set	macro
	.set	reorder

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

	.end	AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
