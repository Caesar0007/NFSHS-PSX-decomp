	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\pausemenu.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	PauseMenu_FullText__FPcsss
	.align	2
	.globl	PauseMenu_MenuTextPositioned__Fssss
	.align	2
	.globl	PauseMenu_MenuText__FsbT1
	.align	2
	.globl	__14tPListIteratorPsPi
	.align	2
	.globl	_._14tPListIterator
	.align	2
	.globl	Value__14tPListIterator7tPlayer
	.align	2
	.globl	TextValue__14tPListIterator7tPlayer
	.align	2
	.globl	Increment__14tPListIterator7tPlayer
	.align	2
	.globl	Decrement__14tPListIterator7tPlayer
	.align	2
	.globl	__21tPListIteratorIndexedPsPiPc
	.align	2
	.globl	_._21tPListIteratorIndexed
	.align	2
	.globl	Value__21tPListIteratorIndexed7tPlayer
	.align	2
	.globl	TextValue__21tPListIteratorIndexed7tPlayer
	.align	2
	.globl	Increment__21tPListIteratorIndexed7tPlayer
	.align	2
	.globl	Decrement__21tPListIteratorIndexed7tPlayer
	.align	2
	.globl	__10tPMenuItemUi
	.align	2
	.globl	_._10tPMenuItem
	.align	2
	.globl	NextMenu__10tPMenuItem
	.align	2
	.globl	Debounce__10tPMenuItem
	.align	2
	.globl	ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	__28tPMenuItemNonInteractiveTextUi
	.align	2
	.globl	_._28tPMenuItemNonInteractiveText
	.align	2
	.globl	Draw__28tPMenuItemNonInteractiveTextb
	.align	2
	.globl	__21tPMenuItemInteractiveUi
	.align	2
	.globl	_._21tPMenuItemInteractive
	.align	2
	.globl	Draw__21tPMenuItemInteractiveb
	.align	2
	.globl	__25tPMenuItemLeftRightChoiceUiP14tPListIterator
	.align	2
	.globl	_._25tPMenuItemLeftRightChoice
	.align	2
	.globl	ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	Draw__25tPMenuItemLeftRightChoiceb
	.align	2
	.globl	__25tPMenuItemLeftRightSliderUiPic
	.align	2
	.globl	_._25tPMenuItemLeftRightSlider
	.align	2
	.globl	Debounce__25tPMenuItemLeftRightSlider
	.align	2
	.globl	ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	Draw__25tPMenuItemLeftRightSliderb
	.align	2
	.globl	__32tPMenuItemLeftRightSliderIndexedUiPicPc
	.align	2
	.globl	_._32tPMenuItemLeftRightSliderIndexed
	.align	2
	.globl	ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	Draw__32tPMenuItemLeftRightSliderIndexedb
	.align	2
	.globl	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
	.align	2
	.globl	_._24tPMenuItemGoToMenuButton
	.align	2
	.globl	NextMenu__24tPMenuItemGoToMenuButton
	.align	2
	.globl	ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	.align	2
	.globl	_._23tPMenuItemCommandButton
	.align	2
	.globl	ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	tPMenuConstructor__6tPMenuP10tPMenuItemPv
	.align	2
	.globl	__6tPMenuP10tPMenuIteme
	.align	2
	.globl	_._6tPMenu
	.align	2
	.globl	Initialize__6tPMenu
	.align	2
	.globl	Debounce__6tPMenu
	.align	2
	.globl	CheckForDisabled__6tPMenu
	.align	2
	.globl	ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand
	.align	2
	.globl	Draw__6tPMenu
	.align	2
	.globl	NumEnabledItems__6tPMenu
	.align	2
	.globl	ItemEnabledNum__6tPMenui
	.align	2
	.globl	IsNavigable__21tPMenuItemInteractive
	.align	2
	.globl	IsNavigable__28tPMenuItemNonInteractiveText
	.align	2
	.globl	IsEnabled__10tPMenuItem
	.align	2
	.globl	IsDisabled__10tPMenuItem

	.lcomm	gPause_CurrentY,4

	.extern	GameSetup_gData, 2600
	.extern	gMPauseUpdateNextTime, 4

	.text
	.text
	.ent	PauseMenu_FullText__FPcsss
PauseMenu_FullText__FPcsss:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$18,24($sp)
	move	$18,$7
	sw	$17,20($sp)
	move	$17,$4
	lw	$3,gPause_CurrentY
	li	$2,98			# 0x00000062
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L601
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	li	$16,160			# 0x000000a0
	li	$6,2			# 0x00000002
	li	$18,6			# 0x00000006
$L601:
	sll	$2,$6,16
	sra	$3,$2,16
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L602
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L603
	subu	$16,$16,$2
	.set	macro
	.set	reorder

$L602:
	bne	$3,$2,$L603
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$17
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	sra	$3,$3,1
	subu	$16,$16,$3
$L603:
	sll	$4,$18,16
	.set	noreorder
	.set	nomacro
	jal	Font_TextColor__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$5,$16,16
	lw	$6,gPause_CurrentY
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	sra	$5,$5,16
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

	.end	PauseMenu_FullText__FPcsss
	.text
	.ent	PauseMenu_MenuTextPositioned__Fssss
PauseMenu_MenuTextPositioned__Fssss:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$7
	sw	$16,16($sp)
	sll	$16,$4,16
	sra	$16,$16,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	sll	$17,$17,16
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L606
	li	$7,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$7,3			# 0x00000003
$L606:
	move	$4,$2
	sll	$5,$18,16
	sll	$6,$16,16
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_FullText__FPcsss
	sra	$6,$6,16
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

	.end	PauseMenu_MenuTextPositioned__Fssss
	.text
	.ent	PauseMenu_MenuText__FsbT1
PauseMenu_MenuText__FsbT1:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	sll	$16,$4,16
	sra	$16,$16,16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$17,$17,16
	sll	$18,$18,16
	sll	$2,$2,16
	sra	$5,$17,16
	sra	$6,$18,16
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuTextPositioned__Fssss
	sra	$7,$2,16
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

	.end	PauseMenu_MenuText__FsbT1
	.text
	.ent	__14tPListIteratorPsPi
__14tPListIteratorPsPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(tPListIterator_vtable) # high
	addiu	$3,$3,%lo(tPListIterator_vtable) # low
	sw	$3,8($2)
	sw	$5,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,4($2)
	.set	macro
	.set	reorder

	.end	__14tPListIteratorPsPi
	.text
	.ent	_._14tPListIterator
_._14tPListIterator:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPListIterator_vtable) # high
	addiu	$2,$2,%lo(tPListIterator_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L613
	sw	$2,8($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L613:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._14tPListIterator
	.text
	.ent	Value__14tPListIterator7tPlayer
Value__14tPListIterator7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	lw	$2,0($2)
	j	$31
	.end	Value__14tPListIterator7tPlayer
	.text
	.ent	TextValue__14tPListIterator7tPlayer
TextValue__14tPListIterator7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,8($16)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__14tPListIterator7tPlayer
	.text
	.ent	Increment__14tPListIterator7tPlayer
Increment__14tPListIterator7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,4($4)
	#nop
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	lw	$5,4($4)
	#nop
	lw	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L617
	sw	$0,0($5)
$L617:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,gMPauseUpdateNextTime
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Increment__14tPListIterator7tPlayer
	.text
	.ent	Decrement__14tPListIterator7tPlayer
Decrement__14tPListIterator7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,4($4)
	#nop
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	move	$5,$3
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	lh	$2,2($2)
	#nop
	blez	$2,$L624
$L622:
	lw	$2,0($5)
	#nop
	addu	$2,$2,1
	sw	$2,0($5)
	lw	$5,4($4)
	#nop
	lw	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	blez	$2,$L624
	j	$L622
$L619:
	addu	$2,$2,-1
	sw	$2,0($3)
$L624:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,gMPauseUpdateNextTime
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Decrement__14tPListIterator7tPlayer
	.text
	.ent	__21tPListIteratorIndexedPsPiPc
__21tPListIteratorIndexedPsPiPc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__14tPListIteratorPsPi
	move	$17,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPListIteratorIndexed_vtable) # high
	addiu	$3,$3,%lo(tPListIteratorIndexed_vtable) # low
	sw	$3,8($2)
	sw	$17,12($2)
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

	.end	__21tPListIteratorIndexedPsPiPc
	.text
	.ent	_._21tPListIteratorIndexed
_._21tPListIteratorIndexed:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPListIteratorIndexed_vtable) # high
	addiu	$2,$2,%lo(tPListIteratorIndexed_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._14tPListIterator
	sw	$2,8($4)
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

	.end	_._21tPListIteratorIndexed
	.text
	.ent	Value__21tPListIteratorIndexed7tPlayer
Value__21tPListIteratorIndexed7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,12($4)
	#nop
	lbu	$2,0($2)
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	j	$31
	.end	Value__21tPListIteratorIndexed7tPlayer
	.text
	.ent	TextValue__21tPListIteratorIndexed7tPlayer
TextValue__21tPListIteratorIndexed7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,8($16)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	sll	$2,$2,1
	lw	$3,0($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TextValue__21tPListIteratorIndexed7tPlayer
	.text
	.ent	Increment__21tPListIteratorIndexed7tPlayer
Increment__21tPListIteratorIndexed7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,12($4)
	#nop
	lbu	$3,0($2)
	lw	$2,4($4)
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	lw	$2,12($4)
	#nop
	lbu	$2,0($2)
	lw	$3,4($4)
	sll	$2,$2,2
	addu	$5,$2,$3
	lw	$2,0($5)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,0($2)
	#nop
	bne	$2,$0,$L632
	sw	$0,0($5)
$L632:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,gMPauseUpdateNextTime
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Increment__21tPListIteratorIndexed7tPlayer
	.text
	.ent	Decrement__21tPListIteratorIndexed7tPlayer
Decrement__21tPListIteratorIndexed7tPlayer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$6,12($4)
	#nop
	lbu	$2,0($6)
	lw	$5,4($4)
	sll	$2,$2,2
	addu	$3,$2,$5
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	lh	$2,2($2)
	#nop
	blez	$2,$L639
$L637:
	lbu	$3,0($6)
	#nop
	sll	$3,$3,2
	addu	$3,$3,$5
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	lw	$6,12($4)
	#nop
	lbu	$2,0($6)
	lw	$5,4($4)
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$2,0($2)
	lw	$3,0($4)
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$2,2($2)
	#nop
	blez	$2,$L639
	j	$L637
$L634:
	sw	$2,0($3)
$L639:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,gMPauseUpdateNextTime
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Decrement__21tPListIteratorIndexed7tPlayer
	.text
	.ent	__10tPMenuItemUi
__10tPMenuItemUi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$2,$4
	lui	$3,%hi(tPMenuItem_vtable) # high
	addiu	$3,$3,%lo(tPMenuItem_vtable) # low
	sw	$3,8($2)
	sw	$5,4($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($2)
	.set	macro
	.set	reorder

	.end	__10tPMenuItemUi
	.text
	.ent	_._10tPMenuItem
_._10tPMenuItem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItem_vtable) # high
	addiu	$2,$2,%lo(tPMenuItem_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L645
	sw	$2,8($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L645:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._10tPMenuItem
	.text
	.ent	NextMenu__10tPMenuItem
NextMenu__10tPMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	NextMenu__10tPMenuItem
	.text
	.ent	Debounce__10tPMenuItem
Debounce__10tPMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	Debounce__10tPMenuItem
	.text
	.ent	ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand
ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	__28tPMenuItemNonInteractiveTextUi
__28tPMenuItemNonInteractiveTextUi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tPMenuItemUi
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(tPMenuItemNonInteractiveText_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemNonInteractiveText_vtable) # low
	sw	$2,8($16)
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__28tPMenuItemNonInteractiveTextUi
	.text
	.ent	_._28tPMenuItemNonInteractiveText
_._28tPMenuItemNonInteractiveText:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemNonInteractiveText_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemNonInteractiveText_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._10tPMenuItem
	sw	$2,8($4)
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

	.end	_._28tPMenuItemNonInteractiveText
	.text
	.ent	Draw__28tPMenuItemNonInteractiveTextb
Draw__28tPMenuItemNonInteractiveTextb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$5,$0
	sw	$31,16($sp)
	lh	$4,4($4)
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuText__FsbT1
	move	$6,$5
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

	.end	Draw__28tPMenuItemNonInteractiveTextb
	.text
	.ent	__21tPMenuItemInteractiveUi
__21tPMenuItemInteractiveUi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__10tPMenuItemUi
	move	$16,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(tPMenuItemInteractive_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemInteractive_vtable) # low
	sw	$2,8($16)
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__21tPMenuItemInteractiveUi
	.text
	.ent	_._21tPMenuItemInteractive
_._21tPMenuItemInteractive:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemInteractive_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemInteractive_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._10tPMenuItem
	sw	$2,8($4)
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

	.end	_._21tPMenuItemInteractive
	.text
	.ent	Draw__21tPMenuItemInteractiveb
Draw__21tPMenuItemInteractiveb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$6,0($4)
	lh	$4,4($4)
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuText__FsbT1
	andi	$6,$6,0x0001
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

	.end	Draw__21tPMenuItemInteractiveb
	.text
	.ent	__25tPMenuItemLeftRightChoiceUiP14tPListIterator
__25tPMenuItemLeftRightChoiceUiP14tPListIterator:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__21tPMenuItemInteractiveUi
	move	$17,$6
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPMenuItemLeftRightChoice_vtable) # high
	addiu	$3,$3,%lo(tPMenuItemLeftRightChoice_vtable) # low
	sw	$3,8($2)
	sw	$17,12($2)
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

	.end	__25tPMenuItemLeftRightChoiceUiP14tPListIterator
	.text
	.ent	_._25tPMenuItemLeftRightChoice
_._25tPMenuItemLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemLeftRightChoice_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemLeftRightChoice_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._21tPMenuItemInteractive
	sw	$2,8($4)
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

	.end	_._25tPMenuItemLeftRightChoice
	.text
	.ent	ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand
ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	lw	$3,0($16)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L665
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L667
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	j	$L670
$L665:
	lw	$3,12($4)
	#nop
	lw	$2,8($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	.set	noreorder
	.set	nomacro
	j	$L671
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L667:
	lw	$3,12($4)
	#nop
	lw	$2,8($3)
	#nop
	lh	$4,32($2)
	lw	$2,36($2)
$L671:
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,0($16)
$L670:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	Draw__25tPMenuItemLeftRightChoiceb
Draw__25tPMenuItemLeftRightChoiceb:
	.frame	$sp,64,$31		# vars= 0, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$17,28($sp)
	move	$17,$4
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$18,$5
	.set	macro
	.set	reorder

	sll	$16,$18,16
	sra	$16,$16,16
	move	$5,$16
	sll	$2,$2,16
	sra	$7,$2,16
	#.set	volatile
	lw	$6,0($17)
	#.set	novolatile
	lh	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuTextPositioned__Fssss
	andi	$6,$6,0x0001
	.set	macro
	.set	reorder

	lw	$3,12($17)
	#nop
	lw	$2,8($3)
	li	$5,-1			# 0xffffffff
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$19,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$4,$19
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$16
	sll	$2,$2,16
	sra	$23,$2,16
	#.set	volatile
	lw	$6,0($17)
	#.set	novolatile
	move	$7,$23
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuTextPositioned__Fssss
	andi	$6,$6,0x0001
	.set	macro
	.set	reorder

	lw	$17,gPause_CurrentY
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L674
	lui	$2,%hi(GameSetup_gData+224) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+224)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	li	$20,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$20,$20,0x0004
	li	$18,16711680			# 0x00ff0000
	ori	$18,$18,0xffff
	move	$4,$19
	li	$22,528482304			# 0x1f800000
	li	$19,-16777216			# 0xff000000
	lw	$16,0($20)
	lw	$5,0($22)
	lw	$3,0($16)
	lw	$2,0($5)
	and	$3,$3,$19
	and	$2,$2,$18
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$2,0($5)
	addu	$3,$16,52
	sw	$3,0($20)
	and	$3,$16,$18
	and	$2,$2,$19
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sw	$2,0($5)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$16,%hi(HudPmx_gShapes+360) # high
	addiu	$16,$16,%lo(HudPmx_gShapes+360) # low
	move	$5,$16
	subu	$2,$23,$2
	addu	$6,$2,-8
	addu	$17,$17,5
	move	$7,$17
	li	$21,48830			# 0x0000bebe
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
	sw	$21,16($sp)
	.set	macro
	.set	reorder

	addu	$5,$16,20
	addu	$6,$23,4
	move	$7,$17
	lw	$16,0($20)
	lw	$8,0($22)
	move	$4,$16
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$19
	and	$2,$2,$18
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($8)
	addu	$3,$4,52
	sw	$3,0($20)
	and	$3,$4,$18
	and	$2,$2,$19
	or	$2,$2,$3
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
	sw	$21,16($sp)
	.set	macro
	.set	reorder

$L674:
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

	.end	Draw__25tPMenuItemLeftRightChoiceb
	.text
	.ent	__25tPMenuItemLeftRightSliderUiPic
__25tPMenuItemLeftRightSliderUiPic:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__21tPMenuItemInteractiveUi
	move	$18,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPMenuItemLeftRightSlider_vtable) # high
	addiu	$3,$3,%lo(tPMenuItemLeftRightSlider_vtable) # low
	sw	$3,8($2)
	sw	$17,12($2)
	sb	$18,16($2)
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

	.end	__25tPMenuItemLeftRightSliderUiPic
	.text
	.ent	_._25tPMenuItemLeftRightSlider
_._25tPMenuItemLeftRightSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemLeftRightSlider_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemLeftRightSlider_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._21tPMenuItemInteractive
	sw	$2,8($4)
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

	.end	_._25tPMenuItemLeftRightSlider
	.text
	.ent	Debounce__25tPMenuItemLeftRightSlider
Debounce__25tPMenuItemLeftRightSlider:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Debounce__25tPMenuItemLeftRightSlider
	.text
	.ent	ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($5)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L682
	move	$6,$0
	.set	macro
	.set	reorder

	li	$2,4096			# 0x00001000
	beq	$3,$2,$L684
	j	$L685
$L682:
	lw	$2,12($4)
	#nop
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L689
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,gMPauseUpdateNextTime
	lbu	$3,16($4)
	li	$2,-2004318071			# 0x88888889
	multu	$3,$2
	lw	$4,12($4)
	#nop
	lw	$3,0($4)
	mfhi	$7
	#nop
	#nop
	srl	$2,$7,4
	andi	$2,$2,0x00ff
	subu	$3,$3,$2
	bgez	$3,$L687
	move	$3,$0
$L687:
	.set	noreorder
	.set	nomacro
	j	$L688
	sw	$3,0($4)
	.set	macro
	.set	reorder

$L684:
	lw	$2,12($4)
	lbu	$3,16($4)
	lw	$2,0($2)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,gMPauseUpdateNextTime
	lbu	$3,16($4)
	li	$2,-2004318071			# 0x88888889
	multu	$3,$2
	lw	$4,12($4)
	move	$6,$3
	lw	$3,0($4)
	mfhi	$7
	#nop
	#nop
	srl	$2,$7,4
	andi	$2,$2,0x00ff
	addu	$3,$3,$2
	slt	$2,$6,$3
	bne	$2,$0,$L691
	move	$6,$3
$L691:
	sw	$6,0($4)
$L688:
	li	$6,1			# 0x00000001
$L689:
	li	$2,1			# 0x00000001
	sw	$2,0($5)
$L685:
	beq	$6,$0,$L680
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

$L680:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	Draw__25tPMenuItemLeftRightSliderb
Draw__25tPMenuItemLeftRightSliderb:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$21,60($sp)
	move	$21,$0
	sw	$20,56($sp)
	li	$20,528482304			# 0x1f800000
	ori	$20,$20,0x0004
	sw	$17,44($sp)
	li	$17,16711680			# 0x00ff0000
	ori	$17,$17,0xffff
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$16,40($sp)
	sw	$4,80($sp)
	sw	$5,84($sp)
	lw	$4,4($4)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$23,$21
	.set	macro
	.set	reorder

	sll	$7,$2,16
	sra	$7,$7,16
	lw	$9,84($sp)
	move	$22,$7
	sll	$5,$9,16
	lw	$9,80($sp)
	lhu	$19,gPause_CurrentY
	#.set	volatile
	lw	$6,0($9)
	#.set	novolatile
	lh	$4,4($9)
	sra	$5,$5,16
	sh	$2,32($sp)
	.set	noreorder
	.set	nomacro
	jal	PauseMenu_MenuTextPositioned__Fssss
	andi	$6,$6,0x0001
	.set	macro
	.set	reorder

	addu	$19,$19,4
$L696:
	slt	$2,$21,15
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	li	$18,3276800			# 0x00320000
	.set	macro
	.set	reorder

	lw	$9,80($sp)
	#nop
	lw	$2,12($9)
	#nop
	lw	$4,0($2)
	lbu	$3,16($9)
	sll	$2,$4,4
	subu	$2,$2,$4
	div	$2,$2,$3
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	ori	$18,$18,0x3232
	.set	macro
	.set	reorder

	addu	$fp,$23,66
 #APP
 #NO_APP
	addu	$fp,$fp,$22
	li	$18,8388608			# 0x00800000
	lw	$9,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L701
	ori	$18,$18,0x8080
	.set	macro
	.set	reorder

	li	$18,48830			# 0x0000bebe
$L699:
	lw	$9,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L701
	lui	$2,%hi(GameSetup_gData+224) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(GameSetup_gData+224)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L703
	move	$4,$0
	.set	macro
	.set	reorder

	la	$5,HudPmx_gShapes+360
	addu	$6,$22,53
	sll	$16,$19,16
	sra	$16,$16,16
	addu	$16,$16,2
	move	$7,$16
	li	$9,-16777216			# 0xff000000
	lw	$4,0($20)
	lw	$8,528482304
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$9
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($8)
	addu	$2,$4,52
	sw	$2,0($20)
	and	$2,$4,$17
	and	$3,$3,$9
	or	$3,$3,$2
	sw	$3,0($8)
	li	$9,48830			# 0x0000bebe
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
	sw	$9,16($sp)
	.set	macro
	.set	reorder

	lui	$9,%hi(HudPmx_gShapes+360) # high
	addiu	$9,$9,%lo(HudPmx_gShapes+360) # low
	addu	$5,$9,20
	addu	$6,$22,144
	move	$7,$16
	li	$9,-16777216			# 0xff000000
	lw	$4,0($20)
	lw	$8,528482304
	lw	$3,0($4)
	lw	$2,0($8)
	and	$3,$3,$9
	and	$2,$2,$17
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($8)
	addu	$2,$4,52
	sw	$2,0($20)
	and	$2,$4,$17
	and	$3,$3,$9
	or	$3,$3,$2
	sw	$3,0($8)
	li	$9,48830			# 0x0000bebe
	.set	noreorder
	.set	nomacro
	jal	Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
	sw	$9,16($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
$L701:
	move	$4,$0
$L703:
	move	$5,$fp
	sll	$6,$19,16
	sra	$6,$6,16
	addu	$6,$6,2
	li	$7,3			# 0x00000003
	li	$2,5			# 0x00000005
	sw	$2,16($sp)
	sw	$18,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$23,$23,5
	.set	noreorder
	.set	nomacro
	j	$L696
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L697:
	move	$4,$0
	sll	$6,$19,16
	sra	$6,$6,16
	addu	$6,$6,1
	li	$7,79			# 0x0000004f
	lhu	$9,32($sp)
	li	$2,7			# 0x00000007
	sw	$2,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	sll	$5,$9,16
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	addu	$5,$5,63
	.set	macro
	.set	reorder

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

	.end	Draw__25tPMenuItemLeftRightSliderb
	.text
	.ent	__32tPMenuItemLeftRightSliderIndexedUiPicPc
__32tPMenuItemLeftRightSliderIndexedUiPicPc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	lw	$17,48($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__25tPMenuItemLeftRightSliderUiPic
	andi	$7,$7,0x00ff
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPMenuItemLeftRightSliderIndexed_vtable) # high
	addiu	$3,$3,%lo(tPMenuItemLeftRightSliderIndexed_vtable) # low
	sw	$3,8($2)
	sw	$17,20($2)
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

	.end	__32tPMenuItemLeftRightSliderIndexedUiPicPc
	.text
	.ent	_._32tPMenuItemLeftRightSliderIndexed
_._32tPMenuItemLeftRightSliderIndexed:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemLeftRightSliderIndexed_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemLeftRightSliderIndexed_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._25tPMenuItemLeftRightSlider
	sw	$2,8($4)
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

	.end	_._32tPMenuItemLeftRightSliderIndexed
	.text
	.ent	ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand
ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,20($16)
	#nop
	lbu	$2,0($2)
	lw	$17,12($16)
	sll	$2,$2,2
	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand
	sw	$2,12($16)
	.set	macro
	.set	reorder

	sw	$17,12($16)
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

	.end	ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	Draw__32tPMenuItemLeftRightSliderIndexedb
Draw__32tPMenuItemLeftRightSliderIndexedb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,20($16)
	#nop
	lbu	$2,0($2)
	lw	$17,12($16)
	sll	$2,$2,2
	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	jal	Draw__25tPMenuItemLeftRightSliderb
	sw	$2,12($16)
	.set	macro
	.set	reorder

	sw	$17,12($16)
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

	.end	Draw__32tPMenuItemLeftRightSliderIndexedb
	.text
	.ent	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__21tPMenuItemInteractiveUi
	move	$18,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPMenuItemGoToMenuButton_vtable) # high
	addiu	$3,$3,%lo(tPMenuItemGoToMenuButton_vtable) # low
	sw	$3,8($2)
	sw	$17,12($2)
	sw	$18,16($2)
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

	.end	__24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v
	.text
	.ent	_._24tPMenuItemGoToMenuButton
_._24tPMenuItemGoToMenuButton:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemGoToMenuButton_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemGoToMenuButton_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._21tPMenuItemInteractive
	sw	$2,8($4)
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

	.end	_._24tPMenuItemGoToMenuButton
	.text
	.ent	NextMenu__24tPMenuItemGoToMenuButton
NextMenu__24tPMenuItemGoToMenuButton:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,12($4)
	j	$31
	.end	NextMenu__24tPMenuItemGoToMenuButton
	.text
	.ent	ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand
ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	sw	$31,28($sp)
	lw	$3,0($18)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L715
	move	$17,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L717
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	sw	$2,0($17)
	lw	$2,8($16)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	sw	$2,4($17)
$L717:
	lw	$2,16($16)
	#nop
	beq	$2,$0,$L718
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$17
	.set	macro
	.set	reorder

$L718:
	li	$2,1			# 0x00000001
	sw	$2,0($18)
$L715:
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

	.end	ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	__23tPMenuItemCommandButtonUi17tPMenuCommandType
__23tPMenuItemCommandButtonUi17tPMenuCommandType:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__21tPMenuItemInteractiveUi
	move	$17,$6
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tPMenuItemCommandButton_vtable) # high
	addiu	$3,$3,%lo(tPMenuItemCommandButton_vtable) # low
	sw	$3,8($2)
	sw	$17,12($2)
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

	.end	__23tPMenuItemCommandButtonUi17tPMenuCommandType
	.text
	.ent	_._23tPMenuItemCommandButton
_._23tPMenuItemCommandButton:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenuItemCommandButton_vtable) # high
	addiu	$2,$2,%lo(tPMenuItemCommandButton_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._21tPMenuItemInteractive
	sw	$2,8($4)
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

	.end	_._23tPMenuItemCommandButton
	.text
	.ent	ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand
ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	sw	$31,28($sp)
	lw	$3,0($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L723
	move	$18,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	sw	$2,0($18)
	li	$2,1			# 0x00000001
	sw	$2,0($17)
$L723:
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

	.end	ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	tPMenuConstructor__6tPMenuP10tPMenuItemPv
tPMenuConstructor__6tPMenuP10tPMenuItemPv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$6,$6,4
	sw	$5,8($4)
	sw	$0,76($4)
	lw	$2,-4($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L731
	sw	$2,12($4)
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
$L727:
	addu	$5,$5,4
	lw	$2,76($4)
	addu	$6,$6,4
	addu	$2,$2,1
	sw	$2,76($4)
	lw	$3,-4($6)
	addu	$2,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L727
	sw	$3,8($2)
	.set	macro
	.set	reorder

$L731:
	j	$31
	.end	tPMenuConstructor__6tPMenuP10tPMenuItemPv
	.text
	.ent	__6tPMenuP10tPMenuIteme
__6tPMenuP10tPMenuIteme:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	sw	$5,4($sp)
	sw	$6,8($sp)
	sw	$7,12($sp)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(tPMenu_vtable) # high
	addiu	$2,$2,%lo(tPMenu_vtable) # low
	addu	$6,$sp,32
	sw	$31,20($sp)
	sw	$5,28($sp)
	sw	$2,80($16)
	.set	noreorder
	.set	nomacro
	jal	tPMenuConstructor__6tPMenuP10tPMenuItemPv
	sw	$0,0($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__6tPMenuP10tPMenuIteme
	.text
	.ent	_._6tPMenu
_._6tPMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tPMenu_vtable) # high
	addiu	$2,$2,%lo(tPMenu_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L737
	sw	$2,80($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L737:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._6tPMenu
	.text
	.ent	Initialize__6tPMenu
Initialize__6tPMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	sw	$0,0($17)
	lw	$2,0($17)
	li	$3,1			# 0x00000001
	sw	$3,4($17)
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$3,8($2)
	#nop
	lw	$2,0($3)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L739
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,8($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sltu	$4,$0,$2
$L739:
	bne	$4,$0,$L738
$L741:
	lw	$2,0($17)
	#nop
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$3,8($2)
	#nop
	beq	$3,$0,$L738
	lw	$2,0($3)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L746
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$2,8($3)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	bne	$2,$0,$L745
$L746:
	li	$16,1			# 0x00000001
$L745:
	beq	$16,$0,$L738
	lw	$2,0($17)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L741
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L738:
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

	.end	Initialize__6tPMenu
	.text
	.ent	Debounce__6tPMenu
Debounce__6tPMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,0($4)
	#nop
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$3,8($4)
	#nop
	lw	$2,8($3)
	#nop
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
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

	.end	Debounce__6tPMenu
	.text
	.ent	CheckForDisabled__6tPMenu
CheckForDisabled__6tPMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
$L752:
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,8($2)
	#nop
	lw	$2,8($3)
	move	$17,$0
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L754
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L753
$L754:
	li	$17,1			# 0x00000001
$L753:
	beq	$17,$0,$L749
	lw	$2,0($16)
	#nop
	blez	$2,$L756
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L752
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L756:
	addu	$2,$2,1
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	beq	$2,$0,$L752
$L759:
	lw	$2,0($16)
	#nop
	addu	$3,$2,1
	addu	$2,$2,2
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$3,0($16)
	lw	$2,8($2)
	#nop
	bne	$2,$0,$L759
	j	$L752
$L749:
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

	.end	CheckForDisabled__6tPMenu
	.text
	.ent	ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand
ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$2,0($16)
	move	$18,$5
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,8($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L765
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$2,8($3)
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

$L765:
	lw	$3,0($18)
	li	$2,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L767
	slt	$2,$3,513
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	beq	$3,$2,$L790
	j	$L764
$L793:
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L781
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	beq	$3,$2,$L789
	j	$L764
$L767:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

$L768:
	lw	$2,0($16)
	#nop
	blez	$2,$L771
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L772
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L771:
	addu	$2,$2,1
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	beq	$2,$0,$L772
$L774:
	lw	$2,0($16)
	#nop
	addu	$3,$2,1
	addu	$2,$2,2
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$3,0($16)
	lw	$2,8($2)
	#nop
	bne	$2,$0,$L774
$L772:
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,8($2)
	#nop
	lw	$2,8($3)
	move	$17,$0
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L779
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L770
$L779:
	li	$17,1			# 0x00000001
$L770:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L768
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L764
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L781:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

$L782:
	lw	$2,0($16)
	#nop
	addu	$2,$2,1
	sw	$2,0($16)
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	bne	$2,$0,$L785
	sw	$0,0($16)
$L785:
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,8($2)
	#nop
	lw	$2,8($3)
	move	$17,$0
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	beq	$2,$0,$L787
	lw	$2,0($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L784
$L787:
	li	$17,1			# 0x00000001
$L784:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L782
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L764
	sw	$2,0($18)
	.set	macro
	.set	reorder

$L789:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L796
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L790:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayPauseSound__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sw	$2,0($17)
	li	$2,1			# 0x00000001
$L796:
	sw	$2,0($18)
$L764:
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

	.end	ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand
	.text
	.ent	Draw__6tPMenu
Draw__6tPMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	CheckForDisabled__6tPMenu
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$6,8($17)
	li	$16,1			# 0x00000001
	lw	$3,8($6)
	li	$2,98			# 0x00000062
	sw	$2,gPause_CurrentY
	lh	$4,48($3)
	lw	$2,52($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	li	$2,117			# 0x00000075
	sw	$2,gPause_CurrentY
$L798:
	sll	$2,$16,16
	sra	$4,$2,16
	sll	$2,$4,2
	addu	$2,$17,$2
	lw	$3,8($2)
	#nop
	beq	$3,$0,$L797
	lw	$2,0($3)
	#nop
	xori	$2,$2,0x0001
	andi	$2,$2,0x0001
	beq	$2,$0,$L802
	lw	$2,4($17)
	#nop
	beq	$2,$0,$L803
	lw	$5,0($17)
	lw	$2,8($3)
	xor	$5,$4,$5
	.set	noreorder
	.set	nomacro
	j	$L806
	sltu	$5,$5,1
	.set	macro
	.set	reorder

$L803:
	lw	$2,8($3)
	move	$5,$0
$L806:
	lh	$4,48($2)
	lw	$2,52($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$2,gPause_CurrentY
	#nop
	addu	$2,$2,13
	sw	$2,gPause_CurrentY
$L802:
	.set	noreorder
	.set	nomacro
	j	$L798
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L797:
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

	.end	Draw__6tPMenu
	.text
	.ent	NumEnabledItems__6tPMenu
NumEnabledItems__6tPMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,76($4)
	li	$3,1			# 0x00000001
	addu	$4,$4,4
	move	$6,$5
$L810:
	slt	$2,$6,$3
	bne	$2,$0,$L809
	lw	$2,8($4)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L812
	addu	$5,$5,-1
$L812:
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L810
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L809:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	NumEnabledItems__6tPMenu
	.text
	.ent	ItemEnabledNum__6tPMenui
ItemEnabledNum__6tPMenui:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$5
	move	$3,$0
$L817:
	slt	$2,$3,$6
	beq	$2,$0,$L816
	lw	$2,8($4)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L819
	addu	$5,$5,-1
$L819:
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L817
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L816:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	ItemEnabledNum__6tPMenui
	.text
	.ent	IsNavigable__21tPMenuItemInteractive
IsNavigable__21tPMenuItemInteractive:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	IsNavigable__21tPMenuItemInteractive
	.text
	.ent	IsNavigable__28tPMenuItemNonInteractiveText
IsNavigable__28tPMenuItemNonInteractiveText:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	IsNavigable__28tPMenuItemNonInteractiveText
	.text
	.ent	IsEnabled__10tPMenuItem
IsEnabled__10tPMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	IsEnabled__10tPMenuItem
	.text
	.ent	IsDisabled__10tPMenuItem
IsDisabled__10tPMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	IsDisabled__10tPMenuItem
