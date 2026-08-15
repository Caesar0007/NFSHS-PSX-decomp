	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\unbtree.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	unbtree

	.comm	SQVs,4

	.comm	SQVd,4

	.comm	SQVclue,4

	.comm	SQVleft,4

	.comm	SQVright,4

	.text
	.def	unbtree;	.val	unbtree;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	unbtree
unbtree:
	.frame	$sp,800,$31		# vars= 768, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.def	src;	.val	4;	.scl	17;	.type	0x1c;	.endef
	.def	dst;	.val	5;	.scl	17;	.type	0x1c;	.endef
	subu	$sp,$sp,800
	sw	$17,788($sp)
	addu	$2,$sp,16
	sw	$2,SQVclue
	addu	$2,$sp,272
	sw	$2,SQVleft
	addu	$2,$sp,528
	sw	$31,792($sp)
	sw	$16,784($sp)
	sw	$4,SQVs
	sw	$5,SQVd
	sw	$2,SQVright
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L2
	move	$17,$0
	.set	macro
	.set	reorder

	lbu	$5,0($4)
	addu	$2,$4,1
	sw	$2,SQVs
	lbu	$3,1($4)
	addu	$2,$4,2
	sw	$2,SQVs
	sll	$2,$5,8
	addu	$5,$2,$3
	li	$2,18427			# 0x000047fb
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L3
	addu	$2,$4,5
	.set	macro
	.set	reorder

	sw	$2,SQVs
$L3:
	lw	$2,SQVs
	move	$5,$0
	lbu	$17,0($2)
	addu	$2,$2,1
	sw	$2,SQVs
	lbu	$4,0($2)
	addu	$3,$2,1
	sw	$3,SQVs
	lbu	$3,1($2)
	addu	$2,$2,2
	sw	$2,SQVs
	sll	$2,$17,8
	addu	$17,$2,$4
	sll	$2,$17,8
	addu	$17,$2,$3
$L4:
	lw	$2,SQVclue
	#nop
	addu	$2,$2,$5
	addu	$5,$5,1
	sb	$0,0($2)
	slt	$2,$5,256
	bne	$2,$0,$L4
	lw	$2,SQVs
	lw	$3,SQVclue
	lbu	$4,0($2)
	addu	$2,$2,1
	sw	$2,SQVs
	li	$2,1			# 0x00000001
	addu	$3,$3,$4
	sb	$2,0($3)
	lw	$2,SQVs
	#nop
	lbu	$6,0($2)
	addu	$2,$2,1
	sw	$2,SQVs
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L12
	move	$5,$0
	.set	macro
	.set	reorder

	li	$7,-1			# 0xffffffff
	addu	$5,$5,1
$L20:
	lw	$3,SQVs
	lw	$2,SQVleft
	lbu	$16,0($3)
	addu	$3,$3,1
	sw	$3,SQVs
	lbu	$4,0($3)
	addu	$2,$2,$16
	sb	$4,0($2)
	addu	$2,$3,1
	sw	$2,SQVs
	lw	$2,SQVright
	lbu	$4,1($3)
	addu	$2,$2,$16
	sb	$4,0($2)
	lw	$2,SQVclue
	addu	$3,$3,2
	sw	$3,SQVs
	addu	$2,$2,$16
	sb	$7,0($2)
	slt	$2,$5,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L20
	addu	$5,$5,1
	.set	macro
	.set	reorder

	addu	$5,$5,-1
$L12:
	lw	$3,SQVs
	lw	$2,SQVclue
	lbu	$16,0($3)
	addu	$3,$3,1
	sw	$3,SQVs
	addu	$2,$2,$16
	lb	$2,0($2)
	#nop
	beq	$2,$0,$L16
	.set	noreorder
	.set	nomacro
	bgez	$2,$L17
	addu	$2,$3,1
	.set	macro
	.set	reorder

	lw	$2,SQVleft
	#nop
	addu	$2,$2,$16
	lbu	$4,0($2)
	jal	chase
	lw	$2,SQVright
	#nop
	addu	$2,$2,$16
	lbu	$4,0($2)
	jal	chase
	j	$L12
$L17:
	lbu	$16,0($3)
	sw	$2,SQVs
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L21
	move	$2,$17
	.set	macro
	.set	reorder

$L16:
	lw	$2,SQVd
	#nop
	sb	$16,0($2)
	addu	$2,$2,1
	sw	$2,SQVd
	j	$L12
$L2:
	move	$2,$17
$L21:
	lw	$31,792($sp)
	lw	$17,788($sp)
	lw	$16,784($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,800
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	unbtree
	.def	SQVs;	.val	SQVs;	.scl	2;	.type	0x4;	.endef
	.def	SQVd;	.val	SQVd;	.scl	2;	.type	0x1c;	.endef
	.def	SQVclue;	.val	SQVclue;	.scl	2;	.type	0x4;	.endef
	.def	SQVleft;	.val	SQVleft;	.scl	2;	.type	0x4;	.endef
	.def	SQVright;	.val	SQVright;	.scl	2;	.type	0x4;	.endef
