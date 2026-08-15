	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\input.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Input_StartUp__Fv
	.align	2
	.globl	Input_WingCommandMode__Fi
	.align	2
	.globl	Input_Update__Fv
	.align	2
	.globl	Input_Store__Fv
	.align	2
	.globl	Input_Fetch__Fi
	.align	2
	.globl	Input_Gear__Fci
	.align	2
	.globl	Input_Interface__FUli
	.align	2
	.globl	Input_MainExitKey__Fv
	.globl	Input_gHandler
	.data
	.align	2
Input_gHandler:
	.space	736
	.globl	Input_gDBFlags
	.align	2
Input_gDBFlags:
	.space	32
	.globl	Input_gInterfaceResults
	.align	2
Input_gInterfaceResults:
	.space	128
	.globl	Input_gPressTime
	.align	2
Input_gPressTime:
	.space	136
	.globl	Input_gTime
	.sdata
	.align	2
Input_gTime:
	.space	4
	.globl	Input_gResults
	.align	2
Input_gResults:
	.space	8
	.globl	Input_gSim
	.align	2
Input_gSim:
	.space	4
	.globl	Input_gLookBehind
	.align	2
Input_gLookBehind:
	.space	8
	.globl	Input_gMode
	.align	2
Input_gMode:
	.space	8

	.extern	simGlobal, 24
	.extern	gSimQueue_BlockSelf, 4
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	Input_StartUp__Fv
Input_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Device_StartUp__Fv
	lui	$2,%hi(Input_gHandler) # high
	addiu	$2,$2,%lo(Input_gHandler) # low
	li	$5,183			# 0x000000b7
$L601:
	sw	$0,0($2)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L601
	addu	$2,$2,4
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$2,%hi(Input_gPressTime) # high
	addiu	$9,$2,%lo(Input_gPressTime) # low
	move	$8,$5
	la	$7,Input_gMode
	lui	$2,%hi(Input_gDBFlags) # high
	addiu	$6,$2,%lo(Input_gDBFlags) # low
$L605:
	slt	$2,$5,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	move	$4,$0
	.set	macro
	.set	reorder

	move	$3,$8
	sw	$0,0($6)
	sw	$0,0($7)
$L612:
	addu	$2,$3,$9
	sw	$0,0($2)
	addu	$4,$4,1
	slt	$2,$4,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$3,$3,4
	.set	macro
	.set	reorder

	addu	$8,$8,68
	addu	$7,$7,4
	addu	$6,$6,4
	.set	noreorder
	.set	nomacro
	j	$L605
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L606:
	li	$5,31			# 0x0000001f
	lui	$2,%hi(Input_gInterfaceResults) # high
	addiu	$2,$2,%lo(Input_gInterfaceResults) # low
	addu	$2,$2,124
$L614:
	sw	$0,0($2)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L614
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lui	$2,%hi(Input_gHandler) # high
	lw	$31,16($sp)
	addiu	$2,$2,%lo(Input_gHandler) # low
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Input_StartUp__Fv
	.text
	.ent	Input_WingCommandMode__Fi
Input_WingCommandMode__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(Input_gHandler+180) # high
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L619
	addiu	$3,$2,%lo(Input_gHandler+180) # low
	.set	macro
	.set	reorder

	addu	$3,$3,304
$L619:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	andi	$2,$4,0x0001
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	andi	$2,$4,0x0001
	.set	macro
	.set	reorder

	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	andi	$2,$4,0x0001
	.set	macro
	.set	reorder

$L630:
	sll	$2,$2,2
	la	$3,Input_gMode
	addu	$2,$2,$3
	lw	$3,0($2)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L626
$L624:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L626:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	Input_WingCommandMode__Fi
	.text
	.ent	Input_Update__Fv
Input_Update__Fv:
	.frame	$sp,184,$31		# vars= 128, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$31,180($sp)
	sw	$fp,176($sp)
	sw	$23,172($sp)
	sw	$22,168($sp)
	sw	$21,164($sp)
	sw	$20,160($sp)
	sw	$19,156($sp)
	sw	$18,152($sp)
	sw	$17,148($sp)
	.set	noreorder
	.set	nomacro
	jal	Device_Update__Fv
	sw	$16,144($sp)
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	li	$fp,31			# 0x0000001f
	addu	$2,$sp,47
$L632:
	sb	$3,0($2)
	addu	$fp,$fp,-1
	.set	noreorder
	.set	nomacro
	bgez	$fp,$L632
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lui	$2,%hi(Input_gHandler) # high
	addiu	$18,$2,%lo(Input_gHandler) # low
	la	$11,Input_gResults
	move	$fp,$0
	li	$22,1			# 0x00000001
	sw	$11,112($sp)
	addu	$11,$sp,48
	lui	$2,%hi(Input_gDBFlags) # high
	addiu	$2,$2,%lo(Input_gDBFlags) # low
	la	$20,Input_gResults+3
	sw	$0,116($sp)
	sw	$11,120($sp)
	sw	$2,124($sp)
	sw	$0,128($sp)
	sw	$0,132($sp)
$L636:
	slt	$2,$fp,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
	move	$23,$0
	.set	macro
	.set	reorder

	move	$16,$23
$L643:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L644
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	bne	$2,$0,$L644
	addu	$23,$16,1
$L644:
	addu	$16,$16,1
	slt	$2,$16,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	addu	$18,$18,4
	.set	macro
	.set	reorder

	lw	$11,128($sp)
	la	$2,Input_gMode
	addu	$2,$11,$2
	.set	noreorder
	.set	nomacro
	bne	$23,$0,$L646
	sw	$23,0($2)
	.set	macro
	.set	reorder

	lw	$4,0($18)
	addu	$18,$18,4
	move	$16,$0
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	move	$17,$2
	lw	$4,0($18)
	addu	$18,$18,4
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	subu	$2,$2,$17
	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$11,112($sp)
	sra	$2,$2,1
	sb	$2,0($11)
	lw	$4,0($18)
	addu	$18,$18,4
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	sb	$2,-2($20)
	lw	$4,0($18)
	addu	$18,$18,4
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	sb	$2,-1($20)
$L650:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L651
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L802
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lbu	$2,0($20)
	sll	$3,$22,$16
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L652
	sb	$2,0($20)
	.set	macro
	.set	reorder

$L651:
	sll	$2,$22,$16
$L802:
	lbu	$3,0($20)
	nor	$2,$0,$2
	and	$3,$3,$2
	sb	$3,0($20)
$L652:
	addu	$16,$16,1
	slt	$2,$16,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L650
	addu	$18,$18,4
	.set	macro
	.set	reorder

	move	$21,$0
	li	$4,16			# 0x00000010
	lw	$11,120($sp)
	lbu	$2,0($20)
	addu	$3,$11,$4
	andi	$2,$2,0x0007
	sb	$2,0($20)
$L657:
	sb	$22,0($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L657
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	move	$16,$0
	lw	$23,132($sp)
	lw	$19,124($sp)
	move	$17,$23
$L661:
	slt	$2,$16,17
	beq	$2,$0,$L660
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L663
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L664
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$3,$17,$11
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	slt	$2,$2,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L803
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$4,0($19)
	sll	$3,$22,$16
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	sw	$2,0($19)
$L665:
	move	$4,$0
$L803:
	addu	$7,$16,-17
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$6,$17,$11
	move	$5,$23
$L670:
	subu	$2,$4,$7
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$3,0($2)
	lw	$2,0($18)
	#nop
	bne	$3,$2,$L669
	lw	$11,120($sp)
	#nop
	addu	$2,$11,$4
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	sb	$0,0($2)
	lw	$3,0($6)
	addu	$2,$5,$11
	sw	$3,0($2)
$L669:
	addu	$4,$4,1
	slt	$2,$4,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	addu	$5,$5,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L799
	addu	$18,$18,4
	.set	macro
	.set	reorder

$L664:
	nor	$2,$0,$2
	lui	$11,%hi(Input_gPressTime) # high
	lw	$3,0($19)
	addiu	$11,$11,%lo(Input_gPressTime) # low
	and	$3,$3,$2
	addu	$2,$17,$11
	sw	$3,0($19)
	sw	$0,0($2)
$L663:
	addu	$18,$18,4
$L799:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L661
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L660:
	move	$16,$0
	lw	$17,124($sp)
$L678:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L679
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L680
	sll	$2,$16,2
	.set	macro
	.set	reorder

	lw	$11,120($sp)
	#nop
	addu	$2,$11,$16
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	sll	$3,$22,$16
	.set	macro
	.set	reorder

	lw	$4,0($17)
	#nop
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L679
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	.set	noreorder
	.set	nomacro
	j	$L679
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L680:
	lw	$11,132($sp)
	#nop
	addu	$2,$2,$11
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$5,$2,$11
	lw	$2,0($5)
	#nop
	addu	$2,$2,-1
	sltu	$2,$2,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L683
	sll	$3,$22,$16
	.set	macro
	.set	reorder

	lw	$4,0($17)
	#nop
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L684
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	sw	$2,0($17)
$L684:
	.set	noreorder
	.set	nomacro
	j	$L679
	sw	$0,0($5)
	.set	macro
	.set	reorder

$L683:
	sll	$2,$22,$16
	lw	$3,0($17)
	nor	$2,$0,$2
	and	$3,$3,$2
	sw	$3,0($17)
$L679:
	addu	$16,$16,1
	slt	$2,$16,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L678
	addu	$18,$18,4
	.set	macro
	.set	reorder

	move	$19,$0
	lw	$17,124($sp)
	move	$16,$0
$L694:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L695
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lw	$3,0($17)
	.set	noreorder
	.set	nomacro
	j	$L796
	or	$3,$3,$2
	.set	macro
	.set	reorder

$L696:
	lw	$3,0($17)
	nor	$2,$0,$2
	and	$3,$3,$2
$L796:
	sw	$3,0($17)
$L695:
	addu	$16,$16,1
	slt	$2,$16,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L694
	addu	$18,$18,4
	.set	macro
	.set	reorder

	addu	$19,$19,1
	slt	$2,$19,2
	beq	$2,$0,$L700
	.set	noreorder
	.set	nomacro
	j	$L694
	move	$16,$0
	.set	macro
	.set	reorder

$L646:
	li	$16,39			# 0x00000027
	addu	$2,$sp,111
$L704:
	sb	$22,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L704
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	move	$16,$0
	sll	$2,$23,4
	addu	$8,$2,$23
	addu	$9,$sp,72
	move	$5,$18
$L709:
	move	$4,$0
	move	$7,$5
	addu	$6,$9,$16
	addu	$2,$8,$4
$L804:
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$3,0($7)
	lw	$2,92($2)
	#nop
	bne	$3,$2,$L712
	sb	$0,0($6)
$L712:
	addu	$4,$4,1
	slt	$2,$4,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L804
	addu	$2,$8,$4
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,40
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	addu	$5,$5,4
	.set	macro
	.set	reorder

	move	$16,$0
	lui	$2,%hi(Input_gHandler) # high
	addiu	$10,$2,%lo(Input_gHandler) # low
	sll	$2,$23,4
	addu	$8,$2,$23
	addu	$9,$sp,16
	li	$5,608			# 0x00000260
$L720:
	move	$4,$0
	addu	$7,$5,$10
	addu	$6,$9,$16
	addu	$2,$8,$4
$L805:
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$3,0($7)
	lw	$2,92($2)
	#nop
	bne	$3,$2,$L723
	sb	$0,0($6)
$L723:
	addu	$4,$4,1
	slt	$2,$4,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L805
	addu	$2,$8,$4
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	addu	$5,$5,4
	.set	macro
	.set	reorder

	lw	$4,0($18)
	addu	$18,$18,4
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	move	$17,$2
	lw	$4,0($18)
	addu	$18,$18,4
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	lbu	$3,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L728
	move	$4,$2
	.set	macro
	.set	reorder

	lbu	$2,73($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	subu	$2,$4,$17
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$2,$2,$3
	lw	$11,112($sp)
	sra	$2,$2,1
	sb	$2,0($11)
$L728:
	lbu	$2,74($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L729
	lui	$11,%hi(Device_gDeviceList) # high
	.set	macro
	.set	reorder

	lw	$4,0($18)
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	sb	$2,-2($20)
$L729:
	lbu	$2,75($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L730
	addu	$18,$18,4
	.set	macro
	.set	reorder

	lui	$11,%hi(Device_gDeviceList) # high
	lw	$4,0($18)
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	andi	$3,$4,0x00ff
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	sb	$2,-1($20)
$L730:
	addu	$18,$18,4
	move	$16,$0
$L734:
	addu	$2,$16,$sp
	lbu	$2,76($2)
	#nop
	beq	$2,$0,$L735
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L736
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L806
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lbu	$2,0($20)
	sll	$3,$22,$16
	or	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L735
	sb	$2,0($20)
	.set	macro
	.set	reorder

$L736:
	sll	$2,$22,$16
$L806:
	lbu	$3,0($20)
	nor	$2,$0,$2
	and	$3,$3,$2
	sb	$3,0($20)
$L735:
	addu	$16,$16,1
	slt	$2,$16,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L734
	addu	$18,$18,4
	.set	macro
	.set	reorder

	move	$21,$0
	li	$4,16			# 0x00000010
	lw	$11,120($sp)
	lbu	$2,0($20)
	addu	$3,$11,$4
	andi	$2,$2,0x0007
	sb	$2,0($20)
$L742:
	sb	$22,0($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L742
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	move	$16,$0
	lw	$8,132($sp)
	lw	$19,124($sp)
	move	$17,$8
$L744:
	slt	$2,$16,17
	beq	$2,$0,$L748
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L749
	addu	$2,$16,$sp
	.set	macro
	.set	reorder

	lbu	$2,78($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	sra	$4,$4,8
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sw	$8,136($sp)
	.set	macro
	.set	reorder

	slt	$2,$2,65
	lw	$8,136($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L807
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$3,$17,$11
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
	slt	$2,$2,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L808
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$4,0($19)
	sll	$3,$22,$16
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L751
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	sw	$2,0($19)
$L751:
	move	$4,$0
$L808:
	addu	$7,$16,-17
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$6,$17,$11
	move	$5,$8
$L756:
	subu	$2,$4,$7
	sll	$2,$2,2
	addu	$2,$2,$18
	lw	$3,0($2)
	lw	$2,0($18)
	#nop
	bne	$3,$2,$L755
	lw	$11,120($sp)
	#nop
	addu	$2,$11,$4
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	sb	$0,0($2)
	lw	$3,0($6)
	addu	$2,$5,$11
	sw	$3,0($2)
$L755:
	addu	$4,$4,1
	slt	$2,$4,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L756
	addu	$5,$5,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L800
	addu	$18,$18,4
	.set	macro
	.set	reorder

$L750:
	sll	$2,$22,$16
$L807:
	nor	$2,$0,$2
	lui	$11,%hi(Input_gPressTime) # high
	lw	$3,0($19)
	addiu	$11,$11,%lo(Input_gPressTime) # low
	and	$3,$3,$2
	addu	$2,$17,$11
	sw	$3,0($19)
	sw	$0,0($2)
$L749:
	addu	$18,$18,4
$L800:
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L744
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L748:
	move	$16,$0
	lw	$19,124($sp)
$L763:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L764
	addu	$2,$16,$sp
	.set	macro
	.set	reorder

	addu	$17,$2,95
	lbu	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L765
	sll	$3,$22,$16
	.set	macro
	.set	reorder

	lw	$4,0($19)
	#nop
	and	$2,$4,$3
	bne	$2,$0,$L764
	lw	$11,120($sp)
	#nop
	addu	$2,$11,$16
	lbu	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L764
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	.set	noreorder
	.set	nomacro
	j	$L764
	sw	$2,0($19)
	.set	macro
	.set	reorder

$L765:
	lbu	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	sll	$2,$16,2
	.set	macro
	.set	reorder

	lw	$11,132($sp)
	#nop
	addu	$2,$2,$11
	lui	$11,%hi(Input_gPressTime) # high
	addiu	$11,$11,%lo(Input_gPressTime) # low
	addu	$5,$2,$11
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L768
	slt	$2,$2,6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	sll	$3,$22,$16
	.set	macro
	.set	reorder

	lw	$4,0($19)
	#nop
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L769
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	sw	$2,0($19)
$L769:
	.set	noreorder
	.set	nomacro
	j	$L764
	sw	$0,0($5)
	.set	macro
	.set	reorder

$L768:
	sll	$2,$22,$16
	lw	$3,0($19)
	nor	$2,$0,$2
	and	$3,$3,$2
	sw	$3,0($19)
$L764:
	addu	$16,$16,1
	slt	$2,$16,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L763
	addu	$18,$18,4
	.set	macro
	.set	reorder

	addu	$3,$23,-1
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$18,$18,$2
	move	$16,$0
	lw	$17,124($sp)
$L775:
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L776
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L777
	sll	$2,$22,$16
	.set	macro
	.set	reorder

	lw	$4,0($17)
	sll	$3,$22,$16
	and	$2,$4,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L776
	or	$2,$4,$3
	.set	macro
	.set	reorder

	addu	$21,$16,1
	.set	noreorder
	.set	nomacro
	j	$L776
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L777:
	lw	$3,0($17)
	nor	$2,$0,$2
	and	$3,$3,$2
	sw	$3,0($17)
$L776:
	addu	$16,$16,1
	slt	$2,$16,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L775
	addu	$18,$18,4
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
	subu	$3,$3,$23
	sll	$2,$3,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$18,$18,$2
$L700:
	lbu	$2,0($20)
	sll	$3,$21,3
	or	$2,$2,$3
	sb	$2,0($20)
 #APP
 #NO_APP
	lbu	$4,0($20)
	li	$2,16			# 0x00000010
	srl	$3,$4,3
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L783
	andi	$2,$4,0x0007
	.set	macro
	.set	reorder

	slt	$2,$3,17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L787
	li	$2,15			# 0x0000000f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L782
	andi	$2,$4,0x0007
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L801
	addu	$20,$20,4
	.set	macro
	.set	reorder

$L787:
	li	$2,17			# 0x00000011
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L784
	andi	$2,$4,0x0007
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L801
	addu	$20,$20,4
	.set	macro
	.set	reorder

$L782:
	sb	$2,0($20)
	lw	$11,116($sp)
	.set	noreorder
	.set	nomacro
	j	$L797
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

$L783:
	sb	$2,0($20)
	.set	noreorder
	.set	nomacro
	j	$L798
	addu	$2,$fp,26
	.set	macro
	.set	reorder

$L784:
	sb	$2,0($20)
	addu	$2,$fp,28
$L798:
	lw	$11,116($sp)
	sll	$2,$22,$2
$L797:
	or	$11,$11,$2
	sw	$11,116($sp)
	addu	$20,$20,4
$L801:
	lui	$2,%hi(GameSetup_gData+968) # high
	lw	$11,112($sp)
	lw	$2,%lo(GameSetup_gData+968)($2)
	addu	$11,$11,4
	.set	noreorder
	.set	nomacro
	bne	$2,$22,$L638
	sw	$11,112($sp)
	.set	macro
	.set	reorder

	lw	$11,124($sp)
	#nop
	addu	$11,$11,4
	sw	$11,124($sp)
	lw	$11,128($sp)
	addu	$18,$18,304
	addu	$11,$11,4
	sw	$11,128($sp)
	lw	$11,132($sp)
	addu	$fp,$fp,1
	addu	$11,$11,68
	sw	$11,132($sp)
$L638:
	lw	$11,124($sp)
	#nop
	addu	$11,$11,4
	sw	$11,124($sp)
	lw	$11,128($sp)
	#nop
	addu	$11,$11,4
	sw	$11,128($sp)
	lw	$11,132($sp)
	addu	$fp,$fp,1
	addu	$11,$11,68
	.set	noreorder
	.set	nomacro
	j	$L636
	sw	$11,132($sp)
	.set	macro
	.set	reorder

$L637:
	move	$fp,$0
	addu	$16,$sp,16
 #APP
 #NO_APP
	li	$17,1			# 0x00000001
 #APP
 #NO_APP
$L792:
	addu	$2,$16,$fp
	lbu	$2,0($2)
	#nop
	beq	$2,$0,$L793
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L793
	andi	$3,$4,0x00ff
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$11,%hi(Device_gDeviceList) # high
	addiu	$11,$11,%lo(Device_gDeviceList) # low
	addu	$2,$2,$11
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	sra	$4,$4,8
	.set	macro
	.set	reorder

	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L793
	sll	$2,$17,$fp
	.set	macro
	.set	reorder

	lw	$11,116($sp)
	#nop
	or	$11,$11,$2
	sw	$11,116($sp)
$L793:
	addu	$fp,$fp,1
	slt	$2,$fp,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L792
	addu	$18,$18,4
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lui	$4,%hi(Input_gInterfaceResults) # high
	addiu	$4,$4,%lo(Input_gInterfaceResults) # low
	lw	$2,Input_gTime
	lw	$11,116($sp)
	addu	$3,$2,2
	sw	$3,Input_gTime
	andi	$3,$3,0x001f
	sll	$3,$3,2
	addu	$3,$3,$4
	addu	$2,$2,3
	andi	$2,$2,0x001f
	sll	$2,$2,2
	addu	$2,$2,$4
	sw	$11,0($3)
	sw	$11,0($2)
	lw	$31,180($sp)
	lw	$fp,176($sp)
	lw	$23,172($sp)
	lw	$22,168($sp)
	lw	$21,164($sp)
	lw	$20,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	Input_Update__Fv
	.text
	.ent	Input_Store__Fv
Input_Store__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,gSimQueue_BlockSelf
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L809
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData) # high
	addiu	$3,$2,%lo(GameSetup_gData) # low
	lw	$2,968($3)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L811
	la	$5,Input_gResults
	.set	noreorder
	.set	nomacro
	jal	SimQueue_Put__FiP14Input_tResults
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L809
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	la	$5,Input_gResults+4
	j	$L816
$L811:
	lw	$2,12($3)
	#nop
	bne	$2,$0,$L809
	lw	$4,28($3)
	la	$5,Input_gResults
$L816:
	jal	SimQueue_Put__FiP14Input_tResults
$L809:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Input_Store__Fv
	.text
	.ent	Input_Fetch__Fi
Input_Fetch__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	la	$5,Input_gSim
	sw	$31,16($sp)
	jal	SimQueue_GetCurrentInput__FiP14Input_tResults
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Input_Fetch__Fi
	.text
	.ent	Input_Gear__Fci
Input_Gear__Fci:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,Input_gSim+3
	#nop
	srl	$7,$2,3
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$7,$2,$L820
	move	$6,$4
	.set	macro
	.set	reorder

	andi	$2,$6,0x00ff
	addu	$3,$5,-1
	slt	$2,$2,$3
	beq	$2,$0,$L821
	addu	$6,$4,1
$L821:
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$6,0x00ff
	.set	macro
	.set	reorder

$L820:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$7,$2,$L826
	andi	$2,$6,0x00ff
	.set	macro
	.set	reorder

	beq	$2,$0,$L821
	.set	noreorder
	.set	nomacro
	j	$L821
	addu	$6,$4,-1
	.set	macro
	.set	reorder

$L826:
	j	$31
	.end	Input_Gear__Fci
	.text
	.ent	Input_Interface__FUli
Input_Interface__FUli:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L829
	move	$6,$4
	.set	macro
	.set	reorder

	lui	$5,%hi(Input_gInterfaceResults) # high
	lui	$2,%hi(simGlobal+8) # high
	addiu	$5,$5,%lo(Input_gInterfaceResults) # low
	li	$4,1			# 0x00000001
	lw	$2,%lo(simGlobal+8)($2)
	sll	$4,$4,$6
	andi	$3,$2,0x001f
	sll	$3,$3,2
	addu	$3,$3,$5
	addu	$2,$2,-1
	andi	$2,$2,0x001f
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,0($3)
	lw	$2,0($2)
	and	$3,$3,$4
	nor	$2,$0,$2
	and	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L835
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L829:
	li	$2,1			# 0x00000001
	lui	$4,%hi(Input_gInterfaceResults) # high
	lui	$3,%hi(simGlobal+8) # high
	lw	$3,%lo(simGlobal+8)($3)
	addiu	$4,$4,%lo(Input_gInterfaceResults) # low
	andi	$3,$3,0x001f
	sll	$3,$3,2
	addu	$3,$3,$4
	move	$4,$2
	lw	$3,0($3)
	sll	$4,$4,$6
	and	$3,$3,$4
	bne	$3,$0,$L835
	move	$2,$0
$L835:
	j	$31
	.end	Input_Interface__FUli
	.text
	.ent	Input_MainExitKey__Fv
Input_MainExitKey__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(Input_gInterfaceResults) # high
	lui	$2,%hi(simGlobal+8) # high
	lw	$2,%lo(simGlobal+8)($2)
	addiu	$3,$3,%lo(Input_gInterfaceResults) # low
	andi	$2,$2,0x001f
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	andi	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	Input_MainExitKey__Fv
