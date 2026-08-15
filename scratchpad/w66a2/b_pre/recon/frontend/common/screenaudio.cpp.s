	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screenaudio.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	PlaySound__12tScreenAudio
	.ent	PlaySound__12tScreenAudio
PlaySound__12tScreenAudio:
	.frame	$sp,112,$31		# vars= 64, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	subu	$sp,$sp,112
	sw	$31,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	lw	$2,10068($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	move	$17,$4
	.set	macro
	.set	reorder

	lh	$3,112($17)
	lh	$2,116($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L643
	lui	$2,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	li	$4,10			# 0x0000000a
	.set	macro
	.set	reorder

	lh	$2,116($17)
	lw	$3,120($17)
	sll	$2,$2,6
	addu	$3,$3,$2
	lw	$4,8($3)
	jal	AudioMus_PlaySong__FPc
	lhu	$2,116($17)
	#nop
	sh	$2,112($17)
$L601:
	lui	$2,%hi(frontEnd) # high
$L643:
	addiu	$18,$2,%lo(frontEnd) # low
	lbu	$2,833($18)
	#nop
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

	lbu	$3,835($18)
	lui	$2,%hi(gMasterFENarrationLevel) # high
	sw	$3,%lo(gMasterFENarrationLevel)($2)
	lbu	$3,838($18)
	lbu	$2,102($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L602
	lui	$20,%hi(gStereoMode) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$16,1			# 0x00000001
	lui	$19,%hi(Audio_direct3davail) # high
	sw	$16,%lo(gStereoMode)($20)
	sw	$0,%lo(Audio_direct3davail)($19)
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_getopts
	sh	$16,104($17)
	.set	macro
	.set	reorder

	lbu	$2,838($18)
	#nop
	bne	$2,$16,$L603
	move	$2,$16
	sb	$16,40($sp)
	li	$2,2			# 0x00000002
	sw	$0,%lo(gStereoMode)($20)
	.set	noreorder
	.set	nomacro
	j	$L604
	sh	$2,104($17)
	.set	macro
	.set	reorder

$L603:
	bne	$2,$0,$L605
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L604
	sb	$2,40($sp)
	.set	macro
	.set	reorder

$L605:
	li	$2,2			# 0x00000002
	sb	$2,40($sp)
	sw	$16,%lo(Audio_direct3davail)($19)
$L604:
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_setopts
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+838) # high
	lbu	$2,%lo(frontEnd+838)($2)
	#nop
	sb	$2,102($17)
$L602:
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	lh	$3,10216($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L607
	move	$2,$0
	.set	macro
	.set	reorder

	slt	$2,$3,6
$L607:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L611
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$3,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$19,$L610
	lui	$2,%hi(frontEnd+834) # high
	.set	macro
	.set	reorder

	j	$L642
$L616:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L612
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L613
	lui	$2,%hi(frontEnd+834) # high
	.set	macro
	.set	reorder

	j	$L642
$L610:
	lbu	$18,%lo(frontEnd+834)($2)
	.set	noreorder
	.set	nomacro
	j	$L609
	li	$16,31			# 0x0000001f
	.set	macro
	.set	reorder

$L611:
	lui	$2,%hi(frontEnd+836) # high
	lbu	$18,%lo(frontEnd+836)($2)
	j	$L640
$L612:
	lui	$2,%hi(frontEnd+835) # high
	lbu	$18,%lo(frontEnd+835)($2)
	.set	noreorder
	.set	nomacro
	j	$L609
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L613:
	lui	$2,%hi(frontEnd+837) # high
	lbu	$18,%lo(frontEnd+837)($2)
	.set	noreorder
	.set	nomacro
	j	$L609
	li	$16,30			# 0x0000001e
	.set	macro
	.set	reorder

$L642:
	lbu	$18,%lo(frontEnd+834)($2)
$L640:
	jal	rand
	li	$3,715784192			# 0x2aaa0000
	ori	$3,$3,0xaaab
	mult	$2,$3
	sra	$4,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$4,$8,$4
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,1
	subu	$2,$2,$3
	addu	$16,$2,41
$L609:
	lh	$3,104($17)
	lui	$2,%hi(gMasterSFXLevel) # high
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L617
	sw	$18,%lo(gMasterSFXLevel)($2)
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+838) # high
	lbu	$3,%lo(frontEnd+838)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L618
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
$L618:
	.set	noreorder
	.set	nomacro
	j	$L620
	sh	$4,104($17)
	.set	macro
	.set	reorder

$L617:
	lw	$4,108($17)
	jal	SNDover
	move	$19,$2
$L620:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L621
	lui	$2,%hi(ginfo+22) # high
	.set	macro
	.set	reorder

	lhu	$2,%lo(ginfo+22)($2)
	#nop
	bne	$2,$0,$L621
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L621
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$3,104($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L622
	move	$6,$0
	.set	macro
	.set	reorder

	li	$6,49152			# 0x0000c000
	lui	$2,%hi(frontEnd+838) # high
	lbu	$3,%lo(frontEnd+838)($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L641
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L641
	move	$4,$2
	.set	macro
	.set	reorder

$L622:
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$5,$L626
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+838) # high
	lbu	$2,%lo(frontEnd+838)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L631
	li	$3,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L631
	move	$3,$5
	.set	macro
	.set	reorder

$L626:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L630
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$6,16383			# 0x00003fff
	lui	$2,%hi(frontEnd+838) # high
	lbu	$2,%lo(frontEnd+838)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L631
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,4			# 0x00000004
$L631:
	.set	noreorder
	.set	nomacro
	j	$L625
	sh	$3,104($17)
	.set	macro
	.set	reorder

$L630:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L644
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$6,32768			# 0x00008000
$L641:
	sh	$4,104($17)
$L625:
	li	$2,-1			# 0xffffffff
$L644:
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L635
	move	$5,$16
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	FeAudio_AsyncPlaySpeech__Fii
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L621
	sw	$0,108($17)
	.set	macro
	.set	reorder

$L635:
	lui	$2,%hi(gSndBnk) # high
	lw	$4,%lo(gSndBnk)($2)
	li	$2,64			# 0x00000040
	move	$7,$18
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlaySound__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	sw	$2,108($17)
$L621:
	lui	$2,%hi(frontEnd+834) # high
	lbu	$3,%lo(frontEnd+834)($2)
	lui	$2,%hi(gMasterSFXLevel) # high
	.set	noreorder
	.set	nomacro
	j	$L600
	sw	$3,%lo(gMasterSFXLevel)($2)
	.set	macro
	.set	reorder

$L608:
	lh	$2,104($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	lui	$2,%hi(frontEnd+834) # high
	.set	macro
	.set	reorder

	lw	$4,108($17)
	lbu	$3,%lo(frontEnd+834)($2)
	lui	$2,%hi(gMasterSFXLevel) # high
	.set	noreorder
	.set	nomacro
	jal	SNDstop
	sw	$3,%lo(gMasterSFXLevel)($2)
	.set	macro
	.set	reorder

	sh	$0,104($17)
$L600:
	lw	$31,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	PlaySound__12tScreenAudio
	.align	2
	.globl	DrawForeground__12tScreenAudio
	.ent	DrawForeground__12tScreenAudio
DrawForeground__12tScreenAudio:
	.frame	$sp,48,$31		# vars= 0, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	subu	$sp,$sp,48
	sw	$31,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,10324($2)
	#nop
	sra	$4,$2,1
	sll	$2,$4,16
	sra	$3,$2,16
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L657
	slt	$2,$3,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$3,$L648
	move	$16,$0
	.set	macro
	.set	reorder

$L657:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	li	$4,128			# 0x00000080
	.set	macro
	.set	reorder

$L648:
	move	$4,$0
$L658:
	move	$18,$4
 #APP
 #NO_APP
	sll	$2,$18,16
	sra	$17,$2,16
	addu	$4,$16,48
$L659:
	li	$5,1			# 0x00000001
	move	$6,$0
	move	$7,$6
	sw	$17,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	addu	$4,$16,48
	.set	macro
	.set	reorder

	sll	$2,$18,16
	sra	$2,$2,16
	slt	$2,$2,100
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L645
	li	$4,637			# 0x0000027d
	.set	macro
	.set	reorder

	li	$5,480			# 0x000001e0
	li	$6,220			# 0x000000dc
	li	$7,1			# 0x00000001
	move	$2,$7
	sw	$2,16($sp)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,637			# 0x0000027d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,480			# 0x000001e0
	li	$6,220			# 0x000000dc
	subu	$2,$0,$2
	addu	$7,$2,-5
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L645:
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

	.end	DrawForeground__12tScreenAudio

	.lcomm	lastpercentage.230,4

	.lcomm	perfade.231,4
	.rdata
	.align	2
$LC0:
	.ascii	"%d%%\000"
	.text
	.align	2
	.globl	DrawBackground__12tScreenAudio
	.ent	DrawBackground__12tScreenAudio
DrawBackground__12tScreenAudio:
	.frame	$sp,312,$31		# vars= 256, regs= 5/0, args= 32, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,312
	sw	$31,304($sp)
	sw	$19,300($sp)
	sw	$18,296($sp)
	sw	$17,292($sp)
	.set	noreorder
	.set	nomacro
	jal	PlaySound__12tScreenAudio
	sw	$16,288($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$2,%lo(menuDefs)($2)
	#nop
	addu	$3,$2,10208
	lw	$2,116($3)
	#nop
	sra	$2,$2,1
	move	$19,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	bne	$2,$0,$L661
	li	$19,128			# 0x00000080
$L661:
	lh	$3,8($3)
	#nop
	sltu	$2,$3,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$2,%hi($L670) # high
	addiu	$2,$2,%lo($L670) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L670:
	.word	$L663
	.word	$L664
	.word	$L665
	.word	$L666
	.word	$L667
	.text
$L663:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L689
	addu	$4,$4,9676
	.set	macro
	.set	reorder

$L664:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L689
	addu	$4,$4,9732
	.set	macro
	.set	reorder

$L665:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L689
	addu	$4,$4,9788
	.set	macro
	.set	reorder

$L666:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	j	$L689
	addu	$4,$4,9844
	.set	macro
	.set	reorder

$L667:
	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	#nop
	addu	$4,$4,9900
$L689:
	jal	Percentage__29tMenuItemLeftRightAudioSlider
	move	$16,$2
$L669:
	.set	noreorder
	.set	nomacro
	bltz	$16,$L688
	lui	$2,%hi(lastpercentage.230) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L673
	sw	$16,%lo(lastpercentage.230)($2)
	.set	macro
	.set	reorder

$L688:
	lw	$2,%lo(lastpercentage.230)($2)
	#nop
	bltz	$2,$L672
$L673:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L691
	lui	$3,%hi(perfade.231) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(menuDefs) # high
	lw	$4,%lo(menuDefs)($2)
	.set	noreorder
	.set	nomacro
	jal	TransitionIsFinished__12tOptionsMenu
	addu	$4,$4,10208
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L674
	lui	$3,%hi(perfade.231) # high
	.set	macro
	.set	reorder

$L691:
	lw	$2,%lo(perfade.231)($3)
	.set	noreorder
	.set	nomacro
	j	$L690
	addu	$2,$2,4
	.set	macro
	.set	reorder

$L674:
	lw	$2,%lo(perfade.231)($3)
	#nop
	addu	$2,$2,-4
$L690:
	sw	$2,%lo(perfade.231)($3)
	lui	$17,%hi(perfade.231) # high
	lw	$7,%lo(perfade.231)($17)
	#nop
	slt	$2,$7,129
	bne	$2,$0,$L677
	li	$7,128			# 0x00000080
$L677:
	bgez	$7,$L678
	move	$7,$0
$L678:
	move	$5,$0
	sll	$6,$19,16
	lui	$3,%hi(kRGBVals) # high
	lui	$2,%hi(textDefinitions+41) # high
	lbu	$2,%lo(textDefinitions+41)($2)
	addiu	$3,$3,%lo(kRGBVals) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	sra	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fiiii
	sw	$7,%lo(perfade.231)($17)
	.set	macro
	.set	reorder

	move	$6,$16
	move	$18,$2
 #APP
 #NO_APP
	lui	$2,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	bgez	$6,$L681
	addiu	$5,$2,%lo($LC0) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(lastpercentage.230) # high
	lw	$6,%lo(lastpercentage.230)($2)
$L681:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lw	$3,%lo(perfade.231)($17)
	li	$2,128			# 0x00000080
	beq	$3,$2,$L672
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,476			# 0x000001dc
	.set	macro
	.set	reorder

	li	$4,476			# 0x000001dc
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	move	$5,$16
	sll	$2,$2,16
	sra	$6,$2,16
	move	$7,$18
	li	$2,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L672:
	move	$16,$0
	sll	$2,$19,16
	sra	$17,$2,16
	addu	$4,$16,6
$L692:
	li	$5,1			# 0x00000001
	move	$6,$0
	move	$7,$6
	sw	$17,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L692
	addu	$4,$16,6
	.set	macro
	.set	reorder

	lw	$31,304($sp)
	lw	$19,300($sp)
	lw	$18,296($sp)
	lw	$17,292($sp)
	lw	$16,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,312
	.set	macro
	.set	reorder

	.end	DrawBackground__12tScreenAudio
	.rdata
	.align	2
$LC1:
	.ascii	"zAudio\000"
	.text
	.align	2
	.globl	GetShapeInfo__12tScreenAudioRsT1PPcT3
	.ent	GetShapeInfo__12tScreenAudioRsT1PPcT3
GetShapeInfo__12tScreenAudioRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$0,0($6)
	sw	$0,0($2)
	li	$2,52			# 0x00000034
	sh	$2,0($5)
	lui	$2,%hi($LC1) # high
	addiu	$2,$2,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__12tScreenAudioRsT1PPcT3
	.align	2
	.globl	__12tScreenAudio
	.ent	__12tScreenAudio
__12tScreenAudio:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tScreenAudio_vtable) # high
	addiu	$3,$3,%lo(tScreenAudio_vtable) # low
	sw	$3,96($2)
	sh	$0,116($2)
	sb	$0,114($2)
	sw	$0,120($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__12tScreenAudio
	.align	2
	.globl	Initialize__12tScreenAudio
	.ent	Initialize__12tScreenAudio
Initialize__12tScreenAudio:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(menuDefs) # high
	lw	$6,%lo(menuDefs)($2)
	li	$2,-1			# 0xffffffff
	li	$5,1			# 0x00000001
	sw	$31,20($sp)
	sh	$2,112($16)
	addu	$4,$6,10000
	.set	noreorder
	.set	nomacro
	jal	SetMenu__20tMenuItemSlidingMenubP14tInsideBoxMenu
	addu	$6,$6,10072
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+838) # high
	lbu	$2,%lo(frontEnd+838)($2)
	sh	$0,104($16)
	sw	$0,108($16)
	sw	$0,120($16)
	sb	$2,102($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__12tScreenAudio
	.align	2
	.globl	Cleanup__12tScreenAudio
	.ent	Cleanup__12tScreenAudio
Cleanup__12tScreenAudio:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lh	$2,104($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L703
	lui	$16,%hi(frontEnd) # high
	.set	macro
	.set	reorder

	lw	$4,108($17)
	jal	SNDstop
	sh	$0,104($17)
$L703:
	addiu	$16,$16,%lo(frontEnd) # low
	lbu	$2,833($16)
	#nop
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

	lbu	$2,833($16)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	sra	$4,$4,6
	move	$3,$2
	lui	$2,%hi(gMasterMusicLevel) # high
	sw	$3,%lo(gMasterMusicLevel)($2)
	lbu	$3,834($16)
	lui	$2,%hi(gMasterSFXLevel) # high
	sw	$3,%lo(gMasterSFXLevel)($2)
	lbu	$3,835($16)
	lui	$2,%hi(gMasterFENarrationLevel) # high
	sw	$3,%lo(gMasterFENarrationLevel)($2)
	lbu	$3,836($16)
	lui	$2,%hi(gMasterEngineLevel) # high
	sw	$3,%lo(gMasterEngineLevel)($2)
	lbu	$3,837($16)
	lui	$2,%hi(gMasterAmbientLevel) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sw	$3,%lo(gMasterAmbientLevel)($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$2,%hi(ginfo) # high
	addiu	$16,$2,%lo(ginfo) # low
$L700:
	lhu	$2,16($16)
	#nop
	beq	$2,$0,$L698
	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L700
$L698:
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

	.end	Cleanup__12tScreenAudio
	.align	2
	.globl	___12tScreenAudio
	.ent	___12tScreenAudio
___12tScreenAudio:
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

	.end	___12tScreenAudio
	.globl	screenAudio
	.data
	.align	2
screenAudio:
	.space	4
