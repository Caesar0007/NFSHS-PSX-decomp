	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\smemman.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDmemconstrain
	.align	2
	.globl	iSNDmeminit
	.align	2
	.globl	iSNDmemrestore
	.align	2
	.globl	iSNDmalloc

	.comm	sndmm,524

	.text
	.def	SNDMemState;	.scl	10;	.type	0x8;	.size	524;	.endef
	.def	base;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	count;	.val	4;	.scl	8;	.type	0x3;	.endef
	.def	poolWords;	.val	6;	.scl	8;	.type	0x3;	.endef
	.def	highWater;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	entries;	.val	12;	.scl	8;	.dim	256;	.size	512;	.type	0x3d;	.endef
	.def	.eos;	.val	524;	.scl	102;	.tag	SNDMemState;	.size	524;	.endef
	.def	SNDMemState;	.scl	13;	.tag	SNDMemState;	.size	524;	.type	0x8;	.endef
	.def	.0fake;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	blk;	.val	0;	.scl	8;	.type	0xd;	.endef
	.def	sz;	.val	2;	.scl	8;	.type	0xd;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	.0fake;	.size	4;	.endef
	.def	SndMemEnt;	.scl	13;	.tag	.0fake;	.size	4;	.type	0x8;	.endef
	.def	iSNDmemconstrain;	.val	iSNDmemconstrain;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDmemconstrain
iSNDmemconstrain:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	block;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	size;	.val	5;	.scl	17;	.type	0x14;	.endef
	lui	$3,%hi(sndmm+6) # high
	lw	$4,0($4)
	lw	$2,0($5)
	lhu	$3,%lo(sndmm+6)($3)
	addu	$2,$4,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	subu	$2,$3,$4
	.set	macro
	.set	reorder

	sw	$2,0($5)
$L3:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDmemconstrain
	.def	iSNDmeminit;	.val	iSNDmeminit;	.scl	2;	.type	0x64;	.endef
	.text
	.ent	iSNDmeminit
iSNDmeminit:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	membase;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	5;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndmm) # high
	sw	$4,%lo(sndmm)($2)
	addiu	$2,$2,%lo(sndmm) # low
	sra	$5,$5,2
	sh	$0,4($2)
	sh	$5,6($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,8($2)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDmeminit
	.def	iSNDmemrestore;	.val	iSNDmemrestore;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	iSNDmemrestore
iSNDmemrestore:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$4,%hi(sndmm) # high
	addiu	$4,$4,%lo(sndmm) # low
	lw	$3,8($4)
	#nop
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,3
	addu	$2,$2,$3
	lhu	$3,6($4)
	sll	$2,$2,2
	divu	$2,$2,$3
	j	$31

	.loc	1 0
LM3:
	.end	iSNDmemrestore
	.def	iSNDmalloc;	.val	iSNDmalloc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDmalloc
iSNDmalloc:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	size;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$4
	lui	$2,%hi(sndmm) # high
	addiu	$3,$2,%lo(sndmm) # low
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lhu	$4,4($3)
	#nop
	sltu	$2,$4,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$18,$18,3
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L9
	sra	$18,$18,2
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lhu	$2,6($3)
	addu	$5,$sp,20
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDmemconstrain
	sw	$2,20($sp)
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L26
$L9:
	lhu	$2,4($3)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L28
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$20,$3,12
	addu	$19,$3,8
	move	$17,$3
$L30:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L16
	addu	$5,$2,$20
	.set	macro
	.set	reorder

	lhu	$2,0($5)
	sw	$0,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L17
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L16:
	addu	$6,$2,$19
 #APP
 #NO_APP
	lhu	$2,0($6)
	lhu	$4,2($6)
	lhu	$3,0($5)
	addu	$2,$2,$4
	subu	$3,$3,$2
	sw	$2,16($sp)
	sw	$3,20($sp)
$L17:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	iSNDmemconstrain
	addu	$5,$sp,20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	slt	$2,$2,$18
	bne	$2,$0,$L18
	lhu	$4,4($17)
	#nop
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L11
	sll	$3,$4,2
	.set	macro
	.set	reorder

$L29:
	addu	$3,$3,$17
	addu	$4,$4,-1
	sll	$2,$4,2
	addu	$2,$2,$17
	lwl	$7,15($2)
	lwr	$7,12($2)
	swl	$7,15($3)
	swr	$7,12($3)
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L29
	sll	$3,$4,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L27
	sll	$4,$16,2
	.set	macro
	.set	reorder

$L18:
	lhu	$2,4($17)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	sll	$2,$16,2
	.set	macro
	.set	reorder

$L28:
 #APP
 #NO_APP
	lui	$3,%hi(sndmm+8) # high
	addiu	$3,$3,%lo(sndmm+8) # low
 #APP
 #NO_APP
	addu	$6,$2,$3
 #APP
 #NO_APP
	addu	$4,$sp,16
	addu	$5,$sp,20
	lhu	$2,0($6)
	lhu	$6,2($6)
	lhu	$3,-2($3)
	addu	$2,$2,$6
	subu	$3,$3,$2
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDmemconstrain
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	move	$2,$0
	.set	macro
	.set	reorder

	.def	commit;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	sll	$4,$16,2
$L27:
	lui	$3,%hi(sndmm+12) # high
	addiu	$3,$3,%lo(sndmm+12) # low
	lhu	$2,16($sp)
	addu	$5,$4,$3
	sh	$18,2($5)
	sh	$2,0($5)
	addu	$5,$3,-12
	lhu	$2,4($5)
	#nop
	addu	$2,$2,1
	sh	$2,4($5)
	lw	$4,16($sp)
	lw	$3,-12($3)
	sll	$2,$4,2
	addu	$3,$3,$2
	lw	$2,8($5)
	addu	$4,$4,$18
	slt	$2,$2,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L26
	move	$2,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L26
	sw	$4,8($5)
	.set	macro
	.set	reorder

	.def	fail;	.val	$L8;	.scl	6;	.type	0x0;	.endef
$L8:
	move	$2,$0
$L26:
	lw	$31,44($sp)
	lw	$20,40($sp)
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
LM4:
	.end	iSNDmalloc
	.def	sndmm;	.val	sndmm;	.scl	2;	.tag	SNDMemState;	.size	524;	.type	0x8;	.endef
