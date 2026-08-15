	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\trackspec.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	TrackSpec_SetDefault__FP10CTrackSpec
	.align	2
	.globl	TrackSpec_SetUp__Fv
	.align	2
	.globl	read__FPPcPvi
	.rdata
	.align	2
$LC0:
	.ascii	"%sTr%02d.bin\000"
	.text
	.align	2
	.globl	TrackSpec_Read__Fi
	.rdata
	.align	2
$LC1:
	.word	0
	.word	1
	.word	2
	.word	3
	.text
	.align	2
	.globl	TrackSpec_Load__Fii
	.globl	TrackSpec_gPrevSpec
	.sdata
	.align	2
TrackSpec_gPrevSpec:
	.space	4
	.globl	TrackSpec_gCurrentSpec
	.align	2
TrackSpec_gCurrentSpec:
	.space	4
	.globl	TrackSpec_gMaxSpec
	.align	2
TrackSpec_gMaxSpec:
	.space	4

	.extern	Paths_Paths, 200
	.extern	TrackSpec_gSpec, 264
	.extern	GameSetup_gData, 2600

	.text
	.text
	.ent	TrackSpec_SetDefault__FP10CTrackSpec
TrackSpec_SetDefault__FP10CTrackSpec:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$4
	move	$6,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	li	$3,1			# 0x00000001
	sh	$0,0($5)
	lhu	$4,72($2)
	li	$7,23			# 0x00000017
	sh	$3,4($5)
	sh	$3,6($5)
	sh	$4,2($5)
	lhu	$4,84($2)
	li	$2,65536			# 0x00010000
	sw	$2,16($5)
	li	$2,128			# 0x00000080
	sh	$3,10($5)
	li	$3,200			# 0x000000c8
	sw	$3,24($5)
	li	$3,8			# 0x00000008
	sw	$3,28($5)
	li	$3,2			# 0x00000002
	sw	$3,36($5)
	li	$3,1			# 0x00000001
	sw	$3,40($5)
	li	$3,-4224			# 0xffffef80
	sw	$3,48($5)
	li	$3,19200			# 0x00004b00
	sb	$2,20($5)
	sb	$2,21($5)
	sb	$2,22($5)
	sw	$0,32($5)
	sw	$0,44($5)
	sw	$3,52($5)
	sb	$2,56($5)
	sb	$2,57($5)
	sb	$2,58($5)
	sb	$2,60($5)
	sb	$2,61($5)
	sb	$2,62($5)
	sb	$2,64($5)
	sb	$2,65($5)
	sb	$2,66($5)
	sb	$2,68($5)
	sb	$2,69($5)
	sb	$2,70($5)
	sh	$4,8($5)
	slt	$2,$6,8
$L618:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L605
	addu	$3,$5,$6
	.set	macro
	.set	reorder

	subu	$2,$7,$6
	.set	noreorder
	.set	nomacro
	j	$L603
	sb	$2,72($3)
	.set	macro
	.set	reorder

$L605:
	sb	$6,72($3)
$L603:
	addu	$6,$6,1
	slt	$2,$6,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L618
	slt	$2,$6,8
	.set	macro
	.set	reorder

	move	$6,$0
	li	$8,50			# 0x00000032
	li	$9,70			# 0x00000046
	move	$4,$5
	move	$7,$6
	li	$2,4			# 0x00000004
	sw	$0,88($5)
	sw	$2,92($5)
$L611:
	move	$3,$0
	sb	$8,96($4)
	sb	$8,97($4)
	sb	$9,98($4)
	sb	$8,116($4)
	sb	$8,117($4)
	sb	$9,118($4)
	addu	$2,$3,$7
$L619:
	addu	$2,$5,$2
	sb	$0,196($2)
	addu	$3,$3,1
	slt	$2,$3,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	addu	$2,$3,$7
	.set	macro
	.set	reorder

	sll	$2,$6,12
	sw	$2,216($4)
	addu	$4,$4,4
	addu	$6,$6,1
	slt	$2,$6,5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L611
	addu	$7,$7,4
	.set	macro
	.set	reorder

	li	$4,8			# 0x00000008
	li	$3,16			# 0x00000010
	li	$2,-6216			# 0xffffe7b8
	sw	$2,140($5)
	li	$2,238			# 0x000000ee
	sw	$2,144($5)
	sw	$2,152($5)
	li	$2,60			# 0x0000003c
	sw	$2,156($5)
	li	$2,4000			# 0x00000fa0
	sw	$2,160($5)
	li	$2,10000			# 0x00002710
	sw	$2,164($5)
	li	$2,64			# 0x00000040
	sw	$2,168($5)
	li	$2,200			# 0x000000c8
	sw	$2,172($5)
	li	$2,255			# 0x000000ff
	sb	$2,176($5)
	sb	$2,177($5)
	sb	$2,178($5)
	li	$2,12345			# 0x00003039
	sw	$2,180($5)
	li	$2,33			# 0x00000021
	sb	$2,184($5)
	sb	$2,185($5)
	li	$2,25			# 0x00000019
	sb	$2,188($5)
	li	$2,10			# 0x0000000a
	sb	$3,137($5)
	sb	$3,186($5)
	sb	$3,237($5)
	sb	$3,238($5)
	li	$3,128			# 0x00000080
	sb	$2,189($5)
	li	$2,68			# 0x00000044
	sw	$2,244($5)
	li	$2,19660			# 0x00004ccc
	sb	$4,136($5)
	sb	$4,138($5)
	sw	$0,148($5)
	sb	$0,190($5)
	sw	$0,192($5)
	sb	$4,236($5)
	sb	$3,240($5)
	sb	$3,241($5)
	sb	$3,242($5)
	sh	$0,256($5)
	sh	$0,258($5)
	sh	$0,260($5)
	sh	$0,262($5)
	sw	$2,248($5)
	sb	$3,252($5)
	sb	$3,253($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$3,254($5)
	.set	macro
	.set	reorder

	.end	TrackSpec_SetDefault__FP10CTrackSpec
	.text
	.ent	TrackSpec_SetUp__Fv
TrackSpec_SetUp__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(GameSetup_gData) # high
	lui	$2,%hi(TrackSpec_gSpec) # high
	addiu	$2,$2,%lo(TrackSpec_gSpec) # low
	lh	$4,8($2)
	lh	$2,2($2)
	addiu	$3,$3,%lo(GameSetup_gData) # low
	sw	$4,84($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,72($3)
	.set	macro
	.set	reorder

	.end	TrackSpec_SetUp__Fv
	.text
	.ent	read__FPPcPvi
read__FPPcPvi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$7,0($4)
	.set	noreorder
	.set	nomacro
	blez	$6,$L622
	move	$3,$0
	.set	macro
	.set	reorder

$L623:
	lbu	$2,0($7)
	addu	$7,$7,1
	addu	$3,$3,1
	sb	$2,0($5)
	slt	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L623
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L622:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$7,0($4)
	.set	macro
	.set	reorder

	.end	read__FPPcPvi
	.text
	.ent	TrackSpec_Read__Fi
TrackSpec_Read__Fi:
	.frame	$sp,120,$31		# vars= 80, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	sw	$18,104($sp)
	move	$18,$4
	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+24) # high
	lw	$6,%lo(Paths_Paths+24)($2)
	lui	$2,%hi(GameSetup_gData+60) # high
	lui	$5,%hi($LC0) # high
	lw	$7,%lo(GameSetup_gData+60)($2)
	addiu	$5,$5,%lo($LC0) # low
	sw	$31,112($sp)
	sw	$19,108($sp)
	sw	$17,100($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	move	$5,$0
	.set	macro
	.set	reorder

	move	$16,$2
	move	$19,$16
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L627
	sw	$2,88($sp)
	.set	macro
	.set	reorder

	addu	$17,$sp,88
	move	$4,$17
	addu	$5,$sp,80
	sw	$18,TrackSpec_gPrevSpec
	sw	$18,TrackSpec_gCurrentSpec
	.set	noreorder
	.set	nomacro
	jal	read__FPPcPvi
	li	$6,8			# 0x00000008
	.set	macro
	.set	reorder

	lw	$3,84($sp)
	#nop
	slt	$2,$18,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L629
	lui	$5,%hi(TrackSpec_gSpec) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(TrackSpec_gSpec) # high
	.set	noreorder
	.set	nomacro
	jal	TrackSpec_SetDefault__FP10CTrackSpec
	addiu	$4,$4,%lo(TrackSpec_gSpec) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L631
	move	$4,$16
	.set	macro
	.set	reorder

$L629:
	move	$4,$17
	addiu	$5,$5,%lo(TrackSpec_gSpec) # low
	li	$6,264			# 0x00000108
	addu	$2,$3,1
	sw	$2,TrackSpec_gMaxSpec
	sll	$2,$18,5
	addu	$2,$2,$18
	lw	$3,88($sp)
	sll	$2,$2,3
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	jal	read__FPPcPvi
	sw	$3,88($sp)
	.set	macro
	.set	reorder

	jal	TrackSpec_SetUp__Fv
	move	$4,$19
$L631:
	jal	purgememadr
$L627:
	lw	$31,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	TrackSpec_Read__Fi
	.text
	.ent	TrackSpec_Load__Fii
TrackSpec_Load__Fii:
	.frame	$sp,40,$31		# vars= 16, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi($LC1) # high
	sll	$5,$5,2
	sll	$4,$4,3
	addu	$5,$5,$4
	sw	$31,32($sp)
	addiu	$8,$2,%lo($LC1)
	lw	$3,0($8)
	lw	$6,4($8)
	lw	$7,8($8)
	sw	$3,16($sp)
	sw	$6,20($sp)
	sw	$7,24($sp)
	lw	$3,12($8)
	sw	$3,28($sp)
	addu	$2,$sp,$5
	lw	$4,16($2)
	jal	TrackSpec_Read__Fi
	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	TrackSpec_Load__Fii
