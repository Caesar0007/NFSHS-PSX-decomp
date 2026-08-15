	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sfxlevel.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDplatformfxmasterlevel
	.align	2
	.globl	SNDfxlevel

	.text
	.def	SNDfxBusView;	.scl	10;	.type	0x8;	.size	164;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	160;	.size	160;	.type	0x3c;	.endef
	.def	master;	.val	160;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	164;	.scl	102;	.tag	SNDfxBusView;	.size	164;	.endef
	.def	iSNDplatformfxmasterlevel;	.val	iSNDplatformfxmasterlevel;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformfxmasterlevel
iSNDplatformfxmasterlevel:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	bus;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sll	$4,$5,7
	addu	$4,$4,$5
	sll	$4,$4,1
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxeffectvol
	move	$5,$4
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatformfxmasterlevel
	.def	SNDfxlevel;	.val	SNDfxlevel;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDfxlevel
SNDfxlevel:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	tag;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	bus;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	19;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$4
	sw	$17,28($sp)
	move	$17,$5
	lui	$2,%hi(sndgs) # high
	sw	$18,32($sp)
	addiu	$18,$2,%lo(sndgs) # low
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	lb	$2,60($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	move	$19,$6
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L3:
	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$16,$L4
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	sll	$2,$17,4
	addu	$20,$2,$18
	move	$4,$16
$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	move	$5,$17
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lw	$3,148($18)
	sll	$2,$2,2
	addu	$3,$3,$2
	addu	$3,$3,$17
	lb	$2,52($3)
	#nop
	mult	$19,$2
	sb	$19,53($3)
	mflo	$8
	#nop
	lw	$2,160($20)
	#nop
	mult	$8,$2
	mflo	$2
	#nop
	li	$3,-2113536000			# 0x82060000
	ori	$3,$3,0x1029
	mult	$2,$3
	lw	$4,16($sp)
	mfhi	$3
	#nop
	#nop
	addu	$6,$3,$2
	sra	$6,$6,13
	sra	$2,$2,31
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformfxlevel
	subu	$6,$6,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L9
	move	$4,$16
	.set	macro
	.set	reorder

$L4:
	jal	iSNDleaveaudio
	move	$2,$16
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
LM2:
	.end	SNDfxlevel
