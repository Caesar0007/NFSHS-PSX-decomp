	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\fetourn.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gFEData_80011658
	.data
gFEData_80011658:
	.byte	83
	.globl	gFEData_80011659
gFEData_80011659:
	.byte	77
	.globl	gFEData_8001165a
gFEData_8001165a:
	.byte	76
	.globl	gFEData_8001165c
	.align	2
gFEData_8001165c:
	.word	1112754007
	.text
	.align	2
	.globl	Initialize__18tTournamentManager
	.ent	Initialize__18tTournamentManager
Initialize__18tTournamentManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	li	$2,20000			# 0x00004e20
	sw	$2,20($4)
	sw	$0,12($4)
	sb	$0,0($4)
	sw	$0,24($4)
	sh	$0,52($4)
	sh	$0,182($4)
	sll	$2,$5,16
$L616:
	sra	$2,$2,16
	addu	$2,$4,$2
	sb	$0,567($2)
	addu	$2,$5,1
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L616
	sll	$2,$5,16
	.set	macro
	.set	reorder

	move	$5,$0
	li	$3,7			# 0x00000007
	sll	$2,$5,16
$L617:
	sra	$2,$2,16
	addu	$2,$4,$2
	sb	$3,496($2)
	addu	$2,$5,1
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,64
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L617
	sll	$2,$5,16
	.set	macro
	.set	reorder

	move	$5,$0
	li	$6,6			# 0x00000006
$L614:
	sll	$3,$5,16
	addu	$2,$5,1
	move	$5,$2
	sra	$3,$3,15
	addu	$3,$4,$3
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,3
	sh	$6,36($3)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L614
	sh	$0,44($3)
	.set	macro
	.set	reorder

	lui	$2,%hi(carManager) # high
	lui	$3,%hi(frontEnd) # high
	lw	$2,%lo(carManager)($2)
	addiu	$3,$3,%lo(frontEnd) # low
	addu	$2,$2,-1
	sb	$2,291($3)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$2,292($3)
	.set	macro
	.set	reorder

	.end	Initialize__18tTournamentManager
	.rdata
	.align	2
$LC0:
	.ascii	"%s%s\000"
	.align	2
$LC1:
	.ascii	"tourn.trn\000"
	.align	2
$LC2:
	.ascii	"Tourney\000"
	.text
	.align	2
	.globl	LoadDescription__18tTournamentManager
	.ent	LoadDescription__18tTournamentManager
LoadDescription__18tTournamentManager:
	.frame	$sp,144,$31		# vars= 88, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$22,128($sp)
	move	$22,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	lui	$2,%hi(Paths_Paths+148) # high
	lui	$7,%hi($LC1) # high
	lw	$6,%lo(Paths_Paths+148)($2)
	addiu	$7,$7,%lo($LC1) # low
	sw	$31,140($sp)
	sw	$fp,136($sp)
	sw	$23,132($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$18,112($sp)
	sw	$17,108($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,104($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	ReleaseDescription__18tTournamentManager
	move	$4,$22
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadr
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	sw	$2,96($sp)
	move	$4,$2
	addu	$5,$22,561
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	lw	$8,96($sp)
	li	$5,10532			# 0x00002924
	lbu	$2,6($8)
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sb	$2,0($22)
	.set	macro
	.set	reorder

	lbu	$3,0($22)
	lw	$8,96($sp)
	move	$fp,$0
	sw	$2,24($22)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L619
	addu	$18,$8,7
	.set	macro
	.set	reorder

	move	$4,$18
$L635:
	li	$6,12			# 0x0000000c
	sll	$2,$fp,16
	sra	$17,$2,16
	sll	$16,$17,1
	addu	$16,$16,$17
	lw	$5,24($22)
	sll	$16,$16,2
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$5,$5,$16
	.set	macro
	.set	reorder

	lw	$6,24($22)
	#nop
	addu	$16,$6,$16
	lbu	$20,2($16)
	lbu	$2,0($16)
	move	$3,$20
	addu	$2,$3,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	addu	$18,$18,12
	.set	macro
	.set	reorder

	move	$23,$3
	move	$21,$17
	move	$4,$18
$L634:
	sll	$3,$20,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$17,$2,2
	addu	$5,$17,36
	addu	$5,$6,$5
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,84			# 0x00000054
	.set	macro
	.set	reorder

	lw	$6,24($22)
	#nop
	addu	$2,$6,$17
	lbu	$16,38($2)
	lbu	$2,37($2)
	move	$3,$16
	addu	$2,$3,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L627
	addu	$18,$18,84
	.set	macro
	.set	reorder

	move	$19,$3
$L628:
	move	$4,$18
	sll	$2,$16,16
	sra	$2,$2,16
	sll	$5,$2,2
	addu	$5,$5,$2
	sll	$5,$5,3
	addu	$5,$5,5412
	addu	$5,$6,$5
	.set	noreorder
	.set	nomacro
	jal	blockmove
	li	$6,40			# 0x00000028
	.set	macro
	.set	reorder

	addu	$3,$16,1
	move	$16,$3
	lw	$6,24($22)
	sll	$3,$3,16
	addu	$2,$6,$17
	lbu	$2,37($2)
	sra	$3,$3,16
	addu	$2,$19,$2
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L628
	addu	$18,$18,40
	.set	macro
	.set	reorder

$L627:
	addu	$2,$20,1
	move	$20,$2
	sll	$2,$2,16
	sll	$3,$21,1
	addu	$3,$3,$21
	lw	$6,24($22)
	sll	$3,$3,2
	addu	$3,$6,$3
	lbu	$3,0($3)
	sra	$2,$2,16
	addu	$3,$23,$3
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L634
	move	$4,$18
	.set	macro
	.set	reorder

$L623:
	addu	$2,$fp,1
	move	$fp,$2
	sll	$2,$2,16
	lbu	$3,0($22)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	move	$4,$18
	.set	macro
	.set	reorder

$L619:
	lw	$4,96($sp)
	jal	purgememadr
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,144
	.set	macro
	.set	reorder

	.end	LoadDescription__18tTournamentManager
	.align	2
	.globl	ReleaseDescription__18tTournamentManager
	.ent	ReleaseDescription__18tTournamentManager
ReleaseDescription__18tTournamentManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,24($16)
	#nop
	beq	$4,$0,$L636
	jal	purgememadr
	sw	$0,24($16)
$L636:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ReleaseDescription__18tTournamentManager
	.align	2
	.globl	UpdateTrackList__18tTournamentManagerss
	.ent	UpdateTrackList__18tTournamentManagerss
UpdateTrackList__18tTournamentManagerss:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$8,$4
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$2,$5,1
	addu	$2,$2,$5
	sll	$2,$2,2
	lw	$4,24($8)
	sll	$6,$6,16
	addu	$2,$4,$2
	lbu	$3,2($2)
	sra	$6,$6,16
	addu	$3,$3,$6
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$4,$4,$2
	lbu	$10,1($4)
	lbu	$6,2($4)
	move	$2,$10
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	move	$7,$0
	.set	macro
	.set	reorder

	move	$9,$2
$L640:
	move	$3,$6
	addu	$6,$6,1
	sll	$5,$7,16
	sll	$3,$3,16
	sra	$3,$3,16
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$4,$7,1
	move	$7,$4
	sra	$5,$5,15
	addu	$5,$8,$5
	sll	$4,$4,16
	lw	$3,24($8)
	sra	$4,$4,16
	addu	$3,$3,$2
	lbu	$2,5412($3)
	slt	$4,$4,$9
	sll	$2,$2,24
	sra	$2,$2,24
	addu	$2,$2,213
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L640
	sh	$2,182($5)
	.set	macro
	.set	reorder

$L639:
	sll	$2,$10,1
	addu	$2,$8,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,182($2)
	.set	macro
	.set	reorder

	.end	UpdateTrackList__18tTournamentManagerss
	.align	2
	.globl	GetTrackList__18tTournamentManagerss
	.ent	GetTrackList__18tTournamentManagerss
GetTrackList__18tTournamentManagerss:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sll	$5,$5,16
	sll	$6,$6,16
	sra	$5,$5,16
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	UpdateTrackList__18tTournamentManagerss
	sra	$6,$6,16
	.set	macro
	.set	reorder

	addu	$2,$16,182
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	GetTrackList__18tTournamentManagerss
	.align	2
	.globl	GetTrackToRace__18tTournamentManagerR10tTrackInfo
	.ent	GetTrackToRace__18tTournamentManagerR10tTrackInfo
GetTrackToRace__18tTournamentManagerR10tTrackInfo:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$31,24($sp)
	lw	$3,4($16)
	lw	$5,24($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($16)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lbu	$2,38($2)
	lw	$3,12($16)
	li	$6,40			# 0x00000028
	addu	$2,$2,$3
	sll	$4,$2,2
	addu	$4,$4,$2
	sll	$4,$4,3
	addu	$4,$4,5412
	addu	$4,$5,$4
	.set	noreorder
	.set	nomacro
	jal	blockmove
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$2,12($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,216($2)
	#nop
	sb	$2,1($17)
	lw	$2,12($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,232($2)
	#nop
	sb	$2,2($17)
	lw	$2,12($16)
	#nop
	addu	$2,$16,$2
	lbu	$2,248($2)
	#nop
	sb	$2,3($17)
	lw	$2,12($16)
	#nop
	addu	$16,$16,$2
	lbu	$2,264($16)
	#nop
	sb	$2,4($17)
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

	.end	GetTrackToRace__18tTournamentManagerR10tTrackInfo
	.align	2
	.globl	StartNewTournament__18tTournamentManagerUcUc
	.ent	StartNewTournament__18tTournamentManagerUcUc
StartNewTournament__18tTournamentManagerUcUc:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	andi	$5,$5,0x00ff
	andi	$6,$6,0x00ff
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$5,4($19)
	sw	$6,8($19)
	.set	noreorder
	.set	nomacro
	jal	GetNumCompetitors__18tTournamentManager
	sw	$0,12($19)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lw	$4,4($19)
	lw	$5,24($19)
	sra	$2,$2,16
	sw	$2,16($19)
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$5,$3
	lbu	$4,2($3)
	lw	$3,8($19)
	move	$18,$0
	addu	$4,$4,$3
	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$3,36
	.set	noreorder
	.set	nomacro
	blez	$2,$L647
	addu	$20,$5,$3
	.set	macro
	.set	reorder

	sll	$2,$18,16
$L665:
	sra	$4,$2,16
	sll	$2,$4,4
	addu	$3,$19,$2
	sh	$0,292($3)
	sw	$0,288($3)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L651
	sb	$0,285($3)
	.set	macro
	.set	reorder

	addu	$2,$4,$20
	lbu	$2,51($2)
	.set	noreorder
	.set	nomacro
	j	$L652
	sw	$2,280($3)
	.set	macro
	.set	reorder

$L651:
	sw	$0,280($3)
$L652:
	sll	$3,$18,16
	sra	$3,$3,16
	sll	$2,$3,4
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L653
	addu	$4,$19,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L654
	sb	$18,294($4)
	.set	macro
	.set	reorder

$L653:
	lbu	$2,16($19)
	#nop
	sb	$2,294($4)
$L654:
	addu	$2,$18,1
	move	$18,$2
	sll	$2,$2,16
	lw	$3,16($19)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L665
	sll	$2,$18,16
	.set	macro
	.set	reorder

$L647:
	lbu	$2,1($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L656
	move	$18,$0
	.set	macro
	.set	reorder

	sll	$4,$18,16
$L667:
	lbu	$3,2($20)
	sra	$4,$4,16
	addu	$3,$3,$4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,3
	lw	$3,24($19)
	addu	$2,$2,5412
	addu	$17,$3,$2
	lbu	$2,1($17)
	addu	$16,$19,$4
	sb	$2,216($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	bne	$2,$0,$L660
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,216($16)
$L660:
	lbu	$2,2($17)
	#nop
	sb	$2,232($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	bne	$2,$0,$L661
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,232($16)
$L661:
	lbu	$2,3($17)
	#nop
	sb	$2,248($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	bne	$2,$0,$L662
	jal	rand
	andi	$2,$2,0x0001
	sb	$2,248($16)
$L662:
	lbu	$2,4($17)
	#nop
	sb	$2,264($16)
	andi	$2,$2,0x00ff
	sltu	$2,$2,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L666
	addu	$2,$18,1
	.set	macro
	.set	reorder

	jal	rand
	andi	$2,$2,0x0001
	sb	$2,264($16)
	addu	$2,$18,1
$L666:
	move	$18,$2
	sll	$2,$2,16
	lbu	$3,1($20)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L667
	sll	$4,$18,16
	.set	macro
	.set	reorder

$L656:
	li	$2,1			# 0x00000001
	sb	$2,285($19)
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

	.end	StartNewTournament__18tTournamentManagerUcUc
	.align	2
	.globl	IsTournamentFinished__18tTournamentManager
	.ent	IsTournamentFinished__18tTournamentManager
IsTournamentFinished__18tTournamentManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$4
	lw	$3,4($5)
	lw	$4,24($5)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($5)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$4,$4,$2
	lbu	$2,1($4)
	lw	$3,12($5)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L670
	lbu	$2,5($4)
	#nop
	beq	$2,$0,$L672
	lhu	$2,292($5)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L672
$L670:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L672:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	IsTournamentFinished__18tTournamentManager
	.align	2
	.globl	tournPointsCompare__FPcT0
	.ent	tournPointsCompare__FPcT0
tournPointsCompare__FPcT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(tournamentManager) # high
	addiu	$3,$3,%lo(tournamentManager) # low
	addu	$3,$3,280
	lbu	$5,0($5)
	lbu	$4,0($4)
	sll	$2,$5,4
	addu	$7,$2,$3
	sll	$2,$4,4
	addu	$6,$2,$3
	lhu	$3,12($7)
	lhu	$2,12($6)
	#nop
	subu	$3,$3,$2
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L677
	addiu	$8,$2,%lo(Cars_gNewCarStatsList) # low
	.set	macro
	.set	reorder

	lb	$3,5($7)
	lb	$2,5($6)
	#nop
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L677
	sll	$2,$5,2
	.set	macro
	.set	reorder

	sll	$3,$4,2
	addu	$3,$3,$4
	sll	$3,$3,5
	addu	$3,$3,$8
	addu	$2,$2,$5
	sll	$2,$2,5
	addu	$2,$2,$8
	lw	$3,132($3)
	lw	$2,132($2)
	#nop
	subu	$3,$3,$2
$L677:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	tournPointsCompare__FPcT0
	.align	2
	.globl	UpdateTournFinishMoney__18tTournamentManager
	.ent	UpdateTournFinishMoney__18tTournamentManager
UpdateTournFinishMoney__18tTournamentManager:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,4($18)
	lw	$4,24($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($18)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$19,$4,$2
	lb	$2,0($19)
	#nop
	addu	$2,$18,$2
	lbu	$2,496($2)
	#nop
	sb	$2,560($18)
	lbu	$2,5($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L679
	move	$4,$18
	.set	macro
	.set	reorder

	lbu	$5,294($18)
	.set	noreorder
	.set	nomacro
	jal	GetTournamentFinishPrize__18tTournamentManagers
	addu	$5,$5,-1
	.set	macro
	.set	reorder

	lw	$3,580($18)
	#nop
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L678
	sw	$3,580($18)
	.set	macro
	.set	reorder

$L679:
	move	$16,$0
	andi	$17,$16,0x00ff
$L688:
	addu	$2,$18,$17
	lbu	$2,567($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L683
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetTournamentFinishPrize__18tTournamentManagers
	andi	$5,$16,0x00ff
	.set	macro
	.set	reorder

	lw	$3,580($18)
	#nop
	addu	$3,$3,$2
	sw	$3,580($18)
	lb	$2,0($19)
	#nop
	addu	$3,$18,$2
	lb	$2,496($3)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L683
	addu	$2,$16,1
	.set	macro
	.set	reorder

	sb	$2,496($3)
$L683:
	addu	$16,$16,1
	andi	$2,$16,0x00ff
	sltu	$2,$2,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L688
	andi	$17,$16,0x00ff
	.set	macro
	.set	reorder

$L678:
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

	.end	UpdateTournFinishMoney__18tTournamentManager
	.align	2
	.globl	UpdateTrackFinishMoney__18tTournamentManager
	.ent	UpdateTrackFinishMoney__18tTournamentManager
UpdateTrackFinishMoney__18tTournamentManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lui	$2,%hi(Cars_gNewCarStatsList) # high
	addiu	$4,$2,%lo(Cars_gNewCarStatsList) # low
	sw	$31,20($sp)
	lw	$3,128($4)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L689
	lhu	$5,132($4)
	move	$4,$16
	addu	$5,$5,-1
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	GetTrackFinishPrize__18tTournamentManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	lw	$3,576($16)
	#nop
	addu	$3,$3,$2
	sw	$3,576($16)
$L689:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateTrackFinishMoney__18tTournamentManager
	.align	2
	.globl	CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
	.ent	CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
CalcTrackFinishDamageBill__18tTournamentManagerbRlT2:
	.frame	$sp,240,$31		# vars= 208, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,240
	sw	$17,228($sp)
	move	$17,$6
	sw	$18,232($sp)
	move	$18,$7
	sw	$31,236($sp)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L692
	sw	$16,224($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(Cars_gNewCarStatsList) # high
	addiu	$16,$2,%lo(Cars_gNewCarStatsList) # low
	lui	$4,%hi(carManager) # high
	lui	$2,%hi(frontEnd+291) # high
	addiu	$4,$4,%lo(carManager) # low
	addu	$6,$sp,16
	lbu	$5,%lo(frontEnd+291)($2)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	move	$3,$0
	li	$8,1			# 0x00000001
	addu	$7,$sp,16
	li	$4,4			# 0x00000004
	lw	$5,48($sp)
	lbu	$6,212($sp)
$L696:
	sll	$2,$8,$3
	sll	$2,$2,16
	sra	$2,$2,16
	and	$2,$6,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L695
	addu	$2,$7,$4
	.set	macro
	.set	reorder

	lw	$2,32($2)
	#nop
	addu	$5,$5,$2
$L695:
	addu	$3,$3,1
	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L696
	addu	$4,$4,4
	.set	macro
	.set	reorder

	lw	$3,112($16)
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$3,$L699
	li	$2,65535			# 0x0000ffff
	.set	macro
	.set	reorder

	addu	$3,$3,$2
$L699:
	sra	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L705
	mult	$5,$3
	.set	macro
	.set	reorder

	lw	$2,132($16)
	#nop
	slt	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L700
	li	$2,1717960704			# 0x66660000
	.set	macro
	.set	reorder

	ori	$2,$2,0x6667
	mult	$5,$2
	lui	$2,%hi(gTrackFinishBill) # high
	lui	$6,%hi(gTrackFinishBonus) # high
	lw	$3,132($16)
	sra	$4,$5,31
	sw	$0,%lo(gTrackFinishBill)($2)
	mfhi	$9
	#nop
	#nop
	sra	$2,$9,3
	subu	$2,$2,$4
	sw	$2,%lo(gTrackFinishBonus)($6)
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L701
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$3,1374355456			# 0x51eb0000
	ori	$3,$3,0x851f
	sll	$2,$5,1
	addu	$2,$2,$5
	mult	$2,$3
	sra	$2,$2,31
	mfhi	$9
	#nop
	#nop
	sra	$3,$9,5
	subu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L692
	sw	$3,%lo(gTrackFinishBonus)($6)
	.set	macro
	.set	reorder

$L701:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L706
	lui	$2,%hi(gTrackFinishBill) # high
	.set	macro
	.set	reorder

	li	$2,1374355456			# 0x51eb0000
	ori	$2,$2,0x851f
	mult	$5,$2
	mfhi	$9
	#nop
	#nop
	sra	$2,$9,5
	subu	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$L692
	sw	$2,%lo(gTrackFinishBonus)($6)
	.set	macro
	.set	reorder

$L700:
	mult	$5,$3
$L705:
	li	$4,1759182848			# 0x68db0000
	ori	$4,$4,0x8bad
	mflo	$2
	#nop
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	mult	$3,$4
	lui	$2,%hi(gTrackFinishBonus) # high
	lui	$4,%hi(gTrackFinishBill) # high
	sra	$3,$3,31
	sw	$0,%lo(gTrackFinishBonus)($2)
	mfhi	$8
	#nop
	#nop
	sra	$2,$8,12
	subu	$2,$2,$3
	sw	$2,%lo(gTrackFinishBill)($4)
$L692:
	lui	$2,%hi(gTrackFinishBill) # high
$L706:
	lw	$2,%lo(gTrackFinishBill)($2)
	#nop
	sw	$2,0($17)
	lui	$2,%hi(gTrackFinishBonus) # high
	lw	$2,%lo(gTrackFinishBonus)($2)
	#nop
	sw	$2,0($18)
	lw	$31,236($sp)
	lw	$18,232($sp)
	lw	$17,228($sp)
	lw	$16,224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,240
	.set	macro
	.set	reorder

	.end	CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
	.align	2
	.globl	UpdateTrackFinishPoints__18tTournamentManager
	.ent	UpdateTrackFinishPoints__18tTournamentManager
UpdateTrackFinishPoints__18tTournamentManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	GetNumCompetitors__18tTournamentManager
	move	$16,$4
	.set	macro
	.set	reorder

	move	$7,$0
	lw	$4,4($16)
	lw	$5,24($16)
	sll	$3,$4,1
	addu	$3,$3,$4
	sll	$3,$3,2
	addu	$3,$5,$3
	lbu	$3,2($3)
	lw	$4,8($16)
	move	$8,$2
	addu	$3,$3,$4
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lui	$3,%hi(Cars_gNewCarStatsList) # high
	lbu	$2,41($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L708
	addiu	$9,$3,%lo(Cars_gNewCarStatsList) # low
	.set	macro
	.set	reorder

	sll	$2,$8,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L710
	move	$4,$0
	.set	macro
	.set	reorder

	li	$11,2			# 0x00000002
	li	$10,1			# 0x00000001
	move	$8,$2
	move	$5,$16
$L712:
	lw	$2,288($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L713
	sll	$2,$7,16
	.set	macro
	.set	reorder

	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,5
	addu	$3,$3,$9
	lw	$6,132($3)
	#nop
	addu	$2,$6,-1
	sltu	$2,$2,6
	beq	$2,$0,$L714
	lw	$2,128($3)
	#nop
	bne	$2,$11,$L714
	lw	$2,16($16)
	#nop
	slt	$2,$6,$2
	bne	$2,$0,$L715
	.set	noreorder
	.set	nomacro
	j	$L716
	sw	$10,288($5)
	.set	macro
	.set	reorder

$L715:
	lhu	$2,292($5)
	#nop
	addu	$2,$2,1
	sh	$2,292($5)
$L716:
	lbu	$2,132($3)
	#nop
	sb	$2,294($5)
$L714:
	addu	$7,$7,1
$L713:
 #APP
 #NO_APP
	addu	$4,$4,1
	slt	$2,$4,$8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	addu	$5,$5,16
	.set	macro
	.set	reorder

$L710:
	lw	$2,16($16)
	#nop
	addu	$2,$2,-1
	.set	noreorder
	.set	nomacro
	j	$L707
	sw	$2,16($16)
	.set	macro
	.set	reorder

$L708:
	sll	$2,$8,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L720
	move	$4,$0
	.set	macro
	.set	reorder

	li	$10,2			# 0x00000002
	move	$7,$2
	move	$6,$16
	move	$5,$9
$L722:
	lw	$2,132($5)
	#nop
	addu	$3,$2,-1
	sltu	$2,$3,6
	beq	$2,$0,$L721
	lw	$2,128($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$10,$L721
	addu	$2,$16,$3
	.set	macro
	.set	reorder

	lbu	$3,561($2)
	lhu	$2,292($6)
	#nop
	addu	$2,$2,$3
	sh	$2,292($6)
$L721:
	addu	$6,$6,16
	addu	$4,$4,1
	slt	$2,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L722
	addu	$5,$5,160
	.set	macro
	.set	reorder

$L720:
	li	$4,5			# 0x00000005
	addu	$2,$16,$4
$L725:
	sb	$4,567($2)
	addu	$4,$4,-1
	.set	noreorder
	.set	nomacro
	bgez	$4,$L725
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	addu	$4,$16,567
	sll	$5,$8,16
	lui	$7,%hi(tournPointsCompare__FPcT0) # high
	sra	$5,$5,16
	li	$6,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	qsort
	addiu	$7,$7,%lo(tournPointsCompare__FPcT0) # low
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$2,$16,$4
$L733:
	addu	$3,$4,1
	lbu	$2,567($2)
 #APP
 #NO_APP
	move	$4,$3
	sll	$2,$2,4
	addu	$2,$16,$2
	sb	$4,294($2)
	slt	$2,$4,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L733
	addu	$2,$16,$4
	.set	macro
	.set	reorder

$L707:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateTrackFinishPoints__18tTournamentManager
	.align	2
	.globl	AdvanceToNextTrack__18tTournamentManager
	.ent	AdvanceToNextTrack__18tTournamentManager
AdvanceToNextTrack__18tTournamentManager:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	lw	$3,4($17)
	lw	$4,24($17)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($17)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$18,$4,$2
	lbu	$2,1($18)
	lw	$3,12($17)
	addu	$2,$2,-1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L735
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	move	$4,$17
	sw	$0,576($17)
	sw	$0,580($17)
	sh	$0,584($17)
	.set	noreorder
	.set	nomacro
	jal	UpdateTrackFinishMoney__18tTournamentManager
	sw	$0,604($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	UpdateTrackFinishPoints__18tTournamentManager
	move	$4,$17
	.set	macro
	.set	reorder

	lbu	$2,1($18)
	lw	$3,12($17)
	addu	$2,$2,-1
	bne	$3,$2,$L736
	.set	noreorder
	.set	nomacro
	jal	UpdateTournFinishMoney__18tTournamentManager
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CalcTierFinishPrize__18tTournamentManager
	move	$4,$17
	.set	macro
	.set	reorder

$L736:
	lw	$2,12($17)
	#nop
	addu	$2,$2,1
	sw	$2,12($17)
	lbu	$3,1($18)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L737
	lbu	$2,294($17)
	sw	$0,608($17)
	sltu	$2,$2,4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L738
	sw	$0,636($17)
	.set	macro
	.set	reorder

	lhu	$2,10($18)
	#nop
	andi	$2,$2,0x0001
	beq	$2,$0,$L739
	lhu	$2,584($17)
	#nop
	ori	$2,$2,0x0001
	sh	$2,584($17)
	lbu	$2,14($18)
	#nop
	sb	$2,586($17)
$L739:
	lhu	$2,10($18)
	#nop
	andi	$2,$2,0x0002
	beq	$2,$0,$L740
	lhu	$2,584($17)
	#nop
	ori	$2,$2,0x0002
	sh	$2,584($17)
	lbu	$2,15($18)
	#nop
	sw	$2,588($17)
$L740:
	lhu	$2,10($18)
	#nop
	andi	$2,$2,0x0004
	beq	$2,$0,$L741
	lhu	$2,584($17)
	#nop
	ori	$2,$2,0x0004
	sh	$2,584($17)
	lbu	$2,16($18)
	#nop
	sw	$2,592($17)
$L741:
	lhu	$2,10($18)
	#nop
	andi	$2,$2,0x0008
	beq	$2,$0,$L742
	lhu	$2,584($17)
	#nop
	ori	$2,$2,0x0008
	sh	$2,584($17)
	lbu	$2,67($18)
	#nop
	sw	$2,596($17)
$L742:
	sw	$0,624($17)
$L738:
	lbu	$2,294($17)
	#nop
	sltu	$2,$2,2
	beq	$2,$0,$L737
	lbu	$2,7($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L744
	lui	$16,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(carManager) # low
	lbu	$5,8($18)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$4,$16
	.set	macro
	.set	reorder

	li	$20,1			# 0x00000001
	sw	$20,604($17)
	lbu	$3,8($18)
	move	$19,$2
	sw	$3,616($17)
	lbu	$2,4($19)
	move	$4,$16
	sb	$2,620($17)
	lbu	$2,9($18)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	sb	$2,621($17)
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,32
	bne	$2,$0,$L744
	lw	$2,580($17)
	sw	$20,608($17)
	lw	$3,32($19)
	#nop
	addu	$2,$2,$3
	sw	$2,580($17)
	lw	$2,32($19)
	#nop
	sw	$2,612($17)
$L744:
	lhu	$2,10($18)
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L746
	lhu	$2,584($17)
	#nop
	ori	$2,$2,0x0010
	sh	$2,584($17)
	lbu	$2,68($18)
	#nop
	sw	$2,600($17)
$L746:
	sw	$0,624($17)
	lb	$2,0($18)
	li	$3,1			# 0x00000001
	addu	$2,$17,$2
	sb	$3,496($2)
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	addu	$4,$4,25
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,4($17)
	sw	$2,624($17)
	sll	$2,$3,$2
	addu	$2,$2,$3
	lw	$3,24($17)
	sll	$2,$2,2
	addu	$5,$3,$2
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	move	$4,$0
	.set	macro
	.set	reorder

	move	$6,$3
	li	$7,1			# 0x00000001
	sll	$2,$4,16
$L760:
	lbu	$3,2($5)
	sra	$2,$2,16
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$6
	lb	$2,36($2)
	#nop
	addu	$2,$17,$2
	lb	$2,496($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$7,$L759
	addu	$2,$4,1
	.set	macro
	.set	reorder

	sw	$0,624($17)
$L759:
	move	$4,$2
	sll	$2,$2,16
	lbu	$3,0($5)
	sra	$2,$2,16
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L760
	sll	$2,$4,16
	.set	macro
	.set	reorder

$L748:
	lw	$2,624($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L737
	lui	$2,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(carManager) # low
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	GetNumOwnedCars__11tCarManagers
	move	$5,$0
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lw	$3,604($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L755
	sra	$16,$2,16
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L755:
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	FECheat_ActivateBonus__F10tCheatCode
	addu	$4,$4,25
	.set	macro
	.set	reorder

	lw	$2,4($17)
	#nop
	addu	$2,$2,19
	sw	$2,632($17)
	lh	$5,632($17)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$4,$18
	.set	macro
	.set	reorder

	move	$19,$2
	move	$4,$18
	lw	$5,632($17)
	.set	noreorder
	.set	nomacro
	jal	SetCarAvailable__11tCarManager10tCarModelsb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$18
	lw	$5,632($17)
	.set	noreorder
	.set	nomacro
	jal	SetCarViewable__11tCarManager10tCarModelsb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	slt	$2,$16,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L756
	move	$4,$18
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,636($17)
	lw	$3,32($19)
	lw	$2,20($17)
	#nop
	addu	$2,$2,$3
	sw	$3,640($17)
	.set	noreorder
	.set	nomacro
	j	$L757
	sw	$2,20($17)
	.set	macro
	.set	reorder

$L756:
	lh	$5,632($17)
	lbu	$6,4($19)
	.set	noreorder
	.set	nomacro
	jal	PurchaseCar__11tCarManagersss
	move	$7,$0
	.set	macro
	.set	reorder

$L757:
	lhu	$2,4($17)
	#nop
	addu	$2,$2,985
	sh	$2,628($17)
$L737:
	lw	$2,12($17)
$L735:
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

	.end	AdvanceToNextTrack__18tTournamentManager
	.align	2
	.globl	GetLastTrackRaced__18tTournamentManager
	.ent	GetLastTrackRaced__18tTournamentManager
GetLastTrackRaced__18tTournamentManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lbu	$3,38($2)
	lw	$2,12($4)
	#nop
	addu	$3,$3,$2
	addu	$3,$3,-1
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$5,$5,$2
	lb	$2,5412($5)
	j	$31
	.end	GetLastTrackRaced__18tTournamentManager
	.align	2
	.globl	SaveTournament__18tTournamentManagerR15tSaveTournament
	.ent	SaveTournament__18tTournamentManagerR15tSaveTournament
SaveTournament__18tTournamentManagerR15tSaveTournament:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	lw	$2,20($7)
	move	$6,$0
	sw	$2,0($5)
$L763:
	sll	$4,$6,16
	addu	$3,$6,1
	move	$6,$3
	sra	$4,$4,16
	addu	$2,$7,$4
	addu	$4,$5,$4
	sll	$3,$3,16
	sra	$3,$3,16
	lbu	$2,496($2)
	slt	$3,$3,64
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L763
	sb	$2,104($4)
	.set	macro
	.set	reorder

	j	$31
	.end	SaveTournament__18tTournamentManagerR15tSaveTournament
	.align	2
	.globl	LoadTournament__18tTournamentManagerR15tSaveTournament
	.ent	LoadTournament__18tTournamentManagerR15tSaveTournament
LoadTournament__18tTournamentManagerR15tSaveTournament:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$4
	lw	$2,0($5)
	move	$6,$0
	sw	$2,20($7)
$L768:
	sll	$4,$6,16
	addu	$3,$6,1
	move	$6,$3
	sra	$4,$4,16
	addu	$2,$5,$4
	addu	$4,$7,$4
	sll	$3,$3,16
	sra	$3,$3,16
	lbu	$2,104($2)
	slt	$3,$3,64
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L768
	sb	$2,496($4)
	.set	macro
	.set	reorder

	j	$31
	.end	LoadTournament__18tTournamentManagerR15tSaveTournament
	.align	2
	.globl	GetNumCompetitors__18tTournamentManager
	.ent	GetNumCompetitors__18tTournamentManager
GetNumCompetitors__18tTournamentManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	lw	$5,24($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$5,$2
	lbu	$3,2($2)
	lw	$2,8($4)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$5
	lbu	$2,42($2)
	j	$31
	.end	GetNumCompetitors__18tTournamentManager
	.align	2
	.globl	UpdateCarLineup__18tTournamentManager
	.ent	UpdateCarLineup__18tTournamentManager
UpdateCarLineup__18tTournamentManager:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	GetNumCompetitors__18tTournamentManager
	move	$16,$4
	.set	macro
	.set	reorder

	move	$6,$0
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	blez	$2,$L773
	move	$5,$6
	.set	macro
	.set	reorder

	move	$7,$2
	sll	$2,$5,16
$L781:
	sra	$2,$2,12
	addu	$4,$16,$2
	lw	$2,288($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L780
	addu	$2,$5,1
	.set	macro
	.set	reorder

	sll	$2,$6,16
	sra	$2,$2,16
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,2
	lb	$2,285($4)
	addu	$3,$16,$3
	sltu	$2,$0,$2
	sw	$2,376($3)
	lw	$2,280($4)
	#nop
	sw	$2,380($3)
	lbu	$2,294($4)
	addu	$6,$6,1
	sb	$2,384($3)
	addu	$2,$5,1
$L780:
	move	$5,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L781
	sll	$2,$5,16
	.set	macro
	.set	reorder

$L773:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	UpdateCarLineup__18tTournamentManager
	.align	2
	.globl	GetTrackFinishPrize__18tTournamentManagers
	.ent	GetTrackFinishPrize__18tTournamentManagers
GetTrackFinishPrize__18tTournamentManagers:
	.frame	$sp,416,$31		# vars= 376, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,416
	sw	$18,400($sp)
	move	$18,$4
	sw	$17,396($sp)
	move	$17,$5
	sw	$16,392($sp)
	move	$16,$0
	addu	$3,$sp,224
	lui	$2,%hi(gTrackFinishPrizes) # high
	addiu	$2,$2,%lo(gTrackFinishPrizes) # low
	addu	$4,$2,160
	sw	$31,408($sp)
	sw	$19,404($sp)
$L783:
	lw	$8,0($2)
	lw	$9,4($2)
	lw	$10,8($2)
	lw	$11,12($2)
	sw	$8,0($3)
	sw	$9,4($3)
	sw	$10,8($3)
	sw	$11,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L783
	addu	$3,$3,16
	.set	macro
	.set	reorder

	lw	$8,0($2)
	lw	$9,4($2)
	sw	$8,0($3)
	sw	$9,4($3)
	andi	$2,$17,0xffff
	sltu	$2,$2,6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L789
	move	$2,$16
	.set	macro
	.set	reorder

	lw	$3,4($18)
	lw	$4,24($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($18)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$19,$4,$2
	lbu	$3,3($19)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L790
	sll	$4,$17,16
	.set	macro
	.set	reorder

	lui	$4,%hi(carManager) # high
	addiu	$4,$4,%lo(carManager) # low
	lui	$2,%hi(frontEnd+291) # high
	addu	$6,$sp,16
	lbu	$5,%lo(frontEnd+291)($2)
	.set	noreorder
	.set	nomacro
	jal	GetGarageCar__11tCarManagersR8tCarInfos
	move	$7,$0
	.set	macro
	.set	reorder

	lbu	$2,18($sp)
	#nop
	sltu	$2,$2,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L790
	sll	$4,$17,16
	.set	macro
	.set	reorder

	lbu	$3,212($sp)
	lw	$5,48($sp)
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L791
	andi	$2,$3,0x0002
	.set	macro
	.set	reorder

	lw	$2,52($sp)
	#nop
	addu	$5,$5,$2
	andi	$2,$3,0x0002
$L791:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L792
	andi	$2,$3,0x0004
	.set	macro
	.set	reorder

	lw	$2,56($sp)
	#nop
	addu	$5,$5,$2
	andi	$2,$3,0x0004
$L792:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	sll	$3,$17,16
	.set	macro
	.set	reorder

	lw	$2,60($sp)
	#nop
	addu	$5,$5,$2
$L793:
	lbu	$4,18($sp)
	sra	$3,$3,14
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$3,$3,$2
	addu	$2,$sp,$3
	lw	$4,224($2)
	jal	fixedmult
	addu	$16,$16,$2
	sll	$4,$17,16
$L790:
	lbu	$3,2($19)
	lw	$2,12($18)
	sra	$4,$4,14
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,3
	lw	$3,24($18)
	addu	$4,$4,$2
	addu	$3,$3,$4
	lw	$2,5420($3)
	#nop
	addu	$16,$16,$2
	move	$2,$16
$L789:
	lw	$31,408($sp)
	lw	$19,404($sp)
	lw	$18,400($sp)
	lw	$17,396($sp)
	lw	$16,392($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,416
	.set	macro
	.set	reorder

	.end	GetTrackFinishPrize__18tTournamentManagers
	.align	2
	.globl	GetTournamentFinishPrize__18tTournamentManagers
	.ent	GetTournamentFinishPrize__18tTournamentManagers
GetTournamentFinishPrize__18tTournamentManagers:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	andi	$2,$5,0xffff
	sltu	$2,$2,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L795
	move	$6,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L795:
	lw	$3,4($6)
	lw	$4,24($6)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($6)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$4,$4,$2
	sll	$2,$5,16
	sra	$2,$2,14
	addu	$4,$4,$2
	lw	$2,24($4)
	j	$31
	.end	GetTournamentFinishPrize__18tTournamentManagers
	.align	2
	.globl	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	.ent	GetAwardInformation__18tTournamentManagerR17tAwardInformation
GetAwardInformation__18tTournamentManagerR17tAwardInformation:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$2,$4,576
	addu	$4,$4,640
$L798:
	lw	$3,0($2)
	lw	$6,4($2)
	lw	$7,8($2)
	lw	$8,12($2)
	sw	$3,0($5)
	sw	$6,4($5)
	sw	$7,8($5)
	sw	$8,12($5)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L798
	addu	$5,$5,16
	.set	macro
	.set	reorder

	lw	$3,0($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,0($5)
	.set	macro
	.set	reorder

	.end	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	.align	2
	.globl	UpdateAwardInformation__18tTournamentManager
	.ent	UpdateAwardInformation__18tTournamentManager
UpdateAwardInformation__18tTournamentManager:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	li	$5,1			# 0x00000001
	addu	$6,$sp,16
	addu	$7,$sp,20
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lw	$2,20($17)
	lw	$3,16($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,20($17)
	lw	$3,20($sp)
	lw	$4,576($17)
	addu	$2,$2,$3
	sw	$2,20($17)
	addu	$2,$2,$4
	lw	$4,580($17)
	lhu	$3,584($17)
	sw	$2,20($17)
	addu	$2,$2,$4
	andi	$3,$3,0x0002
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L800
	sw	$2,20($17)
	.set	macro
	.set	reorder

	lw	$4,588($17)
	jal	FECheat_ActivateBonus__F10tCheatCode
$L800:
	lhu	$2,584($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L801
	lui	$4,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(carManager) # low
	lw	$5,592($17)
	.set	noreorder
	.set	nomacro
	jal	SetCarAvailable__11tCarManager10tCarModelsb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L801:
	lhu	$2,584($17)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L802
	lui	$4,%hi(trackManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(trackManager) # low
	lbu	$5,586($17)
	.set	noreorder
	.set	nomacro
	jal	SetTrackAvailable__13tTrackManagersb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L802:
	lhu	$2,584($17)
	#nop
	andi	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L803
	lui	$4,%hi(trackManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(trackManager) # low
	lw	$5,596($17)
	.set	noreorder
	.set	nomacro
	jal	SetClassAvailable__13tTrackManager15tTrackClassTypeb
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L803:
	lhu	$2,584($17)
	#nop
	andi	$2,$2,0x0010
	beq	$2,$0,$L804
	lw	$4,600($17)
	jal	FECheat_ActivateBonus__F10tCheatCode
$L804:
	lw	$2,604($17)
	#nop
	beq	$2,$0,$L799
	lw	$2,608($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L799
	lui	$16,%hi(carManager) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(carManager) # low
	lh	$5,616($17)
	.set	noreorder
	.set	nomacro
	jal	GetCarFromID__11tCarManagers
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	lbu	$3,620($17)
	lh	$5,616($17)
	addu	$2,$2,$3
	lb	$6,175($2)
	.set	noreorder
	.set	nomacro
	jal	PurchaseCar__11tCarManagersss
	move	$7,$0
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$2,%hi(frontEnd+291) # high
	lbu	$5,%lo(frontEnd+291)($2)
	lbu	$6,621($17)
	.set	noreorder
	.set	nomacro
	jal	PurchaseUpgrade__11tCarManagersss
	move	$7,$0
	.set	macro
	.set	reorder

$L799:
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

	.end	UpdateAwardInformation__18tTournamentManager
	.align	2
	.globl	TournPointTotal__18tTournamentManagerPs
	.ent	TournPointTotal__18tTournamentManagerPs
TournPointTotal__18tTournamentManagerPs:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($5)
	#nop
	sll	$2,$2,4
	addu	$4,$4,$2
	lhu	$2,292($4)
	j	$31
	.end	TournPointTotal__18tTournamentManagerPs
	.align	2
	.globl	PlayerRanking__18tTournamentManagers
	.ent	PlayerRanking__18tTournamentManagers
PlayerRanking__18tTournamentManagers:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	GetNumCompetitors__18tTournamentManager
	move	$16,$5
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$3,$2,16
	.set	noreorder
	.set	nomacro
	blez	$3,$L809
	move	$4,$0
	.set	macro
	.set	reorder

	sll	$2,$16,16
	sra	$6,$2,16
	move	$5,$3
	sll	$2,$4,16
$L815:
	sra	$3,$2,16
	sll	$2,$3,4
	addu	$2,$17,$2
	lbu	$2,294($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$6,$L810
	addu	$2,$4,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L814
	move	$2,$3
	.set	macro
	.set	reorder

$L810:
	move	$4,$2
	sll	$2,$2,16
	sra	$2,$2,16
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L815
	sll	$2,$4,16
	.set	macro
	.set	reorder

$L809:
	move	$2,$0
$L814:
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

	.end	PlayerRanking__18tTournamentManagers
	.align	2
	.globl	CalcTierFinishPrize__18tTournamentManager
	.ent	CalcTierFinishPrize__18tTournamentManager
CalcTierFinishPrize__18tTournamentManager:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	li	$3,7			# 0x00000007
	sll	$2,$2,1
	addu	$2,$4,$2
	sh	$3,36($2)
	lw	$2,4($4)
	#nop
	sll	$2,$2,1
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$0,44($4)
	.set	macro
	.set	reorder

	.end	CalcTierFinishPrize__18tTournamentManager
	.rdata
	.align	2
$LC3:
	.byte	83
	.byte	77
	.byte	76
	.align	2
$LC4:
	.byte	87
	.byte	71
	.byte	83
	.byte	66
	.align	2
$LC5:
	.ascii	"TR%c%02d%c\000"
	.text
	.align	2
	.globl	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	.ent	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci:
	.frame	$sp,48,$31		# vars= 16, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	move	$4,$7
	lui	$2,%hi($LC3) # high
	sw	$31,40($sp)
	addiu	$11,$2,%lo($LC3)
	lb	$8,0($11)
	lb	$9,1($11)
	lb	$10,2($11)
	sb	$8,24($sp)
	sb	$9,25($sp)
	sb	$10,26($sp)
	lui	$2,%hi(tournamentManager) # high
	lb	$3,0($5)
	addiu	$2,$2,%lo(tournamentManager) # low
	addu	$3,$3,$2
	lb	$7,496($3)
	lui	$2,%hi($LC4) # high
	addiu	$11,$2,%lo($LC4)
	lwl	$8,3($11)
	lwr	$8,0($11)
	swl	$8,35($sp)
	swr	$8,32($sp)
	lw	$3,64($sp)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L818
	addu	$2,$7,$2
	.set	macro
	.set	reorder

	sltu	$2,$2,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L819
	move	$3,$0
	.set	macro
	.set	reorder

	move	$3,$7
$L819:
	sll	$2,$3,16
	.set	noreorder
	.set	nomacro
	j	$L820
	sra	$2,$2,16
	.set	macro
	.set	reorder

$L818:
	move	$2,$3
$L820:
	addu	$3,$sp,$6
	addu	$2,$sp,$2
	lbu	$7,22($5)
	lui	$5,%hi($LC5) # high
	lbu	$2,32($2)
	lbu	$6,24($3)
	addiu	$5,$5,%lo($LC5) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
	.align	2
	.globl	ValidCar__18tTournamentManagerR8tCarInfo
	.ent	ValidCar__18tTournamentManagerR8tCarInfo
ValidCar__18tTournamentManagerR8tCarInfo:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$31,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$3,4($18)
	lw	$4,24($18)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($18)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$17,$4,$2
	lbu	$3,3($17)
	li	$2,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L822
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,2($19)
	li	$4,25			# 0x00000019
	xor	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	FECheat_IsCheatEnabled__F10tCheatCode
	sltu	$16,$2,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L822
	lw	$2,4($18)
	#nop
	bne	$2,$0,$L822
	li	$16,1			# 0x00000001
$L822:
	lhu	$2,12($17)
	#nop
	andi	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L838
	move	$2,$16
	.set	macro
	.set	reorder

	lb	$3,0($19)
	lbu	$2,18($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L825
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$3,19($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L824
	slt	$2,$3,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L836
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L827
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L838
$L836:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L830
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L832
	move	$2,$16
	.set	macro
	.set	reorder

	j	$L838
$L827:
	lbu	$2,196($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L838
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L824
	move	$16,$0
	.set	macro
	.set	reorder

$L830:
	lbu	$2,196($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L838
	move	$2,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L824
	move	$16,$0
	.set	macro
	.set	reorder

$L832:
	lbu	$2,196($19)
	lbu	$3,20($17)
	#nop
	and	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L838
	move	$2,$16
	.set	macro
	.set	reorder

$L825:
	move	$16,$0
$L824:
	move	$2,$16
$L838:
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

	.end	ValidCar__18tTournamentManagerR8tCarInfo
	.align	2
	.globl	__23tListIteratorTournamentPcP18tTournamentManager
	.ent	__23tListIteratorTournamentPcP18tTournamentManager
__23tListIteratorTournamentPcP18tTournamentManager:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	move	$2,$5
	sw	$17,20($sp)
	move	$17,$6
	move	$5,$0
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	__13tListIteratorPsPc
	move	$6,$2
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tListIteratorTournament_vtable) # high
	addiu	$3,$3,%lo(tListIteratorTournament_vtable) # low
	sw	$3,12($2)
	sw	$17,16($2)
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

	.end	__23tListIteratorTournamentPcP18tTournamentManager
	.align	2
	.globl	_._23tListIteratorTournament
	.ent	_._23tListIteratorTournament
_._23tListIteratorTournament:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(tListIteratorTournament_vtable) # high
	addiu	$2,$2,%lo(tListIteratorTournament_vtable) # low
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	_._13tListIterator
	sw	$2,12($4)
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

	.end	_._23tListIteratorTournament
	.align	2
	.globl	Value__23tListIteratorTournament7tPlayer
	.ent	Value__23tListIteratorTournament7tPlayer
Value__23tListIteratorTournament7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	lbu	$2,0($2)
	j	$31
	.end	Value__23tListIteratorTournament7tPlayer
	.align	2
	.globl	TextValue__23tListIteratorTournament7tPlayer
	.ent	TextValue__23tListIteratorTournament7tPlayer
TextValue__23tListIteratorTournament7tPlayer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+290) # high
	lbu	$3,%lo(frontEnd+290)($2)
	lw	$5,16($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	lw	$5,24($5)
	lw	$3,4($4)
	addu	$2,$5,$2
	lbu	$2,2($2)
	lbu	$3,0($3)
	#nop
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$5,$5,$2
	lb	$2,36($5)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,833
	.set	macro
	.set	reorder

	.end	TextValue__23tListIteratorTournament7tPlayer
	.align	2
	.globl	Increment__23tListIteratorTournament7tPlayer
	.ent	Increment__23tListIteratorTournament7tPlayer
Increment__23tListIteratorTournament7tPlayer:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+290) # high
	lbu	$3,%lo(frontEnd+290)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,16($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,24($4)
	sll	$2,$2,2
	addu	$17,$3,$2
$L846:
	lw	$3,4($16)
	#nop
	lbu	$2,0($3)
	#nop
	addu	$2,$2,1
	sb	$2,0($3)
	lw	$4,4($16)
	lbu	$3,0($17)
	lbu	$2,0($4)
	#nop
	sltu	$2,$2,$3
	bne	$2,$0,$L849
	sb	$0,0($4)
$L849:
	lw	$2,4($16)
	#nop
	lbu	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	ValidTournament__23tListIteratorTournamentc
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	bne	$2,$0,$L846
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

	.end	Increment__23tListIteratorTournament7tPlayer
	.align	2
	.globl	Decrement__23tListIteratorTournament7tPlayer
	.ent	Decrement__23tListIteratorTournament7tPlayer
Decrement__23tListIteratorTournament7tPlayer:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+290) # high
	lbu	$3,%lo(frontEnd+290)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$4,16($16)
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$3,24($4)
	sll	$2,$2,2
	addu	$17,$3,$2
$L852:
	lw	$3,4($16)
	#nop
	lbu	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L857
	addu	$2,$2,-1
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	#nop
	addu	$2,$2,-1
$L857:
	sb	$2,0($3)
	lw	$2,4($16)
	#nop
	lbu	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	ValidTournament__23tListIteratorTournamentc
	move	$4,$16
	.set	macro
	.set	reorder

	xori	$2,$2,0x0001
	bne	$2,$0,$L852
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

	.end	Decrement__23tListIteratorTournament7tPlayer
	.align	2
	.globl	ValidTournament__23tListIteratorTournamentc
	.ent	ValidTournament__23tListIteratorTournamentc
ValidTournament__23tListIteratorTournamentc:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(frontEnd+290) # high
	lbu	$3,%lo(frontEnd+290)($2)
	lw	$6,16($4)
	sll	$2,$3,1
	addu	$2,$2,$3
	lw	$4,24($6)
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	andi	$5,$5,0x00ff
	addu	$3,$3,$5
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$4,$4,$2
	lhu	$5,12($4)
	li	$3,1			# 0x00000001
	and	$2,$5,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L861
	andi	$2,$5,0x0002
	.set	macro
	.set	reorder

	lbu	$2,17($4)
	#nop
	addu	$2,$6,$2
	lb	$2,496($2)
	#nop
	slt	$3,$2,4
	andi	$2,$5,0x0002
$L861:
	beq	$2,$0,$L860
	lbu	$2,17($4)
	#nop
	addu	$2,$6,$2
	lb	$2,496($2)
	#nop
	slt	$2,$2,2
	bne	$2,$0,$L860
	move	$3,$0
$L860:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

	.end	ValidTournament__23tListIteratorTournamentc
	.globl	gTrackFinishBill
	.data
	.align	2
gTrackFinishBill:
	.space	4
	.globl	gTrackFinishBonus
	.align	2
gTrackFinishBonus:
	.space	4
	.globl	gTrackFinishPrizes
	.align	2
gTrackFinishPrizes:
	.space	256

	.lcomm	retbill,4

	.lcomm	retbonus,4
