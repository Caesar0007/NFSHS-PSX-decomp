	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\sfx.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Sfx_Transform__FP8coorddefP7SVECTORT0
	.align	2
	.globl	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
	.align	2
	.globl	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
	.align	2
	.globl	Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
	.align	2
	.globl	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
	.align	2
	.globl	Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
	.align	2
	.globl	Sfx_Add__FP17Souffle_tISouffle
	.globl	Sfx_gCache
	.data
	.align	2
Sfx_gCache:
	.space	24

	.extern	gLeafPixmap, 4
	.extern	gSnowPalette, 4
	.extern	gGrassPalette, 4
	.extern	gGravelPixmap, 8
	.extern	gDirtPalette, 4
	.extern	gSMokePalette, 4
	.extern	Draw_gViewOtSize, 4
	.extern	GameSetup_gData, 2600
	.extern	gSMokePixmap, 8
	.extern	gWorldMat, 36

	.text
	.text
	.ent	Sfx_Transform__FP8coorddefP7SVECTORT0
Sfx_Transform__FP8coorddefP7SVECTORT0:
	.frame	$sp,88,$31		# vars= 56, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,88
	sw	$17,76($sp)
	move	$17,$4
	sw	$18,80($sp)
	move	$18,$5
	sw	$16,72($sp)
	move	$16,$6
	lui	$4,%hi(gWorldMat) # high
	addiu	$4,$4,%lo(gWorldMat) # low
	sw	$31,84($sp)
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,0($17)
	lw	$3,0($16)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,16($sp)
	lw	$2,4($17)
	lw	$3,4($16)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,18($sp)
	lw	$2,8($17)
	lw	$3,8($16)
	#nop
	subu	$2,$2,$3
	sra	$2,$2,10
	sh	$2,20($sp)
	addu	$2,$sp,16
 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 1246232594
 #NO_APP
	addu	$2,$sp,24
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lhu	$2,24($sp)
	#nop
	sh	$2,0($18)
	lhu	$2,28($sp)
	#nop
	sh	$2,2($18)
	lhu	$2,32($sp)
	#nop
	sh	$2,4($18)
	li	$2,4096			# 0x00001000
	sh	$2,40($sp)
	sh	$2,48($sp)
	sh	$2,56($sp)
	addu	$2,$sp,40
	sh	$0,46($sp)
	sh	$0,52($sp)
	sh	$0,42($sp)
	sh	$0,54($sp)
	sh	$0,44($sp)
	sh	$0,50($sp)
	sw	$0,60($sp)
	sw	$0,64($sp)
	sw	$0,68($sp)
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
	lw   $12, 20($2)
	lw   $13, 24($2)
	ctc2 $12, $5
	lw   $14, 28($2)
	ctc2 $13, $6
	ctc2 $14, $7
 #NO_APP
	lw	$31,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	Sfx_Transform__FP8coorddefP7SVECTORT0
	.text
	.ent	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$21,36($sp)
	move	$21,$6
	sw	$18,24($sp)
	li	$18,31			# 0x0000001f
	sw	$31,40($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$16,3($19)
	lw	$4,8($19)
	subu	$16,$18,$16
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	addu	$16,$16,38
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,8($19)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,48($19)
	#nop
	subu	$3,$3,$2
	sh	$3,16($20)
	lhu	$3,50($19)
	#nop
	addu	$3,$3,$17
	sh	$3,18($20)
	lhu	$3,52($19)
	#nop
	sh	$3,20($20)
	lhu	$3,48($19)
	#nop
	addu	$3,$3,$17
	sh	$3,24($20)
	lhu	$3,50($19)
	#nop
	addu	$3,$3,$2
	sh	$3,26($20)
	lhu	$3,52($19)
	#nop
	sh	$3,28($20)
	lhu	$3,48($19)
	#nop
	addu	$3,$3,$2
	sh	$3,32($20)
	lhu	$3,50($19)
	#nop
	subu	$3,$3,$17
	sh	$3,34($20)
	lhu	$3,52($19)
	#nop
	sh	$3,36($20)
	lhu	$3,48($19)
	#nop
	subu	$3,$3,$17
	sh	$3,40($20)
	lhu	$3,50($19)
	#nop
	subu	$3,$3,$2
	sh	$3,42($20)
	lhu	$2,52($19)
	#nop
	sh	$2,44($20)
	lbu	$2,3($19)
	#nop
	subu	$18,$18,$2
	sra	$18,$18,1
	slt	$2,$18,16
	bne	$2,$0,$L602
	li	$18,15			# 0x0000000f
$L602:
	lw	$2,56($19)
	la	$3,gSMokePixmap
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lwl	$7,3($2)
	lwr	$7,0($2)
	lwl	$8,7($2)
	lwr	$8,4($2)
	lwl	$9,11($2)
	lwr	$9,8($2)
	lwl	$10,15($2)
	lwr	$10,12($2)
	swl	$7,3($20)
	swr	$7,0($20)
	swl	$8,7($20)
	swr	$8,4($20)
	swl	$9,11($20)
	swr	$9,8($20)
	swl	$10,15($20)
	swr	$10,12($20)
	lhu	$2,2($21)
	#nop
	addu	$2,$2,$18
	sh	$2,2($20)
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

	.end	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
	.text
	.ent	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
Sfx_ThickenXZ__FP7SVECTORP8coorddefN21:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$31,36($sp)
	sw	$17,20($sp)
	lw	$3,0($20)
	lw	$4,0($16)
	lw	$2,8($20)
	lw	$5,8($16)
	subu	$4,$3,$4
	.set	noreorder
	.set	nomacro
	jal	intatan
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	move	$4,$17
	.set	macro
	.set	reorder

	li	$4,58982			# 0x0000e666
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	subu	$5,$0,$2
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	sra	$17,$2,1
	.set	macro
	.set	reorder

	li	$4,58982			# 0x0000e666
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$2
	.set	macro
	.set	reorder

	lw	$3,0($16)
	lw	$4,0($18)
	addu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,8($19)
	lw	$3,4($16)
	lw	$4,4($18)
	sra	$2,$2,1
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,10($19)
	lw	$3,8($16)
	lw	$4,8($18)
	addu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,12($19)
	lw	$3,0($16)
	lw	$4,0($18)
	subu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,16($19)
	lw	$3,4($16)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,18($19)
	lw	$3,8($16)
	lw	$4,8($18)
	subu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,20($19)
	lw	$3,0($20)
	lw	$4,0($18)
	addu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,0($19)
	lw	$3,4($20)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,2($19)
	lw	$3,8($20)
	lw	$4,8($18)
	addu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,4($19)
	lw	$3,0($20)
	lw	$4,0($18)
	subu	$3,$3,$17
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,24($19)
	lw	$3,4($20)
	lw	$4,4($18)
	#nop
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,26($19)
	lw	$3,8($20)
	lw	$4,8($18)
	subu	$3,$3,$2
	subu	$3,$3,$4
	sra	$3,$3,10
	sh	$3,28($19)
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

	.end	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
	.text
	.ent	Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$2,3($4)
	li	$3,8			# 0x00000008
	subu	$3,$3,$2
	slt	$2,$3,16
	bne	$2,$0,$L605
	li	$3,15			# 0x0000000f
$L605:
	lwl	$8,3($6)
	lwr	$8,0($6)
	lwl	$9,7($6)
	lwr	$9,4($6)
	lwl	$10,11($6)
	lwr	$10,8($6)
	lwl	$11,15($6)
	lwr	$11,12($6)
	swl	$8,3($5)
	swr	$8,0($5)
	swl	$9,7($5)
	swr	$9,4($5)
	swl	$10,11($5)
	swr	$10,8($5)
	swl	$11,15($5)
	swr	$11,12($5)
	lhu	$2,2($7)
	#nop
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,2($5)
	.set	macro
	.set	reorder

	.end	Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
	.text
	.ent	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	lw	$17,56($sp)
	sw	$31,32($sp)
	sw	$16,24($sp)
	lw	$2,4($17)
	lw	$3,8($17)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L606
	move	$8,$4
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($5)
	lwc2 $1, 4($5)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	lw	$16,528482308
	#nop
	addu	$2,$16,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$4,$5,8
	addu	$3,$5,16
	addu	$2,$5,24
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	andi	$2,$6,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L608
	li	$2,777519104			# 0x2e580000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L615
	ori	$2,$2,0x98b8
	.set	macro
	.set	reorder

$L608:
	lui	$2,%hi(GameSetup_gData+84) # high
	lw	$2,%lo(GameSetup_gData+84)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L610
	li	$2,773324800			# 0x2e180000
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L615
	ori	$2,$2,0x1818
	.set	macro
	.set	reorder

$L610:
	li	$2,772276224			# 0x2e080000
	ori	$2,$2,0x0808
$L615:
	sw	$2,4($16)
	addu	$4,$16,16
	addu	$3,$16,32
	addu	$2,$16,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	addu	$2,$17,20
 #APP
	swc2 $7, 0($2)
 #NO_APP
	lw	$2,20($17)
	#nop
	sra	$2,$2,1
	addu	$7,$2,$7
	.set	noreorder
	.set	nomacro
	bltz	$7,$L606
	sw	$7,20($17)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	sb	$2,3($16)
	lw	$2,0($8)
	lw	$3,4($8)
	lw	$4,8($8)
	lw	$5,12($8)
	sw	$2,12($16)
	sw	$3,20($16)
	sw	$4,28($16)
	sw	$5,36($16)
	lhu	$2,6($8)
	#nop
	sh	$2,16($sp)
	andi	$2,$6,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L613
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L616
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L613:
	li	$5,1			# 0x00000001
$L616:
	jal	ChangeTPage__FPUsi
	li	$8,528482304			# 0x1f800000
	ori	$8,$8,0x0004
	li	$5,16711680			# 0x00ff0000
	ori	$5,$5,0xffff
	lhu	$2,16($sp)
	lw	$6,528482304
	li	$7,-16777216			# 0xff000000
	sh	$2,22($16)
	lw	$2,20($17)
	lw	$16,0($8)
	sll	$2,$2,2
	addu	$2,$2,$6
	lw	$3,0($16)
	lw	$2,0($2)
	and	$3,$3,$7
	and	$2,$2,$5
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$4,20($17)
	addu	$3,$16,40
	sll	$4,$4,2
	addu	$4,$4,$6
	lw	$2,0($4)
	and	$5,$16,$5
	sw	$3,0($8)
	and	$2,$2,$7
	or	$2,$2,$5
	sw	$2,0($4)
$L606:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
	.text
	.ent	Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle:
	.frame	$sp,224,$31		# vars= 176, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,224
	sw	$16,200($sp)
	move	$16,$4
	sw	$18,208($sp)
	move	$18,$5
	sw	$31,216($sp)
	sw	$19,212($sp)
	sw	$17,204($sp)
	lbu	$2,0($18)
	#nop
	addu	$3,$2,-1
	sltu	$2,$3,14
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	li	$19,528482304			# 0x1f800000
	.set	macro
	.set	reorder

	lui	$2,%hi($L661) # high
	addiu	$2,$2,%lo($L661) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L661:
	.word	$L630
	.word	$L631
	.word	$L633
	.word	$L634
	.word	$L628
	.word	$L648
	.word	$L649
	.word	$L652
	.word	$L650
	.word	$L643
	.word	$L651
	.word	$L628
	.word	$L658
	.word	$L658
	.text
$L630:
	move	$4,$18
	lw	$6,gSMokePalette
	.set	noreorder
	.set	nomacro
	jal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	addu	$4,$sp,24
	.set	macro
	.set	reorder

$L631:
	move	$4,$18
	lw	$6,gSMokePalette
	.set	noreorder
	.set	nomacro
	jal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	lbu	$2,3($18)
	#nop
	sltu	$2,$2,18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L632
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,0($18)
$L632:
	sw	$19,16($sp)
	addu	$4,$sp,24
	addu	$5,$sp,40
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
	li	$7,15			# 0x0000000f
	.set	macro
	.set	reorder

	j	$L628
$L633:
	move	$4,$18
	lw	$6,gSMokePalette
	.set	noreorder
	.set	nomacro
	jal	Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	addu	$5,$sp,40
	.set	noreorder
	.set	nomacro
	j	$L665
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L634:
	lw	$10,24($18)
	lw	$11,28($18)
	lw	$12,32($18)
	sw	$10,72($sp)
	sw	$11,76($sp)
	sw	$12,80($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	addu	$4,$sp,72
	.set	macro
	.set	reorder

	addu	$4,$sp,72
	lw	$2,72($sp)
	lw	$3,12($18)
	sll	$2,$2,2
	subu	$3,$3,$2
	lw	$2,76($sp)
	addu	$5,$sp,88
	sw	$3,72($sp)
	lw	$3,16($18)
	sll	$2,$2,2
	subu	$3,$3,$2
	lw	$2,80($sp)
	addu	$6,$16,8
	sw	$3,76($sp)
	lw	$3,20($18)
	sll	$2,$2,2
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	Sfx_Transform__FP8coorddefP7SVECTORT0
	sw	$3,80($sp)
	.set	macro
	.set	reorder

	lh	$2,92($sp)
	#nop
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
	addu	$16,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L636
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

$L637:
	lh	$4,88($sp)
	lh	$3,48($18)
	#nop
	subu	$2,$4,$3
	.set	noreorder
	.set	nomacro
	blez	$2,$L639
	slt	$2,$2,32
	.set	macro
	.set	reorder

	beq	$2,$0,$L638
	j	$L640
$L639:
	subu	$2,$3,$4
	slt	$2,$2,32
	beq	$2,$0,$L638
$L640:
	lh	$2,48($18)
	lh	$3,88($sp)
	#nop
	slt	$2,$2,$3
	lhu	$3,48($18)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	addu	$2,$3,32
	.set	macro
	.set	reorder

	addu	$2,$3,-32
$L642:
	sh	$2,88($sp)
$L638:
	lhu	$2,48($18)
	#nop
	sh	$2,16($16)
	lhu	$2,50($18)
	#nop
	addu	$2,$2,32
	sh	$2,18($16)
	lhu	$2,52($18)
	#nop
	sh	$2,20($16)
	lhu	$2,48($18)
	#nop
	sh	$2,40($16)
	lhu	$2,50($18)
	#nop
	addu	$2,$2,-32
	sh	$2,42($16)
	lhu	$2,52($18)
	#nop
	sh	$2,44($16)
	lhu	$2,88($sp)
	#nop
	sh	$2,24($16)
	lhu	$2,90($sp)
	#nop
	addu	$2,$2,32
	sh	$2,26($16)
	lhu	$2,92($sp)
	#nop
	sh	$2,28($16)
	lhu	$2,88($sp)
	#nop
	sh	$2,32($16)
	lhu	$2,90($sp)
	#nop
	addu	$2,$2,-32
	sh	$2,34($16)
	lhu	$2,92($sp)
	move	$3,$0
	sh	$2,36($16)
$L636:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L628
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	addu	$5,$sp,40
	li	$6,2			# 0x00000002
	lui	$3,%hi(gSparkHPixmap) # high
	addiu	$3,$3,%lo(gSparkHPixmap) # low
	lbu	$7,3($18)
	li	$2,6			# 0x00000006
	subu	$2,$2,$7
	sll	$2,$2,$6
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lwl	$10,3($2)
	lwr	$10,0($2)
	lwl	$11,7($2)
	lwr	$11,4($2)
	lwl	$12,11($2)
	lwr	$12,8($2)
	lwl	$13,15($2)
	lwr	$13,12($2)
	swl	$10,27($sp)
	swr	$10,24($sp)
	swl	$11,31($sp)
	swr	$11,28($sp)
	swl	$12,35($sp)
	swr	$12,32($sp)
	swl	$13,39($sp)
	swr	$13,36($sp)
	.set	noreorder
	.set	nomacro
	j	$L666
	li	$7,40			# 0x00000028
	.set	macro
	.set	reorder

$L643:
	li	$2,773324800			# 0x2e180000
	ori	$2,$2,0x1010
	sw	$2,72($sp)
	lwl	$10,75($sp)
	lwr	$10,72($sp)
	swl	$10,111($sp)
	swr	$10,108($sp)
	lw	$10,24($18)
	lw	$11,28($18)
	lw	$12,32($18)
	sw	$10,152($sp)
	sw	$11,156($sp)
	sw	$12,160($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	addu	$4,$sp,152
	.set	macro
	.set	reorder

	lw	$10,12($18)
	lw	$11,16($18)
	lw	$12,20($18)
	sw	$10,164($sp)
	sw	$11,168($sp)
	sw	$12,172($sp)
	lh	$3,58($18)
	lw	$2,152($sp)
	#nop
	mult	$2,$3
	mflo	$14
	#nop
	lw	$2,156($sp)
	#nop
	mult	$2,$3
	addu	$17,$sp,120
	move	$4,$17
	mflo	$9
	#nop
	lw	$2,160($sp)
	addu	$5,$sp,152
	mult	$2,$3
	addu	$6,$sp,164
	addu	$7,$16,8
	lw	$2,164($sp)
	sra	$3,$14,4
	subu	$2,$2,$3
	sw	$2,152($sp)
	lw	$2,168($sp)
	sra	$3,$9,4
	subu	$2,$2,$3
	sw	$2,156($sp)
	lw	$2,172($sp)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
	sw	$2,160($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(gWorldMat) # high
	addiu	$4,$4,%lo(gWorldMat) # low
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,4($19)
	lw	$3,8($19)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	addu	$2,$sp,128
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$sp,176
	lw	$16,528482308
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,184($sp)
	#nop
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	addu	$2,$16,16
	.set	macro
	.set	reorder

 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$3,$sp,136
	addu	$2,$sp,144
 #APP
	lwc2 $0, 0($17)
	lwc2 $1, 4($17)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$4,$16,8
	lw	$2,108($sp)
	addu	$3,$16,32
	sw	$2,4($16)
	addu	$2,$16,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	addu	$2,$19,20
 #APP
	swc2 $7, 0($2)
 #NO_APP
	lw	$2,20($19)
	#nop
	sra	$2,$2,1
	addu	$3,$2,50
	.set	noreorder
	.set	nomacro
	bltz	$3,$L628
	sw	$3,20($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	lui	$3,%hi(gSparkHPixmap) # high
	addiu	$3,$3,%lo(gSparkHPixmap) # low
	sb	$2,3($16)
	lbu	$4,3($18)
	li	$2,6			# 0x00000006
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$3,0($2)
	lw	$5,4($2)
	lw	$6,8($2)
	lw	$7,12($2)
	addu	$4,$sp,192
	sw	$3,12($16)
	sw	$5,20($16)
	sw	$6,28($16)
	sw	$7,36($16)
	lhu	$2,6($2)
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	sh	$2,192($sp)
	.set	macro
	.set	reorder

	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	lhu	$2,192($sp)
	lw	$5,528482304
	li	$6,-16777216			# 0xff000000
	sh	$2,22($16)
	lw	$2,20($19)
	lw	$16,528482308
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,0($16)
	lw	$2,0($2)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$3,20($19)
	addu	$2,$16,40
	sw	$2,528482308
	sll	$3,$3,2
	addu	$3,$3,$5
	lw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L667
	and	$4,$16,$4
	.set	macro
	.set	reorder

$L648:
	li	$16,136			# 0x00000088
	lbu	$2,3($18)
	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	subu	$16,$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,48($18)
	addu	$16,$sp,24
	subu	$3,$3,$2
	sh	$3,16($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$17
	sh	$3,18($16)
	lhu	$3,52($18)
	#nop
	sh	$3,20($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$17
	sh	$3,24($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$2
	sh	$3,26($16)
	lhu	$3,52($18)
	#nop
	sh	$3,28($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$2
	sh	$3,32($16)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$17
	sh	$3,34($16)
	lhu	$3,52($18)
	#nop
	sh	$3,36($16)
	lhu	$3,48($18)
	#nop
	subu	$3,$3,$17
	sh	$3,40($16)
	lhu	$3,50($18)
	lw	$7,gDirtPalette
	.set	noreorder
	.set	nomacro
	j	$L670
	subu	$3,$3,$2
	.set	macro
	.set	reorder

$L649:
	li	$16,8			# 0x00000008
	lbu	$2,3($18)
	lw	$4,8($18)
	subu	$16,$16,$2
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	addu	$16,$16,25
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,48($18)
	addu	$16,$sp,24
	subu	$3,$3,$2
	sh	$3,16($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$17
	sh	$3,18($16)
	lhu	$3,52($18)
	#nop
	sh	$3,20($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$17
	sh	$3,24($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$2
	sh	$3,26($16)
	lhu	$3,52($18)
	#nop
	sh	$3,28($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$2
	sh	$3,32($16)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$17
	sh	$3,34($16)
	lhu	$3,52($18)
	#nop
	sh	$3,36($16)
	lhu	$3,48($18)
	#nop
	subu	$3,$3,$17
	sh	$3,40($16)
	lhu	$3,50($18)
	lw	$7,gGrassPalette
	subu	$3,$3,$2
	sh	$3,42($16)
	lhu	$2,52($18)
	move	$4,$18
	sh	$2,44($16)
	lw	$2,56($4)
	la	$3,gGravelPixmap
	.set	noreorder
	.set	nomacro
	j	$L671
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L650:
	li	$16,8			# 0x00000008
	lbu	$2,3($18)
	lw	$4,8($18)
	subu	$16,$16,$2
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	addu	$16,$16,25
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,48($18)
	addu	$16,$sp,24
	subu	$3,$3,$2
	sh	$3,16($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$17
	sh	$3,18($16)
	lhu	$3,52($18)
	#nop
	sh	$3,20($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$17
	sh	$3,24($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$2
	sh	$3,26($16)
	lhu	$3,52($18)
	#nop
	sh	$3,28($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$2
	sh	$3,32($16)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$17
	sh	$3,34($16)
	lhu	$3,52($18)
	#nop
	sh	$3,36($16)
	lhu	$3,48($18)
	#nop
	subu	$3,$3,$17
	sh	$3,40($16)
	lhu	$3,50($18)
	lw	$7,gSnowPalette
	subu	$3,$3,$2
	sh	$3,42($16)
	lhu	$2,52($18)
	move	$4,$18
	sh	$2,44($16)
	lw	$2,56($4)
	la	$3,gGravelPixmap
	.set	noreorder
	.set	nomacro
	j	$L671
	sll	$2,$2,2
	.set	macro
	.set	reorder

$L651:
	li	$16,8			# 0x00000008
	lbu	$2,3($18)
	lw	$4,8($18)
	subu	$16,$16,$2
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	jal	fastintcos
	addu	$16,$16,12
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	move	$5,$16
	.set	macro
	.set	reorder

	lhu	$3,48($18)
	addu	$16,$sp,24
	subu	$3,$3,$2
	sh	$3,16($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$17
	sh	$3,18($16)
	lhu	$3,52($18)
	#nop
	sh	$3,20($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$17
	sh	$3,24($16)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$2
	sh	$3,26($16)
	lhu	$3,52($18)
	#nop
	sh	$3,28($16)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$2
	sh	$3,32($16)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$17
	sh	$3,34($16)
	lhu	$3,52($18)
	#nop
	sh	$3,36($16)
	lhu	$3,48($18)
	#nop
	subu	$3,$3,$17
	sh	$3,40($16)
	lhu	$3,50($18)
	lw	$7,gSnowPalette
	subu	$3,$3,$2
$L670:
	sh	$3,42($16)
	lhu	$2,52($18)
	move	$4,$18
	sh	$2,44($16)
	lw	$2,56($4)
	la	$3,gSMokePixmap
	sll	$2,$2,2
$L671:
	addu	$2,$2,$3
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	jal	Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
$L664:
	addu	$5,$sp,40
	move	$6,$0
$L665:
	li	$7,15			# 0x0000000f
$L666:
	.set	noreorder
	.set	nomacro
	jal	Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
	sw	$19,16($sp)
	.set	macro
	.set	reorder

	j	$L628
$L652:
	li	$2,774897664			# 0x2e300000
	ori	$2,$2,0x1818
	sw	$2,80($sp)
	lwl	$10,83($sp)
	lwr	$10,80($sp)
	swl	$10,103($sp)
	swr	$10,100($sp)
	lw	$10,24($18)
	lw	$11,28($18)
	lw	$12,32($18)
	sw	$10,144($sp)
	sw	$11,148($sp)
	sw	$12,152($sp)
	.set	noreorder
	.set	nomacro
	jal	Math_NormalizeVector__FP8coorddef
	addu	$4,$sp,144
	.set	macro
	.set	reorder

	lw	$10,12($18)
	lw	$11,16($18)
	lw	$12,20($18)
	sw	$10,156($sp)
	sw	$11,160($sp)
	sw	$12,164($sp)
	lh	$3,58($18)
	lw	$2,144($sp)
	#nop
	mult	$2,$3
	mflo	$14
	#nop
	lw	$2,148($sp)
	#nop
	mult	$2,$3
	addu	$17,$sp,112
	move	$4,$17
	mflo	$9
	#nop
	lw	$2,152($sp)
	addu	$5,$sp,144
	mult	$2,$3
	addu	$6,$sp,156
	addu	$7,$16,8
	lw	$2,156($sp)
	sra	$3,$14,4
	subu	$2,$2,$3
	sw	$2,144($sp)
	lw	$2,160($sp)
	sra	$3,$9,4
	subu	$2,$2,$3
	sw	$2,148($sp)
	lw	$2,164($sp)
	mflo	$8
	#nop
	#nop
	sra	$3,$8,4
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
	sw	$2,152($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(gWorldMat) # high
	addiu	$4,$4,%lo(gWorldMat) # low
	.set	noreorder
	.set	nomacro
	jal	TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,4($19)
	lw	$3,8($19)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	addu	$2,$sp,120
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	addu	$2,$sp,168
	lw	$16,528482308
 #APP
	swc2 $25, 0($2)
	swc2 $26, 4($2)
	swc2 $27, 8($2)
 #NO_APP
	lw	$2,176($sp)
	#nop
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	addu	$2,$16,16
	.set	macro
	.set	reorder

 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$3,$sp,128
	addu	$2,$sp,136
 #APP
	lwc2 $0, 0($17)
	lwc2 $1, 4($17)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	addu	$4,$16,8
	lw	$2,100($sp)
	addu	$3,$16,32
	sw	$2,4($16)
	addu	$2,$16,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	addu	$2,$19,20
 #APP
	swc2 $7, 0($2)
 #NO_APP
	lw	$2,20($19)
	#nop
	sra	$2,$2,1
	addu	$3,$2,50
	.set	noreorder
	.set	nomacro
	bltz	$3,$L628
	sw	$3,20($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	lui	$3,%hi(gSparkHPixmap) # high
	addiu	$3,$3,%lo(gSparkHPixmap) # low
	sb	$2,3($16)
	lbu	$4,3($18)
	li	$2,6			# 0x00000006
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$3,0($2)
	lw	$5,4($2)
	lw	$6,8($2)
	lw	$7,12($2)
	addu	$4,$sp,194
	sw	$3,12($16)
	sw	$5,20($16)
	sw	$6,28($16)
	sw	$7,36($16)
	lhu	$2,6($2)
	li	$5,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	sh	$2,194($sp)
	.set	macro
	.set	reorder

	li	$4,16711680			# 0x00ff0000
	ori	$4,$4,0xffff
	lhu	$2,194($sp)
	lw	$5,528482304
	li	$6,-16777216			# 0xff000000
	sh	$2,22($16)
	lw	$2,20($19)
	lw	$16,528482308
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$3,0($16)
	lw	$2,0($2)
	and	$3,$3,$6
	and	$2,$2,$4
	or	$3,$3,$2
	sw	$3,0($16)
	lw	$3,20($19)
	addu	$2,$16,40
	sw	$2,528482308
	sll	$3,$3,2
	addu	$3,$3,$5
	lw	$2,0($3)
	.set	noreorder
	.set	nomacro
	j	$L667
	and	$4,$16,$4
	.set	macro
	.set	reorder

$L658:
	lw	$4,8($18)
	jal	fastintcos
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	fastintsin
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	li	$5,6			# 0x00000006
	.set	macro
	.set	reorder

	lhu	$3,48($18)
	addu	$4,$sp,24
	subu	$3,$3,$2
	sh	$3,16($4)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$16
	sh	$3,18($4)
	lhu	$3,52($18)
	#nop
	sh	$3,20($4)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$16
	sh	$3,24($4)
	lhu	$3,50($18)
	#nop
	addu	$3,$3,$2
	sh	$3,26($4)
	lhu	$3,52($18)
	#nop
	sh	$3,28($4)
	lhu	$3,48($18)
	#nop
	addu	$3,$3,$2
	sh	$3,32($4)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$16
	sh	$3,34($4)
	lhu	$3,52($18)
	#nop
	sh	$3,36($4)
	lhu	$3,48($18)
	#nop
	subu	$3,$3,$16
	sh	$3,40($4)
	lhu	$3,50($18)
	#nop
	subu	$3,$3,$2
	sh	$3,42($4)
	lhu	$2,52($18)
	#nop
	sh	$2,44($4)
	lw	$2,4($19)
	lw	$3,8($19)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L628
	addu	$2,$sp,40
	.set	macro
	.set	reorder

 #APP
	lwc2 $0, 0($2)
	lwc2 $1, 4($2)
	nop
	nop
	.word 0x4A180001
 #NO_APP
	li	$9,528482304			# 0x1f800000
	ori	$9,$9,0x0004
	lw	$8,0($9)
	#nop
	addu	$2,$8,8
 #APP
	swc2 $14, 0($2)
 #NO_APP
	addu	$4,$sp,48
	addu	$3,$sp,56
	addu	$2,$sp,64
 #APP
	lwc2 $0, 0($4)
	lwc2 $1, 4($4)
	lwc2 $2, 0($3)
	lwc2 $3, 4($3)
	lwc2 $4, 0($2)
	lwc2 $5, 4($2)
	nop
	nop
	.word 0x4A280030
 #NO_APP
	li	$3,738197504			# 0x2c000000
	lw	$2,64($18)
	addu	$4,$8,16
	or	$2,$2,$3
	addu	$3,$8,32
	sw	$2,4($8)
	addu	$2,$8,24
 #APP
	swc2 $12, 0($4)
	swc2 $13, 0($3)
	swc2 $14, 0($2)
	nop
	nop
	.word 0x4B68002E
 #NO_APP
	addu	$2,$19,20
 #APP
	swc2 $7, 0($2)
 #NO_APP
	lw	$2,20($19)
	#nop
	sra	$2,$2,1
	addu	$3,$2,15
	.set	noreorder
	.set	nomacro
	bltz	$3,$L628
	sw	$3,20($19)
	.set	macro
	.set	reorder

	lw	$2,Draw_gViewOtSize
	#nop
	addu	$2,$2,-3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L628
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	li	$7,16711680			# 0x00ff0000
	sb	$2,3($8)
	lw	$2,gLeafPixmap
	ori	$7,$7,0xffff
	lw	$3,0($2)
	lw	$4,4($2)
	lw	$5,8($2)
	lw	$2,12($2)
	li	$6,-16777216			# 0xff000000
	sw	$3,12($8)
	sw	$4,20($8)
	sw	$5,28($8)
	sw	$2,36($8)
	lw	$2,20($19)
	lw	$5,528482304
	lw	$3,0($8)
	sll	$2,$2,2
	addu	$2,$2,$5
	lw	$2,0($2)
	and	$3,$3,$6
	and	$2,$2,$7
	or	$3,$3,$2
	sw	$3,0($8)
	lw	$4,0($9)
	lw	$3,20($19)
	addu	$2,$4,40
	sll	$3,$3,2
	addu	$3,$3,$5
	sw	$2,0($9)
	lw	$2,0($3)
	and	$4,$4,$7
$L667:
	and	$2,$2,$6
	or	$2,$2,$4
	sw	$2,0($3)
$L628:
	lw	$31,216($sp)
	lw	$19,212($sp)
	lw	$18,208($sp)
	lw	$17,204($sp)
	lw	$16,200($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,224
	.set	macro
	.set	reorder

	.end	Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle
	.text
	.ent	Sfx_Add__FP17Souffle_tISouffle
Sfx_Add__FP17Souffle_tISouffle:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lbu	$2,0($16)
	#nop
	addu	$3,$2,-1
	sltu	$2,$3,13
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L672
	lui	$2,%hi($L686) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L686) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L686:
	.word	$L676
	.word	$L676
	.word	$L676
	.word	$L684
	.word	$L672
	.word	$L680
	.word	$L680
	.word	$L684
	.word	$L680
	.word	$L684
	.word	$L681
	.word	$L672
	.word	$L685
	.text
$L676:
	.set	noreorder
	.set	nomacro
	j	$L677
	li	$2,31			# 0x0000001f
	.set	macro
	.set	reorder

$L680:
	li	$2,8			# 0x00000008
$L677:
	.set	noreorder
	.set	nomacro
	jal	random
	sb	$2,3($16)
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L672
	sw	$2,56($16)
	.set	macro
	.set	reorder

$L681:
	jal	random
	andi	$2,$2,0x0001
	sw	$2,56($16)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L672
	sb	$2,3($16)
	.set	macro
	.set	reorder

$L684:
	li	$2,6			# 0x00000006
	.set	noreorder
	.set	nomacro
	j	$L672
	sb	$2,3($16)
	.set	macro
	.set	reorder

$L685:
	li	$2,64			# 0x00000040
	sb	$2,3($16)
	lw	$2,32($16)
	lw	$3,24($16)
	sw	$0,40($16)
	subu	$2,$0,$2
	sw	$2,36($16)
	sw	$3,44($16)
$L672:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Sfx_Add__FP17Souffle_tISouffle
