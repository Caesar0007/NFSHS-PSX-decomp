	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdinv.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl fixedinverse
fixedinverse:
rinverse:
	addiu	$8,$0,-1
	sra	$10,$4,31
	xor	$9,$4,$10
	subu	$9,$9,$10
	.word	0x0109001b
	nop
	sra	$11,$9,1
	mflo	$2
	mfhi	$3
	sltu	$12,$11,$3
	addu	$2,$2,$12
	xor	$2,$2,$10
	jr	$31
	 subu	$2,$2,$10
	.set at
	.set reorder

		.globl rinverse


	.text
