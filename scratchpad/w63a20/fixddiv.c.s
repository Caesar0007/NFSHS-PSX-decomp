	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixddiv.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl rdiv
rdiv:
	bgez	$a0,.L800E4410
	 slt	$t0,$a0,$zero
	negu	$a0,$a0
.L800E4410:
	bgez	$a1,.L800E441C
	 slt	$t1,$a1,$zero
	negu	$a1,$a1
.L800E441C:
	divu	$zero,$a0,$a1
	xor	$t0,$t0,$t1
	negu	$t0,$t0
	beqz	$a1,.L800E44A4
	 lui	$t2,1
	ori	$t1,$zero,0x1
	mfhi	$a0
	mflo	$v0
	bltz	$a0,.L800E4474
	 sll	$v0,$v0,16
	sll	$a0,$a0,1
.L800E4448:
	bgez	$a0,.L800E4480
	 sltu	$t3,$a0,$a1
.L800E4450:
	bnez	$t3,.L800E4460
	 srl	$t2,$t2,1
	or	$v0,$v0,$t2
	subu	$a0,$a0,$a1
.L800E4460:
	bne	$t2,$t1,.L800E4448
	 srl	$a1,$a1,1
	xor	$v0,$v0,$t0
	jr	$ra
	 sub	$v0,$v0,$t0
.L800E4474:
	srl	$a1,$a1,1
.L800E4478:
	bltz	$a0,.L800E4450
	 sltu	$t3,$a0,$a1
.L800E4480:
	bnez	$t3,.L800E4490
	 srl	$t2,$t2,1
	or	$v0,$v0,$t2
	subu	$a0,$a0,$a1
.L800E4490:
	bne	$t2,$t1,.L800E4478
	 sll	$a0,$a0,1
	xor	$v0,$v0,$t0
	jr	$ra
	 sub	$v0,$v0,$t0
.L800E44A4:
	jr	$ra
	 or	$v0,$zero,$zero
	.set pop

		.globl fixeddiv
fixeddiv = rdiv
	.type rdiv,@function
	.size rdiv,0xa8


	.text
