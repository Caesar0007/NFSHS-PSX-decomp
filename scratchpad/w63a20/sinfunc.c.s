	.file	1 "C:\\Temp\\nfs4-decomp\\recon\\eaclib\\psx\\eacpsxz\\sinfunc.c"
gcc2_compiled.:
__gnu_compiled_c:
 #APP
		.set push
	.set noat
	.set	noreorder
	.set noreorder
	.globl intcos
intcos:
	addiu	$a0,$a0,256
	.globl intsin
intsin:
	lui	$t4,%hi(sintbl)
	addiu	$t4,$t4,%lo(sintbl)
	andi	$t1,$a0,512
	andi	$t2,$a0,256
	bnez	$t1,.L800F1928
	 andi	$t0,$a0,255
	bnez	$t2,.L800F1918
	 sll	$t3,$t0,2
	addu	$t5,$t4,$t3
	lw	$v0,0($t5)
	jr	$ra
	 nop
.L800F1918:
	subu	$t5,$t4,$t3
	lw	$v0,1024($t5)
	jr	$ra
	 nop
.L800F1928:
	bnez	$t2,.L800F1940
	 sll	$t3,$t0,2
	addu	$t5,$t4,$t3
	lw	$v0,0($t5)
	jr	$ra
	 negu	$v0,$v0
.L800F1940:
	subu	$t5,$t4,$t3
	lw	$v0,1024($t5)
	jr	$ra
	 negu	$v0,$v0
	.set pop

		.globl fastintcos
fastintcos = intcos
	.globl fastintsin
fastintsin = intsin
	.type intcos,@function
	.size intcos,4
	.type intsin,@function
	.size intsin,0x68


	.text
