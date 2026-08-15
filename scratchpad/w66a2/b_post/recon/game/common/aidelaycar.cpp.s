	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aidelaycar.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	__10AIDelayCarP8Car_tObjT1i
	.align	2
	.globl	SetNewTargetCar__10AIDelayCarP8Car_tObj
	.align	2
	.globl	Update__10AIDelayCar

	.extern	gNumSlices, 4

	.text
	.text
	.ent	__10AIDelayCarP8Car_tObjT1i
__10AIDelayCarP8Car_tObjT1i:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	sw	$5,4($16)
	move	$5,$6
	.set	noreorder
	.set	nomacro
	jal	SetNewTargetCar__10AIDelayCarP8Car_tObj
	sw	$7,0($16)
	.set	macro
	.set	reorder

	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__10AIDelayCarP8Car_tObjT1i
	.text
	.ent	SetNewTargetCar__10AIDelayCarP8Car_tObj
SetNewTargetCar__10AIDelayCarP8Car_tObj:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	sw	$5,8($16)
	.set	macro
	.set	reorder

	lw	$3,8($16)
	sw	$2,12($16)
	lh	$2,8($3)
	#nop
	sw	$2,16($16)
	lw	$2,4($16)
	lw	$3,160($3)
	lw	$2,160($2)
	#nop
	subu	$2,$2,$3
	sw	$2,20($16)
	lw	$2,4($16)
	lw	$3,8($16)
	lw	$2,164($2)
	lw	$3,164($3)
	#nop
	subu	$2,$2,$3
	sw	$2,24($16)
	lw	$2,4($16)
	lw	$3,8($16)
	lw	$2,168($2)
	lw	$3,168($3)
	lw	$4,8($16)
	subu	$2,$2,$3
	sw	$2,28($16)
	lw	$6,160($4)
	lw	$7,164($4)
	lw	$8,168($4)
	sw	$6,32($16)
	sw	$7,36($16)
	sw	$8,40($16)
	lw	$2,4($16)
	lw	$3,8($16)
	lw	$2,1396($2)
	lw	$3,1396($3)
	lw	$4,8($16)
	subu	$2,$2,$3
	sw	$2,44($16)
	lw	$2,1396($4)
	move	$3,$4
	sw	$2,48($16)
	lw	$2,1732($3)
	#nop
	sw	$2,52($16)
	lw	$2,1380($3)
	#nop
	sw	$2,56($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SetNewTargetCar__10AIDelayCarP8Car_tObj
	.text
	.ent	Update__10AIDelayCar
Update__10AIDelayCar:
	.frame	$sp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,48($sp)
	move	$16,$4
	sw	$31,52($sp)
	lw	$4,8($16)
	lw	$5,4($16)
	jal	AIWorld_ApxSplineDistance__FP8Car_tObjT0
	lw	$4,12($16)
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	li	$4,715784192			# 0x2aaa0000
	lw	$3,12($16)
	ori	$4,$4,0xaaab
	addu	$3,$3,$2
	mult	$3,$4
	sw	$3,12($16)
	sra	$3,$3,31
	mfhi	$7
	#nop
	#nop
	sra	$2,$7,16
	subu	$3,$2,$3
	bltz	$3,$L604
	lw	$2,4($16)
	#nop
	lh	$2,8($2)
	lw	$4,gNumSlices
	addu	$3,$2,$3
	slt	$2,$3,$4
	bne	$2,$0,$L606
	.set	noreorder
	.set	nomacro
	j	$L606
	subu	$3,$3,$4
	.set	macro
	.set	reorder

$L604:
	lw	$2,4($16)
	#nop
	lh	$2,8($2)
	#nop
	addu	$3,$2,$3
	bgez	$3,$L606
	lw	$2,gNumSlices
	#nop
	addu	$3,$3,$2
$L606:
	lw	$2,8($16)
	sw	$3,16($16)
	lw	$3,4($16)
	lw	$4,160($2)
	lw	$2,160($3)
	#nop
	subu	$4,$4,$2
	sw	$4,16($sp)
	lw	$2,8($16)
	lw	$3,4($16)
	lw	$6,164($2)
	lw	$2,164($3)
	#nop
	subu	$6,$6,$2
	sw	$6,20($sp)
	lw	$2,8($16)
	lw	$5,4($16)
	lw	$3,168($2)
	lw	$2,168($5)
	#nop
	subu	$3,$3,$2
	sw	$3,24($sp)
	lw	$2,20($16)
	#nop
	subu	$4,$4,$2
	sw	$4,32($sp)
	lw	$2,24($16)
	#nop
	subu	$6,$6,$2
	sw	$6,36($sp)
	lw	$2,28($16)
	#nop
	subu	$3,$3,$2
	sw	$3,40($sp)
	lw	$5,0($16)
	jal	fixedmult
	lw	$3,20($16)
	lw	$5,0($16)
	addu	$3,$3,$2
	sw	$3,20($16)
	lw	$4,36($sp)
	jal	fixedmult
	lw	$3,24($16)
	lw	$5,0($16)
	addu	$3,$3,$2
	sw	$3,24($16)
	lw	$4,40($sp)
	jal	fixedmult
	lw	$3,28($16)
	lw	$4,4($16)
	addu	$3,$3,$2
	sw	$3,28($16)
	lw	$2,160($4)
	lw	$3,20($16)
	#nop
	addu	$2,$2,$3
	sw	$2,32($16)
	lw	$2,164($4)
	lw	$3,24($16)
	#nop
	addu	$2,$2,$3
	sw	$2,36($16)
	lw	$2,168($4)
	lw	$3,28($16)
	lw	$5,0($16)
	addu	$2,$2,$3
	sw	$2,40($16)
	lw	$2,8($16)
	move	$3,$4
	lw	$4,1396($2)
	lw	$2,1396($3)
	lw	$3,44($16)
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$4,$3
	.set	macro
	.set	reorder

	lw	$3,44($16)
	lw	$4,4($16)
	addu	$3,$3,$2
	sw	$3,44($16)
	lw	$5,1396($4)
	lw	$4,16($16)
	addu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	AIWorld_LaneIndex__Fii
	sw	$5,48($16)
	.set	macro
	.set	reorder

	lw	$3,8($16)
	lw	$4,56($16)
	sw	$2,52($16)
	lw	$2,1380($3)
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$4,$2,$4
	.set	macro
	.set	reorder

	lw	$3,56($16)
	#nop
	addu	$3,$3,$2
	sw	$3,56($16)
	lw	$31,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Update__10AIDelayCar
