	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\callback.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.globl	mutexbuf
	.section	.bss
	.align	2
mutexbuf:
	.space	128
	.text
 #NO_APP
	.text
	.align	2
	.globl	allocmutex
	.align	2
	.globl	freemutex

	.text
	.def	allocmutex;	.val	allocmutex;	.scl	2;	.type	0x63;	.endef
	.text
	.ent	allocmutex
allocmutex:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$3,$0
	lui	$2,%hi(mutexbuf) # high
	addiu	$5,$2,%lo(mutexbuf) # low
$L4:
	move	$4,$5
	lh	$2,0($4)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$3,$3,1
	slt	$2,$3,32
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L4
	addu	$5,$4,4
	.set	macro
	.set	reorder

$L3:
	li	$2,32			# 0x00000020
	.set	noreorder
	.set	nomacro
	beq	$3,$2,$L7
	sll	$3,$3,2
	.set	macro
	.set	reorder

	lui	$2,%hi(mutexbuf) # high
	addiu	$2,$2,%lo(mutexbuf) # low
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

$L9:
	.set	noreorder
	.set	nomacro
	j	$L3
	sh	$2,0($5)
	.set	macro
	.set	reorder

$L7:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder


	.loc	1 0
LM1:
	.end	allocmutex
	.def	freemutex;	.val	freemutex;	.scl	2;	.type	0x21;	.endef
	.text
	.ent	freemutex
freemutex:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.def	mutex;	.val	4;	.scl	17;	.type	0x11;	.endef
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,0($4)
	.set	macro
	.set	reorder


	.loc	1 0
LM2:
	.end	freemutex
