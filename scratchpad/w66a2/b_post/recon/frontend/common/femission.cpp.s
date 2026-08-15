	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\femission.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Initialize__15tMissionManager
	.ent	Initialize__15tMissionManager
Initialize__15tMissionManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd) # high
	addiu	$2,$2,%lo(frontEnd) # low
	sb	$0,0($4)
	sw	$0,4($4)
	sb	$0,299($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,300($2)
	.set	macro
	.set	reorder

	.end	Initialize__15tMissionManager
	.rdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.align	2
$LC1:
	.ascii	"zHPurs.mis\000"
	.align	2
$LC2:
	.ascii	"zHPurs2.mis\000"
	.align	2
$LC3:
	.ascii	"Missions\000"
	.text
	.align	2
	.globl	LoadDescription__15tMissionManagerb
	.ent	LoadDescription__15tMissionManagerb
LoadDescription__15tMissionManagerb:
	.frame	$sp,128,$31		# vars= 80, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,128
	sw	$20,112($sp)
	move	$20,$4
	lui	$2,%hi($LC0) # high
	addiu	$5,$2,%lo($LC0) # low
	lui	$2,%hi(Paths_Paths) # high
	addiu	$6,$2,%lo(Paths_Paths) # low
	lui	$2,%hi(frontEnd+3) # high
	lbu	$3,%lo(frontEnd+3)($2)
	li	$2,1			# 0x00000001
	sw	$31,120($sp)
	sw	$21,116($sp)
	sw	$19,108($sp)
	sw	$18,104($sp)
	sw	$17,100($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L602
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$L603
	addiu	$7,$2,%lo($LC1) # low
	.set	macro
	.set	reorder

$L602:
	lui	$2,%hi($LC2) # high
	addiu	$7,$2,%lo($LC2) # low
$L603:
	lw	$6,148($6)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$18,$2
	lbu	$2,0($18)
	#nop
	sb	$2,0($20)
	lw	$21,4($18)
	lw	$2,4($20)
	lw	$19,8($18)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	addu	$17,$18,12
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,12576			# 0x00003120
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,4($20)
$L604:
	move	$4,$17
	lbu	$6,0($20)
	lw	$5,4($20)
	.set	noreorder
	.set	nomacro
	jal	blockmove
	sll	$6,$6,2
	.set	macro
	.set	reorder

	sll	$16,$21,2
	addu	$16,$16,$21
	sll	$16,$16,2
	move	$6,$16
	lbu	$2,0($20)
	lw	$5,4($20)
	sll	$2,$2,2
	addu	$17,$17,$2
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$5,$5,32
	.set	macro
	.set	reorder

	addu	$4,$17,$16
	sll	$6,$19,1
	addu	$6,$6,$19
	sll	$6,$6,2
	subu	$6,$6,$19
	lw	$5,4($20)
	sll	$6,$6,2
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$5,$5,1312
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$18
	.set	macro
	.set	reorder

	lw	$31,120($sp)
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
	addu	$sp,$sp,128
	.set	macro
	.set	reorder

	.end	LoadDescription__15tMissionManagerb
	.align	2
	.globl	ReleaseDescription__15tMissionManager
	.ent	ReleaseDescription__15tMissionManager
ReleaseDescription__15tMissionManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,4($16)
	#nop
	beq	$4,$0,$L605
	jal	purgememadr
	sw	$0,4($16)
$L605:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ReleaseDescription__15tMissionManager
	.align	2
	.globl	GetMissionStages__15tMissionManagerssPP10tStageInfo
	.ent	GetMissionStages__15tMissionManagerssPP10tStageInfo
GetMissionStages__15tMissionManagerssPP10tStageInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$5,$5,16
	sra	$5,$5,14
	lw	$8,4($4)
	sll	$6,$6,16
	addu	$5,$8,$5
	lbu	$2,2($5)
	sra	$6,$6,16
	addu	$2,$2,$6
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,32
	addu	$3,$8,$3
	lhu	$4,8($3)
	#nop
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,2
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$2,1312
	addu	$8,$8,$2
	sw	$8,0($7)
	lbu	$2,10($3)
	j	$31
	.end	GetMissionStages__15tMissionManagerssPP10tStageInfo
	.align	2
	.globl	GetMissionToRace__15tMissionManagerPP12tMissionInfo
	.ent	GetMissionToRace__15tMissionManagerPP12tMissionInfo
GetMissionToRace__15tMissionManagerPP12tMissionInfo:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$6,%hi(frontEnd) # high
	addiu	$6,$6,%lo(frontEnd) # low
	lbu	$2,299($6)
	lw	$4,4($4)
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lbu	$2,300($6)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,32
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($5)
	.set	macro
	.set	reorder

	.end	GetMissionToRace__15tMissionManagerPP12tMissionInfo
