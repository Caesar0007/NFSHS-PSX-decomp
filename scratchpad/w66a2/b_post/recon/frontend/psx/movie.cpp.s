	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\frontend\\\\psx\\\\movie.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"vlcbuf0\000"
	.align	2
$LC1:
	.ascii	"vlcbuf1\000"
	.align	2
$LC2:
	.ascii	"imgbuf\000"
	.align	2
$LC3:
	.ascii	"sect_buff\000"
	.text
	.align	2
	.globl	Movie_Init__Fc
	.align	2
	.globl	Movie_DeInit__Fv
	.align	2
	.globl	Movie_SetDecodeOffset__Fssss
	.rdata
	.align	2
$LC4:
	.ascii	"\\MOVIES\\%s;1\000"
	.text
	.align	2
	.globl	Movie_Load__Fc
	.align	2
	.globl	Movie_NextFrame__Fv
	.align	2
	.globl	Movie_DownloadFrame__Fv
	.align	2
	.globl	Movie_Stop__Fv
	.align	2
	.globl	Movie_Finished__Fv
	.align	2
	.globl	Movie_Play__Fc
	.align	2
	.globl	play_movie__Fc
	.align	2
	.globl	strSetDefDecEnv__FP6DECENV
	.align	2
	.globl	strInit__FP6CdlLOCiPFe_vT2
	.align	2
	.globl	strCallback__Fv
	.align	2
	.globl	strNextVlc__FP6DECENV
	.align	2
	.globl	strNext__FP6DECENV
	.align	2
	.globl	strSync__FP6DECENVi
	.align	2
	.globl	strKickCD__FP6CdlLOC
	.section .bss,"aw",@progbits
	.align	2
width:
	.space	4
	.align	2
height:
	.space	4
	.align	2
loc:
	.space	4
	.align	1
PPWTop:
	.space	2
	.align	1
PPWBottom:
	.space	2
	.align	1
gMode:
	.space	2
	.align	2
gIsRGB24:
	.space	4
	.align	1
gMovieHeight:
	.space	2
	.align	1
gMovieWidth:
	.space	2
	.align	2
gMovieFrame:
	.space	4
	.align	2
gEndFrame:
	.space	4
	.align	2
bMovieLoaded:
	.space	4
	.align	2
bStopMovie:
	.space	4
	.align	2
bRewindMovie:
	.space	4
	.align	2
isFirstSlice:
	.space	4

	.lcomm	dec,48
	.align	2
vlcbuf0:
	.space	4
	.align	2
vlcbuf1:
	.space	4
	.align	2
imgbuf:
	.space	4
	.align	2
sect_buff:
	.space	4

	.extern	skip_all, 1
	.extern	gMasterMusicLevel, 4
	.extern	movieframes, 10
	.extern	movienames, 20
	.extern	movieheight, 10
	.extern	moviewidth, 10
	.extern	movie24bit, 20

	.text
	.text
	.ent	Movie_Init__Fc
Movie_Init__Fc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lui	$2,%hi(movie24bit) # high
	addiu	$2,$2,%lo(movie24bit) # low
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L601
	move	$7,$4
	.set	macro
	.set	reorder

	lui	$3,%hi(PPWTop) # high
	li	$2,3			# 0x00000003
	sh	$2,%lo(PPWTop)($3)
	lui	$3,%hi(PPWBottom) # high
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	j	$L602
	sh	$2,%lo(PPWBottom)($3)
	.set	macro
	.set	reorder

$L601:
	lui	$2,%hi(PPWTop) # high
	li	$3,1			# 0x00000001
	sh	$3,%lo(PPWTop)($2)
	lui	$2,%hi(PPWBottom) # high
	sh	$3,%lo(PPWBottom)($2)
$L602:
	move	$4,$0
	move	$5,$4
	move	$6,$4
	lui	$2,%hi(moviewidth) # high
	addiu	$2,$2,%lo(moviewidth) # low
	andi	$3,$7,0x00ff
	sll	$3,$3,1
	addu	$2,$3,$2
	lhu	$7,0($2)
	lui	$2,%hi(gMovieWidth) # high
	sh	$7,%lo(gMovieWidth)($2)
	lui	$2,%hi(movieheight) # high
	addiu	$2,$2,%lo(movieheight) # low
	addu	$3,$3,$2
	lui	$2,%hi(gMovieHeight) # high
	lhu	$3,0($3)
	li	$7,256			# 0x00000100
	.set	noreorder
	.set	nomacro
	jal	Movie_SetDecodeOffset__Fssss
	sh	$3,%lo(gMovieHeight)($2)
	.set	macro
	.set	reorder

	move	$4,$0
	lui	$2,%hi(gMovieFrame) # high
	sw	$0,%lo(gMovieFrame)($2)
	lui	$2,%hi(gEndFrame) # high
	sw	$0,%lo(gEndFrame)($2)
	lui	$2,%hi(bMovieLoaded) # high
	.set	noreorder
	.set	nomacro
	jal	settrans
	sw	$0,%lo(bMovieLoaded)($2)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,131072			# 0x00020000
	ori	$5,$5,0x8000
	li	$6,16			# 0x00000010
	lui	$2,%hi(download) # high
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sh	$0,%lo(download)($2)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC1) # high
	addiu	$4,$4,%lo($LC1) # low
	li	$5,131072			# 0x00020000
	ori	$5,$5,0x8000
	li	$6,16			# 0x00000010
	lui	$3,%hi(vlcbuf0) # high
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,%lo(vlcbuf0)($3)
	.set	macro
	.set	reorder

	lui	$3,%hi(PPWTop) # high
	lui	$4,%hi(PPWBottom) # high
	lh	$3,%lo(PPWTop)($3)
	lh	$4,%lo(PPWBottom)($4)
	sll	$3,$3,5
	divu	$3,$3,$4
	li	$6,16			# 0x00000010
	lui	$5,%hi(vlcbuf1) # high
	sw	$2,%lo(vlcbuf1)($5)
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	sll	$5,$3,4
	subu	$5,$5,$3
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sll	$5,$5,5
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,65536			# 0x00010000
	li	$6,16			# 0x00000010
	lui	$3,%hi(imgbuf) # high
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	sw	$2,%lo(imgbuf)($3)
	.set	macro
	.set	reorder

	lui	$3,%hi(sect_buff) # high
	.set	noreorder
	.set	nomacro
	jal	Platform_ResetDCTBuffer__Fv
	sw	$2,%lo(sect_buff)($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CD_Restart
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,11			# 0x0000000b
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	li	$4,12			# 0x0000000c
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCTvlcSize
	move	$4,$0
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

	.end	Movie_Init__Fc
	.text
	.ent	Movie_DeInit__Fv
Movie_DeInit__Fv:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	li	$4,14			# 0x0000000e
	addu	$5,$sp,16
	move	$6,$0
	lui	$2,%hi(bMovieLoaded) # high
	sw	$0,%lo(bMovieLoaded)($2)
	li	$2,128			# 0x00000080
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	sb	$2,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	move	$4,$0
	.set	macro
	.set	reorder

	jal	StUnSetRing
	.set	noreorder
	.set	nomacro
	jal	CdDataCallback
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,11			# 0x0000000b
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	li	$4,9			# 0x00000009
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	li	$4,12			# 0x0000000c
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$5
	.set	macro
	.set	reorder

	lui	$2,%hi(vlcbuf0) # high
	lw	$4,%lo(vlcbuf0)($2)
	jal	purgememadr
	lui	$2,%hi(vlcbuf1) # high
	lw	$4,%lo(vlcbuf1)($2)
	jal	purgememadr
	lui	$2,%hi(imgbuf) # high
	lw	$4,%lo(imgbuf)($2)
	jal	purgememadr
	lui	$2,%hi(sect_buff) # high
	lw	$4,%lo(sect_buff)($2)
	jal	purgememadr
	jal	Platform_ResetDCTBuffer__Fv
	.set	noreorder
	.set	nomacro
	jal	CD_Restart
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Movie_DeInit__Fv
	.text
	.ent	Movie_SetDecodeOffset__Fssss
Movie_SetDecodeOffset__Fssss:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(gMovieWidth) # high
	lui	$3,%hi(PPWTop) # high
	lh	$8,%lo(gMovieWidth)($2)
	lh	$2,%lo(PPWTop)($3)
	#nop
	mult	$8,$2
	lui	$2,%hi(PPWBottom) # high
	mflo	$8
	#nop
	lh	$3,%lo(PPWBottom)($2)
	#nop
	div	$3,$8,$3
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(dec+16) # high
	sh	$4,%lo(dec+16)($2)
	addiu	$2,$2,%lo(dec+16) # low
	move	$4,$2
	sh	$5,2($4)
	move	$5,$0
	sh	$6,8($4)
	move	$6,$5
	lhu	$2,gMovieHeight
	addu	$16,$4,8
	sh	$7,2($16)
	move	$7,$5
	sh	$2,6($4)
	sh	$2,6($16)
	sh	$3,4($4)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$3,4($16)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	move	$7,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
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

	.end	Movie_SetDecodeOffset__Fssss
	.text
	.ent	Movie_Load__Fc
Movie_Load__Fc:
	.frame	$sp,136,$31		# vars= 104, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,136
	sw	$16,120($sp)
	move	$16,$4
	lui	$2,%hi(bMovieLoaded) # high
	sw	$0,%lo(bMovieLoaded)($2)
	lui	$2,%hi(bRewindMovie) # high
	sw	$0,%lo(bRewindMovie)($2)
	lui	$2,%hi(bStopMovie) # high
	sw	$0,%lo(bStopMovie)($2)
	lui	$2,%hi(download) # high
	sh	$0,%lo(download)($2)
	lui	$2,%hi(isFirstSlice) # high
	sw	$18,128($sp)
	li	$18,1			# 0x00000001
	sw	$31,132($sp)
	sw	$17,124($sp)
	.set	noreorder
	.set	nomacro
	jal	ResetCallback
	sw	$18,%lo(isFirstSlice)($2)
	.set	macro
	.set	reorder

	addu	$4,$sp,40
	lui	$2,%hi(movienames) # high
	addiu	$2,$2,%lo(movienames) # low
	andi	$16,$16,0x00ff
	sll	$17,$16,2
	addu	$2,$17,$2
	lui	$5,%hi($LC4) # high
	lw	$6,0($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(gMovieFrame) # high
	sw	$0,%lo(gMovieFrame)($2)
	lui	$2,%hi(movieframes) # high
	addiu	$2,$2,%lo(movieframes) # low
	sll	$16,$16,$18
	addu	$2,$16,$2
	lh	$2,0($2)
	lui	$3,%hi(gEndFrame) # high
	addu	$2,$2,-1
	sw	$2,%lo(gEndFrame)($3)
	lui	$2,%hi(movie24bit) # high
	addiu	$2,$2,%lo(movie24bit) # low
	addu	$17,$17,$2
	lw	$4,0($17)
	lui	$2,%hi(gIsRGB24) # high
	sw	$4,%lo(gIsRGB24)($2)
	lui	$2,%hi(moviewidth) # high
	addiu	$2,$2,%lo(moviewidth) # low
	addu	$2,$16,$2
	lhu	$3,0($2)
	lui	$2,%hi(gMovieWidth) # high
	sh	$3,%lo(gMovieWidth)($2)
	lui	$2,%hi(movieheight) # high
	addiu	$2,$2,%lo(movieheight) # low
	addu	$16,$16,$2
	lhu	$3,0($16)
	lui	$2,%hi(gMovieHeight) # high
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L606
	sh	$3,%lo(gMovieHeight)($2)
	.set	macro
	.set	reorder

	lui	$2,%hi(PPWTop) # high
	li	$4,3			# 0x00000003
	lui	$3,%hi(PPWBottom) # high
	sh	$4,%lo(PPWTop)($2)
	li	$2,2			# 0x00000002
	sh	$2,%lo(PPWBottom)($3)
	lui	$2,%hi(gMode) # high
	.set	noreorder
	.set	nomacro
	j	$L607
	sh	$4,%lo(gMode)($2)
	.set	macro
	.set	reorder

$L606:
	lui	$2,%hi(PPWTop) # high
	sh	$18,%lo(PPWTop)($2)
	lui	$2,%hi(PPWBottom) # high
	lui	$3,%hi(gMode) # high
	sh	$18,%lo(PPWBottom)($2)
	li	$2,2			# 0x00000002
	sh	$2,%lo(gMode)($3)
$L607:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdSearchFile
	addu	$5,$sp,40
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L605
	lui	$17,%hi(dec) # high
	.set	macro
	.set	reorder

	addiu	$17,$17,%lo(dec) # low
	move	$4,$17
	lbu	$2,16($sp)
	lbu	$3,18($sp)
	lui	$16,%hi(loc) # high
	sb	$2,%lo(loc)($16)
	lbu	$2,17($sp)
	addiu	$16,$16,%lo(loc) # low
	sb	$3,2($16)
	.set	noreorder
	.set	nomacro
	jal	strSetDefDecEnv__FP6DECENV
	sb	$2,1($16)
	.set	macro
	.set	reorder

	move	$4,$16
	li	$5,268369920			# 0x0fff0000
	ori	$5,$5,0xffff
	lui	$6,%hi(strCallback__Fv) # high
	addiu	$6,$6,%lo(strCallback__Fv) # low
	.set	noreorder
	.set	nomacro
	jal	strInit__FP6CdlLOCiPFe_vT2
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strNextVlc__FP6DECENV
	move	$4,$17
	.set	macro
	.set	reorder

	lui	$3,%hi(bMovieLoaded) # high
	li	$2,1			# 0x00000001
	sw	$2,%lo(bMovieLoaded)($3)
$L605:
	lw	$31,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,136
	.set	macro
	.set	reorder

	.end	Movie_Load__Fc
	.text
	.ent	Movie_NextFrame__Fv
Movie_NextFrame__Fv:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(dec) # high
	sw	$16,24($sp)
	addiu	$16,$2,%lo(dec) # low
	lui	$3,%hi(gMode) # high
	sw	$31,28($sp)
	lw	$2,8($16)
	lh	$5,%lo(gMode)($3)
	sll	$2,$2,2
	addu	$2,$2,$16
	lw	$4,0($2)
	jal	DecDCTin
	.set	noreorder
	.set	nomacro
	jal	DecDCTinSync
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$2,%hi(PPWTop) # high
	lui	$4,%hi(PPWBottom) # high
	lh	$3,%lo(PPWTop)($2)
	lh	$2,%lo(PPWBottom)($4)
	sll	$3,$3,4
	div	$3,$3,$2
	lh	$2,40($16)
	#nop
	addu	$2,$2,-1
	div	$2,$2,$3
	addu	$2,$2,1
	mult	$2,$3
	lh	$3,42($16)
	#nop
	addu	$2,$3,-1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L610
	sll	$5,$7,4
	.set	macro
	.set	reorder

	addu	$2,$3,14
$L610:
	sra	$2,$2,4
	addu	$2,$2,1
	mult	$5,$2
	lw	$4,12($16)
	mflo	$6
	#nop
	.set	noreorder
	.set	nomacro
	jal	DecDCTout
	sra	$5,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strNextVlc__FP6DECENV
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L611
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strSync__FP6DECENVi
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L612
	move	$2,$0
	.set	macro
	.set	reorder

$L611:
	li	$2,-1			# 0xffffffff
$L612:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	Movie_NextFrame__Fv
	.text
	.ent	Movie_DownloadFrame__Fv
Movie_DownloadFrame__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(download) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$2,%lo(download)($3)
	.set	macro
	.set	reorder

	.end	Movie_DownloadFrame__Fv
	.text
	.ent	Movie_Stop__Fv
Movie_Stop__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(bStopMovie) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,%lo(bStopMovie)($3)
	.set	macro
	.set	reorder

	.end	Movie_Stop__Fv
	.text
	.ent	Movie_Finished__Fv
Movie_Finished__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(gMovieFrame) # high
	lui	$3,%hi(gEndFrame) # high
	lw	$2,%lo(gMovieFrame)($2)
	lw	$3,%lo(gEndFrame)($3)
	#nop
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(bMovieLoaded) # high
	lw	$2,%lo(bMovieLoaded)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L617
	lui	$2,%hi(bStopMovie) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(bStopMovie)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L617
	lui	$2,%hi(bRewindMovie) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(bRewindMovie)($2)
	#nop
	beq	$2,$0,$L616
$L617:
	li	$4,1			# 0x00000001
$L616:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	Movie_Finished__Fv
	.text
	.ent	Movie_Play__Fc
Movie_Play__Fc:
	.frame	$sp,184,$31		# vars= 136, regs= 6/0, args= 24, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	lw	$2,gMasterMusicLevel
	subu	$sp,$sp,184
	sw	$16,160($sp)
	move	$16,$4
	sw	$17,164($sp)
	addu	$17,$sp,48
	sw	$20,176($sp)
	lui	$20,%hi(gIsRGB24) # high
	sw	$19,172($sp)
	li	$19,1			# 0x00000001
	sw	$31,180($sp)
	sw	$18,168($sp)
	sll	$4,$2,7
	subu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	SNDcdvol
	sra	$4,$4,7
	.set	macro
	.set	reorder

	andi	$16,$16,0x00ff
	.set	noreorder
	.set	nomacro
	jal	Movie_Init__Fc
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	Movie_Load__Fc
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$2,%hi(dec) # high
	addiu	$18,$2,%lo(dec) # low
$L621:
	jal	Movie_Finished__Fv
	xori	$2,$2,0x0001
	beq	$2,$0,$L620
	jal	Movie_NextFrame__Fv
	li	$3,-1			# 0xffffffff
	beq	$2,$3,$L620
	lw	$16,32($18)
	#nop
	sltu	$16,$16,1
	sll	$16,$16,3
	addu	$16,$16,$18
	lh	$5,16($16)
	lh	$6,18($16)
	lh	$7,20($16)
	lh	$2,22($16)
	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	SetDefDispEnv
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	li	$2,240			# 0x000000f0
	sh	$2,38($sp)
	lh	$5,16($16)
	lh	$6,18($16)
	lh	$7,20($16)
	lh	$2,22($16)
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	SetDefDrawEnv
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$2,%lo(gIsRGB24)($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L624
	li	$3,1431633920			# 0x55550000
	.set	macro
	.set	reorder

	lh	$2,28($sp)
	ori	$3,$3,0x5556
	sll	$2,$2,1
	mult	$2,$3
	li	$3,1			# 0x00000001
	sra	$2,$2,31
	sb	$3,41($sp)
	mfhi	$8
	#nop
	#nop
	subu	$2,$8,$2
	sh	$2,28($sp)
$L624:
	.set	noreorder
	.set	nomacro
	jal	PutDispEnv
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PutDrawEnv
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SetDispMask
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,%lo(gIsRGB24)($20)
	#nop
	bne	$2,$0,$L625
	.set	noreorder
	.set	nomacro
	jal	FntFlush
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L625:
	jal	Movie_DownloadFrame__Fv
	lui	$2,%hi(download) # high
	.set	noreorder
	.set	nomacro
	jal	PAD_update
	sh	$19,%lo(download)($2)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,4			# 0x00000004
	.set	noreorder
	.set	nomacro
	jal	PAD_state
	move	$16,$2
	.set	macro
	.set	reorder

	or	$16,$16,$2
	andi	$16,$16,0xffff
	beq	$16,$0,$L621
	jal	Movie_Stop__Fv
	lbu	$2,skip_all
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L630
	lui	$2,%hi(user_exit) # high
	.set	macro
	.set	reorder

	li	$2,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L621
	lui	$2,%hi(user_exit) # high
	.set	macro
	.set	reorder

$L630:
	.set	noreorder
	.set	nomacro
	j	$L621
	sh	$19,%lo(user_exit)($2)
	.set	macro
	.set	reorder

$L620:
	.set	noreorder
	.set	nomacro
	jal	Movie_DeInit__Fv
	lui	$16,%hi(dec+16) # high
	.set	macro
	.set	reorder

	addiu	$16,$16,%lo(dec+16) # low
	move	$4,$16
	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	move	$7,$5
	.set	macro
	.set	reorder

	addu	$4,$16,8
	move	$5,$0
	move	$6,$5
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	move	$7,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	DrawSync
	move	$4,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(user_exit) # high
	lh	$2,%lo(user_exit)($2)
	lw	$31,180($sp)
	lw	$20,176($sp)
	lw	$19,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,184
	.set	macro
	.set	reorder

	.end	Movie_Play__Fc
	.text
	.ent	play_movie__Fc
play_movie__Fc:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Movie_Play__Fc
	andi	$4,$4,0x00ff
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

	.end	play_movie__Fc
	.text
	.ent	strSetDefDecEnv__FP6DECENV
strSetDefDecEnv__FP6DECENV:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(PPWTop) # high
	lui	$3,%hi(PPWBottom) # high
	lh	$5,%lo(PPWTop)($2)
	lh	$2,%lo(PPWBottom)($3)
	sll	$5,$5,4
	div	$5,$5,$2
	lui	$3,%hi(vlcbuf1) # high
	lui	$6,%hi(imgbuf) # high
	lui	$7,%hi(gMovieHeight) # high
	lw	$3,%lo(vlcbuf1)($3)
	lw	$6,%lo(imgbuf)($6)
	lhu	$7,%lo(gMovieHeight)($7)
	lui	$2,%hi(vlcbuf0) # high
	lw	$2,%lo(vlcbuf0)($2)
	sw	$0,8($4)
	sw	$0,32($4)
	sw	$0,44($4)
	sh	$0,36($4)
	sh	$0,38($4)
	sw	$3,4($4)
	sw	$6,12($4)
	sh	$7,42($4)
	sw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$5,40($4)
	.set	macro
	.set	reorder

	.end	strSetDefDecEnv__FP6DECENV
	.text
	.ent	strInit__FP6CdlLOCiPFe_vT2
strInit__FP6CdlLOCiPFe_vT2:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$16,24($sp)
	move	$16,$6
	sw	$17,28($sp)
	move	$17,$7
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	DecDCTReset
	move	$4,$0
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$2,%hi(bRewindMovie) # high
	.set	noreorder
	.set	nomacro
	jal	DecDCToutCallback
	sw	$0,%lo(bRewindMovie)($2)
	.set	macro
	.set	reorder

	lui	$2,%hi(sect_buff) # high
	lw	$4,%lo(sect_buff)($2)
	.set	noreorder
	.set	nomacro
	jal	StSetRing
	li	$5,32			# 0x00000020
	.set	macro
	.set	reorder

	jal	StClearRing
	lui	$2,%hi(gIsRGB24) # high
	li	$5,1			# 0x00000001
	move	$6,$18
	lw	$4,%lo(gIsRGB24)($2)
	move	$7,$0
	.set	noreorder
	.set	nomacro
	jal	StSetStream
	sw	$17,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strKickCD__FP6CdlLOC
	move	$4,$19
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	strInit__FP6CdlLOCiPFe_vT2
	.text
	.ent	strCallback__Fv
strCallback__Fv:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(gIsRGB24) # high
	lw	$2,%lo(gIsRGB24)($2)
	subu	$sp,$sp,32
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L635
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lui	$16,%hi(StCdIntrFlag) # high
	lw	$2,%lo(StCdIntrFlag)($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L644
	lui	$2,%hi(download) # high
	.set	macro
	.set	reorder

	jal	StCdInterrupt
	sw	$0,%lo(StCdIntrFlag)($16)
$L635:
	lui	$2,%hi(download) # high
$L644:
	lh	$2,%lo(download)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L636
	lui	$4,%hi(dec+36) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(dec+36) # low
	lw	$5,-24($4)
	jal	LoadImage
$L636:
	lui	$7,%hi(isFirstSlice) # high
	lw	$2,%lo(isFirstSlice)($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L637
	lui	$2,%hi(PPWTop) # high
	.set	macro
	.set	reorder

	lui	$3,%hi(PPWBottom) # high
	lh	$6,%lo(PPWTop)($2)
	lh	$4,%lo(PPWBottom)($3)
	sll	$3,$6,4
	div	$3,$3,$4
	lui	$2,%hi(dec) # high
	addiu	$5,$2,%lo(dec) # low
	lw	$2,32($5)
	#nop
	sll	$2,$2,3
	addu	$2,$2,$5
	lh	$2,20($2)
	#nop
	rem	$3,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L637
	mult	$3,$6
	.set	macro
	.set	reorder

	mflo	$3
	#nop
	#nop
	div	$3,$3,$4
	lhu	$2,36($5)
	sw	$0,%lo(isFirstSlice)($7)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L639
	sh	$2,36($5)
	.set	macro
	.set	reorder

$L637:
	lui	$2,%hi(PPWTop) # high
	lui	$3,%hi(PPWBottom) # high
	lh	$4,%lo(PPWTop)($2)
	lh	$2,%lo(PPWBottom)($3)
	sll	$4,$4,4
	div	$4,$4,$2
	lui	$3,%hi(dec) # high
	addiu	$3,$3,%lo(dec) # low
	lhu	$2,36($3)
	#nop
	addu	$2,$2,$4
	sh	$2,36($3)
$L639:
	lui	$2,%hi(dec) # high
	addiu	$6,$2,%lo(dec) # low
	lw	$7,32($6)
	#nop
	sll	$2,$7,3
	addu	$2,$2,$6
	lh	$3,16($2)
	lh	$4,20($2)
	lh	$2,36($6)
	addu	$3,$3,$4
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L640
	lui	$2,%hi(PPWTop) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(PPWBottom) # high
	lh	$3,%lo(PPWTop)($2)
	lh	$2,%lo(PPWBottom)($4)
	sll	$3,$3,4
	div	$3,$3,$2
	lh	$2,40($6)
	#nop
	addu	$2,$2,-1
	div	$2,$2,$3
	addu	$2,$2,1
	mult	$2,$3
	lh	$3,42($6)
	#nop
	addu	$2,$3,-1
	mflo	$7
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L641
	sll	$5,$7,4
	.set	macro
	.set	reorder

	addu	$2,$3,14
$L641:
	sra	$2,$2,4
	addu	$2,$2,1
	mult	$5,$2
	lw	$4,12($6)
	mflo	$8
	#nop
	.set	noreorder
	.set	nomacro
	jal	DecDCTout
	sra	$5,$8,1
	.set	macro
	.set	reorder

	j	$L634
$L640:
	li	$5,1			# 0x00000001
	sltu	$4,$7,$5
	sw	$4,32($6)
	sll	$4,$4,3
	addu	$4,$4,$6
	sw	$5,44($6)
	lhu	$3,16($4)
	lui	$2,%hi(isFirstSlice) # high
	sw	$5,%lo(isFirstSlice)($2)
	lui	$2,%hi(height) # high
	sh	$3,36($6)
	lw	$3,%lo(height)($2)
	li	$2,240			# 0x000000f0
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	lhu	$3,18($4)
	sra	$2,$2,$5
	addu	$3,$3,$2
	sh	$3,38($6)
$L634:
	lw	$31,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	strCallback__Fv
	.text
	.ent	strNextVlc__FP6DECENV
strNextVlc__FP6DECENV:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	li	$16,10			# 0x0000000a
	sw	$31,28($sp)
	sw	$17,20($sp)
$L646:
	.set	noreorder
	.set	nomacro
	jal	strNext__FP6DECENV
	move	$4,$18
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L650
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L646
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	j	$L657
$L650:
	lw	$2,8($18)
	#nop
	sltu	$2,$2,1
	sw	$2,8($18)
	sll	$2,$2,2
	addu	$2,$18,$2
	lw	$5,0($2)
	.set	noreorder
	.set	nomacro
	jal	DecDCTvlc
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L653
	move	$4,$0
	.set	macro
	.set	reorder

$L658:
	.set	noreorder
	.set	nomacro
	jal	DecDCTvlc
	move	$5,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L658
	move	$4,$0
	.set	macro
	.set	reorder

$L653:
	.set	noreorder
	.set	nomacro
	jal	StFreeRing
	move	$4,$17
	.set	macro
	.set	reorder

	move	$2,$0
$L657:
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

	.end	strNextVlc__FP6DECENV
	.text
	.ent	strNext__FP6DECENV
strNext__FP6DECENV:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$17,36($sp)
	move	$17,$4
	sw	$16,32($sp)
	li	$16,50000			# 0x0000c350
	sw	$31,40($sp)
	addu	$4,$sp,24
$L678:
	.set	noreorder
	.set	nomacro
	jal	StGetNext
	addu	$5,$sp,28
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L678
	addu	$4,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L677
	move	$2,$0
	.set	macro
	.set	reorder

$L661:
	lw	$4,24($sp)
	lw	$5,28($sp)
	lw	$3,0($4)
	lw	$2,20($5)
	#nop
	bne	$3,$2,$L667
	lw	$3,4($4)
	lw	$2,24($5)
	#nop
	beq	$3,$2,$L669
$L667:
	jal	StFreeRing
	.set	noreorder
	.set	nomacro
	j	$L677
	move	$2,$0
	.set	macro
	.set	reorder

$L669:
	lui	$4,%hi(gMovieFrame) # high
	lw	$2,%lo(gMovieFrame)($4)
	lw	$3,8($5)
	#nop
	sltu	$2,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L671
	lui	$2,%hi(gEndFrame) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(gEndFrame)($2)
	#nop
	sltu	$2,$3,$2
	bne	$2,$0,$L673
$L671:
	lui	$3,%hi(bRewindMovie) # high
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L674
	sw	$2,%lo(bRewindMovie)($3)
	.set	macro
	.set	reorder

$L673:
	sw	$3,%lo(gMovieFrame)($4)
$L674:
	lui	$16,%hi(width) # high
	lw	$4,28($sp)
	lw	$2,%lo(width)($16)
	lhu	$3,16($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L679
	lui	$2,%hi(PPWTop) # high
	.set	macro
	.set	reorder

	lui	$2,%hi(height) # high
	lhu	$3,18($4)
	lw	$2,%lo(height)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L675
	lui	$2,%hi(PPWTop) # high
	.set	macro
	.set	reorder

$L679:
	lh	$3,%lo(PPWTop)($2)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	lui	$3,%hi(PPWBottom) # high
	lh	$3,%lo(PPWBottom)($3)
	sll	$2,$2,7
	div	$2,$2,$3
	addu	$4,$sp,16
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sh	$0,16($sp)
	sh	$0,18($sp)
	li	$3,480			# 0x000001e0
	sh	$3,22($sp)
	.set	noreorder
	.set	nomacro
	jal	ClearImage
	sh	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$3,28($sp)
	#nop
	lhu	$2,16($3)
	lhu	$3,18($3)
	sw	$2,%lo(width)($16)
	lui	$2,%hi(height) # high
	sw	$3,%lo(height)($2)
$L675:
	lui	$4,%hi(width) # high
	lui	$2,%hi(PPWTop) # high
	lh	$3,%lo(PPWTop)($2)
	lw	$2,%lo(width)($4)
	#nop
	mult	$2,$3
	lui	$2,%hi(PPWBottom) # high
	mflo	$3
	#nop
	lh	$4,%lo(PPWBottom)($2)
	#nop
	div	$4,$3,$4
	lui	$3,%hi(height) # high
	lhu	$3,%lo(height)($3)
	lw	$2,24($sp)
	sh	$3,30($17)
	sh	$3,22($17)
	sh	$3,42($17)
	sh	$4,28($17)
	sh	$4,20($17)
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

	.end	strNext__FP6DECENV
	.text
	.ent	strSync__FP6DECENVi
strSync__FP6DECENVi:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	lw	$3,44($4)
	li	$2,8388608			# 0x00800000
	#.set	volatile
	sw	$2,0($sp)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L681
	lui	$2,%hi(height) # high
	.set	macro
	.set	reorder

	li	$6,1			# 0x00000001
	lw	$3,%lo(height)($2)
	li	$2,240			# 0x000000f0
	subu	$2,$2,$3
	srl	$3,$2,31
	addu	$2,$2,$3
	sra	$5,$2,$6
$L682:
	#.set	volatile
	lw	$2,0($sp)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sw	$2,0($sp)
	#.set	novolatile
	#.set	volatile
	lw	$2,0($sp)
	#.set	novolatile
	#nop
	bne	$2,$0,$L684
	lw	$2,32($4)
	sw	$6,44($4)
	sltu	$2,$2,1
	sw	$2,32($4)
	sll	$2,$2,3
	addu	$2,$4,$2
	lhu	$3,16($2)
	lw	$2,32($4)
	#nop
	sll	$2,$2,3
	addu	$2,$4,$2
	sh	$3,36($4)
	lhu	$2,18($2)
	#nop
	addu	$2,$2,$5
	sh	$2,38($4)
$L684:
	lw	$2,44($4)
	#nop
	beq	$2,$0,$L682
$L681:
	sw	$0,44($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	strSync__FP6DECENVi
	.text
	.ent	strKickCD__FP6CdlLOC
strKickCD__FP6CdlLOC:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	li	$4,21			# 0x00000015
$L696:
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	CdControl
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L696
	li	$4,21			# 0x00000015
	.set	macro
	.set	reorder

$L692:
	.set	noreorder
	.set	nomacro
	jal	CdRead2
	li	$4,448			# 0x000001c0
	.set	macro
	.set	reorder

	beq	$2,$0,$L692
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	strKickCD__FP6CdlLOC
