	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\cars.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	Cars_topSpeedCap
	.data
	.align	2
Cars_topSpeedCap:
	.word	4107141
	.word	3932160
	.word	4653056
	.word	4587520
	.word	4660264
	.word	4631429
	.word	4805754
	.word	4514775
	.word	4543610
	.word	5097390
	.word	5388369
	.word	5417861
	.word	5796003
	.word	6087639
	.word	5825495
	.word	6552944
	.word	7274496
	.word	7274496
	.word	7274496
	.word	7274496
	.word	7274496
	.word	7274496
	.globl	Cars_kSmokingSurface
	.align	2
Cars_kSmokingSurface:
	.word	0
	.word	0
	.word	655360
	.word	0
	.word	0
	.word	1310720
	.word	0
	.word	0
	.word	0
	.word	655360
	.word	0
	.word	0
	.word	1310720
	.word	1310720
	.word	0
	.word	655360
	.globl	Cars_kSkidMarkSurface
	.align	2
Cars_kSkidMarkSurface:
	.word	0
	.word	1
	.word	2
	.word	2
	.word	1
	.word	2
	.word	0
	.word	1
	.word	0
	.word	2
	.word	1
	.word	1
	.word	1
	.word	2
	.word	0
	.word	2
	.globl	Cars_kConvertFromRoadToSfxType
	.align	2
Cars_kConvertFromRoadToSfxType:
	.word	0
	.word	1
	.word	7
	.word	8
	.word	1
	.word	6
	.word	0
	.word	1
	.word	0
	.word	9
	.word	1
	.word	1
	.word	1
	.word	6
	.word	0
	.word	9
	.globl	Cars_kAudioRoadSurfaceInterface
	.align	2
Cars_kAudioRoadSurfaceInterface:
	.word	0
	.word	0
	.word	3
	.word	12
	.word	0
	.word	3
	.word	0
	.word	0
	.word	11
	.word	11
	.word	0
	.word	0
	.word	3
	.word	3
	.word	3
	.word	11
	.globl	Cars_kSFXWallSurfaceInterface
	.align	2
Cars_kSFXWallSurfaceInterface:
	.word	0
	.word	4
	.word	4
	.word	6
	.word	4
	.word	8
	.word	0
	.word	6
	.globl	Cars_kAudioWallSurfaceInterface
	.align	2
Cars_kAudioWallSurfaceInterface:
	.word	4
	.word	4
	.word	4
	.word	13
	.word	4
	.word	14
	.word	13
	.word	13
	.globl	Cars_kAudioCollisoinTypeInterface
	.align	2
Cars_kAudioCollisoinTypeInterface:
	.word	1
	.word	2
	.word	2
	.word	2
	.word	1
	.word	1
	.word	1
	.text
	.align	2
	.globl	Cars_DoGravityEffectsOnAcc__FP8Car_tObji
	.align	2
	.globl	Cars_GetDashData__FP8Car_tObjPiN21
	.align	2
	.globl	Cars_QDUpdateVelGlue__FP8Car_tObj
	.align	2
	.globl	Cars_InitDashData__FP8Car_tObjPiT1
	.align	2
	.globl	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	.align	2
	.globl	Cars_ResetCarCounters__Fv
	.align	2
	.globl	Cars_InitStats__FP8Car_tObj
	.sdata
	.align	2
$LC0:
	.ascii	"\000"
	.text
	.align	2
	.globl	Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
	.globl	frontLimit
	.sdata
	.align	2
frontLimit:
	.word	32768
	.globl	rearLimit
	.align	2
rearLimit:
	.word	65536
	.text
	.align	2
	.globl	Cars_ResetVariablesAfterACollision__FP8Car_tObj
	.align	2
	.globl	Cars_ResetCollidedCars__FP8Car_tObjii
	.align	2
	.globl	Cars_SetCarUpForHiRezSim__FP8Car_tObj
	.align	2
	.globl	Cars_DoExtraCarCollisionProcessing__FP8Car_tObj
	.align	2
	.globl	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	.align	2
	.globl	Car_TireSkiddingStuff__FP8Car_tObj
	.align	2
	.globl	Cars_FindTotalSlice__FP8Car_tObj
	.align	2
	.globl	Car_DoSkiddingStuff__FP8Car_tObj
	.align	2
	.globl	Car_DoPostCollisionStuff__FP8Car_tObj
	.align	2
	.globl	Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
	.align	2
	.globl	Cars_IniCarObjects__FP8Car_tObji
	.rdata
	.align	2
$LC1:
	.ascii	"%s%s.qda\000"
	.align	2
$LC2:
	.ascii	"%sSTDR.qda\000"
	.sdata
	.align	2
$LC3:
	.ascii	"p%s.dat\000"
	.rdata
	.align	2
$LC4:
	.ascii	"ptram.dat\000"
	.align	2
$LC5:
	.ascii	"%sdusty.viv\000"
	.align	2
$LC6:
	.ascii	"carSpecs\000"
	.text
	.align	2
	.globl	Cars_InitCar__FP8Car_tObji
	.align	2
	.globl	Cars_DeInitCar__FP8Car_tObj
	.align	2
	.globl	Cars_Restart__Fv
	.align	2
	.globl	Cars_Initialize__FPci
	.rdata
	.align	2
$LC7:
	.ascii	"Car_tObj\000"
	.text
	.align	2
	.globl	Cars_StartUp__Fv
	.align	2
	.globl	Cars_CleanUp__Fv
	.align	2
	.globl	Cars_FindCurrentLap__FP8Car_tObj
	.align	2
	.globl	Cars_CalculateRoadSpan__FP8Car_tObj
	.align	2
	.globl	Cars_CalculateRoadPosition__FP8Car_tObj
	.align	2
	.globl	Cars_CalcVelDownRoad__FP8Car_tObj
	.align	2
	.globl	Cars_Randomize__Fv
	.align	2
	.globl	Cars_ManageBureaucracy__Fv
	.align	2
	.globl	Cars_CheckForAccidentScenes__Fv
	.align	2
	.globl	Cars_SortCars__Fv
	.globl	Cars_gList
	.data
	.align	2
Cars_gList:
	.space	36
	.globl	Cars_gRaceCarList
	.align	2
Cars_gRaceCarList:
	.space	36
	.globl	Cars_gAICarList
	.align	2
Cars_gAICarList:
	.space	36
	.globl	Cars_gHumanRaceCarList
	.align	2
Cars_gHumanRaceCarList:
	.space	36
	.globl	Cars_gAIRaceCarList
	.align	2
Cars_gAIRaceCarList:
	.space	36
	.globl	Cars_gTrafficCarList
	.align	2
Cars_gTrafficCarList:
	.space	36
	.globl	Cars_gCopCarList
	.align	2
Cars_gCopCarList:
	.space	36
	.globl	Cars_gLifeBasisCarList
	.align	2
Cars_gLifeBasisCarList:
	.space	36
	.globl	Cars_gSortedList
	.align	2
Cars_gSortedList:
	.space	36
	.globl	Cars_gTotalSortedList
	.align	2
Cars_gTotalSortedList:
	.space	36
	.globl	Cars_gNewCarStatsList
	.align	2
Cars_gNewCarStatsList:
	.space	1440
	.globl	InfiniteMassNewton
	.align	2
InfiniteMassNewton:
	.space	2880
	.globl	Cars_gNumCars
	.sdata
	.align	2
Cars_gNumCars:
	.space	4
	.globl	Cars_gNumRaceCars
	.align	2
Cars_gNumRaceCars:
	.space	4
	.globl	Cars_gNumAICars
	.align	2
Cars_gNumAICars:
	.space	4
	.globl	Cars_gNumHumanRaceCars
	.align	2
Cars_gNumHumanRaceCars:
	.space	4
	.globl	Cars_gNumAIRaceCars
	.align	2
Cars_gNumAIRaceCars:
	.space	4
	.globl	Cars_gNumTrafficCars
	.align	2
Cars_gNumTrafficCars:
	.space	4
	.globl	Cars_gNumCopCars
	.align	2
Cars_gNumCopCars:
	.space	4
	.globl	Cars_gNumLifeBasisCars
	.align	2
Cars_gNumLifeBasisCars:
	.space	4
	.globl	accidentSlice
	.align	2
accidentSlice:
	.space	4

	.extern	SceneLoaded, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	R3DCar_LicenseShapeFile, 4
	.extern	Object_IMassObjInst, 4
	.extern	gLeafPixmap, 4
	.extern	gTAddCarWheelDelay, 4
	.extern	Camera_gInfo, 544
	.extern	simGlobal, 24
	.extern	BWorldSm_slices, 4
	.extern	AITune_driveSide, 4
	.extern	gNumSlices, 4
	.extern	GameSetup_gPersonalityNames, 120
	.extern	GameSetup_gData, 2600
	.extern	frontEnd, 1104
	.extern	GameSetup_gCarNames, 255

	.text
	.text
	.ent	Cars_DoGravityEffectsOnAcc__FP8Car_tObji
Cars_DoGravityEffectsOnAcc__FP8Car_tObji:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,36($sp)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0010
	bne	$2,$0,$L494
	lw	$5,256($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$3,46529			# 0x0000b5c1
	slt	$3,$3,$2
	bne	$3,$0,$L496
	lw	$5,244($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,-655360			# 0xfff60000
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	lw	$5,256($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,-655360			# 0xfff60000
	.set	macro
	.set	reorder

	sw	$2,20($sp)
	lw	$5,268($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,-655360			# 0xfff60000
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	lw	$2,1036($16)
	lw	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,1036($16)
	lw	$2,1040($16)
	lw	$3,20($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,1040($16)
	lw	$2,1044($16)
	lw	$3,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L504
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L496:
	lbu	$2,1088($16)
	#nop
	sltu	$2,$2,64
	beq	$2,$0,$L494
	lw	$5,268($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,-655360			# 0xfff60000
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	lw	$5,148($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	bgez	$3,1f
	move	$2,$3
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,3277
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L494
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	blez	$3,$L500
	lw	$4,1044($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L502
	sra	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L502
	sra	$2,$3,3
	.set	macro
	.set	reorder

$L500:
	lw	$4,1044($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L502
	sra	$2,$3,3
	.set	macro
	.set	reorder

	sra	$2,$3,1
$L502:
	addu	$2,$4,$2
$L504:
	sw	$2,1044($16)
$L494:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Cars_DoGravityEffectsOnAcc__FP8Car_tObji
	.text
	.ent	Cars_GetDashData__FP8Car_tObjPiN21
Cars_GetDashData__FP8Car_tObjPiN21:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1128($4)
	#nop
	sw	$2,0($5)
	lbu	$2,1090($4)
	#nop
	sw	$2,0($6)
	lw	$2,1056($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	Cars_GetDashData__FP8Car_tObjPiN21
	.text
	.ent	Cars_QDUpdateVelGlue__FP8Car_tObj
Cars_QDUpdateVelGlue__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,172($4)
	lw	$6,624($4)
	.set	noreorder
	.set	nomacro
	bgez	$2,$L511
	move	$5,$6
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L511:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L508
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$5,$6,255
$L508:
	sra	$7,$5,8
	mult	$3,$7
	lw	$5,180($4)
	lw	$2,176($4)
	lw	$3,164($4)
	sra	$2,$2,6
	addu	$3,$3,$2
	lw	$2,160($4)
	sw	$3,164($4)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,6
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$5,$L509
	sw	$2,160($4)
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L509:
	sra	$3,$5,8
	mult	$3,$7
	lw	$2,168($4)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,6
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,168($4)
	.set	macro
	.set	reorder

	.end	Cars_QDUpdateVelGlue__FP8Car_tObj
	.text
	.ent	Cars_InitDashData__FP8Car_tObjPiT1
Cars_InitDashData__FP8Car_tObjPiT1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,1124($4)
	#nop
	lw	$2,240($2)
	#nop
	sw	$2,0($5)
	lw	$2,1124($4)
	#nop
	lw	$2,244($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder

	.end	Cars_InitDashData__FP8Car_tObjPiT1
	.text
	.ent	Cars_SetAudioCalls__FP8Car_tObjiiiiii
Cars_SetAudioCalls__FP8Car_tObjiiiiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$4,$2
	sw	$5,1944($2)
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$4,$2
	sw	$6,1948($2)
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$4,$2
	sw	$7,1952($2)
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	lw	$3,16($sp)
	addu	$2,$4,$2
	sw	$3,1956($2)
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	lw	$3,20($sp)
	addu	$2,$4,$2
	sw	$3,1960($2)
	lw	$3,1940($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	lw	$3,24($sp)
	addu	$2,$4,$2
	sw	$3,1964($2)
	lw	$2,1940($4)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,1940($4)
	.set	macro
	.set	reorder

	.end	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	.text
	.ent	Cars_ResetCarCounters__Fv
Cars_ResetCarCounters__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,Cars_gNumCars
	sw	$0,Cars_gNumRaceCars
	sw	$0,Cars_gNumAICars
	sw	$0,Cars_gNumHumanRaceCars
	sw	$0,Cars_gNumAIRaceCars
	sw	$0,Cars_gNumTrafficCars
	sw	$0,Cars_gNumCopCars
	sw	$0,Cars_gNumLifeBasisCars
	j	$31
	.end	Cars_ResetCarCounters__Fv
	.text
	.ent	Cars_InitStats__FP8Car_tObj
Cars_InitStats__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	addu	$4,$4,844
	move	$3,$4
	li	$2,512			# 0x00000200
	sw	$0,4($4)
	sw	$0,8($4)
	sw	$0,12($4)
	sw	$0,16($4)
	sw	$0,20($4)
	sw	$2,24($4)
$L516:
	sw	$0,28($3)
	sw	$0,44($3)
	addu	$5,$5,1
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L516
	addu	$3,$3,4
	.set	macro
	.set	reorder

	sw	$0,60($4)
	sw	$0,64($4)
	sw	$0,68($4)
	sw	$0,76($4)
	sw	$0,72($4)
	sw	$0,80($4)
	sw	$0,84($4)
	sw	$0,88($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,92($4)
	.set	macro
	.set	reorder

	.end	Cars_InitStats__FP8Car_tObj
	.text
	.ent	Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	addu	$4,$17,576
	lui	$2,%hi(Cars_gList) # high
	lw	$6,Cars_gNumCars
	addiu	$2,$2,%lo(Cars_gList) # low
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$5,648($17)
	sll	$3,$6,2
	lw	$19,4($5)
	addu	$2,$3,$2
	sw	$17,0($2)
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$2,$2,%lo(Cars_gSortedList) # low
	addu	$2,$3,$2
	sw	$17,0($2)
	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$2,$2,%lo(Cars_gTotalSortedList) # low
	addu	$3,$3,$2
	li	$2,-1			# 0xffffffff
	sw	$17,0($3)
	sw	$6,596($17)
	addu	$6,$6,1
	lw	$3,648($17)
	lui	$5,%hi(GameSetup_gCarNames) # high
	sw	$0,608($17)
	sw	$2,600($17)
	lw	$3,0($3)
	addiu	$5,$5,%lo(GameSetup_gCarNames) # low
	sw	$6,Cars_gNumCars
	sll	$2,$3,2
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$2,648($17)
	#nop
	lw	$4,0($2)
	#nop
	slt	$2,$4,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L521
	lui	$5,%hi($LC0) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,78
	.set	macro
	.set	reorder

	addu	$4,$17,585
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L544
	andi	$2,$19,0x0001
	.set	macro
	.set	reorder

$L521:
	addu	$4,$17,585
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	andi	$2,$19,0x0001
$L544:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L546
	andi	$2,$19,0x0002
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumHumanRaceCars
	jal	PlayerNameExist__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L525
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumHumanRaceCars
	jal	PlayerNameMixedCase__Fi
	j	$L529
$L525:
	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L527
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,47			# 0x0000002f
	.set	macro
	.set	reorder

	move	$5,$2
	lw	$4,648($17)
	lw	$6,Cars_gNumHumanRaceCars
	addu	$4,$4,92
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L545
	lui	$5,%hi(frontEnd+900) # high
	.set	macro
	.set	reorder

$L527:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,46			# 0x0000002e
	.set	macro
	.set	reorder

$L529:
	lw	$4,648($17)
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$4,92
	.set	macro
	.set	reorder

	lui	$5,%hi(frontEnd+900) # high
$L545:
	addiu	$5,$5,%lo(frontEnd+900) # low
	lw	$4,648($17)
	lw	$2,Cars_gNumHumanRaceCars
	addu	$4,$4,104
	sll	$2,$2,3
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$4,Cars_gNumHumanRaceCars
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$4,600($17)
	addu	$4,$4,1
	lui	$3,%hi(Cars_gRaceCarList) # high
	sw	$17,0($2)
	lw	$2,608($17)
	addiu	$3,$3,%lo(Cars_gRaceCarList) # low
	sw	$4,Cars_gNumHumanRaceCars
	lw	$4,Cars_gNumRaceCars
	ori	$2,$2,0x0004
	sw	$2,608($17)
	sll	$2,$4,2
	addu	$2,$2,$3
	addu	$4,$4,1
	lui	$3,%hi(Cars_gLifeBasisCarList) # high
	sw	$17,0($2)
	lw	$2,608($17)
	addiu	$3,$3,%lo(Cars_gLifeBasisCarList) # low
	sw	$4,Cars_gNumRaceCars
	lw	$4,Cars_gNumLifeBasisCars
	ori	$2,$2,0x0001
	sw	$2,608($17)
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$17,0($2)
	lw	$3,608($17)
	addu	$4,$4,1
	sw	$4,Cars_gNumLifeBasisCars
	ori	$2,$3,0x0100
	sw	$2,608($17)
	andi	$2,$19,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L524
	ori	$2,$3,0x0300
	.set	macro
	.set	reorder

	sw	$2,608($17)
$L524:
	andi	$2,$19,0x0002
$L546:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L531
	lui	$16,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$4,$16,%lo(GameSetup_gData) # low
	lui	$5,%hi(GameSetup_gPersonalityNames) # high
	lw	$2,596($17)
	addiu	$5,$5,%lo(GameSetup_gPersonalityNames) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$4,648($17)
	lw	$18,1060($2)
	addu	$4,$4,92
	sll	$2,$18,3
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L533
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L532
$L533:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L534
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L532
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L532
$L534:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,50			# 0x00000032
	.set	macro
	.set	reorder

	lw	$4,648($17)
	.set	noreorder
	.set	nomacro
	j	$L543
	move	$5,$2
	.set	macro
	.set	reorder

$L532:
	lw	$4,648($17)
	sll	$2,$18,3
	lui	$5,%hi(GameSetup_gPersonalityNames) # high
	addiu	$5,$5,%lo(GameSetup_gPersonalityNames) # low
	addu	$5,$2,$5
$L543:
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$4,$4,104
	.set	macro
	.set	reorder

	lw	$4,648($17)
	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	addu	$4,$4,104
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gAICarList) # high
	addiu	$3,$3,%lo(Cars_gAICarList) # low
	lw	$4,Cars_gNumAICars
	lw	$5,Cars_gNumAIRaceCars
	sll	$2,$4,2
	addu	$2,$2,$3
	lui	$3,%hi(Cars_gAIRaceCarList) # high
	addiu	$3,$3,%lo(Cars_gAIRaceCarList) # low
	sw	$17,0($2)
	lw	$2,608($17)
	addu	$4,$4,1
	sw	$4,Cars_gNumAICars
	lw	$4,Cars_gNumRaceCars
	ori	$2,$2,0x0002
	sw	$2,608($17)
	sll	$2,$5,2
	addu	$2,$2,$3
	lui	$3,%hi(Cars_gRaceCarList) # high
	addiu	$3,$3,%lo(Cars_gRaceCarList) # low
	sw	$17,0($2)
	lw	$2,608($17)
	addu	$5,$5,1
	sw	$5,Cars_gNumAIRaceCars
	ori	$2,$2,0x0008
	sw	$2,608($17)
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$17,0($2)
	lw	$2,608($17)
	lui	$3,%hi(GameSetup_gData) # high
	ori	$2,$2,0x0001
	sw	$2,608($17)
	addiu	$2,$3,%lo(GameSetup_gData) # low
	lw	$2,20($2)
	addu	$4,$4,1
	sw	$4,Cars_gNumRaceCars
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L531
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L538
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L547
	lui	$3,%hi(Cars_gLifeBasisCarList) # high
	.set	macro
	.set	reorder

$L538:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L531
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L547
	lui	$3,%hi(Cars_gLifeBasisCarList) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L548
	andi	$2,$19,0x0004
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gLifeBasisCarList) # high
$L547:
	lw	$4,Cars_gNumLifeBasisCars
	addiu	$3,$3,%lo(Cars_gLifeBasisCarList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$17,0($2)
	lw	$2,608($17)
	addu	$4,$4,1
	sw	$4,Cars_gNumLifeBasisCars
	ori	$2,$2,0x0100
	sw	$2,608($17)
$L531:
	andi	$2,$19,0x0004
$L548:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L539
	lui	$3,%hi(Cars_gAICarList) # high
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumAICars
	addiu	$3,$3,%lo(Cars_gAICarList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	addu	$4,$4,1
	lui	$3,%hi(Cars_gTrafficCarList) # high
	sw	$17,0($2)
	lw	$2,608($17)
	addiu	$3,$3,%lo(Cars_gTrafficCarList) # low
	sw	$4,Cars_gNumAICars
	lw	$4,Cars_gNumTrafficCars
	ori	$2,$2,0x0002
	sw	$2,608($17)
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$17,0($2)
	lw	$2,608($17)
	addu	$4,$4,1
	sw	$4,Cars_gNumTrafficCars
	ori	$2,$2,0x0010
	sw	$2,608($17)
$L539:
	andi	$2,$19,0x0018
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L520
	lui	$3,%hi(Cars_gAICarList) # high
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumAICars
	addiu	$3,$3,%lo(Cars_gAICarList) # low
	sll	$2,$4,2
	addu	$2,$2,$3
	addu	$4,$4,1
	lui	$3,%hi(Cars_gCopCarList) # high
	sw	$17,0($2)
	lw	$2,608($17)
	addiu	$3,$3,%lo(Cars_gCopCarList) # low
	sw	$4,Cars_gNumAICars
	lw	$4,Cars_gNumCopCars
	ori	$2,$2,0x0002
	sw	$2,608($17)
	sll	$2,$4,2
	addu	$2,$2,$3
	sw	$17,0($2)
	lw	$3,608($17)
	addu	$4,$4,1
	sw	$4,Cars_gNumCopCars
	ori	$2,$3,0x0020
	sw	$2,608($17)
	andi	$2,$19,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L520
	ori	$2,$3,0x0060
	.set	macro
	.set	reorder

	sw	$2,608($17)
$L520:
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

	.end	Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
	.text
	.ent	Cars_ResetVariablesAfterACollision__FP8Car_tObj
Cars_ResetVariablesAfterACollision__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sw	$0,276($4)
	sw	$0,280($4)
	sw	$0,284($4)
	sw	$0,1060($4)
	sw	$0,1064($4)
	sw	$0,1068($4)
	sw	$0,1036($4)
	sw	$0,1040($4)
	sw	$0,1044($4)
	sh	$0,380($4)
	sw	$0,396($4)
	sw	$0,428($4)
	sw	$0,400($4)
	sw	$0,404($4)
	sw	$0,412($4)
	sw	$0,388($4)
	sw	$0,192($4)
	sw	$0,1932($4)
	.set	noreorder
	.set	nomacro
	jal	Physics_ResetCar__FP8Car_tObj
	sw	$0,372($4)
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

	.end	Cars_ResetVariablesAfterACollision__FP8Car_tObj
	.text
	.ent	Cars_ResetCollidedCars__FP8Car_tObjii
Cars_ResetCollidedCars__FP8Car_tObjii:
	.frame	$sp,56,$31		# vars= 16, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$17,36($sp)
	move	$17,$5
	addu	$4,$sp,16
	move	$5,$0
	li	$6,12			# 0x0000000c
	sw	$31,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	lw	$2,628($18)
	lw	$19,1360($18)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L551
	sw	$0,1932($18)
	.set	macro
	.set	reorder

	bne	$17,$0,$L553
	lw	$3,336($18)
	#nop
	bgez	$3,$L555
	addu	$3,$3,255
$L555:
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L556
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L556:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,340($18)
	mflo	$5
	#nop
	bgez	$3,$L557
	addu	$3,$3,255
$L557:
	lw	$2,256($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L558
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L558:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,344($18)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L559
	addu	$3,$5,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L559:
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L560
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L560:
	sra	$2,$2,8
	mult	$4,$2
	li	$2,49152			# 0x0000c000
	mflo	$8
	#nop
	#nop
	addu	$3,$3,$8
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L553
	li	$4,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	lw	$2,276($18)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L553
	lw	$2,284($18)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L553
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lw	$3,448($18)
	#nop
	beq	$3,$2,$L553
	beq	$3,$0,$L553
	lw	$2,128($18)
	#nop
	beq	$2,$0,$L553
	lhu	$2,380($18)
	#nop
	sltu	$2,$2,6
	beq	$2,$0,$L553
	lw	$2,392($18)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L553
	.set	noreorder
	.set	nomacro
	j	$L551
	sw	$0,1932($18)
	.set	macro
	.set	reorder

$L553:
	lh	$16,8($18)
	sll	$2,$19,2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L561
	addu	$5,$16,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L592
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L592
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L561:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L592
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
	li	$2,2			# 0x00000002
$L592:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L565
	move	$16,$5
	.set	macro
	.set	reorder

	lh	$16,8($18)
$L565:
	lw	$3,accidentSlice
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L566
	addu	$4,$3,5
	.set	macro
	.set	reorder

	lw	$5,gNumSlices
	#nop
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L568
	slt	$2,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L593
	addu	$2,$3,-5
	.set	macro
	.set	reorder

	j	$L566
$L568:
	addu	$2,$5,-5
	subu	$2,$3,$2
	slt	$2,$16,$2
	beq	$2,$0,$L566
	lw	$3,accidentSlice
	#nop
	addu	$2,$3,-5
$L593:
	.set	noreorder
	.set	nomacro
	bltz	$2,$L570
	slt	$2,$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L594
	sll	$2,$19,2
	.set	macro
	.set	reorder

	j	$L566
$L570:
	lw	$2,gNumSlices
	#nop
	addu	$2,$2,-5
	addu	$2,$3,$2
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L566
	sll	$2,$19,2
	.set	macro
	.set	reorder

$L594:
	addu	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bltz	$2,$L572
	addu	$5,$16,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L566
	move	$16,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L575
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L572:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L566
	move	$16,$5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L575:
	move	$16,$5
$L566:
	lw	$3,596($18)
	move	$20,$0
	li	$4,-1			# 0xffffffff
	srl	$2,$3,31
	addu	$2,$3,$2
	sra	$2,$2,1
	sll	$2,$2,1
	xor	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$19,$4,$L576
	sltu	$3,$0,$2
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	subu	$3,$2,$3
$L576:
	lw	$2,AITune_driveSide
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L577
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	subu	$3,$2,$3
$L577:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L578
	sll	$2,$16,5
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	#nop
	addu	$2,$2,$3
	lbu	$3,30($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	srl	$2,$2,4
	mult	$3,$2
	lw	$3,308($18)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L579
	subu	$4,$0,$8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L579:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,7
	.set	noreorder
	.set	nomacro
	j	$L589
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L588:
	sw	$0,16($sp)
	move	$5,$16
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	move	$7,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L591
	move	$4,$18
	.set	macro
	.set	reorder

$L578:
	lw	$3,BWorldSm_slices
	#nop
	addu	$2,$2,$3
	lbu	$3,31($2)
	lbu	$2,29($2)
	sll	$3,$3,15
	andi	$2,$2,0x000f
	mult	$3,$2
	lw	$4,308($18)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L595
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
	sra	$3,$4,8
$L595:
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,7
	subu	$2,$9,$2
$L589:
	sw	$2,16($sp)
	move	$4,$18
	move	$5,$16
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	move	$7,$19
	.set	macro
	.set	reorder

	lw	$3,448($18)
	.set	noreorder
	.set	nomacro
	j	$L590
	move	$17,$0
	.set	macro
	.set	reorder

$L596:
	move	$5,$16
$L597:
	addu	$6,$sp,16
$L598:
	move	$7,$19
	addu	$17,$17,1
	lw	$2,16($sp)
	sll	$3,$20,14
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	slt	$2,$17,41
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L588
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,448($18)
$L590:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L596
	move	$4,$18
	.set	macro
	.set	reorder

	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L597
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,128($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L598
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	move	$4,$18
$L591:
	sw	$0,180($4)
	sw	$0,176($4)
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetVariablesAfterACollision__FP8Car_tObj
	sw	$0,172($4)
	.set	macro
	.set	reorder

$L551:
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

	.end	Cars_ResetCollidedCars__FP8Car_tObjii
	.text
	.ent	Cars_SetCarUpForHiRezSim__FP8Car_tObj
Cars_SetCarUpForHiRezSim__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lbu	$2,144($16)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L599
	sw	$0,1932($16)
	.set	macro
	.set	reorder

	addu	$4,$16,160
	addu	$5,$16,8
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,128($16)
	#nop
	beq	$2,$0,$L599
	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L599
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$0
	.set	macro
	.set	reorder

$L599:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cars_SetCarUpForHiRezSim__FP8Car_tObj
	.text
	.ent	Cars_DoExtraCarCollisionProcessing__FP8Car_tObj
Cars_DoExtraCarCollisionProcessing__FP8Car_tObj:
	.frame	$sp,120,$31		# vars= 64, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$17,100($sp)
	move	$17,$4
	sw	$31,112($sp)
	sw	$19,108($sp)
	sw	$18,104($sp)
	sw	$16,96($sp)
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0400
	bne	$2,$0,$L603
	lw	$3,628($17)
	#nop
	beq	$3,$0,$L605
	lw	$2,1056($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,6553
	beq	$2,$0,$L606
	lw	$2,1048($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,628($17)
$L606:
	lw	$2,628($17)
	#nop
	slt	$2,$2,321
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L605
	move	$4,$17
	.set	macro
	.set	reorder

	sw	$0,628($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$0
	.set	macro
	.set	reorder

$L605:
	lw	$2,628($17)
	#nop
	bne	$2,$0,$L609
	lw	$2,632($17)
	#nop
	bne	$2,$0,$L609
	lbu	$2,1097($17)
	#nop
	beq	$2,$0,$L609
	lw	$2,912($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,833
	bne	$2,$0,$L609
	lw	$2,908($17)
	#nop
	bne	$2,$0,$L683
	li	$2,1769472			# 0x001b0000
	lw	$3,192($17)
	ori	$2,$2,0x9998
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$0
	.set	macro
	.set	reorder

	li	$2,160			# 0x000000a0
	sw	$2,908($17)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lui	$4,%hi(Camera_gInfo) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	addiu	$4,$4,%lo(Camera_gInfo) # low
	xor	$2,$17,$2
	sltu	$2,$2,1
	sll	$3,$2,4
	addu	$3,$3,$2
	sll	$3,$3,4
	lw	$2,264($17)
	addu	$3,$3,$4
	subu	$2,$0,$2
	sll	$2,$2,1
	sw	$2,20($3)
	lw	$2,268($17)
	#nop
	subu	$2,$0,$2
	sll	$2,$2,1
	sw	$2,24($3)
	lw	$2,272($17)
	#nop
	subu	$2,$0,$2
	sll	$2,$2,1
	sw	$2,28($3)
$L609:
	lw	$2,908($17)
$L683:
	.set	noreorder
	.set	nomacro
	blez	$2,$L616
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	sw	$2,908($17)
$L616:
	lw	$2,1932($17)
	#nop
	beq	$2,$0,$L617
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_CrashCar__FP8coorddef
	addu	$4,$17,160
	.set	macro
	.set	reorder

	lhu	$2,380($17)
	#nop
	bne	$2,$0,$L617
	sw	$0,1932($17)
$L617:
	lw	$2,1936($17)
	#nop
	beq	$2,$0,$L619
	lbu	$2,144($17)
	#nop
	bne	$2,$0,$L619
	lw	$2,2132($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L620
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$16,3			# 0x00000003
$L620:
	sll	$2,$16,1
	addu	$2,$2,$16
	sll	$2,$2,4
	addu	$2,$17,$2
	lui	$3,%hi(Cars_kSkidMarkSurface) # high
	lw	$2,696($2)
	addiu	$3,$3,%lo(Cars_kSkidMarkSurface) # low
	andi	$2,$2,0x000f
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,0($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L621
	jal	random
	andi	$2,$2,0x0003
	bne	$2,$0,$L621
	lw	$2,224($17)
	#nop
	bgez	$2,$L623
	addu	$2,$2,255
$L623:
	lw	$3,240($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L684
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L684:
	sw	$8,64($sp)
	lw	$2,224($17)
	#nop
	bgez	$2,$L625
	addu	$2,$2,255
$L625:
	lw	$3,244($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L685
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L685:
	sw	$7,68($sp)
	lw	$2,224($17)
	#nop
	bgez	$2,$L627
	addu	$2,$2,255
$L627:
	lw	$3,248($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L686
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L686:
	sw	$6,72($sp)
	sw	$0,80($sp)
	sw	$0,84($sp)
	sw	$0,88($sp)
	lw	$4,160($17)
	#nop
	sw	$4,32($sp)
	lw	$2,164($17)
	#nop
	sw	$2,36($sp)
	lw	$5,168($17)
	#nop
	sw	$5,40($sp)
	lw	$3,384($17)
	andi	$2,$16,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	sw	$3,36($sp)
	.set	macro
	.set	reorder

	subu	$2,$4,$8
	sw	$2,48($sp)
	subu	$2,$3,$7
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L680
	subu	$2,$5,$6
	.set	macro
	.set	reorder

$L629:
	addu	$2,$4,$8
	sw	$2,48($sp)
	addu	$2,$3,$7
	sw	$2,52($sp)
	addu	$2,$5,$6
$L680:
	sw	$2,56($sp)
	addu	$5,$sp,48
	li	$6,4			# 0x00000004
	lw	$2,48($sp)
	lw	$3,80($sp)
	lw	$4,84($sp)
	lw	$7,88($sp)
	subu	$2,$2,$3
	sw	$2,48($sp)
	lw	$2,52($sp)
	lw	$3,56($sp)
	subu	$2,$2,$4
	subu	$3,$3,$7
	sw	$2,52($sp)
	sw	$3,56($sp)
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSfx__FiP8coorddefiT1
	addu	$7,$17,172
	.set	macro
	.set	reorder

$L621:
	sw	$0,1936($17)
$L619:
	lw	$2,400($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	move	$16,$0
	.set	macro
	.set	reorder

	li	$4,-268500992			# 0xefff0000
	lw	$2,648($17)
	lw	$3,408($17)
	lw	$2,0($2)
	#nop
	slt	$2,$2,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	and	$18,$3,$4
	.set	macro
	.set	reorder

	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lw	$3,564($17)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L693
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L693:
	andi	$2,$4,0x0002
$L687:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,548($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	ori	$2,$4,0x0002
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L635:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	lw	$3,568($17)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	ori	$2,$4,0x0004
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L694:
	andi	$2,$4,0x0008
$L688:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,536($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	ori	$2,$4,0x0008
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L639:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	andi	$2,$4,0x0020
	.set	macro
	.set	reorder

	lw	$3,544($17)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	ori	$2,$4,0x0010
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L695:
	andi	$2,$4,0x0020
$L689:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,560($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	ori	$2,$4,0x0020
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L643:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,552($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	ori	$2,$4,0x0040
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L632:
	lw	$2,404($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L690
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$3,400($17)
	li	$2,4915200			# 0x004b0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L648
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_CrashCar__FP8coorddef
	addu	$4,$17,160
	.set	macro
	.set	reorder

	lw	$3,1928($17)
	li	$2,1			# 0x00000001
	sw	$2,1932($17)
	sw	$0,1156($17)
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L647
	sw	$0,1160($17)
	.set	macro
	.set	reorder

	li	$2,320			# 0x00000140
	sw	$2,1928($17)
$L647:
	li	$2,262144			# 0x00040000
$L690:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L650
	li	$3,32768			# 0x00008000
	.set	macro
	.set	reorder

	lw	$9,416($17)
	lw	$10,420($17)
	lw	$11,424($17)
	sw	$9,32($sp)
	sw	$10,36($sp)
	sw	$11,40($sp)
	lw	$2,36($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,36($sp)
	lw	$3,192($17)
	li	$2,1572864			# 0x00180000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$3,392($17)
	li	$2,39320			# 0x00009998
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L652
	lui	$16,%hi(Cars_kSFXWallSurfaceInterface) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(Cars_kSFXWallSurfaceInterface) # low
	lbu	$2,408($17)
	lw	$4,0($17)
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSfx__FiP8coorddefiT1
	addu	$7,$17,172
	.set	macro
	.set	reorder

	lbu	$2,408($17)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$3,0($2)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L650
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	li	$6,-1			# 0xffffffff
	move	$7,$5
	li	$2,15			# 0x0000000f
	sw	$2,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	j	$L650
$L652:
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	j	$L681
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

$L651:
	li	$4,983040			# 0x000f0000
	slt	$2,$4,$3
	bne	$2,$0,$L657
	lw	$2,400($17)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L657
	beq	$16,$0,$L650
$L657:
	lw	$4,0($17)
	addu	$5,$sp,32
	li	$6,1			# 0x00000001
$L681:
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSfx__FiP8coorddefiT1
	addu	$7,$17,172
	.set	macro
	.set	reorder

$L650:
	lw	$3,400($17)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	lui	$2,%hi(Cars_kAudioCollisoinTypeInterface) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_kAudioCollisoinTypeInterface) # low
	sra	$3,$18,14
	addu	$3,$3,$2
	lw	$19,0($3)
	li	$2,262144			# 0x00040000
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L659
	li	$4,196608			# 0x00030000
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_kAudioWallSurfaceInterface) # high
	lbu	$2,408($17)
	addiu	$3,$3,%lo(Cars_kAudioWallSurfaceInterface) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	j	$L682
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L659:
	slt	$2,$4,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L661
	li	$2,327680			# 0x00050000
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_kAudioRoadSurfaceInterface) # high
	lbu	$2,408($17)
	addiu	$3,$3,%lo(Cars_kAudioRoadSurfaceInterface) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	bne	$18,$4,$L660
	li	$2,58981			# 0x0000e665
	.set	macro
	.set	reorder

	lw	$3,300($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L663
	li	$19,1			# 0x00000001
$L663:
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_CrashCar__FP8coorddef
	addu	$4,$17,416
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L682
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L661:
	lbu	$16,408($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L660
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	li	$6,4			# 0x00000004
	lw	$9,416($17)
	lw	$10,420($17)
	lw	$11,424($17)
	sw	$9,32($sp)
	sw	$10,36($sp)
	sw	$11,40($sp)
	lw	$2,36($sp)
	li	$3,32768			# 0x00008000
	addu	$2,$2,$3
	sw	$2,36($sp)
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSfx__FiP8coorddefiT1
	addu	$7,$17,172
	.set	macro
	.set	reorder

$L660:
	sw	$16,16($sp)
$L682:
	lw	$2,400($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L691
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$2,$2,7
$L691:
	li	$5,1			# 0x00000001
	li	$6,-1			# 0xffffffff
	move	$7,$19
	sra	$2,$2,3
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L658:
	sw	$0,400($17)
	sw	$0,404($17)
	sw	$0,408($17)
$L631:
	lw	$3,1928($17)
	#nop
	blez	$3,$L667
	lw	$2,632($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sw	$2,1928($17)
	lw	$2,176($17)
	lw	$3,192($17)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$3,$3,$2
	li	$2,65535			# 0x0000ffff
	slt	$2,$2,$3
	beq	$2,$0,$L669
	lw	$3,448($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L669
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	bne	$3,$2,$L668
$L669:
	lw	$2,1928($17)
	#nop
	addu	$2,$2,-8
	sw	$2,1928($17)
$L668:
	lw	$2,1928($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L667
	move	$4,$17
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCollidedCars__FP8Car_tObjii
	move	$6,$5
	.set	macro
	.set	reorder

	sw	$0,1928($17)
$L667:
	lw	$3,336($17)
	#nop
	bgez	$3,$L671
	addu	$3,$3,255
$L671:
	lw	$2,252($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L672
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L672:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,340($17)
	mflo	$4
	#nop
	bgez	$3,$L673
	addu	$3,$3,255
$L673:
	lw	$2,256($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L674
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L674:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,344($17)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L675
	addu	$4,$4,$9
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L675:
	lw	$2,260($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L676
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L676:
	sra	$2,$2,8
	mult	$3,$2
	lw	$2,1928($17)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L603
	addu	$3,$4,$9
	.set	macro
	.set	reorder

	slt	$2,$3,6553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L692
	li	$2,320			# 0x00000140
	.set	macro
	.set	reorder

	lw	$3,448($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L678
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	bne	$3,$2,$L603
$L678:
	li	$2,320			# 0x00000140
$L692:
	sw	$2,1928($17)
$L603:
	lw	$31,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Cars_DoExtraCarCollisionProcessing__FP8Car_tObj
	.text
	.ent	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii:
	.frame	$sp,72,$31		# vars= 0, regs= 9/0, args= 32, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,32($sp)
	move	$16,$4
	sw	$17,36($sp)
	move	$17,$5
	sw	$19,44($sp)
	andi	$7,$7,0x000f
	sll	$7,$7,2
	lui	$2,%hi(Cars_kSmokingSurface) # high
	addiu	$2,$2,%lo(Cars_kSmokingSurface) # low
	addu	$2,$7,$2
	sw	$31,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	lw	$22,0($2)
	lui	$2,%hi(Cars_kConvertFromRoadToSfxType) # high
	addiu	$2,$2,%lo(Cars_kConvertFromRoadToSfxType) # low
	addu	$7,$7,$2
	li	$2,1			# 0x00000001
	sll	$20,$2,$17
	li	$2,3			# 0x00000003
	lw	$8,88($sp)
	lw	$5,92($sp)
	lw	$18,0($16)
	lw	$23,0($7)
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L697
	move	$19,$6
	.set	macro
	.set	reorder

	move	$22,$0
$L697:
	lh	$4,2236($16)
	lw	$21,gTAddCarWheelDelay
	slt	$2,$4,29
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L698
	move	$3,$0
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	sll	$21,$21,$3
$L698:
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L696
	slt	$2,$17,2
	.set	macro
	.set	reorder

	bne	$2,$0,$L700
	beq	$5,$0,$L701
	beq	$8,$0,$L701
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L701
	sll	$2,$17,1
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$4,$16,$2
	lw	$3,0($19)
	lw	$2,1168($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L738
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,8($19)
	lw	$2,1176($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L710
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L738:
	bne	$17,$2,$L704
	lw	$3,1160($16)
	lw	$2,1152($16)
	.set	noreorder
	.set	nomacro
	j	$L705
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L704:
	lw	$3,1160($16)
	lw	$2,1152($16)
	#nop
	addu	$3,$3,$2
$L705:
	li	$5,-65536			# 0xffff0000
	addu	$4,$3,$5
	.set	noreorder
	.set	nomacro
	bgez	$4,$L739
	li	$2,393216			# 0x00060000
	.set	macro
	.set	reorder

	move	$4,$0
$L739:
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L706
	addu	$3,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L740
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L740
	move	$3,$0
	.set	macro
	.set	reorder

$L706:
	li	$3,393216			# 0x00060000
	move	$4,$18
$L740:
	move	$5,$17
	move	$6,$19
	move	$7,$0
	addu	$2,$8,-1
	sw	$3,16($sp)
	sw	$16,20($sp)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$9,0($19)
	lw	$10,4($19)
	lw	$11,8($19)
	sw	$9,1168($2)
	sw	$10,1172($2)
	sw	$11,1176($2)
	lw	$2,1164($16)
	.set	noreorder
	.set	nomacro
	j	$L733
	or	$2,$2,$20
	.set	macro
	.set	reorder

$L701:
	lw	$2,1164($16)
	#nop
	and	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$17
	sll	$6,$17,1
	addu	$6,$6,$17
	sll	$6,$6,2
	addu	$6,$6,1168
	addu	$6,$16,$6
	lw	$2,1160($16)
	li	$7,1			# 0x00000001
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1164($16)
	#nop
	subu	$2,$2,$20
$L733:
	sw	$2,1164($16)
$L710:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$23,$2,$L741
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,192($16)
	#nop
	slt	$2,$22,$2
	beq	$2,$0,$L715
	.set	noreorder
	.set	nomacro
	bgtz	$22,$L742
	move	$5,$17
	.set	macro
	.set	reorder

$L715:
	lw	$3,1160($16)
	.set	noreorder
	.set	nomacro
	j	$L737
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

$L700:
	beq	$5,$0,$L717
	beq	$8,$0,$L717
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L717
	sll	$2,$17,1
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$4,$16,$2
	lw	$3,0($19)
	lw	$2,1168($4)
	#nop
	bne	$3,$2,$L719
	lw	$3,8($19)
	lw	$2,1176($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L743
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

$L719:
	bne	$17,$0,$L720
	lw	$3,1156($16)
	lw	$2,1152($16)
	.set	noreorder
	.set	nomacro
	j	$L721
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L720:
	lw	$3,1156($16)
	lw	$2,1152($16)
	#nop
	addu	$3,$3,$2
$L721:
	li	$5,-131072			# 0xfffe0000
	ori	$5,$5,0x8000
	addu	$4,$3,$5
	.set	noreorder
	.set	nomacro
	bgez	$4,$L744
	li	$2,393216			# 0x00060000
	.set	macro
	.set	reorder

	move	$4,$0
$L744:
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L722
	addu	$3,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L745
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L745
	move	$3,$0
	.set	macro
	.set	reorder

$L722:
	li	$3,393216			# 0x00060000
	move	$4,$18
$L745:
	move	$5,$17
	move	$6,$19
	move	$7,$0
	addu	$2,$8,-1
	sw	$3,16($sp)
	sw	$16,20($sp)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	sll	$2,$17,1
	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$9,0($19)
	lw	$10,4($19)
	lw	$11,8($19)
	sw	$9,1168($2)
	sw	$10,1172($2)
	sw	$11,1176($2)
	lw	$2,1164($16)
	.set	noreorder
	.set	nomacro
	j	$L735
	or	$2,$2,$20
	.set	macro
	.set	reorder

$L717:
	lw	$2,1164($16)
	#nop
	and	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$17
	sll	$6,$17,1
	addu	$6,$6,$17
	sll	$6,$6,2
	addu	$6,$6,1168
	addu	$6,$16,$6
	lw	$2,1156($16)
	li	$7,1			# 0x00000001
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1164($16)
	#nop
	subu	$2,$2,$20
$L735:
	sw	$2,1164($16)
$L726:
	li	$2,8			# 0x00000008
$L743:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L728
	move	$4,$18
	.set	macro
	.set	reorder

$L741:
	move	$5,$17
	move	$6,$19
	addu	$2,$16,172
	sw	$2,16($sp)
	sw	$21,20($sp)
	lw	$2,192($16)
	li	$7,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L696
$L728:
	lw	$2,192($16)
	#nop
	slt	$2,$22,$2
	beq	$2,$0,$L731
	.set	noreorder
	.set	nomacro
	bgtz	$22,$L746
	move	$4,$18
	.set	macro
	.set	reorder

$L731:
	lw	$3,1156($16)
	li	$2,262144			# 0x00040000
$L737:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L696
	move	$4,$18
	.set	macro
	.set	reorder

$L746:
	move	$5,$17
$L742:
	move	$6,$19
	move	$7,$23
	addu	$2,$16,172
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
	sw	$21,20($sp)
	.set	macro
	.set	reorder

$L696:
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

	.end	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	.text
	.ent	Car_TireSkiddingStuff__FP8Car_tObj
Car_TireSkiddingStuff__FP8Car_tObj:
	.frame	$sp,168,$31		# vars= 96, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	subu	$sp,$sp,168
	sw	$16,128($sp)
	move	$16,$4
	sw	$21,148($sp)
	move	$21,$0
	sw	$23,156($sp)
	sw	$31,164($sp)
	sw	$fp,160($sp)
	sw	$22,152($sp)
	sw	$20,144($sp)
	sw	$19,140($sp)
	sw	$18,136($sp)
	sw	$17,132($sp)
	lh	$fp,194($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	move	$23,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$16,8
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	sltu	$23,$21,$2
$L748:
	li	$2,3866624			# 0x003b0000
	ori	$2,$2,0xffff
	lw	$3,140($16)
	lw	$5,448($16)
	slt	$2,$2,$3
	bne	$2,$0,$L749
	lw	$2,392($16)
	#nop
	slt	$2,$2,26214
	beq	$2,$0,$L749
	li	$21,1			# 0x00000001
$L749:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L758
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$2,160($16)
	#nop
	sw	$2,32($sp)
	lw	$2,164($16)
	#nop
	sw	$2,36($sp)
	lw	$2,168($16)
	#nop
	sw	$2,40($sp)
	lw	$2,384($16)
	#nop
	sw	$2,36($sp)
	lw	$3,1156($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L762
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

	move	$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L995
	move	$19,$4
	.set	macro
	.set	reorder

	move	$4,$3
	move	$19,$4
$L995:
	lw	$4,1056($16)
	li	$2,1310720			# 0x00140000
	sw	$19,116($sp)
	.set	noreorder
	bgez	$4,1f
	move	$3,$4
	subu	$3,$0,$3
1:
	.set	reorder
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L767
	sw	$19,1156($16)
	.set	macro
	.set	reorder

	move	$2,$4
	bgez	$2,$L766
	addu	$2,$2,7
$L766:
	sra	$2,$2,3
	bgez	$2,1f
	subu	$2,$0,$2
1:
	.set	noreorder
	.set	nomacro
	j	$L760
	subu	$22,$19,$2
	.set	macro
	.set	reorder

$L762:
	sw	$0,116($sp)
$L767:
	move	$22,$19
$L760:
	lw	$3,1160($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L769
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

	move	$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L996
	move	$20,$4
	.set	macro
	.set	reorder

	move	$4,$3
	move	$20,$4
$L996:
	sw	$4,1160($16)
	.set	noreorder
	.set	nomacro
	j	$L773
	sw	$20,120($sp)
	.set	macro
	.set	reorder

$L769:
	.set	noreorder
	.set	nomacro
	j	$L991
	move	$20,$0
	.set	macro
	.set	reorder

$L758:
	move	$22,$19
	move	$20,$19
	sw	$0,116($sp)
$L991:
	sw	$0,120($sp)
$L773:
	lui	$2,%hi(Cars_kAudioRoadSurfaceInterface) # high
	addiu	$2,$2,%lo(Cars_kAudioRoadSurfaceInterface) # low
	sll	$3,$5,2
	addu	$3,$3,$2
	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$3,0($3)
	lw	$2,%lo(GameSetup_gData+72)($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L774
	sw	$3,112($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L997
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	addu	$4,$16,8
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L777
	li	$11,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L777
	sw	$11,112($sp)
	.set	macro
	.set	reorder

$L774:
	lw	$11,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L997
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,648($16)
	#nop
	lw	$3,56($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L779
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L992
	li	$11,18			# 0x00000012
	.set	macro
	.set	reorder

$L779:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L997
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	li	$11,17			# 0x00000011
$L992:
	sw	$11,112($sp)
$L777:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L997:
	lw	$18,696($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,684($16)
	lw	$17,0($3)
	beq	$2,$0,$L782
	move	$17,$0
$L782:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L998
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L784
$L998:
	bne	$2,$0,$L783
	beq	$fp,$0,$L783
$L784:
	beq	$21,$0,$L783
	lw	$2,216($16)
	#nop
	bgez	$2,$L786
	addu	$2,$2,255
$L786:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L787
	addu	$2,$2,255
$L787:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L788
	addu	$2,$2,255
$L788:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L999
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L999:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L790
	addu	$2,$2,255
$L790:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1000
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1000:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L792
	addu	$2,$2,255
$L792:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1001
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1001:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L794
	addu	$2,$2,255
$L794:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1002
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1002:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L796
	addu	$2,$2,255
$L796:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L797
	addu	$5,$5,255
$L797:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$8
	sw	$4,48($sp)
	addu	$4,$4,$7
	sw	$3,56($sp)
	addu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$9
	sw	$2,52($sp)
	addu	$2,$2,$6
	sw	$2,52($sp)
	slt	$2,$17,2
	bne	$2,$0,$L798
	lw	$2,frontLimit
	#nop
	slt	$2,$2,$22
	beq	$2,$0,$L798
	li	$17,3			# 0x00000003
$L798:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L799
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$0
	addu	$6,$sp,48
	move	$7,$18
	li	$2,1			# 0x00000001
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L801
$L799:
	move	$5,$0
	addu	$6,$sp,48
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	j	$L801
$L783:
	lw	$4,1164($16)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$6,$16,1168
	lw	$3,1156($16)
	addu	$2,$4,-1
	sw	$2,1164($16)
	sw	$16,20($sp)
	sw	$0,24($sp)
	sw	$3,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

$L801:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L803
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1003
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1003
	beq	$21,$0,$L1003
	lw	$2,216($16)
	#nop
	bgez	$2,$L805
	addu	$2,$2,255
$L805:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L806
	addu	$2,$2,255
$L806:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L807
	addu	$2,$2,255
$L807:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1004
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1004:
	sw	$10,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L809
	addu	$2,$2,255
$L809:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1005
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1005:
	sw	$9,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L811
	addu	$2,$2,255
$L811:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1006
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1006:
	sw	$8,96($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L813
	addu	$2,$2,255
$L813:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1007
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1007:
	sw	$7,100($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L815
	addu	$2,$2,255
$L815:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1008
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1008:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$6,$6,8
	sw	$6,104($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$9
	sw	$4,48($sp)
	addu	$4,$4,$8
	sw	$3,56($sp)
	addu	$3,$3,$6
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$10
	sw	$2,52($sp)
	addu	$2,$2,$7
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,192($16)
	addu	$6,$sp,48
	sw	$2,24($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$19,$L817
	move	$2,$19
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L817:
	move	$19,$2
$L803:
	andi	$2,$18,0x0020
$L1003:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1009
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L818
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1009
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraCheck__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1009
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	jal	random
	andi	$2,$2,0x0007
	addu	$2,$2,-4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$2,$3,8
	lw	$4,216($16)
	addu	$5,$3,$2
	addu	$2,$4,$5
	bgez	$2,$L819
	addu	$2,$2,255
$L819:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L820
	addu	$2,$2,255
$L820:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L821
	addu	$2,$2,255
$L821:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1010
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1010:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L823
	addu	$2,$2,255
$L823:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1011
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1011:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L825
	addu	$2,$2,255
$L825:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1012
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1012:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L827
	addu	$2,$2,255
$L827:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1013
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1013:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L829
	addu	$2,$2,255
$L829:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L830
	addu	$5,$5,255
$L830:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$8
	sw	$4,48($sp)
	addu	$4,$4,$7
	sw	$3,56($sp)
	addu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$9
	sw	$2,52($sp)
	addu	$2,$2,$6
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	lw	$2,192($16)
	#nop
	sw	$2,20($sp)
	#.set	volatile
	lw	$2,52($sp)
	#.set	novolatile
	move	$5,$0
	sw	$2,24($sp)
	lw	$2,2176($16)
	li	$7,13			# 0x0000000d
	sw	$2,28($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	addu	$6,$sp,48
	.set	macro
	.set	reorder

$L818:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1009:
	lw	$18,744($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,732($16)
	lw	$17,0($3)
	beq	$2,$0,$L831
	move	$17,$0
$L831:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L1014
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L833
$L1014:
	bne	$2,$0,$L832
	beq	$fp,$0,$L832
$L833:
	beq	$21,$0,$L832
	lw	$2,216($16)
	#nop
	bgez	$2,$L835
	addu	$2,$2,255
$L835:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L836
	addu	$2,$2,255
$L836:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L837
	addu	$2,$2,255
$L837:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1015
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1015:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L839
	addu	$2,$2,255
$L839:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1016
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1016:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L841
	addu	$2,$2,255
$L841:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1017
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1017:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L843
	addu	$2,$2,255
$L843:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1018
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1018:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L845
	addu	$2,$2,255
$L845:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L846
	addu	$5,$5,255
$L846:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$8
	sw	$4,48($sp)
	addu	$4,$4,$7
	sw	$3,56($sp)
	addu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$9
	sw	$2,52($sp)
	addu	$2,$2,$6
	sw	$2,52($sp)
	slt	$2,$17,2
	bne	$2,$0,$L847
	lw	$2,frontLimit
	#nop
	slt	$2,$2,$22
	beq	$2,$0,$L847
	li	$17,3			# 0x00000003
$L847:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L848
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	addu	$6,$sp,48
	move	$7,$18
	move	$2,$5
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L850
$L848:
	li	$5,1			# 0x00000001
	addu	$6,$sp,48
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	j	$L850
$L832:
	lw	$4,1164($16)
	#nop
	andi	$2,$4,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L850
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$6,$16,1180
	lw	$3,1156($16)
	addu	$2,$4,-2
	sw	$2,1164($16)
	sw	$16,20($sp)
	sw	$0,24($sp)
	sw	$3,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	move	$7,$5
	.set	macro
	.set	reorder

$L850:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L852
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1019
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1019
	beq	$21,$0,$L1019
	lw	$2,216($16)
	#nop
	bgez	$2,$L854
	addu	$2,$2,255
$L854:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L855
	addu	$2,$2,255
$L855:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L856
	addu	$2,$2,255
$L856:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1020
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1020:
	sw	$10,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L858
	addu	$2,$2,255
$L858:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1021
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1021:
	sw	$9,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L860
	addu	$2,$2,255
$L860:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1022
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1022:
	sw	$8,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L862
	addu	$2,$2,255
$L862:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1023
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1023:
	sw	$7,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L864
	addu	$2,$2,255
$L864:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1024
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1024:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$6,$6,8
	sw	$6,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$9
	sw	$4,48($sp)
	addu	$4,$4,$8
	sw	$3,56($sp)
	addu	$3,$3,$6
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$10
	sw	$2,52($sp)
	addu	$2,$2,$7
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,192($16)
	addu	$6,$sp,48
	sw	$2,24($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$19,$L866
	move	$2,$19
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L866:
	move	$19,$2
$L852:
	andi	$2,$18,0x0020
$L1019:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1025
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L867
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1025
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraCheck__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1025
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	jal	random
	andi	$2,$2,0x0007
	addu	$2,$2,-4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$2,$3,8
	lw	$4,216($16)
	addu	$5,$3,$2
	addu	$2,$4,$5
	bgez	$2,$L868
	addu	$2,$2,255
$L868:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L869
	addu	$2,$2,255
$L869:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L870
	addu	$2,$2,255
$L870:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1026
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1026:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L872
	addu	$2,$2,255
$L872:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1027
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1027:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L874
	addu	$2,$2,255
$L874:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1028
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1028:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L876
	addu	$2,$2,255
$L876:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1029
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1029:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L878
	addu	$2,$2,255
$L878:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L879
	addu	$5,$5,255
$L879:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$8
	sw	$4,48($sp)
	addu	$4,$4,$7
	sw	$3,56($sp)
	addu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$9
	sw	$2,52($sp)
	addu	$2,$2,$6
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	lw	$2,192($16)
	#nop
	sw	$2,20($sp)
	#.set	volatile
	lw	$2,52($sp)
	#.set	novolatile
	li	$5,1			# 0x00000001
	sw	$2,24($sp)
	lw	$2,2176($16)
	li	$7,13			# 0x0000000d
	sw	$2,28($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	addu	$6,$sp,48
	.set	macro
	.set	reorder

$L867:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1025:
	lw	$18,792($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,780($16)
	lw	$17,0($3)
	beq	$2,$0,$L880
	move	$17,$0
$L880:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1030
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L882
$L1030:
	bne	$2,$0,$L881
	beq	$fp,$0,$L881
$L882:
	beq	$21,$0,$L881
	lw	$2,224($16)
	#nop
	bgez	$2,$L884
	addu	$2,$2,255
$L884:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L885
	addu	$2,$2,255
$L885:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L886
	addu	$2,$2,255
$L886:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1031
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1031:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L888
	addu	$2,$2,255
$L888:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1032
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1032:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L890
	addu	$2,$2,255
$L890:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1033
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1033:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L892
	addu	$2,$2,255
$L892:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1034
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1034:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L894
	addu	$2,$2,255
$L894:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L895
	addu	$5,$5,255
$L895:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$8
	sw	$4,48($sp)
	subu	$4,$4,$7
	sw	$3,56($sp)
	subu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$9
	sw	$2,52($sp)
	subu	$2,$2,$6
	sw	$2,52($sp)
	slt	$2,$17,2
	bne	$2,$0,$L896
	lw	$2,rearLimit
	#nop
	slt	$2,$2,$20
	beq	$2,$0,$L896
	li	$17,3			# 0x00000003
$L896:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L897
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	addu	$6,$sp,48
	move	$7,$18
	li	$2,1			# 0x00000001
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L899
$L897:
	li	$5,2			# 0x00000002
	addu	$6,$sp,48
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	j	$L899
$L881:
	lw	$2,1164($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L899
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,1160($16)
	addu	$6,$16,1192
	sw	$16,20($sp)
	sw	$0,24($sp)
	sw	$2,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,1164($16)
	#nop
	addu	$2,$2,-4
	sw	$2,1164($16)
$L899:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L901
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1035
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1035
	beq	$21,$0,$L1035
	lw	$2,224($16)
	#nop
	bgez	$2,$L903
	addu	$2,$2,255
$L903:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L904
	addu	$2,$2,255
$L904:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L905
	addu	$2,$2,255
$L905:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1036
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1036:
	sw	$10,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L907
	addu	$2,$2,255
$L907:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1037
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1037:
	sw	$9,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L909
	addu	$2,$2,255
$L909:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1038
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1038:
	sw	$8,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L911
	addu	$2,$2,255
$L911:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1039
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1039:
	sw	$7,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L913
	addu	$2,$2,255
$L913:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1040
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1040:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$6,$6,8
	sw	$6,88($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$9
	sw	$4,48($sp)
	subu	$4,$4,$8
	sw	$3,56($sp)
	subu	$3,$3,$6
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$10
	sw	$2,52($sp)
	subu	$2,$2,$7
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,192($16)
	addu	$6,$sp,48
	sw	$2,24($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$20,$L915
	move	$2,$20
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L915:
	move	$20,$2
$L901:
	andi	$2,$18,0x0020
$L1035:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1041
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L916
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1041
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraCheck__Fii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1041
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	jal	random
	andi	$2,$2,0x0007
	addu	$2,$2,-4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$2,$3,8
	lw	$4,224($16)
	addu	$5,$3,$2
	addu	$2,$4,$5
	bgez	$2,$L917
	addu	$2,$2,255
$L917:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L918
	addu	$2,$2,255
$L918:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L919
	addu	$2,$2,255
$L919:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1042
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1042:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L921
	addu	$2,$2,255
$L921:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1043
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1043:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L923
	addu	$2,$2,255
$L923:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1044
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1044:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L925
	addu	$2,$2,255
$L925:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1045
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1045:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L927
	addu	$2,$2,255
$L927:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L928
	addu	$5,$5,255
$L928:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	subu	$4,$4,$2
	lw	$2,36($sp)
	subu	$3,$3,$8
	sw	$4,48($sp)
	subu	$4,$4,$7
	sw	$3,56($sp)
	subu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	subu	$2,$2,$9
	sw	$2,52($sp)
	subu	$2,$2,$6
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	lw	$2,192($16)
	#nop
	sw	$2,20($sp)
	#.set	volatile
	lw	$2,52($sp)
	#.set	novolatile
	li	$5,2			# 0x00000002
	sw	$2,24($sp)
	lw	$2,2176($16)
	li	$7,13			# 0x0000000d
	sw	$2,28($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	addu	$6,$sp,48
	.set	macro
	.set	reorder

$L916:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1041:
	lw	$18,840($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,828($16)
	lw	$17,0($3)
	beq	$2,$0,$L929
	move	$17,$0
$L929:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1046
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L931
$L1046:
	bne	$2,$0,$L930
	beq	$fp,$0,$L930
$L931:
	beq	$21,$0,$L930
	lw	$2,224($16)
	#nop
	bgez	$2,$L933
	addu	$2,$2,255
$L933:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L934
	addu	$2,$2,255
$L934:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L935
	addu	$2,$2,255
$L935:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1047
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1047:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L937
	addu	$2,$2,255
$L937:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1048
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1048:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L939
	addu	$2,$2,255
$L939:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1049
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1049:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L941
	addu	$2,$2,255
$L941:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1050
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1050:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L943
	addu	$2,$2,255
$L943:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L944
	addu	$5,$5,255
$L944:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$8
	sw	$4,48($sp)
	subu	$4,$4,$7
	sw	$3,56($sp)
	subu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$9
	sw	$2,52($sp)
	subu	$2,$2,$6
	sw	$2,52($sp)
	slt	$2,$17,2
	bne	$2,$0,$L945
	lw	$2,rearLimit
	#nop
	slt	$2,$2,$20
	beq	$2,$0,$L945
	li	$17,3			# 0x00000003
$L945:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L946
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,3			# 0x00000003
	addu	$6,$sp,48
	move	$7,$18
	li	$2,1			# 0x00000001
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L948
$L946:
	li	$5,3			# 0x00000003
	addu	$6,$sp,48
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	j	$L948
$L930:
	lw	$2,1164($16)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L948
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,1160($16)
	addu	$6,$16,1204
	sw	$16,20($sp)
	sw	$0,24($sp)
	sw	$2,16($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,1164($16)
	#nop
	addu	$2,$2,-8
	sw	$2,1164($16)
$L948:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L950
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1051
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1051
	beq	$21,$0,$L1051
	lw	$2,224($16)
	#nop
	bgez	$2,$L952
	addu	$2,$2,255
$L952:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L953
	addu	$2,$2,255
$L953:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L954
	addu	$2,$2,255
$L954:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1052
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1052:
	sw	$10,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L956
	addu	$2,$2,255
$L956:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1053
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1053:
	sw	$9,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L958
	addu	$2,$2,255
$L958:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1054
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1054:
	sw	$8,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L960
	addu	$2,$2,255
$L960:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1055
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1055:
	sw	$7,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L962
	addu	$2,$2,255
$L962:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1056
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1056:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$6,$6,8
	sw	$6,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$9
	sw	$4,48($sp)
	subu	$4,$4,$8
	sw	$3,56($sp)
	subu	$3,$3,$6
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$10
	sw	$2,52($sp)
	subu	$2,$2,$7
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,192($16)
	addu	$6,$sp,48
	sw	$2,24($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	li	$7,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$20,$L964
	move	$2,$20
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L964:
	move	$20,$2
$L950:
	andi	$2,$18,0x0020
$L1051:
	beq	$2,$0,$L965
	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L965
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L965
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraCheck__Fii
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$2,$0,$L965
	jal	random
	andi	$2,$2,0x0007
	addu	$2,$2,-4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	addu	$3,$3,$2
	sll	$2,$3,8
	lw	$4,224($16)
	addu	$5,$3,$2
	addu	$2,$4,$5
	bgez	$2,$L966
	addu	$2,$2,255
$L966:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L967
	addu	$2,$2,255
$L967:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L968
	addu	$2,$2,255
$L968:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1057
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1057:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L970
	addu	$2,$2,255
$L970:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1058
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1058:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L972
	addu	$2,$2,255
$L972:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1059
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1059:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L974
	addu	$2,$2,255
$L974:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1060
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1060:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L976
	addu	$2,$2,255
$L976:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L977
	addu	$5,$5,255
$L977:
	lw	$4,32($sp)
	lw	$2,64($sp)
	lw	$3,40($sp)
	sra	$5,$5,8
	sw	$5,88($sp)
	addu	$4,$4,$2
	lw	$2,36($sp)
	addu	$3,$3,$8
	sw	$4,48($sp)
	subu	$4,$4,$7
	sw	$3,56($sp)
	subu	$3,$3,$5
	sw	$4,48($sp)
	sw	$3,56($sp)
	addu	$2,$2,$9
	sw	$2,52($sp)
	subu	$2,$2,$6
	sw	$2,52($sp)
	addu	$2,$16,172
	sw	$2,16($sp)
	lw	$2,192($16)
	#nop
	sw	$2,20($sp)
	#.set	volatile
	lw	$2,52($sp)
	#.set	novolatile
	li	$5,3			# 0x00000003
	sw	$2,24($sp)
	lw	$2,2176($16)
	li	$7,13			# 0x0000000d
	sw	$2,28($sp)
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	addu	$6,$sp,48
	.set	macro
	.set	reorder

$L965:
	beq	$19,$0,$L978
	lw	$11,116($sp)
	#nop
	bgez	$11,$L1061
	sw	$0,116($sp)
	lw	$11,116($sp)
$L1061:
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L1062
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L982
$L1062:
	li	$5,2			# 0x00000002
	li	$6,18			# 0x00000012
	lw	$11,112($sp)
	move	$7,$5
	sw	$19,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$11,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	.set	noreorder
	.set	nomacro
	j	$L993
	ori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L978:
	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L982
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,3			# 0x00000003
	li	$6,18			# 0x00000012
	lw	$11,112($sp)
	li	$7,2			# 0x00000002
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$11,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	addu	$2,$2,-1
$L993:
	sw	$2,1216($16)
$L982:
	beq	$20,$0,$L984
	lw	$11,120($sp)
	#nop
	bgez	$11,$L1063
	sw	$0,120($sp)
	lw	$11,120($sp)
$L1063:
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L1064
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L990
$L1064:
	li	$5,4			# 0x00000004
	li	$6,20			# 0x00000014
	li	$7,2			# 0x00000002
	srl	$2,$20,31
	addu	$2,$20,$2
	lw	$11,112($sp)
	sra	$2,$2,1
	sw	$2,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$11,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	.set	noreorder
	.set	nomacro
	j	$L994
	ori	$2,$2,0x0002
	.set	macro
	.set	reorder

$L984:
	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L990
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,5			# 0x00000005
	li	$6,20			# 0x00000014
	lw	$11,112($sp)
	li	$7,2			# 0x00000002
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$11,16($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	addu	$2,$2,-2
$L994:
	sw	$2,1216($16)
$L990:
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

	.end	Car_TireSkiddingStuff__FP8Car_tObj
	.text
	.ent	Cars_FindTotalSlice__FP8Car_tObj
Cars_FindTotalSlice__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,616($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1066
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,6($4)
	.set	macro
	.set	reorder

$L1066:
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,gNumSlices
	beq	$2,$0,$L1067
	lw	$2,612($4)
	#nop
	mult	$2,$3
	lhu	$2,8($4)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1070
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L1067:
	lw	$2,612($4)
	#nop
	mult	$2,$3
	lhu	$2,8($4)
$L1070:
	mflo	$5
	#nop
	#nop
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,6($4)
	.set	macro
	.set	reorder

	.end	Cars_FindTotalSlice__FP8Car_tObj
	.text
	.ent	Car_DoSkiddingStuff__FP8Car_tObj
Car_DoSkiddingStuff__FP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,36($sp)
	lw	$2,300($16)
	#nop
	slt	$2,$2,13108
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1072
	lui	$2,%hi(Cars_kAudioRoadSurfaceInterface) # high
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1073
	li	$5,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$6,20			# 0x00000014
	li	$7,1			# 0x00000001
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	addu	$2,$2,-4
	sw	$2,1216($16)
$L1073:
	.set	noreorder
	.set	nomacro
	jal	Car_TireSkiddingStuff__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L1071
$L1072:
	addiu	$2,$2,%lo(Cars_kAudioRoadSurfaceInterface) # low
	lw	$3,448($16)
	lw	$4,392($16)
	lw	$5,192($16)
	sll	$3,$3,2
	addu	$3,$3,$2
	slt	$4,$4,13107
	lw	$3,0($3)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1075
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1075
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
	li	$6,20			# 0x00000014
	li	$7,1			# 0x00000001
	li	$2,655360			# 0x000a0000
	sw	$3,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	.set	noreorder
	.set	nomacro
	j	$L1076
	ori	$2,$2,0x0004
	.set	macro
	.set	reorder

$L1075:
	move	$4,$16
	li	$5,5			# 0x00000005
	li	$6,20			# 0x00000014
	li	$7,1			# 0x00000001
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_SetAudioCalls__FP8Car_tObjiiiiii
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	addu	$2,$2,-4
$L1076:
	sw	$2,1216($16)
$L1071:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Car_DoSkiddingStuff__FP8Car_tObj
	.text
	.ent	Car_DoPostCollisionStuff__FP8Car_tObj
Car_DoPostCollisionStuff__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,400($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1079
	sw	$0,1940($16)
	.set	macro
	.set	reorder

	sw	$2,436($16)
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,404($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1080
	sw	$2,440($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1079
	sw	$3,432($16)
	.set	macro
	.set	reorder

$L1080:
	sw	$0,432($16)
$L1079:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L1083
	lbu	$2,145($16)
	#nop
	bne	$2,$0,$L1085
$L1083:
	lw	$2,1124($16)
	sw	$0,2120($16)
	sw	$0,2124($16)
	lw	$2,340($2)
	move	$4,$16
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	Cars_DoExtraCarCollisionProcessing__FP8Car_tObj
	sw	$2,2136($4)
	.set	macro
	.set	reorder

	j	$L1078
$L1085:
	.set	noreorder
	.set	nomacro
	jal	AIPhysic_ProcessCollision__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_DoExtraCarCollisionProcessing__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Car_DoSkiddingStuff__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1087
	lhu	$2,380($16)
	#nop
	beq	$2,$0,$L1086
$L1087:
	lw	$3,2128($16)
	lw	$4,1044($16)
	sll	$2,$3,4
	subu	$2,$2,$3
	addu	$2,$2,$4
	lw	$4,2132($16)
	lw	$3,1036($16)
	sra	$2,$2,4
	sw	$2,2128($16)
	sll	$2,$4,4
	subu	$2,$2,$4
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1100
	sra	$2,$2,4
	.set	macro
	.set	reorder

$L1086:
	lw	$3,2128($16)
	lw	$4,1044($16)
	sll	$2,$3,3
	subu	$2,$2,$3
	addu	$2,$2,$4
	lw	$4,2132($16)
	lw	$3,1036($16)
	sra	$2,$2,3
	sw	$2,2128($16)
	sll	$2,$4,3
	subu	$2,$2,$4
	addu	$2,$2,$3
	sra	$2,$2,3
$L1100:
	sw	$2,2132($16)
	lw	$2,388($16)
	#nop
	subu	$4,$0,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1089
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,31
$L1089:
	sra	$3,$2,5
	slt	$2,$3,1311
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1101
	slt	$2,$3,-2620
	.set	macro
	.set	reorder

	li	$3,1310			# 0x0000051e
	slt	$2,$3,-2620
$L1101:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1092
	li	$17,-2621			# 0xfffff5c3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$4,$L1094
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,31
$L1094:
	sra	$3,$2,5
	slt	$2,$3,1311
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1092
	li	$17,1310			# 0x0000051e
	.set	macro
	.set	reorder

	move	$17,$3
$L1092:
	lw	$3,2132($16)
	lw	$2,1124($16)
	sll	$4,$3,1
	addu	$4,$4,$3
	lw	$5,332($2)
	srl	$2,$4,31
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,1
	.set	macro
	.set	reorder

	bgez	$2,1f
	subu	$2,$0,$2
1:
	lw	$5,2144($16)
	lw	$3,1124($16)
	lw	$4,2132($16)
	lw	$3,340($3)
	subu	$2,$17,$2
	sw	$4,2124($16)
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,2136($16)
	.set	macro
	.set	reorder

	lw	$5,2140($16)
	lw	$4,2128($16)
	sw	$2,2124($16)
	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$4,2120($16)
	.set	macro
	.set	reorder

	lw	$3,648($16)
	move	$4,$2
	sw	$4,2120($16)
	lw	$3,64($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1102
	srl	$2,$4,31
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1078
	srl	$2,$4,31
	.set	macro
	.set	reorder

$L1102:
	addu	$2,$4,$2
	lw	$3,2124($16)
	sra	$2,$2,1
	sw	$2,2120($16)
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	sw	$3,2124($16)
$L1078:
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

	.end	Car_DoPostCollisionStuff__FP8Car_tObj
	.text
	.ent	Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$6,$2,%lo(GameSetup_gData) # low
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$2,48($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1104
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L1104:
	lw	$2,596($4)
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$2,$3,4
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$6
	lw	$3,Cars_gNumRaceCars
	lw	$7,1064($2)
	slt	$3,$3,3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1105
	sll	$2,$5,2
	.set	macro
	.set	reorder

	addu	$2,$2,$5
	sll	$2,$2,1
	mult	$2,$7
	mflo	$8
	#nop
	#nop
	addu	$3,$5,$8
	bltz	$3,$L1106
	lw	$6,gNumSlices
	#nop
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1107
	move	$5,$3
	.set	macro
	.set	reorder

	subu	$5,$3,$6
$L1107:
	.set	noreorder
	.set	nomacro
	j	$L1108
	sw	$5,0($17)
	.set	macro
	.set	reorder

$L1106:
	lw	$2,gNumSlices
	.set	noreorder
	.set	nomacro
	j	$L1120
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L1105:
	bltz	$5,$L1109
	lw	$6,gNumSlices
	#nop
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1111
	move	$3,$5
	.set	macro
	.set	reorder

	subu	$3,$5,$6
$L1111:
	.set	noreorder
	.set	nomacro
	j	$L1108
	sw	$3,0($17)
	.set	macro
	.set	reorder

$L1109:
	lw	$2,gNumSlices
	#nop
	addu	$2,$5,$2
$L1120:
	sw	$2,0($17)
$L1108:
	lw	$3,1360($4)
	lw	$2,AITune_driveSide
	#nop
	mult	$3,$2
	li	$2,-1			# 0xffffffff
	mflo	$8
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$2,$L1112
	andi	$16,$7,0x0001
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	subu	$16,$2,$16
$L1112:
	jal	AITune_GetOneWay__Fv
	beq	$2,$0,$L1113
	lw	$2,0($17)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$4,30($2)
	lbu	$6,29($2)
	sll	$4,$4,15
	srl	$5,$6,4
	mult	$4,$5
	lbu	$2,31($2)
	mflo	$4
	#nop
	sll	$2,$2,15
	andi	$6,$6,0x000f
	mult	$2,$6
	addu	$5,$5,$6
	mflo	$3
	#nop
	#nop
	addu	$2,$4,$3
	srl	$3,$2,1
	subu	$3,$3,$4
	div	$4,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L1121
	addu	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1121
	subu	$2,$3,$4
	.set	macro
	.set	reorder

$L1113:
	beq	$16,$0,$L1117
	lw	$2,0($17)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,31($2)
	.set	noreorder
	.set	nomacro
	j	$L1121
	sll	$2,$2,14
	.set	macro
	.set	reorder

$L1117:
	lw	$2,0($17)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,30($2)
	#nop
	sll	$2,$2,15
	subu	$2,$0,$2
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
$L1121:
	sw	$2,0($18)
	li	$2,32768			# 0x00008000
	sw	$2,4($18)
	sw	$0,8($18)
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

	.end	Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
	.text
	.ent	Cars_IniCarObjects__FP8Car_tObji
Cars_IniCarObjects__FP8Car_tObji:
	.frame	$sp,72,$31		# vars= 24, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,56($sp)
	move	$16,$4
	sw	$17,60($sp)
	sw	$31,64($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_InitStats__FP8Car_tObj
	move	$17,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+964) # high
	sw	$0,640($16)
	sw	$0,644($16)
	lw	$2,%lo(GameSetup_gData+964)($2)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1160
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,648($16)
	#nop
	lw	$3,0($2)
	li	$2,33			# 0x00000021
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,36			# 0x00000024
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,38			# 0x00000026
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,39			# 0x00000027
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,47			# 0x0000002f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,48			# 0x00000030
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1125
	li	$2,49			# 0x00000031
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1132
	li	$2,34			# 0x00000022
	.set	macro
	.set	reorder

$L1125:
	.set	noreorder
	.set	nomacro
	j	$L1133
	li	$6,1638400			# 0x00190000
	.set	macro
	.set	reorder

$L1132:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1135
	li	$2,37			# 0x00000025
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1135
	li	$2,41			# 0x00000029
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1135
	li	$2,43			# 0x0000002b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1135
	li	$2,44			# 0x0000002c
	.set	macro
	.set	reorder

	bne	$3,$2,$L1140
$L1135:
	.set	noreorder
	.set	nomacro
	j	$L1133
	li	$6,1114112			# 0x00110000
	.set	macro
	.set	reorder

$L1140:
	lw	$2,1124($16)
	#nop
	lw	$2,0($2)
	#nop
	bgez	$2,$L1141
	addu	$2,$2,127
$L1141:
	sra	$6,$2,7
$L1133:
	lw	$2,308($16)
	move	$4,$16
	sw	$2,16($sp)
	lw	$2,312($16)
	ori	$5,$17,0x0100
	sw	$2,20($sp)
	lw	$2,316($16)
	move	$7,$6
	.set	noreorder
	.set	nomacro
	jal	Newton_InitBaseNewtonObj__FPUiUiiUiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
$L1160:
	addu	$5,$sp,48
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
	addu	$6,$sp,32
	.set	macro
	.set	reorder

	lw	$4,gNumSlices
	lw	$3,48($sp)
	srl	$2,$4,31
	addu	$2,$4,$2
	sra	$2,$2,1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1142
	subu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1143
	sw	$2,844($16)
	.set	macro
	.set	reorder

$L1142:
	sw	$3,844($16)
$L1143:
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1144
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,48($sp)
	addu	$6,$sp,32
	.set	noreorder
	.set	nomacro
	j	$L1158
	li	$7,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L1144:
	lw	$5,48($sp)
	addu	$6,$sp,32
	li	$7,1			# 0x00000001
$L1158:
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$2,1			# 0x00000001
	sw	$2,616($16)
	lui	$2,%hi(GameSetup_gData+48) # high
	sw	$0,612($16)
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	beq	$2,$0,$L1146
	lhu	$2,gNumSlices
	lhu	$3,8($16)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1159
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L1146:
	lhu	$2,8($16)
$L1159:
	sh	$2,4($16)
	.set	noreorder
	.set	nomacro
	jal	Cars_FindTotalSlice__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$0
	li	$6,65536			# 0x00010000
	li	$5,1			# 0x00000001
	move	$3,$16
	move	$2,$6
	sw	$0,1120($16)
	sw	$0,1116($16)
	sb	$0,1112($16)
	sb	$0,1113($16)
	sw	$2,624($16)
	sw	$2,1840($16)
	sw	$0,1844($16)
	sw	$0,1004($16)
	sw	$0,628($16)
	sw	$0,632($16)
	sw	$0,1024($16)
	sw	$0,1028($16)
	sw	$0,1032($16)
	sw	$0,1012($16)
	sw	$0,1016($16)
	sw	$0,1020($16)
	sw	$0,1036($16)
	sw	$0,1040($16)
	sw	$0,1044($16)
	sw	$0,1072($16)
	sw	$0,1076($16)
	sw	$0,1080($16)
	sw	$0,1048($16)
	sw	$0,1052($16)
	sw	$0,1056($16)
	sw	$0,1060($16)
	sw	$0,1064($16)
	sw	$0,1068($16)
$L1151:
	sw	$0,676($3)
	sw	$0,652($3)
	sw	$0,656($3)
	sw	$0,660($3)
	sw	$0,664($3)
	sw	$6,668($3)
	sw	$0,672($3)
	sw	$0,680($3)
	sw	$0,684($3)
	sw	$0,688($3)
	sw	$0,692($3)
	sw	$5,696($3)
	addu	$4,$4,1
	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1151
	addu	$3,$3,48
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,1086($16)
	sb	$2,1090($16)
	sb	$2,1089($16)
	lui	$2,%hi(GameSetup_gData+84) # high
	sw	$0,1128($16)
	sw	$0,1132($16)
	sw	$0,1136($16)
	sw	$0,1140($16)
	sw	$0,1144($16)
	sw	$0,1156($16)
	sw	$0,1160($16)
	sb	$0,1084($16)
	sb	$0,1085($16)
	sw	$0,1100($16)
	sb	$0,1091($16)
	sb	$0,1092($16)
	sb	$0,1087($16)
	sb	$0,1088($16)
	sw	$0,1104($16)
	sb	$0,1093($16)
	sb	$0,1094($16)
	lw	$2,%lo(GameSetup_gData+84)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1153
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1154
	sb	$2,1095($16)
	.set	macro
	.set	reorder

$L1153:
	sb	$0,1095($16)
$L1154:
	move	$4,$16
	sb	$0,1097($16)
	sb	$0,1096($16)
	sw	$0,1108($16)
	sb	$0,1098($16)
	sb	$0,1099($16)
	sw	$0,1148($16)
	sw	$0,1164($16)
	sw	$0,1216($16)
	sw	$0,1156($16)
	.set	noreorder
	.set	nomacro
	jal	AIInit_RestartAICar__FP8Car_tObj
	sw	$0,1160($16)
	.set	macro
	.set	reorder

	lw	$2,648($16)
	sw	$0,1940($16)
	sw	$0,1936($16)
	sw	$0,1928($16)
	sw	$0,1932($16)
	sh	$0,380($16)
	sw	$0,396($16)
	sw	$0,428($16)
	sw	$0,400($16)
	sw	$0,404($16)
	sw	$0,412($16)
	sw	$0,388($16)
	sw	$0,372($16)
	sw	$0,192($16)
	sw	$0,2120($16)
	sw	$0,2124($16)
	sw	$0,2128($16)
	sw	$0,2132($16)
	sw	$0,2136($16)
	lw	$2,0($2)
	#nop
	slt	$2,$2,29
	beq	$2,$0,$L1155
	lw	$2,1124($16)
	#nop
	lw	$3,312($2)
	lw	$4,328($2)
	sll	$5,$3,1
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	addu	$5,$5,$3
	.set	macro
	.set	reorder

	lw	$3,1124($16)
	sw	$2,2140($16)
	lw	$5,312($3)
	lw	$4,332($3)
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sll	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1122
	sw	$2,2144($16)
	.set	macro
	.set	reorder

$L1155:
	sw	$0,2140($16)
	sw	$0,2144($16)
$L1122:
	lw	$31,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Cars_IniCarObjects__FP8Car_tObji
	.text
	.ent	Cars_InitCar__FP8Car_tObji
Cars_InitCar__FP8Car_tObji:
	.frame	$sp,280,$31		# vars= 232, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+964) # high
	lw	$2,%lo(GameSetup_gData+964)($2)
	subu	$sp,$sp,280
	sw	$17,252($sp)
	move	$17,$4
	sw	$21,268($sp)
	move	$21,$5
	sw	$18,256($sp)
	move	$18,$0
	sw	$19,260($sp)
	move	$19,$18
	sw	$20,264($sp)
	move	$20,$18
	sw	$16,248($sp)
	move	$16,$18
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1162
	sw	$31,272($sp)
	.set	macro
	.set	reorder

	lw	$2,648($17)
	#nop
	lw	$4,0($2)
	jal	AIInit_IsNonStandardCarFile__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1163
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	lui	$2,%hi(Paths_Paths+16) # high
	lw	$6,%lo(Paths_Paths+16)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$7,$17,576
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1173
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L1163:
	lui	$2,%hi(Paths_Paths+16) # high
	lw	$6,%lo(Paths_Paths+16)($2)
	lui	$5,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
$L1173:
	.set	noreorder
	.set	nomacro
	jal	loadpackadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$19,$2
 #APP
 #NO_APP
	move	$4,$0
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,648($17)
	#nop
	lw	$3,0($3)
	move	$20,$2
	slt	$2,$3,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1165
	addu	$4,$sp,224
	.set	macro
	.set	reorder

	lui	$5,%hi($LC3) # high
	addiu	$5,$5,%lo($LC3) # low
	sll	$2,$3,2
	addu	$2,$2,$3
	lui	$6,%hi(GameSetup_gCarNames) # high
	addiu	$6,$6,%lo(GameSetup_gCarNames) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1174
	addu	$16,$sp,120
	.set	macro
	.set	reorder

$L1165:
	lui	$5,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	addu	$16,$sp,120
$L1174:
	move	$4,$16
	lui	$2,%hi(Paths_Paths+12) # high
	lui	$5,%hi($LC5) # high
	lw	$6,%lo(Paths_Paths+12)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC5) # low
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$18,$2
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	locatebig
	addu	$5,$sp,224
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	move	$6,$4
	.set	macro
	.set	reorder

	lui	$3,%hi(GameSetup_gData+964) # high
	lw	$3,%lo(GameSetup_gData+964)($3)
	#nop
	slt	$3,$21,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1162
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
	move	$5,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIInit_RestartAICar__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	li	$5,464			# 0x000001d0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
	sw	$2,1124($17)
	.set	macro
	.set	reorder

	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1175
	lui	$2,%hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateDerivedCarSpecs__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L1162:
	lui	$2,%hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj) # high
$L1175:
	addiu	$2,$2,%lo(Newton_UpdateRoadInfo__FP13BO_tNewtonObj) # low
	sw	$2,1220($17)
	lui	$2,%hi(Replay_DoReplay__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Replay_DoReplay__FP8Car_tObj) # low
	sw	$2,1224($17)
	lui	$2,%hi(Control_Human__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Control_Human__FP8Car_tObj) # low
	sw	$2,1228($17)
	lui	$2,%hi(Stats_TrackStats__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Stats_TrackStats__FP8Car_tObj) # low
	sw	$2,1232($17)
	lui	$2,%hi(Physics_SimCar__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Physics_SimCar__FP8Car_tObj) # low
	sw	$2,1236($17)
	lui	$2,%hi(Newton_ApplyTheLawOfGravity__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Newton_ApplyTheLawOfGravity__FP8Car_tObj) # low
	sw	$2,1240($17)
	lui	$2,%hi(Newton_QDUpdateVel__Fi) # high
	addiu	$2,$2,%lo(Newton_QDUpdateVel__Fi) # low
	sw	$2,1244($17)
	lui	$2,%hi(Newton_QDUpdateRot64Hz__Fi) # high
	addiu	$2,$2,%lo(Newton_QDUpdateRot64Hz__Fi) # low
	sw	$2,1248($17)
	lui	$2,%hi(Collide_CheckMeForCollisions__FP13BO_tNewtonObj) # high
	addiu	$2,$2,%lo(Collide_CheckMeForCollisions__FP13BO_tNewtonObj) # low
	sw	$2,1252($17)
	lui	$2,%hi(Car_DoPostCollisionStuff__FP8Car_tObj) # high
	lw	$3,608($17)
	addiu	$2,$2,%lo(Car_DoPostCollisionStuff__FP8Car_tObj) # low
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1169
	sw	$2,1256($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(Control_AI__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Control_AI__FP8Car_tObj) # low
	sw	$2,1228($17)
	lui	$2,%hi(AIPhysic_Main__FP8Car_tObj) # high
	addiu	$2,$2,%lo(AIPhysic_Main__FP8Car_tObj) # low
	sw	$2,1236($17)
	lui	$2,%hi(Newton_QDUpdateRot32Hz__Fi) # high
	addiu	$2,$2,%lo(Newton_QDUpdateRot32Hz__Fi) # low
	sw	$0,1224($17)
	sw	$2,1248($17)
$L1169:
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1170
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,32($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1176
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1176
	lui	$2,%hi(Cars_QDUpdateVelGlue__FP8Car_tObj) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_QDUpdateVelGlue__FP8Car_tObj) # low
	sw	$2,1244($17)
$L1170:
	move	$4,$17
$L1176:
	.set	noreorder
	.set	nomacro
	jal	R3DCar_Instantiate3DCar__FP8Car_tObji
	move	$5,$21
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+964) # high
	lw	$2,%lo(GameSetup_gData+964)($2)
	#nop
	slt	$2,$21,$2
	beq	$2,$0,$L1161
	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$19
	.set	macro
	.set	reorder

$L1161:
	lw	$31,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,280
	.set	macro
	.set	reorder

	.end	Cars_InitCar__FP8Car_tObji
	.text
	.ent	Cars_DeInitCar__FP8Car_tObj
Cars_DeInitCar__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AIInit_DeInitAICar__FP8Car_tObj
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$4,1124($16)
	#nop
	beq	$4,$0,$L1178
	jal	purgememadr
	sw	$0,1124($16)
$L1178:
	.set	noreorder
	.set	nomacro
	jal	R3DCar_DeInstantiate3DCar__FP8Car_tObj
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

	.end	Cars_DeInitCar__FP8Car_tObj
	.text
	.ent	Cars_Restart__Fv
Cars_Restart__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$6,Cars_gNumCars
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	blez	$6,$L1194
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$5,$2,%lo(Cars_gTotalSortedList) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$3,$2,%lo(Cars_gList) # low
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$4,$2,%lo(Cars_gSortedList) # low
$L1182:
	lw	$2,0($3)
	addu	$16,$16,1
	sw	$2,0($4)
	lw	$2,0($3)
	addu	$3,$3,4
	addu	$4,$4,4
	sw	$2,0($5)
	slt	$2,$16,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1182
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$16,$0
$L1194:
	lui	$2,%hi(Cars_gList) # high
	addiu	$17,$2,%lo(Cars_gList) # low
$L1186:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1187
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	jal	Cars_IniCarObjects__FP8Car_tObji
	addu	$16,$16,1
	.set	macro
	.set	reorder

	j	$L1186
$L1187:
	move	$16,$0
$L1190:
	jal	Object_GetNumIMassObjects__Fv
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1189
	sll	$2,$16,5
	.set	macro
	.set	reorder

	lw	$3,Object_IMassObjInst
	addu	$16,$16,1
	addu	$2,$2,$3
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	.set	noreorder
	.set	nomacro
	j	$L1190
	sw	$0,28($2)
	.set	macro
	.set	reorder

$L1189:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	sw	$0,accidentSlice
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Cars_Restart__Fv
	.text
	.ent	Cars_Initialize__FPci
Cars_Initialize__FPci:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	blez	$5,$L1202
	move	$3,$0
	.set	macro
	.set	reorder

$L1197:
	sb	$0,0($4)
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1197
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L1202:
	j	$31
	.end	Cars_Initialize__FPci
	.text
	.ent	Cars_StartUp__Fv
Cars_StartUp__Fv:
	.frame	$sp,72,$31		# vars= 16, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$31,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetCarCounters__Fv
	sw	$16,48($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,964($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1205
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$20,%hi($LC7) # high
	move	$19,$3
	move	$18,$17
$L1207:
	addiu	$4,$20,%lo($LC7) # low
	li	$5,2268			# 0x000008dc
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Cars_Initialize__FPci
	li	$5,2268			# 0x000008dc
	.set	macro
	.set	reorder

	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1208
	addu	$2,$19,980
	.set	macro
	.set	reorder

	addu	$2,$18,$2
	sw	$2,648($16)
$L1208:
	.set	noreorder
	.set	nomacro
	jal	Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,964($19)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1207
	addu	$18,$18,180
	.set	macro
	.set	reorder

$L1205:
	move	$17,$0
	lui	$2,%hi(InfiniteMassNewton) # high
	addiu	$16,$2,%lo(InfiniteMassNewton) # low
$L1210:
	jal	Object_GetNumIMassObjects__Fv
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1211
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Object_GetIMassObjectDimensions__FiP8coorddef
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,513			# 0x00000201
	li	$6,2621440			# 0x00280000
	li	$7,20971520			# 0x01400000
	lw	$2,32($sp)
	addu	$16,$16,576
	sw	$2,16($sp)
	lw	$2,36($sp)
	addu	$17,$17,1
	sw	$2,20($sp)
	lw	$2,40($sp)
	li	$3,65536			# 0x00010000
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Newton_InitBaseNewtonObj__FPUiUiiUiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L1210
$L1211:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$20,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$19,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$18,$2,%lo(Cars_gList) # low
$L1214:
	lw	$2,964($20)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1215
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$16,0($18)
	addu	$18,$18,4
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	jal	Cars_InitCar__FP8Car_tObji
	move	$4,$16
	.set	macro
	.set	reorder

	move	$6,$16
	lw	$4,16($19)
	lw	$5,1220($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	li	$7,6			# 0x00000006
	.set	macro
	.set	reorder

	j	$L1214
$L1215:
	lw	$4,R3DCar_LicenseShapeFile
	#nop
	beq	$4,$0,$L1218
	jal	purgememadr
$L1218:
	sw	$0,R3DCar_LicenseShapeFile
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1219:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1220
	li	$7,21			# 0x00000015
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,16($18)
	lw	$5,1228($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1219
$L1220:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1223:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1224
	li	$7,30			# 0x0000001e
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,16($18)
	lw	$5,1236($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1223
$L1224:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1227:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1228
	li	$7,30			# 0x0000001e
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,16($18)
	lw	$5,1240($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1227
$L1228:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1231:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1232
	li	$7,40			# 0x00000028
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,16($18)
	lw	$5,1252($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1231
$L1232:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1235:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1236
	li	$7,50			# 0x00000032
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,16($18)
	lw	$5,1256($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1235
$L1236:
	.set	noreorder
	.set	nomacro
	jal	Force_StartUp__Fv
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1239:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1240
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1241
	lw	$4,12($18)
	lw	$5,1232($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	li	$7,25			# 0x00000019
	.set	macro
	.set	reorder

$L1241:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L1239
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1240:
	move	$17,$0
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1244:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1245
	li	$7,30			# 0x0000001e
	.set	macro
	.set	reorder

	lw	$6,0($16)
	addu	$16,$16,4
	lw	$4,12($18)
	lw	$5,1244($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L1244
$L1245:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1248:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L1254
	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1252
	lw	$4,12($18)
	j	$L1253
$L1252:
	lw	$4,20($18)
$L1253:
	lw	$5,1248($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	li	$7,30			# 0x0000001e
	.set	macro
	.set	reorder

 #APP
	
 #NO_APP
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L1248
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1254:
	lw	$31,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Cars_StartUp__Fv
	.text
	.ent	Cars_CleanUp__Fv
Cars_CleanUp__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,Cars_gNumCars
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$0
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	blez	$2,$L1255
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$17,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1257:
	lw	$6,0($16)
	lw	$4,16($17)
	lw	$5,1220($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	lw	$4,16($17)
	lw	$5,1228($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1260
	lw	$4,12($17)
	lw	$5,1232($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
$L1260:
	lw	$4,16($17)
	lw	$5,1236($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	lw	$4,16($17)
	lw	$5,1240($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	lw	$4,12($17)
	lw	$5,1244($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	lw	$4,16($17)
	lw	$5,1252($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
	lw	$4,16($17)
	lw	$5,1256($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$4,0($16)
	jal	Force_IsForceOn__FP8Car_tObj
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1261
	lui	$5,%hi(Force_Update__FP8Car_tObj) # high
	.set	macro
	.set	reorder

	lw	$4,16($17)
	lw	$6,0($16)
	.set	noreorder
	.set	nomacro
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	addiu	$5,$5,%lo(Force_Update__FP8Car_tObj) # low
	.set	macro
	.set	reorder

$L1261:
	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1262
	lw	$4,12($17)
	j	$L1263
$L1262:
	lw	$4,20($17)
$L1263:
	lw	$5,1248($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	addu	$18,$18,1
	.set	macro
	.set	reorder

	lw	$4,0($16)
	jal	Cars_DeInitCar__FP8Car_tObj
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$18,$2
	bne	$2,$0,$L1257
$L1255:
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

	.end	Cars_CleanUp__Fv
	.text
	.ent	Cars_FindCurrentLap__FP8Car_tObj
Cars_FindCurrentLap__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	beq	$2,$0,$L1267
	lh	$3,8($4)
	lw	$2,gNumSlices
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1268
	addu	$5,$2,-1
	.set	macro
	.set	reorder

$L1267:
	lh	$5,8($4)
$L1268:
	lhu	$3,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$5,$L1277
	slt	$2,$5,501
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1276
	sltu	$2,$5,51
	.set	macro
	.set	reorder

	bne	$3,$0,$L1276
	lw	$2,616($4)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1271
	sw	$2,616($4)
	.set	macro
	.set	reorder

$L1276:
	beq	$2,$0,$L1271
	lhu	$2,4($4)
	#nop
	sltu	$2,$2,501
	bne	$2,$0,$L1271
	lw	$2,616($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1273
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1271
	sw	$2,616($4)
	.set	macro
	.set	reorder

$L1273:
	lw	$2,612($4)
	#nop
	addu	$2,$2,1
	sw	$2,612($4)
$L1271:
	sh	$5,4($4)
$L1277:
	j	$31
	.end	Cars_FindCurrentLap__FP8Car_tObj
	.text
	.ent	Cars_CalculateRoadSpan__FP8Car_tObj
Cars_CalculateRoadSpan__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$8,324($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$8,$L1279
	move	$3,$8
	.set	macro
	.set	reorder

	addu	$3,$8,255
$L1279:
	lw	$2,240($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1280
	sra	$11,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1280:
	sra	$2,$2,8
	mult	$11,$2
	lw	$7,328($4)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L1281
	move	$3,$7
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L1281:
	lw	$2,244($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1282
	sra	$10,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1282:
	sra	$2,$2,8
	mult	$10,$2
	lw	$6,332($4)
	#nop
	move	$3,$6
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1283
	addu	$5,$5,$12
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L1283:
	lw	$2,248($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1284
	sra	$9,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1284:
	sra	$2,$2,8
	mult	$9,$2
	mflo	$12
	#nop
	#nop
	addu	$5,$5,$12
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	bgez	$2,$L1285
	addu	$2,$2,255
$L1285:
	lw	$3,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1286
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1286:
	sra	$2,$3,8
	mult	$5,$2
	mflo	$5
 #APP
 #NO_APP
	#nop
	lw	$2,252($4)
	#nop
	bgez	$2,$L1288
	addu	$2,$2,255
$L1288:
	sra	$2,$2,8
	mult	$11,$2
	mflo	$3
	#nop
	lw	$2,256($4)
	#nop
	bgez	$2,$L1290
	addu	$2,$2,255
$L1290:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$12
	#nop
	lw	$2,260($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1292
	addu	$3,$3,$12
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1292:
	sra	$2,$2,8
	mult	$9,$2
	mflo	$12
	#nop
	#nop
	addu	$2,$3,$12
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	bgez	$3,$L1293
	addu	$3,$3,255
$L1293:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1294
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1294:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,324($4)
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1295
	addu	$5,$5,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1295:
	lw	$2,264($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1296
	sra	$6,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1296:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($4)
	mflo	$6
	#nop
	bgez	$3,$L1297
	addu	$3,$3,255
$L1297:
	lw	$2,268($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1298
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1298:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,332($4)
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1299
	addu	$6,$6,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1299:
	lw	$2,272($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1300
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1300:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$12
	#nop
	#nop
	addu	$2,$6,$12
	.set	noreorder
	bgez	$2,1f
	move	$3,$2
	subu	$3,$0,$3
1:
	.set	reorder
	bgez	$3,$L1301
	addu	$3,$3,255
$L1301:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1302
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1302:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$5,$12
	.set	macro
	.set	reorder

	.end	Cars_CalculateRoadSpan__FP8Car_tObj
	.text
	.ent	Cars_CalculateRoadPosition__FP8Car_tObj
Cars_CalculateRoadPosition__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Newton_CalculateRoadPosition__FP13BO_tNewtonObj
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cars_CalculateRoadPosition__FP8Car_tObj
	.text
	.ent	Cars_CalcVelDownRoad__FP8Car_tObj
Cars_CalcVelDownRoad__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,172($4)
	#nop
	bgez	$3,$L1306
	addu	$3,$3,255
$L1306:
	lw	$2,348($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1307
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1307:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,176($4)
	mflo	$5
	#nop
	bgez	$3,$L1308
	addu	$3,$3,255
$L1308:
	lw	$2,352($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1309
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1309:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,180($4)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1310
	addu	$5,$5,$6
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1310:
	lw	$2,356($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1311
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1311:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$5,$6
	.set	macro
	.set	reorder

	.end	Cars_CalcVelDownRoad__FP8Car_tObj
	.text
	.ent	Cars_Randomize__Fv
Cars_Randomize__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Cars_gNumAICars
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1319
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$2,1396($2)
	#nop
	andi	$2,$2,0x0300
	sra	$4,$2,8
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L1319
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$5,randSeed
$L1315:
	lw	$2,fastRandom
	#nop
	mult	$2,$5
	addu	$3,$3,1
	mflo	$2
	#nop
	#nop
	sw	$2,randtemp
	andi	$2,$2,0xffff
	sw	$2,fastRandom
	slt	$2,$3,$4
	bne	$2,$0,$L1315
$L1319:
	j	$31
	.end	Cars_Randomize__Fv
	.text
	.ent	Cars_ManageBureaucracy__Fv
Cars_ManageBureaucracy__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$0
	lui	$2,%hi(Cars_gList) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(Cars_gList) # low
	sw	$31,36($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L1321:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$20,$2
	beq	$2,$0,$L1322
	lw	$18,0($19)
	#nop
	lbu	$2,145($18)
	#nop
	beq	$2,$0,$L1323
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadSpan__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Cars_CalculateRoadPosition__FP8Car_tObj
	sw	$2,620($18)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	AIWorld_CalculateLaneInfo
	sw	$2,1396($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysics_UseCoolPhysics
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L1326
	.set	noreorder
	.set	nomacro
	jal	Cars_CalcVelDownRoad__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$2,1380($18)
$L1326:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1327
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	li	$3,327680			# 0x00050000
	ori	$3,$3,0xfffe
	lw	$5,1380($18)
	lw	$4,192($18)
	addu	$2,$5,$2
	sltu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1328
	sw	$4,1384($18)
	.set	macro
	.set	reorder

	lw	$4,264($18)
	lh	$2,8($18)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lb	$5,15($2)
	jal	fixedmult
	lw	$4,268($18)
	lh	$3,8($18)
	lw	$5,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$5
	lb	$5,16($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,272($18)
	lh	$3,8($18)
	lw	$5,BWorldSm_slices
	sll	$3,$3,5
	addu	$3,$3,$5
	lb	$5,17($3)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	addu	$17,$17,$2
	.set	noreorder
	.set	nomacro
	bgtz	$17,$L1332
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1332
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L1328:
	.set	noreorder
	.set	nomacro
	bltz	$5,$L1332
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L1332:
	sw	$2,1364($18)
$L1327:
	lb	$2,96($18)
	#nop
	beq	$2,$0,$L1323
	.set	noreorder
	.set	nomacro
	jal	Cars_FindCurrentLap__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cars_FindTotalSlice__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1323:
	addu	$19,$19,4
	.set	noreorder
	.set	nomacro
	j	$L1321
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L1322:
	jal	Cars_SortCars
	jal	Cars_Randomize__Fv
	jal	AISpeeds_MaintainLeaderBoard
	jal	DrawW_DoObjectAnimations
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

	.end	Cars_ManageBureaucracy__Fv
	.text
	.ent	Cars_CheckForAccidentScenes__Fv
Cars_CheckForAccidentScenes__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$3,%hi(GameSetup_gData) # high
	addiu	$4,$3,%lo(GameSetup_gData) # low
	sw	$31,20($sp)
	sw	$16,16($sp)
	lw	$2,12($4)
	li	$16,1			# 0x00000001
	beq	$2,$16,$L1336
	lw	$3,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L1336
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	beq	$3,$2,$L1336
	lw	$2,SceneLoaded
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1338
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$3,864($2)
	lw	$2,220($4)
	#nop
	bne	$3,$2,$L1336
	jal	Object_ClearCustomObjects__Fv
	sw	$0,SceneLoaded
	sw	$0,accidentSlice
	j	$L1336
$L1338:
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$3,864($2)
	lw	$2,216($4)
	#nop
	bne	$3,$2,$L1336
	jal	Scene_BuildCustomSceneList__Fv
	sw	$2,accidentSlice
	sw	$16,SceneLoaded
$L1336:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Cars_CheckForAccidentScenes__Fv
	.text
	.ent	Cars_SortCars__Fv
Cars_SortCars__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,Cars_gNumCars
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$11,$2,%lo(Cars_gSortedList) # low
	addu	$12,$3,-1
	move	$3,$0
$L1370:
	.set	noreorder
	.set	nomacro
	blez	$12,$L1345
	move	$9,$3
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	addu	$10,$2,-1
	sll	$2,$3,2
$L1369:
	addu	$7,$2,$11
	addu	$8,$3,1
	sll	$2,$8,2
	addu	$6,$2,$11
	lw	$5,0($7)
	lw	$4,0($6)
	lh	$3,8($5)
	lh	$2,8($4)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1368
	move	$3,$8
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
	sw	$4,0($7)
	sw	$5,0($6)
$L1368:
	slt	$2,$3,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1369
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L1345:
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L1370
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$5,Cars_gNumCars
	#nop
	slt	$2,$9,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1354
	lui	$2,%hi(Cars_gSortedList) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(Cars_gSortedList) # low
$L1356:
	lw	$2,0($4)
	#nop
	sw	$3,604($2)
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1356
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L1354:
	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$11,$2,%lo(Cars_gTotalSortedList) # low
	lw	$3,Cars_gNumCars
	lui	$2,%hi(simGlobal) # high
	addiu	$12,$2,%lo(simGlobal) # low
	addu	$13,$3,-1
	move	$3,$0
$L1373:
	.set	noreorder
	.set	nomacro
	blez	$13,$L1360
	move	$9,$3
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	addu	$10,$2,-1
	sll	$2,$3,2
$L1372:
	addu	$7,$2,$11
	addu	$8,$3,1
	sll	$2,$8,2
	addu	$6,$2,$11
	lw	$5,0($7)
	lw	$4,0($6)
	lhu	$3,6($5)
	lhu	$2,6($4)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1371
	move	$3,$8
	.set	macro
	.set	reorder

	sw	$4,640($5)
	lw	$3,0($6)
	lw	$2,0($7)
	#nop
	sw	$2,640($3)
	lw	$4,0($6)
	lw	$2,4($12)
	lw	$3,0($7)
	sw	$2,644($4)
	sw	$2,644($3)
	lw	$3,0($7)
	lw	$2,0($6)
	li	$9,1			# 0x00000001
	sw	$2,0($7)
	sw	$3,0($6)
	move	$3,$8
$L1371:
	slt	$2,$3,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1372
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L1360:
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L1373
	move	$3,$0
	.set	macro
	.set	reorder

	j	$31
	.end	Cars_SortCars__Fv
