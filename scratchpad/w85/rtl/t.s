	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\stattool.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	minChar
	.data
	.align	2
minChar:
	.byte	58
	.byte	58
	.byte	58
	.byte	58
	.byte	58
	.byte	58
	.globl	secChar
	.align	2
secChar:
	.byte	46
	.byte	58
	.byte	46
	.byte	46
	.byte	46
	.byte	46
	.rdata
	.align	2
$LC0:
	.ascii	"TempSort\000"
	.text
	.align	2
	.globl	Stattool_nCreateIndex__FiPiPs
	.rdata
	.align	2
$LC1:
	.ascii	"%02d%c%02d%c%02d\000"
	.text
	.align	2
	.globl	Stattool_ParseTime__FiPc
	.align	2
	.globl	UserNameUpperCaseOneLetter__FPc
	.align	2
	.globl	Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
	.align	2
	.globl	StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
	.rdata
	.align	2
$LC2:
	.ascii	"records\000"
	.text
	.align	2
	.globl	Stattool_GetAllDefaultRecords__FP13tRecordBufferb
	.rdata
	.align	2
$LC3:
	.ascii	"%sznfsrec.dat\000"
	.align	2
$LC4:
	.ascii	"%szrecord.dat\000"
	.text
	.align	2
	.globl	Stattool_ReadDefaultRecords__FP13tRecordBufferb
	.align	2
	.globl	Stattool_GetRecords__FsP13tRecordBuffer
	.rdata
	.align	2
$LC5:
	.ascii	"trkrcrds\000"
	.text
	.align	2
	.globl	Stattool_ReturnRecordLapTime__Fs
	.align	2
	.globl	Stattool_CheckForHumanCar__FP10Car_tStats
	.align	2
	.globl	Stattool_GetAINameFromPersonality__F14tPersonalities

	.extern	GameSetup_gPersonalityNames, 120
	.extern	GameSetup_gData, 976
	.extern	Stats_gTrackRecords, 3740
	.extern	Paths_Paths, 200
	.extern	frontEnd, 1104

	.text
	.text
	.ent	Stattool_nCreateIndex__FiPiPs
Stattool_nCreateIndex__FiPiPs:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$18,24($sp)
	move	$18,$6
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	addu	$5,$17,1
	sll	$5,$5,2
	li	$6,16			# 0x00000010
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$16,$0
	.set	noreorder
	.set	nomacro
	blez	$17,$L9
	move	$4,$2
	.set	macro
	.set	reorder

	move	$6,$4
	move	$5,$19
	move	$3,$18
$L10:
	sh	$16,0($3)
	lw	$2,0($5)
	addu	$5,$5,4
	addu	$3,$3,2
	addu	$16,$16,1
	sw	$2,0($6)
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	addu	$6,$6,4
	.set	macro
	.set	reorder

$L9:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L12
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	addu	$10,$18,2
	.set	macro
	.set	reorder

	addu	$9,$4,4
$L16:
	addu	$6,$16,-1
	lw	$8,0($9)
	lh	$11,0($10)
	.set	noreorder
	.set	nomacro
	bltz	$6,$L18
	sll	$2,$6,1
	.set	macro
	.set	reorder

	addu	$7,$2,$18
	sll	$2,$6,2
	addu	$5,$2,$4
$L22:
	lw	$3,0($5)
	#nop
	slt	$2,$8,$3
	beq	$2,$0,$L18
	sw	$3,4($5)
	addu	$5,$5,-4
	lhu	$2,0($7)
	addu	$6,$6,-1
	sh	$2,2($7)
	.set	noreorder
	.set	nomacro
	bgez	$6,$L22
	addu	$7,$7,-2
	.set	macro
	.set	reorder

$L18:
	addu	$10,$10,2
	addu	$16,$16,1
	sll	$2,$6,2
	addu	$2,$2,$4
	sw	$8,4($2)
	sll	$2,$6,1
	addu	$2,$2,$18
	sh	$11,2($2)
	slt	$2,$16,$17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L16
	addu	$9,$9,4
	.set	macro
	.set	reorder

$L12:
	jal	purgememadr
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

	.end	Stattool_nCreateIndex__FiPiPs
	.text
	.ent	Stattool_ParseTime__FiPc
Stattool_ParseTime__FiPc:
	.frame	$sp,40,$31		# vars= 0, regs= 2/0, args= 32, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	move	$10,$4
	sw	$16,32($sp)
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	__floatsisf
	move	$16,$5
	.set	macro
	.set	reorder

	li.s	$5,6.39999985694885253906e-1
	.set	noreorder
	.set	nomacro
	jal	__divsf3
	move	$4,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	move	$10,$2
	li	$2,91619328			# 0x05760000
	ori	$2,$2,0x19f1
	mult	$10,$2
	li	$3,1374355456			# 0x51eb0000
	ori	$3,$3,0x851f
	sra	$2,$10,31
	mfhi	$11
	#nop
	#nop
	sra	$6,$11,7
	subu	$6,$6,$2
	sll	$6,$6,16
	sra	$6,$6,16
	sll	$2,$6,1
	addu	$2,$2,$6
	sll	$2,$2,4
	subu	$2,$2,$6
	sll	$2,$2,3
	subu	$2,$2,$6
	sll	$2,$2,4
	subu	$10,$10,$2
	mult	$10,$3
	move	$4,$16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	lui	$7,%hi(minChar) # high
	lui	$9,%hi(frontEnd) # high
	addiu	$9,$9,%lo(frontEnd) # low
	addiu	$7,$7,%lo(minChar) # low
	sra	$2,$10,31
	mfhi	$11
	#nop
	#nop
	sra	$8,$11,5
	subu	$8,$8,$2
	sll	$8,$8,16
	sra	$8,$8,16
	sll	$3,$8,1
	addu	$3,$3,$8
	sll	$3,$3,3
	addu	$3,$3,$8
	sll	$3,$3,2
	lbu	$2,832($9)
	subu	$10,$10,$3
	addu	$2,$2,$7
	lbu	$7,0($2)
	lui	$2,%hi(secChar) # high
	sw	$8,16($sp)
	lbu	$3,832($9)
	addiu	$2,$2,%lo(secChar) # low
	addu	$3,$3,$2
	sll	$2,$10,16
	lbu	$3,0($3)
	sra	$2,$2,16
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	Stattool_ParseTime__FiPc
	.text
	.ent	UserNameUpperCaseOneLetter__FPc
UserNameUpperCaseOneLetter__FPc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lbu	$3,0($4)
	#nop
	addu	$2,$3,-97
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L26
	addu	$2,$3,224
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L26:
	lbu	$2,0($4)
	#nop
	addu	$3,$2,-224
	sltu	$2,$3,29
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L49
	lui	$2,%hi($L46) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo($L46) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$2,0($3)
	#nop
	j	$2
	.rdata
	.align	3
$L46:
	.word	$L38
	.word	$L32
	.word	$L25
	.word	$L25
	.word	$L28
	.word	$L37
	.word	$L25
	.word	$L25
	.word	$L39
	.word	$L31
	.word	$L25
	.word	$L25
	.word	$L42
	.word	$L33
	.word	$L25
	.word	$L25
	.word	$L25
	.word	$L36
	.word	$L43
	.word	$L34
	.word	$L25
	.word	$L25
	.word	$L29
	.word	$L25
	.word	$L25
	.word	$L44
	.word	$L35
	.word	$L25
	.word	$L30
	.text
$L28:
	li	$2,196			# 0x000000c4
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L29:
	li	$2,214			# 0x000000d6
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L30:
	li	$2,220			# 0x000000dc
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L31:
	li	$2,69			# 0x00000045
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L32:
	li	$2,65			# 0x00000041
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L33:
	li	$2,73			# 0x00000049
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L34:
	li	$2,79			# 0x0000004f
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L35:
	li	$2,85			# 0x00000055
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L36:
	li	$2,209			# 0x000000d1
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L37:
	li	$2,197			# 0x000000c5
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L38:
	li	$2,192			# 0x000000c0
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L39:
	lui	$2,%hi(frontEnd+832) # high
	lbu	$3,%lo(frontEnd+832)($2)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L40
	li	$2,69			# 0x00000045
	.set	macro
	.set	reorder

	li	$2,200			# 0x000000c8
$L40:
	sb	$2,0($4)
$L42:
	li	$2,204			# 0x000000cc
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L43:
	li	$2,210			# 0x000000d2
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,0($4)
	.set	macro
	.set	reorder

$L44:
	li	$2,217			# 0x000000d9
	sb	$2,0($4)
$L25:
$L49:
	j	$31
	.end	UserNameUpperCaseOneLetter__FPc
	.text
	.ent	Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	s_lower__FPc
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	lbu	$17,0($16)
	.set	noreorder
	.set	nomacro
	jal	UserNameUpperCaseOneLetter__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L50
	li	$18,32			# 0x00000020
	.set	macro
	.set	reorder

$L53:
	bne	$17,$18,$L54
	.set	noreorder
	.set	nomacro
	jal	UserNameUpperCaseOneLetter__FPc
	move	$4,$16
	.set	macro
	.set	reorder

$L54:
	lbu	$17,0($16)
	addu	$16,$16,1
	lbu	$2,0($16)
	#nop
	bne	$2,$0,$L53
$L50:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
	.text
	.ent	StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lbu	$2,0($16)
	#nop
	beq	$2,$0,$L57
$L60:
	.set	noreorder
	.set	nomacro
	jal	UserNameUpperCaseOneLetter__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	lbu	$2,0($16)
	#nop
	bne	$2,$0,$L60
$L57:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
	.text
	.ent	Stattool_GetAllDefaultRecords__FP13tRecordBufferb
Stattool_GetAllDefaultRecords__FP13tRecordBufferb:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$22,40($sp)
	move	$22,$4
	sw	$16,16($sp)
	move	$16,$5
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,3740			# 0x00000e9c
	li	$6,16			# 0x00000010
	sw	$31,44($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$21,$2
	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	Stattool_ReadDefaultRecords__FP13tRecordBufferb
	move	$5,$16
	.set	macro
	.set	reorder

	move	$20,$0
	move	$19,$20
$L64:
	move	$18,$0
	addu	$2,$19,$18
$L73:
	sll	$16,$2,2
	addu	$16,$16,$2
	sll	$16,$16,2
	addu	$17,$22,$16
	move	$4,$17
	addu	$16,$21,$16
	.set	noreorder
	.set	nomacro
	jal	strcpy
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	sw	$2,8($17)
	lw	$2,12($16)
	#nop
	sw	$2,12($17)
	lw	$2,16($16)
	addu	$18,$18,1
	sw	$2,16($17)
	slt	$2,$18,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	addu	$2,$19,$18
	.set	macro
	.set	reorder

	addu	$20,$20,1
	slt	$2,$20,11
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L64
	addu	$19,$19,17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

	lw	$31,44($sp)
	lw	$22,40($sp)
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

	.end	Stattool_GetAllDefaultRecords__FP13tRecordBufferb
	.text
	.ent	Stattool_ReadDefaultRecords__FP13tRecordBufferb
Stattool_ReadDefaultRecords__FP13tRecordBufferb:
	.frame	$sp,104,$31		# vars= 80, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$16,96($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L75
	sw	$31,100($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+144) # high
	lw	$6,%lo(Paths_Paths+144)($2)
	lui	$5,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$L80
	addiu	$5,$5,%lo($LC3) # low
	.set	macro
	.set	reorder

$L75:
	addu	$4,$sp,16
	lui	$2,%hi(Paths_Paths+144) # high
	lw	$6,%lo(Paths_Paths+144)($2)
	lui	$5,%hi($LC4) # high
	addiu	$5,$5,%lo($LC4) # low
$L80:
	jal	sprintf
	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$3,3740			# 0x00000e9c
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L77
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileatadrz
	move	$5,$16
	.set	macro
	.set	reorder

	j	$L74
$L77:
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,3740			# 0x00000e9c
	.set	macro
	.set	reorder

$L74:
	lw	$31,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Stattool_ReadDefaultRecords__FP13tRecordBufferb
	.text
	.ent	Stattool_GetRecords__FsP13tRecordBuffer
Stattool_GetRecords__FsP13tRecordBuffer:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sll	$4,$4,16
	sra	$4,$4,16
	sll	$2,$4,2
	addu	$2,$2,$4
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$2,$2,2
	lui	$4,%hi(Stats_gTrackRecords) # high
	addiu	$4,$4,%lo(Stats_gTrackRecords) # low
	addu	$4,$2,$4
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,340			# 0x00000154
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

	.end	Stattool_GetRecords__FsP13tRecordBuffer
	.text
	.ent	Stattool_ReturnRecordLapTime__Fs
Stattool_ReturnRecordLapTime__Fs:
	.frame	$sp,48,$31		# vars= 24, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,40($sp)
	move	$16,$4
	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	li	$5,360			# 0x00000168
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	sll	$16,$16,16
	sra	$4,$16,16
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	Stattool_GetRecords__FsP13tRecordBuffer
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,32($sp)
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Stattool_ReturnRecordLapTime__Fs
	.text
	.ent	Stattool_CheckForHumanCar__FP10Car_tStats
Stattool_CheckForHumanCar__FP10Car_tStats:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$6,$0
	lui	$2,%hi(GameSetup_gData) # high
	addiu	$2,$2,%lo(GameSetup_gData) # low
	lhu	$3,968($2)
	lhu	$2,972($2)
	#nop
	addu	$3,$3,$2
	sll	$3,$3,16
	sra	$3,$3,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L87
	move	$5,$6
	.set	macro
	.set	reorder

	li	$8,1			# 0x00000001
	move	$7,$3
	sll	$2,$5,16
$L95:
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,5
	addu	$3,$3,$4
	lw	$2,108($3)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L94
	addu	$2,$5,1
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
$L94:
	.set	noreorder
	.set	nomacro
	beq	$6,$8,$L87
	move	$5,$2
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L95
	sll	$2,$5,16
	.set	macro
	.set	reorder

$L87:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	Stattool_CheckForHumanCar__FP10Car_tStats
	.text
	.ent	Stattool_GetAINameFromPersonality__F14tPersonalities
Stattool_GetAINameFromPersonality__F14tPersonalities:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sltu	$2,$4,15
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L97
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	sll	$3,$4,3
	lui	$2,%hi(GameSetup_gPersonalityNames) # high
	addiu	$2,$2,%lo(GameSetup_gPersonalityNames) # low
	.set	noreorder
	.set	nomacro
	j	$L98
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L97:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,750			# 0x000002ee
	.set	macro
	.set	reorder

$L98:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Stattool_GetAINameFromPersonality__F14tPersonalities
