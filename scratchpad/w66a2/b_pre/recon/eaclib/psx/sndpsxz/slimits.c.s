	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\slimits.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDgetlimits
	.align	2
	.globl	SNDsetlimits

	.extern	sndpsxlimits, 20

	.text
	.def	LimitsBlock;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	value;	.val	0;	.scl	8;	.dim	5;	.size	20;	.type	0x34;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	LimitsBlock;	.size	20;	.endef
	.def	SNDgetlimits;	.val	SNDgetlimits;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDgetlimits
SNDgetlimits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	opts;	.val	4;	.scl	17;	.type	0x14;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	lui	$2,%hi(sndpsxlimits) # high
	.set	macro
	.set	reorder

	addiu	$7,$2,%lo(sndpsxlimits)
	lw	$3,0($7)
	lw	$5,4($7)
	lw	$6,8($7)
	sw	$3,0($4)
	sw	$5,4($4)
	sw	$6,8($4)
	lw	$3,12($7)
	lw	$5,16($7)
	sw	$3,12($4)
	sw	$5,16($4)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-14			# 0xfffffff2
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDgetlimits
	.def	SNDsetlimits;	.val	SNDsetlimits;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDsetlimits
SNDsetlimits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	opts;	.val	3;	.scl	17;	.type	0x14;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	move	$3,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L5:
	lw	$2,16($3)
	#nop
	slt	$2,$2,8192
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(sndpsxlimits) # high
	addiu	$9,$4,%lo(sndpsxlimits)
	lw	$6,0($3)
	lw	$7,4($3)
	lw	$8,8($3)
	sw	$6,0($9)
	sw	$7,4($9)
	sw	$8,8($9)
	lw	$6,12($3)
	lw	$7,16($3)
	sw	$6,12($9)
	sw	$7,16($9)
	addiu	$4,$4,%lo(sndpsxlimits) # low
	lw	$3,16($4)
	li	$5,-8192			# 0xffffe000
	and	$3,$3,$5
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$3,16($4)
	.set	macro
	.set	reorder

$L6:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	SNDsetlimits
