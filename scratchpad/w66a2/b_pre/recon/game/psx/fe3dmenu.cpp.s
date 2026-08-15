	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\fe3dmenu.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Fe3D_InitShowroom__Fv
	.align	2
	.globl	CameraLookAt__FP10matrixtdefP8coorddef
	.align	2
	.globl	Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii

	.extern	gMenuRotate, 8
	.extern	Fe3D_lightsVertex, 384
	.extern	Fe3D_spotVertex, 198

	.text
	.text
	.ent	Fe3D_InitShowroom__Fv
Fe3D_InitShowroom__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	move	$18,$17
	lui	$2,%hi(Fe3D_spotVertex) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(Fe3D_spotVertex) # low
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
$L601:
	.set	noreorder
	.set	nomacro
	jal	csin
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$3,$2,4
	sll	$2,$2,5
	addu	$2,$2,$3
	sra	$2,$2,8
	sh	$2,0($16)
	.set	noreorder
	.set	nomacro
	jal	ccos
	sh	$0,2($16)
	.set	macro
	.set	reorder

	addu	$17,$17,128
	sll	$3,$2,4
	sll	$2,$2,5
	addu	$2,$2,$3
	sra	$2,$2,8
	sh	$2,4($16)
	addu	$18,$18,1
	slt	$2,$18,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	addu	$16,$16,6
	.set	macro
	.set	reorder

	move	$17,$0
	move	$19,$17
	sll	$2,$18,1
	addu	$2,$2,$18
	move	$18,$17
	lui	$3,%hi(Fe3D_lightsVertex) # high
	addiu	$20,$3,%lo(Fe3D_lightsVertex) # low
	lui	$3,%hi(Fe3D_spotVertex) # high
	addiu	$3,$3,%lo(Fe3D_spotVertex) # low
	sll	$2,$2,1
	addu	$2,$2,$3
	sh	$0,0($2)
	sh	$0,2($2)
	sh	$0,4($2)
$L605:
	slt	$2,$18,32
	beq	$2,$0,$L600
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$4,$17
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	sra	$16,$2,3
	.set	macro
	.set	reorder

	sll	$3,$19,16
	addu	$5,$19,1
	move	$6,$3
 #APP
 #NO_APP
	addu	$19,$5,1
	addu	$17,$17,32
	addu	$18,$18,1
	sra	$3,$3,16
	sll	$4,$3,1
	addu	$4,$4,$3
	sll	$4,$4,1
	addu	$4,$4,$20
	sll	$3,$16,1
	addu	$3,$3,$16
	srl	$3,$3,5
	sra	$2,$2,3
	sra	$6,$6,16
	sh	$3,0($4)
	sh	$0,2($4)
	sll	$4,$6,1
	addu	$4,$4,$6
	sll	$4,$4,1
	addu	$4,$4,$20
	sll	$3,$2,1
	addu	$3,$3,$2
	srl	$3,$3,5
	sll	$5,$5,16
	sra	$5,$5,16
	sh	$3,4($4)
	sll	$4,$5,1
	addu	$4,$4,$5
	sll	$4,$4,1
	addu	$4,$4,$20
	sll	$3,$16,2
	addu	$3,$3,$16
	sll	$3,$3,2
	addu	$3,$3,$16
	sra	$3,$3,8
	sh	$3,0($4)
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	sra	$3,$3,8
	sh	$0,2($4)
	.set	noreorder
	.set	nomacro
	j	$L605
	sh	$3,4($4)
	.set	macro
	.set	reorder

$L600:
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

	.end	Fe3D_InitShowroom__Fv
	.text
	.ent	CameraLookAt__FP10matrixtdefP8coorddef
CameraLookAt__FP10matrixtdefP8coorddef:
	.frame	$sp,80,$31		# vars= 48, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	lui	$2,%hi(bigBuf+44) # high
	sw	$31,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	addiu	$9,$2,%lo(bigBuf+44)
	lw	$3,0($9)
	lw	$7,4($9)
	lw	$8,8($9)
	sw	$3,48($sp)
	sw	$7,52($sp)
	sw	$8,56($sp)
	lw	$2,0($5)
	#nop
	subu	$2,$0,$2
	sw	$2,16($sp)
	lw	$2,4($5)
	move	$17,$4
	subu	$2,$0,$2
	sw	$2,20($sp)
	lw	$2,8($5)
	addu	$4,$sp,16
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$18,$sp,48
	move	$4,$18
	addu	$5,$sp,16
	addu	$16,$sp,32
	.set	noreorder
	.set	nomacro
	jal	crossproduct
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	crossproduct
	move	$6,$18
	.set	macro
	.set	reorder

	lw	$2,32($sp)
	#nop
	sw	$2,0($17)
	lw	$2,36($sp)
	#nop
	sw	$2,4($17)
	lw	$2,40($sp)
	#nop
	sw	$2,8($17)
	lw	$2,48($sp)
	#nop
	sw	$2,12($17)
	lw	$2,52($sp)
	#nop
	sw	$2,16($17)
	lw	$2,56($sp)
	#nop
	sw	$2,20($17)
	lw	$2,16($sp)
	#nop
	sw	$2,24($17)
	lw	$2,20($sp)
	#nop
	sw	$2,28($17)
	lw	$2,24($sp)
	#nop
	sw	$2,32($17)
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

	.end	CameraLookAt__FP10matrixtdefP8coorddef
	.text
	.ent	Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii:
	.frame	$sp,248,$31		# vars= 192, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$21,228($sp)
	lw	$21,276($sp)
	sw	$22,232($sp)
	lw	$22,280($sp)
	sw	$fp,240($sp)
	lw	$fp,264($sp)
	sw	$19,220($sp)
	lw	$19,272($sp)
	sw	$20,224($sp)
	move	$20,$4
	sw	$23,236($sp)
	move	$23,$5
	sw	$18,216($sp)
	move	$18,$6
	sw	$16,208($sp)
	move	$16,$7
	sw	$31,244($sp)
	.set	noreorder
	.set	nomacro
	jal	TrsProj_ResetTransPrecision__Fv
	sw	$17,212($sp)
	.set	macro
	.set	reorder

	lui	$17,%hi(showRoomFlag) # high
	lw	$2,%lo(showRoomFlag)($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L618
	addu	$4,$18,-256
	.set	macro
	.set	reorder

	li	$16,140			# 0x0000008c
$L618:
	addu	$5,$16,-128
	li	$6,512			# 0x00000200
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetMenuProjection__Fiiii
	li	$7,256			# 0x00000100
	.set	macro
	.set	reorder

	lui	$2,%hi(gMenuRotate) # high
	addiu	$2,$2,%lo(gMenuRotate) # low
	sll	$4,$fp,2
	addu	$4,$4,$2
	lw	$2,0($4)
	lw	$3,268($sp)
	lw	$5,%lo(showRoomFlag)($17)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L612
	sw	$2,0($4)
	.set	macro
	.set	reorder

	li.s	$5,5.00000000000000000000e-1
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	move	$4,$21
	.set	macro
	.set	reorder

	move	$21,$2
	li.s	$16,6.55360000000000000000e4
	move	$4,$21
	sw	$0,152($sp)
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	sw	$2,156($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$17,$sp,56
	move	$4,$17
	addu	$5,$sp,152
	.set	noreorder
	.set	nomacro
	jal	CameraLookAt__FP10matrixtdefP8coorddef
	sw	$2,160($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,96
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	sll	$5,$19,6
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__extendsfdf2
	move	$4,$22
	.set	macro
	.set	reorder

	move	$4,$21
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	__extendsfdf2
	move	$17,$3
	.set	macro
	.set	reorder

	li.d	$6,2.50000000000000000000e0
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__divdf3
	move	$5,$3
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	__adddf3
	move	$7,$3
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__truncdfsf2
	move	$5,$3
	.set	macro
	.set	reorder

	move	$22,$2
	.set	noreorder
	.set	nomacro
	j	$L613
	move	$21,$0
	.set	macro
	.set	reorder

$L612:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	fixedxformy
	sll	$5,$19,6
	.set	macro
	.set	reorder

$L613:
	addu	$4,$sp,168
	addu	$5,$sp,16
	addu	$18,$23,20
	move	$6,$18
	li	$17,65536			# 0x00010000
	li	$2,35200			# 0x00008980
	sw	$17,168($sp)
	sw	$0,172($sp)
	sw	$0,176($sp)
	sw	$0,180($sp)
	sw	$17,184($sp)
	sw	$0,188($sp)
	sw	$0,192($sp)
	sw	$0,196($sp)
	sw	$17,200($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_fasttransmult__FP10matrixtdefN20
	sw	$2,184($sp)
	.set	macro
	.set	reorder

	move	$4,$18
	addu	$19,$23,68
	.set	noreorder
	.set	nomacro
	jal	transpose
	move	$5,$19
	.set	macro
	.set	reorder

	li.s	$16,6.55360000000000000000e4
	move	$4,$21
	sw	$0,136($sp)
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	move	$4,$22
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	__mulsf3
	sw	$2,140($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$16,$sp,136
	move	$4,$16
	move	$5,$18
	addu	$6,$23,8
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,144($sp)
	.set	macro
	.set	reorder

	lw	$2,8($23)
	move	$4,$16
	subu	$2,$0,$2
	sw	$2,136($sp)
	lw	$2,12($23)
	move	$5,$19
	subu	$2,$0,$2
	sw	$2,140($sp)
	lw	$2,16($23)
	addu	$6,$23,56
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	jal	transform
	sw	$2,144($sp)
	.set	macro
	.set	reorder

	sw	$17,240($20)
	sw	$17,256($20)
	sw	$17,272($20)
	sw	$0,244($20)
	sw	$0,248($20)
	sw	$0,252($20)
	sw	$0,260($20)
	sw	$0,264($20)
	sw	$0,268($20)
	sw	$0,160($20)
	sw	$0,164($20)
	.set	noreorder
	.set	nomacro
	bne	$fp,$0,$L614
	sw	$0,168($20)
	.set	macro
	.set	reorder

	lui	$4,%hi(generic128HzClock) # high
	lui	$5,%hi(R3DCar_ClockLast) # high
	#.set	volatile
	lw	$3,%lo(generic128HzClock)($4)
	#.set	novolatile
	lw	$2,%lo(R3DCar_ClockLast)($5)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	lui	$2,%hi(R3DCar_Clock) # high
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,%lo(generic128HzClock)($4)
	#.set	novolatile
	li	$4,1			# 0x00000001
	sw	$4,%lo(R3DCar_Clock)($2)
	addu	$3,$3,5
	.set	noreorder
	.set	nomacro
	j	$L614
	sw	$3,%lo(R3DCar_ClockLast)($5)
	.set	macro
	.set	reorder

$L615:
	sw	$0,%lo(R3DCar_Clock)($2)
$L614:
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadMenuTexture__Fv
	sw	$fp,4($23)
	.set	macro
	.set	reorder

	move	$4,$20
	.set	noreorder
	.set	nomacro
	jal	R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
	move	$5,$23
	.set	macro
	.set	reorder

	lw	$5,284($sp)
	.set	noreorder
	.set	nomacro
	jal	R3DCar_InsertCarFacetMenuII__FP8Car_tObji
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	R3DCar_Showroom__FP13DRender_tView
	move	$4,$23
	.set	macro
	.set	reorder

	lw	$8,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L610
	li	$4,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	ori	$4,$4,0x03fc
	li	$18,528482304			# 0x1f800000
	lui	$17,%hi(R3DCar_InMenu) # high
	lw	$2,%lo(R3DCar_InMenu)($17)
	lw	$3,12($18)
	ori	$2,$2,0x0080
	xori	$3,$3,0x0001
	sw	$2,%lo(R3DCar_InMenu)($17)
	.set	noreorder
	.set	nomacro
	jal	SetSp
	sw	$3,12($18)
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$23
	lui	$16,%hi(gWSavePtr) # high
	lui	$19,%hi(stackSpeedUpEnbabledFlag) # high
	sw	$2,%lo(gWSavePtr)($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView
	sw	$2,%lo(stackSpeedUpEnbabledFlag)($19)
	.set	macro
	.set	reorder

	lw	$4,%lo(gWSavePtr)($16)
	jal	SetSp
	lw	$5,284($sp)
	move	$4,$20
	sw	$2,%lo(gWSavePtr)($16)
	.set	noreorder
	.set	nomacro
	jal	R3DCar_InsertCarFacetMenuII__FP8Car_tObji
	sw	$0,%lo(stackSpeedUpEnbabledFlag)($19)
	.set	macro
	.set	reorder

	lw	$2,%lo(R3DCar_InMenu)($17)
	lw	$3,12($18)
	andi	$2,$2,0x007f
	xori	$3,$3,0x0001
	sw	$2,%lo(R3DCar_InMenu)($17)
	sw	$3,12($18)
$L610:
	lw	$31,244($sp)
	lw	$fp,240($sp)
	lw	$23,236($sp)
	lw	$22,232($sp)
	lw	$21,228($sp)
	lw	$20,224($sp)
	lw	$19,220($sp)
	lw	$18,216($sp)
	lw	$17,212($sp)
	lw	$16,208($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,248
	.set	macro
	.set	reorder

	.end	Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii
