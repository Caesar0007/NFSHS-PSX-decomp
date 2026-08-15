	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\copspeak.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	CopSpeak_RadioStaticInit__Fv
	.align	2
	.globl	CopSpeak_RadioStaticActive__Fi
	.align	2
	.globl	CopSpeak_RadioStaticSquelch__Fv
	.align	2
	.globl	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	.align	2
	.globl	CopSpeak_SilenceCop__FP8Car_tObji
	.align	2
	.globl	CopSpeak_Alloc__FP17CopSpeak_tRequest
	.align	2
	.globl	CopSpeak_Free__FP17CopSpeak_tRequest
	.align	2
	.globl	CopSpeak_ReadyNextRequest__Fv
	.align	2
	.globl	CopSpeak_Cancel__Fv
	.align	2
	.globl	CopSpeak_Stop__Fv
	.align	2
	.globl	CopSpeak_CleanUp__Fv
	.align	2
	.globl	CopSpeak_InitVars__Fv
	.align	2
	.globl	CopSpeak_DirectRequest__FillP8Car_tObjPc
	.align	2
	.globl	CopSpeak_GenericBankRequest__FiP8Car_tObj
	.rdata
	.align	2
$LC0:
	.ascii	"%szzzwzzz.viv\000"
	.sdata
	.align	2
$LC1:
	.ascii	"BAD!\000"
	.rdata
	.align	2
$LC2:
	.ascii	"ocar index\000"
	.align	2
$LC3:
	.ascii	"rain.bnk\000"
	.sdata
	.align	2
$LC4:
	.ascii	"lden\000"
	.align	2
$LC5:
	.ascii	"ldex\000"
	.rdata
	.align	2
$LC6:
	.ascii	"%.4s%.4s.bnk\000"
	.align	2
$LC7:
	.ascii	"%szzzw%s.viv\000"
	.align	2
$LC8:
	.ascii	"%szzzwcst.viv\000"
	.align	2
$LC9:
	.ascii	"trck index\000"
	.sdata
	.align	2
$LC10:
	.ascii	"fre\000"
	.align	2
$LC11:
	.ascii	"ger\000"
	.align	2
$LC12:
	.ascii	"eng\000"
	.rdata
	.align	2
$LC13:
	.ascii	"%szzzx%s.viv\000"
	.align	2
$LC14:
	.ascii	"oneshots.txt\000"
	.align	2
$LC15:
	.ascii	"copspeak temp\000"
	.align	2
$LC16:
	.ascii	"1sht index\000"
	.align	2
$LC17:
	.ascii	"CopSpeakBuf\000"
	.text
	.align	2
	.globl	CopSpeak_StartUp__Fv
	.align	2
	.globl	CopSpeak_GetEnginePatch__Fii
	.align	2
	.globl	CopSpeak_Play__FP17CopSpeak_tRequesti
	.align	2
	.globl	CopSpeak_Skip__Fv
	.align	2
	.globl	CopSpeak_Request__FP17CopSpeak_tRequest
	.align	2
	.globl	CopSpeak_BankVolume__FP17CopSpeak_tRequest
	.align	2
	.globl	CopSpeak_LoadNextRequest__Fv
	.align	2
	.globl	CopSpeak_PlayNextRequest__Fv
	.align	2
	.globl	CopSpeak_Flush__Fv
	.align	2
	.globl	CopSpeak_Server__Fv
	.align	2
	.globl	CopSpeak_SfxQueued__Fv
	.rdata
	.align	2
$LC18:
	.ascii	"\000\000"
	.sdata
	.align	2
$LC19:
	.ascii	"x\000"
	.align	2
$LC20:
	.ascii	"s\000"
	.align	2
$LC21:
	.ascii	".\000"
	.align	2
$LC22:
	.ascii	"n\000"
	.align	2
$LC23:
	.ascii	"D\000"
	.align	2
$LC24:
	.ascii	"%s%d\000"
	.align	2
$LC25:
	.ascii	"|\000"
	.text
	.align	2
	.globl	CopSpeak_ShowQueue__Fv
	.align	2
	.globl	CopSpeak_Debug__Fv
	.globl	Copspeak_gBank
	.data
	.align	2
Copspeak_gBank:
	.space	64
	.globl	CopSpeak_gRequest
	.align	2
CopSpeak_gRequest:
	.space	32
	.globl	CopSpeak_gCurrent
	.align	2
CopSpeak_gCurrent:
	.space	32
	.globl	CopSpeak_gQueue
	.align	2
CopSpeak_gQueue:
	.space	2048
	.globl	CopSpeak_gMusicStat
	.align	2
CopSpeak_gMusicStat:
	.space	12
	.globl	cdsectorreseek
	.sdata
	.align	2
cdsectorreseek:
	.space	4
	.globl	CopSpeak_gHandleCount
CopSpeak_gHandleCount:
	.space	1
	.globl	CopSpeak_gQueueHead
	.align	2
CopSpeak_gQueueHead:
	.space	4
	.globl	CopSpeak_gQueuePlay
	.align	2
CopSpeak_gQueuePlay:
	.space	4
	.globl	CopSpeak_gSpchHandle
	.align	2
CopSpeak_gSpchHandle:
	.space	4
	.globl	CopSpeak_gNumTrackSfx
	.align	2
CopSpeak_gNumTrackSfx:
	.space	4
	.globl	CopSpeak_gQueueLoad
	.align	2
CopSpeak_gQueueLoad:
	.space	4
	.globl	CopSpeak_gQueueReady
	.align	2
CopSpeak_gQueueReady:
	.space	4
	.globl	CopSpeak_gWrongWay
	.align	2
CopSpeak_gWrongWay:
	.space	4
	.globl	CopSpeak_gBuffer
	.align	2
CopSpeak_gBuffer:
	.space	4
	.globl	CopSpeak_gBufferLow
	.align	1
CopSpeak_gBufferLow:
	.space	2
	.globl	CopSpeak_gBufferStart
	.align	1
CopSpeak_gBufferStart:
	.space	2
	.globl	CopSpeak_gBufferEnd
	.align	1
CopSpeak_gBufferEnd:
	.space	2
	.globl	CopSpeak_gBufferHigh
	.align	1
CopSpeak_gBufferHigh:
	.space	2
	.globl	CopSpeak_gStaticHandle
	.align	2
CopSpeak_gStaticHandle:
	.space	8
	.globl	CopSpeak_gStaticPatch
	.align	2
CopSpeak_gStaticPatch:
	.space	2

	.extern	gMasterAmbientLevel, 4
	.extern	gStereoMode, 4
	.extern	Audio_direct3davail, 4
	.extern	gSndBnk, 84
	.extern	GameSetup_gData, 2600
	.extern	GameSetup_gTrackNames, 48
	.extern	GameSetup_gCarNames, 255
	.extern	Paths_Paths, 200
	.extern	gMasterFENarrationLevel, 4

	.text
	.text
	.ent	CopSpeak_RadioStaticInit__Fv
CopSpeak_RadioStaticInit__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	li	$5,-1			# 0xffffffff
	la	$6,CopSpeak_gStaticPatch
	la	$4,CopSpeak_gStaticHandle
$L604:
	sw	$5,0($4)
	addu	$2,$3,$6
	addu	$3,$3,1
	sb	$5,0($2)
	slt	$2,$3,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	addu	$4,$4,4
	.set	macro
	.set	reorder

	j	$31
	.end	CopSpeak_RadioStaticInit__Fv
	.text
	.ent	CopSpeak_RadioStaticActive__Fi
CopSpeak_RadioStaticActive__Fi:
	.frame	$sp,72,$31		# vars= 24, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,72
	sw	$21,60($sp)
	li	$21,3			# 0x00000003
	slt	$2,$4,97
	sw	$31,68($sp)
	sw	$22,64($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L607
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	li	$21,4			# 0x00000004
$L607:
	move	$19,$0
	li	$20,-1			# 0xffffffff
	sll	$2,$4,7
	addu	$22,$2,$4
	slt	$2,$19,2
$L619:
	beq	$2,$0,$L609
	la	$2,CopSpeak_gStaticPatch
	addu	$18,$19,$2
	lb	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$20,$L620
	sll	$3,$19,2
	.set	macro
	.set	reorder

	jal	random
	remu	$3,$2,$21
	sb	$3,0($18)
	sll	$3,$19,2
$L620:
	la	$2,CopSpeak_gStaticHandle
	addu	$17,$3,$2
	lw	$4,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$20,$L613
	move	$6,$0
	.set	macro
	.set	reorder

	lb	$5,0($18)
	li	$4,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	addu	$5,$5,47
	.set	macro
	.set	reorder

	move	$16,$2
	bltz	$16,$L610
	.set	noreorder
	.set	nomacro
	jal	SNDplaysetdef
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$2,gMasterFENarrationLevel
	#nop
	mult	$2,$22
	addu	$4,$sp,16
	sb	$16,20($sp)
	sw	$0,16($sp)
	mflo	$7
	#nop
	#nop
	sra	$2,$7,14
	.set	noreorder
	.set	nomacro
	jal	SNDplay
	sb	$2,24($sp)
	.set	macro
	.set	reorder

	sw	$2,0($17)
	sb	$20,0($18)
	lw	$4,0($17)
	#nop
	bgez	$4,$L610
	.set	noreorder
	.set	nomacro
	jal	AudioClc_SndError__Fi
	addu	$19,$19,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L619
	slt	$2,$19,2
	.set	macro
	.set	reorder

$L613:
	jal	SNDover
	beq	$2,$0,$L610
	sw	$20,0($17)
$L610:
	addu	$19,$19,1
	.set	noreorder
	.set	nomacro
	j	$L619
	slt	$2,$19,2
	.set	macro
	.set	reorder

$L609:
	lw	$31,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,72
	.set	macro
	.set	reorder

	.end	CopSpeak_RadioStaticActive__Fi
	.text
	.ent	CopSpeak_RadioStaticSquelch__Fv
CopSpeak_RadioStaticSquelch__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	sw	$18,24($sp)
	li	$18,-1			# 0xffffffff
	sw	$16,16($sp)
	la	$16,CopSpeak_gStaticHandle
	sw	$31,28($sp)
$L622:
	lw	$4,0($16)
	#nop
	beq	$4,$18,$L625
	jal	SNDstop
	sw	$18,0($16)
$L625:
	addu	$17,$17,1
	slt	$2,$17,2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L622
	addu	$16,$16,4
	.set	macro
	.set	reorder

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

	.end	CopSpeak_RadioStaticSquelch__Fv
	.text
	.ent	CopSpeak_InitRequest__FP17CopSpeak_tRequest
CopSpeak_InitRequest__FP17CopSpeak_tRequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1			# 0xffffffff
	sw	$2,4($4)
	sw	$2,24($4)
	li	$2,2			# 0x00000002
	sw	$0,0($4)
	sw	$0,8($4)
	sw	$0,12($4)
	sb	$0,28($4)
	sb	$0,29($4)
	sb	$2,30($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sb	$0,31($4)
	.set	macro
	.set	reorder

	.end	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	.text
	.ent	CopSpeak_SilenceCop__FP8Car_tObji
CopSpeak_SilenceCop__FP8Car_tObji:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L630
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lui	$3,%hi(CopSpeak_gCurrent) # high
	addiu	$2,$3,%lo(CopSpeak_gCurrent) # low
	lbu	$2,28($2)
	#nop
	bne	$2,$5,$L628
	lw	$2,%lo(CopSpeak_gCurrent)($3)
	#nop
	bne	$4,$2,$L628
$L630:
	lw	$4,CopSpeak_gSpchHandle
	li	$2,-1			# 0xffffffff
	beq	$4,$2,$L631
	.set	noreorder
	.set	nomacro
	jal	SNDvol
	move	$5,$0
	.set	macro
	.set	reorder

$L631:
	jal	CopSpeak_RadioStaticSquelch__Fv
$L628:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_SilenceCop__FP8Car_tObji
	.text
	.ent	CopSpeak_Alloc__FP17CopSpeak_tRequest
CopSpeak_Alloc__FP17CopSpeak_tRequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,CopSpeak_gQueueReady
	lw	$2,CopSpeak_gQueueLoad
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L633
	li	$2,32764			# 0x00007ffc
	.set	macro
	.set	reorder

	sh	$0,CopSpeak_gBufferLow
	sh	$0,CopSpeak_gBufferHigh
	sh	$0,CopSpeak_gBufferStart
	sh	$2,CopSpeak_gBufferEnd
$L633:
	lh	$2,CopSpeak_gBufferEnd
	lh	$5,CopSpeak_gBufferStart
	lw	$6,12($4)
	lhu	$3,CopSpeak_gBufferStart
	subu	$2,$2,$5
	slt	$2,$2,$6
	bne	$2,$0,$L634
	lhu	$2,12($4)
	sw	$5,4($4)
	addu	$2,$3,$2
	sh	$2,CopSpeak_gBufferStart
	j	$31
$L634:
	lh	$2,CopSpeak_gBufferLow
	lhu	$5,CopSpeak_gBufferLow
	slt	$2,$2,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L635
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lhu	$2,12($4)
	sh	$3,CopSpeak_gBufferHigh
	sh	$5,CopSpeak_gBufferEnd
	sh	$0,CopSpeak_gBufferLow
	sw	$0,4($4)
	sh	$2,CopSpeak_gBufferStart
	j	$31
$L635:
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

	.end	CopSpeak_Alloc__FP17CopSpeak_tRequest
	.text
	.ent	CopSpeak_Free__FP17CopSpeak_tRequest
CopSpeak_Free__FP17CopSpeak_tRequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,4($4)
	#nop
	bltz	$2,$L644
	lw	$5,12($4)
	#nop
	blez	$5,$L644
	lh	$3,CopSpeak_gBufferHigh
	#nop
	beq	$3,$0,$L638
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L643
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$2,32764			# 0x00007ffc
	sh	$0,CopSpeak_gBufferHigh
	sh	$2,CopSpeak_gBufferEnd
	.set	noreorder
	.set	nomacro
	j	$L643
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L638:
	lh	$3,CopSpeak_gBufferStart
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L641
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sh	$0,CopSpeak_gBufferStart
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

$L641:
	lhu	$2,4($4)
	lhu	$3,12($4)
	#nop
	addu	$2,$2,$3
	sh	$2,CopSpeak_gBufferLow
	li	$2,-1			# 0xffffffff
$L643:
	sw	$2,4($4)
$L644:
	j	$31
	.end	CopSpeak_Free__FP17CopSpeak_tRequest
	.text
	.ent	CopSpeak_ReadyNextRequest__Fv
CopSpeak_ReadyNextRequest__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$3,%hi(CopSpeak_gQueue) # high
	lw	$2,CopSpeak_gQueueReady
	addiu	$3,$3,%lo(CopSpeak_gQueue) # low
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sll	$2,$2,5
	addu	$16,$2,$3
	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L646
	li	$18,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,20($16)
	jal	FILE_opstatus
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L645
	xor	$2,$2,$18
	.set	macro
	.set	reorder

	lw	$4,20($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_completeop
	sltu	$18,$2,$18
	.set	macro
	.set	reorder

	lbu	$3,CopSpeak_gHandleCount
	lw	$4,12($16)
	addu	$3,$3,-1
	sb	$3,CopSpeak_gHandleCount
	beq	$2,$4,$L648
	move	$18,$0
$L648:
	lw	$3,CopSpeak_gBuffer
	lw	$2,4($16)
	li	$4,1816854528			# 0x6c4b0000
	addu	$17,$3,$2
	lw	$2,0($17)
	ori	$4,$4,0x4e42
	beq	$2,$4,$L649
	move	$18,$0
$L649:
	lbu	$3,4($17)
	li	$2,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L650
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	beq	$3,$2,$L650
	move	$18,$0
$L650:
	bne	$18,$0,$L651
	lbu	$2,29($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L667
	li	$2,1279852544			# 0x4c490000
	.set	macro
	.set	reorder

	lb	$4,30($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L667
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$5,24($16)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_LoadAsyncSfx__FiiPvi
	move	$7,$6
	.set	macro
	.set	reorder

	li	$2,1279852544			# 0x4c490000
$L667:
	ori	$2,$2,0x4146
	sw	$2,0($17)
	lw	$2,4($16)
	sw	$0,16($sp)
	sw	$0,20($sp)
	lw	$4,16($16)
	lw	$5,8($16)
	lw	$6,CopSpeak_gBuffer
	lw	$7,12($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_read
	addu	$6,$6,$2
	.set	macro
	.set	reorder

	sw	$2,20($16)
	lbu	$2,CopSpeak_gHandleCount
	lw	$4,20($16)
	addu	$2,$2,1
	sb	$2,CopSpeak_gHandleCount
	jal	FILE_operror
	j	$L660
$L651:
	lb	$4,30($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L668
	li	$2,1279852544			# 0x4c490000
	.set	macro
	.set	reorder

	lbu	$2,29($16)
	#nop
	bne	$2,$0,$L656
	lw	$2,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L655
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L656:
	lw	$5,24($16)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L668
	li	$2,1279852544			# 0x4c490000
	.set	macro
	.set	reorder

	lb	$4,30($16)
	lw	$5,24($16)
	lw	$2,CopSpeak_gBuffer
	lw	$6,4($16)
	lw	$7,12($16)
	j	$L666
$L655:
	lw	$5,8($16)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	addu	$5,$5,16384
	.set	macro
	.set	reorder

	li	$3,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L668
	li	$2,1279852544			# 0x4c490000
	.set	macro
	.set	reorder

	lb	$4,30($16)
	lw	$7,12($16)
	lw	$5,8($16)
	lw	$2,CopSpeak_gBuffer
	lw	$6,4($16)
	addu	$5,$5,16384
$L666:
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_LoadAsyncSfx__FiiPvi
	addu	$6,$2,$6
	.set	macro
	.set	reorder

	li	$2,1279852544			# 0x4c490000
$L668:
	ori	$2,$2,0x4146
	sw	$2,0($17)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_Free__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L660
$L646:
	lbu	$2,29($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L669
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,24($16)
	#nop
	bltz	$2,$L660
	lb	$2,30($16)
	#nop
	bltz	$2,$L660
$L669:
	lb	$4,30($16)
	lw	$5,24($16)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_LoadAsyncSfx__FiiPvi
	move	$7,$6
	.set	macro
	.set	reorder

$L660:
	beq	$18,$0,$L645
	lw	$4,CopSpeak_gQueueReady
	#nop
	slt	$2,$4,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L664
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$4,1
$L664:
	sw	$3,CopSpeak_gQueueReady
$L645:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	CopSpeak_ReadyNextRequest__Fv
	.text
	.ent	CopSpeak_Cancel__Fv
CopSpeak_Cancel__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$3,CopSpeak_gQueueReady
	lw	$2,CopSpeak_gQueueLoad
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L671
	sw	$16,16($sp)
	.set	macro
	.set	reorder

$L672:
	jal	CopSpeak_ReadyNextRequest__Fv
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$3,CopSpeak_gQueueReady
	lw	$2,CopSpeak_gQueueLoad
	#nop
	bne	$3,$2,$L672
$L671:
	lw	$4,CopSpeak_gSpchHandle
	li	$16,-1			# 0xffffffff
	beq	$4,$16,$L676
	jal	SNDstop
$L676:
	jal	CopSpeak_RadioStaticSquelch__Fv
	lui	$4,%hi(CopSpeak_gCurrent) # high
	sw	$16,CopSpeak_gSpchHandle
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	addiu	$4,$4,%lo(CopSpeak_gCurrent) # low
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	li	$2,32764			# 0x00007ffc
	sw	$0,CopSpeak_gQueueHead
	sw	$0,CopSpeak_gQueueLoad
	sw	$0,CopSpeak_gQueueReady
	sw	$0,CopSpeak_gQueuePlay
	sh	$0,CopSpeak_gBufferLow
	sh	$0,CopSpeak_gBufferHigh
	sh	$0,CopSpeak_gBufferStart
	sh	$2,CopSpeak_gBufferEnd
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_Cancel__Fv
	.text
	.ent	CopSpeak_Stop__Fv
CopSpeak_Stop__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CopSpeak_Cancel__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_Stop__Fv
	.text
	.ent	CopSpeak_CleanUp__Fv
CopSpeak_CleanUp__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_Stop__Fv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(Copspeak_gBank) # high
	addiu	$16,$2,%lo(Copspeak_gBank) # low
$L679:
	lw	$2,4($16)
	#nop
	beq	$2,$0,$L682
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_closesync
	li	$5,100			# 0x00000064
	.set	macro
	.set	reorder

	sw	$0,4($16)
$L682:
	lw	$4,8($16)
	#nop
	beq	$4,$0,$L683
	jal	purgememadr
	sw	$0,8($16)
$L683:
	addu	$17,$17,1
	slt	$2,$17,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L679
	addu	$16,$16,16
	.set	macro
	.set	reorder

	lw	$2,CopSpeak_gBuffer
	#nop
	beq	$2,$0,$L678
	sw	$0,CopSpeak_gBuffer
$L678:
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

	.end	CopSpeak_CleanUp__Fv
	.text
	.ent	CopSpeak_InitVars__Fv
CopSpeak_InitVars__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	move	$4,$0
	lui	$2,%hi(Copspeak_gBank) # high
	addiu	$3,$2,%lo(Copspeak_gBank) # low
$L690:
	sw	$0,4($3)
	sw	$0,8($3)
	addu	$4,$4,1
	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L690
	addu	$3,$3,16
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	sw	$2,CopSpeak_gSpchHandle
	li	$2,32764			# 0x00007ffc
	lui	$4,%hi(CopSpeak_gCurrent) # high
	sw	$0,CopSpeak_gBuffer
	sw	$0,CopSpeak_gQueueHead
	sw	$0,CopSpeak_gQueueLoad
	sw	$0,CopSpeak_gQueueReady
	sw	$0,CopSpeak_gQueuePlay
	sw	$0,CopSpeak_gWrongWay
	sh	$0,CopSpeak_gBufferLow
	sh	$0,CopSpeak_gBufferHigh
	sh	$0,CopSpeak_gBufferStart
	sh	$2,CopSpeak_gBufferEnd
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	addiu	$4,$4,%lo(CopSpeak_gCurrent) # low
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

	.end	CopSpeak_InitVars__Fv
	.text
	.ent	CopSpeak_DirectRequest__FillP8Car_tObjPc
CopSpeak_DirectRequest__FillP8Car_tObjPc:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$21,36($sp)
	move	$21,$7
	sw	$17,20($sp)
	lui	$3,%hi(CopSpeak_gQueue) # high
	lw	$4,CopSpeak_gQueueHead
	addiu	$3,$3,%lo(CopSpeak_gQueue) # low
	sw	$31,40($sp)
	sw	$16,16($sp)
	sll	$2,$4,5
	addu	$16,$2,$3
	slt	$2,$4,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L693
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$17,$4,1
$L693:
	lw	$2,CopSpeak_gQueuePlay
	#nop
	beq	$17,$2,$L692
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,127			# 0x0000007f
	sw	$18,16($16)
	sw	$19,8($16)
	sw	$20,12($16)
	sb	$2,31($16)
	sw	$21,0($16)
	sw	$17,CopSpeak_gQueueHead
$L692:
	lw	$31,40($sp)
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

	.end	CopSpeak_DirectRequest__FillP8Car_tObjPc
	.text
	.ent	CopSpeak_GenericBankRequest__FiP8Car_tObj
CopSpeak_GenericBankRequest__FiP8Car_tObj:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$17,20($sp)
	lui	$3,%hi(CopSpeak_gQueue) # high
	lw	$4,CopSpeak_gQueueHead
	addiu	$3,$3,%lo(CopSpeak_gQueue) # low
	sw	$31,32($sp)
	sw	$16,16($sp)
	sll	$2,$4,5
	addu	$16,$2,$3
	slt	$2,$4,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L696
	move	$17,$0
	.set	macro
	.set	reorder

	addu	$17,$4,1
$L696:
	lw	$2,CopSpeak_gQueuePlay
	#nop
	beq	$17,$2,$L695
	lw	$2,CopSpeak_gQueueReady
	#nop
	beq	$17,$2,$L695
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	li	$2,3			# 0x00000003
	sb	$2,30($16)
	li	$2,127			# 0x0000007f
	sw	$18,24($16)
	sb	$2,31($16)
	sw	$19,0($16)
	sw	$17,CopSpeak_gQueueHead
$L695:
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

	.end	CopSpeak_GenericBankRequest__FiP8Car_tObj
	.text
	.ent	CopSpeak_StartUp__Fv
CopSpeak_StartUp__Fv:
	.frame	$sp,208,$31		# vars= 144, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,208
	sw	$31,204($sp)
	sw	$fp,200($sp)
	sw	$23,196($sp)
	sw	$22,192($sp)
	sw	$21,188($sp)
	sw	$20,184($sp)
	sw	$19,180($sp)
	sw	$18,176($sp)
	sw	$17,172($sp)
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitVars__Fv
	sw	$16,168($sp)
	.set	macro
	.set	reorder

	jal	CopSpeak_RadioStaticInit__Fv
	addu	$4,$sp,24
	lui	$2,%hi(Paths_Paths+112) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+112)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L699
	lui	$2,%hi(Copspeak_gBank+16) # high
	.set	macro
	.set	reorder

	addiu	$18,$2,%lo(Copspeak_gBank+16) # low
	sw	$0,12($18)
	lui	$2,%hi(GameSetup_gCarNames) # high
	addiu	$17,$2,%lo(GameSetup_gCarNames) # low
	lui	$16,%hi($LC1) # high
$L700:
	lw	$2,12($18)
	addiu	$5,$16,%lo($LC1) # low
	sll	$4,$2,2
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addu	$4,$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L701
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,12($18)
	#nop
	addu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L700
	sw	$2,12($18)
	.set	macro
	.set	reorder

$L701:
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	move	$17,$6
	lw	$2,12($18)
	addu	$19,$sp,152
	sll	$2,$2,1
	addu	$2,$2,1
	sll	$5,$2,3
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,12($18)
	.set	macro
	.set	reorder

	sw	$2,8($18)
	lui	$2,%hi($LC3) # high
	addiu	$2,$2,%lo($LC3) # low
	sw	$2,152($sp)
$L706:
	move	$4,$21
	lw	$7,8($18)
	sll	$16,$17,3
	addu	$7,$7,$16
	addu	$2,$7,4
	sw	$2,16($sp)
	lw	$5,0($19)
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	move	$6,$0
	.set	macro
	.set	reorder

	bne	$2,$0,$L705
	lw	$2,8($18)
	#nop
	addu	$2,$16,$2
	sw	$0,0($2)
	lw	$2,8($18)
	#nop
	addu	$2,$16,$2
	sw	$0,4($2)
$L705:
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	blez	$17,$L706
	addu	$19,$19,4
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi($LC4) # high
	addiu	$fp,$2,%lo($LC4) # low
	lui	$2,%hi($LC5) # high
	addiu	$23,$2,%lo($LC5) # low
	addu	$20,$sp,128
	lui	$2,%hi(GameSetup_gCarNames) # high
	addiu	$22,$2,%lo(GameSetup_gCarNames) # low
	li	$19,8			# 0x00000008
$L709:
	lw	$2,12($18)
	#nop
	addu	$2,$2,-1
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L710
	move	$4,$20
	.set	macro
	.set	reorder

	lui	$5,%hi($LC6) # high
	addiu	$5,$5,%lo($LC6) # low
	srl	$3,$17,31
	addu	$3,$17,$3
	sra	$3,$3,1
	sll	$2,$3,1
	subu	$2,$17,$2
	sll	$2,$2,2
	addu	$2,$sp,$2
	sll	$6,$3,2
	addu	$6,$6,$3
	sw	$fp,144($sp)
	sw	$23,148($sp)
	lw	$7,144($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$6,$6,$22
	.set	macro
	.set	reorder

	move	$4,$21
	move	$5,$20
	move	$6,$0
	lw	$7,8($18)
	sll	$16,$17,3
	addu	$7,$7,$19
	addu	$2,$7,4
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	bne	$2,$0,$L711
	lw	$2,8($18)
	#nop
	addu	$2,$16,$2
	sw	$0,8($2)
	lw	$2,8($18)
	#nop
	addu	$2,$16,$2
	sw	$0,12($2)
$L711:
	addu	$19,$19,8
	.set	noreorder
	.set	nomacro
	j	$L709
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L710:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,1			# 0x00000001
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	move	$7,$18
	.set	macro
	.set	reorder

	sw	$2,4($18)
$L699:
	addu	$4,$sp,24
	lui	$2,%hi(Paths_Paths) # high
	addiu	$16,$2,%lo(Paths_Paths) # low
	lui	$5,%hi($LC7) # high
	lui	$2,%hi(GameSetup_gData+60) # high
	addiu	$5,$5,%lo($LC7) # low
	lui	$7,%hi(GameSetup_gTrackNames) # high
	lw	$6,112($16)
	lw	$2,%lo(GameSetup_gData+60)($2)
	addiu	$7,$7,%lo(GameSetup_gTrackNames) # low
	sw	$0,CopSpeak_gNumTrackSfx
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$7,$2,$7
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	bne	$21,$0,$L746
	move	$4,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	lw	$6,112($16)
	lui	$5,%hi($LC8) # high
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC8) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L715
	move	$4,$21
	.set	macro
	.set	reorder

$L746:
	lui	$2,%hi(Copspeak_gBank) # high
	.set	noreorder
	.set	nomacro
	jal	bigcount
	addiu	$17,$2,%lo(Copspeak_gBank) # low
	.set	macro
	.set	reorder

	lui	$4,%hi($LC9) # high
	addiu	$4,$4,%lo($LC9) # low
	sll	$5,$2,3
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,12($17)
	.set	macro
	.set	reorder

	lw	$3,12($17)
	sw	$2,8($17)
	sw	$3,CopSpeak_gNumTrackSfx
	.set	noreorder
	.set	nomacro
	blez	$3,$L717
	move	$16,$0
	.set	macro
	.set	reorder

	move	$4,$21
$L747:
	move	$5,$0
	move	$6,$16
	lw	$7,8($17)
	sll	$2,$16,3
	addu	$7,$7,$2
	addu	$2,$7,4
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$2,12($17)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L747
	move	$4,$21
	.set	macro
	.set	reorder

$L717:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,1			# 0x00000001
	li	$6,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	move	$7,$17
	.set	macro
	.set	reorder

	sw	$2,4($17)
$L715:
	lui	$2,%hi(GameSetup_gData+224) # high
	lw	$3,%lo(GameSetup_gData+224)($2)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L723
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L724
	lui	$2,%hi($LC12) # high
	.set	macro
	.set	reorder

	lui	$2,%hi($LC10) # high
	.set	noreorder
	.set	nomacro
	j	$L721
	addiu	$7,$2,%lo($LC10) # low
	.set	macro
	.set	reorder

$L723:
	lui	$2,%hi($LC11) # high
	.set	noreorder
	.set	nomacro
	j	$L721
	addiu	$7,$2,%lo($LC11) # low
	.set	macro
	.set	reorder

$L724:
	addiu	$7,$2,%lo($LC12) # low
$L721:
	addu	$4,$sp,24
	lui	$5,%hi($LC13) # high
	lui	$2,%hi(Paths_Paths+116) # high
	lw	$6,%lo(Paths_Paths+116)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC13) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$21,$2
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L726
	addu	$2,$sp,160
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	move	$4,$21
	lui	$5,%hi($LC14) # high
	addiu	$5,$5,%lo($LC14) # low
	move	$6,$0
	addu	$7,$sp,156
	lui	$16,%hi(Copspeak_gBank+32) # high
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	addiu	$23,$16,%lo(Copspeak_gBank+32) # low
	.set	macro
	.set	reorder

	beq	$2,$0,$L727
	lw	$5,160($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L727
	lui	$4,%hi($LC15) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo($LC15) # low
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	li	$6,16			# 0x00000010
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	li	$5,1			# 0x00000001
	li	$6,100			# 0x00000064
	move	$7,$23
	.set	noreorder
	.set	nomacro
	jal	FILE_opensync
	move	$19,$2
	.set	macro
	.set	reorder

	move	$6,$19
	lw	$4,%lo(Copspeak_gBank+32)($16)
	move	$16,$19
	sw	$2,4($23)
	lw	$5,156($sp)
	lw	$7,160($sp)
	li	$2,100			# 0x00000064
	.set	noreorder
	.set	nomacro
	jal	FILE_readsync
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$2,160($sp)
	move	$18,$0
	addu	$3,$19,$2
	sltu	$2,$19,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L729
	sw	$0,12($23)
	.set	macro
	.set	reorder

	li	$4,34			# 0x00000022
$L731:
	lbu	$2,0($16)
	#nop
	bne	$2,$4,$L730
	beq	$18,$0,$L733
	lw	$2,12($23)
	#nop
	addu	$2,$2,1
	sw	$2,12($23)
$L733:
	sltu	$18,$18,1
$L730:
	addu	$16,$16,1
	sltu	$2,$16,$3
	bne	$2,$0,$L731
$L729:
	lui	$4,%hi($LC16) # high
	addiu	$4,$4,%lo($LC16) # low
	move	$6,$0
	move	$20,$6
	move	$22,$19
	lw	$5,12($23)
	move	$16,$19
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lw	$3,160($sp)
	move	$18,$0
	addu	$3,$19,$3
	sltu	$3,$19,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L736
	sw	$2,8($23)
	.set	macro
	.set	reorder

$L738:
	lbu	$3,0($16)
	li	$2,34			# 0x00000022
	bne	$3,$2,$L737
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L740
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L741
	addu	$22,$16,1
	.set	macro
	.set	reorder

$L740:
	move	$5,$22
	move	$6,$0
	sb	$0,0($16)
	lw	$7,8($23)
	sll	$17,$20,3
	addu	$7,$7,$17
	addu	$2,$7,4
	.set	noreorder
	.set	nomacro
	jal	locatebigentryz
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	bne	$2,$0,$L742
	lw	$2,8($23)
	#nop
	addu	$2,$17,$2
	sw	$0,4($2)
$L742:
	addu	$20,$20,1
$L741:
	xori	$18,$18,0x0001
$L737:
	lw	$2,160($sp)
	addu	$16,$16,1
	addu	$2,$19,$2
	sltu	$2,$16,$2
	bne	$2,$0,$L738
$L736:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$19
	.set	macro
	.set	reorder

$L727:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$21
	.set	macro
	.set	reorder

$L726:
	li	$4,32768			# 0x00008000
	lui	$5,%hi($LC17) # high
	.set	noreorder
	.set	nomacro
	jal	Platform_GetDCTBuffer__FiPc
	addiu	$5,$5,%lo($LC17) # low
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
	sw	$2,CopSpeak_gBuffer
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,208
	.set	macro
	.set	reorder

	.end	CopSpeak_StartUp__Fv
	.text
	.ent	CopSpeak_GetEnginePatch__Fii
CopSpeak_GetEnginePatch__Fii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$4,$4,1
	addu	$2,$5,1
	addu	$4,$4,$2
	lui	$2,%hi(Copspeak_gBank+24) # high
	lw	$3,%lo(Copspeak_gBank+24)($2)
	sll	$2,$4,3
	addu	$2,$2,$3
	lw	$2,4($2)
	#nop
	bne	$2,$0,$L749
	addu	$4,$5,69
$L749:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	CopSpeak_GetEnginePatch__Fii
	.text
	.ent	CopSpeak_Play__FP17CopSpeak_tRequesti
CopSpeak_Play__FP17CopSpeak_tRequesti:
	.frame	$sp,56,$31		# vars= 24, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$16,40($sp)
	move	$16,$4
	sw	$17,44($sp)
	move	$17,$5
	addu	$4,$sp,16
	sw	$31,52($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDplaysetdef
	sw	$18,48($sp)
	.set	macro
	.set	reorder

	lb	$3,30($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L751
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(gSndBnk+36) # high
	lbu	$2,%lo(gSndBnk+36)($2)
	#nop
	sb	$2,20($sp)
	lw	$2,24($16)
	.set	noreorder
	.set	nomacro
	j	$L752
	sw	$2,16($sp)
	.set	macro
	.set	reorder

$L751:
	sb	$17,20($sp)
	sw	$0,16($sp)
$L752:
	lw	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	li	$4,48			# 0x00000030
	.set	macro
	.set	reorder

	lh	$2,142($2)
	#nop
	addu	$3,$2,32
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L753
	li	$4,127			# 0x0000007f
	.set	macro
	.set	reorder

	move	$4,$3
$L753:
	lui	$2,%hi(Copspeak_gBank+32) # high
	lw	$3,16($16)
	lw	$2,%lo(Copspeak_gBank+32)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L755
	sra	$2,$4,2
	.set	macro
	.set	reorder

	lw	$2,gMasterFENarrationLevel
	#nop
	sll	$3,$2,7
	addu	$3,$3,$2
	sra	$3,$3,7
	sll	$3,$3,1
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L757
	li	$4,127			# 0x0000007f
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L757
	move	$4,$3
	.set	macro
	.set	reorder

$L755:
	li	$3,128			# 0x00000080
	subu	$3,$3,$2
	sll	$2,$3,7
	lw	$4,gMasterFENarrationLevel
	addu	$2,$2,$3
	mult	$4,$2
	mflo	$6
	#nop
	#nop
	sra	$4,$6,14
$L757:
	lw	$3,Audio_direct3davail
	li	$5,64			# 0x00000040
	sb	$5,25($sp)
	sb	$4,24($sp)
	sltu	$2,$0,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L758
	sb	$2,27($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L759
	sh	$18,32($sp)
	.set	macro
	.set	reorder

$L758:
	lw	$2,gStereoMode
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L760
	li	$2,64			# 0x00000040
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L759
	sb	$2,23($sp)
	.set	macro
	.set	reorder

$L760:
	sb	$5,23($sp)
$L759:
	.set	noreorder
	.set	nomacro
	jal	SNDplay
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	lw	$31,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	CopSpeak_Play__FP17CopSpeak_tRequesti
	.text
	.ent	CopSpeak_Skip__Fv
CopSpeak_Skip__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(CopSpeak_gQueue) # high
	lw	$3,CopSpeak_gQueueLoad
	addiu	$2,$2,%lo(CopSpeak_gQueue) # low
	sw	$31,16($sp)
	sll	$3,$3,5
	addu	$4,$3,$2
	lbu	$3,29($4)
	li	$2,-1			# 0xffffffff
	sw	$2,4($4)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L765
	sw	$2,24($4)
	.set	macro
	.set	reorder

	lb	$4,30($4)
	move	$5,$2
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_LoadAsyncSfx__FiiPvi
	move	$7,$6
	.set	macro
	.set	reorder

$L765:
	lw	$4,CopSpeak_gQueueLoad
	#nop
	slt	$2,$4,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L766
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$4,1
$L766:
	lw	$31,16($sp)
	sw	$3,CopSpeak_gQueueLoad
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_Skip__Fv
	.text
	.ent	CopSpeak_Request__FP17CopSpeak_tRequest
CopSpeak_Request__FP17CopSpeak_tRequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$7,CopSpeak_gQueueHead
	#nop
	slt	$2,$7,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L768
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$7,1
$L768:
	lw	$2,CopSpeak_gQueuePlay
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L777
	lui	$3,%hi(Copspeak_gBank) # high
	.set	macro
	.set	reorder

	lb	$2,30($4)
	addiu	$3,$3,%lo(Copspeak_gBank) # low
	sll	$2,$2,4
	addu	$5,$2,$3
	lw	$2,4($5)
	#nop
	beq	$2,$0,$L777
	lw	$2,8($5)
	#nop
	beq	$2,$0,$L777
	lw	$3,24($4)
	#nop
	bltz	$3,$L777
	lw	$2,12($5)
	#nop
	slt	$2,$2,$3
	beq	$2,$0,$L772
$L777:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L772:
	lw	$2,0($5)
	#nop
	sw	$2,16($4)
	lw	$2,24($4)
	lw	$3,8($5)
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	sw	$2,8($4)
	lw	$2,24($4)
	lw	$3,8($5)
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$2,4($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L777
	sw	$2,12($4)
	.set	macro
	.set	reorder

	lui	$3,%hi(CopSpeak_gQueue) # high
	addiu	$3,$3,%lo(CopSpeak_gQueue) # low
	sll	$2,$7,5
	lw	$5,CopSpeak_gQueueHead
	addu	$2,$2,$3
	lw	$8,0($4)
	lw	$9,4($4)
	lw	$10,8($4)
	lw	$11,12($4)
	sw	$8,0($2)
	sw	$9,4($2)
	sw	$10,8($2)
	sw	$11,12($2)
	lw	$8,16($4)
	lw	$9,20($4)
	lw	$10,24($4)
	lw	$11,28($4)
	sw	$8,16($2)
	sw	$9,20($2)
	sw	$10,24($2)
	sw	$11,28($2)
	slt	$2,$5,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L774
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$6,$5,1
$L774:
	sw	$6,CopSpeak_gQueueHead
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

	.end	CopSpeak_Request__FP17CopSpeak_tRequest
	.text
	.ent	CopSpeak_BankVolume__FP17CopSpeak_tRequest
CopSpeak_BankVolume__FP17CopSpeak_tRequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lb	$3,30($4)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L779
	lw	$2,gMasterAmbientLevel
	j	$31
$L779:
	lw	$2,gMasterFENarrationLevel
	j	$31
	.end	CopSpeak_BankVolume__FP17CopSpeak_tRequest
	.text
	.ent	CopSpeak_LoadNextRequest__Fv
CopSpeak_LoadNextRequest__Fv:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Buffered__Fv
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_Threshold__Fv
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$16,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L781
	li	$17,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L785:
	lw	$5,CopSpeak_gQueueLoad
	lw	$2,CopSpeak_gQueueHead
	#nop
	beq	$5,$2,$L781
	#.set	volatile
	lw	$2,CopSpeak_gQueueReady
	#.set	novolatile
	#nop
	addu	$2,$2,-64
	subu	$2,$5,$2
	andi	$2,$2,0x003f
	slt	$2,$2,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	sll	$3,$5,5
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gQueue) # high
	addiu	$2,$2,%lo(CopSpeak_gQueue) # low
	addu	$16,$3,$2
	lb	$4,30($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L800
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L789
	slt	$2,$5,63
	.set	macro
	.set	reorder

	sw	$17,4($16)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L803
	move	$3,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L803
	addu	$3,$5,1
	.set	macro
	.set	reorder

$L789:
	lbu	$2,29($16)
	#nop
	bne	$2,$0,$L796
	lw	$5,24($16)
	#nop
	bltz	$5,$L807
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L792
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$4,CopSpeak_gQueueLoad
	.set	noreorder
	.set	nomacro
	j	$L806
	sw	$17,4($16)
	.set	macro
	.set	reorder

$L792:
	lbu	$2,29($16)
$L807:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L796
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,8($16)
	lb	$4,30($16)
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_GetAsyncSfx__Fiib
	addu	$5,$5,16384
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L796
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$4,CopSpeak_gQueueLoad
	.set	noreorder
	.set	nomacro
	j	$L806
	sw	$17,4($16)
	.set	macro
	.set	reorder

$L796:
	lw	$2,CopSpeak_gBuffer
	#nop
	beq	$2,$0,$L800
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_BankVolume__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L800
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L800
	slt	$2,$2,32765
	.set	macro
	.set	reorder

	bne	$2,$0,$L799
$L800:
	jal	CopSpeak_Skip__Fv
	j	$L785
$L799:
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_Alloc__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L781
	li	$3,1279852544			# 0x4c490000
	.set	macro
	.set	reorder

	lw	$8,CopSpeak_gBuffer
	ori	$3,$3,0x4146
	addu	$2,$8,$2
	sw	$3,0($2)
	lw	$6,4($16)
	li	$2,100			# 0x00000064
	sw	$2,16($sp)
	sw	$0,20($sp)
	lw	$4,16($16)
	lw	$5,8($16)
	lw	$7,12($16)
	.set	noreorder
	.set	nomacro
	jal	FILE_read
	addu	$6,$8,$6
	.set	macro
	.set	reorder

	sw	$2,20($16)
	lbu	$2,CopSpeak_gHandleCount
	lw	$4,20($16)
	addu	$2,$2,1
	sb	$2,CopSpeak_gHandleCount
	jal	FILE_operror
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L785
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$4,CopSpeak_gQueueLoad
$L806:
	slt	$2,$4,63
	beq	$2,$0,$L803
	addu	$3,$4,1
$L803:
	sw	$3,CopSpeak_gQueueLoad
	j	$L785
$L781:
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

	.end	CopSpeak_LoadNextRequest__Fv
	.text
	.ent	CopSpeak_PlayNextRequest__Fv
CopSpeak_PlayNextRequest__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$3,%hi(CopSpeak_gQueue) # high
	lw	$4,CopSpeak_gQueuePlay
	addiu	$3,$3,%lo(CopSpeak_gQueue) # low
	sw	$31,20($sp)
	sw	$16,16($sp)
	sll	$2,$4,5
	addu	$16,$2,$3
	lb	$2,30($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L818
	slt	$2,$4,63
	.set	macro
	.set	reorder

	lbu	$2,29($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L810
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,CopSpeak_gSpchHandle
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L808
	lui	$2,%hi(CopSpeak_gCurrent) # high
	.set	macro
	.set	reorder

	addiu	$10,$2,%lo(CopSpeak_gCurrent)
	lw	$7,0($16)
	lw	$8,4($16)
	lw	$9,8($16)
	sw	$7,0($10)
	sw	$8,4($10)
	sw	$9,8($10)
	lw	$7,12($16)
	lw	$8,16($16)
	lw	$9,20($16)
	sw	$7,12($10)
	sw	$8,16($10)
	sw	$9,20($10)
	lw	$7,24($16)
	lw	$8,28($16)
	sw	$7,24($10)
	sw	$8,28($10)
	lw	$5,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L812
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,8($16)
	lb	$4,30($16)
	.set	noreorder
	.set	nomacro
	j	$L817
	addu	$5,$5,16384
	.set	macro
	.set	reorder

$L812:
	lb	$4,30($16)
$L817:
	jal	AudioCmn_GetAsyncSfx__Fiib
	move	$5,$2
	.set	noreorder
	.set	nomacro
	bgez	$5,$L815
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lb	$3,30($16)
	#nop
	bne	$3,$2,$L810
$L815:
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_Play__FP17CopSpeak_tRequesti
	move	$4,$16
	.set	macro
	.set	reorder

	sw	$2,CopSpeak_gSpchHandle
$L810:
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,CopSpeak_gQueuePlay
	#nop
	slt	$2,$4,63
$L818:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L816
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$4,1
$L816:
	sw	$3,CopSpeak_gQueuePlay
$L808:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_PlayNextRequest__Fv
	.text
	.ent	CopSpeak_Flush__Fv
CopSpeak_Flush__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,CopSpeak_gQueuePlay
	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L827
	lui	$2,%hi(CopSpeak_gQueue) # high
	.set	macro
	.set	reorder

	addiu	$6,$2,%lo(CopSpeak_gQueue) # low
	li	$5,-1			# 0xffffffff
	sll	$2,$3,5
$L826:
	addu	$2,$2,$6
	sb	$5,30($2)
	slt	$2,$3,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L822
	move	$4,$0
	.set	macro
	.set	reorder

	addu	$4,$3,1
$L822:
	lw	$2,CopSpeak_gQueueHead
	move	$3,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L826
	sll	$2,$3,5
	.set	macro
	.set	reorder

$L827:
	j	$31
	.end	CopSpeak_Flush__Fv
	.text
	.ent	CopSpeak_Server__Fv
CopSpeak_Server__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lw	$2,CopSpeak_gSpchHandle
	li	$3,-1			# 0xffffffff
	sw	$31,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L829
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gCurrent) # high
	addiu	$2,$2,%lo(CopSpeak_gCurrent) # low
	lw	$5,24($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L830
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,8($2)
	lb	$4,30($2)
	.set	noreorder
	.set	nomacro
	j	$L856
	addu	$5,$5,16384
	.set	macro
	.set	reorder

$L830:
	lb	$4,30($2)
$L856:
	jal	AudioCmn_GetAsyncSfx__Fiib
	lw	$4,CopSpeak_gSpchHandle
	jal	SNDtimeremaining
	slt	$2,$2,5
	beq	$2,$0,$L829
	lw	$3,CopSpeak_gQueuePlay
	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L833
	sll	$3,$3,5
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gQueue) # high
	addiu	$2,$2,%lo(CopSpeak_gQueue) # low
	addu	$4,$3,$2
	lb	$3,30($4)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L858
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$3,24($4)
	li	$2,19			# 0x00000013
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L858
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gCurrent) # high
	lw	$2,%lo(CopSpeak_gCurrent)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L858
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$2,20			# 0x00000014
	sw	$2,24($4)
$L833:
	li	$2,-1			# 0xffffffff
$L858:
	sw	$2,CopSpeak_gSpchHandle
	lui	$4,%hi(CopSpeak_gCurrent) # high
	.set	noreorder
	.set	nomacro
	jal	CopSpeak_InitRequest__FP17CopSpeak_tRequest
	addiu	$4,$4,%lo(CopSpeak_gCurrent) # low
	.set	macro
	.set	reorder

$L829:
	lw	$16,CopSpeak_gQueuePlay
	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L836
	lui	$2,%hi(CopSpeak_gQueue) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(CopSpeak_gQueue) # low
	sll	$2,$16,5
$L860:
	addu	$3,$2,$17
	lbu	$2,29($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L859
	slt	$2,$16,63
	.set	macro
	.set	reorder

	lb	$4,30($3)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L859
	slt	$2,$16,63
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$4,$L837
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$5,24($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L840
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$5,8($3)
	#nop
	addu	$5,$5,16384
$L840:
	jal	AudioCmn_GetAsyncSfx__Fiib
$L837:
	slt	$2,$16,63
$L859:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L842
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$16,1
$L842:
	lw	$2,CopSpeak_gQueueHead
	move	$16,$3
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L860
	sll	$2,$16,5
	.set	macro
	.set	reorder

$L836:
	lw	$3,CopSpeak_gQueueReady
	lw	$2,CopSpeak_gQueueLoad
	#nop
	beq	$3,$2,$L845
	jal	CopSpeak_ReadyNextRequest__Fv
$L845:
	lw	$3,CopSpeak_gSpchHandle
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L846
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gCurrent) # high
	.set	noreorder
	.set	nomacro
	j	$L847
	addiu	$4,$2,%lo(CopSpeak_gCurrent) # low
	.set	macro
	.set	reorder

$L846:
	lw	$3,CopSpeak_gQueuePlay
	lw	$2,CopSpeak_gQueueReady
	#nop
	beq	$3,$2,$L847
	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L847
	lui	$2,%hi(CopSpeak_gQueue) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(CopSpeak_gQueue) # low
	slt	$2,$3,63
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L847
	addu	$2,$3,1
	.set	macro
	.set	reorder

	sll	$2,$2,5
	addu	$4,$2,$4
$L847:
	beq	$4,$0,$L850
	lbu	$2,31($4)
	#nop
	beq	$2,$0,$L850
	lw	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L851
	li	$4,48			# 0x00000030
	.set	macro
	.set	reorder

	lh	$2,142($2)
	#nop
	addu	$3,$2,32
	slt	$2,$3,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L851
	li	$4,127			# 0x0000007f
	.set	macro
	.set	reorder

	move	$4,$3
$L851:
	jal	CopSpeak_RadioStaticActive__Fi
	j	$L853
$L850:
	jal	CopSpeak_RadioStaticSquelch__Fv
$L853:
	lw	$3,CopSpeak_gQueueReady
	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L855
	lui	$2,%hi(CopSpeak_gQueue) # high
	.set	macro
	.set	reorder

	addiu	$4,$2,%lo(CopSpeak_gQueue) # low
	sll	$2,$3,5
	addu	$3,$2,$4
	lbu	$2,29($3)
	#nop
	bne	$2,$0,$L855
	lw	$2,CopSpeak_gQueuePlay
	lw	$3,0($3)
	sll	$2,$2,5
	addu	$2,$2,$4
	lw	$2,0($2)
	#nop
	beq	$3,$2,$L854
$L855:
	lw	$3,CopSpeak_gQueuePlay
	lw	$2,CopSpeak_gQueueReady
	#nop
	beq	$3,$2,$L854
	lw	$2,CopSpeak_gQueueHead
	#nop
	beq	$3,$2,$L854
	jal	CopSpeak_PlayNextRequest__Fv
$L854:
	jal	CopSpeak_LoadNextRequest__Fv
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

	.end	CopSpeak_Server__Fv
	.text
	.ent	CopSpeak_SfxQueued__Fv
CopSpeak_SfxQueued__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$4,CopSpeak_gQueuePlay
	lw	$3,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$3,$L863
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(CopSpeak_gQueue) # high
	addiu	$7,$2,%lo(CopSpeak_gQueue) # low
	move	$6,$3
	sll	$2,$4,5
$L869:
	addu	$3,$2,$7
	lb	$2,30($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L868
	slt	$2,$4,63
	.set	macro
	.set	reorder

	lbu	$2,29($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L868
	slt	$2,$4,63
	.set	macro
	.set	reorder

	addu	$5,$5,1
$L868:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L862
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$4,1
$L862:
	move	$4,$3
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L869
	sll	$2,$4,5
	.set	macro
	.set	reorder

$L863:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

	.end	CopSpeak_SfxQueued__Fv
	.text
	.ent	CopSpeak_ShowQueue__Fv
CopSpeak_ShowQueue__Fv:
	.frame	$sp,120,$31		# vars= 72, regs= 3/0, args= 32, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,120
	addu	$4,$sp,34
	move	$5,$0
	sw	$16,104($sp)
	lw	$16,CopSpeak_gQueuePlay
	lui	$2,%hi($LC18) # high
	sw	$31,112($sp)
	sw	$17,108($sp)
	addiu	$11,$2,%lo($LC18)
	lb	$8,0($11)
	lb	$9,1($11)
	sb	$8,32($sp)
	sb	$9,33($sp)
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,64			# 0x00000040
	.set	macro
	.set	reorder

	lw	$2,CopSpeak_gQueueHead
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L871
	lui	$2,%hi(CopSpeak_gQueue) # high
	.set	macro
	.set	reorder

	addiu	$17,$2,%lo(CopSpeak_gQueue) # low
	sll	$2,$16,5
$L893:
	addu	$3,$2,$17
	lb	$4,30($3)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L875
	lui	$5,%hi($LC19) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC19) # low
	.set	macro
	.set	reorder

	j	$L876
$L875:
	lbu	$2,29($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L877
	lui	$5,%hi($LC20) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,32
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC20) # low
	.set	macro
	.set	reorder

	j	$L876
$L877:
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L879
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$5,%hi($LC21) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC21) # low
	.set	macro
	.set	reorder

	j	$L876
$L879:
	lw	$2,24($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L881
	lui	$5,%hi($LC22) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC22) # low
	.set	macro
	.set	reorder

	j	$L876
$L881:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L883
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lui	$5,%hi($LC23) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC23) # low
	.set	macro
	.set	reorder

	j	$L876
$L883:
	lui	$5,%hi($LC24) # high
	addiu	$5,$5,%lo($LC24) # low
	lw	$7,596($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$4
	.set	macro
	.set	reorder

$L876:
	lw	$2,CopSpeak_gQueueReady
	#nop
	.set	noreorder
	.set	nomacro
	beq	$16,$2,$L891
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	lw	$2,CopSpeak_gQueueLoad
	#nop
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L892
	slt	$2,$16,63
	.set	macro
	.set	reorder

	addu	$4,$sp,32
$L891:
	lui	$5,%hi($LC25) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC25) # low
	.set	macro
	.set	reorder

	slt	$2,$16,63
$L892:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L887
	move	$3,$0
	.set	macro
	.set	reorder

	addu	$3,$16,1
$L887:
	lw	$2,CopSpeak_gQueueHead
	move	$16,$3
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L893
	sll	$2,$16,5
	.set	macro
	.set	reorder

$L871:
	.set	noreorder
	.set	nomacro
	jal	strlen
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L870
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	li	$5,10			# 0x0000000a
	.set	noreorder
	.set	nomacro
	jal	Font_TextXY__FPcii
	li	$6,6			# 0x00000006
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	textpixels
	addu	$4,$sp,32
	.set	macro
	.set	reorder

	li	$3,1638400			# 0x00190000
	ori	$3,$3,0x0505
	li	$4,1			# 0x00000001
	li	$5,8			# 0x00000008
	li	$6,9			# 0x00000009
	addu	$7,$2,5
	move	$2,$6
	sw	$2,16($sp)
	sw	$3,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	Hud_FBuildF4__FiiiiiUlcc
	sw	$0,28($sp)
	.set	macro
	.set	reorder

$L870:
	lw	$31,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,120
	.set	macro
	.set	reorder

	.end	CopSpeak_ShowQueue__Fv
	.text
	.ent	CopSpeak_Debug__Fv
CopSpeak_Debug__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	CopSpeak_ShowQueue__Fv
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	CopSpeak_Debug__Fv
