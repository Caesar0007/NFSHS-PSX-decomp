	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\loading.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"%sLoad%d%c.qps\000"
	.align	2
$LC1:
	.ascii	"%sLoada.psh\000"
	.text
	.align	2
	.globl	Loading_DrawLoadingScreen__Fv
	.rdata
	.align	2
$LC2:
	.ascii	"%sLoadb.psh\000"
	.align	2
$LC3:
	.ascii	"back\000"
	.text
	.align	2
	.globl	Loading_UpdateLoadingScreen__Fi
	.align	2
	.globl	Loading_GetInitialMemory__Fv
	.globl	smallShapeFile
	.sdata
	.align	2
smallShapeFile:
	.space	4
	.globl	totalAvailMem
	.align	2
totalAvailMem:
	.space	4

	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	Loading_DrawLoadingScreen__Fv
Loading_DrawLoadingScreen__Fv:
	.frame	$sp,304,$31		# vars= 256, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,304
	addu	$4,$sp,32
	lui	$5,%hi($LC0) # high
	sw	$16,288($sp)
	lui	$16,%hi(Paths_Paths) # high
	addiu	$16,$16,%lo(Paths_Paths) # low
	lui	$3,%hi(GameSetup_gData) # high
	addiu	$3,$3,%lo(GameSetup_gData) # low
	sw	$31,300($sp)
	sw	$18,296($sp)
	sw	$17,292($sp)
	lw	$6,100($16)
	lw	$2,44($3)
	lw	$7,60($3)
	addu	$2,$2,97
	sw	$2,16($sp)
	lw	$17,224($3)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	lw	$6,100($16)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$18,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	li	$4,512			# 0x00000200
	li	$5,240			# 0x000000f0
	li	$6,1			# 0x00000001
	move	$7,$0
	move	$3,$6
	move	$16,$2
	sw	$3,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetEnvironment__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	shapepointer
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$2
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	Draw_DrawDirectScreen__FP8shapetblii
	move	$6,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(D_80120D00) # high
	addiu	$2,$2,%lo(D_80120D00) # low
	sll	$17,$17,2
	addu	$17,$17,$2
	lw	$5,0($17)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$6,12($2)
	move	$4,$2
	sll	$5,$6,20
	sra	$5,$5,20
	sll	$6,$6,4
	.set	noreorder
	.set	nomacro
	jal	Draw_DrawDirectScreen__FP8shapetblii
	sra	$6,$6,20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,512			# 0x00000200
	li	$5,240			# 0x000000f0
	move	$6,$0
	li	$7,1			# 0x00000001
	sw	$0,16($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetEnvironment__Fiiiiiiii
	sw	$0,28($sp)
	.set	macro
	.set	reorder

	lw	$31,300($sp)
	lw	$18,296($sp)
	lw	$17,292($sp)
	lw	$16,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,304
	.set	macro
	.set	reorder

	.end	Loading_DrawLoadingScreen__Fv
	.text
	.ent	Loading_UpdateLoadingScreen__Fi
Loading_UpdateLoadingScreen__Fi:
	.frame	$sp,296,$31		# vars= 256, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,296
	sw	$19,284($sp)
	move	$19,$4
	sw	$18,280($sp)
	li	$18,23			# 0x00000017
	li	$2,1			# 0x00000001
	sw	$31,292($sp)
	sw	$20,288($sp)
	sw	$17,276($sp)
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L602
	sw	$16,272($sp)
	.set	macro
	.set	reorder

	lw	$2,smallShapeFile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(Paths_Paths+100) # high
	lui	$5,%hi($LC2) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,smallShapeFile
$L602:
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L603
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$20,%hi($LC3) # high
	addu	$3,$19,-1
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$17,$2,$3
$L604:
	lw	$4,smallShapeFile
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	addiu	$5,$20,%lo($LC3) # low
	.set	macro
	.set	reorder

	move	$4,$2
	addu	$5,$16,142
	addu	$5,$17,$5
	.set	noreorder
	.set	nomacro
	jal	Draw_DrawDirectScreen__FP8shapetblii
	li	$6,192			# 0x000000c0
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,$18
	bne	$2,$0,$L604
$L603:
	li	$2,10			# 0x0000000a
	bne	$19,$2,$L601
	lw	$4,smallShapeFile
	#nop
	beq	$4,$0,$L601
	jal	purgememadr
	sw	$0,smallShapeFile
$L601:
	lw	$31,292($sp)
	lw	$20,288($sp)
	lw	$19,284($sp)
	lw	$18,280($sp)
	lw	$17,276($sp)
	lw	$16,272($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,296
	.set	macro
	.set	reorder

	.end	Loading_UpdateLoadingScreen__Fi
	.text
	.ent	Loading_GetInitialMemory__Fv
Loading_GetInitialMemory__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	largestunused
	lw	$31,16($sp)
	sw	$2,totalAvailMem
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Loading_GetInitialMemory__Fv
