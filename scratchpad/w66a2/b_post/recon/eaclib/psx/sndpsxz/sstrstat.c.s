	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstrstat.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDSTRM_requeststatus

	.text
	.def	SNDSTRM_requeststatus;	.val	SNDSTRM_requeststatus;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	SNDSTRM_requeststatus
SNDSTRM_requeststatus:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.def	reqTag;	.val	16;	.scl	17;	.type	0xe;	.endef
	.def	s;	.val	18;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,40
	sw	$18,32($sp)
	move	$18,$5
	lui	$2,%hi(sndgs+60) # high
	sw	$31,36($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	sw	$0,0($18)
	sw	$0,4($18)
	sw	$0,8($18)
	sw	$0,12($18)
	lb	$2,%lo(sndgs+60)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$16,$4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L12
	li	$2,-10			# 0xfffffff6
	.set	macro
	.set	reorder

$L2:
	.set	noreorder
	.set	nomacro
	bltz	$16,$L12
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDstreamgetstreamptr
	andi	$4,$16,0x00ff
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	beq	$17,$0,$L12
	li	$2,-8			# 0xfffffff8
	.set	macro
	.set	reorder

	jal	iSNDenteraudio
	.set	noreorder
	.set	nomacro
	jal	iSNDstreamgetrequestptr
	move	$4,$16
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L6
	li	$2,3			# 0x00000003
	.set	macro
	.set	reorder

	lw	$2,8($16)
	#nop
	bgez	$2,$L7
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$0,0($18)
	.set	macro
	.set	reorder

$L7:
	lw	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L9
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$2,2			# 0x00000002
	sw	$2,0($18)
	lhu	$17,28($17)
	.set	noreorder
	.set	nomacro
	j	$L14
	addu	$4,$sp,16
	.set	macro
	.set	reorder

$L9:
	sw	$2,0($18)
	lhu	$17,32($17)
	addu	$4,$sp,16
$L14:
	lw	$5,20($16)
	.set	noreorder
	.set	nomacro
	jal	iSNDmulu64
	li	$6,1000			# 0x000003e8
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDdivu64
	move	$6,$17
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sw	$2,4($18)
	lw	$2,24($16)
	lw	$5,20($16)
	li	$6,1000			# 0x000003e8
	.set	noreorder
	.set	nomacro
	jal	iSNDmulu64
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	lw	$4,16($sp)
	lw	$5,20($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDdivu64
	move	$6,$17
	.set	macro
	.set	reorder

	sw	$2,8($18)
	lw	$3,28($16)
	#nop
	sll	$2,$3,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	divu	$2,$2,$17
	.set	noreorder
	.set	nomacro
	j	$L11
	sw	$2,12($18)
	.set	macro
	.set	reorder

	.def	no_request;	.val	$L6;	.scl	6;	.type	0x0;	.endef
$L6:
	sw	$2,0($18)
	.def	status_done;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	jal	iSNDleaveaudio
	move	$2,$0
$L12:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	SNDSTRM_requeststatus
