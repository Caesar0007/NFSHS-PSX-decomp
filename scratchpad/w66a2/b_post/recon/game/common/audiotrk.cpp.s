	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\audiotrk.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AudioTrk_Reset__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"trck globals\000"
	.text
	.align	2
	.globl	AudioTrk_StartUp__Fv
	.align	2
	.globl	AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
	.align	2
	.globl	AudioTrk_SoundTrack__FP8Car_tObji
	.align	2
	.globl	AudioTrk_PreLoad__Fv
	.align	2
	.globl	AudioTrk_CleanUp__Fv
	.globl	AudioTrk_g
	.sdata
	.align	2
AudioTrk_g:
	.space	4

	.extern	BWorldSm_slices, 4
	.extern	Anim_gInstanceFromIndex, 32
	.extern	simGlobal, 24
	.extern	gMasterAmbientLevel, 4
	.extern	GameSetup_gData, 2600
	.extern	CopSpeak_gNumTrackSfx, 4
	.extern	AudioClc_gRenderView, 132
	.extern	gGameAudioList, 4

	.text
	.text
	.ent	AudioTrk_Reset__Fv
AudioTrk_Reset__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,AudioTrk_g
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$17,$0
	li	$18,-1			# 0xffffffff
$L602:
	lw	$2,AudioTrk_g
	sll	$16,$17,4
	addu	$2,$2,$16
	lw	$2,4($2)
	#nop
	beq	$2,$18,$L605
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$17,55
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	addu	$2,$2,$16
	sw	$18,4($2)
$L605:
	lw	$2,AudioTrk_g
	addu	$17,$17,1
	addu	$2,$2,$16
	sw	$0,0($2)
	sh	$18,12($2)
	slt	$2,$17,16
	bne	$2,$0,$L602
$L601:
	lw	$3,gGameAudioList
	#nop
	beq	$3,$0,$L600
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L600
	move	$4,$0
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	addu	$3,$3,37
$L608:
	sb	$5,0($3)
	lw	$2,gGameAudioList
	sh	$0,-9($3)
	lw	$2,4($2)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	addu	$3,$3,24
	.set	macro
	.set	reorder

$L600:
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

	.end	AudioTrk_Reset__Fv
	.text
	.ent	AudioTrk_StartUp__Fv
AudioTrk_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,AudioTrk_g
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,256			# 0x00000100
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,AudioTrk_g
	li	$4,-1			# 0xffffffff
	li	$3,15			# 0x0000000f
	addu	$2,$2,240
$L614:
	sw	$4,4($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L614
	addu	$2,$2,-16
	.set	macro
	.set	reorder

$L613:
	jal	AudioTrk_Reset__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioTrk_StartUp__Fv
	.text
	.ent	AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji:
	.frame	$sp,200,$31		# vars= 136, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lw	$2,AudioTrk_g
	subu	$sp,$sp,200
	sw	$20,176($sp)
	move	$20,$4
	sw	$16,160($sp)
	move	$16,$5
	sw	$31,196($sp)
	sw	$fp,192($sp)
	sw	$23,188($sp)
	sw	$22,184($sp)
	sw	$21,180($sp)
	sw	$19,172($sp)
	sw	$18,168($sp)
	sw	$17,164($sp)
	sw	$6,208($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	sw	$7,212($sp)
	.set	macro
	.set	reorder

	lui	$5,%hi(AudioClc_gRenderView) # high
	.set	noreorder
	.set	nomacro
	jal	Math_Dist3D__FP8coorddefT0
	addiu	$5,$5,%lo(AudioClc_gRenderView) # low
	.set	macro
	.set	reorder

	lh	$3,16($20)
	move	$23,$2
	addu	$3,$3,100
	sll	$3,$3,16
	slt	$3,$23,$3
	beq	$3,$0,$L621
	lbu	$2,14($20)
	lw	$3,CopSpeak_gNumTrackSfx
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	move	$18,$0
	.set	macro
	.set	reorder

$L621:
	lb	$4,21($20)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L618
	sll	$3,$4,4
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	addu	$16,$2,$3
	lw	$2,4($16)
	li	$17,-1			# 0xffffffff
	beq	$2,$17,$L625
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$4,55
	.set	macro
	.set	reorder

	sw	$17,4($16)
$L625:
	lw	$2,0($16)
	#nop
	sb	$17,21($2)
	sw	$0,0($16)
	.set	noreorder
	.set	nomacro
	j	$L618
	sh	$17,12($16)
	.set	macro
	.set	reorder

$L623:
	lb	$2,21($20)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L627
	li	$22,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$22,$2
	lw	$3,AudioTrk_g
	sll	$2,$22,4
	.set	noreorder
	.set	nomacro
	j	$L628
	addu	$18,$3,$2
	.set	macro
	.set	reorder

$L627:
	lhu	$2,12($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L680
	move	$17,$0
	.set	macro
	.set	reorder

	bne	$2,$16,$L618
$L680:
	li	$19,-1			# 0xffffffff
$L637:
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	sll	$3,$17,4
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	addu	$3,$2,$3
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L632
	move	$18,$3
 #APP
 #NO_APP
	sw	$20,0($3)
	sw	$19,8($18)
	lbu	$2,23($20)
	lbu	$16,22($20)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	move	$22,$17
	.set	macro
	.set	reorder

	jal	random
	lbu	$3,23($20)
	#nop
	addu	$3,$3,1
	remu	$3,$2,$3
	addu	$16,$16,$3
$L636:
	lw	$2,0($18)
	sh	$16,14($18)
	sb	$22,21($2)
$L632:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L637
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L628:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L638
	move	$21,$0
	.set	macro
	.set	reorder

	move	$19,$21
	move	$16,$21
	li	$fp,-1			# 0xffffffff
$L641:
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L640
	slt	$2,$16,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	sll	$3,$16,4
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	lui	$8,%hi(AudioClc_gRenderView) # high
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	Math_Dist3D__FP8coorddefT0
	addiu	$5,$8,%lo(AudioClc_gRenderView) # low
	.set	macro
	.set	reorder

	lw	$4,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$fp,$L644
	move	$17,$2
	.set	macro
	.set	reorder

	jal	SNDover
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L644
	slt	$2,$19,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L644
	move	$21,$16
	move	$19,$17
$L644:
	.set	noreorder
	.set	nomacro
	j	$L641
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L640:
	slt	$2,$23,$19
	beq	$2,$0,$L647
	move	$22,$21
	lw	$3,AudioTrk_g
	sll	$2,$22,4
	addu	$18,$3,$2
	li	$2,-1			# 0xffffffff
	sw	$20,0($18)
	sw	$2,8($18)
	lbu	$2,23($20)
	lbu	$16,22($20)
	beq	$2,$0,$L648
	jal	random
	lbu	$3,23($20)
	#nop
	addu	$3,$3,1
	remu	$3,$2,$3
	addu	$16,$16,$3
$L648:
	lw	$2,0($18)
	sh	$16,14($18)
	sb	$22,21($2)
$L647:
	beq	$18,$0,$L618
$L638:
	lh	$3,12($18)
	lbu	$2,14($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L650
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,4($18)
	#nop
	beq	$2,$16,$L651
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$22,55
	.set	macro
	.set	reorder

	sw	$16,4($18)
$L651:
	lbu	$2,14($20)
	#nop
	sh	$2,12($18)
$L650:
	lw	$4,4($18)
	li	$16,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$4,$16,$L652
	move	$17,$0
	.set	macro
	.set	reorder

	jal	SNDover
	beq	$2,$0,$L652
	lh	$2,14($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lhu	$2,14($18)
	li	$17,1			# 0x00000001
	sw	$16,4($18)
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	j	$L652
	sh	$2,14($18)
	.set	macro
	.set	reorder

$L653:
	lbu	$3,20($20)
	#nop
	bne	$3,$2,$L656
	lh	$2,16($20)
	#nop
	sll	$2,$2,16
	slt	$2,$2,$23
	beq	$2,$0,$L652
$L656:
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$22,55
	.set	macro
	.set	reorder

	lw	$3,0($18)
	li	$2,-1			# 0xffffffff
	sw	$16,4($18)
	sh	$16,12($18)
	sb	$2,21($3)
	sw	$0,0($18)
$L652:
	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	move	$21,$0
	.set	macro
	.set	reorder

	li	$19,65536			# 0x00010000
	lbu	$3,20($20)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L658
	move	$16,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L658
	li	$17,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,4($18)
	#nop
	beq	$4,$17,$L659
	jal	SNDover
	bne	$2,$0,$L618
$L659:
	lbu	$2,15($20)
	#nop
	sll	$2,$2,16
	slt	$2,$23,$2
	beq	$2,$0,$L660
	lw	$2,8($18)
	#nop
	bne	$2,$17,$L660
	lw	$8,216($sp)
	#nop
	lh	$4,8($8)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	lh	$2,24($sp)
	#nop
	sw	$2,8($18)
$L660:
	lw	$8,216($sp)
	lw	$2,8($18)
	lh	$3,8($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L681
	move	$4,$0
	.set	macro
	.set	reorder

	lbu	$2,15($20)
	#nop
	sll	$2,$2,16
	slt	$2,$2,$23
	beq	$2,$0,$L658
$L681:
	lh	$5,12($18)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$4
	.set	macro
	.set	reorder

	j	$L618
$L658:
	lh	$2,16($20)
	#nop
	sll	$2,$2,16
	slt	$2,$23,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L663
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lbu	$3,20($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L664
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,220($sp)
	.set	noreorder
	.set	nomacro
	j	$L684
	addu	$21,$21,$2
	.set	macro
	.set	reorder

$L664:
	beq	$3,$2,$L665
	lui	$4,%hi(AudioClc_gRenderView) # high
	addiu	$4,$4,%lo(AudioClc_gRenderView) # low
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef
	move	$5,$20
	.set	macro
	.set	reorder

	move	$21,$2
	lw	$5,208($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioClc_CalcDopplerShiftRatio__FP8coorddefT0
	move	$4,$20
	.set	macro
	.set	reorder

	move	$19,$2
$L665:
$L684:
	lbu	$3,20($20)
	addu	$2,$3,-4
	sltu	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L668
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$3,$2,$L670
$L668:
	lh	$16,16($20)
	#nop
	mult	$16,$16
	sra	$4,$23,2
	mflo	$16
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	sra	$3,$16,4
	sll	$3,$3,16
	subu	$3,$3,$2
	div	$3,$3,$16
	lw	$8,212($sp)
	#nop
	sll	$2,$8,7
	subu	$2,$2,$8
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L682
	srl	$16,$3,19
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L663
	srl	$16,$3,19
	.set	macro
	.set	reorder

$L670:
	lbu	$3,15($20)
	#nop
	sll	$4,$3,16
	slt	$2,$23,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L663
	li	$16,127			# 0x0000007f
	.set	macro
	.set	reorder

	lh	$16,16($20)
	#nop
	subu	$16,$16,$3
	mult	$16,$16
	subu	$4,$23,$4
	sra	$4,$4,2
	mflo	$16
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	sra	$3,$16,4
	sll	$3,$3,16
	subu	$3,$3,$2
	div	$3,$3,$16
	sll	$2,$3,7
	subu	$2,$2,$3
	sll	$3,$2,4
	.set	noreorder
	.set	nomacro
	bgez	$3,$L682
	srl	$16,$3,16
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$3,$3,$2
	srl	$16,$3,16
$L663:
$L682:
	li	$2,655360			# 0x000a0000
	slt	$4,$2,$19
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L675
	move	$3,$19
	.set	macro
	.set	reorder

	move	$3,$2
$L675:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L677
	move	$2,$19
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
$L677:
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L683
	move	$19,$3
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	move	$19,$3
$L683:
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	andi	$2,$2,0x0400
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	addu	$4,$22,55
	.set	macro
	.set	reorder

	li	$6,64			# 0x00000040
	lh	$5,12($18)
	andi	$2,$16,0x00ff
	sw	$2,16($sp)
	andi	$2,$21,0xffff
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlaySFX__Fiiiiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	sw	$2,4($18)
$L618:
	lw	$31,196($sp)
	lw	$fp,192($sp)
	lw	$23,188($sp)
	lw	$22,184($sp)
	lw	$21,180($sp)
	lw	$20,176($sp)
	lw	$19,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
	.text
	.ent	AudioTrk_SoundTrack__FP8Car_tObji
AudioTrk_SoundTrack__FP8Car_tObji:
	.frame	$sp,120,$31		# vars= 56, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	sw	$31,116($sp)
	sw	$fp,112($sp)
	sw	$23,108($sp)
	sw	$22,104($sp)
	sw	$21,100($sp)
	sw	$20,96($sp)
	sw	$19,92($sp)
	sw	$18,88($sp)
	sw	$17,84($sp)
	sw	$16,80($sp)
	sw	$4,120($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L724
	sw	$5,124($sp)
	.set	macro
	.set	reorder

	lw	$2,gMasterAmbientLevel
	#nop
	beq	$2,$0,$L724
	lw	$2,AudioTrk_g
	#nop
	beq	$2,$0,$L724
	lw	$4,gGameAudioList
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L724
	lui	$2,%hi(simGlobal+4) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(simGlobal+4)($2)
	lw	$7,4($4)
	sra	$5,$3,1
	sra	$2,$7,2
	addu	$6,$2,1
	sra	$3,$3,3
	lui	$2,%hi(AudioClc_gRenderView) # high
	sw	$3,64($sp)
	addiu	$3,$2,%lo(AudioClc_gRenderView) # low
	lw	$2,%lo(AudioClc_gRenderView)($2)
	addu	$21,$4,16
	sw	$2,68($sp)
	lw	$3,8($3)
	move	$4,$5
	.set	noreorder
	.set	nomacro
	bgez	$5,$L690
	sw	$3,72($sp)
	.set	macro
	.set	reorder

	addu	$4,$5,3
$L690:
	sra	$2,$4,2
	sll	$2,$2,2
	subu	$2,$5,$2
	mult	$2,$6
	move	$fp,$7
	mflo	$3
	#nop
	#nop
	addu	$4,$3,$6
	slt	$2,$fp,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L726
	sll	$2,$3,1
	.set	macro
	.set	reorder

	move	$fp,$4
$L726:
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$21,$21,$2
	move	$23,$3
	addu	$17,$21,20
$L692:
	slt	$2,$23,$fp
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L724
	li	$8,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lb	$3,1($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$8,$L696
	sll	$3,$3,4
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	beq	$2,$21,$L696
	sb	$8,1($17)
$L696:
	lbu	$2,0($17)
	lw	$18,64($sp)
	addu	$2,$2,-4
	sltu	$2,$2,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L697
	move	$20,$0
	.set	macro
	.set	reorder

	lui	$8,%hi(Anim_gInstanceFromIndex) # high
	sw	$0,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	lbu	$2,0($17)
	addiu	$8,$8,%lo(Anim_gInstanceFromIndex) # low
	addu	$2,$2,-4
	sll	$2,$2,2
	addu	$2,$2,$8
	lw	$20,0($2)
	#nop
	beq	$20,$0,$L699
	.set	noreorder
	.set	nomacro
	jal	DrawW_GetAnimationTime__FP15Trk_AnimateInst
	move	$4,$20
	.set	macro
	.set	reorder

	move	$18,$2
	move	$4,$20
	li	$5,1			# 0x00000001
	move	$6,$18
	move	$7,$21
	addu	$2,$sp,56
	sw	$2,16($sp)
	addu	$2,$sp,60
	.set	noreorder
	.set	nomacro
	jal	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	j	$L699
$L697:
	lw	$2,-4($17)
	li	$3,-65536			# 0xffff0000
	and	$2,$2,$3
	beq	$2,$0,$L699
	lhu	$2,-8($17)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	li	$8,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lb	$2,1($17)
	#nop
	bne	$2,$8,$L699
	lbu	$2,-1($17)
	#nop
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L701
	move	$3,$0
	.set	macro
	.set	reorder

	jal	random
	lbu	$3,-1($17)
	#nop
	remu	$3,$2,$3
$L701:
	lbu	$2,-2($17)
	#nop
	addu	$2,$2,$18
	addu	$2,$2,$3
	sh	$2,-8($17)
$L699:
	lw	$2,0($21)
	lw	$8,68($sp)
	#nop
	subu	$4,$2,$8
	bgtz	$4,$L702
	subu	$4,$8,$2
$L702:
	lw	$2,-12($17)
	lw	$8,72($sp)
	#nop
	subu	$3,$2,$8
	bgtz	$3,$L703
	subu	$3,$8,$2
$L703:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L704
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L705
	addu	$3,$4,$2
	.set	macro
	.set	reorder

$L704:
	sra	$2,$4,2
	addu	$3,$3,$2
$L705:
	lh	$2,-4($17)
	#nop
	addu	$2,$2,100
	sll	$2,$2,16
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	move	$22,$0
	.set	macro
	.set	reorder

	lb	$2,1($17)
	#nop
	bltz	$2,$L694
$L727:
	lbu	$2,0($17)
	#nop
	addu	$2,$2,-4
	sltu	$2,$2,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L708
	li	$19,128			# 0x00000080
	.set	macro
	.set	reorder

	beq	$20,$0,$L709
	lbu	$2,-2($17)
	#nop
	sh	$2,-8($17)
	lbu	$2,-5($17)
	lw	$4,56($sp)
	sll	$3,$2,3
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	addu	$2,$3,128
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L711
	move	$19,$22
	.set	macro
	.set	reorder

$L710:
	slt	$2,$4,$2
	beq	$2,$0,$L711
	subu	$19,$4,$3
$L711:
	lbu	$2,-1($17)
	#nop
	sll	$4,$2,3
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L713
	addu	$2,$4,128
	.set	macro
	.set	reorder

	lw	$3,56($sp)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L714
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L713
	move	$19,$0
	.set	macro
	.set	reorder

$L714:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L713
	addu	$2,$3,-128
	.set	macro
	.set	reorder

	subu	$19,$4,$2
$L713:
	.set	noreorder
	.set	nomacro
	blez	$19,$L717
	addu	$3,$18,32
	.set	macro
	.set	reorder

	lw	$2,60($sp)
	#nop
	addu	$16,$2,-1
	slt	$2,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	move	$4,$20
	.set	macro
	.set	reorder

	move	$16,$3
$L728:
	li	$5,1			# 0x00000001
	move	$6,$16
	addu	$7,$sp,40
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	subu	$6,$16,$18
	li	$2,32			# 0x00000020
	bne	$6,$2,$L719
	lw	$2,40($sp)
	lw	$3,0($21)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,1
	sw	$2,24($sp)
	lw	$2,44($sp)
	lw	$3,-16($17)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,1
	sw	$2,28($sp)
	lw	$2,48($sp)
	lw	$3,-12($17)
	addu	$22,$sp,24
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L725
	sll	$2,$2,1
	.set	macro
	.set	reorder

$L719:
	beq	$6,$0,$L717
	lw	$2,40($sp)
	lw	$3,0($21)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,6
	div	$2,$2,$6
	sw	$2,24($sp)
	lw	$2,44($sp)
	lw	$3,-16($17)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,6
	div	$2,$2,$6
	sw	$2,28($sp)
	lw	$2,48($sp)
	lw	$3,-12($17)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,6
	div	$2,$2,$6
	addu	$22,$sp,24
$L725:
	sw	$2,32($sp)
$L717:
	lw	$2,60($sp)
	#nop
	blez	$2,$L722
	rem	$18,$18,$2
$L722:
	sra	$18,$18,3
$L709:
	lbu	$2,0($17)
	#nop
	addu	$2,$2,-4
	sltu	$2,$2,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L729
	move	$4,$21
	.set	macro
	.set	reorder

	beq	$20,$0,$L694
$L708:
	move	$4,$21
$L729:
	move	$5,$18
	lw	$8,120($sp)
	move	$6,$22
	sw	$8,16($sp)
	lw	$8,124($sp)
	move	$7,$19
	.set	noreorder
	.set	nomacro
	jal	AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
	sw	$8,20($sp)
	.set	macro
	.set	reorder

$L694:
	addu	$17,$17,24
	addu	$21,$21,24
	.set	noreorder
	.set	nomacro
	j	$L692
	addu	$23,$23,1
	.set	macro
	.set	reorder

$L724:
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

	.end	AudioTrk_SoundTrack__FP8Car_tObji
	.text
	.ent	AudioTrk_PreLoad__Fv
AudioTrk_PreLoad__Fv:
	.frame	$sp,64,$31		# vars= 8, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	lw	$2,gGameAudioList
	subu	$sp,$sp,64
	sw	$31,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lw	$2,gMasterAmbientLevel
	#nop
	bne	$2,$0,$L731
$L732:
	.set	noreorder
	.set	nomacro
	j	$L749
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L731:
	lw	$2,BWorldSm_slices
	#nop
	lw	$21,0($2)
	lw	$20,8($2)
	.set	noreorder
	.set	nomacro
	jal	gettick
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$3,gGameAudioList
	addu	$23,$2,640
	lw	$22,4($3)
	move	$16,$0
$L750:
	bne	$19,$0,$L736
	jal	gettick
	slt	$2,$2,$23
	beq	$2,$0,$L736
	.set	noreorder
	.set	nomacro
	jal	SNDmemlargestunused
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$3,32768			# 0x00008000
	slt	$16,$3,$2
$L736:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L734
	li	$19,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,gGameAudioList
	move	$18,$0
	addu	$17,$2,16
	addu	$16,$2,30
$L739:
	slt	$2,$18,$22
	beq	$2,$0,$L740
	lw	$2,0($17)
	#nop
	subu	$4,$2,$21
	bgtz	$4,$L743
	subu	$4,$21,$2
$L743:
	lw	$2,-6($16)
	#nop
	subu	$3,$2,$20
	bgtz	$3,$L744
	subu	$3,$20,$2
$L744:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L745
	sra	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L746
	addu	$3,$4,$2
	.set	macro
	.set	reorder

$L745:
	sra	$2,$4,2
	addu	$3,$3,$2
$L746:
	lh	$2,2($16)
	#nop
	addu	$2,$2,100
	sll	$2,$2,16
	slt	$2,$3,$2
	beq	$2,$0,$L741
	lbu	$5,0($16)
	lw	$2,CopSpeak_gNumTrackSfx
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$6,$4
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	bne	$2,$3,$L741
	move	$19,$0
$L741:
	addu	$16,$16,24
	addu	$17,$17,24
	.set	noreorder
	.set	nomacro
	j	$L739
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L740:
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_Server__Fv
	move	$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L750
$L734:
	jal	gettick
	slt	$2,$2,$23
$L749:
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

	.end	AudioTrk_PreLoad__Fv
	.text
	.ent	AudioTrk_CleanUp__Fv
AudioTrk_CleanUp__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioTrk_Reset__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L751
	move	$16,$0
	.set	macro
	.set	reorder

	li	$18,-1			# 0xffffffff
$L753:
	lw	$2,AudioTrk_g
	sll	$17,$16,4
	addu	$2,$2,$17
	lw	$2,4($2)
	#nop
	beq	$2,$18,$L756
	.set	noreorder
	.set	nomacro
	jal	freeVoiceChannel__Fi
	addu	$4,$16,55
	.set	macro
	.set	reorder

	lw	$2,AudioTrk_g
	#nop
	addu	$2,$2,$17
	sw	$18,4($2)
$L756:
	addu	$16,$16,1
	slt	$2,$16,16
	bne	$2,$0,$L753
	lw	$4,AudioTrk_g
	jal	purgememadr
	sw	$0,AudioTrk_g
$L751:
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

	.end	AudioTrk_CleanUp__Fv
