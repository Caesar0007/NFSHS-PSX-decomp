	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\smath64.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDmulu64
	.align	2
	.globl	iSNDdivu64

	.text
	.def	SNDu64Value;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	lo;	.val	0;	.scl	8;	.type	0xe;	.endef
	.def	hi;	.val	4;	.scl	8;	.type	0xe;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	SNDu64Value;	.size	8;	.endef
	.def	iSNDmulu64;	.val	iSNDmulu64;	.scl	2;	.tag	SNDu64Value;	.size	8;	.type	0x68;	.endef
	.text
	.ent	iSNDmulu64
iSNDmulu64:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	out;	.val	2;	.scl	17;	.tag	SNDu64Value;	.size	8;	.type	0x18;	.endef
	.def	a;	.val	5;	.scl	17;	.type	0xe;	.endef
	.def	b;	.val	6;	.scl	17;	.type	0xe;	.endef
	move	$2,$4
	andi	$4,$5,0xffff
	andi	$8,$6,0xffff
	mult	$4,$8
	mflo	$7
	#nop
	srl	$6,$6,16
	mult	$4,$6
	mflo	$4
	#nop
	srl	$5,$5,16
	mult	$5,$8
	subu	$sp,$sp,8
	sll	$3,$4,16
	mflo	$8
	#nop
	addu	$3,$7,$3
	srl	$7,$7,16
	mult	$5,$6
	sll	$9,$8,16
	addu	$3,$3,$9
	sw	$3,0($sp)
	andi	$3,$4,0xffff
	addu	$7,$7,$3
	andi	$3,$8,0xffff
	addu	$7,$7,$3
	srl	$7,$7,16
	srl	$4,$4,16
	srl	$8,$8,16
	addu	$4,$4,$8
	mflo	$14
	#nop
	#nop
	addu	$4,$4,$14
	addu	$4,$4,$7
	sw	$4,4($sp)
	lw	$10,0($sp)
	lw	$11,4($sp)
	sw	$10,0($2)
	sw	$11,4($2)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,8
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDmulu64
	.def	iSNDdivu64;	.val	iSNDdivu64;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDdivu64
iSNDdivu64:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	value;	.val	0;	.scl	9;	.tag	SNDu64Value;	.size	8;	.type	0x8;	.endef
	.def	div;	.val	6;	.scl	17;	.type	0xe;	.endef
	move	$3,$0
	li	$7,32			# 0x00000020
	sw	$4,0($sp)
	sw	$5,4($sp)
	addu	$7,$7,-1
$L8:
	sll	$3,$3,1
	sll	$5,$5,1
	srl	$2,$4,31
	addu	$5,$5,$2
	sltu	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	sll	$4,$4,1
	.set	macro
	.set	reorder

	subu	$5,$5,$6
	addu	$3,$3,1
$L5:
	.set	noreorder
	.set	nomacro
	bne	$7,$0,$L8
	addu	$7,$7,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDdivu64
