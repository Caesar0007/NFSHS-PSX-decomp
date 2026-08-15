	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\cario.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"carPixMap\000"
	.text
	.align	2
	.globl	CarIO_StartUp__Fv
	.align	2
	.globl	CarIO_CleanUp__Fv
	.align	2
	.globl	CarIO_ReStart__Fv
	.align	2
	.globl	CarIO_CopyFromShape__FPsT0iiii
	.align	2
	.globl	CarIO_CopyToShape__FPsT0i
	.sdata
	.align	2
$LC1:
	.ascii	"plate1\000"
	.align	2
$LC2:
	.ascii	"plate2\000"
	.rdata
	.align	2
$LC3:
	.ascii	"theplate\000"
	.sdata
	.align	2
$LC4:
	.ascii	"blnk\000"
	.align	2
$LC5:
	.ascii	"   \000"
	.text
	.align	2
	.globl	CarIO_CreateLicense__FPcii
	.align	2
	.globl	CarIO_CleanUpLicense__Fi
	.align	2
	.globl	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	.align	2
	.globl	CarIO_ReadInCarTextureData__FPcP8Car_tObjii
	.align	2
	.globl	CarIO_UpdateCarTextureData__FPcP8Car_tObji
	.align	2
	.globl	CarIO_ReleaseCarCluts__FP8Car_tObj
	.globl	CarIO_carPixMap
	.sdata
	.align	2
CarIO_carPixMap:
	.space	4
	.globl	CarIO_Plate1
	.align	2
CarIO_Plate1:
	.space	8
	.globl	CarIO_Plate2
	.align	2
CarIO_Plate2:
	.space	8
	.globl	CarIO_carPixMapCount
	.align	2
CarIO_carPixMapCount:
	.space	4
	.globl	CarIO_carVRamCount
	.align	2
CarIO_carVRamCount:
	.space	4
	.globl	CarIO_licenseSFX_Count
	.align	2
CarIO_licenseSFX_Count:
	.space	4

	.extern	CarIO_licensePlate, 264
	.extern	Texture_palNum, 4
	.extern	D_8011E804, 612
	.extern	Texture_palCopy, 4
	.extern	CarIO_carVRamOffset, 12
	.extern	CarIO_carVRamSlotsMenu, 24
	.extern	CarIO_carVRamAdd, 12
	.extern	CarIO_carVRamSlots, 72
	.extern	CarIO_licenseSFX_Vram, 48
	.extern	GameSetup_gData, 2600
	.extern	R3DCar_InMenu, 4
	.extern	R3DCar_LicenseShapeFile, 4

	.text
	.text
	.ent	CarIO_StartUp__Fv
CarIO_StartUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,CarIO_carPixMap
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,9792			# 0x00002640
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,CarIO_carPixMap
$L601:
	lw	$2,CarIO_carPixMap
	li	$3,611			# 0x00000263
	addu	$2,$2,9776
$L602:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L602
	addu	$2,$2,-16
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	sw	$0,CarIO_carPixMapCount
	sw	$0,CarIO_carVRamCount
	sw	$0,CarIO_licenseSFX_Count
	sw	$0,CarIO_Plate2
	sw	$0,CarIO_Plate1
	sw	$0,CarIO_Plate2+4
	sw	$0,CarIO_Plate1+4
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CarIO_StartUp__Fv
	.text
	.ent	CarIO_CleanUp__Fv
CarIO_CleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,CarIO_carPixMap
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L607
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L607:
	lw	$31,16($sp)
	sw	$0,CarIO_carPixMap
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CarIO_CleanUp__Fv
	.text
	.ent	CarIO_ReStart__Fv
CarIO_ReStart__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lw	$2,CarIO_carPixMap
	li	$3,611			# 0x00000263
	sw	$31,16($sp)
	addu	$2,$2,9776
$L609:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L609
	addu	$2,$2,-16
	.set	macro
	.set	reorder

	sw	$0,CarIO_carPixMapCount
	sw	$0,CarIO_carVRamCount
	.set	noreorder
	.set	nomacro
	jal	CarIO_CleanUpLicense__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CarIO_CleanUpLicense__Fi
	li	$4,1			# 0x00000001
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

	.end	CarIO_ReStart__Fv
	.text
	.ent	CarIO_CopyFromShape__FPsT0iiii
CarIO_CopyFromShape__FPsT0iiii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sra	$8,$6,2
	andi	$6,$6,0x0003
	lw	$24,16($sp)
	lw	$9,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L646
	sra	$3,$24,2
	.set	macro
	.set	reorder

	addu	$8,$8,1
$L646:
	sll	$2,$9,1
	addu	$2,$2,$9
	sll	$2,$2,2
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$5,$5,$3
	li	$13,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L615
	move	$12,$13
	.set	macro
	.set	reorder

	move	$12,$0
$L615:
	addu	$6,$6,-1
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L647
	move	$15,$0
	.set	macro
	.set	reorder

$L617:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L617
	sll	$12,$12,4
	.set	macro
	.set	reorder

	move	$15,$0
$L647:
	andi	$6,$24,0x0003
	li	$9,-1			# 0xffffffff
$L621:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$9,$L622
	sll	$2,$15,4
	.set	macro
	.set	reorder

	ori	$15,$2,0x000f
	andi	$3,$12,0xf000
	sll	$12,$12,4
	srl	$3,$3,12
	sll	$2,$13,4
	.set	noreorder
	.set	nomacro
	j	$L621
	or	$13,$2,$3
	.set	macro
	.set	reorder

$L622:
	andi	$3,$13,0xffff
	li	$2,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L648
	li	$14,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$12,$13
	addu	$8,$8,1
$L648:
	addu	$25,$8,$14
$L626:
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$14,$L649
	move	$10,$0
	.set	macro
	.set	reorder

	lhu	$8,0($4)
	addu	$4,$4,2
	andi	$6,$24,0x0003
$L630:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L631
	andi	$3,$8,0xf000
	.set	macro
	.set	reorder

	sll	$8,$8,4
	srl	$3,$3,12
	sll	$2,$10,4
	.set	noreorder
	.set	nomacro
	j	$L630
	or	$10,$2,$3
	.set	macro
	.set	reorder

$L631:
	li	$11,1			# 0x00000001
	lhu	$2,0($5)
	addu	$9,$5,2
	and	$2,$2,$15
	or	$2,$2,$8
	sh	$2,0($5)
$L634:
	slt	$2,$11,$25
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	andi	$6,$24,0x0003
	.set	macro
	.set	reorder

	sh	$10,0($9)
	lhu	$8,0($4)
	addu	$4,$4,2
	move	$10,$0
$L637:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L638
	andi	$3,$8,0xf000
	.set	macro
	.set	reorder

	sll	$8,$8,4
	srl	$3,$3,12
	sll	$2,$10,4
	.set	noreorder
	.set	nomacro
	j	$L637
	or	$10,$2,$3
	.set	macro
	.set	reorder

$L638:
	lhu	$2,0($9)
	addu	$11,$11,1
	or	$2,$2,$8
	sh	$2,0($9)
	.set	noreorder
	.set	nomacro
	j	$L634
	addu	$9,$9,2
	.set	macro
	.set	reorder

$L635:
	sll	$3,$11,1
	addu	$3,$3,$5
	lhu	$2,0($3)
	#nop
	and	$2,$2,$12
	or	$2,$2,$10
	sh	$2,0($3)
	andi	$3,$13,0xffff
	li	$2,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L641
	addu	$6,$6,-1
	.set	macro
	.set	reorder

	lhu	$8,0($4)
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L643
	addu	$4,$4,2
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L644:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L644
	sll	$8,$8,4
	.set	macro
	.set	reorder

$L643:
	sll	$3,$11,1
	addu	$3,$3,$5
	lhu	$2,0($3)
	#nop
	or	$2,$2,$8
	sh	$2,0($3)
$L641:
	.set	noreorder
	.set	nomacro
	j	$L626
	addu	$5,$5,24
	.set	macro
	.set	reorder

$L649:
	j	$31
	.end	CarIO_CopyFromShape__FPsT0iiii
	.text
	.ent	CarIO_CopyToShape__FPsT0i
CarIO_CopyToShape__FPsT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$10,$4
	move	$8,$5
	li	$11,22			# 0x00000016
	li	$12,-1			# 0xffffffff
$L651:
	addu	$11,$11,-1
	beq	$11,$12,$L665
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L655
	li	$7,5			# 0x00000005
	.set	macro
	.set	reorder

	move	$7,$0
	move	$3,$10
$L656:
	lhu	$2,0($3)
	addu	$3,$3,2
	addu	$7,$7,1
	sh	$2,0($8)
	slt	$2,$7,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	addu	$8,$8,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L651
	addu	$10,$10,24
	.set	macro
	.set	reorder

$L655:
	addu	$9,$10,10
$L661:
	.set	noreorder
	.set	nomacro
	bltz	$7,$L662
	addu	$7,$7,-1
	.set	macro
	.set	reorder

	lhu	$3,0($9)
	addu	$9,$9,-2
	andi	$2,$3,0x000f
	sll	$2,$2,12
	andi	$5,$3,0x00f0
	sll	$5,$5,4
	andi	$4,$3,0x0f00
	srl	$4,$4,4
	srl	$3,$3,12
	or	$2,$2,$5
	or	$2,$2,$4
	or	$2,$2,$3
	sh	$2,0($8)
	.set	noreorder
	.set	nomacro
	j	$L661
	addu	$8,$8,2
	.set	macro
	.set	reorder

$L662:
 #APP
	
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L651
	addu	$10,$10,24
	.set	macro
	.set	reorder

$L665:
	j	$31
	.end	CarIO_CopyToShape__FPsT0i
	.text
	.ent	CarIO_CreateLicense__FPcii
CarIO_CreateLicense__FPcii:
	.frame	$sp,72,$31		# vars= 8, regs= 9/0, args= 24, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$23,60($sp)
	move	$23,$4
	sw	$22,56($sp)
	move	$22,$6
	slt	$5,$5,22
	sw	$31,64($sp)
	sw	$21,52($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L667
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	sll	$2,$22,2
	la	$3,CarIO_Plate2
	addu	$3,$2,$3
	sw	$0,0($3)
	la	$3,CarIO_Plate1
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L666
	sw	$0,0($2)
	.set	macro
	.set	reorder

$L667:
	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,328			# 0x00000148
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,328			# 0x00000148
	move	$6,$0
	sll	$17,$22,2
	la	$16,CarIO_Plate1
	addu	$16,$17,$16
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,0($16)
	.set	macro
	.set	reorder

	move	$18,$0
	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,528			# 0x00000210
	li	$6,16			# 0x00000010
	la	$3,CarIO_Plate2
	addu	$17,$17,$3
	sw	$2,0($17)
	lw	$3,0($16)
	addu	$21,$2,280
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	addu	$20,$3,280
	.set	macro
	.set	reorder

	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
	lw	$4,R3DCar_LicenseShapeFile
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$19,$2
	.set	macro
	.set	reorder

	move	$7,$2
	lw	$2,0($7)
	move	$6,$7
	sra	$2,$2,8
	addu	$8,$7,$2
$L669:
	lw	$5,0($6)
	addu	$6,$6,4
	sll	$3,$18,2
	addu	$18,$18,1
	lw	$2,0($17)
	lw	$4,0($16)
	addu	$2,$3,$2
	addu	$3,$3,$4
	sw	$5,0($2)
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L669
	sw	$5,0($3)
	.set	macro
	.set	reorder

	move	$18,$0
	move	$3,$20
	move	$5,$21
	move	$4,$8
$L673:
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$18,$18,1
	sw	$2,0($5)
	sw	$2,0($3)
	addu	$3,$3,4
	slt	$2,$18,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	addu	$5,$5,4
	.set	macro
	.set	reorder

	li	$11,65536			# 0x00010000
	ori	$11,$11,0x1800
	addu	$4,$7,16
	move	$5,$19
	li	$6,48			# 0x00000030
	li	$7,22			# 0x00000016
	sll	$8,$22,2
	la	$2,CarIO_Plate1
	la	$3,CarIO_Plate2
	addu	$3,$8,$3
	lw	$9,0($3)
	addu	$8,$8,$2
	lbu	$2,0($9)
	lw	$10,0($8)
	or	$2,$2,$11
	sw	$2,0($9)
	lbu	$2,0($10)
	move	$18,$0
	or	$2,$2,$11
	sw	$2,0($10)
	lw	$3,0($3)
	lw	$8,0($8)
	li	$2,24			# 0x00000018
	sh	$2,4($3)
	sh	$2,4($8)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyFromShape__FPsT0iiii
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$23
	.set	macro
	.set	reorder

	move	$17,$2
	sll	$2,$17,1
	addu	$2,$2,$17
	li	$3,24			# 0x00000018
	subu	$16,$3,$2
	lui	$2,%hi($L693) # high
	addiu	$20,$2,%lo($L693) # low
$L677:
	slt	$2,$18,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L678
	addu	$2,$23,$18
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	li	$2,32			# 0x00000020
	andi	$4,$3,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L681
	addu	$4,$4,-192
	.set	macro
	.set	reorder

	sltu	$2,$4,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L682
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L693:
	.word	$L686
	.word	$L682
	.word	$L682
	.word	$L682
	.word	$L686
	.word	$L686
	.word	$L682
	.word	$L682
	.word	$L687
	.word	$L682
	.word	$L682
	.word	$L682
	.word	$L688
	.word	$L682
	.word	$L682
	.word	$L682
	.word	$L682
	.word	$L683
	.word	$L690
	.word	$L682
	.word	$L682
	.word	$L682
	.word	$L690
	.word	$L682
	.word	$L682
	.word	$L692
	.word	$L682
	.word	$L682
	.word	$L692
	.text
$L683:
	.set	noreorder
	.set	nomacro
	j	$L682
	li	$3,110			# 0x0000006e
	.set	macro
	.set	reorder

$L686:
	.set	noreorder
	.set	nomacro
	j	$L682
	li	$3,97			# 0x00000061
	.set	macro
	.set	reorder

$L687:
	.set	noreorder
	.set	nomacro
	j	$L682
	li	$3,101			# 0x00000065
	.set	macro
	.set	reorder

$L688:
	.set	noreorder
	.set	nomacro
	j	$L682
	li	$3,105			# 0x00000069
	.set	macro
	.set	reorder

$L690:
	.set	noreorder
	.set	nomacro
	j	$L682
	li	$3,111			# 0x0000006f
	.set	macro
	.set	reorder

$L692:
	li	$3,117			# 0x00000075
$L682:
 #APP
 #NO_APP
	addu	$4,$sp,24
	lui	$5,%hi($LC5) # high
	addiu	$5,$5,%lo($LC5) # low
	sb	$3,24($sp)
	.set	noreorder
	.set	nomacro
	jal	strcat
	sb	$0,25($sp)
	.set	macro
	.set	reorder

	lw	$4,R3DCar_LicenseShapeFile
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	addu	$4,$2,16
	move	$5,$19
	li	$6,7			# 0x00000007
	li	$7,12			# 0x0000000c
	li	$2,5			# 0x00000005
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyFromShape__FPsT0iiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L681:
	addu	$16,$16,6
	.set	noreorder
	.set	nomacro
	j	$L677
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L678:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L699
	move	$4,$19
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L699
	sll	$16,$22,2
	.set	macro
	.set	reorder

	addu	$4,$19,12
	la	$2,CarIO_Plate1
	addu	$2,$16,$2
	lw	$5,0($2)
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	addu	$5,$5,16
	.set	macro
	.set	reorder

	move	$4,$19
	la	$2,CarIO_Plate2
	addu	$16,$16,$2
	lw	$5,0($16)
	.set	noreorder
	.set	nomacro
	j	$L698
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L699:
	sll	$16,$22,2
	la	$2,CarIO_Plate1
	addu	$2,$16,$2
	lw	$5,0($2)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	addu	$5,$5,16
	.set	macro
	.set	reorder

	addu	$4,$19,12
	la	$2,CarIO_Plate2
	addu	$16,$16,$2
	lw	$5,0($16)
	move	$6,$0
$L698:
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	addu	$5,$5,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$19
	.set	macro
	.set	reorder

$L666:
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

	.end	CarIO_CreateLicense__FPcii
	.text
	.ent	CarIO_CleanUpLicense__Fi
CarIO_CleanUpLicense__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	sll	$17,$4,2
	la	$2,CarIO_Plate1
	sw	$16,16($sp)
	addu	$16,$17,$2
	sw	$31,24($sp)
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L701
	jal	purgememadr
$L701:
	la	$2,CarIO_Plate2
	sw	$0,0($16)
	addu	$16,$17,$2
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L702
	jal	purgememadr
$L702:
	sw	$0,0($16)
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

	.end	CarIO_CleanUpLicense__Fi
	.text
	.ent	CarIO_LicenseCheck__FiPiT1P8Car_tObji
CarIO_LicenseCheck__FiPiT1P8Car_tObji:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$5
	lw	$3,16($sp)
	andi	$4,$4,0x0002
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L705
	move	$9,$6
	.set	macro
	.set	reorder

	lw	$4,CarIO_licenseSFX_Count
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L707
	addu	$2,$7,$3
	.set	macro
	.set	reorder

	lui	$2,%hi(CarIO_licenseSFX_Vram) # high
	addiu	$2,$2,%lo(CarIO_licenseSFX_Vram) # low
	sll	$4,$4,2
	addu	$4,$4,$2
	addu	$5,$7,$3
	lh	$6,0($4)
	lw	$2,0($8)
	lh	$4,2($4)
	andi	$3,$6,0x003f
	andi	$2,$2,0x003f
	subu	$3,$3,$2
	sll	$3,$3,2
	sb	$3,2252($5)
	lbu	$2,0($9)
	#nop
	subu	$2,$4,$2
	sb	$2,2254($5)
	sw	$6,0($8)
	sw	$4,0($9)
	lw	$2,CarIO_licenseSFX_Count
	#nop
	addu	$2,$2,1
	sw	$2,CarIO_licenseSFX_Count
	j	$31
$L705:
	addu	$2,$7,$3
$L707:
	sb	$0,2254($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,2252($2)
	.set	macro
	.set	reorder

	.end	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	.text
	.ent	CarIO_ReadInCarTextureData__FPcP8Car_tObjii
CarIO_ReadInCarTextureData__FPcP8Car_tObjii:
	.frame	$sp,136,$31		# vars= 64, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$16,96($sp)
	move	$16,$7
	li	$8,8			# 0x00000008
	sw	$31,132($sp)
	sw	$fp,128($sp)
	sw	$23,124($sp)
	sw	$22,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$18,104($sp)
	sw	$17,100($sp)
	sw	$4,136($sp)
	sw	$5,140($sp)
	sw	$6,144($sp)
	sw	$8,72($sp)
	lh	$9,2236($5)
	andi	$2,$6,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L709
	sw	$9,64($sp)
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L710
	lui	$2,%hi(CarIO_carVRamSlotsMenu) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(CarIO_carVRamSlots) # high
	lw	$4,CarIO_carVRamCount
	addiu	$2,$2,%lo(CarIO_carVRamSlots) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lhu	$2,0($3)
	#nop
	sh	$2,2244($5)
	sll	$2,$2,16
	sra	$22,$2,16
	lhu	$3,2($3)
	lw	$8,140($sp)
	sll	$2,$3,16
	sra	$23,$2,16
	slt	$2,$9,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L711
	sh	$3,2246($8)
	.set	macro
	.set	reorder

	lhu	$2,2240($8)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L712
	li	$2,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	ori	$2,$2,0x5556
	mult	$4,$2
	sra	$2,$4,31
	lui	$3,%hi(CarIO_carVRamAdd) # high
	addiu	$3,$3,%lo(CarIO_carVRamAdd) # low
	mfhi	$8
	#nop
	#nop
	subu	$2,$8,$2
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	addu	$2,$4,$2
	sw	$2,CarIO_carVRamCount
	j	$L716
$L712:
	addu	$2,$4,3
	sw	$2,CarIO_carVRamCount
	j	$L716
$L711:
	addu	$2,$4,1
	sw	$2,CarIO_carVRamCount
	j	$L716
$L710:
	addiu	$2,$2,%lo(CarIO_carVRamSlotsMenu) # low
	lw	$5,CarIO_carVRamCount
	lw	$9,140($sp)
	sll	$3,$5,2
	addu	$3,$3,$2
	lhu	$2,0($3)
	#nop
	sh	$2,2244($9)
	sll	$2,$2,16
	sra	$22,$2,16
	lhu	$4,2($3)
	lui	$3,%hi(CarIO_carVRamAdd) # high
	addiu	$3,$3,%lo(CarIO_carVRamAdd) # low
	sll	$2,$5,1
	addu	$2,$2,$3
	sh	$4,2246($9)
	sll	$4,$4,16
	lh	$2,0($2)
	#nop
	addu	$5,$5,$2
	sw	$5,CarIO_carVRamCount
	.set	noreorder
	.set	nomacro
	j	$L716
	sra	$23,$4,16
	.set	macro
	.set	reorder

$L709:
	lw	$8,140($sp)
	#nop
	lh	$22,2244($8)
	lh	$23,2246($8)
$L716:
	lw	$9,144($sp)
	#nop
	andi	$2,$9,0x0010
	bne	$2,$0,$L717
	lw	$8,CarIO_carPixMapCount
	lw	$9,140($sp)
	sw	$8,68($sp)
	.set	noreorder
	.set	nomacro
	j	$L718
	sw	$8,2116($9)
	.set	macro
	.set	reorder

$L717:
	lw	$8,140($sp)
	#nop
	lw	$8,2116($8)
	#nop
	sw	$8,68($sp)
$L718:
	lw	$9,68($sp)
 #APP
 #NO_APP
	lw	$8,144($sp)
	#nop
	andi	$2,$8,0x0008
	beq	$2,$0,$L719
	lw	$9,140($sp)
	#nop
	lhu	$2,2240($9)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L750
	andi	$2,$22,0x003f
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L721
	addu	$3,$22,-512
	.set	macro
	.set	reorder

	addu	$3,$22,-640
$L721:
	sra	$3,$3,6
	lui	$2,%hi(CarIO_carVRamOffset) # high
	addiu	$2,$2,%lo(CarIO_carVRamOffset) # low
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	addu	$22,$22,$2
	andi	$2,$22,0x003f
$L750:
	lw	$8,140($sp)
	sll	$2,$2,2
	sh	$2,2248($8)
	andi	$2,$23,0x00ff
	sh	$2,2250($8)
$L719:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L722
	move	$19,$0
	.set	macro
	.set	reorder

	lw	$9,72($sp)
	#nop
	ori	$9,$9,0x0010
	sw	$9,72($sp)
$L722:
	lw	$8,140($sp)
	lw	$9,68($sp)
	lw	$2,2180($8)
	#nop
	sw	$2,Texture_palCopy
	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	sll	$17,$9,4
	.set	macro
	.set	reorder

	sll	$3,$16,2
	la	$2,CarIO_Plate1
	addu	$2,$3,$2
	sw	$2,80($sp)
	la	$2,CarIO_Plate2
	addu	$3,$3,$2
	lui	$2,%hi(D_8011E804) # high
	lw	$8,140($sp)
	addiu	$fp,$2,%lo(D_8011E804) # low
	sw	$3,84($sp)
	sw	$8,88($sp)
$L723:
	slt	$2,$19,51
	beq	$2,$0,$L724
	lw	$4,136($sp)
	lw	$5,4($fp)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	li	$20,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$9,8($fp)
	move	$18,$2
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L727
	sw	$9,76($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$9,$0,$L751
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$5,0($fp)
	lw	$4,136($sp)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$20,$0
	.set	macro
	.set	reorder

	move	$18,$2
$L727:
	li	$2,20			# 0x00000014
$L751:
	bne	$19,$2,$L728
	sw	$0,72($sp)
$L728:
	beq	$18,$0,$L729
	lw	$8,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L730
	move	$16,$0
	.set	macro
	.set	reorder

	lhu	$2,Texture_palNum
	lw	$9,88($sp)
	#nop
	sh	$2,2186($9)
$L730:
	lw	$8,64($sp)
	#nop
	slt	$2,$8,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L731
	sll	$2,$8,1
	.set	macro
	.set	reorder

	addu	$2,$2,$8
	sll	$2,$2,2
	lui	$9,%hi(CarIO_licensePlate) # high
	addiu	$9,$9,%lo(CarIO_licensePlate) # low
	addu	$3,$2,$9
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L732
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	addu	$6,$sp,36
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,2($3)
	lh	$3,4($3)
	addu	$2,$22,$2
	addu	$3,$23,$3
	sw	$2,32($sp)
	sw	$3,36($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$6,72($sp)
	lw	$7,32($sp)
	lw	$5,36($sp)
	lw	$3,CarIO_carPixMap
	lw	$8,80($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,$17
	sw	$5,16($sp)
	sw	$3,28($sp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,CarIO_carPixMap
	li	$16,1			# 0x00000001
	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L731
	sh	$16,14($2)
	.set	macro
	.set	reorder

$L732:
	lh	$2,6($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L731
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	addu	$6,$sp,44
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,8($3)
	lh	$3,10($3)
	addu	$2,$22,$2
	addu	$3,$23,$3
	sw	$2,40($sp)
	li	$2,1			# 0x00000001
	sw	$3,44($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$6,72($sp)
	lw	$7,40($sp)
	lw	$5,44($sp)
	lw	$3,CarIO_carPixMap
	lw	$9,84($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,$17
	sw	$5,16($sp)
	sw	$3,28($sp)
	lw	$5,0($9)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	move	$4,$0
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lw	$3,CarIO_carPixMap
	li	$2,2			# 0x00000002
	addu	$3,$17,$3
	sh	$2,14($3)
$L731:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L752
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$18
	move	$7,$22
	lw	$6,72($sp)
	lw	$3,CarIO_carPixMap
	li	$2,-1			# 0xffffffff
	sw	$23,16($sp)
	sw	$2,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,$17
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L752:
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L736
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$17
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L736:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$17,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L729:
	beq	$20,$0,$L725
	lw	$8,76($sp)
	lw	$16,68($sp)
	beq	$8,$0,$L738
	lw	$9,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L739
	addu	$16,$8,-1
	.set	macro
	.set	reorder

	sll	$2,$16,1
	lw	$8,140($sp)
	lw	$9,88($sp)
	addu	$2,$8,$2
	lhu	$2,2186($2)
	#nop
	sh	$2,2186($9)
$L739:
	lw	$8,140($sp)
	#nop
	lw	$2,2116($8)
	#nop
	addu	$16,$16,$2
$L738:
	lw	$5,0($fp)
	lw	$4,136($sp)
	jal	locateshapez
	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L725
	sll	$2,$16,4
	.set	macro
	.set	reorder

	lw	$3,CarIO_carPixMap
	move	$16,$0
	addu	$2,$2,$3
	lhu	$3,2($2)
	lw	$9,64($sp)
	andi	$2,$3,0x003f
	sll	$20,$2,4
	slt	$2,$9,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L741
	srl	$21,$3,6
	.set	macro
	.set	reorder

	sll	$2,$9,1
	addu	$2,$2,$9
	sll	$2,$2,2
	lui	$8,%hi(CarIO_licensePlate) # high
	addiu	$8,$8,%lo(CarIO_licensePlate) # low
	addu	$3,$2,$8
	lh	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L742
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	addu	$6,$sp,52
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,2($3)
	lh	$3,4($3)
	addu	$2,$22,$2
	addu	$3,$23,$3
	sw	$2,48($sp)
	sw	$3,52($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$7,48($sp)
	lw	$3,52($sp)
	lw	$2,CarIO_carPixMap
	lw	$9,80($sp)
	move	$4,$16
	sw	$20,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$17
	sw	$3,16($sp)
	sw	$2,28($sp)
	lw	$5,0($9)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	lw	$2,CarIO_carPixMap
	li	$16,1			# 0x00000001
	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L741
	sh	$16,14($2)
	.set	macro
	.set	reorder

$L742:
	lh	$2,6($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L741
	addu	$5,$sp,56
	.set	macro
	.set	reorder

	addu	$6,$sp,60
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,8($3)
	lh	$3,10($3)
	addu	$2,$22,$2
	addu	$3,$23,$3
	sw	$2,56($sp)
	li	$2,1			# 0x00000001
	sw	$3,60($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$7,56($sp)
	lw	$3,60($sp)
	lw	$2,CarIO_carPixMap
	lw	$8,84($sp)
	move	$4,$0
	sw	$20,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$17
	sw	$3,16($sp)
	sw	$2,28($sp)
	lw	$5,0($8)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lw	$3,CarIO_carPixMap
	li	$2,2			# 0x00000002
	addu	$3,$17,$3
	sh	$2,14($3)
$L741:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L753
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$18
	li	$6,32			# 0x00000020
	lw	$2,CarIO_carPixMap
	move	$7,$22
	sw	$23,16($sp)
	sw	$20,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L753:
	.set	noreorder
	.set	nomacro
	bne	$19,$2,$L746
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$17
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L746:
	lw	$9,76($sp)
	#nop
	bne	$9,$0,$L725
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$17,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L725:
	addu	$17,$17,16
	addu	$fp,$fp,12
	addu	$19,$19,1
	lw	$8,68($sp)
	lw	$9,88($sp)
	addu	$8,$8,1
	addu	$9,$9,2
	sw	$8,68($sp)
	.set	noreorder
	.set	nomacro
	j	$L723
	sw	$9,88($sp)
	.set	macro
	.set	reorder

$L724:
	lw	$8,144($sp)
	#nop
	andi	$2,$8,0x0080
	beq	$2,$0,$L708
	lw	$9,68($sp)
	#nop
	sw	$9,CarIO_carPixMapCount
$L708:
	lw	$31,132($sp)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	CarIO_ReadInCarTextureData__FPcP8Car_tObjii
	.text
	.ent	CarIO_UpdateCarTextureData__FPcP8Car_tObji
CarIO_UpdateCarTextureData__FPcP8Car_tObji:
	.frame	$sp,104,$31		# vars= 32, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$31,100($sp)
	sw	$fp,96($sp)
	sw	$23,92($sp)
	sw	$22,88($sp)
	sw	$21,84($sp)
	sw	$20,80($sp)
	sw	$19,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	sw	$4,104($sp)
	sw	$5,108($sp)
	lw	$8,2116($5)
	lw	$2,R3DCar_InMenu
	sw	$8,44($sp)
	lh	$8,2236($5)
	#nop
	sw	$8,32($sp)
	lh	$8,2244($5)
	move	$16,$6
	sw	$8,36($sp)
	lh	$8,2246($5)
	li	$fp,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L755
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	li	$fp,24			# 0x00000018
$L755:
	lw	$8,108($sp)
	#nop
	lw	$2,2180($8)
	lw	$8,44($sp)
	move	$22,$0
	sw	$2,Texture_palCopy
	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	sll	$21,$8,4
	.set	macro
	.set	reorder

	lui	$3,%hi(CarIO_licensePlate) # high
	addiu	$3,$3,%lo(CarIO_licensePlate) # low
	lw	$8,32($sp)
	sll	$16,$16,2
	sw	$16,56($sp)
	sll	$2,$8,1
	addu	$2,$2,$8
	sll	$2,$2,2
	addu	$18,$2,$3
	lui	$2,%hi(D_8011E804) # high
	lw	$8,108($sp)
	addiu	$23,$2,%lo(D_8011E804) # low
$L785:
	slt	$2,$22,51
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L754
	sw	$8,60($sp)
	.set	macro
	.set	reorder

	lw	$4,104($sp)
	lw	$5,4($23)
	li	$8,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	sw	$8,52($sp)
	.set	macro
	.set	reorder

	lw	$8,8($23)
	move	$17,$2
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L760
	sw	$8,48($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L786
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	sw	$0,52($sp)
	lw	$5,0($23)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
$L760:
	li	$2,20			# 0x00000014
$L786:
	bne	$22,$2,$L761
	move	$fp,$0
$L761:
	beq	$17,$0,$L762
	lw	$2,CarIO_carPixMap
	#nop
	addu	$5,$21,$2
	lhu	$2,14($5)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L758
	move	$16,$0
	.set	macro
	.set	reorder

	lhu	$3,2($5)
	#nop
	andi	$2,$3,0x003f
	sll	$19,$2,4
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L764
	srl	$20,$3,6
	.set	macro
	.set	reorder

	lw	$8,60($sp)
	#nop
	lh	$2,2186($8)
	#nop
	sw	$2,Texture_palNum
$L764:
	lw	$8,32($sp)
	#nop
	slt	$2,$8,22
	beq	$2,$0,$L765
	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L766
	move	$4,$0
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lh	$2,4($18)
	lw	$8,40($sp)
	lh	$7,2($18)
	addu	$2,$8,$2
	lw	$8,56($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$5,28($sp)
	sw	$2,16($sp)
	la	$2,CarIO_Plate1
	.set	noreorder
	.set	nomacro
	j	$L783
	move	$6,$fp
	.set	macro
	.set	reorder

$L766:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L765
	move	$6,$fp
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lh	$2,10($18)
	lw	$8,40($sp)
	lh	$7,8($18)
	addu	$2,$8,$2
	lw	$8,56($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$5,28($sp)
	sw	$2,16($sp)
	la	$2,CarIO_Plate2
$L783:
	addu	$2,$8,$2
	lw	$8,36($sp)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	addu	$7,$8,$7
	.set	macro
	.set	reorder

$L765:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L787
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$17
	lw	$2,CarIO_carPixMap
	lw	$7,36($sp)
	lw	$8,40($sp)
	move	$6,$fp
	sw	$19,20($sp)
	sw	$20,24($sp)
	addu	$2,$2,$21
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L787:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L770
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$21
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L770:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L762:
	lw	$8,52($sp)
	#nop
	beq	$8,$0,$L758
	lw	$8,48($sp)
	lw	$16,44($sp)
	beq	$8,$0,$L772
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L773
	addu	$16,$8,-1
	.set	macro
	.set	reorder

	lw	$8,108($sp)
	sll	$2,$16,1
	addu	$2,$8,$2
	lhu	$2,2186($2)
	lw	$8,60($sp)
	#nop
	sh	$2,2186($8)
$L773:
	lw	$8,108($sp)
	#nop
	lw	$2,2116($8)
	#nop
	addu	$16,$16,$2
$L772:
	lw	$5,0($23)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L758
	sll	$2,$16,4
	.set	macro
	.set	reorder

	lw	$5,CarIO_carPixMap
	move	$16,$0
	addu	$2,$2,$5
	lhu	$3,2($2)
	lw	$8,32($sp)
	andi	$2,$3,0x003f
	sll	$19,$2,4
	slt	$2,$8,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L775
	srl	$20,$3,6
	.set	macro
	.set	reorder

	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L776
	move	$4,$0
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lh	$7,2($18)
	lh	$3,4($18)
	lw	$8,40($sp)
	addu	$2,$5,$21
	sw	$2,28($sp)
	addu	$3,$8,$3
	lw	$8,56($sp)
	la	$2,CarIO_Plate1
	.set	noreorder
	.set	nomacro
	j	$L784
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

$L776:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L775
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	lh	$7,8($18)
	lh	$3,10($18)
	lw	$8,40($sp)
	addu	$2,$5,$21
	sw	$2,28($sp)
	addu	$3,$8,$3
	lw	$8,56($sp)
	la	$2,CarIO_Plate2
$L784:
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$3,16($sp)
	addu	$2,$8,$2
	lw	$8,36($sp)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	addu	$7,$8,$7
	.set	macro
	.set	reorder

$L775:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L788
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$17
	lw	$2,CarIO_carPixMap
	lw	$7,36($sp)
	lw	$8,40($sp)
	li	$6,32			# 0x00000020
	sw	$19,20($sp)
	sw	$20,24($sp)
	addu	$2,$2,$21
	sw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L788:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L780
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$21
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L780:
	lw	$8,48($sp)
	#nop
	bne	$8,$0,$L758
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L758:
	addu	$21,$21,16
	lw	$8,44($sp)
	addu	$23,$23,12
	addu	$8,$8,1
	sw	$8,44($sp)
	lw	$8,60($sp)
	addu	$22,$22,1
	.set	noreorder
	.set	nomacro
	j	$L785
	addu	$8,$8,2
	.set	macro
	.set	reorder

$L754:
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

	.end	CarIO_UpdateCarTextureData__FPcP8Car_tObji
	.text
	.ent	CarIO_ReleaseCarCluts__FP8Car_tObj
CarIO_ReleaseCarCluts__FP8Car_tObj:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$17,2116($4)
$L790:
	lw	$3,CarIO_carPixMap
	sll	$2,$17,4
	addu	$3,$2,$3
	lhu	$2,14($3)
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L793
	lh	$4,2($3)
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sh	$0,14($3)
	.set	macro
	.set	reorder

$L793:
	addu	$16,$16,1
	slt	$2,$16,51
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L790
	addu	$17,$17,1
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

	.end	CarIO_ReleaseCarCluts__FP8Car_tObj
