	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\texture.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"pshare 4\000"
	.align	2
$LC1:
	.ascii	"pshare 8\000"
	.align	2
$LC2:
	.ascii	"pal 4bit\000"
	.align	2
$LC3:
	.ascii	"pal 8bit\000"
	.text
	.align	2
	.globl	Texture_InitPaletteSharing__Fv
	.align	2
	.globl	Texture_DeInitPaletteSharing__Fv
	.align	2
	.globl	Texture_ResetPaletteSharing__Fv
	.align	2
	.globl	Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
	.align	2
	.globl	Texture_AddSharedPalette__FPcP12Draw_tPixMapi
	.align	2
	.globl	Texture_InitClut__Fv
	.align	2
	.globl	Texture_GetClutId__FiPiT1
	.align	2
	.globl	Texture_MenuReleaseClutId__Fs
	.align	2
	.globl	Texture_ColorCarPalette__FPcT0i
	.align	2
	.globl	Texture_CopyPalette__FPciii
	.align	2
	.globl	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
	.align	2
	.globl	Texture_LoadImage__FP4RECTPUl
	.align	2
	.globl	Texture_Vramf__FP8shapetbliiii
	.align	2
	.globl	Texture_Vramcf__FP8shapetbliiii
	.align	2
	.globl	Texture_GetTranslucencyMode__FP8shapetbl
	.align	2
	.globl	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	.align	2
	.globl	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	.rdata
	.align	2
$LC4:
	.ascii	"4 bit Cluts\000"
	.align	2
$LC5:
	.ascii	"8 bit Cluts\000"
	.text
	.align	2
	.globl	Texture_InitTrackTexture__Fv
	.rdata
	.align	2
$LC6:
	.ascii	"4 bits cluts\000"
	.align	2
$LC7:
	.ascii	"8 bits cluts\000"
	.text
	.align	2
	.globl	Texture_InitMenuClut__Fv
	.align	2
	.globl	Texture_InitMenuTexture__Fv
	.align	2
	.globl	Texture_CleanupMenuTexture__Fv
	.rdata
	.align	2
$LC8:
	.ascii	"%sshow.psh\000"
	.align	2
$LC9:
	.ascii	"show\000"
	.align	2
$LC10:
	.ascii	"shad\000"
	.align	2
$LC11:
	.ascii	"lgt3\000"
	.align	2
$LC12:
	.ascii	"lgta\000"
	.align	2
$LC13:
	.ascii	"lgtb\000"
	.align	2
$LC14:
	.ascii	"lgtc\000"
	.text
	.align	2
	.globl	Texture_LoadMenuTexture__Fv
	.align	2
	.globl	Texture_KillTrackTexture__Fv
	.align	2
	.globl	Texture_KillMenuTexture__Fv
	.globl	gMenuPixmap
	.data
	.align	2
gMenuPixmap:
	.space	32
	.globl	gMenuPixmapAlloc
	.align	2
gMenuPixmapAlloc:
	.space	128
	.globl	Texture_CarColor
	.sdata
	.align	2
Texture_CarColor:
	.space	4
	.globl	Texture_palCopy
	.align	2
Texture_palCopy:
	.space	4
	.globl	Texture_palNum
	.align	2
Texture_palNum:
	.space	4
	.globl	Texture_gNum4bitPal
	.align	2
Texture_gNum4bitPal:
	.space	4
	.globl	Texture_gNum8bitPal
	.align	2
Texture_gNum8bitPal:
	.space	4
	.globl	Texture_gP4bitPmx
	.align	2
Texture_gP4bitPmx:
	.space	4
	.globl	Texture_gP8bitPmx
	.align	2
Texture_gP8bitPmx:
	.space	4
	.globl	Texture_gPalette4bit
	.align	2
Texture_gPalette4bit:
	.space	4
	.globl	Texture_gPalette8bit
	.align	2
Texture_gPalette8bit:
	.space	4
	.globl	gFreePal4
	.align	2
gFreePal4:
	.space	4
	.globl	gNbFreePal4
	.align	2
gNbFreePal4:
	.space	4
	.globl	gFreePal8
	.align	2
gFreePal8:
	.space	4
	.globl	gNbFreePal8
	.align	2
gNbFreePal8:
	.space	4

	.extern	Paths_Paths, 200

	.text
	.text
	.ent	Texture_InitPaletteSharing__Fv
Texture_InitPaletteSharing__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,2048			# 0x00000800
	sw	$31,16($sp)
	sw	$0,Texture_gNum4bitPal
	sw	$0,Texture_gNum8bitPal
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,256			# 0x00000100
	sw	$2,Texture_gP4bitPmx
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,2048			# 0x00000800
	sw	$2,Texture_gP8bitPmx
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,256			# 0x00000100
	sw	$2,Texture_gPalette4bit
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$2,Texture_gPalette8bit
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_InitPaletteSharing__Fv
	.text
	.ent	Texture_DeInitPaletteSharing__Fv
Texture_DeInitPaletteSharing__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,Texture_gP4bitPmx
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lw	$4,Texture_gP8bitPmx
	jal	purgememadr
	lw	$4,Texture_gPalette4bit
	jal	purgememadr
	lw	$4,Texture_gPalette8bit
	jal	purgememadr
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_DeInitPaletteSharing__Fv
	.text
	.ent	Texture_ResetPaletteSharing__Fv
Texture_ResetPaletteSharing__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sw	$0,Texture_gNum4bitPal
	sw	$0,Texture_gNum8bitPal
	j	$31
	.end	Texture_ResetPaletteSharing__Fv
	.text
	.ent	Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L604
	move	$2,$0
	.set	macro
	.set	reorder

	j	$31
$L629:
	lw	$3,Texture_gP8bitPmx
	sll	$2,$9,2
$L632:
	addu	$2,$2,$3
	lw	$3,0($2)
	li	$2,1			# 0x00000001
	lwl	$13,3($3)
	lwr	$13,0($3)
	lwl	$14,7($3)
	lwr	$14,4($3)
	lwl	$15,11($3)
	lwr	$15,8($3)
	lwl	$24,15($3)
	lwr	$24,12($3)
	swl	$13,3($6)
	swr	$13,0($6)
	swl	$14,7($6)
	swr	$14,4($6)
	swl	$15,11($6)
	swr	$15,8($6)
	swl	$24,15($6)
	.set	noreorder
	.set	nomacro
	j	$31
	swr	$24,12($6)
	.set	macro
	.set	reorder

$L630:
	lw	$3,Texture_gP4bitPmx
	.set	noreorder
	.set	nomacro
	j	$L632
	sll	$2,$9,2
	.set	macro
	.set	reorder

$L604:
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L605
	move	$9,$0
	.set	macro
	.set	reorder

	li	$12,128			# 0x00000080
	lw	$11,Texture_gNum8bitPal
	lw	$10,Texture_gPalette8bit
$L608:
	slt	$2,$9,$11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	move	$8,$5
	.set	macro
	.set	reorder

	lw	$7,0($10)
	move	$4,$0
$L610:
	lw	$3,0($7)
	addu	$7,$7,4
	lw	$2,0($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L612
	addu	$8,$8,4
	.set	macro
	.set	reorder

	addu	$4,$4,1
	slt	$2,$4,128
	bne	$2,$0,$L610
$L612:
	.set	noreorder
	.set	nomacro
	beq	$4,$12,$L629
	addu	$10,$10,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L608
	addu	$9,$9,1
	.set	macro
	.set	reorder

$L605:
	li	$12,8			# 0x00000008
	lw	$11,Texture_gNum4bitPal
	lw	$10,Texture_gPalette4bit
$L619:
	slt	$2,$9,$11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	move	$8,$5
	.set	macro
	.set	reorder

	lw	$7,0($10)
	move	$4,$0
$L621:
	lw	$3,0($7)
	addu	$7,$7,4
	lw	$2,0($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L623
	addu	$8,$8,4
	.set	macro
	.set	reorder

	addu	$4,$4,1
	slt	$2,$4,8
	bne	$2,$0,$L621
$L623:
	.set	noreorder
	.set	nomacro
	beq	$4,$12,$L630
	addu	$10,$10,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L619
	addu	$9,$9,1
	.set	macro
	.set	reorder

$L616:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
	.text
	.ent	Texture_AddSharedPalette__FPcP12Draw_tPixMapi
Texture_AddSharedPalette__FPcP12Draw_tPixMapi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L634
	move	$8,$5
	.set	macro
	.set	reorder

	lw	$4,Texture_gNum4bitPal
	lw	$2,Texture_gPalette4bit
	lw	$5,Texture_gP4bitPmx
	sll	$3,$4,2
	addu	$2,$3,$2
	addu	$3,$3,$5
	addu	$4,$4,1
	sw	$7,0($2)
	sw	$8,0($3)
	sw	$4,Texture_gNum4bitPal
	j	$31
$L634:
	li	$2,1			# 0x00000001
	bne	$6,$2,$L637
	lw	$4,Texture_gNum8bitPal
	lw	$2,Texture_gPalette8bit
	lw	$5,Texture_gP8bitPmx
	sll	$3,$4,2
	addu	$2,$3,$2
	addu	$3,$3,$5
	addu	$4,$4,1
	sw	$7,0($2)
	sw	$8,0($3)
	sw	$4,Texture_gNum8bitPal
$L637:
	j	$31
	.end	Texture_AddSharedPalette__FPcP12Draw_tPixMapi
	.text
	.ent	Texture_InitClut__Fv
Texture_InitClut__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$8,gFreePal4
	move	$7,$0
	sw	$0,gNbFreePal4
	move	$5,$0
$L669:
	sra	$2,$7,4
	andi	$6,$2,0x003f
	sll	$3,$5,6
$L668:
	addu	$5,$5,1
	lw	$4,gNbFreePal4
	or	$3,$3,$6
	sll	$2,$4,1
	addu	$4,$4,1
	addu	$2,$2,$8
	sh	$3,0($2)
	slt	$2,$5,120
	sw	$4,gNbFreePal4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L668
	sll	$3,$5,6
	.set	macro
	.set	reorder

	addu	$7,$7,16
	slt	$2,$7,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L669
	move	$5,$0
	.set	macro
	.set	reorder

	move	$7,$0
	lw	$9,gFreePal4
$L670:
	sra	$2,$7,4
	andi	$8,$2,0x003f
	li	$6,8192			# 0x00002000
$L655:
	or	$4,$6,$8
	lw	$3,gNbFreePal4
	addu	$5,$5,1
	sll	$2,$3,1
	addu	$3,$3,1
	addu	$2,$2,$9
	sh	$4,0($2)
	slt	$2,$5,32
	sw	$3,gNbFreePal4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L655
	addu	$6,$6,64
	.set	macro
	.set	reorder

	addu	$7,$7,16
	slt	$2,$7,128
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L670
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$9,gFreePal8
	move	$7,$0
	sw	$0,gNbFreePal8
$L671:
	sra	$2,$7,4
	andi	$8,$2,0x003f
	li	$6,7680			# 0x00001e00
$L664:
	or	$4,$6,$8
	lw	$3,gNbFreePal8
	addu	$5,$5,1
	sll	$2,$3,1
	addu	$3,$3,1
	addu	$2,$2,$9
	sh	$4,0($2)
	slt	$2,$5,8
	sw	$3,gNbFreePal8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L664
	addu	$6,$6,64
	.set	macro
	.set	reorder

	addu	$7,$7,256
	slt	$2,$7,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	move	$5,$0
	.set	macro
	.set	reorder

	j	$31
	.end	Texture_InitClut__Fv
	.text
	.ent	Texture_GetClutId__FiPiT1
Texture_GetClutId__FiPiT1:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L673
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$2,gNbFreePal4
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$3,gFreePal4
	sw	$2,gNbFreePal4
	.set	noreorder
	.set	nomacro
	j	$L679
	sll	$2,$2,1
	.set	macro
	.set	reorder

$L673:
	lw	$2,gNbFreePal8
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L675
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lw	$3,gFreePal8
	sw	$2,gNbFreePal8
	sll	$2,$2,1
$L679:
	addu	$2,$2,$3
	lhu	$3,0($2)
$L675:
	andi	$2,$3,0x003f
	sll	$2,$2,4
	sw	$2,0($5)
	sll	$2,$3,16
	sra	$2,$2,22
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($6)
	.set	macro
	.set	reorder

	.end	Texture_GetClutId__FiPiT1
	.text
	.ent	Texture_MenuReleaseClutId__Fs
Texture_MenuReleaseClutId__Fs:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$4
	sll	$2,$5,16
	sra	$2,$2,22
	slt	$2,$2,488
	beq	$2,$0,$L681
	lw	$2,gNbFreePal8
	lw	$4,gFreePal8
	sll	$3,$2,1
	addu	$2,$2,1
	addu	$3,$3,$4
	sh	$5,0($3)
	sw	$2,gNbFreePal8
	j	$31
$L681:
	lw	$2,gNbFreePal4
	lw	$4,gFreePal4
	sll	$3,$2,1
	addu	$2,$2,1
	addu	$3,$3,$4
	sh	$5,0($3)
	sw	$2,gNbFreePal4
	j	$31
	.end	Texture_MenuReleaseClutId__Fs
	.text
	.ent	Texture_ColorCarPalette__FPcT0i
Texture_ColorCarPalette__FPcT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Texture_CarColor
	addu	$3,$6,-1
	sll	$2,$2,5
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L690
	addu	$4,$4,$2
	.set	macro
	.set	reorder

	li	$6,-1			# 0xffffffff
$L685:
	lhu	$2,0($4)
	addu	$4,$4,2
	addu	$3,$3,-1
	sh	$2,0($5)
	.set	noreorder
	.set	nomacro
	bne	$3,$6,$L685
	addu	$5,$5,2
	.set	macro
	.set	reorder

$L690:
	j	$31
	.end	Texture_ColorCarPalette__FPcT0i
	.text
	.ent	Texture_CopyPalette__FPciii
Texture_CopyPalette__FPciii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,Texture_palNum
	move	$8,$0
	sll	$3,$2,6
	addu	$3,$3,$2
	lw	$2,Texture_palCopy
	sll	$3,$3,3
	addu	$3,$3,$2
	addu	$9,$3,8
	sw	$6,0($3)
	.set	noreorder
	.set	nomacro
	blez	$5,$L692
	sw	$7,4($3)
	.set	macro
	.set	reorder

$L693:
	lhu	$2,0($4)
	addu	$4,$4,2
	addu	$8,$8,1
	sh	$2,0($9)
	slt	$2,$8,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L693
	addu	$9,$9,2
	.set	macro
	.set	reorder

$L692:
	lw	$2,Texture_palNum
	#nop
	addu	$2,$2,1
	sw	$2,Texture_palNum
	j	$31
	.end	Texture_CopyPalette__FPciii
	.text
	.ent	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
Texture_ProcessPaletteCopy__FP15Texture_pal8bitii:
	.frame	$sp,80,$31		# vars= 40, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$19,68($sp)
	move	$19,$6
	sw	$31,72($sp)
	sw	$18,64($sp)
	sw	$17,60($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L698
	sw	$16,56($sp)
	.set	macro
	.set	reorder

	move	$17,$5
	li	$2,16			# 0x00000010
	sh	$2,20($sp)
	li	$2,1			# 0x00000001
	sh	$2,22($sp)
	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L698
	addu	$18,$sp,24
	.set	macro
	.set	reorder

	sll	$2,$17,6
	addu	$2,$2,$17
	sll	$2,$2,3
	addu	$16,$2,$4
	addu	$4,$16,8
$L706:
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Texture_ColorCarPalette__FPcT0i
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$18
	lhu	$2,0($16)
	addu	$17,$17,1
	sh	$2,16($sp)
	lhu	$2,4($16)
	addu	$16,$16,520
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	sh	$2,18($sp)
	.set	macro
	.set	reorder

	slt	$2,$17,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L706
	addu	$4,$16,8
	.set	macro
	.set	reorder

$L698:
	lw	$31,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Texture_ProcessPaletteCopy__FP15Texture_pal8bitii
	.text
	.ent	Texture_LoadImage__FP4RECTPUl
Texture_LoadImage__FP4RECTPUl:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lhu	$2,4($4)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L708
	lhu	$2,6($4)
	#nop
	ori	$2,$2,0x0001
	sh	$2,6($4)
$L708:
	jal	LoadImage
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_LoadImage__FP4RECTPUl
	.text
	.ent	Texture_Vramf__FP8shapetbliiii
Texture_Vramf__FP8shapetbliiii:
	.frame	$sp,80,$31		# vars= 24, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,80
	sw	$21,60($sp)
	lw	$21,96($sp)
	sw	$16,40($sp)
	move	$16,$4
	sw	$19,52($sp)
	move	$19,$5
	sw	$20,56($sp)
	move	$20,$6
	sw	$17,44($sp)
	move	$17,$7
	sw	$31,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L710
	sw	$18,48($sp)
	.set	macro
	.set	reorder

	li	$18,-4096			# 0xfffff000
	andi	$2,$20,0x0fff
	sll	$23,$2,16
	andi	$2,$21,0x0fff
	sll	$22,$2,16
$L712:
	lbu	$2,0($16)
	#nop
	andi	$3,$2,0x00f7
	li	$2,35			# 0x00000023
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L715
	sltu	$2,$3,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	sltu	$2,$3,68
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L720
	sltu	$2,$3,64
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L720
	li	$5,-268435456			# 0xf0000000
	.set	macro
	.set	reorder

	ori	$5,$5,0xffff
	move	$4,$16
	lw	$2,12($16)
	andi	$3,$19,0x0fff
	and	$2,$2,$18
	or	$2,$2,$3
	and	$2,$2,$5
	lbu	$3,0($16)
	or	$2,$2,$23
	sw	$2,12($16)
	ori	$3,$3,0x0008
	sb	$3,0($16)
	sh	$19,16($sp)
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sh	$20,18($sp)
	.set	macro
	.set	reorder

	lh	$3,4($16)
	#nop
	mult	$3,$2
	mflo	$3
	#nop
	#nop
	addu	$2,$3,15
	.set	noreorder
	.set	nomacro
	bgez	$2,$L727
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$2,$3,30
$L727:
	sra	$2,$2,4
	sh	$2,20($sp)
	lhu	$2,6($16)
	addu	$5,$16,16
	.set	noreorder
	.set	nomacro
	j	$L726
	sh	$2,22($sp)
	.set	macro
	.set	reorder

$L715:
	.set	noreorder
	.set	nomacro
	bltz	$17,$L720
	li	$6,-268435456			# 0xf0000000
	.set	macro
	.set	reorder

	ori	$6,$6,0xffff
	addu	$4,$sp,16
	addu	$5,$16,16
	lw	$2,12($16)
	andi	$3,$17,0x0fff
	and	$2,$2,$18
	or	$2,$2,$3
	and	$2,$2,$6
	lbu	$3,0($16)
	or	$2,$2,$22
	sw	$2,12($16)
	ori	$3,$3,0x0008
	sb	$3,0($16)
	sh	$17,16($sp)
	sh	$21,18($sp)
	lhu	$3,4($16)
	li	$2,1			# 0x00000001
	sh	$2,22($sp)
	sh	$3,20($sp)
$L726:
	jal	Texture_LoadImage__FP4RECTPUl
$L720:
	lw	$3,0($16)
	li	$2,-256			# 0xffffff00
	and	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L722
	sra	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L723
	addu	$4,$16,$2
	.set	macro
	.set	reorder

$L722:
	move	$4,$0
$L723:
	move	$16,$4
	bne	$16,$0,$L712
$L710:
	lw	$31,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder

	.end	Texture_Vramf__FP8shapetbliiii
	.text
	.ent	Texture_Vramcf__FP8shapetbliiii
Texture_Vramcf__FP8shapetbliiii:
	.frame	$sp,72,$31		# vars= 8, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$20,48($sp)
	move	$20,$4
	sw	$21,52($sp)
	move	$21,$5
	sw	$23,60($sp)
	move	$23,$6
	sw	$fp,64($sp)
	lw	$fp,88($sp)
	sw	$31,68($sp)
	sw	$22,56($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	.set	noreorder
	.set	nomacro
	jal	shapedepth
	sw	$7,84($sp)
	.set	macro
	.set	reorder

	lh	$3,4($20)
	#nop
	mult	$3,$2
	li	$2,-16			# 0xfffffff0
	mflo	$8
	#nop
	#nop
	addu	$3,$8,15
	and	$22,$3,$2
	sra	$16,$22,3
	andi	$2,$16,0x0002
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L732
	move	$4,$20
	.set	macro
	.set	reorder

	lhu	$18,6($20)
	#nop
	andi	$2,$18,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	move	$5,$21
	.set	macro
	.set	reorder

	sll	$18,$18,16
	sra	$18,$18,16
	addu	$2,$18,-1
	mult	$2,$16
	addu	$4,$sp,24
	addu	$17,$23,$18
	addu	$2,$17,-2
	li	$19,1			# 0x00000001
	sh	$2,26($sp)
	li	$2,2			# 0x00000002
	sh	$21,24($sp)
	sh	$19,28($sp)
	sh	$2,30($sp)
	mflo	$8
	#nop
	#nop
	addu	$16,$8,16
	addu	$16,$20,$16
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	addu	$5,$16,-2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	addu	$5,$16,2
	addu	$2,$21,1
	addu	$17,$17,-1
	sh	$2,24($sp)
	sra	$2,$22,4
	addu	$2,$2,-1
	sh	$17,26($sp)
	sh	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	LoadImage
	sh	$19,30($sp)
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$21
	move	$6,$23
	lhu	$2,6($20)
	lw	$7,84($sp)
	addu	$2,$2,-1
	sh	$2,6($20)
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramf__FP8shapetbliiii
	sw	$fp,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L728
	sh	$18,6($20)
	.set	macro
	.set	reorder

$L732:
	move	$5,$21
$L733:
	lw	$7,84($sp)
	move	$6,$23
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramf__FP8shapetbliiii
	sw	$fp,16($sp)
	.set	macro
	.set	reorder

$L728:
	lw	$31,68($sp)
	lw	$fp,64($sp)
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

	.end	Texture_Vramcf__FP8shapetbliiii
	.text
	.ent	Texture_GetTranslucencyMode__FP8shapetbl
Texture_GetTranslucencyMode__FP8shapetbl:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$6,107			# 0x0000006b
	li	$7,3			# 0x00000003
	li	$5,-256			# 0xffffff00
$L737:
	beq	$4,$0,$L736
	lbu	$2,0($4)
	#nop
	bne	$2,$6,$L739
	lhu	$2,4($4)
	#nop
	srl	$2,$2,5
	andi	$2,$2,0x0003
	bne	$2,$7,$L746
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L739:
	lw	$3,0($4)
	#nop
	and	$2,$3,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	sra	$2,$3,8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L737
	addu	$4,$4,$2
	.set	macro
	.set	reorder

$L741:
	.set	noreorder
	.set	nomacro
	j	$L737
	move	$4,$0
	.set	macro
	.set	reorder

$L736:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L746:
	j	$31
	.end	Texture_GetTranslucencyMode__FP8shapetbl
	.text
	.ent	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap:
	.frame	$sp,96,$31		# vars= 32, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	lw	$2,116($sp)
	lw	$3,120($sp)
	sw	$18,64($sp)
	lw	$18,124($sp)
	sw	$23,84($sp)
	move	$23,$6
	sw	$17,60($sp)
	move	$17,$7
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L748
	sw	$16,56($sp)
	.set	macro
	.set	reorder

	jal	locateshapez
	.set	noreorder
	.set	nomacro
	j	$L749
	move	$16,$2
	.set	macro
	.set	reorder

$L748:
	move	$16,$5
$L749:
	beq	$16,$0,$L747
	lw	$2,12($16)
	lbu	$3,0($16)
	sll	$8,$2,4
	sra	$8,$8,20
	andi	$20,$3,0x0003
	sll	$2,$2,20
	sra	$2,$2,20
	sw	$8,36($sp)
	sw	$2,32($sp)
	sw	$20,48($sp)
	lh	$8,4($16)
	#nop
	sw	$8,40($sp)
	lh	$8,6($16)
	andi	$2,$23,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L751
	sw	$8,44($sp)
	.set	macro
	.set	reorder

	beq	$20,$0,$L751
	move	$20,$0
$L751:
	lw	$3,12($16)
	#nop
	andi	$2,$3,0x4000
	sltu	$2,$0,$2
	sw	$2,28($sp)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$17,$2,$L752
	sll	$2,$3,20
	.set	macro
	.set	reorder

	move	$21,$0
	li	$22,160			# 0x000000a0
	li	$2,1			# 0x00000001
	sh	$2,4($16)
	.set	noreorder
	.set	nomacro
	j	$L753
	sh	$2,6($16)
	.set	macro
	.set	reorder

$L752:
	sra	$2,$2,20
	addu	$21,$2,$17
	sll	$2,$3,4
	lw	$3,112($sp)
	sra	$2,$2,20
	addu	$22,$2,$3
$L753:
	lh	$8,4($16)
	andi	$2,$23,0x0001
	sw	$8,24($sp)
	lh	$fp,6($16)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L786
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	addu	$8,$8,-1
	sw	$8,24($sp)
	addu	$fp,$fp,-1
$L786:
	.set	noreorder
	.set	nomacro
	beq	$20,$2,$L755
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,0($16)
	#nop
	sra	$2,$2,8
	addu	$17,$16,$2
	lh	$8,4($17)
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L756
	sw	$8,52($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L781
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

$L756:
	li	$2,256			# 0x00000100
$L781:
	sh	$2,4($17)
	andi	$4,$23,0x0040
	addu	$19,$17,16
	move	$5,$19
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
	move	$7,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L787
	andi	$2,$23,0x0020
	.set	macro
	.set	reorder

	lw	$3,116($sp)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L759
	li	$2,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$sp,116
	.set	noreorder
	.set	nomacro
	jal	Texture_GetClutId__FiPiT1
	addu	$6,$sp,120
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L784
	andi	$2,$23,0x0002
	.set	macro
	.set	reorder

$L759:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L761
	li	$2,-2			# 0xfffffffe
	.set	macro
	.set	reorder

	lh	$5,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextureProcess_DepthColorCluts__FPci
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L760
	sh	$2,10($18)
	.set	macro
	.set	reorder

$L761:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L784
	andi	$2,$23,0x0002
	.set	macro
	.set	reorder

	li	$2,160			# 0x000000a0
	sw	$2,120($sp)
	li	$2,1			# 0x00000001
	sw	$0,116($sp)
	sh	$2,4($17)
$L760:
	andi	$2,$23,0x0002
$L784:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L788
	andi	$2,$23,0x0008
	.set	macro
	.set	reorder

	lh	$5,4($17)
	.set	noreorder
	.set	nomacro
	jal	TextureProcess_TransColorCheck__FPci
	addu	$4,$17,16
	.set	macro
	.set	reorder

	sll	$2,$2,1
	sh	$2,14($18)
	andi	$2,$23,0x0008
$L788:
	beq	$2,$0,$L765
	lw	$8,48($sp)
	#nop
	beq	$8,$0,$L765
	lw	$2,Texture_palCopy
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L789
	andi	$2,$23,0x0010
	.set	macro
	.set	reorder

	lw	$6,116($sp)
	lw	$7,120($sp)
	lw	$5,52($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_CopyPalette__FPciii
	addu	$4,$17,16
	.set	macro
	.set	reorder

	andi	$2,$23,0x0010
$L789:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L765
	addu	$4,$17,16
	.set	macro
	.set	reorder

	move	$5,$4
	.set	noreorder
	.set	nomacro
	jal	Texture_ColorCarPalette__FPcT0i
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

$L765:
	lw	$4,116($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L768
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	lw	$5,120($sp)
	jal	GetClut
	.set	noreorder
	.set	nomacro
	j	$L785
	sh	$2,2($18)
	.set	macro
	.set	reorder

$L768:
	sh	$2,2($18)
$L785:
	andi	$2,$23,0x0040
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	addu	$4,$17,16
	.set	macro
	.set	reorder

	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	Texture_AddSharedPalette__FPcP12Draw_tPixMapi
	move	$6,$20
	.set	macro
	.set	reorder

$L758:
	andi	$2,$23,0x0020
$L787:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L771
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sw	$2,16($sp)
	move	$5,$21
	move	$6,$22
	.set	noreorder
	.set	nomacro
	j	$L783
	move	$7,$2
	.set	macro
	.set	reorder

$L771:
	move	$5,$21
	lw	$7,116($sp)
	lw	$2,120($sp)
	move	$6,$22
	sw	$2,16($sp)
$L783:
	jal	Texture_Vramcf__FP8shapetbliiii
	lhu	$8,52($sp)
	.set	noreorder
	.set	nomacro
	j	$L773
	sh	$8,4($17)
	.set	macro
	.set	reorder

$L755:
	sw	$0,16($sp)
	move	$5,$21
	move	$6,$22
	.set	noreorder
	.set	nomacro
	jal	Texture_Vramcf__FP8shapetbliiii
	move	$7,$0
	.set	macro
	.set	reorder

$L773:
	.set	noreorder
	.set	nomacro
	jal	Texture_GetTranslucencyMode__FP8shapetbl
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$2
	move	$6,$21
	.set	noreorder
	.set	nomacro
	jal	GetTPage
	move	$7,$22
	.set	macro
	.set	reorder

	sh	$2,6($18)
	.set	noreorder
	.set	nomacro
	bgez	$21,$L774
	move	$2,$21
	.set	macro
	.set	reorder

	addu	$2,$21,63
$L774:
	sra	$4,$2,6
	sll	$2,$4,6
	subu	$4,$21,$2
	.set	noreorder
	.set	nomacro
	bgez	$22,$L775
	move	$2,$22
	.set	macro
	.set	reorder

	addu	$2,$22,255
$L775:
	sra	$5,$2,8
	sll	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$20,$0,$L776
	subu	$5,$22,$2
	.set	macro
	.set	reorder

	sll	$4,$4,2
$L776:
	li	$2,1			# 0x00000001
	bne	$20,$2,$L777
	sll	$4,$4,$2
$L777:
	lw	$8,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L778
	addu	$3,$5,$fp
	.set	macro
	.set	reorder

	sb	$4,0($18)
	sb	$3,1($18)
	sb	$4,4($18)
	sb	$5,5($18)
	lw	$8,24($sp)
	#nop
	addu	$2,$4,$8
	sb	$2,8($18)
	sb	$3,9($18)
	sb	$2,12($18)
	.set	noreorder
	.set	nomacro
	j	$L779
	sb	$5,13($18)
	.set	macro
	.set	reorder

$L778:
	sb	$4,0($18)
	sb	$5,1($18)
	lw	$8,24($sp)
	addu	$2,$5,$fp
	addu	$3,$4,$8
	sb	$3,4($18)
	sb	$5,5($18)
	sb	$4,8($18)
	sb	$2,9($18)
	sb	$3,12($18)
	sb	$2,13($18)
$L779:
	li	$4,-268435456			# 0xf0000000
	ori	$4,$4,0xffff
	lhu	$8,40($sp)
	lw	$3,12($16)
	li	$2,-4096			# 0xfffff000
	sh	$8,4($16)
	lhu	$8,44($sp)
	#nop
	sh	$8,6($16)
	lw	$8,32($sp)
	and	$3,$3,$2
	andi	$2,$8,0x0fff
	or	$3,$3,$2
	lw	$8,36($sp)
	and	$3,$3,$4
	andi	$2,$8,0x0fff
	sll	$2,$2,16
	or	$3,$3,$2
	sw	$3,12($16)
$L747:
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
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
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	.text
	.ent	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
Texture_CloneUVPmx__FP12Draw_tPixMapiT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lwl	$7,3($4)
	lwr	$7,0($4)
	lwl	$8,7($4)
	lwr	$8,4($4)
	lwl	$9,11($4)
	lwr	$9,8($4)
	lwl	$10,15($4)
	lwr	$10,12($4)
	swl	$7,3($6)
	swr	$7,0($6)
	swl	$8,7($6)
	swr	$8,4($6)
	swl	$9,11($6)
	swr	$9,8($6)
	swl	$10,15($6)
	sltu	$2,$5,5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L800
	swr	$10,12($6)
	.set	macro
	.set	reorder

	lui	$2,%hi($L797) # high
	addiu	$2,$2,%lo($L797) # low
	sll	$3,$5,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L797:
	.word	$L792
	.word	$L793
	.word	$L794
	.word	$L795
	.word	$L796
	.text
$L792:
	lhu	$2,4($4)
	#nop
	sh	$2,0($6)
	lhu	$2,0($4)
	#nop
	sh	$2,4($6)
	lhu	$2,12($4)
	#nop
	sh	$2,8($6)
	lhu	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,12($6)
	.set	macro
	.set	reorder

$L793:
	lhu	$2,4($4)
	#nop
	sh	$2,12($6)
	lhu	$2,12($4)
	#nop
	sh	$2,4($6)
	lhu	$2,0($4)
	#nop
	sh	$2,8($6)
	lhu	$2,8($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,0($6)
	.set	macro
	.set	reorder

$L794:
	lhu	$2,8($4)
	#nop
	sh	$2,0($6)
	lhu	$2,0($4)
	#nop
	sh	$2,4($6)
	lhu	$2,4($4)
	#nop
	sh	$2,12($6)
	lhu	$2,12($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,8($6)
	.set	macro
	.set	reorder

$L795:
	lhu	$2,12($4)
	#nop
	sh	$2,0($6)
	lhu	$2,8($4)
	#nop
	sh	$2,4($6)
	lhu	$2,0($4)
	#nop
	sh	$2,12($6)
	lhu	$2,4($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,8($6)
	.set	macro
	.set	reorder

$L796:
	lhu	$2,4($4)
	#nop
	sh	$2,0($6)
	lhu	$2,12($4)
	#nop
	sh	$2,4($6)
	lhu	$2,8($4)
	#nop
	sh	$2,12($6)
	lhu	$2,0($4)
	#nop
	sh	$2,8($6)
$L800:
	j	$31
	.end	Texture_CloneUVPmx__FP12Draw_tPixMapiT0
	.text
	.ent	Texture_InitTrackTexture__Fv
Texture_InitTrackTexture__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$4,5104			# 0x000013f0
	lui	$5,%hi($LC4) # high
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	li	$4,16			# 0x00000010
	lui	$5,%hi($LC5) # high
	sw	$2,gFreePal4
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC5) # low
	.set	macro
	.set	reorder

	sw	$2,gFreePal8
	jal	Texture_InitPaletteSharing__Fv
	jal	TextureProcess_Init__Fv
	jal	Texture_InitClut__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_InitTrackTexture__Fv
	.text
	.ent	Texture_InitMenuClut__Fv
Texture_InitMenuClut__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	li	$5,768			# 0x00000300
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$4,%hi($LC7) # high
	addiu	$4,$4,%lo($LC7) # low
	li	$5,4480			# 0x00001180
	sw	$2,gFreePal4
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$9,gFreePal4
	move	$7,$0
	sw	$2,gFreePal8
	sw	$0,gNbFreePal4
	move	$6,$0
$L823:
	addu	$2,$7,512
	sra	$2,$2,4
	andi	$8,$2,0x003f
	li	$5,31232			# 0x00007a00
$L810:
	or	$4,$5,$8
	lw	$3,gNbFreePal4
	addu	$6,$6,1
	sll	$2,$3,1
	addu	$3,$3,1
	addu	$2,$2,$9
	sh	$4,0($2)
	slt	$2,$6,24
	sw	$3,gNbFreePal4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L810
	addu	$5,$5,64
	.set	macro
	.set	reorder

	addu	$7,$7,16
	slt	$2,$7,256
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L823
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$9,gFreePal8
	move	$7,$0
	sw	$0,gNbFreePal8
$L813:
	move	$6,$0
	addu	$2,$7,512
	sra	$2,$2,4
	andi	$8,$2,0x003f
	li	$5,22272			# 0x00005700
$L819:
	or	$4,$5,$8
	lw	$3,gNbFreePal8
	addu	$6,$6,1
	sll	$2,$3,1
	addu	$3,$3,1
	addu	$2,$2,$9
	sh	$4,0($2)
	slt	$2,$6,140
	sw	$3,gNbFreePal8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L819
	addu	$5,$5,64
	.set	macro
	.set	reorder

	addu	$7,$7,256
	slt	$2,$7,256
	bne	$2,$0,$L813
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_InitMenuClut__Fv
	.text
	.ent	Texture_InitMenuTexture__Fv
Texture_InitMenuTexture__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,7			# 0x00000007
	lui	$2,%hi(gMenuPixmap) # high
	addiu	$2,$2,%lo(gMenuPixmap) # low
	addu	$2,$2,28
$L825:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L825
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	j	$31
	.end	Texture_InitMenuTexture__Fv
	.text
	.ent	Texture_CleanupMenuTexture__Fv
Texture_CleanupMenuTexture__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(gMenuPixmap) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gMenuPixmap) # low
	sw	$31,24($sp)
$L831:
	lw	$2,0($16)
	#nop
	beq	$2,$0,$L834
	lh	$4,2($2)
	jal	Texture_MenuReleaseClutId__Fs
$L834:
	sw	$0,0($16)
	addu	$17,$17,1
	slt	$2,$17,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L831
	addu	$16,$16,4
	.set	macro
	.set	reorder

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

	.end	Texture_CleanupMenuTexture__Fv
	.text
	.ent	Texture_LoadMenuTexture__Fv
Texture_LoadMenuTexture__Fv:
	.frame	$sp,320,$31		# vars= 256, regs= 7/0, args= 32, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,320
	sw	$18,296($sp)
	lui	$18,%hi(gMenuPixmap) # high
	lw	$2,%lo(gMenuPixmap)($18)
	sw	$21,308($sp)
	addiu	$21,$18,%lo(gMenuPixmap) # low
	sw	$31,312($sp)
	sw	$20,304($sp)
	sw	$19,300($sp)
	sw	$17,292($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L837
	sw	$16,288($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$2,%hi(Paths_Paths+100) # high
	lui	$5,%hi($LC8) # high
	lw	$6,%lo(Paths_Paths+100)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC8) # low
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
	move	$19,$2
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC9) # high
	addiu	$5,$5,%lo($LC9) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	li	$20,384			# 0x00000180
	li	$16,-1			# 0xffffffff
	lui	$17,%hi(gMenuPixmapAlloc) # high
	addiu	$17,$17,%lo(gMenuPixmapAlloc) # low
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC10) # high
	addiu	$5,$5,%lo($LC10) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	sw	$17,%lo(gMenuPixmap)($18)
	addu	$18,$17,16
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$18,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC11) # high
	addiu	$5,$5,%lo($LC11) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	sw	$18,4($21)
	addu	$18,$17,32
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$18,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC12) # high
	addiu	$5,$5,%lo($LC12) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	sw	$18,12($21)
	addu	$18,$17,48
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$18,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC13) # high
	addiu	$5,$5,%lo($LC13) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	sw	$18,16($21)
	addu	$18,$17,64
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$18,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	lui	$5,%hi($LC14) # high
	addiu	$5,$5,%lo($LC14) # low
	move	$6,$0
	li	$7,896			# 0x00000380
	addu	$17,$17,80
	sw	$18,20($21)
	sw	$20,16($sp)
	sw	$16,20($sp)
	sw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	sw	$17,24($21)
	.set	macro
	.set	reorder

$L837:
	lw	$31,312($sp)
	lw	$21,308($sp)
	lw	$20,304($sp)
	lw	$19,300($sp)
	lw	$18,296($sp)
	lw	$17,292($sp)
	lw	$16,288($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,320
	.set	macro
	.set	reorder

	.end	Texture_LoadMenuTexture__Fv
	.text
	.ent	Texture_KillTrackTexture__Fv
Texture_KillTrackTexture__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	Texture_KillTrackTexture__Fv
	.text
	.ent	Texture_KillMenuTexture__Fv
Texture_KillMenuTexture__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gFreePal4
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	purgememadr
	lw	$4,gFreePal8
	jal	purgememadr
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Texture_KillMenuTexture__Fv
