	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\unhuff.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	unhuff
	.align	2
	.globl	memcpyl
	.align	2
	.globl	memcpyb
	.align	2
	.globl	refcpy

	.text
	.def	unhuff;	.val	unhuff;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	unhuff
unhuff:
	.frame	$sp,1264,$31		# vars= 1224, regs= 9/0, args= 0, extra= 0
	.mask	0x40ff0000,-8
	.fmask	0x00000000,0
	.def	comp;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	out;	.val	4;	.scl	9;	.type	0x1c;	.endef
	.def	doDecode;	.val	10;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,1264
	move	$10,$6
	move	$9,$4
	sw	$5,1268($sp)
	move	$15,$5
	sw	$22,1248($sp)
	move	$22,$0
	sw	$fp,1256($sp)
	sw	$23,1252($sp)
	sw	$21,1244($sp)
	sw	$20,1240($sp)
	sw	$19,1236($sp)
	sw	$18,1232($sp)
	sw	$17,1228($sp)
	.set	noreorder
	.set	nomacro
	beq	$9,$0,$L2
	sw	$16,1224($sp)
	.set	macro
	.set	reorder

	lbu	$8,0($9)
	lbu	$3,1($9)
	addu	$9,$9,2
	lbu	$4,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	move	$7,$22
	sll	$2,$8,8
	or	$8,$3,$2
	move	$23,$8
	sll	$2,$23,8
	or	$8,$4,$2
	sll	$2,$8,8
	or	$8,$5,$2
	andi	$2,$23,0x0100
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L5
	sll	$5,$8,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$4,1($9)
	addu	$9,$9,2
	lbu	$5,0($9)
	lbu	$6,1($9)
	addu	$9,$9,2
	li	$7,8			# 0x00000008
	sll	$2,$8,$7
	or	$8,$3,$2
	sll	$2,$8,$7
	or	$8,$4,$2
	sll	$2,$8,$7
	or	$8,$5,$2
	sll	$2,$8,$7
	or	$8,$6,$2
	sll	$5,$8,$7
$L5:
	li	$2,-257			# 0xfffffeff
	and	$23,$23,$2
	srl	$6,$5,24
	addu	$7,$7,-8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L8
	sll	$5,$5,8
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L8:
	srl	$22,$5,16
	addu	$7,$7,-16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L9
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L9:
	sll	$2,$6,16
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L10
	or	$22,$22,$2
	.set	macro
	.set	reorder

	srl	$fp,$5,24
	addu	$7,$7,-8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L11
	sll	$5,$5,8
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L11:
	move	$17,$0
	li	$6,1			# 0x00000001
	move	$13,$17
	move	$18,$6
	addu	$16,$sp,4
	li	$14,4			# 0x00000004
$L12:
	sll	$13,$13,1
	addu	$3,$sp,$14
	subu	$2,$13,$17
	.set	noreorder
	.set	nomacro
	bgez	$5,$L15
	sw	$2,64($3)
	.set	macro
	.set	reorder

	srl	$11,$5,29
	addu	$7,$7,-3
	.set	noreorder
	.set	nomacro
	bgez	$7,$L16
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L16:
	.set	noreorder
	.set	nomacro
	j	$L17
	addu	$11,$11,-4
	.set	macro
	.set	reorder

$L15:
	srl	$2,$5,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L18
	li	$10,2			# 0x00000002
	.set	macro
	.set	reorder

$L19:
	sll	$5,$5,1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L19
	addu	$10,$10,1
	.set	macro
	.set	reorder

	addu	$2,$7,1
	subu	$7,$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L24
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L24
	sll	$5,$8,$4
	.set	macro
	.set	reorder

$L18:
	addu	$10,$10,1
$L165:
	srl	$11,$5,31
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bgez	$7,$L27
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L27:
	.set	noreorder
	.set	nomacro
	beq	$11,$0,$L165
	addu	$10,$10,1
	.set	macro
	.set	reorder

	addu	$10,$10,-1
$L24:
	slt	$2,$10,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$2,48			# 0x00000030
	subu	$2,$2,$10
	srl	$11,$5,$2
	addu	$2,$10,-16
	sll	$5,$5,$2
	addu	$2,$7,16
	subu	$7,$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L166
	srl	$12,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
	srl	$12,$5,16
$L166:
	addu	$7,$7,-16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L32
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L32:
	sll	$2,$11,16
	or	$2,$12,$2
	sll	$3,$18,$10
	.set	noreorder
	.set	nomacro
	j	$L157
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L30:
	subu	$2,$2,$10
	srl	$11,$5,$2
	subu	$7,$7,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L34
	sll	$5,$5,$10
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L34:
	sll	$2,$18,$10
	addu	$2,$11,$2
$L157:
	addu	$11,$2,-4
$L17:
	sw	$11,0($16)
	addu	$17,$17,$11
	addu	$13,$13,$11
	.set	noreorder
	.set	nomacro
	beq	$11,$0,$L35
	move	$4,$0
	.set	macro
	.set	reorder

	li	$2,16			# 0x00000010
	subu	$2,$2,$6
	sll	$2,$13,$2
	andi	$4,$2,0xffff
$L35:
	addu	$10,$sp,128
	addu	$2,$10,$14
	sw	$4,0($2)
	addu	$16,$16,4
	addu	$14,$14,4
	.set	noreorder
	.set	nomacro
	beq	$11,$0,$L12
	addu	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L12
	addu	$2,$6,-1
	.set	macro
	.set	reorder

	sll	$3,$2,2
	addu	$3,$10,$3
	li	$4,-1			# 0xffffffff
	sw	$4,0($3)
	move	$21,$2
	li	$6,16			# 0x00000010
	move	$4,$0
	addu	$3,$sp,960
	addu	$2,$sp,972
$L39:
	sw	$4,0($3)
	sw	$4,-8($2)
	sw	$4,-4($2)
	sw	$4,0($2)
	addu	$2,$2,16
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L39
	addu	$3,$3,16
	.set	macro
	.set	reorder

	li	$13,255			# 0x000000ff
	.set	noreorder
	.set	nomacro
	blez	$17,$L42
	move	$12,$0
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	addu	$14,$sp,960
$L44:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L45
	srl	$2,$5,16
	.set	macro
	.set	reorder

	srl	$6,$5,29
	addu	$7,$7,-3
	.set	noreorder
	.set	nomacro
	bgez	$7,$L46
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L46:
	.set	noreorder
	.set	nomacro
	j	$L47
	addu	$6,$6,-4
	.set	macro
	.set	reorder

$L45:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L48
	li	$10,2			# 0x00000002
	.set	macro
	.set	reorder

$L49:
	sll	$5,$5,1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L49
	addu	$10,$10,1
	.set	macro
	.set	reorder

	addu	$2,$7,1
	subu	$7,$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L54
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L54
	sll	$5,$8,$4
	.set	macro
	.set	reorder

$L48:
	addu	$10,$10,1
$L167:
	srl	$6,$5,31
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bgez	$7,$L57
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L57:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L167
	addu	$10,$10,1
	.set	macro
	.set	reorder

	addu	$10,$10,-1
$L54:
	slt	$2,$10,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L60
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$2,48			# 0x00000030
	subu	$2,$2,$10
	srl	$6,$5,$2
	addu	$2,$10,-16
	sll	$5,$5,$2
	addu	$2,$7,16
	subu	$7,$2,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L168
	srl	$11,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
	srl	$11,$5,16
$L168:
	addu	$7,$7,-16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L62
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L62:
	sll	$2,$6,16
	or	$2,$11,$2
	sll	$3,$16,$10
	.set	noreorder
	.set	nomacro
	j	$L158
	addu	$2,$2,$3
	.set	macro
	.set	reorder

$L60:
	subu	$2,$2,$10
	srl	$6,$5,$2
	subu	$7,$7,$10
	.set	noreorder
	.set	nomacro
	bgez	$7,$L64
	sll	$5,$5,$10
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L64:
	sll	$2,$16,$10
	addu	$2,$6,$2
$L158:
	addu	$6,$2,-4
$L47:
	addu	$6,$6,1
$L65:
	addu	$4,$13,1
	move	$13,$4
	andi	$2,$13,0x00ff
	addu	$3,$14,$2
	lb	$2,0($3)
	#nop
	bne	$2,$0,$L67
	addu	$6,$6,-1
$L67:
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L65
	addu	$2,$sp,$12
	.set	macro
	.set	reorder

	addu	$12,$12,1
	sb	$16,0($3)
	sb	$4,192($2)
	slt	$2,$12,$17
	bne	$2,$0,$L44
$L42:
	li	$6,16			# 0x00000010
	li	$3,1077936128			# 0x40400000
	ori	$3,$3,0x4040
	addu	$4,$sp,704
	addu	$2,$sp,716
$L73:
	sw	$3,0($4)
	sw	$3,-8($2)
	sw	$3,-4($2)
	sw	$3,0($2)
	addu	$2,$2,16
	addu	$6,$6,-1
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L73
	addu	$4,$4,16
	.set	macro
	.set	reorder

	addu	$24,$sp,192
	addu	$14,$sp,448
	addu	$13,$sp,704
	.set	noreorder
	.set	nomacro
	blez	$21,$L94
	li	$11,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$20,8			# 0x00000008
	move	$19,$11
	li	$18,-1			# 0xffffffff
	andi	$17,$fp,0x00ff
	addu	$25,$sp,4
$L78:
	lw	$4,0($25)
	slt	$2,$11,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	addu	$4,$4,-1
	.set	macro
	.set	reorder

	subu	$2,$20,$11
	.set	noreorder
	.set	nomacro
	beq	$4,$18,$L77
	sll	$12,$19,$2
	.set	macro
	.set	reorder

	li	$16,-1			# 0xffffffff
$L82:
	lbu	$10,0($24)
	addu	$24,$24,1
	.set	noreorder
	.set	nomacro
	bne	$10,$17,$L83
	move	$6,$11
	.set	macro
	.set	reorder

	sw	$11,1216($sp)
	li	$6,96			# 0x00000060
$L83:
	.set	noreorder
	.set	nomacro
	blez	$12,$L80
	move	$3,$0
	.set	macro
	.set	reorder

$L87:
	sb	$10,0($14)
	addu	$14,$14,1
	sb	$6,0($13)
	addu	$3,$3,1
	slt	$2,$3,$12
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L87
	addu	$13,$13,1
	.set	macro
	.set	reorder

$L80:
	addu	$4,$4,-1
	bne	$4,$16,$L82
$L77:
	addu	$11,$11,1
	slt	$2,$21,$11
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L78
	addu	$25,$25,4
	.set	macro
	.set	reorder

$L10:
	addu	$14,$sp,448
	.set	noreorder
	.set	nomacro
	j	$L94
	addu	$13,$sp,704
	.set	macro
	.set	reorder

$L95:
	addu	$2,$14,$2
	lbu	$2,0($2)
	#nop
	sb	$2,0($15)
	addu	$15,$15,1
	lbu	$3,0($9)
	lbu	$4,1($9)
	addu	$9,$9,2
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$4,$2
	li	$2,16			# 0x00000010
	subu	$2,$2,$7
	sll	$5,$8,$2
	.def	nextloop;	.val	$L94;	.scl	6;	.type	0x0;	.endef
$L94:
	srl	$3,$5,24
	addu	$2,$13,$3
	lbu	$6,0($2)
	.set	noreorder
	.set	nomacro
	j	$L161
	subu	$7,$7,$6
	.set	macro
	.set	reorder

$L102:
	addu	$2,$14,$3
	sll	$5,$5,$6
	lbu	$2,0($2)
	srl	$3,$5,24
	sb	$2,0($15)
	addu	$2,$13,$3
	lbu	$6,0($2)
	#nop
	subu	$7,$7,$6
	.set	noreorder
	.set	nomacro
	bltz	$7,$L98
	addu	$15,$15,1
	.set	macro
	.set	reorder

	addu	$2,$14,$3
	sll	$5,$5,$6
	lbu	$2,0($2)
	srl	$3,$5,24
	sb	$2,0($15)
	addu	$2,$13,$3
	lbu	$6,0($2)
	#nop
	subu	$7,$7,$6
	.set	noreorder
	.set	nomacro
	bltz	$7,$L98
	addu	$15,$15,1
	.set	macro
	.set	reorder

	addu	$2,$14,$3
	sll	$5,$5,$6
	lbu	$2,0($2)
	srl	$3,$5,24
	sb	$2,0($15)
	addu	$2,$13,$3
	lbu	$6,0($2)
	addu	$15,$15,1
	subu	$7,$7,$6
$L161:
	.set	noreorder
	.set	nomacro
	bltz	$7,$L98
	addu	$2,$14,$3
	.set	macro
	.set	reorder

	sll	$5,$5,$6
	lbu	$2,0($2)
	srl	$3,$5,24
	sb	$2,0($15)
	addu	$2,$13,$3
	lbu	$6,0($2)
	#nop
	subu	$7,$7,$6
	.set	noreorder
	.set	nomacro
	bgez	$7,$L102
	addu	$15,$15,1
	.set	macro
	.set	reorder

$L98:
	addu	$7,$7,16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L95
	srl	$2,$5,24
	.set	macro
	.set	reorder

	addu	$2,$6,-16
	addu	$7,$7,$2
	li	$2,96			# 0x00000060
	.set	noreorder
	.set	nomacro
	beq	$6,$2,$L108
	srl	$4,$5,16
	.set	macro
	.set	reorder

	li	$6,8			# 0x00000008
	addu	$3,$sp,160
$L109:
	addu	$3,$3,4
	lw	$2,0($3)
	#nop
	sltu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L109
	addu	$6,$6,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L162
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

$L108:
	lw	$6,1216($sp)
	li	$2,32			# 0x00000020
$L162:
	subu	$2,$2,$6
	srl	$4,$5,$2
	sll	$2,$6,2
	addu	$2,$sp,$2
	lw	$2,64($2)
	sll	$5,$5,$6
	subu	$2,$4,$2
	addu	$2,$sp,$2
	lbu	$10,192($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$10,$fp,$L114
	subu	$7,$7,$6
	.set	macro
	.set	reorder

	bltz	$7,$L156
	.set	noreorder
	.set	nomacro
	j	$L163
	sb	$10,0($15)
	.set	macro
	.set	reorder

$L114:
	bgez	$7,$L115
$L156:
	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L115:
	beq	$10,$fp,$L116
	sb	$10,0($15)
$L163:
	.set	noreorder
	.set	nomacro
	j	$L94
	addu	$15,$15,1
	.set	macro
	.set	reorder

$L116:
	.set	noreorder
	.set	nomacro
	bgez	$5,$L117
	move	$11,$15
	.set	macro
	.set	reorder

	srl	$10,$5,29
	addu	$7,$7,-3
	.set	noreorder
	.set	nomacro
	bgez	$7,$L118
	sll	$5,$5,3
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L118:
	.set	noreorder
	.set	nomacro
	j	$L119
	addu	$10,$10,-4
	.set	macro
	.set	reorder

$L117:
	srl	$2,$5,16
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L120
	li	$6,2			# 0x00000002
	.set	macro
	.set	reorder

$L121:
	sll	$5,$5,1
	.set	noreorder
	.set	nomacro
	bgez	$5,$L121
	addu	$6,$6,1
	.set	macro
	.set	reorder

	addu	$2,$7,1
	subu	$7,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$7,$L126
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	.set	noreorder
	.set	nomacro
	j	$L126
	sll	$5,$8,$4
	.set	macro
	.set	reorder

$L120:
	addu	$6,$6,1
$L169:
	srl	$10,$5,31
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bgez	$7,$L129
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L129:
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L169
	addu	$6,$6,1
	.set	macro
	.set	reorder

	addu	$6,$6,-1
$L126:
	slt	$2,$6,17
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L132
	li	$2,32			# 0x00000020
	.set	macro
	.set	reorder

	li	$2,48			# 0x00000030
	subu	$2,$2,$6
	srl	$10,$5,$2
	addu	$2,$6,-16
	sll	$5,$5,$2
	addu	$2,$7,16
	subu	$7,$2,$6
	.set	noreorder
	.set	nomacro
	bgez	$7,$L170
	srl	$12,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
	srl	$12,$5,16
$L170:
	addu	$7,$7,-16
	.set	noreorder
	.set	nomacro
	bgez	$7,$L134
	sll	$5,$5,16
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L134:
	sll	$3,$10,16
	or	$3,$12,$3
	li	$2,1			# 0x00000001
	sll	$2,$2,$6
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	j	$L119
	addu	$10,$3,-4
	.set	macro
	.set	reorder

$L132:
	subu	$2,$2,$6
	srl	$10,$5,$2
	subu	$7,$7,$6
	.set	noreorder
	.set	nomacro
	bgez	$7,$L136
	sll	$5,$5,$6
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L136:
	li	$2,1			# 0x00000001
	sll	$2,$2,$6
	addu	$2,$10,$2
	addu	$10,$2,-4
$L119:
	.set	noreorder
	.set	nomacro
	beq	$10,$0,$L137
	addu	$3,$11,$10
	.set	macro
	.set	reorder

	lbu	$10,-1($11)
$L138:
	sb	$10,0($11)
	addu	$11,$11,1
	sltu	$2,$11,$3
	bne	$2,$0,$L138
	.set	noreorder
	.set	nomacro
	j	$L94
	move	$15,$11
	.set	macro
	.set	reorder

$L137:
	srl	$6,$5,31
	addu	$7,$7,-1
	.set	noreorder
	.set	nomacro
	bgez	$7,$L142
	sll	$5,$5,1
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L142:
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L92
	srl	$6,$5,24
	.set	macro
	.set	reorder

	addu	$7,$7,-8
	.set	noreorder
	.set	nomacro
	bgez	$7,$L144
	sll	$5,$5,8
	.set	macro
	.set	reorder

	lbu	$3,0($9)
	lbu	$5,1($9)
	addu	$9,$9,2
	subu	$4,$0,$7
	addu	$7,$7,16
	sll	$2,$8,8
	or	$8,$3,$2
	sll	$2,$8,8
	or	$8,$5,$2
	sll	$5,$8,$4
$L144:
	sb	$6,0($15)
	.set	noreorder
	.set	nomacro
	j	$L94
	addu	$15,$15,1
	.set	macro
	.set	reorder

$L92:
	li	$2,13051			# 0x000032fb
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L145
	li	$2,13563			# 0x000034fb
	.set	macro
	.set	reorder

	lw	$15,1268($sp)
	#nop
	addu	$4,$15,$22
	sltu	$2,$15,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$3,$0
	.set	macro
	.set	reorder

$L148:
	lbu	$2,0($15)
	#nop
	addu	$3,$3,$2
	sb	$3,0($15)
	addu	$15,$15,1
	sltu	$2,$15,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L148
	move	$2,$22
	.set	macro
	.set	reorder

	j	$L164
$L145:
	.set	noreorder
	.set	nomacro
	bne	$23,$2,$L164
	move	$2,$22
	.set	macro
	.set	reorder

	move	$3,$0
	lw	$15,1268($sp)
	#nop
	addu	$5,$15,$22
	sltu	$2,$15,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$4,$3
	.set	macro
	.set	reorder

$L154:
	lbu	$2,0($15)
	#nop
	addu	$3,$3,$2
	addu	$4,$4,$3
	sb	$4,0($15)
	addu	$15,$15,1
	sltu	$2,$15,$5
	bne	$2,$0,$L154
$L2:
	move	$2,$22
$L164:
	lw	$fp,1256($sp)
	lw	$23,1252($sp)
	lw	$22,1248($sp)
	lw	$21,1244($sp)
	lw	$20,1240($sp)
	lw	$19,1236($sp)
	lw	$18,1232($sp)
	lw	$17,1228($sp)
	lw	$16,1224($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,1264
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	unhuff
	.def	memcpyl;	.val	memcpyl;	.scl	2;	.type	0x62;	.endef
	.text
	.ent	memcpyl
memcpyl:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	dst;	.val	16;	.scl	17;	.type	0x12;	.endef
	.def	src;	.val	18;	.scl	17;	.type	0x12;	.endef
	.def	n;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$16,16($sp)
	move	$16,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$19,28($sp)
	addu	$19,$16,$17
	sw	$31,32($sp)
$L173:
	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	geti
	li	$5,4			# 0x00000004
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	.set	noreorder
	.set	nomacro
	jal	puti
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$16,$16,4
	addu	$17,$17,-4
	.set	noreorder
	.set	nomacro
	bgtz	$17,$L173
	addu	$18,$18,4
	.set	macro
	.set	reorder

	move	$2,$19
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
	.end	memcpyl
	.def	memcpyb;	.val	memcpyb;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	memcpyb
memcpyb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	dst;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	src;	.val	5;	.scl	17;	.type	0x1c;	.endef
	.def	n;	.val	6;	.scl	17;	.type	0x4;	.endef
$L178:
	lbu	$2,0($5)
	addu	$5,$5,1
	addu	$6,$6,-1
	sb	$2,0($4)
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L178
	addu	$4,$4,1
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM3:
	.end	memcpyb
	.def	refcpy;	.val	refcpy;	.scl	2;	.type	0x6c;	.endef
	.text
	.ent	refcpy
refcpy:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	dst;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	dist;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	len;	.val	6;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sltu	$2,$5,4
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L183
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L184
	addu	$16,$4,$6
	.set	macro
	.set	reorder

	lbu	$5,-1($4)
	jal	memset
	.set	noreorder
	.set	nomacro
	j	$L187
	move	$2,$16
	.set	macro
	.set	reorder

$L184:
	.set	noreorder
	.set	nomacro
	jal	memcpyb
	subu	$5,$4,$5
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L187
	move	$2,$16
	.set	macro
	.set	reorder

$L183:
	.set	noreorder
	.set	nomacro
	jal	memcpyl
	subu	$5,$4,$5
	.set	macro
	.set	reorder

	move	$16,$2
	move	$2,$16
$L187:
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
LM4:
	.end	refcpy
