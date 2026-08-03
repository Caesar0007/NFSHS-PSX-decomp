	.file	1 "b_xmmemcpy.i"
gcc2_compiled.:
__gnu_compiled_c:
	.globl	msg
	.rdata
	.align	2
$LC0:
	.ascii	"hello world\000"
	.sdata
	.align	2
msg:
	.word	$LC0
	.text
	.align	2
	.globl	f2
	.align	2
	.globl	f3

	.comm	gsrc,48

	.comm	gdst,48

	.comm	ge,4

	.comm	arr,400

	.text
	.text
	.ent	f2
f2:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	sw	$17,20($sp)
	move	$17,$5
	lui	$4,%hi(gdst) # high
	addiu	$4,$4,%lo(gdst) # low
	lui	$5,%hi(gsrc) # high
	addiu	$5,$5,%lo(gsrc) # low
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	jal	memcpy
	li	$6,48			# 0x00000030
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$5,$17
	.set	macro
	.set	reorder

	move	$4,$17
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$17,$2
	.set	macro
	.set	reorder

	addu	$17,$17,$2
	lui	$2,%hi(arr) # high
	addiu	$2,$2,%lo(arr) # low
	sll	$16,$16,2
	addu	$16,$16,$2
	lw	$3,0($16)
	lw	$2,ge
	lw	$31,24($sp)
	lw	$16,16($sp)
	addu	$17,$17,$3
	addu	$2,$17,$2
	lw	$17,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	f2
	.text
	.ent	f3
f3:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	move	$7,$0
	.set	noreorder
	.set	nomacro
	blez	$5,$L4
	move	$6,$7
	.set	macro
	.set	reorder

$L6:
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$7,$7,1
	sll	$3,$2,1
	addu	$3,$3,$2
	slt	$2,$7,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	addu	$6,$6,$3
	.set	macro
	.set	reorder

$L4:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	f3
