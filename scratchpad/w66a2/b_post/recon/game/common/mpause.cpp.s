	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\mpause.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	InGameSelectListAudioMode
	.sdata
	.align	2
InGameSelectListAudioMode:
	.half	18
	.half	17
	.half	19
	.half	0
	.globl	SelectListConfig
	.align	2
SelectListConfig:
	.half	23
	.half	24
	.half	25
	.half	0
	.text
	.align	2
	.globl	__14tPauseMenuDefs
	.align	2
	.globl	_._14tPauseMenuDefs
	.align	2
	.globl	MPause_MusicLogic__Fc
	.align	2
	.globl	MPause_ControllerLogic__Fv
	.align	2
	.globl	MPause_Logic__Fv
	.align	2
	.globl	MPause_Render__Fv
	.align	2
	.globl	MPause_InitMPause__Fv
	.align	2
	.globl	MPause_StartPauseMenu__Fv
	.align	2
	.globl	MPause_EndPauseMenu__Fv
	.align	2
	.globl	MPause_KillMPause__Fv
	.globl	gPauseMenuDefs
	.sdata
	.align	2
gPauseMenuDefs:
	.space	4
	.globl	gMPauseUpdate
	.align	2
gMPauseUpdate:
	.space	4
	.globl	gMPauseUpdateNextTime
	.align	2
gMPauseUpdateNextTime:
	.space	4

	.lcomm	gPauseCurrentMenu,4

	.lcomm	kMovingHighlight,2

	.lcomm	kMovingHighlightDir,2

	.lcomm	gBackDepth,4

	.lcomm	gBackList,24

	.lcomm	wasActive,1

	.lcomm	testSFX,1

	.lcomm	playingSFX,1

	.lcomm	vol,4

	.lcomm	SFXHandle,4

	.lcomm	lastplaytick,4

	.extern	Replay_ReplayMode, 4
	.extern	ticks, 4
	.extern	Audio_direct3davail, 4
	.extern	gStereoMode, 4
	.extern	Device_gPausePortIndex, 1
	.extern	gMasterAmbientLevel, 4
	.extern	gMasterEngineLevel, 4
	.extern	gMasterFENarrationLevel, 4
	.extern	gMasterSFXLevel, 4
	.extern	gMasterMusicLevel, 4
	.extern	GameSetup_gData, 2600
	.extern	ChangedEnabling, 4

	.text
	.text
	.ent	__14tPauseMenuDefs
__14tPauseMenuDefs:
	.frame	$sp,88,$31		# vars= 8, regs= 10/0, args= 40, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$16,48($sp)
	move	$16,$4
	move	$5,$0
	sw	$31,84($sp)
	sw	$fp,80($sp)
	sw	$23,76($sp)
	sw	$22,72($sp)
	sw	$21,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	sw	$17,52($sp)
	.set	macro
	.set	reorder

	addu	$21,$16,12
	move	$4,$21
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$20,$16,28
	move	$4,$20
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$19,$16,44
	move	$4,$19
	li	$5,3			# 0x00000003
	addu	$22,$16,232
	move	$6,$22
	.set	noreorder
	.set	nomacro
	jal	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
	move	$7,$0
	.set	macro
	.set	reorder

	addu	$18,$16,64
	move	$4,$18
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$17,$16,80
	move	$4,$17
	li	$5,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$4,$16,96
	move	$5,$16
	move	$6,$21
	move	$7,$20
	sw	$19,16($sp)
	sw	$18,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__6tPMenuP10tPMenuIteme
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	addu	$19,$16,180
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	addu	$18,$16,192
	move	$4,$18
	li	$5,7			# 0x00000007
	addu	$3,$16,456
	move	$6,$3
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
	sw	$3,40($sp)
	.set	macro
	.set	reorder

	addu	$17,$16,212
	move	$4,$17
	li	$5,8			# 0x00000008
	addu	$3,$16,632
	move	$6,$3
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
	sw	$3,44($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$19
	move	$6,$18
	move	$7,$17
	.set	noreorder
	.set	nomacro
	jal	__6tPMenuP10tPMenuIteme
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	addu	$fp,$16,316
	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	li	$5,10			# 0x0000000a
	.set	macro
	.set	reorder

	addu	$17,$16,328
	move	$4,$17
	la	$5,InGameSelectListAudioMode
	lui	$19,%hi(GameSetup_gData+236) # high
	addiu	$19,$19,%lo(GameSetup_gData+236) # low
	.set	noreorder
	.set	nomacro
	jal	__14tPListIteratorPsPi
	move	$6,$19
	.set	macro
	.set	reorder

	addu	$23,$16,340
	move	$4,$23
	li	$5,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightChoiceUiP14tPListIterator
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$22,$16,356
	move	$4,$22
	li	$5,12			# 0x0000000c
	la	$6,gMasterMusicLevel
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	li	$7,127			# 0x0000007f
	.set	macro
	.set	reorder

	addu	$21,$16,376
	move	$4,$21
	li	$5,13			# 0x0000000d
	la	$6,gMasterSFXLevel
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	li	$7,127			# 0x0000007f
	.set	macro
	.set	reorder

	addu	$20,$16,396
	move	$4,$20
	li	$5,14			# 0x0000000e
	la	$6,gMasterFENarrationLevel
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	li	$7,127			# 0x0000007f
	.set	macro
	.set	reorder

	addu	$18,$16,416
	move	$4,$18
	li	$5,15			# 0x0000000f
	la	$6,gMasterEngineLevel
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	li	$7,127			# 0x0000007f
	.set	macro
	.set	reorder

	addu	$17,$16,436
	move	$4,$17
	li	$5,16			# 0x00000010
	la	$6,gMasterAmbientLevel
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	li	$7,127			# 0x0000007f
	.set	macro
	.set	reorder

	move	$5,$fp
	move	$6,$23
	lw	$4,40($sp)
	move	$7,$22
	sw	$21,16($sp)
	sw	$20,20($sp)
	sw	$18,24($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__6tPMenuP10tPMenuIteme
	sw	$0,32($sp)
	.set	macro
	.set	reorder

	addu	$17,$16,540
	move	$4,$17
	la	$5,SelectListConfig
	la	$7,Device_gPausePortIndex
	.set	noreorder
	.set	nomacro
	jal	__21tPListIteratorIndexedPsPiPc
	addu	$6,$19,-140
	.set	macro
	.set	reorder

	addu	$22,$16,556
	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	li	$5,20			# 0x00000014
	.set	macro
	.set	reorder

	addu	$21,$16,568
	move	$4,$21
	li	$5,21			# 0x00000015
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightChoiceUiP14tPListIterator
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$20,$16,584
	move	$4,$20
	li	$5,27			# 0x0000001b
	addu	$6,$19,-68
	li	$7,127			# 0x0000007f
	la	$17,Device_gPausePortIndex
	.set	noreorder
	.set	nomacro
	jal	__32tPMenuItemLeftRightSliderIndexedUiPicPc
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	addu	$18,$16,608
	move	$4,$18
	li	$5,28			# 0x0000001c
	addu	$6,$19,-60
	li	$7,127			# 0x0000007f
	.set	noreorder
	.set	nomacro
	jal	__32tPMenuItemLeftRightSliderIndexedUiPicPc
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	move	$5,$22
	move	$6,$21
	lw	$4,44($sp)
	move	$7,$20
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__6tPMenuP10tPMenuIteme
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	addu	$20,$16,716
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$19,$16,728
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	__28tPMenuItemNonInteractiveTextUi
	li	$5,36			# 0x00000024
	.set	macro
	.set	reorder

	addu	$18,$16,740
	move	$4,$18
	li	$5,38			# 0x00000026
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	li	$6,7			# 0x00000007
	.set	macro
	.set	reorder

	addu	$17,$16,756
	move	$4,$17
	li	$5,37			# 0x00000025
	.set	noreorder
	.set	nomacro
	jal	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	li	$6,7			# 0x00000007
	.set	macro
	.set	reorder

	addu	$4,$16,772
	move	$5,$20
	move	$6,$19
	move	$7,$18
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__6tPMenuP10tPMenuIteme
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,84($sp)
	lw	$fp,80($sp)
	lw	$23,76($sp)
	lw	$22,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	__14tPauseMenuDefs
	.text
	.ent	_._14tPauseMenuDefs
_._14tPauseMenuDefs:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	addu	$4,$17,772
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	_._6tPMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,756
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,740
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,728
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,716
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,632
	.set	noreorder
	.set	nomacro
	jal	_._6tPMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,608
	.set	noreorder
	.set	nomacro
	jal	_._32tPMenuItemLeftRightSliderIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,584
	.set	noreorder
	.set	nomacro
	jal	_._32tPMenuItemLeftRightSliderIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,568
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,556
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,540
	.set	noreorder
	.set	nomacro
	jal	_._21tPListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,456
	.set	noreorder
	.set	nomacro
	jal	_._6tPMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,436
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,416
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,396
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,376
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,356
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,340
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,328
	.set	noreorder
	.set	nomacro
	jal	_._14tPListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,316
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,232
	.set	noreorder
	.set	nomacro
	jal	_._6tPMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,212
	.set	noreorder
	.set	nomacro
	jal	_._24tPMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,192
	.set	noreorder
	.set	nomacro
	jal	_._24tPMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,180
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,96
	.set	noreorder
	.set	nomacro
	jal	_._6tPMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,80
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,64
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,44
	.set	noreorder
	.set	nomacro
	jal	_._24tPMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,28
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12
	.set	noreorder
	.set	nomacro
	jal	_._23tPMenuItemCommandButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	_._28tPMenuItemNonInteractiveText
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	beq	$16,$0,$L614
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L614:
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

	.end	_._14tPauseMenuDefs
	.text
	.ent	MPause_MusicLogic__Fc
MPause_MusicLogic__Fc:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+236) # high
	lw	$3,%lo(GameSetup_gData+236)($2)
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	sw	$16,24($sp)
	li	$16,1			# 0x00000001
	sw	$17,28($sp)
	li	$17,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L618
	sw	$31,36($sp)
	.set	macro
	.set	reorder

	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L622
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L617
	andi	$2,$18,0x00ff
	.set	macro
	.set	reorder

	j	$L643
$L622:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L619
	andi	$2,$18,0x00ff
	.set	macro
	.set	reorder

	j	$L643
$L617:
	sw	$16,gStereoMode
	sw	$0,Audio_direct3davail
	j	$L643
$L618:
	sw	$0,gStereoMode
	sw	$0,Audio_direct3davail
	.set	noreorder
	.set	nomacro
	j	$L643
	andi	$2,$18,0x00ff
	.set	macro
	.set	reorder

$L619:
	sw	$16,gStereoMode
	sw	$16,Audio_direct3davail
$L643:
	beq	$2,$0,$L623
	lbu	$2,wasActive
	#nop
	bne	$2,$0,$L624
	lw	$4,gMasterMusicLevel
	jal	AudioCmn_MusicLevel__Fi
	li	$4,500			# 0x000001f4
	.set	noreorder
	.set	nomacro
	jal	AudioMus_AutoVolume__Fii
	move	$5,$2
	.set	macro
	.set	reorder

$L624:
	lw	$2,gPauseCurrentMenu
	#nop
	lw	$3,0($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L642
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	bne	$3,$2,$L626
$L642:
	li	$4,1			# 0x00000001
$L626:
	beq	$4,$0,$L628
	lw	$4,gMasterMusicLevel
	jal	AudioCmn_MusicLevel__Fi
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	move	$4,$2
	.set	macro
	.set	reorder

$L628:
	lw	$4,gPauseCurrentMenu
	#nop
	lw	$3,0($4)
	li	$2,3			# 0x00000003
	sb	$0,testSFX
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L629
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$17,16			# 0x00000010
	lw	$3,gMasterSFXLevel
	sb	$2,testSFX
	sw	$3,vol
$L629:
	lw	$3,0($4)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L644
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$17,16			# 0x00000010
	lw	$3,gMasterFENarrationLevel
	li	$2,1			# 0x00000001
	sb	$2,testSFX
	sw	$3,vol
	lw	$3,0($4)
	li	$2,5			# 0x00000005
$L644:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L631
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$17,16			# 0x00000010
	lw	$3,gMasterEngineLevel
	sb	$2,testSFX
	sw	$3,vol
$L631:
	lw	$3,0($4)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L632
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$17,16			# 0x00000010
	lw	$3,gMasterAmbientLevel
	sb	$2,testSFX
	sw	$3,vol
$L632:
	lbu	$2,testSFX
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,playingSFX
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,playingSFX
	j	$L635
$L634:
	lw	$4,SFXHandle
	jal	SNDover
	move	$16,$2
$L635:
	beq	$16,$0,$L639
	lw	$2,ticks
	lw	$3,lastplaytick
	#nop
	subu	$2,$2,$3
	slt	$2,$2,193
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	lui	$2,%hi(gSndBnk+36) # high
	.set	macro
	.set	reorder

	move	$5,$17
	lw	$4,%lo(gSndBnk+36)($2)
	li	$2,64			# 0x00000040
	#.set	volatile
	lw	$3,ticks
	#.set	novolatile
	lw	$7,vol
	sw	$2,16($sp)
	sw	$3,lastplaytick
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlaySound__Fiiiii
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,SFXHandle
	j	$L639
$L633:
	lbu	$3,playingSFX
	#nop
	bne	$3,$2,$L639
	lw	$4,SFXHandle
	jal	SNDstop
	sb	$0,playingSFX
	j	$L639
$L623:
	lbu	$2,wasActive
	#nop
	beq	$2,$0,$L639
	lw	$4,SFXHandle
	jal	SNDstop
	li	$4,500			# 0x000001f4
	.set	noreorder
	.set	nomacro
	jal	AudioMus_AutoVolume__Fii
	move	$5,$0
	.set	macro
	.set	reorder

$L639:
	lw	$31,36($sp)
	sb	$18,wasActive
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	MPause_MusicLogic__Fc
	.text
	.ent	MPause_ControllerLogic__Fv
MPause_ControllerLogic__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lbu	$4,Device_gPausePortIndex
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	sltu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	jal	PadGetState
	sll	$4,$4,4
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
	bne	$2,$3,$L646
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsEnabled__10tPMenuItem
	addu	$4,$16,584
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,584($16)
	sw	$3,ChangedEnabling
	or	$2,$2,$3
	sw	$2,584($16)
$L649:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsEnabled__10tPMenuItem
	addu	$4,$16,608
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,608($16)
	sw	$3,ChangedEnabling
	.set	noreorder
	.set	nomacro
	j	$L655
	or	$2,$2,$3
	.set	macro
	.set	reorder

$L646:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,584
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L652
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,584($16)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	sw	$2,584($16)
$L652:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,608
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,608($16)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
$L655:
	sw	$2,608($16)
$L654:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MPause_ControllerLogic__Fv
	.text
	.ent	MPause_Logic__Fv
MPause_Logic__Fv:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$4,gPauseCurrentMenu
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Debounce__6tPMenu
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	li	$4,5			# 0x00000005
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	li	$4,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L689
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	li	$4,24			# 0x00000018
	.set	noreorder
	.set	nomacro
	jal	Input_Interface__FUli
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

$L689:
	sw	$2,24($sp)
$L658:
	lh	$2,kMovingHighlight
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$2,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	lw	$3,gPauseCurrentMenu
	addu	$6,$sp,16
	sw	$2,gMPauseUpdate
	lw	$7,80($3)
	lw	$16,0($3)
	lh	$4,24($7)
	lw	$2,28($7)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$4,gPauseCurrentMenu
	sll	$16,$16,16
	lh	$17,0($4)
	sra	$5,$16,16
	beq	$5,$17,$L673
	jal	ItemEnabledNum__6tPMenui
	move	$5,$17
	sll	$16,$2,1
	addu	$16,$16,$2
	sll	$16,$16,2
	addu	$16,$16,$2
	lw	$4,gPauseCurrentMenu
	.set	noreorder
	.set	nomacro
	jal	ItemEnabledNum__6tPMenui
	addu	$16,$16,106
	.set	macro
	.set	reorder

	li	$5,1717960704			# 0x66660000
	ori	$5,$5,0x6667
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	addu	$3,$3,106
	subu	$4,$3,$16
	mult	$4,$5
	subu	$16,$16,$3
	sra	$4,$4,31
	sh	$16,kMovingHighlight
	mfhi	$8
	#nop
	#nop
	sra	$2,$8,2
	subu	$2,$2,$4
	sh	$2,kMovingHighlightDir
	j	$L673
$L671:
	lw	$2,ChangedEnabling
	#nop
	beq	$2,$0,$L675
$L670:
	li	$2,1			# 0x00000001
	sw	$2,gMPauseUpdate
	j	$L673
$L675:
	lw	$2,gMPauseUpdateNextTime
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L676
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,gMPauseUpdate
	sw	$0,gMPauseUpdateNextTime
	j	$L673
$L676:
	sw	$0,gMPauseUpdate
$L673:
	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	andi	$2,$2,0x0100
	.set	macro
	.set	reorder

	beq	$2,$0,$L679
	lw	$3,gPauseCurrentMenu
	#nop
	lw	$2,0($3)
	#nop
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,8($3)
	lw	$3,gPauseMenuDefs
	lw	$2,4($2)
	#nop
	sw	$2,720($3)
	lbu	$2,16($sp)
	sw	$0,772($3)
	sw	$2,768($3)
	li	$2,6			# 0x00000006
	addu	$3,$3,772
	sw	$2,16($sp)
	sw	$3,20($sp)
$L679:
	lw	$3,16($sp)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L681
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	beq	$3,$2,$L682
	j	$L685
$L681:
	lui	$3,%hi(gBackList) # high
	addiu	$3,$3,%lo(gBackList) # low
	lw	$5,gBackDepth
	lw	$4,gPauseCurrentMenu
	sll	$2,$5,2
	addu	$2,$2,$3
	sw	$4,0($2)
	lw	$4,20($sp)
	#nop
	lw	$3,80($4)
	.set	noreorder
	.set	nomacro
	j	$L690
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L682:
	lw	$5,gBackDepth
	#nop
	.set	noreorder
	.set	nomacro
	blez	$5,$L683
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	lui	$3,%hi(gBackList) # high
	addiu	$3,$3,%lo(gBackList) # low
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$4,0($2)
	#nop
	lw	$3,80($4)
$L690:
	sw	$5,gBackDepth
	sw	$4,gPauseCurrentMenu
	lh	$2,16($3)
	lw	$3,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	j	$L678
$L683:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L688
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L685:
	lw	$2,16($sp)
	j	$L688
$L678:
	lw	$2,gPauseMenuDefs
	lw	$4,gPauseCurrentMenu
	addu	$2,$2,456
	xor	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	MPause_MusicLogic__Fc
	sltu	$4,$4,1
	.set	macro
	.set	reorder

	jal	MPause_ControllerLogic__Fv
	move	$2,$0
$L688:
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

	.end	MPause_Logic__Fv
	.text
	.ent	MPause_Render__Fv
MPause_Render__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lh	$2,kMovingHighlight
	lhu	$3,kMovingHighlight
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$16,32($sp)
	sw	$0,ChangedEnabling
	blez	$2,$L692
	lhu	$2,kMovingHighlightDir
	#nop
	addu	$2,$3,$2
	sh	$2,kMovingHighlight
	sll	$2,$2,16
	bltz	$2,$L703
	j	$L694
$L692:
	bgez	$2,$L694
	lhu	$2,kMovingHighlightDir
	#nop
	addu	$2,$3,$2
	sh	$2,kMovingHighlight
	sll	$2,$2,16
	blez	$2,$L694
$L703:
	sh	$0,kMovingHighlight
$L694:
	lh	$2,kMovingHighlight
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,gPauseCurrentMenu
	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$0,4($2)
	.set	macro
	.set	reorder

$L697:
	lw	$3,gPauseCurrentMenu
	#nop
	sw	$2,4($3)
$L698:
	lw	$3,gPauseCurrentMenu
	#nop
	lw	$2,80($3)
	#nop
	lh	$4,32($2)
	lw	$2,36($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$4,gPauseCurrentMenu
	jal	NumEnabledItems__6tPMenu
	lw	$4,gPauseCurrentMenu
	move	$16,$2
	lw	$3,0($4)
	lh	$2,kMovingHighlight
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	move	$5,$3
	.set	macro
	.set	reorder

	jal	ItemEnabledNum__6tPMenui
	li	$4,1			# 0x00000001
	li	$5,80			# 0x00000050
	li	$7,160			# 0x000000a0
	li	$3,13			# 0x0000000d
	sll	$6,$2,$4
	addu	$6,$6,$2
	sll	$6,$6,2
	sw	$3,16($sp)
	lh	$3,kMovingHighlight
	addu	$6,$6,$2
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	addu	$3,$3,106
	.set	noreorder
	.set	nomacro
	j	$L704
	addu	$6,$6,$3
	.set	macro
	.set	reorder

$L700:
	jal	ItemEnabledNum__6tPMenui
	li	$4,1			# 0x00000001
	li	$5,80			# 0x00000050
	sll	$6,$2,$4
	addu	$6,$6,$2
	sll	$6,$6,2
	addu	$6,$6,$2
	addu	$6,$6,106
	li	$7,160			# 0x000000a0
	li	$2,13			# 0x0000000d
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
$L704:
	jal	Hud_FBuildF4__FiiiiiUlcc
	li	$4,80			# 0x00000050
	li	$5,100			# 0x00000064
	li	$6,160			# 0x000000a0
	addu	$2,$16,1
	sll	$7,$2,1
	addu	$7,$7,$2
	sll	$7,$7,2
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	Hud_RenderPauseBox__Fiiii
	addu	$7,$7,20
	.set	macro
	.set	reorder

	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	MPause_Render__Fv
	.text
	.ent	MPause_InitMPause__Fv
MPause_InitMPause__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+224) # high
	lw	$4,%lo(GameSetup_gData+224)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	TextSys_LoadInGame__Fi
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,856			# 0x00000358
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__14tPauseMenuDefs
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$2,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MPause_InitMPause__Fv
	.text
	.ent	MPause_StartPauseMenu__Fv
MPause_StartPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$4,gPauseMenuDefs
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	addu	$4,$4,96
	lw	$2,80($4)
	sw	$4,gPauseCurrentMenu
	lh	$3,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,6			# 0x00000006
	sw	$0,gBackDepth
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L708
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L708
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,28($16)
	li	$3,-2			# 0xfffffffe
	.set	noreorder
	.set	nomacro
	j	$L747
	and	$2,$2,$3
	.set	macro
	.set	reorder

$L708:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsEnabled__10tPMenuItem
	addu	$4,$16,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,28($16)
	sw	$3,ChangedEnabling
	or	$2,$2,$3
$L747:
	sw	$2,28($16)
$L711:
	lui	$2,%hi(GameSetup_gData) # high
	lw	$3,%lo(GameSetup_gData)($2)
	li	$2,6			# 0x00000006
	bne	$3,$2,$L714
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,80
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L715
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,80($16)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	sw	$2,80($16)
$L715:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsEnabled__10tPMenuItem
	addu	$4,$16,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,64($16)
	sw	$3,ChangedEnabling
	.set	noreorder
	.set	nomacro
	j	$L748
	or	$2,$2,$3
	.set	macro
	.set	reorder

$L714:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsEnabled__10tPMenuItem
	addu	$4,$16,80
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,80($16)
	sw	$3,ChangedEnabling
	or	$2,$2,$3
	sw	$2,80($16)
$L720:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,64($16)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
$L748:
	sw	$2,64($16)
$L719:
	lw	$16,gPauseMenuDefs
	.set	noreorder
	.set	nomacro
	jal	IsDisabled__10tPMenuItem
	addu	$4,$16,356
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,ChangedEnabling
	lw	$2,356($16)
	li	$3,-2			# 0xfffffffe
	and	$2,$2,$3
	sw	$2,356($16)
$L724:
	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L726
	li	$5,-257			# 0xfffffeff
	.set	macro
	.set	reorder

	lw	$3,gPauseMenuDefs
	#nop
	addu	$4,$3,64
	lw	$2,12($4)
	#nop
	and	$2,$2,$5
	sw	$2,12($4)
	addu	$4,$3,28
	lw	$2,12($4)
	addu	$3,$3,80
	and	$2,$2,$5
	sw	$2,12($4)
	lw	$2,12($3)
	.set	noreorder
	.set	nomacro
	j	$L749
	and	$2,$2,$5
	.set	macro
	.set	reorder

$L726:
	lw	$3,gPauseMenuDefs
	#nop
	addu	$4,$3,64
	lw	$2,12($4)
	#nop
	ori	$2,$2,0x0100
	sw	$2,12($4)
	addu	$4,$3,28
	lw	$2,12($4)
	addu	$3,$3,80
	ori	$2,$2,0x0100
	sw	$2,12($4)
	lw	$2,12($3)
	#nop
	ori	$2,$2,0x0100
$L749:
	sw	$2,12($3)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MPause_StartPauseMenu__Fv
	.text
	.ent	MPause_EndPauseMenu__Fv
MPause_EndPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData) # high
	lbu	$4,Device_gPausePortIndex
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sw	$31,16($sp)
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$5,96($3)
	jal	InGame_ResetPSXController__Fii
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MPause_EndPauseMenu__Fv
	.text
	.ent	MPause_KillMPause__Fv
MPause_KillMPause__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$4,gPauseMenuDefs
	#nop
	beq	$4,$0,$L753
	.set	noreorder
	.set	nomacro
	jal	_._14tPauseMenuDefs
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L753:
	jal	TextSys_UnloadWords__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MPause_KillMPause__Fv
