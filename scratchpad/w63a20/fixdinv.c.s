	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\fixdinv.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl fixedinverse
fixedinverse:
	addiu	$t0,$zero,-1
	sra	$t2,$a0,31
	xor	$t1,$a0,$t2
	subu	$t1,$t1,$t2
	divu	$zero,$t0,$t1
	nop
	sra	$t3,$t1,1
	mflo	$v0
	mfhi	$v1
	sltu	$t4,$t3,$v1
	addu	$v0,$v0,$t4
	xor	$v0,$v0,$t2
	jr	$ra
	 subu	$v0,$v0,$t2
	.set pop

		.globl rinverse
rinverse = fixedinverse
	.type fixedinverse,@function
	.size fixedinverse,0x38


	.text
