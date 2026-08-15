	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\ssysinit.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndgs
	.globl	D_80147871
	.globl	D_80147898
	.globl	DAT_801478f4
	.section	.bss
	.align	2
sndgs:
	.space	0x11
D_80147871:
	.space	0x27
D_80147898:
	.space	0x5c
DAT_801478f4:
	.space	0x20
	.text
	.text
 #NO_APP
	.align	2
	.globl	SNDSYS_getopts
	.align	2
	.globl	SNDSYS_setopts
	.align	2
	.globl	SNDSYS_init
	.align	2
	.globl	SNDSYS_restore

	.text
	.def	SndOptsBlock15;	.scl	10;	.type	0x8;	.size	60;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	15;	.size	60;	.type	0x34;	.endef
	.def	.eos;	.val	60;	.scl	102;	.tag	SndOptsBlock15;	.size	60;	.endef
	.def	SNDSYS_getopts;	.val	SNDSYS_getopts;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSYS_getopts
SNDSYS_getopts:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	opts;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	lui	$16,%hi(DAT_80134a68) # high
	lw	$2,%lo(DAT_80134a68)($16)
	move	$5,$0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	jal	iSNDplatformoutputcaps
	move	$5,$2
	li	$2,1			# 0x00000001
	sw	$2,%lo(DAT_80134a68)($16)
$L2:
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	lhu	$2,12($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	li	$2,16			# 0x00000010
	.set	macro
	.set	reorder

	sh	$2,12($3)
$L3:
	move	$4,$17
	move	$2,$3
	addu	$3,$2,48
$L4:
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	lw	$9,12($2)
	sw	$6,0($4)
	sw	$7,4($4)
	sw	$8,8($4)
	sw	$9,12($4)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L4
	addu	$4,$4,16
	.set	macro
	.set	reorder

	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	sw	$6,0($4)
	sw	$7,4($4)
	sw	$8,8($4)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDSYS_getopts
	.def	SndOptsBlock;	.scl	10;	.type	0x8;	.size	44;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	11;	.size	44;	.type	0x34;	.endef
	.def	.eos;	.val	44;	.scl	102;	.tag	SndOptsBlock;	.size	44;	.endef
	.def	SNDSYS_setopts;	.val	SNDSYS_setopts;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSYS_setopts
SNDSYS_setopts:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	opts;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	lui	$2,%hi(sndgs) # high
	addiu	$2,$2,%lo(sndgs) # low
	addu	$5,$2,12
	addu	$3,$4,12
	or	$2,$3,$5
	andi	$2,$2,0x0003
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$4,44
$L8:
	lwl	$6,3($3)
	lwr	$6,0($3)
	lwl	$7,7($3)
	lwr	$7,4($3)
	lwl	$8,11($3)
	lwr	$8,8($3)
	lwl	$9,15($3)
	lwr	$9,12($3)
	swl	$6,3($5)
	swr	$6,0($5)
	swl	$7,7($5)
	swr	$7,4($5)
	swl	$8,11($5)
	swr	$8,8($5)
	swl	$9,15($5)
	swr	$9,12($5)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	addu	$5,$5,16
	.set	macro
	.set	reorder

	j	$L7
$L6:
	addu	$2,$4,44
$L9:
	lw	$6,0($3)
	lw	$7,4($3)
	lw	$8,8($3)
	lw	$9,12($3)
	sw	$6,0($5)
	sw	$7,4($5)
	sw	$8,8($5)
	sw	$9,12($5)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L9
	addu	$5,$5,16
	.set	macro
	.set	reorder

$L7:
	lwl	$6,3($3)
	lwr	$6,0($3)
	lwl	$7,7($3)
	lwr	$7,4($3)
	lwl	$8,11($3)
	lwr	$8,8($3)
	swl	$6,3($5)
	swr	$6,0($5)
	swl	$7,7($5)
	swr	$7,4($5)
	swl	$8,11($5)
	swr	$8,8($5)
	lw	$3,56($4)
	lui	$2,%hi(D_80147898) # high
	.set	noreorder
	.set	nomacro
	jal	iSNDplatformoutputset
	sw	$3,%lo(D_80147898)($2)
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	SNDSYS_setopts
	.def	SNDSYS_init;	.val	SNDSYS_init;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSYS_init
SNDSYS_init:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	membase;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	sw	$17,20($sp)
	addiu	$17,$2,%lo(sndgs) # low
	sw	$31,24($sp)
	sw	$16,16($sp)
	lb	$2,60($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	move	$2,$0
	.set	macro
	.set	reorder

	jal	iSNDmeminit
	lbu	$2,17($17)
	#nop
	bne	$2,$0,$L12
	.set	noreorder
	.set	nomacro
	jal	SNDSYS_getopts
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDSYS_setopts
	move	$4,$17
	.set	macro
	.set	reorder

	lbu	$2,17($17)
$L12:
	sll	$4,$2,1
	addu	$4,$4,$2
	sll	$4,$4,3
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	iSNDmalloc
	sll	$4,$4,2
	.set	macro
	.set	reorder

	move	$4,$2
	lbu	$2,17($17)
	move	$5,$0
	sw	$4,148($17)
	sll	$6,$2,1
	addu	$6,$6,$2
	sll	$6,$6,3
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	memset
	sll	$6,$6,2
	.set	macro
	.set	reorder

	lhu	$2,12($17)
	#nop
	sll	$4,$2,1
	addu	$4,$4,$2
	.set	noreorder
	.set	nomacro
	jal	iSNDmalloc
	sll	$4,$4,2
	.set	macro
	.set	reorder

	move	$4,$2
	lhu	$2,12($17)
	move	$5,$0
	sw	$4,152($17)
	sll	$6,$2,1
	addu	$6,$6,$2
	.set	noreorder
	.set	nomacro
	jal	memset
	sll	$6,$6,2
	.set	macro
	.set	reorder

	lw	$2,72($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L13
	lui	$2,%hi(iSND100hzserver) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(iSND100hzserver) # low
	sw	$2,72($17)
$L13:
	jal	SNDI_mutexalloc
	li	$2,127			# 0x0000007f
	sw	$0,68($17)
	sw	$0,172($17)
	.set	noreorder
	.set	nomacro
	jal	iSNDinit
	sb	$2,61($17)
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	bltz	$16,$L14
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	sb	$2,60($17)
	.set	noreorder
	.set	nomacro
	j	$L15
	move	$2,$0
	.set	macro
	.set	reorder

$L14:
	jal	iSNDrestore
	move	$2,$16
$L15:
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
LM3:
	.end	SNDSYS_init
	.def	SNDSYS_restore;	.val	SNDSYS_restore;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSYS_restore
SNDSYS_restore:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	lui	$2,%hi(sndgs) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sndgs) # low
	sw	$31,20($sp)
	lb	$2,60($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L24
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

	lw	$2,140($16)
	#nop
	beq	$2,$0,$L18
	jal	$31,$2
$L18:
	lw	$2,144($16)
	#nop
	beq	$2,$0,$L19
	jal	$31,$2
$L19:
	lw	$2,132($16)
	#nop
	beq	$2,$0,$L20
	jal	$31,$2
$L20:
	lw	$2,136($16)
	#nop
	beq	$2,$0,$L21
	jal	$31,$2
$L21:
	lw	$2,128($16)
	#nop
	beq	$2,$0,$L22
	jal	$31,$2
$L22:
	jal	SNDstopall
	lw	$2,124($16)
	#nop
	beq	$2,$0,$L23
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	li	$4,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L23:
	jal	iSNDrestore
	.set	noreorder
	.set	nomacro
	jal	SNDI_mutexfree
	sb	$0,60($16)
	.set	macro
	.set	reorder

	jal	iSNDmemrestore
$L24:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	SNDSYS_restore
