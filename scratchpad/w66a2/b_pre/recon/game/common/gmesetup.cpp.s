	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\gmesetup.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	GameSetup_StartUp__FPi
	.align	2
	.globl	GameSetup_CleanUp__Fv
	.globl	GameSetup_gData
	.data
	.align	2
GameSetup_gData:
	.space	2600

	.extern	gMasterAmbientLevel, 4
	.extern	gMasterEngineLevel, 4
	.extern	gMasterFENarrationLevel, 4
	.extern	gMasterSFXLevel, 4
	.extern	gMasterMusicLevel, 4

	.text
	.text
	.ent	GameSetup_StartUp__FPi
GameSetup_StartUp__FPi:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Input_StartUp__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$18
	lui	$2,%hi(Input_gHandler) # high
	lw	$3,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L601
	addiu	$20,$2,%lo(Input_gHandler) # low
	.set	macro
	.set	reorder

	lui	$17,%hi(FEI_gList) # high
	lui	$2,%hi(Device_gDeviceList) # high
	addiu	$19,$2,%lo(Device_gDeviceList) # low
$L602:
	lw	$5,0($16)
	#nop
	slt	$2,$5,259
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L605
	slt	$2,$5,77
	.set	macro
	.set	reorder

	addiu	$3,$17,%lo(FEI_gList) # low
	lw	$2,%lo(FEI_gList)($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,0($3)
$L641:
	bne	$2,$5,$L608
	lw	$4,4($3)
$L608:
	addu	$3,$3,8
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L641
$L607:
	beq	$4,$0,$L612
	lw	$3,4($16)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	subu	$3,$3,$2
	sll	$3,$3,2
	lw	$2,8($16)
	addu	$4,$4,$3
	sw	$2,0($4)
$L612:
	.set	noreorder
	.set	nomacro
	j	$L604
	addu	$16,$16,12
	.set	macro
	.set	reorder

$L605:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	addiu	$3,$17,%lo(FEI_gList) # low
	.set	macro
	.set	reorder

	sll	$2,$5,2
	lw	$3,4($16)
	addu	$2,$2,$20
	sw	$3,-308($2)
	lw	$4,4($16)
	#nop
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$19
	lw	$2,8($2)
	#nop
	beq	$2,$0,$L631
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L604
	addu	$16,$16,8
	.set	macro
	.set	reorder

$L614:
	lw	$2,%lo(FEI_gList)($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,0($3)
$L642:
	bne	$2,$5,$L619
	lw	$4,4($3)
$L619:
	addu	$3,$3,8
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L642
$L618:
	beq	$4,$0,$L623
	lw	$2,0($16)
	#nop
	slt	$2,$2,75
	bne	$2,$0,$L624
	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L623
	move	$5,$0
	.set	macro
	.set	reorder

	move	$3,$16
$L628:
	lw	$2,8($3)
	addu	$3,$3,4
	addu	$5,$5,1
	sw	$2,0($4)
	lw	$2,4($16)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	addu	$4,$4,4
	.set	macro
	.set	reorder

	j	$L623
$L624:
	lw	$2,4($16)
	#nop
	sw	$2,0($4)
$L623:
	lw	$2,0($16)
	#nop
	slt	$2,$2,75
	bne	$2,$0,$L631
	lw	$2,4($16)
	#nop
	sll	$2,$2,2
	addu	$16,$16,$2
$L631:
	addu	$16,$16,8
$L604:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L602
$L601:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,100			# 0x00000064
	.set	macro
	.set	reorder

	jal	PAD_update
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,2313			# 0x00000909
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L633
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	sw	$2,%lo(GameSetup_gData+56)($3)
$L633:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,41088			# 0x0000a080
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L634
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sw	$2,%lo(GameSetup_gData+56)($3)
$L634:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,49153			# 0x0000c001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L635
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	sw	$2,%lo(GameSetup_gData+56)($3)
$L635:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,1600			# 0x00000640
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L636
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,16			# 0x00000010
	sw	$2,%lo(GameSetup_gData+56)($3)
$L636:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,1552			# 0x00000610
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L637
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
	sw	$2,%lo(GameSetup_gData+56)($3)
$L637:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,2320			# 0x00000910
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L638
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,64			# 0x00000040
	sw	$2,%lo(GameSetup_gData+56)($3)
$L638:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,20496			# 0x00005010
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L639
	lui	$3,%hi(GameSetup_gData+56) # high
	.set	macro
	.set	reorder

	li	$2,128			# 0x00000080
	sw	$2,%lo(GameSetup_gData+56)($3)
$L639:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
	li	$3,1568			# 0x00000620
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L643
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(GameSetup_gData+56) # high
	li	$2,256			# 0x00000100
	sw	$2,%lo(GameSetup_gData+56)($3)
	lui	$2,%hi(GameSetup_gData) # high
$L643:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	lw	$3,240($2)
	lw	$4,244($2)
	lw	$5,252($2)
	lw	$6,248($2)
	lw	$2,256($2)
	sw	$3,gMasterMusicLevel
	sw	$4,gMasterSFXLevel
	sw	$5,gMasterFENarrationLevel
	sw	$6,gMasterEngineLevel
	sw	$2,gMasterAmbientLevel
	jal	Device_SetHardCodedKeys__Fv
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

	.end	GameSetup_StartUp__FPi
	.text
	.ent	GameSetup_CleanUp__Fv
GameSetup_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	GameSetup_CleanUp__Fv
