	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\trgsfx.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	TrgSfx_AddEnviroEffect__FiiP8coorddefT2
	.align	2
	.globl	TrgSfx_AddCarSfx__FiP8coorddefiT1
	.align	2
	.globl	TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
	.align	2
	.globl	TrgSfx_AddCarExtraCheck__Fii
	.align	2
	.globl	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	.align	2
	.globl	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	.align	2
	.globl	TrgSfx_CrashCar__FP8coorddef
	.align	2
	.globl	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	.align	2
	.globl	TrgSfx_InitTrgSfx__Fv
	.align	2
	.globl	TrgSfx_RestartTrgSfx__Fv
	.align	2
	.globl	TrgSfx_KillTrgSfx__Fv
	.globl	gTAddCarWheelDelay
	.sdata
	.align	2
gTAddCarWheelDelay:
	.space	4
	.globl	gTAddCSmoke
	.align	2
gTAddCSmoke:
	.space	4

	.extern	GameSetup_gData, 2600
	.extern	gSaveChunk, 128
	.extern	gSaveSeg, 128
	.extern	gPrevSkidSm, 896
	.extern	gStatusSm, 128
	.extern	gTAddCarExtraSfx, 128
	.extern	gTAddCarWheelSfx, 128
	.extern	gTAddCarSfx, 32
	.extern	gTEnviroEffect, 32
	.extern	simGlobal, 24

	.text
	.text
	.ent	TrgSfx_AddEnviroEffect__FiiP8coorddefT2
TrgSfx_AddEnviroEffect__FiiP8coorddefT2:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	andi	$4,$4,0x0007
	lui	$3,%hi(simGlobal+4) # high
	lui	$2,%hi(gTEnviroEffect) # high
	addiu	$2,$2,%lo(gTEnviroEffect) # low
	sll	$4,$4,2
	lw	$3,%lo(simGlobal+4)($3)
	addu	$4,$4,$2
	sw	$31,24($sp)
	lw	$2,0($4)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,11
	bne	$2,$0,$L600
	sw	$3,0($4)
	move	$4,$6
	move	$6,$7
	move	$7,$0
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L600:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TrgSfx_AddEnviroEffect__FiiP8coorddefT2
	.text
	.ent	TrgSfx_AddCarSfx__FiP8coorddefiT1
TrgSfx_AddCarSfx__FiP8coorddefiT1:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	andi	$4,$4,0x0007
	lui	$3,%hi(simGlobal+4) # high
	lui	$2,%hi(gTAddCarSfx) # high
	addiu	$2,$2,%lo(gTAddCarSfx) # low
	sll	$4,$4,2
	lw	$3,%lo(simGlobal+4)($3)
	addu	$4,$4,$2
	sw	$31,24($sp)
	lw	$2,0($4)
	#nop
	subu	$2,$3,$2
	slt	$2,$2,8
	bne	$2,$0,$L602
	sw	$3,0($4)
	move	$4,$5
	move	$5,$6
	move	$6,$7
	move	$7,$0
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L602:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TrgSfx_AddCarSfx__FiP8coorddefiT1
	.text
	.ent	TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i:
	.frame	$sp,48,$31		# vars= 16, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	andi	$4,$4,0x0007
	lui	$2,%hi(simGlobal) # high
	addiu	$8,$2,%lo(simGlobal) # low
	lui	$2,%hi(gTAddCarWheelSfx) # high
	addiu	$2,$2,%lo(gTAddCarWheelSfx) # low
	sll	$5,$5,2
	sll	$4,$4,4
	addu	$5,$5,$4
	addu	$5,$5,$2
	sw	$31,40($sp)
	lw	$3,4($8)
	lw	$4,0($5)
	lw	$2,68($sp)
	subu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$2,64($sp)
	#nop
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	sw	$9,24($sp)
	sw	$10,28($sp)
	sw	$11,32($sp)
	lw	$2,24($sp)
	addu	$6,$sp,24
	sra	$2,$2,1
	sw	$2,24($sp)
	lw	$2,32($sp)
	lw	$3,4($8)
	sra	$2,$2,1
	sw	$2,32($sp)
	sw	$3,0($5)
	move	$5,$7
	move	$7,$0
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L604:
	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i
	.text
	.ent	TrgSfx_AddCarExtraCheck__Fii
TrgSfx_AddCarExtraCheck__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$4,$4,0x0007
	lui	$3,%hi(simGlobal+4) # high
	lui	$2,%hi(gTAddCarExtraSfx) # high
	addiu	$2,$2,%lo(gTAddCarExtraSfx) # low
	sll	$5,$5,2
	sll	$4,$4,4
	addu	$5,$5,$4
	addu	$5,$5,$2
	lw	$2,%lo(simGlobal+4)($3)
	lw	$3,0($5)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TrgSfx_AddCarExtraCheck__Fii
	.text
	.ent	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii:
	.frame	$sp,48,$31		# vars= 16, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	andi	$4,$4,0x0007
	sll	$5,$5,2
	sll	$4,$4,4
	addu	$5,$5,$4
	move	$4,$6
	lw	$2,64($sp)
	lw	$3,68($sp)
	addu	$6,$sp,24
	sw	$31,40($sp)
	sra	$3,$3,3
	lw	$10,0($2)
	lw	$11,4($2)
	lw	$12,8($2)
	sw	$10,24($sp)
	sw	$11,28($sp)
	sw	$12,32($sp)
	lw	$9,72($sp)
	lw	$2,28($sp)
	lw	$8,76($sp)
	addu	$2,$2,$3
	lui	$3,%hi(gTAddCarExtraSfx) # high
	addiu	$3,$3,%lo(gTAddCarExtraSfx) # low
	sw	$2,28($sp)
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	addu	$5,$5,$3
	sw	$2,0($5)
	move	$5,$7
	move	$7,$0
	sw	$9,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$8,20($sp)
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii
	.text
	.ent	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
TrgSfx_AddCarSplash__FiiP8coorddefiT2ii:
	.frame	$sp,48,$31		# vars= 16, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	andi	$4,$4,0x0007
	lui	$2,%hi(simGlobal) # high
	addiu	$8,$2,%lo(simGlobal) # low
	lui	$2,%hi(gTAddCarWheelSfx) # high
	addiu	$2,$2,%lo(gTAddCarWheelSfx) # low
	sll	$5,$5,2
	sll	$4,$4,4
	addu	$5,$5,$4
	addu	$5,$5,$2
	sw	$31,40($sp)
	lw	$3,4($8)
	lw	$4,0($5)
	lw	$2,68($sp)
	subu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	move	$4,$6
	.set	macro
	.set	reorder

	lw	$2,64($sp)
	#nop
	lw	$9,0($2)
	lw	$10,4($2)
	lw	$11,8($2)
	sw	$9,24($sp)
	sw	$10,28($sp)
	sw	$11,32($sp)
	lw	$2,24($sp)
	#nop
	sra	$2,$2,1
	sw	$2,24($sp)
	lw	$2,32($sp)
	lw	$3,4($8)
	sra	$2,$2,1
	sw	$2,32($sp)
	sw	$3,0($5)
	move	$5,$7
	lw	$7,72($sp)
	addu	$6,$sp,24
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

$L608:
	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	TrgSfx_AddCarSplash__FiiP8coorddefiT2ii
	.text
	.ent	TrgSfx_CrashCar__FP8coorddef
TrgSfx_CrashCar__FP8coorddef:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($2)
	lw	$2,gTAddCSmoke
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	subu	$2,$3,$2
	slt	$2,$2,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	sw	$3,gTAddCSmoke
	jal	random
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	move	$6,$0
	move	$7,$6
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$2,28($3)
	#nop
	addu	$2,$2,3932
	sw	$2,28($3)
$L612:
	move	$4,$16
	li	$5,3			# 0x00000003
	move	$6,$0
	move	$7,$6
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Souffle_Add__FP8coorddefiT0iii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	move	$3,$2
	lw	$2,28($3)
	#nop
	addu	$2,$2,3932
	sw	$2,28($3)
$L610:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TrgSfx_CrashCar__FP8coorddef
	.text
	.ent	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji:
	.frame	$sp,56,$31		# vars= 8, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,40($sp)
	move	$16,$4
	sw	$17,44($sp)
	move	$17,$5
	move	$10,$6
	move	$9,$7
	lw	$7,76($sp)
	lw	$4,72($sp)
	lw	$12,80($sp)
	slt	$2,$17,2
	sw	$31,48($sp)
	lw	$11,192($7)
	lh	$13,8($7)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	addu	$5,$7,172
	.set	macro
	.set	reorder

	lw	$8,232($7)
	.set	noreorder
	.set	nomacro
	j	$L638
	li	$3,-1840709632			# 0x92490000
	.set	macro
	.set	reorder

$L614:
	lw	$8,236($7)
	li	$3,-1840709632			# 0x92490000
$L638:
	ori	$3,$3,0x2493
	sll	$2,$4,8
	subu	$2,$2,$4
	mult	$2,$3
	andi	$16,$16,0x0007
	mfhi	$14
	#nop
	#nop
	addu	$3,$14,$2
	sra	$3,$3,18
	sra	$2,$2,31
	subu	$3,$3,$2
	slt	$2,$3,256
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	li	$4,255			# 0x000000ff
	.set	macro
	.set	reorder

	move	$4,$3
$L616:
	move	$3,$4
	sll	$4,$17,2
	sb	$3,34($sp)
	sb	$3,33($sp)
	sb	$3,32($sp)
	lw	$2,0($5)
	lw	$3,0($10)
	sra	$2,$2,6
	addu	$3,$3,$2
	sw	$3,0($10)
	lw	$2,4($5)
	lw	$3,4($10)
	sra	$2,$2,6
	addu	$3,$3,$2
	sw	$3,4($10)
	lw	$2,8($5)
	lw	$3,8($10)
	sra	$2,$2,6
	addu	$6,$3,$2
	lui	$3,%hi(gStatusSm) # high
	addiu	$3,$3,%lo(gStatusSm) # low
	sll	$2,$16,4
	addu	$5,$4,$2
	addu	$4,$5,$3
	sw	$6,8($10)
	lw	$3,0($4)
	#nop
	bne	$3,$0,$L617
	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L613
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($4)
	lui	$4,%hi(gPrevSkidSm) # high
	addiu	$4,$4,%lo(gPrevSkidSm) # low
	sll	$3,$17,3
	subu	$3,$3,$17
	sll	$3,$3,2
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$4
	lwl	$15,35($sp)
	lwr	$15,32($sp)
	swl	$15,15($3)
	swr	$15,12($3)
	sw	$12,16($3)
	lw	$15,0($10)
	lw	$24,4($10)
	lw	$25,8($10)
	sw	$15,0($3)
	sw	$24,4($3)
	sw	$25,8($3)
	.set	noreorder
	.set	nomacro
	j	$L613
	sw	$0,20($3)
	.set	macro
	.set	reorder

$L617:
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L620
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L621
	sll	$4,$17,3
	.set	macro
	.set	reorder

	sll	$3,$16,3
	subu	$3,$3,$16
	sll	$3,$3,4
	sll	$6,$17,3
	subu	$6,$6,$17
	sll	$6,$6,$2
	lui	$2,%hi(gPrevSkidSm) # high
	addiu	$2,$2,%lo(gPrevSkidSm) # low
	addu	$6,$6,$2
	addu	$6,$3,$6
	addu	$2,$sp,32
	sw	$2,16($sp)
	lui	$2,%hi(gSaveSeg) # high
	addiu	$2,$2,%lo(gSaveSeg) # low
	addu	$2,$5,$2
	sw	$8,20($sp)
	sw	$12,24($sp)
	lw	$4,0($2)
	lui	$2,%hi(gSaveChunk) # high
	addiu	$2,$2,%lo(gSaveChunk) # low
	addu	$2,$5,$2
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	move	$7,$10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L639
	lui	$2,%hi(gStatusSm) # high
	.set	macro
	.set	reorder

$L621:
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,4
	subu	$4,$4,$17
	sll	$4,$4,2
	lui	$3,%hi(gPrevSkidSm) # high
	addiu	$3,$3,%lo(gPrevSkidSm) # low
	addu	$4,$4,$3
	addu	$4,$2,$4
	move	$5,$10
	addu	$6,$sp,32
	move	$7,$8
	sw	$12,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
	sw	$13,20($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gStatusSm) # high
$L639:
	addiu	$2,$2,%lo(gStatusSm) # low
	sll	$3,$17,2
	sll	$4,$16,4
	addu	$3,$3,$4
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L613
	sw	$0,0($3)
	.set	macro
	.set	reorder

$L620:
	lui	$4,%hi(gPrevSkidSm) # high
	addiu	$4,$4,%lo(gPrevSkidSm) # low
	sll	$3,$17,3
	subu	$3,$3,$17
	sll	$3,$3,2
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,4
	addu	$3,$3,$2
	addu	$3,$3,$4
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	move	$7,$0
	.set	macro
	.set	reorder

	lw	$4,0($3)
	lw	$2,0($10)
	#nop
	subu	$5,$4,$2
	bgtz	$5,$L625
	subu	$5,$2,$4
$L625:
	lw	$3,8($3)
	#nop
	subu	$4,$3,$6
	.set	noreorder
	.set	nomacro
	bgtz	$4,$L641
	li	$2,589824			# 0x00090000
	.set	macro
	.set	reorder

	subu	$4,$6,$3
$L641:
	ori	$2,$2,0xffff
	slt	$2,$2,$11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	li	$3,49152			# 0x0000c000
	.set	macro
	.set	reorder

	li	$3,12288			# 0x00003000
$L627:
	slt	$2,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	sra	$2,$4,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L630
	addu	$2,$5,$2
	.set	macro
	.set	reorder

$L629:
	sra	$2,$5,2
	addu	$2,$4,$2
$L630:
	slt	$2,$2,$3
	beq	$2,$0,$L624
	li	$7,1			# 0x00000001
$L624:
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L632
	lui	$2,%hi(gStatusSm) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(gStatusSm) # low
	sll	$4,$17,2
	sll	$3,$16,4
	addu	$5,$4,$3
	addu	$2,$5,$2
	lw	$3,0($2)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L633
	sll	$4,$17,3
	.set	macro
	.set	reorder

	sll	$3,$16,3
	subu	$3,$3,$16
	sll	$3,$3,4
	sll	$6,$17,3
	subu	$6,$6,$17
	sll	$6,$6,$2
	lui	$2,%hi(gPrevSkidSm) # high
	addiu	$2,$2,%lo(gPrevSkidSm) # low
	addu	$6,$6,$2
	addu	$6,$3,$6
	addu	$2,$sp,32
	sw	$2,16($sp)
	lui	$2,%hi(gSaveSeg) # high
	addiu	$2,$2,%lo(gSaveSeg) # low
	addu	$2,$5,$2
	sw	$8,20($sp)
	sw	$12,24($sp)
	lw	$4,0($2)
	lui	$2,%hi(gSaveChunk) # high
	addiu	$2,$2,%lo(gSaveChunk) # low
	addu	$2,$5,$2
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	move	$7,$10
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L640
	lui	$4,%hi(gStatusSm) # high
	.set	macro
	.set	reorder

$L633:
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,4
	subu	$4,$4,$17
	sll	$4,$4,2
	lui	$3,%hi(gPrevSkidSm) # high
	addiu	$3,$3,%lo(gPrevSkidSm) # low
	addu	$4,$4,$3
	addu	$4,$2,$4
	move	$5,$10
	addu	$6,$sp,32
	move	$7,$8
	sw	$12,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
	sw	$13,20($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(gStatusSm) # high
$L640:
	addiu	$4,$4,%lo(gStatusSm) # low
	sll	$2,$17,2
	sll	$3,$16,4
	addu	$2,$2,$3
	addu	$2,$2,$4
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L613
	sw	$3,0($2)
	.set	macro
	.set	reorder

$L632:
	addiu	$2,$2,%lo(gStatusSm) # low
	sll	$3,$17,2
	sll	$6,$16,4
	addu	$5,$3,$6
	addu	$9,$5,$2
	lw	$2,0($9)
	li	$11,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$11,$L636
	lui	$4,%hi(gSaveSeg) # high
	.set	macro
	.set	reorder

	sll	$3,$16,3
	subu	$3,$3,$16
	sll	$3,$3,4
	sll	$6,$17,3
	subu	$6,$6,$17
	sll	$6,$6,$11
	lui	$2,%hi(gPrevSkidSm) # high
	addiu	$2,$2,%lo(gPrevSkidSm) # low
	addu	$6,$6,$2
	addu	$6,$3,$6
	addu	$2,$sp,32
	sw	$2,16($sp)
	lui	$2,%hi(gSaveSeg) # high
	addiu	$2,$2,%lo(gSaveSeg) # low
	addu	$2,$5,$2
	sw	$8,20($sp)
	sw	$12,24($sp)
	lw	$4,0($2)
	lui	$2,%hi(gSaveChunk) # high
	addiu	$2,$2,%lo(gSaveChunk) # low
	addu	$2,$5,$2
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
	move	$7,$10
	.set	macro
	.set	reorder

	j	$L613
$L636:
	addiu	$4,$4,%lo(gSaveSeg) # low
	addu	$4,$3,$4
	addu	$4,$6,$4
	lui	$5,%hi(gSaveChunk) # high
	addiu	$5,$5,%lo(gSaveChunk) # low
	addu	$5,$3,$5
	addu	$5,$6,$5
	sll	$3,$16,3
	subu	$3,$3,$16
	sll	$3,$3,4
	sll	$6,$17,3
	subu	$6,$6,$17
	sll	$6,$6,2
	lui	$2,%hi(gPrevSkidSm) # high
	addiu	$2,$2,%lo(gPrevSkidSm) # low
	addu	$6,$6,$2
	addu	$6,$3,$6
	move	$7,$10
	addu	$2,$sp,32
	sw	$11,0($9)
	sw	$2,16($sp)
	sw	$8,20($sp)
	sw	$12,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii
	sw	$13,28($sp)
	.set	macro
	.set	reorder

$L613:
	lw	$31,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji
	.text
	.ent	TrgSfx_InitTrgSfx__Fv
TrgSfx_InitTrgSfx__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$10,$0
	lui	$2,%hi(gTAddCarWheelSfx) # high
	addiu	$25,$2,%lo(gTAddCarWheelSfx) # low
	lui	$2,%hi(gTAddCarExtraSfx) # high
	addiu	$24,$2,%lo(gTAddCarExtraSfx) # low
	move	$13,$10
	lui	$2,%hi(gTAddCarSfx) # high
	addiu	$12,$2,%lo(gTAddCarSfx) # low
	lui	$2,%hi(simGlobal+4) # high
	lui	$3,%hi(gTEnviroEffect) # high
	lw	$9,%lo(simGlobal+4)($2)
	addiu	$11,$3,%lo(gTEnviroEffect) # low
	sw	$9,gTAddCSmoke
$L646:
	move	$8,$0
	lui	$2,%hi(gStatusSm) # high
	addiu	$15,$2,%lo(gStatusSm) # low
	lui	$2,%hi(gPrevSkidSm) # high
	addiu	$14,$2,%lo(gPrevSkidSm) # low
	move	$7,$13
	sll	$6,$10,4
	sw	$9,0($11)
	sw	$9,0($12)
$L650:
	addu	$2,$7,$14
	addu	$7,$7,28
	addu	$3,$6,$25
	addu	$4,$6,$24
	addu	$5,$6,$15
	addu	$8,$8,1
	sw	$9,0($3)
	sw	$9,0($4)
	sw	$0,0($5)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,20($2)
	slt	$2,$8,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L650
	addu	$6,$6,4
	.set	macro
	.set	reorder

	addu	$13,$13,112
	addu	$12,$12,4
	addu	$10,$10,1
	slt	$2,$10,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L646
	addu	$11,$11,4
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	sw	$2,gTAddCarWheelDelay
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L654
	li	$2,12			# 0x0000000c
	.set	macro
	.set	reorder

	sw	$2,gTAddCarWheelDelay
$L654:
	j	$31
	.end	TrgSfx_InitTrgSfx__Fv
	.text
	.ent	TrgSfx_RestartTrgSfx__Fv
TrgSfx_RestartTrgSfx__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	TrgSfx_KillTrgSfx__Fv
	jal	TrgSfx_InitTrgSfx__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TrgSfx_RestartTrgSfx__Fv
	.text
	.ent	TrgSfx_KillTrgSfx__Fv
TrgSfx_KillTrgSfx__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	TrgSfx_KillTrgSfx__Fv
