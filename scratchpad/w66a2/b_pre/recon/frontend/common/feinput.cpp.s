	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\feinput.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	getKeyMappings
	.data
	.align	2
getKeyMappings:
	.word	16
	.word	512
	.word	128
	.word	2048
	.word	32
	.word	4096
	.word	64
	.word	1024
	.word	1024
	.word	32
	.word	256
	.word	64
	.word	2048
	.word	128
	.word	512
	.word	256
	.word	1048576
	.word	512
	.word	8388608
	.word	2048
	.word	2097152
	.word	4096
	.word	4194304
	.word	1024
	.word	268435456
	.word	512
	.word	-2147483648
	.word	2048
	.word	536870912
	.word	4096
	.word	1073741824
	.word	1024
	.text
	.align	2
	.globl	FEInput_VerifyControllerValues__Fi
	.ent	FEInput_VerifyControllerValues__Fi
FEInput_VerifyControllerValues__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(gPadinfo) # high
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$4,5
	addu	$5,$3,$2
	sw	$31,16($sp)
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L600
	lui	$3,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(frontEnd) # low
	sll	$2,$4,1
	addu	$2,$2,$3
	lh	$3,862($2)
	lbu	$2,5($5)
	#nop
	beq	$3,$2,$L600
	.set	noreorder
	.set	nomacro
	jal	Front_ResetPSXController__Fii
	move	$5,$0
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

	.end	FEInput_VerifyControllerValues__Fi
	.align	2
	.globl	FEInput_GetNoDebounceKey__Fii
	.ent	FEInput_GetNoDebounceKey__Fii
FEInput_GetNoDebounceKey__Fii:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	PAD_update
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gPadinfo) # high
	addiu	$19,$2,%lo(gPadinfo) # low
	sll	$18,$20,5
	addu	$17,$18,$19
	lbu	$2,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FEInput_VerifyControllerValues__Fi
	move	$4,$20
	.set	macro
	.set	reorder

	addu	$2,$19,6
	addu	$5,$18,$2
	lbu	$3,5($17)
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L605
	addu	$4,$5,2
	.set	macro
	.set	reorder

	li	$2,83			# 0x00000053
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L604
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

$L605:
	li	$2,4194304			# 0x00400000
	beq	$16,$2,$L612
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	li	$2,268435456			# 0x10000000
	.set	macro
	.set	reorder

	li	$2,1048576			# 0x00100000
	beq	$16,$2,$L611
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,-2147483648			# 0x80000000
	beq	$16,$2,$L613
	.set	noreorder
	.set	nomacro
	j	$L643
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L621:
	beq	$16,$2,$L609
	.set	noreorder
	.set	nomacro
	j	$L643
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L620:
	beq	$16,$2,$L615
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	li	$2,536870912			# 0x20000000
	.set	macro
	.set	reorder

	li	$2,8388608			# 0x00800000
	beq	$16,$2,$L607
	.set	noreorder
	.set	nomacro
	j	$L643
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L622:
	beq	$16,$2,$L614
	li	$2,1073741824			# 0x40000000
	beq	$16,$2,$L616
	.set	noreorder
	.set	nomacro
	j	$L617
	lui	$2,%hi(gPadinfo) # high
	.set	macro
	.set	reorder

$L607:
	lbu	$2,2($5)
	.set	noreorder
	.set	nomacro
	j	$L608
	sltu	$2,$2,64
	.set	macro
	.set	reorder

$L609:
	lbu	$2,2($5)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,193
	.set	macro
	.set	reorder

$L611:
	lbu	$2,1($4)
	.set	noreorder
	.set	nomacro
	j	$L608
	sltu	$2,$2,64
	.set	macro
	.set	reorder

$L612:
	lbu	$2,1($4)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,193
	.set	macro
	.set	reorder

$L613:
	lbu	$2,2($4)
	.set	noreorder
	.set	nomacro
	j	$L608
	sltu	$2,$2,64
	.set	macro
	.set	reorder

$L614:
	lbu	$2,2($4)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,193
	.set	macro
	.set	reorder

$L615:
	lbu	$2,3($4)
	.set	noreorder
	.set	nomacro
	j	$L608
	sltu	$2,$2,64
	.set	macro
	.set	reorder

$L616:
	lbu	$2,3($4)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,193
	.set	macro
	.set	reorder

$L617:
$L643:
	addiu	$2,$2,%lo(gPadinfo) # low
	sll	$3,$20,5
	addu	$3,$3,$2
	lhu	$2,6($3)
	.set	noreorder
	.set	nomacro
	j	$L618
	nor	$2,$0,$2
	.set	macro
	.set	reorder

$L604:
	bne	$3,$2,$L623
	li	$2,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L628
	slt	$2,$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,16384			# 0x00004000
	beq	$16,$2,$L629
	j	$L632
$L635:
	beq	$16,$2,$L625
	li	$2,8388608			# 0x00800000
	beq	$16,$2,$L626
	j	$L632
$L625:
	lbu	$2,8($17)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,161
	.set	macro
	.set	reorder

$L626:
	lbu	$2,8($17)
	#nop
	sltu	$2,$2,98
$L608:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L638
	move	$2,$0
	.set	macro
	.set	reorder

$L628:
	lbu	$2,10($17)
	.set	noreorder
	.set	nomacro
	j	$L610
	sltu	$2,$2,65
	.set	macro
	.set	reorder

$L629:
	lbu	$2,9($17)
	#nop
	sltu	$2,$2,65
$L610:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L638
$L632:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	sll	$4,$20,2
	.set	macro
	.set	reorder

	andi	$2,$2,0xffff
$L618:
	and	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L638
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L638
	move	$2,$0
	.set	macro
	.set	reorder

$L623:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	sll	$4,$20,2
	.set	macro
	.set	reorder

	andi	$3,$2,0xffff
	and	$3,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L638
	move	$2,$0
	.set	macro
	.set	reorder

$L631:
	li	$2,1			# 0x00000001
$L638:
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

	.end	FEInput_GetNoDebounceKey__Fii
	.align	2
	.globl	FEInput_GetDebounceKey__Fii
	.ent	FEInput_GetDebounceKey__Fii
FEInput_GetDebounceKey__Fii:
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
	jal	FEInput_GetNoDebounceKey__Fii
	move	$17,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi(D_80052B60) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(D_80052B60) # low
	sll	$3,$17,2
	addu	$4,$3,$2
	lw	$3,0($4)
	#nop
	and	$2,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(ticks)($2)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L648
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L648
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L648
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L652
	move	$2,$0
	.set	macro
	.set	reorder

$L648:
	lui	$5,%hi(D_80051738) # high
	lw	$2,%lo(D_80051738)($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L654
	slt	$2,$4,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(FeTools_gScrollTicksOut) # high
	lw	$2,%lo(FeTools_gScrollTicksOut)($2)
	#nop
	addu	$2,$4,$2
	addu	$2,$2,10
	sw	$2,%lo(D_80051738)($5)
	lw	$2,%lo(D_80051738)($5)
	#nop
	slt	$2,$4,$2
$L654:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L652
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(FeTools_gScrollTicksOut) # high
	lw	$3,%lo(FeTools_gScrollTicksOut)($2)
	li	$2,1			# 0x00000001
	addu	$3,$4,$3
	.set	noreorder
	.set	nomacro
	j	$L652
	sw	$3,%lo(D_80051738)($5)
	.set	macro
	.set	reorder

$L646:
	li	$2,1			# 0x00000001
	or	$3,$3,$16
	sw	$3,0($4)
	lui	$3,%hi(D_80051738) # high
	.set	noreorder
	.set	nomacro
	j	$L652
	sw	$0,%lo(D_80051738)($3)
	.set	macro
	.set	reorder

$L645:
	move	$2,$0
	lui	$3,%hi(D_80052B60) # high
	addiu	$3,$3,%lo(D_80052B60) # low
	sll	$4,$17,2
	addu	$4,$4,$3
	lw	$3,0($4)
	nor	$5,$0,$16
	and	$3,$3,$5
	sw	$3,0($4)
$L652:
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

	.end	FEInput_GetDebounceKey__Fii
	.align	2
	.globl	FEInput_GetKeyFromPlayer__F7tPlayerl
	.ent	FEInput_GetKeyFromPlayer__F7tPlayerl
FEInput_GetKeyFromPlayer__F7tPlayerl:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(getKeyMappings) # high
	sw	$20,32($sp)
	addiu	$20,$2,%lo(getKeyMappings) # low
	sw	$31,40($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	move	$18,$0
$L673:
	andi	$2,$17,0xffff
	sll	$2,$2,3
	addu	$16,$2,$20
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	bne	$2,$0,$L662
	lw	$2,4($16)
	#nop
	and	$2,$21,$2
	bne	$2,$0,$L661
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetNoDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	beq	$2,$0,$L661
$L662:
	li	$18,1			# 0x00000001
$L661:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L672
	lui	$3,%hi(getKeyMappings) # high
	.set	macro
	.set	reorder

	addu	$17,$17,1
	andi	$2,$17,0xffff
	sltu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	move	$18,$0
	.set	macro
	.set	reorder

	li	$4,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$4,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	li	$4,8192			# 0x00002000
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	li	$4,8			# 0x00000008
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FEInput_GetDebounceKey__Fii
	move	$5,$19
	.set	macro
	.set	reorder

	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$L671
	sll	$2,$2,13
	.set	macro
	.set	reorder

$L672:
	addiu	$3,$3,%lo(getKeyMappings) # low
	andi	$2,$17,0xffff
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$2,4($2)
	j	$L671
$L667:
	li	$2,8			# 0x00000008
$L671:
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

	.end	FEInput_GetKeyFromPlayer__F7tPlayerl
