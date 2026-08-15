	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spitch.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDpitchmult

	.text
	.def	SNDpitchmult;	.val	SNDpitchmult;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDpitchmult
SNDpitchmult:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	mult;	.val	18;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	lui	$2,%hi(sndgs) # high
	sw	$19,36($sp)
	addiu	$19,$2,%lo(sndgs) # low
	sw	$31,40($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	lb	$2,60($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$18,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bltz	$17,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	move	$4,$17
$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L3
	lw	$4,16($sp)
	lw	$3,148($19)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$16,$3,$2
	lhu	$2,96($16)
	#nop
	beq	$2,$18,$L3
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcpitch
	sh	$18,96($16)
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lhu	$5,98($16)
	jal	iSNDplatformpitch
	.set	noreorder
	.set	nomacro
	j	$L9
	move	$4,$17
	.set	macro
	.set	reorder

$L3:
	jal	iSNDleaveaudio
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
	.end	SNDpitchmult
