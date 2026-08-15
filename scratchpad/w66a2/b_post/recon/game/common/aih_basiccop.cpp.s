	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aih_basiccop.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	__15AIHigh_BasicCopP8Car_tObji
	.align	2
	.globl	CheckSpikeBelt__15AIHigh_BasicCop
	.align	2
	.globl	ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
	.align	2
	.globl	Blockade_AddRoadFlare__FP8coorddef
	.align	2
	.globl	Blockade_AddObject__FiP8coorddefi
	.align	2
	.globl	PlacePointOnRoad__FiP8coorddef
	.align	2
	.globl	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	.align	2
	.globl	HandleBlockadeSpeech__15AIHigh_BasicCop
	.align	2
	.globl	___15AIHigh_BasicCop

	.extern	Cars_topSpeedCap, 88
	.extern	BWorldSm_slices, 4
	.extern	Cars_gHumanRaceCarList, 36
	.extern	Object_customSFXInst, 4
	.extern	randSeed, 4
	.extern	fastRandom, 4
	.extern	randtemp, 4
	.extern	AI_elapsedTime, 4
	.extern	Object_customSliceNum, 4
	.extern	AICop_gRoadBlockState, 4
	.extern	AICop_spikeBelt, 20

	.text
	.text
	.ent	__15AIHigh_BasicCopP8Car_tObji
__15AIHigh_BasicCopP8Car_tObji:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__11AIHigh_BaseP8Car_tObj
	move	$17,$6
	.set	macro
	.set	reorder

	lui	$2,%hi(AIHigh_BasicCop_vtable) # high
	addiu	$2,$2,%lo(AIHigh_BasicCop_vtable) # low
	sw	$2,20($18)
	sw	$17,28($18)
	lw	$2,608($16)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L603
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L604
	sw	$2,24($18)
	.set	macro
	.set	reorder

$L603:
	sw	$0,24($18)
$L604:
	move	$2,$18
	li	$3,-1			# 0xffffffff
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$3,48($2)
	sh	$0,80($2)
	sw	$0,84($2)
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

	.end	__15AIHigh_BasicCopP8Car_tObji
	.text
	.ent	CheckSpikeBelt__15AIHigh_BasicCop
CheckSpikeBelt__15AIHigh_BasicCop:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	lui	$17,%hi(AICop_spikeBelt) # high
	lw	$2,%lo(AICop_spikeBelt)($17)
	move	$3,$0
	sw	$16,16($sp)
	addiu	$16,$17,%lo(AICop_spikeBelt) # low
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(D_8011E0B0) # high
	lw	$2,%lo(D_8011E0B0)($2)
	lw	$3,16($16)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,320
	sltu	$3,$2,1
$L607:
	beq	$3,$0,$L608
	lw	$4,4($16)
	jal	AILife_IsSliceInAnyVisibleArea__Fi
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L609
	lui	$2,%hi(D_8011E0B0) # high
	.set	macro
	.set	reorder

	jal	BWorld_InitSpikeBelt__Fv
	.set	noreorder
	.set	nomacro
	j	$L608
	sw	$0,%lo(AICop_spikeBelt)($17)
	.set	macro
	.set	reorder

$L609:
	lw	$2,%lo(D_8011E0B0)($2)
	#nop
	sw	$2,16($16)
$L608:
	lw	$3,AICop_gRoadBlockState
	li	$2,2			# 0x00000002
	bne	$3,$2,$L606
	lw	$4,Object_customSliceNum
	jal	AILife_IsSliceInAnyVisibleArea__Fi
	bne	$2,$0,$L606
	jal	Object_ClearCustomObjects__Fv
	sw	$0,AICop_gRoadBlockState
$L606:
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

	.end	CheckSpikeBelt__15AIHigh_BasicCop
	.text
	.ent	ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$6
	.set	noreorder
	.set	nomacro
	bgez	$5,$L613
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	addu	$5,$5,31
$L613:
	lw	$2,AI_elapsedTime
	sra	$3,$5,5
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$4,$2,3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L614
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$4,$4,$2
$L614:
	lw	$3,fastRandom
	lw	$2,randSeed
	#nop
	mult	$3,$2
	sra	$4,$4,16
	mflo	$3
	#nop
	#nop
	andi	$2,$3,0xffff
	sw	$3,randtemp
	srl	$3,$3,8
	andi	$3,$3,0xffff
	sw	$2,fastRandom
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	srl	$2,$2,16
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,0($17)
	lw	$3,1396($16)
	lw	$2,1396($4)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	bgez	$2,1f
	move	$5,$2
	subu	$5,$0,$5
1:
	.set	reorder
	lw	$2,308($16)
	li	$3,65536			# 0x00010000
	addu	$2,$2,$3
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$2,196608			# 0x00030000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AIWorld_SplineDistance__FP8Car_tObjT0
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$3,0($17)
	#nop
	lw	$3,1364($3)
	#nop
	mult	$2,$3
	lw	$2,316($16)
	li	$3,131072			# 0x00020000
	sll	$2,$2,1
	addu	$2,$2,$3
	mflo	$4
	#nop
	#nop
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$3,720896			# 0x000b0000
	.set	macro
	.set	reorder

	ori	$3,$3,0xffff
	slt	$3,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L618
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L615:
	move	$2,$0
$L618:
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

	.end	ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj
	.text
	.ent	Blockade_AddRoadFlare__FP8coorddef
Blockade_AddRoadFlare__FP8coorddef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,Object_customSFXInst
	lw	$5,0($4)
	lw	$3,0($6)
	addu	$2,$6,4
	sll	$3,$3,4
	addu	$2,$2,$3
	sw	$5,0($2)
	lw	$3,4($4)
	#nop
	sw	$3,4($2)
	lw	$4,8($4)
	li	$3,22			# 0x00000016
	sh	$3,12($2)
	sh	$0,14($2)
	sw	$4,8($2)
	lw	$2,0($6)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder

	.end	Blockade_AddRoadFlare__FP8coorddef
	.text
	.ent	Blockade_AddObject__FiP8coorddefi
Blockade_AddObject__FiP8coorddefi:
	.frame	$sp,272,$31		# vars= 232, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,272
	sw	$16,248($sp)
	move	$16,$4
	sw	$18,256($sp)
	move	$18,$5
	sw	$17,252($sp)
	move	$17,$6
	move	$4,$17
	li	$2,1			# 0x00000001
	sw	$31,264($sp)
	sw	$19,260($sp)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Object_GetObjDefID__Fi
	sw	$2,84($sp)
	.set	macro
	.set	reorder

	li	$3,131072			# 0x00020000
	ori	$3,$3,0x3916
	move	$4,$16
	addu	$16,$sp,112
	move	$5,$16
	sw	$2,92($sp)
	sw	$3,96($sp)
	lw	$7,0($18)
	lw	$8,4($18)
	lw	$9,8($18)
	sw	$7,32($sp)
	sw	$8,36($sp)
	sw	$9,40($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	sw	$17,88($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UNormal__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,60($sp)
	sw	$8,64($sp)
	sw	$9,68($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UForward__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$18,$sp,60
	addu	$17,$sp,72
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,72($sp)
	sw	$8,76($sp)
	sw	$9,80($sp)
	lw	$4,4($18)
	lw	$5,8($17)
	jal	fixedmult
	lw	$4,8($18)
	lw	$5,4($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,48($sp)
	lw	$4,8($18)
	lw	$5,72($sp)
	jal	fixedmult
	lw	$4,60($sp)
	lw	$5,8($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$19,$sp,48
	subu	$16,$16,$2
	sw	$16,4($19)
	lw	$4,60($sp)
	lw	$5,4($17)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,72($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$4
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	transpose
	sw	$16,8($4)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Object_AddCustomObject__FP9SceneElemi
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$31,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,272
	.set	macro
	.set	reorder

	.end	Blockade_AddObject__FiP8coorddefi
	.text
	.ent	PlacePointOnRoad__FiP8coorddef
PlacePointOnRoad__FiP8coorddef:
	.frame	$sp,208,$31		# vars= 168, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$19,196($sp)
	move	$19,$5
	lui	$2,%hi(Cars_gHumanRaceCarList) # high
	lw	$2,%lo(Cars_gHumanRaceCarList)($2)
	addu	$6,$sp,32
	sw	$31,200($sp)
	sw	$18,192($sp)
	sw	$17,188($sp)
	sw	$16,184($sp)
	lw	$7,0($19)
	lw	$8,4($19)
	lw	$9,8($19)
	sw	$7,168($sp)
	sw	$8,172($sp)
	sw	$9,176($sp)
	addu	$5,$2,8
	addu	$2,$2,136
$L622:
	lw	$7,0($5)
	lw	$8,4($5)
	lw	$9,8($5)
	lw	$10,12($5)
	sw	$7,0($6)
	sw	$8,4($6)
	sw	$9,8($6)
	sw	$10,12($6)
	addu	$5,$5,16
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L622
	addu	$6,$6,16
	.set	macro
	.set	reorder

	lw	$2,BWorldSm_slices
	sll	$3,$4,5
	lw	$7,0($5)
	sw	$7,0($6)
	sh	$4,32($sp)
	addu	$2,$3,$2
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,16($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	lw	$2,BWorldSm_slices
	lw	$5,168($sp)
	addu	$3,$3,$2
	lb	$4,18($3)
	lb	$18,20($3)
	lb	$16,15($3)
	lb	$17,17($3)
	sll	$4,$4,9
	sll	$18,$18,9
	sll	$16,$16,9
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$17,$17,9
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$5,176($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	addu	$3,$3,$16
	addu	$3,$3,$2
	sw	$3,0($19)
	lw	$2,20($sp)
	#nop
	sw	$2,4($19)
	lw	$5,168($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$17
	lw	$5,176($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$16,$sp,32
	move	$5,$16
	lw	$3,24($sp)
	li	$6,1			# 0x00000001
	addu	$3,$3,$17
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	sw	$3,8($19)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	BWorldSm_UNormal__FP12BWorldSm_Pos
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$3,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L623
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L624
	addu	$5,$sp,40
	.set	macro
	.set	reorder

$L623:
	lh	$2,32($sp)
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$5,$3,$2
$L624:
	.set	noreorder
	.set	nomacro
	jal	GetPlaneY__FPC8coorddefN20
	move	$6,$19
	.set	macro
	.set	reorder

	sw	$2,4($19)
	lw	$31,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	PlacePointOnRoad__FiP8coorddef
	.text
	.ent	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t:
	.frame	$sp,64,$31		# vars= 16, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,48($sp)
	move	$20,$5
	sw	$31,56($sp)
	sw	$21,52($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$2,8($20)
	#nop
	beq	$2,$0,$L625
	jal	Object_ClearCustomObjects__Fv
	lw	$3,8($20)
	lw	$19,20($20)
	andi	$2,$3,0x0001
	sw	$19,Object_customSliceNum
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	move	$16,$0
	.set	macro
	.set	reorder

	li	$17,-1048576			# 0xfff00000
	sll	$2,$16,17
$L653:
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,24($20)
	#nop
	mult	$2,$17
	move	$4,$19
	addu	$5,$sp,16
	addu	$16,$16,1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$7,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Blockade_AddRoadFlare__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$2,262144			# 0x00040000
	addu	$17,$17,$2
	slt	$2,$16,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	sll	$2,$16,17
	.set	macro
	.set	reorder

	li	$18,1			# 0x00000001
	li	$17,-786432			# 0xfff40000
	li	$16,-131072			# 0xfffe0000
	sw	$16,16($sp)
$L654:
	sw	$0,20($sp)
	lw	$2,24($20)
	#nop
	mult	$2,$17
	move	$4,$19
	addu	$5,$sp,16
	addu	$18,$18,1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$7,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Blockade_AddRoadFlare__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$2,262144			# 0x00040000
	addu	$17,$17,$2
	li	$2,-131072			# 0xfffe0000
	addu	$16,$16,$2
	slt	$2,$18,5
	beq	$2,$0,$L638
	.set	noreorder
	.set	nomacro
	j	$L654
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L627:
	andi	$2,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	li	$16,-393216			# 0xfffa0000
	.set	macro
	.set	reorder

	move	$18,$0
	li	$17,-1572864			# 0xffe80000
$L643:
	sw	$16,16($sp)
	sw	$0,20($sp)
	lw	$2,24($20)
	#nop
	mult	$2,$17
	move	$4,$19
	addu	$5,$sp,16
	addu	$18,$18,1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$7,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Blockade_AddRoadFlare__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$2,262144			# 0x00040000
	addu	$17,$17,$2
	li	$2,131072			# 0x00020000
	addu	$16,$16,$2
	slt	$2,$18,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	li	$21,3			# 0x00000003
	.set	macro
	.set	reorder

	move	$16,$0
	li	$18,-1572864			# 0xffe80000
	li	$17,393216			# 0x00060000
$L648:
	.set	noreorder
	.set	nomacro
	beq	$16,$21,$L647
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	sw	$17,16($sp)
	sw	$0,20($sp)
	lw	$2,24($20)
	#nop
	mult	$2,$18
	move	$4,$19
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$7,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Blockade_AddRoadFlare__FP8coorddef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L647:
	li	$2,262144			# 0x00040000
	addu	$18,$18,$2
	li	$2,-131072			# 0xfffe0000
	addu	$17,$17,$2
	addu	$16,$16,1
	slt	$2,$16,7
	bne	$2,$0,$L648
$L638:
	lw	$2,8($20)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L651
	.set	noreorder
	.set	nomacro
	jal	Object_FindDefWithThisID__Fi
	li	$4,3			# 0x00000003
	.set	macro
	.set	reorder

	move	$16,$2
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L651
	li	$2,-196608			# 0xfffd0000
	.set	macro
	.set	reorder

	ori	$2,$2,0x8000
	move	$4,$19
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,24($20)
	addu	$5,$sp,16
	sll	$2,$2,18
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Blockade_AddObject__FiP8coorddefi
	move	$6,$16
	.set	macro
	.set	reorder

	li	$2,131072			# 0x00020000
	ori	$2,$2,0x8000
	move	$4,$19
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$2,24($20)
	addu	$5,$sp,16
	sll	$2,$2,18
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	PlacePointOnRoad__FiP8coorddef
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Blockade_AddObject__FiP8coorddefi
	move	$6,$16
	.set	macro
	.set	reorder

$L651:
	sw	$0,8($20)
$L625:
	lw	$31,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
	.text
	.ent	HandleBlockadeSpeech__15AIHigh_BasicCop
HandleBlockadeSpeech__15AIHigh_BasicCop:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lh	$2,80($16)
	lhu	$6,80($16)
	beq	$2,$0,$L655
	lw	$2,36($16)
	#nop
	lw	$4,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L667
	move	$7,$4
	.set	macro
	.set	reorder

	lw	$2,856($4)
	lw	$3,52($16)
	lw	$4,628($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L660
	subu	$5,$2,$3
	.set	macro
	.set	reorder

$L667:
	.set	noreorder
	.set	nomacro
	j	$L655
	sh	$0,80($16)
	.set	macro
	.set	reorder

$L660:
	.set	noreorder
	bgez	$5,1f
	move	$2,$5
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,33
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L655
	lui	$3,%hi(Cars_topSpeedCap) # high
	.set	macro
	.set	reorder

	li	$4,1374355456			# 0x51eb0000
	lh	$2,2236($7)
	addiu	$3,$3,%lo(Cars_topSpeedCap) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,0($2)
	ori	$4,$4,0x851f
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	sra	$3,$8,21
	subu	$3,$3,$2
	slt	$2,$5,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L668
	ori	$2,$6,0x0002
	.set	macro
	.set	reorder

	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	ori	$2,$6,0x0004
	.set	macro
	.set	reorder

$L668:
	sh	$2,80($16)
$L664:
	lhu	$2,80($16)
	li	$3,6			# 0x00000006
	andi	$2,$2,0x0006
	bne	$2,$3,$L655
	lw	$4,0($16)
	jal	Mobile__6SpeechP8Car_tObj
	lw	$3,76($2)
	#nop
	lh	$4,56($3)
	lw	$3,60($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$2,$4
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sh	$0,80($16)
	sw	$2,AICop_gRoadBlockState
$L655:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	HandleBlockadeSpeech__15AIHigh_BasicCop
	.text
	.ent	___15AIHigh_BasicCop
___15AIHigh_BasicCop:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___11AIHigh_Base
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___15AIHigh_BasicCop
