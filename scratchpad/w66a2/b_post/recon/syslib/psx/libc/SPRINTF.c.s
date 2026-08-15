	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libc\\SPRINTF.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.rdata
	.align	2
$LC0:
	.ascii	"0123456789ABCDEF\000"
	.align	2
$LC1:
	.ascii	"0123456789abcdef\000"
	.text
	.align	2
	.globl	sprintf

	.extern	D_8012348C, 12

	.text
	.def	.0fake;	.scl	15;	.type	0xa;	.size	4;	.endef
	.def	false;	.val	0;	.scl	16;	.type	0xb;	.endef
	.def	true;	.val	1;	.scl	16;	.type	0xb;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	.0fake;	.size	4;	.endef
	.def	bool;	.scl	13;	.tag	.0fake;	.size	4;	.type	0xa;	.endef
	.def	va_list;	.scl	13;	.type	0x12;	.endef
	.def	printf_info;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	leftJustified;	.val	0;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	prependPlus;	.val	1;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	alternativeForm;	.val	2;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	leadingZeros;	.val	3;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	usePrecision;	.val	4;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	isHalf;	.val	5;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	isLong;	.val	6;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	isLongLong;	.val	7;	.scl	18;	.tag	.0fake;	.size	4;	.type	0xa;	.size	1;	.endef
	.def	leadingChar;	.val	1;	.scl	8;	.type	0x2;	.endef
	.def	width;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	precision;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	printf_info;	.size	12;	.endef
	.def	printf_info;	.scl	13;	.tag	printf_info;	.size	12;	.type	0x8;	.endef
	.def	sprintf;	.val	sprintf;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	sprintf
sprintf:
	.frame	$sp,592,$31		# vars= 536, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	out;	.val	20;	.scl	17;	.type	0x12;	.endef
	.def	f;	.val	4;	.scl	9;	.type	0x12;	.endef
	sw	$5,4($sp)
	sw	$6,8($sp)
	sw	$7,12($sp)
	subu	$sp,$sp,592
	sw	$20,568($sp)
	move	$20,$4
	addu	$2,$sp,600
	sw	$31,584($sp)
	sw	$23,580($sp)
	sw	$22,576($sp)
	sw	$21,572($sp)
	sw	$19,564($sp)
	sw	$18,560($sp)
	sw	$17,556($sp)
	sw	$16,552($sp)
	sw	$5,596($sp)
	sw	$2,544($sp)
	lb	$5,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L3
	move	$18,$0
	.set	macro
	.set	reorder

	li	$19,48			# 0x00000030
	li	$23,45			# 0x0000002d
	li	$22,43			# 0x0000002b
	li	$21,32			# 0x00000020
	li	$2,37			# 0x00000025
$L165:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L155
	addu	$2,$20,$18
	.set	macro
	.set	reorder

	la	$11,D_8012348C
	lw	$8,0($11)
	lw	$9,4($11)
	lw	$10,8($11)
	sw	$8,528($sp)
	sw	$9,532($sp)
	sw	$10,536($sp)
	li	$3,35			# 0x00000023
$L11:
	lw	$6,596($sp)
	#nop
	addu	$7,$6,1
	sw	$7,596($sp)
	lb	$5,1($6)
	#nop
	bne	$5,$23,$L12
	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,528($sp)
	.set	macro
	.set	reorder

$L12:
	bne	$5,$22,$L14
	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0002
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,528($sp)
	.set	macro
	.set	reorder

$L14:
	bne	$5,$21,$L16
	.set	noreorder
	.set	nomacro
	j	$L11
	sb	$5,529($sp)
	.set	macro
	.set	reorder

$L16:
	bne	$5,$3,$L18
	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0004
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,528($sp)
	.set	macro
	.set	reorder

$L18:
	.set	noreorder
	.set	nomacro
	bne	$5,$19,$L10
	li	$2,42			# 0x0000002a
	.set	macro
	.set	reorder

	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0008
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,528($sp)
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L156
	addu	$2,$5,-48
	.set	macro
	.set	reorder

	lw	$2,544($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	.set	noreorder
	.set	nomacro
	bgez	$4,$L24
	sw	$4,532($sp)
	.set	macro
	.set	reorder

	lw	$3,528($sp)
	subu	$2,$0,$4
	sw	$2,532($sp)
	ori	$3,$3,0x0001
	sw	$3,528($sp)
$L24:
	addu	$2,$6,2
	sw	$2,596($sp)
	lb	$5,1($7)
	.set	noreorder
	.set	nomacro
	j	$L153
	li	$2,46			# 0x0000002e
	.set	macro
	.set	reorder

$L28:
	lw	$3,532($sp)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$2,-48
	addu	$2,$2,$5
	sw	$2,532($sp)
	lw	$3,596($sp)
	#nop
	addu	$2,$3,1
	sw	$2,596($sp)
	lb	$5,1($3)
	#nop
	addu	$2,$5,-48
$L156:
	sltu	$2,$2,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L28
	li	$2,46			# 0x0000002e
	.set	macro
	.set	reorder

$L153:
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L30
	li	$2,42			# 0x0000002a
	.set	macro
	.set	reorder

	lw	$4,596($sp)
	#nop
	addu	$6,$4,1
	sw	$6,596($sp)
	lb	$5,1($4)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L157
	addu	$2,$5,-48
	.set	macro
	.set	reorder

	lw	$2,544($sp)
	#nop
	lw	$3,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	addu	$2,$4,2
	sw	$3,536($sp)
	sw	$2,596($sp)
	lb	$5,1($6)
	j	$L32
$L35:
	lw	$3,536($sp)
	#nop
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$2,-48
	addu	$2,$2,$5
	sw	$2,536($sp)
	lw	$3,596($sp)
	#nop
	addu	$2,$3,1
	sw	$2,596($sp)
	lb	$5,1($3)
	#nop
	addu	$2,$5,-48
$L157:
	sltu	$2,$2,10
	bne	$2,$0,$L35
$L32:
	lw	$2,536($sp)
	#nop
	bltz	$2,$L30
	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0010
	sw	$2,528($sp)
$L30:
	lw	$3,528($sp)
	#nop
	andi	$2,$3,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L39
	addu	$17,$sp,528
	.set	macro
	.set	reorder

	li	$2,-9			# 0xfffffff7
	and	$2,$3,$2
	sw	$2,528($sp)
	.def	conversion;	.val	$L39;	.scl	6;	.type	0x0;	.endef
$L39:
	addu	$3,$5,-76
$L154:
	sltu	$2,$3,45
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L133
	sll	$2,$3,2
	.set	macro
	.set	reorder

	lw	$2,$L135($2)
	#nop
	j	$2
	.rdata
	.align	3
$L135:
	.word	$L43
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L97
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L118
	.word	$L45
	.word	$L133
	.word	$L133
	.word	$L133
	.word	$L41
	.word	$L45
	.word	$L133
	.word	$L133
	.word	$L42
	.word	$L133
	.word	$L126
	.word	$L78
	.word	$L96
	.word	$L133
	.word	$L133
	.word	$L119
	.word	$L133
	.word	$L59
	.word	$L133
	.word	$L133
	.word	$L99
	.text
$L41:
	lw	$2,528($sp)
	.set	noreorder
	.set	nomacro
	j	$L151
	ori	$2,$2,0x0020
	.set	macro
	.set	reorder

$L42:
	lw	$2,528($sp)
	.set	noreorder
	.set	nomacro
	j	$L151
	ori	$2,$2,0x0040
	.set	macro
	.set	reorder

$L43:
	lw	$2,528($sp)
	#nop
	ori	$2,$2,0x0080
$L151:
	sw	$2,528($sp)
	lw	$3,596($sp)
	#nop
	addu	$2,$3,1
	sw	$2,596($sp)
	lb	$5,1($3)
	.set	noreorder
	.set	nomacro
	j	$L154
	addu	$3,$5,-76
	.set	macro
	.set	reorder

$L45:
	lw	$2,544($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	lw	$3,528($sp)
	#nop
	srl	$2,$3,5
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L47
	sll	$2,$4,16
	.set	macro
	.set	reorder

	sra	$4,$2,16
$L47:
	.set	noreorder
	.set	nomacro
	bgez	$4,$L51
	srl	$2,$3,1
	.set	macro
	.set	reorder

	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	j	$L58
	sb	$23,529($sp)
	.set	macro
	.set	reorder

$L51:
	andi	$2,$2,0x0001
	beq	$2,$0,$L58
	.set	noreorder
	.set	nomacro
	j	$L58
	sb	$22,529($sp)
	.set	macro
	.set	reorder

$L59:
	lw	$2,544($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	lw	$2,528($sp)
	#nop
	srl	$2,$2,5
	andi	$2,$2,0x0001
	beq	$2,$0,$L61
	andi	$4,$4,0xffff
$L61:
	sb	$0,529($sp)
	.def	printDec;	.val	$L58;	.scl	6;	.type	0x0;	.endef
$L58:
	lw	$3,528($sp)
	#nop
	srl	$2,$3,4
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L65
	srl	$2,$3,3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	beq	$2,$0,$L66
	lw	$3,532($sp)
	lb	$2,529($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L66
	sw	$3,536($sp)
	.set	macro
	.set	reorder

	addu	$2,$3,-1
	sw	$2,536($sp)
$L66:
	lw	$2,536($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L65
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,536($sp)
$L65:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L70
	move	$16,$0
	.set	macro
	.set	reorder

	li	$5,-858993459			# 0xcccccccd
$L71:
	multu	$4,$5
	addu	$17,$17,-1
	addu	$16,$16,1
	mfhi	$8
	#nop
	#nop
	srl	$3,$8,3
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$2,$4,$2
	addu	$2,$2,48
	move	$4,$3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L71
	sb	$2,0($17)
	.set	macro
	.set	reorder

$L70:
	lw	$2,536($sp)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L146
	addu	$17,$17,-1
$L158:
	sb	$19,0($17)
	lw	$2,536($sp)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L158
	addu	$17,$17,-1
	.set	macro
	.set	reorder

	addu	$17,$17,1
$L146:
	lb	$2,529($sp)
	lbu	$3,529($sp)
	beq	$2,$0,$L40
	addu	$17,$17,-1
	sb	$3,0($17)
	.set	noreorder
	.set	nomacro
	j	$L40
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L78:
	lw	$2,544($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	lw	$3,528($sp)
	#nop
	srl	$2,$3,5
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L159
	srl	$2,$3,4
	.set	macro
	.set	reorder

	andi	$4,$4,0xffff
$L159:
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L84
	srl	$2,$3,3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	beq	$2,$0,$L85
	lw	$2,532($sp)
	#nop
	sw	$2,536($sp)
$L85:
	lw	$2,536($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L84
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,536($sp)
$L84:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L88
	move	$16,$0
	.set	macro
	.set	reorder

$L89:
	addu	$17,$17,-1
	andi	$2,$4,0x0007
	addu	$2,$2,48
	sb	$2,0($17)
	srl	$4,$4,3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L89
	addu	$16,$16,1
	.set	macro
	.set	reorder

$L88:
	lw	$2,528($sp)
	#nop
	srl	$2,$2,2
	andi	$2,$2,0x0001
	beq	$2,$0,$L91
	beq	$16,$0,$L91
	lb	$2,0($17)
	#nop
	beq	$2,$19,$L91
	addu	$17,$17,-1
	sb	$19,0($17)
	addu	$16,$16,1
$L91:
	lw	$2,536($sp)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L40
	addu	$17,$17,-1
$L160:
	sb	$19,0($17)
	lw	$2,536($sp)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L160
	addu	$17,$17,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L40
	addu	$17,$17,1
	.set	macro
	.set	reorder

$L96:
	lw	$3,528($sp)
	li	$2,8			# 0x00000008
	sw	$2,536($sp)
	ori	$3,$3,0x0050
	sw	$3,528($sp)
$L97:
	.set	noreorder
	j	$L98
	la	$7,$LC0
	.set	reorder
$L99:
	la	$7,$LC1
	.def	printHex;	.val	$L98;	.scl	6;	.type	0x0;	.endef
$L98:
	lw	$2,544($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	lw	$3,528($sp)
	#nop
	srl	$2,$3,5
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L161
	srl	$2,$3,4
	.set	macro
	.set	reorder

	andi	$4,$4,0xffff
$L161:
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L105
	srl	$2,$3,3
	.set	macro
	.set	reorder

	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L106
	srl	$2,$3,2
	.set	macro
	.set	reorder

	lw	$6,532($sp)
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L106
	sw	$6,536($sp)
	.set	macro
	.set	reorder

	addu	$2,$6,-2
	sw	$2,536($sp)
$L106:
	lw	$2,536($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L105
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sw	$2,536($sp)
$L105:
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L110
	move	$16,$0
	.set	macro
	.set	reorder

$L111:
	addu	$17,$17,-1
	andi	$2,$4,0x000f
	srl	$4,$4,4
	addu	$2,$7,$2
	lbu	$2,0($2)
	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L111
	sb	$2,0($17)
	.set	macro
	.set	reorder

$L110:
	lw	$2,536($sp)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L147
	addu	$17,$17,-1
$L162:
	sb	$19,0($17)
	lw	$2,536($sp)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L162
	addu	$17,$17,-1
	.set	macro
	.set	reorder

	addu	$17,$17,1
$L147:
	lw	$2,528($sp)
	#nop
	srl	$2,$2,2
	andi	$2,$2,0x0001
	beq	$2,$0,$L40
	addu	$17,$17,-1
	sb	$5,0($17)
	addu	$17,$17,-1
	addu	$16,$16,2
	.set	noreorder
	.set	nomacro
	j	$L40
	sb	$19,0($17)
	.set	macro
	.set	reorder

$L118:
	addu	$17,$17,-1
	lw	$2,544($sp)
	li	$16,1			# 0x00000001
	lbu	$3,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	.set	noreorder
	.set	nomacro
	j	$L40
	sb	$3,0($17)
	.set	macro
	.set	reorder

$L119:
	lw	$2,544($sp)
	lw	$3,528($sp)
	lw	$17,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	srl	$2,$3,2
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L120
	srl	$2,$3,4
	.set	macro
	.set	reorder

	lbu	$16,0($17)
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	addu	$17,$17,1
	.set	macro
	.set	reorder

	lw	$3,536($sp)
	#nop
	slt	$2,$3,$16
	beq	$2,$0,$L40
	.set	noreorder
	.set	nomacro
	j	$L40
	move	$16,$3
	.set	macro
	.set	reorder

$L120:
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L123
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L40
	move	$16,$2
	.set	macro
	.set	reorder

$L123:
	lw	$6,536($sp)
	.set	noreorder
	.set	nomacro
	jal	memchr
	move	$5,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L40
	subu	$16,$2,$17
	.set	macro
	.set	reorder

	lw	$16,536($sp)
	j	$L40
$L126:
	lw	$2,544($sp)
	lw	$3,528($sp)
	lw	$17,0($2)
	addu	$2,$2,4
	sw	$2,544($sp)
	srl	$2,$3,5
	andi	$2,$2,0x0001
	beq	$2,$0,$L127
	.set	noreorder
	.set	nomacro
	j	$L6
	sh	$18,0($17)
	.set	macro
	.set	reorder

$L127:
	.set	noreorder
	.set	nomacro
	j	$L6
	sw	$18,0($17)
	.set	macro
	.set	reorder

$L133:
	li	$2,37			# 0x00000025
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L3
	addu	$2,$20,$18
	.set	macro
	.set	reorder

$L155:
	sb	$5,0($2)
	.set	noreorder
	.set	nomacro
	j	$L6
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L40:
	lw	$2,532($sp)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L163
	addu	$4,$20,$18
	.set	macro
	.set	reorder

	lw	$2,528($sp)
	#nop
	andi	$2,$2,0x0001
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L164
	move	$5,$17
	.set	macro
	.set	reorder

$L139:
	addu	$2,$20,$18
	sb	$21,0($2)
	lw	$2,532($sp)
	#nop
	addu	$2,$2,-1
	sw	$2,532($sp)
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L139
	addu	$18,$18,1
	.set	macro
	.set	reorder

	addu	$4,$20,$18
$L163:
	move	$5,$17
$L164:
	.set	noreorder
	.set	nomacro
	jal	memmove
	move	$6,$16
	.set	macro
	.set	reorder

	lw	$2,532($sp)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	addu	$18,$18,$16
	.set	macro
	.set	reorder

$L143:
	addu	$2,$20,$18
	sb	$21,0($2)
	lw	$2,532($sp)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L143
	addu	$18,$18,1
	.set	macro
	.set	reorder

$L6:
	lw	$3,596($sp)
	#nop
	addu	$2,$3,1
	sw	$2,596($sp)
	lb	$5,1($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L165
	li	$2,37			# 0x00000025
	.set	macro
	.set	reorder

	.def	end;	.val	$L3;	.scl	6;	.type	0x0;	.endef
$L3:
	addu	$2,$20,$18
	sb	$0,0($2)
	move	$2,$18
	lw	$31,584($sp)
	lw	$23,580($sp)
	lw	$22,576($sp)
	lw	$21,572($sp)
	lw	$20,568($sp)
	lw	$19,564($sp)
	lw	$18,560($sp)
	lw	$17,556($sp)
	lw	$16,552($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,592
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	sprintf
