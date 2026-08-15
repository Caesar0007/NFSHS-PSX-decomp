	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\timer.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	gettick
	.align	2
	.globl	elapsedticks
	.align	2
	.globl	resettick
	.align	2
	.globl	timedwait

	.comm	gTickSet,4

	.comm	gTickVal,4

	.extern	ticks, 4

	.text
	.def	gettick;	.val	gettick;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	gettick
gettick:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	#.set	volatile
	lw	$2,ticks
	#.set	novolatile
	j	$31

	.loc	1 0
LM1:
	.end	gettick
	.def	elapsedticks;	.val	elapsedticks;	.scl	2;	.type	0x24;	.endef
	.text
	.ent	elapsedticks
elapsedticks:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	lw	$16,gTickVal
	sw	$31,20($sp)
	jal	gettick
	lw	$31,20($sp)
	sw	$2,gTickVal
	subu	$2,$2,$16
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	elapsedticks
	.def	resettick;	.val	resettick;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	resettick
resettick:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	#.set	volatile
	sw	$0,ticks
	#.set	novolatile
	#.set	volatile
	lw	$2,ticks
	#.set	novolatile
	#nop
	sw	$2,gTickVal
	sw	$2,gTickSet
	j	$31

	.loc	1 0
LM3:
	.end	resettick
	.def	timedwait;	.val	timedwait;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	timedwait
timedwait:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.def	n;	.val	16;	.scl	17;	.type	0x4;	.endef
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	gettick
	move	$16,$4
	.set	macro
	.set	reorder

	addu	$16,$2,$16
$L5:
	jal	gettick
	subu	$2,$2,$16
	bgez	$2,$L6
	.set	noreorder
	.set	nomacro
	jal	systemtask
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L5
$L6:
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
LM4:
	.end	timedwait
	.def	gTickSet;	.val	gTickSet;	.scl	2;	.type	0x4;	.endef
	.def	gTickVal;	.val	gTickVal;	.scl	2;	.type	0x4;	.endef
