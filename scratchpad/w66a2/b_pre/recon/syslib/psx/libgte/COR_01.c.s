	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libgte\\COR_01.c"

 # GNU C 2.7.2.SN32.3.7 Build 0001 [AL 1.1, MM 40] Sony Playstation compiled by CC

 # Cc1 defaults:
 # -mgas -msoft-float

 # Cc1 arguments (-G value = 0, Cpu = 3000, ISA = 1):
 # -quiet -O2 -G0 -mgas -fno-strength-reduce -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	csincos
	.ent	csincos
csincos:
	.frame	$sp,96,$31		# vars= 96, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	subu	$sp,$sp,96
	addu	$8,$0,$0
	addu	$11,$sp,68
	la	$10,H_cor_tbl
	addu	$9,$sp,36
	addu	$7,$sp,$0
	li	$2,0x000009b7		# 2487
	sw	$2,0($sp)
	sw	$0,32($sp)
	sw	$4,64($sp)
$L5:
	lw	$2,64($7)
	#nop
	bltz	$2,$L6
	lw	$2,32($7)
	lw	$3,0($7)
	sra	$2,$2,$8
	subu	$3,$3,$2
	lw	$2,0($7)
	sw	$3,4($7)
	lw	$3,32($7)
	sra	$2,$2,$8
	addu	$3,$3,$2
	sw	$3,0($9)
	lw	$2,64($7)
	lw	$3,0($10)
	.set	noreorder
	.set	nomacro
	j	$L9
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L6:
	lw	$2,32($7)
	lw	$3,0($7)
	sra	$2,$2,$8
	addu	$3,$3,$2
	lw	$2,0($7)
	sw	$3,4($7)
	lw	$3,32($7)
	sra	$2,$2,$8
	subu	$3,$3,$2
	sw	$3,0($9)
	lw	$2,64($7)
	lw	$3,0($10)
	#nop
	addu	$2,$2,$3
$L9:
	sw	$2,0($11)
	addu	$11,$11,4
	addu	$10,$10,4
	addu	$9,$9,4
	addu	$8,$8,1
	slt	$2,$8,6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$7,$7,4
	.set	macro
	.set	reorder

	lw	$3,88($sp)
	lw	$2,56($sp)
	#nop
	mult	$3,$2
	lw	$2,24($sp)
	mflo	$12
	#nop
	#nop
	sra	$3,$12,12
	subu	$2,$2,$3
	sw	$2,0($6)
	lw	$3,88($sp)
	lw	$2,24($sp)
	#nop
	mult	$3,$2
	lw	$2,56($sp)
	mflo	$12
	#nop
	#nop
	sra	$3,$12,12
	addu	$2,$2,$3
	sw	$2,0($5)
	addu	$sp,$sp,96
	j	$31
	.end	csincos
