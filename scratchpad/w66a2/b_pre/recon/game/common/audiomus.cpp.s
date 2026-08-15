	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\audiomus.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AudioMus_RefreshStatus__Fv
	.align	2
	.globl	AudioMus_Threshold__Fv
	.align	2
	.globl	AudioMus_Buffered__Fv
	.rdata
	.align	2
$LC0:
	.ascii	"BUFFER NOT ALLOCATED\000"
	.align	2
$LC1:
	.ascii	"STREAM NOT CREATED\000"
	.text
	.align	2
	.globl	AudioMus_GetCurrentSong__Fv
	.align	2
	.globl	AudioMus_SwitchSong__Fv
	.align	2
	.globl	AudioMus_Fail__Fi
	.align	2
	.globl	AudioMus_QueueRequestedSong__Fv
	.align	2
	.globl	AudioMus_SetEntry__FP19AudioMus_tSongEntry
	.align	2
	.globl	AudioMus_SetCurrentSongInfo__Fv
	.align	2
	.globl	AudioMus_Server__Fii
	.rdata
	.align	2
$LC2:
	.ascii	"Song List\000"
	.text
	.align	2
	.globl	AudioMus_GetSongList__FPci
	.align	2
	.globl	AudioMus_InitGlobals__Fv
	.align	2
	.globl	AudioMus_InitDriverGlobals__Fv
	.align	2
	.globl	AudioMus_DriverStartUp__Fii
	.rdata
	.align	2
$LC3:
	.ascii	"Music Globals\000"
	.align	2
$LC4:
	.ascii	"Music Buffer\000"
	.align	2
$LC5:
	.ascii	"%szzz%s.viv\000"
	.text
	.align	2
	.globl	AudioMus_SysStartUp__FiiPc
	.align	2
	.globl	AudioMus_DriverCleanUp__Fv
	.align	2
	.globl	AudioMus_SysCleanUp__Fv
	.align	2
	.globl	AudioMus_StopSong__Fi
	.align	2
	.globl	AudioMus_BuildPlayList__FiPi
	.align	2
	.globl	AudioMus_BuildPattern__FPc
	.rdata
	.align	2
$LC6:
	.ascii	"*-%s\000"
	.text
	.align	2
	.globl	AudioMus_PlaySong__FPc
	.align	2
	.globl	AudioMus_Volume__Fi
	.align	2
	.globl	AudioMus_AutoVolume__Fii
	.globl	AudioMus_g
	.sdata
	.align	2
AudioMus_g:
	.space	4

	.extern	gMusicHandle, 4
	.extern	Hud_kTurnSongOffNext, 4

	.text
	.text
	.ent	AudioMus_RefreshStatus__Fv
AudioMus_RefreshStatus__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$5,AudioMus_g
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$4,116($5)
	#nop
	bltz	$4,$L601
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_status
	addu	$5,$5,144
	.set	macro
	.set	reorder

	lw	$5,AudioMus_g
	#nop
	lw	$2,144($5)
	#nop
	blez	$2,$L600
	lw	$4,148($5)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_requeststatus
	addu	$5,$5,156
	.set	macro
	.set	reorder

	j	$L600
$L601:
	sw	$0,144($5)
$L600:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_RefreshStatus__Fv
	.text
	.ent	AudioMus_Threshold__Fv
AudioMus_Threshold__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$4,AudioMus_g
	#nop
	beq	$4,$0,$L606
	lw	$2,140($4)
	#nop
	bne	$2,$0,$L608
$L606:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L608:
	lw	$2,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L606
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$3,20($4)
	#nop
	bne	$3,$2,$L611
$L612:
	lw	$2,136($4)
	j	$31
$L611:
	lw	$2,144($4)
	#nop
	beq	$2,$0,$L606
	lw	$3,164($4)
	lw	$2,168($4)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	move	$2,$0
	.set	macro
	.set	reorder

	j	$31
	.end	AudioMus_Threshold__Fv
	.text
	.ent	AudioMus_Buffered__Fv
AudioMus_Buffered__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	#nop
	beq	$3,$0,$L623
	lw	$2,140($3)
	#nop
	bne	$2,$0,$L619
$L623:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L619:
	lw	$2,144($3)
	#nop
	beq	$2,$0,$L620
	lw	$2,168($3)
	j	$31
$L620:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	AudioMus_Buffered__Fv
	.text
	.ent	AudioMus_GetCurrentSong__Fv
AudioMus_GetCurrentSong__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L625
	addu	$4,$3,268
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L625:
	lw	$2,164($3)
	#nop
	sw	$2,8($4)
	lw	$2,32($3)
	#nop
	bne	$2,$0,$L626
	lw	$2,12($3)
	#nop
	addu	$2,$2,1
$L626:
	sw	$2,4($4)
 #APP
 #NO_APP
	#.set	volatile
	lw	$2,AudioMus_g
	#.set	novolatile
	#nop
	lw	$3,32($2)
	li	$2,-4			# 0xfffffffc
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L628
	addu	$4,$4,12
	.set	macro
	.set	reorder

	li	$2,-3			# 0xfffffffd
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L629
	lui	$2,%hi($LC1) # high
	.set	macro
	.set	reorder

	j	$L627
$L628:
	lui	$2,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	j	$L636
	addiu	$2,$2,%lo($LC0) # low
	.set	macro
	.set	reorder

$L629:
	addiu	$2,$2,%lo($LC1) # low
$L636:
	sw	$2,4($4)
$L627:
	lw	$3,AudioMus_g
	#nop
	lw	$2,24($3)
	#nop
	beq	$2,$0,$L632
	li	$2,1			# 0x00000001
	sw	$0,24($3)
	.set	noreorder
	.set	nomacro
	j	$L633
	sw	$2,268($3)
	.set	macro
	.set	reorder

$L632:
	sw	$0,268($3)
$L633:
	lw	$2,AudioMus_g
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,268
	.set	macro
	.set	reorder

	.end	AudioMus_GetCurrentSong__Fv
	.text
	.ent	AudioMus_SwitchSong__Fv
AudioMus_SwitchSong__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L637
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$2,8($3)
	#nop
	beq	$2,$0,$L637
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L637
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,24($3)
	addu	$2,$3,280
	sw	$0,44($3)
	sw	$0,32($3)
	sw	$0,276($3)
	sw	$0,24($2)
	sw	$0,280($3)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,20($2)
	lw	$2,20($3)
	#nop
	bne	$2,$0,$L639
	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L639
	li	$5,2000			# 0x000007d0
	.set	macro
	.set	reorder

	lw	$4,116($3)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	li	$2,1000			# 0x000003e8
	sw	$2,36($3)
$L639:
	lw	$4,AudioMus_g
	#nop
	lw	$2,12($4)
	lw	$3,Hud_kTurnSongOffNext
	addu	$5,$2,1
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L641
	sw	$5,12($4)
	.set	macro
	.set	reorder

	lw	$2,8($4)
	#nop
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L643
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L641:
	li	$2,-1			# 0xffffffff
	sw	$0,Hud_kTurnSongOffNext
	sw	$0,16($4)
	sw	$2,20($4)
	.set	noreorder
	.set	nomacro
	j	$L637
	sw	$2,12($4)
	.set	macro
	.set	reorder

$L643:
	sw	$2,20($4)
$L637:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_SwitchSong__Fv
	.text
	.ent	AudioMus_Fail__Fi
AudioMus_Fail__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$3,144($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L647
	sw	$4,32($2)
	.set	macro
	.set	reorder

	jal	AudioMus_Buffered__Fv
	lw	$3,AudioMus_g
	move	$5,$2
	lw	$4,116($3)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	jal	AudioMus_Buffered__Fv
	lw	$3,AudioMus_g
	#nop
	sw	$2,36($3)
$L647:
	lw	$2,AudioMus_g
	li	$3,1			# 0x00000001
	sw	$3,24($2)
	li	$3,-1			# 0xffffffff
	sw	$0,16($2)
	sw	$0,44($2)
	sw	$3,20($2)
	sw	$3,12($2)
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_Fail__Fi
	.text
	.ent	AudioMus_QueueRequestedSong__Fv
AudioMus_QueueRequestedSong__Fv:
	.frame	$sp,40,$31		# vars= 8, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,40
	sw	$31,32($sp)
	lw	$3,12($2)
	#nop
	addu	$3,$2,$3
	lbu	$6,236($3)
	move	$5,$0
	sw	$0,16($sp)
	lw	$4,140($2)
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	lw	$6,AudioMus_g
	#nop
	lw	$4,116($6)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L650
	sw	$2,44($6)
	.set	macro
	.set	reorder

	li	$5,1000			# 0x000003e8
	lw	$7,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_queuefile
	addu	$6,$6,172
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	#nop
	sw	$2,120($3)
$L650:
	lw	$3,AudioMus_g
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	jal	gettick
	sw	$2,20($3)
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	addu	$2,$2,640
	sw	$2,28($3)
	addu	$2,$3,280
	sw	$0,276($3)
	sw	$0,24($2)
	sw	$0,280($3)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,20($2)
	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	AudioMus_QueueRequestedSong__Fv
	.text
	.ent	AudioMus_SetEntry__FP19AudioMus_tSongEntry
AudioMus_SetEntry__FP19AudioMus_tSongEntry:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,0($4)
	move	$5,$0
	sw	$0,8($4)
	sw	$0,12($4)
	sw	$0,16($4)
	sw	$0,20($4)
	lbu	$3,0($6)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L660
	move	$7,$5
	.set	macro
	.set	reorder

	li	$8,45			# 0x0000002d
$L654:
	.set	noreorder
	.set	nomacro
	bne	$3,$8,$L657
	slt	$2,$5,31
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L658
	addu	$2,$6,1
	.set	macro
	.set	reorder

	li	$7,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L661
	move	$5,$0
	.set	macro
	.set	reorder

$L658:
	.set	noreorder
	.set	nomacro
	j	$L660
	sw	$2,8($4)
	.set	macro
	.set	reorder

$L657:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L661
	addu	$2,$4,$5
	.set	macro
	.set	reorder

	sb	$3,32($2)
	addu	$5,$5,1
$L661:
	addu	$6,$6,1
	lbu	$3,0($6)
	#nop
	bne	$3,$0,$L654
$L660:
	addu	$2,$4,$5
	sb	$0,32($2)
	addu	$2,$4,32
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,4($4)
	.set	macro
	.set	reorder

	.end	AudioMus_SetEntry__FP19AudioMus_tSongEntry
	.text
	.ent	AudioMus_SetCurrentSongInfo__Fv
AudioMus_SetCurrentSongInfo__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$2,164($3)
	lw	$5,160($3)
	addu	$4,$3,280
	sw	$2,276($3)
	addu	$2,$2,$5
	sw	$2,24($4)
	lw	$2,44($3)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SetEntry__FP19AudioMus_tSongEntry
	sw	$2,280($3)
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

	.end	AudioMus_SetCurrentSongInfo__Fv
	.text
	.ent	AudioMus_Server__Fii
AudioMus_Server__Fii:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	subu	$sp,$sp,40
	sw	$31,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,140($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	li	$2,46			# 0x0000002e
	.set	macro
	.set	reorder

	lbu	$3,172($3)
	#nop
	beq	$3,$2,$L671
	.set	noreorder
	.set	nomacro
	jal	CdDiskReady
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$3,16			# 0x00000010
	bne	$2,$3,$L671
	lw	$4,AudioMus_g
	#nop
	lw	$2,32($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,12($4)
	li	$2,-2			# 0xfffffffe
	sw	$2,32($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bltz	$3,$L669
	sw	$2,24($4)
	.set	macro
	.set	reorder

	jal	AudioMus_Buffered__Fv
	lw	$3,AudioMus_g
	move	$5,$2
	lw	$4,116($3)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L712
	move	$2,$0
	.set	macro
	.set	reorder

$L671:
	lw	$2,AudioMus_g
	#nop
	lw	$3,32($2)
	li	$2,-2			# 0xfffffffe
	bne	$3,$2,$L675
	.set	noreorder
	.set	nomacro
	jal	CdDiskReady
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$2
	li	$2,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L712
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,AudioMus_g
	#nop
	lw	$3,12($4)
	li	$2,-5			# 0xfffffffb
	.set	noreorder
	.set	nomacro
	bltz	$3,$L669
	sw	$2,32($4)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,24($4)
	.set	noreorder
	.set	nomacro
	j	$L678
	sw	$5,20($4)
	.set	macro
	.set	reorder

$L675:
	jal	AudioMus_RefreshStatus__Fv
	jal	AudioMus_Threshold__Fv
	beq	$2,$0,$L679
	lw	$2,AudioMus_g
	#nop
	lw	$3,20($2)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L679
	jal	AudioMus_Buffered__Fv
	slt	$2,$2,550
	beq	$2,$0,$L680
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Fail__Fi
	li	$4,-5			# 0xfffffffb
	.set	macro
	.set	reorder

	j	$L679
$L680:
	jal	AudioMus_Buffered__Fv
	slt	$2,$2,1500
	beq	$2,$0,$L682
	lw	$3,AudioMus_g
	#nop
	lw	$2,132($3)
	#nop
	bne	$2,$0,$L679
	lw	$4,116($3)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_setgreedystate
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$L679
	sw	$2,132($3)
	.set	macro
	.set	reorder

$L682:
	jal	AudioMus_Buffered__Fv
	lw	$4,AudioMus_g
	#nop
	lw	$3,136($4)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L679
	lw	$2,132($4)
	#nop
	beq	$2,$0,$L679
	lw	$4,116($4)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_setgreedystate
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	#nop
	sw	$0,132($2)
$L679:
	lw	$7,AudioMus_g
	#nop
	lw	$2,20($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L687
	li	$16,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$2,$16,$L689
	lw	$2,112($7)
	#nop
	bne	$2,$0,$L690
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Fail__Fi
	li	$4,-4			# 0xfffffffc
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L712
	move	$2,$0
	.set	macro
	.set	reorder

$L690:
	lw	$2,116($7)
	#nop
	bgez	$2,$L691
	.set	noreorder
	.set	nomacro
	jal	AudioMus_Fail__Fi
	li	$4,-3			# 0xfffffffd
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L712
	move	$2,$0
	.set	macro
	.set	reorder

$L691:
	lw	$2,144($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L712
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,168($7)
	lw	$2,136($7)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L669
	li	$2,-5			# 0xfffffffb
	.set	macro
	.set	reorder

	lw	$3,32($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L694
	li	$5,2000			# 0x000007d0
	.set	macro
	.set	reorder

	lw	$4,116($7)
	lw	$6,0($7)
	.set	noreorder
	.set	nomacro
	j	$L710
	sw	$0,32($7)
	.set	macro
	.set	reorder

$L694:
	jal	AudioMus_SetCurrentSongInfo__Fv
	lw	$2,AudioMus_g
	#nop
	lw	$4,116($2)
	lw	$6,0($2)
	li	$5,2000			# 0x000007d0
$L710:
	jal	SNDSTRM_autovol
	lw	$2,AudioMus_g
	.set	noreorder
	.set	nomacro
	j	$L669
	sw	$0,20($2)
	.set	macro
	.set	reorder

$L689:
	lw	$2,144($7)
	#nop
	beq	$2,$0,$L696
	lw	$4,116($7)
	jal	SNDSTRM_getvol
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	move	$2,$0
	.set	macro
	.set	reorder

$L696:
	lw	$2,AudioMus_g
	#nop
	lw	$4,116($2)
	#nop
	bltz	$4,$L698
	jal	SNDSTRM_purge
$L698:
	lw	$4,AudioMus_g
	#nop
	lw	$3,20($4)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L700
	sw	$0,44($4)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_QueueRequestedSong__Fv
	sw	$0,36($4)
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	#nop
	sw	$16,20($2)
$L678:
	jal	gettick
	lw	$3,AudioMus_g
	addu	$2,$2,640
	.set	noreorder
	.set	nomacro
	j	$L669
	sw	$2,28($3)
	.set	macro
	.set	reorder

$L700:
	.set	noreorder
	.set	nomacro
	j	$L669
	sw	$0,20($4)
	.set	macro
	.set	reorder

$L687:
	lw	$2,144($7)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L712
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$3,12($7)
	#nop
	bltz	$3,$L712
	lw	$16,8($7)
	#nop
	slt	$2,$16,2
	bne	$2,$0,$L703
	lw	$2,40($7)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L704
	move	$4,$0
	.set	macro
	.set	reorder

	move	$19,$7
	addu	$17,$16,-1
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	addu	$18,$3,1
	.set	macro
	.set	reorder

	blez	$2,$L705
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L711
$L705:
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	subu	$2,$0,$2
$L711:
	rem	$3,$2,$17
	addu	$3,$18,$3
	rem	$2,$3,$16
	.set	noreorder
	.set	nomacro
	j	$L703
	sw	$2,12($19)
	.set	macro
	.set	reorder

$L704:
	addu	$2,$3,1
	rem	$3,$2,$16
	sw	$3,12($7)
$L703:
	lw	$2,AudioMus_g
	#nop
	lw	$4,116($2)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_vol
	move	$5,$0
	.set	macro
	.set	reorder

	jal	AudioMus_QueueRequestedSong__Fv
	lw	$3,AudioMus_g
	li	$2,1			# 0x00000001
	sw	$2,24($3)
	sw	$2,16($3)
$L669:
	move	$2,$0
$L712:
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

	.end	AudioMus_Server__Fii
	.text
	.ent	AudioMus_GetSongList__FPci
AudioMus_GetSongList__FPci:
	.frame	$sp,64,$31		# vars= 8, regs= 7/0, args= 24, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	subu	$sp,$sp,64
	sw	$21,52($sp)
	move	$21,$4
	sw	$18,40($sp)
	move	$18,$5
	sw	$17,36($sp)
	move	$17,$0
	sw	$31,56($sp)
	sw	$20,48($sp)
	sw	$19,44($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L714
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	lw	$2,4($3)
	#nop
	slt	$2,$17,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L716
	move	$16,$17
	.set	macro
	.set	reorder

	move	$5,$0
$L728:
	move	$6,$16
	sw	$0,16($sp)
	lw	$4,140($3)
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	move	$7,$5
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$21
	.set	macro
	.set	reorder

	beq	$2,$0,$L717
	addu	$17,$17,1
$L717:
	lw	$3,AudioMus_g
	#nop
	lw	$2,4($3)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L728
	move	$5,$0
	.set	macro
	.set	reorder

$L716:
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	sll	$5,$17,6
	ori	$5,$5,0x0008
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$18
	.set	macro
	.set	reorder

	move	$17,$2
	addu	$20,$17,8
	move	$18,$0
	addu	$19,$17,36
	li	$2,-1			# 0xffffffff
	sw	$0,0($17)
	sw	$2,4($17)
$L721:
	lw	$3,AudioMus_g
	#nop
	lw	$2,4($3)
	#nop
	slt	$2,$18,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L727
	move	$5,$0
	.set	macro
	.set	reorder

	move	$6,$18
	addu	$2,$sp,24
	sw	$2,16($sp)
	lw	$4,140($3)
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	move	$7,$5
	.set	macro
	.set	reorder

	move	$16,$2
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L723
	move	$4,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_SetEntry__FP19AudioMus_tSongEntry
	sw	$16,0($20)
	.set	macro
	.set	reorder

	li	$4,-2113404928			# 0x82080000
	lw	$3,24($sp)
	ori	$4,$4,0x2083
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	mult	$2,$4
	sw	$18,0($19)
	lw	$4,AudioMus_g
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,7
	sra	$2,$2,31
	subu	$3,$3,$2
	sw	$3,-4($19)
	lw	$2,44($4)
	#nop
	bne	$16,$2,$L726
	sw	$18,4($17)
$L726:
	addu	$19,$19,64
	lw	$2,0($17)
	addu	$20,$20,64
	addu	$2,$2,1
	sw	$2,0($17)
$L723:
	.set	noreorder
	.set	nomacro
	j	$L721
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L714:
	lui	$4,%hi($LC2) # high
	addiu	$4,$4,%lo($LC2) # low
	li	$5,8			# 0x00000008
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$18
	.set	macro
	.set	reorder

	move	$17,$2
	li	$2,-1			# 0xffffffff
	sw	$0,0($17)
	sw	$2,4($17)
$L727:
	move	$2,$17
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

	.end	AudioMus_GetSongList__FPci
	.text
	.ent	AudioMus_InitGlobals__Fv
AudioMus_InitGlobals__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	li	$3,-1			# 0xffffffff
	sw	$0,140($2)
	sw	$0,112($2)
	sw	$3,116($2)
	sw	$0,124($2)
	sw	$0,128($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,4($2)
	.set	macro
	.set	reorder

	.end	AudioMus_InitGlobals__Fv
	.text
	.ent	AudioMus_InitDriverGlobals__Fv
AudioMus_InitDriverGlobals__Fv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	li	$3,-1			# 0xffffffff
	sw	$3,12($2)
	addu	$3,$2,280
	sw	$0,0($2)
	sw	$0,36($2)
	sw	$0,8($2)
	sw	$0,16($2)
	sw	$0,24($2)
	sw	$0,44($2)
	sw	$0,20($2)
	sw	$0,32($2)
	sw	$0,132($2)
	sw	$0,276($2)
	sw	$0,24($3)
	sw	$0,280($2)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,20($3)
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,128($2)
	.set	macro
	.set	reorder

	.end	AudioMus_InitDriverGlobals__Fv
	.text
	.ent	AudioMus_DriverStartUp__Fii
AudioMus_DriverStartUp__Fii:
	.frame	$sp,88,$31		# vars= 48, regs= 4/0, args= 24, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,88
	sw	$18,80($sp)
	move	$18,$4
	sw	$16,72($sp)
	move	$16,$5
	sw	$31,84($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L731
	sw	$17,76($sp)
	.set	macro
	.set	reorder

	lw	$2,128($2)
	#nop
	bne	$2,$0,$L733
	jal	AudioMus_InitDriverGlobals__Fv
$L733:
	lw	$4,AudioMus_g
	addu	$2,$18,$16
	lw	$3,116($4)
	sra	$2,$2,5
	.set	noreorder
	.set	nomacro
	bgez	$3,$L734
	sw	$2,136($4)
	.set	macro
	.set	reorder

	lw	$2,112($4)
	#nop
	beq	$2,$0,$L734
	.set	noreorder
	.set	nomacro
	bgez	$18,$L735
	move	$17,$18
	.set	macro
	.set	reorder

	addu	$17,$18,1023
$L735:
	li	$4,1			# 0x00000001
	sra	$17,$17,10
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_overhead
	move	$5,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	SNDgetlimits
	addu	$18,$18,$2
	.set	macro
	.set	reorder

	addu	$4,$sp,24
	.set	noreorder
	.set	nomacro
	jal	SNDsetlimits
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	addu	$16,$sp,48
	.set	noreorder
	.set	nomacro
	jal	SNDplaysetdef
	move	$4,$16
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$2,AudioMus_g
	li	$5,1			# 0x00000001
	sb	$0,56($sp)
	sw	$18,16($sp)
	lw	$7,112($2)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_create
	move	$6,$17
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	.set	noreorder
	.set	nomacro
	bltz	$2,$L734
	sw	$2,116($3)
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_setgreedylevel
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	li	$5,255			# 0x000000ff
	lw	$4,116($2)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_setpriority
	li	$6,5			# 0x00000005
	.set	macro
	.set	reorder

$L734:
	lw	$2,AudioMus_g
	#nop
	lw	$3,116($2)
	lw	$2,124($2)
	sw	$3,gMusicHandle
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L731
	lui	$4,%hi(AudioMus_Server__Fii) # high
	.set	macro
	.set	reorder

	addiu	$4,$4,%lo(AudioMus_Server__Fii) # low
	li	$5,25			# 0x00000019
	.set	noreorder
	.set	nomacro
	jal	addsystemtask
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	li	$2,1			# 0x00000001
	sw	$2,124($3)
$L731:
	lw	$31,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,88
	.set	macro
	.set	reorder

	.end	AudioMus_DriverStartUp__Fii
	.text
	.ent	AudioMus_SysStartUp__FiiPc
AudioMus_SysStartUp__FiiPc:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	sw	$18,24($sp)
	move	$18,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L738
	sw	$31,28($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC3) # high
	addiu	$4,$4,%lo($LC3) # low
	li	$5,344			# 0x00000158
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	sw	$2,AudioMus_g
	beq	$2,$0,$L738
	jal	AudioMus_InitGlobals__Fv
	.set	noreorder
	.set	nomacro
	bgez	$16,$L741
	move	$5,$16
	.set	macro
	.set	reorder

	addu	$5,$16,1023
$L741:
	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_overhead
	sra	$5,$5,10
	.set	macro
	.set	reorder

	lui	$4,%hi($LC4) # high
	addiu	$4,$4,%lo($LC4) # low
	addu	$5,$16,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$16
	lw	$3,AudioMus_g
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	AudioMus_DriverStartUp__Fii
	sw	$2,112($3)
	.set	macro
	.set	reorder

	lui	$5,%hi($LC5) # high
	addiu	$5,$5,%lo($LC5) # low
	lui	$2,%hi(Paths_Paths+108) # high
	move	$7,$18
	lw	$4,AudioMus_g
	lw	$6,%lo(Paths_Paths+108)($2)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	addu	$4,$4,172
	.set	macro
	.set	reorder

	lw	$4,AudioMus_g
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	loadbigfileheader
	addu	$4,$4,172
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L738
	sw	$2,140($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	bigcount
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$3,AudioMus_g
	#nop
	sw	$2,4($3)
$L738:
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

	.end	AudioMus_SysStartUp__FiiPc
	.text
	.ent	AudioMus_DriverCleanUp__Fv
AudioMus_DriverCleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L743
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	lw	$2,124($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L745
	lui	$4,%hi(AudioMus_Server__Fii) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	delsystemtask
	addiu	$4,$4,%lo(AudioMus_Server__Fii) # low
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	#nop
	sw	$0,124($2)
$L745:
	lw	$2,AudioMus_g
	#nop
	lw	$4,116($2)
	#nop
	bltz	$4,$L747
	jal	SNDSTRM_destroy
	lw	$3,AudioMus_g
	li	$2,-1			# 0xffffffff
	sw	$2,116($3)
	lw	$2,AudioMus_g
$L747:
	sw	$0,128($2)
$L743:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_DriverCleanUp__Fv
	.text
	.ent	AudioMus_SysCleanUp__Fv
AudioMus_SysCleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L748
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	AudioMus_DriverCleanUp__Fv
	lw	$2,AudioMus_g
	#nop
	lw	$4,112($2)
	#nop
	beq	$4,$0,$L752
	jal	purgememadr
	lw	$2,AudioMus_g
$L752:
	lw	$4,140($2)
	#nop
	beq	$4,$0,$L751
	jal	purgememadr
$L751:
	lw	$4,AudioMus_g
	jal	purgememadr
	sw	$0,AudioMus_g
$L748:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_SysCleanUp__Fv
	.text
	.ent	AudioMus_StopSong__Fi
AudioMus_StopSong__Fi:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	lw	$4,AudioMus_g
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L753
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$2,12($4)
	#nop
	bltz	$2,$L753
	bne	$16,$0,$L755
	lw	$4,116($4)
	#nop
	bltz	$4,$L756
	jal	SNDSTRM_purge
$L756:
	lw	$2,AudioMus_g
	#nop
	sw	$0,36($2)
	sw	$0,44($2)
	.set	noreorder
	.set	nomacro
	j	$L757
	sw	$0,20($2)
	.set	macro
	.set	reorder

$L755:
	lw	$2,20($4)
	#nop
	bne	$2,$0,$L758
	lw	$2,116($4)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L759
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	.set	noreorder
	.set	nomacro
	j	$L760
	sw	$16,36($2)
	.set	macro
	.set	reorder

$L759:
	sw	$0,36($4)
$L760:
	lw	$2,AudioMus_g
	#nop
	sw	$0,44($2)
$L758:
	lw	$3,AudioMus_g
	li	$2,-1			# 0xffffffff
	sw	$2,20($3)
$L757:
	lw	$3,AudioMus_g
	li	$2,-1			# 0xffffffff
	sw	$2,12($3)
$L753:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudioMus_StopSong__Fi
	.text
	.ent	AudioMus_BuildPlayList__FiPi
AudioMus_BuildPlayList__FiPi:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	#nop
	beq	$2,$0,$L769
	sw	$0,8($2)
	.set	noreorder
	.set	nomacro
	blez	$4,$L769
	move	$7,$0
	.set	macro
	.set	reorder

$L764:
	lw	$3,0($5)
	#nop
	bltz	$3,$L767
	lw	$6,AudioMus_g
	#nop
	lw	$2,4($6)
	#nop
	slt	$2,$3,$2
	beq	$2,$0,$L767
	lw	$2,8($6)
	lbu	$3,0($5)
	addu	$2,$6,$2
	sb	$3,236($2)
	lw	$3,AudioMus_g
	#nop
	lw	$2,8($3)
	#nop
	addu	$2,$2,1
	sw	$2,8($3)
$L767:
	addu	$7,$7,1
	slt	$2,$7,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L764
	addu	$5,$5,4
	.set	macro
	.set	reorder

$L769:
	j	$31
	.end	AudioMus_BuildPlayList__FiPi
	.text
	.ent	AudioMus_BuildPattern__FPc
AudioMus_BuildPattern__FPc:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$3,AudioMus_g
	subu	$sp,$sp,40
	sw	$17,28($sp)
	move	$17,$4
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L770
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	lw	$2,4($3)
	move	$16,$0
	.set	noreorder
	.set	nomacro
	blez	$2,$L770
	sw	$0,8($3)
	.set	macro
	.set	reorder

$L773:
	lw	$3,AudioMus_g
	#nop
	lw	$2,8($3)
	#nop
	slt	$2,$2,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L770
	move	$6,$16
	.set	macro
	.set	reorder

	move	$5,$0
	sw	$0,16($sp)
	lw	$4,140($3)
	.set	noreorder
	.set	nomacro
	jal	locatebigentry
	move	$7,$5
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$17
	.set	macro
	.set	reorder

	beq	$2,$0,$L777
	lw	$2,AudioMus_g
	#nop
	lw	$3,8($2)
	#nop
	addu	$2,$2,$3
	sb	$16,236($2)
	lw	$3,AudioMus_g
	#nop
	lw	$2,8($3)
	#nop
	addu	$2,$2,1
	sw	$2,8($3)
$L777:
	lw	$2,AudioMus_g
	#nop
	lw	$2,4($2)
	addu	$16,$16,1
	slt	$2,$16,$2
	bne	$2,$0,$L773
$L770:
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

	.end	AudioMus_BuildPattern__FPc
	.text
	.ent	AudioMus_PlaySong__FPc
AudioMus_PlaySong__FPc:
	.frame	$sp,168,$31		# vars= 128, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,168
	sw	$19,156($sp)
	move	$19,$4
	sw	$31,160($sp)
	sw	$18,152($sp)
	sw	$17,148($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L780
	sw	$16,144($sp)
	.set	macro
	.set	reorder

	beq	$19,$0,$L781
	jal	AudioMus_BuildPattern__FPc
	lw	$2,AudioMus_g
	#nop
	lw	$2,8($2)
	#nop
	bne	$2,$0,$L781
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$19
	.set	macro
	.set	reorder

	sltu	$2,$2,61
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L781
	lui	$5,%hi($LC6) # high
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addiu	$5,$5,%lo($LC6) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	AudioMus_BuildPattern__FPc
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L781:
	lw	$3,AudioMus_g
	#nop
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L798
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,8($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L784
	move	$16,$2
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L785
	sw	$2,40($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L786
	move	$16,$0
	.set	macro
	.set	reorder

$L785:
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L787
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	blez	$2,$L788
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L799
$L788:
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	subu	$2,$0,$2
$L799:
	rem	$3,$2,$16
 #APP
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$L786
	move	$16,$3
	.set	macro
	.set	reorder

$L787:
	lw	$2,12($3)
	addu	$17,$16,-1
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	addu	$18,$2,1
	.set	macro
	.set	reorder

	blez	$2,$L791
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L800
$L791:
	.set	noreorder
	.set	nomacro
	jal	GetRCnt
	move	$4,$0
	.set	macro
	.set	reorder

	subu	$2,$0,$2
$L800:
	rem	$3,$2,$17
	addu	$3,$18,$3
	rem	$2,$3,$16
	move	$16,$2
$L786:
	lw	$3,AudioMus_g
	#nop
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L793
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,20($3)
	.set	noreorder
	.set	nomacro
	j	$L794
	sw	$16,12($3)
	.set	macro
	.set	reorder

$L793:
	lw	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L795
	li	$5,2000			# 0x000007d0
	.set	macro
	.set	reorder

	lw	$4,116($3)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	li	$3,2000			# 0x000007d0
	sw	$3,36($2)
	li	$3,1			# 0x00000001
	sw	$3,20($2)
	sw	$16,12($2)
	.set	noreorder
	.set	nomacro
	j	$L794
	sw	$0,44($2)
	.set	macro
	.set	reorder

$L795:
	lw	$4,116($3)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_vol
	sw	$0,36($3)
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	.set	noreorder
	.set	nomacro
	jal	AudioMus_QueueRequestedSong__Fv
	sw	$16,12($2)
	.set	macro
	.set	reorder

$L794:
	lw	$2,AudioMus_g
	li	$3,1			# 0x00000001
	sw	$3,16($2)
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L784
	sw	$0,32($2)
	.set	macro
	.set	reorder

	sw	$3,24($2)
$L784:
	lw	$2,AudioMus_g
	#nop
	lw	$2,8($2)
	j	$L798
$L780:
	move	$2,$0
$L798:
	lw	$31,160($sp)
	lw	$19,156($sp)
	lw	$18,152($sp)
	lw	$17,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,168
	.set	macro
	.set	reorder

	.end	AudioMus_PlaySong__FPc
	.text
	.ent	AudioMus_Volume__Fi
AudioMus_Volume__Fi:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	lw	$4,AudioMus_g
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L801
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,0($4)
	#nop
	beq	$2,$17,$L801
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L803
	move	$16,$0
	.set	macro
	.set	reorder

	sw	$0,0($4)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	move	$4,$16
	.set	macro
	.set	reorder

	j	$L801
$L803:
	lw	$2,36($4)
	#nop
	beq	$2,$0,$L805
	lw	$4,116($4)
	#nop
	bltz	$4,$L805
	jal	SNDSTRM_getvol
	move	$4,$2
	blez	$4,$L805
	lw	$2,AudioMus_g
	#nop
	lw	$3,0($2)
	#nop
	blez	$3,$L805
	lw	$2,36($2)
	#nop
	mult	$2,$4
	mflo	$8
	#nop
	#nop
	div	$16,$8,$3
$L805:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L807
	mult	$17,$16
	.set	macro
	.set	reorder

	lw	$2,AudioMus_g
	mflo	$3
	#nop
	lw	$5,36($2)
	#nop
	div	$5,$3,$5
	lw	$4,116($2)
	jal	SNDSTRM_vol
	lw	$2,AudioMus_g
	move	$5,$16
	lw	$4,116($2)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$0
	.set	macro
	.set	reorder

	j	$L808
$L807:
	lw	$2,AudioMus_g
	#nop
	lw	$4,116($2)
	#nop
	bltz	$4,$L808
	lw	$3,20($2)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L808
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_vol
	move	$5,$17
	.set	macro
	.set	reorder

$L808:
	lw	$3,AudioMus_g
	#nop
	lw	$2,0($3)
	#nop
	bne	$2,$0,$L810
	sw	$17,0($3)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L801
$L810:
	sw	$17,0($3)
$L801:
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

	.end	AudioMus_Volume__Fi
	.text
	.ent	AudioMus_AutoVolume__Fii
AudioMus_AutoVolume__Fii:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,AudioMus_g
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L812
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	lw	$3,0($2)
	#nop
	beq	$3,$16,$L812
	bne	$16,$0,$L814
	sw	$0,0($2)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_StopSong__Fi
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L812
$L814:
	bne	$3,$0,$L816
	sw	$16,0($2)
	.set	noreorder
	.set	nomacro
	jal	AudioMus_PlaySong__FPc
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L817
$L816:
	sw	$16,0($2)
$L817:
	lw	$4,AudioMus_g
	#nop
	lw	$3,20($4)
	li	$2,2			# 0x00000002
	beq	$3,$2,$L812
	lw	$2,36($4)
	#nop
	bne	$2,$0,$L812
	lw	$4,116($4)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$4,$L812
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_autovol
	move	$6,$16
	.set	macro
	.set	reorder

$L812:
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

	.end	AudioMus_AutoVolume__Fii
