	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\screenpost.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	screenTournamentStandings
	.data
	.align	2
screenTournamentStandings:
	.word	0
	.globl	screenTournamentStandings3item
	.align	2
screenTournamentStandings3item:
	.word	0
	.globl	screenPinkSlipStandings
	.align	2
screenPinkSlipStandings:
	.word	0
	.text
	.align	2
	.globl	DrawMoney__Fiiilii
	.ent	DrawMoney__Fiiilii
DrawMoney__Fiiilii:
	.frame	$sp,160,$31		# vars= 112, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,160
	sw	$17,140($sp)
	move	$17,$4
	sw	$19,148($sp)
	move	$19,$5
	sw	$18,144($sp)
	move	$18,$7
	li	$2,6			# 0x00000006
	sw	$31,152($sp)
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L603
	sw	$16,136($sp)
	.set	macro
	.set	reorder

	slt	$2,$6,7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L607
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L602
	addu	$16,$sp,80
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L610
	move	$4,$16
	.set	macro
	.set	reorder

$L607:
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L604
	addu	$16,$sp,80
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L610
	move	$4,$16
	.set	macro
	.set	reorder

$L602:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,134			# 0x00000086
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L609
	addu	$16,$sp,80
	.set	macro
	.set	reorder

$L603:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,135			# 0x00000087
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$2
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L609
	addu	$16,$sp,80
	.set	macro
	.set	reorder

$L604:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,136			# 0x00000088
	.set	macro
	.set	reorder

	sw	$0,16($sp)
	addu	$4,$sp,24
	move	$5,$2
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$6
	.set	macro
	.set	reorder

	addu	$16,$sp,80
$L609:
	move	$4,$16
$L610:
	.set	noreorder
	.set	nomacro
	jal	FeTools_FormatMoney__FPcl
	move	$5,$18
	.set	macro
	.set	reorder

	move	$4,$16
	sll	$17,$17,16
	sra	$17,$17,16
	move	$5,$17
	sll	$16,$19,16
	sra	$16,$16,16
	move	$6,$16
	lw	$7,176($sp)
	li	$18,1			# 0x00000001
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	move	$5,$17
	lw	$7,180($sp)
	move	$6,$16
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextRGB__FPcssics
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	lw	$31,152($sp)
	lw	$19,148($sp)
	lw	$18,144($sp)
	lw	$17,140($sp)
	lw	$16,136($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	DrawMoney__Fiiilii
	.align	2
	.globl	__26tScreenTournamentStandings
	.ent	__26tScreenTournamentStandings
__26tScreenTournamentStandings:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	__7tScreen
	move	$16,$4
	.set	macro
	.set	reorder

	move	$2,$16
	lui	$3,%hi(tScreenTournamentStandings_vtable) # high
	addiu	$3,$3,%lo(tScreenTournamentStandings_vtable) # low
	sw	$3,96($2)
	sw	$0,132($2)
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__26tScreenTournamentStandings
	.align	2
	.globl	Initialize__26tScreenTournamentStandings
	.ent	Initialize__26tScreenTournamentStandings
Initialize__26tScreenTournamentStandings:
	.frame	$sp,104,$31		# vars= 72, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	sw	$16,88($sp)
	move	$16,$4
	sw	$31,96($sp)
	.set	noreorder
	.set	nomacro
	jal	Initialize__7tScreen
	sw	$17,92($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(tournamentManager) # high
	addiu	$17,$2,%lo(tournamentManager) # low
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	GetAwardInformation__18tTournamentManagerR17tAwardInformation
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$2,132($16)
	sw	$0,120($16)
	sw	$0,124($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L614
	sw	$0,128($16)
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,120($16)
$L615:
	lw	$2,20($17)
	lw	$3,20($sp)
	#nop
	subu	$3,$2,$3
	sw	$3,100($16)
	lw	$2,76($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L623
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,80($sp)
	#nop
	subu	$2,$3,$2
	sw	$2,100($16)
$L623:
	move	$5,$0
	addu	$6,$16,108
	lw	$2,16($sp)
	addu	$7,$16,112
	.set	noreorder
	.set	nomacro
	jal	CalcTrackFinishDamageBill__18tTournamentManagerbRlT2
	sw	$2,104($16)
	.set	macro
	.set	reorder

	lw	$2,112($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L617
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,124($16)
$L617:
	lw	$2,108($16)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L618
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,128($16)
$L618:
	lw	$2,112($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	sw	$0,136($16)
	.set	macro
	.set	reorder

	lw	$2,108($16)
	#nop
	bne	$2,$0,$L619
	lw	$2,104($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L619
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,136($16)
$L619:
	lw	$4,112($16)
	sw	$0,140($16)
	lw	$3,16($sp)
	#nop
	slt	$2,$4,$3
	beq	$2,$0,$L620
	move	$4,$3
$L620:
	lw	$3,108($16)
	#nop
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	li	$2,715784192			# 0x2aaa0000
	.set	macro
	.set	reorder

	move	$3,$4
$L624:
	ori	$2,$2,0xaaab
	mult	$3,$2
	sra	$3,$3,31
	mfhi	$8
	#nop
	#nop
	sra	$2,$8,2
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L622
	sw	$2,144($16)
	.set	macro
	.set	reorder

$L614:
	lw	$2,20($17)
	lw	$3,20($sp)
	#nop
	subu	$2,$2,$3
	sw	$2,100($16)
$L622:
	lui	$2,%hi(ticks) # high
	lw	$2,%lo(ticks)($2)
	#nop
	sw	$2,116($16)
	lw	$31,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	Initialize__26tScreenTournamentStandings
	.align	2
	.globl	Cleanup__26tScreenTournamentStandings
	.ent	Cleanup__26tScreenTournamentStandings
Cleanup__26tScreenTournamentStandings:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Cleanup__7tScreen
	sw	$0,132($4)
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

	.end	Cleanup__26tScreenTournamentStandings
	.rdata
	.align	2
$LC0:
	.ascii	"zTrnSt1\000"
	.text
	.align	2
	.globl	GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3
	.ent	GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3
GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$0,0($6)
	sw	$0,0($2)
	li	$2,41			# 0x00000029
	sh	$2,0($5)
	lui	$2,%hi($LC0) # high
	addiu	$2,$2,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3
	.rdata
	.align	2
$LC1:
	.ascii	"zTrnStd\000"
	.text
	.align	2
	.globl	GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3
	.ent	GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3
GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,16($sp)
	sh	$0,0($6)
	sw	$0,0($2)
	li	$2,41			# 0x00000029
	sh	$2,0($5)
	lui	$2,%hi($LC1) # high
	addiu	$2,$2,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,0($7)
	.set	macro
	.set	reorder

	.end	GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3
	.align	2
	.globl	ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,0($6)
	li	$2,2			# 0x00000002
	bne	$3,$2,$L631
	lw	$2,136($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L631
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,0($6)
	sw	$2,140($4)
$L631:
	j	$31
	.end	ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
	.rdata
	.align	2
$LC2:
	.ascii	"%d %s\000"
	.text
	.align	2
	.globl	DrawBackground__26tScreenTournamentStandings
	.ent	DrawBackground__26tScreenTournamentStandings
DrawBackground__26tScreenTournamentStandings:
	.frame	$sp,248,$31		# vars= 176, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,248
	sw	$23,236($sp)
	move	$23,$4
	sw	$20,224($sp)
	move	$20,$0
	lui	$9,%hi(tournamentManager) # high
	addiu	$2,$9,%lo(tournamentManager) # low
	addiu	$9,$9,%lo(tournamentManager) # low
	sw	$31,244($sp)
	sw	$fp,240($sp)
	sw	$22,232($sp)
	sw	$21,228($sp)
	sw	$19,220($sp)
	sw	$18,216($sp)
	sw	$17,212($sp)
	sw	$16,208($sp)
	lw	$3,4($2)
	lw	$4,24($9)
	lh	$fp,92($23)
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$4,$2
	lbu	$3,2($2)
	lw	$2,8($9)
	li	$22,766			# 0x000002fe
	sw	$fp,188($sp)
	addu	$3,$3,$2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,36
	addu	$4,$4,$2
	sw	$4,192($sp)
	lbu	$3,5($4)
	lh	$2,16($9)
	sltu	$3,$20,$3
	addu	$2,$2,$3
	sll	$2,$2,16
	sra	$2,$2,16
	addu	$9,$2,-1
	sw	$2,196($sp)
	sw	$9,200($sp)
$L633:
	lw	$9,196($sp)
	#nop
	slt	$2,$20,$9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	lui	$9,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

	addiu	$4,$9,%lo(tournamentManager) # low
	addu	$5,$20,1
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	PlayerRanking__18tTournamentManagers
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$19,$2,16
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L637
	li	$21,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$21,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L638
	move	$18,$21
	.set	macro
	.set	reorder

$L637:
	move	$18,$0
$L638:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$20,599
	.set	macro
	.set	reorder

	li	$4,759			# 0x000002f7
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$22
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$17
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$9,11			# 0x0000000b
	sw	$9,16($sp)
	sw	$18,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L639
	sll	$2,$19,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L664
	move	$17,$2
	.set	macro
	.set	reorder

$L639:
	lui	$9,%hi(tournamentManager) # high
	addiu	$9,$9,%lo(tournamentManager) # low
	addu	$2,$2,$9
	lw	$4,280($2)
	jal	Stattool_GetAINameFromPersonality__F14tPersonalities
	move	$17,$2
$L664:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,760			# 0x000002f8
	.set	macro
	.set	reorder

	move	$4,$22
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$17
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$9,11			# 0x0000000b
	sw	$9,16($sp)
	sw	$21,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$0,24($sp)
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	lw	$9,192($sp)
	sh	$19,184($sp)
	lbu	$2,5($9)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	lui	$9,%hi(tournamentManager) # high
	.set	macro
	.set	reorder

	lw	$9,200($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$9,$L642
	li	$4,795			# 0x0000031b
	.set	macro
	.set	reorder

	li	$4,796			# 0x0000031c
$L642:
	jal	TextSys_Word__Fi
	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	j	$L644
$L641:
	addiu	$4,$9,%lo(tournamentManager) # low
	.set	noreorder
	.set	nomacro
	jal	TournPointTotal__18tTournamentManagerPs
	addu	$5,$sp,184
	.set	macro
	.set	reorder

	li	$4,797			# 0x0000031d
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$2
	.set	macro
	.set	reorder

$L644:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	move	$4,$22
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	addu	$5,$sp,32
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$9,11			# 0x0000000b
	li	$2,1			# 0x00000001
	sw	$9,16($sp)
	sw	$21,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$22,$22,1
	.set	noreorder
	.set	nomacro
	j	$L633
	addu	$20,$20,1
	.set	macro
	.set	reorder

$L634:
	jal	Front_GetTrackRaced__Fv
	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	sll	$2,$2,16
	sra	$5,$2,16
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,112
	.set	macro
	.set	reorder

	jal	Front_GetTrackRaced__Fv
	sll	$2,$2,16
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	addu	$4,$2,213
	.set	macro
	.set	reorder

	li	$4,758			# 0x000002f6
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,765			# 0x000002fd
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$17
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$2,11			# 0x0000000b
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(frontEnd+290) # high
	lbu	$2,%lo(frontEnd+290)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	lui	$2,%hi(menuDefs) # high
	.set	macro
	.set	reorder

	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	j	$L663
	addu	$4,$4,1932
	.set	macro
	.set	reorder

$L645:
	lw	$4,%lo(menuDefs)($2)
	li	$5,-1			# 0xffffffff
	addu	$4,$4,1704
$L663:
	.set	noreorder
	.set	nomacro
	jal	TextValue__23tListIteratorTournament7tPlayer
	lui	$21,%hi(ticks) # high
	.set	macro
	.set	reorder

	sll	$2,$2,16
	sra	$20,$2,16
	addu	$20,$20,19
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,758			# 0x000002f6
	.set	macro
	.set	reorder

	li	$4,764			# 0x000002fc
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	sll	$5,$20,16
	sra	$5,$5,16
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	sw	$2,20($sp)
	li	$2,11			# 0x0000000b
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,758			# 0x000002f6
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,764			# 0x000002fc
	sra	$3,$17,1
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	subu	$16,$2,$3
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$16
	addu	$6,$2,-1
	move	$7,$17
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gCurrentShapes) # high
	lw	$4,%lo(gCurrentShapes)($2)
	#nop
	addu	$4,$4,1248
	lhu	$3,16($4)
	lw	$2,%lo(ticks)($21)
	sll	$3,$3,16
	sra	$5,$3,16
	rem	$16,$2,$5
	lh	$4,20($4)
	sra	$2,$3,17
	addu	$2,$2,-2
	srl	$3,$3,31
	addu	$3,$5,$3
	sra	$3,$3,1
	slt	$3,$3,$16
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L647
	subu	$18,$2,$4
	.set	macro
	.set	reorder

	subu	$16,$5,$16
$L647:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	li	$4,764			# 0x000002fc
	.set	macro
	.set	reorder

	li	$4,40			# 0x00000028
	move	$5,$0
	addu	$6,$18,$16
	addu	$7,$2,1
	lh	$2,92($23)
	li	$17,1			# 0x00000001
	sw	$17,20($sp)
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
	li	$4,764			# 0x000002fc
	.set	macro
	.set	reorder

	li	$4,40			# 0x00000028
	move	$5,$0
	subu	$6,$18,$16
	lh	$3,92($23)
	addu	$7,$2,$17
	sw	$17,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	li	$2,2621440			# 0x00280000
	ori	$2,$2,0x2828
	li	$4,39			# 0x00000027
	li	$5,1024			# 0x00000400
	move	$6,$0
	li	$7,-1			# 0xffffffff
	sw	$2,164($sp)
	lh	$3,92($23)
	addu	$2,$sp,160
	sw	$0,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,758			# 0x000002f6
	.set	macro
	.set	reorder

	li	$4,765			# 0x000002fd
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	addu	$16,$2,-150
	.set	macro
	.set	reorder

	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	move	$5,$16
	addu	$6,$2,10
	li	$7,300			# 0x0000012c
	lw	$9,188($sp)
	li	$2,3			# 0x00000003
	sw	$2,20($sp)
	li	$2,30			# 0x0000001e
	sw	$17,16($sp)
	sw	$2,28($sp)
	.set	noreorder
	.set	nomacro
	jal	PSXDrawBrightEndLine__Fiiiiiiii
	sw	$9,24($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(kRGBVals) # high
	lui	$2,%hi(textDefinitions+71) # high
	lbu	$2,%lo(textDefinitions+71)($2)
	addiu	$3,$3,%lo(kRGBVals) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$5,$fp
	.set	macro
	.set	reorder

	li	$4,2293760			# 0x00230000
	ori	$4,$4,0x2323
	move	$5,$fp
	.set	noreorder
	.set	nomacro
	jal	CalcFadeVal__Fii
	move	$19,$2
	.set	macro
	.set	reorder

	move	$20,$17
	lw	$3,%lo(ticks)($21)
	lw	$4,116($23)
	#nop
	subu	$3,$3,$4
	slt	$3,$3,1001
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L649
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$2,140($23)
	#nop
	beq	$2,$0,$L648
$L649:
	lw	$2,104($23)
	#nop
	bgtz	$2,$L651
	lw	$2,108($23)
	#nop
	bgtz	$2,$L651
	lw	$2,112($23)
	#nop
	blez	$2,$L650
$L651:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_PlayFESFX__Fi
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

$L650:
	lw	$2,104($23)
	lw	$3,144($23)
	#nop
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L648
	sw	$2,104($23)
	.set	macro
	.set	reorder

	lw	$2,108($23)
	sw	$0,104($23)
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L648
	sw	$2,108($23)
	.set	macro
	.set	reorder

	lw	$4,112($23)
	li	$2,1			# 0x00000001
	sw	$2,136($23)
	subu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	bgez	$4,$L654
	sw	$0,108($23)
	.set	macro
	.set	reorder

	move	$4,$0
$L654:
	sw	$4,112($23)
$L648:
	lw	$2,132($23)
	#nop
	beq	$2,$0,$L655
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,786			# 0x00000312
	.set	macro
	.set	reorder

	li	$4,762			# 0x000002fa
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,786			# 0x00000312
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$2,16
	.set	macro
	.set	reorder

	li	$3,11			# 0x0000000b
	sll	$2,$2,16
	sw	$3,16($sp)
	lw	$3,120($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L656
	sra	$7,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L657
	sw	$20,20($sp)
	.set	macro
	.set	reorder

$L656:
	sw	$0,20($sp)
$L657:
	move	$4,$fp
	move	$5,$17
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$20,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	li	$4,786			# 0x00000312
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	sw	$19,16($sp)
	sw	$18,20($sp)
	lw	$7,104($23)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,787			# 0x00000313
	.set	macro
	.set	reorder

	li	$4,762			# 0x000002fa
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,787			# 0x00000313
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$2,16
	.set	macro
	.set	reorder

	li	$3,11			# 0x0000000b
	sll	$2,$2,16
	sw	$3,16($sp)
	lw	$3,128($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L658
	sra	$7,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L659
	sw	$20,20($sp)
	.set	macro
	.set	reorder

$L658:
	sw	$0,20($sp)
$L659:
	move	$4,$fp
	move	$5,$17
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$20,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	li	$4,787			# 0x00000313
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	sw	$19,16($sp)
	sw	$18,20($sp)
	lw	$7,108($23)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,788			# 0x00000314
	.set	macro
	.set	reorder

	li	$4,762			# 0x000002fa
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,788			# 0x00000314
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$2,16
	.set	macro
	.set	reorder

	li	$3,11			# 0x0000000b
	sll	$2,$2,16
	sw	$3,16($sp)
	lw	$3,124($23)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L660
	sra	$7,$2,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L661
	sw	$20,20($sp)
	.set	macro
	.set	reorder

$L660:
	sw	$0,20($sp)
$L661:
	move	$4,$fp
	move	$5,$17
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$20,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	li	$4,788			# 0x00000314
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	sw	$19,16($sp)
	sw	$18,20($sp)
	lw	$7,112($23)
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

$L655:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,789			# 0x00000315
	.set	macro
	.set	reorder

	li	$4,762			# 0x000002fa
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,789			# 0x00000315
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$fp
	move	$5,$17
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$2,11			# 0x0000000b
	sw	$2,16($sp)
	li	$2,2			# 0x00000002
	sw	$2,20($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	li	$4,789			# 0x00000315
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	move	$16,$2
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	lw	$7,100($23)
	lw	$2,104($23)
	lw	$3,108($23)
	lw	$8,112($23)
	li	$6,9			# 0x00000009
	sw	$19,16($sp)
	sw	$18,20($sp)
	subu	$7,$7,$2
	addu	$7,$7,$3
	.set	noreorder
	.set	nomacro
	jal	DrawMoney__Fiiilii
	subu	$7,$7,$8
	.set	macro
	.set	reorder

	move	$4,$23
	li	$5,10			# 0x0000000a
	lui	$2,%hi(gCurrentShapes) # high
	lw	$7,%lo(gCurrentShapes)($2)
	li	$6,29			# 0x0000001d
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,244($sp)
	lw	$fp,240($sp)
	lw	$23,236($sp)
	lw	$22,232($sp)
	lw	$21,228($sp)
	lw	$20,224($sp)
	lw	$19,220($sp)
	lw	$18,216($sp)
	lw	$17,212($sp)
	lw	$16,208($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,248
	.set	macro
	.set	reorder

	.end	DrawBackground__26tScreenTournamentStandings
	.align	2
	.globl	DrawBackground__24tScreenPinkSlipStandings
	.ent	DrawBackground__24tScreenPinkSlipStandings
DrawBackground__24tScreenPinkSlipStandings:
	.frame	$sp,208,$31		# vars= 136, regs= 10/0, args= 32, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$fp,200($sp)
	move	$fp,$4
	sw	$22,192($sp)
	li	$22,11			# 0x0000000b
	sw	$18,176($sp)
	move	$18,$0
	lui	$2,%hi(frontEnd) # high
	sw	$19,180($sp)
	addiu	$19,$2,%lo(frontEnd) # low
	sw	$17,172($sp)
	li	$17,766			# 0x000002fe
	sw	$31,204($sp)
	sw	$23,196($sp)
	sw	$21,188($sp)
	sw	$20,184($sp)
	sw	$16,168($sp)
	lh	$21,92($fp)
$L666:
	lbu	$2,71($19)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	li	$20,2			# 0x00000002
	.set	macro
	.set	reorder

	lbu	$2,70($19)
	#nop
	beq	$18,$2,$L670
	slt	$20,$18,$2
$L670:
	lui	$4,%hi(trackManager) # high
	addiu	$4,$4,%lo(trackManager) # low
	addu	$2,$18,$19
	lbu	$5,35($2)
	.set	noreorder
	.set	nomacro
	jal	GetTrack__13tTrackManagersR17tTrackInformation
	addu	$6,$sp,88
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,759			# 0x000002f7
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$6,$16
	sll	$2,$2,16
	lh	$4,92($fp)
	lbu	$5,88($sp)
	sra	$7,$2,16
	sw	$0,16($sp)
	sw	$20,20($sp)
	sw	$22,24($sp)
	sll	$5,$5,24
	sra	$5,$5,24
	addu	$5,$5,213
	sll	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sra	$5,$5,16
	.set	macro
	.set	reorder

	sll	$2,$18,1
	addu	$2,$2,$19
	lh	$4,12($2)
	li	$2,-1			# 0xffffffff
	bne	$4,$2,$L671
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,781			# 0x0000030d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L681
	addu	$4,$sp,136
	.set	macro
	.set	reorder

$L671:
	jal	PlayerName__Fi
	addu	$4,$sp,136
$L681:
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	move	$4,$17
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$5,$sp,136
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$2,1			# 0x00000001
	sw	$22,16($sp)
	sw	$20,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	j	$L666
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L667:
	move	$18,$0
	li	$23,1			# 0x00000001
	li	$19,787			# 0x00000313
$L673:
	.set	noreorder
	.set	nomacro
	jal	PlayerName__Fi
	move	$4,$18
	.set	macro
	.set	reorder

	li	$4,760			# 0x000002f8
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	move	$4,$19
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$17
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	sw	$22,16($sp)
	sw	$20,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$0,24($sp)
	.set	macro
	.set	reorder

	lui	$8,%hi(frontEnd) # high
	addiu	$8,$8,%lo(frontEnd) # low
	addu	$16,$18,$8
	lbu	$2,72($16)
	#nop
	bne	$2,$23,$L676
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,799			# 0x0000031f
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

	j	$L677
$L676:
	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,798			# 0x0000031e
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	lbu	$6,72($16)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$5,$2
	.set	macro
	.set	reorder

$L677:
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,763			# 0x000002fb
	.set	macro
	.set	reorder

	move	$4,$19
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$21
	addu	$5,$sp,32
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	sw	$22,16($sp)
	sw	$20,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
	sw	$23,24($sp)
	.set	macro
	.set	reorder

	addu	$18,$18,1
	slt	$2,$18,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L673
	addu	$19,$19,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	li	$4,758			# 0x000002f6
	.set	macro
	.set	reorder

	li	$4,764			# 0x000002fc
	sll	$16,$2,16
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sra	$16,$16,16
	.set	macro
	.set	reorder

	move	$4,$21
	li	$5,705			# 0x000002c1
	move	$6,$16
	sll	$2,$2,16
	sra	$7,$2,16
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	sw	$2,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
	sw	$22,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	TextSys_Word__Fi
	li	$4,705			# 0x000002c1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	move	$4,$2
	.set	macro
	.set	reorder

	li	$4,758			# 0x000002f6
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordX__Fi
	move	$17,$2
	.set	macro
	.set	reorder

	li	$4,764			# 0x000002fc
	sra	$3,$17,1
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	subu	$16,$2,$3
	.set	macro
	.set	reorder

	move	$4,$0
	move	$5,$16
	addu	$6,$2,-1
	move	$7,$17
	li	$2,9			# 0x00000009
	.set	noreorder
	.set	nomacro
	jal	PSXDrawSquare__Fiiiii
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lui	$19,%hi(gCurrentShapes) # high
	lw	$4,%lo(gCurrentShapes)($19)
	lui	$2,%hi(ticks) # high
	addu	$4,$4,1248
	lhu	$3,16($4)
	lw	$2,%lo(ticks)($2)
	sll	$3,$3,16
	sra	$5,$3,16
	rem	$17,$2,$5
	lh	$4,20($4)
	sra	$2,$3,17
	addu	$2,$2,-2
	srl	$3,$3,31
	addu	$3,$5,$3
	sra	$3,$3,1
	slt	$3,$3,$17
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L679
	subu	$18,$2,$4
	.set	macro
	.set	reorder

	subu	$17,$5,$17
$L679:
	li	$2,2621440			# 0x00280000
	ori	$2,$2,0x2828
	li	$4,764			# 0x000002fc
	.set	noreorder
	.set	nomacro
	jal	TextSys_WordY__Fi
	sw	$2,92($sp)
	.set	macro
	.set	reorder

	li	$4,40			# 0x00000028
	move	$5,$0
	addu	$6,$18,$17
	addu	$7,$2,1
	lh	$2,92($fp)
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
	li	$4,764			# 0x000002fc
	.set	macro
	.set	reorder

	li	$4,40			# 0x00000028
	move	$5,$0
	subu	$6,$18,$17
	lh	$3,92($fp)
	addu	$7,$2,$16
	sw	$16,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	li	$4,39			# 0x00000027
	li	$5,1024			# 0x00000400
	move	$6,$0
	li	$7,-1			# 0xffffffff
	lh	$3,92($fp)
	addu	$2,$sp,88
	sw	$0,20($sp)
	sw	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
	sw	$3,16($sp)
	.set	macro
	.set	reorder

	move	$4,$fp
	li	$5,10			# 0x0000000a
	lw	$7,%lo(gCurrentShapes)($19)
	li	$6,29			# 0x0000001d
	.set	noreorder
	.set	nomacro
	jal	DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,204($sp)
	lw	$fp,200($sp)
	lw	$23,196($sp)
	lw	$22,192($sp)
	lw	$21,188($sp)
	lw	$20,184($sp)
	lw	$19,180($sp)
	lw	$18,176($sp)
	lw	$17,172($sp)
	lw	$16,168($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	DrawBackground__24tScreenPinkSlipStandings
	.align	2
	.globl	ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
	.ent	ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	tScreen_ProcessInput__FP7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand
	.align	2
	.globl	___24tScreenPinkSlipStandings
	.ent	___24tScreenPinkSlipStandings
___24tScreenPinkSlipStandings:
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

	.end	___24tScreenPinkSlipStandings
	.align	2
	.globl	___31tScreenTournamentStandings3item
	.ent	___31tScreenTournamentStandings3item
___31tScreenTournamentStandings3item:
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

	.end	___31tScreenTournamentStandings3item
	.align	2
	.globl	___26tScreenTournamentStandings
	.ent	___26tScreenTournamentStandings
___26tScreenTournamentStandings:
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

	.end	___26tScreenTournamentStandings
