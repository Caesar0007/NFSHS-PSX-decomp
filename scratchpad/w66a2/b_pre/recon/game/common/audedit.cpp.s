	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\audedit.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	AudList_PurgeAudio__Fv
	.sdata
	.align	2
$LC0:
	.ascii	"\000"
	.rdata
	.align	2
$LC1:
	.ascii	"%s%02d.aud\000"
	.text
	.align	2
	.globl	AudList_LoadAudioFile__Fi
	.globl	gGameAudioList
	.sdata
	.align	2
gGameAudioList:
	.space	4

	.text
	.text
	.ent	AudList_PurgeAudio__Fv
AudList_PurgeAudio__Fv:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$4,gGameAudioList
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L600
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	jal	purgememadr
$L600:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	AudList_PurgeAudio__Fv
	.text
	.ent	AudList_LoadAudioFile__Fi
AudList_LoadAudioFile__Fi:
	.frame	$sp,152,$31		# vars= 128, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,152
	sw	$16,144($sp)
	move	$16,$4
	lui	$4,%hi($LC0) # high
	sw	$31,148($sp)
	.set	noreorder
	.set	nomacro
	jal	Track_MakeTrackPathName__FPc
	addiu	$4,$4,%lo($LC0) # low
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$7,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	loadfileadrz
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$31,148($sp)
	lw	$16,144($sp)
	sw	$2,gGameAudioList
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder

	.end	AudList_LoadAudioFile__Fi
