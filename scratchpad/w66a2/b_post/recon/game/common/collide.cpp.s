	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\collide.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	Collide_gRaiseUp
	.sdata
	.align	2
Collide_gRaiseUp:
	.word	1
	.text
	.align	2
	.globl	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	.align	2
	.globl	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	.align	2
	.globl	CHECK_VERTEX_WITH_DIRS__Fiii
	.align	2
	.globl	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	.align	2
	.globl	Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
	.align	2
	.globl	Collide_LimitAngularVel__FP13BO_tNewtonObj
	.align	2
	.globl	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
	.align	2
	.globl	Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
	.align	2
	.globl	Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
	.align	2
	.globl	Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
	.align	2
	.globl	Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
	.align	2
	.globl	Collide_ClearCollisionRegistry__Fv
	.align	2
	.globl	Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
	.align	2
	.globl	Collide_CheckMeForCollisions__FP13BO_tNewtonObj
	.globl	Collide_gRegistry
	.data
	.align	2
Collide_gRegistry:
	.space	64
	.globl	frictionLess
	.sdata
	.align	2
frictionLess:
	.space	4
	.globl	Collide_gNumRegistered
	.align	2
Collide_gNumRegistered:
	.space	4
	.globl	findClosestSideDave
	.align	2
findClosestSideDave:
	.space	4
	.globl	obj0
	.align	2
obj0:
	.space	4
	.globl	obj1
	.align	2
obj1:
	.space	4
	.globl	pNormal
	.align	2
pNormal:
	.space	4
	.globl	pP
	.align	2
pP:
	.space	4
	.globl	xRange
	.align	2
xRange:
	.space	4
	.globl	yRange
	.align	2
yRange:
	.space	4
	.globl	zRange
	.align	2
zRange:
	.space	4
	.globl	basisDots
	.data
	.align	2
basisDots:
	.space	36
	.globl	scaledBasisDots
	.align	2
scaledBasisDots:
	.space	36
	.globl	scaledBasisDotsOther
	.align	2
scaledBasisDotsOther:
	.space	36
	.globl	basisDotRelative
	.align	2
basisDotRelative:
	.space	24

	.extern	Cars_gNumCars, 4
	.extern	BWorldSm_slices, 4
	.extern	InfiniteMassNewton, 2880
	.extern	D_80055A00, 12

	.text
	.text
	.ent	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
CHECK_CENTER_VERTEX_WITH_DIRS__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(scaledBasisDots) # high
	lw	$2,%lo(scaledBasisDots)($3)
	move	$13,$4
	mult	$13,$2
	addiu	$3,$3,%lo(scaledBasisDots) # low
	mflo	$4
	#nop
	lw	$2,4($3)
	#nop
	mult	$5,$2
	mflo	$15
	#nop
	lw	$2,8($3)
	#nop
	mult	$6,$2
	mflo	$8
	#nop
	lw	$2,12($3)
	#nop
	mult	$13,$2
	mflo	$12
	#nop
	lw	$2,16($3)
	#nop
	mult	$5,$2
	mflo	$9
	#nop
	lw	$2,20($3)
	#nop
	mult	$6,$2
	mflo	$10
	#nop
	lw	$2,24($3)
	#nop
	mult	$13,$2
	mflo	$11
	#nop
	lw	$2,28($3)
	#nop
	mult	$5,$2
	lw	$3,32($3)
	addu	$2,$4,$15
	mflo	$7
	#nop
	lui	$4,%hi(basisDotRelative) # high
	addu	$2,$2,$8
	mult	$6,$3
	lw	$3,%lo(basisDotRelative)($4)
	addiu	$4,$4,%lo(basisDotRelative) # low
	addu	$8,$2,$3
	addu	$2,$12,$9
	lw	$3,4($4)
	addu	$2,$2,$10
	addu	$9,$2,$3
	addu	$2,$11,$7
	lw	$7,obj0
	lw	$3,8($4)
	sw	$8,xRange
	sw	$9,yRange
	lw	$4,316($7)
	mflo	$15
	#nop
	#nop
	addu	$2,$2,$15
	addu	$3,$2,$3
	slt	$2,$4,$3
	sw	$3,zRange
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	bne	$2,$0,$L602
	lw	$3,308($7)
	#nop
	slt	$2,$3,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$8,$2
	bne	$2,$0,$L602
	lw	$3,312($7)
	#nop
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$9,$2
	bne	$2,$0,$L602
	lw	$4,obj1
	#nop
	lw	$2,240($4)
	#nop
	mult	$13,$2
	mflo	$3
	#nop
	lw	$2,252($4)
	#nop
	mult	$5,$2
	mflo	$8
	#nop
	lw	$2,264($4)
	#nop
	mult	$6,$2
	addu	$2,$3,$8
	lw	$3,pNormal
	mflo	$7
	#nop
	#nop
	addu	$2,$2,$7
	sw	$2,0($3)
	lw	$2,244($4)
	#nop
	mult	$13,$2
	mflo	$8
	#nop
	lw	$2,256($4)
	#nop
	mult	$5,$2
	mflo	$7
	#nop
	lw	$2,268($4)
	#nop
	mult	$6,$2
	addu	$2,$8,$7
	mflo	$9
	#nop
	#nop
	addu	$2,$2,$9
	sw	$2,4($3)
	lw	$2,248($4)
	#nop
	mult	$13,$2
	mflo	$8
	#nop
	lw	$2,260($4)
	#nop
	mult	$5,$2
	mflo	$7
	#nop
	lw	$2,272($4)
	#nop
	mult	$6,$2
	addu	$2,$8,$7
	mflo	$9
	#nop
	#nop
	addu	$2,$2,$9
	sw	$2,8($3)
	lw	$3,240($4)
	lw	$9,pP
	bgez	$3,$L608
	addu	$3,$3,255
$L608:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L609
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L609:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,160($4)
	lw	$3,252($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L610
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L610:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L611
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L611:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$3,264($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L612
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L612:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L613
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L613:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$7,$14
	sw	$2,0($9)
	lw	$3,244($4)
	#nop
	bgez	$3,$L614
	addu	$3,$3,255
$L614:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L615
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L615:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,164($4)
	lw	$3,256($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L616
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L616:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L617
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L617:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$8,obj1
	#nop
	lw	$3,268($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L618
	addu	$4,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L618:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L619
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L619:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$4,$14
	sw	$2,4($9)
	lw	$3,248($8)
	lw	$4,pP
	bgez	$3,$L620
	addu	$3,$3,255
$L620:
	lw	$2,308($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L621
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L621:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,168($8)
	lw	$7,260($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L622
	addu	$3,$2,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L622:
	lw	$2,312($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L623
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L623:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$7,272($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L624
	addu	$3,$3,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L624:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L625
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L625:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	li	$2,1			# 0x00000001
	mflo	$14
	#nop
	#nop
	addu	$3,$3,$14
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($4)
	.set	macro
	.set	reorder

$L602:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	.text
	.ent	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(scaledBasisDotsOther) # high
	lw	$2,%lo(scaledBasisDotsOther)($3)
	move	$13,$4
	mult	$13,$2
	addiu	$3,$3,%lo(scaledBasisDotsOther) # low
	mflo	$4
	#nop
	lw	$2,12($3)
	#nop
	mult	$5,$2
	mflo	$15
	#nop
	lw	$2,24($3)
	#nop
	mult	$6,$2
	mflo	$8
	#nop
	lw	$2,4($3)
	#nop
	mult	$13,$2
	mflo	$12
	#nop
	lw	$2,16($3)
	#nop
	mult	$5,$2
	mflo	$9
	#nop
	lw	$2,28($3)
	#nop
	mult	$6,$2
	mflo	$10
	#nop
	lw	$2,8($3)
	#nop
	mult	$13,$2
	mflo	$11
	#nop
	lw	$2,20($3)
	#nop
	mult	$5,$2
	lw	$3,32($3)
	addu	$2,$4,$15
	mflo	$7
	#nop
	lui	$4,%hi(basisDotRelative) # high
	addiu	$4,$4,%lo(basisDotRelative) # low
	mult	$6,$3
	lw	$3,12($4)
	addu	$2,$2,$8
	subu	$8,$2,$3
	addu	$2,$12,$9
	lw	$3,16($4)
	addu	$2,$2,$10
	subu	$9,$2,$3
	addu	$2,$11,$7
	lw	$7,obj1
	lw	$3,20($4)
	sw	$8,xRange
	sw	$9,yRange
	lw	$4,316($7)
	mflo	$15
	#nop
	#nop
	addu	$2,$2,$15
	subu	$3,$2,$3
	slt	$2,$4,$3
	sw	$3,zRange
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	bne	$2,$0,$L630
	lw	$3,308($7)
	#nop
	slt	$2,$3,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$8,$2
	bne	$2,$0,$L630
	lw	$3,312($7)
	#nop
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$9,$2
	bne	$2,$0,$L630
	lw	$4,obj0
	#nop
	lw	$2,240($4)
	#nop
	mult	$13,$2
	mflo	$7
	#nop
	lw	$2,252($4)
	#nop
	mult	$5,$2
	mflo	$3
	#nop
	lw	$2,264($4)
	#nop
	mult	$6,$2
	addu	$2,$7,$3
	lw	$3,pNormal
	mflo	$8
	#nop
	#nop
	addu	$2,$2,$8
	subu	$2,$0,$2
	sw	$2,0($3)
	lw	$2,244($4)
	#nop
	mult	$13,$2
	mflo	$8
	#nop
	lw	$2,256($4)
	#nop
	mult	$5,$2
	mflo	$7
	#nop
	lw	$2,268($4)
	#nop
	mult	$6,$2
	addu	$2,$8,$7
	mflo	$9
	#nop
	#nop
	addu	$2,$2,$9
	subu	$2,$0,$2
	sw	$2,4($3)
	lw	$2,248($4)
	#nop
	mult	$13,$2
	mflo	$8
	#nop
	lw	$2,260($4)
	#nop
	mult	$5,$2
	mflo	$7
	#nop
	lw	$2,272($4)
	#nop
	mult	$6,$2
	addu	$2,$8,$7
	mflo	$9
	#nop
	#nop
	addu	$2,$2,$9
	subu	$2,$0,$2
	sw	$2,8($3)
	lw	$3,240($4)
	lw	$9,pP
	bgez	$3,$L636
	addu	$3,$3,255
$L636:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L637
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L637:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,160($4)
	lw	$3,252($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L638
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L638:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L639
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L639:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$3,264($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L640
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L640:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L641
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L641:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$7,$14
	sw	$2,0($9)
	lw	$3,244($4)
	#nop
	bgez	$3,$L642
	addu	$3,$3,255
$L642:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L643
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L643:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,164($4)
	lw	$3,256($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L644
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L644:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L645
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L645:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$8,obj0
	#nop
	lw	$3,268($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L646
	addu	$4,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L646:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L647
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L647:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$4,$14
	sw	$2,4($9)
	lw	$3,248($8)
	lw	$4,pP
	bgez	$3,$L648
	addu	$3,$3,255
$L648:
	lw	$2,308($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L649
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L649:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,168($8)
	lw	$7,260($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L650
	addu	$3,$2,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L650:
	lw	$2,312($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L651
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L651:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$7,272($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L652
	addu	$3,$3,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L652:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L653
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L653:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	li	$2,1			# 0x00000001
	mflo	$14
	#nop
	#nop
	addu	$3,$3,$14
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($4)
	.set	macro
	.set	reorder

$L630:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	.text
	.ent	CHECK_VERTEX_WITH_DIRS__Fiii
CHECK_VERTEX_WITH_DIRS__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(scaledBasisDots) # high
	lw	$2,%lo(scaledBasisDots)($3)
	move	$13,$4
	mult	$13,$2
	addiu	$3,$3,%lo(scaledBasisDots) # low
	mflo	$4
	#nop
	lw	$2,4($3)
	#nop
	mult	$5,$2
	mflo	$15
	#nop
	lw	$2,8($3)
	#nop
	mult	$6,$2
	mflo	$8
	#nop
	lw	$2,12($3)
	#nop
	mult	$13,$2
	mflo	$12
	#nop
	lw	$2,16($3)
	#nop
	mult	$5,$2
	mflo	$9
	#nop
	lw	$2,20($3)
	#nop
	mult	$6,$2
	mflo	$10
	#nop
	lw	$2,24($3)
	#nop
	mult	$13,$2
	mflo	$11
	#nop
	lw	$2,28($3)
	#nop
	mult	$5,$2
	lw	$3,32($3)
	addu	$2,$4,$15
	mflo	$7
	#nop
	lui	$4,%hi(basisDotRelative) # high
	addu	$2,$2,$8
	mult	$6,$3
	lw	$3,%lo(basisDotRelative)($4)
	addiu	$4,$4,%lo(basisDotRelative) # low
	addu	$8,$2,$3
	addu	$2,$12,$9
	lw	$3,4($4)
	addu	$2,$2,$10
	addu	$9,$2,$3
	addu	$2,$11,$7
	lw	$7,obj0
	lw	$3,8($4)
	sw	$8,xRange
	sw	$9,yRange
	lw	$4,316($7)
	mflo	$15
	#nop
	#nop
	addu	$2,$2,$15
	addu	$3,$2,$3
	slt	$2,$4,$3
	sw	$3,zRange
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	bne	$2,$0,$L658
	lw	$3,308($7)
	#nop
	slt	$2,$3,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$8,$2
	bne	$2,$0,$L658
	lw	$3,312($7)
	#nop
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$9,$2
	bne	$2,$0,$L658
	lw	$4,obj1
	#nop
	lw	$3,240($4)
	lw	$9,pP
	bgez	$3,$L664
	addu	$3,$3,255
$L664:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L665
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L665:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,160($4)
	lw	$3,252($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L666
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L666:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L667
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L667:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$3,264($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L668
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L668:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L669
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L669:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$7,$14
	sw	$2,0($9)
	lw	$3,244($4)
	#nop
	bgez	$3,$L670
	addu	$3,$3,255
$L670:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L671
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L671:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,164($4)
	lw	$3,256($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L672
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L672:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L673
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L673:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$8,obj1
	#nop
	lw	$3,268($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L674
	addu	$4,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L674:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L675
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L675:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$4,$14
	sw	$2,4($9)
	lw	$3,248($8)
	lw	$4,pP
	bgez	$3,$L676
	addu	$3,$3,255
$L676:
	lw	$2,308($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L677
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L677:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,168($8)
	lw	$7,260($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L678
	addu	$3,$2,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L678:
	lw	$2,312($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L679
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L679:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$7,272($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L680
	addu	$3,$3,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L680:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L681
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L681:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	li	$2,1			# 0x00000001
	mflo	$14
	#nop
	#nop
	addu	$3,$3,$14
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($4)
	.set	macro
	.set	reorder

$L658:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CHECK_VERTEX_WITH_DIRS__Fiii
	.text
	.ent	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
CHECK_VERTEX_WITH_DIRS_OTHER__Fiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(scaledBasisDotsOther) # high
	lw	$2,%lo(scaledBasisDotsOther)($3)
	move	$13,$4
	mult	$13,$2
	addiu	$3,$3,%lo(scaledBasisDotsOther) # low
	mflo	$4
	#nop
	lw	$2,12($3)
	#nop
	mult	$5,$2
	mflo	$15
	#nop
	lw	$2,24($3)
	#nop
	mult	$6,$2
	mflo	$8
	#nop
	lw	$2,4($3)
	#nop
	mult	$13,$2
	mflo	$12
	#nop
	lw	$2,16($3)
	#nop
	mult	$5,$2
	mflo	$9
	#nop
	lw	$2,28($3)
	#nop
	mult	$6,$2
	mflo	$10
	#nop
	lw	$2,8($3)
	#nop
	mult	$13,$2
	mflo	$11
	#nop
	lw	$2,20($3)
	#nop
	mult	$5,$2
	lw	$3,32($3)
	addu	$2,$4,$15
	mflo	$7
	#nop
	lui	$4,%hi(basisDotRelative) # high
	addiu	$4,$4,%lo(basisDotRelative) # low
	mult	$6,$3
	lw	$3,12($4)
	addu	$2,$2,$8
	subu	$8,$2,$3
	addu	$2,$12,$9
	lw	$3,16($4)
	addu	$2,$2,$10
	subu	$9,$2,$3
	addu	$2,$11,$7
	lw	$7,obj1
	lw	$3,20($4)
	sw	$8,xRange
	sw	$9,yRange
	lw	$4,316($7)
	mflo	$15
	#nop
	#nop
	addu	$2,$2,$15
	subu	$3,$2,$3
	slt	$2,$4,$3
	sw	$3,zRange
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L686
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	slt	$2,$3,$2
	bne	$2,$0,$L686
	lw	$3,308($7)
	#nop
	slt	$2,$3,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L686
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$8,$2
	bne	$2,$0,$L686
	lw	$3,312($7)
	#nop
	slt	$2,$3,$9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L686
	subu	$2,$0,$3
	.set	macro
	.set	reorder

	slt	$2,$9,$2
	bne	$2,$0,$L686
	lw	$4,obj0
	#nop
	lw	$3,240($4)
	lw	$9,pP
	bgez	$3,$L692
	addu	$3,$3,255
$L692:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L693
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L693:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,160($4)
	lw	$3,252($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L694
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L694:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L695
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L695:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$3,264($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L696
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L696:
	lw	$2,316($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L697
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L697:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$7,$14
	sw	$2,0($9)
	lw	$3,244($4)
	#nop
	bgez	$3,$L698
	addu	$3,$3,255
$L698:
	lw	$2,308($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L699
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L699:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,164($4)
	lw	$3,256($4)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L700
	addu	$7,$2,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L700:
	lw	$2,312($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L701
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L701:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$8,obj0
	#nop
	lw	$3,268($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L702
	addu	$4,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L702:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L703
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L703:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	mflo	$14
	#nop
	#nop
	addu	$2,$4,$14
	sw	$2,4($9)
	lw	$3,248($8)
	lw	$4,pP
	bgez	$3,$L704
	addu	$3,$3,255
$L704:
	lw	$2,308($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L705
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L705:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$14
	#nop
	#nop
	mult	$13,$14
	lw	$2,168($8)
	lw	$7,260($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L706
	addu	$3,$2,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L706:
	lw	$2,312($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L707
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L707:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$5,$14
	lw	$7,272($8)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L708
	addu	$3,$3,$14
	.set	macro
	.set	reorder

	addu	$7,$7,255
$L708:
	lw	$2,316($8)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L709
	sra	$7,$7,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L709:
	sra	$2,$2,8
	mult	$7,$2
	mflo	$14
	#nop
	#nop
	mult	$6,$14
	li	$2,1			# 0x00000001
	mflo	$14
	#nop
	#nop
	addu	$3,$3,$14
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,8($4)
	.set	macro
	.set	reorder

$L686:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	.text
	.ent	Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21:
	.frame	$sp,192,$31		# vars= 144, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,192
	sw	$18,168($sp)
	move	$18,$4
	sw	$19,172($sp)
	move	$19,$5
	sw	$31,184($sp)
	sw	$21,180($sp)
	sw	$20,176($sp)
	sw	$17,164($sp)
	sw	$16,160($sp)
	lw	$14,0($6)
	lw	$15,4($6)
	lw	$24,8($6)
	sw	$14,96($sp)
	sw	$15,100($sp)
	sw	$24,104($sp)
	lw	$14,0($7)
	lw	$15,4($7)
	lw	$24,8($7)
	sw	$14,16($sp)
	sw	$15,20($sp)
	sw	$24,24($sp)
	lw	$3,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L713
	move	$21,$0
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L713:
	lw	$2,172($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L714
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L714:
	sra	$2,$2,8
	mult	$4,$2
	lw	$5,20($sp)
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L715
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L715:
	lw	$2,176($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L716
	sra	$10,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L716:
	sra	$2,$2,8
	mult	$10,$2
	lw	$8,24($sp)
	#nop
	move	$2,$8
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$8,$L717
	addu	$7,$4,$14
	.set	macro
	.set	reorder

	addu	$2,$8,255
$L717:
	lw	$3,180($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L718
	sra	$9,$2,8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L718:
	sra	$3,$3,8
	lw	$4,0($19)
	lw	$2,160($18)
	mult	$9,$3
	subu	$6,$4,$2
	sw	$6,64($sp)
	lw	$3,4($19)
	lw	$2,164($18)
	#nop
	subu	$3,$3,$2
	sw	$3,68($sp)
	lw	$4,8($19)
	lw	$2,168($18)
	#nop
	subu	$4,$4,$2
	sw	$4,72($sp)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L719
	addu	$20,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L719:
	sra	$3,$3,8
	mult	$3,$9
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L721
	move	$2,$4
	.set	macro
	.set	reorder

	addu	$2,$4,255
$L721:
	sra	$7,$2,8
	mult	$7,$10
	mflo	$14
	#nop
	#nop
	subu	$3,$3,$14
	sw	$3,80($sp)
	lw	$5,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L724
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L724:
	sra	$10,$2,8
	mult	$7,$10
	mflo	$2
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L725
	move	$4,$6
	.set	macro
	.set	reorder

	addu	$4,$6,255
$L725:
	sra	$7,$4,8
	mult	$7,$9
	mflo	$14
	#nop
	#nop
	subu	$8,$2,$14
	sw	$8,84($sp)
	lw	$2,20($sp)
	#nop
	bgez	$2,$L728
	addu	$2,$2,255
$L728:
	sra	$2,$2,8
	mult	$7,$2
	lw	$4,68($sp)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L841
	sra	$2,$4,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
	sra	$2,$4,8
$L841:
	mult	$2,$10
	mflo	$14
	#nop
	#nop
	subu	$5,$6,$14
	sw	$5,88($sp)
	lw	$4,276($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L842
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L842:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L732
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L732:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,280($18)
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L843
	move	$2,$8
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L843:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L734
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L734:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,284($18)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L735
	addu	$4,$4,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L735:
	move	$2,$5
	.set	noreorder
	.set	nomacro
	bgez	$2,$L736
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L736:
	sra	$2,$2,8
	mult	$3,$2
	lw	$16,188($18)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$16,$L737
	addu	$17,$4,$14
	.set	macro
	.set	reorder

	addu	$16,$16,3
$L737:
	addu	$4,$sp,80
	.set	noreorder
	.set	nomacro
	jal	Math_VectorLength2__FP8coorddef
	sra	$16,$16,2
	.set	macro
	.set	reorder

	lw	$5,292($18)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,1
	.set	macro
	.set	reorder

	addu	$4,$20,$17
	subu	$4,$0,$4
	srl	$5,$2,31
	addu	$5,$5,$2
	sra	$5,$5,1
	.set	noreorder
	.set	nomacro
	jal	rdiv
	addu	$5,$16,$5
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,26214			# 0x00006666
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$20,1f
	move	$3,$20
	subu	$3,$0,$3
1:
	.set	reorder
	sll	$3,$3,2
	sw	$3,400($18)
	lw	$3,448($18)
	li	$4,196608			# 0x00030000
	sw	$0,404($18)
	or	$3,$3,$4
	sw	$3,408($18)
	lw	$15,0($19)
	lw	$24,4($19)
	lw	$25,8($19)
	sw	$15,416($18)
	sw	$24,420($18)
	sw	$25,424($18)
	lw	$3,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L739
	move	$19,$2
	.set	macro
	.set	reorder

	lw	$2,100($sp)
	#nop
	bne	$2,$0,$L739
	lw	$2,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L844
	li	$3,589824			# 0x00090000
	.set	macro
	.set	reorder

$L739:
	lw	$10,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$10,$L740
	move	$2,$10
	.set	macro
	.set	reorder

	addu	$2,$10,255
$L740:
	lw	$8,16($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$8,$L741
	move	$3,$8
	.set	macro
	.set	reorder

	addu	$3,$8,255
$L741:
	sra	$13,$3,8
	mult	$2,$13
	lw	$9,100($sp)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$9,$L742
	move	$4,$9
	.set	macro
	.set	reorder

	addu	$4,$9,255
$L742:
	lw	$5,20($sp)
	sra	$3,$4,8
	.set	noreorder
	.set	nomacro
	bgez	$5,$L743
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L743:
	sra	$12,$2,8
	mult	$3,$12
	lw	$7,104($sp)
	#nop
	move	$3,$7
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L744
	addu	$4,$6,$14
	.set	macro
	.set	reorder

	addu	$3,$7,255
$L744:
	lw	$6,24($sp)
	sra	$3,$3,8
	.set	noreorder
	.set	nomacro
	bgez	$6,$L745
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$2,$6,255
$L745:
	sra	$11,$2,8
	mult	$3,$11
	mflo	$14
	#nop
	#nop
	addu	$3,$4,$14
	.set	noreorder
	.set	nomacro
	bgez	$3,$L746
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,255
$L746:
	sra	$4,$2,8
	mult	$4,$13
	mflo	$14
	#nop
	#nop
	subu	$2,$10,$14
	sw	$2,96($sp)
	mult	$4,$12
	mflo	$14
	#nop
	#nop
	subu	$5,$9,$14
	sw	$5,100($sp)
	mult	$4,$11
	move	$3,$2
	mflo	$14
	#nop
	#nop
	subu	$6,$7,$14
	.set	noreorder
	.set	nomacro
	bgez	$2,$L752
	sw	$6,104($sp)
	.set	macro
	.set	reorder

	addu	$3,$2,255
$L752:
	sra	$3,$3,8
	mult	$3,$3
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L754
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L754:
	sra	$2,$2,8
	mult	$2,$2
	move	$2,$6
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L756
	addu	$4,$3,$14
	.set	macro
	.set	reorder

	addu	$2,$6,255
$L756:
	sra	$2,$2,8
	mult	$2,$2
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	addu	$4,$4,$14
	.set	macro
	.set	reorder

	move	$21,$2
	srl	$2,$21,31
	addu	$2,$21,$2
	sra	$5,$2,1
	beq	$5,$0,$L758
	.set	noreorder
	.set	nomacro
	jal	rdiv
	li	$4,32768			# 0x00008000
	.set	macro
	.set	reorder

	subu	$16,$0,$2
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,100($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,96($sp)
	.set	macro
	.set	reorder

	lw	$5,104($sp)
	.set	noreorder
	.set	nomacro
	j	$L840
	move	$4,$16
	.set	macro
	.set	reorder

$L758:
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,-65536			# 0xffff0000
	.set	macro
	.set	reorder

	lw	$5,100($sp)
	li	$4,-65536			# 0xffff0000
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,96($sp)
	.set	macro
	.set	reorder

	lw	$5,104($sp)
	li	$4,-65536			# 0xffff0000
$L840:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,100($sp)
	.set	macro
	.set	reorder

	sw	$2,104($sp)
	li	$3,589824			# 0x00090000
$L844:
	lw	$2,192($18)
	ori	$3,$3,0xffff
	bgez	$2,1f
	subu	$2,$0,$2
1:
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L760
	lui	$2,%hi(D_80055A00) # high
	.set	macro
	.set	reorder

	addiu	$14,$2,%lo(D_80055A00)
	lw	$15,0($14)
	lw	$24,4($14)
	lw	$25,8($14)
	sw	$15,144($sp)
	sw	$24,148($sp)
	sw	$25,152($sp)
	lw	$6,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L761
	move	$3,$6
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L761:
	lw	$2,240($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L762
	sra	$10,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L762:
	sra	$2,$2,8
	mult	$10,$2
	lw	$5,148($sp)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L763
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L763:
	lw	$2,244($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L764
	sra	$9,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L764:
	sra	$2,$2,8
	mult	$9,$2
	lw	$4,152($sp)
	#nop
	move	$3,$4
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L765
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L765:
	lw	$2,248($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L766
	sra	$8,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L766:
	sra	$2,$2,8
	mult	$8,$2
	mflo	$14
	#nop
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L768
	addu	$7,$7,$14
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L768:
	sra	$2,$2,8
	mult	$10,$2
	mflo	$3
	#nop
	lw	$2,256($18)
	#nop
	bgez	$2,$L770
	addu	$2,$2,255
$L770:
	sra	$2,$2,8
	mult	$9,$2
	mflo	$14
	#nop
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L772
	addu	$5,$3,$14
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L772:
	sra	$2,$2,8
	mult	$8,$2
	lw	$3,144($sp)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L773
	addu	$5,$5,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L773:
	lw	$2,264($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L774
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L774:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,148($sp)
	mflo	$4
	#nop
	bgez	$3,$L775
	addu	$3,$3,255
$L775:
	lw	$2,268($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L776
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L776:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,152($sp)
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L777
	addu	$4,$4,$14
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L777:
	lw	$2,272($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L778
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L778:
	sra	$2,$2,8
	mult	$3,$2
	.set	noreorder
	bgez	$7,1f
	move	$2,$7
	subu	$2,$0,$2
1:
	.set	reorder
	mflo	$14
	#nop
	#nop
	addu	$3,$4,$14
	li	$4,62914			# 0x0000f5c2
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L845
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	bgez	$3,1f
	move	$2,$3
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L845
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,-65536			# 0xffff0000
	ori	$2,$2,0x0a3e
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L845:
	sw	$2,frictionLess
$L760:
	lw	$3,frictionLess
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L781
	li	$4,32768			# 0x00008000
	.set	macro
	.set	reorder

	li	$4,655			# 0x0000028f
$L781:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$19
	.set	macro
	.set	reorder

	move	$16,$2
	lw	$5,188($18)
	move	$4,$16
	srl	$2,$5,31
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,1
	.set	macro
	.set	reorder

	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	sw	$2,112($sp)
	lw	$5,188($18)
	move	$4,$16
	srl	$2,$5,31
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,1
	.set	macro
	.set	reorder

	lw	$5,100($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	sw	$2,116($sp)
	lw	$5,188($18)
	move	$4,$16
	srl	$2,$5,31
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,1
	.set	macro
	.set	reorder

	lw	$5,104($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$2
	.set	macro
	.set	reorder

	sw	$2,120($sp)
	lw	$5,292($18)
	move	$4,$16
	sw	$0,frictionLess
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lw	$3,100($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L783
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L783:
	lw	$7,72($sp)
	sra	$2,$3,8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L784
	move	$4,$7
	.set	macro
	.set	reorder

	addu	$4,$7,255
$L784:
	sra	$11,$4,8
	mult	$2,$11
	lw	$3,104($sp)
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L785
	move	$5,$3
	.set	macro
	.set	reorder

	addu	$5,$3,255
$L785:
	lw	$6,68($sp)
	sra	$8,$5,8
	.set	noreorder
	.set	nomacro
	bgez	$6,$L786
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$2,$6,255
$L786:
	sra	$10,$2,8
	mult	$8,$10
	mflo	$14
	#nop
	#nop
	subu	$2,$4,$14
	sw	$2,128($sp)
	lw	$5,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L788
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L788:
	sra	$9,$3,8
	mult	$8,$9
	lw	$2,96($sp)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L789
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$4,$2,255
$L789:
	sra	$3,$4,8
	mult	$3,$11
	mflo	$14
	#nop
	#nop
	subu	$4,$8,$14
	sw	$4,132($sp)
	mult	$3,$10
	lw	$2,100($sp)
	mflo	$3
	#nop
	bgez	$2,$L793
	addu	$2,$2,255
$L793:
	sra	$2,$2,8
	mult	$2,$9
	move	$2,$4
	mflo	$14
	#nop
	#nop
	subu	$3,$3,$14
	.set	noreorder
	.set	nomacro
	bgez	$2,$L795
	sw	$3,136($sp)
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L795:
	lw	$8,72($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$8,$L796
	move	$4,$8
	.set	macro
	.set	reorder

	addu	$4,$8,255
$L796:
	sra	$12,$4,8
	mult	$2,$12
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L797
	move	$5,$3
	.set	macro
	.set	reorder

	addu	$5,$3,255
$L797:
	lw	$7,68($sp)
	sra	$9,$5,8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L798
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$2,$7,255
$L798:
	sra	$11,$2,8
	mult	$9,$11
	mflo	$14
	#nop
	#nop
	subu	$5,$4,$14
	sw	$5,128($sp)
	lw	$6,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$6,$L800
	move	$3,$6
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L800:
	sra	$10,$3,8
	mult	$9,$10
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L801
	move	$4,$5
	.set	macro
	.set	reorder

	addu	$4,$5,255
$L801:
	sra	$2,$4,8
	mult	$2,$12
	mflo	$14
	#nop
	#nop
	subu	$3,$3,$14
	mult	$2,$11
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L805
	sw	$3,132($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L805:
	sra	$2,$3,8
	mult	$2,$10
	move	$4,$17
	mflo	$14
	#nop
	#nop
	subu	$2,$7,$14
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,136($sp)
	.set	macro
	.set	reorder

	lw	$5,132($sp)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,128($sp)
	.set	macro
	.set	reorder

	lw	$5,136($sp)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,132($sp)
	.set	macro
	.set	reorder

	lw	$3,112($sp)
	lw	$4,128($sp)
	lw	$5,120($sp)
	sw	$2,136($sp)
	addu	$3,$3,$4
	move	$6,$3
	lw	$4,116($sp)
	lw	$3,132($sp)
	addu	$5,$5,$2
	sw	$6,112($sp)
	sw	$5,120($sp)
	addu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bgez	$6,$L807
	sw	$4,116($sp)
	.set	macro
	.set	reorder

	addu	$6,$6,255
$L807:
	lw	$2,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L808
	sra	$3,$6,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L808:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$3
	#nop
	bgez	$4,$L809
	addu	$4,$4,255
$L809:
	lw	$2,100($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L810
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L810:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$14
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L811
	addu	$3,$3,$14
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L811:
	lw	$2,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L812
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L812:
	sra	$2,$2,8
	mult	$5,$2
	mflo	$14
	#nop
	#nop
	addu	$5,$3,$14
	slt	$2,$21,$5
	beq	$2,$0,$L813
	.set	noreorder
	.set	nomacro
	jal	rdiv
	move	$4,$21
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$2
	.set	macro
	.set	reorder

	move	$16,$2
$L813:
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,100($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,96($sp)
	.set	macro
	.set	reorder

	lw	$5,104($sp)
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,100($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$19,$L839
	sw	$2,104($sp)
	.set	macro
	.set	reorder

	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$5,20($sp)
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,48($sp)
	.set	macro
	.set	reorder

	lw	$5,24($sp)
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,52($sp)
	.set	macro
	.set	reorder

	lw	$5,48($sp)
	lw	$3,96($sp)
	lw	$4,100($sp)
	lw	$6,104($sp)
	sw	$2,56($sp)
	addu	$5,$5,$3
	lw	$3,52($sp)
	addu	$2,$2,$6
	sw	$5,48($sp)
	sw	$2,56($sp)
	addu	$3,$3,$4
	sw	$3,52($sp)
	lw	$4,188($18)
	#nop
	srl	$2,$4,31
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,32($sp)
	lw	$4,188($18)
	lw	$5,52($sp)
	srl	$2,$4,31
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,36($sp)
	lw	$4,188($18)
	lw	$5,56($sp)
	srl	$2,$4,31
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,40($sp)
	lw	$2,172($18)
	lw	$3,32($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,172($18)
	lw	$2,176($18)
	lw	$3,36($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,176($18)
	lw	$2,180($18)
	lw	$3,40($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,180($18)
	lw	$2,68($sp)
	#nop
	bgez	$2,$L815
	addu	$2,$2,255
$L815:
	lw	$7,56($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L816
	move	$4,$7
	.set	macro
	.set	reorder

	addu	$4,$7,255
$L816:
	sra	$11,$4,8
	mult	$2,$11
	lw	$3,72($sp)
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L817
	move	$5,$3
	.set	macro
	.set	reorder

	addu	$5,$3,255
$L817:
	lw	$6,52($sp)
	sra	$8,$5,8
	.set	noreorder
	.set	nomacro
	bgez	$6,$L818
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$2,$6,255
$L818:
	sra	$10,$2,8
	mult	$8,$10
	mflo	$14
	#nop
	#nop
	subu	$2,$4,$14
	sw	$2,32($sp)
	lw	$5,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L820
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$2,$5,255
$L820:
	sra	$9,$2,8
	mult	$8,$9
	lw	$3,64($sp)
	mflo	$2
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L821
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L821:
	sra	$4,$4,8
	mult	$4,$11
	mflo	$14
	#nop
	#nop
	subu	$2,$2,$14
	sw	$2,36($sp)
	mult	$4,$10
	lw	$3,68($sp)
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L825
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,255
$L825:
	sra	$6,$2,8
	mult	$6,$9
	mflo	$14
	#nop
	#nop
	subu	$2,$4,$14
	sw	$2,40($sp)
	lw	$9,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$9,$L828
	move	$2,$9
	.set	macro
	.set	reorder

	addu	$2,$9,255
$L828:
	sra	$12,$2,8
	mult	$6,$12
	lw	$3,72($sp)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L829
	move	$5,$3
	.set	macro
	.set	reorder

	addu	$5,$3,255
$L829:
	lw	$8,52($sp)
	sra	$2,$5,8
	.set	noreorder
	.set	nomacro
	bgez	$8,$L830
	move	$4,$8
	.set	macro
	.set	reorder

	addu	$4,$8,255
$L830:
	sra	$11,$4,8
	mult	$2,$11
	mflo	$14
	#nop
	#nop
	subu	$5,$6,$14
	sw	$5,32($sp)
	lw	$7,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$7,$L832
	move	$4,$7
	.set	macro
	.set	reorder

	addu	$4,$7,255
$L832:
	sra	$10,$4,8
	mult	$2,$10
	lw	$3,64($sp)
	mflo	$2
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L833
	move	$6,$3
	.set	macro
	.set	reorder

	addu	$6,$3,255
$L833:
	sra	$4,$6,8
	mult	$4,$12
	mflo	$14
	#nop
	#nop
	subu	$2,$2,$14
	sw	$2,36($sp)
	mult	$4,$11
	lw	$2,68($sp)
	mflo	$3
	#nop
	bgez	$2,$L837
	addu	$2,$2,255
$L837:
	sra	$2,$2,8
	mult	$2,$10
	mflo	$14
	#nop
	#nop
	subu	$2,$3,$14
	sw	$2,40($sp)
	lw	$4,292($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,32($sp)
	lw	$4,292($18)
	lw	$5,36($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,36($sp)
	lw	$4,292($18)
	lw	$5,40($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,1
	.set	macro
	.set	reorder

	sw	$2,40($sp)
	lw	$2,276($18)
	lw	$3,32($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,276($18)
	lw	$2,280($18)
	lw	$3,36($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,280($18)
	lw	$2,284($18)
	lw	$3,40($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,284($18)
$L839:
	lw	$31,184($sp)
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
	addu	$sp,$sp,192
	.set	macro
	.set	reorder

	.end	Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
	.text
	.ent	Collide_LimitAngularVel__FP13BO_tNewtonObj
Collide_LimitAngularVel__FP13BO_tNewtonObj:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,276($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L847
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,-131072			# 0xfffe0000
	ori	$2,$2,0x8000
	slt	$2,$3,$2
	beq	$2,$0,$L848
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
$L848:
	.set	noreorder
	.set	nomacro
	j	$L849
	sw	$3,276($4)
	.set	macro
	.set	reorder

$L847:
	ori	$2,$2,0x8000
	li	$5,65536			# 0x00010000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L850
	ori	$5,$5,0x8000
	.set	macro
	.set	reorder

	move	$5,$3
$L850:
	sw	$5,276($4)
$L849:
	lw	$3,280($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L852
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,-131072			# 0xfffe0000
	ori	$2,$2,0x8000
	slt	$2,$3,$2
	beq	$2,$0,$L853
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
$L853:
	.set	noreorder
	.set	nomacro
	j	$L854
	sw	$3,280($4)
	.set	macro
	.set	reorder

$L852:
	ori	$2,$2,0x8000
	li	$5,65536			# 0x00010000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L855
	ori	$5,$5,0x8000
	.set	macro
	.set	reorder

	move	$5,$3
$L855:
	sw	$5,280($4)
$L854:
	lw	$3,284($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L857
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	li	$2,-131072			# 0xfffe0000
	ori	$2,$2,0x8000
	slt	$2,$3,$2
	beq	$2,$0,$L858
	li	$3,-131072			# 0xfffe0000
	ori	$3,$3,0x8000
$L858:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,284($4)
	.set	macro
	.set	reorder

$L857:
	ori	$2,$2,0x8000
	li	$5,65536			# 0x00010000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L859
	ori	$5,$5,0x8000
	.set	macro
	.set	reorder

	move	$5,$3
$L859:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,284($4)
	.set	macro
	.set	reorder

	.end	Collide_LimitAngularVel__FP13BO_tNewtonObj
	.text
	.ent	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1:
	.frame	$sp,144,$31		# vars= 96, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$19,124($sp)
	move	$19,$4
	sw	$18,120($sp)
	move	$18,$5
	sw	$16,112($sp)
	move	$16,$6
	li	$4,393216			# 0x00060000
	sw	$31,140($sp)
	sw	$22,136($sp)
	sw	$21,132($sp)
	sw	$20,128($sp)
	sw	$17,116($sp)
	lw	$5,276($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$4,$4,0x487e
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,280($19)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($19)
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,284($19)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($19)
	.set	macro
	.set	reorder

	sw	$2,284($19)
	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L863
	move	$17,$0
	.set	macro
	.set	reorder

	lw	$2,4($18)
	#nop
	bne	$2,$0,$L863
	lw	$2,8($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L863
	li	$2,65536			# 0x00010000
	.set	macro
	.set	reorder

	sw	$2,4($18)
$L863:
	lw	$3,0($18)
	#nop
	bgez	$3,$L864
	addu	$3,$3,255
$L864:
	lw	$2,240($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L865
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L865:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,4($18)
	mflo	$4
	#nop
	bgez	$3,$L866
	addu	$3,$3,255
$L866:
	lw	$2,244($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L867
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L867:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($18)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L868
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L868:
	lw	$2,248($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L869
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L869:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	addu	$3,$4,$13
	bgez	$3,$L870
	addu	$3,$3,255
$L870:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L871
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L871:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	sw	$13,16($sp)
	lw	$3,0($18)
	#nop
	bgez	$3,$L872
	addu	$3,$3,255
$L872:
	lw	$2,252($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L873
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L873:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,4($18)
	mflo	$4
	#nop
	bgez	$3,$L874
	addu	$3,$3,255
$L874:
	lw	$2,256($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L875
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L875:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($18)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L876
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L876:
	lw	$2,260($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L877
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L877:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	addu	$3,$4,$13
	bgez	$3,$L878
	addu	$3,$3,255
$L878:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L879
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L879:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$5
	#nop
	#nop
	sw	$5,20($sp)
	lw	$3,0($18)
	#nop
	bgez	$3,$L880
	addu	$3,$3,255
$L880:
	lw	$2,264($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L881
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L881:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,4($18)
	mflo	$4
	#nop
	bgez	$3,$L882
	addu	$3,$3,255
$L882:
	lw	$2,268($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L883
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L883:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($18)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L884
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L884:
	lw	$2,272($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L885
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L885:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	addu	$3,$4,$13
	bgez	$3,$L886
	addu	$3,$3,255
$L886:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L887
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L887:
	sra	$2,$2,8
	mult	$3,$2
	li	$9,-1			# 0xffffffff
	lw	$12,16($sp)
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$12,$L888
	sw	$7,24($sp)
	.set	macro
	.set	reorder

	li	$9,1			# 0x00000001
$L888:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L889
	li	$10,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$10,1			# 0x00000001
$L889:
	.set	noreorder
	.set	nomacro
	bgez	$7,$L890
	li	$11,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$11,1			# 0x00000001
$L890:
	lw	$3,160($19)
	lw	$2,0($16)
	#nop
	subu	$5,$3,$2
	sw	$5,32($sp)
	lw	$3,164($19)
	lw	$2,4($16)
	#nop
	subu	$6,$3,$2
	sw	$6,36($sp)
	lw	$3,168($19)
	lw	$2,8($16)
	#nop
	subu	$8,$3,$2
	sw	$8,40($sp)
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L962
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L962:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L892
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L892:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,4($18)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L963
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L963:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L894
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L894:
	sra	$2,$2,8
	mult	$4,$2
	lw	$4,8($18)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L895
	addu	$3,$5,$13
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L895:
	move	$2,$8
	.set	noreorder
	.set	nomacro
	bgez	$2,$L896
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L896:
	sra	$2,$2,8
	mult	$4,$2
	mflo	$5
	#nop
	#nop
	mult	$9,$12
	mflo	$6
	#nop
	lw	$2,20($sp)
	#nop
	mult	$10,$2
	mflo	$8
	#nop
	#nop
	mult	$11,$7
	addu	$3,$3,$5
	addu	$2,$6,$8
	mflo	$4
	#nop
	#nop
	addu	$2,$2,$4
	addu	$5,$2,$3
	bgez	$5,$L897
	lw	$3,240($19)
	#nop
	bgez	$3,$L898
	addu	$3,$3,255
$L898:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L899
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L899:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$9,$13
	lw	$2,160($19)
	lw	$3,252($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L900
	addu	$4,$2,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L900:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L901
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L901:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$10,$13
	lw	$3,264($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L902
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L902:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L903
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L903:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$11,$13
	mflo	$13
	#nop
	#nop
	addu	$2,$4,$13
	sw	$2,96($sp)
	lw	$3,244($19)
	#nop
	bgez	$3,$L904
	addu	$3,$3,255
$L904:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L905
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L905:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$9,$13
	lw	$2,164($19)
	lw	$3,256($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L906
	addu	$4,$2,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L906:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L907
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L907:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$10,$13
	lw	$3,268($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L908
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L908:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L909
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L909:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$11,$13
	mflo	$13
	#nop
	#nop
	addu	$2,$4,$13
	sw	$2,100($sp)
	lw	$3,248($19)
	#nop
	bgez	$3,$L910
	addu	$3,$3,255
$L910:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L911
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L911:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$9,$13
	lw	$2,168($19)
	lw	$3,260($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L912
	addu	$4,$2,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L912:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L913
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L913:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$10,$13
	lw	$3,272($19)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L914
	addu	$4,$4,$13
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L914:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L915
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L915:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	mult	$11,$13
	subu	$3,$0,$5
	mflo	$13
	#nop
	#nop
	addu	$2,$4,$13
	sw	$2,104($sp)
	slt	$2,$17,$3
	beq	$2,$0,$L916
	move	$17,$3
$L916:
	lw	$2,Collide_gRaiseUp
	#nop
	beq	$2,$0,$L917
	beq	$17,$0,$L917
	srl	$16,$17,31
	addu	$16,$17,$16
	sra	$16,$16,1
	lw	$5,0($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,48($sp)
	lw	$5,4($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,52($sp)
	lw	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,56($sp)
	lw	$2,160($19)
	lw	$3,48($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,160($19)
	lw	$2,164($19)
	lw	$3,52($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,164($19)
	lw	$2,168($19)
	lw	$3,56($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,168($19)
$L917:
	lw	$3,96($sp)
	lw	$2,160($19)
	#nop
	subu	$9,$3,$2
	lw	$3,100($sp)
	sw	$9,80($sp)
	lw	$2,164($19)
	#nop
	subu	$6,$3,$2
	lw	$3,104($sp)
	sw	$6,84($sp)
	lw	$2,168($19)
	#nop
	subu	$3,$3,$2
	sw	$3,88($sp)
	lw	$2,280($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L964
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L964:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L920
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L920:
	sra	$7,$4,8
	mult	$5,$7
	lw	$2,284($19)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L965
	move	$4,$6
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L965:
	.set	noreorder
	.set	nomacro
	bgez	$6,$L922
	sra	$2,$2,8
	.set	macro
	.set	reorder

	addu	$4,$6,255
$L922:
	sra	$8,$4,8
	mult	$2,$8
	mflo	$13
	#nop
	#nop
	subu	$10,$5,$13
	sw	$10,64($sp)
	lw	$4,284($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L966
	move	$2,$9
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L966:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L924
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L924:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,276($19)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L967
	sra	$2,$4,8
	.set	macro
	.set	reorder

	addu	$4,$4,255
	sra	$2,$4,8
$L967:
	mult	$2,$7
	mflo	$13
	#nop
	#nop
	subu	$7,$5,$13
	sw	$7,68($sp)
	lw	$2,276($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L968
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$3,$2,8
$L968:
	mult	$3,$8
	lw	$4,280($19)
	mflo	$5
	#nop
	bgez	$4,$L929
	addu	$4,$4,255
$L929:
	lw	$2,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L930
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L930:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	subu	$3,$5,$13
	sw	$3,72($sp)
	lw	$2,172($19)
	#nop
	addu	$5,$10,$2
	sw	$5,64($sp)
	lw	$2,176($19)
	#nop
	addu	$6,$7,$2
	sw	$6,68($sp)
	lw	$2,180($19)
	#nop
	addu	$3,$3,$2
	sw	$3,72($sp)
	lw	$4,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L969
	move	$2,$5
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L969:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L933
	sra	$5,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L933:
	sra	$2,$2,8
	mult	$5,$2
	lw	$4,4($18)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L970
	move	$2,$6
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L970:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L935
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L935:
	sra	$2,$2,8
	mult	$4,$2
	lw	$4,8($18)
	mflo	$13
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L936
	addu	$5,$5,$13
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L936:
	move	$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L937
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L937:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$13
	#nop
	#nop
	addu	$2,$5,$13
	.set	noreorder
	.set	nomacro
	bgez	$2,$L931
	move	$4,$19
	.set	macro
	.set	reorder

	addu	$5,$sp,96
	addu	$6,$sp,64
	.set	noreorder
	.set	nomacro
	jal	Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21
	move	$7,$18
	.set	macro
	.set	reorder

$L931:
	lw	$2,Collide_gRaiseUp
	#nop
	beq	$2,$0,$L897
	beq	$17,$0,$L897
	lw	$5,52($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$5,$L897
	li	$4,589824			# 0x00090000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$4,$4,0xcccc
	.set	macro
	.set	reorder

	lw	$4,176($19)
	sll	$16,$2,1
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	move	$4,$2
	slt	$2,$4,$16
	beq	$2,$0,$L941
	.set	noreorder
	.set	nomacro
	j	$L897
	sw	$0,176($19)
	.set	macro
	.set	reorder

$L941:
	lw	$2,176($19)
	#nop
	blez	$2,$L943
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	subu	$4,$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L897
	sw	$2,176($19)
	.set	macro
	.set	reorder

$L943:
	.set	noreorder
	.set	nomacro
	jal	fixedsqrt
	subu	$4,$4,$16
	.set	macro
	.set	reorder

	subu	$2,$0,$2
	sw	$2,176($19)
$L897:
	lw	$5,276($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,10430			# 0x000028be
	.set	macro
	.set	reorder

	lw	$5,280($19)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($19)
	.set	macro
	.set	reorder

	lw	$5,284($19)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($19)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	Collide_LimitAngularVel__FP13BO_tNewtonObj
	sw	$2,284($19)
	.set	macro
	.set	reorder

	lw	$4,0($18)
	lw	$5,172($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$21,9			# 0x00000009
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,176($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,180($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	blez	$16,$L945
	lw	$4,0($18)
	lw	$5,172($19)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,176($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,180($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	j	$L961
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L945:
	lw	$4,0($18)
	lw	$5,172($19)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,176($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,180($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	subu	$16,$0,$16
$L961:
	sll	$22,$16,2
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$22
	beq	$2,$0,$L862
	lw	$4,0($18)
	lw	$5,240($19)
	jal	fixedmult
	lw	$4,4($18)
	lw	$5,244($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,248($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,0($18)
	lw	$5,252($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$20,$16,$2
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,256($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,260($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	lw	$4,0($18)
	lw	$5,264($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$17,$17,$2
	.set	macro
	.set	reorder

	lw	$4,4($18)
	lw	$5,268($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,8($18)
	lw	$5,272($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$18
	slt	$17,$17,-32768
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L948
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	li	$21,8			# 0x00000008
	move	$4,$19
	move	$5,$22
	move	$6,$21
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	move	$7,$0
	.set	macro
	.set	reorder

$L948:
	slt	$2,$16,-6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L949
	slt	$2,$20,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L950
	slt	$2,$20,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L951
	move	$21,$0
	.set	macro
	.set	reorder

$L950:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L971
	slt	$2,$16,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L951
	li	$21,2			# 0x00000002
	.set	macro
	.set	reorder

$L949:
	slt	$2,$16,6554
$L971:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L972
	slt	$2,$21,8
	.set	macro
	.set	reorder

	slt	$2,$20,6554
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L955
	slt	$2,$20,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L951
	li	$21,4			# 0x00000004
	.set	macro
	.set	reorder

$L955:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L972
	slt	$2,$21,8
	.set	macro
	.set	reorder

	li	$21,6			# 0x00000006
$L951:
	slt	$2,$21,8
$L972:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L862
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$22
	move	$6,$21
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	move	$7,$0
	.set	macro
	.set	reorder

$L862:
	lw	$31,140($sp)
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
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
	.text
	.ent	Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2:
	.frame	$sp,184,$31		# vars= 128, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$31,180($sp)
	sw	$fp,176($sp)
	sw	$23,172($sp)
	sw	$22,168($sp)
	sw	$21,164($sp)
	sw	$20,160($sp)
	sw	$19,156($sp)
	sw	$18,152($sp)
	sw	$17,148($sp)
	sw	$16,144($sp)
	sw	$4,184($sp)
	sw	$7,196($sp)
 #APP
 #NO_APP
	lw	$2,0($6)
	lw	$3,160($4)
	lw	$8,184($sp)
	subu	$2,$2,$3
	sw	$2,64($sp)
	lw	$4,4($6)
	lw	$2,164($8)
	#nop
	subu	$4,$4,$2
	sw	$4,68($sp)
	lw	$2,8($6)
	lw	$3,168($8)
	move	$fp,$5
	subu	$2,$2,$3
	sw	$2,72($sp)
	lw	$2,0($6)
	lw	$3,160($fp)
	#nop
	subu	$2,$2,$3
	sw	$2,80($sp)
	lw	$2,4($6)
	lw	$3,164($fp)
	#nop
	subu	$2,$2,$3
	sw	$2,84($sp)
	lw	$2,8($6)
	lw	$3,168($fp)
	move	$8,$7
	subu	$2,$2,$3
	sw	$2,88($sp)
	lw	$5,8($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,72($sp)
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,72($sp)
	lw	$8,196($sp)
	subu	$16,$16,$2
	sw	$16,32($sp)
	lw	$5,0($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,64($sp)
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,64($sp)
	lw	$8,196($sp)
	subu	$16,$16,$2
	sw	$16,36($sp)
	lw	$5,4($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,68($sp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,84($sp)
	lw	$8,196($sp)
	subu	$16,$16,$2
	sw	$16,40($sp)
	lw	$5,8($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,88($sp)
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,88($sp)
	lw	$8,196($sp)
	subu	$16,$16,$2
	sw	$16,48($sp)
	lw	$5,0($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,80($sp)
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	lw	$8,196($sp)
	subu	$16,$16,$2
	sw	$16,52($sp)
	lw	$5,4($8)
	jal	fixedmult
	lw	$8,196($sp)
	lw	$4,84($sp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	subu	$16,$16,$2
	sw	$16,56($sp)
	lw	$4,172($8)
	lw	$8,196($sp)
	#nop
	lw	$5,0($8)
	jal	fixedmult
	lw	$8,184($sp)
	#nop
	lw	$4,176($8)
	lw	$8,196($sp)
	#nop
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	#nop
	lw	$4,180($8)
	lw	$8,196($sp)
	#nop
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,128($sp)
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,172($fp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,132($sp)
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,176($fp)
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,180($fp)
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,136($sp)
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$5,32($sp)
	lw	$4,276($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$23,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$5,36($sp)
	lw	$4,280($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$5,40($sp)
	lw	$4,284($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$22,$2
	.set	macro
	.set	reorder

	lw	$4,276($fp)
	lw	$5,48($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$21,$2
	.set	macro
	.set	reorder

	lw	$4,280($fp)
	lw	$5,52($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,284($fp)
	lw	$5,56($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$20,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$22
	addu	$17,$17,$21
	addu	$16,$16,$20
	lw	$8,128($sp)
	addu	$16,$16,$2
	addu	$19,$19,$8
	lw	$8,132($sp)
	lw	$4,32($sp)
	addu	$19,$19,$8
	lw	$8,136($sp)
	move	$5,$4
	addu	$18,$18,$8
	addu	$18,$18,$23
	subu	$18,$18,$19
	subu	$18,$18,$17
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$18,$18,$16
	.set	macro
	.set	reorder

	lw	$4,36($sp)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$4,40($sp)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	addu	$16,$16,$17
	lw	$5,292($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$16,$2
	.set	macro
	.set	reorder

	lw	$4,48($sp)
	move	$19,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$4,52($sp)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$4,56($sp)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$4
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$5,292($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$4,$16,$2
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$8,184($sp)
	sra	$19,$19,1
	lw	$5,188($8)
	sra	$2,$2,1
	srl	$3,$5,31
	addu	$5,$5,$3
	lw	$3,188($fp)
	sra	$5,$5,1
	srl	$6,$3,31
	addu	$3,$3,$6
	sra	$3,$3,1
	addu	$5,$5,$3
	addu	$5,$5,$19
	.set	noreorder
	.set	nomacro
	jal	rdiv
	addu	$5,$5,$2
	.set	macro
	.set	reorder

	move	$22,$2
	.set	noreorder
	.set	nomacro
	bltz	$22,$L1029
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	#nop
	lw	$2,608($8)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L975
	lw	$2,396($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L975
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,396($8)
$L975:
	lw	$2,608($fp)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L976
	lw	$2,396($fp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L976
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$2,396($fp)
$L976:
	lw	$8,184($sp)
	#nop
	lw	$2,608($8)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L977
	li	$4,13107			# 0x00003333
	.set	macro
	.set	reorder

	lw	$2,608($fp)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L977
	li	$4,16384			# 0x00004000
$L977:
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$22
	.set	macro
	.set	reorder

	move	$22,$2
 #APP
 #NO_APP
	lw	$8,196($sp)
	#nop
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	sw	$2,16($sp)
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	sw	$2,20($sp)
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	sw	$2,24($sp)
	lw	$4,172($8)
	lw	$8,196($sp)
	#nop
	lw	$5,0($8)
	jal	fixedmult
	lw	$8,184($sp)
	#nop
	lw	$4,176($8)
	lw	$8,196($sp)
	#nop
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	#nop
	lw	$4,180($8)
	lw	$8,196($sp)
	#nop
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$20,$2
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,172($fp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$2
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,176($fp)
	lw	$5,4($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$8,196($sp)
	lw	$4,180($fp)
	lw	$5,8($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$20
	addu	$17,$17,$19
	addu	$16,$16,$18
	addu	$16,$16,$2
	lw	$8,184($sp)
	lw	$5,184($fp)
	lw	$2,184($8)
	subu	$4,$17,$16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	move	$16,$2
	lw	$5,188($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	blez	$2,$L978
	lw	$8,184($sp)
	#nop
	lw	$5,188($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L979
$L978:
	lw	$8,184($sp)
	#nop
	lw	$5,188($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	subu	$2,$0,$2
$L979:
	lw	$8,184($sp)
	#nop
	sw	$2,400($8)
	lw	$5,188($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	blez	$2,$L980
	lw	$5,188($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1032
	sw	$2,400($fp)
	.set	macro
	.set	reorder

$L980:
	lw	$5,188($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	subu	$2,$0,$2
	sw	$2,400($fp)
$L1032:
	lw	$8,184($sp)
	#nop
	lw	$2,0($8)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1033
	li	$3,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	lw	$2,0($fp)
	#nop
	slt	$2,$2,512
	bne	$2,$0,$L1034
$L1033:
	lw	$2,400($8)
	ori	$3,$3,0x5556
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$2,$8,$2
	lw	$8,184($sp)
	#nop
	sw	$2,400($8)
	lw	$2,400($fp)
	#nop
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$8
	#nop
	#nop
	subu	$2,$8,$2
	sw	$2,400($fp)
	lw	$8,184($sp)
$L1034:
	lw	$5,16($sp)
	lw	$4,188($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$5,20($sp)
	sw	$2,96($sp)
	lw	$4,188($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$5,24($sp)
	sw	$2,100($sp)
	lw	$4,188($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$3,96($sp)
	sw	$2,104($sp)
	lw	$2,172($8)
	#nop
	addu	$2,$2,$3
	sw	$2,172($8)
	lw	$2,176($8)
	lw	$3,100($sp)
	li	$4,327680			# 0x00050000
	addu	$2,$2,$3
	sw	$2,176($8)
	lw	$5,104($sp)
	lw	$2,180($8)
	lw	$3,0($8)
	ori	$4,$4,0x0001
	sw	$4,408($8)
	sw	$fp,404($8)
	addu	$2,$2,$5
	slt	$3,$3,512
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L984
	sw	$2,180($8)
	.set	macro
	.set	reorder

	lw	$2,160($8)
	lw	$3,160($fp)
	lw	$21,400($8)
	subu	$2,$2,$3
	sw	$2,112($sp)
	lw	$2,164($8)
	lw	$3,164($fp)
	li	$20,9			# 0x00000009
	subu	$2,$2,$3
	sw	$2,116($sp)
	lw	$2,168($8)
	lw	$3,168($fp)
	addu	$4,$sp,112
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,120($sp)
	.set	macro
	.set	reorder

	li	$2,655360			# 0x000a0000
	slt	$2,$2,$21
	beq	$2,$0,$L984
	lw	$8,184($sp)
	lw	$4,112($sp)
	lw	$5,240($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$4,116($sp)
	lw	$5,244($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$4,120($sp)
	lw	$5,248($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$8,184($sp)
	lw	$4,112($sp)
	lw	$5,252($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$19,$16,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$4,116($sp)
	lw	$5,256($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$4,120($sp)
	lw	$5,260($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	lw	$8,184($sp)
	lw	$4,112($sp)
	lw	$5,264($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$17,$17,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$4,116($sp)
	lw	$5,268($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	lw	$4,120($sp)
	lw	$5,272($8)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$18
	slt	$17,$17,-32768
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L986
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	li	$20,8			# 0x00000008
	lw	$4,184($sp)
	move	$5,$21
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L986:
	.set	noreorder
	bgez	$19,1f
	move	$2,$19
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L987
	slt	$2,$16,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L988
	slt	$2,$16,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

$L988:
	bne	$2,$0,$L987
	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,5			# 0x00000005
	.set	macro
	.set	reorder

$L987:
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L991
	slt	$2,$19,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L992
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,7			# 0x00000007
	.set	macro
	.set	reorder

$L992:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1035
	slt	$2,$16,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,3			# 0x00000003
	.set	macro
	.set	reorder

$L991:
	slt	$2,$16,-6553
$L1035:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L994
	slt	$2,$19,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L995
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	move	$20,$0
	.set	macro
	.set	reorder

$L995:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1036
	slt	$2,$16,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,2			# 0x00000002
	.set	macro
	.set	reorder

$L994:
	slt	$2,$16,6554
$L1036:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1037
	slt	$2,$20,8
	.set	macro
	.set	reorder

	slt	$2,$19,6554
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L998
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L989
	li	$20,6			# 0x00000006
	.set	macro
	.set	reorder

$L998:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1037
	slt	$2,$20,8
	.set	macro
	.set	reorder

	li	$20,4			# 0x00000004
$L989:
	slt	$2,$20,8
$L1037:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L984
	move	$5,$21
	.set	macro
	.set	reorder

	lw	$4,184($sp)
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L984:
	lw	$4,188($fp)
	lw	$5,16($sp)
	jal	fixedmult
	sw	$2,96($sp)
	lw	$4,188($fp)
	lw	$5,20($sp)
	jal	fixedmult
	sw	$2,100($sp)
	lw	$4,188($fp)
	lw	$5,24($sp)
	jal	fixedmult
	sw	$2,104($sp)
	lw	$2,172($fp)
	lw	$3,96($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,172($fp)
	lw	$2,176($fp)
	lw	$3,100($sp)
	li	$4,327680			# 0x00050000
	subu	$2,$2,$3
	sw	$2,176($fp)
	lw	$5,104($sp)
	ori	$4,$4,0x0001
	sw	$4,408($fp)
	lw	$8,184($sp)
	lw	$2,180($fp)
	lw	$3,0($fp)
	subu	$2,$2,$5
	slt	$3,$3,512
	sw	$8,404($fp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1001
	sw	$2,180($fp)
	.set	macro
	.set	reorder

	lw	$2,112($sp)
	lw	$21,400($fp)
	lw	$3,120($sp)
	subu	$4,$0,$2
	lw	$2,116($sp)
	subu	$3,$0,$3
	sw	$4,112($sp)
	sw	$3,120($sp)
	subu	$2,$0,$2
	sw	$2,116($sp)
	li	$2,655360			# 0x000a0000
	slt	$2,$2,$21
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1001
	li	$20,9			# 0x00000009
	.set	macro
	.set	reorder

	lw	$5,240($fp)
	jal	fixedmult
	lw	$4,116($sp)
	lw	$5,244($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,248($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	lw	$4,112($sp)
	lw	$5,252($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$19,$16,$2
	.set	macro
	.set	reorder

	lw	$4,116($sp)
	lw	$5,256($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,260($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$16
	lw	$4,112($sp)
	lw	$5,264($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	addu	$17,$17,$2
	.set	macro
	.set	reorder

	lw	$4,116($sp)
	lw	$5,268($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,120($sp)
	lw	$5,272($fp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$18
	slt	$17,$17,-32768
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L1003
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	li	$20,8			# 0x00000008
	move	$4,$fp
	move	$5,$21
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L1003:
	.set	noreorder
	bgez	$19,1f
	move	$2,$19
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1004
	slt	$2,$16,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1005
	slt	$2,$16,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

$L1005:
	bne	$2,$0,$L1004
	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,5			# 0x00000005
	.set	macro
	.set	reorder

$L1004:
	.set	noreorder
	bgez	$16,1f
	move	$2,$16
	subu	$2,$0,$2
1:
	.set	reorder
	slt	$2,$2,6553
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1008
	slt	$2,$19,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1009
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,7			# 0x00000007
	.set	macro
	.set	reorder

$L1009:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1038
	slt	$2,$16,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,3			# 0x00000003
	.set	macro
	.set	reorder

$L1008:
	slt	$2,$16,-6553
$L1038:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1011
	slt	$2,$19,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1012
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	move	$20,$0
	.set	macro
	.set	reorder

$L1012:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1039
	slt	$2,$16,6554
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,2			# 0x00000002
	.set	macro
	.set	reorder

$L1011:
	slt	$2,$16,6554
$L1039:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1040
	slt	$2,$20,8
	.set	macro
	.set	reorder

	slt	$2,$19,6554
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1015
	slt	$2,$19,-6553
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1006
	li	$20,6			# 0x00000006
	.set	macro
	.set	reorder

$L1015:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1040
	slt	$2,$20,8
	.set	macro
	.set	reorder

	li	$20,4			# 0x00000004
$L1006:
	slt	$2,$20,8
$L1040:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1001
	move	$4,$fp
	.set	macro
	.set	reorder

	move	$5,$21
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L1001:
	lw	$4,68($sp)
	lw	$5,24($sp)
	jal	fixedmult
	lw	$4,72($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,72($sp)
	lw	$5,16($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	lw	$4,64($sp)
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,64($sp)
	lw	$5,20($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,100($sp)
	.set	macro
	.set	reorder

	lw	$4,68($sp)
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	subu	$16,$16,$2
	sw	$16,104($sp)
	lw	$2,608($8)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1018
	li	$2,4128768			# 0x003f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$22
	bne	$2,$0,$L1018
	lw	$3,292($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1019
	addu	$2,$2,3
$L1019:
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$2,2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	sw	$2,96($sp)
	lw	$3,292($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1020
	addu	$2,$2,3
$L1020:
	lw	$5,100($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$2,2
	.set	macro
	.set	reorder

	lw	$8,184($sp)
	sw	$2,100($sp)
	lw	$3,292($8)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1021
	addu	$2,$2,3
$L1021:
	lw	$5,104($sp)
	.set	noreorder
	.set	nomacro
	j	$L1030
	sra	$4,$2,2
	.set	macro
	.set	reorder

$L1018:
	lw	$8,184($sp)
	lw	$5,96($sp)
	lw	$4,292($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$5,100($sp)
	sw	$2,96($sp)
	lw	$4,292($8)
	jal	fixedmult
	lw	$8,184($sp)
	lw	$5,104($sp)
	sw	$2,100($sp)
	lw	$4,292($8)
$L1030:
	jal	fixedmult
	sw	$2,104($sp)
	lw	$8,184($sp)
	lw	$3,96($sp)
	lw	$2,276($8)
	#nop
	addu	$2,$2,$3
	sw	$2,276($8)
	lw	$2,280($8)
	lw	$3,100($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,280($8)
	lw	$2,284($8)
	lw	$3,104($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,284($8)
	lw	$4,84($sp)
	lw	$5,24($sp)
	jal	fixedmult
	lw	$4,88($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,88($sp)
	lw	$5,16($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	lw	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	lw	$5,20($sp)
	subu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$16,100($sp)
	.set	macro
	.set	reorder

	lw	$4,84($sp)
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	subu	$16,$16,$2
	sw	$16,104($sp)
	lw	$2,608($fp)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1023
	li	$2,4128768			# 0x003f0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xffff
	slt	$2,$2,$22
	bne	$2,$0,$L1023
	lw	$3,292($fp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1024
	addu	$2,$2,3
$L1024:
	lw	$5,96($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$2,2
	.set	macro
	.set	reorder

	sw	$2,96($sp)
	lw	$3,292($fp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1025
	addu	$2,$2,3
$L1025:
	lw	$5,100($sp)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$4,$2,2
	.set	macro
	.set	reorder

	sw	$2,100($sp)
	lw	$3,292($fp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	bgez	$2,$L1026
	addu	$2,$2,3
$L1026:
	lw	$5,104($sp)
	.set	noreorder
	.set	nomacro
	j	$L1031
	sra	$4,$2,2
	.set	macro
	.set	reorder

$L1023:
	lw	$4,292($fp)
	lw	$5,96($sp)
	jal	fixedmult
	sw	$2,96($sp)
	lw	$4,292($fp)
	lw	$5,100($sp)
	jal	fixedmult
	sw	$2,100($sp)
	lw	$4,292($fp)
	lw	$5,104($sp)
$L1031:
	jal	fixedmult
	sw	$2,104($sp)
	lw	$2,276($fp)
	lw	$3,96($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,276($fp)
	lw	$2,280($fp)
	lw	$3,100($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,280($fp)
	lw	$2,284($fp)
	lw	$3,104($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,284($fp)
	lw	$8,184($sp)
	#nop
	lhu	$2,380($8)
	#nop
	addu	$2,$2,1
	sh	$2,380($8)
	lhu	$2,380($fp)
	lw	$3,160($fp)
	addu	$2,$2,1
	sh	$2,380($fp)
	lw	$2,160($8)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,416($fp)
	sw	$2,416($8)
	lw	$2,164($8)
	lw	$3,164($fp)
	#nop
	addu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,420($fp)
	lw	$3,168($8)
	sw	$2,420($8)
	lw	$4,168($fp)
	li	$2,1			# 0x00000001
	addu	$3,$3,$4
	srl	$4,$3,31
	addu	$3,$3,$4
	sra	$3,$3,$2
	sw	$3,424($fp)
	sw	$3,424($8)
$L1029:
	lw	$31,180($sp)
	lw	$fp,176($sp)
	lw	$23,172($sp)
	lw	$22,168($sp)
	lw	$21,164($sp)
	lw	$20,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
	.text
	.ent	Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2:
	.frame	$sp,112,$31		# vars= 80, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	sw	$18,104($sp)
	move	$18,$5
	li	$4,1			# 0x00000001
	move	$5,$0
	sw	$6,pP
	sw	$16,96($sp)
	move	$16,$7
	sw	$31,108($sp)
	sw	$17,obj0
	sw	$18,obj1
	sw	$16,pNormal
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,-1			# 0xffffffff
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1055
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	CHECK_VERTEX_WITH_DIRS_OTHER__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1064
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L1166
$L1055:
	lw	$4,172($18)
	lw	$3,172($17)
	sw	$0,findClosestSideDave
	subu	$2,$4,$3
	bgtz	$2,$L1072
	subu	$2,$3,$4
$L1072:
	lw	$4,176($18)
	lw	$3,176($17)
	#nop
	subu	$5,$4,$3
	bgtz	$5,$L1073
	subu	$5,$3,$4
$L1073:
	lw	$6,180($18)
	lw	$3,180($17)
	#nop
	subu	$4,$6,$3
	bgtz	$4,$L1074
	subu	$4,$3,$6
$L1074:
	move	$3,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1167
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	move	$3,$5
	slt	$2,$3,$4
$L1167:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1168
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	move	$3,$4
$L1168:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1077
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,findClosestSideDave
$L1077:
	lw	$2,findClosestSideDave
	#nop
	beq	$2,$0,$L1078
	lw	$2,xRange
	lw	$11,172($18)
	lw	$12,176($18)
	lw	$13,180($18)
	sw	$11,64($sp)
	sw	$12,68($sp)
	sw	$13,72($sp)
	lw	$11,240($17)
	lw	$12,244($17)
	lw	$13,248($17)
	sw	$11,16($sp)
	sw	$12,20($sp)
	sw	$13,24($sp)
	lw	$11,252($17)
	lw	$12,256($17)
	lw	$13,260($17)
	sw	$11,32($sp)
	sw	$12,36($sp)
	sw	$13,40($sp)
	lw	$11,264($17)
	lw	$12,268($17)
	lw	$13,272($17)
	sw	$11,48($sp)
	sw	$12,52($sp)
	sw	$13,56($sp)
	blez	$2,$L1079
	lw	$2,16($sp)
	lw	$3,24($sp)
	subu	$2,$0,$2
	sw	$2,16($sp)
	lw	$2,20($sp)
	subu	$3,$0,$3
	sw	$3,24($sp)
	subu	$2,$0,$2
	sw	$2,20($sp)
$L1079:
	lw	$2,yRange
	#nop
	blez	$2,$L1080
	lw	$2,32($sp)
	lw	$3,40($sp)
	subu	$2,$0,$2
	sw	$2,32($sp)
	lw	$2,36($sp)
	subu	$3,$0,$3
	sw	$3,40($sp)
	subu	$2,$0,$2
	sw	$2,36($sp)
$L1080:
	lw	$2,zRange
	#nop
	blez	$2,$L1081
	lw	$2,48($sp)
	lw	$3,56($sp)
	subu	$2,$0,$2
	sw	$2,48($sp)
	lw	$2,52($sp)
	subu	$3,$0,$3
	sw	$3,56($sp)
	subu	$2,$0,$2
	sw	$2,52($sp)
$L1081:
	lw	$2,16($sp)
	#nop
	bgez	$2,$L1082
	addu	$2,$2,255
$L1082:
	lw	$6,64($sp)
	sra	$4,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1083
	move	$3,$6
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L1083:
	sra	$10,$3,8
	mult	$4,$10
	lw	$2,20($sp)
	mflo	$4
	#nop
	bgez	$2,$L1084
	addu	$2,$2,255
$L1084:
	lw	$5,68($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1085
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L1085:
	sra	$9,$3,8
	mult	$2,$9
	lw	$2,24($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1086
	addu	$7,$4,$11
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1086:
	lw	$4,72($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1087
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1087:
	sra	$8,$3,8
	mult	$2,$8
	lw	$2,32($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1088
	addu	$7,$7,$11
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1088:
	sra	$3,$2,8
	mult	$3,$10
	lw	$2,36($sp)
	mflo	$6
	#nop
	bgez	$2,$L1090
	addu	$2,$2,255
$L1090:
	sra	$2,$2,8
	mult	$2,$9
	lw	$3,40($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1092
	addu	$2,$6,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1092:
	sra	$3,$3,8
	mult	$3,$8
	lw	$3,48($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1094
	addu	$5,$2,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1094:
	lw	$2,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1095
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1095:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,52($sp)
	mflo	$4
	#nop
	bgez	$3,$L1096
	addu	$3,$3,255
$L1096:
	lw	$2,68($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1097
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1097:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,56($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1098
	addu	$4,$4,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1098:
	lw	$2,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1099
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1099:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$11
	#nop
	#nop
	addu	$3,$4,$11
 #APP
	
 #NO_APP
	bgez	$7,$L1100
	subu	$7,$0,$7
$L1100:
	bgez	$5,$L1101
	subu	$5,$0,$5
$L1101:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1169
	slt	$2,$5,$7
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L1169:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1103
	slt	$2,$3,$7
	.set	macro
	.set	reorder

	bne	$2,$0,$L1104
$L1103:
	slt	$2,$3,$5
	beq	$2,$0,$L1107
	j	$L1106
$L1078:
	lw	$3,xRange
	#nop
	bgez	$3,$L1108
	lw	$2,308($17)
	.set	noreorder
	.set	nomacro
	j	$L1109
	addu	$5,$2,$3
	.set	macro
	.set	reorder

$L1108:
	lw	$2,308($17)
	#nop
	subu	$5,$2,$3
$L1109:
	lw	$3,yRange
	#nop
	bgez	$3,$L1110
	lw	$2,312($17)
	.set	noreorder
	.set	nomacro
	j	$L1111
	addu	$4,$2,$3
	.set	macro
	.set	reorder

$L1110:
	lw	$2,312($17)
	#nop
	subu	$4,$2,$3
$L1111:
	lw	$3,zRange
	#nop
	bgez	$3,$L1112
	lw	$2,316($17)
	.set	noreorder
	.set	nomacro
	j	$L1113
	addu	$3,$2,$3
	.set	macro
	.set	reorder

$L1112:
	lw	$2,316($17)
	#nop
	subu	$3,$2,$3
$L1113:
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1114
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1170
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	lw	$2,xRange
	lw	$12,240($17)
	lw	$13,244($17)
	lw	$14,248($17)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	j	$L1115
$L1114:
	slt	$2,$4,$3
$L1170:
	beq	$2,$0,$L1116
	lw	$2,yRange
	lw	$12,252($17)
	lw	$13,256($17)
	lw	$14,260($17)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	j	$L1115
$L1116:
	lw	$2,zRange
	lw	$12,264($17)
	lw	$13,268($17)
	lw	$14,272($17)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
$L1115:
	.set	noreorder
	.set	nomacro
	blez	$2,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L1120
$L1064:
	lw	$4,172($18)
	lw	$3,172($17)
	sw	$0,findClosestSideDave
	subu	$2,$4,$3
	bgtz	$2,$L1121
	subu	$2,$3,$4
$L1121:
	lw	$4,176($18)
	lw	$3,176($17)
	#nop
	subu	$5,$4,$3
	bgtz	$5,$L1122
	subu	$5,$3,$4
$L1122:
	lw	$6,180($18)
	lw	$3,180($17)
	#nop
	subu	$4,$6,$3
	bgtz	$4,$L1123
	subu	$4,$3,$6
$L1123:
	move	$3,$2
	slt	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1171
	slt	$2,$3,$4
	.set	macro
	.set	reorder

	move	$3,$5
	slt	$2,$3,$4
$L1171:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1172
	li	$2,983040			# 0x000f0000
	.set	macro
	.set	reorder

	move	$3,$4
$L1172:
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1126
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,findClosestSideDave
$L1126:
	lw	$2,findClosestSideDave
	#nop
	beq	$2,$0,$L1127
	lw	$2,xRange
	lw	$12,172($17)
	lw	$13,176($17)
	lw	$14,180($17)
	sw	$12,80($sp)
	sw	$13,84($sp)
	sw	$14,88($sp)
	lw	$12,240($18)
	lw	$13,244($18)
	lw	$14,248($18)
	sw	$12,16($sp)
	sw	$13,20($sp)
	sw	$14,24($sp)
	lw	$12,252($18)
	lw	$13,256($18)
	lw	$14,260($18)
	sw	$12,32($sp)
	sw	$13,36($sp)
	sw	$14,40($sp)
	lw	$12,264($18)
	lw	$13,268($18)
	lw	$14,272($18)
	sw	$12,48($sp)
	sw	$13,52($sp)
	sw	$14,56($sp)
	bgez	$2,$L1128
	lw	$2,16($sp)
	lw	$3,24($sp)
	subu	$2,$0,$2
	sw	$2,16($sp)
	lw	$2,20($sp)
	subu	$3,$0,$3
	sw	$3,24($sp)
	subu	$2,$0,$2
	sw	$2,20($sp)
$L1128:
	lw	$2,yRange
	#nop
	bgez	$2,$L1129
	lw	$2,32($sp)
	lw	$3,40($sp)
	subu	$2,$0,$2
	sw	$2,32($sp)
	lw	$2,36($sp)
	subu	$3,$0,$3
	sw	$3,40($sp)
	subu	$2,$0,$2
	sw	$2,36($sp)
$L1129:
	lw	$2,zRange
	#nop
	bgez	$2,$L1130
	lw	$2,48($sp)
	lw	$3,56($sp)
	subu	$2,$0,$2
	sw	$2,48($sp)
	lw	$2,52($sp)
	subu	$3,$0,$3
	sw	$3,56($sp)
	subu	$2,$0,$2
	sw	$2,52($sp)
$L1130:
	lw	$2,16($sp)
	#nop
	bgez	$2,$L1131
	addu	$2,$2,255
$L1131:
	lw	$6,80($sp)
	sra	$4,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$6,$L1132
	move	$3,$6
	.set	macro
	.set	reorder

	addu	$3,$6,255
$L1132:
	sra	$10,$3,8
	mult	$4,$10
	lw	$2,20($sp)
	mflo	$4
	#nop
	bgez	$2,$L1133
	addu	$2,$2,255
$L1133:
	lw	$5,84($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1134
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L1134:
	sra	$9,$3,8
	mult	$2,$9
	lw	$2,24($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1135
	addu	$7,$4,$11
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1135:
	lw	$4,88($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1136
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1136:
	sra	$8,$3,8
	mult	$2,$8
	lw	$2,32($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1137
	addu	$7,$7,$11
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1137:
	sra	$3,$2,8
	mult	$3,$10
	lw	$2,36($sp)
	mflo	$6
	#nop
	bgez	$2,$L1139
	addu	$2,$2,255
$L1139:
	sra	$2,$2,8
	mult	$2,$9
	lw	$3,40($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1141
	addu	$2,$6,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1141:
	sra	$3,$3,8
	mult	$3,$8
	lw	$3,48($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1143
	addu	$5,$2,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1143:
	lw	$2,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1144
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1144:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,52($sp)
	mflo	$4
	#nop
	bgez	$3,$L1145
	addu	$3,$3,255
$L1145:
	lw	$2,84($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1146
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1146:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,56($sp)
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1147
	addu	$4,$4,$11
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1147:
	lw	$2,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1148
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1148:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$11
	#nop
	#nop
	addu	$3,$4,$11
 #APP
	
 #NO_APP
	bgez	$7,$L1149
	subu	$7,$0,$7
$L1149:
	bgez	$5,$L1150
	subu	$5,$0,$5
$L1150:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1173
	slt	$2,$5,$7
	.set	macro
	.set	reorder

	subu	$3,$0,$3
$L1173:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1152
	slt	$2,$3,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1174
	slt	$2,$3,$5
	.set	macro
	.set	reorder

$L1104:
	lw	$12,16($sp)
	lw	$13,20($sp)
	lw	$14,24($sp)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	.set	noreorder
	.set	nomacro
	j	$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1152:
	slt	$2,$3,$5
$L1174:
	beq	$2,$0,$L1107
$L1106:
	lw	$12,32($sp)
	lw	$13,36($sp)
	lw	$14,40($sp)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	.set	noreorder
	.set	nomacro
	j	$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1107:
	lw	$12,48($sp)
	lw	$13,52($sp)
	lw	$14,56($sp)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	.set	noreorder
	.set	nomacro
	j	$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1127:
	lw	$3,xRange
	#nop
	bgez	$3,$L1154
	lw	$2,308($18)
	.set	noreorder
	.set	nomacro
	j	$L1155
	addu	$5,$2,$3
	.set	macro
	.set	reorder

$L1154:
	lw	$2,308($18)
	#nop
	subu	$5,$2,$3
$L1155:
	lw	$3,yRange
	#nop
	bgez	$3,$L1156
	lw	$2,312($18)
	.set	noreorder
	.set	nomacro
	j	$L1157
	addu	$4,$2,$3
	.set	macro
	.set	reorder

$L1156:
	lw	$2,312($18)
	#nop
	subu	$4,$2,$3
$L1157:
	lw	$3,zRange
	#nop
	bgez	$3,$L1158
	lw	$2,316($18)
	.set	noreorder
	.set	nomacro
	j	$L1159
	addu	$3,$2,$3
	.set	macro
	.set	reorder

$L1158:
	lw	$2,316($18)
	#nop
	subu	$3,$2,$3
$L1159:
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1160
	slt	$2,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1175
	slt	$2,$4,$3
	.set	macro
	.set	reorder

	lw	$2,xRange
	lw	$12,240($18)
	lw	$13,244($18)
	lw	$14,248($18)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	j	$L1161
$L1160:
	slt	$2,$4,$3
$L1175:
	beq	$2,$0,$L1162
	lw	$2,yRange
	lw	$12,252($18)
	lw	$13,256($18)
	lw	$14,260($18)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
	j	$L1161
$L1162:
	lw	$2,zRange
	lw	$12,264($18)
	lw	$13,268($18)
	lw	$14,272($18)
	sw	$12,0($16)
	sw	$13,4($16)
	sw	$14,8($16)
$L1161:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1166
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L1120:
	lw	$2,0($16)
	lw	$3,8($16)
	subu	$2,$0,$2
	sw	$2,0($16)
	lw	$2,4($16)
	subu	$3,$0,$3
	sw	$3,8($16)
	subu	$2,$0,$2
	sw	$2,4($16)
 #APP
 #NO_APP
	li	$2,1			# 0x00000001
$L1166:
	lw	$31,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
	.text
	.ent	Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2:
	.frame	$sp,176,$31		# vars= 120, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	sw	$19,148($sp)
	move	$19,$4
	sw	$18,144($sp)
	move	$18,$5
	sw	$16,136($sp)
	move	$16,$0
	lui	$5,%hi(basisDots) # high
	sw	$31,172($sp)
	sw	$fp,168($sp)
	sw	$23,164($sp)
	sw	$22,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$17,140($sp)
	sw	$6,184($sp)
	sw	$7,188($sp)
	lw	$3,240($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1177
	addiu	$6,$5,%lo(basisDots) # low
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1177:
	lw	$2,240($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1178
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1178:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,244($19)
	mflo	$4
	#nop
	bgez	$3,$L1179
	addu	$3,$3,255
$L1179:
	lw	$2,244($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1180
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1180:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,248($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1181
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1181:
	lw	$2,248($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1182
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1182:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,%lo(basisDots)($5)
	lw	$3,240($19)
	#nop
	bgez	$3,$L1183
	addu	$3,$3,255
$L1183:
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1184
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1184:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,244($19)
	mflo	$4
	#nop
	bgez	$3,$L1185
	addu	$3,$3,255
$L1185:
	lw	$2,256($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1186
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1186:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,248($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1187
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1187:
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1188
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1188:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,4($6)
	lw	$3,240($19)
	#nop
	bgez	$3,$L1189
	addu	$3,$3,255
$L1189:
	lw	$2,264($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1190
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1190:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,244($19)
	mflo	$4
	#nop
	bgez	$3,$L1191
	addu	$3,$3,255
$L1191:
	lw	$2,268($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1192
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1192:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,248($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1193
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1193:
	lw	$2,272($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1194
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1194:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,8($6)
	lw	$3,252($19)
	#nop
	bgez	$3,$L1195
	addu	$3,$3,255
$L1195:
	lw	$2,240($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1196
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1196:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,256($19)
	mflo	$4
	#nop
	bgez	$3,$L1197
	addu	$3,$3,255
$L1197:
	lw	$2,244($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1198
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1198:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,260($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1199
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1199:
	lw	$2,248($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1200
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1200:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,12($6)
	lw	$3,252($19)
	#nop
	bgez	$3,$L1201
	addu	$3,$3,255
$L1201:
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1202
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1202:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,256($19)
	mflo	$4
	#nop
	bgez	$3,$L1203
	addu	$3,$3,255
$L1203:
	lw	$2,256($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1204
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1204:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,260($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1205
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1205:
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1206
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1206:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,16($6)
	lw	$3,252($19)
	#nop
	bgez	$3,$L1207
	addu	$3,$3,255
$L1207:
	lw	$2,264($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1208
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1208:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,256($19)
	mflo	$4
	#nop
	bgez	$3,$L1209
	addu	$3,$3,255
$L1209:
	lw	$2,268($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1210
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1210:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,260($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1211
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1211:
	lw	$2,272($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1212
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1212:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,20($6)
	lw	$3,264($19)
	#nop
	bgez	$3,$L1213
	addu	$3,$3,255
$L1213:
	lw	$2,240($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1214
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1214:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,268($19)
	mflo	$4
	#nop
	bgez	$3,$L1215
	addu	$3,$3,255
$L1215:
	lw	$2,244($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1216
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1216:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,272($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1217
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1217:
	lw	$2,248($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1218
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1218:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,24($6)
	lw	$3,264($19)
	#nop
	bgez	$3,$L1219
	addu	$3,$3,255
$L1219:
	lw	$2,252($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1220
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1220:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,268($19)
	mflo	$4
	#nop
	bgez	$3,$L1221
	addu	$3,$3,255
$L1221:
	lw	$2,256($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1222
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1222:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,272($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1223
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1223:
	lw	$2,260($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1224
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1224:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,28($6)
	lw	$3,264($19)
	#nop
	bgez	$3,$L1225
	addu	$3,$3,255
$L1225:
	lw	$2,264($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1226
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1226:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,268($19)
	mflo	$4
	#nop
	bgez	$3,$L1227
	addu	$3,$3,255
$L1227:
	lw	$2,268($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1228
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1228:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,272($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1229
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1229:
	lw	$2,272($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1230
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1230:
	sra	$2,$2,8
	mult	$3,$2
	lui	$5,%hi(scaledBasisDots) # high
	lw	$3,0($6)
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	addiu	$4,$5,%lo(scaledBasisDots) # low
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1231
	sw	$2,32($6)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1231:
	lw	$2,308($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1232
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1232:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,4($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1233
	sw	$15,%lo(scaledBasisDots)($5)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1233:
	lw	$2,312($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1234
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1234:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1235
	sw	$15,4($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1235:
	lw	$2,316($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1236
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1236:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,12($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1237
	sw	$15,8($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1237:
	lw	$2,308($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1238
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1238:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,16($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1239
	sw	$15,12($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1239:
	lw	$2,312($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1240
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1240:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,20($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1241
	sw	$15,16($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1241:
	lw	$2,316($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1242
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1242:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,24($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1243
	sw	$15,20($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1243:
	lw	$2,308($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1244
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1244:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,28($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1245
	sw	$15,24($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1245:
	lw	$2,312($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1246
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1246:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,32($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1247
	sw	$15,28($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1247:
	lw	$2,316($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1248
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1248:
	sra	$2,$2,8
	mult	$3,$2
	lui	$5,%hi(scaledBasisDotsOther) # high
	lw	$3,0($6)
	mflo	$15
	#nop
	#nop
	sw	$15,32($4)
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1249
	addiu	$4,$5,%lo(scaledBasisDotsOther) # low
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1249:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1250
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1250:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,4($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1251
	sw	$15,%lo(scaledBasisDotsOther)($5)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1251:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1252
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1252:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,8($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1253
	sw	$15,4($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1253:
	lw	$2,308($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1254
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1254:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,12($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1255
	sw	$15,8($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1255:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1256
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1256:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,16($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1257
	sw	$15,12($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1257:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1258
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1258:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,20($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1259
	sw	$15,16($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1259:
	lw	$2,312($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1260
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1260:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,24($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1261
	sw	$15,20($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1261:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1262
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1262:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,28($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1263
	sw	$15,24($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1263:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1264
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1264:
	sra	$2,$2,8
	mult	$3,$2
	lw	$3,32($6)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1265
	sw	$15,28($4)
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1265:
	lw	$2,316($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1266
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1266:
	sra	$2,$2,8
	mult	$3,$2
	li	$fp,32			# 0x00000020
	move	$21,$0
	lui	$22,%hi(basisDotRelative) # high
	addiu	$20,$22,%lo(basisDotRelative) # low
	addu	$15,$sp,64
	sw	$15,128($sp)
	mflo	$23
	#nop
	#nop
	sw	$23,32($4)
$L1267:
	slt	$2,$21,$fp
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1351
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$3,160($18)
	lw	$2,160($19)
	#nop
	subu	$7,$3,$2
	sw	$7,48($sp)
	lw	$3,164($18)
	lw	$2,164($19)
	#nop
	subu	$8,$3,$2
	sw	$8,52($sp)
	lw	$3,168($18)
	lw	$2,168($19)
	#nop
	subu	$2,$3,$2
	sw	$2,56($sp)
	lw	$4,240($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1352
	move	$5,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1352:
	.set	noreorder
	.set	nomacro
	bgez	$7,$L1272
	sra	$6,$4,8
	.set	macro
	.set	reorder

	addu	$5,$7,255
$L1272:
	sra	$10,$5,8
	mult	$6,$10
	lw	$4,244($19)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1353
	move	$5,$8
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1353:
	.set	noreorder
	.set	nomacro
	bgez	$8,$L1274
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$5,$8,255
$L1274:
	sra	$9,$5,8
	mult	$4,$9
	lw	$4,248($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1275
	addu	$5,$6,$15
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1275:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1276
	sra	$3,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1276:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$5,$15
	sw	$2,%lo(basisDotRelative)($22)
	lw	$2,252($19)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1354
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$3,$2,8
$L1354:
	mult	$3,$10
	lw	$2,256($19)
	mflo	$4
	#nop
	bgez	$2,$L1279
	addu	$2,$2,255
$L1279:
	sra	$2,$2,8
	mult	$2,$9
	lw	$3,260($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1281
	addu	$4,$4,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1281:
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1282
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1282:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,4($20)
	lw	$2,264($19)
	#nop
	bgez	$2,$L1283
	addu	$2,$2,255
$L1283:
	lw	$5,48($sp)
	sra	$4,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1284
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L1284:
	sra	$8,$3,8
	mult	$4,$8
	lw	$2,268($19)
	mflo	$6
	#nop
	bgez	$2,$L1285
	addu	$2,$2,255
$L1285:
	lw	$4,52($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1286
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1286:
	sra	$7,$3,8
	mult	$2,$7
	lw	$3,272($19)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1287
	addu	$6,$6,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1287:
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1288
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1288:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$6,$15
	sw	$2,8($20)
	lw	$2,240($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1355
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$3,$2,8
$L1355:
	mult	$3,$8
	lw	$2,244($18)
	mflo	$5
	#nop
	bgez	$2,$L1291
	addu	$2,$2,255
$L1291:
	sra	$2,$2,8
	mult	$2,$7
	lw	$3,248($18)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1293
	addu	$4,$5,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1293:
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1294
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1294:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$4,$15
	sw	$2,12($20)
	lw	$2,252($18)
	#nop
	bgez	$2,$L1295
	addu	$2,$2,255
$L1295:
	lw	$5,48($sp)
	sra	$4,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1296
	move	$3,$5
	.set	macro
	.set	reorder

	addu	$3,$5,255
$L1296:
	sra	$8,$3,8
	mult	$4,$8
	lw	$2,256($18)
	mflo	$6
	#nop
	bgez	$2,$L1297
	addu	$2,$2,255
$L1297:
	lw	$4,52($sp)
	sra	$2,$2,8
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1298
	move	$3,$4
	.set	macro
	.set	reorder

	addu	$3,$4,255
$L1298:
	sra	$7,$3,8
	mult	$2,$7
	lw	$3,260($18)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1299
	addu	$6,$6,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1299:
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1300
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1300:
	sra	$2,$2,8
	mult	$3,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$6,$15
	sw	$2,16($20)
	lw	$2,264($18)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1356
	sra	$3,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$3,$2,8
$L1356:
	mult	$3,$8
	lw	$2,268($18)
	mflo	$5
	#nop
	bgez	$2,$L1303
	addu	$2,$2,255
$L1303:
	sra	$2,$2,8
	mult	$2,$7
	lw	$3,272($18)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1305
	addu	$6,$5,$15
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1305:
	lw	$2,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1306
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1306:
	sra	$2,$2,8
	mult	$3,$2
	move	$4,$19
	mflo	$15
	#nop
	#nop
	addu	$2,$6,$15
	sw	$2,20($20)
	lw	$6,184($sp)
	lw	$7,188($sp)
	.set	noreorder
	.set	nomacro
	jal	Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1268
	move	$2,$16
	.set	macro
	.set	reorder

	bne	$16,$0,$L1308
	lw	$3,172($19)
	lw	$2,172($18)
	move	$16,$0
	subu	$4,$3,$2
	sw	$4,64($sp)
	lw	$2,176($19)
	lw	$3,176($18)
	move	$17,$16
	subu	$2,$2,$3
	sw	$2,68($sp)
	lw	$3,180($19)
	lw	$2,180($18)
	move	$5,$4
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1309
	sw	$3,72($sp)
	.set	macro
	.set	reorder

	addu	$5,$4,255
$L1309:
	sra	$2,$5,8
	mult	$2,$2
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1311
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L1311:
	sra	$2,$4,8
	mult	$2,$2
	li	$2,235929600			# 0x0e100000
	mflo	$15
	#nop
	#nop
	addu	$3,$5,$15
	slt	$2,$2,$3
	beq	$2,$0,$L1313
	lw	$2,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1314
	move	$3,$2
	.set	macro
	.set	reorder

	addu	$3,$2,255
$L1314:
	sra	$2,$3,8
	lw	$23,48($sp)
 #APP
 #NO_APP
	mult	$2,$2
	lw	$3,56($sp)
	mflo	$5
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1315
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$4,$3,255
$L1315:
	sra	$2,$4,8
	mult	$2,$2
	mflo	$15
	#nop
	#nop
	addu	$2,$5,$15
	slt	$2,$2,3276
	beq	$2,$0,$L1317
	.set	noreorder
	.set	nomacro
	jal	Math_VectorLength__FP8coorddef
	addu	$4,$sp,64
	.set	macro
	.set	reorder

	srl	$3,$2,31
	addu	$3,$3,$2
	sra	$5,$3,1
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L1350
	li	$17,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1313
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L1317:
	lw	$23,64($sp)
	lw	$24,68($sp)
	lw	$25,72($sp)
	sw	$23,96($sp)
	sw	$24,100($sp)
	sw	$25,104($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	addu	$4,$sp,96
	.set	macro
	.set	reorder

	lw	$23,48($sp)
	lw	$24,52($sp)
	lw	$25,56($sp)
	sw	$23,112($sp)
	sw	$24,116($sp)
	sw	$25,120($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,112
	.set	macro
	.set	reorder

	lw	$3,96($sp)
	#nop
	bgez	$3,$L1321
	addu	$3,$3,255
$L1321:
	lw	$2,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1322
	sra	$4,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1322:
	sra	$2,$2,8
	mult	$4,$2
	lw	$3,100($sp)
	mflo	$5
	#nop
	bgez	$3,$L1323
	addu	$3,$3,255
$L1323:
	lw	$2,116($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1324
	sra	$3,$3,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1324:
	sra	$2,$2,8
	mult	$3,$2
	lw	$4,104($sp)
	mflo	$15
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1325
	addu	$3,$5,$15
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1325:
	lw	$2,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1326
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1326:
	sra	$2,$2,8
	mult	$4,$2
	li	$2,55705			# 0x0000d999
	mflo	$15
	#nop
	#nop
	addu	$3,$3,$15
	slt	$2,$2,$3
	beq	$2,$0,$L1313
	lw	$4,128($sp)
	jal	Math_VectorLength__FP8coorddef
	srl	$3,$2,31
	addu	$3,$3,$2
	sra	$5,$3,1
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L1328
	li	$17,65536			# 0x00010000
	.set	macro
	.set	reorder

$L1350:
	.set	noreorder
	.set	nomacro
	jal	rdiv
	li	$4,32768			# 0x00008000
	.set	macro
	.set	reorder

	move	$17,$2
$L1328:
	li	$16,1			# 0x00000001
$L1313:
	beq	$16,$0,$L1330
	lw	$2,0($19)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1331
	subu	$16,$0,$17
	.set	macro
	.set	reorder

	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L1332
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L1331:
	lw	$5,172($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	lw	$5,176($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,20($sp)
	lw	$5,180($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,24($sp)
	sra	$2,$2,5
	sw	$2,24($sp)
	lw	$2,16($sp)
	lw	$3,20($sp)
	sra	$2,$2,5
	sra	$3,$3,5
	sw	$2,16($sp)
	sw	$3,20($sp)
$L1332:
	lw	$2,0($18)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1333
	subu	$16,$0,$17
	.set	macro
	.set	reorder

	sw	$0,32($sp)
	sw	$0,36($sp)
	.set	noreorder
	.set	nomacro
	j	$L1335
	sw	$0,40($sp)
	.set	macro
	.set	reorder

$L1333:
	lw	$5,172($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,32($sp)
	lw	$5,176($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,36($sp)
	lw	$5,180($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,40($sp)
	sra	$2,$2,5
	sw	$2,40($sp)
	lw	$2,32($sp)
	lw	$3,36($sp)
	sra	$2,$2,5
	sra	$3,$3,5
	sw	$2,32($sp)
	.set	noreorder
	.set	nomacro
	j	$L1335
	sw	$3,36($sp)
	.set	macro
	.set	reorder

$L1330:
	lw	$23,48($sp)
	lw	$24,52($sp)
	lw	$25,56($sp)
	sw	$23,80($sp)
	sw	$24,84($sp)
	sw	$25,88($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	addu	$4,$sp,80
	.set	macro
	.set	reorder

	lw	$4,184($19)
	lw	$2,184($18)
	#nop
	addu	$16,$4,$2
	.set	noreorder
	.set	nomacro
	jal	rdiv
	move	$5,$16
	.set	macro
	.set	reorder

	move	$5,$16
	lw	$4,184($18)
	.set	noreorder
	.set	nomacro
	jal	rdiv
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	bgez	$4,$L1336
	addu	$2,$4,3
$L1336:
	lw	$7,80($sp)
	sra	$5,$2,2
	mult	$7,$5
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1337
	addu	$2,$2,16383
$L1337:
	lw	$6,84($sp)
	#nop
	mult	$6,$5
	sra	$2,$2,14
	subu	$13,$0,$2
	sra	$14,$13,5
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1339
	sw	$14,16($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,16383
$L1339:
	sra	$2,$3,14
	subu	$11,$0,$2
	sra	$12,$11,5
	sw	$12,20($sp)
	lw	$3,88($sp)
	#nop
	mult	$3,$5
	mflo	$2
	#nop
	#nop
	bgez	$2,$L1341
	addu	$2,$2,16383
$L1341:
	sra	$2,$2,14
	subu	$9,$0,$2
	sra	$10,$9,5
	sw	$10,24($sp)
	.set	noreorder
	.set	nomacro
	bgez	$16,$L1342
	move	$2,$16
	.set	macro
	.set	reorder

	addu	$2,$16,3
$L1342:
	sra	$2,$2,2
	mult	$7,$2
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1357
	mult	$6,$2
	.set	macro
	.set	reorder

	addu	$4,$4,16383
$L1357:
	sra	$7,$4,19
	mflo	$5
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1345
	sw	$7,32($sp)
	.set	macro
	.set	reorder

	addu	$5,$5,16383
$L1345:
	sra	$8,$5,19
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1347
	sw	$8,36($sp)
	.set	macro
	.set	reorder

	addu	$3,$3,16383
$L1347:
	sra	$6,$3,19
	sw	$6,40($sp)
	lw	$2,0($19)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1348
	srl	$2,$4,31
	.set	macro
	.set	reorder

	addu	$2,$7,$2
	sra	$2,$2,1
	sw	$2,32($sp)
	srl	$2,$5,31
	addu	$2,$8,$2
	sra	$2,$2,1
	sw	$2,36($sp)
	srl	$2,$3,31
	addu	$2,$6,$2
	sra	$2,$2,1
	sw	$2,40($sp)
$L1348:
	lw	$2,0($18)
	#nop
	slt	$2,$2,512
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1308
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	srl	$2,$13,31
	addu	$2,$14,$2
	sra	$2,$2,1
	sw	$2,16($sp)
	srl	$2,$11,31
	addu	$2,$12,$2
	sra	$2,$2,1
	sw	$2,20($sp)
	srl	$2,$9,31
	addu	$2,$10,$2
	sra	$2,$2,1
	sw	$2,24($sp)
$L1335:
	li	$16,1			# 0x00000001
$L1308:
	lw	$2,160($19)
	lw	$3,16($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,160($19)
	lw	$2,164($19)
	lw	$3,20($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,164($19)
	lw	$2,168($19)
	lw	$3,24($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,168($19)
	lw	$2,160($18)
	lw	$3,32($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,160($18)
	lw	$2,164($18)
	lw	$3,36($sp)
	#nop
	addu	$2,$2,$3
	sw	$2,164($18)
	lw	$2,168($18)
	lw	$3,40($sp)
	addu	$21,$21,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L1267
	sw	$2,168($18)
	.set	macro
	.set	reorder

$L1268:
$L1351:
	lw	$31,172($sp)
	lw	$fp,168($sp)
	lw	$23,164($sp)
	lw	$22,160($sp)
	lw	$21,156($sp)
	lw	$20,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
	.text
	.ent	Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0:
	.frame	$sp,72,$31		# vars= 32, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$17,52($sp)
	move	$17,$4
	sw	$18,56($sp)
	move	$18,$5
	addu	$6,$sp,16
	sw	$19,60($sp)
	addu	$19,$sp,32
	move	$7,$19
	sw	$31,68($sp)
	sw	$20,64($sp)
	sw	$16,48($sp)
	sw	$0,400($17)
	.set	noreorder
	.set	nomacro
	jal	Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
	sw	$0,400($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1359
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1370
	move	$2,$0
	.set	macro
	.set	reorder

$L1359:
	move	$5,$18
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
	move	$7,$19
	.set	macro
	.set	reorder

	li	$16,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	li	$20,983040			# 0x000f0000
$L1362:
	move	$4,$17
$L1372:
	move	$5,$18
$L1373:
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2
	move	$7,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1370
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$16,$L1370
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$18
	addu	$6,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2
	move	$7,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1370
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	bne	$16,$0,$L1362
	lw	$2,1004($17)
	#nop
	beq	$2,$0,$L1367
	lw	$2,192($17)
	#nop
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1367
	move	$4,$17
	.set	macro
	.set	reorder

	li	$5,6553600			# 0x00640000
	li	$6,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L1367:
	lw	$2,1004($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1372
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,192($18)
	#nop
	slt	$2,$20,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1373
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$18
	li	$5,6553600			# 0x00640000
	li	$6,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	Newton_AddDamageZone__FP13BO_tNewtonObjiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1372
	move	$4,$17
	.set	macro
	.set	reorder

$L1370:
	lw	$31,68($sp)
	lw	$20,64($sp)
	lw	$19,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
	.text
	.ent	Collide_ClearCollisionRegistry__Fv
Collide_ClearCollisionRegistry__Fv:
	.frame	$sp,80,$31		# vars= 32, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$19,60($sp)
	move	$19,$0
	lui	$2,%hi(InfiniteMassNewton+160) # high
	sw	$22,72($sp)
	addiu	$22,$2,%lo(InfiniteMassNewton+160) # low
	sw	$21,68($sp)
	addu	$21,$22,-152
	lui	$2,%hi(Collide_gRegistry) # high
	sw	$20,64($sp)
	addiu	$20,$2,%lo(Collide_gRegistry) # low
	sw	$18,56($sp)
	move	$18,$22
	sw	$17,52($sp)
	move	$17,$19
	sw	$31,76($sp)
	sw	$16,48($sp)
	sw	$0,Collide_gNumRegistered
$L1375:
	jal	Object_GetNumIMassObjects__Fv
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1376
	move	$4,$19
	.set	macro
	.set	reorder

	move	$5,$18
	addu	$6,$22,80
	addu	$7,$22,12
	addu	$6,$17,$6
	.set	noreorder
	.set	nomacro
	jal	Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
	addu	$7,$17,$7
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$2,$22,-160
	lw	$3,Collide_gNumRegistered
	addu	$16,$17,$2
	sw	$0,276($16)
	sw	$0,280($16)
	sw	$0,284($16)
	sw	$16,0($20)
	addu	$3,$3,1
	sw	$3,Collide_gNumRegistered
	.set	noreorder
	.set	nomacro
	jal	BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
	move	$5,$21
	.set	macro
	.set	reorder

	lh	$3,8($16)
	lw	$2,BWorldSm_slices
	lw	$5,160($16)
	sll	$3,$3,5
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	subu	$5,$5,$2
	sw	$5,16($sp)
	lw	$4,164($16)
	lw	$2,0($3)
	#nop
	subu	$8,$4,$2
	sw	$8,20($sp)
	lw	$4,168($16)
	lw	$2,0($3)
	#nop
	subu	$10,$4,$2
	sw	$10,24($sp)
	lb	$2,18($3)
	#nop
	sll	$6,$2,9
	sw	$6,32($sp)
	lb	$2,19($3)
	#nop
	sll	$7,$2,9
	sw	$7,36($sp)
	lb	$2,20($3)
	#nop
	sll	$9,$2,9
	.set	noreorder
	.set	nomacro
	bgez	$5,$L1379
	sw	$9,40($sp)
	.set	macro
	.set	reorder

	addu	$5,$5,255
$L1379:
	move	$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1380
	sra	$5,$5,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1380:
	sra	$2,$2,8
	mult	$5,$2
	move	$4,$8
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1388
	move	$2,$7
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1388:
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1382
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1382:
	sra	$2,$2,8
	mult	$4,$2
	move	$4,$10
	mflo	$11
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L1383
	addu	$5,$3,$11
	.set	macro
	.set	reorder

	addu	$4,$4,255
$L1383:
	move	$2,$9
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1384
	sra	$4,$4,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L1384:
	sra	$2,$2,8
	mult	$4,$2
	addu	$21,$21,576
	addu	$20,$20,4
	addu	$18,$18,576
	addu	$17,$17,576
	addu	$19,$19,1
	mflo	$11
	#nop
	#nop
	addu	$2,$5,$11
	.set	noreorder
	.set	nomacro
	j	$L1375
	sw	$2,196($16)
	.set	macro
	.set	reorder

$L1376:
	move	$3,$0
	lw	$4,Cars_gNumCars
$L1385:
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1385
	addu	$3,$3,1
	.set	macro
	.set	reorder

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

	.end	Collide_ClearCollisionRegistry__Fv
	.text
	.ent	Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$18,40($sp)
	move	$18,$4
	sw	$31,48($sp)
	sw	$19,44($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lw	$4,0($5)
	lw	$2,160($18)
	#nop
	subu	$4,$4,$2
	sw	$4,16($sp)
	lw	$2,8($5)
	lw	$3,168($18)
	sw	$0,20($sp)
	subu	$2,$2,$3
	sw	$2,24($sp)
	lw	$5,240($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$19,$6
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	lw	$5,244($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,248($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	blez	$16,$L1390
	lw	$4,16($sp)
	lw	$5,240($18)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,244($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,248($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	j	$L1391
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L1390:
	lw	$4,16($sp)
	lw	$5,240($18)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,244($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,248($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	subu	$16,$0,$16
$L1391:
	lw	$2,308($18)
	#nop
	addu	$2,$2,$19
	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1396
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,264($18)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,268($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,272($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	blez	$16,$L1393
	lw	$4,16($sp)
	lw	$5,264($18)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,268($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,272($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	.set	noreorder
	.set	nomacro
	j	$L1394
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L1393:
	lw	$4,16($sp)
	lw	$5,264($18)
	jal	fixedmult
	lw	$4,20($sp)
	lw	$5,268($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$4,24($sp)
	lw	$5,272($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$17
	addu	$16,$16,$2
	subu	$16,$0,$16
$L1394:
	lw	$2,316($18)
	#nop
	addu	$2,$2,$19
	slt	$2,$2,$16
	xori	$2,$2,0x0001
$L1396:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
	.text
	.ent	Collide_CheckMeForCollisions__FP13BO_tNewtonObj
Collide_CheckMeForCollisions__FP13BO_tNewtonObj:
	.frame	$sp,176,$31		# vars= 120, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,176
	sw	$18,144($sp)
	move	$18,$4
	sw	$31,168($sp)
	sw	$23,164($sp)
	sw	$22,160($sp)
	sw	$21,156($sp)
	sw	$20,152($sp)
	sw	$19,148($sp)
	sw	$17,140($sp)
	sw	$16,136($sp)
	lbu	$2,145($18)
	#nop
	beq	$2,$0,$L1398
	lbu	$2,144($18)
	#nop
	beq	$2,$0,$L1399
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	j	$L1398
$L1399:
	lw	$2,412($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1401
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	sw	$2,412($18)
$L1401:
	lw	$2,412($18)
	#nop
	bne	$2,$0,$L1402
	lw	$2,444($18)
	#nop
	andi	$2,$2,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1402
	addu	$4,$18,8
	.set	macro
	.set	reorder

	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi
	addu	$6,$sp,120
	.set	macro
	.set	reorder

	move	$21,$0
	li	$23,1			# 0x00000001
	addu	$22,$sp,48
$L1403:
	lw	$2,120($sp)
	#nop
	slt	$2,$21,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1402
	li	$20,655360			# 0x000a0000
	.set	macro
	.set	reorder

	li	$19,-1			# 0xffffffff
	addu	$4,$sp,16
	move	$5,$21
	addu	$6,$sp,32
	addu	$7,$sp,124
	.set	noreorder
	.set	nomacro
	jal	Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
	sw	$23,128($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$21
	addu	$6,$sp,128
	.set	noreorder
	.set	nomacro
	jal	Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef
	addu	$7,$sp,48
	.set	macro
	.set	reorder

	lw	$2,128($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L1406
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$22
$L1407:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	Math_DistXZ__FP8coorddefT0
	addu	$5,$18,160
	.set	macro
	.set	reorder

	lw	$3,124($sp)
	lw	$4,320($18)
	move	$5,$2
	addu	$3,$3,$4
	slt	$3,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L1410
	slt	$2,$5,$20
	.set	macro
	.set	reorder

	beq	$2,$0,$L1410
	move	$20,$5
	move	$19,$16
$L1410:
	lw	$2,128($sp)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1407
	addu	$17,$17,12
	.set	macro
	.set	reorder

$L1406:
	.set	noreorder
	.set	nomacro
	bltz	$19,$L1413
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$6,124($sp)
	sll	$5,$19,1
	addu	$5,$5,$19
	sll	$5,$5,2
	.set	noreorder
	.set	nomacro
	jal	Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
	addu	$5,$22,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1413
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$5,$21
	.set	noreorder
	.set	nomacro
	jal	Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj
	move	$6,$18
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L1413
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$5,$21
	addu	$6,$sp,32
	.set	noreorder
	.set	nomacro
	jal	Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi
	addu	$7,$sp,124
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$17,$23,$L1416
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	sw	$0,92($sp)
	lw	$2,160($18)
	lw	$3,32($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,88($sp)
	lw	$2,168($18)
	lw	$3,40($sp)
	addu	$4,$sp,88
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeShortVector__FP8coorddef
	sw	$2,96($sp)
	.set	macro
	.set	reorder

	lw	$3,124($sp)
	move	$16,$0
	.set	noreorder
	.set	nomacro
	bgez	$3,$L1417
	move	$4,$3
	.set	macro
	.set	reorder

	addu	$3,$3,255
$L1417:
	lw	$2,88($sp)
	sra	$3,$3,8
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1459
	sra	$6,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$6,$2,8
$L1459:
	sw	$6,104($sp)
	lw	$2,92($sp)
	#nop
	mult	$3,$2
	mflo	$2
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L1460
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$5,$2,8
$L1460:
	sw	$5,108($sp)
	lw	$2,96($sp)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	bgez	$3,$L1422
	addu	$3,$3,255
$L1422:
	lw	$2,32($sp)
	lw	$4,40($sp)
	sra	$3,$3,8
	sw	$3,112($sp)
	addu	$2,$6,$2
	sw	$2,104($sp)
	lw	$2,36($sp)
	addu	$3,$3,$4
	sw	$3,112($sp)
	addu	$2,$5,$2
	sw	$2,108($sp)
	lw	$3,192($18)
	li	$2,2621440			# 0x00280000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1423
	sll	$2,$3,1
	.set	macro
	.set	reorder

	move	$16,$2
	li	$2,9830400			# 0x00960000
	slt	$2,$2,$16
	beq	$2,$0,$L1426
	.set	noreorder
	.set	nomacro
	j	$L1426
	li	$16,9830400			# 0x00960000
	.set	macro
	.set	reorder

$L1423:
	li	$2,1638400			# 0x00190000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1427
	li	$2,1966080			# 0x001e0000
	.set	macro
	.set	reorder

	move	$16,$3
 #APP
 #NO_APP
	slt	$2,$16,$2
	beq	$2,$0,$L1426
	.set	noreorder
	.set	nomacro
	j	$L1426
	li	$16,1966080			# 0x001e0000
	.set	macro
	.set	reorder

$L1427:
	sw	$17,frictionLess
$L1426:
	move	$4,$18
	addu	$5,$sp,88
	.set	noreorder
	.set	nomacro
	jal	Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
	addu	$6,$sp,104
	.set	macro
	.set	reorder

	lw	$5,88($sp)
	lw	$6,92($sp)
	lw	$7,96($sp)
	sw	$0,frictionLess
	.set	noreorder
	.set	nomacro
	jal	Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef
	move	$4,$18
	.set	macro
	.set	reorder

	sw	$16,400($18)
	move	$2,$16
	sw	$23,396($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1413
	sw	$0,404($18)
	.set	macro
	.set	reorder

	li	$2,327680			# 0x00050000
	ori	$2,$2,0x0001
	sw	$2,408($18)
	lw	$8,160($18)
	lw	$9,164($18)
	lw	$10,168($18)
	sw	$8,416($18)
	sw	$9,420($18)
	sw	$10,424($18)
	.set	noreorder
	.set	nomacro
	j	$L1403
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L1416:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1431
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,192($18)
	li	$2,131072			# 0x00020000
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L1413
	li	$3,393216			# 0x00060000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L1455
	ori	$3,$3,0x0006
	.set	macro
	.set	reorder

$L1431:
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L1413
	li	$3,393216			# 0x00060000
	.set	macro
	.set	reorder

	ori	$3,$3,0x0005
$L1455:
	li	$2,983040			# 0x000f0000
	sw	$2,400($18)
	sw	$3,408($18)
	sw	$0,404($18)
	lw	$8,160($18)
	lw	$9,164($18)
	lw	$10,168($18)
	sw	$8,416($18)
	sw	$9,420($18)
	sw	$10,424($18)
	.set	noreorder
	.set	nomacro
	jal	Force_IsForceOn__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

	beq	$2,$0,$L1413
	.set	noreorder
	.set	nomacro
	jal	Force_HitSign__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1413:
	.set	noreorder
	.set	nomacro
	j	$L1403
	addu	$21,$21,1
	.set	macro
	.set	reorder

$L1402:
	lw	$2,444($18)
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L1437
	.set	noreorder
	.set	nomacro
	jal	Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1437:
	lhu	$2,380($18)
	#nop
	beq	$2,$0,$L1438
	.set	noreorder
	.set	nomacro
	jal	Physics_TestForBarrierCollision__FP8Car_tObj
	move	$4,$18
	.set	macro
	.set	reorder

$L1438:
	lw	$2,412($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1398
	move	$17,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(Collide_gRegistry) # high
	lw	$3,Collide_gNumRegistered
	addiu	$4,$2,%lo(Collide_gRegistry) # low
	sll	$2,$3,2
	addu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	blez	$3,$L1440
	sw	$18,0($2)
	.set	macro
	.set	reorder

	move	$19,$4
$L1441:
	lw	$16,0($19)
	lw	$3,320($18)
	lw	$5,168($18)
	lw	$2,320($16)
	lw	$4,168($16)
	addu	$3,$3,$2
	subu	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1461
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	subu	$2,$4,$5
	slt	$2,$2,$3
$L1461:
	beq	$2,$0,$L1444
	lw	$3,320($18)
	lw	$2,320($16)
	lw	$5,160($18)
	lw	$4,160($16)
	addu	$3,$3,$2
	subu	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1462
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	subu	$2,$4,$5
	slt	$2,$2,$3
$L1462:
	beq	$2,$0,$L1444
	lw	$3,320($18)
	lw	$2,320($16)
	lw	$5,164($18)
	lw	$4,164($16)
	addu	$3,$3,$2
	subu	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L1463
	slt	$2,$2,$3
	.set	macro
	.set	reorder

	subu	$2,$4,$5
	slt	$2,$2,$3
$L1463:
	beq	$2,$0,$L1444
	li	$4,393216			# 0x00060000
	lw	$5,276($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$4,$4,0x487e
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,280($18)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($18)
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,284($18)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($18)
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	sw	$2,284($18)
	lw	$5,276($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	ori	$4,$4,0x487e
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,280($16)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($16)
	.set	macro
	.set	reorder

	li	$4,393216			# 0x00060000
	lw	$5,284($16)
	ori	$4,$4,0x487e
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($16)
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0
	sw	$2,284($16)
	.set	macro
	.set	reorder

	lw	$5,276($18)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,10430			# 0x000028be
	.set	macro
	.set	reorder

	lw	$5,280($18)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($18)
	.set	macro
	.set	reorder

	lw	$5,284($18)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($18)
	.set	macro
	.set	reorder

	sw	$2,284($18)
	lw	$5,276($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$4,10430			# 0x000028be
	.set	macro
	.set	reorder

	lw	$5,280($16)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,276($16)
	.set	macro
	.set	reorder

	lw	$5,284($16)
	li	$4,10430			# 0x000028be
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sw	$2,280($16)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	Collide_LimitAngularVel__FP13BO_tNewtonObj
	sw	$2,284($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Collide_LimitAngularVel__FP13BO_tNewtonObj
	move	$4,$16
	.set	macro
	.set	reorder

$L1444:
	lw	$2,Collide_gNumRegistered
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1441
	addu	$19,$19,4
	.set	macro
	.set	reorder

$L1440:
 #APP
 #NO_APP
	lw	$2,Collide_gNumRegistered
	#nop
	addu	$2,$2,1
	sw	$2,Collide_gNumRegistered
$L1398:
 #APP
 #NO_APP
	lw	$31,168($sp)
	lw	$23,164($sp)
	lw	$22,160($sp)
	lw	$21,156($sp)
	lw	$20,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,176
	.set	macro
	.set	reorder

	.end	Collide_CheckMeForCollisions__FP13BO_tNewtonObj
