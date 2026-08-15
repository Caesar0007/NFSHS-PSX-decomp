	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\skidmark.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	.align	2
	.globl	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	.align	2
	.globl	Skidmark_CheckChunk__FP8coorddefii
	.align	2
	.globl	Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
	.align	2
	.globl	Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
	.align	2
	.globl	Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	.align	2
	.globl	Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	.align	2
	.globl	Skidmark_OnyxBuildFacets__FP13DRender_tView
	.rdata
	.align	2
$LC0:
	.ascii	"SkidMark\000"
	.text
	.align	2
	.globl	Skidmark_InitSkidmark__Fv
	.align	2
	.globl	Skidmark_RestartSkidmark__Fv
	.align	2
	.globl	Skidmark_KillSkidmark__Fv
	.globl	gSm
	.sdata
	.align	2
gSm:
	.space	4
	.globl	gCountSm
	.align	2
gCountSm:
	.space	4
	.globl	gUseSm
	.align	2
gUseSm:
	.space	4
	.globl	gMaxSChunk
	.align	2
gMaxSChunk:
	.space	4
	.globl	Skid_gCtrlPoint_0
	.align	2
Skid_gCtrlPoint_0:
	.space	4
	.globl	Skid_gCtrlPoint_1
	.align	2
Skid_gCtrlPoint_1:
	.space	4
	.globl	Skid_gCtrlPoint_2
	.align	2
Skid_gCtrlPoint_2:
	.space	4
	.globl	Skid_gCtrlPoint_3
	.align	2
Skid_gCtrlPoint_3:
	.space	4
	.globl	Skid_gCtrlPoint_4
	.align	2
Skid_gCtrlPoint_4:
	.space	4
	.globl	Skid_gCtrlPoint_5
	.align	2
Skid_gCtrlPoint_5:
	.space	4
	.globl	Skid_gCtrlPoint_6
	.align	2
Skid_gCtrlPoint_6:
	.space	4
	.globl	Skid_gCtrlScratch_94
	.align	2
Skid_gCtrlScratch_94:
	.space	4
	.globl	Skid_gCtrlScratch_98
	.align	2
Skid_gCtrlScratch_98:
	.space	4
	.globl	Skid_gScratchPos1
	.align	2
Skid_gScratchPos1:
	.space	4
	.globl	Skid_gScratchPos2
	.align	2
Skid_gScratchPos2:
	.space	4

	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	lw	$19,64($sp)
	sw	$21,36($sp)
	move	$21,$4
	sw	$22,40($sp)
	move	$22,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$16,16($sp)
	move	$16,$7
	sw	$31,44($sp)
	sw	$20,32($sp)
	sw	$17,20($sp)
	lw	$4,0($16)
	lw	$5,8($16)
	lw	$20,68($sp)
	lw	$3,0($19)
	lw	$2,8($19)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	intatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$0,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	sra	$17,$2,1
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,0($16)
	lw	$4,0($18)
	addu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,0($21)
	lw	$3,4($16)
	lw	$4,4($18)
	sra	$2,$2,1
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,2($21)
	lw	$3,8($16)
	lw	$4,8($18)
	addu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,4($21)
	lw	$3,0($16)
	lw	$4,0($18)
	subu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,8($21)
	lw	$3,4($16)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,10($21)
	lw	$3,8($16)
	lw	$4,8($18)
	subu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,12($21)
	lw	$3,0($19)
	lw	$4,0($18)
	subu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,8($22)
	lw	$3,4($19)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,10($22)
	lw	$3,8($19)
	lw	$4,8($18)
	subu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,12($22)
	lw	$3,0($19)
	lw	$4,0($18)
	addu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,0($22)
	lw	$3,4($19)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,2($22)
	lw	$3,8($19)
	lw	$4,8($18)
	addu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,4($22)
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

	.end	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	.text
	.ent	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$20,32($sp)
	move	$20,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$16,16($sp)
	move	$16,$7
	sw	$31,36($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
	lw	$4,0($6)
	lw	$2,8($16)
	lw	$5,8($6)
	lw	$18,56($sp)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	intatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$0,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	sra	$17,$2,1
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,0($16)
	lw	$4,0($19)
	addu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,0($20)
	lw	$3,4($16)
	lw	$4,4($19)
	sra	$2,$2,1
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,2($20)
	lw	$3,8($16)
	lw	$4,8($19)
	addu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,4($20)
	lw	$3,0($16)
	lw	$4,0($19)
	subu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,8($20)
	lw	$3,4($16)
	lw	$4,4($19)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,10($20)
	lw	$3,8($16)
	lw	$4,8($19)
	subu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,6
	sh	$3,12($20)
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

	.end	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	.text
	.ent	Skidmark_CheckChunk__FP8coorddefii
Skidmark_CheckChunk__FP8coorddefii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,gUseSm
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,gSm
	sll	$2,$2,4
	addu	$7,$3,$2
	lh	$2,12($7)
	lw	$8,0($7)
	lw	$3,0($4)
	addu	$2,$2,$5
	slt	$2,$2,25
	subu	$5,$8,$3
	.set	noreorder
	.set	nomacro
	blez	$5,$L604
	xori	$9,$2,0x0001
	.set	macro
	.set	reorder

	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	.set	noreorder
	.set	nomacro
	j	$L620
	slt	$2,$2,$5
	.set	macro
	.set	reorder

$L604:
	li	$2,983040			# 0x000f0000
	ori	$2,$2,0xffff
	subu	$3,$3,$8
	slt	$2,$2,$3
$L620:
	bne	$2,$0,$L613
	lw	$8,4($7)
	lw	$3,4($4)
	#nop
	subu	$5,$8,$3
	.set	noreorder
	.set	nomacro
	blez	$5,$L608
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	.set	noreorder
	.set	nomacro
	j	$L621
	slt	$2,$2,$5
	.set	macro
	.set	reorder

$L608:
	ori	$2,$2,0xffff
	subu	$3,$3,$8
	slt	$2,$2,$3
$L621:
	bne	$2,$0,$L613
	lw	$8,8($7)
	lw	$3,8($4)
	#nop
	subu	$5,$8,$3
	.set	noreorder
	.set	nomacro
	blez	$5,$L612
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$5
	beq	$2,$0,$L606
	.set	noreorder
	.set	nomacro
	j	$L606
	li	$9,1			# 0x00000001
	.set	macro
	.set	reorder

$L612:
	ori	$2,$2,0xffff
	subu	$3,$3,$8
	slt	$2,$2,$3
	beq	$2,$0,$L606
$L613:
	li	$9,1			# 0x00000001
$L606:
	beq	$9,$0,$L614
	lw	$3,gCountSm
	lw	$5,gMaxSChunk
	#nop
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$3,gUseSm
	sw	$2,gCountSm
	j	$L616
$L615:
	lw	$3,gUseSm
	addu	$2,$5,-1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sw	$2,gUseSm
	j	$L616
$L617:
	sw	$0,gUseSm
$L616:
	lw	$2,gUseSm
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	lw	$2,gSm
	sll	$3,$3,4
	addu	$7,$2,$3
	sh	$0,12($7)
$L614:
	lh	$2,12($7)
	#nop
	bne	$2,$0,$L619
	lw	$10,0($4)
	lw	$11,4($4)
	lw	$12,8($4)
	sw	$10,0($7)
	sw	$11,4($7)
	sw	$12,8($7)
	sh	$6,14($7)
$L619:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	Skidmark_CheckChunk__FP8coorddefii
	.text
	.ent	Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$20,40($sp)
	lw	$20,72($sp)
	sw	$17,28($sp)
	move	$17,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$21,44($sp)
	move	$21,$6
	sw	$18,32($sp)
	sw	$31,48($sp)
	sw	$16,24($sp)
	lw	$2,20($17)
	lw	$6,76($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	move	$18,$7
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	Skidmark_CheckChunk__FP8coorddefii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$16,$2
	move	$6,$16
	lh	$2,12($16)
	move	$7,$17
	sw	$19,16($sp)
	sw	$18,20($sp)
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$4,$5,16
	addu	$4,$16,$4
	addu	$5,$5,44
	.set	noreorder
	.set	nomacro
	jal	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	addu	$5,$16,$5
	.set	macro
	.set	reorder

	lh	$4,12($16)
	#nop
	addu	$2,$4,1
	sll	$3,$2,3
	subu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$16,$3
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($21)
	lwr	$8,0($21)
	swl	$8,35($3)
	swr	$8,32($3)
	lwl	$8,35($3)
	lwr	$8,32($3)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$4,12($16)
	#nop
	addu	$3,$4,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$20,36($2)
	sll	$2,$4,3
	.set	noreorder
	.set	nomacro
	j	$L626
	subu	$2,$2,$4
	.set	macro
	.set	reorder

$L623:
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	Skidmark_CheckChunk__FP8coorddefii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,24($17)
	lw	$3,gUseSm
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L625
	move	$16,$2
	.set	macro
	.set	reorder

	move	$5,$16
	move	$6,$17
	lh	$2,12($16)
	move	$7,$19
	sw	$18,16($sp)
	sll	$4,$2,3
	subu	$4,$4,$2
	sll	$4,$4,2
	addu	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($21)
	lwr	$8,0($21)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$20,36($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,16
	lw	$3,20($17)
	addu	$2,$16,$2
	sw	$2,24($3)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$0,40($2)
	lw	$2,gUseSm
	lwl	$8,3($21)
	lwr	$8,0($21)
	swl	$8,15($17)
	swr	$8,12($17)
	sw	$20,16($17)
	lw	$8,0($19)
	lw	$9,4($19)
	lw	$10,8($19)
	sw	$8,0($17)
	sw	$9,4($17)
	sw	$10,8($17)
	lh	$3,12($16)
	sw	$2,24($17)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,16
	addu	$2,$16,$2
	sw	$2,20($17)
	lhu	$2,12($16)
	.set	noreorder
	.set	nomacro
	j	$L627
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L625:
	move	$6,$16
	lh	$2,12($16)
	move	$7,$17
	sw	$19,16($sp)
	sw	$18,20($sp)
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$4,$5,16
	addu	$4,$16,$4
	addu	$5,$5,44
	.set	noreorder
	.set	nomacro
	jal	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	addu	$5,$16,$5
	.set	macro
	.set	reorder

	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,15($17)
	lwr	$8,12($17)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,16($17)
	addu	$2,$16,$2
	sw	$3,36($2)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($21)
	lwr	$8,0($21)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
$L626:
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$20,36($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$3,$16,$2
	addu	$2,$2,44
	addu	$2,$16,$2
	sw	$2,40($3)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$0,40($2)
	lw	$2,gUseSm
	lwl	$8,3($21)
	lwr	$8,0($21)
	swl	$8,15($17)
	swr	$8,12($17)
	sw	$20,16($17)
	lw	$8,0($19)
	lw	$9,4($19)
	lw	$10,8($19)
	sw	$8,0($17)
	sw	$9,4($17)
	sw	$10,8($17)
	lh	$3,12($16)
	sw	$2,24($17)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,44
	addu	$2,$16,$2
	sw	$2,20($17)
	lhu	$2,12($16)
	#nop
	addu	$2,$2,2
$L627:
	sh	$2,12($16)
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

	.end	Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
	.text
	.ent	Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii:
	.frame	$sp,64,$31		# vars= 0, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,40($sp)
	lw	$20,80($sp)
	sw	$19,36($sp)
	lw	$19,84($sp)
	sw	$21,44($sp)
	lw	$21,88($sp)
	sw	$22,48($sp)
	move	$22,$4
	sw	$23,52($sp)
	move	$23,$5
	sw	$18,32($sp)
	move	$18,$6
	sw	$17,28($sp)
	sw	$31,56($sp)
	sw	$16,24($sp)
	lw	$2,20($18)
	lw	$6,92($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	move	$17,$7
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Skidmark_CheckChunk__FP8coorddefii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	move	$16,$2
	move	$6,$16
	lh	$2,12($16)
	move	$7,$18
	sw	$17,16($sp)
	sw	$19,20($sp)
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$4,$5,16
	addu	$4,$16,$4
	addu	$5,$5,44
	.set	noreorder
	.set	nomacro
	jal	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	addu	$5,$16,$5
	.set	macro
	.set	reorder

	lh	$4,12($16)
	#nop
	addu	$2,$4,1
	sll	$3,$2,3
	subu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$16,$3
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($20)
	lwr	$8,0($20)
	swl	$8,35($3)
	swr	$8,32($3)
	lwl	$8,35($3)
	lwr	$8,32($3)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$4,12($16)
	#nop
	addu	$3,$4,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$21,36($2)
	sll	$2,$4,3
	.set	noreorder
	.set	nomacro
	j	$L632
	subu	$2,$2,$4
	.set	macro
	.set	reorder

$L629:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Skidmark_CheckChunk__FP8coorddefii
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,24($18)
	lw	$3,gUseSm
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L631
	move	$16,$2
	.set	macro
	.set	reorder

	move	$5,$16
	move	$6,$18
	lh	$2,12($16)
	move	$7,$17
	sw	$19,16($sp)
	sll	$4,$2,3
	subu	$4,$4,$2
	sll	$4,$4,2
	addu	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($20)
	lwr	$8,0($20)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$21,36($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,16
	lw	$3,20($18)
	addu	$2,$16,$2
	sw	$2,24($3)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$0,40($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,16
	addu	$2,$16,$2
	sw	$2,0($22)
	lw	$2,gUseSm
	#nop
	sw	$2,0($23)
	lhu	$2,12($16)
	.set	noreorder
	.set	nomacro
	j	$L633
	addu	$2,$2,1
	.set	macro
	.set	reorder

$L631:
	move	$6,$16
	lh	$2,12($16)
	move	$7,$18
	sw	$17,16($sp)
	sw	$19,20($sp)
	sll	$5,$2,3
	subu	$5,$5,$2
	sll	$5,$5,2
	addu	$4,$5,16
	addu	$4,$16,$4
	addu	$5,$5,44
	.set	noreorder
	.set	nomacro
	jal	CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
	addu	$5,$16,$5
	.set	macro
	.set	reorder

	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,15($18)
	lwr	$8,12($18)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	lw	$3,16($18)
	addu	$2,$16,$2
	sw	$3,36($2)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	lwl	$8,3($20)
	lwr	$8,0($20)
	swl	$8,35($2)
	swr	$8,32($2)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
$L632:
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$21,36($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$3,$16,$2
	addu	$2,$2,44
	addu	$2,$16,$2
	sw	$2,40($3)
	lh	$3,12($16)
	#nop
	addu	$3,$3,1
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$16,$2
	sw	$0,40($2)
	lh	$3,12($16)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,44
	addu	$2,$16,$2
	sw	$2,0($22)
	lw	$2,gUseSm
	#nop
	sw	$2,0($23)
	lhu	$2,12($16)
	#nop
	addu	$2,$2,2
$L633:
	sh	$2,12($16)
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

	.end	Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
	.text
	.ent	Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lw	$2,60($sp)
	sw	$17,28($sp)
	lw	$17,56($sp)
	sw	$16,24($sp)
	move	$16,$4
	sw	$18,32($sp)
	lw	$18,64($sp)
	sw	$31,36($sp)
	sw	$2,16($sp)
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,2
	subu	$2,$2,$5
	sll	$2,$2,2
	subu	$2,$2,$5
	lw	$5,gSm
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	jal	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	addu	$5,$5,$2
	.set	macro
	.set	reorder

	lwl	$3,3($17)
	lwr	$3,0($17)
	swl	$3,19($16)
	swr	$3,16($16)
	sw	$18,20($16)
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	.text
	.ent	Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,32($sp)
	move	$18,$4
	sw	$17,28($sp)
	move	$17,$5
	sw	$16,24($sp)
	move	$16,$6
	sw	$21,44($sp)
	move	$21,$7
	sll	$5,$17,1
	addu	$5,$5,$17
	sll	$5,$5,2
	subu	$5,$5,$17
	sll	$5,$5,2
	subu	$5,$5,$17
	lw	$2,76($sp)
	sll	$5,$5,4
	sw	$19,36($sp)
	lw	$19,72($sp)
	sw	$20,40($sp)
	lw	$20,80($sp)
	sw	$2,16($sp)
	lw	$2,gSm
	sw	$31,48($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	lwl	$3,3($19)
	lwr	$3,0($19)
	swl	$3,19($18)
	swr	$3,16($18)
	sw	$20,20($18)
	lwl	$3,3($19)
	lwr	$3,0($19)
	swl	$3,15($16)
	swr	$3,12($16)
	sw	$20,16($16)
	lw	$3,0($21)
	lw	$8,4($21)
	lw	$9,8($21)
	sw	$3,0($16)
	sw	$8,4($16)
	sw	$9,8($16)
	sw	$18,20($16)
	sw	$17,24($16)
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

	.end	Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	.text
	.ent	Skidmark_OnyxBuildFacets__FP13DRender_tView
Skidmark_OnyxBuildFacets__FP13DRender_tView:
	.frame	$sp,80,$31		# vars= 56, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	move	$3,$4
	lw	$2,gCountSm
	lw	$5,gSm
	addu	$4,$sp,16
	sw	$31,72($sp)
	lw	$7,8($3)
	lw	$8,12($3)
	lw	$9,16($3)
	sw	$7,52($sp)
	sw	$8,56($sp)
	sw	$9,60($sp)
	sw	$2,48($4)
	sw	$5,52($4)
	lw	$5,68($3)
	lw	$2,72($3)
	lw	$6,76($3)
	subu	$2,$0,$2
	sw	$5,16($sp)
	sw	$2,4($4)
	sw	$6,8($4)
	lw	$5,80($3)
	lw	$2,84($3)
	lw	$6,88($3)
	subu	$2,$0,$2
	sw	$5,12($4)
	sw	$2,16($4)
	sw	$6,20($4)
	lw	$5,92($3)
	lw	$2,96($3)
	lw	$6,100($3)
	subu	$2,$0,$2
	sw	$5,24($4)
	sw	$2,28($4)
	.set	noreorder
	.set	nomacro
	jal	Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark
	sw	$6,32($4)
	.set	macro
	.set	reorder

	lw	$31,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Skidmark_OnyxBuildFacets__FP13DRender_tView
	.text
	.ent	Skidmark_InitSkidmark__Fv
Skidmark_InitSkidmark__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,16			# 0x00000010
	sw	$2,gMaxSChunk
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L638
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	sw	$2,gMaxSChunk
$L638:
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	lw	$2,gMaxSChunk
	move	$6,$0
	sll	$5,$2,1
	addu	$5,$5,$2
	sll	$5,$5,2
	subu	$5,$5,$2
	sll	$5,$5,2
	subu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,4
	.set	macro
	.set	reorder

	sh	$0,12($2)
	lw	$31,16($sp)
	sw	$2,gSm
	sw	$0,gCountSm
	sw	$0,gUseSm
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Skidmark_InitSkidmark__Fv
	.text
	.ent	Skidmark_RestartSkidmark__Fv
Skidmark_RestartSkidmark__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,gSm
	sw	$0,gCountSm
	sw	$0,gUseSm
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,12($2)
	.set	macro
	.set	reorder

	.end	Skidmark_RestartSkidmark__Fv
	.text
	.ent	Skidmark_KillSkidmark__Fv
Skidmark_KillSkidmark__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gSm
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L641
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L641:
	lw	$31,16($sp)
	sw	$0,gSm
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Skidmark_KillSkidmark__Fv
