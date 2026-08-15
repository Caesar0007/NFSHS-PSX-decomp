	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libapi\\FIRST.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
 #APP
		.globl	_first_save
	.globl	_first_devname
	.section	.bss
	.align	2
_first_save:
	.space	8
_first_devname:
	.space	40
	.text
 #NO_APP
	.align	2
	.globl	firstfile
	.align	2
	.globl	_first_patch

	.extern	_first_save, 4

	.text
	.def	DCB;	.scl	10;	.type	0x8;	.size	80;	.endef
	.def	name;	.val	0;	.scl	8;	.type	0x12;	.endef
	.def	_r1;	.val	4;	.scl	8;	.dim	12;	.size	48;	.type	0x34;	.endef
	.def	firstfile;	.val	52;	.scl	8;	.type	0x11;	.endef
	.def	_r2;	.val	56;	.scl	8;	.dim	6;	.size	24;	.type	0x34;	.endef
	.def	.eos;	.val	80;	.scl	102;	.tag	DCB;	.size	80;	.endef
	.def	DCB;	.scl	13;	.tag	DCB;	.size	80;	.type	0x8;	.endef
	.def	FirstFn;	.scl	13;	.type	0x94;	.endef
	.def	firstfile;	.val	firstfile;	.scl	2;	.type	0x61;	.endef
	.text
	.ent	firstfile
firstfile:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	name;	.val	18;	.scl	17;	.type	0x12;	.endef
	.def	dir;	.val	19;	.scl	17;	.type	0x11;	.endef
	subu	$sp,$sp,40
	sw	$18,24($sp)
	move	$18,$4
	sw	$19,28($sp)
	move	$19,$5
	lui	$2,%hi(_first_devname) # high
	addiu	$4,$2,%lo(_first_devname) # low
	sw	$31,32($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lb	$2,0($18)
	#nop
	slt	$2,$2,59
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L3
	move	$3,$18
	.set	macro
	.set	reorder

$L4:
	lbu	$2,0($3)
	addu	$3,$3,1
	sb	$2,0($4)
	lb	$2,0($3)
	#nop
	slt	$2,$2,59
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L4
	addu	$4,$4,1
	.set	macro
	.set	reorder

$L3:
	sb	$0,0($4)
	lw	$3,340
	li	$2,-858993459			# 0xcccccccd
	multu	$3,$2
	lw	$16,336
	mfhi	$6
	#nop
	#nop
	srl	$3,$6,6
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$3,$16,$2
	sltu	$2,$16,$3
	beq	$2,$0,$L6
	move	$17,$3
	.def	scan1;	.val	$L7;	.scl	6;	.type	0x0;	.endef
$L7:
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L8
	lui	$5,%hi(_first_devname) # high
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addiu	$5,$5,%lo(_first_devname) # low
	.set	macro
	.set	reorder

	beq	$2,$0,$L9
$L8:
	addu	$16,$16,80
	sltu	$2,$16,$17
	bne	$2,$0,$L7
$L6:
	move	$3,$0
	.def	tested;	.val	$L11;	.scl	6;	.type	0x0;	.endef
$L11:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L13
	move	$2,$0
	.set	macro
	.set	reorder

	j	$L20
	.def	hit1;	.val	$L9;	.scl	6;	.type	0x0;	.endef
$L9:
	lw	$2,52($16)
	#nop
	sw	$2,_first_save
	.set	noreorder
	.set	nomacro
	j	$L11
	li	$3,1			# 0x00000001
	.set	macro
	.set	reorder

	.def	hit2;	.val	$L14;	.scl	6;	.type	0x0;	.endef
$L14:
 #APP
 #NO_APP
	lui	$2,%hi(_first_patch) # high
	addiu	$2,$2,%lo(_first_patch) # low
	.set	noreorder
	.set	nomacro
	j	$L15
	sw	$2,52($16)
	.set	macro
	.set	reorder

	.def	pass2;	.val	$L13;	.scl	6;	.type	0x0;	.endef
$L13:
	lw	$3,340
	li	$2,-858993459			# 0xcccccccd
	multu	$3,$2
	lw	$16,336
	mfhi	$6
	#nop
	#nop
	srl	$3,$6,6
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$3,$16,$2
	sltu	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L21
	move	$4,$18
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$17,$3
	.def	scan2;	.val	$L17;	.scl	6;	.type	0x0;	.endef
$L17:
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L18
	lui	$5,%hi(_first_devname) # high
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addiu	$5,$5,%lo(_first_devname) # low
	.set	macro
	.set	reorder

	beq	$2,$0,$L14
$L18:
	addu	$16,$16,80
	sltu	$2,$16,$17
	bne	$2,$0,$L17
	.def	tail;	.val	$L15;	.scl	6;	.type	0x0;	.endef
$L15:
	move	$4,$18
$L21:
	.set	noreorder
	.set	nomacro
	jal	firstfile2
	move	$5,$19
	.set	macro
	.set	reorder

$L20:
	lw	$31,32($sp)
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
LM1:
	.end	firstfile
	.def	_first_patch;	.val	_first_patch;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	_first_patch
_first_patch:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	.def	state;	.val	18;	.scl	17;	.type	0x14;	.endef
	.def	arg;	.val	20;	.scl	17;	.type	0x4;	.endef
	.def	arg2;	.val	21;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,48
	sw	$18,24($sp)
	move	$18,$4
	sw	$20,32($sp)
	move	$20,$5
	sw	$31,40($sp)
	sw	$21,36($sp)
	sw	$19,28($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	move	$21,$6
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
	sw	$2,0($18)
$L23:
	lw	$3,340
	li	$2,-858993459			# 0xcccccccd
	multu	$3,$2
	lw	$16,336
	lw	$19,_first_save
	mfhi	$7
	#nop
	#nop
	srl	$3,$7,6
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$2,$2,4
	addu	$3,$16,$2
	sltu	$2,$16,$3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L29
	move	$4,$18
	.set	macro
	.set	reorder

 #APP
 #NO_APP
	move	$17,$3
	.def	scan;	.val	$L25;	.scl	6;	.type	0x0;	.endef
$L25:
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L26
 #APP
 #NO_APP
	lui	$5,%hi(_first_devname) # high
	.set	noreorder
	.set	nomacro
	jal	strcmp
	addiu	$5,$5,%lo(_first_devname) # low
	.set	macro
	.set	reorder

	bne	$2,$0,$L26
	.set	noreorder
	.set	nomacro
	j	$L24
	sw	$19,52($16)
	.set	macro
	.set	reorder

$L26:
	addu	$16,$16,80
	sltu	$2,$16,$17
	bne	$2,$0,$L25
$L24:
	move	$4,$18
$L29:
	move	$5,$20
	lw	$2,_first_save
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	move	$6,$21
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
LM2:
	.end	_first_patch
