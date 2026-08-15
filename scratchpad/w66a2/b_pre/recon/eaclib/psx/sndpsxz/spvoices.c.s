	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\spvoices.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_create
	.align	2
	.globl	SNDSTRM_destroy
	.align	2
	.globl	SNDSTRM_queuefile
	.align	2
	.globl	SNDSTRM_purge

	.text
	.def	SNDSTRM_create;	.val	SNDSTRM_create;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_create
SNDSTRM_create:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 32, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	priority;	.val	4;	.scl	17;	.type	0x14;	.endef
	.def	numReq;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	pktArg;	.val	6;	.scl	17;	.type	0x4;	.endef
	.def	objbuf;	.val	7;	.scl	17;	.type	0x4;	.endef
	.def	memsize;	.val	16;	.scl	9;	.type	0x4;	.endef
	.def	memsize;	.val	2;	.scl	4;	.type	0x4;	.endef
	subu	$sp,$sp,40
	lw	$2,56($sp)
	sw	$31,32($sp)
	sw	$0,20($sp)
	sw	$0,24($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamcreate
	sw	$2,16($sp)
	.set	macro
	.set	reorder

	lw	$31,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDSTRM_create
	.def	SNDSTRM_destroy;	.val	SNDSTRM_destroy;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_destroy
SNDSTRM_destroy:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	s;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(sndgs) # low
	sw	$31,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lb	$2,60($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	move	$17,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L7
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamgetstreamptr
	move	$4,$17
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L7
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SNDSTRM_purge
	move	$4,$17
	.set	macro
	.set	reorder

	jal	iSNDstreamnumcreated
	li	$3,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	bne	$2,$3,$L5
	lui	$4,%hi(iSNDstreamservice) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDserverremoveclient
	addiu	$4,$4,%lo(iSNDstreamservice) # low
	.set	macro
	.set	reorder

	sw	$0,136($18)
$L5:
	lw	$4,12($16)
	jal	SNDPKTPLAY_destroy
	lbu	$2,24($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	lui	$3,%hi(sndss) # high
	.set	macro
	.set	reorder

	lw	$4,4($16)
	jal	STREAM_destroy
	lui	$3,%hi(sndss) # high
$L8:
	addiu	$3,$3,%lo(sndss) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	sw	$0,0($2)
	move	$2,$0
$L7:
	lw	$31,28($sp)
	lw	$18,24($sp)
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
	.end	SNDSTRM_destroy
	.def	SNDSTRM_queuefile;	.val	SNDSTRM_queuefile;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_queuefile
SNDSTRM_queuefile:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0xe;	.endef
	.def	name;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	filename;	.val	6;	.scl	17;	.type	0x12;	.endef
	.def	off;	.val	7;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamqueue
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder


	.loc	1 0
LM3:
	.end	SNDSTRM_queuefile
	.def	SNDSTRM_purge;	.val	SNDSTRM_purge;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_purge
SNDSTRM_purge:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	s;	.val	4;	.scl	17;	.type	0x4;	.endef
	lui	$2,%hi(sndgs+60) # high
	lb	$2,%lo(sndgs+60)($2)
	subu	$sp,$sp,24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L16
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L11:
	jal	iSNDstreamgetstreamptr
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L16
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	.set	noreorder
	.set	nomacro
	bltz	$2,$L18
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	lw	$4,12($16)
	jal	SNDPKTPLAY_stop
	li	$2,-1			# 0xffffffff
$L18:
	#.set	volatile
	sw	$2,8($16)
	#.set	novolatile
	#.set	volatile
	lbu	$2,24($16)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	addu	$4,$16,28
	.set	macro
	.set	reorder

	lw	$4,4($16)
	jal	STREAM_kill
	addu	$4,$16,28
$L19:
	move	$5,$0
	li	$6,4			# 0x00000004
	#.set	volatile
	sb	$0,22($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,23($16)
	#.set	novolatile
	#.set	volatile
	sb	$0,20($16)
	#.set	novolatile
	jal	memset
	addu	$4,$16,32
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,4			# 0x00000004
	.set	macro
	.set	reorder

	addu	$4,$16,36
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	addu	$4,$16,56
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	memset
	li	$6,20			# 0x00000014
	.set	macro
	.set	reorder

	move	$2,$0
$L16:
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
	.end	SNDSTRM_purge
