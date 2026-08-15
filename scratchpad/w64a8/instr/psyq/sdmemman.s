	.file	1 "recon/eaclib/psx/sndpsxz/sdmemman.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDpsxmemconstrain
	.align	2
	.globl	iSNDpsxmalloc
	.align	2
	.globl	iSNDpsxfree

	.text
	.def	iSNDpsxmemconstrain;	.val	iSNDpsxmemconstrain;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDpsxmemconstrain
iSNDpsxmemconstrain:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	size;	.val	4;	.scl	17;	.type	0x1e;	.endef
	.def	avail;	.val	5;	.scl	17;	.type	0x14;	.endef
	lui	$2,%hi(sndpd) # high
	addiu	$8,$2,%lo(sndpd) # low
	lhu	$7,1306($8)
	lw	$6,0($4)
	#nop
	slt	$2,$6,$7
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	subu	$2,$7,$6
	.set	macro
	.set	reorder

	sw	$7,0($4)
	lw	$3,0($5)
	#nop
	subu	$3,$3,$2
	sw	$3,0($5)
	lw	$6,0($4)
$L6:
	lw	$2,0($5)
	lhu	$3,1308($8)
	addu	$2,$6,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L7
	subu	$2,$3,$6
	.set	macro
	.set	reorder

	sw	$2,0($5)
$L7:
	lw	$4,0($4)
	lw	$2,0($5)
	lhu	$3,1310($8)
	addu	$2,$4,$2
	slt	$2,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	subu	$2,$3,$4
	.set	macro
	.set	reorder

	sw	$2,0($5)
$L9:
	j	$31

	.loc	1 0
LM1:
	.end	iSNDpsxmemconstrain
	.def	PackedAllocSlot;	.scl	10;	.type	0x8;	.size	1316;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	1312;	.size	1312;	.type	0x3c;	.endef
	.def	word;	.val	1312;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	1316;	.scl	102;	.tag	PackedAllocSlot;	.size	1316;	.endef
	.def	iSNDpsxmalloc;	.val	iSNDpsxmalloc;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxmalloc
iSNDpsxmalloc:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	size;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$18,32($sp)
	move	$18,$4
	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lhu	$4,1304($3)
	#nop
	sltu	$2,$4,128
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L51
	move	$16,$0
	.set	macro
	.set	reorder

	addu	$18,$18,63
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L15
	sra	$18,$18,6
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	addu	$5,$sp,20
	lhu	$6,1306($3)
	lhu	$2,1308($3)
	move	$3,$6
	subu	$2,$2,$3
	sw	$6,16($sp)
	sw	$2,20($sp)
$L52:
	jal	iSNDpsxmemconstrain
	lw	$2,20($sp)
	#nop
	slt	$2,$2,$18
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L53
	sll	$2,$16,2
	.set	macro
	.set	reorder

$L51:
	.set	noreorder
	.set	nomacro
	j	$L49
	move	$2,$0
	.set	macro
	.set	reorder

	.def	nonempty;	.val	$L15;	.scl	6;	.type	0x0;	.endef
$L15:
	#.set	volatile
	lhu	$2,1304($3)
	#.set	novolatile
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L17
	addu	$20,$3,1312
	.set	macro
	.set	reorder

	move	$17,$3
	addu	$19,$17,1308
	sll	$2,$16,2
$L55:
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L19
	addu	$5,$2,$20
	.set	macro
	.set	reorder

	lhu	$3,1306($17)
	#.set	volatile
	lhu	$2,0($5)
	#.set	novolatile
	#nop
	subu	$2,$2,$3
	sw	$3,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L20
	sw	$2,20($sp)
	.set	macro
	.set	reorder

$L19:
	addu	$3,$19,$2
	lhu	$2,0($3)
	lhu	$4,2($3)
	lhu	$3,0($5)
	addu	$2,$2,$4
	subu	$3,$3,$2
	sw	$2,16($sp)
	sw	$3,20($sp)
$L20:
	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxmemconstrain
	addu	$5,$sp,20
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	#nop
	slt	$2,$2,$18
	bne	$2,$0,$L21
	lhu	$4,1304($17)
	#nop
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	sll	$2,$16,2
	.set	macro
	.set	reorder

	sll	$3,$4,2
$L54:
	addu	$3,$3,$17
	addu	$4,$4,-1
	sll	$2,$4,2
	addu	$2,$2,$17
	lwl	$7,1315($2)
	lwr	$7,1312($2)
	swl	$7,1315($3)
	swr	$7,1312($3)
	slt	$2,$16,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L54
	sll	$3,$4,2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L53
	sll	$2,$16,2
	.set	macro
	.set	reorder

$L21:
	lhu	$2,1304($17)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L55
	sll	$2,$16,2
	.set	macro
	.set	reorder

	.def	scan_done;	.val	$L17;	.scl	6;	.type	0x0;	.endef
$L17:
	sll	$6,$16,2
	lui	$3,%hi(D_80147E34) # high
	addiu	$2,$3,%lo(D_80147E34) # low
	addu	$6,$6,$2
	addu	$4,$sp,16
	addu	$5,$sp,20
	lhu	$2,0($6)
	lhu	$6,2($6)
	lhu	$3,%lo(D_80147E34)($3)
	addu	$2,$2,$6
	subu	$3,$3,$2
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L52
	sw	$3,20($sp)
	.set	macro
	.set	reorder

	.def	commit;	.val	$L14;	.scl	6;	.type	0x0;	.endef
$L14:
$L53:
	lui	$4,%hi(sndpd+1312) # high
	addiu	$4,$4,%lo(sndpd+1312) # low
	addu	$2,$2,$4
	sh	$18,2($2)
	lhu	$3,16($sp)
	addu	$4,$4,-1312
	sh	$3,0($2)
	lw	$2,16($sp)
	lhu	$3,1304($4)
	sll	$2,$2,6
	addu	$3,$3,1
	sh	$3,1304($4)
$L49:
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
LM2:
	.end	iSNDpsxmalloc
	.def	PackedAllocSlot;	.scl	10;	.type	0x8;	.size	1316;	.endef
	.def	pad;	.val	0;	.scl	8;	.dim	1312;	.size	1312;	.type	0x3c;	.endef
	.def	word;	.val	1312;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	1316;	.scl	102;	.tag	PackedAllocSlot;	.size	1316;	.endef
	.def	iSNDpsxfree;	.val	iSNDpsxfree;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDpsxfree
iSNDpsxfree:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	ptr;	.val	4;	.scl	17;	.type	0x4;	.endef
	move	$5,$0
	lui	$2,%hi(sndpd) # high
	addiu	$3,$2,%lo(sndpd) # low
	lhu	$2,1304($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L57
	sra	$4,$4,6
	.set	macro
	.set	reorder

	addu	$7,$3,1312
	move	$6,$3
	sll	$2,$5,2
$L70:
	addu	$2,$2,$7
	lhu	$2,0($2)
	#nop
	bne	$2,$4,$L61
	lhu	$2,1304($6)
	#nop
	addu	$2,$2,-1
	sh	$2,1304($6)
	andi	$2,$2,0xffff
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L62
	sll	$3,$5,2
	.set	macro
	.set	reorder

$L69:
	addu	$3,$3,$6
	addu	$4,$5,1
	sll	$2,$4,2
	addu	$2,$2,$6
	lwl	$8,1315($2)
	lwr	$8,1312($2)
	swl	$8,1315($3)
	swr	$8,1312($3)
	#.set	volatile
	lhu	$2,1304($6)
	#.set	novolatile
	move	$5,$4
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L69
	sll	$3,$5,2
	.set	macro
	.set	reorder

$L62:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L61:
	lhu	$2,1304($6)
	addu	$5,$5,1
	slt	$2,$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L70
	sll	$2,$5,2
	.set	macro
	.set	reorder

$L57:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	iSNDpsxfree
