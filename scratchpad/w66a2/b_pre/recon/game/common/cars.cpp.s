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
	bne	$2,$0,$L600
	lw	$5,256($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$3,46529			# 0x0000b5c1
	slt	$3,$3,$2
	bne	$3,$0,$L602
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
	j	$L610
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L602:
	lbu	$2,1088($16)
	#nop
	sltu	$2,$2,64
	beq	$2,$0,$L600
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
	bne	$2,$0,$L600
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	blez	$3,$L606
	lw	$4,1044($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L608
	sra	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L608
	sra	$2,$3,3
	.set	macro
	.set	reorder

$L606:
	lw	$4,1044($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L608
	sra	$2,$3,3
	.set	macro
	.set	reorder

	sra	$2,$3,1
$L608:
	addu	$2,$4,$2
$L610:
	sw	$2,1044($16)
$L600:
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
	bgez	$2,$L617
	move	$5,$6
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L617:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L614
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$5,$6,255
$L614:
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
	bgez	$5,$L615
	sw	$2,160($4)
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L615:
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
$L622:
	sw	$0,28($3)
	sw	$0,44($3)
	addu	$5,$5,1
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
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
	beq	$2,$0,$L627
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
	j	$L650
	andi	$2,$19,0x0001
	.set	macro
	.set	reorder

$L627:
	addu	$4,$17,585
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	andi	$2,$19,0x0001
$L650:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	andi	$2,$19,0x0002
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumHumanRaceCars
	jal	PlayerNameExist__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lw	$4,Cars_gNumHumanRaceCars
	jal	PlayerNameMixedCase__Fi
	j	$L635
$L631:
	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L633
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
	j	$L651
	lui	$5,%hi(frontEnd+900) # high
	.set	macro
	.set	reorder

$L633:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,46			# 0x0000002e
	.set	macro
	.set	reorder

$L635:
	lw	$4,648($17)
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$4,92
	.set	macro
	.set	reorder

	lui	$5,%hi(frontEnd+900) # high
$L651:
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
	beq	$2,$0,$L630
	ori	$2,$3,0x0300
	.set	macro
	.set	reorder

	sw	$2,608($17)
$L630:
	andi	$2,$19,0x0002
$L652:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
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
	beq	$3,$2,$L639
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$L638
$L639:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L640
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	bne	$3,$2,$L638
	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$L638
$L640:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,50			# 0x00000032
	.set	macro
	.set	reorder

	lw	$4,648($17)
	.set	noreorder
	.set	nomacro
	j	$L649
	move	$5,$2
	.set	macro
	.set	reorder

$L638:
	lw	$4,648($17)
	sll	$2,$18,3
	lui	$5,%hi(GameSetup_gPersonalityNames) # high
	addiu	$5,$5,%lo(GameSetup_gPersonalityNames) # low
	addu	$5,$2,$5
$L649:
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
	beq	$2,$0,$L637
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L644
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L653
	lui	$3,%hi(Cars_gLifeBasisCarList) # high
	.set	macro
	.set	reorder

$L644:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L653
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
	bne	$2,$0,$L654
	andi	$2,$19,0x0004
	.set	macro
	.set	reorder

	lui	$3,%hi(Cars_gLifeBasisCarList) # high
$L653:
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
$L637:
	andi	$2,$19,0x0004
$L654:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
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
$L645:
	andi	$2,$19,0x0018
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
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
	beq	$2,$0,$L626
	ori	$2,$3,0x0060
	.set	macro
	.set	reorder

	sw	$2,608($17)
$L626:
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
	bne	$2,$0,$L695
	sw	$0,1932($18)
	.set	macro
	.set	reorder

	bne	$17,$0,$L659
	lw	$3,336($18)
	#nop
	bgez	$3,$L661
	addu	$3,$3,255
$L661:
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L662
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L662:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,340($18)
	mflo	$5
	#nop
	bgez	$3,$L663
	addu	$3,$3,255
$L663:
	lw	$2,256($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L664
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L664:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,344($18)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L665
	addu	$3,$5,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L665:
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L666
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L666:
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
	beq	$2,$0,$L659
	li	$4,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	lw	$2,276($18)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L659
	lw	$2,284($18)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	lw	$3,448($18)
	#nop
	beq	$3,$2,$L659
	beq	$3,$0,$L659
	lw	$2,128($18)
	#nop
	beq	$2,$0,$L659
	lhu	$2,380($18)
	#nop
	sltu	$2,$2,6
	beq	$2,$0,$L659
	lw	$2,392($18)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L659
$L695:
	.set	noreorder
	.set	nomacro
	j	$L657
	sw	$0,1932($18)
	.set	macro
	.set	reorder

$L659:
	lh	$16,8($18)
	sll	$2,$19,2
	.set	noreorder
	.set	nomacro
	bltz	$2,$L667
	addu	$5,$16,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L699
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L667:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L699
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
	li	$2,2			# 0x00000002
$L699:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L671
	move	$16,$5
	.set	macro
	.set	reorder

	lh	$16,8($18)
$L671:
	lw	$3,accidentSlice
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L672
	addu	$4,$3,5
	.set	macro
	.set	reorder

	lw	$5,gNumSlices
	#nop
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	slt	$2,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	addu	$2,$3,-5
	.set	macro
	.set	reorder

	j	$L672
$L674:
	addu	$2,$5,-5
	subu	$2,$3,$2
	slt	$2,$16,$2
	beq	$2,$0,$L672
	lw	$3,accidentSlice
	#nop
	addu	$2,$3,-5
$L700:
	.set	noreorder
	.set	nomacro
	bltz	$2,$L676
	slt	$2,$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	sll	$2,$19,2
	.set	macro
	.set	reorder

	j	$L672
$L676:
	lw	$2,gNumSlices
	#nop
	addu	$2,$2,-5
	addu	$2,$3,$2
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	sll	$2,$19,2
	.set	macro
	.set	reorder

$L701:
	addu	$2,$2,$19
	.set	noreorder
	.set	nomacro
	bltz	$2,$L678
	addu	$5,$16,$2
	.set	macro
	.set	reorder

	lw	$3,gNumSlices
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L672
	move	$16,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L681
	subu	$5,$5,$3
	.set	macro
	.set	reorder

$L678:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L672
	move	$16,$5
	.set	macro
	.set	reorder

	lw	$2,gNumSlices
	#nop
	addu	$5,$5,$2
$L681:
	move	$16,$5
$L672:
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
	bne	$19,$4,$L682
	sltu	$3,$0,$2
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	subu	$3,$2,$3
$L682:
	lw	$2,AITune_driveSide
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L683
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	subu	$3,$2,$3
$L683:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L684
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
	bgez	$3,$L685
	subu	$4,$0,$8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L685:
	sra	$3,$3,8
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,7
	.set	noreorder
	.set	nomacro
	j	$L696
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L694:
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
	j	$L698
	move	$4,$18
	.set	macro
	.set	reorder

$L684:
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
	bgez	$4,$L702
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
	sra	$3,$4,8
$L702:
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,7
	subu	$2,$9,$2
$L696:
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
	j	$L697
	move	$17,$0
	.set	macro
	.set	reorder

$L703:
	move	$5,$16
$L704:
	addu	$6,$sp,16
$L705:
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
	beq	$2,$0,$L694
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$3,448($18)
$L697:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L703
	move	$4,$18
	.set	macro
	.set	reorder

	li	$2,14			# 0x0000000e
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L704
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$2,128($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L705
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	move	$4,$18
$L698:
	sw	$0,180($4)
	sw	$0,176($4)
	.set	noreorder
	.set	nomacro
	jal	Cars_ResetVariablesAfterACollision__FP8Car_tObj
	sw	$0,172($4)
	.set	macro
	.set	reorder

$L657:
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
	beq	$2,$0,$L706
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
	beq	$2,$0,$L706
	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L706
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

$L706:
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
	bne	$2,$0,$L710
	lw	$3,628($17)
	#nop
	beq	$3,$0,$L712
	lw	$2,1056($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,6553
	beq	$2,$0,$L713
	lw	$2,1048($17)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,628($17)
$L713:
	lw	$2,628($17)
	#nop
	slt	$2,$2,321
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L715
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

$L715:
	lw	$2,628($17)
	#nop
	bne	$2,$0,$L717
$L712:
	lw	$2,632($17)
	#nop
	bne	$2,$0,$L717
	lbu	$2,1097($17)
	#nop
	beq	$2,$0,$L717
	lw	$2,912($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L717
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(simGlobal+4)($2)
	#nop
	slt	$2,$2,833
	bne	$2,$0,$L717
	lw	$2,908($17)
	#nop
	bne	$2,$0,$L791
	li	$2,1769472			# 0x001b0000
	lw	$3,192($17)
	ori	$2,$2,0x9998
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L717
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
$L717:
	lw	$2,908($17)
$L791:
	.set	noreorder
	.set	nomacro
	blez	$2,$L724
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	sw	$2,908($17)
$L724:
	lw	$2,1932($17)
	#nop
	beq	$2,$0,$L725
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_CrashCar__FP8coorddef
	addu	$4,$17,160
	.set	macro
	.set	reorder

	lhu	$2,380($17)
	#nop
	bne	$2,$0,$L725
	sw	$0,1932($17)
$L725:
	lw	$2,1936($17)
	#nop
	beq	$2,$0,$L727
	lbu	$2,144($17)
	#nop
	bne	$2,$0,$L727
	lw	$2,2132($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L728
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$16,3			# 0x00000003
$L728:
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
	bne	$3,$2,$L729
	jal	random
	andi	$2,$2,0x0003
	bne	$2,$0,$L729
	lw	$2,224($17)
	#nop
	bgez	$2,$L731
	addu	$2,$2,255
$L731:
	lw	$3,240($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L792
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L792:
	sw	$8,64($sp)
	lw	$2,224($17)
	#nop
	bgez	$2,$L733
	addu	$2,$2,255
$L733:
	lw	$3,244($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L793
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L793:
	sw	$7,68($sp)
	lw	$2,224($17)
	#nop
	bgez	$2,$L735
	addu	$2,$2,255
$L735:
	lw	$3,248($17)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L794
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L794:
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
	bne	$2,$0,$L737
	sw	$3,36($sp)
	.set	macro
	.set	reorder

	subu	$2,$4,$8
	sw	$2,48($sp)
	subu	$2,$3,$7
	sw	$2,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L788
	subu	$2,$5,$6
	.set	macro
	.set	reorder

$L737:
	addu	$2,$4,$8
	sw	$2,48($sp)
	addu	$2,$3,$7
	sw	$2,52($sp)
	addu	$2,$5,$6
$L788:
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

$L729:
	sw	$0,1936($17)
$L727:
	lw	$2,400($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L739
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
	beq	$2,$0,$L740
	and	$18,$3,$4
	.set	macro
	.set	reorder

	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L795
	andi	$2,$4,0x0002
	.set	macro
	.set	reorder

	lw	$3,564($17)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L801:
	andi	$2,$4,0x0002
$L795:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,548($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L743
	ori	$2,$4,0x0002
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L743:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L796
	andi	$2,$4,0x0008
	.set	macro
	.set	reorder

	lw	$3,568($17)
	li	$2,196608			# 0x00030000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L802
	ori	$2,$4,0x0004
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L802:
	andi	$2,$4,0x0008
$L796:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L747
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,536($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L747
	ori	$2,$4,0x0008
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L747:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0010
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L797
	andi	$2,$4,0x0020
	.set	macro
	.set	reorder

	lw	$3,544($17)
	li	$2,1966080			# 0x001e0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L803
	ori	$2,$4,0x0010
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
	lhu	$4,2174($17)
$L803:
	andi	$2,$4,0x0020
$L797:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L751
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,560($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L751
	ori	$2,$4,0x0020
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L751:
	lhu	$4,2174($17)
	#nop
	andi	$2,$4,0x0040
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	lw	$3,552($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	ori	$2,$4,0x0040
	.set	macro
	.set	reorder

	sh	$2,2174($17)
	li	$16,1			# 0x00000001
$L740:
	lw	$2,404($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L798
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$3,400($17)
	li	$2,4915200			# 0x004b0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L756
	.set	noreorder
	.set	nomacro
	jal	Physics_FixEngineRpm__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L756:
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
	bgtz	$3,$L755
	sw	$0,1160($17)
	.set	macro
	.set	reorder

	li	$2,320			# 0x00000140
	sw	$2,1928($17)
$L755:
	li	$2,262144			# 0x00040000
$L798:
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L758
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
	beq	$2,$0,$L759
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	lw	$3,392($17)
	li	$2,39320			# 0x00009998
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
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
	bne	$3,$2,$L758
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

	j	$L758
$L760:
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	j	$L789
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

$L759:
	li	$4,983040			# 0x000f0000
	slt	$2,$4,$3
	bne	$2,$0,$L765
	lw	$2,400($17)
	#nop
	slt	$2,$4,$2
	bne	$2,$0,$L765
	beq	$16,$0,$L758
$L765:
	lw	$4,0($17)
	addu	$5,$sp,32
	li	$6,1			# 0x00000001
$L789:
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarSfx__FiP8coorddefiT1
	addu	$7,$17,172
	.set	macro
	.set	reorder

$L758:
	lw	$3,400($17)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L766
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
	bne	$18,$2,$L767
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
	j	$L790
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L767:
	slt	$2,$4,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L769
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
	bne	$18,$4,$L768
	li	$2,58981			# 0x0000e665
	.set	macro
	.set	reorder

	lw	$3,300($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L771
	li	$19,1			# 0x00000001
$L771:
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_CrashCar__FP8coorddef
	addu	$4,$17,416
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L790
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L769:
	lbu	$16,408($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L768
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

$L768:
	sw	$16,16($sp)
$L790:
	lw	$2,400($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L799
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$2,$2,7
$L799:
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

$L766:
	sw	$0,400($17)
	sw	$0,404($17)
	sw	$0,408($17)
$L739:
	lw	$3,1928($17)
	#nop
	blez	$3,$L775
	lw	$2,632($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L775
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
	beq	$2,$0,$L777
	lw	$3,448($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L777
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	bne	$3,$2,$L776
$L777:
	lw	$2,1928($17)
	#nop
	addu	$2,$2,-8
	sw	$2,1928($17)
$L776:
	lw	$2,1928($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L775
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
$L775:
	lw	$3,336($17)
	#nop
	bgez	$3,$L779
	addu	$3,$3,255
$L779:
	lw	$2,252($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L780
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L780:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,340($17)
	mflo	$4
	#nop
	bgez	$3,$L781
	addu	$3,$3,255
$L781:
	lw	$2,256($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L782
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L782:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,344($17)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L783
	addu	$4,$4,$9
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L783:
	lw	$2,260($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L784
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L784:
	sra	$2,$2,8
	mult	$3,$2
	lw	$2,1928($17)
	mflo	$9
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L710
	addu	$3,$4,$9
	.set	macro
	.set	reorder

	slt	$2,$3,6553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L800
	li	$2,320			# 0x00000140
	.set	macro
	.set	reorder

	lw	$3,448($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L786
	li	$2,14			# 0x0000000e
	.set	macro
	.set	reorder

	bne	$3,$2,$L710
$L786:
	li	$2,320			# 0x00000140
$L800:
	sw	$2,1928($17)
$L710:
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
	bne	$8,$2,$L805
	move	$19,$6
	.set	macro
	.set	reorder

	move	$22,$0
$L805:
	lh	$4,2236($16)
	lw	$21,gTAddCarWheelDelay
	slt	$2,$4,29
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L806
	move	$3,$0
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	sll	$21,$21,$3
$L806:
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L804
	slt	$2,$17,2
	.set	macro
	.set	reorder

	bne	$2,$0,$L808
	beq	$5,$0,$L809
	beq	$8,$0,$L809
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L809
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
	bne	$3,$2,$L846
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,8($19)
	lw	$2,1176($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L818
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L846:
	bne	$17,$2,$L812
	lw	$3,1160($16)
	lw	$2,1152($16)
	.set	noreorder
	.set	nomacro
	j	$L813
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L812:
	lw	$3,1160($16)
	lw	$2,1152($16)
	#nop
	addu	$3,$3,$2
$L813:
	li	$5,-65536			# 0xffff0000
	addu	$4,$3,$5
	.set	noreorder
	.set	nomacro
	bgez	$4,$L847
	li	$2,393216			# 0x00060000
	.set	macro
	.set	reorder

	move	$4,$0
$L847:
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L814
	addu	$3,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L848
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L848
	move	$3,$0
	.set	macro
	.set	reorder

$L814:
	li	$3,393216			# 0x00060000
	move	$4,$18
$L848:
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
	j	$L841
	or	$2,$2,$20
	.set	macro
	.set	reorder

$L809:
	lw	$2,1164($16)
	#nop
	and	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L818
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
$L841:
	sw	$2,1164($16)
$L818:
	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	beq	$23,$2,$L849
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$2,192($16)
	#nop
	slt	$2,$22,$2
	beq	$2,$0,$L823
	.set	noreorder
	.set	nomacro
	bgtz	$22,$L850
	move	$5,$17
	.set	macro
	.set	reorder

$L823:
	lw	$3,1160($16)
	.set	noreorder
	.set	nomacro
	j	$L845
	li	$2,262144			# 0x00040000
	.set	macro
	.set	reorder

$L808:
	beq	$5,$0,$L825
	beq	$8,$0,$L825
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L825
	sll	$2,$17,1
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,2
	addu	$4,$16,$2
	lw	$3,0($19)
	lw	$2,1168($4)
	#nop
	bne	$3,$2,$L827
	lw	$3,8($19)
	lw	$2,1176($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L851
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

$L827:
	bne	$17,$0,$L828
	lw	$3,1156($16)
	lw	$2,1152($16)
	.set	noreorder
	.set	nomacro
	j	$L829
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L828:
	lw	$3,1156($16)
	lw	$2,1152($16)
	#nop
	addu	$3,$3,$2
$L829:
	li	$5,-131072			# 0xfffe0000
	ori	$5,$5,0x8000
	addu	$4,$3,$5
	.set	noreorder
	.set	nomacro
	bgez	$4,$L852
	li	$2,393216			# 0x00060000
	.set	macro
	.set	reorder

	move	$4,$0
$L852:
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L830
	addu	$3,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$3,$L853
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L853
	move	$3,$0
	.set	macro
	.set	reorder

$L830:
	li	$3,393216			# 0x00060000
	move	$4,$18
$L853:
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
	j	$L843
	or	$2,$2,$20
	.set	macro
	.set	reorder

$L825:
	lw	$2,1164($16)
	#nop
	and	$2,$2,$20
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L834
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
$L843:
	sw	$2,1164($16)
$L834:
	li	$2,8			# 0x00000008
$L851:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L836
	move	$4,$18
	.set	macro
	.set	reorder

$L849:
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

	j	$L804
$L836:
	lw	$2,192($16)
	#nop
	slt	$2,$22,$2
	beq	$2,$0,$L839
	.set	noreorder
	.set	nomacro
	bgtz	$22,$L854
	move	$4,$18
	.set	macro
	.set	reorder

$L839:
	lw	$3,1156($16)
	li	$2,262144			# 0x00040000
$L845:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L804
	move	$4,$18
	.set	macro
	.set	reorder

$L854:
	move	$5,$17
$L850:
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

$L804:
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
	beq	$2,$0,$L856
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
$L856:
	li	$2,3866624			# 0x003b0000
	ori	$2,$2,0xffff
	lw	$3,140($16)
	lw	$5,448($16)
	slt	$2,$2,$3
	bne	$2,$0,$L857
	lw	$2,392($16)
	#nop
	slt	$2,$2,26214
	beq	$2,$0,$L857
	li	$21,1			# 0x00000001
$L857:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L866
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
	blez	$3,$L870
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

	move	$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1103
	move	$19,$4
	.set	macro
	.set	reorder

	move	$4,$3
	move	$19,$4
$L1103:
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
	beq	$2,$0,$L875
	sw	$19,1156($16)
	.set	macro
	.set	reorder

	move	$2,$4
	bgez	$2,$L874
	addu	$2,$2,7
$L874:
	sra	$2,$2,3
	bgez	$2,1f
	subu	$2,$0,$2
1:
	.set	noreorder
	.set	nomacro
	j	$L868
	subu	$22,$19,$2
	.set	macro
	.set	reorder

$L870:
	sw	$0,116($sp)
$L875:
	move	$22,$19
$L868:
	lw	$3,1160($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L877
	li	$4,655360			# 0x000a0000
	.set	macro
	.set	reorder

	move	$2,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	move	$20,$4
	.set	macro
	.set	reorder

	move	$4,$3
	move	$20,$4
$L1104:
	sw	$4,1160($16)
	.set	noreorder
	.set	nomacro
	j	$L881
	sw	$20,120($sp)
	.set	macro
	.set	reorder

$L877:
	.set	noreorder
	.set	nomacro
	j	$L1099
	move	$20,$0
	.set	macro
	.set	reorder

$L866:
	move	$22,$19
	move	$20,$19
	sw	$0,116($sp)
$L1099:
	sw	$0,120($sp)
$L881:
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
	blez	$2,$L882
	sw	$3,112($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L1105
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
	beq	$2,$0,$L885
	li	$11,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L885
	sw	$11,112($sp)
	.set	macro
	.set	reorder

$L882:
	lw	$11,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L1105
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,648($16)
	#nop
	lw	$3,56($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L887
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1100
	li	$11,18			# 0x00000012
	.set	macro
	.set	reorder

$L887:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1105
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	li	$11,17			# 0x00000011
$L1100:
	sw	$11,112($sp)
$L885:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1105:
	lw	$18,696($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,684($16)
	lw	$17,0($3)
	beq	$2,$0,$L890
	move	$17,$0
$L890:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L1106
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L892
$L1106:
	bne	$2,$0,$L891
	beq	$fp,$0,$L891
$L892:
	beq	$21,$0,$L891
	lw	$2,216($16)
	#nop
	bgez	$2,$L894
	addu	$2,$2,255
$L894:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L895
	addu	$2,$2,255
$L895:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L896
	addu	$2,$2,255
$L896:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1107
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1107:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L898
	addu	$2,$2,255
$L898:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1108
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1108:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L900
	addu	$2,$2,255
$L900:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1109
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1109:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L902
	addu	$2,$2,255
$L902:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1110
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1110:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L904
	addu	$2,$2,255
$L904:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L905
	addu	$5,$5,255
$L905:
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
	bne	$2,$0,$L906
	lw	$2,frontLimit
	#nop
	slt	$2,$2,$22
	beq	$2,$0,$L906
	li	$17,3			# 0x00000003
$L906:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L907
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

	j	$L909
$L907:
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

	j	$L909
$L891:
	lw	$4,1164($16)
	#nop
	andi	$2,$4,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L909
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

$L909:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L911
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1111
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1111
	beq	$21,$0,$L1111
	lw	$2,216($16)
	#nop
	bgez	$2,$L913
	addu	$2,$2,255
$L913:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L914
	addu	$2,$2,255
$L914:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L915
	addu	$2,$2,255
$L915:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1112
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1112:
	sw	$10,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L917
	addu	$2,$2,255
$L917:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1113
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1113:
	sw	$9,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L919
	addu	$2,$2,255
$L919:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1114
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1114:
	sw	$8,96($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L921
	addu	$2,$2,255
$L921:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1115
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1115:
	sw	$7,100($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L923
	addu	$2,$2,255
$L923:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1116
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1116:
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
	bgtz	$19,$L925
	move	$2,$19
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L925:
	move	$19,$2
$L911:
	andi	$2,$18,0x0020
$L1111:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1117
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L926
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1117
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
	beq	$2,$0,$L1117
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
	bgez	$2,$L927
	addu	$2,$2,255
$L927:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L928
	addu	$2,$2,255
$L928:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L929
	addu	$2,$2,255
$L929:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1118
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1118:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L931
	addu	$2,$2,255
$L931:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1119
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1119:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L933
	addu	$2,$2,255
$L933:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1120
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1120:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L935
	addu	$2,$2,255
$L935:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1121
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1121:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L937
	addu	$2,$2,255
$L937:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L938
	addu	$5,$5,255
$L938:
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

$L926:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1117:
	lw	$18,744($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,732($16)
	lw	$17,0($3)
	beq	$2,$0,$L939
	move	$17,$0
$L939:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L1122
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L941
$L1122:
	bne	$2,$0,$L940
	beq	$fp,$0,$L940
$L941:
	beq	$21,$0,$L940
	lw	$2,216($16)
	#nop
	bgez	$2,$L943
	addu	$2,$2,255
$L943:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L944
	addu	$2,$2,255
$L944:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L945
	addu	$2,$2,255
$L945:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1123
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1123:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L947
	addu	$2,$2,255
$L947:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1124
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1124:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L949
	addu	$2,$2,255
$L949:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1125
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1125:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L951
	addu	$2,$2,255
$L951:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1126
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1126:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L953
	addu	$2,$2,255
$L953:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L954
	addu	$5,$5,255
$L954:
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
	bne	$2,$0,$L955
	lw	$2,frontLimit
	#nop
	slt	$2,$2,$22
	beq	$2,$0,$L955
	li	$17,3			# 0x00000003
$L955:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L956
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

	j	$L958
$L956:
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

	j	$L958
$L940:
	lw	$4,1164($16)
	#nop
	andi	$2,$4,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L958
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

$L958:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L960
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1127
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1127
	beq	$21,$0,$L1127
	lw	$2,216($16)
	#nop
	bgez	$2,$L962
	addu	$2,$2,255
$L962:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L963
	addu	$2,$2,255
$L963:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L964
	addu	$2,$2,255
$L964:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1128
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1128:
	sw	$10,68($sp)
	lw	$2,216($16)
	#nop
	bgez	$2,$L966
	addu	$2,$2,255
$L966:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1129
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1129:
	sw	$9,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L968
	addu	$2,$2,255
$L968:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1130
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1130:
	sw	$8,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L970
	addu	$2,$2,255
$L970:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1131
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1131:
	sw	$7,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L972
	addu	$2,$2,255
$L972:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1132
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1132:
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
	bgtz	$19,$L974
	move	$2,$19
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L974:
	move	$19,$2
$L960:
	andi	$2,$18,0x0020
$L1127:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1133
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L975
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1133
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
	beq	$2,$0,$L1133
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
	bgez	$2,$L976
	addu	$2,$2,255
$L976:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L977
	addu	$2,$2,255
$L977:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L978
	addu	$2,$2,255
$L978:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1134
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1134:
	sw	$9,68($sp)
	lw	$2,216($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L980
	addu	$2,$2,255
$L980:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1135
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1135:
	sw	$8,72($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L982
	addu	$2,$2,255
$L982:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1136
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1136:
	sw	$7,80($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L984
	addu	$2,$2,255
$L984:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1137
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1137:
	sw	$6,84($sp)
	lw	$2,220($16)
	#nop
	bgez	$2,$L986
	addu	$2,$2,255
$L986:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L987
	addu	$5,$5,255
$L987:
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

$L975:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1133:
	lw	$18,792($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,780($16)
	lw	$17,0($3)
	beq	$2,$0,$L988
	move	$17,$0
$L988:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1138
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L990
$L1138:
	bne	$2,$0,$L989
	beq	$fp,$0,$L989
$L990:
	beq	$21,$0,$L989
	lw	$2,224($16)
	#nop
	bgez	$2,$L992
	addu	$2,$2,255
$L992:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L993
	addu	$2,$2,255
$L993:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L994
	addu	$2,$2,255
$L994:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1139
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1139:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L996
	addu	$2,$2,255
$L996:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1140
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1140:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L998
	addu	$2,$2,255
$L998:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1141
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1141:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1000
	addu	$2,$2,255
$L1000:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1142
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1142:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1002
	addu	$2,$2,255
$L1002:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L1003
	addu	$5,$5,255
$L1003:
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
	bne	$2,$0,$L1004
	lw	$2,rearLimit
	#nop
	slt	$2,$2,$20
	beq	$2,$0,$L1004
	li	$17,3			# 0x00000003
$L1004:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L1005
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

	j	$L1007
$L1005:
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

	j	$L1007
$L989:
	lw	$2,1164($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1007
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
$L1007:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L1009
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1143
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1143
	beq	$21,$0,$L1143
	lw	$2,224($16)
	#nop
	bgez	$2,$L1011
	addu	$2,$2,255
$L1011:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1012
	addu	$2,$2,255
$L1012:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1013
	addu	$2,$2,255
$L1013:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1144
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1144:
	sw	$10,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1015
	addu	$2,$2,255
$L1015:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1145
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1145:
	sw	$9,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1017
	addu	$2,$2,255
$L1017:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1146
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1146:
	sw	$8,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1019
	addu	$2,$2,255
$L1019:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1147
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1147:
	sw	$7,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1021
	addu	$2,$2,255
$L1021:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1148
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1148:
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
	bgtz	$20,$L1023
	move	$2,$20
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L1023:
	move	$20,$2
$L1009:
	andi	$2,$18,0x0020
$L1143:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1149
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
	.set	macro
	.set	reorder

	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1024
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1149
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
	beq	$2,$0,$L1149
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
	bgez	$2,$L1025
	addu	$2,$2,255
$L1025:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1026
	addu	$2,$2,255
$L1026:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L1027
	addu	$2,$2,255
$L1027:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1150
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1150:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L1029
	addu	$2,$2,255
$L1029:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1151
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1151:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1031
	addu	$2,$2,255
$L1031:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1152
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1152:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1033
	addu	$2,$2,255
$L1033:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1153
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1153:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1035
	addu	$2,$2,255
$L1035:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L1036
	addu	$5,$5,255
$L1036:
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

$L1024:
	lui	$2,%hi(Cars_kSkidMarkSurface) # high
$L1149:
	lw	$18,840($16)
	addiu	$2,$2,%lo(Cars_kSkidMarkSurface) # low
	andi	$3,$18,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,828($16)
	lw	$17,0($3)
	beq	$2,$0,$L1037
	move	$17,$0
$L1037:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L1154
	slt	$2,$17,2
	.set	macro
	.set	reorder

	beq	$23,$0,$L1039
$L1154:
	bne	$2,$0,$L1038
	beq	$fp,$0,$L1038
$L1039:
	beq	$21,$0,$L1038
	lw	$2,224($16)
	#nop
	bgez	$2,$L1041
	addu	$2,$2,255
$L1041:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1042
	addu	$2,$2,255
$L1042:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1043
	addu	$2,$2,255
$L1043:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1155
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1155:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1045
	addu	$2,$2,255
$L1045:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1156
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1156:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1047
	addu	$2,$2,255
$L1047:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1157
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1157:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1049
	addu	$2,$2,255
$L1049:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1158
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1158:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1051
	addu	$2,$2,255
$L1051:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L1052
	addu	$5,$5,255
$L1052:
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
	bne	$2,$0,$L1053
	lw	$2,rearLimit
	#nop
	slt	$2,$2,$20
	beq	$2,$0,$L1053
	li	$17,3			# 0x00000003
$L1053:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L1054
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

	j	$L1056
$L1054:
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

	j	$L1056
$L1038:
	lw	$2,1164($16)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1056
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
$L1056:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L1058
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1159
	andi	$2,$18,0x0020
	.set	macro
	.set	reorder

	beq	$fp,$0,$L1159
	beq	$21,$0,$L1159
	lw	$2,224($16)
	#nop
	bgez	$2,$L1060
	addu	$2,$2,255
$L1060:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1061
	addu	$2,$2,255
$L1061:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1062
	addu	$2,$2,255
$L1062:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1160
	sra	$10,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$10,$2,8
$L1160:
	sw	$10,68($sp)
	lw	$2,224($16)
	#nop
	bgez	$2,$L1064
	addu	$2,$2,255
$L1064:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1161
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1161:
	sw	$9,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1066
	addu	$2,$2,255
$L1066:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1162
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1162:
	sw	$8,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1068
	addu	$2,$2,255
$L1068:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1163
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1163:
	sw	$7,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1070
	addu	$2,$2,255
$L1070:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$6
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1164
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L1164:
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
	bgtz	$20,$L1072
	move	$2,$20
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L1072:
	move	$20,$2
$L1058:
	andi	$2,$18,0x0020
$L1159:
	beq	$2,$0,$L1073
	lw	$2,gLeafPixmap
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1073
	li	$2,655360			# 0x000a0000
	.set	macro
	.set	reorder

	lw	$3,192($16)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L1073
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	TrgSfx_AddCarExtraCheck__Fii
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	beq	$2,$0,$L1073
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
	bgez	$2,$L1074
	addu	$2,$2,255
$L1074:
	lw	$3,240($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1075
	addu	$2,$2,255
$L1075:
	sra	$2,$2,8
	sw	$2,64($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L1076
	addu	$2,$2,255
$L1076:
	lw	$3,244($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1165
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$9,$2,8
$L1165:
	sw	$9,68($sp)
	lw	$2,224($16)
	#nop
	addu	$2,$2,$5
	bgez	$2,$L1078
	addu	$2,$2,255
$L1078:
	lw	$3,248($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1166
	sra	$8,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$8,$2,8
$L1166:
	sw	$8,72($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1080
	addu	$2,$2,255
$L1080:
	lw	$3,264($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1167
	sra	$7,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$7,$2,8
$L1167:
	sw	$7,80($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1082
	addu	$2,$2,255
$L1082:
	lw	$3,268($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1168
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1168:
	sw	$6,84($sp)
	lw	$2,228($16)
	#nop
	bgez	$2,$L1084
	addu	$2,$2,255
$L1084:
	lw	$3,272($16)
	sra	$2,$2,8
	mult	$2,$3
	mflo	$5
	#nop
	#nop
	bgez	$5,$L1085
	addu	$5,$5,255
$L1085:
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

$L1073:
	beq	$19,$0,$L1086
	lw	$11,116($sp)
	#nop
	bgez	$11,$L1169
	sw	$0,116($sp)
	lw	$11,116($sp)
$L1169:
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L1170
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1090
$L1170:
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
	j	$L1101
	ori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L1086:
	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1090
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
$L1101:
	sw	$2,1216($16)
$L1090:
	beq	$20,$0,$L1092
	lw	$11,120($sp)
	#nop
	bgez	$11,$L1171
	sw	$0,120($sp)
	lw	$11,120($sp)
$L1171:
	.set	noreorder
	.set	nomacro
	bne	$11,$0,$L1172
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1098
$L1172:
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
	j	$L1102
	ori	$2,$2,0x0002
	.set	macro
	.set	reorder

$L1092:
	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1098
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
$L1102:
	sw	$2,1216($16)
$L1098:
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
	blez	$2,$L1174
	lui	$2,%hi(GameSetup_gData+48) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,6($4)
	.set	macro
	.set	reorder

$L1174:
	lw	$2,%lo(GameSetup_gData+48)($2)
	lw	$3,gNumSlices
	beq	$2,$0,$L1175
	lw	$2,612($4)
	#nop
	mult	$2,$3
	lhu	$2,8($4)
	#nop
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1178
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L1175:
	lw	$2,612($4)
	#nop
	mult	$2,$3
	lhu	$2,8($4)
$L1178:
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
	bne	$2,$0,$L1180
	lui	$2,%hi(Cars_kAudioRoadSurfaceInterface) # high
	.set	macro
	.set	reorder

	lw	$2,1216($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1181
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
$L1181:
	.set	noreorder
	.set	nomacro
	jal	Car_TireSkiddingStuff__FP8Car_tObj
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L1179
$L1180:
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
	beq	$4,$0,$L1183
	li	$2,131072			# 0x00020000
	.set	macro
	.set	reorder

	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1183
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
	j	$L1184
	ori	$2,$2,0x0004
	.set	macro
	.set	reorder

$L1183:
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
$L1184:
	sw	$2,1216($16)
$L1179:
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
	beq	$2,$0,$L1187
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
	beq	$3,$0,$L1188
	sw	$2,440($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1187
	sw	$3,432($16)
	.set	macro
	.set	reorder

$L1188:
	sw	$0,432($16)
$L1187:
	lbu	$2,144($16)
	#nop
	bne	$2,$0,$L1191
	lbu	$2,145($16)
	#nop
	bne	$2,$0,$L1193
$L1191:
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

	j	$L1186
$L1193:
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
	beq	$2,$0,$L1195
	lhu	$2,380($16)
	#nop
	beq	$2,$0,$L1194
$L1195:
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
	j	$L1208
	sra	$2,$2,4
	.set	macro
	.set	reorder

$L1194:
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
$L1208:
	sw	$2,2132($16)
	lw	$2,388($16)
	#nop
	subu	$4,$0,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1197
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,31
$L1197:
	sra	$3,$2,5
	slt	$2,$3,1311
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1209
	slt	$2,$3,-2620
	.set	macro
	.set	reorder

	li	$3,1310			# 0x0000051e
	slt	$2,$3,-2620
$L1209:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1200
	li	$17,-2621			# 0xfffff5c3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$4,$L1202
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,31
$L1202:
	sra	$3,$2,5
	slt	$2,$3,1311
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1200
	li	$17,1310			# 0x0000051e
	.set	macro
	.set	reorder

	move	$17,$3
$L1200:
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
	beq	$3,$2,$L1210
	srl	$2,$4,31
	.set	macro
	.set	reorder

	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1186
	srl	$2,$4,31
	.set	macro
	.set	reorder

$L1210:
	addu	$2,$4,$2
	lw	$3,2124($16)
	sra	$2,$2,1
	sw	$2,2120($16)
	srl	$2,$3,31
	addu	$3,$3,$2
	sra	$3,$3,1
	sw	$3,2124($16)
$L1186:
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
	beq	$2,$0,$L1212
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L1212:
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
	bne	$3,$0,$L1213
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
	bltz	$3,$L1214
	lw	$6,gNumSlices
	#nop
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1215
	move	$5,$3
	.set	macro
	.set	reorder

	subu	$5,$3,$6
$L1215:
	.set	noreorder
	.set	nomacro
	j	$L1216
	sw	$5,0($17)
	.set	macro
	.set	reorder

$L1214:
	lw	$2,gNumSlices
	.set	noreorder
	.set	nomacro
	j	$L1228
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L1213:
	bltz	$5,$L1217
	lw	$6,gNumSlices
	#nop
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1219
	move	$3,$5
	.set	macro
	.set	reorder

	subu	$3,$5,$6
$L1219:
	.set	noreorder
	.set	nomacro
	j	$L1216
	sw	$3,0($17)
	.set	macro
	.set	reorder

$L1217:
	lw	$2,gNumSlices
	#nop
	addu	$2,$5,$2
$L1228:
	sw	$2,0($17)
$L1216:
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
	bne	$8,$2,$L1220
	andi	$16,$7,0x0001
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	subu	$16,$2,$16
$L1220:
	jal	AITune_GetOneWay__Fv
	beq	$2,$0,$L1221
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
	bne	$16,$0,$L1229
	addu	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1229
	subu	$2,$3,$4
	.set	macro
	.set	reorder

$L1221:
	beq	$16,$0,$L1225
	lw	$2,0($17)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,31($2)
	.set	noreorder
	.set	nomacro
	j	$L1229
	sll	$2,$2,14
	.set	macro
	.set	reorder

$L1225:
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
$L1229:
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
	beq	$2,$0,$L1268
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,648($16)
	#nop
	lw	$3,0($2)
	li	$2,33			# 0x00000021
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,36			# 0x00000024
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,38			# 0x00000026
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,39			# 0x00000027
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,47			# 0x0000002f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,48			# 0x00000030
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1233
	li	$2,49			# 0x00000031
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1240
	li	$2,34			# 0x00000022
	.set	macro
	.set	reorder

$L1233:
	.set	noreorder
	.set	nomacro
	j	$L1241
	li	$6,1638400			# 0x00190000
	.set	macro
	.set	reorder

$L1240:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1243
	li	$2,37			# 0x00000025
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1243
	li	$2,41			# 0x00000029
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1243
	li	$2,43			# 0x0000002b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1243
	li	$2,44			# 0x0000002c
	.set	macro
	.set	reorder

	bne	$3,$2,$L1248
$L1243:
	.set	noreorder
	.set	nomacro
	j	$L1241
	li	$6,1114112			# 0x00110000
	.set	macro
	.set	reorder

$L1248:
	lw	$2,1124($16)
	#nop
	lw	$2,0($2)
	#nop
	bgez	$2,$L1249
	addu	$2,$2,127
$L1249:
	sra	$6,$2,7
$L1241:
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
	jal	Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
$L1268:
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
	beq	$2,$0,$L1250
	subu	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1251
	sw	$2,844($16)
	.set	macro
	.set	reorder

$L1250:
	sw	$3,844($16)
$L1251:
	lui	$2,%hi(GameSetup_gData+48) # high
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1252
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,48($sp)
	addu	$6,$sp,32
	.set	noreorder
	.set	nomacro
	j	$L1266
	li	$7,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L1252:
	lw	$5,48($sp)
	addu	$6,$sp,32
	li	$7,1			# 0x00000001
$L1266:
	jal	Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
	li	$2,1			# 0x00000001
	sw	$2,616($16)
	lui	$2,%hi(GameSetup_gData+48) # high
	sw	$0,612($16)
	lw	$2,%lo(GameSetup_gData+48)($2)
	#nop
	beq	$2,$0,$L1254
	lhu	$2,gNumSlices
	lhu	$3,8($16)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1267
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L1254:
	lhu	$2,8($16)
$L1267:
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
$L1259:
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
	bne	$2,$0,$L1259
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
	beq	$2,$0,$L1261
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1262
	sb	$2,1095($16)
	.set	macro
	.set	reorder

$L1261:
	sb	$0,1095($16)
$L1262:
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
	beq	$2,$0,$L1263
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
	j	$L1230
	sw	$2,2144($16)
	.set	macro
	.set	reorder

$L1263:
	sw	$0,2140($16)
	sw	$0,2144($16)
$L1230:
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
	beq	$2,$0,$L1270
	sw	$31,272($sp)
	.set	macro
	.set	reorder

	lw	$2,648($17)
	#nop
	lw	$4,0($2)
	jal	AIInit_IsNonStandardCarFile__Fi
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1271
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
	j	$L1281
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L1271:
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
$L1281:
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
	beq	$2,$0,$L1273
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
	j	$L1282
	addu	$16,$sp,120
	.set	macro
	.set	reorder

$L1273:
	lui	$5,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	addu	$16,$sp,120
$L1282:
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
	beq	$3,$0,$L1270
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
	beq	$2,$0,$L1283
	lui	$2,%hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_CalculateDerivedCarSpecs__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

$L1270:
	lui	$2,%hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj) # high
$L1283:
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
	lui	$2,%hi(Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj) # high
	addiu	$2,$2,%lo(Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj) # low
	sw	$2,1240($17)
	lui	$2,%hi(Newton_QDUpdateVel__FP13BO_tNewtonObj) # high
	addiu	$2,$2,%lo(Newton_QDUpdateVel__FP13BO_tNewtonObj) # low
	sw	$2,1244($17)
	lui	$2,%hi(Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj) # high
	addiu	$2,$2,%lo(Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj) # low
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
	beq	$3,$0,$L1277
	sw	$2,1256($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(Control_AI__FP8Car_tObj) # high
	addiu	$2,$2,%lo(Control_AI__FP8Car_tObj) # low
	sw	$2,1228($17)
	lui	$2,%hi(AIPhysic_Main__FP8Car_tObj) # high
	addiu	$2,$2,%lo(AIPhysic_Main__FP8Car_tObj) # low
	sw	$2,1236($17)
	lui	$2,%hi(Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj) # high
	addiu	$2,$2,%lo(Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj) # low
	sw	$0,1224($17)
	sw	$2,1248($17)
$L1277:
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1278
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,32($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1284
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1284
	lui	$2,%hi(Cars_QDUpdateVelGlue__FP8Car_tObj) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(Cars_QDUpdateVelGlue__FP8Car_tObj) # low
	sw	$2,1244($17)
$L1278:
	move	$4,$17
$L1284:
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
	beq	$2,$0,$L1269
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

$L1269:
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
	beq	$4,$0,$L1286
	jal	purgememadr
	sw	$0,1124($16)
$L1286:
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
	blez	$6,$L1302
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$5,$2,%lo(Cars_gTotalSortedList) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$3,$2,%lo(Cars_gList) # low
	lui	$2,%hi(Cars_gSortedList) # high
	addiu	$4,$2,%lo(Cars_gSortedList) # low
$L1290:
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
	bne	$2,$0,$L1290
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$16,$0
$L1302:
	lui	$2,%hi(Cars_gList) # high
	addiu	$17,$2,%lo(Cars_gList) # low
$L1294:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1295
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

	j	$L1294
$L1295:
	move	$16,$0
$L1298:
	jal	Object_GetNumIMassObjects__Fv
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1297
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
	j	$L1298
	sw	$0,28($2)
	.set	macro
	.set	reorder

$L1297:
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
	blez	$5,$L1310
	move	$3,$0
	.set	macro
	.set	reorder

$L1305:
	sb	$0,0($4)
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1305
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L1310:
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
	blez	$2,$L1313
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$20,%hi($LC7) # high
	move	$19,$3
	move	$18,$17
$L1315:
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
	beq	$2,$0,$L1316
	addu	$2,$19,980
	.set	macro
	.set	reorder

	addu	$2,$18,$2
	sw	$2,648($16)
$L1316:
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
	bne	$2,$0,$L1315
	addu	$18,$18,180
	.set	macro
	.set	reorder

$L1313:
	move	$17,$0
	lui	$2,%hi(InfiniteMassNewton) # high
	addiu	$16,$2,%lo(InfiniteMassNewton) # low
$L1318:
	jal	Object_GetNumIMassObjects__Fv
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1319
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
	jal	Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	j	$L1318
$L1319:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$20,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$19,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$18,$2,%lo(Cars_gList) # low
$L1322:
	lw	$2,964($20)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1323
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

	j	$L1322
$L1323:
	lw	$4,R3DCar_LicenseShapeFile
	#nop
	beq	$4,$0,$L1326
	jal	purgememadr
$L1326:
	sw	$0,R3DCar_LicenseShapeFile
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1327:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1328
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

	j	$L1327
$L1328:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1331:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1332
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

	j	$L1331
$L1332:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1335:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1336
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

	j	$L1335
$L1336:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1339:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1340
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

	j	$L1339
$L1340:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1343:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1344
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

	j	$L1343
$L1344:
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
$L1347:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1348
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1349
	lw	$4,12($18)
	lw	$5,1232($6)
	.set	noreorder
	.set	nomacro
	jal	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	li	$7,25			# 0x00000019
	.set	macro
	.set	reorder

$L1349:
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	j	$L1347
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1348:
	move	$17,$0
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1352:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1353
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

	j	$L1352
$L1353:
	move	$17,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$19,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(simGlobal) # high
	addiu	$18,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1356:
	lw	$2,964($19)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L1362
	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1360
	lw	$4,12($18)
	j	$L1361
$L1360:
	lw	$4,20($18)
$L1361:
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
	j	$L1356
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L1362:
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
	blez	$2,$L1363
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simGlobal) # high
	addiu	$17,$2,%lo(simGlobal) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$16,$2,%lo(Cars_gList) # low
$L1365:
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
	beq	$2,$0,$L1368
	lw	$4,12($17)
	lw	$5,1232($6)
	jal	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	lw	$6,0($16)
$L1368:
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
	beq	$2,$0,$L1369
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

$L1369:
	lw	$6,0($16)
	#nop
	lw	$2,608($6)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L1370
	lw	$4,12($17)
	j	$L1371
$L1370:
	lw	$4,20($17)
$L1371:
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
	bne	$2,$0,$L1365
$L1363:
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
	beq	$2,$0,$L1375
	lh	$3,8($4)
	lw	$2,gNumSlices
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1376
	addu	$5,$2,-1
	.set	macro
	.set	reorder

$L1375:
	lh	$5,8($4)
$L1376:
	lhu	$3,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$5,$L1385
	slt	$2,$5,501
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1384
	sltu	$2,$5,51
	.set	macro
	.set	reorder

	bne	$3,$0,$L1384
	lw	$2,616($4)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1379
	sw	$2,616($4)
	.set	macro
	.set	reorder

$L1384:
	beq	$2,$0,$L1379
	lhu	$2,4($4)
	#nop
	sltu	$2,$2,501
	bne	$2,$0,$L1379
	lw	$2,616($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1381
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1379
	sw	$2,616($4)
	.set	macro
	.set	reorder

$L1381:
	lw	$2,612($4)
	#nop
	addu	$2,$2,1
	sw	$2,612($4)
$L1379:
	sh	$5,4($4)
$L1385:
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
	bgez	$8,$L1387
	move	$3,$8
	.set	macro
	.set	reorder

	addu	$3,$8,255
$L1387:
	lw	$2,240($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1388
	sra	$11,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1388:
	sra	$2,$2,8
	mult	$11,$2
	lw	$7,328($4)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L1389
	move	$3,$7
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L1389:
	lw	$2,244($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1390
	sra	$10,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1390:
	sra	$2,$2,8
	mult	$10,$2
	lw	$6,332($4)
	#nop
	move	$3,$6
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1391
	addu	$5,$5,$12
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L1391:
	lw	$2,248($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1392
	sra	$9,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1392:
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
	bgez	$2,$L1393
	addu	$2,$2,255
$L1393:
	lw	$3,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1394
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1394:
	sra	$2,$3,8
	mult	$5,$2
	mflo	$5
 #APP
 #NO_APP
	#nop
	lw	$2,252($4)
	#nop
	bgez	$2,$L1396
	addu	$2,$2,255
$L1396:
	sra	$2,$2,8
	mult	$11,$2
	mflo	$3
	#nop
	lw	$2,256($4)
	#nop
	bgez	$2,$L1398
	addu	$2,$2,255
$L1398:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$12
	#nop
	lw	$2,260($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1400
	addu	$3,$3,$12
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1400:
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
	bgez	$3,$L1401
	addu	$3,$3,255
$L1401:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1402
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1402:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,324($4)
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1403
	addu	$5,$5,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1403:
	lw	$2,264($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1404
	sra	$6,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1404:
	sra	$2,$2,8
	mult	$6,$2
	lw	$3,328($4)
	mflo	$6
	#nop
	bgez	$3,$L1405
	addu	$3,$3,255
$L1405:
	lw	$2,268($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1406
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1406:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,332($4)
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1407
	addu	$6,$6,$12
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1407:
	lw	$2,272($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1408
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1408:
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
	bgez	$3,$L1409
	addu	$3,$3,255
$L1409:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1410
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1410:
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
	bgez	$3,$L1414
	addu	$3,$3,255
$L1414:
	lw	$2,348($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1415
	sra	$5,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1415:
	sra	$2,$2,8
	mult	$5,$2
	lw	$3,176($4)
	mflo	$5
	#nop
	bgez	$3,$L1416
	addu	$3,$3,255
$L1416:
	lw	$2,352($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1417
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1417:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,180($4)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1418
	addu	$5,$5,$6
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1418:
	lw	$2,356($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1419
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1419:
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
	beq	$2,$0,$L1427
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
	beq	$4,$0,$L1427
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$5,randSeed
$L1423:
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
	bne	$2,$0,$L1423
$L1427:
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
$L1429:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$20,$2
	beq	$2,$0,$L1430
	lw	$18,0($19)
	#nop
	lbu	$2,145($18)
	#nop
	beq	$2,$0,$L1431
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
	jal	AIWorld_CalculateLaneInfo__FP8Car_tObj
	sw	$2,1396($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIPhysics_UseCoolPhysics__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L1434
	.set	noreorder
	.set	nomacro
	jal	Cars_CalcVelDownRoad__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$2,1380($18)
$L1434:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1435
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
	bne	$3,$0,$L1436
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
	bgtz	$17,$L1440
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1440
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L1436:
	.set	noreorder
	.set	nomacro
	bltz	$5,$L1440
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L1440:
	sw	$2,1364($18)
$L1435:
	lb	$2,96($18)
	#nop
	beq	$2,$0,$L1431
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

$L1431:
	addu	$19,$19,4
	.set	noreorder
	.set	nomacro
	j	$L1429
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L1430:
	jal	Cars_SortCars__Fv
	jal	Cars_Randomize__Fv
	jal	AISpeeds_MaintainLeaderBoard__Fv
	jal	DrawW_DoObjectAnimations__Fv
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
	beq	$2,$16,$L1444
	lw	$3,%lo(GameSetup_gData)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L1444
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	beq	$3,$2,$L1444
	lw	$2,SceneLoaded
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1446
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$3,864($2)
	lw	$2,220($4)
	#nop
	bne	$3,$2,$L1444
	jal	Object_ClearCustomObjects__Fv
	sw	$0,SceneLoaded
	sw	$0,accidentSlice
	j	$L1444
$L1446:
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	#nop
	lw	$3,864($2)
	lw	$2,216($4)
	#nop
	bne	$3,$2,$L1444
	jal	Scene_BuildCustomSceneList__Fv
	sw	$2,accidentSlice
	sw	$16,SceneLoaded
$L1444:
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
$L1478:
	.set	noreorder
	.set	nomacro
	blez	$12,$L1453
	move	$9,$3
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	addu	$10,$2,-1
	sll	$2,$3,2
$L1477:
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
	beq	$2,$0,$L1476
	move	$3,$8
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
	sw	$4,0($7)
	sw	$5,0($6)
$L1476:
	slt	$2,$3,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1477
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L1453:
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L1478
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$5,Cars_gNumCars
	#nop
	slt	$2,$9,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1462
	lui	$2,%hi(Cars_gSortedList) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(Cars_gSortedList) # low
$L1464:
	lw	$2,0($4)
	#nop
	sw	$3,604($2)
	addu	$3,$3,1
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1464
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L1462:
	lui	$2,%hi(Cars_gTotalSortedList) # high
	addiu	$11,$2,%lo(Cars_gTotalSortedList) # low
	lw	$3,Cars_gNumCars
	lui	$2,%hi(simGlobal) # high
	addiu	$12,$2,%lo(simGlobal) # low
	addu	$13,$3,-1
	move	$3,$0
$L1481:
	.set	noreorder
	.set	nomacro
	blez	$13,$L1468
	move	$9,$3
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCars
	#nop
	addu	$10,$2,-1
	sll	$2,$3,2
$L1480:
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
	beq	$2,$0,$L1479
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
$L1479:
	slt	$2,$3,$10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1480
	sll	$2,$3,2
	.set	macro
	.set	reorder

$L1468:
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L1481
	move	$3,$0
	.set	macro
	.set	reorder

	j	$31
	.end	Cars_SortCars__Fv
