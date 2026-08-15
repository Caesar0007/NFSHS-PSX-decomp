	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\schedule.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Sched_ExecuteCheck__FiiiiPiN24i
	.align	2
	.globl	Sched_CreateNewSchedule__FPci
	.align	2
	.globl	Sched_CleanUpSchedule__FP15Sched_tSchedule
	.align	2
	.globl	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	.align	2
	.globl	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	.align	2
	.globl	Sched_Execute__FP15Sched_tSchedule

	.extern	Sched_ExecuteMasks, 28
	.extern	Sched_ExecuteElapsedTimes, 28
	.extern	Sched_ExecuteiTimes, 28
	.extern	Sched_ExecuteTimes, 28
	.extern	Sched_gExecuteInfo, 80
	.extern	simGlobal, 24

	.text
	.text
	.ent	Sched_ExecuteCheck__FiiiiPiN24i
Sched_ExecuteCheck__FiiiiPiN24i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal) # high
	addiu	$10,$2,%lo(simGlobal) # low
	lw	$2,4($10)
	lw	$8,16($sp)
	lw	$11,20($sp)
	lw	$9,24($sp)
	lw	$3,28($sp)
	slt	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	move	$12,$4
	.set	macro
	.set	reorder

	bgez	$6,$L602
	addu	$6,$6,15
$L602:
	sra	$6,$6,4
	.set	noreorder
	.set	nomacro
	bgez	$6,$L603
	move	$2,$6
	.set	macro
	.set	reorder

	li	$2,65535			# 0x0000ffff
	addu	$2,$6,$2
$L603:
	sra	$6,$2,16
	slt	$2,$6,20
	bne	$2,$0,$L604
	li	$6,19			# 0x00000013
$L604:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L607
	lui	$3,%hi(Sched_gExecuteInfo) # high
	.set	macro
	.set	reorder

	move	$6,$0
$L607:
	addiu	$3,$3,%lo(Sched_gExecuteInfo) # low
	sll	$2,$5,2
	addu	$2,$2,$5
	sll	$2,$2,2
	addu	$2,$6,$2
	addu	$2,$2,$3
	lui	$3,%hi(Sched_ExecuteTimes) # high
	lbu	$4,0($2)
	addiu	$3,$3,%lo(Sched_ExecuteTimes) # low
	sll	$4,$4,2
	addu	$3,$4,$3
	lw	$2,0($3)
	mult	$7,$12
	sw	$2,0($8)
	lui	$2,%hi(Sched_ExecuteiTimes) # high
	addiu	$2,$2,%lo(Sched_ExecuteiTimes) # low
	addu	$2,$4,$2
	lw	$2,0($2)
	lui	$3,%hi(Sched_ExecuteMasks) # high
	sw	$2,0($9)
	lui	$2,%hi(Sched_ExecuteElapsedTimes) # high
	addiu	$2,$2,%lo(Sched_ExecuteElapsedTimes) # low
	addu	$2,$4,$2
	lw	$2,0($2)
	addiu	$3,$3,%lo(Sched_ExecuteMasks) # low
	sw	$2,0($11)
	lw	$2,4($10)
	addu	$4,$4,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$2,$2,1
	lw	$3,0($4)
	mflo	$13
	#nop
	#nop
	addu	$2,$2,$13
	and	$2,$2,$3
	xor	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L601:
	lui	$2,%hi(Sched_ExecuteTimes+24) # high
	lw	$2,%lo(Sched_ExecuteTimes+24)($2)
	#nop
	sw	$2,0($8)
	lui	$2,%hi(Sched_ExecuteiTimes+24) # high
	lw	$2,%lo(Sched_ExecuteiTimes+24)($2)
	#nop
	sw	$2,0($9)
	lui	$2,%hi(Sched_ExecuteElapsedTimes+24) # high
	lw	$3,%lo(Sched_ExecuteElapsedTimes+24)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,0($11)
	.set	macro
	.set	reorder

	.end	Sched_ExecuteCheck__FiiiiPiN24i
	.text
	.ent	Sched_CreateNewSchedule__FPci
Sched_CreateNewSchedule__FPci:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sll	$5,$16,4
	addu	$5,$5,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$5,$2
	sw	$16,0($5)
	move	$2,$16
	move	$4,$0
	.set	noreorder
	.set	nomacro
	blez	$2,$L610
	sw	$0,4($5)
	.set	macro
	.set	reorder

	li	$6,32766			# 0x00007ffe
	move	$3,$5
$L612:
	sw	$6,8($3)
	sw	$0,12($3)
	lw	$2,0($5)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$3,$3,16
	.set	macro
	.set	reorder

$L610:
	lw	$31,20($sp)
	lw	$16,16($sp)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sched_CreateNewSchedule__FPci
	.text
	.ent	Sched_CleanUpSchedule__FP15Sched_tSchedule
Sched_CleanUpSchedule__FP15Sched_tSchedule:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sched_CleanUpSchedule__FP15Sched_tSchedule
	.text
	.ent	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$10,$0
	lw	$2,4($4)
	move	$9,$10
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	blez	$2,$L617
	sw	$2,4($4)
	.set	macro
	.set	reorder

	sll	$2,$10,4
$L627:
	addu	$2,$4,$2
	lw	$2,8($2)
	#nop
	slt	$2,$7,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L619
	move	$9,$10
	.set	macro
	.set	reorder

	lw	$2,4($4)
	#nop
	addu	$8,$2,-1
	slt	$2,$9,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	sll	$2,$8,4
	.set	macro
	.set	reorder

	addu	$3,$2,$4
$L621:
	lw	$11,-8($3)
	lw	$12,-4($3)
	lw	$13,0($3)
	lw	$14,4($3)
	sw	$11,8($3)
	sw	$12,12($3)
	sw	$13,16($3)
	sw	$14,20($3)
	addu	$8,$8,-1
	slt	$2,$10,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	addu	$3,$3,-16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L626
	sll	$2,$9,4
	.set	macro
	.set	reorder

$L619:
	lw	$2,4($4)
	addu	$10,$9,1
	slt	$2,$10,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L627
	sll	$2,$10,4
	.set	macro
	.set	reorder

$L617:
	sll	$2,$9,4
$L626:
	addu	$2,$4,$2
	sw	$7,8($2)
	sw	$5,12($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$6,16($2)
	.set	macro
	.set	reorder

	.end	Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
	.text
	.ent	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$8,4($4)
	#nop
	beq	$8,$0,$L640
	.set	noreorder
	.set	nomacro
	blez	$8,$L631
	move	$3,$0
	.set	macro
	.set	reorder

	move	$7,$4
$L632:
	lw	$2,12($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L633
	sll	$9,$3,4
	.set	macro
	.set	reorder

	lw	$2,16($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$6,$L633
	addu	$2,$8,-1
	.set	macro
	.set	reorder

	move	$5,$3
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	addu	$3,$9,$4
	.set	macro
	.set	reorder

$L635:
	lw	$10,24($3)
	lw	$11,28($3)
	lw	$12,32($3)
	lw	$13,36($3)
	sw	$10,8($3)
	sw	$11,12($3)
	sw	$12,16($3)
	sw	$13,20($3)
	lw	$2,4($4)
	addu	$5,$5,1
	addu	$2,$2,-1
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	addu	$3,$3,16
	.set	macro
	.set	reorder

	j	$L631
$L633:
	lw	$8,4($4)
	addu	$3,$3,1
	slt	$2,$3,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	addu	$7,$7,16
	.set	macro
	.set	reorder

$L631:
	lw	$2,4($4)
	li	$3,32766			# 0x00007ffe
	sll	$2,$2,4
	addu	$2,$4,$2
	sw	$3,8($2)
	lw	$2,4($4)
	#nop
	addu	$2,$2,-1
	sw	$2,4($4)
$L640:
	j	$31
	.end	Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
	.text
	.ent	Sched_Execute__FP15Sched_tSchedule
Sched_Execute__FP15Sched_tSchedule:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,4($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L641
	move	$17,$0
	.set	macro
	.set	reorder

	move	$16,$18
$L643:
	lw	$2,12($16)
	#nop
	beq	$2,$0,$L646
	lw	$4,16($16)
	jal	$31,$2
$L646:
	lw	$2,4($18)
	addu	$17,$17,1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	addu	$16,$16,16
	.set	macro
	.set	reorder

$L641:
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

	.end	Sched_Execute__FP15Sched_tSchedule
