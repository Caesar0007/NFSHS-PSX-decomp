	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\video.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"%sDCT.BIN\000"
	.align	2
$LC1:
	.ascii	"Videostruct\000"
	.align	2
$LC2:
	.ascii	"streambuffer\000"
	.text
	.align	2
	.globl	VIDEO_create__Fiiiii
	.align	2
	.globl	VIDEO_destroy__Fi
	.align	2
	.globl	VIDEO_spoolfile__FiPc
	.align	2
	.globl	VIDEO_startplayback__Fi
	.align	2
	.globl	VIDEO_abortplayback__Fi
	.align	2
	.globl	VIDEO_state__Fi
	.align	2
	.globl	VIDEO_updateframexy__Fiii
	.align	2
	.globl	videoupdatetime__FP11VIDEOSTRUCT
	.align	2
	.globl	videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii

	.extern	timerhz, 4
	.extern	ticks, 4

	.text
	.text
	.ent	VIDEO_create__Fiiiii
VIDEO_create__Fiiiii:
	.frame	$sp,144,$31		# vars= 88, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,144
	sw	$17,116($sp)
	lw	$17,160($sp)
	sw	$19,124($sp)
	move	$19,$4
	sw	$20,128($sp)
	move	$20,$5
	sw	$21,132($sp)
	move	$21,$6
	sw	$18,120($sp)
	move	$18,$7
	sw	$31,136($sp)
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	sw	$16,112($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,48
	move	$4,$16
	lui	$2,%hi(Paths_Paths+128) # high
	lui	$5,%hi($LC0) # high
	lw	$6,%lo(Paths_Paths+128)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC0) # low
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$5,%hi(CF_DVLC) # high
	.set	noreorder
	.set	nomacro
	jal	asyncloadfileat
	addiu	$5,$5,%lo(CF_DVLC) # low
	.set	macro
	.set	reorder

	move	$16,$2
$L601:
	.set	noreorder
	.set	nomacro
	jal	getasyncreadstatus
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L602
	lui	$4,%hi($LC1) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L601
$L602:
	addiu	$4,$4,%lo($LC1) # low
	li	$5,64			# 0x00000040
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$17
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	blockclear
	li	$5,64			# 0x00000040
	.set	macro
	.set	reorder

	li	$2,1464074240			# 0x57440000
	ori	$2,$2,0x4956
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	move	$5,$18
	move	$6,$17
	sw	$2,0($16)
	sw	$19,4($16)
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$20,8($16)
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
	move	$5,$4
	sw	$2,12($16)
	sw	$18,16($sp)
	lw	$7,12($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_create
	move	$6,$4
	.set	macro
	.set	reorder

	li	$5,1			# 0x00000001
	li	$6,65535			# 0x0000ffff
	sw	$2,24($16)
	li	$2,2			# 0x00000002
	sw	$2,16($sp)
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_setfilter
	li	$7,17235			# 0x00004353
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$20
	lui	$2,%hi(screenbpp) # high
	lw	$6,%lo(screenbpp)($2)
	.set	noreorder
	.set	nomacro
	jal	initmdec
	move	$7,$17
	.set	macro
	.set	reorder

	lui	$3,%hi(timerhz) # high
	lw	$4,%lo(timerhz)($3)
	li	$5,655360			# 0x000a0000
	sw	$2,16($16)
	.set	noreorder
	.set	nomacro
	jal	fixedmult
	sll	$4,$4,16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	fixeddiv
	move	$5,$21
	.set	macro
	.set	reorder

	sw	$2,48($16)
	move	$2,$16
	sw	$0,28($2)
	lw	$31,136($sp)
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

	.end	VIDEO_create__Fiiiii
	.text
	.ent	VIDEO_destroy__Fi
VIDEO_destroy__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$3,1464074240			# 0x57440000
	sw	$31,20($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	bne	$2,$3,$L604
	lw	$4,16($16)
	.set	noreorder
	.set	nomacro
	jal	restoremdec
	sw	$0,0($16)
	.set	macro
	.set	reorder

	lw	$4,24($16)
	jal	STREAM_destroy
	lw	$4,12($16)
	jal	purgememadr
$L604:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	VIDEO_destroy__Fi
	.text
	.ent	VIDEO_spoolfile__FiPc
VIDEO_spoolfile__FiPc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$3,1464074240			# 0x57440000
	sw	$31,20($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	bne	$2,$3,$L606
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_queuefile
	move	$7,$6
	.set	macro
	.set	reorder

	sw	$2,32($16)
	li	$2,1			# 0x00000001
	sw	$2,28($16)
$L606:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	VIDEO_spoolfile__FiPc
	.text
	.ent	VIDEO_startplayback__Fi
VIDEO_startplayback__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$3,1464074240			# 0x57440000
	sw	$31,20($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	bne	$2,$3,$L608
	lw	$2,28($16)
	#nop
	beq	$2,$0,$L608
	lw	$4,24($16)
	jal	STREAM_bufferusage
	slt	$2,$2,20001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L608
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	sw	$2,28($16)
$L608:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	VIDEO_startplayback__Fi
	.text
	.ent	VIDEO_abortplayback__Fi
VIDEO_abortplayback__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	li	$3,1464074240			# 0x57440000
	sw	$31,20($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	bne	$2,$3,$L611
	lw	$4,24($16)
	jal	STREAM_kill
	sw	$0,28($16)
$L611:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	VIDEO_abortplayback__Fi
	.text
	.ent	VIDEO_state__Fi
VIDEO_state__Fi:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$16,32($sp)
	move	$16,$4
	li	$3,1464074240			# 0x57440000
	sw	$31,36($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L619
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,28($16)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L615
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$4,24($16)
	jal	STREAM_state
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L617
	lui	$2,%hi(ticks) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(ticks)($2)
	li	$2,3			# 0x00000003
	sw	$2,28($16)
	sw	$0,40($16)
	sw	$0,44($16)
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L617
	sw	$2,36($16)
	.set	macro
	.set	reorder

$L615:
	bne	$3,$2,$L617
	lw	$4,24($16)
	jal	STREAM_state
	bne	$2,$0,$L617
	sw	$0,28($16)
$L617:
	lw	$2,28($16)
$L619:
	lw	$31,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	VIDEO_state__Fi
	.text
	.ent	VIDEO_updateframexy__Fiii
VIDEO_updateframexy__Fiii:
	.frame	$sp,64,$31		# vars= 16, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,48($sp)
	move	$20,$5
	sw	$21,52($sp)
	li	$3,1464074240			# 0x57440000
	sw	$16,32($sp)
	move	$16,$4
	sw	$31,56($sp)
	sw	$19,44($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	lw	$2,0($16)
	ori	$3,$3,0x4956
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L621
	move	$21,$6
	.set	macro
	.set	reorder

	lw	$3,28($16)
	li	$2,3			# 0x00000003
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L637
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,ticks
	lw	$4,36($16)
	sll	$3,$2,2
	addu	$3,$3,$2
	sll	$3,$3,1
	lw	$2,40($16)
	subu	$19,$3,$4
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,24($16)
	jal	STREAM_isendofstream
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L637
	move	$2,$0
	.set	macro
	.set	reorder

$L639:
	lw	$4,24($16)
	jal	STREAM_get
	move	$18,$2
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L637
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	videoupdatetime__FP11VIDEOSTRUCT
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$2,40($16)
	#nop
	slt	$2,$19,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L631
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$18
	move	$6,$20
	.set	noreorder
	.set	nomacro
	jal	videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii
	move	$7,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L632
	move	$17,$0
	.set	macro
	.set	reorder

$L631:
	lw	$2,60($16)
	li	$17,1			# 0x00000001
	addu	$2,$2,$17
	sw	$2,60($16)
$L632:
	lw	$4,24($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_release
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L637
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$4,24($16)
	jal	STREAM_isendofstream
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L639
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	j	$L637
$L621:
	move	$2,$0
$L637:
	lw	$31,56($sp)
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
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	VIDEO_updateframexy__Fiii
	.text
	.ent	videoupdatetime__FP11VIDEOSTRUCT
videoupdatetime__FP11VIDEOSTRUCT:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,44($4)
	lw	$2,48($4)
	#nop
	addu	$3,$3,$2
	sw	$3,44($4)
	sra	$3,$3,16
	lw	$2,40($4)
	lhu	$5,44($4)
	addu	$2,$2,$3
	sw	$2,40($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,44($4)
	.set	macro
	.set	reorder

	.end	videoupdatetime__FP11VIDEOSTRUCT
	.text
	.ent	videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii
videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	li	$3,1145241600			# 0x44430000
	sw	$31,24($sp)
	sw	$17,20($sp)
	lw	$2,0($5)
	ori	$3,$3,0x546d
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L645
	move	$16,$4
	.set	macro
	.set	reorder

	lh	$2,12($5)
	lw	$4,16($16)
	sw	$2,52($16)
	lh	$2,14($5)
	addu	$5,$5,8
	.set	noreorder
	.set	nomacro
	jal	mdec
	sw	$2,56($16)
	.set	macro
	.set	reorder

	lui	$3,%hi(ticks) # high
	lw	$2,timerhz
	lw	$3,%lo(ticks)($3)
	sll	$2,$2,2
	addu	$17,$3,$2
$L646:
	lw	$4,16($16)
	jal	mdecdone
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L659
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$2,ticks
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L646
	jal	mdecreset__Fv
$L645:
	move	$2,$0
$L659:
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

	.end	videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii
