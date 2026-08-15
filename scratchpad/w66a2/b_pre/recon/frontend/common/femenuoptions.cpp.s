	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\femenuoptions.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.data
	.align	2
flareextra:
	.word	0
	.text
	.align	2
	.globl	CalcPulsateYellow__Fv
	.ent	CalcPulsateYellow__Fv
CalcPulsateYellow__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	subu	$sp,$sp,24
	sw	$31,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$3,$L602
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$2,$3,127
$L602:
	sra	$5,$2,7
	sll	$2,$5,7
	subu	$5,$4,$2
	slt	$2,$5,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L603
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	subu	$5,$2,$5
$L603:
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	lui	$3,%hi(PulsateYellow) # high
	sw	$2,%lo(PulsateYellow)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcPulsateYellow__Fv
	.align	2
	.globl	DrawLeftFlare__FiiiRi
	.ent	DrawLeftFlare__FiiiRi
DrawLeftFlare__FiiiRi:
	.frame	$sp,56,$31		# vars= 0, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$20,48($sp)
	move	$20,$4
	li	$2,128			# 0x00000080
	sw	$31,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L605
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	lw	$2,0($7)
	.set	noreorder
	.set	nomacro
	j	$L614
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L605:
	lw	$2,0($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	addu	$2,$2,5
	.set	macro
	.set	reorder

$L614:
	sw	$2,0($7)
$L606:
	lw	$2,0($7)
	#nop
	slt	$2,$2,61
	bne	$2,$0,$L608
	sw	$0,0($7)
$L608:
	lw	$7,0($7)
	#nop
	slt	$2,$7,31
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	li	$2,60			# 0x0000003c
	.set	macro
	.set	reorder

	subu	$2,$2,$7
	srl	$3,$2,31
	.set	noreorder
	.set	nomacro
	j	$L615
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L609:
	srl	$2,$7,31
	addu	$2,$7,$2
$L615:
	sra	$17,$2,1
	addu	$17,$17,20
	mult	$17,$5
	mflo	$17
	#nop
	li	$3,128			# 0x00000080
	subu	$2,$3,$6
	mult	$17,$2
	mflo	$18
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$18,$L616
	subu	$19,$3,$5
	.set	macro
	.set	reorder

	addu	$18,$18,127
$L616:
	slt	$2,$19,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	sra	$17,$18,7
	.set	macro
	.set	reorder

	move	$19,$6
$L612:
	blez	$17,$L604
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,478			# 0x000001de
	.set	macro
	.set	reorder

	li	$3,1431633920			# 0x55550000
	ori	$3,$3,0x5556
	sll	$7,$17,1
	mult	$7,$3
	move	$16,$2
	move	$4,$16
	addu	$5,$20,5
	srl	$6,$18,31
	addu	$6,$17,$6
	sra	$6,$6,1
	li	$2,23			# 0x00000017
	sra	$7,$7,31
	sw	$2,16($sp)
	mfhi	$8
	#nop
	.set	noreorder
	.set	nomacro
	jal	Flare_2DHalo__Fiiiii
	subu	$7,$8,$7
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	addu	$6,$16,-3
	addu	$7,$20,-1
	sltu	$2,$4,$19
	sw	$19,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L604:
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

	.end	DrawLeftFlare__FiiiRi
	.align	2
	.globl	SubtractiveBox__Fiiiiiiii
	.ent	SubtractiveBox__Fiiiiiiii
SubtractiveBox__Fiiiiiiii:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,28($sp)
	move	$17,$4
	move	$12,$5
	sw	$18,32($sp)
	li	$18,528482304			# 0x1f800000
	ori	$18,$18,0x0004
	li	$10,16711680			# 0x00ff0000
	ori	$10,$10,0xffff
	li	$4,2			# 0x00000002
	move	$5,$4
	sw	$21,44($sp)
	addu	$21,$17,$6
	move	$6,$0
	sw	$19,36($sp)
	addu	$19,$12,$7
	li	$7,256			# 0x00000100
	sw	$20,40($sp)
	li	$20,528482304			# 0x1f800000
	li	$11,-16777216			# 0xff000000
	sw	$31,48($sp)
	sw	$16,24($sp)
	lw	$8,0($18)
	lw	$9,0($20)
	lw	$3,0($8)
	lw	$2,0($9)
	and	$3,$3,$11
	and	$2,$2,$10
	or	$3,$3,$2
	sw	$3,0($8)
	lw	$13,72($sp)
	lw	$14,76($sp)
	lw	$15,80($sp)
	lw	$16,84($sp)
	lw	$2,0($9)
	addu	$3,$8,36
	sw	$3,0($18)
	and	$3,$8,$10
	and	$2,$2,$11
	or	$2,$2,$3
	sw	$2,0($9)
	li	$2,8			# 0x00000008
	sb	$2,3($8)
	li	$2,58			# 0x0000003a
	sw	$13,4($8)
	sw	$14,12($8)
	sw	$15,20($8)
	sw	$16,28($8)
	sb	$2,7($8)
	sh	$17,8($8)
	sh	$12,10($8)
	sh	$21,16($8)
	sh	$12,18($8)
	sh	$17,24($8)
	sh	$19,26($8)
	sh	$21,32($8)
	sh	$19,34($8)
	lw	$16,0($18)
	lw	$8,0($20)
	lw	$3,0($16)
	lw	$2,0($8)
	and	$3,$3,$11
	and	$2,$2,$10
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,12
	lw	$2,0($8)
	and	$10,$16,$10
	sw	$3,0($18)
	and	$2,$2,$11
	or	$2,$2,$10
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	sw	$2,0($8)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	move	$6,$5
	andi	$7,$2,0xffff
	.set	noreorder
	.set	nomacro
	jal	SetDrawMode
	sw	$0,16($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$31,48($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	SubtractiveBox__Fiiiiiiii
	.align	2
	.globl	TransitionOff__27tMenuItemGoToMenuButtonFade
	.ent	TransitionOff__27tMenuItemGoToMenuButtonFade
TransitionOff__27tMenuItemGoToMenuButtonFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,30			# 0x0000001e
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,34($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__27tMenuItemGoToMenuButtonFade
	.align	2
	.globl	TransitionOn__27tMenuItemGoToMenuButtonFade
	.ent	TransitionOn__27tMenuItemGoToMenuButtonFade
TransitionOn__27tMenuItemGoToMenuButtonFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,128			# 0x00000080
	sh	$2,32($4)
	li	$2,-30			# 0xffffffe2
	sh	$2,34($4)
	sh	$0,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,40($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__27tMenuItemGoToMenuButtonFade
	.align	2
	.globl	TransitionIsFinished__27tMenuItemGoToMenuButtonFade
	.ent	TransitionIsFinished__27tMenuItemGoToMenuButtonFade
TransitionIsFinished__27tMenuItemGoToMenuButtonFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,34($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L621
	sw	$0,36($4)
	.set	macro
	.set	reorder

	lh	$2,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L628
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L621:
	lh	$2,34($4)
	#nop
	blez	$2,$L623
	lh	$2,32($4)
	#nop
	slt	$2,$2,128
	beq	$2,$0,$L623
	li	$2,1			# 0x00000001
$L628:
	sw	$2,36($4)
$L623:
	lw	$2,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__27tMenuItemGoToMenuButtonFade
	.align	2
	.globl	UpdateTransition__27tMenuItemGoToMenuButtonFadeb
	.ent	UpdateTransition__27tMenuItemGoToMenuButtonFadeb
UpdateTransition__27tMenuItemGoToMenuButtonFadeb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,32($16)
	lh	$3,34($16)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	move	$17,$5
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L630:
	bgez	$3,$L631
	move	$3,$0
$L631:
	lw	$2,24($16)
	sh	$3,32($16)
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
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

	.end	UpdateTransition__27tMenuItemGoToMenuButtonFadeb
	.align	2
	.globl	__22tMenuItemLeftRightFadeUiP13tListIterator
	.ent	__22tMenuItemLeftRightFadeUiP13tListIterator
__22tMenuItemLeftRightFadeUiP13tListIterator:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightChoiceUiP13tListIterator
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemLeftRightFade_vtable) # high
	addiu	$3,$3,%lo(tMenuItemLeftRightFade_vtable) # low
	sw	$3,24($2)
	sw	$0,40($2)
	sh	$0,8($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__22tMenuItemLeftRightFadeUiP13tListIterator
	.align	2
	.globl	TransitionOff__22tMenuItemLeftRightFade
	.ent	TransitionOff__22tMenuItemLeftRightFade
TransitionOff__22tMenuItemLeftRightFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	sw	$2,36($4)
	li	$2,30			# 0x0000001e
	sh	$2,34($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,32($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__22tMenuItemLeftRightFade
	.align	2
	.globl	TransitionOn__22tMenuItemLeftRightFade
	.ent	TransitionOn__22tMenuItemLeftRightFade
TransitionOn__22tMenuItemLeftRightFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	sw	$2,36($4)
	li	$2,-30			# 0xffffffe2
	sh	$2,34($4)
	li	$2,128			# 0x00000080
	sw	$0,40($4)
	sh	$0,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,32($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__22tMenuItemLeftRightFade
	.align	2
	.globl	TransitionIsFinished__22tMenuItemLeftRightFade
	.ent	TransitionIsFinished__22tMenuItemLeftRightFade
TransitionIsFinished__22tMenuItemLeftRightFade:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,34($4)
	#nop
	beq	$2,$0,$L644
	bgez	$2,$L645
	lh	$2,32($4)
	#nop
	blez	$2,$L644
	lh	$2,34($4)
$L645:
	.set	noreorder
	.set	nomacro
	blez	$2,$L646
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,32($4)
	#nop
	slt	$2,$2,128
	bne	$2,$0,$L642
$L644:
	.set	noreorder
	.set	nomacro
	j	$L639
	sw	$0,36($4)
	.set	macro
	.set	reorder

$L642:
	li	$2,1			# 0x00000001
$L646:
	sw	$2,36($4)
$L639:
	lw	$2,36($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__22tMenuItemLeftRightFade
	.align	2
	.globl	UpdateTransition__22tMenuItemLeftRightFadeb
	.ent	UpdateTransition__22tMenuItemLeftRightFadeb
UpdateTransition__22tMenuItemLeftRightFadeb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,32($16)
	lh	$3,34($16)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L648
	move	$17,$5
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L648:
	bgez	$3,$L649
	move	$3,$0
$L649:
	lw	$2,24($16)
	sh	$3,32($16)
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
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

	.end	UpdateTransition__22tMenuItemLeftRightFadeb
	.align	2
	.globl	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	.ent	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme:
	.frame	$sp,48,$31		# vars= 0, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$8,64($sp)
	lw	$9,68($sp)
	lw	$2,72($sp)
	sw	$17,36($sp)
	lw	$17,76($sp)
	sw	$16,32($sp)
	move	$16,$4
	sw	$18,40($sp)
	lw	$18,80($sp)
	lw	$3,84($sp)
	sw	$31,44($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,88
	lui	$2,%hi(tOptionsMenu_vtable) # high
	lw	$5,84($sp)
	addiu	$2,$2,%lo(tOptionsMenu_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$2,104($16)
	.set	macro
	.set	reorder

	move	$2,$16
	sw	$0,116($2)
	sh	$0,114($2)
	sw	$17,120($2)
	sw	$18,124($2)
	lw	$31,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	__12tOptionsMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsiiP9tMenuIteme
	.align	2
	.globl	_._12tOptionsMenu
	.ent	_._12tOptionsMenu
_._12tOptionsMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tOptionsMenu_vtable) # high
	addiu	$2,$2,%lo(tOptionsMenu_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._5tMenu
	sw	$2,104($4)
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

	.end	_._12tOptionsMenu
	.align	2
	.globl	DebounceKeys__12tOptionsMenu
	.ent	DebounceKeys__12tOptionsMenu
DebounceKeys__12tOptionsMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,8($4)
	#nop
	sll	$2,$2,2
	addu	$4,$4,$2
	lw	$3,16($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L656
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	andi	$2,$2,0x0001
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,24($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L655:
$L656:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DebounceKeys__12tOptionsMenu
	.align	2
	.globl	TransitionOff__12tOptionsMenu
	.ent	TransitionOff__12tOptionsMenu
TransitionOff__12tOptionsMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	lw	$3,16($17)
	li	$2,40			# 0x00000028
	sb	$2,112($17)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L659
	sw	$0,116($17)
	.set	macro
	.set	reorder

$L661:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L661
	move	$16,$3
	.set	macro
	.set	reorder

$L659:
	li	$2,1			# 0x00000001
	sw	$2,108($17)
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

	.end	TransitionOff__12tOptionsMenu
	.align	2
	.globl	TransitionOn__12tOptionsMenu
	.ent	TransitionOn__12tOptionsMenu
TransitionOn__12tOptionsMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	lw	$3,16($17)
	li	$2,-40			# 0xffffffd8
	sb	$2,112($17)
	li	$2,1			# 0x00000001
	sw	$2,108($17)
	li	$2,552			# 0x00000228
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L663
	sw	$2,116($17)
	.set	macro
	.set	reorder

$L667:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	move	$16,$3
	.set	macro
	.set	reorder

$L663:
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

	.end	TransitionOn__12tOptionsMenu
	.align	2
	.globl	TransitionIsFinished__12tOptionsMenu
	.ent	TransitionIsFinished__12tOptionsMenu
TransitionIsFinished__12tOptionsMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,116($17)
	#nop
	slt	$2,$2,552
	bne	$2,$0,$L670
	lb	$2,112($17)
	#nop
	bgtz	$2,$L682
$L670:
	lw	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L683
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lb	$2,112($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L672
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L682:
	.set	noreorder
	.set	nomacro
	j	$L671
	sw	$0,108($17)
	.set	macro
	.set	reorder

$L672:
$L683:
	sw	$2,108($17)
$L671:
	lw	$2,108($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	move	$16,$0
	.set	macro
	.set	reorder

	li	$18,1			# 0x00000001
$L678:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L685
	addu	$2,$16,1
	.set	macro
	.set	reorder

	sw	$18,108($17)
$L685:
	sll	$3,$2,16
	sra	$3,$3,14
	addu	$3,$17,$3
	lw	$3,16($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L678
	move	$16,$2
	.set	macro
	.set	reorder

$L674:
	lui	$2,%hi(FEApp) # high
$L684:
	lw	$2,%lo(FEApp)($2)
	#nop
	lw	$3,12($2)
	#nop
	lw	$2,96($3)
	#nop
	lh	$4,64($2)
	lw	$2,68($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L681
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,108($17)
$L681:
	lw	$2,108($17)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__12tOptionsMenu
	.align	2
	.globl	UpdateTransition__12tOptionsMenu
	.ent	UpdateTransition__12tOptionsMenu
UpdateTransition__12tOptionsMenu:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$2,108($17)
	#nop
	beq	$2,$0,$L687
	lb	$3,112($17)
	#nop
	bgez	$3,$L688
	lw	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L689
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L698
	sw	$2,116($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$0,116($17)
	.set	macro
	.set	reorder

$L689:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	move	$16,$0
	.set	macro
	.set	reorder

$L693:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L694
	addu	$2,$16,1
	.set	macro
	.set	reorder

	sll	$3,$2,16
	sra	$3,$3,14
	addu	$3,$17,$3
	lw	$3,16($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L693
	move	$16,$2
	.set	macro
	.set	reorder

$L694:
	sll	$2,$16,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	beq	$3,$0,$L698
	j	$L699
$L688:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L702
	move	$16,$0
	.set	macro
	.set	reorder

$L703:
	addu	$2,$16,1
	sll	$3,$2,16
	sra	$3,$3,14
	addu	$3,$17,$3
	lw	$3,16($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L703
	move	$16,$2
	.set	macro
	.set	reorder

$L702:
	addu	$2,$16,-1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L706
	move	$18,$3
	.set	macro
	.set	reorder

	sll	$2,$16,16
$L722:
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$3,16($2)
	#nop
	lw	$2,24($3)
	#nop
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L708
	addu	$2,$16,-1
	.set	macro
	.set	reorder

	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L722
	sll	$2,$16,16
	.set	macro
	.set	reorder

$L708:
	sll	$2,$16,16
	sra	$3,$2,16
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L706
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$17,$2
	lw	$3,16($2)
$L699:
	lw	$2,24($3)
	move	$5,$0
	lh	$4,80($2)
	lw	$2,84($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	j	$L698
$L706:
	lw	$3,116($17)
	#nop
	slt	$2,$3,552
	beq	$2,$0,$L698
	lb	$2,112($17)
	#nop
	addu	$2,$3,$2
	sw	$2,116($17)
	slt	$2,$2,553
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L698
	li	$2,552			# 0x00000228
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L698
	sw	$2,116($17)
	.set	macro
	.set	reorder

$L687:
	lw	$2,16($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	move	$16,$0
	.set	macro
	.set	reorder

$L718:
	sll	$2,$16,16
	sra	$6,$2,16
	sll	$2,$6,2
	addu	$2,$17,$2
	lw	$4,16($2)
	#nop
	lw	$2,24($4)
	move	$5,$0
	addu	$7,$2,80
	lh	$2,80($2)
	lw	$3,108($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L719
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	lw	$2,8($17)
	#nop
	xor	$2,$6,$2
	sltu	$5,$2,1
$L719:
	lw	$2,4($7)
	#nop
	jal	$31,$2
	addu	$3,$16,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$17,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L718
	move	$16,$3
	.set	macro
	.set	reorder

$L698:
	lw	$2,104($17)
	#nop
	lh	$4,56($2)
	lw	$2,60($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
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

	.end	UpdateTransition__12tOptionsMenu
	.align	2
	.globl	Draw__12tOptionsMenu
	.ent	Draw__12tOptionsMenu
Draw__12tOptionsMenu:
	.frame	$sp,72,$31		# vars= 24, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,56($sp)
	move	$16,$4
	sw	$31,64($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcPulsateYellow__Fv
	sw	$17,60($sp)
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L725
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L728
$L725:
	sw	$0,8($16)
$L728:
	lw	$3,8($16)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L734
	addu	$3,$3,1
	.set	macro
	.set	reorder

	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L734
	.set	noreorder
	.set	nomacro
	j	$L728
	sw	$3,8($16)
	.set	macro
	.set	reorder

$L734:
	lw	$3,8($16)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L733
	.set	noreorder
	.set	nomacro
	blez	$3,$L733
	addu	$2,$3,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L734
	sw	$2,8($16)
	.set	macro
	.set	reorder

$L733:
	lw	$2,120($16)
	#nop
	bltz	$2,$L738
	lw	$2,124($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L738
	li	$2,13500416			# 0x00ce0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xc844
	sw	$2,36($sp)
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	lw	$3,124($16)
	sra	$2,$2,4
	rem	$3,$2,$3
	li	$5,1040			# 0x00000410
	li	$6,16			# 0x00000010
	lw	$4,120($16)
	move	$7,$6
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$2,$sp,32
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,$3
	.set	macro
	.set	reorder

$L738:
	lw	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	move	$17,$0
	.set	macro
	.set	reorder

$L742:
	sll	$2,$17,16
	sra	$5,$2,16
	sll	$2,$5,2
	addu	$2,$16,$2
	lw	$4,16($2)
	#nop
	lw	$2,24($4)
	move	$7,$0
	addu	$8,$2,40
	lh	$2,40($2)
	lw	$3,108($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L743
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	xor	$2,$5,$2
	sltu	$7,$2,1
$L743:
	move	$5,$0
	lw	$2,4($8)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$3,$17,1
	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$16,$2
	lw	$2,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L742
	move	$17,$3
	.set	macro
	.set	reorder

$L723:
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

	.end	Draw__12tOptionsMenu
	.align	2
	.globl	ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$19,28($sp)
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	GetNumberEnabledItems__5tMenu
	move	$19,$7
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L750
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$0,8($16)
	lw	$3,0($17)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L750
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L751
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($17)
	move	$4,$16
$L750:
$L751:
	move	$5,$18
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$19
	.set	macro
	.set	reorder

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

	.end	ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.ent	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$2,64($sp)
	lw	$3,68($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$6,$sp,72
	lui	$2,%hi(tInsideBoxMenu_vtable) # high
	lw	$5,68($sp)
	addiu	$2,$2,%lo(tInsideBoxMenu_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	sw	$2,104($16)
	.set	macro
	.set	reorder

	move	$2,$16
	sh	$0,108($2)
	sh	$0,110($2)
	sh	$0,112($2)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.align	2
	.globl	_._14tInsideBoxMenu
	.ent	_._14tInsideBoxMenu
_._14tInsideBoxMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tInsideBoxMenu_vtable) # high
	addiu	$2,$2,%lo(tInsideBoxMenu_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._5tMenu
	sw	$2,104($4)
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

	.end	_._14tInsideBoxMenu
	.align	2
	.globl	ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lh	$2,110($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L757
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	lw	$3,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L758
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L765
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

$L758:
	li	$2,1			# 0x00000001
	sw	$2,0($6)
$L757:
	lw	$3,0($6)
	li	$2,512			# 0x00000200
$L765:
	bne	$3,$2,$L760
	lw	$2,8($4)
	#nop
	bne	$2,$0,$L760
	lw	$3,16($4)
	#nop
	lw	$2,24($3)
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

	j	$L756
$L760:
	lw	$3,0($6)
	li	$2,1024			# 0x00000400
	bne	$3,$2,$L763
	lw	$2,8($4)
	#nop
	addu	$2,$2,1
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$2,16($2)
	#nop
	beq	$2,$0,$L756
$L763:
	jal	ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
$L756:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Draw__14tInsideBoxMenusssss
	.ent	Draw__14tInsideBoxMenusssss
Draw__14tInsideBoxMenusssss:
	.frame	$sp,56,$31		# vars= 0, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lh	$2,108($16)
	lw	$3,8($16)
	lhu	$22,72($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L767
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	li	$2,24			# 0x00000018
	.set	macro
	.set	reorder

	sh	$2,110($16)
	.set	noreorder
	.set	nomacro
	j	$L784
	li	$2,-4			# 0xfffffffc
	.set	macro
	.set	reorder

$L768:
	li	$2,-24			# 0xffffffe8
	sh	$2,110($16)
	li	$2,4			# 0x00000004
$L784:
	sh	$2,112($16)
	lhu	$2,8($16)
	#nop
	sh	$2,108($16)
$L767:
	lh	$2,110($16)
	lhu	$4,110($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L785
	move	$17,$0
	.set	macro
	.set	reorder

	lhu	$2,112($16)
	lh	$3,112($16)
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L771
	sh	$2,110($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bgez	$2,$L771
	sh	$0,110($16)
$L771:
	lh	$2,112($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L785
	move	$17,$0
	.set	macro
	.set	reorder

	lh	$2,110($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L786
	sll	$2,$5,16
	.set	macro
	.set	reorder

	sh	$0,110($16)
	move	$17,$0
$L785:
	sll	$2,$5,16
$L786:
	sra	$21,$2,16
	sll	$2,$6,16
	sra	$20,$2,16
	sll	$2,$7,16
	sra	$19,$2,16
$L773:
	lhu	$3,8($16)
	addu	$2,$17,-2
	addu	$3,$3,$2
	sll	$2,$17,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L776
	move	$18,$3
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$2,$2,14
	addu	$2,$2,$16
	lw	$2,12($2)
	#nop
	beq	$2,$0,$L766
$L776:
	sll	$2,$3,16
	sra	$5,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$5,$L777
	sll	$2,$5,2
	.set	macro
	.set	reorder

	addu	$2,$16,$2
	lw	$4,16($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L787
	addu	$2,$17,1
	.set	macro
	.set	reorder

	lw	$2,24($4)
	#nop
	addu	$6,$2,80
	lh	$2,80($2)
	lh	$3,110($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L778
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	xor	$2,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L779
	sltu	$5,$2,1
	.set	macro
	.set	reorder

$L778:
	move	$5,$0
$L779:
	lw	$2,4($6)
	#nop
	jal	$31,$2
	sll	$2,$18,16
	sra	$5,$2,16
	sll	$2,$5,2
	addu	$2,$16,$2
	lw	$4,16($2)
	#nop
	lw	$2,24($4)
	#nop
	addu	$8,$2,48
	lh	$3,48($2)
	sll	$2,$17,16
	sra	$2,$2,16
	addu	$2,$2,-1
	addu	$7,$4,$3
	sll	$4,$22,16
	sra	$4,$4,16
	addu	$4,$20,$4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	lh	$2,110($16)
	addu	$4,$4,$3
	addu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L780
	addu	$6,$4,5
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	xor	$2,$5,$2
	sltu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L781
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L780:
	sw	$0,16($sp)
$L781:
	move	$4,$7
	move	$5,$21
	lw	$2,4($8)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$7,$19
	.set	macro
	.set	reorder

$L777:
	addu	$2,$17,1
$L787:
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,5
	bne	$2,$0,$L773
$L766:
	lw	$31,52($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Draw__14tInsideBoxMenusssss
	.align	2
	.globl	__20tMenuItemSlidingMenuUissssb
	.ent	__20tMenuItemSlidingMenuUissssb
__20tMenuItemSlidingMenuUissssb:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,20($sp)
	lw	$17,64($sp)
	sw	$18,24($sp)
	lw	$18,68($sp)
	sw	$16,16($sp)
	move	$16,$4
	sw	$20,32($sp)
	move	$20,$6
	sw	$21,36($sp)
	sw	$19,28($sp)
	lw	$19,72($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuItemUi
	move	$21,$7
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$3,0($16)
	move	$2,$16
	sw	$0,28($2)
	sw	$0,32($2)
	sh	$20,36($2)
	sh	$21,38($2)
	sh	$0,8($2)
	ori	$3,$3,0x0080
	sw	$3,0($2)
	lui	$3,%hi(tMenuItemSlidingMenu_vtable) # high
	lw	$4,0($2)
	addiu	$3,$3,%lo(tMenuItemSlidingMenu_vtable) # low
	sw	$3,24($2)
	sh	$17,60($2)
	sh	$18,62($2)
	sw	$19,64($2)
	ori	$4,$4,0x0080
	sw	$4,0($2)
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

	.end	__20tMenuItemSlidingMenuUissssb
	.align	2
	.globl	_._20tMenuItemSlidingMenu
	.ent	_._20tMenuItemSlidingMenu
_._20tMenuItemSlidingMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemSlidingMenu_vtable) # high
	addiu	$2,$2,%lo(tMenuItemSlidingMenu_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._9tMenuItem
	sw	$2,24($4)
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

	.end	_._20tMenuItemSlidingMenu
	.align	2
	.globl	TransitionOff__20tMenuItemSlidingMenu
	.ent	TransitionOff__20tMenuItemSlidingMenu
TransitionOff__20tMenuItemSlidingMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,28($4)
	li	$3,1			# 0x00000001
	sh	$0,46($4)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L794
	sw	$3,52($4)
	.set	macro
	.set	reorder

	li	$2,30			# 0x0000001e
	sw	$3,48($4)
	sh	$2,46($4)
	sh	$0,44($4)
$L794:
	j	$31
	.end	TransitionOff__20tMenuItemSlidingMenu
	.align	2
	.globl	TransitionOn__20tMenuItemSlidingMenu
	.ent	TransitionOn__20tMenuItemSlidingMenu
TransitionOn__20tMenuItemSlidingMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$3,38($4)
	li	$2,-30			# 0xffffffe2
	sh	$2,46($4)
	li	$2,1			# 0x00000001
	sw	$2,48($4)
	li	$2,128			# 0x00000080
	sh	$0,40($4)
	sw	$0,52($4)
	sh	$2,44($4)
	sll	$2,$3,16
	sra	$2,$2,17
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$3,42($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__20tMenuItemSlidingMenu
	.align	2
	.globl	TransitionIsFinished__20tMenuItemSlidingMenu
	.ent	TransitionIsFinished__20tMenuItemSlidingMenu
TransitionIsFinished__20tMenuItemSlidingMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,28($4)
	#nop
	beq	$2,$0,$L798
	lw	$2,32($4)
	#nop
	bne	$2,$0,$L797
$L798:
	sh	$0,46($4)
$L807:
	.set	noreorder
	.set	nomacro
	j	$L799
	sw	$0,48($4)
	.set	macro
	.set	reorder

$L797:
	lh	$2,46($4)
	#nop
	beq	$2,$0,$L807
	bgez	$2,$L808
	lh	$2,44($4)
	#nop
	blez	$2,$L807
	lh	$2,46($4)
$L808:
	.set	noreorder
	.set	nomacro
	blez	$2,$L809
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,44($4)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L807
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L809:
	sw	$2,48($4)
$L799:
	lw	$2,48($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__20tMenuItemSlidingMenu
	.align	2
	.globl	UpdateTransition__20tMenuItemSlidingMenub
	.ent	UpdateTransition__20tMenuItemSlidingMenub
UpdateTransition__20tMenuItemSlidingMenub:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,44($16)
	lh	$3,46($16)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L811
	move	$17,$5
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L811:
	bgez	$3,$L812
	move	$3,$0
$L812:
	lw	$2,24($16)
	sh	$3,44($16)
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
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

	.end	UpdateTransition__20tMenuItemSlidingMenub
	.align	2
	.globl	DebounceKeys__20tMenuItemSlidingMenu
	.ent	DebounceKeys__20tMenuItemSlidingMenu
DebounceKeys__20tMenuItemSlidingMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,28($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L814
	li	$2,1536			# 0x00000600
	.set	macro
	.set	reorder

	lw	$2,104($3)
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

	ori	$2,$2,0x0600
$L814:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	DebounceKeys__20tMenuItemSlidingMenu
	.align	2
	.globl	Draw__20tMenuItemSlidingMenub
	.ent	Draw__20tMenuItemSlidingMenub
Draw__20tMenuItemSlidingMenub:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,24($4)
	move	$7,$5
	lh	$2,40($3)
	move	$5,$0
	addu	$4,$4,$2
	lw	$2,44($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
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

	.end	Draw__20tMenuItemSlidingMenub
	.align	2
	.globl	UpdatefOpenHeight__20tMenuItemSlidingMenub
	.ent	UpdatefOpenHeight__20tMenuItemSlidingMenub
UpdatefOpenHeight__20tMenuItemSlidingMenub:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,40($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L817
	sw	$0,56($4)
	.set	macro
	.set	reorder

	lhu	$3,38($4)
	#nop
	sll	$2,$3,16
	sra	$2,$2,17
	addu	$3,$3,$2
	sh	$3,42($4)
$L817:
	lw	$3,32($4)
	lw	$2,28($4)
	#nop
	beq	$3,$2,$L818
	lh	$2,40($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L818
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	bgez	$2,$L819
	move	$2,$0
$L819:
	sh	$2,40($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L820
	sw	$2,56($4)
	.set	macro
	.set	reorder

$L818:
	lw	$2,32($4)
	#nop
	bne	$2,$0,$L821
	lh	$3,44($4)
	#nop
	slt	$2,$3,128
	beq	$2,$0,$L823
	lw	$2,48($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L820
	addu	$3,$3,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L848
	slt	$2,$3,129
	.set	macro
	.set	reorder

$L821:
	lh	$3,44($4)
$L823:
	blez	$3,$L827
	lw	$2,28($4)
	#nop
	bne	$2,$0,$L827
	lw	$2,32($4)
	#nop
	beq	$2,$0,$L827
	lw	$2,48($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L828
	addu	$2,$3,-40
	.set	macro
	.set	reorder

	bgez	$2,$L829
	move	$2,$0
$L829:
	sh	$2,44($4)
$L828:
	lw	$2,52($4)
	#nop
	bne	$2,$0,$L820
	lw	$2,32($4)
	.set	noreorder
	.set	nomacro
	j	$L820
	sw	$2,28($4)
	.set	macro
	.set	reorder

$L827:
	lw	$3,32($4)
	lw	$2,52($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L820
	sw	$3,28($4)
	.set	macro
	.set	reorder

	lw	$2,48($4)
	#nop
	bne	$2,$0,$L820
	beq	$3,$0,$L826
	lh	$2,44($4)
	#nop
	addu	$2,$2,-40
	bgez	$2,$L834
	move	$2,$0
$L834:
	.set	noreorder
	.set	nomacro
	j	$L820
	sh	$2,44($4)
	.set	macro
	.set	reorder

$L826:
	lh	$2,44($4)
	#nop
	addu	$3,$2,40
	slt	$2,$3,129
$L848:
	bne	$2,$0,$L835
	li	$3,128			# 0x00000080
$L835:
	sh	$3,44($4)
$L820:
	lw	$2,28($4)
	#nop
	beq	$2,$0,$L847
	beq	$5,$0,$L837
	lw	$2,56($4)
	#nop
	bne	$2,$0,$L838
	lh	$6,40($4)
	lh	$3,38($4)
	#nop
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	addu	$6,$6,4
	.set	macro
	.set	reorder

	slt	$2,$6,$3
	beq	$2,$0,$L840
	move	$3,$6
$L840:
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L838
	sh	$3,40($4)
	.set	macro
	.set	reorder

$L839:
	lh	$2,42($4)
	#nop
	addu	$2,$2,-6
	bgez	$2,$L842
	move	$2,$0
$L842:
	sh	$2,42($4)
$L838:
	bne	$5,$0,$L847
$L837:
	lh	$2,40($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L847
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	bgez	$2,$L845
	move	$2,$0
$L845:
	sh	$2,40($4)
$L847:
	j	$31
	.end	UpdatefOpenHeight__20tMenuItemSlidingMenub
	.align	2
	.globl	Draw__20tMenuItemSlidingMenuiib
	.ent	Draw__20tMenuItemSlidingMenuiib
Draw__20tMenuItemSlidingMenuiib:
	.frame	$sp,120,$31		# vars= 48, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$22,104($sp)
	move	$22,$4
	sw	$16,80($sp)
	move	$16,$5
	sw	$17,84($sp)
	move	$17,$6
	sw	$31,116($sp)
	sw	$fp,112($sp)
	sw	$23,108($sp)
	sw	$21,100($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$18,88($sp)
	lw	$2,24($22)
	move	$5,$7
	lh	$4,88($2)
	lw	$2,92($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$22,$4
	.set	macro
	.set	reorder

	lh	$5,8($22)
	lh	$6,44($22)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$4,4($22)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	sw	$2,56($sp)
	.set	macro
	.set	reorder

	lw	$4,4($22)
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sw	$2,60($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(fHelpText) # high
	li	$3,-1			# 0xffffffff
	sw	$3,%lo(fHelpText)($4)
	lui	$3,%hi(gHelpShapes) # high
	addu	$2,$2,$17
	sw	$2,64($sp)
	lui	$2,%hi(menuDefs) # high
	lw	$3,%lo(gHelpShapes)($3)
	lw	$2,%lo(menuDefs)($2)
	addu	$3,$3,960
	sw	$3,68($sp)
	lw	$3,28($22)
	addu	$2,$2,10072
	xor	$3,$3,$2
	sltu	$3,$3,1
	sw	$3,72($sp)
	lh	$6,44($22)
	li	$2,128			# 0x00000080
	beq	$6,$2,$L850
	beq	$3,$0,$L850
	lui	$7,%hi(flareextra) # high
	lw	$4,64($sp)
	lh	$5,8($22)
	.set	noreorder
	.set	nomacro
	jal	DrawLeftFlare__FiiiRi
	addiu	$7,$7,%lo(flareextra) # low
	.set	macro
	.set	reorder

$L850:
	lw	$2,28($22)
	#nop
	bne	$2,$0,$L852
	lw	$10,72($sp)
	#nop
	beq	$10,$0,$L865
$L852:
	lw	$10,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$10,$0,$L854
	li	$16,220			# 0x000000dc
	.set	macro
	.set	reorder

	lh	$16,36($22)
$L854:
	move	$4,$0
	lh	$6,8($22)
	lh	$7,44($22)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	lw	$10,64($sp)
	#nop
	addu	$7,$10,-2
	lw	$10,68($sp)
	sw	$2,36($sp)
	lh	$2,16($10)
	lw	$10,60($sp)
	#nop
	addu	$17,$10,$16
	subu	$2,$17,$2
	lw	$10,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L855
	addu	$6,$2,-10
	.set	macro
	.set	reorder

	lw	$10,64($sp)
	#nop
	addu	$7,$10,-3
$L855:
	li	$4,57			# 0x00000039
	li	$5,24			# 0x00000018
	li	$18,1			# 0x00000001
	addu	$16,$sp,32
	sw	$0,16($sp)
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$10,68($sp)
	#nop
	lh	$2,16($10)
	lw	$10,64($sp)
	#nop
	addu	$7,$10,4
	subu	$2,$17,$2
	lw	$10,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L856
	addu	$6,$2,-10
	.set	macro
	.set	reorder

	lw	$10,64($sp)
	#nop
	addu	$7,$10,3
$L856:
	li	$4,58			# 0x0000003a
	li	$5,24			# 0x00000018
	sw	$0,16($sp)
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lw	$2,28($22)
$L865:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	li	$17,5242880			# 0x00500000
	.set	macro
	.set	reorder

	ori	$17,$17,0x5050
	lui	$2,%hi(Draw_gPlayer1View) # high
	lw	$4,%lo(Draw_gPlayer1View)($2)
	lui	$2,%hi(gFlip) # high
	lh	$3,60($22)
	lw	$5,%lo(gFlip)($2)
	lw	$10,60($sp)
	lh	$2,62($22)
	lhu	$18,40($22)
	lh	$fp,36($22)
	addu	$20,$10,$3
	lw	$10,64($sp)
	sll	$18,$18,16
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	addu	$21,$10,$2
	.set	macro
	.set	reorder

	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	lw	$4,0($9)
	addu	$5,$sp,32
	sh	$0,32($sp)
	sw	$2,76($sp)
	lhu	$3,2($2)
	li	$2,512			# 0x00000200
	sh	$2,36($sp)
	lui	$2,%hi(screenheight) # high
	lhu	$2,%lo(screenheight)($2)
	lw	$6,528482304
	li	$8,-16777216			# 0xff000000
	sh	$3,34($sp)
	sh	$2,38($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$21
	move	$6,$fp
	sra	$16,$18,17
	move	$7,$16
	sw	$17,16($sp)
	sw	$17,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$21,$16
	move	$6,$fp
	move	$7,$16
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SubtractiveBox__Fiiiiiiii
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$5,$20,16
	sra	$5,$5,16
	sll	$6,$21,16
	sra	$6,$6,16
	move	$7,$fp
	lw	$8,28($22)
	lhu	$2,42($22)
	lw	$9,104($8)
	sll	$2,$2,17
	lh	$4,88($9)
	sra	$2,$2,16
	sw	$2,16($sp)
	lui	$2,%hi(gHelpShapes) # high
	lw	$3,%lo(gHelpShapes)($2)
	lh	$2,38($22)
	addu	$4,$8,$4
	addu	$23,$3,992
	sw	$2,20($sp)
	lw	$2,92($9)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$19,$3,1024
	.set	macro
	.set	reorder

	lw	$2,64($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	sra	$18,$18,16
	.set	macro
	.set	reorder

	lh	$2,18($23)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L858
	li	$4,31			# 0x0000001f
	.set	macro
	.set	reorder

	li	$5,12			# 0x0000000c
	move	$6,$20
	move	$7,$21
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	li	$4,31			# 0x0000001f
	li	$5,8			# 0x00000008
	move	$7,$21
	lh	$6,16($23)
	addu	$17,$20,$fp
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$6,$17,$6
	.set	macro
	.set	reorder

	li	$4,32			# 0x00000020
	li	$5,12			# 0x0000000c
	move	$6,$20
	lh	$7,18($19)
	addu	$16,$21,$18
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$7,$16,$7
	.set	macro
	.set	reorder

	li	$4,32			# 0x00000020
	lh	$6,16($19)
	lh	$7,18($19)
	li	$5,8			# 0x00000008
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	subu	$6,$17,$6
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$7,$16,$7
	.set	macro
	.set	reorder

$L858:
	move	$4,$0
	lh	$7,16($23)
	lh	$2,16($19)
	move	$6,$21
	sw	$18,16($sp)
	addu	$5,$20,$7
	addu	$5,$5,5
	subu	$7,$fp,$7
	subu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$7,$7,-10
	.set	macro
	.set	reorder

	lh	$3,18($23)
	lh	$4,18($19)
	#nop
	addu	$2,$3,$4
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L859
	subu	$2,$18,$3
	.set	macro
	.set	reorder

	subu	$2,$2,$4
	sw	$2,16($sp)
	move	$4,$0
	move	$5,$20
	addu	$6,$21,$3
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	move	$7,$fp
	.set	macro
	.set	reorder

$L859:
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	li	$7,16711680			# 0x00ff0000
	ori	$7,$7,0xffff
	lw	$4,0($9)
	lw	$10,76($sp)
	lw	$6,528482304
	addu	$5,$sp,40
	sh	$20,40($sp)
	lhu	$2,2($10)
	li	$8,-16777216			# 0xff000000
	sh	$fp,44($sp)
	sh	$18,46($sp)
	addu	$2,$2,$21
	sh	$2,42($sp)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$8
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($6)
	addu	$3,$4,12
	sw	$3,0($9)
	and	$3,$4,$7
	and	$2,$2,$8
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	SetDrawArea
	sw	$2,0($6)
	.set	macro
	.set	reorder

	lui	$16,%hi(fHelpText) # high
	lw	$4,%lo(fHelpText)($16)
	li	$2,-1			# 0xffffffff
	beq	$4,$2,$L860
	jal	TextSys_Word__Fi
	lw	$4,%lo(fHelpText)($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,%lo(fHelpText)($16)
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	lui	$3,%hi(PulsateYellow) # high
	sll	$2,$2,16
	sra	$6,$2,16
	lw	$7,%lo(PulsateYellow)($3)
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L860:
	lw	$4,4($22)
	jal	TextSys_Word__Fi
	lw	$10,60($sp)
	move	$4,$2
	sw	$0,16($sp)
	sll	$2,$10,16
	lw	$10,64($sp)
	sra	$5,$2,16
	sll	$2,$10,16
	lw	$10,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L861
	sra	$6,$2,16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L862
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L861:
	sw	$0,20($sp)
$L862:
	lw	$7,56($sp)
	jal	FETextRender_FullTextRGB__FPcssics
	li	$4,30			# 0x0000001e
	li	$5,8			# 0x00000008
	lw	$10,64($sp)
	lh	$6,36($22)
	addu	$16,$10,-2
	lw	$10,68($sp)
	lh	$3,44($22)
	lh	$2,16($10)
	lw	$10,60($sp)
	move	$7,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	sw	$3,16($sp)
	addu	$6,$10,$6
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$6,$6,$2
	.set	macro
	.set	reorder

	lw	$2,64($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L849
	move	$4,$0
	.set	macro
	.set	reorder

	move	$6,$16
	lw	$5,60($sp)
	lw	$10,68($sp)
	lh	$2,36($22)
	lh	$7,16($10)
	lh	$3,18($10)
	subu	$7,$2,$7
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L849:
	lw	$31,116($sp)
	lw	$fp,112($sp)
	lw	$23,108($sp)
	lw	$22,104($sp)
	lw	$21,100($sp)
	lw	$20,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Draw__20tMenuItemSlidingMenuiib
	.align	2
	.globl	ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,32($sp)
	sw	$19,28($sp)
	lh	$3,40($16)
	lh	$2,38($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L867
	move	$19,$7
	.set	macro
	.set	reorder

	lw	$3,28($16)
	#nop
	beq	$3,$0,$L867
	lw	$2,104($3)
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

$L867:
	lw	$3,0($17)
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L870
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,0($17)
$L870:
	move	$5,$18
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$19
	.set	macro
	.set	reorder

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

	.end	ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
	.ent	SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L872
	sw	$6,32($4)
	.set	macro
	.set	reorder

	sw	$6,28($4)
$L872:
	lw	$2,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L873
	li	$3,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder

$L873:
	lw	$2,0($4)
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder

	.end	SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
	.align	2
	.globl	UpdatefOpenHeight__25tMenuItemSlidingActivatedb
	.ent	UpdatefOpenHeight__25tMenuItemSlidingActivatedb
UpdatefOpenHeight__25tMenuItemSlidingActivatedb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,68($4)
	#nop
	beq	$2,$0,$L876
	lhu	$2,42($4)
	.set	noreorder
	.set	nomacro
	j	$L881
	addu	$2,$2,-3
	.set	macro
	.set	reorder

$L876:
	lhu	$2,42($4)
	#nop
	addu	$2,$2,3
$L881:
	sh	$2,42($4)
	lhu	$2,38($4)
	lh	$5,42($4)
	sll	$2,$2,16
	sra	$3,$2,16
	sra	$2,$2,17
	addu	$3,$3,$2
	slt	$2,$5,$3
	beq	$2,$0,$L878
	move	$3,$5
$L878:
	bgez	$3,$L879
	move	$3,$0
$L879:
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$3,42($4)
	.set	macro
	.set	reorder

	.end	UpdatefOpenHeight__25tMenuItemSlidingActivatedb
	.align	2
	.globl	TransitionOff__25tMenuItemSlidingActivated
	.ent	TransitionOff__25tMenuItemSlidingActivated
TransitionOff__25tMenuItemSlidingActivated:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,28($4)
	li	$3,1			# 0x00000001
	sh	$0,46($4)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L885
	sw	$3,52($4)
	.set	macro
	.set	reorder

	li	$2,30			# 0x0000001e
	sw	$3,48($4)
	sh	$2,46($4)
	sh	$0,44($4)
$L885:
	j	$31
	.end	TransitionOff__25tMenuItemSlidingActivated
	.align	2
	.globl	TransitionOn__25tMenuItemSlidingActivated
	.ent	TransitionOn__25tMenuItemSlidingActivated
TransitionOn__25tMenuItemSlidingActivated:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$3,38($4)
	li	$2,-30			# 0xffffffe2
	sh	$2,46($4)
	li	$2,1			# 0x00000001
	sw	$2,48($4)
	li	$2,128			# 0x00000080
	sw	$0,68($4)
	sw	$0,52($4)
	sh	$2,44($4)
	sll	$2,$3,16
	sra	$2,$2,17
	move	$5,$3
	addu	$3,$3,$2
	sh	$3,42($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,40($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__25tMenuItemSlidingActivated
	.align	2
	.globl	TransitionIsFinished__25tMenuItemSlidingActivated
	.ent	TransitionIsFinished__25tMenuItemSlidingActivated
TransitionIsFinished__25tMenuItemSlidingActivated:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,28($4)
	#nop
	beq	$2,$0,$L890
	lw	$2,32($4)
	#nop
	bne	$2,$0,$L889
$L890:
	sh	$0,46($4)
$L900:
	.set	noreorder
	.set	nomacro
	j	$L891
	sw	$0,48($4)
	.set	macro
	.set	reorder

$L889:
	lh	$2,46($4)
	#nop
	beq	$2,$0,$L900
	bgez	$2,$L901
	lh	$2,44($4)
	#nop
	blez	$2,$L900
	lh	$2,46($4)
$L901:
	.set	noreorder
	.set	nomacro
	blez	$2,$L902
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,44($4)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L900
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L902:
	sw	$2,48($4)
$L891:
	lw	$2,48($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__25tMenuItemSlidingActivated
	.align	2
	.globl	UpdateTransition__25tMenuItemSlidingActivatedb
	.ent	UpdateTransition__25tMenuItemSlidingActivatedb
UpdateTransition__25tMenuItemSlidingActivatedb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,44($16)
	lh	$3,46($16)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L904
	move	$17,$5
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L904:
	bgez	$3,$L905
	move	$3,$0
$L905:
	lw	$2,24($16)
	sh	$3,44($16)
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
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

	.end	UpdateTransition__25tMenuItemSlidingActivatedb
	.rdata
	.align	2
$LC0:
	.ascii	"amus\000"
	.align	2
$LC1:
	.ascii	"zmenu*\000"
	.align	2
$LC2:
	.ascii	"ymus\000"
	.align	2
$LC3:
	.ascii	"game*\000"
	.align	2
$LC4:
	.ascii	"*\000"
	.text
	.align	2
	.globl	ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$20,32($sp)
	sw	$31,36($sp)
	sw	$16,16($sp)
	lw	$3,0($18)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L908
	move	$20,$7
	.set	macro
	.set	reorder

	li	$2,16			# 0x00000010
	bne	$3,$2,$L911
	lw	$2,68($17)
	#nop
	beq	$2,$0,$L911
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,20			# 0x00000014
	li	$2,1			# 0x00000001
	sw	$0,68($17)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	sw	$2,0($18)
	.set	macro
	.set	reorder

	lui	$16,%hi(screenAudio) # high
	lw	$2,%lo(screenAudio)($16)
	#nop
	lw	$4,120($2)
	#nop
	beq	$4,$0,$L922
	jal	purgememadr
	lw	$2,%lo(screenAudio)($16)
$L922:
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysCleanUp__Fv
	sw	$0,120($2)
	.set	macro
	.set	reorder

	li	$4,55296			# 0x0000d800
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x8000
	lui	$6,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC0) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo($LC1) # low
	.set	macro
	.set	reorder

	j	$L911
$L908:
	lw	$2,68($17)
	#nop
	bne	$2,$0,$L911
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,20			# 0x00000014
	li	$2,1			# 0x00000001
	sw	$2,68($17)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	sw	$2,0($18)
	.set	macro
	.set	reorder

	jal	AudioMus_SysCleanUp__Fv
	li	$4,49152			# 0x0000c000
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x8000
	lui	$6,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC2) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	addiu	$4,$4,%lo($LC3) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC4) # high
	addiu	$4,$4,%lo($LC4) # low
	.set	noreorder
	.set	nomacro
	jal	AudioMus_GetSongList__FPci
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($3)
	#nop
	sw	$2,120($3)
$L911:
	lh	$2,42($17)
	#nop
	bne	$2,$0,$L917
	lw	$2,68($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L923
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,28($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L918
	move	$5,$19
	.set	macro
	.set	reorder

	move	$6,$18
	lw	$2,104($3)
	move	$7,$20
	lh	$4,24($2)
	lw	$2,28($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L917:
	lw	$2,68($17)
$L918:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L915
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	lw	$3,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L920
	li	$2,1024			# 0x00000400
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L923
	move	$4,$17
	.set	macro
	.set	reorder

$L920:
	li	$2,1			# 0x00000001
	sw	$2,0($18)
$L915:
	move	$4,$17
$L923:
	move	$5,$19
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$20
	.set	macro
	.set	reorder

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

	.end	ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	MyLeftRightDraw__22tMenuItemLeftRightFadeii
	.ent	MyLeftRightDraw__22tMenuItemLeftRightFadeii
MyLeftRightDraw__22tMenuItemLeftRightFadeii:
	.frame	$sp,72,$31		# vars= 24, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$16,56($sp)
	move	$16,$4
	sw	$18,64($sp)
	move	$18,$5
	sw	$17,60($sp)
	move	$17,$6
	li	$4,13107200			# 0x00c80000
	ori	$4,$4,0x3c1e
	sw	$31,68($sp)
	lh	$6,8($16)
	lh	$7,32($16)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$2,36($sp)
	lh	$5,8($16)
	lh	$6,32($16)
	.set	noreorder
	.set	nomacro
	jal	DrawLeftFlare__FiiiRi
	addu	$7,$16,40
	.set	macro
	.set	reorder

	lh	$5,8($16)
	lh	$6,32($16)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$18,16
	sra	$5,$5,16
	sll	$6,$17,16
	sra	$6,$6,16
	move	$7,$16
	li	$2,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	li	$4,46			# 0x0000002e
	li	$5,24			# 0x00000018
	addu	$6,$18,26
	addu	$17,$17,1
	move	$7,$17
	addu	$16,$sp,32
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	li	$4,47			# 0x0000002f
	li	$5,24			# 0x00000018
	addu	$6,$18,200
	move	$7,$17
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lw	$31,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	MyLeftRightDraw__22tMenuItemLeftRightFadeii
	.align	2
	.globl	Draw__31tMenuItemDisplayLeftRightChoiceiib
	.ent	Draw__31tMenuItemDisplayLeftRightChoiceiib
Draw__31tMenuItemDisplayLeftRightChoiceiib:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$4
	sw	$16,24($sp)
	move	$16,$5
	sw	$18,32($sp)
	sw	$31,40($sp)
	sw	$17,28($sp)
	lh	$3,32($19)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L928
	move	$18,$6
	.set	macro
	.set	reorder

	lw	$4,4($19)
	jal	TextSys_WordX__Fi
	lw	$4,4($19)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$17,$2,$16
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	lh	$5,8($19)
	lh	$6,32($19)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	addu	$16,$2,$18
	.set	macro
	.set	reorder

	move	$4,$19
	sll	$5,$17,16
	sra	$5,$5,16
	sll	$16,$16,16
	sra	$16,$16,16
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	MyLeftRightDraw__22tMenuItemLeftRightFadeii
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$6,28($19)
	lui	$2,%hi(gMenu_SubMenuPlayer) # high
	lw	$3,12($6)
	lw	$5,%lo(gMenu_SubMenuPlayer)($2)
	lh	$4,24($3)
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$2,16
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$17,$17,115
	sll	$17,$17,16
	sra	$5,$17,16
	move	$6,$16
	li	$2,2			# 0x00000002
	move	$7,$18
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L928:
	lw	$31,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Draw__31tMenuItemDisplayLeftRightChoiceiib
	.align	2
	.globl	TransitionOn__29tMenuItemOnOffLeftRightChoice
	.ent	TransitionOn__29tMenuItemOnOffLeftRightChoice
TransitionOn__29tMenuItemOnOffLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$2,28($16)
	#nop
	lw	$3,12($2)
	#nop
	lh	$4,16($3)
	#nop
	addu	$4,$2,$4
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$4,$16
	andi	$2,$2,0x00ff
	sltu	$2,$0,$2
	sll	$2,$2,7
	.set	noreorder
	.set	nomacro
	jal	TransitionOn__22tMenuItemLeftRightFade
	sh	$2,44($4)
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

	.end	TransitionOn__29tMenuItemOnOffLeftRightChoice
	.align	2
	.globl	Draw__29tMenuItemOnOffLeftRightChoiceiib
	.ent	Draw__29tMenuItemOnOffLeftRightChoiceiib
Draw__29tMenuItemOnOffLeftRightChoiceiib:
	.frame	$sp,56,$31		# vars= 8, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$16,32($sp)
	move	$16,$5
	sw	$19,44($sp)
	sw	$31,48($sp)
	sw	$17,36($sp)
	lh	$3,32($18)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L937
	move	$19,$6
	.set	macro
	.set	reorder

	lw	$3,28($18)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	beq	$2,$0,$L933
	lhu	$2,44($18)
	.set	noreorder
	.set	nomacro
	j	$L938
	addu	$2,$2,32
	.set	macro
	.set	reorder

$L933:
	lhu	$2,44($18)
	#nop
	addu	$2,$2,-32
$L938:
	sh	$2,44($18)
	lh	$2,44($18)
	#nop
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L935
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,44($18)
$L935:
	lh	$2,44($18)
	#nop
	bgez	$2,$L936
	sh	$0,44($18)
$L936:
	lw	$4,4($18)
	jal	TextSys_WordX__Fi
	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$17,$2,$16
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	lh	$5,44($18)
	lh	$6,8($18)
	lh	$7,32($18)
	addu	$3,$sp,24
	sw	$3,16($sp)
	addu	$3,$sp,28
	addu	$16,$2,$19
	.set	noreorder
	.set	nomacro
	jal	CalcOnOffFade__F13tMenuTextTypesssRiT4
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	sll	$5,$17,16
	sra	$5,$5,16
	sll	$16,$16,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	MyLeftRightDraw__22tMenuItemLeftRightFadeii
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,102			# 0x00000066
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$17,55
	sll	$5,$5,16
	sra	$5,$5,16
	lw	$7,24($sp)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,103			# 0x00000067
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$17,$17,158
	sll	$17,$17,16
	sra	$5,$17,16
	lw	$7,28($sp)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L937:
	lw	$31,48($sp)
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

	.end	Draw__29tMenuItemOnOffLeftRightChoiceiib
	.align	2
	.globl	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	.ent	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
__29tMenuItemLeftRightAudioSliderUiP13tListIteratori:
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
	jal	__24tMenuItemLeftRightSliderUiP13tListIterator
	move	$17,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tMenuItemLeftRightAudioSlider_vtable) # high
	addiu	$3,$3,%lo(tMenuItemLeftRightAudioSlider_vtable) # low
	sw	$3,24($2)
	sh	$17,48($2)
	sw	$0,52($2)
	sh	$0,8($2)
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

	.end	__29tMenuItemLeftRightAudioSliderUiP13tListIteratori
	.align	2
	.globl	_._29tMenuItemLeftRightAudioSlider
	.ent	_._29tMenuItemLeftRightAudioSlider
_._29tMenuItemLeftRightAudioSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tMenuItemLeftRightAudioSlider_vtable) # high
	addiu	$2,$2,%lo(tMenuItemLeftRightAudioSlider_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightSlider
	sw	$2,24($4)
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

	.end	_._29tMenuItemLeftRightAudioSlider
	.align	2
	.globl	Draw__29tMenuItemLeftRightAudioSlideriib
	.ent	Draw__29tMenuItemLeftRightAudioSlideriib
Draw__29tMenuItemLeftRightAudioSlideriib:
	.frame	$sp,104,$31		# vars= 24, regs= 5/0, args= 56, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$19,92($sp)
	move	$19,$4
	sw	$16,80($sp)
	move	$16,$5
	sw	$31,96($sp)
	sw	$18,88($sp)
	sw	$17,84($sp)
	lw	$4,4($19)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$4,4($19)
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sh	$2,32($19)
	.set	macro
	.set	reorder

	addu	$2,$2,$17
	lui	$17,%hi(kRGBVals) # high
	lh	$4,4($19)
	addiu	$17,$17,%lo(kRGBVals) # low
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordFlags__Fi
	sh	$2,34($19)
	.set	macro
	.set	reorder

	lui	$16,%hi(textDefinitions) # high
	addiu	$16,$16,%lo(textDefinitions) # low
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$3,$16
	lbu	$2,5($3)
	lh	$4,4($19)
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$18,0($2)
	jal	TextSys_WordFlags__Fi
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$3,$3,$16
	lh	$4,34($19)
	lh	$5,8($19)
	lbu	$2,4($3)
	lh	$6,40($19)
	sll	$2,$2,2
	addu	$2,$2,$17
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	jal	DrawLeftFlare__FiiiRi
	addu	$7,$19,52
	.set	macro
	.set	reorder

	move	$5,$18
	lh	$6,8($19)
	lh	$7,40($19)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
	lh	$3,40($19)
	li	$2,128			# 0x00000080
	beq	$3,$2,$L944
	lw	$4,4($19)
	jal	TextSys_Word__Fi
	move	$4,$2
	move	$7,$16
	lh	$5,32($19)
	lh	$6,34($19)
	li	$2,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	li	$4,5570560			# 0x00550000
	ori	$4,$4,0x1e00
	lh	$6,8($19)
	lh	$7,40($19)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	sw	$2,60($sp)
	lh	$2,8($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L945
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$6,$0
	move	$7,$6
	lh	$4,48($19)
	addu	$2,$sp,56
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L945:
	lw	$3,28($19)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$4,$2,0x00ff
	lhu	$3,34($19)
	lw	$2,28($19)
	lhu	$7,32($19)
	addu	$3,$3,1
	sll	$3,$3,16
	lbu	$5,8($2)
	lbu	$6,9($2)
	sra	$3,$3,16
	sw	$3,16($sp)
	lh	$2,36($19)
	addu	$7,$7,20
	sw	$2,20($sp)
	lh	$3,38($19)
	li	$2,4			# 0x00000004
	sw	$2,28($sp)
	sw	$2,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$3,24($sp)
	lh	$2,8($19)
	sll	$7,$7,16
	sw	$2,44($sp)
	lh	$2,40($19)
	sra	$7,$7,16
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$2,48($sp)
	.set	macro
	.set	reorder

$L944:
	lw	$31,96($sp)
	lw	$19,92($sp)
	lw	$18,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Draw__29tMenuItemLeftRightAudioSlideriib
	.align	2
	.globl	Percentage__29tMenuItemLeftRightAudioSlider
	.ent	Percentage__29tMenuItemLeftRightAudioSlider
Percentage__29tMenuItemLeftRightAudioSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$3,28($16)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$6,28($16)
	li	$5,-1			# 0xffffffff
	lbu	$4,8($6)
	andi	$2,$2,0x00ff
	subu	$2,$2,$4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,3
	addu	$3,$3,$2
	sll	$16,$3,2
	lbu	$2,9($6)
	lw	$3,12($6)
	subu	$2,$2,$4
	div	$16,$16,$2
	lh	$4,16($3)
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L947
	slt	$2,$16,100
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L948
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L947:
	move	$2,$16
$L948:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Percentage__29tMenuItemLeftRightAudioSlider
	.align	2
	.globl	TransitionOff__29tMenuItemLeftRightAudioSlider
	.ent	TransitionOff__29tMenuItemLeftRightAudioSlider
TransitionOff__29tMenuItemLeftRightAudioSlider:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,60			# 0x0000003c
	sh	$0,40($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,42($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__29tMenuItemLeftRightAudioSlider
	.align	2
	.globl	TransitionOn__29tMenuItemLeftRightAudioSlider
	.ent	TransitionOn__29tMenuItemLeftRightAudioSlider
TransitionOn__29tMenuItemLeftRightAudioSlider:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,128			# 0x00000080
	sh	$2,40($4)
	li	$2,-60			# 0xffffffc4
	sh	$2,42($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,8($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__29tMenuItemLeftRightAudioSlider
	.align	2
	.globl	TransitionIsFinished__29tMenuItemLeftRightAudioSlider
	.ent	TransitionIsFinished__29tMenuItemLeftRightAudioSlider
TransitionIsFinished__29tMenuItemLeftRightAudioSlider:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,42($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L952
	sw	$0,44($4)
	.set	macro
	.set	reorder

	lh	$2,40($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L952
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,44($4)
$L952:
	lh	$2,42($4)
	#nop
	blez	$2,$L953
	lh	$2,40($4)
	#nop
	slt	$2,$2,128
	beq	$2,$0,$L953
	li	$2,1			# 0x00000001
	sw	$2,44($4)
$L953:
	lw	$2,44($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__29tMenuItemLeftRightAudioSlider
	.align	2
	.globl	UpdateTransition__29tMenuItemLeftRightAudioSliderb
	.ent	UpdateTransition__29tMenuItemLeftRightAudioSliderb
UpdateTransition__29tMenuItemLeftRightAudioSliderb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lh	$2,40($4)
	lh	$3,42($4)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	bne	$2,$0,$L955
	li	$3,128			# 0x00000080
$L955:
	bgez	$3,$L956
	move	$3,$0
$L956:
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
	sh	$3,40($4)
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

	.end	UpdateTransition__29tMenuItemLeftRightAudioSliderb
	.align	2
	.globl	__18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.ent	__18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
__18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$2,64($sp)
	lw	$3,68($sp)
	sw	$31,36($sp)
	sll	$2,$2,16
	sra	$2,$2,16
	sw	$8,16($sp)
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$3,$16
	lui	$2,%hi(tInsideBoxSongMenu_vtable) # high
	addiu	$2,$2,%lo(tInsideBoxSongMenu_vtable) # low
	sw	$2,104($16)
$L963:
	sh	$0,126($3)
	sh	$0,116($3)
	addu	$4,$4,1
	slt	$2,$4,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L963
	addu	$3,$3,2
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,68($sp)
	.set	noreorder
	.set	nomacro
	jal	tMenuConstructor__5tMenuP9tMenuItemPv
	addu	$6,$sp,72
	.set	macro
	.set	reorder

	move	$2,$16
	sh	$0,110($2)
	sh	$0,112($2)
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__18tInsideBoxSongMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
	.align	2
	.globl	_._18tInsideBoxSongMenu
	.ent	_._18tInsideBoxSongMenu
_._18tInsideBoxSongMenu:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tInsideBoxSongMenu_vtable) # high
	addiu	$2,$2,%lo(tInsideBoxSongMenu_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._14tInsideBoxMenu
	sw	$2,104($4)
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

	.end	_._18tInsideBoxSongMenu
	.align	2
	.globl	Draw__18tInsideBoxSongMenusssss
	.ent	Draw__18tInsideBoxSongMenusssss
Draw__18tInsideBoxSongMenusssss:
	.frame	$sp,72,$31		# vars= 0, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,40($sp)
	move	$18,$4
	lui	$2,%hi(screenAudio) # high
	lw	$2,%lo(screenAudio)($2)
	lw	$4,92($sp)
	sw	$23,60($sp)
	sw	$31,68($sp)
	sw	$fp,64($sp)
	sw	$22,56($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,120($2)
	lhu	$22,88($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L970
	move	$23,$5
	.set	macro
	.set	reorder

	sll	$3,$6,16
	sra	$3,$3,16
	sll	$2,$4,16
	sra	$2,$2,16
	addu	$2,$2,-21
	sra	$2,$2,1
	addu	$21,$3,$2
	move	$17,$0
	li	$4,2			# 0x00000002
	move	$3,$18
$L972:
	beq	$17,$4,$L975
	lh	$2,126($3)
	#nop
	addu	$2,$2,-8
	bgez	$2,$L976
	move	$2,$0
$L976:
	sh	$2,126($3)
$L975:
	addu	$17,$17,1
	slt	$2,$17,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L972
	addu	$3,$3,2
	.set	macro
	.set	reorder

	lh	$2,130($18)
	#nop
	addu	$3,$2,8
	slt	$2,$3,129
	bne	$2,$0,$L978
	li	$3,128			# 0x00000080
$L978:
	lh	$2,110($18)
	lhu	$4,110($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L979
	sh	$3,130($18)
	.set	macro
	.set	reorder

	lhu	$2,112($18)
	lh	$3,112($18)
	sll	$2,$2,1
	addu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bgez	$3,$L980
	sh	$2,110($18)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	bgez	$2,$L980
	sh	$0,110($18)
$L980:
	lh	$2,112($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L992
	move	$17,$0
	.set	macro
	.set	reorder

	lh	$2,110($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L993
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	sh	$0,110($18)
$L979:
	move	$17,$0
$L992:
	lui	$2,%hi(frontEnd) # high
$L993:
	addiu	$fp,$2,%lo(frontEnd) # low
	sll	$2,$7,16
	sra	$20,$2,16
	li	$19,-40			# 0xffffffd8
	move	$16,$18
$L982:
	lui	$2,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($2)
	#nop
	lh	$2,116($3)
	#nop
	addu	$2,$2,$17
	addu	$5,$2,-2
	bltz	$5,$L985
	lw	$2,120($3)
	#nop
	lw	$2,0($2)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L985
	sll	$2,$5,2
	.set	macro
	.set	reorder

	addu	$2,$2,$fp
	lw	$2,924($2)
	#nop
	beq	$2,$0,$L986
	lhu	$2,116($16)
	.set	noreorder
	.set	nomacro
	j	$L991
	addu	$2,$2,32
	.set	macro
	.set	reorder

$L986:
	lhu	$2,116($16)
	#nop
	addu	$2,$2,-32
$L991:
	sh	$2,116($16)
	lh	$2,116($16)
	#nop
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L988
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,116($16)
$L988:
	lh	$2,116($16)
	#nop
	bgez	$2,$L989
	sh	$0,116($16)
$L989:
	sll	$5,$5,16
	sll	$6,$23,16
	lw	$3,104($18)
	lhu	$7,110($18)
	lh	$4,96($3)
	sra	$5,$5,16
	sw	$20,16($sp)
	lh	$2,116($16)
	sra	$6,$6,16
	sw	$2,20($sp)
	lh	$2,126($16)
	addu	$4,$18,$4
	sw	$2,24($sp)
	addu	$2,$21,$19
	addu	$7,$7,$2
	addu	$7,$22,$7
	sll	$7,$7,16
	lw	$2,100($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$7,$7,16
	.set	macro
	.set	reorder

$L985:
	addu	$19,$19,21
	addu	$17,$17,1
	slt	$2,$17,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L982
	addu	$16,$16,2
	.set	macro
	.set	reorder

$L970:
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

	.end	Draw__18tInsideBoxSongMenusssss
	.align	2
	.globl	DrawOneSong__18tInsideBoxSongMenussssss
	.ent	DrawOneSong__18tInsideBoxSongMenussssss
DrawOneSong__18tInsideBoxSongMenussssss:
	.frame	$sp,64,$31		# vars= 8, regs= 8/0, args= 24, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,48($sp)
	move	$20,$5
	sw	$19,44($sp)
	move	$19,$6
	sw	$18,40($sp)
	move	$18,$7
	sw	$21,52($sp)
	lw	$21,80($sp)
	li	$4,5570560			# 0x00550000
	sw	$17,36($sp)
	lw	$17,84($sp)
	ori	$4,$4,0x1e00
	sw	$16,32($sp)
	lw	$16,88($sp)
	li	$5,40			# 0x00000028
	sw	$31,60($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sw	$22,56($sp)
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	move	$7,$0
	addu	$3,$sp,24
	sw	$3,16($sp)
	addu	$3,$sp,28
	move	$22,$2
	sw	$3,20($sp)
	sll	$17,$17,16
	sra	$5,$17,16
	sll	$16,$16,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	CalcOnOffFade__F13tMenuTextTypesssRiT4
	move	$6,$16
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$5,$19,3
	sll	$5,$5,16
	sra	$5,$5,16
	lui	$17,%hi(screenAudio) # high
	addu	$6,$18,2
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$20,$20,16
	lw	$3,%lo(screenAudio)($17)
	sra	$20,$20,10
	lw	$3,120($3)
	move	$16,$2
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$3,$3,$20
	lw	$4,12($3)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	move	$7,$16
	.set	macro
	.set	reorder

	addu	$5,$19,2
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$18,10
	lw	$2,%lo(screenAudio)($17)
	sll	$6,$6,16
	lw	$2,120($2)
	sra	$6,$6,16
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$2,$2,$20
	lw	$4,16($2)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	move	$7,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,102			# 0x00000066
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$17,$19,$21
	addu	$5,$17,-90
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$16,$18,6
	sll	$16,$16,16
	sra	$16,$16,16
	move	$6,$16
	lw	$7,24($sp)
	li	$20,2			# 0x00000002
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$20,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,103			# 0x00000067
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$17,$17,-30
	sll	$17,$17,16
	sra	$5,$17,16
	lw	$7,28($sp)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$20,20($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	sll	$19,$19,16
	sra	$19,$19,16
	sll	$21,$21,16
	sra	$21,$21,16
	addu	$17,$19,$21
	addu	$5,$17,-120
	sll	$18,$18,16
	sra	$18,$18,16
	move	$6,$18
	move	$7,$20
	li	$16,19			# 0x00000013
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	addu	$5,$17,-60
	move	$6,$18
	move	$7,$20
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$19
	move	$6,$18
	move	$7,$21
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$19
	addu	$6,$18,$16
	move	$7,$21
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,60($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	DrawOneSong__18tInsideBoxSongMenussssss
	.align	2
	.globl	DebounceKeys__18tInsideBoxSongMenu
	.ent	DebounceKeys__18tInsideBoxSongMenu
DebounceKeys__18tInsideBoxSongMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,7680			# 0x00001e00
	.set	macro
	.set	reorder

	.end	DebounceKeys__18tInsideBoxSongMenu
	.align	2
	.globl	ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(screenAudio) # high
	lw	$2,%lo(screenAudio)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,120($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L996
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$3,0($17)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L998
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1022
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

$L998:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L999
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

$L1022:
	jal	AudioCmn_PlayFESFX__Fi
$L999:
	lw	$3,0($17)
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1011
	slt	$2,$3,1025
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1020
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1004
	lui	$2,%hi(screenAudio) # high
	.set	macro
	.set	reorder

	j	$L996
$L1020:
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1002
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	bne	$3,$2,$L996
$L1002:
	lui	$2,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($2)
	lui	$2,%hi(frontEnd) # high
	lh	$3,116($3)
	addiu	$2,$2,%lo(frontEnd) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,924($3)
	#nop
	sltu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L1001
	sw	$2,924($3)
	.set	macro
	.set	reorder

$L1004:
	lw	$2,%lo(screenAudio)($2)
	#nop
	lh	$2,116($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1024
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,110($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1024
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
	li	$2,-21			# 0xffffffeb
	sh	$2,110($16)
	move	$2,$5
	sh	$2,112($16)
$L1007:
	sll	$4,$5,1
	addu	$5,$5,-1
	sll	$2,$5,1
	addu	$2,$16,$2
	lhu	$3,116($2)
	addu	$4,$16,$4
	sh	$3,116($4)
	lhu	$2,126($2)
	.set	noreorder
	.set	nomacro
	bgtz	$5,$L1007
	sh	$2,126($4)
	.set	macro
	.set	reorder

	lui	$2,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($2)
	sh	$0,116($16)
	sh	$0,126($16)
	lhu	$2,116($3)
	li	$4,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$L1023
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L1011:
	lui	$2,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($2)
	#nop
	lw	$2,120($3)
	#nop
	lw	$2,0($2)
	lh	$3,116($3)
	addu	$2,$2,-1
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1024
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,110($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1024
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$0
	li	$2,21			# 0x00000015
	sh	$2,110($16)
	li	$2,-4			# 0xfffffffc
	sh	$2,112($16)
	sll	$4,$5,1
$L1025:
	addu	$5,$5,1
	sll	$2,$5,1
	addu	$2,$16,$2
	lhu	$3,116($2)
	addu	$4,$16,$4
	sh	$3,116($4)
	lhu	$2,126($2)
	#nop
	sh	$2,126($4)
	slt	$2,$5,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1025
	sll	$4,$5,1
	.set	macro
	.set	reorder

	lui	$2,%hi(screenAudio) # high
	lw	$3,%lo(screenAudio)($2)
	sh	$0,124($16)
	sh	$0,134($16)
	lhu	$2,116($3)
	li	$4,4			# 0x00000004
	addu	$2,$2,1
$L1023:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sh	$2,116($3)
	.set	macro
	.set	reorder

$L1001:
	li	$2,1			# 0x00000001
$L1024:
	sw	$2,0($17)
$L996:
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

	.end	ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Draw__34tMenuItemControllerLeftRightChoiceiib
	.ent	Draw__34tMenuItemControllerLeftRightChoiceiib
Draw__34tMenuItemControllerLeftRightChoiceiib:
	.frame	$sp,88,$31		# vars= 24, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$20,72($sp)
	move	$20,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$31,80($sp)
	sw	$21,76($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	lw	$4,4($20)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$6
	.set	macro
	.set	reorder

	lw	$4,4($20)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$18,$2,$16
	.set	macro
	.set	reorder

	li	$4,13107200			# 0x00c80000
	ori	$4,$4,0x3c1e
	li	$5,48830			# 0x0000bebe
	lui	$3,%hi(gHelpShapes) # high
	addu	$19,$2,$17
	lh	$6,8($20)
	lw	$3,%lo(gHelpShapes)($3)
	lh	$7,32($20)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	addu	$21,$3,960
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	lh	$5,8($20)
	lh	$6,32($20)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	move	$16,$2
	.set	macro
	.set	reorder

	move	$17,$2
	lh	$3,32($20)
	li	$2,128			# 0x00000080
	beq	$3,$2,$L1027
	sw	$16,36($sp)
	lw	$4,4($20)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sll	$16,$19,16
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$18,16
	sra	$5,$5,16
	sra	$16,$16,16
	move	$6,$16
	move	$7,$17
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$6,28($20)
	lui	$2,%hi(gMenu_SubMenuPlayer) # high
	lw	$3,12($6)
	lw	$5,%lo(gMenu_SubMenuPlayer)($2)
	lh	$4,24($3)
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$6,$4
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$4,$2,16
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$18,151
	sll	$5,$5,16
	sra	$5,$5,16
	move	$6,$16
	move	$7,$17
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L1027:
	move	$4,$0
	lh	$6,8($20)
	lh	$7,32($20)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	li	$4,10			# 0x0000000a
	li	$5,24			# 0x00000018
	sll	$17,$18,16
	sra	$17,$17,16
	addu	$6,$17,131
	sll	$16,$19,16
	sra	$16,$16,16
	move	$7,$16
	li	$19,1			# 0x00000001
	addu	$18,$sp,32
	sw	$2,36($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$4,11			# 0x0000000b
	li	$5,24			# 0x00000018
	addu	$6,$17,161
	move	$7,$16
	sw	$0,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	li	$4,30			# 0x0000001e
	li	$5,8			# 0x00000008
	addu	$16,$16,-3
	lh	$6,16($21)
	lh	$2,32($20)
	move	$7,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	addu	$6,$6,-176
	subu	$6,$17,$6
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$17
	move	$6,$16
	li	$3,176			# 0x000000b0
	lh	$7,16($21)
	lh	$2,18($21)
	subu	$7,$3,$7
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Draw__34tMenuItemControllerLeftRightChoiceiib
	.align	2
	.globl	__25tInsideBoxLeftRightSliderUiP13tListIterator
	.ent	__25tInsideBoxLeftRightSliderUiP13tListIterator
__25tInsideBoxLeftRightSliderUiP13tListIterator:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__24tMenuItemLeftRightSliderUiP13tListIterator
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tInsideBoxLeftRightSlider_vtable) # high
	addiu	$3,$3,%lo(tInsideBoxLeftRightSlider_vtable) # low
	sw	$3,24($2)
	li	$3,5			# 0x00000005
	sh	$0,8($2)
	sh	$3,38($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__25tInsideBoxLeftRightSliderUiP13tListIterator
	.align	2
	.globl	_._25tInsideBoxLeftRightSlider
	.ent	_._25tInsideBoxLeftRightSlider
_._25tInsideBoxLeftRightSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tInsideBoxLeftRightSlider_vtable) # high
	addiu	$2,$2,%lo(tInsideBoxLeftRightSlider_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightSlider
	sw	$2,24($4)
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

	.end	_._25tInsideBoxLeftRightSlider
	.align	2
	.globl	Draw__25tInsideBoxLeftRightSlideriiib
	.ent	Draw__25tInsideBoxLeftRightSlideriiib
Draw__25tInsideBoxLeftRightSlideriiib:
	.frame	$sp,80,$31		# vars= 0, regs= 6/0, args= 56, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$16,56($sp)
	move	$16,$4
	li	$4,5570560			# 0x00550000
	ori	$4,$4,0x1e00
	sw	$31,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	sh	$5,32($16)
	li	$5,13107200			# 0x00c80000
	ori	$5,$5,0x3c1e
	sh	$6,34($16)
	lh	$6,8($16)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$17,$7
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	move	$6,$0
	lh	$5,8($16)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeUnselToSel__F13tMenuTextTypess
	move	$19,$2
	.set	macro
	.set	reorder

	move	$4,$19
	move	$7,$17
	li	$18,1			# 0x00000001
	lh	$5,32($16)
	lh	$6,34($16)
	move	$20,$2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$18,16($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lh	$5,32($16)
	lh	$6,34($16)
	move	$7,$17
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$6,$6,8
	.set	macro
	.set	reorder

	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$17,$17,-8
	.set	macro
	.set	reorder

	move	$4,$2
	lhu	$5,32($16)
	lhu	$6,34($16)
	move	$7,$20
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$5,$5,4
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,10
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lw	$3,28($16)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$4,$2,0x00ff
	sll	$17,$17,16
	sra	$17,$17,16
	lhu	$7,32($16)
	lhu	$2,34($16)
	lw	$3,28($16)
	addu	$7,$7,4
	sll	$7,$7,16
	addu	$2,$2,2
	sll	$2,$2,16
	lbu	$5,8($3)
	lbu	$6,9($3)
	sra	$2,$2,16
	sw	$2,16($sp)
	sw	$17,20($sp)
	lh	$3,38($16)
	li	$2,4			# 0x00000004
	sw	$2,28($sp)
	sw	$2,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$3,24($sp)
	lh	$2,8($16)
	sra	$7,$7,16
	sw	$0,48($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	lw	$31,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Draw__25tInsideBoxLeftRightSlideriiib
	.align	2
	.globl	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	.ent	__22tInsideBoxTwoWaySliderUiP13tListIteratori
__22tInsideBoxTwoWaySliderUiP13tListIteratori:
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
	jal	__24tMenuItemLeftRightSliderUiP13tListIterator
	move	$17,$7
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tInsideBoxTwoWaySlider_vtable) # high
	addiu	$3,$3,%lo(tInsideBoxTwoWaySlider_vtable) # low
	sw	$3,24($2)
	li	$3,5			# 0x00000005
	sh	$17,40($2)
	sh	$0,8($2)
	sh	$3,38($2)
	sw	$0,44($2)
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

	.end	__22tInsideBoxTwoWaySliderUiP13tListIteratori
	.align	2
	.globl	_._22tInsideBoxTwoWaySlider
	.ent	_._22tInsideBoxTwoWaySlider
_._22tInsideBoxTwoWaySlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tInsideBoxTwoWaySlider_vtable) # high
	addiu	$2,$2,%lo(tInsideBoxTwoWaySlider_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._24tMenuItemLeftRightSlider
	sw	$2,24($4)
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

	.end	_._22tInsideBoxTwoWaySlider
	.align	2
	.globl	ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,24($sp)
	lw	$3,0($16)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1047
	move	$17,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,44($17)
	sw	$2,0($16)
	lw	$3,0($16)
$L1047:
	li	$2,128			# 0x00000080
	bne	$3,$2,$L1040
	lw	$2,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1045
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$0,44($17)
	sw	$2,0($16)
$L1040:
	lw	$2,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1046
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,0($16)
	li	$2,2048			# 0x00000800
$L1045:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1043
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	bne	$3,$2,$L1044
$L1043:
	li	$2,1			# 0x00000001
$L1046:
	sw	$2,0($16)
$L1044:
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

	.end	ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	Draw__22tInsideBoxTwoWaySlideriiib
	.ent	Draw__22tInsideBoxTwoWaySlideriiib
Draw__22tInsideBoxTwoWaySlideriiib:
	.frame	$sp,88,$31		# vars= 0, regs= 8/0, args= 56, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$22,80($sp)
	move	$22,$4
	sw	$16,56($sp)
	move	$16,$5
	sw	$17,60($sp)
	move	$17,$6
	sw	$31,84($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$18,64($sp)
	lw	$2,44($22)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1049
	move	$18,$7
	.set	macro
	.set	reorder

	jal	Calibrate__22tInsideBoxTwoWaySlider
$L1049:
	li	$4,5570560			# 0x00550000
	ori	$4,$4,0x1e00
	li	$5,13107200			# 0x00c80000
	ori	$5,$5,0x3c1e
	lh	$6,8($22)
	sra	$18,$18,1
	sh	$16,32($22)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	sh	$17,34($22)
	.set	macro
	.set	reorder

	li	$4,5570560			# 0x00550000
	ori	$4,$4,0x1e00
	li	$5,48830			# 0x0000bebe
	lh	$6,8($22)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiii
	move	$16,$2
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	move	$6,$0
	lh	$5,8($22)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeUnselToSel__F13tMenuTextTypess
	move	$20,$2
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$17,$18,-4
	move	$7,$17
	li	$19,1			# 0x00000001
	lh	$5,32($22)
	lh	$6,34($22)
	move	$21,$2
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$19,16($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$5,32($22)
	lh	$6,34($22)
	move	$7,$17
	sw	$19,16($sp)
	addu	$5,$5,$17
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$5,$5,8
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$5,32($22)
	lh	$6,34($22)
	move	$7,$17
	sw	$19,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$6,$6,8
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$5,32($22)
	lh	$6,34($22)
	move	$7,$17
	sw	$19,16($sp)
	addu	$5,$5,$17
	addu	$5,$5,9
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$6,$6,8
	.set	macro
	.set	reorder

	move	$4,$20
	li	$7,2			# 0x00000002
	lh	$5,32($22)
	lh	$6,34($22)
	li	$2,9			# 0x00000009
	sw	$2,16($sp)
	addu	$5,$5,$17
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	addu	$5,$5,3
	.set	macro
	.set	reorder

	lw	$4,4($22)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$18,$18,-8
	.set	macro
	.set	reorder

	move	$4,$2
	lhu	$5,32($22)
	lhu	$6,34($22)
	move	$7,$21
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$5,$5,4
	sll	$5,$5,16
	sra	$5,$5,16
	addu	$6,$6,10
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	lw	$3,28($22)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$4,$2,0x00ff
	sll	$18,$18,16
	sra	$18,$18,16
	li	$16,4			# 0x00000004
	lhu	$7,32($22)
	lhu	$2,34($22)
	lw	$3,28($22)
	addu	$7,$7,$19
	addu	$2,$2,2
	sll	$2,$2,16
	lbu	$5,8($3)
	lbu	$6,9($3)
	sra	$2,$2,16
	sw	$2,16($sp)
	sw	$18,20($sp)
	lh	$2,38($22)
	sll	$7,$7,16
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$19,36($sp)
	sw	$0,40($sp)
	sw	$2,24($sp)
	lh	$2,8($22)
	sra	$7,$7,16
	sw	$0,48($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	lw	$3,28($22)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	andi	$4,$2,0x00ff
	lhu	$3,34($22)
	lw	$2,28($22)
	lhu	$7,32($22)
	addu	$3,$3,2
	sll	$3,$3,16
	sra	$3,$3,16
	addu	$7,$7,$17
	lbu	$5,8($2)
	lbu	$6,9($2)
	addu	$7,$7,10
	sw	$3,16($sp)
	sw	$18,20($sp)
	lh	$2,38($22)
	sll	$7,$7,16
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$2,24($sp)
	lh	$2,8($22)
	sra	$7,$7,16
	sw	$0,48($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawSlider__FsssssssssbT9ss
	sw	$2,44($sp)
	.set	macro
	.set	reorder

	lw	$31,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Draw__22tInsideBoxTwoWaySlideriiib
	.align	2
	.globl	GetCurrentStickRange__Fi
	.ent	GetCurrentStickRange__Fi
GetCurrentStickRange__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$4,$4,5
	addu	$4,$4,$2
	lbu	$2,8($4)
	li	$3,128			# 0x00000080
	subu	$5,$3,$2
	bgtz	$5,$L1051
	addu	$5,$2,-128
$L1051:
	lbu	$4,9($4)
	#nop
	subu	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1054
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$2,$4,-128
	move	$3,$2
$L1054:
	slt	$2,$3,$5
	beq	$2,$0,$L1053
	move	$3,$5
$L1053:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	GetCurrentStickRange__Fi
	.align	2
	.globl	GetCurrentStickRange2__Fi
	.ent	GetCurrentStickRange2__Fi
GetCurrentStickRange2__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$4,$4,5
	addu	$4,$4,$2
	lbu	$2,10($4)
	li	$3,128			# 0x00000080
	subu	$5,$3,$2
	bgtz	$5,$L1056
	addu	$5,$2,-128
$L1056:
	lbu	$4,11($4)
	#nop
	subu	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1059
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$2,$4,-128
	move	$3,$2
$L1059:
	slt	$2,$3,$5
	beq	$2,$0,$L1058
	move	$3,$5
$L1058:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	GetCurrentStickRange2__Fi
	.align	2
	.globl	Calibrate__22tInsideBoxTwoWaySlider
	.ent	Calibrate__22tInsideBoxTwoWaySlider
Calibrate__22tInsideBoxTwoWaySlider:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(screenControllerConfig) # high
	#.set	volatile
	lw	$4,%lo(screenControllerConfig)($2)
	#.set	novolatile
	lui	$2,%hi(FEApp) # high
	#.set	volatile
	lw	$3,%lo(FEApp)($2)
	#.set	novolatile
	lui	$2,%hi(gPadinfo) # high
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lbu	$18,557($3)
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$18,5
	.set	noreorder
	.set	nomacro
	jal	GetHelpText__23tScreenControllerConfig
	addu	$17,$3,$2
	.set	macro
	.set	reorder

	lui	$3,%hi(fHelpText) # high
	sw	$2,%lo(fHelpText)($3)
	lh	$3,40($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1071
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1100
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1062
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	j	$L1060
$L1100:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1082
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1090
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	j	$L1060
$L1062:
	lbu	$3,5($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1063
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$5,8($17)
	#nop
	slt	$2,$5,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1064
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1065
	subu	$3,$2,$5
	.set	macro
	.set	reorder

$L1064:
	addu	$3,$5,-128
$L1065:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$4,$18,$2
	lbu	$2,843($4)
	move	$5,$3
	addu	$6,$2,10
	slt	$2,$5,$6
	beq	$2,$0,$L1066
	move	$5,$6
$L1066:
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$5,841($4)
	.set	macro
	.set	reorder

$L1063:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1069
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	bne	$3,$2,$L1060
$L1069:
	.set	noreorder
	.set	nomacro
	jal	GetCurrentStickRange__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$4,$18,$3
	lbu	$3,851($4)
	andi	$5,$2,0x00ff
	addu	$3,$3,10
	slt	$2,$5,$3
	beq	$2,$0,$L1070
	move	$5,$3
$L1070:
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$5,849($4)
	.set	macro
	.set	reorder

$L1071:
	lbu	$3,5($17)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1072
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$5,8($17)
	#nop
	slt	$2,$5,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1073
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1074
	subu	$3,$2,$5
	.set	macro
	.set	reorder

$L1073:
	addu	$3,$5,-128
$L1074:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$4,$18,$2
	lbu	$2,841($4)
	move	$5,$3
	addu	$6,$2,-10
	slt	$2,$6,$5
	beq	$2,$0,$L1075
	move	$5,$6
$L1075:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1076
	move	$2,$5
	.set	macro
	.set	reorder

	move	$2,$0
$L1076:
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$2,843($4)
	.set	macro
	.set	reorder

$L1072:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1079
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	bne	$3,$2,$L1060
$L1079:
	.set	noreorder
	.set	nomacro
	jal	GetCurrentStickRange__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$4,$18,$3
	lbu	$3,849($4)
	andi	$5,$2,0x00ff
	addu	$3,$3,-10
	slt	$2,$3,$5
	beq	$2,$0,$L1080
	move	$5,$3
$L1080:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1081
	move	$2,$5
	.set	macro
	.set	reorder

	move	$2,$0
$L1081:
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$2,851($4)
	.set	macro
	.set	reorder

$L1082:
	lbu	$3,5($17)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1083
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$5,9($17)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1084
	move	$3,$5
	.set	macro
	.set	reorder

	move	$3,$0
$L1084:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$3,845($2)
	.set	macro
	.set	reorder

$L1083:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1087
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	bne	$3,$2,$L1060
$L1087:
	.set	noreorder
	.set	nomacro
	jal	GetCurrentStickRange2__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$4,$18,$3
	lbu	$3,855($4)
	andi	$5,$2,0x00ff
	addu	$3,$3,10
	slt	$2,$5,$3
	beq	$2,$0,$L1088
	move	$5,$3
$L1088:
	sb	$5,853($4)
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1089
	move	$2,$5
	.set	macro
	.set	reorder

	move	$2,$0
$L1089:
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$2,853($4)
	.set	macro
	.set	reorder

$L1090:
	lbu	$3,5($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1091
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$5,10($17)
	li	$3,10			# 0x0000000a
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1102
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	move	$3,$5
$L1102:
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	j	$L1060
	sb	$3,847($2)
	.set	macro
	.set	reorder

$L1091:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1095
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	bne	$3,$2,$L1060
$L1095:
	.set	noreorder
	.set	nomacro
	jal	GetCurrentStickRange2__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$4,$18,$3
	lbu	$3,853($4)
	andi	$5,$2,0x00ff
	addu	$3,$3,-10
	slt	$2,$3,$5
	beq	$2,$0,$L1096
	move	$5,$3
$L1096:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1097
	move	$2,$5
	.set	macro
	.set	reorder

	move	$2,$0
$L1097:
	sb	$2,855($4)
$L1060:
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

	.end	Calibrate__22tInsideBoxTwoWaySlider
	.align	2
	.globl	__17tUserNameMenuItemUi
	.ent	__17tUserNameMenuItemUi
__17tUserNameMenuItemUi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__9tMenuItemUi
	move	$16,$4
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$2,%hi(tUserNameMenuItem_vtable) # high
	addiu	$2,$2,%lo(tUserNameMenuItem_vtable) # low
	sw	$2,24($16)
	sh	$0,36($16)
	sh	$0,34($16)
$L1104:
	sll	$3,$4,16
	sra	$3,$3,16
	sll	$2,$3,3
	addu	$2,$2,$3
	addu	$2,$16,$2
	sb	$0,38($2)
	addu	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	move	$2,$16
	.set	macro
	.set	reorder

	sw	$0,28($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__17tUserNameMenuItemUi
	.align	2
	.globl	CheckForCheats__FPc
	.ent	CheckForCheats__FPc
CheckForCheats__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	slt	$2,$3,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1119
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$2,$16,$3
$L1120:
	sb	$0,0($2)
	addu	$3,$3,1
	slt	$2,$3,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1120
	addu	$2,$16,$3
	.set	macro
	.set	reorder

	move	$17,$0
$L1119:
	.set	noreorder
	.set	nomacro
	jal	FECheat_ActivateCheat__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L1117
	.set	noreorder
	.set	nomacro
	jal	FECheat_ActivateBonusByCode__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1121
	move	$2,$17
	.set	macro
	.set	reorder

$L1117:
	li	$17,1			# 0x00000001
	move	$2,$17
$L1121:
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

	.end	CheckForCheats__FPc
	.align	2
	.globl	ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	lw	$3,0($17)
	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1179
	move	$16,$4
	.set	macro
	.set	reorder

	slt	$2,$3,1025
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1163
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1143
	li	$2,512			# 0x00000200
	.set	macro
	.set	reorder

	beq	$3,$2,$L1175
	j	$L1123
$L1163:
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1131
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	beq	$3,$2,$L1133
	j	$L1123
$L1179:
	li	$2,512			# 0x00000200
$L1175:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1126
	lui	$3,%hi(menu_kUserNameRows) # high
	.set	macro
	.set	reorder

	lhu	$2,36($16)
	#nop
	addu	$2,$2,-1
	sh	$2,36($16)
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1128
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	lui	$2,%hi(menu_kUserNameRows) # high
	lhu	$2,%lo(menu_kUserNameRows)($2)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L1128
	sh	$2,36($16)
	.set	macro
	.set	reorder

$L1126:
	lhu	$2,36($16)
	lh	$3,%lo(menu_kUserNameRows)($3)
	addu	$2,$2,1
	sh	$2,36($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1128
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	sh	$0,36($16)
$L1128:
	jal	AudioCmn_PlayFESFX__Fi
	lh	$2,34($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1176
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1176
	sh	$0,34($16)
	.set	macro
	.set	reorder

$L1131:
	lhu	$2,34($16)
	#nop
	addu	$2,$2,-1
	sh	$2,34($16)
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1172
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	j	$L1172
	sh	$2,34($16)
	.set	macro
	.set	reorder

$L1133:
	lhu	$2,34($16)
	#nop
	addu	$2,$2,1
	sh	$2,34($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,6
	bne	$2,$0,$L1134
	sh	$0,34($16)
$L1134:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,0($17)
	lh	$4,36($16)
	lhu	$5,34($16)
	lh	$2,34($16)
	sll	$3,$4,3
	addu	$4,$3,$4
	addu	$2,$2,$4
	addu	$2,$16,$2
	lbu	$3,38($2)
	li	$2,45			# 0x0000002d
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1142
	move	$3,$4
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$2,$5,1
$L1177:
	sh	$2,34($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,6
	bne	$2,$0,$L1139
	sh	$0,34($16)
$L1139:
	lh	$2,34($16)
	#nop
	addu	$2,$2,$3
	addu	$2,$16,$2
	lbu	$2,38($2)
	lhu	$5,34($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L1177
	addu	$2,$5,1
	.set	macro
	.set	reorder

	j	$L1123
$L1143:
	lw	$4,28($16)
	jal	strlen
	lh	$5,36($16)
	lh	$3,34($16)
	sll	$4,$5,3
	addu	$4,$4,$5
	addu	$3,$3,$4
	addu	$3,$16,$3
	lbu	$5,38($3)
	move	$3,$2
	addu	$2,$5,-35
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1144
	sll	$2,$3,16
	.set	macro
	.set	reorder

	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L1171
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

	lw	$2,28($16)
	#nop
	addu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L1172
	sb	$0,-1($2)
	.set	macro
	.set	reorder

$L1144:
 #APP
 #NO_APP
	andi	$4,$5,0x00ff
	li	$2,33			# 0x00000021
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1148
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1147
	li	$2,38			# 0x00000026
	.set	macro
	.set	reorder

$L1148:
	lw	$4,28($16)
	jal	CheckForCheats__FPc
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1149
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lw	$2,28($16)
	.set	noreorder
	.set	nomacro
	j	$L1123
	sb	$0,0($2)
	.set	macro
	.set	reorder

$L1149:
	lw	$2,%lo(FEApp)($2)
	#nop
	lw	$2,4($2)
	#nop
	lw	$2,0($2)
	#nop
	andi	$2,$2,0x0100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1173
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	li	$2,8192			# 0x00002000
$L1173:
	.set	noreorder
	.set	nomacro
	j	$L1174
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L1147:
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1155
	li	$2,94			# 0x0000005e
	.set	macro
	.set	reorder

	bne	$4,$2,$L1154
$L1155:
	sll	$3,$3,16
	lh	$2,32($16)
	sra	$5,$3,16
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1174
	li	$3,32			# 0x00000020
	.set	macro
	.set	reorder

	lw	$2,28($16)
	#nop
	addu	$2,$2,$5
	sb	$3,0($2)
	lw	$2,28($16)
	li	$4,21			# 0x00000015
	addu	$2,$5,$2
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	sb	$0,1($2)
	.set	macro
	.set	reorder

	j	$L1123
$L1154:
	sll	$3,$3,16
	lh	$2,32($16)
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1159
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

$L1174:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L1123
$L1159:
	lw	$2,28($16)
	#nop
	addu	$2,$2,$3
	sb	$5,0($2)
	lw	$2,28($16)
	#nop
	addu	$2,$3,$2
	sb	$0,1($2)
$L1172:
	jal	AudioCmn_PlayFESFX__Fi
$L1171:
	li	$2,1			# 0x00000001
$L1176:
	sw	$2,0($17)
$L1123:
	lh	$4,36($16)
	lhu	$5,34($16)
	lh	$2,34($16)
	sll	$3,$4,3
	addu	$4,$3,$4
	addu	$2,$2,$4
	addu	$2,$16,$2
	lbu	$3,38($2)
	li	$2,45			# 0x0000002d
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1142
	li	$6,5			# 0x00000005
	.set	macro
	.set	reorder

	move	$3,$4
	move	$4,$2
	addu	$2,$5,-1
$L1178:
	sh	$2,34($16)
	sll	$2,$2,16
	bgez	$2,$L1168
	sh	$6,34($16)
$L1168:
	lh	$2,34($16)
	#nop
	addu	$2,$2,$3
	addu	$2,$16,$2
	lbu	$2,38($2)
	lhu	$5,34($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L1178
	addu	$2,$5,-1
	.set	macro
	.set	reorder

$L1142:
	lw	$4,28($16)
	jal	Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
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

	.end	ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	SpecialCharacter__Fc
	.ent	SpecialCharacter__Fc
SpecialCharacter__Fc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$4,$4,0x00ff
	addu	$3,$4,-225
	sltu	$2,$3,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1181
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi($L1193) # high
	addiu	$2,$2,%lo($L1193) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L1193:
	.word	$L1187
	.word	$L1181
	.word	$L1181
	.word	$L1182
	.word	$L1192
	.word	$L1181
	.word	$L1181
	.word	$L1186
	.word	$L1185
	.word	$L1181
	.word	$L1181
	.word	$L1181
	.word	$L1188
	.word	$L1181
	.word	$L1181
	.word	$L1181
	.word	$L1191
	.word	$L1181
	.word	$L1189
	.word	$L1181
	.word	$L1181
	.word	$L1183
	.word	$L1181
	.word	$L1181
	.word	$L1181
	.word	$L1190
	.word	$L1181
	.word	$L1184
	.text
$L1182:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,81			# 0x00000051
	.set	macro
	.set	reorder

$L1183:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,82			# 0x00000052
	.set	macro
	.set	reorder

$L1184:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,83			# 0x00000053
	.set	macro
	.set	reorder

$L1185:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,84			# 0x00000054
	.set	macro
	.set	reorder

$L1186:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,85			# 0x00000055
	.set	macro
	.set	reorder

$L1187:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,86			# 0x00000056
	.set	macro
	.set	reorder

$L1188:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,87			# 0x00000057
	.set	macro
	.set	reorder

$L1189:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,88			# 0x00000058
	.set	macro
	.set	reorder

$L1190:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,89			# 0x00000059
	.set	macro
	.set	reorder

$L1191:
	.set	noreorder
	.set	nomacro
	j	$L1181
	li	$5,90			# 0x0000005a
	.set	macro
	.set	reorder

$L1192:
	li	$5,91			# 0x0000005b
$L1181:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	SpecialCharacter__Fc
	.align	2
	.globl	Draw__17tUserNameMenuItemb
	.ent	Draw__17tUserNameMenuItemb
Draw__17tUserNameMenuItemb:
	.frame	$sp,136,$31		# vars= 64, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$18,104($sp)
	move	$18,$4
	sw	$31,132($sp)
	sw	$fp,128($sp)
	sw	$23,124($sp)
	sw	$22,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$17,100($sp)
	sw	$16,96($sp)
	lw	$4,4($18)
	jal	TextSys_WordX__Fi
	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sw	$2,88($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(gHelpShapes) # high
	lw	$3,%lo(gHelpShapes)($3)
	move	$fp,$2
	addu	$22,$3,960
	lh	$3,130($18)
	li	$2,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1221
	li	$4,30			# 0x0000001e
	.set	macro
	.set	reorder

	sb	$0,33($sp)
	lh	$5,130($18)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	li	$4,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	li	$4,48830			# 0x0000bebe
	lh	$5,130($18)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$19,$2
	.set	macro
	.set	reorder

	move	$23,$2
	sw	$23,44($sp)
	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$6,$fp,16
	sra	$6,$6,16
	lw	$8,88($sp)
	move	$7,$19
	sw	$0,16($sp)
	sw	$0,20($sp)
	sll	$5,$8,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lw	$4,28($18)
	jal	strlen
	lh	$4,32($18)
	lw	$8,88($sp)
	sh	$2,92($sp)
	sll	$2,$2,16
	addu	$5,$8,78
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,1
	subu	$17,$5,$3
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L1197
	addu	$2,$fp,17
	.set	macro
	.set	reorder

	sll	$21,$2,16
	move	$20,$3
	addu	$4,$sp,32
$L1222:
	sll	$3,$16,16
	sra	$3,$3,16
	sll	$5,$3,2
	addu	$5,$5,$3
	sll	$5,$5,2
	addu	$5,$17,$5
	sll	$5,$5,16
	sra	$5,$5,16
	lw	$2,28($18)
	sra	$6,$21,16
	addu	$2,$2,$3
	lbu	$2,0($2)
	move	$7,$19
	sb	$2,32($sp)
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1222
	addu	$4,$sp,32
	.set	macro
	.set	reorder

$L1197:
	lhu	$16,92($sp)
	lh	$3,32($18)
	sll	$2,$16,16
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1202
	sll	$2,$17,16
	.set	macro
	.set	reorder

	sra	$17,$2,16
	move	$4,$23
$L1223:
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$5,$2,2
	addu	$5,$5,$2
	sll	$5,$5,2
	addu	$5,$17,$5
	addu	$6,$fp,25
	li	$7,17			# 0x00000011
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	lh	$3,32($18)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1223
	move	$4,$23
	.set	macro
	.set	reorder

$L1202:
	lh	$3,34($18)
	lui	$4,%hi(MENUUSERNAME_STARTY) # high
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$6,$2,2
	lh	$3,36($18)
 #APP
 #NO_APP
	addu	$17,$6,258
 #APP
 #NO_APP
	sll	$2,$3,4
	subu	$2,$2,$3
	lh	$3,%lo(MENUUSERNAME_STARTY)($4)
	lh	$4,130($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L1196
	addu	$16,$3,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(PulsateYellow) # high
	lw	$2,%lo(PulsateYellow)($2)
	#nop
	sw	$2,68($sp)
	lh	$4,36($18)
	lh	$3,34($18)
	sll	$2,$4,3
	addu	$2,$2,$4
	addu	$3,$3,$2
	addu	$5,$18,$3
	lbu	$3,38($5)
	li	$2,33			# 0x00000021
	andi	$4,$3,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1209
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1208
	addu	$2,$3,-35
	.set	macro
	.set	reorder

$L1209:
	li	$4,78			# 0x0000004e
	li	$5,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	j	$L1220
	addu	$6,$6,253
	.set	macro
	.set	reorder

$L1208:
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1211
	li	$2,38			# 0x00000026
	.set	macro
	.set	reorder

	li	$4,79			# 0x0000004f
	li	$5,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	j	$L1220
	addu	$6,$6,253
	.set	macro
	.set	reorder

$L1211:
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L1214
	li	$2,94			# 0x0000005e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L1213
	addu	$2,$3,-97
	.set	macro
	.set	reorder

$L1214:
	li	$4,80			# 0x00000050
	li	$5,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	j	$L1220
	addu	$6,$6,253
	.set	macro
	.set	reorder

$L1213:
	andi	$2,$2,0x00ff
	sltu	$2,$2,26
	beq	$2,$0,$L1216
	lbu	$2,38($5)
	.set	noreorder
	.set	nomacro
	j	$L1217
	addu	$2,$2,-55
	.set	macro
	.set	reorder

$L1216:
	addu	$2,$3,-48
	andi	$2,$2,0x00ff
	sltu	$2,$2,10
	beq	$2,$0,$L1218
	lbu	$2,38($5)
	.set	noreorder
	.set	nomacro
	j	$L1217
	addu	$2,$2,20
	.set	macro
	.set	reorder

$L1218:
	jal	SpecialCharacter__Fc
$L1217:
	move	$4,$2
	li	$5,16			# 0x00000010
	addu	$6,$17,-5
$L1220:
	addu	$7,$16,-3
	addu	$2,$sp,64
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,24($sp)
	.set	macro
	.set	reorder

$L1196:
	li	$4,30			# 0x0000001e
$L1221:
	li	$5,8			# 0x00000008
	addu	$16,$fp,-3
	lh	$6,16($22)
	lh	$2,130($18)
	lw	$8,88($sp)
	move	$7,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	addu	$17,$8,156
	subu	$6,$17,$6
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$3,156			# 0x0000009c
 #APP
 #NO_APP
	move	$4,$0
	move	$6,$16
	lw	$5,88($sp)
	lh	$7,16($22)
	lh	$2,18($22)
	subu	$7,$3,$7
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$4,33			# 0x00000021
	lui	$2,%hi(gHelpShapes) # high
	li	$5,8			# 0x00000008
	lw	$2,%lo(gHelpShapes)($2)
	addu	$16,$fp,12
	addu	$22,$2,1056
	lh	$6,16($22)
	lh	$2,130($18)
	move	$7,$16
	sw	$0,20($sp)
	sw	$0,24($sp)
	subu	$6,$17,$6
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	li	$3,156			# 0x0000009c
 #APP
 #NO_APP
	move	$4,$0
	move	$6,$16
	lw	$5,88($sp)
	lh	$7,16($22)
	lh	$2,18($22)
	subu	$7,$3,$7
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,132($sp)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	Draw__17tUserNameMenuItemb
	.align	2
	.globl	TransitionOff__17tUserNameMenuItem
	.ent	TransitionOff__17tUserNameMenuItem
TransitionOff__17tUserNameMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,30			# 0x0000001e
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,132($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__17tUserNameMenuItem
	.rdata
	.align	2
$LC5:
	.half	7
	.half	9
	.half	9
	.half	9
	.half	8
	.half	9
	.text
	.align	2
	.globl	TransitionOn__17tUserNameMenuItem
	.ent	TransitionOn__17tUserNameMenuItem
TransitionOn__17tUserNameMenuItem:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$4
	sw	$18,40($sp)
	move	$18,$0
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$16,32($sp)
$L1229:
	sll	$16,$18,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$16,507
	.set	macro
	.set	reorder

	sll	$4,$16,3
	addu	$4,$4,$16
	addu	$4,$4,38
	addu	$4,$17,$4
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1229
	lui	$2,%hi(frontEnd+832) # high
	.set	macro
	.set	reorder

	lui	$3,%hi($LC5) # high
	lbu	$2,%lo(frontEnd+832)($2)
	move	$4,$0
	addiu	$9,$3,%lo($LC5)
	lwl	$6,3($9)
	lwr	$6,0($9)
	lwl	$7,7($9)
	lwr	$7,4($9)
	lwl	$8,11($9)
	lwr	$8,8($9)
	swl	$6,19($sp)
	swr	$6,16($sp)
	swl	$7,23($sp)
	swr	$7,20($sp)
	swl	$8,27($sp)
	swr	$8,24($sp)
	sll	$2,$2,1
	addu	$2,$sp,$2
	lhu	$3,16($2)
	lui	$2,%hi(menu_kUserNameRows) # high
	sh	$3,%lo(menu_kUserNameRows)($2)
	lh	$2,34($17)
	li	$19,33			# 0x00000021
	sh	$0,36($17)
	addu	$2,$17,$2
	lbu	$2,38($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L1232
	li	$18,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L1232
	lui	$2,%hi(menu_kUserNameRows) # high
	.set	macro
	.set	reorder

$L1243:
	lh	$2,%lo(menu_kUserNameRows)($2)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L1232
	lh	$2,36($17)
	sh	$0,34($17)
	sll	$3,$2,3
	addu	$3,$3,$2
	addu	$2,$17,$3
	lbu	$2,38($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$19,$L1236
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L1236
	addu	$4,$3,38
	.set	macro
	.set	reorder

$L1242:
	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	slt	$2,$16,$2
	beq	$2,$0,$L1236
	lhu	$4,34($17)
	lh	$3,36($17)
	addu	$4,$4,1
	sll	$2,$4,16
	sra	$16,$2,16
	sll	$2,$3,3
	addu	$3,$2,$3
	addu	$2,$16,$3
	addu	$2,$17,$2
	sh	$4,34($17)
	lbu	$2,38($2)
	#nop
	beq	$2,$19,$L1236
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L1242
	addu	$4,$3,38
	.set	macro
	.set	reorder

$L1236:
	lhu	$3,36($17)
	#nop
	addu	$3,$3,1
	sll	$2,$3,16
	sra	$4,$2,16
	sh	$3,36($17)
	sll	$3,$4,3
	lh	$2,34($17)
	addu	$3,$3,$4
	addu	$2,$2,$3
	addu	$2,$17,$2
	lbu	$2,38($2)
	#nop
	beq	$2,$19,$L1232
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L1243
	lui	$2,%hi(menu_kUserNameRows) # high
	.set	macro
	.set	reorder

$L1232:
	lhu	$3,36($17)
	li	$2,128			# 0x00000080
	sh	$2,130($17)
	li	$2,-30			# 0xffffffe2
	sh	$2,132($17)
	lh	$2,128($17)
	lui	$18,%hi(FEApp) # high
	sh	$0,8($17)
	addu	$3,$3,-1
	sh	$3,36($17)
	lw	$3,%lo(FEApp)($18)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$5,888($3)
	li	$16,-1			# 0xffffffff
	beq	$5,$16,$L1225
	.set	noreorder
	.set	nomacro
	jal	FeAudio_AsyncPlaySpeech__Fii
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	lh	$2,128($17)
	lw	$3,%lo(FEApp)($18)
	sll	$2,$2,2
	addu	$3,$3,$2
	sw	$16,888($3)
$L1225:
	lw	$31,48($sp)
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

	.end	TransitionOn__17tUserNameMenuItem
	.align	2
	.globl	TransitionIsFinished__17tUserNameMenuItem
	.ent	TransitionIsFinished__17tUserNameMenuItem
TransitionIsFinished__17tUserNameMenuItem:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,132($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1245
	sw	$0,136($4)
	.set	macro
	.set	reorder

	lh	$2,130($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1253
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1245:
	lh	$2,132($4)
	#nop
	blez	$2,$L1247
	lh	$2,130($4)
	#nop
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1253
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(ginfo+16) # high
	lhu	$2,%lo(ginfo+16)($2)
	#nop
	beq	$2,$0,$L1247
	li	$2,1			# 0x00000001
$L1253:
	sw	$2,136($4)
$L1247:
	lw	$2,136($4)
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__17tUserNameMenuItem
	.align	2
	.globl	UpdateTransition__17tUserNameMenuItemb
	.ent	UpdateTransition__17tUserNameMenuItemb
UpdateTransition__17tUserNameMenuItemb:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lh	$2,130($16)
	lh	$3,132($16)
	#nop
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1255
	move	$17,$5
	.set	macro
	.set	reorder

	li	$3,128			# 0x00000080
$L1255:
	bgez	$3,$L1256
	move	$3,$0
$L1256:
	lw	$2,24($16)
	sh	$3,130($16)
	lh	$4,72($2)
	lw	$2,76($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	UpdateTransition__9tMenuItemb
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

	.end	UpdateTransition__17tUserNameMenuItemb
	.align	2
	.globl	Draw__19tMemoryCardMenuItemb
	.ent	Draw__19tMemoryCardMenuItemb
Draw__19tMemoryCardMenuItemb:
	.frame	$sp,88,$31		# vars= 24, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$18,64($sp)
	move	$18,$4
	sw	$31,84($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	sw	$17,60($sp)
	sw	$16,56($sp)
	lw	$2,0($18)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L1259
	lhu	$2,40($18)
	.set	noreorder
	.set	nomacro
	j	$L1260
	addu	$2,$2,-8
	.set	macro
	.set	reorder

$L1259:
	lhu	$2,40($18)
	#nop
	addu	$2,$2,8
$L1260:
	#.set	volatile
	sh	$2,40($18)
	#.set	novolatile
	lh	$4,40($18)
	lhu	$3,40($18)
	slt	$2,$4,256
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1280
	slt	$2,$4,257
	.set	macro
	.set	reorder

	blez	$4,$L1263
$L1280:
	bne	$2,$0,$L1265
	.set	noreorder
	.set	nomacro
	j	$L1265
	li	$3,256			# 0x00000100
	.set	macro
	.set	reorder

$L1263:
	move	$3,$0
$L1265:
	sh	$3,40($18)
	sll	$2,$3,16
	sra	$3,$2,16
	addu	$16,$3,-128
	slt	$2,$16,129
	bne	$2,$0,$L1266
	li	$16,128			# 0x00000080
$L1266:
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1281
	slt	$2,$3,128
	.set	macro
	.set	reorder

	move	$16,$0
$L1281:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1268
	li	$19,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L1273
	move	$19,$0
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1273
	move	$19,$3
	.set	macro
	.set	reorder

	li	$19,128			# 0x00000080
$L1268:
$L1273:
 #APP
 #NO_APP
	lh	$2,32($18)
	li	$21,128			# 0x00000080
	beq	$2,$21,$L1279
	lh	$2,40($18)
	#nop
	beq	$2,$0,$L1279
	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	subu	$16,$21,$16
	.set	macro
	.set	reorder

	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$20,$2
	.set	macro
	.set	reorder

	li	$4,6			# 0x00000006
	lh	$5,8($18)
	lh	$6,32($18)
	.set	noreorder
	.set	nomacro
	jal	CalcTextFadeSelToHi__F13tMenuTextTypess
	move	$22,$2
	.set	macro
	.set	reorder

	move	$17,$2
	li	$4,13107200			# 0x00c80000
	ori	$4,$4,0x3c1e
	lh	$6,8($18)
	lh	$7,32($18)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	li	$5,48830			# 0x0000bebe
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$16,$2
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L1275
	sw	$16,36($sp)
	.set	macro
	.set	reorder

	lw	$4,4($18)
	jal	TextSys_Word__Fi
	move	$4,$2
	sll	$5,$20,16
	sra	$5,$5,16
	sll	$6,$22,16
	sra	$6,$6,16
	move	$7,$17
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L1275:
	li	$16,150			# 0x00000096
	mult	$19,$16
	mflo	$3
	#nop
	#nop
	bgez	$3,$L1276
	addu	$3,$3,127
$L1276:
	lh	$2,32($18)
	sra	$3,$3,7
	subu	$2,$21,$2
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1282
	sra	$16,$2,7
	.set	macro
	.set	reorder

	addu	$2,$2,127
	sra	$16,$2,7
$L1282:
	li	$4,30			# 0x0000001e
	lui	$2,%hi(gHelpShapes) # high
	li	$5,8			# 0x00000008
	addu	$18,$22,-3
	lw	$2,%lo(gHelpShapes)($2)
	move	$7,$18
	addu	$17,$2,960
	lh	$2,16($17)
	addu	$6,$20,$16
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	subu	$6,$6,$2
	.set	macro
	.set	reorder

	lh	$3,16($17)
	#nop
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1279
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$20
	move	$6,$18
	lh	$2,18($17)
	subu	$7,$16,$3
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L1279:
	lw	$31,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Draw__19tMemoryCardMenuItemb
	.align	2
	.globl	ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$19,28($sp)
	sw	$31,32($sp)
	lw	$3,0($17)
	li	$2,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1285
	move	$19,$7
	.set	macro
	.set	reorder

	li	$2,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1288
	move	$4,$16
	.set	macro
	.set	reorder

$L1285:
	li	$2,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1289
	lui	$2,%hi(screenControllerConfig) # high
	.set	macro
	.set	reorder

	lw	$3,28($16)
	#nop
	lw	$2,12($3)
	li	$5,-1			# 0xffffffff
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$3,28($16)
	#nop
	lbu	$3,9($3)
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L1284
	lui	$2,%hi(screenControllerConfig) # high
	.set	macro
	.set	reorder

$L1289:
	lw	$3,%lo(screenControllerConfig)($2)
	li	$2,1			# 0x00000001
	sw	$2,368($3)
$L1284:
	move	$4,$16
$L1288:
	move	$5,$18
	move	$6,$17
	.set	noreorder
	.set	nomacro
	jal	ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	move	$7,$19
	.set	macro
	.set	reorder

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

	.end	ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___35tInsideBoxControllerLeftRightSlider
	.ent	___35tInsideBoxControllerLeftRightSlider
___35tInsideBoxControllerLeftRightSlider:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___25tInsideBoxLeftRightSlider
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___35tInsideBoxControllerLeftRightSlider
	.align	2
	.globl	___19tMemoryCardMenuItem
	.ent	___19tMemoryCardMenuItem
___19tMemoryCardMenuItem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___23tMenuItemGoToMenuButton
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___19tMemoryCardMenuItem
	.align	2
	.globl	___27tMenuItemGoToMenuButtonFade
	.ent	___27tMenuItemGoToMenuButtonFade
___27tMenuItemGoToMenuButtonFade:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___23tMenuItemGoToMenuButton
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___27tMenuItemGoToMenuButtonFade
	.align	2
	.globl	___17tUserNameMenuItem
	.ent	___17tUserNameMenuItem
___17tUserNameMenuItem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___9tMenuItem
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___17tUserNameMenuItem
	.align	2
	.globl	___34tMenuItemControllerLeftRightChoice
	.ent	___34tMenuItemControllerLeftRightChoice
___34tMenuItemControllerLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___34tMenuItemControllerLeftRightChoice
	.align	2
	.globl	___29tMenuItemOnOffLeftRightChoice
	.ent	___29tMenuItemOnOffLeftRightChoice
___29tMenuItemOnOffLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___29tMenuItemOnOffLeftRightChoice
	.align	2
	.globl	___31tMenuItemDisplayLeftRightChoice
	.ent	___31tMenuItemDisplayLeftRightChoice
___31tMenuItemDisplayLeftRightChoice:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___31tMenuItemDisplayLeftRightChoice
	.align	2
	.globl	___25tMenuItemSlidingActivated
	.ent	___25tMenuItemSlidingActivated
___25tMenuItemSlidingActivated:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___20tMenuItemSlidingMenu
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___25tMenuItemSlidingActivated
	.align	2
	.globl	___22tMenuItemLeftRightFade
	.ent	___22tMenuItemLeftRightFade
___22tMenuItemLeftRightFade:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___24tMenuItemLeftRightChoice
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___22tMenuItemLeftRightFade
	.globl	_UNK_80010a02
	.data
	.align	1
_UNK_80010a02:
	.space	2
	.globl	_UNK_80010a06
	.align	1
_UNK_80010a06:
	.space	2
	.globl	_UNK_80010a0a
	.align	1
_UNK_80010a0a:
	.space	2
