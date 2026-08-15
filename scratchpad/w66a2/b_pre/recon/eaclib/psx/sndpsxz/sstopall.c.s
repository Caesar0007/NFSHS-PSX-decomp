	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sstopall.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	SNDstopall

	.text
	.def	SNDstopall;	.val	SNDstopall;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	SNDstopall
SNDstopall:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	lui	$2,%hi(sndgs) # high
	addiu	$3,$2,%lo(sndgs) # low
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lbu	$2,17($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	move	$16,$0
	.set	macro
	.set	reorder

	move	$18,$3
	move	$17,$16
$L3:
	lw	$2,148($18)
	#nop
	addu	$2,$17,$2
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	jal	SNDstop
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lbu	$2,17($18)
	#nop
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	addu	$17,$17,100
	.set	macro
	.set	reorder

$L2:
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
LM1:
	.end	SNDstopall
