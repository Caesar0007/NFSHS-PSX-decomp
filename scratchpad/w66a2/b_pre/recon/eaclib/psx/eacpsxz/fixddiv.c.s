	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixddiv.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl rdiv
rdiv:
fixeddiv:
	bgez	$4,.L800E4410
	 slt	$8,$4,$0
	negu	$4,$4
.L800E4410:
	bgez	$5,.L800E441C
	 slt	$9,$5,$0
	negu	$5,$5
.L800E441C:
	.word	0x0085001b
	xor	$8,$8,$9
	negu	$8,$8
	beqz	$5,.L800E44A4
	 lui	$10,1
	ori	$9,$0,0x1
	mfhi	$4
	mflo	$2
	bltz	$4,.L800E4474
	 sll	$2,$2,16
	sll	$4,$4,1
.L800E4448:
	bgez	$4,.L800E4480
	 sltu	$11,$4,$5
.L800E4450:
	bnez	$11,.L800E4460
	 srl	$10,$10,1
	or	$2,$2,$10
	subu	$4,$4,$5
.L800E4460:
	bne	$10,$9,.L800E4448
	 srl	$5,$5,1
	xor	$2,$2,$8
	jr	$31
	 sub	$2,$2,$8
.L800E4474:
	srl	$5,$5,1
.L800E4478:
	bltz	$4,.L800E4450
	 sltu	$11,$4,$5
.L800E4480:
	bnez	$11,.L800E4490
	 srl	$10,$10,1
	or	$2,$2,$10
	subu	$4,$4,$5
.L800E4490:
	bne	$10,$9,.L800E4478
	 sll	$4,$4,1
	xor	$2,$2,$8
	jr	$31
	 sub	$2,$2,$8
.L800E44A4:
	jr	$31
	 or	$2,$0,$0
	.set at
	.set reorder

		.globl fixeddiv


	.text
