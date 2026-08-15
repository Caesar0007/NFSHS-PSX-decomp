	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fedialog.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	___31tDialogMessageStringWithTimeout
	.ent	___31tDialogMessageStringWithTimeout
___31tDialogMessageStringWithTimeout:
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

	.end	___31tDialogMessageStringWithTimeout
	.align	2
	.globl	ShouldTimeOut__11tDialogBase
	.ent	ShouldTimeOut__11tDialogBase
ShouldTimeOut__11tDialogBase:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,120($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$5,$L603
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(ticks)($2)
	lw	$4,116($4)
	#nop
	subu	$3,$3,$4
	slt	$3,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L606
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L603:
	move	$2,$0
$L606:
	j	$31
	.end	ShouldTimeOut__11tDialogBase
	.align	2
	.globl	InitializeClass__11tDialogBase
	.ent	InitializeClass__11tDialogBase
InitializeClass__11tDialogBase:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	HideAllDialogs__11tDialogBase
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	InitializeClass__11tDialogBase
	.align	2
	.globl	DrawAllDialogs__11tDialogBase
	.ent	DrawAllDialogs__11tDialogBase
DrawAllDialogs__11tDialogBase:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$3,%hi(DialogVisibilityList) # high
	lw	$2,%lo(DialogVisibilityList)($3)
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addiu	$18,$3,%lo(DialogVisibilityList) # low
$L611:
	sll	$2,$17,16
	sra	$3,$2,16
	slt	$2,$3,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$16,$2,$18
	lw	$4,0($16)
	jal	ShouldTimeOut__11tDialogBase
	sll	$2,$2,16
	beq	$2,$0,$L613
	lw	$4,0($16)
	jal	Hide__11tDialogBase
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L608
$L613:
	lw	$3,0($16)
	#nop
	lw	$2,96($3)
	#nop
	lh	$4,88($2)
	lw	$2,92($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$17,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$2,$18
	lw	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	move	$17,$3
	.set	macro
	.set	reorder

$L608:
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

	.end	DrawAllDialogs__11tDialogBase
	.align	2
	.globl	HideAllDialogs__11tDialogBase
	.ent	HideAllDialogs__11tDialogBase
HideAllDialogs__11tDialogBase:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	lui	$2,%hi(DialogVisibilityList) # high
	addiu	$4,$2,%lo(DialogVisibilityList) # low
	sll	$2,$3,16
$L621:
	sra	$2,$2,14
	addu	$2,$2,$4
	sw	$0,0($2)
	addu	$2,$3,1
	move	$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	sll	$2,$3,16
	.set	macro
	.set	reorder

	j	$31
	.end	HideAllDialogs__11tDialogBase
	.align	2
	.globl	GetTopMostDialog__11tDialogBase
	.ent	GetTopMostDialog__11tDialogBase
GetTopMostDialog__11tDialogBase:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(DialogVisibilityList) # high
	lw	$2,%lo(DialogVisibilityList)($2)
	j	$31
	.end	GetTopMostDialog__11tDialogBase
	.align	2
	.globl	Display__11tDialogBase
	.ent	Display__11tDialogBase
Display__11tDialogBase:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	li	$5,7			# 0x00000007
	.set	macro
	.set	reorder

	lui	$2,%hi(DialogVisibilityList) # high
	addiu	$6,$2,%lo(DialogVisibilityList) # low
	lhu	$3,136($17)
	li	$2,1			# 0x00000001
	sw	$2,112($17)
	sw	$0,132($17)
	sh	$3,138($17)
$L625:
	sll	$2,$5,16
	addu	$4,$5,-1
	move	$5,$4
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$2,$2,-1
	sll	$2,$2,2
	addu	$2,$2,$6
	addu	$3,$3,$6
	lw	$2,0($2)
	sll	$4,$4,16
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L625
	sw	$2,0($3)
	.set	macro
	.set	reorder

	move	$4,$17
	lui	$16,%hi(DialogVisibilityList) # high
	.set	noreorder
	.set	nomacro
	jal	ShouldTimeOut__11tDialogBase
	sw	$17,%lo(DialogVisibilityList)($16)
	.set	macro
	.set	reorder

	lw	$4,%lo(DialogVisibilityList)($16)
	jal	ShouldTimeOut__11tDialogBase
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	li	$4,15			# 0x0000000f
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$2,116($17)
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	sw	$0,132($17)
	sw	$2,140($17)
$L623:
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

	.end	Display__11tDialogBase
	.align	2
	.globl	Hide__11tDialogBase
	.ent	Hide__11tDialogBase
Hide__11tDialogBase:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,112($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	move	$16,$0
	.set	macro
	.set	reorder

	sw	$0,112($18)
	lui	$2,%hi(DialogVisibilityList) # high
	addiu	$17,$2,%lo(DialogVisibilityList) # low
	sll	$2,$16,16
$L638:
	sra	$7,$2,16
	sll	$3,$7,2
	addu	$5,$3,$17
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L637
	addu	$2,$16,1
	.set	macro
	.set	reorder

	addu	$4,$17,4
	addu	$4,$3,$4
	li	$6,7			# 0x00000007
	subu	$6,$6,$7
	sll	$6,$6,2
	sw	$0,112($18)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sw	$0,0($5)
	.set	macro
	.set	reorder

	li	$4,18			# 0x00000012
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sw	$0,28($17)
	.set	macro
	.set	reorder

	addu	$2,$16,1
$L637:
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L629:
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

	.end	Hide__11tDialogBase
	.align	2
	.globl	Draw__11tDialogBase
	.ent	Draw__11tDialogBase
Draw__11tDialogBase:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	move	$4,$0
	li	$7,4			# 0x00000004
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lh	$5,102($16)
	lh	$6,104($16)
	lh	$2,108($16)
	move	$18,$7
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,102($16)
	lh	$2,106($16)
	lh	$6,104($16)
	lh	$3,108($16)
	li	$7,4			# 0x00000004
	sw	$18,20($sp)
	addu	$5,$5,$2
	addu	$5,$5,-4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lh	$5,102($16)
	lh	$6,104($16)
	lh	$7,106($16)
	li	$17,2			# 0x00000002
	sw	$17,16($sp)
	sw	$18,20($sp)
	addu	$5,$5,4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	addu	$7,$7,-8
	.set	macro
	.set	reorder

	lh	$5,102($16)
	lh	$6,104($16)
	lh	$2,108($16)
	lh	$7,106($16)
	move	$4,$0
	sw	$17,16($sp)
	sw	$18,20($sp)
	addu	$5,$5,4
	addu	$6,$6,$2
	addu	$6,$6,-2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	addu	$7,$7,-8
	.set	macro
	.set	reorder

	lh	$5,102($16)
	lh	$6,104($16)
	lh	$7,106($16)
	lh	$2,108($16)
	move	$4,$0
	sw	$17,20($sp)
	addu	$5,$5,4
	addu	$6,$6,$17
	addu	$7,$7,-8
	addu	$2,$2,-4
	.set	noreorder
	.set	nomacro
	jal	PSXDrawTransSquare__Fiiiiis
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeDraw_SetABRMode__Fi
	move	$4,$0
	.set	macro
	.set	reorder

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

	.end	Draw__11tDialogBase
	.align	2
	.globl	ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$2,0($17)
	li	$16,1			# 0x00000001
	beq	$2,$16,$L640
	jal	Hide__11tDialogBase
	sw	$16,0($17)
$L640:
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

	.end	ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	AddItem__11tDialogHelpss
	.ent	AddItem__11tDialogHelpss
AddItem__11tDialogHelpss:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,204($16)
	#nop
	slt	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L642
	move	$17,$6
	.set	macro
	.set	reorder

	sll	$4,$5,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$4,16
	.set	macro
	.set	reorder

	lh	$3,204($16)
	#nop
	sll	$3,$3,2
	addu	$3,$16,$3
	sw	$2,148($3)
	sll	$2,$17,16
	lh	$3,204($16)
	sra	$2,$2,16
	sll	$3,$3,2
	addu	$3,$16,$3
	sw	$2,176($3)
	lhu	$2,204($16)
	#nop
	addu	$2,$2,1
	sh	$2,204($16)
$L642:
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

	.end	AddItem__11tDialogHelpss
	.align	2
	.globl	CalculateDimensions__11tDialogHelp
	.ent	CalculateDimensions__11tDialogHelp
CalculateDimensions__11tDialogHelp:
	.frame	$sp,72,$31		# vars= 24, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$19,52($sp)
	move	$19,$4
	lui	$2,%hi(kHelpArrayTemplate) # high
	sw	$31,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	addiu	$12,$2,%lo(kHelpArrayTemplate)
	lwl	$9,3($12)
	lwr	$9,0($12)
	lwl	$10,7($12)
	lwr	$10,4($12)
	lwl	$11,11($12)
	lwr	$11,8($12)
	swl	$9,19($sp)
	swr	$9,16($sp)
	swl	$10,23($sp)
	swr	$10,20($sp)
	swl	$11,27($sp)
	swr	$11,24($sp)
	lwl	$9,15($12)
	lwr	$9,12($12)
	lh	$10,16($12)
	swl	$9,31($sp)
	swr	$9,28($sp)
	sh	$10,32($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetFont__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$19
	li	$5,89			# 0x00000059
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	sh	$0,204($19)
	.set	macro
	.set	reorder

	move	$21,$0
	lh	$3,100($19)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L645
	addu	$16,$sp,16
	.set	macro
	.set	reorder

	move	$21,$3
$L645:
	lh	$2,144($19)
	#nop
	sll	$3,$2,3
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$16,$3
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L671
	move	$18,$0
	.set	macro
	.set	reorder

	move	$20,$18
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	sll	$3,$21,2
	addu	$2,$2,$3
	lw	$16,4($2)
	move	$17,$18
	move	$4,$16
$L649:
	sll	$2,$17,16
	sra	$2,$2,14
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L648
	lw	$3,0($2)
	#nop
	xori	$2,$3,0x0001
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L651
	andi	$2,$3,0x0400
	.set	macro
	.set	reorder

	beq	$2,$0,$L652
	.set	noreorder
	.set	nomacro
	j	$L651
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

$L652:
	li	$20,1			# 0x00000001
$L651:
	.set	noreorder
	.set	nomacro
	j	$L649
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	jal	GetNumberEnabledItems__5tMenu
	move	$4,$16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L655
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,82			# 0x00000052
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,80			# 0x00000050
	.set	macro
	.set	reorder

$L655:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L656
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,83			# 0x00000053
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,160			# 0x000000a0
	.set	macro
	.set	reorder

$L656:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L657
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	lw	$3,0($16)
	#nop
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,131072			# 0x00020000
	and	$2,$3,$2
	beq	$2,$0,$L659
$L660:
	li	$4,1			# 0x00000001
$L659:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L658
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L695
	li	$5,86			# 0x00000056
	.set	macro
	.set	reorder

$L658:
	li	$5,85			# 0x00000055
$L695:
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,16384			# 0x00004000
	.set	macro
	.set	reorder

$L657:
	lui	$2,%hi(FEApp) # high
	lw	$2,%lo(FEApp)($2)
	sll	$3,$21,2
	addu	$2,$2,$3
	lw	$2,324($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L664
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,84			# 0x00000054
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,4096			# 0x00001000
	.set	macro
	.set	reorder

$L664:
	lw	$2,92($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L665
	move	$4,$19
	.set	macro
	.set	reorder

	li	$5,87			# 0x00000057
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,-32768			# 0xffff8000
	.set	macro
	.set	reorder

$L665:
	lw	$3,0($16)
	#nop
	andi	$2,$3,0x0800
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L666
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L696
	li	$5,88			# 0x00000058
	.set	macro
	.set	reorder

$L666:
	lw	$2,84($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L669
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$3,0x0400
	bne	$2,$0,$L669
	lw	$2,96($16)
	#nop
	beq	$2,$0,$L668
$L669:
	li	$4,1			# 0x00000001
$L668:
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L698
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L671
$L698:
	li	$5,86			# 0x00000056
$L696:
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

$L671:
	lh	$2,144($19)
	addu	$18,$sp,16
	sll	$3,$2,3
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$18,$3
	lh	$2,2($3)
	lhu	$3,144($19)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L673
	move	$17,$0
	.set	macro
	.set	reorder

	move	$4,$19
$L699:
	sll	$6,$17,16
	sra	$6,$6,14
	sll	$3,$3,16
	sra	$3,$3,16
	sll	$2,$3,3
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$6,$6,$2
	addu	$6,$18,$6
	lh	$5,2($6)
	lh	$6,4($6)
	.set	noreorder
	.set	nomacro
	jal	AddItem__11tDialogHelpss
	move	$16,$18
	.set	macro
	.set	reorder

	addu	$3,$17,1
	move	$17,$3
	sll	$3,$3,16
	lh	$4,144($19)
	sra	$3,$3,14
	sll	$2,$4,3
	addu	$2,$2,$4
	sll	$2,$2,1
	addu	$3,$3,$2
	addu	$16,$16,$3
	lh	$2,2($16)
	lhu	$3,144($19)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	move	$4,$19
	.set	macro
	.set	reorder

$L673:
	.set	noreorder
	.set	nomacro
	jal	PAD_update
	sh	$0,206($19)
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,4($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	li	$3,35			# 0x00000023
	lbu	$2,5($4)
	lh	$4,206($19)
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L677
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

	ori	$2,$4,0x0002
$L677:
	sh	$2,206($19)
	lui	$2,%hi(gPadinfo) # high
$L700:
	addiu	$4,$2,%lo(gPadinfo) # low
	lbu	$2,36($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L679
	li	$3,35			# 0x00000023
	.set	macro
	.set	reorder

	lbu	$2,37($4)
	lh	$4,206($19)
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L680
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

	ori	$2,$4,0x0002
$L680:
	sh	$2,206($19)
$L679:
	lh	$2,204($19)
	move	$17,$0
	.set	noreorder
	.set	nomacro
	blez	$2,$L682
	sh	$0,106($19)
	.set	macro
	.set	reorder

	sll	$2,$17,16
$L701:
	sra	$2,$2,14
	addu	$2,$19,$2
	lw	$4,148($2)
	jal	textpixels
	lh	$3,106($19)
	#nop
	slt	$3,$3,$2
	beq	$3,$0,$L686
	sh	$2,106($19)
$L686:
	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	lh	$3,204($19)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	sll	$2,$17,16
	.set	macro
	.set	reorder

$L682:
	lh	$3,206($19)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L688
	li	$3,40			# 0x00000028
	.set	macro
	.set	reorder

	lhu	$2,106($19)
	li	$3,70			# 0x00000046
	sh	$3,208($19)
	.set	noreorder
	.set	nomacro
	j	$L697
	addu	$2,$2,70
	.set	macro
	.set	reorder

$L688:
	lhu	$2,106($19)
	sh	$3,208($19)
	addu	$2,$2,40
$L697:
	sh	$2,106($19)
	lh	$3,204($19)
	#nop
	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L690
	sll	$2,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L691
	sh	$0,108($19)
	.set	macro
	.set	reorder

$L690:
	subu	$2,$2,$3
	sh	$2,108($19)
$L691:
	lui	$2,%hi(screenwidth) # high
	lui	$6,%hi(gHelpShapes) # high
	lh	$3,106($19)
	lw	$2,%lo(screenwidth)($2)
	lw	$4,%lo(gHelpShapes)($6)
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lh	$3,108($19)
	sra	$2,$2,1
	sh	$2,102($19)
	li	$2,240			# 0x000000f0
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sh	$2,104($19)
	lh	$2,112($4)
	lh	$3,106($19)
	addu	$2,$2,20
	slt	$3,$3,$2
	lhu	$2,112($4)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L692
	addu	$2,$2,20
	.set	macro
	.set	reorder

	sh	$2,106($19)
$L692:
	lui	$3,%hi(ticks) # high
	lhu	$2,106($19)
	lw	$8,%lo(ticks)($3)
	lw	$3,116($19)
	addu	$2,$2,20
	sh	$2,106($19)
	lhu	$2,108($19)
	subu	$5,$8,$3
	addu	$2,$2,10
	sh	$2,108($19)
	sltu	$2,$5,50
	beq	$2,$0,$L693
	lw	$4,%lo(gHelpShapes)($6)
	#nop
	lh	$6,1360($4)
	lh	$3,106($19)
	sll	$2,$6,17
	sra	$2,$2,16
	subu	$3,$3,$2
	mult	$3,$5
	lh	$5,1362($4)
	lh	$4,108($19)
	lw	$2,116($19)
	sll	$3,$5,17
	sra	$3,$3,16
	mflo	$7
	#nop
	subu	$4,$4,$3
	subu	$2,$8,$2
	mult	$4,$2
	mflo	$3
	#nop
	li	$2,1374355456			# 0x51eb0000
	ori	$2,$2,0x851f
	multu	$7,$2
	mfhi	$7
	#nop
	#nop
	multu	$3,$2
	sll	$6,$6,1
	sll	$5,$5,1
	srl	$2,$7,4
	addu	$6,$6,$2
	sh	$6,106($19)
	mfhi	$3
	#nop
	#nop
	srl	$2,$3,4
	addu	$5,$5,$2
	sh	$5,108($19)
$L693:
	lhu	$3,106($19)
	li	$2,20			# 0x00000014
	sh	$2,104($19)
	li	$2,505			# 0x000001f9
	subu	$2,$2,$3
	sh	$2,102($19)
	lw	$31,64($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	CalculateDimensions__11tDialogHelp
	.align	2
	.globl	Draw__11tDialogHelp
	.ent	Draw__11tDialogHelp
Draw__11tDialogHelp:
	.frame	$sp,136,$31		# vars= 80, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$18,112($sp)
	move	$18,$4
	sw	$31,132($sp)
	sw	$22,128($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$17,108($sp)
	sw	$16,104($sp)
	lw	$2,96($18)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$5,116($18)
	move	$4,$2
 #APP
 #NO_APP
	addu	$2,$5,50
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L703
	li	$3,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	ori	$3,$3,0x5556
	subu	$2,$4,$5
	addu	$2,$2,-50
	mult	$2,$3
	move	$19,$0
	addu	$22,$sp,24
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$21,$8,$2
 #APP
 #NO_APP
	sll	$3,$19,16
$L736:
	lh	$2,204($18)
	sra	$3,$3,16
	slt	$2,$3,$2
	beq	$2,$0,$L703
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L708
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	lhu	$2,104($18)
	.set	noreorder
	.set	nomacro
	j	$L709
	addu	$20,$2,4
	.set	macro
	.set	reorder

$L708:
	sll	$3,$2,4
	lhu	$4,104($18)
	subu	$3,$3,$2
	addu	$4,$4,$3
	addu	$20,$4,19
$L709:
	sll	$2,$19,16
	sra	$7,$2,16
	.set	noreorder
	.set	nomacro
	blez	$7,$L710
	sll	$2,$7,2
	.set	macro
	.set	reorder

	addu	$2,$18,$2
	li	$3,2			# 0x00000002
	lh	$4,206($18)
	lw	$5,176($2)
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L712
	slt	$2,$4,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L714
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L716
	li	$2,160			# 0x000000a0
	.set	macro
	.set	reorder

$L714:
	li	$4,65			# 0x00000041
	andi	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	j	$L733
	addu	$2,$7,-1
	.set	macro
	.set	reorder

$L712:
	li	$4,35			# 0x00000023
	andi	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	j	$L733
	addu	$2,$7,-1
	.set	macro
	.set	reorder

$L716:
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L720
	li	$2,80			# 0x00000050
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L720
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L720
	li	$4,65			# 0x00000041
	.set	macro
	.set	reorder

	andi	$17,$5,0xffff
	move	$5,$17
	addu	$2,$7,-1
	sll	$16,$2,4
	subu	$16,$16,$2
	addu	$16,$16,15
	lh	$6,102($18)
	lh	$7,104($18)
	addu	$6,$6,20
	addu	$7,$7,$16
	.set	noreorder
	.set	nomacro
	jal	FeTools_DrawPSXButton__FUcUsii
	addu	$7,$7,4
	.set	macro
	.set	reorder

	li	$4,35			# 0x00000023
	move	$5,$17
	lh	$6,102($18)
	lh	$7,104($18)
	addu	$6,$6,40
	addu	$7,$7,$16
	.set	noreorder
	.set	nomacro
	j	$L734
	addu	$7,$7,4
	.set	macro
	.set	reorder

$L720:
	li	$4,65			# 0x00000041
	andi	$5,$5,0xffff
	sll	$2,$19,16
	sra	$2,$2,16
	addu	$2,$2,-1
$L733:
	sll	$7,$2,4
	subu	$7,$7,$2
	lh	$6,102($18)
	lh	$3,104($18)
	addu	$6,$6,20
	addu	$7,$7,$3
	addu	$7,$7,19
$L734:
	jal	FeTools_DrawPSXButton__FUcUsii
$L710:
	sll	$2,$19,16
	sra	$17,$2,16
	sll	$2,$17,2
	addu	$16,$18,$2
	lw	$4,148($16)
	jal	strlen
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L721
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$21,$L722
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$16
$L723:
	sll	$3,$5,16
	addu	$4,$5,1
	move	$5,$4
	sra	$3,$3,16
	sll	$4,$4,16
	sra	$4,$4,16
	lw	$2,148($6)
	slt	$4,$4,$21
	addu	$2,$2,$3
	lbu	$2,0($2)
	addu	$3,$22,$3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L723
	sb	$2,0($3)
	.set	macro
	.set	reorder

$L722:
	addu	$2,$22,$21
	sb	$0,0($2)
	lhu	$2,102($18)
	lhu	$3,208($18)
	#nop
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$5,$2,16
	sll	$2,$20,16
	sra	$6,$2,16
	sll	$2,$19,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	li	$7,8			# 0x00000008
	.set	macro
	.set	reorder

	li	$7,9			# 0x00000009
$L727:
	move	$4,$22
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L735
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L721:
	lhu	$2,102($18)
	lhu	$3,208($18)
	#nop
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$5,$2,16
	sll	$2,$20,16
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L730
	sra	$6,$2,16
	.set	macro
	.set	reorder

	li	$7,9			# 0x00000009
$L730:
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$4,148($16)
$L735:
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	addu	$19,$19,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L736
	sll	$3,$19,16
	.set	macro
	.set	reorder

$L703:
	.set	noreorder
	.set	nomacro
	jal	Draw__11tDialogBase
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$31,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	Draw__11tDialogHelp
	.align	2
	.globl	CalculateDimensions__20tDialogMessageString
	.ent	CalculateDimensions__20tDialogMessageString
CalculateDimensions__20tDialogMessageString:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$4,1374355456			# 0x51eb0000
	lui	$2,%hi(ticks) # high
	lw	$8,%lo(ticks)($2)
	ori	$4,$4,0x851f
	sw	$31,20($sp)
	lw	$3,116($16)
	addu	$2,$8,-50
	subu	$2,$2,$3
	sll	$2,$2,7
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,5
	subu	$3,$3,$2
	li	$2,128			# 0x00000080
	subu	$2,$2,$3
	move	$3,$2
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	sw	$3,140($16)
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L738:
	move	$2,$3
	bgez	$2,$L739
	move	$2,$0
$L739:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L740
	sw	$2,140($16)
	.set	macro
	.set	reorder

	sw	$0,132($16)
$L740:
	lhu	$2,128($16)
	lh	$3,130($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L741
	sh	$2,106($16)
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$4,$4,-40
	sll	$4,$4,16
	lw	$5,144($16)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapHeight__FsPc
	sra	$4,$4,16
	.set	macro
	.set	reorder

	sh	$2,108($16)
	sll	$2,$2,16
	sra	$2,$2,16
	li	$3,8			# 0x00000008
	bne	$2,$3,$L742
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L743
	sw	$2,148($16)
	.set	macro
	.set	reorder

$L742:
	sw	$0,148($16)
$L743:
	lhu	$2,108($16)
	.set	noreorder
	.set	nomacro
	j	$L748
	addu	$2,$2,16
	.set	macro
	.set	reorder

$L741:
	lhu	$2,130($16)
	sw	$0,148($16)
$L748:
	sh	$2,108($16)
	lui	$2,%hi(ticks) # high
	lw	$8,%lo(ticks)($2)
	lw	$2,116($16)
	#nop
	subu	$4,$8,$2
	slt	$2,$4,50
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L745
	lui	$2,%hi(gHelpShapes) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(gHelpShapes)($2)
	#nop
	lh	$6,1360($3)
	lh	$5,106($16)
	sll	$2,$6,17
	sra	$2,$2,16
	subu	$5,$5,$2
	mult	$5,$4
	lh	$7,1362($3)
	#nop
	sll	$3,$7,17
	sra	$3,$3,16
	lh	$4,108($16)
	lw	$2,116($16)
	mflo	$5
	#nop
	subu	$4,$4,$3
	subu	$2,$8,$2
	mult	$4,$2
	mflo	$4
	#nop
	li	$2,1374355456			# 0x51eb0000
	ori	$2,$2,0x851f
	mult	$5,$2
	mfhi	$8
	#nop
	#nop
	mult	$4,$2
	sw	$0,132($16)
	sll	$6,$6,1
	sll	$7,$7,1
	sra	$5,$5,31
	sra	$2,$8,4
	subu	$2,$2,$5
	addu	$6,$6,$2
	sra	$4,$4,31
	sh	$6,106($16)
	mfhi	$3
	#nop
	#nop
	sra	$2,$3,4
	subu	$2,$2,$4
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	j	$L746
	sh	$7,108($16)
	.set	macro
	.set	reorder

$L745:
	li	$2,1			# 0x00000001
	sw	$2,132($16)
$L746:
	lui	$2,%hi(screenwidth) # high
	lh	$3,106($16)
	lw	$2,%lo(screenwidth)($2)
	#nop
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lhu	$3,124($16)
	sra	$2,$2,1
	addu	$3,$3,$2
	sh	$3,102($16)
	lh	$3,108($16)
	li	$2,240			# 0x000000f0
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lhu	$3,126($16)
	sra	$2,$2,1
	addu	$3,$3,$2
	sh	$3,104($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalculateDimensions__20tDialogMessageString
	.align	2
	.globl	Draw__20tDialogMessageString
	.ent	Draw__20tDialogMessageString
Draw__20tDialogMessageString:
	.frame	$sp,48,$31		# vars= 8, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,40($sp)
	sw	$17,36($sp)
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

	lui	$3,%hi(ticks) # high
	lw	$2,116($16)
	lw	$3,%lo(ticks)($3)
	addu	$2,$2,50
	slt	$3,$3,$2
	beq	$3,$0,$L750
	.set	noreorder
	.set	nomacro
	j	$L751
	sw	$0,132($16)
	.set	macro
	.set	reorder

$L750:
	lw	$2,140($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L757
	lui	$3,%hi(kRGBVals) # high
	.set	macro
	.set	reorder

	sw	$0,132($16)
$L757:
	lui	$2,%hi(textDefinitions+52) # high
	addiu	$3,$3,%lo(kRGBVals) # low
	lbu	$2,%lo(textDefinitions+52)($2)
	lw	$5,140($16)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	jal	CalcFadeVal__Fii
	lhu	$3,102($16)
	li	$4,1			# 0x00000001
	addu	$3,$3,17
	sh	$3,24($sp)
	lhu	$3,104($16)
	move	$5,$4
	addu	$3,$3,10
	sh	$3,26($sp)
	lhu	$3,106($16)
	move	$17,$2
	addu	$3,$3,-20
	sh	$3,28($sp)
	lhu	$3,110($16)
	lhu	$6,108($16)
	addu	$3,$3,8
	subu	$6,$6,$3
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	sh	$6,30($sp)
	.set	macro
	.set	reorder

	lw	$2,148($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lhu	$3,106($16)
	lhu	$5,102($16)
	lhu	$6,104($16)
	move	$7,$17
	sw	$0,16($sp)
	sw	$2,20($sp)
	lw	$4,144($16)
	sll	$3,$3,16
	sra	$3,$3,17
	addu	$5,$5,$3
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,8
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L756
	move	$4,$0
	.set	macro
	.set	reorder

$L753:
	lw	$4,144($16)
	addu	$5,$sp,24
	.set	noreorder
	.set	nomacro
	jal	FETextRender_WordWrapTextRGB__FPcR4RECTi
	move	$6,$17
	.set	macro
	.set	reorder

	move	$4,$0
$L756:
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	move	$5,$4
	.set	macro
	.set	reorder

$L751:
	.set	noreorder
	.set	nomacro
	jal	Draw__11tDialogBase
	move	$4,$16
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

	.end	Draw__20tDialogMessageString
	.align	2
	.globl	ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lh	$3,100($4)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L760
	bne	$5,$3,$L764
$L760:
	lw	$3,0($6)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L761
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L764
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L764
	sw	$2,0($6)
	.set	macro
	.set	reorder

$L761:
	jal	Hide__11tDialogBase
$L764:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Run__18tDialogInteractive
	.ent	Run__18tDialogInteractive
Run__18tDialogInteractive:
	.frame	$sp,72,$31		# vars= 16, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$19,44($sp)
	move	$19,$4
	li	$2,1			# 0x00000001
	sw	$31,64($sp)
	sw	$23,60($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Display__11tDialogBase
	sw	$2,156($19)
	.set	macro
	.set	reorder

	addu	$23,$sp,16
	li	$20,1			# 0x00000001
	lw	$2,96($19)
	lui	$21,%hi(FEApp) # high
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

	sw	$0,152($19)
$L766:
	lw	$2,152($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L767
	li	$22,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$0,24($sp)
	move	$17,$0
	move	$16,$23
	move	$18,$17
$L769:
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FEInput_GetKeyFromPlayer__F7tPlayerl
	move	$5,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	sw	$2,0($16)
	.set	macro
	.set	reorder

	sw	$20,0($16)
$L772:
	lw	$3,0($16)
	li	$2,4			# 0x00000004
	bne	$3,$2,$L773
	lw	$4,%lo(FEApp)($21)
	#nop
	lw	$2,456($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L774
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$2,$4,$18
	lw	$2,4($2)
	#nop
	sltu	$3,$3,$2
$L774:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L773
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$2,$4,$18
	lw	$3,4($2)
	move	$6,$16
	lw	$2,104($3)
	addu	$7,$sp,24
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	sw	$20,0($16)
$L773:
	lw	$2,0($16)
	#nop
	beq	$2,$20,$L780
	lw	$2,%lo(FEApp)($21)
	#nop
	addu	$4,$2,344
	lw	$2,112($4)
	#nop
	beq	$2,$0,$L776
	jal	Hide__11tDialogBase
	sw	$20,0($16)
$L776:
	lw	$2,0($16)
$L780:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	move	$5,$17
	.set	macro
	.set	reorder

	move	$6,$16
	lw	$2,96($19)
	addu	$7,$sp,24
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$19,$4
	.set	macro
	.set	reorder

$L778:
	addu	$16,$16,4
	addu	$18,$18,4
	.set	noreorder
	.set	nomacro
	j	$L769
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L770:
	lw	$4,%lo(FEApp)($21)
	jal	Redraw__14tFEApplication
	j	$L766
$L767:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	move	$4,$19
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	jal	Redraw__14tFEApplication
	lh	$2,138($19)
	sw	$0,156($19)
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

	.end	Run__18tDialogInteractive
	.align	2
	.globl	CalculateDimensions__12tDialogYesNo
	.ent	CalculateDimensions__12tDialogYesNo
CalculateDimensions__12tDialogYesNo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CalculateDimensions__20tDialogMessageString
	move	$16,$4
	.set	macro
	.set	reorder

	lh	$2,130($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L781
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(ticks)($2)
	lw	$2,116($16)
	#nop
	subu	$4,$3,$2
	slt	$2,$4,50
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L783
	li	$2,1374355456			# 0x51eb0000
	.set	macro
	.set	reorder

	ori	$2,$2,0x851f
	sll	$3,$4,4
	subu	$3,$3,$4
	mult	$3,$2
	sra	$3,$3,31
	lhu	$2,108($16)
	mfhi	$5
	#nop
	#nop
	sra	$4,$5,4
	subu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	j	$L786
	addu	$2,$2,$4
	.set	macro
	.set	reorder

$L783:
	lhu	$2,108($16)
	#nop
	addu	$2,$2,15
$L786:
	sh	$2,108($16)
	lh	$3,108($16)
	li	$2,15			# 0x0000000f
	sh	$2,110($16)
	li	$2,240			# 0x000000f0
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lhu	$3,126($16)
	sra	$2,$2,1
	addu	$3,$3,$2
	sh	$3,104($16)
$L781:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalculateDimensions__12tDialogYesNo
	.align	2
	.globl	__12tDialogYesNo
	.ent	__12tDialogYesNo
__12tDialogYesNo:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__20tDialogMessageString
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tDialogBase_vtable) # high
	addiu	$3,$3,%lo(tDialogBase_vtable) # low
	sw	$3,96($2)
	li	$3,288			# 0x00000120
	sh	$3,128($2)
	li	$3,-1			# 0xffffffff
	sh	$3,100($2)
	lui	$3,%hi(tDialogMessageString_vtable) # high
	addiu	$3,$3,%lo(tDialogMessageString_vtable) # low
	sw	$3,96($2)
	li	$3,128			# 0x00000080
	sw	$3,140($2)
	lui	$3,%hi(tDialogInteractive_vtable) # high
	addiu	$3,$3,%lo(tDialogInteractive_vtable) # low
	sw	$3,96($2)
	lui	$3,%hi(tDialogYesNo_vtable) # high
	addiu	$3,$3,%lo(tDialogYesNo_vtable) # low
	sw	$0,112($2)
	sh	$0,110($2)
	sh	$0,130($2)
	sh	$0,126($2)
	sh	$0,124($2)
	sh	$0,108($2)
	sh	$0,106($2)
	sh	$0,104($2)
	sh	$0,102($2)
	sh	$0,136($2)
	sw	$0,120($2)
	sw	$0,148($2)
	sw	$0,132($2)
	sw	$0,120($2)
	#.set	volatile
	sw	$0,120($2)
	#.set	novolatile
	sw	$0,156($2)
	sw	$3,96($2)
	sh	$0,138($2)
	sw	$0,152($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__12tDialogYesNo
	.align	2
	.globl	Draw__12tDialogYesNo
	.ent	Draw__12tDialogYesNo
Draw__12tDialogYesNo:
	.frame	$sp,64,$31		# vars= 0, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,32($sp)
	move	$18,$4
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$2,96($18)
	#nop
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$18,$4
	.set	macro
	.set	reorder

	lw	$2,140($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L802
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	sw	$0,132($18)
$L802:
	lw	$2,%lo(ticks)($2)
	lw	$3,116($18)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,50
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L795
	move	$19,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(kRGBVals) # high
	addiu	$23,$2,%lo(kRGBVals) # low
	lui	$2,%hi(textDefinitions) # high
	addiu	$22,$2,%lo(textDefinitions) # low
	move	$21,$18
	lhu	$2,106($18)
	lh	$3,102($18)
	sll	$2,$2,16
	sra	$2,$2,18
	addu	$20,$3,$2
$L798:
	slt	$2,$19,2
	beq	$2,$0,$L795
	lh	$2,138($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L800
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L800:
	addu	$2,$3,$22
	lbu	$2,51($2)
	lw	$5,140($18)
	sll	$2,$2,2
	addu	$2,$2,$23
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	addu	$19,$19,1
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$4
	lh	$16,104($18)
	lh	$3,108($18)
	move	$17,$2
	addu	$16,$16,$3
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	addu	$16,$16,-11
	.set	macro
	.set	reorder

	lw	$4,160($21)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sll	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$20,16
	sra	$5,$5,16
	li	$2,2			# 0x00000002
	sra	$6,$16,16
	move	$7,$17
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	move	$5,$4
	.set	macro
	.set	reorder

	lhu	$2,106($18)
	addu	$21,$21,4
	sll	$2,$2,16
	sra	$2,$2,17
	.set	noreorder
	.set	nomacro
	j	$L798
	addu	$20,$20,$2
	.set	macro
	.set	reorder

$L795:
	.set	noreorder
	.set	nomacro
	jal	Draw__20tDialogMessageString
	move	$4,$18
	.set	macro
	.set	reorder

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

	.end	Draw__12tDialogYesNo
	.align	2
	.globl	ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lh	$3,100($16)
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L805
	bne	$5,$3,$L815
$L805:
	lw	$2,132($16)
	#nop
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	lw	$6,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L808
	slt	$2,$6,2049
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L814
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$6,$2,$L811
	j	$L815
$L814:
	li	$2,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L809
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	beq	$6,$2,$L811
	j	$L815
$L808:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L815
	sh	$2,138($16)
	.set	macro
	.set	reorder

$L809:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L815
	sh	$0,138($16)
	.set	macro
	.set	reorder

$L811:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,152($16)
	.set	noreorder
	.set	nomacro
	jal	Hide__11tDialogBase
	move	$4,$16
	.set	macro
	.set	reorder

$L815:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(CURRENTPLAYER) # high
	lw	$2,%lo(CURRENTPLAYER)($2)
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$21,36($sp)
	move	$21,$7
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,40($sp)
	sw	$17,20($sp)
	sll	$2,$2,2
	addu	$17,$2,1
	.set	noreorder
	.set	nomacro
	jal	MCRD_handlecardevents
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$3,$2,-2
	sltu	$2,$3,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L817
	lui	$2,%hi($L826) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L826) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L826:
	.word	$L825
	.word	$L825
	.word	$L817
	.word	$L817
	.word	$L817
	.word	$L825
	.word	$L817
	.word	$L817
	.word	$L825
	.word	$L825
	.word	$L817
	.word	$L817
	.word	$L817
	.word	$L817
	.word	$L825
	.word	$L817
	.word	$L817
	.word	$L825
	.word	$L817
	.word	$L817
	.word	$L817
	.word	$L825
	.text
$L825:
	li	$16,1			# 0x00000001
$L817:
	.set	noreorder
	.set	nomacro
	jal	MCRD_getcard
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,0($2)
	li	$3,-1			# 0xffffffff
	bne	$2,$3,$L828
	li	$16,1			# 0x00000001
$L828:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L829
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,152($18)
	.set	noreorder
	.set	nomacro
	j	$L816
	sh	$3,138($18)
	.set	macro
	.set	reorder

$L829:
	move	$4,$18
	move	$5,$19
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$21
	.set	macro
	.set	reorder

$L816:
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

	.end	ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($6)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L833
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,152($4)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L832
	sh	$2,138($4)
	.set	macro
	.set	reorder

$L833:
	jal	ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
$L832:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	ProcessInput__21tDialogNoInputMessage7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__21tDialogNoInputMessage7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__21tDialogNoInputMessage7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	ProcessInput__21tDialogNoInputMessage7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___15tDialogYesNoTri
	.ent	___15tDialogYesNoTri
___15tDialogYesNoTri:
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

	.end	___15tDialogYesNoTri
	.align	2
	.globl	___15tDialogYesNoMem
	.ent	___15tDialogYesNoMem
___15tDialogYesNoMem:
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

	.end	___15tDialogYesNoMem
	.align	2
	.globl	___12tDialogYesNo
	.ent	___12tDialogYesNo
___12tDialogYesNo:
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

	.end	___12tDialogYesNo
	.align	2
	.globl	___18tDialogInteractive
	.ent	___18tDialogInteractive
___18tDialogInteractive:
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

	.end	___18tDialogInteractive
	.align	2
	.globl	___21tDialogNoInputMessage
	.ent	___21tDialogNoInputMessage
___21tDialogNoInputMessage:
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

	.end	___21tDialogNoInputMessage
	.align	2
	.globl	___17tDialogBackUpOnly
	.ent	___17tDialogBackUpOnly
___17tDialogBackUpOnly:
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

	.end	___17tDialogBackUpOnly
	.align	2
	.globl	___20tDialogMessageString
	.ent	___20tDialogMessageString
___20tDialogMessageString:
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

	.end	___20tDialogMessageString
	.align	2
	.globl	___11tDialogHelp
	.ent	___11tDialogHelp
___11tDialogHelp:
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

	.end	___11tDialogHelp
	.align	2
	.globl	___11tDialogBase
	.ent	___11tDialogBase
___11tDialogBase:
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

	.end	___11tDialogBase
	.globl	DialogVisibilityList
	.data
	.align	2
DialogVisibilityList:
	.space	32
	.rdata
	.align	2
kHelpArrayTemplate:
	.byte	1
	.space	1
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
	.half	0
