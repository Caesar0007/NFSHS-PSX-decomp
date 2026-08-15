	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aiperson.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIPerson_LoadGridAndSetPersonalityIndexes__Fv
	.align	2
	.globl	AIPerson_SetPersonality__FP8Car_tObji
	.align	2
	.globl	AIPerson_SetPersonalityPointers__Fv
	.align	2
	.globl	AIPerson_LoadPersonalityData__FP10Udff_tInfo
	.align	2
	.globl	AIPerson_LoadScriptData__FP10Udff_tInfo
	.align	2
	.globl	AIPerson_LoadGlue__FP10Udff_tInfo
	.align	2
	.globl	AIPerson_Startup__Fv
	.align	2
	.globl	AIPerson_Cleanup__Fv

	.extern	Cars_gNumAIRaceCars, 4
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Cars_gNumCopCars, 4
	.extern	AIPerson_glueTable, 84
	.extern	AIPerson_smackProbMask, 16
	.extern	AIPerson_rearEndProbMask, 16
	.extern	AIPerson_bestLineAbilities, 16
	.extern	AIPerson_gripLossRecoveryPerTick, 16
	.extern	AIPerson_gripLossMinFactor, 16
	.extern	AIPerson_gripLossProbPerSecond, 16
	.extern	AIPerson_randomWipeOutTicks, 20
	.extern	AIPerson_minimumWipeOutTicks, 20
	.extern	AIPerson_fishtailAngles, 16
	.extern	AIPerson_attackTimes, 16
	.extern	AIPerson_attackActivationHits, 16
	.extern	AIPerson_brakeMultiplier, 16
	.extern	AIPerson_swerveChangeProb, 16
	.extern	AIPerson_laneSwerve, 64
	.extern	AIPerson_oncomingLookAhead, 16
	.extern	AIPerson_blockMinDistance, 16
	.extern	AIPerson_blockMaxDistance, 16
	.extern	AIPerson_ScriptData, 504
	.extern	AIPerson_PersonalityData, 756
	.extern	GameSetup_gData, 2600
	.extern	Cars_gNumCars, 4

	.text
	.text
	.ent	AIPerson_LoadGridAndSetPersonalityIndexes__Fv
AIPerson_LoadGridAndSetPersonalityIndexes__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$7,Cars_gNumCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$7,$L606
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$6,$2,%lo(GameSetup_gData) # low
	lui	$2,%hi(Cars_gList) # high
	addiu	$5,$2,%lo(Cars_gList) # low
$L602:
	lw	$3,1060($6)
	addu	$6,$6,180
	lw	$2,0($5)
	addu	$4,$4,1
	sw	$3,1260($2)
	slt	$2,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L606:
	j	$31
	.end	AIPerson_LoadGridAndSetPersonalityIndexes__Fv
	.text
	.ent	AIPerson_SetPersonality__FP8Car_tObji
AIPerson_SetPersonality__FP8Car_tObji:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,608($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	move	$16,$5
	.set	macro
	.set	reorder

	lw	$4,648($17)
	sll	$2,$16,3
	lui	$5,%hi(GameSetup_gPersonalityNames) # high
	addiu	$5,$5,%lo(GameSetup_gPersonalityNames) # low
	addu	$5,$2,$5
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$4,$4,92
	.set	macro
	.set	reorder

$L608:
	li	$2,1717960704			# 0x66660000
	ori	$2,$2,0x6667
	mult	$16,$2
	addu	$4,$17,1268
	sra	$2,$16,31
	lui	$5,%hi(AIPerson_ScriptData) # high
	addiu	$5,$5,%lo(AIPerson_ScriptData) # low
	mfhi	$6
	#nop
	#nop
	sra	$3,$6,1
	subu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	subu	$16,$16,$2
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,3
	addu	$5,$2,$5
	sll	$2,$16,2
	addu	$2,$2,$16
	sll	$2,$2,2
	addu	$2,$2,$16
	sll	$2,$2,2
	lui	$3,%hi(AIPerson_PersonalityData) # high
	addiu	$3,$3,%lo(AIPerson_PersonalityData) # low
	addu	$2,$2,$3
	sw	$16,1260($17)
	.set	noreorder
	.set	nomacro
	jal	AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails
	sw	$2,1264($17)
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

	.end	AIPerson_SetPersonality__FP8Car_tObji
	.text
	.ent	AIPerson_SetPersonalityPointers__Fv
AIPerson_SetPersonalityPointers__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(Cars_gList) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Cars_gList) # low
	sw	$31,24($sp)
$L610:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L609
	lw	$4,0($16)
	addu	$16,$16,4
	lw	$5,1260($4)
	.set	noreorder
	.set	nomacro
	jal	AIPerson_SetPersonality__FP8Car_tObji
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L610
$L609:
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

	.end	AIPerson_SetPersonalityPointers__Fv
	.text
	.ent	AIPerson_LoadPersonalityData__FP10Udff_tInfo
AIPerson_LoadPersonalityData__FP10Udff_tInfo:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$4,80($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(AIPerson_PersonalityData) # high
	addiu	$fp,$2,%lo(AIPerson_PersonalityData) # low
	sw	$0,16($sp)
$L616:
	lw	$7,16($sp)
	#nop
	slt	$2,$7,9
	beq	$2,$0,$L613
	lw	$4,80($sp)
	jal	Udff_GetInt__FP10Udff_tInfo
	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$19,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$20,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$23,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$22,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sll	$16,$16,2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$21,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$5,32($sp)
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$6,36($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(AIPerson_blockMaxDistance) # high
	addiu	$3,$3,%lo(AIPerson_blockMaxDistance) # low
	addu	$16,$16,$3
	lw	$3,0($16)
	sll	$18,$18,2
	sw	$3,0($fp)
	lui	$3,%hi(AIPerson_blockMinDistance) # high
	addiu	$3,$3,%lo(AIPerson_blockMinDistance) # low
	addu	$18,$18,$3
	lw	$3,0($18)
	sll	$19,$19,2
	sw	$3,4($fp)
	lui	$3,%hi(AIPerson_oncomingLookAhead) # high
	addiu	$3,$3,%lo(AIPerson_oncomingLookAhead) # low
	addu	$19,$19,$3
	lw	$3,0($19)
	sll	$4,$20,4
	sw	$3,8($fp)
	lui	$3,%hi(AIPerson_laneSwerve) # high
	addiu	$3,$3,%lo(AIPerson_laneSwerve) # low
	addu	$4,$4,$3
	lw	$3,0($4)
	#nop
	sw	$3,12($fp)
	lw	$3,4($4)
	#nop
	sw	$3,16($fp)
	lw	$3,8($4)
	#nop
	sw	$3,20($fp)
	lw	$3,12($4)
	sll	$20,$20,2
	sw	$3,24($fp)
	lui	$3,%hi(AIPerson_swerveChangeProb) # high
	addiu	$3,$3,%lo(AIPerson_swerveChangeProb) # low
	addu	$20,$20,$3
	lw	$3,0($20)
	sll	$23,$23,2
	sw	$3,28($fp)
	lui	$3,%hi(AIPerson_brakeMultiplier) # high
	addiu	$3,$3,%lo(AIPerson_brakeMultiplier) # low
	addu	$23,$23,$3
	lw	$3,0($23)
	sll	$22,$22,2
	sw	$3,32($fp)
	lui	$3,%hi(AIPerson_attackActivationHits) # high
	addiu	$3,$3,%lo(AIPerson_attackActivationHits) # low
	addu	$3,$22,$3
	lw	$3,0($3)
	#nop
	sw	$3,36($fp)
	lui	$3,%hi(AIPerson_attackTimes) # high
	addiu	$3,$3,%lo(AIPerson_attackTimes) # low
	addu	$22,$22,$3
	lw	$3,0($22)
	#nop
	sw	$3,40($fp)
	lui	$3,%hi(AIPerson_fishtailAngles) # high
	lw	$7,20($sp)
	addiu	$3,$3,%lo(AIPerson_fishtailAngles) # low
	sll	$4,$7,2
	addu	$3,$4,$3
	lui	$7,%hi(GameSetup_gData) # high
	lw	$3,0($3)
	addiu	$7,$7,%lo(GameSetup_gData) # low
	sw	$3,44($fp)
	lw	$3,72($7)
	lui	$7,%hi(AIPerson_minimumWipeOutTicks) # high
	addiu	$7,$7,%lo(AIPerson_minimumWipeOutTicks) # low
	addu	$3,$17,$3
	sll	$3,$3,2
	addu	$3,$3,$7
	lui	$7,%hi(GameSetup_gData) # high
	lw	$3,0($3)
	addiu	$7,$7,%lo(GameSetup_gData) # low
	sw	$3,48($fp)
	lui	$3,%hi(AIPerson_randomWipeOutTicks) # high
	lw	$4,72($7)
	addiu	$3,$3,%lo(AIPerson_randomWipeOutTicks) # low
	addu	$17,$17,$4
	sll	$17,$17,2
	addu	$17,$17,$3
	lw	$3,0($17)
	sll	$21,$21,2
	sw	$3,52($fp)
	lui	$3,%hi(AIPerson_gripLossProbPerSecond) # high
	addiu	$3,$3,%lo(AIPerson_gripLossProbPerSecond) # low
	addu	$3,$21,$3
	lw	$3,0($3)
	#nop
	sw	$3,56($fp)
	lui	$3,%hi(AIPerson_gripLossMinFactor) # high
	addiu	$3,$3,%lo(AIPerson_gripLossMinFactor) # low
	addu	$3,$21,$3
	lw	$3,0($3)
	#nop
	sw	$3,60($fp)
	lui	$3,%hi(AIPerson_gripLossRecoveryPerTick) # high
	addiu	$3,$3,%lo(AIPerson_gripLossRecoveryPerTick) # low
	addu	$21,$21,$3
	lw	$3,0($21)
	#nop
	sw	$3,64($fp)
	lui	$3,%hi(AIPerson_bestLineAbilities) # high
	lw	$7,24($sp)
	addiu	$3,$3,%lo(AIPerson_bestLineAbilities) # low
	sll	$4,$7,2
	addu	$3,$4,$3
	lw	$3,0($3)
	#nop
	sw	$3,68($fp)
	lui	$3,%hi(AIPerson_rearEndProbMask) # high
	lw	$5,32($sp)
	addiu	$3,$3,%lo(AIPerson_rearEndProbMask) # low
	sll	$5,$5,2
	addu	$5,$5,$3
	lw	$3,0($5)
	#nop
	sw	$3,72($fp)
	lui	$3,%hi(AIPerson_smackProbMask) # high
	addiu	$3,$3,%lo(AIPerson_smackProbMask) # low
	lw	$6,36($sp)
	lw	$7,16($sp)
	sll	$6,$6,2
	addu	$6,$6,$3
	lw	$3,0($6)
	addu	$7,$7,1
	sw	$7,16($sp)
	sw	$2,80($fp)
	sw	$3,76($fp)
	.set	noreorder
	.set	nomacro
	j	$L616
	addu	$fp,$fp,84
	.set	macro
	.set	reorder

$L613:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	AIPerson_LoadPersonalityData__FP10Udff_tInfo
	.text
	.ent	AIPerson_LoadScriptData__FP10Udff_tInfo
AIPerson_LoadScriptData__FP10Udff_tInfo:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$22,40($sp)
	move	$22,$4
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$23,$0
	lui	$2,%hi(AIPerson_ScriptData) # high
	addiu	$fp,$2,%lo(AIPerson_ScriptData) # low
	move	$21,$23
$L621:
	slt	$2,$23,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L620
	move	$18,$0
	.set	macro
	.set	reorder

$L626:
	slt	$2,$18,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	move	$17,$0
	.set	macro
	.set	reorder

	sll	$20,$18,3
	move	$19,$21
$L628:
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	move	$4,$22
	.set	macro
	.set	reorder

	move	$4,$22
	addu	$16,$17,$20
	addu	$16,$16,$19
	addu	$16,$16,$fp
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sb	$2,0($16)
	.set	macro
	.set	reorder

	addu	$17,$17,1
	sb	$2,4($16)
	slt	$2,$17,4
	bne	$2,$0,$L628
	.set	noreorder
	.set	nomacro
	j	$L626
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L627:
	addu	$21,$21,56
	.set	noreorder
	.set	nomacro
	j	$L621
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L620:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AIPerson_LoadScriptData__FP10Udff_tInfo
	.text
	.ent	AIPerson_LoadGlue__FP10Udff_tInfo
AIPerson_LoadGlue__FP10Udff_tInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Udff_GetInt__FP10Udff_tInfo
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$5,%hi(AIPerson_glueTable) # high
	addiu	$5,$5,%lo(AIPerson_glueTable) # low
	.set	noreorder
	.set	nomacro
	jal	Udff_GetBuffer__FP10Udff_tInfoPci
	li	$6,84			# 0x00000054
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumCopCars
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L637
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L647
	move	$17,$0
	.set	macro
	.set	reorder

$L637:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L647
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	bne	$2,$0,$L634
$L647:
	lui	$2,%hi(AIPerson_glueTable) # high
	addiu	$16,$2,%lo(AIPerson_glueTable) # low
$L638:
	lw	$4,0($16)
	li	$2,65536			# 0x00010000
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	li	$5,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L642
	ori	$5,$5,0x2666
	.set	macro
	.set	reorder

$L641:
	li	$2,65535			# 0x0000ffff
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L644
	li	$5,55705			# 0x0000d999
	.set	macro
	.set	reorder

$L642:
	jal	fixedmult
	sw	$2,0($16)
$L644:
	addu	$17,$17,1
	slt	$2,$17,21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L634:
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

	.end	AIPerson_LoadGlue__FP10Udff_tInfo
	.text
	.ent	AIPerson_Startup__Fv
AIPerson_Startup__Fv:
	.frame	$sp,144,$31		# vars= 112, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$31,136($sp)
	sw	$17,132($sp)
	.set	noreorder
	.set	nomacro
	jal	AIPerson_LoadGridAndSetPersonalityIndexes__Fv
	sw	$16,128($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths) # high
	addiu	$17,$2,%lo(Paths_Paths) # low
	lui	$5,%hi(D_80055354) # high
	lw	$6,8($17)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo(D_80055354) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AIPerson_LoadPersonalityData__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi(D_80055364) # high
	lw	$6,8($17)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo(D_80055364) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AIPerson_LoadScriptData__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L650
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L657
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L650:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L651
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L657
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

$L651:
	addu	$4,$sp,16
	lw	$6,8($17)
	lui	$5,%hi(D_80055374) # high
	.set	noreorder
	.set	nomacro
	j	$L656
	addiu	$5,$5,%lo(D_80055374) # low
	.set	macro
	.set	reorder

$L649:
$L657:
	lw	$2,%lo(GameSetup_gData)($2)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumAIRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L653
	lui	$2,%hi(D_80116470) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lw	$6,%lo(D_80116470)($2)
	lui	$5,%hi(D_80055384) # high
	.set	noreorder
	.set	nomacro
	j	$L656
	addiu	$5,$5,%lo(D_80055384) # low
	.set	macro
	.set	reorder

$L653:
	addu	$4,$sp,16
	lui	$2,%hi(D_80116470) # high
	lw	$6,%lo(D_80116470)($2)
	lui	$5,%hi(D_80055394) # high
	addiu	$5,$5,%lo(D_80055394) # low
$L656:
	jal	sprintf
	addu	$4,$sp,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Udff_Opena__FPcT0i
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AIPerson_LoadGlue__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Udff_Close__FP10Udff_tInfo
	move	$4,$16
	.set	macro
	.set	reorder

	jal	AIPerson_SetPersonalityPointers__Fv
	lw	$31,136($sp)
	lw	$17,132($sp)
	lw	$16,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	AIPerson_Startup__Fv
	.text
	.ent	AIPerson_Cleanup__Fv
AIPerson_Cleanup__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIPerson_Cleanup__Fv
