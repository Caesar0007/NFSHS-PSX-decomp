	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\chunk.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
	.align	2
	.globl	Chunk_UpdateSys__FP13DRender_tView
	.align	2
	.globl	Chunk_Init__Fv
	.align	2
	.globl	Chunk_DeInit__Fv
	.globl	Chunk_lightTable
	.sdata
	.align	2
Chunk_lightTable:
	.space	4
	.globl	Chunk_chunkCenters
	.align	2
Chunk_chunkCenters:
	.space	4

	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$21,36($sp)
	move	$21,$5
	sw	$19,28($sp)
	move	$19,$6
	move	$4,$21
	li	$5,28			# 0x0000001c
	move	$6,$0
	sw	$31,40($sp)
	sw	$20,32($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$2,16
	lhu	$3,10($4)
	#nop
	sh	$3,104($18)
	lwl	$11,35($2)
	lwr	$11,32($2)
	swl	$11,3($18)
	swr	$11,0($18)
	lwl	$11,39($2)
	lwr	$11,36($2)
	swl	$11,7($18)
	swr	$11,4($18)
	lwl	$11,43($2)
	lwr	$11,40($2)
	swl	$11,11($18)
	swr	$11,8($18)
	lwl	$11,47($2)
	lwr	$11,44($2)
	swl	$11,15($18)
	swr	$11,12($18)
	lwl	$11,51($2)
	lwr	$11,48($2)
	swl	$11,19($18)
	swr	$11,16($18)
	lwl	$11,55($2)
	lwr	$11,52($2)
	swl	$11,23($18)
	swr	$11,20($18)
	lwl	$11,59($2)
	lwr	$11,56($2)
	swl	$11,27($18)
	swr	$11,24($18)
	lwl	$11,63($2)
	lwr	$11,60($2)
	swl	$11,31($18)
	swr	$11,28($18)
	lhu	$2,12($4)
	#nop
	sh	$2,106($18)
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L601
	move	$4,$21
	.set	macro
	.set	reorder

	li	$5,3			# 0x00000003
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,11			# 0x0000000b
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,64($18)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L602
	sw	$2,80($18)
	.set	macro
	.set	reorder

$L601:
	li	$5,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,3			# 0x00000003
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$20,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$20,$0,$L618
	move	$17,$2
	.set	macro
	.set	reorder

	move	$6,$0
	lw	$16,12($20)
	li	$10,127			# 0x0000007f
	li	$9,-1			# 0xffffffff
	li	$8,5			# 0x00000005
	addu	$5,$20,16
$L605:
	slt	$2,$6,$16
	beq	$2,$0,$L606
 #APP
 #NO_APP
	#.set	volatile
	lbu	$2,18($5)
	#.set	novolatile
	#nop
	beq	$2,$10,$L607
	lbu	$3,18($5)
	lw	$2,12($17)
	#nop
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	addu	$4,$17,16
	.set	macro
	.set	reorder

	addu	$3,$3,-1
	beq	$3,$9,$L612
	li	$7,-1			# 0xffffffff
$L613:
	lh	$2,0($4)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$3,$7,$L613
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L612:
	beq	$4,$0,$L606
	lbu	$2,2($4)
	#nop
	bne	$2,$8,$L606
	lbu	$2,35($4)
	#nop
	bne	$2,$0,$L606
$L607:
	addu	$5,$5,20
	.set	noreorder
	.set	nomacro
	j	$L605
	addu	$6,$6,1
	.set	macro
	.set	reorder

$L606:
 #APP
 #NO_APP
	move	$16,$6
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L618
	move	$4,$21
	.set	macro
	.set	reorder

	move	$5,$20
	move	$6,$19
	sll	$7,$16,2
	addu	$7,$7,$16
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
	sll	$7,$7,2
	.set	macro
	.set	reorder

	sw	$2,80($18)
	.set	noreorder
	.set	nomacro
	j	$L604
	sw	$16,0($2)
	.set	macro
	.set	reorder

$L618:
	sw	$0,80($18)
$L604:
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L621
	move	$16,$0
	.set	macro
	.set	reorder

	lw	$4,12($17)
	move	$7,$16
	addu	$3,$17,16
	li	$6,5			# 0x00000005
	li	$5,1			# 0x00000001
$L624:
	slt	$2,$16,$4
	beq	$2,$0,$L623
	lbu	$2,2($3)
	#nop
	bne	$2,$6,$L626
	lbu	$2,35($3)
	#nop
	bne	$2,$0,$L623
	j	$L628
$L626:
	bne	$2,$5,$L623
$L628:
	lh	$2,0($3)
	addu	$16,$16,1
	addu	$7,$7,$2
	.set	noreorder
	.set	nomacro
	j	$L624
	addu	$3,$3,$2
	.set	macro
	.set	reorder

$L623:
	move	$4,$21
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi
	move	$6,$19
	.set	macro
	.set	reorder

	sw	$2,64($18)
	.set	noreorder
	.set	nomacro
	j	$L631
	sw	$16,0($2)
	.set	macro
	.set	reorder

$L621:
	sw	$0,64($18)
$L631:
	lw	$3,80($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L638
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$2,64($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L638
	li	$7,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$5,0($3)
	li	$6,127			# 0x0000007f
	addu	$3,$20,16
	sll	$2,$5,2
	addu	$2,$2,$5
	sll	$2,$2,2
	addu	$4,$2,$3
$L633:
	addu	$5,$5,-1
$L639:
	.set	noreorder
	.set	nomacro
	beq	$5,$7,$L602
	addu	$4,$4,-20
	.set	macro
	.set	reorder

	lw	$2,64($18)
	lbu	$3,18($4)
	lw	$2,0($2)
	#nop
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L639
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	addu	$5,$5,1
	.set	noreorder
	.set	nomacro
	j	$L633
	sb	$6,18($4)
	.set	macro
	.set	reorder

$L602:
	move	$4,$21
$L638:
	li	$5,21			# 0x00000015
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,10			# 0x0000000a
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,68($18)
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,5			# 0x00000005
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,84($18)
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,6			# 0x00000006
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,76($18)
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,9			# 0x00000009
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,72($18)
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,23			# 0x00000017
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	sw	$2,88($18)
	.set	macro
	.set	reorder

	move	$17,$2
	move	$4,$17
	li	$5,27			# 0x0000001b
	.set	noreorder
	.set	nomacro
	jal	LocateGroupType__15SerializedGroupii
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$16,$2,16
	lbu	$2,12($16)
	#nop
	sb	$2,32($18)
	lbu	$2,14($16)
	#nop
	sb	$2,33($18)
	lbu	$2,16($16)
	move	$4,$17
	sb	$2,34($18)
	lbu	$2,18($16)
	li	$5,25			# 0x00000019
	sb	$2,35($18)
	lbu	$2,20($16)
	move	$6,$19
	sb	$2,36($18)
	lbu	$2,22($16)
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sb	$2,37($18)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$2,$2,4
	sw	$2,40($18)
	lh	$6,12($16)
	li	$5,26			# 0x0000001a
	sll	$3,$6,1
	addu	$3,$3,$6
	sll	$3,$3,1
	addu	$2,$2,$3
	sw	$2,44($18)
	lh	$7,14($16)
	move	$6,$19
	sll	$3,$7,1
	addu	$3,$3,$7
	sll	$3,$3,1
	addu	$2,$2,$3
	sw	$2,48($18)
	lh	$8,20($16)
	move	$7,$0
	sll	$3,$8,1
	addu	$3,$3,$8
	sll	$3,$3,1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,52($18)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,37			# 0x00000025
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,56($18)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,24			# 0x00000018
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,60($18)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,39			# 0x00000027
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,108($18)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,40			# 0x00000028
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,92($18)
	.set	macro
	.set	reorder

	move	$4,$17
	li	$5,41			# 0x00000029
	move	$6,$19
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	LocateCreateGroupType__15SerializedGroupiP9SimpleMemi
	sw	$2,96($18)
	.set	macro
	.set	reorder

	sw	$2,100($18)
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem
	.text
	.ent	Chunk_UpdateSys__FP13DRender_tView
Chunk_UpdateSys__FP13DRender_tView:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Chunk_UpdateSys__FP13DRender_tView
	.text
	.ent	Chunk_Init__Fv
Chunk_Init__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Chunk_Init__Fv
	.text
	.ent	Chunk_DeInit__Fv
Chunk_DeInit__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Chunk_DeInit__Fv
