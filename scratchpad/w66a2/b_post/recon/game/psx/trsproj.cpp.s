	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\trsproj.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	TrsProj_precision
	.sdata
	.align	2
TrsProj_precision:
	.word	10
	.text
	.align	2
	.globl	TrsProj_SetTransPrecision__Fi
	.align	2
	.globl	TrsProj_ResetTransPrecision__Fv
	.align	2
	.globl	TrsProj_SetProjection__Fiiii
	.align	2
	.globl	TrsProj_SetMenuProjection__Fiiii
	.align	2
	.globl	TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
	.align	2
	.globl	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
	.align	2
	.globl	TrsProj_SetPsxTrans__FP8coorddef
	.align	2
	.globl	TrsProj_SetPsxTransZero__Fv
	.align	2
	.globl	TrsProj_TransPt__FP8coorddefT0
	.align	2
	.globl	TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
	.align	2
	.globl	TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex

	.extern	GameSetup_gData, 2600
	.extern	Camera_gGeomScreen, 4

	.text
	.text
	.ent	TrsProj_SetTransPrecision__Fi
TrsProj_SetTransPrecision__Fi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$4,TrsProj_precision
	j	$31
	.end	TrsProj_SetTransPrecision__Fi
	.text
	.ent	TrsProj_ResetTransPrecision__Fv
TrsProj_ResetTransPrecision__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,10			# 0x0000000a
	sw	$2,TrsProj_precision
	j	$31
	.end	TrsProj_ResetTransPrecision__Fv
	.text
	.ent	TrsProj_SetProjection__Fiiii
TrsProj_SetProjection__Fiiii:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	lw	$4,Camera_gGeomScreen
	sw	$18,24($sp)
	move	$18,$5
	sw	$16,16($sp)
	move	$16,$6
	sw	$17,20($sp)
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	SetGeomScreen
	move	$17,$7
	.set	macro
	.set	reorder

	srl	$2,$16,31
	addu	$16,$16,$2
	sra	$16,$16,1
	addu	$19,$19,$16
	srl	$2,$17,31
	addu	$17,$17,$2
	sra	$17,$17,1
	addu	$18,$18,$17
 #APP
	sll $12, $19, 16
	sll $13, $18, 16
	ctc2 $12, $24
	ctc2 $13, $25
 #NO_APP
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

	.end	TrsProj_SetProjection__Fiiii
	.text
	.ent	TrsProj_SetMenuProjection__Fiiii
TrsProj_SetMenuProjection__Fiiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,512			# 0x00000200
 #APP
	ctc2 $3, $26
 #NO_APP
	srl	$2,$6,31
	addu	$6,$6,$2
	sra	$6,$6,1
	addu	$4,$4,$6
	srl	$2,$7,31
	addu	$7,$7,$2
	sra	$7,$7,1
	addu	$5,$5,$7
 #APP
	sll $12, $4, 16
	sll $13, $5, 16
	ctc2 $12, $24
	ctc2 $13, $25
 #NO_APP
	j	$31
	.end	TrsProj_SetMenuProjection__Fiiii
	.text
	.ent	TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
TrsProj_SetViewTrsProjEnviro__FP13DRender_tView:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(GameSetup_gData+12) # high
	lw	$3,%lo(GameSetup_gData+12)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L605
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	li	$6,320			# 0x00000140
	.set	noreorder
	.set	nomacro
	j	$L607
	li	$7,120			# 0x00000078
	.set	macro
	.set	reorder

$L605:
	move	$4,$0
	move	$5,$4
	li	$6,320			# 0x00000140
	li	$7,240			# 0x000000f0
$L607:
	jal	TrsProj_SetProjection__Fiiii
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TrsProj_SetViewTrsProjEnviro__FP13DRender_tView
	.text
	.ent	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef:
	.frame	$sp,56,$31		# vars= 32, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	move	$6,$5
	sw	$31,48($sp)
	lw	$2,0($4)
	lw	$3,12($4)
	lw	$5,24($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$5,$5,4
	sh	$2,16($sp)
	sh	$3,18($sp)
	sh	$5,20($sp)
	lw	$2,4($4)
	lw	$3,16($4)
	lw	$5,28($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$5,$5,4
	sh	$2,22($sp)
	sh	$3,24($sp)
	sh	$5,26($sp)
	lw	$2,8($4)
	lw	$3,20($4)
	lw	$4,32($4)
	sra	$2,$2,4
	sra	$3,$3,4
	sra	$4,$4,4
	sh	$2,28($sp)
	addu	$2,$sp,16
	sh	$3,30($sp)
	sh	$4,32($sp)
 #APP
	lw   $12, 0($2)
	lw   $13, 4($2)
	ctc2 $12, $0
	ctc2 $13, $1
	lw   $12, 8($2)
	lw   $13, 12($2)
	lw   $14, 16($2)
	ctc2 $12, $2
	ctc2 $13, $3
	ctc2 $14, $4
 #NO_APP
	beq	$6,$0,$L609
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxTrans__FP8coorddef
	move	$4,$6
	.set	macro
	.set	reorder

	j	$L608
$L609:
	sw	$0,44($sp)
	sw	$0,40($sp)
	sw	$0,36($sp)
 #APP
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
$L608:
	lw	$31,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
	.text
	.ent	TrsProj_SetPsxTrans__FP8coorddef
TrsProj_SetPsxTrans__FP8coorddef:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	subu	$sp,$sp,32
	sra	$2,$2,10
	sw	$2,20($sp)
	lw	$2,4($4)
	#nop
	sra	$2,$2,10
	sw	$2,24($sp)
	lw	$2,8($4)
	#nop
	sra	$2,$2,10
	sw	$2,28($sp)
 #APP
	lw   $12, 20($sp)
	lw   $13, 24($sp)
	ctc2 $12, $5
	lw   $14, 28($sp)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TrsProj_SetPsxTrans__FP8coorddef
	.text
	.ent	TrsProj_SetPsxTransZero__Fv
TrsProj_SetPsxTransZero__Fv:
	.frame	$sp,32,$31		# vars= 32, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
 #APP
	lw   $12, 20($sp)
	lw   $13, 24($sp)
	ctc2 $12, $5
	lw   $14, 28($sp)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	TrsProj_SetPsxTransZero__Fv
	.text
	.ent	TrsProj_TransPt__FP8coorddefT0
TrsProj_TransPt__FP8coorddefT0:
	.frame	$sp,24,$31		# vars= 24, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($4)
	subu	$sp,$sp,24
	sra	$2,$2,10
	sh	$2,0($sp)
	lw	$2,4($4)
	#nop
	sra	$2,$2,10
	sh	$2,2($sp)
	lw	$2,8($4)
	#nop
	sra	$2,$2,10
	sh	$2,4($sp)
 #APP
	lwc2 $0, 0($sp)
	lwc2 $1, 4($sp)
	nop
	nop
	.word 1246232594
 #NO_APP
	addu	$2,$sp,8
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,8($sp)
	#nop
	sll	$2,$2,10
	sw	$2,0($5)
	lw	$2,12($sp)
	#nop
	sll	$2,$2,10
	sw	$2,4($5)
	lw	$2,16($sp)
	#nop
	sll	$2,$2,10
	sw	$2,8($5)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TrsProj_TransPt__FP8coorddefT0
	.text
	.ent	TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
TrsProj_TransPtN16__FP10RelCoord16P8coorddefi:
	.frame	$sp,24,$31		# vars= 24, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$7,$5
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L615
	addu	$3,$6,-1
	.set	macro
	.set	reorder

	addu	$6,$sp,8
	li	$8,-1			# 0xffffffff
	addu	$5,$5,8
$L617:
	lhu	$2,0($4)
	sh	$0,2($sp)
	sh	$2,0($sp)
	lhu	$2,2($4)
	#nop
	sh	$2,4($sp)
 #APP
	lwc2 $0, 0($sp)
	lwc2 $1, 4($sp)
	nop
	nop
	.word 1246232594
	swc2 $25, 0($6)
	swc2 $26, 4($6)
	swc2 $27, 8($6)
 #NO_APP
	lw	$2,8($sp)
	addu	$4,$4,4
	sw	$2,0($7)
	lw	$2,12($sp)
	addu	$3,$3,-1
	sw	$2,-4($5)
	lw	$2,16($sp)
	addu	$7,$7,12
	sw	$2,0($5)
	.set	noreorder
	.set	nomacro
	bne	$3,$8,$L617
	addu	$5,$5,12
	.set	macro
	.set	reorder

$L615:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	TrsProj_TransPtN16__FP10RelCoord16P8coorddefi
	.text
	.ent	TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex:
	.frame	$sp,72,$31		# vars= 16, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$18,40($sp)
	lw	$18,88($sp)
	sw	$23,60($sp)
	move	$23,$4
	sw	$20,48($sp)
	move	$20,$5
	sw	$21,52($sp)
	move	$21,$6
	sw	$19,44($sp)
	move	$19,$7
	sw	$17,36($sp)
	move	$17,$0
	sw	$31,64($sp)
	sw	$22,56($sp)
	.set	noreorder
	.set	nomacro
	blez	$21,$L621
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	li	$22,10			# 0x0000000a
	addu	$16,$18,6
$L623:
	move	$4,$19
	move	$5,$23
	.set	noreorder
	.set	nomacro
	jal	transform
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	lw	$3,0($20)
	addu	$19,$19,12
	addu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,0($18)
	lw	$2,20($sp)
	lw	$3,4($20)
	addu	$17,$17,1
	addu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,-4($16)
	lw	$2,24($sp)
	lw	$3,8($20)
	addu	$18,$18,8
	sh	$22,0($16)
	addu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,-2($16)
	slt	$2,$17,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	addu	$16,$16,8
	.set	macro
	.set	reorder

$L621:
	lw	$31,64($sp)
	lw	$23,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
