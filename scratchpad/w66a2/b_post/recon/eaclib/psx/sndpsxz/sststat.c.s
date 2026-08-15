	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sststat.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_status

	.text
	.def	SNDSTRM_status;	.val	SNDSTRM_status;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_status
SNDSTRM_status:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	tag;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	s;	.val	17;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$5
	lui	$2,%hi(sndgs+60) # high
	sw	$31,24($sp)
	sw	$16,16($sp)
	sw	$0,8($17)
	sw	$0,4($17)
	sw	$0,0($17)
	lb	$2,%lo(sndgs+60)($2)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

	jal	iSNDstreamgetstreamptr
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L6
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	#.set	volatile
	lbu	$2,22($16)
	#.set	novolatile
	#nop
	sll	$2,$2,24
	sra	$2,$2,24
	sw	$2,0($17)
	lbu	$2,22($16)
	#nop
	beq	$2,$0,$L4
	lw	$2,0($16)
	#nop
	lw	$2,4($2)
	#nop
	sw	$2,4($17)
	lhu	$2,28($16)
	#nop
	beq	$2,$0,$L4
	lw	$4,12($16)
	jal	SNDPKTPLAY_unsafeframesoutstanding
	sll	$3,$2,5
	subu	$3,$3,$2
	sll	$3,$3,2
	addu	$3,$3,$2
	lhu	$2,28($16)
	sll	$3,$3,3
	divu	$3,$3,$2
	sw	$3,8($17)
$L4:
	jal	iSNDleaveaudio
	move	$2,$0
$L6:
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
LM1:
	.end	SNDSTRM_status
