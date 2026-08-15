	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\souffle.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	GetGustWind__FP17Souffle_tISouffle
	.align	2
	.globl	GetAngleWind__FP17Souffle_tISouffle
	.align	2
	.globl	MoveAngleWind__FP17Souffle_tISouffle
	.align	2
	.globl	Souffle_Add__FP8coorddefiT0iii
	.align	2
	.globl	Souffle_DoSouffle__Fv
	.align	2
	.globl	Souffle_CircleClip__FP8coorddefT0i
	.align	2
	.globl	Souffle_InsertFacet__FP13DRender_tView
	.rdata
	.align	2
$LC0:
	.ascii	"souffle\000"
	.text
	.align	2
	.globl	Souffle_InitTrackSouffle__Fv
	.align	2
	.globl	Souffle_RestartTrackSouffle__Fv
	.align	2
	.globl	Souffle_KillTrackSouffle__Fv
	.globl	gISouffle
	.sdata
	.align	2
gISouffle:
	.space	4
	.globl	gCISouffle
	.align	2
gCISouffle:
	.space	4
	.globl	gTMoveSouffle
	.align	2
gTMoveSouffle:
	.space	4
	.globl	gWindDir
	.align	2
gWindDir:
	.space	4

	.extern	Replay_ReplayInterface, 32
	.extern	Replay_ReplayMode, 4
	.extern	simGlobal, 24

	.text
	.text
	.ent	GetGustWind__FP17Souffle_tISouffle
GetGustWind__FP17Souffle_tISouffle:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	random
	move	$16,$4
	.set	macro
	.set	reorder

	andi	$2,$2,0x03ff
	.set	noreorder
	.set	nomacro
	jal	random
	sw	$2,24($16)
	.set	macro
	.set	reorder

	andi	$2,$2,0x03ff
	.set	noreorder
	.set	nomacro
	jal	random
	sw	$2,32($16)
	.set	macro
	.set	reorder

	andi	$2,$2,0x03ff
	addu	$2,$2,2047
	sw	$2,28($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetGustWind__FP17Souffle_tISouffle
	.text
	.ent	GetAngleWind__FP17Souffle_tISouffle
GetAngleWind__FP17Souffle_tISouffle:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	random
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	random
	sw	$2,8($16)
	.set	macro
	.set	reorder

	andi	$2,$2,0x007f
	addu	$2,$2,-63
	sw	$2,4($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetAngleWind__FP17Souffle_tISouffle
	.text
	.ent	MoveAngleWind__FP17Souffle_tISouffle
MoveAngleWind__FP17Souffle_tISouffle:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	lw	$2,8($4)
	move	$5,$3
	addu	$2,$2,$3
	sw	$2,8($4)
	slt	$2,$5,-8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	slt	$2,$5,9
	.set	macro
	.set	reorder

	addu	$2,$5,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

$L603:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L605
	addu	$2,$5,-1
	.set	macro
	.set	reorder

	sw	$2,4($4)
$L605:
	j	$31
	.end	MoveAngleWind__FP17Souffle_tISouffle
	.text
	.ent	Souffle_Add__FP8coorddefiT0iii
Souffle_Add__FP8coorddefiT0iii:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$11,$0
	lw	$3,gCISouffle
	li	$2,60			# 0x0000003c
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L607
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	li	$8,1			# 0x00000001
	lw	$2,gISouffle
	li	$12,60			# 0x0000003c
	addu	$9,$2,68
	lbu	$10,3($2)
$L610:
	lbu	$3,3($9)
	#nop
	slt	$2,$3,$10
	beq	$2,$0,$L611
	move	$11,$8
	move	$10,$3
$L611:
	addu	$8,$8,1
	slt	$2,$8,$12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	addu	$9,$9,68
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L636
	sll	$2,$11,4
	.set	macro
	.set	reorder

$L607:
	move	$11,$3
	addu	$2,$11,1
	sw	$2,gCISouffle
	sll	$2,$11,4
$L636:
	addu	$2,$2,$11
	lw	$3,gISouffle
	sll	$2,$2,2
	addu	$16,$3,$2
	lw	$13,0($4)
	lw	$14,4($4)
	lw	$15,8($4)
	sw	$13,12($16)
	sw	$14,16($16)
	sw	$15,20($16)
	sb	$0,3($16)
	sb	$5,0($16)
	sb	$11,1($16)
	lw	$2,56($sp)
	#nop
	sw	$2,60($16)
	lw	$2,60($sp)
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L614
	sw	$2,64($16)
	.set	macro
	.set	reorder

	addu	$6,$sp,16
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
$L614:
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L629
	slt	$2,$5,10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	li	$2,4			# 0x00000004
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L623
	slt	$2,$5,5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L633
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	blez	$5,$L615
	j	$L619
$L633:
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L629
	slt	$2,$5,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	li	$2,6			# 0x00000006
	.set	macro
	.set	reorder

	beq	$5,$2,$L619
	j	$L615
$L632:
	li	$2,12			# 0x0000000c
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L623
	slt	$2,$5,13
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L623
	li	$2,11			# 0x0000000b
	.set	macro
	.set	reorder

	beq	$5,$2,$L629
	j	$L615
$L634:
	slt	$2,$5,15
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	li	$2,257			# 0x00000101
	.set	macro
	.set	reorder

	beq	$5,$2,$L629
	j	$L615
$L619:
	.set	noreorder
	.set	nomacro
	jal	GetGustWind__FP17Souffle_tISouffle
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sb	$2,2($16)
	.set	noreorder
	.set	nomacro
	j	$L635
	move	$4,$16
	.set	macro
	.set	reorder

$L623:
	sw	$7,56($16)
$L629:
	lw	$2,0($6)
	#nop
	sra	$2,$2,5
	sw	$2,24($16)
	lw	$2,4($6)
	#nop
	sra	$2,$2,6
	sw	$2,28($16)
	lw	$2,8($6)
	move	$4,$16
	sb	$0,2($16)
	sra	$2,$2,5
	sw	$2,32($16)
$L635:
	jal	GetAngleWind__FP17Souffle_tISouffle
$L615:
	.set	noreorder
	.set	nomacro
	jal	Sfx_Add__FP17Souffle_tISouffle
	move	$4,$16
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Souffle_Add__FP8coorddefiT0iii
	.text
	.ent	Souffle_DoSouffle__Fv
Souffle_DoSouffle__Fv:
	.frame	$sp,88,$31		# vars= 48, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,gTMoveSouffle
	subu	$sp,$sp,88
	sw	$31,80($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	subu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	blez	$2,$L637
	sw	$16,64($sp)
	.set	macro
	.set	reorder

	lw	$2,gCISouffle
	sw	$3,gTMoveSouffle
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$4,gWindDir
	#nop
	addu	$4,$4,2
	sw	$4,gWindDir
	jal	fastintcos
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,3276			# 0x00000ccc
	.set	macro
	.set	reorder

	lw	$4,gWindDir
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,3276			# 0x00000ccc
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	sw	$0,20($sp)
$L682:
	lui	$2,%hi(Replay_ReplayInterface) # high
	addiu	$19,$2,%lo(Replay_ReplayInterface) # low
	move	$18,$17
$L640:
	lw	$2,gCISouffle
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L641
	lw	$2,gISouffle
	#nop
	addu	$16,$2,$18
	lw	$8,24($16)
	lw	$9,28($16)
	lw	$10,32($16)
	sw	$8,32($sp)
	sw	$9,36($sp)
	sw	$10,40($sp)
	lbu	$2,2($16)
	#nop
	beq	$2,$0,$L644
	lw	$2,32($sp)
	lw	$3,16($sp)
	lw	$4,20($sp)
	lw	$5,24($sp)
	addu	$2,$2,$3
	sw	$2,32($sp)
	lw	$2,36($sp)
	lw	$3,40($sp)
	addu	$2,$2,$4
	addu	$3,$3,$5
	sw	$2,36($sp)
	sw	$3,40($sp)
$L644:
	lw	$3,Replay_ReplayMode
	li	$2,2			# 0x00000002
	bne	$3,$2,$L645
	lw	$2,4($19)
	#nop
	subu	$4,$3,$2
	blez	$4,$L646
	lw	$2,32($sp)
	lw	$3,40($sp)
	sra	$2,$2,$4
	sw	$2,32($sp)
	lw	$2,36($sp)
	sra	$3,$3,$4
	sw	$3,40($sp)
	sra	$2,$2,$4
	sw	$2,36($sp)
$L646:
	bgez	$4,$L645
	lw	$2,32($sp)
	lw	$3,40($sp)
	sll	$2,$2,1
	sw	$2,32($sp)
	lw	$2,36($sp)
	sll	$3,$3,1
	sw	$3,40($sp)
	sll	$2,$2,1
	sw	$2,36($sp)
$L645:
	lw	$2,12($16)
	lw	$3,32($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,12($16)
	lw	$2,16($16)
	lw	$3,36($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,16($16)
	lw	$2,20($16)
	lw	$3,40($sp)
	lw	$4,24($16)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L648
	sw	$2,20($16)
	.set	macro
	.set	reorder

	addu	$2,$4,2621
	.set	noreorder
	.set	nomacro
	blez	$2,$L650
	sw	$2,24($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L650
	sw	$0,24($16)
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	blez	$4,$L650
	addu	$2,$4,-2621
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L650
	sw	$2,24($16)
	.set	macro
	.set	reorder

	sw	$0,24($16)
$L650:
	lw	$2,32($16)
	#nop
	bgez	$2,$L652
	addu	$2,$2,2621
	.set	noreorder
	.set	nomacro
	blez	$2,$L654
	sw	$2,32($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L654
	sw	$0,32($16)
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	blez	$2,$L654
	addu	$2,$2,-2621
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L654
	sw	$2,32($16)
	.set	macro
	.set	reorder

	sw	$0,32($16)
$L654:
	lbu	$3,0($16)
	li	$2,13			# 0x0000000d
	bne	$3,$2,$L656
	lw	$8,36($16)
	lw	$9,40($16)
	lw	$10,44($16)
	sw	$8,48($sp)
	sw	$9,52($sp)
	sw	$10,56($sp)
	lw	$4,8($16)
	jal	fastintsin
	move	$5,$2
	lw	$3,Replay_ReplayMode
	li	$2,2			# 0x00000002
	bne	$3,$2,$L657
	lw	$2,4($19)
	#nop
	subu	$4,$3,$2
	blez	$4,$L658
	lw	$2,48($sp)
	lw	$3,56($sp)
	sra	$2,$2,$4
	sw	$2,48($sp)
	lw	$2,52($sp)
	sra	$3,$3,$4
	sw	$3,56($sp)
	sra	$2,$2,$4
	sw	$2,52($sp)
$L658:
	bgez	$4,$L657
	lw	$2,48($sp)
	lw	$3,56($sp)
	sll	$2,$2,1
	sw	$2,48($sp)
	lw	$2,52($sp)
	sll	$3,$3,1
	sw	$3,56($sp)
	sll	$2,$2,1
	sw	$2,52($sp)
$L657:
	lw	$2,48($sp)
	#nop
	mult	$2,$5
	lw	$2,12($16)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,17
	addu	$2,$2,$3
	sw	$2,12($16)
	lw	$2,56($sp)
	#nop
	mult	$2,$5
	lw	$4,36($16)
	lw	$2,20($16)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,17
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L660
	sw	$2,20($16)
	.set	macro
	.set	reorder

	addu	$2,$4,327
	.set	noreorder
	.set	nomacro
	blez	$2,$L662
	sw	$2,36($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L662
	sw	$0,36($16)
	.set	macro
	.set	reorder

$L660:
	.set	noreorder
	.set	nomacro
	blez	$4,$L662
	addu	$2,$4,-327
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L662
	sw	$2,36($16)
	.set	macro
	.set	reorder

	sw	$0,36($16)
$L662:
	lw	$2,44($16)
	#nop
	bgez	$2,$L664
	addu	$2,$2,327
	.set	noreorder
	.set	nomacro
	blez	$2,$L666
	sw	$2,44($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L666
	sw	$0,44($16)
	.set	macro
	.set	reorder

$L664:
	.set	noreorder
	.set	nomacro
	blez	$2,$L666
	addu	$2,$2,-327
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L666
	sw	$2,44($16)
	.set	macro
	.set	reorder

	sw	$0,44($16)
$L666:
	lw	$3,16($16)
	lw	$2,60($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L668
	.set	noreorder
	.set	nomacro
	j	$L656
	sb	$0,0($16)
	.set	macro
	.set	reorder

$L668:
	lw	$2,28($16)
	#nop
	addu	$2,$2,-327
	sw	$2,28($16)
$L656:
	.set	noreorder
	.set	nomacro
	jal	MoveAngleWind__FP17Souffle_tISouffle
	move	$4,$16
	.set	macro
	.set	reorder

	lbu	$2,3($16)
	#nop
	addu	$2,$2,-1
	sb	$2,3($16)
	andi	$2,$2,0x00ff
	bne	$2,$0,$L642
	sb	$0,0($16)
$L642:
	addu	$18,$18,68
	.set	noreorder
	.set	nomacro
	j	$L640
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L641:
	lw	$4,gCISouffle
	#nop
	.set	noreorder
	.set	nomacro
	blez	$4,$L637
	move	$17,$0
	.set	macro
	.set	reorder

	move	$7,$17
$L674:
	lw	$6,gISouffle
	#nop
	addu	$3,$7,$6
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	move	$5,$3
	.set	macro
	.set	reorder

	sll	$2,$4,4
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$6
	addu	$3,$2,-68
	addu	$2,$2,-4
$L676:
	lw	$9,0($3)
	lw	$10,4($3)
	lw	$11,8($3)
	lw	$8,12($3)
	sw	$9,0($5)
	sw	$10,4($5)
	sw	$11,8($5)
	sw	$8,12($5)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L676
	addu	$5,$5,16
	.set	macro
	.set	reorder

	addu	$7,$7,-68
	lw	$2,gCISouffle
	addu	$17,$17,-1
	lw	$9,0($3)
	sw	$9,0($5)
	addu	$2,$2,-1
	sw	$2,gCISouffle
$L673:
	lw	$4,gCISouffle
	addu	$17,$17,1
	slt	$2,$17,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L674
	addu	$7,$7,68
	.set	macro
	.set	reorder

$L637:
	lw	$31,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Souffle_DoSouffle__Fv
	.text
	.ent	Souffle_CircleClip__FP8coorddefT0i
Souffle_CircleClip__FP8coorddefT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($4)
	lw	$2,0($5)
	#nop
	subu	$7,$3,$2
	bgtz	$7,$L684
	subu	$7,$2,$3
$L684:
	lw	$4,8($4)
	lw	$5,8($5)
	#nop
	subu	$3,$4,$5
	.set	noreorder
	.set	nomacro
	bgtz	$3,$L688
	slt	$2,$3,$7
	.set	macro
	.set	reorder

	subu	$3,$5,$4
	slt	$2,$3,$7
$L688:
	beq	$2,$0,$L686
	sra	$2,$3,2
	.set	noreorder
	.set	nomacro
	j	$L687
	addu	$2,$7,$2
	.set	macro
	.set	reorder

$L686:
	sra	$2,$7,2
	addu	$2,$3,$2
$L687:
	.set	noreorder
	.set	nomacro
	j	$31
	slt	$2,$2,$6
	.set	macro
	.set	reorder

	.end	Souffle_CircleClip__FP8coorddefT0i
	.text
	.ent	Souffle_InsertFacet__FP13DRender_tView
Souffle_InsertFacet__FP13DRender_tView:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$19,28($sp)
	move	$19,$0
	sw	$20,32($sp)
	addu	$20,$21,8
	sw	$18,24($sp)
	move	$18,$19
	sw	$31,40($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L690:
	lw	$2,gCISouffle
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L689
	move	$5,$20
	.set	macro
	.set	reorder

	lw	$2,gISouffle
	li	$6,3276800			# 0x00320000
	addu	$16,$2,$18
	addu	$17,$16,12
	.set	noreorder
	.set	nomacro
	jal	Souffle_CircleClip__FP8coorddefT0i
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	lbu	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L695
	move	$4,$17
	.set	macro
	.set	reorder

	addu	$5,$16,48
	.set	noreorder
	.set	nomacro
	jal	Sfx_Transform__FP8coorddefP7SVECTORT0
	move	$6,$20
	.set	macro
	.set	reorder

	lh	$2,48($16)
	lh	$3,52($16)
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	bne	$3,$0,$L698
	lbu	$2,0($16)
	#nop
	beq	$2,$0,$L698
$L695:
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
	move	$5,$16
	.set	macro
	.set	reorder

$L698:
	addu	$18,$18,68
	.set	noreorder
	.set	nomacro
	j	$L690
	addu	$19,$19,1
	.set	macro
	.set	reorder

$L689:
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

	.end	Souffle_InsertFacet__FP13DRender_tView
	.text
	.ent	Souffle_InitTrackSouffle__Fv
Souffle_InitTrackSouffle__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(simGlobal+4) # high
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,4080			# 0x00000ff0
	lw	$2,%lo(simGlobal+4)($2)
	sw	$31,16($sp)
	sw	$0,gWindDir
	sw	$0,gCISouffle
	sw	$2,gTMoveSouffle
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$2,gISouffle
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Souffle_InitTrackSouffle__Fv
	.text
	.ent	Souffle_RestartTrackSouffle__Fv
Souffle_RestartTrackSouffle__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	sw	$0,gWindDir
	sw	$0,gCISouffle
	sw	$2,gTMoveSouffle
	j	$31
	.end	Souffle_RestartTrackSouffle__Fv
	.text
	.ent	Souffle_KillTrackSouffle__Fv
Souffle_KillTrackSouffle__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gISouffle
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L706
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L706:
	lw	$31,16($sp)
	sw	$0,gISouffle
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Souffle_KillTrackSouffle__Fv
