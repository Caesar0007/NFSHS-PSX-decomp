	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libc\\QSORT.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-strength-reduce -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	qsort
	.ent	qsort
qsort:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$21,36($sp)
	addu	$21,$5,$0
	sw	$19,28($sp)
	addu	$19,$6,$0
	sw	$23,44($sp)
	addu	$23,$7,$0
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$18,24($sp)
	addu	$18,$20,$19
	sw	$22,40($sp)
	addu	$22,$0,$0
	sltu	$2,$21,2
	sw	$31,48($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L1
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$2,0x00000002		# 2
	.set	noreorder
	.set	nomacro
	bne	$21,$2,$L3
	srl	$2,$21,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	$31,$23
	addu	$5,$18,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	blez	$2,$L1
	addu	$4,$20,$0
	.set	macro
	.set	reorder

	addu	$5,$18,$0
	.set	noreorder
	.set	nomacro
	jal	_swap
	addu	$6,$19,$0
	.set	macro
	.set	reorder

	j	$L1
$L3:
	mult	$2,$19
	addu	$4,$20,$0
	addu	$6,$19,$0
	addu	$17,$20,$0
	li	$16,0x00000001		# 1
	mflo	$3
	#nop
	.set	noreorder
	.set	nomacro
	jal	_swap
	addu	$5,$20,$3
	.set	macro
	.set	reorder

	sltu	$2,$16,$21
	beq	$2,$0,$L6
$L8:
	addu	$4,$18,$0
	.set	noreorder
	.set	nomacro
	jal	$31,$23
	addu	$5,$20,$0
	.set	macro
	.set	reorder

	bgez	$2,$L9
	addu	$17,$17,$19
	.set	noreorder
	.set	nomacro
	beq	$18,$17,$L9
	addu	$22,$22,1
	.set	macro
	.set	reorder

	addu	$4,$18,$0
	addu	$5,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_swap
	addu	$6,$19,$0
	.set	macro
	.set	reorder

$L9:
	addu	$16,$16,1
	sltu	$2,$16,$21
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L8
	addu	$18,$18,$19
	.set	macro
	.set	reorder

$L6:
	.set	noreorder
	.set	nomacro
	beq	$17,$20,$L12
	addu	$4,$20,$0
	.set	macro
	.set	reorder

	addu	$5,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_swap
	addu	$6,$19,$0
	.set	macro
	.set	reorder

$L12:
	addu	$4,$20,$0
	addu	$5,$22,$0
	addu	$6,$19,$0
	.set	noreorder
	.set	nomacro
	jal	qsort
	addu	$7,$23,$0
	.set	macro
	.set	reorder

	addu	$4,$17,$19
	subu	$5,$21,$22
	addu	$5,$5,-1
	addu	$6,$19,$0
	.set	noreorder
	.set	nomacro
	jal	qsort
	addu	$7,$23,$0
	.set	macro
	.set	reorder

$L1:
	lw	$31,48($sp)
	lw	$23,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,56
	j	$31
	.end	qsort
	.align	2
	.globl	_swap
	.ent	_swap
_swap:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$8,$4,$0
	addu	$9,$5,$0
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L13
	addu	$7,$0,$0
	.set	macro
	.set	reorder

$L15:
	addu	$3,$8,$7
	addu	$4,$9,$7
	lbu	$5,0($3)
	lbu	$2,0($4)
	addu	$7,$7,1
	sb	$2,0($3)
	sltu	$2,$7,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	sb	$5,0($4)
	.set	macro
	.set	reorder

$L13:
	j	$31
	.end	_swap
