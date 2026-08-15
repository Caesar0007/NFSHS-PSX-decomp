	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libpad\\PADENTRY.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	PadStartCom
	.align	2
	.globl	PadStopCom
	.align	2
	.globl	PadGetState
	.align	2
	.globl	PadInfoMode
	.align	2
	.globl	PadInfoAct
	.align	2
	.globl	PadSetActAlign
	.align	2
	.globl	PadSetMainMode
	.align	2
	.globl	PadSetAct

	.extern	_padFuncPort2Info, 4

	.text
	.def	_PadDev;	.scl	10;	.type	0x8;	.size	236;	.endef
	.def	mode_tbl;	.val	0;	.scl	8;	.type	0x1d;	.endef
	.def	act_tbl;	.val	4;	.scl	8;	.type	0x1c;	.endef
	.def	_pad08;	.val	8;	.scl	8;	.dim	8;	.size	8;	.type	0x32;	.endef
	.def	self;	.val	16;	.scl	8;	.tag	_PadDev;	.size	236;	.type	0x18;	.endef
	.def	_pad14;	.val	20;	.scl	8;	.dim	28;	.size	28;	.type	0x32;	.endef
	.def	flag_ptr;	.val	48;	.scl	8;	.type	0x12;	.endef
	.def	status;	.val	52;	.scl	8;	.type	0xe;	.endef
	.def	connected;	.val	56;	.scl	8;	.type	0xc;	.endef
	.def	_pad39;	.val	57;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	_pad3b;	.val	59;	.scl	8;	.dim	14;	.size	14;	.type	0x32;	.endef
	.def	state;	.val	73;	.scl	8;	.type	0xc;	.endef
	.def	_pad4a;	.val	74;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	term100;	.val	76;	.scl	8;	.type	0x4;	.endef
	.def	_pad50;	.val	80;	.scl	8;	.dim	147;	.size	147;	.type	0x32;	.endef
	.def	nmode;	.val	227;	.scl	8;	.type	0xc;	.endef
	.def	mode3;	.val	228;	.scl	8;	.type	0xc;	.endef
	.def	_pade5;	.val	229;	.scl	8;	.dim	1;	.size	1;	.type	0x32;	.endef
	.def	modeword;	.val	230;	.scl	8;	.type	0xd;	.endef
	.def	mode1;	.val	232;	.scl	8;	.type	0xc;	.endef
	.def	nact;	.val	233;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	236;	.scl	102;	.tag	_PadDev;	.size	236;	.endef
	.def	_PadDev;	.scl	13;	.tag	_PadDev;	.size	236;	.type	0x8;	.endef
	.def	PadStartCom;	.val	PadStartCom;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	PadStartCom
PadStartCom:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_padStartCom
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM1:
	.end	PadStartCom
	.def	PadStopCom;	.val	PadStopCom;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	PadStopCom
PadStopCom:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	_padStopCom
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM2:
	.end	PadStopCom
	.def	PadGetState;	.val	PadGetState;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	PadGetState
PadGetState:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	$31,$2
	move	$4,$2
	lw	$2,52($4)
	li	$3,-65536			# 0xffff0000
	and	$2,$2,$3
	bne	$2,$0,$L5
	lw	$2,16($4)
	#nop
	beq	$4,$2,$L6
	lbu	$2,56($4)
	#nop
	bne	$2,$0,$L5
$L6:
	lw	$2,48($4)
	#nop
	lbu	$2,0($2)
	#nop
	beq	$2,$0,$L4
$L5:
	lbu	$3,73($4)
	li	$2,3			# 0x00000003
	beq	$3,$2,$L9
	slt	$2,$3,4
	beq	$2,$0,$L13
	li	$2,2			# 0x00000002
	beq	$3,$2,$L8
	j	$L4
$L13:
	li	$2,6			# 0x00000006
	beq	$3,$2,$L10
	j	$L4
$L8:
$L9:
	li	$2,1			# 0x00000001
	j	$L14
$L10:
	li	$2,4			# 0x00000004
	j	$L14
$L4:
	lbu	$2,73($4)
$L14:
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM3:
	.end	PadGetState
	.def	PadInfoMode;	.val	PadInfoMode;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	PadInfoMode
PadInfoMode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	term;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	offs;	.val	17;	.scl	17;	.type	0x4;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	jal	$31,$2
	move	$3,$2
	li	$2,3			# 0x00000003
	beq	$16,$2,$L19
	slt	$2,$16,4
	beq	$2,$0,$L26
	li	$2,1			# 0x00000001
	beq	$16,$2,$L17
	li	$2,2			# 0x00000002
	beq	$16,$2,$L18
	j	$L16
$L26:
	li	$2,4			# 0x00000004
	beq	$16,$2,$L20
	li	$2,100			# 0x00000064
	beq	$16,$2,$L23
	j	$L16
$L17:
	lbu	$2,232($3)
	j	$L27
$L18:
	lhu	$2,230($3)
	j	$L27
$L19:
	lbu	$2,228($3)
	j	$L27
$L20:
	bgez	$17,$L21
	lbu	$2,227($3)
	j	$L27
$L21:
	lbu	$2,227($3)
	#nop
	slt	$2,$17,$2
	beq	$2,$0,$L16
	lw	$3,0($3)
	sll	$2,$17,1
	addu	$2,$2,$3
	lhu	$2,0($2)
	j	$L27
$L23:
	lw	$2,76($3)
	j	$L27
$L16:
	move	$2,$0
$L27:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,32
	j	$31

	.loc	1 0
LM4:
	.end	PadInfoMode
	.def	PadInfoAct;	.val	PadInfoAct;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	PadInfoAct
PadInfoAct:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	actno;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	term;	.val	17;	.scl	17;	.type	0x4;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	jal	$31,$2
	move	$3,$2
	bgez	$16,$L29
	lbu	$2,233($3)
	j	$L39
$L29:
	lbu	$2,233($3)
	#nop
	slt	$2,$16,$2
	beq	$2,$0,$L30
	sll	$2,$16,2
	lw	$3,4($3)
	addu	$2,$2,$16
	addu	$6,$17,-1
	addu	$3,$3,$2
	sltu	$2,$6,5
	beq	$2,$0,$L30
	sll	$2,$6,2
	lw	$2,$L37($2)
	#nop
	j	$2
	.rdata
	.align	3
$L37:
	.word	$L32
	.word	$L33
	.word	$L34
	.word	$L35
	.word	$L36
	.text
$L32:
	lbu	$2,0($3)
	j	$L39
$L33:
	lbu	$2,1($3)
	j	$L39
$L34:
	lbu	$2,2($3)
	j	$L39
$L35:
	lbu	$2,3($3)
	j	$L39
$L36:
	lbu	$2,4($3)
	j	$L39
$L30:
	move	$2,$0
$L39:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,32
	j	$31

	.loc	1 0
LM5:
	.end	PadInfoAct
	.def	PadSetActAlign;	.val	PadSetActAlign;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	PadSetActAlign
PadSetActAlign:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	data;	.val	16;	.scl	17;	.type	0x12;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,20($sp)
	jal	$31,$2
	move	$4,$2
	move	$5,$16
	jal	_padSetActAlign
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,24
	j	$31

	.loc	1 0
LM6:
	.end	PadSetActAlign
	.def	PadSetMainMode;	.val	PadSetMainMode;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	PadSetMainMode
PadSetMainMode:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	offs;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	lock;	.val	17;	.scl	17;	.type	0x4;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	jal	$31,$2
	move	$4,$2
	andi	$5,$16,0x00ff
	andi	$6,$17,0x00ff
	jal	_padSetMainMode
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,32
	j	$31

	.loc	1 0
LM7:
	.end	PadSetMainMode
	.def	PadSetAct;	.val	PadSetAct;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	PadSetAct
PadSetAct:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	port;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	data;	.val	16;	.scl	17;	.type	0x1c;	.endef
	.def	len;	.val	17;	.scl	17;	.type	0x4;	.endef
	lw	$2,_padFuncPort2Info
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$17,20($sp)
	move	$17,$6
	sw	$31,24($sp)
	jal	$31,$2
	move	$4,$2
	move	$5,$16
	move	$6,$17
	jal	_padSetAct
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	addu	$sp,$sp,32
	j	$31

	.loc	1 0
LM8:
	.end	PadSetAct
