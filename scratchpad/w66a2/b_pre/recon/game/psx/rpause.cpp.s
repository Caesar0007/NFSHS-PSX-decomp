	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\rpause.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	RPause_CopyBackToFrontBuffer__Fv
	.align	2
	.globl	RPause_StartPauseMenu__Fv
	.align	2
	.globl	RPause_StopPauseMenu__Fv

	.extern	gFlip, 4
	.extern	Render_gPauseMenuView, 4
	.extern	gEnviro, 48
	.extern	D_8013D3DA, 2
	.extern	D_8013D3D8, 2
	.extern	D_8013D3D6, 2
	.extern	gPauseMenuRect, 2
	.extern	Draw_gPlayer1View, 4

	.text
	.text
	.ent	RPause_CopyBackToFrontBuffer__Fv
RPause_CopyBackToFrontBuffer__Fv:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$4,Draw_gPlayer1View
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lwl	$8,3($2)
	lwr	$8,0($2)
	lwl	$9,7($2)
	lwr	$9,4($2)
	swl	$8,19($sp)
	swr	$8,16($sp)
	swl	$9,23($sp)
	swr	$9,20($sp)
	lhu	$2,16($sp)
	lhu	$3,gPauseMenuRect
	lw	$4,Draw_gPlayer1View
	lhu	$6,D_8013D3D8
	lhu	$7,D_8013D3DA
	addu	$2,$2,$3
	sh	$2,16($sp)
	lhu	$2,18($sp)
	lhu	$3,D_8013D3D6
	move	$5,$0
	sh	$6,20($sp)
	sh	$7,22($sp)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Draw_GetDRAWENV__Fii
	sh	$2,18($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lh	$3,0($2)
	lh	$5,gPauseMenuRect
	lh	$2,2($2)
	lh	$6,D_8013D3D6
	addu	$5,$3,$5
	.set	noreorder
	.set	nomacro
	jal	MoveImage
	addu	$6,$2,$6
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

	.end	RPause_CopyBackToFrontBuffer__Fv
	.text
	.ent	RPause_StartPauseMenu__Fv
RPause_StartPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	Draw_StartFrameRender__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	RPause_StartPauseMenu__Fv
	.text
	.ent	RPause_StopPauseMenu__Fv
RPause_StopPauseMenu__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi(gEnviro+24) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	PutDispEnv
	addiu	$4,$4,%lo(gEnviro+24) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	jal	RPause_CopyBackToFrontBuffer__Fv
	lui	$5,%hi(Draw_gView) # high
	addiu	$5,$5,%lo(Draw_gView) # low
	lw	$3,gFlip
	lw	$4,Render_gPauseMenuView
	sll	$3,$3,2
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$3,$3,$2
	addu	$3,$3,$5
	addu	$2,$2,$5
	lw	$2,0($2)
	lw	$4,192($3)
	sll	$2,$2,2
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	DrawOTag
	addu	$4,$4,-4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	lw	$3,gFlip
	lw	$31,16($sp)
	subu	$2,$2,$3
	sw	$2,gFlip
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	RPause_StopPauseMenu__Fv
