	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\genericpmx.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"%sSfx4w.psh\000"
	.align	2
$LC1:
	.ascii	"%sSfx4.psh\000"
	.align	2
$LC2:
	.ascii	"%sSfx.psh\000"
	.sdata
	.align	2
$LC3:
	.ascii	"LIN%d\000"
	.align	2
$LC4:
	.ascii	"spik\000"
	.align	2
$LC5:
	.ascii	"DEBG\000"
	.align	2
$LC6:
	.ascii	"SHAD\000"
	.align	2
$LC7:
	.ascii	"SKD0\000"
	.align	2
$LC8:
	.ascii	"SKD1\000"
	.align	2
$LC9:
	.ascii	"FLAK\000"
	.align	2
$LC10:
	.ascii	"FLA1\000"
	.align	2
$LC11:
	.ascii	"SPLT\000"
	.align	2
$LC12:
	.ascii	"SMX0\000"
	.align	2
$LC13:
	.ascii	"SMX1\000"
	.align	2
$LC14:
	.ascii	"SMOK\000"
	.align	2
$LC15:
	.ascii	"DIRT\000"
	.align	2
$LC16:
	.ascii	"GRX0\000"
	.align	2
$LC17:
	.ascii	"GRX1\000"
	.align	2
$LC18:
	.ascii	"GRAV\000"
	.align	2
$LC19:
	.ascii	"GRAS\000"
	.align	2
$LC20:
	.ascii	"SNOW\000"
	.align	2
$LC21:
	.ascii	"SHX%d\000"
	.align	2
$LC22:
	.ascii	"LF%02d\000"
	.align	2
$LC23:
	.ascii	"DAMG\000"
	.align	2
$LC24:
	.ascii	"LNG%d\000"
	.align	2
$LC25:
	.ascii	"MONF\000"
	.align	2
$LC26:
	.ascii	"FLR0\000"
	.align	2
$LC27:
	.ascii	"FLR1\000"
	.align	2
$LC28:
	.ascii	"RBOW\000"
	.text
	.align	2
	.globl	GenericPMX_LoadTexture__Fv
	.globl	gDLPixmap
	.data
	.align	2
gDLPixmap:
	.space	40
	.globl	gFlarePixmap
	.align	2
gFlarePixmap:
	.space	12
	.globl	gLightningPixmap
	.align	2
gLightningPixmap:
	.space	64
	.globl	gSparkHPixmap
	.align	2
gSparkHPixmap:
	.space	24
	.globl	gStartUpPixmap
	.align	2
gStartUpPixmap:
	.space	16
	.globl	gWeatherPixmap
	.align	2
gWeatherPixmap:
	.space	12
	.globl	gPixmaps
	.align	2
gPixmaps:
	.space	1136
	.globl	gDPixmap
	.sdata
	.align	2
gDPixmap:
	.space	4
	.globl	gSpikeBeltPixmap
	.align	2
gSpikeBeltPixmap:
	.space	4
	.globl	gShadowPixmap
	.align	2
gShadowPixmap:
	.space	8
	.globl	gSkidMarkPixmap
	.align	2
gSkidMarkPixmap:
	.space	8
	.globl	gSMokePixmap
	.align	2
gSMokePixmap:
	.space	8
	.globl	gSMokePalette
	.align	2
gSMokePalette:
	.space	4
	.globl	gDirtPalette
	.align	2
gDirtPalette:
	.space	4
	.globl	gGravelPixmap
	.align	2
gGravelPixmap:
	.space	8
	.globl	gGravelPalette
	.align	2
gGravelPalette:
	.space	4
	.globl	gGrassPalette
	.align	2
gGrassPalette:
	.space	4
	.globl	gSnowPalette
	.align	2
gSnowPalette:
	.space	4
	.globl	gLeafPixmap
	.align	2
gLeafPixmap:
	.space	4
	.globl	gDamagePixmap
	.align	2
gDamagePixmap:
	.space	4

	.extern	TrackSpec_gSpec, 264
	.extern	Paths_Paths, 200
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	GenericPMX_LoadTexture__Fv
GenericPMX_LoadTexture__Fv:
	.frame	$sp,336,$31		# vars= 264, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,336
	sw	$21,316($sp)
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$4,$2,%lo(GameSetup_gData) # low
	sw	$31,332($sp)
	sw	$fp,328($sp)
	sw	$23,324($sp)
	sw	$22,320($sp)
	sw	$20,312($sp)
	sw	$19,308($sp)
	sw	$18,304($sp)
	sw	$17,300($sp)
	sw	$16,296($sp)
	lw	$2,60($4)
	li	$3,4			# 0x00000004
	andi	$2,$2,0x000f
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L601
	move	$21,$0
	.set	macro
	.set	reorder

	lw	$2,72($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L602
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$2,%hi(Paths_Paths+100) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	lui	$5,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	j	$L626
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

$L602:
	lui	$2,%hi(Paths_Paths+100) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	lui	$5,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$L626
	addiu	$5,$5,%lo($LC1) # low
	.set	macro
	.set	reorder

$L601:
	addu	$4,$sp,32
	lui	$2,%hi(Paths_Paths+100) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
$L626:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$23,$0
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	move	$22,$2
	.set	macro
	.set	reorder

	move	$18,$23
	lui	$2,%hi(gPixmaps) # high
	addiu	$20,$2,%lo(gPixmaps) # low
	li	$19,-1			# 0xffffffff
	lui	$2,%hi(gDLPixmap) # high
	addiu	$17,$2,%lo(gDLPixmap) # low
$L605:
	slt	$2,$18,10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	lui	$5,%hi($LC3) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	addiu	$5,$5,%lo($LC3) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	addu	$5,$sp,32
	ori	$6,$23,0x0040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$20
	sw	$8,16($sp)
	sw	$19,20($sp)
	sw	$19,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sw	$16,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L605
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L606:
	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	li	$20,-1			# 0xffffffff
	lui	$2,%hi(gPixmaps) # high
	addiu	$23,$2,%lo(gPixmaps) # low
	addu	$17,$17,$23
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC5) # high
	addiu	$5,$5,%lo($LC5) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$17,gSpikeBeltPixmap
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC6) # high
	addiu	$5,$5,%lo($LC6) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$17,$17,$23
	sw	$16,gDPixmap
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC7) # high
	addiu	$5,$5,%lo($LC7) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$17,gShadowPixmap
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	lui	$5,%hi($LC8) # high
	addiu	$5,$5,%lo($LC8) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	sw	$16,gSkidMarkPixmap
	sll	$16,$21,4
	addu	$16,$16,$23
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	lw	$4,gSkidMarkPixmap
	li	$5,2			# 0x00000002
	sw	$16,gSkidMarkPixmap+4
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lw	$4,gSkidMarkPixmap+4
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	addu	$21,$21,1
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC9) # high
	addiu	$5,$5,%lo($LC9) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$18,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC10) # high
	addiu	$5,$5,%lo($LC10) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	lui	$19,%hi(gWeatherPixmap) # high
	li	$8,160			# 0x000000a0
	addu	$18,$18,$23
	sw	$16,%lo(gWeatherPixmap)($19)
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$18,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC11) # high
	addiu	$5,$5,%lo($LC11) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	addiu	$17,$19,%lo(gWeatherPixmap) # low
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$18,4($17)
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	lw	$4,%lo(gWeatherPixmap)($19)
	li	$5,1			# 0x00000001
	sw	$16,8($17)
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lw	$4,4($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lw	$4,8($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L609:
	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC12) # high
	addiu	$5,$5,%lo($LC12) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC13) # high
	addiu	$5,$5,%lo($LC13) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$17,$17,$23
	sw	$16,gSMokePixmap
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC14) # high
	addiu	$5,$5,%lo($LC14) # low
	move	$6,$0
	li	$7,-1			# 0xffffffff
	addu	$16,$16,$23
	sw	$17,gSMokePixmap+4
	sw	$20,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC15) # high
	addiu	$5,$5,%lo($LC15) # low
	move	$6,$0
	li	$7,-1			# 0xffffffff
	addu	$17,$17,$23
	sw	$16,gSMokePalette
	sw	$20,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC16) # high
	addiu	$5,$5,%lo($LC16) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$23
	sw	$17,gDirtPalette
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC17) # high
	addiu	$5,$5,%lo($LC17) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$17,$17,$23
	sw	$16,gGravelPixmap
	sw	$8,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC18) # high
	addiu	$5,$5,%lo($LC18) # low
	move	$6,$0
	li	$7,-1			# 0xffffffff
	addu	$16,$16,$23
	sw	$17,gGravelPixmap+4
	sw	$20,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$17,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC19) # high
	addiu	$5,$5,%lo($LC19) # low
	move	$6,$0
	li	$7,-1			# 0xffffffff
	addu	$17,$17,$23
	sw	$16,gGravelPalette
	sw	$20,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC20) # high
	addiu	$5,$5,%lo($LC20) # low
	move	$6,$0
	li	$7,-1			# 0xffffffff
	addu	$16,$16,$23
	sw	$17,gGrassPalette
	sw	$20,16($sp)
	sw	$20,20($sp)
	sw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	move	$18,$0
	move	$20,$23
	li	$19,-1			# 0xffffffff
	lui	$2,%hi(gSparkHPixmap) # high
	addiu	$17,$2,%lo(gSparkHPixmap) # low
	sw	$16,gSnowPalette
$L610:
	slt	$2,$18,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L611
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$5,%hi($LC21) # high
	addiu	$5,$5,%lo($LC21) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	addu	$5,$sp,32
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$20
	sw	$8,16($sp)
	sw	$19,20($sp)
	sw	$19,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sw	$16,0($17)
	addu	$17,$17,4
	.set	noreorder
	.set	nomacro
	j	$L610
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L611:
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$5,$2,%lo(GameSetup_gData) # low
	lw	$2,84($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,12($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L614
	addu	$16,$sp,288
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$6,60($5)
	lui	$5,%hi($LC22) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC22) # low
	.set	macro
	.set	reorder

	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	sll	$16,$21,4
	.set	macro
	.set	reorder

	addu	$21,$21,1
	move	$4,$0
	move	$5,$2
	li	$6,64			# 0x00000040
	move	$7,$4
	li	$8,160			# 0x000000a0
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	lui	$2,%hi(gPixmaps) # high
	addiu	$2,$2,%lo(gPixmaps) # low
	addu	$16,$16,$2
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sw	$16,gLeafPixmap
	.set	noreorder
	.set	nomacro
	j	$L627
	move	$4,$22
	.set	macro
	.set	reorder

$L614:
	sw	$0,gLeafPixmap
	move	$4,$22
$L627:
	lui	$5,%hi($LC23) # high
	addiu	$5,$5,%lo($LC23) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	li	$2,-1			# 0xffffffff
	sll	$16,$21,4
	sw	$2,20($sp)
	sw	$2,24($sp)
	lui	$2,%hi(gPixmaps) # high
	addiu	$17,$2,%lo(gPixmaps) # low
	addu	$16,$16,$17
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+72) # high
	lw	$2,%lo(GameSetup_gData+72)($2)
	sw	$16,gDamagePixmap
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	addu	$21,$21,1
	.set	macro
	.set	reorder

	move	$18,$0
	move	$fp,$17
	li	$23,-1			# 0xffffffff
	lui	$2,%hi(gLightningPixmap) # high
	addiu	$19,$2,%lo(gLightningPixmap) # low
	li	$20,32			# 0x00000020
	slt	$2,$18,8
$L628:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$5,%hi($LC24) # high
	addiu	$5,$5,%lo($LC24) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$18
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	addu	$5,$sp,32
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	addu	$16,$16,$fp
	sw	$8,16($sp)
	sw	$23,20($sp)
	sw	$23,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	sll	$2,$21,4
	addu	$21,$21,1
	li	$5,1			# 0x00000001
	lui	$8,%hi(gLightningPixmap) # high
	addiu	$8,$8,%lo(gLightningPixmap) # low
	addu	$17,$20,$8
	addu	$20,$20,4
	addu	$2,$2,$fp
	sw	$16,0($19)
	sw	$2,0($17)
	lw	$4,0($19)
	addu	$18,$18,$5
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$4,0($19)
	lw	$6,0($17)
	.set	noreorder
	.set	nomacro
	jal	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	addu	$19,$19,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L628
	slt	$2,$18,8
	.set	macro
	.set	reorder

$L618:
	lui	$2,%hi(TrackSpec_gSpec) # high
	addiu	$17,$2,%lo(TrackSpec_gSpec) # low
	lw	$2,92($17)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	sll	$16,$21,4
	.set	macro
	.set	reorder

	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC25) # high
	addiu	$5,$5,%lo($LC25) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	lui	$2,%hi(gPixmaps) # high
	addiu	$2,$2,%lo(gPixmaps) # low
	addu	$16,$16,$2
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gFlarePixmap) # high
	sw	$16,%lo(gFlarePixmap)($2)
$L624:
	lw	$2,92($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	sll	$17,$21,4
	.set	macro
	.set	reorder

	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC26) # high
	addiu	$5,$5,%lo($LC26) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	li	$8,160			# 0x000000a0
	li	$18,-1			# 0xffffffff
	lui	$19,%hi(gPixmaps) # high
	addiu	$19,$19,%lo(gPixmaps) # low
	addu	$17,$17,$19
	sw	$8,16($sp)
	sw	$18,20($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	sll	$16,$21,4
	addu	$21,$21,1
	move	$4,$22
	lui	$5,%hi($LC27) # high
	addiu	$5,$5,%lo($LC27) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	lui	$20,%hi(gFlarePixmap) # high
	li	$8,160			# 0x000000a0
	addu	$16,$16,$19
	sw	$17,%lo(gFlarePixmap)($20)
	sw	$8,16($sp)
	sw	$18,20($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	move	$4,$22
	lui	$5,%hi($LC28) # high
	addiu	$5,$5,%lo($LC28) # low
	li	$6,64			# 0x00000040
	move	$7,$0
	addiu	$17,$20,%lo(gFlarePixmap) # low
	li	$8,160			# 0x000000a0
	sw	$16,4($17)
	sll	$16,$21,4
	addu	$16,$16,$19
	sw	$8,16($sp)
	sw	$18,20($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$16,28($sp)
	.set	macro
	.set	reorder

	lw	$4,%lo(gFlarePixmap)($20)
	li	$5,1			# 0x00000001
	sw	$16,8($17)
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lw	$4,4($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

	lw	$4,8($17)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L623:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$22
	.set	macro
	.set	reorder

	lw	$31,332($sp)
	lw	$fp,328($sp)
	lw	$23,324($sp)
	lw	$22,320($sp)
	lw	$21,316($sp)
	lw	$20,312($sp)
	lw	$19,308($sp)
	lw	$18,304($sp)
	lw	$17,300($sp)
	lw	$16,296($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,336
	.set	macro
	.set	reorder

	.end	GenericPMX_LoadTexture__Fv
