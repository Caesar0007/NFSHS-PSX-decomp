	.file	1 "C:\\\\Temp\\\\nfs4-wt39-a5\\\\recon\\\\game\\\\psx\\\\cario.cpp"
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
	.extern	CarIO_textureName, 612
	.extern	Texture_palCopy, 4
	.extern	CarIO_carVRamOffset, 12
	.extern	CarIO_carVRamSlotsMenu, 24
	.extern	CarIO_carVRamAdd, 12
	.extern	CarIO_carVRamSlots, 72
	.extern	CarIO_licenseSFX_Vram, 48
	.extern	GameSetup_gData, 2600
	.extern	R3DCar_InMenu, 4

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
	bne	$2,$0,$L369
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
$L369:
	lw	$2,CarIO_carPixMap
	li	$3,611			# 0x00000263
	addu	$2,$2,9776
$L370:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L370
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
	beq	$4,$0,$L375
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L375:
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
$L377:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L377
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
	.frame	$sp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x00010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sra	$9,$6,2
	lw	$25,24($sp)
	lw	$8,28($sp)
	andi	$6,$6,0x0003
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L382
	sw	$16,0($sp)
	.set	macro
	.set	reorder

	addu	$9,$9,1
$L382:
	sra	$3,$25,2
	sll	$3,$3,1
	addu	$3,$5,$3
	sll	$2,$8,1
	addu	$2,$2,$8
	sll	$2,$2,3
	addu	$12,$3,$2
	li	$13,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L419
	move	$8,$13
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L419
	move	$8,$0
	.set	macro
	.set	reorder

$L386:
	sll	$8,$8,4
$L419:
	addu	$6,$6,-1
	nor	$2,$0,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L386
	move	$15,$0
	.set	macro
	.set	reorder

	andi	$6,$25,0x0003
	li	$10,-1			# 0xffffffff
$L390:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$10,$L389
	sll	$2,$15,4
	.set	macro
	.set	reorder

	ori	$15,$2,0x000f
	andi	$5,$8,0xf000
	sll	$8,$8,4
	sll	$3,$13,4
	srl	$2,$5,12
	.set	noreorder
	.set	nomacro
	j	$L390
	or	$13,$3,$2
	.set	macro
	.set	reorder

$L389:
	andi	$3,$13,0xffff
	li	$2,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L393
	move	$16,$8
	.set	macro
	.set	reorder

	addu	$9,$9,1
	move	$16,$13
$L393:
	li	$14,-1			# 0xffffffff
	addu	$24,$9,$14
$L396:
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$14,$L381
	move	$6,$0
	.set	macro
	.set	reorder

	lhu	$5,0($4)
	andi	$8,$25,0x0003
$L400:
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	beq	$8,$14,$L399
	andi	$2,$5,0xf000
	.set	macro
	.set	reorder

	sll	$5,$5,4
	sll	$3,$6,4
	srl	$2,$2,12
	.set	noreorder
	.set	nomacro
	j	$L400
	or	$6,$3,$2
	.set	macro
	.set	reorder

$L399:
	li	$11,1			# 0x00000001
	move	$10,$4
	lhu	$2,0($12)
	move	$9,$12
	and	$2,$2,$15
	or	$2,$2,$5
	sh	$2,0($12)
$L405:
	addu	$9,$9,2
	addu	$4,$10,2
	slt	$2,$11,$24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L404
	andi	$8,$25,0x0003
	.set	macro
	.set	reorder

	sh	$6,0($9)
	move	$6,$0
	lhu	$5,2($10)
$L409:
	addu	$8,$8,-1
	.set	noreorder
	.set	nomacro
	beq	$8,$14,$L408
	andi	$2,$5,0xf000
	.set	macro
	.set	reorder

	sll	$5,$5,4
	sll	$3,$6,4
	srl	$2,$2,12
	.set	noreorder
	.set	nomacro
	j	$L409
	or	$6,$3,$2
	.set	macro
	.set	reorder

$L408:
	addu	$11,$11,1
	lhu	$2,0($9)
	move	$10,$4
	or	$2,$2,$5
	.set	noreorder
	.set	nomacro
	j	$L405
	sh	$2,0($9)
	.set	macro
	.set	reorder

$L404:
	sll	$3,$11,1
	addu	$3,$3,$12
	lhu	$2,0($3)
	#nop
	and	$2,$2,$16
	or	$2,$2,$6
	sh	$2,0($3)
	andi	$3,$13,0xffff
	li	$2,65535			# 0x0000ffff
	bne	$3,$2,$L413
	lhu	$5,0($4)
	.set	noreorder
	.set	nomacro
	j	$L420
	addu	$4,$10,4
	.set	macro
	.set	reorder

$L416:
	sll	$5,$5,4
$L420:
	addu	$8,$8,-1
	nor	$2,$0,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L416
	sll	$3,$11,1
	.set	macro
	.set	reorder

	addu	$3,$3,$12
	lhu	$2,0($3)
	#nop
	or	$2,$2,$5
	sh	$2,0($3)
$L413:
	.set	noreorder
	.set	nomacro
	j	$L396
	addu	$12,$12,24
	.set	macro
	.set	reorder

$L381:
	lw	$16,0($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	CarIO_CopyFromShape__FPsT0iiii
	.text
	.ent	CarIO_CopyToShape__FPsT0i
CarIO_CopyToShape__FPsT0i:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$9,$4
	li	$10,22			# 0x00000016
	li	$11,-1			# 0xffffffff
$L422:
	addu	$10,$10,-1
	beq	$10,$11,$L437
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L426
	li	$7,5			# 0x00000005
	.set	macro
	.set	reorder

	move	$7,$0
	move	$3,$9
$L427:
	lhu	$2,0($3)
	addu	$3,$3,2
	addu	$7,$7,1
	sh	$2,0($5)
	slt	$2,$7,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L427
	addu	$5,$5,2
	.set	macro
	.set	reorder

$L436:
	.set	noreorder
	.set	nomacro
	j	$L422
	addu	$9,$9,24
	.set	macro
	.set	reorder

$L426:
	addu	$8,$9,10
$L432:
	.set	noreorder
	.set	nomacro
	bltz	$7,$L436
	addu	$7,$7,-1
	.set	macro
	.set	reorder

	lhu	$4,0($8)
	addu	$8,$8,-2
	andi	$3,$4,0x000f
	sll	$3,$3,12
	andi	$2,$4,0x00f0
	sll	$2,$2,4
	or	$3,$3,$2
	andi	$2,$4,0x0f00
	srl	$2,$2,4
	or	$3,$3,$2
	srl	$4,$4,12
	or	$3,$3,$4
	sh	$3,0($5)
	.set	noreorder
	.set	nomacro
	j	$L432
	addu	$5,$5,2
	.set	macro
	.set	reorder

$L437:
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
	bne	$5,$0,$L439
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
	j	$L438
	sw	$0,0($2)
	.set	macro
	.set	reorder

$L439:
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
	sll	$16,$22,2
	la	$3,CarIO_Plate1
	addu	$20,$16,$3
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,0($20)
	.set	macro
	.set	reorder

	move	$17,$2
	move	$18,$0
	la	$2,CarIO_Plate2
	addu	$16,$16,$2
	sw	$17,0($16)
	addu	$17,$17,280
	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,528			# 0x00000210
	lw	$2,0($20)
	li	$6,16			# 0x00000010
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	addu	$19,$2,280
	.set	macro
	.set	reorder

	lui	$4,%hi(R3DCar_LicenseShapeFile) # high
	addiu	$4,$4,%lo(R3DCar_LicenseShapeFile) # low
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$21,$2
	.set	macro
	.set	reorder

	move	$7,$2
	move	$5,$7
	lw	$2,0($7)
	move	$8,$16
	sra	$2,$2,8
	addu	$6,$7,$2
$L441:
	lw	$4,0($5)
	addu	$5,$5,4
	sll	$16,$18,2
	addu	$18,$18,1
	lw	$2,0($8)
	lw	$3,0($20)
	addu	$2,$2,$16
	addu	$3,$3,$16
	sw	$4,0($2)
	slt	$2,$18,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L441
	sw	$4,0($3)
	.set	macro
	.set	reorder

	move	$18,$0
$L445:
	lw	$2,0($6)
	addu	$6,$6,4
	addu	$18,$18,1
	sw	$2,0($17)
	sw	$2,0($19)
	addu	$19,$19,4
	slt	$2,$18,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L445
	addu	$17,$17,4
	.set	macro
	.set	reorder

	sll	$8,$22,2
	li	$9,65536			# 0x00010000
	ori	$9,$9,0x1800
	addu	$4,$7,16
	move	$5,$21
	li	$6,48			# 0x00000030
	li	$7,22			# 0x00000016
	la	$3,CarIO_Plate2
	addu	$3,$8,$3
	la	$2,CarIO_Plate1
	lw	$19,0($3)
	addu	$8,$8,$2
	lbu	$2,0($19)
	lw	$17,0($8)
	or	$2,$2,$9
	sw	$2,0($19)
	lbu	$2,0($17)
	move	$16,$0
	or	$2,$2,$9
	sw	$2,0($17)
	lw	$17,0($8)
	lw	$3,0($3)
	li	$2,24			# 0x00000018
	sh	$2,4($3)
	sh	$2,4($17)
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
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	blez	$17,$L450
	addu	$18,$2,24
	.set	macro
	.set	reorder

	lui	$2,%hi($L465) # high
	addiu	$19,$2,%lo($L465) # low
$L452:
	addu	$2,$23,$16
	lbu	$6,0($2)
	li	$2,32			# 0x00000020
	andi	$3,$6,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L453
	addu	$3,$3,64
	.set	macro
	.set	reorder

	sltu	$2,$3,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L454
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$2,$19
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L465:
	.word	$L457
	.word	$L454
	.word	$L454
	.word	$L454
	.word	$L457
	.word	$L457
	.word	$L454
	.word	$L454
	.word	$L458
	.word	$L454
	.word	$L454
	.word	$L454
	.word	$L459
	.word	$L454
	.word	$L454
	.word	$L454
	.word	$L454
	.word	$L460
	.word	$L462
	.word	$L454
	.word	$L454
	.word	$L454
	.word	$L462
	.word	$L454
	.word	$L454
	.word	$L464
	.word	$L454
	.word	$L454
	.word	$L464
	.text
$L457:
	.set	noreorder
	.set	nomacro
	j	$L454
	li	$6,97			# 0x00000061
	.set	macro
	.set	reorder

$L458:
	.set	noreorder
	.set	nomacro
	j	$L454
	li	$6,101			# 0x00000065
	.set	macro
	.set	reorder

$L459:
	.set	noreorder
	.set	nomacro
	j	$L454
	li	$6,105			# 0x00000069
	.set	macro
	.set	reorder

$L460:
	.set	noreorder
	.set	nomacro
	j	$L454
	li	$6,110			# 0x0000006e
	.set	macro
	.set	reorder

$L462:
	.set	noreorder
	.set	nomacro
	j	$L454
	li	$6,111			# 0x0000006f
	.set	macro
	.set	reorder

$L464:
	li	$6,117			# 0x00000075
$L454:
	addu	$4,$sp,24
	lui	$5,%hi($LC5) # high
	addiu	$5,$5,%lo($LC5) # low
	sb	$0,25($sp)
	.set	noreorder
	.set	nomacro
	jal	strcat
	sb	$6,24($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(R3DCar_LicenseShapeFile) # high
	addiu	$4,$4,%lo(R3DCar_LicenseShapeFile) # low
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	addu	$5,$sp,24
	.set	macro
	.set	reorder

	addu	$4,$2,16
	move	$5,$21
	li	$6,7			# 0x00000007
	li	$7,12			# 0x0000000c
	li	$2,5			# 0x00000005
	sw	$18,16($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyFromShape__FPsT0iiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L453:
	addu	$16,$16,1
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L452
	addu	$18,$18,6
	.set	macro
	.set	reorder

$L450:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L472
	move	$4,$21
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L472
	sll	$16,$22,2
	.set	macro
	.set	reorder

	addu	$4,$21,12
	li	$6,1			# 0x00000001
	la	$2,CarIO_Plate1
	addu	$2,$16,$2
	lw	$5,0($2)
	move	$18,$6
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	addu	$5,$5,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L471
	move	$4,$21
	.set	macro
	.set	reorder

$L472:
	move	$6,$0
	sll	$16,$22,2
	la	$2,CarIO_Plate1
	addu	$2,$16,$2
	lw	$5,0($2)
	move	$18,$6
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	addu	$5,$5,16
	.set	macro
	.set	reorder

	addu	$4,$21,12
$L471:
	la	$2,CarIO_Plate2
	addu	$16,$16,$2
	lw	$17,0($16)
	#nop
	addu	$5,$17,16
	.set	noreorder
	.set	nomacro
	jal	CarIO_CopyToShape__FPsT0i
	move	$6,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

$L438:
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
	beq	$4,$0,$L474
	jal	purgememadr
$L474:
	la	$2,CarIO_Plate2
	sw	$0,0($16)
	addu	$16,$17,$2
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L475
	jal	purgememadr
$L475:
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
	beq	$4,$0,$L478
	move	$9,$6
	.set	macro
	.set	reorder

	lw	$4,CarIO_licenseSFX_Count
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L480
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
$L478:
	addu	$2,$7,$3
$L480:
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
	sw	$8,80($sp)
	lh	$9,2236($5)
	andi	$2,$6,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L482
	sw	$9,72($sp)
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L483
	lui	$2,%hi(CarIO_carVRamSlotsMenu) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(CarIO_carVRamSlots) # high
	addiu	$2,$2,%lo(CarIO_carVRamSlots) # low
	lw	$6,CarIO_carVRamCount
	#nop
	sll	$3,$6,2
	addu	$3,$3,$2
	lhu	$5,0($3)
	lw	$8,140($sp)
	sll	$4,$5,16
	sh	$5,2244($8)
	lh	$fp,2($3)
	lhu	$2,2($3)
	#nop
	sh	$2,2246($8)
	slt	$2,$9,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L484
	sra	$23,$4,16
	.set	macro
	.set	reorder

	lhu	$2,2240($8)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L485
	li	$2,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	ori	$2,$2,0x5556
	mult	$6,$2
	lui	$3,%hi(CarIO_carVRamAdd) # high
	addiu	$3,$3,%lo(CarIO_carVRamAdd) # low
	sra	$2,$6,31
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
	addu	$2,$6,$2
	sw	$2,CarIO_carVRamCount
	j	$L489
$L485:
	addu	$2,$6,3
	sw	$2,CarIO_carVRamCount
	j	$L489
$L484:
	addu	$2,$6,1
	sw	$2,CarIO_carVRamCount
	j	$L489
$L483:
	lw	$4,CarIO_carVRamCount
	addiu	$2,$2,%lo(CarIO_carVRamSlotsMenu) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lhu	$5,0($3)
	lw	$9,140($sp)
	sll	$2,$5,16
	sra	$23,$2,16
	lui	$2,%hi(CarIO_carVRamAdd) # high
	addiu	$2,$2,%lo(CarIO_carVRamAdd) # low
	sh	$5,2244($9)
	lhu	$5,2($3)
	sll	$3,$4,1
	addu	$3,$3,$2
	sll	$2,$5,16
	sh	$5,2246($9)
	lh	$3,0($3)
	#nop
	addu	$4,$4,$3
	sw	$4,CarIO_carVRamCount
	.set	noreorder
	.set	nomacro
	j	$L489
	sra	$fp,$2,16
	.set	macro
	.set	reorder

$L482:
	lw	$8,140($sp)
	#nop
	lh	$23,2244($8)
	lh	$fp,2246($8)
$L489:
	lw	$9,144($sp)
	#nop
	andi	$2,$9,0x0010
	bne	$2,$0,$L490
	lw	$8,CarIO_carPixMapCount
	lw	$9,140($sp)
	sw	$8,76($sp)
	.set	noreorder
	.set	nomacro
	j	$L491
	sw	$8,2116($9)
	.set	macro
	.set	reorder

$L490:
	lw	$8,140($sp)
	#nop
	lw	$8,2116($8)
	#nop
	sw	$8,76($sp)
$L491:
	lw	$9,144($sp)
	#nop
	andi	$2,$9,0x0008
	beq	$2,$0,$L492
	lw	$8,140($sp)
	#nop
	lhu	$2,2240($8)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L523
	andi	$2,$23,0x003f
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L494
	addu	$20,$23,-512
	.set	macro
	.set	reorder

	addu	$20,$23,-640
$L494:
	lui	$2,%hi(CarIO_carVRamOffset) # high
	addiu	$2,$2,%lo(CarIO_carVRamOffset) # low
	sra	$3,$20,6
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	addu	$23,$23,$2
	andi	$2,$23,0x003f
$L523:
	lw	$9,140($sp)
	sll	$2,$2,2
	sh	$2,2248($9)
	andi	$2,$fp,0x00ff
	sh	$2,2250($9)
$L492:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L495
	move	$20,$0
	.set	macro
	.set	reorder

	li	$8,24			# 0x00000018
	sw	$8,80($sp)
$L495:
	lw	$9,140($sp)
	lw	$8,76($sp)
	lw	$2,2180($9)
	#nop
	sw	$2,Texture_palCopy
	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	sll	$17,$8,4
	.set	macro
	.set	reorder

	lui	$2,%hi(CarIO_textureName) # high
	addiu	$2,$2,%lo(CarIO_textureName) # low
	lui	$3,%hi(CarIO_licensePlate) # high
	addiu	$3,$3,%lo(CarIO_licensePlate) # low
	lw	$9,140($sp)
	lw	$8,72($sp)
	sll	$16,$16,2
	sw	$2,68($sp)
	sw	$16,88($sp)
	sll	$2,$8,1
	addu	$2,$2,$8
	sll	$2,$2,2
	addu	$18,$2,$3
	la	$2,CarIO_Plate1
	addu	$2,$16,$2
	sw	$9,84($sp)
	sw	$2,92($sp)
$L496:
	slt	$2,$20,51
	beq	$2,$0,$L497
	lw	$9,68($sp)
	lw	$4,136($sp)
	lw	$5,4($9)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$8,68($sp)
	#nop
	lw	$8,8($8)
	move	$19,$2
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L500
	sw	$8,64($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L524
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$9,68($sp)
	lw	$4,136($sp)
	lw	$5,0($9)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$16,$0
	.set	macro
	.set	reorder

	move	$19,$2
$L500:
	li	$2,20			# 0x00000014
$L524:
	bne	$20,$2,$L501
	sw	$0,80($sp)
$L501:
	beq	$19,$0,$L502
	lw	$8,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L503
	move	$4,$0
	.set	macro
	.set	reorder

	lhu	$2,Texture_palNum
	lw	$9,84($sp)
	#nop
	sh	$2,2186($9)
$L503:
	lw	$8,72($sp)
	#nop
	slt	$2,$8,22
	beq	$2,$0,$L504
	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L505
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	addu	$6,$sp,36
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,2($18)
	lh	$3,4($18)
	addu	$2,$23,$2
	addu	$3,$fp,$3
	sw	$2,32($sp)
	sw	$3,36($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$6,80($sp)
	lw	$7,32($sp)
	lw	$5,36($sp)
	lw	$3,CarIO_carPixMap
	lw	$9,92($sp)
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

	lw	$2,CarIO_carPixMap
	li	$4,1			# 0x00000001
	addu	$2,$17,$2
	.set	noreorder
	.set	nomacro
	j	$L504
	sh	$4,14($2)
	.set	macro
	.set	reorder

$L505:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L504
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	addu	$6,$sp,44
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,8($18)
	lh	$3,10($18)
	addu	$2,$23,$2
	addu	$3,$fp,$3
	sw	$2,40($sp)
	li	$2,1			# 0x00000001
	sw	$3,44($sp)
	.set	noreorder
	.set	nomacro
	jal	CarIO_LicenseCheck__FiPiT1P8Car_tObji
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$7,40($sp)
	lw	$5,44($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	la	$2,CarIO_Plate2
	lw	$6,80($sp)
	lw	$3,CarIO_carPixMap
	lw	$8,88($sp)
	addu	$3,$3,$17
	addu	$2,$8,$2
	sw	$5,16($sp)
	sw	$3,28($sp)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	lw	$3,CarIO_carPixMap
	li	$2,2			# 0x00000002
	addu	$3,$17,$3
	sh	$2,14($3)
$L504:
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L525
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$19
	move	$7,$23
	lw	$6,80($sp)
	lw	$3,CarIO_carPixMap
	li	$2,-1			# 0xffffffff
	sw	$fp,16($sp)
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
$L525:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L509
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,CarIO_carPixMap
	addu	$4,$17,6
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L509:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$17,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L502:
	beq	$16,$0,$L510
	lw	$9,64($sp)
	lw	$16,76($sp)
	beq	$9,$0,$L511
	lw	$8,80($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L512
	addu	$2,$9,-1
	.set	macro
	.set	reorder

	sll	$2,$2,1
	lw	$9,140($sp)
	lw	$8,84($sp)
	addu	$2,$9,$2
	lhu	$2,2186($2)
	#nop
	sh	$2,2186($8)
$L512:
	lw	$9,140($sp)
	#nop
	lw	$2,2116($9)
	lw	$8,64($sp)
	addu	$2,$2,-1
	addu	$16,$8,$2
$L511:
	lw	$9,68($sp)
	lw	$4,136($sp)
	lw	$5,0($9)
	jal	locateshapez
	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L510
	sll	$2,$16,4
	.set	macro
	.set	reorder

	lw	$3,CarIO_carPixMap
	move	$16,$0
	addu	$2,$2,$3
	lhu	$3,2($2)
	lw	$8,72($sp)
	andi	$2,$3,0x003f
	sll	$21,$2,4
	slt	$2,$8,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L514
	srl	$22,$3,6
	.set	macro
	.set	reorder

	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L515
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	addu	$6,$sp,52
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,2($18)
	lh	$3,4($18)
	addu	$2,$23,$2
	addu	$3,$fp,$3
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
	lw	$9,92($sp)
	move	$4,$16
	sw	$21,20($sp)
	sw	$22,24($sp)
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
	j	$L514
	sh	$16,14($2)
	.set	macro
	.set	reorder

$L515:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L514
	addu	$5,$sp,56
	.set	macro
	.set	reorder

	addu	$6,$sp,60
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,8($18)
	lh	$3,10($18)
	addu	$2,$23,$2
	addu	$3,$fp,$3
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
	lw	$8,88($sp)
	move	$4,$0
	sw	$21,20($sp)
	sw	$22,24($sp)
	addu	$2,$2,$17
	sw	$2,28($sp)
	la	$2,CarIO_Plate2
	addu	$2,$8,$2
	sw	$3,16($sp)
	lw	$5,0($2)
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
$L514:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L526
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$19
	li	$6,32			# 0x00000020
	lw	$2,CarIO_carPixMap
	move	$7,$23
	sw	$fp,16($sp)
	sw	$21,20($sp)
	sw	$22,24($sp)
	addu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L526:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L519
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,CarIO_carPixMap
	addu	$4,$17,6
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$2,$4
	.set	macro
	.set	reorder

$L519:
	lw	$9,64($sp)
	#nop
	bne	$9,$0,$L510
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$17,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L510:
	addu	$17,$17,16
	addu	$20,$20,1
	lw	$8,68($sp)
	lw	$9,76($sp)
	addu	$8,$8,12
	sw	$8,68($sp)
	lw	$8,84($sp)
	addu	$9,$9,1
	sw	$9,76($sp)
	addu	$8,$8,2
	.set	noreorder
	.set	nomacro
	j	$L496
	sw	$8,84($sp)
	.set	macro
	.set	reorder

$L497:
	lw	$9,144($sp)
	#nop
	andi	$2,$9,0x0080
	beq	$2,$0,$L481
	lw	$8,76($sp)
	#nop
	sw	$8,CarIO_carPixMapCount
$L481:
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
	li	$8,8			# 0x00000008
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
	sw	$8,48($sp)
	lw	$8,2116($5)
	lw	$2,R3DCar_InMenu
	sw	$8,44($sp)
	lh	$8,2236($5)
	#nop
	sw	$8,32($sp)
	lh	$8,2244($5)
	#nop
	sw	$8,36($sp)
	lh	$8,2246($5)
	move	$16,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L528
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	li	$8,24			# 0x00000018
	sw	$8,48($sp)
$L528:
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
	lui	$2,%hi(CarIO_textureName) # high
	addiu	$fp,$2,%lo(CarIO_textureName) # low
	lw	$8,108($sp)
	#nop
	sw	$8,60($sp)
$L529:
	slt	$2,$22,51
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L527
	li	$8,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$8,52($sp)
	lw	$5,4($fp)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
	lw	$23,8($fp)
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L558
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	bne	$23,$0,$L558
	sw	$0,52($sp)
	lw	$5,0($fp)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
	li	$2,20			# 0x00000014
$L558:
	bne	$22,$2,$L534
	sw	$0,48($sp)
$L534:
	beq	$17,$0,$L535
	lw	$2,CarIO_carPixMap
	#nop
	addu	$5,$2,$21
	lhu	$2,14($5)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L531
	move	$16,$0
	.set	macro
	.set	reorder

	lhu	$3,2($5)
	lw	$8,48($sp)
	andi	$2,$3,0x003f
	sll	$19,$2,4
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L537
	srl	$20,$3,6
	.set	macro
	.set	reorder

	lw	$8,60($sp)
	#nop
	lh	$2,2186($8)
	#nop
	sw	$2,Texture_palNum
$L537:
	lw	$8,32($sp)
	#nop
	slt	$2,$8,22
	beq	$2,$0,$L538
	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L539
	move	$4,$0
	.set	macro
	.set	reorder

	lh	$7,2($18)
	lh	$2,4($18)
	lw	$8,40($sp)
	lw	$6,48($sp)
	addu	$2,$8,$2
	lw	$8,56($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$5,28($sp)
	sw	$2,16($sp)
	la	$2,CarIO_Plate1
	.set	noreorder
	.set	nomacro
	j	$L556
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

$L539:
	lh	$2,6($18)
	#nop
	bne	$22,$2,$L538
	li	$16,1			# 0x00000001
	lh	$7,8($18)
	lh	$2,10($18)
	lw	$8,40($sp)
	lw	$6,48($sp)
	addu	$2,$8,$2
	lw	$8,56($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$5,28($sp)
	sw	$2,16($sp)
	la	$2,CarIO_Plate2
$L556:
	addu	$2,$8,$2
	lw	$8,36($sp)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	addu	$7,$8,$7
	.set	macro
	.set	reorder

$L538:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L559
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	lw	$6,48($sp)
	lw	$2,CarIO_carPixMap
	lw	$7,36($sp)
	lw	$8,40($sp)
	move	$5,$17
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
$L559:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L543
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

$L543:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L535:
	lw	$8,52($sp)
	#nop
	beq	$8,$0,$L531
	lw	$16,44($sp)
	beq	$23,$0,$L545
	lw	$8,48($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L546
	addu	$2,$23,-1
	.set	macro
	.set	reorder

	lw	$8,108($sp)
	sll	$2,$2,1
	addu	$2,$8,$2
	lhu	$2,2186($2)
	lw	$8,60($sp)
	#nop
	sh	$2,2186($8)
$L546:
	lw	$8,108($sp)
	#nop
	lw	$2,2116($8)
	#nop
	addu	$2,$2,-1
	addu	$16,$23,$2
$L545:
	lw	$5,0($fp)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L531
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
	beq	$2,$0,$L548
	srl	$20,$3,6
	.set	macro
	.set	reorder

	lh	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L549
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
	j	$L557
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

$L549:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L548
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
$L557:
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

$L548:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L560
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
$L560:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L553
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

$L553:
	bne	$23,$0,$L531
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L531:
	addu	$fp,$fp,12
	lw	$8,60($sp)
	addu	$22,$22,1
	addu	$8,$8,2
	sw	$8,60($sp)
	lw	$8,44($sp)
	addu	$21,$21,16
	addu	$8,$8,1
	.set	noreorder
	.set	nomacro
	j	$L529
	sw	$8,44($sp)
	.set	macro
	.set	reorder

$L527:
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
$L562:
	lw	$3,CarIO_carPixMap
	sll	$2,$17,4
	addu	$3,$2,$3
	lhu	$2,14($3)
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L565
	lh	$4,2($3)
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sh	$0,14($3)
	.set	macro
	.set	reorder

$L565:
	addu	$16,$16,1
	slt	$2,$16,51
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L562
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
