	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sst.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	sndss
	.globl	sndStreamMap
	.section	.bss
	.align	2
sndss:
	.space	4
sndStreamMap:
	.space	4
	.text
 #NO_APP
	.text
	.align	2
	.globl	iSNDstreamdestroyall
	.align	2
	.globl	iSNDstreamgetstreamptr
	.align	2
	.globl	iSNDstreamremoverequest
	.align	2
	.globl	iSNDstreamreleasecallback
	.align	2
	.globl	iSNDstreamnotifycallback
	.align	2
	.globl	iSNDstreamparseheader
	.align	2
	.globl	iSNDstreamparsenumchunks
	.align	2
	.globl	iSNDstreamparsedata
	.align	2
	.globl	iSNDstreamparseend
	.align	2
	.globl	iSNDstreamparsechunk
	.align	2
	.globl	iSNDstreamisheld
	.align	2
	.globl	iSNDstreamhotroddatachunks
	.align	2
	.globl	iSNDstreamservice
	.align	2
	.globl	iSNDstreamnumcreated
	.align	2
	.globl	iSNDstreamcreate
	.align	2
	.globl	iSNDstreamqueue

	.text
	.def	iSNDstreamdestroyall;	.val	iSNDstreamdestroyall;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamdestroyall
iSNDstreamdestroyall:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$0
	sw	$31,20($sp)
$L2:
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_destroy
	move	$4,$16
	.set	macro
	.set	reorder

	addu	$16,$16,1
	.set	noreorder
	.set	nomacro
	blez	$16,$L2
	move	$2,$0
	.set	macro
	.set	reorder

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
LM1:
	.end	iSNDstreamdestroyall
	.def	iSNDstreamgetstreamptr;	.val	iSNDstreamgetstreamptr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamgetstreamptr
iSNDstreamgetstreamptr:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	idx;	.val	4;	.scl	17;	.type	0x4;	.endef
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L7
	lui	$2,%hi(sndss) # high
	.set	macro
	.set	reorder

	lw	$2,%lo(sndss)($2)
	j	$31
$L7:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDstreamgetstreamptr
	.def	ReqRec;	.scl	10;	.type	0x8;	.size	44;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	11;	.size	44;	.type	0x34;	.endef
	.def	.eos;	.val	44;	.scl	102;	.tag	ReqRec;	.size	44;	.endef
	.def	iSNDstreamremoverequest;	.val	iSNDstreamremoverequest;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDstreamremoverequest
iSNDstreamremoverequest:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	reqid;	.val	4;	.scl	17;	.type	0xe;	.endef
	lui	$2,%hi(sndss) # high
	addiu	$2,$2,%lo(sndss) # low
	andi	$3,$4,0x00ff
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$5,0($3)
	move	$10,$0
	lbu	$2,22($5)
	#nop
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	blez	$2,$L10
	move	$7,$10
	.set	macro
	.set	reorder

	move	$9,$10
	move	$8,$10
$L11:
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	#nop
	addu	$3,$2,$9
	lw	$2,4($3)
	#nop
	beq	$2,$4,$L14
	#.set	volatile
	lbu	$2,23($5)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$7,$L15
	sb	$10,23($5)
$L15:
	#.set	volatile
	lw	$2,0($5)
	#.set	novolatile
	addu	$6,$3,32
	addu	$2,$8,$2
$L16:
	lw	$11,0($3)
	lw	$12,4($3)
	lw	$13,8($3)
	lw	$14,12($3)
	sw	$11,0($2)
	sw	$12,4($2)
	sw	$13,8($2)
	sw	$14,12($2)
	addu	$3,$3,16
	.set	noreorder
	.set	nomacro
	bne	$3,$6,$L16
	addu	$2,$2,16
	.set	macro
	.set	reorder

	lw	$11,0($3)
	lw	$12,4($3)
	lw	$13,8($3)
	sw	$11,0($2)
	sw	$12,4($2)
	sw	$13,8($2)
	addu	$8,$8,44
	addu	$10,$10,1
$L14:
	addu	$9,$9,44
	#.set	volatile
	lbu	$2,22($5)
	#.set	novolatile
	addu	$7,$7,1
	sll	$2,$2,24
	sra	$2,$2,24
	slt	$2,$7,$2
	bne	$2,$0,$L11
$L10:
	#.set	volatile
	lbu	$2,22($5)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	#.set	volatile
	sb	$2,22($5)
	#.set	novolatile
	#.set	volatile
	lbu	$3,23($5)
	#.set	novolatile
	#.set	volatile
	lbu	$2,22($5)
	#.set	novolatile
	sll	$3,$3,24
	sll	$2,$2,24
	slt	$2,$2,$3
	beq	$2,$0,$L19
	#.set	volatile
	lbu	$2,23($5)
	#.set	novolatile
	#nop
	addu	$2,$2,-1
	sb	$2,23($5)
$L19:
	j	$31

	.loc	1 0
LM3:
	.end	iSNDstreamremoverequest
	.def	iSNDstreamreleasecallback;	.val	iSNDstreamreleasecallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDstreamreleasecallback
iSNDstreamreleasecallback:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	sample;	.val	4;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$5,-4($4)
	lui	$3,%hi(sndss) # high
	lbu	$2,0($5)
	addiu	$3,$3,%lo(sndss) # low
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$2,0($2)
	#nop
	lw	$4,4($2)
	jal	STREAM_release
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM4:
	.end	iSNDstreamreleasecallback
	.def	iSNDstreamnotifycallback;	.val	iSNDstreamnotifycallback;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDstreamnotifycallback
iSNDstreamnotifycallback:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	handle;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	bytes;	.val	5;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,32
	lui	$3,%hi(sndss) # high
	addiu	$3,$3,%lo(sndss) # low
	addu	$4,$4,$3
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lb	$2,4($4)
	move	$16,$0
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$17,0($2)
$L22:
	lw	$4,0($17)
	#nop
	#.set	volatile
	lw	$2,28($4)
	#.set	novolatile
	#nop
	sltu	$2,$2,$5
	beq	$2,$0,$L25
	#.set	volatile
	lw	$2,28($4)
	#.set	novolatile
	#nop
	subu	$16,$5,$2
	subu	$5,$5,$16
$L25:
	#.set	volatile
	lw	$2,20($4)
	#.set	novolatile
	#nop
	addu	$2,$2,$5
	#.set	volatile
	sw	$2,20($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,28($4)
	#.set	novolatile
	#nop
	subu	$2,$2,$5
	#.set	volatile
	sw	$2,28($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,20($4)
	#.set	novolatile
	#.set	volatile
	lw	$3,24($4)
	#.set	novolatile
	#nop
	sltu	$2,$2,$3
	bne	$2,$0,$L27
	#.set	volatile
	lw	$4,4($4)
	#.set	novolatile
	jal	iSNDstreamremoverequest
	.def	notdone;	.val	$L27;	.scl	6;	.type	0x0;	.endef
$L27:
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L23
	move	$5,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L22
	move	$16,$0
	.set	macro
	.set	reorder

$L23:
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
LM5:
	.end	iSNDstreamnotifycallback
	.def	PackedRate;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	word;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	PackedRate;	.size	4;	.endef
	.def	Hdr5;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	5;	.size	20;	.type	0x34;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	Hdr5;	.size	20;	.endef
	.def	iSNDstreamparseheader;	.val	iSNDstreamparseheader;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamparseheader
iSNDstreamparseheader:
	.frame	$sp,48,$31		# vars= 8, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.def	S;	.val	19;	.scl	17;	.type	0x4;	.endef
	.def	data;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$19,36($sp)
	move	$19,$4
	sw	$18,32($sp)
	move	$18,$5
	addu	$4,$18,12
	sw	$17,28($sp)
	addu	$17,$19,32
	move	$5,$17
	sw	$20,40($sp)
	addu	$20,$19,56
	move	$6,$20
	addu	$7,$sp,16
	sw	$31,44($sp)
	sw	$16,24($sp)
	#.set	volatile
	lbu	$3,23($19)
	#.set	novolatile
	lw	$16,0($19)
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	jal	iSNDpatchtohdr
	addu	$16,$16,$2
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	#nop
	#.set	volatile
	sw	$2,24($16)
	#.set	novolatile
	lw	$4,4($19)
	.set	noreorder
	.set	nomacro
	jal	STREAM_release
	move	$5,$18
	.set	macro
	.set	reorder

	li	$3,-1840709632			# 0x92490000
	#.set	volatile
	lw	$2,24($16)
	#.set	novolatile
	ori	$3,$3,0x2493
	addu	$2,$2,27
	mult	$2,$3
	move	$4,$17
	mfhi	$8
	#nop
	#nop
	addu	$3,$8,$2
	sra	$3,$3,4
	sra	$2,$2,31
	subu	$3,$3,$2
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	#.set	volatile
	sw	$2,24($16)
	#.set	novolatile
	jal	iSNDplatformcalcdatarate
	addu	$4,$19,28
	move	$5,$17
	li	$6,4			# 0x00000004
	#.set	volatile
	sw	$2,16($16)
	#.set	novolatile
	jal	memcmp
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L31
	addu	$4,$19,36
	.set	macro
	.set	reorder

	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	memcmp
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	beq	$2,$0,$L33
	.def	formatdiffers;	.val	$L31;	.scl	6;	.type	0x0;	.endef
$L31:
	lhu	$2,28($19)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L34
	li	$2,2			# 0x00000002
	.set	macro
	.set	reorder

	#.set	volatile
	sb	$2,20($19)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L37
	move	$2,$0
	.set	macro
	.set	reorder

$L34:
	lwl	$9,35($19)
	lwr	$9,32($19)
	swl	$9,31($19)
	swr	$9,28($19)
	lw	$9,56($19)
	lw	$10,60($19)
	lw	$11,64($19)
	lw	$8,68($19)
	sw	$9,36($19)
	sw	$10,40($19)
	sw	$11,44($19)
	sw	$8,48($19)
	lw	$9,72($19)
	sw	$9,52($19)
	.def	formatsame;	.val	$L33;	.scl	6;	.type	0x0;	.endef
$L33:
	#.set	volatile
	lbu	$2,20($19)
	#.set	novolatile
	li	$16,1			# 0x00000001
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L35
	addu	$5,$19,28
	.set	macro
	.set	reorder

	addu	$6,$19,36
	lw	$4,12($19)
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_start
	addu	$7,$19,76
	.set	macro
	.set	reorder

	sw	$2,8($19)
	sb	$16,20($19)
$L35:
	move	$2,$0
$L37:
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
LM6:
	.end	iSNDstreamparseheader
	.def	iSNDstreamparsenumchunks;	.val	iSNDstreamparsenumchunks;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamparsenumchunks
iSNDstreamparsenumchunks:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	S;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	data;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	sw	$31,24($sp)
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_release
	move	$17,$5
	.set	macro
	.set	reorder

	#.set	volatile
	lbu	$3,23($16)
	#.set	novolatile
	lw	$4,12($17)
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,0($16)
	sll	$2,$2,2
	addu	$2,$2,$3
	sw	$4,36($2)
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM7:
	.end	iSNDstreamparsenumchunks
	.def	iSNDstreamparsedata;	.val	iSNDstreamparsedata;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamparsedata
iSNDstreamparsedata:
	.frame	$sp,56,$31		# vars= 32, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	S;	.val	8;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,56
	sw	$31,52($sp)
	sw	$16,48($sp)
	lw	$2,12($5)
	move	$8,$4
	sw	$2,20($sp)
	lbu	$2,47($8)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L40
	move	$9,$0
	.set	macro
	.set	reorder

	addu	$7,$5,16
	lbu	$2,30($8)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L52
	move	$4,$9
	.set	macro
	.set	reorder

	move	$6,$7
	addu	$3,$sp,16
$L48:
	sw	$6,12($3)
	addu	$6,$6,$9
	lbu	$2,30($8)
	addu	$4,$4,1
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L48
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L59
	li	$3,-1840709632			# 0x92490000
	.set	macro
	.set	reorder

$L40:
	addu	$6,$5,16
	lbu	$3,30($8)
	move	$4,$0
	sll	$2,$3,2
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L52
	addu	$7,$6,$2
	.set	macro
	.set	reorder

	addu	$3,$sp,16
$L54:
	lw	$2,0($6)
	addu	$6,$6,4
	addu	$4,$4,1
	addu	$2,$7,$2
	sw	$2,12($3)
	lbu	$2,30($8)
	#nop
	slt	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L54
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L52:
	li	$3,-1840709632			# 0x92490000
$L59:
	lw	$2,20($sp)
	ori	$3,$3,0x2493
	addu	$2,$2,27
	mult	$2,$3
	lw	$6,28($sp)
	mfhi	$10
	#nop
	#nop
	addu	$3,$10,$2
	sra	$3,$3,4
	sra	$2,$2,31
	subu	$3,$3,$2
	sll	$2,$3,3
	subu	$2,$2,$3
	sll	$2,$2,2
	sw	$2,20($sp)
	#.set	volatile
	lbu	$3,23($8)
	#.set	novolatile
	lw	$4,0($8)
	sw	$5,-4($6)
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$16,$4,$2
	lw	$2,4($16)
	#nop
	sw	$2,0($5)
	#.set	volatile
	lw	$2,28($16)
	#.set	novolatile
	lw	$3,20($sp)
	#nop
	addu	$2,$2,$3
	#.set	volatile
	sw	$2,28($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,32($16)
	#.set	novolatile
	#nop
	addu	$2,$2,1
	#.set	volatile
	sw	$2,32($16)
	#.set	novolatile
	lw	$4,12($8)
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_submit
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,12($16)
	#.set	novolatile
	#.set	volatile
	lw	$2,8($16)
	#.set	novolatile
	#nop
	bgez	$2,$L58
	lw	$2,12($16)
	#nop
	sw	$2,8($16)
$L58:
	lw	$31,52($sp)
	lw	$16,48($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM8:
	.end	iSNDstreamparsedata
	.def	iSNDstreamparseend;	.val	iSNDstreamparseend;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamparseend
iSNDstreamparseend:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	S;	.val	16;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lw	$4,4($16)
	jal	STREAM_release
	lbu	$2,23($16)
	#nop
	addu	$2,$2,1
	sb	$2,23($16)
	lw	$31,20($sp)
	lw	$16,16($sp)
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM9:
	.end	iSNDstreamparseend
	.def	iSNDstreamparsechunk;	.val	iSNDstreamparsechunk;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamparsechunk
iSNDstreamparsechunk:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	S;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	chunk;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	li	$2,1816395776			# 0x6c440000
	sw	$31,20($sp)
	lw	$3,0($5)
	ori	$2,$2,0x4353
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L62
	li	$16,1			# 0x00000001
	.set	macro
	.set	reorder

	jal	iSNDstreamparsedata
	.set	noreorder
	.set	nomacro
	j	$L63
	move	$16,$2
	.set	macro
	.set	reorder

$L62:
	li	$2,1816657920			# 0x6c480000
	ori	$2,$2,0x4353
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L64
	li	$2,1816461312			# 0x6c450000
	.set	macro
	.set	reorder

	jal	iSNDstreamparseheader
	.set	noreorder
	.set	nomacro
	j	$L63
	move	$16,$2
	.set	macro
	.set	reorder

$L64:
	ori	$2,$2,0x4353
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L66
	li	$2,1816330240			# 0x6c430000
	.set	macro
	.set	reorder

	jal	iSNDstreamparseend
	.set	noreorder
	.set	nomacro
	j	$L63
	move	$16,$2
	.set	macro
	.set	reorder

$L66:
	ori	$2,$2,0x4353
	bne	$3,$2,$L68
	jal	iSNDstreamparsenumchunks
	.set	noreorder
	.set	nomacro
	j	$L63
	move	$16,$2
	.set	macro
	.set	reorder

$L68:
	lw	$4,4($4)
	jal	STREAM_release
$L63:
	move	$2,$16
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
LM10:
	.end	iSNDstreamparsechunk
	.def	iSNDstreamisheld;	.val	iSNDstreamisheld;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamisheld
iSNDstreamisheld:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	S;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	#.set	volatile
	lbu	$3,23($17)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,0($17)
	sll	$2,$2,2
	addu	$16,$3,$2
	lw	$2,16($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	move	$2,$0
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,40($16)
	#.set	novolatile
	#nop
	sll	$2,$2,16
	.set	noreorder
	.set	nomacro
	bltz	$2,$L79
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	#.set	volatile
	lhu	$2,40($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L79
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,4($17)
	jal	STREAM_gettable
	move	$3,$2
	li	$2,3997696			# 0x003d0000
	ori	$2,$2,0x0900
	sltu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L83
	sll	$2,$3,5
	.set	macro
	.set	reorder

	li	$3,3997696			# 0x003d0000
	ori	$3,$3,0x0900
	sll	$2,$3,5
$L83:
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	lw	$3,16($16)
	sll	$2,$2,3
	divu	$2,$2,$3
	#.set	volatile
	lhu	$3,40($16)
	#.set	novolatile
	#nop
	sll	$3,$3,16
	sra	$3,$3,16
	sltu	$2,$2,$3
	bne	$2,$0,$L76
	.def	clear_threshold;	.val	$L77;	.scl	6;	.type	0x0;	.endef
$L77:
	sh	$0,40($16)
	.set	noreorder
	.set	nomacro
	j	$L79
	move	$2,$0
	.set	macro
	.set	reorder

	.def	check_state;	.val	$L76;	.scl	6;	.type	0x0;	.endef
$L76:
	lw	$4,4($17)
	jal	STREAM_state
	li	$3,2			# 0x00000002
	.set	noreorder
	.set	nomacro
	beq	$2,$3,$L77
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L79:
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
LM11:
	.end	iSNDstreamisheld
	.def	iSNDstreamhotroddatachunks;	.val	iSNDstreamhotroddatachunks;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDstreamhotroddatachunks
iSNDstreamhotroddatachunks:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$0
	sw	$21,36($sp)
	move	$21,$19
	lui	$2,%hi(sndss) # high
	sw	$20,32($sp)
	addiu	$20,$2,%lo(sndss) # low
	sw	$31,40($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
$L85:
	lw	$17,0($20)
	#nop
	beq	$17,$0,$L89
	lbu	$2,22($17)
	#nop
	beq	$2,$0,$L89
	#.set	volatile
	lbu	$2,20($17)
	#.set	novolatile
	li	$3,1			# 0x00000001
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$3,$L89
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamisheld
	move	$4,$17
	.set	macro
	.set	reorder

	bne	$2,$0,$L89
	#.set	volatile
	lbu	$3,23($17)
	#.set	novolatile
	#nop
	sll	$3,$3,24
	sra	$3,$3,24
	sll	$2,$3,1
	addu	$2,$2,$3
	sll	$2,$2,2
	subu	$2,$2,$3
	lw	$3,0($17)
	sll	$2,$2,2
	addu	$4,$3,$2
	lw	$2,36($4)
	#nop
	beq	$2,$0,$L89
	lw	$2,32($4)
	#nop
	beq	$2,$0,$L89
	#.set	volatile
	lw	$3,36($4)
	#.set	novolatile
	#.set	volatile
	lw	$2,32($4)
	#.set	novolatile
	lw	$4,12($17)
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_submitspace
	subu	$18,$3,$2
	.set	macro
	.set	reorder

	move	$16,$2
	slt	$2,$18,$16
	beq	$2,$0,$L99
	move	$16,$18
$L99:
	blez	$16,$L89
$L101:
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	STREAM_get
	addu	$16,$16,-1
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L103
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$2,4($5)
	#nop
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamparsedata
	addu	$19,$19,$2
	.set	macro
	.set	reorder

$L103:
	.set	noreorder
	.set	nomacro
	blez	$16,$L89
	slt	$2,$19,16384
	.set	macro
	.set	reorder

	bne	$2,$0,$L101
	.def	next;	.val	$L89;	.scl	6;	.type	0x0;	.endef
$L89:
	addu	$21,$21,1
	.set	noreorder
	.set	nomacro
	blez	$21,$L85
	addu	$20,$20,4
	.set	macro
	.set	reorder

	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM12:
	.end	iSNDstreamhotroddatachunks
	.def	PackedRate;	.scl	10;	.type	0x8;	.size	4;	.endef
	.def	word;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	4;	.scl	102;	.tag	PackedRate;	.size	4;	.endef
	.def	iSNDstreamservice;	.val	iSNDstreamservice;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	iSNDstreamservice
iSNDstreamservice:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDenteraudio
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$20,$0
	lui	$2,%hi(sndss) # high
	addiu	$19,$2,%lo(sndss) # low
$L109:
	lw	$16,0($19)
	#nop
	beq	$16,$0,$L115
	lbu	$2,22($16)
	#nop
	beq	$2,$0,$L115
	#.set	volatile
	lbu	$2,20($16)
	#.set	novolatile
	li	$3,2			# 0x00000002
	sll	$2,$2,24
	sra	$2,$2,24
	bne	$2,$3,$L113
	lw	$4,12($16)
	jal	SNDPKTPLAY_framesoutstanding
	bgtz	$2,$L115
	lwl	$8,35($16)
	lwr	$8,32($16)
	swl	$8,31($16)
	swr	$8,28($16)
	lw	$4,12($16)
	jal	SNDPKTPLAY_stop
	addu	$5,$16,28
	addu	$6,$16,36
	lw	$4,12($16)
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_start
	addu	$7,$16,76
	.set	macro
	.set	reorder

	sw	$2,8($16)
	li	$2,1			# 0x00000001
	sb	$2,20($16)
$L113:
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamisheld
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$0,$L115
	#.set	volatile
	lbu	$2,20($16)
	#.set	novolatile
	li	$3,1			# 0x00000001
	sll	$2,$2,24
	sra	$2,$2,24
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L117
	li	$17,10			# 0x0000000a
	.set	macro
	.set	reorder

	lw	$4,12($16)
	jal	SNDPKTPLAY_submitspace
	move	$17,$2
	beq	$17,$0,$L115
	.set	noreorder
	.set	nomacro
	j	$L120
	move	$18,$0
	.set	macro
	.set	reorder

$L117:
	move	$18,$0
$L120:
	lw	$4,4($16)
	.set	noreorder
	.set	nomacro
	jal	STREAM_get
	addu	$17,$17,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L123
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDstreamparsechunk
	move	$5,$2
	.set	macro
	.set	reorder

	move	$18,$2
$L123:
	beq	$18,$0,$L115
	bgtz	$17,$L120
	.def	next;	.val	$L115;	.scl	6;	.type	0x0;	.endef
$L115:
	addu	$20,$20,1
	.set	noreorder
	.set	nomacro
	blez	$20,$L109
	addu	$19,$19,4
	.set	macro
	.set	reorder

	jal	iSNDleaveaudio
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
LM13:
	.end	iSNDstreamservice
	.def	iSNDstreamnumcreated;	.val	iSNDstreamnumcreated;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamnumcreated
iSNDstreamnumcreated:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$5,$0
	move	$4,$5
	lui	$2,%hi(sndss) # high
	addiu	$3,$2,%lo(sndss) # low
$L131:
	lw	$2,0($3)
	#nop
	beq	$2,$0,$L130
	addu	$5,$5,1
$L130:
	addu	$4,$4,1
	.set	noreorder
	.set	nomacro
	blez	$4,$L131
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder


	.loc	1 0
LM14:
	.end	iSNDstreamnumcreated
	.def	Prio5;	.scl	10;	.type	0x8;	.size	20;	.endef
	.def	w;	.val	0;	.scl	8;	.dim	5;	.size	20;	.type	0x34;	.endef
	.def	.eos;	.val	20;	.scl	102;	.tag	Prio5;	.size	20;	.endef
	.def	iSNDstreamcreate;	.val	iSNDstreamcreate;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamcreate
iSNDstreamcreate:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	priority;	.val	30;	.scl	17;	.type	0x14;	.endef
	.def	numReq;	.val	21;	.scl	17;	.type	0x4;	.endef
	.def	pktArg;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	objbuf;	.val	18;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	extHandle;	.val	20;	.scl	9;	.type	0x4;	.endef
	.def	extFlag;	.val	24;	.scl	9;	.type	0x4;	.endef
	.def	extHandle;	.val	2;	.scl	4;	.type	0x4;	.endef
	.def	extFlag;	.val	23;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,64
	lui	$2,%hi(sndgs+60) # high
	sw	$19,36($sp)
	lw	$19,80($sp)
	lb	$2,%lo(sndgs+60)($2)
	sw	$23,52($sp)
	lw	$23,88($sp)
	sw	$fp,56($sp)
	move	$fp,$4
	sw	$21,44($sp)
	move	$21,$5
	sw	$22,48($sp)
	move	$22,$6
	sw	$18,32($sp)
	move	$18,$7
	sw	$31,60($sp)
	sw	$20,40($sp)
	sw	$17,28($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L135
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L147
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L135:
	move	$5,$0
	lui	$2,%hi(sndss) # high
	addiu	$3,$2,%lo(sndss) # low
$L139:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L141
	move	$17,$18
	.set	macro
	.set	reorder

	addu	$5,$5,1
	.set	noreorder
	.set	nomacro
	blez	$5,$L139
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L147
	li	$2,-9			# 0xfffffff7
	.set	macro
	.set	reorder

	.def	found;	.val	$L141;	.scl	6;	.type	0x0;	.endef
$L141:
	addu	$18,$17,96
	addu	$19,$19,-96
	sll	$2,$21,1
	addu	$2,$2,$21
	sll	$2,$2,2
	subu	$2,$2,$21
	sll	$2,$2,2
	sw	$18,0($17)
	addu	$18,$18,$2
	subu	$19,$19,$2
	move	$4,$22
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_overhead
	move	$20,$5
	.set	macro
	.set	reorder

	move	$16,$18
	addu	$18,$18,$2
	subu	$19,$19,$2
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_overhead
	move	$4,$22
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$2
	lui	$6,%hi(iSNDstreamreleasecallback) # high
	addiu	$6,$6,%lo(iSNDstreamreleasecallback) # low
	lui	$7,%hi(iSNDstreamnotifycallback) # high
	.set	noreorder
	.set	nomacro
	jal	SNDPKTPLAY_create
	addiu	$7,$7,%lo(iSNDstreamnotifycallback) # low
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,12($17)
	#.set	novolatile
	#.set	volatile
	lw	$2,12($17)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bgez	$2,$L143
	lui	$2,%hi(sndss) # high
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$2,12($17)
	#.set	novolatile
	j	$L147
$L143:
	#.set	volatile
	lw	$3,12($17)
	#.set	novolatile
	addiu	$2,$2,%lo(sndss) # low
	addu	$3,$3,$2
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L144
	sb	$20,4($3)
	.set	macro
	.set	reorder

	lw	$2,84($sp)
	#nop
	sw	$2,4($17)
	li	$2,1			# 0x00000001
	#.set	volatile
	sb	$2,24($17)
	#.set	novolatile
	.set	noreorder
	.set	nomacro
	j	$L148
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L144:
	addu	$4,$21,1
	li	$5,1			# 0x00000001
	move	$6,$5
	move	$7,$18
	.set	noreorder
	.set	nomacro
	jal	STREAM_create
	sw	$19,16($sp)
	.set	macro
	.set	reorder

	sw	$2,4($17)
	move	$4,$2
	#.set	volatile
	sb	$0,24($17)
	#.set	novolatile
	jal	STREAM_buffersize
	li	$3,1431633920			# 0x55550000
	ori	$3,$3,0x5556
	mult	$2,$3
	sra	$2,$2,31
	lw	$4,4($17)
	mfhi	$8
	#nop
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_setgreedylevel
	subu	$5,$8,$2
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
$L148:
	sw	$0,16($17)
	sw	$2,8($17)
	sb	$21,21($17)
	lw	$9,0($fp)
	lw	$10,4($fp)
	lw	$11,8($fp)
	lw	$8,12($fp)
	sw	$9,76($17)
	sw	$10,80($17)
	sw	$11,84($17)
	sw	$8,88($17)
	lw	$9,16($fp)
	sw	$9,92($17)
	jal	iSNDstreamnumcreated
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L149
	lui	$3,%hi(sndss) # high
	.set	macro
	.set	reorder

	lui	$4,%hi(iSNDstreamservice) # high
	.set	noreorder
	.set	nomacro
	jal	iSNDserveraddclient
	addiu	$4,$4,%lo(iSNDstreamservice) # low
	.set	macro
	.set	reorder

	lui	$3,%hi(sndgs+136) # high
	lui	$2,%hi(iSNDstreamdestroyall) # high
	addiu	$2,$2,%lo(iSNDstreamdestroyall) # low
	sw	$2,%lo(sndgs+136)($3)
	lui	$3,%hi(sndss) # high
$L149:
	addiu	$3,$3,%lo(sndss) # low
	sll	$2,$20,2
	addu	$2,$2,$3
	sw	$17,0($2)
	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_purge
	move	$4,$20
	.set	macro
	.set	reorder

	move	$2,$20
$L147:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM15:
	.end	iSNDstreamcreate
	.def	iSNDstreamqueue;	.val	iSNDstreamqueue;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamqueue
iSNDstreamqueue:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	s;	.val	21;	.scl	17;	.type	0xe;	.endef
	.def	name;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	filename;	.val	19;	.scl	17;	.type	0x12;	.endef
	.def	off;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	mode;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	mode;	.val	18;	.scl	4;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,48
	sw	$18,24($sp)
	lw	$18,64($sp)
	sw	$21,36($sp)
	move	$21,$4
	sw	$22,40($sp)
	move	$22,$5
	sw	$19,28($sp)
	move	$19,$6
	sw	$20,32($sp)
	move	$20,$7
	sw	$31,44($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L151
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L160
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L151:
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamgetstreamptr
	move	$4,$21
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L160
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	lbu	$3,22($17)
	lbu	$2,21($17)
	sll	$3,$3,24
	sll	$2,$2,24
	slt	$3,$3,$2
	bne	$3,$0,$L153
	jal	iSNDleaveaudio
	.set	noreorder
	.set	nomacro
	j	$L160
	li	$2,-13			# 0xfffffff3
	.set	macro
	.set	reorder

$L153:
	#.set	volatile
	lbu	$2,22($17)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sll	$3,$2,1
	addu	$3,$3,$2
	sll	$3,$3,2
	subu	$3,$3,$2
	lw	$2,0($17)
	sll	$3,$3,2
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L154
	addu	$16,$2,$3
	.set	macro
	.set	reorder

	move	$5,$19
	move	$6,$20
	li	$7,1816461312			# 0x6c450000
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	STREAM_queuefile
	ori	$7,$7,0x4353
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,0($16)
	#.set	novolatile
	j	$L155
$L154:
	li	$2,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L156
	move	$5,$19
	.set	macro
	.set	reorder

	move	$6,$0
	li	$7,1816461312			# 0x6c450000
	lw	$4,4($17)
	.set	noreorder
	.set	nomacro
	jal	STREAM_queuemem
	ori	$7,$7,0x4353
	.set	macro
	.set	reorder

	#.set	volatile
	sw	$2,0($16)
	#.set	novolatile
	j	$L155
$L156:
	#.set	volatile
	sw	$20,0($16)
	#.set	novolatile
$L155:
	lw	$2,0($16)
	#nop
	bne	$2,$0,$L158
	jal	iSNDleaveaudio
	.set	noreorder
	.set	nomacro
	j	$L160
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L158:
	#.set	volatile
	lw	$2,16($17)
	#.set	novolatile
	#nop
	addu	$2,$2,256
	#.set	volatile
	sw	$2,16($17)
	#.set	novolatile
	#.set	volatile
	lw	$2,16($17)
	#.set	novolatile
	#nop
	bgez	$2,$L159
	#.set	volatile
	sw	$0,16($17)
	#.set	novolatile
$L159:
	#.set	volatile
	lw	$2,16($17)
	#.set	novolatile
	#nop
	or	$2,$2,$21
	#.set	volatile
	sw	$2,4($16)
	#.set	novolatile
	#.set	volatile
	sh	$22,40($16)
	#.set	novolatile
	lbu	$2,22($17)
	#nop
	addu	$2,$2,1
	sb	$2,22($17)
	li	$2,-1			# 0xffffffff
	sw	$0,16($16)
	sw	$2,8($16)
	sw	$2,12($16)
	sw	$0,20($16)
	sw	$0,28($16)
	sw	$0,32($16)
	#.set	volatile
	sw	$0,36($16)
	#.set	novolatile
	jal	iSNDleaveaudio
	lw	$2,4($16)
$L160:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder


	.loc	1 0
LM16:
	.end	iSNDstreamqueue
