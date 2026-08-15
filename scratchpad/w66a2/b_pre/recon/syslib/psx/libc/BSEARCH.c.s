	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libc\\BSEARCH.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-schedule-insns -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	bsearch
	.ent	bsearch
bsearch:
	.frame	$sp,56,$31		# vars= 0, regs= 9/0, args= 16, extra= 0
	.mask	0x80ff0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	sw	$23,44($sp)
	lw	$23,72($sp)
	sw	$21,36($sp)
	addu	$21,$4,$0
	sw	$22,40($sp)
	addu	$22,$5,$0
	sw	$19,28($sp)
	addu	$19,$6,$0
	sw	$18,24($sp)
	addu	$18,$0,$0
	sw	$20,32($sp)
	addu	$20,$7,$0
	sw	$31,48($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L2
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	addu	$2,$18,$19
$L12:
	srl	$16,$2,1
	mult	$20,$16
	addu	$5,$21,$0
	mflo	$3
	#nop
	#nop
	addu	$17,$22,$3
	.set	noreorder
	.set	nomacro
	jal	$31,$23
	addu	$4,$17,$0
	.set	macro
	.set	reorder

	bgez	$2,$L6
	.set	noreorder
	.set	nomacro
	j	$L5
	addu	$18,$16,1
	.set	macro
	.set	reorder

$L6:
	.set	noreorder
	.set	nomacro
	bgtz	$2,$L8
	addu	$19,$16,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L11
	addu	$2,$17,$0
	.set	macro
	.set	reorder

$L8:
$L5:
	sltu	$2,$18,$19
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L12
	addu	$2,$18,$19
	.set	macro
	.set	reorder

$L2:
 #APP
 #NO_APP
	addu	$2,$0,$0
$L11:
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
	.end	bsearch
