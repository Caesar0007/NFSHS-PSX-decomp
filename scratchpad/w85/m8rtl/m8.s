	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\cario__m8dump_29700.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	CarIO_carPixMap
	.sdata
	.align	2
CarIO_carPixMap:
	.word	0
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
	.globl	CarIO_carPixMapCount
	.sdata
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
	.globl	CarIO_Plate1
	.align	2
CarIO_Plate1:
	.space	8
	.globl	CarIO_Plate2
	.align	2
CarIO_Plate2:
	.space	8

	.extern	Texture_palNum, 4
	.extern	CarIO_licensePlate, 264
	.extern	D_8011E804, 612
	.extern	Texture_palCopy, 4
	.extern	CarIO_carVRamOffset, 12
	.extern	CarIO_carVRamSlotsMenu, 24
	.extern	CarIO_carVRamAdd, 12
	.extern	CarIO_carVRamSlots, 72
	.extern	CarIO_licenseSFX_Vram, 48
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
	bne	$2,$0,$L6
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
$L6:
	lw	$2,CarIO_carPixMap
	li	$3,611			# 0x00000263
	addu	$2,$2,9776
$L7:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L7
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
	beq	$4,$0,$L13
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L13:
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
$L16:
	sh	$0,14($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L16
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
	beq	$6,$0,$L55
	sra	$3,$24,2
	.set	macro
	.set	reorder

	addu	$8,$8,1
$L55:
	sll	$2,$9,1
	addu	$2,$2,$9
	sll	$2,$2,2
	addu	$3,$3,$2
	sll	$3,$3,1
	addu	$5,$5,$3
	li	$13,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L23
	move	$12,$13
	.set	macro
	.set	reorder

	move	$12,$0
$L23:
	addu	$6,$6,-1
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L56
	move	$15,$0
	.set	macro
	.set	reorder

$L25:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L25
	sll	$12,$12,4
	.set	macro
	.set	reorder

	move	$15,$0
$L56:
	andi	$6,$24,0x0003
	li	$9,-1			# 0xffffffff
$L29:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$9,$L30
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
	j	$L29
	or	$13,$2,$3
	.set	macro
	.set	reorder

$L30:
	andi	$3,$13,0xffff
	li	$2,65535			# 0x0000ffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L57
	li	$14,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$12,$13
	addu	$8,$8,1
$L57:
	addu	$25,$8,$14
$L34:
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	beq	$7,$14,$L58
	move	$10,$0
	.set	macro
	.set	reorder

	lhu	$8,0($4)
	addu	$4,$4,2
	andi	$6,$24,0x0003
$L38:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L39
	andi	$3,$8,0xf000
	.set	macro
	.set	reorder

	sll	$8,$8,4
	srl	$3,$3,12
	sll	$2,$10,4
	.set	noreorder
	.set	nomacro
	j	$L38
	or	$10,$2,$3
	.set	macro
	.set	reorder

$L39:
	li	$11,1			# 0x00000001
	lhu	$2,0($5)
	addu	$9,$5,2
	and	$2,$2,$15
	or	$2,$2,$8
	sh	$2,0($5)
$L42:
	slt	$2,$11,$25
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L43
	andi	$6,$24,0x0003
	.set	macro
	.set	reorder

	sh	$10,0($9)
	lhu	$8,0($4)
	addu	$4,$4,2
	move	$10,$0
$L45:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L46
	andi	$3,$8,0xf000
	.set	macro
	.set	reorder

	sll	$8,$8,4
	srl	$3,$3,12
	sll	$2,$10,4
	.set	noreorder
	.set	nomacro
	j	$L45
	or	$10,$2,$3
	.set	macro
	.set	reorder

$L46:
	lhu	$2,0($9)
	addu	$11,$11,1
	or	$2,$2,$8
	sh	$2,0($9)
	.set	noreorder
	.set	nomacro
	j	$L42
	addu	$9,$9,2
	.set	macro
	.set	reorder

$L43:
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
	bne	$3,$2,$L49
	addu	$6,$6,-1
	.set	macro
	.set	reorder

	lhu	$8,0($4)
	.set	noreorder
	.set	nomacro
	beq	$6,$14,$L51
	addu	$4,$4,2
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L52:
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L52
	sll	$8,$8,4
	.set	macro
	.set	reorder

$L51:
	sll	$3,$11,1
	addu	$3,$3,$5
	lhu	$2,0($3)
	#nop
	or	$2,$2,$8
	sh	$2,0($3)
$L49:
	.set	noreorder
	.set	nomacro
	j	$L34
	addu	$5,$5,24
	.set	macro
	.set	reorder

$L58:
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
$L60:
	addu	$11,$11,-1
	beq	$11,$12,$L75
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L64
	li	$7,5			# 0x00000005
	.set	macro
	.set	reorder

	move	$7,$0
	move	$3,$10
$L65:
	lhu	$2,0($3)
	addu	$3,$3,2
	addu	$7,$7,1
	sh	$2,0($8)
	slt	$2,$7,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	addu	$8,$8,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L60
	addu	$10,$10,24
	.set	macro
	.set	reorder

$L64:
	addu	$9,$10,10
$L70:
	.set	noreorder
	.set	nomacro
	bltz	$7,$L71
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
	j	$L70
	addu	$8,$8,2
	.set	macro
	.set	reorder

$L71:
 #APP
	
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L60
	addu	$10,$10,24
	.set	macro
	.set	reorder

$L75:
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
	bne	$5,$0,$L77
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
	j	$L76
	sw	$0,0($2)
	.set	macro
	.set	reorder

$L77:
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

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,528			# 0x00000210
	li	$6,16			# 0x00000010
	la	$3,CarIO_Plate2
	addu	$17,$17,$3
	move	$18,$0
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
$L79:
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
	bne	$2,$0,$L79
	sw	$5,0($3)
	.set	macro
	.set	reorder

	move	$18,$0
	move	$3,$20
	move	$5,$21
	move	$4,$8
$L83:
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$18,$18,1
	sw	$2,0($5)
	sw	$2,0($3)
	addu	$3,$3,4
	slt	$2,$18,12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L83
	addu	$5,$5,4
	.set	macro
	.set	reorder

	li	$12,65536			# 0x00010000
	ori	$12,$12,0x1800
	addu	$4,$7,16
	move	$5,$19
	li	$6,48			# 0x00000030
	sll	$8,$22,2
	la	$9,CarIO_Plate2
	addu	$9,$8,$9
	li	$7,22			# 0x00000016
	la	$2,CarIO_Plate1
	lw	$11,0($9)
	addu	$8,$8,$2
	lbu	$3,0($11)
	lw	$10,0($8)
	or	$3,$3,$12
	sw	$3,0($11)
	lbu	$2,0($10)
	move	$18,$0
	or	$2,$2,$12
	sw	$2,0($10)
	lw	$8,0($8)
	lw	$3,0($9)
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
	lui	$2,%hi($L103) # high
	addiu	$20,$2,%lo($L103) # low
$L87:
	slt	$2,$18,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L88
	addu	$2,$23,$18
	.set	macro
	.set	reorder

	lbu	$3,0($2)
	li	$2,32			# 0x00000020
	andi	$4,$3,0x00ff
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L91
	addu	$4,$4,-192
	.set	macro
	.set	reorder

	sltu	$2,$4,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L92
	sll	$2,$4,2
	.set	macro
	.set	reorder

	addu	$2,$2,$20
	lw	$2,0($2)
	#nop
	j	$2
	.rdata
	.align	3
$L103:
	.word	$L96
	.word	$L92
	.word	$L92
	.word	$L92
	.word	$L96
	.word	$L96
	.word	$L92
	.word	$L92
	.word	$L97
	.word	$L92
	.word	$L92
	.word	$L92
	.word	$L98
	.word	$L92
	.word	$L92
	.word	$L92
	.word	$L92
	.word	$L93
	.word	$L100
	.word	$L92
	.word	$L92
	.word	$L92
	.word	$L100
	.word	$L92
	.word	$L92
	.word	$L102
	.word	$L92
	.word	$L92
	.word	$L102
	.text
$L93:
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$3,110			# 0x0000006e
	.set	macro
	.set	reorder

$L96:
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$3,97			# 0x00000061
	.set	macro
	.set	reorder

$L97:
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$3,101			# 0x00000065
	.set	macro
	.set	reorder

$L98:
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$3,105			# 0x00000069
	.set	macro
	.set	reorder

$L100:
	.set	noreorder
	.set	nomacro
	j	$L92
	li	$3,111			# 0x0000006f
	.set	macro
	.set	reorder

$L102:
	li	$3,117			# 0x00000075
$L92:
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

$L91:
	addu	$16,$16,6
	.set	noreorder
	.set	nomacro
	j	$L87
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L88:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L109
	move	$4,$19
	.set	macro
	.set	reorder

	lui	$2,%hi(GameSetup_gData+44) # high
	lw	$2,%lo(GameSetup_gData+44)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L109
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
	j	$L108
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L109:
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
$L108:
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

$L76:
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
	beq	$4,$0,$L111
	jal	purgememadr
$L111:
	la	$2,CarIO_Plate2
	sw	$0,0($16)
	addu	$16,$17,$2
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L112
	jal	purgememadr
$L112:
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
	beq	$4,$0,$L115
	move	$9,$6
	.set	macro
	.set	reorder

	lw	$4,CarIO_licenseSFX_Count
	#nop
	slt	$2,$4,12
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L117
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
$L115:
	addu	$2,$7,$3
$L117:
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
	li	$9,8			# 0x00000008
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
	sw	$9,72($sp)
	lh	$10,2236($5)
	andi	$2,$6,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L119
	sw	$10,64($sp)
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L120
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
	lw	$9,140($sp)
	sll	$2,$3,16
	sra	$23,$2,16
	slt	$2,$10,28
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L121
	sh	$3,2246($9)
	.set	macro
	.set	reorder

	lhu	$2,2240($9)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L122
	li	$2,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	ori	$2,$2,0x5556
	mult	$4,$2
	sra	$2,$4,31
	lui	$3,%hi(CarIO_carVRamAdd) # high
	addiu	$3,$3,%lo(CarIO_carVRamAdd) # low
	mfhi	$9
	#nop
	#nop
	subu	$2,$9,$2
	sll	$2,$2,1
	addu	$2,$2,$3
	lh	$3,0($2)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	addu	$2,$4,$2
	sw	$2,CarIO_carVRamCount
	j	$L126
$L122:
	addu	$2,$4,3
	sw	$2,CarIO_carVRamCount
	j	$L126
$L121:
	addu	$2,$4,1
	sw	$2,CarIO_carVRamCount
	j	$L126
$L120:
	addiu	$2,$2,%lo(CarIO_carVRamSlotsMenu) # low
	lw	$5,CarIO_carVRamCount
	lw	$10,140($sp)
	sll	$3,$5,2
	addu	$3,$3,$2
	lhu	$2,0($3)
	#nop
	sh	$2,2244($10)
	sll	$2,$2,16
	sra	$22,$2,16
	lhu	$4,2($3)
	lui	$3,%hi(CarIO_carVRamAdd) # high
	addiu	$3,$3,%lo(CarIO_carVRamAdd) # low
	sll	$2,$5,1
	addu	$2,$2,$3
	sh	$4,2246($10)
	sll	$4,$4,16
	lh	$2,0($2)
	#nop
	addu	$5,$5,$2
	sw	$5,CarIO_carVRamCount
	.set	noreorder
	.set	nomacro
	j	$L126
	sra	$23,$4,16
	.set	macro
	.set	reorder

$L119:
	lw	$9,140($sp)
	#nop
	lh	$22,2244($9)
	lh	$23,2246($9)
$L126:
	lw	$10,144($sp)
	#nop
	andi	$2,$10,0x0010
	bne	$2,$0,$L127
	lw	$2,CarIO_carPixMapCount
	lw	$9,140($sp)
	sw	$2,68($sp)
	.set	noreorder
	.set	nomacro
	j	$L128
	sw	$2,2116($9)
	.set	macro
	.set	reorder

$L127:
	lw	$10,140($sp)
	#nop
	lw	$10,2116($10)
	#nop
	sw	$10,68($sp)
$L128:
	lw	$9,144($sp)
	#nop
	andi	$2,$9,0x0008
	beq	$2,$0,$L129
	lw	$10,140($sp)
	#nop
	lhu	$2,2240($10)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L161
	andi	$2,$22,0x003f
	.set	macro
	.set	reorder

	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L131
	addu	$3,$22,-512
	.set	macro
	.set	reorder

	addu	$3,$22,-640
$L131:
	sra	$3,$3,6
	lui	$2,%hi(CarIO_carVRamOffset) # high
	addiu	$2,$2,%lo(CarIO_carVRamOffset) # low
	sll	$3,$3,1
	addu	$3,$3,$2
	lh	$2,0($3)
	#nop
	addu	$22,$22,$2
	andi	$2,$22,0x003f
$L161:
	lw	$9,140($sp)
	sll	$2,$2,2
	sh	$2,2248($9)
	andi	$2,$23,0x00ff
	sh	$2,2250($9)
$L129:
	lw	$2,R3DCar_InMenu
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L132
	move	$20,$0
	.set	macro
	.set	reorder

	lw	$10,72($sp)
	#nop
	ori	$10,$10,0x0010
	sw	$10,72($sp)
$L132:
	lw	$9,140($sp)
	lw	$10,68($sp)
	lw	$2,2180($9)
	#nop
	sw	$2,Texture_palCopy
	.set	noreorder
	.set	nomacro
	jal	Texture_ResetPaletteSharing__Fv
	sll	$18,$10,4
	.set	macro
	.set	reorder

	sll	$3,$16,2
	la	$2,CarIO_Plate1
	addu	$2,$3,$2
	sw	$2,80($sp)
	la	$2,CarIO_Plate2
	addu	$3,$3,$2
	lui	$2,%hi(D_8011E804) # high
	lw	$9,140($sp)
	addiu	$fp,$2,%lo(D_8011E804) # low
	sw	$3,84($sp)
$L160:
	slt	$2,$20,51
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L134
	sw	$9,88($sp)
	.set	macro
	.set	reorder

	lw	$4,136($sp)
	lw	$5,4($fp)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	li	$17,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$10,8($fp)
	move	$19,$2
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L137
	sw	$10,76($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$10,$0,$L162
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	lw	$5,0($fp)
	lw	$4,136($sp)
	.set	noreorder
	.set	nomacro
	jal	locateshapez
	move	$17,$0
	.set	macro
	.set	reorder

	move	$19,$2
$L137:
	li	$2,20			# 0x00000014
$L162:
	bne	$20,$2,$L138
	sw	$0,72($sp)
$L138:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L139
	lui	$10,%hi(CarIO_licensePlate) # high
	.set	macro
	.set	reorder

	lw	$9,64($sp)
	addiu	$10,$10,%lo(CarIO_licensePlate) # low
	sll	$2,$9,1
	addu	$2,$2,$9
	sll	$2,$2,2
	addu	$3,$2,$10
	lw	$9,72($sp)
	lhu	$4,0($3)
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L140
	move	$16,$0
	.set	macro
	.set	reorder

	lhu	$2,Texture_palNum
	lw	$10,88($sp)
	#nop
	sh	$2,2186($10)
$L140:
	lw	$9,64($sp)
	#nop
	slt	$2,$9,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L141
	sll	$2,$4,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	bltz	$2,$L141
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L142
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
	lw	$10,80($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,$18
	sw	$5,16($sp)
	sw	$3,28($sp)
	lw	$5,0($10)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,CarIO_carPixMap
	li	$16,1			# 0x00000001
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	j	$L141
	sh	$16,14($2)
	.set	macro
	.set	reorder

$L142:
	lh	$2,6($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L141
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
	addu	$3,$3,$18
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
	addu	$3,$18,$3
	sh	$2,14($3)
$L141:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L163
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$19
	move	$7,$22
	lw	$6,72($sp)
	lw	$3,CarIO_carPixMap
	li	$2,-1			# 0xffffffff
	sw	$23,16($sp)
	sw	$2,20($sp)
	sw	$2,24($sp)
	addu	$3,$3,$18
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$3,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L163:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L146
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$18
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L146:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$18,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L139:
	beq	$17,$0,$L135
	lw	$10,76($sp)
	lw	$16,68($sp)
	beq	$10,$0,$L148
	lw	$9,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L149
	addu	$16,$10,-1
	.set	macro
	.set	reorder

	sll	$2,$16,1
	lw	$10,140($sp)
	lw	$9,88($sp)
	addu	$2,$10,$2
	lhu	$2,2186($2)
	#nop
	sh	$2,2186($9)
$L149:
	lw	$10,140($sp)
	#nop
	lw	$2,2116($10)
	#nop
	addu	$16,$16,$2
$L148:
	lw	$5,0($fp)
	lw	$4,136($sp)
	jal	locateshapez
	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L135
	move	$17,$0
	.set	macro
	.set	reorder

	sll	$3,$16,4
	lui	$10,%hi(CarIO_licensePlate) # high
	addiu	$10,$10,%lo(CarIO_licensePlate) # low
	lw	$2,CarIO_carPixMap
	lw	$9,64($sp)
	addu	$3,$3,$2
	sll	$2,$9,1
	addu	$2,$2,$9
	sll	$2,$2,2
	addu	$8,$2,$10
	lhu	$3,2($3)
	lhu	$4,0($8)
	andi	$2,$3,0x003f
	sll	$16,$2,4
	slt	$2,$9,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L151
	srl	$21,$3,6
	.set	macro
	.set	reorder

	sll	$2,$4,16
	sra	$2,$2,16
	bltz	$2,$L151
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L152
	addu	$5,$sp,48
	.set	macro
	.set	reorder

	addu	$6,$sp,52
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,2($8)
	lh	$3,4($8)
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
	move	$4,$17
	sw	$16,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$18
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
	li	$17,1			# 0x00000001
	addu	$2,$18,$2
	.set	noreorder
	.set	nomacro
	j	$L151
	sh	$17,14($2)
	.set	macro
	.set	reorder

$L152:
	lh	$2,6($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L151
	addu	$5,$sp,56
	.set	macro
	.set	reorder

	addu	$6,$sp,60
	lw	$4,144($sp)
	lw	$7,140($sp)
	lh	$2,8($8)
	lh	$3,10($8)
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
	lw	$10,84($sp)
	move	$4,$0
	sw	$16,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$18
	sw	$3,16($sp)
	sw	$2,28($sp)
	lw	$5,0($10)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
	lw	$3,CarIO_carPixMap
	li	$2,2			# 0x00000002
	addu	$3,$18,$3
	sh	$2,14($3)
$L151:
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L164
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$19
	li	$6,32			# 0x00000020
	lw	$2,CarIO_carPixMap
	move	$7,$22
	sw	$23,16($sp)
	sw	$16,20($sp)
	sw	$21,24($sp)
	addu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	li	$2,32			# 0x00000020
$L164:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L156
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$4,CarIO_carPixMap
	#nop
	addu	$4,$4,$18
	.set	noreorder
	.set	nomacro
	jal	ChangeTPage__FPUsi
	addu	$4,$4,6
	.set	macro
	.set	reorder

$L156:
	lw	$9,76($sp)
	#nop
	bne	$9,$0,$L135
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$18,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L135:
	addu	$18,$18,16
	addu	$fp,$fp,12
	addu	$20,$20,1
	lw	$10,68($sp)
	lw	$9,88($sp)
	addu	$10,$10,1
	addu	$9,$9,2
	.set	noreorder
	.set	nomacro
	j	$L160
	sw	$10,68($sp)
	.set	macro
	.set	reorder

$L134:
	lw	$10,144($sp)
	#nop
	andi	$2,$10,0x0080
	beq	$2,$0,$L118
	lw	$9,68($sp)
	#nop
	sw	$9,CarIO_carPixMapCount
$L118:
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
	bne	$2,$0,$L166
	sw	$8,40($sp)
	.set	macro
	.set	reorder

	li	$fp,24			# 0x00000018
$L166:
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
$L196:
	slt	$2,$22,51
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L165
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
	bne	$17,$0,$L171
	sw	$8,48($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$8,$0,$L197
	li	$2,20			# 0x00000014
	.set	macro
	.set	reorder

	sw	$0,52($sp)
	lw	$5,0($23)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
$L171:
	li	$2,20			# 0x00000014
$L197:
	bne	$22,$2,$L172
	move	$fp,$0
$L172:
	beq	$17,$0,$L173
	lw	$2,CarIO_carPixMap
	#nop
	addu	$5,$21,$2
	lhu	$2,14($5)
	#nop
	andi	$2,$2,0x0080
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L169
	move	$16,$0
	.set	macro
	.set	reorder

	lhu	$3,2($5)
	#nop
	andi	$2,$3,0x003f
	srl	$20,$3,6
	lhu	$3,0($18)
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L175
	sll	$19,$2,4
	.set	macro
	.set	reorder

	lw	$8,60($sp)
	#nop
	lh	$2,2186($8)
	#nop
	sw	$2,Texture_palNum
$L175:
	lw	$8,32($sp)
	#nop
	slt	$2,$8,22
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L176
	sll	$2,$3,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	bltz	$2,$L176
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L177
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
	j	$L194
	move	$6,$fp
	.set	macro
	.set	reorder

$L177:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L176
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
$L194:
	addu	$2,$8,$2
	lw	$8,36($sp)
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
	addu	$7,$8,$7
	.set	macro
	.set	reorder

$L176:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L198
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
$L198:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L181
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

$L181:
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L173:
	lw	$8,52($sp)
	#nop
	beq	$8,$0,$L169
	lw	$8,48($sp)
	lw	$16,44($sp)
	beq	$8,$0,$L183
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L184
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
$L184:
	lw	$8,108($sp)
	#nop
	lw	$2,2116($8)
	#nop
	addu	$16,$16,$2
$L183:
	lw	$5,0($23)
	lw	$4,104($sp)
	jal	locateshapez
	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L169
	sll	$2,$16,4
	.set	macro
	.set	reorder

	lw	$5,CarIO_carPixMap
	#nop
	addu	$2,$2,$5
	lhu	$3,2($2)
	lw	$8,32($sp)
	andi	$2,$3,0x003f
	sll	$19,$2,4
	srl	$20,$3,6
	slt	$2,$8,22
	lhu	$3,0($18)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L186
	move	$16,$0
	.set	macro
	.set	reorder

	sll	$2,$3,16
	sra	$2,$2,16
	bltz	$2,$L186
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L187
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
	j	$L195
	li	$6,32			# 0x00000020
	.set	macro
	.set	reorder

$L187:
	lh	$2,6($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L186
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
$L195:
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

$L186:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L199
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
$L199:
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L191
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

$L191:
	lw	$8,48($sp)
	#nop
	bne	$8,$0,$L169
	lw	$3,CarIO_carPixMap
	#nop
	addu	$3,$21,$3
	lhu	$2,14($3)
	#nop
	ori	$2,$2,0x0080
	sh	$2,14($3)
$L169:
	addu	$21,$21,16
	lw	$8,44($sp)
	addu	$23,$23,12
	addu	$8,$8,1
	sw	$8,44($sp)
	lw	$8,60($sp)
	addu	$22,$22,1
	.set	noreorder
	.set	nomacro
	j	$L196
	addu	$8,$8,2
	.set	macro
	.set	reorder

$L165:
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
$L201:
	lw	$3,CarIO_carPixMap
	sll	$2,$17,4
	addu	$3,$2,$3
	lhu	$2,14($3)
	#nop
	andi	$2,$2,0x0080
	beq	$2,$0,$L204
	lh	$4,2($3)
	.set	noreorder
	.set	nomacro
	jal	Texture_MenuReleaseClutId__Fs
	sh	$0,14($3)
	.set	macro
	.set	reorder

$L204:
	addu	$16,$16,1
	slt	$2,$16,51
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L201
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
