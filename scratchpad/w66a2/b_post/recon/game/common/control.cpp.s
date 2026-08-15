	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\control.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Control_AI__FP8Car_tObj
	.align	2
	.globl	Control_Human__FP8Car_tObj

	.extern	HudBustedOverlay, 4
	.extern	GameSetup_gData, 2600
	.extern	Input_gSim, 4
	.extern	Cars_gNumAICars, 4
	.extern	simGlobal, 24

	.text
	.text
	.ent	Control_AI__FP8Car_tObj
Control_AI__FP8Car_tObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Control_AI__FP8Car_tObj
	.text
	.ent	Control_Human__FP8Car_tObj
Control_Human__FP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumAICars
	#nop
	blez	$2,$L603
	lw	$2,596($16)
	#nop
	bne	$2,$0,$L603
	jal	AI_Main_OverallSetup__Fv
$L603:
	jal	InGame_SetRamp__Fv
	lw	$2,1224($16)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,1120($16)
	#nop
	beq	$2,$0,$L604
	lbu	$2,1112($16)
	lw	$3,1116($16)
	andi	$2,$2,0x00f8
	.set	noreorder
	.set	nomacro
	bgez	$3,$L605
	sb	$2,1084($16)
	.set	macro
	.set	reorder

	addu	$3,$3,3
$L605:
	sra	$2,$3,2
	sll	$2,$2,2
	sw	$2,1100($16)
	sb	$0,1085($16)
	sb	$0,1093($16)
	sb	$0,1094($16)
	sb	$0,1097($16)
	.set	noreorder
	.set	nomacro
	j	$L606
	sb	$0,1098($16)
	.set	macro
	.set	reorder

$L604:
	lbu	$2,Input_gSim+1
	#nop
	andi	$2,$2,0x00f8
	sb	$2,1084($16)
	lbu	$2,Input_gSim+2
	la	$4,Input_gSim+1
	andi	$2,$2,0x00f8
	sb	$2,1085($16)
	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$3,%lo(GameSetup_gData+44)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L607
	lb	$2,-1($4)
	#nop
	bgez	$2,$L608
	addu	$2,$2,3
$L608:
	sra	$2,$2,2
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L646
	subu	$2,$0,$2
	.set	macro
	.set	reorder

$L607:
	lb	$2,-1($4)
	#nop
	bgez	$2,$L610
	addu	$2,$2,3
$L610:
	sra	$2,$2,2
	sll	$2,$2,2
$L646:
	sw	$2,1100($16)
	lbu	$2,Input_gSim+3
	#nop
	andi	$2,$2,0x0001
	sb	$2,1093($16)
	lbu	$2,Input_gSim+3
	#nop
	srl	$2,$2,1
	andi	$2,$2,0x0001
	sb	$2,1094($16)
	lbu	$2,Input_gSim+3
	#nop
	srl	$2,$2,3
	xori	$2,$2,0x0003
	sltu	$2,$2,1
	sb	$2,1097($16)
	lbu	$2,Input_gSim+3
	#nop
	srl	$2,$2,3
	sb	$2,1098($16)
$L606:
	lbu	$2,1098($16)
	#nop
	addu	$3,$2,-4
	sltu	$2,$3,11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	lui	$2,%hi($L641) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L641) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L641:
	.word	$L612
	.word	$L614
	.word	$L616
	.word	$L618
	.word	$L622
	.word	$L611
	.word	$L611
	.word	$L626
	.word	$L633
	.word	$L611
	.word	$L637
	.text
$L612:
	lw	$2,HudBustedOverlay
	#nop
	bne	$2,$0,$L611
	lw	$4,596($16)
	lbu	$2,1098($16)
	.set	noreorder
	.set	nomacro
	j	$L647
	move	$5,$0
	.set	macro
	.set	reorder

$L614:
	lw	$2,HudBustedOverlay
	#nop
	bne	$2,$0,$L611
	lw	$4,596($16)
	lbu	$2,1098($16)
	.set	noreorder
	.set	nomacro
	j	$L647
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L616:
	lw	$2,HudBustedOverlay
	#nop
	bne	$2,$0,$L611
	lw	$4,596($16)
	lbu	$2,1098($16)
	li	$5,2			# 0x00000002
$L647:
	.set	noreorder
	.set	nomacro
	jal	Hud_WingmanFlash__Fii
	sb	$2,1099($16)
	.set	macro
	.set	reorder

	j	$L611
$L618:
	lw	$2,648($16)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-22
	sltu	$2,$2,6
	bne	$2,$0,$L611
	lbu	$3,1095($16)
	#nop
	andi	$2,$3,0x0008
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L649
	andi	$2,$3,0x00e7
	.set	macro
	.set	reorder

	ori	$2,$3,0x0008
	lhu	$3,2232($16)
	andi	$2,$2,0x00ef
	sb	$2,1095($16)
	sh	$0,2234($16)
	ori	$3,$3,0x0080
	.set	noreorder
	.set	nomacro
	j	$L611
	sh	$3,2232($16)
	.set	macro
	.set	reorder

$L622:
	lw	$2,648($16)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-22
	sltu	$2,$2,6
	bne	$2,$0,$L611
	lbu	$3,1095($16)
	#nop
	andi	$2,$3,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	andi	$2,$3,0x00e7
	.set	macro
	.set	reorder

	sb	$2,1095($16)
	sh	$0,2234($16)
	.set	noreorder
	.set	nomacro
	j	$L611
	sh	$0,2232($16)
	.set	macro
	.set	reorder

$L624:
	ori	$2,$3,0x0010
	lhu	$3,2234($16)
	andi	$2,$2,0x00f7
	sb	$2,1095($16)
	sh	$0,2232($16)
	ori	$3,$3,0x0080
	.set	noreorder
	.set	nomacro
	j	$L611
	sh	$3,2234($16)
	.set	macro
	.set	reorder

$L626:
	lw	$2,648($16)
	#nop
	lw	$2,0($2)
	#nop
	addu	$2,$2,-22
	sltu	$2,$2,6
	beq	$2,$0,$L627
	lw	$3,1392($16)
	#nop
	andi	$2,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L611
	sw	$2,1392($16)
	.set	macro
	.set	reorder

$L628:
	ori	$2,$3,0x0002
	.set	noreorder
	.set	nomacro
	j	$L611
	sw	$2,1392($16)
	.set	macro
	.set	reorder

$L627:
	lbu	$3,1095($16)
	#nop
	andi	$2,$3,0x0018
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L631
	andi	$2,$3,0x00e7
	.set	macro
	.set	reorder

	ori	$2,$3,0x0018
	sb	$2,1095($16)
	lhu	$2,2232($16)
	lhu	$3,2234($16)
	ori	$2,$2,0x0080
	ori	$3,$3,0x0080
	sh	$2,2232($16)
	.set	noreorder
	.set	nomacro
	j	$L611
	sh	$3,2234($16)
	.set	macro
	.set	reorder

$L631:
$L649:
	sb	$2,1095($16)
	sh	$0,2232($16)
	.set	noreorder
	.set	nomacro
	j	$L611
	sh	$0,2234($16)
	.set	macro
	.set	reorder

$L633:
	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0002
	bne	$2,$0,$L611
	lbu	$2,1095($16)
	#nop
	xori	$5,$2,0x0003
	andi	$2,$5,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	sb	$5,1095($16)
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	R3DCar_TurnHeadLightOn__FP8Car_tObji
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L611
$L635:
	move	$4,$16
	andi	$5,$5,0x0004
	.set	noreorder
	.set	nomacro
	j	$L648
	sltu	$5,$5,1
	.set	macro
	.set	reorder

$L637:
	lbu	$2,1095($16)
	#nop
	xori	$3,$2,0x0004
	andi	$2,$3,0x0002
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	sb	$3,1095($16)
	.set	macro
	.set	reorder

	lw	$2,1392($16)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	andi	$2,$3,0x0004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	R3DCar_TurnHeadLightOn__FP8Car_tObji
	move	$5,$0
	.set	macro
	.set	reorder

	j	$L611
$L639:
	li	$5,1			# 0x00000001
$L648:
	jal	R3DCar_TurnHeadLightOff__FP8Car_tObji
$L611:
	lw	$2,1124($16)
	lbu	$4,1090($16)
	lw	$5,4($2)
	jal	Input_Gear__Fci
	lw	$3,1124($16)
	lw	$4,1128($16)
	lw	$3,240($3)
	#nop
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L644
	andi	$5,$2,0x00ff
	.set	macro
	.set	reorder

	lbu	$2,1090($16)
	#nop
	slt	$2,$5,$2
	bne	$2,$0,$L601
$L644:
	sb	$5,1086($16)
$L601:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Control_Human__FP8Car_tObj
