	.file	1 "C:\\\\Temp\\\\nfs4-decomp\\\\recon\\\\game\\\\common\\\\simplemem.cpp"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.text
	.align	2
	.globl	Alloc__9SimpleMemii
	.align	2
	.globl	FeignAlloc__9SimpleMemi
	.align	2
	.globl	ResizeToFit__9SimpleMem

	.text
	.text
	.ent	Alloc__9SimpleMemii
Alloc__9SimpleMemii:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$5,$5,3
	li	$2,-4			# 0xfffffffc
	and	$5,$5,$2
	lw	$2,8($4)
	#nop
	slt	$2,$2,$5
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L604
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$7,4($4)
	.set	noreorder
	.set	nomacro
	bne	$6,$0,$L602
	addu	$3,$7,$5
	.set	macro
	.set	reorder

	lw	$2,8($4)
	sw	$3,4($4)
	subu	$2,$2,$5
	sw	$2,8($4)
$L602:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$7
	.set	macro
	.set	reorder

$L604:
	j	$31
	.end	Alloc__9SimpleMemii
	.text
	.ent	FeignAlloc__9SimpleMemi
FeignAlloc__9SimpleMemi:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	Alloc__9SimpleMemii
	li	$6,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	FeignAlloc__9SimpleMemi
	.text
	.ent	ResizeToFit__9SimpleMem
ResizeToFit__9SimpleMem:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	lw	$5,4($4)
	lw	$2,0($4)
	sw	$0,4($4)
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	resizememadr
	subu	$5,$5,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	ResizeToFit__9SimpleMem
