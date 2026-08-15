	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libsn\\READ.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	PCread
	.ent	PCread
PCread:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$20,32($sp)
	addu	$20,$4,$0
	sw	$19,28($sp)
	addu	$19,$5,$0
	sw	$16,16($sp)
	addu	$16,$6,$0
	sw	$18,24($sp)
	addu	$18,$0,$0
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L2
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	li	$22,0x00008000		# 32768
	li	$21,-1			# 0xffffffff
	sltu	$2,$22,$16
$L11:
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L6
	addu	$17,$16,$0
	.set	macro
	.set	reorder

	li	$17,0x00008000		# 32768
$L6:
	addu	$4,$0,$0
	addu	$5,$20,$0
	addu	$6,$17,$0
	.set	noreorder
	.set	nomacro
	jal	_SN_read
	addu	$7,$19,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$21,$L7
	addu	$18,$18,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L10
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L7:
	addu	$19,$19,$2
	subu	$16,$16,$2
	slt	$2,$2,$17
	bne	$2,$0,$L2
	.set	noreorder
	.set	nomacro
	bne	$16,$0,$L11
	sltu	$2,$22,$16
	.set	macro
	.set	reorder

$L2:
	addu	$2,$18,$0
$L10:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	.set	noreorder
	addu	$sp,$sp,48
	j	$31
	nop
	.set	reorder
	.end	PCread
