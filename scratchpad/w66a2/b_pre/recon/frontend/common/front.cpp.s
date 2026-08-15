	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\front.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	regularCopModels
	.data
	.align	2
regularCopModels:
	.word	24
	.word	24
	.word	24
	.word	23
	.word	22
	.word	24
	.word	24
	.word	24
	.word	23
	.word	22
	.word	24
	.word	24
	.word	24
	.word	24
	.word	22
	.word	24
	.word	24
	.word	24
	.word	24
	.word	25
	.word	26
	.word	26
	.word	26
	.word	24
	.word	25
	.word	26
	.word	26
	.word	26
	.word	24
	.word	25
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.globl	superCopModels
	.align	2
superCopModels:
	.word	26
	.word	26
	.word	26
	.word	24
	.word	25
	.word	26
	.word	26
	.word	26
	.word	24
	.word	25
	.word	26
	.word	26
	.word	26
	.word	24
	.word	25
	.word	26
	.word	26
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
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.word	27
	.text
	.align	2
	.globl	Front_ConstructAll__Fv
	.ent	Front_ConstructAll__Fv
Front_ConstructAll__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,15320			# 0x00003bd8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__11tAllScreens
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,896			# 0x00000380
	lui	$3,%hi(gAllScreens) # high
	sw	$2,%lo(gAllScreens)($3)
	lui	$3,%hi(screenMain) # high
	lui	$5,%hi(screenCarSelect) # high
	sw	$2,%lo(screenMain)($3)
	addu	$3,$2,1464
	sw	$3,%lo(screenCarSelect)($5)
	lui	$5,%hi(screenCarSelectDuel) # high
	addu	$3,$2,2392
	sw	$3,%lo(screenCarSelectDuel)($5)
	lui	$5,%hi(screenCarSelectTwoPlayer) # high
	addu	$3,$2,3368
	sw	$3,%lo(screenCarSelectTwoPlayer)($5)
	lui	$5,%hi(screenCarSelectPlayerTwo) # high
	addu	$3,$2,4448
	sw	$3,%lo(screenCarSelectPlayerTwo)($5)
	lui	$5,%hi(screenPinkSlipsCarSelectTwoPlayer) # high
	addu	$3,$2,5528
	sw	$3,%lo(screenPinkSlipsCarSelectTwoPlayer)($5)
	lui	$5,%hi(screenPinkSlipsCarSelectPlayerTwo) # high
	addu	$3,$2,6628
	sw	$3,%lo(screenPinkSlipsCarSelectPlayerTwo)($5)
	lui	$5,%hi(screenTrackRecords) # high
	addu	$3,$2,7728
	sw	$3,%lo(screenTrackRecords)($5)
	lui	$5,%hi(screenTrackInfo) # high
	addu	$3,$2,7844
	sw	$3,%lo(screenTrackInfo)($5)
	lui	$5,%hi(screenTrackSelect) # high
	addu	$3,$2,8520
	sw	$3,%lo(screenTrackSelect)($5)
	lui	$5,%hi(screenTournSelect) # high
	addu	$3,$2,9192
	sw	$3,%lo(screenTournSelect)($5)
	lui	$5,%hi(screenTournamentStandings) # high
	addu	$3,$2,9904
	sw	$3,%lo(screenTournamentStandings)($5)
	lui	$5,%hi(screenTournamentTrophy) # high
	addu	$3,$2,10052
	sw	$3,%lo(screenTournamentTrophy)($5)
	lui	$5,%hi(screenTrophyRoom) # high
	addu	$3,$2,10444
	sw	$3,%lo(screenTrophyRoom)($5)
	lui	$5,%hi(screenTrophyInfo) # high
	addu	$3,$2,10788
	sw	$3,%lo(screenTrophyInfo)($5)
	lui	$5,%hi(screenControllerConfig) # high
	addu	$3,$2,10892
	sw	$3,%lo(screenControllerConfig)($5)
	lui	$5,%hi(screenDisplay) # high
	addu	$3,$2,11272
	sw	$3,%lo(screenDisplay)($5)
	lui	$5,%hi(screenAudio) # high
	addu	$3,$2,11372
	sw	$3,%lo(screenAudio)($5)
	lui	$5,%hi(screenMemcard) # high
	addu	$3,$2,11496
	sw	$3,%lo(screenMemcard)($5)
	lui	$5,%hi(screenUserName) # high
	addu	$3,$2,12940
	sw	$3,%lo(screenUserName)($5)
	lui	$5,%hi(screenPinkSlipCongrats) # high
	addu	$3,$2,13144
	sw	$3,%lo(screenPinkSlipCongrats)($5)
	lui	$5,%hi(screenPinkSlipStandings) # high
	addu	$3,$2,13536
	sw	$3,%lo(screenPinkSlipStandings)($5)
	lui	$5,%hi(screenTournamentStandings3item) # high
	addu	$3,$2,13684
	sw	$3,%lo(screenTournamentStandings3item)($5)
	lui	$5,%hi(screenPinkSlips) # high
	addu	$3,$2,13832
	sw	$3,%lo(screenPinkSlips)($5)
	lui	$5,%hi(screenBeTheCopCongrats) # high
	addu	$3,$2,14544
	sw	$3,%lo(screenBeTheCopCongrats)($5)
	lui	$3,%hi(screenTournamentCongrats) # high
	addu	$2,$2,14932
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,%lo(screenTournamentCongrats)($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__14tFEApplication
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,15128			# 0x00003b18
	lui	$3,%hi(FEApp) # high
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,%lo(FEApp)($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__15tGlobalMenuDefs
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	lui	$3,%hi(menuDefs) # high
	sw	$2,%lo(menuDefs)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Front_ConstructAll__Fv
	.align	2
	.globl	Front_DeleteAll__Fv
	.ent	Front_DeleteAll__Fv
Front_DeleteAll__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(gAllScreens) # high
	lw	$4,%lo(gAllScreens)($2)
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L602
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	___11tAllScreens
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L602:
	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L605
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	___14tFEApplication
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
$L605:
	lw	$4,%lo(menuDefs)($2)
	#nop
	beq	$4,$0,$L601
	.set	noreorder
	.set	nomacro
	jal	___15tGlobalMenuDefs
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

$L601:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Front_DeleteAll__Fv
	.align	2
	.globl	Front_ResetSettingsForCar__Fii
	.ent	Front_ResetSettingsForCar__Fii
Front_ResetSettingsForCar__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$7,%hi(frontEnd) # high
	addiu	$7,$7,%lo(frontEnd) # low
	sll	$6,$4,1
	addu	$8,$6,$7
	li	$2,1			# 0x00000001
	sll	$2,$2,$5
	nor	$2,$0,$2
	addu	$6,$6,$4
	sll	$6,$6,4
	addu	$5,$5,$6
	lhu	$3,304($8)
	addu	$5,$5,$7
	and	$3,$3,$2
	li	$2,50			# 0x00000032
	sh	$3,304($8)
	sb	$2,596($5)
	sb	$2,500($5)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,692($5)
	.set	macro
	.set	reorder

	.end	Front_ResetSettingsForCar__Fii
	.align	2
	.globl	Front_ResetSettingsMenu__Fi
	.ent	Front_ResetSettingsMenu__Fi
Front_ResetSettingsMenu__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	move	$4,$17
$L612:
	.set	noreorder
	.set	nomacro
	jal	Front_ResetSettingsForCar__Fii
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,48
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	move	$4,$17
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

	.end	Front_ResetSettingsMenu__Fi
	.align	2
	.globl	Front_ResetPSXController__Fii
	.ent	Front_ResetPSXController__Fii
Front_ResetPSXController__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	timedwait
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

	jal	PAD_update
	lui	$5,%hi(frontEnd) # high
	addiu	$5,$5,%lo(frontEnd) # low
	sll	$4,$16,1
	lui	$3,%hi(gPadinfo) # high
	addiu	$3,$3,%lo(gPadinfo) # low
	sll	$2,$16,5
	addu	$2,$2,$3
	addu	$4,$4,$5
	lbu	$2,5($2)
	addu	$16,$16,$5
	sh	$2,862($4)
	sb	$17,866($16)
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

	.end	Front_ResetPSXController__Fii
	.align	2
	.globl	Front_ResetPSXAnalogs__Fi
	.ent	Front_ResetPSXAnalogs__Fi
Front_ResetPSXAnalogs__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$4,$4,$2
	li	$2,121			# 0x00000079
	sb	$2,841($4)
	li	$2,10			# 0x0000000a
	sb	$2,843($4)
	li	$2,255			# 0x000000ff
	li	$3,127			# 0x0000007f
	sb	$2,845($4)
	sb	$2,847($4)
	li	$2,6			# 0x00000006
	sb	$3,849($4)
	sb	$2,851($4)
	sb	$3,853($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,855($4)
	.set	macro
	.set	reorder

	.end	Front_ResetPSXAnalogs__Fi
	.align	2
	.globl	GetPSXPadValue__Fii
	.ent	GetPSXPadValue__Fii
GetPSXPadValue__Fii:
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
	bne	$2,$0,$L617
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	lbu	$3,5($3)
 #APP
	
 #NO_APP
	j	$L657
$L617:
	move	$3,$0
$L657:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L621
	slt	$2,$3,84
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L648
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L636
	sll	$2,$17,26
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L659
	sll	$3,$16,8
	.set	macro
	.set	reorder

$L648:
	li	$2,115			# 0x00000073
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L621:
	li	$2,4194304			# 0x00400000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L626
	lui	$4,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L633
	li	$2,268435456			# 0x10000000
	.set	macro
	.set	reorder

	li	$2,1048576			# 0x00100000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L625
	addiu	$4,$4,%lo(frontEnd) # low
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,-2147483648			# 0x80000000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L627
	sll	$6,$17,30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L634:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L624
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L633:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L629
	sll	$6,$17,30
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	li	$2,536870912			# 0x20000000
	.set	macro
	.set	reorder

	li	$2,8388608			# 0x00800000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L623
	sll	$5,$17,30
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L635:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L628
	lui	$4,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	li	$2,1073741824			# 0x40000000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L630
	addiu	$4,$4,%lo(frontEnd) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L623:
	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$3,$17,$3
	lbu	$2,851($3)
	lbu	$3,853($3)
	.set	noreorder
	.set	nomacro
	j	$L650
	li	$4,127			# 0x0000007f
	.set	macro
	.set	reorder

$L624:
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$17,$2
	sll	$4,$17,30
	lbu	$3,851($2)
	lbu	$2,849($2)
	addu	$3,$3,128
	sll	$3,$3,16
	or	$4,$4,$3
	addu	$2,$2,128
	.set	noreorder
	.set	nomacro
	j	$L651
	sll	$2,$2,8
	.set	macro
	.set	reorder

$L625:
	addu	$4,$17,$4
	li	$5,127			# 0x0000007f
	lbu	$2,851($4)
	li	$3,16777216			# 0x01000000
	subu	$2,$5,$2
	sll	$2,$2,16
	or	$2,$2,$3
	lbu	$3,849($4)
	.set	noreorder
	.set	nomacro
	j	$L652
	sll	$6,$17,30
	.set	macro
	.set	reorder

$L626:
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$4,$17,$4
	lbu	$2,851($4)
	li	$3,16777216			# 0x01000000
	addu	$2,$2,128
	sll	$2,$2,16
	or	$2,$2,$3
	lbu	$3,849($4)
	.set	noreorder
	.set	nomacro
	j	$L653
	sll	$5,$17,30
	.set	macro
	.set	reorder

$L627:
	lui	$4,%hi(frontEnd) # high
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$4,$17,$4
	li	$5,127			# 0x0000007f
	lbu	$2,855($4)
	.set	noreorder
	.set	nomacro
	j	$L654
	li	$3,33554432			# 0x02000000
	.set	macro
	.set	reorder

$L628:
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$4,$17,$4
	sll	$5,$17,30
	lbu	$2,855($4)
	.set	noreorder
	.set	nomacro
	j	$L655
	li	$3,33554432			# 0x02000000
	.set	macro
	.set	reorder

$L629:
	lui	$4,%hi(frontEnd) # high
	addiu	$4,$4,%lo(frontEnd) # low
	addu	$4,$17,$4
	li	$5,127			# 0x0000007f
	lbu	$2,855($4)
	li	$3,50331648			# 0x03000000
$L654:
	subu	$2,$5,$2
	sll	$2,$2,16
	or	$2,$2,$3
	lbu	$3,853($4)
$L652:
	or	$6,$6,$2
	subu	$5,$5,$3
	sll	$5,$5,8
	or	$4,$6,$5
	.set	noreorder
	.set	nomacro
	j	$L649
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L630:
	addu	$4,$17,$4
	sll	$5,$17,30
	lbu	$2,855($4)
	li	$3,50331648			# 0x03000000
$L655:
	addu	$2,$2,128
	sll	$2,$2,16
	or	$2,$2,$3
	lbu	$3,853($4)
$L653:
	or	$5,$5,$2
	addu	$3,$3,128
	sll	$3,$3,8
	or	$4,$5,$3
	.set	noreorder
	.set	nomacro
	j	$L649
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L636:
	li	$2,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L641
	sll	$4,$17,30
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	li	$2,2097152			# 0x00200000
	.set	macro
	.set	reorder

	li	$2,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L642
	li	$3,50987008			# 0x030a0000
	.set	macro
	.set	reorder

	li	$2,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L640
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sll	$2,$17,26
	.set	macro
	.set	reorder

$L645:
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L639
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	li	$2,8388608			# 0x00800000
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L619
	sll	$5,$17,30
	.set	macro
	.set	reorder

	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$3,$17,$3
	li	$4,127			# 0x0000007f
	lbu	$2,843($3)
	lbu	$3,841($3)
$L650:
	subu	$2,$4,$2
	sll	$2,$2,16
	or	$5,$5,$2
	subu	$4,$4,$3
	sll	$4,$4,8
	or	$4,$5,$4
	.set	noreorder
	.set	nomacro
	j	$L649
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L639:
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$17,$2
	sll	$4,$17,30
	lbu	$3,843($2)
	lbu	$2,841($2)
	addu	$3,$3,128
	sll	$3,$3,16
	or	$4,$4,$3
	addu	$2,$2,128
	.set	noreorder
	.set	nomacro
	j	$L651
	sll	$2,$2,8
	.set	macro
	.set	reorder

$L640:
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$17,$2
	lbu	$2,845($2)
	sll	$4,$17,30
	.set	noreorder
	.set	nomacro
	j	$L656
	li	$3,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L641:
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$17,$2
	lbu	$2,847($2)
	li	$3,33554432			# 0x02000000
$L656:
	sll	$2,$2,8
	or	$2,$2,$3
$L651:
	or	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$L649
	ori	$2,$4,0x0001
	.set	macro
	.set	reorder

$L642:
	ori	$3,$3,0xff01
	sll	$2,$17,30
	.set	noreorder
	.set	nomacro
	j	$L649
	or	$2,$2,$3
	.set	macro
	.set	reorder

$L619:
	sll	$2,$17,26
$L658:
	sll	$3,$16,8
$L659:
	or	$2,$2,$3
	ori	$2,$2,0x0002
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

	.end	GetPSXPadValue__Fii
	.align	2
	.globl	SetPads__Fv
	.ent	SetPads__Fv
SetPads__Fv:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	move	$21,$0
	sw	$fp,48($sp)
	lui	$fp,%hi(ticks) # high
	lui	$2,%hi(frontEnd) # high
	sw	$23,44($sp)
	addiu	$23,$2,%lo(frontEnd) # low
	sw	$31,52($sp)
	sw	$22,40($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L661:
	slt	$2,$21,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	li	$22,4			# 0x00000004
	.set	macro
	.set	reorder

	lw	$2,1096($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	sll	$17,$21,$22
	.set	macro
	.set	reorder

	li	$22,7			# 0x00000007
$L664:
	lw	$16,%lo(ticks)($fp)
$L665:
	lw	$2,%lo(ticks)($fp)
	#nop
	subu	$2,$2,$16
	slt	$2,$2,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	move	$3,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PadGetState
	move	$4,$17
	.set	macro
	.set	reorder

	xori	$2,$2,0x0006
	sltu	$3,$0,$2
$L667:
	bne	$3,$0,$L665
	.set	noreorder
	.set	nomacro
	jal	PadGetState
	move	$4,$17
	.set	macro
	.set	reorder

	li	$3,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L670
	move	$20,$0
	.set	macro
	.set	reorder

	move	$19,$20
	move	$4,$17
	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	PadInfoMode
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$18,$2
	move	$16,$20
$L673:
	slt	$2,$16,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	PadInfoMode
	move	$6,$16
	.set	macro
	.set	reorder

	bne	$2,$22,$L675
	li	$19,1			# 0x00000001
	move	$20,$16
$L675:
	.set	noreorder
	.set	nomacro
	j	$L673
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L672:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L670
	move	$5,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PadSetMainMode
	move	$6,$0
	.set	macro
	.set	reorder

$L670:
	addu	$23,$23,4
	.set	noreorder
	.set	nomacro
	j	$L661
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L660:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	SetPads__Fv
	.align	2
	.globl	InitFrontEndStructure__Fv
	.ent	InitFrontEndStructure__Fv
InitFrontEndStructure__Fv:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$19,36($sp)
	move	$19,$0
	lui	$3,%hi(frontEnd) # high
	addiu	$2,$3,%lo(frontEnd) # low
	move	$4,$2
	li	$2,1			# 0x00000001
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sh	$0,%lo(frontEnd)($3)
	sb	$2,7($4)
	li	$2,20			# 0x00000014
	sb	$0,2($4)
	sh	$0,84($4)
	sh	$0,86($4)
	sh	$0,88($4)
	sb	$0,3($4)
	sb	$0,4($4)
	sb	$0,6($4)
	sb	$2,916($4)
	addu	$2,$19,$4
$L699:
	addu	$19,$19,1
	sb	$0,35($2)
	sb	$0,45($2)
	sb	$0,55($2)
	sb	$0,50($2)
	sb	$0,22($2)
	sb	$0,27($2)
	sb	$0,60($2)
	sb	$0,65($2)
	sb	$0,919($2)
	sb	$0,92($2)
	slt	$2,$19,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	addu	$2,$19,$4
	.set	macro
	.set	reorder

	move	$19,$0
	li	$22,1			# 0x00000001
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	move	$21,$2
	move	$23,$21
	move	$17,$23
	move	$fp,$19
	move	$18,$23
	sw	$0,16($sp)
	lbu	$4,35($21)
	move	$16,$22
	sb	$0,33($21)
	sb	$0,34($21)
	sb	$0,296($21)
	sb	$0,297($21)
	sb	$16,790($21)
	.set	noreorder
	.set	nomacro
	jal	Stattool_ReturnRecordLapTime__Fs
	sb	$0,44($21)
	.set	macro
	.set	reorder

	sw	$2,40($21)
	sb	$16,9($21)
	sb	$16,10($21)
	sb	$16,918($21)
	sb	$0,288($21)
	sb	$0,289($21)
	sb	$0,290($21)
	sb	$0,295($21)
	sb	$0,299($21)
	sb	$0,300($21)
	sb	$0,799($21)
$L687:
	move	$16,$0
	li	$2,-1			# 0xffffffff
	sw	$22,1096($18)
	sb	$0,788($17)
	sb	$22,94($17)
	sb	$0,800($17)
	sb	$22,802($17)
	sb	$22,804($17)
	sb	$22,806($17)
	sb	$22,808($17)
	sb	$22,810($17)
	sb	$22,812($17)
	sb	$0,814($17)
	sb	$0,72($17)
	sw	$0,76($18)
	sh	$2,90($21)
	li	$2,3			# 0x00000003
	sb	$2,817($18)
	li	$2,6			# 0x00000006
	sb	$2,818($18)
	li	$2,7			# 0x00000007
	sb	$2,819($18)
	sll	$2,$19,3
	addu	$2,$2,$21
	sb	$0,816($18)
	sb	$0,868($2)
	addu	$2,$16,$fp
$L700:
	addu	$2,$2,$21
	sb	$0,824($2)
	addu	$16,$16,1
	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L700
	addu	$2,$16,$fp
	.set	macro
	.set	reorder

	lw	$20,16($sp)
	move	$16,$0
	sb	$22,791($17)
	sb	$22,793($17)
	sb	$22,795($17)
	lui	$6,%hi(carManager) # high
$L701:
	addiu	$4,$6,%lo(carManager) # low
	sll	$5,$16,16
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	addu	$3,$16,$20
	addu	$16,$16,1
	lbu	$2,4($2)
	addu	$3,$3,$21
	sb	$2,96($3)
	slt	$2,$16,48
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	lui	$6,%hi(carManager) # high
	.set	macro
	.set	reorder

	move	$4,$19
	li	$2,65			# 0x00000041
	li	$20,85			# 0x00000055
	sh	$2,862($23)
	sb	$0,866($17)
	sb	$22,921($17)
	sb	$20,857($17)
	.set	noreorder
	.set	nomacro
	jal	Front_ResetPSXAnalogs__Fi
	sb	$20,859($17)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	Front_ResetPSXController__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$17,$17,1
	addu	$23,$23,2
	addu	$fp,$fp,4
	addu	$18,$18,4
	addu	$19,$19,1
	lw	$6,16($sp)
	slt	$2,$19,2
	addu	$6,$6,48
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L687
	sw	$6,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	.set	noreorder
	.set	nomacro
	jal	Front_ResetSettingsMenu__Fi
	sb	$0,917($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_ResetSettingsMenu__Fi
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi(CreditManager) # high
	addiu	$4,$4,%lo(CreditManager) # low
	li	$2,1			# 0x00000001
	sb	$2,798($16)
	li	$2,2			# 0x00000002
	sb	$2,838($16)
	lui	$2,%hi(gMasterMusicLevel) # high
	li	$3,85			# 0x00000055
	sb	$0,797($16)
	sb	$0,832($16)
	sb	$20,833($16)
	sb	$20,834($16)
	sb	$20,835($16)
	sb	$20,836($16)
	sb	$20,837($16)
	sb	$0,839($16)
	sw	$3,%lo(gMasterMusicLevel)($2)
	lui	$2,%hi(gMasterSFXLevel) # high
	sw	$3,%lo(gMasterSFXLevel)($2)
	lui	$2,%hi(gMasterFENarrationLevel) # high
	sw	$3,%lo(gMasterFENarrationLevel)($2)
	lui	$2,%hi(gMasterAmbientLevel) # high
	sw	$3,%lo(gMasterAmbientLevel)($2)
	sb	$0,840($16)
	.set	noreorder
	.set	nomacro
	jal	Setup__14tCreditManager
	sw	$0,1092($16)
	.set	macro
	.set	reorder

	lw	$31,60($sp)
	lw	$fp,56($sp)
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

	.end	InitFrontEndStructure__Fv
	.align	2
	.globl	LoadConfig__Fv
	.ent	LoadConfig__Fv
LoadConfig__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	LoadConfig__Fv
	.align	2
	.globl	Front_InitialMemCardCheck__Fv
	.ent	Front_InitialMemCardCheck__Fv
Front_InitialMemCardCheck__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(MEMCARDFRONTENDISINITTED) # high
	sw	$0,%lo(MEMCARDFRONTENDISINITTED)($2)
	lui	$2,%hi(gPSXMemCardFull) # high
	sw	$0,%lo(gPSXMemCardFull)($2)
	lui	$2,%hi(memCardReadOK) # high
	lui	$4,%hi(Stats_gTrackRecords) # high
	addiu	$4,$4,%lo(Stats_gTrackRecords) # low
	move	$5,$0
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetAllDefaultRecords__FP13tRecordBufferb
	sw	$0,%lo(memCardReadOK)($2)
	.set	macro
	.set	reorder

	jal	InitFrontEndStructure__Fv
	lw	$31,16($sp)
	lui	$2,%hi(frontEnd+832) # high
	sb	$0,%lo(frontEnd+832)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Front_InitialMemCardCheck__Fv
	.align	2
	.globl	Front_SecondaryMemCardCheck__Fv
	.ent	Front_SecondaryMemCardCheck__Fv
Front_SecondaryMemCardCheck__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi(MEMCARDFRONTENDISINITTED) # high
	move	$4,$0
	move	$5,$4
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Init_Memcard__FbT0
	sw	$0,%lo(MEMCARDFRONTENDISINITTED)($2)
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$19,%hi(memCardReadOK) # high
$L707:
	slt	$2,$17,2
	beq	$2,$0,$L706
	lw	$2,%lo(memCardReadOK)($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$18,$17,16
	sra	$4,$18,16
$L716:
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	LoadGame__FsbT1
	move	$6,$5
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sltu	$3,$2,1
	addu	$16,$16,1
	slt	$2,$16,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L709
	sw	$3,%lo(memCardReadOK)($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L716
	sra	$4,$18,16
	.set	macro
	.set	reorder

$L709:
	sw	$0,%lo(memCardReadOK)($19)
	.set	noreorder
	.set	nomacro
	j	$L707
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L706:
	jal	DeInit_Memcard__Fv
	jal	SetPads__Fv
	lui	$3,%hi(MEMCARDFRONTENDISINITTED) # high
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	sw	$2,%lo(MEMCARDFRONTENDISINITTED)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Front_SecondaryMemCardCheck__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"%szzFE.viv\000"
	.text
	.align	2
	.globl	Front_InitGraphics__Fv
	.ent	Front_InitGraphics__Fv
Front_InitGraphics__Fv:
	.frame	$sp,64,$31		# vars= 40, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	move	$4,$0
	li	$5,1			# 0x00000001
	sw	$31,56($sp)
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+140) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+140)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$0
	li	$6,100			# 0x00000064
	lui	$7,%hi(gFEBigHandle) # high
	.set	noreorder
	.set	nomacro
	jal	FILE_addbigsync
	addiu	$7,$7,%lo(gFEBigHandle) # low
	.set	macro
	.set	reorder

	bne	$2,$0,$L718
$L721:
	j	$L721
$L718:
	jal	Platform_ResetDCTBuffer__Fv
	jal	Init_PSX_FrontEnd__Fv
	lw	$31,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Front_InitGraphics__Fv
	.align	2
	.globl	Front_InitGraphicsAndDisplayLoading__Fv
	.ent	Front_InitGraphicsAndDisplayLoading__Fv
Front_InitGraphicsAndDisplayLoading__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Front_InitGraphics__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Front_InitGraphicsAndDisplayLoading__Fv
	.align	2
	.globl	Front_Menu__F21tFront_ProcessingType
	.ent	Front_Menu__F21tFront_ProcessingType
Front_Menu__F21tFront_ProcessingType:
	.frame	$sp,56,$31		# vars= 8, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,28($sp)
	move	$17,$4
	sw	$19,36($sp)
	move	$19,$0
	lui	$2,%hi(_7tScreen_fSuppressLoadingText) # high
	sw	$20,40($sp)
	li	$20,1			# 0x00000001
	sw	$31,48($sp)
	sw	$21,44($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	largestunused
	sw	$20,%lo(_7tScreen_fSuppressLoadingText)($2)
	.set	macro
	.set	reorder

	move	$5,$19
	move	$16,$19
	lui	$3,%hi(frontEnd) # high
	addiu	$21,$3,%lo(frontEnd) # low
	lbu	$4,832($21)
	lui	$3,%hi(gLargestUnused) # high
	.set	noreorder
	.set	nomacro
	jal	FeAudio_InitCommentary__Fii
	sw	$2,%lo(gLargestUnused)($3)
	.set	macro
	.set	reorder

	jal	InitializeSpinningCars__Fv
	jal	Front_ConstructAll__Fv
	lui	$2,%hi(carManager) # high
	addiu	$18,$2,%lo(carManager) # low
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$19
	.set	macro
	.set	reorder

	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L725
	lui	$2,%hi(tournamentManager+20) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(tournamentManager+20)($2)
	#nop
	slt	$16,$2,$20
$L725:
	beq	$16,$0,$L726
	.set	noreorder
	.set	nomacro
	jal	CheapestCarStockPrice__11tCarManager
	move	$4,$18
	.set	macro
	.set	reorder

	lui	$3,%hi(tournamentManager) # high
	addiu	$3,$3,%lo(tournamentManager) # low
	lw	$4,20($3)
	addu	$2,$2,1
	addu	$4,$4,$2
	sw	$4,20($3)
$L726:
	.set	noreorder
	.set	nomacro
	beq	$17,$20,$L729
	slt	$2,$17,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$17,$0,$L728
	j	$L727
$L741:
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L731
	lui	$2,%hi(gCalculateVictory) # high
	.set	macro
	.set	reorder

	j	$L727
$L728:
	jal	LoadConfig__Fv
$L729:
	lui	$2,%hi(gUseFrontend) # high
	lw	$2,%lo(gUseFrontend)($2)
	#nop
	beq	$2,$0,$L727
	.set	noreorder
	.set	nomacro
	jal	MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(FEApp) # high
	lw	$4,%lo(FEApp)($2)
	jal	RunFrontEnd__14tFEApplication
	.set	noreorder
	.set	nomacro
	j	$L727
	move	$19,$2
	.set	macro
	.set	reorder

$L731:
	lbu	$3,4($21)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$17,$L732
	sb	$20,%lo(gCalculateVictory)($2)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+36) # high
	lw	$2,%lo(GameSetup_gData+36)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lui	$16,%hi(tournamentManager) # high
	addiu	$16,$16,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	AdvanceToNextTrack__18tTournamentManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateAwardInformation__18tTournamentManager
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L743
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

$L732:
	lui	$2,%hi(frontEnd) # high
$L744:
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,4($4)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L743
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+36) # high
	lw	$2,%lo(GameSetup_gData+36)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L743
	lui	$2,%hi(FEApp) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gNewCarStatsList+132) # high
	lw	$2,%lo(Cars_gNewCarStatsList+132)($2)
	#nop
	slt	$2,$2,2
	beq	$2,$0,$L737
	lh	$2,90($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L745
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

$L737:
	lh	$2,90($4)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L735
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

$L745:
	addiu	$2,$2,%lo(frontEnd) # low
	lbu	$3,70($2)
	#nop
	sll	$3,$3,1
	addu	$3,$3,$2
	sh	$0,12($3)
	lbu	$3,72($2)
	#nop
	addu	$3,$3,1
	.set	noreorder
	.set	nomacro
	j	$L733
	sb	$3,72($2)
	.set	macro
	.set	reorder

$L735:
	lbu	$2,70($4)
	#nop
	sll	$2,$2,1
	addu	$2,$2,$4
	sh	$3,12($2)
	lbu	$2,73($4)
	#nop
	addu	$2,$2,1
	sb	$2,73($4)
$L733:
	lui	$2,%hi(FEApp) # high
$L743:
	lw	$4,%lo(FEApp)($2)
	jal	RunPostGame__14tFEApplication
	move	$19,$2
$L727:
	.set	noreorder
	.set	nomacro
	jal	Front_DeleteAll__Fv
	lui	$16,%hi(gFEBigHandle) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeAudio_DeInitCommentary__Fv
	lui	$17,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Audio_FECleanUp__Fv
	addiu	$17,$17,%lo(frontEnd) # low
	.set	macro
	.set	reorder

	jal	TextSys_UnloadWords__Fv
	jal	FeTools_deinit__Fv
	jal	PSXExitFrontend__Fv
	lw	$4,%lo(gFEBigHandle)($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_delbigsync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

	lbu	$4,35($17)
	.set	noreorder
	.set	nomacro
	jal	Stattool_ReturnRecordLapTime__Fs
	sw	$0,%lo(gFEBigHandle)($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	largestunused
	sw	$2,40($17)
	.set	macro
	.set	reorder

	lui	$3,%hi(gLargestUnused) # high
	sw	$2,%lo(gLargestUnused)($3)
	move	$2,$19
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

	.end	Front_Menu__F21tFront_ProcessingType
	.align	2
	.globl	OutputDisplaySettings__FPiiiR17tTrackInformation
	.ent	OutputDisplaySettings__FPiiiR17tTrackInformation
OutputDisplaySettings__FPiiiR17tTrackInformation:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	move	$9,$5
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$6,$2
	lbu	$3,800($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L747
	move	$4,$0
	.set	macro
	.set	reorder

	slt	$2,$3,2
	beq	$2,$0,$L753
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L748
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L754
	li	$2,282			# 0x0000011a
	.set	macro
	.set	reorder

$L753:
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L750
	li	$4,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L754
	li	$2,282			# 0x0000011a
	.set	macro
	.set	reorder

$L748:
	lui	$3,%hi(CountryMeasurement) # high
	lbu	$2,42($7)
	addiu	$3,$3,%lo(CountryMeasurement) # low
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$4,0($2)
	.set	noreorder
	.set	nomacro
	j	$L754
	li	$2,282			# 0x0000011a
	.set	macro
	.set	reorder

$L750:
	li	$4,1			# 0x00000001
$L747:
	li	$2,282			# 0x0000011a
$L754:
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	addu	$8,$8,4
	sw	$4,0($8)
	addu	$8,$8,4
	li	$2,283			# 0x0000011b
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	addu	$8,$8,4
	move	$4,$8
	lui	$5,%hi(frontEnd) # high
	addiu	$5,$5,%lo(frontEnd) # low
	addu	$3,$6,$5
	lbu	$2,800($3)
	addu	$8,$8,4
	xori	$2,$2,0x0003
	sltu	$2,$0,$2
	sw	$2,0($4)
	li	$2,284			# 0x0000011c
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,804($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,285			# 0x0000011d
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,806($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,286			# 0x0000011e
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,808($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,287			# 0x0000011f
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,812($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,288			# 0x00000120
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,810($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,289			# 0x00000121
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	addu	$8,$8,4
	lbu	$2,814($3)
	sll	$3,$6,2
	addu	$3,$3,$5
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,294			# 0x00000126
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,816($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,295			# 0x00000127
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,817($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,296			# 0x00000128
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,818($3)
	addu	$8,$8,4
	sw	$2,0($8)
	addu	$8,$8,4
	li	$2,297			# 0x00000129
	sw	$2,0($8)
	addu	$8,$8,4
	sw	$9,0($8)
	lbu	$2,819($3)
	addu	$8,$8,4
	sw	$2,0($8)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$8,4
	.set	macro
	.set	reorder

	.end	OutputDisplaySettings__FPiiiR17tTrackInformation
	.align	2
	.globl	Front_GetLapsForType__Fv
	.ent	Front_GetLapsForType__Fv
Front_GetLapsForType__Fv:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	li	$2,2			# 0x00000002
	sh	$2,0($sp)
	li	$2,4			# 0x00000004
	sh	$2,2($sp)
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,4($4)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L756
	lbu	$2,70($4)
	#nop
	addu	$2,$2,$4
	lbu	$2,45($2)
	#nop
	sll	$2,$2,1
	addu	$2,$sp,$2
	lh	$2,0($2)
	j	$L757
$L756:
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lbu	$2,105($2)
$L757:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	Front_GetLapsForType__Fv
	.align	2
	.globl	Front_InitStream__FR9tFEStream
	.ent	Front_InitStream__FR9tFEStream
Front_InitStream__FR9tFEStream:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	sh	$0,0($4)
	sh	$0,2($4)
	sh	$0,4($4)
	lui	$4,%hi(carManager) # high
	.set	noreorder
	.set	nomacro
	jal	InitializeIngameCarList__11tCarManager
	addiu	$4,$4,%lo(carManager) # low
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

	.end	Front_InitStream__FR9tFEStream
	.align	2
	.globl	Front_InitPlayerCars__FR9tFEStream
	.ent	Front_InitPlayerCars__FR9tFEStream
Front_InitPlayerCars__FR9tFEStream:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	lui	$2,%hi(frontEnd) # high
	sw	$19,36($sp)
	addiu	$19,$2,%lo(frontEnd) # low
	sw	$31,40($sp)
	sw	$18,32($sp)
	sw	$16,24($sp)
	sh	$0,6($17)
	lbu	$3,4($19)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L760
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	addu	$6,$17,8
	lbu	$5,291($19)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	j	$L777
$L760:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L762
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$16,%hi(carManager) # high
	addiu	$16,$16,%lo(carManager) # low
	move	$4,$16
	addu	$6,$17,8
	lbu	$5,293($19)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	lh	$3,6($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,8
	addu	$5,$17,$2
	lbu	$2,197($5)
	#nop
	addu	$2,$5,$2
	lbu	$2,175($2)
	move	$4,$16
	sb	$2,197($5)
	lhu	$2,6($17)
	li	$7,1			# 0x00000001
	addu	$2,$2,$7
	sh	$2,6($17)
	sll	$2,$2,16
	sra	$2,$2,16
	sll	$6,$2,$7
	addu	$6,$6,$2
	sll	$2,$6,4
	addu	$6,$6,$2
	sll	$6,$6,2
	addu	$6,$6,8
	lbu	$5,294($19)
	.set	noreorder
	.set	nomacro
	jal	GetPinkSlipsCar__11tCarManagersR8tCarInfos
	addu	$6,$17,$6
	.set	macro
	.set	reorder

$L777:
	lh	$3,6($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,8
	addu	$5,$17,$2
	lbu	$2,197($5)
	#nop
	addu	$2,$5,$2
	lbu	$2,175($2)
	#nop
	sb	$2,197($5)
	lhu	$2,6($17)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L761
	sh	$2,6($17)
	.set	macro
	.set	reorder

$L762:
$L764:
	lbu	$2,298($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L767
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	sll	$16,$18,16
	sra	$16,$16,16
	addu	$2,$16,$19
	lh	$3,6($17)
	lbu	$5,92($2)
	sll	$6,$3,1
	addu	$6,$6,$3
	sll	$2,$6,4
	addu	$6,$6,$2
	sll	$6,$6,2
	addu	$6,$6,8
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$17,$6
	.set	macro
	.set	reorder

	lh	$3,6($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,8
	addu	$5,$17,$2
	sll	$2,$16,1
	addu	$2,$2,$16
	lb	$3,0($5)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$19
	lbu	$2,96($3)
	.set	noreorder
	.set	nomacro
	j	$L779
	addu	$2,$5,$2
	.set	macro
	.set	reorder

$L767:
	addiu	$4,$4,%lo(carManager) # low
	sll	$7,$18,16
	sra	$7,$7,16
	addu	$2,$7,$19
	lh	$3,6($17)
	lbu	$5,291($2)
	sll	$6,$3,1
	addu	$6,$6,$3
	sll	$2,$6,4
	addu	$6,$6,$2
	sll	$6,$6,2
	addu	$6,$6,8
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	addu	$6,$17,$6
	.set	macro
	.set	reorder

	lh	$3,6($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,8
	addu	$5,$17,$2
	lbu	$2,197($5)
	#nop
	addu	$2,$5,$2
$L779:
	lbu	$2,175($2)
	#nop
	sb	$2,197($5)
 #APP
 #NO_APP
	lbu	$3,2($5)
	li	$2,7			# 0x00000007
	bne	$3,$2,$L769
	lh	$3,6($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lb	$3,0($5)
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$19
	lbu	$2,192($3)
	sb	$0,197($5)
	sb	$2,199($5)
$L769:
	lhu	$2,6($17)
	#nop
	addu	$2,$2,1
	sh	$2,6($17)
	lbu	$3,3($19)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L761
	addu	$2,$18,$2
	.set	macro
	.set	reorder

	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	bne	$2,$0,$L764
$L761:
	move	$18,$0
	lui	$16,%hi(carManager) # high
$L772:
	sll	$3,$18,16
	lh	$2,6($17)
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L759
	addiu	$4,$16,%lo(carManager) # low
	.set	macro
	.set	reorder

	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$17,$2
	lb	$3,8($2)
	addu	$5,$sp,16
	sw	$3,16($sp)
	lbu	$2,205($2)
	addu	$6,$sp,20
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	sb	$2,20($sp)
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L780
	addiu	$4,$16,%lo(carManager) # low
	.set	macro
	.set	reorder

	lh	$2,2($17)
	lhu	$3,2($17)
	slt	$2,$2,13
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L780
	addu	$2,$3,6
	.set	macro
	.set	reorder

	sh	$2,2($17)
	addiu	$4,$16,%lo(carManager) # low
$L780:
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	addu	$6,$sp,20
	.set	macro
	.set	reorder

	sll	$3,$18,16
	sra	$3,$3,16
	sll	$4,$3,2
	addu	$4,$4,$3
	sll	$4,$4,2
	lhu	$2,0($17)
	addu	$4,$17,$4
	addu	$2,$2,2
	sh	$2,0($17)
	lw	$5,16($sp)
	lbu	$6,20($sp)
	li	$2,1			# 0x00000001
	sw	$2,420($4)
	sll	$2,$3,$2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$17,$2
	sw	$5,432($4)
	sb	$6,436($4)
	lbu	$2,204($2)
	addu	$18,$18,1
	.set	noreorder
	.set	nomacro
	j	$L772
	sb	$2,437($4)
	.set	macro
	.set	reorder

$L759:
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

	.end	Front_InitPlayerCars__FR9tFEStream
	.align	2
	.globl	Front_InitTourneyTraffic__FR9tFEStream
	.ent	Front_InitTourneyTraffic__FR9tFEStream
Front_InitTourneyTraffic__FR9tFEStream:
	.frame	$sp,56,$31		# vars= 8, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,24($sp)
	move	$16,$4
	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	sw	$31,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lw	$3,4($4)
	sb	$0,20($sp)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	sh	$0,580($16)
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$5,$5,$2
	lui	$2,%hi(frontEnd+4) # high
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L781
	lbu	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(carManager) # high
	addiu	$20,$2,%lo(carManager) # low
	addu	$19,$sp,16
	addu	$18,$sp,20
	li	$21,3			# 0x00000003
$L783:
	move	$2,$17
	addu	$3,$2,1
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$16,$2
	move	$17,$3
	sll	$3,$3,16
	sra	$3,$3,16
	lbu	$2,684($2)
	slt	$3,$3,6
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L786
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$17,$0
$L786:
	move	$4,$20
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	move	$6,$18
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L787
	move	$4,$20
	.set	macro
	.set	reorder

	move	$5,$19
	lhu	$2,2($16)
	move	$6,$18
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	sh	$2,2($16)
	.set	macro
	.set	reorder

$L787:
	lh	$2,580($16)
	lhu	$3,16($sp)
	sll	$2,$2,1
	addu	$2,$16,$2
	sh	$3,582($2)
	lhu	$3,0($16)
	lhu	$2,580($16)
	addu	$3,$3,1
	addu	$2,$2,1
	sh	$2,580($16)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L783
	sh	$3,0($16)
	.set	macro
	.set	reorder

$L781:
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

	.end	Front_InitTourneyTraffic__FR9tFEStream
	.align	2
	.globl	Front_InitOpponentCars__FR9tFEStream
	.ent	Front_InitOpponentCars__FR9tFEStream
Front_InitOpponentCars__FR9tFEStream:
	.frame	$sp,312,$31		# vars= 248, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,312
	sw	$18,280($sp)
	move	$18,$4
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	sw	$31,308($sp)
	sw	$fp,304($sp)
	sw	$23,300($sp)
	sw	$22,296($sp)
	sw	$21,292($sp)
	sw	$20,288($sp)
	sw	$19,284($sp)
	sw	$17,276($sp)
	sw	$16,272($sp)
	sh	$0,416($18)
	lbu	$3,4($2)
	li	$4,2			# 0x00000002
	beq	$3,$4,$L791
	bne	$3,$0,$L790
	lbu	$2,798($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L830
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

$L791:
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L792
	sw	$0,264($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lbu	$3,39($2)
	.set	noreorder
	.set	nomacro
	j	$L828
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

$L792:
	li	$3,10			# 0x0000000a
	li	$2,10			# 0x0000000a
$L828:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L794
	lui	$4,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager+24) # high
	lw	$4,%lo(tournamentManager+24)($2)
	lbu	$2,8($18)
	lbu	$3,26($4)
	li	$10,1			# 0x00000001
	sw	$10,264($sp)
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	.set	noreorder
	.set	nomacro
	j	$L795
	addu	$19,$4,$2
	.set	macro
	.set	reorder

$L794:
	addiu	$4,$4,%lo(tournamentManager) # low
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$19,$5,$2
$L795:
	lui	$2,%hi(frontEnd+4) # high
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L796
	li	$23,5			# 0x00000005
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager+16) # high
	lw	$2,%lo(tournamentManager+16)($2)
	#nop
	addu	$23,$2,-1
$L796:
	sll	$2,$23,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L798
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(carManager) # high
	addiu	$20,$2,%lo(carManager) # low
	addu	$22,$sp,248
	addu	$21,$sp,252
	lui	$2,%hi(frontEnd) # high
	addiu	$fp,$2,%lo(frontEnd) # low
$L799:
	sll	$2,$17,16
	sra	$2,$2,16
	addu	$2,$19,$2
	lbu	$5,57($2)
	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	sw	$5,248($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$sp,248
	move	$16,$2
	lbu	$2,4($16)
	addu	$6,$sp,252
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	sb	$2,252($sp)
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L831
	move	$4,$20
	.set	macro
	.set	reorder

	lh	$2,2($18)
	lhu	$3,2($18)
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L831
	addu	$2,$3,3
	.set	macro
	.set	reorder

	sh	$2,2($18)
	move	$4,$20
$L831:
	move	$5,$22
	move	$6,$21
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	move	$6,$21
	.set	macro
	.set	reorder

	sll	$2,$17,16
	sra	$6,$2,16
	addu	$3,$6,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$4,248($sp)
	lbu	$3,252($sp)
	addu	$5,$18,$2
	sw	$0,420($5)
	addu	$3,$16,$3
	sw	$4,432($5)
	lbu	$2,175($3)
	#nop
	sb	$2,436($5)
	lw	$10,264($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L803
	addu	$2,$19,$6
	.set	macro
	.set	reorder

	lbu	$2,204($18)
	.set	noreorder
	.set	nomacro
	j	$L829
	sb	$2,437($5)
	.set	macro
	.set	reorder

$L803:
	lbu	$2,62($2)
	#nop
	sb	$2,437($5)
$L829:
	lbu	$3,4($fp)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L832
	addu	$4,$17,1
	.set	macro
	.set	reorder

	lbu	$2,290($fp)
	#nop
	bne	$2,$0,$L832
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	li	$4,25			# 0x00000019
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L833
	sll	$3,$17,16
	.set	macro
	.set	reorder

	lbu	$2,34($fp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L806
	sra	$3,$3,16
	.set	macro
	.set	reorder

	addu	$4,$3,1
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$3,$19,$3
	lbu	$3,62($3)
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	j	$L805
	sb	$3,437($2)
	.set	macro
	.set	reorder

$L806:
	sll	$3,$17,16
$L833:
	sra	$3,$3,16
	addu	$3,$3,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$18,$2
	sb	$0,437($2)
$L805:
	addu	$4,$17,1
$L832:
	move	$17,$4
	sll	$4,$4,16
	lhu	$2,0($18)
	lhu	$3,416($18)
	addu	$2,$2,2
	addu	$3,$3,1
	sh	$2,0($18)
	sll	$2,$23,16
	slt	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L799
	sh	$3,416($18)
	.set	macro
	.set	reorder

$L798:
	lui	$2,%hi(frontEnd+4) # high
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L809
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$16,%hi(tournamentManager) # high
	addiu	$16,$16,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	UpdateCarLineup__18tTournamentManager
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$0
	lw	$2,16($16)
	#nop
	addu	$2,$2,-1
	sh	$2,416($18)
	sll	$2,$23,16
	sra	$2,$2,16
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	blez	$2,$L789
	addu	$16,$16,376
	.set	macro
	.set	reorder

	move	$5,$2
$L813:
	sll	$2,$17,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$4,$3,$16
	lw	$2,4($4)
	addu	$3,$18,$3
	sw	$2,424($3)
	addu	$2,$17,1
	move	$17,$2
	sll	$2,$2,16
	sra	$2,$2,16
	lbu	$4,8($4)
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L813
	sb	$4,428($3)
	.set	macro
	.set	reorder

	j	$L789
$L809:
$L819:
	sll	$5,$17,16
	addu	$6,$17,1
	move	$4,$6
	move	$17,$4
	sra	$5,$5,16
	addu	$3,$5,1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$18,$2
	sll	$4,$4,16
	sra	$4,$4,16
	slt	$4,$4,5
	sw	$5,424($2)
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L819
	sb	$6,428($2)
	.set	macro
	.set	reorder

	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	j	$L789
	sb	$2,428($18)
	.set	macro
	.set	reorder

$L790:
	lui	$2,%hi(frontEnd) # high
$L830:
	addiu	$5,$2,%lo(frontEnd) # low
	lbu	$2,4($5)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L822
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,798($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L834
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(carManager) # high
	addiu	$17,$2,%lo(carManager) # low
	move	$4,$17
	lbu	$5,797($5)
	.set	noreorder
	.set	nomacro
	jal	GetStockCar__11tCarManagersR8tCarInfo
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$20,$sp,256
	move	$5,$20
	lb	$2,24($sp)
	lbu	$3,28($sp)
	addu	$19,$sp,260
	sw	$2,256($sp)
	addu	$2,$sp,$3
	lbu	$2,199($2)
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	sb	$2,260($sp)
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L835
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	lh	$2,2($18)
	lhu	$3,2($18)
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L824
	addu	$2,$3,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L835
	sh	$2,2($18)
	.set	macro
	.set	reorder

$L824:
	move	$4,$17
	li	$6,3			# 0x00000003
	addu	$16,$sp,232
	lbu	$5,26($sp)
	.set	noreorder
	.set	nomacro
	jal	GetClassList__11tCarManager13tCarClassTypesP10tCarModels
	move	$7,$16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$20
	move	$6,$19
	li	$7,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	jal	FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
$L835:
	addiu	$4,$4,%lo(carManager) # low
	addu	$5,$sp,256
	lhu	$2,416($18)
	lbu	$9,204($18)
	addu	$6,$sp,260
	sw	$0,440($18)
	sw	$0,444($18)
	addu	$2,$2,1
	sh	$2,416($18)
	lw	$7,256($sp)
	lbu	$8,260($sp)
	lbu	$3,416($18)
	li	$2,1			# 0x00000001
	sb	$2,448($18)
	sb	$9,457($18)
	addu	$3,$3,1
	sw	$7,452($18)
	sb	$8,456($18)
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	sb	$3,428($18)
	.set	macro
	.set	reorder

	lhu	$2,0($18)
	#nop
	addu	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L789
	sh	$2,0($18)
	.set	macro
	.set	reorder

$L822:
	li	$2,1			# 0x00000001
$L834:
	sb	$2,428($18)
	li	$2,2			# 0x00000002
	sb	$2,448($18)
$L789:
	lw	$31,308($sp)
	lw	$fp,304($sp)
	lw	$23,300($sp)
	lw	$22,296($sp)
	lw	$21,292($sp)
	lw	$20,288($sp)
	lw	$19,284($sp)
	lw	$18,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,312
	.set	macro
	.set	reorder

	.end	Front_InitOpponentCars__FR9tFEStream
	.align	2
	.globl	Front_InitMissions__FR9tFEStream
	.ent	Front_InitMissions__FR9tFEStream
Front_InitMissions__FR9tFEStream:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	lui	$2,%hi(frontEnd+4) # high
	sw	$31,36($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$0,600($20)
	sw	$0,604($20)
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L836
	move	$6,$0
	.set	macro
	.set	reorder

	lh	$3,6($20)
	#nop
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L839
	move	$4,$6
	.set	macro
	.set	reorder

	li	$7,7			# 0x00000007
	move	$5,$3
	sll	$3,$4,16
$L846:
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$3,$20,$2
	lbu	$2,10($3)
	#nop
	bne	$2,$7,$L836
	lb	$3,8($3)
	#nop
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L845
	addu	$2,$4,1
	.set	macro
	.set	reorder

	move	$6,$3
$L845:
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L846
	sll	$3,$4,16
	.set	macro
	.set	reorder

$L839:
	lui	$17,%hi(missionManager) # high
	addiu	$17,$17,%lo(missionManager) # low
	move	$4,$17
	li	$5,1			# 0x00000001
	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	lbu	$18,299($16)
	lbu	$19,300($16)
	addu	$2,$6,-22
	sb	$2,299($16)
	.set	noreorder
	.set	nomacro
	jal	LoadDescription__15tMissionManagerb
	sb	$0,300($16)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetMissionToRace__15tMissionManagerPP12tMissionInfo
	addu	$5,$20,600
	.set	macro
	.set	reorder

	move	$4,$17
	lbu	$5,299($16)
	lbu	$6,300($16)
	.set	noreorder
	.set	nomacro
	jal	GetMissionStages__15tMissionManagerssPP10tStageInfo
	addu	$7,$20,604
	.set	macro
	.set	reorder

	sb	$18,299($16)
	sb	$19,300($16)
$L836:
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

	.end	Front_InitMissions__FR9tFEStream
	.align	2
	.globl	Front_InitCopCars__FR9tFEStream
	.ent	Front_InitCopCars__FR9tFEStream
Front_InitCopCars__FR9tFEStream:
	.frame	$sp,64,$31		# vars= 8, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,32($sp)
	move	$18,$4
	move	$5,$0
	sw	$19,36($sp)
	move	$19,$5
	move	$6,$5
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lh	$3,6($18)
	li	$2,22			# 0x00000016
	sw	$2,16($sp)
	sb	$0,20($sp)
	sh	$0,540($18)
	.set	noreorder
	.set	nomacro
	blez	$3,$L849
	sh	$0,542($18)
	.set	macro
	.set	reorder

	move	$7,$3
	sll	$3,$19,16
$L886:
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$4,$18,$2
	lb	$3,8($4)
	#nop
	slt	$2,$5,$3
	beq	$2,$0,$L852
	move	$5,$3
$L852:
	lbu	$3,10($4)
	#nop
	slt	$2,$6,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L885
	addu	$2,$19,1
	.set	macro
	.set	reorder

	move	$6,$3
$L885:
	move	$19,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L886
	sll	$3,$19,16
	.set	macro
	.set	reorder

$L849:
	lw	$4,600($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L887
	lui	$2,%hi(frontEnd+4) # high
	.set	macro
	.set	reorder

	lw	$2,604($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L855
	lui	$2,%hi(frontEnd+3) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L847
	lbu	$2,10($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L847
	move	$19,$0
	.set	macro
	.set	reorder

	sll	$3,$19,16
$L888:
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,604($18)
	sll	$2,$2,2
	addu	$3,$2,$3
	lh	$2,6($3)
	#nop
	bgez	$2,$L862
	lh	$2,10($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L859
	addu	$2,$19,1
	.set	macro
	.set	reorder

$L862:
	lh	$2,540($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$5,544($2)
	lh	$2,540($18)
	lbu	$3,207($18)
	sll	$2,$2,1
	addu	$2,$18,$2
	sh	$3,568($2)
	lhu	$2,540($18)
	lhu	$3,0($18)
	addu	$2,$2,1
	addu	$3,$3,2
	sh	$2,540($18)
	.set	noreorder
	.set	nomacro
	j	$L847
	sh	$3,0($18)
	.set	macro
	.set	reorder

$L859:
	move	$19,$2
	lw	$3,600($18)
	sll	$2,$2,16
	lbu	$3,10($3)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L888
	sll	$3,$19,16
	.set	macro
	.set	reorder

	j	$L847
$L855:
	lui	$2,%hi(frontEnd+4) # high
$L887:
	lbu	$3,%lo(frontEnd+4)($2)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L847
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L867
	move	$19,$0
	.set	macro
	.set	reorder

	li	$5,7			# 0x00000007
	move	$4,$2
	sll	$3,$19,16
$L889:
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$18,$2
	lbu	$2,10($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L847
	addu	$2,$19,1
	.set	macro
	.set	reorder

	move	$19,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L889
	sll	$3,$19,16
	.set	macro
	.set	reorder

$L867:
	lh	$3,6($18)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L890
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lh	$2,416($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L872
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sh	$2,540($18)
	.set	noreorder
	.set	nomacro
	j	$L873
	sh	$3,542($18)
	.set	macro
	.set	reorder

$L872:
$L890:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L874
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	sh	$0,540($18)
	.set	noreorder
	.set	nomacro
	j	$L873
	sh	$3,542($18)
	.set	macro
	.set	reorder

$L874:
	sh	$2,540($18)
	sh	$0,542($18)
$L873:
	lh	$2,540($18)
	lh	$3,542($18)
	lhu	$5,542($18)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	blez	$2,$L847
	move	$19,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(superCopModels) # high
	addiu	$23,$2,%lo(superCopModels) # low
	sll	$2,$6,2
	addu	$2,$2,$6
	sll	$20,$2,2
	lui	$2,%hi(regularCopModels) # high
	addiu	$22,$2,%lo(regularCopModels) # low
	lui	$2,%hi(carManager) # high
	addiu	$21,$2,%lo(carManager) # low
	sll	$2,$19,16
$L891:
	sll	$3,$5,16
	slt	$2,$2,$3
	beq	$2,$0,$L880
	lbu	$2,680($18)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$20
	.set	noreorder
	.set	nomacro
	j	$L884
	addu	$2,$2,$23
	.set	macro
	.set	reorder

$L880:
	lbu	$2,680($18)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$20
	addu	$2,$2,$22
$L884:
	lw	$2,0($2)
	#nop
	sw	$2,16($sp)
	move	$4,$21
	addu	$16,$sp,16
	move	$5,$16
	addu	$17,$sp,20
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	move	$6,$17
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L882
	move	$4,$21
	.set	macro
	.set	reorder

	move	$5,$16
	lhu	$2,2($18)
	move	$6,$17
	addu	$2,$2,3
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	sh	$2,2($18)
	.set	macro
	.set	reorder

$L882:
	sll	$3,$19,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$18,$2
	sll	$3,$3,1
	lw	$4,16($sp)
	addu	$3,$18,$3
	sw	$4,544($2)
	addu	$4,$19,1
	move	$19,$4
	lhu	$2,0($18)
	sll	$4,$4,16
	addu	$2,$2,2
	sh	$2,0($18)
	lbu	$2,680($18)
	sra	$4,$4,16
	sh	$2,568($3)
	lh	$2,540($18)
	lh	$3,542($18)
	lhu	$5,542($18)
	addu	$2,$2,$3
	slt	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L891
	sll	$2,$19,16
	.set	macro
	.set	reorder

$L847:
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

	.end	Front_InitCopCars__FR9tFEStream
	.align	2
	.globl	Front_InitPerps__FR9tFEStream
	.ent	Front_InitPerps__FR9tFEStream
Front_InitPerps__FR9tFEStream:
	.frame	$sp,56,$31		# vars= 8, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,24($sp)
	move	$16,$4
	sw	$31,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lw	$2,600($16)
	sh	$0,594($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L892
	sh	$0,596($16)
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$21,%hi(carManager) # high
	addiu	$20,$21,%lo(carManager) # low
	addu	$19,$sp,16
	addu	$18,$sp,20
$L894:
	lw	$2,600($16)
	sll	$3,$17,16
	lbu	$2,10($2)
	sra	$3,$3,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L892
	sll	$2,$3,1
	.set	macro
	.set	reorder

	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,604($16)
	sll	$2,$2,2
	addu	$3,$2,$3
	lbu	$5,0($3)
	lw	$3,604($16)
	#nop
	addu	$2,$2,$3
	sw	$5,16($sp)
	lbu	$2,1($2)
	addiu	$4,$21,%lo(carManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	sb	$2,20($sp)
	.set	macro
	.set	reorder

	move	$5,$2
	move	$3,$0
	lbu	$4,20($sp)
	sll	$2,$3,16
$L906:
	sra	$2,$2,16
	addu	$2,$5,$2
	lb	$2,175($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L899
	addu	$2,$3,1
	.set	macro
	.set	reorder

	move	$3,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L906
	sll	$2,$3,16
	.set	macro
	.set	reorder

$L899:
	sb	$3,20($sp)
	move	$4,$20
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	move	$6,$18
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	beq	$2,$0,$L904
	lh	$2,2($16)
	lhu	$3,2($16)
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L905
	addu	$2,$3,6
	.set	macro
	.set	reorder

	sh	$2,2($16)
$L905:
	move	$4,$20
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	move	$6,$18
	.set	macro
	.set	reorder

	lhu	$2,0($16)
	lh	$3,594($16)
	addu	$2,$2,2
	sll	$3,$3,3
	sh	$2,0($16)
	lw	$2,16($sp)
	addu	$3,$16,$3
	sw	$2,608($3)
	sll	$3,$17,16
	sra	$3,$3,16
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	lh	$4,594($16)
	lw	$3,604($16)
	sll	$4,$4,3
	addu	$2,$2,$3
	lbu	$2,1($2)
	addu	$4,$16,$4
	sb	$2,612($4)
	lhu	$2,594($16)
	#nop
	addu	$2,$2,1
	sh	$2,594($16)
$L904:
	lhu	$2,596($16)
	addu	$17,$17,1
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L894
	sh	$2,596($16)
	.set	macro
	.set	reorder

$L892:
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

	.end	Front_InitPerps__FR9tFEStream
	.align	2
	.globl	Front_InitTrack__FR9tFEStream
	.ent	Front_InitTrack__FR9tFEStream
Front_InitTrack__FR9tFEStream:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	lui	$2,%hi(frontEnd) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(frontEnd) # low
	sw	$31,24($sp)
	lbu	$3,4($16)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L908
	move	$17,$4
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	GetTrackToRace__18tTournamentManagerR10tTrackInfo
	addu	$5,$17,704
	.set	macro
	.set	reorder

	lb	$5,704($17)
	lui	$4,%hi(trackManager) # high
	.set	noreorder
	.set	nomacro
	jal	GetTrackByID__13tTrackManagers
	addiu	$4,$4,%lo(trackManager) # low
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$17,656
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,48			# 0x00000030
	.set	macro
	.set	reorder

	j	$L909
$L908:
	lui	$4,%hi(trackManager) # high
	lbu	$2,70($16)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$16
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$17,656
	.set	macro
	.set	reorder

	lbu	$2,656($17)
	#nop
	sb	$2,704($17)
	lbu	$2,298($16)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L911
	addu	$3,$17,704
	.set	macro
	.set	reorder

	lbu	$2,4($16)
	#nop
	bne	$2,$4,$L910
$L911:
	lbu	$2,70($16)
	#nop
	addu	$2,$2,$16
	lbu	$2,50($2)
	#nop
	sb	$2,1($3)
	lbu	$2,70($16)
	#nop
	addu	$2,$2,$16
	lbu	$2,55($2)
	#nop
	sb	$2,2($3)
	lbu	$2,70($16)
	#nop
	addu	$2,$2,$16
	lbu	$2,22($2)
	#nop
	sb	$2,3($3)
	lbu	$2,70($16)
	#nop
	addu	$2,$2,$16
	lbu	$2,27($2)
	.set	noreorder
	.set	nomacro
	j	$L912
	sb	$2,4($3)
	.set	macro
	.set	reorder

$L910:
	sb	$0,4($3)
	sb	$0,3($3)
	sb	$0,2($3)
	sb	$0,1($3)
$L912:
	li	$2,65536			# 0x00010000
	sw	$2,736($17)
$L909:
	lbu	$2,705($17)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L913
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,705($17)
$L913:
	lbu	$2,706($17)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L914
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,706($17)
$L914:
	lbu	$2,707($17)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L915
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,707($17)
$L915:
	lbu	$2,708($17)
	#nop
	sltu	$2,$2,2
	bne	$2,$0,$L907
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,708($17)
$L907:
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

	.end	Front_InitTrack__FR9tFEStream
	.align	2
	.globl	Front_InitTraffic__FR9tFEStream
	.ent	Front_InitTraffic__FR9tFEStream
Front_InitTraffic__FR9tFEStream:
	.frame	$sp,56,$31		# vars= 8, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,36($sp)
	move	$19,$4
	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	sw	$31,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sb	$0,20($sp)
	lbu	$2,3($3)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L918
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$6,3			# 0x00000003
$L918:
	lbu	$3,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L945
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lbu	$2,707($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L919
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
$L919:
	lui	$2,%hi(frontEnd) # high
$L945:
	addiu	$5,$2,%lo(frontEnd) # low
	lbu	$2,70($5)
	#nop
	addu	$2,$2,$5
	lbu	$2,60($2)
	lbu	$3,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L934
	sltu	$4,$0,$2
	.set	macro
	.set	reorder

	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L923
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	beq	$3,$2,$L921
	.set	noreorder
	.set	nomacro
	j	$L921
	move	$4,$0
	.set	macro
	.set	reorder

$L923:
	lbu	$2,298($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L946
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L947
	addiu	$5,$2,%lo(frontEnd) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L925
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L946:
	addiu	$5,$2,%lo(frontEnd) # low
$L947:
	lbu	$3,4($5)
	li	$2,1			# 0x00000001
	bne	$3,$2,$L925
	lbu	$2,60($5)
	#nop
	sltu	$4,$0,$2
$L925:
	lbu	$2,658($19)
	#nop
	sltu	$2,$2,3
	bne	$2,$0,$L927
	move	$4,$0
$L927:
	lbu	$2,660($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L948
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	move	$4,$0
$L948:
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$5,3($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L929
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$2,4($3)
	#nop
	bne	$2,$5,$L921
	.set	noreorder
	.set	nomacro
	j	$L921
	move	$4,$0
	.set	macro
	.set	reorder

$L929:
	lbu	$3,798($3)
	#nop
	bne	$3,$2,$L921
$L934:
	move	$4,$0
$L921:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L917
	move	$16,$0
	.set	macro
	.set	reorder

	move	$3,$6
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L917
	sh	$0,580($19)
	.set	macro
	.set	reorder

	lui	$2,%hi(carManager) # high
	addiu	$20,$2,%lo(carManager) # low
	addu	$18,$sp,16
	addu	$17,$sp,20
	move	$21,$3
	move	$2,$16
$L949:
	addu	$3,$2,1
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$2,$19,$2
	move	$16,$3
	sll	$3,$3,16
	sra	$3,$3,16
	lbu	$2,684($2)
	slt	$3,$3,6
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L941
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$16,$0
$L941:
	move	$4,$20
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	IsCarAnAddedModel__11tCarManagerR10tCarModelsRc
	move	$6,$17
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L942
	move	$4,$20
	.set	macro
	.set	reorder

	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	AddCarToIngameList__11tCarManagerR10tCarModelsRc
	move	$6,$17
	.set	macro
	.set	reorder

$L942:
	lh	$2,580($19)
	lhu	$3,16($sp)
	sll	$2,$2,1
	addu	$2,$19,$2
	sh	$3,582($2)
	lhu	$2,580($19)
	#nop
	addu	$2,$2,1
	sh	$2,580($19)
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L949
	move	$2,$16
	.set	macro
	.set	reorder

$L917:
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

	.end	Front_InitTraffic__FR9tFEStream
	.align	2
	.globl	Front_AppendPlayerCarData__FPiR9tFEStream
	.ent	Front_AppendPlayerCarData__FPiR9tFEStream
Front_AppendPlayerCarData__FPiR9tFEStream:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	move	$7,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
 #APP
 #NO_APP
	lh	$2,6($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L951
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	addiu	$18,$2,%lo(frontEnd) # low
	li	$2,281			# 0x00000119
$L974:
	sw	$2,0($7)
	addu	$7,$7,4
	sll	$4,$17,16
	lh	$2,4($16)
	sra	$4,$4,16
	sw	$2,0($7)
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,420
	addu	$6,$16,$2
	lb	$2,8($6)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,260			# 0x00000104
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,8
	addu	$5,$16,$2
	addu	$7,$7,4
	lbu	$2,1($5)
	addu	$4,$4,$18
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,262			# 0x00000106
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,94($4)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,266			# 0x0000010a
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,197($5)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,267			# 0x0000010b
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	sw	$0,0($7)
	addu	$7,$7,4
	li	$2,273			# 0x00000111
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,788($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L957
	addu	$7,$7,4
	.set	macro
	.set	reorder

	lbu	$2,3($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L972
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L957:
	lb	$3,0($5)
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L955
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L972:
	.set	noreorder
	.set	nomacro
	j	$L968
	sw	$2,0($7)
	.set	macro
	.set	reorder

$L955:
	sw	$0,0($7)
$L968:
	addu	$7,$7,4
	li	$2,277			# 0x00000115
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	sll	$2,$17,16
	sra	$2,$2,16
	addu	$2,$2,$18
	lbu	$2,788($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L961
	addu	$7,$7,4
	.set	macro
	.set	reorder

	lbu	$2,194($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L973
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L961:
	lb	$3,0($5)
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L959
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L973:
	.set	noreorder
	.set	nomacro
	j	$L969
	sw	$2,0($7)
	.set	macro
	.set	reorder

$L959:
	sw	$0,0($7)
$L969:
	addu	$7,$7,4
	li	$2,272			# 0x00000110
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,17($6)
	addu	$7,$7,4
	srl	$2,$2,2
	andi	$2,$2,0x0001
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,274			# 0x00000112
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,17($6)
	addu	$7,$7,4
	srl	$2,$2,1
	andi	$2,$2,0x0001
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,269			# 0x0000010d
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,17($6)
	addu	$7,$7,4
	andi	$2,$2,0x0001
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,268			# 0x0000010c
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	sw	$0,0($7)
	addu	$7,$7,4
	li	$2,290			# 0x00000122
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$3,197($5)
	addu	$7,$7,4
	sll	$3,$3,2
	addu	$3,$5,$3
	lw	$2,68($3)
	lbu	$4,70($3)
	andi	$3,$2,0xff00
	or	$4,$4,$3
	andi	$2,$2,0x00ff
	sll	$2,$2,16
	or	$4,$4,$2
	sw	$4,0($7)
	addu	$7,$7,4
	li	$2,291			# 0x00000123
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,707($16)
	#nop
	sll	$2,$2,2
	addu	$2,$5,$2
	lw	$2,148($2)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,292			# 0x00000124
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,197($5)
	#nop
	addu	$2,$5,$2
	lbu	$2,132($2)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,293			# 0x00000125
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,199($5)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$3,2($5)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L963
	addu	$7,$7,4
	.set	macro
	.set	reorder

	li	$2,261			# 0x00000105
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	.set	noreorder
	.set	nomacro
	j	$L970
	li	$2,65			# 0x00000041
	.set	macro
	.set	reorder

$L963:
	li	$2,261			# 0x00000105
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,1			# 0x00000001
$L970:
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,275			# 0x00000113
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,196($5)
	#nop
	andi	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L965
	addu	$7,$7,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L971
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L965:
	lbu	$2,6($5)
$L971:
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,263			# 0x00000107
	sw	$2,0($7)
	addu	$7,$7,4
	sll	$6,$17,16
	sra	$6,$6,16
	lh	$2,4($16)
	addu	$3,$6,$18
	sw	$2,0($7)
	lbu	$2,791($3)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,264			# 0x00000108
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	lbu	$2,793($3)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,265			# 0x00000109
	sw	$2,0($7)
	lh	$2,4($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	lbu	$2,795($3)
	addu	$4,$7,4
	sw	$2,0($7)
	lh	$5,4($16)
	.set	noreorder
	.set	nomacro
	jal	OutputDisplaySettings__FPiiiR17tTrackInformation
	addu	$7,$16,656
	.set	macro
	.set	reorder

	move	$7,$2
	addu	$2,$17,1
	move	$17,$2
	lhu	$3,4($16)
	sll	$2,$2,16
	addu	$3,$3,1
	sh	$3,4($16)
	lh	$3,6($16)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L974
	li	$2,281			# 0x00000119
	.set	macro
	.set	reorder

$L951:
	li	$2,29			# 0x0000001d
	sw	$2,0($7)
	lh	$2,6($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,30			# 0x0000001e
	sw	$2,0($7)
	lh	$2,416($16)
	addu	$7,$7,4
	sw	$2,0($7)
	addu	$7,$7,4
	li	$2,14			# 0x0000000e
	sw	$2,0($7)
	addu	$7,$7,4
	sw	$0,0($7)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$2,$7,4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Front_AppendPlayerCarData__FPiR9tFEStream
	.align	2
	.globl	Front_AppendOpponentData__FPiR9tFEStream
	.ent	Front_AppendOpponentData__FPiR9tFEStream
Front_AppendOpponentData__FPiR9tFEStream:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
 #APP
 #NO_APP
	lh	$2,416($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L976
	move	$19,$0
	.set	macro
	.set	reorder

$L977:
	sll	$2,$19,16
	sra	$2,$2,16
	lh	$3,6($18)
	lui	$4,%hi(carManager) # high
	addu	$2,$2,$3
	sll	$16,$2,2
	addu	$16,$16,$2
	sll	$16,$16,2
	addu	$16,$16,420
	addu	$16,$18,$16
	lh	$5,12($16)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	li	$3,281			# 0x00000119
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lb	$3,8($16)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,260			# 0x00000104
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,1($2)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,262			# 0x00000106
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,1			# 0x00000001
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,261			# 0x00000105
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,2			# 0x00000002
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,276			# 0x00000114
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lw	$3,4($16)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,280			# 0x00000118
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lw	$3,4($16)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,266			# 0x0000010a
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,16($16)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,267			# 0x0000010b
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$3,272			# 0x00000110
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,17($16)
	addu	$17,$17,4
	andi	$3,$3,0x0001
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,274			# 0x00000112
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,17($16)
	addu	$17,$17,4
	srl	$3,$3,1
	andi	$3,$3,0x0001
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,269			# 0x0000010d
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,17($16)
	addu	$17,$17,4
	srl	$3,$3,2
	andi	$3,$3,0x0001
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,268			# 0x0000010c
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$3,293			# 0x00000125
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$3,290			# 0x00000122
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$4,16($16)
	addu	$17,$17,4
	sll	$4,$4,2
	addu	$4,$2,$4
	lw	$3,68($4)
	lbu	$5,70($4)
	andi	$4,$3,0xff00
	or	$5,$5,$4
	andi	$3,$3,0x00ff
	sll	$3,$3,16
	or	$5,$5,$3
	sw	$5,0($17)
	addu	$17,$17,4
	li	$3,291			# 0x00000123
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	lbu	$3,707($18)
	#nop
	sll	$3,$3,2
	addu	$3,$2,$3
	lw	$3,148($3)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$17,$17,4
	li	$3,292			# 0x00000124
	sw	$3,0($17)
	lh	$3,4($18)
	addu	$17,$17,4
	sw	$3,0($17)
	addu	$3,$19,1
	move	$19,$3
	lbu	$4,16($16)
	addu	$17,$17,4
	addu	$2,$2,$4
	lbu	$2,132($2)
	sll	$3,$3,16
	sw	$2,0($17)
	lhu	$2,4($18)
	sra	$3,$3,16
	addu	$2,$2,1
	sh	$2,4($18)
	lh	$2,416($18)
	#nop
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L977
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L976:
	move	$2,$17
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

	.end	Front_AppendOpponentData__FPiR9tFEStream
	.align	2
	.globl	Front_AppendCopData__FPiR9tFEStream
	.ent	Front_AppendCopData__FPiR9tFEStream
Front_AppendCopData__FPiR9tFEStream:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lh	$2,540($17)
	lh	$3,542($17)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	blez	$2,$L982
	move	$16,$4
	.set	macro
	.set	reorder

	li	$2,12			# 0x0000000c
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,1			# 0x00000001
	sw	$2,0($16)
	addu	$16,$16,4
$L982:
	move	$19,$0
$L983:
	sll	$2,$19,16
	lh	$3,540($17)
	lh	$4,542($17)
	sra	$18,$2,16
	addu	$3,$3,$4
	slt	$3,$18,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L984
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	sll	$2,$18,2
	addu	$2,$17,$2
	lh	$5,544($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	li	$3,260			# 0x00000104
	sw	$3,0($16)
	addu	$16,$16,4
	lh	$3,4($17)
	li	$4,8			# 0x00000008
	sw	$3,0($16)
	lbu	$2,1($2)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,262			# 0x00000106
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,1			# 0x00000001
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,261			# 0x00000105
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	move	$3,$16
	lh	$2,542($17)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L987
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$4,16			# 0x00000010
$L987:
	li	$2,280			# 0x00000118
	sw	$4,0($3)
	sw	$2,0($16)
	addu	$16,$16,4
	lh	$2,4($17)
	addu	$19,$19,1
	sw	$2,0($16)
	lui	$2,%hi(frontEnd+6) # high
	lbu	$2,%lo(frontEnd+6)($2)
	addu	$16,$16,4
	addu	$2,$2,5
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,266			# 0x0000010a
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,267			# 0x0000010b
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,268			# 0x0000010c
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,293			# 0x00000125
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	sll	$2,$18,1
	addu	$2,$17,$2
	lh	$2,568($2)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,272			# 0x00000110
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,274			# 0x00000112
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,269			# 0x0000010d
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	lhu	$2,4($17)
	addu	$16,$16,4
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L983
	sh	$2,4($17)
	.set	macro
	.set	reorder

$L984:
	move	$2,$16
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

	.end	Front_AppendCopData__FPiR9tFEStream
	.align	2
	.globl	Front_AppendPerpData__FPiR9tFEStream
	.ent	Front_AppendPerpData__FPiR9tFEStream
Front_AppendPerpData__FPiR9tFEStream:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$5
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,600($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L989
	move	$17,$4
	.set	macro
	.set	reorder

	li	$2,37			# 0x00000025
	sw	$2,0($17)
	lw	$2,600($18)
	#nop
	lbu	$2,10($2)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,38			# 0x00000026
	sw	$2,0($17)
	lw	$2,600($18)
	#nop
	lhu	$2,8($2)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L996
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L989:
	li	$2,37			# 0x00000025
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,38			# 0x00000026
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
$L996:
	addu	$17,$17,4
	lh	$2,594($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L991
	move	$19,$0
	.set	macro
	.set	reorder

	li	$20,1			# 0x00000001
$L992:
	lui	$4,%hi(carManager) # high
	sll	$16,$19,16
	sra	$16,$16,13
	addu	$16,$18,$16
	lh	$5,608($16)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	li	$3,260			# 0x00000104
	sw	$3,0($17)
	addu	$17,$17,4
	addu	$4,$19,1
	move	$19,$4
	lh	$3,4($18)
	sll	$4,$4,16
	sw	$3,0($17)
	lbu	$2,1($2)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,262			# 0x00000106
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$20,0($17)
	addu	$17,$17,4
	li	$2,266			# 0x0000010a
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	lbu	$2,612($16)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,267			# 0x0000010b
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,261			# 0x00000105
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,2			# 0x00000002
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,280			# 0x00000118
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,268			# 0x0000010c
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$20,0($17)
	addu	$17,$17,4
	li	$2,293			# 0x00000125
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,272			# 0x00000110
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,274			# 0x00000112
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	addu	$17,$17,4
	li	$2,269			# 0x0000010d
	sw	$2,0($17)
	lh	$2,4($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$0,0($17)
	lhu	$2,4($18)
	sra	$4,$4,16
	addu	$2,$2,1
	sh	$2,4($18)
	lh	$2,594($18)
	#nop
	slt	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L992
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L991:
	li	$2,37			# 0x00000025
	sw	$2,0($17)
	addu	$17,$17,4
	lh	$3,596($18)
	addu	$2,$17,4
	sw	$3,0($17)
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

	.end	Front_AppendPerpData__FPiR9tFEStream
	.align	2
	.globl	Front_AppendTrafficData__FPiR9tFEStream
	.ent	Front_AppendTrafficData__FPiR9tFEStream
Front_AppendTrafficData__FPiR9tFEStream:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	lh	$2,580($17)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L998
	move	$18,$0
	.set	macro
	.set	reorder

	li	$19,1			# 0x00000001
$L999:
	lui	$4,%hi(carManager) # high
	sll	$2,$18,16
	sra	$2,$2,15
	addu	$2,$17,$2
	lh	$5,582($2)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	addiu	$4,$4,%lo(carManager) # low
	.set	macro
	.set	reorder

	li	$3,260			# 0x00000104
	sw	$3,0($16)
	addu	$16,$16,4
	addu	$4,$18,1
	move	$18,$4
	lh	$3,4($17)
	sll	$4,$4,16
	sw	$3,0($16)
	lbu	$2,1($2)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,262			# 0x00000106
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$19,0($16)
	addu	$16,$16,4
	li	$2,266			# 0x0000010a
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,267			# 0x0000010b
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,261			# 0x00000105
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,4			# 0x00000004
	sw	$2,0($16)
	addu	$16,$16,$2
	li	$2,280			# 0x00000118
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,8			# 0x00000008
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,268			# 0x0000010c
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$19,0($16)
	addu	$16,$16,4
	li	$2,293			# 0x00000125
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,272			# 0x00000110
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,274			# 0x00000112
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,269			# 0x0000010d
	sw	$2,0($16)
	lh	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	lhu	$2,4($17)
	sra	$4,$4,16
	addu	$2,$2,1
	sh	$2,4($17)
	lh	$2,580($17)
	#nop
	slt	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L999
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L998:
	li	$4,1431633920			# 0x55550000
	lhu	$2,580($17)
	ori	$4,$4,0x5556
	sll	$2,$2,16
	sra	$3,$2,16
	mult	$3,$4
	sra	$2,$2,31
	mfhi	$6
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L1003
	subu	$4,$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$4,$L1004
	move	$2,$4
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L1004:
	move	$4,$2
$L1003:
	li	$2,13			# 0x0000000d
	sw	$2,0($16)
	addu	$16,$16,4
	addu	$2,$16,4
	sw	$4,0($16)
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

	.end	Front_AppendTrafficData__FPiR9tFEStream
	.align	2
	.globl	Front_AppendTrackData__FPiR9tFEStream
	.ent	Front_AppendTrackData__FPiR9tFEStream
Front_AppendTrackData__FPiR9tFEStream:
	.frame	$sp,80,$31		# vars= 48, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$17,68($sp)
	move	$17,$4
	sw	$18,72($sp)
	move	$18,$5
	sw	$16,64($sp)
	lui	$16,%hi(frontEnd) # high
	addiu	$16,$16,%lo(frontEnd) # low
	lui	$4,%hi(trackManager) # high
	sw	$31,76($sp)
	lbu	$2,70($16)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$16
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$3,800($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1007
	move	$4,$0
	.set	macro
	.set	reorder

	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1009
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1011
	lui	$3,%hi(CountryMeasurement) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1007
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

$L1009:
	lui	$3,%hi(CountryMeasurement) # high
$L1011:
	lbu	$2,58($sp)
	addiu	$3,$3,%lo(CountryMeasurement) # low
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$4,0($2)
$L1007:
	li	$2,26			# 0x0000001a
	sw	$2,0($17)
	addu	$17,$17,4
	sw	$4,0($17)
	addu	$17,$17,4
	li	$2,24			# 0x00000018
	sw	$2,0($17)
	lbu	$2,706($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,25			# 0x00000019
	sw	$2,0($17)
	lbu	$2,705($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,20			# 0x00000014
	sw	$2,0($17)
	lbu	$2,708($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,23			# 0x00000017
	sw	$2,0($17)
	lbu	$2,707($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,18			# 0x00000012
	sw	$2,0($17)
	lbu	$2,657($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$17,$17,4
	li	$2,11			# 0x0000000b
	sw	$2,0($17)
	lw	$2,736($18)
	addu	$17,$17,4
	sw	$2,0($17)
	addu	$2,$17,4
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

	.end	Front_AppendTrackData__FPiR9tFEStream
	.align	2
	.globl	Front_EnableLocalSpeech__Fv
	.ent	Front_EnableLocalSpeech__Fv
Front_EnableLocalSpeech__Fv:
	.frame	$sp,80,$31		# vars= 48, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$17,68($sp)
	lui	$2,%hi(frontEnd) # high
	sw	$16,64($sp)
	addiu	$16,$2,%lo(frontEnd) # low
	sw	$31,72($sp)
	lbu	$3,4($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1013
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(trackManager) # high
	lbu	$2,70($16)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$16
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$3,43($sp)
	lbu	$2,832($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1016
	move	$2,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$3,$L1013
	slt	$2,$3,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1015
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1016
	move	$2,$17
	.set	macro
	.set	reorder

$L1015:
	li	$17,1			# 0x00000001
$L1013:
	move	$2,$17
$L1016:
	lw	$31,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Front_EnableLocalSpeech__Fv
	.align	2
	.globl	Front_BuildStream__FPi
	.ent	Front_BuildStream__FPi
Front_BuildStream__FPi:
	.frame	$sp,784,$31		# vars= 744, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,784
	sw	$19,772($sp)
	move	$19,$4
	addu	$4,$sp,16
	sw	$31,780($sp)
	sw	$20,776($sp)
	sw	$18,768($sp)
	sw	$17,764($sp)
	.set	noreorder
	.set	nomacro
	jal	Front_InitStream__FR9tFEStream
	sw	$16,760($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitPlayerCars__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitTrack__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitTourneyTraffic__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitOpponentCars__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitMissions__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitCopCars__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitPerps__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_InitTraffic__FR9tFEStream
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(ticks) # high
	#.set	volatile
	lw	$3,%lo(ticks)($2)
	#.set	novolatile
	lui	$2,%hi(frontEnd) # high
	sll	$4,$3,16
	sra	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	seedrandom
	sh	$3,%lo(frontEnd)($2)
	.set	macro
	.set	reorder

	li	$3,7			# 0x00000007
	lui	$2,%hi(colourChosen) # high
	addiu	$2,$2,%lo(colourChosen) # low
	addu	$2,$2,28
$L1021:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1021
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Controller_SetRamp__Fv
	addu	$16,$19,212
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	resizememadr
	li	$5,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,52			# 0x00000034
	lui	$5,%hi(frontEnd) # high
	addiu	$3,$5,%lo(frontEnd) # low
	sw	$2,0($19)
	lbu	$4,866($3)
	li	$2,53			# 0x00000035
	sw	$2,8($19)
	sw	$4,4($19)
	lbu	$4,843($3)
	li	$2,54			# 0x00000036
	sw	$2,16($19)
	sw	$4,12($19)
	lbu	$4,841($3)
	li	$2,55			# 0x00000037
	sw	$2,24($19)
	sw	$4,20($19)
	lbu	$4,847($3)
	li	$2,56			# 0x00000038
	sw	$2,32($19)
	sw	$4,28($19)
	lbu	$4,845($3)
	li	$2,57			# 0x00000039
	sw	$2,40($19)
	sw	$4,36($19)
	lbu	$4,849($3)
	li	$2,58			# 0x0000003a
	sw	$2,48($19)
	sw	$4,44($19)
	lbu	$4,851($3)
	li	$2,59			# 0x0000003b
	sw	$2,56($19)
	sw	$4,52($19)
	lbu	$4,853($3)
	li	$2,60			# 0x0000003c
	sw	$2,64($19)
	sw	$4,60($19)
	lbu	$4,855($3)
	li	$2,61			# 0x0000003d
	sw	$2,72($19)
	sw	$4,68($19)
	lbu	$4,857($3)
	li	$2,62			# 0x0000003e
	sw	$2,80($19)
	sw	$4,76($19)
	lbu	$2,859($3)
	#nop
	sw	$2,84($19)
	li	$2,63			# 0x0000003f
	sw	$2,88($19)
	lbu	$4,867($3)
	li	$2,64			# 0x00000040
	sw	$2,96($19)
	sw	$4,92($19)
	lbu	$4,844($3)
	li	$2,65			# 0x00000041
	sw	$2,104($19)
	sw	$4,100($19)
	lbu	$4,842($3)
	li	$2,66			# 0x00000042
	sw	$2,112($19)
	sw	$4,108($19)
	lbu	$4,848($3)
	li	$2,67			# 0x00000043
	sw	$2,120($19)
	sw	$4,116($19)
	lbu	$4,846($3)
	li	$2,68			# 0x00000044
	sw	$2,128($19)
	sw	$4,124($19)
	lbu	$4,850($3)
	li	$2,69			# 0x00000045
	sw	$2,136($19)
	sw	$4,132($19)
	lbu	$4,852($3)
	li	$2,70			# 0x00000046
	sw	$2,144($19)
	sw	$4,140($19)
	lbu	$4,854($3)
	li	$2,71			# 0x00000047
	sw	$2,152($19)
	sw	$4,148($19)
	lbu	$4,856($3)
	li	$2,72			# 0x00000048
	sw	$2,160($19)
	sw	$4,156($19)
	lbu	$4,858($3)
	li	$2,73			# 0x00000049
	sw	$2,168($19)
	sw	$4,164($19)
	lbu	$4,860($3)
	li	$2,33			# 0x00000021
	sw	$2,176($19)
	li	$2,-1			# 0xffffffff
	sw	$4,172($19)
	sw	$2,180($19)
	li	$2,3			# 0x00000003
	sw	$2,184($19)
	li	$2,1			# 0x00000001
	sw	$2,188($19)
	li	$2,27			# 0x0000001b
	sw	$2,192($19)
	lh	$4,%lo(frontEnd)($5)
	li	$2,74			# 0x0000004a
	sw	$2,200($19)
	li	$2,36			# 0x00000024
	sw	$0,204($19)
	sw	$2,208($19)
	sw	$4,196($19)
	lbu	$18,832($3)
	lbu	$2,33($3)
	lbu	$17,699($sp)
	beq	$2,$0,$L1023
	jal	Front_EnableLocalSpeech__Fv
	beq	$2,$0,$L1023
	sw	$17,212($19)
	.set	noreorder
	.set	nomacro
	j	$L1024
	addu	$16,$19,216
	.set	macro
	.set	reorder

$L1023:
	sw	$18,0($16)
	addu	$16,$16,4
$L1024:
	li	$2,39			# 0x00000027
	sw	$2,0($16)
	addu	$16,$16,4
	lui	$2,%hi(frontEnd) # high
	addiu	$17,$2,%lo(frontEnd) # low
	lbu	$2,832($17)
	addu	$5,$sp,16
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,40			# 0x00000028
	sw	$2,0($16)
	lbu	$2,799($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,17			# 0x00000011
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,9			# 0x00000009
	sw	$2,0($16)
	lbu	$2,6($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,10			# 0x0000000a
	sw	$2,0($16)
	lbu	$2,3($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,7			# 0x00000007
	sw	$2,0($16)
	lbu	$2,4($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,277			# 0x00000115
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,279			# 0x00000117
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,15			# 0x0000000f
	sw	$2,0($16)
	addu	$16,$16,4
	lbu	$2,7($17)
	addu	$4,$16,4
	.set	noreorder
	.set	nomacro
	jal	Front_AppendTrackData__FPiR9tFEStream
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$16,$2
	li	$2,19			# 0x00000013
	sw	$2,0($16)
	lbu	$2,839($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,42			# 0x0000002a
	sw	$2,0($16)
	lbu	$2,838($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,43			# 0x0000002b
	sw	$2,0($16)
	lbu	$2,833($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,44			# 0x0000002c
	sw	$2,0($16)
	lbu	$2,834($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,45			# 0x0000002d
	sw	$2,0($16)
	lbu	$2,836($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,46			# 0x0000002e
	sw	$2,0($16)
	lbu	$2,835($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,47			# 0x0000002f
	sw	$2,0($16)
	lbu	$2,837($17)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,22			# 0x00000016
	sw	$2,0($16)
	lb	$3,24($sp)
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1025
	addu	$16,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1082
	sw	$0,0($16)
	.set	macro
	.set	reorder

$L1025:
	lbu	$3,4($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L1027
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,790($17)
	.set	noreorder
	.set	nomacro
	j	$L1082
	sw	$2,0($16)
	.set	macro
	.set	reorder

$L1027:
	sw	$2,0($16)
$L1082:
	addu	$16,$16,4
	move	$5,$0
	move	$3,$5
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
$L1032:
	lw	$2,924($4)
	#nop
	beq	$2,$0,$L1031
	addu	$5,$5,1
$L1031:
	addu	$3,$3,1
	slt	$2,$3,40
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1032
	addu	$4,$4,4
	.set	macro
	.set	reorder

	li	$2,48			# 0x00000030
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$5,0($16)
	addu	$16,$16,4
	li	$2,76			# 0x0000004c
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$5,0($16)
	addu	$16,$16,4
	move	$3,$0
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
$L1038:
	lw	$2,924($4)
	#nop
	beq	$2,$0,$L1037
	sw	$3,0($16)
	addu	$16,$16,4
$L1037:
	addu	$3,$3,1
	slt	$2,$3,40
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1038
	addu	$4,$4,4
	.set	macro
	.set	reorder

	li	$2,41			# 0x00000029
	sw	$2,0($16)
	lb	$4,720($sp)
	.set	noreorder
	.set	nomacro
	jal	Stattool_ReturnRecordLapTime__Fs
	addu	$16,$16,4
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,8			# 0x00000008
	sw	$2,0($16)
	lui	$2,%hi(frontEnd) # high
	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1041
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lbu	$2,298($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1084
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1041:
	jal	Front_GetLapsForType__Fv
$L1084:
	sw	$2,0($16)
	lbu	$2,26($sp)
	li	$3,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L1044
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lbu	$2,230($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L1044
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	addiu	$3,$2,%lo(frontEnd) # low
	lbu	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1085
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	lbu	$2,798($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1085
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	lbu	$2,3($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1043
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

$L1044:
	li	$2,32			# 0x00000020
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,50			# 0x00000032
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,51			# 0x00000033
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	.set	noreorder
	.set	nomacro
	j	$L1045
	addu	$16,$16,4
	.set	macro
	.set	reorder

$L1043:
$L1085:
	lui	$3,%hi(frontEnd) # high
	addiu	$3,$3,%lo(frontEnd) # low
	sw	$2,0($16)
	lbu	$2,918($3)
	addu	$16,$16,4
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,50			# 0x00000032
	sw	$2,0($16)
	addu	$16,$16,4
	move	$4,$16
	lbu	$3,919($3)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1046
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lui	$2,%hi(CountryMeasurement) # high
	lbu	$3,714($sp)
	addiu	$2,$2,%lo(CountryMeasurement) # low
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1047
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1047
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L1046:
	move	$3,$0
$L1047:
	li	$2,51			# 0x00000033
	sw	$3,0($4)
	sw	$2,0($16)
	addu	$16,$16,4
	move	$4,$16
	lui	$2,%hi(frontEnd+920) # high
	lbu	$3,%lo(frontEnd+920)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1050
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lui	$2,%hi(CountryMeasurement) # high
	lbu	$3,714($sp)
	addiu	$2,$2,%lo(CountryMeasurement) # low
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1051
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1051
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L1050:
	move	$3,$0
$L1051:
	sw	$3,0($4)
$L1045:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	Front_AppendPlayerCarData__FPiR9tFEStream
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	Front_AppendOpponentData__FPiR9tFEStream
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	Front_AppendPerpData__FPiR9tFEStream
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	Front_AppendCopData__FPiR9tFEStream
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	Front_AppendTrafficData__FPiR9tFEStream
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$16,$2
	li	$2,28			# 0x0000001c
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,1			# 0x00000001
	lh	$2,22($sp)
	lh	$3,432($sp)
	move	$5,$0
	addu	$2,$2,$3
	lh	$3,556($sp)
	lh	$6,558($sp)
	addu	$2,$2,$3
	addu	$2,$2,$6
	lh	$3,610($sp)
	lh	$6,596($sp)
	addu	$2,$2,$3
	addu	$2,$2,$6
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,229			# 0x000000e5
	sw	$2,0($16)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	addu	$16,$16,4
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,235			# 0x000000eb
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,232			# 0x000000e8
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,128			# 0x00000080
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,233			# 0x000000e9
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,230			# 0x000000e6
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,231			# 0x000000e7
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,234			# 0x000000ea
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,16384			# 0x00004000
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	lbu	$20,866($2)
	lh	$18,862($2)
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L1054
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$2,83			# 0x00000053
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L1058
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1055
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L1058:
	.set	noreorder
	.set	nomacro
	j	$L1055
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1054:
	move	$2,$0
$L1055:
	move	$18,$2
	li	$2,79			# 0x0000004f
	sw	$2,0($16)
	addu	$16,$16,4
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$20,2
	addu	$2,$2,$20
	sll	$2,$2,3
	subu	$2,$2,$20
	addu	$2,$2,$18
	sll	$2,$2,2
	addu	$17,$2,$3
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,80			# 0x00000050
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,12($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,81			# 0x00000051
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,24($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,82			# 0x00000052
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,36($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,251			# 0x000000fb
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,96($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,83			# 0x00000053
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,48($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,102			# 0x00000066
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,60($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,103			# 0x00000067
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,72($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,104			# 0x00000068
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,144($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lbu	$2,723($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1059
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$2,115			# 0x00000073
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,108($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,84			# 0x00000054
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1061
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1061
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

$L1059:
	li	$2,115			# 0x00000073
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,84			# 0x00000054
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	lw	$4,108($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1061
	addu	$16,$16,4
	.set	macro
	.set	reorder

	ori	$4,$4,0x0006
$L1061:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,77			# 0x0000004d
	sw	$2,0($16)
	addu	$16,$16,4
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$20,2
	addu	$2,$2,$20
	sll	$2,$2,3
	subu	$2,$2,$20
	addu	$2,$2,$18
	sll	$2,$2,2
	addu	$17,$2,$3
	lw	$4,132($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,117			# 0x00000075
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,84($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,101			# 0x00000065
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,84($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,133			# 0x00000085
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lbu	$3,26($sp)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1063
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+3) # high
	lbu	$2,%lo(frontEnd+3)($2)
	li	$20,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$20,$L1064
	li	$2,122			# 0x0000007a
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,32768			# 0x00008000
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,123			# 0x0000007b
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,8192			# 0x00002000
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,124			# 0x0000007c
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
$L1064:
	li	$2,129			# 0x00000081
	sw	$2,0($16)
	lw	$4,120($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$20,$L1066
	addu	$16,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1066
	ori	$4,$4,0x0006
	.set	macro
	.set	reorder

$L1063:
	li	$2,130			# 0x00000082
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	lw	$4,120($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1067
	addu	$16,$16,4
	.set	macro
	.set	reorder

	ori	$4,$4,0x0006
$L1067:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,125			# 0x0000007d
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,126			# 0x0000007e
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,12($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,129			# 0x00000081
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,64			# 0x00000040
$L1066:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	move	$5,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lui	$2,%hi(frontEnd) # high
	addiu	$4,$2,%lo(frontEnd) # low
	lbu	$3,3($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1068
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$2,35			# 0x00000023
	lh	$18,864($4)
	lbu	$20,867($4)
	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L1069
	li	$2,83			# 0x00000053
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$2,$L1073
	li	$2,115			# 0x00000073
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1070
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L1073:
	.set	noreorder
	.set	nomacro
	j	$L1070
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1069:
	move	$2,$0
$L1070:
	move	$18,$2
	li	$2,155			# 0x0000009b
	sw	$2,0($16)
	addu	$16,$16,4
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$20,2
	addu	$2,$2,$20
	sll	$2,$2,3
	subu	$2,$2,$20
	addu	$2,$2,$18
	sll	$2,$2,2
	addu	$17,$2,$3
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,156			# 0x0000009c
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,12($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,157			# 0x0000009d
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,24($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,158			# 0x0000009e
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,36($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,252			# 0x000000fc
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,96($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,159			# 0x0000009f
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,48($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,178			# 0x000000b2
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,60($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,179			# 0x000000b3
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,72($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,180			# 0x000000b4
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,144($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lbu	$2,723($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1074
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$2,191			# 0x000000bf
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,108($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,160			# 0x000000a0
	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1076
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1076
	li	$4,6			# 0x00000006
	.set	macro
	.set	reorder

$L1074:
	li	$2,191			# 0x000000bf
	sw	$2,0($16)
	addu	$16,$16,4
	sw	$0,0($16)
	addu	$16,$16,4
	li	$2,160			# 0x000000a0
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	lw	$4,108($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1076
	addu	$16,$16,4
	.set	macro
	.set	reorder

	ori	$4,$4,0x0006
$L1076:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,153			# 0x00000099
	sw	$2,0($16)
	addu	$16,$16,4
	lui	$3,%hi(mappings) # high
	addiu	$3,$3,%lo(mappings) # low
	sll	$2,$20,2
	addu	$2,$2,$20
	sll	$2,$2,3
	subu	$2,$2,$20
	addu	$2,$2,$18
	sll	$2,$2,2
	addu	$17,$2,$3
	lw	$4,132($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,193			# 0x000000c1
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,84($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,177			# 0x000000b1
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,84($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,209			# 0x000000d1
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,2048			# 0x00000800
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	lbu	$3,230($sp)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1078
	addu	$16,$16,4
	.set	macro
	.set	reorder

	li	$2,205			# 0x000000cd
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	lw	$4,120($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1080
	addu	$16,$16,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1080
	ori	$4,$4,0x0006
	.set	macro
	.set	reorder

$L1078:
	li	$2,206			# 0x000000ce
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	lw	$4,120($17)
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L1081
	addu	$16,$16,4
	.set	macro
	.set	reorder

	ori	$4,$4,0x0006
$L1081:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,201			# 0x000000c9
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,202			# 0x000000ca
	sw	$2,0($16)
	addu	$16,$16,4
	lw	$4,12($17)
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
	li	$2,205			# 0x000000cd
	sw	$2,0($16)
	addu	$16,$16,4
	li	$4,64			# 0x00000040
$L1080:
	.set	noreorder
	.set	nomacro
	jal	GetPSXPadValue__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($16)
	addu	$16,$16,4
$L1068:
	sw	$0,0($16)
	addu	$16,$16,4
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	resizememadr
	subu	$5,$16,$19
	.set	macro
	.set	reorder

	move	$2,$19
	lw	$31,780($sp)
	lw	$20,776($sp)
	lw	$19,772($sp)
	lw	$18,768($sp)
	lw	$17,764($sp)
	lw	$16,760($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,784
	.set	macro
	.set	reorder

	.end	Front_BuildStream__FPi
	.align	2
	.globl	Front_GetInGameVars__Fv
	.ent	Front_GetInGameVars__Fv
Front_GetInGameVars__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(frontEnd) # high
	lui	$2,%hi(gMasterMusicLevel) # high
	lbu	$2,%lo(gMasterMusicLevel)($2)
	addiu	$16,$16,%lo(frontEnd) # low
	sw	$31,20($sp)
	sb	$2,833($16)
	andi	$2,$2,0x00ff
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,6
	.set	macro
	.set	reorder

	move	$9,$0
	lui	$3,%hi(gMasterSFXLevel) # high
	lui	$4,%hi(gMasterEngineLevel) # high
	lui	$5,%hi(gMasterFENarrationLevel) # high
	lui	$6,%hi(gMasterAmbientLevel) # high
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	lbu	$3,%lo(gMasterSFXLevel)($3)
	lbu	$4,%lo(gMasterEngineLevel)($4)
	lbu	$5,%lo(gMasterFENarrationLevel)($5)
	lbu	$6,%lo(gMasterAmbientLevel)($6)
	lhu	$7,184($2)
	move	$8,$2
	sb	$3,834($16)
	sb	$4,836($16)
	sb	$5,835($16)
	sb	$6,837($16)
	sh	$7,90($16)
$L1087:
	lbu	$2,96($8)
	addu	$3,$9,$16
	sb	$2,866($3)
	lbu	$2,104($8)
	#nop
	sb	$2,843($3)
	lbu	$2,112($8)
	#nop
	sb	$2,841($3)
	lbu	$2,120($8)
	#nop
	sb	$2,847($3)
	lbu	$2,128($8)
	#nop
	sb	$2,845($3)
	lbu	$2,168($8)
	addu	$9,$9,1
	sb	$2,857($3)
	lbu	$2,176($8)
	#nop
	sb	$2,859($3)
	slt	$2,$9,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1087
	addu	$8,$8,4
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

	.end	Front_GetInGameVars__Fv
	.align	2
	.globl	SetLicensePlate__Fv
	.ent	SetLicensePlate__Fv
SetLicensePlate__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$0
	lui	$2,%hi(frontEnd+900) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(frontEnd+900) # low
	sw	$31,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sll	$17,$18,16
$L1096:
	sra	$17,$17,16
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	sll	$16,$17,3
	addu	$16,$16,$19
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CarIO_CleanUpLicense__Fi
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CarIO_CreateLicense__FPcii
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1096
	sll	$17,$18,16
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

	.end	SetLicensePlate__Fv
	.rdata
	.align	2
$LC1:
	.ascii	"ymus\000"
	.align	2
$LC2:
	.ascii	"game*\000"
	.align	2
$LC3:
	.ascii	"amus\000"
	.text
	.align	2
	.globl	SetPlayList__Fi
	.ent	SetPlayList__Fi
SetPlayList__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysCleanUp__Fv
	move	$16,$4
	.set	macro
	.set	reorder

	li	$4,49152			# 0x0000c000
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x8000
	lui	$6,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC1) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	.set	noreorder
	.set	nomacro
	jal	AudioMus_GetSongList__FPci
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L1098
	move	$4,$2
	.set	macro
	.set	reorder

	li	$3,39			# 0x00000027
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	addu	$2,$2,156
$L1099:
	sw	$0,924($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1099
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1098
	move	$3,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd) # high
	addiu	$7,$2,%lo(frontEnd) # low
	li	$6,1			# 0x00000001
	move	$5,$4
$L1104:
	lw	$2,36($5)
	#nop
	sll	$2,$2,2
	addu	$2,$2,$7
	sw	$6,924($2)
	lw	$2,0($4)
	addu	$3,$3,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1104
	addu	$5,$5,64
	.set	macro
	.set	reorder

$L1098:
	lui	$2,%hi(frontEnd+1092) # high
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$3,%lo(frontEnd+1092)($2)
	.set	macro
	.set	reorder

	jal	AudioMus_SysCleanUp__Fv
	li	$4,55296			# 0x0000d800
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x8000
	lui	$6,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC3) # low
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

	.end	SetPlayList__Fi
	.align	2
	.globl	Front_GetTrackRaced__Fv
	.ent	Front_GetTrackRaced__Fv
Front_GetTrackRaced__Fv:
	.frame	$sp,72,$31		# vars= 48, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	lui	$2,%hi(frontEnd) # high
	addiu	$5,$2,%lo(frontEnd) # low
	sw	$31,64($sp)
	lbu	$3,4($5)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1109
	lui	$4,%hi(trackManager) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(tournamentManager) # high
	.set	noreorder
	.set	nomacro
	jal	GetLastTrackRaced__18tTournamentManager
	addiu	$4,$4,%lo(tournamentManager) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1111
	sll	$2,$2,16
	.set	macro
	.set	reorder

$L1109:
	lbu	$2,70($5)
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$2,$5
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,16($sp)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$2,$2,16
$L1111:
	lw	$31,64($sp)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Front_GetTrackRaced__Fv
	.align	2
	.globl	PlayerNameExist__Fi
	.ent	PlayerNameExist__Fi
PlayerNameExist__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sll	$2,$4,3
	lui	$4,%hi(frontEnd+868) # high
	addiu	$4,$4,%lo(frontEnd+868) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PlayerNameExist__Fi
	.align	2
	.globl	PlayerName__Fi
	.ent	PlayerName__Fi
PlayerName__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sll	$5,$18,3
	lui	$2,%hi(frontEnd+884) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(frontEnd+884) # low
	sw	$16,16($sp)
	addu	$16,$5,$17
	move	$4,$16
	addu	$2,$17,-16
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$5,$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1114
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1116
	move	$2,$16
	.set	macro
	.set	reorder

$L1114:
	lbu	$3,-881($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1115
	li	$4,78			# 0x0000004e
	.set	macro
	.set	reorder

	addu	$4,$18,80
$L1115:
	jal	TextSys_Word__Fi
$L1116:
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

	.end	PlayerName__Fi
	.align	2
	.globl	PlayerNameMixedCase__Fi
	.ent	PlayerNameMixedCase__Fi
PlayerNameMixedCase__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sll	$3,$18,3
	lui	$2,%hi(frontEnd+868) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(frontEnd+868) # low
	sw	$16,16($sp)
	addu	$16,$3,$17
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1120
	move	$2,$16
	.set	macro
	.set	reorder

	lbu	$3,-865($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L1119
	li	$4,78			# 0x0000004e
	.set	macro
	.set	reorder

	addu	$4,$18,80
$L1119:
	jal	TextSys_Word__Fi
$L1120:
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

	.end	PlayerNameMixedCase__Fi
	.align	2
	.globl	__11tAllScreens
	.ent	__11tAllScreens
__11tAllScreens:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$23,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$17,1464
	lui	$2,%hi(tScreenMain_vtable) # high
	addiu	$2,$2,%lo(tScreenMain_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	sw	$2,96($17)
	.set	macro
	.set	reorder

	addu	$16,$17,2392
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$18,$17,3368
	move	$4,$18
	lui	$2,%hi(tScreenCarSelectDuel_vtable) # high
	addiu	$2,$2,%lo(tScreenCarSelectDuel_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	sw	$2,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,4296
	move	$4,$16
	la	$5,tScreenCarSelectTwoPlayer_vtable
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$5,96($18)
	.set	macro
	.set	reorder

	addu	$18,$17,4448
	move	$4,$18
	lui	$23,%hi(tDialogBase_vtable) # high
	addiu	$23,$23,%lo(tDialogBase_vtable) # low
	li	$5,288			# 0x00000120
	sh	$5,128($16)
	li	$5,-1			# 0xffffffff
	lui	$20,%hi(tDialogMessageString_vtable) # high
	addiu	$20,$20,%lo(tDialogMessageString_vtable) # low
	li	$fp,128			# 0x00000080
	lui	$19,%hi(tDialogBackUpOnly_vtable) # high
	addiu	$19,$19,%lo(tDialogBackUpOnly_vtable) # low
	sw	$23,96($16)
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$5,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$20,96($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	sw	$fp,140($16)
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	sw	$19,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,5376
	move	$4,$16
	la	$5,tScreenCarSelectTwoPlayer_vtable
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$5,96($18)
	.set	macro
	.set	reorder

	addu	$21,$17,5528
	move	$4,$21
	li	$5,288			# 0x00000120
	sh	$5,128($16)
	li	$5,-1			# 0xffffffff
	sw	$23,96($16)
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$5,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$20,96($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	sw	$fp,140($16)
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	sw	$19,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,6456
	move	$4,$16
	la	$5,tScreenCarSelectTwoPlayer_vtable
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$5,96($21)
	.set	macro
	.set	reorder

	addu	$22,$17,6628
	move	$4,$22
	li	$5,288			# 0x00000120
	sh	$5,128($16)
	li	$5,-1			# 0xffffffff
	lui	$18,%hi(tScreenPinkSlipsCarSelect_vtable) # high
	addiu	$18,$18,%lo(tScreenPinkSlipsCarSelect_vtable) # low
	sw	$23,96($16)
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$5,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$20,96($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	sw	$fp,140($16)
	sw	$19,96($16)
	.set	noreorder
	.set	nomacro
	jal	__16tScreenCarSelect
	sw	$18,96($21)
	.set	macro
	.set	reorder

	addu	$16,$17,7556
	move	$4,$16
	la	$5,tScreenCarSelectTwoPlayer_vtable
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$5,96($22)
	.set	macro
	.set	reorder

	addu	$21,$17,7728
	move	$4,$21
	li	$5,288			# 0x00000120
	sh	$5,128($16)
	li	$5,-1			# 0xffffffff
	sw	$23,96($16)
	sw	$0,112($16)
	sh	$0,110($16)
	sh	$0,130($16)
	sh	$0,126($16)
	sh	$0,124($16)
	sh	$0,108($16)
	sh	$0,106($16)
	sh	$0,104($16)
	sh	$0,102($16)
	sh	$5,100($16)
	sh	$0,136($16)
	sw	$0,120($16)
	sw	$20,96($16)
	sw	$0,148($16)
	sw	$0,132($16)
	sw	$0,120($16)
	sw	$fp,140($16)
	sw	$19,96($16)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$18,96($22)
	.set	macro
	.set	reorder

	addu	$18,$17,7844
	move	$4,$18
	lui	$2,%hi(tScreenTrackRecords_vtable) # high
	addiu	$2,$2,%lo(tScreenTrackRecords_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,96($21)
	.set	macro
	.set	reorder

	addu	$16,$17,8520
	move	$4,$16
	lui	$2,%hi(tScreenTrackInfo_vtable) # high
	addiu	$2,$2,%lo(tScreenTrackInfo_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,96($18)
	.set	macro
	.set	reorder

	addu	$4,$17,9192
	lui	$2,%hi(tScreenTrackSelect_vtable) # high
	addiu	$2,$2,%lo(tScreenTrackSelect_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__18tScreenTournSelect
	sw	$2,96($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__26tScreenTournamentStandings
	addu	$4,$17,9904
	.set	macro
	.set	reorder

	addu	$16,$17,10052
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$17,10444
	lui	$2,%hi(tScreenTournamentTrophy_vtable) # high
	addiu	$2,$2,%lo(tScreenTournamentTrophy_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__17tScreenTrophyRoom
	sw	$2,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,10788
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$17,10892
	lui	$2,%hi(tScreenTrophyInfo_vtable) # high
	addiu	$2,$2,%lo(tScreenTrophyInfo_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__23tScreenControllerConfig
	sw	$2,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,11272
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$17,11372
	lui	$2,%hi(tScreenDisplay_vtable) # high
	addiu	$2,$2,%lo(tScreenDisplay_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__12tScreenAudio
	sw	$2,96($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__14tScreenMemcard
	addu	$4,$17,11496
	.set	macro
	.set	reorder

	addu	$16,$17,12940
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$18,$17,13144
	move	$4,$18
	lui	$2,%hi(tScreenUserName_vtable) # high
	addiu	$2,$2,%lo(tScreenUserName_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,96($16)
	.set	macro
	.set	reorder

	addu	$16,$17,13536
	move	$4,$16
	lui	$2,%hi(tScreenPinkSlipCongrats_vtable) # high
	addiu	$2,$2,%lo(tScreenPinkSlipCongrats_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__26tScreenTournamentStandings
	sw	$2,96($18)
	.set	macro
	.set	reorder

	addu	$19,$17,13684
	move	$4,$19
	lui	$2,%hi(tScreenPinkSlipStandings_vtable) # high
	addiu	$2,$2,%lo(tScreenPinkSlipStandings_vtable) # low
	sw	$2,96($16)
	lui	$16,%hi(tScreenTournamentStandings3item_vtable) # high
	.set	noreorder
	.set	nomacro
	jal	__26tScreenTournamentStandings
	addiu	$16,$16,%lo(tScreenTournamentStandings3item_vtable) # low
	.set	macro
	.set	reorder

	addu	$18,$17,13832
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$16,96($19)
	.set	macro
	.set	reorder

	addu	$19,$17,14544
	move	$4,$19
	lui	$2,%hi(tScreenPinkSlips_vtable) # high
	addiu	$2,$2,%lo(tScreenPinkSlips_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,96($18)
	.set	macro
	.set	reorder

	addu	$16,$17,14932
	move	$4,$16
	lui	$2,%hi(tScreenBeTheCopCongrats_vtable) # high
	addiu	$2,$2,%lo(tScreenBeTheCopCongrats_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	sw	$2,96($19)
	.set	macro
	.set	reorder

	move	$2,$17
	lui	$3,%hi(tScreenTournamentCongrats_vtable) # high
	addiu	$3,$3,%lo(tScreenTournamentCongrats_vtable) # low
	sw	$3,96($16)
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	__11tAllScreens
	.align	2
	.globl	_._11tAllScreens
	.ent	_._11tAllScreens
_._11tAllScreens:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	addu	$4,$18,14932
	li	$5,2			# 0x00000002
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$18,14544
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,13832
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,13684
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,13536
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,13144
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,12940
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,11496
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,11372
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,11272
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,11076
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	addu	$16,$18,10892
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,10788
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,10444
	.set	noreorder
	.set	nomacro
	jal	_._17tScreenTrophyRoom
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,10052
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,9904
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,9192
	.set	noreorder
	.set	nomacro
	jal	_._18tScreenTournSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,8520
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,7844
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,7728
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,7556
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	addu	$16,$18,6628
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,6456
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	addu	$16,$18,5528
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,5376
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	addu	$16,$18,4448
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,4296
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	addu	$16,$18,3368
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,2392
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$4,$18,1464
	.set	noreorder
	.set	nomacro
	jal	_._16tScreenCarSelect
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	_._7tScreen
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	andi	$17,$17,0x0001
	beq	$17,$0,$L1528
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$18
	.set	macro
	.set	reorder

$L1528:
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

	.end	_._11tAllScreens
	.globl	gAllScreens
	.data
	.align	2
gAllScreens:
	.globl	_usePlayerUpgrades
	.align	2
_usePlayerUpgrades:
	.space	4
	.globl	colourChosen
	.align	2
colourChosen:
	.space	32
	.globl	gPSXMemCardFull
	.align	2
gPSXMemCardFull:
	.space	4
	.globl	memCardReadOK
	.align	2
memCardReadOK:
	.space	4
	.globl	overRide
	.align	2
overRide:
	.space	4
	.globl	ComingIntoTheFrontEndTheVeryFirstTime
	.align	2
ComingIntoTheFrontEndTheVeryFirstTime:
	.space	4
	.globl	gFE_Cheats
	.align	2
gFE_Cheats:
	.space	5
	.globl	CarLineup
	.align	2
CarLineup:
	.space	36
	.globl	picked
	.align	2
picked:
	.space	11
