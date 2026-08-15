	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\common\\\\feaudio.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.globl	gCurrentVIV
	.data
gCurrentVIV:
	.byte	-1
	.globl	allLanguages
	.rdata
	.align	2
$LC0:
	.ascii	"zEngl\000"
	.align	2
$LC1:
	.ascii	"zGerm\000"
	.align	2
$LC2:
	.ascii	"zFren\000"
	.align	2
$LC3:
	.ascii	"zSpan\000"
	.align	2
$LC4:
	.ascii	"zItal\000"
	.align	2
$LC5:
	.ascii	"zSwed\000"
	.data
	.align	2
allLanguages:
	.word	$LC0
	.word	$LC1
	.word	$LC2
	.word	$LC3
	.word	$LC4
	.word	$LC5
	.rdata
	.align	2
$LC6:
	.ascii	"\000"
	.text
	.align	2
	.globl	FEAudio_StartLoadPatch__FP10SPEECHINFO
	.ent	FEAudio_StartLoadPatch__FP10SPEECHINFO
FEAudio_StartLoadPatch__FP10SPEECHINFO:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,24($sp)
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	asyncidle
	move	$16,$4
	.set	macro
	.set	reorder

	move	$5,$16
	addu	$6,$sp,16
	lui	$2,%hi(speechfileHeader) # high
	lw	$4,%lo(speechfileHeader)($2)
	.set	noreorder
	.set	nomacro
	jal	FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
	addu	$7,$sp,20
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L604
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,24($16)
	#nop
	beq	$4,$0,$L603
	jal	purgememadr
	sw	$0,24($16)
$L603:
	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	lw	$5,16($sp)
	lw	$6,20($sp)
	.set	noreorder
	.set	nomacro
	jal	FeAudio_StartBigfileRead__FPciiPi
	addu	$7,$16,32
	.set	macro
	.set	reorder

	sw	$2,24($16)
	li	$2,1			# 0x00000001
	move	$3,$2
	sb	$3,16($16)
	sb	$0,18($16)
$L604:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FEAudio_StartLoadPatch__FP10SPEECHINFO
	.align	2
	.globl	Feaudio_StartPatch__FP10SPEECHINFO
	.ent	Feaudio_StartPatch__FP10SPEECHINFO
Feaudio_StartPatch__FP10SPEECHINFO:
	.frame	$sp,48,$31		# vars= 24, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,40($sp)
	move	$16,$4
	sw	$31,44($sp)
	lw	$5,24($16)
	#nop
	beq	$5,$0,$L606
	.set	noreorder
	.set	nomacro
	jal	SNDbankadd
	addu	$4,$16,8
	.set	macro
	.set	reorder

	li	$3,7			# 0x00000007
	bne	$2,$3,$L608
	lw	$4,8($16)
	jal	SNDbankheadersize
	lui	$4,%hi(bigBuf+260) # high
	addiu	$4,$4,%lo(bigBuf+260) # low
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	lw	$5,8($16)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	SNDbankheadercopy
	sw	$4,20($16)
	.set	macro
	.set	reorder

	lw	$4,24($16)
	#nop
	beq	$4,$0,$L610
	jal	purgememadr
	.set	noreorder
	.set	nomacro
	j	$L610
	sw	$0,24($16)
	.set	macro
	.set	reorder

$L608:
	lw	$2,24($16)
	sw	$0,24($16)
	sw	$2,28($16)
$L610:
	.set	noreorder
	.set	nomacro
	jal	SNDplaysetdef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lui	$2,%hi(commentaryActualLevel) # high
	lbu	$3,8($16)
	lbu	$2,%lo(commentaryActualLevel)($2)
	addu	$4,$sp,16
	sw	$0,16($sp)
	sb	$3,20($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDplay
	sb	$2,24($sp)
	.set	macro
	.set	reorder

	lw	$3,4($16)
	sw	$2,12($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L606
	sb	$2,17($16)
	.set	macro
	.set	reorder

	lbu	$2,2($16)
	#nop
	sltu	$2,$2,122
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L612
	lui	$2,%hi(gCurrentVIV) # high
	.set	macro
	.set	reorder

	lbu	$3,%lo(gCurrentVIV)($2)
	#nop
	addu	$3,$3,1
	sb	$3,%lo(gCurrentVIV)($2)
	lbu	$2,2($16)
	move	$4,$16
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	jal	FEAudio_StartLoadPatch__FP10SPEECHINFO
	sb	$2,2($4)
	.set	macro
	.set	reorder

	j	$L606
$L612:
	sb	$0,16($16)
	sb	$0,18($16)
$L606:
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	Feaudio_StartPatch__FP10SPEECHINFO
	.align	2
	.globl	FeAudio_systemtask__Fi
	.ent	FeAudio_systemtask__Fi
FeAudio_systemtask__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	systemtask
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(ginfo) # high
	addiu	$16,$2,%lo(ginfo) # low
	lbu	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L634
	lui	$2,%hi(ginfo) # high
	.set	macro
	.set	reorder

	lw	$4,32($16)
	jal	getasyncreadstatus
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L615
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$0,16($16)
	sb	$2,18($16)
$L615:
	lui	$2,%hi(ginfo) # high
$L634:
	addiu	$16,$2,%lo(ginfo) # low
	lbu	$2,17($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	lui	$2,%hi(gStopCommentaryNow) # high
	.set	macro
	.set	reorder

	lw	$4,12($16)
	jal	SNDover
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L616
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	SNDautovol
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,8($16)
	jal	SNDbankremove
	lw	$4,28($16)
	#nop
	beq	$4,$0,$L617
	jal	purgememadr
	sw	$0,28($16)
$L617:
	lw	$4,20($16)
	#nop
	beq	$4,$0,$L618
	jal	purgememadr
	sw	$0,20($16)
$L618:
	lbu	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	li	$2,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

$L620:
	lw	$4,32($16)
	jal	getasyncreadstatus
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L621
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L620
$L621:
	sb	$0,16($16)
	sb	$2,18($16)
	li	$2,16711680			# 0x00ff0000
$L636:
	lui	$3,%hi(ginfo) # high
	addiu	$3,$3,%lo(ginfo) # low
	sb	$0,17($3)
	lw	$4,16($3)
	ori	$2,$2,0x00ff
	and	$4,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L616
	sw	$0,8($3)
	.set	macro
	.set	reorder

	lui	$3,%hi(gStopCommentaryNow) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(gStopCommentaryNow)($3)
$L616:
	lui	$2,%hi(gStopCommentaryNow) # high
$L635:
	lw	$2,%lo(gStopCommentaryNow)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	lui	$4,%hi(gCurrentVIV) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(ginfo) # high
	addiu	$5,$2,%lo(ginfo) # low
	lbu	$3,16($5)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L625
	sb	$2,%lo(gCurrentVIV)($4)
	.set	macro
	.set	reorder

	move	$16,$5
$L626:
	lw	$4,32($16)
	jal	getasyncreadstatus
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	lui	$2,%hi(ginfo) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L626
$L625:
	lui	$2,%hi(ginfo) # high
$L637:
	addiu	$16,$2,%lo(ginfo) # low
	lbu	$2,17($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L629
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	SNDautovol
	li	$6,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,8($16)
	jal	SNDbankremove
$L629:
	lui	$2,%hi(gMasterMusicLevel) # high
	lw	$2,%lo(gMasterMusicLevel)($2)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	sll	$4,$4,1
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,7
	.set	macro
	.set	reorder

	lw	$4,24($16)
	#nop
	beq	$4,$0,$L630
	jal	purgememadr
	sw	$0,24($16)
$L630:
	lw	$4,28($16)
	#nop
	beq	$4,$0,$L631
	jal	purgememadr
	sw	$0,28($16)
$L631:
	lw	$4,20($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L638
	lui	$2,%hi(gStopCommentaryNow) # high
	.set	macro
	.set	reorder

	jal	purgememadr
	sw	$0,20($16)
	lui	$2,%hi(gStopCommentaryNow) # high
$L638:
	sb	$0,17($16)
	sb	$0,18($16)
	sw	$0,%lo(gStopCommentaryNow)($2)
	sb	$0,16($16)
$L624:
	lui	$2,%hi(ginfo) # high
	addiu	$16,$2,%lo(ginfo) # low
	lbu	$2,18($16)
	#nop
	beq	$2,$0,$L614
	lhu	$2,16($16)
	#nop
	bne	$2,$0,$L614
	.set	noreorder
	.set	nomacro
	jal	Feaudio_StartPatch__FP10SPEECHINFO
	move	$4,$16
	.set	macro
	.set	reorder

	sb	$0,18($16)
$L614:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FeAudio_systemtask__Fi
	.align	2
	.globl	FeAudio_AsyncPlayCommentary__FPc
	.ent	FeAudio_AsyncPlayCommentary__FPc
FeAudio_AsyncPlayCommentary__FPc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	lui	$2,%hi(gMasterFENarrationLevel) # high
	lw	$3,%lo(gMasterFENarrationLevel)($2)
	lui	$4,%hi(commentaryActualLevel) # high
	sw	$31,24($sp)
	sw	$16,16($sp)
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$2,$3
	sll	$2,$2,1
	sra	$2,$2,7
	sw	$2,%lo(commentaryActualLevel)($4)
	slt	$2,$2,91
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L642
	lui	$16,%hi(ginfo) # high
	.set	macro
	.set	reorder

	li	$2,90			# 0x0000005a
	sw	$2,%lo(commentaryActualLevel)($4)
$L642:
	addiu	$16,$16,%lo(ginfo) # low
	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	strncpy
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$3,%hi(gCurrentVIV) # high
	sw	$0,8($16)
	sw	$0,12($16)
	lbu	$5,0($17)
	li	$2,-1			# 0xffffffff
	sb	$0,16($4)
	sb	$0,17($4)
	sb	$0,18($4)
	sw	$0,20($4)
	sw	$0,24($4)
	sw	$0,28($4)
	sw	$0,32($4)
	sb	$2,%lo(gCurrentVIV)($3)
	xori	$5,$5,0x0063
	sltu	$5,$0,$5
	.set	noreorder
	.set	nomacro
	jal	FEAudio_StartLoadPatch__FP10SPEECHINFO
	sw	$5,4($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L641
	lui	$2,%hi(gMasterMusicLevel) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gMasterMusicLevel)($2)
	#nop
	sll	$4,$2,3
	addu	$4,$4,$2
	sll	$4,$4,2
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Volume__Fi
	sra	$4,$4,7
	.set	macro
	.set	reorder

$L641:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FeAudio_AsyncPlayCommentary__FPc
	.align	2
	.globl	FeAudio_AsyncPlaySpeech__Fii
	.ent	FeAudio_AsyncPlaySpeech__Fii
FeAudio_AsyncPlaySpeech__Fii:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	move	$6,$4
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L644
	move	$7,$5
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi(bigBuf+272) # high
	addiu	$5,$5,%lo(bigBuf+272) # low
	.set	noreorder
	.set	nomacro
	j	$L648
	li	$6,99			# 0x00000063
	.set	macro
	.set	reorder

$L644:
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L646
	lui	$5,%hi(bigBuf+280) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addiu	$5,$5,%lo(bigBuf+280) # low
	li	$6,97			# 0x00000061
	.set	noreorder
	.set	nomacro
	j	$L648
	addu	$7,$7,$6
	.set	macro
	.set	reorder

$L646:
	addu	$4,$sp,16
	addiu	$5,$5,%lo(bigBuf+280) # low
	addu	$6,$6,97
	addu	$7,$7,48
$L648:
	jal	sprintf
	.set	noreorder
	.set	nomacro
	jal	FeAudio_AsyncPlayCommentary__FPc
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	sll	$2,$2,16
	lw	$31,24($sp)
	sra	$2,$2,16
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	FeAudio_AsyncPlaySpeech__Fii
	.align	2
	.globl	FeAudio_StartBigfileRead__FPciiPi
	.ent	FeAudio_StartBigfileRead__FPciiPi
FeAudio_StartBigfileRead__FPciiPi:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L651
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi(bigBuf+288) # high
	addiu	$4,$4,%lo(bigBuf+288) # low
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$16,$2
	beq	$16,$0,$L651
	.set	noreorder
	.set	nomacro
	jal	setasyncfile
	move	$4,$18
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	asyncloadsegment
	move	$6,$17
	.set	macro
	.set	reorder

	sw	$2,0($20)
	.set	noreorder
	.set	nomacro
	j	$L652
	move	$2,$16
	.set	macro
	.set	reorder

$L651:
	move	$2,$0
$L652:
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

	.end	FeAudio_StartBigfileRead__FPciiPi
	.align	2
	.globl	FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
	.ent	FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$19,28($sp)
	move	$19,$4
	sw	$fp,48($sp)
	move	$fp,$5
	sw	$22,40($sp)
	move	$22,$6
	sw	$23,44($sp)
	move	$23,$7
	sw	$31,52($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$0,0($22)
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L653
	sw	$0,0($23)
	.set	macro
	.set	reorder

	addu	$17,$19,16
	lw	$2,8($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$20,16711680			# 0x00ff0000
	li	$21,-16777216			# 0xff000000
$L656:
	addu	$16,$17,8
	move	$4,$fp
	.set	noreorder
	.set	nomacro
	jal	strcmp
	move	$5,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L659
	lw	$3,0($17)
	#nop
	sll	$4,$3,24
	andi	$2,$3,0xff00
	sll	$2,$2,8
	or	$4,$4,$2
	and	$2,$3,$20
	srl	$2,$2,8
	or	$4,$4,$2
	and	$3,$3,$21
	srl	$3,$3,24
	or	$4,$4,$3
	sw	$4,0($22)
	lw	$3,4($17)
	#nop
	sll	$4,$3,24
	andi	$2,$3,0xff00
	sll	$2,$2,8
	or	$4,$4,$2
	and	$2,$3,$20
	srl	$2,$2,8
	or	$4,$4,$2
	and	$3,$3,$21
	srl	$3,$3,24
	or	$4,$4,$3
	.set	noreorder
	.set	nomacro
	j	$L653
	sw	$4,0($23)
	.set	macro
	.set	reorder

$L659:
	lbu	$2,8($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L660
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$5,$5,1
$L666:
	lbu	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L666
	addu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$5,$5,-1
$L660:
	addu	$17,$5,1
	lw	$3,8($19)
	move	$2,$18
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L656
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L653:
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$23,44($sp)
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
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	FeAudio_LocateBigfile__FP9LUMPYHEADPcPiT2
	.rdata
	.align	2
$LC7:
	.ascii	"lumpyhead\000"
	.text
	.align	2
	.globl	FeAudio_InitViv__FPc
	.ent	FeAudio_InitViv__FPc
FeAudio_InitViv__FPc:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	jal	setasyncfile
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	asyncloadsegment
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
$L668:
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L668
	lui	$4,%hi($LC7) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC7) # low
 #APP
 #NO_APP
	lw	$7,16($sp)
	li	$8,16711680			# 0x00ff0000
	sll	$3,$7,24
	andi	$2,$7,0xff00
	sll	$2,$2,8
	or	$3,$3,$2
	and	$2,$7,$8
	srl	$2,$2,8
	or	$3,$3,$2
	srl	$7,$7,24
	or	$3,$3,$7
	move	$7,$3
 #APP
 #NO_APP
	lw	$5,28($sp)
	move	$6,$0
	sw	$7,16($sp)
	lw	$7,24($sp)
	sll	$3,$5,24
	andi	$2,$5,0xff00
	sll	$2,$2,8
	or	$3,$3,$2
	and	$2,$5,$8
	srl	$2,$2,8
	or	$3,$3,$2
	srl	$5,$5,24
	or	$3,$3,$5
	addu	$5,$3,32
	sw	$3,28($sp)
	sll	$3,$7,24
	andi	$2,$7,0xff00
	sll	$2,$2,8
	or	$3,$3,$2
	and	$8,$7,$8
	srl	$8,$8,8
	or	$3,$3,$8
	srl	$7,$7,24
	or	$3,$3,$7
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$3,24($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L672
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L677
	move	$2,$0
	.set	macro
	.set	reorder

$L672:
	lw	$6,28($sp)
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	asyncloadsegment
	addu	$6,$6,32
	.set	macro
	.set	reorder

	move	$16,$2
$L673:
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L673
	li	$7,16711680			# 0x00ff0000
	.set	macro
	.set	reorder

	lw	$5,0($17)
 #APP
 #NO_APP
	move	$2,$17
	sll	$4,$5,24
	andi	$3,$5,0xff00
	sll	$3,$3,8
	or	$4,$4,$3
	and	$3,$5,$7
	srl	$3,$3,8
	or	$4,$4,$3
	srl	$5,$5,24
	or	$4,$4,$5
	lw	$6,12($2)
	lw	$5,8($2)
	sw	$4,0($2)
	sll	$4,$6,24
	andi	$3,$6,0xff00
	sll	$3,$3,8
	or	$4,$4,$3
	and	$3,$6,$7
	srl	$3,$3,8
	or	$4,$4,$3
	srl	$6,$6,24
	or	$4,$4,$6
	sw	$4,12($2)
	sll	$4,$5,24
	andi	$3,$5,0xff00
	sll	$3,$3,8
	or	$4,$4,$3
	and	$7,$5,$7
	srl	$7,$7,8
	or	$4,$4,$7
	srl	$5,$5,24
	or	$4,$4,$5
	sw	$4,8($2)
$L677:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	FeAudio_InitViv__FPc
	.align	2
	.globl	FeAudio_InitCommentary__Fii
	.ent	FeAudio_InitCommentary__Fii
FeAudio_InitCommentary__Fii:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(currentSpeechViv) # high
	addiu	$16,$16,%lo(currentSpeechViv) # low
	sll	$7,$4,2
	move	$4,$16
	lui	$5,%hi(ginfo) # high
	addiu	$2,$5,%lo(ginfo) # low
	lui	$3,%hi(D_8001016C) # high
	sw	$31,20($sp)
	sw	$0,8($2)
	lw	$6,%lo(D_8001016C)($3)
	li	$3,1			# 0x00000001
	sw	$3,4($2)
	lui	$3,%hi(Paths_Paths+152) # high
	sw	$0,12($2)
	sb	$0,16($2)
	sb	$0,17($2)
	sb	$0,18($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	sw	$0,32($2)
	lui	$2,%hi(allLanguages) # high
	addiu	$2,$2,%lo(allLanguages) # low
	addu	$7,$7,$2
	sw	$6,%lo(ginfo)($5)
	lui	$5,%hi(D_80010170) # high
	lw	$6,%lo(Paths_Paths+152)($3)
	#.set	volatile
	lw	$7,0($7)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo(D_80010170) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	FeAudio_InitViv__FPc
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	lui	$3,%hi(speechfileHeader) # high
	sw	$2,%lo(speechfileHeader)($3)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FeAudio_InitCommentary__Fii
	.align	2
	.globl	FeAudio_DeInitCommentary__Fv
	.ent	FeAudio_DeInitCommentary__Fv
FeAudio_DeInitCommentary__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lui	$16,%hi(speechfileHeader) # high
	lw	$4,%lo(speechfileHeader)($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L679
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
	sw	$0,%lo(speechfileHeader)($16)
$L679:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FeAudio_DeInitCommentary__Fv
	.globl	ginfo
	.data
	.align	2
ginfo:
	.space	36
	.globl	commentaryActualLevel
	.align	2
commentaryActualLevel:
	.space	4
	.globl	gStopCommentaryNow
	.align	2
gStopCommentaryNow:
	.space	4
	.globl	currentSpeechViv
	.align	2
currentSpeechViv:
	.space	40
