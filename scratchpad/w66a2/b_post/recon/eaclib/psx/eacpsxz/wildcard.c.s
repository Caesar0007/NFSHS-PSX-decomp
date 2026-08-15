	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\wildcard.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	strrstr
	.rdata
	.align	2
kOps.4:
	.ascii	"&|!~^\000"
	.text
	.align	2
	.globl	wildcard

	.text
	.def	strrstr;	.val	strrstr;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	strrstr
strrstr:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	s;	.val	18;	.scl	17;	.type	0x12;	.endef
	.def	set;	.val	16;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	sw	$17,20($sp)
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$17,$0
	.set	macro
	.set	reorder

$L3:
	lbu	$5,0($16)
	.set	noreorder
	.set	nomacro
	jal	strrchr
	move	$4,$18
	.set	macro
	.set	reorder

	move	$3,$2
	sltu	$2,$17,$3
	beq	$2,$0,$L6
	move	$17,$3
$L6:
	addu	$16,$16,1
	lbu	$2,0($16)
	#nop
	bne	$2,$0,$L3
$L2:
	move	$2,$17
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
	.end	strrstr
	.def	wildcard;	.val	wildcard;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	wildcard
wildcard:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	text;	.val	17;	.scl	17;	.type	0x12;	.endef
	.def	pat;	.val	18;	.scl	17;	.type	0x12;	.endef
	subu	$sp,$sp,40
	sw	$17,20($sp)
	move	$17,$4
	sw	$18,24($sp)
	move	$18,$5
	move	$4,$18
	lui	$5,%hi(kOps.4) # high
	addiu	$5,$5,%lo(kOps.4) # low
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	.set	noreorder
	.set	nomacro
	jal	strrstr
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$19,$2
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L20
	li	$2,38			# 0x00000026
	.set	macro
	.set	reorder

	lbu	$20,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L10
	li	$2,124			# 0x0000007c
	.set	macro
	.set	reorder

	sb	$0,0($19)
	move	$16,$0
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	wildcard
	addu	$5,$19,1
	.set	macro
	.set	reorder

	sltu	$16,$0,$2
$L11:
	sb	$20,0($19)
	.set	noreorder
	.set	nomacro
	j	$L37
	move	$2,$16
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L12
	li	$2,33			# 0x00000021
	.set	macro
	.set	reorder

	sb	$0,0($19)
	move	$16,$0
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L14
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	wildcard
	addu	$5,$19,1
	.set	macro
	.set	reorder

	beq	$2,$0,$L13
$L14:
	li	$16,1			# 0x00000001
$L13:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$2,124			# 0x0000007c
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	beq	$20,$2,$L16
	li	$2,126			# 0x0000007e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L15
	li	$2,94			# 0x0000005e
	.set	macro
	.set	reorder

$L16:
	sb	$0,0($19)
	move	$16,$0
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L18
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	wildcard
	addu	$5,$19,1
	.set	macro
	.set	reorder

	beq	$2,$0,$L17
$L18:
	li	$16,1			# 0x00000001
$L17:
	li	$2,33			# 0x00000021
$L39:
	sb	$2,0($19)
	.set	noreorder
	.set	nomacro
	j	$L37
	move	$2,$16
	.set	macro
	.set	reorder

$L15:
	.set	noreorder
	.set	nomacro
	bne	$20,$2,$L40
	lui	$2,%hi(_ctype_+1) # high
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$18
	.set	noreorder
	.set	nomacro
	jal	wildcard
	sb	$0,0($19)
	.set	macro
	.set	reorder

	move	$4,$17
	addu	$5,$19,1
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$16,$2
	.set	macro
	.set	reorder

	xor	$2,$16,$2
	.set	noreorder
	.set	nomacro
	j	$L37
	sb	$20,0($19)
	.set	macro
	.set	reorder

	.def	notleaf;	.val	$L21;	.scl	6;	.type	0x0;	.endef
$L21:
	.set	noreorder
	.set	nomacro
	jal	wildcard
	addu	$5,$18,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L37
	sltu	$2,$2,1
	.set	macro
	.set	reorder

	.def	leaf;	.val	$L20;	.scl	6;	.type	0x0;	.endef
$L20:
	lui	$2,%hi(_ctype_+1) # high
$L40:
	addiu	$19,$2,%lo(_ctype_+1) # low
	.def	loop;	.val	$L22;	.scl	6;	.type	0x0;	.endef
$L22:
	lbu	$3,0($18)
	li	$2,42			# 0x0000002a
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L23
	li	$2,63			# 0x0000003f
	.set	macro
	.set	reorder

	addu	$18,$18,1
$L24:
	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	wildcard
	move	$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L37
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L24
	addu	$17,$17,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L37
	move	$2,$0
	.set	macro
	.set	reorder

$L23:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L29
	li	$2,35			# 0x00000023
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	.set	noreorder
	.set	nomacro
	j	$L30
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L29:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L31
	li	$2,126			# 0x0000007e
	.set	macro
	.set	reorder

	lbu	$2,0($17)
	#nop
	addu	$2,$2,$19
	lbu	$2,0($2)
	addu	$18,$18,1
	andi	$2,$2,0x0004
	.def	join;	.val	$L30;	.scl	6;	.type	0x0;	.endef
$L30:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L33
	addu	$17,$17,1
	.set	macro
	.set	reorder

	j	$L22
$L31:
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L21
	move	$4,$17
	.set	macro
	.set	reorder

	lbu	$4,0($18)
	jal	tolower
	lbu	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	tolower
	move	$16,$2
	.set	macro
	.set	reorder

	andi	$16,$16,0x00ff
	andi	$2,$2,0x00ff
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L37
	move	$2,$0
	.set	macro
	.set	reorder

	lbu	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L38
	addu	$18,$18,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L22
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L38:
	.set	noreorder
	.set	nomacro
	j	$L37
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	ret0;	.val	$L33;	.scl	6;	.type	0x0;	.endef
$L33:
	move	$2,$0
$L37:
	lw	$31,36($sp)
	lw	$20,32($sp)
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
	.end	wildcard
