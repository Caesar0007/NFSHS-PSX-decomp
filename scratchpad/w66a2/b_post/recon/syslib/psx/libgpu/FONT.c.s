	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\FONT.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	FntFlush
	.align	2
	.globl	FntPrint

	.extern	D_801369E4, 4
	.extern	D_80135FDC, 4
	.extern	_fnt, 384
	.extern	D_80135FD8, 4

	.text
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	u_short;	.scl	13;	.type	0xd;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon/stdarg.h"
	.def	va_list;	.scl	13;	.type	0x11;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\FONT.c"
	.file	1 "C:\\Temp\\nfs4-decomp\\recon/stddef.h"
	.def	size_t;	.scl	13;	.type	0xe;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\FONT.c"
	.def	.0fake;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	tag;	.val	0;	.scl	8;	.type	0xf;	.endef
	.def	r0;	.val	4;	.scl	8;	.type	0xc;	.endef
	.def	g0;	.val	5;	.scl	8;	.type	0xc;	.endef
	.def	b0;	.val	6;	.scl	8;	.type	0xc;	.endef
	.def	code;	.val	7;	.scl	8;	.type	0xc;	.endef
	.def	x0;	.val	8;	.scl	8;	.type	0x3;	.endef
	.def	y0;	.val	10;	.scl	8;	.type	0x3;	.endef
	.def	w;	.val	12;	.scl	8;	.type	0x3;	.endef
	.def	h;	.val	14;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	.0fake;	.size	16;	.endef
	.def	TILE;	.scl	13;	.tag	.0fake;	.size	16;	.type	0x8;	.endef
	.def	.1fake;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	tag;	.val	0;	.scl	8;	.type	0xf;	.endef
	.def	code;	.val	4;	.scl	8;	.dim	2;	.size	8;	.type	0x3f;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	.1fake;	.size	12;	.endef
	.def	DR_MODE;	.scl	13;	.tag	.1fake;	.size	12;	.type	0x8;	.endef
	.def	.2fake;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	tag;	.val	0;	.scl	8;	.type	0xf;	.endef
	.def	r0;	.val	4;	.scl	8;	.type	0xc;	.endef
	.def	g0;	.val	5;	.scl	8;	.type	0xc;	.endef
	.def	b0;	.val	6;	.scl	8;	.type	0xc;	.endef
	.def	code;	.val	7;	.scl	8;	.type	0xc;	.endef
	.def	x0;	.val	8;	.scl	8;	.type	0x3;	.endef
	.def	y0;	.val	10;	.scl	8;	.type	0x3;	.endef
	.def	u0;	.val	12;	.scl	8;	.type	0xc;	.endef
	.def	v0;	.val	13;	.scl	8;	.type	0xc;	.endef
	.def	clut;	.val	14;	.scl	8;	.type	0xd;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	.2fake;	.size	16;	.endef
	.def	SPRT_8;	.scl	13;	.tag	.2fake;	.size	16;	.type	0x8;	.endef
	.def	FntStream;	.scl	10;	.type	0x8;	.size	48;	.endef
	.def	tile;	.val	0;	.scl	8;	.tag	.0fake;	.size	16;	.type	0x8;	.endef
	.def	draw_mode;	.val	16;	.scl	8;	.tag	.1fake;	.size	12;	.type	0x8;	.endef
	.def	maxchars;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	primbuf;	.val	32;	.scl	8;	.tag	.2fake;	.size	16;	.type	0x18;	.endef
	.def	textbuf;	.val	36;	.scl	8;	.type	0x12;	.endef
	.def	textlen;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	autoupd;	.val	44;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	48;	.scl	102;	.tag	FntStream;	.size	48;	.endef
	.def	FntStream;	.scl	13;	.tag	FntStream;	.size	48;	.type	0x8;	.endef
	.def	FntFlush;	.val	FntFlush;	.scl	2;	.type	0x6f;	.endef
	.text
	.ent	FntFlush
FntFlush:
	.frame	$sp,80,$31		# vars= 24, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	id;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,80
	li	$6,128			# 0x00000080
	sw	$6,28($sp)
	sw	$6,32($sp)
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sw	$0,20($sp)
	.set	noreorder
	.set	nomacro
	bltz	$4,$L3
	sw	$6,36($sp)
	.set	macro
	.set	reorder

	lw	$2,D_80135FD8
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	sll	$2,$4,1
	.set	macro
	.set	reorder

$L3:
	lw	$4,D_80135FDC
	#nop
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,4
	lw	$2,_fnt+36($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sll	$2,$4,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L38
	move	$2,$0
	.set	macro
	.set	reorder

$L2:
$L42:
	addu	$2,$2,$4
	sll	$2,$2,4
	la	$3,_fnt
	addu	$19,$2,$3
	addu	$6,$19,16
	move	$4,$6
	sw	$6,16($sp)
	lw	$16,36($19)
	lw	$fp,28($19)
	lh	$17,8($19)
	lh	$21,10($19)
	lh	$2,12($19)
	lh	$3,14($19)
	#nop
	addu	$3,$21,$3
	sw	$3,24($sp)
	lw	$18,32($19)
	lw	$22,44($19)
	.set	noreorder
	.set	nomacro
	jal	TermPrim
	addu	$23,$17,$2
	.set	macro
	.set	reorder

	j	$L39
$L7:
	.set	noreorder
	.set	nomacro
	beq	$fp,$0,$L6
	sll	$2,$3,24
	.set	macro
	.set	reorder

	sra	$3,$2,24
	li	$2,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L9
	move	$20,$0
	.set	macro
	.set	reorder

	slt	$2,$3,33
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	li	$2,9			# 0x00000009
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L13
	li	$2,10			# 0x0000000a
	.set	macro
	.set	reorder

	beq	$3,$2,$L40
	j	$L18
$L10:
	li	$2,126			# 0x0000007e
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L18
	li	$2,99			# 0x00000063
	.set	macro
	.set	reorder

	addu	$16,$16,1
	lb	$3,0($16)
	#nop
	bne	$3,$2,$L29
	addu	$16,$16,1
	lb	$2,0($16)
	addu	$16,$16,1
	lb	$3,0($16)
	addu	$16,$16,1
	addu	$2,$2,-48
	sll	$2,$2,4
	addu	$3,$3,-48
	sw	$2,28($sp)
	lb	$2,0($16)
	sll	$3,$3,4
	sw	$3,32($sp)
	addu	$2,$2,-48
	sll	$2,$2,4
	.set	noreorder
	.set	nomacro
	j	$L29
	sw	$2,36($sp)
	.set	macro
	.set	reorder

	.def	do_tab;	.val	$L13;	.scl	6;	.type	0x0;	.endef
$L13:
	.set	noreorder
	.set	nomacro
	j	$L41
	addu	$17,$17,32
	.set	macro
	.set	reorder

	.def	do_char;	.val	$L18;	.scl	6;	.type	0x0;	.endef
$L18:
	lbu	$3,0($16)
	#nop
	addu	$2,$3,-97
	sltu	$2,$2,26
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	sll	$2,$3,24
	.set	macro
	.set	reorder

	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	j	$L25
	addu	$3,$2,-64
	.set	macro
	.set	reorder

$L24:
	sra	$2,$2,24
	addu	$3,$2,-32
$L25:
	.set	noreorder
	.set	nomacro
	bgez	$3,$L26
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$2,$3,15
$L26:
	sra	$4,$2,4
	sll	$2,$4,4
	subu	$2,$3,$2
	sll	$2,$2,3
	sb	$2,12($18)
	sll	$2,$4,3
	sb	$2,13($18)
	sh	$17,8($18)
	sh	$21,10($18)
	lbu	$6,28($sp)
	move	$5,$18
	sb	$6,4($18)
	lbu	$6,32($sp)
	#nop
	sb	$6,5($18)
	lbu	$6,36($sp)
	#nop
	sb	$6,6($18)
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AddPrim
	addu	$18,$18,16
	.set	macro
	.set	reorder

$L9:
	addu	$17,$17,8
$L41:
	slt	$2,$17,$23
	bne	$2,$0,$L29
	bne	$22,$0,$L29
$L40:
	li	$20,1			# 0x00000001
$L29:
	beq	$20,$0,$L31
	lw	$6,20($sp)
	#nop
	slt	$2,$6,$17
	beq	$2,$0,$L32
	sw	$17,20($sp)
$L32:
	addu	$21,$21,8
	lw	$6,24($sp)
	lh	$17,8($19)
	slt	$2,$21,$6
	beq	$2,$0,$L6
$L31:
	addu	$16,$16,1
	addu	$fp,$fp,-1
$L39:
	lb	$2,0($16)
	lbu	$3,0($16)
	bne	$2,$0,$L7
$L6:
	lbu	$2,7($19)
	#nop
	beq	$2,$0,$L36
	lw	$4,16($sp)
	.set	noreorder
	.set	nomacro
	jal	AddPrim
	move	$5,$19
	.set	macro
	.set	reorder

	beq	$22,$0,$L36
	lhu	$2,8($19)
	lw	$6,20($sp)
	lhu	$3,10($19)
	subu	$2,$6,$2
	addu	$3,$3,-8
	subu	$3,$21,$3
	sh	$2,12($19)
	sh	$3,14($19)
$L36:
	lw	$4,16($sp)
	jal	DrawOTag
	lw	$3,36($19)
	lw	$2,16($sp)
	sw	$0,40($19)
	sb	$0,0($3)
$L38:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,80
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	FntFlush
	.def	FntPrint;	.val	FntPrint;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	FntPrint
FntPrint:
	.frame	$sp,568,$31		# vars= 520, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	id;	.val	0;	.scl	9;	.type	0x12;	.endef
	sw	$4,0($sp)
	sw	$5,4($sp)
	sw	$6,8($sp)
	sw	$7,12($sp)
	subu	$sp,$sp,568
	addu	$2,$sp,572
	sw	$31,560($sp)
	sw	$21,556($sp)
	sw	$20,552($sp)
	sw	$19,548($sp)
	sw	$18,544($sp)
	sw	$17,540($sp)
	sw	$16,536($sp)
	sw	$4,568($sp)
	.set	noreorder
	.set	nomacro
	bltz	$4,$L45
	sw	$2,528($sp)
	.set	macro
	.set	reorder

	lw	$2,D_80135FD8
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L44
	addu	$2,$sp,576
	.set	macro
	.set	reorder

$L45:
	lw	$2,D_80135FDC
	#nop
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,4
	lw	$3,_fnt+36($3)
	move	$19,$4
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L47
	sw	$2,568($sp)
	.set	macro
	.set	reorder

$L116:
	.set	noreorder
	.set	nomacro
	j	$L108
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L44:
	lw	$19,572($sp)
	sw	$2,528($sp)
$L47:
	lw	$3,568($sp)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,4
	la	$3,_fnt
	addu	$17,$2,$3
	lw	$3,40($17)
	lw	$2,28($17)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L116
	lb	$4,0($19)
	#nop
	beq	$4,$0,$L50
 #APP
 #NO_APP
	li	$20,37			# 0x00000025
	li	$21,-858993459			# 0xcccccccd
$L54:
	bne	$4,$20,$L113
	addu	$19,$19,1
	lb	$4,0($19)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$20,$L57
	move	$18,$0
	.set	macro
	.set	reorder

$L113:
	lw	$2,40($17)
	lw	$3,36($17)
	#nop
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,28($17)
	addu	$2,$2,1
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L53
	sw	$2,40($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L108
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L57:
	xori	$2,$4,0x0030
	sltu	$2,$2,1
	.set	noreorder
	.set	nomacro
	j	$L115
	move	$6,$2
	.set	macro
	.set	reorder

$L61:
	addu	$2,$2,$18
	sll	$2,$2,1
	addu	$2,$2,-48
	addu	$18,$2,$4
	addu	$19,$19,1
	lb	$4,0($19)
$L115:
	addu	$2,$4,-48
	sltu	$2,$2,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L61
	sll	$2,$18,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgtz	$18,$L118
	addu	$3,$4,-88
	.set	macro
	.set	reorder

	li	$18,1			# 0x00000001
$L118:
	sltu	$2,$3,33
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L64
	addu	$16,$sp,528
	.set	macro
	.set	reorder

	sll	$2,$3,2
	lw	$2,$L94($2)
	#nop
	j	$2
	.rdata
	.align	3
$L94:
	.word	$L78
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L92
	.word	$L65
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L93
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L64
	.word	$L78
	.text
$L65:
	lw	$2,528($sp)
	#nop
	lw	$4,0($2)
	addu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bgez	$4,$L66
	sw	$2,528($sp)
	.set	macro
	.set	reorder

	subu	$4,$0,$4
	.set	noreorder
	.set	nomacro
	j	$L67
	li	$6,45			# 0x0000002d
	.set	macro
	.set	reorder

$L66:
	move	$6,$0
$L67:
	move	$5,$0
$L71:
	multu	$4,$21
	addu	$16,$16,-1
	addu	$5,$5,1
	mfhi	$7
	#nop
	#nop
	srl	$3,$7,3
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,1
	subu	$2,$4,$2
	addu	$2,$2,48
	sb	$2,0($16)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L71
	move	$4,$3
	.set	macro
	.set	reorder

	bne	$4,$0,$L71
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L117
	slt	$2,$5,$18
	.set	macro
	.set	reorder

	addu	$16,$16,-1
	sb	$6,0($16)
	.set	noreorder
	.set	nomacro
	j	$L64
	addu	$5,$5,1
	.set	macro
	.set	reorder

$L78:
	lw	$2,528($sp)
	move	$5,$0
	lw	$4,0($2)
	addu	$2,$2,4
	sw	$2,528($sp)
$L82:
	addu	$16,$16,-1
$L119:
	andi	$2,$4,0x000f
	lw	$3,D_801369E4
	srl	$4,$4,4
	addu	$3,$3,$2
	lbu	$2,0($3)
	addu	$5,$5,1
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L82
	sb	$2,0($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L119
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	addu	$16,$16,1
	move	$2,$6
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L64
	slt	$2,$5,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L109
	li	$3,48			# 0x00000030
	.set	macro
	.set	reorder

$L90:
	addu	$16,$16,-1
	addu	$5,$5,1
	slt	$2,$5,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L90
	sb	$3,0($16)
	.set	macro
	.set	reorder

	j	$L117
$L92:
	addu	$16,$16,-1
	lw	$2,528($sp)
	li	$5,1			# 0x00000001
	lbu	$3,0($2)
	addu	$2,$2,4
	sb	$3,0($16)
	.set	noreorder
	.set	nomacro
	j	$L64
	sw	$2,528($sp)
	.set	macro
	.set	reorder

$L93:
	lw	$2,528($sp)
	#nop
	lw	$16,0($2)
	addu	$2,$2,4
	sw	$2,528($sp)
	.set	noreorder
	.set	nomacro
	jal	strlen
	move	$4,$16
	.set	macro
	.set	reorder

	move	$5,$2
$L64:
	slt	$2,$5,$18
$L117:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L109
	li	$4,32			# 0x00000020
	.set	macro
	.set	reorder

$L98:
	lw	$2,40($17)
	lw	$3,36($17)
	#nop
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,28($17)
	addu	$2,$2,1
	slt	$3,$3,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L116
	sw	$2,40($17)
	.set	macro
	.set	reorder

	addu	$18,$18,-1
	slt	$2,$5,$18
	bne	$2,$0,$L98
$L109:
 #APP
 #NO_APP
	addu	$5,$5,-1
	li	$2,-1			# 0xffffffff
	beq	$5,$2,$L53
	li	$6,-1			# 0xffffffff
$L102:
	lw	$3,40($17)
	lw	$2,36($17)
	lbu	$4,0($16)
	addu	$16,$16,1
	addu	$2,$2,$3
	sb	$4,0($2)
	lw	$2,28($17)
	addu	$3,$3,1
	slt	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L116
	sw	$3,40($17)
	.set	macro
	.set	reorder

	addu	$5,$5,-1
	bne	$5,$6,$L102
$L53:
	addu	$19,$19,1
	lb	$4,0($19)
	#nop
	bne	$4,$0,$L54
	.def	fnt_done;	.val	$L50;	.scl	6;	.type	0x0;	.endef
$L50:
	lw	$2,36($17)
	lw	$3,40($17)
	#nop
	addu	$2,$2,$3
	sb	$0,0($2)
	lw	$2,40($17)
$L108:
	lw	$31,560($sp)
	lw	$21,556($sp)
	lw	$20,552($sp)
	lw	$19,548($sp)
	lw	$18,544($sp)
	lw	$17,540($sp)
	lw	$16,536($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,568
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	FntPrint
