	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\resize.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	resizememadr

	.extern	gMemClassTable, 64

	.text
	.def	MemBlock;	.scl	13;	.tag	MemBlock;	.size	0;	.type	0x8;	.endef
	.def	MemClass;	.scl	13;	.tag	MemClass;	.size	0;	.type	0x8;	.endef
	.def	resizememadr;	.val	resizememadr;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	resizememadr
resizememadr:
	.frame	$sp,64,$31		# vars= 0, regs= 8/0, args= 32, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.def	userptr;	.val	22;	.scl	17;	.type	0x11;	.endef
	.def	newsize;	.val	5;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,64
	sw	$22,56($sp)
	move	$22,$4
	sw	$20,48($sp)
	sw	$19,44($sp)
	addu	$19,$22,-16
	lui	$2,%hi(gMemClassTable) # high
	addiu	$2,$2,%lo(gMemClassTable) # low
	sw	$31,60($sp)
	sw	$21,52($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	lhu	$17,2($19)
	lw	$18,8($19)
	andi	$3,$17,0x000f
	sll	$3,$3,2
	addu	$3,$3,$2
	lhu	$4,2($18)
	lw	$21,0($3)
	andi	$4,$4,0x4000
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	move	$20,$5
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	FREE_remove
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$18,8($18)
	#nop
	sw	$18,8($19)
$L2:
	move	$16,$20
	slt	$2,$16,8
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

	bne	$16,$2,$L4
	.set	noreorder
	.set	nomacro
	j	$L3
	li	$16,1073741824			# 0x40000000
	.set	macro
	.set	reorder

$L4:
	bltz	$16,$L3
	li	$16,8			# 0x00000008
$L3:
	.set	noreorder
	.set	nomacro
	jal	getblockname
	move	$4,$22
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	MEM_tailsize
	move	$5,$17
	.set	macro
	.set	reorder

	move	$6,$2
 #APP
 #NO_APP
	lw	$3,40($21)
	addu	$2,$16,$6
	addu	$4,$3,15
	addu	$2,$2,$4
	subu	$3,$0,$3
	and	$2,$2,$3
	addu	$16,$2,-16
	subu	$2,$18,$19
	addu	$17,$2,-16
	slt	$2,$17,$16
	beq	$2,$0,$L7
	move	$16,$17
	subu	$20,$17,$6
$L7:
	lw	$4,4($19)
	addu	$5,$22,$20
	.set	noreorder
	.set	nomacro
	jal	blockmove
	addu	$4,$22,$4
	.set	macro
	.set	reorder

	subu	$2,$17,$16
	slt	$2,$2,65
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	sw	$20,4($19)
	.set	macro
	.set	reorder

	addu	$16,$16,16
	addu	$16,$22,$16
	move	$4,$16
	move	$5,$0
	move	$6,$5
	move	$7,$5
	sw	$0,16($sp)
	sw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	jal	initmemblock
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	move	$4,$21
	.set	noreorder
	.set	nomacro
	jal	FREE_add
	move	$5,$16
	.set	macro
	.set	reorder

	sw	$16,12($18)
	sw	$16,8($19)
$L8:
	move	$2,$22
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	resizememadr
