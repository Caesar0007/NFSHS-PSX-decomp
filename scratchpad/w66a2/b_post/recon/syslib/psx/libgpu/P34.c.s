	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgpu\\P34.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SetDrawMove

	.text
	.def	u_char;	.scl	13;	.type	0xc;	.endef
	.def	u_long;	.scl	13;	.type	0xf;	.endef
	.def	.0fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	addr;	.val	0;	.scl	18;	.type	0xe;	.size	24;	.endef
	.def	len;	.val	24;	.scl	18;	.type	0xe;	.size	8;	.endef
	.def	r0;	.val	4;	.scl	8;	.type	0xc;	.endef
	.def	g0;	.val	5;	.scl	8;	.type	0xc;	.endef
	.def	b0;	.val	6;	.scl	8;	.type	0xc;	.endef
	.def	code;	.val	7;	.scl	8;	.type	0xc;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.0fake;	.size	8;	.endef
	.def	P_TAG;	.scl	13;	.tag	.0fake;	.size	8;	.type	0x8;	.endef
	.def	.1fake;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	x;	.val	0;	.scl	8;	.type	0x3;	.endef
	.def	y;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	w;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	h;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	.1fake;	.size	8;	.endef
	.def	RECT;	.scl	13;	.tag	.1fake;	.size	8;	.type	0x8;	.endef
	.def	.2fake;	.scl	10;	.type	0x8;	.size	24;	.endef
	.def	tag;	.val	0;	.scl	8;	.type	0xf;	.endef
	.def	code;	.val	4;	.scl	8;	.dim	5;	.size	20;	.type	0x3f;	.endef
	.def	.eos;	.val	24;	.scl	102;	.tag	.2fake;	.size	24;	.endef
	.def	DR_MOVE;	.scl	13;	.tag	.2fake;	.size	24;	.type	0x8;	.endef
	.def	SetDrawMove;	.val	SetDrawMove;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SetDrawMove
SetDrawMove:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	p;	.val	8;	.scl	17;	.tag	.2fake;	.size	24;	.type	0x18;	.endef
	.def	rect;	.val	5;	.scl	17;	.tag	.1fake;	.size	8;	.type	0x18;	.endef
	.def	x;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	y;	.val	7;	.scl	17;	.type	0x4;	.endef
	move	$8,$4
	lh	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$4,5			# 0x00000005
	.set	macro
	.set	reorder

	lh	$2,6($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	li	$2,16777216			# 0x01000000
	.set	macro
	.set	reorder

$L3:
	move	$4,$0
	li	$2,16777216			# 0x01000000
$L4:
	sw	$2,4($8)
	li	$2,-2147483648			# 0x80000000
	sw	$2,8($8)
	sll	$2,$7,16
	andi	$3,$6,0xffff
	sb	$4,3($8)
	lw	$4,0($5)
	or	$2,$2,$3
	sw	$2,16($8)
	sw	$4,12($8)
	lw	$2,4($5)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$2,20($8)
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SetDrawMove
