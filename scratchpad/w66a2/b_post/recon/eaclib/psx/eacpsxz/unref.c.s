	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\unref.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	unrefpack
	.align	2
	.globl	chase

	.comm	SQVd,4

	.comm	SQVclue,4

	.comm	SQVleft,4

	.comm	SQVright,4

	.text
	.def	unrefpack;	.val	unrefpack;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	unrefpack
unrefpack:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	comp;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	out_arg;	.val	5;	.scl	17;	.type	0x1c;	.endef
	.def	reverse_arg;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$6
	sw	$18,32($sp)
	move	$18,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$20,40($sp)
	move	$20,$0
	sw	$31,44($sp)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L2
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	addu	$18,$18,2
	.set	macro
	.set	reorder

	addu	$18,$18,3
$L3:
	lbu	$2,0($18)
	lbu	$3,1($18)
	lbu	$4,2($18)
	addu	$18,$18,3
	sll	$2,$2,16
	sll	$3,$3,8
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L2
	addu	$20,$2,$4
	.set	macro
	.set	reorder

	addu	$4,$19,$20
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

$L5:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$17,$2
	andi	$2,$17,0x0080
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	andi	$2,$17,0x0040
	.set	macro
	.set	reorder

	addu	$18,$18,2
	andi	$16,$17,0x0003
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$19,$19,$16
	addu	$18,$18,$16
	move	$4,$19
	sll	$5,$17,3
	andi	$5,$5,0x0300
	srl	$2,$17,8
	andi	$2,$2,0x00ff
	addu	$2,$2,1
	addu	$5,$5,$2
	srl	$6,$17,2
	andi	$6,$6,0x0007
	.set	noreorder
	.set	nomacro
	j	$L26
	addu	$6,$6,3
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	andi	$2,$17,0x0020
	.set	macro
	.set	reorder

	addu	$18,$18,3
	srl	$2,$17,14
	andi	$16,$2,0x0003
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$19,$19,$16
	addu	$18,$18,$16
	move	$4,$19
	srl	$2,$17,8
 #APP
 #NO_APP
	sll	$2,$2,8
	andi	$2,$2,0x3f00
	srl	$5,$17,16
	andi	$5,$5,0x00ff
	addu	$5,$5,1
	addu	$5,$2,$5
	andi	$6,$17,0x003f
	.set	noreorder
	.set	nomacro
	j	$L26
	addu	$6,$6,4
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	andi	$2,$17,0x00ff
	.set	macro
	.set	reorder

	addu	$18,$18,4
	andi	$16,$17,0x0003
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$19,$19,$16
	addu	$18,$18,$16
	move	$4,$19
	sll	$3,$17,12
	li	$2,65536			# 0x00010000
	and	$3,$3,$2
	andi	$2,$17,0xff00
	addu	$2,$2,1
	addu	$3,$3,$2
	srl	$5,$17,16
	andi	$5,$5,0x00ff
	addu	$5,$3,$5
	sll	$6,$17,6
	andi	$6,$6,0x0300
	srl	$2,$17,24
	addu	$6,$6,$2
	addu	$6,$6,5
$L26:
	jal	refcpy
	.set	noreorder
	.set	nomacro
	j	$L5
	move	$19,$2
	.set	macro
	.set	reorder

$L14:
	sltu	$2,$2,252
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	addu	$18,$18,1
	.set	macro
	.set	reorder

	andi	$2,$17,0x001f
	addu	$2,$2,1
	sll	$16,$2,2
	move	$4,$19
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	memcpyl
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$19,$19,$16
	.set	noreorder
	.set	nomacro
	j	$L5
	addu	$18,$18,$16
	.set	macro
	.set	reorder

$L18:
	andi	$16,$17,0x0003
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L27
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L23:
	lbu	$2,0($18)
	addu	$18,$18,1
	addu	$16,$16,-1
	sb	$2,0($19)
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L23
	addu	$19,$19,1
	.set	macro
	.set	reorder

	addu	$4,$sp,16
$L27:
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$19
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

$L2:
	move	$2,$20
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
	.end	unrefpack
	.def	chase;	.val	chase;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	chase
chase:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	code;	.val	4;	.scl	17;	.type	0xe;	.endef
	lw	$2,SQVclue
	subu	$sp,$sp,24
	sw	$16,16($sp)
	andi	$16,$4,0x00ff
	sw	$31,20($sp)
	addu	$2,$2,$16
	lb	$2,0($2)
	#nop
	beq	$2,$0,$L29
	lw	$2,SQVleft
	#nop
	addu	$2,$2,$16
	lbu	$4,0($2)
	jal	chase
	lw	$2,SQVright
	#nop
	addu	$2,$2,$16
	lbu	$4,0($2)
	jal	chase
	j	$L30
$L29:
	lw	$2,SQVd
	#nop
	sb	$4,0($2)
	addu	$2,$2,1
	sw	$2,SQVd
$L30:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	chase
	.def	SQVd;	.val	SQVd;	.scl	2;	.type	0x4;	.endef
	.def	SQVclue;	.val	SQVclue;	.scl	2;	.type	0x4;	.endef
	.def	SQVleft;	.val	SQVleft;	.scl	2;	.type	0x4;	.endef
	.def	SQVright;	.val	SQVright;	.scl	2;	.type	0x4;	.endef
