	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\bworldSm.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	GlobalSimQuad
	.sdata
	.align	2
GlobalSimQuad:
	.byte	14
	.text
	.align	2
	.globl	BWorldSm_Init__FP5Group
	.align	2
	.globl	BWorldSm_Restart__Fv
	.align	2
	.globl	BWorldSm_DeInit__Fv
	.align	2
	.globl	FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	.align	2
	.globl	GetStmQuadPts__FP12BWorldSm_PosP8coorddef
	.align	2
	.globl	SetStrip__FP12BWorldSm_Pos
	.align	2
	.globl	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	.align	2
	.globl	BWorld_SetSimSlice__FP12BWorldSm_Pos
	.align	2
	.globl	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	.align	2
	.globl	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos

	.lcomm	sliceOffs.254,48
	.align	2
	.globl	RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos

	.lcomm	corrPt.257,12
	.align	2
	.globl	FindClosestQuad__FP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	.align	2
	.globl	BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi
	.align	2
	.globl	PointDirection__FP8coorddefN20
	.align	2
	.globl	BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
	.align	2
	.globl	BWorldSm_QuadLight__FP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	.align	2
	.globl	NormalCache_AddEntry__FP12BWorldSm_Pos
	.align	2
	.globl	NormalCache_FindEntry__FP12BWorldSm_Pos
	.align	2
	.globl	NormalCache_Init__Fv
	.align	2
	.globl	Check_Rot__FP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_UNormal__FP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_UForward__FP12BWorldSm_Pos
	.align	2
	.globl	BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
	.globl	BWSM_NormalCache
	.data
	.align	2
BWSM_NormalCache:
	.space	512
	.globl	BWorldSm_slices
	.sdata
	.align	2
BWorldSm_slices:
	.space	4
	.globl	sim_Handle
	.align	2
sim_Handle:
	.space	4
	.globl	gNumSlices
	.align	2
gNumSlices:
	.space	4
	.globl	sim_File
	.align	2
sim_File:
	.space	4
	.globl	sim_ItemPtr
	.align	2
sim_ItemPtr:
	.space	4
	.globl	gMaxFindQuadSliceIterations
	.align	2
gMaxFindQuadSliceIterations:
	.space	4
	.globl	BWSM_NormalCacheSysTime
	.align	2
BWSM_NormalCacheSysTime:
	.space	4

	.extern	Chunk_lightTable, 4
	.extern	Chunk_chunkCenters, 4
	.extern	Track_chunkList, 4

	.text
	.text
	.ent	BWorldSm_Init__FP5Group
BWorldSm_Init__FP5Group:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,0($4)
	addu	$2,$4,4
	sw	$2,BWorldSm_slices
	li	$2,5			# 0x00000005
	sw	$2,gMaxFindQuadSliceIterations
	sw	$3,gNumSlices
	jal	BWorldSm_Restart__Fv
	lw	$31,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorldSm_Init__FP5Group
	.text
	.ent	BWorldSm_Restart__Fv
BWorldSm_Restart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	NormalCache_Init__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorldSm_Restart__Fv
	.text
	.ent	BWorldSm_DeInit__Fv
BWorldSm_DeInit__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	BWorldSm_DeInit__Fv
	.text
	.ent	FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	move	$20,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$17,20($sp)
	li	$17,2147418112			# 0x7fff0000
	sw	$18,24($sp)
	lw	$18,gNumSlices
	ori	$17,$17,0xffff
	sw	$19,28($sp)
	li	$19,-1			# 0xffffffff
	sw	$16,16($sp)
	move	$16,$0
	.set	noreorder
	.set	nomacro
	blez	$18,$L605
	sw	$31,40($sp)
	.set	macro
	.set	reorder

$L607:
	lw	$2,BWorldSm_slices
	sll	$4,$16,5
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	xzsquaredist32__FP8coorddefT0
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	move	$3,$2
	slt	$2,$3,$17
	beq	$2,$0,$L606
	move	$19,$16
	move	$17,$3
$L606:
	addu	$16,$16,8
	slt	$2,$16,$18
	bne	$2,$0,$L607
$L605:
	sh	$19,0($21)
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

	.end	FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	move	$5,$17
	sw	$31,28($sp)
	sw	$18,24($sp)
	lh	$18,0($16)
	lw	$2,BWorldSm_slices
	sll	$4,$18,5
	.set	noreorder
	.set	nomacro
	jal	Math_DistXZ__FP8coorddefT0
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	li	$3,8388608			# 0x00800000
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L611
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos
	move	$5,$16
	.set	macro
	.set	reorder

$L611:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
	move	$5,$16
	.set	macro
	.set	reorder

	lh	$3,0($16)
	lw	$4,BWorldSm_slices
	lh	$2,0($16)
	sll	$3,$3,5
	addu	$3,$3,$4
	xor	$2,$2,$18
	lbu	$3,28($3)
	sltu	$2,$0,$2
	sb	$2,89($16)
	sb	$2,88($16)
	sb	$3,117($16)
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

	.end	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$11,$4
	li	$14,-1			# 0xffffffff
	lw	$2,gNumSlices
	lh	$6,0($5)
	lw	$12,BWorldSm_slices
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L614
	addu	$13,$2,$14
	.set	macro
	.set	reorder

	move	$9,$2
	slt	$2,$6,$13
$L635:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	move	$14,$6
	.set	macro
	.set	reorder

	sll	$4,$6,5
	lw	$2,0($11)
	.set	noreorder
	.set	nomacro
	j	$L633
	addu	$4,$4,$12
	.set	macro
	.set	reorder

$L618:
	rem	$4,$6,$9
	lw	$2,0($11)
	sll	$4,$4,5
	addu	$4,$4,$12
$L633:
	lw	$3,0($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	lw	$2,8($11)
	lw	$3,8($4)
	mflo	$7
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	mflo	$2
	#nop
	#nop
	addu	$10,$7,$2
	addu	$2,$13,-1
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L622
	sll	$4,$6,5
	.set	macro
	.set	reorder

	addu	$4,$4,$12
	lw	$2,0($11)
	lw	$3,32($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	lw	$2,8($11)
	lw	$3,40($4)
	mflo	$7
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	mflo	$2
	#nop
	#nop
	addu	$2,$7,$2
	slt	$2,$2,$10
	beq	$2,$0,$L624
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L622:
	addu	$2,$6,1
	rem	$8,$2,$9
	lw	$2,0($11)
	sll	$4,$8,5
	addu	$4,$4,$12
	lw	$3,0($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	lw	$2,8($11)
	lw	$3,8($4)
	mflo	$7
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	mflo	$2
	#nop
	#nop
	addu	$2,$7,$2
	slt	$2,$2,$10
	beq	$2,$0,$L624
	.set	noreorder
	.set	nomacro
	j	$L617
	move	$6,$8
	.set	macro
	.set	reorder

$L624:
	.set	noreorder
	.set	nomacro
	blez	$6,$L627
	sll	$4,$6,5
	.set	macro
	.set	reorder

	addu	$4,$4,$12
	lw	$2,0($11)
	lw	$3,-32($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	lw	$2,8($11)
	lw	$3,-24($4)
	mflo	$7
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	mflo	$2
	#nop
	#nop
	addu	$2,$7,$2
	slt	$2,$2,$10
	beq	$2,$0,$L617
	.set	noreorder
	.set	nomacro
	j	$L617
	addu	$6,$6,-1
	.set	macro
	.set	reorder

$L627:
	addu	$2,$6,1
	addu	$6,$2,$13
	addu	$7,$6,-1
	rem	$4,$7,$9
	lw	$2,0($11)
	sll	$4,$4,5
	addu	$4,$4,$12
	lw	$3,0($4)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	lw	$2,8($11)
	lw	$3,8($4)
	mflo	$8
	#nop
	subu	$2,$2,$3
	sra	$2,$2,9
	mult	$2,$2
	mflo	$2
	#nop
	#nop
	addu	$2,$8,$2
	slt	$2,$2,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	addu	$2,$6,1
	.set	macro
	.set	reorder

	move	$6,$7
	addu	$2,$6,1
$L634:
	addu	$6,$2,$13
	rem	$6,$6,$9
$L617:
	.set	noreorder
	.set	nomacro
	bne	$14,$6,$L635
	slt	$2,$6,$13
	.set	macro
	.set	reorder

$L614:
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$6,0($5)
	.set	macro
	.set	reorder

	.end	RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	BWorldSm_SetSlice__FiP12BWorldSm_Pos
BWorldSm_SetSlice__FiP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sh	$4,0($5)
	lh	$2,0($5)
	sb	$0,88($5)
	sb	$0,89($5)
	sb	$0,90($5)
	lw	$3,BWorldSm_slices
	sw	$0,128($5)
	sw	$0,120($5)
	sh	$0,4($5)
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$3,28($2)
	li	$2,-2			# 0xfffffffe
	sb	$2,118($5)
	li	$2,1			# 0x00000001
	sb	$2,119($5)
	li	$2,-1			# 0xffffffff
	sb	$0,91($5)
	sb	$2,116($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$3,117($5)
	.set	macro
	.set	reorder

	.end	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	.text
	.ent	GetStmQuadPts__FP12BWorldSm_PosP8coorddef
GetStmQuadPts__FP12BWorldSm_PosP8coorddef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$11,0($5)
	lw	$10,4($5)
	lw	$9,8($5)
	addu	$5,$4,8
	lw	$2,124($4)
	lbu	$3,117($4)
	lh	$12,2($4)
	lbu	$6,0($2)
	lbu	$7,1($2)
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	addu	$6,$6,$12
	sll	$6,$6,3
	lw	$8,108($2)
	addu	$7,$7,$12
	addu	$8,$8,4
	addu	$6,$6,$8
	lh	$2,8($6)
	addu	$3,$6,8
	sll	$2,$2,10
	addu	$14,$11,$2
	lh	$2,2($3)
	sll	$7,$7,3
	sll	$2,$2,10
	addu	$13,$10,$2
	lh	$2,4($3)
	addu	$7,$7,$8
	sw	$14,12($5)
	sw	$13,16($5)
	sll	$2,$2,10
	addu	$2,$9,$2
	sw	$2,20($5)
	lh	$2,0($6)
	lh	$3,2($6)
	sll	$2,$2,10
	addu	$14,$11,$2
	sll	$3,$3,10
	lh	$2,4($6)
	addu	$13,$10,$3
	sw	$14,24($5)
	sw	$13,28($5)
	sll	$2,$2,10
	addu	$2,$9,$2
	sw	$2,32($5)
	lh	$2,0($7)
	lh	$3,2($7)
	sll	$2,$2,10
	addu	$14,$11,$2
	sll	$3,$3,10
	lh	$2,4($7)
	addu	$13,$10,$3
	sw	$14,36($5)
	sw	$13,40($5)
	sll	$2,$2,10
	addu	$2,$9,$2
	sw	$2,44($5)
	lh	$2,8($7)
	addu	$7,$7,8
	lh	$3,2($7)
	sll	$2,$2,10
	addu	$14,$11,$2
	sll	$3,$3,10
	lh	$2,4($7)
	addu	$13,$10,$3
	sw	$14,8($4)
	sw	$13,4($5)
	sll	$2,$2,10
	addu	$2,$9,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,8($5)
	.set	macro
	.set	reorder

	.end	GetStmQuadPts__FP12BWorldSm_PosP8coorddef
	.text
	.ent	SetStrip__FP12BWorldSm_Pos
SetStrip__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$3,117($4)
	move	$5,$0
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,128($4)
	lw	$2,56($2)
	lbu	$6,0($3)
	addu	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L641
	sw	$2,124($4)
	.set	macro
	.set	reorder

$L642:
	lw	$2,124($4)
	#nop
	lbu	$3,2($2)
	addu	$5,$5,1
	sll	$3,$3,1
	addu	$3,$3,4
	addu	$2,$2,$3
	sw	$2,124($4)
	slt	$2,$5,$6
	bne	$2,$0,$L642
$L641:
	lw	$2,124($4)
	lb	$5,116($4)
	lbu	$3,2($2)
	#nop
	slt	$2,$5,$3
	bne	$2,$0,$L647
	subu	$5,$5,$3
$L650:
	sll	$2,$3,1
	lw	$3,124($4)
	addu	$2,$2,4
	addu	$3,$3,$2
	sw	$3,124($4)
	lbu	$3,2($3)
	#nop
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L650
	subu	$5,$5,$3
	.set	macro
	.set	reorder

	addu	$5,$5,$3
$L647:
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,2($4)
	.set	macro
	.set	reorder

	.end	SetStrip__FP12BWorldSm_Pos
	.text
	.ent	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16:
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
	jal	SetStrip__FP12BWorldSm_Pos
	move	$17,$5
	.set	macro
	.set	reorder

	addu	$4,$16,56
	lw	$3,124($16)
	lh	$5,2($16)
	lbu	$2,0($3)
	lbu	$3,1($3)
	addu	$2,$2,$5
	sll	$2,$2,3
	addu	$2,$2,$17
	addu	$3,$3,$5
	lhu	$6,8($2)
	lhu	$7,12($2)
	sll	$3,$3,3
	sh	$6,8($4)
	sh	$7,12($4)
	lhu	$6,0($2)
	lhu	$7,4($2)
	addu	$3,$3,$17
	sh	$6,16($4)
	sh	$7,20($4)
	lhu	$6,0($3)
	lhu	$7,4($3)
	sh	$6,24($4)
	sh	$7,28($4)
	lhu	$6,8($3)
	lhu	$7,12($3)
	sh	$6,56($16)
	sh	$7,4($4)
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

	.end	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	.text
	.ent	BWorld_SetSimSlice__FP12BWorldSm_Pos
BWorld_SetSimSlice__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($4)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,28($2)
	#nop
	sb	$2,117($4)
	andi	$3,$2,0x00ff
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$5,72($2)
	lh	$3,0($4)
	lh	$2,104($2)
	addu	$5,$5,4
	subu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,128($4)
	.set	macro
	.set	reorder

	.end	BWorld_SetSimSlice__FP12BWorldSm_Pos
	.text
	.ent	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
BworldSm_UpdateSimQuad__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,128($4)
	lb	$3,116($4)
	lbu	$2,4($5)
	#nop
	subu	$6,$3,$2
	bltz	$6,$L654
	lbu	$2,3($5)
	#nop
	slt	$2,$6,$2
	beq	$2,$0,$L654
	lbu	$3,117($4)
	#nop
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$3,76($2)
	move	$2,$5
	addu	$3,$3,4
	sw	$3,120($4)
	lbu	$2,2($2)
	#nop
	addu	$2,$2,$6
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,120($4)
	.set	macro
	.set	reorder

$L654:
	la	$2,GlobalSimQuad
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,120($4)
	.set	macro
	.set	reorder

	.end	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	.text
	.ent	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
BworldSm_IsSimQuadValid__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,120($4)
	#nop
	bne	$2,$0,$L656
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L656:
	lbu	$2,0($2)
	#nop
	andi	$2,$2,0x000f
	xori	$2,$2,0x000e
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

	.end	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
	.text
	.ent	RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$fp,56($sp)
	move	$fp,$4
	sw	$16,24($sp)
	move	$16,$5
	sw	$19,36($sp)
	move	$19,$0
	move	$4,$16
	sw	$31,60($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$0,120($16)
	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSimSlice__FP12BWorldSm_Pos
	sh	$0,4($16)
	.set	macro
	.set	reorder

	lb	$3,116($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$3,$L659
	move	$22,$19
	.set	macro
	.set	reorder

	lw	$2,128($16)
	#nop
	lbu	$2,1($2)
	#nop
	addu	$2,$2,-1
	slt	$2,$3,$2
	beq	$2,$0,$L659
	lb	$2,90($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	move	$21,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L731
	move	$23,$0
	.set	macro
	.set	reorder

$L716:
	move	$4,$16
	move	$5,$20
	li	$2,2			# 0x00000002
	sb	$2,119($4)
	.set	noreorder
	.set	nomacro
	jal	GetStmQuadPts__FP12BWorldSm_PosP8coorddef
	sb	$0,90($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L713
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L659:
	lw	$2,128($16)
	#nop
	lbu	$2,1($2)
	#nop
	addu	$2,$2,-1
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sll	$3,$2,24
	sra	$21,$3,24
	sb	$2,116($16)
	move	$23,$0
$L731:
	sb	$0,90($16)
	sb	$21,116($16)
$L661:
	lw	$2,gMaxFindQuadSliceIterations
	#nop
	slt	$2,$19,$2
	beq	$2,$0,$L662
	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSimSlice__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,128($16)
	sb	$21,116($16)
	lbu	$3,1($2)
	#nop
	addu	$2,$3,-1
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	addu	$2,$3,-2
	.set	macro
	.set	reorder

	sb	$2,116($16)
$L664:
	lbu	$3,117($16)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,Chunk_chunkCenters
	sll	$2,$2,2
	addu	$20,$3,$2
	lw	$2,0($fp)
	lw	$3,0($20)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,16($sp)
	lw	$2,8($fp)
	lw	$3,8($20)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,20($sp)
	lbu	$3,117($16)
	li	$17,2147418112			# 0x7fff0000
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,108($2)
	move	$4,$16
	addu	$18,$2,4
	.set	noreorder
	.set	nomacro
	jal	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,128($16)
	.set	noreorder
	.set	nomacro
	j	$L718
	ori	$17,$17,0xffff
	.set	macro
	.set	reorder

$L667:
	.set	noreorder
	.set	nomacro
	jal	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	move	$5,$18
	.set	macro
	.set	reorder

	lh	$6,64($16)
	lh	$10,72($16)
	lh	$11,20($sp)
	lh	$12,76($16)
	subu	$3,$6,$10
	subu	$2,$11,$12
	mult	$3,$2
	lh	$9,16($sp)
	lh	$4,68($16)
	mflo	$5
	#nop
	subu	$3,$9,$10
	subu	$2,$4,$12
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L668
	subu	$2,$11,$4
	.set	macro
	.set	reorder

	lh	$8,56($16)
	#nop
	subu	$3,$8,$6
	mult	$3,$2
	lh	$7,60($16)
	mflo	$5
	#nop
	subu	$3,$9,$6
	subu	$2,$7,$4
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$5,$3
	bgtz	$2,$L668
	lh	$4,80($16)
	lh	$5,84($16)
	subu	$3,$10,$4
	subu	$2,$11,$5
	mult	$3,$2
	mflo	$6
	#nop
	subu	$3,$9,$4
	subu	$2,$12,$5
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$6,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L668
	subu	$3,$4,$8
	.set	macro
	.set	reorder

	subu	$2,$11,$7
	mult	$3,$2
	mflo	$4
	#nop
	subu	$3,$9,$8
	subu	$2,$5,$7
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$4,$3
	bgtz	$2,$L668
	.set	noreorder
	.set	nomacro
	jal	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L716
$L668:
	lw	$2,128($16)
	#nop
	lbu	$2,1($2)
	lb	$3,116($16)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L715
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L670
	lh	$3,16($sp)
	lh	$2,80($16)
	#nop
	subu	$8,$3,$2
	bgtz	$8,$L671
	subu	$8,$2,$3
$L671:
	lh	$2,72($16)
	#nop
	subu	$7,$3,$2
	bgtz	$7,$L672
	subu	$7,$2,$3
$L672:
	lh	$2,64($16)
	#nop
	subu	$6,$3,$2
	bgtz	$6,$L673
	subu	$6,$2,$3
$L673:
	lh	$2,56($16)
	#nop
	subu	$5,$3,$2
	bgtz	$5,$L674
	subu	$5,$2,$3
$L674:
	lh	$4,20($sp)
	lh	$2,60($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L675
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L729
	addu	$5,$5,$3
	.set	macro
	.set	reorder

$L675:
	addu	$5,$5,$2
	lh	$4,20($sp)
$L729:
	lh	$2,68($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L677
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L719
	addu	$2,$6,$3
	.set	macro
	.set	reorder

$L677:
	addu	$2,$6,$2
$L719:
	addu	$5,$5,$2
	lh	$4,20($sp)
	lh	$2,76($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L679
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L720
	addu	$2,$7,$3
	.set	macro
	.set	reorder

$L679:
	addu	$2,$7,$2
$L720:
	addu	$5,$5,$2
	lh	$4,20($sp)
	lh	$2,84($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L681
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L721
	addu	$2,$8,$3
	.set	macro
	.set	reorder

$L681:
	addu	$2,$8,$2
$L721:
	addu	$2,$5,$2
	move	$3,$2
	subu	$2,$3,$17
	slt	$2,$2,41
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	li	$17,2147418112			# 0x7fff0000
	.set	macro
	.set	reorder

	move	$17,$3
$L670:
	lbu	$2,116($16)
	move	$4,$16
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	sb	$2,116($16)
	.set	macro
	.set	reorder

	lw	$2,128($16)
$L718:
	lbu	$2,1($2)
	lb	$3,116($16)
	addu	$2,$2,-1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	move	$4,$16
	.set	macro
	.set	reorder

$L666:
	li	$17,2147418112			# 0x7fff0000
$L727:
	lb	$2,90($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L685
	ori	$17,$17,0xffff
	.set	macro
	.set	reorder

	bne	$19,$0,$L685
	lw	$2,128($16)
	#nop
	lbu	$2,1($2)
	.set	noreorder
	.set	nomacro
	j	$L722
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L715:
	.set	noreorder
	.set	nomacro
	j	$L666
	sb	$2,90($16)
	.set	macro
	.set	reorder

$L717:
	.set	noreorder
	.set	nomacro
	j	$L689
	sb	$2,90($16)
	.set	macro
	.set	reorder

$L685:
	addu	$2,$21,-1
$L722:
	sb	$2,116($16)
	lb	$2,116($16)
	#nop
	bgez	$2,$L687
	sb	$0,116($16)
$L687:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L723
	move	$4,$16
	.set	macro
	.set	reorder

$L690:
	.set	noreorder
	.set	nomacro
	jal	GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16
	move	$5,$18
	.set	macro
	.set	reorder

	lh	$6,64($16)
	lh	$10,72($16)
	lh	$11,20($sp)
	lh	$12,76($16)
	subu	$3,$6,$10
	subu	$2,$11,$12
	mult	$3,$2
	lh	$9,16($sp)
	lh	$4,68($16)
	mflo	$5
	#nop
	subu	$3,$9,$10
	subu	$2,$4,$12
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L691
	subu	$2,$11,$4
	.set	macro
	.set	reorder

	lh	$8,56($16)
	#nop
	subu	$3,$8,$6
	mult	$3,$2
	lh	$7,60($16)
	mflo	$5
	#nop
	subu	$3,$9,$6
	subu	$2,$7,$4
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$5,$3
	bgtz	$2,$L691
	lh	$4,80($16)
	lh	$5,84($16)
	subu	$3,$10,$4
	subu	$2,$11,$5
	mult	$3,$2
	mflo	$6
	#nop
	subu	$3,$9,$4
	subu	$2,$12,$5
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$6,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L691
	subu	$3,$4,$8
	.set	macro
	.set	reorder

	subu	$2,$11,$7
	mult	$3,$2
	mflo	$4
	#nop
	subu	$3,$9,$8
	subu	$2,$5,$7
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	subu	$2,$4,$3
	bgtz	$2,$L691
	.set	noreorder
	.set	nomacro
	jal	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L716
$L691:
	lb	$2,116($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L717
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L693
	lh	$3,16($sp)
	lh	$2,80($16)
	#nop
	subu	$8,$3,$2
	bgtz	$8,$L694
	subu	$8,$2,$3
$L694:
	lh	$2,72($16)
	#nop
	subu	$7,$3,$2
	bgtz	$7,$L695
	subu	$7,$2,$3
$L695:
	lh	$2,64($16)
	#nop
	subu	$6,$3,$2
	bgtz	$6,$L696
	subu	$6,$2,$3
$L696:
	lh	$2,56($16)
	#nop
	subu	$5,$3,$2
	bgtz	$5,$L697
	subu	$5,$2,$3
$L697:
	lh	$4,20($sp)
	lh	$2,60($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L698
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L730
	addu	$5,$5,$3
	.set	macro
	.set	reorder

$L698:
	addu	$5,$5,$2
	lh	$4,20($sp)
$L730:
	lh	$2,68($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L700
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L724
	addu	$2,$6,$3
	.set	macro
	.set	reorder

$L700:
	addu	$2,$6,$2
$L724:
	addu	$5,$5,$2
	lh	$4,20($sp)
	lh	$2,76($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L702
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L725
	addu	$2,$7,$3
	.set	macro
	.set	reorder

$L702:
	addu	$2,$7,$2
$L725:
	addu	$5,$5,$2
	lh	$4,20($sp)
	lh	$2,84($16)
	#nop
	subu	$3,$4,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L704
	subu	$2,$2,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L726
	addu	$2,$8,$3
	.set	macro
	.set	reorder

$L704:
	addu	$2,$8,$2
$L726:
	addu	$2,$5,$2
	move	$3,$2
	subu	$2,$3,$17
	slt	$2,$2,41
	beq	$2,$0,$L689
	move	$17,$3
$L693:
	lbu	$2,116($16)
	move	$4,$16
	addu	$2,$2,-1
	sb	$2,116($16)
$L723:
	jal	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	lb	$2,116($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L690
	move	$4,$16
	.set	macro
	.set	reorder

$L689:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L728
	lui	$2,%hi(sliceOffs.254) # high
	.set	macro
	.set	reorder

	lb	$23,90($16)
$L728:
	addiu	$2,$2,%lo(sliceOffs.254) # low
	sll	$3,$19,2
	addu	$3,$3,$2
	lh	$4,0($16)
	lw	$2,0($3)
	lw	$5,gNumSlices
	addu	$4,$4,$2
	slt	$2,$4,$5
	bne	$2,$0,$L709
	subu	$4,$4,$5
$L709:
	bgez	$4,$L710
	addu	$4,$4,$5
$L710:
	sh	$4,0($16)
	lw	$2,0($3)
	addu	$19,$19,1
	.set	noreorder
	.set	nomacro
	j	$L661
	addu	$22,$22,$2
	.set	macro
	.set	reorder

$L662:
	lh	$3,0($16)
	lw	$4,gNumSlices
	subu	$3,$3,$22
	slt	$2,$3,$4
	bne	$2,$0,$L711
	subu	$3,$3,$4
$L711:
	bgez	$3,$L712
	addu	$3,$3,$4
$L712:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSimSlice__FP12BWorldSm_Pos
	sh	$3,0($16)
	.set	macro
	.set	reorder

	move	$2,$0
	sb	$23,90($16)
	sw	$0,120($16)
	sb	$0,91($16)
$L713:
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

	.end	RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	FindClosestQuad__FP8coorddefP12BWorldSm_Pos
FindClosestQuad__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	lh	$20,0($16)
	lb	$21,116($16)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	move	$18,$4
	.set	macro
	.set	reorder

	move	$4,$18
	lh	$17,0($16)
	.set	noreorder
	.set	nomacro
	jal	RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L744
	move	$4,$0
	.set	macro
	.set	reorder

	lb	$2,90($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L734
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorld_SetSimSlice__FP12BWorldSm_Pos
	sh	$17,0($16)
	.set	macro
	.set	reorder

	lb	$3,90($16)
	li	$2,1			# 0x00000001
	beq	$3,$2,$L735
	lw	$2,128($16)
	#nop
	lbu	$2,1($2)
	.set	noreorder
	.set	nomacro
	j	$L736
	addu	$2,$2,-1
	.set	macro
	.set	reorder

$L735:
	move	$2,$0
$L736:
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	BworldSm_UpdateSimQuad__FP12BWorldSm_Pos
	sb	$2,116($16)
	.set	macro
	.set	reorder

	move	$4,$16
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	SetStrip__FP12BWorldSm_Pos
	sb	$2,119($16)
	.set	macro
	.set	reorder

	lbu	$2,117($16)
	move	$4,$16
	sll	$5,$2,1
	addu	$5,$5,$2
	lw	$2,Chunk_chunkCenters
	sll	$5,$5,2
	.set	noreorder
	.set	nomacro
	jal	GetStmQuadPts__FP12BWorldSm_PosP8coorddef
	addu	$5,$2,$5
	.set	macro
	.set	reorder

$L734:
	lui	$3,%hi(corrPt.257) # high
	addiu	$9,$3,%lo(corrPt.257)
	lw	$6,0($18)
	lw	$7,4($18)
	lw	$8,8($18)
	sw	$6,0($9)
	sw	$7,4($9)
	sw	$8,8($9)
	lw	$2,120($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	move	$17,$0
	.set	macro
	.set	reorder

	move	$19,$3
	addiu	$18,$19,%lo(corrPt.257) # low
$L741:
	slt	$2,$17,10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L733
	move	$4,$18
	.set	macro
	.set	reorder

	lh	$2,0($16)
	lw	$5,BWorldSm_slices
	lw	$3,%lo(corrPt.257)($19)
	sll	$2,$2,5
	addu	$2,$2,$5
	lw	$2,0($2)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,5
	addu	$3,$3,$2
	sw	$3,%lo(corrPt.257)($19)
	lh	$2,0($16)
	lw	$3,8($18)
	sll	$2,$2,5
	addu	$2,$2,$5
	lw	$2,8($2)
	move	$5,$16
	subu	$2,$2,$3
	sra	$2,$2,5
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos
	sw	$3,8($18)
	.set	macro
	.set	reorder

	lw	$2,120($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L733:
	move	$4,$0
$L744:
	lh	$2,0($16)
	lb	$3,116($16)
	xor	$2,$20,$2
	sltu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	bne	$21,$3,$L743
	sb	$2,88($16)
	.set	macro
	.set	reorder

	beq	$2,$0,$L742
$L743:
	li	$4,1			# 0x00000001
$L742:
	lb	$2,88($16)
	sb	$4,89($16)
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

	.end	FindClosestQuad__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	li	$2,3			# 0x00000003
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L746
	sb	$2,91($17)
	.set	macro
	.set	reorder

	lw	$3,120($17)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L747
	sb	$2,118($17)
	.set	macro
	.set	reorder

	move	$19,$0
	lw	$3,20($17)
	lw	$4,32($17)
	lw	$2,8($18)
	lw	$5,40($17)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$6,0($18)
	lw	$4,32($17)
	lw	$3,28($17)
	lw	$5,40($17)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	bgtz	$16,$L748
	lw	$3,8($17)
	lw	$4,20($17)
	lw	$2,8($18)
	lw	$5,28($17)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$6,0($18)
	lw	$4,20($17)
	lw	$3,16($17)
	lw	$5,28($17)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	bgtz	$16,$L748
	lw	$3,32($17)
	lw	$4,44($17)
	lw	$2,8($18)
	lw	$5,52($17)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$6,0($18)
	lw	$4,44($17)
	lw	$3,40($17)
	lw	$5,52($17)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	bgtz	$16,$L748
	lw	$3,44($17)
	lw	$4,8($17)
	lw	$2,8($18)
	lw	$5,16($17)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$6,0($18)
	lw	$4,8($17)
	lw	$3,52($17)
	lw	$5,16($17)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	slt	$19,$16,1
$L748:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L747
	move	$2,$0
	.set	macro
	.set	reorder

	sb	$0,89($17)
	.set	noreorder
	.set	nomacro
	j	$L752
	sb	$0,88($17)
	.set	macro
	.set	reorder

$L747:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	FindClosestQuad__FP8coorddefP12BWorldSm_Pos
	move	$5,$17
	.set	macro
	.set	reorder

	j	$L752
$L746:
	move	$4,$18
	move	$5,$17
	li	$2,1			# 0x00000001
	sb	$2,118($5)
	sb	$2,119($5)
	li	$2,-1			# 0xffffffff
	sw	$0,128($5)
	sw	$0,120($5)
	sb	$2,116($5)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	sb	$0,91($5)
	.set	macro
	.set	reorder

$L752:
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

	.end	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	.text
	.ent	BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi
BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	li	$6,1			# 0x00000001
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

	.end	BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi
	.text
	.ent	PointDirection__FP8coorddefN20
PointDirection__FP8coorddefN20:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,28($sp)
	lw	$3,0($18)
	lw	$4,0($16)
	lw	$2,8($17)
	lw	$5,8($16)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$4,0($16)
	lw	$5,8($16)
	move	$16,$2
	lw	$6,0($17)
	lw	$3,8($18)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$2,$16,$2
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

	.end	PointDirection__FP8coorddefN20
	.text
	.ent	BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	move	$21,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$23,44($sp)
	move	$23,$6
	sw	$fp,48($sp)
	move	$fp,$7
	sw	$18,24($sp)
	addu	$18,$19,8
	sw	$22,40($sp)
	addu	$22,$19,32
	move	$4,$22
	sw	$16,16($sp)
	addu	$16,$19,44
	move	$5,$16
	move	$6,$21
	sw	$31,52($sp)
	sw	$20,32($sp)
	.set	noreorder
	.set	nomacro
	jal	PointDirection__FP8coorddefN20
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$20,-131072			# 0xfffe0000
	ori	$20,$20,0x8000
	slt	$2,$2,$20
	xori	$17,$2,0x0001
	move	$4,$16
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	PointDirection__FP8coorddefN20
	move	$6,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L759
	move	$4,$18
	.set	macro
	.set	reorder

	ori	$17,$17,0x0008
$L759:
	addu	$16,$19,20
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	PointDirection__FP8coorddefN20
	move	$6,$21
	.set	macro
	.set	reorder

	slt	$2,$2,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
	move	$4,$16
	.set	macro
	.set	reorder

	ori	$17,$17,0x0002
$L760:
	move	$5,$22
	.set	noreorder
	.set	nomacro
	jal	PointDirection__FP8coorddefN20
	move	$6,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L761
	addu	$18,$23,8
	.set	macro
	.set	reorder

	ori	$17,$17,0x0004
$L761:
	lw	$3,4($18)
	lw	$4,16($18)
	move	$2,$17
	addu	$3,$3,$4
	lw	$4,28($18)
	lw	$5,40($18)
	addu	$3,$3,$4
	addu	$3,$3,$5
	lw	$4,4($21)
	sra	$3,$3,2
	subu	$3,$3,$4
	sw	$3,0($fp)
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

	.end	BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi
	.text
	.ent	BWorldSm_QuadLight__FP12BWorldSm_Pos
BWorldSm_QuadLight__FP12BWorldSm_Pos:
	.frame	$sp,40,$31		# vars= 40, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lb	$3,119($4)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L763
	subu	$sp,$sp,40
	.set	macro
	.set	reorder

	li	$2,8323072			# 0x007f0000
	.set	noreorder
	.set	nomacro
	j	$L766
	ori	$2,$2,0x7f7f
	.set	macro
	.set	reorder

$L763:
	lw	$2,124($4)
	lh	$6,2($4)
	lbu	$4,117($4)
	lbu	$3,0($2)
	lbu	$5,1($2)
	sll	$2,$4,3
	subu	$2,$2,$4
	sll	$2,$2,4
	lw	$4,Track_chunkList
	addu	$3,$3,$6
	addu	$2,$2,$4
	addu	$5,$5,$6
	sll	$3,$3,3
	sll	$5,$5,3
	lw	$2,108($2)
	lw	$6,Chunk_lightTable
	addu	$2,$2,4
	addu	$3,$3,$2
	addu	$5,$5,$2
	lh	$4,14($3)
	lhu	$2,6($3)
	lhu	$3,6($5)
	lhu	$5,14($5)
	sll	$4,$4,2
	addu	$4,$4,$6
	sll	$2,$2,16
	sra	$2,$2,14
	sll	$3,$3,16
	lwl	$7,3($4)
	lwr	$7,0($4)
	swl	$7,11($sp)
	swr	$7,8($sp)
	lw	$4,Chunk_lightTable
	sra	$3,$3,14
	addu	$2,$2,$4
	lwl	$7,3($2)
	lwr	$7,0($2)
	swl	$7,19($sp)
	swr	$7,16($sp)
	lw	$2,Chunk_lightTable
	sll	$5,$5,16
	addu	$3,$3,$2
	lw	$2,Chunk_lightTable
	sra	$5,$5,14
	lwl	$7,3($3)
	lwr	$7,0($3)
	swl	$7,27($sp)
	swr	$7,24($sp)
	addu	$5,$5,$2
	lwl	$7,3($5)
	lwr	$7,0($5)
	swl	$7,35($sp)
	swr	$7,32($sp)
	lbu	$2,8($sp)
	lbu	$3,16($sp)
	#nop
	addu	$2,$2,$3
	lbu	$3,24($sp)
	lbu	$4,32($sp)
	addu	$2,$2,$3
	addu	$2,$2,$4
	lbu	$3,9($sp)
	lbu	$4,17($sp)
	sra	$2,$2,2
	sb	$2,0($sp)
	lbu	$2,25($sp)
	addu	$3,$3,$4
	addu	$3,$3,$2
	lbu	$4,33($sp)
	lbu	$2,10($sp)
	addu	$3,$3,$4
	lbu	$4,18($sp)
	sra	$3,$3,2
	sb	$3,1($sp)
	lbu	$3,26($sp)
	addu	$2,$2,$4
	lbu	$4,34($sp)
	addu	$2,$2,$3
	addu	$2,$2,$4
	sra	$2,$2,2
	sb	$2,2($sp)
	lw	$2,0($sp)
$L766:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	BWorldSm_QuadLight__FP12BWorldSm_Pos
	.text
	.ent	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($4)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$2,$3
	lbu	$2,21($2)
	#nop
	andi	$2,$2,0x0044
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,120($4)
	#nop
	beq	$4,$0,$L769
	lbu	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$L770
	andi	$2,$2,0x000f
	.set	macro
	.set	reorder

$L769:
	li	$2,14			# 0x0000000e
$L770:
	xori	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L772:
	j	$31
	.end	BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
	.text
	.ent	NormalCache_AddEntry__FP12BWorldSm_Pos
NormalCache_AddEntry__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	li	$6,-1			# 0xffffffff
	move	$7,$6
	lui	$2,%hi(BWSM_NormalCache) # high
	addiu	$3,$2,%lo(BWSM_NormalCache) # low
	lw	$2,BWSM_NormalCacheSysTime
	move	$5,$0
	addu	$2,$2,1
	sw	$2,BWSM_NormalCacheSysTime
$L774:
	lw	$4,28($3)
	#nop
	sltu	$2,$4,$6
	beq	$2,$0,$L777
	move	$7,$5
	move	$6,$4
$L777:
	addu	$5,$5,1
	slt	$2,$5,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L774
	addu	$3,$3,32
	.set	macro
	.set	reorder

	lui	$2,%hi(BWSM_NormalCache) # high
	addiu	$2,$2,%lo(BWSM_NormalCache) # low
	sll	$3,$7,5
	lw	$4,BWSM_NormalCacheSysTime
	addu	$3,$3,$2
	sw	$4,28($3)
	lw	$9,104($8)
	lw	$10,108($8)
	lw	$11,112($8)
	sw	$9,16($3)
	sw	$10,20($3)
	sw	$11,24($3)
	lw	$9,92($8)
	lw	$10,96($8)
	lw	$11,100($8)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	lhu	$2,0($8)
	#nop
	sh	$2,0($3)
	lbu	$2,116($8)
	#nop
	sb	$2,3($3)
	lbu	$2,91($8)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,2($3)
	.set	macro
	.set	reorder

	.end	NormalCache_AddEntry__FP12BWorldSm_Pos
	.text
	.ent	NormalCache_FindEntry__FP12BWorldSm_Pos
NormalCache_FindEntry__FP12BWorldSm_Pos:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(BWSM_NormalCache) # high
	addiu	$6,$2,%lo(BWSM_NormalCache) # low
	move	$7,$0
	addu	$5,$6,2
	lw	$2,BWSM_NormalCacheSysTime
	lh	$9,0($4)
	addu	$2,$2,1
	sw	$2,BWSM_NormalCacheSysTime
	lb	$8,116($4)
$L782:
	lh	$2,0($6)
	#nop
	bne	$2,$9,$L783
	lb	$2,1($5)
	#nop
	bne	$2,$8,$L783
	lbu	$3,0($5)
	lb	$2,91($4)
	#nop
	beq	$3,$2,$L788
$L783:
	addu	$5,$5,32
	addu	$7,$7,1
	slt	$2,$7,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L782
	addu	$6,$6,32
	.set	macro
	.set	reorder

$L781:
	slt	$2,$7,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L785
	move	$2,$0
	.set	macro
	.set	reorder

	j	$31
$L788:
	lw	$2,BWSM_NormalCacheSysTime
	.set	noreorder
	.set	nomacro
	j	$L781
	sw	$2,28($6)
	.set	macro
	.set	reorder

$L785:
	lw	$10,4($6)
	lw	$11,8($6)
	lw	$12,12($6)
	sw	$10,92($4)
	sw	$11,96($4)
	sw	$12,100($4)
	lw	$10,16($6)
	lw	$11,20($6)
	lw	$12,24($6)
	sw	$10,104($4)
	sw	$11,108($4)
	sw	$12,112($4)
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.end	NormalCache_FindEntry__FP12BWorldSm_Pos
	.text
	.ent	NormalCache_Init__Fv
NormalCache_Init__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,BWSM_NormalCacheSysTime
	move	$4,$0
	li	$5,-1			# 0xffffffff
	lui	$2,%hi(BWSM_NormalCache) # high
	addiu	$3,$2,%lo(BWSM_NormalCache) # low
$L790:
	sh	$5,0($3)
	sb	$5,3($3)
	sb	$0,2($3)
	sw	$0,28($3)
	addu	$4,$4,1
	slt	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L790
	addu	$3,$3,32
	.set	macro
	.set	reorder

	j	$31
	.end	NormalCache_Init__Fv
	.text
	.ent	Check_Rot__FP12BWorldSm_Pos
Check_Rot__FP12BWorldSm_Pos:
	.frame	$sp,64,$31		# vars= 32, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,48($sp)
	move	$16,$4
	sw	$31,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	lh	$3,4($16)
	lb	$2,91($16)
	#nop
	beq	$3,$2,$L795
	jal	NormalCache_FindEntry__FP12BWorldSm_Pos
	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lb	$3,91($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L797
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,32($16)
	lw	$2,44($16)
	#nop
	subu	$4,$3,$2
	sw	$4,32($sp)
	lw	$3,20($16)
	lw	$2,8($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L798
	addu	$2,$2,7
$L798:
	sra	$2,$2,3
	addu	$2,$4,$2
	sw	$2,32($sp)
	lw	$3,36($16)
	lw	$2,48($16)
	#nop
	subu	$4,$3,$2
	sw	$4,36($sp)
	lw	$3,24($16)
	lw	$2,12($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L799
	addu	$2,$2,7
$L799:
	sra	$2,$2,3
	addu	$2,$4,$2
	sw	$2,36($sp)
	lw	$3,40($16)
	lw	$2,52($16)
	#nop
	subu	$4,$3,$2
	sw	$4,40($sp)
	lw	$3,28($16)
	lw	$2,16($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L800
	addu	$2,$2,7
$L800:
	sra	$2,$2,3
	addu	$2,$4,$2
	sw	$2,40($sp)
	lw	$3,8($16)
	lw	$2,44($16)
	#nop
	subu	$4,$3,$2
	sw	$4,16($sp)
	lw	$3,20($16)
	lw	$2,32($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L801
	addu	$2,$2,7
$L801:
	sra	$2,$2,3
	addu	$2,$4,$2
	sw	$2,16($sp)
	lw	$3,12($16)
	lw	$2,48($16)
	#nop
	subu	$4,$3,$2
	sw	$4,20($sp)
	lw	$3,24($16)
	lw	$2,36($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L802
	addu	$2,$2,7
$L802:
	sra	$2,$2,3
	addu	$2,$4,$2
	sw	$2,20($sp)
	lw	$3,16($16)
	lw	$2,52($16)
	#nop
	subu	$4,$3,$2
	sw	$4,24($sp)
	lw	$3,28($16)
	lw	$2,40($16)
	#nop
	subu	$2,$3,$2
	bgez	$2,$L803
	addu	$2,$2,7
$L803:
	sra	$2,$2,3
	.set	noreorder
	.set	nomacro
	j	$L808
	addu	$2,$4,$2
	.set	macro
	.set	reorder

$L797:
	bne	$3,$2,$L805
	lw	$2,20($16)
	lw	$3,8($16)
	#nop
	subu	$2,$2,$3
	sw	$2,32($sp)
	lw	$2,24($16)
	lw	$3,12($16)
	#nop
	subu	$2,$2,$3
	sw	$2,36($sp)
	lw	$2,28($16)
	lw	$3,16($16)
	#nop
	subu	$2,$2,$3
	sw	$2,40($sp)
	lw	$2,20($16)
	lw	$3,32($16)
	#nop
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,24($16)
	lw	$3,36($16)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,28($16)
	lw	$3,40($16)
	.set	noreorder
	.set	nomacro
	j	$L808
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L805:
	lw	$2,32($16)
	lw	$3,44($16)
	#nop
	subu	$2,$2,$3
	sw	$2,32($sp)
	lw	$2,36($16)
	lw	$3,48($16)
	#nop
	subu	$2,$2,$3
	sw	$2,36($sp)
	lw	$2,40($16)
	lw	$3,52($16)
	#nop
	subu	$2,$2,$3
	sw	$2,40($sp)
	lw	$2,8($16)
	lw	$3,44($16)
	#nop
	subu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,12($16)
	lw	$3,48($16)
	#nop
	subu	$2,$2,$3
	sw	$2,20($sp)
	lw	$2,16($16)
	lw	$3,52($16)
	#nop
	subu	$2,$2,$3
$L808:
	sw	$2,24($sp)
	addu	$4,$sp,32
	addu	$18,$16,104
	addu	$17,$16,92
	addu	$5,$sp,16
	lw	$7,32($sp)
	lw	$8,36($sp)
	lw	$9,40($sp)
	sw	$7,104($16)
	sw	$8,108($16)
	sw	$9,112($16)
	.set	noreorder
	.set	nomacro
	jal	crossproduct
	move	$6,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$3,4($17)
	li	$2,65535			# 0x0000ffff
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L807
	li	$2,65529			# 0x0000fff9
	.set	macro
	.set	reorder

	sw	$2,4($17)
$L807:
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	NormalCache_AddEntry__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

$L795:
	lbu	$2,91($16)
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sh	$2,4($16)
	lw	$31,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	Check_Rot__FP12BWorldSm_Pos
	.text
	.ent	BWorldSm_UNormal__FP12BWorldSm_Pos
BWorldSm_UNormal__FP12BWorldSm_Pos:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Check_Rot__FP12BWorldSm_Pos
	move	$16,$4
	.set	macro
	.set	reorder

	addu	$2,$16,92
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorldSm_UNormal__FP12BWorldSm_Pos
	.text
	.ent	BWorldSm_UForward__FP12BWorldSm_Pos
BWorldSm_UForward__FP12BWorldSm_Pos:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Check_Rot__FP12BWorldSm_Pos
	move	$16,$4
	.set	macro
	.set	reorder

	addu	$2,$16,104
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	BWorldSm_UForward__FP12BWorldSm_Pos
	.text
	.ent	BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	lw	$3,120($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L813
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$3,32($17)
	lw	$4,8($17)
	lw	$2,8($16)
	lw	$5,16($17)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$6,0($16)
	move	$16,$2
	lw	$4,8($17)
	lw	$3,40($17)
	lw	$5,16($17)
	subu	$4,$6,$4
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	blez	$16,$L814
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L814:
	sb	$2,91($17)
$L813:
	move	$2,$18
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

	.end	BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi
