	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\EXT.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetDefDrawEnv
	.align	2
	.globl	SetDefDispEnv

	.text
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	DRAWENV;	.scl	10;	.type	0x8;	.size	28;	.endef
	.def	clipx;	.val	0;	.scl	8;	.type	0x3;	.endef
	.def	clipy;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	clipw;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	cliph;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	ofsx;	.val	8;	.scl	8;	.type	0x3;	.endef
	.def	ofsy;	.val	10;	.scl	8;	.type	0x3;	.endef
	.def	twx;	.val	12;	.scl	8;	.type	0x3;	.endef
	.def	twy;	.val	14;	.scl	8;	.type	0x3;	.endef
	.def	tww;	.val	16;	.scl	8;	.type	0x3;	.endef
	.def	twh;	.val	18;	.scl	8;	.type	0x3;	.endef
	.def	tpage;	.val	20;	.scl	8;	.type	0x3;	.endef
	.def	dtd;	.val	22;	.scl	8;	.type	0xc;	.endef
	.def	dfe;	.val	23;	.scl	8;	.type	0xc;	.endef
	.def	isbg;	.val	24;	.scl	8;	.type	0xc;	.endef
	.def	bg0;	.val	25;	.scl	8;	.type	0xc;	.endef
	.def	bg1;	.val	26;	.scl	8;	.type	0xc;	.endef
	.def	bg2;	.val	27;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	28;	.scl	102;	.tag	DRAWENV;	.size	28;	.endef
	.def	DRAWENV;	.scl	13;	.tag	DRAWENV;	.size	28;	.type	0x8;	.endef
	.def	SetDefDrawEnv;	.val	SetDefDrawEnv;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	SetDefDrawEnv
SetDefDrawEnv:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	env;	.val	17;	.scl	17;	.type	0x11;	.endef
	.def	x;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	w;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	h;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	h;	.val	18;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	lw	$18,56($sp)
	sw	$17,20($sp)
	move	$17,$4
	sw	$19,28($sp)
	move	$19,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$16,16($sp)
	sw	$31,36($sp)
	.set	noreorder
	.set	nomacro
	jal	GetVideoMode
	move	$16,$7
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
	sh	$19,0($17)
	sh	$20,2($17)
	sh	$16,4($17)
	sh	$0,12($17)
	sh	$0,14($17)
	sh	$0,16($17)
	sh	$0,18($17)
	sb	$0,25($17)
	sb	$0,26($17)
	sb	$0,27($17)
	sb	$3,22($17)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	sh	$18,6($17)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L4
	slt	$2,$18,289
	.set	macro
	.set	reorder

$L2:
	slt	$2,$18,257
$L4:
	sb	$2,23($17)
	move	$2,$17
	li	$3,10			# 0x0000000a
	sh	$19,8($2)
	sh	$20,10($2)
	sh	$3,20($2)
	sb	$0,24($2)
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
LM1:
	.end	SetDefDrawEnv
	.def	SetDefDispEnv;	.val	SetDefDispEnv;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	SetDefDispEnv
SetDefDispEnv:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	env;	.val	2;	.scl	17;	.type	0x11;	.endef
	.def	x;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	w;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	h;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	h;	.val	3;	.scl	4;	.type	0x4;	.endef
	lw	$3,16($sp)
	move	$2,$4
	sh	$5,0($2)
	sh	$6,2($2)
	sh	$7,4($2)
	sh	$0,8($2)
	sh	$0,10($2)
	sh	$0,12($2)
	sh	$0,14($2)
	sb	$0,17($2)
	sb	$0,16($2)
	sb	$0,19($2)
	sb	$0,18($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sh	$3,6($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	SetDefDispEnv
