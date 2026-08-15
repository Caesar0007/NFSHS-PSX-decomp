	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\femenudefs.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	SelectListOffOn
	.data
	.align	2
SelectListOffOn:
	.half	103
	.half	102
	.half	0
	.globl	SelectListNormal
	.align	2
SelectListNormal:
	.half	227
	.half	225
	.half	0
	.globl	SelectListOpponentUpgrades
	.align	2
SelectListOpponentUpgrades:
	.half	271
	.half	272
	.half	0
	.globl	SelectListTrackDirection
	.align	2
SelectListTrackDirection:
	.half	228
	.half	229
	.half	0
	.globl	SelectListTransmission
	.align	2
SelectListTransmission:
	.half	276
	.half	275
	.half	0
	.globl	SelectListDisplaySpeed
	.align	2
SelectListDisplaySpeed:
	.half	500
	.half	498
	.half	499
	.half	103
	.half	0
	.globl	SelectListDisplayMap
	.align	2
SelectListDisplayMap:
	.half	103
	.half	488
	.half	489
	.half	0
	.globl	SelectListDisplayOpponentID
	.align	2
SelectListDisplayOpponentID:
	.half	103
	.half	501
	.half	502
	.half	0
	.globl	SelectListSplitTime
	.align	2
SelectListSplitTime:
	.half	103
	.half	490
	.half	491
	.half	0
	.globl	SelectListSplitDisplay
	.align	2
SelectListSplitDisplay:
	.half	492
	.half	493
	.half	0
	.globl	SelectListUpgrades
	.align	2
SelectListUpgrades:
	.half	150
	.half	151
	.half	152
	.half	0
	.globl	SelectListControllerConfig
	.align	2
SelectListControllerConfig:
	.half	539
	.half	540
	.half	541
	.half	0
	.globl	SelectListAudioMode
	.align	2
SelectListAudioMode:
	.half	466
	.half	467
	.half	468
	.half	0
	.globl	gCarActivation
	.align	2
gCarActivation:
	.word	25
	.word	25
	.word	25
	.word	25
	.word	25
	.word	24
	.word	24
	.word	24
	.word	24
	.word	24
	.word	26
	.word	26
	.word	26
	.word	27
	.word	26
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	28
	.word	28
	.word	28
	.word	28
	.word	28
	.text
	.align	2
	.globl	MenuExtended_SetOnePlayer__FR12tMenuCommand
	.ent	MenuExtended_SetOnePlayer__FR12tMenuCommand
MenuExtended_SetOnePlayer__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lbu	$3,557($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L601
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L600
	sw	$0,0($4)
	.set	macro
	.set	reorder

$L601:
	sb	$0,%lo(frontEnd+3)($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L600:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_SetOnePlayer__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetTwoPlayer__FR12tMenuCommand
	.ent	MenuExtended_SetTwoPlayer__FR12tMenuCommand
MenuExtended_SetTwoPlayer__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(gPadinfo+36) # high
	lbu	$2,%lo(gPadinfo+36)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L603
	sw	$0,0($4)
	.set	macro
	.set	reorder

$L604:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$3,3($2)
	sb	$0,798($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L603:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_SetTwoPlayer__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetTestDrive__FR12tMenuCommand
	.ent	MenuExtended_SetTestDrive__FR12tMenuCommand
MenuExtended_SetTestDrive__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	sb	$0,298($2)
	sb	$0,798($2)
	sb	$0,70($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,4($2)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetTestDrive__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetSingleRace__FR12tMenuCommand
	.ent	MenuExtended_SetSingleRace__FR12tMenuCommand
MenuExtended_SetSingleRace__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sb	$3,298($2)
	sb	$0,70($2)
	sb	$0,4($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
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

	.end	MenuExtended_SetSingleRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetTournament__FR12tMenuCommand
	.ent	MenuExtended_SetTournament__FR12tMenuCommand
MenuExtended_SetTournament__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sb	$3,298($2)
	li	$3,2			# 0x00000002
	sb	$0,70($2)
	sb	$0,290($2)
	sb	$3,4($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
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

	.end	MenuExtended_SetTournament__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetSpecialEvent__FR12tMenuCommand
	.ent	MenuExtended_SetSpecialEvent__FR12tMenuCommand
MenuExtended_SetSpecialEvent__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sb	$3,298($2)
	sb	$3,290($2)
	li	$3,2			# 0x00000002
	sb	$0,70($2)
	sb	$3,4($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
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

	.end	MenuExtended_SetSpecialEvent__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetSoloRace__FR12tMenuCommand
	.ent	MenuExtended_SetSoloRace__FR12tMenuCommand
MenuExtended_SetSoloRace__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$0,70($2)
	sb	$0,4($2)
	sb	$0,798($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$3,298($2)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetSoloRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand
	.ent	MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand
MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand:
	.frame	$sp,200,$31		# vars= 168, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	sw	$17,188($sp)
	move	$17,$4
	sw	$16,184($sp)
	addu	$16,$sp,16
	sw	$31,192($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(tDialogYesNoTri_vtable) # high
	addiu	$2,$2,%lo(tDialogYesNoTri_vtable) # low
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	sw	$2,96($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bgtz	$2,$L648
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,66			# 0x00000042
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,144($4)
	li	$2,801			# 0x00000321
	sw	$2,160($4)
	li	$2,802			# 0x00000322
	sw	$2,164($4)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($4)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$3,$2,16
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L650
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$16,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($16)
	lui	$2,%hi(frontEnd+4) # high
	sb	$0,%lo(frontEnd+4)($2)
	sw	$3,0($17)
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,7268
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,7268
	.set	macro
	.set	reorder

	li	$5,2			# 0x00000002
	lui	$3,%hi(screenCarSelect) # high
	lw	$2,%lo(menuDefs)($16)
	lw	$4,%lo(screenCarSelect)($3)
	addu	$2,$2,7496
 #APP
 #NO_APP
	.set	noreorder
	jal	SetState__16tScreenCarSelecti
	sw	$2,4($17)
	.set	reorder
	.set	noreorder
	.set	nomacro
	j	$L683
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_SetSoloRace__FR12tMenuCommand
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($17)
	addu	$2,$2,3360
	sw	$2,4($17)
$L650:
	addu	$4,$sp,16
$L683:
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetDuelRace__FR12tMenuCommand
	.ent	MenuExtended_SetDuelRace__FR12tMenuCommand
MenuExtended_SetDuelRace__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sb	$0,70($2)
	sb	$0,4($2)
	sb	$3,798($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
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

	.end	MenuExtended_SetDuelRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetFullGrid__FR12tMenuCommand
	.ent	MenuExtended_SetFullGrid__FR12tMenuCommand
MenuExtended_SetFullGrid__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,2			# 0x00000002
	sw	$31,16($sp)
	sb	$0,70($2)
	sb	$0,4($2)
	sb	$3,798($2)
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
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

	.end	MenuExtended_SetFullGrid__FR12tMenuCommand
	.align	2
	.globl	AskTheUserToSaveTheGame__Fv
	.ent	AskTheUserToSaveTheGame__Fv
AskTheUserToSaveTheGame__Fv:
	.frame	$sp,192,$31		# vars= 168, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,192
	sw	$31,188($sp)
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsTheUserACryBabyCheater__Fv
	sw	$16,184($sp)
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L718
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,817			# 0x00000331
	.set	macro
	.set	reorder

	addu	$16,$sp,16
	move	$4,$16
	sw	$2,144($16)
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($16)
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$16,$2,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$2,$16
$L718:
	lw	$31,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,192
	.set	macro
	.set	reorder

	.end	AskTheUserToSaveTheGame__Fv
	.align	2
	.globl	MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
	.ent	MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($4)
	addu	$2,$2,176
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

	.end	MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand
	.ent	MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand
MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AskTheUserToSaveTheGame__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L721
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($16)
	addu	$2,$2,15000
	.set	noreorder
	.set	nomacro
	j	$L720
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L721:
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
	move	$4,$16
	.set	macro
	.set	reorder

$L720:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToCarSelect__FR12tMenuCommand
	.ent	MenuExtended_GoToCarSelect__FR12tMenuCommand
MenuExtended_GoToCarSelect__FR12tMenuCommand:
	.frame	$sp,80,$31		# vars= 48, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$18,72($sp)
	move	$18,$4
	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	lui	$2,%hi(frontEnd) # high
	sw	$16,64($sp)
	addiu	$16,$2,%lo(frontEnd) # low
	lui	$3,%hi(FEApp) # high
	addu	$6,$sp,16
	sw	$31,76($sp)
	sw	$17,68($sp)
	lbu	$2,70($16)
	lw	$3,%lo(FEApp)($3)
	addu	$2,$2,$16
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$17,$3,44
	.set	macro
	.set	reorder

	lbu	$2,19($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L724
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,235			# 0x000000eb
	.set	macro
	.set	reorder

	sw	$2,144($17)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	move	$4,$17
	.set	macro
	.set	reorder

	j	$L723
$L724:
	lbu	$2,3($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L725
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$2,0($18)
	lbu	$3,4($16)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L726
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,298($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,5824
	.set	noreorder
	.set	nomacro
	j	$L730
	sw	$2,4($18)
	.set	macro
	.set	reorder

$L727:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,6280
	.set	noreorder
	.set	nomacro
	j	$L730
	sw	$2,4($18)
	.set	macro
	.set	reorder

$L726:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,6724
	.set	noreorder
	.set	nomacro
	j	$L730
	sw	$2,4($18)
	.set	macro
	.set	reorder

$L725:
	lbu	$2,798($16)
	#nop
	bne	$2,$3,$L731
	sw	$3,0($18)
	lbu	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L732
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L761
	addu	$2,$2,5576
	.set	macro
	.set	reorder

$L732:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,5452
$L761:
	sw	$2,4($18)
	lui	$2,%hi(screenCarSelectDuel) # high
	lw	$4,%lo(screenCarSelectDuel)($2)
	.set	noreorder
	.set	nomacro
	j	$L762
	li	$5,7			# 0x00000007
	.set	macro
	.set	reorder

$L731:
	sw	$3,0($18)
	lbu	$2,298($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L735
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$2,%hi(menuDefs) # high
	lui	$3,%hi(screenCarSelect) # high
	lw	$2,%lo(menuDefs)($2)
	lw	$4,%lo(screenCarSelect)($3)
	.set	noreorder
	.set	nomacro
	j	$L736
	addu	$2,$2,4688
	.set	macro
	.set	reorder

$L735:
	lui	$2,%hi(menuDefs) # high
	lui	$3,%hi(screenCarSelect) # high
	lw	$2,%lo(menuDefs)($2)
	lw	$4,%lo(screenCarSelect)($3)
	addu	$2,$2,4968
$L736:
	sw	$2,4($18)
$L762:
	jal	SetState__16tScreenCarSelecti
$L730:
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,4($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L738
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L742
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L743
	addiu	$3,$2,%lo(frontEnd) # low
	.set	macro
	.set	reorder

$L738:
	lbu	$2,798($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L764
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,3($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L739
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

$L764:
	lw	$3,%lo(menuDefs)($2)
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$2,4476($3)
	.set	macro
	.set	reorder

$L739:
	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$3,4476($2)
	.set	macro
	.set	reorder

$L742:
	lui	$2,%hi(menuDefs) # high
	lw	$3,%lo(menuDefs)($2)
	li	$2,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$2,6628($3)
	.set	macro
	.set	reorder

$L743:
	lbu	$2,298($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$2,4476($3)
	.set	macro
	.set	reorder

$L744:
	lbu	$2,4($3)
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L746
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	li	$2,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	j	$L737
	sw	$2,4828($3)
	.set	macro
	.set	reorder

$L746:
	lw	$2,%lo(menuDefs)($2)
	#nop
	sw	$3,4828($2)
$L737:
	lui	$2,%hi(frontEnd) # high
	addiu	$17,$2,%lo(frontEnd) # low
	lbu	$2,298($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L749
	lui	$16,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,4460
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,4460
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,4460
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L763
	addu	$4,$4,4460
	.set	macro
	.set	reorder

$L749:
	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L765
	lui	$16,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$3,4($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L766
	lui	$2,%hi(frontEnd+798) # high
	.set	macro
	.set	reorder

	lbu	$2,798($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L767
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

$L765:
	lw	$4,%lo(menuDefs)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,4812
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,4812
	.set	macro
	.set	reorder

	lbu	$3,3($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L750
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,4812
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,1			# 0x00000001
	addu	$4,$4,4812
$L763:
	jal	Increment__16tListIteratorCar7tPlayer
$L750:
	lui	$2,%hi(frontEnd+798) # high
$L766:
	lbu	$3,%lo(frontEnd+798)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L723
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

$L767:
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L723
	lui	$16,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,5216
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,5216
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($16)
	li	$2,1			# 0x00000001
	sw	$2,5232($3)
$L723:
	lw	$31,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToCarSelect__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToDealer__FR12tMenuCommand
	.ent	MenuExtended_GoToDealer__FR12tMenuCommand
MenuExtended_GoToDealer__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	li	$5,2			# 0x00000002
	lui	$2,%hi(screenCarSelect) # high
	sw	$16,16($sp)
 #APP
 #NO_APP
	lui	$16,%hi(menuDefs) # high
	lw	$4,%lo(screenCarSelect)($2)
	lw	$2,%lo(menuDefs)($16)
	li	$3,1			# 0x00000001
	sw	$31,20($sp)
	sw	$3,0($6)
	addu	$2,$2,7496
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	sw	$2,4($6)
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,7268
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,7268
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

	.end	MenuExtended_GoToDealer__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToSeller__FR12tMenuCommand
	.ent	MenuExtended_GoToSeller__FR12tMenuCommand
MenuExtended_GoToSeller__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	li	$5,3			# 0x00000003
	lui	$2,%hi(screenCarSelect) # high
	sw	$16,16($sp)
 #APP
 #NO_APP
	lui	$16,%hi(menuDefs) # high
	lw	$4,%lo(screenCarSelect)($2)
	lw	$2,%lo(menuDefs)($16)
	li	$3,1			# 0x00000001
	sw	$31,20($sp)
	sw	$3,0($6)
	addu	$2,$2,7732
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	sw	$2,4($6)
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	addu	$4,$4,7620
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,7620
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

	.end	MenuExtended_GoToSeller__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToUpgrades__FR12tMenuCommand
	.ent	MenuExtended_GoToUpgrades__FR12tMenuCommand
MenuExtended_GoToUpgrades__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sw	$3,0($4)
	addu	$2,$2,7988
	sw	$2,4($4)
	lui	$2,%hi(screenCarSelect) # high
	lw	$4,%lo(screenCarSelect)($2)
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	li	$5,4			# 0x00000004
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

	.end	MenuExtended_GoToUpgrades__FR12tMenuCommand
	.align	2
	.globl	GenericMenuSaveGame__Fi
	.ent	GenericMenuSaveGame__Fi
GenericMenuSaveGame__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	lui	$17,%hi(FEApp) # high
	lui	$2,%hi(screenMemcard) # high
	lw	$4,%lo(FEApp)($17)
	lw	$3,%lo(screenMemcard)($2)
	li	$2,638			# 0x0000027e
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	sw	$2,1412($3)
	.set	macro
	.set	reorder

	lui	$2,%hi(MEMCARD_INITIALIZED) # high
	lw	$2,%lo(MEMCARD_INITIALIZED)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L776
	move	$18,$0
	.set	macro
	.set	reorder

	beq	$16,$0,$L775
$L776:
	lw	$16,%lo(FEApp)($17)
	li	$4,642			# 0x00000282
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,720
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($17)
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L779:
	lw	$4,%lo(FEApp)($17)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L778
	jal	Redraw__14tFEApplication
	j	$L779
$L778:
	jal	Redraw__14tFEApplication
	lui	$2,%hi(MEMCARD_INITIALIZED) # high
	lw	$2,%lo(MEMCARD_INITIALIZED)($2)
	#nop
	bne	$2,$0,$L775
	li	$18,1			# 0x00000001
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	move	$5,$0
	.set	macro
	.set	reorder

$L775:
	.set	noreorder
	.set	nomacro
	jal	SaveGame__Fs
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(screenMemcard) # high
	lw	$4,%lo(screenMemcard)($3)
	li	$3,-1			# 0xffffffff
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L783
	sw	$3,1412($4)
	.set	macro
	.set	reorder

	jal	DeInit_Memcard__Fv
$L783:
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	move	$2,$16
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

	.end	GenericMenuSaveGame__Fi
	.align	2
	.globl	PinkSlipsPreSave__Fv
	.ent	PinkSlipsPreSave__Fv
PinkSlipsPreSave__Fv:
	.frame	$sp,200,$31		# vars= 168, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	sw	$31,192($sp)
	sw	$17,188($sp)
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsTheUserACryBabyCheater__Fv
	sw	$16,184($sp)
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$16,$sp,16
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,627			# 0x00000273
	lui	$2,%hi(tDialogYesNoTri_vtable) # high
	addiu	$2,$2,%lo(tDialogYesNoTri_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,96($16)
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,144($16)
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$3,$2,16
	beq	$3,$17,$L788
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L856
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L855
	move	$2,$0
	.set	macro
	.set	reorder

$L788:
	.set	noreorder
	.set	nomacro
	jal	GenericMenuSaveGame__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$17,$2
	addu	$4,$sp,16
$L856:
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L855
	move	$2,$17
	.set	macro
	.set	reorder

$L785:
	li	$2,1			# 0x00000001
$L855:
	lw	$31,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	PinkSlipsPreSave__Fv
	.align	2
	.globl	MenuExtended_GoToBestOfOne__FR12tMenuCommand
	.ent	MenuExtended_GoToBestOfOne__FR12tMenuCommand
MenuExtended_GoToBestOfOne__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PinkSlipsPreSave__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($16)
	addu	$2,$2,3360
	.set	noreorder
	.set	nomacro
	j	$L859
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L858:
	sw	$0,0($16)
$L859:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$0,70($2)
	sb	$3,71($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToBestOfOne__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToBestOfThree__FR12tMenuCommand
	.ent	MenuExtended_GoToBestOfThree__FR12tMenuCommand
MenuExtended_GoToBestOfThree__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PinkSlipsPreSave__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L861
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($16)
	addu	$2,$2,2960
	.set	noreorder
	.set	nomacro
	j	$L862
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L861:
	sw	$0,0($16)
$L862:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,3			# 0x00000003
	sb	$0,70($2)
	sb	$3,71($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToBestOfThree__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToBestOfFive__FR12tMenuCommand
	.ent	MenuExtended_GoToBestOfFive__FR12tMenuCommand
MenuExtended_GoToBestOfFive__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PinkSlipsPreSave__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L864
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($16)
	addu	$2,$2,3084
	.set	noreorder
	.set	nomacro
	j	$L865
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L864:
	sw	$0,0($16)
$L865:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,5			# 0x00000005
	sb	$0,70($2)
	sb	$3,71($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToBestOfFive__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToRace__FR12tMenuCommand
	.ent	MenuExtended_GoToRace__FR12tMenuCommand
MenuExtended_GoToRace__FR12tMenuCommand:
	.frame	$sp,248,$31		# vars= 208, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$19,236($sp)
	move	$19,$4
	lui	$2,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($2)
	li	$2,5			# 0x00000005
	sw	$31,240($sp)
	sw	$18,232($sp)
	sw	$17,228($sp)
	sw	$16,224($sp)
	sw	$2,0($19)
	lui	$2,%hi(frontEnd) # high
	addiu	$18,$2,%lo(frontEnd) # low
	li	$2,1			# 0x00000001
	lbu	$16,298($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L867
	addu	$17,$3,44
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L873
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

	lbu	$3,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$16,$L867
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L872
	li	$4,170			# 0x000000aa
	.set	macro
	.set	reorder

$L867:
	lui	$2,%hi(frontEnd+4) # high
$L873:
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L874
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumTourneyCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L868
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L872
	li	$4,241			# 0x000000f1
	.set	macro
	.set	reorder

$L868:
$L874:
	addiu	$5,$2,%lo(frontEnd) # low
	lbu	$3,4($5)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L875
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lbu	$5,92($5)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,207($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L869
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L872
	li	$4,242			# 0x000000f2
	.set	macro
	.set	reorder

$L869:
$L875:
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,298($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L866
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	lbu	$5,92($3)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,23($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L866
	li	$4,243			# 0x000000f3
	.set	macro
	.set	reorder

$L872:
	jal	TextSys_Word__Fi
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

	sw	$0,0($19)
$L866:
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

	.end	MenuExtended_GoToRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoTo2PlayerRace__FR12tMenuCommand
	.ent	MenuExtended_GoTo2PlayerRace__FR12tMenuCommand
MenuExtended_GoTo2PlayerRace__FR12tMenuCommand:
	.frame	$sp,248,$31		# vars= 208, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$19,236($sp)
	move	$19,$4
	lui	$3,%hi(FEApp) # high
	lui	$2,%hi(frontEnd) # high
	sw	$17,228($sp)
	addiu	$17,$2,%lo(frontEnd) # low
	lw	$2,%lo(FEApp)($3)
	li	$4,6			# 0x00000006
	sw	$31,240($sp)
	sw	$18,232($sp)
	sw	$16,224($sp)
	sw	$4,0($19)
	lbu	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L876
	addu	$18,$2,44
	.set	macro
	.set	reorder

	lbu	$16,298($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L883
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L883
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lbu	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L882
	li	$4,170			# 0x000000aa
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
$L883:
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,298($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L884
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	lui	$4,%hi(carManager) # high
	lbu	$2,556($2)
	addiu	$4,$4,%lo(carManager) # low
	addu	$2,$2,$3
	lbu	$5,92($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,23($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L879
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L882
	li	$4,243			# 0x000000f3
	.set	macro
	.set	reorder

$L879:
$L884:
	addiu	$5,$2,%lo(frontEnd) # low
	lbu	$3,4($5)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L876
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(FEApp)($2)
	lui	$4,%hi(carManager) # high
	lbu	$2,556($2)
	addiu	$4,$4,%lo(carManager) # low
	addu	$2,$2,$5
	lbu	$5,92($2)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,207($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L876
	li	$4,242			# 0x000000f2
	.set	macro
	.set	reorder

$L882:
	jal	TextSys_Word__Fi
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

	sw	$0,0($19)
$L876:
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

	.end	MenuExtended_GoTo2PlayerRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToTournTrackInfo__FR12tMenuCommand
	.ent	MenuExtended_GoToTournTrackInfo__FR12tMenuCommand
MenuExtended_GoToTournTrackInfo__FR12tMenuCommand:
	.frame	$sp,208,$31		# vars= 168, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$19,196($sp)
	move	$19,$4
	lui	$4,%hi(frontEnd) # high
	lui	$2,%hi(tournamentManager) # high
	sw	$17,188($sp)
	addiu	$17,$2,%lo(tournamentManager) # low
	addiu	$4,$4,%lo(frontEnd) # low
	sw	$31,200($sp)
	sw	$18,192($sp)
	sw	$16,184($sp)
 #APP
 #NO_APP
	lw	$5,24($17)
	lbu	$2,288($4)
	sb	$0,290($4)
	lbu	$3,2($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$5,$5,$2
	lw	$3,48($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L886
	move	$18,$5
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$2,20($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L887
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$16,%lo(FEApp)($2)
	li	$4,246			# 0x000000f6
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,44
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

	j	$L885
$L887:
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,247			# 0x000000f7
	.set	macro
	.set	reorder

	addu	$16,$sp,16
	move	$4,$16
	sw	$2,144($16)
	li	$2,802			# 0x00000322
	sw	$2,160($16)
	li	$2,801			# 0x00000321
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L888
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	j	$L885
$L888:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$3,48($18)
	lw	$2,20($17)
	li	$5,2			# 0x00000002
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$2,20($17)
	.set	macro
	.set	reorder

$L886:
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lui	$2,%hi(frontEnd+288) # high
	lbu	$6,%lo(frontEnd+288)($2)
	.set	noreorder
	.set	nomacro
	jal	StartNewTournament__18tTournamentManagerUcUc
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($19)
	addu	$2,$2,4336
	sw	$2,4($19)
$L885:
	lw	$31,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToTournTrackInfo__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand
	.ent	MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand
MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand:
	.frame	$sp,208,$31		# vars= 168, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$19,196($sp)
	move	$19,$4
	lui	$4,%hi(frontEnd) # high
	addiu	$4,$4,%lo(frontEnd) # low
	lui	$2,%hi(tournamentManager) # high
	sw	$17,188($sp)
	addiu	$17,$2,%lo(tournamentManager) # low
	sw	$31,200($sp)
	sw	$18,192($sp)
	sw	$16,184($sp)
 #APP
 #NO_APP
	lw	$5,24($17)
	li	$2,1			# 0x00000001
	sb	$2,290($4)
	lbu	$2,289($4)
	lbu	$3,14($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$5,$5,$2
	lw	$3,48($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L950
	move	$18,$5
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$2,20($17)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L951
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$16,%lo(FEApp)($2)
	li	$4,246			# 0x000000f6
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,44
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

	j	$L949
$L951:
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,247			# 0x000000f7
	.set	macro
	.set	reorder

	addu	$16,$sp,16
	move	$4,$16
	sw	$2,144($16)
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L952
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	j	$L949
$L952:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$3,48($18)
	lw	$2,20($17)
	li	$5,2			# 0x00000002
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$2,20($17)
	.set	macro
	.set	reorder

$L950:
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lui	$2,%hi(frontEnd+289) # high
	lbu	$6,%lo(frontEnd+289)($2)
	.set	noreorder
	.set	nomacro
	jal	StartNewTournament__18tTournamentManagerUcUc
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$3,0($19)
	addu	$2,$2,4336
	sw	$2,4($19)
$L949:
	lw	$31,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_EnterUserName__FR12tMenuCommand
	.ent	MenuExtended_EnterUserName__FR12tMenuCommand
MenuExtended_EnterUserName__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(FEApp) # high
	lui	$2,%hi(menuDefs) # high
	lw	$6,%lo(menuDefs)($2)
	lw	$2,%lo(FEApp)($3)
	addu	$5,$6,12588
	#.set	volatile
	lbu	$7,557($2)
	#.set	novolatile
	lbu	$3,557($2)
	li	$2,7			# 0x00000007
	sh	$2,32($5)
	lui	$2,%hi(frontEnd+868) # high
	addiu	$2,$2,%lo(frontEnd+868) # low
	sll	$3,$3,3
	addu	$3,$3,$2
	lui	$2,%hi(screenUserName) # high
	lw	$2,%lo(screenUserName)($2)
	addu	$6,$6,13008
	sh	$0,36($5)
	sh	$0,34($5)
	sh	$7,128($5)
	sw	$3,28($5)
	sw	$6,100($2)
	li	$2,1			# 0x00000001
	sw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,4($4)
	.set	macro
	.set	reorder

	.end	MenuExtended_EnterUserName__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToShowroom__FR12tMenuCommand
	.ent	MenuExtended_GoToShowroom__FR12tMenuCommand
MenuExtended_GoToShowroom__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sw	$3,0($4)
	addu	$2,$2,9068
	sw	$2,4($4)
	lui	$2,%hi(screenCarSelect) # high
	lw	$4,%lo(screenCarSelect)($2)
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	li	$5,5			# 0x00000005
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

	.end	MenuExtended_GoToShowroom__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToDealerShowroom__FR12tMenuCommand
	.ent	MenuExtended_GoToDealerShowroom__FR12tMenuCommand
MenuExtended_GoToDealerShowroom__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,1			# 0x00000001
	sw	$31,16($sp)
	sw	$3,0($4)
	addu	$2,$2,9068
	sw	$2,4($4)
	lui	$2,%hi(screenCarSelect) # high
	lw	$4,%lo(screenCarSelect)($2)
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	li	$5,6			# 0x00000006
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

	.end	MenuExtended_GoToDealerShowroom__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetHPSoloRace__FR12tMenuCommand
	.ent	MenuExtended_SetHPSoloRace__FR12tMenuCommand
MenuExtended_SetHPSoloRace__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$0,70($2)
	sb	$3,4($2)
	sb	$0,798($2)
	lui	$2,%hi(menuDefs) # high
	lw	$3,%lo(menuDefs)($2)
	li	$2,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4476($3)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetHPSoloRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetHPDuelRace__FR12tMenuCommand
	.ent	MenuExtended_SetHPDuelRace__FR12tMenuCommand
MenuExtended_SetHPDuelRace__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$0,70($2)
	sb	$3,4($2)
	sb	$3,798($2)
	lui	$2,%hi(menuDefs) # high
	lw	$3,%lo(menuDefs)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4476($3)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetHPDuelRace__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetHotPursuit__FR12tMenuCommand
	.ent	MenuExtended_SetHotPursuit__FR12tMenuCommand
MenuExtended_SetHotPursuit__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	li	$3,1			# 0x00000001
	sb	$0,298($2)
	sb	$0,70($2)
	sb	$3,4($2)
	lbu	$2,3($2)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L1019
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(menuDefs)($2)
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	j	$L1020
	sw	$2,4476($3)
	.set	macro
	.set	reorder

$L1019:
	lw	$2,%lo(menuDefs)($2)
	#nop
	sw	$3,4476($2)
$L1020:
	lui	$2,%hi(frontEnd+798) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,%lo(frontEnd+798)($2)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetHotPursuit__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SellCar__FR12tMenuCommand
	.ent	MenuExtended_SellCar__FR12tMenuCommand
MenuExtended_SellCar__FR12tMenuCommand:
	.frame	$sp,200,$31		# vars= 168, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	lui	$2,%hi(carManager) # high
	sw	$17,188($sp)
	addiu	$17,$2,%lo(carManager) # low
	lui	$2,%hi(frontEnd+291) # high
	lbu	$5,%lo(frontEnd+291)($2)
	lui	$2,%hi(tournamentManager+20) # high
	sw	$16,184($sp)
	lw	$16,%lo(tournamentManager+20)($2)
	move	$4,$17
	sw	$18,192($sp)
	sw	$31,196($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcUsedPrice__11tCarManagers
	move	$18,$0
	move	$4,$17
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	beq	$2,$0,$L1023
	.set	noreorder
	.set	nomacro
	jal	CheapestCarStockPrice__11tCarManager
	move	$4,$17
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	bne	$2,$0,$L1022
$L1023:
	li	$18,1			# 0x00000001
$L1022:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L1024
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,165			# 0x000000a5
	.set	macro
	.set	reorder

	addu	$17,$sp,16
	move	$4,$17
	sw	$2,144($17)
	li	$2,801			# 0x00000321
	sw	$2,160($17)
	li	$2,802			# 0x00000322
	sw	$2,164($17)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,136($17)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1025
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	lui	$2,%hi(frontEnd+297) # high
	lbu	$5,%lo(frontEnd+297)($2)
	.set	noreorder
	.set	nomacro
	jal	SellCar__11tCarManagerss
	move	$6,$0
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$6,%hi(tournamentManager) # high
	addiu	$6,$6,%lo(tournamentManager) # low
	lui	$16,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($16)
	lw	$3,20($6)
	addu	$4,$4,7620
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	sw	$3,20($6)
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,7620
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,26			# 0x0000001a
	.set	macro
	.set	reorder

$L1025:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	j	$L1021
$L1024:
	lw	$16,%lo(FEApp)($2)
	li	$4,169			# 0x000000a9
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,44
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

$L1021:
	lw	$31,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	MenuExtended_SellCar__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_BuyCar__FR12tMenuCommand
	.ent	MenuExtended_BuyCar__FR12tMenuCommand
MenuExtended_BuyCar__FR12tMenuCommand:
	.frame	$sp,416,$31		# vars= 376, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,416
	lui	$2,%hi(carManager) # high
	sw	$18,400($sp)
	addiu	$18,$2,%lo(carManager) # low
	move	$4,$18
	lui	$3,%hi(FEApp) # high
	lui	$2,%hi(frontEnd) # high
	sw	$19,404($sp)
	addiu	$19,$2,%lo(frontEnd) # low
	lw	$2,%lo(FEApp)($3)
	addu	$6,$sp,16
	sw	$31,408($sp)
	sw	$17,396($sp)
	sw	$16,392($sp)
	lbu	$5,296($19)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$16,$2,44
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1058
	move	$17,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager) # high
	addiu	$17,$2,%lo(tournamentManager) # low
	lw	$2,20($17)
	lw	$3,48($sp)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L1059
	addu	$16,$sp,224
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,164			# 0x000000a4
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,368($sp)
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,360($sp)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1060
	move	$4,$18
	.set	macro
	.set	reorder

	lb	$5,16($sp)
	#nop
	addu	$2,$5,$19
	lbu	$6,96($2)
	.set	noreorder
	.set	nomacro
	jal	PurchaseCar__11tCarManagersss
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$3,20($17)
	li	$4,26			# 0x0000001a
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$3,20($17)
	.set	macro
	.set	reorder

$L1060:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	j	$L1057
$L1059:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,167			# 0x000000a7
	.set	macro
	.set	reorder

	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	j	$L1091
	move	$4,$16
	.set	macro
	.set	reorder

$L1058:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,75			# 0x0000004b
	.set	macro
	.set	reorder

	sw	$2,144($17)
	move	$4,$17
$L1091:
	jal	Display__11tDialogBase
$L1057:
	lw	$31,408($sp)
	lw	$19,404($sp)
	lw	$18,400($sp)
	lw	$17,396($sp)
	lw	$16,392($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,416
	.set	macro
	.set	reorder

	.end	MenuExtended_BuyCar__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_PurchaseUpgrade__Fi
	.ent	MenuExtended_PurchaseUpgrade__Fi
MenuExtended_PurchaseUpgrade__Fi:
	.frame	$sp,416,$31		# vars= 376, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,416
	sw	$16,392($sp)
	move	$16,$4
	lui	$2,%hi(carManager) # high
	sw	$20,408($sp)
	addiu	$20,$2,%lo(carManager) # low
	move	$4,$20
	addu	$6,$sp,16
	move	$7,$0
	lui	$2,%hi(frontEnd) # high
	sw	$19,404($sp)
	addiu	$19,$2,%lo(frontEnd) # low
	li	$2,1			# 0x00000001
	sw	$31,412($sp)
	sw	$18,400($sp)
	sw	$17,396($sp)
	lbu	$5,291($19)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	sll	$18,$2,$16
	.set	macro
	.set	reorder

	lbu	$2,212($sp)
	#nop
	and	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1092
	addu	$2,$16,1
	.set	macro
	.set	reorder

	sll	$2,$2,2
	addu	$3,$sp,$2
	lui	$2,%hi(tournamentManager) # high
	addiu	$17,$2,%lo(tournamentManager) # low
	lw	$2,20($17)
	lw	$3,48($3)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1094
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	addu	$16,$sp,224
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,166			# 0x000000a6
	.set	macro
	.set	reorder

	move	$4,$16
	sw	$2,368($sp)
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sh	$0,360($sp)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1095
	move	$4,$20
	.set	macro
	.set	reorder

	sll	$6,$18,16
	sra	$6,$6,16
	lbu	$5,291($19)
	.set	noreorder
	.set	nomacro
	jal	PurchaseUpgrade__11tCarManagersss
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$3,20($17)
	li	$4,26			# 0x0000001a
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$3,20($17)
	.set	macro
	.set	reorder

$L1095:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	j	$L1092
$L1094:
	lw	$16,%lo(FEApp)($2)
	li	$4,168			# 0x000000a8
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$16,$16,44
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

$L1092:
	lw	$31,412($sp)
	lw	$20,408($sp)
	lw	$19,404($sp)
	lw	$18,400($sp)
	lw	$17,396($sp)
	lw	$16,392($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,416
	.set	macro
	.set	reorder

	.end	MenuExtended_PurchaseUpgrade__Fi
	.align	2
	.globl	MenuExtended_PurchaseUpgrade1__FR12tMenuCommand
	.ent	MenuExtended_PurchaseUpgrade1__FR12tMenuCommand
MenuExtended_PurchaseUpgrade1__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_PurchaseUpgrade__Fi
	li	$4,1			# 0x00000001
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

	.end	MenuExtended_PurchaseUpgrade1__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_PurchaseUpgrade2__FR12tMenuCommand
	.ent	MenuExtended_PurchaseUpgrade2__FR12tMenuCommand
MenuExtended_PurchaseUpgrade2__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_PurchaseUpgrade__Fi
	li	$4,2			# 0x00000002
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

	.end	MenuExtended_PurchaseUpgrade2__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_PurchaseUpgrade3__FR12tMenuCommand
	.ent	MenuExtended_PurchaseUpgrade3__FR12tMenuCommand
MenuExtended_PurchaseUpgrade3__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_PurchaseUpgrade__Fi
	move	$4,$0
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

	.end	MenuExtended_PurchaseUpgrade3__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SaveGame__FR12tMenuCommand
	.ent	MenuExtended_SaveGame__FR12tMenuCommand
MenuExtended_SaveGame__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1130
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	lw	$2,12372($2)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L1130
	.set	noreorder
	.set	nomacro
	jal	GenericMenuSaveGame__Fi
	move	$4,$0
	.set	macro
	.set	reorder

$L1130:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_SaveGame__FR12tMenuCommand
	.align	2
	.globl	GenericMenuLoadGame__Fi
	.ent	GenericMenuLoadGame__Fi
GenericMenuLoadGame__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(CURRENTLYUSINGMEMCARD) # high
	lw	$2,%lo(CURRENTLYUSINGMEMCARD)($2)
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1133
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(FEApp) # high
 #APP
 #NO_APP
	lui	$17,%hi(screenMemcard) # high
	#.set	volatile
	lw	$4,%lo(FEApp)($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,%lo(screenMemcard)($17)
	#.set	novolatile
	li	$2,637			# 0x0000027d
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	sw	$2,1412($3)
	.set	macro
	.set	reorder

	sll	$4,$18,16
	sra	$4,$4,16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	LoadGame__FsbT1
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	#.set	volatile
	lw	$4,%lo(FEApp)($16)
	#.set	novolatile
	#.set	volatile
	lw	$3,%lo(screenMemcard)($17)
	#.set	novolatile
	addu	$4,$4,720
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	sw	$2,1412($3)
	.set	macro
	.set	reorder

$L1133:
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
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

	.end	GenericMenuLoadGame__Fi
	.align	2
	.globl	MenuExtended_LoadGame__FR12tMenuCommand
	.ent	MenuExtended_LoadGame__FR12tMenuCommand
MenuExtended_LoadGame__FR12tMenuCommand:
	.frame	$sp,200,$31		# vars= 176, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	subu	$sp,$sp,200
	sw	$31,196($sp)
	sw	$16,192($sp)
	lw	$2,12416($2)
	#nop
	andi	$2,$2,0x0001
	bne	$2,$0,$L1134
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$4,704			# 0x000002c0
	addu	$16,$sp,16
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$0,136($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sw	$2,144($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1136
	lui	$2,%hi(screenMemcard) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(screenMemcard)($2)
	#nop
	lh	$4,1436($2)
	jal	GenericMenuLoadGame__Fi
$L1136:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L1134:
	lw	$31,196($sp)
	lw	$16,192($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	MenuExtended_LoadGame__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_TierFinished__FR12tMenuCommand
	.ent	MenuExtended_TierFinished__FR12tMenuCommand
MenuExtended_TierFinished__FR12tMenuCommand:
	.frame	$sp,96,$31		# vars= 72, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$16,88($sp)
	move	$16,$4
	li	$2,2			# 0x00000002
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	addu	$5,$sp,16
	sw	$31,92($sp)
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	sw	$2,0($16)
	.set	macro
	.set	reorder

	lw	$2,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1168
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L1169
	addu	$2,$2,14708
	.set	macro
	.set	reorder

$L1168:
	jal	AskTheUserToSaveTheGame__Fv
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1170
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L1169
	addu	$2,$2,15000
	.set	macro
	.set	reorder

$L1170:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,176
$L1169:
	sw	$2,4($16)
	lw	$31,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	MenuExtended_TierFinished__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_DidUserWinBeTheCop__Fv
	.ent	MenuExtended_DidUserWinBeTheCop__Fv
MenuExtended_DidUserWinBeTheCop__Fv:
	.frame	$sp,248,$31		# vars= 208, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$19,236($sp)
	move	$19,$0
	lui	$2,%hi(carManager) # high
	sw	$18,232($sp)
	addiu	$18,$2,%lo(carManager) # low
	move	$4,$18
	lui	$2,%hi(frontEnd) # high
	sw	$17,228($sp)
	addiu	$17,$2,%lo(frontEnd) # low
	sw	$31,240($sp)
	sw	$16,224($sp)
	lbu	$5,92($17)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$3,18($sp)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1178
	move	$2,$19
	.set	macro
	.set	reorder

	lbu	$3,4($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1178
	move	$2,$19
	.set	macro
	.set	reorder

	lbu	$2,3($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L1173
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(GameSetup_gData) # low
	lw	$3,440($2)
	lw	$2,428($2)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1173
	lui	$5,%hi(gCarActivation) # high
	.set	macro
	.set	reorder

	lb	$3,16($sp)
	addiu	$5,$5,%lo(gCarActivation) # low
	addu	$4,$3,$17
	addu	$3,$3,-22
	sll	$2,$3,2
	lb	$4,192($4)
	addu	$2,$2,$3
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$5
	lh	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$4,$18
	.set	macro
	.set	reorder

	move	$16,$2
	lbu	$2,7($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1178
	move	$2,$19
	.set	macro
	.set	reorder

	move	$4,$18
	lb	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	SetCarAvailable__11tCarManager10tCarModelsb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lb	$3,16($sp)
	lbu	$2,0($16)
	addu	$3,$3,$17
	sb	$2,301($17)
	lbu	$2,192($3)
	li	$19,1			# 0x00000001
	sb	$2,302($17)
$L1173:
	move	$2,$19
$L1178:
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

	.end	MenuExtended_DidUserWinBeTheCop__Fv
	.align	2
	.globl	MenuExtended_PostGameMenu__FR12tMenuCommand
	.ent	MenuExtended_PostGameMenu__FR12tMenuCommand
MenuExtended_PostGameMenu__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	StatChk_ClearNewRecords__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
	lui	$2,%hi(frontEnd+4) # high
	sw	$3,0($16)
	lbu	$4,%lo(frontEnd+4)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L1181
	slt	$2,$4,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1188
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1184
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	j	$L1191
$L1188:
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1183
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	j	$L1191
$L1181:
	lui	$4,%hi(tournamentManager) # high
	.set	noreorder
	.set	nomacro
	jal	IsTournamentFinished__18tTournamentManager
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1182
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,13784
	sw	$2,4($16)
	lui	$2,%hi(screenTournamentStandings) # high
	lw	$3,%lo(screenTournamentStandings)($2)
	.set	noreorder
	.set	nomacro
	j	$L1192
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1182:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,13616
	sw	$2,4($16)
	lui	$2,%hi(screenTournamentStandings3item) # high
	lw	$3,%lo(screenTournamentStandings3item)($2)
	li	$2,1			# 0x00000001
$L1192:
	.set	noreorder
	.set	nomacro
	j	$L1179
	sw	$2,132($3)
	.set	macro
	.set	reorder

$L1183:
	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L1180
	addu	$2,$2,13404
	.set	macro
	.set	reorder

$L1184:
	jal	MenuExtended_DidUserWinBeTheCop__Fv
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1186
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L1180
	addu	$2,$2,14584
	.set	macro
	.set	reorder

$L1186:
$L1191:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,176
$L1180:
	sw	$2,4($16)
$L1179:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_PostGameMenu__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand
	.ent	MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand
MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	lui	$2,%hi(FEApp) # high
	lw	$3,%lo(FEApp)($2)
	li	$2,2			# 0x00000002
	sw	$31,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sw	$2,0($18)
	lw	$2,884($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1199
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	.set	macro
	.set	reorder

	lw	$2,876($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1194
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	li	$2,1			# 0x00000001
	addu	$3,$4,12868
	sh	$2,128($3)
	lui	$2,%hi(frontEnd+900) # high
	addiu	$2,$2,%lo(frontEnd+900) # low
	sw	$2,28($3)
	li	$2,7			# 0x00000007
	sh	$2,32($3)
	lui	$2,%hi(screenUserName) # high
	lw	$2,%lo(screenUserName)($2)
	addu	$4,$4,14160
	sh	$0,36($3)
	sh	$0,34($3)
	sw	$4,100($2)
	.set	noreorder
	.set	nomacro
	j	$L1193
	sw	$4,4($18)
	.set	macro
	.set	reorder

$L1194:
$L1199:
	addiu	$17,$2,%lo(Cars_gNewCarStatsList) # low
	move	$4,$17
	lui	$16,%hi(Cars_gNumRaceCars) # high
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsRecordLapTime__FP10Car_tStatssPs
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L1196
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	lh	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	StatChk_SaveRecordLapTime__FP10Car_tStatsss
	move	$4,$17
	.set	macro
	.set	reorder

$L1196:
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsTopTime__FP10Car_tStatss
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1200
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lh	$5,%lo(Cars_gNumRaceCars)($16)
	.set	noreorder
	.set	nomacro
	jal	StatChk_SaveTopTime__FP10Car_tStatss
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
$L1200:
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$2,$2,14332
	sw	$2,4($18)
$L1193:
	lw	$31,36($sp)
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

	.end	MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand
	.ent	MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand
MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$4
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	sw	$17,28($sp)
	addiu	$17,$2,%lo(Cars_gNewCarStatsList) # low
	move	$4,$17
	sw	$16,24($sp)
	lui	$16,%hi(Cars_gNumRaceCars) # high
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsRecordLapTime__FP10Car_tStatssPs
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L1202
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	lh	$6,16($sp)
	.set	noreorder
	.set	nomacro
	jal	StatChk_SaveRecordLapTime__FP10Car_tStatsss
	move	$4,$17
	.set	macro
	.set	reorder

$L1202:
	lh	$5,%lo(Cars_gNumRaceCars)($16)
	.set	noreorder
	.set	nomacro
	jal	StatChk_IsTopTime__FP10Car_tStatss
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1205
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lh	$5,%lo(Cars_gNumRaceCars)($16)
	.set	noreorder
	.set	nomacro
	jal	StatChk_SaveTopTime__FP10Car_tStatss
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
$L1205:
	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($18)
	addu	$2,$2,14332
	sw	$2,4($18)
	lw	$31,36($sp)
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

	.end	MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetPinkSlips__FR12tMenuCommand
	.ent	MenuExtended_SetPinkSlips__FR12tMenuCommand
MenuExtended_SetPinkSlips__FR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(screenMain) # high
	lw	$4,%lo(screenMain)($2)
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SwapBackground__11tScreenMaini
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$3,$0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	move	$4,$2
	li	$2,6			# 0x00000006
	sb	$2,4($4)
	li	$2,1			# 0x00000001
	sb	$2,3($4)
	li	$2,-1			# 0xffffffff
	sb	$0,798($4)
	sh	$2,90($4)
	sb	$0,70($4)
	sll	$2,$3,16
$L1216:
	sra	$2,$2,16
	addu	$2,$2,$4
	sb	$0,72($2)
	addu	$2,$3,1
	move	$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1216
	sll	$2,$3,16
	.set	macro
	.set	reorder

	move	$3,$0
	lui	$2,%hi(frontEnd) # high
	addiu	$5,$2,%lo(frontEnd) # low
	li	$4,-1			# 0xffffffff
$L1211:
	sll	$2,$3,16
	sra	$2,$2,15
	addu	$2,$2,$5
	sh	$4,12($2)
	addu	$2,$3,1
	move	$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,5
	bne	$2,$0,$L1211
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	MenuExtended_SetPinkSlips__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand
	.ent	MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand
MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand:
	.frame	$sp,504,$31		# vars= 456, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,504
	sw	$21,492($sp)
	move	$21,$4
	sw	$16,472($sp)
	addu	$16,$sp,96
	move	$4,$16
	sw	$31,496($sp)
	sw	$20,488($sp)
	sw	$19,484($sp)
	sw	$18,480($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	sw	$17,476($sp)
	.set	macro
	.set	reorder

	li	$2,657			# 0x00000291
	sw	$2,160($16)
	li	$2,658			# 0x00000292
	sw	$2,164($16)
	lui	$2,%hi(screenPinkSlipCongrats) # high
	lw	$3,%lo(screenPinkSlipCongrats)($2)
	li	$2,1			# 0x00000001
	sh	$2,136($16)
	lh	$19,388($3)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,666			# 0x0000029a
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$16
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$7,$19,1
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	move	$20,$2
	lw	$4,%lo(FEApp)($2)
	addu	$2,$sp,16
	addu	$4,$4,720
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,144($4)
	.set	macro
	.set	reorder

$L1220:
	lw	$4,%lo(FEApp)($20)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L1219
	jal	Redraw__14tFEApplication
	j	$L1220
$L1219:
	.set	noreorder
	.set	nomacro
	jal	Redraw__14tFEApplication
	lui	$18,%hi(carManager) # high
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	addiu	$18,$18,%lo(carManager) # low
	move	$4,$18
	addu	$6,$sp,264
	lui	$17,%hi(frontEnd) # high
	addiu	$17,$17,%lo(frontEnd) # low
	li	$7,1			# 0x00000001
	subu	$7,$7,$19
	addu	$2,$7,$17
	sll	$7,$7,16
	lbu	$5,293($2)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	sra	$7,$7,16
	move	$4,$18
	.set	macro
	.set	reorder

	move	$16,$19
	lb	$5,264($sp)
	lbu	$6,461($sp)
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	AddToPinkSlipsList__11tCarManagersss
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$17,$16,$17
	lbu	$5,293($17)
	lbu	$6,460($sp)
	.set	noreorder
	.set	nomacro
	jal	AddUpgradesToPinkSlipsList__11tCarManagersss
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCarsWithErrorDialogs__Fsss
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($20)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	li	$4,628			# 0x00000274
	li	$2,2			# 0x00000002
	sw	$2,0($21)
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	lw	$16,%lo(FEApp)($20)
	addu	$2,$2,176
	addu	$16,$16,720
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,4($21)
	.set	macro
	.set	reorder

	lw	$4,%lo(FEApp)($20)
	lui	$17,%hi(FEApp) # high
	sw	$2,144($16)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

$L1225:
	lw	$4,%lo(FEApp)($17)
	#nop
	lw	$2,852($4)
	#nop
	xori	$2,$2,0x0001
	beq	$2,$0,$L1224
	jal	Redraw__14tFEApplication
	j	$L1225
$L1224:
	jal	Redraw__14tFEApplication
	.set	noreorder
	.set	nomacro
	jal	GenericMenuLoadGame__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	jal	DeInit_Memcard__Fv
	lw	$4,%lo(FEApp)($17)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	addu	$4,$sp,96
	li	$5,2			# 0x00000002
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	move	$3,$5
	sw	$3,0($21)
	addu	$2,$2,176
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$2,4($21)
	.set	macro
	.set	reorder

	lw	$31,496($sp)
	lw	$21,492($sp)
	lw	$20,488($sp)
	lw	$19,484($sp)
	lw	$18,480($sp)
	lw	$17,476($sp)
	lw	$16,472($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,504
	.set	macro
	.set	reorder

	.end	MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToGarage__FR12tMenuCommand
	.ent	MenuExtended_GoToGarage__FR12tMenuCommand
MenuExtended_GoToGarage__FR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	li	$5,-1			# 0xffffffff
	lui	$3,%hi(frontEnd+298) # high
	sw	$16,16($sp)
	lui	$16,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($16)
	li	$2,1			# 0x00000001
	sb	$2,%lo(frontEnd+298)($3)
	li	$2,64			# 0x00000040
	sw	$31,24($sp)
	addu	$4,$4,4812
	.set	noreorder
	.set	nomacro
	jal	Decrement__16tListIteratorCar7tPlayer
	sw	$2,16($4)
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($16)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	Increment__16tListIteratorCar7tPlayer
	addu	$4,$4,4812
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,0($17)
	lui	$2,%hi(tournamentManager+12) # high
	lw	$2,%lo(tournamentManager+12)($2)
	#nop
	bne	$2,$0,$L1260
	lw	$2,%lo(menuDefs)($16)
	.set	noreorder
	.set	nomacro
	j	$L1261
	addu	$2,$2,4968
	.set	macro
	.set	reorder

$L1260:
	lw	$2,%lo(menuDefs)($16)
	#nop
	addu	$2,$2,5092
$L1261:
	sw	$2,4($17)
	lui	$2,%hi(screenCarSelect) # high
	lw	$4,%lo(screenCarSelect)($2)
	.set	noreorder
	.set	nomacro
	jal	SetState__16tScreenCarSelecti
	li	$5,1			# 0x00000001
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

	.end	MenuExtended_GoToGarage__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand
	.ent	MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand
MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+290) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,%lo(frontEnd+290)($2)
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_GoToSETrophyRoom__FR12tMenuCommand
	.ent	MenuExtended_GoToSETrophyRoom__FR12tMenuCommand
MenuExtended_GoToSETrophyRoom__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(frontEnd+290) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,%lo(frontEnd+290)($3)
	.set	macro
	.set	reorder

	.end	MenuExtended_GoToSETrophyRoom__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetBeginner__FR12tMenuCommand
	.ent	MenuExtended_SetBeginner__FR12tMenuCommand
MenuExtended_SetBeginner__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+6) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,%lo(frontEnd+6)($2)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetBeginner__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetIntermediate__FR12tMenuCommand
	.ent	MenuExtended_SetIntermediate__FR12tMenuCommand
MenuExtended_SetIntermediate__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(frontEnd+6) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,%lo(frontEnd+6)($3)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetIntermediate__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_SetExpert__FR12tMenuCommand
	.ent	MenuExtended_SetExpert__FR12tMenuCommand
MenuExtended_SetExpert__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(frontEnd+6) # high
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,%lo(frontEnd+6)($3)
	.set	macro
	.set	reorder

	.end	MenuExtended_SetExpert__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_ExitTourney__FR12tMenuCommand
	.ent	MenuExtended_ExitTourney__FR12tMenuCommand
MenuExtended_ExitTourney__FR12tMenuCommand:
	.frame	$sp,200,$31		# vars= 168, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	sw	$17,188($sp)
	move	$17,$4
	addu	$4,$sp,16
	sw	$31,192($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	sw	$16,184($sp)
	.set	macro
	.set	reorder

	li	$4,157			# 0x0000009d
	addu	$16,$sp,16
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$0,136($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sw	$2,144($4)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1274
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($17)
	addu	$2,$2,176
	.set	noreorder
	.set	nomacro
	j	$L1275
	sw	$2,4($17)
	.set	macro
	.set	reorder

$L1274:
	sw	$0,0($17)
$L1275:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	MenuExtended_ExitTourney__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand
	.ent	MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand
MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand:
	.frame	$sp,288,$31		# vars= 248, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,288
	sw	$19,276($sp)
	move	$19,$4
	addu	$4,$sp,16
	sw	$31,280($sp)
	sw	$18,272($sp)
	sw	$17,268($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tDialogYesNo
	sw	$16,264($sp)
	.set	macro
	.set	reorder

	li	$4,157			# 0x0000009d
	addu	$16,$sp,16
	li	$2,801			# 0x00000321
	sw	$2,160($16)
	li	$2,802			# 0x00000322
	sw	$2,164($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sh	$0,136($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Run__18tDialogInteractive
	sw	$2,144($4)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1308
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$17,$0
	addu	$18,$sp,184
	slt	$2,$17,2
$L1342:
	beq	$2,$0,$L1310
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,663			# 0x00000297
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$16
	move	$6,$2
	addu	$16,$17,1
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$16
	.set	macro
	.set	reorder

	sll	$4,$17,16
	sra	$4,$4,16
	li	$5,1			# 0x00000001
	li	$6,-1			# 0xffffffff
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	move	$17,$16
	.set	noreorder
	.set	nomacro
	jal	SavePinkSlipsCarsWithErrorDialogs__Fsss
	sw	$18,864($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1342
	slt	$2,$17,2
	.set	macro
	.set	reorder

$L1310:
	jal	DeInit_Memcard__Fv
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	addu	$4,$4,720
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($19)
	addu	$2,$2,176
	sw	$2,4($19)
	lui	$2,%hi(frontEnd+4) # high
	sb	$0,%lo(frontEnd+4)($2)
$L1308:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$31,280($sp)
	lw	$19,276($sp)
	lw	$18,272($sp)
	lw	$17,268($sp)
	lw	$16,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,288
	.set	macro
	.set	reorder

	.end	MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand
	.align	2
	.globl	MenuExtended_PinkSlipsContinue__FR12tMenuCommand
	.ent	MenuExtended_PinkSlipsContinue__FR12tMenuCommand
MenuExtended_PinkSlipsContinue__FR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$6,$2,%lo(frontEnd) # low
	lbu	$2,71($6)
	lbu	$3,72($6)
	srl	$2,$2,1
	addu	$5,$2,1
	slt	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1348
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lbu	$2,73($6)
	#nop
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1346
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

$L1348:
	lw	$2,%lo(menuDefs)($2)
	li	$3,2			# 0x00000002
	sw	$3,0($4)
	addu	$2,$2,14460
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

$L1346:
	lbu	$2,70($6)
	#nop
	addu	$2,$2,1
	sb	$2,70($6)
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder

	.end	MenuExtended_PinkSlipsContinue__FR12tMenuCommand
	.align	2
	.globl	__15tGlobalMenuDefs
	.ent	__15tGlobalMenuDefs
__15tGlobalMenuDefs:
	.frame	$sp,640,$31		# vars= 528, regs= 10/0, args= 72, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,640
	li	$5,91			# 0x0000005b
	sw	$4,640($sp)
	addu	$8,$4,1112
	move	$6,$8
	lui	$7,%hi(MenuExtended_SetOnePlayer__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetOnePlayer__FR12tMenuCommand) # low
	li	$2,30			# 0x0000001e
	li	$9,10			# 0x0000000a
	sw	$31,636($sp)
	sw	$fp,632($sp)
	sw	$23,628($sp)
	sw	$22,624($sp)
	sw	$21,620($sp)
	sw	$20,616($sp)
	sw	$19,612($sp)
	sw	$18,608($sp)
	sw	$17,604($sp)
	sw	$16,600($sp)
	sw	$8,128($sp)
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,92			# 0x0000005c
	lui	$7,%hi(MenuExtended_SetTwoPlayer__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetTwoPlayer__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$9,640($sp)
	li	$2,40			# 0x00000028
	sw	$2,16($sp)
	addu	$8,$8,44
	move	$4,$8
	addu	$9,$9,2336
	move	$6,$9
	sw	$8,132($sp)
	li	$8,10			# 0x0000000a
	sw	$9,136($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,94			# 0x0000005e
	move	$7,$0
	lw	$9,640($sp)
	lw	$8,640($sp)
	li	$18,50			# 0x00000032
	sw	$18,16($sp)
	addu	$9,$9,88
	move	$4,$9
	addu	$8,$8,388
	move	$6,$8
	sw	$9,140($sp)
	li	$9,10			# 0x0000000a
	sw	$8,144($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,93			# 0x0000005d
	move	$7,$0
	li	$2,60			# 0x0000003c
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,132
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	addu	$6,$8,9456
	.set	macro
	.set	reorder

	li	$5,4116			# 0x00001014
	lui	$9,%hi(screenMain) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenMain)($9)
	lw	$9,140($sp)
	addu	$4,$8,176
	sw	$8,28($sp)
	lw	$8,132($sp)
	li	$2,180			# 0x000000b4
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$16,36($sp)
	sw	$0,44($sp)
	sw	$9,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,32($sp)
	.set	macro
	.set	reorder

	li	$5,99			# 0x00000063
	lui	$7,%hi(MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand) # high
	lw	$8,640($sp)
	lw	$9,640($sp)
	addiu	$7,$7,%lo(MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand) # low
	sw	$18,16($sp)
	addu	$8,$8,300
	move	$4,$8
	addu	$16,$9,13192
	move	$6,$16
	sw	$8,148($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,105			# 0x00000069
	move	$6,$16
	lui	$7,%hi(MenuExtended_GoToSETrophyRoom__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToSETrophyRoom__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$18,16($sp)
	sw	$8,20($sp)
	addu	$9,$9,344
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,152($sp)
	.set	macro
	.set	reorder

	li	$5,4116			# 0x00001014
	lui	$9,%hi(screenMain) # high
	move	$7,$0
	lw	$4,144($sp)
	lw	$6,%lo(screenMain)($9)
	lw	$8,148($sp)
	lw	$9,152($sp)
	li	$2,95			# 0x0000005f
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$0,36($sp)
	sw	$8,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	li	$5,16384			# 0x00004000
	lui	$2,%hi(screenTrophyInfo) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenTrophyInfo)($2)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,512
	.set	macro
	.set	reorder

	li	$5,161			# 0x000000a1
	lui	$7,%hi(MenuExtended_SetBeginner__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetBeginner__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$9,640($sp)
	li	$2,140			# 0x0000008c
	sw	$2,16($sp)
	addu	$8,$8,636
	move	$4,$8
	addu	$9,$9,3360
	move	$6,$9
	sw	$8,156($sp)
	li	$8,10			# 0x0000000a
	sw	$9,160($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,162			# 0x000000a2
	lui	$7,%hi(MenuExtended_SetIntermediate__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetIntermediate__FR12tMenuCommand) # low
	li	$2,150			# 0x00000096
	lw	$9,640($sp)
	lw	$6,160($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$18,$9,680
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,163			# 0x000000a3
	lui	$7,%hi(MenuExtended_SetExpert__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetExpert__FR12tMenuCommand) # low
	li	$2,160			# 0x000000a0
	lw	$9,640($sp)
	lw	$6,160($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$16,$9,724
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$8,%hi(screenMain) # high
	move	$7,$0
	lw	$9,640($sp)
	lw	$6,%lo(screenMain)($8)
	li	$2,183			# 0x000000b7
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$18,32($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	addu	$fp,$9,768
	lw	$9,156($sp)
	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	li	$5,96			# 0x00000060
	la	$7,MenuExtended_SetTestDrive__FR12tMenuCommand
	lw	$8,640($sp)
	lw	$9,640($sp)
	addu	$8,$8,892
	move	$4,$8
	addu	$9,$9,3484
	move	$6,$9
	sw	$8,164($sp)
	li	$8,240			# 0x000000f0
	sw	$9,168($sp)
	li	$9,10			# 0x0000000a
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,114			# 0x00000072
	lui	$7,%hi(MenuExtended_SetSingleRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetSingleRace__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$9,640($sp)
	addu	$8,$8,936
	move	$4,$8
	addu	$9,$9,1368
	move	$6,$9
	sw	$8,172($sp)
	li	$8,70			# 0x00000046
	sw	$9,176($sp)
	li	$9,10			# 0x0000000a
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,113			# 0x00000071
	la	$7,MenuExtended_SetHotPursuit__FR12tMenuCommand
	lw	$8,640($sp)
	lw	$9,640($sp)
	addu	$8,$8,980
	move	$4,$8
	addu	$9,$9,1580
	move	$6,$9
	sw	$8,180($sp)
	li	$8,80			# 0x00000050
	sw	$9,184($sp)
	li	$9,10			# 0x0000000a
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,99			# 0x00000063
	lui	$7,%hi(MenuExtended_SetTournament__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetTournament__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$2,90			# 0x0000005a
	sw	$2,16($sp)
	addu	$18,$8,1024
	move	$4,$18
	addu	$9,$8,1808
	move	$6,$9
	li	$8,10			# 0x0000000a
	sw	$9,188($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,105			# 0x00000069
	lui	$7,%hi(MenuExtended_SetSpecialEvent__FR12tMenuCommand) # high
	lw	$9,640($sp)
	addiu	$7,$7,%lo(MenuExtended_SetSpecialEvent__FR12tMenuCommand) # low
	addu	$16,$9,1068
	move	$4,$16
	addu	$8,$9,2036
	move	$6,$8
	li	$9,100			# 0x00000064
	sw	$8,192($sp)
	li	$8,10			# 0x0000000a
	sw	$9,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(screenMain) # high
	lw	$4,128($sp)
	lw	$6,%lo(screenMain)($9)
	lw	$9,164($sp)
	li	$8,181			# 0x000000b5
	sw	$8,24($sp)
	lw	$8,172($sp)
	li	$5,4100			# 0x00001004
	sw	$9,28($sp)
	lw	$9,180($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$18,40($sp)
	sw	$16,44($sp)
	sw	$0,48($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,36($sp)
	.set	macro
	.set	reorder

	li	$5,108			# 0x0000006c
	lui	$7,%hi(MenuExtended_SetSoloRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetSoloRace__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$6,160($sp)
	li	$9,110			# 0x0000006e
	sw	$9,16($sp)
	addu	$8,$8,1236
	move	$4,$8
	sw	$8,196($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,109			# 0x0000006d
	move	$6,$fp
	lui	$7,%hi(MenuExtended_SetDuelRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetDuelRace__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,120			# 0x00000078
	sw	$8,16($sp)
	addu	$18,$9,1280
	move	$4,$18
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,111			# 0x0000006f
	move	$6,$fp
	lui	$7,%hi(MenuExtended_SetFullGrid__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetFullGrid__FR12tMenuCommand) # low
	li	$2,130			# 0x00000082
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,1324
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$8,%hi(screenMain) # high
	move	$7,$0
	lw	$4,176($sp)
	lw	$6,%lo(screenMain)($8)
	lw	$8,196($sp)
	li	$9,182			# 0x000000b6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	sw	$18,32($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	li	$5,108			# 0x0000006c
	move	$6,$fp
	lui	$7,%hi(MenuExtended_SetHPSoloRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetHPSoloRace__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,110			# 0x0000006e
	sw	$8,16($sp)
	addu	$18,$9,1492
	move	$4,$18
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,109			# 0x0000006d
	move	$6,$fp
	lui	$7,%hi(MenuExtended_SetHPDuelRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetHPDuelRace__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,120			# 0x00000078
	sw	$9,16($sp)
	addu	$16,$8,1536
	move	$4,$16
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$9,%hi(screenMain) # high
	move	$7,$0
	lw	$4,184($sp)
	lw	$6,%lo(screenMain)($9)
	li	$8,182			# 0x000000b6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$8,24($sp)
	sw	$18,28($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	lui	$18,%hi(tournamentManager) # high
	addiu	$18,$18,%lo(tournamentManager) # low
	move	$6,$18
	lw	$9,640($sp)
	lw	$5,184($sp)
	addu	$9,$9,1704
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__23tListIteratorTournamentPcP18tTournamentManager
	sw	$9,200($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	lui	$16,%hi(MenuExtended_GoToTournTrackInfo__FR12tMenuCommand) # high
	addiu	$16,$16,%lo(MenuExtended_GoToTournTrackInfo__FR12tMenuCommand) # low
	move	$7,$16
	lw	$8,640($sp)
	li	$9,34			# 0x00000022
	sw	$9,16($sp)
	addu	$8,$8,1724
	move	$4,$8
	sw	$8,204($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,148			# 0x00000094
	li	$7,44			# 0x0000002c
	lw	$9,640($sp)
	lw	$6,200($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,1768
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,208($sp)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	lui	$9,%hi(screenTournSelect) # high
	move	$7,$0
	lw	$4,188($sp)
	lw	$6,%lo(screenTournSelect)($9)
	lw	$8,204($sp)
	lw	$9,208($sp)
	li	$2,101			# 0x00000065
	sw	$0,16($sp)
	sw	$16,20($sp)
	sw	$2,24($sp)
	sw	$0,36($sp)
	sw	$8,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	move	$6,$18
	lw	$8,640($sp)
	lw	$5,188($sp)
	addu	$8,$8,1932
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__23tListIteratorTournamentPcP18tTournamentManager
	sw	$8,212($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	lui	$16,%hi(MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand) # high
	addiu	$16,$16,%lo(MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand) # low
	move	$7,$16
	lw	$9,640($sp)
	li	$8,34			# 0x00000022
	sw	$8,16($sp)
	addu	$9,$9,1952
	move	$4,$9
	sw	$9,216($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,105			# 0x00000069
	li	$7,54			# 0x00000036
	lw	$8,640($sp)
	lw	$6,212($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$18,$8,1996
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	lui	$8,%hi(screenTournSelect) # high
	move	$7,$0
	lw	$4,192($sp)
	lw	$6,%lo(screenTournSelect)($8)
	lw	$8,216($sp)
	li	$9,100			# 0x00000064
	sw	$0,16($sp)
	sw	$16,20($sp)
	sw	$9,24($sp)
	sw	$18,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	li	$5,96			# 0x00000060
	la	$7,MenuExtended_SetTestDrive__FR12tMenuCommand
	lw	$9,640($sp)
	lw	$6,168($sp)
	li	$8,240			# 0x000000f0
	sw	$8,16($sp)
	addu	$9,$9,2160
	move	$4,$9
	sw	$9,220($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,114			# 0x00000072
	move	$6,$0
	lui	$7,%hi(MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,70			# 0x00000046
	sw	$9,16($sp)
	addu	$8,$8,2204
	move	$4,$8
	sw	$8,224($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,113			# 0x00000071
	move	$6,$fp
	la	$7,MenuExtended_SetHotPursuit__FR12tMenuCommand
	lw	$9,640($sp)
	li	$8,80			# 0x00000050
	sw	$8,16($sp)
	addu	$9,$9,2248
	move	$4,$9
	sw	$9,228($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,106			# 0x0000006a
	lui	$7,%hi(MenuExtended_SetPinkSlips__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SetPinkSlips__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$16,170			# 0x000000aa
	sw	$16,16($sp)
	addu	$18,$8,2292
	move	$4,$18
	addu	$9,$8,2592
	move	$6,$9
	li	$8,10			# 0x0000000a
	sw	$9,232($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(screenMain) # high
	lw	$4,136($sp)
	lw	$6,%lo(screenMain)($9)
	lw	$9,220($sp)
	li	$8,181			# 0x000000b5
	sw	$8,24($sp)
	lw	$8,224($sp)
	li	$5,4100			# 0x00001004
	sw	$9,28($sp)
	lw	$9,228($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$18,40($sp)
	sw	$0,44($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,36($sp)
	.set	macro
	.set	reorder

	li	$5,192			# 0x000000c0
	lui	$7,%hi(MenuExtended_GoToBestOfOne__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToBestOfOne__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$6,160($sp)
	li	$9,10			# 0x0000000a
	sw	$16,16($sp)
	sw	$9,20($sp)
	addu	$8,$8,2460
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,236($sp)
	.set	macro
	.set	reorder

	li	$5,193			# 0x000000c1
	lui	$7,%hi(MenuExtended_GoToBestOfThree__FR12tMenuCommand) # high
	lw	$8,640($sp)
	lw	$9,640($sp)
	addiu	$7,$7,%lo(MenuExtended_GoToBestOfThree__FR12tMenuCommand) # low
	sw	$16,16($sp)
	addu	$8,$8,2504
	move	$4,$8
	addu	$9,$9,2960
	move	$6,$9
	sw	$8,240($sp)
	li	$8,10			# 0x0000000a
	sw	$9,244($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,194			# 0x000000c2
	lui	$7,%hi(MenuExtended_GoToBestOfFive__FR12tMenuCommand) # high
	lw	$9,640($sp)
	addiu	$7,$7,%lo(MenuExtended_GoToBestOfFive__FR12tMenuCommand) # low
	sw	$16,16($sp)
	addu	$18,$9,2548
	move	$4,$18
	addu	$8,$9,3084
	move	$6,$8
	li	$9,10			# 0x0000000a
	sw	$8,248($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	lui	$8,%hi(screenMain) # high
	lw	$4,232($sp)
	lw	$6,%lo(screenMain)($8)
	lw	$8,236($sp)
	li	$9,182			# 0x000000b6
	sw	$9,24($sp)
	lw	$9,240($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$18,36($sp)
	sw	$0,40($sp)
	sw	$8,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	la	$7,MenuExtended_GoToCarSelect__FR12tMenuCommand
	li	$2,36			# 0x00000024
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$fp,$8,2716
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,195			# 0x000000c3
	li	$7,46			# 0x0000002e
	lw	$8,640($sp)
	lw	$9,640($sp)
	addu	$8,$8,2760
	move	$4,$8
	addu	$16,$9,3208
	move	$6,$16
	sw	$8,252($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,16($sp)
	.set	macro
	.set	reorder

	li	$5,196			# 0x000000c4
	move	$6,$16
	li	$7,46			# 0x0000002e
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,2800
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,256($sp)
	.set	macro
	.set	reorder

	li	$5,197			# 0x000000c5
	move	$6,$16
	li	$7,46			# 0x0000002e
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,2840
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,260($sp)
	.set	macro
	.set	reorder

	li	$5,198			# 0x000000c6
	move	$6,$16
	li	$7,46			# 0x0000002e
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$19,$9,2880
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,199			# 0x000000c7
	move	$6,$16
	li	$7,46			# 0x0000002e
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$20,$9,2920
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$20
	.set	macro
	.set	reorder

	li	$5,5120			# 0x00001400
	lui	$18,%hi(screenPinkSlips) # high
	lw	$4,244($sp)
	lw	$6,%lo(screenPinkSlips)($18)
	lw	$9,640($sp)
	la	$8,MenuExtended_GoToCarSelect__FR12tMenuCommand
	sw	$8,20($sp)
	lw	$8,256($sp)
	addu	$9,$9,3988
	sw	$9,264($sp)
	sw	$9,16($sp)
	lw	$9,252($sp)
	move	$7,$0
	sw	$9,32($sp)
	lw	$9,260($sp)
	li	$2,190			# 0x000000be
	sw	$2,24($sp)
	sw	$fp,28($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	lw	$4,248($sp)
	lw	$6,%lo(screenPinkSlips)($18)
	lw	$8,264($sp)
	la	$9,MenuExtended_GoToCarSelect__FR12tMenuCommand
	sw	$9,20($sp)
	lw	$9,256($sp)
	li	$5,5120			# 0x00001400
	sw	$8,16($sp)
	lw	$8,252($sp)
	move	$7,$0
	sw	$8,32($sp)
	lw	$8,260($sp)
	li	$2,191			# 0x000000bf
	sw	$2,24($sp)
	sw	$fp,28($sp)
	sw	$19,44($sp)
	sw	$20,48($sp)
	sw	$0,52($sp)
	sw	$9,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	la	$5,frontEnd+35
	addu	$18,$5,35
	move	$6,$18
	lui	$7,%hi(trackManager) # high
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorTrackPcT1P13tTrackManager
	addiu	$7,$7,%lo(trackManager) # low
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	la	$7,MenuExtended_GoToCarSelect__FR12tMenuCommand
	li	$2,28			# 0x0000001c
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$fp,$9,3232
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,147			# 0x00000093
	move	$6,$16
	li	$7,38			# 0x00000026
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,3276
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,268($sp)
	.set	macro
	.set	reorder

	li	$5,212			# 0x000000d4
	move	$7,$0
	lw	$9,640($sp)
	li	$2,58			# 0x0000003a
	sw	$2,16($sp)
	addu	$16,$9,3316
	move	$4,$16
	addu	$8,$9,4164
	move	$6,$8
	li	$9,10			# 0x0000000a
	sw	$8,272($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,5632			# 0x00001600
	lui	$8,%hi(screenTrackSelect) # high
	lw	$4,160($sp)
	lw	$6,%lo(screenTrackSelect)($8)
	lw	$9,264($sp)
	la	$8,MenuExtended_GoToCarSelect__FR12tMenuCommand
	sw	$8,20($sp)
	lw	$8,268($sp)
	move	$7,$0
	sw	$fp,28($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	sw	$9,16($sp)
	li	$9,200			# 0x000000c8
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,32($sp)
	.set	macro
	.set	reorder

	li	$5,5632			# 0x00001600
	lui	$9,%hi(screenTrackSelect) # high
	move	$7,$0
	lw	$4,168($sp)
	lw	$6,%lo(screenTrackSelect)($9)
	la	$8,MenuExtended_GoToCarSelect__FR12tMenuCommand
	sw	$8,20($sp)
	lw	$8,268($sp)
	li	$9,200			# 0x000000c8
	sw	$0,16($sp)
	sw	$9,24($sp)
	sw	$fp,28($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,32($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListNormal) # high
	addiu	$5,$5,%lo(SelectListNormal) # low
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,10
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3608
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,276($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListTrackDirection) # high
	addiu	$5,$5,%lo(SelectListTrackDirection) # low
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,15
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3628
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,280($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(SelectListOffOn) # high
	addiu	$16,$16,%lo(SelectListOffOn) # low
	move	$5,$16
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,20
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3648
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,284($sp)
	.set	macro
	.set	reorder

	move	$5,$16
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,-13
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3668
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,288($sp)
	.set	macro
	.set	reorder

	move	$5,$16
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,-8
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3688
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,292($sp)
	.set	macro
	.set	reorder

	move	$5,$16
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	addu	$6,$8,25
	lw	$9,640($sp)
	move	$7,$18
	addu	$9,$9,3708
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$9,296($sp)
	.set	macro
	.set	reorder

	move	$5,$16
	lui	$8,%hi(frontEnd+35) # high
	addiu	$8,$8,%lo(frontEnd+35) # low
	lw	$9,640($sp)
	addu	$6,$8,-2
	addu	$9,$9,3728
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	sw	$9,300($sp)
	.set	macro
	.set	reorder

	li	$5,202			# 0x000000ca
	lw	$9,640($sp)
	lw	$6,276($sp)
	addu	$22,$9,3744
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	move	$4,$22
	.set	macro
	.set	reorder

	li	$5,204			# 0x000000cc
	lui	$16,%hi(tMenuItemOptionsLeftRightChoice_vtable) # high
	lw	$8,640($sp)
	lw	$6,280($sp)
	addiu	$16,$16,%lo(tMenuItemOptionsLeftRightChoice_vtable) # low
	sw	$16,24($22)
	addu	$23,$8,3776
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	move	$4,$23
	.set	macro
	.set	reorder

	lw	$9,640($sp)
	lw	$6,284($sp)
	li	$5,205			# 0x000000cd
	sw	$16,24($23)
	addu	$fp,$9,3808
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,206			# 0x000000ce
	lui	$16,%hi(tMenuItemOptionsTwoItemChoice_vtable) # high
	addiu	$16,$16,%lo(tMenuItemOptionsTwoItemChoice_vtable) # low
	li	$9,128			# 0x00000080
	lw	$8,640($sp)
	lw	$6,288($sp)
	addu	$8,$8,3844
	move	$4,$8
	sw	$8,304($sp)
	sw	$16,24($fp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sh	$9,32($fp)
	.set	macro
	.set	reorder

	li	$5,207			# 0x000000cf
	lw	$8,640($sp)
	lw	$6,292($sp)
	lw	$9,304($sp)
	addu	$8,$8,3880
	move	$4,$8
	sw	$8,308($sp)
	li	$8,128			# 0x00000080
	sw	$16,24($9)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sh	$8,32($9)
	.set	macro
	.set	reorder

	li	$5,208			# 0x000000d0
	lw	$9,640($sp)
	lw	$6,296($sp)
	lw	$8,308($sp)
	addu	$9,$9,3916
	move	$4,$9
	sw	$9,312($sp)
	li	$9,128			# 0x00000080
	sw	$16,24($8)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sh	$9,32($8)
	.set	macro
	.set	reorder

	li	$5,210			# 0x000000d2
	lw	$8,640($sp)
	lw	$6,300($sp)
	lw	$9,312($sp)
	addu	$18,$8,3952
	move	$4,$18
	li	$8,128			# 0x00000080
	sw	$16,24($9)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sh	$8,32($9)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	move	$6,$0
	lw	$4,264($sp)
	li	$9,128			# 0x00000080
	sw	$16,24($18)
	sh	$9,32($18)
	lw	$9,304($sp)
	li	$8,-1			# 0xffffffff
	sw	$8,28($sp)
	lw	$8,308($sp)
	move	$7,$6
	sw	$9,44($sp)
	lw	$9,312($sp)
	li	$2,185			# 0x000000b9
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$22,32($sp)
	sw	$23,36($sp)
	sw	$fp,40($sp)
	sw	$18,56($sp)
	sw	$0,60($sp)
	sw	$8,48($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,52($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	move	$7,$5
	lw	$8,640($sp)
	li	$9,-1			# 0xffffffff
	sw	$9,16($sp)
	addu	$16,$8,4120
	move	$4,$16
	move	$8,$9
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	lui	$2,%hi(tBlankMenuItemGoToMenuNFS4Button_vtable) # high
	lw	$4,272($sp)
	addiu	$2,$2,%lo(tBlankMenuItemGoToMenuNFS4Button_vtable) # low
	sw	$2,24($16)
	lui	$2,%hi(screenTrackRecords) # high
	move	$7,$0
	lw	$6,%lo(screenTrackRecords)($2)
	li	$2,212			# 0x000000d4
	sw	$2,24($sp)
	li	$2,1			# 0x00000001
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,28($sp)
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	lui	$7,%hi(MenuExtended_GoToGarage__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToGarage__FR12tMenuCommand) # low
	li	$2,33			# 0x00000021
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,4292
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$2,%hi(screenTrackInfo) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenTrackInfo)($2)
	li	$2,249			# 0x000000f9
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$16,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	addu	$4,$8,4336
	.set	macro
	.set	reorder

	la	$5,frontEnd+92
	lw	$9,640($sp)
	la	$6,carManager
	addu	$9,$9,4460
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	sw	$9,316($sp)
	.set	macro
	.set	reorder

	la	$7,frontEnd+92
	lui	$9,%hi(FEApp) # high
	lw	$8,640($sp)
	lw	$5,316($sp)
	lw	$6,%lo(FEApp)($9)
	la	$9,carManager
	sw	$9,20($sp)
	addu	$8,$8,4488
	move	$4,$8
	sw	$8,320($sp)
	li	$8,48			# 0x00000030
	addu	$6,$6,556
	.set	noreorder
	.set	nomacro
	jal	__21tListIteratorCarColorPcN21iP11tCarManager
	sw	$8,16($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	la	$7,MenuExtended_GoToRace__FR12tMenuCommand
	li	$2,128			# 0x00000080
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$8,$8,4520
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,324($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,28			# 0x0000001c
	lw	$8,640($sp)
	lw	$6,316($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,4564
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,328($sp)
	.set	macro
	.set	reorder

	li	$5,288			# 0x00000120
	li	$7,38			# 0x00000026
	lw	$8,640($sp)
	lw	$6,320($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,4604
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,332($sp)
	.set	macro
	.set	reorder

	li	$5,274			# 0x00000112
	move	$6,$0
	lui	$7,%hi(MenuExtended_GoToShowroom__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToShowroom__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,48			# 0x00000030
	sw	$9,16($sp)
	addu	$16,$8,4644
	move	$4,$16
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	lui	$8,%hi(screenCarSelect) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelect)($8)
	li	$8,186			# 0x000000ba
	sw	$8,24($sp)
	lw	$8,328($sp)
	addu	$4,$9,4688
	addu	$fp,$9,8408
	la	$9,MenuExtended_GoToRace__FR12tMenuCommand
	sw	$9,20($sp)
	lw	$9,324($sp)
	li	$5,6656			# 0x00001a00
	sw	$9,28($sp)
	lw	$9,332($sp)
	move	$7,$0
	sw	$16,40($sp)
	sw	$0,44($sp)
	sw	$fp,16($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,36($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd+35) # high
	addiu	$9,$9,%lo(frontEnd+35) # low
	addu	$5,$9,256
	lw	$8,640($sp)
	la	$6,carManager
	addu	$8,$8,4812
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	sw	$8,336($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,28			# 0x0000001c
	lw	$8,640($sp)
	lw	$6,336($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,4840
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,340($sp)
	.set	macro
	.set	reorder

	li	$5,116			# 0x00000074
	move	$7,$0
	lw	$8,640($sp)
	lw	$9,640($sp)
	li	$2,58			# 0x0000003a
	sw	$2,16($sp)
	addu	$8,$8,4880
	move	$4,$8
	addu	$9,$9,7144
	move	$6,$9
	sw	$8,344($sp)
	li	$8,10			# 0x0000000a
	sw	$9,348($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,145			# 0x00000091
	move	$6,$0
	lui	$7,%hi(MenuExtended_GoToUpgrades__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToUpgrades__FR12tMenuCommand) # low
	li	$2,68			# 0x00000044
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$16,$9,4924
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,6656			# 0x00001a00
	lui	$8,%hi(screenCarSelect) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelect)($8)
	lw	$8,324($sp)
	addu	$4,$9,4968
	la	$9,MenuExtended_GoToRace__FR12tMenuCommand
	sw	$9,20($sp)
	lw	$9,340($sp)
	move	$7,$0
	sw	$8,28($sp)
	lw	$8,344($sp)
	li	$18,143			# 0x0000008f
	sw	$fp,16($sp)
	sw	$18,24($sp)
	sw	$16,40($sp)
	sw	$0,44($sp)
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,36($sp)
	.set	macro
	.set	reorder

	li	$5,6656			# 0x00001a00
	lui	$8,%hi(screenCarSelect) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelect)($8)
	lw	$8,324($sp)
	move	$7,$0
	sw	$fp,16($sp)
	sw	$18,24($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	addu	$4,$9,5092
	la	$9,MenuExtended_GoToRace__FR12tMenuCommand
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	la	$5,frontEnd+797
	lw	$9,640($sp)
	la	$6,carManager
	addu	$18,$9,5216
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	la	$7,MenuExtended_GoToRace__FR12tMenuCommand
	lw	$8,640($sp)
	li	$9,42			# 0x0000002a
	sw	$9,16($sp)
	addu	$8,$8,5244
	move	$4,$8
	sw	$8,352($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,12			# 0x0000000c
	lw	$9,640($sp)
	lw	$6,316($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	addu	$4,$9,5288
	.set	macro
	.set	reorder

	li	$5,288			# 0x00000120
	li	$7,22			# 0x00000016
	lw	$9,640($sp)
	lw	$6,320($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	addu	$4,$9,5328
	.set	macro
	.set	reorder

	li	$5,120			# 0x00000078
	la	$7,MenuExtended_GoToDealer__FR12tMenuCommand
	lw	$9,640($sp)
	lw	$8,640($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,16($sp)
	addu	$9,$9,5368
	move	$4,$9
	addu	$8,$8,7496
	move	$6,$8
	sw	$9,356($sp)
	li	$9,10			# 0x0000000a
	sw	$8,360($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,188			# 0x000000bc
	move	$6,$18
	li	$7,32			# 0x00000020
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$16,$8,5412
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$18,%hi(screenCarSelectDuel) # high
	lw	$8,640($sp)
	lw	$6,%lo(screenCarSelectDuel)($18)
	la	$9,MenuExtended_GoToRace__FR12tMenuCommand
	sw	$9,20($sp)
	lw	$9,352($sp)
	addu	$4,$8,5452
	li	$8,186			# 0x000000ba
	sw	$8,24($sp)
	lw	$8,340($sp)
	li	$5,6144			# 0x00001800
	sw	$9,28($sp)
	lw	$9,356($sp)
	move	$7,$0
	sw	$fp,16($sp)
	sw	$16,40($sp)
	sw	$0,44($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,36($sp)
	.set	macro
	.set	reorder

	lw	$8,640($sp)
	lw	$6,%lo(screenCarSelectDuel)($18)
	la	$9,MenuExtended_GoToRace__FR12tMenuCommand
	sw	$9,20($sp)
	lw	$9,352($sp)
	addu	$4,$8,5576
	li	$8,186			# 0x000000ba
	sw	$8,24($sp)
	lw	$8,328($sp)
	li	$5,6144			# 0x00001800
	sw	$9,28($sp)
	lw	$9,332($sp)
	move	$7,$0
	sw	$fp,16($sp)
	sw	$16,40($sp)
	sw	$0,44($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,36($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	lui	$16,%hi(MenuExtended_GoTo2PlayerRace__FR12tMenuCommand) # high
	addiu	$16,$16,%lo(MenuExtended_GoTo2PlayerRace__FR12tMenuCommand) # low
	move	$7,$16
	lw	$8,640($sp)
	li	$9,42			# 0x0000002a
	sw	$9,16($sp)
	addu	$8,$8,5700
	move	$4,$8
	sw	$8,364($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,12			# 0x0000000c
	lw	$9,640($sp)
	lw	$6,316($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,5744
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,368($sp)
	.set	macro
	.set	reorder

	li	$5,288			# 0x00000120
	li	$7,22			# 0x00000016
	lw	$9,640($sp)
	lw	$6,320($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$18,$9,5784
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenCarSelectTwoPlayer) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelectTwoPlayer)($8)
	li	$8,186			# 0x000000ba
	sw	$8,24($sp)
	lw	$8,368($sp)
	addu	$4,$9,5824
	addu	$9,$9,8540
	sw	$9,372($sp)
	sw	$9,16($sp)
	lw	$9,364($sp)
	move	$7,$0
	sw	$16,20($sp)
	sw	$18,36($sp)
	sw	$0,40($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	move	$7,$16
	lw	$9,640($sp)
	li	$8,42			# 0x0000002a
	sw	$8,16($sp)
	addu	$9,$9,5948
	move	$4,$9
	sw	$9,376($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,12			# 0x0000000c
	lw	$8,640($sp)
	lw	$6,316($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,5992
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,380($sp)
	.set	macro
	.set	reorder

	li	$5,288			# 0x00000120
	li	$7,22			# 0x00000016
	lw	$8,640($sp)
	lw	$6,320($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$18,$8,6032
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$9,%hi(screenCarSelectPlayerTwo) # high
	lw	$8,640($sp)
	lw	$6,%lo(screenCarSelectPlayerTwo)($9)
	li	$9,186			# 0x000000ba
	sw	$9,24($sp)
	lw	$9,380($sp)
	addu	$4,$8,6072
	addu	$8,$8,8672
	sw	$8,384($sp)
	sw	$8,16($sp)
	lw	$8,376($sp)
	move	$7,$0
	sw	$16,20($sp)
	sw	$18,36($sp)
	sw	$0,40($sp)
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	move	$7,$16
	lw	$8,640($sp)
	li	$9,42			# 0x0000002a
	sw	$9,16($sp)
	addu	$4,$8,6196
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,12			# 0x0000000c
	lw	$9,640($sp)
	lw	$6,336($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$18,$9,6240
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenCarSelectTwoPlayer) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelectTwoPlayer)($8)
	addu	$4,$9,6280
	lw	$9,372($sp)
	move	$7,$0
	sw	$9,16($sp)
	lw	$9,364($sp)
	li	$8,186			# 0x000000ba
	sw	$16,20($sp)
	sw	$8,24($sp)
	sw	$18,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	move	$7,$16
	lw	$8,640($sp)
	li	$9,42			# 0x0000002a
	sw	$9,16($sp)
	addu	$8,$8,6404
	move	$4,$8
	sw	$8,388($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	li	$7,12			# 0x0000000c
	lw	$9,640($sp)
	lw	$6,336($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$18,$9,6448
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenCarSelectPlayerTwo) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelectPlayerTwo)($8)
	addu	$4,$9,6488
	lw	$9,384($sp)
	move	$7,$0
	sw	$9,16($sp)
	lw	$9,388($sp)
	li	$8,186			# 0x000000ba
	sw	$16,20($sp)
	sw	$8,24($sp)
	sw	$18,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd+92) # high
	addiu	$9,$9,%lo(frontEnd+92) # low
	addu	$5,$9,201
	lw	$8,640($sp)
	la	$6,carManager
	addu	$18,$8,6612
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	move	$7,$16
	lw	$8,640($sp)
	li	$9,42			# 0x0000002a
	sw	$9,16($sp)
	addu	$8,$8,6640
	move	$4,$8
	sw	$8,392($sp)
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	move	$6,$18
	li	$7,12			# 0x0000000c
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$8,16($sp)
	addu	$9,$9,6684
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$9,396($sp)
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenPinkSlipsCarSelectTwoPlayer) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenPinkSlipsCarSelectTwoPlayer)($8)
	li	$8,186			# 0x000000ba
	sw	$8,24($sp)
	lw	$8,396($sp)
	addu	$4,$9,6724
	addu	$9,$9,8804
	sw	$9,400($sp)
	sw	$9,16($sp)
	lw	$9,392($sp)
	move	$7,$0
	sw	$16,20($sp)
	sw	$0,36($sp)
	sw	$8,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	li	$5,189			# 0x000000bd
	move	$6,$0
	move	$7,$16
	lw	$9,640($sp)
	li	$8,42			# 0x0000002a
	sw	$8,16($sp)
	addu	$9,$9,6848
	move	$4,$9
	sw	$9,404($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	move	$6,$18
	li	$7,12			# 0x0000000c
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,6892
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,408($sp)
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$9,%hi(screenPinkSlipsCarSelectPlayerTwo) # high
	lw	$8,640($sp)
	lw	$6,%lo(screenPinkSlipsCarSelectPlayerTwo)($9)
	li	$9,186			# 0x000000ba
	sw	$9,24($sp)
	lw	$9,408($sp)
	addu	$4,$8,6932
	addu	$8,$8,8936
	sw	$8,412($sp)
	sw	$8,16($sp)
	lw	$8,404($sp)
	move	$7,$0
	sw	$16,20($sp)
	sw	$0,36($sp)
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tMenuNFS4TwoPlayerUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	li	$5,120			# 0x00000078
	la	$7,MenuExtended_GoToDealer__FR12tMenuCommand
	lw	$8,640($sp)
	lw	$6,360($sp)
	li	$9,88			# 0x00000058
	sw	$9,16($sp)
	addu	$18,$8,7056
	move	$4,$18
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,121			# 0x00000079
	lui	$7,%hi(MenuExtended_GoToSeller__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToSeller__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,78			# 0x0000004e
	sw	$8,16($sp)
	addu	$16,$9,7100
	move	$4,$16
	addu	$fp,$9,7732
	move	$6,$fp
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,4608			# 0x00001200
	lui	$8,%hi(screenCarSelect) # high
	move	$7,$0
	lw	$4,348($sp)
	lw	$6,%lo(screenCarSelect)($8)
	li	$9,144			# 0x00000090
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	sw	$18,28($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd+92) # high
	addiu	$9,$9,%lo(frontEnd+92) # low
	addu	$18,$9,204
	move	$5,$18
	lw	$8,640($sp)
	la	$6,carManager
	addu	$16,$8,7268
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$16
	lui	$9,%hi(FEApp) # high
	move	$7,$18
	lw	$8,640($sp)
	lw	$6,%lo(FEApp)($9)
	la	$9,carManager
	sw	$9,20($sp)
	addu	$8,$8,7296
	move	$4,$8
	sw	$8,416($sp)
	li	$8,48			# 0x00000030
	addu	$6,$6,556
	.set	noreorder
	.set	nomacro
	jal	__21tListIteratorCarColorPcN21iP11tCarManager
	sw	$8,16($sp)
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	move	$6,$16
	li	$7,28			# 0x0000001c
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,7328
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,420($sp)
	.set	macro
	.set	reorder

	li	$5,288			# 0x00000120
	li	$7,38			# 0x00000026
	lw	$8,640($sp)
	lw	$6,416($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$8,$8,7368
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	sw	$8,424($sp)
	.set	macro
	.set	reorder

	li	$5,117			# 0x00000075
	move	$6,$0
	lui	$7,%hi(MenuExtended_BuyCar__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_BuyCar__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,88			# 0x00000058
	sw	$9,16($sp)
	addu	$18,$8,7408
	move	$4,$18
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,274			# 0x00000112
	move	$6,$0
	lui	$7,%hi(MenuExtended_GoToDealerShowroom__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_GoToDealerShowroom__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,48			# 0x00000030
	sw	$8,16($sp)
	addu	$16,$9,7452
	move	$4,$16
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,8768			# 0x00002240
	lui	$8,%hi(screenCarSelect) # high
	lw	$4,360($sp)
	lw	$6,%lo(screenCarSelect)($8)
	lw	$8,420($sp)
	li	$9,144			# 0x00000090
	sw	$9,24($sp)
	lw	$9,424($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$18,36($sp)
	sw	$16,40($sp)
	sw	$0,44($sp)
	sw	$8,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(frontEnd+92) # high
	addiu	$9,$9,%lo(frontEnd+92) # low
	addu	$5,$9,205
	lw	$8,640($sp)
	la	$6,carManager
	addu	$16,$8,7620
	.set	noreorder
	.set	nomacro
	jal	__16tListIteratorCarPcP11tCarManager
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,146			# 0x00000092
	move	$6,$16
	li	$7,28			# 0x0000001c
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$9,16($sp)
	addu	$18,$8,7648
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,119			# 0x00000077
	move	$6,$0
	lui	$7,%hi(MenuExtended_SellCar__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_SellCar__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,78			# 0x0000004e
	sw	$9,16($sp)
	addu	$16,$8,7688
	move	$4,$16
	li	$8,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	move	$4,$fp
	li	$5,8704			# 0x00002200
	lui	$9,%hi(screenCarSelect) # high
	move	$7,$0
	lw	$6,%lo(screenCarSelect)($9)
	li	$8,144			# 0x00000090
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$8,24($sp)
	sw	$18,28($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$0,36($sp)
	.set	macro
	.set	reorder

	li	$5,150			# 0x00000096
	move	$6,$0
	lui	$7,%hi(MenuExtended_PurchaseUpgrade1__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_PurchaseUpgrade1__FR12tMenuCommand) # low
	li	$2,98			# 0x00000062
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$9,$9,7856
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,428($sp)
	.set	macro
	.set	reorder

	li	$5,151			# 0x00000097
	move	$6,$0
	lui	$7,%hi(MenuExtended_PurchaseUpgrade2__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_PurchaseUpgrade2__FR12tMenuCommand) # low
	li	$2,108			# 0x0000006c
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$18,$9,7900
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,152			# 0x00000098
	move	$6,$0
	lui	$7,%hi(MenuExtended_PurchaseUpgrade3__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_PurchaseUpgrade3__FR12tMenuCommand) # low
	li	$2,118			# 0x00000076
	lw	$9,640($sp)
	li	$8,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$8,20($sp)
	addu	$16,$9,7944
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,8704			# 0x00002200
	lui	$8,%hi(screenCarSelect) # high
	move	$7,$0
	lw	$9,640($sp)
	lw	$6,%lo(screenCarSelect)($8)
	addu	$4,$9,7988
	lw	$9,428($sp)
	li	$2,145			# 0x00000091
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$18,32($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListTransmission) # high
	addiu	$5,$5,%lo(SelectListTransmission) # low
	lui	$9,%hi(FEApp) # high
	la	$6,frontEnd+94
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$8,$8,8112
	move	$4,$8
	addu	$7,$7,556
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$8,432($sp)
	.set	macro
	.set	reorder

	la	$5,SelectListOffOn
	lui	$9,%hi(FEApp) # high
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$8,$8,8132
	move	$4,$8
	sw	$8,436($sp)
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	addu	$6,$8,-9
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,556
	.set	macro
	.set	reorder

	la	$5,SelectListOffOn
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$6,$8,-7
	addu	$18,$9,8152
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListOpponentUpgrades) # high
	addiu	$5,$5,%lo(SelectListOpponentUpgrades) # low
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$6,$8,-763
	addu	$17,$9,8168
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,266			# 0x0000010a
	lw	$9,640($sp)
	lw	$6,432($sp)
	addu	$9,$9,8184
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$9,440($sp)
	.set	macro
	.set	reorder

	li	$5,267			# 0x0000010b
	lui	$16,%hi(tMenuItemOptionsLeftRightChoice_vtable) # high
	addiu	$16,$16,%lo(tMenuItemOptionsLeftRightChoice_vtable) # low
	lw	$8,640($sp)
	lw	$6,436($sp)
	lw	$9,440($sp)
	addu	$8,$8,8216
	move	$4,$8
	sw	$8,444($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,273			# 0x00000111
	move	$6,$18
	lw	$8,640($sp)
	lw	$9,444($sp)
	addu	$8,$8,8248
	move	$4,$8
	sw	$8,448($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,266			# 0x0000010a
	lw	$8,640($sp)
	lw	$6,432($sp)
	lw	$9,448($sp)
	addu	$fp,$8,8280
	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,267			# 0x0000010b
	lw	$8,640($sp)
	lw	$6,436($sp)
	addu	$8,$8,8312
	move	$4,$8
	sw	$8,452($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($fp)
	.set	macro
	.set	reorder

	li	$5,273			# 0x00000111
	move	$6,$18
	lw	$9,640($sp)
	lw	$8,452($sp)
	addu	$9,$9,8344
	move	$4,$9
	sw	$9,456($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($8)
	.set	macro
	.set	reorder

	li	$5,270			# 0x0000010e
	move	$6,$17
	lw	$9,640($sp)
	lw	$8,456($sp)
	addu	$18,$9,8376
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	sw	$16,24($8)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	lw	$9,640($sp)
	move	$6,$0
	sw	$16,24($18)
	li	$8,-1			# 0xffffffff
	sw	$8,28($sp)
	lw	$8,444($sp)
	addu	$4,$9,8408
	lw	$9,440($sp)
	move	$7,$6
	sw	$9,32($sp)
	lw	$9,448($sp)
	li	$16,187			# 0x000000bb
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$18,44($sp)
	sw	$0,48($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	lui	$8,%hi(screenCarSelectTwoPlayer) # high
	lw	$4,372($sp)
	lw	$6,%lo(screenCarSelectTwoPlayer)($8)
	lw	$9,440($sp)
	lw	$8,444($sp)
	li	$5,4104			# 0x00001008
	sw	$9,32($sp)
	lw	$9,448($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$0,28($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenCarSelectPlayerTwo) # high
	lw	$4,384($sp)
	lw	$6,%lo(screenCarSelectPlayerTwo)($8)
	lw	$8,452($sp)
	li	$9,1			# 0x00000001
	sw	$9,28($sp)
	lw	$9,456($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$fp,32($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	lui	$8,%hi(screenPinkSlipsCarSelectTwoPlayer) # high
	lw	$4,400($sp)
	lw	$6,%lo(screenPinkSlipsCarSelectTwoPlayer)($8)
	lw	$9,440($sp)
	lw	$8,444($sp)
	li	$5,4104			# 0x00001008
	sw	$9,32($sp)
	lw	$9,448($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$0,28($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	li	$5,4104			# 0x00001008
	lui	$8,%hi(screenPinkSlipsCarSelectPlayerTwo) # high
	lw	$4,412($sp)
	lw	$6,%lo(screenPinkSlipsCarSelectPlayerTwo)($8)
	lw	$8,452($sp)
	li	$9,1			# 0x00000001
	sw	$9,28($sp)
	lw	$9,456($sp)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,24($sp)
	sw	$fp,32($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tMenuOptionsUiP7tScreenP5tMenuT3PFR12tMenuCommand_vssP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	li	$5,16384			# 0x00004000
	move	$6,$0
	move	$7,$6
	lw	$8,640($sp)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,9068
	.set	macro
	.set	reorder

	li	$5,453			# 0x000001c5
	move	$7,$0
	lw	$8,640($sp)
	lw	$9,640($sp)
	li	$2,180			# 0x000000b4
	sw	$2,16($sp)
	addu	$8,$8,9192
	move	$4,$8
	addu	$9,$9,10208
	move	$6,$9
	sw	$8,460($sp)
	li	$8,10			# 0x0000000a
	sw	$9,464($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,454			# 0x000001c6
	move	$7,$0
	lw	$9,640($sp)
	lw	$8,640($sp)
	li	$2,190			# 0x000000be
	sw	$2,16($sp)
	addu	$9,$9,9236
	move	$4,$9
	addu	$8,$8,10856
	move	$6,$8
	sw	$9,468($sp)
	li	$9,10			# 0x0000000a
	sw	$8,472($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,456			# 0x000001c8
	move	$7,$0
	lw	$8,640($sp)
	lw	$9,640($sp)
	li	$2,200			# 0x000000c8
	sw	$2,16($sp)
	addu	$8,$8,9280
	move	$4,$8
	addu	$9,$9,11116
	move	$6,$9
	sw	$8,476($sp)
	li	$8,10			# 0x0000000a
	sw	$9,480($sp)
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	li	$5,457			# 0x000001c9
	move	$7,$0
	lw	$9,640($sp)
	lw	$8,640($sp)
	li	$2,210			# 0x000000d2
	sw	$2,16($sp)
	addu	$9,$9,9324
	move	$4,$9
	addu	$6,$8,12460
	sw	$9,484($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,458			# 0x000001ca
	move	$6,$0
	lui	$7,%hi(MenuExtended_EnterUserName__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_EnterUserName__FR12tMenuCommand) # low
	li	$2,220			# 0x000000dc
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$18,$8,9368
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,460			# 0x000001cc
	move	$7,$0
	li	$2,230			# 0x000000e6
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$2,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,9412
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	addu	$6,$8,14832
	.set	macro
	.set	reorder

	lui	$2,%hi(screenMain) # high
	lw	$8,640($sp)
	lw	$6,%lo(screenMain)($2)
	lw	$9,460($sp)
	addu	$4,$8,9456
	lw	$8,468($sp)
	li	$5,4116			# 0x00001014
	sw	$9,28($sp)
	lw	$9,476($sp)
	move	$7,$0
	sw	$8,32($sp)
	lw	$8,484($sp)
	li	$2,93			# 0x0000005d
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$18,44($sp)
	sw	$16,48($sp)
	sw	$0,52($sp)
	sw	$9,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$7,$8,36
	addu	$16,$9,9580
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$7,$8,37
	addu	$18,$9,9596
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$7,$8,39
	addu	$9,$9,9612
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	sw	$9,488($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$7,$8,38
	addu	$9,$9,9628
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	sw	$9,492($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$7,$8,40
	addu	$9,$9,9644
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__18tListIteratorRangeccPc
	sw	$9,496($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListAudioMode) # high
	addiu	$5,$5,%lo(SelectListAudioMode) # low
	lui	$8,%hi(frontEnd+797) # high
	addiu	$8,$8,%lo(frontEnd+797) # low
	lw	$9,640($sp)
	addu	$6,$8,41
	addu	$9,$9,9660
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	sw	$9,500($sp)
	.set	macro
	.set	reorder

	li	$5,469			# 0x000001d5
	move	$6,$16
	lw	$9,640($sp)
	move	$7,$0
	addu	$9,$9,9676
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	sw	$9,504($sp)
	.set	macro
	.set	reorder

	li	$5,470			# 0x000001d6
	move	$6,$18
	lw	$8,640($sp)
	li	$7,1			# 0x00000001
	addu	$8,$8,9732
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	sw	$8,508($sp)
	.set	macro
	.set	reorder

	li	$5,471			# 0x000001d7
	li	$7,2			# 0x00000002
	lw	$9,640($sp)
	lw	$6,488($sp)
	addu	$fp,$9,9788
	.set	noreorder
	.set	nomacro
	jal	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,472			# 0x000001d8
	li	$7,3			# 0x00000003
	lw	$8,640($sp)
	lw	$6,492($sp)
	addu	$8,$8,9844
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	sw	$8,512($sp)
	.set	macro
	.set	reorder

	li	$5,473			# 0x000001d9
	li	$7,4			# 0x00000004
	lw	$9,640($sp)
	lw	$6,496($sp)
	addu	$9,$9,9900
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	sw	$9,516($sp)
	.set	macro
	.set	reorder

	li	$5,474			# 0x000001da
	lw	$8,640($sp)
	lw	$6,500($sp)
	addu	$18,$8,9956
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,475			# 0x000001db
	li	$6,350			# 0x0000015e
	li	$7,43			# 0x0000002b
	la	$8,tMenuItemDisplayLeftRightChoice_vtable
	lw	$9,640($sp)
	li	$2,-102			# 0xffffff9a
	sw	$8,24($18)
	sw	$2,16($sp)
	sw	$0,24($sp)
	addu	$16,$9,10000
	move	$4,$16
	li	$9,13			# 0x0000000d
	.set	noreorder
	.set	nomacro
	jal	__20tMenuItemSlidingMenuUissssb
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	move	$6,$0
	move	$7,$6
	lui	$2,%hi(tMenuItemSlidingActivated_vtable) # high
	lw	$8,640($sp)
	addiu	$2,$2,%lo(tMenuItemSlidingActivated_vtable) # low
	sw	$2,24($16)
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	addu	$4,$8,10072
	.set	macro
	.set	reorder

	li	$5,4112			# 0x00001010
	lui	$2,%hi(screenAudio) # high
	lw	$4,464($sp)
	lw	$6,%lo(screenAudio)($2)
	lw	$8,504($sp)
	li	$9,10			# 0x0000000a
	sw	$9,32($sp)
	lw	$9,508($sp)
	move	$7,$0
	sw	$8,36($sp)
	lw	$8,512($sp)
	li	$2,611			# 0x00000263
	sw	$2,24($sp)
	sw	$9,40($sp)
	lw	$9,516($sp)
	li	$2,38			# 0x00000026
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,28($sp)
	sw	$fp,44($sp)
	sw	$18,56($sp)
	sw	$16,60($sp)
	sw	$0,64($sp)
	sw	$8,48($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$9,52($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListDisplaySpeed) # high
	addiu	$5,$5,%lo(SelectListDisplaySpeed) # low
	lui	$9,%hi(FEApp) # high
	la	$6,frontEnd+800
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$8,$8,10336
	move	$4,$8
	addu	$7,$7,557
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	sw	$8,520($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListDisplayMap) # high
	addiu	$5,$5,%lo(SelectListDisplayMap) # low
	lui	$9,%hi(FEApp) # high
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$8,$8,10356
	move	$4,$8
	sw	$8,524($sp)
	lui	$8,%hi(frontEnd+94) # high
	addiu	$8,$8,%lo(frontEnd+94) # low
	addu	$6,$8,710
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListDisplayOpponentID) # high
	addiu	$5,$5,%lo(SelectListDisplayOpponentID) # low
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$7,%lo(FEApp)($8)
	addu	$9,$9,10376
	move	$4,$9
	sw	$9,528($sp)
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$6,$9,712
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	la	$5,SelectListOffOn
	lui	$9,%hi(FEApp) # high
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$18,$8,10396
	move	$4,$18
	lui	$8,%hi(frontEnd+94) # high
	addiu	$8,$8,%lo(frontEnd+94) # low
	addu	$6,$8,714
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	la	$5,SelectListOffOn
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$7,%lo(FEApp)($8)
	addu	$16,$9,10416
	move	$4,$16
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$6,$9,716
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	la	$5,SelectListOffOn
	lui	$9,%hi(FEApp) # high
	lw	$8,640($sp)
	lw	$7,%lo(FEApp)($9)
	addu	$8,$8,10436
	move	$4,$8
	sw	$8,532($sp)
	lui	$8,%hi(frontEnd+94) # high
	addiu	$8,$8,%lo(frontEnd+94) # low
	addu	$6,$8,718
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListSplitTime) # high
	addiu	$5,$5,%lo(SelectListSplitTime) # low
	lui	$8,%hi(frontEnd+94) # high
	addiu	$8,$8,%lo(frontEnd+94) # low
	lw	$9,640($sp)
	addu	$6,$8,824
	addu	$9,$9,10456
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	sw	$9,536($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListSplitDisplay) # high
	addiu	$5,$5,%lo(SelectListSplitDisplay) # low
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$7,%lo(FEApp)($8)
	addu	$9,$9,10472
	move	$4,$9
	sw	$9,540($sp)
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$6,$9,825
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	li	$5,479			# 0x000001df
	lw	$8,640($sp)
	lw	$6,520($sp)
	addu	$21,$8,10492
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	move	$4,$21
	.set	macro
	.set	reorder

	li	$5,481			# 0x000001e1
	lw	$9,640($sp)
	lw	$6,524($sp)
	la	$8,tMenuItemDisplayLeftRightChoice_vtable
	sw	$8,24($21)
	addu	$fp,$9,10536
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,482			# 0x000001e2
	la	$8,tMenuItemDisplayLeftRightChoice_vtable
	lw	$9,640($sp)
	lw	$6,528($sp)
	addu	$9,$9,10580
	move	$4,$9
	sw	$9,544($sp)
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	sw	$8,24($fp)
	.set	macro
	.set	reorder

	li	$5,483			# 0x000001e3
	move	$6,$18
	lw	$9,640($sp)
	lw	$8,544($sp)
	addu	$9,$9,10624
	move	$4,$9
	sw	$9,548($sp)
	la	$9,tMenuItemDisplayLeftRightChoice_vtable
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	sw	$9,24($8)
	.set	macro
	.set	reorder

	li	$5,486			# 0x000001e6
	move	$6,$16
	lui	$16,%hi(tMenuItemOnOffLeftRightChoice_vtable) # high
	addiu	$16,$16,%lo(tMenuItemOnOffLeftRightChoice_vtable) # low
	lw	$8,640($sp)
	lw	$9,548($sp)
	addu	$8,$8,10672
	move	$4,$8
	sw	$8,552($sp)
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,487			# 0x000001e7
	lw	$8,640($sp)
	lw	$6,532($sp)
	lw	$9,552($sp)
	addu	$8,$8,10720
	move	$4,$8
	sw	$8,556($sp)
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,484			# 0x000001e4
	lw	$8,640($sp)
	lw	$6,536($sp)
	lw	$9,556($sp)
	addu	$18,$8,10768
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	sw	$16,24($9)
	.set	macro
	.set	reorder

	li	$5,485			# 0x000001e5
	lw	$8,640($sp)
	lw	$6,540($sp)
	la	$9,tMenuItemDisplayLeftRightChoice_vtable
	sw	$9,24($18)
	addu	$16,$8,10812
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	move	$4,$16
	.set	macro
	.set	reorder

	la	$8,tMenuItemDisplayLeftRightChoice_vtable
	lw	$4,472($sp)
	lui	$2,%hi(screenDisplay) # high
	sw	$8,24($16)
	lw	$6,%lo(screenDisplay)($2)
	li	$9,1			# 0x00000001
	sw	$9,28($sp)
	lw	$9,544($sp)
	li	$8,10			# 0x0000000a
	sw	$8,32($sp)
	lw	$8,548($sp)
	li	$5,4128			# 0x00001020
	sw	$9,44($sp)
	lw	$9,552($sp)
	move	$7,$0
	sw	$8,48($sp)
	lw	$8,556($sp)
	li	$2,477			# 0x000001dd
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$21,36($sp)
	sw	$fp,40($sp)
	sw	$18,52($sp)
	sw	$16,56($sp)
	sw	$0,68($sp)
	sw	$9,60($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$8,64($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(SelectListControllerConfig) # high
	addiu	$5,$5,%lo(SelectListControllerConfig) # low
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$7,%lo(FEApp)($8)
	addu	$18,$9,10984
	move	$4,$18
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$6,$9,772
	.set	noreorder
	.set	nomacro
	jal	__20tListIteratorIndexedPsPcT2
	addu	$7,$7,557
	.set	macro
	.set	reorder

	li	$5,521			# 0x00000209
	lw	$8,640($sp)
	move	$6,$18
	addu	$16,$8,11004
	.set	noreorder
	.set	nomacro
	jal	__22tMenuItemLeftRightFadeUiP13tListIterator
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,522			# 0x0000020a
	li	$6,172			# 0x000000ac
	li	$7,72			# 0x00000048
	lui	$2,%hi(tMenuItemControllerLeftRightChoice_vtable) # high
	lw	$9,640($sp)
	addiu	$2,$2,%lo(tMenuItemControllerLeftRightChoice_vtable) # low
	sw	$2,24($16)
	li	$8,13			# 0x0000000d
	sw	$0,16($sp)
	sw	$8,20($sp)
	addu	$18,$9,11048
	move	$4,$18
	li	$9,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	__20tMenuItemSlidingMenuUissssb
	sw	$9,24($sp)
	.set	macro
	.set	reorder

	li	$5,4128			# 0x00001020
	lui	$2,%hi(screenControllerConfig) # high
	move	$7,$0
	lw	$6,%lo(screenControllerConfig)($2)
	li	$2,520			# 0x00000208
	lw	$4,480($sp)
	li	$8,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$0,28($sp)
	sw	$8,32($sp)
	sw	$16,36($sp)
	sw	$18,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$0,44($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($8)
	addu	$16,$9,11244
	move	$4,$16
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$7,$9,763
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,526			# 0x0000020e
	lw	$8,640($sp)
	move	$6,$16
	addu	$8,$8,11264
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__25tInsideBoxLeftRightSliderUiP13tListIterator
	sw	$8,560($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$16,%hi(tInsideBoxControllerLeftRightSlider_vtable) # high
	addiu	$16,$16,%lo(tInsideBoxControllerLeftRightSlider_vtable) # low
	lw	$9,640($sp)
	lw	$8,560($sp)
	addu	$18,$9,11304
	move	$4,$18
	lui	$9,%hi(FEApp) # high
	sw	$16,24($8)
	lui	$8,%hi(frontEnd+94) # high
	addiu	$8,$8,%lo(frontEnd+94) # low
	lw	$2,%lo(FEApp)($9)
	addu	$7,$8,765
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,527			# 0x0000020f
	lw	$9,640($sp)
	move	$6,$18
	addu	$9,$9,11324
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__25tInsideBoxLeftRightSliderUiP13tListIterator
	sw	$9,564($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lw	$8,640($sp)
	lw	$9,564($sp)
	addu	$18,$8,11364
	move	$4,$18
	lui	$8,%hi(FEApp) # high
	sw	$16,24($9)
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	lw	$2,%lo(FEApp)($8)
	addu	$7,$9,755
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,529			# 0x00000211
	move	$6,$18
	lw	$8,640($sp)
	move	$7,$0
	addu	$8,$8,11384
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$8,568($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($8)
	addu	$16,$9,11432
	move	$4,$16
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$7,$9,757
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,531			# 0x00000213
	move	$6,$16
	lw	$8,640($sp)
	li	$7,1			# 0x00000001
	addu	$8,$8,11452
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$8,572($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($8)
	addu	$16,$9,11500
	move	$4,$16
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$7,$9,759
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,528			# 0x00000210
	move	$6,$16
	lw	$8,640($sp)
	li	$7,2			# 0x00000002
	addu	$8,$8,11520
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$8,576($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$8,%hi(FEApp) # high
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($8)
	addu	$16,$9,11568
	move	$4,$16
	lui	$9,%hi(frontEnd+94) # high
	addiu	$9,$9,%lo(frontEnd+94) # low
	addu	$7,$9,761
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,530			# 0x00000212
	move	$6,$16
	lw	$8,640($sp)
	li	$7,3			# 0x00000003
	addu	$8,$8,11588
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$8,580($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$18,%hi(FEApp) # high
	lui	$8,%hi(frontEnd+800) # high
	addiu	$8,$8,%lo(frontEnd+800) # low
	addu	$7,$8,41
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($18)
	addu	$16,$9,11636
	move	$4,$16
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,532			# 0x00000214
	move	$6,$16
	lw	$9,640($sp)
	move	$7,$0
	addu	$9,$9,11656
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$9,584($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,127			# 0x0000007f
	lui	$9,%hi(frontEnd+800) # high
	addiu	$9,$9,%lo(frontEnd+800) # low
	addu	$7,$9,43
	lw	$8,640($sp)
	lw	$2,%lo(FEApp)($18)
	addu	$16,$8,11704
	move	$4,$16
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,533			# 0x00000215
	move	$6,$16
	lw	$8,640($sp)
	li	$7,1			# 0x00000001
	addu	$fp,$8,11724
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	move	$4,$fp
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,255			# 0x000000ff
	lui	$8,%hi(frontEnd+800) # high
	addiu	$8,$8,%lo(frontEnd+800) # low
	addu	$7,$8,45
	lw	$9,640($sp)
	lw	$2,%lo(FEApp)($18)
	addu	$16,$9,11772
	move	$4,$16
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,534			# 0x00000216
	move	$6,$16
	lw	$9,640($sp)
	li	$7,2			# 0x00000002
	addu	$9,$9,11792
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	sw	$9,588($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,255			# 0x000000ff
	lui	$9,%hi(frontEnd+800) # high
	addiu	$9,$9,%lo(frontEnd+800) # low
	addu	$7,$9,47
	lw	$8,640($sp)
	lw	$2,%lo(FEApp)($18)
	addu	$16,$8,11840
	move	$4,$16
	addu	$2,$2,557
	.set	noreorder
	.set	nomacro
	jal	__25tListIteratorRangeIndexedccPcT3
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$5,535			# 0x00000217
	move	$6,$16
	lw	$8,640($sp)
	li	$7,3			# 0x00000003
	addu	$18,$8,11860
	.set	noreorder
	.set	nomacro
	jal	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	move	$6,$0
	lw	$9,640($sp)
	lw	$8,560($sp)
	addu	$4,$9,11908
	lw	$9,564($sp)
	move	$7,$6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,36($sp)
	sw	$8,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	lw	$8,640($sp)
	lw	$9,568($sp)
	addu	$4,$8,12024
	lw	$8,572($sp)
	li	$5,4096			# 0x00001000
	sw	$9,28($sp)
	lw	$9,576($sp)
	move	$6,$0
	sw	$8,32($sp)
	lw	$8,580($sp)
	move	$7,$6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,44($sp)
	sw	$9,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	lw	$9,640($sp)
	lw	$8,560($sp)
	addu	$4,$9,12140
	lw	$9,564($sp)
	li	$5,4096			# 0x00001000
	sw	$8,28($sp)
	lw	$8,572($sp)
	move	$6,$0
	sw	$9,32($sp)
	lw	$9,580($sp)
	move	$7,$6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,44($sp)
	sw	$8,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	li	$5,4096			# 0x00001000
	move	$6,$0
	lw	$8,640($sp)
	lw	$9,584($sp)
	addu	$4,$8,12256
	lw	$8,588($sp)
	move	$7,$6
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$fp,32($sp)
	sw	$18,40($sp)
	sw	$0,44($sp)
	sw	$9,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$8,36($sp)
	.set	macro
	.set	reorder

	li	$5,646			# 0x00000286
	move	$6,$0
	lui	$7,%hi(MenuExtended_SaveGame__FR12tMenuCommand) # high
	lw	$9,640($sp)
	addiu	$7,$7,%lo(MenuExtended_SaveGame__FR12tMenuCommand) # low
	addu	$fp,$9,12372
	.set	noreorder
	.set	nomacro
	jal	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	move	$4,$fp
	.set	macro
	.set	reorder

	li	$5,647			# 0x00000287
	move	$6,$0
	lui	$7,%hi(MenuExtended_LoadGame__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_LoadGame__FR12tMenuCommand) # low
	lw	$8,640($sp)
	la	$9,tMemoryCardMenuItem_vtable
	sw	$9,24($fp)
	addu	$16,$8,12416
	.set	noreorder
	.set	nomacro
	jal	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4128			# 0x00001020
	la	$9,tMemoryCardMenuItem_vtable
	lw	$8,640($sp)
	move	$7,$0
	sw	$9,24($16)
	li	$9,-1			# 0xffffffff
	sw	$9,24($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,32($sp)
	sw	$16,36($sp)
	sw	$fp,40($sp)
	sw	$0,44($sp)
	addu	$4,$8,12460
	lui	$8,%hi(screenMemcard) # high
	lw	$6,%lo(screenMemcard)($8)
	li	$8,46			# 0x0000002e
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$8,28($sp)
	.set	macro
	.set	reorder

	lw	$8,640($sp)
	li	$5,504			# 0x000001f8
	addu	$16,$8,12588
	.set	noreorder
	.set	nomacro
	jal	__17tUserNameMenuItemUi
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$9,640($sp)
	li	$5,504			# 0x000001f8
	addu	$9,$9,12728
	move	$4,$9
	.set	noreorder
	.set	nomacro
	jal	__17tUserNameMenuItemUi
	sw	$9,592($sp)
	.set	macro
	.set	reorder

	lw	$8,640($sp)
	li	$5,504			# 0x000001f8
	addu	$8,$8,12868
	move	$4,$8
	.set	noreorder
	.set	nomacro
	jal	__17tUserNameMenuItemUi
	sw	$8,596($sp)
	.set	macro
	.set	reorder

	li	$5,4384			# 0x00001120
	lui	$8,%hi(screenUserName) # high
	move	$7,$0
	lw	$9,640($sp)
	lw	$6,%lo(screenUserName)($8)
	li	$8,32			# 0x00000020
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$8,28($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	addu	$4,$9,13008
	li	$9,-1			# 0xffffffff
	sw	$9,24($sp)
	li	$9,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$9,32($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(screenTrophyRoom) # high
	lw	$8,640($sp)
	lw	$6,%lo(screenTrophyRoom)($9)
	addu	$18,$8,13136
	move	$4,$18
	addu	$5,$6,216
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	addu	$6,$6,204
	.set	macro
	.set	reorder

	li	$5,94			# 0x0000005e
	move	$6,$18
	lw	$8,640($sp)
	li	$7,-1			# 0xffffffff
	sw	$0,16($sp)
	addu	$16,$8,13152
	.set	noreorder
	.set	nomacro
	jal	__28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,16400			# 0x00004010
	lui	$2,%hi(tBlankMenuItemNFS4LeftRightChoice_vtable) # high
	addiu	$2,$2,%lo(tBlankMenuItemNFS4LeftRightChoice_vtable) # low
	lw	$9,640($sp)
	lui	$8,%hi(screenTrophyRoom) # high
	sw	$2,24($16)
	lw	$6,%lo(screenTrophyRoom)($8)
	move	$7,$0
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$16,28($sp)
	sw	$0,32($sp)
	addu	$4,$9,13192
	li	$9,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	__15tMenuNFS4BottomUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	sw	$9,24($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	lui	$7,%hi(MenuExtended_PinkSlipsContinue__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_PinkSlipsContinue__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$9,20($sp)
	addu	$18,$8,13316
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$18
	.set	macro
	.set	reorder

	li	$5,156			# 0x0000009c
	move	$6,$0
	lui	$7,%hi(MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,13360
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$2,%hi(screenPinkSlipStandings) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenPinkSlipStandings)($2)
	li	$9,756			# 0x000002f4
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	sw	$18,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	addu	$4,$8,13404
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$7,$0
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$9,20($sp)
	addu	$18,$8,13528
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	addu	$6,$8,4336
	.set	macro
	.set	reorder

	li	$5,155			# 0x0000009b
	move	$6,$0
	lui	$7,%hi(MenuExtended_ExitTourney__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_ExitTourney__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,13572
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$2,%hi(screenTournamentStandings3item) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenTournamentStandings3item)($2)
	li	$9,756			# 0x000002f4
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	sw	$18,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	addu	$4,$8,13616
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$7,$0
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$9,20($sp)
	addu	$16,$8,13740
	move	$4,$16
	addu	$18,$8,13908
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	move	$6,$18
	.set	macro
	.set	reorder

	li	$5,4100			# 0x00001004
	lui	$2,%hi(screenTournamentStandings) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenTournamentStandings)($2)
	li	$9,756			# 0x000002f4
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	sw	$16,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuNFS4UiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	addu	$4,$8,13784
	.set	macro
	.set	reorder

	move	$4,$18
	li	$5,32768			# 0x00008000
	lui	$2,%hi(screenTournamentTrophy) # high
	move	$7,$0
	lw	$6,%lo(screenTournamentTrophy)($2)
	lui	$2,%hi(MenuExtended_TierFinished__FR12tMenuCommand) # high
	addiu	$2,$2,%lo(MenuExtended_TierFinished__FR12tMenuCommand) # low
	li	$8,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$8,24($sp)
	.set	macro
	.set	reorder

	li	$5,4160			# 0x00001040
	lui	$8,%hi(screenUserName) # high
	move	$7,$0
	lui	$2,%hi(MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenUserName)($8)
	li	$8,32			# 0x00000020
	sw	$8,28($sp)
	lw	$8,592($sp)
	addiu	$2,$2,%lo(MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand) # low
	sw	$0,16($sp)
	sw	$2,20($sp)
	sw	$0,40($sp)
	addu	$4,$9,14032
	li	$9,-1			# 0xffffffff
	sw	$9,24($sp)
	li	$9,10			# 0x0000000a
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$8,36($sp)
	.set	macro
	.set	reorder

	li	$5,4224			# 0x00001080
	lui	$8,%hi(screenUserName) # high
	move	$7,$0
	lui	$2,%hi(MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand) # high
	lw	$9,640($sp)
	lw	$6,%lo(screenUserName)($8)
	li	$8,32			# 0x00000020
	sw	$8,28($sp)
	lw	$8,596($sp)
	addiu	$2,$2,%lo(MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand) # low
	sw	$0,16($sp)
	sw	$2,20($sp)
	sw	$0,40($sp)
	addu	$4,$9,14160
	li	$9,-1			# 0xffffffff
	sw	$9,24($sp)
	li	$9,10			# 0x0000000a
	sw	$9,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$8,36($sp)
	.set	macro
	.set	reorder

	li	$5,90			# 0x0000005a
	move	$6,$0
	lui	$7,%hi(MenuExtended_PostGameMenu__FR12tMenuCommand) # high
	addiu	$7,$7,%lo(MenuExtended_PostGameMenu__FR12tMenuCommand) # low
	lw	$9,640($sp)
	li	$8,-1			# 0xffffffff
	sw	$8,16($sp)
	addu	$16,$9,14288
	move	$4,$16
	move	$9,$8
	.set	noreorder
	.set	nomacro
	jal	__27tMenuItemGoToMenuNFS4ButtonUiP5tMenuPFR12tMenuCommand_vii
	sw	$9,20($sp)
	.set	macro
	.set	reorder

	li	$5,131072			# 0x00020000
	ori	$5,$5,0x1004
	lui	$2,%hi(tBlankMenuItemGoToMenuNFS4Button_vtable) # high
	addiu	$2,$2,%lo(tBlankMenuItemGoToMenuNFS4Button_vtable) # low
	sw	$2,24($16)
	lui	$2,%hi(screenTrackRecords) # high
	move	$7,$0
	lw	$6,%lo(screenTrackRecords)($2)
	li	$2,212			# 0x000000d4
	li	$18,1			# 0x00000001
	lw	$8,640($sp)
	li	$9,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	sw	$18,28($sp)
	sw	$9,32($sp)
	sw	$16,36($sp)
	sw	$0,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	addu	$4,$8,14332
	.set	macro
	.set	reorder

	li	$5,32768			# 0x00008000
	lui	$2,%hi(screenPinkSlipCongrats) # high
	move	$7,$0
	lw	$6,%lo(screenPinkSlipCongrats)($2)
	lui	$2,%hi(MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand) # high
	addiu	$2,$2,%lo(MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand) # low
	lw	$8,640($sp)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$2,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,14460
	.set	macro
	.set	reorder

	li	$5,32768			# 0x00008000
	lui	$2,%hi(screenBeTheCopCongrats) # high
	move	$7,$0
	lui	$16,%hi(MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand) # high
	addiu	$16,$16,%lo(MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand) # low
	lw	$8,640($sp)
	lw	$6,%lo(screenBeTheCopCongrats)($2)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$16,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,14584
	.set	macro
	.set	reorder

	li	$5,32768			# 0x00008000
	lui	$2,%hi(screenTournamentCongrats) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenTournamentCongrats)($2)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$16,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,14708
	.set	macro
	.set	reorder

	li	$5,4112			# 0x00001010
	lui	$2,%hi(screenMain) # high
	move	$7,$0
	lw	$8,640($sp)
	lw	$6,%lo(screenMain)($2)
	li	$9,-1			# 0xffffffff
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$9,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tMenuBlankUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	addu	$4,$8,14832
	.set	macro
	.set	reorder

	li	$5,650			# 0x0000028a
	move	$6,$0
	lui	$7,%hi(MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand) # high
	lw	$8,640($sp)
	addiu	$7,$7,%lo(MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand) # low
	addu	$16,$8,14956
	.set	noreorder
	.set	nomacro
	jal	__23tMenuItemGoToMenuButtonUiP5tMenuPFR12tMenuCommand_v
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,4160			# 0x00001040
	la	$8,tMemoryCardMenuItem_vtable
	lw	$9,640($sp)
	move	$7,$0
	sw	$8,24($16)
	li	$8,-1			# 0xffffffff
	sw	$8,24($sp)
	li	$8,10			# 0x0000000a
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$8,32($sp)
	sw	$16,36($sp)
	sw	$fp,40($sp)
	sw	$0,44($sp)
	addu	$4,$9,15000
	lui	$9,%hi(screenMemcard) # high
	lw	$6,%lo(screenMemcard)($9)
	li	$9,46			# 0x0000002e
	.set	noreorder
	.set	nomacro
	jal	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	sw	$9,28($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	li	$7,120			# 0x00000078
	lw	$9,640($sp)
	li	$16,5			# 0x00000005
	addu	$4,$9,9676
	addu	$2,$9,6072
	sw	$2,5912($9)
	addu	$2,$9,6488
	sw	$2,6368($9)
	addu	$2,$9,6932
	sw	$2,6812($9)
	.set	noreorder
	.set	nomacro
	jal	SetDimensions__24tMenuItemLeftRightSliderssss
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	lw	$8,640($sp)
	li	$7,120			# 0x00000078
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SetDimensions__24tMenuItemLeftRightSliderssss
	addu	$4,$8,9732
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	lw	$9,640($sp)
	li	$7,120			# 0x00000078
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SetDimensions__24tMenuItemLeftRightSliderssss
	addu	$4,$9,9788
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	lw	$8,640($sp)
	li	$7,120			# 0x00000078
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SetDimensions__24tMenuItemLeftRightSliderssss
	addu	$4,$8,9844
	.set	macro
	.set	reorder

	move	$5,$0
	move	$6,$5
	lw	$9,640($sp)
	li	$7,120			# 0x00000078
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SetDimensions__24tMenuItemLeftRightSliderssss
	addu	$4,$9,9900
	.set	macro
	.set	reorder

	lw	$8,640($sp)
	li	$9,32			# 0x00000020
	lw	$3,13740($8)
	li	$2,2			# 0x00000002
	sw	$9,6628($8)
	sw	$2,4828($8)
	sw	$18,7284($8)
	sw	$2,7636($8)
	sh	$0,10308($8)
	sh	$0,10956($8)
	sh	$18,11216($8)
	sh	$0,12560($8)
	sh	$0,13108($8)
	sh	$18,4264($8)
	sh	$0,612($8)
	ori	$3,$3,0x0040
	sw	$3,13740($8)
 #APP
 #NO_APP
	lw	$31,636($sp)
	lw	$fp,632($sp)
	lw	$23,628($sp)
	lw	$22,624($sp)
	lw	$21,620($sp)
	lw	$20,616($sp)
	lw	$19,612($sp)
	lw	$18,608($sp)
	lw	$17,604($sp)
	lw	$16,600($sp)
	move	$2,$8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,640
	.set	macro
	.set	reorder

	.end	__15tGlobalMenuDefs
	.align	2
	.globl	_._15tGlobalMenuDefs
	.ent	_._15tGlobalMenuDefs
_._15tGlobalMenuDefs:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	addu	$4,$17,15000
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14956
	.set	noreorder
	.set	nomacro
	jal	_._23tMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14832
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14708
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14584
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14460
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14332
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14288
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14160
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,14032
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13908
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13784
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13740
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13616
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13572
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13528
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13404
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13360
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13316
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13192
	.set	noreorder
	.set	nomacro
	jal	_._15tMenuNFS4Bottom
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13152
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13136
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,13008
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12868
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuItem
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12728
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuItem
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12588
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuItem
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12460
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12416
	.set	noreorder
	.set	nomacro
	jal	_._23tMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12372
	.set	noreorder
	.set	nomacro
	jal	_._23tMenuItemGoToMenuButton
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12256
	.set	noreorder
	.set	nomacro
	jal	_._14tInsideBoxMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12140
	.set	noreorder
	.set	nomacro
	jal	_._14tInsideBoxMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,12024
	.set	noreorder
	.set	nomacro
	jal	_._14tInsideBoxMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11908
	.set	noreorder
	.set	nomacro
	jal	_._14tInsideBoxMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11860
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11840
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11792
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11772
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11724
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11704
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11656
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11636
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11588
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11568
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11520
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11500
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11452
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11432
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11384
	.set	noreorder
	.set	nomacro
	jal	_._22tInsideBoxTwoWaySlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11364
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11324
	.set	noreorder
	.set	nomacro
	jal	_._25tInsideBoxLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11304
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11264
	.set	noreorder
	.set	nomacro
	jal	_._25tInsideBoxLeftRightSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11244
	.set	noreorder
	.set	nomacro
	jal	_._25tListIteratorRangeIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11116
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11048
	.set	noreorder
	.set	nomacro
	jal	_._20tMenuItemSlidingMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,11004
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10984
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10856
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10812
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10768
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10720
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10672
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10624
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10580
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10536
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10492
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10472
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10456
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10436
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10416
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10396
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10376
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10356
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10336
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10208
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10072
	.set	noreorder
	.set	nomacro
	jal	_._18tInsideBoxSongMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,10000
	.set	noreorder
	.set	nomacro
	jal	_._20tMenuItemSlidingMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9956
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9900
	.set	noreorder
	.set	nomacro
	jal	_._29tMenuItemLeftRightAudioSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9844
	.set	noreorder
	.set	nomacro
	jal	_._29tMenuItemLeftRightAudioSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9788
	.set	noreorder
	.set	nomacro
	jal	_._29tMenuItemLeftRightAudioSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9732
	.set	noreorder
	.set	nomacro
	jal	_._29tMenuItemLeftRightAudioSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9676
	.set	noreorder
	.set	nomacro
	jal	_._29tMenuItemLeftRightAudioSlider
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9660
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9644
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9628
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9612
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9596
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9580
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorRange
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9456
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9412
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9368
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9324
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9280
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9236
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9192
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,9068
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8936
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8804
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8672
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8540
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8408
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8376
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8344
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8312
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8280
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8248
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8216
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8184
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8168
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8152
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8132
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,8112
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7988
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7944
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7900
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7856
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7732
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7688
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7648
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7620
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7496
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7452
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7408
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7368
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7328
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7296
	.set	noreorder
	.set	nomacro
	jal	_._21tListIteratorCarColor
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7268
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7144
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7100
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,7056
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6932
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6892
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6848
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6724
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6684
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6640
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6612
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6488
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6448
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6404
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6280
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6240
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6196
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6072
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,6032
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5992
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5948
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5824
	.set	noreorder
	.set	nomacro
	jal	_._18tMenuNFS4TwoPlayer
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5784
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5744
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5700
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5576
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5452
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5412
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5368
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5328
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5288
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5244
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5216
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,5092
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4968
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4924
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4880
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4840
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4812
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4688
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4644
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4604
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4564
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4520
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4488
	.set	noreorder
	.set	nomacro
	jal	_._21tListIteratorCarColor
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4460
	.set	noreorder
	.set	nomacro
	jal	_._16tListIteratorCar
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4336
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4292
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4164
	.set	noreorder
	.set	nomacro
	jal	_._12tOptionsMenu
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,4120
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3988
	.set	noreorder
	.set	nomacro
	jal	_._12tMenuOptions
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3952
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3916
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3880
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3844
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3808
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3776
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3744
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3728
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3708
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3688
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3668
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3648
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3628
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3608
	.set	noreorder
	.set	nomacro
	jal	_._20tListIteratorIndexed
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3484
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3360
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3316
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3276
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3232
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3208
	.set	noreorder
	.set	nomacro
	jal	_._18tListIteratorTrack
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,3084
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2960
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2920
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2880
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2840
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2800
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2760
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2716
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2592
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2548
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2504
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2460
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2336
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2292
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2248
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2204
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2160
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,2036
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1996
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1952
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1932
	.set	noreorder
	.set	nomacro
	jal	_._23tListIteratorTournament
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1808
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1768
	.set	noreorder
	.set	nomacro
	jal	_._28tMenuItemNFS4LeftRightChoice
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1724
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1704
	.set	noreorder
	.set	nomacro
	jal	_._23tListIteratorTournament
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1580
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1536
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1492
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1368
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1324
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1280
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1236
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1112
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1068
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,1024
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,980
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,936
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,892
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,768
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,724
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,680
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,636
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,512
	.set	noreorder
	.set	nomacro
	jal	_._10tMenuBlank
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,388
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,344
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,300
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,176
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuNFS4
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,132
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,88
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$17,44
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	_._27tMenuItemGoToMenuNFS4Button
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	andi	$16,$16,0x0001
	beq	$16,$0,$L1560
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L1560:
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

	.end	_._15tGlobalMenuDefs
	.align	2
	.globl	TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button
	.ent	TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button
TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button
	.align	2
	.globl	Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib
	.ent	Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib
Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib
	.align	2
	.globl	Draw__32tBlankMenuItemGoToMenuNFS4Buttonb
	.ent	Draw__32tBlankMenuItemGoToMenuNFS4Buttonb
Draw__32tBlankMenuItemGoToMenuNFS4Buttonb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Draw__32tBlankMenuItemGoToMenuNFS4Buttonb
	.align	2
	.globl	___32tBlankMenuItemGoToMenuNFS4Button
	.ent	___32tBlankMenuItemGoToMenuNFS4Button
___32tBlankMenuItemGoToMenuNFS4Button:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___27tMenuItemGoToMenuNFS4Button
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___32tBlankMenuItemGoToMenuNFS4Button
	.align	2
	.globl	TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice
	.ent	TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice
TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice
	.align	2
	.globl	Draw__33tBlankMenuItemNFS4LeftRightChoiceiib
	.ent	Draw__33tBlankMenuItemNFS4LeftRightChoiceiib
Draw__33tBlankMenuItemNFS4LeftRightChoiceiib:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Draw__33tBlankMenuItemNFS4LeftRightChoiceiib
	.align	2
	.globl	___33tBlankMenuItemNFS4LeftRightChoice
	.ent	___33tBlankMenuItemNFS4LeftRightChoice
___33tBlankMenuItemNFS4LeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___28tMenuItemNFS4LeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___33tBlankMenuItemNFS4LeftRightChoice
	.globl	menuDefs
	.data
	.align	2
menuDefs:
	.space	4
	.globl	SelectListNull
	.align	2
SelectListNull:
	.space	4
