	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\svol.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDunsafevol
	.align	2
	.globl	SNDvol

	.text
	.file	1 "C:/Temp/nfs4-decomp/recon/lib/snd.h"
	.def	SndVoice;	.scl	10;	.type	0x8;	.size	100;	.endef
	.def	handle;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	f04;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	_g08;	.val	8;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	bank;	.val	10;	.scl	8;	.type	0x2;	.endef
	.def	f0B;	.val	11;	.scl	8;	.type	0x2;	.endef
	.def	f0C;	.val	12;	.scl	8;	.type	0xc;	.endef
	.def	_g0D;	.val	13;	.scl	8;	.dim	3;	.size	3;	.type	0x32;	.endef
	.def	f10;	.val	16;	.scl	8;	.type	0x4;	.endef
	.def	f14;	.val	20;	.scl	8;	.type	0x4;	.endef
	.def	f18;	.val	24;	.scl	8;	.type	0x4;	.endef
	.def	f1C;	.val	28;	.scl	8;	.type	0x4;	.endef
	.def	f20;	.val	32;	.scl	8;	.type	0x4;	.endef
	.def	f24;	.val	36;	.scl	8;	.type	0x4;	.endef
	.def	f28;	.val	40;	.scl	8;	.type	0x4;	.endef
	.def	f2C;	.val	44;	.scl	8;	.type	0x2;	.endef
	.def	vol_l;	.val	45;	.scl	8;	.type	0x2;	.endef
	.def	pan;	.val	46;	.scl	8;	.type	0x2;	.endef
	.def	f2F;	.val	47;	.scl	8;	.type	0x2;	.endef
	.def	f30;	.val	48;	.scl	8;	.type	0x2;	.endef
	.def	f31;	.val	49;	.scl	8;	.type	0xc;	.endef
	.def	f32;	.val	50;	.scl	8;	.type	0x2;	.endef
	.def	f33;	.val	51;	.scl	8;	.type	0x2;	.endef
	.def	f34;	.val	52;	.scl	8;	.type	0x2;	.endef
	.def	f35;	.val	53;	.scl	8;	.type	0x2;	.endef
	.def	f36;	.val	54;	.scl	8;	.type	0x2;	.endef
	.def	f37;	.val	55;	.scl	8;	.type	0xc;	.endef
	.def	f38;	.val	56;	.scl	8;	.type	0xc;	.endef
	.def	f39;	.val	57;	.scl	8;	.type	0xc;	.endef
	.def	f3A;	.val	58;	.scl	8;	.type	0xc;	.endef
	.def	f3B;	.val	59;	.scl	8;	.type	0xc;	.endef
	.def	f3C;	.val	60;	.scl	8;	.type	0x2;	.endef
	.def	pan_cur;	.val	61;	.scl	8;	.type	0x2;	.endef
	.def	_g3E;	.val	62;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	f40;	.val	64;	.scl	8;	.type	0x4;	.endef
	.def	f44;	.val	68;	.scl	8;	.type	0x4;	.endef
	.def	pancurve;	.val	72;	.scl	8;	.type	0x4;	.endef
	.def	f4C;	.val	76;	.scl	8;	.type	0x4;	.endef
	.def	f50;	.val	80;	.scl	8;	.type	0x4;	.endef
	.def	f54;	.val	84;	.scl	8;	.type	0x4;	.endef
	.def	_g58;	.val	88;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	f5A;	.val	90;	.scl	8;	.type	0x3;	.endef
	.def	f5C;	.val	92;	.scl	8;	.type	0x3;	.endef
	.def	f5E;	.val	94;	.scl	8;	.type	0x3;	.endef
	.def	f60;	.val	96;	.scl	8;	.type	0xd;	.endef
	.def	f62;	.val	98;	.scl	8;	.type	0xd;	.endef
	.def	.eos;	.val	100;	.scl	102;	.tag	SndVoice;	.size	100;	.endef
	.def	SndVoice;	.scl	13;	.tag	SndVoice;	.size	100;	.type	0x8;	.endef
	.def	SndBank;	.scl	10;	.type	0x8;	.size	12;	.endef
	.def	datablk;	.val	0;	.scl	8;	.type	0x11;	.endef
	.def	platblk;	.val	4;	.scl	8;	.type	0x11;	.endef
	.def	f08;	.val	8;	.scl	8;	.type	0xc;	.endef
	.def	inuse;	.val	9;	.scl	8;	.type	0xc;	.endef
	.def	f0A;	.val	10;	.scl	8;	.type	0x2;	.endef
	.def	f0B;	.val	11;	.scl	8;	.type	0x2;	.endef
	.def	.eos;	.val	12;	.scl	102;	.tag	SndBank;	.size	12;	.endef
	.def	SndBank;	.scl	13;	.tag	SndBank;	.size	12;	.type	0x8;	.endef
	.def	SndFxBus;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	type;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	master;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	depth;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	delay;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	SndFxBus;	.size	16;	.endef
	.def	SndFxBus;	.scl	13;	.tag	SndFxBus;	.size	16;	.type	0x8;	.endef
	.def	SndPlayDef;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	handle;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	f04;	.val	4;	.scl	8;	.type	0x2;	.endef
	.def	decay;	.val	5;	.scl	8;	.type	0x2;	.endef
	.def	vol0;	.val	6;	.scl	8;	.type	0x2;	.endef
	.def	pan0;	.val	7;	.scl	8;	.type	0x2;	.endef
	.def	vol1;	.val	8;	.scl	8;	.type	0x2;	.endef
	.def	pan1;	.val	9;	.scl	8;	.type	0x2;	.endef
	.def	vol2;	.val	10;	.scl	8;	.type	0x2;	.endef
	.def	f0B;	.val	11;	.scl	8;	.type	0x2;	.endef
	.def	pitch0;	.val	12;	.scl	8;	.type	0x3;	.endef
	.def	pitch1;	.val	14;	.scl	8;	.type	0x3;	.endef
	.def	f10;	.val	16;	.scl	8;	.type	0x3;	.endef
	.def	f12;	.val	18;	.scl	8;	.type	0x3;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	SndPlayDef;	.size	20;	.endef
	.def	SndPlayDef;	.scl	13;	.tag	SndPlayDef;	.size	20;	.type	0x8;	.endef
	.def	SndState;	.scl	10;	.type	0x8;	.size	188;	.endef
	.def	_g00;	.val	0;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	f02;	.val	2;	.scl	8;	.type	0x3;	.endef
	.def	f04;	.val	4;	.scl	8;	.type	0x2;	.endef
	.def	f05;	.val	5;	.scl	8;	.type	0x2;	.endef
	.def	f06;	.val	6;	.scl	8;	.type	0x2;	.endef
	.def	f07;	.val	7;	.scl	8;	.type	0x2;	.endef
	.def	f08;	.val	8;	.scl	8;	.type	0x2;	.endef
	.def	f09;	.val	9;	.scl	8;	.type	0x2;	.endef
	.def	_g0A;	.val	10;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	bankcount;	.val	12;	.scl	8;	.type	0xd;	.endef
	.def	f0E;	.val	14;	.scl	8;	.type	0x3;	.endef
	.def	f10;	.val	16;	.scl	8;	.type	0x2;	.endef
	.def	patchcount;	.val	17;	.scl	8;	.type	0xc;	.endef
	.def	f12;	.val	18;	.scl	8;	.type	0x2;	.endef
	.def	f13;	.val	19;	.scl	8;	.type	0x2;	.endef
	.def	f14;	.val	20;	.scl	8;	.type	0x2;	.endef
	.def	_g15;	.val	21;	.scl	8;	.dim	39;	.size	39;	.type	0x32;	.endef
	.def	enabled;	.val	60;	.scl	8;	.type	0x2;	.endef
	.def	f3D;	.val	61;	.scl	8;	.type	0x2;	.endef
	.def	f3E;	.val	62;	.scl	8;	.type	0xc;	.endef
	.def	f3F;	.val	63;	.scl	8;	.type	0xc;	.endef
	.def	f40;	.val	64;	.scl	8;	.type	0xc;	.endef
	.def	f41;	.val	65;	.scl	8;	.type	0xc;	.endef
	.def	_g42;	.val	66;	.scl	8;	.dim	2;	.size	2;	.type	0x32;	.endef
	.def	f44;	.val	68;	.scl	8;	.type	0x4;	.endef
	.def	f48;	.val	72;	.scl	8;	.type	0x4;	.endef
	.def	f4C;	.val	76;	.scl	8;	.type	0x4;	.endef
	.def	_g50;	.val	80;	.scl	8;	.dim	44;	.size	44;	.type	0x32;	.endef
	.def	f7C;	.val	124;	.scl	8;	.type	0x4;	.endef
	.def	f80;	.val	128;	.scl	8;	.type	0x4;	.endef
	.def	f84;	.val	132;	.scl	8;	.type	0x4;	.endef
	.def	f88;	.val	136;	.scl	8;	.type	0x4;	.endef
	.def	f8C;	.val	140;	.scl	8;	.type	0x4;	.endef
	.def	f90;	.val	144;	.scl	8;	.type	0x4;	.endef
	.def	voices;	.val	148;	.scl	8;	.tag	SndVoice;	.size	100;	.type	0x18;	.endef
	.def	banks;	.val	152;	.scl	8;	.tag	SndBank;	.size	12;	.type	0x18;	.endef
	.def	fxbus;	.val	156;	.scl	8;	.tag	SndFxBus;	.dim	2;	.size	32;	.type	0x38;	.endef
	.def	.eos;	.val	188;	.scl	102;	.tag	SndState;	.size	188;	.endef
	.def	SndState;	.scl	13;	.tag	SndState;	.size	188;	.type	0x8;	.endef
	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\svol.c"
	.def	iSNDunsafevol;	.val	iSNDunsafevol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDunsafevol
iSNDunsafevol:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	vol;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$16,24($sp)
	move	$16,$5
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDgetchan
	sw	$17,28($sp)
	.set	macro
	.set	reorder

	move	$18,$2
	.set	noreorder
	.set	nomacro
	bltz	$18,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	lui	$2,%hi(gSndState) # high
	addiu	$19,$2,%lo(gSndState) # low
	sll	$17,$16,16
	move	$4,$18
$L9:
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchkey
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	move	$2,$18
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$3,148($19)
	sll	$2,$4,1
	addu	$2,$2,$4
	sll	$2,$2,3
	addu	$2,$2,$4
	sll	$2,$2,2
	addu	$16,$3,$2
	lw	$2,28($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$17,$L8
	move	$2,$0
	.set	macro
	.set	reorder

	sw	$17,28($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDcalcvol
	sw	$0,20($16)
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lb	$5,45($16)
	jal	iSNDvol
	.set	noreorder
	.set	nomacro
	j	$L9
	move	$4,$18
	.set	macro
	.set	reorder

	.def	done;	.val	$L3;	.scl	6;	.type	0x0;	.endef
$L3:
	move	$2,$18
$L8:
	lw	$31,40($sp)
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
	.end	iSNDunsafevol
	.def	SNDvol;	.val	SNDvol;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDvol
SNDvol:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	vol;	.val	17;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(gSndState+60) # high
	lb	$2,%lo(gSndState+60)($2)
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDunsafevol
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDleaveaudio
	move	$16,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	move	$2,$16
	.set	macro
	.set	reorder

$L11:
	li	$2,-10			# 0xfffffff6
$L12:
	lw	$31,24($sp)
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
LM2:
	.end	SNDvol
