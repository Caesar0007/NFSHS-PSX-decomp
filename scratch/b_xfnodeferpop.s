	.file	1 "b_xfnodeferpop.i"
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
	sw	$17,20($sp)
	move	$17,$4
	sw	$16,16($sp)
	move	$16,$5
	lui	$2,%hi(gdst) # high
	addiu	$3,$2,%lo(gdst) # low
	lui	$2,%hi(gsrc) # high
	addiu	$2,$2,%lo(gsrc) # low
	addu	$4,$2,48
	sw	$31,24($sp)
$L2:
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,8($2)
	lw	$9,12($2)
	sw	$6,0($3)
	sw	$7,4($3)
	sw	$8,8($3)
	sw	$9,12($3)
	addu	$2,$2,16
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L2
	addu	$3,$3,16
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	ext
	move	$16,$2
	.set	macro
	.set	reorder

	addu	$16,$16,$2
	lui	$3,%hi(arr) # high
	addiu	$3,$3,%lo(arr) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$3,0($2)
	lw	$2,ge
	lw	$31,24($sp)
	lw	$17,20($sp)
	addu	$16,$16,$3
	addu	$2,$16,$2
	lw	$16,16($sp)
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
	blez	$5,$L5
	move	$6,$7
	.set	macro
	.set	reorder

$L7:
	lw	$2,0($4)
	addu	$4,$4,4
	addu	$7,$7,1
	sll	$3,$2,1
	addu	$3,$3,$2
	slt	$2,$7,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L7
	addu	$6,$6,$3
	.set	macro
	.set	reorder

$L5:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$6
	.set	macro
	.set	reorder

	.end	f3
