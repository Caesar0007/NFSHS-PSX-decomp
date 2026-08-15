	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\psx\\\\audio.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.rdata
	.align	2
$LC0:
	.ascii	"audio heap\000"
	.align	2
$LC1:
	.ascii	"amus\000"
	.text
	.align	2
	.globl	Audio_InitDriver__Fii
	.align	2
	.globl	Audio_DeInitDriver__Fv
	.align	2
	.globl	Audio_CleanUp__Fv
	.align	2
	.globl	Audio_FECleanUp__Fv
	.align	2
	.globl	AudioCmn_AddBank__FPciT0i
	.rdata
	.align	2
$LC2:
	.ascii	".bnk\000"
	.text
	.align	2
	.globl	AudioCmn_LoadBank__FPci
	.globl	Audio_direct3davail
	.sdata
	.align	2
Audio_direct3davail:
	.space	4
	.globl	Audio_gHeap
	.align	2
Audio_gHeap:
	.space	4

	.extern	AudioCmn_kAudioStreamingOn, 4
	.extern	AudioCmn_kAudioOn, 4
	.extern	gSndBnk, 84

	.text
	.text
	.ent	Audio_InitDriver__Fii
Audio_InitDriver__Fii:
	.frame	$sp,96,$31		# vars= 64, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	sw	$16,80($sp)
	move	$16,$4
	sw	$17,84($sp)
	move	$17,$5
	move	$4,$0
	lui	$2,%hi(gSndBnk) # high
	addiu	$3,$2,%lo(gSndBnk) # low
	sw	$31,88($sp)
$L601:
	sw	$4,0($3)
	sw	$0,8($3)
	addu	$4,$4,1
	slt	$2,$4,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L601
	addu	$3,$3,12
	.set	macro
	.set	reorder

	lw	$2,AudioCmn_kAudioOn
	#nop
	bne	$2,$0,$L606
	lw	$2,AudioCmn_kAudioStreamingOn
	#nop
	beq	$2,$0,$L605
$L606:
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_getopts
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	li	$2,48			# 0x00000030
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_setopts
	sh	$2,28($sp)
	.set	macro
	.set	reorder

	jal	SNDSYS_vectortoreal
	lui	$4,%hi($LC0) # high
	addiu	$4,$4,%lo($LC0) # low
	li	$5,4096			# 0x00001000
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$4,$2
	sw	$4,Audio_gHeap
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_init
	li	$5,4096			# 0x00001000
	.set	macro
	.set	reorder

	jal	AudioCmn_InitReverb__Fv
$L605:
	.set	noreorder
	.set	nomacro
	blez	$16,$L607
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$17
	lui	$6,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	jal	AudioMus_SysStartUp__FiiPc
	addiu	$6,$6,%lo($LC1) # low
	.set	macro
	.set	reorder

$L607:
	lw	$31,88($sp)
	lw	$17,84($sp)
	lw	$16,80($sp)
	sw	$0,Audio_direct3davail
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,96
	.set	macro
	.set	reorder

	.end	Audio_InitDriver__Fii
	.text
	.ent	Audio_DeInitDriver__Fv
Audio_DeInitDriver__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	AudioMus_SysCleanUp__Fv
	lw	$2,AudioCmn_kAudioOn
	#nop
	bne	$2,$0,$L610
	lw	$2,AudioCmn_kAudioStreamingOn
	#nop
	beq	$2,$0,$L608
$L610:
	jal	SNDSYS_restore
	lw	$4,Audio_gHeap
	jal	purgememadr
$L608:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Audio_DeInitDriver__Fv
	.text
	.ent	Audio_CleanUp__Fv
Audio_CleanUp__Fv:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(gSndBnk) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(gSndBnk) # low
	sw	$31,24($sp)
$L612:
	lw	$4,8($16)
	#nop
	beq	$4,$0,$L615
	jal	purgememadr
	sw	$0,8($16)
$L615:
	addu	$17,$17,1
	slt	$2,$17,7
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L612
	addu	$16,$16,12
	.set	macro
	.set	reorder

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

	.end	Audio_CleanUp__Fv
	.text
	.ent	Audio_FECleanUp__Fv
Audio_FECleanUp__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	li	$4,-1			# 0xffffffff
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDbankremove
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(gSndBnk) # high
	addiu	$16,$2,%lo(gSndBnk) # low
	lw	$4,8($16)
	#nop
	beq	$4,$0,$L617
	jal	purgememadr
	sw	$0,8($16)
$L617:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	Audio_FECleanUp__Fv
	.text
	.ent	AudioCmn_AddBank__FPciT0i
AudioCmn_AddBank__FPciT0i:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$18,32($sp)
	move	$18,$5
	sw	$19,36($sp)
	move	$19,$6
	sw	$20,40($sp)
	move	$20,$7
	move	$3,$16
	li	$2,-1			# 0xffffffff
	sw	$31,44($sp)
	sw	$17,28($sp)
	sw	$2,16($sp)
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L621
	move	$17,$0
	.set	macro
	.set	reorder

	li	$4,92			# 0x0000005c
	lbu	$2,0($3)
$L627:
	bne	$2,$4,$L623
	addu	$16,$3,1
$L623:
	addu	$3,$3,1
	lbu	$2,0($3)
	#nop
	bne	$2,$0,$L627
$L621:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	SNDbankadd
	move	$5,$19
	.set	macro
	.set	reorder

	move	$4,$2
	li	$2,7			# 0x00000007
	bne	$4,$2,$L625
	lw	$4,16($sp)
	jal	SNDbankheadersize
	move	$4,$16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	reservememadr
	move	$6,$0
	.set	macro
	.set	reorder

	move	$17,$2
	lw	$5,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SNDbankheadercopy
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	jal	SNDbankheadersize
	.set	noreorder
	.set	nomacro
	j	$L626
	subu	$18,$18,$2
	.set	macro
	.set	reorder

$L625:
	jal	AudioClc_SndError__Fi
$L626:
	.set	noreorder
	.set	nomacro
	jal	purgememadr
	move	$4,$19
	.set	macro
	.set	reorder

	move	$2,$18
	lui	$3,%hi(gSndBnk) # high
	addiu	$3,$3,%lo(gSndBnk) # low
	sll	$4,$20,1
	addu	$4,$4,$20
	sll	$4,$4,2
	lw	$5,16($sp)
	addu	$4,$4,$3
	sw	$17,8($4)
	sw	$5,0($4)
	lw	$31,44($sp)
	lw	$20,40($sp)
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

	.end	AudioCmn_AddBank__FPciT0i
	.text
	.ent	AudioCmn_LoadBank__FPci
AudioCmn_LoadBank__FPci:
	.frame	$sp,112,$31		# vars= 80, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,112
	sw	$17,100($sp)
	move	$17,$4
	sw	$18,104($sp)
	move	$18,$5
	addu	$4,$sp,16
	move	$5,$17
	sw	$31,108($sp)
	.set	noreorder
	.set	nomacro
	jal	strcpy
	sw	$16,96($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC2) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	li	$5,16			# 0x00000010
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L629
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	filesize
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$2
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	AudioCmn_AddBank__FPciT0i
	move	$7,$18
	.set	macro
	.set	reorder

$L629:
	lw	$31,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,112
	.set	macro
	.set	reorder

	.end	AudioCmn_LoadBank__FPci
