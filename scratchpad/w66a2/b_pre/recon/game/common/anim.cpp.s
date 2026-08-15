	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\anim.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Anim_Restart__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"%sA.viv\000"
	.align	2
$LC1:
	.ascii	"animScripts\000"
	.sdata
	.align	2
$LC2:
	.ascii	"Tr\000"
	.rdata
	.align	2
$LC3:
	.ascii	"tr00a%02d.can\000"
	.text
	.align	2
	.globl	Anim_InitSystem__FPc
	.align	2
	.globl	Anim_DeInitSystem__Fv
	.align	2
	.globl	Anim_Handle__Fi
	.align	2
	.globl	Anim_FreeHandle__Fi
	.align	2
	.globl	Anim_GetAnim__Fi
	.align	2
	.globl	Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
	.align	2
	.globl	Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
	.align	2
	.globl	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
	.align	2
	.globl	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
	.align	2
	.globl	__10AnimScripti
	.align	2
	.globl	__10AnimScriptii
	.align	2
	.globl	__10AnimScriptP5Groupiii
	.align	2
	.globl	SetAnimAttrib__10AnimScripti
	.align	2
	.globl	GetAnimFrameInfo__10AnimScriptPiT1
	.align	2
	.globl	GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
	.align	2
	.globl	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	.align	2
	.globl	GetStatus__10AnimScript
	.globl	animSlots
	.data
	.align	2
animSlots:
	.space	128
	.globl	Anim_gInstanceFromIndex
	.align	2
Anim_gInstanceFromIndex:
	.space	128
	.globl	animScripts
	.align	2
animScripts:
	.space	40

	.extern	simGlobal, 24
	.extern	gPersistObjInst, 4

	.text
	.text
	.ent	Anim_Restart__Fv
Anim_Restart__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(animSlots) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(animSlots) # low
	sw	$18,24($sp)
	addu	$18,$17,128
	sw	$31,28($sp)
	sw	$16,16($sp)
$L601:
	slt	$2,$17,$18
	beq	$2,$0,$L603
	lw	$16,0($17)
	#nop
	beq	$16,$0,$L604
	lw	$4,16($16)
	#nop
	beq	$4,$0,$L605
	jal	__builtin_vec_delete
$L605:
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$16
	.set	macro
	.set	reorder

$L604:
	sw	$0,0($17)
	.set	noreorder
	.set	nomacro
	j	$L601
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L603:
	jal	DrawW_ResetAnimationTimer__Fv
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

	.end	Anim_Restart__Fv
	.text
	.ent	Anim_InitSystem__FPc
Anim_InitSystem__FPc:
	.frame	$sp,120,$31		# vars= 80, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$19,108($sp)
	move	$19,$4
	sw	$31,112($sp)
	sw	$18,104($sp)
	sw	$17,100($sp)
	.set	noreorder
	.set	nomacro
	jal	Anim_Restart__Fv
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$19
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L608
	li	$16,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	lui	$5,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

	move	$4,$17
	move	$18,$2
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	blockmove
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	jal	strstr
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	move	$16,$0
	lui	$19,%hi($LC3) # high
	lui	$2,%hi(animScripts) # high
	addiu	$17,$2,%lo(animScripts) # low
$L612:
	addu	$4,$sp,16
	addiu	$5,$19,%lo($LC3) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	locatebig
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	sw	$2,0($17)
	addu	$16,$16,1
	slt	$2,$16,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$17,$17,4
	.set	macro
	.set	reorder

	j	$L614
$L608:
	lui	$2,%hi(animScripts) # high
	addiu	$2,$2,%lo(animScripts) # low
	addu	$2,$2,36
$L618:
	sw	$0,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L618
	addu	$2,$2,-4
	.set	macro
	.set	reorder

$L614:
	lw	$2,gPersistObjInst
	#nop
	beq	$2,$0,$L620
	lw	$4,0($2)
	addu	$3,$2,4
	li	$2,-1			# 0xffffffff
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L620
	lui	$2,%hi(Anim_gInstanceFromIndex) # high
	.set	macro
	.set	reorder

	li	$8,3			# 0x00000003
	li	$7,7			# 0x00000007
	addiu	$6,$2,%lo(Anim_gInstanceFromIndex) # low
	li	$5,-1			# 0xffffffff
$L623:
	lbu	$2,2($3)
	#nop
	beq	$2,$8,$L625
	bne	$2,$7,$L624
$L625:
	lbu	$2,3($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	sll	$2,$2,2
	.set	macro
	.set	reorder

	addu	$2,$2,$6
	sw	$3,0($2)
$L624:
	lh	$2,0($3)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bne	$4,$5,$L623
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L620:
	lw	$31,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	Anim_InitSystem__FPc
	.text
	.ent	Anim_DeInitSystem__Fv
Anim_DeInitSystem__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,9			# 0x00000009
	addu	$3,$3,-1
$L638:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L638
	addu	$3,$3,-1
	.set	macro
	.set	reorder

	li	$3,31			# 0x0000001f
	lui	$2,%hi(Anim_gInstanceFromIndex) # high
	addiu	$2,$2,%lo(Anim_gInstanceFromIndex) # low
	addu	$2,$2,124
$L633:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L633
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	j	$31
	.end	Anim_DeInitSystem__Fv
	.text
	.ent	Anim_Handle__Fi
Anim_Handle__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$0
	lui	$2,%hi(animSlots) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(animSlots) # low
	move	$3,$17
	sw	$31,28($sp)
$L644:
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L641
	addu	$16,$16,1
	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L644
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L641:
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__10AnimScripti
	move	$5,$18
	.set	macro
	.set	reorder

	sll	$3,$16,2
	addu	$3,$3,$17
	sw	$2,0($3)
	move	$2,$16
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

	.end	Anim_Handle__Fi
	.text
	.ent	Anim_FreeHandle__Fi
Anim_FreeHandle__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	lui	$3,%hi(animSlots) # high
	addiu	$3,$3,%lo(animSlots) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	sw	$31,24($sp)
	sw	$16,16($sp)
	lw	$16,0($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L648
	lui	$3,%hi(animSlots) # high
	.set	macro
	.set	reorder

	lw	$4,16($16)
	#nop
	beq	$4,$0,$L647
	jal	__builtin_vec_delete
$L647:
	.set	noreorder
	.set	nomacro
	jal	__builtin_delete
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$3,%hi(animSlots) # high
$L648:
	addiu	$3,$3,%lo(animSlots) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	sw	$0,0($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Anim_FreeHandle__Fi
	.text
	.ent	Anim_GetAnim__Fi
Anim_GetAnim__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(animSlots) # high
	addiu	$2,$2,%lo(animSlots) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	lw	$2,0($4)
	j	$31
	.end	Anim_GetAnim__Fi
	.text
	.ent	Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	lh	$3,8($4)
	addu	$4,$4,12
	addu	$3,$3,-1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	addu	$4,$sp,16
	lwl	$7,15($2)
	lwr	$7,12($2)
	lwl	$8,19($2)
	lwr	$8,16($2)
	swl	$7,19($sp)
	swr	$7,16($sp)
	swl	$8,23($sp)
	swr	$8,20($sp)
	lw	$7,0($2)
	lw	$8,4($2)
	lw	$9,8($2)
	sw	$7,0($5)
	sw	$8,4($5)
	sw	$9,8($5)
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	move	$5,$6
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
	.text
	.ent	Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$7
	lui	$2,%hi(animScripts) # high
	addiu	$2,$2,%lo(animScripts) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	move	$5,$6
	sw	$31,24($sp)
	lw	$4,0($4)
	.set	noreorder
	.set	nomacro
	jal	Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
	move	$6,$17
	.set	macro
	.set	reorder

	andi	$16,$16,0x0004
	beq	$16,$0,$L652
	lw	$7,12($17)
	lw	$2,24($17)
	lw	$3,28($17)
	subu	$5,$0,$7
	lw	$7,16($17)
	lw	$4,32($17)
	subu	$6,$0,$7
	lw	$7,20($17)
	sw	$2,12($17)
	sw	$5,24($17)
	sw	$3,16($17)
	sw	$6,28($17)
	sw	$4,20($17)
	subu	$2,$0,$7
	sw	$2,32($17)
$L652:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef
	.text
	.ent	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef:
	.frame	$sp,96,$31		# vars= 56, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	move	$9,$6
	sw	$31,92($sp)
	sw	$16,88($sp)
	lbu	$3,2($4)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L655
	move	$10,$7
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L654
	addu	$8,$4,16
	.set	macro
	.set	reorder

$L655:
	addu	$8,$4,12
$L654:
	lhu	$3,10($4)
	#nop
	addu	$2,$3,-1
	sltu	$2,$2,400
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L657
	sll	$2,$3,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L658
	sra	$3,$2,16
	.set	macro
	.set	reorder

$L657:
	li	$3,6			# 0x00000006
$L658:
	andi	$5,$5,0x0002
	div	$6,$9,$3
	beq	$5,$0,$L659
	lh	$2,8($4)
	#nop
	addu	$2,$2,-1
	slt	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	move	$2,$0
	.set	macro
	.set	reorder

$L659:
	rem	$7,$9,$3
	lh	$2,8($4)
	#nop
	addu	$2,$2,-1
	rem	$6,$6,$2
	sll	$7,$7,16
	div	$7,$7,$3
	addu	$4,$sp,72
	addu	$5,$sp,80
	addu	$16,$sp,64
	sll	$3,$6,2
	addu	$3,$3,$6
	sll	$3,$3,2
	addu	$3,$3,$8
	addu	$6,$6,1
	sll	$2,$6,2
	addu	$2,$2,$6
	sll	$2,$2,2
	addu	$2,$2,$8
	addu	$6,$sp,32
	lwl	$11,15($3)
	lwr	$11,12($3)
	lwl	$12,19($3)
	lwr	$12,16($3)
	swl	$11,75($sp)
	swr	$11,72($sp)
	swl	$12,79($sp)
	swr	$12,76($sp)
	lwl	$11,15($2)
	lwr	$11,12($2)
	lwl	$12,19($2)
	lwr	$12,16($2)
	swl	$11,83($sp)
	swr	$11,80($sp)
	swl	$12,87($sp)
	swr	$12,84($sp)
	lw	$11,0($3)
	lw	$12,4($3)
	lw	$13,8($3)
	sw	$11,32($sp)
	sw	$12,36($sp)
	sw	$13,40($sp)
	lw	$11,0($2)
	lw	$12,4($2)
	lw	$13,8($2)
	sw	$11,48($sp)
	sw	$12,52($sp)
	sw	$13,56($sp)
	sw	$16,20($sp)
	sw	$10,24($sp)
	sw	$7,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
	addu	$7,$sp,48
	.set	macro
	.set	reorder

	lw	$5,112($sp)
	.set	noreorder
	.set	nomacro
	jal	Quatern_QuatToMat__FP5tQuatP10matrixtdef
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L660:
	lw	$31,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
	.text
	.ent	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4:
	.frame	$sp,72,$31		# vars= 32, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,56($sp)
	move	$18,$4
	sw	$17,52($sp)
	move	$17,$6
	sw	$31,68($sp)
	sw	$20,64($sp)
	sw	$19,60($sp)
	sw	$16,48($sp)
	lhu	$3,10($18)
	lw	$19,88($sp)
	lw	$20,92($sp)
	addu	$2,$3,-1
	sltu	$2,$2,400
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L662
	addu	$4,$18,12
	.set	macro
	.set	reorder

	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	j	$L663
	sra	$16,$2,16
	.set	macro
	.set	reorder

$L662:
	li	$16,6			# 0x00000006
$L663:
	andi	$5,$5,0x0002
	div	$3,$17,$16
	beq	$5,$0,$L664
	lh	$2,8($18)
	#nop
	addu	$2,$2,-1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	move	$2,$0
	.set	macro
	.set	reorder

$L664:
	rem	$6,$17,$16
	lh	$2,8($18)
	#nop
	addu	$2,$2,-1
	rem	$3,$3,$2
	sll	$6,$6,16
	div	$6,$6,$16
	addu	$5,$sp,32
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	addu	$3,$3,1
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,16($sp)
	sw	$9,20($sp)
	sw	$10,24($sp)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$4
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	sw	$8,32($sp)
	sw	$9,36($sp)
	sw	$10,40($sp)
	.set	noreorder
	.set	nomacro
	jal	Quatern_VecInterpolate__FP8coorddefT0iT0
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	beq	$19,$0,$L665
	lh	$2,8($18)
	#nop
	addu	$2,$2,-1
	mult	$2,$16
	mflo	$3
	#nop
	#nop
	rem	$2,$17,$3
	sw	$2,0($19)
$L665:
	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L667
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lh	$2,8($18)
	#nop
	addu	$2,$2,-1
	mult	$2,$16
	mflo	$8
	#nop
	#nop
	sw	$8,0($20)
	li	$2,1			# 0x00000001
$L667:
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

	.end	Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
	.text
	.ent	__10AnimScripti
__10AnimScripti:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__builtin_vec_new
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$2
	lui	$2,%hi(animScripts) # high
	addiu	$2,$2,%lo(animScripts) # low
	sll	$16,$16,2
	addu	$16,$16,$2
	sw	$4,16($17)
	lw	$3,0($16)
	move	$2,$17
	sw	$3,0($4)
	lui	$3,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($3)
	li	$3,6			# 0x00000006
	sw	$3,8($2)
	sw	$4,0($2)
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

	.end	__10AnimScripti
	.text
	.ent	__10AnimScriptii
__10AnimScriptii:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__builtin_vec_new
	sll	$4,$16,2
	.set	macro
	.set	reorder

	move	$5,$0
	.set	noreorder
	.set	nomacro
	blez	$16,$L671
	sw	$2,16($17)
	.set	macro
	.set	reorder

	lui	$2,%hi(animScripts) # high
	addiu	$6,$2,%lo(animScripts) # low
	sll	$4,$5,2
$L677:
	addu	$2,$18,$5
	addu	$5,$5,1
	sll	$2,$2,2
	addu	$2,$2,$6
	lw	$3,16($17)
	lw	$2,0($2)
	addu	$4,$4,$3
	sw	$2,0($4)
	slt	$2,$5,$16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L677
	sll	$4,$5,2
	.set	macro
	.set	reorder

$L671:
	move	$2,$17
	lui	$3,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($3)
	li	$3,6			# 0x00000006
	sw	$3,8($2)
	sw	$4,0($2)
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

	.end	__10AnimScriptii
	.text
	.ent	__10AnimScriptP5Groupiii
__10AnimScriptP5Groupiii:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	lw	$4,56($sp)
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$16,16($sp)
	addu	$16,$5,4
	sw	$31,36($sp)
	sw	$17,20($sp)
	lw	$17,0($5)
	.set	noreorder
	.set	nomacro
	jal	__builtin_vec_new
	sll	$4,$4,2
	.set	macro
	.set	reorder

	addu	$17,$17,-1
	sw	$2,16($18)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L679
	move	$4,$0
	.set	macro
	.set	reorder

	move	$5,$2
$L680:
	lbu	$2,2($16)
	#nop
	bne	$2,$19,$L683
	lbu	$2,13($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L683
	sll	$2,$4,2
	.set	macro
	.set	reorder

	lw	$3,16($18)
	addu	$4,$4,1
	addu	$2,$2,$3
	sw	$16,0($2)
$L683:
	lh	$2,0($16)
	addu	$17,$17,-1
	.set	noreorder
	.set	nomacro
	bne	$17,$5,$L680
	addu	$16,$16,$2
	.set	macro
	.set	reorder

$L679:
	move	$2,$18
	lui	$3,%hi(simGlobal+4) # high
	lw	$4,%lo(simGlobal+4)($3)
	li	$3,6			# 0x00000006
	sw	$3,8($2)
	sw	$4,0($2)
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

	.end	__10AnimScriptP5Groupiii
	.text
	.ent	SetAnimAttrib__10AnimScripti
SetAnimAttrib__10AnimScripti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,8($4)
	.set	macro
	.set	reorder

	.end	SetAnimAttrib__10AnimScripti
	.text
	.ent	GetAnimFrameInfo__10AnimScriptPiT1
GetAnimFrameInfo__10AnimScriptPiT1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$5
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,16($4)
	lw	$5,%lo(simGlobal+4)($2)
	lw	$7,0($3)
	lw	$2,0($4)
	lhu	$4,10($7)
	subu	$3,$5,$2
	addu	$2,$4,-1
	sltu	$2,$2,400
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L688
	sll	$2,$4,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L689
	sra	$2,$2,16
	.set	macro
	.set	reorder

$L688:
	li	$2,6			# 0x00000006
$L689:
	div	$3,$3,$2
	lh	$2,8($7)
	#nop
	addu	$2,$2,-1
	rem	$2,$3,$2
	sw	$2,0($8)
	lh	$2,8($7)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder

	.end	GetAnimFrameInfo__10AnimScriptPiT1
	.text
	.ent	GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$2,$5
	move	$7,$6
	move	$5,$0
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	move	$6,$2
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

	.end	GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
	.text
	.ent	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,28($sp)
	move	$17,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$16,24($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	GetStatus__10AnimScript
	move	$16,$7
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L695
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$3,%hi(simGlobal+4) # high
	lw	$5,0($17)
	lw	$2,16($17)
	lw	$6,%lo(simGlobal+4)($3)
	sll	$18,$18,2
	sw	$16,16($sp)
	addu	$2,$18,$2
	subu	$6,$6,$5
	lw	$4,0($2)
	lw	$5,8($17)
	.set	noreorder
	.set	nomacro
	jal	Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
	move	$7,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L693
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,16($17)
	li	$4,-1			# 0xffffffff
	sw	$4,0($17)
	addu	$3,$18,$3
	.set	noreorder
	.set	nomacro
	j	$L695
	sw	$0,0($3)
	.set	macro
	.set	reorder

$L693:
	lw	$2,8($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$7,12($16)
	lw	$2,24($16)
	lw	$3,28($16)
	subu	$5,$0,$7
	lw	$7,16($16)
	lw	$4,32($16)
	subu	$6,$0,$7
	lw	$7,20($16)
	sw	$2,12($16)
	sw	$5,24($16)
	sw	$3,16($16)
	sw	$6,28($16)
	sw	$4,20($16)
	subu	$2,$0,$7
	sw	$2,32($16)
	li	$2,1			# 0x00000001
$L695:
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

	.end	GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
	.text
	.ent	GetStatus__10AnimScript
GetStatus__10AnimScript:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($4)
	#nop
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$0,$2
	.set	macro
	.set	reorder

	.end	GetStatus__10AnimScript
