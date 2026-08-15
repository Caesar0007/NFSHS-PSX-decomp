	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aitriger.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Init__24AITrigger_TriggerManagerPc
	.align	2
	.globl	InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
	.align	2
	.globl	GetNextTrigger__24AITrigger_TriggerManageri
	.align	2
	.globl	GetPrevTrigger__24AITrigger_TriggerManageri
	.align	2
	.globl	CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
	.align	2
	.globl	GetTrigger__24AITrigger_TriggerManageriPi
	.align	2
	.globl	CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
	.align	2
	.globl	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
	.align	2
	.globl	AITrigger_Compare__FPCvT0
	.align	2
	.globl	Sort__24AITrigger_TriggerManager
	.globl	triggerManagerCops
	.sdata
	.align	2
triggerManagerCops:
	.space	4
	.globl	triggerManagerTraffic
	.align	2
triggerManagerTraffic:
	.space	4

	.extern	simGlobal, 24

	.text
	.text
	.ent	Init__24AITrigger_TriggerManagerPc
Init__24AITrigger_TriggerManagerPc:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	li	$4,-2560			# 0xfffff600
	sw	$16,16($sp)
	li	$16,99			# 0x00000063
	addu	$3,$19,396
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$0,0($19)
	sw	$0,4($19)
$L601:
	sw	$4,408($3)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L601
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	li	$16,8			# 0x00000008
	addu	$3,$19,32
$L605:
	sw	$0,808($3)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L605
	addu	$3,$3,-4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L600
	move	$18,$5
	.set	macro
	.set	reorder

	addu	$17,$18,4
	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L610
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$19
$L616:
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$17,$17,$2
	lw	$2,0($18)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	move	$4,$19
	.set	macro
	.set	reorder

$L610:
	.set	noreorder
	.set	nomacro
	jal	Sort__24AITrigger_TriggerManager
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$5,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L600
	li	$4,65536			# 0x00010000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	sll	$5,$5,16
	.set	macro
	.set	reorder

	sw	$2,4($19)
$L600:
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

	.end	Init__24AITrigger_TriggerManagerPc
	.text
	.ent	InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$16,16($sp)
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$3,0($17)
	li	$2,5			# 0x00000005
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L618
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L619
	addu	$2,$17,64
	.set	macro
	.set	reorder

	sw	$2,60($17)
$L619:
	lw	$2,0($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$17,8($2)
	lw	$3,56($17)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	j	$L620
	addu	$16,$2,64
	.set	macro
	.set	reorder

$L618:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L623
	slt	$2,$3,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	beq	$3,$2,$L623
	j	$L621
$L627:
	li	$2,3			# 0x00000003
	beq	$3,$2,$L624
	j	$L621
$L623:
	.set	noreorder
	.set	nomacro
	j	$L621
	li	$16,20			# 0x00000014
	.set	macro
	.set	reorder

$L624:
	li	$16,72			# 0x00000048
$L621:
	lw	$2,0($18)
	#nop
	sll	$2,$2,2
	addu	$2,$18,$2
	sw	$17,8($2)
$L620:
	lw	$2,0($18)
	#nop
	addu	$2,$2,1
	sw	$2,0($18)
	move	$2,$16
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

	.end	InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
	.text
	.ent	GetNextTrigger__24AITrigger_TriggerManageri
GetNextTrigger__24AITrigger_TriggerManageri:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	sll	$2,$5,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L629:
	addu	$5,$4,$2
	lw	$2,808($5)
	#nop
	addu	$2,$2,1
	sw	$2,808($5)
	lw	$3,0($4)
	#nop
	bne	$2,$3,$L630
	sw	$0,808($5)
$L630:
	lw	$3,808($5)
	lw	$2,0($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$4,$2
	lw	$2,8($2)
	j	$31
$L631:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	GetNextTrigger__24AITrigger_TriggerManageri
	.text
	.ent	GetPrevTrigger__24AITrigger_TriggerManageri
GetPrevTrigger__24AITrigger_TriggerManageri:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	sll	$2,$5,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L634:
	addu	$5,$4,$2
	lw	$2,808($5)
	li	$3,-1			# 0xffffffff
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L635
	sw	$2,808($5)
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	addu	$2,$2,$3
	sw	$2,808($5)
$L635:
	lw	$3,808($5)
	lw	$2,0($4)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$4,$2
	lw	$2,8($2)
	j	$31
$L636:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	GetPrevTrigger__24AITrigger_TriggerManageri
	.text
	.ent	CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
CheckForTriggerAtSlice__24AITrigger_TriggerManagerii:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$3,0($16)
	move	$18,$6
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L654
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sll	$2,$19,2
	addu	$2,$2,808
	addu	$17,$16,$2
	lw	$2,0($17)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,4($2)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	slt	$2,$3,2
	.set	macro
	.set	reorder

	bne	$2,$0,$L640
$L643:
	lw	$2,0($16)
	#.set	volatile
	lw	$3,0($17)
	#.set	novolatile
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L646
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetNextTrigger__24AITrigger_TriggerManageri
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,4($2)
	#nop
	slt	$2,$2,$18
	beq	$2,$0,$L646
	j	$L643
$L640:
 #APP
 #NO_APP
	lw	$3,0($17)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,4($2)
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L646
	lw	$2,0($16)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L646
$L650:
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L646
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetPrevTrigger__24AITrigger_TriggerManageri
	move	$5,$19
	.set	macro
	.set	reorder

	lw	$3,0($17)
	#nop
	sll	$2,$3,2
	addu	$2,$16,$2
	lw	$2,8($2)
	#nop
	lw	$2,4($2)
	#nop
	slt	$2,$18,$2
	bne	$2,$0,$L650
$L646:
	lw	$6,0($17)
	#nop
	sll	$2,$6,2
	addu	$4,$16,$2
	lw	$5,8($4)
	#nop
	lw	$3,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$18,$L654
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$3,%hi(simGlobal+4) # high
	lw	$3,%lo(simGlobal+4)($3)
	lw	$4,408($4)
	#nop
	subu	$3,$3,$4
	slt	$3,$3,2561
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L654
	li	$3,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,0($5)
	#nop
	beq	$4,$3,$L654
	move	$2,$6
$L654:
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

	.end	CheckForTriggerAtSlice__24AITrigger_TriggerManagerii
	.text
	.ent	GetTrigger__24AITrigger_TriggerManageriPi
GetTrigger__24AITrigger_TriggerManageriPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(simGlobal+4) # high
	sll	$3,$5,2
	addu	$3,$4,$3
	lw	$2,%lo(simGlobal+4)($2)
	lw	$3,408($3)
	#nop
	subu	$2,$2,$3
	slt	$2,$2,2561
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L657
	sw	$0,0($6)
	.set	macro
	.set	reorder

$L656:
	sw	$2,0($6)
$L657:
	sll	$3,$5,2
	lui	$2,%hi(simGlobal+4) # high
	lw	$2,%lo(simGlobal+4)($2)
	addu	$6,$4,$3
	sw	$2,408($6)
	lw	$2,0($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L658
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$3,8($6)
$L658:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	GetTrigger__24AITrigger_TriggerManageriPi
	.text
	.ent	CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$0
	move	$10,$9
	li	$11,-1			# 0xffffffff
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	move	$12,$11
	.set	macro
	.set	reorder

$L678:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$11
	.set	macro
	.set	reorder

$L675:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$8
	.set	macro
	.set	reorder

$L660:
	move	$8,$0
	move	$13,$2
$L663:
	slt	$2,$8,$13
	beq	$2,$0,$L662
	lw	$3,8($4)
	#nop
	lw	$2,0($3)
	#nop
	bne	$2,$6,$L665
	bne	$10,$0,$L666
	move	$10,$3
	move	$12,$8
$L666:
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L675
	slt	$2,$5,$2
	.set	macro
	.set	reorder

	beq	$2,$0,$L668
	bgtz	$7,$L675
	bgez	$7,$L668
	bne	$9,$0,$L678
$L668:
	move	$9,$3
	move	$11,$8
$L665:
	addu	$4,$4,4
	.set	noreorder
	.set	nomacro
	j	$L663
	addu	$8,$8,1
	.set	macro
	.set	reorder

$L662:
	beq	$9,$0,$L672
	.set	noreorder
	.set	nomacro
	bltz	$7,$L679
	move	$2,$11
	.set	macro
	.set	reorder

$L672:
	.set	noreorder
	.set	nomacro
	bgtz	$7,$L679
	move	$2,$12
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L679:
	j	$31
	.end	CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
	.text
	.ent	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t
	.text
	.ent	AITrigger_Compare__FPCvT0
AITrigger_Compare__FPCvT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	lw	$3,0($5)
	lw	$4,4($2)
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$31
	subu	$2,$4,$2
	.set	macro
	.set	reorder

	.end	AITrigger_Compare__FPCvT0
	.text
	.ent	Sort__24AITrigger_TriggerManager
Sort__24AITrigger_TriggerManager:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$5,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L682
	addu	$4,$4,8
	.set	macro
	.set	reorder

	lui	$7,%hi(AITrigger_Compare__FPCvT0) # high
	li	$6,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	qsort
	addiu	$7,$7,%lo(AITrigger_Compare__FPCvT0) # low
	.set	macro
	.set	reorder

$L682:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sort__24AITrigger_TriggerManager
