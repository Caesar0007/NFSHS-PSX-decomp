	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\sndpsxz\\sdresolv.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	iSNDplatformresolve
	.align	2
	.globl	iSNDplatformremove

	.text
	.def	SNDResolveEntry;	.scl	10;	.type	0x8;	.size	8;	.endef
	.def	offset;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	spu;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	8;	.scl	102;	.tag	SNDResolveEntry;	.size	8;	.endef
	.def	iSNDplatformresolve;	.val	iSNDplatformresolve;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformresolve
iSNDplatformresolve:
	.frame	$sp,72,$31		# vars= 16, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	.def	cursor;	.val	0;	.scl	9;	.type	0x4;	.endef
	.def	bank;	.val	22;	.scl	17;	.type	0x4;	.endef
	.def	patch;	.val	23;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,72
	sw	$22,56($sp)
	move	$22,$5
	sw	$23,60($sp)
	move	$23,$6
	sw	$17,36($sp)
	move	$17,$0
	sw	$21,52($sp)
	li	$21,1			# 0x00000001
	sw	$19,44($sp)
	move	$19,$17
	sw	$20,48($sp)
	move	$20,$17
	sw	$18,40($sp)
	move	$18,$17
	sw	$31,64($sp)
	sw	$16,32($sp)
	sw	$4,72($sp)
	addu	$4,$sp,72
$L33:
	addu	$5,$sp,16
$L35:
	addu	$6,$sp,20
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	li	$2,254			# 0x000000fe
	.set	macro
	.set	reorder

	lw	$3,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L3
	li	$2,128			# 0x00000080
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L33
	addu	$4,$sp,72
	.set	macro
	.set	reorder

	li	$2,136			# 0x00000088
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L8
	li	$2,138			# 0x0000008a
	.set	macro
	.set	reorder

	lw	$19,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L8:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L10
	li	$2,130			# 0x00000082
	.set	macro
	.set	reorder

	lw	$20,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L33
	addu	$4,$sp,72
	.set	macro
	.set	reorder

$L10:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L12
	li	$2,133			# 0x00000085
	.set	macro
	.set	reorder

	lw	$21,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L33
	addu	$4,$sp,72
	.set	macro
	.set	reorder

$L12:
	.set	noreorder
	.set	nomacro
	bne	$3,$2,$L33
	addu	$4,$sp,72
	.set	macro
	.set	reorder

	lw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	j	$L35
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L3:
	.set	noreorder
	.set	nomacro
	beq	$22,$0,$L15
	sll	$2,$18,3
	.set	macro
	.set	reorder

	addu	$4,$2,$23
	#.set	volatile
	lw	$3,0($4)
	#.set	novolatile
	li	$2,-1			# 0xffffffff
	beq	$3,$2,$L23
	move	$5,$2
	move	$3,$4
$L17:
	move	$4,$3
 #APP
 #NO_APP
	#.set	volatile
	lw	$2,0($4)
	#.set	novolatile
	#nop
	beq	$2,$19,$L21
	addu	$3,$4,8
	#.set	volatile
	lw	$2,8($4)
	#.set	novolatile
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L17
	addu	$18,$18,1
	.set	macro
	.set	reorder

	.def	checked;	.val	$L23;	.scl	6;	.type	0x0;	.endef
$L23:
	lw	$2,0($20)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L32
	li	$2,7			# 0x00000007
	.set	macro
	.set	reorder

	li	$2,-1840709632			# 0x92490000
	ori	$2,$2,0x2493
	mult	$17,$2
	sra	$3,$17,31
	mfhi	$8
	#nop
	#nop
	addu	$2,$8,$17
	sra	$2,$2,4
	subu	$16,$2,$3
	sll	$2,$16,3
	subu	$2,$2,$16
	sll	$2,$2,2
	.set	noreorder
	.set	nomacro
	beq	$17,$2,$L34
	sll	$2,$21,4
	.set	macro
	.set	reorder

	addu	$16,$16,1
$L34:
	mult	$16,$2
	mflo	$16
	#nop
	.set	noreorder
	.set	nomacro
	jal	iSNDpsxmalloc
	move	$4,$16
	.set	macro
	.set	reorder

	move	$17,$2
	.set	noreorder
	.set	nomacro
	bne	$17,$0,$L27
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L32
	li	$2,-6			# 0xfffffffa
	.set	macro
	.set	reorder

	.def	found;	.val	$L21;	.scl	6;	.type	0x0;	.endef
$L21:
	lw	$2,4($3)
	.set	noreorder
	.set	nomacro
	j	$L23
	sw	$2,0($20)
	.set	macro
	.set	reorder

	.def	resolve;	.val	$L27;	.scl	6;	.type	0x0;	.endef
$L27:
	addu	$4,$22,$19
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	iSNDdmqueuesplit
	li	$7,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$16,$2
	sll	$2,$18,3
	addu	$2,$2,$23
	sw	$17,0($20)
	sw	$19,0($2)
	sw	$17,4($2)
$L30:
	.set	noreorder
	.set	nomacro
	jal	iSNDdmcomplete
	move	$4,$16
	.set	macro
	.set	reorder

	beq	$2,$0,$L30
$L15:
	li	$2,7			# 0x00000007
$L32:
	lw	$31,64($sp)
	lw	$23,60($sp)
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
	addu	$sp,$sp,72
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	iSNDplatformresolve
	.def	iSNDplatformremove;	.val	iSNDplatformremove;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	iSNDplatformremove
iSNDplatformremove:
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	cursor;	.val	0;	.scl	9;	.type	0x4;	.endef
	.def	patch;	.val	17;	.scl	17;	.type	0x14;	.endef
	subu	$sp,$sp,56
	sw	$17,36($sp)
	move	$17,$5
	sw	$16,32($sp)
	move	$16,$0
	sw	$19,44($sp)
	li	$19,254			# 0x000000fe
	sw	$18,40($sp)
	li	$18,138			# 0x0000008a
	sw	$31,48($sp)
	sw	$4,56($sp)
	addu	$4,$sp,56
$L50:
	addu	$5,$sp,16
$L53:
	addu	$6,$sp,20
	.set	noreorder
	.set	nomacro
	jal	iSNDgettag
	addu	$7,$sp,24
	.set	macro
	.set	reorder

	beq	$2,$0,$L38
	lw	$2,16($sp)
	#nop
	beq	$2,$19,$L38
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L50
	addu	$4,$sp,56
	.set	macro
	.set	reorder

	lw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	j	$L53
	addu	$5,$sp,16
	.set	macro
	.set	reorder

$L38:
	lw	$3,0($17)
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L42
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$5,0($16)
	move	$6,$2
	move	$3,$17
	lw	$2,0($3)
$L52:
	.set	noreorder
	.set	nomacro
	beq	$2,$5,$L48
	addu	$3,$3,8
	.set	macro
	.set	reorder

	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$6,$L52
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L42:
	sll	$2,$4,3
	lw	$3,0($16)
	addu	$2,$2,$17
	sw	$3,0($2)
	lw	$4,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L51
	move	$2,$0
	.set	macro
	.set	reorder

	jal	iSNDpsxfree
$L48:
	move	$2,$0
$L51:
	lw	$31,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	iSNDplatformremove
