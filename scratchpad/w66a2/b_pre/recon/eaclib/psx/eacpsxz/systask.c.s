	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\systask.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.section	.bss
	.align	2
systemtasksubs:
	.space	256
	.text
 #NO_APP
	.text
	.align	2
	.globl	addsystemtask
	.align	2
	.globl	delsystemtask
	.align	2
	.globl	systemtask

	.comm	gSysTaskCount,4

	.comm	gSysTaskLastTick,4

	.extern	libticks, 4

	.text
	.def	addsystemtask;	.val	addsystemtask;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	addsystemtask
addsystemtask:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	taskFn;	.val	4;	.scl	17;	.type	0x4;	.endef
	.def	period;	.val	5;	.scl	17;	.type	0x4;	.endef
	.def	delay;	.val	6;	.scl	17;	.type	0x4;	.endef
	move	$9,$4
	li	$3,-1			# 0xffffffff
	move	$4,$0
	move	$10,$3
	lui	$2,%hi(systemtasksubs) # high
	lw	$7,gSysTaskCount
	addiu	$8,$2,%lo(systemtasksubs) # low
	addu	$2,$7,1
	sw	$2,gSysTaskCount
$L5:
	lw	$2,0($8)
	#nop
	beq	$2,$9,$L9
	bne	$2,$0,$L4
	bne	$3,$10,$L4
	beq	$7,$0,$L9
	.set	noreorder
	.set	nomacro
	j	$L4
	addu	$7,$7,-1
	.set	macro
	.set	reorder

$L9:
	move	$3,$4
$L4:
	addu	$4,$4,1
	slt	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$8,$8,16
	.set	macro
	.set	reorder

	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L12
	lui	$2,%hi(systemtasksubs) # high
	.set	macro
	.set	reorder

	addiu	$2,$2,%lo(systemtasksubs) # low
	sll	$3,$3,4
	#.set	volatile
	lw	$4,libticks
	#.set	novolatile
	addu	$3,$3,$2
	sw	$9,0($3)
	sw	$5,4($3)
	sw	$0,12($3)
	addu	$4,$4,$6
	sw	$4,8($3)
$L12:
	lw	$2,gSysTaskCount
	#nop
	addu	$2,$2,-1
	sw	$2,gSysTaskCount
	j	$31

	.loc	1 0
LM1:
	.end	addsystemtask
	.def	delsystemtask;	.val	delsystemtask;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	delsystemtask
delsystemtask:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	fn;	.val	4;	.scl	17;	.type	0x4;	.endef
	move	$3,$0
	lui	$2,%hi(systemtasksubs) # high
	addiu	$6,$2,%lo(systemtasksubs) # low
	move	$5,$6
$L17:
	lw	$2,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L22
	slt	$2,$3,16
	.set	macro
	.set	reorder

	addu	$3,$3,1
	slt	$2,$3,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L17
	addu	$5,$5,16
	.set	macro
	.set	reorder

	slt	$2,$3,16
$L22:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	sll	$2,$3,4
	.set	macro
	.set	reorder

	addu	$3,$2,$6
	lw	$2,0($3)
	#nop
	bne	$2,$4,$L23
	sw	$0,0($3)
$L23:
	j	$31

	.loc	1 0
LM2:
	.end	delsystemtask
	.def	SysTaskSlot;	.scl	10;	.type	0x8;	.size	16;	.endef
	.def	fn;	.val	0;	.scl	8;	.type	0x4;	.endef
	.def	period;	.val	4;	.scl	8;	.type	0x4;	.endef
	.def	deadline;	.val	8;	.scl	8;	.type	0x4;	.endef
	.def	busy;	.val	12;	.scl	8;	.type	0x4;	.endef
	.def	.eos;	.val	16;	.scl	102;	.tag	SysTaskSlot;	.size	16;	.endef
	.def	systemtask;	.val	systemtask;	.scl	2;	.type	0x2e;	.endef
	.text
	.ent	systemtask
systemtask:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.def	arg1;	.val	19;	.scl	17;	.type	0x4;	.endef
	lw	$3,gSysTaskLastTick
	#.set	volatile
	lw	$2,libticks
	#.set	novolatile
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$18,24($sp)
	move	$18,$0
	sw	$31,32($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L25
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	move	$17,$18
	lui	$2,%hi(systemtasksubs) # high
	#.set	volatile
	lw	$3,libticks
	#.set	novolatile
	addiu	$16,$2,%lo(systemtasksubs) # low
	sw	$3,gSysTaskLastTick
	.def	next;	.val	$L26;	.scl	6;	.type	0x0;	.endef
$L26:
	lw	$6,0($16)
	#nop
	beq	$6,$0,$L27
	#.set	volatile
	lw	$2,libticks
	#.set	novolatile
	lw	$3,8($16)
	#nop
	slt	$2,$2,$3
	bne	$2,$0,$L27
	lw	$2,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L27
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$5,$3
	sw	$2,12($16)
	#.set	volatile
	lw	$2,libticks
	#.set	novolatile
	move	$4,$19
	.set	noreorder
	.set	nomacro
	jal	$31,$6
	subu	$5,$2,$5
	.set	macro
	.set	reorder

	#.set	volatile
	lw	$3,libticks
	#.set	novolatile
	lw	$4,4($16)
	or	$18,$18,$2
	sw	$0,12($16)
	addu	$3,$3,$4
	sw	$3,8($16)
$L27:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	addu	$16,$16,16
	.set	macro
	.set	reorder

$L25:
	move	$2,$18
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
LM3:
	.end	systemtask
	.def	gSysTaskCount;	.val	gSysTaskCount;	.scl	2;	.type	0x4;	.endef
	.def	gSysTaskLastTick;	.val	gSysTaskLastTick;	.scl	2;	.type	0x4;	.endef
