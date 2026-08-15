	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\device.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Device_VerifyType__Fi

	.lcomm	failtime.228,2
	.align	2
	.globl	Device_Fail__Fi
	.align	2
	.globl	Device_Update__Fv
	.align	2
	.globl	Device_StartUp__Fv
	.align	2
	.globl	Device_SetHardCodedKeys__Fv
	.align	2
	.globl	Device_PSXPad__FUl
	.align	2
	.globl	Device_ReadPad__FiUl
	.align	2
	.globl	Device_PSXPadMulti__FUl
	.align	2
	.globl	Device_Analog__FUl
	.align	2
	.globl	Device_Null__FUl
	.globl	Device_gPaused
	.sdata
	.align	2
Device_gPaused:
	.space	4
	.globl	Device_gForcePause
	.align	2
Device_gForcePause:
	.space	4
	.globl	Device_gPausePort
	.align	2
Device_gPausePort:
	.space	4
	.globl	Device_gPausePortIndex
Device_gPausePortIndex:
	.space	1
	.globl	Device_gToggleTime
	.align	2
Device_gToggleTime:
	.space	8
	.globl	Device_gPrev
	.align	2
Device_gPrev:
	.space	8

	.extern	Replay_ReplayMode, 4
	.extern	simVar, 28
	.extern	GameSetup_gData, 2600
	.extern	frontEnd, 1104
	.extern	gPadinfo, 84
	.extern	gUseFrontend, 4

	.text
	.text
	.ent	Device_VerifyType__Fi
Device_VerifyType__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,gUseFrontend
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$4,3
	addu	$16,$3,$2
	lbu	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	sltu	$4,$0,$4
	subu	$5,$0,$4
	andi	$2,$5,0x0002
	addu	$17,$2,$3
	lbu	$3,5($16)
	lh	$2,862($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L601
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(GameSetup_gData) # low
	andi	$3,$5,0x0004
	addu	$3,$3,$2
	lw	$5,96($3)
	jal	InGame_ResetPSXController__Fii
	lbu	$3,5($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L610
	sh	$3,862($17)
	.set	macro
	.set	reorder

$L601:
	li	$2,1			# 0x00000001
$L610:
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

	.end	Device_VerifyType__Fi
	.text
	.ent	Device_Fail__Fi
Device_Fail__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Device_VerifyType__Fi
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	sltu	$2,$0,$16
	.set	macro
	.set	reorder

	la	$3,failtime.228
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L613
	sb	$0,0($2)
	.set	macro
	.set	reorder

$L612:
	la	$3,failtime.228
	addu	$4,$2,$3
	lbu	$3,0($4)
	#nop
	sltu	$2,$3,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	addu	$2,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L616
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L614:
	sb	$2,0($4)
$L613:
	move	$2,$0
$L616:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Device_Fail__Fi
	.text
	.ent	Device_Update__Fv
Device_Update__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	PAD_update
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(simVar+8) # high
	lw	$2,%lo(simVar+8)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,Device_gPaused
	li	$2,17			# 0x00000011
	sw	$2,Device_gToggleTime
	sw	$2,Device_gToggleTime+4
	.set	noreorder
	.set	nomacro
	j	$L626
	lui	$2,%hi(simVar+8) # high
	.set	macro
	.set	reorder

$L618:
	lw	$2,Device_gPaused
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$0,Device_gPaused
	sw	$2,Device_gPausePort
	sw	$0,Device_gToggleTime
	sw	$0,Device_gToggleTime+4
$L619:
	lui	$2,%hi(simVar+8) # high
$L626:
	lw	$2,%lo(simVar+8)($2)
	#nop
	bne	$2,$0,$L617
	.set	noreorder
	.set	nomacro
	jal	Device_Fail__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L622
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,Device_gForcePause
	sw	$0,Device_gPausePort
	sb	$0,Device_gPausePortIndex
	j	$L617
$L622:
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$16,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	bne	$16,$2,$L624
	.set	noreorder
	.set	nomacro
	jal	Device_Fail__Fi
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	sw	$16,Device_gForcePause
	sw	$2,Device_gPausePort
	sb	$16,Device_gPausePortIndex
	j	$L617
$L624:
	sw	$0,Device_gForcePause
$L617:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Device_Update__Fv
	.text
	.ent	Device_StartUp__Fv
Device_StartUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	sw	$0,Device_gPaused
	sw	$0,Device_gForcePause
	sw	$2,Device_gPausePort
	sw	$0,Device_gToggleTime
	sw	$0,Device_gToggleTime+4
	sw	$0,Device_gPrev
	sw	$0,Device_gPrev+4
	j	$31
	.end	Device_StartUp__Fv
	.text
	.ent	Device_SetHardCodedKeys__Fv
Device_SetHardCodedKeys__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$6,4194304			# 0x00400000
	ori	$6,$6,0x0003
	li	$5,1048576			# 0x00100000
	ori	$5,$5,0x0003
	li	$4,8388608			# 0x00800000
	ori	$4,$4,0x0003
	lui	$2,%hi(Input_gHandler) # high
	addiu	$2,$2,%lo(Input_gHandler) # low
	li	$3,4099			# 0x00001003
	sw	$3,612($2)
	li	$3,16387			# 0x00004003
	sw	$3,616($2)
	li	$3,32771			# 0x00008003
	sw	$3,620($2)
	li	$3,8195			# 0x00002003
	sw	$3,624($2)
	li	$3,2051			# 0x00000803
	sw	$3,632($2)
	li	$3,259			# 0x00000103
	sw	$6,628($2)
	sw	$5,704($2)
	sw	$4,708($2)
	sw	$3,640($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,608($2)
	.set	macro
	.set	reorder

	.end	Device_SetHardCodedKeys__Fv
	.text
	.ent	Device_PSXPad__FUl
Device_PSXPad__FUl:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	srl	$16,$17,16
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Device_VerifyType__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L630
	lui	$3,%hi(gPadinfo+6) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(gPadinfo+6) # low
	sll	$2,$16,3
	addu	$2,$2,$3
	lhu	$3,0($2)
	#nop
	nor	$3,$0,$3
	andi	$3,$3,0xffff
	and	$3,$3,$17
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L632
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L630:
	move	$2,$0
$L632:
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

	.end	Device_PSXPad__FUl
	.text
	.ent	Device_ReadPad__FiUl
Device_ReadPad__FiUl:
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
	jal	Device_VerifyType__Fi
	move	$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L649
	move	$2,$0
	.set	macro
	.set	reorder

$L634:
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$16,3
	addu	$4,$3,$2
	lbu	$3,5($4)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L655
	sll	$3,$16,3
	.set	macro
	.set	reorder

	andi	$3,$17,0xffff
	li	$2,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L656
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

	lbu	$2,9($4)
	#nop
	sltu	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L656:
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$16,3
	addu	$4,$3,$2
	lbu	$3,5($4)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L655
	sll	$3,$16,3
	.set	macro
	.set	reorder

	andi	$3,$17,0xffff
	li	$2,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L655
	sll	$3,$16,3
	.set	macro
	.set	reorder

	lbu	$2,10($4)
	#nop
	sltu	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L655:
	lui	$2,%hi(gPadinfo+6) # high
	addiu	$2,$2,%lo(gPadinfo+6) # low
	addu	$5,$3,$2
	addu	$2,$2,$3
	lbu	$3,-1($2)
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L646
	addu	$4,$5,2
	.set	macro
	.set	reorder

	andi	$3,$17,0xffff
	li	$2,128			# 0x00000080
	bne	$3,$2,$L637
	lbu	$2,2($5)
	#nop
	sltu	$2,$2,65
	beq	$2,$0,$L638
$L654:
	.set	noreorder
	.set	nomacro
	j	$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L638:
	lbu	$2,2($4)
	#nop
	sltu	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L637:
	lui	$3,%hi(gPadinfo) # high
	addiu	$3,$3,%lo(gPadinfo) # low
	sll	$2,$16,3
	addu	$2,$2,$3
	lbu	$3,5($2)
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L646
	andi	$3,$17,0xffff
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	bne	$3,$2,$L640
	lbu	$2,0($4)
	#nop
	sltu	$2,$2,192
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,2($4)
	#nop
	sltu	$2,$2,192
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L640:
	lui	$3,%hi(gPadinfo) # high
	addiu	$3,$3,%lo(gPadinfo) # low
	sll	$2,$16,3
	addu	$2,$2,$3
	lbu	$3,5($2)
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L646
	andi	$3,$17,0xffff
	.set	macro
	.set	reorder

	li	$2,16			# 0x00000010
	bne	$3,$2,$L643
	lbu	$2,3($4)
	#nop
	sltu	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,1($4)
	#nop
	sltu	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L643:
	lui	$3,%hi(gPadinfo) # high
	addiu	$3,$3,%lo(gPadinfo) # low
	sll	$2,$16,3
	addu	$2,$2,$3
	lbu	$3,5($2)
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L646
	andi	$3,$17,0xffff
	.set	macro
	.set	reorder

	li	$2,64			# 0x00000040
	bne	$3,$2,$L646
	lbu	$2,3($4)
	#nop
	sltu	$2,$2,192
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,1($4)
	#nop
	sltu	$2,$2,192
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L649
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L646:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$16
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	and	$2,$2,$17
	sltu	$2,$0,$2
$L649:
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

	.end	Device_ReadPad__FiUl
	.text
	.ent	Device_PSXPadMulti__FUl
Device_PSXPadMulti__FUl:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(simVar+8) # high
	lw	$2,%lo(simVar+8)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$4,Device_gPausePort
	.set	noreorder
	.set	nomacro
	jal	Device_ReadPad__FiUl
	move	$5,$16
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L666
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L666
	move	$2,$0
	.set	macro
	.set	reorder

$L658:
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	Device_ReadPad__FiUl
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	andi	$3,$16,0xffff
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L666
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

	sw	$0,Device_gPausePort
	sb	$0,Device_gPausePortIndex
	j	$L666
$L660:
	lw	$2,Replay_ReplayMode
	#nop
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L666
	move	$2,$0
	.set	macro
	.set	reorder

$L663:
	li	$4,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	Device_ReadPad__FiUl
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L662
	andi	$3,$16,0xffff
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L665
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,Device_gPausePortIndex
	li	$2,4			# 0x00000004
	sw	$2,Device_gPausePort
$L665:
	.set	noreorder
	.set	nomacro
	j	$L666
	li	$2,255			# 0x000000ff
	.set	macro
	.set	reorder

$L662:
	move	$2,$0
$L666:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Device_PSXPadMulti__FUl
	.text
	.ent	Device_Analog__FUl
Device_Analog__FUl:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	srl	$17,$16,20
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Device_VerifyType__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L668
	srl	$4,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L681
	move	$2,$0
	.set	macro
	.set	reorder

$L668:
	andi	$4,$4,0x0003
	lui	$3,%hi(gPadinfo+8) # high
	addiu	$3,$3,%lo(gPadinfo+8) # low
	sll	$2,$17,3
	addu	$2,$2,$4
	addu	$2,$2,$3
	lbu	$3,0($2)
	srl	$2,$16,8
	andi	$5,$2,0x00ff
	andi	$4,$16,0x00ff
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	slt	$2,$3,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L682
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	subu	$3,$3,$5
	.set	macro
	.set	reorder

$L684:
	.set	noreorder
	.set	nomacro
	j	$L674
	li	$3,255			# 0x000000ff
	.set	macro
	.set	reorder

$L672:
	sll	$2,$3,8
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L683
	subu	$3,$4,$5
	.set	macro
	.set	reorder

$L669:
	.set	noreorder
	.set	nomacro
	beq	$5,$4,$L682
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	subu	$3,$5,$3
	.set	macro
	.set	reorder

$L682:
	.set	noreorder
	.set	nomacro
	j	$L674
	move	$3,$0
	.set	macro
	.set	reorder

$L679:
	sll	$2,$3,8
	subu	$2,$2,$3
	subu	$3,$5,$4
$L683:
	div	$3,$2,$3
$L674:
	move	$2,$3
$L681:
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

	.end	Device_Analog__FUl
	.text
	.ent	Device_Null__FUl
Device_Null__FUl:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Device_Null__FUl
