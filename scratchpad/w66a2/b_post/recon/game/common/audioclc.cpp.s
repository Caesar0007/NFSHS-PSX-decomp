	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\audioclc.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AudioClc_SndError__Fi
	.align	2
	.globl	AudioClc_SetHorn__FP8Car_tObji
	.align	2
	.globl	AudioClc_HonkHorn__FP8Car_tObjiii
	.align	2
	.globl	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
	.align	2
	.globl	AudioClc_StartUp__Fv
	.align	2
	.globl	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
	.align	2
	.globl	AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
	.align	2
	.globl	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	.align	2
	.globl	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	.align	2
	.globl	AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
	.data
	.align	2
trafficFreqs.246:
	.byte	88
	.byte	80
	.byte	70
	.byte	65
	.byte	60
	.byte	50
	.byte	85
	.byte	90
	.byte	60
	.byte	45
	.byte	90
	.byte	50
	.byte	85
	.byte	75
	.byte	84
	.byte	74
	.byte	50
	.byte	70
	.byte	45
	.byte	72
	.byte	60
	.byte	60
	.byte	55
	.byte	70
	.byte	60
	.byte	45
	.byte	50
	.byte	75
	.byte	65
	.byte	82
	.byte	72
	.byte	60
	.byte	86
	.byte	34
	.byte	47
	.byte	82
	.byte	47
	.byte	80
	.byte	30
	.byte	30
	.byte	64
	.byte	74
	.byte	55
	.byte	50
	.byte	52
	.byte	52
	.byte	62
	.byte	21
	.byte	64
	.byte	21
	.text
	.align	2
	.globl	AudioClc_SoundOpponentHorn__Fiiii
	.align	2
	.globl	AudioClc_SilenceOpponentHorn__Fi
	.align	2
	.globl	AudioClc_SoundCloseCar__Fii
	.align	2
	.globl	AudioClc_SoundPlayersCar__Fi
	.align	2
	.globl	AudioClc_ResetClosest__FiP8Car_tObji
	.align	2
	.globl	AudioClc_GetClosestCars__Fiii
	.align	2
	.globl	AudioClc_SoundSpeech__Fv
	.align	2
	.globl	AudioClc_SoundCars__Fv
	.globl	AudioClc_gPlayer
	.data
	.align	2
AudioClc_gPlayer:
	.space	160
	.globl	AudioClc_gClosest
	.align	2
AudioClc_gClosest:
	.space	224
	.globl	AudioClc_gRenderView
	.align	2
AudioClc_gRenderView:
	.space	132
	.globl	AudioClc_PursuitTime
	.align	2
AudioClc_PursuitTime:
	.space	36
	.globl	AudioClc_gCameraVelocity
	.sdata
	.align	2
AudioClc_gCameraVelocity:
	.space	4
	.globl	AudioClc_gRandomPhrase
	.align	2
AudioClc_gRandomPhrase:
	.space	4
	.globl	AudioClc_gBullHornCount
	.align	2
AudioClc_gBullHornCount:
	.space	4
	.globl	AudioClc_gBumpCopCount
	.align	2
AudioClc_gBumpCopCount:
	.space	4
	.globl	AudioClc_gLastVoice
	.align	2
AudioClc_gLastVoice:
	.space	4
	.globl	AudioClc_gLastphrase1
	.align	2
AudioClc_gLastphrase1:
	.space	4
	.globl	AudioClc_gLastphrase2
	.align	2
AudioClc_gLastphrase2:
	.space	4
	.globl	AudioClc_gLastphrase3
	.align	2
AudioClc_gLastphrase3:
	.space	4

	.extern	gMasterAmbientLevel, 4
	.extern	HudBustedOverlay, 4
	.extern	Cars_gNumCars, 4
	.extern	gMasterSFXLevel, 4
	.extern	Camera_gInfo, 544
	.extern	Hud_BeTheCop, 4
	.extern	BWorldSm_slices, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Cars_gNumHumanRaceCars, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AudioClc_SndError__Fi
AudioClc_SndError__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AudioClc_SndError__Fi
	.text
	.ent	AudioClc_SetHorn__FP8Car_tObji
AudioClc_SetHorn__FP8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$0
	lui	$2,%hi(AudioClc_gClosest) # high
	addiu	$6,$2,%lo(AudioClc_gClosest) # low
	li	$7,1			# 0x00000001
	addu	$3,$6,44
$L602:
	lw	$2,0($6)
	#nop
	bne	$2,$4,$L605
	beq	$5,$0,$L606
	sw	$7,-12($3)
	.set	noreorder
	.set	nomacro
	j	$L605
	sw	$0,-8($3)
	.set	macro
	.set	reorder

$L606:
	lw	$2,-12($3)
	#nop
	beq	$2,$0,$L605
	sw	$7,-12($3)
	sw	$7,-8($3)
	sw	$7,0($3)
$L605:
	addu	$8,$8,1
	addu	$3,$3,56
	slt	$2,$8,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	addu	$6,$6,56
	.set	macro
	.set	reorder

	j	$31
	.end	AudioClc_SetHorn__FP8Car_tObji
	.text
	.ent	AudioClc_HonkHorn__FP8Car_tObjiii
AudioClc_HonkHorn__FP8Car_tObjiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$0
	lui	$2,%hi(AudioClc_gClosest) # high
	addiu	$8,$2,%lo(AudioClc_gClosest) # low
	subu	$7,$0,$7
	addu	$3,$8,44
$L611:
	lw	$2,0($8)
	#nop
	bne	$2,$4,$L614
	lw	$2,-12($3)
	#nop
	bne	$2,$0,$L614
	sw	$6,-12($3)
	sw	$6,-8($3)
	sw	$7,-4($3)
	sw	$5,0($3)
$L614:
	addu	$9,$9,1
	addu	$3,$3,56
	slt	$2,$9,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	addu	$8,$8,56
	.set	macro
	.set	reorder

	j	$31
	.end	AudioClc_HonkHorn__FP8Car_tObjiii
	.text
	.ent	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	sw	$2,4($4)
	sw	$2,8($4)
	li	$2,4900			# 0x00001324
	sw	$5,0($4)
	sw	$0,16($4)
	sw	$0,32($4)
	sw	$2,20($4)
	sw	$0,24($4)
	sw	$0,48($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,52($4)
	.set	macro
	.set	reorder

	.end	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
	.text
	.ent	AudioClc_StartUp__Fv
AudioClc_StartUp__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lui	$2,%hi(AudioClc_gPlayer) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(AudioClc_gPlayer) # low
	lui	$2,%hi(AudioClc_gClosest) # high
	sw	$20,32($sp)
	addiu	$20,$2,%lo(AudioClc_gClosest) # low
	sw	$16,16($sp)
	move	$16,$0
	lui	$2,%hi(GameSetup_gData) # high
	sw	$21,36($sp)
	addiu	$21,$2,%lo(GameSetup_gData) # low
	sw	$17,20($sp)
	addu	$17,$18,24
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	sw	$22,40($sp)
	addiu	$22,$2,%lo(Cars_gHumanRaceCarList) # low
	sw	$19,28($sp)
	move	$19,$22
	li	$2,-1			# 0xffffffff
	sw	$31,44($sp)
	sw	$0,AudioClc_gRandomPhrase
	sw	$0,AudioClc_gBullHornCount
	sw	$0,AudioClc_gBumpCopCount
	sw	$2,AudioClc_gLastVoice
	sw	$2,AudioClc_gLastphrase1
	sw	$2,AudioClc_gLastphrase2
	sw	$2,AudioClc_gLastphrase3
$L618:
	move	$4,$17
	move	$5,$0
	li	$2,-1			# 0xffffffff
	sw	$2,0($18)
	sw	$0,-20($17)
	.set	noreorder
	.set	nomacro
	jal	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
	sw	$0,-16($17)
	.set	macro
	.set	reorder

	lw	$2,12($21)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L621
	bne	$16,$0,$L623
	lw	$3,28($21)
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$22
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L623
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L621:
	lw	$2,Cars_gNumHumanRaceCars
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L623
	lw	$2,0($19)
	#nop
	sw	$2,0($17)
$L623:
	addu	$19,$19,4
	addu	$16,$16,1
	addu	$17,$17,80
	slt	$2,$16,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$18,$18,80
	.set	macro
	.set	reorder

	move	$16,$0
$L626:
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	addu	$20,$20,56
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
	sw	$0,AudioClc_gCameraVelocity
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AudioClc_StartUp__Fv
	.text
	.ent	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
AudioClc_CalcDopplerShiftRatio__FP8coorddefT0:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$5
	lui	$5,%hi(AudioClc_gRenderView) # high
	sw	$31,40($sp)
	sw	$16,32($sp)
	lw	$2,0($4)
	lw	$3,%lo(AudioClc_gRenderView)($5)
	addiu	$5,$5,%lo(AudioClc_gRenderView) # low
	subu	$2,$2,$3
	sra	$2,$2,8
	sw	$2,16($sp)
	lw	$2,4($4)
	lw	$3,4($5)
	lw	$16,AudioClc_gCameraVelocity
	subu	$2,$2,$3
	sra	$2,$2,8
	sw	$2,20($sp)
	lw	$2,8($4)
	lw	$3,8($5)
	addu	$4,$sp,16
	subu	$2,$2,$3
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L632
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	bgez	$3,$L633
	addu	$3,$3,255
$L633:
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L634
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L634:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,20($sp)
	mflo	$4
	#nop
	bgez	$3,$L635
	addu	$3,$3,255
$L635:
	lw	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L636
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L636:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,24($sp)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L637
	addu	$5,$4,$7
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L637:
	lw	$2,8($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L638
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L638:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	addu	$6,$5,$7
$L632:
	beq	$16,$0,$L639
	lw	$3,16($sp)
	#nop
	bgez	$3,$L640
	addu	$3,$3,255
$L640:
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L641
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L641:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,20($sp)
	mflo	$4
	#nop
	bgez	$3,$L642
	addu	$3,$3,255
$L642:
	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L643
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L643:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,24($sp)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L644
	addu	$4,$4,$7
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L644:
	lw	$2,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L645
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L645:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$7
	#nop
	#nop
	addu	$2,$4,$7
	subu	$6,$6,$2
$L639:
	li	$4,22282240			# 0x01540000
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	addu	$5,$6,$5
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
	.text
	.ent	AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($5)
	lw	$2,0($4)
	lw	$6,4($5)
	lw	$5,8($5)
	subu	$7,$3,$2
	bgez	$7,1f
	subu	$7,$0,$7
1:
	lw	$3,4($4)
	lw	$2,8($4)
	subu	$6,$6,$3
	subu	$3,$5,$2
	bgez	$6,1f
	subu	$6,$0,$6
1:
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L647
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L648
	addu	$3,$7,$2
	.set	macro
	.set	reorder

$L647:
	sra	$2,$7,2
	addu	$3,$3,$2
$L648:
	slt	$2,$3,$6
	beq	$2,$0,$L649
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$6,$2
	.set	macro
	.set	reorder

$L649:
	sra	$2,$6,2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
	.text
	.ent	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	lw	$3,0($5)
	lw	$2,0($4)
	#nop
	subu	$6,$3,$2
	sw	$6,16($sp)
	lw	$3,4($5)
	lw	$2,4($4)
	#nop
	subu	$7,$3,$2
	sw	$7,20($sp)
	lw	$3,8($5)
	lw	$2,8($4)
	move	$5,$6
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$6,$L652
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	addu	$5,$6,255
$L652:
	lw	$2,12($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L653
	sra	$10,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L653:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L654
	move	$5,$7
	.set	macro
	.set	reorder

	addu	$5,$7,255
$L654:
	lw	$2,16($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L655
	sra	$9,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L655:
	sra	$2,$2,8
	mult	$9,$2
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L656
	addu	$5,$8,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L656:
	lw	$2,20($4)
	#nop
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
	mflo	$11
	#nop
	lw	$2,36($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L659
	addu	$3,$5,$11
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L659:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$5
	#nop
	lw	$2,40($4)
	#nop
	bgez	$2,$L661
	addu	$2,$2,255
$L661:
	sra	$2,$2,8
	mult	$9,$2
	lw	$6,24($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L662
	addu	$5,$5,$11
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L662:
	lw	$2,44($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L663
	sra	$6,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L663:
	sra	$2,$2,8
	mult	$6,$2
	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	addu	$5,$5,$11
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L664:
	sra	$4,$3,8
	.set	noreorder
	.set	nomacro
	jal	intatan
	sra	$5,$5,8
	.set	macro
	.set	reorder

	sll	$2,$2,6
	lw	$31,32($sp)
	andi	$2,$2,0xffc0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	.text
	.ent	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj:
	.frame	$sp,16,$31		# vars= 16, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$5
	lw	$3,160($7)
	lw	$2,0($4)
	subu	$sp,$sp,16
	subu	$3,$3,$2
	sw	$3,0($sp)
	lw	$5,164($7)
	lw	$2,4($4)
	#nop
	subu	$6,$5,$2
	sw	$6,4($sp)
	lw	$5,168($7)
	lw	$2,8($4)
	#nop
	subu	$4,$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L666
	sw	$4,8($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L666:
	lw	$2,264($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L667
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L667:
	sra	$2,$2,8
	mult	$3,$2
	move	$5,$6
	mflo	$3
	#nop
	bgez	$5,$L668
	addu	$5,$5,255
$L668:
	lw	$2,268($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L669
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L669:
	sra	$2,$2,8
	mult	$5,$2
	move	$5,$4
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L670
	addu	$3,$3,$8
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L670:
	lw	$2,272($7)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L671
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L671:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$8
	#nop
	#nop
	addu	$2,$3,$8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	.text
	.ent	AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$7,348($5)
	move	$9,$4
	.set	noreorder
	.set	nomacro
	bgez	$7,$L673
	move	$3,$7
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L673:
	lw	$2,12($9)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L674
	sra	$11,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L674:
	sra	$2,$2,8
	mult	$11,$2
	lw	$6,352($5)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L675
	move	$3,$6
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L675:
	lw	$2,16($9)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L676
	sra	$10,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L676:
	sra	$2,$2,8
	mult	$10,$2
	lw	$5,356($5)
	#nop
	move	$3,$5
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L677
	addu	$4,$8,$12
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L677:
	lw	$2,20($9)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L678
	sra	$8,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L678:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$12
	#nop
	lw	$2,36($9)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L680
	addu	$4,$4,$12
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L680:
	sra	$2,$2,8
	mult	$11,$2
	mflo	$3
	#nop
	lw	$2,40($9)
	#nop
	bgez	$2,$L682
	addu	$2,$2,255
$L682:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$12
	#nop
	lw	$2,44($9)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L684
	addu	$3,$3,$12
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L684:
	sra	$2,$2,8
	mult	$8,$2
	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	mflo	$12
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L685
	addu	$5,$3,$12
	.set	macro
	.set	reorder

	subu	$4,$0,$4
$L685:
	sra	$4,$4,8
	.set	noreorder
	.set	nomacro
	jal	intatan
	sra	$5,$5,8
	.set	macro
	.set	reorder

	sll	$2,$2,6
	lw	$31,16($sp)
	andi	$2,$2,0xffc0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
	.text
	.ent	AudioClc_SoundOpponentHorn__Fiiii
AudioClc_SoundOpponentHorn__Fiiii:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$8,$4
	move	$9,$5
	sll	$2,$8,3
	subu	$2,$2,$8
	sll	$2,$2,3
	lui	$3,%hi(AudioClc_gClosest) # high
	addiu	$3,$3,%lo(AudioClc_gClosest) # low
	addu	$2,$2,$3
	sw	$31,24($sp)
	lw	$2,0($2)
	move	$10,$6
	lw	$2,648($2)
	#nop
	lw	$6,0($2)
	li	$2,48			# 0x00000030
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L687
	li	$5,10			# 0x0000000a
	.set	macro
	.set	reorder

	li	$5,11			# 0x0000000b
$L687:
	li	$4,1795096576			# 0x6aff0000
	ori	$4,$4,0x5f81
	li	$2,4900			# 0x00001324
	subu	$2,$2,$7
	sll	$3,$2,7
	subu	$3,$3,$2
	mult	$3,$4
	lui	$2,%hi(trafficFreqs.246) # high
	addiu	$2,$2,%lo(trafficFreqs.246) # low
	addu	$2,$6,$2
	sra	$3,$3,31
	addu	$4,$8,37
	lbu	$6,0($2)
	move	$7,$10
	sw	$9,20($sp)
	mfhi	$11
	#nop
	#nop
	sra	$2,$11,11
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlaySFX__Fiiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	AudioClc_SoundOpponentHorn__Fiiii
	.text
	.ent	AudioClc_SilenceOpponentHorn__Fi
AudioClc_SilenceOpponentHorn__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$4,37
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

	.end	AudioClc_SilenceOpponentHorn__Fi
	.text
	.ent	AudioClc_SoundCloseCar__Fii
AudioClc_SoundCloseCar__Fii:
	.frame	$sp,72,$31		# vars= 0, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$23,60($sp)
	move	$23,$5
	sll	$3,$23,3
	subu	$3,$3,$23
	sll	$3,$3,3
	lui	$2,%hi(AudioClc_gClosest) # high
	addiu	$2,$2,%lo(AudioClc_gClosest) # low
	sw	$19,44($sp)
	addu	$19,$3,$2
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	sw	$4,72($sp)
	lw	$18,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L689
	addu	$16,$18,160
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
	addu	$5,$18,172
	.set	macro
	.set	reorder

	move	$fp,$2
	.set	noreorder
	.set	nomacro
	bltz	$fp,$L689
	lui	$2,%hi(AudioClc_gRenderView) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(AudioClc_gRenderView) # low
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	li	$20,65536			# 0x00010000
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L734
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	li	$3,-65536			# 0xffff0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L692
	move	$4,$17
	.set	macro
	.set	reorder

$L734:
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L693
	move	$17,$2
	.set	macro
	.set	reorder

$L696:
	.set	noreorder
	.set	nomacro
	j	$L693
	li	$17,65536			# 0x00010000
	.set	macro
	.set	reorder

$L692:
	li	$17,-65536			# 0xffff0000
$L693:
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L698
	lui	$4,%hi(AudioClc_gRenderView) # high
	.set	macro
	.set	reorder

	lw	$8,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L700
	li	$21,16383			# 0x00003fff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L700
	li	$21,49152			# 0x0000c000
	.set	macro
	.set	reorder

$L698:
	addiu	$4,$4,%lo(AudioClc_gRenderView) # low
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	addu	$5,$18,160
	.set	macro
	.set	reorder

	move	$21,$2
$L700:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L701
	move	$2,$16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$16,$2
$L701:
	sra	$20,$2,16
	mult	$20,$20
	li	$22,4900			# 0x00001324
	mflo	$20
	#nop
	#nop
	slt	$2,$20,$22
	beq	$2,$0,$L702
	move	$22,$20
$L702:
	lw	$2,AudioClc_gCameraVelocity
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L703
	lui	$2,%hi(AudioClc_gPlayer) # high
	.set	macro
	.set	reorder

	lw	$8,72($sp)
	addiu	$2,$2,%lo(AudioClc_gPlayer) # low
	sll	$3,$8,2
	addu	$3,$3,$8
	sll	$3,$3,4
	addu	$3,$3,$2
	lw	$2,24($3)
	lw	$4,1380($18)
	lw	$3,1380($2)
	#nop
	subu	$2,$4,$3
	bgtz	$2,$L731
	.set	noreorder
	.set	nomacro
	j	$L731
	subu	$2,$3,$4
	.set	macro
	.set	reorder

$L703:
	lw	$2,1380($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
$L731:
	sw	$2,12($19)
	sw	$22,20($19)
	lw	$2,1124($18)
	lw	$6,1128($18)
	lw	$2,240($2)
	sll	$6,$6,16
	div	$6,$6,$2
	lw	$3,648($18)
	sw	$16,16($sp)
	sw	$21,20($sp)
	lw	$2,1056($18)
	addu	$4,$23,6
	sw	$17,28($sp)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sw	$2,24($sp)
	lw	$5,0($3)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_TrafficSFX__Fiiiiiiii
	move	$7,$fp
	.set	macro
	.set	reorder

	lw	$2,1940($18)
	#nop
	addu	$17,$2,-1
	.set	noreorder
	.set	nomacro
	bltz	$17,$L707
	sll	$2,$17,1
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	sll	$2,$2,3
	addu	$16,$2,$18
$L708:
	lw	$2,1948($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L709
	addu	$4,$23,32
	.set	macro
	.set	reorder

	sw	$20,16($sp)
	sw	$21,20($sp)
	lw	$5,1952($16)
	lw	$6,1956($16)
	lw	$7,1960($16)
	j	$L732
$L709:
	sw	$22,16($sp)
	sw	$21,20($sp)
	lw	$5,1952($16)
	lw	$6,1956($16)
	lw	$7,1960($16)
	li	$4,-1			# 0xffffffff
$L732:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii
	addu	$16,$16,-24
	.set	macro
	.set	reorder

	addu	$17,$17,-1
	bgez	$17,$L708
$L707:
	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L712
	lbu	$2,1094($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	move	$4,$23
	.set	macro
	.set	reorder

	move	$5,$21
	move	$6,$fp
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundOpponentHorn__Fiiii
	move	$7,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L733
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L713:
	lw	$2,32($19)
	#nop
	beq	$2,$0,$L716
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SilenceOpponentHorn__Fi
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L716
	sw	$0,32($19)
	.set	macro
	.set	reorder

$L712:
	lw	$3,32($19)
	#nop
	blez	$3,$L717
	lw	$2,36($19)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L718
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	sw	$2,32($19)
$L718:
	lw	$2,32($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L719
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SilenceOpponentHorn__Fi
	sb	$0,1094($18)
	.set	macro
	.set	reorder

	lw	$2,44($19)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L716
	sw	$2,44($19)
	.set	macro
	.set	reorder

	lw	$2,40($19)
	.set	noreorder
	.set	nomacro
	j	$L716
	sw	$2,32($19)
	.set	macro
	.set	reorder

$L719:
	sb	$2,1094($18)
	move	$4,$23
	move	$5,$21
	move	$6,$fp
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundOpponentHorn__Fiiii
	move	$7,$22
	.set	macro
	.set	reorder

	j	$L716
$L717:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L716
	addu	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L716
	sw	$2,32($19)
	.set	macro
	.set	reorder

	lw	$2,36($19)
$L733:
	sw	$2,32($19)
$L716:
	lw	$2,648($18)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-22
	sltu	$2,$2,6
	beq	$2,$0,$L689
	lw	$2,1392($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L726
	li	$3,1795096576			# 0x6aff0000
	.set	macro
	.set	reorder

	ori	$3,$3,0x5f81
	li	$2,4900			# 0x00001324
	subu	$2,$2,$22
	sll	$4,$2,7
	subu	$4,$4,$2
	mult	$4,$3
	sra	$4,$4,31
	lui	$3,%hi(bSirenOn) # high
	addiu	$3,$3,%lo(bSirenOn) # low
	sll	$2,$23,2
	addu	$2,$2,$3
	lw	$2,0($2)
	mfhi	$8
	#nop
	#nop
	sra	$5,$8,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	subu	$5,$5,$4
	.set	macro
	.set	reorder

	lw	$5,608($18)
	move	$4,$23
	.set	noreorder
	.set	nomacro
	jal	SirenOn__Fii
	andi	$5,$5,0x0040
	.set	macro
	.set	reorder

	j	$L689
$L727:
	move	$4,$23
	move	$6,$fp
	lw	$2,608($18)
	move	$7,$21
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	jal	UpdateSiren__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	j	$L689
$L726:
	lui	$2,%hi(bSirenOn) # high
	addiu	$2,$2,%lo(bSirenOn) # low
	sll	$3,$23,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L689
	.set	noreorder
	.set	nomacro
	jal	SirenOff__Fi
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$23,43
	.set	macro
	.set	reorder

$L689:
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

	.end	AudioClc_SoundCloseCar__Fii
	.text
	.ent	AudioClc_SoundPlayersCar__Fi
AudioClc_SoundPlayersCar__Fi:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$4,80($sp)
	lui	$4,%hi(AudioClc_gRenderView) # high
	lui	$2,%hi(AudioClc_gPlayer+24) # high
	lw	$8,80($sp)
	addiu	$2,$2,%lo(AudioClc_gPlayer+24) # low
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
	sll	$3,$8,2
	addu	$3,$3,$8
	sll	$3,$3,4
	addu	$23,$3,$2
	lw	$18,0($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$Lnthr1_735
	addiu	$fp,$4,%lo(AudioClc_gRenderView) # low
	.set	macro
	.set	reorder

	lw	$2,608($18)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lnthr1_737
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$3,1360($18)
	lw	$2,1364($18)
	#nop
	beq	$3,$2,$Lnthr1_739
	.set	noreorder
	.set	nomacro
	j	$Lnthr1_739
	li	$17,-1			# 0xffffffff
	.set	macro
	.set	reorder

$Lnthr1_737:
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
	lui	$3,%hi(GameSetup_gData+48) # high
	lw	$3,%lo(GameSetup_gData+48)($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$Lnthr1_739
	addu	$17,$17,$2
	.set	macro
	.set	reorder

	subu	$17,$0,$17
$Lnthr1_739:
	lw	$2,912($18)
	li	$4,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$Lnthr1_741
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$Lnthr1_743
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	bne	$3,$2,$Lnthr1_742
$Lnthr1_743:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_744
	addiu	$3,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	#nop
	bne	$2,$4,$Lnthr1_742
	lw	$2,4($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	beq	$2,$0,$Lnthr1_742
$Lnthr1_744:
	lw	$2,608($18)
	li	$3,4			# 0x00000004
	andi	$2,$2,0x0204
	beq	$2,$3,$Lnthr1_741
$Lnthr1_742:
	lw	$2,1120($18)
	#nop
	bne	$2,$0,$Lnthr1_741
	lw	$2,632($18)
	#nop
	bne	$2,$0,$Lnthr1_741
	bgez	$17,$Lnthr1_741
	lhu	$2,380($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_799
	addu	$16,$18,160
	.set	macro
	.set	reorder

	lw	$2,1932($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_797
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,1008($18)
	#nop
	addu	$3,$2,1
	slt	$2,$3,64
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_797
	sw	$3,1008($18)
	.set	macro
	.set	reorder

	andi	$2,$3,0x001f
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_797
	slt	$2,$3,148
	.set	macro
	.set	reorder

	bne	$2,$0,$Lnthr1_747
	lw	$2,Hud_BeTheCop
	#nop
	beq	$2,$0,$Lnthr1_797
$Lnthr1_747:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayWrongWaySFX__Fv
	addu	$16,$18,160
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_797
	move	$4,$16
	.set	macro
	.set	reorder

$Lnthr1_741:
	sw	$0,1008($18)
	addu	$16,$18,160
$Lnthr1_799:
	move	$4,$16
$Lnthr1_797:
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
	addu	$5,$18,172
	.set	macro
	.set	reorder

	sw	$2,32($sp)
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$Lnthr1_749
	lui	$2,%hi(Camera_gInfo) # high
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$Lnthr1_751
	li	$21,49152			# 0x0000c000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_751
	li	$21,16383			# 0x00003fff
	.set	macro
	.set	reorder

$Lnthr1_749:
	lw	$8,80($sp)
	addiu	$2,$2,%lo(Camera_gInfo) # low
	sll	$3,$8,4
	addu	$3,$3,$8
	sll	$3,$3,4
	addu	$3,$3,$2
	lh	$2,112($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_752
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_802
	move	$21,$0
	.set	macro
	.set	reorder

$Lnthr1_752:
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	move	$5,$16
	.set	macro
	.set	reorder

	move	$21,$2
$Lnthr1_751:
	move	$4,$fp
$Lnthr1_802:
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef
	addu	$5,$18,160
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$17
	.set	macro
	.set	reorder

	li	$16,65536			# 0x00010000
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_800
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$17
	.set	macro
	.set	reorder

	li	$3,-65536			# 0xffff0000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_754
	li	$19,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	move	$4,$fp
$Lnthr1_800:
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$17
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_801
	li	$19,65536			# 0x00010000
	.set	macro
	.set	reorder

	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
$Lnthr1_754:
$Lnthr1_755:
$Lnthr1_801:
	.set	noreorder
	.set	nomacro
	bgez	$17,$Lnthr1_760
	move	$2,$17
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$17,$2
$Lnthr1_760:
	sra	$20,$2,16
	mult	$20,$20
	lw	$2,648($18)
	#nop
	lw	$3,8($2)
	li	$2,1			# 0x00000001
	mflo	$20
	#nop
	bne	$3,$2,$Lnthr1_761
	lw	$2,1124($18)
	#nop
	lw	$2,240($2)
	.set	noreorder
	.set	nomacro
	j	$Lnthr1_762
	addu	$6,$2,1000
	.set	macro
	.set	reorder

$Lnthr1_761:
	lw	$2,1124($18)
	#nop
	lw	$2,240($2)
	#nop
	addu	$6,$2,2000
$Lnthr1_762:
	lhu	$2,380($18)
	#nop
	sltu	$2,$2,6
	bne	$2,$0,$Lnthr1_763
	addu	$6,$6,-500
$Lnthr1_763:
	lw	$3,1128($18)
	#nop
	sll	$2,$3,7
	subu	$2,$2,$3
	lw	$3,AudioClc_gCameraVelocity
	div	$22,$2,$6
	beq	$3,$0,$Lnthr1_764
	.set	noreorder
	.set	nomacro
	j	$Lnthr1_765
	sw	$0,12($23)
	.set	macro
	.set	reorder

$Lnthr1_764:
	lw	$2,1380($18)
	#nop
	bgez	$2,1f
	subu	$2,$0,$2
1:
	sw	$2,12($23)
$Lnthr1_765:
	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$18
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	AudioTrk_SoundTrack__FP8Car_tObji
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$17
	sw	$21,16($sp)
	sw	$16,20($sp)
	lw	$2,12($23)
	lw	$7,32($sp)
	move	$6,$22
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_SoundCar__FP8Car_tObjiiiiiii
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$2,gMasterSFXLevel
	#nop
	beq	$2,$0,$Lnthr1_735
	lw	$2,1940($18)
	#nop
	addu	$19,$2,-1
	.set	noreorder
	.set	nomacro
	bltz	$19,$Lnthr1_768
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$22,$2,%lo(GameSetup_gData) # low
	sll	$2,$19,1
	addu	$2,$2,$19
	sll	$2,$2,3
	addu	$17,$2,$18
$Lnthr1_769:
	lw	$4,1948($17)
	li	$2,18			# 0x00000012
	bne	$4,$2,$Lnthr1_770
	lw	$8,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$Lnthr1_772
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_772
	li	$16,19			# 0x00000013
	.set	macro
	.set	reorder

$Lnthr1_770:
	li	$2,20			# 0x00000014
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$Lnthr1_773
	move	$16,$4
	.set	macro
	.set	reorder

	lw	$8,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$Lnthr1_772
	move	$16,$2
	.set	macro
	.set	reorder

	li	$16,21			# 0x00000015
$Lnthr1_773:
$Lnthr1_772:
	lw	$3,1944($17)
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$Lnthr1_777
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	bne	$3,$2,$Lnthr1_776
$Lnthr1_777:
	bltz	$16,$Lnthr1_776
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$2,$16,-18
	sltu	$2,$2,2
	beq	$2,$0,$Lnthr1_779
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_798
	addu	$17,$17,-24
	.set	macro
	.set	reorder

$Lnthr1_776:
	.set	noreorder
	.set	nomacro
	bgez	$16,$Lnthr1_780
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,12($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$Lnthr1_780
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$3,1952($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$Lnthr1_780
	li	$2,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$Lnthr1_780
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	addu	$5,$18,416
	.set	macro
	.set	reorder

	sw	$20,16($sp)
	.set	noreorder
	.set	nomacro
	j	$Lnthr1_794
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$Lnthr1_780:
	sw	$20,16($sp)
	sw	$21,20($sp)
$Lnthr1_794:
	lw	$5,1952($17)
	lw	$6,1956($17)
	lw	$7,1960($17)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_SFX__Fi6s_typeT1iii
	move	$4,$16
	.set	macro
	.set	reorder

$Lnthr1_779:
	addu	$17,$17,-24
$Lnthr1_798:
	addu	$19,$19,-1
	bgez	$19,$Lnthr1_769
$Lnthr1_768:
	lbu	$2,1094($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lnthr1_783
	move	$5,$20
	.set	macro
	.set	reorder

	lw	$8,32($sp)
	li	$6,64			# 0x00000040
	sw	$8,16($sp)
	lw	$4,596($18)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayerHornOn__Fiiiii
	move	$7,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$Lnthr1_795
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$Lnthr1_783:
	lw	$2,32($23)
	#nop
	beq	$2,$0,$Lnthr1_784
	lw	$4,596($18)
	jal	AudioCmn_PlayerHornOff__Fi
$Lnthr1_795:
	sw	$2,32($23)
$Lnthr1_784:
	lw	$2,648($18)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-22
	sltu	$2,$2,6
	beq	$2,$0,$Lnthr1_735
	lw	$2,1392($18)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lnthr1_787
	slt	$2,$20,4900
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$Lnthr1_788
	li	$4,1795096576			# 0x6aff0000
	.set	macro
	.set	reorder

	ori	$4,$4,0x5f81
	li	$2,4900			# 0x00001324
	subu	$2,$2,$20
	sll	$3,$2,7
	subu	$3,$3,$2
	mult	$3,$4
	sra	$3,$3,31
	mfhi	$8
	#nop
	#nop
	sra	$2,$8,11
	.set	noreorder
	.set	nomacro
	j	$Lnthr1_789
	subu	$5,$2,$3
	.set	macro
	.set	reorder

$Lnthr1_788:
	move	$5,$0
$Lnthr1_789:
	lui	$3,%hi(bSirenOn) # high
	lw	$2,596($18)
	addiu	$3,$3,%lo(bSirenOn) # low
	addu	$4,$2,4
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$Lnthr1_790
	move	$7,$21
	.set	macro
	.set	reorder

	lw	$5,608($18)
	.set	noreorder
	.set	nomacro
	jal	SirenOn__Fii
	andi	$5,$5,0x0040
	.set	macro
	.set	reorder

	j	$Lnthr1_735
$Lnthr1_790:
	lw	$2,608($18)
	lw	$6,32($sp)
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	jal	UpdateSiren__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	j	$Lnthr1_735
$Lnthr1_787:
	lui	$3,%hi(bSirenOn) # high
	lw	$2,596($18)
	addiu	$3,$3,%lo(bSirenOn) # low
	addu	$4,$2,4
	sll	$2,$4,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	beq	$2,$0,$Lnthr1_735
	jal	SirenOff__Fi
	lw	$4,596($18)
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$4,47
	.set	macro
	.set	reorder

$Lnthr1_735:
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

	.end	AudioClc_SoundPlayersCar__Fi
	.text
	.ent	AudioClc_ResetClosest__FiP8Car_tObji
AudioClc_ResetClosest__FiP8Car_tObji:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(AudioClc_gClosest) # high
	addiu	$2,$2,%lo(AudioClc_gClosest) # low
	sll	$3,$16,3
	subu	$3,$3,$16
	sll	$3,$3,3
	addu	$3,$3,$2
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L805
	move	$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L808
	lui	$2,%hi(bSirenOn) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,14
	.set	macro
	.set	reorder

	lui	$2,%hi(bSirenOn) # high
$L808:
	addiu	$2,$2,%lo(bSirenOn) # low
	sll	$3,$16,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L807
	.set	noreorder
	.set	nomacro
	jal	SirenOff__Fi
	move	$4,$16
	.set	macro
	.set	reorder

$L807:
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,37
	.set	macro
	.set	reorder

$L805:
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,3
	lui	$4,%hi(AudioClc_gClosest) # high
	addiu	$4,$4,%lo(AudioClc_gClosest) # low
	addu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	jal	AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj
	move	$5,$17
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

	.end	AudioClc_ResetClosest__FiP8Car_tObji
	.text
	.ent	AudioClc_GetClosestCars__Fiii
AudioClc_GetClosestCars__Fiii:
	.frame	$fp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$fp,56($sp)
	move	$fp,$sp
	sw	$23,52($sp)
	move	$23,$4
	sw	$21,44($sp)
	move	$21,$6
	sll	$2,$21,6
	srl	$2,$2,3
	sw	$31,60($sp)
	sw	$22,48($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	subu	$sp,$sp,$2
	move	$18,$0
	sw	$5,68($fp)
	sll	$3,$5,3
	subu	$3,$3,$5
	sll	$3,$3,3
	lui	$2,%hi(AudioClc_gClosest) # high
	addiu	$2,$2,%lo(AudioClc_gClosest) # low
	addu	$3,$3,$2
	addu	$22,$sp,16
	.set	noreorder
	.set	nomacro
	blez	$21,$L880
	sw	$3,16($fp)
	.set	macro
	.set	reorder

	li	$4,19660800			# 0x012c0000
	move	$3,$22
$L813:
	sw	$0,0($3)
	sw	$4,4($3)
	addu	$18,$18,1
	slt	$2,$18,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	addu	$3,$3,8
	.set	macro
	.set	reorder

	move	$18,$0
$L880:
	lui	$2,%hi(Cars_gList) # high
	addiu	$19,$2,%lo(Cars_gList) # low
$L815:
	lw	$2,Cars_gNumCars
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	lui	$9,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$9,$9,%lo(GameSetup_gData) # low
	lw	$3,12($9)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L818
	sll	$2,$23,2
	.set	macro
	.set	reorder

	lw	$2,0($19)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L821
	.set	noreorder
	.set	nomacro
	j	$L881
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L818:
	addu	$2,$2,$23
	sll	$2,$2,4
	lui	$9,%hi(AudioClc_gPlayer) # high
	addiu	$9,$9,%lo(AudioClc_gPlayer) # low
	addu	$2,$2,$9
	lw	$3,0($19)
	lw	$2,24($2)
	#nop
	beq	$3,$2,$L820
$L821:
	lw	$4,0($19)
	#nop
	lbu	$2,145($4)
	#nop
	beq	$2,$0,$L820
	lw	$2,608($4)
	#nop
	andi	$2,$2,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L824
	li	$20,19660800			# 0x012c0000
	.set	macro
	.set	reorder

	li	$20,3276800			# 0x00320000
$L824:
	lui	$9,%hi(AudioClc_gRenderView) # high
	addiu	$9,$9,%lo(AudioClc_gRenderView) # low
	lw	$3,160($4)
	lw	$2,0($9)
	lw	$5,164($4)
	lw	$4,168($4)
	subu	$6,$3,$2
	bgez	$6,1f
	subu	$6,$0,$6
1:
	lw	$3,4($9)
	lw	$2,8($9)
	subu	$17,$5,$3
	subu	$3,$4,$2
	bgez	$17,1f
	subu	$17,$0,$17
1:
	bgez	$3,1f
	subu	$3,$0,$3
1:
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L825
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L826
	addu	$16,$6,$2
	.set	macro
	.set	reorder

$L825:
	sra	$2,$6,2
	addu	$16,$3,$2
$L826:
	li	$2,26148864			# 0x018f0000
	ori	$2,$2,0xffff
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L878
	slt	$2,$16,$20
	.set	macro
	.set	reorder

	lw	$2,0($19)
	#nop
	lw	$2,648($2)
	#nop
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_GetEnginePatch__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L827
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$0
	.set	macro
	.set	reorder

$L827:
	slt	$2,$16,$20
$L878:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L820
	slt	$2,$16,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L830
	sra	$2,$16,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L831
	addu	$8,$17,$2
	.set	macro
	.set	reorder

$L830:
	sra	$2,$17,2
	addu	$8,$16,$2
$L831:
	slt	$2,$8,$20
	beq	$2,$0,$L820
	.set	noreorder
	.set	nomacro
	blez	$21,$L820
	move	$6,$0
	.set	macro
	.set	reorder

	move	$7,$22
$L836:
	lw	$2,4($7)
	#nop
	slt	$2,$8,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L835
	addu	$5,$21,-1
	.set	macro
	.set	reorder

	slt	$2,$6,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	sll	$4,$5,3
	.set	macro
	.set	reorder

$L879:
	addu	$5,$5,-1
	sll	$2,$5,3
	addu	$2,$22,$2
	lw	$3,0($2)
	addu	$4,$22,$4
	sw	$3,0($4)
	lw	$2,4($2)
	#nop
	sw	$2,4($4)
	slt	$2,$6,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L879
	sll	$4,$5,3
	.set	macro
	.set	reorder

$L839:
	lw	$2,0($19)
	sw	$8,4($7)
	.set	noreorder
	.set	nomacro
	j	$L820
	sw	$2,0($7)
	.set	macro
	.set	reorder

$L835:
	addu	$6,$6,1
	slt	$2,$6,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L836
	addu	$7,$7,8
	.set	macro
	.set	reorder

$L820:
	addu	$18,$18,1
$L881:
	.set	noreorder
	.set	nomacro
	j	$L815
	addu	$19,$19,4
	.set	macro
	.set	reorder

$L816:
	.set	noreorder
	.set	nomacro
	blez	$21,$L845
	move	$18,$0
	.set	macro
	.set	reorder

	li	$8,-1			# 0xffffffff
	lw	$5,16($fp)
$L847:
	lw	$2,0($5)
	#nop
	beq	$2,$0,$L846
	.set	noreorder
	.set	nomacro
	blez	$21,$L850
	move	$6,$0
	.set	macro
	.set	reorder

	move	$7,$5
	move	$4,$22
$L852:
	lw	$3,0($4)
	lw	$2,0($7)
	#nop
	bne	$3,$2,$L851
	.set	noreorder
	.set	nomacro
	j	$L850
	sw	$0,0($4)
	.set	macro
	.set	reorder

$L851:
	addu	$6,$6,1
	slt	$2,$6,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L852
	addu	$4,$4,8
	.set	macro
	.set	reorder

$L850:
	bne	$6,$21,$L846
	sw	$8,0($5)
$L846:
	addu	$18,$18,1
	slt	$2,$18,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L847
	addu	$5,$5,56
	.set	macro
	.set	reorder

$L845:
	.set	noreorder
	.set	nomacro
	blez	$21,$L858
	move	$18,$0
	.set	macro
	.set	reorder

	li	$17,-1			# 0xffffffff
	move	$16,$22
$L860:
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L859
	.set	noreorder
	.set	nomacro
	blez	$21,$L859
	move	$6,$0
	.set	macro
	.set	reorder

	move	$5,$16
	lw	$3,16($fp)
$L865:
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L867
	bne	$2,$17,$L864
$L867:
	lw	$9,68($fp)
	lw	$5,0($5)
	addu	$4,$6,$9
	.set	noreorder
	.set	nomacro
	jal	AudioClc_ResetClosest__FiP8Car_tObji
	move	$6,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L877
	addu	$16,$16,8
	.set	macro
	.set	reorder

$L864:
	addu	$6,$6,1
	slt	$2,$6,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L865
	addu	$3,$3,56
	.set	macro
	.set	reorder

$L859:
	addu	$16,$16,8
$L877:
	addu	$18,$18,1
	slt	$2,$18,$21
	bne	$2,$0,$L860
$L858:
	.set	noreorder
	.set	nomacro
	blez	$21,$L871
	move	$18,$0
	.set	macro
	.set	reorder

	li	$17,-1			# 0xffffffff
	lw	$16,16($fp)
$L873:
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L872
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$9,68($fp)
	move	$6,$23
	.set	noreorder
	.set	nomacro
	jal	AudioClc_ResetClosest__FiP8Car_tObji
	addu	$4,$18,$9
	.set	macro
	.set	reorder

$L872:
	addu	$18,$18,1
	slt	$2,$18,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L873
	addu	$16,$16,56
	.set	macro
	.set	reorder

$L871:
	move	$sp,$fp
	lw	$31,60($sp)
	lw	$fp,56($sp)
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

	.end	AudioClc_GetClosestCars__Fiii
	.text
	.ent	AudioClc_SoundSpeech__Fv
AudioClc_SoundSpeech__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AudioCmn_SetLevels__Fv
	jal	Speech_Server__Fv
	jal	CopSpeak_Server__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioClc_SoundSpeech__Fv
	.text
	.ent	AudioClc_SoundCars__Fv
AudioClc_SoundCars__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundSpeech__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	jal	AudioCmn_UpdateThunder__Fv
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$5,$2,%lo(GameSetup_gData) # low
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L886
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L899
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

$L886:
	lui	$3,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($3)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L887
	addiu	$4,$3,%lo(Cars_gHumanRaceCarList) # low
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumHumanRaceCars
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L899
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L899
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

$L887:
	lw	$2,HudBustedOverlay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L899
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$2,428($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L885
	move	$17,$0
	.set	macro
	.set	reorder

	move	$18,$5
	move	$16,$18
$L891:
	move	$5,$0
	lw	$4,444($16)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_GetEnginePatch__Fii
	addu	$17,$17,1
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$4,444($16)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_GetEnginePatch__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,428($18)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L891
	addu	$16,$16,52
	.set	macro
	.set	reorder

$L885:
	lui	$2,%hi(GameSetup_gData+12) # high
$L899:
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L893
	lui	$16,%hi(AudioClc_gRenderView) # high
	.set	macro
	.set	reorder

	move	$4,$0
	addiu	$17,$16,%lo(AudioClc_gRenderView) # low
	la	$6,AudioClc_gCameraVelocity
	.set	noreorder
	.set	nomacro
	jal	Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
	move	$5,$17
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	AudioClc_GetClosestCars__Fiii
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundPlayersCar__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,gMasterAmbientLevel
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L900
	move	$5,$17
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	move	$5,$4
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$17
$L900:
	la	$6,AudioClc_gCameraVelocity
	lui	$2,%hi(AudioClc_gPlayer) # high
	addiu	$17,$2,%lo(AudioClc_gPlayer) # low
	addiu	$10,$16,%lo(AudioClc_gRenderView)
	lw	$7,0($10)
	lw	$8,4($10)
	lw	$9,8($10)
	sw	$7,12($17)
	sw	$8,16($17)
	sw	$9,20($17)
	.set	noreorder
	.set	nomacro
	jal	Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	AudioClc_GetClosestCars__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundPlayersCar__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,gMasterAmbientLevel
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L895
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L895:
	addiu	$10,$16,%lo(AudioClc_gRenderView)
	lw	$7,0($10)
	lw	$8,4($10)
	lw	$9,8($10)
	sw	$7,92($17)
	sw	$8,96($17)
	sw	$9,100($17)
	j	$L898
$L893:
	move	$4,$0
	la	$6,AudioClc_gCameraVelocity
	.set	noreorder
	.set	nomacro
	jal	Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
	addiu	$5,$16,%lo(AudioClc_gRenderView) # low
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	AudioClc_GetClosestCars__Fiii
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundPlayersCar__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,gMasterAmbientLevel
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L897
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	move	$5,$4
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SoundCloseCar__Fii
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L897:
	lui	$2,%hi(AudioClc_gPlayer) # high
	addiu	$2,$2,%lo(AudioClc_gPlayer) # low
	addiu	$10,$16,%lo(AudioClc_gRenderView)
	lw	$7,0($10)
	lw	$8,4($10)
	lw	$9,8($10)
	sw	$7,12($2)
	sw	$8,16($2)
	sw	$9,20($2)
$L898:
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

	.end	AudioClc_SoundCars__Fv
