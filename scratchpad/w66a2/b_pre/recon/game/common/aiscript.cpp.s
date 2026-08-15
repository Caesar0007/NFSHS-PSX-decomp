	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\aiscript.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails
	.align	2
	.globl	AIScript_ClearLastReactionIndex__FP10AIScript_t
	.align	2
	.globl	AIScript_Startup__FP10AIScript_t
	.align	2
	.globl	AIScript_Cleanup__Fv
	.align	2
	.globl	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	.align	2
	.globl	AIScript_ProcessActionsAndReactions__FP10AIScript_ti
	.align	2
	.globl	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	.align	2
	.globl	AIScript_GetReactionTicksLeft__FP10AIScript_t

	.text
	.text
	.ent	AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails
AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,28($4)
	.set	macro
	.set	reorder

	.end	AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails
	.text
	.ent	AIScript_ClearLastReactionIndex__FP10AIScript_t
AIScript_ClearLastReactionIndex__FP10AIScript_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,-1			# 0xffffffff
	li	$2,6			# 0x00000006
	addu	$4,$4,24
$L602:
	sw	$3,32($4)
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	bgez	$2,$L602
	addu	$4,$4,-4
	.set	macro
	.set	reorder

	j	$31
	.end	AIScript_ClearLastReactionIndex__FP10AIScript_t
	.text
	.ent	AIScript_Startup__FP10AIScript_t
AIScript_Startup__FP10AIScript_t:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$2,7			# 0x00000007
	sw	$31,20($sp)
	sw	$2,8($16)
	sw	$2,0($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	AIScript_ClearLastReactionIndex__FP10AIScript_t
	sw	$2,20($16)
	.set	macro
	.set	reorder

	sw	$0,60($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AIScript_Startup__FP10AIScript_t
	.text
	.ent	AIScript_Cleanup__Fv
AIScript_Cleanup__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	AIScript_Cleanup__Fv
	.text
	.ent	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	sw	$17,20($sp)
	move	$17,$7
	sw	$31,32($sp)
	lw	$2,60($16)
	addu	$3,$17,-1280
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	move	$18,$6
	.set	macro
	.set	reorder

	jal	AIScript_ClearLastReactionIndex__FP10AIScript_t
$L609:
	lw	$3,8($16)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L608
	sw	$17,60($16)
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	slt	$2,$18,$2
	beq	$2,$0,$L608
	sw	$18,0($16)
	sw	$19,4($16)
$L608:
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

	.end	AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
	.text
	.ent	AIScript_ProcessActionsAndReactions__FP10AIScript_ti
AIScript_ProcessActionsAndReactions__FP10AIScript_ti:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,7			# 0x00000007
	lw	$6,8($4)
	lw	$8,28($4)
	bne	$6,$2,$L612
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$6,$L613
	li	$9,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$10,$9
	sw	$2,8($4)
	lw	$2,4($4)
	lw	$3,8($4)
	li	$12,2			# 0x00000002
	sw	$6,0($4)
	sw	$0,24($4)
	sll	$3,$3,$12
	addu	$3,$3,32
	addu	$7,$4,$3
	sw	$2,12($4)
	lw	$2,0($7)
	li	$11,7			# 0x00000007
	sw	$9,20($4)
	sw	$2,16($4)
$L614:
	beq	$9,$0,$L613
	lw	$2,16($4)
	#nop
	addu	$3,$2,1
	slt	$2,$3,4
	beq	$2,$0,$L616
	lw	$2,8($4)
	#nop
	sll	$2,$2,3
	addu	$2,$2,$8
	addu	$2,$2,$3
	lbu	$2,0($2)
	#nop
	sll	$6,$10,$2
	beq	$6,$12,$L616
	sw	$3,16($4)
	lw	$2,0($7)
	#nop
	addu	$2,$2,1
	sw	$2,0($7)
$L616:
	lw	$2,8($4)
	lw	$3,16($4)
	sll	$2,$2,3
	addu	$2,$2,$8
	addu	$2,$2,$3
	lbu	$2,0($2)
	lw	$3,20($4)
	sll	$6,$10,$2
	lw	$2,8($4)
	or	$3,$3,$6
	sw	$3,20($4)
	lw	$3,16($4)
	sll	$2,$2,3
	addu	$2,$2,$8
	addu	$2,$2,$3
	lbu	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	sll	$2,$2,4
	.set	macro
	.set	reorder

	sw	$2,24($4)
	move	$9,$0
$L621:
	lw	$2,20($4)
	#nop
	bne	$2,$10,$L614
	sw	$11,8($4)
	.set	noreorder
	.set	nomacro
	j	$L614
	sw	$11,0($4)
	.set	macro
	.set	reorder

$L613:
	lw	$3,8($4)
	li	$2,7			# 0x00000007
	beq	$3,$2,$L626
$L612:
	lw	$2,24($4)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L624
	subu	$2,$2,$5
	.set	macro
	.set	reorder

	li	$2,7			# 0x00000007
	sw	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($4)
	.set	macro
	.set	reorder

$L624:
	sw	$2,24($4)
$L626:
	j	$31
	.end	AIScript_ProcessActionsAndReactions__FP10AIScript_ti
	.text
	.ent	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L628
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,20($4)
	#nop
	and	$2,$5,$2
	beq	$2,$0,$L628
	lw	$6,12($4)
$L628:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
	.text
	.ent	AIScript_GetReactionTicksLeft__FP10AIScript_t
AIScript_GetReactionTicksLeft__FP10AIScript_t:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,8($4)
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L632
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,24($4)
$L632:
	j	$31
	.end	AIScript_GetReactionTicksLeft__FP10AIScript_t
