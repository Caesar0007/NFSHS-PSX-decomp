	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\audioeng.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AudioEng_Set__Fiiiiiiii
	.align	2
	.globl	AudioEng_Update__Fv
	.align	2
	.globl	AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
	.rdata
	.align	2
$LC0:
	.ascii	"Engine Audio\000"
	.align	2
$LC1:
	.ascii	"%s%sens.viv\000"
	.align	2
$LC2:
	.ascii	"%s%seng.viv\000"
	.align	2
$LC3:
	.ascii	"%sp993ens.viv\000"
	.align	2
$LC4:
	.ascii	"%sp993eng.viv\000"
	.sdata
	.align	2
$LC5:
	.ascii	"*.bnk\000"
	.align	2
$LC6:
	.ascii	"*.ltb\000"
	.align	2
$LC7:
	.ascii	"*.ctb\000"
	.rdata
	.align	2
$LC8:
	.ascii	"Engine Tables\000"
	.text
	.align	2
	.globl	AudioEng_StartUp__FiPc
	.align	2
	.globl	AudioEng_StartServer__Fv
	.align	2
	.globl	AudioEng_StopServer__Fv
	.align	2
	.globl	AudioEng_Pause__Fv
	.align	2
	.globl	AudioEng_Resume__Fv
	.align	2
	.globl	AudioEng_CleanUp__Fv
	.globl	AudioEng_g
	.sdata
	.align	2
AudioEng_g:
	.space	8

	.extern	gSndBnk, 84
	.extern	Xfade, 129
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	AudioEng_Set__Fiiiiiiii
AudioEng_Set__Fiiiiiiii:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$23,44($sp)
	move	$23,$5
	sw	$21,36($sp)
	lw	$21,72($sp)
	lw	$5,76($sp)
	sw	$22,40($sp)
	lw	$22,80($sp)
	sw	$19,28($sp)
	move	$19,$7
	sw	$20,32($sp)
	lw	$20,84($sp)
	sltu	$2,$4,2
	sw	$31,48($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L600
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	sll	$4,$4,2
	la	$2,AudioEng_g
	addu	$2,$4,$2
	lw	$17,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L600
	li	$2,15			# 0x0000000f
	.set	macro
	.set	reorder

	lbu	$3,283($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L604
	move	$18,$17
	.set	macro
	.set	reorder

	lbu	$2,282($17)
	#nop
	addu	$2,$2,1
	andi	$2,$2,0x0001
	bne	$2,$0,$L600
$L604:
	lbu	$2,7($17)
	#nop
	mult	$2,$6
	lbu	$3,282($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,90
	addu	$16,$17,$2
	mflo	$8
	#nop
	#nop
	sra	$3,$8,14
	slt	$2,$3,512
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	li	$7,511			# 0x000001ff
	.set	macro
	.set	reorder

	move	$7,$3
$L605:
	lui	$2,%hi(Cars_gList) # high
	addiu	$2,$2,%lo(Cars_gList) # low
	addu	$2,$4,$2
	sh	$7,8($16)
	lw	$2,0($2)
	#nop
	lw	$2,648($2)
	#nop
	lw	$3,0($2)
	li	$2,28			# 0x0000001c
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L607
	sra	$2,$6,2
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	li	$4,49152			# 0x0000c000
	.set	noreorder
	.set	nomacro
	j	$L608
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L607:
 #APP
 #NO_APP
	addu	$4,$6,13107
$L608:
	jal	fixedmult
	lbu	$3,6($17)
	#nop
	mult	$3,$2
	mflo	$8
	#nop
	#nop
	sra	$2,$8,10
	sh	$2,2($16)
 #APP
 #NO_APP
	sra	$2,$19,5
	addu	$2,$19,$2
	sra	$3,$19,6
	addu	$3,$2,$3
	slt	$2,$3,129
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L610
	sb	$3,11($16)
	.set	macro
	.set	reorder

$L609:
	sb	$2,11($16)
$L610:
	bne	$21,$0,$L611
	lbu	$2,1($18)
	#nop
	sb	$2,10($16)
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L612
	li	$2,16383			# 0x00003fff
	.set	macro
	.set	reorder

	sh	$0,6($16)
	.set	noreorder
	.set	nomacro
	j	$L613
	sh	$22,4($16)
	.set	macro
	.set	reorder

$L612:
	sh	$0,4($16)
	sh	$2,6($16)
$L613:
	lbu	$2,0($18)
	.set	noreorder
	.set	nomacro
	j	$L625
	mult	$23,$2
	.set	macro
	.set	reorder

$L611:
	lbu	$2,2($18)
	.set	noreorder
	.set	nomacro
	bgez	$20,$L617
	sb	$2,10($16)
	.set	macro
	.set	reorder

	lbu	$2,3($18)
	#nop
	mult	$20,$2
	mflo	$8
	#nop
	lbu	$4,10($16)
	.set	noreorder
	.set	nomacro
	j	$L624
	mult	$8,$4
	.set	macro
	.set	reorder

$L617:
	lbu	$2,4($18)
	#nop
	mult	$20,$2
	lbu	$4,10($16)
	mflo	$8
	#nop
	li	$2,128			# 0x00000080
	subu	$2,$2,$4
	mult	$8,$2
$L624:
	mflo	$8
	#nop
	#nop
	sra	$3,$8,7
	.set	noreorder
	.set	nomacro
	bgez	$3,$L626
	sra	$2,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	sra	$2,$3,16
$L626:
	addu	$2,$4,$2
	sb	$2,10($16)
	sh	$22,4($16)
	sh	$0,6($16)
	lbu	$2,5($18)
	#nop
	mult	$23,$2
$L625:
	mflo	$8
	#nop
	#nop
	sra	$5,$8,6
	slt	$2,$5,2048
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	li	$3,2047			# 0x000007ff
	.set	macro
	.set	reorder

	move	$3,$5
$L621:
	sh	$3,0($16)
	lbu	$2,282($17)
	#nop
	addu	$2,$2,1
	andi	$2,$2,0x000f
	sb	$2,282($17)
$L600:
	lw	$31,48($sp)
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

	.end	AudioEng_Set__Fiiiiiiii
	.text
	.ent	AudioEng_Update__Fv
AudioEng_Update__Fv:
	.frame	$sp,88,$31		# vars= 32, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	lui	$2,%hi(Xfade) # high
	sw	$fp,80($sp)
	addiu	$fp,$2,%lo(Xfade) # low
	sw	$23,76($sp)
	li	$23,-1			# 0xffffffff
	sw	$31,84($sp)
	sw	$22,72($sp)
	sw	$21,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	sw	$0,40($sp)
$L628:
	lw	$7,40($sp)
	#nop
	slt	$2,$7,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	sll	$2,$7,2
	.set	macro
	.set	reorder

	la	$3,AudioEng_g
	addu	$2,$2,$3
	lw	$17,0($2)
	#nop
	beq	$17,$0,$L627
	lbu	$3,283($17)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,90
	.set	noreorder
	.set	nomacro
	jal	gettick
	addu	$16,$17,$2
	.set	macro
	.set	reorder

	lbu	$4,283($17)
	lbu	$3,282($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L633
	move	$18,$2
	.set	macro
	.set	reorder

	jal	gettick
	lw	$3,8($17)
	#nop
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L633
	addu	$2,$18,2
	.set	macro
	.set	reorder

	sw	$2,8($17)
	move	$22,$0
	move	$6,$17
	move	$5,$17
$L635:
	slt	$2,$22,16
	beq	$2,$0,$L636
	lb	$2,292($5)
	#nop
	bltz	$2,$L637
	lhu	$3,8($16)
	lh	$4,284($5)
	#nop
	slt	$2,$3,$4
	bne	$2,$0,$L640
	lh	$2,286($5)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	subu	$3,$3,$4
	.set	macro
	.set	reorder

	lw	$2,288($5)
	#nop
	addu	$2,$2,$3
	lb	$4,0($2)
	j	$L641
$L640:
	move	$4,$0
$L641:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L642
	slt	$2,$22,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L643
	li	$7,128			# 0x00000080
	.set	macro
	.set	reorder

	lbu	$2,11($16)
	.set	noreorder
	.set	nomacro
	j	$L685
	subu	$2,$7,$2
	.set	macro
	.set	reorder

$L643:
	lbu	$2,11($16)
$L685:
	addu	$2,$2,$fp
	lbu	$2,0($2)
	#nop
	mult	$4,$2
	mflo	$4
	#nop
	lb	$2,292($5)
	#nop
	slt	$2,$2,64
	bne	$2,$0,$L645
	lhu	$2,6($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	li	$7,128			# 0x00000080
	.set	macro
	.set	reorder

	lbu	$2,10($16)
	#nop
	subu	$2,$7,$2
	addu	$2,$2,$fp
	lbu	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L686
	sra	$2,$2,6
	.set	macro
	.set	reorder

$L646:
	lbu	$2,10($16)
	.set	noreorder
	.set	nomacro
	j	$L687
	subu	$2,$7,$2
	.set	macro
	.set	reorder

$L645:
	lbu	$2,10($16)
$L687:
	addu	$2,$2,$fp
	lbu	$2,0($2)
$L686:
	mult	$4,$2
	mflo	$4
$L642:
	lhu	$2,0($16)
	#nop
	mult	$4,$2
	mflo	$4
	#nop
	#nop
	srl	$4,$4,21
	sltu	$2,$4,128
	bne	$2,$0,$L649
	li	$4,127			# 0x0000007f
$L649:
	sw	$4,12($6)
	lhu	$2,4($16)
	#nop
	sw	$2,76($17)
	lhu	$2,6($16)
	#nop
	sw	$2,80($17)
	lhu	$2,2($16)
	#nop
	sw	$2,84($17)
$L637:
	addu	$6,$6,4
	addu	$5,$5,12
	.set	noreorder
	.set	nomacro
	j	$L635
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L636:
	lbu	$2,283($17)
	#nop
	addu	$2,$2,1
	andi	$2,$2,0x000f
	sb	$2,283($17)
$L633:
	move	$22,$0
	move	$16,$17
	move	$20,$16
	move	$21,$16
$L652:
	slt	$2,$22,16
	beq	$2,$0,$L651
 #APP
 #NO_APP
	lb	$3,292($16)
	#nop
	bltz	$3,$L654
	lw	$2,12($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	slt	$2,$3,64
	.set	macro
	.set	reorder

	bne	$2,$0,$L656
	lhu	$3,76($17)
	lhu	$2,80($17)
	#nop
	subu	$18,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L657
	addu	$19,$3,$2
	.set	macro
	.set	reorder

$L656:
	lhu	$19,76($17)
	#nop
	move	$18,$19
$L657:
	.set	noreorder
	.set	nomacro
	jal	SNDplaysetdef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,88($17)
	#nop
	sb	$2,20($sp)
	lb	$2,292($16)
	sb	$0,24($sp)
	sw	$2,16($sp)
	lhu	$3,84($17)
	li	$2,1			# 0x00000001
	sb	$2,27($sp)
	sh	$0,34($sp)
	sh	$3,28($sp)
	lw	$2,484($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$23,$L658
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDplay
	sh	$18,32($sp)
	.set	macro
	.set	reorder

	sw	$2,484($16)
	li	$2,2			# 0x00000002
	sb	$2,860($20)
	sb	$0,476($16)
	sh	$18,480($16)
	lhu	$2,84($17)
	.set	noreorder
	.set	nomacro
	j	$L654
	sh	$2,478($16)
	.set	macro
	.set	reorder

$L658:
	lw	$2,80($17)
	#nop
	beq	$2,$0,$L661
	lb	$2,292($16)
	#nop
	slt	$2,$2,64
	bne	$2,$0,$L661
	lw	$2,676($16)
	#nop
	beq	$2,$23,$L660
$L661:
	lb	$3,476($16)
	lw	$4,12($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L660
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L663
	addu	$3,$3,-2
	.set	noreorder
	.set	nomacro
	j	$L664
	slt	$2,$3,$4
	.set	macro
	.set	reorder

$L663:
	addu	$3,$3,2
	slt	$2,$4,$3
$L664:
	beq	$2,$0,$L665
	move	$3,$4
$L665:
	#.set	volatile
	sb	$3,476($16)
	#.set	novolatile
	#.set	volatile
	lw	$4,484($16)
	#.set	novolatile
	lb	$5,476($16)
	jal	SNDvol
$L660:
	lhu	$2,480($16)
	andi	$5,$18,0xffff
	beq	$2,$5,$L666
	lw	$4,484($16)
	.set	noreorder
	.set	nomacro
	jal	SND3dpos
	move	$6,$0
	.set	macro
	.set	reorder

	sh	$18,480($16)
$L666:
	lhu	$2,478($16)
	lw	$5,84($17)
	#nop
	beq	$2,$5,$L667
	lw	$4,484($16)
	jal	SNDpitchmult
	lhu	$2,84($17)
	#nop
	sh	$2,478($16)
$L667:
	lb	$2,292($16)
	#nop
	slt	$2,$2,64
	bne	$2,$0,$L668
	lw	$2,80($17)
	#nop
	beq	$2,$0,$L668
	lw	$2,676($16)
	#nop
	bne	$2,$23,$L669
	lbu	$2,860($20)
	#nop
	addu	$2,$2,-1
	sb	$2,860($20)
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	bne	$2,$23,$L654
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDplay
	sh	$19,32($sp)
	.set	macro
	.set	reorder

	sw	$2,676($16)
	sb	$0,668($16)
	.set	noreorder
	.set	nomacro
	j	$L688
	sh	$19,672($16)
	.set	macro
	.set	reorder

$L669:
	lb	$3,668($16)
	lw	$4,12($21)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$4,$L672
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	beq	$2,$0,$L673
	addu	$3,$3,-2
	.set	noreorder
	.set	nomacro
	j	$L674
	slt	$2,$3,$4
	.set	macro
	.set	reorder

$L673:
	addu	$3,$3,2
	slt	$2,$4,$3
$L674:
	beq	$2,$0,$L675
	move	$3,$4
$L675:
	#.set	volatile
	sb	$3,668($16)
	#.set	novolatile
	#.set	volatile
	lw	$4,676($16)
	#.set	novolatile
	lb	$5,668($16)
	jal	SNDvol
$L672:
	lhu	$2,672($16)
	andi	$5,$19,0xffff
	beq	$2,$5,$L676
	lw	$4,676($16)
	.set	noreorder
	.set	nomacro
	jal	SND3dpos
	move	$6,$0
	.set	macro
	.set	reorder

	sh	$19,672($16)
$L676:
	lhu	$2,670($16)
	lw	$5,84($17)
	#nop
	beq	$2,$5,$L654
	lw	$4,676($16)
	jal	SNDpitchmult
$L688:
	lhu	$2,84($17)
	.set	noreorder
	.set	nomacro
	j	$L654
	sh	$2,670($16)
	.set	macro
	.set	reorder

$L668:
	lw	$4,676($16)
	#nop
	beq	$4,$23,$L654
	jal	SNDstop
	li	$2,2			# 0x00000002
	sw	$23,676($16)
	.set	noreorder
	.set	nomacro
	j	$L654
	sb	$2,860($20)
	.set	macro
	.set	reorder

$L655:
	lw	$4,484($16)
	#nop
	beq	$4,$23,$L654
	jal	SNDstop
	lw	$4,676($16)
	#nop
	beq	$4,$23,$L682
	jal	SNDstop
$L682:
	sw	$23,484($16)
	sw	$23,676($16)
$L654:
	addu	$20,$20,1
	addu	$16,$16,12
	addu	$21,$21,4
	.set	noreorder
	.set	nomacro
	j	$L652
	addu	$22,$22,1
	.set	macro
	.set	reorder

$L651:
	lw	$7,40($sp)
	#nop
	addu	$7,$7,1
	.set	noreorder
	.set	nomacro
	j	$L628
	sw	$7,40($sp)
	.set	macro
	.set	reorder

$L627:
	lw	$31,84($sp)
	lw	$fp,80($sp)
	lw	$23,76($sp)
	lw	$22,72($sp)
	lw	$21,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	AudioEng_Update__Fv
	.text
	.ent	AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$6
	sw	$19,36($sp)
	move	$19,$7
	sw	$17,28($sp)
	lw	$17,64($sp)
	move	$4,$5
	sw	$16,24($sp)
	lw	$16,68($sp)
	li	$6,16			# 0x00000010
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$19
	li	$2,100			# 0x00000064
	sw	$2,16($sp)
	lw	$6,0($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	move	$7,$17
	.set	macro
	.set	reorder

$L689:
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

	.end	AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
	.text
	.ent	AudioEng_StartUp__FiPc
AudioEng_StartUp__FiPc:
	.frame	$sp,152,$31		# vars= 88, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,152
	sw	$23,140($sp)
	move	$23,$4
	sw	$19,124($sp)
	move	$19,$5
	sltu	$2,$23,2
	sw	$31,148($sp)
	sw	$fp,144($sp)
	sw	$22,136($sp)
	sw	$21,132($sp)
	sw	$20,128($sp)
	sw	$18,120($sp)
	sw	$17,116($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L755
	sw	$16,112($sp)
	.set	macro
	.set	reorder

	sll	$2,$23,2
	la	$3,AudioEng_g
	addu	$16,$2,$3
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L693
	move	$21,$0
	.set	macro
	.set	reorder

$L755:
	.set	noreorder
	.set	nomacro
	j	$L753
	move	$2,$0
	.set	macro
	.set	reorder

$L693:
	move	$fp,$21
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,880			# 0x00000370
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$21
	.set	macro
	.set	reorder

	move	$17,$21
	li	$5,-1			# 0xffffffff
	li	$6,512			# 0x00000200
	move	$18,$2
	move	$3,$18
	move	$4,$18
	li	$2,4096			# 0x00001000
	sw	$18,0($16)
	sw	$0,876($18)
	sw	$0,8($18)
	sw	$0,76($18)
	sw	$0,80($18)
	sw	$2,84($18)
$L697:
	sw	$0,12($4)
	sw	$5,484($3)
	sw	$5,676($3)
	sb	$5,292($3)
	sh	$6,284($3)
	sh	$6,286($3)
	sw	$0,288($3)
	addu	$3,$3,12
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L697
	addu	$4,$4,4
	.set	macro
	.set	reorder

	li	$2,50			# 0x00000032
	sw	$0,104($sp)
	sw	$0,100($sp)
	sb	$2,0($18)
	li	$2,31			# 0x0000001f
	sb	$2,1($18)
	li	$2,166			# 0x000000a6
	sb	$2,5($18)
	li	$2,43			# 0x0000002b
	sb	$2,2($18)
	li	$2,64			# 0x00000040
	sb	$2,3($18)
	li	$2,121			# 0x00000079
	sb	$2,4($18)
	li	$2,80			# 0x00000050
	sb	$2,6($18)
	li	$2,104			# 0x00000068
	sb	$2,7($18)
	lui	$2,%hi(GameSetup_gData+12) # high
	sb	$0,282($18)
	sb	$0,283($18)
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L699
	move	$22,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	lui	$5,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$L756
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

$L699:
	addu	$4,$sp,24
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
$L756:
	lui	$2,%hi(Paths_Paths+112) # high
	lw	$6,%lo(Paths_Paths+112)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$19
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$20,$2
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L761
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L702
	lui	$2,%hi(Paths_Paths+112) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	lw	$6,%lo(Paths_Paths+112)($2)
	lui	$5,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L757
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

$L702:
	lw	$6,%lo(Paths_Paths+112)($2)
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
$L757:
	jal	sprintf
	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$20,$2
	beq	$20,$0,$L704
	addu	$4,$sp,24
$L761:
	li	$5,1			# 0x00000001
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	addu	$7,$sp,88
	.set	macro
	.set	reorder

	move	$19,$0
$L705:
	.set	noreorder
	.set	nomacro
	jal	bigcount
	move	$4,$20
	.set	macro
	.set	reorder

	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L706
	addu	$2,$sp,96
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	move	$4,$20
	move	$5,$0
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	addu	$7,$sp,92
	.set	macro
	.set	reorder

	move	$17,$2
	move	$4,$17
	lui	$5,%hi($LC5) # high
	.set	noreorder
	.set	nomacro
	jal	wildcard
	addiu	$5,$5,%lo($LC5) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L762
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$22,$0,$L763
	lui	$5,%hi($LC6) # high
	.set	macro
	.set	reorder

	move	$4,$17
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L707
	move	$6,$16
	.set	macro
	.set	reorder

	li	$22,1			# 0x00000001
	lw	$4,88($sp)
	lw	$5,92($sp)
	lw	$7,96($sp)
	li	$2,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	move	$6,$16
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_AddBank__FPciT0i
	move	$7,$23
	.set	macro
	.set	reorder

	sll	$3,$23,$22
	addu	$3,$3,$23
	sll	$3,$3,2
	lui	$13,%hi(gSndBnk) # high
	addiu	$13,$13,%lo(gSndBnk) # low
	addu	$3,$3,$13
	lbu	$3,0($3)
	move	$fp,$2
	.set	noreorder
	.set	nomacro
	j	$L707
	sb	$3,88($18)
	.set	macro
	.set	reorder

$L762:
	lui	$5,%hi($LC6) # high
$L763:
	.set	noreorder
	.set	nomacro
	jal	wildcard
	addiu	$5,$5,%lo($LC6) # low
	.set	macro
	.set	reorder

	beq	$2,$0,$L712
	lw	$2,100($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	move	$5,$17
	lw	$6,88($sp)
	lw	$7,92($sp)
	lw	$3,96($sp)
	.set	noreorder
	.set	nomacro
	j	$L758
	addu	$2,$sp,100
	.set	macro
	.set	reorder

$L712:
	move	$4,$17
	lui	$5,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	wildcard
	addiu	$5,$5,%lo($LC7) # low
	.set	macro
	.set	reorder

	beq	$2,$0,$L707
	lw	$2,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L707
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	move	$5,$17
	lw	$6,88($sp)
	lw	$7,92($sp)
	lw	$3,96($sp)
	addu	$2,$sp,104
$L758:
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef
	sw	$3,16($sp)
	.set	macro
	.set	reorder

$L707:
	.set	noreorder
	.set	nomacro
	j	$L705
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L706:
	lw	$4,88($sp)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$20
	.set	macro
	.set	reorder

$L704:
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L753
	move	$2,$fp
	.set	macro
	.set	reorder

	lw	$2,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	move	$2,$fp
	.set	macro
	.set	reorder

	lw	$2,100($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L759
	move	$11,$0
	.set	macro
	.set	reorder

	addu	$12,$18,284
$L718:
	slt	$2,$11,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L719
	move	$5,$21
	.set	macro
	.set	reorder

	beq	$11,$0,$L722
	lw	$7,100($sp)
	j	$L723
$L722:
	lw	$7,104($sp)
$L723:
	lbu	$2,5($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	move	$17,$0
	.set	macro
	.set	reorder

	move	$6,$7
	move	$10,$17
	li	$9,328			# 0x00000148
	li	$8,296			# 0x00000128
$L725:
	slt	$2,$17,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	addu	$5,$7,$17
	.set	macro
	.set	reorder

	lb	$2,32($5)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L729
	addu	$2,$7,$8
	.set	macro
	.set	reorder

	lw	$3,296($6)
	#nop
	addu	$2,$2,$3
	lw	$3,328($6)
	addu	$4,$12,$10
	sw	$2,296($6)
	addu	$2,$7,$9
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$11,$0,$L730
	sw	$2,328($6)
	.set	macro
	.set	reorder

	addu	$4,$4,96
$L730:
	lbu	$2,32($5)
	#nop
	sb	$2,8($4)
	lw	$2,296($6)
	#nop
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L732
	move	$3,$0
	.set	macro
	.set	reorder

	move	$5,$6
	addu	$3,$3,1
$L765:
	slt	$2,$3,512
	beq	$2,$0,$L764
	lw	$2,296($5)
	#nop
	addu	$2,$2,$3
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L765
	addu	$3,$3,1
	.set	macro
	.set	reorder

	addu	$3,$3,-1
$L732:
	slt	$2,$3,512
$L764:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	sh	$3,0($4)
	.set	macro
	.set	reorder

	lw	$5,296($6)
	#nop
	addu	$2,$5,$3
$L767:
	lb	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L766
	sll	$2,$3,16
	.set	macro
	.set	reorder

	addu	$3,$3,1
	slt	$2,$3,512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L767
	addu	$2,$5,$3
	.set	macro
	.set	reorder

$L737:
	sll	$2,$3,16
$L766:
	sh	$3,2($4)
	lh	$3,0($4)
	sra	$2,$2,16
	subu	$2,$2,$3
	addu	$21,$21,$2
$L729:
	li	$2,1			# 0x00000001
	sb	$2,5($7)
	addu	$6,$6,4
	addu	$10,$10,12
	addu	$9,$9,4
	addu	$8,$8,4
	.set	noreorder
	.set	nomacro
	j	$L725
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L720:
	.set	noreorder
	.set	nomacro
	j	$L718
	addu	$11,$11,1
	.set	macro
	.set	reorder

$L719:
	lui	$4,%hi($LC8) # high
	addiu	$4,$4,%lo($LC8) # low
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,876($18)
	move	$19,$2
	move	$20,$0
	addu	$21,$18,284
$L741:
	slt	$2,$20,2
	beq	$2,$0,$L742
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L745
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,100($sp)
	.set	noreorder
	.set	nomacro
	j	$L768
	move	$18,$2
	.set	macro
	.set	reorder

$L745:
	lw	$2,104($sp)
	#nop
	move	$18,$2
$L768:
	move	$16,$17
$L747:
	slt	$2,$17,8
	beq	$2,$0,$L743
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L751
	addu	$2,$21,$16
	.set	macro
	.set	reorder

	addu	$2,$2,96
$L751:
	lh	$6,2($2)
	lh	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$3,$L749
	move	$4,$19
	.set	macro
	.set	reorder

	subu	$6,$6,$3
	sw	$19,4($2)
	move	$2,$3
	lw	$5,296($18)
	addu	$19,$19,$6
	.set	noreorder
	.set	nomacro
	jal	memcpy
	addu	$5,$5,$2
	.set	macro
	.set	reorder

$L749:
	addu	$18,$18,4
	addu	$16,$16,12
	.set	noreorder
	.set	nomacro
	j	$L747
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L743:
	.set	noreorder
	.set	nomacro
	j	$L741
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L742:
	lw	$4,100($sp)
	jal	purgememadr
	lw	$4,104($sp)
	jal	purgememadr
$L759:
	move	$2,$fp
$L753:
	lw	$31,148($sp)
	lw	$fp,144($sp)
	lw	$23,140($sp)
	lw	$22,136($sp)
	lw	$21,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder

	.end	AudioEng_StartUp__FiPc
	.text
	.ent	AudioEng_StartServer__Fv
AudioEng_StartServer__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(AudioEng_Update__Fv) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDserveradd100hzclient
	addiu	$4,$4,%lo(AudioEng_Update__Fv) # low
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

	.end	AudioEng_StartServer__Fv
	.text
	.ent	AudioEng_StopServer__Fv
AudioEng_StopServer__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(AudioEng_Update__Fv) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDserverremove100hzclient
	addiu	$4,$4,%lo(AudioEng_Update__Fv) # low
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

	.end	AudioEng_StopServer__Fv
	.text
	.ent	AudioEng_Pause__Fv
AudioEng_Pause__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	li	$8,15			# 0x0000000f
	li	$7,4096			# 0x00001000
	la	$5,AudioEng_g
$L772:
	slt	$2,$6,2
	beq	$2,$0,$L778
	lw	$4,0($5)
	#nop
	beq	$4,$0,$L778
	lbu	$2,283($4)
	#nop
	bne	$2,$8,$L777
	lbu	$2,282($4)
	#nop
	addu	$2,$2,1
	andi	$2,$2,0x0001
	bne	$2,$0,$L778
$L777:
	lbu	$2,282($4)
	addu	$5,$5,4
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,90
	addu	$3,$4,$3
	sh	$0,0($3)
	sh	$0,8($3)
	sh	$7,2($3)
	sb	$0,11($3)
	sb	$0,10($3)
	sh	$0,6($3)
	sh	$0,4($3)
	lbu	$2,282($4)
	addu	$6,$6,1
	addu	$2,$2,1
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	j	$L772
	sb	$2,282($4)
	.set	macro
	.set	reorder

$L778:
	j	$31
	.end	AudioEng_Pause__Fv
	.text
	.ent	AudioEng_Resume__Fv
AudioEng_Resume__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AudioEng_Resume__Fv
	.text
	.ent	AudioEng_CleanUp__Fv
AudioEng_CleanUp__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	li	$20,-1			# 0xffffffff
	sw	$21,36($sp)
	la	$21,AudioEng_g
	sw	$19,28($sp)
	move	$19,$21
	sw	$31,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L781:
	addu	$2,$21,8
	slt	$2,$19,$2
	beq	$2,$0,$L780
	lw	$18,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L780
	move	$17,$0
	.set	macro
	.set	reorder

	move	$16,$18
$L789:
	lw	$4,484($16)
	#nop
	beq	$4,$20,$L788
	jal	SNDstop
	lw	$4,676($16)
	#nop
	beq	$4,$20,$L791
	jal	SNDstop
$L791:
	sw	$20,484($16)
	sw	$20,676($16)
$L788:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L789
	addu	$16,$16,12
	.set	macro
	.set	reorder

	lw	$4,876($18)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$0,0($19)
	.set	noreorder
	.set	nomacro
	j	$L781
	addu	$19,$19,4
	.set	macro
	.set	reorder

$L780:
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

	.end	AudioEng_CleanUp__Fv
