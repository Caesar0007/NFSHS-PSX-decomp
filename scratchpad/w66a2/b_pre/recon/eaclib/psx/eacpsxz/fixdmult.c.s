	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdmult.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set noat
	.set	noreorder
	.set noreorder
	.globl rmult
	.globl fixedmult
rmult:
fixedmult:
	.word	0x00850018
	ori	$10,$0,0x8000
	mflo	$8
	mfhi	$9
	addu	$8,$8,$10
	sltu	$10,$8,$10
	addu	$9,$9,$10
	srl	$10,$8,16
	sll	$11,$9,16
	jr	$31
	or	$2,$10,$11
	.set at
	.set reorder


	.text
