	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screentrackrecords.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"zRec\000"
	.text
	.align	2
	.globl	GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3
	.ent	GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3
GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,16($sp)
	li	$2,40			# 0x00000028
	sh	$2,0($5)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	sh	$0,0($6)
	sw	$2,0($7)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($3)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3
	.rdata
	.align	2
$LC1:
	.ascii	"trkrcrds\000"
	.text
	.align	2
	.globl	Initialize__19tScreenTrackRecords
	.ent	Initialize__19tScreenTrackRecords
Initialize__19tScreenTrackRecords:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$0,108($16)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,360			# 0x00000168
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_GetTrackRaced__Fv
	sw	$2,100($16)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lw	$5,100($16)
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	sra	$4,$2,16
	.set	macro
	.set	reorder

	sw	$0,112($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Initialize__19tScreenTrackRecords
	.align	2
	.globl	Cleanup__19tScreenTrackRecords
	.ent	Cleanup__19tScreenTrackRecords
Cleanup__19tScreenTrackRecords:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,100($16)
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	jal	StatChk_ClearNewRecords__Fv
	sw	$0,100($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	move	$4,$16
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

	.end	Cleanup__19tScreenTrackRecords
	.align	2
	.globl	DrawOneRecord__19tScreenTrackRecordsibi
	.ent	DrawOneRecord__19tScreenTrackRecordsibi
DrawOneRecord__19tScreenTrackRecordsibi:
	.frame	$sp,144,$31		# vars= 80, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$20,128($sp)
	move	$20,$4
	sw	$18,120($sp)
	move	$18,$5
	sw	$22,136($sp)
	move	$22,$6
	sw	$21,132($sp)
	move	$21,$7
	sltu	$4,$0,$22
	sll	$2,$18,2
	addu	$2,$2,$18
	sw	$31,140($sp)
	sw	$19,124($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	lw	$3,100($20)
	sll	$16,$2,2
	addu	$3,$16,$3
	lw	$2,16($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L603
	sll	$19,$4,1
	.set	macro
	.set	reorder

	beq	$22,$0,$L607
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,583			# 0x00000247
	.set	macro
	.set	reorder

	li	$3,1431633920			# 0x55550000
	lw	$6,104($20)
	ori	$3,$3,0x5556
	sll	$7,$6,1
	mult	$7,$3
	addu	$4,$2,3
	addu	$5,$21,4
	li	$2,23			# 0x00000017
	sw	$2,16($sp)
	srl	$2,$6,31
	addu	$6,$6,$2
	sra	$6,$6,1
	sra	$7,$7,31
	mfhi	$8
	#nop
	.set	noreorder
	.set	nomacro
	jal	Flare_2DHalo__Fiiiii
	subu	$7,$8,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,583			# 0x00000247
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$4
	move	$6,$2
	move	$7,$21
	sw	$0,16($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$0,24($sp)
	.set	macro
	.set	reorder

$L607:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,587			# 0x0000024b
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lw	$3,100($20)
	sra	$5,$2,16
	sll	$2,$21,16
	sra	$6,$2,16
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L608
	addu	$4,$3,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L617
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L608:
	li	$2,1			# 0x00000001
$L617:
	sw	$2,16($sp)
	li	$7,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	sll	$16,$18,2
	addu	$16,$16,$18
	lw	$2,100($20)
	sll	$16,$16,2
	addu	$2,$16,$2
	lw	$4,8($2)
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$4,339
	.set	macro
	.set	reorder

	li	$4,588			# 0x0000024c
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$2,$2,16
	sra	$5,$2,16
	sll	$6,$21,16
	sra	$6,$6,16
	li	$7,11			# 0x0000000b
	sw	$19,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$2,100($20)
	#nop
	addu	$16,$16,$2
	lw	$4,12($16)
	#nop
	beq	$4,$0,$L610
	.set	noreorder
	.set	nomacro
	jal	Stattool_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	j	$L611
$L610:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,609			# 0x00000261
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

$L611:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,589			# 0x0000024d
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$5,$2,16
	sll	$2,$21,16
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L612
	sra	$6,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L618
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

$L612:
	sltu	$2,$0,$18
$L618:
	sw	$2,16($sp)
	addu	$4,$sp,32
	li	$7,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	sll	$2,$18,2
	addu	$2,$2,$18
	lw	$3,100($20)
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,16($2)
	.set	noreorder
	.set	nomacro
	jal	Stattool_ParseTime__FiPc
	addu	$5,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,590			# 0x0000024e
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$5,$2,16
	sll	$2,$21,16
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L616
	sra	$6,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L614
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L616:
	.set	noreorder
	.set	nomacro
	j	$L615
	sw	$19,16($sp)
	.set	macro
	.set	reorder

$L614:
	sw	$2,16($sp)
$L615:
	sw	$0,20($sp)
	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	li	$7,11			# 0x0000000b
	.set	macro
	.set	reorder

$L603:
	lw	$31,140($sp)
	lw	$22,136($sp)
	lw	$21,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	DrawOneRecord__19tScreenTrackRecordsibi
	.align	2
	.globl	DrawRecords__19tScreenTrackRecordss
	.ent	DrawRecords__19tScreenTrackRecordss
DrawRecords__19tScreenTrackRecordss:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,40($sp)
	move	$20,$4
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lw	$2,108($20)
	#nop
	addu	$2,$2,1
	sw	$2,108($20)
	slt	$2,$2,61
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L620
	move	$fp,$5
	.set	macro
	.set	reorder

	sw	$0,108($20)
$L620:
	lw	$3,108($20)
	#nop
	slt	$2,$3,31
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	srl	$2,$3,31
	.set	macro
	.set	reorder

	li	$2,60			# 0x0000003c
	subu	$2,$2,$3
	srl	$3,$2,31
$L621:
	addu	$2,$3,$2
	sra	$2,$2,1
	sw	$2,104($20)
	#.set	volatile
	lw	$2,104($20)
	#.set	novolatile
	#nop
	addu	$2,$2,20
	sll	$2,$2,7
	.set	noreorder
	.set	nomacro
	jal	Front_GetLapsForType__Fv
	sw	$2,104($20)
	.set	macro
	.set	reorder

	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L623
	li	$4,9			# 0x00000009
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
$L623:
	move	$18,$0
	sll	$2,$fp,16
	sra	$23,$2,16
	lui	$2,%hi(NewRecords) # high
	addiu	$21,$2,%lo(NewRecords) # low
	move	$22,$4
	sll	$2,$18,16
$L635:
	sra	$17,$2,16
	slt	$2,$17,$23
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L626
	addu	$16,$17,599
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,585			# 0x00000249
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$19,$2
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$2,16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sll	$3,$17,2
	addu	$3,$3,$21
	lw	$3,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L630
	sra	$6,$2,16
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L631
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L630:
	sw	$0,16($sp)
$L631:
	move	$4,$19
	move	$5,$16
	li	$7,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	sll	$16,$18,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$4,$16,599
	.set	macro
	.set	reorder

	move	$4,$20
	addu	$5,$16,$22
	sll	$16,$16,2
	addu	$16,$16,$21
	lw	$6,0($16)
	.set	noreorder
	.set	nomacro
	jal	DrawOneRecord__19tScreenTrackRecordsibi
	move	$7,$2
	.set	macro
	.set	reorder

	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	sll	$2,$18,16
	.set	macro
	.set	reorder

$L626:
	sll	$2,$fp,16
	sra	$2,$2,16
	slt	$2,$2,9
	bne	$2,$0,$L619
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,608			# 0x00000260
	.set	macro
	.set	reorder

	move	$4,$20
	move	$5,$0
	lui	$3,%hi(NewBestLap) # high
	lw	$6,%lo(NewBestLap)($3)
	.set	noreorder
	.set	nomacro
	jal	DrawOneRecord__19tScreenTrackRecordsibi
	move	$7,$2
	.set	macro
	.set	reorder

$L619:
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

	.end	DrawRecords__19tScreenTrackRecordss
	.rdata
	.align	2
$LC2:
	.ascii	"%s %s\000"
	.text
	.align	2
	.globl	DrawBackground__19tScreenTrackRecords
	.ent	DrawBackground__19tScreenTrackRecords
DrawBackground__19tScreenTrackRecords:
	.frame	$sp,264,$31		# vars= 192, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,264
	sw	$31,260($sp)
	sw	$fp,256($sp)
	sw	$23,252($sp)
	sw	$22,248($sp)
	sw	$21,244($sp)
	sw	$20,240($sp)
	sw	$19,236($sp)
	sw	$18,232($sp)
	sw	$17,228($sp)
	sw	$16,224($sp)
	sw	$4,264($sp)
	lh	$3,92($4)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	bgez	$2,$L654
	sra	$3,$2,7
	.set	macro
	.set	reorder

	addu	$2,$2,127
	sra	$3,$2,7
$L654:
	addu	$18,$3,-180
	.set	noreorder
	.set	nomacro
	bgez	$18,$L655
	slt	$2,$18,129
	.set	macro
	.set	reorder

	move	$18,$0
	slt	$2,$18,129
$L655:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	move	$5,$3
	.set	macro
	.set	reorder

	li	$18,128			# 0x00000080
$L656:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L657
	slt	$2,$5,181
	.set	macro
	.set	reorder

	move	$5,$0
	slt	$2,$5,181
$L657:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	li	$2,-1240793088			# 0xb60b0000
	.set	macro
	.set	reorder

	li	$5,180			# 0x000000b4
$L658:
	ori	$2,$2,0x60b7
	sll	$3,$3,7
	mult	$3,$2
	mfhi	$8
	#nop
	#nop
	addu	$2,$8,$3
	sra	$2,$2,7
	sra	$3,$3,31
	subu	$21,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$21,$L659
	slt	$2,$21,129
	.set	macro
	.set	reorder

	move	$21,$0
	slt	$2,$21,129
$L659:
	bne	$2,$0,$L644
	li	$21,128			# 0x00000080
$L644:
	li	$4,1717960704			# 0x66660000
	ori	$4,$4,0x6667
	sll	$2,$5,16
	sra	$2,$2,16
	li	$3,180			# 0x000000b4
	subu	$3,$3,$2
	mult	$3,$4
	li	$4,584			# 0x00000248
	sra	$3,$3,31
	mfhi	$9
	#nop
	#nop
	sra	$19,$9,3
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	subu	$19,$19,$3
	.set	macro
	.set	reorder

	li	$4,598			# 0x00000256
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$20,$2
	.set	macro
	.set	reorder

	li	$4,591			# 0x0000024f
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$23,$2
	.set	macro
	.set	reorder

	subu	$2,$2,$20
	li	$4,607			# 0x0000025f
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sh	$2,200($sp)
	.set	macro
	.set	reorder

	sll	$18,$18,16
	sra	$18,$18,16
	lui	$17,%hi(kRGBVals) # high
	lui	$16,%hi(textDefinitions) # high
	addiu	$16,$16,%lo(textDefinitions) # low
	lbu	$3,70($16)
	addiu	$17,$17,%lo(kRGBVals) # low
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$4,0($3)
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	sh	$2,208($sp)
	.set	macro
	.set	reorder

	lbu	$3,71($16)
	move	$5,$18
	sll	$3,$3,2
	addu	$3,$3,$17
	lw	$4,0($3)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$fp,$2
	.set	macro
	.set	reorder

	sll	$3,$19,16
	sra	$3,$3,16
	move	$5,$3
	lw	$4,264($sp)
	move	$18,$2
	.set	noreorder
	.set	nomacro
	jal	DrawRecords__19tScreenTrackRecordss
	sw	$3,216($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,593			# 0x00000251
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_GetLapsForType__Fv
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$17,$sp,88
	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Front_GetTrackRaced__Fv
	li	$16,260			# 0x00000104
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$2,213
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,597			# 0x00000255
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	li	$5,260			# 0x00000104
	sll	$2,$2,16
	sra	$6,$2,16
	move	$7,$18
	li	$2,2			# 0x00000002
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	li	$4,597			# 0x00000255
	sra	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	subu	$16,$16,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$16
	move	$6,$17
	move	$7,$2
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gCurrentShapes) # high
	lw	$4,%lo(gCurrentShapes)($2)
	lui	$2,%hi(ticks) # high
	addu	$4,$4,1216
	lhu	$3,16($4)
	lw	$2,%lo(ticks)($2)
	sll	$3,$3,16
	sra	$5,$3,16
	rem	$18,$2,$5
	li	$22,2293760			# 0x00230000
	ori	$22,$22,0x2323
	sh	$21,168($sp)
	sh	$19,176($sp)
	sh	$20,184($sp)
	sh	$23,192($sp)
	lh	$4,20($4)
	sra	$2,$3,17
	addu	$2,$2,-2
	srl	$3,$3,31
	addu	$3,$5,$3
	sra	$3,$3,1
	slt	$3,$3,$18
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L645
	subu	$19,$2,$4
	.set	macro
	.set	reorder

	subu	$18,$5,$18
$L645:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,597			# 0x00000255
	.set	macro
	.set	reorder

	li	$4,39			# 0x00000027
	move	$5,$0
	addu	$6,$19,$18
	lw	$8,216($sp)
	addu	$7,$2,1
	sw	$8,220($sp)
	lw	$8,264($sp)
	move	$17,$5
	lh	$2,92($8)
	li	$16,1			# 0x00000001
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,597			# 0x00000255
	.set	macro
	.set	reorder

	li	$4,39			# 0x00000027
	move	$5,$0
	lw	$8,264($sp)
	subu	$6,$19,$18
	lh	$3,92($8)
	addu	$7,$2,$16
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	li	$2,5242880			# 0x00500000
	ori	$2,$2,0x5050
	li	$4,38			# 0x00000026
	li	$5,1040			# 0x00000410
	li	$6,-2			# 0xfffffffe
	lw	$8,264($sp)
	move	$7,$0
	sw	$2,148($sp)
	lh	$3,92($8)
	addu	$2,$sp,144
	sw	$0,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$23,4
	sll	$20,$2,16
	sll	$2,$23,16
	sra	$2,$2,16
	addu	$19,$2,2
	sll	$2,$21,16
	sra	$18,$2,16
$L646:
	sll	$2,$17,16
	sra	$16,$2,16
	slt	$2,$16,3
	beq	$2,$0,$L647
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	addu	$4,$16,588
	.set	macro
	.set	reorder

	addu	$4,$16,594
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$2
	sll	$5,$16,16
	sra	$5,$5,16
	sra	$6,$20,16
	move	$7,$fp
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	lw	$8,220($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$8,$L648
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	subu	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bgez	$2,$L651
	addu	$5,$16,-6
	.set	macro
	.set	reorder

	addu	$2,$2,15
$L651:
	sra	$2,$2,4
	sw	$2,16($sp)
	move	$4,$22
	move	$6,$19
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

$L648:
	.set	noreorder
	.set	nomacro
	j	$L646
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L647:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,610			# 0x00000262
	.set	macro
	.set	reorder

	li	$4,585			# 0x00000249
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$2,$2,16
	sra	$5,$2,16
	lhu	$8,208($sp)
	move	$7,$fp
	sw	$0,16($sp)
	sw	$0,20($sp)
	addu	$6,$8,3
	sll	$6,$6,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sra	$6,$6,16
	.set	macro
	.set	reorder

	move	$4,$22
	lhu	$8,184($sp)
	li	$2,-1			# 0xffffffff
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	li	$2,35			# 0x00000023
	sw	$2,28($sp)
	sll	$5,$8,16
	lhu	$8,192($sp)
	sra	$5,$5,16
	sll	$17,$8,16
	sra	$17,$17,16
	lhu	$8,200($sp)
	addu	$6,$17,3
	sll	$7,$8,16
	lhu	$8,168($sp)
	sra	$7,$7,16
	sll	$16,$8,16
	sra	$16,$16,16
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,588			# 0x0000024c
	.set	macro
	.set	reorder

	move	$4,$22
	addu	$5,$2,-6
	addu	$6,$17,4
	lhu	$8,208($sp)
	li	$7,2			# 0x00000002
	sw	$16,24($sp)
	sw	$0,28($sp)
	sll	$2,$8,16
	sra	$2,$2,16
	addu	$2,$2,-12
	subu	$2,$2,$17
	sw	$2,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lhu	$8,176($sp)
	#nop
	sll	$2,$8,16
	sra	$2,$2,16
	slt	$2,$2,9
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L660
	li	$5,11			# 0x0000000b
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,588			# 0x0000024c
	.set	macro
	.set	reorder

	li	$4,608			# 0x00000260
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$16,$2,-6
	.set	macro
	.set	reorder

	li	$3,8			# 0x00000008
	sw	$3,16($sp)
	move	$4,$22
	move	$5,$16
	addu	$6,$2,-1
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	li	$7,2			# 0x00000002
	.set	macro
	.set	reorder

	li	$5,11			# 0x0000000b
$L660:
	lui	$2,%hi(gCurrentShapes) # high
	lw	$4,264($sp)
	lw	$7,%lo(gCurrentShapes)($2)
	li	$6,27			# 0x0000001b
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,260($sp)
	lw	$fp,256($sp)
	lw	$23,252($sp)
	lw	$22,248($sp)
	lw	$21,244($sp)
	lw	$20,240($sp)
	lw	$19,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,264
	.set	macro
	.set	reorder

	.end	DrawBackground__19tScreenTrackRecords
	.align	2
	.globl	___19tScreenTrackRecords
	.ent	___19tScreenTrackRecords
___19tScreenTrackRecords:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	___7tScreen
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	___19tScreenTrackRecords
