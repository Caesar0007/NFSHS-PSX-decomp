	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sbdload.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDdownloadbank

	.text
	.def	iSNDdownloadbank;	.val	iSNDdownloadbank;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDdownloadbank
iSNDdownloadbank:
	.frame	$sp,2104,$31		# vars= 2048, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.def	bankData;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	patchData;	.val	4;	.scl	9;	.type	0x4;	.endef
	subu	$sp,$sp,2104
	sw	$20,2080($sp)
	move	$20,$4
	sw	$22,2088($sp)
	li	$22,7			# 0x00000007
	li	$3,-1			# 0xffffffff
	sw	$16,2064($sp)
	li	$16,255			# 0x000000ff
	addu	$2,$sp,2056
	sw	$31,2100($sp)
	sw	$fp,2096($sp)
	sw	$23,2092($sp)
	sw	$21,2084($sp)
	sw	$19,2076($sp)
	sw	$18,2072($sp)
	sw	$17,2068($sp)
	sw	$5,2108($sp)
$L2:
	sw	$3,0($2)
	addu	$16,$16,-1
	.set	noreorder
	.set	nomacro
	bgez	$16,$L2
	addu	$2,$2,-8
	.set	macro
	.set	reorder

	move	$fp,$20
 #APP
 #NO_APP
	lhu	$2,6($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L10
	move	$16,$0
	.set	macro
	.set	reorder

	li	$23,4			# 0x00000004
	li	$21,12			# 0x0000000c
	move	$18,$20
	li	$19,20			# 0x00000014
	move	$17,$20
$L11:
	lbu	$2,4($20)
	#nop
	bne	$2,$23,$L14
	lw	$2,20($17)
	j	$L15
$L14:
	lw	$2,12($18)
$L15:
	beq	$2,$0,$L16
	lbu	$2,4($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$23,$L17
	addu	$2,$fp,$21
	.set	macro
	.set	reorder

	lw	$3,20($17)
	addu	$2,$20,$19
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$L18
	sw	$2,20($17)
	.set	macro
	.set	reorder

$L17:
	lw	$3,12($18)
	#nop
	addu	$2,$2,$3
	sw	$2,12($18)
$L18:
	move	$4,$2
	lw	$5,2108($sp)
	.set	noreorder
	.set	nomacro
	jal	iSNDresolvetaggedpatch
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	li	$3,7			# 0x00000007
	beq	$2,$3,$L16
	li	$22,8			# 0x00000008
$L16:
	addu	$21,$21,4
	addu	$18,$18,4
	addu	$19,$19,4
	lhu	$2,6($20)
	addu	$16,$16,1
	slt	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$17,$17,4
	.set	macro
	.set	reorder

$L10:
	move	$2,$22
	lw	$31,2100($sp)
	lw	$fp,2096($sp)
	lw	$23,2092($sp)
	lw	$22,2088($sp)
	lw	$21,2084($sp)
	lw	$20,2080($sp)
	lw	$19,2076($sp)
	lw	$18,2072($sp)
	lw	$17,2068($sp)
	lw	$16,2064($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,2104
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDdownloadbank
