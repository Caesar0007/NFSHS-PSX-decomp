	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fescreen.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	DisplayLoadingText__7tScreen
	.ent	DisplayLoadingText__7tScreen
DisplayLoadingText__7tScreen:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$3,%hi(_7tScreen_fSuppressLoadingText) # high
	lw	$2,%lo(_7tScreen_fSuppressLoadingText)($3)
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L600
	sw	$0,%lo(_7tScreen_fSuppressLoadingText)($3)
	.set	macro
	.set	reorder

$L601:
	move	$16,$0
	lui	$4,%hi(Draw_gView) # high
	lui	$5,%hi(Draw_gPlayer1View) # high
	lw	$3,%lo(Draw_gPlayer1View)($5)
	addiu	$4,$4,%lo(Draw_gView) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$4
	lbu	$18,32($2)
	move	$17,$5
	sb	$0,124($2)
	sb	$0,32($2)
$L606:
	jal	Draw_StartFrameRender__Fv
	lw	$4,%lo(Draw_gPlayer1View)($17)
	jal	Draw_StartRenderingView__Fi
	li	$4,637			# 0x0000027d
	li	$5,480			# 0x000001e0
	li	$6,220			# 0x000000dc
	li	$7,1			# 0x00000001
	move	$2,$7
	sw	$2,16($sp)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,637			# 0x0000027d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$0
	li	$5,480			# 0x000001e0
	li	$6,220			# 0x000000dc
	subu	$2,$0,$2
	addu	$7,$2,-5
	li	$2,7			# 0x00000007
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$4,%lo(Draw_gPlayer1View)($17)
	jal	Draw_StopRenderingView__Fi
	jal	Draw_StopFrameRender__Fv
	addu	$2,$16,1
	move	$16,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	lui	$2,%hi(Draw_gPlayer1View) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(Draw_gView) # high
	lw	$3,%lo(Draw_gPlayer1View)($2)
	addiu	$4,$4,%lo(Draw_gView) # low
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$4
	sb	$18,124($2)
	sb	$18,32($2)
$L600:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	DisplayLoadingText__7tScreen
	.align	2
	.globl	GoNonInterlaced__7tScreen
	.ent	GoNonInterlaced__7tScreen
GoNonInterlaced__7tScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$8,%hi(screenheight) # high
	li	$2,240			# 0x000000f0
	sw	$2,%lo(screenheight)($8)
	#.set	volatile
	#.set	novolatile
 #APP
 #NO_APP
	lui	$2,%hi(gEnviro) # high
	addiu	$2,$2,%lo(gEnviro) # low
	li	$7,256			# 0x00000100
	lui	$6,%hi(Draw_gView) # high
	lhu	$5,%lo(screenheight)($8)
	lui	$4,%hi(Draw_gPlayer1View) # high
	sw	$31,16($sp)
	#.set	volatile
	sb	$0,16($2)
	#.set	novolatile
	#.set	volatile
	sb	$0,40($2)
	#.set	novolatile
	lw	$3,%lo(Draw_gPlayer1View)($4)
	addiu	$6,$6,%lo(Draw_gView) # low
	sh	$7,2($2)
	sh	$0,26($2)
	sh	$5,6($2)
	sh	$5,14($2)
	sh	$5,38($2)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$6
	sb	$0,31($2)
	lw	$3,%lo(Draw_gPlayer1View)($4)
	move	$4,$0
	sh	$0,10($2)
	sh	$5,14($2)
	sh	$0,16($2)
	sh	$0,18($2)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	sll	$2,$2,3
	lhu	$3,%lo(screenheight)($8)
	addu	$2,$2,$6
	sh	$7,102($2)
	sh	$0,108($2)
	sh	$7,110($2)
	sb	$0,123($2)
	.set	noreorder
	.set	nomacro
	jal	DrawSync
	sh	$3,106($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GoNonInterlaced__7tScreen
	.align	2
	.globl	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	.ent	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi:
	.frame	$sp,88,$31		# vars= 24, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$18,64($sp)
	move	$18,$4
	sw	$19,68($sp)
	move	$19,$5
	sw	$20,72($sp)
	move	$20,$6
	sw	$16,56($sp)
	move	$16,$19
	addu	$2,$16,$20
	sw	$21,76($sp)
	lw	$21,104($sp)
	slt	$2,$16,$2
	sw	$31,80($sp)
	sw	$17,60($sp)
	sw	$7,52($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L609
	sh	$21,32($sp)
	.set	macro
	.set	reorder

	addu	$17,$sp,32
	move	$4,$16
$L616:
	li	$5,512			# 0x00000200
	move	$6,$0
	lh	$2,92($18)
	move	$7,$6
	sw	$0,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$21,$L612
	move	$4,$16
	.set	macro
	.set	reorder

	li	$5,608			# 0x00000260
	move	$6,$0
	lh	$2,92($18)
	move	$7,$6
	sw	$0,20($sp)
	sw	$17,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L612:
	addu	$16,$16,1
	addu	$2,$19,$20
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	move	$4,$16
	.set	macro
	.set	reorder

$L609:
	lw	$31,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	.align	2
	.globl	AsyncLoadPermanentShapeFile__7tScreenPc
	.ent	AsyncLoadPermanentShapeFile__7tScreenPc
AsyncLoadPermanentShapeFile__7tScreenPc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	move	$6,$4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AsyncLoadPermanentShapeFile__7tScreenPc
	.rdata
	.align	2
$LC0:
	.ascii	"z%s\000"
	.text
	.align	2
	.globl	AsyncLoadSwapShapeFile__7tScreenPc
	.ent	AsyncLoadSwapShapeFile__7tScreenPc
AsyncLoadSwapShapeFile__7tScreenPc:
	.frame	$sp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,48($sp)
	move	$16,$4
	move	$6,$5
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L619
	sw	$31,52($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	j	$L621
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L619:
	move	$4,$16
	move	$5,$0
$L621:
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	addu	$6,$4,40
	.set	macro
	.set	reorder

	lw	$31,52($sp)
	lw	$16,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	AsyncLoadSwapShapeFile__7tScreenPc
	.align	2
	.globl	IsShapeFileLoaded__7tScreenR17tShapeInformation
	.ent	IsShapeFileLoaded__7tScreenR17tShapeInformation
IsShapeFileLoaded__7tScreenR17tShapeInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	sw	$17,20($sp)
	lw	$4,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L623
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	jal	getasyncreadstatus
	move	$3,$2
	.set	noreorder
	.set	nomacro
	blez	$3,$L624
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	bne	$2,$0,$L625
	lw	$4,12($16)
	jal	getasyncreadadr
$L625:
	sw	$2,4($16)
	lw	$4,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L635
	sw	$0,12($16)
	.set	macro
	.set	reorder

	lw	$2,36($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	bne	$2,$0,$L628
	jal	purgememadr
$L628:
	.set	noreorder
	.set	nomacro
	j	$L635
	sw	$0,4($16)
	.set	macro
	.set	reorder

$L624:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L630
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lw	$4,12($16)
	jal	getasyncreadadr
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$18
$L641:
	addu	$5,$16,20
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L635
	move	$17,$0
	.set	macro
	.set	reorder

$L630:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L635
	move	$17,$0
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$5,$16,20
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	move	$6,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L635
	move	$17,$0
	.set	macro
	.set	reorder

$L623:
	lw	$2,36($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$4,4($16)
	#nop
	beq	$4,$0,$L637
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L638
	jal	purgememadr
$L638:
	sw	$0,4($16)
$L637:
	sw	$0,36($16)
	move	$4,$18
	addu	$5,$16,20
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	move	$6,$16
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	move	$5,$16
	.set	macro
	.set	reorder

	move	$17,$0
$L635:
	move	$2,$17
$L640:
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

	.end	IsShapeFileLoaded__7tScreenR17tShapeInformation
	.align	2
	.globl	UploadPermanentShapes__7tScreeni
	.ent	UploadPermanentShapes__7tScreeni
UploadPermanentShapes__7tScreeni:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	move	$16,$4
	sll	$5,$5,16
	sra	$5,$5,16
	sw	$5,16($sp)
	move	$5,$16
	move	$6,$0
	move	$7,$6
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadShapes__7tScreenR17tShapeInformationssss
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$3,0($16)
	lw	$31,28($sp)
	lw	$16,24($sp)
	lui	$2,%hi(gCurrentShapes) # high
	sw	$3,%lo(gCurrentShapes)($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	UploadPermanentShapes__7tScreeni
	.align	2
	.globl	UploadSwapShapes__7tScreeni
	.ent	UploadSwapShapes__7tScreeni
UploadSwapShapes__7tScreeni:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sll	$5,$5,16
	sra	$5,$5,16
	sw	$5,16($sp)
	addu	$5,$4,40
	move	$6,$0
	move	$7,$6
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadShapes__7tScreenR17tShapeInformationssss
	sw	$0,20($sp)
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

	.end	UploadSwapShapes__7tScreeni
	.align	2
	.globl	GetShapeInfo__7tScreenRsT1PPcT3
	.ent	GetShapeInfo__7tScreenRsT1PPcT3
GetShapeInfo__7tScreenRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$0,0($6)
	sh	$0,0($5)
	sw	$0,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__7tScreenRsT1PPcT3
	.align	2
	.globl	__7tScreen
	.ent	__7tScreen
__7tScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	move	$5,$16
	move	$6,$0
	lui	$2,%hi(tScreen_vtable) # high
	addiu	$2,$2,%lo(tScreen_vtable) # low
	sw	$31,20($sp)
	sw	$2,96($16)
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	sw	$0,0($16)
	.set	macro
	.set	reorder

	move	$4,$16
	addu	$5,$16,40
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	sw	$0,40($16)
	.set	macro
	.set	reorder

	move	$2,$16
	sh	$0,92($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__7tScreen
	.align	2
	.globl	_._7tScreen
	.ent	_._7tScreen
_._7tScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tScreen_vtable) # high
	addiu	$2,$2,%lo(tScreen_vtable) # low
	andi	$5,$5,0x0001
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L650
	sw	$2,96($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L650:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_._7tScreen
	.align	2
	.globl	Initialize__7tScreen
	.ent	Initialize__7tScreen
Initialize__7tScreen:
	.frame	$sp,56,$31		# vars= 16, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$17,44($sp)
	move	$17,$4
	sw	$31,48($sp)
	.set	noreorder
	.set	nomacro
	jal	DisplayLoadingText__7tScreen
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	lw	$2,96($17)
	#nop
	lh	$4,40($2)
	lw	$2,44($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

	addu	$5,$sp,24
	addu	$2,$sp,32
	lw	$3,96($17)
	addu	$6,$sp,26
	lh	$4,8($3)
	addu	$7,$sp,28
	sw	$2,16($sp)
	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$17,$4
	.set	macro
	.set	reorder

$L652:
	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$3,4($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L655
	move	$16,$2
	.set	macro
	.set	reorder

	lh	$5,24($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadPermanentShapes__7tScreeni
	move	$4,$17
	.set	macro
	.set	reorder

$L655:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L656
	move	$3,$0
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	IsShapeFileLoaded__7tScreenR17tShapeInformation
	addu	$5,$17,40
	.set	macro
	.set	reorder

	sltu	$3,$0,$2
$L656:
	lw	$2,44($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L654
	move	$16,$3
	.set	macro
	.set	reorder

	lh	$5,26($sp)
	.set	noreorder
	.set	nomacro
	jal	UploadSwapShapes__7tScreeni
	move	$4,$17
	.set	macro
	.set	reorder

$L654:
	beq	$16,$0,$L652
	lhu	$2,24($sp)
	lhu	$3,26($sp)
	sh	$2,16($17)
	.set	noreorder
	.set	nomacro
	jal	GoNonInterlaced__7tScreen
	sh	$3,56($17)
	.set	macro
	.set	reorder

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

	.end	Initialize__7tScreen
	.align	2
	.globl	Cleanup__7tScreen
	.ent	Cleanup__7tScreen
Cleanup__7tScreen:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadPermanentShapeFile__7tScreenPc
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	move	$5,$0
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	FreeShapes__7tScreenR17tShapeInformation
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	FreeShapes__7tScreenR17tShapeInformation
	addu	$5,$4,40
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

	.end	Cleanup__7tScreen
	.align	2
	.globl	Draw__7tScreenb
	.ent	Draw__7tScreenb
Draw__7tScreenb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L661
	move	$3,$4
	.set	macro
	.set	reorder

	lw	$2,96($3)
	#nop
	lh	$4,16($2)
	lw	$2,20($2)
	j	$L663
$L661:
	lw	$2,96($3)
	#nop
	lh	$4,24($2)
	lw	$2,28($2)
$L663:
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$3,$4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Draw__7tScreenb
	.rdata
	.align	2
$LC1:
	.ascii	"%s\000"
	.align	2
$LC2:
	.ascii	"%s%s.psh\000"
	.text
	.align	2
	.globl	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	.ent	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
AsyncLoadShapeFile__7tScreenPcR17tShapeInformation:
	.frame	$sp,160,$31		# vars= 128, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$18,152($sp)
	move	$18,$4
	sw	$17,148($sp)
	move	$17,$5
	sw	$16,144($sp)
	move	$16,$6
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L665
	sw	$31,156($sp)
	.set	macro
	.set	reorder

	lw	$4,12($16)
	#nop
	beq	$4,$0,$L665
	jal	cancelasyncload
	sw	$0,12($16)
$L665:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	CancelAsyncLoad__7tScreenR17tShapeInformation
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,4($16)
	#nop
	beq	$4,$0,$L666
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L667
	jal	purgememadr
$L667:
	sw	$0,4($16)
$L666:
	lhu	$2,18($16)
	#nop
	andi	$2,$2,0xfffe
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L664
	sh	$2,18($16)
	.set	macro
	.set	reorder

	addu	$4,$16,20
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	lui	$2,%hi(Paths_Paths+128) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$17
	.set	macro
	.set	reorder

	lw	$2,36($16)
	#nop
	bne	$2,$0,$L664
	lw	$5,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L670
	sw	$0,36($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	asyncloadfileat
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	sw	$2,12($16)
	.set	macro
	.set	reorder

$L670:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	asyncloadfile
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,12($16)
$L664:
	lw	$31,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
	.align	2
	.globl	CancelAsyncLoad__7tScreenR17tShapeInformation
	.ent	CancelAsyncLoad__7tScreenR17tShapeInformation
CancelAsyncLoad__7tScreenR17tShapeInformation:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	lw	$4,12($16)
	#nop
	beq	$4,$0,$L673
	jal	getasyncreadstatus
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L675
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L673
	sw	$2,36($16)
	.set	macro
	.set	reorder

$L675:
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L677
	lw	$4,12($16)
	jal	getasyncreadadr
	sw	$2,4($16)
$L677:
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L678
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L679
	jal	purgememadr
$L679:
	sw	$0,4($16)
$L678:
	sw	$0,12($16)
$L673:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CancelAsyncLoad__7tScreenR17tShapeInformation
	.rdata
	.align	2
$LC3:
	.ascii	"Shapes\000"
	.text
	.align	2
	.globl	InitializeShapes__7tScreenR17tShapeInformationUi
	.ent	InitializeShapes__7tScreenR17tShapeInformationUi
InitializeShapes__7tScreenR17tShapeInformationUi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L681
	move	$17,$6
	.set	macro
	.set	reorder

	jal	purgememadr
	sw	$0,0($16)
$L681:
	sh	$0,18($16)
	sh	$17,16($16)
	sw	$0,12($16)
	sw	$0,4($16)
	sw	$0,8($16)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L682
	sw	$0,36($16)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	sll	$5,$17,5
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,0($16)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L680
	move	$4,$0
	.set	macro
	.set	reorder

	andi	$2,$4,0xffff
$L688:
	addu	$4,$4,1
	lw	$3,0($16)
	sll	$2,$2,5
	addu	$2,$2,$3
	sw	$0,4($2)
	andi	$2,$4,0xffff
	sltu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	andi	$2,$4,0xffff
	.set	macro
	.set	reorder

$L682:
$L680:
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

	.end	InitializeShapes__7tScreenR17tShapeInformationUi
	.align	2
	.globl	FreeShapes__7tScreenR17tShapeInformation
	.ent	FreeShapes__7tScreenR17tShapeInformation
FreeShapes__7tScreenR17tShapeInformation:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	CancelAsyncLoad__7tScreenR17tShapeInformation
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	beq	$2,$0,$L691
	li	$18,-1			# 0xffffffff
	li	$17,-2			# 0xfffffffe
$L692:
	lw	$4,12($16)
	jal	getasyncreadstatus
	bgtz	$2,$L694
	bne	$2,$18,$L693
$L694:
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L695
	lw	$4,12($16)
	jal	getasyncreadadr
	.set	noreorder
	.set	nomacro
	j	$L709
	sw	$2,4($16)
	.set	macro
	.set	reorder

$L695:
	.set	noreorder
	.set	nomacro
	j	$L709
	sw	$0,4($16)
	.set	macro
	.set	reorder

$L693:
	bne	$2,$17,$L697
$L709:
	sw	$0,12($16)
$L697:
	.set	noreorder
	.set	nomacro
	jal	FeAudio_systemtask__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	bne	$2,$0,$L692
$L691:
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L700
	lw	$2,8($16)
	#nop
	bne	$2,$0,$L701
	jal	purgememadr
$L701:
	sw	$0,4($16)
$L700:
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L689
	lhu	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L703
	move	$17,$0
	.set	macro
	.set	reorder

	sll	$2,$17,16
$L711:
	lw	$3,0($16)
	sra	$2,$2,11
	addu	$3,$2,$3
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	addu	$2,$17,1
	.set	macro
	.set	reorder

	lh	$4,4($3)
	jal	Texture_MenuReleaseClutId__Fs
	addu	$2,$17,1
$L710:
	move	$17,$2
	sll	$2,$2,16
	lhu	$3,16($16)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L711
	sll	$2,$17,16
	.set	macro
	.set	reorder

$L703:
	lw	$4,0($16)
	jal	purgememadr
	sw	$0,0($16)
$L689:
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

	.end	FreeShapes__7tScreenR17tShapeInformation
	.align	2
	.globl	UploadShapes__7tScreenR17tShapeInformationssss
	.ent	UploadShapes__7tScreenR17tShapeInformationssss
UploadShapes__7tScreenR17tShapeInformationssss:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	lw	$3,80($sp)
	lw	$4,84($sp)
	sw	$18,32($sp)
	move	$18,$5
	sw	$fp,56($sp)
	move	$fp,$6
	sw	$23,52($sp)
	move	$23,$7
	sw	$31,60($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$2,4($18)
	move	$19,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L712
	move	$22,$4
	.set	macro
	.set	reorder

	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L727
	sll	$2,$19,16
	.set	macro
	.set	reorder

	lhu	$19,16($18)
	#nop
	sll	$2,$19,16
$L727:
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L716
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$4,16
	sra	$21,$2,16
	move	$20,$3
	addu	$2,$16,$21
$L728:
	lw	$3,0($18)
	sll	$17,$2,5
	addu	$3,$17,$3
	lw	$2,4($3)
	#nop
	beq	$2,$0,$L717
	lh	$4,4($3)
	jal	Texture_MenuReleaseClutId__Fs
	lw	$2,0($18)
	#nop
	addu	$2,$17,$2
	sw	$0,4($2)
$L717:
	addu	$16,$16,1
	slt	$2,$16,$20
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L728
	addu	$2,$16,$21
	.set	macro
	.set	reorder

$L716:
	lhu	$2,18($18)
	#nop
	andi	$2,$2,0xfffe
	sh	$2,18($18)
	sll	$2,$19,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L722
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$22,16
	sra	$21,$2,16
	sll	$20,$23,16
	sll	$2,$fp,16
	sra	$19,$2,16
	move	$17,$3
$L724:
	addu	$6,$16,$21
	move	$5,$16
	addu	$16,$16,1
	sll	$6,$6,5
	lw	$2,0($18)
	sra	$7,$20,16
	sw	$19,16($sp)
	lw	$4,4($18)
	.set	noreorder
	.set	nomacro
	jal	FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	slt	$2,$16,$17
	bne	$2,$0,$L724
$L722:
	lhu	$2,18($18)
	lw	$3,8($18)
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L726
	sh	$2,18($18)
	.set	macro
	.set	reorder

	lw	$4,4($18)
	jal	purgememadr
$L726:
	sw	$0,4($18)
$L712:
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

	.end	UploadShapes__7tScreenR17tShapeInformationssss
	.align	2
	.globl	PreLoad__7tScreen
	.ent	PreLoad__7tScreen
PreLoad__7tScreen:
	.frame	$sp,48,$31		# vars= 16, regs= 2/0, args= 24, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,40($sp)
	move	$16,$4
	addu	$5,$sp,24
	addu	$6,$sp,26
	sw	$31,44($sp)
	lw	$3,96($16)
	addu	$2,$sp,32
	lh	$4,8($3)
	addu	$7,$sp,28
	sw	$2,16($sp)
	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$16,$4
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$6,24($sp)
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
	lh	$6,26($sp)
	.set	noreorder
	.set	nomacro
	jal	InitializeShapes__7tScreenR17tShapeInformationUi
	addu	$5,$16,40
	.set	macro
	.set	reorder

	lw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadPermanentShapeFile__7tScreenPc
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$5,32($sp)
	.set	noreorder
	.set	nomacro
	jal	AsyncLoadSwapShapeFile__7tScreenPc
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	PreLoad__7tScreen
	.align	2
	.globl	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	.ent	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,1			# 0x00000001
	sh	$0,92($4)
	sw	$0,88($4)
	sw	$2,84($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,80($4)
	.set	macro
	.set	reorder

	.end	TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
	.align	2
	.globl	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
	.ent	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,128			# 0x00000080
	sh	$2,92($4)
	lui	$2,%hi(ticks) # high
	lw	$3,%lo(ticks)($2)
	li	$2,128			# 0x00000080
	sw	$2,88($4)
	sw	$0,84($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,80($4)
	.set	macro
	.set	reorder

	.end	TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
	.align	2
	.globl	UpdateTransition__7tScreen
	.ent	UpdateTransition__7tScreen
UpdateTransition__7tScreen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,84($4)
	lw	$3,88($4)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	addu	$2,$3,12
	.set	macro
	.set	reorder

	addu	$2,$3,-12
$L733:
	sw	$2,88($4)
	move	$3,$2
	slt	$2,$3,-50
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L739
	slt	$2,$3,151
	.set	macro
	.set	reorder

	li	$3,-50			# 0xffffffce
	slt	$2,$3,151
$L739:
	bne	$2,$0,$L736
	li	$3,150			# 0x00000096
$L736:
	sw	$3,88($4)
	lhu	$2,88($4)
	#nop
	sh	$2,92($4)
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L737
	slt	$2,$2,129
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,92($4)
	.set	macro
	.set	reorder

$L737:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L740
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	sh	$2,92($4)
$L740:
	j	$31
	.end	UpdateTransition__7tScreen
	.align	2
	.globl	TransitionIsFinished__7tScreen
	.ent	TransitionIsFinished__7tScreen
TransitionIsFinished__7tScreen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,88($4)
	#nop
	addu	$2,$2,24
	sltu	$2,$2,167
	.set	noreorder
	.set	nomacro
	j	$31
	xori	$2,$2,0x0001
	.set	macro
	.set	reorder

	.end	TransitionIsFinished__7tScreen
	.align	2
	.globl	ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	DrawForeground__7tScreen
	.ent	DrawForeground__7tScreen
DrawForeground__7tScreen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DrawForeground__7tScreen
	.align	2
	.globl	DrawBackground__7tScreen
	.ent	DrawBackground__7tScreen
DrawBackground__7tScreen:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	DrawBackground__7tScreen
