	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\object.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CalcObjYawAngle__FP8CCOORD16
	.align	2
	.globl	CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
	.align	2
	.globl	BuildObjCollisionMatrix__FiiiP10matrixtdef
	.align	2
	.globl	FindObjInstanceFromSerialNum__FP5Groupi
	.align	2
	.globl	Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
	.align	2
	.globl	GetSimObj__FiP18Object_tSimObjListPi
	.align	2
	.globl	Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
	.align	2
	.globl	Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
	.align	2
	.globl	Object_InitStatus__Fv
	.align	2
	.globl	Object_KillStatus__Fv
	.align	2
	.globl	Object_GetAnim__FP13Trk_SimObject
	.align	2
	.globl	Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
	.rdata
	.align	2
$LC0:
	.ascii	"Custom Objects\000"
	.align	2
$LC1:
	.ascii	"Custom SimObjects\000"
	.text
	.align	2
	.globl	Object_InitCustomObjects__Fv
	.align	2
	.globl	Object_DeInitCustomObjects__Fv
	.align	2
	.globl	Object_ClearCustomObjects__Fv
	.align	2
	.globl	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	.align	2
	.globl	Object_AddCustomSimObject__FP9SceneElemii
	.align	2
	.globl	Object_GetObjDefID__Fi
	.align	2
	.globl	Object_FindDefWithThisID__Fi
	.align	2
	.globl	Object_AddCustomObject__FP9SceneElemi
	.align	2
	.globl	GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
	.rdata
	.align	2
$LC2:
	.ascii	"IMObj info\000"
	.text
	.align	2
	.globl	Object_InitIMassObjectInfo__Fv
	.align	2
	.globl	Object_DeInitIMassObjectInfo__Fv
	.align	2
	.globl	Object_GetNumIMassObjects__Fv
	.align	2
	.globl	Object_GetIMassObjectDimensions__FiP8coorddef
	.align	2
	.globl	Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
	.align	2
	.globl	Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei
	.align	2
	.globl	__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
	.align	2
	.globl	Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei
	.align	2
	.globl	Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei
	.align	2
	.globl	__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
	.align	2
	.globl	Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei
	.align	2
	.globl	___14ObjectSignAnim
	.align	2
	.globl	___22ObjectFinishedSignAnim
	.align	2
	.globl	___15ObjectMultiAnim
	.align	2
	.globl	___23ObjectFinishedMultiAnim
	.align	2
	.globl	_._10ObjectAnim
	.globl	Object_customObjInst
	.sdata
	.align	2
Object_customObjInst:
	.space	4
	.globl	Object_customSimObjs
	.align	2
Object_customSimObjs:
	.space	4
	.globl	Object_customSFXInst
	.align	2
Object_customSFXInst:
	.space	4
	.globl	Object_customSliceNum
	.align	2
Object_customSliceNum:
	.space	4
	.globl	gSimObjAnims
	.data
	.align	2
gSimObjAnims:
	.space	1800
	.globl	Object_IMassObjInst
	.sdata
	.align	2
Object_IMassObjInst:
	.space	4
	.globl	gNumIMassObjects
	.align	2
gNumIMassObjects:
	.space	4

	.extern	gPersistObjInst, 4
	.extern	Track_gSaveSurface, 4
	.extern	Cars_gNumCopCars, 4
	.extern	Cars_gNumTrafficCars, 4
	.extern	gPersistObjDef, 4
	.extern	gAnimDefs, 280
	.extern	Track_gObjDefs, 4
	.extern	simGlobal, 24
	.extern	BWorldSm_slices, 4
	.extern	gNumSlices, 4
	.extern	Track_chunkList, 4

	.text
	.text
	.ent	CalcObjYawAngle__FP8CCOORD16
CalcObjYawAngle__FP8CCOORD16:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lh	$6,8($4)
	lh	$2,0($4)
	lh	$3,12($4)
	lh	$5,4($4)
	subu	$4,$6,$2
	.set	noreorder
	.set	nomacro
	jal	fixedatan
	subu	$5,$3,$5
	.set	macro
	.set	reorder

	addu	$2,$2,-16384
	lw	$31,16($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CalcObjYawAngle__FP8CCOORD16
	.text
	.ent	CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat:
	.frame	$sp,104,$31		# vars= 72, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$31,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	lw	$17,0($4)
	lh	$2,0($5)
	lw	$18,8($4)
	sll	$2,$2,10
	sw	$2,56($sp)
	lh	$2,4($5)
	move	$16,$6
	sll	$2,$2,10
	sw	$2,64($sp)
	lh	$2,8($5)
	move	$4,$7
	sll	$2,$2,10
	sw	$2,72($sp)
	lh	$2,12($5)
	addu	$5,$sp,16
	sll	$2,$2,10
	sw	$2,80($sp)
	sw	$17,0($16)
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	sw	$18,8($16)
	.set	macro
	.set	reorder

	addu	$4,$sp,56
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	transform
	addu	$6,$16,12
	.set	macro
	.set	reorder

	addu	$4,$sp,72
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	transform
	addu	$6,$16,24
	.set	macro
	.set	reorder

	lw	$2,12($16)
	lw	$3,20($16)
	addu	$2,$2,$17
	sw	$2,12($16)
	lw	$2,24($16)
	addu	$3,$3,$18
	sw	$3,20($16)
	lw	$3,32($16)
	addu	$2,$2,$17
	addu	$3,$3,$18
	sw	$2,24($16)
	sw	$3,32($16)
	lw	$31,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
	.text
	.ent	BuildObjCollisionMatrix__FiiiP10matrixtdef
BuildObjCollisionMatrix__FiiiP10matrixtdef:
	.frame	$sp,160,$31		# vars= 120, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$16,136($sp)
	move	$16,$4
	sw	$17,140($sp)
	move	$17,$5
	sw	$18,144($sp)
	move	$18,$6
	sw	$19,148($sp)
	move	$19,$7
	subu	$4,$0,$18
	li	$5,65536			# 0x00010000
	sw	$31,152($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$5,$16
	.set	macro
	.set	reorder

	subu	$4,$0,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$sp,56
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	addu	$5,$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$19
	addu	$16,$sp,96
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$19
	.set	macro
	.set	reorder

	lw	$31,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	BuildObjCollisionMatrix__FiiiP10matrixtdef
	.text
	.ent	FindObjInstanceFromSerialNum__FP5Groupi
FindObjInstanceFromSerialNum__FP5Groupi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$2,$5,-126
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	andi	$2,$5,0x0080
	.set	macro
	.set	reorder

$L617:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L605:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	li	$3,-129			# 0xffffff7f
	.set	macro
	.set	reorder

	lw	$4,Object_customObjInst
	#nop
	lw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$L616
	and	$5,$5,$3
	.set	macro
	.set	reorder

$L606:
	lw	$2,0($4)
$L616:
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$5,$2,$L612
	addu	$4,$4,4
	.set	macro
	.set	reorder

	move	$3,$2
$L613:
	lh	$2,0($4)
	addu	$5,$5,-1
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L613
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L612:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	FindObjInstanceFromSerialNum__FP5Groupi
	.text
	.ent	Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$4
	sw	$31,20($sp)
	sw	$16,16($sp)
	lbu	$2,117($7)
	#nop
	sll	$3,$2,3
	subu	$3,$3,$2
	lw	$2,Track_chunkList
	sll	$3,$3,4
	addu	$3,$3,$2
	lw	$2,80($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	move	$16,$6
	.set	macro
	.set	reorder

	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L620
	sw	$2,0($5)
	.set	macro
	.set	reorder

$L619:
	sw	$0,0($5)
$L620:
	lbu	$2,117($7)
	sw	$0,8($5)
	sw	$2,4($5)
	lh	$6,0($7)
	lw	$3,gNumSlices
	addu	$4,$6,1
	slt	$2,$4,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	sll	$2,$4,5
	.set	macro
	.set	reorder

	lw	$3,BWorldSm_slices
	.set	noreorder
	.set	nomacro
	j	$L637
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L621:
	addu	$2,$3,-1
	subu	$2,$6,$2
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$3,$2
$L637:
	lbu	$4,28($2)
	lbu	$2,117($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L623
	sll	$2,$4,3
	.set	macro
	.set	reorder

	subu	$2,$2,$4
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,80($2)
	#nop
	beq	$2,$0,$L623
	lw	$2,0($2)
	#nop
	sw	$2,8($5)
	lw	$2,0($5)
	lw	$3,8($5)
	sw	$4,12($5)
	.set	noreorder
	.set	nomacro
	j	$L635
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L623:
	lh	$3,0($7)
	#nop
	addu	$2,$3,-1
	bgez	$2,$L636
	lw	$2,gNumSlices
	#nop
	addu	$2,$2,-1
	addu	$2,$3,$2
$L636:
	lw	$3,BWorldSm_slices
	sll	$2,$2,5
	addu	$2,$3,$2
	lbu	$4,28($2)
	lbu	$2,117($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L627
	sll	$2,$4,3
	.set	macro
	.set	reorder

	subu	$2,$2,$4
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$2,$2,$3
	lw	$2,80($2)
	#nop
	beq	$2,$0,$L627
	lw	$2,0($2)
	#nop
	sw	$2,8($5)
	lw	$2,0($5)
	lw	$3,8($5)
	sw	$4,12($5)
	.set	noreorder
	.set	nomacro
	j	$L635
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L627:
	lw	$2,0($5)
$L635:
	sw	$2,0($16)
	lw	$2,Object_customSimObjs
	#nop
	beq	$2,$0,$L618
	lw	$2,0($2)
	#nop
	blez	$2,$L618
	lw	$4,Object_customSliceNum
	lh	$5,0($7)
	lw	$2,BWorldSm_slices
	sll	$4,$4,5
	sll	$5,$5,5
	addu	$4,$2,$4
	.set	noreorder
	.set	nomacro
	jal	Math_DistXZ__FP8coorddefT0
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	li	$3,12517376			# 0x00bf0000
	ori	$3,$3,0xffff
	slt	$3,$3,$2
	bne	$3,$0,$L618
	lw	$2,Object_customSimObjs
	#nop
	lw	$3,0($2)
	lw	$2,0($16)
	#nop
	addu	$2,$2,$3
	sw	$2,0($16)
$L618:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
	.text
	.ent	GetSimObj__FiP18Object_tSimObjListPi
GetSimObj__FiP18Object_tSimObjListPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($5)
	lw	$8,8($5)
	#nop
	addu	$2,$3,$8
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L639
	move	$7,$0
	.set	macro
	.set	reorder

	subu	$2,$4,$3
	subu	$4,$2,$8
	lw	$3,Object_customSimObjs
	li	$2,-1			# 0xffffffff
	sw	$2,0($6)
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$7,$3,4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$7,$2
	.set	macro
	.set	reorder

$L639:
	lw	$2,4($5)
	#nop
	sw	$2,0($6)
	lw	$3,0($5)
	#nop
	slt	$2,$4,$3
	bne	$2,$0,$L640
	lw	$2,12($5)
	subu	$4,$4,$3
	sw	$2,0($6)
$L640:
	lw	$2,0($6)
	#nop
	sll	$3,$2,3
	subu	$3,$3,$2
	lw	$2,Track_chunkList
	sll	$3,$3,4
	addu	$3,$3,$2
	lw	$2,80($3)
	#nop
	beq	$2,$0,$L641
	addu	$7,$2,4
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$7,$7,$2
	lbu	$3,19($7)
	li	$2,16			# 0x00000010
	bne	$3,$2,$L641
	move	$7,$0
$L641:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	GetSimObj__FiP18Object_tSimObjListPi
	.text
	.ent	Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi:
	.frame	$sp,48,$31		# vars= 8, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$2,$4
	move	$4,$5
	move	$5,$2
	sw	$18,40($sp)
	move	$18,$6
	addu	$6,$sp,24
	sw	$17,36($sp)
	move	$17,$7
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	GetSimObj__FiP18Object_tSimObjListPi
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L645
	lbu	$2,19($16)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L646
	lui	$2,%hi(gSimObjAnims) # high
	.set	macro
	.set	reorder

	lh	$3,14($16)
	addiu	$2,$2,%lo(gSimObjAnims) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L646
	lw	$3,24($sp)
	lbu	$5,18($16)
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$3,$3,$2
	lw	$4,64($3)
	jal	FindObjInstanceFromSerialNum__FP5Groupi
	move	$4,$2
	li	$5,1			# 0x00000001
	lui	$2,%hi(simGlobal+4) # high
	lw	$6,%lo(simGlobal+4)($2)
	addu	$2,$sp,28
	move	$7,$16
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L646:
	lw	$8,0($16)
	lw	$9,4($16)
	lw	$10,8($16)
	sw	$8,0($18)
	sw	$9,4($18)
	sw	$10,8($18)
	lh	$2,12($16)
	#nop
	sll	$2,$2,7
	.set	noreorder
	.set	nomacro
	j	$L647
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L645:
	sw	$0,0($17)
$L647:
	lw	$31,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
	.text
	.ent	Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$2,$4
	move	$4,$5
	move	$5,$2
	sw	$17,28($sp)
	move	$17,$6
	addu	$6,$sp,16
	sw	$18,32($sp)
	move	$18,$7
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	GetSimObj__FiP18Object_tSimObjListPi
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L649
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L650
	sll	$2,$3,3
	.set	macro
	.set	reorder

	lbu	$5,18($16)
	.set	noreorder
	.set	nomacro
	j	$L657
	move	$4,$0
	.set	macro
	.set	reorder

$L650:
	subu	$2,$2,$3
	sll	$2,$2,4
	lw	$3,Track_chunkList
	lbu	$5,18($16)
	addu	$2,$2,$3
	lw	$4,64($2)
$L657:
	jal	FindObjInstanceFromSerialNum__FP5Groupi
	move	$7,$2
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L652
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lh	$2,6($7)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lbu	$3,2($7)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L658
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,35($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L653
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$5,4
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat
	addu	$7,$7,20
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	j	$L648
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L653:
$L658:
	lw	$8,0($16)
	lw	$9,4($16)
	lw	$10,8($16)
	sw	$8,0($18)
	sw	$9,4($18)
	sw	$10,8($18)
	.set	noreorder
	.set	nomacro
	j	$L648
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L652:
	li	$2,1			# 0x00000001
	sw	$2,0($17)
	lw	$8,0($16)
	lw	$9,4($16)
	lw	$10,8($16)
	sw	$8,0($18)
	sw	$9,4($18)
	.set	noreorder
	.set	nomacro
	j	$L648
	sw	$10,8($18)
	.set	macro
	.set	reorder

$L649:
	sw	$0,0($17)
$L648:
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

	.end	Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
	.text
	.ent	Object_InitStatus__Fv
Object_InitStatus__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,449			# 0x000001c1
	lui	$2,%hi(gSimObjAnims) # high
	addiu	$2,$2,%lo(gSimObjAnims) # low
	addu	$2,$2,1796
$L660:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L660
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	j	$31
	.end	Object_InitStatus__Fv
	.text
	.ent	Object_KillStatus__Fv
Object_KillStatus__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(gSimObjAnims) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gSimObjAnims) # low
	sw	$31,24($sp)
$L665:
	lw	$3,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L668
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L668:
	addu	$17,$17,1
	slt	$2,$17,450
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	addu	$16,$16,4
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

	.end	Object_KillStatus__Fv
	.text
	.ent	Object_GetAnim__FP13Trk_SimObject
Object_GetAnim__FP13Trk_SimObject:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L671
	lui	$3,%hi(gSimObjAnims) # high
	.set	macro
	.set	reorder

	lh	$2,14($4)
	addiu	$3,$3,%lo(gSimObjAnims) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	j	$31
$L671:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Object_GetAnim__FP13Trk_SimObject
	.text
	.ent	Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj:
	.frame	$sp,80,$31		# vars= 8, regs= 8/0, args= 40, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	move	$2,$4
	sw	$16,48($sp)
	move	$16,$0
	move	$4,$5
	move	$5,$2
	sw	$22,72($sp)
	move	$22,$6
	addu	$6,$sp,40
	sw	$31,76($sp)
	sw	$21,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$18,56($sp)
	sw	$17,52($sp)
	lw	$3,172($22)
	lw	$2,180($22)
	bgez	$3,1f
	subu	$3,$0,$3
1:
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	GetSimObj__FiP18Object_tSimObjListPi
	sra	$17,$3,16
	.set	macro
	.set	reorder

	move	$19,$2
	lui	$3,%hi(gSimObjAnims) # high
	addiu	$3,$3,%lo(gSimObjAnims) # low
	lh	$2,14($19)
	lbu	$4,19($19)
	sll	$2,$2,2
	addu	$2,$2,$3
	andi	$4,$4,0x000f
	li	$3,2			# 0x00000002
	lw	$2,0($2)
	beq	$4,$3,$L677
	slt	$2,$4,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L680
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L698
$L695:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L692
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L698
$L677:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L698
	move	$2,$16
	.set	macro
	.set	reorder

	bltz	$17,$L680
	lw	$3,40($sp)
	lbu	$5,18($19)
	sll	$2,$3,3
	subu	$2,$2,$3
	lw	$3,Track_chunkList
	sll	$2,$2,4
	addu	$3,$3,$2
	lw	$4,64($3)
	jal	FindObjInstanceFromSerialNum__FP5Groupi
	move	$20,$2
	lbu	$3,2($2)
	li	$2,6			# 0x00000006
	bne	$3,$2,$L681
	lbu	$2,13($20)
	.set	noreorder
	.set	nomacro
	j	$L699
	sll	$3,$2,2
	.set	macro
	.set	reorder

$L681:
	lbu	$2,35($20)
	#nop
	sll	$3,$2,2
$L699:
	addu	$3,$3,$2
	sll	$3,$3,2
	lui	$2,%hi(gAnimDefs) # high
	addiu	$2,$2,%lo(gAnimDefs) # low
	addu	$18,$3,$2
	lw	$2,16($18)
	#nop
	beq	$2,$0,$L683
	lw	$2,gPersistObjDef
	.set	noreorder
	.set	nomacro
	j	$L684
	addu	$21,$2,4
	.set	macro
	.set	reorder

$L683:
	lh	$2,6($20)
	lw	$3,Track_gObjDefs
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$21,0($2)
$L684:
	lw	$3,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L685
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L687
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$4,48			# 0x00000030
	move	$16,$2
	lui	$2,%hi(ObjectFinishedMultiAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectFinishedMultiAnim_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$22,172
	move	$6,$18
	move	$7,$20
	sw	$21,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L700
	lui	$4,%hi(gSimObjAnims) # high
	.set	macro
	.set	reorder

$L685:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,48			# 0x00000030
	.set	macro
	.set	reorder

	li	$4,48			# 0x00000030
	move	$17,$2
	lui	$2,%hi(ObjectFinishedSignAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectFinishedSignAnim_vtable) # low
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,0($17)
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$4,172($22)
	lw	$5,180($22)
	sra	$4,$4,8
	.set	noreorder
	.set	nomacro
	jal	fixedatan
	sra	$5,$5,8
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$22,172
	sra	$6,$2,8
	move	$7,$18
	addu	$2,$22,336
	sw	$20,16($sp)
	sw	$21,20($sp)
	sw	$19,24($sp)
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
	sw	$17,32($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(gSimObjAnims) # high
$L700:
	lh	$3,14($19)
	addiu	$4,$4,%lo(gSimObjAnims) # low
	sll	$3,$3,2
	addu	$3,$3,$4
	sw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L687
	li	$16,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L680:
	.set	noreorder
	.set	nomacro
	j	$L687
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L692:
	li	$16,2			# 0x00000002
$L687:
	move	$2,$16
$L698:
	lw	$31,76($sp)
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
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
	.text
	.ent	Object_InitCustomObjects__Fv
Object_InitCustomObjects__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,1024			# 0x00000400
	move	$6,$0
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi($LC1) # high
	addiu	$16,$16,%lo($LC1) # low
	move	$4,$16
	li	$5,1024			# 0x00000400
	move	$6,$0
	sw	$2,Object_customObjInst
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$0,0($2)
	.set	macro
	.set	reorder

	addu	$4,$2,4
	li	$5,1020			# 0x000003fc
	move	$6,$0
	sw	$2,Object_customSimObjs
	.set	noreorder
	.set	nomacro
	jal	blockfill
	sw	$0,0($2)
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,1024			# 0x00000400
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$0,0($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	sw	$2,Object_customSFXInst
	sw	$0,Object_customSliceNum
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Object_InitCustomObjects__Fv
	.text
	.ent	Object_DeInitCustomObjects__Fv
Object_DeInitCustomObjects__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,Object_customObjInst
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L703
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L703:
	lw	$4,Object_customSFXInst
	#nop
	beq	$4,$0,$L704
	jal	purgememadr
$L704:
	lw	$4,Object_customSimObjs
	#nop
	beq	$4,$0,$L705
	jal	purgememadr
$L705:
	lw	$31,16($sp)
	sw	$0,Object_customObjInst
	sw	$0,Object_customSFXInst
	sw	$0,Object_customSimObjs
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Object_DeInitCustomObjects__Fv
	.text
	.ent	Object_ClearCustomObjects__Fv
Object_ClearCustomObjects__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$2,Object_customObjInst
	lw	$3,Object_customSimObjs
	lw	$4,Object_customSFXInst
	lw	$6,Cars_gNumTrafficCars
	move	$5,$0
	sw	$31,16($sp)
	sw	$0,0($2)
	sw	$0,0($3)
	.set	noreorder
	.set	nomacro
	blez	$6,$L708
	sw	$0,0($4)
	.set	macro
	.set	reorder

	li	$7,-1025			# 0xfffffbff
	lui	$2,%hi(Cars_gTrafficCarList) # high
	addiu	$4,$2,%lo(Cars_gTrafficCarList) # low
$L710:
	lw	$2,0($4)
	#nop
	lw	$3,608($2)
	addu	$5,$5,1
	and	$3,$3,$7
	sw	$3,608($2)
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L708:
	lw	$6,Cars_gNumCopCars
	#nop
	.set	noreorder
	.set	nomacro
	blez	$6,$L713
	move	$5,$0
	.set	macro
	.set	reorder

	li	$7,-1025			# 0xfffffbff
	lui	$2,%hi(Cars_gCopCarList) # high
	addiu	$4,$2,%lo(Cars_gCopCarList) # low
$L715:
	lw	$2,0($4)
	#nop
	lw	$3,608($2)
	addu	$5,$5,1
	and	$3,$3,$7
	sw	$3,608($2)
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L715
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L713:
	lw	$4,Track_gSaveSurface
	#nop
	beq	$4,$0,$L706
	jal	RestoreAll__11SaveSurface
$L706:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Object_ClearCustomObjects__Fv
	.text
	.ent	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
SetCautionSurface__FP8coorddefP12BWorldSm_Pos:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,120($16)
	#nop
	beq	$5,$0,$L718
	lbu	$2,0($5)
	#nop
	andi	$2,$2,0x0040
	bne	$2,$0,$L718
	lw	$4,Track_gSaveSurface
	jal	Save__11SaveSurfaceP14Trk_NewSimQuad
	lw	$3,120($16)
	#nop
	lbu	$2,0($3)
	#nop
	ori	$2,$2,0x0040
	sb	$2,0($3)
$L718:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	.text
	.ent	Object_AddCustomSimObject__FP9SceneElemii
Object_AddCustomSimObject__FP9SceneElemii:
	.frame	$sp,200,$31		# vars= 152, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,200
	sw	$20,184($sp)
	move	$20,$4
	sw	$21,188($sp)
	move	$21,$5
	sw	$31,196($sp)
	sw	$22,192($sp)
	sw	$19,180($sp)
	sw	$18,176($sp)
	sw	$17,172($sp)
	sw	$16,168($sp)
	lw	$2,0($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L721
	move	$22,$6
	.set	macro
	.set	reorder

	lw	$3,Object_customSimObjs
	#nop
	lw	$4,0($3)
	addu	$3,$3,4
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$2,$2,2
	lw	$4,16($20)
	addu	$19,$3,$2
	sw	$4,0($19)
	lw	$2,20($20)
	addu	$5,$sp,16
	sw	$2,4($19)
	lw	$2,24($20)
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_SetSlice__FiP12BWorldSm_Pos
	sw	$2,8($19)
	.set	macro
	.set	reorder

	addu	$17,$sp,152
	move	$4,$17
	lw	$7,16($20)
	lw	$8,20($20)
	lw	$9,24($20)
	sw	$7,152($sp)
	sw	$8,156($sp)
	sw	$9,160($sp)
	.set	noreorder
	.set	nomacro
	jal	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$sp,16
	lw	$2,152($sp)
	li	$16,-262144			# 0xfffc0000
	addu	$2,$2,$16
	.set	noreorder
	.set	nomacro
	jal	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	sw	$2,152($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$sp,16
	lw	$2,152($sp)
	li	$18,524288			# 0x00080000
	addu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	jal	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	sw	$2,152($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$sp,16
	lw	$2,152($sp)
	lw	$3,160($sp)
	addu	$2,$2,$16
	addu	$3,$3,$16
	sw	$2,152($sp)
	.set	noreorder
	.set	nomacro
	jal	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	sw	$3,160($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	lw	$2,160($sp)
	addu	$5,$sp,16
	addu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	jal	SetCautionSurface__FP8coorddefP12BWorldSm_Pos
	sw	$2,160($sp)
	.set	macro
	.set	reorder

	lh	$4,16($sp)
	lw	$3,80($20)
	addu	$2,$21,400
	sh	$2,14($19)
	addu	$2,$22,-128
	sra	$3,$3,9
	sw	$4,Object_customSliceNum
	sh	$3,12($19)
	sb	$2,18($19)
	lw	$2,76($20)
	#nop
	slt	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L726
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L726:
	sb	$2,19($19)
	lw	$3,Object_customSimObjs
	#nop
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	sw	$2,0($3)
$L721:
	lw	$2,Object_customSimObjs
	lw	$31,196($sp)
	lw	$22,192($sp)
	lw	$21,188($sp)
	lw	$20,184($sp)
	lw	$19,180($sp)
	lw	$18,176($sp)
	lw	$17,172($sp)
	lw	$2,0($2)
	lw	$16,168($sp)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,200
	.set	macro
	.set	reorder

	.end	Object_AddCustomSimObject__FP9SceneElemii
	.text
	.ent	Object_GetObjDefID__Fi
Object_GetObjDefID__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,gPersistObjDef
	#nop
	beq	$2,$0,$L728
	lw	$2,0($2)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L728
	sll	$3,$4,2
	.set	macro
	.set	reorder

	lw	$2,Track_gObjDefs
	#nop
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	lh	$2,0($2)
	j	$31
$L728:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Object_GetObjDefID__Fi
	.text
	.ent	Object_FindDefWithThisID__Fi
Object_FindDefWithThisID__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	lw	$2,gPersistObjDef
	lw	$5,Track_gObjDefs
	lw	$6,0($2)
$L733:
	slt	$2,$3,$6
	beq	$2,$0,$L735
	lw	$2,0($5)
	#nop
	lh	$2,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L737
	addu	$5,$5,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

$L737:
	.set	noreorder
	.set	nomacro
	j	$L733
	addu	$3,$3,1
	.set	macro
	.set	reorder

$L735:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.end	Object_FindDefWithThisID__Fi
	.text
	.ent	Object_AddCustomObject__FP9SceneElemi
Object_AddCustomObject__FP9SceneElemi:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$18,32($sp)
	sw	$31,36($sp)
	sw	$16,24($sp)
	lw	$3,0($17)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L743
	move	$18,$5
	.set	macro
	.set	reorder

	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L744
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L746
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	j	$L741
$L744:
	beq	$3,$2,$L749
	j	$L741
$L746:
	lw	$4,Object_customObjInst
	#nop
	lw	$3,0($4)
	#nop
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L752
	addu	$16,$4,4
	.set	macro
	.set	reorder

	lh	$2,4($4)
	li	$4,-1			# 0xffffffff
$L753:
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L753
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L752:
	li	$2,36			# 0x00000024
	sh	$2,0($16)
	lw	$2,76($17)
	#nop
	slt	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L777
	li	$2,5			# 0x00000005
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
$L777:
	sb	$2,2($16)
	li	$2,3			# 0x00000003
	sb	$2,4($16)
	sb	$0,5($16)
	lw	$2,16($17)
	#nop
	sw	$2,8($16)
	lw	$2,20($17)
	#nop
	sw	$2,12($16)
	lw	$2,24($17)
	sb	$0,3($16)
	lw	$3,gPersistObjDef
	sw	$2,16($16)
	lhu	$2,72($17)
	#nop
	sh	$2,6($16)
	sll	$2,$2,16
	lw	$3,0($3)
	sra	$2,$2,16
	slt	$2,$2,$3
	bne	$2,$0,$L759
	sh	$0,6($16)
$L759:
	lw	$2,8($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L778
	addu	$4,$17,32
	.set	macro
	.set	reorder

	lw	$2,12($17)
	#nop
	beq	$2,$0,$L778
	lh	$4,6($16)
	jal	Object_GetObjDefID__Fi
	lw	$4,76($17)
	#nop
	beq	$2,$4,$L760
	jal	Object_FindDefWithThisID__Fi
	lw	$4,76($17)
	jal	Object_FindDefWithThisID__Fi
	move	$3,$2
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L762
	sh	$3,6($16)
	lw	$4,76($17)
	.set	noreorder
	.set	nomacro
	jal	Object_FindDefWithThisID__Fi
	sw	$3,72($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L778
	addu	$4,$17,32
	.set	macro
	.set	reorder

$L762:
	lh	$4,6($16)
	jal	Object_GetObjDefID__Fi
	sw	$2,76($17)
$L760:
	addu	$4,$17,32
$L778:
	.set	noreorder
	.set	nomacro
	jal	Quatern_MatToQuat__FP10matrixtdefP5tQuat
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lhu	$2,22($sp)
	#nop
	sh	$2,26($16)
	lhu	$2,16($sp)
	#nop
	sh	$2,20($16)
	lhu	$2,18($sp)
	#nop
	sh	$2,22($16)
	lhu	$3,20($sp)
	li	$2,256			# 0x00000100
	sh	$2,28($16)
	sh	$2,30($16)
	sh	$2,32($16)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L764
	sh	$3,24($16)
	.set	macro
	.set	reorder

	lw	$2,Object_customObjInst
	#nop
	lw	$5,0($2)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Object_AddCustomSimObject__FP9SceneElemii
	move	$6,$5
	.set	macro
	.set	reorder

	sb	$2,34($16)
	lbu	$2,76($17)
	.set	noreorder
	.set	nomacro
	j	$L765
	sb	$2,35($16)
	.set	macro
	.set	reorder

$L764:
	sb	$0,34($16)
	sb	$0,35($16)
$L765:
	lw	$3,Object_customObjInst
	#nop
	lw	$2,0($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L741
	sw	$2,0($3)
	.set	macro
	.set	reorder

$L749:
	lw	$5,Object_customSFXInst
	lw	$4,16($17)
	lw	$3,0($5)
	addu	$2,$5,4
	sll	$3,$3,4
	addu	$2,$2,$3
	sw	$4,0($2)
	lw	$3,20($17)
	#nop
	sw	$3,4($2)
	lw	$3,24($17)
	#nop
	sw	$3,8($2)
	lhu	$3,68($17)
	sh	$0,14($2)
	sh	$3,12($2)
	lw	$2,0($5)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L741
	sw	$2,0($5)
	.set	macro
	.set	reorder

$L743:
	move	$5,$0
	lw	$2,68($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L741
	move	$4,$5
	.set	macro
	.set	reorder

	lw	$3,Cars_gNumTrafficCars
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L741
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	lui	$2,%hi(Cars_gTrafficCarList) # high
	.set	macro
	.set	reorder

	move	$6,$3
	addiu	$4,$2,%lo(Cars_gTrafficCarList) # low
$L772:
	lw	$3,0($4)
	#nop
	lw	$2,608($3)
	#nop
	andi	$2,$2,0x0400
	bne	$2,$0,$L771
	lh	$3,2236($3)
	lw	$2,84($17)
	#nop
	beq	$3,$2,$L770
$L771:
	addu	$5,$5,1
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L772
	addu	$4,$4,4
	.set	macro
	.set	reorder

$L770:
	lw	$2,Cars_gNumTrafficCars
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	lui	$3,%hi(Cars_gTrafficCarList) # high
	.set	macro
	.set	reorder

	addiu	$3,$3,%lo(Cars_gTrafficCarList) # low
	sll	$2,$5,2
	addu	$2,$2,$3
	lw	$4,0($2)
	lui	$3,%hi(highLevelAIObjs) # high
	lw	$2,596($4)
	addiu	$3,$3,%lo(highLevelAIObjs) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$17,32($2)
$L741:
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

	.end	Object_AddCustomObject__FP9SceneElemi
	.text
	.ent	GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$6
	sw	$31,40($sp)
	sw	$16,32($sp)
	lh	$2,6($5)
	move	$5,$0
	li	$6,8			# 0x00000008
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$16,0($2)
	.set	noreorder
	.set	nomacro
	jal	memset
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	lbu	$6,2($16)
	#nop
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L780
	addu	$7,$16,4
	.set	macro
	.set	reorder

	move	$8,$2
	addu	$5,$16,8
$L781:
	lh	$4,0($7)
	lh	$2,24($sp)
	lhu	$3,0($7)
	slt	$2,$2,$4
	beq	$2,$0,$L784
	.set	noreorder
	.set	nomacro
	j	$L785
	sh	$3,24($sp)
	.set	macro
	.set	reorder

$L784:
	lh	$2,16($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L785
	sh	$3,16($sp)
$L785:
	lh	$4,-2($5)
	lh	$2,26($sp)
	lhu	$3,-2($5)
	slt	$2,$2,$4
	beq	$2,$0,$L787
	.set	noreorder
	.set	nomacro
	j	$L788
	sh	$3,26($sp)
	.set	macro
	.set	reorder

$L787:
	lh	$2,18($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L788
	sh	$3,18($sp)
$L788:
	lh	$4,0($5)
	lh	$2,28($sp)
	lhu	$3,0($5)
	slt	$2,$2,$4
	beq	$2,$0,$L790
	.set	noreorder
	.set	nomacro
	j	$L791
	sh	$3,28($sp)
	.set	macro
	.set	reorder

$L790:
	lh	$2,20($sp)
	#nop
	slt	$2,$4,$2
	beq	$2,$0,$L791
	sh	$3,20($sp)
$L791:
	addu	$5,$5,8
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$8,$L781
	addu	$7,$7,8
	.set	macro
	.set	reorder

$L780:
	lh	$2,24($sp)
	lh	$3,16($sp)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,9
	sw	$2,0($17)
	lh	$2,26($sp)
	lh	$3,18($sp)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,9
	sw	$2,4($17)
	lh	$2,28($sp)
	lh	$3,20($sp)
	#nop
	subu	$2,$2,$3
	sll	$2,$2,9
	sw	$2,8($17)
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
	.text
	.ent	Object_InitIMassObjectInfo__Fv
Object_InitIMassObjectInfo__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$5,gPersistObjInst
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$0,gNumIMassObjects
	sw	$0,Object_IMassObjInst
	beq	$5,$0,$L795
	lw	$2,gPersistObjDef
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC2) # low
	lw	$5,0($5)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,5
	.set	macro
	.set	reorder

	sw	$2,Object_IMassObjInst
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L795
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,gPersistObjInst
	#nop
	lw	$3,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L795
	addu	$16,$2,4
	.set	macro
	.set	reorder

$L799:
	lbu	$3,2($16)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L802
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,Track_gObjDefs
	lw	$2,gNumIMassObjects
	lw	$3,Object_IMassObjInst
	sll	$2,$2,5
	addu	$2,$2,$3
	addu	$6,$2,4
	.set	noreorder
	.set	nomacro
	jal	GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
	sw	$16,0($2)
	.set	macro
	.set	reorder

	lw	$4,gNumIMassObjects
	lw	$3,Object_IMassObjInst
	sll	$2,$4,5
	addu	$2,$2,$3
	addu	$4,$4,1
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	sw	$4,gNumIMassObjects
$L802:
	addu	$17,$17,1
	lw	$2,gPersistObjInst
	lh	$3,0($16)
	lw	$2,0($2)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L799
	addu	$16,$16,$3
	.set	macro
	.set	reorder

$L795:
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

	.end	Object_InitIMassObjectInfo__Fv
	.text
	.ent	Object_DeInitIMassObjectInfo__Fv
Object_DeInitIMassObjectInfo__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,Object_IMassObjInst
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L805
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L805:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Object_DeInitIMassObjectInfo__Fv
	.text
	.ent	Object_GetNumIMassObjects__Fv
Object_GetNumIMassObjects__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,gNumIMassObjects
	j	$31
	.end	Object_GetNumIMassObjects__Fv
	.text
	.ent	Object_GetIMassObjectDimensions__FiP8coorddef
Object_GetIMassObjectDimensions__FiP8coorddef:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Object_IMassObjInst
	sll	$4,$4,5
	addu	$4,$4,$2
	lw	$3,4($4)
	lw	$6,8($4)
	lw	$7,12($4)
	sw	$3,0($5)
	sw	$6,4($5)
	sw	$7,8($5)
	j	$31
	.end	Object_GetIMassObjectDimensions__FiP8coorddef
	.text
	.ent	Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lw	$2,Object_IMassObjInst
	subu	$sp,$sp,48
	sw	$20,40($sp)
	move	$20,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$17,28($sp)
	move	$17,$6
	sw	$16,24($sp)
	sll	$16,$20,5
	sw	$31,44($sp)
	sw	$18,32($sp)
	addu	$2,$16,$2
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	DrawW_GetAnimationTime__FP15Trk_AnimateInst
	move	$18,$7
	.set	macro
	.set	reorder

	sw	$17,16($sp)
	move	$17,$2
	li	$5,1			# 0x00000001
	lw	$3,Object_IMassObjInst
	move	$6,$17
	addu	$3,$16,$3
	lw	$4,0($3)
	.set	noreorder
	.set	nomacro
	jal	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
	move	$7,$19
	.set	macro
	.set	reorder

	lw	$2,Object_IMassObjInst
	#nop
	addu	$16,$16,$2
	lw	$2,28($16)
	#nop
	subu	$4,$17,$2
	blez	$4,$L811
	lw	$2,0($19)
	lw	$3,16($16)
	#nop
	subu	$2,$2,$3
	div	$2,$2,$4
	sll	$2,$2,6
	sw	$2,0($18)
	lw	$2,4($19)
	lw	$3,20($16)
	#nop
	subu	$2,$2,$3
	div	$2,$2,$4
	sll	$2,$2,6
	sw	$2,4($18)
	lw	$2,8($19)
	lw	$3,24($16)
	#nop
	subu	$2,$2,$3
	div	$2,$2,$4
	sll	$2,$2,6
	.set	noreorder
	.set	nomacro
	j	$L812
	sw	$2,8($18)
	.set	macro
	.set	reorder

$L811:
	sw	$0,0($18)
	sw	$0,4($18)
	sw	$0,8($18)
$L812:
	lw	$2,Object_IMassObjInst
	sll	$3,$20,5
	move	$4,$2
	addu	$2,$3,$2
	addu	$3,$3,$4
	lw	$8,0($19)
	lw	$9,4($19)
	lw	$10,8($19)
	sw	$8,16($2)
	sw	$9,20($2)
	sw	$10,24($2)
	sw	$17,28($3)
	lw	$31,44($sp)
	lw	$20,40($sp)
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

	.end	Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
	.text
	.ent	Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei
Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.end	Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei
	.text
	.ent	__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,24($sp)
	move	$16,$4
	lui	$2,%hi(ObjectMultiAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectMultiAnim_vtable) # low
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$2,0($16)
	lw	$2,0($5)
	#nop
	sra	$2,$2,6
	sw	$2,4($16)
	lw	$2,4($5)
	#nop
	sra	$2,$2,6
	sw	$2,8($16)
	lw	$2,8($5)
	sw	$6,28($16)
	lw	$3,56($sp)
	lw	$4,60($sp)
	move	$17,$7
	sw	$17,20($16)
	sra	$2,$2,6
	sw	$3,24($16)
	sw	$4,16($16)
	sw	$2,12($16)
	lbu	$2,2($17)
	li	$3,6			# 0x00000006
	bne	$2,$3,$L815
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$5,gPersistObjInst
	lw	$2,28($16)
	lbu	$7,13($17)
	j	$L818
$L815:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$5,gPersistObjInst
	lw	$2,28($16)
	lbu	$7,35($17)
$L818:
	lw	$2,4($2)
	li	$6,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	__10AnimScriptP5Groupiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	sw	$2,40($16)
	lw	$4,40($16)
	.set	noreorder
	.set	nomacro
	jal	SetAnimAttrib__10AnimScripti
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,64($sp)
	move	$2,$16
	sw	$3,44($2)
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim
	.text
	.ent	Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei
Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei:
	.frame	$sp,208,$31		# vars= 136, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$21,188($sp)
	move	$21,$4
	sw	$fp,200($sp)
	move	$fp,$5
	move	$5,$0
	sw	$6,216($sp)
	addu	$6,$sp,72
	sw	$31,204($sp)
	sw	$23,196($sp)
	sw	$22,192($sp)
	sw	$20,184($sp)
	sw	$19,180($sp)
	sw	$18,176($sp)
	sw	$17,172($sp)
	sw	$16,168($sp)
	sw	$7,220($sp)
	lw	$4,40($21)
	.set	noreorder
	.set	nomacro
	jal	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	addu	$2,$2,1
	sltu	$2,$2,2
	beq	$2,$0,$L820
	lw	$2,16($21)
	lw	$16,44($21)
	lh	$3,14($2)
	lui	$2,%hi(gSimObjAnims) # high
	addiu	$2,$2,%lo(gSimObjAnims) # low
	sw	$0,44($21)
	sll	$3,$3,2
	addu	$17,$3,$2
	lw	$3,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L821
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L821:
	lw	$6,216($sp)
	move	$5,$fp
	sw	$16,0($17)
	lw	$2,0($16)
	lw	$7,220($sp)
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	j	$L838
$L820:
	lw	$4,40($21)
	#nop
	lw	$2,16($4)
	#nop
	lw	$2,0($2)
	#nop
	lh	$3,10($2)
	lh	$2,8($2)
	#nop
	mult	$3,$2
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,0($4)
	#nop
	subu	$4,$3,$2
	lw	$2,28($21)
	#nop
	lw	$23,4($2)
	mflo	$8
	#nop
	#nop
	sra	$5,$8,1
	slt	$3,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L823
	move	$22,$0
	.set	macro
	.set	reorder

	move	$4,$5
$L823:
	lw	$2,4($21)
	#nop
	mult	$2,$4
	mflo	$8
	#nop
	#nop
	sw	$8,104($sp)
	lw	$2,8($21)
	#nop
	mult	$2,$4
	mflo	$8
	#nop
	#nop
	sw	$8,108($sp)
	lw	$2,12($21)
	#nop
	mult	$2,$4
	mflo	$8
	#nop
	#nop
	sw	$8,112($sp)
	lw	$6,20($21)
	#nop
	lbu	$3,2($6)
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L824
	addu	$4,$sp,160
	.set	macro
	.set	reorder

	lwl	$9,23($6)
	lwr	$9,20($6)
	lwl	$10,27($6)
	lwr	$10,24($6)
	swl	$9,163($sp)
	swr	$9,160($sp)
	swl	$10,167($sp)
	swr	$10,164($sp)
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	addu	$5,$sp,120
	.set	macro
	.set	reorder

	lw	$2,20($21)
	lw	$4,120($sp)
	lh	$16,28($2)
	lh	$17,30($2)
	lh	$18,32($2)
	sll	$16,$16,8
	move	$5,$16
	sll	$17,$17,8
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$18,$18,8
	.set	macro
	.set	reorder

	move	$20,$2
	lw	$4,132($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,144($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,124($sp)
	move	$5,$17
	#.set	volatile
	sw	$20,120($sp)
	#.set	novolatile
	#.set	volatile
	sw	$19,132($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,144($sp)
	.set	macro
	.set	reorder

	move	$20,$2
	lw	$4,136($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,148($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$4,128($sp)
	move	$5,$18
	#.set	volatile
	sw	$20,124($sp)
	#.set	novolatile
	#.set	volatile
	sw	$19,136($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,148($sp)
	.set	macro
	.set	reorder

	move	$20,$2
	lw	$4,140($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	move	$19,$2
	lw	$4,152($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$18
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$20,128($sp)
	#.set	novolatile
	#.set	volatile
	sw	$19,140($sp)
	#.set	novolatile
	sw	$2,152($sp)
$L824:
	lw	$2,gPersistObjInst
	#nop
	addu	$16,$2,4
	slt	$2,$22,$23
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L826
	li	$17,6			# 0x00000006
	.set	macro
	.set	reorder

	li	$19,8			# 0x00000008
	li	$18,5			# 0x00000005
	move	$5,$22
$L840:
	addu	$6,$sp,72
	lw	$4,40($21)
	.set	noreorder
	.set	nomacro
	jal	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	lw	$2,20($21)
	#nop
	lbu	$2,2($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$17,$L828
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	addu	$5,$sp,120
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$4
	.set	macro
	.set	reorder

$L828:
	lw	$2,16($21)
	#nop
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	sw	$9,88($sp)
	sw	$10,92($sp)
	sw	$11,96($sp)
	lw	$4,72($sp)
	lw	$2,104($sp)
	lw	$3,92($sp)
	lw	$5,76($sp)
	addu	$4,$4,$2
	lw	$2,88($sp)
	addu	$3,$3,$5
	sw	$3,92($sp)
	lw	$3,80($sp)
	addu	$2,$2,$4
	lw	$4,112($sp)
	sw	$2,88($sp)
	lw	$2,96($sp)
	addu	$3,$3,$4
	addu	$2,$2,$3
	sw	$2,96($sp)
$L831:
	lbu	$2,2($16)
	#nop
	bne	$2,$19,$L832
	lw	$5,20($21)
	#nop
	lbu	$4,2($5)
	#nop
	bne	$4,$18,$L834
	lbu	$3,13($16)
	lbu	$2,35($5)
	#nop
	bne	$3,$2,$L832
$L834:
	.set	noreorder
	.set	nomacro
	bne	$4,$17,$L830
	move	$4,$fp
	.set	macro
	.set	reorder

	lbu	$3,13($16)
	lbu	$2,13($5)
	#nop
	beq	$3,$2,$L839
$L832:
	lh	$2,0($16)
	.set	noreorder
	.set	nomacro
	j	$L831
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L830:
$L839:
	addu	$6,$sp,32
	lw	$5,216($sp)
	lh	$2,6($16)
	lw	$3,Track_gObjDefs
	lw	$9,220($sp)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$7,0($2)
	addu	$2,$sp,88
	sw	$2,16($sp)
	li	$2,-1			# 0xffffffff
	sw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lh	$2,0($16)
	addu	$22,$22,1
	addu	$16,$16,$2
	slt	$2,$22,$23
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L840
	move	$5,$22
	.set	macro
	.set	reorder

$L826:
	li	$2,4			# 0x00000004
$L838:
	lw	$31,204($sp)
	lw	$fp,200($sp)
	lw	$23,196($sp)
	lw	$22,192($sp)
	lw	$21,188($sp)
	lw	$20,184($sp)
	lw	$19,180($sp)
	lw	$18,176($sp)
	lw	$17,172($sp)
	lw	$16,168($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei
	.text
	.ent	Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei
Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$8,$4
	li	$2,-1			# 0xffffffff
	move	$4,$5
	sw	$31,32($sp)
	lw	$3,44($8)
	move	$5,$6
	sw	$7,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,8
	sw	$3,16($sp)
	lw	$7,40($8)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	addu	$6,$8,4
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei
	.text
	.ent	__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim:
	.frame	$sp,216,$31		# vars= 160, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,216
	sw	$21,196($sp)
	move	$21,$4
	lui	$2,%hi(ObjectSignAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectSignAnim_vtable) # low
	sw	$31,208($sp)
	sw	$23,204($sp)
	sw	$22,200($sp)
	sw	$20,192($sp)
	sw	$19,188($sp)
	sw	$18,184($sp)
	sw	$17,180($sp)
	sw	$16,176($sp)
	sw	$2,0($21)
	lw	$16,0($5)
	lw	$2,8($5)
	sll	$6,$6,8
	lw	$8,0($5)
	lw	$9,4($5)
	lw	$10,8($5)
	sw	$8,4($21)
	sw	$9,8($21)
	sw	$10,12($21)
	sw	$6,36($21)
	sw	$7,28($21)
	lw	$23,232($sp)
	lw	$22,236($sp)
	lw	$3,240($sp)
	addu	$4,$22,4
	bgez	$16,1f
	subu	$16,$0,$16
1:
	bgez	$2,1f
	subu	$2,$0,$2
1:
	addu	$16,$16,$2
	sw	$23,20($21)
	sw	$22,24($21)
	sw	$3,16($21)
	lw	$20,248($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcObjYawAngle__FP8CCOORD16
	sra	$16,$16,16
	.set	macro
	.set	reorder

	sll	$2,$2,8
	slt	$16,$16,10
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L843
	sw	$2,32($21)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$3,28($21)
	#nop
	lw	$5,12($3)
	lw	$6,4($3)
	.set	noreorder
	.set	nomacro
	j	$L846
	move	$4,$2
	.set	macro
	.set	reorder

$L843:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$3,28($21)
	move	$4,$2
	lw	$5,12($3)
	lw	$6,4($3)
	addu	$5,$5,1
$L846:
	.set	noreorder
	.set	nomacro
	jal	__10AnimScriptii
	addu	$18,$20,28
	.set	macro
	.set	reorder

	sw	$2,40($21)
	lw	$4,40($21)
	.set	noreorder
	.set	nomacro
	jal	SetAnimAttrib__10AnimScripti
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	sw	$20,44($21)
	lw	$2,244($sp)
	addu	$17,$20,16
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,16($20)
	sw	$9,20($20)
	sw	$10,24($20)
	move	$2,$5
	sw	$0,28($20)
	sw	$0,4($18)
	sw	$2,8($18)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$19,$20,4
	.set	macro
	.set	reorder

	lw	$4,8($17)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,4($20)
	lw	$4,8($17)
	lw	$5,28($20)
	jal	fixedmult
	lw	$4,16($20)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,4($19)
	lw	$4,16($20)
	lw	$5,4($18)
	jal	fixedmult
	lw	$4,4($17)
	lw	$5,28($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,4($19)
	subu	$16,$16,$2
	sw	$16,8($19)
	lw	$5,8($17)
	jal	fixedmult
	lw	$4,8($19)
	lw	$5,4($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,28($20)
	lw	$4,8($19)
	lw	$5,16($20)
	jal	fixedmult
	lw	$4,4($20)
	lw	$5,8($17)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,4($18)
	lw	$4,4($20)
	lw	$5,4($17)
	jal	fixedmult
	lw	$4,4($19)
	lw	$5,16($20)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$19
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	reorthogonalize
	sw	$16,8($18)
	.set	macro
	.set	reorder

	addu	$17,$sp,136
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedxformx
	li	$5,16384			# 0x00004000
	.set	macro
	.set	reorder

	addu	$16,$sp,56
	lw	$5,32($21)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	subu	$5,$0,$5
	.set	macro
	.set	reorder

	lw	$5,36($21)
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	addu	$16,$sp,96
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$19
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	move	$6,$5
	.set	macro
	.set	reorder

	move	$2,$21
	sw	$22,40($20)
	sw	$23,44($20)
	lw	$31,208($sp)
	lw	$23,204($sp)
	lw	$22,200($sp)
	lw	$21,196($sp)
	lw	$20,192($sp)
	lw	$19,188($sp)
	lw	$18,184($sp)
	lw	$17,180($sp)
	lw	$16,176($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,216
	.set	macro
	.set	reorder

	.end	__14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
	.text
	.ent	Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei
Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei:
	.frame	$sp,136,$31		# vars= 80, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$17,116($sp)
	move	$17,$4
	sw	$18,120($sp)
	move	$18,$5
	sw	$19,124($sp)
	move	$19,$6
	sw	$20,128($sp)
	move	$20,$7
	move	$5,$0
	sw	$16,112($sp)
	addu	$16,$sp,72
	move	$6,$16
	sw	$31,132($sp)
	lw	$4,40($17)
	.set	noreorder
	.set	nomacro
	jal	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	addu	$2,$2,1
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L848
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,16($17)
	lw	$16,44($17)
	lh	$3,14($2)
	lui	$2,%hi(gSimObjAnims) # high
	addiu	$2,$2,%lo(gSimObjAnims) # low
	sw	$0,44($17)
	sll	$3,$3,2
	addu	$17,$3,$2
	lw	$3,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L849
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L849:
	move	$5,$18
	move	$6,$19
	sw	$16,0($17)
	lw	$2,0($16)
	move	$7,$20
	lh	$4,16($2)
	lw	$2,20($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	j	$L850
$L848:
	move	$6,$16
	lw	$4,40($17)
	lw	$16,24($17)
	.set	noreorder
	.set	nomacro
	jal	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	addu	$5,$sp,104
	lw	$4,40($17)
	.set	noreorder
	.set	nomacro
	jal	GetAnimFrameInfo__10AnimScriptPiT1
	addu	$6,$sp,108
	.set	macro
	.set	reorder

	lw	$4,104($sp)
	lw	$2,108($sp)
	sll	$4,$4,16
	div	$4,$4,$2
	lw	$2,20($17)
	#nop
	lw	$8,8($2)
	lw	$9,12($2)
	lw	$10,16($2)
	sw	$8,88($sp)
	sw	$9,92($sp)
	sw	$10,96($sp)
	lw	$2,88($sp)
	lw	$3,72($sp)
	lw	$5,76($sp)
	lw	$6,80($sp)
	addu	$2,$2,$3
	sw	$2,88($sp)
	lw	$2,92($sp)
	lw	$3,96($sp)
	addu	$2,$2,$5
	addu	$3,$3,$6
	sw	$2,92($sp)
	sw	$3,96($sp)
	lw	$5,32($17)
	lw	$6,36($17)
	.set	noreorder
	.set	nomacro
	jal	BuildObjCollisionMatrix__FiiiP10matrixtdef
	addu	$7,$sp,32
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$19
	addu	$6,$sp,32
	move	$7,$16
	addu	$2,$sp,88
	sw	$2,16($sp)
	li	$2,-1			# 0xffffffff
	sw	$20,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
$L850:
	lw	$31,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei
	.text
	.ent	___14ObjectSignAnim
___14ObjectSignAnim:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	lui	$2,%hi(ObjectSignAnim_vtable) # high
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$16,40($17)
	addiu	$2,$2,%lo(ObjectSignAnim_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L852
	sw	$2,0($17)
	.set	macro
	.set	reorder

	lw	$4,16($16)
	#nop
	beq	$4,$0,$L853
	jal	__builtin_vec_delete
$L853:
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$16
	.set	macro
	.set	reorder

$L852:
	lw	$3,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L854
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L854:
	lui	$2,%hi(ObjectAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectAnim_vtable) # low
	sw	$2,0($17)
	andi	$2,$18,0x0001
	beq	$2,$0,$L851
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L851:
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

	.end	___14ObjectSignAnim
	.text
	.ent	___22ObjectFinishedSignAnim
___22ObjectFinishedSignAnim:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(ObjectAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectAnim_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L856
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L856:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___22ObjectFinishedSignAnim
	.text
	.ent	___15ObjectMultiAnim
___15ObjectMultiAnim:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	lui	$2,%hi(ObjectMultiAnim_vtable) # high
	sw	$31,28($sp)
	sw	$16,16($sp)
	lw	$16,40($17)
	addiu	$2,$2,%lo(ObjectMultiAnim_vtable) # low
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L859
	sw	$2,0($17)
	.set	macro
	.set	reorder

	lw	$4,16($16)
	#nop
	beq	$4,$0,$L860
	jal	__builtin_vec_delete
$L860:
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$16
	.set	macro
	.set	reorder

$L859:
	lw	$3,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L861
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	lh	$4,8($2)
	lw	$2,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

$L861:
	lui	$2,%hi(ObjectAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectAnim_vtable) # low
	sw	$2,0($17)
	andi	$2,$18,0x0001
	beq	$2,$0,$L858
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$17
	.set	macro
	.set	reorder

$L858:
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

	.end	___15ObjectMultiAnim
	.text
	.ent	___23ObjectFinishedMultiAnim
___23ObjectFinishedMultiAnim:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(ObjectAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectAnim_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L863
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L863:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___23ObjectFinishedMultiAnim
	.text
	.ent	_._10ObjectAnim
_._10ObjectAnim:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(ObjectAnim_vtable) # high
	addiu	$2,$2,%lo(ObjectAnim_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L868
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L868:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._10ObjectAnim
