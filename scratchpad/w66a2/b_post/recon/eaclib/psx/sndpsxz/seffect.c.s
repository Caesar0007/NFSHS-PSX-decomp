	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\seffect.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDfxinitbus
	.align	2
	.globl	SNDfxmasterlevel

	.text
	.def	SNDfxinitbus;	.val	SNDfxinitbus;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDfxinitbus
SNDfxinitbus:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	bus;	.val	17;	.scl	17;	.type	0x4;	.endef
	.def	mode;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	arg2;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	arg3;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	arg4;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	arg4;	.val	7;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$16,16($sp)
	move	$16,$6
	move	$6,$7
	move	$5,$16
	sll	$3,$17,4
	lui	$2,%hi(sndgs+156) # high
	addiu	$2,$2,%lo(sndgs+156) # low
	lw	$7,48($sp)
	addu	$3,$3,$2
	sw	$31,28($sp)
	sw	$16,0($3)
	sw	$6,8($3)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformfxinit
	sw	$7,12($3)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L3
	move	$4,$17
	.set	macro
	.set	reorder

	move	$18,$0
$L3:
	.set	noreorder
	.set	nomacro
	jal	SNDfxmasterlevel
	move	$5,$18
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


	.loc	1 0
LM1:
	.end	SNDfxinitbus
	.def	SNDfxmasterlevel;	.val	SNDfxmasterlevel;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDfxmasterlevel
SNDfxmasterlevel:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	bus;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	lui	$2,%hi(sndgs) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(sndgs) # low
	sll	$2,$19,4
	addu	$2,$2,$17
	sw	$31,32($sp)
	sw	$18,24($sp)
	sw	$16,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformfxmasterlevel
	sw	$5,160($2)
	.set	macro
	.set	reorder

	bltz	$2,$L12
	lb	$2,60($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L12
	move	$2,$0
	.set	macro
	.set	reorder

	lbu	$2,17($17)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$17
	move	$17,$16
$L10:
	lw	$2,148($18)
	move	$5,$19
	addu	$2,$17,$2
	lw	$4,0($2)
	addu	$2,$2,$19
	lb	$6,53($2)
	.set	noreorder
	.set	nomacro
	jal	SNDfxlevel
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lbu	$2,17($18)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	addu	$17,$17,100
	.set	macro
	.set	reorder

$L8:
	move	$2,$0
$L12:
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


	.loc	1 0
LM2:
	.end	SNDfxmasterlevel
