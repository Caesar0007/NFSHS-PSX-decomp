	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbend.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDunsafebend
	.align	2
	.globl	SNDpitchbend

	.text
	.def	iSNDunsafebend;	.val	iSNDunsafebend;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDunsafebend
iSNDunsafebend:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	chan;	.val	18;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$5
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bltz	$17,$L2
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	lui	$2,%hi(sndgs) # high
	addiu	$19,$2,%lo(sndgs) # low
	move	$4,$17
$L10:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($19)
	sll	$2,$2,2
	addu	$16,$3,$2
	lb	$2,47($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$18,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	lh	$2,90($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	sb	$18,47($16)
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcpitch
	sh	$0,94($16)
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lhu	$5,98($16)
	jal	iSNDplatformpitch
	.set	noreorder
	.set	nomacro
	j	$L10
	move	$4,$17
	.set	macro
	.set	reorder

$L2:
	move	$2,$17
$L8:
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


	.loc	1 0
LM1:
	.end	iSNDunsafebend
	.def	SNDpitchbend;	.val	SNDpitchbend;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDpitchbend
SNDpitchbend:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	bend;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDunsafebend
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDleaveaudio
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L13
	move	$2,$16
	.set	macro
	.set	reorder

$L12:
	li	$2,-10			# 0xfffffff6
$L13:
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


	.loc	1 0
LM2:
	.end	SNDpitchbend
