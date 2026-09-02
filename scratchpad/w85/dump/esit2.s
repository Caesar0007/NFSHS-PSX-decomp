	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\psxfront__region_gate_8456.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Quick_DD__Fiii
	.ent	Quick_DD__Fiii
Quick_DD__Fiii:
	.frame	$sp,48,$31		# vars= 0, regs= 1/0, args= 40, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$4,16($sp)
	move	$4,$0
	sw	$5,20($sp)
	move	$5,$4
	sw	$6,24($sp)
	li	$6,512			# 0x00000200
	li	$7,240			# 0x000000f0
	sw	$31,40($sp)
	sw	$0,28($sp)
	sw	$0,32($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_DirectSetEnvironment__Fiiiiiiiiii
	sw	$0,36($sp)
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

	.end	Quick_DD__Fiii
	.rdata
	.align	2
$LC0:
	.ascii	"ps0\000"
	.align	2
$LC1:
	.ascii	"ps1\000"
	.text
	.align	2
	.globl	PSXFront_AllocateDrawMemory__Fv
	.ent	PSXFront_AllocateDrawMemory__Fv
PSXFront_AllocateDrawMemory__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_InitViewOT__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x3880
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,65536			# 0x00010000
	ori	$5,$5,0x3880
	li	$6,16			# 0x00000010
	lui	$16,%hi(gEnviro) # high
	addiu	$16,$16,%lo(gEnviro) # low
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,20($16)
	.set	macro
	.set	reorder

	li	$5,65536			# 0x00010000
	lui	$3,%hi(Draw_gPlayer1View) # high
	lw	$4,%lo(Draw_gPlayer1View)($3)
	ori	$5,$5,0x3880
	.set	noreorder
	.set	nomacro
	jal	Draw_SetViewMemBudget__Fii
	sw	$2,44($16)
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PSXFront_AllocateDrawMemory__Fv
	.align	2
	.globl	PSXFront_FreeDrawMemory__Fv
	.ent	PSXFront_FreeDrawMemory__Fv
PSXFront_FreeDrawMemory__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	ClearPrimitivesBuffer__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PSXFront_FreeDrawMemory__Fv
	.rdata
	.align	2
$LC2:
	.ascii	"carObj\000"
	.text
	.align	2
	.globl	InitializeSpinningCars__Fv
	.ent	InitializeSpinningCars__Fv
InitializeSpinningCars__Fv:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(rendering3DEnvironmentInitialized) # high
	lbu	$2,%lo(rendering3DEnvironmentInitialized)($2)
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(R3DCar_InMenu) # high
	li	$17,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	sw	$17,%lo(R3DCar_InMenu)($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_InitMenuTexture__Fv
	lui	$16,%hi(inFrontEnd) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CarIO_StartUp__Fv
	sw	$17,%lo(inFrontEnd)($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	R3DCar_StartUp__Fv
	move	$17,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawC_ReadeMapData__Fv
	sw	$0,%lo(inFrontEnd)($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Fe3D_InitShowroom__Fv
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gCarNames) # high
	addiu	$21,$2,%lo(GameSetup_gCarNames) # low
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	addu	$18,$2,980
	lui	$3,%hi(gCarObj) # high
	addiu	$19,$3,%lo(gCarObj) # low
	sw	$0,72($2)
$L14:
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L13
	lui	$4,%hi($LC2) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC2) # low
	li	$5,2268			# 0x000008dc
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	li	$5,2268			# 0x000008dc
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$16,0($19)
	.set	macro
	.set	reorder

	addu	$4,$16,576
	sw	$18,648($16)
	sw	$20,0($18)
	lw	$2,648($16)
	addu	$18,$18,180
	lw	$2,0($2)
	addu	$19,$19,4
	sll	$5,$2,2
	addu	$5,$5,$2
	.set	noreorder
	.set	nomacro
	jal	strcpy
	addu	$5,$5,$21
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	ori	$2,$17,0x0100
	.set	noreorder
	.set	nomacro
	jal	R3DCar_Instantiate3DCar__FP8Car_tObji
	sw	$2,0($16)
	.set	macro
	.set	reorder

	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	j	$L14
	sb	$20,145($16)
	.set	macro
	.set	reorder

$L13:
	jal	R3DCar_PostStartUp__Fv
	lui	$4,%hi(gCView) # high
	addiu	$4,$4,%lo(gCView) # low
	li	$5,140			# 0x0000008c
	lui	$3,%hi(gMenuRotate) # high
	addiu	$2,$3,%lo(gMenuRotate) # low
	sw	$0,4($2)
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$0,%lo(gMenuRotate)($3)
	.set	macro
	.set	reorder

	lui	$4,%hi(DrawC_gMenuColor) # high
	addiu	$3,$4,%lo(DrawC_gMenuColor) # low
	li	$2,-1			# 0xffffffff
	sw	$2,4($3)
	sw	$2,%lo(DrawC_gMenuColor)($4)
	lui	$2,%hi(DrawC_gMenuLights) # high
	sw	$0,%lo(DrawC_gMenuLights)($2)
	lui	$2,%hi(DrawC_gMenuLightsDirection) # high
	lui	$3,%hi(rendering3DEnvironmentInitialized) # high
	sw	$0,%lo(DrawC_gMenuLightsDirection)($2)
	li	$2,1			# 0x00000001
	sb	$2,%lo(rendering3DEnvironmentInitialized)($3)
$L10:
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

	.end	InitializeSpinningCars__Fv
	.rdata
	.align	2
$LC3:
	.ascii	"%sDCT.BIN\000"
	.text
	.align	2
	.globl	CleanupSpinningCars__Fv
	.ent	CleanupSpinningCars__Fv
CleanupSpinningCars__Fv:
	.frame	$sp,96,$31		# vars= 64, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(rendering3DEnvironmentInitialized) # high
	lbu	$2,%lo(rendering3DEnvironmentInitialized)($2)
	subu	$sp,$sp,96
	sw	$31,88($sp)
	sw	$17,84($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	sw	$16,80($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(gCarObj) # high
	addiu	$16,$2,%lo(gCarObj) # low
$L22:
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	R3DCar_DeInstantiate3DCar__FP8Car_tObj
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	addu	$16,$16,4
	.set	macro
	.set	reorder

	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L22
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$16,%hi(inFrontEnd) # high
	.set	noreorder
	.set	nomacro
	jal	R3DCar_CleanUp__Fv
	sw	$2,%lo(inFrontEnd)($16)
	.set	macro
	.set	reorder

	jal	CarIO_CleanUp__Fv
	.set	noreorder
	.set	nomacro
	jal	Texture_KillMenuTexture__Fv
	sw	$0,%lo(inFrontEnd)($16)
	.set	macro
	.set	reorder

	jal	PSXFront_FreeDrawMemory__Fv
	lui	$2,%hi(R3DCar_InMenu) # high
	lui	$3,%hi(gFlip) # high
	sw	$0,%lo(R3DCar_InMenu)($2)
	li	$2,-1			# 0xffffffff
	sw	$2,%lo(gFlip)($3)
	lui	$2,%hi(rendering3DEnvironmentInitialized) # high
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	sb	$0,%lo(rendering3DEnvironmentInitialized)($2)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC3) # high
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi(CF_DVLC) # high
	.set	noreorder
	.set	nomacro
	jal	asyncloadfileat
	addiu	$5,$5,%lo(CF_DVLC) # low
	.set	macro
	.set	reorder

	move	$16,$2
$L24:
	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L17
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L24
$L17:
	lw	$31,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	CleanupSpinningCars__Fv
	.align	2
	.globl	CleanupSpinningCarsMenu__Fv
	.ent	CleanupSpinningCarsMenu__Fv
CleanupSpinningCarsMenu__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(rendering3DEnvironmentInitialized) # high
	lbu	$2,%lo(rendering3DEnvironmentInitialized)($2)
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L27
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(gCarObj) # high
	addiu	$16,$2,%lo(gCarObj) # low
$L29:
	lw	$4,0($16)
	addu	$16,$16,4
	.set	noreorder
	.set	nomacro
	jal	R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj
	addu	$17,$17,1
	.set	macro
	.set	reorder

	slt	$2,$17,2
	bne	$2,$0,$L29
	jal	Texture_CleanupMenuTexture__Fv
	jal	CarIO_ReStart__Fv
$L27:
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

	.end	CleanupSpinningCarsMenu__Fv
	.rdata
	.align	2
$LC4:
	.ascii	"title.psh\000"
	.align	2
$LC5:
	.ascii	"back\000"
	.text
	.align	2
	.globl	DoTitleScreen__Fv
	.ent	DoTitleScreen__Fv
DoTitleScreen__Fv:
	.frame	$sp,104,$31		# vars= 72, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$31,96($sp)
	sw	$17,92($sp)
	.set	noreorder
	.set	nomacro
	jal	elapsedticks
	sw	$16,88($sp)
	.set	macro
	.set	reorder

	lui	$17,%hi(creditShapeFile) # high
	lw	$2,%lo(creditShapeFile)($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L34
	addu	$16,$sp,64
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$5,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(STR_FRMT) # high
	lw	$5,%lo(STR_FRMT)($2)
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	systemtask
	sw	$2,%lo(creditShapeFile)($17)
	.set	macro
	.set	reorder

	lw	$2,%lo(creditShapeFile)($17)
	#nop
	beq	$2,$0,$L33
$L34:
	lui	$5,%hi($LC5) # high
	lw	$4,%lo(creditShapeFile)($17)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	addiu	$5,$5,%lo($LC5) # low
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$0
	move	$6,$4
	.set	noreorder
	.set	nomacro
	jal	Quick_DD__Fiii
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	settrans
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	movfxya
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	settrans
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	Quick_DD__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	lw	$4,%lo(creditShapeFile)($17)
	jal	purgememadr
	lui	$3,%hi(titleScreenDisplayed) # high
	li	$2,1			# 0x00000001
	sw	$0,%lo(creditShapeFile)($17)
	sb	$2,%lo(titleScreenDisplayed)($3)
$L33:
	lw	$31,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	DoTitleScreen__Fv
	.rdata
	.align	2
$LC6:
	.ascii	"yENG\000"
	.align	2
$LC7:
	.ascii	"yITA\000"
	.align	2
$LC8:
	.ascii	"yESP\000"
	.align	2
$LC9:
	.ascii	"bENG\000"
	.align	2
$LC10:
	.ascii	"bITA\000"
	.align	2
$LC11:
	.ascii	"bESP\000"
	.align	2
$LC12:
	.ascii	"lite\000"
	.align	2
$LC13:
	.ascii	"dark\000"
	.align	2
$LC14:
	.word	$LC5
	.word	$LC6
	.word	$LC7
	.word	$LC8
	.word	$LC9
	.word	$LC10
	.word	$LC11
	.word	$LC12
	.word	$LC13
	.align	2
$LC15:
	.byte	0
	.byte	4
	.byte	3
	.align	2
$LC16:
	.ascii	"lang.psh\000"
	.text
	.align	2
	.globl	DoLanguageScreen__Fv
	.ent	DoLanguageScreen__Fv
DoLanguageScreen__Fv:
	.frame	$sp,184,$31		# vars= 136, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,184
	sw	$31,180($sp)
	sw	$22,176($sp)
	sw	$21,172($sp)
	sw	$20,168($sp)
	sw	$19,164($sp)
	sw	$18,160($sp)
	sw	$17,156($sp)
	.set	noreorder
	.set	nomacro
	jal	Front_InitialMemCardCheck__Fv
	sw	$16,152($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+832) # high
	lbu	$3,%lo(frontEnd+832)($2)
	li	$2,255			# 0x000000ff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L36
	addu	$3,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi($LC14) # high
	addiu	$2,$2,%lo($LC14) # low
	addu	$4,$2,32
$L38:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L38
	addu	$3,$3,16
	.set	macro
	.set	reorder

	move	$19,$0
	addu	$16,$sp,104
	move	$4,$16
	move	$17,$19
	addu	$20,$sp,56
	addu	$18,$sp,16
	lw	$8,0($2)
	sw	$8,0($3)
	lui	$2,%hi(STR_FRMT) # high
	lw	$5,%lo(STR_FRMT)($2)
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	lui	$2,%hi($LC15) # high
	lui	$7,%hi($LC16) # high
	addiu	$11,$2,%lo($LC15)
	lb	$8,0($11)
	lb	$9,1($11)
	lb	$10,2($11)
	sb	$8,96($sp)
	sb	$9,97($sp)
	sb	$10,98($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$7,$7,%lo($LC16) # low
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$22,$2
	.set	macro
	.set	reorder

$L39:
	move	$4,$22
	lw	$5,0($18)
	addu	$18,$18,4
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	addu	$17,$17,1
	.set	macro
	.set	reorder

	sw	$2,0($20)
	slt	$2,$17,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L39
	addu	$20,$20,4
	.set	macro
	.set	reorder

	move	$21,$0
	li	$4,1			# 0x00000001
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	Quick_DD__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	settrans
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$4,56($sp)
	move	$5,$21
	move	$6,$21
	.set	noreorder
	.set	nomacro
	jal	movfxya
	addu	$20,$sp,56
	.set	macro
	.set	reorder

	move	$3,$21
	li	$2,2			# 0x00000002
$L64:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L44
	li	$2,8192			# 0x00002000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L44
	addu	$21,$21,1
	.set	macro
	.set	reorder

	slt	$2,$21,2
	bne	$2,$0,$L47
	move	$21,$0
$L47:
	.set	noreorder
	.set	nomacro
	jal	settrans
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$17,$4
	li	$18,4			# 0x00000004
	lw	$2,88($sp)
	lw	$5,84($sp)
	lhu	$3,4($2)
	li	$2,246			# 0x000000f6
	lh	$5,4($5)
	sll	$3,$3,16
	sra	$3,$3,17
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	VSync
	subu	$16,$2,$5
	.set	macro
	.set	reorder

$L48:
	slt	$2,$17,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$17,$L52
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$2,28			# 0x0000001c
$L52:
	move	$5,$16
	addu	$2,$20,$2
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	movfxya
	li	$6,180			# 0x000000b4
	.set	macro
	.set	reorder

	lw	$2,84($sp)
	addu	$4,$20,$18
	lhu	$3,4($2)
	lw	$2,0($4)
	sll	$3,$3,16
	lhu	$2,4($2)
	sra	$3,$3,17
	sll	$2,$2,16
	sra	$2,$2,17
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$17,$L54
	move	$2,$18
	.set	macro
	.set	reorder

	addu	$2,$17,4
	sll	$2,$2,2
$L54:
	addu	$4,$20,$2
	addu	$5,$16,$3
	addu	$2,$sp,$17
	lbu	$3,96($2)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L55
	li	$6,185			# 0x000000b9
	.set	macro
	.set	reorder

	li	$6,184			# 0x000000b8
$L55:
	lw	$4,0($4)
	.set	noreorder
	.set	nomacro
	jal	movfxya
	addu	$18,$18,4
	.set	macro
	.set	reorder

	lw	$2,84($sp)
	addu	$17,$17,1
	lh	$3,4($2)
	addu	$2,$16,10
	.set	noreorder
	.set	nomacro
	j	$L48
	addu	$16,$2,$3
	.set	macro
	.set	reorder

$L49:
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetKeyFromPlayer__F7tPlayerl
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L61
	li	$2,2048			# 0x00000800
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FEInput_GetKeyFromPlayer__F7tPlayerl
	li	$5,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$3,$2
	li	$2,2048			# 0x00000800
$L61:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L62
	li	$2,4096			# 0x00001000
	.set	macro
	.set	reorder

	addu	$19,$19,-1
$L62:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L63
	slt	$2,$19,3
	.set	macro
	.set	reorder

	addu	$19,$19,1
	slt	$2,$19,3
$L63:
	bne	$2,$0,$L59
	li	$19,2			# 0x00000002
$L59:
	.set	noreorder
	.set	nomacro
	bgez	$19,$L64
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L64
	move	$19,$0
	.set	macro
	.set	reorder

$L44:
	move	$4,$22
	addu	$2,$sp,$19
	lbu	$3,96($2)
	lui	$2,%hi(frontEnd+832) # high
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sb	$3,%lo(frontEnd+832)($2)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	Quick_DD__Fiii
	move	$6,$4
	.set	macro
	.set	reorder

	jal	NFS4_LoadingIcon__Fv
$L36:
	lw	$31,180($sp)
	lw	$22,176($sp)
	lw	$21,172($sp)
	lw	$20,168($sp)
	lw	$19,164($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	DoLanguageScreen__Fv
	.align	2
	.globl	PSXExitFrontend__Fv
	.ent	PSXExitFrontend__Fv
PSXExitFrontend__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CleanupSpinningCars__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(PAD_update) # high
	.set	noreorder
	.set	nomacro
	jal	deltimer
	addiu	$4,$4,%lo(PAD_update) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Audio_DeInitDriver__Fv
	lui	$16,%hi(gHelpShapes) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(gHelpShapes)($16)
	#nop
	beq	$4,$0,$L66
	jal	purgememadr
	sw	$0,%lo(gHelpShapes)($16)
$L66:
	lw	$31,20($sp)
	lw	$16,16($sp)
	lui	$2,%hi(ComingIntoTheFrontEndTheVeryFirstTime) # high
	sw	$0,%lo(ComingIntoTheFrontEndTheVeryFirstTime)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PSXExitFrontend__Fv
	.rdata
	.align	2
$LC17:
	.ascii	"gHelpShapes\000"
	.text
	.align	2
	.globl	PSX_AllocShapes__Fv
	.ent	PSX_AllocShapes__Fv
PSX_AllocShapes__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC17) # high
	addiu	$4,$4,%lo($LC17) # low
	li	$5,1888			# 0x00000760
	sw	$16,16($sp)
	lui	$16,%hi(gHelpShapes) # high
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$2
	li	$5,1888			# 0x00000760
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$2,%lo(gHelpShapes)($16)
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PSX_AllocShapes__Fv
	.align	2
	.globl	Init_RenderingEnvironment__Fv
	.ent	Init_RenderingEnvironment__Fv
Init_RenderingEnvironment__Fv:
	.frame	$sp,56,$31		# vars= 0, regs= 4/0, args= 40, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,40($sp)
	lui	$16,%hi(gEnviro) # high
	addiu	$16,$16,%lo(gEnviro) # low
	move	$4,$16
	move	$5,$0
	li	$6,256			# 0x00000100
	li	$7,512			# 0x00000200
	sw	$17,44($sp)
	li	$17,240			# 0x000000f0
	sw	$31,52($sp)
	sw	$18,48($sp)
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$16,24
	move	$5,$0
	move	$6,$5
	li	$7,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Draw_InitViews__Fv
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	move	$6,$4
	li	$7,256			# 0x00000100
	lui	$3,%hi(Draw_gRearView) # high
	li	$2,-1			# 0xffffffff
	sw	$2,%lo(Draw_gRearView)($3)
	li	$2,512			# 0x00000200
	sw	$2,16($sp)
	li	$2,10			# 0x0000000a
	sw	$17,20($sp)
	sw	$0,24($sp)
	sw	$18,28($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_SetView__Fiiiiiiiii
	sw	$2,32($sp)
	.set	macro
	.set	reorder

	lui	$17,%hi(gCView) # high
	addiu	$4,$17,%lo(gCView) # low
	li	$5,140			# 0x0000008c
	lui	$16,%hi(Draw_gPlayer1View) # high
	.set	noreorder
	.set	nomacro
	jal	blockclear
	sw	$2,%lo(Draw_gPlayer1View)($16)
	.set	macro
	.set	reorder

	lw	$2,%lo(Draw_gPlayer1View)($16)
	.set	noreorder
	.set	nomacro
	jal	PSXFront_AllocateDrawMemory__Fv
	sw	$2,%lo(gCView)($17)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	lui	$2,%hi(Draw_gDoVSync) # high
	.set	noreorder
	.set	nomacro
	jal	FETextRender_SetABR__Fib
	sw	$18,%lo(Draw_gDoVSync)($2)
	.set	macro
	.set	reorder

	lw	$31,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	lui	$2,%hi(gFlip) # high
	sw	$0,%lo(gFlip)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	Init_RenderingEnvironment__Fv
	.align	2
	.globl	Init_PSX_FrontEnd__Fv
	.ent	Init_PSX_FrontEnd__Fv
Init_PSX_FrontEnd__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(PAD_update) # high
	addiu	$4,$4,%lo(PAD_update) # low
	lui	$3,%hi(gFlip) # high
	li	$2,-1			# 0xffffffff
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	addtimer
	sw	$2,%lo(gFlip)($3)
	.set	macro
	.set	reorder

	jal	InitGeom
	jal	PSX_AllocShapes__Fv
	jal	Texture_InitMenuClut__Fv
	lui	$3,%hi(screenwidth) # high
	li	$2,512			# 0x00000200
	lui	$4,%hi(screenbpp) # high
	sw	$2,%lo(screenwidth)($3)
	lui	$2,%hi(ComingIntoTheFrontEndTheVeryFirstTime) # high
	lw	$3,%lo(ComingIntoTheFrontEndTheVeryFirstTime)($2)
	li	$2,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L70
	sw	$2,%lo(screenbpp)($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	play_movie__Fc
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L73
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	play_movie__Fc
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$0
$L73:
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	jal	Init_RenderingEnvironment__Fv
	move	$4,$0
	li	$5,20			# 0x00000014
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$4
	.set	macro
	.set	reorder

	jal	DoLanguageScreen__Fv
	lui	$2,%hi(frontEnd+832) # high
	lbu	$4,%lo(frontEnd+832)($2)
	jal	TextSys_LoadWords__Fi
	jal	DoTitleScreen__Fv
	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	initlinkmode
	move	$6,$5
	.set	macro
	.set	reorder

	jal	Front_SecondaryMemCardCheck__Fv
	j	$L72
$L70:
	jal	Init_RenderingEnvironment__Fv
	lui	$2,%hi(frontEnd+832) # high
	lbu	$4,%lo(frontEnd+832)($2)
	jal	TextSys_LoadWords__Fi
$L72:
	jal	FeTools_init__Fv
	li	$4,55296			# 0x0000d800
	li	$5,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	jal	Audio_InitDriver__Fii
	ori	$5,$5,0x8000
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+1092) # high
	lw	$4,%lo(frontEnd+1092)($2)
	jal	SetPlayList__Fi
	jal	AudioCmn_LoadFESamples__Fv
	jal	LoadAllHelpShapes__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Init_PSX_FrontEnd__Fv
	.align	2
	.ent	AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended
AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($7)
	lw	$9,16($sp)
	lw	$10,20($sp)
	lw	$11,24($sp)
	andi	$2,$2,0x0400
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L75
	move	$8,$4
	.set	macro
	.set	reorder

	lh	$3,20($8)
	lw	$2,0($5)
	#nop
	subu	$2,$2,$3
	sw	$2,0($5)
	lh	$3,22($8)
	lw	$2,0($6)
	.set	noreorder
	.set	nomacro
	j	$L101
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L75:
	lw	$2,0($6)
	#nop
	bgtz	$2,$L76
	lh	$3,20($8)
	lw	$2,0($5)
	#nop
	subu	$2,$2,$3
	sw	$2,0($5)
	lh	$2,22($8)
	lw	$3,0($6)
	#nop
	addu	$2,$2,$3
	subu	$2,$0,$2
$L101:
	sw	$2,0($6)
$L76:
	lw	$2,0($7)
	#nop
	andi	$2,$2,0x0100
	beq	$2,$0,$L78
	lhu	$2,16($8)
	lw	$3,0($5)
	sll	$2,$2,16
	sra	$2,$2,17
	subu	$3,$3,$2
	sw	$3,0($5)
	lhu	$2,18($8)
	lw	$3,0($6)
	sll	$2,$2,16
	sra	$2,$2,17
	subu	$3,$3,$2
	sw	$3,0($6)
$L78:
	lw	$2,0($7)
	#nop
	andi	$2,$2,0x0020
	beq	$2,$0,$L79
	lh	$2,0($11)
	lh	$4,18($8)
	lw	$3,0($6)
	sll	$2,$2,1
	addu	$3,$3,$4
	subu	$2,$2,$3
	addu	$2,$2,1
	sw	$2,0($6)
	lw	$2,0($7)
	#nop
	ori	$2,$2,0x0002
	sw	$2,0($7)
$L79:
	lw	$7,0($7)
	#nop
	andi	$2,$7,0x0010
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L80
	andi	$2,$7,0x0080
	.set	macro
	.set	reorder

	lbu	$2,6($11)
	#nop
	mult	$2,$9
	lw	$2,4($11)
	mflo	$3
	#nop
	#nop
	bgez	$3,$L81
	addu	$3,$3,127
$L81:
	sra	$2,$2,8
	andi	$2,$2,0x00ff
	mult	$2,$9
	sra	$2,$3,7
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L82
	sll	$5,$2,16
	.set	macro
	.set	reorder

	addu	$4,$4,127
$L82:
	lbu	$2,4($11)
	#nop
	mult	$2,$9
	sra	$2,$4,7
	sll	$2,$2,8
	mflo	$3
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L83
	or	$4,$5,$2
	.set	macro
	.set	reorder

	addu	$3,$3,127
$L83:
	sra	$2,$3,7
	or	$2,$4,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($10)
	.set	macro
	.set	reorder

$L80:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L85
	andi	$2,$7,0x0040
	.set	macro
	.set	reorder

	move	$8,$0
	sll	$3,$8,16
$L102:
	sra	$3,$3,14
	addu	$7,$11,$3
	lbu	$2,6($7)
	#nop
	mult	$2,$9
	lw	$2,4($7)
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L90
	addu	$3,$3,$10
	.set	macro
	.set	reorder

	addu	$4,$4,127
$L90:
	sra	$2,$2,8
	andi	$2,$2,0x00ff
	mult	$2,$9
	sra	$2,$4,7
	mflo	$5
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$5,$L91
	sll	$6,$2,16
	.set	macro
	.set	reorder

	addu	$5,$5,127
$L91:
	lbu	$2,4($7)
	#nop
	mult	$2,$9
	sra	$2,$5,7
	sll	$2,$2,8
	mflo	$4
	#nop
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$4,$L92
	or	$5,$6,$2
	.set	macro
	.set	reorder

	addu	$4,$4,127
$L92:
	sra	$2,$4,7
	or	$2,$5,$2
	sw	$2,0($3)
	addu	$2,$8,1
	move	$8,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L102
	sll	$3,$8,16
	.set	macro
	.set	reorder

	j	$31
$L85:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L95
	sll	$2,$9,16
	.set	macro
	.set	reorder

	lhu	$5,0($11)
	lhu	$3,0($6)
	#nop
	subu	$2,$5,$3
	addu	$4,$2,1
	sll	$2,$4,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L96
	move	$7,$4
	.set	macro
	.set	reorder

	subu	$7,$0,$4
$L96:
	sll	$2,$7,1
	move	$7,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	bne	$2,$0,$L97
	li	$7,128			# 0x00000080
$L97:
	lhu	$2,18($8)
	#nop
	addu	$2,$3,$2
	subu	$2,$5,$2
	addu	$3,$2,1
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L98
	move	$4,$3
	.set	macro
	.set	reorder

	subu	$4,$0,$3
$L98:
	sll	$2,$4,1
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,129
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L103
	sll	$2,$4,16
	.set	macro
	.set	reorder

	li	$4,128			# 0x00000080
	sll	$2,$4,16
$L103:
	sra	$2,$2,16
	li	$5,128			# 0x00000080
	subu	$2,$5,$2
	sll	$3,$2,16
	sll	$4,$2,8
	or	$3,$3,$4
	or	$3,$3,$2
	sll	$2,$7,16
	sra	$2,$2,16
	subu	$5,$5,$2
	sll	$2,$5,16
	sw	$3,0($10)
	sw	$3,4($10)
	sll	$3,$5,8
	or	$2,$2,$3
	or	$2,$2,$5
	sw	$2,8($10)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,12($10)
	.set	macro
	.set	reorder

$L95:
	sll	$3,$9,8
	or	$2,$2,$3
	or	$2,$2,$9
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($10)
	.set	macro
	.set	reorder

	.end	AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended
	.align	2
	.ent	DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii:
	.frame	$sp,104,$31		# vars= 48, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$20,80($sp)
	move	$20,$4
	move	$14,$5
	move	$10,$6
	sw	$23,92($sp)
	sw	$31,100($sp)
	sw	$fp,96($sp)
	sw	$22,88($sp)
	sw	$21,84($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	lhu	$3,18($20)
	lw	$13,120($sp)
	lhu	$15,16($20)
	andi	$4,$14,0x0002
	sh	$15,16($sp)
	lbu	$5,8($20)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L105
	move	$23,$7
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$2,$2,16
	addu	$23,$23,$2
	subu	$3,$0,$3
$L105:
	lbu	$2,26($20)
	lhu	$24,18($20)
	move	$12,$2
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L106
	sh	$24,24($sp)
	.set	macro
	.set	reorder

	addu	$12,$2,-1
$L106:
 #APP
 #NO_APP
	move	$17,$0
	move	$22,$5
	li	$11,16711680			# 0x00ff0000
	ori	$11,$11,0xffff
	sb	$12,32($sp)
	addu	$fp,$3,$23
$L107:
	sll	$2,$17,16
	lh	$8,16($20)
	sra	$6,$2,16
	slt	$2,$6,$8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L104
	mult	$6,$22
	.set	macro
	.set	reorder

	mflo	$5
	#nop
	#nop
	bgez	$5,$L110
	addu	$5,$5,15
$L110:
	lhu	$4,24($20)
	#nop
	sll	$3,$4,16
	sra	$3,$3,12
	div	$3,$3,$22
	sra	$2,$5,4
	addu	$9,$4,$2
	li	$2,-64			# 0xffffffc0
	and	$2,$9,$2
	sll	$2,$2,16
	sra	$2,$2,12
	div	$2,$2,$22
	addu	$3,$17,$3
	subu	$19,$3,$2
	sll	$2,$19,16
	sra	$2,$2,16
	li	$3,255			# 0x000000ff
	subu	$7,$3,$2
	subu	$3,$8,$6
	slt	$2,$3,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L111
	move	$18,$19
	.set	macro
	.set	reorder

	move	$7,$3
$L111:
	li	$6,528482304			# 0x1f800000
	ori	$6,$6,0x0004
	li	$5,-16777216			# 0xff000000
	lw	$16,0($6)
	lw	$4,528482304
	lw	$3,0($16)
	lw	$2,0($4)
	and	$3,$3,$5
	and	$2,$2,$11
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$3,0($4)
	addu	$2,$16,52
	sw	$2,0($6)
	and	$2,$16,$11
	and	$3,$3,$5
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$2,0($13)
	#nop
	sw	$2,4($16)
	lw	$2,4($13)
	#nop
	sw	$2,16($16)
	lw	$2,8($13)
	#nop
	sw	$2,28($16)
	andi	$2,$14,0x0001
	sll	$2,$2,1
	lw	$3,12($13)
	addu	$2,$2,60
	sb	$2,7($16)
	li	$2,12			# 0x0000000c
	sb	$2,3($16)
	sw	$3,40($16)
	lw	$5,4($20)
	move	$21,$7
	sw	$9,40($sp)
	sw	$10,44($sp)
	sw	$11,48($sp)
	sw	$12,52($sp)
	sw	$13,56($sp)
	sw	$14,60($sp)
	andi	$4,$5,0x003f
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sra	$5,$5,6
	.set	macro
	.set	reorder

	sh	$2,14($16)
	lbu	$3,9($20)
	lw	$15,124($sp)
	lhu	$4,26($20)
	lw	$9,40($sp)
	andi	$3,$3,0x0003
	sll	$3,$3,7
	andi	$2,$15,0x0003
	sll	$2,$2,5
	or	$3,$3,$2
	andi	$2,$4,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	or	$3,$3,$2
	andi	$2,$9,0x03c0
	srl	$2,$2,6
	or	$3,$3,$2
	andi	$4,$4,0x0200
	sll	$4,$4,2
	or	$3,$3,$4
	sh	$3,26($16)
	lw	$14,60($sp)
	lw	$10,44($sp)
	lw	$11,48($sp)
	lw	$12,52($sp)
	lw	$13,56($sp)
	andi	$2,$14,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L112
	move	$6,$0
	.set	macro
	.set	reorder

	lh	$2,16($20)
	#nop
	slt	$2,$2,255
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L116
	move	$5,$21
	.set	macro
	.set	reorder

	addu	$18,$19,-1
	li	$6,1			# 0x00000001
$L112:
	move	$5,$21
$L116:
	addu	$3,$18,$5
	sb	$18,12($16)
	sb	$12,13($16)
	sb	$3,24($16)
	sb	$12,25($16)
	sb	$18,36($16)
	lhu	$24,24($sp)
	lbu	$15,32($sp)
	sb	$3,48($16)
	addu	$2,$24,$15
	sb	$2,37($16)
	sb	$2,49($16)
	sll	$2,$5,16
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L117
	andi	$2,$14,0x0004
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
$L117:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L114
	addu	$3,$6,-1
	.set	macro
	.set	reorder

	lhu	$24,16($sp)
	#nop
	addu	$2,$24,$10
	subu	$2,$2,$17
	addu	$2,$2,$3
	sh	$2,8($16)
 #APP
 #NO_APP
	sh	$23,10($16)
	lhu	$2,16($20)
	addu	$4,$17,$5
	sh	$23,22($16)
	addu	$2,$2,$10
	subu	$2,$2,$4
	addu	$2,$2,$3
	sh	$2,20($16)
	lhu	$2,16($20)
	sh	$fp,34($16)
	addu	$2,$2,$10
	subu	$2,$2,$17
	addu	$2,$2,$3
	sh	$2,32($16)
	lhu	$2,16($20)
	sh	$fp,46($16)
	addu	$2,$2,$10
	subu	$2,$2,$4
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L115
	sh	$2,44($16)
	.set	macro
	.set	reorder

$L114:
	addu	$2,$17,$10
	addu	$3,$5,$2
	sh	$2,8($16)
	sh	$23,10($16)
	sh	$3,20($16)
	sh	$23,22($16)
	sh	$2,32($16)
	sh	$fp,34($16)
	sh	$3,44($16)
	sh	$fp,46($16)
$L115:
	.set	noreorder
	.set	nomacro
	j	$L107
	addu	$17,$17,$5
	.set	macro
	.set	reorder

$L104:
	lw	$31,100($sp)
	lw	$fp,96($sp)
	lw	$23,92($sp)
	lw	$22,88($sp)
	lw	$21,84($sp)
	lw	$20,80($sp)
	lw	$19,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
	.align	2
	.ent	DrawFlatShape__FP18tTexture_ShapeInfoiiiPii
DrawFlatShape__FP18tTexture_ShapeInfoiiiPii:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$2,48($sp)
	lw	$8,52($sp)
	sw	$31,24($sp)
	lw	$3,0($2)
	#nop
	sw	$3,12($2)
	sw	$3,8($2)
	sw	$3,4($2)
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
	sw	$8,20($sp)
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

	.end	DrawFlatShape__FP18tTexture_ShapeInfoiiiPii
	.align	2
	.globl	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	.ent	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
DrawShapeExtended__FiiiiiiP18tDrawShapeExtended:
	.frame	$sp,64,$31		# vars= 16, regs= 4/0, args= 32, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,56($sp)
	lw	$18,84($sp)
	lw	$10,88($sp)
	move	$8,$4
	sw	$5,68($sp)
	andi	$5,$5,0x0008
	sw	$31,60($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	sw	$6,72($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L120
	sw	$7,76($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gHelpShapes) # high
	lw	$3,%lo(gHelpShapes)($2)
	.set	noreorder
	.set	nomacro
	j	$L126
	sll	$2,$8,5
	.set	macro
	.set	reorder

$L120:
	lui	$2,%hi(gCurrentShapes) # high
	lw	$3,%lo(gCurrentShapes)($2)
	sll	$2,$8,5
$L126:
	addu	$16,$3,$2
	li	$2,128			# 0x00000080
	lw	$4,80($sp)
	lw	$3,68($sp)
	#nop
	andi	$3,$3,0x0200
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L122
	subu	$9,$2,$4
	.set	macro
	.set	reorder

	lw	$3,20($10)
	sll	$2,$8,5
	addu	$16,$3,$2
$L122:
	move	$4,$16
	addu	$5,$sp,72
	addu	$6,$sp,76
	addu	$7,$sp,68
	sll	$2,$9,16
	sra	$2,$2,16
	addu	$17,$sp,32
	sw	$2,16($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended
	sw	$10,24($sp)
	.set	macro
	.set	reorder

	lw	$5,68($sp)
	#nop
	andi	$2,$5,0x00c0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L123
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$6,72($sp)
	lw	$7,76($sp)
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	j	$L119
$L123:
	lw	$6,72($sp)
	lw	$7,76($sp)
	sw	$17,16($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawFlatShape__FP18tTexture_ShapeInfoiiiPii
	sw	$18,20($sp)
	.set	macro
	.set	reorder

$L119:
	lw	$31,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	.align	2
	.ent	ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii:
	.frame	$sp,64,$31		# vars= 8, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,40($sp)
	move	$20,$4
	sw	$23,52($sp)
	move	$23,$5
	sw	$22,48($sp)
	move	$22,$6
	sw	$21,44($sp)
	move	$21,$7
	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x0004
	li	$5,16711680			# 0x00ff0000
	ori	$5,$5,0xffff
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lhu	$18,16($20)
	lhu	$17,18($20)
	lw	$19,0($8)
	lw	$6,528482304
	lbu	$9,8($20)
	lw	$2,0($19)
	lw	$3,0($6)
	li	$7,-16777216			# 0xff000000
	sh	$9,16($sp)
	and	$2,$2,$7
	and	$3,$3,$5
	or	$2,$2,$3
	addu	$3,$19,52
	sw	$2,0($19)
	lw	$4,88($sp)
	lw	$16,92($sp)
	lw	$2,0($6)
	and	$5,$19,$5
	sw	$3,0($8)
	and	$2,$2,$7
	or	$2,$2,$5
	sw	$2,0($6)
	lw	$2,0($4)
	#nop
	sw	$2,4($19)
	lw	$2,4($4)
	#nop
	sw	$2,16($19)
	lw	$2,8($4)
	#nop
	sw	$2,28($19)
	lw	$2,12($4)
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	SetPolyGT4
	sw	$2,40($19)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	SetSemiTrans
	andi	$5,$23,0x0001
	.set	macro
	.set	reorder

	lw	$5,4($20)
	#nop
	andi	$4,$5,0x003f
	sll	$4,$4,4
	.set	noreorder
	.set	nomacro
	jal	GetClut
	sra	$5,$5,6
	.set	macro
	.set	reorder

	andi	$16,$16,0x0003
	sll	$16,$16,5
	andi	$fp,$23,0x0004
	sh	$2,14($19)
	lbu	$4,9($20)
	lhu	$5,26($20)
	lhu	$3,24($20)
	andi	$4,$4,0x0003
	sll	$4,$4,7
	or	$4,$4,$16
	andi	$2,$5,0x0100
	sll	$2,$2,16
	sra	$2,$2,20
	or	$4,$4,$2
	andi	$3,$3,0x03c0
	srl	$3,$3,6
	or	$4,$4,$3
	andi	$5,$5,0x0200
	sll	$5,$5,2
	or	$4,$4,$5
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L128
	sh	$4,26($19)
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	sll	$5,$18,16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,16
	.set	macro
	.set	reorder

	addu	$22,$22,$2
	subu	$18,$0,$18
$L128:
	andi	$23,$23,0x0002
	beq	$23,$0,$L129
	lw	$4,84($sp)
	sll	$5,$17,16
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sra	$5,$5,16
	.set	macro
	.set	reorder

	addu	$21,$21,$2
	subu	$17,$0,$17
$L129:
	sll	$18,$18,16
	sra	$18,$18,16
	lw	$4,80($sp)
	move	$5,$18
	sh	$22,8($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$21,10($19)
	.set	macro
	.set	reorder

	sll	$17,$17,16
	sra	$17,$17,16
	move	$5,$17
	addu	$16,$22,-1
	lw	$4,84($sp)
	addu	$2,$16,$2
	sh	$2,20($19)
	sh	$21,22($19)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$22,32($19)
	.set	macro
	.set	reorder

	move	$5,$18
	lw	$4,80($sp)
	addu	$2,$21,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$2,34($19)
	.set	macro
	.set	reorder

	move	$5,$17
	lw	$4,84($sp)
	addu	$16,$16,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sh	$16,44($19)
	.set	macro
	.set	reorder

	addu	$2,$21,$2
	sh	$2,46($19)
	lhu	$2,24($20)
	lhu	$9,16($sp)
	andi	$2,$2,0x003f
	sll	$2,$2,4
	div	$3,$2,$9
	lbu	$6,16($20)
	lbu	$4,18($20)
	lbu	$2,26($20)
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L130
	move	$5,$3
	.set	macro
	.set	reorder

	addu	$5,$3,-1
$L130:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L131
	addu	$3,$5,$6
	.set	macro
	.set	reorder

	addu	$2,$2,-1
$L131:
	sb	$2,13($19)
	sb	$2,25($19)
	addu	$2,$2,$4
	sb	$5,12($19)
	sb	$3,24($19)
	sb	$5,36($19)
	sb	$2,37($19)
	sb	$3,48($19)
	sb	$2,49($19)
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
	.align	2
	.ent	ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lw	$3,64($sp)
	lw	$8,56($sp)
	lw	$9,60($sp)
	lw	$10,68($sp)
	sw	$31,32($sp)
	lw	$2,0($3)
	#nop
	sw	$2,12($3)
	sw	$2,8($3)
	sw	$2,4($3)
	sw	$8,16($sp)
	sw	$9,20($sp)
	sw	$3,24($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
	sw	$10,28($sp)
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
	.align	2
	.globl	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	.ent	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended:
	.frame	$sp,72,$31		# vars= 16, regs= 6/0, args= 32, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$20,64($sp)
	lw	$20,92($sp)
	lw	$10,96($sp)
	move	$9,$4
	sw	$18,56($sp)
	li	$18,131072			# 0x00020000
	sw	$19,60($sp)
	li	$19,65536			# 0x00010000
	sw	$5,76($sp)
	andi	$5,$5,0x0008
	sw	$31,68($sp)
	sw	$17,52($sp)
	sw	$16,48($sp)
	sw	$6,80($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L138
	sw	$7,84($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gHelpShapes) # high
	lw	$3,%lo(gHelpShapes)($2)
	.set	noreorder
	.set	nomacro
	j	$L144
	sll	$2,$9,5
	.set	macro
	.set	reorder

$L138:
	lui	$2,%hi(gCurrentShapes) # high
	lw	$3,%lo(gCurrentShapes)($2)
	sll	$2,$9,5
$L144:
	addu	$16,$3,$2
	li	$2,128			# 0x00000080
	lw	$4,88($sp)
	lw	$3,76($sp)
	#nop
	andi	$3,$3,0x0200
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L140
	subu	$8,$2,$4
	.set	macro
	.set	reorder

	lw	$3,20($10)
	sll	$2,$9,5
	addu	$16,$3,$2
$L140:
	move	$4,$16
	addu	$5,$sp,80
	addu	$6,$sp,84
	addu	$7,$sp,76
	sll	$2,$8,16
	sra	$2,$2,16
	addu	$17,$sp,32
	sw	$2,16($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended
	sw	$10,24($sp)
	.set	macro
	.set	reorder

	lw	$5,76($sp)
	#nop
	andi	$2,$5,0x00c0
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L141
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$6,80($sp)
	lw	$7,84($sp)
	sw	$18,16($sp)
	sw	$19,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
	sw	$20,28($sp)
	.set	macro
	.set	reorder

	j	$L137
$L141:
	lw	$6,80($sp)
	lw	$7,84($sp)
	sw	$18,16($sp)
	sw	$19,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
	sw	$20,28($sp)
	.set	macro
	.set	reorder

$L137:
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

	.end	ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
	.rdata
	.align	2
$LC18:
	.ascii	"%szperm.psh\000"
	.text
	.align	2
	.globl	LoadAllHelpShapes__Fv
	.ent	LoadAllHelpShapes__Fv
LoadAllHelpShapes__Fv:
	.frame	$sp,80,$31		# vars= 48, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+128) # high
	lui	$5,%hi($LC18) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	addiu	$5,$5,%lo($LC18) # low
	sw	$31,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,64($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadshapeadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L145
	move	$16,$0
	.set	macro
	.set	reorder

	lui	$18,%hi(gHelpShapes) # high
	move	$4,$17
$L151:
	move	$5,$16
	sll	$2,$16,5
	lw	$6,%lo(gHelpShapes)($18)
	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	jal	FETexture_LoadPmx__FPciP18tTexture_ShapeInfo
	addu	$6,$6,$2
	.set	macro
	.set	reorder

	slt	$2,$16,59
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L151
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$17
	.set	macro
	.set	reorder

$L145:
	lw	$31,76($sp)
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	LoadAllHelpShapes__Fv
	.align	2
	.globl	PSXDrawSquare__Fiiiii
	.ent	PSXDrawSquare__Fiiiii
PSXDrawSquare__Fiiiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$12,528482304			# 0x1f800000
	ori	$12,$12,0x0004
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$11,-16777216			# 0xff000000
	addu	$7,$5,$7
	lw	$8,0($12)
	lw	$10,528482304
	lw	$3,0($8)
	lw	$2,0($10)
	and	$3,$3,$11
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($8)
	addu	$3,$8,24
	lw	$13,16($sp)
	lw	$2,0($10)
	and	$9,$8,$9
	sw	$3,0($12)
	and	$2,$2,$11
	or	$2,$2,$9
	sw	$2,0($10)
	li	$2,40			# 0x00000028
	sw	$4,4($8)
	sb	$2,7($8)
	li	$2,5			# 0x00000005
	sh	$6,10($8)
	sh	$6,14($8)
	addu	$6,$6,$13
	sb	$2,3($8)
	sh	$5,8($8)
	sh	$7,12($8)
	sh	$5,16($8)
	sh	$6,18($8)
	sh	$7,20($8)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$6,22($8)
	.set	macro
	.set	reorder

	.end	PSXDrawSquare__Fiiiii
	.align	2
	.globl	PSXDrawGouraudSquare__Fiiiiiiii
	.ent	PSXDrawGouraudSquare__Fiiiiiiii
PSXDrawGouraudSquare__Fiiiiiiii:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	sw	$20,32($sp)
	move	$20,$7
	li	$11,528482304			# 0x1f800000
	ori	$11,$11,0x0004
	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	li	$6,-16777216			# 0xff000000
	sw	$31,36($sp)
	sw	$16,16($sp)
	lw	$16,0($11)
	lw	$5,528482304
	lw	$3,0($16)
	lw	$2,0($5)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($16)
	addu	$3,$16,36
	lw	$7,56($sp)
	lw	$8,60($sp)
	lw	$9,64($sp)
	lw	$10,68($sp)
	lw	$2,0($5)
	and	$4,$16,$4
	sw	$3,0($11)
	and	$2,$2,$6
	or	$2,$2,$4
	move	$4,$16
	sw	$2,0($5)
	sw	$7,4($16)
	sw	$8,12($16)
	sw	$9,20($16)
	.set	noreorder
	.set	nomacro
	jal	SetPolyG4
	sw	$10,28($16)
	.set	macro
	.set	reorder

	addu	$18,$19,$18
	sh	$17,10($16)
	sh	$17,18($16)
	addu	$17,$17,$20
	sh	$19,8($16)
	sh	$18,16($16)
	sh	$19,24($16)
	sh	$17,26($16)
	sh	$18,32($16)
	sh	$17,34($16)
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

	.end	PSXDrawGouraudSquare__Fiiiiiiii
	.align	2
	.globl	PSXDrawTransGouraudSquare__Fiiiiiiiii
	.ent	PSXDrawTransGouraudSquare__Fiiiiiiiii
PSXDrawTransGouraudSquare__Fiiiiiiiii:
	.frame	$sp,24,$31		# vars= 0, regs= 5/0, args= 0, extra= 0
	.mask	0x001f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$15,40($sp)
	sw	$20,16($sp)
	lw	$20,44($sp)
	sw	$19,12($sp)
	lw	$19,48($sp)
	sw	$18,8($sp)
	lw	$18,52($sp)
	move	$13,$4
	sw	$17,4($sp)
	lw	$17,56($sp)
	move	$8,$0
	.set	noreorder
	.set	nomacro
	blez	$15,$L154
	sw	$16,0($sp)
	.set	macro
	.set	reorder

	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x0004
	li	$16,528482304			# 0x1f800000
	li	$9,16711680			# 0x00ff0000
	ori	$9,$9,0xffff
	li	$12,-16777216			# 0xff000000
	li	$25,57			# 0x00000039
	li	$24,8			# 0x00000008
	sll	$11,$5,16
	addu	$3,$13,$6
	or	$14,$11,$3
	addu	$2,$5,$7
	sll	$6,$2,16
	or	$7,$6,$3
$L156:
	addu	$8,$8,1
	lw	$4,0($10)
	lw	$5,0($16)
	lw	$3,0($4)
	lw	$2,0($5)
	and	$3,$3,$12
	and	$2,$2,$9
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($5)
	addu	$2,$4,36
	sw	$2,0($10)
	and	$2,$4,$9
	and	$3,$3,$12
	or	$3,$3,$2
	or	$2,$11,$13
	sw	$3,0($5)
	sw	$2,8($4)
	or	$2,$6,$13
	sw	$2,24($4)
	slt	$2,$8,$15
	sw	$20,4($4)
	sw	$19,12($4)
	sw	$18,20($4)
	sw	$17,28($4)
	sb	$25,7($4)
	sb	$24,3($4)
	sw	$14,16($4)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L156
	sw	$7,32($4)
	.set	macro
	.set	reorder

$L154:
	lw	$20,16($sp)
	lw	$19,12($sp)
	lw	$18,8($sp)
	lw	$17,4($sp)
	lw	$16,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	PSXDrawTransGouraudSquare__Fiiiiiiiii
	.align	2
	.globl	PSXDrawTransSquare__Fiiiiis
	.ent	PSXDrawTransSquare__Fiiiiis
PSXDrawTransSquare__Fiiiiis:
	.frame	$sp,8,$31		# vars= 0, regs= 2/0, args= 0, extra= 0
	.mask	0x00030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$17,4($sp)
	move	$17,$4
	move	$13,$5
	move	$14,$6
	lh	$3,28($sp)
	move	$11,$0
	.set	noreorder
	.set	nomacro
	blez	$3,$L160
	sw	$16,0($sp)
	.set	macro
	.set	reorder

	li	$10,528482304			# 0x1f800000
	ori	$10,$10,0x0004
	li	$16,528482304			# 0x1f800000
	li	$8,16711680			# 0x00ff0000
	ori	$8,$8,0xffff
	li	$12,-16777216			# 0xff000000
	li	$25,42			# 0x0000002a
	li	$24,5			# 0x00000005
	addu	$7,$13,$7
	lw	$2,24($sp)
	move	$15,$3
	addu	$9,$14,$2
$L162:
	addu	$5,$11,1
	move	$11,$5
	sll	$5,$5,16
	sra	$5,$5,16
	slt	$5,$5,$15
	lw	$4,0($10)
	lw	$6,0($16)
	lw	$3,0($4)
	lw	$2,0($6)
	and	$3,$3,$12
	and	$2,$2,$8
	or	$3,$3,$2
	sw	$3,0($4)
	lw	$3,0($6)
	addu	$2,$4,24
	sw	$2,0($10)
	and	$2,$4,$8
	and	$3,$3,$12
	or	$3,$3,$2
	sw	$3,0($6)
	sw	$17,4($4)
	sb	$25,7($4)
	sb	$24,3($4)
	sh	$13,8($4)
	sh	$14,10($4)
	sh	$7,12($4)
	sh	$14,14($4)
	sh	$13,16($4)
	sh	$9,18($4)
	sh	$7,20($4)
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L162
	sh	$9,22($4)
	.set	macro
	.set	reorder

$L160:
	lw	$17,4($sp)
	lw	$16,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	PSXDrawTransSquare__Fiiiiis
	.align	2
	.globl	FontUpsideDownBlit__FiiPviiP12charactertbli
	.ent	FontUpsideDownBlit__FiiPviiP12charactertbli
FontUpsideDownBlit__FiiPviiP12charactertbli:
	.frame	$sp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x00010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	li	$3,528482304			# 0x1f800000
	ori	$3,$3,0x0004
	li	$11,16711680			# 0x00ff0000
	ori	$11,$11,0xffff
	lw	$2,28($sp)
	li	$13,-16777216			# 0xff000000
	sw	$16,0($sp)
	lw	$16,24($sp)
	lw	$9,0($3)
	lbu	$15,2($2)
	lbu	$14,3($2)
	lb	$12,10($2)
	addu	$2,$9,40
	sw	$2,0($3)
	lw	$3,0($9)
	lw	$10,528482304
	lw	$8,12($6)
	and	$3,$3,$13
	subu	$24,$5,$12
	addu	$12,$14,$12
	sll	$8,$8,4
	sra	$8,$8,20
	addu	$8,$8,$16
	andi	$8,$8,0x00ff
	lw	$2,0($10)
	addu	$8,$8,-1
	and	$2,$2,$11
	or	$3,$3,$2
	and	$11,$9,$11
	lui	$2,%hi(font_tint) # high
	sw	$3,0($9)
	lw	$3,0($10)
	lw	$2,%lo(font_tint)($2)
	and	$3,$3,$13
	or	$3,$3,$11
	sw	$3,0($10)
	li	$3,9			# 0x00000009
	sw	$2,4($9)
	li	$2,44			# 0x0000002c
	sb	$3,3($9)
	addu	$3,$24,5
	sb	$2,7($9)
	lui	$2,%hi(gFontClut) # high
	lhu	$2,%lo(gFontClut)($2)
	subu	$24,$3,$12
	sh	$2,14($9)
	lbu	$3,0($6)
	lw	$5,12($6)
	addu	$2,$7,$15
	sb	$8,13($9)
	sb	$8,21($9)
	addu	$8,$8,$14
	addu	$14,$24,$14
	addu	$15,$4,$15
	sb	$7,12($9)
	sb	$2,20($9)
	sb	$7,28($9)
	sb	$8,29($9)
	sb	$2,36($9)
	sb	$8,37($9)
	sh	$4,8($9)
	andi	$3,$3,0x0003
	sll	$3,$3,7
	srl	$2,$5,20
	andi	$2,$2,0x0010
	or	$3,$3,$2
	andi	$5,$5,0x03ff
	sra	$5,$5,6
	or	$3,$3,$5
	sh	$3,22($9)
	sh	$14,10($9)
	sh	$15,16($9)
	sh	$14,18($9)
	sh	$4,24($9)
	sh	$24,26($9)
	sh	$15,32($9)
	sh	$24,34($9)
	lw	$16,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	FontUpsideDownBlit__FiiPviiP12charactertbli

	.lcomm	STR_FRMT,8

	.lcomm	ofs,4

	.lcomm	rendering3DEnvironmentInitialized,8
