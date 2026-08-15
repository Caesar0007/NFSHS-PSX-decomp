	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\psxcontroller.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	InGame_ResetPSXController__Fii
	.align	2
	.globl	InGame_GetPSXPadValue__Fii
	.align	2
	.globl	InGame_GetDevice__Fi
	.align	2
	.globl	InGame_SetRamp__Fv

	.extern	Cars_gNumHumanRaceCars, 4
	.extern	Replay_ReplayMode, 4
	.extern	GameSetup_gData, 2600
	.extern	frontEnd, 1104
	.extern	gPadinfo, 84

	.text
	.text
	.ent	InGame_ResetPSXController__Fii
InGame_ResetPSXController__Fii:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$22,40($sp)
	lui	$3,%hi(gPadinfo) # high
	addiu	$3,$3,%lo(gPadinfo) # low
	sll	$2,$18,5
	addu	$2,$2,$3
	sw	$31,44($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$19,5($2)
	lui	$2,%hi(Input_gHandler) # high
	addiu	$20,$2,%lo(Input_gHandler) # low
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$19,$2,$L601
	move	$22,$5
	.set	macro
	.set	reorder

	li	$2,83			# 0x00000053
	.set	noreorder
	.set	nomacro
	beq	$19,$2,$L605
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L602
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L605:
	.set	noreorder
	.set	nomacro
	j	$L602
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L601:
	move	$2,$0
$L602:
	move	$19,$2
 #APP
 #NO_APP
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	sll	$3,$18,1
	addu	$5,$3,$2
	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$18,5
	addu	$4,$3,$2
	lh	$3,862($5)
	lbu	$2,5($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L616
	sll	$21,$18,2
	.set	macro
	.set	reorder

	lbu	$2,5($4)
	#nop
	sh	$2,862($5)
$L616:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$2,$21,$2
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sw	$22,96($2)
	sll	$2,$22,2
	addu	$2,$2,$22
	sll	$2,$2,3
	subu	$2,$2,$22
	addu	$2,$2,$19
	sll	$2,$2,2
	addu	$16,$2,$3
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(D_8013DAC0) # high
	addiu	$3,$3,%lo(D_8013DAC0) # low
	addu	$17,$21,$3
	lw	$4,0($17)
	li	$3,79			# 0x0000004f
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,80			# 0x00000050
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,81			# 0x00000051
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,36($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,82			# 0x00000052
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,96($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	addu	$3,$21,$20
	sw	$2,696($3)
	lw	$4,84($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,117			# 0x00000075
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,84($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,101			# 0x00000065
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,48($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,83			# 0x00000053
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$2,$2,%lo(Cars_gHumanRaceCarList) # low
	addu	$2,$21,$2
	lw	$2,0($2)
	#nop
	lw	$2,608($2)
	#nop
	andi	$2,$2,0x0200
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,120($16)
	bne	$19,$2,$L608
	ori	$4,$4,0x0006
$L608:
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	j	$L615
	li	$3,129			# 0x00000081
	.set	macro
	.set	reorder

$L607:
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,125			# 0x0000007d
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,126			# 0x0000007e
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	li	$2,1			# 0x00000001
	lw	$4,120($16)
	bne	$19,$2,$L610
	ori	$4,$4,0x0006
$L610:
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,130			# 0x00000082
$L615:
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lui	$2,%hi(GameSetup_gData+84) # high
	lw	$2,%lo(GameSetup_gData+84)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	lui	$3,%hi(mappings) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$22,2
	addu	$2,$2,$22
	sll	$2,$2,3
	subu	$2,$2,$22
	addu	$2,$2,$19
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,108($2)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	sll	$4,$18,2
	lui	$3,%hi(D_8013DAC0) # high
	addiu	$3,$3,%lo(D_8013DAC0) # low
	addu	$16,$4,$3
	lw	$4,0($16)
	li	$3,115			# 0x00000073
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L612
	move	$5,$0
	.set	macro
	.set	reorder

	li	$5,6			# 0x00000006
$L612:
	.set	noreorder
	.set	nomacro
	j	$L614
	move	$4,$5
	.set	macro
	.set	reorder

$L611:
	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	sll	$4,$18,2
	lui	$3,%hi(D_8013DAC0) # high
	addiu	$3,$3,%lo(D_8013DAC0) # low
	addu	$16,$4,$3
	lw	$4,0($16)
	li	$3,115			# 0x00000073
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$22,2
	addu	$2,$2,$22
	sll	$2,$2,3
	subu	$2,$2,$22
	addu	$2,$2,$19
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,108($2)
	li	$2,1			# 0x00000001
	bne	$19,$2,$L614
	ori	$4,$4,0x0006
$L614:
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($16)
	li	$3,84			# 0x00000054
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lui	$2,%hi(mappings) # high
	addiu	$2,$2,%lo(mappings) # low
	sll	$16,$22,2
	addu	$16,$16,$22
	sll	$16,$16,3
	subu	$16,$16,$22
	addu	$16,$16,$19
	sll	$16,$16,2
	addu	$16,$16,$2
	lw	$4,60($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	sll	$17,$18,2
	lui	$3,%hi(D_8013DAC0) # high
	addiu	$3,$3,%lo(D_8013DAC0) # low
	addu	$17,$17,$3
	lw	$4,0($17)
	li	$3,102			# 0x00000066
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,72($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,103			# 0x00000067
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,144($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,104			# 0x00000068
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$4,132($16)
	.set	noreorder
	.set	nomacro
	jal	InGame_GetPSXPadValue__Fii
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$4,0($17)
	li	$3,77			# 0x0000004d
	subu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$20
	sw	$2,0($3)
	lw	$31,44($sp)
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
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	InGame_ResetPSXController__Fii
	.text
	.ent	InGame_GetPSXPadValue__Fii
InGame_GetPSXPadValue__Fii:
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
	jal	PAD_update
	move	$17,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$17,5
	addu	$3,$3,$2
	lbu	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$3,5($3)
 #APP
	
 #NO_APP
	j	$L659
$L619:
	move	$3,$0
$L659:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L623
	slt	$2,$3,84
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L638
	sll	$2,$17,26
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L661
	sll	$3,$16,8
	.set	macro
	.set	reorder

$L650:
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L660
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L623:
	li	$2,4194304			# 0x00400000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L628
	sll	$4,$17,2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	li	$2,268435456			# 0x10000000
	.set	macro
	.set	reorder

	li	$2,1048576			# 0x00100000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L627
	sll	$5,$17,2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L636
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,-2147483648			# 0x80000000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L629
	sll	$6,$17,30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L660
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L636:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L626
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L660
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L635:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L631
	sll	$6,$17,30
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	li	$2,536870912			# 0x20000000
	.set	macro
	.set	reorder

	li	$2,8388608			# 0x00800000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L625
	sll	$2,$17,26
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L661
	sll	$3,$16,8
	.set	macro
	.set	reorder

$L637:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L630
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	li	$2,1073741824			# 0x40000000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L632
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L660
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L625:
	sll	$5,$17,30
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	li	$3,128			# 0x00000080
	lw	$2,136($4)
	lw	$4,144($4)
	subu	$2,$3,$2
	sll	$2,$2,16
	or	$5,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L652
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L626:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	sll	$5,$17,30
	lw	$3,136($4)
	lw	$2,144($4)
	addu	$3,$3,128
	sll	$3,$3,16
	or	$5,$5,$3
	addu	$2,$2,128
	sll	$2,$2,8
	or	$4,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L651
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L627:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$5,$5,$2
	li	$4,128			# 0x00000080
	lw	$2,136($5)
	li	$3,16777216			# 0x01000000
	subu	$2,$4,$2
	sll	$2,$2,16
	or	$2,$2,$3
	lw	$3,144($5)
	.set	noreorder
	.set	nomacro
	j	$L653
	sll	$6,$17,30
	.set	macro
	.set	reorder

$L628:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$4,$4,$2
	lw	$2,136($4)
	li	$3,16777216			# 0x01000000
	addu	$2,$2,128
	sll	$2,$2,16
	or	$2,$2,$3
	lw	$3,144($4)
	.set	noreorder
	.set	nomacro
	j	$L654
	sll	$5,$17,30
	.set	macro
	.set	reorder

$L629:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$5,$17,2
	addu	$5,$5,$2
	li	$4,128			# 0x00000080
	lw	$2,152($5)
	.set	noreorder
	.set	nomacro
	j	$L655
	li	$3,33554432			# 0x02000000
	.set	macro
	.set	reorder

$L630:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	sll	$5,$17,30
	lw	$2,152($4)
	.set	noreorder
	.set	nomacro
	j	$L656
	li	$3,33554432			# 0x02000000
	.set	macro
	.set	reorder

$L631:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$5,$17,2
	addu	$5,$5,$2
	li	$4,128			# 0x00000080
	lw	$2,152($5)
	li	$3,50331648			# 0x03000000
$L655:
	subu	$2,$4,$2
	sll	$2,$2,16
	or	$2,$2,$3
	lw	$3,160($5)
$L653:
	or	$6,$6,$2
	subu	$4,$4,$3
	sll	$4,$4,8
	or	$4,$6,$4
	.set	noreorder
	.set	nomacro
	j	$L651
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L632:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	sll	$5,$17,30
	lw	$2,152($4)
	li	$3,50331648			# 0x03000000
$L656:
	addu	$2,$2,128
	sll	$2,$2,16
	or	$2,$2,$3
	lw	$3,160($4)
$L654:
	or	$5,$5,$2
	addu	$3,$3,128
$L652:
	sll	$3,$3,8
	or	$4,$5,$3
	.set	noreorder
	.set	nomacro
	j	$L651
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L638:
	li	$2,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L643
	lui	$3,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L647
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L644
	li	$3,50987008			# 0x030a0000
	.set	macro
	.set	reorder

	li	$2,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L642
	lui	$3,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L660
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L647:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L641
	lui	$2,%hi(GameSetup_gData) # high
	.set	macro
	.set	reorder

	li	$2,8388608			# 0x00800000
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L621
	sll	$5,$17,30
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	li	$3,128			# 0x00000080
	lw	$2,104($4)
	lw	$4,112($4)
	subu	$2,$3,$2
	sll	$2,$2,16
	or	$5,$5,$2
	subu	$3,$3,$4
	sll	$3,$3,8
	or	$4,$5,$3
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L651
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L641:
	addiu	$2,$2,%lo(GameSetup_gData) # low
	sll	$4,$17,2
	addu	$4,$4,$2
	sll	$5,$17,30
	lw	$3,104($4)
	lw	$2,112($4)
	addu	$3,$3,128
	sll	$3,$3,16
	or	$4,$5,$3
	addu	$2,$2,128
	.set	noreorder
	.set	nomacro
	j	$L657
	sll	$2,$2,8
	.set	macro
	.set	reorder

$L642:
	addiu	$3,$3,%lo(GameSetup_gData) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$2,128($2)
	sll	$4,$17,30
	.set	noreorder
	.set	nomacro
	j	$L658
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L643:
	addiu	$3,$3,%lo(GameSetup_gData) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$2,120($2)
	sll	$4,$17,30
	li	$3,33554432			# 0x02000000
$L658:
	sll	$2,$2,8
	or	$2,$2,$3
$L657:
	or	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L651
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L644:
	ori	$3,$3,0xff01
	sll	$2,$17,30
	.set	noreorder
	.set	nomacro
	j	$L651
	or	$2,$2,$3
	.set	macro
	.set	reorder

$L621:
	sll	$2,$17,26
$L660:
	sll	$3,$16,8
$L661:
	or	$2,$2,$3
	ori	$2,$2,0x0002
$L651:
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

	.end	InGame_GetPSXPadValue__Fii
	.text
	.ent	InGame_GetDevice__Fi
InGame_GetDevice__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$4,0x00ff
	.set	macro
	.set	reorder

	.end	InGame_GetDevice__Fi
	.text
	.ent	InGame_SetRamp__Fv
InGame_SetRamp__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lw	$2,Replay_ReplayMode
	lui	$3,%hi(Input_gHandler) # high
	sw	$20,32($sp)
	addiu	$20,$3,%lo(Input_gHandler) # low
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,Cars_gNumHumanRaceCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L663
	move	$19,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	addiu	$21,$2,%lo(Cars_gHumanRaceCarList) # low
	li	$18,1			# 0x00000001
	sll	$3,$19,16
$L674:
	sra	$3,$3,14
	addu	$17,$3,$21
	lw	$2,0($17)
	#nop
	lw	$2,648($2)
	#nop
	sw	$18,28($2)
	sw	$18,32($2)
	sw	$18,24($2)
	lui	$2,%hi(D_8013DAC0) # high
	addiu	$2,$2,%lo(D_8013DAC0) # low
 #APP
 #NO_APP
	addu	$16,$3,$2
	lw	$3,0($16)
	li	$2,79			# 0x0000004f
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$4,0($2)
	jal	InGame_GetDevice__Fi
	bne	$2,$18,$L669
	lw	$2,0($17)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,24($2)
$L669:
	lw	$3,0($16)
	li	$2,81			# 0x00000051
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$4,0($2)
	jal	InGame_GetDevice__Fi
	bne	$2,$18,$L670
	lw	$2,0($17)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,28($2)
$L670:
	lw	$3,0($16)
	li	$2,82			# 0x00000052
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$4,0($2)
	jal	InGame_GetDevice__Fi
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L673
	addu	$2,$19,1
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	lw	$2,648($2)
	#nop
	sw	$0,32($2)
	addu	$2,$19,1
$L673:
	move	$19,$2
	sll	$2,$2,16
	lw	$3,Cars_gNumHumanRaceCars
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	sll	$3,$19,16
	.set	macro
	.set	reorder

$L663:
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

	.end	InGame_SetRamp__Fv
