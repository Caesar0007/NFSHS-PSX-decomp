	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\simqueue.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gSimQueue_Ticker
	.sdata
	.align	2
gSimQueue_Ticker:
	.word	-1
	.globl	gSimQueue_BlockSelf
	.align	2
gSimQueue_BlockSelf:
	.word	1
	.globl	gSimQueue_BlockOther
	.align	2
gSimQueue_BlockOther:
	.word	1
 #APP
		.section	.bss
	.align	2
inputQueue:
	.space	524
	.text
 #NO_APP
	.text
	.align	2
	.globl	SimQueue_StartUp__Fv
	.align	2
	.globl	SimQueue_Reset__Fv
	.align	2
	.globl	SimQueue_CleanUp__Fv
	.align	2
	.globl	SimQueue_Put__FiP14Input_tResults
	.align	2
	.globl	SimQueue_SetCurrentInput__Fi
	.align	2
	.globl	SimQueue_GetCurrentInput__FiP14Input_tResults
	.align	2
	.globl	SimQueue_SetLag__Fv
	.align	2
	.globl	SimQueue_IsBlocking__Fi
	.globl	maxTicksPerFrame
	.sdata
	.align	2
maxTicksPerFrame:
	.space	4

	.extern	D_8013DDC8, 8
	.extern	GameSetup_gData, 2600
	.extern	inputQueue, 524

	.text
	.text
	.ent	SimQueue_StartUp__Fv
SimQueue_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$2,1			# 0x00000001
	sw	$31,16($sp)
	sw	$2,gSimQueue_BlockSelf
	sw	$2,gSimQueue_BlockOther
	jal	SimQueue_SetLag__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	SimQueue_StartUp__Fv
	.text
	.ent	SimQueue_Reset__Fv
SimQueue_Reset__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	li	$8,1			# 0x00000001
	lui	$2,%hi(inputQueue) # high
	addiu	$6,$2,%lo(inputQueue) # low
	move	$7,$6
	move	$2,$8
	sw	$2,gSimQueue_BlockSelf
	sw	$2,gSimQueue_BlockOther
	move	$4,$0
$L613:
	sll	$3,$5,7
$L606:
	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	addu	$2,$3,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L614
	sw	$8,256($2)
	.set	macro
	.set	reorder

$L609:
	sw	$0,256($2)
	addu	$2,$3,$6
$L614:
	addu	$4,$4,1
	sb	$0,0($2)
	sb	$0,1($2)
	sb	$0,2($2)
	sb	$0,3($2)
	slt	$2,$4,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	addu	$3,$3,4
	.set	macro
	.set	reorder

	li	$2,4			# 0x00000004
	sw	$2,516($7)
	addu	$7,$7,$2
	addu	$5,$5,1
	slt	$2,$5,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L613
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(inputQueue+512) # high
	sw	$0,%lo(inputQueue+512)($2)
	li	$2,3			# 0x00000003
	sw	$2,gSimQueue_Ticker
	sw	$0,gSimQueue_BlockOther
	sw	$0,gSimQueue_BlockSelf
	j	$31
	.end	SimQueue_Reset__Fv
	.text
	.ent	SimQueue_CleanUp__Fv
SimQueue_CleanUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,1			# 0x00000001
	sw	$2,gSimQueue_BlockSelf
	sw	$2,gSimQueue_BlockOther
	j	$31
	.end	SimQueue_CleanUp__Fv
	.text
	.ent	SimQueue_Put__FiP14Input_tResults
SimQueue_Put__FiP14Input_tResults:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$20,32($sp)
	move	$20,$5
	lui	$2,%hi(inputQueue) # high
	sw	$19,28($sp)
	addiu	$19,$2,%lo(inputQueue) # low
	sll	$2,$18,2
	sw	$16,16($sp)
	addu	$16,$2,$19
	sw	$31,36($sp)
	sw	$17,20($sp)
	lw	$2,516($16)
	#nop
	.set	noreorder
	.set	nomacro
	jal	SimQueue_IsBlocking__Fi
	andi	$17,$2,0x001f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	move	$2,$0
	.set	macro
	.set	reorder

	sll	$2,$17,2
	sll	$3,$18,7
	addu	$2,$2,$3
	addu	$3,$2,$19
	lw	$2,256($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L626
	move	$2,$0
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lwl	$6,3($20)
	lwr	$6,0($20)
	swl	$6,3($3)
	swr	$6,0($3)
	sw	$4,256($3)
	lw	$2,516($16)
	#nop
	addu	$2,$2,$4
	sw	$2,516($16)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	lw	$3,12($2)
	#nop
	beq	$3,$0,$L619
	bne	$3,$4,$L622
	beq	$18,$0,$L622
	lw	$2,gSimQueue_Ticker
	.set	noreorder
	.set	nomacro
	j	$L628
	addu	$2,$2,$4
	.set	macro
	.set	reorder

$L619:
	lw	$2,968($2)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L629
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L626
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L629:
	lw	$2,gSimQueue_Ticker
	#nop
	addu	$2,$2,1
$L628:
	sw	$2,gSimQueue_Ticker
$L622:
	li	$2,1			# 0x00000001
$L626:
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

	.end	SimQueue_Put__FiP14Input_tResults
	.text
	.ent	SimQueue_SetCurrentInput__Fi
SimQueue_SetCurrentInput__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$5,$2,%lo(GameSetup_gData) # low
	lw	$2,968($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L632
	andi	$4,$4,0x001f
	.set	macro
	.set	reorder

	lui	$2,%hi(inputQueue) # high
	addiu	$8,$2,%lo(inputQueue) # low
	move	$7,$5
	lui	$2,%hi(D_8013DDC8) # high
	addiu	$6,$2,%lo(D_8013DDC8) # low
	sll	$5,$4,2
$L633:
	addu	$2,$5,$8
	lwl	$9,3($2)
	lwr	$9,0($2)
	swl	$9,3($6)
	swr	$9,0($6)
	addu	$6,$6,4
	lw	$2,968($7)
	addu	$3,$3,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L633
	addu	$5,$5,128
	.set	macro
	.set	reorder

$L632:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$5,$2,%lo(GameSetup_gData) # low
	lw	$2,968($5)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L636
	move	$3,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(inputQueue) # high
	addiu	$6,$2,%lo(inputQueue) # low
	sll	$4,$4,2
$L637:
	addu	$2,$4,$6
	sw	$0,256($2)
	lw	$2,968($5)
	addu	$3,$3,1
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	addu	$4,$4,128
	.set	macro
	.set	reorder

$L636:
	lui	$3,%hi(inputQueue) # high
	addiu	$3,$3,%lo(inputQueue) # low
	lw	$2,512($3)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,512($3)
	.set	macro
	.set	reorder

	.end	SimQueue_SetCurrentInput__Fi
	.text
	.ent	SimQueue_GetCurrentInput__FiP14Input_tResults
SimQueue_GetCurrentInput__FiP14Input_tResults:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(D_8013DDC8) # high
	addiu	$2,$2,%lo(D_8013DDC8) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	lwl	$3,3($4)
	lwr	$3,0($4)
	swl	$3,3($5)
	.set	noreorder
	.set	nomacro
	j	$31
	swr	$3,0($5)
	.set	macro
	.set	reorder

	.end	SimQueue_GetCurrentInput__FiP14Input_tResults
	.text
	.ent	SimQueue_SetLag__Fv
SimQueue_SetLag__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L644
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	bne	$3,$2,$L645
$L644:
	li	$2,4			# 0x00000004
	sw	$2,maxTicksPerFrame
$L645:
	j	$31
	.end	SimQueue_SetLag__Fv
	.text
	.ent	SimQueue_IsBlocking__Fi
SimQueue_IsBlocking__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L648
	lui	$2,%hi(GameSetup_gData+12) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L648:
	lw	$3,%lo(GameSetup_gData+12)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L655
	lui	$2,%hi(inputQueue) # high
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L652
	lui	$2,%hi(inputQueue) # high
	.set	macro
	.set	reorder

$L655:
	addiu	$2,$2,%lo(inputQueue) # low
	lw	$3,512($2)
	lw	$4,maxTicksPerFrame
	lw	$2,516($2)
	addu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	SimQueue_IsBlocking__Fi
