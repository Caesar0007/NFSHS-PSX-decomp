	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstgetrp.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDstreamgetrequestptr

	.text
	.def	iSNDstreamgetrequestptr;	.val	iSNDstreamgetrequestptr;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDstreamgetrequestptr
iSNDstreamgetrequestptr:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	idx;	.val	16;	.scl	17;	.type	0xe;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	bltz	$16,$L11
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	iSNDstreamgetstreamptr
	andi	$4,$16,0x00ff
	.set	macro
	.set	reorder

	move	$5,$2
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L10
	move	$2,$0
	.set	macro
	.set	reorder

	lbu	$2,22($5)
	#nop
	sll	$2,$2,24
	.set	noreorder
	.set	nomacro
	blez	$2,$L11
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$3,0($5)
$L5:
	lw	$2,4($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$16,$L8
	move	$2,$3
	.set	macro
	.set	reorder

	addu	$3,$3,44
	#.set	volatile
	lbu	$2,22($5)
	#.set	novolatile
	addu	$4,$4,1
	sll	$2,$2,24
	sra	$2,$2,24
	slt	$2,$4,$2
	bne	$2,$0,$L5
$L11:
	move	$2,$0
$L8:
$L10:
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
	.end	iSNDstreamgetrequestptr
