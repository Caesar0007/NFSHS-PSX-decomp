	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sautovol.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDautovol

	.text
	.def	SNDautovol;	.val	SNDautovol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDautovol
SNDautovol:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	rate;	.val	17;	.scl	17;	.type	0xe;	.endef
	.def	target;	.val	20;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$17,28($sp)
	move	$17,$5
	lui	$2,%hi(sndgs) # high
	sw	$19,36($sp)
	addiu	$19,$2,%lo(sndgs) # low
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$18,32($sp)
	lb	$2,60($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$20,$6
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

	move	$18,$2
	bltz	$18,$L3
	.set	noreorder
	.set	nomacro
	bgtz	$17,$L9
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	li	$17,1			# 0x00000001
$L9:
	sw	$2,16($sp)
	sll	$16,$20,16
$L5:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	beq	$2,$0,$L3
	lw	$3,16($sp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($19)
	sll	$2,$2,2
	addu	$3,$3,$2
	lw	$2,28($3)
	#nop
	subu	$2,$16,$2
	div	$2,$2,$17
	sw	$16,24($3)
	.set	noreorder
	.set	nomacro
	j	$L5
	sw	$2,20($3)
	.set	macro
	.set	reorder

$L3:
	jal	iSNDleaveaudio
	move	$2,$18
$L8:
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


	.loc	1 0
LM1:
	.end	SNDautovol
