	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\addtimer.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	addtimer
	.align	2
	.globl	deltimer

	.comm	gTimerSubs,32

	.text
	.def	addtimer;	.val	addtimer;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	addtimer
addtimer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	fn;	.val	4;	.scl	17;	.type	0x94;	.endef
	move	$5,$0
	lui	$2,%hi(gTimerSubs) # high
	addiu	$3,$2,%lo(gTimerSubs) # low
$L5:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$4,$L14
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$3,$3,4
	.set	macro
	.set	reorder

	move	$5,$0
	lui	$2,%hi(gTimerSubs) # high
	addiu	$3,$2,%lo(gTimerSubs) # low
$L11:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L10
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,0($3)
	.set	macro
	.set	reorder

$L10:
	slt	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L11
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L14:
	j	$31

	.loc	1 0
LM1:
	.end	addtimer
	.def	deltimer;	.val	deltimer;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	deltimer
deltimer:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	fn;	.val	4;	.scl	17;	.type	0x94;	.endef
	move	$5,$0
	lui	$2,%hi(gTimerSubs) # high
	addiu	$3,$2,%lo(gTimerSubs) # low
$L19:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L18
	addu	$5,$5,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($3)
	.set	macro
	.set	reorder

$L18:
	slt	$2,$5,8
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L19
	addu	$3,$3,4
	.set	macro
	.set	reorder

	j	$31

	.loc	1 0
LM2:
	.end	deltimer
	.def	gTimerSubs;	.val	gTimerSubs;	.scl	2;	.dim	8;	.size	32;	.type	0x274;	.endef
