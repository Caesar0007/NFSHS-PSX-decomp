	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\saetodv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDabs
	.align	2
	.globl	iSNDatodlrv

	.text
	.def	iSNDabs;	.val	iSNDabs;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDabs
iSNDabs:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	a;	.val	2;	.scl	17;	.type	0x4;	.endef
	move	$2,$4
	bgez	$2,$L3
	subu	$2,$0,$2
$L3:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDabs
	.def	iSNDatodlrv;	.val	iSNDatodlrv;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDatodlrv
iSNDatodlrv:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	angle;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	level;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	out_l;	.val	17;	.scl	17;	.type	0x14;	.endef
	.def	out_r;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	prevL;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	prevR;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	prevL;	.val	20;	.scl	4;	.type	0x4;	.endef
	.def	prevR;	.val	19;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$17,20($sp)
	move	$17,$6
	sw	$18,24($sp)
	move	$18,$7
	sw	$20,32($sp)
	lw	$20,64($sp)
	sw	$19,28($sp)
	lw	$19,68($sp)
	sw	$31,40($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDlibatodlrv
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	bgez	$20,$L5
	.set	noreorder
	.set	nomacro
	bgez	$19,$L9
	slt	$2,$20,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	bltz	$19,$L9
	slt	$2,$20,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$5,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L8
	li	$5,2			# 0x00000002
	.set	macro
	.set	reorder

$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDabs
	move	$4,$20
	.set	macro
	.set	reorder

	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	iSNDabs
	move	$16,$2
	.set	macro
	.set	reorder

	slt	$2,$2,$16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$5,3			# 0x00000003
	.set	macro
	.set	reorder

	li	$5,4			# 0x00000004
	.def	have_quad;	.val	$L8;	.scl	6;	.type	0x0;	.endef
$L8:
	addu	$3,$21,-16384
	li	$2,32767			# 0x00007fff
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	move	$6,$0
	.set	macro
	.set	reorder

	lw	$2,0($17)
	lw	$3,0($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L15
	li	$4,4			# 0x00000004
	.set	macro
	.set	reorder

	li	$4,3			# 0x00000003
$L15:
	slt	$2,$5,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L18
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

	bne	$5,$6,$L18
	.set	noreorder
	.set	nomacro
	j	$L18
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

$L14:
	lw	$2,0($17)
	lw	$3,0($18)
	#nop
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L19
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,2			# 0x00000002
$L19:
	slt	$2,$5,3
	bne	$2,$0,$L18
	li	$6,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	bne	$4,$6,$L18
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	bne	$5,$2,$L18
	li	$6,1			# 0x00000001
$L18:
	bgez	$20,$L21
	lw	$2,0($17)
	#nop
	subu	$2,$0,$2
	sw	$2,0($17)
$L21:
	.set	noreorder
	.set	nomacro
	bgez	$19,$L27
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	subu	$2,$0,$2
	sw	$2,0($18)
	li	$2,1			# 0x00000001
$L27:
	.set	noreorder
	.set	nomacro
	bne	$6,$2,$L23
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	lw	$2,0($17)
	#nop
	subu	$2,$0,$2
	.set	noreorder
	.set	nomacro
	j	$L24
	sw	$2,0($17)
	.set	macro
	.set	reorder

$L23:
	bne	$6,$2,$L24
	lw	$2,0($18)
	#nop
	subu	$2,$0,$2
	sw	$2,0($18)
$L24:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDatodlrv
